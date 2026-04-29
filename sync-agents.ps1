#Requires -Version 7.3
<#
.SYNOPSIS
    per-project AGENTS.md drift 감지 + 동기화 (v1.22+)

.DESCRIPTION
    프로젝트 루트에서 실행. AGENTS.md를 canonical source로 하여
    CLAUDE.md 등 7개 대상 파일의 SHA-256 drift를 감지/해소한다.
    SymbolicLink / Junction 파일은 자동 skip (canonical 직접 참조).

    전제:
      - 프로젝트 루트에 AGENTS.md 존재
      - PowerShell 7+

    인터페이스:
      - (없음)          warn-and-prompt (비대화형 시 warn + exit 1)
      - -SourceWins     AGENTS.md → 대상 파일 덮어쓰기
      - -Check          drift 감지만, 파일 변경 없음 (drift 시 exit 1)
      - -DryRun         계획 출력, 파일 변경 없음
      - -ListTargets    감지 대상 목록 출력

.EXAMPLE
    pwsh ~/harness-meta/sync-agents.ps1
    pwsh ~/harness-meta/sync-agents.ps1 -SourceWins
    pwsh ~/harness-meta/sync-agents.ps1 -Check
    pwsh ~/harness-meta/sync-agents.ps1 -DryRun
    pwsh ~/harness-meta/sync-agents.ps1 -ListTargets
#>
param(
    [switch]$SourceWins,
    [switch]$Check,
    [switch]$DryRun,
    [switch]$ListTargets
)

$ErrorActionPreference = 'Stop'

function Write-Info ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Ok   ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err  ($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

# ── AGENTS.md 검증 ───────────────────────────────────────────────────────
$Canonical = "AGENTS.md"
if (-not (Test-Path $Canonical)) {
    Write-Err "AGENTS.md not found in current directory ($(Get-Location))"
    Write-Err "Run this script from the project root."
    exit 1
}

# ── 대상 매핑 (AGENTS_MD_STRATEGY.md §3 기반) ──────────────────────────
$AgentMappings = @(
    "CLAUDE.md"
    "GEMINI.md"
    ".github/copilot-instructions.md"
    ".cursor/rules/main.mdc"
    "CONVENTIONS.md"
    ".clinerules/main.md"
    ".roo/rules/main.md"
)

# ── --list-targets ───────────────────────────────────────────────────────
if ($ListTargets) {
    Write-Info "Sync targets for $(Get-Location)/AGENTS.md:"
    foreach ($target in $AgentMappings) {
        if (Test-Path $target) {
            $item = Get-Item $target -Force
            if ($item.LinkType -in @('SymbolicLink', 'Junction')) {
                Write-Host "  $target (symlink/junction — skipped)"
            } else {
                Write-Host "  $target"
            }
        } else {
            Write-Host "  $target (absent)"
        }
    }
    exit 0
}

# ── 비대화형 감지 ────────────────────────────────────────────────────────
$NonInteractive = [Console]::IsInputRedirected -or ($null -ne $env:CI)

# ── SHA-256 헬퍼 ─────────────────────────────────────────────────────────
function Get-FileHashHex ([string]$Path) {
    (Get-FileHash -Path $Path -Algorithm SHA256).Hash.ToLower()
}

# ── drift 감지 ───────────────────────────────────────────────────────────
$CanonicalHash = Get-FileHashHex $Canonical

$Drift = @()
foreach ($target in $AgentMappings) {
    # 파일 없으면 skip (absent = 해당 adapter 미사용)
    if (-not (Test-Path $target)) { continue }
    # SymbolicLink 또는 Junction → canonical 직접 참조, drift 없음
    $item = Get-Item $target -Force
    if ($item.LinkType -in @('SymbolicLink', 'Junction')) { continue }
    $targetHash = Get-FileHashHex $target
    if ($targetHash -ne $CanonicalHash) {
        $Drift += $target
    }
}

# ── drift 없음 ─────────────────────────────────────────────────────────
if ($Drift.Count -eq 0) {
    Write-Ok "All agent files are in sync with AGENTS.md."
    exit 0
}

# ── -Check ──────────────────────────────────────────────────────────────
if ($Check) {
    Write-Warn "Drift detected in $($Drift.Count) file(s):"
    foreach ($t in $Drift) { Write-Host "  $t" }
    exit 1
}

# ── -DryRun ─────────────────────────────────────────────────────────────
if ($DryRun) {
    Write-Info "Drift detected in $($Drift.Count) file(s) (dry-run — no changes):"
    foreach ($t in $Drift) { Write-Host "  $t" }
    exit 0
}

# ── -SourceWins ──────────────────────────────────────────────────────────
if ($SourceWins) {
    foreach ($target in $Drift) {
        $targetDir = Split-Path $target -Parent
        if ($targetDir -and -not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        Copy-Item -Path $Canonical -Destination $target -Force
        Write-Ok "overwritten: $target"
    }
    exit 0
}

# ── warn-and-prompt ──────────────────────────────────────────────────────
if ($NonInteractive) {
    Write-Warn "Drift detected in $($Drift.Count) file(s) (non-interactive: use -SourceWins to sync):"
    foreach ($t in $Drift) { Write-Warn "  drift: $t" }
    exit 1
}

Write-Host "`n[WARN] Drift detected in $($Drift.Count) file(s):" -ForegroundColor Yellow
for ($i = 0; $i -lt $Drift.Count; $i++) {
    Write-Host "  $($i+1). $($Drift[$i])"
}
Write-Host ""

foreach ($target in $Drift) {
    $answer = Read-Host "  Overwrite $target with AGENTS.md? [y/n/q]"
    switch -Regex ($answer.Trim().ToLower()) {
        '^y' {
            $targetDir = Split-Path $target -Parent
            if ($targetDir -and -not (Test-Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }
            Copy-Item -Path $Canonical -Destination $target -Force
            Write-Ok "overwritten: $target"
        }
        '^q' {
            Write-Info "Aborted."
            break
        }
        default {
            Write-Info "skipped: $target"
        }
    }
}

exit 0

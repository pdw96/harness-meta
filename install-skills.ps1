#Requires -Version 7.3
<#
.SYNOPSIS
    harness-meta 글로벌 user-skill 배포 스크립트 (opt-in, symlink 기반).

.DESCRIPTION
    bootstrap/skills/<name>/ → ~/.claude/skills/<name>/ symlink 생성.
    기존 ~/.claude/skills/<name>/ 존재 시 ~/.claude/skills/<name>.bak-<ts>/로 backup.

    전제:
      - $HOME/harness-meta/ clone 또는 $env:HARNESS_META_ROOT 설정
      - PowerShell 7+
      - Windows Developer Mode ON 또는 admin (symlink 권한)

    충돌 정책:
      - 이미 정상 symlink (target == source) → no-op
      - 다른 디렉토리/링크 → backup-<ts>/로 이동 후 symlink (-Force 미지원, 항상 안전)

.PARAMETER SkillName
    설치할 skill 이름. 기본: ai-ready-scorer

.PARAMETER All
    bootstrap/skills/ 하위 모든 디렉토리 install

.PARAMETER List
    install 안 하고 사용 가능 skill 목록만 출력

.PARAMETER DryRun
    실제 동작 없이 계획만 출력

.PARAMETER MetaRoot
    harness-meta repo 루트. 기본값: $HOME/harness-meta 또는 $env:HARNESS_META_ROOT

.EXAMPLE
    pwsh ./install-skills.ps1
    pwsh ./install-skills.ps1 -All
    pwsh ./install-skills.ps1 -List
    pwsh ./install-skills.ps1 ai-ready-scorer -DryRun
#>
param(
    [Parameter(Position=0)]
    [string]$SkillName = "",
    [switch]$All,
    [switch]$List,
    [switch]$DryRun,
    [string]$MetaRoot = $(if ($env:HARNESS_META_ROOT) { $env:HARNESS_META_ROOT } else { Join-Path $HOME 'harness-meta' })
)

$ErrorActionPreference = 'Stop'

function Write-Info ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Ok   ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err  ($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

$SkillsSrc  = Join-Path $MetaRoot 'bootstrap\skills'
$SkillsDest = Join-Path $HOME '.claude\skills'
# backup은 ~/.claude/skills/ 외부에 둠 (내부에 두면 Claude Code가 SKILL.md 자동 인식 → 충돌)
$BackupRoot = Join-Path $HOME '.claude\backups\skills'

if (-not (Test-Path $SkillsSrc)) {
    Write-Err "bootstrap/skills/ not found: $SkillsSrc"
    exit 2
}

if ($List) {
    Write-Info "Available skills in ${SkillsSrc}:"
    Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
        Write-Host "  - $($_.Name)"
    }
    exit 0
}

if (-not (Test-Path $SkillsDest)) {
    New-Item -ItemType Directory -Path $SkillsDest -Force | Out-Null
}
if (-not (Test-Path $BackupRoot)) {
    New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null
}

function Install-OneSkill {
    param([string]$Name)

    $src  = Join-Path $SkillsSrc $Name
    $dest = Join-Path $SkillsDest $Name
    $ts   = Get-Date -Format 'yyyyMMdd-HHmmss'

    if (-not (Test-Path $src)) {
        Write-Err "skill not found: $src"
        return
    }

    # 이미 정상 symlink → no-op
    if (Test-Path $dest) {
        $item = Get-Item -Path $dest -Force
        if ($item.LinkType -eq 'SymbolicLink') {
            $target = $item.Target | Select-Object -First 1
            if ($target -eq $src -or (Resolve-Path -LiteralPath $target -ErrorAction SilentlyContinue).Path -eq $src) {
                Write-Info "${Name}: already symlinked (no-op)"
                return
            }
        }
    }

    if ($DryRun) {
        if (Test-Path $dest) {
            Write-Info "[dry-run] ${Name}: backup $dest -> $BackupRoot\$Name.$ts, then symlink $src -> $dest"
        } else {
            Write-Info "[dry-run] ${Name}: symlink $src -> $dest"
        }
        return
    }

    # backup 분기 (외부 위치)
    $bak = $null
    if (Test-Path $dest) {
        $bak = Join-Path $BackupRoot "$Name.$ts"
        Move-Item -LiteralPath $dest -Destination $bak -Force
        Write-Warn "${Name}: backed up to $bak"
    }

    New-Item -ItemType SymbolicLink -Path $dest -Target $src -Force | Out-Null

    # symlink 정상 검증
    $created = Get-Item -Path $dest -Force
    if ($created.LinkType -ne 'SymbolicLink') {
        Write-Err "${Name}: symlink creation failed (LinkType=$($created.LinkType))"
        # rollback: backup 복원
        if ($bak -and (Test-Path $bak)) {
            Remove-Item -LiteralPath $dest -Recurse -Force -ErrorAction SilentlyContinue
            Move-Item -LiteralPath $bak -Destination $dest -Force
            Write-Warn "${Name}: rolled back from $bak"
        }
        return
    }
    Write-Ok "${Name}: symlinked $src -> $dest (LinkType=SymbolicLink)"
}

if ($All) {
    $found = $false
    Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
        Install-OneSkill -Name $_.Name
        $found = $true
    }
    if (-not $found) {
        Write-Warn "no skills found in $SkillsSrc"
    }
} else {
    $name = if ($SkillName) { $SkillName } else { 'ai-ready-scorer' }
    Install-OneSkill -Name $name
}

Write-Ok "install-skills 완료"

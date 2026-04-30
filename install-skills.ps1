#Requires -Version 7.3
<#
.SYNOPSIS
    harness-meta 글로벌 user-skill 배포 스크립트 (opt-in, symlink 또는 copy 기반).

.DESCRIPTION
    bootstrap/skills/<name>/ → ~/.claude/skills/<name>/ symlink 생성.
    기존 ~/.claude/skills/<name>/ 존재 시 ~/.claude/backups/skills/<name>.<ts>/로 backup.

    symlink 생성 실패 시(Developer Mode OFF 또는 권한 부재) 자동으로 copy mode fallback.
    -CopyMode 플래그로 명시적 copy mode 지정 가능.

    설치 모드는 ~/.claude/skills/.harness-install-mode 에 기록됨 ("symlink" 또는 "copy").

    전제:
      - $HOME/harness-meta/ clone 또는 $env:HARNESS_META_ROOT 설정
      - PowerShell 7+
      - symlink mode: Windows Developer Mode ON 또는 admin (symlink 권한)
      - copy mode: 권한 불필요

    충돌 정책:
      - 이미 정상 symlink (target == source) → no-op
      - 다른 디렉토리/링크 → ~/.claude/backups/skills/<name>.<ts>/로 이동 후 설치

.PARAMETER SkillName
    설치할 skill 이름. 기본: ai-ready-scorer

.PARAMETER All
    bootstrap/skills/ 하위 모든 디렉토리 install

.PARAMETER List
    install 안 하고 사용 가능 skill 목록만 출력

.PARAMETER DryRun
    실제 동작 없이 계획만 출력

.PARAMETER CopyMode
    symlink 대신 디렉토리 복사로 설치. Developer Mode 불필요.

.PARAMETER MetaRoot
    harness-meta repo 루트. 기본값: $HOME/harness-meta 또는 $env:HARNESS_META_ROOT

.PARAMETER Cleanup
    (v1.30+) backup 정리 후 종료 (skill install 안 함). 단일 skill name 명시 시 해당 skill만.

.PARAMETER CleanupAfter
    (v1.30+) install 후 cleanup 1회 수행

.PARAMETER Retain
    (v1.30+) skill별 최근 N개 backup 유지. 기본 3.

.PARAMETER GraceDays
    (v1.30+) D일 미만 mtime backup 보존 (count 초과해도). 기본 7.

.PARAMETER Yes
    (v1.30+) 실 삭제 확인. 없으면 dry-run-equivalent + WARN.

.EXAMPLE
    pwsh ./install-skills.ps1
    pwsh ./install-skills.ps1 -All
    pwsh ./install-skills.ps1 -List
    pwsh ./install-skills.ps1 ai-ready-scorer -DryRun
    pwsh ./install-skills.ps1 -CopyMode
    pwsh ./install-skills.ps1 -All -CopyMode
    pwsh ./install-skills.ps1 -Cleanup                          # 모든 skill backup 정리 (plan only)
    pwsh ./install-skills.ps1 -Cleanup -Yes                     # 실 삭제
    pwsh ./install-skills.ps1 -Cleanup ai-ready-scorer -Retain 1 -Yes
    pwsh ./install-skills.ps1 -CleanupAfter -Yes                # install + cleanup
#>
param(
    [Parameter(Position=0)]
    [string]$SkillName = "",
    [switch]$All,
    [switch]$List,
    [switch]$DryRun,
    [switch]$CopyMode,
    [switch]$Cleanup,
    [switch]$CleanupAfter,
    [switch]$Yes,
    [int]$Retain = 3,
    [int]$GraceDays = 7,
    [string]$MetaRoot = $(if ($env:HARNESS_META_ROOT) { $env:HARNESS_META_ROOT } else { Join-Path $HOME 'harness-meta' })
)

if ($Retain -lt 0)     { Write-Host "[ERR]  -Retain must be >= 0: $Retain" -ForegroundColor Red; exit 2 }
if ($GraceDays -lt 0)  { Write-Host "[ERR]  -GraceDays must be >= 0: $GraceDays" -ForegroundColor Red; exit 2 }

$ErrorActionPreference = 'Stop'

function Write-Info ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Ok   ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err  ($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

$SkillsSrc  = Join-Path $MetaRoot 'bootstrap\skills'
$SkillsDest = Join-Path $HOME '.claude\skills'
# backup은 ~/.claude/skills/ 외부에 둠 (내부에 두면 Claude Code가 SKILL.md 자동 인식 → 충돌)
# v1.30+: env override 지원 (테스트/고급용)
$BackupRoot = if ($env:HARNESS_SKILLS_BACKUP_ROOT) {
    $env:HARNESS_SKILLS_BACKUP_ROOT
} else {
    Join-Path $HOME '.claude\backups\skills'
}
# 설치 모드 파일 (dotfile — Claude Code 스캔 대상 아님)
$ModeFile   = Join-Path $SkillsDest '.harness-install-mode'

if (-not (Test-Path $SkillsSrc)) {
    Write-Err "bootstrap/skills/ not found: $SkillsSrc"
    exit 2
}

if ($List) {
    Write-Info "Available skills in ${SkillsSrc} (v1.36+ 2-tier <category>/<name>):"
    # v1.36: 2단계 카테고리 enumerate (audit/, dev-tools/ 등)
    Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
        $catDir = $_
        # 카테고리 디렉토리는 SKILL.md 없음
        if (Test-Path (Join-Path $catDir.FullName 'SKILL.md')) { return }
        Get-ChildItem -Path $catDir.FullName -Directory -ErrorAction SilentlyContinue | ForEach-Object {
            if (Test-Path (Join-Path $_.FullName 'SKILL.md')) {
                Write-Host "  - $($catDir.Name)/$($_.Name)"
            }
        }
    }
    exit 0
}

# v1.36: 2단계 lookup — legacy `<name>` 입력 시 `bootstrap/skills/*/<name>/`로 자동 prefix
# 0/1/2+ 매치 분기:
#   0 → return $null + WARN
#   1 → return "<category>/<name>"
#   2+ → return $null + WARN list (typosquatting 방어)
# 보안: regex validation + bootstrap/skills/ prefix 강제
function Resolve-SkillName {
    param([string]$SkillInput)

    # 보안 R5/R7 — regex validation (alphanumeric + - + _ only)
    if ($SkillInput -notmatch '^[a-z0-9][a-z0-9_-]*(/[a-z0-9][a-z0-9_-]*)?$') {
        Write-Err "invalid skill name (regex ^[a-z0-9][a-z0-9_-]*(/...)?$): $SkillInput"
        return $null
    }

    # 이미 <category>/<name> 형식이면 정확 path 검증
    if ($SkillInput -match '/') {
        $target = Join-Path $SkillsSrc $SkillInput
        if ((Test-Path $target -PathType Container) -and (Test-Path (Join-Path $target 'SKILL.md'))) {
            return $SkillInput
        }
        Write-Err "skill not found: $target"
        return $null
    }

    # legacy `<name>` — 모든 카테고리 검색
    $matches = @()
    Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
        $catDir = $_
        $candidate = Join-Path $catDir.FullName $SkillInput
        if ((Test-Path $candidate -PathType Container) -and (Test-Path (Join-Path $candidate 'SKILL.md'))) {
            $matches += "$($catDir.Name)/$SkillInput"
        }
    }

    switch ($matches.Count) {
        0 {
            Write-Err "skill '$SkillInput' not found in any category under $SkillsSrc"
            return $null
        }
        1 {
            return $matches[0]
        }
        default {
            Write-Err "skill '$SkillInput' matches multiple categories — specify <category>/<name>:"
            foreach ($m in $matches) {
                Write-Err "  - $m"
            }
            return $null
        }
    }
}

if (-not (Test-Path $SkillsDest)) {
    New-Item -ItemType Directory -Path $SkillsDest -Force | Out-Null
}
if (-not (Test-Path $BackupRoot)) {
    New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null
}

function Install-OneSkill {
    param([string]$Name)

    # v1.36: 2단계 resolve — Name은 `<name>` 또는 `<category>/<name>`
    $resolved = Resolve-SkillName -SkillInput $Name
    if (-not $resolved) {
        return
    }
    # resolved = "<category>/<name>" 형식
    $leafName = ($resolved -split '/')[-1]   # symlink target은 1단계 평탄 (Claude Code SKILL 인식 호환)
    $src  = Join-Path $SkillsSrc $resolved
    $dest = Join-Path $SkillsDest $leafName
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
                Write-Info "${resolved}: already symlinked (no-op)"
                return
            }
        }
    }

    if ($DryRun) {
        $action = if ($CopyMode) { 'copy' } else { 'symlink (fallback: copy)' }
        if (Test-Path $dest) {
            Write-Info "[dry-run] ${resolved}: backup $dest -> $BackupRoot\$leafName.$ts, then $action $src -> $dest"
        } else {
            Write-Info "[dry-run] ${resolved}: $action $src -> $dest"
        }
        return
    }

    # backup 분기 (외부 위치) — $leafName 사용 (slash 회피)
    $bak = $null
    if (Test-Path $dest) {
        $bak = Join-Path $BackupRoot "$leafName.$ts"
        Move-Item -LiteralPath $dest -Destination $bak -Force
        Write-Warn "${resolved}: backed up to $bak"
    }

    if ($CopyMode) {
        # 명시적 copy mode
        Copy-Item -Path $src -Destination $dest -Recurse -Force
        "copy" | Set-Content $ModeFile
        Write-Ok "${resolved}: copied (copy mode) $src -> $dest"
        return
    }

    # symlink 시도 → 실패 시 copy fallback
    try {
        New-Item -ItemType SymbolicLink -Path $dest -Target $src -Force | Out-Null
        # 사후 LinkType 검증
        $created = Get-Item -Path $dest -Force
        if ($created.LinkType -ne 'SymbolicLink') {
            throw "LinkType verification failed: expected SymbolicLink, got $($created.LinkType)"
        }
        "symlink" | Set-Content $ModeFile
        Write-Ok "${resolved}: symlinked $src -> $dest (LinkType=SymbolicLink)"
    } catch {
        Write-Warn "${resolved}: symlink failed — $($_.Exception.Message)"
        Write-Info "${resolved}: falling back to copy mode"
        # symlink 실패 시 잔여물 제거 후 copy
        if (Test-Path $dest) {
            Remove-Item -LiteralPath $dest -Recurse -Force -ErrorAction SilentlyContinue
        }
        try {
            Copy-Item -Path $src -Destination $dest -Recurse -Force
            "copy" | Set-Content $ModeFile
            Write-Ok "${resolved}: copied (copy mode fallback) $src -> $dest"
        } catch {
            Write-Err "${resolved}: copy also failed — $($_.Exception.Message)"
            # rollback: backup 복원
            if ($bak -and (Test-Path $bak)) {
                Move-Item -LiteralPath $bak -Destination $dest -Force
                Write-Warn "${resolved}: rolled back from $bak"
            }
        }
    }
}

# ── cleanup 함수 (v1.30+) ─────────────────────────────────────────────
# distinct skill prefix 추출
function Get-DistinctSkills {
    if (-not (Test-Path $BackupRoot)) { return @() }
    Get-ChildItem -Path $BackupRoot -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^.+\.\d{8}-\d{6}$' } |
        ForEach-Object { $_.Name -replace '\.\d{8}-\d{6}$', '' } |
        Sort-Object -Unique
}

# skill별 cleanup — count + grace 결합
function Invoke-CleanupOne {
    param([string]$Skill)

    if (-not (Test-Path $BackupRoot)) {
        Write-Info "${Skill}: no backups (BackupRoot 부재)"
        return
    }

    # 해당 skill의 backup dir (Name desc = ts desc, lexical)
    $backups = Get-ChildItem -Path $BackupRoot -Directory -ErrorAction SilentlyContinue |
        Where-Object {
            $_.Name -match '^.+\.\d{8}-\d{6}$' -and
            ($_.Name -replace '\.\d{8}-\d{6}$', '') -eq $Skill
        } |
        Sort-Object -Property Name -Descending

    if (-not $backups -or $backups.Count -eq 0) {
        Write-Info "${Skill}: no backups"
        return
    }

    # purge-all guard (R4 / D6)
    if ($Retain -eq 0 -and $GraceDays -eq 0 -and (-not $Yes) -and (-not $DryRun)) {
        Write-Err "${Skill}: destructive purge (-Retain 0 -GraceDays 0) requires -Yes"
        return
    }

    # 분류
    $cutoff = (Get-Date).AddDays(-$GraceDays)
    $toDelete = @()
    $i = 0
    foreach ($b in $backups) {
        if ($i -lt $Retain) {
            $i++
            continue
        }
        # grace 검사 — LastWriteTime이 cutoff 이전 = 정리 대상
        if ($b.LastWriteTime -lt $cutoff) {
            $toDelete += $b
        }
        $i++
    }

    Write-Info "${Skill}: $($backups.Count) backup(s), retain=$Retain grace=${GraceDays}d -> delete $($toDelete.Count)"

    if ($toDelete.Count -eq 0) {
        return
    }

    if ($DryRun -or (-not $Yes)) {
        $note = if ($DryRun) { '[dry-run]' } else { '[plan -- use -Yes to confirm]' }
        foreach ($b in $toDelete) {
            Write-Info "$note would delete: $($b.FullName)"
        }
        if ((-not $Yes) -and (-not $DryRun)) {
            Write-Warn "${Skill}: -Yes not specified, no changes made"
        }
        return
    }

    # 실 삭제
    $deleted = 0
    foreach ($b in $toDelete) {
        # R4-1 path traversal 방어 — BackupRoot prefix 강제
        $resolvedBackupRoot = (Resolve-Path -LiteralPath $BackupRoot).Path
        $resolvedTarget = (Resolve-Path -LiteralPath $b.FullName).Path
        if (-not $resolvedTarget.StartsWith($resolvedBackupRoot)) {
            Write-Err "skip (path traversal guard): $($b.FullName)"
            continue
        }
        try {
            Remove-Item -LiteralPath $b.FullName -Recurse -Force
            $deleted++
            Write-Ok "deleted: $($b.FullName)"
        } catch {
            Write-Err "failed to delete $($b.FullName): $($_.Exception.Message)"
        }
    }
    Write-Ok "${Skill}: cleanup complete ($deleted deleted)"
}

function Invoke-CleanupAll {
    $skills = Get-DistinctSkills
    if (-not $skills -or $skills.Count -eq 0) {
        Write-Info "no backups to cleanup"
        return
    }
    if ($SkillName) {
        Invoke-CleanupOne -Skill $SkillName
    } else {
        foreach ($s in $skills) {
            Invoke-CleanupOne -Skill $s
        }
    }
}

# ── 실행 ───────────────────────────────────────────────────────────────

# -Cleanup 단독: install 안 함, cleanup 후 종료
if ($Cleanup) {
    Invoke-CleanupAll
    Write-Ok "install-skills cleanup 완료"
    exit 0
}

if ($All) {
    # v1.36: 2단계 enumerate — bootstrap/skills/<category>/<name>/SKILL.md
    $found = $false
    Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
        $catDir = $_
        # 카테고리 디렉토리 자체는 SKILL.md 없음
        if (Test-Path (Join-Path $catDir.FullName 'SKILL.md')) { return }
        Get-ChildItem -Path $catDir.FullName -Directory -ErrorAction SilentlyContinue | ForEach-Object {
            if (Test-Path (Join-Path $_.FullName 'SKILL.md')) {
                Install-OneSkill -Name "$($catDir.Name)/$($_.Name)"
                $found = $true
            }
        }
    }
    if (-not $found) {
        Write-Warn "no skills found in $SkillsSrc"
    }
} else {
    $name = if ($SkillName) { $SkillName } else { 'ai-ready-scorer' }
    Install-OneSkill -Name $name
}

# -CleanupAfter: install 후 cleanup 1회
if ($CleanupAfter) {
    Write-Info "running cleanup after install (-CleanupAfter)"
    Invoke-CleanupAll
}

Write-Ok "install-skills 완료"

#Requires -Version 7.3
<#
.SYNOPSIS
    프로젝트 루트에 harness-meta의 _base/.claude/ 템플릿을 복사한다 (Claude Code local).

.DESCRIPTION
    v1.8+ 구조: 하네스 실행 명령(commands/agents/skills/output-styles)은 프로젝트
    local `.claude/`로 배포한다. 본 스크립트가 `bootstrap/templates/_base/.claude/`
    내용을 <ProjectRoot>/.claude/에 복사한다 (symlink 아닌 Copy).

    전제:
      - <ProjectRoot>에 .harness.toml 존재 (하네스 활성 프로젝트)
      - $MetaRoot/bootstrap/templates/_base/.claude/ 존재

    충돌 정책:
      - 기존 .claude/<category>/<file> 존재 시 기본은 중단 + 경고
      - -Force 지정 시 .claude/backup-<ts>/에 이동 후 덮어쓰기

.PARAMETER ProjectRoot
    프로젝트 루트 경로. 기본값: 현재 디렉토리.

.PARAMETER Force
    기존 파일과 충돌 시 backup 후 덮어쓰기.

.PARAMETER MetaRoot
    harness-meta repo 위치. 기본값: $env:HARNESS_META_ROOT 또는 $HOME/harness-meta

.EXAMPLE
    pwsh ~/harness-meta/bootstrap/install-project-claude.ps1

.EXAMPLE
    pwsh ~/harness-meta/bootstrap/install-project-claude.ps1 -ProjectRoot ~/upbit -Force
#>
param(
    [string]$ProjectRoot = (Get-Location).Path,
    [switch]$Force,
    [string]$MetaRoot = $(if ($env:HARNESS_META_ROOT) { $env:HARNESS_META_ROOT } else { Join-Path $HOME 'harness-meta' })
)

$ErrorActionPreference = 'Stop'

function Write-Info ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Ok   ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err  ($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

# 1. ProjectRoot / MetaRoot / 매니페스트 검증
$ProjectRoot = (Resolve-Path $ProjectRoot -ErrorAction Stop).Path
$Manifest = Join-Path $ProjectRoot '.harness.toml'
$BaseTemplate = Join-Path $MetaRoot 'bootstrap/templates/_base/.claude'

if (-not (Test-Path $Manifest)) {
    Write-Err ".harness.toml 미발견: $Manifest"
    Write-Err "하네스 비활성 프로젝트에는 설치하지 않는다. bootstrap 먼저 수행."
    exit 1
}
if (-not (Test-Path $BaseTemplate)) {
    Write-Err "base template 미발견: $BaseTemplate"
    Write-Err "HARNESS_META_ROOT 환경변수 또는 -MetaRoot 인자 확인."
    exit 1
}

Write-Info "ProjectRoot: $ProjectRoot"
Write-Info "MetaRoot:    $MetaRoot"

$ProjectClaude = Join-Path $ProjectRoot '.claude'
if (-not (Test-Path $ProjectClaude)) {
    New-Item -ItemType Directory -Path $ProjectClaude -Force | Out-Null
    Write-Ok "$ProjectClaude 디렉토리 생성"
}

# 2. 카테고리별 충돌 스캔
$categories = @('commands', 'agents', 'skills', 'output-styles')
$conflicts = @()
foreach ($cat in $categories) {
    $srcDir = Join-Path $BaseTemplate $cat
    $dstDir = Join-Path $ProjectClaude $cat
    if (-not (Test-Path $srcDir)) { continue }
    $items = Get-ChildItem -Path $srcDir -Force -ErrorAction SilentlyContinue
    foreach ($it in $items) {
        $dstItem = Join-Path $dstDir $it.Name
        if (Test-Path $dstItem) {
            $conflicts += [pscustomobject]@{ Path = $dstItem; Category = $cat; Name = $it.Name }
        }
    }
}

# 3. 충돌 처리
if ($conflicts.Count -gt 0) {
    if (-not $Force) {
        Write-Err "충돌 발견 ($($conflicts.Count)건). 기존 파일 유지하려면 수동 제거 후 재실행, 덮어쓰려면 -Force."
        foreach ($c in $conflicts) { Write-Err "  - $($c.Path)" }
        exit 1
    }
    $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backupRoot = Join-Path $ProjectClaude "backup-$ts"
    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
    foreach ($c in $conflicts) {
        $catDir = Join-Path $backupRoot $c.Category
        if (-not (Test-Path $catDir)) { New-Item -ItemType Directory -Path $catDir -Force | Out-Null }
        Move-Item -Path $c.Path -Destination (Join-Path $catDir $c.Name) -Force
    }
    Write-Warn "충돌 $($conflicts.Count)건 backup: $backupRoot"
}

# 4. 재귀 복사
$totalCopied = 0
foreach ($cat in $categories) {
    $srcDir = Join-Path $BaseTemplate $cat
    $dstDir = Join-Path $ProjectClaude $cat
    if (-not (Test-Path $srcDir)) { continue }
    if (-not (Test-Path $dstDir)) {
        New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
    }
    $items = Get-ChildItem -Path $srcDir -Force -ErrorAction SilentlyContinue
    foreach ($it in $items) {
        Copy-Item -Path $it.FullName -Destination $dstDir -Recurse -Force
        $totalCopied++
        Write-Ok "copied: $cat/$($it.Name)"
    }
}

Write-Host ""
Write-Ok "완료 — $totalCopied 항목 복사 ($ProjectClaude)"
Write-Host ""
Write-Info "다음 단계:"
Write-Info "  1. Claude Code 세션 재시작 (또는 새 세션으로 $ProjectRoot 진입)"
Write-Info "  2. /config 실행 → Output style → 'Harness Engineer' 선택"
Write-Info "     (output-styles/harness-engineer.md 활성화)"
Write-Info "  3. /harness 입력 → 슬래시 명령 인식 확인"
Write-Info "  4. 프로젝트 repo에 .claude/ 커밋 (team share)"

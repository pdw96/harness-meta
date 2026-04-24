#Requires -Version 7.3
<#
.SYNOPSIS
    harness-meta 글로벌 통합 레이어 설치 스크립트 (symlink 기반).

.DESCRIPTION
    ~/.claude/{commands,agents,skills,output-styles,hooks,statusline}/ 하위에
    harness-meta/claude/ 원본을 가리키는 symlink를 생성한다.
    ~/.claude/settings.json에 statusLine.command + hooks.SessionStart 필드를 추가한다.

    전제:
      - Windows 11 + Developer Mode ON
      - PowerShell 7+
      - 본 스크립트는 harness-meta repo 루트에서 실행 (pwsh ./install.ps1)

    충돌 정책:
      - ~/.claude/ 하위에 같은 이름 파일·링크가 이미 있으면 기본은 중단 + 경고
      - -Force 지정 시 ~/.claude/backup-<timestamp>/에 이동 후 덮어쓰기

    fail-fast + 부분 rollback:
      - 도중 실패하면 이미 만든 symlink를 제거한 뒤 중단

.PARAMETER Force
    동일 이름 파일·링크가 이미 있을 때 백업 후 덮어쓰기.

.PARAMETER MetaRoot
    harness-meta repo 루트 경로. 기본값: $HOME/harness-meta
    환경변수 HARNESS_META_ROOT가 설정되어 있으면 그 값이 기본값.

.EXAMPLE
    pwsh ./install.ps1

.EXAMPLE
    pwsh ./install.ps1 -Force

.EXAMPLE
    pwsh ./install.ps1 -MetaRoot D:\harness-meta
#>
param(
    [switch]$Force,
    [string]$MetaRoot = $(if ($env:HARNESS_META_ROOT) { $env:HARNESS_META_ROOT } else { Join-Path $HOME 'harness-meta' })
)

$ErrorActionPreference = 'Stop'

# ─── 공통 유틸 ─────────────────────────────────────────────────────────

function Write-Info    ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Ok      ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn    ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err     ($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

# rollback 대상 (성공적으로 만든 symlink)
$script:CreatedLinks = @()
# 백업 이동 대상 (원상복구용)
$script:Backups = @()
# settings.json backup path (원본 복원용)
$script:SettingsBackup = $null

function Invoke-Rollback {
    Write-Warn "Rolling back..."
    foreach ($link in $script:CreatedLinks) {
        if (Test-Path $link) {
            # -Recurse 금지: 디렉토리 symlink도 -Force만으로 안전 제거 (타깃 보존)
            try { Remove-Item $link -Force } catch { }
        }
    }
    foreach ($b in $script:Backups) {
        if (Test-Path $b.Backup) {
            try { Move-Item -Path $b.Backup -Destination $b.Original -Force } catch { }
        }
    }
    if ($script:SettingsBackup -and (Test-Path $script:SettingsBackup)) {
        $origSettings = Join-Path $HOME '.claude' 'settings.json'
        try { Move-Item -Path $script:SettingsBackup -Destination $origSettings -Force } catch { }
    }
}

# ─── Prechecks ────────────────────────────────────────────────────────

Write-Info "harness-meta install starting (MetaRoot=$MetaRoot, Force=$Force)"

# 1. Developer Mode
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
$devMode = (Get-ItemProperty -Path $regPath -Name AllowDevelopmentWithoutDevLicense -ErrorAction SilentlyContinue).AllowDevelopmentWithoutDevLicense
if ($devMode -ne 1) {
    Write-Err "Developer Mode가 꺼져 있습니다. 설정 → 시스템 → 개발자용 → 개발자 모드 ON."
    Write-Err "또는 관리자 PowerShell에서:"
    Write-Err '  reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v AllowDevelopmentWithoutDevLicense /d 1'
    exit 1
}
Write-Ok "Developer Mode ON"

# 2. MetaRoot 검증
if (-not (Test-Path $MetaRoot)) {
    Write-Err "MetaRoot 디렉토리가 없습니다: $MetaRoot"
    exit 1
}
foreach ($sub in @('claude/commands', 'claude/agents', 'claude/skills', 'claude/output-styles', 'claude/hooks', 'claude/statusline')) {
    $p = Join-Path $MetaRoot $sub
    if (-not (Test-Path $p)) {
        Write-Err "MetaRoot 하위 필수 디렉토리 누락: $p"
        exit 1
    }
}
Write-Ok "MetaRoot 구조 유효: $MetaRoot"

# 3. Git Bash 검증 (hook에서 shell=bash 사용)
$bash = Get-Command bash -ErrorAction SilentlyContinue
if (-not $bash) {
    Write-Err "bash가 PATH에 없습니다. Git for Windows 설치 필요 (Git Bash 동반)."
    exit 1
}
Write-Ok "bash 발견: $($bash.Source)"

# 4. Python3 검증 (statusline + session-init 내부가 python3 명시 호출)
$py3 = Get-Command python3 -ErrorAction SilentlyContinue
if (-not $py3) {
    Write-Err "python3이 PATH에 없습니다. hook/statusline이 'python3' 명령으로 호출하므로 필수."
    Write-Err "조치:"
    Write-Err "  (a) Python 설치: winget install Python.Python.3.12"
    Write-Err "  (b) Git Bash ~/.bashrc 또는 ~/.bash_profile에 'alias python3=python' 추가"
    Write-Err "  (c) PATH에 python3 심볼릭 링크 추가"
    exit 1
}
Write-Ok "python3 발견: $($py3.Source)"

# ─── 설치 대상 매핑 ──────────────────────────────────────────────────

$ClaudeDir = Join-Path $HOME '.claude'
if (-not (Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
    Write-Ok "~/.claude 디렉토리 생성"
}

# 카테고리별 처리 방식:
#   file    : 개별 *.md 파일 symlink
#   dir     : 디렉토리 단위 symlink (skills는 각 skill 디렉토리 통째)
$categories = @(
    @{ name = 'commands';      type = 'file'; pattern = 'harness*.md' }
    @{ name = 'agents';        type = 'file'; pattern = 'harness-*.md' }
    @{ name = 'skills';        type = 'dir';  pattern = 'harness-*' }
    @{ name = 'output-styles'; type = 'file'; pattern = 'harness-*.md' }
    @{ name = 'hooks';         type = 'file'; pattern = 'session-init.sh' }
    @{ name = 'statusline';    type = 'file'; pattern = 'statusline.sh' }
)

# ─── 충돌 스캔 ────────────────────────────────────────────────────────

$conflicts = @()
foreach ($cat in $categories) {
    $src = Join-Path $MetaRoot 'claude' $cat.name
    $dst = Join-Path $ClaudeDir $cat.name

    if (-not (Test-Path $dst)) { continue }

    if ($cat.type -eq 'file') {
        $items = Get-ChildItem -Path $src -Filter $cat.pattern -File -ErrorAction SilentlyContinue
    } else {
        $items = Get-ChildItem -Path $src -Filter $cat.pattern -Directory -ErrorAction SilentlyContinue
    }
    foreach ($item in $items) {
        $dstItem = Join-Path $dst $item.Name
        if (Test-Path $dstItem) {
            # 이미 우리가 만든 symlink (올바른 타깃)면 skip
            $existing = Get-Item $dstItem -Force
            if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
                if ($existing.Target -eq $item.FullName) {
                    continue  # 동일 symlink — 재설치 무관
                }
            }
            # 카테고리 정보 동반하여 backup 경로 조립 시 활용
            $conflicts += [pscustomobject]@{ Path = $dstItem; Category = $cat.name }
        }
    }
}

if ($conflicts.Count -gt 0) {
    if (-not $Force) {
        Write-Err "충돌 발견 ($($conflicts.Count)건). 기존 항목 유지하려면 수동 제거 후 재실행, 백업 후 덮어쓰려면 -Force."
        foreach ($c in $conflicts) { Write-Err "  - $($c.Path)" }
        exit 1
    }
    $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backupRoot = Join-Path $ClaudeDir "backup-$ts"
    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
    foreach ($c in $conflicts) {
        # backup/<timestamp>/<category>/<filename> — 카테고리 간 동명 파일 충돌 방지
        $catDir = Join-Path $backupRoot $c.Category
        if (-not (Test-Path $catDir)) {
            New-Item -ItemType Directory -Path $catDir -Force | Out-Null
        }
        $target = Join-Path $catDir (Split-Path $c.Path -Leaf)
        Move-Item -Path $c.Path -Destination $target -Force
        $script:Backups += [pscustomobject]@{ Original = $c.Path; Backup = $target }
    }
    Write-Warn "충돌 $($conflicts.Count)건 백업 이동: $backupRoot"
}

# ─── Symlink 생성 ─────────────────────────────────────────────────────

try {
    foreach ($cat in $categories) {
        $src = Join-Path $MetaRoot 'claude' $cat.name
        $dst = Join-Path $ClaudeDir $cat.name

        if (-not (Test-Path $dst)) {
            New-Item -ItemType Directory -Path $dst -Force | Out-Null
        }

        if ($cat.type -eq 'file') {
            $items = Get-ChildItem -Path $src -Filter $cat.pattern -File
            foreach ($item in $items) {
                $linkPath = Join-Path $dst $item.Name
                if (Test-Path $linkPath) { continue }  # 이미 동일 symlink
                New-Item -ItemType SymbolicLink -Path $linkPath -Target $item.FullName | Out-Null
                $script:CreatedLinks += $linkPath
                Write-Ok "symlink: $($cat.name)/$($item.Name)"
            }
        } else {
            $items = Get-ChildItem -Path $src -Filter $cat.pattern -Directory
            foreach ($item in $items) {
                $linkPath = Join-Path $dst $item.Name
                if (Test-Path $linkPath) { continue }
                New-Item -ItemType SymbolicLink -Path $linkPath -Target $item.FullName | Out-Null
                $script:CreatedLinks += $linkPath
                Write-Ok "symlink(dir): $($cat.name)/$($item.Name)"
            }
        }
    }

    # ─── settings.json merge ────────────────────────────────────────

    $settingsPath = Join-Path $ClaudeDir 'settings.json'
    $settings = $null
    $existingSettings = $false

    if (Test-Path $settingsPath) {
        $existingSettings = $true
        $backupPath = "$settingsPath.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Copy-Item -Path $settingsPath -Destination $backupPath
        $script:SettingsBackup = $backupPath
        Write-Info "기존 settings.json 백업: $backupPath"
        $settings = Get-Content -Path $settingsPath -Raw | ConvertFrom-Json -AsHashtable
    } else {
        $settings = @{}
    }

    # statusLine 필드 충돌 체크
    if ($settings.ContainsKey('statusLine')) {
        $existing = $settings.statusLine
        $desired = '$HOME/.claude/statusline/statusline.sh'
        if ($existing.command -ne $desired) {
            if (-not $Force) {
                Write-Err "settings.json에 이미 statusLine.command 존재: $($existing.command)"
                Write-Err "글로벌 값으로 교체하려면 -Force"
                throw "settings.json statusLine conflict"
            }
            Write-Warn "statusLine.command 덮어쓰기 (기존: $($existing.command))"
        }
    }

    $settings.statusLine = @{
        type = 'command'
        command = '$HOME/.claude/statusline/statusline.sh'
    }

    # hooks.SessionStart 필드 처리
    if (-not $settings.ContainsKey('hooks')) { $settings.hooks = @{} }
    if ($settings.hooks.ContainsKey('SessionStart')) {
        if (-not $Force) {
            Write-Err "settings.json에 이미 hooks.SessionStart 존재. 글로벌 hook으로 교체하려면 -Force"
            throw "settings.json hooks.SessionStart conflict"
        }
        Write-Warn "hooks.SessionStart 덮어쓰기"
    }

    $settings.hooks.SessionStart = @(
        @{
            matcher = 'startup'
            hooks = @(
                @{
                    type = 'command'
                    command = '$HOME/.claude/hooks/session-init.sh'
                    shell = 'bash'
                    timeout = 10
                }
            )
        }
    )

    $json = $settings | ConvertTo-Json -Depth 10
    # utf8NoBOM 명시: Claude Code JSON 파서의 BOM 호환성 문제 회피
    Set-Content -Path $settingsPath -Value $json -Encoding utf8NoBOM
    Write-Ok "settings.json 저장 (statusLine + hooks.SessionStart)"

    # ─── 검증 ────────────────────────────────────────────────────────

    Write-Info "symlink 속성 검증 중..."
    $verifyFail = 0
    foreach ($link in $script:CreatedLinks) {
        $item = Get-Item $link -Force
        if (-not ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            Write-Err "symlink 아님: $link"
            $verifyFail++
        }
    }
    if ($verifyFail -gt 0) {
        throw "symlink 검증 실패 ($verifyFail건)"
    }
    Write-Ok "symlink 검증 통과 ($($script:CreatedLinks.Count)건)"

    Write-Host ""
    Write-Ok "설치 완료."
    Write-Info "요약:"
    Write-Info "  symlinks: $($script:CreatedLinks.Count)"
    Write-Info "  backups : $($script:Backups.Count) + settings.json.bak"
    Write-Info "  settings.json: $(if ($existingSettings) { '갱신' } else { '신규' })"
    Write-Info ""
    Write-Info "다음 단계:"
    Write-Info "  1. 기존 Claude Code 세션 종료 후 새 세션으로 upbit 루트 진입"
    Write-Info "  2. 'What skills are available?' 입력 → harness-* 목록 확인"
    Write-Info "  3. statusline에 [harness] 프로젝트 상태 표시 확인"
    Write-Info "  4. 동작 OK면 upbit commit B (.claude/harness-* 로컬 제거)"

} catch {
    Write-Err "설치 실패: $_"
    Invoke-Rollback
    exit 1
}

#Requires -Version 7.3
<#
.SYNOPSIS
    harness-meta 설치 후 자가 검증 스크립트 (read-only).

.DESCRIPTION
    Z/A/B/C/D/E/F/G 8 단계 29 자동화 체크 + 수동 체크리스트 출력.

        Z : 플랫폼 전제        (IsWindows, PS 버전, MetaRoot 정규화)
        A : 환경 전제          (Dev Mode, MetaRoot 구조, bash/python3)
        B : Symlink 무결성     (17 예상 · LinkType=SymbolicLink · Target · MetaRoot 하위 · SKILL.md)
        C : settings.json      (BOM 부재 · JSON 파싱 · statusLine · hooks.SessionStart 만)
        D : Hook 스모크        (no-manifest / F1 / F2)
        E : Statusline 스모크  (no-manifest / F1 / F2)
        F : 정보성             (~/.claude/backup-<ts>/ 열거)
        G : Runtime-only 체크리스트 (Claude Code 세션 내 수동 확인)

    실패 시 exit 1. 전부 PASS → exit 0.

    "우리 필드만 검증" 원칙: settings.json의 permissions/model/hooks.UserPromptSubmit 등은 무시.

.PARAMETER MetaRoot
    harness-meta repo 루트. 기본값: $env:HARNESS_META_ROOT or $HOME/harness-meta.

.PARAMETER Timeout
    Hook/statusline 실행 최대 대기(초). 기본 30.

.EXAMPLE
    pwsh ./verify.ps1

.EXAMPLE
    pwsh ./verify.ps1 -MetaRoot D:\harness-meta -Timeout 60
#>
param(
    [string]$MetaRoot = $(if ($env:HARNESS_META_ROOT) { $env:HARNESS_META_ROOT } else { Join-Path $HOME 'harness-meta' }),
    [int]$Timeout = 30
)

$ErrorActionPreference = 'Stop'

# 공유 함수
. (Join-Path $PSScriptRoot 'verify-lib.ps1')

function Write-Info ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Ok   ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err  ($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

$script:Pass = 0
$script:Fail = 0
$script:Warn = 0

function Check-Ok   ($id, $msg) { Write-Ok   "$id $msg"; $script:Pass++ }
function Check-Fail ($id, $msg) { Write-Err  "$id $msg"; $script:Fail++ }
function Check-Warn ($id, $msg) { Write-Warn "$id $msg"; $script:Warn++ }

Write-Info "harness-meta verify 시작 (MetaRoot=$MetaRoot, Timeout=${Timeout}s)"
Write-Host ""

# ═══ Z. 플랫폼 전제 ══════════════════════════════════════════════════
Write-Host "== Z. 플랫폼 전제 ==" -ForegroundColor Magenta

if (-not $IsWindows) {
    Check-Fail "Z1" "Windows 아님 (verify.ps1는 Windows 전용 — macOS/Linux는 후속 세션 후보)"
    Write-Host ""
    Write-Err "플랫폼 전제 실패로 조기 종료."
    exit 1
} else {
    Check-Ok "Z1" "Windows 감지 ($([Environment]::OSVersion.VersionString))"
}

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Check-Fail "Z2" "PowerShell < 7 (#Requires가 차단했어야 함 — 이상)"
    exit 1
} else {
    Check-Ok "Z2" "PowerShell $($PSVersionTable.PSVersion)"
}

if (-not (Test-Path $MetaRoot)) {
    Check-Fail "Z3" "MetaRoot 디렉토리 없음: $MetaRoot"
    Write-Host ""
    exit 1
}
$MetaRoot = (Resolve-Path $MetaRoot).Path
Check-Ok "Z3" "MetaRoot 정규화 완료: $MetaRoot"

Write-Host ""

# ═══ A. 환경 전제 ════════════════════════════════════════════════════
Write-Host "== A. 환경 전제 ==" -ForegroundColor Magenta

$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
$devMode = (Get-ItemProperty -Path $regPath -Name AllowDevelopmentWithoutDevLicense -ErrorAction SilentlyContinue).AllowDevelopmentWithoutDevLicense
if ($devMode -ne 1) {
    Check-Fail "A1" "Developer Mode OFF (HKLM AllowDevelopmentWithoutDevLicense != 1)"
} else {
    Check-Ok "A1" "Developer Mode ON"
}

$structOk = $true
$missing = @()
foreach ($sub in @('claude/commands', 'claude/agents', 'claude/skills', 'claude/output-styles', 'claude/hooks', 'claude/statusline')) {
    if (-not (Test-Path (Join-Path $MetaRoot $sub))) { $structOk = $false; $missing += $sub }
}
if ($structOk) {
    Check-Ok "A2" "MetaRoot 하위 6 카테고리 구조 유효"
} else {
    Check-Fail "A2" "MetaRoot 하위 누락: $($missing -join ', ')"
}

# A3a: Git Bash 명시 우선 탐지 (Windows `bash.exe`는 WSL bash로 PATH 우선 매핑될 수 있음 —
# WSL bash는 Windows 경로 C:/... 를 해석 못 하여 hook/statusline 실행 실패).
$GitBashCandidates = @(
    "$env:ProgramFiles\Git\bin\bash.exe"
    "${env:ProgramFiles(x86)}\Git\bin\bash.exe"
    "$env:LOCALAPPDATA\Programs\Git\bin\bash.exe"
)
$BashExe = $null
foreach ($c in $GitBashCandidates) {
    if ($c -and (Test-Path $c)) { $BashExe = $c; break }
}
if (-not $BashExe) {
    $fallback = Get-Command bash -ErrorAction SilentlyContinue
    if ($fallback) { $BashExe = $fallback.Source }
}
if ($BashExe) {
    Check-Ok "A3a" "bash: $BashExe"
    $script:BashExe = $BashExe
} else {
    Check-Fail "A3a" "bash 탐지 실패 — Git for Windows 필요"
    $script:BashExe = $null
}

# A3b: python3은 더 이상 hook/statusline이 요구하지 않음 (v1.6+). 단 프로젝트가
# statusline_cmd에 python3을 쓸 수 있으므로 info 수준으로만 표시.
$py3 = Get-Command python3 -ErrorAction SilentlyContinue
if ($py3) {
    Check-Ok "A3b" "python3 (optional): $($py3.Source)"
} else {
    Check-Ok "A3b" "python3 (optional) 부재 — v1.6+ hook/statusline은 bash-only. 프로젝트 statusline_cmd에 python3 사용 시에만 필요"
}

Write-Host ""

# ═══ B. Symlink 무결성 ════════════════════════════════════════════════
Write-Host "== B. Symlink 무결성 ==" -ForegroundColor Magenta

$ClaudeDir = Join-Path $HOME '.claude'

$categories = @(
    @{ name = 'commands';      type = 'file'; pattern = 'harness*.md' }
    @{ name = 'agents';        type = 'file'; pattern = 'harness-*.md' }
    @{ name = 'skills';        type = 'dir';  pattern = 'harness-*' }
    @{ name = 'output-styles'; type = 'file'; pattern = 'harness-*.md' }
    @{ name = 'hooks';         type = 'file'; pattern = 'session-init.sh' }
    @{ name = 'statusline';    type = 'file'; pattern = 'statusline.sh' }
)

# B1. ~/.claude 6 카테고리 디렉토리 존재
$b1Miss = @()
foreach ($cat in $categories) {
    if (-not (Test-Path (Join-Path $ClaudeDir $cat.name))) { $b1Miss += $cat.name }
}
if ($b1Miss.Count -eq 0) {
    Check-Ok "B1" "~/.claude/ 6 카테고리 존재"
} else {
    Check-Fail "B1" "~/.claude/ 누락 카테고리: $($b1Miss -join ', ')"
}

# B2. 기대 파일 동적 enumerate
$expected = @()
foreach ($cat in $categories) {
    $src = Join-Path $MetaRoot 'claude' $cat.name
    if (-not (Test-Path $src)) { continue }
    if ($cat.type -eq 'file') {
        $items = Get-ChildItem -Path $src -Filter $cat.pattern -File -ErrorAction SilentlyContinue
    } else {
        $items = Get-ChildItem -Path $src -Filter $cat.pattern -Directory -ErrorAction SilentlyContinue
    }
    foreach ($it in $items) {
        $expected += [pscustomobject]@{
            Category = $cat.name
            Name = $it.Name
            Src = $it.FullName
            Dst = Join-Path $ClaudeDir $cat.name $it.Name
            Type = $cat.type
        }
    }
}
$byCat = $expected | Group-Object Category | ForEach-Object { "$($_.Name)×$($_.Count)" }
Check-Ok "B2" "기대 파일 $($expected.Count)개 ($($byCat -join ' '))"

# B3. 1:1 대응 — partial install 감지
$b3Missing = $expected | Where-Object { -not (Test-Path $_.Dst) }
if ($b3Missing.Count -eq 0) {
    Check-Ok "B3" "1:1 대응 완료 (누락 0건)"
} else {
    Check-Fail "B3" "누락 $($b3Missing.Count)건: $($b3Missing | ForEach-Object { "$($_.Category)/$($_.Name)" } | Join-String -Separator ', ')"
}

# B4–B6. LinkType + Target + MetaRoot 하위 (Test-SymlinkIntegrity 재사용)
$b4Bad = @(); $b5Bad = @(); $b6Bad = @()
foreach ($e in $expected) {
    if (-not (Test-Path $e.Dst)) { continue }  # B3에서 이미 카운트
    $chk = Test-SymlinkIntegrity -Path $e.Dst -MetaRoot $MetaRoot
    if (-not $chk.Ok) {
        if ($chk.Reason -match 'LinkType') { $b4Bad += "$($e.Category)/$($e.Name): $($chk.Reason)" }
        elseif ($chk.Reason -match 'target 실존') { $b5Bad += "$($e.Category)/$($e.Name): $($chk.Reason)" }
        elseif ($chk.Reason -match 'MetaRoot 밖') { $b6Bad += "$($e.Category)/$($e.Name): $($chk.Reason)" }
        else { $b5Bad += "$($e.Category)/$($e.Name): $($chk.Reason)" }
    }
}
if ($b4Bad.Count -eq 0) { Check-Ok "B4" "LinkType=SymbolicLink 전부 확인" }
else { foreach ($m in $b4Bad) { Check-Fail "B4" $m } }

if ($b5Bad.Count -eq 0) { Check-Ok "B5" "Target 실존 전부 확인" }
else { foreach ($m in $b5Bad) { Check-Fail "B5" $m } }

if ($b6Bad.Count -eq 0) { Check-Ok "B6" "Target 모두 MetaRoot 하위" }
else { foreach ($m in $b6Bad) { Check-Fail "B6" $m } }

# B7. skill 디렉토리 내부 SKILL.md
$skillExpected = $expected | Where-Object { $_.Category -eq 'skills' }
$b7Miss = @()
foreach ($s in $skillExpected) {
    $skillMd = Join-Path $s.Src 'SKILL.md'
    if (-not (Test-Path $skillMd)) { $b7Miss += $s.Name }
}
if ($b7Miss.Count -eq 0) {
    Check-Ok "B7" "SKILL.md 존재 $($skillExpected.Count)/$($skillExpected.Count) skills"
} else {
    Check-Fail "B7" "SKILL.md 누락 skills: $($b7Miss -join ', ')"
}

Write-Host ""

# ═══ C. settings.json ════════════════════════════════════════════════
Write-Host "== C. settings.json ==" -ForegroundColor Magenta

$settingsPath = Join-Path $ClaudeDir 'settings.json'
$cAbort = $false

# C0 BOM 부재
if (-not (Test-Path $settingsPath)) {
    Check-Fail "C0" "settings.json 부재: $settingsPath"
    $cAbort = $true
} else {
    $bytes = [IO.File]::ReadAllBytes($settingsPath) | Select-Object -First 3
    if ($bytes.Count -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        Check-Fail "C0" "settings.json에 UTF-8 BOM 검출 (Claude Code JSON 파서 호환성 ↓)"
    } else {
        Check-Ok "C0" "UTF-8 no BOM"
    }
}

# C1 JSON parse
$settings = $null
if (-not $cAbort) {
    try {
        $raw = Get-Content -Path $settingsPath -Raw
        $settings = $raw | ConvertFrom-Json -AsHashtable
        Check-Ok "C1" "JSON 파싱 성공"
    } catch {
        Check-Fail "C1" "JSON 파싱 실패: $_"
        $cAbort = $true
    }
}

if (-not $cAbort -and $settings) {
    # C2 statusLine.type
    if ($settings.ContainsKey('statusLine') -and $settings.statusLine.type -eq 'command') {
        Check-Ok "C2" "statusLine.type == 'command'"
    } else {
        Check-Fail "C2" "statusLine.type != 'command' (실제: '$($settings.statusLine.type)')"
    }

    # C3 statusLine.command
    $expCmd = '$HOME/.claude/statusline/statusline.sh'
    if ($settings.statusLine.command -eq $expCmd) {
        Check-Ok "C3" "statusLine.command literal 일치"
    } else {
        Check-Fail "C3" "statusLine.command != '$expCmd' (실제: '$($settings.statusLine.command)')"
    }

    # C4 hooks.SessionStart 배열
    if (-not $settings.ContainsKey('hooks') -or -not $settings.hooks.ContainsKey('SessionStart')) {
        Check-Fail "C4" "hooks.SessionStart 부재"
        $cAbort = $true
    } else {
        $ss = @($settings.hooks.SessionStart)
        if ($ss.Count -eq 1) {
            Check-Ok "C4" "hooks.SessionStart 배열 길이 1"
        } elseif ($ss.Count -gt 1) {
            Check-Warn "C4" "hooks.SessionStart 배열 길이 $($ss.Count) (다른 SessionStart hook과 공존 — install.ps1은 첫 원소만 관리)"
        } else {
            Check-Fail "C4" "hooks.SessionStart 배열 빈 상태"
            $cAbort = $true
        }
    }

    if (-not $cAbort) {
        $ssFirst = @($settings.hooks.SessionStart)[0]

        # C5 matcher
        if ($ssFirst.matcher -eq 'startup') {
            Check-Ok "C5" "matcher == 'startup'"
        } else {
            Check-Fail "C5" "matcher != 'startup' (실제: '$($ssFirst.matcher)')"
        }

        if (-not $ssFirst.hooks -or @($ssFirst.hooks).Count -eq 0) {
            Check-Fail "C6" "hooks[] 배열 빈 상태"
        } else {
            $h = @($ssFirst.hooks)[0]

            if ($h.type -eq 'command') { Check-Ok "C6" "hooks[0].type == 'command'" }
            else { Check-Fail "C6" "hooks[0].type != 'command' (실제: '$($h.type)')" }

            $expHook = '$HOME/.claude/hooks/session-init.sh'
            if ($h.command -eq $expHook) { Check-Ok "C7" "hooks[0].command literal 일치" }
            else { Check-Fail "C7" "hooks[0].command != '$expHook' (실제: '$($h.command)')" }

            if ($h.shell -eq 'bash') { Check-Ok "C8" "hooks[0].shell == 'bash'" }
            else { Check-Fail "C8" "hooks[0].shell != 'bash' (실제: '$($h.shell)')" }

            if ($h.timeout -eq 10) { Check-Ok "C9" "hooks[0].timeout == 10" }
            else { Check-Fail "C9" "hooks[0].timeout != 10 (실제: '$($h.timeout)')" }
        }
    }
}

Write-Host ""

# ═══ D/E Fixture 경로 준비 ═══════════════════════════════════════════
$fixtureRoot = Join-Path $MetaRoot 'tests' 'fixtures'
$F1 = Join-Path $fixtureRoot 'sample-project'
$F2 = Join-Path $fixtureRoot 'empty-phases'
$F1_fwd = $F1 -replace '\\','/'
$F2_fwd = $F2 -replace '\\','/'

# no-manifest 용 임시 디렉토리
$NoManifest = Join-Path ([IO.Path]::GetTempPath()) "harness-verify-nomanifest-$([guid]::NewGuid().ToString('N').Substring(0,8))"
New-Item -ItemType Directory -Path $NoManifest -Force | Out-Null
$NoManifest_fwd = $NoManifest -replace '\\','/'

$hookScript = Join-Path $MetaRoot 'claude' 'hooks' 'session-init.sh'
$hookScript_fwd = $hookScript -replace '\\','/'
$slScript = Join-Path $MetaRoot 'claude' 'statusline' 'statusline.sh'
$slScript_fwd = $slScript -replace '\\','/'

function Invoke-Bash {
    param([string]$ScriptFwdPath, [string]$ProjectFwdPath)
    $stdoutFile = [IO.Path]::GetTempFileName()
    $stderrFile = [IO.Path]::GetTempFileName()
    try {
        # PYTHONIOENCODING=utf-8: hook/statusline Python이 Korean Windows cp949 locale에서도
        # UTF-8 stdout 출력하도록 강제. 미설정 시 em-dash(—) 등 non-cp949 문자 UnicodeEncodeError 또는
        # Korean 문자 mojibake 발생 (PS UTF-8 read와 인코딩 불일치).
        # Git Bash 명시 호출 (WSL bash 회피). $BashExe는 A3a에서 탐지한 경로.
        $bashPath = if ($script:BashExe) { $script:BashExe } else { 'bash' }
        $p = Start-Process -FilePath $bashPath -ArgumentList @($ScriptFwdPath) `
            -NoNewWindow -Wait -PassThru `
            -RedirectStandardOutput $stdoutFile `
            -RedirectStandardError $stderrFile `
            -Environment @{
                CLAUDE_PROJECT_DIR = $ProjectFwdPath
                PYTHONIOENCODING = 'utf-8'
            }
        $stdout = Get-Content -Path $stdoutFile -Raw -Encoding utf8
        $stderr = Get-Content -Path $stderrFile -Raw -Encoding utf8
        return [pscustomobject]@{
            ExitCode = $p.ExitCode
            Stdout = if ($null -eq $stdout) { '' } else { $stdout }
            Stderr = if ($null -eq $stderr) { '' } else { $stderr }
        }
    } finally {
        Remove-Item -Path $stdoutFile, $stderrFile -ErrorAction SilentlyContinue
    }
}

# ═══ D. Hook 스모크 ══════════════════════════════════════════════════
Write-Host "== D. Hook 스모크 ==" -ForegroundColor Magenta

# D1 no-manifest → exact "{}"
try {
    $r = Invoke-Bash -ScriptFwdPath $hookScript_fwd -ProjectFwdPath $NoManifest_fwd
    $trim = $r.Stdout.Trim()
    if ($r.ExitCode -eq 0 -and $trim -eq '{}') {
        Check-Ok "D1" "no-manifest → exact '{}' (exit 0)"
    } else {
        Check-Fail "D1" "no-manifest 결과 이상 (exit=$($r.ExitCode), stdout='$trim', stderr='$($r.Stderr.Trim())')"
    }
} catch {
    Check-Fail "D1" "실행 예외: $_"
}

# D2 F1 (manifest만, phases 디렉토리 없음) → additionalContext "not initialized"
try {
    $r = Invoke-Bash -ScriptFwdPath $hookScript_fwd -ProjectFwdPath $F1_fwd
    if ($r.ExitCode -ne 0) {
        Check-Fail "D2" "exit != 0 ($($r.ExitCode)). stderr='$($r.Stderr.Trim())'"
    } else {
        $obj = $null
        try { $obj = $r.Stdout | ConvertFrom-Json -AsHashtable } catch { }
        if (-not $obj) {
            Check-Fail "D2" "JSON parse 실패. stdout='$($r.Stdout.Trim())'"
        } elseif ($obj.hookSpecificOutput.hookEventName -ne 'SessionStart') {
            Check-Fail "D2" "hookEventName != 'SessionStart' (실제: '$($obj.hookSpecificOutput.hookEventName)')"
        } elseif ($obj.hookSpecificOutput.additionalContext -notmatch 'not initialized') {
            Check-Fail "D2" "additionalContext에 'not initialized' 없음. 내용='$($obj.hookSpecificOutput.additionalContext)'"
        } else {
            Check-Ok "D2" "F1 → SessionStart + 'not initialized' 포함"
        }
    }
} catch {
    Check-Fail "D2" "실행 예외: $_"
}

# D3 F2 (manifest + phases 디렉토리 있음, state_file 없음) → additionalContext "phases directory exists"
try {
    $r = Invoke-Bash -ScriptFwdPath $hookScript_fwd -ProjectFwdPath $F2_fwd
    if ($r.ExitCode -ne 0) {
        Check-Fail "D3" "exit != 0 ($($r.ExitCode)). stderr='$($r.Stderr.Trim())'"
    } else {
        $obj = $null
        try { $obj = $r.Stdout | ConvertFrom-Json -AsHashtable } catch { }
        if (-not $obj) {
            Check-Fail "D3" "JSON parse 실패. stdout='$($r.Stdout.Trim())'"
        } elseif ($obj.hookSpecificOutput.additionalContext -notmatch 'phases directory exists') {
            Check-Fail "D3" "additionalContext에 'phases directory exists' 없음. 내용='$($obj.hookSpecificOutput.additionalContext)'"
        } else {
            Check-Ok "D3" "F2 → 'phases directory exists' 포함"
        }
    }
} catch {
    Check-Fail "D3" "실행 예외: $_"
}

Write-Host ""

# ═══ E. Statusline 스모크 ═════════════════════════════════════════════
Write-Host "== E. Statusline 스모크 ==" -ForegroundColor Magenta

# E1 no-manifest → 빈 출력
try {
    $r = Invoke-Bash -ScriptFwdPath $slScript_fwd -ProjectFwdPath $NoManifest_fwd
    if ($r.ExitCode -eq 0 -and [string]::IsNullOrEmpty($r.Stdout.Trim())) {
        Check-Ok "E1" "no-manifest → 빈 출력 (exit 0)"
    } else {
        Check-Fail "E1" "no-manifest 결과 이상 (exit=$($r.ExitCode), stdout='$($r.Stdout)')"
    }
} catch {
    Check-Fail "E1" "실행 예외: $_"
}

# E2 F1 (statusline_cmd 필드 없음) → "[harness] sample-project"
try {
    $r = Invoke-Bash -ScriptFwdPath $slScript_fwd -ProjectFwdPath $F1_fwd
    $out = $r.Stdout.Trim()
    $exp = '[harness] sample-project'
    if ($r.ExitCode -eq 0 -and $out -eq $exp) {
        Check-Ok "E2" "F1 → '$exp'"
    } else {
        Check-Fail "E2" "F1 결과 이상 (exit=$($r.ExitCode), stdout='$out', 기대='$exp')"
    }
} catch {
    Check-Fail "E2" "실행 예외: $_"
}

# E3 F2 (statusline_cmd 필드 없음) → "[harness] empty-phases"
try {
    $r = Invoke-Bash -ScriptFwdPath $slScript_fwd -ProjectFwdPath $F2_fwd
    $out = $r.Stdout.Trim()
    $exp = '[harness] empty-phases'
    if ($r.ExitCode -eq 0 -and $out -eq $exp) {
        Check-Ok "E3" "F2 → '$exp'"
    } else {
        Check-Fail "E3" "F2 결과 이상 (exit=$($r.ExitCode), stdout='$out', 기대='$exp')"
    }
} catch {
    Check-Fail "E3" "실행 예외: $_"
}

# no-manifest 임시 디렉토리 정리
Remove-Item -Path $NoManifest -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""

# ═══ F. 정보성 출력 ═══════════════════════════════════════════════════
Write-Host "== F. 정보성 ==" -ForegroundColor Magenta

$backups = Get-ChildItem -Path $ClaudeDir -Directory -Filter 'backup-*' -ErrorAction SilentlyContinue
if ($backups -and $backups.Count -gt 0) {
    Write-Info "~/.claude/backup-<ts>/ 디렉토리 $($backups.Count)개 존재 (수동 삭제 권장):"
    foreach ($b in $backups) {
        Write-Info "  - $($b.FullName)"
    }
} else {
    Write-Info "leftover backup 디렉토리 없음"
}

Write-Host ""

# ═══ G. Runtime-only 체크리스트 ═══════════════════════════════════════
Write-Host "== G. Runtime-only 수동 확인 체크리스트 ==" -ForegroundColor Magenta
Write-Host "  [ ] Claude Code 세션에서 'What skills are available?' → harness-{plan,design,ship} 노출"
Write-Host "  [ ] /harness-meta 입력 → slash command 인식 (commands 7종)"
Write-Host "  [ ] .mcp.json에 harness 서버 선언된 프로젝트에서 mcp__harness__* deferred tools 노출"
Write-Host "  [ ] output-style 'Harness Engineer' 선택 → 응답 스타일 반영"
Write-Host "  [ ] CLAUDE.md의 @bootstrap/docs/OWNERSHIP.md 내용 자동 로드 확인"
Write-Host "  [ ] 활성 프로젝트에서 execute.py --doctor → 0 FAIL"

Write-Host ""

# ═══ 요약 ═════════════════════════════════════════════════════════════
Write-Host "== 요약 ==" -ForegroundColor Magenta
$total = $script:Pass + $script:Fail
if ($script:Fail -eq 0) {
    Write-Ok "$($script:Pass)/$total PASS (WARN: $($script:Warn)) — 자동화 검증 통과"
    Write-Info "G 체크리스트(6항)는 Claude Code 세션 내 수동 확인 필요"
    exit 0
} else {
    Write-Err "$($script:Pass)/$total PASS · $($script:Fail) FAIL (WARN: $($script:Warn))"
    exit 1
}

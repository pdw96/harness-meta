# audit/A1 — v1.22 상세 분석 + context7 검증

세션: `sessions/meta/v1.22-install-unification/`
작성: 2026-04-29

## 0. 검증 방법

| 소스 | 항목 |
|------|------|
| context7 `/microsoftdocs/powershell-docs` | PS `Copy-Item -Recurse` 동작, 예외 처리 패턴, `$PSItem.Exception.Message` |
| context7 `/microsoftdocs/windows-powershell-docs` | `Get-FileHash`, `Get-Item LinkType`, `Set-Content Encoding` |
| Bash 실행 검증 | `sha256sum` / `shasum` 출력 포맷 (65자 hex + newline 일치) |
| 코드 직독 | `install-skills.ps1`, `install-skills.sh` 전체 라인 추적 |
| AGENTS_MD_STRATEGY.md §4.2~4.4 | sync-agents 스펙 원문 |

---

## E: copy mode fallback — D1~D20

### D1: New-Item SymbolicLink 실패 예외 타입

**관찰**: 현재 `install-skills.ps1`은 `$ErrorActionPreference = 'Stop'` 설정 후
```powershell
New-Item -ItemType SymbolicLink -Path $dest -Target $src -Force | Out-Null
```
를 try/catch 없이 호출. Developer Mode OFF + 권한 부재 시 `New-Item` 실패 → terminating error 발생 → 함수 전체 abrupt exit.

**예외 타입** (Windows API 기준):
- Win32 error `ERROR_PRIVILEGE_NOT_HELD` (1314) → PowerShell은 이를 `System.UnauthorizedAccessException` 또는 `System.ComponentModel.Win32Exception`으로 wrap
- 정확한 타입은 PowerShell 버전·호출 경로에 따라 다름

**결정**: 특정 예외 타입 catch 말고 **bare `catch {}`** 사용. `$ErrorActionPreference = 'Stop'`이 모든 에러를 terminating으로 전환하므로 bare catch로 충분. `$_.Exception.Message`로 메시지 출력.

context7 인용 (exceptions deep-dive):
```powershell
try { ... }
catch { Write-Output "Error: $($_.Exception.Message)" }
```

### D2: 현재 코드의 사후 검증 로직 분석

현재 symlink 성공 여부를 **사후** 확인:
```powershell
New-Item -ItemType SymbolicLink ... | Out-Null
$created = Get-Item -Path $dest -Force
if ($created.LinkType -ne 'SymbolicLink') { ... rollback ... }
```

**문제**: `New-Item` 실패 시 `$ErrorActionPreference = 'Stop'`으로 인해 함수가 이미 exit. `$created` 라인에 도달하지 못함 → 사후 롤백 코드가 실행되지 않는다.

**수정**: try/catch 도입으로 실패를 잡은 뒤 copy mode로 전환. 사후 `LinkType` 검증 코드는 유지 (실제 symlink 여부 확인).

### D3: Copy-Item 디렉토리 목적지 동작 (context7 확인)

context7 결과:
```powershell
# Destination이 존재하지 않을 때: $dest 자체로 복사 (디렉토리 생성)
Copy-Item -Path C:\New.Directory -Destination C:\temp -Recurse -Force -PassThru
# → C:\temp 가 없으면: C:\temp 생성 (New.Directory 내용)
# → C:\temp 가 있으면: C:\temp\New.Directory 생성 (INTO 동작)
```

**우리 케이스**:
- 선행 조건: `Move-Item $dest $bak` 으로 backup 이동 → `$dest` 부재
- 따라서: `Copy-Item -Path $src -Destination $dest -Recurse -Force` → `$dest` 생성 (src 내용) ✓
- `$SkillsDest` (`~/.claude/skills/`) 는 script 상단에서 `New-Item -ItemType Directory -Force`로 보장 → parent dir 항상 존재 ✓

**⚠️ 주의**: backup 이전에 `$dest`가 이미 없는 케이스(fresh install). 이 경우도 `$dest` 부재 → Copy-Item 정상 동작 ✓

### D4: CopyMode 파라미터 스코프

현재 `Install-OneSkill` 함수는 outer scope의 `$DryRun` 변수를 직접 참조. `$CopyMode`도 동일 패턴으로 outer scope에서 접근.

**구조**:
```powershell
param([switch]$CopyMode, ...)   # script-level

function Install-OneSkill {
    param([string]$Name)
    # $CopyMode, $DryRun 는 outer (script) scope에서 closure-like 참조
}
```

PowerShell 스크립트에서 함수 내부는 부모 스코프 변수를 읽을 수 있음 ✓

### D5: 롤백 로직 copy mode 적용

현재 롤백:
```powershell
if ($bak -and (Test-Path $bak)) {
    Remove-Item -LiteralPath $dest -Recurse -Force -ErrorAction SilentlyContinue
    Move-Item -LiteralPath $bak -Destination $dest -Force
}
```

Copy-Item 실패 시에도 동일 로직 적용 가능. 단 `Copy-Item` 실패는 매우 드묾 (디스크 공간 부족 등).

### D6: Git Bash → PowerShell 플래그 변환 (잠재 버그 발견)

**현재 코드**:
```bash
case "$(uname -s ...)" in
    MINGW*|...)
        exec pwsh "$META_ROOT/install-skills.ps1" "$@"
```

`"$@"` 를 그대로 전달. 사용자가 `bash install-skills.sh --all`을 실행하면:
- bash `--all` → PowerShell 에 `--all`로 전달
- PowerShell `param([switch]$All)` 은 `-All`을 기대. `--all`은 positional argument `$SkillName` = `"--all"`로 파싱될 수 있음

**실증적 분석**:
- PowerShell 7은 `--all`을 `-all`과 동일하게 처리? → **미확인, PS 7.4 docs에서 명확하지 않음**
- 현재 사용자 대부분은 Windows에서 `.ps1`을 직접 실행하므로 이 경로가 사용되지 않았을 가능성

**v1.22 결정 (D6-R)**: v1.22에서 `--copy-mode` → `-CopyMode` 변환이 필수이므로 **전체 플래그 변환 맵** 구현. 기존 `--all`, `--dry-run`, `--list`도 동시에 수정. 잠재 버그 해소.

```bash
# 변환 맵
_ps_args=()
for arg in "$@"; do
    case "$arg" in
        --all)       _ps_args+=("-All") ;;
        --dry-run)   _ps_args+=("-DryRun") ;;
        --list)      _ps_args+=("-List") ;;
        --copy-mode) _ps_args+=("-CopyMode") ;;
        -h|--help)   _ps_args+=("-Help") ;;      # PS에 -Help param 없음 → skip or 별도 처리
        *)           _ps_args+=("$arg") ;;
    esac
done
exec pwsh "$META_ROOT/install-skills.ps1" "${_ps_args[@]}"
```

**범위 판단**: install-skills.sh의 기존 잠재 버그 수정. v1.22 scope(E) 내 부수적 수정. Out of scope 표에 추가 불필요 (bugfix, 추가 파일 없음).

### D7: .harness-install-mode 파일 위치 안전성

`$SkillsDest/.harness-install-mode` = `~/.claude/skills/.harness-install-mode`

Claude Code skill scanner가 `~/.claude/skills/` 내 **서브디렉토리**의 SKILL.md를 탐색. 루트 레벨 파일(`~/.claude/skills/.harness-install-mode`)은 탐색 대상 아님 ✓

단 dotfile(`.`로 시작)이므로 `Get-ChildItem` 기본에서 제외. `-Force` 없으면 표시 안 됨 → Claude Code 스캔 영향 0 ✓

### D8: .harness-install-mode vs .harness-mode 명명 충돌 분석

`AGENTS_MD_STRATEGY.md §4.3`:
> `install` 스크립트가 `.harness-mode` 파일(`symlink` | `copy`)에 현재 모드를 기록

이것은 per-project AGENTS.md sync 모드 파일 (project root에 생성). `install-project-claude` 맥락.

`install-skills`의 모드 파일은 `~/.claude/skills/.harness-install-mode` (글로벌, user home).

**두 파일 비교**:
| 파일 | 위치 | 맥락 |
|------|------|------|
| `.harness-mode` | `<proj>/` | AGENTS.md sync 모드 (per-project, v1.21 연기) |
| `.harness-install-mode` | `~/.claude/skills/` | skills install 모드 (글로벌) |

이름 충돌 없음. 의미도 명확히 구분 ✓

### D9: Set-Content 인코딩 (모드 파일 쓰기)

```powershell
"symlink" | Set-Content (Join-Path $SkillsDest '.harness-install-mode')
```

PowerShell 7+ 기본 인코딩: **UTF-8 NoBOM** ✓ (PS 5.1에서는 UTF-16LE 주의, but #Requires -Version 7.3)

plain ASCII 문자열("symlink"/"copy") → BOM 무관, 어느 인코딩으로 읽어도 동일 ✓

### D10: --list, --dry-run 시 모드 파일 미기록

`R3`의 "install-skills --list / --dry-run 시 미생성" 조건을 코드로 보장:

```powershell
function Install-OneSkill {
    if ($DryRun) {
        # ... dry-run log; return
        return  # 모드 파일 기록 없음 ✓
    }
    # ... 실제 설치 후
    "symlink" | Set-Content $modeFile  # 실설치 시만 기록
}
```

`-List`는 `Install-OneSkill`을 호출하지 않으므로 모드 파일 기록 없음 ✓

### D11: 모드 파일 덮어쓰기 정책

복수 skill 설치 시 (`-All`) 마지막 skill의 모드로 덮어써짐. 예: skill A → symlink 성공 → "symlink", skill B → symlink 실패 → "copy". 모드 파일 = "copy".

**판단**: 글로벌 단일 모드 파일이라 혼재 표현 불가. 하지만 목적이 "마지막 설치 결과 기록"이므로 덮어쓰기 허용.

실제 사용 패턴: 한 기기에서 symlink 권한이 있거나 없거나 → 모든 skill이 동일 모드 → 혼재 시나리오 극히 드묾.

### D12: install-skills.ps1 LinkType 검증 호환성 (PS 7.2+)

context7 결과:
> `FileSystemInfo.Target` property가 PS 7.2+에서 `CodeProperty` → `LinkTarget`의 AliasProperty로 변경.

현재 코드:
```powershell
$target = $item.Target | Select-Object -First 1
if ($target -eq $src ...) { ... }
```

PS 7.2+: `.Target`이 `.LinkTarget` alias → 단일 string 반환. `| Select-Object -First 1`은 string에 대해 string 자체를 반환 ✓

PS 7.1-: `.Target`은 `ICollection<string>` → `| Select-Object -First 1`이 첫 원소 반환 ✓

**결론**: 현재 코드가 두 PS 버전 모두 대응 ✓ v1.22에서 변경 불필요.

### D13: SKILLS.md 문서 갱신 포인트

§5 충돌 정책 표에 **copy 모드 행** 추가:
| 상태 | 동작 |
|------|------|
| symlink 실패 (권한 부재) → `-CopyMode` 자동 fallback | backup → copy + 모드 파일 "copy" 기록 |

§6 OS 분기 + 권한 표에 **Windows Developer Mode OFF 행** 수정:
| OS | 요구사항 | symlink 명령 | copy fallback |
|----|----------|-------------|--------------|
| Windows + Developer Mode ON | PowerShell 7+ | `New-Item -ItemType SymbolicLink` | — |
| Windows + admin 권한 | PowerShell 7+ | 동상 | — |
| **Windows + 권한 부재** | **PowerShell 7+** | **New-Item 시도 후 catch** | **`Copy-Item -Recurse -Force`** |

현재 §6: "Windows + 권한 부재 → install-skills.ps1 abort" → 수정 필요.

---

## C: sync-agents — D14~D36

### D14: sync-agents 목적과 사용 시나리오

AGENTS_MD_STRATEGY.md §4.2에 따르면 sync-agents는 **copy 모드** 프로젝트에서 AGENTS.md 편집 후 CLAUDE.md 등이 drift할 때 동기화하는 도구.

**주요 사용 시나리오**:
1. Windows copy 모드 bootstrap → `CLAUDE.md` = AGENTS.md 복사본
2. 사용자가 AGENTS.md 수정 → `CLAUDE.md`와 hash 불일치 (drift)
3. `sync-agents.sh --source-wins` 실행 → CLAUDE.md 동기화

symlink 모드(Linux/macOS 기본)에서는 CLAUDE.md = AGENTS.md symlink → drift 불가 → sync-agents를 실행해도 no-op(skip all symlinks).

### D15: SHA-256 cross-platform (실증 검증 완료)

실행 결과:
```
sha256sum 출력: a1fff0...  */tmp/_hash_test.txt  → awk/cut 모두 hash 추출 ✓
shasum 출력:    a1fff0...  */tmp/_hash_test.txt  → 동일 hash ✓
양쪽 wc -c = 65 (64 hex + newline) ✓
```

**알고리즘**:
```bash
if command -v sha256sum >/dev/null 2>&1; then
    hash_of() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
    hash_of() { shasum -a 256 "$1" | awk '{print $1}'; }
else
    hash_of() { python3 -c \
        "import hashlib,sys; print(hashlib.sha256(open(sys.argv[1],'rb').read()).hexdigest())" "$1"; }
fi
```

`awk '{print $1}'`을 `cut -d' ' -f1`보다 선호: sha256sum 이진 모드(`*` prefix) 시 `<hash> *<file>` 형태도 안정적으로 추출. context7에서 `cut` 미사용 예시 패턴 확인.

**Python3 fallback 추가 이유**: 특수 Linux 배포판(embedded)에서 sha256sum/shasum 모두 없을 가능성. Python3는 대부분의 현대 시스템에 존재.

### D16: PowerShell Get-FileHash SHA256

```powershell
(Get-FileHash -Path $path -Algorithm SHA256).Hash
```
→ uppercase hex string (e.g., `"A1FFF0..."`)

context7 `/microsoftdocs/windows-powershell-docs`에서 Get-FileHash 직접 결과는 미반환. 공식 PS docs 기반:
- `.Hash` property → uppercase hex ✓
- `$sourceHash -eq $targetHash` → PS string comparison은 기본 case-insensitive → 비교 안전 ✓

**bash↔PS 크로스 비교 없음**: sync-agents.sh는 bash끼리, sync-agents.ps1은 PS끼리 비교 → case 불일치 문제 없음 ✓

### D17: 심링크 감지 — bash

```bash
[ -f "$target" ]   # true: 파일 존재 (symlink pointing to regular file도 true)
[ -L "$target" ]   # true: symlink (broken symlink도 true)
```

**흐름**:
1. `[ -f "$target" ]` 먼저 확인 → false면 skip (broken symlink 포함)
2. valid symlink: `[ -f ]` = true, `[ -L ]` = true → skip (drift check 불필요)
3. regular file: `[ -f ]` = true, `[ -L ]` = false → SHA-256 비교

```bash
[ -f "$target" ] || continue
[ -L "$target" ] && { color_info "symlink: $target (skip)"; continue; }
target_hash=$(hash_of "$target")
```

### D18: 심링크 감지 — PowerShell (Junction 포함)

현재 install-skills.ps1:
```powershell
if ($item.LinkType -eq 'SymbolicLink') { ... }
```

Windows에서 디렉토리 symlink는 **Junction**으로 처리되는 경우가 있음. sync-agents.ps1에서 drift 감지 시 둘 다 skip해야:

```powershell
$item = Get-Item $target -Force
if ($item.LinkType -in @('SymbolicLink', 'Junction')) {
    Write-Info "symlink/junction: $target (skip)"
    continue
}
```

**`-in` 연산자**: PowerShell 3.0+에서 지원. `#Requires -Version 7.3`이므로 사용 가능 ✓

### D19: 비대화형 환경 감지

```bash
# bash
if [ ! -t 0 ] || [ -n "${CI:-}" ]; then
    NON_INTERACTIVE=1
fi
```

```powershell
# PowerShell  
if ([Console]::IsInputRedirected -or $env:CI) {
    $NonInteractive = $true
}
```

**CI 환경 처리**: `warn-and-prompt` 모드에서 stdin이 non-TTY이면 → 각 파일에 대해 prompt 없이 "drift detected, use --source-wins" 메시지 + exit 1. 파일 변경 없음. `--check` 동작과 동일.

**`$env:CI`는 GitHub Actions, GitLab CI, CircleCI 등 대부분 CI에서 자동 설정**. 단 Jenkins, 일부 구형 CI는 미설정. `[Console]::IsInputRedirected`가 더 범용적.

### D20: AGENTS.md 인코딩과 SHA-256 (D21로 이동)

실제 drift 발생 케이스:
1. Linux에서 AGENTS.md 편집 (LF) → Windows에서 CLAUDE.md (Git 자동 CRLF 변환 시)
2. PowerShell `Set-Content`로 copy 시 인코딩 변환

**source-wins 구현 방법**:
- `Copy-Item -Path AGENTS.md -Destination CLAUDE.md -Force` → **바이너리 복사** (인코딩 변환 없음) ✓
- bash: `cp AGENTS.md CLAUDE.md` → 바이너리 복사 ✓

`Set-Content`로 쓰면 인코딩 변환 위험 → **Copy-Item / cp 사용** (바이너리 복사 원칙)

### D21: 대상 파일 존재 검사 및 매핑

PLAN R5의 FILE_MAPPINGS 7건 중 일부는 디렉토리 없는 경우:
- `.github/copilot-instructions.md` → `.github/` 없으면 파일도 없음 → `[ -f ]` 검사가 자연히 skip ✓
- `.cursor/rules/main.mdc` → 마찬가지 ✓

**추가 고려**: `source-wins` 시 대상 파일 덮어쓰기 → 부모 디렉토리 없으면 `cp` 실패.
- 대응: `[ -f "$target" ]`이 false면 skip → 부모 디렉토리 없는 파일은 처리 대상 아님 ✓
- 단 `--source-wins --create-missing` 플래그는 Out of scope (v1.22 밖)

### D22: AGENTS.md 부재 시 처리

```bash
if [ ! -f "AGENTS.md" ]; then
    color_err "AGENTS.md not found in CWD. Run from project root."
    exit 1
fi
```

```powershell
if (-not (Test-Path "AGENTS.md")) {
    Write-Err "AGENTS.md not found in CWD. Run from project root."
    exit 1
}
```

실행 위치 검증을 최초에 수행 → 나머지 로직은 AGENTS.md 존재 보장 상태에서 실행.

### D23: --source-wins 시 대상 파일 쓰기 원자성

`cp AGENTS.md CLAUDE.md` (bash) / `Copy-Item AGENTS.md CLAUDE.md -Force` (PS) → 간단한 덮어쓰기. 원자성 보장 없음 (OS-level).

시나리오: 쓰기 중 Claude Code가 CLAUDE.md 읽기 → 불완전한 파일 가능성. 이론적 위험이지만 실용적으로 무시 가능 (sync-agents는 사람이 명시 실행).

Out of scope: 원자적 쓰기 (temp file + rename 패턴)는 v1.22 밖.

### D24: warn-and-prompt 대화형 구현

```bash
printf '\n[WARN] drift detected in %d file(s):\n' "${#DRIFT[@]}"
for i in "${!DRIFT[@]}"; do
    printf '  %d. %s\n' "$((i+1))" "${DRIFT[$i]}"
done
printf '\nApply source-wins for each? (y=overwrite, n=skip, q=quit)\n'

for target in "${DRIFT[@]}"; do
    [ "$NON_INTERACTIVE" -eq 1 ] && { color_warn "non-interactive: skip $target"; continue; }
    printf '  %s [y/n/q]: ' "$target"
    read -r answer </dev/tty   # stdin이 pipe여도 /dev/tty 직접 읽기
    case "$answer" in
        [Yy]) cp AGENTS.md "$target"; color_ok "overwritten: $target" ;;
        [Qq]) break ;;
        *)    color_info "skipped: $target" ;;
    esac
done
```

**`read -r answer </dev/tty`**: stdin이 pipe여도 TTY에서 직접 입력 수신 가능. CI에서 `/dev/tty`가 없으면 실패 → `$NON_INTERACTIVE` 체크로 사전 차단 ✓

### D25: sync-agents.sh set -euo pipefail 영향

```bash
set -euo pipefail
```

`-e`: 명령 실패 시 즉시 종료. `hash_of()` 함수가 실패하면 스크립트 종료.

**hash_of 호출 시 파일 존재 보장**: `[ -f "$target" ]` 체크 후에만 `hash_of "$target"` 호출 → 파일 없어서 실패하는 케이스 없음 ✓

`-u`: 미정의 변수 참조 실패. `${CI:-}` 형태로 unset 시 empty string 사용 ✓

### D26: DRIFT 배열 초기화 및 사용

```bash
DRIFT=()   # bash 4+ array (macOS bash 3.2 에서 배열 지원 있음)

# 요소 추가
DRIFT+=("$target")

# 배열 길이
"${#DRIFT[@]}"

# 반복
for target in "${DRIFT[@]}"; do
```

bash 3.2 (macOS system bash) 에서도 1차원 배열 지원 ✓. `#!/usr/bin/env bash`이므로 `/usr/bin/bash` (3.2) 대신 Homebrew bash를 찾을 수 있음.

### D27: sync-agents.sh Windows Git Bash 위임

install-skills.sh와 동일 패턴:
```bash
case "$(uname -s 2>/dev/null || echo unknown)" in
    MINGW*|MSYS*|CYGWIN*)
        # 플래그 변환 포함
        exec pwsh "$SCRIPT_DIR/sync-agents.ps1" ...
        ;;
esac
```

`$SCRIPT_DIR`: sync-agents.sh 위치 기반 절대경로.
```bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

install-skills.sh는 `$META_ROOT`를 환경변수로 받지만, sync-agents.sh는 프로젝트 루트에서 실행되므로 위치 다름. `$BASH_SOURCE[0]`으로 스크립트 위치 기반 META_ROOT 계산.

### D28: sync-agents.ps1 non-interactive 처리

```powershell
$IsNonInteractive = [Console]::IsInputRedirected -or 
                    ($null -ne $env:CI) -or
                    ($null -ne $env:GITHUB_ACTIONS)
```

`[Console]::IsInputRedirected`: PowerShell 7+에서 stdin redirect 감지 ✓

warn-and-prompt + non-interactive → 파일 변경 없음 + `[WARN]` 출력 + exit 1.

### D29: --check flag exit code 정책

AGENTS_MD_STRATEGY.md §4.4 exit code:
- `symlink 깨짐`: ERR (exit 1)
- `drift 감지`: WARN (exit 0) — 의도적 편집일 수 있음
- `파일 누락`: ERR (exit 1)

**하지만 PLAN R4에서**: `--check` → drift 있으면 exit 1.

**충돌 해소**: AGENTS_MD_STRATEGY.md는 의사코드 수준 스펙. v1.22에서 실제 구현 결정:
- `--check` flag 명시 시: drift 있으면 exit 1 (CI 파이프라인 활용 목적)
- 기본(warn-and-prompt): drift 있으면 exit 0 + warn (의도적 편집 가능성 반영)

이 결정이 AGENTS_MD_STRATEGY.md §4.4 exit code와 차이. §4.4는 v1.22에서 갱신.

### D30: --list-targets 구현

```bash
list_targets() {
    if [ ! -f "AGENTS.md" ]; then
        color_err "AGENTS.md not found in CWD"
        exit 1
    fi
    color_info "Detected targets in CWD:"
    for target in "${MAPPINGS[@]}"; do
        if [ -f "$target" ]; then
            if [ -L "$target" ]; then
                printf '  [symlink] %s\n' "$target"
            else
                printf '  [copy]    %s\n' "$target"
            fi
        fi
    done
}
```

`MAPPINGS` 배열에 R5 7건 경로 정의.

### D31: sync-agents 실행 위치 강제

현재 PLAN: "프로젝트 루트에서 실행". CWD에 AGENTS.md 없으면 exit 1 (D22).

추가 고려: `AGENTS.md`가 현재 디렉토리 기준 → 상위 디렉토리 검색 없음 (단순 설계 유지).

### D32: target-wins (Out of scope 확인)

PLAN Out of scope에 명시됨. v1.22에서는 `--source-wins`만. `--target-wins` 코드 skeleton도 작성 안 함 (dead code 방지).

### D33: sync-agents.ps1 플래그 변환

bash `--source-wins` → PS `-SourceWins` (etc.) 변환 필요. `sync-agents.sh`의 Windows 위임에서 처리.

### D34: smoke-sync-agents.sh dynamic setup

Linux에서 tmpdir에 AGENTS.md + CLAUDE.md (identical) 생성 후 테스트:
```bash
tmpdir=$(mktemp -d)
echo "# Test AGENTS.md content" > "$tmpdir/AGENTS.md"
cp "$tmpdir/AGENTS.md" "$tmpdir/CLAUDE.md"
```

**T1**: `cd "$tmpdir" && bash sync-agents.sh --check` → exit 0 (no drift) ✓
**T2**: `echo "different" >> "$tmpdir/CLAUDE.md" && bash sync-agents.sh --check` → exit 1 (drift) ✓
**T3**: `bash sync-agents.sh --source-wins` → CLAUDE.md = AGENTS.md, exit 0 ✓
**T4**: `bash sync-agents.sh --list-targets` → CLAUDE.md 포함 ✓

### D35: smoke-skills-install.sh copy mode 테스트

Linux에서 `--copy-mode` 명시 테스트:
```bash
HOME="$TMPHOME" bash install-skills.sh --copy-mode ai-ready-scorer
[ ! -L "$TMPHOME/.claude/skills/ai-ready-scorer" ]   # symlink 아님
[ -d "$TMPHOME/.claude/skills/ai-ready-scorer" ]      # directory
[ -f "$TMPHOME/.claude/skills/ai-ready-scorer/SKILL.md" ]  # 내용 있음
grep -q "copy" "$TMPHOME/.claude/skills/.harness-install-mode"  # 모드 파일
```

### D36: AGENTS_MD_STRATEGY.md §4.2 갱신 범위

현재 텍스트: `sync-agents.{ps1, sh}  (실제 구현: v1.21-cross-platform-install)`
갱신: `실제 구현: v1.22-install-unification`

인터페이스 스펙 (`--source-wins`, `--check`, `--dry-run`, `--list-targets`) 추가.
exit code 정책 (D29) 갱신.

---

## R 결정 변경 사항 (PLAN 대비 수정 필요)

### R2 수정: install-skills.sh Git Bash 위임 플래그 변환

**PLAN 원문**: `--copy-mode` 전달 포함.
**수정 내용**: 전체 플래그 변환 맵 구현 (D6). `--all`, `--dry-run`, `--list`도 동시 수정.

### R4 수정: sync-agents.sh SCRIPT_DIR 기반 경로

`$META_ROOT` 환경변수 대신 `BASH_SOURCE[0]` 기반으로 스크립트 위치에서 상위 디렉토리를 추론. install-skills.sh와 같은 위치에 있으므로:
```bash
META_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```
단 sync-agents는 harness-meta 루트에서 실행되는 스크립트가 아니므로 `META_ROOT`가 불필요할 수도. sync-agents는 어느 프로젝트 루트에서도 실행 가능하며, 스크립트 자체 경로는 `$HOME/harness-meta/sync-agents.sh`. **환경변수 `HARNESS_META_ROOT`는 필요 없음 - sync-agents는 CWD의 파일만 처리**.

### R5 수정: FILE_MAPPINGS 배열명

bash에서 `MAPPINGS` 대신 명확성 위해 `AGENT_MAPPINGS` 사용:
```bash
AGENT_MAPPINGS=(
    "CLAUDE.md"
    "GEMINI.md"
    ".github/copilot-instructions.md"
    ".cursor/rules/main.mdc"
    "CONVENTIONS.md"
    ".clinerules/main.md"
    ".roo/rules/main.md"
)
```

### R6 수정: PS symlink 감지에 Junction 추가 (D18)

```powershell
if ($item.LinkType -in @('SymbolicLink', 'Junction')) { ... skip ... }
```

### R7 수정: non-interactive 감지 정확화 (D19)

bash: `[ ! -t 0 ] || [ -n "${CI:-}" ]`
PS: `[Console]::IsInputRedirected -or ($null -ne $env:CI)`

`warn-and-prompt` 기본값이지만 non-interactive 시 → exit 1 + warn (파일 변경 없음).

### R9 추가: smoke copy mode dynamic (D35)

`smoke-skills-install.sh`의 Linux dynamic 섹션에 `--copy-mode` 테스트 3건 추가 (총 6건 → 6건 dynamic으로 확장).

---

## 신규 발견 D41~D44 (1차 분석 미포함)

### D41: install-skills.ps1 SYNOPSIS 갱신 필요

`.DESCRIPTION`에 copy mode fallback 설명 추가:
```
v1.22+: Windows Developer Mode 미설정 시 copy 모드로 자동 fallback.
        ~/.claude/skills/.harness-install-mode 에 모드 기록.
```

`.PARAMETER CopyMode` 항목 추가.
`.EXAMPLE` 예시 추가: `pwsh ./install-skills.ps1 -CopyMode`

### D42: install-skills.sh header 갱신

```bash
# v1.22+: copy mode fallback (--copy-mode). Windows Developer Mode 없어도 설치 가능.
```

Usage 섹션:
```
# bash install-skills.sh --copy-mode [name]   # copy 모드 명시
```

### D43: smoke-scope-contract.sh v1.22 glob

현재 끝: `sessions/meta/v1.21*/PLAN.md` 추가 필요.
추가: `sessions/meta/v1.22*/PLAN.md`

v1.22 PLAN.md가 "세션 소속 근거 + Scope inheritance + Out of scope" 3 섹션 모두 포함해야 smoke PASS.

### D44: install-skills.ps1 exit code 일관성

현재: 실패 시 rollback 후 `return` (함수 종료), 스크립트는 계속 진행. 일부 케이스에서 partial install로 `Write-Ok "install-skills 완료"` 출력.

copy mode fallback에서 Copy-Item 성공 시 → OK. 실패 시 → rollback + `return`. 스크립트 전체는 계속. 이는 `-All` 모드에서 개별 skill 실패가 나머지 설치를 막지 않는 의도적 설계 ✓

---

## 요약: PLAN 수정 항목

| # | 항목 | 변경 방향 |
|---|------|---------|
| R2 수정 | install-skills.sh Git Bash 위임: 전체 플래그 변환 맵 | 잠재 버그(D6) 동시 수정 |
| R4 수정 | sync-agents META_ROOT 불필요 (CWD 기반 동작) | 구조 단순화 |
| R5 수정 | FILE_MAPPINGS 배열명 `AGENT_MAPPINGS` | 명확성 |
| R6 수정 | PS symlink: `Junction` 타입도 skip | D18 발견 |
| R7 수정 | non-interactive: `[Console]::IsInputRedirected` + bash `[ ! -t 0 ]` | D19 정확화 |
| R9 추가 | smoke copy mode dynamic 3건 추가 (D35) | 기존 dynamic 섹션 확장 |
| D41 | install-skills.ps1 SYNOPSIS + .PARAMETER CopyMode | docs 일관성 |
| D42 | install-skills.sh header/Usage copy mode 설명 | docs 일관성 |
| D43 | smoke-scope-contract.sh v1.22 glob 추가 | scope contract self-test |
| D44 | 기존 exit code 정책 유지 확인 (변경 없음) | no-op |

**추가 잠재 버그 해소 (D6)**: install-skills.sh Git Bash 위임 플래그 변환 = v1.22 E scope의 부수적 bugfix. Out of scope 표 추가 불필요 (별도 파일 없음, install-skills.sh 수정 범위 내).

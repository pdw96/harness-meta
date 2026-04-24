# meta v1.3-install-verify — PLAN

세션 시작: 2026-04-24
선행 세션: [`sessions/meta/v1.1-global-smoke-test/`](../v1.1-global-smoke-test/REPORT.md) (smoke 절차 원천), [`sessions/meta/v1.2-ownership-rules/`](../v1.2-ownership-rules/REPORT.md) (OWNERSHIP 규약)
목적: `install.ps1`에 동반하는 **설치 후 자가 검증 스크립트** 도입. v1.1에서 수동으로 수행한 smoke 절차 중 **스크립트화 가능한 부분**을 자동화해 회귀 방지 + 타 기기 이전 비용 ↓.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/harness-meta/{install.ps1, verify.ps1 (신규), tests/fixtures/** (신규), README.md, CLAUDE.md}` → 전부 **S3** (repo 정책·설치).
- **T1 경로 다수결** 모두 S3 → `sessions/meta/` 확정.
- `tests/fixtures/**`는 install 검증용 자산이므로 bootstrap(S2)과 구분되는 S3 귀속. "설치의 일부"로 본다.

## 배경

### v1.1 smoke test의 한계

v1.1-global-smoke-test는 15개 증거 항목을 **수동으로** 수집했다. 문제:
- 타 기기 이전 / 재설치 시 동일 절차 재수행 부담
- 회귀 발생 시 감지 지연 (사용자가 새 세션에서 마주치기 전에는 모름)
- `install.ps1` 설치 끝 검증(`ReparsePoint` 속성만, lines 299–311)은 너무 얕음 — **broken symlink(target 실종) 감지 못함**

### 목표 경계 — 스크립트화 가능 vs Claude runtime 전용

v1.1의 15 항목 분해:

| 영역 | 스크립트화 | 비고 |
|---|---|---|
| symlink 17개 target 유효 | ✅ | 현재 속성만, target resolve 미검증 |
| settings.json 필드 | ✅ | 현재 설치만, 검증 안 함 |
| hook 실행 (2 케이스) | ✅ | fixture 필요 |
| statusline 실행 (2 케이스) | ✅ | fixture 필요 |
| slash/agent/skill 노출 | ❌ | Claude Code 런타임 전용 |
| MCP deferred tools | ❌ | 런타임 전용 |
| output-style 적용 | ❌ | 런타임 전용 |
| `CLAUDE.md @import` 해석 | ❌ | 런타임 전용 |
| `execute.py --doctor/--status` | ❌ | 프로젝트별 (verify 범위 외) |

**9/15 자동화 + 6/15는 체크리스트 출력으로 보조**.

## 목표

- [ ] `verify.ps1` 신규 — repo 루트에 독립 스크립트 (`#Requires -Version 7.3` 선언, `$IsWindows` 가드)
- [ ] `install.ps1`에서 symlink 속성 체크 로직을 공유 함수 `Test-SymlinkIntegrity`로 추출
- [ ] 함수는 `LinkType -eq 'SymbolicLink'` 엄격 체크 (Junction 배제) + target `Test-Path` + target이 MetaRoot 하위
- [ ] `install.ps1` lines 167·303도 강화된 함수 호출로 교체 (ReparsePoint → SymbolicLink)
- [ ] `tests/fixtures/sample-project/` 신규 — F1 (매니페스트만) fixture
- [ ] `tests/fixtures/empty-phases/` 신규 — F2 (+ 빈 `phases/index.json`) fixture
- [ ] settings.json 검증 — `statusLine` + `hooks.SessionStart`만 (foreign hooks 무시, BOM 부재)
- [ ] Hook 실행 스모크 3 케이스 (no-manifest / F1 / F2) — stdout 격리
- [ ] Statusline 실행 스모크 3 케이스 (no-manifest / F1 / F2)
- [ ] Bash에 fixture path 전달 시 forward-slash 정규화 (`\\` → `/`)
- [ ] Runtime-only 6항 체크리스트 출력 (verify 말미)
- [ ] Leftover `~/.claude/backup-<ts>/` 디렉토리 [INFO] 안내
- [ ] Partial install 감지 — 기대 파일 목록 vs 실제 symlink 1:1 매칭
- [ ] 실패 주입 테스트 수동 수행 (symlink 1개 삭제 → B FAIL 감지)
- [ ] README/CLAUDE.md에 `verify.ps1` 사용법 추가
- [ ] v1.3 REPORT에 verify 실측 로그 + 실패 주입 로그 첨부

## 범위

**포함**:
- `verify.ps1` 신규 스크립트 (read-only, `#Requires 7.3`, `$IsWindows` 가드)
- `install.ps1` 리팩터 — `Test-SymlinkIntegrity` 함수 추출 + **LinkType 엄격화** (ReparsePoint → SymbolicLink)
- `tests/fixtures/**` 2종 (F1 minimal, F2 empty-phases)
- Foreign-compatible settings.json 검증 (우리 필드만)
- README 트러블슈팅 섹션에 `verify.ps1` 진입점 1줄
- CLAUDE.md "명령어" 섹션 갱신
- REPORT에 실패 주입 테스트 3종 증거

**제외**:
- F3 fixture (milestone.json + phase/index.json + mock `statusline_stats.py`) — mock 파일이 S5 복제 경계를 넘음. v1.4+ 후보
- CI 통합 (`-Json` 출력 모드) — v1.4-ci-integration 후보
- macOS/Linux 지원 — verify.ps1는 Windows 전용, `$IsWindows` 가드만. Cross-platform 세션은 v1.4+ 후보
- `execute.py --doctor/--status` 래핑 — 프로젝트별, verify 범위 외
- 설치 끝에 auto-verify 자동 호출 — 사용자 명시 실행 유지 (v1.4 후보로 보류)
- `.verify-report.txt` 파일 저장 — 표준 출력만
- bit-flag exit code — 단순 exit 1만
- NTFS ACL / 안티바이러스 / unicode 경로 지원 — 실무 edge case 별도 대응

## 실무 제약 (v1.3 구현 고려사항)

### Bash 호출 (Windows native bash/MSYS)
- `& bash $scriptPath 2>$stderrFile` — stdout만 `$LASTEXITCODE`로 수집, stderr 격리
- stdin 오염 방지: `$null | & bash ...` 또는 PS `Start-Process -RedirectStandardInput $null`
- fixture path: `(Resolve-Path $fixture).Path -replace '\\','/'` 후 `$env:CLAUDE_PROJECT_DIR` 설정

### Sub-process 환경변수 격리
- `$env:CLAUDE_PROJECT_DIR = $path` 후 `& bash ...` → PS 프로세스 scope 환경변수만 오염
- verify 종료 시 `Remove-Item Env:CLAUDE_PROJECT_DIR` 정리 (best-effort)

### 실제 사용자 settings.json 예 (foreign-compatible 검증용)
```json
{
  "permissions": { "allow": [...] },                // ← verify 무시
  "model": "Opus",                                   // ← verify 무시
  "hooks": {
    "UserPromptSubmit": [ ... ],                     // ← verify 무시 (다른 matcher)
    "SessionStart": [ { ... } ]                      // ← verify C4–C9 검증 대상
  },
  "statusLine": { "type": "command", "command": "..." }  // ← verify C2–C3
}
```

### Partial install 시나리오 (G29 실증)
- install.ps1이 line 220(agents 생성) 직후 크래시 → ~/.claude/commands/ 7개만 생성, agents/skills/output-styles/hooks/statusline 누락
- verify B3이 "10건 누락" FAIL 출력, 어느 카테고리가 누락인지 표시

### LinkType=Junction 시나리오 (G31 실증)
- Dev Mode OFF에서 `New-Item -ItemType SymbolicLink`가 Junction으로 fallback 가능 (PowerShell 7에서 드물지만 가능)
- 실제 `Get-Item $link | Select-Object LinkType`으로 `SymbolicLink` 정확 확인 필요
- 현재 install.ps1 line 303 `ReparsePoint` 체크는 Junction도 통과 → v1.3에서 엄격화

## 변경 대상

### 신규 파일

| 경로 | scope | 역할 |
|---|---|---|
| `~/harness-meta/verify.ps1` | S3 | 설치 후 자가 검증 스크립트 (PowerShell 7+) |
| `~/harness-meta/tests/fixtures/sample-project/.harness.toml` | S3 | F1 fixture — 매니페스트만. no-op / 미초기화 경로 테스트 |
| `~/harness-meta/tests/fixtures/sample-project/scripts/harness/.gitkeep` | S3 | `code_dir` 존재 전제 충족용 빈 디렉토리 유지 |
| `~/harness-meta/tests/fixtures/empty-phases/.harness.toml` | S3 | F2 fixture — + `phases/index.json` |
| `~/harness-meta/tests/fixtures/empty-phases/phases/index.json` | S3 | F2용. `{"milestones": []}` — "all milestones OK" 분기 |
| `~/harness-meta/tests/fixtures/empty-phases/scripts/harness/.gitkeep` | S3 | 위와 동일 |

### 수정 파일

| 경로 | scope | 변경 |
|---|---|---|
| `~/harness-meta/install.ps1` | S3 | symlink 속성 체크 로직(lines 299–311)을 `Test-SymlinkIntegrity` 함수로 추출. `verify.ps1`이 dot-source 또는 직접 호출. `-Verify`와 `-Force` 상호 배타 가드는 install 쪽에 안 넣음 (install은 원래 Force만, verify는 별도 파일이므로 무관) |
| `~/harness-meta/README.md` | S3 | "트러블슈팅" 섹션에 `pwsh ./verify.ps1` 안내 1줄 + "설치 직후 / 타 기기 이전 후 권장" 한 줄 |
| `~/harness-meta/CLAUDE.md` | S3 | "명령어" 섹션 `### 설치 / 재설치` 하위에 `pwsh ./verify.ps1` 추가 |

### 세션 기록

| 경로 | 역할 |
|---|---|
| `sessions/meta/v1.3-install-verify/PLAN.md` | 본 파일 |
| `sessions/meta/v1.3-install-verify/REPORT.md` | 구현 + verify 실측 결과 |

## verify.ps1 설계 (초안)

### 시그니처

```powershell
param(
    [string]$MetaRoot = $(if ($env:HARNESS_META_ROOT) { $env:HARNESS_META_ROOT } else { Join-Path $HOME 'harness-meta' }),
    [int]$Timeout = 30
)
```

- `-Force` 없음 (read-only)
- `-Timeout` — hook/statusline 실행 최대 대기 (기본 30s, v1.1 lessons 고려)

### 검증 단계 (A–E 5개 + 선행 Z 플랫폼 가드)

```
[Z] 플랫폼 전제 (early-exit 가드)
    Z1 $IsWindows -eq $true (아니면 exit 1 with "Windows 전용")
    Z2 $PSVersionTable.PSVersion.Major -ge 7 (#Requires 선언으로 이중 보호)
    Z3 $MetaRoot = (Resolve-Path $MetaRoot).Path (정규화)

[A] 환경 전제 (install.ps1 prechecks 재사용)
    A1 Developer Mode ON (HKLM 레지스트리)
    A2 MetaRoot 구조 (6 카테고리 디렉토리)
    A3 bash / python3 PATH

[B] Symlink 무결성 — 기대 vs 실제 1:1 enumeration
    B1 ~/.claude/{commands,agents,skills,output-styles,hooks,statusline}/ 디렉토리 존재
    B2 MetaRoot에서 기대 파일 동적 enumerate (install.ps1 line 139-146 필터 재사용)
    B3 각 기대 파일 ↔ symlink 1:1 대응 (partial install 감지 — 누락 목록 출력)
    B4 $item.LinkType -eq 'SymbolicLink' (Junction/ReparsePoint 단독 불허)
    B5 Test-Path $item.Target 통과 (broken symlink 감지)
    B6 $item.Target 시작이 $MetaRoot + '\' 하위 (stale MetaRoot 감지)
    B7 skill 디렉토리 내부 SKILL.md 존재 (skill별 추가 파일은 검증 제외)

[C] settings.json 검증 — 우리가 쓴 필드만
    C0 파일 존재 + 첫 3바이트 0xEF 0xBB 0xBF 부재 (UTF-8 no BOM)
    C1 JSON parse OK
    C2 statusLine.type == "command"
    C3 statusLine.command 정확 일치 '$HOME/.claude/statusline/statusline.sh' (literal string)
    C4 hooks.SessionStart 배열 존재 (길이 1 기대, >1이면 [WARN] 공존 경고)
    C5 hooks.SessionStart[0].matcher == "startup"
    C6 hooks.SessionStart[0].hooks[0].type == "command"
    C7 hooks.SessionStart[0].hooks[0].command == '$HOME/.claude/hooks/session-init.sh'
    C8 hooks.SessionStart[0].hooks[0].shell == "bash"
    C9 hooks.SessionStart[0].hooks[0].timeout == 10
    # 주의: permissions, model, hooks.UserPromptSubmit 등 다른 필드는 조회 안 함 (foreign-compatible)

[D] Hook 스모크 (session-init.sh) — stdout 격리, stderr 분리
    D0 fixture path 정규화 — (Resolve-Path $fixture).Path -replace '\\','/'
    D1 no-manifest: $env:CLAUDE_PROJECT_DIR=빈 임시 디렉토리 → stdout == "{}" (정확 일치)
    D2 F1: $env:CLAUDE_PROJECT_DIR=sample-project → JSON parse OK
           + hookSpecificOutput.hookEventName == "SessionStart"
           + additionalContext contains "미존재" (phases 미초기화 분기 문자열)
    D3 F2: $env:CLAUDE_PROJECT_DIR=empty-phases → JSON parse OK
           + additionalContext contains "전체 milestone 완료"
    # 호출 방식: & bash $script 2>$errorFile; $stdout = $output (stdin은 $null로 격리)

[E] Statusline 스모크 (statusline.sh)
    E1 no-manifest: stdout 빈 문자열 + exit 0
    E2 F1: stdout == "[harness] phases 미초기화" + exit 0
    E3 F2: stdout == "[harness] stats 모듈 없음" + exit 0

[F] 정보성 출력 (파일이 없어도 FAIL 아님)
    F1 ~/.claude/backup-<ts>/ 디렉토리 열거 (존재 시 [INFO] 수동 삭제 권장)

[G] Runtime-only 수동 확인 체크리스트 (자동화 불가)
    G1 [ ] Claude Code 세션 'What skills are available?' → harness-* 3종 노출
    G2 [ ] /harness-meta 입력 → slash command 인식
    G3 [ ] .mcp.json harness 선언 프로젝트에서 mcp__harness__* deferred tools 노출
    G4 [ ] output-style 'Harness Engineer' 적용 여부
    G5 [ ] CLAUDE.md의 @bootstrap/docs/OWNERSHIP.md 내용 로드
    G6 [ ] 활성 프로젝트 execute.py --doctor 0 FAIL
```

### 출력 포맷

```
[INFO] harness-meta verify starting (MetaRoot=..., Timeout=30s)

== Z. 플랫폼 전제 ==
  [OK]   Z1 Windows (OS detected)
  [OK]   Z2 PowerShell 7.4.x
  [OK]   Z3 MetaRoot 정규화 완료

== A. 환경 전제 ==
  [OK]   A1 Developer Mode ON
  [OK]   A2 MetaRoot 구조 유효
  [OK]   A3 bash / python3 PATH

== B. Symlink 무결성 (17/17 기대 · dynamic) ==
  [OK]   B1 ~/.claude/ 6 카테고리 존재
  [OK]   B2 기대 파일 17개 (commands×7 agents×4 skills×3 output-styles×1 hooks×1 statusline×1)
  [OK]   B3 1:1 대응 완료 (누락 0건)
  [OK]   B4 LinkType=SymbolicLink 17/17 (Junction/ReparsePoint-only 0건)
  [OK]   B5 Target Test-Path 17/17
  [OK]   B6 Target under MetaRoot 17/17
  [OK]   B7 SKILL.md 존재 3/3 skills

== C. settings.json ==
  [OK]   C0 UTF-8 no BOM
  [OK]   C1 JSON parse
  [OK]   C2 statusLine.type
  [OK]   C3 statusLine.command
  [OK]   C4 hooks.SessionStart 배열 (length=N) [WARN if N>1]
  [OK]   C5 matcher=startup
  ...

== D. Hook 스모크 ==
  [OK]   D1 no-manifest → "{}"
  [OK]   D2 F1 → additionalContext "미존재" 포함
  [OK]   D3 F2 → additionalContext "전체 milestone 완료" 포함

== E. Statusline 스모크 ==
  [OK]   E1 no-manifest → 빈 출력
  [OK]   E2 F1 → "[harness] phases 미초기화"
  [OK]   E3 F2 → "[harness] stats 모듈 없음"

== F. 정보성 ==
  [INFO] backup 디렉토리 N개 존재: ~/.claude/backup-20260424-... (수동 삭제 권장)

== G. Runtime-only 수동 확인 체크리스트 ==
  [ ] Claude Code 세션 'What skills are available?' → harness-* 노출
  [ ] /harness-meta 입력 → slash command 인식
  [ ] .mcp.json 프로젝트에서 mcp__harness__* deferred tools
  [ ] output-style 'Harness Engineer' 적용
  [ ] CLAUDE.md의 @bootstrap/docs/OWNERSHIP.md 로드
  [ ] 활성 프로젝트 execute.py --doctor 0 FAIL

== 요약 ==
  Z 3/3, A 3/3, B 7/7, C 10/10, D 3/3, E 3/3 = 29/29 PASS
```

실패 시 해당 체크만 [ERR] 프리픽스 + 세부 메시지. 마지막에 `exit 1`. 전부 PASS → `exit 0`. F는 [INFO]만, G는 사용자 수동 확인 대상 (체크 불가).

## Grey Areas — 결정 (28개 중 사용자 결정분)

| ID | 질문 | 결정 |
|---|---|---|
| G1 | 엔트리포인트 | **(b) 별도 `verify.ps1`** — install.ps1 330L에 100+L 추가하면 유지보수성↓. repo 루트에 배치 |
| G2 | Fixture 위치 | **(a) `tests/fixtures/`** — 신규 디렉토리 도입. bootstrap은 "도입 자산" 성격이라 분리 |
| G3 | Fixture 단계 | **F1 + F2**. F3는 mock `statusline_stats.py` 필요 → S5 경계 침범 |
| G3-sub | Hook/statusline 스모크 깊이 | **6 케이스 전부** (D1–D3, E1–E3) |
| G4 | 설치 전제 | **(a) 설치 전제** — verify 전에 install 실행 유도. symlink 부재 시 "먼저 install.ps1 실행" 안내 후 exit 1 |
| G5 | 출력 포맷 | **(b) 표준 출력 PASS/FAIL 표** — `-Json`은 v1.4 후보 |
| G6 | install.ps1 리팩터 | **(b) 함수 추출** — symlink 속성 체크를 `Test-SymlinkIntegrity` 함수로. install 끝에서도 verify.ps1에서도 호출 |
| G7 | symlink target resolve | **(a)+(b)** — `Test-Path $item.Target` + MetaRoot 하위 여부. 해시 비교는 과설계 |
| G8 | settings.json 깊이 | **(c) 전체 값 검증** — `command / timeout / shell / matcher` 정확 일치. 기대 외 필드는 [WARN]만 |
| G10 | Windows path ↔ bash | **native path 유지** — PS가 fixture 절대경로 그대로 `$env:CLAUDE_PROJECT_DIR`에 설정. bash에서 `[ -f "$CLAUDE_PROJECT_DIR/.harness.toml" ]`가 Windows path 수락 여부를 D1에서 동시 실측 |
| G13 | Timeout | **30s 기본, `-Timeout` 파라미터로 override** |
| G14 | Runtime-only 6항 | **verify 말미에 체크리스트 출력** — 자동화 불가 사실 명시 |
| G18 | `-Verify` + `-Force` 상호작용 | **별 파일이므로 무관** — verify.ps1에 `-Force` 없음 |
| G19 | Symlink 개수 | **MetaRoot 동적 계산** — 17 하드코딩 금지 |
| G23 | Exit code | **exit 1만** — 세부는 표준 출력 |
| G26 | Hook 실행 방식 | **`& bash $script_path`** (PowerShell 호출 연산자 + explicit bash) |
| G27 | skill 디렉토리 내부 | **`SKILL.md` 존재까지 체크** |

### Grey Area — 부수 결정 (묶어서 수렴)

| ID | 결정 |
|---|---|
| G11 | python3 prechecks 재사용 (install.ps1 A3) |
| G12 | 고정 fixture → idempotent. 임시 디렉토리 불채택 |
| G15 | `verify.ps1` 위치 = repo 루트 (`install.ps1` 옆) |
| G16 | fixture read-only (session-init는 read-only 확정) |
| G17 | `-Verify` 버전 호환성 걱정 없음 (항상 최신 로직) |
| G20 | `.gitkeep`는 `harness*` 필터로 자동 제외 |
| G21 | `-MetaRoot` 파라미터 승계 (실행 위치 독립) |
| G22 | `[INFO]/[OK]/[WARN]/[ERR]` 한글 메시지 승계 |
| G24 | CI-friendly `-Json`은 v1.4 후보 |
| G25 | PS 서브프로세스 로컬 변수만 사용 (환경 오염 없음) |
| G28 | fixture `schema_version = "1.0"` 고정 |

### Grey Area — 추가 발견 (v1.3 PLAN 보강)

| ID | 질문 | 결정 |
|---|---|---|
| **G29** | Partial install 감지 (mid-way crash 후 10/17 symlink 상태) | B3 단계에서 기대 파일 enumeration ↔ 실제 symlink 1:1 매칭. 차이 시 누락 목록 출력 |
| **G30** | Foreign hooks 공존 (사용자 `UserPromptSubmit` 등 이미 존재) | C 단계는 `statusLine` + `hooks.SessionStart`만 검증. `hooks.UserPromptSubmit` 등 다른 matcher 완전 무시. `hooks.SessionStart` 배열 길이 >1이면 [WARN] 공존 경고만 (FAIL 아님) |
| **G31** | LinkType == SymbolicLink 엄격 | B4에서 `$item.LinkType -eq 'SymbolicLink'`. Junction은 명시 FAIL. install.ps1도 함께 강화 (함수 추출 시) |
| **G32** | Target이 현재 MetaRoot 하위인지 | B6에서 `$item.Target.StartsWith($MetaRoot + [IO.Path]::DirectorySeparatorChar)` |
| **G33** | settings.json BOM 부재 | C0 첫 3바이트 검사 (`0xEF 0xBB 0xBF` 부재) |
| **G34** | Leftover backup 디렉토리 | F 단계 [INFO] 출력만. FAIL 아님 |
| **G35** | Platform check (Windows 전용) | Z1 `$IsWindows` 가드. 다른 OS는 즉시 exit 1 + "Windows 전용, macOS/Linux는 후속 세션" |
| **G36** | Skill 내부 파일 | `SKILL.md` 존재만 체크. skill별 추가 파일(plan-template/7d-checklist/report-template)은 선택적이라 verify 대상 외 |
| **G37** | Hook stderr 분리 | `& bash $script 2>$tempErr`으로 stdout만 `$output`에 모으기. stdin은 `$null` |
| **G38** | Bash의 Windows path 수신 | D0에서 fixture path `\\` → `/` 변환 후 `$env:CLAUDE_PROJECT_DIR` 설정. 원본 native path와 둘 다 실측 필요 |
| **G40** | `-MetaRoot` 상대경로 | Z3 `Resolve-Path $MetaRoot` 강제 |
| **G42** | `#Requires -Version 7.3` 선언 | verify.ps1 line 1 |

## 성공 기준

- [ ] `verify.ps1` 신규 — `#Requires -Version 7.3` 선언, `$IsWindows` 가드, `Resolve-Path $MetaRoot` 정규화
- [ ] `install.ps1`에서 `Test-SymlinkIntegrity` 함수 추출 — `LinkType='SymbolicLink'` + `Test-Path $Target` + `$Target.StartsWith($MetaRoot)`
- [ ] `install.ps1` lines 167·303이 함수 호출로 교체 (기존 ReparsePoint-only 로직 제거)
- [ ] `tests/fixtures/sample-project/{.harness.toml, scripts/harness/.gitkeep}` 존재
- [ ] `tests/fixtures/empty-phases/{.harness.toml, scripts/harness/.gitkeep, phases/index.json}` 존재
- [ ] `phases/index.json` 내용 = `{"milestones": []}` (JSON parse 통과)
- [ ] `pwsh verify.ps1` 실행 결과: **Z 3/3, A 3/3, B 7/7, C 10/10, D 3/3, E 3/3 = 29/29 PASS** (exit 0) + F [INFO] + G 체크리스트 출력
- [ ] **실패 주입 테스트 1** (수동): symlink 하나 `Remove-Item` 삭제 → B3 FAIL 감지 + 누락 목록 + exit 1
- [ ] **실패 주입 테스트 2** (수동): settings.json에 BOM 추가 (UTF-8 with BOM 변환) → C0 FAIL 감지 + exit 1
- [ ] **실패 주입 테스트 3** (수동): fixture `.harness.toml` 일시 삭제 → D1/E1 no-manifest 분기 진입 확인 (PASS 유지)
- [ ] **Foreign hooks 공존 테스트**: 사용자 실제 settings.json(`UserPromptSubmit` 존재)에서 verify 실행 → C WARN 없음 + 전부 PASS
- [ ] **Bash path 변환 실측**: forward-slash 변환 전/후 D2 실행 결과 비교 (REPORT 첨부)
- [ ] README 트러블슈팅에 `verify.ps1` 1줄 안내
- [ ] CLAUDE.md "명령어" 섹션에 verify 1줄
- [ ] REPORT에 `evidence/verify-output.txt` + `evidence/failure-injection-{1,2,3}.txt` 첨부

## 커밋 전략

단일 커밋 제안 (원자적 논리 단위):

```
feat(meta): sessions/meta/v1.3-install-verify — verify.ps1 + fixtures

- add: verify.ps1 (A–E 5 단계, 25 체크)
- refactor: install.ps1 — symlink 속성 체크를 Test-SymlinkIntegrity 함수로 추출
- add: tests/fixtures/sample-project/ (F1 — .harness.toml + scripts/harness/.gitkeep)
- add: tests/fixtures/empty-phases/ (F2 — + phases/index.json)
- update: README.md 트러블슈팅 + CLAUDE.md 명령어 섹션
- add: sessions/meta/v1.3-install-verify/{PLAN,REPORT,evidence/}

실측: 25/25 PASS (Windows 11, pwsh 7.4). Runtime-only 6항은 체크리스트 출력.
```

사용자 확인 후 커밋.

## 후속 세션 연결

- **직접 연결**: 없음 (v1.3 단독)
- **보류 후보**:
  - `sessions/meta/vX-verify-json-output/` (S3) — `-Json` 플래그 추가 + CI 통합 가이드
  - `sessions/meta/vX-verify-auto-on-install/` (S3) — `install.ps1` 끝에 `-SkipVerify` 없으면 verify 자동 호출
  - `sessions/meta/vX-fixture-f3/` (S3) — F3 fixture 도입 (mock `statusline_stats.py`) + statusline 정상 경로 커버리지
  - `sessions/meta/vX-verify-cross-platform/` (S3) — macOS/Linux 지원 (Developer Mode 체크 skip, symlink 의미 차이 반영)
  - `sessions/meta/vX-bootstrap-templates/` (S2) — 여전히 대기 중 (v1.2 이래 보류)

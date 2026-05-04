# meta v1.23-verify-unification — REPORT

세션 종료: 2026-04-29
선행 세션: [`sessions/meta/v1.22-install-unification/`](../v1.22-install-unification/REPORT.md) — install 흐름 통합. v1.23은 read-only verify 흐름 통합.

## 최종 결과

| 항목 | 수치 |
|------|------|
| Smoke PASS (신규) | smoke-verify-sh-parity 5/5 (정적 + Windows dynamic skip) |
| Smoke PASS (회귀) | smoke-bash-permission-pattern 6/6 + smoke-thinking-effort 5/5 + smoke-language-overlay 11/11 + smoke-legacy-cleanup-overlay 9/9 + smoke-skills-install 9/9 + smoke-sync-agents 5/5 + smoke-scope-contract **44/44** |
| verify.ps1 PASS | 38/38 (Stage H 3 + Stage I 5 신규 추가) |
| 신규 파일 | 5 (`verify.sh`, `verify-lib.sh`, `tests/smoke-verify-sh-parity.sh`, PLAN, REPORT) |
| 수정 파일 | 6 (`verify.ps1`, `tests/smoke-scope-contract.sh`, `bootstrap/docs/PERMISSION_PATTERN.md`, `bootstrap/docs/OVERLAY.md`, `README.md`, `CLAUDE.md`) |
| context7 검증 | C1~C10 spec 정합 (`/websites/code_claude` benchmark 83.6) |

## 구현 요약

### Stage A: `verify-lib.sh` 신설 (R2)

**`verify-lib.sh`** (45 lines):

- `test_symlink_integrity()` 함수 — `Test-SymlinkIntegrity` (ps1) 의미 동등
- python3 `os.path.realpath`로 BSD/GNU readlink 차이 회피 (D2 결정)
- 4 실패 사유: `LinkType=NotASymlink`, `target_not_exist:<t>`, `target_mismatch:<t> (expected:<e>)`, `target_outside_meta:<t> (meta:<m>)`

### Stage B: `verify.sh` 신설 (R1)

**`verify.sh`** (588 lines, executable bit):

- 10 stage Z/A/B/C/D/E/F/H/I/G mirror (R5 순서)
- Z1: `uname -s` Linux/Darwin 매치 → 그 외 ERR + 조기 종료
- Z2: `BASH_VERSINFO[0] -lt 4` 검사
- Z4: `verify-lib.sh` source (A 추가 — `Test-SymlinkIntegrity` 동등 함수 로드)
- A1/A3a: Linux/macOS 자연 권한 → `[INFO] N/A` 정보 출력 (skip)
- C: settings.json 파싱 — python3 우선 → jq fallback → 둘 다 부재 시 SKIP+WARN (R6)
- D/E: hook + statusline smoke (CLAUDE_PROJECT_DIR env로 fixture 주입)
- H1~H3 + I1~I5: ps1과 의미 동등 (R3 + R4)

### Stage C: verify.sh Stage H/I (R3 + R4)

**Stage H (Overlay 무결성)**:

- H1: `bootstrap/templates/<lang>/.claude/` enumerate. `_*` reserved skip + 매트릭스 10 lang 검사
- H2: overlay item `harness-*` prefix convention (`.gitkeep` 제외)
- H3: overlay SKILL.md frontmatter `^name:` + `^description:` 최소 필드

**Stage I (Frontmatter 6축)** — 12 파일 검증:

- I1: V1 — 콜론 없음 패턴 `Bash([a-z][a-z\-]*\*)` 0건
- I2: V5 — auto-allow set declare 0건
- I3: V7 — slash command `^allowed-tools:` 필드 존재
- I4: V8 — single-line 콤마 separator 0건
- I5: V10 — `^thinking:` 잔존 0건

### Stage D: verify.ps1 Stage H/I + 순서 갱신 (R3 + R4 + R5)

**`verify.ps1`** 수정 (Stage H 80 lines + Stage I 90 lines 추가):

- 헤더 docstring 갱신 (8 → 10 stage)
- Stage F 직후 → Stage H (Overlay) → Stage I (Frontmatter 6축) → Stage G 순서
- `Select-String -Pattern -AllMatches` 활용 (regex 매치 카운트)
- `Get-Content -Raw` + multiline regex (`(?m)^name:`) 활용 (frontmatter 검증)

**검증 결과**: `pwsh ./verify.ps1` → **38/38 PASS** (Stage H 3건 + Stage I 5건 추가)

### Stage E: smoke-verify-sh-parity.sh (R7)

**`tests/smoke-verify-sh-parity.sh`** (정적 5 + dynamic 3 = 8 checks):

정적 5:

- S1.1: verify.sh 존재 + executable bit
- S1.2: verify-lib.sh + `test_symlink_integrity()` grep
- S1.3: verify.ps1 Stage H/I 신설 grep
- S1.4: verify.sh Stage H/I mirror grep
- S1.5: stage 순서 Z/A/B/C/D/E/F/H/I/G (sh + ps1 양쪽 line number 단조 증가)

Dynamic 3 (Linux/Darwin + bash 4+ + python3 가용 시만):

- S2.1: verify.sh exit code OK (0 또는 1)
- S2.2: Stage H1 'python' overlay 감지
- S2.3: Stage I1~I5 5건 모두 등장

**Windows 결과**: 5/5 PASS (정적). dynamic 3건은 SKIP (Linux/Darwin 환경 v1.24에서 검증).

### Stage F: 문서 4 cross-ref 갱신 (R8)

- **`bootstrap/docs/PERMISSION_PATTERN.md`** §10: "후속 세션 v1.21 통합" → "v1.23 verify 통합 (Stage I)" 갱신. V1+V5+V7+V8+V10 5건 verify 통합 + V4/V9 dev-time smoke 분리 명시 + context7 검증 인용
- **`bootstrap/docs/OVERLAY.md`** §13: v1.22/v1.23 "예정" → "완료, 2026-04-29" 갱신. v1.23 항목에 Stage H + Stage I 통합 + context7 정합 명시
- **`README.md`** "Verify" §: Windows + macOS/Linux 양쪽 명령 + Stage Z/A/B/C/D/E/F/H/I/G 10건 설명 표
- **`CLAUDE.md`** "명령어" §: 양쪽 OS verify 명령 + v1.23+ Stage H/I 통합 명시

### Stage G: tests/smoke-scope-contract.sh v1.23 glob

`sessions/meta/v1.23*/PLAN.md` glob 1줄 추가. self-test 결과: **44/44 PASS** (v1.23 — Scope inheritance + Out of scope 양쪽 § 검증 PASS).

## 판정

| 성공 기준 | 결과 |
|-----------|------|
| `verify.sh` 존재 + executable bit + Z/A/B/C/D/E/F/H/I/G 10 stage | ✅ |
| `verify-lib.sh` 존재 + `test_symlink_integrity` 함수 | ✅ |
| `verify.ps1` Stage H + I 추가 + 순서 갱신 | ✅ (38/38 PASS) |
| `verify.sh` 본 repo 실행 시 exit 0/1 (segfault 없음) | ✅ (Windows에서는 Z1 거부 — 의도 동작) |
| `smoke-verify-sh-parity.sh` 정적 5 PASS | ✅ (Windows dynamic SKIP) |
| `smoke-scope-contract.sh` v1.23 self-test PASS | ✅ (44/44) |
| 회귀 0 (smoke-bash-permission-pattern, smoke-thinking-effort, smoke-language-overlay, smoke-legacy-cleanup-overlay, smoke-skills-install, smoke-sync-agents) | ✅ |
| 문서 4 cross-ref 정합 | ✅ |
| context7 검증 (`/websites/code_claude` C1~C10) | ✅ |

## Lessons Learned

### L1 — context7로 PERMISSION_PATTERN.md spec 정합 재확인 가치

v1.10d/v1.10g audit은 1차 스냅샷이었고 v1.23은 ~2개월 후. context7 query (C1~C10)로 v1.23 시점 정합 재검증 — 모든 spec이 그대로 유효함을 확인 + 신규 발견 (changelog 2.1.111 `cd && glob` auto-allow 보강 후보, `effort: medium` 가능 등 — Out of scope로 분리). 향후 SKILL/agent spec 변경 시 동일 패턴 (context7 → spec 갱신 세션) 표준화.

### L2 — Cross-platform verify는 lib 함수 분리가 결정적

`Test-SymlinkIntegrity` (ps1) ↔ `test_symlink_integrity` (sh) 함수 동등성으로 mirror drift 차단. 양쪽 verify가 본문에 직접 인라인되면 향후 LinkType 검사 로직 변경 시 한쪽만 갱신할 위험. lib 분리로 단일 source-of-truth (의미 단위) 유지.

### L3 — settings.json 파싱은 python3 우선 + jq fallback + SKIP

도구 의존성 단계화로 환경 이식성 확보. python3는 macOS/Linux 사실상 보편, jq는 일부 minimal 환경 부재 가능. 둘 다 부재 시 SKIP+WARN로 자동화 검증 흐름은 유지하되 C 단계 명확히 분리. 향후 다른 JSON 검증 (.mcp.json 등)에 동일 패턴 재사용.

### L4 — smoke vs verify 책임 분리 정형화

V4 (PERMISSION_PATTERN.md keyword 9개 존재) + V9 (YAML list `^  -` count ≥3 per 파일)는 dev-time meta-check / 파일별 가변 — verify에서 false positive 위험. 두 검증은 smoke 전용 유지. 사용자 install 후 즉시 검증해야 하는 V1/V5/V7/V8/V10만 verify 통합. 향후 신규 spec 추가 시 두 카테고리 (CI smoke vs install verify) 명시 의무.

### L5 — `grep -c` exit code 함정

`grep -cE '...' file 2>/dev/null || echo 0` 패턴 — `grep -c`는 매치 0건일 때 stdout `0` 출력 + exit 1. 따라서 `|| echo 0`이 추가로 0 출력 → "0\n0" 멀티라인 → bash `[: 0\n0: integer expression expected` ERR. 수정: `|| echo 0` 제거 + `${var:-0}` parameter expansion fallback 사용. smoke 작성 시 표준 패턴.

### L6 — Stage 순서 검증 mechanism

`check_order()` helper로 stage 헤더 출현 line number 단조 증가 검증. 정규식은 stage 헤더 패턴(echo "${C_HEAD}== <S>." / Write-Host "== <S>.")만 매치 — `B7. _base...` 등 sub-step 회피. 향후 stage 추가/순서 변경 시 자동 회귀 검증.

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.24-multi-os-validation` | 제3 기기 또는 macOS/Linux CI 환경. verify.sh dynamic 3건 검증 + WSL bash 거동 |
| `v1.10g 확장` | `effort: medium`/`high`/`xhigh` 매트릭스 evidence (현재 xhigh 권고만) |
| `v1.A4-readonly-update-2.1.111` | C8 changelog 보강 (`cd && glob` auto-allow 매트릭스) |
| `v1.B-verify-fix-mode` | verify의 `--fix` 자동 정정 모드 evidence-driven |
| `v1.C-precommit-hook` | pre-commit hook으로 verify 자동 실행 evidence-driven |

## 후속 세션 (예정)

- **v1.24-multi-os-validation** — verify.sh dynamic 3건을 Linux/macOS 또는 WSL bash 환경에서 실 검증. v1.22/v1.23 Windows-only 검증 → cross-platform 종결

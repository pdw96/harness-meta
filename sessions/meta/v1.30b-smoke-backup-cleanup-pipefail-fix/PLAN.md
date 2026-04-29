# meta v1.30b-smoke-backup-cleanup-pipefail-fix — PLAN

세션 시작: 2026-04-30
직접 선행 세션:
- [`sessions/meta/v1.30-backup-cleanup/`](../v1.30-backup-cleanup/) — `tests/smoke-backup-cleanup.sh` 도입 (Test 8 `--list` 회귀 검증). 본 세션이 fix.
- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) — 본 세션 root cause 발견 계기. v1.35 CI run 25120205169 Test 8 FAIL.

목적: `tests/smoke-backup-cleanup.sh` Test 8의 **SIGPIPE (exit 141) Linux CI 비결정성** fix. `grep -q` early-exit가 pipe writer (`bash install-skills.sh --list`)에 SIGPIPE 발생 → smoke의 `set -o pipefail`이 전체 pipeline 실패로 propagate. 수정: `grep -q` → `grep -F ... >/dev/null` (full read, exit code based on match).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(1) `tests/smoke-backup-cleanup.sh` (smoke test) = **1/1 meta**
- **T1 경로 다수결** — meta scope 1/1
- **T3 검증 대상 기준** — smoke test fix는 검증 인프라 영역 (S3)

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.35-scorer-other-na-categories/REPORT.md` "다음 후보" 행 (verbatim, 본 세션 명시 도출)**:

> CI 실패 (smoke-backup-cleanup.sh Test 8) → 별 후속 (`v1.30b-smoke-backup-cleanup-ci-fix` 또는 `v1.36d`) — Ubuntu CI 환경에서 `--list` 비결정성 원인 진단 + smoke 안정화. 본 v1.35 scope 외 (ai-ready-scorer 한정)

**Source 2 — v1.35 CI run 25120205169 로그 (verbatim)**:

> ✗ Test 8 — 회귀: --list 정상 동작
> === 결과: PASS=17 FAIL=1 ===

**Source 3 — 사용자 발의 (2026-04-30) verbatim**:

> "응" — v1.35 REPORT의 후속 별 세션 진행 동의

**Source 4 — 디테일 분석 (본 세션 D1) WSL Linux 재현 결과 (verbatim)**:

> set -euo pipefail && bash install-skills.sh --list 2>&1 | grep -q 'ai-ready-scorer'
> Exit code 141 (SIGPIPE)

**Parsed sub-items (1)**:

1. **`tests/smoke-backup-cleanup.sh` Test 8 SIGPIPE fix** — `grep -q` early-exit → SIGPIPE → pipefail propagation. 수정으로 Linux CI 결정적 PASS 보장.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 smoke 파일의 `grep -q` SIGPIPE 잠재 패턴 audit | 별 후속 (v1.30c 또는 evidence-driven). 본 세션은 Test 8만 |
| `set -o pipefail` 자체 정책 재검토 (smoke 전반) | 별 후속. pipefail은 정상 다른 smoke에서 essential |
| install-skills.sh `--list` 동작 변경 (예: 출력 첫 줄 ai-ready-scorer 보장) | 별 후속. 본 세션은 smoke 측 수정만 (install-skills.sh 변경 0) |
| Windows Git Bash vs Linux SIGPIPE 처리 차이 정책 문서화 | 별 후속 (`bootstrap/docs/SHELL_PORTABILITY.md` 등) |
| CI 환경 디버그 로그 추가 (smoke 일반) | 별 후속. 본 세션은 fix 한정 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/gnu_software_bash_manual_html_node` |
| **topic** | `set -o pipefail` + SIGPIPE 동작 + `grep -q` early-exit |
| **findings** | see citations below |
| **drift** | no — fix는 Bash manual `pipefail` spec 정합 (pipefail은 의도된 동작; SIGPIPE 회피는 사용자 책임) |
| **re-verify** | smoke 추가 시 `grep -q` 패턴 발견 시 재검증 |

**Citations**:
- C1 — Bash manual `set -o pipefail`: "the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully" (Source: `https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html`)
- C2 — POSIX SIGPIPE: pipe writer가 closed pipe에 write 시도 시 SIGPIPE → default exit 141 (128+13). `grep -q` 첫 매치 시 stdin 닫음 → writer SIGPIPE (Source: `https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html`)

## 1. 문제 (CI 비결정성)

### 현재 동작

`tests/smoke-backup-cleanup.sh` line 164-165 Test 8:

```bash
check "Test 8 — 회귀: --list 정상 동작" \
    "bash '$REPO_ROOT/install-skills.sh' --list 2>&1 | grep -q 'ai-ready-scorer'"
```

### Root cause (D1)

1. `install-skills.sh --list` 실행 → 5 라인 stdout 출력 (4 skill names + INFO 헤더)
2. `grep -q 'ai-ready-scorer'` 첫 매치 (라인 2) 후 즉시 stdin 닫음 → 조기 exit
3. `bash install-skills.sh` writer가 추가 라인 stdout 쓰려다 → **SIGPIPE 수신** → exit 141
4. smoke의 `set -o pipefail` (line 27)이 pipeline 어느 element라도 fail 시 전체 pipeline fail로 propagate
5. Test 8 FAIL (exit 141 ≠ 0)

### 환경 비결정성

| 환경 | 동작 |
|------|------|
| Ubuntu Linux CI | 100% FAIL (SIGPIPE 정상 propagate) |
| WSL Linux (HARNESS_META_ROOT 설정) | 100% FAIL (CI 동등) |
| Windows Git Bash | PASS (MSYS의 SIGPIPE 처리 관대 또는 무시) |

→ 로컬 (Windows Git Bash) PASS / CI (Ubuntu) FAIL 비결정성. v1.35 CI run 25120205169 / v1.35 외 어떤 commit이 첫 번째 직격탄인지는 git history audit 후속.

## 2. 결정 (R1)

### R1 — Test 8 grep 호출 패턴 변경

**기존** (line 164-165):
```bash
check "Test 8 — 회귀: --list 정상 동작" \
    "bash '$REPO_ROOT/install-skills.sh' --list 2>&1 | grep -q 'ai-ready-scorer'"
```

**수정**:
```bash
check "Test 8 — 회귀: --list 정상 동작" \
    "bash '$REPO_ROOT/install-skills.sh' --list 2>&1 | grep -F -- 'ai-ready-scorer' >/dev/null"
```

**변경 effect**:
- `grep -F` (literal match, ai-ready-scorer 정확 패턴)
- `--` (option terminator, 안전)
- `>/dev/null` (출력 suppress, `-q` 대체)
- **`grep` (without -q): 모든 stdin 읽기 후 exit** → writer SIGPIPE 회피
- 매치 발견 시 exit 0 / 매치 없으면 exit 1 (의도 정합)

**WSL 검증** (D1 재현 후 fix 검증):
```
set -euo pipefail && bash install-skills.sh --list 2>&1 | grep -F -- 'ai-ready-scorer' >/dev/null
OK_EXIT=0
```

### R2 — 다른 smoke `grep -q` audit (Out of scope, 후속 분기)

본 세션은 Test 8 한정 fix. `tests/smoke-*.sh` 전반의 `grep -q` 패턴 SIGPIPE 잠재성 audit은 별 후속 (`v1.30c-smokes-pipefail-audit` 등). 임계: evidence 1+ 추가 발견 시.

## 3. 변경 대상 (1 수정 + 2 신규)

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-backup-cleanup.sh` | S3 | line 164-165 — `grep -q` → `grep -F -- ... >/dev/null` |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.30b-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.30b-.../REPORT.md` | meta | Stage F 종료 |

## 4. 목표

- [x] 디테일 분석 D1 — WSL Linux 재현 + SIGPIPE root cause 확정
- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `tests/smoke-backup-cleanup.sh` Test 8 fix
- [ ] Stage B — WSL Linux 재실행 → PASS=18/FAIL=0 검증
- [ ] Stage C — Windows Git Bash 재실행 → 회귀 0 검증
- [ ] Stage D — REPORT.md 작성
- [ ] Stage E — 커밋 + push + CI 재확인 (gh run watch)

## 5. 성공 기준

- [ ] `tests/smoke-backup-cleanup.sh` Test 8 SIGPIPE 회피
- [ ] WSL Linux PASS=18/FAIL=0 (CI 동등 환경)
- [ ] Windows Git Bash 회귀 0 (PASS=18/FAIL=0 유지)
- [ ] CI run (Ubuntu Linux) 결과 PASS (모든 smoke 통과)
- [ ] install-skills.sh / install-skills.ps1 변경 0 (smoke 측 수정만)

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.30b-smoke-backup-cleanup-pipefail-fix — SIGPIPE 회피

- update: tests/smoke-backup-cleanup.sh Test 8 — grep -q → grep -F ... >/dev/null
- add: sessions/meta/v1.30b-.../{PLAN,REPORT}.md

Root cause: grep -q 첫 매치 후 stdin 닫음 → bash install-skills.sh writer SIGPIPE → 
smoke `set -o pipefail`이 전체 pipeline 실패로 propagate.

환경 비결정성: Ubuntu Linux CI 100% FAIL / Windows Git Bash PASS (MSYS SIGPIPE 처리 관대).
검증: WSL Linux 재현 환경에서 fix 후 PASS=18/FAIL=0 (CI 동등).

References: GNU Bash manual `pipefail` + POSIX SIGPIPE spec.
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.30c-smokes-pipefail-audit` | 다른 smoke 파일의 `grep -q` SIGPIPE 잠재 패턴 evidence 1+ 추가 발견 시 |
| `bootstrap/docs/SHELL_PORTABILITY.md` 신설 | Windows Git Bash vs Linux/macOS SIGPIPE 처리 차이 등 portability 정책 단일 소스. evidence 누적 시 |

## 8. Lessons Forward (예상)

- **L1 — `grep -q` SIGPIPE의 pipefail 환경 비결정성**: 짧은 stdin 출력 (몇 라인) → race condition 발생 안 할 수도 있음. 출력이 충분히 길어 `grep -q` 매치 후에도 writer가 더 쓸 게 있을 때만 SIGPIPE 발생. install-skills.sh --list 4 라인은 임계 — 환경별 처리 차이로 가시화.
- **L2 — Windows Git Bash vs Linux의 SIGPIPE 처리 차이**: MSYS/MinGW는 SIGPIPE 무시 또는 관대 처리 → 동일 코드 Linux 100% FAIL / Windows PASS. cross-platform smoke 개발 시 Linux/CI에서 검증 의무.
- **L3 — 디테일 분석 단계의 가치 (D1)**: PLAN 작성 전 WSL 재현으로 SIGPIPE 발견 → fix 정확 단일. 디테일 분석 없이 바로 코드 수정 진입했다면 다른 fix 시도 (예: `set +o pipefail` 또는 `|| true`) — root cause 미해결.
- **L4 — `grep -q` vs `grep ... >/dev/null` trade-off**: `-q` early-exit 효율적이지만 SIGPIPE risk. `grep ... >/dev/null` (full read)은 SIGPIPE-safe. smoke처럼 작은 stdin은 후자 권장.

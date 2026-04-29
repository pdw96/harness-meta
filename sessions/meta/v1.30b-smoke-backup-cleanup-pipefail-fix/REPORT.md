# meta v1.30b-smoke-backup-cleanup-pipefail-fix — REPORT

세션 종료: 2026-04-30
선행 세션:
- [`sessions/meta/v1.30-backup-cleanup/`](../v1.30-backup-cleanup/) — 본 fix 대상 smoke 도입
- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) — CI 실패 발견 계기 (run 25120205169)

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `tests/smoke-backup-cleanup.sh` (1줄 — Test 8) |
| install-skills.{sh,ps1} 변경 | **0** (smoke 측 수정만) |
| WSL Linux (CI 동등) | PASS=18/FAIL=0 (이전 PASS=17/FAIL=1) |
| Windows Git Bash | PASS=18/FAIL=0 (회귀 0) |
| Root cause | SIGPIPE — `grep -q` early-exit + `set -o pipefail` propagation |

## 구현 요약

### Stage A — Test 8 fix (`tests/smoke-backup-cleanup.sh`)

```diff
  # Test 8: 회귀 — --list 변경 무
+ # v1.30b: grep -q 대신 grep ... >/dev/null (SIGPIPE 회피, set -o pipefail 환경 결정성)
  check "Test 8 — 회귀: --list 정상 동작" \
-     "bash '$REPO_ROOT/install-skills.sh' --list 2>&1 | grep -q 'ai-ready-scorer'"
+     "bash '$REPO_ROOT/install-skills.sh' --list 2>&1 | grep -F -- 'ai-ready-scorer' >/dev/null"
```

**변경 effect**:
- `grep -F` (literal match, 안전)
- `--` (option terminator)
- `>/dev/null` (`-q` 대체)
- **`grep` (without `-q`): 모든 stdin 읽기 후 exit** → writer SIGPIPE 회피

### Stage B — WSL Linux 재실행 (CI 동등 환경)

```
PASS=18 FAIL=0
```

### Stage C — Windows Git Bash 회귀 검증

```
PASS=18 FAIL=0
```

## 디테일 검증 (D1 root cause 분석)

### A. SIGPIPE 메커니즘

1. `bash install-skills.sh --list` → 5 라인 stdout 출력:
   ```
   [INFO] Available skills in /path/...:
     - ai-ready-scorer
     - developer-profile
     - harness-plan-verify
     - mindvault
   ```
2. `grep -q 'ai-ready-scorer'` 라인 2 매치 → **즉시 stdin 닫음 + exit 0**
3. bash writer가 라인 3+ 쓰려다 → **SIGPIPE (signal 13) 수신** → exit 141 (128+13)
4. smoke의 `set -o pipefail` (line 27) → pipeline 어느 element라도 fail 시 전체 fail
5. Test 8 FAIL

### B. 환경 비결정성 (재현 매트릭스)

| 환경 | 동작 |
|------|------|
| Ubuntu Linux CI | 100% FAIL (SIGPIPE 정상 propagate) |
| WSL Linux (HARNESS_META_ROOT 설정) | 100% FAIL (CI 동등) |
| Windows Git Bash | PASS (MSYS의 SIGPIPE 처리 관대 또는 무시) |

### C. fix 검증

```bash
# WSL Linux, set -euo pipefail
bash install-skills.sh --list 2>&1 | grep -F -- 'ai-ready-scorer' >/dev/null
echo $?  # 0 (이전: 141)
```

`grep` (without `-q`)은 모든 stdin 읽고 exit code만 매치 여부로 결정 → SIGPIPE 회피.

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| `tests/smoke-backup-cleanup.sh` Test 8 SIGPIPE 회피 | ✅ |
| WSL Linux PASS=18/FAIL=0 (CI 동등 환경) | ✅ |
| Windows Git Bash 회귀 0 (PASS=18/FAIL=0 유지) | ✅ |
| install-skills.sh / install-skills.ps1 변경 0 | ✅ |
| CI run (Ubuntu Linux) PASS — 사후 검증 | (Stage E 커밋+push 후 확인 의무) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/gnu_software_bash_manual_html_node` |
| **topic** | `set -o pipefail` + SIGPIPE 동작 + `grep -q` early-exit |
| **findings** | no new findings |
| **drift** | no — fix는 Bash manual `pipefail` spec 정합 (pipefail은 의도된 동작; SIGPIPE 회피는 사용자 책임). 구현 중 신규 spec drift 없음 |
| **re-verify** | smoke 추가 시 `grep -q` 패턴 발견 시 재검증 |

**Citations**:
- C1 — Bash manual `set -o pipefail`: pipeline의 return value는 첫 fail element의 exit code (Source: `https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html`)
- C2 — POSIX SIGPIPE: pipe writer가 closed pipe에 write 시 SIGPIPE → exit 141. `grep -q` 첫 매치 시 stdin 닫음 → writer SIGPIPE (Source: `https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html`)

## Lessons Learned

- **L1 — `grep -q` SIGPIPE의 pipefail 환경 비결정성** ⭐: 짧은 stdin (4 라인) 출력에서도 race condition 발생 가능. install-skills.sh `--list`는 grep -q 매치 후에도 더 쓸 라인 있음 → 환경별 처리 차이로 가시화. cross-platform smoke는 Linux/CI에서 결정적 검증 의무.

- **L2 — Windows Git Bash vs Linux SIGPIPE 처리 차이**: MSYS/MinGW는 SIGPIPE 무시 또는 관대 처리 → 동일 코드 Linux 100% FAIL / Windows PASS. 본 v1.30 도입 시 로컬 (Windows) PASS만 검증 → CI에서 첫 발견. v1.20 (도입 직후) CI는 우연 PASS — Test 8 race 비결정성. v1.18g run failure는 다른 smoke (verify-sh-parity), 본 Test 8 fail은 v1.30 도입 이후 잠재 재발 가능했음.

- **L3 — 디테일 분석 단계의 가치 (D1)** ⭐: WSL 재현 환경에서 `bash --list 2>&1 | grep -q` 직접 실행 → exit 141 SIGPIPE 즉시 발견. fix 단순 (1줄). 디테일 분석 없이 바로 시도했다면 다른 fix (`set +o pipefail`, `|| true`, retry loop 등) — root cause 미해결.

- **L4 — `grep -q` vs `grep ... >/dev/null` trade-off**: `-q` 효율적 (early-exit 시 입력 short-circuit) but SIGPIPE risk in pipefail. `grep ... >/dev/null` (full read) SIGPIPE-safe but 입력 끝까지 읽음. **smoke처럼 작은 stdin (수십 라인 이하)** = 후자 권장.

- **L5 — install-skills.sh 변경 0 = 책임 분리**: 본 세션은 smoke 측 fix만. install-skills.sh `--list` 출력은 정상 (의도된 다중 라인). smoke의 grep 사용 패턴이 SIGPIPE-unsafe였던 것이 진짜 원인. 책임 라인 정확.

## 다음 후보 (보류 — 후속 분기)

| 항목 | 조건 |
|------|------|
| `v1.30c-smokes-pipefail-audit` | 다른 smoke 파일의 `grep -q` SIGPIPE 잠재 패턴 evidence 1+ 추가 발견 시 |
| `bootstrap/docs/SHELL_PORTABILITY.md` 신설 | Windows Git Bash vs Linux/macOS SIGPIPE 처리 차이 등 portability 정책 단일 소스. evidence 누적 시 |
| **`v1.18g2-helper-threshold-revisit`** | v1.35 D1 부수 발견 — helper 4 조건 #4 임계 5 재검토 (build_sources >= 5 시 helper=False, harness-meta 92→90 회귀 미해결) |

# meta v1.23b-sh-executable-bit-fix — REPORT

세션 종료: 2026-04-30
선행 세션:
- [`sessions/meta/v1.23-verify-unification/`](../v1.23-verify-unification/) — verify.sh + verify-lib.sh + smoke-verify-sh-parity.sh 도입
- [`sessions/meta/v1.30b-smoke-backup-cleanup-pipefail-fix/`](../v1.30b-smoke-backup-cleanup-pipefail-fix/) — 직전 fix 후 두 번째 잠재 fail 노출 (CI run 25120749345)

## 최종 결과

| 항목 | 결과 |
|------|------|
| Mode 변경 파일 | **12** (.sh 파일) |
| 파일 콘텐츠 변경 | **0** (mode bit만) |
| WSL Linux smoke-verify-sh-parity | 8/8 PASS (dynamic 포함) |
| Windows Git Bash | 5/5 PASS (dynamic SKIP — Linux 전용) |
| Root cause | Windows checkout `core.fileMode = false` default → 100644 mode commit |

## 구현 요약

### Stage A — `git update-index --chmod=+x` 일괄 (12 파일)

```
verify.sh                                         100644 → 100755
verify-lib.sh                                     100644 → 100755
install-skills.sh                                 100644 → 100755
sync-agents.sh                                    100644 → 100755
tests/integration/test-install-guards.sh          100644 → 100755
tests/integration/test-session-init-branches.sh   100644 → 100755
tests/integration/test-statusline-timeout.sh      100644 → 100755
tests/smoke-backup-cleanup.sh                     100644 → 100755
tests/smoke-legacy-cleanup-overlay.sh             100644 → 100755
tests/smoke-skills-install.sh                     100644 → 100755
tests/smoke-spec-verification.sh                  100644 → 100755
tests/smoke-sync-agents.sh                        100644 → 100755
```

### Stage B — WSL Linux 검증

```
=== Stage 1 — 정적 5 checks ===
  [OK] S1.1 verify.sh 존재 + executable bit
  [OK] S1.2 verify-lib.sh + test_symlink_integrity()
  [OK] S1.3 verify.ps1 Stage H/I 신설
  [OK] S1.4 verify.sh Stage H/I mirror
  [OK] S1.5 stage 순서 Z/A/B/C/D/E/F/H/I/G (sh + ps1)

=== Stage 2 — Dynamic 3 checks ===
  [OK] S2.1 verify.sh exit code OK (1)
  [OK] S2.2 Stage H1 overlay enumerate (python 감지)
  [OK] S2.3 Stage I1~I5 모두 등장 (5 line)

PASS — 8/8
```

⚠️ WSL `/mnt/c/` mount는 NTFS-9P fallback으로 모든 파일 0777 표시 → exec bit 자체가 항상 +x. 실 CI 검증은 Linux native checkout 후 수행. git update-index 적용은 정확 (mode 100755 stamp 확인).

### Stage C — Windows Git Bash 회귀 0

```
PASS — 5/5
```

dynamic 3 SKIP (Linux/macOS 전용 — MINGW64 fallback 정상).

## 디테일 검증 (D1)

### A. git mode 변경 검증

```
$ git ls-files -s verify.sh
100755 c59fe9dffac9dd48a79b9f9f43ec3ae74583f999 0	verify.sh
```

12 파일 모두 100755 stamped. 콘텐츠 hash 변경 0 (mode bit만 변경).

### B. 환경별 영향

| 환경 | 영향 |
|------|------|
| Ubuntu Linux CI | 100644 → 100755 stamp 후 `chmod +x` 자동 (checkout 시) → S1.1 PASS |
| Linux/macOS 로컬 | 동상 — git checkout 시 +x 자동 부여 |
| Windows Git Bash | NTFS exec bit 무관 — mode 변경 영향 0 |
| WSL `/mnt/c/` | drvfs/9P 0777 default — mode 변경 영향 0 (이미 +x) |

→ 본 fix는 **Linux/macOS native checkout 환경**에서만 효과. CI (Ubuntu)에서 첫 결정적 검증.

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| 12 .sh 파일 git mode 100644 → 100755 | ✅ |
| WSL Linux smoke-verify-sh-parity PASS | ✅ (단 NTFS-9P 한계로 진짜 +x 검증은 CI에서) |
| Windows Git Bash 회귀 0 | ✅ (5/5 PASS) |
| 파일 콘텐츠 변경 0 (mode bit만) | ✅ |
| CI run (Ubuntu Linux) smoke-verify-sh-parity PASS | (Stage D push 후 사후 검증) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — git mode bit 변경은 외부 spec 의존 무 (git 표준 100644/100755). 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — Windows checkout `core.fileMode = false` default의 누적 영향** ⭐: v1.23+ 신규 .sh 파일 12개가 모두 100644 mode commit. 환경별 동작 차이로 가시화 늦춤 (Linux CI에서 `[ -x ]` 체크 시 첫 노출). cross-platform repo는 신규 .sh 추가 시 git mode 명시 검증 의무.

- **L2 — WSL `/mnt/c/` drvfs의 0777 fallback의 검증 한계**: WSL에서 Windows mount 디렉토리는 모든 파일 0777로 표시 → 실 chmod 테스트 부적합. cross-platform CI 검증은 Linux native checkout (Docker / 별 instance) 또는 직접 CI 실행 필요. WSL은 Linux 동작 시뮬레이션의 70% 정도만 cover (이번 case는 70% 외).

- **L3 — `git update-index --chmod=+x`의 retroactive 한계**: 이미 100644로 commit된 파일은 모든 contributor가 신규 commit으로 100755 stamp 의무. v1.23+ 12 파일은 본 세션 일괄 fix. v1.23+ 신규 .sh 추가는 반드시 적절한 mode로 commit (Windows 사용자 주의).

- **L4 — Scope contract 분할 패턴 (v1.30b → v1.23b)** ⭐: v1.30b가 Test 8 SIGPIPE fix만 다루고 push → CI에서 새 fail (S1.1 verify.sh -x) 노출 → v1.23b로 분리. 포괄 fix 회피 = scope discipline. 각 세션 1 책임 라인.

## 다음 후보 (보류 — 후속 분기)

| 항목 | 조건 |
|------|------|
| `bootstrap/docs/SHELL_PORTABILITY.md` 신설 | core.fileMode + Windows checkout + WSL drvfs 정책 단일 소스. evidence 누적 |
| pre-commit hook으로 신규 .sh 자동 +x | 재발 1+ 시 |
| `.gitattributes` 보강 (`*.sh diff=bash`) | 별 후속 evidence-driven |
| **`v1.18g2-helper-threshold-revisit`** | v1.35 D1 부수 발견 — helper 4 조건 #4 임계 5 재검토 (continued from v1.35) |

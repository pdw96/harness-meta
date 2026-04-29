# meta v1.23b-sh-executable-bit-fix — PLAN

세션 시작: 2026-04-30
직접 선행 세션:
- [`sessions/meta/v1.23-verify-unification/`](../v1.23-verify-unification/) — `verify.sh` + `verify-lib.sh` 도입 + `tests/smoke-verify-sh-parity.sh` 도입. 본 세션이 executable bit 누락 fix.
- [`sessions/meta/v1.30b-smoke-backup-cleanup-pipefail-fix/`](../v1.30b-smoke-backup-cleanup-pipefail-fix/) — 직전 세션. CI 첫 fix 후 두 번째 잠재 fail 노출.

목적: v1.23+에서 추가된 10개 `.sh` 파일의 git mode 100644 → 100755 (`+x` bit) 일괄 fix. Windows checkout 한계로 executable bit 누락 → Linux CI에서 `[ -x file ]` 체크 fail. `tests/smoke-verify-sh-parity.sh` Stage S1.1 fail 해결.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(10) `.sh` 파일 git mode 변경 (verify.sh / verify-lib.sh / install-skills.sh / sync-agents.sh / 6 tests/) = **10/10 meta**
- **T1 경로 다수결** — meta scope 10/10
- **T3 검증 대상 기준** — CI 환경 검증 인프라 fix

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — v1.30b CI run 25120749345 로그 (verbatim)**:

> [FAIL] S1.1 verify.sh 부재 또는 non-executable
> FAIL — 7/8 (1 fail)
> ##[error]FAIL — tests/smoke-verify-sh-parity.sh

**Source 2 — `tests/smoke-verify-sh-parity.sh` Stage S1.1 (verbatim)**:

> if [ -f verify.sh ] && [ -x verify.sh ]; then
>     ok "S1.1 verify.sh 존재 + executable bit"
> else
>     fail "S1.1 verify.sh 부재 또는 non-executable"
> fi

**Source 3 — 디테일 분석 (본 세션 D1) git ls-files 결과 (verbatim)**:

> 100644 c59fe9dffac9dd48a79b9f9f43ec3ae74583f999 0	verify.sh
> 100644 6205b61c267ae180f4b33a1937f7b2d48dc3c62d 0	verify-lib.sh

**Source 4 — 사용자 진행 동의 (2026-04-30, v1.30b 후속)**:

> "응" 다음 "푸시 후 ci 진행 gh로 확인" — CI green 목표 명시

**Parsed sub-items (1)**:

1. **10 `.sh` 파일 mode 100644 → 100755 (`+x` bit)** — `git update-index --chmod=+x` 일괄 적용. CI Linux 환경에서 `[ -x ... ]` 체크 통과.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `core.fileMode` git config 설정 권장 README 문서화 | 별 후속 (`bootstrap/docs/SHELL_PORTABILITY.md` 신설 시 흡수) |
| `.gitattributes` `* eol=lf` 또는 `*.sh diff=bash` 추가 | 별 후속 evidence-driven |
| pre-commit hook으로 `.sh` 신규 추가 시 자동 +x 강제 | 별 후속. 현 v1.23b는 누락분 retroactive fix만 |
| Windows checkout 시 `core.fileMode = false` 자동 안내 | 별 후속 (사용자 발의 필요) |
| 셸 스크립트 자체 코드 변경 | scope 외. mode bit만 변경 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — git mode bit 변경은 외부 spec 의존 무 (git 표준 100644/100755). |
| **re-verify** | N/A |

## 1. 문제 (executable bit 누락)

### 영향 받는 10 파일

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

⚠️ 12 파일 (위 10 + tests/smoke-spec-verification.sh + tests/smoke-sync-agents.sh) — 정밀 재카운트 후 R1에서 결정.

### Root cause

- Windows에서 commit한 파일은 git mode 100644 (default — `core.fileMode = false`)
- Linux/macOS checkout 시 `chmod +x` 안 됨
- `[ -x file ]` 체크 fail (S1.1 등)
- `bash file` 호출은 작동 (Linux/macOS), 그러나 `./file` 또는 `[ -x ]` 체크는 fail

### 환경 비결정성

| 환경 | 동작 |
|------|------|
| Ubuntu Linux CI | `[ -x verify.sh ]` False → S1.1 FAIL |
| Windows Git Bash | `[ -x verify.sh ]` 파일 시스템 의존 (NTFS exec bit 무) — smoke 자체 실행 안 시도 |
| Linux/macOS 로컬 (수동 chmod 한 경우) | True |

→ 본 fix로 git mode 100755 영구 stamp → 모든 환경 일관.

## 2. 결정 (R1)

### R1 — `git update-index --chmod=+x` 일괄 적용

```bash
git update-index --chmod=+x \
    verify.sh verify-lib.sh \
    install-skills.sh sync-agents.sh \
    tests/integration/test-install-guards.sh \
    tests/integration/test-session-init-branches.sh \
    tests/integration/test-statusline-timeout.sh \
    tests/smoke-backup-cleanup.sh \
    tests/smoke-legacy-cleanup-overlay.sh \
    tests/smoke-skills-install.sh \
    tests/smoke-spec-verification.sh \
    tests/smoke-sync-agents.sh
```

**12 파일** mode 100644 → 100755. 파일 콘텐츠 변경 0 (mode bit만).

### R2 — 검증 (Linux/Windows 양쪽)

- WSL Linux: `bash tests/smoke-verify-sh-parity.sh` → S1.1 PASS 확인
- Windows Git Bash: 회귀 0 (file mode change는 NTFS에 영향 없음)

## 3. 변경 대상 (12 mode + 2 신규)

### Mode 변경 (12)

| 경로 | 이전 → 이후 |
|------|------|
| `verify.sh` | 100644 → 100755 |
| `verify-lib.sh` | 100644 → 100755 |
| `install-skills.sh` | 100644 → 100755 |
| `sync-agents.sh` | 100644 → 100755 |
| `tests/integration/test-install-guards.sh` | 100644 → 100755 |
| `tests/integration/test-session-init-branches.sh` | 100644 → 100755 |
| `tests/integration/test-statusline-timeout.sh` | 100644 → 100755 |
| `tests/smoke-backup-cleanup.sh` | 100644 → 100755 |
| `tests/smoke-legacy-cleanup-overlay.sh` | 100644 → 100755 |
| `tests/smoke-skills-install.sh` | 100644 → 100755 |
| `tests/smoke-spec-verification.sh` | 100644 → 100755 |
| `tests/smoke-sync-agents.sh` | 100644 → 100755 |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.23b-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.23b-.../REPORT.md` | meta | Stage E 종료 |

## 4. 목표

- [x] 디테일 분석 D1 — git ls-files로 12 mode 100644 파일 식별
- [x] 세션 디렉토리 + PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `git update-index --chmod=+x` 12 파일 일괄
- [ ] Stage B — WSL Linux smoke 검증 (smoke-verify-sh-parity Stage S1.1 PASS)
- [ ] Stage C — REPORT.md
- [ ] Stage D — 커밋 + push + CI 재확인

## 5. 성공 기준

- [ ] 12 .sh 파일 git mode 100644 → 100755
- [ ] WSL Linux: `tests/smoke-verify-sh-parity.sh` 모든 Stage PASS
- [ ] WSL Linux: 다른 smoke (특히 backup-cleanup) 회귀 0
- [ ] Windows Git Bash: 회귀 0 (mode bit는 NTFS에 영향 없음)
- [ ] CI run (Ubuntu Linux): smoke-verify-sh-parity PASS + 모든 smoke PASS
- [ ] 파일 콘텐츠 변경 0 (mode bit만)

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.23b-sh-executable-bit-fix — 12 .sh 파일 +x bit

- chmod +x: verify.sh, verify-lib.sh, install-skills.sh, sync-agents.sh,
            tests/integration/*.sh (3), tests/smoke-{backup-cleanup,legacy-cleanup-overlay,
            skills-install,spec-verification,sync-agents}.sh
- add: sessions/meta/v1.23b-.../{PLAN,REPORT}.md

Root cause: Windows checkout default core.fileMode = false → 100644 mode commit.
Linux CI에서 [ -x file ] 체크 fail (smoke-verify-sh-parity Stage S1.1).
v1.23+ 신규 .sh 파일 retroactive fix.

검증: WSL Linux smoke-verify-sh-parity 모든 Stage PASS + 회귀 0.
파일 콘텐츠 변경 0 (mode bit만).
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `bootstrap/docs/SHELL_PORTABILITY.md` 신설 | core.fileMode + Windows checkout 정책 단일 소스 |
| pre-commit hook으로 신규 .sh 자동 +x | evidence 누적 (재발 1+ 시) |
| `.gitattributes` 보강 | `*.sh diff=bash`, `* eol=lf` |

# meta v1.64-precommit-autofix — PLAN

세션 시작: 2026-05-04
직접 선행 세션:
- [`sessions/meta/v1.39-precommit-hook/`](../v1.39-precommit-hook/PLAN.md) — pre-commit local hooks 도입
- [`sessions/meta/v1.63-fix-field-name-rename/`](../v1.63-fix-field-name-rename/PLAN.md) — 직전 --fix 시리즈

목적: pre-commit hook 실패 시 smoke `--fix` 자동 시도 + 변경 안내 후 abort. 사용자는 `git diff`로 변경 검토 후 re-stage + re-commit.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(2) `tests/precommit-autofix-or-fail.sh` (신규) + `.pre-commit-config.yaml` = **2/2 meta**
- **T1 경로 다수결** — S3 단독
- **T2 스펙 vs 값** — pre-commit hook 자동화 mechanism = 글로벌 정책

## Scope inheritance (verbatim from 선행 세션)

**Source — ROADMAP §3-A `v1.39c-fix-autofix` (verbatim)**:

> `v1.39c-fix-autofix` — smoke 실패 시 pre-commit hook 내 `--fix` 자동 실행 수요 | `v1.39 REPORT`

**Parsed sub-items (3)**:

1. **wrapper script 신설** — `tests/precommit-autofix-or-fail.sh` 범용 (smoke path 인자)
2. **`.pre-commit-config.yaml` 갱신** — 기존 2 hook (smoke-spec-verification + smoke-scope-contract) `entry`를 wrapper 호출로 변경
3. **safe abort 패턴** — --fix 후 exit 1 → 사용자 `git diff` 검토 → `git add` 재스테이징 → 재커밋

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 새 pre-commit hook 추가 (smoke-bash-permission-pattern / smoke-thinking-effort / smoke-broad-bash-fine-grain) | 후속 미정 — wrapper는 범용이므로 entry 추가만 하면 가능. evidence 누적 후 |
| 자동 re-stage (git add) | 본 세션 정책 — 사용자 검토 단계 보존 |
| --fix 실패 시 fallback (다른 정정 메커니즘) | 후속 미정 — 현재 anchor 부재 등은 사용자 수동 작성 의무 |
| dry-run 모드 (--fix 적용 전 plan 먼저) | 후속 미정 — 현재 wrapper는 단순 실행, dry-run 옵션 추가 시 복잡도 증가 |
| `--no-fix` opt-out 환경변수 | 후속 미정 — 사용자 evidence 부재 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — pre-commit framework 표준 사용 (entry: bash ...). spec 신규 의존 없음 |
| **re-verify** | N/A |

## 배경

`v1.39-precommit-hook`에서 smoke-spec-verification + smoke-scope-contract 2 hook 도입. 현재 smoke 실패 시:
1. pre-commit이 commit abort
2. 사용자가 수동으로 `bash tests/smoke-X.sh --fix` 실행
3. 변경 검토 후 재스테이징 + 재커밋

v1.60~v1.63에서 추가 4 smoke (`bash-permission-pattern`, `thinking-effort`, `broad-bash-fine-grain`)에 `--fix` mode 누적. **자동화 가치 임계 도달** — 매 commit 실패 시 수동 명령 입력 비용 누적.

본 v1.64는 pre-commit hook 내부에서 자동으로 `--fix` 시도 → 사용자는 `git diff`만 검토 → 자연 재커밋 흐름.

## 구현 설계

### 1. Wrapper script — `tests/precommit-autofix-or-fail.sh`

```bash
#!/usr/bin/env bash
# pre-commit wrapper: run smoke; if fail, attempt --fix; abort with review instruction.
# v1.64 — safe abort pattern (user reviews diff before re-commit).
set -uo pipefail

SMOKE="${1:?Usage: $0 <smoke-script-path>}"

# 1. 정상 실행 (no modifications)
if bash "$SMOKE"; then
    exit 0
fi

# 2. 실패 → --fix 시도
echo ""
echo "=== smoke FAIL: $SMOKE — attempting --fix ==="
fix_rc=0
bash "$SMOKE" --fix || fix_rc=$?

# 3. 변경 안내 + abort
echo ""
echo "=== --fix attempted (rc=$fix_rc). Please review changes:"
echo "    git diff"
echo ""
echo "=== If changes look correct, re-stage and re-commit:"
echo "    git add -u"
echo "    git commit"
echo ""
echo "=== If --fix did not resolve violations, manual edit required."
exit 1
```

### 2. `.pre-commit-config.yaml` 갱신

기존:
```yaml
- id: smoke-spec-verification
  entry: bash tests/smoke-spec-verification.sh
- id: smoke-scope-contract
  entry: bash tests/smoke-scope-contract.sh
```

변경:
```yaml
- id: smoke-spec-verification
  entry: bash tests/precommit-autofix-or-fail.sh tests/smoke-spec-verification.sh
- id: smoke-scope-contract
  entry: bash tests/precommit-autofix-or-fail.sh tests/smoke-scope-contract.sh
```

### 3. 흐름 다이어그램

```
git commit
  ↓
pre-commit
  ↓
┌─ smoke-spec-verification ──┐
│ wrapper                    │
│   ↓                        │
│  bash smoke (no args)      │
│   ↓                        │
│  PASS? → exit 0 (continue) │
│  FAIL?                     │
│    ↓                       │
│   bash smoke --fix         │
│   echo "review git diff"   │
│   exit 1                   │
└────────────────────────────┘
  ↓ (실패 시)
commit abort
  ↓
사용자: git diff (검토) → git add -u → git commit (재시도)
```

### 4. 안전성 분석

- **Safe abort pattern**: --fix가 파일을 수정하지만 staged 영역에는 영향 0 (working tree만). 사용자가 `git add` 명시 호출까지는 commit에 포함 안 됨
- **자동 modify의 가시성**: 사용자가 `git diff`로 변경 확인. 의도 외 변경 시 `git checkout` 또는 `git restore`로 폐기 가능
- **--fix 실패 시 (anchor 부재 등)**: wrapper가 명시적 메시지로 manual fix 안내. exit 1로 commit 중단
- **idempotent**: --fix가 이미 정정된 파일에 추가 변경 없음 (모든 smoke --fix가 idempotent 보장)

### 5. README 갱신 (선택, F2)

`README.md` pre-commit 안내에 자동 --fix 동작 1줄 추가.

## 목표

- [ ] 세션 디렉토리 + PLAN.md 작성 ✅
- [ ] Stage A — `tests/precommit-autofix-or-fail.sh` 신규 작성 + executable
- [ ] Stage B — `.pre-commit-config.yaml` 2 entry wrapper 경유로 변경
- [ ] Stage C — README.md 자동 --fix 동작 안내 추가 (1~2줄)
- [ ] Stage D — 검증: 기존 smoke PASS 상태에서 wrapper 호출 → exit 0 (정상)
- [ ] Stage E — E2E: violation 주입 → wrapper 호출 → --fix 적용 + exit 1 + 안내 출력 → 복원 후 재커밋 시뮬레이션
- [ ] REPORT.md 작성

## 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `tests/precommit-autofix-or-fail.sh` | S3 | 신규 — pre-commit wrapper script |
| `.pre-commit-config.yaml` | S3 | 2 entry (smoke-spec-verification, smoke-scope-contract) wrapper 경유 |
| `README.md` | S3 | pre-commit 자동 --fix 동작 1~2줄 안내 |

## 성공 기준

- [ ] wrapper executable + shellcheck 통과
- [ ] PASS 상태에서 wrapper 호출 → exit 0 (smoke 정상)
- [ ] FAIL 상태에서 wrapper 호출 → --fix 시도 + exit 1 + 안내 출력
- [ ] 두 hook 모두 wrapper 경유 동작 정상
- [ ] 회귀 0 (기존 smoke 동작 그대로)

## 커밋 전략

```
feat(meta): v1.64-precommit-autofix — pre-commit 실패 시 --fix 자동 시도

- add: tests/precommit-autofix-or-fail.sh (wrapper — smoke 실행, 실패 시 --fix + 안내 + exit 1)
- update: .pre-commit-config.yaml (smoke-spec-verification + smoke-scope-contract entry wrapper 경유)
- update: README.md (pre-commit 자동 --fix 동작 안내)

safe abort 패턴 — --fix 적용 후 commit 중단 → 사용자 git diff 검토 후 재스테이징 + 재커밋.
v1.39c-fix-autofix trigger 이행. v1.60~v1.63 누적 --fix mode 활용.
회귀 0 (기존 smoke 동작 그대로).
```

## 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.64b-precommit-expand` | 신규 pre-commit hook 추가 (smoke-bash-permission-pattern + smoke-thinking-effort + smoke-broad-bash-fine-grain) — wrapper 재사용 |
| `v1.64c-precommit-dry-run` | wrapper에 dry-run mode 추가 (--fix 적용 전 plan 먼저 보여주기) evidence |
| `v1.64d-precommit-autostage` | --fix 후 자동 git add (사용자 검토 단계 생략) — 위험성 검증 후 evidence-driven |

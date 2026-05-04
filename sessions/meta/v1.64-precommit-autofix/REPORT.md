# meta v1.64-precommit-autofix — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 3 (`tests/precommit-autofix-or-fail.sh` 신규 + `.pre-commit-config.yaml` 갱신 + `README.md` 안내 1줄)
- PASS 경로: wrapper exit 0 (smoke-spec-verification 423 PASS, smoke-scope-contract 148 PASS)
- E2E FAIL → --fix → exit 1: § 누락 주입 → wrapper 자동 정정 + abort 안내 출력
- 회귀: 0 (기존 smoke 동작 그대로)

## 구현 요약

### Stage A — wrapper 신설 (`tests/precommit-autofix-or-fail.sh`)

```bash
#!/usr/bin/env bash
# pre-commit wrapper: run smoke; if fail, attempt --fix; abort with review instruction.
set -uo pipefail
SMOKE="${1:?Usage: $0 <smoke-script-path>}"
if bash "$SMOKE"; then exit 0; fi
echo "=== smoke FAIL: $SMOKE — attempting --fix ==="
fix_rc=0
bash "$SMOKE" --fix || fix_rc=$?
echo "=== --fix attempted (rc=$fix_rc). Please review changes:"
echo "    git diff"
echo "=== Re-stage and re-commit:"
echo "    git add -u && git commit"
exit 1
```

`chmod +x`로 executable 부여.

### Stage B — `.pre-commit-config.yaml` 갱신

기존 2 hook (`smoke-spec-verification` + `smoke-scope-contract`) `entry` 필드 wrapper 경유:

```yaml
entry: bash tests/precommit-autofix-or-fail.sh tests/smoke-spec-verification.sh
entry: bash tests/precommit-autofix-or-fail.sh tests/smoke-scope-contract.sh
```

`name` 필드도 "(실패 시 --fix 자동)" 추가하여 사용자 가시성 확보.

### Stage C — README.md 안내

`### Optional dev tooling` § 직후 1줄 안내:

> **v1.64+** — smoke 실패 시 wrapper(`tests/precommit-autofix-or-fail.sh`)가 `--fix` 자동 시도 + 안내 후 abort. 사용자는 `git diff` 검토 → `git add -u` 재스테이징 → 재커밋.

### Stage D — PASS 경로 검증

- `bash tests/precommit-autofix-or-fail.sh tests/smoke-spec-verification.sh` → exit 0 (423 PASS)
- `bash tests/precommit-autofix-or-fail.sh tests/smoke-scope-contract.sh` → exit 0 (148 PASS)

### Stage E — E2E FAIL 시나리오

```bash
# 1. PLAN.md에서 Spec verification § 제거 (violation 주입)
python3 -c "import re; ..."   # § 블록 삭제
# → grep '## Spec verification' = 0

# 2. wrapper 호출
bash tests/precommit-autofix-or-fail.sh tests/smoke-spec-verification.sh
# → smoke FAIL → --fix attempted (rc=0)
# → "Please review changes: git diff"
# → "Re-stage and re-commit: git add -u && git commit"
# → exit 1

# 3. 자동 정정 확인
# → grep '## Spec verification' = 1 (§ skeleton 자동 삽입됨)

# 4. 복원 + 재검증
# → smoke 423 PASS / 0 FAIL
```

## 판정

| 성공 기준 | 결과 |
|---------|------|
| wrapper executable + 작동 | ✅ |
| PASS 경로 → exit 0 (양 hook) | ✅ |
| FAIL 경로 → --fix 시도 + exit 1 + 안내 | ✅ |
| 회귀 0 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — pre-commit framework 표준 사용. 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — safe abort 패턴 (Approach B)이 자동화-안전성 균형의 sweet spot**: --fix 적용 후 자동 git add (Approach A) 또는 dry-run only (Approach C) 모두 한쪽으로 치우침. exit 1 + 사용자 검토 강제는 자동화 가치 + 안전성 양쪽 보존
- **L2 — 범용 wrapper 설계의 재사용 가능성**: `precommit-autofix-or-fail.sh <smoke-path>` 단일 인자 → 모든 --fix 보유 smoke 적용 가능. v1.64b에서 새 hook 추가 시 entry만 추가하면 됨
- **L3 — `set -uo pipefail` (no `-e`) 의도적 선택**: wrapper는 smoke FAIL 시에도 진행해야 하므로 `-e` 사용 시 첫 FAIL에서 종료 → --fix 시도 못 함. `set -uo pipefail`로 unset/pipe 보호만 활성

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.64b-precommit-expand` | E | 신규 pre-commit hook 추가 (smoke-bash-permission-pattern + smoke-thinking-effort + smoke-broad-bash-fine-grain) — wrapper 재사용 |
| `v1.64c-precommit-dry-run` | E | wrapper에 dry-run mode 추가 (--fix 적용 전 plan 먼저) evidence |
| `v1.64d-precommit-autostage` | A | --fix 후 자동 git add 정책 — 위험성 검증 후 evidence-driven |

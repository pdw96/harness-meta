#!/usr/bin/env bash
# pre-commit wrapper: run smoke; if fail, attempt --fix; abort with review instruction.
# v1.64 — safe abort pattern (user reviews diff before re-commit).
#
# Usage (in .pre-commit-config.yaml):
#   entry: bash tests/precommit-autofix-or-fail.sh tests/smoke-X.sh
#
# 동작:
#   1) smoke 정상 실행 → exit 0
#   2) smoke FAIL → --fix 시도 → 안내 + exit 1 (commit abort)
#   3) 사용자: git diff 검토 → git add -u → git commit (재시도)

set -uo pipefail

SMOKE="${1:?Usage: $0 <smoke-script-path>}"

# 1) 정상 실행 (modifications 없음)
if bash "$SMOKE"; then
    exit 0
fi

# 2) 실패 → --fix 시도
echo ""
echo "=== smoke FAIL: $SMOKE — attempting --fix ==="
fix_rc=0
bash "$SMOKE" --fix || fix_rc=$?

# 3) 변경 안내 + abort
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

#!/usr/bin/env bash
# v1.10h2 smoke — AGENTS.md.tmpl L5 "See [README.md](README.md) for project overview..." 제거
# Stage 1: L5 단독 (License: {{license}}) + README link 잔존 0
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

TMPL="bootstrap/skeletons/AGENTS.md.tmpl"

PASS=0; FAIL=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

# Stage 1 — AGENTS.md.tmpl L5 정리 (2 checks)
echo "=== Stage 1 — AGENTS.md.tmpl L5 ==="

# Check 1: L5 "See [README.md]" 잔존 0
if grep -q 'See \[README.md\]' "$TMPL"; then
    fail "L5 'See [README.md]' 잔존 — 제거 실패"
else
    ok "L5 'See [README.md]' 잔존 0"
fi

# Check 2: L5 = "License: {{license}}" exact (단독)
L5=$(sed -n '5p' "$TMPL")
if [ "$L5" = "License: {{license}}" ]; then
    ok "L5 단독 'License: {{license}}' 일치"
else
    fail "L5 불일치: actual=[$L5]"
fi

# 결과
echo ""
echo "=== 결과: $PASS PASS / $FAIL FAIL ==="
[ "$FAIL" -eq 0 ] || exit 1
echo "v1.10h2 smoke 2/2 PASS — L5 README link 정리 정상"

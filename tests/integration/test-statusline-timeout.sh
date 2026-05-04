#!/usr/bin/env bash
# test-statusline-timeout.sh — statusline.sh timeout 동작 검증
#
# Coverage:
#   T1: statusline_cmd 없음         → "[harness] <name>" fallback
#   T2: statusline_cmd 정상 실행    → 명령 출력 반환
#   T3: statusline_cmd timeout(3s)  → "[harness] <name>" fallback + 3초 내 완료
#   T4: manifest 없음               → 빈 출력 + exit 0

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
STATUSLINE="$HARNESS_META_ROOT/claude/statusline/statusline.sh"
FIXTURE_TIMEOUT="$HARNESS_META_ROOT/tests/fixtures/statusline-timeout"
FIXTURE_CMD="$HARNESS_META_ROOT/tests/fixtures/statusline-cmd"

PASS=0; FAIL=0
ok()   { echo "  [OK] $1"; PASS=$((PASS+1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL+1)); }

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "=== test-statusline-timeout ==="

# ── T1: statusline_cmd 없음 → "[harness] <name>" fallback ───────
cat > "$TMPDIR/.harness.toml" << 'EOF'
schema_version = "1.1"
[project]
name = "no-cmd-project"
language = "python"
package_manager = "uv"
[harness]
code_dir = "scripts/harness"
phases_dir = "phases"
EOF
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$STATUSLINE" 2>/dev/null)
if [ "$OUT" = "[harness] no-cmd-project" ]; then
    ok "T1: statusline_cmd 없음 → '[harness] no-cmd-project'"
else
    fail "T1: expected '[harness] no-cmd-project', got: '$OUT'"
fi

# ── T2: statusline_cmd 정상 실행 → 명령 출력 반환 ───────────────
OUT=$(CLAUDE_PROJECT_DIR="$FIXTURE_CMD" bash "$STATUSLINE" 2>/dev/null)
if [ "$OUT" = "[fixture]OK" ]; then
    ok "T2: statusline_cmd 정상 → '[fixture]OK'"
else
    fail "T2: expected '[fixture]OK', got: '$OUT'"
fi

# ── T3: statusline_cmd = "sleep 10" → timeout 후 fallback ───────
START=$(date +%s)
OUT=$(CLAUDE_PROJECT_DIR="$FIXTURE_TIMEOUT" bash "$STATUSLINE" 2>/dev/null)
END=$(date +%s)
ELAPSED=$((END - START))

if [ "$OUT" = "[harness] statusline-timeout-fixture" ]; then
    ok "T3: timeout → '[harness] statusline-timeout-fixture' fallback"
else
    fail "T3: timeout fallback 미동작, got: '$OUT'"
fi
# timeout이 3초 + 1초 margin 내에 완료됐는지
if [ "$ELAPSED" -le 5 ]; then
    ok "T3: timeout 경과시간 ${ELAPSED}s (≤5s)"
else
    fail "T3: timeout 경과시간 ${ELAPSED}s > 5s (too slow)"
fi

# ── T4: manifest 없음 → 빈 출력 + exit 0 ────────────────────────
TMPDIR2=$(mktemp -d)
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR2" bash "$STATUSLINE" 2>/dev/null)
EXIT_CODE=$?
rm -rf "$TMPDIR2"
if [ -z "$OUT" ] && [ "$EXIT_CODE" -eq 0 ]; then
    ok "T4: manifest 없음 → 빈 출력 + exit 0"
else
    fail "T4: manifest 없음 → unexpected output='$OUT' exit=$EXIT_CODE"
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

#!/usr/bin/env bash
# test-statusline-timeout.sh — statusline.sh timeout + 컨텍스트 게이지 검증
#
# Coverage:
#   T1: statusline_cmd 없음           → "[harness] <name>" fallback
#   T2: statusline_cmd 정상 실행      → 명령 출력 반환
#   T3: statusline_cmd timeout(3s)    → "[harness] <name>" fallback + 3초 내 완료
#   T4: manifest 없음                 → 빈 출력 + exit 0
#   T5: marker + context_window.used_percentage=8 → "[ctx 8%]" 게이지 (v7.1)
#   T6: marker + context_window 부재  → 게이지 미출력 (v7.1, risk_1)
#   T7: marker + rate_limits.used_percentage 동시 존재 → context_window 값만 (v7.1, risk_2)
#   T8: marker + rate_limits 가 context_window 앞 + used_percentage 가 current_usage 뒤
#       → 여전히 정확 추출 (v7.1, anchored-first-match 키 순서 변동 회귀)
#   T9: 임계 마커 — 75% → "*" 주의 / 95% → "!" 위험 (v7.1, d_3)
#
# NOTE (v7.1, risk_5): statusline.sh 가 stdin 을 input=$(cat) 으로 1회 읽으므로,
#   모든 호출은 stdin redirect (</dev/null 또는 fixture JSON pipe) 의무 — 부재 시 EOF 대기 hang.
#   production 은 Claude Code 가 항상 JSON stdin 제공 (statusline.md) 이라 무관 (smoke 환경 전용).

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
STATUSLINE="$HARNESS_META_ROOT/claude/statusline/statusline.sh"
FIXTURE_TIMEOUT="$HARNESS_META_ROOT/tests/fixtures/statusline-timeout"
FIXTURE_CMD="$HARNESS_META_ROOT/tests/fixtures/statusline-cmd"
FIXTURE_STDIN="$HARNESS_META_ROOT/tests/fixtures/statusline-stdin"

PASS=0; FAIL=0
ok()   { echo "  [OK] $1"; PASS=$((PASS+1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL+1)); }

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# marker-only 게이지 테스트용 tmpdir (harness-meta repo marker 존재 모사)
MARKERDIR=$(mktemp -d)
mkdir -p "$MARKERDIR/development"
: > "$MARKERDIR/development/claude-code-version-log.md"
trap 'rm -rf "$TMPDIR" "$MARKERDIR"' EXIT

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
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$STATUSLINE" </dev/null 2>/dev/null)
if [ "$OUT" = "[harness] no-cmd-project" ]; then
    ok "T1: statusline_cmd 없음 → '[harness] no-cmd-project'"
else
    fail "T1: expected '[harness] no-cmd-project', got: '$OUT'"
fi

# ── T2: statusline_cmd 정상 실행 → 명령 출력 반환 ───────────────
OUT=$(CLAUDE_PROJECT_DIR="$FIXTURE_CMD" bash "$STATUSLINE" </dev/null 2>/dev/null)
if [ "$OUT" = "[fixture]OK" ]; then
    ok "T2: statusline_cmd 정상 → '[fixture]OK'"
else
    fail "T2: expected '[fixture]OK', got: '$OUT'"
fi

# ── T3: statusline_cmd = "sleep 10" → timeout 후 fallback ───────
START=$(date +%s)
OUT=$(CLAUDE_PROJECT_DIR="$FIXTURE_TIMEOUT" bash "$STATUSLINE" </dev/null 2>/dev/null)
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
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR2" bash "$STATUSLINE" </dev/null 2>/dev/null)
EXIT_CODE=$?
rm -rf "$TMPDIR2"
if [ -z "$OUT" ] && [ "$EXIT_CODE" -eq 0 ]; then
    ok "T4: manifest 없음 → 빈 출력 + exit 0"
else
    fail "T4: manifest 없음 → unexpected output='$OUT' exit=$EXIT_CODE"
fi

# ── T5: marker + context_window.used_percentage=8 → "[ctx 8%]" ──
OUT=$(CLAUDE_PROJECT_DIR="$MARKERDIR" bash "$STATUSLINE" < "$FIXTURE_STDIN/context-present.json" 2>/dev/null)
if [ "$OUT" = "[ctx 8%]" ]; then
    ok "T5: context_window.used_percentage=8 → '[ctx 8%]'"
else
    fail "T5: expected '[ctx 8%]', got: '$OUT'"
fi

# ── T6: marker + context_window 부재 → 게이지 미출력 ────────────
OUT=$(CLAUDE_PROJECT_DIR="$MARKERDIR" bash "$STATUSLINE" < "$FIXTURE_STDIN/context-absent.json" 2>/dev/null)
if [ -z "$OUT" ]; then
    ok "T6: context_window 부재 → 게이지 미출력 (빈 출력, '0%' 금지)"
else
    fail "T6: expected empty (게이지 생략), got: '$OUT'"
fi

# ── T7: marker + rate_limits.used_percentage 동시 → context_window 값만 ──
OUT=$(CLAUDE_PROJECT_DIR="$MARKERDIR" bash "$STATUSLINE" < "$FIXTURE_STDIN/ratelimit-dup.json" 2>/dev/null)
if [ "$OUT" = "[ctx 8%]" ]; then
    ok "T7: rate_limits 동시 존재 → context_window 값만 '[ctx 8%]'"
else
    fail "T7: expected '[ctx 8%]' (rate_limit 50/99 오매칭 회피), got: '$OUT'"
fi

# ── T8: rate_limits 가 앞 + used_percentage 가 current_usage 뒤 → 정확 추출 ──
OUT=$(CLAUDE_PROJECT_DIR="$MARKERDIR" bash "$STATUSLINE" < "$FIXTURE_STDIN/keyorder.json" 2>/dev/null)
if [ "$OUT" = "[ctx 42%]" ]; then
    ok "T8: 키 순서 변동 → '[ctx 42%]' (anchored-first-match 회귀)"
else
    fail "T8: expected '[ctx 42%]' (키 순서 무관 정확 추출), got: '$OUT'"
fi

# ── T9: 임계 마커 — 75% → '*' 주의 / 95% → '!' 위험 (d_3) ────────
OUT=$(CLAUDE_PROJECT_DIR="$MARKERDIR" bash "$STATUSLINE" <<< '{"context_window":{"used_percentage":75}}' 2>/dev/null)
if [ "$OUT" = "[ctx 75%*]" ]; then
    ok "T9a: 75% → '[ctx 75%*]' 주의 마커"
else
    fail "T9a: expected '[ctx 75%*]', got: '$OUT'"
fi
OUT=$(CLAUDE_PROJECT_DIR="$MARKERDIR" bash "$STATUSLINE" <<< '{"context_window":{"used_percentage":95}}' 2>/dev/null)
if [ "$OUT" = "[ctx 95%!]" ]; then
    ok "T9b: 95% → '[ctx 95%!]' 위험 마커"
else
    fail "T9b: expected '[ctx 95%!]', got: '$OUT'"
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

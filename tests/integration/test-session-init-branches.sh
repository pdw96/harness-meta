#!/usr/bin/env bash
# test-session-init-branches.sh — session-init.sh 4개 분기 + JSON validity + 제어문자 버그 회귀
#
# Branch coverage:
#   B1: manifest 없음          → {}
#   B2: phases 디렉토리 없음   → "not initialized" fallback
#   B3: phases 있음, state 없음 → "directory exists" fallback
#   B4: state_file 있음        → 파일 내용 주입
#   B5: 제어문자(0x08) 버그 회귀 방지 → valid JSON 확인

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
HOOK="$HARNESS_META_ROOT/claude/hooks/session-init.sh"

PASS=0; FAIL=0
ok()   { echo "  [OK] $1"; PASS=$((PASS+1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL+1)); }

_json_valid() {
    echo "$1" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null
}

# ── 임시 프로젝트 루트 ──────────────────────────────────────────
TMPDIR=$(mktemp -d)
trap "rm -rf '$TMPDIR'" EXIT

_make_manifest() {
    cat > "$TMPDIR/.harness.toml" << 'EOF'
schema_version = "1.1"
[project]
name = "branch-test"
language = "python"
package_manager = "uv"
[harness]
code_dir = "scripts/harness"
phases_dir = "phases"
EOF
}

echo "=== test-session-init-branches ==="

# ── B1: manifest 없음 → {} ──────────────────────────────────────
rm -f "$TMPDIR/.harness.toml"
rm -rf "$TMPDIR/phases"
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$HOOK" 2>/dev/null)
if [ "$OUT" = '{}' ]; then
    ok "B1: manifest 없음 → {}"
else
    fail "B1: manifest 없음 → expected '{}', got: $OUT"
fi

# ── B2: phases 디렉토리 없음 → not-initialized fallback ─────────
_make_manifest
rm -rf "$TMPDIR/phases"
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$HOOK" 2>/dev/null)
if _json_valid "$OUT" && echo "$OUT" | grep -q "not initialized"; then
    ok "B2: phases 없음 → valid JSON + 'not initialized'"
else
    fail "B2: phases 없음 → JSON invalid or 'not initialized' 미포함: $OUT"
fi

# ── B3: phases 있음, state_file 없음 → directory exists fallback ─
_make_manifest
mkdir -p "$TMPDIR/phases"
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$HOOK" 2>/dev/null)
if _json_valid "$OUT" && echo "$OUT" | grep -q "phases directory exists"; then
    ok "B3: phases 있음 → valid JSON + 'phases directory exists'"
else
    fail "B3: phases 있음 → JSON invalid or 'directory exists' 미포함: $OUT"
fi

# ── B4: state_file 있음 → 파일 내용 주입 ───────────────────────
_make_manifest
mkdir -p "$TMPDIR/phases"
printf 'milestone: v1.0\nstatus: in-progress' > "$TMPDIR/phases/.harness-state.txt"
# state_file 추가
printf '\nstate_file = "phases/.harness-state.txt"\n' >> "$TMPDIR/.harness.toml"
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$HOOK" 2>/dev/null)
if _json_valid "$OUT" && echo "$OUT" | grep -q "milestone"; then
    ok "B4: state_file → valid JSON + 파일 내용 포함"
else
    fail "B4: state_file → JSON invalid or 내용 미포함: $OUT"
fi

# ── B5: 제어문자(0x08 backspace) 버그 회귀 방지 ────────────────
_make_manifest
mkdir -p "$TMPDIR/phases"
printf 'data with BS:\x08here\nand VT:\x0bskip' > "$TMPDIR/phases/.harness-state.txt"
printf '\nstate_file = "phases/.harness-state.txt"\n' >> "$TMPDIR/.harness.toml"
OUT=$(CLAUDE_PROJECT_DIR="$TMPDIR" bash "$HOOK" 2>/dev/null)
if _json_valid "$OUT"; then
    ok "B5: 제어문자 포함 state_file → valid JSON (버그 회귀 없음)"
else
    fail "B5: 제어문자 포함 state_file → JSON invalid (버그 재발)"
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

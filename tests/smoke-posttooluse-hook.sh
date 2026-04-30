#!/usr/bin/env bash
# smoke-posttooluse-hook.sh — v1.36b PostToolUse hook 검증
# Stage 1: 정적 3 checks  |  Stage 2: dynamic 7 checks (A~G)  |  Total: 10/10

set -euo pipefail
cd "$(dirname "$0")/.."

PASS=0; FAIL=0
ok()   { echo "  ✓ $*"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $*"; FAIL=$((FAIL+1)); }

HOOK="claude/hooks/post-report-write.sh"

echo "=== Stage 1 — Static (3) ==="

# S1: hook 파일 존재 + executable
if [ -x "$HOOK" ]; then
    ok "hook 존재 + executable: $HOOK"
else
    fail "hook 미존재 또는 non-executable: $HOOK"
fi

# S2: install.ps1에 PostToolUse matcher-level merge 코드 존재 (Edit|Write|MultiEdit)
if grep -q "PostToolUse" install.ps1 && \
   grep -q "Edit|Write|MultiEdit"  install.ps1 && \
   grep -q "matcher-level merge" install.ps1; then
    ok "install.ps1 PostToolUse matcher-level merge 코드 존재 (Edit|Write|MultiEdit)"
else
    fail "install.ps1 PostToolUse 코드 누락 (PostToolUse / Edit|Write|MultiEdit / matcher-level merge)"
fi

# S3: hook에 python3 fallback + grep fallback 양쪽 존재
if grep -q "python3" "$HOOK" && grep -q "grep" "$HOOK"; then
    ok "hook python3 fallback + grep fallback 양쪽 존재"
else
    fail "hook python3 또는 grep fallback 누락"
fi

echo ""
echo "=== Stage 2 — Dynamic (7) ==="

run_hook() {
    printf '%s' "$1" | bash "$HOOK" 2>/dev/null
}

BASE_REPORT='sessions/meta/v1.36b-test/REPORT.md'

# Test A — Write + REPORT.md (forward slash) → additionalContext 포함
A_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/%s"},"tool_response":{"success":true}}' "$BASE_REPORT")
A_OUT=$(run_hook "$A_IN")
if printf '%s' "$A_OUT" | grep -q "additionalContext" && printf '%s' "$A_OUT" | grep -q "harness-roadmap-update"; then
    ok "A: Write + REPORT.md → additionalContext 포함"
else
    fail "A: Write + REPORT.md → 예상 additionalContext 없음. got: $A_OUT"
fi

# Test B — Write + non-REPORT.md → no-op {}
B_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/some/other/file.md"},"tool_response":{"success":true}}'
B_OUT=$(run_hook "$B_IN")
if [ "$B_OUT" = '{}' ]; then
    ok "B: Write + non-REPORT.md → no-op {}"
else
    fail "B: Write + non-REPORT.md → 예상 {} 아님. got: $B_OUT"
fi

# Test C — Write + REPORT.md (Windows backslash) → additionalContext 포함
C_PATH='C:\\Users\\qkreh\\harness-meta\\sessions\\meta\\v1.36b-test\\REPORT.md'
C_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"%s"},"tool_response":{"success":true}}' "$C_PATH")
C_OUT=$(run_hook "$C_IN")
if printf '%s' "$C_OUT" | grep -q "additionalContext"; then
    ok "C: Write + REPORT.md (Windows backslash) → additionalContext 포함"
else
    fail "C: Write + REPORT.md (backslash) → additionalContext 없음. got: $C_OUT"
fi

# Test D — Edit + REPORT.md → additionalContext 포함 (Edit|Write|MultiEdit matcher 정합)
D_IN=$(printf '{"tool_name":"Edit","tool_input":{"file_path":"/home/user/harness-meta/%s"},"tool_response":{"success":true}}' "$BASE_REPORT")
D_OUT=$(run_hook "$D_IN")
if printf '%s' "$D_OUT" | grep -q "additionalContext"; then
    ok "D: Edit + REPORT.md → additionalContext 포함"
else
    fail "D: Edit + REPORT.md → additionalContext 없음. got: $D_OUT"
fi

# Test E — Write + REPORT.md but success: false → no-op {} (실패 가드)
E_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/%s"},"tool_response":{"success":false}}' "$BASE_REPORT")
E_OUT=$(run_hook "$E_IN")
if [ "$E_OUT" = '{}' ]; then
    ok "E: Write + REPORT.md + success:false → no-op {} (실패 가드)"
else
    fail "E: success:false → 예상 {} 아님. got: $E_OUT"
fi

# Test F — MultiEdit + REPORT.md → additionalContext 포함 (v1.40 신규)
F_IN=$(printf '{"tool_name":"MultiEdit","tool_input":{"file_path":"/home/user/harness-meta/%s"},"tool_response":{"success":true}}' "$BASE_REPORT")
F_OUT=$(run_hook "$F_IN")
if printf '%s' "$F_OUT" | grep -q "additionalContext" && printf '%s' "$F_OUT" | grep -q "harness-roadmap-update"; then
    ok "F: MultiEdit + REPORT.md → additionalContext 포함"
else
    fail "F: MultiEdit + REPORT.md → additionalContext 없음. got: $F_OUT"
fi

# Test G — MultiEdit + REPORT.md + success:false → no-op {} (실패 가드, v1.40 신규)
G_IN=$(printf '{"tool_name":"MultiEdit","tool_input":{"file_path":"/home/user/harness-meta/%s"},"tool_response":{"success":false}}' "$BASE_REPORT")
G_OUT=$(run_hook "$G_IN")
if [ "$G_OUT" = '{}' ]; then
    ok "G: MultiEdit + REPORT.md + success:false → no-op {} (실패 가드)"
else
    fail "G: MultiEdit + success:false → 예상 {} 아님. got: $G_OUT"
fi

echo ""
echo "=== 결과: PASS $PASS / FAIL $FAIL (총 $((PASS+FAIL))) ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

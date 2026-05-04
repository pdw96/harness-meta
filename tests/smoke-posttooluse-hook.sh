#!/usr/bin/env bash
# smoke-posttooluse-hook.sh — v1.36b PostToolUse hook 검증
# v1.41: Test H (MultiEdit + 마커 있음) + Test I (MultiEdit + 마커 없음 → NOOP) 추가
# v1.42: Test J (Write + sections → message에 섹션명 포함) + Test K (no sections → graceful)
# v1.54: Test L (malformed JSON → 양쪽 파서 실패 → stderr WARN + NOOP) 추가
# v1.57: Test M (NotebookEdit + REPORT.ipynb → trigger) + Test N (NotebookEdit + non-REPORT → NOOP)
# v1.58: Test O (NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 포함, 동적 파일명 검증)
# v1.59: Test P (Write + PLAN.md → harness-plan-verify 안내) + Test Q (non-sessions PLAN → NOOP)
# Stage 1: 정적 3 checks  |  Stage 2: dynamic 17 checks (A~Q)  |  Total: 20/20

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

# S2: install.ps1에 PostToolUse matcher-level merge 코드 존재 (Edit|Write|MultiEdit|NotebookEdit)
if grep -q "PostToolUse" install.ps1 && \
   grep -q "Edit|Write|MultiEdit|NotebookEdit"  install.ps1 && \
   grep -q "matcher-level merge" install.ps1; then
    ok "install.ps1 PostToolUse matcher-level merge 코드 존재 (Edit|Write|MultiEdit|NotebookEdit)"
else
    fail "install.ps1 PostToolUse 코드 누락 (PostToolUse / Edit|Write|MultiEdit|NotebookEdit / matcher-level merge)"
fi

# S3: hook에 python3 fallback + grep fallback 양쪽 존재
if grep -q "python3" "$HOOK" && grep -q "grep" "$HOOK"; then
    ok "hook python3 fallback + grep fallback 양쪽 존재"
else
    fail "hook python3 또는 grep fallback 누락"
fi

echo ""
echo "=== Stage 2 — Dynamic (17) ==="

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

# Test H — MultiEdit + REPORT.md + edits with '## ' marker → additionalContext (v1.41)
H_EDITS='[{"old_string":"old","new_string":"## 판정\n\n| 성공 기준 | 결과 |\n|---------|------|\n| smoke PASS | ✅ |"}]'
H_IN=$(printf '{"tool_name":"MultiEdit","tool_input":{"file_path":"/home/user/harness-meta/%s","edits":%s},"tool_response":{"success":true}}' "$BASE_REPORT" "$H_EDITS")
H_OUT=$(run_hook "$H_IN")
if printf '%s' "$H_OUT" | grep -q "additionalContext" && printf '%s' "$H_OUT" | grep -q "harness-roadmap-update"; then
    ok "H: MultiEdit + REPORT.md + edits with '## ' marker → additionalContext 포함"
else
    fail "H: MultiEdit + REPORT.md + marker edits → additionalContext 없음. got: $H_OUT"
fi

# Test I — MultiEdit + REPORT.md + edits without '## ' marker → NOOP (v1.41 콘텐츠 가드)
I_EDITS='[{"old_string":"typo","new_string":"typo fix"}]'
I_IN=$(printf '{"tool_name":"MultiEdit","tool_input":{"file_path":"/home/user/harness-meta/%s","edits":%s},"tool_response":{"success":true}}' "$BASE_REPORT" "$I_EDITS")
I_OUT=$(run_hook "$I_IN")
if [ "$I_OUT" = '{}' ]; then
    ok "I: MultiEdit + REPORT.md + edits without '## ' marker → NOOP {} (콘텐츠 가드)"
else
    fail "I: MultiEdit + no marker → 예상 {} 아님. got: $I_OUT"
fi

# Test J — Write + REPORT.md + content with '## ' sections → message includes section names (v1.42)
J_CONTENT='## 판정\n\n성공\n\n## Lessons Learned\n\n교훈'
J_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/%s","content":"%s"},"tool_response":{"success":true}}' "$BASE_REPORT" "$J_CONTENT")
J_OUT=$(run_hook "$J_IN")
if printf '%s' "$J_OUT" | grep -q "additionalContext" && printf '%s' "$J_OUT" | grep -q "sections:"; then
    ok "J: Write + REPORT.md + content with sections → message includes section names"
else
    fail "J: Write + REPORT.md + sections → section names not in message. got: $J_OUT"
fi

# Test K — Write + REPORT.md + content without '## ' sections → message valid (graceful degradation) (v1.42)
K_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/%s","content":"plain content without headings"},"tool_response":{"success":true}}' "$BASE_REPORT")
K_OUT=$(run_hook "$K_IN")
if printf '%s' "$K_OUT" | grep -q "additionalContext" && printf '%s' "$K_OUT" | grep -q "harness-roadmap-update"; then
    ok "K: Write + REPORT.md + no sections → message valid (graceful degradation)"
else
    fail "K: Write + no sections → expected valid message. got: $K_OUT"
fi

# Test L — malformed JSON → 양쪽 파서 실패 → NOOP {} + stderr WARN (v1.54)
_L_STDERR_FILE=$(mktemp)
L_STDOUT=$(printf '%s' 'not valid json at all' | bash "$HOOK" 2>"$_L_STDERR_FILE")
L_STDERR=$(cat "$_L_STDERR_FILE")
rm -f "$_L_STDERR_FILE"
if [ "$L_STDOUT" = '{}' ] && printf '%s' "$L_STDERR" | grep -q '\[post-report-write\] WARN'; then
    ok "L: malformed JSON → NOOP {} + stderr WARN (양쪽 파서 실패, v1.54)"
else
    fail "L: malformed JSON → stdout='$L_STDOUT' stderr='$L_STDERR'"
fi

# Test M — NotebookEdit + REPORT.ipynb → additionalContext (v1.57 신규)
M_NB_PATH='/home/user/harness-meta/sessions/meta/v1.57-test/REPORT.ipynb'
M_IN=$(printf '{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"%s","new_source":"## 판정\\n\\nOK","cell_type":"markdown","edit_mode":"replace"},"tool_response":{"success":true}}' "$M_NB_PATH")
M_OUT=$(run_hook "$M_IN")
if printf '%s' "$M_OUT" | grep -q "additionalContext" && printf '%s' "$M_OUT" | grep -q "harness-roadmap-update"; then
    ok "M: NotebookEdit + REPORT.ipynb (notebook_path) → additionalContext 포함"
else
    fail "M: NotebookEdit + REPORT.ipynb → additionalContext 없음. got: $M_OUT"
fi

# Test N — NotebookEdit + non-REPORT notebook → NOOP {} (v1.57 신규)
N_IN='{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"/home/user/harness-meta/some/other/notebook.ipynb","new_source":"x","cell_type":"code","edit_mode":"replace"},"tool_response":{"success":true}}'
N_OUT=$(run_hook "$N_IN")
if [ "$N_OUT" = '{}' ]; then
    ok "N: NotebookEdit + non-REPORT notebook → no-op {}"
else
    fail "N: NotebookEdit + non-REPORT → 예상 {} 아님. got: $N_OUT"
fi

# Test O — NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 포함 (v1.58 동적 파일명)
O_NB_PATH='/home/user/harness-meta/sessions/meta/v1.57-test/REPORT.ipynb'
O_IN=$(printf '{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"%s","new_source":"## 판정","cell_type":"markdown","edit_mode":"replace"},"tool_response":{"success":true}}' "$O_NB_PATH")
O_OUT=$(run_hook "$O_IN")
if printf '%s' "$O_OUT" | grep -q "REPORT.ipynb"; then
    ok "O: NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 포함 (v1.58 동적 파일명)"
else
    fail "O: NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 없음. got: $O_OUT"
fi

# Test P — Write + sessions/**/PLAN.md → harness-plan-verify 안내 (v1.59 신규)
P_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/sessions/meta/v1.59-test/PLAN.md","content":"## 목표\n\n- [ ] 구현"},"tool_response":{"success":true}}')
P_OUT=$(run_hook "$P_IN")
if printf '%s' "$P_OUT" | grep -q "additionalContext" && printf '%s' "$P_OUT" | grep -q "harness-plan-verify"; then
    ok "P: Write + PLAN.md → additionalContext with harness-plan-verify (v1.59)"
else
    fail "P: Write + PLAN.md → harness-plan-verify 없음. got: $P_OUT"
fi

# Test Q — Write + PLAN.md outside sessions → NOOP (경로 가드, v1.59 신규)
Q_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/docs/PLAN.md","content":"## 목표"},"tool_response":{"success":true}}'
Q_OUT=$(run_hook "$Q_IN")
if [ "$Q_OUT" = '{}' ]; then
    ok "Q: Write + PLAN.md outside sessions → NOOP {} (경로 가드, v1.59)"
else
    fail "Q: PLAN.md outside sessions → 예상 {} 아님. got: $Q_OUT"
fi

echo ""
echo "=== 결과: PASS $PASS / FAIL $FAIL (총 $((PASS+FAIL))) ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

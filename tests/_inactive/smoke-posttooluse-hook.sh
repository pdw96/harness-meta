#!/usr/bin/env bash
# smoke-posttooluse-hook.sh — PostToolUse hook 검증
# v1.41: Test H (MultiEdit + 마커 있음) + Test I (MultiEdit + 마커 없음 → NOOP) 추가
# v1.42: Test J (Write + sections → message에 섹션명 포함) + Test K (no sections → graceful)
# v1.54: Test L (malformed JSON → 양쪽 파서 실패 → stderr WARN + NOOP) 추가
# v1.57: Test M (NotebookEdit + REPORT.ipynb) + Test N (NotebookEdit + non-REPORT → NOOP)
# v1.58: Test O (NotebookEdit + REPORT.ipynb → 동적 파일명 검증)
# v1.59: Test P (Write + PLAN.md → harness-plan-verify 안내) + Test Q (non-milestone PLAN → NOOP)
# v1.60: BASE_REPORT sessions→milestones 갱신 + M/O NOOP 전환 + Test R (execute/phase-N) + Test S (구 sessions NOOP)
# v1.61: Tests A/F/H/K/R harness-roadmap-update→/harness-meta 키워드 + Test P harness-plan-verify→RESEARCH 키워드
# v3.7: Test T (Write + INTENT.md → RESEARCH 안내) + Test U (APPROVE.md → EXECUTE 게이트) + Test V (PROPOSE.md → next_candidates 안내)
# Stage 1: 정적 3 checks  |  Stage 2: dynamic 22 checks (A~V)  |  Total: 25/25

set -euo pipefail
cd "$(dirname "$0")/../.."

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
echo "=== Stage 2 — Dynamic (22) ==="

run_hook() {
    printf '%s' "$1" | bash "$HOOK" 2>/dev/null
}

BASE_REPORT='projects/meta/milestones/v1.1_test/REPORT.md'

# Test A — Write + REPORT.md (forward slash) → additionalContext 포함
A_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/%s"},"tool_response":{"success":true}}' "$BASE_REPORT")
A_OUT=$(run_hook "$A_IN")
if printf '%s' "$A_OUT" | grep -q "additionalContext" && printf '%s' "$A_OUT" | grep -q "/harness-meta"; then
    ok "A: Write + REPORT.md → additionalContext 포함"
else
    fail "A: Write + REPORT.md → 예상 additionalContext 없음. got: $A_OUT"
fi

# Test B — Write + non-milestone.md → no-op {}
B_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/some/other/file.md"},"tool_response":{"success":true}}'
B_OUT=$(run_hook "$B_IN")
if [ "$B_OUT" = '{}' ]; then
    ok "B: Write + non-milestone.md → no-op {}"
else
    fail "B: Write + non-milestone.md → 예상 {} 아님. got: $B_OUT"
fi

# Test C — Write + REPORT.md (Windows backslash) → additionalContext 포함
C_PATH='C:\\Users\\qkreh\\harness-meta\\projects\\meta\\milestones\\v1.1_test\\REPORT.md'
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
if printf '%s' "$F_OUT" | grep -q "additionalContext" && printf '%s' "$F_OUT" | grep -q "/harness-meta"; then
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
if printf '%s' "$H_OUT" | grep -q "additionalContext" && printf '%s' "$H_OUT" | grep -q "/harness-meta"; then
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
if printf '%s' "$K_OUT" | grep -q "additionalContext" && printf '%s' "$K_OUT" | grep -q "/harness-meta"; then
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

# Test M — NotebookEdit + REPORT.ipynb → NOOP (v1.60: milestones는 .md only, ipynb 미지원)
M_NB_PATH='/home/user/harness-meta/projects/meta/milestones/v1.1_test/REPORT.ipynb'
M_IN=$(printf '{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"%s","new_source":"## 판정\\n\\nOK","cell_type":"markdown","edit_mode":"replace"},"tool_response":{"success":true}}' "$M_NB_PATH")
M_OUT=$(run_hook "$M_IN")
if [ "$M_OUT" = '{}' ]; then
    ok "M: NotebookEdit + REPORT.ipynb → NOOP {} (milestones .md only, v1.60)"
else
    fail "M: NotebookEdit + REPORT.ipynb → 예상 NOOP {} 아님. got: $M_OUT"
fi

# Test N — NotebookEdit + non-REPORT notebook → NOOP {} (v1.57 신규, 여전히 NOOP)
N_IN='{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"/home/user/harness-meta/some/other/notebook.ipynb","new_source":"x","cell_type":"code","edit_mode":"replace"},"tool_response":{"success":true}}'
N_OUT=$(run_hook "$N_IN")
if [ "$N_OUT" = '{}' ]; then
    ok "N: NotebookEdit + non-milestone notebook → no-op {}"
else
    fail "N: NotebookEdit + non-milestone → 예상 {} 아님. got: $N_OUT"
fi

# Test O — NotebookEdit + REPORT.ipynb → NOOP (v1.60: .md only 패턴으로 ipynb 미매치)
O_NB_PATH='/home/user/harness-meta/projects/meta/milestones/v1.1_test/REPORT.ipynb'
O_IN=$(printf '{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"%s","new_source":"## 판정","cell_type":"markdown","edit_mode":"replace"},"tool_response":{"success":true}}' "$O_NB_PATH")
O_OUT=$(run_hook "$O_IN")
if [ "$O_OUT" = '{}' ]; then
    ok "O: NotebookEdit + REPORT.ipynb → NOOP {} (v1.60 .md only)"
else
    fail "O: NotebookEdit + REPORT.ipynb → 예상 NOOP {} 아님. got: $O_OUT"
fi

# Test P — Write + milestones/**/PLAN.md → harness-plan-verify 안내 (v1.59, v1.60 경로 갱신)
P_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/projects/meta/milestones/v1.1_test/PLAN.md","content":"## 목표\n\n- [ ] 구현"},"tool_response":{"success":true}}')
P_OUT=$(run_hook "$P_IN")
if printf '%s' "$P_OUT" | grep -q "additionalContext" && printf '%s' "$P_OUT" | grep -q "RESEARCH"; then
    ok "P: Write + PLAN.md → additionalContext with RESEARCH 안내 (v1.61)"
else
    fail "P: Write + PLAN.md → RESEARCH 키워드 없음. got: $P_OUT"
fi

# Test Q — Write + PLAN.md outside milestones → NOOP (경로 가드, v1.59/v1.60)
Q_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/docs/PLAN.md","content":"## 목표"},"tool_response":{"success":true}}'
Q_OUT=$(run_hook "$Q_IN")
if [ "$Q_OUT" = '{}' ]; then
    ok "Q: Write + PLAN.md outside milestones → NOOP {} (경로 가드, v1.60)"
else
    fail "Q: PLAN.md outside milestones → 예상 {} 아님. got: $Q_OUT"
fi

# Test R — Write + execute/phase-N.md → additionalContext 포함 (v1.60 신규)
R_IN=$(printf '{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/projects/meta/milestones/v1.1_test/execute/phase-1.md","content":"## status\n\ncomplete"},"tool_response":{"success":true}}')
R_OUT=$(run_hook "$R_IN")
if printf '%s' "$R_OUT" | grep -q "additionalContext" && printf '%s' "$R_OUT" | grep -q "/harness-meta"; then
    ok "R: Write + execute/phase-1.md → additionalContext 포함 (v1.60)"
else
    fail "R: Write + execute/phase-1.md → additionalContext 없음. got: $R_OUT"
fi

# Test S — Write + 구 sessions/ 경로 → NOOP (v1.60: sessions 패턴 제거 회귀 방지)
S_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/sessions/meta/v1.36b-test/REPORT.md","content":"## 판정"},"tool_response":{"success":true}}'
S_OUT=$(run_hook "$S_IN")
if [ "$S_OUT" = '{}' ]; then
    ok "S: Write + 구 sessions/ 경로 → NOOP {} (v1.60 sessions 패턴 제거 확인)"
else
    fail "S: 구 sessions/ 경로 → 예상 NOOP {} 아님 (sessions 패턴 미제거). got: $S_OUT"
fi

# Test T — Write + INTENT.md → additionalContext에 '다음: RESEARCH' 포함 (v3.7, 9-stage era)
T_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/projects/meta/milestones/v3.7/INTENT.md","content":"## 의도\n\n- goal"},"tool_response":{"success":true}}'
T_OUT=$(run_hook "$T_IN")
if printf '%s' "$T_OUT" | grep -q "additionalContext" && printf '%s' "$T_OUT" | grep -q "다음: RESEARCH"; then
    ok "T: Write + INTENT.md → additionalContext에 '다음: RESEARCH' 포함 (v3.7)"
else
    fail "T: Write + INTENT.md → 예상 additionalContext 없음. got: $T_OUT"
fi

# Test U — Write + APPROVE.md → additionalContext에 'EXECUTE' 포함 (v3.7, 승인 게이트)
U_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/projects/meta/milestones/v3.7/APPROVE.md","content":"## 승인\n\n- approved"},"tool_response":{"success":true}}'
U_OUT=$(run_hook "$U_IN")
if printf '%s' "$U_OUT" | grep -q "additionalContext" && printf '%s' "$U_OUT" | grep -q "EXECUTE"; then
    ok "U: Write + APPROVE.md → additionalContext에 'EXECUTE' 포함 (v3.7)"
else
    fail "U: Write + APPROVE.md → 예상 additionalContext 없음. got: $U_OUT"
fi

# Test V — Write + PROPOSE.md → additionalContext에 'next_candidates' 포함 (v3.7, forward)
V_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/projects/meta/milestones/v3.7/PROPOSE.md","content":"## 후속\n\n- candidates"},"tool_response":{"success":true}}'
V_OUT=$(run_hook "$V_IN")
if printf '%s' "$V_OUT" | grep -q "additionalContext" && printf '%s' "$V_OUT" | grep -q "next_candidates"; then
    ok "V: Write + PROPOSE.md → additionalContext에 'next_candidates' 포함 (v3.7)"
else
    fail "V: Write + PROPOSE.md → 예상 additionalContext 없음. got: $V_OUT"
fi

# Test W — Write + MILESTONE.md → NOOP {} (v6.2 D8, 9-stage-flattened era)
# v6.2_milestone-artifact-directory-flattening: MILESTONE.md edit 시 hook trigger 부재 결정 (D8).
# 단일 파일 안 ## REPORT 섹션 신규 출현 자동 검출 = 구현 복잡 + trigger 점 모호 → 사용자 manual PROPOSE 진행.
# architecture P1 #2 흡수 — NOOP 경로 검증 행 명시.
W_IN='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/projects/meta/milestones/v6.2/MILESTONE.md","content":"## REPORT\n\n- summary"},"tool_response":{"success":true}}'
W_OUT=$(run_hook "$W_IN")
if [ "$W_OUT" = '{}' ]; then
    ok "W: Write + MILESTONE.md → NOOP {} (v6.2 D8 flattened era, hook trigger 부재)"
else
    fail "W: Write + MILESTONE.md → 예상 NOOP {} 아님 (v6.2 D8 위배). got: $W_OUT"
fi

echo ""
echo "=== 결과: PASS $PASS / FAIL $FAIL (총 $((PASS+FAIL))) ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

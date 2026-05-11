#!/usr/bin/env bash
# smoke-roi-regression.sh — v1.52 ROI 액션 0건 회귀 감지
# v1.51에서 compute_roi_actions/top_actions의 'not passed' → 'score < max_score and not na' 수정 보호.
# Stage 1: 정적 4 checks  |  Stage 2: dynamic 2 checks  |  Total: 6/6

set -euo pipefail
cd "$(dirname "$0")/.."

PASS=0; FAIL=0
ok()   { echo "  ✓ $*"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $*"; FAIL=$((FAIL+1)); }

SCORER_DIR="bootstrap/skills/audit/ai-ready-scorer/scripts"
OPS="$SCORER_DIR/categories_ops.py"
SCORE="$SCORER_DIR/score_codebase.py"

echo "=== Stage 1 — Static (4) ==="

# S1: compute_roi_actions에 'score < max_score and not' 조건 존재 (v1.51 수정 핵심)
if grep -q 'ch\["score"\] < ch\["max_score"\] and not ch.get("na"' "$OPS"; then
    ok "compute_roi_actions: score < max_score and not na 조건 존재"
else
    fail "compute_roi_actions: 조건식 누락 — 'not passed' 회귀 가능성"
fi

# S2: compute_roi_actions에 action 필터 존재
if grep -q 'ch.get("action")' "$OPS"; then
    ok "compute_roi_actions: ch.get(\"action\") 필터 존재"
else
    fail "compute_roi_actions: action 필터 누락"
fi

# S3: top_actions (score_codebase.py)에 'c.score < c.max_score and not c.na' 조건 존재 (v1.51 수정 핵심)
if grep -q 'c\.score < c\.max_score and not c\.na' "$SCORE"; then
    ok "top_actions: c.score < c.max_score and not c.na 조건 존재"
else
    fail "top_actions: 조건식 누락 — 'not c.passed' 회귀 가능성"
fi

# S4: AuditReport 생성 시 roi_actions=roi 할당 존재
if grep -q 'roi_actions=roi' "$SCORE"; then
    ok "AuditReport: roi_actions=roi 할당 존재"
else
    fail "AuditReport: roi_actions 할당 누락"
fi

echo ""
echo "=== Stage 2 — Dynamic (2) ==="

# D1: eligible check → roi_actions 1건 (na=False + score < max_score + action 있음)
D1_OUT=$(python3 -c "
import sys; sys.path.insert(0, '$SCORER_DIR')
from categories_ops import compute_roi_actions
from utils import CategoryResult, Check
from dataclasses import asdict

c1 = Check(name='test-check', passed=False, score=1.0, max_score=3.0,
           detail='partial', action='Fix this', roi_effort='단기', roi_impact=1.0, na=False)
c2 = Check(name='na-check', passed=False, score=0.0, max_score=2.0,
           detail='na', action='Should be excluded', roi_effort='단기', roi_impact=1.0, na=True)
c3 = Check(name='perfect', passed=True, score=2.0, max_score=2.0,
           detail='done', action='Already done', roi_effort='단기', roi_impact=1.0, na=False)

cat = CategoryResult(id='t', name_ko='테스트', score=3.0, max_score=7,
                     grade='B', color='orange',
                     checks=[asdict(c1), asdict(c2), asdict(c3)], top_actions=[])
result = compute_roi_actions([cat])
assert len(result) == 1, f'expected 1, got {len(result)}: {result}'
assert result[0]['check'] == 'test-check', f'unexpected: {result[0]}'
print('ok')
" 2>&1)
if [ "$D1_OUT" = "ok" ]; then
    ok "D1: eligible 1 + na 1 + perfect 1 → roi_actions 1건 (eligible만 포함)"
else
    fail "D1: compute_roi_actions 결과 오류. output: $D1_OUT"
fi

# D2: na=True만 있는 경우 → roi_actions == [] (올바른 0건)
D2_OUT=$(python3 -c "
import sys; sys.path.insert(0, '$SCORER_DIR')
from categories_ops import compute_roi_actions
from utils import CategoryResult, Check
from dataclasses import asdict

c_na = Check(name='na-only', passed=False, score=0.0, max_score=3.0,
             detail='na', action='excluded', roi_effort='단기', roi_impact=1.0, na=True)
cat = CategoryResult(id='t', name_ko='테스트', score=0.0, max_score=3,
                     grade='F', color='red',
                     checks=[asdict(c_na)], top_actions=[])
result = compute_roi_actions([cat])
assert result == [], f'expected [], got {result}'
print('ok')
" 2>&1)
if [ "$D2_OUT" = "ok" ]; then
    ok "D2: na=True 전체 → roi_actions [] (올바른 0건 — 버그와 구분됨)"
else
    fail "D2: na-only 배제 오류. output: $D2_OUT"
fi

echo ""
echo "=== Summary ==="
echo "PASS: $PASS / $((PASS+FAIL))"
if [ "$FAIL" -gt 0 ]; then
    echo "FAIL: $FAIL"
    exit 1
fi

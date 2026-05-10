#!/usr/bin/env bash
# smoke-scope-contract.sh — approval 게이트 + out_of_scope 의무 검증 (v2.1, era 자동 식별)
# v2.1 갱신 (v2.0_workflow-word-fidelity 2026-05-10):
#   era 자동 식별 — 산출 파일명 자체로 분기 (D10, ARCHITECTURE.md § 6 era 정책)
#     · 9-stage era (v2.0+): INTENT.md + APPROVE.md + PROPOSE.md 동시 존재
#     · 7-stage era (v1.0~v1.4): PLAN.md 존재 + INTENT/APPROVE/PROPOSE 부재
#     · 4-tier era (v1.84~v1.88): JSON block 없음 → 자동 SKIP
#   Stage 1: INTENT.out_of_scope (9-stage) 또는 PLAN.out_of_scope (7-stage) 비어있지 않음
#   Stage 2: execute/ 파일 존재 milestone → APPROVE.md.approval.approved_by = "user" (9-stage)
#            또는 DESIGN.approval.approved_by = "user" (7-stage)
#            (approve gate — EXECUTE 진입 전 사용자 명시 승인 강제)
#   Stage 3: claude/commands/harness-meta.md approval.approved_by 안내 존재 (인프라)
#
# Usage:
#   bash tests/smoke-scope-contract.sh        # 검증 (default)
#   bash tests/smoke-scope-contract.sh --help
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/harness-meta")}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0; SKIP=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }
skip() { echo "  - $1 (SKIP)"; SKIP=$((SKIP+1)); }

usage() {
    cat <<'USAGE'
Usage: bash tests/smoke-scope-contract.sh

approval 게이트 + out_of_scope 의무 검증 (era 자동 식별).
enumerate: projects/*/milestones/v*_*/ — 산출 파일명 자체로 9-stage / 7-stage / 4-tier 분기.
9-stage era (v2.0+) = INTENT/APPROVE 검증, 7-stage era (v1.0~v1.4) = PLAN/DESIGN.approval 검증.
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help|-h) usage; exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *) echo "Unknown argument: $1" >&2; exit 2 ;;
    esac
done

# Python3: PLAN.out_of_scope 비어있지 않음 검증
# stdout: "OK" | "SKIP:no-json-block" | "FAIL:<reason>"
check_out_of_scope() {
    local file="$1"
    python3 - "$file" <<'PYEOF'
import sys, re, json
from pathlib import Path

fp = Path(sys.argv[1])
try:
    content = fp.read_text(encoding='utf-8', errors='replace')
except Exception as e:
    print(f"FAIL:read-error:{e}")
    sys.exit(0)

m = re.search(r'```json\n(.*?)\n```', content, re.DOTALL)
if not m:
    print("SKIP:no-json-block")
    sys.exit(0)

try:
    obj = json.loads(m.group(1))
except json.JSONDecodeError as e:
    print(f"FAIL:json-parse-error:{e}")
    sys.exit(0)

if "out_of_scope" not in obj:
    print("FAIL:out_of_scope 필드 없음")
elif not isinstance(obj["out_of_scope"], list):
    print("FAIL:out_of_scope가 list가 아님")
elif len(obj["out_of_scope"]) == 0:
    print("FAIL:out_of_scope 빈 배열 (명시적 항목 1건 이상 필요)")
else:
    print("OK")
PYEOF
}

# Python3: DESIGN.approval.approved_by = "user" 검증
# stdout: "OK" | "SKIP:no-json-block" | "SKIP:no-approval" | "FAIL:<reason>"
check_approval() {
    local file="$1"
    python3 - "$file" <<'PYEOF'
import sys, re, json
from pathlib import Path

fp = Path(sys.argv[1])
try:
    content = fp.read_text(encoding='utf-8', errors='replace')
except Exception as e:
    print(f"FAIL:read-error:{e}")
    sys.exit(0)

m = re.search(r'```json\n(.*?)\n```', content, re.DOTALL)
if not m:
    print("SKIP:no-json-block")
    sys.exit(0)

try:
    obj = json.loads(m.group(1))
except json.JSONDecodeError as e:
    print(f"FAIL:json-parse-error:{e}")
    sys.exit(0)

approval = obj.get("approval")
if approval is None:
    print("SKIP:no-approval-field")
    sys.exit(0)

approved_by = approval.get("approved_by")
if approved_by == "user":
    print("OK")
elif approved_by is None:
    print("FAIL:approval.approved_by=null (미승인 상태에서 EXECUTE 진입 금지)")
else:
    print(f"FAIL:approval.approved_by='{approved_by}' ('user' 필요)")
PYEOF
}

# era 자동 식별 (D10): "9-stage" | "7-stage" | "skip"
detect_era() {
    local mdir="$1"
    if [ -f "${mdir}INTENT.md" ] && [ -f "${mdir}APPROVE.md" ] && [ -f "${mdir}PROPOSE.md" ]; then
        echo "9-stage"
    elif [ -f "${mdir}PLAN.md" ]; then
        echo "7-stage"
    else
        echo "skip"
    fi
}

# milestone 디렉토리 열거
shopt -s nullglob
milestone_dirs=(projects/*/milestones/v*_*/)
shopt -u nullglob

if [ "${#milestone_dirs[@]}" -eq 0 ]; then
    fail "milestone 디렉토리 0건 (projects/*/milestones/v*_*/ 없음)"
    echo ""
    echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
    exit 1
fi

# ─── Stage 1 — out_of_scope 비어있지 않음 (era 분기) ─────────────────────────
echo "=== Stage 1 — INTENT.out_of_scope (9-stage) 또는 PLAN.out_of_scope (7-stage) 비어있지 않음 ==="

for mdir in "${milestone_dirs[@]}"; do
    label=$(echo "$mdir" | sed 's|projects/\([^/]*\)/milestones/\([^/]*\)/|\1/\2|')
    era=$(detect_era "$mdir")
    case "$era" in
        9-stage) fp="${mdir}INTENT.md" ;;
        7-stage) fp="${mdir}PLAN.md" ;;
        skip)    skip "$label — 4-tier era 또는 INTENT/PLAN 모두 부재"; continue ;;
    esac

    if [ ! -f "$fp" ]; then
        skip "$label — $(basename "$fp") 부재 (era=$era)"
        continue
    fi
    result=$(check_out_of_scope "$fp")
    case "$result" in
        OK)     ok "$label ($era) — out_of_scope 비어있지 않음" ;;
        SKIP:*) skip "$label ($era) — legacy (no JSON block)" ;;
        FAIL:*) fail "$label ($era) — ${result#FAIL:}" ;;
    esac
done

# ─── Stage 2 — execute/ 존재 시 approval.approved_by = "user" (era 분기) ────
echo ""
echo "=== Stage 2 — execute/ 존재 시 approval.approved_by='user' (9-stage=APPROVE.md, 7-stage=DESIGN.md) ==="

for mdir in "${milestone_dirs[@]}"; do
    label=$(echo "$mdir" | sed 's|projects/\([^/]*\)/milestones/\([^/]*\)/|\1/\2|')
    era=$(detect_era "$mdir")

    # execute/ 하위에 phase-*.md 존재 여부
    shopt -s nullglob
    phase_files=("${mdir}execute/phase-"*.md)
    shopt -u nullglob

    if [ "${#phase_files[@]}" -eq 0 ]; then
        skip "$label — execute/ 없음 (approve gate 미적용)"
        continue
    fi

    case "$era" in
        9-stage) gate_fp="${mdir}APPROVE.md" ;;
        7-stage) gate_fp="${mdir}DESIGN.md" ;;
        skip)    skip "$label — 4-tier era 또는 era 미식별"; continue ;;
    esac

    if [ ! -f "$gate_fp" ]; then
        fail "$label ($era) — execute/ 있으나 $(basename "$gate_fp") 부재"
        continue
    fi

    result=$(check_approval "$gate_fp")
    case "$result" in
        OK)     ok "$label ($era) — $(basename "$gate_fp").approval.approved_by='user'" ;;
        SKIP:no-json-block) skip "$label ($era) — $(basename "$gate_fp") legacy (no JSON block)" ;;
        SKIP:no-approval-field) skip "$label ($era) — $(basename "$gate_fp") approval 필드 없음 (legacy)" ;;
        FAIL:*) fail "$label ($era) — ${result#FAIL:}" ;;
    esac
done

# ─── Stage 3 — harness-meta.md DESIGN.approval 안내 존재 ─────────────────────
echo ""
echo "=== Stage 3 — harness-meta.md DESIGN.approval 안내 존재 ==="

CMD="claude/commands/harness-meta.md"
if [ ! -f "$CMD" ]; then
    fail "$CMD 파일 없음"
else
    if grep -q 'approval.approved_by' "$CMD"; then
        ok "$CMD approval.approved_by 안내 존재"
    else
        fail "$CMD approval.approved_by 안내 없음"
    fi
    if grep -q 'EXECUTE.*진입.*금지\|미승인.*EXECUTE.*금지' "$CMD"; then
        ok "$CMD EXECUTE 진입 금지 규칙 존재"
    else
        fail "$CMD EXECUTE 진입 금지 규칙 없음"
    fi
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

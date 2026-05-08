#!/usr/bin/env bash
# smoke-scope-contract.sh — DESIGN.approval 게이트 + out_of_scope 의무 검증 (v2.0)
# v2.0 재작성 (v1.1_smoke-precommit-rewrite 2026-05-08):
#   sessions/ 기반 로직 제거 → projects/*/milestones/v*_*/ 열거
#   Stage 1: PLAN.out_of_scope JSON 필드 비어있지 않음
#   Stage 2: execute/ 파일 존재 milestone → DESIGN.approval.approved_by = "user"
#            (approve gate — EXECUTE 진입 전 DESIGN 승인 강제)
#   Stage 3: claude/commands/harness-meta.md DESIGN.approval 안내 존재 (인프라)
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

DESIGN.approval 게이트 + out_of_scope 의무 검증.
enumerate: projects/*/milestones/v*_*/ — JSON block 없는 legacy milestone은 SKIP.
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

# ─── Stage 1 — PLAN.out_of_scope 비어있지 않음 ────────────────────────────────
echo "=== Stage 1 — PLAN.out_of_scope 비어있지 않음 ==="

for mdir in "${milestone_dirs[@]}"; do
    fp="${mdir}PLAN.md"
    label=$(echo "$mdir" | sed 's|projects/\([^/]*\)/milestones/\([^/]*\)/|\1/\2|')
    if [ ! -f "$fp" ]; then
        skip "$label — PLAN.md 부재"
        continue
    fi
    result=$(check_out_of_scope "$fp")
    case "$result" in
        OK)     ok "$label — out_of_scope 비어있지 않음" ;;
        SKIP:*) skip "$label — legacy (no JSON block)" ;;
        FAIL:*) fail "$label — ${result#FAIL:}" ;;
    esac
done

# ─── Stage 2 — execute/ 존재 시 DESIGN.approval.approved_by = "user" ─────────
echo ""
echo "=== Stage 2 — execute/ 존재 시 DESIGN.approval.approved_by = 'user' ==="

for mdir in "${milestone_dirs[@]}"; do
    label=$(echo "$mdir" | sed 's|projects/\([^/]*\)/milestones/\([^/]*\)/|\1/\2|')
    design_fp="${mdir}DESIGN.md"

    # execute/ 하위에 phase-*.md 존재 여부
    shopt -s nullglob
    phase_files=("${mdir}execute/phase-"*.md)
    shopt -u nullglob

    if [ "${#phase_files[@]}" -eq 0 ]; then
        skip "$label — execute/ 없음 (approve gate 미적용)"
        continue
    fi

    if [ ! -f "$design_fp" ]; then
        fail "$label — execute/ 있으나 DESIGN.md 부재"
        continue
    fi

    result=$(check_approval "$design_fp")
    case "$result" in
        OK)     ok "$label — DESIGN.approval.approved_by='user'" ;;
        SKIP:no-json-block) skip "$label — legacy DESIGN (no JSON block)" ;;
        SKIP:no-approval-field) skip "$label — DESIGN.approval 필드 없음 (legacy)" ;;
        FAIL:*) fail "$label — ${result#FAIL:}" ;;
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

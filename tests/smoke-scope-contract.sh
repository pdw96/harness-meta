#!/usr/bin/env bash
# smoke-scope-contract.sh — approval 게이트 + out_of_scope 의무 검증 (v2.2, batched python)
# v2.2 갱신 (v2.1_smoke-spawn-batching 2026-05-10):
#   per-call python3 spawn (~34회) 패턴을 단일 batched python3 호출로 통합 (Stage 1+2).
#   Stage 3 (harness-meta.md grep) bash 유지 — Python 통합 효과 미미 + 가독성 (D3).
#   bash detect_era() 함수 제거 — Python def detect_era 일원화 (D5 옵션 e).
#   동일 검증 로직 / 출력 / exit code 보존 (baseline PASS=15 FAIL=0 SKIP=23 동치).
# v2.1 (v2.0_workflow-word-fidelity 2026-05-10):
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

usage() {
    cat <<'USAGE'
Usage: bash tests/smoke-scope-contract.sh

approval 게이트 + out_of_scope 의무 검증 (era 자동 식별 + batched python).
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

# Stage 1+2 — 단일 batched python3 호출 (Stage 3 bash 유지, D3).
# Python 카운트는 COUNT_FILE 경로로 전달 — bash 가 read 후 Stage 3 와 합산.
COUNT_FILE=$(mktemp)
export COUNT_FILE

python3 <<'PYEOF'
import os
import sys
import re
import json
from pathlib import Path

# Windows cp949 콘솔에서 한글/em dash UnicodeEncodeError 회피 (smoke-python-entry-boilerplate § P2 v1.87)
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

PASS = 0
FAIL = 0
SKIP = 0


def ok(msg):
    global PASS
    print(f"  ✓ {msg}", flush=True)
    PASS += 1


def fail(msg):
    global FAIL
    print(f"  ✗ {msg}", flush=True)
    FAIL += 1


def skip(msg):
    global SKIP
    print(f"  - {msg} (SKIP)", flush=True)
    SKIP += 1


def detect_era(mdir):
    """era 자동 식별 (D5/D15 일원화 source) — 9-stage / 7-stage / skip"""
    if (mdir / "INTENT.md").is_file() and (mdir / "APPROVE.md").is_file() and (mdir / "PROPOSE.md").is_file():
        return "9-stage"
    if (mdir / "PLAN.md").is_file():
        return "7-stage"
    if (mdir / "INTENT.md").is_file():
        # historical 7-stage era milestone (PLAN.md → INTENT.md migrate, hotfix 43472b7)
        return "7-stage"
    return "skip"


def extract_json(fp):
    try:
        content = fp.read_text(encoding='utf-8', errors='replace')
    except Exception as e:
        return None, f"read-error:{e}"
    m = re.search(r'```json\n(.*?)\n```', content, re.DOTALL)
    if not m:
        return None, "no-json-block"
    try:
        obj = json.loads(m.group(1))
    except json.JSONDecodeError as e:
        return None, f"json-parse-error:{e}"
    return obj, None


def check_out_of_scope(fp, label, era):
    """Stage 1 — out_of_scope 비어있지 않음 (per-milestone try/except 격리, R2/D6)"""
    try:
        obj, err = extract_json(fp)
        if err == "no-json-block":
            skip(f"{label} ({era}) — legacy (no JSON block)")
            return
        if err is not None:
            fail(f"{label} ({era}) — {err}")
            return
        if "out_of_scope" not in obj:
            fail(f"{label} ({era}) — out_of_scope 필드 없음")
        elif not isinstance(obj["out_of_scope"], list):
            fail(f"{label} ({era}) — out_of_scope가 list가 아님")
        elif len(obj["out_of_scope"]) == 0:
            fail(f"{label} ({era}) — out_of_scope 빈 배열 (명시적 항목 1건 이상 필요)")
        else:
            ok(f"{label} ({era}) — out_of_scope 비어있지 않음")
    except Exception as e:
        fail(f"{label} ({era}) — unexpected: {e}")


def check_approval(fp, label, era):
    """Stage 2 — approval.approved_by='user' (per-milestone try/except 격리)"""
    gate_basename = fp.name
    try:
        obj, err = extract_json(fp)
        if err == "no-json-block":
            skip(f"{label} ({era}) — {gate_basename} legacy (no JSON block)")
            return
        if err is not None:
            fail(f"{label} ({era}) — {err}")
            return
        approval = obj.get("approval")
        if approval is None:
            skip(f"{label} ({era}) — {gate_basename} approval 필드 없음 (legacy)")
            return
        approved_by = approval.get("approved_by")
        if approved_by == "user":
            ok(f"{label} ({era}) — {gate_basename}.approval.approved_by='user'")
        elif approved_by is None:
            fail(f"{label} ({era}) — approval.approved_by=null (미승인 상태에서 EXECUTE 진입 금지)")
        else:
            fail(f"{label} ({era}) — approval.approved_by='{approved_by}' ('user' 필요)")
    except Exception as e:
        fail(f"{label} ({era}) — unexpected: {e}")


def main():
    milestone_dirs = sorted(Path("projects").glob("*/milestones/v*_*"))
    milestone_dirs = [d for d in milestone_dirs if d.is_dir()]

    if not milestone_dirs:
        fail("milestone 디렉토리 0건 (projects/*/milestones/v*_*/ 없음)")
        return

    # Stage 1 — out_of_scope (era 분기)
    print("=== Stage 1 — INTENT.out_of_scope (9-stage) 또는 PLAN.out_of_scope (7-stage) 비어있지 않음 ===")
    for mdir in milestone_dirs:
        label = f"{mdir.parent.parent.name}/{mdir.name}"
        era = detect_era(mdir)
        if era == "9-stage":
            fp = mdir / "INTENT.md"
        elif era == "7-stage":
            # bash 동치: era="7-stage" 분류는 PLAN.md 또는 historical INTENT.md 둘 다 포함하나
            # Stage 1 검증 대상은 PLAN.md 만 (historical migrate 의 INTENT.md 검증 누락은
            # bash 원본 동작 — 후속 milestone 으로 별도 검토. D8 baseline 동치 의무).
            fp = mdir / "PLAN.md"
        else:
            skip(f"{label} — 4-tier era 또는 INTENT/PLAN 모두 부재")
            continue

        if not fp.is_file():
            skip(f"{label} — {fp.name} 부재 (era={era})")
            continue
        check_out_of_scope(fp, label, era)

    # Stage 2 — approval gate (era 분기)
    print()
    print("=== Stage 2 — execute/ 존재 시 approval.approved_by='user' (9-stage=APPROVE.md, 7-stage=DESIGN.md) ===")
    for mdir in milestone_dirs:
        label = f"{mdir.parent.parent.name}/{mdir.name}"
        era = detect_era(mdir)
        execute_dir = mdir / "execute"
        phase_files = sorted(execute_dir.glob("phase-*.md")) if execute_dir.is_dir() else []

        if not phase_files:
            skip(f"{label} — execute/ 없음 (approve gate 미적용)")
            continue

        if era == "9-stage":
            gate_fp = mdir / "APPROVE.md"
        elif era == "7-stage":
            gate_fp = mdir / "DESIGN.md"
        else:
            skip(f"{label} — 4-tier era 또는 era 미식별")
            continue

        if not gate_fp.is_file():
            fail(f"{label} ({era}) — execute/ 있으나 {gate_fp.name} 부재")
            continue
        check_approval(gate_fp, label, era)


main()

# 카운트를 bash 합산용으로 파일에 기록 (Stage 3 와 합산 후 최종 출력)
with open(os.environ['COUNT_FILE'], 'w', encoding='utf-8') as f:
    f.write(f"{PASS} {FAIL} {SKIP}\n")
PYEOF

# Python 카운트 read (Stage 1+2)
read -r PASS FAIL SKIP < "$COUNT_FILE"
rm -f "$COUNT_FILE"

# Stage 3 — harness-meta.md DESIGN.approval 안내 존재 (bash 유지, D3)
echo ""
echo "=== Stage 3 — harness-meta.md DESIGN.approval 안내 존재 ==="

CMD="claude/commands/harness-meta.md"
if [ ! -f "$CMD" ]; then
    echo "  ✗ $CMD 파일 없음"
    FAIL=$((FAIL+1))
else
    if grep -q 'approval.approved_by' "$CMD"; then
        echo "  ✓ $CMD approval.approved_by 안내 존재"
        PASS=$((PASS+1))
    else
        echo "  ✗ $CMD approval.approved_by 안내 없음"
        FAIL=$((FAIL+1))
    fi
    if grep -q 'EXECUTE.*진입.*금지\|미승인.*EXECUTE.*금지' "$CMD"; then
        echo "  ✓ $CMD EXECUTE 진입 금지 규칙 존재"
        PASS=$((PASS+1))
    else
        echo "  ✗ $CMD EXECUTE 진입 금지 규칙 없음"
        FAIL=$((FAIL+1))
    fi
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

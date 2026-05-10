#!/usr/bin/env bash
# smoke-spec-verification.sh — milestone 산출물 JSON schema 정합 검증 (v2.1, era 자동 식별)
# v2.1 갱신 (v2.0_workflow-word-fidelity 2026-05-10):
#   era 자동 식별 — 산출 파일명 자체로 분기 (D10, ARCHITECTURE.md § 6 era 정책)
#     · 9-stage era (v2.0+): INTENT.md + APPROVE.md + PROPOSE.md 동시 존재 → 7종 검증
#     · 7-stage era (v1.0~v1.4): PLAN.md 존재 + INTENT/APPROVE/PROPOSE 부재 → 5종 검증
#     · 4-tier era (v1.84~v1.88): JSON block 없음 → 자동 SKIP
#   각 stage 별 milestone 부재 시 SKIP (era 자동 분기)
#
# Stage 1 (7-stage era): PLAN.md     — id, title, goal, success_criteria, out_of_scope
# Stage 2 (9-stage era): INTENT.md   — id, title, goal, success_criteria, out_of_scope
# Stage 3 (era 공통):    RESEARCH.md — external, codebase, options, risks_identified
# Stage 4 (era 공통):    DESIGN.md   — decisions, phases (approval 검증은 smoke-scope-contract 책임)
# Stage 5 (9-stage era): APPROVE.md  — approval (approved_by + date)
# Stage 6 (era 공통):    VERIFY.md   — verdict, criteria_check
# Stage 7 (era 공통):    REPORT.md   — summary (next_candidates 책임은 PROPOSE 로 이전)
# Stage 8 (9-stage era): PROPOSE.md  — next_candidates
# Stage 9 (era 공통):    execute/phase-{n}.md — phase, status (파일명 regex 검증 포함)
#
# Usage:
#   bash tests/smoke-spec-verification.sh        # 검증 (default)
#   bash tests/smoke-spec-verification.sh --help
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/harness-meta")}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0; SKIP=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }
skip() { echo "  - $1 (SKIP)"; SKIP=$((SKIP+1)); }

usage() {
    cat <<'USAGE'
Usage: bash tests/smoke-spec-verification.sh

milestone 산출물 JSON schema 정합 검증 (era 자동 식별).
enumerate: projects/*/milestones/v*_*/ — JSON block 없는 4-tier era milestone (v1.84~v1.88) 은 SKIP.
9-stage era (v2.0+) 와 7-stage era (v1.0~v1.4) 는 산출 파일명 자체로 자동 분기.
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help|-h) usage; exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *) echo "Unknown argument: $1" >&2; exit 2 ;;
    esac
done

# Python3: JSON block 추출 + 필수 필드 검증
# stdout: "OK" | "SKIP:no-json-block" | "FAIL:<missing fields csv>"
check_json_fields() {
    local file="$1"
    shift
    local required=("$@")

    python3 - "$file" "${required[@]}" <<'PYEOF'
import sys, re, json
from pathlib import Path

fp   = Path(sys.argv[1])
reqs = sys.argv[2:]

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

missing = [f for f in reqs if f not in obj]
if missing:
    print("FAIL:" + ",".join(missing))
else:
    print("OK")
PYEOF
}

# execute/phase-{n}.md 파일명 regex 검증 + JSON schema
check_execute_phase() {
    local file="$1"
    local fname
    fname=$(basename "$file")

    if ! echo "$fname" | grep -qE '^phase-[0-9]+\.md$'; then
        fail "execute/ 파일명 위반: $file (expected phase-N.md)"
        return
    fi

    local result
    result=$(check_json_fields "$file" "phase" "status")
    case "$result" in
        OK)   ok "$file — phase/status OK" ;;
        SKIP:*) skip "$file — legacy (no JSON block)" ;;
        FAIL:*) fail "$file — 필드 누락: ${result#FAIL:}" ;;
    esac
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

# helper: artifact 검증 (stage header + per-milestone loop)
check_stage() {
    local stage_label="$1"
    local artifact="$2"
    shift 2
    local required=("$@")

    echo ""
    echo "=== $stage_label — $artifact JSON schema ==="
    for mdir in "${milestone_dirs[@]}"; do
        local fp="${mdir}${artifact}"
        local label
        label=$(echo "$mdir" | sed 's|projects/\([^/]*\)/milestones/\([^/]*\)/|\1/\2|')
        if [ ! -f "$fp" ]; then
            skip "$label — $artifact 부재"
            continue
        fi
        local result
        result=$(check_json_fields "$fp" "${required[@]}")
        case "$result" in
            OK)     ok "$label — 필수 필드 OK" ;;
            SKIP:*) skip "$label — legacy (no JSON block)" ;;
            FAIL:*) fail "$label — 필드 누락: ${result#FAIL:}" ;;
        esac
    done
}

# Stage 1 — PLAN (7-stage era; 부재 시 SKIP)
check_stage "Stage 1 (7-stage era)" "PLAN.md" "id" "title" "goal" "success_criteria" "out_of_scope"

# Stage 2 — INTENT (9-stage era; 부재 시 SKIP)
check_stage "Stage 2 (9-stage era)" "INTENT.md" "id" "title" "goal" "success_criteria" "out_of_scope"

# Stage 3 — RESEARCH (era 공통)
check_stage "Stage 3" "RESEARCH.md" "external" "codebase" "options" "risks_identified"

# Stage 4 — DESIGN (era 공통; approval 검증은 smoke-scope-contract 책임으로 이전)
check_stage "Stage 4" "DESIGN.md" "decisions" "phases"

# Stage 5 — APPROVE (9-stage era; 부재 시 SKIP — DESIGN.approval era 보존은 smoke-scope-contract 가 분기 검증)
check_stage "Stage 5 (9-stage era)" "APPROVE.md" "approval"

# Stage 6 — VERIFY (era 공통)
check_stage "Stage 6" "VERIFY.md" "verdict" "criteria_check"

# Stage 7 — REPORT (era 공통; next_candidates 책임은 PROPOSE 로 분리)
check_stage "Stage 7" "REPORT.md" "summary"

# Stage 8 — PROPOSE (9-stage era; 부재 시 SKIP)
check_stage "Stage 8 (9-stage era)" "PROPOSE.md" "next_candidates"

# Stage 9 — execute/phase-{n}.md (era 공통)
echo ""
echo "=== Stage 9 — execute/phase-{n}.md 파일명 + JSON schema ==="
shopt -s nullglob
execute_files=(projects/*/milestones/v*_*/execute/phase-*.md)
step_files=(projects/*/milestones/v*_*/execute/step*.md)
shopt -u nullglob

if [ "${#step_files[@]}" -gt 0 ]; then
    for sf in "${step_files[@]}"; do
        fail "execute/ 파일명 위반: $sf (step{N}.md 금지 — phase-{N}.md 사용)"
    done
fi

if [ "${#execute_files[@]}" -eq 0 ]; then
    skip "Stage 6 — execute/phase-*.md 0건"
else
    for ef in "${execute_files[@]}"; do
        check_execute_phase "$ef"
    done
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

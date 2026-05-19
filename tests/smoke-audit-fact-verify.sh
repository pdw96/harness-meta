#!/usr/bin/env bash
# smoke-audit-fact-verify.sh
#
# Purpose: v6.6 audit chain hallucination 자동 검출 mechanism (scripts/audit_fact_verify.py) 의
#   fixture-based contract 검증. v5.13 정전화 3 method (boolean/표/수치) script-only detect 가
#   각 fixture case 에서 expected exit code (PASS 0 / FAIL 1) 반환하는지 검증.
#
# 검증 scope (D4 6 fixture sub-dir):
#   - tests/fixtures/audit-fact-verify/boolean-normal/ (expected exit 0)
#   - tests/fixtures/audit-fact-verify/boolean-mismatch/ (expected exit 1)
#   - tests/fixtures/audit-fact-verify/table-normal/ (expected exit 0)
#   - tests/fixtures/audit-fact-verify/table-mismatch/ (expected exit 1)
#   - tests/fixtures/audit-fact-verify/numeric-normal/ (expected exit 0, lookup empty no-op)
#   - tests/fixtures/audit-fact-verify/empty-targets/ (expected exit 0, no detect targets)
#
# 본 smoke 책임 = script contract 검증 (read-only). script logic 단일 source = scripts/audit_fact_verify.py.
#
# 활성: pre-commit hook (local 11건째 등재, v6.6_audit-chain-hallucination-auto-correction).
# Algo: V1 (python3 + fixture sub-dir + expected exit code).
# python3 부재 시 SKIP exit 0 (환경 가드).
#
# v3.21 narrative 정전화 3 단계 패턴 cycle 32 (mechanism creation 본질 1차 source = phase-1).

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

SCRIPT="scripts/audit_fact_verify.py"
FIXTURE_DIR="tests/fixtures/audit-fact-verify"

PASS=0
FAIL=0
SKIP=0

# python3 환경 가드
if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-audit-fact-verify: SKIP (python3 not available)" >&2
    exit 0
fi

# script 부재 시 SKIP (mechanism 미설치 환경)
if [[ ! -f "$SCRIPT" ]]; then
    echo "smoke-audit-fact-verify: SKIP ($SCRIPT not found)" >&2
    exit 0
fi

# fixture 디렉토리 부재 시 SKIP
if [[ ! -d "$FIXTURE_DIR" ]]; then
    echo "smoke-audit-fact-verify: SKIP ($FIXTURE_DIR not found)" >&2
    exit 0
fi

run_case() {
    local case_name="$1"
    local expected_exit="$2"
    local case_dir="$FIXTURE_DIR/$case_name"

    if [[ ! -d "$case_dir" ]]; then
        echo "  ✗ $case_name: fixture sub-dir missing"
        FAIL=$((FAIL+1))
        return
    fi

    set +e
    python3 "$SCRIPT" --dir "$case_dir" >/dev/null 2>&1
    local actual_exit=$?
    set -e

    if [[ "$actual_exit" -eq "$expected_exit" ]]; then
        echo "  ✓ $case_name (exit=$actual_exit, expected=$expected_exit)"
        PASS=$((PASS+1))
    else
        echo "  ✗ $case_name (exit=$actual_exit, expected=$expected_exit)"
        FAIL=$((FAIL+1))
    fi
}

echo "=== Stage 1 — boolean method (cycle 2 v5.11 evidence) ==="
run_case "boolean-normal" 0
run_case "boolean-mismatch" 1

echo "=== Stage 2 — table method (cycle 1+3 v5.10/v5.12 evidence) ==="
run_case "table-normal" 0
run_case "table-mismatch" 1

echo "=== Stage 3 — numeric method (v5.13 정전화, lookup empty no-op) ==="
run_case "numeric-normal" 0

echo "=== Stage 4 — edge case (empty targets, no detect) ==="
run_case "empty-targets" 0

echo "=== Stage 5 — path traversal 차단 (D10 보안 P1#1) ==="
set +e
python3 "$SCRIPT" --dir "/etc" >/dev/null 2>&1
TRAVERSAL_EXIT=$?
set -e
if [[ "$TRAVERSAL_EXIT" -eq 2 ]]; then
    echo "  ✓ /etc reject (exit=2)"
    PASS=$((PASS+1))
else
    echo "  ✗ /etc reject (exit=$TRAVERSAL_EXIT, expected=2)"
    FAIL=$((FAIL+1))
fi

echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
exit $((FAIL == 0 ? 0 : 1))

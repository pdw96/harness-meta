#!/usr/bin/env bash
# smoke-scorer-output-newline.sh — v1.70 ai-ready-scorer CRLF 회귀 방지
#
# 정적 2 + 동적 3 = 5 checks
#  S1: score_codebase.py write_text에 newline= 인자 선언 존재
#  S2: html_renderer.py 동상
#  D1: scorer 실행 exit 0 (harness-meta 대상, --output-dir tmpdir)
#  D2: ai-ready-report.json CRLF=0 (byte-level, sys.argv 경로 전달)
#  D3: ai-ready-dashboard.html CRLF=0 (byte-level)
#
# Note: Python 경로 검증은 sys.argv 경유로 수행 — bash /tmp (MSYS 경로)를
# Python -c 문자열에 직접 삽입하면 Windows Python이 경로를 찾지 못함.
# sys.argv 인자 전달 시 MSYS2가 자동으로 Windows 경로로 번역.

set -euo pipefail

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "${HARNESS_META_ROOT:-$HOME/harness-meta}")
SCORER_DIR="$ROOT/skills/ai-ready-scorer/scripts"
SCORE_PY="$SCORER_DIR/score_codebase.py"
HTML_PY="$SCORER_DIR/html_renderer.py"

PASS=0
FAIL=0

ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

echo "=== smoke-scorer-output-newline.sh (v1.70) ==="

# Stage 1 — 정적: 소스 코드 grep
echo "[Stage 1] 정적 — write_text newline= 선언 확인"

if grep -q 'newline=' "$SCORE_PY"; then
    ok "S1 score_codebase.py — write_text newline= 선언 존재"
else
    fail "S1 score_codebase.py — newline= 선언 누락 (v1.69 fix 소실 의심)"
fi

if grep -q 'newline=' "$HTML_PY"; then
    ok "S2 html_renderer.py — write_text newline= 선언 존재"
else
    fail "S2 html_renderer.py — newline= 선언 누락 (v1.69 fix 소실 의심)"
fi

# Stage 2 — 동적: 실 산출물 CRLF byte-level 검증
echo "[Stage 2] 동적 — scorer 실행 + 산출물 CRLF=0 검증"

TMPOUT=$(mktemp -d)
trap 'rm -rf "$TMPOUT"' EXIT

JSON_PATH="$TMPOUT/ai-ready-report.json"
HTML_PATH="$TMPOUT/ai-ready-dashboard.html"

if python3 "$SCORE_PY" "$ROOT" --output-dir "$TMPOUT" > /dev/null 2>&1; then
    ok "D1 scorer 실행 exit 0 (harness-meta 대상)"

    # D2: JSON CRLF 검증 (sys.argv 경유 — MSYS /tmp → Windows path 자동 번역)
    CRLF_JSON=$(python3 -c "import sys; d=open(sys.argv[1],'rb').read(); print(d.count(b'\r\n'))" "$JSON_PATH" 2>/dev/null || echo "ERROR")
    if [ "$CRLF_JSON" = "0" ]; then
        ok "D2 JSON CRLF=0 (Pure LF 확인)"
    elif [ "$CRLF_JSON" = "ERROR" ]; then
        fail "D2 JSON 파일 읽기 실패 (파일 부재 또는 오류)"
    else
        fail "D2 JSON CRLF=${CRLF_JSON}건 — v1.69 fix 회귀"
    fi

    # D3: HTML CRLF 검증 (동상)
    CRLF_HTML=$(python3 -c "import sys; d=open(sys.argv[1],'rb').read(); print(d.count(b'\r\n'))" "$HTML_PATH" 2>/dev/null || echo "ERROR")
    if [ "$CRLF_HTML" = "0" ]; then
        ok "D3 HTML CRLF=0 (Pure LF 확인)"
    elif [ "$CRLF_HTML" = "ERROR" ]; then
        fail "D3 HTML 파일 읽기 실패 (파일 부재 또는 오류)"
    else
        fail "D3 HTML CRLF=${CRLF_HTML}건 — v1.69 fix 회귀"
    fi
else
    fail "D1 scorer 실행 실패 — D2/D3 skip"
    fail "D2 skip (D1 실패)"
    fail "D3 skip (D1 실패)"
fi

echo ""
echo "=== 결과: $PASS PASS / $FAIL FAIL ==="

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0

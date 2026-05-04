#!/usr/bin/env bash
# v1.23 smoke — verify.sh + verify-lib.sh + verify.ps1 stage H/I parity
# 정적 5 + dynamic 3 = 8 checks (dynamic은 bash 4+ + python3 가용 시만)
set -u
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT" || { echo "FAIL — HARNESS_META_ROOT not found: $HARNESS_META_ROOT"; exit 1; }

PASS=0
FAIL=0

ok()   { echo "  [OK] $*"; PASS=$((PASS + 1)); }
fail() { echo "  [FAIL] $*"; FAIL=$((FAIL + 1)); }

echo "=== Stage 1 — 정적 5 checks ==="

# S1.1 — verify.sh 존재 + executable
if [ -f verify.sh ] && [ -x verify.sh ]; then
    ok "S1.1 verify.sh 존재 + executable bit"
else
    fail "S1.1 verify.sh 부재 또는 non-executable"
fi

# S1.2 — verify-lib.sh 존재 + test_symlink_integrity 함수
if [ -f verify-lib.sh ] && grep -qE '^test_symlink_integrity\(\)' verify-lib.sh; then
    ok "S1.2 verify-lib.sh + test_symlink_integrity()"
else
    fail "S1.2 verify-lib.sh 또는 test_symlink_integrity() 부재"
fi

# S1.3 — verify.ps1 stage H/I 신설 grep
ps_h=$(grep -cE 'H\. Overlay' verify.ps1 2>/dev/null)
ps_i=$(grep -cE 'I\. Frontmatter' verify.ps1 2>/dev/null)
if [ "${ps_h:-0}" -ge 1 ] && [ "${ps_i:-0}" -ge 1 ]; then
    ok "S1.3 verify.ps1 Stage H/I 신설"
else
    fail "S1.3 verify.ps1 H=${ps_h:-0} I=${ps_i:-0} (각 1+ 기대)"
fi

# S1.4 — verify.sh stage H/I mirror grep
sh_h=$(grep -cE 'H\. Overlay' verify.sh 2>/dev/null)
sh_i=$(grep -cE 'I\. Frontmatter' verify.sh 2>/dev/null)
if [ "${sh_h:-0}" -ge 1 ] && [ "${sh_i:-0}" -ge 1 ]; then
    ok "S1.4 verify.sh Stage H/I mirror"
else
    fail "S1.4 verify.sh H=${sh_h:-0} I=${sh_i:-0} (각 1+ 기대)"
fi

# S1.5 — stage 순서 Z/A/B/C/D/E/F/H/I/G (양쪽 sh + ps1)
check_order() {
    local file="$1"
    local prev=0
    local stages="Z A B C D E F H I G"
    # shellcheck disable=SC2034  # local 선언, for 루프 내에서 할당 후 사용
    local stage_pat
    for s in $stages; do
        # B는 'B7. _base' 등에서도 매치되므로 stage 헤더 매치 패턴 사용:
        # sh: 'echo "${C_HEAD}== <S>. ' / ps1: 'Write-Host "== <S>. '
        ln=$(grep -nE "(echo .*\\\$\\{C_HEAD\\}== $s\.|Write-Host \"== $s\.)" "$file" 2>/dev/null | head -1 | cut -d: -f1)
        [ -z "$ln" ] && return 1
        if [ "$ln" -le "$prev" ]; then return 1; fi
        prev=$ln
    done
    return 0
}
if check_order verify.ps1 && check_order verify.sh; then
    ok "S1.5 stage 순서 Z/A/B/C/D/E/F/H/I/G (sh + ps1)"
else
    fail "S1.5 stage 순서 위반"
fi

echo ""
echo "=== Stage 2 — Dynamic 3 checks (bash 4+ + python3 가용 시만) ==="

# Dynamic precondition — Linux/Darwin + bash 4+ + python3
UNAME_S=$(uname -s 2>/dev/null || echo "")
if [ "$UNAME_S" != "Linux" ] && [ "$UNAME_S" != "Darwin" ]; then
    echo "  [SKIP] OS '$UNAME_S' (verify.sh는 Linux/Darwin 전용 — dynamic skip)"
    SKIP_DYNAMIC=1
elif [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
    echo "  [SKIP] bash < 4 (dynamic skip)"
    SKIP_DYNAMIC=1
elif ! command -v python3 >/dev/null 2>&1; then
    echo "  [SKIP] python3 부재 (dynamic skip)"
    SKIP_DYNAMIC=1
else
    SKIP_DYNAMIC=0
fi

if [ "$SKIP_DYNAMIC" -eq 0 ]; then
    # 임시 stdout 캡처
    OUT=$(mktemp)
    bash verify.sh "$HARNESS_META_ROOT" >"$OUT" 2>&1
    rc=$?

    # S2.1 — verify.sh 종료 코드 0 또는 1 (segfault/syntax error 없음)
    if [ "$rc" -eq 0 ] || [ "$rc" -eq 1 ]; then
        ok "S2.1 verify.sh exit code OK ($rc)"
    else
        fail "S2.1 verify.sh exit code 이상 ($rc)"
    fi

    # S2.2 — Stage H 출력에 "harness-python" 또는 "python" 매치 (overlay enumerate 정합)
    if grep -qE 'H1.*python' "$OUT"; then
        ok "S2.2 Stage H1 overlay enumerate (python 감지)"
    else
        fail "S2.2 Stage H1 'python' 미발견"
    fi

    # S2.3 — Stage I 출력에 I1~I5 5건 모두 등장 (색 escape 포괄)
    i_count=$(grep -cE 'I[1-5]\s' "$OUT" 2>/dev/null)
    if [ "${i_count:-0}" -ge 5 ]; then
        ok "S2.3 Stage I1~I5 모두 등장 (${i_count} line)"
    else
        fail "S2.3 Stage I 출력 부족 (${i_count:-0} line, 5+ 기대)"
    fi

    rm -f "$OUT"
else
    # SKIP은 PASS 카운트하지 않음 (정확)
    echo "  [INFO] dynamic 3건 SKIP — Linux/macOS 또는 WSL bash + python3 환경에서 검증"
fi

echo ""
TOTAL=$((PASS + FAIL))
if [ "$FAIL" -eq 0 ]; then
    echo "PASS — $PASS/$TOTAL"
    exit 0
else
    echo "FAIL — $PASS/$TOTAL ($FAIL fail)"
    exit 1
fi

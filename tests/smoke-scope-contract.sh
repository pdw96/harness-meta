#!/usr/bin/env bash
# v1.10j smoke — PLAN.md Scope contract 두 섹션 의무 검사
# Stage 1: v1.10h / v1.10h2 / v1.10j PLAN.md 에 두 섹션 존재 확인
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

check_plan() {
    local plan="$1"
    local label="$2"
    if grep -q '^## Scope inheritance' "$plan"; then
        ok "$label — '## Scope inheritance' 존재"
    else
        fail "$label — '## Scope inheritance' 누락"
    fi
    if grep -q '^## Out of scope' "$plan"; then
        ok "$label — '## Out of scope' 존재"
    else
        fail "$label — '## Out of scope' 누락"
    fi
}

# Stage 1 — 두 섹션 존재 (자동 enumerate, v1.11 갱신)
# v1.10h+ / v1.10j+ / v1.11+ glob 패턴 — 향후 세션 자동 흡수.
# v1.10h 이전 legacy 자연 제외.
echo "=== Stage 1 — PLAN.md Scope contract 두 섹션 존재 (자동 enumerate) ==="

shopt -s nullglob
plans=(
    sessions/meta/v1.10h*/PLAN.md
    sessions/meta/v1.10j*/PLAN.md
    sessions/meta/v1.11*/PLAN.md
    sessions/meta/v1.12*/PLAN.md
    sessions/meta/v1.13*/PLAN.md
    sessions/meta/v1.14*/PLAN.md
)
shopt -u nullglob

if [ "${#plans[@]}" -eq 0 ]; then
    fail "Stage 1 — PLAN.md glob 매치 0건 (예상치 못함)"
else
    for plan in "${plans[@]}"; do
        label=$(basename "$(dirname "$plan")" | sed 's/-.*//')
        check_plan "$plan" "$label"
    done
fi

# Stage 2 — OWNERSHIP.md Scope contract § 존재
echo ""
echo "=== Stage 2 — OWNERSHIP.md Scope contract § ==="

OWNERSHIP="bootstrap/docs/OWNERSHIP.md"
if grep -q '^## Scope contract' "$OWNERSHIP"; then
    ok "OWNERSHIP.md '## Scope contract' § 존재"
else
    fail "OWNERSHIP.md '## Scope contract' § 누락"
fi
if grep -q '위반 정책' "$OWNERSHIP"; then
    ok "OWNERSHIP.md '위반 정책' 표 존재"
else
    fail "OWNERSHIP.md '위반 정책' 표 누락"
fi

# Stage 3 — harness-meta.md Scope contract 안내 존재
echo ""
echo "=== Stage 3 — harness-meta.md Scope contract 안내 ==="

CMD="claude/commands/harness-meta.md"
if grep -q 'Scope inheritance' "$CMD"; then
    ok "harness-meta.md 'Scope inheritance' 안내 존재"
else
    fail "harness-meta.md 'Scope inheritance' 안내 누락"
fi
if grep -q 'Out of scope' "$CMD"; then
    ok "harness-meta.md 'Out of scope' 안내 존재"
else
    fail "harness-meta.md 'Out of scope' 안내 누락"
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

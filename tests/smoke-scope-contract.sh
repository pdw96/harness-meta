#!/usr/bin/env bash
# v1.10j smoke — PLAN.md Scope contract 두 섹션 의무 검사
# v1.33 확장 — `--fix` mode (§ skeleton 자동 삽입) + enumerate glob 자동 흡수
# Stage 1: PLAN.md 두 § 존재 (자동 enumerate v1.10h+ + v1.10j + v1.11~v1.99 + v2+)
# Stage 2: OWNERSHIP.md §Scope contract 존재
# Stage 3: harness-meta.md Scope contract 안내 존재
# Usage:
#   bash tests/smoke-scope-contract.sh                                # 검증만 (default 회귀 0)
#   bash tests/smoke-scope-contract.sh --fix                          # 두 § 누락 PLAN 모두 skeleton 삽입
#   bash tests/smoke-scope-contract.sh --fix --dry-run                # 변경 없이 plan만 출력
#   bash tests/smoke-scope-contract.sh --fix <path> [<path>...]       # 특정 PLAN.md 만 처리
#   bash tests/smoke-scope-contract.sh --help                         # usage
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0; SKIP=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }
skip() { echo "  - $1 (SKIP)"; SKIP=$((SKIP+1)); }

# v1.33 — argv 파싱
FIX_MODE=0
DRY_RUN=0
TARGET_PATHS=()
while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h)
            cat <<USAGE
Usage: $0 [--fix [--dry-run]] [<path>...]

Default mode (no args): Stage 1~3 § 의무 검사 (회귀 0).

--fix:        두 § 누락 PLAN에 OWNERSHIP.md §Scope contract 정합 skeleton 자동 삽입.
              위치: '## 세션 소속 근거' § 직후 → Scope inheritance, 그 직후 → Out of scope.
              TODO placeholder 잔존 — 사용자/SKILL이 채움.
              anchor '## 세션 소속 근거' 부재 시 FAIL (사용자 수동 작성 의무).
--dry-run:    --fix와 함께 — 변경 없이 plan만 출력.
<path>...:    특정 PLAN.md 경로만 처리. 없으면 default enumerate.
USAGE
            exit 0
            ;;
        --*)
            echo "Unknown option: $1 (try --help)" >&2
            exit 2
            ;;
        *)
            TARGET_PATHS+=("$1")
            ;;
    esac
    shift
done

# v1.33 — Skeleton 단일 소스 (OWNERSHIP.md §Scope contract verbatim 정합)
read -r -d '' SCOPE_INHERITANCE_SKELETON <<'SKELETON_EOF' || true

## Scope inheritance (verbatim from 선행 세션)

**Source — TODO `sessions/meta/vX.Y-.../PLAN.md` Out of scope 표 또는 사용자 발의 (verbatim)**:

> TODO — 원문 그대로 인용

**Parsed sub-items (N)**:

1. **TODO** — 설명

SKELETON_EOF

read -r -d '' OUT_OF_SCOPE_SKELETON <<'SKELETON_EOF' || true

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| TODO — 인접 발견 issue | TODO `vX.Y-{name}` 또는 "evidence-driven 시" |

SKELETON_EOF

# v1.33 — fix_section: 단일 § skeleton 삽입 (idempotent + dry-run)
fix_section() {
    local file="$1" section_name="$2" anchor="$3" skeleton_var="$4"
    local anchor_line insert_line total tmp

    # Idempotency: § 이미 존재
    if grep -qE "^## ${section_name}" "$file"; then
        ok "fix: $file — '## ${section_name}' 이미 존재 (no-op)"
        return 0
    fi

    # Anchor line
    anchor_line=$(grep -nE "$anchor" "$file" | head -1 | cut -d: -f1 || true)
    if [ -z "$anchor_line" ]; then
        fail "fix: $file — anchor '$anchor' 부재. fix 불가"
        return 1
    fi

    # 다음 ^## (anchor 이후) — 부재 시 EOF
    insert_line=$(awk -v a="$anchor_line" 'NR>a && /^## / { print NR; exit }' "$file")
    total=$(wc -l < "$file")
    [ -z "$insert_line" ] && insert_line=$((total + 1))

    if [ "$DRY_RUN" -eq 1 ]; then
        ok "fix: $file [dry-run] — Would insert '$section_name' skeleton at line $insert_line"
        return 0
    fi

    # 삽입: head + skeleton + tail
    tmp=$(mktemp)
    {
        head -n $((insert_line - 1)) "$file"
        printf '%s\n' "${!skeleton_var}"
        tail -n +"$insert_line" "$file"
    } > "$tmp"
    mv "$tmp" "$file"
    ok "fix: $file — '$section_name' skeleton 삽입 (line $insert_line)"
}

# v1.33 — fix_file: 한 PLAN.md에 두 § 모두 처리
fix_file() {
    local file="$1"
    [ -f "$file" ] || { fail "fix: $file — 파일 부재"; return 1; }
    case "$file" in
        */PLAN.md) ;;
        *) fail "fix: $file — PLAN.md만 지원"; return 1 ;;
    esac

    # D1: dry-run 두 § 모두 부재 시 통합 처리 (anchor offset 계산 회피)
    if [ "$DRY_RUN" -eq 1 ]; then
        local has_inh has_oos anchor_line
        if grep -qE '^## Scope inheritance' "$file"; then has_inh=1; else has_inh=0; fi
        if grep -qE '^## Out of scope' "$file"; then has_oos=1; else has_oos=0; fi
        if [ "$has_inh" -eq 0 ] && [ "$has_oos" -eq 0 ]; then
            anchor_line=$(grep -nE '^## 세션 소속 근거' "$file" | head -1 | cut -d: -f1 || true)
            if [ -n "$anchor_line" ]; then
                ok "fix: $file [dry-run] — Would insert both sections after '## 세션 소속 근거' (line $anchor_line)"
                return 0
            fi
        fi
    fi

    # Scope inheritance 먼저 (anchor: 세션 소속 근거)
    fix_section "$file" "Scope inheritance" '^## 세션 소속 근거' "SCOPE_INHERITANCE_SKELETON"
    # Out of scope (anchor: Scope inheritance — 1번 삽입 후 그것이 anchor)
    fix_section "$file" "Out of scope" '^## Scope inheritance' "OUT_OF_SCOPE_SKELETON"
}

# v1.33 — Enumerate 자동 흡수 (glob 패턴 — D3/D4/D5 검증 완료)
# v1.10h*: v1.10h, v1.10h2, v1.10h3
# v1.10j*: v1.10j
# v1.1[1-9]*: v1.11~v1.19 + suffix (v1.18b 등)
# v1.[2-9][0-9]*: v1.20~v1.99
# v[2-9].*: 향후 v2+
# v1.10b~v1.10g 면제 (Scope contract 도입 이전, OWNERSHIP.md)
enumerate_plans() {
    shopt -s nullglob
    local raw=(
        sessions/meta/v1.10h*/PLAN.md
        sessions/meta/v1.10j*/PLAN.md
        sessions/meta/v1.1[1-9]*/PLAN.md
        sessions/meta/v1.[2-9][0-9]*/PLAN.md
        sessions/meta/v[2-9].*/PLAN.md
    )
    shopt -u nullglob
    # Dedup (associative array — 안전장치, D3)
    declare -A seen
    local result=()
    local p
    for p in "${raw[@]}"; do
        [ -n "${seen[$p]:-}" ] && continue
        seen[$p]=1
        result+=("$p")
    done
    printf '%s\n' "${result[@]}"
}

# v1.33 — --fix dispatch (검증 stages 진입 전 종료)
if [ "$FIX_MODE" -eq 1 ]; then
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "=== --fix mode (dry-run) ==="
    else
        echo "=== --fix mode ==="
    fi
    targets=()
    if [ "${#TARGET_PATHS[@]}" -gt 0 ]; then
        targets=("${TARGET_PATHS[@]}")
    else
        while IFS= read -r line; do
            [ -n "$line" ] && targets+=("$line")
        done < <(enumerate_plans)
    fi
    if [ "${#targets[@]}" -eq 0 ]; then
        skip "fix — 대상 0건"
    else
        for f in "${targets[@]}"; do
            fix_file "$f" || true
        done
    fi
    echo ""
    echo "=== 결과 (--fix): PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
    [ "$FAIL" -eq 0 ] && exit 0 || exit 1
fi

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

# Stage 1 — 두 섹션 존재 (자동 enumerate, v1.33 갱신)
echo "=== Stage 1 — PLAN.md Scope contract 두 섹션 존재 (자동 enumerate v1.33+) ==="

plans=()
while IFS= read -r line; do
    [ -n "$line" ] && plans+=("$line")
done < <(enumerate_plans)

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
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

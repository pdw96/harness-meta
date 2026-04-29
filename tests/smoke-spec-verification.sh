#!/usr/bin/env bash
# v1.24 smoke — PLAN.md Spec verification (context7) § 의무 검사
# v1.26 확장 — 프로젝트 세션 PLAN도 검사 (레거시 skip 목록 제외)
# Stage 1~5: § 헤더 / sub-field 5종 / drift 값 / N/A 분기 / SKILL.md 정합
# 검증 대상:
#   - sessions/meta/v1.24+/**/PLAN.md (자동 enumerate)
#   - sessions/<project>/v*/PLAN.md (v1.26 도입 이후 신규 — 레거시 LEGACY_PROJECT_PLANS 제외)
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0; SKIP=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }
skip() { echo "  - $1 (SKIP)"; SKIP=$((SKIP+1)); }

# v1.26 — 레거시 프로젝트 PLAN 목록 (소급 면제, 동결)
LEGACY_PROJECT_PLANS=(
    "sessions/upbit/v1.0-project-claude-install/PLAN.md"
    "sessions/upbit/v1.1-skills-migration/PLAN.md"
    "sessions/upbit/v1.2-python-overlay-apply/PLAN.md"
)

is_legacy() {
    local target="$1"
    local item
    for item in "${LEGACY_PROJECT_PLANS[@]}"; do
        [ "$item" = "$target" ] && return 0
    done
    return 1
}

# v1.26 — 프로젝트 prefix 포함 label (e.g., "meta/v1.24", "upbit/v1.3")
make_label() {
    echo "$1" | sed -E 's|sessions/([^/]+)/([^/]+)/PLAN\.md|\1/\2|' \
              | sed -E 's/(v[0-9]+\.[0-9]+[a-z]*)-.*$/\1/'
}

# § 구간 추출 helper — Spec verification 헤더부터 다음 ## 헤더 직전까지
extract_section() {
    local plan="$1"
    awk '
        /^## Spec verification \(context7\)$/ { in_sec=1; next }
        in_sec && /^## / { exit }
        in_sec { print }
    ' "$plan"
}

# table cell 값 추출 helper — | **<key>** | <value> | 형식에서 value 추출
extract_cell() {
    local section="$1"
    local key="$2"
    echo "$section" \
        | grep -E "^\| \*\*${key}\*\* \|" \
        | head -1 \
        | sed -E 's/^\| \*\*[^*]+\*\* \| (.*) \|.*$/\1/' \
        | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//'
}

# Stage 1 — § 헤더 존재
echo "=== Stage 1 — § 헤더 존재 (^## Spec verification \\(context7\\)\$) ==="

shopt -s nullglob
meta_plans=(sessions/meta/v1.2[4-9]*/PLAN.md sessions/meta/v1.[3-9][0-9]*/PLAN.md sessions/meta/v[2-9].*/PLAN.md)
project_plans_raw=(sessions/*/v*/PLAN.md)
shopt -u nullglob

# project_plans_raw에서 meta 제외 + 레거시 제외
project_plans=()
for plan in "${project_plans_raw[@]}"; do
    # meta는 별도 enumerate
    case "$plan" in
        sessions/meta/*) continue ;;
    esac
    if is_legacy "$plan"; then
        continue
    fi
    project_plans+=("$plan")
done

# 합집합
plans=("${meta_plans[@]}" "${project_plans[@]}")

# 레거시 SKIP 보고 (가시성)
for legacy in "${LEGACY_PROJECT_PLANS[@]}"; do
    if [ -f "$legacy" ]; then
        skip "$(make_label "$legacy") — 레거시 면제 (v1.26 도입 이전)"
    fi
done

if [ "${#plans[@]}" -eq 0 ]; then
    fail "Stage 1 — PLAN.md glob 매치 0건 (예상치 못함)"
else
    for plan in "${plans[@]}"; do
        label=$(make_label "$plan")
        if grep -qE '^## Spec verification \(context7\)$' "$plan"; then
            ok "$label — § 헤더 존재"
        else
            fail "$label — § 헤더 누락"
        fi
    done
fi

# Stage 2 — § 구간 추출 후 sub-field 5종 존재
echo ""
echo "=== Stage 2 — sub-field 5종 (library/topic/findings/drift/re-verify) ==="

for plan in "${plans[@]}"; do
    label=$(make_label "$plan")
    section=$(extract_section "$plan")
    if [ -z "$section" ]; then
        fail "$label — § 구간 추출 실패 (헤더 부재)"
        continue
    fi
    missing=()
    for sub in library topic findings drift re-verify; do
        if ! echo "$section" | grep -qE "^\| \*\*${sub}\*\* \|"; then
            missing+=("$sub")
        fi
    done
    if [ "${#missing[@]}" -eq 0 ]; then
        ok "$label — sub-field 5종 모두 존재"
    else
        fail "$label — sub-field 누락: ${missing[*]}"
    fi
done

# Stage 3 — drift 값 정합 (yes/no/N/A 중 정확 1개)
echo ""
echo "=== Stage 3 — drift 값 (yes/no/N/A) ==="

for plan in "${plans[@]}"; do
    label=$(make_label "$plan")
    section=$(extract_section "$plan")
    drift_cell=$(extract_cell "$section" "drift")
    # drift cell 첫 토큰만 추출 (공백 또는 ' — ' 앞)
    drift_value=$(echo "$drift_cell" | awk '{print $1}')
    case "$drift_value" in
        yes|no|N/A)
            ok "$label — drift=$drift_value"
            ;;
        *)
            fail "$label — drift 값 부적절 ('$drift_value')"
            ;;
    esac
done

# Stage 4 — N/A 분기 정합 (drift=N/A → 다른 4 sub-field 정확히 N/A)
echo ""
echo "=== Stage 4 — N/A 분기 정합 (부분 N/A 차단) ==="

for plan in "${plans[@]}"; do
    label=$(make_label "$plan")
    section=$(extract_section "$plan")
    drift_cell=$(extract_cell "$section" "drift")
    drift_value=$(echo "$drift_cell" | awk '{print $1}')
    if [ "$drift_value" = "N/A" ]; then
        bad=()
        for sub in library topic findings re-verify; do
            val=$(extract_cell "$section" "$sub")
            if [ "$val" != "N/A" ]; then
                bad+=("${sub}='${val}'")
            fi
        done
        if [ "${#bad[@]}" -eq 0 ]; then
            ok "$label — drift=N/A + 다른 4 sub-field 정확히 N/A"
        else
            fail "$label — 부분 N/A 위반: ${bad[*]}"
        fi
    else
        ok "$label — drift=$drift_value (N/A 분기 무관)"
    fi
done

# Stage 5 — SKILL.md 존재 + frontmatter 정합
echo ""
echo "=== Stage 5 — bootstrap/skills/harness-plan-verify/SKILL.md 정합 ==="

SKILL="bootstrap/skills/harness-plan-verify/SKILL.md"
if [ ! -f "$SKILL" ]; then
    fail "SKILL.md 부재: $SKILL"
else
    ok "SKILL.md 존재"
    if grep -qE '^name: harness-plan-verify$' "$SKILL"; then
        ok "frontmatter name: harness-plan-verify"
    else
        fail "frontmatter name 부적절"
    fi
    if grep -qE '^model: opus$' "$SKILL"; then
        ok "frontmatter model: opus"
    else
        fail "frontmatter model 부적절"
    fi
    if grep -qE '^effort: xhigh$' "$SKILL"; then
        ok "frontmatter effort: xhigh"
    else
        fail "frontmatter effort 부적절"
    fi
    if grep -q 'mcp__plugin_context7_context7__query-docs' "$SKILL"; then
        ok "frontmatter mcp__...__query-docs 선언"
    else
        fail "MCP query-docs 선언 누락"
    fi
    if grep -q 'mcp__plugin_context7_context7__resolve-library-id' "$SKILL"; then
        ok "frontmatter mcp__...__resolve-library-id 선언"
    else
        fail "MCP resolve-library-id 선언 누락"
    fi
    if grep -qE '^thinking:' "$SKILL"; then
        fail "thinking: 필드 잔존 (V10 위반 — silent ignore)"
    else
        ok "thinking: 필드 부재 (V10 정합)"
    fi
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

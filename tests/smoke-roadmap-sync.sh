#!/usr/bin/env bash
# v1.36 smoke (rename from smoke-archive-sync.sh, v1.31c) — ROADMAP drift 자동 감지
# 도입 세션: sessions/meta/v1.36-roadmap-unification-and-flow/
# 선행: sessions/meta/v1.31c-archive-sync-automation/ (smoke-archive-sync.sh)
#
# v1.36 변경:
#   - Target ROADMAP: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md → sessions/meta/ROADMAP.md
#   - Stage 5 신규: 프로젝트 ROADMAP "최근 완료" entry per 프로젝트 세션 (projects/<name>/ROADMAP.md)
#   - --fix sanitize: ROADMAP §8 row 삽입 전 메타 문자 5종 (@, {{, }}, <!--, <script) fenced wrap
#   - LEGACY_SESSIONS skip 정책 답습 (pre-v1.31 메타 forward-only)
#
# Stage 1 — meta ROADMAP §8 entry 존재 (per post-v1.31 meta session). FAIL.
# Stage 2 — §2 strikethrough → §8/§9 archive entry 일치 (WARN-only)
# Stage 3 — §"최근 완료" stale 감지 (WARN-only)
# Stage 4 — §"다음 후보" 카운트 동기화. FAIL.
# Stage 5 (v1.36 신규) — projects/*/ROADMAP.md "최근 완료" entry per 프로젝트 세션. FAIL (프로젝트 ROADMAP 부재 시 SKIP).
#
# Legacy 정책: pre-v1.31 메타 53건은 forward-only skip (REPORT.md "세션 종료" 일자 기준).
#
# Usage:
#   bash tests/smoke-roadmap-sync.sh                  # 검증만 (default)
#   bash tests/smoke-roadmap-sync.sh --fix            # §"최근 완료" 누락 entry sanitize 후 자동 삽입
#   bash tests/smoke-roadmap-sync.sh --fix --dry-run  # 변경 없이 plan만 출력
#   bash tests/smoke-roadmap-sync.sh --help

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

# v1.36: meta ROADMAP path 변경 (sessions/meta/ROADMAP.md)
ROADMAP="sessions/meta/ROADMAP.md"
ROADMAP_INTRO_DATE="2026-04-29"  # v1.31 도입 — 이 날짜 이전 세션은 forward-only skip

# v1.36: --fix sanitize — interview.md Q13 답습. 5 메타 문자 + control character
# Sanitize는 fix mode에서만 적용 — 사용자가 PLAN/REPORT에 작성한 텍스트가 ROADMAP에 직접 흐르지 않도록
sanitize_row() {
    local text="$1"
    # control character strip (null byte, ANSI escape) — printf %q는 ASCII control 보존이므로 sed로 제거
    text=$(printf '%s' "$text" | sed 's/[\x00-\x1F\x7F]//g')
    # 메타 문자 5종 검출 → fenced code block wrap
    if printf '%s' "$text" | grep -qE '@|\{\{|\}\}|<!--|<script'; then
        text='`'"$(printf '%s' "$text" | head -c 200)"'`'  # inline code fence (200 char truncate)
    fi
    printf '%s' "$text"
}

# Pre-roadmap chronological sessions — forward-only list (v1.31 도입 이전 완료)
# 일자 기반 자동 판정 불가 (v1.30/v1.29 등이 같은 날짜에 완료) → 명시 hardcode
LEGACY_SESSIONS=(
    v1.0 v1.1 v1.2 v1.3 v1.4 v1.5 v1.5b v1.6 v1.7
    v1.8 v1.8b v1.9 v1.9b v1.9c
    v1.10 v1.10b v1.10c v1.10d v1.10e v1.10e2 v1.10e3
    v1.10f v1.10g v1.10h v1.10h2 v1.10h3 v1.10j
    v1.11 v1.11b v1.12 v1.13 v1.14 v1.15 v1.16 v1.17
    v1.18 v1.18b v1.18c v1.18g
    v1.19 v1.20 v1.21 v1.22 v1.23 v1.23b
    v1.24 v1.25 v1.26 v1.27 v1.28 v1.29
    v1.30 v1.30b
)

PASS=0; FAIL=0; SKIP=0; WARN=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }
skip() { echo "  - $1 (SKIP)"; SKIP=$((SKIP+1)); }
warn() { echo "  ⚠ $1"; WARN=$((WARN+1)); }

# CLI parsing
FIX_MODE=0
DRY_RUN=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h)
            cat <<'USAGE'
Usage: bash tests/smoke-archive-sync.sh [--fix [--dry-run]]

Default: Stage 1~4 정적 검증 (회귀 0).

Stage 1 — §8 확정 세션 entry 검증 (post-v1.31 meta 세션 대상). FAIL.
Stage 2 — §2 strikethrough → §9 archive entry 일치. WARN-only.
Stage 3 — §5 stale 감지 (strikethrough → §8/§9 부재). WARN-only.
Stage 4 — §2 헤더 카운트 동기화. FAIL.

--fix:        Stage 1 누락 entry에 §8 skeleton 자동 삽입 (§9 헤더 직전).
              형식: "- **vX.Y** (YYYY-MM-DD) — TODO: 1 line summary."
              사용자가 TODO 채움 후 재호출 시 PASS.
--dry-run:    --fix와 함께 — 변경 없이 plan만 출력.

Legacy 정책: pre-v1.31 메타 53건은 REPORT.md "세션 종료: <YYYY-MM-DD>" 기준 자동 skip.
LEGACY_SESSIONS hardcode 없음 — 일자 기반 forward-only.
USAGE
            exit 0
            ;;
        --*)
            echo "Unknown option: $1 (try --help)" >&2
            exit 2
            ;;
        *)
            echo "Unknown argument: $1 (try --help)" >&2
            exit 2
            ;;
    esac
    shift
done

# ─── Helpers ─────────────────────────────────────────────────────────────────

# 디렉토리명 → 버전 추출 (v1.31-evidence-driven-roadmap → v1.31)
extract_version() {
    basename "$1" | sed -E 's/^(v[0-9]+\.[0-9]+[a-z0-9]*)-.*/\1/'
}

# REPORT.md → "세션 종료: YYYY-MM-DD" 추출 (grep no-match 시 빈 문자열, errexit 회피)
extract_end_date() {
    local report="$1"
    local raw=""
    [ -f "$report" ] || { echo ""; return; }
    raw=$(grep -m1 '^세션 종료:' "$report" 2>/dev/null || true)
    [ -z "$raw" ] && { echo ""; return; }
    echo "$raw" | sed -E 's/^세션 종료:[[:space:]]*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/' | tr -d ' '
}

# pre-roadmap 여부 (true: legacy) — LEGACY_SESSIONS list 우선, 일자 fallback
is_legacy() {
    local version="$1" end_date="$2"
    # LEGACY_SESSIONS list 매칭 우선 (chronological 기준)
    local legacy
    for legacy in "${LEGACY_SESSIONS[@]}"; do
        [ "$version" = "$legacy" ] && return 0
    done
    # 일자 fallback (LEGACY list 누락 방지)
    [ -z "$end_date" ] && return 0
    [ "$end_date" \< "$ROADMAP_INTRO_DATE" ] && return 0
    return 1
}

# §"최근 완료" 또는 §"확정 세션" entry 존재 검증 (v1.36 ROADMAP 형식)
# - v1.36 ROADMAP §8 "최근 완료" 표: "| v1.31b-... |" (plain row) 또는 "| **vX.Y...** |"
# - v1.36 ROADMAP §9 "확정 세션" bullet: "- **vX.Y** (YYYY-MM-DD) — ..."
# - 매치 패턴: version 직후 hyphen + alphanumeric (`v1.31b-...`) 또는 version 단독 (`**v1.31**`)
has_section8_entry() {
    local version="$1"
    # Pattern 1: "| <version>-..." (plain table row)
    # Pattern 2: "| **<version>-..." or "| **<version>** " (bold table row)
    # Pattern 3: "- **<version>** " (bullet list)
    grep -qE "(\| ${version}-|\| \*\*${version}[-*]|^- \*\*${version}\*\* )" "$ROADMAP"
}

# v1.36 신규 — 프로젝트 ROADMAP entry 검증 (per project)
has_section8_entry_proj() {
    local roadmap="$1" version="$2"
    grep -qE "(\| \`${version}|\| ${version}-|\| \*\*${version}[-*]|^- \*\*${version}\*\* )" "$roadmap"
}

# ─── Stage 1 — §8 entry 검증 ──────────────────────────────────────────────────

echo "=== Stage 1 — §8 확정 세션 entry 검증 (post-v1.31 메타 세션) ==="

shopt -s nullglob
META_SESSIONS=(sessions/meta/v*/)
shopt -u nullglob

MISSING_S8=()  # "version|date|name" entries

for session_dir in "${META_SESSIONS[@]}"; do
    name=$(basename "$session_dir")
    report="$session_dir/REPORT.md"
    if [ ! -f "$report" ]; then
        skip "$name — REPORT.md 부재 (세션 미완료)"
        continue
    fi

    end_date=$(extract_end_date "$report")
    version=$(extract_version "$session_dir")
    if is_legacy "$version" "$end_date"; then
        skip "$name — pre-v1.31 (${end_date:-no-date})"
        continue
    fi
    if has_section8_entry "$version"; then
        ok "$name — §8 entry 존재 (${version}, ${end_date})"
    else
        fail "$name — §8 entry 누락 (${version}, ${end_date})"
        MISSING_S8+=("${version}|${end_date}|${name}")
    fi
done

# ─── --fix mode (Stage 1 only) ───────────────────────────────────────────────

if [ "$FIX_MODE" -eq 1 ] && [ "${#MISSING_S8[@]}" -gt 0 ]; then
    echo
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "=== --fix mode (dry-run) — §9 확정 세션 skeleton 삽입 plan ==="
    else
        echo "=== --fix mode — §9 확정 세션 skeleton 삽입 (sanitize 적용) ==="
    fi

    # v1.36: §9 헤더 (확정 세션) 또는 EOF 직전에 삽입
    s9_line=$(grep -nE '^## 9\. ' "$ROADMAP" | head -1 | cut -d: -f1 || true)
    if [ -z "$s9_line" ]; then
        # fallback — 마지막 ## section 직후
        last_heading=$(grep -nE '^## ' "$ROADMAP" | tail -1 | cut -d: -f1)
        if [ -n "$last_heading" ]; then
            s9_line=$(($(wc -l < "$ROADMAP") + 1))
        fi
    fi
    if [ -z "$s9_line" ]; then
        fail "--fix: §9/§8 헤더 부재 — 삽입 위치 결정 불가"
    else
        for entry in "${MISSING_S8[@]}"; do
            version=$(echo "$entry" | cut -d'|' -f1)
            date=$(echo "$entry" | cut -d'|' -f2)
            name=$(echo "$entry" | cut -d'|' -f3)
            # v1.36 sanitize_row — 메타 문자 5종 + control character strip
            sanitized_name=$(sanitize_row "$name")
            skeleton="- **${version}** (${date}) — TODO: 1 line summary (session: ${sanitized_name})."
            if [ "$DRY_RUN" -eq 1 ]; then
                echo "  [dry-run] would insert §9 entry (sanitized): $skeleton"
            else
                tmp=$(mktemp)
                blank_line=$((s9_line - 1))
                {
                    head -n $((blank_line - 1)) "$ROADMAP"
                    printf '%s\n' "$skeleton"
                    tail -n +"$blank_line" "$ROADMAP"
                } > "$tmp"
                mv "$tmp" "$ROADMAP"
                s9_line=$(grep -nE '^## 9\. ' "$ROADMAP" | head -1 | cut -d: -f1)
                ok "fix: §9에 skeleton 추가 (sanitize 적용) — $skeleton"
                MISSING_S8_FIXED=$((${MISSING_S8_FIXED:-0} + 1))
            fi
        done
    fi
fi

# ─── Stage 2 — §2 strikethrough → §9 archive 일치 (WARN-only) ─────────────────

echo
echo "=== Stage 2 — §2 strikethrough → §9 archive entry 일치 (WARN-only) ==="

# §2 row에서 strikethrough된 row 추출 + alias chain의 actual session 추출
# 패턴: ~~`v1.18f-...`~~ → **`v1.35-...` 완료**
section2_block=$(awk '/^## 2\. /,/^## 3\. /' "$ROADMAP")
archived_rows=$(echo "$section2_block" | grep -cE '~~.*~~ →' || true)

if [ "$archived_rows" -eq 0 ]; then
    skip "§2 strikethrough row 0건 (검증 대상 없음)"
else
    # 각 row의 actual 완료 session 추출 (→ ** ` 패턴)
    actual_sessions=$(echo "$section2_block" | grep -oE '→ \*\*`v[0-9]+\.[0-9]+[a-z0-9]*-[^`]+`' | sed -E 's/→ \*\*`(v[^`]+)`/\1/')
    if [ -z "$actual_sessions" ]; then
        warn "§2 strikethrough row 있으나 actual session 추출 실패 — 패턴 확인 필요"
    else
        section9_block=$(awk '/^## 9\. /,0' "$ROADMAP")
        while IFS= read -r actual; do
            [ -z "$actual" ] && continue
            # -F: fixed-string (백틱 literal). pattern: `version-name`
            if echo "$section9_block" | grep -qF "\`${actual}\`"; then
                ok "§2 archive ${actual} → §9 entry 존재"
            else
                warn "§2 archive ${actual} → §9 entry 부재 (manual fix 필요)"
            fi
        done <<< "$actual_sessions"
    fi
fi

# ─── Stage 3 — §5 stale 감지 (WARN-only) ─────────────────────────────────────

echo
echo "=== Stage 3 — §5 stale 감지 (strikethrough → §8/§9 부재) (WARN-only) ==="

# v1.36: errexit 회피 — awk no-match 시 빈 문자열 처리
section5_block=$(awk '/^## 5\. /,/^## 6\. /' "$ROADMAP" 2>/dev/null || echo "")
stale_refs=$(echo "$section5_block" | grep -oE '~~`v[0-9]+\.[0-9]+[a-z0-9]*-[^`]+`~~' 2>/dev/null | sed -E 's/~~`(.+)`~~/\1/' || true)

if [ -z "$stale_refs" ]; then
    skip "§5 strikethrough row 0건 (검증 대상 없음)"
else
    while IFS= read -r ref; do
        [ -z "$ref" ] && continue
        version_only=$(echo "$ref" | sed -E 's/^(v[0-9]+\.[0-9]+[a-z0-9]*)-.*/\1/')
        # §8 또는 §9 entry 존재 확인
        if grep -qE "(\\*\\*${version_only}\\*\\*|\\\`${ref}\\\`)" "$ROADMAP"; then
            ok "§5 stale ${ref} → §8/§9 entry 존재 (정합)"
        else
            warn "§5 stale ${ref} → §8/§9 entry 부재 (강제 ranking → archive 누락)"
        fi
    done <<< "$stale_refs"
fi

# ─── Stage 4 — §"다음 후보" 카운트 동기화 (v1.36 ROADMAP 형식) ────────────────

echo
echo "=== Stage 4 — §2 (다음 후보) 정합 ==="

# v1.36 ROADMAP §2: "## 2. 다음 후보 (활성)" 헤더 — 카운트 헤더 자체에 명시 안 함 (active rows count로 판정)
# active row pattern: "| <num> | **`v..." 또는 "| <num> | **v..."
# errexit 회피 — grep no-match 시 빈 문자열
header_pattern=$(grep -cE "^## 2\. 다음 후보" "$ROADMAP" 2>/dev/null || echo "0")
active_count=$(echo "${section2_block:-}" | grep -cE '^\| [0-9]+ \| \*\*' 2>/dev/null || echo "0")

if [ "$header_pattern" = "0" ]; then
    fail "§2 헤더 부재 (^## 2\\. 다음 후보 매치 실패) — ROADMAP 형식 drift"
else
    ok "§2 다음 후보 헤더 존재 (active rows: ${active_count}건)"
fi

# ─── Stage 5 (v1.36 신규) — projects/*/ROADMAP.md 검증 ───────────────────────

echo
echo "=== Stage 5 — projects/*/ROADMAP.md 정합 (v1.36 신규) ==="

shopt -s nullglob
PROJECT_ROADMAPS=(projects/*/ROADMAP.md)
shopt -u nullglob

if [ "${#PROJECT_ROADMAPS[@]}" -eq 0 ]; then
    skip "projects/*/ROADMAP.md 부재 (프로젝트별 ROADMAP 0건 — v1.36 신규 활성 0)"
else
    for proj_roadmap in "${PROJECT_ROADMAPS[@]}"; do
        proj_name=$(basename "$(dirname "$proj_roadmap")")
        # 프로젝트 ROADMAP "최근 완료" §6 또는 §"최근 완료" 존재 여부
        if grep -qE '^## [0-9]+\. (최근 완료|Recent Completed)' "$proj_roadmap"; then
            ok "$proj_name — ROADMAP §최근 완료 존재"
        else
            fail "$proj_name — ROADMAP §최근 완료 § 부재"
        fi
        # 프로젝트 sessions 디렉토리에 vX.Y-* 세션 있으면 ROADMAP에 매핑되는 entry 검증
        proj_sessions_dir="sessions/$proj_name"
        if [ -d "$proj_sessions_dir" ]; then
            shopt -s nullglob
            for sd in "$proj_sessions_dir"/v*/; do
                sname=$(basename "$sd")
                version=$(extract_version "$sd")
                if has_section8_entry_proj "$proj_roadmap" "$version"; then
                    ok "$proj_name — ROADMAP entry $version 존재"
                else
                    skip "$proj_name — ROADMAP entry $version 부재 (manual review)"
                fi
            done
            shopt -u nullglob
        fi
    done
fi

# ─── 결과 ────────────────────────────────────────────────────────────────────

echo
echo "=== 결과: PASS=${PASS} FAIL=${FAIL} SKIP=${SKIP} WARN=${WARN} ==="

[ "$FAIL" = "0" ] && exit 0 || exit 1

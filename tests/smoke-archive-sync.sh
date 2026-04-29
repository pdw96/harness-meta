#!/usr/bin/env bash
# v1.31c smoke — EVIDENCE_DRIVEN_ROADMAP.md drift 자동 감지
# 도입 세션: sessions/meta/v1.31c-archive-sync-automation/
#
# Stage 1 — §8 확정 세션 entry 검증 (post-v1.31 메타 세션)
# Stage 2 — §2 strikethrough → §9 archive entry 일치 (WARN-only)
# Stage 3 — §5 stale 감지 (strikethrough → §8/§9 부재) (WARN-only)
# Stage 4 — §2 헤더 카운트 동기화 (`진행 가능 N건` ↔ active row 수)
#
# Legacy 정책: pre-v1.31 메타 53건은 forward-only skip (REPORT.md "세션 종료" 일자 기준).
#
# Usage:
#   bash tests/smoke-archive-sync.sh                  # 검증만 (default)
#   bash tests/smoke-archive-sync.sh --fix            # §8 누락 entry skeleton 자동 삽입
#   bash tests/smoke-archive-sync.sh --fix --dry-run  # 변경 없이 plan만 출력
#   bash tests/smoke-archive-sync.sh --help

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

ROADMAP="bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md"
ROADMAP_INTRO_DATE="2026-04-29"  # v1.31 도입 — 이 날짜 이전 세션은 forward-only skip

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

# §8 entry 존재 검증
has_section8_entry() {
    local version="$1"
    grep -qE "^- \*\*${version}\*\* " "$ROADMAP"
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
        echo "=== --fix mode (dry-run) — §8 skeleton 삽입 plan ==="
    else
        echo "=== --fix mode — §8 skeleton 삽입 ==="
    fi

    # §9 헤더 직전 (line N-1) 위치 탐색
    s9_line=$(grep -nE '^## 9\. Archive' "$ROADMAP" | head -1 | cut -d: -f1 || true)
    if [ -z "$s9_line" ]; then
        fail "--fix: §9 헤더 부재 — 삽입 위치 결정 불가"
    else
        # §9 헤더 직전 빈 line (anchor) 찾기 — §8 마지막 entry 다음 \n
        # 안전하게 §9 헤더 line 직전에 삽입 (line N-1 위치에)
        for entry in "${MISSING_S8[@]}"; do
            version=$(echo "$entry" | cut -d'|' -f1)
            date=$(echo "$entry" | cut -d'|' -f2)
            name=$(echo "$entry" | cut -d'|' -f3)
            skeleton="- **${version}** (${date}) — TODO: 1 line summary (session: ${name})."
            if [ "$DRY_RUN" -eq 1 ]; then
                echo "  [dry-run] would append to §8: $skeleton"
            else
                # §9 헤더 직전 빈 line (line N-1) 위치 — 빈 line 직전에 skeleton 삽입
                # head -(N-2) + skeleton + "" (blank) + ## 9 onwards
                # 더 안전한 방식: §9 헤더 line 직전에 단순 추가
                tmp=$(mktemp)
                # s9_line은 "## 9. Archive (완료 세션)" line
                # 그 직전 line이 보통 빈 line (## 8 끝). skeleton + 빈 line 추가
                # → head -(s9_line - 1) + skeleton 추가 + tail (blank line + ## 9 ...)
                # 가장 안전: blank line 직전에 skeleton 삽입 (line s9_line - 1 위치)
                blank_line=$((s9_line - 1))
                {
                    head -n $((blank_line - 1)) "$ROADMAP"
                    printf '%s\n' "$skeleton"
                    tail -n +"$blank_line" "$ROADMAP"
                } > "$tmp"
                mv "$tmp" "$ROADMAP"
                # 한 번 삽입하면 §9 line 번호가 +1 → 다음 entry 위해 재계산
                s9_line=$(grep -nE '^## 9\. Archive' "$ROADMAP" | head -1 | cut -d: -f1)
                ok "fix: §8에 skeleton 추가 — $skeleton"
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

section5_block=$(awk '/^## 5\. /,/^## 6\. /' "$ROADMAP")
stale_refs=$(echo "$section5_block" | grep -oE '~~`v[0-9]+\.[0-9]+[a-z0-9]*-[^`]+`~~' | sed -E 's/~~`(.+)`~~/\1/')

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

# ─── Stage 4 — §2 헤더 카운트 동기화 ─────────────────────────────────────────

echo
echo "=== Stage 4 — §2 헤더 카운트 ↔ active row 수 동기화 ==="

header_count=$(grep -m1 -E "^## 2\. 진행 가능 [0-9]+건" "$ROADMAP" | grep -oE "[0-9]+건" | head -1 | grep -oE "[0-9]+" || echo "")
active_count=$(echo "$section2_block" | grep -cE '^\| [0-9]+ \| \*\*`v' || true)

if [ -z "$header_count" ]; then
    fail "§2 헤더 형식 mismatch (`^## 2\\. 진행 가능 [0-9]+건` 매치 실패)"
elif [ "$header_count" = "$active_count" ]; then
    ok "§2 header (${header_count}건) ↔ active rows (${active_count}건) 동기화"
else
    fail "§2 header (${header_count}건) ↔ active rows (${active_count}건) drift"
fi

# ─── 결과 ────────────────────────────────────────────────────────────────────

echo
echo "=== 결과: PASS=${PASS} FAIL=${FAIL} SKIP=${SKIP} WARN=${WARN} ==="

[ "$FAIL" = "0" ] && exit 0 || exit 1

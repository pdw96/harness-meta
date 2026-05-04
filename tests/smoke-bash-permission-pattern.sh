#!/usr/bin/env bash
# v1.10d β scope smoke — frontmatter 5축 통합 정정 검증
# V1 (A3 pattern format) + V4 (R5' doc) + V5 (A4 redundancy) + V7 (A1 field name) + V8 (A2 separator) + V9 (YAML list)
# v1.60 — --fix mode: V1/V5/V7 자동 정정 (V8/V9/V4 Out of scope)
#
# Usage:
#   bash tests/smoke-bash-permission-pattern.sh                 # default — Stage 1~6 검증
#   bash tests/smoke-bash-permission-pattern.sh --fix           # V1/V5/V7 위반 자동 정정 후 검증
#   bash tests/smoke-bash-permission-pattern.sh --fix --dry-run # 변경 없이 plan만 출력
#   bash tests/smoke-bash-permission-pattern.sh --help          # usage
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

# v1.60 — argv 파싱
FIX_MODE=0
DRY_RUN=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h)
            cat <<USAGE
Usage: $0 [--fix [--dry-run]]

Default mode (no args): Stage 1~6 검증 (회귀 0).

--fix:     V1 (Bash(cmd*) → Bash(cmd *)) + V5 (YAML list 자동허용 set 줄 삭제) +
           V7 (slash command ^tools: → ^allowed-tools:) 자동 정정.
           V8 (콤마 separator) / V9 (YAML list 항목 수) / V4 (doc keyword)는 구조적/문서성
           변경 어려워 Out of scope.
--dry-run: --fix와 함께 — 변경 없이 plan만 출력. Stage 검증 skip (drift 의도).
USAGE
            exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *)   echo "Unexpected arg: $1 (try --help)" >&2; exit 2 ;;
    esac
    shift
done

FILES=(
  "claude/commands/harness-meta.md"
  "bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md"
  # v1.36+ 글로벌 user-skill 2단계 카테고리 (audit/)
  "bootstrap/skills/audit/harness-plan-verify/SKILL.md"
  "bootstrap/skills/audit/harness-roadmap-update/SKILL.md"
)
SLASH_FILE="claude/commands/harness-meta.md"

# v1.60 — --fix block: Stage 검증 진입 전 자동 정정
if [ "$FIX_MODE" -eq 1 ]; then
    echo "=== --fix mode (V1/V5/V7) ==="
    fix_count=0

    # V1 — Bash(cmd*) → Bash(cmd *) (공백 형식)
    V1_PAT='Bash\([a-z][a-z\-]*\*\)'
    for f in "${FILES[@]}"; do
        if grep -qE "$V1_PAT" "$f" 2>/dev/null; then
            if [ "$DRY_RUN" -eq 1 ]; then
                grep -nE "$V1_PAT" "$f" | sed "s|^|  [would fix V1] $f: |"
            else
                sed -E -i.bak 's/Bash\(([a-z][a-z\-]*)\*\)/Bash(\1 *)/g' "$f" && rm -f "$f.bak"
                echo "  [fix V1] $f"
            fi
            fix_count=$((fix_count + 1))
        fi
    done

    # V5 — YAML list line 자동 허용 set 삭제 (markdown body 보호)
    V5_PAT='^[[:space:]]*-[[:space:]]*Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)[[:space:]]*$'
    for f in "${FILES[@]}"; do
        if grep -qE "$V5_PAT" "$f" 2>/dev/null; then
            if [ "$DRY_RUN" -eq 1 ]; then
                grep -nE "$V5_PAT" "$f" | sed "s|^|  [would fix V5] $f: |"
            else
                sed -E -i.bak "/$V5_PAT/d" "$f" && rm -f "$f.bak"
                echo "  [fix V5] $f"
            fi
            fix_count=$((fix_count + 1))
        fi
    done

    # V7 — slash command ^tools: → ^allowed-tools: (harness-meta.md only)
    if grep -qE '^tools:' "$SLASH_FILE" 2>/dev/null; then
        if [ "$DRY_RUN" -eq 1 ]; then
            grep -nE '^tools:' "$SLASH_FILE" | sed "s|^|  [would fix V7] $SLASH_FILE: |"
        else
            sed -E -i.bak 's/^tools:/allowed-tools:/' "$SLASH_FILE" && rm -f "$SLASH_FILE.bak"
            echo "  [fix V7] $SLASH_FILE"
        fi
        fix_count=$((fix_count + 1))
    fi

    if [ "$fix_count" -eq 0 ]; then
        echo "  (no violations found — 0 fixes)"
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        echo ""
        echo "=== dry-run 종료 (Stage 검증 skip) ==="
        exit 0
    fi
    echo ""
fi

# Stage 1 — V1 (A3): 콜론 없는 Bash(\w+\*) 잔존 0 (공백 형식 채택)
echo "=== Stage 1 — V1 (A3) Pattern format (공백 형식) ==="
no_colon=0
for f in "${FILES[@]}"; do
    n=$(grep -cE 'Bash\([a-z][a-z\-]*\*\)' "$f" || true)
    echo "  $f: $n"
    no_colon=$((no_colon + n))
done
[ "$no_colon" -eq 0 ] || { echo "FAIL — V1 콜론 없음 패턴 $no_colon건 잔존"; exit 1; }
echo "PASS — V1 0건"

# Stage 2 — V5 (A4) Redundancy: 자동 허용 set declare 잔존 0
echo ""
echo "=== Stage 2 — V5 (A4) Redundancy (auto-allow set declare) ==="
auto_set='Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)'
redundant=0
for f in "${FILES[@]}"; do
    n=$(grep -cE "$auto_set" "$f" || true)
    echo "  $f: $n"
    redundant=$((redundant + n))
done
[ "$redundant" -eq 0 ] || { echo "FAIL — V5 자동 허용 declare $redundant건"; exit 1; }
echo "PASS — V5 0건"

# Stage 3 — V7 (A1) Field name: harness-meta.md는 allowed-tools:
echo ""
echo "=== Stage 3 — V7 (A1) Field name (slash command) ==="
SLASH="claude/commands/harness-meta.md"
grep -qE '^allowed-tools:' "$SLASH" || { echo "FAIL — $SLASH 'allowed-tools:' 부재"; exit 1; }
if grep -qE '^tools:' "$SLASH"; then
    echo "FAIL — $SLASH 'tools:' 잔존 (should be allowed-tools)"; exit 1
fi
echo "PASS — V7 (A1) allowed-tools: 정합"

# Stage 4 — V8 (A2) Separator: single-line 콤마 separator 잔존 0
echo ""
echo "=== Stage 4 — V8 (A2) Separator (콤마 → YAML list) ==="
v8_fail=0
for f in "${FILES[@]}"; do
    if grep -qE '^(allowed-tools|tools):.+,' "$f"; then
        echo "  FAIL — $f single-line 콤마 잔존"
        v8_fail=$((v8_fail + 1))
    else
        echo "  $f: OK"
    fi
done
[ "$v8_fail" -eq 0 ] || { echo "FAIL — V8 single-line 콤마 separator $v8_fail 파일 잔존"; exit 1; }
echo "PASS — V8 single-line 콤마 0건"

# Stage 5 — V9 (A2) YAML list 형식
echo ""
echo "=== Stage 5 — V9 (A2) YAML list 형식 ==="
for f in "${FILES[@]}"; do
    if grep -qE '^allowed-tools:[[:space:]]*$' "$f"; then
        n=$(awk '/^allowed-tools:[[:space:]]*$/{flag=1; next} flag && /^  - /{count++; next} flag && !/^  - /{flag=0} END{print count+0}' "$f")
        echo "  $f: $n YAML list 항목"
        [ "$n" -ge 3 ] || { echo "FAIL — $f YAML list 항목 부족 ($n < 3)"; exit 1; }
    else
        echo "FAIL — $f YAML list 형식 부재"; exit 1
    fi
done
echo "PASS — V9 YAML list 형식 정합"

# Stage 6 — V4 (R5') PERMISSION_PATTERN.md 검증
echo ""
echo "=== Stage 6 — V4 (R5') PERMISSION_PATTERN.md ==="
DOC="bootstrap/docs/PERMISSION_PATTERN.md"
[ -f "$DOC" ] || { echo "FAIL — $DOC 부재"; exit 1; }
KEYWORDS=("allowed-tools" "auto-allow|자동 허용" "fragile" "YAML list" "PreToolUse" "Conservative" "v1.10d" "subagent" "5축")
for kw in "${KEYWORDS[@]}"; do
    grep -qE "$kw" "$DOC" || { echo "FAIL — $DOC missing keyword: $kw"; exit 1; }
done
echo "PASS — V4 doc 존재 + 9 keyword"

echo ""
echo "============================="
echo "smoke-bash-permission-pattern PASS — 6/6"
echo "============================="

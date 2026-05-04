#!/usr/bin/env bash
# v1.10f scope smoke — templates 7 파일 5축 정합 검증 (broad Bash + agent 콤마)
# Stage 1 (V8 A2 separator) + Stage 2 (V9 YAML list) + Stage 3 (R2 Bash 제거)
# + Stage 4 (R3/R4 broad Bash 유지) + Stage 5 (V5 A4 redundancy) + Stage 6 (Field name + R6)
# v1.62 — --fix mode: V5 (7 파일 auto-allow set 삭제) + R2/R6 (4 NO_BASH_FILES Bash declare 삭제).
#         V8/V9/Stage 4/Stage 6 field name은 Out of scope.
#
# Usage:
#   bash tests/smoke-broad-bash-fine-grain.sh                 # default — Stage 1~6 검증
#   bash tests/smoke-broad-bash-fine-grain.sh --fix           # V5 + R2/R6 위반 자동 정정
#   bash tests/smoke-broad-bash-fine-grain.sh --fix --dry-run # 변경 없이 plan 출력
#   bash tests/smoke-broad-bash-fine-grain.sh --help          # usage
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

# v1.62 — argv 파싱
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

--fix:     V5 (7 파일 auto-allow set declare YAML list 삭제) + R2/R6 (4 NO_BASH_FILES
           harness SKILL + 3 agent dispatcher/explore/grey-area Bash declare 삭제) 자동 정정.
           V8 (콤마 separator) / V9 (YAML list 항목 수) / Stage 4 (broad Bash positive 검사) /
           Stage 6 field name (bidirectional rename)는 Out of scope.
--dry-run: --fix와 함께 — 변경 없이 plan만 출력. Stage 검증 skip.
USAGE
            exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *)   echo "Unexpected arg: $1 (try --help)" >&2; exit 2 ;;
    esac
    shift
done

# 본 v1.10f scope 7 파일
SKILL_FILES=(
  "bootstrap/templates/_base/.claude/skills/harness/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"
)
AGENT_FILES=(
  "bootstrap/templates/_base/.claude/agents/harness-verifier.md"
  "bootstrap/templates/_base/.claude/agents/harness-dispatcher.md"
  "bootstrap/templates/_base/.claude/agents/harness-explore.md"
  "bootstrap/templates/_base/.claude/agents/harness-grey-area.md"
)
ALL_FILES=("${SKILL_FILES[@]}" "${AGENT_FILES[@]}")

# v1.62 — --fix block: Stage 1 진입 전 V5 + R2/R6 자동 정정
if [ "$FIX_MODE" -eq 1 ]; then
    echo "=== --fix mode (V5 + R2/R6) ==="
    fix_count=0

    # V5 — 7 파일 auto-allow set YAML list 삭제
    V5_PAT='^[[:space:]]*-[[:space:]]*Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)[[:space:]]*$'
    for f in "${ALL_FILES[@]}"; do
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

    # R2/R6 — 4 NO_BASH_FILES Bash declare YAML list 삭제 (broad Bash 또는 parenthesized 모두)
    NO_BASH_FILES=(
        "bootstrap/templates/_base/.claude/skills/harness/SKILL.md"
        "bootstrap/templates/_base/.claude/agents/harness-dispatcher.md"
        "bootstrap/templates/_base/.claude/agents/harness-explore.md"
        "bootstrap/templates/_base/.claude/agents/harness-grey-area.md"
    )
    NO_BASH_PAT='^[[:space:]]*-[[:space:]]*Bash([[:space:]]*\(.*\))?[[:space:]]*$'
    for f in "${NO_BASH_FILES[@]}"; do
        if grep -qE "$NO_BASH_PAT" "$f" 2>/dev/null; then
            if [ "$DRY_RUN" -eq 1 ]; then
                grep -nE "$NO_BASH_PAT" "$f" | sed "s|^|  [would fix R2/R6] $f: |"
            else
                sed -E -i.bak "/$NO_BASH_PAT/d" "$f" && rm -f "$f.bak"
                echo "  [fix R2/R6] $f"
            fi
            fix_count=$((fix_count + 1))
        fi
    done

    [ "$fix_count" -eq 0 ] && echo "  (no violations found — 0 fixes)"
    if [ "$DRY_RUN" -eq 1 ]; then
        echo ""
        echo "=== dry-run 종료 (Stage 검증 skip) ==="
        exit 0
    fi
    echo ""
fi

# Stage 1 — V8 (A2): single-line 콤마 separator 잔존 0 (7 파일)
echo "=== Stage 1 — V8 (A2) Separator (single-line comma 잔존 0) ==="
comma=0
for f in "${ALL_FILES[@]}"; do
    n=$(grep -cE '^(allowed-tools|tools):.+,' "$f" || true)
    echo "  $f: $n"
    comma=$((comma + n))
done
[ "$comma" -eq 0 ] || { echo "FAIL — V8 single-line 콤마 separator $comma건 잔존"; exit 1; }
echo "PASS — V8 0건"

# Stage 2 — V9 (A2): YAML list ^  - 라인 수 검증
echo ""
echo "=== Stage 2 — V9 (A2) YAML list 형식 정합 ==="
declare -A EXPECTED=(
  ["bootstrap/templates/_base/.claude/skills/harness/SKILL.md"]=4
  ["bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md"]=5
  ["bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"]=6
  ["bootstrap/templates/_base/.claude/agents/harness-verifier.md"]=4
  ["bootstrap/templates/_base/.claude/agents/harness-dispatcher.md"]=3
  ["bootstrap/templates/_base/.claude/agents/harness-explore.md"]=3
  ["bootstrap/templates/_base/.claude/agents/harness-grey-area.md"]=3
)
for f in "${ALL_FILES[@]}"; do
    expected="${EXPECTED[$f]}"
    # frontmatter section만 추출 (첫 ---부터 두번째 ---까지) 후 ^  - 카운트
    actual=$(awk '/^---$/{c++; next} c==1' "$f" | grep -cE '^[[:space:]][[:space:]]-[[:space:]]' || true)
    echo "  $f: $actual (expected $expected)"
    [ "$actual" -eq "$expected" ] || { echo "FAIL — V9 YAML list entries 수 불일치"; exit 1; }
done
echo "PASS — V9 7 파일 entries 정합"

# Stage 3 — R2 검증: harness/SKILL.md에 Bash declare 부재
echo ""
echo "=== Stage 3 — R2 (harness/SKILL.md Bash declare 제거) ==="
HARNESS_SKILL="bootstrap/templates/_base/.claude/skills/harness/SKILL.md"
fm_section=$(awk '/^---$/{c++; next} c==1' "$HARNESS_SKILL")
bash_lines=$(echo "$fm_section" | grep -cE '^[[:space:]][[:space:]]-[[:space:]]Bash(\s*\(.*\))?$' || true)
echo "  $HARNESS_SKILL: Bash declare $bash_lines건"
[ "$bash_lines" -eq 0 ] || { echo "FAIL — R2 Bash declare 잔존"; exit 1; }
echo "PASS — R2 Bash 제거 정합"

# Stage 4 — R3/R4 검증: broad Bash 유지 (parens 없음 — 3 파일)
echo ""
echo "=== Stage 4 — R3/R4 (harness-run/harness-ship/harness-verifier broad Bash 유지) ==="
BROAD_BASH_FILES=(
  "bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"
  "bootstrap/templates/_base/.claude/agents/harness-verifier.md"
)
for f in "${BROAD_BASH_FILES[@]}"; do
    fm=$(awk '/^---$/{c++; next} c==1' "$f")
    n=$(echo "$fm" | grep -cE '^[[:space:]][[:space:]]-[[:space:]]Bash$' || true)
    echo "  $f: broad Bash $n건"
    [ "$n" -eq 1 ] || { echo "FAIL — R3/R4 broad Bash 부재"; exit 1; }
done
echo "PASS — R3/R4 broad Bash 3 파일 유지"

# Stage 5 — V5 (A4): 자동 허용 set declare 잔존 0 (7 파일)
echo ""
echo "=== Stage 5 — V5 (A4) Redundancy (auto-allow set declare 잔존 0) ==="
auto_set='Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)'
redundant=0
for f in "${ALL_FILES[@]}"; do
    n=$(grep -cE "$auto_set" "$f" || true)
    echo "  $f: $n"
    redundant=$((redundant + n))
done
[ "$redundant" -eq 0 ] || { echo "FAIL — V5 자동 허용 declare $redundant건"; exit 1; }
echo "PASS — V5 0건"

# Stage 6 — Field name (A1) + R6: 3 SKILL allowed-tools: + 4 agent tools: 정합 + R6 3 agent Bash 부재
echo ""
echo "=== Stage 6 — Field name (A1) + R6 ==="
# 3 SKILL: allowed-tools: 존재 + tools: 부재
for f in "${SKILL_FILES[@]}"; do
    grep -qE '^allowed-tools:' "$f" || { echo "FAIL — $f 'allowed-tools:' 부재"; exit 1; }
    if grep -qE '^tools:' "$f"; then
        echo "FAIL — $f 'tools:' 잔존 (skill should use allowed-tools)"; exit 1
    fi
done
echo "  3 SKILL allowed-tools: 정합"
# 4 agent: tools: 존재 + allowed-tools: 부재
for f in "${AGENT_FILES[@]}"; do
    grep -qE '^tools:' "$f" || { echo "FAIL — $f 'tools:' 부재"; exit 1; }
    if grep -qE '^allowed-tools:' "$f"; then
        echo "FAIL — $f 'allowed-tools:' 잔존 (agent should use tools:)"; exit 1
    fi
done
echo "  4 agent tools: 정합"
# R6 — 3 agent (dispatcher/explore/grey-area) Bash declare 부재
R6_AGENTS=(
  "bootstrap/templates/_base/.claude/agents/harness-dispatcher.md"
  "bootstrap/templates/_base/.claude/agents/harness-explore.md"
  "bootstrap/templates/_base/.claude/agents/harness-grey-area.md"
)
for f in "${R6_AGENTS[@]}"; do
    fm=$(awk '/^---$/{c++; next} c==1' "$f")
    n=$(echo "$fm" | grep -cE '^[[:space:]][[:space:]]-[[:space:]]Bash' || true)
    [ "$n" -eq 0 ] || { echo "FAIL — R6 $f Bash declare 잔존 ($n건)"; exit 1; }
done
echo "  R6 — 3 agent Bash declare 부재 정합"
echo "PASS — Stage 6"

echo ""
echo "=== ALL 6 STAGES PASS — v1.10f templates baseline 5축 정합 (7 파일) ==="

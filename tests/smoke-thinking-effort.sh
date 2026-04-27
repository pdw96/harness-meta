#!/usr/bin/env bash
# v1.10g smoke — thinking: 제거 + effort: spec 정합 (4 파일 + 6축 신설)
# Stage 1 (V10 A6 thinking 잔존 0) + Stage 2 (R1 harness-meta sonnet)
# + Stage 3 (R2 3 SKILL effort: xhigh) + Stage 4 (R2 model: opus 보존)
# + Stage 5 (cross-session 회귀 — v1.10d/v1.10f spec 정합 유지)
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

# 본 v1.10g scope 4 파일
SLASH_FILE="claude/commands/harness-meta.md"
OPUS_SKILLS=(
  "bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"
)
ALL_FILES=("$SLASH_FILE" "${OPUS_SKILLS[@]}")

# Stage 1 — V10 (A6): thinking: 필드 잔존 0 (4 파일)
echo "=== Stage 1 — V10 (A6) thinking: 필드 잔존 0 ==="
thinking=0
for f in "${ALL_FILES[@]}"; do
    n=$(grep -cE '^thinking:' "$f" || true)
    echo "  $f: $n"
    thinking=$((thinking + n))
done
[ "$thinking" -eq 0 ] || { echo "FAIL — V10 thinking: $thinking건 잔존 (silent ignore — A1 §4)"; exit 1; }
echo "PASS — V10 0건"

# Stage 2 — R1: harness-meta.md model: sonnet + effort: 부재
echo ""
echo "=== Stage 2 — R1 (harness-meta.md sonnet + effort 부재) ==="
if grep -qE '^model: sonnet$' "$SLASH_FILE"; then
    echo "  $SLASH_FILE: model: sonnet match"
else
    echo "FAIL — R1 model: sonnet 불일치"; exit 1
fi
if grep -qE '^effort:' "$SLASH_FILE"; then
    echo "FAIL — R1 effort: 라인 잔존 (declare 무 의도)"; exit 1
else
    echo "  $SLASH_FILE: effort: 부재 (default high inherit)"
fi
echo "PASS — R1 정합"

# Stage 3 — R2: 3 SKILL effort: xhigh + thinking: 부재 (Stage 1 통과 reinforce)
echo ""
echo "=== Stage 3 — R2 (3 opus SKILL effort: xhigh) ==="
for f in "${OPUS_SKILLS[@]}"; do
    if grep -qE '^effort: xhigh$' "$f"; then
        echo "  $f: effort: xhigh match"
    else
        echo "FAIL — R2 effort: xhigh 불일치 ($f)"; exit 1
    fi
done
echo "PASS — R2 정합 (3/3)"

# Stage 4 — R2 보존: 3 SKILL model: opus 유지
echo ""
echo "=== Stage 4 — R2 보존 (3 SKILL model: opus 유지) ==="
for f in "${OPUS_SKILLS[@]}"; do
    if grep -qE '^model: opus$' "$f"; then
        echo "  $f: model: opus 유지"
    else
        echo "FAIL — model: opus 변경 회귀 ($f)"; exit 1
    fi
done
echo "PASS — model: opus 3/3 유지"

# Stage 5 — cross-session 회귀: v1.10d/v1.10f spec 정합 유지
# V1 (A3 콜론 없음 패턴) + V5 (A4 auto-allow declare) + V8 (A2 single-line 콤마) + V9 (A2 YAML list)
echo ""
echo "=== Stage 5 — cross-session 회귀 (v1.10d/v1.10f spec 정합) ==="

# V1 — 콜론 없음 패턴 잔존 0 (4 파일)
v1=0
for f in "${ALL_FILES[@]}"; do
    n=$(grep -cE 'Bash\([a-z][a-z\-]*\*\)' "$f" || true)
    v1=$((v1 + n))
done
[ "$v1" -eq 0 ] || { echo "FAIL — V1 콜론 없음 패턴 $v1건 잔존"; exit 1; }
echo "  V1 (A3 word-boundary): 0건"

# V5 — auto-allow set declare 잔존 0
v5=0
for f in "${ALL_FILES[@]}"; do
    n=$(grep -cE 'Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)[: ]?\*?\)' "$f" || true)
    v5=$((v5 + n))
done
[ "$v5" -eq 0 ] || { echo "FAIL — V5 auto-allow declare $v5건 잔존"; exit 1; }
echo "  V5 (A4 auto-allow): 0건"

# V8 — single-line 콤마 separator 잔존 0
v8=0
for f in "${ALL_FILES[@]}"; do
    n=$(grep -cE '^(allowed-tools|tools):.+,' "$f" || true)
    v8=$((v8 + n))
done
[ "$v8" -eq 0 ] || { echo "FAIL — V8 single-line 콤마 separator $v8건 잔존"; exit 1; }
echo "  V8 (A2 separator): 0건"

# V9 — YAML list 형식 (allowed-tools: 다음 ^  - 라인 ≥3)
declare -A EXPECTED_LIST=(
  ["claude/commands/harness-meta.md"]=14
  ["bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md"]=5
  ["bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md"]=6
  ["bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"]=6
)
for f in "${ALL_FILES[@]}"; do
    actual=$(awk '/^allowed-tools:[[:space:]]*$/{flag=1; next} flag && /^[a-z]/{flag=0} flag && /^  - /{c++} END{print c+0}' "$f")
    expected="${EXPECTED_LIST[$f]}"
    if [ "$actual" -ge "$expected" ]; then
        echo "  V9 ($f): $actual 라인 (≥$expected)"
    else
        echo "FAIL — V9 ($f): $actual 라인 (<$expected 기대)"; exit 1
    fi
done
echo "PASS — Stage 5 v1.10d/v1.10f spec 정합 유지"

echo ""
echo "================================================"
echo "ALL STAGES PASS — v1.10g thinking-effort 5/5 ✓"
echo "================================================"

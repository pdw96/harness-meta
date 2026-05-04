#!/usr/bin/env bash
# v1.10g smoke — thinking: 제거 + effort: spec 정합 (4 파일 + 6축 신설)
# Stage 1 (V10 A6 thinking 잔존 0) + Stage 2 (R1 harness-meta sonnet)
# + Stage 3 (R2 3 SKILL effort: xhigh) + Stage 4 (R2 model: opus 보존)
# + Stage 5 (cross-session 회귀 — v1.10d/v1.10f spec 정합 유지)
# v1.61 — --fix mode: V10 (^thinking: line auto-remove).
# v1.71 — --fix mode 확장: R1/R2/R3 frontmatter insert/replace (Python 위임).
#         R1: slash command model: sonnet insert/replace + effort: line-delete
#         R2: 3 opus SKILL effort: xhigh insert/replace
#         R3: 3 opus SKILL model: opus insert/replace
#
# Usage:
#   bash tests/smoke-thinking-effort.sh                 # default — Stage 1~5 검증
#   bash tests/smoke-thinking-effort.sh --fix           # V10+R1/R2/R3 위반 자동 정정 후 검증
#   bash tests/smoke-thinking-effort.sh --fix --dry-run # 변경 없이 plan 출력
#   bash tests/smoke-thinking-effort.sh --help          # usage
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

# v1.61 — argv 파싱
FIX_MODE=0
DRY_RUN=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h)
            cat <<USAGE
Usage: $0 [--fix [--dry-run]]

Default mode (no args): Stage 1~5 검증 (회귀 0).

--fix:     V10 (^thinking: line auto-remove) + R1/R2/R3 (model+effort frontmatter insert/replace).
           R1: slash command model: sonnet (effort: 부재 보장)
           R2: 3 opus SKILL effort: xhigh
           R3: 3 opus SKILL model: opus
           Stage 5 (V1/V5/V8/V9 cross-session)는 다른 smoke 중복 회피 → Out of scope.
--dry-run: --fix와 함께 — 변경 없이 plan만 출력. Stage 검증 skip.
USAGE
            exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *)   echo "Unexpected arg: $1 (try --help)" >&2; exit 2 ;;
    esac
    shift
done

# 본 v1.10g scope 4 파일
SLASH_FILE="claude/commands/harness-meta.md"
OPUS_SKILLS=(
  "bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"
)
ALL_FILES=("$SLASH_FILE" "${OPUS_SKILLS[@]}")

# v1.61 — --fix block: Stage 1 진입 전 V10 자동 정정
if [ "$FIX_MODE" -eq 1 ]; then
    echo "=== --fix mode (V10 ^thinking: line auto-remove) ==="
    fix_count=0
    for f in "${ALL_FILES[@]}"; do
        if grep -qE '^thinking:' "$f" 2>/dev/null; then
            if [ "$DRY_RUN" -eq 1 ]; then
                grep -nE '^thinking:' "$f" | sed "s|^|  [would fix V10] $f: |"
            else
                sed -E -i.bak '/^thinking:/d' "$f" && rm -f "$f.bak"
                echo "  [fix V10] $f"
            fi
            fix_count=$((fix_count + 1))
        fi
    done
    [ "$fix_count" -eq 0 ] && echo "  (no violations found — 0 fixes)"

    # v1.71 — R1/R2/R3 frontmatter insert/replace (Python 위임)
    echo ""
    echo "=== --fix mode (R1/R2/R3 model+effort frontmatter insert/replace) ==="
    DRY_RUN_PY="$DRY_RUN" python3 - "$SLASH_FILE" "${OPUS_SKILLS[@]}" <<'PYEOF'
import os, sys
from pathlib import Path

# Windows cp949 default 환경 — UTF-8 출력 보장 (v1.18d 패턴)
for stream in (sys.stdout, sys.stderr):
    if hasattr(stream, "reconfigure"):
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except (AttributeError, ValueError, OSError):
            pass

DRY = os.environ.get("DRY_RUN_PY", "0") == "1"
slash_file = sys.argv[1]
opus_files = sys.argv[2:]

# 기대값: (file, model_expected, effort_expected) — None은 "부재 보장"
TARGETS = [(slash_file, "sonnet", None)]
TARGETS += [(f, "opus", "xhigh") for f in opus_files]

def fix_frontmatter(path, want_model, want_effort):
    p = Path(path)
    lines = p.read_text(encoding="utf-8").splitlines(keepends=False)
    if not lines or lines[0].strip() != "---":
        print(f"  WARN: {path} — frontmatter 부재 (skip)")
        return 0
    # closing --- 위치
    close_idx = None
    for i in range(1, len(lines)):
        if lines[i].strip() == "---":
            close_idx = i
            break
    if close_idx is None:
        print(f"  WARN: {path} — closing '---' 부재 (skip)")
        return 0

    fm = lines[1:close_idx]
    changes = []

    def find_field(field):
        for j, ln in enumerate(fm):
            if ln.startswith(field + ":"):
                return j
        return -1

    # model 처리
    mi = find_field("model")
    if want_model is None:
        if mi >= 0:
            changes.append(("delete", mi, f"model: ... (want absent)"))
    else:
        want_line = f"model: {want_model}"
        if mi < 0:
            changes.append(("insert", len(fm), want_line))
        elif fm[mi] != want_line:
            changes.append(("replace", mi, want_line))

    # effort 처리
    ei = find_field("effort")
    if want_effort is None:
        if ei >= 0:
            changes.append(("delete", ei, f"effort: ... (want absent)"))
    else:
        want_line = f"effort: {want_effort}"
        if ei < 0:
            changes.append(("insert", len(fm), want_line))
        elif fm[ei] != want_line:
            changes.append(("replace", ei, want_line))

    if not changes:
        return 0

    if DRY:
        for action, idx, val in changes:
            tag = {"insert": "R*-insert", "replace": "R*-replace", "delete": "R*-delete"}[action]
            print(f"  [would fix {tag}] {path}: {val}")
        return len(changes)

    # 실 적용 — delete를 역순으로 처리 (인덱스 안정)
    new_fm = list(fm)
    inserts = [c for c in changes if c[0] == "insert"]
    replaces = [c for c in changes if c[0] == "replace"]
    deletes = sorted([c for c in changes if c[0] == "delete"], key=lambda x: -x[1])

    for _, idx, val in deletes:
        del new_fm[idx]
    for _, idx, val in replaces:
        # delete 후 idx 가 시프트될 수 있으므로 field 이름으로 재탐색
        field = val.split(":", 1)[0]
        for j, ln in enumerate(new_fm):
            if ln.startswith(field + ":"):
                new_fm[j] = val
                break
    for _, idx, val in inserts:
        # closing 직전 (= len(new_fm))에 추가
        new_fm.append(val)

    out = ["---"] + new_fm + ["---"] + lines[close_idx + 1:]
    p.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    for action, idx, val in changes:
        tag = {"insert": "R*-insert", "replace": "R*-replace", "delete": "R*-delete"}[action]
        print(f"  [fix {tag}] {path}: {val}")
    return len(changes)

total = 0
for path, wm, we in TARGETS:
    total += fix_frontmatter(path, wm, we)

if total == 0:
    print("  (no R1/R2/R3 violations found — 0 fixes)")
PYEOF

    if [ "$DRY_RUN" -eq 1 ]; then
        echo ""
        echo "=== dry-run 종료 (Stage 검증 skip) ==="
        exit 0
    fi
    echo ""
fi

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

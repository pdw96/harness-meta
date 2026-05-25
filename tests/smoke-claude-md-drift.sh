#!/usr/bin/env bash
# tests/smoke-claude-md-drift.sh — root ↔ module CLAUDE.md drift detection (v1.79)
# 도입 세션: sessions/meta/v1.79-claude-md-drift-smoke/
#
# Stage S1: 모듈 CLAUDE.md 존재 확인 (root 표 ↔ 실제 파일) — 5건
# Stage S2: 각 모듈 CLAUDE.md의 상위 back-reference 링크 존재 확인 — 5건
# Stage S3: root ↔ 모듈 대형 중복 블록 감지 (≥5 연속 행 fingerprint) — 5건
# Stage S4: root "smoke N 매트릭스" 기술 정합 (실제 smoke 파일 수 일치) — 1건
#
# Usage:
#   bash tests/smoke-claude-md-drift.sh

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/harness-meta")}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0
ok()   { echo "  ✓ $*"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $*"; FAIL=$((FAIL+1)); }

MODULE_PATHS=(
    "bootstrap/skills/CLAUDE.md"
    "claude/CLAUDE.md"
    "tests/CLAUDE.md"
    "development/CLAUDE.md"
)

# ─── Stage S1 — Module Existence ─────────────────────────────────────────────
echo "=== Stage S1 — Module Existence (${#MODULE_PATHS[@]}) ==="

for mod in "${MODULE_PATHS[@]}"; do
    if [[ -f "$mod" ]]; then
        ok "$mod 존재"
    else
        fail "$mod 누락"
    fi
done

# ─── Stage S2 — Back-reference Link ──────────────────────────────────────────
echo ""
echo "=== Stage S2 — Back-reference Link (${#MODULE_PATHS[@]}) ==="

# bootstrap/skills/CLAUDE.md → ../CLAUDE.md (= bootstrap/CLAUDE.md) 의도적 계층 (skills→bootstrap→root)
# 다른 4개 모듈 → ../CLAUDE.md (= root)
# 공통 패턴: 파일 내 "상위 진입" 또는 ../*CLAUDE.md 링크 존재 여부만 검사

for mod in "${MODULE_PATHS[@]}"; do
    if [[ ! -f "$mod" ]]; then
        fail "$mod 누락 (S2 skip)"
        continue
    fi
    if grep -qE '상위[[:space:]]+진입|\.\.\/.*CLAUDE\.md|\.\.\.\.\/(CLAUDE\.md)' "$mod"; then
        ok "$mod: 상위 CLAUDE.md back-reference 존재"
    else
        fail "$mod: 상위 CLAUDE.md back-reference 누락"
    fi
done

# ─── Stage S3 — Content Duplication Detection ─────────────────────────────────
echo ""
echo "=== Stage S3 — Content Duplication (${#MODULE_PATHS[@]}) ==="

# Python sliding window (5행): root CLAUDE.md ↔ 각 모듈 fingerprint 비교
# 필터: 구조적 행(#/|/-/---로 시작) ≥ 60% 인 window skip (Markdown 표/헤더 관용 패턴 제외)

for mod in "${MODULE_PATHS[@]}"; do
    if [[ ! -f "$mod" ]]; then
        fail "$mod 누락 (S3 skip)"
        continue
    fi

    result=$(python3 - "CLAUDE.md" "$mod" <<'PYEOF'
import sys, hashlib

ROOT = sys.argv[1]
MOD  = sys.argv[2]

WINDOW = 5
STRUCTURAL_RATIO_THRESHOLD = 0.6

STRUCTURAL_PREFIXES = ('#', '|', '-', '>')

def is_structural(line):
    s = line.strip()
    if not s:
        return True
    if s.startswith('---') or s == '---':
        return True
    return any(s.startswith(p) for p in STRUCTURAL_PREFIXES)

def get_windows(path):
    with open(path, encoding='utf-8', errors='replace') as fh:
        lines = [ln.rstrip() for ln in fh if ln.strip()]
    wins = set()
    for i in range(len(lines) - WINDOW + 1):
        chunk = lines[i:i + WINDOW]
        structural = sum(1 for ln in chunk if is_structural(ln))
        if structural / WINDOW >= STRUCTURAL_RATIO_THRESHOLD:
            continue
        key = '\n'.join(chunk)
        wins.add(hashlib.sha256(key.encode()).hexdigest())
    return wins

try:
    root_wins = get_windows(ROOT)
    mod_wins  = get_windows(MOD)
    shared    = root_wins & mod_wins
    if shared:
        print(f"FAIL:{len(shared)}")
    else:
        print("OK")
except Exception as e:
    print(f"ERR:{e}")
PYEOF
    )

    if [[ "$result" == "OK" ]]; then
        ok "$mod: 대형 중복 블록 없음"
    elif [[ "$result" == FAIL:* ]]; then
        cnt="${result#FAIL:}"
        fail "$mod: 중복 5-line 블록 ${cnt}건 감지 (root CLAUDE.md와 동일 — drift 의심)"
    else
        fail "$mod: S3 검사 오류 — ${result}"
    fi
done

# ─── Stage S4 — Root Smoke Count Accuracy ────────────────────────────────────
echo ""
echo "=== Stage S4 — Root Smoke Count Accuracy (1) ==="

actual_count=$(find tests -maxdepth 1 -name 'smoke-*.sh' 2>/dev/null | wc -l | tr -d ' ')
doc_count=$(grep -oE '현 ([0-9]+) 파일' tests/CLAUDE.md 2>/dev/null \
    | grep -oE '[0-9]+' | head -1 || echo "")

if [[ -z "$doc_count" ]]; then
    fail "tests/CLAUDE.md에서 '현 N 파일' 패턴을 찾을 수 없음"
elif [[ "$actual_count" -eq "$doc_count" ]]; then
    ok "smoke count 정합: tests/CLAUDE.md '${doc_count}' = 실제 파일 수 ${actual_count}"
else
    fail "smoke count 불일치: tests/CLAUDE.md '${doc_count}' ≠ 실제 ${actual_count} (갱신 필요)"
fi

# ─── Summary ──────────────────────────────────────────────────────────────────
echo ""
total=$((PASS + FAIL))
if [[ $FAIL -eq 0 ]]; then
    echo "RESULT: ${PASS}/${total} PASS"
else
    echo "RESULT: ${PASS}/${total} PASS (${FAIL} FAIL)"
fi
[[ $FAIL -eq 0 ]]

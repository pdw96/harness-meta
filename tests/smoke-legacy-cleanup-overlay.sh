#!/usr/bin/env bash
# v1.21 smoke — legacy cleanup overlay-aware 검증
# Stage 1: 정적 (3 checks)
# Stage 2: dynamic install (6 checks, sample-project fixture, T1~T5)
# 단일 소스: bootstrap/docs/OVERLAY.md §11

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

# ============================================================
# Stage 1 — 정적 (3 checks)
# ============================================================
echo "=== Stage 1 — 정적 알고리즘 검증 ==="

# S1.1 install-project-claude.sh: Section 2.4 통합 추출 + in_overlay 검사
SH="bootstrap/install-project-claude.sh"
if grep -q '^# 2.4' "$SH" \
   && grep -q '^overlay_path=' "$SH" \
   && grep -q 'in_overlay=' "$SH" \
   && grep -q 'in_base.*-eq 0.*in_overlay.*-eq 0\|in_base.*0.*in_overlay.*0' "$SH"; then
    ok "install-project-claude.sh: Section 2.4 + in_overlay 검사 패턴"
else
    fail "install-project-claude.sh: 키워드 누락 (Section 2.4 / overlay_path / in_overlay)"
fi

# S1.2 install-project-claude.ps1: 동등 mirror (overlayPath + inOverlay)
PS1="bootstrap/install-project-claude.ps1"
if grep -q '# 2.4' "$PS1" \
   && grep -q '\$overlayPath' "$PS1" \
   && grep -q '\$inOverlay' "$PS1" \
   && grep -q '\$matchResult' "$PS1"; then
    ok "install-project-claude.ps1: Section 2.4 + overlayPath + inOverlay + null-safe"
else
    fail "install-project-claude.ps1: 키워드 누락"
fi

# S1.3 OVERLAY.md §11 재작성 keyword
DOC="bootstrap/docs/OVERLAY.md"
if grep -q 'Legacy cleanup overlay-aware (v1.21' "$DOC" \
   && grep -q '양쪽 검사' "$DOC" \
   && grep -q 'v1.11b.*활성 버그\|활성 버그' "$DOC"; then
    ok "OVERLAY.md §11: v1.21 재작성 + 양쪽 검사 + 활성 버그 명시"
else
    fail "OVERLAY.md §11: 키워드 누락"
fi

# ============================================================
# Stage 2 — Dynamic install (6 checks, sample-project fixture)
# ============================================================
echo ""
echo "=== Stage 2 — Dynamic install (sample-project fixture) ==="

TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'legacy-cleanup-smoke')
trap "rm -rf '$TMPDIR'" EXIT

# Setup: sample-project 전체 복사 (.harness.toml + scripts/ 포함)
cp -r tests/fixtures/sample-project/. "$TMPDIR/"

INSTALL_LOG="$TMPDIR/install.log"

# ============================================================
# T1 — 첫 install (no -f)
# ============================================================
echo "  -- T1: 첫 install (no -f) --"
if HARNESS_META_ROOT="$HARNESS_META_ROOT" bash bootstrap/install-project-claude.sh "$TMPDIR" >"$INSTALL_LOG" 2>&1; then
    if [ -f "$TMPDIR/.claude/skills/harness-python/SKILL.md" ]; then
        ok "T1 — 첫 install + harness-python 정상 복사 (Phase 2)"
    else
        fail "T1 — harness-python/SKILL.md 부재"
        cat "$INSTALL_LOG" >&2 || true
    fi
else
    fail "T1 — install exit != 0"
    cat "$INSTALL_LOG" >&2 || true
fi

# ============================================================
# T2 — --force 재install (overlay 정합 유지) — CRITICAL G fix 검증
# ============================================================
echo "  -- T2: --force 재install (G fix 검증, CRITICAL) --"
T2_LOG="$TMPDIR/install-t2.log"
sleep 1   # backup-<ts> 디렉토리 ts 충돌 회피
if HARNESS_META_ROOT="$HARNESS_META_ROOT" bash bootstrap/install-project-claude.sh "$TMPDIR" -f >"$T2_LOG" 2>&1; then
    : # exit 0 OK
else
    fail "T2 — install exit != 0"
    cat "$T2_LOG" >&2 || true
fi

# T2.a (CRITICAL): 'legacy cleanup' 키워드 부재
if grep -q 'legacy cleanup' "$T2_LOG"; then
    fail "T2.a CRITICAL — 'legacy cleanup' 트리거됨 (G fix 실패)"
    grep 'legacy cleanup\|backup' "$T2_LOG" >&2 || true
else
    ok "T2.a CRITICAL — 'legacy cleanup' 미발생 (G fix 검증)"
fi

# T2.b (CRITICAL): backup-*/skills/ 내 harness-python 부재
spurious=$(find "$TMPDIR/.claude" -maxdepth 4 -path '*/backup-*/skills/harness-python' -type d 2>/dev/null | wc -l)
if [ "$spurious" -eq 0 ]; then
    ok "T2.b CRITICAL — backup-*/skills/harness-python 부재 (G fix 검증)"
else
    fail "T2.b CRITICAL — backup-*/skills/harness-python 발견 ($spurious건)"
    find "$TMPDIR/.claude" -path '*/backup-*/skills/harness-python' >&2 || true
fi

# ============================================================
# T3 — language 변경 (python → haskell, overlay 부재) — legitimate cleanup
# ============================================================
echo "  -- T3: language 변경 후 --force (legitimate cleanup) --"
awk '/^language/{print "language = \"haskell\""; next}{print}' \
    "$TMPDIR/.harness.toml" > "$TMPDIR/.tmp" \
    && mv "$TMPDIR/.tmp" "$TMPDIR/.harness.toml"

T3_LOG="$TMPDIR/install-t3.log"
sleep 1
HARNESS_META_ROOT="$HARNESS_META_ROOT" bash bootstrap/install-project-claude.sh "$TMPDIR" -f >"$T3_LOG" 2>&1 || true

# T3 검증: harness-python을 backup으로 이동 (legitimate)
moved=$(find "$TMPDIR/.claude" -maxdepth 4 -path '*/backup-*/skills/harness-python' -type d 2>/dev/null | wc -l)
if [ "$moved" -ge 1 ]; then
    ok "T3 — language 변경 후 harness-python backup 이동 (legitimate cleanup)"
else
    fail "T3 — harness-python backup 이동 실패"
    cat "$T3_LOG" >&2 || true
fi

# ============================================================
# T4 — language 복원 (python) → harness-python 재복사
# ============================================================
echo "  -- T4: language 복원 후 --force (overlay 재적용) --"
awk '/^language/{print "language = \"python\""; next}{print}' \
    "$TMPDIR/.harness.toml" > "$TMPDIR/.tmp" \
    && mv "$TMPDIR/.tmp" "$TMPDIR/.harness.toml"

T4_LOG="$TMPDIR/install-t4.log"
sleep 1
HARNESS_META_ROOT="$HARNESS_META_ROOT" bash bootstrap/install-project-claude.sh "$TMPDIR" -f >"$T4_LOG" 2>&1 || true

if [ -f "$TMPDIR/.claude/skills/harness-python/SKILL.md" ]; then
    ok "T4 — language 복원 후 harness-python 재복사 (Phase 2 overlay)"
else
    fail "T4 — harness-python 재복사 실패"
    cat "$T4_LOG" >&2 || true
fi

# ============================================================
# T5 — _base 항목 (skills/harness/) 정상 잔존 — 회귀 0
# ============================================================
echo "  -- T5: _base 항목 회귀 0 --"
if [ -f "$TMPDIR/.claude/skills/harness/SKILL.md" ]; then
    ok "T5 — _base/skills/harness/SKILL.md 정상 잔존 (회귀 0)"
else
    fail "T5 — _base 항목 회귀 발생"
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

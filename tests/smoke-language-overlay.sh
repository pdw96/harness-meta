#!/usr/bin/env bash
# v1.11b smoke — language overlay 인프라 + harness-python 실 콘텐츠 검증
# Stage 1: 정적 인프라 (6 checks)
# Stage 2: dynamic install (5 checks, sample-project fixture)
# 단일 소스: bootstrap/docs/OVERLAY.md

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

PASS=0; FAIL=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

# ============================================================
# Stage 1 — 정적 인프라 (4 checks)
# ============================================================
echo "=== Stage 1 — 정적 인프라 ==="

# S1.1 placeholder 존재
if [ -f "bootstrap/templates/python/.claude/.gitkeep" ]; then
    ok "bootstrap/templates/python/.claude/.gitkeep 존재"
else
    fail "bootstrap/templates/python/.claude/.gitkeep 부재"
fi

# S1.2 install-project-claude.sh: language extract + lowercase + Phase 2 + .gitkeep skip
SH="bootstrap/install-project-claude.sh"
if grep -q "tr 'A-Z' 'a-z'" "$SH" \
   && grep -q "Phase 2" "$SH" \
   && grep -q '\.gitkeep' "$SH" \
   && grep -q 'overlay overwrite' "$SH"; then
    ok "install-project-claude.sh: Phase 2 + lowercase + .gitkeep skip + overlay overwrite"
else
    fail "install-project-claude.sh: 키워드 누락 (Phase 2 / lowercase / .gitkeep / overlay overwrite)"
fi

# S1.3 install-project-claude.ps1: 동상 + Where-Object skip
PS1="bootstrap/install-project-claude.ps1"
if grep -q 'ToLower' "$PS1" \
   && grep -q 'Phase 2' "$PS1" \
   && grep -q "Where-Object.*\.gitkeep" "$PS1" \
   && grep -q 'overlay overwrite' "$PS1"; then
    ok "install-project-claude.ps1: Phase 2 + ToLower + Where-Object .gitkeep + overlay overwrite"
else
    fail "install-project-claude.ps1: 키워드 누락"
fi

# S1.5 harness-python/SKILL.md 존재
if [ -f "bootstrap/templates/python/.claude/skills/harness-python/SKILL.md" ]; then
    ok "harness-python/SKILL.md 존재 (overlay 실 콘텐츠)"
else
    fail "harness-python/SKILL.md 부재"
fi

# S1.6 name: harness-python frontmatter 포함 (harness-* prefix 준수)
if grep -q '^name: harness-python' \
        "bootstrap/templates/python/.claude/skills/harness-python/SKILL.md" 2>/dev/null; then
    ok "harness-python SKILL.md: name: harness-python (harness-* prefix 준수)"
else
    fail "harness-python SKILL.md: name 필드 누락 또는 harness-* prefix 위반"
fi

# S1.4 OVERLAY.md 존재 + 14 § keyword
DOC="bootstrap/docs/OVERLAY.md"
if [ -f "$DOC" ]; then
    keywords=("개요" "디렉토리 규약" "Language 매트릭스" "Language 정규화" \
              "Reserved prefix" "Naming convention" "Merge 알고리즘" \
              "충돌 시나리오" ".gitkeep" "Recursion" "Legacy cleanup" \
              "빈 overlay" "v1.11 scope" "관련 문서")
    miss=0
    for kw in "${keywords[@]}"; do
        grep -q "$kw" "$DOC" || miss=$((miss+1))
    done
    if [ "$miss" -eq 0 ]; then
        ok "OVERLAY.md 존재 + 14 § keyword 모두 매치"
    else
        fail "OVERLAY.md keyword $miss건 누락 (14 §)"
    fi
else
    fail "OVERLAY.md 부재"
fi

# ============================================================
# Stage 2 — Dynamic install (4 checks)
# ============================================================
echo ""
echo "=== Stage 2 — Dynamic install (sample-project fixture) ==="

TMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'overlay-smoke')
trap "rm -rf '$TMPDIR'" EXIT

# Setup: sample-project 전체 복사 (.harness.toml + scripts/ 포함)
cp -r tests/fixtures/sample-project/. "$TMPDIR/"

# S2.1 install 실행 → exit 0
INSTALL_OUT="$TMPDIR/install.log"
if HARNESS_META_ROOT="$HARNESS_META_ROOT" bash bootstrap/install-project-claude.sh "$TMPDIR" >"$INSTALL_OUT" 2>&1; then
    ok "install-project-claude.sh exit 0"
else
    fail "install exit != 0 (log: $INSTALL_OUT)"
    cat "$INSTALL_OUT" >&2 || true
fi

# S2.2 _base 카테고리 디렉토리 생성됨
all_cats=1
for cat in agents skills output-styles; do
    [ -d "$TMPDIR/.claude/$cat" ] || all_cats=0
done
if [ "$all_cats" -eq 1 ]; then
    ok ".claude/{agents,skills,output-styles}/ 모두 생성"
else
    fail ".claude/ 일부 카테고리 부재"
fi

# S2.3 _base/skills/harness/SKILL.md 복사 검증 (sub-dir recursion)
if [ -f "$TMPDIR/.claude/skills/harness/SKILL.md" ]; then
    ok ".claude/skills/harness/SKILL.md 존재 (_base sub-dir 복사)"
else
    fail ".claude/skills/harness/SKILL.md 부재"
fi

# S2.4 top-level overlay .gitkeep skip 정합 — sample-project는 language="python"
# v1.11b: python/.claude/skills/harness-python/ 존재 → Phase 2 active (harness-python 복사)
# python/.claude/.gitkeep (top-level) → skip. harness-python/ 내부는 .gitkeep 없음
# dest .claude 어디에도 .gitkeep 없어야 함
if find "$TMPDIR/.claude" -name '.gitkeep' 2>/dev/null | grep -q .; then
    fail "dest에 .gitkeep 잔존 (overlay skip 실패)"
else
    ok "dest에 .gitkeep 부재 (top-level overlay .gitkeep skip 정합)"
fi

# S2.5 harness-python/SKILL.md가 실제 설치됨 (Phase 2 active copy 검증)
if [ -f "$TMPDIR/.claude/skills/harness-python/SKILL.md" ]; then
    ok ".claude/skills/harness-python/SKILL.md 존재 (Phase 2 overlay 복사)"
else
    fail ".claude/skills/harness-python/SKILL.md 부재 (Phase 2 복사 실패)"
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

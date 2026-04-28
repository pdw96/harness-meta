#!/usr/bin/env bash
# test-install-guards.sh — install-project-claude.sh 가드 + --force 동작 검증
#
# Coverage:
#   G1: manifest(.harness.toml) 없음 → exit 1
#   G2: base template 없음           → exit 1
#   G3: 정상 install                 → exit 0 + .claude/ 생성
#   G4: 충돌 있는데 --force 없음     → exit 1
#   G5: --force → backup 디렉토리 생성 + 재설치 성공

set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
INSTALL="$HARNESS_META_ROOT/bootstrap/install-project-claude.sh"
SAMPLE="$HARNESS_META_ROOT/tests/fixtures/sample-project"

PASS=0; FAIL=0
ok()   { echo "  [OK] $1"; PASS=$((PASS+1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL+1)); }

echo "=== test-install-guards ==="

# ── G1: manifest 없음 → exit 1 ──────────────────────────────────
TMPDIR=$(mktemp -d)
set +e
HARNESS_META_ROOT="$HARNESS_META_ROOT" bash "$INSTALL" "$TMPDIR" 2>/dev/null
EXIT_CODE=$?
set -e
rm -rf "$TMPDIR"
if [ "$EXIT_CODE" -eq 1 ]; then
    ok "G1: manifest 없음 → exit 1"
else
    fail "G1: manifest 없음 → expected exit 1, got: $EXIT_CODE"
fi

# ── G2: base template 없음 (잘못된 HARNESS_META_ROOT) → exit 1 ──
TMPDIR=$(mktemp -d)
cp -r "$SAMPLE/." "$TMPDIR/"
set +e
HARNESS_META_ROOT="/nonexistent/path" bash "$INSTALL" "$TMPDIR" 2>/dev/null
EXIT_CODE=$?
set -e
rm -rf "$TMPDIR"
if [ "$EXIT_CODE" -eq 1 ]; then
    ok "G2: 잘못된 HARNESS_META_ROOT → exit 1"
else
    fail "G2: 잘못된 HARNESS_META_ROOT → expected exit 1, got: $EXIT_CODE"
fi

# ── G3: 정상 install → exit 0 + .claude/ 생성 ───────────────────
TMPDIR=$(mktemp -d)
cp -r "$SAMPLE/." "$TMPDIR/"
HARNESS_META_ROOT="$HARNESS_META_ROOT" bash "$INSTALL" "$TMPDIR" 2>/dev/null
EXIT_CODE=$?
if [ "$EXIT_CODE" -eq 0 ] && [ -d "$TMPDIR/.claude" ]; then
    FILE_COUNT=$(find "$TMPDIR/.claude" -type f | wc -l)
    ok "G3: 정상 install → exit 0 + .claude/ ($FILE_COUNT 파일)"
else
    fail "G3: 정상 install → exit=$EXIT_CODE .claude exists=$([ -d "$TMPDIR/.claude" ] && echo Y || echo N)"
fi

# ── G4: 충돌 있는데 --force 없음 → exit 1 ───────────────────────
set +e
HARNESS_META_ROOT="$HARNESS_META_ROOT" bash "$INSTALL" "$TMPDIR" 2>/dev/null
EXIT_CODE=$?
set -e
if [ "$EXIT_CODE" -eq 1 ]; then
    ok "G4: 충돌 + --force 없음 → exit 1"
else
    fail "G4: 충돌 + --force 없음 → expected exit 1, got: $EXIT_CODE"
fi

# ── G5: --force → backup 디렉토리 생성 + 재설치 성공 ────────────
HARNESS_META_ROOT="$HARNESS_META_ROOT" bash "$INSTALL" "$TMPDIR" --force 2>/dev/null
EXIT_CODE=$?
BACKUP_DIR=$(ls "$TMPDIR/.claude/" | grep "^backup-" | head -1 || true)
if [ "$EXIT_CODE" -eq 0 ] && [ -n "$BACKUP_DIR" ]; then
    ok "G5: --force → exit 0 + backup 디렉토리 생성 ($BACKUP_DIR)"
else
    fail "G5: --force → exit=$EXIT_CODE backup=$(ls "$TMPDIR/.claude/" | grep backup || echo NONE)"
fi

rm -rf "$TMPDIR"

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1

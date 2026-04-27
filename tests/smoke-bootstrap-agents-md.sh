#!/usr/bin/env bash
# smoke-bootstrap-agents-md.sh — v1.10b strict 검증
# 6 stage / 4 검증 포인트:
#   AGENTS.md.tmpl 8 sections + 13 sed 변수 + footer link + license/install_cmd placeholder
#   CLAUDE.md.tmpl 3 import (@AGENTS.md + @ARCHITECTURE.md + @CLAUDE.override.md)
#   CLAUDE.override.md.tmpl Q13 marker
#   sed 13 변수 치환 + bootstrap_version stamp + license/install_cmd placeholder 잔존 + {{ 잔존 0
# v1.10b strict (옵션 B): license / install_cmd 변수는 v1.10c 후속 — placeholder 형태로 유지

set -euo pipefail
META_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "[smoke] META_ROOT=$META_ROOT"

# ============================================================
# Stage 1: AGENTS.md.tmpl 8 sections (7 categories + Status, W5+W11+N14+N21)
# ============================================================
TMPL="$META_ROOT/bootstrap/skeletons/AGENTS.md.tmpl"
[ -f "$TMPL" ] || { echo "FAIL S1 AGENTS.md.tmpl missing"; exit 1; }
for marker in "## Setup commands" "## Code style" "## Project structure" "## Session workflow" "## Testing instructions" "## PR instructions" "## Boundaries" "## Status"; do
    grep -q "^$marker$" "$TMPL" || { echo "FAIL S1 section missing: $marker"; exit 1; }
done
echo "[Stage 1] AGENTS.md.tmpl 8 sections PASS (공식 agents.md sample 4 § 일치 + PLAN 고유 4 §)"

# ============================================================
# Stage 2: AGENTS.md.tmpl 13 sed 변수 + description placeholder + N17 README 관계 + footer link + license/install_cmd placeholder
# ============================================================
for var in "{{name}}" "{{language}}" "{{runtime_version}}" "{{package_manager}}" \
           "{{code_dir}}" "{{phases_dir}}" "{{locale}}" \
           "{{test_cmd}}" "{{lint_cmd}}" "{{format_cmd}}" \
           "{{type_check_cmd}}" "{{build_cmd}}" "{{bootstrap_version}}"; do
    grep -q "$var" "$TMPL" || { echo "FAIL S2 var missing: $var"; exit 1; }
done
# description placeholder (M3+N7)
grep -q '<!-- TODO: 1-line project description' "$TMPL" || { echo "FAIL S2 description placeholder"; exit 1; }
# license / install_cmd placeholder (v1.10c 이연)
grep -q 'License: see LICENSE' "$TMPL" || { echo "FAIL S2 license placeholder (v1.10c 이연)"; exit 1; }
grep -q 'Install deps: <see project README' "$TMPL" || { echo "FAIL S2 install_cmd placeholder (v1.10c 이연)"; exit 1; }
# AGENTS.md complements README.md (N17)
grep -q 'AGENTS.md complements README.md' "$TMPL" || { echo "FAIL S2 README relation"; exit 1; }
# footer link (W14+W22)
grep -q 'pdw96/harness-meta' "$TMPL" || { echo "FAIL S2 footer pdw96 link"; exit 1; }
grep -q 'agents.md spec' "$TMPL" || { echo "FAIL S2 footer agents.md link"; exit 1; }
echo "[Stage 2] AGENTS.md.tmpl 13 sed vars + placeholders + README relation + footer link PASS"

# ============================================================
# Stage 3: CLAUDE.md.tmpl 3 import lines (N1)
# ============================================================
CLAUDE_TMPL="$META_ROOT/bootstrap/skeletons/CLAUDE.md.tmpl"
[ -f "$CLAUDE_TMPL" ] || { echo "FAIL S3 CLAUDE.md.tmpl missing"; exit 1; }
grep -q '^@AGENTS.md$' "$CLAUDE_TMPL" || { echo "FAIL S3 @AGENTS.md import"; exit 1; }
grep -q '@~/harness-meta/projects/{{name}}/ARCHITECTURE.md' "$CLAUDE_TMPL" || { echo "FAIL S3 ARCHITECTURE import"; exit 1; }
grep -q '^@CLAUDE.override.md$' "$CLAUDE_TMPL" || { echo "FAIL S3 @CLAUDE.override.md import"; exit 1; }
echo "[Stage 3] CLAUDE.md.tmpl 3 imports PASS"

# ============================================================
# Stage 4: AGENTS.md.tmpl sed 치환 mock (13 변수, license/install_cmd 잔존, bootstrap_version stamp)
# ============================================================
TMP="$(mktemp)"
sed -e 's/{{name}}/my-pyuv/g' \
    -e 's/{{language}}/python/g' \
    -e 's/{{runtime_version}}/3.12/g' \
    -e 's/{{package_manager}}/uv/g' \
    -e 's|{{code_dir}}|scripts/harness|g' \
    -e 's/{{phases_dir}}/phases/g' \
    -e 's|{{test_cmd}}|uv run pytest|g' \
    -e 's|{{lint_cmd}}|uv run ruff check|g' \
    -e 's|{{format_cmd}}|uv run ruff format --check|g' \
    -e 's|{{type_check_cmd}}|uv run mypy src|g' \
    -e 's/{{build_cmd}}//g' \
    -e 's/{{locale}}/ko/g' \
    -e 's/{{bootstrap_version}}/1.10b/g' \
    "$TMPL" > "$TMP"
grep -q '^# my-pyuv$' "$TMP" || { echo "FAIL S4 name substitution"; exit 1; }
grep -q 'python 3.12 (uv)' "$TMP" || { echo "FAIL S4 stack substitution"; exit 1; }
grep -q 'License: see LICENSE' "$TMP" || { echo "FAIL S4 license placeholder (v1.10c 이연)"; exit 1; }
grep -q 'Install deps: <see project README' "$TMP" || { echo "FAIL S4 install_cmd placeholder (v1.10c 이연)"; exit 1; }
grep -q 'Bootstrap version: v1.10b' "$TMP" || { echo "FAIL S4 bootstrap_version stamp"; exit 1; }
# {{ 잔존 0 (description은 placeholder 주석이라 sed 대상 외)
! grep -q '{{' "$TMP" || { echo "FAIL S4 unsubstituted vars remain:"; grep '{{' "$TMP"; exit 1; }
echo "[Stage 4] sed 13-var + bootstrap_version stamp + license/install_cmd placeholder 잔존 PASS — {{ 잔존 0"

# ============================================================
# Stage 5: 절대경로 0 + Do/Don't 페어링 5 + Boundaries 3 .harness/backups/ (W17)
# ============================================================
! grep -E '/c/Users|C:\\\\|qkreh' "$TMPL" || { echo "FAIL S5 absolute path detected"; exit 1; }
dont_count=$(grep -c "^- Don't" "$TMPL" || echo 0)
[ "$dont_count" -ge 5 ] || { echo "FAIL S5 Do/Don't pairing < 5: $dont_count"; exit 1; }
grep -q '.harness/backups/' "$TMPL" || { echo "FAIL S5 Boundaries 3 .harness/backups/ (W17)"; exit 1; }
echo "[Stage 5] absolute path 0 + Do/Don't $dont_count + Boundaries 3 backups PASS"

# ============================================================
# Stage 6: CLAUDE.override.md.tmpl Q13 marker + header + 흡수 § (W7+N9)
# ============================================================
OVERRIDE="$META_ROOT/bootstrap/skeletons/CLAUDE.override.md.tmpl"
[ -f "$OVERRIDE" ] || { echo "FAIL S6 override.tmpl missing"; exit 1; }
grep -q '{{q13_claude_specific}}' "$OVERRIDE" || { echo "FAIL S6 q13 marker"; exit 1; }
grep -q '^# .* — Claude Code Override$' "$OVERRIDE" || { echo "FAIL S6 header"; exit 1; }
grep -q '## Claude-specific context' "$OVERRIDE" || { echo "FAIL S6 Q13 absorb section"; exit 1; }
echo "[Stage 6] CLAUDE.override.md.tmpl marker + header + Q13 § PASS"

# ============================================================
# Cleanup
# ============================================================
rm -f "$TMP"

echo
echo "PASS — bootstrap agents-md smoke (6 stages, v1.10b strict)"
exit 0

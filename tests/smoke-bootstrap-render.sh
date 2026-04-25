#!/usr/bin/env bash
# smoke-bootstrap-render.sh — v1.10 Bootstrap 흐름 검증 (S1 detect → S3 render → S4 round-trip + escape rejection)
# 기존 fixture (tests/fixtures/detect-python-uv) 재사용.
# 7-stage / 4 검증 포인트.

set -euo pipefail
META_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIXTURE="$META_ROOT/tests/fixtures/detect-python-uv"

echo "[smoke] META_ROOT=$META_ROOT"
echo "[smoke] FIXTURE=$FIXTURE"

# ============================================================
# Stage 1: detect — fixture에서 lang/pm 정확 감지
# ============================================================
DETECT_OUT="$(bash "$META_ROOT/bootstrap/detect-project.sh" "$FIXTURE")"
echo "$DETECT_OUT" | grep -q 'language = "python"'    || { echo "FAIL Stage1 detect lang"; exit 1; }
echo "$DETECT_OUT" | grep -q 'package_manager = "uv"' || { echo "FAIL Stage1 detect pm";   exit 1; }
echo "[Stage 1] detect PASS — language=python, package_manager=uv"

# ============================================================
# Stage 2: env mock — 사용자 인터뷰 시뮬
# ============================================================
export HM_NAME="my-pyuv"
export HM_LANGUAGE="python"
export HM_PACKAGE_MANAGER="uv"
export HM_RUNTIME_VERSION="3.12"
export HM_CODE_DIR="scripts/harness"
export HM_PHASES_DIR="phases"
export HM_META_REF="projects/my-pyuv/ARCHITECTURE.md"
export HM_GUARDRAILS="docs/GUARDRAILS.md"
export HM_LOCALE="ko"
export HM_TEST_CMD="uv run pytest"
export HM_LINT_CMD="uv run ruff check"
export HM_FORMAT_CMD="uv run ruff format --check"
export HM_TYPE_CHECK_CMD="uv run mypy src"
echo "[Stage 2] env mock set"

# ============================================================
# Stage 3: render → 임시 파일
# ============================================================
TOML_FILE="$(mktemp)"
bash "$META_ROOT/bootstrap/render-manifest.sh" > "$TOML_FILE"
echo "[Stage 3] rendered to $TOML_FILE"

# ============================================================
# Stage 4: assertions on rendered TOML — 7개 라인 grep
# ============================================================
grep -q '^schema_version = "1.1"$'                              "$TOML_FILE" || { echo "FAIL Stage4 schema";        exit 1; }
grep -q '^name = "my-pyuv"$'                                    "$TOML_FILE" || { echo "FAIL Stage4 name";          exit 1; }
grep -q '^locale = "ko"$'                                       "$TOML_FILE" || { echo "FAIL Stage4 locale";        exit 1; }
grep -q '^mcp_server = "harness"$'                              "$TOML_FILE" || { echo "FAIL Stage4 mcp_server";    exit 1; }
grep -q '^primary = "claude-code"$'                             "$TOML_FILE" || { echo "FAIL Stage4 agent";         exit 1; }
grep -q '^meta_ref = "projects/my-pyuv/ARCHITECTURE.md"$'       "$TOML_FILE" || { echo "FAIL Stage4 meta_ref";      exit 1; }
grep -q '^type_check_cmd = "uv run mypy src"$'                  "$TOML_FILE" || { echo "FAIL Stage4 type_check";    exit 1; }
echo "[Stage 4] 7-line assertions PASS"

# ============================================================
# Stage 5: round-trip — name + code_dir + phases_dir 3 필드 (W22)
# session-init.sh / statusline.sh 호환 보장
# ============================================================
parsed_name="$(grep -E '^name[[:space:]]*=[[:space:]]*"' "$TOML_FILE" | head -1 \
    | sed -E 's/^name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')"
[ "$parsed_name" = "my-pyuv" ] || { echo "FAIL Stage5 round-trip name=$parsed_name"; exit 1; }

parsed_code_dir="$(grep -E '^code_dir[[:space:]]*=[[:space:]]*"' "$TOML_FILE" | head -1 \
    | sed -E 's/^code_dir[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')"
[ "$parsed_code_dir" = "scripts/harness" ] || { echo "FAIL Stage5 round-trip code_dir=$parsed_code_dir"; exit 1; }

parsed_phases_dir="$(grep -E '^phases_dir[[:space:]]*=[[:space:]]*"' "$TOML_FILE" | head -1 \
    | sed -E 's/^phases_dir[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')"
[ "$parsed_phases_dir" = "phases" ] || { echo "FAIL Stage5 round-trip phases_dir=$parsed_phases_dir"; exit 1; }
echo "[Stage 5] round-trip 3 fields PASS (name/code_dir/phases_dir)"

# ============================================================
# Stage 6: double-quote rejection — exit 2 (W2/G17/G21)
# ============================================================
set +e
HM_NAME='bad"name' HM_LANGUAGE=python HM_PACKAGE_MANAGER=uv \
HM_RUNTIME_VERSION=3.12 HM_CODE_DIR=scripts/harness HM_PHASES_DIR=phases \
HM_META_REF=projects/x/ARCHITECTURE.md \
bash "$META_ROOT/bootstrap/render-manifest.sh" >/dev/null 2>&1
rc=$?
set -e
[ $rc -eq 2 ] || { echo "FAIL Stage6 double-quote rejection: rc=$rc (expected 2)"; exit 1; }
echo "[Stage 6] double-quote rejection PASS (exit 2)"

# ============================================================
# Stage 7: single-quote rejection — exit 2 (W2 — bash -c 명령 주입 차단)
# ============================================================
set +e
HM_NAME="bad'name" HM_LANGUAGE=python HM_PACKAGE_MANAGER=uv \
HM_RUNTIME_VERSION=3.12 HM_CODE_DIR=scripts/harness HM_PHASES_DIR=phases \
HM_META_REF=projects/x/ARCHITECTURE.md \
bash "$META_ROOT/bootstrap/render-manifest.sh" >/dev/null 2>&1
rc=$?
set -e
[ $rc -eq 2 ] || { echo "FAIL Stage7 single-quote rejection: rc=$rc (expected 2)"; exit 1; }
echo "[Stage 7] single-quote rejection PASS (exit 2)"

# ============================================================
# Cleanup
# ============================================================
rm -f "$TOML_FILE"

echo
echo "PASS — bootstrap render smoke (7 stages)"
exit 0

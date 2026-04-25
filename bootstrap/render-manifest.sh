#!/usr/bin/env bash
# Render .harness.toml v1.1 from environment variables.
# Stdout: TOML text. Caller redirects to <project>/.harness.toml.
#
# Exit codes:
#   0 — success
#   1 — missing required env (bash :? failure)
#   2 — unsafe TOML char in input
#   3 — bash version < 4 (indirect expansion 미지원, macOS 시스템 bash 3.2)
#
# Required env: HM_NAME, HM_LANGUAGE, HM_PACKAGE_MANAGER, HM_RUNTIME_VERSION,
#               HM_CODE_DIR, HM_PHASES_DIR, HM_META_REF
# Optional env: HM_GUARDRAILS, HM_LOCALE (default "en"),
#               HM_TEST_CMD, HM_LINT_CMD, HM_FORMAT_CMD, HM_TYPE_CHECK_CMD,
#               HM_BUILD_TOOL, HM_BUILD_CMD, HM_ARTIFACT_DIR
#
# Note (v1.10): executor / statusline_cmd / statusline_timeout_ms / state_file /
#               harness_test_cmd / notifications / agents.secondary 는 emit 안 함.
#               해당 필드는 v1.11+ language overlay 또는 사용자 후속 편집.

set -euo pipefail

# 0. Bash 4+ required (indirect expansion ${!v} 사용)
[ "${BASH_VERSINFO[0]:-0}" -ge 4 ] || {
    echo "ERR: bash 4+ required. macOS 사용자: brew install bash 후 /opt/homebrew/bin/bash 명시 호출" >&2
    exit 3
}

# 1. Required validation
: "${HM_NAME:?required}" "${HM_LANGUAGE:?required}" "${HM_PACKAGE_MANAGER:?required}"
: "${HM_RUNTIME_VERSION:?required}" "${HM_CODE_DIR:?required}" "${HM_PHASES_DIR:?required}"
: "${HM_META_REF:?required}"

# 2. TOML escaping validation — refuse unsafe chars (5종)
check_safe() {
    local var_name="$1" val="$2"
    case "$val" in
        *\"*|*\'*|*$'\n'*|*\$*|*\\*)
            echo "ERR: $var_name contains unsafe chars (\", ', newline, \$, backslash): $val" >&2
            exit 2
            ;;
    esac
}
for v in HM_NAME HM_LANGUAGE HM_PACKAGE_MANAGER HM_RUNTIME_VERSION HM_CODE_DIR \
         HM_PHASES_DIR HM_META_REF HM_GUARDRAILS HM_LOCALE \
         HM_TEST_CMD HM_LINT_CMD HM_FORMAT_CMD HM_TYPE_CHECK_CMD \
         HM_BUILD_TOOL HM_BUILD_CMD HM_ARTIFACT_DIR; do
    check_safe "$v" "${!v:-}"
done

# 3. Render — schema §10 예시 순서 일치
cat <<EOF
schema_version = "1.1"

[project]
name = "$HM_NAME"
language = "$HM_LANGUAGE"
package_manager = "$HM_PACKAGE_MANAGER"
runtime_version = "$HM_RUNTIME_VERSION"
locale = "${HM_LOCALE:-en}"

[harness]
code_dir = "$HM_CODE_DIR"
phases_dir = "$HM_PHASES_DIR"
EOF
[ -n "${HM_GUARDRAILS:-}" ] && echo "guardrails = \"$HM_GUARDRAILS\""
echo "mcp_server = \"harness\""

cat <<EOF

[agents]
primary = "claude-code"

[architecture]
meta_ref = "$HM_META_REF"
EOF

if [ -n "${HM_BUILD_TOOL:-}" ]; then
    cat <<EOF

[build]
tool = "$HM_BUILD_TOOL"
build_cmd = "$HM_BUILD_CMD"
artifact_dir = "$HM_ARTIFACT_DIR"
EOF
fi

if [ -n "${HM_TEST_CMD:-}${HM_LINT_CMD:-}${HM_FORMAT_CMD:-}${HM_TYPE_CHECK_CMD:-}" ]; then
    echo ""
    echo "[testing]"
    [ -n "${HM_TEST_CMD:-}" ]       && echo "test_cmd = \"$HM_TEST_CMD\""
    [ -n "${HM_TYPE_CHECK_CMD:-}" ] && echo "type_check_cmd = \"$HM_TYPE_CHECK_CMD\""
    [ -n "${HM_LINT_CMD:-}" ]       && echo "lint_cmd = \"$HM_LINT_CMD\""
    [ -n "${HM_FORMAT_CMD:-}" ]     && echo "format_cmd = \"$HM_FORMAT_CMD\""
fi

exit 0

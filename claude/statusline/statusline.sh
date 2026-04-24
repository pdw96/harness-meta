#!/usr/bin/env bash
# Harness global statusline — bash-only. Python 의존 없음.
#
# Design (v1.6+):
#   - Project declares `[harness].statusline_cmd` in .harness.toml
#     to provide rich statusline. Global layer just executes it.
#   - No statusline_cmd -> minimal fallback [harness] {project_name}
#   - No manifest -> silent no-op
#
# Contract (v1.7 formalized):
#   - statusline_cmd: full shell command string, executed with CWD = $PROJECT_DIR
#   - stdout -> statusline text (entire output, not just first line)
#   - stderr ignored
#   - timeout 3s; on exceed -> fallback
#
# Registration: ~/.claude/settings.json statusLine.command

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"

# 1. No manifest -> silent no-op
if [ ! -f "$MANIFEST" ]; then
    exit 0
fi

# 2. Minimal TOML extraction
_extract() {
    local key="$1"
    grep -E "^${key}[[:space:]]*=[[:space:]]*\"" "$MANIFEST" 2>/dev/null \
        | head -1 \
        | sed -E "s/^${key}[[:space:]]*=[[:space:]]*\"([^\"]+)\".*/\\1/"
}

project_name=$(_extract 'name')
statusline_cmd=$(_extract 'statusline_cmd')

# 3. Execute statusline_cmd if declared
if [ -n "$statusline_cmd" ]; then
    # Array parsing — mitigates trivial shell injection compared to eval.
    # Note: complex quoting inside statusline_cmd is not supported; project
    # should keep it as simple command-with-args form.
    read -ra cmd_tokens <<< "$statusline_cmd"
    if command -v timeout >/dev/null 2>&1; then
        output=$(cd "$PROJECT_DIR" && timeout 3s "${cmd_tokens[@]}" 2>/dev/null)
    else
        # Fallback: no GNU timeout available (rare — Git Bash / coreutils include it)
        output=$(cd "$PROJECT_DIR" && "${cmd_tokens[@]}" 2>/dev/null)
    fi
    if [ -n "$output" ]; then
        printf '%s' "$output"
        exit 0
    fi
    # statusline_cmd failed or produced empty output -> fall through to minimal
fi

# 4. Minimal fallback
printf '[harness] %s' "${project_name:-?}"
exit 0

#!/usr/bin/env bash
# SessionStart hook — bash-only. Python 의존 없음.
#
# Design (v1.6+):
#   - Global layer의 책임 최소화. 깊은 TOML/JSON 파싱은 하지 않는다.
#   - Project가 rich context를 원하면 `[harness].state_file` 경로에
#     preformatted text를 써두면 그대로 주입됨.
#
# Output: {"hookSpecificOutput": {"hookEventName": "SessionStart", "additionalContext": "..."}}
# Registration: ~/.claude/settings.json hooks.SessionStart[].command
#
# All branches exit 0 with valid JSON to avoid Claude Code SessionStart UI
# error (see anthropics/claude-code issues #12671, #19346, #21643).

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"

# 1. No manifest -> no-op (harness-inactive project)
if [ ! -f "$MANIFEST" ]; then
    printf '{}'
    exit 0
fi

# 2. Minimal TOML extraction via grep + sed (flat keys only)
_extract() {
    local key="$1"
    grep -E "^${key}[[:space:]]*=[[:space:]]*\"" "$MANIFEST" 2>/dev/null \
        | head -1 \
        | sed -E "s/^${key}[[:space:]]*=[[:space:]]*\"([^\"]+)\".*/\\1/"
}

project_name=$(_extract 'name')
phases_dir=$(_extract 'phases_dir')
state_file=$(_extract 'state_file')

phases_dir="${phases_dir:-phases}"
project_name="${project_name:-?}"

# 3. Build context text (English — AGENTS.md locale policy §8)
context=""

if [ -n "$state_file" ] && [ -f "$PROJECT_DIR/$state_file" ]; then
    # Project-provided state file — use as-is
    context=$(cat "$PROJECT_DIR/$state_file" 2>/dev/null)
elif [ -d "$PROJECT_DIR/$phases_dir" ]; then
    context=$(printf '## Harness (project: %s)\n- phases directory exists at `%s/`\n- For detailed state, configure `[harness].state_file` in .harness.toml' \
        "$project_name" "$phases_dir")
else
    context=$(printf '## Harness (project: %s)\n- `%s/` not initialized — run `/harness-plan` or project bootstrap' \
        "$project_name" "$phases_dir")
fi

# 4. Empty context -> {} (defensive)
if [ -z "$context" ]; then
    printf '{}'
    exit 0
fi

# 5. JSON escape (backslash, double quote, newline, tab, carriage return)
#    Limitation: control chars beyond \t\r\n are passed through as-is.
#    For complex content, project should emit already-escaped text via state_file.
escaped=$(printf '%s' "$context" \
    | sed -e 's/\\/\\\\/g' \
          -e 's/"/\\"/g' \
          -e 's/\t/\\t/g' \
          -e 's/\r/\\r/g' \
    | awk 'BEGIN{ORS=""} NR>1{print "\\n"} {print}')

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}' "$escaped"
exit 0

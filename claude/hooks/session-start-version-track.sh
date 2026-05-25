#!/usr/bin/env bash
# SessionStart hook — Claude Code 버전 추적 (T1.6 단계 a, v7.0).
#
# Design (정정 #4, 2026-05-25):
#   - hook 책임 = `claude --version` stdout 주입만 (출력 전용).
#     SessionStart hook 은 system reminder 파싱 불가 → log file 기록 안 함.
#   - log 기록 = Claude / version-tracker subagent 단독 (단일 writer →
#     경합 + churn 제거). hook 은 검출 데이터만 context 로 흘려보냄.
#   - scope = harness-meta repo 만. gate marker = log file 존재
#     (projects/meta/claude-code-version-log.md). harness-meta 엔
#     .harness.toml 부재하여 session-init.sh 와는 다른 gate 사용.
#
# Output: {"hookSpecificOutput": {"hookEventName": "SessionStart", "additionalContext": "..."}}
# Registration: claude/hooks/hooks.json SessionStart[].hooks[]
#
# All branches exit 0 with valid JSON to avoid Claude Code SessionStart UI
# error (anthropics/claude-code issues #12671, #19346, #21643).

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
LOG_FILE="$PROJECT_DIR/projects/meta/claude-code-version-log.md"

# 1. log file 부재 -> no-op (harness-meta repo 아님)
if [ ! -f "$LOG_FILE" ]; then
    printf '{}'
    exit 0
fi

# 2. claude --version 검출 (PATH 부재 시 graceful no-op)
version=$(claude --version 2>/dev/null | head -1)
if [ -z "$version" ]; then
    printf '{}'
    exit 0
fi

# 3. Build context text (English — AGENTS.md locale policy §8)
context=$(printf '## Claude Code version (T1.6 version-track)\n- detected: %s\n- Compare against `projects/meta/claude-code-version-log.md` ## Current state. If it changed, update the log (## Current state overwrite + ## History append). You / the version-tracker subagent are the single writer — this hook only injects the detected version.' "$version")

# 4. JSON escape (session-init.sh 동일 패턴)
#    Step 1: strip control chars illegal raw in JSON strings.
#    Step 2: escape backslash, double-quote, tab, CR; awk joins lines with \n.
escaped=$(printf '%s' "$context" \
    | LC_ALL=C tr -d '\000-\010\013\014\016-\037\177' \
    | sed -e 's/\\/\\\\/g' \
          -e 's/"/\\"/g' \
          -e 's/\t/\\t/g' \
          -e 's/\r/\\r/g' \
    | awk 'BEGIN{ORS=""} NR>1{print "\\n"} {print}')

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}' "$escaped"
exit 0

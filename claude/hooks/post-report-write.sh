#!/usr/bin/env bash
# PostToolUse hook: sessions/**/REPORT.md Write/Edit 감지 → harness-roadmap-update invoke 안내
# v1.36b — python3 (1순위) + grep+sed fallback (2순위). exit 0 only (non-zero = session noise).
# Timeout: 10s (settings.json registration). tool_response.success 가드 포함.

NOOP='{}'
INPUT=$(cat) || { printf '%s\n' "$NOOP"; exit 0; }

TOOL_NAME=''
FILE_PATH=''
SUCCESS='false'

# ── 1순위: python3 파싱 ─────────────────────────────────────────────────────
if command -v python3 >/dev/null 2>&1; then
    _result=$(printf '%s' "$INPUT" | python3 -c '
import sys, json
try:
    d = json.loads(sys.stdin.read())
    t = d.get("tool_name", "")
    f = d.get("tool_input", {}).get("file_path", "")
    s = d.get("tool_response", {}).get("success", False)
    f = f.replace("\\", "/")
    print(t)
    print(f)
    print("true" if s is True else "false")
except Exception:
    print("")
    print("")
    print("false")
' 2>/dev/null) || _result=''
    if [ -n "$_result" ]; then
        TOOL_NAME=$(printf '%s' "$_result" | sed -n '1p')
        FILE_PATH=$(printf '%s' "$_result" | sed -n '2p')
        SUCCESS=$(printf '%s' "$_result" | sed -n '3p')
    fi
fi

# ── 2순위: grep+sed fallback ─────────────────────────────────────────────────
if [ -z "$TOOL_NAME" ]; then
    TOOL_NAME=$(printf '%s' "$INPUT" | grep -o '"tool_name":"[^"]*"' | head -1 | sed 's/^"tool_name":"//;s/"$//') || TOOL_NAME=''
    FILE_PATH=$(printf '%s' "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | sed 's/^"file_path":"//;s/"$//' | tr '\\' '/') || FILE_PATH=''
    _s=$(printf '%s' "$INPUT" | grep -oE '"success"\s*:\s*(true|false)' 2>/dev/null | head -1 | grep -oE '(true|false)' 2>/dev/null) || _s=''
    SUCCESS="${_s:-false}"
fi

# ── 가드: tool_response.success != true ──────────────────────────────────────
[ "$SUCCESS" = 'true' ] || { printf '%s\n' "$NOOP"; exit 0; }

# ── 매치: Write 또는 Edit (C3: Edit|Write matcher 정합) ──────────────────────
case "$TOOL_NAME" in
    Write|Edit) ;;
    *) printf '%s\n' "$NOOP"; exit 0 ;;
esac

# ── path 정규화 + REPORT.md 패턴 ─────────────────────────────────────────────
NORM_PATH=$(printf '%s' "$FILE_PATH" | tr '\\' '/')
printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/REPORT\.md$' \
    || { printf '%s\n' "$NOOP"; exit 0; }

# ── additionalContext 출력 (C2: without truncation, concise) ─────────────────
MSG="REPORT.md write detected. Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update — update ROADMAP.md with this session completed entry and Out of scope trigger rows."

printf '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"%s"}}\n' "$MSG"
exit 0

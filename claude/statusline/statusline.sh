#!/usr/bin/env bash
# Harness global statusline — bash-only. Python 의존 없음.
#
# Design (v1.6+ / v7.1 컨텍스트 게이지):
#   - Reads Claude Code statusline JSON from stdin and prefixes a context gauge
#     `[ctx N%]` from context_window.used_percentage (70/90 임계 마커 * / !).
#     Field absent / non-integer / stdin 부재 -> gauge omitted (no '0%' false-calm).
#   - Gate: .harness.toml OR harness-meta repo marker
#     (projects/meta/claude-code-version-log.md) — 사용자 본인 harness-meta 세션에도 게이지.
#   - Project declares `[harness].statusline_cmd` in .harness.toml for rich statusline.
#   - No statusline_cmd -> minimal fallback [harness] {project_name}
#   - Neither manifest nor marker -> silent no-op
#
# Contract (v1.7 formalized):
#   - statusline_cmd: full shell command string, executed with CWD = $PROJECT_DIR
#   - stdout -> statusline text (entire output, not just first line)
#   - stderr ignored
#   - timeout 3s; on exceed -> fallback
#
# Registration: ~/.claude/settings.json statusLine.command

# 0. Read Claude Code statusline JSON from stdin (once — stdin is single-consume).
#    Must precede the gate exit: the manifest/marker gate below may exit early, so
#    stdin has to be captured before any exit or the gauge is impossible.
input="$(cat)"

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"
# harness-meta repo marker — version-track hook (session-start-version-track.sh:20) 과 동일 파일.
MARKER="$PROJECT_DIR/projects/meta/claude-code-version-log.md"

# 1. Gate — neither manifest nor harness-meta marker -> silent no-op
if [ ! -f "$MANIFEST" ] && [ ! -f "$MARKER" ]; then
    exit 0
fi

# 2. Context gauge — extract context_window.used_percentage (bash-native, jq 비의존).
#    anchored-first-match: slice from the first "context_window" occurrence to EOF and
#    take the first used_percentage integer inside it. The current_usage object holds no
#    used_percentage (token counts only), so the first used_percentage after
#    "context_window" is reliably context_window's own — independent of JSON key order
#    (rate_limits.*.used_percentage either precedes the slice point or follows the
#    context_window value). Field absent / non-integer -> empty gauge (no '0%' false-calm).
_context_gauge() {
    local json="$1"
    local cw="${json#*\"context_window\"}"
    [ "$cw" = "$json" ] && return  # "context_window" 부재 -> 게이지 생략

    local pct
    pct=$(printf '%s' "$cw" \
        | grep -oE '"used_percentage"[[:space:]]*:[[:space:]]*[0-9]+' \
        | head -1 \
        | grep -oE '[0-9]+')
    [ -z "$pct" ] && return  # 값 부재 / 비정수 -> 게이지 생략

    # 70/90 임계 마커 (statusline.md 예제 패턴, ANSI 대신 텍스트 — statusline 단순성).
    local mark=""
    if [ "$pct" -ge 90 ]; then
        mark="!"
    elif [ "$pct" -ge 70 ]; then
        mark="*"
    fi
    printf '[ctx %s%%%s]' "$pct" "$mark"
}

gauge=$(_context_gauge "$input")

# 게이지를 본문 앞에 prefix 결합 (게이지 부재 시 본문 그대로 = 회귀 0).
_join() {
    if [ -n "$1" ] && [ -n "$2" ]; then
        printf '%s %s' "$1" "$2"
    else
        printf '%s%s' "$1" "$2"
    fi
}

# 3. No manifest (marker-only, e.g. harness-meta session) -> gauge alone
if [ ! -f "$MANIFEST" ]; then
    printf '%s' "$gauge"
    exit 0
fi

# 4. Minimal TOML extraction
_extract() {
    local key="$1"
    grep -E "^${key}[[:space:]]*=[[:space:]]*\"" "$MANIFEST" 2>/dev/null \
        | head -1 \
        | sed -E "s/^${key}[[:space:]]*=[[:space:]]*\"([^\"]+)\".*/\\1/"
}

project_name=$(_extract 'name')
statusline_cmd=$(_extract 'statusline_cmd')

# 5. Execute statusline_cmd if declared
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
        _join "$gauge" "$output"
        exit 0
    fi
    # statusline_cmd failed or produced empty output -> fall through to minimal
fi

# 6. Minimal fallback
_join "$gauge" "[harness] ${project_name:-?}"
exit 0

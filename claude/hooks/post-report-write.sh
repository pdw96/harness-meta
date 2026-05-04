#!/usr/bin/env bash
# PostToolUse hook: sessions/**/REPORT.md Write/Edit 감지 → harness-roadmap-update invoke 안내
# v1.36b — python3 (1순위) + grep+sed fallback (2순위). exit 0 only (non-zero = session noise).
# v1.41  — MultiEdit: edits[*].new_string '## ' 마커 검사. 마커 없으면 NOOP (false positive 필터).
# v1.42  — section name extraction: 감지된 '## SectionName'을 additionalContext 메시지에 포함.
# v1.54  — python3 미설치 + 양쪽 파서 실패(TOOL_NAME 빈값) 시 stderr WARN 추가.
# v1.57  — NotebookEdit: notebook_path 추출 + REPORT.(md|ipynb) 패턴 확장.
# v1.58  — REPORT_BASENAME: 동적 파일명 (REPORT.md|REPORT.ipynb) MSG에 반영.
# v1.59  — PLAN.md 감지 추가: FILE_TYPE 분기(REPORT|PLAN) + harness-plan-verify 라우팅.
# Timeout: 10s (settings.json registration). tool_response.success 가드 포함.

NOOP='{}'
INPUT=$(cat) || { printf '%s\n' "$NOOP"; exit 0; }

TOOL_NAME=''
FILE_PATH=''
SUCCESS='false'
HAS_MARKERS='true'   # 보수적 초기값: python3/fallback 실패 시 trigger 유지
SECTIONS=''          # v1.42: 감지된 섹션명 (python3 전용)

# ── 1순위: python3 파싱 ─────────────────────────────────────────────────────
if ! command -v python3 >/dev/null 2>&1; then
    printf '[post-report-write] WARN: python3 not found, using grep fallback only\n' >&2
fi
if command -v python3 >/dev/null 2>&1; then
    _result=$(printf '%s' "$INPUT" | python3 -c '
import sys, json, re
try:
    d = json.loads(sys.stdin.read())
    t = d.get("tool_name", "")
    # v1.57: NotebookEdit은 notebook_path, 그 외는 file_path
    if t == "NotebookEdit":
        f = d.get("tool_input", {}).get("notebook_path", "")
    else:
        f = d.get("tool_input", {}).get("file_path", "")
    s = d.get("tool_response", {}).get("success", False)
    f = f.replace("\\", "/")
    # MultiEdit edits content check (v1.41)
    edits = d.get("tool_input", {}).get("edits", [])
    has_edits = len(edits) > 0
    has_markers = not has_edits  # conservative: no edits array -> do not filter
    if has_edits:
        combined = " ".join(e.get("new_string", "") for e in edits)
        has_markers = "## " in combined
    # v1.57: NotebookEdit은 edits 없음 — 보수적 True 강제 (has_edits 블록 이후 오버라이드)
    if t == "NotebookEdit":
        has_markers = True
    # v1.42: section name extraction
    secs = []
    if t == "Write":
        content = d.get("tool_input", {}).get("content", "")
        secs = re.findall(r"^## (.+)", content, re.MULTILINE)
    elif t == "Edit":
        secs = re.findall(r"^## (.+)", d.get("tool_input", {}).get("new_string", ""), re.MULTILINE)
    elif t == "MultiEdit":
        for e in edits:
            secs += re.findall(r"^## (.+)", e.get("new_string", ""), re.MULTILINE)
    elif t == "NotebookEdit":
        pass  # v1.57: notebook cell 섹션 추출 미구현 (Out of scope)
    secs = ["".join(c for c in s.strip()[:40] if c != chr(34) and c != chr(92) and ord(c) >= 32) for s in secs[:5]]
    secs_str = ", ".join("## " + s for s in secs if s)
    print(t)
    print(f)
    print("true" if s is True else "false")
    print("true" if has_markers else "false")
    print(secs_str)
except Exception:
    print("")
    print("")
    print("false")
    print("true")
    print("")
' 2>/dev/null) || _result=''
    if [ -n "$_result" ]; then
        TOOL_NAME=$(printf '%s' "$_result" | sed -n '1p')
        FILE_PATH=$(printf '%s' "$_result" | sed -n '2p')
        SUCCESS=$(printf '%s' "$_result" | sed -n '3p')
        _hm=$(printf '%s' "$_result" | sed -n '4p')
        [ -n "$_hm" ] && HAS_MARKERS="$_hm"
        SECTIONS=$(printf '%s' "$_result" | sed -n '5p')
    fi
fi

# ── 2순위: grep+sed fallback ─────────────────────────────────────────────────
if [ -z "$TOOL_NAME" ]; then
    TOOL_NAME=$(printf '%s' "$INPUT" | grep -o '"tool_name":"[^"]*"' | head -1 | sed 's/^"tool_name":"//;s/"$//') || TOOL_NAME=''
    FILE_PATH=$(printf '%s' "$INPUT" | grep -o '"file_path":"[^"]*"' | head -1 | sed 's/^"file_path":"//;s/"$//' | tr '\\' '/') || FILE_PATH=''
    # v1.57: NotebookEdit fallback — file_path 빈값일 때 notebook_path 추출
    if [ -z "$FILE_PATH" ] && [ "$TOOL_NAME" = 'NotebookEdit' ]; then
        FILE_PATH=$(printf '%s' "$INPUT" | grep -o '"notebook_path":"[^"]*"' | head -1 \
                    | sed 's/^"notebook_path":"//;s/"$//' | tr '\\' '/') || FILE_PATH=''
    fi
    _s=$(printf '%s' "$INPUT" | grep -oE '"success"\s*:\s*(true|false)' 2>/dev/null | head -1 | grep -oE '(true|false)' 2>/dev/null) || _s=''
    SUCCESS="${_s:-false}"
    SECTIONS=''   # section 추출은 python3 전용 — grep fallback은 best-effort 불가
    # MultiEdit edits content check — fallback (v1.41)
    if printf '%s' "$INPUT" | grep -q '"edits"'; then
        _m=$(printf '%s' "$INPUT" | grep -oE '"new_string":"[^"]*"' \
             | grep -c '## ' 2>/dev/null) || _m=0
        if [ "$_m" -gt 0 ]; then HAS_MARKERS='true'; else HAS_MARKERS='false'; fi
    fi
    # v1.57: NotebookEdit fallback — has_markers 보수적 True 강제
    if [ "$TOOL_NAME" = 'NotebookEdit' ]; then
        HAS_MARKERS='true'
    fi
    # edits key 없으면 HAS_MARKERS=true 초기값 유지 (보수적)
fi

# ── 양쪽 파서 실패 감지 (v1.54 debug log) ────────────────────────────────────
if [ -z "$TOOL_NAME" ]; then
    printf '[post-report-write] WARN: both python3 and grep parsers failed to extract tool_name\n' >&2
    printf '%s\n' "$NOOP"
    exit 0
fi

# ── 가드: tool_response.success != true ──────────────────────────────────────
[ "$SUCCESS" = 'true' ] || { printf '%s\n' "$NOOP"; exit 0; }

# ── 매치: Write / Edit / MultiEdit / NotebookEdit (v1.57: NotebookEdit 추가) ─
case "$TOOL_NAME" in
    Write|Edit|MultiEdit|NotebookEdit) ;;
    *) printf '%s\n' "$NOOP"; exit 0 ;;
esac

# ── path 정규화 + REPORT.(md|ipynb)|PLAN.md 패턴 (v1.59: PLAN.md 확장) ────────
NORM_PATH=$(printf '%s' "$FILE_PATH" | tr '\\' '/')
FILE_TYPE=''
if printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/REPORT\.(md|ipynb)$'; then
    FILE_TYPE='REPORT'
elif printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/PLAN\.md$'; then
    FILE_TYPE='PLAN'
else
    printf '%s\n' "$NOOP"; exit 0
fi

# ── 동적 파일명 추출 (v1.58; REPORT_BASENAME → FILE_BASENAME, v1.59) ────────────
FILE_BASENAME=$(basename "$NORM_PATH")

# ── MultiEdit 콘텐츠 가드 (v1.41) ────────────────────────────────────────────
if [ "$TOOL_NAME" = 'MultiEdit' ] && [ "$HAS_MARKERS" = 'false' ]; then
    printf '%s\n' "$NOOP"
    exit 0
fi

# ── additionalContext 출력 (C2: without truncation, concise) ─────────────────
# v1.42: sections 있을 때 섹션명 포함, 없을 때 기존 형식 (graceful degradation)
# v1.59: FILE_TYPE 분기 — PLAN → harness-plan-verify, REPORT → harness-roadmap-update
if [ "$FILE_TYPE" = 'PLAN' ]; then
    MSG="PLAN.md write detected. Please invoke harness-plan-verify SKILL now: /harness-plan-verify — verify spec (context7) before proceeding."
elif [ -n "$SECTIONS" ]; then
    MSG="${FILE_BASENAME} write detected (sections: ${SECTIONS}). Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update"
else
    MSG="${FILE_BASENAME} write detected. Please invoke harness-roadmap-update SKILL now: /harness-roadmap-update — update ROADMAP.md with this session completed entry and Out of scope trigger rows."
fi

printf '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"%s"}}\n' "$MSG"
exit 0

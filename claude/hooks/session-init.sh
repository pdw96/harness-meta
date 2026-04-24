#!/usr/bin/env bash
# SessionStart hook — 하네스 활성 프로젝트의 현재 상태 + ROADMAP을 additionalContext로 주입.
#
# 동작 원칙:
#   1. $CLAUDE_PROJECT_DIR/.harness.toml 없으면 조용히 종료 (빈 output, 무관 프로젝트 무간섭)
#   2. 매니페스트 있으면 phases/index.json + milestone.json + ROADMAP.md 읽어 context 구성
#   3. 파싱 오류는 세션을 차단하지 않음 (exit 0 + 경고 문자열만)
#
# 출력: {"hookSpecificOutput": {"hookEventName": "SessionStart", "additionalContext": "..."}}
# 등록: ~/.claude/settings.json의 hooks.SessionStart[].command = "$HOME/.claude/hooks/session-init.sh"

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"

# 1. 매니페스트 부재 → no-op (하네스 비활성 프로젝트)
if [ ! -f "$MANIFEST" ]; then
    printf '{}'
    exit 0
fi

python3 - <<'PY'
import json
import os
import re
from pathlib import Path

root = Path(os.environ.get("CLAUDE_PROJECT_DIR", "."))
manifest = root / ".harness.toml"

# 2. 매니페스트 파싱 (간단 grep 방식. 깊은 파싱 필요 시 tomllib)
def _extract(pattern: str) -> str:
    try:
        for line in manifest.read_text(encoding="utf-8").splitlines():
            m = re.match(pattern, line.strip())
            if m:
                return m.group(1)
    except Exception:
        pass
    return ""

project_name = _extract(r'^name\s*=\s*"([^"]+)"')
code_dir = _extract(r'^code_dir\s*=\s*"([^"]+)"') or "scripts/harness"
phases_dir = _extract(r'^phases_dir\s*=\s*"([^"]+)"') or "phases"

phases_idx = root / phases_dir / "index.json"
roadmap = root / phases_dir / "ROADMAP.md"

lines = []

# 3. 진행 중 milestone
if phases_idx.exists():
    try:
        data = json.loads(phases_idx.read_text(encoding="utf-8"))
        active = None
        for m in data.get("milestones", []):
            if m.get("status") != "completed":
                active = m
                break
        if active:
            version = active["version"]
            lines.append(f"## Harness 현재 상태 (project: {project_name or '?'})")
            lines.append(f"- 진행 중 milestone: **{version}** ({active.get('name', '')}) — status: {active.get('status', '?')}")
            # phase 수준 요약
            ms_file = root / phases_dir / version / "milestone.json"
            if ms_file.exists():
                ms = json.loads(ms_file.read_text(encoding="utf-8"))
                for p in ms.get("phases", []):
                    if p.get("status") != "completed":
                        pidx = root / phases_dir / version / p["dir"] / "index.json"
                        if pidx.exists():
                            pd = json.loads(pidx.read_text(encoding="utf-8"))
                            total = len(pd.get("steps", []))
                            done = sum(1 for s in pd["steps"] if s.get("status") == "completed")
                            lines.append(f"- 활성 phase: `{version}/{p['dir']}` — {done}/{total} steps")
                        else:
                            lines.append(f"- 활성 phase: `{version}/{p['dir']}` — 미시작")
                        break
        else:
            lines.append(f"## Harness (project: {project_name or '?'}): 전체 milestone 완료")
    except Exception as e:
        lines.append(f"(harness state read error: {e})")
else:
    lines.append(f"## Harness (project: {project_name or '?'})")
    lines.append(f"- `{phases_dir}/index.json` 미존재 — `/harness-plan`으로 초기화")

# 4. ROADMAP head
if roadmap.exists():
    try:
        text = roadmap.read_text(encoding="utf-8")
        head = "\n".join(text.splitlines()[:40])
        lines.append("")
        lines.append("## ROADMAP 요약")
        lines.append(head)
    except Exception:
        pass

ctx = "\n".join(lines).strip()
if not ctx:
    print("{}")
else:
    out = {
        "hookSpecificOutput": {
            "hookEventName": "SessionStart",
            "additionalContext": ctx,
        }
    }
    print(json.dumps(out, ensure_ascii=False))
PY

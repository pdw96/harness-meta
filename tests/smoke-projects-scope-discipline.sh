#!/usr/bin/env bash
# smoke-projects-scope-discipline.sh
#
# Purpose: root ROADMAP thin index 형식 + projects/<name>/ROADMAP scope discipline 검증.
#
# 배경: v1.1_meta-as-project (2026-05-08) — root ROADMAP.md 에 project milestone (e.g., v1.1_upbit-cross-ref-cleanup)
#   이 잘못 등재되는 misclassification 사례 발견. 본 smoke 가 재발 차단.
#
# 검증:
#   1. root ROADMAP.md = thin index — { projects: [{ name, roadmap_path }] } 만, milestones[] 키 부재
#   2. roadmap_path 가 path traversal-safe 한 single-segment 형식 (^projects/[a-z0-9_-]+/ROADMAP\.md$)
#   3. projects/<name>/ROADMAP.md milestones[] 배열 보유
#
# 활성: pre-commit hook (단독 active block, v1.1_smoke-precommit-rewrite 에서 통합 예정)
# Algo: V1 (python3 + json.load + dict-key assertions). python3 부재 시 SKIP exit 0.
# Defense-in-depth: file size guard (>100KB skip), single-segment glob, regex path validation.

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-projects-scope-discipline: SKIP (python3 not available)" >&2
    exit 0
fi

python3 - <<'PYEOF'
import json
import re
import sys
from pathlib import Path

REPO = Path.cwd()
ROOT_ROADMAP = REPO / "ROADMAP.md"
PROJECTS_DIR = REPO / "projects"
SIZE_LIMIT = 100_000  # 100KB defense-in-depth

errors: list[str] = []


def extract_json_block(md_path: Path) -> dict | None:
    """Markdown 첫 ```json 코드블록 추출."""
    if not md_path.exists():
        return None
    if md_path.stat().st_size > SIZE_LIMIT:
        errors.append(f"{md_path}: size > {SIZE_LIMIT} bytes (skip for safety)")
        return None
    text = md_path.read_text(encoding="utf-8")
    m = re.search(r"```json\s*\n(.*?)\n```", text, re.DOTALL)
    if not m:
        return None
    try:
        return json.loads(m.group(1))
    except json.JSONDecodeError as e:
        errors.append(f"{md_path}: JSON parse error — {e}")
        return None


# 1. root ROADMAP.md = thin index
root_data = extract_json_block(ROOT_ROADMAP)
if root_data is None:
    errors.append("ROADMAP.md (root): JSON 코드블록 없음 또는 파싱 실패")
else:
    if "milestones" in root_data:
        errors.append(
            "ROADMAP.md (root): 'milestones' 키 발견 — thin index에 milestone 등재 금지. "
            "milestone은 projects/<name>/ROADMAP.md 에만 등재 (v1.1_meta-as-project scope discipline)."
        )
    if "projects" not in root_data:
        errors.append("ROADMAP.md (root): 'projects' 키 부재 — thin index 형식 위배")
    elif not isinstance(root_data["projects"], list):
        errors.append("ROADMAP.md (root): 'projects' 값이 list 아님")
    else:
        path_pattern = re.compile(r"^projects/[a-z0-9_-]+/ROADMAP\.md$")
        for entry in root_data["projects"]:
            if not isinstance(entry, dict):
                errors.append(f"ROADMAP.md (root): projects[] entry not dict — {entry!r}")
                continue
            missing = [k for k in ("name", "roadmap_path") if k not in entry]
            if missing:
                errors.append(
                    f"ROADMAP.md (root): projects[] entry 필수 키 부재 {missing} — {entry!r}"
                )
                continue
            rp = entry["roadmap_path"]
            if not isinstance(rp, str):
                errors.append(f"ROADMAP.md (root): roadmap_path not str — {rp!r}")
                continue
            if not path_pattern.match(rp):
                errors.append(
                    f"ROADMAP.md (root): roadmap_path '{rp}' regex 위배 "
                    f"(허용: ^projects/[a-z0-9_-]+/ROADMAP\\.md$, single-segment + lowercase)"
                )
                continue
            target = REPO / rp
            if not target.exists():
                errors.append(f"ROADMAP.md (root): roadmap_path '{rp}' 실 파일 부재")

# 2. projects/<name>/ROADMAP.md milestones[] 보유
if PROJECTS_DIR.exists() and PROJECTS_DIR.is_dir():
    for project_dir in sorted(PROJECTS_DIR.iterdir()):
        if not project_dir.is_dir():
            continue
        project_roadmap = project_dir / "ROADMAP.md"
        if not project_roadmap.exists():
            continue  # ROADMAP 부재는 별도 정책 — 본 smoke 범위 외
        proj_data = extract_json_block(project_roadmap)
        if proj_data is None:
            errors.append(f"{project_roadmap.relative_to(REPO)}: JSON 코드블록 없음 또는 파싱 실패")
            continue
        if "milestones" not in proj_data:
            errors.append(
                f"{project_roadmap.relative_to(REPO)}: 'milestones' 배열 부재 — "
                "projects/<name>/ROADMAP.md 형식 위배"
            )
        elif not isinstance(proj_data["milestones"], list):
            errors.append(
                f"{project_roadmap.relative_to(REPO)}: 'milestones' 값이 list 아님"
            )

if errors:
    print("=== smoke-projects-scope-discipline FAIL ===", file=sys.stderr)
    for e in errors:
        print(f"  - {e}", file=sys.stderr)
    sys.exit(1)

print("smoke-projects-scope-discipline PASS")
sys.exit(0)
PYEOF

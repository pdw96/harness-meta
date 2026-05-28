#!/usr/bin/env bash
# smoke-bundle-trigger.sh
#
# Purpose: OPERATIONS.md § 2.1 bundling 정책 자동 검증 — v3.0+ 9-stage-bundled era
#   ROADMAP `milestones[]` entry schema 정합 검사.
#
# 배경: v3.1_workflow-policy-fine-tuning phase-3 (2026-05-10) — v3.0_milestones-restructure 도입
#   bundling 정책 (version 단위 1 milestone, 의미 단위 grouping) narrative 1차 source 외 자동 강제 부재.
#   ROADMAP entry 신규 (status: pending) 시 같은 version 안 다른 entry 와 의미 단위 grouping 검사.
#   v3.1_smoke-bundle-trigger-validation 흡수 (v3.0 PROPOSE next_candidates).
#
# 검증 책임 (DESIGN D8):
#   1. v3.0+ 신 schema entry (version 필드 존재) 가 같은 version 값 둘 이상 보유 부재 = bundling 강제
#   2. v3.0+ 신 schema entry 가 milestones_path 필드 보유 + 형식 검증 (^milestones/v[0-9]+\.[0-9]+/milestones\.md$)
#   3. historical entry (version 필드 부재, id flat = v{X.Y}_{slug}) 무시 (forward-only 정책)
#
# detect_era 미호출 (D16) — ROADMAP entry schema 직접 검사. era 분류 (tests/_era_detect.py) 와 책임 분리.
#
# 활성: pre-commit hook (D3 — 신규 등록, 12 → 13 hook). entry 형식: direct (--fix 미지원, D9).
# Algo: V1 (python3 + json.load + dict-key assertions). python3 부재 시 SKIP exit 0.
# Defense-in-depth: file size guard (>100KB skip), milestones_path regex.

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-bundle-trigger: SKIP (python3 not available)" >&2
    exit 0
fi

python3 - <<'PYEOF'
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

# Windows cp949 콘솔 UnicodeEncodeError 회피 (tests/CLAUDE.md § '흔한 함정' 6번 + smoke-python-entry-boilerplate § P2)
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')

REPO = Path.cwd()
PROJECTS_DIR = REPO / "projects"
SIZE_LIMIT = 100_000  # 100KB defense-in-depth
MILESTONES_PATH_REGEX = re.compile(r"^milestones/(_archive/)?v[0-9]+\.[0-9]+/(MILESTONE\.md(#sub-milestones)?|milestones\.md|LIGHTWEIGHT\.md)$")
# v6.2_milestone-artifact-directory-flattening (D7 c): era 양립 — bundled era = milestones.md / flattened era = MILESTONE.md(#sub-milestones)?
# v8.1_meta-lightweight-flow-design (D3): 4-section-lightweight era = LIGHTWEIGHT.md (가벼운 흐름 트랙, WORKFLOW.md § 3)

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
        errors.append(f"{md_path}: JSON parse error - {e}")
        return None


def validate_roadmap(roadmap_path: Path) -> None:
    """projects/<name>/ROADMAP.md 안 milestones[] 검증."""
    rel = roadmap_path.relative_to(REPO).as_posix()
    data = extract_json_block(roadmap_path)
    if data is None:
        # 본 smoke 범위 외 (smoke-projects-scope-discipline 가 thin index 검증)
        return
    milestones = data.get("milestones")
    if not isinstance(milestones, list):
        return  # 본 smoke 범위 외

    version_counts: dict[str, int] = defaultdict(int)
    for idx, entry in enumerate(milestones):
        if not isinstance(entry, dict):
            continue  # 본 smoke 범위 외 (smoke-projects-scope-discipline 가 검출)
        version = entry.get("version")
        if not isinstance(version, str):
            # historical entry (version 필드 부재) - forward-only 정책 일관, skip
            continue
        # v3.0+ 신 schema entry
        version_counts[version] += 1
        # milestones_path 필드 검증 (책임 2) — status: pending/deferred 은 디렉토리 미존재 정상, skip
        # (v5.21_roadmap-forward-looking-redesign-and-changelog-archival: deferred 분기 추가 — v1.x flat era entry 가 ROADMAP `milestones[]` 안 deferred status 로 보존 시 milestones_path 부재 자연)
        status = entry.get("status")
        if status in ("pending", "deferred"):
            continue
        mp = entry.get("milestones_path")
        if not isinstance(mp, str):
            errors.append(
                f"{rel}: milestones[{idx}] (version={version!r}, status={status!r}) milestones_path 필드 부재 또는 str 아님 - "
                f"v3.0+ 신 schema 의무 (OPERATIONS.md § 2.1, in_progress/completed entry 만)"
            )
        elif not MILESTONES_PATH_REGEX.match(mp):
            errors.append(
                f"{rel}: milestones[{idx}] (version={version!r}) milestones_path '{mp}' regex 위배 - "
                f"허용: ^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$ "
                f"(v4.0 안 _archive/ prefix 허용 + v6.2 안 MILESTONE.md 양립 + #sub-milestones anchor 허용)"
            )
        else:
            # 실 파일 존재 검증 — harness-meta 자체 개발 이력 (development/) 만 (OPERATIONS.md § 1: upbit 등 외부 project 는 milestone 산출물이 해당 repo 에 위치, harness-meta 내 부재 설계)
            # v8.0_reclassify-meta-as-development: meta → development/ 재분류 후 self-development roadmap 의 parent.name = "development"
            # v6.2: anchor (#sub-milestones) strip 후 실 파일 검사 (flattened era MILESTONE.md#sub-milestones 케이스)
            is_self_dev = roadmap_path.parent.name == "development"
            if is_self_dev:
                mp_file = mp.split('#', 1)[0]
                target = roadmap_path.parent / mp_file
                if not target.exists():
                    errors.append(
                        f"{rel}: milestones[{idx}] (version={version!r}) milestones_path '{mp}' 실 파일 부재 (anchor strip 후 '{mp_file}')"
                    )

    # 책임 1: 같은 version 값 v3.0+ entry 1건 강제 (= bundling 강제)
    for version, count in version_counts.items():
        if count > 1:
            errors.append(
                f"{rel}: version={version!r} entry {count}건 발견 - "
                f"bundling 정책 위반 (OPERATIONS.md § 2.1: 'version 단위 1 milestone'). "
                f"같은 의미 단위 후속 candidates 는 통합 milestone (sub-milestone phase 매핑) 으로 운용."
            )


# projects/<name>/ROADMAP.md 순회
if PROJECTS_DIR.exists() and PROJECTS_DIR.is_dir():
    for project_dir in sorted(PROJECTS_DIR.iterdir()):
        if not project_dir.is_dir():
            continue
        roadmap = project_dir / "ROADMAP.md"
        if roadmap.exists():
            validate_roadmap(roadmap)

# v8.0_reclassify-meta-as-development: development/ROADMAP.md (harness-meta 자체 개발 이력) 순회
dev_roadmap = REPO / "development" / "ROADMAP.md"
if dev_roadmap.exists():
    validate_roadmap(dev_roadmap)

if errors:
    print("=== smoke-bundle-trigger FAIL ===", file=sys.stderr)
    for e in errors:
        print(f"  - {e}", file=sys.stderr)
    sys.exit(1)

print("smoke-bundle-trigger PASS")
sys.exit(0)
PYEOF

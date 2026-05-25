#!/usr/bin/env bash
# smoke-open-stage-discipline.sh
#
# Purpose: ARCHITECTURE.md § 6.1 9-stage-bundled era 디렉토리 ↔ milestones.md 페어링 자동 강제.
#
# 배경: v3.5_open-stage-discipline-strengthening (2026-05-11) — v3.4 lessons L1 (cascade smoke 부재) 해소.
#   v3.4 Stage A step 7 narrative 강제만으로 누락 검출 불가 갭 (디렉토리 생성됐으나 milestones.md 부재)
#   사전 차단. tests/_era_detect.py:27 의 9-stage-bundled 표지와 1:1 정합.
#
# 검증 책임 (DESIGN D3):
#   디렉토리 명 ^v\d+\.\d+$ (밑줄 부재) 매칭 후 milestones.md 부재 시 FAIL.
#   historical era (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier) 의 디렉토리명
#   (밑줄 포함) 정규식 부재 → 자연 skip (forward-only D6).
#
# bundle-trigger 와 책임 분리 (DESIGN D3):
#   bundle-trigger: ROADMAP entry → 실 파일 방향 (entry schema 의무)
#   open-stage-discipline: 디렉토리 → milestones.md 방향 (페어링 의무)
#   두 책임은 검사 방향 직교 — tests/CLAUDE.md L208 책임 분리 규약 (v3.1 L3 D16) 정합.
#
# 활성: pre-commit hook (D5 — 신규 등록, 13 → 14 hook). entry: direct (--fix 미지원, D5).
# Algo: V1 (python3 + Path glob). python3 부재 시 SKIP exit 0.

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-open-stage-discipline: SKIP (python3 not available)" >&2
    exit 0
fi

python3 - <<'PYEOF'
import re
import sys
from pathlib import Path

# Windows cp949 콘솔 UnicodeEncodeError 회피 (D7 — tests/CLAUDE.md § '흔한 함정' 6번 + smoke-python-entry-boilerplate § P2)
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')

REPO = Path.cwd()
PROJECTS_DIR = REPO / "projects"
BUNDLED_NAME_REGEX = re.compile(r"^v\d+\.\d+$")
# 9-stage-bundled (v3.0~v6.1) 또는 9-stage-flattened (v6.2+, v6.2 D6) era 표지 (D3 — _era_detect.py 1:1 정합)
# v6.2_milestone-artifact-directory-flattening: era 양립 페어링 — MILESTONE.md OR milestones.md

errors: list[str] = []
checked = 0
skipped = 0

# v8.0_reclassify-meta-as-development: projects/*/milestones (외부 적용) + development/milestones (harness-meta 자체) 양쪽 순회.
milestones_dirs: list[Path] = []
if PROJECTS_DIR.exists() and PROJECTS_DIR.is_dir():
    for project_dir in sorted(PROJECTS_DIR.iterdir()):
        if project_dir.is_dir() and (project_dir / "milestones").is_dir():
            milestones_dirs.append(project_dir / "milestones")
dev_milestones = REPO / "development" / "milestones"
if dev_milestones.is_dir():
    milestones_dirs.append(dev_milestones)

for milestones_dir in milestones_dirs:
    for mdir in sorted(milestones_dir.iterdir()):
        if not mdir.is_dir():
            continue
        if not BUNDLED_NAME_REGEX.match(mdir.name):
            # historical era (밑줄 포함) — forward-only skip (D6)
            skipped += 1
            continue
        # 9-stage-bundled (milestones.md) OR 9-stage-flattened (MILESTONE.md) 페어링 검증
        # v6.2 D6: era 양립 — 둘 중 하나 존재 시 PASS
        ms_file = mdir / "milestones.md"
        milestone_file = mdir / "MILESTONE.md"
        rel = mdir.relative_to(REPO).as_posix()
        if not ms_file.is_file() and not milestone_file.is_file():
            errors.append(
                f"{rel}/: 디렉토리 ↔ (milestones.md OR MILESTONE.md) 페어링 위배 — "
                f"9-stage-bundled (v3.0~v6.1) 또는 9-stage-flattened (v6.2+) era "
                f"(ARCHITECTURE.md § 6.1) 의무 충족 부재. "
                f"tests/_era_detect.py 표지 미충족 → era 오인 위험 "
                f"(smoke-spec-verification / smoke-scope-contract skip 침묵 통과 가능)."
            )
        else:
            checked += 1

if errors:
    print("=== smoke-open-stage-discipline FAIL ===", file=sys.stderr)
    for e in errors:
        print(f"  - {e}", file=sys.stderr)
    sys.exit(1)

print(f"smoke-open-stage-discipline PASS (bundled/flattened checked={checked}, historical skipped={skipped})")
sys.exit(0)
PYEOF

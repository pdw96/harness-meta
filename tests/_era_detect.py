"""era 자동 식별 — 4-tier / 7-stage / 9-stage / 9-stage-bundled / skip

D5/D15 일원화 source (v3.0_milestones-restructure phase-2 — v2.2_era-detect-shared-module 흡수).

본 모듈은 smoke-spec-verification.sh + smoke-scope-contract.sh 가 batched python heredoc 안에서
sys.path.insert(0, 'tests') 후 import. 두 smoke 의 def detect_era 중복 → 단일 source 일원화.

era 분류 규칙:
- 9-stage-bundled (v3.0+, D10): 디렉토리 명 ^v\\d+\\.\\d+$ (밑줄 부재) + milestones.md 존재
- 9-stage (v2.0~v2.1): INTENT.md + APPROVE.md + PROPOSE.md 동시 존재
- 7-stage (v1.0~v1.4): PLAN.md 존재 또는 historical INTENT.md (PLAN→INTENT migrate, hotfix 43472b7)
- 4-tier (v1.84~v1.88) 또는 미식별: skip (위 모두 부재)
"""
import re
from pathlib import Path


def detect_era(mdir: Path) -> str:
    """era 자동 식별.

    Args:
        mdir: milestone 디렉토리 Path (예: projects/meta/milestones/v3.0/)

    Returns:
        "9-stage-bundled" | "9-stage" | "7-stage" | "skip"
    """
    if re.match(r'^v\d+\.\d+$', mdir.name) and (mdir / "milestones.md").is_file():
        return "9-stage-bundled"
    if (mdir / "INTENT.md").is_file() and (mdir / "APPROVE.md").is_file() and (mdir / "PROPOSE.md").is_file():
        return "9-stage"
    if (mdir / "PLAN.md").is_file():
        return "7-stage"
    if (mdir / "INTENT.md").is_file():
        # historical 7-stage era milestone (PLAN.md → INTENT.md migrate, hotfix 43472b7)
        return "7-stage"
    return "skip"

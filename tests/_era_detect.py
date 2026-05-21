"""era 자동 식별 — external-vector-pivot / 9-stage-flattened / 9-stage-bundled / 9-stage / 7-stage / 4-tier / skip

D5/D15 일원화 source (v3.0_milestones-restructure phase-2 — v2.2_era-detect-shared-module 흡수).
v6.2_milestone-artifact-directory-flattening: 9-stage-flattened 신규 era 추가 (D6).
v7.0_mechanism-cleanup-external-pivot phase-3: external-vector-pivot 신규 era 추가 (단수 디렉토리, mandate #8 도그푸드).

본 모듈은 smoke-spec-verification.sh + smoke-scope-contract.sh 가 batched python heredoc 안에서
sys.path.insert(0, 'tests') 후 import. 두 smoke 의 def detect_era 중복 → 단일 source 일원화.

era 분류 규칙 (검사 순서 = 위에서 아래로, 첫 매칭 반환):
- external-vector-pivot (v7.0+, mandate #8 도그푸드): 디렉토리 명 == 'milestone' (단수) + MILESTONE.md 존재. forward-only mandate.
- 9-stage-flattened (v6.2+, D6 신규): 디렉토리 명 ^v\\d+\\.\\d+$ (밑줄 부재) + MILESTONE.md 존재.
  검사 순서 우선 — phase-2 retrofit 일시적 MILESTONE.md + milestones.md 동시 존재 케이스 deterministic.
- 9-stage-bundled (v3.0~v6.1, D10): 디렉토리 명 ^v\\d+\\.\\d+$ (밑줄 부재) + milestones.md 존재
- 9-stage (v2.0~v2.1): INTENT.md + APPROVE.md + PROPOSE.md 동시 존재
- 7-stage (v1.0~v1.4): PLAN.md 존재 또는 historical INTENT.md (PLAN→INTENT migrate, hotfix 43472b7)
- 4-tier (v1.84~v1.88) 또는 미식별: skip (위 모두 부재)
"""
import re
from pathlib import Path


def detect_era(mdir: Path) -> str:
    """era 자동 식별.

    Args:
        mdir: milestone 디렉토리 Path (예: projects/meta/milestones/v3.0/ 또는 projects/meta/milestone/)

    Returns:
        "external-vector-pivot" | "9-stage-flattened" | "9-stage-bundled" | "9-stage" | "7-stage" | "skip"
    """
    # v7.0+ external-vector-pivot (단수 디렉토리, mandate #8 도그푸드, forward-only)
    if mdir.name == "milestone" and (mdir / "MILESTONE.md").is_file():
        return "external-vector-pivot"
    # v6.2+ 9-stage-flattened (검사 순서 우선, D6 — phase-2 retrofit 동시 존재 케이스 deterministic)
    if re.match(r'^v\d+\.\d+$', mdir.name) and (mdir / "MILESTONE.md").is_file():
        return "9-stage-flattened"
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

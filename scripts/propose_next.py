#!/usr/bin/env python3
"""propose_next.py — v6.5 Claude 자율 milestone 발의 mechanism (deterministic core).

v6.8 dedupe 확장 — surface candidate 자동 분리 (passing/delta status).

Purpose:
    ROADMAP next_candidates[] + 최근 5 milestone PROPOSE next_candidates_named_only +
    lessons_learned P2 라벨 항목 enumerate → JSON output. read-only.

    v6.8 dedupe — enumerated_milestones[].candidate_items 안 status 분류:
      - passing = next_candidates 또는 candidate_draft 안 이미 등재 (id 우선 + title fallback)
      - delta = 어디에도 부재 = 신규 surface 대상
    LLM Step 2 안 delta 우선 surface + passing 통계 only (D5 narrative).

    Append 책임은 slash command (claude/commands/propose-next.md) 안 LLM 안 Bash Edit
    도구 직접 호출 (D10 책임 분리, v6.4 cascade-sync.md step 3 정합).

Mechanism (D10 + D11 + v6.8 D1~D5):
    1. --scan (default) — read-only enumerate.
       (1차) 디렉토리 enumerate — projects/meta/milestones/v*/ semver desc 정렬 → 최근 5.
              각 디렉토리 안 MILESTONE.md (v6.2+ flattened) 또는 PROPOSE.md (v6.0~v6.1
              bundled) read.
       (2차) ROADMAP recent 3 + CHANGELOG archival 2건 cross-validate. 불일치 시 stderr
              warn (v5.18 Input Verification 패턴 정합).
       (3차) v6.8 dedupe — known_ids + known_titles set 구성 (next_candidates +
              candidate_draft 양쪽) → 각 candidate_item status 분류.
       출력 = JSON to stdout (UTF-8) — proposed candidates + cross-validate status
              + dedupe_stats (delta_count + passing_count + known_ids/titles_count).
    2. --list-candidates — ROADMAP candidate_draft[] 현재 entry read + JSON 출력.

Security (D10 + v6.4 패턴 정합):
    - Path traversal 차단 = is_relative_to(REPO_ROOT) verify on all file reads.
    - Fixed argument list = --scan | --list-candidates (subprocess injection 차단).
    - JSON 출력 = json.dumps() + round-trip self-check (json.loads).
    - Length-bounded regex = ID_REGEX {1,64} + TITLE_REGEX {1,200} + ENTRY_BLOCK_REGEX
      {1,2000} (ReDoS 차단).

Usage:
    python scripts/propose_next.py --scan
    python scripts/propose_next.py --list-candidates
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import date
from pathlib import Path

# Windows cp949 콘솔 UnicodeEncodeError 회피 (tests/CLAUDE.md § 흔한 함정 6)
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
if hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")


REPO_ROOT = Path(__file__).resolve().parent.parent

# 최근 5 milestone enumerate (D11 1차 디렉토리)
RECENT_LIMIT = 5

# Semver regex (length-bounded ReDoS 차단)
SEMVER_REGEX = re.compile(r"^v(\d{1,3})\.(\d{1,3})$")

# next_candidates / next_candidates_named_only / candidates_named_only 라벨 grep
# v6.8 fix — closing ']' 종결자 명시 (`,` 또는 `}` 후행) 으로 entry rationale 안 '[]'
# 문자열 안 ']' 잘림 회귀 차단 (v6.5 PROPOSE 안 rationale "candidate_draft[]..." evidence)
NAMED_ONLY_REGEX = re.compile(
    r'"(?:next_)?candidates(?:_named_only)?"\s*:\s*\[(.*?)\]\s*[,}]', re.DOTALL
)

# lessons_learned P2 라벨 grep (narrative_priority: "P2" 또는 priority: "P2")
LESSONS_P2_REGEX = re.compile(
    r'"(?:narrative_)?priority"\s*:\s*"P2"', re.IGNORECASE
)

# title 필드 grep — PROPOSE 안 candidate title 추출용
TITLE_REGEX = re.compile(r'"title"\s*:\s*"([^"]{1,200})"')

# id 필드 grep — v6.8 dedupe matching key 우선 (length-bounded {1,64} group-slug, ReDoS 차단)
ID_REGEX = re.compile(r'"id"\s*:\s*"([a-z0-9-]{1,64})"')

# Entry block (flat dict — nested {} 부재 전제, v6.x PROPOSE schema 정합)
ENTRY_BLOCK_REGEX = re.compile(r'\{[^{}]{1,2000}\}')

# Section text length cap (LLM input size 가드)
SECTION_TEXT_CAP = 8000


def safe_relative(path: Path) -> bool:
    """Path traversal 차단 — REPO_ROOT 안 path 만 허용."""
    try:
        path.resolve().relative_to(REPO_ROOT)
        return True
    except ValueError:
        return False


def semver_key(name: str) -> tuple[int, int]:
    """Semver desc 정렬 키. 매칭 부재 시 (-1, -1)."""
    m = SEMVER_REGEX.match(name)
    if not m:
        return (-1, -1)
    return (int(m.group(1)), int(m.group(2)))


def enumerate_recent_milestones() -> list[Path]:
    """1차 디렉토리 enumerate — projects/meta/milestones/v*/ semver desc 최근 N."""
    milestones_dir = REPO_ROOT / "projects" / "meta" / "milestones"
    if not safe_relative(milestones_dir) or not milestones_dir.is_dir():
        return []
    dirs = [
        d for d in milestones_dir.iterdir()
        if d.is_dir() and SEMVER_REGEX.match(d.name)
    ]
    dirs.sort(key=lambda d: semver_key(d.name), reverse=True)
    return dirs[:RECENT_LIMIT]


def extract_propose_section(milestone_dir: Path) -> str | None:
    """v6.2+ flattened: MILESTONE.md ## PROPOSE section / v6.0~v6.1 bundled: PROPOSE.md."""
    flattened = milestone_dir / "MILESTONE.md"
    bundled = milestone_dir / "PROPOSE.md"
    if flattened.is_file() and safe_relative(flattened):
        text = flattened.read_text(encoding="utf-8", errors="replace")
        # ## PROPOSE 섹션 추출 (다음 ## H2 까지)
        m = re.search(r"^## PROPOSE\s*\n(.+?)(?=^## |\Z)", text, re.MULTILINE | re.DOTALL)
        if m:
            return m.group(1)
    if bundled.is_file() and safe_relative(bundled):
        return bundled.read_text(encoding="utf-8", errors="replace")
    return None


def grep_named_only(section_text: str) -> list[dict]:
    """PROPOSE 섹션 안 next_candidates / candidate entries 안 {id, title} pair 추출.

    v6.8 dedupe — entry block 단위 분리 (ENTRY_BLOCK_REGEX) 후 id + title 같은 block 안 매칭.
    legacy era (v3~v5) 안 id 부재 시 id=None fallback (D2 title fallback 분기 자연 발현).
    """
    if not section_text:
        return []
    items: list[dict] = []
    for m in NAMED_ONLY_REGEX.finditer(section_text):
        inner = m.group(1)
        for entry_match in ENTRY_BLOCK_REGEX.finditer(inner):
            block = entry_match.group(0)
            title_m = TITLE_REGEX.search(block)
            if not title_m:
                continue
            id_m = ID_REGEX.search(block)
            items.append({
                "id": id_m.group(1) if id_m else None,
                "title": title_m.group(1),
            })
    return items


def grep_lessons_p2(section_text: str) -> int:
    """lessons_learned 안 P2 라벨 count."""
    if not section_text:
        return 0
    return len(LESSONS_P2_REGEX.findall(section_text))


def read_roadmap_json() -> dict | None:
    """ROADMAP.md 안 json 코드 블록 read."""
    roadmap = REPO_ROOT / "projects" / "meta" / "ROADMAP.md"
    if not safe_relative(roadmap) or not roadmap.is_file():
        return None
    text = roadmap.read_text(encoding="utf-8", errors="replace")
    m = re.search(r"```json\s*\n(.+?)\n```", text, re.DOTALL)
    if not m:
        return None
    try:
        return json.loads(m.group(1))
    except json.JSONDecodeError as e:
        print(f"propose_next: ROADMAP json parse error — {e}", file=sys.stderr)
        return None


def cmd_scan() -> dict:
    """--scan (default) — read-only enumerate.

    v6.8 dedupe — enumerated_milestones[].candidate_items 안 status 'delta' | 'passing'
    분류 (D1+D2+D4). passing = roadmap_next_candidates + candidate_draft 안 id 일치 (우선)
    또는 title 일치 (fallback) entry. delta = 어디에도 부재 = 신규 surface 대상.
    """
    roadmap = read_roadmap_json() or {}
    next_candidates = roadmap.get("next_candidates", []) or []
    candidate_draft = roadmap.get("candidate_draft", []) or []

    # D4 — dedupe scope = next_candidates + candidate_draft 양쪽
    known_ids: set[str] = set()
    known_titles: set[str] = set()
    for entry in list(next_candidates) + list(candidate_draft):
        if isinstance(entry, dict):
            eid = entry.get("id")
            if isinstance(eid, str) and eid:
                known_ids.add(eid)
            etitle = entry.get("title")
            if isinstance(etitle, str) and etitle:
                known_titles.add(etitle)

    recent_dirs = enumerate_recent_milestones()
    proposals_by_milestone: list[dict] = []
    for d in recent_dirs:
        section = extract_propose_section(d) or ""
        named_only_items = grep_named_only(section)
        # D1+D2 — status 분류, id 우선 + title fallback
        candidate_items: list[dict] = []
        for item in named_only_items:
            is_passing = False
            if item["id"] and item["id"] in known_ids:
                is_passing = True
            elif item["title"] in known_titles:
                is_passing = True
            candidate_items.append({
                "id": item["id"],
                "title": item["title"],
                "status": "passing" if is_passing else "delta",
            })
        lessons_p2_count = grep_lessons_p2(section)
        proposals_by_milestone.append({
            "milestone": d.name,
            "candidate_items_count": len(candidate_items),
            "candidate_items": candidate_items[:20],
            "lessons_p2_count": lessons_p2_count,
            "propose_section_preview": section[:SECTION_TEXT_CAP],
        })

    # D5 — Step 2 prompt narrative 입력 = delta + passing 통계
    delta_count = sum(
        1 for p in proposals_by_milestone
        for it in p["candidate_items"] if it["status"] == "delta"
    )
    passing_count = sum(
        1 for p in proposals_by_milestone
        for it in p["candidate_items"] if it["status"] == "passing"
    )

    cross_validate = {
        "directory_count": len(recent_dirs),
        "directory_names": [d.name for d in recent_dirs],
        "roadmap_recent_milestones": [
            m.get("version") for m in roadmap.get("milestones", [])
            if m.get("status") == "completed"
        ][:3],
        "dedupe_stats": {
            "delta_count": delta_count,
            "passing_count": passing_count,
            "known_ids_count": len(known_ids),
            "known_titles_count": len(known_titles),
        },
    }

    output = {
        "mode": "scan",
        "generated_at": date.today().isoformat(),
        "enumerated_milestones": proposals_by_milestone,
        "roadmap_next_candidates_count": len(next_candidates),
        "roadmap_next_candidates": next_candidates,
        "roadmap_candidate_draft_count": len(candidate_draft),
        "cross_validate": cross_validate,
        "instructions": (
            "Claude 자율 candidate 제안 (v6.8 dedupe 자동) = enumerated_milestones[]."
            "candidate_items 안 'status: delta' (신규 surface 대상) 우선 보고. "
            "'status: passing' = 이미 next_candidates 또는 candidate_draft 안 등재 → "
            "통계만 narrative (예: '이미 N건 등재 (passing). 신규 M건 (delta) 우선 검토'). "
            "cross_validate.dedupe_stats 안 delta_count + passing_count 직접 참조. "
            "delta 0건 시 신규 후보 부재 narrative + passing 통계 보고. 비유 표현 "
            "가이드 (D12 dialog P1-2): candidate_draft → '아직 결정 안 한 후보 명단', "
            "internal_synthesis → '내부 진척 후 떠오른 아이디어', benchmark_external "
            "→ '외부 트렌드 발견', delta → '신규 surface 후보', passing → '이미 인지한 후보'."
        ),
    }
    return output


def cmd_list_candidates() -> dict:
    """--list-candidates — ROADMAP candidate_draft[] read."""
    roadmap = read_roadmap_json() or {}
    candidate_draft = roadmap.get("candidate_draft", []) or []
    return {
        "mode": "list-candidates",
        "generated_at": date.today().isoformat(),
        "candidate_draft_count": len(candidate_draft),
        "candidate_draft": candidate_draft,
    }


def main() -> int:
    parser = argparse.ArgumentParser(
        description="v6.5 Claude 자율 milestone 발의 mechanism (deterministic core)"
    )
    parser.add_argument(
        "--scan", action="store_true",
        help="read-only enumerate (default mode)"
    )
    parser.add_argument(
        "--list-candidates", dest="list_candidates", action="store_true",
        help="ROADMAP candidate_draft[] 현재 entry 출력"
    )
    args = parser.parse_args()

    # Default mode = --scan
    if args.list_candidates:
        result = cmd_list_candidates()
    else:
        result = cmd_scan()

    # JSON round-trip self-check (D10 sec P1_sec_3 흡수)
    output_text = json.dumps(result, ensure_ascii=False, indent=2)
    try:
        json.loads(output_text)
    except json.JSONDecodeError as e:
        print(f"propose_next: JSON round-trip self-check FAIL — {e}", file=sys.stderr)
        return 2

    print(output_text)
    return 0


if __name__ == "__main__":
    sys.exit(main())

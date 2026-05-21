"""v6.19 phase-2 — CHANGELOG.md 안 v1.0~v5.21 entry 일괄 단축.

본 script = 1회성 mechanical task (hybrid 분기 marker = v6.19, v6.20+ Releases 단일 source).
- v6.0~v6.18 entry (line 11~391) 본문 잔존 (R1 결정 본질).
- v5.21~v1.0 entry (line 392~EOF) → ID + title + REPORT link 1줄 단축.

usage: python shrink_changelog.py --dry-run | --apply
"""
from __future__ import annotations
import argparse
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[5]
CHANGELOG = REPO_ROOT / "CHANGELOG.md"

VERSION_HEADER_RE = re.compile(
    r"^## \[(v[0-9]+(?:\.[0-9]+[a-z]*)?(?:[–\-]v?[0-9]+(?:\.[0-9]+[a-z]*)?)?[!]?)\] - (.+)$"
)
TITLE_BOLD_RE = re.compile(r"^- \*\*([^\*]+?)\*\*", re.MULTILINE)
TITLE_PLAIN_RE = re.compile(r"^- (.+)$", re.MULTILINE)
LINK_RE = re.compile(r"\(([^\)\s]*REPORT\.md)\)")
ARCHIVE_SLUG_DIRS_CACHE: dict[str, str] | None = None


def _load_archive_dir_index() -> dict[str, str]:
    """Map version (e.g., 'v1.5') → _archive directory slug (e.g., 'v1.5_xxx')."""
    global ARCHIVE_SLUG_DIRS_CACHE
    if ARCHIVE_SLUG_DIRS_CACHE is not None:
        return ARCHIVE_SLUG_DIRS_CACHE
    archive_dir = REPO_ROOT / "projects" / "meta" / "milestones" / "_archive"
    out: dict[str, str] = {}
    if archive_dir.exists():
        for child in archive_dir.iterdir():
            if not child.is_dir():
                continue
            name = child.name
            # extract version prefix (e.g., 'v1.5' from 'v1.5_xxx' or 'v3.0' from 'v3.0')
            m = re.match(r"^(v[0-9]+\.[0-9]+[a-z]*)", name)
            if m:
                version = m.group(1)
                # prefer first match (deterministic by directory listing order)
                out.setdefault(version, name)
    ARCHIVE_SLUG_DIRS_CACHE = out
    return out


def _fallback_archive_link(version_raw: str) -> str:
    """Build REPORT.md link by mapping version → _archive directory slug."""
    index = _load_archive_dir_index()
    # 1차: exact match
    v_norm = version_raw.rstrip("!")
    if v_norm in index:
        return f"projects/meta/milestones/_archive/{index[v_norm]}/REPORT.md"
    # 2차: range entry (예: 'v1.0–v1.4') — first part 매핑
    range_match = re.match(r"^(v[0-9]+\.[0-9]+[a-z]*)[–\-]", v_norm)
    if range_match:
        first_v = range_match.group(1)
        if first_v in index:
            return f"projects/meta/milestones/_archive/{index[first_v]}/REPORT.md"
    return ""


def _fallback_title(block: str) -> str:
    """첫 bullet 본문 truncate (60 char) — bold title 부재 시."""
    match = TITLE_PLAIN_RE.search(block)
    if not match:
        return ""
    text = match.group(1).strip()
    # strip 안 leading ` ** / 외부 라벨
    text = re.sub(r"^\*\*", "", text)
    text = re.sub(r"\*\*$", "", text)
    if len(text) > 80:
        text = text[:77].rstrip() + "..."
    return text


def parse_old_entries(lines: list[str], start_idx: int) -> list[tuple[str, str, str, str]]:
    entries: list[tuple[str, str, str, str]] = []
    i = start_idx
    while i < len(lines):
        m = VERSION_HEADER_RE.match(lines[i])
        if not m:
            i += 1
            continue
        version_raw = m.group(1)
        date = m.group(2).strip()
        end = i + 1
        while end < len(lines) and not VERSION_HEADER_RE.match(lines[end]):
            end += 1
        block = "\n".join(lines[i:end])
        # title — bold first, plain fallback
        title_match = TITLE_BOLD_RE.search(block)
        title = title_match.group(1).strip() if title_match else _fallback_title(block)
        # link — explicit first, archive fallback
        link_match = LINK_RE.search(block)
        link = link_match.group(1) if link_match else _fallback_archive_link(version_raw)
        entries.append((version_raw, date, title, link))
        i = end
    return entries


def shrink_entry(version_raw: str, date: str, title: str, link: str) -> str:
    bracketed = f"[{version_raw}]"
    title_part = f" - **{title}**" if title else ""
    link_part = f" ([REPORT]({link}))" if link else ""
    return f"- {bracketed} - {date}{title_part}{link_part}"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--apply", action="store_true", help="실 갱신 (없으면 dry-run)")
    args = parser.parse_args()

    text = CHANGELOG.read_text(encoding="utf-8")
    lines = text.split("\n")

    v60_idx: int | None = None
    v521_idx: int | None = None
    for i, line in enumerate(lines):
        match = VERSION_HEADER_RE.match(line)
        if match:
            version = match.group(1).rstrip("!")
            if version == "v6.0" and v60_idx is None:
                v60_idx = i
            if version == "v5.21" and v521_idx is None:
                v521_idx = i

    if v60_idx is None or v521_idx is None:
        print("ERROR: v6.0 or v5.21 boundary not found", file=sys.stderr)
        return 1

    head = lines[: v521_idx]
    old_entries = parse_old_entries(lines, v521_idx)

    shrunk_section: list[str] = [
        "## [v1.0–v5.21] — Archived (1줄 단축)",
        "",
        "> v6.19_changelog-github-releases-migration 안 archival cycle 두 번째 적용. 본 archived "
        "entry list = ID + title + REPORT link 1줄. 본문 full = 각 entry 의 `REPORT.md` 또는 git log "
        "참조. trace 3중 본질 = (1) 본 short link / (2) REPORT.md 본문 / (3) git log atomic commits.",
        "",
    ]
    for entry in old_entries:
        shrunk_section.append(shrink_entry(*entry))
    shrunk_section.append("")

    new_lines = head + shrunk_section
    new_text = "\n".join(new_lines)
    if not new_text.endswith("\n"):
        new_text += "\n"

    old_size = len(text.encode("utf-8"))
    new_size = len(new_text.encode("utf-8"))
    delta = new_size - old_size

    print(f"old size: {old_size} bytes / {len(lines)} lines")
    print(f"new size: {new_size} bytes / {len(new_lines)} lines")
    print(f"delta: {delta:+d} bytes ({100*delta/old_size:+.1f}%)")
    print(f"old entries shrunk: {len(old_entries)}")
    no_title = sum(1 for e in old_entries if not e[2])
    no_link = sum(1 for e in old_entries if not e[3])
    print(f"entries with no title: {no_title}")
    print(f"entries with no link: {no_link}")

    if args.apply:
        CHANGELOG.write_text(new_text, encoding="utf-8")
        print("APPLIED")
    else:
        print("DRY-RUN (no write). pass --apply to write.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

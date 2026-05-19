#!/usr/bin/env python3
"""cascade_sync.py — v6.4 cascade 자동 동기 mechanism (deterministic core).

Purpose:
    v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source → (b) EXECUTE Edit cascade
    → (c) VERIFY grep 의 (b) 단계 수동 cycle (v3.18~v6.3 누적 28+ cycle) 자동화.

Mechanism:
    1. Enumerate cascade host files = grep `<!-- cascade-source: <path>#<anchor>
       expected-hash:<16-hex> -->` marker comment in repo-wide *.md files.
    2. Parse marker → resolve <path> (path traversal 차단 = is_relative_to REPO_ROOT).
    3. Read source file + extract anchor → paragraph (heading slug or explicit
       HTML id `<a id="X">` 매칭, anchor 직후 paragraph 단일 block).
    4. Compute SHA-256 of normalized paragraph (whitespace `\\s+` → single space,
       trim) → 16-hex prefix (8 byte = 64 bit collision space).
    5. Compare expected (marker) vs actual (source) hash.
    6. Mode dispatch:
       - --check (default) = report drift as diff text + exit 1 if drift else 0.
       - --apply = update host marker expected-hash to actual + exit 0.

Edge cases (DESIGN.D11):
    (a) 0 host marker = OK exit 0 silent.
    (b) N host pointing same source = normal (multi-host cascade).
    (c) source path 부재 = ERROR exit 2.
    (d) source anchor 부재 = ERROR exit 2.
    (e) host SIZE_LIMIT 100KB 초과 = WARN skip.
    (f) code fence 안 marker = false-positive 회피 (in_code toggle).

Security (DESIGN.D12 + D13):
    - Path traversal 차단 = is_relative_to(REPO_ROOT) verify.
    - Fixed argument list = --check | --apply only (subprocess injection 차단).
    - External URL skip = stderr warn (re_match `^https?://`).

Usage:
    python scripts/cascade_sync.py --check
    python scripts/cascade_sync.py --apply
"""

from __future__ import annotations

import argparse
import hashlib
import re
import sys
from pathlib import Path

# Windows cp949 콘솔 UnicodeEncodeError 회피 (tests/CLAUDE.md § 흔한 함정 6)
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
if hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")


REPO_ROOT = Path(__file__).resolve().parent.parent

# D11 SIZE_LIMIT (host file)
SIZE_LIMIT = 100_000

# D7 marker regex (length-bounded ReDoS 차단, D12)
MARKER_REGEX = re.compile(
    r"<!--\s*cascade-source:\s*"
    r"(?P<path>[^\s#]{1,200})"
    r"#(?P<anchor>[^\s]{1,100})\s+"
    r"expected-hash:(?P<hash>[0-9a-f]{16})"
    r"\s*-->"
)

# Code fence toggle (D11 (f))
CODE_FENCE_REGEX = re.compile(r"^```")

# External URL skip (D12)
EXTERNAL_URL_REGEX = re.compile(r"^https?://")

# HTML escape 차단 (D7 P2_sec_3)
HTML_BREAK_REGEX = re.compile(r"-->")


def normalize_whitespace(text: str) -> str:
    """Whitespace normalize — `\\s+` → single space, trim."""
    return re.sub(r"\s+", " ", text).strip()


def compute_hash(text: str) -> str:
    """SHA-256 of normalized text → 16-hex prefix (D6, 8 byte = 64 bit)."""
    normalized = normalize_whitespace(text)
    return hashlib.sha256(normalized.encode("utf-8")).hexdigest()[:16]


def find_anchor_paragraph(source_text: str, anchor: str) -> str | None:
    """Extract paragraph block matching anchor (D11 매핑 logic).

    Anchor priority:
        1. Explicit HTML id `<a id="X">` 매칭 시 = 같은 paragraph 단일 block.
        2. Markdown heading slug 매칭 시 = heading 직후 paragraph 단일 block.
    """
    # 1. Explicit HTML id match (priority 1)
    explicit_regex = re.compile(
        rf'<a\s+id="{re.escape(anchor)}"\s*>', re.IGNORECASE
    )
    match = explicit_regex.search(source_text)
    if match:
        # Extract paragraph containing the anchor (split by blank lines, take same block)
        before = source_text[: match.end()]
        after = source_text[match.end() :]
        # backtrack to start of paragraph (previous blank line)
        before_lines = before.split("\n")
        block_start_idx = len(before_lines) - 1
        for i in range(len(before_lines) - 2, -1, -1):
            if not before_lines[i].strip():
                block_start_idx = i + 1
                break
            block_start_idx = i
        # forward to end of paragraph (next blank line)
        after_lines = after.split("\n")
        block_end_idx = 0
        for i, line in enumerate(after_lines):
            if not line.strip():
                block_end_idx = i
                break
            block_end_idx = i + 1
        block = "\n".join(before_lines[block_start_idx:] + after_lines[:block_end_idx])
        return block

    # 2. Markdown heading slug match (priority 2)
    # Slug = lowercase, spaces → hyphens, alphanumeric + hyphen only
    for match in re.finditer(r"^(#{1,6})\s+(.+)$", source_text, re.MULTILINE):
        heading_text = match.group(2).strip()
        slug = re.sub(r"[^\w\s-]", "", heading_text.lower())
        slug = re.sub(r"[-\s]+", "-", slug).strip("-")
        if slug == anchor:
            # Extract paragraph block following heading until next blank line
            after = source_text[match.end() :]
            after_lines = after.split("\n")
            block_lines = []
            for line in after_lines[1:]:  # skip blank line after heading
                if not line.strip() and block_lines:
                    break
                if line.strip():
                    block_lines.append(line)
            return "\n".join(block_lines) if block_lines else None

    return None


def enumerate_hosts() -> list[tuple[Path, list[tuple[re.Match, str, str, str]]]]:
    """Enumerate cascade host files in repo-wide *.md (excluding node_modules / .git)."""
    results = []
    skip_dirs = {".git", "node_modules", ".venv", "venv", "_archive"}
    for md_path in REPO_ROOT.rglob("*.md"):
        # Skip excluded dirs
        if any(part in skip_dirs for part in md_path.parts):
            continue
        # SIZE_LIMIT check (D11 (e))
        if md_path.stat().st_size > SIZE_LIMIT:
            print(
                f"  ! {md_path.relative_to(REPO_ROOT)}: size > {SIZE_LIMIT} bytes (WARN skip)",
                file=sys.stderr,
            )
            continue
        text = md_path.read_text(encoding="utf-8")
        # Code fence toggle (D11 (f))
        in_code = False
        markers = []
        for line_idx, line in enumerate(text.split("\n")):
            if CODE_FENCE_REGEX.match(line):
                in_code = not in_code
                continue
            if in_code:
                continue
            for match in MARKER_REGEX.finditer(line):
                path_str = match.group("path")
                anchor = match.group("anchor")
                expected_hash = match.group("hash")
                # HTML escape 차단 (D7)
                if HTML_BREAK_REGEX.search(path_str) or HTML_BREAK_REGEX.search(anchor):
                    print(
                        f"  X {md_path.relative_to(REPO_ROOT)}:{line_idx + 1}: "
                        f"marker contains '-->' literal (HTML escape FAIL)",
                        file=sys.stderr,
                    )
                    sys.exit(2)
                markers.append((match, path_str, anchor, expected_hash))
        if markers:
            results.append((md_path, markers))
    return results


def resolve_source(path_str: str) -> Path | None:
    """Resolve marker <path> + path traversal 차단 (D12 P1_sec_1)."""
    # External URL skip (D12)
    if EXTERNAL_URL_REGEX.match(path_str):
        print(f"  - external URL skip: {path_str}", file=sys.stderr)
        return None
    try:
        candidate = (REPO_ROOT / path_str).resolve()
    except (OSError, ValueError):
        return None
    # Path traversal 차단
    try:
        candidate.relative_to(REPO_ROOT)
    except ValueError:
        print(
            f"  X path traversal blocked: {path_str} (resolved outside REPO_ROOT)",
            file=sys.stderr,
        )
        sys.exit(2)
    return candidate if candidate.exists() else None


def main() -> int:
    parser = argparse.ArgumentParser(
        description="cascade 자동 동기 mechanism (v6.4)",
        epilog="Modes: --check (default, dry-run) | --apply (auto Edit).",
    )
    mode_group = parser.add_mutually_exclusive_group()
    mode_group.add_argument(
        "--check", action="store_true", default=True, help="dry-run (default)"
    )
    mode_group.add_argument(
        "--apply", action="store_true", help="auto-update host marker hash"
    )
    args = parser.parse_args()

    hosts = enumerate_hosts()

    # Edge case (a): 0 host marker = OK exit 0 silent
    if not hosts:
        return 0

    drift_count = 0
    edit_count = 0
    for host_path, markers in hosts:
        host_rel = host_path.relative_to(REPO_ROOT).as_posix()
        host_text = host_path.read_text(encoding="utf-8")
        new_host_text = host_text
        for match, path_str, anchor, expected_hash in markers:
            source_path = resolve_source(path_str)
            # Edge case (c): source 부재
            if source_path is None:
                if not EXTERNAL_URL_REGEX.match(path_str):
                    print(
                        f"  X {host_rel}: source not found: {path_str}",
                        file=sys.stderr,
                    )
                    sys.exit(2)
                continue
            source_text = source_path.read_text(encoding="utf-8")
            paragraph = find_anchor_paragraph(source_text, anchor)
            # Edge case (d): anchor 부재
            if paragraph is None:
                print(
                    f"  X {host_rel}: anchor not found in {path_str}: #{anchor}",
                    file=sys.stderr,
                )
                sys.exit(2)
            actual_hash = compute_hash(paragraph)
            if expected_hash != actual_hash:
                drift_count += 1
                print(f"  ~ {host_rel}: drift detected")
                print(f"    source: {path_str}#{anchor}")
                print(f"    expected: {expected_hash}")
                print(f"    actual:   {actual_hash}")
                if args.apply:
                    # Replace expected-hash in host marker
                    old_marker = match.group(0)
                    new_marker = old_marker.replace(
                        f"expected-hash:{expected_hash}",
                        f"expected-hash:{actual_hash}",
                    )
                    new_host_text = new_host_text.replace(old_marker, new_marker, 1)
                    edit_count += 1
        if args.apply and new_host_text != host_text:
            host_path.write_text(new_host_text, encoding="utf-8")
            print(f"  ✓ {host_rel}: marker updated")

    if drift_count == 0:
        print(f"  ✓ all {len(hosts)} host(s) in sync")
        return 0
    if args.apply:
        print(
            f"\n  ✓ apply complete — {edit_count} marker(s) updated in "
            f"{drift_count} drift(s) across {len(hosts)} host(s)"
        )
        return 0
    print(
        f"\n  ✗ {drift_count} drift(s) detected across {len(hosts)} host(s) — "
        f"run with --apply to sync",
        file=sys.stderr,
    )
    return 1


if __name__ == "__main__":
    sys.exit(main())

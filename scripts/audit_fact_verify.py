#!/usr/bin/env python3
"""audit_fact_verify — script-only audit chain fact verify (v5.13 3 method automation)

Detects boolean / table / numeric fact mismatches between audit chain agent outputs
(scanner / analyzer / mapper / proposer) and 1차 source mappings.

CLI:
    python scripts/audit_fact_verify.py --dir <audit-output> [--strict]

Exit codes:
    0 = no mismatch
    1 = mismatch detected
    2 = error (invalid path, parse error, etc.)

v6.6_audit-chain-hallucination-auto-correction 정전화 — D2 callable lookup, D10 path traversal
차단, D11 stdlib only (no PyYAML), D12 자기 정전화 자연.

v6.9_synthesizer-mismatch-report-5step-format 정전화 — mismatch dict schema 5-step 통일
(6 필드: method + capture/identify/isolate/fix/verify, Anthropic Claude Code debugger subagent
spec 정합 https://code.claude.com/docs/en/sub-agents). 책임 분리 (D2) = script 가
Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (null, LLM/사용자
채움 — v6.6 R1 자율 = 검출 only + v6.7 3-step chain 정합).
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Callable, Optional

REPO_ROOT = Path(__file__).resolve().parent.parent

FILE_SIZE_CAP = 5 * 1024 * 1024  # 5 MB cap (보안 P2#1 흡수 일부)


# ---------------------------------------------------------------------------
# Lookup tables (D2 callable 만, shell 호출 / subprocess / eval / exec 금지)
# ---------------------------------------------------------------------------

BOOLEAN_LOOKUP: dict[str, Callable[[], bool]] = {
    # cycle 2 v5.11 evidence + 자연 확장
    "claude_md_in_repo": lambda: (REPO_ROOT / "CLAUDE.md").exists(),
    "agents_md_in_repo": lambda: (REPO_ROOT / "AGENTS.md").exists(),
    "roadmap_in_repo": lambda: (REPO_ROOT / "ROADMAP.md").exists(),
    "license_in_repo": lambda: (REPO_ROOT / "LICENSE").exists(),
    "pre_commit_config_in_repo": lambda: (REPO_ROOT / ".pre-commit-config.yaml").exists(),
}

NUMERIC_LOOKUP: dict[str, Callable[[], int]] = {
    # empty 초기 (evidence cycle 0) — evidence 도달 시 사전 추가, no-op fallback
}


# ---------------------------------------------------------------------------
# Path traversal 차단 (D10 보안 P1#1 흡수)
# ---------------------------------------------------------------------------


def safe_resolve(arg: str) -> Path:
    """Resolve path + repo root prefix 검증. symlink reject (D10 P1#1)."""
    candidate = Path(arg).resolve()
    expected_prefix = REPO_ROOT.resolve()
    try:
        candidate.relative_to(expected_prefix)
    except ValueError:
        print(
            f"error: --dir path must be inside repo root ({candidate.name} outside)",
            file=sys.stderr,
        )
        sys.exit(2)
    if candidate.is_symlink():
        print(f"error: symlink not allowed ({candidate.name})", file=sys.stderr)
        sys.exit(2)
    return candidate


def auto_detect_dir() -> Optional[Path]:
    """가장 최근 projects/*/audit-* 디렉토리 자동 detect (sorted by name desc)."""
    candidates = sorted(
        REPO_ROOT.glob("projects/*/audit-*"), key=lambda p: p.name, reverse=True
    )
    for cand in candidates:
        if cand.is_dir() and not cand.is_symlink():
            return cand
    return None


def safe_read(file: Path) -> Optional[str]:
    """Read file with size cap. Returns None on error."""
    try:
        if file.stat().st_size > FILE_SIZE_CAP:
            print(
                f"warning: skip oversized file {file.name} (> {FILE_SIZE_CAP // (1024 * 1024)} MB)",
                file=sys.stderr,
            )
            return None
        return file.read_text(encoding="utf-8")
    except OSError as exc:
        print(f"warning: cannot read {file.name}: {type(exc).__name__}", file=sys.stderr)
        return None


# ---------------------------------------------------------------------------
# Boolean method detect (cycle 2 v5.11 evidence)
# ---------------------------------------------------------------------------

BOOLEAN_PATTERN = re.compile(
    r'(?:^|[\s,{])\s*"?(?P<key>[a-z_][a-z0-9_]*)"?\s*:\s*(?P<value>true|false)\b'
)


def detect_boolean_mismatches(content: str, file: Path) -> list[dict]:
    """`key: true|false` 인용 patterns; verify against BOOLEAN_LOOKUP.

    v6.9 5-step schema (6 필드: method + capture/identify/isolate/fix/verify).
    """
    mismatches: list[dict] = []
    for match in BOOLEAN_PATTERN.finditer(content):
        key = match.group("key")
        value = match.group("value") == "true"
        if key not in BOOLEAN_LOOKUP:
            continue  # unknown key skip (false negative trade-off, lookup table 확장 자연)
        try:
            expected = BOOLEAN_LOOKUP[key]()
        except Exception as exc:  # noqa: BLE001
            mismatches.append(
                {
                    "method": "boolean",
                    "capture": f"{file.name}: {key}={value} (lookup error)",
                    "identify": file.name,
                    "isolate": {
                        "key": key,
                        "stated": value,
                        "error": f"lookup callable raised: {type(exc).__name__}",
                    },
                    "fix": None,
                    "verify": None,
                }
            )
            continue
        if value != expected:
            mismatches.append(
                {
                    "method": "boolean",
                    "capture": f"{file.name}: {key}={value}",
                    "identify": file.name,
                    "isolate": {"key": key, "stated": value, "actual": expected},
                    "fix": None,
                    "verify": None,
                }
            )
    return mismatches


# ---------------------------------------------------------------------------
# Table method detect (cycle 1 v5.10 + cycle 3 v5.12 evidence, D3 4 agent column)
# ---------------------------------------------------------------------------

TABLE_ROW_PATTERN = re.compile(r"^\s*\|(.+)\|\s*$")
SEPARATOR_CELL = re.compile(r"^:?-+:?$")


def parse_markdown_tables(content: str) -> list[list[list[str]]]:
    """Parse `| col1 | col2 |` tables. Returns list of tables (each = list of rows)."""
    tables: list[list[list[str]]] = []
    current: list[list[str]] = []
    for line in content.splitlines():
        match = TABLE_ROW_PATTERN.match(line)
        if not match:
            if current:
                tables.append(current)
                current = []
            continue
        cells = [c.strip() for c in match.group(1).split("|")]
        # separator row (`| --- | --- |`) skip
        if cells and all((not c) or SEPARATOR_CELL.fullmatch(c) for c in cells):
            continue
        current.append(cells)
    if current:
        tables.append(current)
    return tables


SOURCE_COLUMN_KEYS = ("source_path", "source_url", "source_key", "source")


def detect_table_row_mismatches(content: str, file: Path) -> list[dict]:
    """Tables with `source_path`/`source_url`/`source` column → verify path exists.

    v6.9 5-step schema (6 필드: method + capture/identify/isolate/fix/verify).
    """
    mismatches: list[dict] = []
    expected_prefix = REPO_ROOT.resolve()
    for table in parse_markdown_tables(content):
        if len(table) < 2:
            continue
        header = [cell.lower() for cell in table[0]]
        source_idx: Optional[int] = None
        for key in SOURCE_COLUMN_KEYS:
            if key in header:
                source_idx = header.index(key)
                break
        if source_idx is None:
            continue
        for row in table[1:]:
            if source_idx >= len(row):
                continue
            ref = row[source_idx]
            if not ref or ref in {"—", "-", "N/A"}:
                continue
            if ref.startswith(("http://", "https://")):
                continue
            candidate = (REPO_ROOT / ref).resolve()
            try:
                candidate.relative_to(expected_prefix)
            except ValueError:
                mismatches.append(
                    {
                        "method": "table",
                        "capture": f"{file.name}: source_ref={ref}",
                        "identify": file.name,
                        "isolate": {"source_ref": ref, "issue": "path outside repo"},
                        "fix": None,
                        "verify": None,
                    }
                )
                continue
            if not candidate.exists():
                mismatches.append(
                    {
                        "method": "table",
                        "capture": f"{file.name}: source_ref={ref}",
                        "identify": file.name,
                        "isolate": {"source_ref": ref, "issue": "path does not exist"},
                        "fix": None,
                        "verify": None,
                    }
                )
    return mismatches


# ---------------------------------------------------------------------------
# Numeric method detect (lookup empty 초기 no-op fallback, v5.13 정전화)
# ---------------------------------------------------------------------------

NUMERIC_PATTERN = re.compile(
    r'(?:^|[\s,{])\s*"?(?P<key>[a-z_][a-z0-9_]*)"?\s*:\s*(?P<value>\d+)\b'
)


def detect_numeric_mismatches(content: str, file: Path) -> list[dict]:
    """`key: N` patterns; verify against NUMERIC_LOOKUP (empty initial = no-op).

    v6.9 5-step schema (6 필드: method + capture/identify/isolate/fix/verify).
    """
    if not NUMERIC_LOOKUP:
        return []  # empty 초기 fallback (evidence cycle 0)
    mismatches: list[dict] = []
    for match in NUMERIC_PATTERN.finditer(content):
        key = match.group("key")
        value = int(match.group("value"))
        if key not in NUMERIC_LOOKUP:
            continue
        try:
            expected = NUMERIC_LOOKUP[key]()
        except Exception as exc:  # noqa: BLE001
            mismatches.append(
                {
                    "method": "numeric",
                    "capture": f"{file.name}: {key}={value} (lookup error)",
                    "identify": file.name,
                    "isolate": {
                        "key": key,
                        "stated": value,
                        "error": f"lookup callable raised: {type(exc).__name__}",
                    },
                    "fix": None,
                    "verify": None,
                }
            )
            continue
        if value != expected:
            mismatches.append(
                {
                    "method": "numeric",
                    "capture": f"{file.name}: {key}={value}",
                    "identify": file.name,
                    "isolate": {"key": key, "stated": value, "actual": expected},
                    "fix": None,
                    "verify": None,
                }
            )
    return mismatches


# ---------------------------------------------------------------------------
# Orchestrator
# ---------------------------------------------------------------------------

DETECT_FUNCTIONS = (
    detect_boolean_mismatches,
    detect_table_row_mismatches,
    detect_numeric_mismatches,
)


def verify_directory(audit_dir: Path, strict: bool = False) -> list[dict]:
    """Walk audit_dir for *.md files; run 3 method detect; aggregate mismatches."""
    all_mismatches: list[dict] = []
    for md_file in sorted(audit_dir.glob("*.md")):
        if md_file.is_symlink():
            continue
        content = safe_read(md_file)
        if content is None:
            continue
        for detect_fn in DETECT_FUNCTIONS:
            method_ms = detect_fn(content, md_file)
            all_mismatches.extend(method_ms)
            if strict and method_ms:
                return all_mismatches
    return all_mismatches


def main(argv: Optional[list[str]] = None) -> int:
    parser = argparse.ArgumentParser(
        description="audit chain fact verify (v5.13 3 method script-only automation)"
    )
    parser.add_argument(
        "--dir",
        help="audit chain output directory (default = latest projects/*/audit-*)",
    )
    parser.add_argument(
        "--strict",
        action="store_true",
        help="exit 1 on first mismatch (default = full scan)",
    )
    args = parser.parse_args(argv)

    if args.dir:
        audit_dir = safe_resolve(args.dir)
    else:
        detected = auto_detect_dir()
        if detected is None:
            print(
                "error: no audit-* directory found under projects/*/",
                file=sys.stderr,
            )
            return 2
        audit_dir = detected
    if not audit_dir.is_dir():
        print(f"error: not a directory: {audit_dir.name}", file=sys.stderr)
        return 2

    mismatches = verify_directory(audit_dir, strict=args.strict)
    relative = audit_dir.relative_to(REPO_ROOT)
    if not mismatches:
        print(f"audit_fact_verify: PASS ({relative})")
        return 0
    print(f"audit_fact_verify: FAIL ({relative}, {len(mismatches)} mismatch)")
    print(json.dumps(mismatches, indent=2, ensure_ascii=False))
    return 1


if __name__ == "__main__":
    sys.exit(main())

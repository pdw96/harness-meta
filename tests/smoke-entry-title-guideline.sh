#!/usr/bin/env bash
# smoke-entry-title-guideline.sh
#
# Purpose: OPERATIONS § 4 entry title 가이드 4 원칙 중 (1)+(2) 자동 강제 검증.
#   (1) 한 entry = 한 본질 — ' + ' literal space + lookbehind/lookahead non-whitespace (P1 mechanical proxy)
#   (2) ≤ 60자 — Python len() codepoint 동치 (한국어 시각 폭 ≈ 영문 120자 baseline)
#
# 검증 scope (entry-form artifact closed-set, D4):
#   1. projects/*/ROADMAP.md 안 `milestones[]/next_candidates[]/candidate_draft[]` title 필드
#      (milestones[] 안 status='deferred' entry 포함)
#   2. CHANGELOG.md bullet bold header `- **{title}** —` line-by-line iteration
#
# (3) Active form + (4) Detail summary 분리 = oos_1+oos_2 (휴리스틱 false-positive + 의미 차원 = AI 판단 위임).
#
# 활성: pre-commit hook (local 8건째 등재, v6.3_entry-title-guideline-smoke-verification).
# Algo: V1 (python3 + regex + json.load). python3 부재 시 SKIP exit 0 (환경 가드).
# Defense-in-depth: SIZE_LIMIT 100KB 초과 = stderr 경고 + exit 1 FAIL (silent SKIP 폐기, security p1_2 정책 우회 차단).
# ReDoS 차단: CHANGELOG regex length-bounded `[^*\n]{1,500}` + 단일 line cap 4096 (security p1_1).
#
# v3.21 narrative 정전화 3 단계 패턴 cycle 28 (사이드 effect — 본질 = mechanism creation 1차).
# v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 4번째 자연 발현 (v4.2+v5.6+v6.2+v6.3).

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-entry-title-guideline: SKIP (python3 not available)" >&2
    exit 0
fi

python3 - <<'PYEOF'
import sys
import re
import json
from pathlib import Path

# Windows cp949 콘솔 UnicodeEncodeError 회피
# (tests/CLAUDE.md § 흔한 함정 6 + smoke-python-entry-boilerplate § P2)
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
if hasattr(sys.stderr, 'reconfigure'):
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')

REPO = Path.cwd()
PROJECTS_DIR = REPO / "projects"
CHANGELOG = REPO / "CHANGELOG.md"
SIZE_LIMIT = 100_000   # 100KB defense-in-depth (D1)
MAX_LINE_LENGTH = 4096  # 단일 line cap (D5, ReDoS 차단)
MAX_TITLE_LENGTH = 60   # § 7.2 (2) baseline (D3)

# (1) ' + ' regex — literal space 양옆 + lookbehind/lookahead non-whitespace (D2)
PLUS_REGEX = re.compile(r'(?<=\S) \+ (?=\S)')

# CHANGELOG bullet bold regex — length-bounded `{1,500}` + newline 제외 (D5)
CHANGELOG_REGEX = re.compile(r'^[\s]*-[\s]+\*\*([^*\n]{1,500})\*\*')

violations = []  # list of (source, location, title, length, principle)


def check_title(title, source, location):
    """단일 title 검증 — (1) ' + ' + (2) > 60자."""
    if PLUS_REGEX.search(title):
        violations.append((source, location, title, len(title), "P1 ' + '"))
    if len(title) > MAX_TITLE_LENGTH:
        violations.append((source, location, title, len(title), f"P2 > {MAX_TITLE_LENGTH}자"))


def check_roadmap(roadmap_path):
    """projects/<name>/ROADMAP.md milestones[]/next_candidates[]/candidate_draft[] title 검증."""
    if not roadmap_path.exists():
        return
    rel = roadmap_path.relative_to(REPO).as_posix()
    if roadmap_path.stat().st_size > SIZE_LIMIT:
        print(f"  X {rel}: size > {SIZE_LIMIT} bytes (FAIL, D1 정책 우회 차단)", flush=True)
        sys.exit(1)
    text = roadmap_path.read_text(encoding='utf-8')
    m = re.search(r'```json\s*\n(.*?)\n```', text, re.DOTALL)
    if not m:
        # 본 smoke 범위 외 (root thin index = smoke-projects-scope-discipline 책임)
        return
    try:
        data = json.loads(m.group(1))
    except json.JSONDecodeError as e:
        print(f"  X {rel}: JSON parse error - {e}", file=sys.stderr, flush=True)
        sys.exit(1)
    # D4 enumerate scope = milestones + next_candidates + candidate_draft
    for array_name in ('milestones', 'next_candidates', 'candidate_draft'):
        entries = data.get(array_name, [])
        if not isinstance(entries, list):
            continue
        for i, entry in enumerate(entries):
            if not isinstance(entry, dict):
                continue
            # D4 명시: title 키만 검사 (id/summary/description/deferred_reason 제외)
            title = entry.get('title')
            if isinstance(title, str):
                check_title(title, rel, f"{array_name}[{i}].title")


def check_changelog():
    """CHANGELOG.md bullet bold header line-by-line 검증 (D5)."""
    if not CHANGELOG.exists():
        return
    if CHANGELOG.stat().st_size > SIZE_LIMIT:
        print(f"  X CHANGELOG.md: size > {SIZE_LIMIT} bytes (FAIL, D1 정책 우회 차단)", flush=True)
        sys.exit(1)
    text = CHANGELOG.read_text(encoding='utf-8')
    for ln, line in enumerate(text.splitlines(), start=1):
        if len(line) > MAX_LINE_LENGTH:
            continue  # 단일 line cap (D5)
        m = CHANGELOG_REGEX.match(line)
        if m:
            title = m.group(1)
            check_title(title, "CHANGELOG.md", f"L{ln}")


# 1. ROADMAP enumerate
if PROJECTS_DIR.exists():
    for roadmap in sorted(PROJECTS_DIR.glob("*/ROADMAP.md")):
        check_roadmap(roadmap)
# v8.0_reclassify-meta-as-development: development/ROADMAP.md (harness-meta 자체 개발 이력)
check_roadmap(REPO / "development" / "ROADMAP.md")

# 2. CHANGELOG bullet
check_changelog()

# 출력
FAIL = len(violations)

if FAIL == 0:
    print("=== smoke-entry-title-guideline: PASS (no violations) ===", flush=True)
    sys.exit(0)

print("=== smoke-entry-title-guideline: FAIL ===", flush=True)
print(f"[smoke-entry-title-guideline] FAIL: {FAIL} violation(s) detected", flush=True)
print(f"  OPERATIONS § 4 (1) 한 entry = 한 본질 ' + ' marker / (2) <= {MAX_TITLE_LENGTH}자 baseline", flush=True)
print(f"  (3) Active form + (4) Detail summary = AI 판단 위임 (자동 검증 제외)", flush=True)
print("", flush=True)
for source, location, title, length, principle in violations:
    title_display = title if len(title) <= 80 else title[:77] + "..."
    print(f"  [{source}] {location} [{length}자] [{principle}]: {title_display}", flush=True)
sys.exit(1)
PYEOF

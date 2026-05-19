#!/usr/bin/env bash
# smoke-candidate-draft-schema.sh
#
# Purpose: v6.5 ROADMAP candidate_draft[] entry schema 자동 강제 (read-only).
#   단일 책임 (D5, arch P1_arch_2 흡수):
#     - 7 필드 존재: id / title / source / detected_at / rationale / category / decision_pending
#     - category enum 2 값: 'internal_synthesis' | 'benchmark_external'
#
# 검증 scope: projects/*/ROADMAP.md 안 candidate_draft[] 안 각 entry.
#
# Algo: V1 (python3 + json.load). python3 부재 시 SKIP exit 0 (환경 가드).
# Defense-in-depth: SIZE_LIMIT 100KB 초과 = stderr 경고 + exit 1 FAIL.
#
# v6.5 phase-1 신규 (v6.5_claude-autonomous-milestone-proposal 흡수).
# v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 6번째 자연 발현
#   (v4.2+v5.6+v6.2+v6.3+v6.4+v6.5).

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-candidate-draft-schema: SKIP (python3 not available)" >&2
    exit 0
fi

python3 - <<'PYEOF'
import sys
import re
import json
from pathlib import Path

# Windows cp949 콘솔 UnicodeEncodeError 회피
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
if hasattr(sys.stderr, 'reconfigure'):
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')

REPO_ROOT = Path.cwd()
SIZE_LIMIT = 100_000

REQUIRED_FIELDS = [
    "id", "title", "source", "detected_at",
    "rationale", "category", "decision_pending",
]
CATEGORY_ENUM = {"internal_synthesis", "benchmark_external"}

PASS = 0
FAIL = 0

print("=== Stage 1 — candidate_draft[] entry schema 검증 ===")

roadmaps = sorted(REPO_ROOT.glob("projects/*/ROADMAP.md"))
if not roadmaps:
    print("  (no ROADMAP.md found, SKIP)")
    sys.exit(0)

for rp in roadmaps:
    size = rp.stat().st_size
    if size > SIZE_LIMIT:
        print(f"  ✗ {rp.relative_to(REPO_ROOT)}: SIZE_LIMIT 초과 ({size} > {SIZE_LIMIT})", file=sys.stderr)
        FAIL += 1
        continue
    text = rp.read_text(encoding="utf-8", errors="replace")
    m = re.search(r"```json\s*\n(.+?)\n```", text, re.DOTALL)
    if not m:
        # ROADMAP 안 json 코드 블록 부재 = skip silent
        continue
    try:
        data = json.loads(m.group(1))
    except json.JSONDecodeError as e:
        print(f"  ✗ {rp.relative_to(REPO_ROOT)}: json parse FAIL — {e}")
        FAIL += 1
        continue

    candidate_draft = data.get("candidate_draft", [])
    if not isinstance(candidate_draft, list):
        print(f"  ✗ {rp.relative_to(REPO_ROOT)}: candidate_draft 필드가 array 아님")
        FAIL += 1
        continue

    for idx, entry in enumerate(candidate_draft):
        if not isinstance(entry, dict):
            print(f"  ✗ {rp.relative_to(REPO_ROOT)}: candidate_draft[{idx}] dict 아님")
            FAIL += 1
            continue
        missing = [f for f in REQUIRED_FIELDS if f not in entry]
        if missing:
            print(f"  ✗ {rp.relative_to(REPO_ROOT)}: candidate_draft[{idx}] 필드 누락 — {missing}")
            FAIL += 1
            continue
        cat = entry.get("category")
        if cat not in CATEGORY_ENUM:
            print(f"  ✗ {rp.relative_to(REPO_ROOT)}: candidate_draft[{idx}] category '{cat}' enum 위반 (허용: {sorted(CATEGORY_ENUM)})")
            FAIL += 1
            continue
        PASS += 1
        print(f"  ✓ {rp.relative_to(REPO_ROOT)}: candidate_draft[{idx}] id={entry.get('id')[:40]} category={cat}")

print(f"=== 결과: PASS={PASS} FAIL={FAIL} ===")
sys.exit(0 if FAIL == 0 else 1)
PYEOF

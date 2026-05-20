#!/usr/bin/env bash
# smoke-candidate-draft-schema.sh
#
# Purpose: 'candidate-related schema 강제' umbrella — 두 source 검증 (read-only).
#   Stage 1 (v6.5): ROADMAP candidate_draft[] entry schema
#     - 7 필드 존재: id / title / source / detected_at / rationale / category / decision_pending
#     - category enum 2 값: 'internal_synthesis' | 'benchmark_external'
#   Stage 2 (v6.8): scripts/propose_next.py --scan 출력 candidate_items schema
#     - 3 필드 존재: id (str | null) / title (str) / status (str)
#     - status enum 2 값: 'delta' | 'passing'
#     - cross_validate.dedupe_stats 4 필드: delta_count / passing_count / known_ids_count / known_titles_count
#
# 검증 scope:
#   Stage 1 — projects/*/ROADMAP.md 안 candidate_draft[] 안 각 entry
#   Stage 2 — python3 scripts/propose_next.py --scan stdout JSON
#
# Algo: V1 (python3 + json.load). python3 부재 시 SKIP exit 0 (환경 가드).
# Defense-in-depth: SIZE_LIMIT 100KB 초과 = stderr 경고 + exit 1 FAIL.
#
# v6.5 phase-1 신규 (v6.5_claude-autonomous-milestone-proposal 흡수).
# v6.8 phase-1 확장 (v6.8_propose-next-surface-dedupe-mechanism 흡수 D9 — 두 source 'candidate-related' umbrella).
# v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 6번째 → 8번째 자연 발현
#   (v4.2+v5.6+v6.2+v6.3+v6.4+v6.5+v6.6+v6.8).

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

print("=== Stage 2 — scripts/propose_next.py --scan 출력 candidate_items schema 검증 ===")

import subprocess

script_path = REPO_ROOT / "scripts" / "propose_next.py"
if not script_path.is_file():
    print(f"  (scripts/propose_next.py 부재, SKIP)")
else:
    try:
        result = subprocess.run(
            [sys.executable, str(script_path), "--scan"],
            capture_output=True, text=True, encoding="utf-8", errors="replace",
            timeout=30, cwd=str(REPO_ROOT),
        )
    except (subprocess.TimeoutExpired, FileNotFoundError) as e:
        print(f"  ✗ propose_next.py 호출 FAIL — {e}")
        FAIL += 1
    else:
        if result.returncode != 0:
            print(f"  ✗ propose_next.py exit code {result.returncode} (expected 0)")
            FAIL += 1
        else:
            try:
                scan_data = json.loads(result.stdout)
            except json.JSONDecodeError as e:
                print(f"  ✗ propose_next.py stdout json parse FAIL — {e}")
                FAIL += 1
            else:
                # cross_validate.dedupe_stats 4 필드 검증
                ds = scan_data.get("cross_validate", {}).get("dedupe_stats")
                if not isinstance(ds, dict):
                    print(f"  ✗ cross_validate.dedupe_stats dict 아님")
                    FAIL += 1
                else:
                    required_ds = {"delta_count", "passing_count", "known_ids_count", "known_titles_count"}
                    missing_ds = required_ds - set(ds.keys())
                    if missing_ds:
                        print(f"  ✗ dedupe_stats 필드 누락 — {sorted(missing_ds)}")
                        FAIL += 1
                    else:
                        non_int = [k for k, v in ds.items() if not isinstance(v, int)]
                        if non_int:
                            print(f"  ✗ dedupe_stats 안 비-int 값 — {non_int}")
                            FAIL += 1
                        else:
                            print(f"  ✓ dedupe_stats: delta={ds['delta_count']} passing={ds['passing_count']} known_ids={ds['known_ids_count']} known_titles={ds['known_titles_count']}")
                            PASS += 1

                # enumerated_milestones[].candidate_items schema 검증
                STATUS_ENUM = {"delta", "passing"}
                em = scan_data.get("enumerated_milestones", [])
                if not isinstance(em, list):
                    print(f"  ✗ enumerated_milestones array 아님")
                    FAIL += 1
                else:
                    items_total = 0
                    items_fail = 0
                    for mi, m in enumerate(em):
                        if not isinstance(m, dict):
                            items_fail += 1
                            continue
                        items = m.get("candidate_items", [])
                        if not isinstance(items, list):
                            items_fail += 1
                            continue
                        for ci, it in enumerate(items):
                            items_total += 1
                            if not isinstance(it, dict):
                                items_fail += 1
                                print(f"  ✗ enumerated_milestones[{mi}].candidate_items[{ci}] dict 아님")
                                continue
                            if "title" not in it or not isinstance(it["title"], str):
                                items_fail += 1
                                print(f"  ✗ enumerated_milestones[{mi}].candidate_items[{ci}] title 누락 또는 비-str")
                                continue
                            if "id" not in it:
                                items_fail += 1
                                print(f"  ✗ enumerated_milestones[{mi}].candidate_items[{ci}] id 키 부재")
                                continue
                            # id 는 str 또는 None
                            if it["id"] is not None and not isinstance(it["id"], str):
                                items_fail += 1
                                print(f"  ✗ enumerated_milestones[{mi}].candidate_items[{ci}] id 가 str 또는 None 아님")
                                continue
                            if it.get("status") not in STATUS_ENUM:
                                items_fail += 1
                                print(f"  ✗ enumerated_milestones[{mi}].candidate_items[{ci}] status '{it.get('status')}' enum 위반 (허용: {sorted(STATUS_ENUM)})")
                                continue
                    if items_fail == 0:
                        print(f"  ✓ candidate_items schema 검증 ({items_total}건 items, 5 milestones)")
                        PASS += 1
                    else:
                        FAIL += items_fail

print("=== Stage 3 — next_candidates[].id regex 검증 ===")

# v6.11_id-regex-validation-smoke 흡수.
# (a) projects/meta/ROADMAP.md schema_note 안 regex 명시값 일치 검증 (drift 자동 차단, v6.10 L7 가이드라인 정합)
# (b) projects/*/ROADMAP.md 안 next_candidates[].id 가 regex `^[a-z0-9-]+$` 정합 검증
# id 부재 entry SKIP (legacy era 안전 — v6.11 D4, 별 candidate `propose-next-legacy-era-id-backfill` 보존)

ID_REGEX = re.compile(r"^[a-z0-9-]+$")
META_SCHEMA_NOTE_REGEX_SUBSTRING = "^[a-z0-9-]+$"

meta_roadmap = REPO_ROOT / "projects" / "meta" / "ROADMAP.md"
if meta_roadmap.is_file():
    meta_text = meta_roadmap.read_text(encoding="utf-8", errors="replace")
    meta_m = re.search(r"```json\s*\n(.+?)\n```", meta_text, re.DOTALL)
    if meta_m:
        try:
            meta_data = json.loads(meta_m.group(1))
        except json.JSONDecodeError:
            meta_data = None
        if meta_data is not None:
            schema_note = meta_data.get("schema_note", "")
            if META_SCHEMA_NOTE_REGEX_SUBSTRING in schema_note:
                print(f"  ✓ projects/meta/ROADMAP.md: schema_note 안 regex '{META_SCHEMA_NOTE_REGEX_SUBSTRING}' 일치 (smoke hardcode 와 drift 없음)")
                PASS += 1
            else:
                print(f"  ✗ projects/meta/ROADMAP.md: schema_note 안 regex '{META_SCHEMA_NOTE_REGEX_SUBSTRING}' 부재 — smoke hardcode 와 drift")
                FAIL += 1

for rp in roadmaps:
    text = rp.read_text(encoding="utf-8", errors="replace")
    m = re.search(r"```json\s*\n(.+?)\n```", text, re.DOTALL)
    if not m:
        continue
    try:
        data = json.loads(m.group(1))
    except json.JSONDecodeError:
        continue

    next_candidates = data.get("next_candidates", [])
    if not isinstance(next_candidates, list):
        continue

    rp_rel = rp.relative_to(REPO_ROOT)
    nc_pass = 0
    nc_fail = 0
    for idx, entry in enumerate(next_candidates):
        if not isinstance(entry, dict):
            continue
        if "id" not in entry:
            continue
        nid = entry["id"]
        if not isinstance(nid, str):
            print(f"  ✗ {rp_rel}: next_candidates[{idx}].id 비-str ({type(nid).__name__})")
            nc_fail += 1
            continue
        if not ID_REGEX.match(nid):
            print(f"  ✗ {rp_rel}: next_candidates[{idx}].id '{nid}' regex '^[a-z0-9-]+$' 위반")
            nc_fail += 1
            continue
        nc_pass += 1

    if nc_pass + nc_fail > 0:
        if nc_fail == 0:
            print(f"  ✓ {rp_rel}: next_candidates[].id regex PASS ({nc_pass}건)")
            PASS += 1
        else:
            FAIL += nc_fail

print(f"=== 결과: PASS={PASS} FAIL={FAIL} ===")
sys.exit(0 if FAIL == 0 else 1)
PYEOF

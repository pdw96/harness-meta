#!/usr/bin/env bash
# smoke-spec-verification.sh — milestone 산출물 JSON schema 정합 검증 (v2.2, batched python)
# v2.2 갱신 (v2.1_smoke-spawn-batching 2026-05-10):
#   per-call python3 spawn (~150회) → 단일 batched python3 호출로 통합.
#   spawn cost 0.376s × ~150 ≈ 57s 절감 → 시간 66s → ~5s.
#   동일 검증 로직 / 출력 / exit code 보존 (baseline PASS=99 FAIL=0 SKIP=80 동치).
# v2.1 (v2.0_workflow-word-fidelity 2026-05-10):
#   era 자동 식별 — 산출 파일명 자체로 분기 (D10, ARCHITECTURE.md § 6 era 정책)
#     · 9-stage era (v2.0+): INTENT.md + APPROVE.md + PROPOSE.md 동시 존재 → 7종 검증
#     · 7-stage era (v1.0~v1.4): PLAN.md 존재 + INTENT/APPROVE/PROPOSE 부재 → 5종 검증
#     · 4-tier era (v1.84~v1.88): JSON block 없음 → 자동 SKIP
#   각 stage 별 milestone 부재 시 SKIP (era 자동 분기)
#
# Stage 1 (7-stage era): PLAN.md     — id, title, goal, success_criteria, out_of_scope
# Stage 2 (9-stage era): INTENT.md   — id, title, goal, success_criteria, out_of_scope
# Stage 3 (era 공통):    RESEARCH.md — external, codebase, options, risks_identified
# Stage 4 (era 공통):    DESIGN.md   — decisions, phases (approval 검증은 smoke-scope-contract 책임)
# Stage 5 (9-stage era): APPROVE.md  — approval (approved_by + date)
# Stage 6 (era 공통):    VERIFY.md   — verdict, criteria_check
# Stage 7 (era 공통):    REPORT.md   — summary (next_candidates 책임은 PROPOSE 로 이전)
# Stage 8 (9-stage era): PROPOSE.md  — next_candidates
# Stage 9 (era 공통):    execute/phase-{n}.md — phase, status (파일명 regex 검증 포함)
#
# Usage:
#   bash tests/smoke-spec-verification.sh        # 검증 (default)
#   bash tests/smoke-spec-verification.sh --help
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/harness-meta")}"
cd "$HARNESS_META_ROOT"

usage() {
    cat <<'USAGE'
Usage: bash tests/smoke-spec-verification.sh

milestone 산출물 JSON schema 정합 검증 (era 자동 식별 + batched python).
enumerate: projects/*/milestones/v*_*/ — JSON block 없는 4-tier era milestone (v1.84~v1.88) 은 SKIP.
9-stage era (v2.0+) 와 7-stage era (v1.0~v1.4) 는 산출 파일명 자체로 자동 분기.
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help|-h) usage; exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *) echo "Unknown argument: $1" >&2; exit 2 ;;
    esac
done

# 단일 batched python3 호출 — 모든 milestone × 모든 stage 검증.
# heredoc quoting <<'PYEOF' (single-quoted) — bash variable expansion 차단 (D13).
python3 <<'PYEOF'
import sys
import re
import json
from pathlib import Path

# Windows cp949 콘솔에서 한글/em dash (U+2014) UnicodeEncodeError 회피.
# tests/smoke-python-entry-boilerplate.sh § P2 패턴 (v1.87) + D15 errors='replace' 통일 (v3.0 phase-6).
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# v3.0_milestones-restructure phase-2: detect_era 함수 tests/_era_detect.py 분리 (D5/D15 일원화 source).
# 본 smoke 는 detect_era 호출 부재 (era 분기 안 함, 모든 milestone 의 fp 존재 시 검증) — 정의 제거.
# era 분기 검증은 smoke-scope-contract.sh 책임.

PASS = 0
FAIL = 0
SKIP = 0


def ok(msg):
    global PASS
    print(f"  ✓ {msg}", flush=True)
    PASS += 1


def fail(msg):
    global FAIL
    print(f"  ✗ {msg}", flush=True)
    FAIL += 1


def skip(msg):
    global SKIP
    print(f"  - {msg} (SKIP)", flush=True)
    SKIP += 1


def extract_json(fp):
    """return (obj, error_token). error_token = None | 'no-json-block' | 'json-parse-error:<e>' | 'read-error:<e>'"""
    try:
        content = fp.read_text(encoding='utf-8', errors='replace')
    except Exception as e:
        return None, f"read-error:{e}"
    m = re.search(r'```json\n(.*?)\n```', content, re.DOTALL)
    if not m:
        return None, "no-json-block"
    try:
        obj = json.loads(m.group(1))
    except json.JSONDecodeError as e:
        return None, f"json-parse-error:{e}"
    return obj, None


def check_json_fields(fp, label, required):
    """required 필드 존재 검증 → ok / skip / fail (per-milestone try/except 격리, R2/D6)"""
    try:
        obj, err = extract_json(fp)
        if err == "no-json-block":
            skip(f"{label} — legacy (no JSON block)")
            return
        if err is not None:
            fail(f"{label} — 필드 누락: {err}")
            return
        missing = [f for f in required if f not in obj]
        if missing:
            fail(f"{label} — 필드 누락: {','.join(missing)}")
        else:
            ok(f"{label} — 필수 필드 OK")
    except Exception as e:
        fail(f"{label} — unexpected: {e}")


def check_execute_phase(fp_posix, fp):
    """execute/phase-{n}.md 파일명 regex + JSON schema (per-milestone try/except 격리)"""
    try:
        fname = fp.name
        if not re.match(r'^phase-[0-9]+\.md$', fname):
            fail(f"execute/ 파일명 위반: {fp_posix} (expected phase-N.md)")
            return
        obj, err = extract_json(fp)
        if err == "no-json-block":
            skip(f"{fp_posix} — legacy (no JSON block)")
            return
        if err is not None:
            fail(f"{fp_posix} — 필드 누락: {err}")
            return
        missing = [f for f in ("phase", "status") if f not in obj]
        if missing:
            fail(f"{fp_posix} — 필드 누락: {','.join(missing)}")
        else:
            ok(f"{fp_posix} — phase/status OK")
    except Exception as e:
        fail(f"{fp_posix} — unexpected: {e}")


def check_stage(stage_label, artifact, required, milestone_dirs):
    """artifact 별 milestone iteration"""
    print()
    print(f"=== {stage_label} — {artifact} JSON schema ===")
    for mdir in milestone_dirs:
        fp = mdir / artifact
        label = f"{mdir.parent.parent.name}/{mdir.name}"
        if not fp.is_file():
            skip(f"{label} — {artifact} 부재")
            continue
        check_json_fields(fp, label, required)


def main():
    # v3.0_milestones-restructure: glob v*_* → v[0-9]* (밑줄 없는 v3.0+ 디렉토리도 포함)
    milestone_dirs = sorted(Path("projects").glob("*/milestones/v[0-9]*"))
    milestone_dirs = [d for d in milestone_dirs if d.is_dir()]

    if not milestone_dirs:
        fail("milestone 디렉토리 0건 (projects/*/milestones/v[0-9]*/ 없음)")
        print()
        print(f"=== 결과: PASS={PASS} FAIL={FAIL} SKIP={SKIP} ===")
        return 1

    # Stage 1 — PLAN (7-stage era; 부재 시 SKIP)
    check_stage("Stage 1 (7-stage era)", "PLAN.md",
                ["id", "title", "goal", "success_criteria", "out_of_scope"], milestone_dirs)

    # Stage 2 — INTENT (9-stage era; 부재 시 SKIP)
    check_stage("Stage 2 (9-stage era)", "INTENT.md",
                ["id", "title", "goal", "success_criteria", "out_of_scope"], milestone_dirs)

    # Stage 3 — RESEARCH (era 공통)
    check_stage("Stage 3", "RESEARCH.md",
                ["external", "codebase", "options", "risks_identified"], milestone_dirs)

    # Stage 4 — DESIGN (era 공통; approval 검증은 smoke-scope-contract 책임)
    check_stage("Stage 4", "DESIGN.md", ["decisions", "phases"], milestone_dirs)

    # Stage 5 — APPROVE (9-stage era; 부재 시 SKIP)
    check_stage("Stage 5 (9-stage era)", "APPROVE.md", ["approval"], milestone_dirs)

    # Stage 6 — VERIFY (era 공통)
    check_stage("Stage 6", "VERIFY.md", ["verdict", "criteria_check"], milestone_dirs)

    # Stage 7 — REPORT (era 공통; next_candidates 책임은 PROPOSE)
    check_stage("Stage 7", "REPORT.md", ["summary"], milestone_dirs)

    # Stage 8 — PROPOSE (9-stage era; 부재 시 SKIP)
    check_stage("Stage 8 (9-stage era)", "PROPOSE.md", ["next_candidates"], milestone_dirs)

    # Stage 9 — execute/phase-{n}.md
    print()
    print("=== Stage 9 — execute/phase-{n}.md 파일명 + JSON schema ===")
    execute_files = sorted(Path("projects").glob("*/milestones/v[0-9]*/execute/phase-*.md"))
    step_files = sorted(Path("projects").glob("*/milestones/v[0-9]*/execute/step*.md"))

    for sf in step_files:
        fail(f"execute/ 파일명 위반: {sf.as_posix()} (step{{N}}.md 금지 — phase-{{N}}.md 사용)")

    if not execute_files:
        skip("Stage 6 — execute/phase-*.md 0건")
    else:
        for ef in execute_files:
            check_execute_phase(ef.as_posix(), ef)

    print()
    print(f"=== 결과: PASS={PASS} FAIL={FAIL} SKIP={SKIP} ===")
    return 0 if FAIL == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
PYEOF
exit $?

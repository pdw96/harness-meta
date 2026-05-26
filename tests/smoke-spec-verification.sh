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
enumerate: projects/*/milestones/v*_*/ + development/milestones/v*/ — JSON block 없는 4-tier era milestone (v1.84~v1.88) 은 SKIP.
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
# v6.2_milestone-artifact-directory-flattening: 9-stage-flattened era (MILESTONE.md 단일 파일) 추가 검증 — detect_era 호출 재개 (D7 a).
# Stage 1~9 개별 파일 검증 (bundled/legacy era) 후 flattened era milestone 에 한해 MILESTONE.md 안 H2 섹션 추가 검증.
# 8 stage H2 분기 모두 정합 (regression P2 #2 흡수).
sys.path.insert(0, 'tests')
from _era_detect import detect_era  # noqa: E402

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


def extract_frontmatter(fp):
    """v6.1+ YAML frontmatter parser (PyYAML 의존 회피, regex + line split).
    return (dict, error_token). error_token = None | 'no-frontmatter' | 'read-error:<e>'
    Frontmatter = file 첫 줄 `---\\n...\\n---\\n` 블록. 단순 key: value 라인만 인식 (nested 미지원)."""
    try:
        content = fp.read_text(encoding='utf-8', errors='replace')
    except Exception as e:
        return None, f"read-error:{e}"
    m = re.match(r'^---\n(.*?)\n---\n', content, re.DOTALL)
    if not m:
        return None, "no-frontmatter"
    fm = {}
    for line in m.group(1).split('\n'):
        if ':' in line and not line.lstrip().startswith('#'):
            k, v = line.split(':', 1)
            fm[k.strip()] = v.strip()
    return fm, None


def extract_h2_section_json(milestone_fp, h2_name):
    """v6.2+ 9-stage-flattened era — MILESTONE.md 안 `## {h2_name}` 섹션 안 첫 ```json``` 추출.
    return (obj, error_token). error_token = None | 'no-h2-section' | 'no-json-block' | 'json-parse-error:<e>'."""
    try:
        content = milestone_fp.read_text(encoding='utf-8', errors='replace')
    except Exception as e:
        return None, f"read-error:{e}"
    pattern = rf'^## {re.escape(h2_name)}\s*$\n(.*?)(?=^## |\Z)'
    m = re.search(pattern, content, re.MULTILINE | re.DOTALL)
    if not m:
        return None, "no-h2-section"
    section = m.group(1)
    json_m = re.search(r'```json\n(.*?)\n```', section, re.DOTALL)
    if not json_m:
        return None, "no-json-block"
    try:
        return json.loads(json_m.group(1)), None
    except json.JSONDecodeError as e:
        return None, f"json-parse-error:{e}"


def check_h2_section_fields(milestone_fp, h2_name, label, required):
    """v6.2+ flattened era — MILESTONE.md 안 H2 섹션 JSON 강제 필드 검증.
    required 안 id/title 자동 제외 (frontmatter milestone-level 1건으로 이전, D3)."""
    try:
        obj, err = extract_h2_section_json(milestone_fp, h2_name)
        if err == "no-h2-section":
            skip(f"{label} — ## {h2_name} 섹션 부재")
            return
        if err == "no-json-block":
            skip(f"{label} — ## {h2_name} 섹션 안 ```json``` 부재")
            return
        if err is not None:
            fail(f"{label} — {err}")
            return
        json_required = [f for f in required if f not in ('id', 'title')]
        missing = [f for f in json_required if f not in obj]
        if missing:
            fail(f"{label} — JSON 필드 누락: {','.join(missing)}")
        else:
            ok(f"{label} — flattened era H2 ## {h2_name} OK")
    except Exception as e:
        fail(f"{label} — unexpected: {e}")


def check_json_fields(fp, label, required, frontmatter_required=None):
    """v6.1+ 자동 식별 — YAML frontmatter 존재 시 신규 schema (frontmatter id/title 검증 + JSON 강제 필드 검증, id/title JSON 강제 제외), 부재 시 현 schema (JSON 강제 필드 검증, id/title 포함).
    frontmatter_required = 신규 schema 안 frontmatter 강제 필드 (default = ['id','title','version','stage','status']).
    required = 현 schema JSON 강제 필드 (id/title 포함). 신규 schema 안에서는 id/title 자동 제외 후 검증.
    per-milestone try/except 격리, R2/D6."""
    try:
        fm, fm_err = extract_frontmatter(fp)
        if fm is not None:
            # 신규 schema (v6.1+ Anthropic 정합 하이브리드)
            fm_req = frontmatter_required or ['id', 'title', 'version', 'stage', 'status']
            fm_missing = [k for k in fm_req if k not in fm]
            if fm_missing:
                fail(f"{label} — frontmatter 누락: {','.join(fm_missing)}")
                return
            obj, err = extract_json(fp)
            if err == "no-json-block":
                skip(f"{label} — frontmatter only (no JSON block)")
                return
            if err is not None:
                fail(f"{label} — 필드 누락: {err}")
                return
            json_required = [f for f in required if f not in ('id', 'title')]
            missing = [f for f in json_required if f not in obj]
            if missing:
                fail(f"{label} — JSON 필드 누락 (신규 schema): {','.join(missing)}")
            else:
                ok(f"{label} — 신규 schema (YAML+JSON) OK")
            return

        # 현 schema (v6.0 이전, frontmatter 부재)
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
    # v8.0_reclassify-meta-as-development: meta → development/ 재분류 — projects/*/milestones (외부 적용 upbit 등) + development/milestones (harness-meta 자체 개발 이력) 양쪽 enumerate.
    milestone_dirs = sorted(Path("projects").glob("*/milestones/v[0-9]*"))
    milestone_dirs += sorted(Path("development").glob("milestones/v[0-9]*"))
    milestone_dirs = [d for d in milestone_dirs if d.is_dir()]

    if not milestone_dirs:
        fail("milestone 디렉토리 0건 (projects/*/milestones/v[0-9]*/ + development/milestones/v[0-9]*/ 없음)")
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
    execute_files += sorted(Path("development").glob("milestones/v[0-9]*/execute/phase-*.md"))
    step_files = sorted(Path("projects").glob("*/milestones/v[0-9]*/execute/step*.md"))
    step_files += sorted(Path("development").glob("milestones/v[0-9]*/execute/step*.md"))

    for sf in step_files:
        fail(f"execute/ 파일명 위반: {sf.as_posix()} (step{{N}}.md 금지 — phase-{{N}}.md 사용)")

    if not execute_files:
        skip("Stage 6 — execute/phase-*.md 0건")
    else:
        for ef in execute_files:
            check_execute_phase(ef.as_posix(), ef)

    # v6.2+ 9-stage-flattened era — MILESTONE.md 안 H2 8 stage 섹션 추가 검증
    # bundled/legacy era milestone 안 개별 파일 검증 (Stage 1~9) 후 flattened era milestone 에 한해 H2 검증.
    H2_STAGE_MAP = [
        ("Stage 2 (flattened)", "INTENT", ["id", "title", "goal", "success_criteria", "out_of_scope"]),
        ("Stage 3 (flattened)", "RESEARCH", ["external", "codebase", "options", "risks_identified"]),
        ("Stage 4 (flattened)", "DESIGN", ["decisions", "phases"]),
        ("Stage 5 (flattened)", "APPROVE", ["approval"]),
        ("Stage 6 (flattened)", "VERIFY", ["verdict", "criteria_check"]),
        ("Stage 7 (flattened)", "REPORT", ["summary"]),
        ("Stage 8 (flattened)", "PROPOSE", ["next_candidates"]),
    ]
    flattened_dirs = [m for m in milestone_dirs if detect_era(m) == "9-stage-flattened"]
    if flattened_dirs:
        print()
        print(f"=== v6.2+ flattened era — MILESTONE.md H2 섹션 검증 ({len(flattened_dirs)}건) ===")
        for mdir in flattened_dirs:
            milestone_fp = mdir / "MILESTONE.md"
            label_prefix = f"{mdir.parent.parent.name}/{mdir.name}"
            for stage_label, h2_name, required in H2_STAGE_MAP:
                check_h2_section_fields(milestone_fp, h2_name, f"{label_prefix}#{h2_name.lower()}", required)

    # v8.1+ 4-section-lightweight era — LIGHTWEIGHT.md 4 섹션 + frontmatter 검증 (ARCHITECTURE.md § 7.4)
    # 가벼운 흐름 = 작은 건 트랙. frontmatter 4 필드 (id/title/version/status) + H2 4 섹션 (## 문제 / ## 결정 / ## 적용 / ## 기록) 존재 검증.
    LIGHTWEIGHT_SECTIONS = ["문제", "결정", "적용", "기록"]
    lightweight_dirs = [m for m in milestone_dirs if detect_era(m) == "4-section-lightweight"]
    if lightweight_dirs:
        print()
        print(f"=== v8.1+ 4-section-lightweight era — LIGHTWEIGHT.md 검증 ({len(lightweight_dirs)}건) ===")
        for mdir in lightweight_dirs:
            lw_fp = mdir / "LIGHTWEIGHT.md"
            label = f"{mdir.parent.parent.name}/{mdir.name}"
            try:
                fm, fm_err = extract_frontmatter(lw_fp)
                if fm is None:
                    fail(f"{label} — LIGHTWEIGHT.md frontmatter 부재 ({fm_err})")
                else:
                    fm_missing = [k for k in ('id', 'title', 'version', 'status') if k not in fm]
                    if fm_missing:
                        fail(f"{label} — LIGHTWEIGHT.md frontmatter 누락: {','.join(fm_missing)}")
                    elif fm.get('status') not in ('draft', 'completed'):
                        fail(f"{label} — LIGHTWEIGHT.md status '{fm.get('status')}' (draft|completed 필요)")
                    else:
                        ok(f"{label} — LIGHTWEIGHT.md frontmatter (id/title/version/status) OK")
                content = lw_fp.read_text(encoding='utf-8', errors='replace')
                missing_sec = [s for s in LIGHTWEIGHT_SECTIONS
                               if not re.search(rf'^## {re.escape(s)}\s*$', content, re.MULTILINE)]
                if missing_sec:
                    fail(f"{label} — LIGHTWEIGHT.md H2 섹션 누락: {','.join('## ' + s for s in missing_sec)}")
                else:
                    ok(f"{label} — LIGHTWEIGHT.md 4 섹션 (## 문제 / ## 결정 / ## 적용 / ## 기록) OK")
            except Exception as e:
                fail(f"{label} — LIGHTWEIGHT.md unexpected: {e}")

    print()
    print(f"=== 결과: PASS={PASS} FAIL={FAIL} SKIP={SKIP} ===")
    return 0 if FAIL == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
PYEOF
exit $?

#!/usr/bin/env python3
"""
AI-Ready Codebase Scorer
코드베이스 AI 준비도 100점 루브릭 평가 스크립트

Usage:
    python score_codebase.py <repo_path> [--output-dir DIR] [--gate N] [--json-only]

Exit codes:
    0  정상 완료 (--gate 미지정 또는 점수 통과)
    1  --gate 점수 미달
    2  유효하지 않은 리포지토리 경로

v1.18g (2026-04-29): 1335줄 → 5 모듈 분할.
- utils.py — dataclasses + GRADE_MAP + grade/pct + 13 helpers
- categories_quality.py — documentation/code_structure/type_safety/test_quality
- categories_ops.py — context_layer/automation/agentic_safety + compute_roi_actions
- html_renderer.py — generate_html
- score_codebase.py (본 파일) — entrypoint + run_audit + main
"""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import asdict
from pathlib import Path

from categories_ops import (
    compute_roi_actions,
    score_agentic_safety,
    score_automation,
    score_context_layer,
)
from categories_quality import (
    score_code_structure,
    score_documentation,
    score_test_quality,
    score_type_safety,
)
from html_renderer import generate_html
from utils import (
    AuditReport,
    CategoryResult,
    detect_language,
    git_branch,
    git_tracked_files,
    grade,
)


# ── 카테고리 메타 (run_audit iter 순서) ───────────────────────────────────────
CATEGORY_META = [
    {"id": "documentation",  "name_ko": "문서화",           "max": 15},
    {"id": "code_structure",  "name_ko": "코드 구조",        "max": 15},
    {"id": "type_safety",     "name_ko": "타입 안전성",      "max": 15},
    {"id": "test_quality",    "name_ko": "테스트 품질",      "max": 15},
    {"id": "context_layer",   "name_ko": "컨텍스트 레이어", "max": 15},
    {"id": "automation",      "name_ko": "자동화",           "max": 15},
    {"id": "agentic_safety",  "name_ko": "에이전틱 안전",   "max": 10},
]


# ── 메인 ─────────────────────────────────────────────────────────────────────
def run_audit(repo_path: Path, output_dir: Path) -> AuditReport:
    tracked = git_tracked_files(repo_path)
    lang = detect_language(repo_path, tracked)

    scorers = [
        ("documentation",  score_documentation),
        ("code_structure",  score_code_structure),
        ("type_safety",     score_type_safety),
        ("test_quality",    score_test_quality),
        ("context_layer",   score_context_layer),
        ("automation",      score_automation),
        ("agentic_safety",  score_agentic_safety),
    ]

    cat_results: list[CategoryResult] = []
    total_score = 0.0

    for meta, scorer_fn in zip(CATEGORY_META, [s[1] for s in scorers]):
        checks_raw = scorer_fn(repo_path, tracked, lang)
        cat_score = min(sum(c.score for c in checks_raw), meta["max"])
        g, col = grade(cat_score, meta["max"])
        top_actions = [
            {"check": c.name, "action": c.action, "effort": c.roi_effort,
             "recoverable": c.max_score - c.score}
            for c in checks_raw if not c.passed and c.action
        ][:3]
        checks_dict = [asdict(c) for c in checks_raw]
        cat_results.append(CategoryResult(
            id=meta["id"], name_ko=meta["name_ko"],
            score=cat_score, max_score=meta["max"],
            grade=g, color=col,
            checks=checks_dict, top_actions=top_actions
        ))
        total_score += cat_score

    total_score = round(min(total_score, 100), 1)
    g, col = grade(total_score, 100)
    roi = compute_roi_actions(cat_results)

    report = AuditReport(
        repo_path=str(repo_path),
        repo_name=repo_path.name,
        language=lang,
        total_score=total_score,
        percentage=round(total_score, 1),
        grade=g,
        color=col,
        categories=[asdict(c) for c in cat_results],
        roi_actions=roi,
        git_branch=git_branch(repo_path),
        file_count=len(tracked),
    )
    return report


def main() -> None:
    # Windows cp949 default 환경에서 emoji + 한국어 출력 안전 보장 (v1.18d).
    # stdout/stderr 모두 UTF-8 + errors='replace' fallback (encode 불가 문자 → '?').
    # Linux/macOS는 이미 UTF-8 default → reconfigure no-op.
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8", errors="replace")
            except (AttributeError, ValueError, OSError):
                pass

    parser = argparse.ArgumentParser(description="AI-Ready Codebase Scorer")
    parser.add_argument("repo", nargs="?", default=".", help="리포지토리 경로")
    parser.add_argument("--output-dir", default=None, help="출력 디렉토리 (기본: 리포 루트)")
    parser.add_argument("--gate", type=float, default=None, help="최소 점수 (미달 시 exit 1)")
    parser.add_argument("--json-only", action="store_true", help="JSON만 생성 (HTML 생략)")
    args = parser.parse_args()

    repo = Path(args.repo).resolve()
    if not repo.is_dir():
        print(f"ERROR: 유효하지 않은 경로 — {repo}", file=sys.stderr)
        sys.exit(2)

    output_dir = Path(args.output_dir).resolve() if args.output_dir else repo
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"🔍 분석 중: {repo.name} ({repo})", file=sys.stderr)
    report = run_audit(repo, output_dir)
    report_dict = asdict(report)

    json_path = output_dir / "ai-ready-report.json"
    json_path.write_text(json.dumps(report_dict, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"✅ JSON: {json_path}", file=sys.stderr)

    if not args.json_only:
        html_path = output_dir / "ai-ready-dashboard.html"
        generate_html(report_dict, html_path)
        print(f"✅ HTML: {html_path}", file=sys.stderr)

    # 콘솔 요약
    g_emoji = {"S": "🏆", "A": "⭐", "B": "✅", "C": "⚠️", "D": "🔴"}.get(report.grade, "")
    print(f"\n{'='*50}")
    print(f"  {g_emoji} AI-Ready 점수: {report.total_score:.0f}/100  등급: {report.grade}")
    print(f"{'='*50}")
    for c in report_dict["categories"]:
        bar = "█" * int(c["score"] / c["max_score"] * 10) + "░" * (10 - int(c["score"] / c["max_score"] * 10))
        print(f"  {c['name_ko']:12s} {bar} {c['score']:.0f}/{c['max_score']} [{c['grade']}]")
    print(f"{'='*50}")

    if report.roi_actions:
        print("\n🚀 ROI TOP 5 액션:")
        for i, a in enumerate(report.roi_actions[:5], 1):
            print(f"  {i}. [{a['effort']}/+{a['recoverable_score']:.0f}점] {a['action'][:70]}")

    print()
    # stdout에 JSON 경로 출력 (스킬 파이프라인용)
    print(json.dumps({"json": str(json_path),
                      "html": str(output_dir / "ai-ready-dashboard.html"),
                      "score": report.total_score,
                      "grade": report.grade}, ensure_ascii=False))

    if args.gate is not None and report.total_score < args.gate:
        print(f"\n❌ GATE FAIL: {report.total_score:.0f} < {args.gate}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()

"""categories_documentation.py — 문서화 카테고리

score_documentation: README / CLAUDE.md / 아키텍처 문서 / Docstring / Changelog.
v1.56-quality-file-split에서 categories_quality.py 분할.
"""

from __future__ import annotations

from pathlib import Path

from utils import (
    Check,
    count_docstrings_python,
    count_lines,
    file_exists_any,
    is_shell_markdown_only_repo,
)


def score_documentation(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)

    # README
    exists, fname = file_exists_any(repo, ["README.md", "README.rst", "README.txt", "README"])
    if exists:
        lines = count_lines(repo / fname)
        if lines >= 50:
            checks.append(Check("README (충분한 내용)", True, 3, 3,
                                f"{fname} — {lines}줄"))
        else:
            checks.append(Check("README (충분한 내용)", False, 1, 3,
                                f"{fname} — {lines}줄 (50줄 미만)",
                                "README를 50줄 이상으로 보강 (설치·사용법·아키텍처 개요 포함)",
                                "즉시", 2.0))
    else:
        checks.append(Check("README 존재", False, 0, 3,
                            "README 파일 없음",
                            "README.md 생성 (프로젝트 개요·설치·사용법 포함)",
                            "즉시", 2.5))

    # CLAUDE.md / AGENTS.md
    exists, fname = file_exists_any(repo, ["CLAUDE.md", "AGENTS.md", ".claude/CLAUDE.md"])
    checks.append(Check(
        "CLAUDE.md / AGENTS.md",
        exists, 3 if exists else 0, 3,
        f"발견: {fname}" if exists else "없음 — AI 에이전트 행동 가이드 부재",
        None if exists else "CLAUDE.md 생성 (아키텍처 규칙·금지 명령·개발 프로세스 포함)",
        "즉시", 3.0
    ))

    # Architecture / ADR 문서 (v1.35 N/A)
    arch_patterns = ["ARCHITECTURE.md", "docs/ARCHITECTURE.md", "docs/core/ARCHITECTURE.md",
                     "ADR.md", "docs/ADR.md", "docs/adr/", "doc/architecture"]
    exists, fname = file_exists_any(repo, arch_patterns)
    if not exists and na_repo:
        checks.append(Check(
            "아키텍처 문서",
            passed=True, score=3, max_score=3,
            detail="N/A — shell/markdown-only repo (아키텍처 문서 부적합, 자동 만점)",
            action=None,
            roi_effort="단기", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "아키텍처 문서",
            exists, 3 if exists else 0, 3,
            f"발견: {fname}" if exists else "아키텍처 문서 없음",
            None if exists else "docs/ARCHITECTURE.md 또는 ADR 디렉토리 생성",
            "단기", 2.0
        ))

    # Docstring coverage (Python)
    if lang == "Python":
        py_files = [f for f in tracked if f.suffix == ".py" and f.is_file()]
        with_doc, total = count_docstrings_python(py_files)
        ratio = with_doc / total if total else 0
        score = 3 if ratio >= 0.4 else (2 if ratio >= 0.2 else (1 if ratio > 0 else 0))
        checks.append(Check(
            "Docstring 커버리지",
            ratio >= 0.2, score, 3,
            f"{with_doc}/{total} 함수/클래스 ({ratio:.0%})",
            None if ratio >= 0.2 else "public 함수·클래스에 one-line docstring 추가 (AI 코드 이해 품질 향상)",
            "단기", 1.5
        ))
    elif na_repo:
        checks.append(Check(
            "Docstring / JSDoc 커버리지",
            passed=True, score=3, max_score=3,
            detail="N/A — shell/markdown-only repo (docstring 부적합, 자동 만점)",
            action=None,
            roi_effort="단기", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check("Docstring / JSDoc 커버리지", True, 2, 3,
                            f"{lang} — 자동 측정 skip (부분 점수)", None))

    # Changelog (v1.35 N/A)
    exists, fname = file_exists_any(repo, ["CHANGELOG.md", "CHANGELOG", "HISTORY.md", "CHANGES.md"])
    if not exists and na_repo:
        checks.append(Check(
            "Changelog",
            passed=True, score=1, max_score=1,
            detail="N/A — shell/markdown-only repo (changelog 부적합, 자동 만점)",
            action=None,
            roi_effort="단기", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "Changelog",
            exists, 1 if exists else 0, 1,
            f"발견: {fname}" if exists else "없음",
            None if exists else "CHANGELOG.md 생성 (conventional commits 기반 자동 생성 가능)",
            "단기", 1.0
        ))

    return checks

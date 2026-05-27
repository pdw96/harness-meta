"""categories_test_quality.py — 테스트 품질 카테고리

score_test_quality: 테스트 디렉토리 / 파일 수 / 프레임워크 / 커버리지 / 통합 테스트 / 비율 / CI.
v1.56-quality-file-split에서 categories_quality.py 분할.
"""

from __future__ import annotations

import re
from pathlib import Path

from utils import (
    Check,
    file_content,
    file_exists_any,
    is_shell_markdown_only_repo,
    is_small_typed_lang_repo,
)


def score_test_quality(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)
    small_typed_repo = is_small_typed_lang_repo(repo, tracked, lang)

    # tests 디렉토리 (v1.35 N/A)
    has_tests, tdir = file_exists_any(repo, ["tests/", "test/", "__tests__/", "spec/"])
    test_files = [
        f for f in tracked
        if f.is_file() and (
            f.name.startswith("test_") or f.name.endswith("_test.py")
            or "_test." in f.name or f.name.startswith("test.") or "spec." in f.name
            # Shell smoke/integration tests in tests/ directory
            or (f.suffix == ".sh" and any(seg in f.parts for seg in ("test", "tests")))
        )
    ]
    if not (has_tests or test_files) and na_repo:
        checks.append(Check(
            "테스트 디렉토리 존재",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (단위 테스트 부적합, 자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "테스트 디렉토리 존재",
            has_tests or bool(test_files), 2 if (has_tests or test_files) else 0, 2,
            f"테스트 파일 {len(test_files)}개" + (f" ({tdir})" if has_tests else ""),
            None if (has_tests or test_files) else "tests/ 디렉토리 생성 및 테스트 파일 추가",
            "즉시", 3.0
        ))

    # 테스트 파일 수 (v1.35 N/A)
    count = len(test_files)
    if count < 5 and na_repo:
        checks.append(Check(
            "테스트 파일 수 (≥15)",
            passed=True, score=3, max_score=3,
            detail="N/A — shell/markdown-only repo (테스트 파일 부적합, 자동 만점)",
            action=None,
            roi_effort="중기", roi_impact=0.0,
            na=True,
        ))
    else:
        score = 3 if count >= 15 else (2 if count >= 5 else (1 if count >= 1 else 0))
        checks.append(Check(
            "테스트 파일 수 (≥15)",
            count >= 5, score, 3,
            f"{count}개 테스트 파일",
            None if count >= 5 else "핵심 비즈니스 로직 단위 테스트 추가 (TDD 권장)",
            "중기", 2.5
        ))

    # 테스트 프레임워크 설정
    if lang == "Python":
        pytest_conf, fname = file_exists_any(repo, [
            "pytest.ini", "pyproject.toml", "setup.cfg", "conftest.py"
        ])
        has_pytest = False
        if pytest_conf:
            content = file_content(repo / fname)
            has_pytest = "pytest" in content
        if not has_pytest and small_typed_repo:
            checks.append(Check(
                "pytest 설정",
                passed=True, score=2, max_score=2,
                detail="N/A — Python 소스 5개 미만 (pytest 설정 부적합, 자동 만점)",
                action=None,
                roi_effort="즉시", roi_impact=0.0,
                na=True,
            ))
        else:
            checks.append(Check(
                "pytest 설정",
                has_pytest, 2 if has_pytest else 0, 2,
                "pytest 설정 있음" if has_pytest else "pytest 설정 없음",
                None if has_pytest else "pyproject.toml에 [tool.pytest.ini_options] 추가",
                "즉시", 1.5
            ))
    else:
        checks.append(Check("테스트 프레임워크 설정", True, 2, 2,
                            f"{lang} — skip (부분 점수)", None))

    # Coverage 설정 (v1.35 N/A)
    cov_conf, fname = file_exists_any(repo, [
        ".coveragerc", "pyproject.toml", ".nycrc", "jest.config.js",
        "jest.config.ts", "coverage.json"
    ])
    has_cov = False
    if cov_conf:
        content = file_content(repo / fname)
        has_cov = "coverage" in content.lower() or "cov" in content.lower()
    if not has_cov and na_repo:
        checks.append(Check(
            "커버리지 설정",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (커버리지 부적합, 자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "커버리지 설정",
            has_cov, 2 if has_cov else 0, 2,
            "커버리지 설정 있음" if has_cov else "없음",
            None if has_cov else "pyproject.toml에 [tool.coverage] 또는 .coveragerc 추가 (목표: 70%+)",
            "즉시", 1.5
        ))

    # 통합 테스트 (v1.35 N/A)
    int_test, fname = file_exists_any(repo, [
        "tests/integration/", "tests/e2e/", "tests/int/",
        "test/integration/", "e2e/", "integration/"
    ])
    if not int_test and na_repo:
        checks.append(Check(
            "통합 테스트",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (통합 테스트 부적합, 자동 만점)",
            action=None,
            roi_effort="중기", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "통합 테스트",
            int_test, 2 if int_test else 0, 2,
            f"발견: {fname}" if int_test else "통합 테스트 없음",
            None if int_test else "tests/integration/ 디렉토리에 주요 플로우 통합 테스트 추가",
            "중기", 2.0
        ))

    # 테스트/소스 비율 — shell/script repo도 올바르게 측정하기 위해 source_exts 분리
    source_exts = {
        ".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java",
        ".sh", ".bash", ".ps1", ".zsh",  # shell/script repo 지원
        ".rb", ".swift", ".kt", ".cs",   # 기존 누락 언어 보완
    }
    source_files = [
        f for f in tracked
        if f.suffix in source_exts and f.is_file()
        and not any(seg in f.parts for seg in ("test", "tests", "__tests__", "spec"))
    ]
    ratio = len(test_files) / len(source_files) if source_files else 0
    score = 2 if ratio >= 0.3 else (1 if ratio >= 0.1 else 0)
    if ratio < 0.1 and na_repo:
        checks.append(Check(
            "테스트/소스 비율 (≥0.3)",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (테스트/소스 비율 부적합, 자동 만점)",
            action=None,
            roi_effort="중기", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "테스트/소스 비율 (≥0.3)",
            ratio >= 0.1, score, 2,
            f"{ratio:.2f} ({len(test_files)}테스트 / {len(source_files)}소스)",
            None if ratio >= 0.1 else "소스 파일 대비 30% 이상 테스트 파일 확보",
            "중기", 2.0
        ))

    # CI에서 테스트 실행
    # Use as_posix() for cross-platform path matching (Windows uses backslashes in str())
    ci_files = [f for f in tracked if ".github/workflows" in f.as_posix() or ".gitlab-ci" in f.as_posix()]
    ci_text = "\n".join(file_content(f) for f in ci_files)
    ci_runs_tests = "test" in ci_text.lower()

    precommit = repo / ".pre-commit-config.yaml"
    precommit_smokes: set[str] = set()
    if precommit.exists():
        precommit_text = file_content(precommit)
        precommit_smokes = set(re.findall(r"entry:\s+(?:bash\s+)?(tests/smoke-[\w-]+\.sh)", precommit_text))
    ci_smokes = set(re.findall(r"tests/smoke-[\w-]+\.sh", ci_text))
    missing_ci_smokes = sorted(precommit_smokes - ci_smokes)
    if precommit_smokes:
        ci_runs_tests = ci_runs_tests and not missing_ci_smokes

    if not ci_runs_tests and na_repo:
        checks.append(Check(
            "CI 테스트 자동화",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (CI 테스트 자동화 부적합, 자동 만점)",
            action=None,
            roi_effort="단기", roi_impact=0.0,
            na=True,
        ))
    else:
        detail = "CI에서 테스트 실행 중"
        action = None
        if missing_ci_smokes:
            detail = f"CI smoke 누락: {', '.join(missing_ci_smokes[:3])}"
            if len(missing_ci_smokes) > 3:
                detail += f" 외 {len(missing_ci_smokes) - 3}개"
            action = ".github/workflows/ci.yml ACTIVE_SMOKES를 .pre-commit-config.yaml smoke hook 목록과 동기화"
        checks.append(Check(
            "CI 테스트 자동화",
            ci_runs_tests, 2 if ci_runs_tests else 0, 2,
            detail if ci_runs_tests or missing_ci_smokes else "CI 테스트 없음",
            action if missing_ci_smokes else (None if ci_runs_tests else "GitHub Actions에 pytest / npm test 단계 추가"),
            "단기", 2.5
        ))

    return checks

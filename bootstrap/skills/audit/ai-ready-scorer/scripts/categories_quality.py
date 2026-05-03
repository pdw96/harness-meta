"""categories_quality.py — 정적 품질 카테고리 4종

documentation / code_structure / type_safety / test_quality.
v1.18g-score-codebase-py-split에서 추출.

의존: utils (Check + 6 helpers).
"""

from __future__ import annotations

from pathlib import Path

from utils import (
    Check,
    count_docstrings_python,
    count_lines,
    file_content,
    file_exists_any,
    is_shell_markdown_only_repo,
    is_small_typed_lang_repo,
    python_type_hint_ratio,
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


def score_code_structure(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)

    # src / tests 분리
    _src_dirs = ["src", "lib", "bot", "app", "pkg", "scripts", "cmd", "internal"]
    _shell_exts = {".sh", ".bash", ".ps1", ".zsh"}
    _shell_source_in_subdir = any(
        f.parent != repo
        and not any(seg in f.parts for seg in ("test", "tests"))
        for f in tracked
        if f.suffix in _shell_exts and f.is_file()
    )
    has_src = any((repo / d).is_dir() for d in _src_dirs) or _shell_source_in_subdir
    has_tests = any((repo / d).is_dir() for d in ["tests", "test", "__tests__", "spec"])
    checks.append(Check(
        "소스/테스트 디렉토리 분리",
        has_src and has_tests,
        3 if (has_src and has_tests) else (1 if (has_src or has_tests) else 0), 3,
        f"src계: {'✓' if has_src else '✗'}, tests계: {'✓' if has_tests else '✗'}",
        None if (has_src and has_tests) else "소스 코드를 src/ 또는 명명된 패키지로, 테스트를 tests/로 분리",
        "단기", 2.0
    ))

    # 파일 크기 (god file 체크)
    code_exts = {".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs", ".java", ".kt", ".cs"}
    large_files = [
        f for f in tracked
        if f.suffix in code_exts and f.is_file() and count_lines(f) > 500
    ]
    score = 3 if not large_files else (2 if len(large_files) <= 2 else (1 if len(large_files) <= 5 else 0))
    checks.append(Check(
        "파일 크기 적정 (≤500줄)",
        len(large_files) <= 2, score, 3,
        f"500줄 초과 파일: {len(large_files)}개" + (
            f" ({', '.join(f.name for f in large_files[:3])})" if large_files else ""
        ),
        None if not large_files else "God file을 책임별 모듈로 분리 (AI가 단일 파일 전체를 이해하기 어려움)",
        "중기", 2.0
    ))

    # Config 분리
    config_exists, fname = file_exists_any(repo, [
        "config/", "config.py", "config/settings.py", "configs/", "settings.py",
        "config.ts", "config.js", ".env.example", "config.yaml", "config.toml"
    ])
    if not config_exists and na_repo:
        checks.append(Check(
            "설정 분리 (config/settings)",
            passed=True, score=3, max_score=3,
            detail="N/A — shell/markdown-only repo (설정 파일 부적합, 자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "설정 분리 (config/settings)",
            config_exists, 3 if config_exists else 0, 3,
            f"발견: {fname}" if config_exists else "설정이 코드에 혼재 가능",
            None if config_exists else "config/settings.py (또는 해당 언어 관례)로 환경변수·설정 중앙화",
            "단기", 1.5
        ))

    # 빌드/패키지 매니페스트
    manifest, fname = file_exists_any(repo, [
        "pyproject.toml", "package.json", "go.mod", "Cargo.toml",
        "pom.xml", "build.gradle", "setup.py", "setup.cfg"
    ])
    if not manifest and na_repo:
        checks.append(Check(
            "패키지 매니페스트",
            passed=True, score=3, max_score=3,
            detail="N/A — shell/markdown-only repo (의존성 매니페스트 부적합, 자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "패키지 매니페스트",
            manifest, 3 if manifest else 0, 3,
            f"발견: {fname}" if manifest else "의존성 관리 파일 없음",
            None if manifest else "pyproject.toml / package.json 등 의존성 매니페스트 추가",
            "즉시", 1.5
        ))

    # 모듈 수 (너무 많은 파일이 루트에 있는지)
    root_code_files = [f for f in repo.iterdir() if f.suffix in code_exts and f.is_file()]
    too_flat = len(root_code_files) > 8
    checks.append(Check(
        "루트 평탄화 방지",
        not too_flat,
        1 if not too_flat else 0, 1,
        f"루트 코드 파일: {len(root_code_files)}개 ({'과다' if too_flat else '적정'})",
        None if not too_flat else "루트 코드 파일을 패키지·모듈 디렉토리로 정리",
        "단기", 1.0
    ))

    return checks


def score_type_safety(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []
    small_repo = is_small_typed_lang_repo(repo, tracked, lang)

    if lang == "Python":
        py_files = [f for f in tracked if f.suffix == ".py" and f.is_file()]
        ratio = python_type_hint_ratio(py_files)
        score = 5 if ratio >= 0.7 else (3 if ratio >= 0.4 else (1 if ratio > 0.1 else 0))
        if not (ratio >= 0.4) and small_repo:
            checks.append(Check(
                "타입 힌트 커버리지",
                True, 5, 5,
                "N/A — Python 소스 5개 미만 (타입 힌트 부적합, 자동 만점)",
                None, "즉시", 2.5, na=True
            ))
        else:
            checks.append(Check(
                "타입 힌트 커버리지",
                ratio >= 0.4, score, 5,
                f"함수 {ratio:.0%} 타입 힌트 보유",
                None if ratio >= 0.4 else "모든 public 함수에 인자·반환 타입 힌트 추가 (mypy strict 권장)",
                "중기", 2.5
            ))

        # mypy / pyright 설정
        mypy_conf, fname = file_exists_any(repo, [
            "mypy.ini", ".mypy.ini", "pyproject.toml"
        ])
        mypy_active = False
        if mypy_conf:
            content = file_content(repo / fname)
            mypy_active = "[mypy]" in content or "mypy" in content.lower()
        if not mypy_active and small_repo:
            checks.append(Check(
                "mypy / pyright 설정",
                True, 3, 3,
                "N/A — Python 소스 5개 미만 (정적 타입 체크 부적합, 자동 만점)",
                None, "즉시", 2.0, na=True
            ))
        else:
            checks.append(Check(
                "mypy / pyright 설정",
                mypy_active, 3 if mypy_active else 0, 3,
                "설정 있음" if mypy_active else "정적 타입 체크 미설정",
                None if mypy_active else "pyproject.toml에 [tool.mypy] strict 설정 추가",
                "즉시", 2.0
            ))

        # pydantic / dataclass / TypedDict
        schema_patterns = ["pydantic", "dataclass", "TypedDict", "attrs", "msgspec"]
        schema_found = any(
            any(p in file_content(f) for p in schema_patterns)
            for f in py_files[:50]
        )
        if not schema_found and small_repo:
            checks.append(Check(
                "스키마 정의 (Pydantic/dataclass)",
                True, 4, 4,
                "N/A — Python 소스 5개 미만 (스키마 정의 부적합, 자동 만점)",
                None, "단기", 2.0, na=True
            ))
        else:
            checks.append(Check(
                "스키마 정의 (Pydantic/dataclass)",
                schema_found, 4 if schema_found else 0, 4,
                "스키마 라이브러리 사용 중" if schema_found else "구조화된 데이터 모델 미사용",
                None if schema_found else "API 입출력·설정·이벤트에 Pydantic 모델 또는 dataclass 적용",
                "단기", 2.0
            ))

        # Protocol / ABC
        protocol_found = any("Protocol" in file_content(f) or "ABC" in file_content(f) for f in py_files[:50])
        if not protocol_found and small_repo:
            checks.append(Check(
                "인터페이스 정의 (Protocol/ABC)",
                True, 3, 3,
                "N/A — Python 소스 5개 미만 (인터페이스 정의 부적합, 자동 만점)",
                None, "중기", 1.5, na=True
            ))
        else:
            checks.append(Check(
                "인터페이스 정의 (Protocol/ABC)",
                protocol_found, 3 if protocol_found else 0, 3,
                "Protocol/ABC 사용 중" if protocol_found else "인터페이스 계약 미정의",
                None if protocol_found else "모듈 경계에 Protocol 또는 ABC로 인터페이스 계약 정의",
                "중기", 1.5
            ))

    elif lang in ("TypeScript",):
        # tsconfig
        tsconfig, fname = file_exists_any(repo, ["tsconfig.json", "tsconfig.base.json"])
        if not tsconfig and small_repo:
            checks.append(Check("tsconfig.json (strict)", True, 5, 5,
                                "N/A — TypeScript 소스 5개 미만 (tsconfig 부적합, 자동 만점)",
                                None, "즉시", 2.5, na=True))
        else:
            checks.append(Check("tsconfig.json (strict)", tsconfig, 5 if tsconfig else 0, 5,
                                f"발견: {fname}" if tsconfig else "없음",
                                None if tsconfig else "tsconfig.json strict 모드 활성화",
                                "즉시", 2.5))
        # zod / io-ts
        ts_files = [f for f in tracked if f.suffix in {".ts", ".tsx"} and f.is_file()]
        schema = any("zod" in file_content(f) or "io-ts" in file_content(f) for f in ts_files[:50])
        if not schema and small_repo:
            checks.append(Check("런타임 스키마 (zod/io-ts)", True, 7, 7,
                                "N/A — TypeScript 소스 5개 미만 (런타임 스키마 부적합, 자동 만점)",
                                None, "단기", 2.0, na=True))
        else:
            checks.append(Check("런타임 스키마 (zod/io-ts)", schema, 7 if schema else 0, 7,
                                "런타임 검증 라이브러리 사용 중" if schema else "런타임 타입 검증 없음",
                                None if schema else "경계 레이어(API/외부입력)에 zod 스키마 적용",
                                "단기", 2.0))
        checks.append(Check("타입 시스템 상세 분석", True, 3, 3,
                            "TypeScript — 기본 점수 부여", None))

    else:
        checks.append(Check(
            f"{lang} 타입 시스템",
            True, 10, 15,
            f"{lang} — 정적 분석 skip (부분 점수 부여)", None
        ))
        checks.append(Check("스키마 정의", True, 5, 5,
                            f"{lang} — 부분 점수 부여", None))

    return checks


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
    ci_runs_tests = any("test" in file_content(f).lower() for f in ci_files)
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
        checks.append(Check(
            "CI 테스트 자동화",
            ci_runs_tests, 2 if ci_runs_tests else 0, 2,
            "CI에서 테스트 실행 중" if ci_runs_tests else "CI 테스트 없음",
            None if ci_runs_tests else "GitHub Actions에 pytest / npm test 단계 추가",
            "단기", 2.5
        ))

    return checks

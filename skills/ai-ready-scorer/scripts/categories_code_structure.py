"""categories_code_structure.py — 코드 구조 카테고리

score_code_structure: src/tests 분리 / 파일 크기 / 설정 분리 / 패키지 매니페스트 / 루트 평탄화.
v1.56-quality-file-split에서 categories_quality.py 분할.
"""

from __future__ import annotations

from pathlib import Path

from utils import (
    Check,
    count_lines,
    file_exists_any,
    is_shell_markdown_only_repo,
)


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

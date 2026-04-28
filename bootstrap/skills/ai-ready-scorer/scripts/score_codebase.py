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
"""

from __future__ import annotations

import argparse
import ast
import json
import os
import re
import subprocess
import sys
from dataclasses import asdict, dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Optional

# ── 등급 임계값 ──────────────────────────────────────────────────────────────
GRADE_MAP = [
    (90, "S", "#10b981"),
    (75, "A", "#3b82f6"),
    (60, "B", "#8b5cf6"),
    (45, "C", "#f59e0b"),
    (0,  "D", "#ef4444"),
]

CATEGORY_META = [
    {"id": "documentation",  "name_ko": "문서화",           "max": 15},
    {"id": "code_structure",  "name_ko": "코드 구조",        "max": 15},
    {"id": "type_safety",     "name_ko": "타입 안전성",      "max": 15},
    {"id": "test_quality",    "name_ko": "테스트 품질",      "max": 15},
    {"id": "context_layer",   "name_ko": "컨텍스트 레이어", "max": 15},
    {"id": "automation",      "name_ko": "자동화",           "max": 15},
    {"id": "agentic_safety",  "name_ko": "에이전틱 안전",   "max": 10},
]


# ── 데이터 클래스 ─────────────────────────────────────────────────────────────
@dataclass
class Check:
    name: str
    passed: bool
    score: float
    max_score: float
    detail: str
    action: Optional[str] = None
    roi_effort: str = "즉시"     # 즉시 / 단기 / 중기
    roi_impact: float = 1.0     # AI 생산성 영향 가중치 (1~3)
    na: bool = False             # N/A (체크 부적합 — 자동 만점). HTML icon ℹ️


@dataclass
class CategoryResult:
    id: str
    name_ko: str
    score: float
    max_score: int
    grade: str
    color: str
    checks: list[dict]
    top_actions: list[dict]


@dataclass
class AuditReport:
    repo_path: str
    repo_name: str
    language: str
    total_score: float
    max_score: int = 100
    percentage: float = 0.0
    grade: str = "D"
    color: str = "#ef4444"
    categories: list[dict] = field(default_factory=list)
    roi_actions: list[dict] = field(default_factory=list)
    generated_at: str = field(default_factory=lambda: datetime.now().isoformat())
    git_branch: str = ""
    file_count: int = 0


# ── 유틸리티 ──────────────────────────────────────────────────────────────────
def grade(score: float, max_score: int) -> tuple[str, str]:
    pct = (score / max_score * 100) if max_score else 0
    for threshold, g, color in GRADE_MAP:
        if pct >= threshold:
            return g, color
    return "D", "#ef4444"


def pct(score: float, max_score: int) -> float:
    return round(score / max_score * 100, 1) if max_score else 0.0


def git_tracked_files(repo: Path) -> list[Path]:
    try:
        result = subprocess.run(
            ["git", "-C", str(repo), "ls-files"],
            capture_output=True, text=True, timeout=15
        )
        if result.returncode != 0:
            return []
        return [repo / p for p in result.stdout.splitlines() if p]
    except Exception:
        return list(repo.rglob("*"))


def detect_language(repo: Path, tracked: list[Path]) -> str:
    exts: dict[str, int] = {}
    for f in tracked:
        if f.suffix:
            exts[f.suffix.lower()] = exts.get(f.suffix.lower(), 0) + 1
    lang_map = {
        ".py": "Python", ".ts": "TypeScript", ".tsx": "TypeScript",
        ".js": "JavaScript", ".jsx": "JavaScript", ".go": "Go",
        ".rs": "Rust", ".java": "Java", ".kt": "Kotlin",
        ".cs": "C#", ".rb": "Ruby", ".swift": "Swift",
    }
    if not exts:
        return "Unknown"
    dominant = max(exts, key=lambda k: exts[k])
    return lang_map.get(dominant, dominant.lstrip(".").capitalize())


def file_exists_any(repo: Path, candidates: list[str]) -> tuple[bool, str]:
    for c in candidates:
        p = repo / c
        if p.exists():
            return True, c
    return False, ""


def count_lines(path: Path) -> int:
    try:
        return len(path.read_text(encoding="utf-8", errors="ignore").splitlines())
    except Exception:
        return 0


def file_content(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8", errors="ignore")
    except Exception:
        return ""


def git_branch(repo: Path) -> str:
    try:
        r = subprocess.run(
            ["git", "-C", str(repo), "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True, text=True, timeout=5
        )
        return r.stdout.strip() if r.returncode == 0 else ""
    except Exception:
        return ""


def is_env_committed(repo: Path) -> bool:
    try:
        r = subprocess.run(
            ["git", "-C", str(repo), "ls-files", ".env"],
            capture_output=True, text=True, timeout=5
        )
        return bool(r.stdout.strip())
    except Exception:
        return False


def python_type_hint_ratio(py_files: list[Path]) -> float:
    """Python 함수 중 반환 타입 또는 인자 타입 힌트가 있는 비율."""
    total = annotated = 0
    for f in py_files[:80]:  # 성능 상한
        try:
            tree = ast.parse(f.read_text(encoding="utf-8", errors="ignore"))
        except Exception:
            continue
        for node in ast.walk(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                total += 1
                has_return = node.returns is not None
                has_args = any(
                    a.annotation for a in node.args.args + node.args.posonlyargs
                )
                if has_return or has_args:
                    annotated += 1
    return annotated / total if total else 0.0


def count_docstrings_python(py_files: list[Path]) -> tuple[int, int]:
    """(docstring 있는 함수, 전체 함수) 반환."""
    total = with_doc = 0
    for f in py_files[:80]:
        try:
            tree = ast.parse(f.read_text(encoding="utf-8", errors="ignore"))
        except Exception:
            continue
        for node in ast.walk(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
                total += 1
                if (node.body and isinstance(node.body[0], ast.Expr)
                        and isinstance(node.body[0].value, ast.Constant)
                        and isinstance(node.body[0].value.value, str)):
                    with_doc += 1
    return with_doc, total


_BUILD_LANGS = {
    "Python", "TypeScript", "JavaScript", "Go", "Rust",
    "Java", "Kotlin", "C#", "Ruby", "Swift",
}
_BUILD_MANIFESTS = [
    "package.json", "Cargo.toml", "go.mod",
    "build.gradle", "build.gradle.kts", "pom.xml",
]
_BUILD_SOURCE_EXTS = {
    ".py", ".ts", ".tsx", ".js", ".jsx", ".go", ".rs",
    ".java", ".kt", ".cs", ".rb", ".swift",
}


def _pyproject_runtime_deps_empty(pyproject_path: Path) -> bool:
    """pyproject.toml의 runtime 의존성이 비어있는가?

    tomllib(3.11+) 우선 + regex fallback. dev/coverage/lint 등 도구 의존성은 검사 대상 아님.
    """
    if not pyproject_path.is_file():
        return True
    try:
        import tomllib  # py311+
        with pyproject_path.open("rb") as fh:
            data = tomllib.load(fh)
        project_deps = data.get("project", {}).get("dependencies") or []
        if project_deps:
            return False
        poetry_deps = (
            data.get("tool", {}).get("poetry", {}).get("dependencies") or {}
        )
        non_python = [k for k in poetry_deps if k.lower() != "python"]
        return len(non_python) == 0
    except Exception:
        # regex fallback
        content = file_content(pyproject_path)
        m = re.search(r'\[project\][\s\S]*?dependencies\s*=\s*\[\s*[^\s\]]', content)
        if m:
            return False
        m = re.search(r'\[tool\.poetry\.dependencies\]\s*\n([\s\S]*?)(?=\n\[|\Z)', content)
        if m:
            body = m.group(1)
            for ln in body.splitlines():
                s = ln.strip()
                if not s or s.startswith("#"):
                    continue
                if s.lower().startswith("python "):
                    continue
                if s.lower().startswith("python="):
                    continue
                return False
        return True


def is_shell_markdown_only_repo(repo: Path, tracked: list[Path], lang: str) -> bool:
    """repo가 컨테이너화/lock 파일 모두 부적합한 패턴인가? (4 조건 AND)

    1. lang ∉ build-language 화이트리스트
    2. 빌드 매니페스트(package.json/Cargo.toml/go.mod/build.gradle*/pom.xml) 부재
    3. pyproject.toml 부재 OR runtime deps 비어있음
    4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 5
    """
    if lang in _BUILD_LANGS:
        return False
    has_build_manifest, _ = file_exists_any(repo, _BUILD_MANIFESTS)
    if has_build_manifest:
        return False
    if not _pyproject_runtime_deps_empty(repo / "pyproject.toml"):
        return False
    build_sources = sum(
        1 for f in tracked
        if f.suffix in _BUILD_SOURCE_EXTS and f.is_file()
    )
    return build_sources < 5


def has_secret_pattern(repo: Path, tracked: list[Path]) -> bool:
    """간단한 하드코딩 비밀 패턴 탐지 (false-positive 억제)."""
    patterns = [
        re.compile(r'(?:password|passwd|secret|api_key|token)\s*=\s*["\'][^"\']{8,}["\']', re.I),
        re.compile(r'sk-[a-zA-Z0-9]{32,}'),
        re.compile(r'AKIA[0-9A-Z]{16}'),
    ]
    exclude_exts = {".png", ".jpg", ".jpeg", ".gif", ".ico", ".woff", ".ttf", ".lock"}
    for f in tracked:
        if f.suffix in exclude_exts or not f.is_file():
            continue
        if f.name in {".env", ".env.local", ".env.production"}:
            continue
        content = file_content(f)
        if any(p.search(content) for p in patterns):
            return True
    return False


# ── 카테고리별 스코어링 함수 ──────────────────────────────────────────────────

def score_documentation(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []

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

    # Architecture / ADR 문서
    arch_patterns = ["ARCHITECTURE.md", "docs/ARCHITECTURE.md", "docs/core/ARCHITECTURE.md",
                     "ADR.md", "docs/ADR.md", "docs/adr/", "doc/architecture"]
    exists, fname = file_exists_any(repo, arch_patterns)
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
    else:
        checks.append(Check("Docstring / JSDoc 커버리지", True, 2, 3,
                            f"{lang} — 자동 측정 skip (부분 점수)", None))

    # Changelog
    exists, fname = file_exists_any(repo, ["CHANGELOG.md", "CHANGELOG", "HISTORY.md", "CHANGES.md"])
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

    if lang == "Python":
        py_files = [f for f in tracked if f.suffix == ".py" and f.is_file()]
        ratio = python_type_hint_ratio(py_files)
        score = 5 if ratio >= 0.7 else (3 if ratio >= 0.4 else (1 if ratio > 0.1 else 0))
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
        checks.append(Check(
            "스키마 정의 (Pydantic/dataclass)",
            schema_found, 4 if schema_found else 0, 4,
            "스키마 라이브러리 사용 중" if schema_found else "구조화된 데이터 모델 미사용",
            None if schema_found else "API 입출력·설정·이벤트에 Pydantic 모델 또는 dataclass 적용",
            "단기", 2.0
        ))

        # Protocol / ABC
        protocol_found = any("Protocol" in file_content(f) or "ABC" in file_content(f) for f in py_files[:50])
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
        checks.append(Check("tsconfig.json (strict)", tsconfig, 5 if tsconfig else 0, 5,
                            f"발견: {fname}" if tsconfig else "없음",
                            None if tsconfig else "tsconfig.json strict 모드 활성화",
                            "즉시", 2.5))
        # zod / io-ts
        ts_files = [f for f in tracked if f.suffix in {".ts", ".tsx"} and f.is_file()]
        schema = any("zod" in file_content(f) or "io-ts" in file_content(f) for f in ts_files[:50])
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

    # tests 디렉토리
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
    checks.append(Check(
        "테스트 디렉토리 존재",
        has_tests or bool(test_files), 2 if (has_tests or test_files) else 0, 2,
        f"테스트 파일 {len(test_files)}개" + (f" ({tdir})" if has_tests else ""),
        None if (has_tests or test_files) else "tests/ 디렉토리 생성 및 테스트 파일 추가",
        "즉시", 3.0
    ))

    # 테스트 파일 수
    count = len(test_files)
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

    # Coverage 설정
    cov_conf, fname = file_exists_any(repo, [
        ".coveragerc", "pyproject.toml", ".nycrc", "jest.config.js",
        "jest.config.ts", "coverage.json"
    ])
    has_cov = False
    if cov_conf:
        content = file_content(repo / fname)
        has_cov = "coverage" in content.lower() or "cov" in content.lower()
    checks.append(Check(
        "커버리지 설정",
        has_cov, 2 if has_cov else 0, 2,
        "커버리지 설정 있음" if has_cov else "없음",
        None if has_cov else "pyproject.toml에 [tool.coverage] 또는 .coveragerc 추가 (목표: 70%+)",
        "즉시", 1.5
    ))

    # 통합 테스트
    int_test, fname = file_exists_any(repo, [
        "tests/integration/", "tests/e2e/", "tests/int/",
        "test/integration/", "e2e/", "integration/"
    ])
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
    checks.append(Check(
        "CI 테스트 자동화",
        ci_runs_tests, 2 if ci_runs_tests else 0, 2,
        "CI에서 테스트 실행 중" if ci_runs_tests else "CI 테스트 없음",
        None if ci_runs_tests else "GitHub Actions에 pytest / npm test 단계 추가",
        "단기", 2.5
    ))

    return checks


def score_context_layer(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []

    # CLAUDE.md 품질
    exists, fname = file_exists_any(repo, ["CLAUDE.md", "AGENTS.md", ".claude/CLAUDE.md"])
    if exists:
        content = file_content(repo / fname)
        lines = content.count("\n")
        has_arch = any(k in content for k in ["아키텍처", "architecture", "Architecture", "CRITICAL"])
        has_commands = any(k in content for k in ["```bash", "```sh", "poetry run", "npm run", "go test"])
        score = 3
        score += 2 if lines >= 30 else 0
        score += 3 if has_arch else 0
        score += 3 if has_commands else 0
        score = min(score, 11)
        checks.append(Check(
            "CLAUDE.md 품질",
            score >= 6, score, 11,
            f"{lines}줄 | 아키텍처: {'✓' if has_arch else '✗'} | 명령어: {'✓' if has_commands else '✗'}",
            None if score >= 6 else "CLAUDE.md에 아키텍처 규칙·금지 명령·개발 명령어 섹션 추가",
            "즉시", 3.0
        ))
    else:
        checks.append(Check(
            "CLAUDE.md / AGENTS.md",
            False, 0, 11,
            "AI 에이전트 컨텍스트 파일 없음 — 가장 중요한 누락",
            "CLAUDE.md 생성 (기술 스택·아키텍처 규칙·개발 프로세스·명령어 포함). 📌 최우선 과제",
            "즉시", 3.0
        ))

    # GUARDRAILS / 가드레일
    guard, fname = file_exists_any(repo, [
        "docs/GUARDRAILS.md", "GUARDRAILS.md", ".claude/GUARDRAILS.md",
        "docs/guardrails.md"
    ])
    checks.append(Check(
        "가드레일 (GUARDRAILS.md)",
        guard, 2 if guard else 0, 2,
        f"발견: {fname}" if guard else "없음 — AI가 금지 행동을 모름",
        None if guard else "docs/GUARDRAILS.md 생성 (금지 명령·보안 규칙·위험 작업 목록)",
        "즉시", 2.5
    ))

    # ADR / Decision Records
    adr, fname = file_exists_any(repo, [
        "docs/ADR.md", "docs/adr/", "ADR.md", "docs/core/ADR.md",
        "decisions/", "docs/decisions/", "DECISIONS.md"
    ])
    checks.append(Check(
        "ADR / 의사결정 기록",
        adr, 2 if adr else 0, 2,
        f"발견: {fname}" if adr else "없음 — AI가 과거 결정 맥락을 모름",
        None if adr else "docs/ADR.md 또는 docs/adr/ 디렉토리에 핵심 아키텍처 결정 기록",
        "단기", 2.0
    ))

    return checks


def score_automation(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []

    # CI/CD
    ci, fname = file_exists_any(repo, [
        ".github/workflows/", ".gitlab-ci.yml", ".circleci/",
        "Jenkinsfile", ".travis.yml", "azure-pipelines.yml"
    ])
    checks.append(Check(
        "CI/CD 파이프라인",
        ci, 3 if ci else 0, 3,
        f"발견: {fname}" if ci else "없음",
        None if ci else "GitHub Actions .github/workflows/ci.yml 추가 (lint·test·build)",
        "단기", 2.5
    ))

    # Pre-commit
    pre_commit, fname = file_exists_any(repo, [".pre-commit-config.yaml", ".pre-commit-config.yml"])
    checks.append(Check(
        "Pre-commit 훅",
        pre_commit, 3 if pre_commit else 0, 3,
        f"발견: {fname}" if pre_commit else "없음",
        None if pre_commit else ".pre-commit-config.yaml 추가 (ruff/eslint/gitleaks 포함) — AI 실수 자동 차단",
        "즉시", 2.5
    ))

    # Linter 설정
    if lang == "Python":
        lint, fname = file_exists_any(repo, [
            "pyproject.toml", ".ruff.toml", "ruff.toml", ".flake8", "setup.cfg"
        ])
        lint_active = False
        if lint:
            content = file_content(repo / fname)
            lint_active = "ruff" in content or "flake8" in content or "pylint" in content
        checks.append(Check(
            "린터 설정 (ruff/flake8)",
            lint_active, 2 if lint_active else 0, 2,
            "린터 설정 있음" if lint_active else "없음",
            None if lint_active else "pyproject.toml에 [tool.ruff] 설정 추가",
            "즉시", 2.0
        ))
    elif lang == "TypeScript":
        lint, fname = file_exists_any(repo, [".eslintrc.json", ".eslintrc.js", "eslint.config.js", "biome.json"])
        checks.append(Check(
            "린터 설정 (ESLint/Biome)",
            bool(lint), 2 if lint else 0, 2,
            f"발견: {fname}" if lint else "없음",
            None if lint else "ESLint 또는 Biome 설정 추가",
            "즉시", 2.0
        ))
    else:
        checks.append(Check("린터 설정", True, 2, 2, f"{lang} — 부분 점수", None))

    # Makefile / task runner
    make, fname = file_exists_any(repo, ["Makefile", "justfile", "taskfile.yml", "Taskfile.yml", "scripts/"])
    checks.append(Check(
        "Makefile / 태스크 러너",
        make, 2 if make else 0, 2,
        f"발견: {fname}" if make else "없음",
        None if make else "Makefile 또는 scripts/ 디렉토리로 공통 명령 표준화 (AI가 실행 가능한 명령 목록)",
        "즉시", 1.5
    ))

    # N/A 판정 (shell/markdown-only repo는 컨테이너화/lock 부적합)
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)

    # Docker
    docker, fname = file_exists_any(repo, ["Dockerfile", "docker-compose.yml", "docker-compose.yaml", ".dockerignore"])
    if not docker and na_repo:
        checks.append(Check(
            "Docker / 컨테이너화",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (컨테이너화 부적합, 자동 만점)",
            action=None,
            roi_effort="중기", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "Docker / 컨테이너화",
            docker, 2 if docker else 0, 2,
            f"발견: {fname}" if docker else "없음",
            None if docker else "Dockerfile 및 docker-compose.yml 추가 (환경 재현성 보장)",
            "중기", 1.5
        ))

    # Lock file
    lock, fname = file_exists_any(repo, [
        "poetry.lock", "package-lock.json", "yarn.lock", "pnpm-lock.yaml",
        "go.sum", "Cargo.lock", "Pipfile.lock", "uv.lock"
    ])
    if not lock and na_repo:
        checks.append(Check(
            "의존성 Lock 파일",
            passed=True, score=1, max_score=1,
            detail="N/A — runtime 의존성 부재 (자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "의존성 Lock 파일",
            lock, 1 if lock else 0, 1,
            f"발견: {fname}" if lock else "없음",
            None if lock else "의존성 lock 파일 생성 및 커밋 (재현 가능한 빌드)",
            "즉시", 1.5
        ))

    return checks


def score_agentic_safety(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []

    # .gitignore
    gitignore = (repo / ".gitignore").exists()
    checks.append(Check(
        ".gitignore 존재",
        gitignore, 1 if gitignore else 0, 1,
        "있음" if gitignore else "없음 — 민감 파일 실수 커밋 위험",
        None if gitignore else ".gitignore 추가 (.env, __pycache__, node_modules 등 제외)",
        "즉시", 2.0
    ))

    # .env가 git에 추적되지 않음
    env_committed = is_env_committed(repo)
    checks.append(Check(
        ".env 미커밋",
        not env_committed, 2 if not env_committed else 0, 2,
        ".env 커밋됨 — 비밀 키 노출 위험!" if env_committed else ".env 미추적 (안전)",
        None if not env_committed else "즉시 git rm --cached .env 후 .gitignore에 .env 추가. 비밀 키 rotation 필요",
        "즉시", 3.0
    ))

    # .env.example 존재
    env_example, fname = file_exists_any(repo, [".env.example", ".env.sample", "env.example"])
    checks.append(Check(
        ".env.example",
        env_example, 2 if env_example else 0, 2,
        f"발견: {fname}" if env_example else "없음 — 필요 환경변수 불명확",
        None if env_example else ".env.example 생성 (실제 값 없이 키 이름·설명만 포함)",
        "즉시", 2.0
    ))

    # 하드코딩 비밀 패턴 탐지
    has_secret = has_secret_pattern(repo, tracked)
    checks.append(Check(
        "하드코딩 비밀 없음",
        not has_secret, 2 if not has_secret else 0, 2,
        "비밀 패턴 탐지됨 — 즉시 확인 필요!" if has_secret else "패턴 탐지 없음",
        None if not has_secret else "하드코딩된 비밀 값을 환경변수·시크릿 관리자로 이동. gitleaks 설치 권장",
        "즉시", 3.0
    ))

    # Claude Code 권한 설정
    perm, fname = file_exists_any(repo, [".claude/settings.json", ".claude/settings.local.json"])
    checks.append(Check(
        "Claude Code 권한 설정",
        perm, 2 if perm else 0, 2,
        f"발견: {fname}" if perm else "없음 — AI 도구 권한 미제어",
        None if perm else ".claude/settings.json에 permissions 블록 추가 (deny: rm -rf, git push --force 등)",
        "즉시", 2.0
    ))

    # Guardrails 파일 (중복이지만 안전 관점에서 재채점)
    guard, fname = file_exists_any(repo, ["docs/GUARDRAILS.md", "GUARDRAILS.md"])
    checks.append(Check(
        "가드레일 파일",
        guard, 1 if guard else 0, 1,
        f"발견: {fname}" if guard else "없음",
        None if guard else "AI 에이전트 행동 제약 가드레일 정의",
        "즉시", 2.0
    ))

    return checks


# ── ROI 계산 ────────────────────────────────────────────────────────────────
EFFORT_HOURS = {"즉시": 1, "단기": 8, "중기": 40}

def compute_roi_actions(categories: list[CategoryResult]) -> list[dict]:
    actions: list[dict] = []
    for cat in categories:
        for ch in cat.checks:
            if not ch["passed"] and ch.get("action"):
                recoverable = ch["max_score"] - ch["score"]
                effort = ch.get("roi_effort", "단기")
                impact = ch.get("roi_impact", 1.0)
                roi = (recoverable * impact) / EFFORT_HOURS[effort]
                actions.append({
                    "category": cat.name_ko,
                    "check": ch["name"],
                    "action": ch["action"],
                    "recoverable_score": recoverable,
                    "effort": effort,
                    "roi_score": round(roi, 3),
                })
    actions.sort(key=lambda x: x["roi_score"], reverse=True)
    return actions


# ── HTML 대시보드 생성 ─────────────────────────────────────────────────────────
def generate_html(report: dict, output_path: Path) -> None:
    cats = report["categories"]
    total = report["total_score"]
    grade = report["grade"]
    color = report["color"]
    roi = report["roi_actions"]

    radar_labels = json.dumps([c["name_ko"] for c in cats], ensure_ascii=False)
    radar_scores = json.dumps([c["score"] for c in cats])
    radar_max    = json.dumps([c["max_score"] for c in cats])

    grade_emoji = {"S": "🏆", "A": "⭐", "B": "✅", "C": "⚠️", "D": "🔴"}.get(grade, "")

    cat_cards = ""
    for c in cats:
        g, col = c["grade"], c["color"]
        bar_pct = pct(c["score"], c["max_score"])
        checks_html = ""
        for ch in c["checks"]:
            icon = "ℹ️" if ch.get("na") else ("✅" if ch["passed"] else "❌")
            action_html = f'<div class="action">→ {ch["action"]}</div>' if not ch["passed"] and ch.get("action") else ""
            checks_html += f'''
            <li>
              <span class="check-icon">{icon}</span>
              <span class="check-name">{ch["name"]}</span>
              <span class="check-score">{ch["score"]:.0f}/{ch["max_score"]:.0f}</span>
              {action_html}
            </li>'''
        cat_cards += f'''
        <div class="cat-card">
          <div class="cat-header">
            <span class="cat-name">{c["name_ko"]}</span>
            <span class="cat-grade" style="background:{col}">{g}</span>
            <span class="cat-score">{c["score"]:.0f} / {c["max_score"]}</span>
          </div>
          <div class="progress-bar">
            <div class="progress-fill" style="width:{bar_pct}%;background:{col}"></div>
          </div>
          <ul class="check-list">{checks_html}</ul>
        </div>'''

    roi_rows = ""
    for i, a in enumerate(roi[:10], 1):
        effort_color = {"즉시": "#10b981", "단기": "#f59e0b", "중기": "#ef4444"}.get(a["effort"], "#6b7280")
        roi_rows += f'''
        <tr>
          <td class="rank">#{i}</td>
          <td><span class="tag" style="background:{effort_color}">{a["effort"]}</span></td>
          <td class="score-cell">+{a["recoverable_score"]:.0f}점</td>
          <td class="cat-cell">{a["category"]}</td>
          <td class="action-text">{a["action"]}</td>
        </tr>'''

    html = f"""<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI-Ready 감사 — {report["repo_name"]}</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
  *, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    background: #0f172a; color: #e2e8f0; min-height: 100vh;
  }}
  .header {{
    background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    border-bottom: 1px solid #334155;
    padding: 2rem;
    text-align: center;
  }}
  .header h1 {{ font-size: 1.5rem; color: #94a3b8; margin-bottom: 0.5rem; }}
  .repo-name {{ font-size: 2rem; font-weight: 700; color: #f1f5f9; }}
  .meta {{ color: #64748b; font-size: 0.875rem; margin-top: 0.5rem; }}
  .score-hero {{
    display: flex; align-items: center; justify-content: center; gap: 2rem;
    padding: 3rem 2rem;
    background: #1e293b;
    border-bottom: 1px solid #334155;
  }}
  .score-circle {{
    width: 140px; height: 140px; border-radius: 50%;
    border: 6px solid {color};
    display: flex; flex-direction: column; align-items: center; justify-content: center;
    box-shadow: 0 0 30px {color}44;
  }}
  .score-number {{ font-size: 3rem; font-weight: 800; color: {color}; line-height: 1; }}
  .score-denom {{ font-size: 1rem; color: #64748b; }}
  .score-info {{ text-align: left; }}
  .grade-badge {{
    display: inline-block; padding: 0.5rem 1.5rem; border-radius: 2rem;
    background: {color}22; border: 2px solid {color};
    font-size: 2rem; font-weight: 800; color: {color};
    margin-bottom: 0.75rem;
  }}
  .score-pct {{ font-size: 1.25rem; color: #94a3b8; }}
  .score-lang {{ font-size: 0.875rem; color: #64748b; margin-top: 0.25rem; }}
  .main {{ max-width: 1200px; margin: 0 auto; padding: 2rem; }}
  .section-title {{ font-size: 1.25rem; font-weight: 700; color: #f1f5f9; margin-bottom: 1.5rem;
    border-left: 4px solid #3b82f6; padding-left: 0.75rem; }}
  .chart-section {{
    display: grid; grid-template-columns: 1fr 2fr; gap: 2rem;
    margin-bottom: 3rem; align-items: start;
  }}
  .chart-box {{
    background: #1e293b; border: 1px solid #334155; border-radius: 1rem; padding: 1.5rem;
  }}
  .chart-legend {{ display: flex; flex-direction: column; gap: 0.75rem; }}
  .legend-item {{
    display: flex; align-items: center; gap: 0.75rem;
    background: #0f172a; border-radius: 0.5rem; padding: 0.75rem;
  }}
  .legend-dot {{ width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }}
  .legend-name {{ flex: 1; font-size: 0.875rem; }}
  .legend-score {{ font-weight: 700; font-size: 0.875rem; }}
  .legend-bar {{ flex: 1; height: 4px; background: #334155; border-radius: 2px; overflow: hidden; }}
  .legend-fill {{ height: 100%; border-radius: 2px; }}
  .cats-grid {{
    display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 1.5rem; margin-bottom: 3rem;
  }}
  .cat-card {{
    background: #1e293b; border: 1px solid #334155; border-radius: 1rem; padding: 1.25rem;
  }}
  .cat-header {{
    display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.75rem;
  }}
  .cat-name {{ flex: 1; font-weight: 600; font-size: 1rem; }}
  .cat-grade {{
    padding: 0.25rem 0.75rem; border-radius: 1rem; font-weight: 800; font-size: 0.875rem;
    color: white;
  }}
  .cat-score {{ font-size: 0.875rem; color: #94a3b8; white-space: nowrap; }}
  .progress-bar {{
    height: 6px; background: #334155; border-radius: 3px; overflow: hidden; margin-bottom: 1rem;
  }}
  .progress-fill {{ height: 100%; border-radius: 3px; transition: width 0.5s ease; }}
  .check-list {{ list-style: none; display: flex; flex-direction: column; gap: 0.5rem; }}
  .check-list li {{
    display: flex; align-items: flex-start; gap: 0.5rem; font-size: 0.8rem;
    flex-wrap: wrap;
  }}
  .check-icon {{ flex-shrink: 0; }}
  .check-name {{ flex: 1; color: #94a3b8; }}
  .check-score {{ color: #64748b; font-size: 0.75rem; white-space: nowrap; }}
  .action {{
    width: 100%; color: #f59e0b; font-size: 0.75rem;
    padding: 0.25rem 0.5rem; background: #f59e0b11; border-radius: 0.25rem;
    margin-top: 0.25rem;
  }}
  .roi-section {{ margin-bottom: 3rem; }}
  .roi-table {{ width: 100%; border-collapse: collapse; font-size: 0.875rem; }}
  .roi-table th {{
    background: #334155; color: #94a3b8; padding: 0.75rem 1rem;
    text-align: left; font-weight: 600;
  }}
  .roi-table td {{ padding: 0.75rem 1rem; border-bottom: 1px solid #1e293b; vertical-align: top; }}
  .roi-table tr:hover td {{ background: #1e293b; }}
  .rank {{ color: #64748b; font-weight: 700; width: 3rem; }}
  .tag {{
    display: inline-block; padding: 0.2rem 0.6rem; border-radius: 1rem;
    font-size: 0.75rem; font-weight: 600; color: white; white-space: nowrap;
  }}
  .score-cell {{ font-weight: 700; color: #10b981; white-space: nowrap; }}
  .cat-cell {{ color: #94a3b8; white-space: nowrap; }}
  .action-text {{ color: #e2e8f0; }}
  .footer {{
    text-align: center; color: #475569; font-size: 0.8rem;
    padding: 2rem; border-top: 1px solid #334155; margin-top: 2rem;
  }}
  @media (max-width: 768px) {{
    .chart-section {{ grid-template-columns: 1fr; }}
    .score-hero {{ flex-direction: column; gap: 1.5rem; }}
  }}
</style>
</head>
<body>
<div class="header">
  <h1>🤖 AI-Ready Codebase 감사 리포트</h1>
  <div class="repo-name">{report["repo_name"]}</div>
  <div class="meta">생성: {report["generated_at"][:10]} | 언어: {report["language"]} | 파일: {report["file_count"]}개 | 브랜치: {report["git_branch"] or "N/A"}</div>
</div>

<div class="score-hero">
  <div class="score-circle">
    <div class="score-number">{total:.0f}</div>
    <div class="score-denom">/ 100</div>
  </div>
  <div class="score-info">
    <div class="grade-badge">{grade_emoji} {grade}</div>
    <div class="score-pct">{report["percentage"]:.1f}% AI-Ready</div>
    <div class="score-lang">{report["language"]} 프로젝트</div>
  </div>
</div>

<div class="main">
  <div class="chart-section">
    <div class="chart-box" style="max-width:320px">
      <canvas id="radarChart" width="300" height="300"></canvas>
    </div>
    <div class="chart-box">
      <div class="section-title">카테고리별 점수</div>
      <div class="chart-legend">
        {"".join(f'''<div class="legend-item">
          <div class="legend-dot" style="background:{c['color']}"></div>
          <span class="legend-name">{c["name_ko"]}</span>
          <div class="legend-bar"><div class="legend-fill" style="width:{pct(c['score'],c['max_score'])}%;background:{c['color']}"></div></div>
          <span class="legend-score" style="color:{c['color']}">{c['score']:.0f}/{c['max_score']}</span>
          <span class="cat-grade" style="background:{c['color']}">{c['grade']}</span>
        </div>''' for c in cats)}
      </div>
    </div>
  </div>

  <div class="section-title">카테고리 상세</div>
  <div class="cats-grid">{cat_cards}</div>

  <div class="roi-section">
    <div class="section-title">🚀 ROI 우선순위 액션 TOP 10</div>
    <table class="roi-table">
      <thead>
        <tr>
          <th>순위</th><th>난이도</th><th>회복 점수</th><th>카테고리</th><th>권장 액션</th>
        </tr>
      </thead>
      <tbody>{roi_rows}</tbody>
    </table>
  </div>
</div>

<div class="footer">
  AI-Ready Codebase Scorer · 생성: {report["generated_at"]} ·
  <a href="https://github.com/pdw96/upbit" style="color:#3b82f6">upbit</a>
</div>

<script>
const labels = {radar_labels};
const scores = {radar_scores};
const maxes  = {radar_max};
const pcts = scores.map((s,i) => parseFloat((s/maxes[i]*100).toFixed(1)));

new Chart(document.getElementById('radarChart'), {{
  type: 'radar',
  data: {{
    labels: labels,
    datasets: [{{
      label: 'AI-Ready 점수',
      data: pcts,
      backgroundColor: 'rgba(59,130,246,0.15)',
      borderColor: '#3b82f6',
      borderWidth: 2,
      pointBackgroundColor: '#3b82f6',
      pointRadius: 4,
    }}]
  }},
  options: {{
    responsive: true,
    scales: {{
      r: {{
        min: 0, max: 100,
        ticks: {{ color: '#64748b', stepSize: 25, font: {{ size: 10 }} }},
        grid: {{ color: '#334155' }},
        pointLabels: {{ color: '#94a3b8', font: {{ size: 10 }} }},
        angleLines: {{ color: '#334155' }},
      }}
    }},
    plugins: {{ legend: {{ display: false }} }}
  }}
}});
</script>
</body>
</html>"""

    output_path.write_text(html, encoding="utf-8")


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

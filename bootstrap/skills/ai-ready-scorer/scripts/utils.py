"""utils.py — AI-Ready Scorer 공유 모듈 (dataclasses + helpers)

분할 후 모든 카테고리 스코어링 모듈이 의존하는 shared types + utility 함수.
v1.18g-score-codebase-py-split에서 score_codebase.py 1335줄 → 5 모듈 분할 시 추출.

의존: stdlib only (ast, os, re, subprocess, dataclasses, datetime, pathlib).
"""

from __future__ import annotations

import ast
import re
import subprocess
from dataclasses import dataclass, field
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

"""categories_ops.py — 운영/자동화 카테고리 3종 + ROI 계산

context_layer / automation / agentic_safety + compute_roi_actions.
v1.18g-score-codebase-py-split에서 추출.

의존: utils (Check + CategoryResult + 5 helpers).
"""

from __future__ import annotations

from pathlib import Path

from utils import (
    CategoryResult,
    Check,
    file_content,
    file_exists_any,
    has_secret_pattern,
    is_env_committed,
    is_shell_markdown_only_repo,
    is_small_typed_lang_repo,
)


def score_context_layer(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)

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

    # GUARDRAILS / 가드레일 (v1.35 N/A)
    guard, fname = file_exists_any(repo, [
        "docs/GUARDRAILS.md", "GUARDRAILS.md", ".claude/GUARDRAILS.md",
        "docs/guardrails.md"
    ])
    if not guard and na_repo:
        checks.append(Check(
            "가드레일 (GUARDRAILS.md)",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (가드레일 부적합, 자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(
            "가드레일 (GUARDRAILS.md)",
            guard, 2 if guard else 0, 2,
            f"발견: {fname}" if guard else "없음 — AI가 금지 행동을 모름",
            None if guard else "docs/GUARDRAILS.md 생성 (금지 명령·보안 규칙·위험 작업 목록)",
            "즉시", 2.5
        ))

    # ADR / Decision Records (v1.35 N/A)
    adr, fname = file_exists_any(repo, [
        "docs/ADR.md", "docs/adr/", "ADR.md", "docs/core/ADR.md",
        "decisions/", "docs/decisions/", "DECISIONS.md"
    ])
    if not adr and na_repo:
        checks.append(Check(
            "ADR / 의사결정 기록",
            passed=True, score=2, max_score=2,
            detail="N/A — shell/markdown-only repo (ADR 부적합, 자동 만점)",
            action=None,
            roi_effort="단기", roi_impact=0.0,
            na=True,
        ))
    else:
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

    # N/A 판정 (상단 추출 - v1.48: 린터 + Docker/Lock 공용)
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)

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
        if is_small_typed_lang_repo(repo, tracked, lang):
            checks.append(Check(
                "린터 설정 (ruff/flake8)",
                passed=True, score=2, max_score=2,
                detail="N/A — Python 소스 5개 미만 (린터 설정 부적합, 자동 만점)",
                action=None,
                roi_effort="즉시", roi_impact=0.0,
                na=True,
            ))
        else:
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
        if is_small_typed_lang_repo(repo, tracked, lang):
            checks.append(Check(
                "린터 설정 (ESLint/Biome)",
                passed=True, score=2, max_score=2,
                detail="N/A — TypeScript 소스 5개 미만 (린터 설정 부적합, 자동 만점)",
                action=None,
                roi_effort="즉시", roi_impact=0.0,
                na=True,
            ))
        else:
            lint, fname = file_exists_any(repo, [".eslintrc.json", ".eslintrc.js", "eslint.config.js", "biome.json"])
            checks.append(Check(
                "린터 설정 (ESLint/Biome)",
                bool(lint), 2 if lint else 0, 2,
                f"발견: {fname}" if lint else "없음",
                None if lint else "ESLint 또는 Biome 설정 추가",
                "즉시", 2.0
            ))
    else:
        if na_repo:
            checks.append(Check(
                "린터 설정",
                passed=True, score=2, max_score=2,
                detail="N/A — shell/markdown-only repo (린터 부적합, 자동 만점)",
                action=None,
                roi_effort="즉시", roi_impact=0.0,
                na=True,
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
            if ch["score"] < ch["max_score"] and not ch.get("na", False) and ch.get("action"):
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

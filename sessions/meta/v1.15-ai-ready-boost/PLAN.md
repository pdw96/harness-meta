# meta v1.15-ai-ready-boost — PLAN

세션 시작: 2026-04-28
직접 선행 세션:
- `/ai-ready-scorer` 실행 결과 (53/100, 등급 C) — 스코어러는 임시 분석 도구 (세션 아님), 본 세션이 결과를 받아 액션화
- [`sessions/meta/v1.14-bootstrap-simplify/`](../v1.14-bootstrap-simplify/PLAN.md) — 직전 meta 세션 (bootstrap 8-stage 간결화)

목적: AI-Ready 스코어러가 식별한 즉시 ROI 항목 5건을 일괄 처리. CI 자동화 + 컨텍스트 가드레일 + 환경변수 문서 + 변경 이력으로 점수 53 → ~64 회복 + AI 에이전트 실수 자동 차단 인프라 확립.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(5) `.github/workflows/ci.yml`, `.pre-commit-config.yaml`, `GUARDRAILS.md`, `.env.example`, `CHANGELOG.md` — 모두 repo-global 정책·설치 영역
- T1 경로 다수결 — meta scope 5/5
- T2 스펙 vs 값 — repo 정책·CI 인프라 = 모든 프로젝트 영향 → meta

## Scope inheritance (verbatim from /ai-ready-scorer 결과)

**Source — `ai-ready-report.json` `roi_actions` 상위 5건** (verbatim, ROI 점수 내림차순):

> 1. [즉시 / +3점] 자동화·Pre-commit 훅: ".pre-commit-config.yaml 추가 (ruff/eslint/gitleaks 포함) — AI 실수 자동 차단"
> 2. [즉시 / +2점] 컨텍스트 레이어·가드레일: "docs/GUARDRAILS.md 생성 (금지 명령·보안 규칙·위험 작업 목록)"
> 3. [즉시 / +2점] 에이전틱 안전·.env.example: ".env.example 생성 (실제 값 없이 키 이름·설명만 포함)"
> 4. [단기 / +3점] 자동화·CI/CD: "GitHub Actions .github/workflows/ci.yml 추가 (lint·test·build)"
> 5. [단기 / +1점] 문서화·Changelog: "CHANGELOG.md 생성 (conventional commits 기반 자동 생성 가능)"

**Parsed sub-items (5)**:

1. **`.pre-commit-config.yaml`** — shellcheck + markdownlint hook (harness-meta는 shell + markdown 중심)
2. **`GUARDRAILS.md`** — harness-meta 세션 진행 시 금지 행동·위험 작업 목록 (project repo의 GUARDRAILS와 별개 — meta repo 자체용)
3. **`.env.example`** — `HARNESS_META_ROOT` 환경변수 문서화 (실 값 없음)
4. **`.github/workflows/ci.yml`** — 기존 `tests/smoke-*.sh` 13건 자동 실행
5. **`CHANGELOG.md`** — conventional commits 기반 수동 작성 (자동 생성은 후속)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `docs/ARCHITECTURE.md` 신규 작성 | sessions/meta/ 자체가 ADR 역할 — AI-Ready 스코어러의 일반 코드 레포 가정 부적용 |
| 소스/테스트 디렉토리 분리 (`src/` 패키지화) | 메타 repo는 markdown+shell 중심 — 부적용 |
| `pyproject.toml` / `package.json` 패키지 매니페스트 | 메타 repo는 라이브러리 아님 — 부적용 |
| 테스트 파일 ≥15 확보 / 통합 테스트 / 커버리지 | 메타 repo의 smoke 테스트 13건은 충분 — 일반 코드 레포 가정 부적용 |
| Docker / 컨테이너화 | install 도구 (PowerShell+bash) — 부적용 |
| 의존성 lock 파일 | 의존성 0 — 부적용 |
| Conventional commits 기반 CHANGELOG **자동** 생성 (release-please / git-cliff) | v1.15b+ evidence-driven (CHANGELOG.md 수동 작성 운영 후) |
| pre-commit hook의 ruff / eslint / gitleaks (Python·JS·secret 검출) | meta repo 미해당 (shellcheck + markdownlint만) |
| `verify.ps1`에 CI/pre-commit 검증 통합 | v1.21-cross-platform-install (verify 통합 시점) |
| AI-Ready 스코어러 자체 개선 (Md 언어 오감지 등) | 별 도메인 (skill 레벨) |
| 프로젝트별 (upbit 등) CI 도입 | 각 프로젝트 세션 — T4 후행 분할 |

## 1. 문제 (현 상태)

### 자동화 카테고리 2/15 (등급 D)

- CI/CD 파이프라인 부재: PR/push 시 13건 smoke 자동 실행 없음
- pre-commit 훅 부재: shell 문법 오류 / markdown 깨짐 commit 시점 미검출
- AI 에이전트가 install-project-claude.{sh,ps1} 같은 핵심 자산 수정 후 smoke 회귀 인지 못 함

### 컨텍스트 레이어 가드레일 부재

- `bootstrap/templates/_base/.claude/skills/`의 SKILL.md들은 frontmatter `allowed-tools:`로 권한 제어
- 그러나 `~/harness-meta/` 자체 세션 진행 시 행동 가드레일 없음 — 예: "글로벌 layer (`claude/**`) 변경 시 사용자 확인 의무"는 CLAUDE.md에만 산재
- 단일 소스 GUARDRAILS.md 부재 → AI 에이전트가 위험 작업 (sessions/meta/ 외부 변경, force push 등)을 매 세션 재발견

### 환경변수 문서화 부재

- `HARNESS_META_ROOT` 환경변수가 install.ps1 + hook + statusline에서 사용
- `.env.example` 부재로 신규 사용자가 환경변수 목록을 코드 grep으로 발견해야 함

### 변경 이력 산재

- 모든 변경 이력이 `sessions/meta/vX.Y-{name}/` 디렉토리에 분산
- 사용자 관점 highlight (breaking / new feature / bugfix) 단일 진입점 부재

## 2. 결정 (R1 ~ R5)

### R1 — `.github/workflows/ci.yml`

**위치**: `~/harness-meta/.github/workflows/ci.yml`

**트리거**: `push` (main) + `pull_request` (main 대상)

**Job 구조** (단일 job — `smoke`):

```yaml
name: Smoke Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  smoke:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run all smoke tests
        run: |
          set -e
          for f in tests/smoke-*.sh; do
            echo "=== $f ==="
            bash "$f"
          done
```

**근거**:
- ubuntu-latest = bash 5.x 사전 설치 (render-manifest.sh의 bash 4+ indirect expansion 호환)
- single job = 13건 smoke 통합. 개별 분리는 evidence 누적 후 v1.15b+
- shellcheck / markdownlint는 pre-commit에서 처리 (R2)
- Windows runner는 v1.21 (cross-platform install) 통합 시점 — `install-project-claude.ps1`은 별 검증 경로

### R2 — `.pre-commit-config.yaml`

**위치**: `~/harness-meta/.pre-commit-config.yaml`

**Hooks**:

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: check-merge-conflict
      # mixed-line-ending 제거 — .gitattributes가 이미 *.sh=lf / *.ps1=crlf enforce
      # I2 (회귀 방지): .ps1 강제 LF 변환 시 Windows 호환 회귀
  - repo: https://github.com/shellcheck-py/shellcheck-py
    rev: v0.10.0.1
    hooks:
      - id: shellcheck
        files: \.sh$
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.42.0
    hooks:
      - id: markdownlint
        args: [--config, .markdownlint.json, --ignore-path, .markdownlintignore]
        files: \.md$
```

**`.markdownlint.json`** 별도 작성 (relax 규칙 + I1 반영):
- MD013 (line length) disable — 한국어 markdown은 long line 일반적
- MD033 (inline HTML) allow — 일부 표 정렬용
- **MD041 (first line must be h1) disable** — `bootstrap/skeletons/` + `bootstrap/templates/_base/.claude/` + `bootstrap/templates/python/.claude/`의 17 파일이 YAML frontmatter로 시작 (정상 패턴)
- MD024 (duplicate headings) siblings_only

**`.markdownlintignore`** 별도 작성 (I1 추가 보호) — frontmatter-기반 파일 디렉토리 명시 제외:
```
bootstrap/skeletons/
bootstrap/templates/_base/.claude/
bootstrap/templates/python/.claude/
```
→ 향후 신규 frontmatter 디렉토리 추가 시 본 ignore에 append 의무 (GUARDRAILS R3에 가이드)

**LF 강제 — 명시적 제거**: `.gitattributes`의 `*.sh text eol=lf` + `*.ps1 text eol=crlf` 정책이 git 레벨에서 enforce. pre-commit `mixed-line-ending`은 충돌 회피 위해 미사용.

**설치 안내**: README.md의 "Installation" 섹션 (영문, I3 반영)에 추가:
```bash
# (Optional) Dev tooling — enable pre-commit hooks for shellcheck + markdownlint
pip install pre-commit  # or: pipx install pre-commit
pre-commit install
```

### R3 — `GUARDRAILS.md`

**위치**: `~/harness-meta/GUARDRAILS.md` (repo root — `bootstrap/manifest-schema.md §6.3 [harness].guardrails`와 별개. 이건 **meta repo 자체의 가드레일**)

**섹션 구조** (~80~120 lines):

1. **목적** — harness-meta repo 자체 개선 세션 시 AI 에이전트가 따를 행동 가드레일 단일 소스
2. **금지 행동 (Hard rules)**:
   - `sessions/meta/<old-version>/PLAN.md` 또는 `REPORT.md` 직접 수정 (이력 보존 — `--amend` 금지, 신규 세션으로 정정)
   - `git push --force` (main branch 또는 published session 커밋 — 사용자 명시 승인 외 금지)
   - `--no-verify` / `--no-gpg-sign` 사용 (pre-commit 우회 금지)
   - `~/.claude/` 직접 편집 (글로벌 layer는 install.ps1 symlink로만 갱신)
   - 프로젝트 repo (`upbit`, `harness-meta` 외 외부)에 직접 커밋 (T4 후행 세션으로 분할)
   - `execute.py` 호출 (재귀 회피 — meta 세션은 GSD 패턴, phase 세션 도구 사용 금지)
3. **위험 작업 (Confirmation 의무)**:
   - `claude/**` 변경 (글로벌 layer — 모든 프로젝트 영향)
   - `bootstrap/templates/_base/**` 변경 (메타 소유 프로젝트 템플릿 — 신규 install 영향)
   - `bootstrap/install-project-claude.{sh,ps1}` 변경 (배포 logic)
   - `.harness.toml` schema 변경 (manifest-schema.md bump 동반 의무)
   - 파일 5+ 동시 변경 시
4. **Scope contract 의무** (v1.10j 정합):
   - 모든 PLAN.md에 "세션 소속 근거" + "Scope inheritance" + "Out of scope" 3 섹션
   - 인접 발견 issue는 본 세션 본문에 흡수하지 말고 Out of scope 표에 추가
5. **Smoke 회귀 의무**:
   - `tests/smoke-*.sh` 변경 시 본 세션에서 PASS 확인 후 커밋
   - CI (R1) 실패 시 force-merge 금지
6. **References**: OWNERSHIP.md, AGENTS_MD_STRATEGY.md, PERMISSION_PATTERN.md cross-link

**스코프**: 메타 repo 자체용. 프로젝트 (upbit 등)의 `docs/GUARDRAILS.md`와 무관 — 본 파일은 sessions/meta/ 진행 시만 적용.

### R4 — `.env.example`

**위치**: `~/harness-meta/.env.example`

**내용**:

```bash
# harness-meta — 환경변수 예시
# 실제 값은 .env (gitignored) 또는 shell rc에 설정

# repo clone 위치 override. install.ps1 / hooks / statusline가 참조
# 기본값: $HOME/harness-meta
HARNESS_META_ROOT=
```

**`.gitignore` 갱신**: `.env` 항목 확인 (없으면 append).

### R5 — `CHANGELOG.md`

**위치**: `~/harness-meta/CHANGELOG.md`

**형식**: [Keep a Changelog](https://keepachangelog.com/) v1.1.0 + SemVer

**언어** (I5 반영): **영문** — root-level 파일 (README.md / AGENTS.md / LICENSE) 일관성. Keep a Changelog 표준도 영문 기준. sessions/ 한국어와 분리 (root = 외부 소비자 / sessions = 내부 audit).

**초기 내용** — 기존 sessions/meta/v1.0~v1.14 highlight 추출:

```markdown
# Changelog

User-facing highlights only. For detailed change records, see `sessions/meta/vX.Y-<slug>/REPORT.md`.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- `.github/workflows/ci.yml` — smoke tests (13 files) auto-run on push / PR
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — shellcheck + markdownlint enforcement
- `GUARDRAILS.md` — meta-repo session behavior guardrails (forbidden actions, confirmation-required operations)
- `.env.example` — `HARNESS_META_ROOT` environment variable reference
- `CHANGELOG.md` — this file

## [v1.14] - 2026-04-28
### Changed
- Bootstrap interview simplified: 10 stages → 8 stages, 13 questions → 7 questions

## [v1.13] - 2026-04-28
### Added
- English README + AGENTS.md rewrite (open-source entry)

## [v1.12] - 2026-04-27
### Changed
- `_base` skills + Python overlay fully translated to English

## [v1.11b] - 2026-04-27
### Added
- `bootstrap/templates/python/.claude/` overlay content (`harness-python` skill)

## [v1.11] - 2026-04-27
### Added
- Language overlay infrastructure (`bootstrap/templates/<language>/.claude/`)

(For v1.10 and earlier, see `sessions/meta/` directly.)
```

**자동 생성 (release-please / git-cliff)**: Out of scope (v1.15b+).

## 3. 변경 대상 (7 신규 + 3 수정)

### 신규 (7)

| 경로 | scope | 역할 |
|------|------|------|
| `.github/workflows/ci.yml` | S3 | R1 |
| `.pre-commit-config.yaml` | S3 | R2 |
| `.markdownlint.json` | S3 | R2 (relax 규칙 — MD041 disable) |
| `.markdownlintignore` | S3 | R2 (I1 — frontmatter 디렉토리 제외) |
| `GUARDRAILS.md` | S3 | R3 |
| `.env.example` | S3 | R4 |
| `CHANGELOG.md` | S3 | R5 (영문) |

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `README.md` | S3 | "Installation" 섹션에 pre-commit 안내 (영문, I3) + "Key docs"에 GUARDRAILS.md / CHANGELOG.md cross-ref |
| `AGENTS.md` | S3 | I4 — "Project structure" 섹션에 GUARDRAILS.md / CHANGELOG.md / `.github/workflows/` 1줄씩 추가 (영문) |
| `.gitignore` | S3 | `.env` 항목 append (현재 부재 확인됨) |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 검토 6 issue 반영
- [ ] **사용자 진입 확인**
- [ ] Stage A — `.github/workflows/ci.yml` 신규
- [ ] Stage B — `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` 신규 (I1+I2 반영)
- [ ] Stage C — `GUARDRAILS.md` 신규 (한국어 — sessions/ 일관성)
- [ ] Stage D — `.env.example` 신규 + `.gitignore` `.env` append
- [ ] Stage E — `CHANGELOG.md` 신규 (영문, I5)
- [ ] Stage F — `README.md` 갱신 (영문, I3) + `AGENTS.md` 갱신 (영문, I4)
- [ ] Stage G — Smoke 회귀 (기존 13건 PASS 확인)
- [ ] Stage H — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `.github/workflows/ci.yml` 존재 + smoke 13건 자동 호출
- [ ] `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` 존재 (I1+I2 반영 — MD041 disable + frontmatter dir 제외 + .ps1 미강제)
- [ ] `GUARDRAILS.md` 존재 + 6 § 작성 (목적 / 금지 / 위험 / Scope contract / Smoke / References)
- [ ] `.env.example` 존재 + `HARNESS_META_ROOT` 명시 (영문)
- [ ] `CHANGELOG.md` 존재 + Keep a Changelog 형식 + v1.0~v1.14 highlight (영문, I5)
- [ ] `README.md`: pre-commit install 안내 (영문 + dev 의존성, I3) + GUARDRAILS/CHANGELOG cross-ref
- [ ] `AGENTS.md`: GUARDRAILS/CHANGELOG/CI cross-ref (I4)
- [ ] `.gitignore`: `.env` 항목 append
- [ ] 기존 smoke 13건 회귀 0
- [ ] AI-Ready 재측정: 53 → 64+ 회복 (자동화 +6 / 컨텍스트 레이어 +2 / 에이전틱 안전 +2 / 문서화 +1)

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.15-ai-ready-boost — CI 자동화 + 가드레일 + 환경변수 + 변경 이력

- add: .github/workflows/ci.yml (R1 — smoke 13건 자동 실행)
- add: .pre-commit-config.yaml + .markdownlint.json + .markdownlintignore
       (R2 — shellcheck + markdownlint, I1: MD041 disable + frontmatter dir 제외, I2: .ps1 LF 강제 회피)
- add: GUARDRAILS.md (R3 — 메타 repo 자체 행동 가드레일 6 §)
- add: .env.example (R4 — HARNESS_META_ROOT 문서화)
- add: CHANGELOG.md (R5 — Keep a Changelog 영문 + v1.0~v1.14 highlight, I5)
- update: README.md (영문 pre-commit install 안내 + GUARDRAILS/CHANGELOG cross-ref, I3)
- update: AGENTS.md (GUARDRAILS/CHANGELOG/CI cross-ref, I4)
- update: .gitignore (.env append)
- add: sessions/meta/v1.15-.../{PLAN,REPORT}.md

Scope: AI-Ready 스코어러 ROI 상위 5건 일괄 처리 (53 → ~64).
- CI 자동화 → AI 실수 자동 차단 인프라
- GUARDRAILS → 메타 세션 진행 시 행동 가드레일 단일 소스
- CHANGELOG → 사용자 관점 변경 이력 진입점 (영문)

Smoke 13건 회귀 0.
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.15b-changelog-automation` | CHANGELOG.md 수동 운영 3+ 세션 누적 후 release-please 또는 git-cliff 도입 검토 |
| `v1.15c-ci-windows-runner` | install-project-claude.ps1 회귀 의심 시 Windows runner 추가 |
| `v1.21-cross-platform-install` | verify.ps1에 CI/pre-commit 검증 통합 |
| `v1.X-project-ci` | upbit 등 각 프로젝트 CI 도입 (T4 후행 분할) |

## 8. Lessons Forward (예상)

- **L1 — AI-Ready 스코어러 결과는 일반 코드 레포 가정** — 메타 repo (markdown+shell 중심) 특수성 고려 시 "src/ 분리", "package.json", "Docker" 등 항목은 부적용으로 명시 reject 의무. Out of scope 표가 이를 영구 기록
- **L2 — CI + pre-commit + GUARDRAILS는 3-layer 안전망** — 각자 다른 시점 (commit / push / 세션 진행) 차단. 단일 layer로는 AI 실수 차단 부족
- **L3 — CHANGELOG는 sessions/meta/와 보완 관계** — sessions/는 audit trail (Claude 관점), CHANGELOG는 highlight (사용자 관점). 둘 다 필요

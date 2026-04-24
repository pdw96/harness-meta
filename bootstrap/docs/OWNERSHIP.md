# Ownership — 세션 소속 판단 규약

하네스 관련 변경을 **어느 세션 디렉토리에 귀속시킬지** 결정하는 단일 소스.
`sessions/meta/v1.2-ownership-rules/`에서 확정. 차후 모든 `/harness-meta` 세션이 따른다.

## 왜 필요한가

- `/harness-meta` command는 argument 없으면 CWD basename을 target으로 간주
- 그러나 **"세션 소속"은 CWD가 아니라 "변경 대상의 scope"** — CWD에서 실행해도 글로벌 레이어를 검증/수정하는 세션은 `sessions/meta/` 소속
- v1.1-global-smoke-test가 CWD=upbit에서 글로벌 레이어를 검증하다 초기에 `sessions/upbit/`에 잘못 생성된 사례 → 규약 부재의 직접 비용

## Scope 분류 (S1–S7)

변경이 닿는 **물리 경로**를 기준으로 scope를 판정한다.

| # | Scope | 물리 경로 | 소유 세션 |
|---|-------|----------|----------|
| **S1** | 글로벌 UX | `~/harness-meta/claude/**` — commands · agents · skills · hooks · statusline · output-styles | `sessions/meta/` |
| **S2** | Bootstrap 자산 | `~/harness-meta/bootstrap/**` — manifest-schema.md, templates/, docs/ (본 파일 포함), interview.md | `sessions/meta/` |
| **S3** | Repo 정책·설치 | `~/harness-meta/{README.md, CLAUDE.md, install.ps1}` | `sessions/meta/` |
| **S4** | 프로젝트 아키텍처 문서 | `~/harness-meta/projects/<name>/**` — ARCHITECTURE · DECISIONS · INTERVIEW · STACK | `sessions/<name>/` |
| **S5** | 프로젝트 실행기 코드 | `<proj>/scripts/harness/**`, `scripts/tests/harness/**`, `scripts/execute.py` | `sessions/<name>/` |
| **S6** | 프로젝트 매니페스트·Claude 설정 | `<proj>/{.harness.toml, .claude/, .mcp.json, docs/GUARDRAILS.md, docs/HARNESS.md}` | `sessions/<name>/` |
| **S7** | **비즈니스 코드 (본 체계 외)** | `<proj>/{bot, core, config, infra, docs/core, docs/scope, …}` | **meta 세션 대상 아님** — `/harness-plan`~`/harness-ship` 정식 플로우 |

### 핵심 분리선

- **S1–S3** — repo-global / 정책·규약. 한 번 바꾸면 모든 프로젝트 영향. meta 소유.
- **S4–S6** — 프로젝트-specific. 해당 프로젝트 한 곳에만 영향. `<name>` 소유.
- **S7** — 비즈니스 로직. meta 체계 밖. phase(`phases/{version}/{phase}/`) 문서 체계로 관리.

## Tie-breakers (T1–T5)

Scope 단일 매핑이 애매한 경우 순차 적용.

### T1 — 경로 다수결

세션이 건드리는 파일들을 S1–S6에 매핑, 다수파가 소유. 동률이면 T2로.

**예**: 본 v1.2 세션은 S1×1 + S2×1 + S3×2 → S1–S3 다수파 = meta 소유.

### T2 — 스펙 vs 값

- **스키마·규약·인터페이스 변경** → meta 소유 (한 번 바꾸면 모두에 영향)
- **해당 스펙의 단일 인스턴스·값** → project 소유

**예**: `.harness.toml` schema_version "1.0"→"1.1" 필드 추가는 meta. upbit의 `.harness.toml`에서 `code_dir` 값만 바꾸는 건 upbit.

### T3 — 검증 대상 기준

코드 수정 없이 **검증만** 수행하는 세션은 "검증 대상(verification target)"의 소유자를 따른다. **CWD 또는 실행 위치는 무관**.

**예**: v1.1 smoke test는 CWD=upbit에서 실행됐지만 대상은 글로벌 레이어(symlink / hook / statusline / MCP tools) → meta 소유.

**주의**: upbit `scripts/harness/`의 unit test 실행 결과 검증은 대상이 S5 → upbit 소유.

### T4 — 크로스 커팅은 분할

S1–S3과 S4–S6이 하나의 논리적 단위로 엮여야 하는 작업은 **두 세션으로 분할**한다.

- 선행: `sessions/meta/vX.Y-{spec}/` — 스펙·규약 정의
- 후행: `sessions/<name>/vX.Y-{apply}/` — 각 프로젝트 값 적용
- 두 세션은 서로 REPORT에서 **상호 링크** (선행 세션은 "후속 세션" 섹션, 후행 세션은 "선행 세션" 섹션)

**예**: `.harness.toml` schema "1.1" 도입 →
- `sessions/meta/vX.Y-manifest-schema-1.1/` (스펙 + 마이그레이션 가이드)
- `sessions/upbit/vX.Y-manifest-upgrade/` (upbit 매니페스트 1.0→1.1 실제 갱신)

단일 세션에서 크로스 커팅을 처리하면 scope 경계가 흐려져 감사(audit) 불가.

### T5 — 애매하면 meta

S1–S6 어느 쪽에도 명확히 속하지 않으면 **기본값은 meta**.

**이유**:
- `sessions/meta/`가 repo 정책의 기록소. "어디 속하는지 불명" 자체가 규칙의 빈틈 → meta에서 규약 보강
- 오분류 비용 비교: 잘못 meta로 묶는 경우(전체 가시성 유지) < 잘못 project로 묶는 경우(프로젝트 특화 문맥 가정 → 다른 프로젝트가 참조 불가)

**적용 후 액션**: 다음 meta 세션에서 본 OWNERSHIP.md에 신규 scope 또는 T# 추가 제안.

## PLAN 템플릿 — "세션 소속 근거" 섹션 규격

모든 `sessions/**/PLAN.md` 상단에 의무 배치.

```markdown
## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/{target}/`

**근거**:
- 변경 파일: <S# 분류 — 개수/비율>
- <T# 적용 내용 — 어느 규칙이 결정했는지>
```

**규칙**:
- **3줄 이내 권장, 최대 5줄.** 초과하면 scope 경계 불명료 신호 → T4 분할 또는 T5 적용 검토
- 적용된 **S#·T# 번호를 반드시 표기**. 사후 감사 가능하도록
- 검증-only 세션은 T3 명시 필수 (CWD와 소속이 다른 경우가 있으므로)

## Evolution 조항

본 규약은 **하네스 레이어 구조 변화**에 따라 개정된다.

### L3 추출 (코어 분리) 시

- 현재 S5(`<proj>/scripts/harness/**`)는 프로젝트 repo 소유 (각 프로젝트가 fork하여 진화 가정, H-ADR-001 트레이드오프)
- 향후 L3에서 하네스 코어를 별도 repo(`harness-core` 등)로 추출하면 S5는 성격상 S1에 근접 → **S5가 meta-class scope로 승격**
- **개정 트리거**: `sessions/meta/vX.Y-ownership-l3/` 별도 세션에서 S5 재정의 + 프로젝트별 패치 지점(S5-local) 분리

### `.harness.toml` 스키마 진화 시

- `schema_version` bump 시 T4에 따라 meta 세션(스펙) + 각 project 세션(적용) 분리 원칙 유지
- 스키마 v2.0 breaking change 시 본 OWNERSHIP.md의 S6 기술 내용 갱신 필요

### 신종 자산 도입 시

- 공유 pre-commit 훅, 공통 GitHub Actions workflow 템플릿 등 신종 자산은 최초 도입 시 T5로 meta 소유 → 사용 패턴 확인 후 본 문서에 신규 S# 추가 가능

### AGENTS.md 오픈 표준 채택 시 (v1.5 확정)

`sessions/meta/v1.5-agents-md-strategy/`에서 **AGENTS.md를 프로젝트 컨텍스트 파일의 source of truth로 채택**. 본 규약에 미치는 영향:

- **S1 (글로벌 UX) 확장**: `claude/**`에서 `adapters/{claude-code, cursor, codex-cli, gemini-cli, windsurf, cline, aider}/**`로 확장 예정 (v1.8-core-adapter-split). 각 adapter 디렉토리는 S1 유지.
- **S2 (Bootstrap 자산) 확장**: `bootstrap/docs/AGENTS_MD_STRATEGY.md`가 S2에 추가. 파일명 매핑 매트릭스·symlink/copy 이중 전략·locale 정책의 단일 소스.
- **S4 (프로젝트 아키텍처 문서)에 영향 없음**: `projects/<name>/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md`는 AGENTS.md와 별개 (프로젝트별 하네스 아키텍처 기록).
- **프로젝트의 `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` 등**: S6 (프로젝트 매니페스트·Claude 설정)에 귀속. 해당 프로젝트 세션에서 다룸 (T4 크로스 커팅 분할 원칙 — 스펙은 meta, 적용은 각 project).
- **`.agents/skills/` 표준 경로**: 2025-12 SKILL.md 표준 채택. Claude Code의 `.claude/skills/`는 junction/symlink로 연결. 상세: `AGENTS_MD_STRATEGY.md` §9.

## v1.1 motivating example

v1.1-global-smoke-test는 본 규약이 해결하는 문제의 **실제 사례**다.

- **목표**: 글로벌 레이어(symlink, hook, statusline, MCP tools) 정상 작동 검증
- **실행 위치**: CWD=upbit (다른 CWD에서는 글로벌 레이어가 어떻게 작동하는지 볼 수 없으므로)
- **잘못된 최초 분류**: `sessions/upbit/` (CWD basename 기준)
- **올바른 분류**: `sessions/meta/` (검증 **대상**이 글로벌 레이어이므로 T3 적용)
- **정정**: 사용자 지적으로 이동 완료 (`sessions/meta/v1.1-global-smoke-test/`)

본 규약 도입 이후는 PLAN 상단의 "세션 소속 근거" 섹션에서 T3를 명시적으로 적용 → 동일 오분류 원천 차단.

## 관련 문서

- 상위 진입점: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 세션 시작 command: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- 확정 세션 기록: [`../../sessions/meta/v1.2-ownership-rules/`](../../sessions/meta/v1.2-ownership-rules/)
- motivating example: [`../../sessions/meta/v1.1-global-smoke-test/REPORT.md`](../../sessions/meta/v1.1-global-smoke-test/REPORT.md)

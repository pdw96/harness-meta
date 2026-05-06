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
| **S1a** | 글로벌 UX (최소) | `~/harness-meta/claude/**` — `commands/harness-meta.md` + `hooks/` + `statusline/` (v1.8+) | `sessions/meta/` |
| **S1b** | 메타 소유 프로젝트 템플릿 | `~/harness-meta/bootstrap/templates/_base/.claude/**` — commands/agents/skills/output-styles (v1.8+) | `sessions/meta/` |
| **S1c** | 메타 소유 글로벌 user-skill | `~/harness-meta/bootstrap/skills/<category>/<name>/**` — 모든 사용자에게 배포되는 글로벌 스킬 (v1.19+, v1.36 2단계 카테고리 도입: audit/ + dev-tools/). `install-skills.{ps1,sh}` opt-in 배포 → `~/.claude/skills/<name>/` symlink (1단계 평탄). 사례: ai-ready-scorer + harness-plan-verify + harness-roadmap-update + mindvault + developer-profile (5건) | `sessions/meta/` |
| **S1d** | 메타 milestone 4-tier 트리 (v1.84+) | `~/harness-meta/milestones/v{X.Y}_{slug}/` — 메타 milestone 컨테이너. 4-tier 구조 (milestone PLAN.md + N개 plan-{n}-{slug}/PLAN+REPORT.md + 각 PLAN의 phase-{m}/ + milestone REPORT.md). vX.Y는 sessions/meta/와 통합 번호 공간 (단조 증가). regex `^v[1-9][0-9]*\.[0-9]+[a-z]?_[a-z0-9-]+$` (M{N} 폐기). 양방향 linkage (milestone PLAN의 N PLAN 사전 선언 ↔ 각 plan-{n}/PLAN). dogfood: v1.84_workflow-revamp. ADR-006-workflow-revamp. v1.83 milestone-phase 2-tier (M{N}/) 폐기 (revert `295bd16`). Meta-only scope (project ROADMAP은 evidence-driven 후속 `project-workflow-extension`) | `sessions/meta/` (이력 stamp만, 실 산출물은 `milestones/` 트리) |
| **S2** | Bootstrap 자산 | `~/harness-meta/bootstrap/**` — manifest-schema.md, templates/, docs/ (본 파일 포함), interview.md | `sessions/meta/` |
| **S3** | Repo 정책·설치 | `~/harness-meta/{README.md, CLAUDE.md, install.ps1, install-skills.{ps1,sh}}` | `sessions/meta/` |
| **S4** | 프로젝트 아키텍처 문서 | `~/harness-meta/projects/<name>/**` — ARCHITECTURE · DECISIONS · INTERVIEW · STACK | `sessions/<name>/` |
| **S5** | 프로젝트 실행기 코드 | `<proj>/scripts/harness/**`, `scripts/tests/harness/**`, `scripts/execute.py` | `sessions/<name>/` |
| **S6** | 프로젝트 매니페스트·Claude 설정 | `<proj>/{.harness.toml, .claude/**, .mcp.json, docs/GUARDRAILS.md, docs/HARNESS.md}` — v1.8+ `.claude/**`는 install-project-claude로 배포된 하네스 명령 포함 | `sessions/<name>/` |
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

## Scope contract — "Scope inheritance" + "Out of scope" 섹션 규격

`sessions/meta/v1.10j-scope-contract-discipline/`에서 확정. over-scope drift 영구 차단 mechanism.

### 의무 위치

모든 `sessions/**/PLAN.md`의 "세션 소속 근거" 섹션 **직후**에 배치.

### 두 섹션 규격

#### `## Scope inheritance (verbatim from <선행 세션>)`

선행 세션 PLAN.md 또는 사용자 발의에서 **명시된 sub-item만** 인용. 변형·해석·추가 금지.

```markdown
## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/vX.Y-.../PLAN.md` Out of scope 표** (verbatim):

> (원문 그대로 인용)

**Parsed sub-items (N)**:

1. **item 1** — 설명
2. **item 2** — 설명
```

**규칙**:

- 선행 세션 Out of scope 표에서 본 세션으로 분리된 항목 또는 사용자 발의 verbatim 인용
- "Parsed sub-items"는 Claude가 본문 진입 전 **사전 공개 선언** — 이후 모든 작업은 이 목록에 매핑 가능해야 함
- 인용 원문을 자유 해석하거나 umbrella로 확장하면 **규약 위반**

#### `## Out of scope (explicit rejection)`

본 세션에서 발견했지만 **다루지 않는 항목**을 명시적으로 열거. 공백 = "인식하지 못했음"이 아니라 "없다"를 의미.

```markdown
## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 인접 발견 issue | vX.Y-{name} 또는 "evidence-driven 시" |
```

**규칙**:

- 인접 발견 issue는 **본 세션 본문에 흡수하지 않고 반드시 이 표에 추가**
- 분리 대상 세션 ID 또는 조건 명시 (세션 없으면 `후속 미정` 허용)
- 구현 중 추가 발견 시 표를 **즉시 갱신** (post-hoc도 허용, 사후 누락 금지)

### 위반 정책

| 위반 유형 | 처치 |
|---------|------|
| 두 섹션 중 하나라도 누락 | PLAN 거부 + 사용자 재작성 요청 |
| Scope inheritance에 없는 항목을 본문에서 구현 | Over-scope — PLAN 거부 또는 Out of scope 표에 이관 후 재확인 |
| Out of scope 표 구현 중 누락 추가 | PLAN.md 즉시 갱신 후 계속 (경미) |

### 레거시 세션

본 규약 이전(`v1.10j` 이전) 세션은 소급 의무 없음. `tests/smoke-scope-contract.sh`는 default 호출 시 `v1.10h` 이후 세션만 검사 (`v1.10h`/`v1.10h2`/`v1.10h3`은 1차 demo로 두 § 자연 보유 → PASS).

#### `--include-legacy` opt-in pathway (v1.34+)

legacy 23건 (v1.0 ~ v1.10g) 점진 마이그레이션을 위한 도구 인프라. default 호출 (검증 + `--fix`) 영향 0. opt-in trigger 시만 enumerate에 legacy 추가.

```bash
bash tests/smoke-scope-contract.sh --include-legacy             # legacy 포함 검증 (FAIL 다수 정상 — § 부재 가시화)
bash tests/smoke-scope-contract.sh --include-legacy --fix --dry-run  # G2 21건 fix plan + G1 2건 SKIP
```

**G1 (2건, anchor 부재 → 자동 fix 불가)**: `v1.0-bootstrap`, `v1.1-global-smoke-test`. `## 세션 소속 근거` § 부재 (chain head — 첫 세션은 본질적으로 선행 세션 부재). 사용자 수동 작성 의무 또는 SKIP 영구 유지.

**G2 (21건, anchor 보유 → fix 적용 가능)**: `v1.2 ~ v1.10g`. `--include-legacy --fix` 시 skeleton 자동 삽입 가능.

#### ⚠️ R-WARP — Retroactive § 작성 시 4 risk

| Risk | 메커니즘 | 회피 |
|------|---------|------|
| **R-WARP1** | Scope inheritance "verbatim from 선행 세션" 의무인데 선행도 § 부재 → 인용 source 없음 | "Source — 사용자 발의 (retroactive)" 형식으로 본문 "배경"에서 추출 |
| **R-WARP2** | TODO placeholder 영구 잔존 (사용자 채움 누락) | smoke `--include-legacy` 호출 시 FAIL/SKIP 명시 가시화 |
| **R-WARP3** | G1 chain head 본질적 anchor 부재 | 명시 SKIP, 자동 anchor 추가 시도 안 함 |
| **R-WARP4** | Legacy = closed historical record. retroactive § 추가는 audit trail 시간 거짓 risk | **사용자 자율 영역 — Claude 강제 적용 안 함**. `--include-legacy` opt-in trigger 시만 |

도입 세션: [`../../sessions/meta/v1.34-legacy-plan-migration/`](../../sessions/meta/v1.34-legacy-plan-migration/). `v1.10j` Out of scope "기존 모든 sessions PLAN.md 소급 갱신 ... 점진 마이그레이션" verbatim 정합. v1.27 `smoke-spec-verification.sh` LEGACY_REPORTS 패턴 + v1.33 `--fix` 인프라 답습.

### Spec verification (context7) § (v1.24+)

`sessions/meta/v1.24-plan-spec-verification/`에서 본 Scope contract 패턴을 재사용해 추가 § 의무화. **메타 세션 PLAN의 "Out of scope" § 직후**에 `## Spec verification (context7)` § 의무 (sub-field 5종 + Citations). 외부 spec drift 검증 결과 기록. 상세 규격 + SKILL `harness-plan-verify` 사용법: [`SPEC_VERIFICATION.md`](SPEC_VERIFICATION.md). 검증: `tests/smoke-spec-verification.sh`.

### Smoke `--fix` mode (v1.33+)

`tests/smoke-scope-contract.sh --fix`로 두 § 부재 PLAN에 본 §Scope contract 정합 skeleton 자동 삽입 (`## 세션 소속 근거` § 직후). TODO placeholder 잔존 — 사용자/SKILL이 채움. 도입 세션: [`../../sessions/meta/v1.33-fix-scope-contract/`](../../sessions/meta/v1.33-fix-scope-contract/). v1.29 `tests/smoke-spec-verification.sh --fix` 패턴 답습.

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
- **적용 사례 — v1.0 → v1.1 (2026-04-25)**: `sessions/meta/v1.7-manifest-schema-v1.1/`에서 SemVer minor(additive only) bump. 신규 필드(`runtime_version`, `locale`, `statusline_cmd`, `statusline_timeout_ms`, `state_file`, `[agents]`, `[build]`, `format_cmd`) 추가. `python_version` deprecated retained. 기존 v1.0 매니페스트(upbit 포함) 무변경 계속 작동. upbit 실제 필드 추가는 별도 `sessions/upbit/vX-manifest-upgrade-1.1/`에서 T4 분할 수행

### 신종 자산 도입 시

- 공유 pre-commit 훅, 공통 GitHub Actions workflow 템플릿 등 신종 자산은 최초 도입 시 T5로 meta 소유 → 사용 패턴 확인 후 본 문서에 신규 S# 추가 가능

### claude/ 이관 (2026-04-25 v1.8)

`sessions/meta/v1.8-core-adapter-split/`에서 claude/ 축소 + `bootstrap/templates/_base/.claude/` 신설.

- **S1 split**: S1a(글로벌 최소) + S1b(메타 소유 템플릿) 분리.
- **S6 확장**: `<proj>/.claude/**`는 이제 `install-project-claude.{ps1,sh}`로 배포되는 하네스 명령을 명시적으로 포함 (기존 `<proj>/.claude/`만으로 모호했음 → 명확화).
- **Breaking**: 기존 프로젝트(upbit 포함)는 글로벌 symlink로 받던 `/harness-plan` 등을 상실. 복구는 `sessions/<name>/vX-project-claude-install/` 별도 세션.

⚠️ 주의 — Anthropic 공식 문서(code.claude.com) 2026-04 기준 `.claude/commands/`를 **legacy format**으로 표기하고 `.claude/skills/`를 preferred로 권장. v1.8은 commands 그대로 이관하는 **과도기**이며, 향후 `v1.8b-commands-to-skills-migration` 또는 v1.11+ bootstrap-templates 세션에서 commands → skills 통합 재설계 예정.

### commands → skills 통합 (2026-04-25 v1.8b)

`sessions/meta/v1.8b-commands-to-skills-migration/`에서 `_base/.claude/commands/` 6 파일을 `_base/.claude/skills/*/SKILL.md`로 `git mv` (이력 보존). 각 SKILL.md에 `name`(slash UX 유지) + `disable-model-invocation: true` 추가. commands/ 디렉토리 완전 제거. Anthropic preferred format 채택. BREAKING — 각 프로젝트 `install-project-claude` 재실행 필요 (upbit는 `sessions/upbit/v1.1-skills-migration/` 후속).

### Frontmatter 5축 통합 (2026-04-27 v1.10d)

`sessions/meta/v1.10d-bash-permission-pattern-audit/`에서 frontmatter + Bash() 5축 spec 통합 (S1a 1 + S1b 3 + S2 2). `claude/commands/harness-meta.md` `tools:` → `allowed-tools:` 정정 (slash command 공식 필드) + 5 파일 콤마 separator → YAML list + 공백 패턴 형식 + auto-allow set redundant 제거 (16 → 9 Bash). 단일 소스: `bootstrap/docs/PERMISSION_PATTERN.md`. T4 후행: `sessions/upbit/v1.2-bash-permission-update/` (upbit deployed 6 SKILL + settings 36 패턴).

### 글로벌 user-skill 신설 (2026-04-29 v1.19)

`sessions/meta/v1.19-scorer-skill-distribution/`에서 **S1c 신규** — `bootstrap/skills/<name>/`로 글로벌 user-skill source 단일화.

- **배경**: ai-ready-scorer가 `~/.claude/skills/`(git 미추적)에만 있어 v1.18b 변경분 57 lines 손실 위험. 다른 기기 재현 불가.
- **결정**: `bootstrap/skills/<name>/`을 source-of-truth로 채택. `install-skills.{ps1,sh}` opt-in으로 `~/.claude/skills/`에 symlink 배포. `install.ps1`(글로벌 자동) 흡수 회피로 S1a 안정성 보호.
- **명확 분리**: `bootstrap/skills/` = 글로벌 user-skill / `bootstrap/templates/_base/.claude/skills/` = 프로젝트별 skill. 디렉토리 위치로 의도 표현.
- **첫 적용**: ai-ready-scorer (v1.19에서 이관). 다른 글로벌 skill 이관은 evidence-driven 후속.
- **S3 확장**: `install-skills.{ps1,sh}` 추가.
- 상세: [`SKILLS.md`](SKILLS.md).

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

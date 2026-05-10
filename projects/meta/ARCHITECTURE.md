# meta — Harness Architecture

harness-meta repo 자체의 **하네스** 아키텍처 스냅샷. 글로벌 통합 레이어(slash command / hook / statusline / skills) + 메타 milestone trace 보유. 본 repo가 곧 'meta project'의 작업 공간 — `projects/upbit/` 와 비대칭 (upbit milestones는 upbit repo, meta milestones는 본 repo의 `projects/meta/milestones/`).

> 운영 가이드 + CRITICAL 규칙: root [`../../CLAUDE.md`](../../CLAUDE.md). 영문 요약: [`../../AGENTS.md`](../../AGENTS.md). 본 파일 § 1 디렉토리 트리가 글로벌 시스템 도식 단일 source.

## 1. 디렉토리 구조

```
harness-meta/
├── ROADMAP.md                      # thin index — { projects: [{name, roadmap_path}] }
├── CLAUDE.md                       # root 운영 가이드 (@ROADMAP.md 자동 로드)
├── AGENTS.md                       # 영문 요약 (외부 AI 도구 / 오픈소스 방문자용)
├── README.md                       # 사용자 진입 (영문)
├── projects/
│   ├── meta/                       # ★ 본 디렉토리 (meta as project)
│   │   ├── CLAUDE.md               # subdirectory guide — meta 작업 시 lazy load
│   │   ├── ARCHITECTURE.md         # 본 파일
│   │   ├── ROADMAP.md              # meta milestones 5건
│   │   └── milestones/             # 9-stage milestone 산출물 (v2.0+, v1.x = 7-stage era + v1.84~v1.88 = 4-tier era 보존, § 6 era 정책 참조)
│   │       └── v{X.Y}_{slug}/
│   │           ├── INTENT.md       # 의도 (goal/success_criteria/out_of_scope/dependencies) — 구 PLAN.md (v1.x era)
│   │           ├── RESEARCH.md     # 조사 (external/codebase/options/risks_identified)
│   │           ├── DESIGN.md       # 설계 (decisions/approach/phases/risk_mitigation)
│   │           ├── APPROVE.md      # 사용자 명시 승인 gate (approved_by/date/approval_summary) — 9-stage 신규
│   │           ├── execute/phase-{n}.md  # per-phase 구현 (1 phase = 1 commit)
│   │           ├── VERIFY.md       # 검증 (smoke/criteria_check/verdict)
│   │           ├── REPORT.md       # 종합 backward (summary/delta/lessons_learned)
│   │           └── PROPOSE.md      # 후속 forward (next_candidates ROADMAP 등록) — 9-stage 신규
│   └── upbit/
│       ├── ARCHITECTURE.md
│       └── ROADMAP.md              # upbit milestones는 upbit repo 자체에 위치
├── claude/                         # 글로벌 레이어 (commands/hooks/statusline)
├── bootstrap/skills/               # 글로벌 user-skill 매트릭스
├── tests/                          # smoke + pre-commit autofix
└── docs/{adr,ARCHITECTURE.md}      # 아키텍처 docs + ADR
```

## 2. 모듈 책임 요약

| 모듈 | 역할 | 위임 |
|---|---|---|
| `claude/{commands,hooks,statusline}/` | 글로벌 layer (slash command + hook + statusline) | [`../../claude/CLAUDE.md`](../../claude/CLAUDE.md) |
| `bootstrap/skills/` | 글로벌 user-skill (audit / dev / etc.) | [`../../bootstrap/skills/CLAUDE.md`](../../bootstrap/skills/CLAUDE.md) |
| `tests/` | smoke + pre-commit autofix-or-fail wrapper | [`../../tests/CLAUDE.md`](../../tests/CLAUDE.md) |
| `projects/meta/milestones/` | 메타 milestone 9-stage 기록 (v2.0+; v1.x 7-stage era + v1.84~v1.88 4-tier era 참조용 보존) | (본 디렉토리) |
| `docs/adr/` | ADR (architecture decision records) | [`../../docs/adr/README.md`](../../docs/adr/README.md) |

## 3. 하네스 엔지니어링 정의 (정전 — single source)

### 3.1 Working definition

> 하네스 엔지니어링은 agent 의 행동을 Markdown narrative + 파일 trace 로 결속하여 인프라 자동화 의존을 최소화하는 활동이다. 5요소 (Context / Workflow / Constraint / Verification / Trace) 가 정전 분류이며, 신규 작업 발의는 본 5요소 중 하나에 매핑되어야 한다.

**여기서 '인프라 자동화 의존 최소화' 란**: SKILL 자동 invoke / hook hard-code / smoke 키워드 강제 / settings.json permission gate 같은 자동화 메커니즘에 작업의 **정합성·의사결정·trace** 를 맡기지 않는다는 뜻이다. 자동화는 **보조**이며, PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 narrative + 사용자 명시 approval gate 가 **1차 source**. 자동화 자체를 거부하지는 않는다 — 다만 자동화가 1차 source 가 되면 narrative 와 drift 하고 (예: v1.2 lessons '메시지 1건 변경 → smoke 6건 연쇄') 정전성이 약화되므로, 자동화는 항상 narrative 의 보조 역할로 위치한다.

### 3.2 Working philosophy

> ★ harness-meta 의 working philosophy: narrative + 파일 trace 우선, 인프라 자동화 최소화, 단일 source 정합. SKILL 인프라·자동 hook gate 보다 PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 MD narrative + 사용자 명시 approval gate 를 1차 source 로 둔다.

### 3.3 5요소 매트릭스

| 요소 | (a) 책임 | (b) 메커니즘 cross-ref | (c) 정전 vs 임시방편 분류 |
|---|---|---|---|
| Context | agent 가 작업 시 흡수하는 정보 source 의 결속 | root [`CLAUDE.md`](../../CLAUDE.md) 자동 로드 + 모듈 CLAUDE.md lazy load + 메모리 (auto memory) + sub-agent prompt 의 manual inject (v1.75 컨벤션, SKILL 자동 invoke 거부) | 정전 (manual injection 컨벤션 채택). SKILL 자동 invoke 부분만 임시방편 |
| Workflow | milestone 단위 작업의 단계 분할 + 산출물 형식 통일 | 9-stage pipeline (ROADMAP 입력 source → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE), 단어 = 단일 책임 1:1 매핑, [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 진입점, 모든 산출물 MD + JSON 코드블록 | 정전 (v1.0_workflow-redesign 으로 7-stage 확립 + v2.0_workflow-word-fidelity 로 9-stage 단어 부합 정정) |
| Constraint | agent 가 위반하면 안 되는 규칙·금지·승인 게이트 | root [`CLAUDE.md`](../../CLAUDE.md) CRITICAL 섹션 + APPROVE.md.approved_by (`"user"` + date ISO-8601, 9-stage era v2.0+) 또는 DESIGN.approval (7-stage era v1.x 보존) + [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 금지 목록 + settings.json permission | 정전 (APPROVE.md / DESIGN.approval 게이트 + CRITICAL narrative). settings.json permission 은 보조 메커니즘 |
| Verification | 산출물 정합·schema·회귀 자동 검증 | [`../../tests/`](../../tests/) smoke 27종 + pre-commit hook (.pre-commit-config.yaml) + `.github/workflows/ci.yml` + `VERIFY.md` (criteria_check) | 정전 — VERIFY.md narrative 가 1차 source. smoke shell / install / verify 인프라 는 narrative 보조 (drift 항목 제거 후 잔존 인프라가 [`tests/CLAUDE.md`](../../tests/CLAUDE.md) 매트릭스에 회귀 차단 책임 명시 — active 5 = pre-commit 강제, inactive 22 = manual run leverage) |
| Trace | 의사결정·실행 이력의 영속 보존 — 외부 컨벤션 부재, 메타 고유 | [`milestones/`](milestones/) 9-stage 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md, v2.0+) 또는 7-stage 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute, v1.x era 보존) 또는 4-tier 산출물 (v1.84~v1.88 era 보존) + git history + ROADMAP.milestones[] | 정전 (메타 고유 차별화 — 외부 'agent harness' 컨벤션 부재 지점) |

### 3.4 외부 컨벤션 관계

외부 컨벤션 (Anthropic / Claude Code) 의 'agent harness' 는 **명시 working definition 부재** — hooks / settings.json permission / sub-agents / SKILL 등 메커니즘 묶음으로 사용. 본 정의는 외부 spec 추수가 아니라 사용자·repo 자체 working definition 정전화 (v1.3_harness-engineering-definition RESEARCH external#1). 5요소 (b) 메커니즘 cross-ref 가 외부 컨벤션 (hook / settings / SKILL / sub-agent) 에 자연 매핑되며, **'Trace' 요소는 외부 컨벤션 부재 — 메타 고유 차별화 지점** (REPORT.md + execute/phase-{n}.md 의 영속 파일 trace).

### 3.5 ★ 단일 source 정합

본 § 3 (하네스 엔지니어링 정의) 는 본 파일 (`projects/meta/ARCHITECTURE.md`) 이 **단일 source**. 다른 문서 (root [`../../CLAUDE.md`](../../CLAUDE.md), [`../../AGENTS.md`](../../AGENTS.md), [`../../README.md`](../../README.md), [`CLAUDE.md`](CLAUDE.md), [`../../GUARDRAILS.md`](../../GUARDRAILS.md)) 는 cross-ref 만, 정의 본문·매트릭스 중복 금지. 향후 정의 갱신 시 본 § 3 만 수정.

### 3.6 신규 milestone 발의 시 평가 절차

새 milestone 을 발의·설계할 때:

1. 본 5요소 (Context / Workflow / Constraint / Verification / Trace) 중 어느 요소에 속하는지 INTENT.motivation 또는 DESIGN.decisions 에 명시 (v2.0+ era. v1.x 7-stage era 보존 milestone 은 PLAN.motivation 으로 동치)
2. (c) 분류가 '정전' 인 요소를 보강하는가, '임시방편' 인 요소를 정전화하는가, 또는 '혼재' 의 임시방편 부분을 narrative 로 대체하는가 분명히
3. 위 매핑이 안 되는 작업은 본 정의 scope 외 — milestone 진입 자체 재고

## 4. 9-stage workflow (v2.0+)

```
ROADMAP (입력 source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE
```

단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity 정정):

| Stage | 산출 파일 | 단어 책임 |
|:-:|---|---|
| OPEN (A) | (디렉토리 생성) | 컨테이너 마운트 + ROADMAP entry `in_progress` |
| INTENT (B) | `INTENT.md` | 의도 — goal / motivation / success_criteria / out_of_scope / dependencies |
| RESEARCH (C) | `RESEARCH.md` | 조사 — external / codebase / options / risks_identified |
| DESIGN (D) | `DESIGN.md` | 설계 — decisions / approach / phases / risk_mitigation + 5 관점 검토 |
| APPROVE (E) | `APPROVE.md` | 사용자 명시 승인 게이트 — approved_by / date / approval_summary |
| EXECUTE (F) | `execute/phase-{n}.md` | per-phase 구현 (1 phase = 1 commit, conventional commits) |
| VERIFY (G) | `VERIFY.md` | 검증 — smoke / criteria_check / verdict |
| REPORT (H) | `REPORT.md` | 종합 backward — summary / delta / lessons_learned |
| PROPOSE (I) | `PROPOSE.md` | 후속 forward — next_candidates ROADMAP 등록 |

Historical era (참조용 보존, § 6 era 정책 참조):

- **7-stage era (v1.0~v1.4)**: ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT (산출 5종 + execute)
- **4-tier era (v1.84~v1.88)**: 어셈블 plan-N/{PLAN,REPORT}.md (참조용 보존)

자세한 단계별 책임 + 절차 + AskUserQuestion trigger + 금지 목록은 root [`../../CLAUDE.md`](../../CLAUDE.md) § "워크플로우 (v2.0+ 9-stage)" + slash command [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 참조.

## 5. 비대칭 의도 (CRITICAL)

`projects/meta/milestones/` 는 본 repo 안에 존재하지만 `projects/upbit/milestones/` 는 **부재** — upbit milestone 산출물은 upbit repo 자체에 위치한다 (root CLAUDE.md "프로젝트별 하네스 개선" 컨벤션). meta는 본 repo가 곧 자체 작업 공간이므로 본 repo의 `projects/meta/milestones/` 보유.

이 비대칭은 의도적: `projects/<name>/` 는 "harness-meta 가 인지하는 프로젝트 trace 의 view" 이며, meta 만 본 repo 가 곧 작업 repo 이므로 milestones/ 디렉토리 보유. 미래 N 개 프로젝트 추가 시 동일 패턴 — 작업 repo 가 곧 본 repo 인 경우만 `projects/<name>/milestones/` 보유, 나머지는 ROADMAP + ARCHITECTURE 만.

## 6. 변경 시 주의 + era 정책

- root `CLAUDE.md` / `AGENTS.md` 갱신 시 본 ARCHITECTURE.md 동기 검토 (drift risk)
- 신규 milestone 진입 시 `projects/meta/milestones/v{X.Y}_{slug}/` 생성 (root `milestones/` 부활 금지)
- root ROADMAP.md 는 thin index 유지 — milestones[] 키 추가 금지 (smoke `tests/smoke-projects-scope-discipline.sh` 가 차단)
- ★ § 3 (하네스 엔지니어링 정의) 본문·매트릭스는 **본 파일이 단일 source** — 다른 문서로 복제 금지, cross-ref 만 허용

### 6.1 era 정책 (3 era 명문화)

milestone 디렉토리 안 산출 파일명 자체로 era 자동 추론:

| era | version 범위 | 산출 파일 (era 표지) | 신규 작업 |
|---|---|---|---|
| **9-stage** | v2.0+ | `INTENT.md` + `APPROVE.md` + `PROPOSE.md` (3종 신규 = era 식별) + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ✅ 의무 |
| **7-stage** | v1.0~v1.4 | `PLAN.md` 존재 + `INTENT.md`/`APPROVE.md`/`PROPOSE.md` 동시 부재 (= era 식별) + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 참조용 보존, 신규 금지 |
| **4-tier** | v1.84~v1.88 | 어셈블 plan-N/{PLAN,REPORT}.md (sub-plan 구조 = era 식별) | ❌ 참조용 보존, 신규 금지 |

**자기참조 회피 표지**: 본 milestone `v2.0_workflow-word-fidelity` 자체는 7-stage 포맷 (PLAN.md / DESIGN.md / REPORT.md) 으로 진행 — 9-stage 가 본 milestone 의 산출물이므로 진행 중 적용 시 chicken-and-egg. v2.1+ 부터 9-stage 의무 적용.

**smoke 자동 식별 보조**: `tests/smoke-spec-verification.sh` 가 위 era 표지 파일 존재 여부로 era 분류 후 schema 차별화 검증 (narrative 1차 source + smoke 보조, ARCHITECTURE § 3.1 정책 일관).

## 7. 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- 영문 요약: [`../../AGENTS.md`](../../AGENTS.md)
- ADR: [`../../docs/adr/README.md`](../../docs/adr/README.md)
- subdirectory CLAUDE.md (lazy): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone (메타): [`ROADMAP.md`](ROADMAP.md)

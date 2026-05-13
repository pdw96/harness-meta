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
│   │   └── milestones/             # 9-stage-bundled (v3.0+) / 9-stage (v2.0~v2.1) / 7-stage (v1.0~v1.4) / 4-tier (v1.84~v1.88) era 공존, § 6.1 era 정책 참조
│   │       ├── v{X.Y}/             # 9-stage-bundled era (v3.0+) — version 디렉토리 (sub-id 부재, milestones.md 위임)
│   │       │   ├── milestones.md   # sub-milestone listing per version (id/title/status/phase 매핑) — 9-stage-bundled 신규
│   │       │   ├── INTENT.md       # 통합 의도 (goal/success_criteria/out_of_scope/dependencies)
│   │       │   ├── RESEARCH.md     # 통합 조사
│   │       │   ├── DESIGN.md       # 통합 설계 (sub-milestone = phase 매핑)
│   │       │   ├── APPROVE.md      # 사용자 명시 승인 gate
│   │       │   ├── execute/phase-{n}.md  # per-phase 1 commit (sub-milestone 1:1)
│   │       │   ├── VERIFY.md       # 통합 검증
│   │       │   ├── REPORT.md       # 통합 backward
│   │       │   └── PROPOSE.md      # 후속 forward
│   │       └── v{X.Y}_{slug}/      # 9-stage (v2.0~v2.1) / 7-stage (v1.0~v1.4) / 4-tier (v1.84~v1.88) era 보존
│   │           ├── INTENT.md       # 의도 — 구 PLAN.md (7-stage era v1.x)
│   │           ├── RESEARCH.md
│   │           ├── DESIGN.md
│   │           ├── APPROVE.md      # 9-stage era v2.0+ (7-stage 부재)
│   │           ├── execute/phase-{n}.md
│   │           ├── VERIFY.md
│   │           ├── REPORT.md
│   │           └── PROPOSE.md      # 9-stage era v2.0+ (7-stage 부재)
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
| Workflow | milestone 단위 작업의 단계 분할 + 산출물 형식 통일 + version 단위 통합 | 9-stage pipeline (ROADMAP 입력 source → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE), 단어 = 단일 책임 1:1 매핑, v3.0+ 9-stage-bundled era — version 단위 1 milestone (sub-milestone phase 매핑, milestones.md per version 위임, § 6.1 bundling 정책), [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 진입점, 모든 산출물 MD + JSON 코드블록 | 정전 (v1.0 7-stage 확립 → v2.0 9-stage 단어 부합 → v3.0 9-stage-bundled hierarchy) |
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

## 4. 9-stage workflow (v2.0+) + bundling (v3.0+)

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

**B/C/D 부산물의 PROPOSE 흡수 책임** (v3.10_stage-byproduct-clarification): B (`INTENT.out_of_scope`) / C (`RESEARCH.untouched_files_explicit` / `risks_identified`) / D (`DESIGN.decisions[i].rationale` / `phases[n].scope`) 의 부산물은 본 stage 의 **사실 진술 책임** 안 — 후속 milestone 명명 + ROADMAP 등재는 I (PROPOSE) 통합 흡수 단일 책임. 정의 보강 narrative: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) Stage B/C/D/I 참조.

**Word-fidelity drift 수용** (v3.19_word-fidelity-audit-v2 진단 + v3.20_drift-narrative-canonicalization 정전화): 위 9-stage 단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity 정정) 은 ideal 목표이며, 실 운용 부합도는 9 stage 평균 ~86.1% (APPROVE 100% 최고 부합 / PROPOSE 70% 최대 drift / OPEN 90% / INTENT 80% / RESEARCH 85% / DESIGN 80% / EXECUTE 85% / VERIFY 95% / REPORT 90%) — [`milestones/v3.19/RESEARCH.md`](milestones/v3.19/RESEARCH.md) 정량 1차 source. drift 의도성 = pragmatic 절충: 단일 책임 100% 부합 추구 시 workflow 비대화 risk (예: PROPOSE register 책임 분리 = 10-stage breaking change v4.0). drift 수용은 § 6.2 workflow self-improvement 동결 정책과 정합 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, 실 변경 (10-stage 분리 / ROADMAP 재정의 / 단어 변경) 은 evidence-base trigger 만.

### 4.1 Bundling (v3.0+ 9-stage-bundled era)

v3.0_milestones-restructure 도입 — 같은 의미 단위 (모듈 / 주제 / lessons_learned) 후속 candidates 는 version 단위 1 milestone 에 통합:

- **ROADMAP `milestones[]` entry**: version 단위 1건 (`{version, id, title, status, summary, trigger}`). version + id 분리 schema (id = group-slug)
- **디렉토리**: `milestones/v{X.Y}/` (sub-id 부재 — milestones.md 위임)
- **산출물**: INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 통합 1건씩 + `milestones.md` (sub-milestone listing per version, id/title/status/phase 매핑) + `execute/phase-{n}.md` (sub-milestone 1:1 매핑, 각 1 commit)
- **자기참조 부합** (도그푸드, v3.0+ 권장): 새 era 도입 milestone 자체가 신 구조 첫 적용. 회피 표지 (v2.0_workflow-word-fidelity 7-stage 포맷 사용 선례) 는 chicken-and-egg 위험 시만 예외

상세 bundling trigger 조건 + 자기참조 정책 + breaking change 정책: § 6.1.

Historical era (참조용 보존, § 6.1 era 정책):

- **9-stage era (v2.0~v2.1)**: 디렉토리 `v{X.Y}_{slug}/` + INTENT/APPROVE/PROPOSE 3종 신규 (산출 7종 + execute)
- **7-stage era (v1.0~v1.4)**: 디렉토리 `v{X.Y}_{slug}/` + PLAN.md (산출 5종 + execute)
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

### 6.1 era 정책 (4 era 명문화 + bundling)

milestone 디렉토리 명 + 산출 파일명 자체로 era 자동 추론:

| era | version 범위 | era 표지 (smoke 자동 식별) | 신규 작업 |
|---|---|---|---|
| **9-stage-bundled** | v3.0+ | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `milestones.md` (sub-milestone listing per version) + INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md | ✅ 의무 |
| **9-stage** | v2.0~v2.1 | 디렉토리 명 `v{X.Y}_{slug}` + INTENT/APPROVE/PROPOSE 3종 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 신규 금지 (v3.0+ 9-stage-bundled 의무, forward-only 정책) |
| **7-stage** | v1.0~v1.4 | 디렉토리 명 `v{X.Y}_{slug}` + PLAN.md 존재 + INTENT/APPROVE/PROPOSE 동시 부재 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 참조용 보존, 신규 금지 |
| **4-tier** | v1.84~v1.88 | 어셈블 plan-N/{PLAN,REPORT}.md (sub-plan 구조) | ❌ 참조용 보존, 신규 금지 |

**bundling 정책 (9-stage-bundled era, v3.0+)**: version (= 1 milestone) 단위로 의미 단위 후속 candidates 를 묶음.

- **묶이는 단위 (의미 grouping)**: (a) 같은 모듈 영향 (예: tests/CLAUDE.md 동시 수정), (b) 같은 주제 (예: smoke 인프라 / 정책 명문화), (c) 같은 lessons_learned 에서 발의된 후속 candidates
- **분리 단위 (별 milestone)**: 다른 모듈 / 다른 주제 / 시간 단위만 같은 (release train 모델 부적합)
- **운용**: 한 milestone (= version) 안 sub-milestone 들은 phase 단위 1 commit 으로 운용. INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 산출물은 통합 1건. ROADMAP `milestones[]` entry 는 version 단위 1건 (sub-milestone 상세는 milestones.md 위임)

**1-phase milestone 정합 (v3.17_phase-distribution-audit 진단 + v3.18_option-a-natural-adaptation-narrative 정전화)**: 같은 의미 단위 후속 candidates 가 1건 (= `sub_milestones[]` 1 entry) 일 때도 본 era 정합 — `milestones.md` 가 narrative 1차 source 책임 충족하면 phase 다중 통합 (≥2 건 자연 활용) 와 1-phase 정전화 (1 건) 두 경로 모두 정상. 정량: v3.7~v3.16 = 100% 1-phase, v3.x 전체 17 milestone = 12/17 = 70.6% 1-phase (`projects/meta/milestones/v3.17/RESEARCH.md` 분포표 1차 source). bundling 의미 grouping 본질 = 후속 candidates 가 ≥2 건일 때 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재.

**자기참조 부합 (도그푸드, v3.0+ 권장)**: 새 era 도입 milestone 자체가 신 구조 첫 적용. 회피 표지 (v2.0 선례 — 본 milestone `v2.0_workflow-word-fidelity` 자체가 7-stage 포맷 사용, chicken-and-egg 회피) 는 신뢰 부족 시만 예외. v3.0_milestones-restructure 는 부합 채택 — phase-1 smoke era branching 선결 commit 으로 chicken-and-egg mitigate.

**breaking change → major bump (semver)**: era 도입 (= ROADMAP schema + 디렉토리 명 + 모든 cross-ref 영향) 은 breaking change → major bump (예: v2 → v3). semver.org 정합. 단조 증가 정책 (root CLAUDE.md) 직접 적용.

**era 영구화 trade-off (forward-only)**: era N 추가 = smoke 분기 N+1 코드 복잡도 누적. forward-only 정책 (historical 디렉토리 unchanged) 의 직접 비용. detect_era 함수 (`tests/_era_detect.py`, v2.2_era-detect-shared-module 흡수 v3.0 phase-2) 단일 source 로 mitigate. era N+1 추가 시 본 § 6.1 표 + tests/_era_detect.py 갱신 의무.

**milestones.md spec historical era 적용 결정 (v3.1 phase-2 흡수)**: milestones.md spec picture-frame (`projects/meta/milestones/v3.0/milestones.md` § Spec, v3.0 phase-5 도입) 의 적용 era 정책 = **옵션 (a) forward-only 강제**. v3.0+ 9-stage-bundled era 만 milestones.md 의무 (§ 6.1 표 행 1), historical era (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier) 부재 영구. rationale: (1) v2.x 9-stage flat 구조 = 디렉토리 명 `v{X.Y}_{slug}` 단위 1 milestone (sub-milestone 부재) → milestones.md 의 sub_milestones[] phase 매핑 본질 부적합, (2) v1.x 7-stage / 4-tier 동일, (3) forward-only 정책 (§ 6.1 'era 영구화 trade-off') 직접 일관 — historical 디렉토리 unchanged. 옵션 (b) v2.x retroactive / (c) 신규만 거부 — (b) 본질 부적합 + git mv history 위험, (c) (a) 와 사실상 동치. spec picture-frame: `projects/meta/milestones/v3.0/milestones.md`. 본 결정은 v3.1_workflow-policy-fine-tuning phase-2 흡수, historical 디렉토리 변경 부재.

**smoke 자동 식별 보조**: `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` 가 위 era 표지로 era 분류 후 schema 차별화 검증 (narrative 1차 source + smoke 보조, § 3.1 정책 일관). detect_era 함수는 `tests/_era_detect.py` 단일 source.

### 6.2 Lightweight 모드 정책 (v3.6_overengineering-audit 도입)

Self-referential milestone (workflow / smoke 인프라 자체 강화) 은 narrative 5~9x overhead 양산 위험 + 자기참조 사이클 진입 위험을 보유한다. v3.6_overengineering-audit 진단 결과 — 본 repo 18일간 24 milestone 중 9건이 workflow self-improvement, pending 6건 중 4건이 workflow narrative 강화 — 외부 권위 (Martin Fowler 'lightweight harness', OpenAI Bitter Lesson 'do not build massive control flows', Anthropic Skills 'progressive disclosure') 와 정면 충돌 확인. lightweight 모드 표지 정책으로 mitigate.

**Lightweight 모드 trigger 조건** (3 모두 충족 시 권장 적용):

1. 본질이 workflow / smoke / cross-ref / era 분기 등 메타 인프라 자체 변경 (외부 프로젝트 적용 부재)
2. 변경 scope 작음 (≤5 파일 또는 narrative 강화 중심)
3. 5 관점 의견 충돌 부재 예상 (architecture / 보안 분기 부재)

**적용 시 차이**:

- 산출물 LOC cap (각 < 150줄, 총 < 850줄 권고. v3.5 897줄 = 일반 모드 baseline, v3.6 본 milestone 적용 cap)
- 5 관점 subagent 병렬 검토 **생략** (scope 따라 3 관점 또는 0 관점)
- 자기참조 부합 (도그푸드) **거부 + 회피 표지 명시 의무** (`milestones.md self_reference_policy: "avoid"` + `self_reference_rationale` 필드)

**Workflow self-improvement milestone 동결 정책 (v3.6 권고 #1)**: workflow self-improvement (`claude/commands/harness-meta.md` / `tests/CLAUDE.md` / 본 ARCHITECTURE.md § 4 변경) 만을 본질로 하는 milestone 은 **evidence-base trigger 만 발의 허용** — release train (정기 narrative 강화) 또는 lessons_learned 자동 후속 등재로 발의 **금지**. 발의 trigger 조건: 외부 프로젝트 (`projects/<name>/`, `name ≠ meta`) 실 적용 milestone 1건 완료 후, 그 정량 데이터에 근거한 명시적 사용자 발의만.

**선례**:

- v2.0_workflow-word-fidelity (7-stage 포맷 자기참조 회피 표지, chicken-and-egg 회피 — 첫 사례)
- v3.6_overengineering-audit (자기참조 사이클 진단 자체가 lightweight 모드 — narrative cap + 5 관점 생략 + 본 § 6.2 도입 milestone)

## 7. 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- 영문 요약: [`../../AGENTS.md`](../../AGENTS.md)
- ADR: [`../../docs/adr/README.md`](../../docs/adr/README.md)
- subdirectory CLAUDE.md (lazy): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone (메타): [`ROADMAP.md`](ROADMAP.md)

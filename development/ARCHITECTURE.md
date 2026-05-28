# meta — Harness Architecture

harness-meta repo 자체의 **하네스** 아키텍처 스냅샷 — 구조 + 정체성 + 책임 레이어. 사전적 architecture 정의 ("전체의 뼈대·구성요소·관계") 정합 단일 source.

> 운영 가이드 + CRITICAL 규칙: root [`../CLAUDE.md`](../CLAUDE.md). 영문 요약: [`../AGENTS.md`](../AGENTS.md). 본 파일 § 1 디렉토리 트리가 글로벌 시스템 도식 단일 source.
>
> **본질 분리 (v9.1+)**: 본 ARCHITECTURE.md = 구조 + 정체성 + 책임 레이어 단일 source. 워크플로우 정의 (9-stage / bundling / Stage 본질 / 가벼운 흐름 / 분야 발현) 1차 source = [`WORKFLOW.md`](WORKFLOW.md). 운영 매뉴얼 (비대칭 의도 / era 정책 / AI Native 정의 / entry title 가이드) 1차 source = [`OPERATIONS.md`](OPERATIONS.md). v9.1_architecture-md-split-by-canonical-definition 정전화.

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
├── agents/                         # 글로벌 subagent (plugin_root standard, v5.1+) — 10 멤버 flat
├── skills/                         # 글로벌 user-skill (plugin_root standard, v5.1+) — 15 skill flat
├── claude/                         # 글로벌 레이어 (commands/hooks/statusline)
├── bootstrap/skills/               # 글로벌 user-skill 정책 narrative (CLAUDE.md only, v5.1+)
├── tests/                          # smoke + pre-commit autofix
└── docs/{adr,ARCHITECTURE.md}      # 아키텍처 docs + ADR
```

## 2. 모듈 책임 요약

| 모듈 | 역할 | 위임 |
|---|---|---|
| `claude/{commands,hooks,statusline}/` | 글로벌 layer (slash command + hook + statusline) | [`../../claude/CLAUDE.md`](../claude/CLAUDE.md) |
| `bootstrap/skills/` | 글로벌 user-skill (audit / dev / etc.) | [`../../bootstrap/skills/CLAUDE.md`](../bootstrap/skills/CLAUDE.md) |
| `tests/` | smoke + pre-commit autofix-or-fail wrapper | [`../../tests/CLAUDE.md`](../tests/CLAUDE.md) |
| `development/milestones/` | 메타 milestone 9-stage 기록 (v2.0+; v1.x 7-stage era + v1.84~v1.88 4-tier era 참조용 보존) | (본 디렉토리) |
| `docs/adr/` | ADR (architecture decision records) | [`../../docs/adr/README.md`](../docs/adr/README.md) |

## 3. 하네스 엔지니어링 정의 (정전 — single source)

### 3.1 Working definition

> 하네스 엔지니어링은 agent 의 행동을 Markdown narrative + 파일 trace 로 결속하여 인프라 자동화 의존을 최소화하는 활동이다. 5요소 (Context / Workflow / Constraint / Verification / Trace) 가 정전 분류이며, 신규 작업 발의는 본 5요소 중 하나에 매핑되어야 한다.

**여기서 '인프라 자동화 의존 최소화' 란**: SKILL 자동 invoke / hook hard-code / smoke 키워드 강제 / settings.json permission gate 같은 자동화 메커니즘에 작업의 **정합성·의사결정·trace** 를 맡기지 않는다는 뜻이다. 자동화는 **보조**이며, PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 narrative + 사용자 명시 approval gate 가 **1차 source**. 자동화 자체를 거부하지는 않는다 — 다만 자동화가 1차 source 가 되면 narrative 와 drift 하고 (예: v1.2 lessons '메시지 1건 변경 → smoke 6건 연쇄') 정전성이 약화되므로, 자동화는 항상 narrative 의 보조 역할로 위치한다.

**harness-meta repo 정체성** (v4.0_harness-composer-pivot, 2026-05-13; v8.x adapter-neutral remodel; v9.0_multi-llm-adapter-tiers, 2026-05-28): 본 repo 는 위 working definition 을 적용하는 구체 instance — **LLM-agnostic harness engineering consultant + project harness composer + reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)**. 대상 프로젝트를 먼저 벤더 중립 5요소 (Context / Workflow / Constraint / Verification / Trace) 로 분석하고, 그 결과를 active AI tool surface 에 맞는 adapter 로 배치한다. 현 production adapter 는 [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소 harness 구성요소 (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) 를 만들어 배치한다. mechanical install/update/cleanup 도 agent (`component-installer`) 가 직접 담당 — static install script 부재. GitHub 인기 저장소 + Claude Code release notes 를 정기 벤치마크하여 업그레이드 검토 + agent fleet 자체 lifecycle (scope 확장 / 분할 / 신규 / 통합 / 삭제) 도 관리하되, Claude Code 특화 자산은 core 방법론이 아니라 adapter 구현으로 분류한다. Custom 과 built-in 충돌 / fleet evolution 모두 `audit → propose → 사용자 명시 결정 → apply` (e3) 적용. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md).

**Core / Adapter 분리 원칙**: 5요소 모델, 9-stage/4-section 흐름, approval gate, smoke/verification, trace 보존은 core spec 이다. Claude Code plugin manifest / agents / skills / hooks / slash command 는 Claude adapter 이다. 향후 Codex / Cursor / Gemini / Copilot 같은 다른 LLM surface 는 별도 adapter 로 추가하되, `AGENTS.md` / `.cursor/rules` / `GEMINI.md` / `.github/copilot-instructions.md` 같은 tool-specific 파일을 선제 생성하지 않는다. 실제 contributor 가 해당 tool 을 사용하고 사용자 명시 결정이 있을 때만 adapter 산출물을 추가한다.

**mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리** (v4.2_verify-infra-agent-absorption 도입): harness-meta 안 'mechanical install/update/cleanup' 본질 책임 (script 폐기 후 agent 흡수 가능 — v4.0 install + v4.2 verify/sync) 과 Claude Code spec 의무 실 실행 컴포넌트 (settings.json 안 등록된 OS subprocess — `claude/hooks/{session-init.sh, post-report-write.sh}` + `claude/statusline/statusline.sh`) 는 본질 분리. spec 의무 컴포넌트는 agent 흡수 불가능 (agent = Claude Code session 안 Task 호출, hook = OS-level subprocess, recursion 차단). 정체성 (project harness composer + agent fleet maintainer) 확장 시 본 분리 narrative 정합.

**Install 정책 = Claude Code Plugin spec 전면 채택** (v5.0_plugin-pivot, 2026-05-14): harness-meta 자체가 Claude Code Plugin — `.claude-plugin/plugin.json` (manifest, paths 명시 = agents/commands/hooks/skills) + `.claude-plugin/marketplace.json` (local marketplace, source = `.`) 정전. 사용자 onboarding = `claude plugin marketplace add pdw96/harness-meta` (외부, clone 불요, v5.3+) 또는 `git clone` + `claude plugin marketplace add ~/harness-meta` (로컬) + `claude plugin install harness-meta@harness-meta` 표준 CLI 명령. GitHub shorthand 는 전체 repo clone → `./"` relative path 정상 작동 (context7 spec 확인). Plugin source 거주 위치 = `~/.claude/plugins/cache/harness-meta/` (Claude Code 표준). 현 inventory = `plugin.json` agents explicit file list 10 멤버 + `./skills/` 15 skill 인식 + `./claude/commands/` slash commands + hooks.json (PostToolUse Write\|Edit + SessionStart matcher, `${CLAUDE_PLUGIN_ROOT}` 변수 활용). Agent file list 를 explicit 로 둔 이유 = `agents/project-harness-audit-team/CLAUDE.md` 같은 module guide 가 plugin agent 로 오인되지 않도록 배포 surface 를 좁히기 위함. Plugin 채택 효익 = (1) Developer Mode 의존 0 + (2) ecosystem integrator 정체성 정합 + (3) install scope user/project/local 선택 + (4) enable/disable/uninstall 표준 lifecycle + (5) agent/skill 확장분 배포 누락 해소. component-installer agent 책임 분리 — custom component lifecycle (milestone 산출물 mechanical apply) 보존 + Plugin install lifecycle (mechanical) Claude Code CLI 위임. **Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — 자연어 호출 `~~harness-meta 설치해줘~~` + v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup retention) 는 historical narrative 만 보존 (v4.x milestone 산출물 안 인용 source). v4.x 환경 안 `~/.claude/agents/` 5 멤버 SymbolicLink 잔존 시 manual cleanup 권고 narrative — 정확 명령 [`../../README.md`](../README.md#installation).

**Historical narrative — Install 정책 본질** (v4.3_subagent-discovery-path-research 도입, v5.0 채택 narrative 의 source): 현 (deprecated) harness-meta install (~/.claude/{commands,hooks,statusline,skills,agents}/ 안 SymbolicLink default + Copy fallback 매핑) 의 본질 근거 = Claude Code spec 안 subagent/command/hook/statusline/skill discovery 경로 `~/.claude/<category>/` 단일 강제 (sub-agents docs / settings docs context7 검증). Plugin spec 안 marketplace local source + plugin manifest paths = install (SymbolicLink/Copy 매핑) 회피 경로 발견. trade-off 분석 narrative source = [`milestones/v4.3/RESEARCH.md`](milestones/v4.3/RESEARCH.md) + [`milestones/v5.0/DESIGN.md`](milestones/v5.0/DESIGN.md).

**정체성-운용 vector drift 수용** (v5.8_identity-application-vector-audit, 2026-05-17): 위 § 3.1 끝 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 도입 (v4.0, 2026-05-13) 후 ~4일 운영분 수 = 12 meta milestone (v4.0~v5.7, 100% self-loop = 9785 LOC 안 mechanical install/Plugin 44.1% + agent fleet evolution 22.2% + 정체성 pivot 19.0% + RESEARCH/narrative 14.7%) + 1 외부 적용 (upbit v1.17, 2026-05-14, `/harness-meta upbit --audit` audit-team chain 5 멤버 완전 작동 + 12 항목 mechanical apply, evidence 강력) = 13 / 12 self-loop = 92.3%. 운용 부합도 sub-metric (가중 평균 77.5%) — composer 50% × 0.4 (audit-team 작동 evidence 강력 / 빈도 1/13) + integrator 60% × 0.3 (spec drift detection 5건 / 벤치마크 routine 0건) + maintainer 70% × 0.3 (fleet 진화 3건 / 분할·통합·삭제 0건). drift 본질 = v5.0 Plugin pivot (2026-05-14) 자기 강화 cascade — spec-drift 자기 detect (v5.1/5.2/5.4) + environment-auditor 자기 진화 (v5.5/5.6) + narrative 정전화 자기 강화 (v5.7) 3축이 Plugin spec 자체를 self-recruit attractor 화. 가드레일 진화 trend = v3.6 § 6.2 강한 정책 → v3.17 PROPOSE 거명 약 → v3.19/v5.8 narrative 흡수 medium (v4.0 § 6.2 폐지로 strong 가드레일 자체 부재). drift 수용 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, § 6.2 (v4.0 폐지) 재도입 등 실 가드레일 변경은 evidence-base trigger 만 (cycle 4 trigger 조건 = 외부 적용 5건 추가 누적 ∧ 사용자 명시 발의 AND, 현 reverse evidence 6건 누적 = deferred 동결 정량 정당화). 자세히: [`milestones/v5.8/RESEARCH.md`](milestones/v5.8/RESEARCH.md) 정량 1차 source + 보강 분석 § A1~A9.

**운영 원칙 측면 보완** (v6.0_ai-native-operation-reframe-and-entry-title-guideline, 2026-05-19): 위 정체성 (v4.0) 이 '책임 / 결과물' 차원 (composer + integrator + maintainer) 이라면, 운영 원칙 / 운영 방식 차원의 보완 정의 = § 7 AI Native 운영 (컨텍스트 효율 + 자율성 + 다중 AI 협업 3 면 매트릭스). 두 차원 직교 — 신규 milestone 발의 시 본 § 3.1 정체성 + § 7 AI Native 운영 양방향 cross-ref 평가.

**검증철학 — 자기개발(책상 검증) ≠ 제품 역량 검증(현장 검증)** (v8.6_verification-philosophy-redefine, 2026-05-26): **자기개발 횟수(meta self-loop, ~200 milestone)는 제품 역량 검증의 증거가 아니다.** harness-meta 는 자기 자신을 만드는 도구라 dogfooding(자기개발)은 불가피하고 계속돼야 하나, '컨설팅 자산(방법론·도구·외부 제공물)이 실제로 외부에서 통하는가'는 자기개발 횟수로 입증되지 않는다 — 요리사가 자기 음식을 시식한 횟수가 손님 만족도가 아닌 것과 같다. 따라서 두 범주를 명시적으로 분리한다:

- **자기개발 = 책상 검증** (meta self-loop): 설계 정합·schema·회귀를 self 점검. 검증 방식 = 9-stage VERIFY(G) + 5요소 Verification(§ 3.3) + smoke. **무엇을 보장하는가** = 산출물이 내부 정전 규칙에 부합함. **보장하지 못하는 것** = 외부·이질 환경에서의 제품 역량.
- **제품 역량 검증 = 현장 검증** (외부 적용, 외부 vector): upbit / price-compare 등 외부 프로젝트에 컨설팅 자산을 실제 적용. **이것이 제품 컨설팅 자산의 1차 역량 검증 vector 다.** 실증 누적(현 evidence 2건, forward 누적) = (1) v8.3 — 외부 이종 스택(price-compare: Next.js/TS/Prisma)에서만 audit-team '신규=백지' 전제 결함이 관찰됨(self-loop 로는 절대 불가, [`milestones/v8.3/LIGHTWEIGHT.md`](milestones/v8.3/LIGHTWEIGHT.md) L41). (2) v8.5 — 외부 대조 audit 으로 v8.4 보강의 실효 확인 + 비발화 대조군이 1건 과적합 risk 를 실 반증([`milestones/v8.5/LIGHTWEIGHT.md`](milestones/v8.5/LIGHTWEIGHT.md) L49/L54). 외부 vector 의 '결함 검출'·'정정 실효' 양면 실증.

**self-loop 92.3% 수치 재라벨**: 위 § 3.1 v5.8 paragraph 의 'self-loop 92.3% / 운용 부합도 77.5%'는 **v4.0~v5.7, 13 milestone 기준 시점 고정 진단 수치**이며, 본 검증철학상 **'자기개발 trace 통계'이지 '제품 역량 검증 성숙도'가 아니다** — 이 수치를 '제품이 외부에서 통한다'는 증거로 오독하면 안 된다(dogfooding 착시). 수치 자체는 trace 사실로 보존하되 해석은 본 분리 선언에 종속한다.

**'검증' 단어 3중 의미 경계** (단어-책임 1:1 매핑 v2.0 정합 — 한 단어 세 책임이 아니라 세 라벨 세 책임):

| 라벨 | 층위 | 본질 | host (정의 위치) |
|---|---|---|---|
| 9-stage VERIFY (stage G) | 책상 (자기점검) | milestone 단위 smoke / criteria_check vs INTENT / verdict | § 4 9-stage 표 |
| 5요소 Verification | 책상 (자기점검) | 산출물 정합·schema·회귀 자동 검증 | § 3.3 Verification row |
| 제품 역량 검증 (외부 vector) | 현장 (역량) | 외부 적용으로 컨설팅 자산이 실제 통하는가 | § 3.1 본 paragraph |

본 검증철학 정전화 범위 = **원칙 선언(재정의)까지** — 외부 적용 능동 추진/의무화는 별도 후속(본 paragraph scope 밖). 산출물 = 문서 정전화 only(mechanism 부재). 자세히: [`milestones/v8.6/MILESTONE.md`](milestones/v8.6/MILESTONE.md). 운영 방식 측면 연결 = [`OPERATIONS.md`](OPERATIONS.md) § 3 (단방향 pointer, v9.1+ 분리 정합).

**Multi-LLM 어댑터 tier 정전화** (v9.0_multi-llm-adapter-tiers, 2026-05-28): 위 § 3.1 정체성 첫 줄 (v9.0 갱신) 안 '단수 Claude Code adapter maintainer → reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)' 격상 본질을 4 tier schema 로 정전. **핵심 원칙 한 줄** (정전): "목표는 LLM 도구 간 자동화 동등성이 아니라, 도구별 자동화 tier 를 인정하는 이식 가능한 방법론이다" (영어 derived: "The goal is not automation parity across LLM tools, but portable methodology with adapter-specific automation tiers"). **4 tier 분류**:

| Tier | 본질 | 현 instance |
|---|---|---|
| Core methodology | LLM-agnostic canonical spec — 5요소 (Context / Workflow / Constraint / Verification / Trace) + 9-stage workflow + milestone schema + verification policy + ROADMAP discipline. 도구 무관 정전 | § 3 working definition + § 3.5 표 외 모든 § |
| Reference adapter | Claude Code richest automation — subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin. Plugin spec 안 본 repo 자체 거주 | Claude Code (.claude-plugin/plugin.json + agents/ + skills/ + claude/) |
| Portable adapters | docs + CLI-first surface — 각 LLM 도구별 얇은 운영 지침 (Codex AGENTS.md / Gemini GEMINI.md / Cursor .cursor/rules/) + portable scripts. 자동화는 Reference 보다 minimal | Codex (AGENTS.md) Documentation-ready / Cursor (.cursor/rules/) Candidate / Gemini (GEMINI.md) Candidate |
| Optional integration | MCP wrappers — portable CLI 안정화 후 (v9.3+ portable scripts 정리 후) MCP server 안 wrapping. 모든 adapter 안 MCP 표면 호출 가능. CLI-first 후 2차 본질 | MCP (현 미배포, v10.0+ 별 milestone) |

본 격상 본질 = line 71 existing 'Core / Adapter 분리 원칙' (v4.0 도입) 의 격상 (신규 도입 아님) — line 71 안 'core spec / Claude adapter / 향후 Codex / Cursor / Gemini / Copilot 같은 다른 LLM surface 는 별도 adapter 로 추가' 분리 본질이 이미 존재하나 정체성 첫 줄 narrative 안 '단수 Claude Code adapter maintainer' 종속 표현으로 정합 부재. v9.0 = 본 분리 원칙을 첫 줄 narrative + tier schema 로 격상. major bump 정당성 = 정체성 첫 줄 breaking change (단수 → 복수 표현 cascade, 10 host 정합 — 한국어 primary 3 + 영문 primary 4 + v4.0 ecosystem-integrator 별 표현 3). § 3.5 'Adapter taxonomy' 표 안 Tier column 매핑 정합 (Reference / Portable / Optional integration 3 tier, Core methodology = § 3.5 외 본질). 자세히: [`milestones/v9.0/MILESTONE.md`](milestones/v9.0/MILESTONE.md).

### 3.2 Working philosophy

> ★ harness-meta 의 working philosophy: narrative + 파일 trace 우선, 인프라 자동화 최소화, 단일 source 정합. SKILL 인프라·자동 hook gate 보다 PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 MD narrative + 사용자 명시 approval gate 를 1차 source 로 둔다.

### 3.3 5요소 매트릭스

| 요소 | (a) 책임 | (b) 메커니즘 cross-ref | (c) 정전 vs 임시방편 분류 |
|---|---|---|---|
| Context | agent 가 작업 시 흡수하는 정보 source 의 결속 | Core = project facts / architecture / roadmap / local rules 를 어떤 AI 에게도 같은 의미로 제공. Claude adapter = root [`CLAUDE.md`](../CLAUDE.md) 자동 로드 + 모듈 CLAUDE.md lazy load + 메모리 (auto memory) + sub-agent prompt 의 manual inject (v1.75 컨벤션, SKILL 자동 invoke 거부). Codex 등 다른 adapter 는 `AGENTS.md` 또는 해당 tool surface 로 같은 core context 를 투영 | 정전 (manual injection 컨벤션 채택). SKILL 자동 invoke 부분만 임시방편 |
| Workflow | milestone 단위 작업의 단계 분할 + 산출물 형식 통일 + version 단위 통합 | Core = 9-stage pipeline (ROADMAP 입력 source → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE), 단어 = 단일 책임 1:1 매핑, v6.2+ 9-stage-flattened era — version 단위 1 milestone (`MILESTONE.md` 본책 + `execute/` 별책, sub-milestone phase 매핑은 `## SUB_MILESTONES` 위임, § 6.1), v8.1+ 4-section-lightweight era — 작은 건은 `LIGHTWEIGHT.md` 4 섹션. Claude adapter = [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) 진입점. 모든 산출물 Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body, v6.1+ 신규 schema, 이전 v1.0~v6.0 = MD + JSON 코드블록) | 정전 (v1.0 7-stage 확립 → v2.0 9-stage 단어 부합 → v3.0 9-stage-bundled hierarchy → v6.2 flattened → v8.1 lightweight two-track) |
| Constraint | agent 가 위반하면 안 되는 규칙·금지·승인 게이트 | Core = 사용자 승인 gate + 금지 행동 + repo boundary. Claude adapter = root [`CLAUDE.md`](../CLAUDE.md) CRITICAL 섹션 + APPROVE.md.approved_by (`"user"` + date ISO-8601, 9-stage era v2.0+) 또는 DESIGN.approval (7-stage era v1.x 보존) + [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) 금지 목록 + settings.json permission | 정전 (APPROVE.md / DESIGN.approval 게이트 + CRITICAL narrative). settings.json permission 은 보조 메커니즘 |
| Verification | 산출물 정합·schema·회귀 자동 검증 (**자기점검 = 책상 검증** 층위 — 제품 역량 검증(현장)은 § 3.1 검증철학 paragraph 의 별도 범주) | Core = deterministic smoke / criteria check / external application evidence. Current implementation = [`../../tests/`](../tests) smoke matrix + pre-commit hook (.pre-commit-config.yaml) + `.github/workflows/ci.yml` + `Makefile smoke` + `VERIFY.md` (criteria_check). Adapter 별 command 는 이 검증 묶음을 호출하는 얇은 entry 여야 함 | 정전 — VERIFY.md narrative 가 1차 source. smoke shell / install / verify 인프라 는 narrative 보조 (drift 항목 제거 후 잔존 인프라가 [`tests/CLAUDE.md`](../tests/CLAUDE.md) 매트릭스에 회귀 차단 책임 명시 — active 16 = pre-commit 강제 15 + manual 1, inactive 22 = manual run leverage; 실행 표면 동기화는 `smoke-workflow-registration.sh` 가 강제) |
| Trace | 의사결정·실행 이력의 영속 보존 — 외부 컨벤션 부재, 메타 고유 | Core = [`development/milestones/`](milestones/) meta milestone 산출물 (v6.2+ `MILESTONE.md` 또는 v8.1+ `LIGHTWEIGHT.md`, historical eras forward-only 보존) + target repo milestone artifacts for external projects + git history + `development/ROADMAP.md` milestones[] (recent 3 + in_progress + deferred, v5.21+ schema A2) + **GitHub Releases** (past completed archival 단일 source, v6.19+) + [`../../CHANGELOG.md`](../CHANGELOG.md) (v6.19 까지 historical hybrid, Keep a Changelog v1.1.0 정합, v5.21 도입). Adapter 산출물은 이 trace 를 참조하고 중복 source 를 만들지 않음 | 정전 (메타 고유 차별화 — 외부 'agent harness' 컨벤션 부재 지점). v5.21 안 sub-mechanism 분리 (forward-looking 부분 ROADMAP + past trace 부분) → v6.19 가 past trace 를 CHANGELOG → GitHub Releases 이전 (SIZE_LIMIT 회피), 3중 archival = REPORT.md(9-stage)/LIGHTWEIGHT.md ## 기록(가벼운 흐름, v8.13) + git log + GitHub Release |

### 3.4 외부 컨벤션 관계

외부 컨벤션 (Anthropic / Claude Code) 의 'agent harness' 는 **명시 working definition 부재** — hooks / settings.json permission / sub-agents / SKILL 등 메커니즘 묶음으로 사용. 본 정의는 외부 spec 추수가 아니라 사용자·repo 자체 working definition 정전화 (v1.3_harness-engineering-definition RESEARCH external#1). 5요소 (b) 메커니즘 cross-ref 가 외부 컨벤션 (hook / settings / SKILL / sub-agent) 에 자연 매핑되며, **'Trace' 요소는 외부 컨벤션 부재 — 메타 고유 차별화 지점** (REPORT.md + execute/phase-{n}.md 의 영속 파일 trace).

### 3.5 Adapter taxonomy

Adapter 는 core spec 을 특정 AI tool surface 로 투영하는 얇은 구현층이다. core 를 바꾸지 않고 adapter 만 바꿔야 여러 LLM 에 같은 컨설팅 방법론을 적용할 수 있다.

| Adapter | Surface | Status | Tier | Boundary |
|---|---|---|---|---|
| Claude Code | `.claude-plugin/plugin.json`, `agents/`, `skills/`, `claude/commands/`, `claude/hooks/`, statusline | Production | Reference adapter | 현재 repo 의 유일한 production adapter |
| Codex | `AGENTS.md`, repo-local skills/workflows, terminal verification commands | Documentation-ready | Portable adapter | 본 repo 안 `AGENTS.md` 는 cross-AI context 이지만 Codex 전용 adapter 파일은 아직 만들지 않음 |
| Cursor | `.cursor/rules/*.mdc` | Candidate | Portable adapter | contributor 가 Cursor 를 실제 사용하고 사용자 결정이 있을 때만 추가 |
| Gemini | `GEMINI.md` | Candidate | Portable adapter | contributor 가 Gemini 를 실제 사용하고 사용자 결정이 있을 때만 추가 |
| GitHub Copilot | `.github/copilot-instructions.md` | Candidate | Portable adapter | repo policy 와 충돌하지 않는 범위에서 별도 결정 필요 |
| MCP | MCP server wrapping portable CLI tools (smoke / schema validation / artifact scaffold / fact verification / cascade sync 등) | Optional | Optional integration | portable CLI 안정화 후 (v9.3+ portable scripts 정리 후) 진행. CLI-first 후 2차 본질. 모든 adapter 안 MCP 표면 호출 가능 |

v9.0_multi-llm-adapter-tiers (2026-05-28) 안 Tier column 추가 = § 3.1 v9.0 paragraph 4 tier schema 와 직접 매핑. Reference adapter (Claude Code 만) / Portable adapters (Codex + Cursor + Gemini + Copilot, docs + CLI-first surface) / Optional integration (MCP, CLI 안정화 후 2차) 3 tier 가 § 3.5 안 거주. Core methodology (Tier 1) = § 3.5 외 본질 — 5요소 + 9-stage + milestone schema 가 § 3 working definition + § 3.3 + § 4 등 § 3.5 외 모든 § 안 거주.

Adapter 추가 절차 = `audit → propose → 사용자 명시 결정 → apply → verify`. 선제 tool-file 생성 금지 원칙은 root [`AGENTS.md`](../AGENTS.md) Boundaries 와 동일하다.

### 3.6 ★ 단일 source 정합

본 § 3 (하네스 엔지니어링 정의) 는 본 파일 (`development/ARCHITECTURE.md`) 이 **단일 source**. 다른 문서 (root [`../../CLAUDE.md`](../CLAUDE.md), [`../../AGENTS.md`](../AGENTS.md), [`../../README.md`](../README.md), [`CLAUDE.md`](CLAUDE.md), [`../../GUARDRAILS.md`](../GUARDRAILS.md)) 는 cross-ref 만, 정의 본문·매트릭스 중복 금지. 향후 정의 갱신 시 본 § 3 만 수정.

### 3.7 신규 milestone 발의 시 평가 절차

새 milestone 을 발의·설계할 때:

1. 본 5요소 (Context / Workflow / Constraint / Verification / Trace) 중 어느 요소에 속하는지 INTENT.motivation 또는 DESIGN.decisions 에 명시 (v2.0+ era. v1.x 7-stage era 보존 milestone 은 PLAN.motivation 으로 동치)
2. (c) 분류가 '정전' 인 요소를 보강하는가, '임시방편' 인 요소를 정전화하는가, 또는 '혼재' 의 임시방편 부분을 narrative 로 대체하는가 분명히
3. 위 매핑이 안 되는 작업은 본 정의 scope 외 — milestone 진입 자체 재고

## 4. 3-way 책임 직교 (CLAUDE.md / .claude/rules/ / MEMORY) — v7.0 T1.1

Claude Code `.claude/rules/` mechanism (2026-w13+ 도입) 환경 안 컨텍스트 본질 3 분류 책임 직교. v7.0 T1.1 정전화 (정정 #3·#9, 2026-05-25).

| 본질 | 거주 | load 시점 | 책임 |
|---|---|---|---|
| **CLAUDE.md** | repo root + subdirectory | always-loaded (CWD 안 자동) | entry pointer + 구조 규칙 + 진입 narrative |
| **.claude/rules/** | `.claude/rules/*.md` (repo-local — plugin manifest 에 `rules` 필드 부재 → harness-meta repo 전용, 배포 안 됨) | path-scoped (frontmatter `paths:` glob 매칭 시 자동 inject) | mechanical rule (schema 의무 / smoke 정합) |
| **MEMORY** | `~/.claude/projects/<encoded>/memory/` | cross-session (memory tool inject) | personal preference + cross-project 일반 원칙 |

### 책임 직교 본질

- **CLAUDE.md** = 진입 narrative + 구조 규칙 + entry pointer (always-loaded 본질 정합 — 본질 정전화 한정).
- **.claude/rules/** = 특정 path 작업 시만 자동 inject (lazy load 본질 — Claude 컨텍스트 부하 최소화). repo-local = harness-meta repo 안 거주하는 mechanical rule 만 자연. cross-project 원칙은 거주 부적합 (repo 밖 미적용).
- **MEMORY** = 사용자 협업 본질 (선호도 / 과거 결정 / project state) + **cross-project 일반 원칙** (모든 repo 적용 본질). cross-session personal 본질 정합.

### archival 본질 (v7.0 T1.1 도입)

기존 MEMORY 안 mechanical rule 본질 중 **harness-meta repo-local** 4 entry (schema 의무 3 + smoke 정합 1) = `.claude/rules/` archival (단일 source 본질). 2 rule file 압축:

| rule file | 흡수 MEMORY entry | scope (paths) |
|---|---|---|
| `schema-discipline.md` | APPROVE.md wrap + INTENT.md id/title + cascade marker 16-hex | `projects/*/milestones/**/{APPROVE,INTENT}.md` + `**/*.md` |
| `candidate-draft-schema.md` | candidate_draft decision_pending = string | `projects/*/ROADMAP.md` |

**audit fact-hallucination 검증 의무 = MEMORY 유지** (정정 #3) — cross-project 일반 원칙 (모든 repo 의 Agent 호출에 적용)이므로 repo-local `.claude/rules/` 거주 부적합. 3-way 직교 정합. MEMORY.md index 17 → 13 entry (4 row 제거).

### 운영 index

- `.claude/rules/README.md` = operational index (2 rule file 매트릭스)
- 본 § = long-lived 1차 source (책임 직교 정의)

## 5. Auto-Mode 최소권한 + subagent frontmatter pattern — v7.0 T1.5

Claude Code Auto-Mode (2026-w13+ 공식 spec, context7 verify 2026-05-25 `/websites/code_claude`) 환경 안 subagent 최소권한 mechanism 정의. v7.0 T1.5 정전화 (정정 #1·#2). mechanism source-of-truth = `../../.claude/settings.json` (repo-local — plugin manifest 에 `settings` 필드 부재 → 배포 안 됨, § 4 `.claude/rules/` 와 일관).

### 5.1 Auto-Mode 4 분류

| 분류 | 본질 | 거주 |
|---|---|---|
| `autoMode.environment[]` | trusted source / path 명시 (LLM classifier 정합도 향상) | `.claude/settings.json` |
| `autoMode.allow[]` | 명시 허용 (prompt 부재) | 〃 |
| `autoMode.soft_deny[]` | 명시 금지 — prompt 발생 (사용자 명시 결정 게이트) | 〃 |
| `autoMode.hard_deny[]` | 절대 금지 — prompt 부재 + 자동 reject | 〃 |
| `$defaults` | built-in rule inherit (omit 시 모든 보안 default 제거 위험) | 각 array 안 첫 항목 |

`permissions.defaultMode: "auto"` = Auto-Mode 활성 스위치. **v7.0 = mechanism 설치만, `defaultMode` 미포함 (활성 보류)** — 정정 #7 'v7.0 설치 / 첫 사용 v7.1 격리' + 사용자 '커밋·배포 전 확인' 협업 본질 정합. v7.1 활성 결정 시 `permissions.defaultMode: "auto"` 추가.

### 5.2 subagent frontmatter pattern (3 subagent 정합)

| 본질 | design-review (T1.3, 생성) | Explore (built-in) | version-tracker (T1.6) |
|---|---|---|---|
| frontmatter `tools:` | Read, Grep, Glob (read-only) | (built-in, frontmatter 부재) | context7 2 + Read + Edit (minimal write) |
| `model:` | opus | (built-in default) | opus |
| Auto-Mode allow | inherit (read-only 자연) | inherit (read-only 자연) | 명시 (단일 file write, T1.6b) |
| settings.json 추가 | 부재 | environment 안 명시 | allow + soft_deny 명시 (T1.6b) |

본 § = mechanism source-of-truth 단일 책임. 실 적용 = T1.3 ([`design-review` **생성 완료**](../agents/design-review.md), read-only tools — v7.0 Tier 2) / T2.3 (Explore **활용 pattern** 정전화, environment — § 11) / T1.6b (version-tracker **권한 정전화**, allow + soft_deny) 안 각자 inherit — T1.5 이후 진입.

### 5.3 AI Native 정의 (OPERATIONS § 3) 자율성 면 cross-ref

OPERATIONS § 3 (AI Native 정의) 안 자율성 면 = Auto-Mode 정합 본질 (사용자 명시 결정 게이트 = `soft_deny` prompt 보존 + `hard_deny` 안전망). 단 v7.0 = mechanism 정의, 활성 v7.1 보류 (자율성 baseline 변경 없음).

## 6. 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../CLAUDE.md)
- 영문 요약: [`../../AGENTS.md`](../AGENTS.md)
- ADR: [`../../docs/adr/README.md`](../docs/adr/README.md)
- subdirectory CLAUDE.md (lazy): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone (메타): [`ROADMAP.md`](ROADMAP.md)

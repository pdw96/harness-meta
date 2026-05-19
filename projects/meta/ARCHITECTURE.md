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
├── agents/                         # 글로벌 subagent (plugin_root standard, v5.1+) — 7 멤버 flat
├── skills/                         # 글로벌 user-skill (plugin_root standard, v5.1+) — 5 skill flat
├── claude/                         # 글로벌 레이어 (commands/hooks/statusline)
├── bootstrap/skills/               # 글로벌 user-skill 정책 narrative (CLAUDE.md only, v5.1+)
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

**harness-meta repo 정체성** (v4.0_harness-composer-pivot, 2026-05-13): 본 repo 는 위 working definition 을 적용하는 구체 instance — **project harness composer + Claude Code ecosystem integrator + agent fleet maintainer**. 대상 프로젝트를 분석하고 [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소 harness 구성요소 (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) 를 만들어 배치한다. mechanical install/update/cleanup 도 agent (`component-installer`) 가 직접 담당 — static install script 부재. GitHub 인기 저장소 + Claude Code release notes 를 정기 벤치마크하여 업그레이드 검토 + agent fleet 자체 lifecycle (scope 확장 / 분할 / 신규 / 통합 / 삭제) 도 관리. 글로벌 자산은 `bootstrap/` 하위, 프로젝트 특화 자산은 `projects/<name>/.claude/` 하위 **두 층 구조**. Custom 과 built-in 충돌 / fleet evolution 모두 `audit → propose → 사용자 명시 결정 → apply` (e3) 적용. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md).

**mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리** (v4.2_verify-infra-agent-absorption 도입): harness-meta 안 'mechanical install/update/cleanup' 본질 책임 (script 폐기 후 agent 흡수 가능 — v4.0 install + v4.2 verify/sync) 과 Claude Code spec 의무 실 실행 컴포넌트 (settings.json 안 등록된 OS subprocess — `claude/hooks/{session-init.sh, post-report-write.sh}` + `claude/statusline/statusline.sh`) 는 본질 분리. spec 의무 컴포넌트는 agent 흡수 불가능 (agent = Claude Code session 안 Task 호출, hook = OS-level subprocess, recursion 차단). 정체성 (project harness composer + agent fleet maintainer) 확장 시 본 분리 narrative 정합.

**Install 정책 = Claude Code Plugin spec 전면 채택** (v5.0_plugin-pivot, 2026-05-14): harness-meta 자체가 Claude Code Plugin — `.claude-plugin/plugin.json` (manifest, paths 명시 = agents/commands/hooks/skills replace-default + add-to-default 패턴) + `.claude-plugin/marketplace.json` (local marketplace, source = `.`) 정전. 사용자 onboarding = `claude plugin marketplace add pdw96/harness-meta` (외부, clone 불요, v5.3+) 또는 `git clone` + `claude plugin marketplace add ~/harness-meta` (로컬) + `claude plugin install harness-meta@harness-meta` 표준 CLI 명령. GitHub shorthand 는 전체 repo clone → `./"` relative path 정상 작동 (context7 spec 확인). Plugin source 거주 위치 = `~/.claude/plugins/cache/harness-meta/` (Claude Code 표준), agents 필드 부재 → plugin_root `./agents/` default discovery = 7 멤버 (5 team + 2 standalone) 자동 인식 (v5.1_plugin-component-discovery-fix). skills 필드 `./skills/` (add-to-default) — 5 skill 자동 인식. hooks.json (PostToolUse Write\|Edit + SessionStart matcher, `${CLAUDE_PLUGIN_ROOT}` 변수 활용) 신규. Plugin 채택 효익 = (1) Developer Mode 의존 0 + (2) ecosystem integrator 정체성 정합 + (3) install scope user/project/local 선택 + (4) enable/disable/uninstall 표준 lifecycle + (5) 2 standalone subagent 미배포 자연 해소. component-installer agent 책임 분리 — custom component lifecycle (milestone 산출물 mechanical apply) 보존 + Plugin install lifecycle (mechanical) Claude Code CLI 위임. **Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — 자연어 호출 `~~harness-meta 설치해줘~~` + v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup retention) 는 historical narrative 만 보존 (v4.x milestone 산출물 안 인용 source). v4.x 환경 안 `~/.claude/agents/` 5 멤버 SymbolicLink 잔존 시 manual cleanup 권고 narrative — 정확 명령 [`../../README.md`](../../README.md#installation).

**Historical narrative — Install 정책 본질** (v4.3_subagent-discovery-path-research 도입, v5.0 채택 narrative 의 source): 현 (deprecated) harness-meta install (~/.claude/{commands,hooks,statusline,skills,agents}/ 안 SymbolicLink default + Copy fallback 매핑) 의 본질 근거 = Claude Code spec 안 subagent/command/hook/statusline/skill discovery 경로 `~/.claude/<category>/` 단일 강제 (sub-agents docs / settings docs context7 검증). Plugin spec 안 marketplace local source + plugin manifest paths = install (SymbolicLink/Copy 매핑) 회피 경로 발견. trade-off 분석 narrative source = [`milestones/v4.3/RESEARCH.md`](milestones/v4.3/RESEARCH.md) + [`milestones/v5.0/DESIGN.md`](milestones/v5.0/DESIGN.md).

**정체성-운용 vector drift 수용** (v5.8_identity-application-vector-audit, 2026-05-17): 위 § 3.1 끝 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 도입 (v4.0, 2026-05-13) 후 ~4일 운영분 수 = 12 meta milestone (v4.0~v5.7, 100% self-loop = 9785 LOC 안 mechanical install/Plugin 44.1% + agent fleet evolution 22.2% + 정체성 pivot 19.0% + RESEARCH/narrative 14.7%) + 1 외부 적용 (upbit v1.17, 2026-05-14, `/harness-meta upbit --audit` audit-team chain 5 멤버 완전 작동 + 12 항목 mechanical apply, evidence 강력) = 13 / 12 self-loop = 92.3%. 운용 부합도 sub-metric (가중 평균 77.5%) — composer 50% × 0.4 (audit-team 작동 evidence 강력 / 빈도 1/13) + integrator 60% × 0.3 (spec drift detection 5건 / 벤치마크 routine 0건) + maintainer 70% × 0.3 (fleet 진화 3건 / 분할·통합·삭제 0건). drift 본질 = v5.0 Plugin pivot (2026-05-14) 자기 강화 cascade — spec-drift 자기 detect (v5.1/5.2/5.4) + environment-auditor 자기 진화 (v5.5/5.6) + narrative 정전화 자기 강화 (v5.7) 3축이 Plugin spec 자체를 self-recruit attractor 화. 가드레일 진화 trend = v3.6 § 6.2 강한 정책 → v3.17 PROPOSE 거명 약 → v3.19/v5.8 narrative 흡수 medium (v4.0 § 6.2 폐지로 strong 가드레일 자체 부재). drift 수용 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, § 6.2 (v4.0 폐지) 재도입 등 실 가드레일 변경은 evidence-base trigger 만 (cycle 4 trigger 조건 = 외부 적용 5건 추가 누적 ∧ 사용자 명시 발의 AND, 현 reverse evidence 6건 누적 = deferred 동결 정량 정당화). 자세히: [`milestones/v5.8/RESEARCH.md`](milestones/v5.8/RESEARCH.md) 정량 1차 source + 보강 분석 § A1~A9.

**운영 원칙 측면 보완** (v6.0_ai-native-operation-reframe-and-entry-title-guideline, 2026-05-19): 위 정체성 (v4.0) 이 '책임 / 결과물' 차원 (composer + integrator + maintainer) 이라면, 운영 원칙 / 운영 방식 차원의 보완 정의 = § 7 AI Native 운영 (컨텍스트 효율 + 자율성 + 다중 AI 협업 3 면 매트릭스). 두 차원 직교 — 신규 milestone 발의 시 본 § 3.1 정체성 + § 7 AI Native 운영 양방향 cross-ref 평가.

### 3.2 Working philosophy

> ★ harness-meta 의 working philosophy: narrative + 파일 trace 우선, 인프라 자동화 최소화, 단일 source 정합. SKILL 인프라·자동 hook gate 보다 PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 MD narrative + 사용자 명시 approval gate 를 1차 source 로 둔다.

### 3.3 5요소 매트릭스

| 요소 | (a) 책임 | (b) 메커니즘 cross-ref | (c) 정전 vs 임시방편 분류 |
|---|---|---|---|
| Context | agent 가 작업 시 흡수하는 정보 source 의 결속 | root [`CLAUDE.md`](../../CLAUDE.md) 자동 로드 + 모듈 CLAUDE.md lazy load + 메모리 (auto memory) + sub-agent prompt 의 manual inject (v1.75 컨벤션, SKILL 자동 invoke 거부) | 정전 (manual injection 컨벤션 채택). SKILL 자동 invoke 부분만 임시방편 |
| Workflow | milestone 단위 작업의 단계 분할 + 산출물 형식 통일 + version 단위 통합 | 9-stage pipeline (ROADMAP 입력 source → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE), 단어 = 단일 책임 1:1 매핑, v3.0+ 9-stage-bundled era — version 단위 1 milestone (sub-milestone phase 매핑, milestones.md per version 위임, § 6.1 bundling 정책), [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 진입점, 모든 산출물 Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body, v6.1+ 신규 schema, 이전 v1.0~v6.0 = MD + JSON 코드블록) | 정전 (v1.0 7-stage 확립 → v2.0 9-stage 단어 부합 → v3.0 9-stage-bundled hierarchy) |
| Constraint | agent 가 위반하면 안 되는 규칙·금지·승인 게이트 | root [`CLAUDE.md`](../../CLAUDE.md) CRITICAL 섹션 + APPROVE.md.approved_by (`"user"` + date ISO-8601, 9-stage era v2.0+) 또는 DESIGN.approval (7-stage era v1.x 보존) + [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 금지 목록 + settings.json permission | 정전 (APPROVE.md / DESIGN.approval 게이트 + CRITICAL narrative). settings.json permission 은 보조 메커니즘 |
| Verification | 산출물 정합·schema·회귀 자동 검증 | [`../../tests/`](../../tests/) smoke 27종 + pre-commit hook (.pre-commit-config.yaml) + `.github/workflows/ci.yml` + `VERIFY.md` (criteria_check) | 정전 — VERIFY.md narrative 가 1차 source. smoke shell / install / verify 인프라 는 narrative 보조 (drift 항목 제거 후 잔존 인프라가 [`tests/CLAUDE.md`](../../tests/CLAUDE.md) 매트릭스에 회귀 차단 책임 명시 — active 5 = pre-commit 강제, inactive 22 = manual run leverage) |
| Trace | 의사결정·실행 이력의 영속 보존 — 외부 컨벤션 부재, 메타 고유 | [`milestones/`](milestones/) 9-stage 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md, v2.0+) 또는 7-stage 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute, v1.x era 보존) 또는 4-tier 산출물 (v1.84~v1.88 era 보존) + git history + ROADMAP.milestones[] (recent 3 + in_progress + deferred, v5.21+ schema A2) + [`../../CHANGELOG.md`](../../CHANGELOG.md) (past completed archival, Keep a Changelog v1.1.0 정합, v5.21 도입) | 정전 (메타 고유 차별화 — 외부 'agent harness' 컨벤션 부재 지점). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 안 sub-mechanism 분리 (forward-looking 부분 ROADMAP + past trace 부분 CHANGELOG, 3중 archival = REPORT.md + git log + CHANGELOG entry) |

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

### § 4 끝 narrative 정전화 누적 매트릭스 (v5.20_audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade, 무넘버)

§ 4 끝에 누적된 7 narrative paragraph (v3.10 ~ v5.20) 한눈 가독성 + 신규 정전화 추가 시 row append 매트릭스. 본 매트릭스 시발 = v5.19 PROPOSE#8 trigger 조건 충족 (6+ 누적). full paragraph 본문은 본 매트릭스 다음에 보존 (narrative archive 효과 + cross-ref 1차 source 보존).

| # | 정전화 milestone | 본질 | 1차 source | 검증 method (v5.13 절차 정합) |
|:-:|---|---|---|---|
| 1 | v3.10 (2026-05-11) | B/C/D 부산물 PROPOSE 흡수 책임 (stage 단어-책임 1:1 매핑 정합) | [`milestones/_archive/v3.10/RESEARCH.md`](milestones/_archive/v3.10/RESEARCH.md) | boolean — `out_of_scope` entry 명령형 부재 검증 |
| 2 | v3.20 (2026-05-13) | Word-fidelity drift 수용 (9 stage 평균 ~86.1% / APPROVE 100% / PROPOSE 70%) | [`milestones/_archive/v3.19/RESEARCH.md`](milestones/_archive/v3.19/RESEARCH.md) | 수치 — 9 stage 단어-책임 부합도 정량 |
| 3 | v5.9 → **v5.21 drift 해소** (2026-05-19) | ROADMAP 단어 drift 해소 사례 — Schema A2 (milestones[] + next_candidates[] 별도) + CHANGELOG.md archival 흡수로 ~30~40% → ~95%+ 부합 도달 | [`milestones/v5.9/RESEARCH.md`](milestones/v5.9/RESEARCH.md) § axis_c_roadmap_word + [`milestones/v5.21/RESEARCH.md`](milestones/v5.21/RESEARCH.md) + [`milestones/v5.21/DESIGN.md`](milestones/v5.21/DESIGN.md) D10 | 수치 — ROADMAP entry status 분포 (~30~40% → 95%+) + 표 — milestones[] length 7 + next_candidates[] length ≥ 1 |
| 4 | v5.10 (2026-05-18) | Narrative cascade drift 검증 의무 (v5.8→v5.9→v5.10 cascade) | [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../upbit/audit-2026-05-18/) | 표 — 후속 milestone PROPOSE/INTENT carry-over 시 origin RESEARCH 1차 cross-ref grep |
| 5 | v5.11+v5.18 (2026-05-18) | Audit chain fact 인용 검증 의무 + v5.18 Input Verification H2 sub-section + 검증 method 분리 | [`milestones/v5.11/RESEARCH.md`](milestones/v5.11/RESEARCH.md) + [`milestones/v5.18/RESEARCH.md`](milestones/v5.18/RESEARCH.md) + [`milestones/v5.18/DESIGN.md`](milestones/v5.18/DESIGN.md) | boolean+표+수치 분리 — v5.13 절차 정전화 + v5.18 method 분리 |
| 6 | v5.16 (2026-05-18) | Agent 산출 markdown lint precheck 의무 (MD022/MD031/MD032 hardcode + 추가 발현 candidate) | [`milestones/v5.14/REPORT.md`](milestones/v5.14/REPORT.md) L58-L59 + [`milestones/v5.15/VERIFY.md`](milestones/v5.15/VERIFY.md) L10-L11 | boolean — agent 산출 markdown 안 heading/fences/list 직전·직후 blank line 1줄 검증 |
| 7 | v5.20 (2026-05-19) | audit-apply-audit stability cycle pattern (upbit commit 0 + 동일 baseline 반복 호출 = 결과 converged) | [`milestones/v5.19/VERIFY.md`](milestones/v5.19/VERIFY.md) + [`../upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md`](../upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md) § 5+§ 6 | 표+수치 — cycle 별 commit SHA / R1+R2 APPLIED cycle 수 / 신규 gap 0건 / hallucination 변동 정량 |
| 8 | v6.4 (2026-05-20) | cascade 자동 동기 mechanism (v3.21 패턴 (b) 자동화 — slash + script + smoke) | [`milestones/v6.4/MILESTONE.md`](milestones/v6.4/MILESTONE.md) D1~D13 | boolean — `scripts/cascade_sync.py --check` exit code 0/1/2 + smoke pre-commit 자동 차단 |
| 9 | v6.5 (2026-05-20) | Claude 자율 milestone 발의 mechanism (`/propose-next` slash + script + smoke + candidate_draft[] category enum 2 값 분리) | [`milestones/v6.5/MILESTONE.md`](milestones/v6.5/MILESTONE.md) D1~D12 | boolean — smoke `tests/smoke-candidate-draft-schema.sh` 7 필드 + category enum 강제 + pre-commit 자동 차단 |
| 10 | v6.6 (2026-05-20) | audit chain hallucination 자동 검출 mechanism (script-only 3 method script + audit-team Step 6 + smoke + fixture, AI Native § 7.1 다중 AI 협업 면 second cycle) | [`milestones/v6.6/MILESTONE.md`](milestones/v6.6/MILESTONE.md) D1~D12 | boolean+표 — `scripts/audit_fact_verify.py --dir` exit code 0/1/2 + 6 fixture sub-dir + smoke `tests/smoke-audit-fact-verify.sh` 7 stage PASS + pre-commit 자동 차단 |

신규 § 4 끝 paragraph 추가 시 본 매트릭스 row append 의무 (v3.21 narrative 정전화 3 단계 패턴 정합 — (b) EXECUTE Edit 단계에서 매트릭스 row append 동기 수행).

**아래 paragraph 본문 7건은 narrative archive (1차 source 보존)** — 매트릭스 row 와 1:1 대응. 신규 정전화 시 본문 + row 동시 추가 의무.

**B/C/D 부산물의 PROPOSE 흡수 책임** (v3.10_stage-byproduct-clarification): B (`INTENT.out_of_scope`) / C (`RESEARCH.untouched_files_explicit` / `risks_identified`) / D (`DESIGN.decisions[i].rationale` / `phases[n].scope`) 의 부산물은 본 stage 의 **사실 진술 책임** 안 — 후속 milestone 명명 + ROADMAP 등재는 I (PROPOSE) 통합 흡수 단일 책임. 정의 보강 narrative: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) Stage B/C/D/I 참조.

**Word-fidelity drift 수용** (v3.19_word-fidelity-audit-v2 진단 + v3.20_drift-narrative-canonicalization 정전화): 위 9-stage 단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity 정정) 은 ideal 목표이며, 실 운용 부합도는 9 stage 평균 ~86.1% (APPROVE 100% 최고 부합 / PROPOSE 70% 최대 drift / OPEN 90% / INTENT 80% / RESEARCH 85% / DESIGN 80% / EXECUTE 85% / VERIFY 95% / REPORT 90%) — [`milestones/_archive/v3.19/RESEARCH.md`](milestones/_archive/v3.19/RESEARCH.md) 정량 1차 source. drift 의도성 = pragmatic 절충: 단일 책임 100% 부합 추구 시 workflow 비대화 risk (예: PROPOSE register 책임 분리 = 10-stage breaking change v4.0). drift 수용 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, 실 변경 (10-stage 분리 / ROADMAP 재정의 / 단어 변경) 은 evidence-base trigger 만. **v5.21 부분 해소** (v5.21_roadmap-forward-looking-redesign-and-changelog-archival): PROPOSE 등재 위치 명료화 (ROADMAP `milestones[]` status:pending → `next_candidates[]` 별도 필드) 로 PROPOSE drift 70% → ~90% 부분 자연 해소 — **단 PROPOSE 단어-책임 분리 아님 (10-stage 분리 본질 아님), 등재 destination field 명료화 효과만**. ROADMAP 단어 drift 는 동일 milestone 안 schema A2 재설계로 완전 해소 (#3 row 참조).

**ROADMAP 단어 drift 해소 사례** (v3.19_word-fidelity-audit-v2 진단 ROADMAP 측 + v5.9_dictionary-semantics-integrated-audit drift 수용 paragraph 1차 정전화 + **v5.21_roadmap-forward-looking-redesign-and-changelog-archival drift 해소 정전화**): `roadmap` 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 와 현 `projects/meta/ROADMAP.md` 실 상태 사이 부합도 ~30~40% 의 drift 가 v5.21 evidence-base trigger 첫 사례로 **해소** (drift 수용 → drift 해소 본질 변경). v5.9 baseline (50 entry — completed 46 / deferred 3 / in_progress 1 / pending 0, completed-dominant 92% / forward-looking 0%) → v5.21 적용 후 (`milestones[]` length 7 — recent 3 completed + in_progress 1 + deferred 3 / `next_candidates[]` length ≥ 1 = forward-looking 신규) = ~95%+ 부합 도달. 해소 방법 = (a) Schema A2 도입 — `milestones[]` 안 recent 3 + in_progress + deferred 만 보존 + `next_candidates[]` 별도 필드 신규 (forward-looking 본질), (b) 과거 completed entry 41건 (v5.17 ~ v1.0_workflow-redesign) `CHANGELOG.md` 으로 archival 이전 (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill 패턴 정합), (c) PROPOSE register 책임 의미 자연 흡수 — PROPOSE.next_candidates → ROADMAP.next_candidates[] 1:1 매핑 (단 PROPOSE 단어-책임 분리 아님, 등재 위치만 변경). trace 보존 = REPORT.md + git log + CHANGELOG entry 3중 archival. 정전화 1차 source = [`milestones/v5.21/RESEARCH.md`](milestones/v5.21/RESEARCH.md) + [`milestones/v5.21/DESIGN.md`](milestones/v5.21/DESIGN.md) D2/D10/D11 + [`milestones/v5.21/REPORT.md`](milestones/v5.21/REPORT.md). 본 사례는 § 4 끝 #2 'Word-fidelity drift 수용' narrative 안 명시된 'evidence-base trigger 만 실 변경' 의 첫 evidence-base trigger 사례 (사용자 명시 발의 A_user 2026-05-19) — '실 변경 (ROADMAP 재정의)' 분기 활성. v3.19 baseline 1차 진단 source = [`milestones/_archive/v3.19/RESEARCH.md`](milestones/_archive/v3.19/RESEARCH.md). v5.9 drift 수용 paragraph 1차 정전화 source = [`milestones/v5.9/RESEARCH.md`](milestones/v5.9/RESEARCH.md) § axis_c_roadmap_word.

**Narrative cascade drift 검증 의무 (v5.8 → v5.9 → v5.10 cascade)** (v5.10_external-audit-team-second-call-with-diff 정전화): 정전화된 fact 가 후속 milestone carry-over 시 cascade 누락되어 동일 drift 재발 가능. v5.10 evidence — v5.8 RESEARCH (R2 + L172) 가 'audit-team 호출 0건' → '1건 (v1.17 upbit, 2026-05-14)' 1차 정정 + 부합도 60% → 65% upgrade. v5.9 carry-over 시 cascade 누락 → PROPOSE.next_candidates#5 안 'v4.0 도입 후 호출 0건' / INTENT.out_of_scope 안 'first 시도' 재 misclassification 재발. v5.10 second call (audit chain 4 멤버 read-only 재호출 + v1.17 산출물 diff) 가 cascade drift 정정 + audit-team 호출 누적 정확 정량 = 7건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth + v5.17 fifth + v5.19 sixth + v5.20 seventh). cascade drift 회피 의무 = 후속 milestone PROPOSE/INTENT carry-over 시 origin milestone RESEARCH 안 정정 fact 1차 cross-ref 검증. 진단 + audit chain 산출물 1차 source = [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../upbit/audit-2026-05-18/) (4 산출물 scanner/analyzer/mapper/proposal-draft).

**Audit chain fact 인용 검증 의무** (v5.11_audit-chain-fact-verification-discipline 정전화): audit chain 4 멤버 (`project-scanner` / `harness-gap-analyzer` / `claude-docs-mapper` / `component-proposer`) 산출물 안 외부 1차 source fact 인용 시 synthesizer (메인 Claude orchestrator) 의 직접 매핑 검증 의무. evidence cycle 2 도달 trigger — (1) v5.10 L1 `component-proposer` 12 항목 표 hallucination (django/ai-ready-scorer 등 upbit 무관) → synthesizer overwrite 정정 + (2) v5.10 `project-scanner` `claude_md_in_repo: false` hallucination → 3 산출물 (analyzer/mapper/proposal-draft) cascade 흡수 + v5.10 PROPOSE.next_candidates#4 안 5 차 위치 인용 누적 stale → v5.11 정정. 검증 운용 의무 — (a) audit chain 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 synthesizer 가 직접 source (예: 파일 존재 여부 `ls` / 파일 내용 `Read`) 매핑 검증, (b) hallucination 발견 시 산출물 archive 보존 + 정정 narrative inline 추가 (overwrite 회피, audit trail 보존) + cascade 흡수 위치 (ROADMAP entry / PROPOSE.next_candidates / 다른 carry-over milestone) 동기 정정. 진단 + audit chain 산출물 1차 source = [`milestones/v5.11/RESEARCH.md`](milestones/v5.11/RESEARCH.md) + [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../upbit/audit-2026-05-18/). 절차화 (v5.13): [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step + [`agents/project-harness-audit-team/CLAUDE.md`](../../agents/project-harness-audit-team/CLAUDE.md) D8 sequence 섹션 Note. **v5.18 (audit-chain-direct-read-and-verification-depth)**: audit chain hallucination cycle 9 누적 (cycle 7+8+9 = 8건 evidence 도달) trigger — (a) `agents/{4 멤버}.md` 안 `## Input Verification` H2 sub-section 추가 (input 산출물 직접 Read 의무 narrative — Read tool 보유 멤버 (scanner / analyzer) 직접 Read / Read tool 부재 멤버 (mapper / proposer) D10 우회 패턴 = orchestrator inline 첨부 본문 직접 인용) + (b) v5.13 절차 안 검증 method 분리 (boolean / 표 / 수치 별 매핑 method) sub-narrative 흡수 ([`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 L80 + [`agents/project-harness-audit-team/CLAUDE.md`](../../agents/project-harness-audit-team/CLAUDE.md) D8 Note v5.18 3-stack 별도 block 분리, D11). 1차 source = [`milestones/v5.18/RESEARCH.md`](milestones/v5.18/RESEARCH.md) + [`milestones/v5.18/DESIGN.md`](milestones/v5.18/DESIGN.md) (D10 우회 패턴 + D11 3-stack 분리).

**Agent 산출 markdown lint precheck 의무** (v5.16_audit-output-markdown-lint-precheck 정전화): audit chain 산출물 산출 4 멤버 (`project-scanner` / `harness-gap-analyzer` / `claude-docs-mapper` / `component-proposer` — D8 Step 1~4, installer Step 5 제외) markdown 산출물을 repo 안 저장 시 markdownlint MD022 (blanks-around-headings) / MD031 (blanks-around-fences) / MD032 (blanks-around-lists) 3 rule 위반이 자동 발생하는 패턴 evidence cycle 2 도달 — (1) v5.14 L7 origin (cycle 3 audit 3건 발생) + (2) v5.15 L5 재현 (cycle 4 audit 8건 발생). 검증 운용 의무 — (a) agent 산출 직후 synthesizer (메인 Claude orchestrator) 가 markdown 본문 안 heading / fenced code block / list 직전·직후 blank line 1 줄 존재 패턴 검증 (pre-write check), (b) 위반 발견 시 inline blank line 정정 후 저장 — agent 산출물 archive 보존 + 정정 narrative inline 추가 (v5.11 fact 검증 패턴 정합 — overwrite 회피). MD022/MD031/MD032 hardcode (evidence-base 원칙) — 추가 rule (예: MD028 재발 또는 신 rule 발현) 시 본 절차 재발의 candidate. 정의 + 누적 evidence 1차 source = [`milestones/v5.14/REPORT.md`](milestones/v5.14/REPORT.md) L58-L59 + [`milestones/v5.15/VERIFY.md`](milestones/v5.15/VERIFY.md) L10-L11. 절차화 = [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step 직후 lint precheck step + [`../../agents/project-harness-audit-team/CLAUDE.md`](../../agents/project-harness-audit-team/CLAUDE.md) D8 sequence 섹션 Note (v5.16).

**audit-apply-audit stability cycle pattern** (v5.20_audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade 정전화): audit-team 외부 호출 cycle 사이 upbit repo commit 0 발생 시 동일 baseline 반복 호출 = 결과 converged 패턴 = stability cycle. 구성 = (1) 동일 upbit commit SHA 유지 (예: `5aeed93` v1.20 chore) + (2) 신규 gap 0건 + (3) audit chain 산출물 R1/R2 등 apply 상태 N cycle 연속 APPLIED + (4) 신규 proposal converged (carry-over only, mechanical apply 부재). 의의 = audit 의 본질 (Context vector 7 = ecosystem integrator + apply 효과 정합 검증) 안 apply 효과 stability (rollback 없음 + 재발 부재) 직접 evidence. 누적 evidence 2 cycle 도달 trigger — (1) v5.19 cycle 6 첫 완성 (cycle 5+6 동일 v1.20 baseline + R1+R2 2 cycle 연속) + (2) v5.20 cycle 7 두 번째 완성 (cycle 5+6+7 동일 baseline + R1+R2 3 cycle 연속 + 신규 proposal 0건 converged). narrative effect isolation 한계 sub-evidence — cycle 6 hallucination 0건 vs cycle 7 hallucination 2건 (mapper origin + proposer cascade) 동일 narrative + 동일 baseline 안 변동 = narrative 효과 단일 source 분리 미가능 직접 evidence (cycle 6 = 우연 정확 / cycle 7 = 분포 본질). v5.19 PROPOSE#1 `audit-cycle-7-narrative-effect-isolation` trigger 조건 = "cycle 7+ commit 발생 후 호출 = 새 fact source 추가 = narrative 효과 단일 evidence 가능" — cycle 7 upbit commit 부재 → cycle 8+ commit 발생 시 추가 검증 candidate. 정의 + 누적 evidence 1차 source = [`milestones/v5.19/VERIFY.md`](milestones/v5.19/VERIFY.md) + [`milestones/v5.20/VERIFY.md`](milestones/v5.20/VERIFY.md) + [`../upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md`](../upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md) § 5+§ 6.

**cascade 자동 동기 mechanism** (v6.4_cascade-auto-sync-mechanism 정전화): <a id="section-4-end-row-8"></a>v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source → (b) EXECUTE Edit cascade → (c) VERIFY grep 의 (b) 단계 수동 cycle (v3.18~v6.3 누적 28+, 평균 host ~5~12) 자동화. '자동' = source→host 매핑 + hash compare + diff 자동 생성 의미 (사용자는 명시 호출 `/cascade-sync` slash command 또는 `python scripts/cascade_sync.py --check|--apply`), PostToolUse hook 안 자동 trigger 는 oos_1 (v6.x 후속 candidate). 책임 분리 = slash command (UX orchestrator: script 호출 + diff 사용자 표시 + 승인 받기) + script (deterministic mechanical: enumerate + hash compare + diff text + apply) + smoke (read-only drift detect, pre-commit 자동 차단). marker format `<!-- cascade-source: <path>#<anchor> expected-hash:<16-hex> -->` = 본 repo 자체 컨벤션 (Anthropic Claude Code spec 안 표준 cascade marker / dependency tracking 패턴 부재, context7 query 안 0건 → v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 5번째). 정의 + 사용법 1차 source = [`milestones/v6.4/MILESTONE.md`](milestones/v6.4/MILESTONE.md) D1~D13.

**Claude 자율 milestone 발의 mechanism** (v6.5_claude-autonomous-milestone-proposal 정전화): <a id="section-4-end-row-9"></a>AI Native § 7.1 '자율성' 면 첫 실 적용. ROADMAP `next_candidates[]` + 최근 5 milestone PROPOSE `next_candidates_named_only` + lessons_learned P2 라벨 항목 자동 enumerate → 다음 milestone candidate 후보 제안 → 사용자 명시 결정 게이트 (스무고개) → ROADMAP `candidate_draft[]` append. 자율 범위 = candidate 제안까지만 (결정 = 사용자 — round 1 결정 정합). 책임 분리 = slash command `/propose-next` (UX orchestrator: script 호출 + 최우선 1건 우선 보고 + 비유 표현 + 사용자 응답 + Edit append) + script `scripts/propose_next.py` (deterministic read-only enumerate: 1차 디렉토리 semver desc + 2차 ROADMAP/CHANGELOG cross-validate, v5.18 Input Verification 정합) + smoke `tests/smoke-candidate-draft-schema.sh` (read-only schema 검증 단일 책임 = 7 필드 + category enum 2 값). `candidate_draft[]` host = v4.0 phase-7 narrative (벤치마크 cycle routine schedule skill 주 1회 cron, 작동 0건 v5.8 evidence) 와 공존 — `category` 필드 enum 2 값 분리 (`internal_synthesis` = v6.5 자율 발의 / `benchmark_external` = v4.0 벤치마크 cycle). 정의 + 사용법 1차 source = [`milestones/v6.5/MILESTONE.md`](milestones/v6.5/MILESTONE.md) D1~D12.

**audit chain hallucination 자동 검출 mechanism** (v6.6_audit-chain-hallucination-auto-correction 정전화): <a id="section-4-end-row-10"></a>AI Native § 7.1 '다중 AI 협업' 면 second cycle (v6.4 cascade-sync 첫 cycle 후속). v5.13/v5.18 정전화 절차 (synthesizer 직접 source 매핑 검증 + 검증 method 분리 boolean/표/수치) 의 수동 cycle (v5.10~v6.5 누적 9+, evidence cycle 4 = v5.10/v5.11/v5.12/v6.5) script-only 자동 검출. 자율 범위 = 검출 only (자동 정정 부재 — 재귀 hallucination 위험 차단 + 사용자 결정 게이트 보존 + memory `feedback_subagent_fact_hallucination_correction` '비대칭 default' 직접 정합, R1 결정). Trigger = `--audit` flow 안 audit-team synthesizer step (Step 6 신규, proposer 직후 installer 직전) 자동 통합 (별 slash command 부재 — v6.4/v6.5 패턴과 facing 대상 다름, R2 결정). scope = audit chain 4 agent (scanner/analyzer/mapper/proposer) 산출물 한정 (cycle 4 evidence 정확 매핑, 외부 산출물 oos_4). 책임 분리 = deterministic core (`scripts/audit_fact_verify.py` ~250 LOC, stdlib only re+json+pathlib, BOOLEAN_LOOKUP callable lookup 5 evidence-base 항목 + 표 schema column 매핑 + NUMERIC_LOOKUP empty no-op fallback evidence 도달 시 자연 확장, D1/D2) + narrative orchestrator (`agents/project-harness-audit-team/CLAUDE.md` Note v6.6 + Step 6 sequence 갱신 + 4 agent 표 column 본질 명시, D3/D5) + smoke (`tests/smoke-audit-fact-verify.sh` fixture-based read-only — 6 fixture sub-dir [boolean × 2 + 표 × 2 + numeric + empty] + Stage 5 path traversal 차단 검증, D4/D6). 인용 method (cycle 4 v6.5 evidence `v4.0/PROPOSE.md:54 category fleet-evolution` fact 부재) = LLM 추론 필요 → script-only 불가능 + 재귀 hallucination 위험 → v6.6 scope 외 (oos_2), PROPOSE 후속 거명만 (target_version v6.x — '인용 method 자동 detect mechanism'). Agent SDK `output_format=json_schema` 미채택 — script-only stdlib 유지 (외부 의존 회피 + fact 정확성 검증 schema 외 책임 + v5.13/v5.18 narrative 정합, D11). 외부 spec 안 first-class 'audit chain fact verification' 패턴 부재 (context7 verification = code-reviewer + Agent Hook for Test Verification 2종만, 직접 인용: "A read-only subagent for code review... Run git diff to see recent changes... Critical issues / Warnings / Suggestions" + "Verify that all unit tests pass. Run the test suite and check the results.") → 자기 정전화 자연 (v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 7번째 자연 발현, D12). 정의 + 사용법 1차 source = [`milestones/v6.6/MILESTONE.md`](milestones/v6.6/MILESTONE.md) D1~D12.

### 4.1 Bundling (v3.0+ 9-stage-bundled era)

v3.0_milestones-restructure 도입 — 같은 의미 단위 (모듈 / 주제 / lessons_learned) 후속 candidates 는 version 단위 1 milestone 에 통합:

- **ROADMAP `milestones[]` entry**: version 단위 1건 (`{version, id, title, status, summary, trigger, milestones_path}`). version + id 분리 schema (id = group-slug). **v5.21+ schema A2**: `milestones[]` 안 recent 3 completed + in_progress + deferred only. PROPOSE 발의 후보는 `next_candidates[]` 별도 필드 (`{id, title, trigger, origin_milestone, target_version, description}`). 과거 completed entry archival = `CHANGELOG.md`
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
| **9-stage-flattened** | v6.2+ | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `MILESTONE.md` (단일 본책, H2 9 섹션 = ## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES) + execute/phase-{n}.md (별책) | ✅ 의무 (v6.2+ 신규) |
| **9-stage-bundled** | v3.0~v6.1 | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `milestones.md` (sub-milestone listing per version) + INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md | ❌ 참조용 보존 (v6.1 까지), 신규 금지 — v6.2+ 9-stage-flattened 의무 |
| **9-stage** | v2.0~v2.1 | 디렉토리 명 `v{X.Y}_{slug}` + INTENT/APPROVE/PROPOSE 3종 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 신규 금지 (forward-only 정책) |
| **7-stage** | v1.0~v1.4 | 디렉토리 명 `v{X.Y}_{slug}` + PLAN.md 존재 + INTENT/APPROVE/PROPOSE 동시 부재 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 참조용 보존, 신규 금지 |
| **4-tier** | v1.84~v1.88 | 어셈블 plan-N/{PLAN,REPORT}.md (sub-plan 구조) | ❌ 참조용 보존, 신규 금지 |

**9-stage-flattened era 정전화 (v6.2_milestone-artifact-directory-flattening, 2026-05-19)**: AI Native § 7.1 컨텍스트 효율 면 두 번째 실 적용 milestone (v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화). 본질 = 1 milestone 디렉토리 안 6~8 파일 분산 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md) → 1 본책 (MILESTONE.md) + 1 별책 디렉토리 (execute/) 통합 = AI 1 Read 으로 milestone 전체 흡수. 형태 = (b) 하이브리드 (책 + 별책 비유) — 본책 안 H2 9 섹션 (8 stage 단어 fidelity 보존 + 1 SUB_MILESTONES listing, v2.0_workflow-word-fidelity 정전화 정합) + 별책 phase-{n}.md (실 구현 일지 분리, 동시 편집 가능). YAML frontmatter = 4 필드 (id/title/version/status — stage 필드 제거, milestone-level 통합 표지 = H2 섹션 자체). 적용 범위 = v6.2+ 신규만 (v3.0~v6.1 28 active 디렉토리 era 보존, era 분기 자연 확장 — forward-only 정책 일관). bundling 정책 (version 단위 1 milestone + sub-milestone phase 매핑) 본질 = ## SUB_MILESTONES 섹션 안 흡수 = bundling 본질 보존 (era 명명 분리 ≠ bundling 정책 폐기). 자기참조 부합 = phase-2 도그푸드 (자체 MILESTONE.md retrofit). detect_era 검사 순서 우선 = 9-stage-flattened (MILESTONE.md 존재 첫 검사, milestones.md 보다 우선 — phase-2 retrofit 일시 동시 존재 케이스 deterministic 보장).

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

**§ 6.2 폐지 narrative** (v4.0_harness-composer-pivot, 2026-05-13): 구 § 6.2 "Lightweight 모드 정책 (v3.6_overengineering-audit 도입)" + "Workflow self-improvement milestone 동결 정책" + "Narrative 정전화 3단계 패턴" + 선례 2건 모두 v4.0 정체성 재정의로 폐지. 새 정체성 (§ 3.1 끝 paragraph) 이 자연 가드레일 — 자기참조 workflow self-improvement milestone 자체가 새 정체성에 부합 안 함. 본 § 6.2 cross-ref (v3.6 / v3.10 / v3.11 / v3.13 ~ v3.21 entry) 들은 v4.0 phase-2 안 `projects/meta/milestones/_archive/` 이전으로 자동 무력화. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md) + [`milestones/v4.0/DESIGN.md`](milestones/v4.0/DESIGN.md).

**spec-drift spike 패턴** (v5.7_spec-drift-spike-pattern-canonicalization, 2026-05-16): 외부 spec 안 정확 명시 부재 (context7 source narrative 표현 추정) 항목의 정정 cycle 3 단계 — (a) RESEARCH 단계 context7 source 추정 진행 (정확 spec 명시 부재 인식 + 추정 명시 의무) → (b) Stage D DESIGN 5 관점 spec-drift agent 검토 안 추정 risk 식별 → (c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정 → (d) DESIGN.decisions 또는 phase-{n}.md execution_notes 안 hardcode (정확 spec 값 string literal 명시, 동적 구성 회피). 자연 발현 origin 2건 — v4.2 = (a)→(b)→DESIGN 즉시 정정→(d) (Stage F 전 cycle, context7 standard pattern 정정), v5.6 = (a)→(b)→Stage F spike→(d) (Stage F 안 cycle, settings.json enabled key 검증). 정정 시점 차이 (DESIGN 즉시 vs Stage F spike) 는 spec 명시 부재 정도에 따라 자연 분기. ecosystem integrator 정체성 (§ 3.1 끝 paragraph) 직접 부합 — context7 spec 정합 가드레일. 자세히: [`milestones/v4.2/DESIGN.md`](milestones/v4.2/DESIGN.md) (D2 origin) + [`milestones/v5.6/DESIGN.md`](milestones/v5.6/DESIGN.md) (D10 origin) + [`milestones/v5.7/DESIGN.md`](milestones/v5.7/DESIGN.md) (정전화).

## 7. AI Native 운영

### 7.1 정의

본 repo (harness-meta) 운영의 본질은 **AI Native 운영** — 본 repo 의 산출물 (ROADMAP / CHANGELOG / milestone 산출물 / cascade narrative) 이 AI (Claude / 다른 LLM agent) 에 의해 가장 자주 흡수되고 활용되며, AI 의 컨텍스트 효율 + 자율성 + 다중 AI 협업 친화도가 운영 품질의 1차 measure 다. § 3.1 끝 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer, v4.0 도입) 이 '본 repo 가 무엇을 만드는가' (책임 / 결과물) 라면, AI Native 운영은 '본 repo 가 어떻게 운영되는가' (원칙 / 운영 방식) — 두 차원 직교 보완.

**3 면 매트릭스**:

| 면 | 정의 | 현 baseline |
|---|---|---|
| **컨텍스트 효율** | AI 가 한 자료 (예: ROADMAP entry list) 를 흡수할 때 토큰 비용 + 본질 파악 신속 | entry title ≤ 60자 (§ 7.2 P2 정합), 한 entry = 한 본질 (§ 7.2 P1) — v6.0 정전화 |
| **자율성** | AI 가 사용자 명령 모호해도 의도 추출 + milestone 발의 + 진행 + 회고 가능. 사용자 명시 결정 게이트 보존 + AI 가 주도 결정 책임 흡수 | v6.x+ 후속 milestone candidate — 현 baseline = 사용자 명시 발의 의무 |
| **다중 AI 협업** | audit-team / external agent / context7 등 여러 AI 사이 컨텍스트 공유 + 책임 분리 명료 + fact 검증 자동 | audit chain 6 cycle 실 호출 (v5.10~v5.19) + Input Verification narrative 정전화 (v5.18) + lint precheck (v5.16) — 진행 중 |

본 매트릭스는 후속 milestone 발의 평가 기준 — 신규 milestone 이 3 면 중 어느 면을 향상시키는가 명시 (§ 3.6 5요소 매트릭스 평가 절차 와 cross-ref 보완).

### 7.2 Entry title 가이드 (4 원칙)

ROADMAP `milestones[]` entry / CHANGELOG bullet header / 기타 entry-form artifact 안 title 작성 시 다음 4 원칙 의무:

1. **한 entry = 한 본질** — bundling 시 (v3.0+ bundling era) 모자 본질만 title 안. 'A + B + C + D' 합치기 형식 금지. 나머지 본질은 summary 필드 안.
2. **≤ 60자 (한국어, 영문 약 120자)** — 한 화면 안 시각 흡수 + LLM context efficiency baseline. 60자 위 = 분류 정확도 감소 + grep keyword false-positive 증가.
3. **Active form + 짧은 동사구 시작** — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사. 명사구 시작 회피.
4. **Detail 은 summary 필드로 분리** — title 은 '무엇' / summary 는 '왜 + 어떻게 + 결과 + cross-ref'.

**smoke 자동 강제 정전화** (v6.3_entry-title-guideline-smoke-verification, 2026-05-20): 위 4 원칙 중 **(1) + (2) 자동 검증** = `tests/smoke-entry-title-guideline.sh` (pre-commit hook 8건째 등재). (1) ' + ' literal space + lookbehind/lookahead non-whitespace P1 mechanical proxy 검출 (코드 식별자 R1+R2 / C++ false-positive 회피). (2) Python `len(title)` codepoint > 60 검출 (한국어 시각 폭 ≈ 영문 120자 baseline). **(3) Active form + (4) Detail summary 분리 = AI 판단 위임** (자동 검증 제외 — 휴리스틱 false-positive 위험 + 의미 차원). enumerate scope = `projects/*/ROADMAP.md` 안 `milestones[]/next_candidates[]/candidate_draft[]` title 필드 + `CHANGELOG.md` bullet bold header (line-by-line + `[^*\n]{1,500}` length-bounded ReDoS 차단). SIZE_LIMIT 100KB 초과 = stderr 경고 + exit 1 FAIL (silent SKIP 폐기, 정책 우회 차단).

## 8. 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- 영문 요약: [`../../AGENTS.md`](../../AGENTS.md)
- ADR: [`../../docs/adr/README.md`](../../docs/adr/README.md)
- subdirectory CLAUDE.md (lazy): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone (메타): [`ROADMAP.md`](ROADMAP.md)

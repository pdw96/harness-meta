# meta — Harness Architecture

harness-meta repo 자체의 **하네스** 아키텍처 스냅샷. 글로벌 통합 레이어(slash command / hook / statusline / skills) + 메타 milestone trace 보유. 본 repo가 곧 'meta project'의 작업 공간 — `projects/upbit/` 와 비대칭 (upbit milestones는 upbit repo, meta milestones는 본 repo의 `development/milestones/`).

> 운영 가이드 + CRITICAL 규칙: root [`../../CLAUDE.md`](../CLAUDE.md). 영문 요약: [`../../AGENTS.md`](../AGENTS.md). 본 파일 § 1 디렉토리 트리가 글로벌 시스템 도식 단일 source.

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
| `claude/{commands,hooks,statusline}/` | 글로벌 layer (slash command + hook + statusline) | [`../../claude/CLAUDE.md`](../claude/CLAUDE.md) |
| `bootstrap/skills/` | 글로벌 user-skill (audit / dev / etc.) | [`../../bootstrap/skills/CLAUDE.md`](../bootstrap/skills/CLAUDE.md) |
| `tests/` | smoke + pre-commit autofix-or-fail wrapper | [`../../tests/CLAUDE.md`](../tests/CLAUDE.md) |
| `development/milestones/` | 메타 milestone 9-stage 기록 (v2.0+; v1.x 7-stage era + v1.84~v1.88 4-tier era 참조용 보존) | (본 디렉토리) |
| `docs/adr/` | ADR (architecture decision records) | [`../../docs/adr/README.md`](../docs/adr/README.md) |

## 3. 하네스 엔지니어링 정의 (정전 — single source)

### 3.1 Working definition

> 하네스 엔지니어링은 agent 의 행동을 Markdown narrative + 파일 trace 로 결속하여 인프라 자동화 의존을 최소화하는 활동이다. 5요소 (Context / Workflow / Constraint / Verification / Trace) 가 정전 분류이며, 신규 작업 발의는 본 5요소 중 하나에 매핑되어야 한다.

**여기서 '인프라 자동화 의존 최소화' 란**: SKILL 자동 invoke / hook hard-code / smoke 키워드 강제 / settings.json permission gate 같은 자동화 메커니즘에 작업의 **정합성·의사결정·trace** 를 맡기지 않는다는 뜻이다. 자동화는 **보조**이며, PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 narrative + 사용자 명시 approval gate 가 **1차 source**. 자동화 자체를 거부하지는 않는다 — 다만 자동화가 1차 source 가 되면 narrative 와 drift 하고 (예: v1.2 lessons '메시지 1건 변경 → smoke 6건 연쇄') 정전성이 약화되므로, 자동화는 항상 narrative 의 보조 역할로 위치한다.

**harness-meta repo 정체성** (v4.0_harness-composer-pivot, 2026-05-13): 본 repo 는 위 working definition 을 적용하는 구체 instance — **project harness composer + Claude Code ecosystem integrator + agent fleet maintainer**. 대상 프로젝트를 분석하고 [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소 harness 구성요소 (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) 를 만들어 배치한다. mechanical install/update/cleanup 도 agent (`component-installer`) 가 직접 담당 — static install script 부재. GitHub 인기 저장소 + Claude Code release notes 를 정기 벤치마크하여 업그레이드 검토 + agent fleet 자체 lifecycle (scope 확장 / 분할 / 신규 / 통합 / 삭제) 도 관리. 글로벌 자산은 `bootstrap/` 하위, 프로젝트 특화 자산은 `projects/<name>/.claude/` 하위 **두 층 구조**. Custom 과 built-in 충돌 / fleet evolution 모두 `audit → propose → 사용자 명시 결정 → apply` (e3) 적용. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md).

**mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리** (v4.2_verify-infra-agent-absorption 도입): harness-meta 안 'mechanical install/update/cleanup' 본질 책임 (script 폐기 후 agent 흡수 가능 — v4.0 install + v4.2 verify/sync) 과 Claude Code spec 의무 실 실행 컴포넌트 (settings.json 안 등록된 OS subprocess — `claude/hooks/{session-init.sh, post-report-write.sh}` + `claude/statusline/statusline.sh`) 는 본질 분리. spec 의무 컴포넌트는 agent 흡수 불가능 (agent = Claude Code session 안 Task 호출, hook = OS-level subprocess, recursion 차단). 정체성 (project harness composer + agent fleet maintainer) 확장 시 본 분리 narrative 정합.

**Install 정책 = Claude Code Plugin spec 전면 채택** (v5.0_plugin-pivot, 2026-05-14): harness-meta 자체가 Claude Code Plugin — `.claude-plugin/plugin.json` (manifest, paths 명시 = agents/commands/hooks/skills replace-default + add-to-default 패턴) + `.claude-plugin/marketplace.json` (local marketplace, source = `.`) 정전. 사용자 onboarding = `claude plugin marketplace add pdw96/harness-meta` (외부, clone 불요, v5.3+) 또는 `git clone` + `claude plugin marketplace add ~/harness-meta` (로컬) + `claude plugin install harness-meta@harness-meta` 표준 CLI 명령. GitHub shorthand 는 전체 repo clone → `./"` relative path 정상 작동 (context7 spec 확인). Plugin source 거주 위치 = `~/.claude/plugins/cache/harness-meta/` (Claude Code 표준), agents 필드 부재 → plugin_root `./agents/` default discovery = 7 멤버 (5 team + 2 standalone) 자동 인식 (v5.1_plugin-component-discovery-fix). skills 필드 `./skills/` (add-to-default) — 5 skill 자동 인식. hooks.json (PostToolUse Write\|Edit + SessionStart matcher, `${CLAUDE_PLUGIN_ROOT}` 변수 활용) 신규. Plugin 채택 효익 = (1) Developer Mode 의존 0 + (2) ecosystem integrator 정체성 정합 + (3) install scope user/project/local 선택 + (4) enable/disable/uninstall 표준 lifecycle + (5) 2 standalone subagent 미배포 자연 해소. component-installer agent 책임 분리 — custom component lifecycle (milestone 산출물 mechanical apply) 보존 + Plugin install lifecycle (mechanical) Claude Code CLI 위임. **Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — 자연어 호출 `~~harness-meta 설치해줘~~` + v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup retention) 는 historical narrative 만 보존 (v4.x milestone 산출물 안 인용 source). v4.x 환경 안 `~/.claude/agents/` 5 멤버 SymbolicLink 잔존 시 manual cleanup 권고 narrative — 정확 명령 [`../../README.md`](../README.md#installation).

**Historical narrative — Install 정책 본질** (v4.3_subagent-discovery-path-research 도입, v5.0 채택 narrative 의 source): 현 (deprecated) harness-meta install (~/.claude/{commands,hooks,statusline,skills,agents}/ 안 SymbolicLink default + Copy fallback 매핑) 의 본질 근거 = Claude Code spec 안 subagent/command/hook/statusline/skill discovery 경로 `~/.claude/<category>/` 단일 강제 (sub-agents docs / settings docs context7 검증). Plugin spec 안 marketplace local source + plugin manifest paths = install (SymbolicLink/Copy 매핑) 회피 경로 발견. trade-off 분석 narrative source = [`milestones/v4.3/RESEARCH.md`](milestones/v4.3/RESEARCH.md) + [`milestones/v5.0/DESIGN.md`](milestones/v5.0/DESIGN.md).

**정체성-운용 vector drift 수용** (v5.8_identity-application-vector-audit, 2026-05-17): 위 § 3.1 끝 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 도입 (v4.0, 2026-05-13) 후 ~4일 운영분 수 = 12 meta milestone (v4.0~v5.7, 100% self-loop = 9785 LOC 안 mechanical install/Plugin 44.1% + agent fleet evolution 22.2% + 정체성 pivot 19.0% + RESEARCH/narrative 14.7%) + 1 외부 적용 (upbit v1.17, 2026-05-14, `/harness-meta upbit --audit` audit-team chain 5 멤버 완전 작동 + 12 항목 mechanical apply, evidence 강력) = 13 / 12 self-loop = 92.3%. 운용 부합도 sub-metric (가중 평균 77.5%) — composer 50% × 0.4 (audit-team 작동 evidence 강력 / 빈도 1/13) + integrator 60% × 0.3 (spec drift detection 5건 / 벤치마크 routine 0건) + maintainer 70% × 0.3 (fleet 진화 3건 / 분할·통합·삭제 0건). drift 본질 = v5.0 Plugin pivot (2026-05-14) 자기 강화 cascade — spec-drift 자기 detect (v5.1/5.2/5.4) + environment-auditor 자기 진화 (v5.5/5.6) + narrative 정전화 자기 강화 (v5.7) 3축이 Plugin spec 자체를 self-recruit attractor 화. 가드레일 진화 trend = v3.6 § 6.2 강한 정책 → v3.17 PROPOSE 거명 약 → v3.19/v5.8 narrative 흡수 medium (v4.0 § 6.2 폐지로 strong 가드레일 자체 부재). drift 수용 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, § 6.2 (v4.0 폐지) 재도입 등 실 가드레일 변경은 evidence-base trigger 만 (cycle 4 trigger 조건 = 외부 적용 5건 추가 누적 ∧ 사용자 명시 발의 AND, 현 reverse evidence 6건 누적 = deferred 동결 정량 정당화). 자세히: [`milestones/v5.8/RESEARCH.md`](milestones/v5.8/RESEARCH.md) 정량 1차 source + 보강 분석 § A1~A9.

**운영 원칙 측면 보완** (v6.0_ai-native-operation-reframe-and-entry-title-guideline, 2026-05-19): 위 정체성 (v4.0) 이 '책임 / 결과물' 차원 (composer + integrator + maintainer) 이라면, 운영 원칙 / 운영 방식 차원의 보완 정의 = § 7 AI Native 운영 (컨텍스트 효율 + 자율성 + 다중 AI 협업 3 면 매트릭스). 두 차원 직교 — 신규 milestone 발의 시 본 § 3.1 정체성 + § 7 AI Native 운영 양방향 cross-ref 평가.

### 3.2 Working philosophy

> ★ harness-meta 의 working philosophy: narrative + 파일 trace 우선, 인프라 자동화 최소화, 단일 source 정합. SKILL 인프라·자동 hook gate 보다 PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 MD narrative + 사용자 명시 approval gate 를 1차 source 로 둔다.

### 3.3 5요소 매트릭스

| 요소 | (a) 책임 | (b) 메커니즘 cross-ref | (c) 정전 vs 임시방편 분류 |
|---|---|---|---|
| Context | agent 가 작업 시 흡수하는 정보 source 의 결속 | root [`CLAUDE.md`](../CLAUDE.md) 자동 로드 + 모듈 CLAUDE.md lazy load + 메모리 (auto memory) + sub-agent prompt 의 manual inject (v1.75 컨벤션, SKILL 자동 invoke 거부) | 정전 (manual injection 컨벤션 채택). SKILL 자동 invoke 부분만 임시방편 |
| Workflow | milestone 단위 작업의 단계 분할 + 산출물 형식 통일 + version 단위 통합 | 9-stage pipeline (ROADMAP 입력 source → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE), 단어 = 단일 책임 1:1 매핑, v3.0+ 9-stage-bundled era — version 단위 1 milestone (sub-milestone phase 매핑, milestones.md per version 위임, § 6.1 bundling 정책), [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) 진입점, 모든 산출물 Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body, v6.1+ 신규 schema, 이전 v1.0~v6.0 = MD + JSON 코드블록) | 정전 (v1.0 7-stage 확립 → v2.0 9-stage 단어 부합 → v3.0 9-stage-bundled hierarchy) |
| Constraint | agent 가 위반하면 안 되는 규칙·금지·승인 게이트 | root [`CLAUDE.md`](../CLAUDE.md) CRITICAL 섹션 + APPROVE.md.approved_by (`"user"` + date ISO-8601, 9-stage era v2.0+) 또는 DESIGN.approval (7-stage era v1.x 보존) + [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) 금지 목록 + settings.json permission | 정전 (APPROVE.md / DESIGN.approval 게이트 + CRITICAL narrative). settings.json permission 은 보조 메커니즘 |
| Verification | 산출물 정합·schema·회귀 자동 검증 | [`../../tests/`](../tests) smoke 27종 + pre-commit hook (.pre-commit-config.yaml) + `.github/workflows/ci.yml` + `VERIFY.md` (criteria_check) | 정전 — VERIFY.md narrative 가 1차 source. smoke shell / install / verify 인프라 는 narrative 보조 (drift 항목 제거 후 잔존 인프라가 [`tests/CLAUDE.md`](../tests/CLAUDE.md) 매트릭스에 회귀 차단 책임 명시 — active 5 = pre-commit 강제, inactive 22 = manual run leverage) |
| Trace | 의사결정·실행 이력의 영속 보존 — 외부 컨벤션 부재, 메타 고유 | [`milestones/`](milestones/) 9-stage 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md, v2.0+) 또는 7-stage 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute, v1.x era 보존) 또는 4-tier 산출물 (v1.84~v1.88 era 보존) + git history + ROADMAP.milestones[] (recent 3 + in_progress + deferred, v5.21+ schema A2) + [`../../CHANGELOG.md`](../CHANGELOG.md) (past completed archival, Keep a Changelog v1.1.0 정합, v5.21 도입) | 정전 (메타 고유 차별화 — 외부 'agent harness' 컨벤션 부재 지점). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 안 sub-mechanism 분리 (forward-looking 부분 ROADMAP + past trace 부분 CHANGELOG, 3중 archival = REPORT.md + git log + CHANGELOG entry) |

### 3.4 외부 컨벤션 관계

외부 컨벤션 (Anthropic / Claude Code) 의 'agent harness' 는 **명시 working definition 부재** — hooks / settings.json permission / sub-agents / SKILL 등 메커니즘 묶음으로 사용. 본 정의는 외부 spec 추수가 아니라 사용자·repo 자체 working definition 정전화 (v1.3_harness-engineering-definition RESEARCH external#1). 5요소 (b) 메커니즘 cross-ref 가 외부 컨벤션 (hook / settings / SKILL / sub-agent) 에 자연 매핑되며, **'Trace' 요소는 외부 컨벤션 부재 — 메타 고유 차별화 지점** (REPORT.md + execute/phase-{n}.md 의 영속 파일 trace).

### 3.5 ★ 단일 source 정합

본 § 3 (하네스 엔지니어링 정의) 는 본 파일 (`development/ARCHITECTURE.md`) 이 **단일 source**. 다른 문서 (root [`../../CLAUDE.md`](../CLAUDE.md), [`../../AGENTS.md`](../AGENTS.md), [`../../README.md`](../README.md), [`CLAUDE.md`](CLAUDE.md), [`../../GUARDRAILS.md`](../GUARDRAILS.md)) 는 cross-ref 만, 정의 본문·매트릭스 중복 금지. 향후 정의 갱신 시 본 § 3 만 수정.

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
| 4 | v5.10 (2026-05-18) | Narrative cascade drift 검증 의무 (v5.8→v5.9→v5.10 cascade) | [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../projects/upbit/audit-2026-05-18) | 표 — 후속 milestone PROPOSE/INTENT carry-over 시 origin RESEARCH 1차 cross-ref grep |
| 5 | v5.11+v5.18 (2026-05-18) | Audit chain fact 인용 검증 의무 + v5.18 Input Verification H2 sub-section + 검증 method 분리 | [`milestones/v5.11/RESEARCH.md`](milestones/v5.11/RESEARCH.md) + [`milestones/v5.18/RESEARCH.md`](milestones/v5.18/RESEARCH.md) + [`milestones/v5.18/DESIGN.md`](milestones/v5.18/DESIGN.md) | boolean+표+수치 분리 — v5.13 절차 정전화 + v5.18 method 분리 |
| 6 | v5.16 (2026-05-18) | Agent 산출 markdown lint precheck 의무 (MD022/MD031/MD032 hardcode + 추가 발현 candidate) | [`milestones/v5.14/REPORT.md`](milestones/v5.14/REPORT.md) L58-L59 + [`milestones/v5.15/VERIFY.md`](milestones/v5.15/VERIFY.md) L10-L11 | boolean — agent 산출 markdown 안 heading/fences/list 직전·직후 blank line 1줄 검증 |
| 7 | v5.20 (2026-05-19) | audit-apply-audit stability cycle pattern (upbit commit 0 + 동일 baseline 반복 호출 = 결과 converged) | [`milestones/v5.19/VERIFY.md`](milestones/v5.19/VERIFY.md) + [`../upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md`](../projects/upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md) § 5+§ 6 | 표+수치 — cycle 별 commit SHA / R1+R2 APPLIED cycle 수 / 신규 gap 0건 / hallucination 변동 정량 |
| 8 | v6.4 (2026-05-20) | cascade 자동 동기 mechanism (v3.21 패턴 (b) 자동화 — slash + script + smoke) | [`milestones/v6.4/MILESTONE.md`](milestones/v6.4/MILESTONE.md) D1~D13 | boolean — `scripts/cascade_sync.py --check` exit code 0/1/2 + smoke pre-commit 자동 차단 |
| 9 | v6.5 (2026-05-20) + **v6.8 dedupe 확장** (2026-05-20) | Claude 자율 milestone 발의 mechanism (`/propose-next` slash + script + smoke + candidate_draft[] category enum 2 값 분리) + **v6.8 surface 자동 dedupe** (status `delta`/`passing` 분류 + matching key id 우선 + title fallback + scope `next_candidates[]` + `candidate_draft[]` 양쪽) | [`milestones/v6.5/MILESTONE.md`](milestones/v6.5/MILESTONE.md) D1~D12 + [`milestones/v6.8/MILESTONE.md`](milestones/v6.8/MILESTONE.md) D1~D11 | boolean — smoke `tests/smoke-candidate-draft-schema.sh` Stage 1 (ROADMAP candidate_draft 7 필드 + category enum) + Stage 2 (v6.8 candidate_items 3 필드 + status enum 2 값 + dedupe_stats 4 필드) + pre-commit 자동 차단 |
| 10 | v6.6 (2026-05-20) + **v6.9 5-step schema enhancement** (2026-05-20) + **v6.14 NUMERIC_LOOKUP cycle 7 evidence + context scope narrative** (2026-05-21) | audit chain hallucination 자동 검출 mechanism (script-only 3 method script + audit-team Step 6 + smoke + fixture, AI Native § 7.1 다중 AI 협업 면 second cycle) + **v6.9 mismatch 보고 5-step 형식** + **v6.14 NUMERIC_LOOKUP 2 entry 자연 확장 (claude_md_lines + claude_md_bytes, harness-meta context 한정) + mechanism context scope narrative 정전화 (target project 외부 repo context oos, v6.6 D10 path traversal 차단 정합)** | [`milestones/v6.6/MILESTONE.md`](milestones/v6.6/MILESTONE.md) D1~D12 + [`milestones/v6.9/MILESTONE.md`](milestones/v6.9/MILESTONE.md) D1~D11 + [`milestones/v6.14/MILESTONE.md`](milestones/v6.14/MILESTONE.md) D1~D11 | boolean+표+수치 — `scripts/audit_fact_verify.py --dir` exit code 0/1/2 + 7 fixture sub-dir (v6.14 numeric-mismatch 신규) + smoke `tests/smoke-audit-fact-verify.sh` 9 stage PASS (v6.9 Stage 6 5-step schema + v6.14 Stage 3 numeric-mismatch 추가) + pre-commit 자동 차단 |
| 11 | v6.12 (2026-05-20) | fixture-based smoke 자동화 패턴 cycle 2 (v6.6 cycle 1 동질 mechanism — sub-dir + expected exit code mapping + validate() 함수 재호출, candidate_draft schema 적용) | [`milestones/v6.12/MILESTONE.md`](milestones/v6.12/MILESTONE.md) D1~D14 | boolean — `tests/smoke-candidate-draft-schema.sh` Stage 4 fixture loop 7 sub-dir (normal=0 + violation 6=1) actual_exit vs expected mapping 일치 검증 + Stage 1 logic 확장 5 신규 검증 (id regex + detected_at ISO + rationale length + source/decision_pending non-empty) + pre-commit 자동 차단 |
| 12 | v6.16 (2026-05-21) + **v6.18 7 stage 확장** (2026-05-21) | stage 본질 = templated section 작성 task 정전화 (v6.2 9-stage-flattened era 자연 수렴 + v6.4~v6.9 mechanical cascade 누적 후 manual narrative 작성 본질 잔존 + skill = derived checklist 정합) + OPEN/PROPOSE 2 stage skill 시범 도입 + **v6.18 나머지 7 stage (INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT) skill 일괄 도입 = 9 stage 전체 cover** | [`milestones/v6.16/MILESTONE.md`](milestones/v6.16/MILESTONE.md) D1~D10 + [`milestones/v6.18/MILESTONE.md`](milestones/v6.18/MILESTONE.md) D1~D10 + [§ 7.3](#73-stage-본질-templated-section-작성-task) | boolean — skill SKILL.md description 안 ARCHITECTURE § 7.3 인용 grep + skills/stage-{open,intent,research,design,approve,execute,verify,report,propose} 9 디렉토리 존재 + § 7.3 + § 4 #12 row + § 4 본문 paragraph 3 host cross-ref 정합 grep |
| 13 | v6.19 (2026-05-21) | CHANGELOG → GitHub Releases hybrid migration mechanism (시간 분기 3 era — v1.0~v5.21 archived 1줄 단축 / v6.0~v6.18 본문 잔존 / v6.19+ Releases 단일 source) + commit msg explicit marker `[release:v{X.Y}]` 자동 trigger workflow + MILESTONE.md ## REPORT 섹션 자동 추출 release body | [`milestones/v6.19/MILESTONE.md`](milestones/v6.19/MILESTONE.md) D1~D9 + [`.github/workflows/release-publish.yml`](../.github/workflows/release-publish.yml) | boolean+수치 — workflow yaml `python yaml.safe_load` PASS + `awk '/^## REPORT/{flag=1; next} /^## PROPOSE/{flag=0} flag'` v6.18 fixture 95 line 추출 + CHANGELOG.md size 99998 → 65705 bytes (-34.3%) + 52 entry archived 1줄 단축 (v1.0~v5.21) |
| 14 | v6.20 (2026-05-21) | Agent(agent_type) syntax 흡수 — `agents/audit-orchestrator.md` 신설 + frontmatter `tools: Agent(5 멤버 allowlist), Read, Bash, Edit, Grep, Glob` (v2.1.33+ Claude Code syntax 본 repo 안 첫 사용 사례) + audit-team 5 멤버 만 spawn 허용 sandbox 효과 + Step 1~6 통합 책임 흡수 (메인 Claude → audit-orchestrator agent narrative cascade 9 host) | [`milestones/v6.20/MILESTONE.md`](milestones/v6.20/MILESTONE.md) D1~D7 | boolean+표 — `Grep 'Agent\(' agents/audit-orchestrator.md` 1 match + smoke `tests/smoke-agent-frontmatter-schema.sh` 3 검증 항목 PASS (frontmatter parse + Agent(...) literal regex + 참조 agent 존재 검증) + grep '메인 Claude.*orchestrator' active narrative 안 0 match (historical 보존) |
| 16 | v6.23 (2026-05-22) | milestone version mechanism 통합 재고 — bundling 자연 발현 본질 명문화 (cb_3 정합, ≥2 sub trigger 자연 발현 시만 활용) + 5 source 우선순위 narrative 정전화 (디렉토리명 primary / frontmatter redundant / ROADMAP forward-looking / git tag release trigger / GitHub Release external visible) — lightweight 평가/결정만, 실 적용 oos_1 (v6.24+ 별 milestone) | [`milestones/v6.23/MILESTONE.md`](milestones/v6.23/MILESTONE.md) D1~D8 | boolean+표 — `Grep '## SUB_MILESTONES' development/milestones/v6.23/MILESTONE.md` 1 match (v6.2~v6.22 21 milestone 부재 패턴 후 첫 실 활용 cycle, cb_8 정합) + 표 — 5 source 우선순위 본 paragraph 안 5 row (디렉토리명/frontmatter/ROADMAP/git tag/GitHub Release 본질 매핑) |

신규 § 4 끝 paragraph 추가 시 본 매트릭스 row append 의무 (v3.21 narrative 정전화 3 단계 패턴 정합 — (b) EXECUTE Edit 단계에서 매트릭스 row append 동기 수행).

**아래 paragraph 본문 7건은 narrative archive (1차 source 보존)** — 매트릭스 row 와 1:1 대응. 신규 정전화 시 본문 + row 동시 추가 의무.

**B/C/D 부산물의 PROPOSE 흡수 책임** (v3.10_stage-byproduct-clarification): B (`INTENT.out_of_scope`) / C (`RESEARCH.untouched_files_explicit` / `risks_identified`) / D (`DESIGN.decisions[i].rationale` / `phases[n].scope`) 의 부산물은 본 stage 의 **사실 진술 책임** 안 — 후속 milestone 명명 + ROADMAP 등재는 I (PROPOSE) 통합 흡수 단일 책임. 정의 보강 narrative: [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) Stage B/C/D/I 참조.

**Word-fidelity drift 수용** (v3.19_word-fidelity-audit-v2 진단 + v3.20_drift-narrative-canonicalization 정전화): 위 9-stage 단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity 정정) 은 ideal 목표이며, 실 운용 부합도는 9 stage 평균 ~86.1% (APPROVE 100% 최고 부합 / PROPOSE 70% 최대 drift / OPEN 90% / INTENT 80% / RESEARCH 85% / DESIGN 80% / EXECUTE 85% / VERIFY 95% / REPORT 90%) — [`milestones/_archive/v3.19/RESEARCH.md`](milestones/_archive/v3.19/RESEARCH.md) 정량 1차 source. drift 의도성 = pragmatic 절충: 단일 책임 100% 부합 추구 시 workflow 비대화 risk (예: PROPOSE register 책임 분리 = 10-stage breaking change v4.0). drift 수용 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, 실 변경 (10-stage 분리 / ROADMAP 재정의 / 단어 변경) 은 evidence-base trigger 만. **v5.21 부분 해소** (v5.21_roadmap-forward-looking-redesign-and-changelog-archival): PROPOSE 등재 위치 명료화 (ROADMAP `milestones[]` status:pending → `next_candidates[]` 별도 필드) 로 PROPOSE drift 70% → ~90% 부분 자연 해소 — **단 PROPOSE 단어-책임 분리 아님 (10-stage 분리 본질 아님), 등재 destination field 명료화 효과만**. ROADMAP 단어 drift 는 동일 milestone 안 schema A2 재설계로 완전 해소 (#3 row 참조).

**ROADMAP 단어 drift 해소 사례** (v3.19_word-fidelity-audit-v2 진단 ROADMAP 측 + v5.9_dictionary-semantics-integrated-audit drift 수용 paragraph 1차 정전화 + **v5.21_roadmap-forward-looking-redesign-and-changelog-archival drift 해소 정전화**): `roadmap` 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 와 현 `development/ROADMAP.md` 실 상태 사이 부합도 ~30~40% 의 drift 가 v5.21 evidence-base trigger 첫 사례로 **해소** (drift 수용 → drift 해소 본질 변경). v5.9 baseline (50 entry — completed 46 / deferred 3 / in_progress 1 / pending 0, completed-dominant 92% / forward-looking 0%) → v5.21 적용 후 (`milestones[]` length 7 — recent 3 completed + in_progress 1 + deferred 3 / `next_candidates[]` length ≥ 1 = forward-looking 신규) = ~95%+ 부합 도달. 해소 방법 = (a) Schema A2 도입 — `milestones[]` 안 recent 3 + in_progress + deferred 만 보존 + `next_candidates[]` 별도 필드 신규 (forward-looking 본질), (b) 과거 completed entry 41건 (v5.17 ~ v1.0_workflow-redesign) `CHANGELOG.md` 으로 archival 이전 (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill 패턴 정합), (c) PROPOSE register 책임 의미 자연 흡수 — PROPOSE.next_candidates → ROADMAP.next_candidates[] 1:1 매핑 (단 PROPOSE 단어-책임 분리 아님, 등재 위치만 변경). trace 보존 = REPORT.md + git log + CHANGELOG entry 3중 archival. 정전화 1차 source = [`milestones/v5.21/RESEARCH.md`](milestones/v5.21/RESEARCH.md) + [`milestones/v5.21/DESIGN.md`](milestones/v5.21/DESIGN.md) D2/D10/D11 + [`milestones/v5.21/REPORT.md`](milestones/v5.21/REPORT.md). 본 사례는 § 4 끝 #2 'Word-fidelity drift 수용' narrative 안 명시된 'evidence-base trigger 만 실 변경' 의 첫 evidence-base trigger 사례 (사용자 명시 발의 A_user 2026-05-19) — '실 변경 (ROADMAP 재정의)' 분기 활성. v3.19 baseline 1차 진단 source = [`milestones/_archive/v3.19/RESEARCH.md`](milestones/_archive/v3.19/RESEARCH.md). v5.9 drift 수용 paragraph 1차 정전화 source = [`milestones/v5.9/RESEARCH.md`](milestones/v5.9/RESEARCH.md) § axis_c_roadmap_word.

**Narrative cascade drift 검증 의무 (v5.8 → v5.9 → v5.10 cascade)** (v5.10_external-audit-team-second-call-with-diff 정전화): 정전화된 fact 가 후속 milestone carry-over 시 cascade 누락되어 동일 drift 재발 가능. v5.10 evidence — v5.8 RESEARCH (R2 + L172) 가 'audit-team 호출 0건' → '1건 (v1.17 upbit, 2026-05-14)' 1차 정정 + 부합도 60% → 65% upgrade. v5.9 carry-over 시 cascade 누락 → PROPOSE.next_candidates#5 안 'v4.0 도입 후 호출 0건' / INTENT.out_of_scope 안 'first 시도' 재 misclassification 재발. v5.10 second call (audit chain 4 멤버 read-only 재호출 + v1.17 산출물 diff) 가 cascade drift 정정 + audit-team 호출 누적 정확 정량 = 7건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth + v5.17 fifth + v5.19 sixth + v5.20 seventh). cascade drift 회피 의무 = 후속 milestone PROPOSE/INTENT carry-over 시 origin milestone RESEARCH 안 정정 fact 1차 cross-ref 검증. 진단 + audit chain 산출물 1차 source = [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../projects/upbit/audit-2026-05-18) (4 산출물 scanner/analyzer/mapper/proposal-draft).

**Audit chain fact 인용 검증 의무** (v5.11_audit-chain-fact-verification-discipline 정전화): audit chain 4 멤버 (`project-scanner` / `harness-gap-analyzer` / `claude-docs-mapper` / `component-proposer`) 산출물 안 외부 1차 source fact 인용 시 synthesizer (audit-orchestrator agent, v6.20 정전화 후) 의 직접 매핑 검증 의무. evidence cycle 2 도달 trigger — (1) v5.10 L1 `component-proposer` 12 항목 표 hallucination (django/ai-ready-scorer 등 upbit 무관) → synthesizer overwrite 정정 + (2) v5.10 `project-scanner` `claude_md_in_repo: false` hallucination → 3 산출물 (analyzer/mapper/proposal-draft) cascade 흡수 + v5.10 PROPOSE.next_candidates#4 안 5 차 위치 인용 누적 stale → v5.11 정정. 검증 운용 의무 — (a) audit chain 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 synthesizer 가 직접 source (예: 파일 존재 여부 `ls` / 파일 내용 `Read`) 매핑 검증, (b) hallucination 발견 시 산출물 archive 보존 + 정정 narrative inline 추가 (overwrite 회피, audit trail 보존) + cascade 흡수 위치 (ROADMAP entry / PROPOSE.next_candidates / 다른 carry-over milestone) 동기 정정. 진단 + audit chain 산출물 1차 source = [`milestones/v5.11/RESEARCH.md`](milestones/v5.11/RESEARCH.md) + [`milestones/v5.10/RESEARCH.md`](milestones/v5.10/RESEARCH.md) + [`../upbit/audit-2026-05-18/`](../projects/upbit/audit-2026-05-18). 절차화 (v5.13): [`claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step + [`agents/project-harness-audit-team/CLAUDE.md`](../agents/project-harness-audit-team/CLAUDE.md) D8 sequence 섹션 Note. **v5.18 (audit-chain-direct-read-and-verification-depth)**: audit chain hallucination cycle 9 누적 (cycle 7+8+9 = 8건 evidence 도달) trigger — (a) `agents/{4 멤버}.md` 안 `## Input Verification` H2 sub-section 추가 (input 산출물 직접 Read 의무 narrative — Read tool 보유 멤버 (scanner / analyzer) 직접 Read / Read tool 부재 멤버 (mapper / proposer) D10 우회 패턴 = orchestrator inline 첨부 본문 직접 인용) + (b) v5.13 절차 안 검증 method 분리 (boolean / 표 / 수치 별 매핑 method) sub-narrative 흡수 ([`claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) `--audit` 분기 L80 + [`agents/project-harness-audit-team/CLAUDE.md`](../agents/project-harness-audit-team/CLAUDE.md) D8 Note v5.18 3-stack 별도 block 분리, D11). 1차 source = [`milestones/v5.18/RESEARCH.md`](milestones/v5.18/RESEARCH.md) + [`milestones/v5.18/DESIGN.md`](milestones/v5.18/DESIGN.md) (D10 우회 패턴 + D11 3-stack 분리).

**Agent 산출 markdown lint precheck 의무** (v5.16_audit-output-markdown-lint-precheck 정전화): audit chain 산출물 산출 4 멤버 (`project-scanner` / `harness-gap-analyzer` / `claude-docs-mapper` / `component-proposer` — D8 Step 1~4, installer Step 5 제외) markdown 산출물을 repo 안 저장 시 markdownlint MD022 (blanks-around-headings) / MD031 (blanks-around-fences) / MD032 (blanks-around-lists) 3 rule 위반이 자동 발생하는 패턴 evidence cycle 2 도달 — (1) v5.14 L7 origin (cycle 3 audit 3건 발생) + (2) v5.15 L5 재현 (cycle 4 audit 8건 발생). 검증 운용 의무 — (a) agent 산출 직후 synthesizer (audit-orchestrator agent, v6.20 정전화 후) 가 markdown 본문 안 heading / fenced code block / list 직전·직후 blank line 1 줄 존재 패턴 검증 (pre-write check), (b) 위반 발견 시 inline blank line 정정 후 저장 — agent 산출물 archive 보존 + 정정 narrative inline 추가 (v5.11 fact 검증 패턴 정합 — overwrite 회피). MD022/MD031/MD032 hardcode (evidence-base 원칙) — 추가 rule (예: MD028 재발 또는 신 rule 발현) 시 본 절차 재발의 candidate. 정의 + 누적 evidence 1차 source = [`milestones/v5.14/REPORT.md`](milestones/v5.14/REPORT.md) L58-L59 + [`milestones/v5.15/VERIFY.md`](milestones/v5.15/VERIFY.md) L10-L11. 절차화 = [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step 직후 lint precheck step + [`../../agents/project-harness-audit-team/CLAUDE.md`](../agents/project-harness-audit-team/CLAUDE.md) D8 sequence 섹션 Note (v5.16).

**audit-apply-audit stability cycle pattern** (v5.20_audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade 정전화): audit-team 외부 호출 cycle 사이 upbit repo commit 0 발생 시 동일 baseline 반복 호출 = 결과 converged 패턴 = stability cycle. 구성 = (1) 동일 upbit commit SHA 유지 (예: `5aeed93` v1.20 chore) + (2) 신규 gap 0건 + (3) audit chain 산출물 R1/R2 등 apply 상태 N cycle 연속 APPLIED + (4) 신규 proposal converged (carry-over only, mechanical apply 부재). 의의 = audit 의 본질 (Context vector 7 = ecosystem integrator + apply 효과 정합 검증) 안 apply 효과 stability (rollback 없음 + 재발 부재) 직접 evidence. 누적 evidence 2 cycle 도달 trigger — (1) v5.19 cycle 6 첫 완성 (cycle 5+6 동일 v1.20 baseline + R1+R2 2 cycle 연속) + (2) v5.20 cycle 7 두 번째 완성 (cycle 5+6+7 동일 baseline + R1+R2 3 cycle 연속 + 신규 proposal 0건 converged). narrative effect isolation 한계 sub-evidence — cycle 6 hallucination 0건 vs cycle 7 hallucination 2건 (mapper origin + proposer cascade) 동일 narrative + 동일 baseline 안 변동 = narrative 효과 단일 source 분리 미가능 직접 evidence (cycle 6 = 우연 정확 / cycle 7 = 분포 본질). v5.19 PROPOSE#1 `audit-cycle-7-narrative-effect-isolation` trigger 조건 = "cycle 7+ commit 발생 후 호출 = 새 fact source 추가 = narrative 효과 단일 evidence 가능" — cycle 7 upbit commit 부재 → cycle 8+ commit 발생 시 추가 검증 candidate. 정의 + 누적 evidence 1차 source = [`milestones/v5.19/VERIFY.md`](milestones/v5.19/VERIFY.md) + [`milestones/v5.20/VERIFY.md`](milestones/v5.20/VERIFY.md) + [`../upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md`](../projects/upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md) § 5+§ 6.

**cascade 자동 동기 mechanism** (v6.4_cascade-auto-sync-mechanism 정전화): <a id="section-4-end-row-8"></a>v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source → (b) EXECUTE Edit cascade → (c) VERIFY grep 의 (b) 단계 수동 cycle (v3.18~v6.3 누적 28+, 평균 host ~5~12) 자동화. '자동' = source→host 매핑 + hash compare + diff 자동 생성 의미 (사용자는 명시 호출 `/cascade-sync` slash command 또는 `python scripts/cascade_sync.py --check|--apply`), PostToolUse hook 안 자동 trigger 는 oos_1 (v6.x 후속 candidate). 책임 분리 = slash command (UX orchestrator: script 호출 + diff 사용자 표시 + 승인 받기) + script (deterministic mechanical: enumerate + hash compare + diff text + apply) + smoke (read-only drift detect, pre-commit 자동 차단). marker format `<!-- cascade-source: <path>#<anchor> expected-hash:<16-hex> -->` = 본 repo 자체 컨벤션 (Anthropic Claude Code spec 안 표준 cascade marker / dependency tracking 패턴 부재, context7 query 안 0건 → v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 5번째). 정의 + 사용법 1차 source = [`milestones/v6.4/MILESTONE.md`](milestones/v6.4/MILESTONE.md) D1~D13.

**Claude 자율 milestone 발의 mechanism** (v6.5_claude-autonomous-milestone-proposal 정전화 + **v6.8_propose-next-surface-dedupe-mechanism 보강**): <a id="section-4-end-row-9"></a>AI Native § 7.1 '자율성' 면 첫 실 적용. ROADMAP `next_candidates[]` + 최근 5 milestone PROPOSE `next_candidates_named_only` 자동 enumerate → 다음 milestone candidate 후보 제안 → 사용자 명시 결정 게이트 (스무고개) → ROADMAP `candidate_draft[]` append. 자율 범위 = candidate 제안까지만 (결정 = 사용자 — round 1 결정 정합). **v7.0 T1.2 정전화**: lessons_learned P2 자동 종합 폐지 (후보 source = ROADMAP + 최근 5 PROPOSE only, `scripts/propose_next.py` lessons P2 grep/count 제거) + `next_candidates[]` append = 사용자 명시 결정 게이트 후만 (자동 append 폐지 — 부산물 cycle 차단). 책임 분리 = slash command `/propose-next` (UX orchestrator: script 호출 + 최우선 1건 우선 보고 + 비유 표현 + 사용자 응답 + Edit append) + script `scripts/propose_next.py` (deterministic read-only enumerate: 1차 디렉토리 semver desc + 2차 ROADMAP/CHANGELOG cross-validate, v5.18 Input Verification 정합) + smoke `tests/smoke-candidate-draft-schema.sh` (read-only schema 검증 책임 = 7 필드 + category enum 2 값 / v6.8 Stage 2 확장 candidate_items 3 필드 + status enum 2 값 + dedupe_stats 4 필드). `candidate_draft[]` host = v4.0 phase-7 narrative (벤치마크 cycle routine schedule skill 주 1회 cron, 작동 0건 v5.8 evidence) 와 공존 — `category` 필드 enum 2 값 분리 (`internal_synthesis` = v6.5 자율 발의 / `benchmark_external` = v4.0 벤치마크 cycle). **v6.8 surface 자동 dedupe 확장**: v6.5 mechanism 외부 cycle 1 evidence (2026-05-20, commit ed44bed) — `/propose-next --scan` 출력 안 enumerated_milestones 9건 중 8건 (89%) 이 이미 next_candidates 안 등재 → LLM surface 시 duplicate 위험 → script 자체 enumerated 둘로 분리 (`status: delta` 신규 surface | `status: passing` 이미 인지). matching key = id 우선 (`{1,64}` group-slug regex 추출) + title fallback (legacy era v3~v5 PROPOSE schema 변동 안 id 부재 안전망). dedupe scope = `next_candidates[]` + `candidate_draft[]` 양쪽 (이미 인지한 후보 통합 의미 — buffer 안 entry 재 surface 위험 0). LLM Step 2 안 `status: delta` 우선 surface + passing 통계 only narrative ('이미 N건 등재 (passing). 신규 M건 (delta) 우선 검토'). deterministic (LLM 누락 risk 0 + token cost 0). 정의 + 사용법 1차 source = [`milestones/v6.5/MILESTONE.md`](milestones/v6.5/MILESTONE.md) D1~D12 + [`milestones/v6.8/MILESTONE.md`](milestones/v6.8/MILESTONE.md) D1~D11. v3.21 narrative 정전화 3 단계 패턴 cycle 34 자연 발현 + AI Native § 7.1 '자율성' 면 second cycle.

**audit chain hallucination 자동 검출 mechanism** (v6.6_audit-chain-hallucination-auto-correction 정전화 + **v6.9_synthesizer-mismatch-report-5step-format 보강**): <a id="section-4-end-row-10"></a>AI Native § 7.1 '다중 AI 협업' 면 second cycle (v6.4 cascade-sync 첫 cycle 후속). v5.13/v5.18 정전화 절차 (synthesizer 직접 source 매핑 검증 + 검증 method 분리 boolean/표/수치) 의 수동 cycle (v5.10~v6.5 누적 9+, evidence cycle 4 = v5.10/v5.11/v5.12/v6.5) script-only 자동 검출. 자율 범위 = 검출 only (자동 정정 부재 — 재귀 hallucination 위험 차단 + 사용자 결정 게이트 보존 + memory `feedback_subagent_fact_hallucination_correction` '비대칭 default' 직접 정합, R1 결정). Trigger = `--audit` flow 안 audit-team synthesizer step (Step 6 신규, proposer 직후 installer 직전) 자동 통합 (별 slash command 부재 — v6.4/v6.5 패턴과 facing 대상 다름, R2 결정). scope = audit chain 4 agent (scanner/analyzer/mapper/proposer) 산출물 한정 (cycle 4 evidence 정확 매핑, 외부 산출물 oos_4). 책임 분리 = deterministic core (`scripts/audit_fact_verify.py` ~250 LOC, stdlib only re+json+pathlib, BOOLEAN_LOOKUP callable lookup 5 evidence-base 항목 + 표 schema column 매핑 + NUMERIC_LOOKUP empty no-op fallback evidence 도달 시 자연 확장, D1/D2) + narrative orchestrator (`agents/project-harness-audit-team/CLAUDE.md` Note v6.6 + Step 6 sequence 갱신 + 4 agent 표 column 본질 명시, D3/D5) + smoke (`tests/smoke-audit-fact-verify.sh` fixture-based read-only — 6 fixture sub-dir [boolean × 2 + 표 × 2 + numeric + empty] + Stage 5 path traversal 차단 검증, D4/D6). 본 mechanism 의 운영 책임 분리 = 3-step chain (`v6.7_v513-v518-v66-3step-chain-narrative-canonicalization` 정전화) — (a) 수동 1차 source (`v5.13_audit-chain-fact-verification-protocol-procedure` 3 method + `v5.18_audit-chain-direct-read-and-verification-depth` 검증 method 분리) → (b) 자동 검출 (본 v6.6 mechanism Step 6 자동 호출) → (c) 수동 정정 (사용자/orchestrator, R1 자율 = 검출 only 결정 정합). 검출 (b 자동) ↔ 정정 (c 수동) 비대칭 default = memory `feedback_subagent_fact_hallucination_correction` 직접 정합 + cycle 4 evidence (v5.10/v5.11/v5.12/v6.5). 인용 method (cycle 4 v6.5 evidence `v4.0/PROPOSE.md:54 category fleet-evolution` fact 부재) = LLM 추론 필요 → script-only 불가능 + 재귀 hallucination 위험 → v6.6 scope 외 (oos_2), PROPOSE 후속 거명만 (target_version v6.x — '인용 method 자동 detect mechanism'). Agent SDK `output_format=json_schema` 미채택 — script-only stdlib 유지 (외부 의존 회피 + fact 정확성 검증 schema 외 책임 + v5.13/v5.18 narrative 정합, D11). 외부 spec 안 first-class 'audit chain fact verification' 패턴 부재 (context7 verification = code-reviewer + Agent Hook for Test Verification 2종만, 직접 인용: "A read-only subagent for code review... Run git diff to see recent changes... Critical issues / Warnings / Suggestions" + "Verify that all unit tests pass. Run the test suite and check the results.") → 자기 정전화 자연 (v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 7번째 자연 발현, D12). 정의 + 사용법 1차 source = [`milestones/v6.6/MILESTONE.md`](milestones/v6.6/MILESTONE.md) D1~D12. **v6.9 mismatch 보고 5-step 형식 enhancement**: Anthropic Claude Code debugger subagent (<https://code.claude.com/docs/en/sub-agents>) 의 5-step prompt ("1. Capture error message and stack trace / 2. Identify reproduction steps / 3. Isolate the failure location / 4. Implement minimal fix / 5. Verify solution works") 정합 — `scripts/audit_fact_verify.py` 안 3 detect function (boolean/table/numeric) mismatch dict schema 5-step 통일 (6 필드: method 보존 + capture/identify/isolate/fix/verify, isolate 안 method-specific dict 보존 = boolean/numeric {stated, actual, key} / table {source_ref, issue}). 책임 분리 = script Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (null, LLM/사용자 채움 — v6.6 R1 자율 = 검출 only + v6.7 3-step chain 수동 v5.13/v5.18 1차 source → 자동 v6.6 검출 → 수동 정정 사용자/orchestrator 정합). 미래 script (예: propose_next.py mismatch detect 도입 시) 동일 5-step schema 정합 의무 (cross-cutting feature 본질, scope 일반 정전화). v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 9번째 자연 발현 (외부 spec 인용 → 직접 정전화). 정의 + 사용법 1차 source = [`milestones/v6.9/MILESTONE.md`](milestones/v6.9/MILESTONE.md) D1~D11. **v6.14 NUMERIC_LOOKUP cycle 7 evidence + mechanism context scope narrative enhancement**: v6.6 mechanism 안 `NUMERIC_LOOKUP` empty {} no-op fallback narrative (risk_2/risk_3 안 'evidence 도달 시 lookup 추가 자연') 의 cycle 7 v5.17 evidence (scanner-output cycle 5 line 130 JSON 형식 `claude_md_lines: 148` + `claude_md_bytes: 9158` wc -l/-c 실측 정정) 자연 도달 = 2 entry (`claude_md_lines` = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').splitlines())` + `claude_md_bytes` = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').encode('utf-8'))` Python stdlib cross-platform safe) 자연 추가. **mechanism context scope 본질 명시** — BOOLEAN/NUMERIC lookup callable scope = harness-meta repo (REPO_ROOT 기준) context 한정 cover, target project (외부 repo 예 upbit) context 검증 oos (v6.6 D10 path traversal 차단 narrative `safe_resolve` 안 REPO_ROOT prefix 검증 → 외부 path reject 직접 정합). 본 자기 한계 인정 narrative = 외부 context 검증 mechanism 필요 시 별 milestone 자연 (scanner agent.md `target_project_root` field 명시 + path traversal narrative 갱신). pre-PLAN 11 round 누적 결정 trace — round 5 finding (BOOLEAN_LOOKUP REPO_ROOT vs target project context mismatch) → round 9 finding (target project = harness-meta 외부 별 git repo + v6.6 D10 path traversal 차단 narrative 외부 path 불허 = mechanism 작동 불가능) → round 10 (Y) 회귀 (lookup signature 변경 폐기, v6.6 보존) + (P1) 전면 재작성. v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 11번째 자연 발현 (context7 query 안 동치 패턴 부재 finding, 자기 정전화 v6.6 D12 정합). 정의 + 사용법 1차 source = [`milestones/v6.14/MILESTONE.md`](milestones/v6.14/MILESTONE.md) D1~D11.

**fixture-based smoke 자동화 패턴 cycle 2** (v6.12_smoke-stage-3-tests-fixture-pattern 정전화): <a id="section-4-end-row-11"></a>v6.6 cycle 1 (smoke-audit-fact-verify fixture sub-dir 6 종 — boolean × 2 + 표 × 2 + numeric + empty + Stage 5 path traversal 차단) 안 적용된 fixture-based smoke 자동화 패턴 의 본 repo 자체 정전화 cycle 2 (smoke-candidate-draft-schema 안 fixture sub-dir 7 종 — normal + violation 6 × Stage 1 logic 검증 항목 매핑). 본질 = controlled 비교 (sub-dir 안 fixture roadmap.md + expected exit code mapping + smoke 안 validate() 함수 재호출) → fixture FAIL count > 0 ↔ exit code 1 매핑 비교. v6.6 cycle 1 = `validate` 책임 = script 분리 (`scripts/audit_fact_verify.py`) + smoke 가 subprocess 호출 / v6.12 cycle 2 = `validate_candidate_draft()` 함수 분리 (smoke 자체 안 누적, 별 script 부재) — book 분리 정책 본질 동일 (책임 단일 source 분리). Anthropic Claude Code spec 안 first-class 'fixture-based smoke automation' 패턴 부재 (context7 query 안 0건, v6.6 D12 + v6.4 패턴 정합) → 본 repo 자체 정전화 단일 source. evidence cycle 2 도달 trigger — (1) v6.6 phase-1 commit (29a3ab1, 2026-05-20) 첫 발현 + (2) v6.12 phase-1 commit 두 번째 발현. 책임 분리 = smoke loop logic (각 sub-dir 안 fixture path 명시 호출 = projects/*/ROADMAP.md glob 분리, v6.6 D8 정합 + v6.12 D8) + sub-dir name → expected exit code mapping (smoke 내부 hardcode, expected.txt 별 파일 부재, v6.6 D7 + v6.12 D7) + validate() 함수 재호출 (silent mode, v6.6 fixture loop 안 subprocess / v6.12 fixture loop 안 in-process). v3.21 narrative 정전화 3 단계 패턴 cycle 3 안 (a) RESEARCH 1차 source 식별 (cb_1~cb_6) + (b) EXECUTE Edit 3 host (smoke + tests/CLAUDE.md + ARCHITECTURE) + (c) VERIFY grep 수동 (cascade-sync marker opt out, v6.12 R3) — 본 paragraph 가 cascade host #3. 정의 + 사용법 1차 source = [`milestones/v6.12/MILESTONE.md`](milestones/v6.12/MILESTONE.md) D1~D14.

**stage 본질 = templated section 작성 task 정전화 및 skill 시범+확장 도입** (v6.16_stage-templated-task-canonicalization-and-skill-pilot 정전화 + **v6.18_stage-skill-expansion-7-stages 7 stage 확장**): <a id="section-4-end-row-12"></a>v6.2 9-stage-flattened era 도입 (2026-05-19) 이후 stage 본질이 'MILESTONE.md 안 H2 section 1 칸 작성 task' 로 자연 수렴 + v6.4~v6.9 mechanical 누적 자동화 cascade (cascade_sync v6.4 / propose_next v6.5+v6.8 / audit_fact_verify v6.6+v6.9) 후 mechanical 부분 잔존 0 → 남은 본질 = section narrative 작성 (= LLM judgment 본질). 사용자 자연어 표현 차이 origin (2026-05-21 대화 — "open 진입이 아니라 open 작성") = 본 자연 수렴 evidence. 정전화 본질 = ARCHITECTURE § 7.3 신규 sub-section (본문 1차 source) + 본 § 4 매트릭스 #12 row + 본 § 4 본문 paragraph 3 host 양방 cascade. skill = derived checklist 정합 본질 (단방향 derived, cascade marker 부재 자연) — frontmatter description = trigger keyword narrow (예: 'milestone OPEN stage 진입') + body 4 H2 (입력 / 작성할 것 / 검증 / 관련) = forcing function 보조 + narrative judgment 보존 (LLM at runtime). **v6.16 시범 scope = OPEN + PROPOSE 2 stage** (mechanical-heavy 우선 포맷 검증) → **v6.18 확장 scope = 9 stage 전체** (INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT 7 stage 일괄 도입 = rm_5 일관성 mitigation 자연 도달, v6.17 도그푸드 cycle 1 PASS evidence trigger 충족). entry skill (harness-meta:harness-meta = 9-stage workflow 진입점) ↔ stage skill (단일 stage 진행) 코existence + trigger keyword 본질 별 분리 (v6.16 D3). v3.21 narrative 정전화 3 단계 패턴 cycle 37 (v6.16) + cycle 38 (v6.18) 자연 발현 + AI Native § 7.1 컨텍스트 효율 면 third cycle (v6.0 정의 → v6.2 디렉토리 평탄화 cycle 2 → v6.16+v6.18 stage 본질 정전화 cycle 3 enhancement). 정의 + 사용법 1차 source = [`milestones/v6.16/MILESTONE.md`](milestones/v6.16/MILESTONE.md) D1~D10 (시범) + [`milestones/v6.18/MILESTONE.md`](milestones/v6.18/MILESTONE.md) D1~D10 (7 stage 확장) + [§ 7.3](#73-stage-본질-templated-section-작성-task).

**CHANGELOG → GitHub Releases hybrid migration mechanism** (v6.19_changelog-github-releases-migration 정전화): <a id="section-4-end-row-13"></a>CHANGELOG.md SIZE_LIMIT 회귀 회피 (v6.18 evidence 99998 bytes / 100000 -2 한계 + v6.17/v6.18 entry 1줄 단축 압박 누적) + GitHub Releases mechanism 도입. AI Native § 7.1 3 면 enhancement (컨텍스트 효율 cycle 4 / 자율성 cycle 2 / 다중 AI 협업 cycle 4). 시간 분기 본질 = 3 era — (1) v1.0~v5.21 trace = CHANGELOG.md 안 ID + title + REPORT link 1줄 archived (52 entry, ~6KB) + git log + REPORT.md 본문 / (2) v6.0~v6.18 trace = CHANGELOG.md 본문 잔존 (hybrid 분기 marker = v6.19 = last full entry) / (3) v6.19+ trace = GitHub Releases 단일 source (CHANGELOG entry 추가 단속). trigger = `.github/workflows/release-publish.yml` 안 (a) `on: push: branches: [main]` + `if: contains(github.event.head_commit.message, '[release:v')` filter + (b) `workflow_dispatch` 수동 trigger (version + dry_run input). 사용자 통제 본질 = commit msg explicit marker `[release:v{X.Y}]` 작성 자체 = 명시 결정 게이트 (memory `커밋·배포 전 확인 요청` 직접 정합 — marker 부재 commit = workflow no-op). workflow logic 7 step = checkout fetch-depth=0 → version 추출 (commit msg regex 또는 dispatch input) → dry_run mode 결정 → MILESTONE.md locate (era 분기 본질 = v6.2+ flattened) → REPORT 섹션 추출 (`awk '/^## REPORT/{flag=1; next} /^## PROPOSE/{flag=0} flag'` flag-based) → tag conflict check → dry_run summary OR (git tag push --follow-tags + `gh release create --notes-file --target ${{ github.sha }}`). 책임 분리 = workflow yaml (deterministic mechanical) + commit msg marker (사용자 명시 결정 본질) + MILESTONE.md ## REPORT (release body single source, polish oos). v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 cycle 13 자연 발현 — context7 ext_4 (`gh release create --notes-file`) + ext_5 (`contains()` expression) 추정 명시 → EXECUTE phase-1 verification (ext_5 verified + ext_4 partial verified) → mismatch 부재 hardcode 유지. v3.21 narrative 정전화 3 단계 패턴 cycle 39 자연 발현 (cascade host 2 = 본 § 4 매트릭스 #13 row + 본 § 4 본문 paragraph). archival cycle 두 번째 (v5.21 첫 = v1.0~v5.20 backfill / v6.19 둘째 = v1.0~v5.21 단축). CHANGELOG.md 안 본 archival 적용 후 size 99998 → 65705 bytes (-34.3%, < 70KB target 정합 — DESIGN D5 < 50KB → EXECUTE phase-2 evidence-base second retouch < 70KB). 정의 + 사용법 1차 source = [`milestones/v6.19/MILESTONE.md`](milestones/v6.19/MILESTONE.md) D1~D9 + [`.github/workflows/release-publish.yml`](../.github/workflows/release-publish.yml).

**bundled skill 카탈로그 cross-ref — 책임 매핑 표 16 row evidence** (v6.21_bundled-skill-comprehensive-cross-audit 정전화): <a id="section-4-end-row-15"></a>Claude Code 안 'bundled skills' 카테고리 본질 = 'prompt-based playbooks' (vs 'built-in commands' fixed logic, context7 `/websites/code_claude` ext_1 직접 인용). 명시 카탈로그 = `/simplify` + `/batch` + `/debug` + `/loop` + `/claude-api` (5건) + `/run` + `/verify` + `/run-skill-generator` (v2.1.145+ 필요, 3건) + 추가 user-invocable (`/code-review` + `/review` + `/init` + `/security-review` + `/keybindings-help` + `/update-config` + `/fewer-permission-prompts` + `/schedule` 8건, 카테고리 본질 별 = built-in fixed-logic 또는 plugin 또는 cross-list). 책임 매핑 표 16 row × 6 column (skill / 카테고리 / Anthropic 본질 / 본 repo 대응 / 결정 / 근거) dogfood evidence cycle 1 직접 호출 (`/fewer-permission-prompts` body 본질 파악 + 실 추가 회피 default — 본 milestone scope 외 자산 변경 본질) + 15건 description+body Read fallback. **흡수 0 / 유지 16 = 본 repo 시스템 책임 폭 우위 직접 evidence** — bundled skill (Anthropic 표준) 본질 vs 본 repo 시스템 (9-stage workflow + 5 관점 review + cascade-sync + propose-next + audit-team + 자율 mechanism + plugin SKILL.md 14건) 책임 폭 차이 16 row 모두 본 repo 우위. R5 default 유지 (사용자 명시 결정) + d_4 evidence-base 흡수 default 정합. cross-list 카테고리 = `/debug` (built-in + bundled) + `/code-review` (bundled + plugin) 자연 발견. 본 환경 부재 4건 (`/simplify` + `/batch` + `/debug` + `/run-skill-generator`) = Claude Code 버전 분기 또는 plugin 별도 install 추정 → 본 environment fact verify 정전화 후속 candidate 자연 (spec-drift P3#2). v3.21 narrative 정전화 3 단계 패턴 cycle 41 단일 host 본질 (v6.10 L3 단일 host 적용 대상 부재 경우 패턴 적용 회피 가이드 정합 cycle 2) + 5 관점 review cycle 8 (decisive 0 + P1 0 + P2 16 + P3 12 = 28건, cycle 4 v6.4 38건 0.74배 추가 감소 converged 추세 정합). 정의 + 사용법 1차 source = [`milestones/v6.21/MILESTONE.md`](milestones/v6.21/MILESTONE.md) + [`milestones/v6.21/execute/phase-1.md`](milestones/v6.21/execute/phase-1.md) (책임 매핑 표 16 row × 6 column 본책).

**Agent(agent_type) syntax 흡수 — audit-orchestrator agent 정전화** (v6.20_agent-type-syntax-adoption 정전화): <a id="section-4-end-row-14"></a>post-v6.19 audit session (2026-05-21, commit 192f374) 안 본 repo 자산 전수 audit + Claude/GitHub 표준 대체 검토 결과 발견된 4 자산 흡수 매트릭스 안 'full' 흡수 강도 유일 1건 origin (next_candidates#18). v2.1.33+ Claude Code `Agent(agent_type)` syntax (frontmatter `tools` 필드 안 `Agent(specific-agent)` literal allowlist) 흡수 본질 = `agents/audit-orchestrator.md` 신설 + frontmatter `tools: Agent(project-scanner, harness-gap-analyzer, claude-docs-mapper, component-proposer, component-installer), Read, Bash, Edit, Grep, Glob` 명시 (본 repo 안 첫 Agent(agent_type) literal 사용 사례, RESEARCH cb_1 안 `Grep 'Agent\('` 0 match evidence 정합 — cycle 1 evidence). 효과 = (a) audit-team 5 멤버 만 spawn 허용 = audit-team 외 agent (agents-md-sync / environment-auditor 등) spawn 차단 sandbox 효과 + (b) Step 1~6 통합 책임 흡수 (Step 1~4 read-only sequential + Step 4↔5 USER DECISION GATE + Step 5 component-installer spawn accept 시만 + Step 6 synthesizer fact verify + lint precheck 통합). write 권한 단독 본질은 `component-installer` 자체 frontmatter level (`tools: Bash, Edit, Read`, 5 멤버 중 유일 write 멤버, RESEARCH cb_5) 안 이미 정합 — 본 v6.20 allowlist 는 audit-team 경계 syntax-level 강제 본질. cascade host 9 = (i) audit-team CLAUDE.md (1차 source — D8 sequence narrative + v6.20 정전화 Note) + (ii) claude/commands/harness-meta.md `--audit` flow 전면 재작성 (메인 Claude → audit-orchestrator agent 단일 invoke) + (iii) development/ARCHITECTURE.md § 4 paragraphs #5/#6 거명 정정 + (iv) root CLAUDE.md (audit-orchestrator agent 본질 자연 매핑, cascade marker 보존) + (v~viii) 4 agent .md (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer Input Verification 섹션) + (ix) component-proposer.md L82. ext_2 transitive 비적용 spec hardcode (audit-orchestrator agent body Note 안 직접 인용 — `code.claude.com/docs/en/sub-agents` 안 'This restriction does not apply to subagents spawning other subagents.' = audit-orchestrator agent 의 frontmatter tools 는 self-spawn allowlist 본질 매핑) = v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 14번째 자연 발현. v3.21 narrative 정전화 3 단계 패턴 cycle 40 자연 발현 — (a) DESIGN 1차 source 식별 = audit-team CLAUDE.md L25 D8 sequence + 본 paragraph + (b) EXECUTE Edit cascade 9 host (DESIGN d_5 4 host minimum + EXECUTE 발견 5 추가, lightweight 자연 확장) + (c) VERIFY grep ('메인 Claude.*orchestrator' active narrative 0 match, historical milestone 산출물 안 보존). 정의 + 사용법 1차 source = [`milestones/v6.20/MILESTONE.md`](milestones/v6.20/MILESTONE.md) D1~D7.

**milestone version mechanism 통합 재고 — bundling 자연 발현 본질 명문화 + 5 source 우선순위 정전화** (v6.23_version-mechanism-integration-rethink 정전화): <a id="section-4-end-row-16"></a>v6.16~v6.22 7 micro milestone 누적 패턴 (RESEARCH cb_4 통계 = 평균 1.57 phase + 1-phase 비율 5/7 ≈ 71.4% + ## SUB_MILESTONES 활용 0/7) 발견 후 사용자 명시 발의 (2026-05-22, A_user trigger) — 'bundling cycle 재개 평가' + 'git tag 단일 version source 평가' 두 본질 통합 lightweight milestone (사용자 명시 R1 결정 = 평가 + 결정만, 실 적용 oos_1 = v6.24+ 별 milestone 자연 분기). 평가 outcome 두 결정 = (1) **v6.23.1 bundling 본질 = opt_2 자연 발현 채택** (R6 결정) — 현행 본질 명문화 (≥2 sub trigger 자연 발현 시만 ## SUB_MILESTONES 활용, RESEARCH cb_3 정전 본질 §6.1 1-phase 정합 paragraph '후속 candidates ≥2 건일 때 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재' 정확 정합) + (2) **v6.23.2 git tag 본질 = opt_4 N=5 현행 유지 채택 + 우선순위 narrative 정전화** (R7 결정) — 5 source duplication 본질 변경 부재 (lightweight + churn 회피) + redundancy 인정 본질 정합.

**misnomer evidence 흡수**: INTENT motivation 안 'forward-only forsake' 표현 = cb_2/cb_3 정전 본질 (§ 6.1 v6.2 flattened era paragraph + 1-phase 정합 paragraph) 와 부분 정합 — 정전 본질 = 'bundling 본질 보존 (era 명명 분리 ≠ bundling 정책 폐기) — ## SUB_MILESTONES 섹션 안 흡수' (cb_2 직접 인용). v6.16~v6.22 = 각 단일 본질 → 1-phase 자연 + bundling cycle dormant 상태 (활용 부재 ≠ 폐기). v6.23 = 첫 ≥2 sub 자연 발현 cycle = ## SUB_MILESTONES 섹션 첫 실 활용 (cb_8 evidence direct, 자기참조 dogfood). INTENT 본문 historical 보존 (R5 결정) + audit trail = RESEARCH cb_2/cb_3 + REPORT lessons L1.

**5 source 우선순위 narrative 정전화** (DESIGN d_7): milestone version mechanism 안 5 source 본질 매핑 — (1) 디렉토리명 (`development/milestones/v{X.Y}/`) = **primary path source** (smoke era detect `tests/_era_detect.py` + cascade_sync `scripts/cascade_sync.py` 의존 source 본질), (2) frontmatter version = **redundant in-file trace** (MILESTONE.md YAML 안, smoke-spec-verification.sh frontmatter_required 강제), (3) ROADMAP `milestones[].version` = **forward-looking ROADMAP trace** (propose_next + smoke-candidate-draft-schema 의존), (4) git tag = **release trigger source** (v6.19 GitHub Release mechanism commit msg marker `[release:v{X.Y}]` 발급, cb_5 정합), (5) GitHub Release tag = **external visible trace** (gh release create 자동 발급, git tag 1:1 매핑). 5 source redundancy 인정 본질 정합 — trace 다중 본질 보존 + lightweight scope (변경 부재 churn 회피, opt_5/opt_6 = breaking change + smoke + cascade_sync + 28 active milestone backfill 부담 회피).

**v3.21 narrative 정전화 3 단계 패턴 cycle 43 자연 발현** (단일 host 본질, v6.10 L3 + v6.21 cycle 41 단일 host 패턴 정합 cycle 3) — (a) DESIGN 1차 source = 본 paragraph + § 4 끝 매트릭스 #16 row (R3 + R3.5 결정 정합) + (b) EXECUTE Edit cascade = 단일 host (§ 4.1 + § 6.1 cross-ref 거명만, paragraph 본문 안 자연) + (c) VERIFY grep 자연 (smoke-cross-ref + cascade-sync --check 부재 default — cascade marker 단일 host 자연). 5 관점 inline review cycle 10 자연 발현 (R8 결정, decisive 0 + PASS 3 + pass-with-comments 2). v6.16~v6.22 lightweight 1-phase 14 consec → v6.23 15 consec 연장 (sc_4). 정의 + 사용법 1차 source = [`milestones/v6.23/MILESTONE.md`](milestones/v6.23/MILESTONE.md) D1~D8.

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

자세한 단계별 책임 + 절차 + AskUserQuestion trigger + 금지 목록은 root [`../../CLAUDE.md`](../CLAUDE.md) § "워크플로우 (v2.0+ 9-stage)" + slash command [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md) 참조.

## 5. 비대칭 의도 (CRITICAL)

`development/milestones/` 는 본 repo 안에 존재하지만 `projects/upbit/milestones/` 는 **부재** — upbit milestone 산출물은 upbit repo 자체에 위치한다 (root CLAUDE.md "프로젝트별 하네스 개선" 컨벤션). meta는 본 repo가 곧 자체 작업 공간이므로 본 repo의 `development/milestones/` 보유.

이 비대칭은 의도적: `projects/<name>/` 는 "harness-meta 가 인지하는 프로젝트 trace 의 view" 이며, meta 만 본 repo 가 곧 작업 repo 이므로 milestones/ 디렉토리 보유. 미래 N 개 프로젝트 추가 시 동일 패턴 — 작업 repo 가 곧 본 repo 인 경우만 `projects/<name>/milestones/` 보유, 나머지는 ROADMAP + ARCHITECTURE 만.

## 6. 변경 시 주의 + era 정책

- root `CLAUDE.md` / `AGENTS.md` 갱신 시 본 ARCHITECTURE.md 동기 검토 (drift risk)
- 신규 milestone 진입 시 `development/milestones/v{X.Y}_{slug}/` 생성 (root `milestones/` 부활 금지)
- root ROADMAP.md 는 thin index 유지 — milestones[] 키 추가 금지 (smoke `tests/smoke-projects-scope-discipline.sh` 가 차단)
- ★ § 3 (하네스 엔지니어링 정의) 본문·매트릭스는 **본 파일이 단일 source** — 다른 문서로 복제 금지, cross-ref 만 허용

### 6.1 era 정책 (4 era 명문화 + bundling)

milestone 디렉토리 명 + 산출 파일명 자체로 era 자동 추론:

| era | version 범위 | era 표지 (smoke 자동 식별) | 신규 작업 |
|---|---|---|---|
| **9-stage-flattened** | v6.2+ | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `MILESTONE.md` (단일 본책, H2 9 섹션 = ## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES + 조건부 ## SCOPE_OUT_NOTES) + execute/phase-{n}.md (별책) | ✅ 의무 (v6.2+ 신규) |
| **9-stage-bundled** | v3.0~v6.1 | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `milestones.md` (sub-milestone listing per version) + INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md | ❌ 참조용 보존 (v6.1 까지), 신규 금지 — v6.2+ 9-stage-flattened 의무 |
| **9-stage** | v2.0~v2.1 | 디렉토리 명 `v{X.Y}_{slug}` + INTENT/APPROVE/PROPOSE 3종 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 신규 금지 (forward-only 정책) |
| **7-stage** | v1.0~v1.4 | 디렉토리 명 `v{X.Y}_{slug}` + PLAN.md 존재 + INTENT/APPROVE/PROPOSE 동시 부재 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 참조용 보존, 신규 금지 |
| **4-tier** | v1.84~v1.88 | 어셈블 plan-N/{PLAN,REPORT}.md (sub-plan 구조) | ❌ 참조용 보존, 신규 금지 |

**9-stage-flattened era 정전화 (v6.2_milestone-artifact-directory-flattening, 2026-05-19)**: AI Native § 7.1 컨텍스트 효율 면 두 번째 실 적용 milestone (v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화). 본질 = 1 milestone 디렉토리 안 6~8 파일 분산 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md) → 1 본책 (MILESTONE.md) + 1 별책 디렉토리 (execute/) 통합 = AI 1 Read 으로 milestone 전체 흡수. 형태 = (b) 하이브리드 (책 + 별책 비유) — 본책 안 H2 9 섹션 (8 stage 단어 fidelity 보존 + 1 SUB_MILESTONES listing, v2.0_workflow-word-fidelity 정전화 정합) + 별책 phase-{n}.md (실 구현 일지 분리, 동시 편집 가능). **조건부 ## SCOPE_OUT_NOTES** (v7.0 T1.3, 2026-05-25) = Stage D design-review N+ 가변 안 scope 외 거명 발생 시만 생성하는 선택 H2 (SUB_MILESTONES 선례 정합 — 고정 10 H2 아님, § 11.4 + smoke-spec-verification 은 필수 8 stage 섹션 존재만 검사하므로 추가 섹션 무해). YAML frontmatter = 4 필드 (id/title/version/status — stage 필드 제거, milestone-level 통합 표지 = H2 섹션 자체). 적용 범위 = v6.2+ 신규만 (v3.0~v6.1 28 active 디렉토리 era 보존, era 분기 자연 확장 — forward-only 정책 일관). bundling 정책 (version 단위 1 milestone + sub-milestone phase 매핑) 본질 = ## SUB_MILESTONES 섹션 안 흡수 = bundling 본질 보존 (era 명명 분리 ≠ bundling 정책 폐기). 자기참조 부합 = phase-2 도그푸드 (자체 MILESTONE.md retrofit). detect_era 검사 순서 우선 = 9-stage-flattened (MILESTONE.md 존재 첫 검사, milestones.md 보다 우선 — phase-2 retrofit 일시 동시 존재 케이스 deterministic 보장).

**bundling 정책 (9-stage-bundled era, v3.0+)**: version (= 1 milestone) 단위로 의미 단위 후속 candidates 를 묶음.

- **묶이는 단위 (의미 grouping)**: (a) 같은 모듈 영향 (예: tests/CLAUDE.md 동시 수정), (b) 같은 주제 (예: smoke 인프라 / 정책 명문화), (c) 같은 lessons_learned 에서 발의된 후속 candidates
- **분리 단위 (별 milestone)**: 다른 모듈 / 다른 주제 / 시간 단위만 같은 (release train 모델 부적합)
- **운용**: 한 milestone (= version) 안 sub-milestone 들은 phase 단위 1 commit 으로 운용. INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 산출물은 통합 1건. ROADMAP `milestones[]` entry 는 version 단위 1건 (sub-milestone 상세는 milestones.md 위임)

**1-phase milestone 정합 (v3.17_phase-distribution-audit 진단 + v3.18_option-a-natural-adaptation-narrative 정전화)**: 같은 의미 단위 후속 candidates 가 1건 (= `sub_milestones[]` 1 entry) 일 때도 본 era 정합 — `milestones.md` 가 narrative 1차 source 책임 충족하면 phase 다중 통합 (≥2 건 자연 활용) 와 1-phase 정전화 (1 건) 두 경로 모두 정상. 정량: v3.7~v3.16 = 100% 1-phase, v3.x 전체 17 milestone = 12/17 = 70.6% 1-phase (`development/milestones/v3.17/RESEARCH.md` 분포표 1차 source). bundling 의미 grouping 본질 = 후속 candidates 가 ≥2 건일 때 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재.

**자기참조 부합 (도그푸드, v3.0+ 권장)**: 새 era 도입 milestone 자체가 신 구조 첫 적용. 회피 표지 (v2.0 선례 — 본 milestone `v2.0_workflow-word-fidelity` 자체가 7-stage 포맷 사용, chicken-and-egg 회피) 는 신뢰 부족 시만 예외. v3.0_milestones-restructure 는 부합 채택 — phase-1 smoke era branching 선결 commit 으로 chicken-and-egg mitigate.

**breaking change → major bump (semver)**: era 도입 (= ROADMAP schema + 디렉토리 명 + 모든 cross-ref 영향) 은 breaking change → major bump (예: v2 → v3). semver.org 정합. 단조 증가 정책 (root CLAUDE.md) 직접 적용.

**era 영구화 trade-off (forward-only)**: era N 추가 = smoke 분기 N+1 코드 복잡도 누적. forward-only 정책 (historical 디렉토리 unchanged) 의 직접 비용. detect_era 함수 (`tests/_era_detect.py`, v2.2_era-detect-shared-module 흡수 v3.0 phase-2) 단일 source 로 mitigate. era N+1 추가 시 본 § 6.1 표 + tests/_era_detect.py 갱신 의무.

**milestones.md spec historical era 적용 결정 (v3.1 phase-2 흡수)**: milestones.md spec picture-frame (`development/milestones/v3.0/milestones.md` § Spec, v3.0 phase-5 도입) 의 적용 era 정책 = **옵션 (a) forward-only 강제**. v3.0+ 9-stage-bundled era 만 milestones.md 의무 (§ 6.1 표 행 1), historical era (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier) 부재 영구. rationale: (1) v2.x 9-stage flat 구조 = 디렉토리 명 `v{X.Y}_{slug}` 단위 1 milestone (sub-milestone 부재) → milestones.md 의 sub_milestones[] phase 매핑 본질 부적합, (2) v1.x 7-stage / 4-tier 동일, (3) forward-only 정책 (§ 6.1 'era 영구화 trade-off') 직접 일관 — historical 디렉토리 unchanged. 옵션 (b) v2.x retroactive / (c) 신규만 거부 — (b) 본질 부적합 + git mv history 위험, (c) (a) 와 사실상 동치. spec picture-frame: `development/milestones/v3.0/milestones.md`. 본 결정은 v3.1_workflow-policy-fine-tuning phase-2 흡수, historical 디렉토리 변경 부재.

**smoke 자동 식별 보조**: `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` 가 위 era 표지로 era 분류 후 schema 차별화 검증 (narrative 1차 source + smoke 보조, § 3.1 정책 일관). detect_era 함수는 `tests/_era_detect.py` 단일 source.

**§ 6.2 폐지 narrative** (v4.0_harness-composer-pivot, 2026-05-13): 구 § 6.2 "Lightweight 모드 정책 (v3.6_overengineering-audit 도입)" + "Workflow self-improvement milestone 동결 정책" + "Narrative 정전화 3단계 패턴" + 선례 2건 모두 v4.0 정체성 재정의로 폐지. 새 정체성 (§ 3.1 끝 paragraph) 이 자연 가드레일 — 자기참조 workflow self-improvement milestone 자체가 새 정체성에 부합 안 함. 본 § 6.2 cross-ref (v3.6 / v3.10 / v3.11 / v3.13 ~ v3.21 entry) 들은 v4.0 phase-2 안 `development/milestones/_archive/` 이전으로 자동 무력화. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md) + [`milestones/v4.0/DESIGN.md`](milestones/v4.0/DESIGN.md).

**spec-drift spike 패턴** (v5.7_spec-drift-spike-pattern-canonicalization, 2026-05-16 + **v6.13_spec-drift-spike-pattern-c-design-immediate-narrative + v6.14_audit-fact-verify-numeric-lookup-cycle-7-extension + v6.15_v6-4-v6-9-entry-title-active-form-redefinition 보강**, 2026-05-21): 외부 spec 안 정확 명시 부재 (context7 source narrative 표현 추정) 항목의 정정 cycle 4 단계 — (a) RESEARCH 단계 context7 source 추정 진행 (정확 spec 명시 부재 인식 + 추정 명시 의무) → (b) Stage D DESIGN 5 관점 spec-drift agent 검토 안 추정 risk 식별 → (c) 정정 시점 분기 = (c-1) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 (c-2) DESIGN 안 즉시 정정 → (d) DESIGN.decisions 또는 phase-{n}.md execution_notes 안 hardcode (정확 spec 값 string literal 명시, 동적 구성 회피). 자연 발현 origin 2건 — v4.2 = (a)→(b)→(c-2) DESIGN 즉시 정정→(d) (Stage F 전 cycle, context7 standard pattern 정정), v5.6 = (a)→(b)→(c-1) Stage F spike→(d) (Stage F 안 cycle, settings.json enabled key 검증). 정정 시점 차이 (c-1 vs c-2) 는 spec 명시 부재 정도에 따라 자연 분기. **v6.13 + v6.14 + v6.15 누적 evidence 보강**: 자연 발현 누적 cycle 12 (v4.2 / v5.6 / v6.2 / v6.3 / v6.4 / v6.5 / v6.6 / v6.8 / v6.9 / v6.13 / v6.14 / v6.15), 분기 분포 11:1 (c-2 vs c-1) — v4.2 + v6.2~v6.9 + v6.13 + v6.14 + v6.15 11건 자체 정전화 cycle 누적 (외부 spec 자체 부재 → c-2 DESIGN 즉시 정정 분기, v6.15 = Conventional Commits / Keep a Changelog 안 entry title style guide 부재 → § 7.2 본 repo 자체 컨벤션 자기 적용) + v5.6 1건 외부 spec 검증 단일 (settings.json enabled key binary 검증 → c-1 Stage F spike 분기). **분기 본질** = 외부 spec 명시 부재 정도 (자체 정전화 = spec 자체 부재 → c-2 / 외부 spec 검증 = binary 검증 필요 → c-1). 누적 분포 11:1 = 자체 정전화 cycle 우세 evidence — 본 repo 자체 컨벤션 mechanism 도입 시 외부 spec 검증 → 부재 시 자체 정전화 분기가 더 흔한 자연 발현 패턴 사실 진술. § 4 끝 row paragraph 안 individual cycle 명시 (row #8 = cycle 5 v6.4 / row #10 = cycle 7 v6.6 + cycle 9 v6.9 + cycle 11 v6.14) 보존. ecosystem integrator 정체성 (§ 3.1 끝 paragraph) 직접 부합 — context7 spec 정합 가드레일. 자세히: [`milestones/v4.2/DESIGN.md`](milestones/v4.2/DESIGN.md) (D2 origin) + [`milestones/v5.6/DESIGN.md`](milestones/v5.6/DESIGN.md) (D10 origin) + [`milestones/v5.7/DESIGN.md`](milestones/v5.7/DESIGN.md) (정전화) + [`milestones/v6.13/MILESTONE.md`](milestones/v6.13/MILESTONE.md) + [`milestones/v6.14/MILESTONE.md`](milestones/v6.14/MILESTONE.md) + [`milestones/v6.15/MILESTONE.md`](milestones/v6.15/MILESTONE.md) (보강).

## 7. AI Native 운영

### 7.1 정의

본 repo (harness-meta) 운영의 본질은 **AI Native 운영** — 본 repo 의 산출물 (ROADMAP / CHANGELOG / milestone 산출물 / cascade narrative) 이 AI (Claude / 다른 LLM agent) 에 의해 가장 자주 흡수되고 활용되며, AI 의 컨텍스트 효율 + 자율성 + 다중 AI 협업 친화도가 운영 품질의 1차 measure 다. § 3.1 끝 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer, v4.0 도입) 이 '본 repo 가 무엇을 만드는가' (책임 / 결과물) 라면, AI Native 운영은 '본 repo 가 어떻게 운영되는가' (원칙 / 운영 방식) — 두 차원 직교 보완.

**3 면 매트릭스**:

| 면 | 정의 | 현 baseline |
|---|---|---|
| **컨텍스트 효율** | AI 가 한 자료 (예: ROADMAP entry list) 를 흡수할 때 토큰 비용 + 본질 파악 신속 | entry title ≤ 60자 (§ 7.2 P2 정합), 한 entry = 한 본질 (§ 7.2 P1) — v6.0 정전화 |
| **자율성** | AI 가 사용자 명령 모호해도 의도 추출 + milestone 발의 + 진행 + 회고 가능. 사용자 명시 결정 게이트 보존 + AI 가 주도 결정 책임 흡수 | v6.x+ 후속 milestone candidate — 현 baseline = 사용자 명시 발의 의무. Auto-Mode 최소권한 mechanism = § 10 (v7.0 T1.5 정전화, `defaultMode` 활성 v7.1 보류) |
| **다중 AI 협업** | audit-team / external agent / context7 등 여러 AI 사이 컨텍스트 공유 + 책임 분리 명료 + fact 검증 자동 | audit chain 6 cycle 실 호출 (v5.10~v5.19) + Input Verification narrative 정전화 (v5.18) + lint precheck (v5.16) — 진행 중 |

본 매트릭스는 후속 milestone 발의 평가 기준 — 신규 milestone 이 3 면 중 어느 면을 향상시키는가 명시 (§ 3.6 5요소 매트릭스 평가 절차 와 cross-ref 보완).

**컨텍스트 효율 면 mechanism** (v7.1): (a) statusline 컨텍스트 게이지 `[ctx N%]` = statusline.sh 가 stdin `context_window.used_percentage` 표시 (70/90 임계 마커, 부재 시 생략) + (b) stage carry-over 블록 + `/clear` 권고 = stage 완료 결정적 trigger 에 디스크 미기록 in-flight 상태 carry. 두 반쪽은 '게이지 보고(WHEN) → 안전 리셋(HOW)' 한 loop. 1차 source = [`../../CLAUDE.md`](../CLAUDE.md) § 개발 프로세스 (carry-over narrative, always-loaded) — 본 § 7.1 은 pointer only (정의 중복 회피, cascade marker 부재 자연 = § 7.3 단방향 pointer 선례 동형).

### 7.2 Entry title 가이드 (4 원칙)

ROADMAP `milestones[]` entry / CHANGELOG bullet header / 기타 entry-form artifact 안 title 작성 시 다음 4 원칙 의무:

1. **한 entry = 한 본질** — bundling 시 (v3.0+ bundling era) 모자 본질만 title 안. 'A + B + C + D' 합치기 형식 금지. 나머지 본질은 summary 필드 안.
2. **≤ 60자 (한국어, 영문 약 120자)** — 한 화면 안 시각 흡수 + LLM context efficiency baseline. 60자 위 = 분류 정확도 감소 + grep keyword false-positive 증가.
3. **Active form + 짧은 동사구 시작** — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사. 명사구 시작 회피.
4. **Detail 은 summary 필드로 분리** — title 은 '무엇' / summary 는 '왜 + 어떻게 + 결과 + cross-ref'.

**smoke 자동 강제 정전화** (v6.3_entry-title-guideline-smoke-verification, 2026-05-20): 위 4 원칙 중 **(1) + (2) 자동 검증** = `tests/smoke-entry-title-guideline.sh` (pre-commit hook 8건째 등재). (1) ' + ' literal space + lookbehind/lookahead non-whitespace P1 mechanical proxy 검출 (코드 식별자 R1+R2 / C++ false-positive 회피). (2) Python `len(title)` codepoint > 60 검출 (한국어 시각 폭 ≈ 영문 120자 baseline). **(3) Active form + (4) Detail summary 분리 = AI 판단 위임** (자동 검증 제외 — 휴리스틱 false-positive 위험 + 의미 차원). enumerate scope = `projects/*/ROADMAP.md` 안 `milestones[]/next_candidates[]/candidate_draft[]` title 필드 + `CHANGELOG.md` bullet bold header (line-by-line + `[^*\n]{1,500}` length-bounded ReDoS 차단). SIZE_LIMIT 100KB 초과 = stderr 경고 + exit 1 FAIL (silent SKIP 폐기, 정책 우회 차단).

### 7.3 Stage 본질 (templated section 작성 task)

> ★ stage 본질 (v6.2+ 9-stage-flattened era 안): 9-stage workflow 안 각 stage 는 'MILESTONE.md 안 H2 section 1 칸 작성 task' 로 자연 수렴한다. mechanical 부분 (cascade host 동기 / candidate dedupe / smoke 검증 / hallucination 검출 등) 은 누적적으로 script + slash command + smoke 로 흡수되어 왔으며 (v6.4 cascade-sync / v6.5 propose-next / v6.6 audit-fact-verify 등), 잔존 manual = section narrative 작성 본질 (= LLM judgment).

**자연 수렴 본질 정전화** (v6.16_stage-templated-task-canonicalization-and-skill-pilot, 2026-05-21): v6.2 9-stage-flattened era 도입 (2026-05-19) 이후 stage 본질이 'MILESTONE.md H2 section 작성 task' 로 자연 수렴 — (a) v6.2 디렉토리 평탄화 = 1 milestone 디렉토리 안 6~8 파일 분산 → 1 본책 (MILESTONE.md) + 1 별책 디렉토리 (execute/) 통합 (§ 6.1 9-stage-flattened era paragraph 정합) + (b) v6.4~v6.9 mechanical 누적 자동화 cascade = cascade host 동기 (cascade_sync v6.4) / candidate dedupe (propose_next v6.5+v6.8) / hallucination 검출 (audit_fact_verify v6.6+v6.9) → mechanical 부분 잔존 0 → 남은 본질 = section narrative 작성 (= LLM judgment 본질). 사용자 자연어 표현 차이 origin (2026-05-21 대화 — "open 진입이 아니라 open 작성") = 본 자연 수렴 evidence (사용자 인식 안 stage = '작성' 본질 자연 표현). **skill = derived checklist 정합 본질** (v6.16 phase-2 시범 적용 + v6.18 7 stage 확장 cycle 2): 본 자연 수렴 본질 → stage skill (= templated checklist + schema template) 자연 도구 적합 — frontmatter description = trigger keyword (예: 'milestone OPEN stage 진입') + body 4 H2 (입력 / 작성할 것 / 검증 / 관련) = 본질 forcing function 보조. ARCHITECTURE 1차 source (본 § 7.3 paragraph) + skill = derived 단방향 cascade 본질 (cascade marker 부재 자연, v3.21 narrative 정전화 3 단계 패턴 단일 host 적용 = 본 § 7.3 본문 + § 4 매트릭스 row + § 4 본문 paragraph 3 host 양방). **skill scope = 9 stage 전체** (v6.16 시범 OPEN+PROPOSE 2 stage → v6.18 7 stage 확장 INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT 일괄 도입 = 9 skill 완전 cover, rm_5 일관성 mitigation 자연 도달). v6.17 도그푸드 cycle 1 PASS evidence (description auto-inject 직접 evidence + Layer 2 body 본질 한계 정전화 + skill body ↔ § 7.3 drift 부재) → v6.18 cycle 2 evidence stream (7 신규 skill 확장 자체 = scale-up cycle, 단순 반복 아님). 정의 + 사용법 1차 source = [`milestones/v6.16/MILESTONE.md`](milestones/v6.16/MILESTONE.md) D1~D10 (시범 도입) + [`milestones/v6.18/MILESTONE.md`](milestones/v6.18/MILESTONE.md) D1~D10 (7 stage 확장). v3.21 narrative 정전화 3 단계 패턴 cycle 37 (v6.16) + cycle 38 (v6.18) 자연 발현 + AI Native § 7.1 컨텍스트 효율 면 third cycle (v6.0 정의 → v6.2 디렉토리 평탄화 cycle 2 → v6.16+v6.18 stage 본질 정전화 cycle 3 enhancement).

## 8. 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../CLAUDE.md)
- 영문 요약: [`../../AGENTS.md`](../AGENTS.md)
- ADR: [`../../docs/adr/README.md`](../docs/adr/README.md)
- subdirectory CLAUDE.md (lazy): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone (메타): [`ROADMAP.md`](ROADMAP.md)

## 9. 3-way 책임 직교 (CLAUDE.md / .claude/rules/ / MEMORY) — v7.0 T1.1

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

## 10. Auto-Mode 최소권한 + subagent frontmatter pattern — v7.0 T1.5

Claude Code Auto-Mode (2026-w13+ 공식 spec, context7 verify 2026-05-25 `/websites/code_claude`) 환경 안 subagent 최소권한 mechanism 정의. v7.0 T1.5 정전화 (정정 #1·#2). mechanism source-of-truth = `../../.claude/settings.json` (repo-local — plugin manifest 에 `settings` 필드 부재 → 배포 안 됨, § 9 `.claude/rules/` 와 일관).

### 10.1 Auto-Mode 4 분류

| 분류 | 본질 | 거주 |
|---|---|---|
| `autoMode.environment[]` | trusted source / path 명시 (LLM classifier 정합도 향상) | `.claude/settings.json` |
| `autoMode.allow[]` | 명시 허용 (prompt 부재) | 〃 |
| `autoMode.soft_deny[]` | 명시 금지 — prompt 발생 (사용자 명시 결정 게이트) | 〃 |
| `autoMode.hard_deny[]` | 절대 금지 — prompt 부재 + 자동 reject | 〃 |
| `$defaults` | built-in rule inherit (omit 시 모든 보안 default 제거 위험) | 각 array 안 첫 항목 |

`permissions.defaultMode: "auto"` = Auto-Mode 활성 스위치. **v7.0 = mechanism 설치만, `defaultMode` 미포함 (활성 보류)** — 정정 #7 'v7.0 설치 / 첫 사용 v7.1 격리' + 사용자 '커밋·배포 전 확인' 협업 본질 정합. v7.1 활성 결정 시 `permissions.defaultMode: "auto"` 추가.

### 10.2 subagent frontmatter pattern (3 subagent 정합)

| 본질 | design-review (T1.3, 생성) | Explore (built-in) | version-tracker (T1.6) |
|---|---|---|---|
| frontmatter `tools:` | Read, Grep, Glob (read-only) | (built-in, frontmatter 부재) | context7 2 + Read + Edit (minimal write) |
| `model:` | opus | (built-in default) | opus |
| Auto-Mode allow | inherit (read-only 자연) | inherit (read-only 자연) | 명시 (단일 file write, T1.6b) |
| settings.json 추가 | 부재 | environment 안 명시 | allow + soft_deny 명시 (T1.6b) |

본 § = mechanism source-of-truth 단일 책임. 실 적용 = T1.3 ([`design-review` **생성 완료**](../agents/design-review.md), read-only tools — v7.0 Tier 2) / T2.3 (Explore **활용 pattern** 정전화, environment — § 11) / T1.6b (version-tracker **권한 정전화**, allow + soft_deny) 안 각자 inherit — T1.5 이후 진입.

### 10.3 AI Native § 7.1 자율성 면 cross-ref

§ 7.1 자율성 면 = Auto-Mode 정합 본질 (사용자 명시 결정 게이트 = `soft_deny` prompt 보존 + `hard_deny` 안전망). 단 v7.0 = mechanism 정의, 활성 v7.1 보류 (자율성 baseline 변경 없음).

## 11. 분야 발현 mechanism — RESEARCH cb / DESIGN review (작업 본질 type 매트릭스) — v7.0 T2.3 + T1.3

RESEARCH 조사 분야 (T2.3) 와 DESIGN review 검토 분야 (T1.3) 는 **고정 매트릭스가 아니라 작업 본질 + scope 크기에 따라 자연 발현** 한다. 두 stage 가 같은 발현 pattern 을 공유하므로 본 § 이 단일 source — `claude/commands/harness-meta.md` 의 Stage C / Stage D narrative 는 본 § 을 pointer 한다. v7.0 정전화 (정정 #5·#6, 2026-05-25). **v7.0 = 설치만, 첫 실사용 v7.1**.

### 11.1 공유 발현 pattern (T1.3 ↔ T2.3)

| 본질 | T2.3 (RESEARCH cb mapping) | T1.3 (DESIGN review) |
|---|---|---|
| 진입 시점 | INTENT.md 작성 완료 직후 (Stage B 종료) | DESIGN.md 작성 완료 직후 (Stage D 종료 직전) |
| Claude 메인 자동 분석 source | INTENT.goal + INTENT.dependencies | INTENT.success_criteria + DESIGN.phases |
| 자동 발현 본질 | codebase 분야 (agent fleet / smoke fleet / cascade narrative 등) | 검증 관점 (spec-drift / token-efficiency / scope contract 등) |
| 사용자 게이트 | AskUserQuestion ("이 N 분야로 충분?") | AskUserQuestion ("이 N 관점으로 충분?") |
| 사용자 명시 후 invoke | `Explore` parallel (분야별 1:1, N 호출 동시) | `design-review` subagent (perspectives parameterized, 1 invoke 안 N 분야 순차 통합 — subagent 중첩 불가) |
| 결과 흡수 | RESEARCH.md `codebase.{분야명}` | DESIGN.md (scope 안) + MILESTONE.md `## SCOPE_OUT_NOTES` (scope 외) |
| 본질 | **조사** (investigation, 진입 전 매핑) | **검증** (verification, 산출 후 정합 확인) |

공통 4-step = (1) Claude 메인 자동 분야 발현 → (2) 분야 매트릭스 제안 → (3) AskUserQuestion 게이트 → (4) 사용자 명시 후 subagent invoke. mechanism 통일성 = 학습 부하 최소.

### 11.2 scope 크기 매트릭스 (count 가변)

| scope | T2.3 cb 분야 | T1.3 검토 관점 |
|---|:-:|:-:|
| 작음 (≤5 파일) | 2~3 | 3~5 |
| 중간 (6~15) | 3~5 | 5~7 |
| 큼 (16+) | 5~8 | 7~10 |

고정 count 강제 부재 — 분야 매트릭스는 open-ended (신규 분야 자연 발현 가능).

### 11.3 작업 본질 type 매트릭스 (분야 자동 발현 source)

작업 본질 type 자체는 Claude 메인 LLM 자율 분류 (INTENT.goal 자연 매핑). 아래는 발현 분야 예시 — row 추가 = v7.x 안 자연 발현 (lessons 흡수).

| 작업 본질 type | 자연 발현 분야 (cb 조사 / review 검증 공통 예시) |
|---|---|
| schema change (smoke 강제 필드 변경) | spec verification logic + 기존 milestone schema 정합 |
| agent fleet 변경 (신규 / 정정) | agent fleet + plugin.json paths + audit-orchestrator allowlist |
| skill 추가/정정 | skills directory + plugin.json skills paths + frontmatter description trigger |
| hook 추가/정정 | hooks directory + hooks.json matcher + PostToolUse 본질 |
| cascade narrative 변경 (ARCHITECTURE / CLAUDE.md) | cascade marker 거주 + cascade_sync logic + cross-ref 매트릭스 |
| workflow stage 변경 | stage skills + commands/harness-meta.md narrative + 기존 milestone 적용 |
| `.claude/rules/` 추가 (§ 9 정합) | rules directory + paths frontmatter scope + CLAUDE.md entry pointer |
| settings.json 변경 (§ 10 정합) | settings.json + plugin.json paths + Auto-Mode 4 분류 |

### 11.4 scope 외 거명 — `## SCOPE_OUT_NOTES` (부산물 cycle 차단)

T1.3 review 안 scope 외 거명은 MILESTONE.md `## SCOPE_OUT_NOTES` (조건부 H2 — 거명 있을 때만 생성, SUB_MILESTONES 선례 정합) 에 거주만. **next_candidates 자동 append 부재** — PROPOSE stage 안 사용자 명시 결정 게이트 후만 등재. 기존 cycle (review 거명 → lessons 자동 enumerate → next_candidates 자동 append → 부산물 재생산) 을 자연 종료시킨다 (T1.2 lessons 자동 enumerate 폐지와 정합, Tier 3 진입 시 정전화).

### 11.5 cross-ref

- Stage C / Stage D 진입 narrative: [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md)
- design-review subagent: [`../../agents/design-review.md`](../agents/design-review.md)
- frontmatter pattern + Auto-Mode 정합: § 10.2
- MILESTONE.md skeleton (조건부 SCOPE_OUT_NOTES): § 6.1 + `skills/stage-open/SKILL.md`

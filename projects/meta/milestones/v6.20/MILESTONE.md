---
id: agent-type-syntax-adoption
title: Agent(agent_type) syntax 흡수
version: v6.20
status: in_progress
---

# v6.20 — Agent(agent_type) syntax 흡수

## INTENT

### Spec

```json
{
  "id": "agent-type-syntax-adoption",
  "title": "Agent(agent_type) syntax 흡수",
  "goal": "agents/audit-orchestrator.md 신설 + frontmatter `tools: Agent(component-installer), Read, Bash, Edit, Grep, Glob` 명시 → audit-team 5 멤버 중 component-installer 만 spawn 허용 = write 권한 단독 본질 syntax-level 강제. v2.1.33+ Claude Code Agent(agent_type) syntax 흡수 본질 (외부 spec → 본 repo 적용).",
  "motivation": "post-v6.19 audit session (2026-05-21, commit 192f374) 안 본 repo 자산 전수 audit + Claude/GitHub 표준 대체 검토 결과 발견된 4 자산 흡수 매트릭스 안 'full' 흡수 강도 유일 1건 origin (next_candidates#18). 현 audit-team 5 멤버 (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) 중 component-installer 1건만 write 권한 보유 = 본질이나 syntax-level 강제 부재 (메인 Claude orchestrator 의 judgment 의존). v2.1.33+ Agent(agent_type) syntax = frontmatter `tools` 안 Agent(specific-agent) 명시 가능 신규 syntax. pre-PLAN 2 round 결정 (2026-05-21) trace = R1 orchestrator 정체 = 별도 agents/audit-orchestrator.md 신설 (full 적용, 옵션 1 = '새 자물쇠 도입' 비유) / R2 title 본질 = 흡수 (외부 spec → 본 repo 적용 origin, candidate description 첫 줄 '4 자산 흡수 매트릭스' 자연 정합). 메인 Claude 면 frontmatter 적용 불가 → orchestrator 정체 자체를 별도 agent 로 분리 + audit-team CLAUDE.md narrative 흡수 + /harness-meta --audit 호출 흐름 변경 = scope 자연 확장.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "agents/audit-orchestrator.md 신규 파일 존재 + frontmatter `tools:` 필드 안 `Agent(component-installer)` literal 포함. 추가 도구 (Read/Bash/Edit/Grep/Glob 등) 명시 항목 범위는 DESIGN 단계 결정."
    },
    {
      "id": "sc_2",
      "criterion": "audit-team CLAUDE.md narrative 안 orchestrator 정체 표기 변경 ('orchestrator = 메인 Claude' → 'orchestrator = audit-orchestrator agent') + 5 멤버 호출 흐름 narrative 흡수 scope DESIGN 단계 결정 후 정합."
    },
    {
      "id": "sc_3",
      "criterion": "claude/commands/harness-meta.md (--audit slash command) 안 호출 흐름 narrative 변경 — slash command 호출 후 메인 Claude 가 audit-orchestrator agent invoke 또는 slash command 자체가 직접 invoke (흐름 변경 깊이는 DESIGN 단계 결정)."
    },
    {
      "id": "sc_4",
      "criterion": "pre-commit hook 12+ smoke 전체 PASS (회귀 부재). 신규 agents/audit-orchestrator.md 안 frontmatter schema + path 정합 smoke 미존재 → 신규 smoke 도입 여부 DESIGN 단계 결정."
    },
    {
      "id": "sc_5",
      "criterion": "v2.1.33+ Claude Code Agent(agent_type) syntax 정합 verify — context7 query (sub-agent + plugin agent frontmatter tools 안 Agent(name) literal spec) 안 직접 evidence 확보. spec drift 발견 시 v5.7 spike 패턴 (RESEARCH 추정 → DESIGN 식별 → Stage F spike or DESIGN 즉시 정정) 적용."
    },
    {
      "id": "sc_6",
      "criterion": "cascade host drift 부재 — audit-team CLAUDE.md + claude/commands/harness-meta.md + ARCHITECTURE.md (orchestrator 정체 언급 안 있는 경우) drift 부재. v3.21 narrative 정전화 3 단계 패턴 적용 대상 자연 검토 후 결정."
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "audit-team 5 멤버 자체 frontmatter tools 강화 (멤버끼리 상호 spawn 차단 syntax) — 옵션 2 본질 ('audit-team 5 멤버 frontmatter tools 명시' scope 축소 안). 본 milestone scope 외 — 별 candidate 자연 (origin = 본 milestone R1 결정 안 옵션 2 선택지)."
    },
    {
      "id": "oos_2",
      "item": "다른 agent 영역 (project-harness-audit-team 외) frontmatter tools 정비 — 본 repo 안 agents/ 디렉토리 안 다른 standalone subagent (environment-auditor / agents-md-sync 등) frontmatter tools Agent(...) syntax 흡수. evidence 누적 시 별 candidate 자연 발의."
    },
    {
      "id": "oos_3",
      "item": "orchestrator agent 안 추가 책임 흡수 (Step 6 synthesizer logic 흡수 / Step 4↔5 dialogue hook 흡수 등) — 본 milestone scope = orchestrator 정체 분리 + Agent syntax 명시 1건. 추가 책임 흡수는 DESIGN 단계 잔존 시 별 candidate."
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "v2.1.33+ Claude Code Agent(agent_type) syntax spec (context7 query)",
      "purpose": "RESEARCH 단계 안 spec 정합 검증 1차 source. frontmatter tools 안 Agent(specific-agent) literal 명시 spec + 적용 scope (sub-agent / plugin agent / main agent 영역 차이) 확인 필수."
    },
    {
      "id": "dep_2",
      "ref": "agents/project-harness-audit-team/CLAUDE.md (audit-team narrative)",
      "purpose": "orchestrator 정체 표기 흡수 대상 + 5 멤버 호출 흐름 narrative 흡수 scope source. DESIGN 단계 안 흡수 깊이 결정 후 EXECUTE 단계 안 cascade Edit."
    },
    {
      "id": "dep_3",
      "ref": "claude/commands/harness-meta.md (--audit slash command narrative)",
      "purpose": "/harness-meta --audit 호출 흐름 변경 source. slash command 안 audit-orchestrator agent invoke 흐름 narrative 추가 또는 변경 source."
    },
    {
      "id": "dep_4",
      "ref": "post-v6.19 audit session (commit 192f374, 2026-05-21)",
      "purpose": "본 milestone origin = '4 자산 흡수 매트릭스 안 full 유일 1건' 발견 cycle. ROADMAP next_candidates#18 등재 trace 본 commit 안."
    }
  ]
}
```

### Narrative

post-v6.19 audit session (2026-05-21) 안 본 repo 자산 전수 audit + Claude/GitHub 표준 대체 검토 결과 발견된 4 자산 흡수 매트릭스 (agent-type-syntax / task-completed-hook PoC / bundled-skill cross-audit / agents-md-sync reassessment) 안 'full' 흡수 강도 유일 1건 origin. 현 audit-team 5 멤버 중 component-installer 1건만 write 권한 보유 = 본질이나 syntax-level 강제 부재 (메인 Claude orchestrator judgment 의존). v2.1.33+ Claude Code Agent(agent_type) syntax 흡수 본질 = frontmatter `tools: Agent(component-installer), Read, Bash, Edit, Grep, Glob` 명시 → audit-team 5 멤버 중 component-installer 만 spawn 허용 = write 권한 단독 본질 syntax-level 강제 효과.

pre-PLAN 2 round 결정 (2026-05-21) — R1 orchestrator 정체 = 별도 `agents/audit-orchestrator.md` 신설 (full 적용, 옵션 1 '새 자물쇠 도입' 비유) / R2 title 본질 = 흡수 (외부 spec → 본 repo 적용 origin, candidate description 첫 줄 '4 자산 흡수 매트릭스' 자연 정합). 메인 Claude 면 frontmatter 적용 불가 evidence → orchestrator 정체 자체를 별도 agent 로 분리 = audit-team CLAUDE.md narrative 흡수 + `/harness-meta --audit` 호출 흐름 변경 = scope 자연 확장.

성공 본질 6건 = (a) `agents/audit-orchestrator.md` 신설 + frontmatter tools 명시 (sc_1) + (b) audit-team CLAUDE.md narrative 흡수 (sc_2) + (c) `/harness-meta --audit` 흐름 변경 (sc_3) + (d) smoke 회귀 부재 (sc_4) + (e) v2.1.33+ syntax spec 정합 verify (sc_5) + (f) cascade host drift 부재 (sc_6). DESIGN 단계 안 결정 사항 = frontmatter tools 명시 항목 범위 + audit-team narrative 흡수 scope + slash command 흐름 변경 깊이 + 신규 smoke 도입 여부 + cascade host 매트릭스 (v3.21 narrative 정전화 3 단계 패턴 적용 대상 자연 검토).

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "context7 /websites/code_claude — https://code.claude.com/docs/en/sub-agents § 'Restrict spawned subagent types'",
      "finding": "frontmatter `tools` 필드 안 `Agent(agent_type)` syntax = allowlist pattern. 예시 직접 인용 = `tools: Agent(worker, researcher), Read, Bash`. comma separated 다중 agent type 가능. `name` + `description` + `tools` 3 필드 동시 명시 가능."
    },
    {
      "id": "ext_2",
      "source": "context7 /websites/code_claude — https://code.claude.com/docs/en/sub-agents § 'Control subagent capabilities > Restrict which subagents can be spawned'",
      "finding": "직접 인용 = 'To restrict which subagents can be spawned by the main agent using the Agent tool, use the Agent(agent_type) syntax within the tools field. This acts as an allowlist, specifying only the permitted subagent types. If Agent is omitted entirely from the tools list, the agent cannot spawn any subagents. This restriction does not apply to subagents spawning other subagents.' → 3 state 분기 = (a) tools 안 `Agent` 부재 = spawn 불가, (b) `Agent(x, y)` 명시 = allowlist x/y, (c) main 안 restriction 의 transitive 적용 = 부재 (sub-agent 가 또 다른 sub-agent spawn 시 main restriction 우회 가능)."
    },
    {
      "id": "ext_3",
      "source": "context7 /websites/code_claude — https://code.claude.com/docs/en/agent-sdk/subagents § 'Define Subagents Programmatically'",
      "finding": "SDK 안 동치 pattern = `allowed_tools=['Read', 'Grep', 'Glob', 'Agent']` (Agent literal tool name) + `agents` parameter 안 `AgentDefinition(description=..., prompt=..., tools=[...])`. frontmatter parens syntax (`Agent(name, name2)`) 는 file-based subagent (`agents/*.md`) 또는 plugin 안 적용 전용 — SDK programmatic 안 동치 형식은 `agents` parameter 안 allowlist 직접 명시 본질."
    },
    {
      "id": "ext_4",
      "source": "context7 /websites/code_claude — https://code.claude.com/docs/en/claude-directory § 'agents/ > agent-reviewer'",
      "finding": "agents/*.md 안 `tools:` frontmatter = tool access restriction allowlist. 직접 인용 = 'Subagents can have their tool access restricted using the tools: frontmatter field. For example, a code-reviewer subagent might be limited to read-only tools like Read, Grep, and Glob.' + `description:` 필드 = Claude 가 자동 delegate task 시 매칭 source. orchestrator agent description = 본 의도 본질 매칭 narrative 의무 (v6.20 sc_5 정합)."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "agents/{agents-md-sync,claude-docs-mapper,component-installer,component-proposer,environment-auditor,harness-gap-analyzer,project-scanner}.md frontmatter `tools:` 필드 (7건 head -10)",
      "finding": "현 agents/*.md 7건 모두 frontmatter `tools:` 안 Agent literal 0건 (Grep `Agent\\(` 안 0 match). 본 v6.20 안 audit-orchestrator.md 신설 시 본 repo 안 첫 Agent(agent_type) 사용 사례 자연. 7 멤버 tools = (1) agents-md-sync: Read+Bash+Edit / (2) claude-docs-mapper: mcp__plugin_context7_context7__{resolve-library-id,query-docs}+WebFetch / (3) component-installer: Bash+Edit+Read (write 권한 유일) / (4) component-proposer: Write / (5) environment-auditor: Bash+Read+Glob+Grep / (6) harness-gap-analyzer: Read+Grep+Bash / (7) project-scanner: Read+Glob+Grep. write 권한 단독 본질 = component-installer 만 자연 보유 (다른 4 audit-team 멤버 + 2 standalone 멤버 tools 안 write 부재) → INTENT motivation '본질이나 syntax-level 강제 부재' 는 main Claude 의 audit-team 멤버 호출 자유도 위에서만 성립 (frontmatter level 본질은 이미 정합)."
    },
    {
      "id": "cb_2",
      "ref": "agents/project-harness-audit-team/CLAUDE.md L25 + L54 + L68-82 + L84 + L88 + L92 + L96 + L98-100",
      "finding": "orchestrator 정체 narrative 1차 source = audit-team CLAUDE.md. L25 'D8 sequence — 순차 호출 — 각 단계 결과가 다음 단계 입력. 메인 Claude (orchestrator) 가 단계별 결과 다음 멤버 prompt 입력.' / L54 'USER DECISION GATE (e3 정책) ← 메인 Claude 가 사용자 명시 결정 대기' / L68 'Step 6 (v6.6 신규) — synthesizer fact verify (orchestrator script invoke, subagent 부재)' / L73 'Invoke: 메인 Claude orchestrator (subagent 부재, deterministic)' / L84 v5.13 Note 'synthesizer (메인 Claude orchestrator)' / L88 v5.16 Note 'synthesizer (메인 Claude orchestrator)' / L92 v5.18 Note 'Step 1~4 산출 4 멤버... 메인 Claude orchestrator' / L96+L100 v6.6/v6.14 Note. 거명 6+ 위치 = cascade host #1 (1차 source) + 영향 host 확장 source."
    },
    {
      "id": "cb_3",
      "ref": "claude/commands/harness-meta.md L74-85 `--audit` 분기 + L350 관련 문서",
      "finding": "현 --audit flow narrative = '메인 Claude' 가 `Agent(subagent_type=\"harness-meta:project-scanner|harness-gap-analyzer|claude-docs-mapper|component-proposer|component-installer\")` 5 멤버 순차 호출 + L80 synthesizer fact 검증 + L81 markdown lint precheck + L82 audit_fact_verify Step 6 자동 호출 + L83-84 사용자 결정 게이트 + component-installer spawn (accept 시만). 본 narrative 안 'Agent(subagent_type=...)' 5 위치 = Task tool literal call signature (v2.1.33+ SDK 호환). orchestrator agent 신설 시 본 flow 안 (a) slash command → audit-orchestrator agent 단일 invoke / (b) audit-orchestrator agent 안 5 멤버 spawn / (c) 사용자 결정 게이트 위치 (orchestrator 안 / slash command 안) 흐름 변경 깊이 결정 source (sc_3)."
    },
    {
      "id": "cb_4",
      "ref": "projects/meta/ARCHITECTURE.md § 4 끝 paragraph #5 (Audit chain fact 인용 검증 의무) + #10 (audit chain hallucination 자동 검출 mechanism) + #11 (fixture-based smoke) + #12 (stage 본질 templated section)",
      "finding": "ARCHITECTURE.md 안 orchestrator 거명 5건 (L163/L165/L169/L171/L173) = 'synthesizer (메인 Claude orchestrator)' / 'narrative orchestrator' 등 cascade host #2~#5. v3.21 narrative 정전화 3 단계 패턴 적용 host 갯수 ≥4 도달 (cb_2 audit-team CLAUDE.md = 1차 source + cb_3 harness-meta.md = #2 + ARCHITECTURE § 4 # 5/#10/#11/#12 paragraph = #3~#6 + 잠재 root CLAUDE.md = #7). 적용 대상 자연 — cascade host 갯수 ≥2 trigger 충족 (v6.10 PROPOSE next_candidates `v321-pattern-application-judgment-criterion-narrative` 후보 정합)."
    },
    {
      "id": "cb_5",
      "ref": "agents/component-installer.md frontmatter `tools: Bash, Edit, Read` + `model: opus`",
      "finding": "component-installer 유일 write 권한 멤버 (Bash + Edit + Read). 다른 4 audit-team 멤버 tools 안 Write/Edit/Bash(write) 부재 (project-scanner = Read+Glob+Grep / harness-gap-analyzer = Read+Grep+Bash[read-only] / claude-docs-mapper = MCP+WebFetch / component-proposer = Write[draft만]). 단 component-proposer Write 보유 = 'proposal draft 만' narrative (CLAUDE.md L18 명시) — installer 와 본질 분리 (draft markdown 작성 vs mechanical apply). v6.20 의 'write 권한 단독 본질' narrative 정밀 = 'mechanical apply 권한 단독 = component-installer' 본질."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "orchestrator tools = `Agent(component-installer), Read, Bash, Edit, Grep, Glob` (INTENT narrative 그대로)",
      "rationale": "INTENT motivation + sc_1 narrative ('component-installer 만 spawn 허용') 직접 정합. 단 결과 = audit-team 4 read-only 멤버 (scanner/analyzer/mapper/proposer) orchestrator agent 안에서 spawn 불가능 → 4 멤버 책임은 (a) 메인 Claude 가 audit-orchestrator agent invoke 전 직접 수행 후 결과 첨부 또는 (b) orchestrator agent scope 협소 = Step 5 단독 (사용자 결정 게이트 후 component-installer spawn 만) — D8 sequence 본질 변경 자연. INTENT narrative 자연 해석 = (b) 협소 scope."
    },
    {
      "id": "opt_2",
      "label": "orchestrator tools = `Agent(project-scanner, harness-gap-analyzer, claude-docs-mapper, component-proposer, component-installer), Read, Bash, Edit, Grep, Glob` (5 멤버 모두 allowlist)",
      "rationale": "5 멤버 모두 명시 = audit-team sequence 본질 (Step 1~5) 보존 + audit-team 외 agent (agents-md-sync / environment-auditor 등) spawn 차단 자연. 단 INTENT narrative ('component-installer 만 spawn 허용') 직접 모순 → INTENT 정정 candidate (motivation + sc_1 narrative 자연 해석 = 'audit-team 5 멤버 만 spawn 허용 = audit-team 외 차단'). write 권한 단독 본질은 cb_5 안 component-installer 자체 frontmatter tools 안 이미 정합 (다른 4 멤버 tools 안 write 부재) → orchestrator allowlist scope 는 audit-team 경계 정합 본질로 자연 재해석. INTENT 정정 본질 = scope 재해석 (component-installer 만 spawn → audit-team 5 멤버 만 spawn)."
    },
    {
      "id": "opt_3",
      "label": "opt_1 + orchestrator scope 명시 = Step 5 단독 책임 (사용자 결정 게이트 후 component-installer spawn)",
      "rationale": "opt_1 의 협소 scope 해석 명시. orchestrator agent = Step 5 단독 책임 (사용자 결정 게이트 통과 → component-installer spawn). Step 1~4 (audit-team 4 read-only 멤버) 는 메인 Claude 직접 호출 보존 (현 cb_3 flow 유지). 단 orchestrator scope 협소 = 'orchestrator' 명명 본질 과대 (Step 5 단독 책임 = 'installer-gate' 명명 자연). audit-team CLAUDE.md narrative 흡수 scope 최소 — '메인 Claude (orchestrator)' 거명 중 Step 5 부분만 'audit-orchestrator agent' 정정 + Step 1~4 narrative 보존."
    },
    {
      "id": "opt_4",
      "label": "orchestrator tools = `Agent, Read, Bash, ...` (parens 없이 Agent literal — spec 모호)",
      "rationale": "context7 spec 안 직접 evidence 부재 (ext_1/ext_2 안 `Agent(...)` 형식만 명시 + ext_3 SDK `allowed_tools=[..., 'Agent']` 안 literal Agent). frontmatter 안 `Agent` (parens 없이) 의 의미 = (a) 모든 subagent 자유 spawn (allowlist 부재 = 자유 default) 또는 (b) parse error 가능성. v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 후보. 본 v6.20 안 채택 시 syntax-level 강제 효과 0 → INTENT motivation 부합 부재. 폐기 자연."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "cascade drift host 갯수 ≥4 (audit-team CLAUDE.md L25/L54/L68/L84/L88/L92/L96 + harness-meta.md L76-85 + ARCHITECTURE.md § 4 #5/#10/#11/#12 + 잠재 root CLAUDE.md). orchestrator 정체 변경 시 본 host 들 narrative cascade drift 발생 위험. mitigation 부재 시 v5.10 L172 cascade drift 재발 패턴 정합.",
      "mitigation": "v3.21 narrative 정전화 3 단계 패턴 적용 자연 (host ≥2 trigger 충족, v6.10 next_candidates `v321-pattern-application-judgment-criterion-narrative` 정합) — (a) DESIGN 1차 source 식별 (audit-team CLAUDE.md L25 D8 sequence narrative = 정전 1차 source) + (b) EXECUTE Edit cascade (harness-meta.md + ARCHITECTURE.md + 잠재 root CLAUDE.md) + (c) VERIFY grep (`grep -rn '메인 Claude.*orchestrator\\|메인 Claude orchestrator'` 안 0 match 또는 정합 narrative 만 잔존). v6.4 cascade-sync mechanism marker 적용 candidate 자연 (DESIGN 단계 cascade host 매트릭스 확정 후)."
    },
    {
      "id": "risk_2",
      "description": "opt_1 / opt_3 채택 시 audit-team D8 sequence 본질 변경 (4 read-only 멤버 spawn 책임 분리) — Step 1~4 메인 Claude 직접 호출 vs orchestrator agent 안 inline 책임 분기. orchestrator scope 협소 (Step 5 단독) 시 'orchestrator' 명명 본질 과대 risk.",
      "mitigation": "DESIGN 단계 결정 분기 — (a) opt_2 채택 시 audit-team 5 멤버 sequence 본질 보존 + INTENT motivation 'component-installer 만 spawn' → 'audit-team 5 멤버 만 spawn' 자연 재해석 (motivation 정정 narrative 추가) + (b) opt_1/opt_3 채택 시 audit-team CLAUDE.md D8 narrative 안 'Step 1~4 메인 Claude / Step 5 audit-orchestrator agent' 분기 명시 + orchestrator 명명 재고 ('installer-gate-agent' 자연). 결정 source = INTENT motivation 의도 vs sequence 본질 보존 trade-off."
    },
    {
      "id": "risk_3",
      "description": "ext_2 spec '본 restriction 의 transitive 적용 부재 (sub-agent 가 또 다른 sub-agent spawn 시 main restriction 우회 가능)' narrative 의 본 milestone 안 작용 명료화 부재 risk. 본 의도 본질 = 'audit-orchestrator agent (sub-agent) 가 component-installer (sub-agent) spawn' 시 main Claude 의 tools restriction 무력 (= main tools 안 Agent(audit-orchestrator) 만 명시해도 component-installer spawn 가능 의미). 단 audit-orchestrator agent 자체의 frontmatter tools 는 자기 spawn allowlist 정확 매핑 (transitive 비적용 본질은 grandparent → grandchild 안에만 적용).",
      "mitigation": "DESIGN d_X 안 spec 정합 narrative 명시 — (a) audit-orchestrator agent 의 frontmatter tools 는 self-spawn allowlist 본질 매핑 (ext_2 'sub-agent X 의 tools 안 Agent(Y)' = X 안에서 Y spawn 가능 / Agent 부재 = X spawn 불가) + (b) ext_2 'transitive 비적용' narrative 는 main → A → B 안 A 가 B spawn 시 main restriction 비적용 의미 — 본 v6.20 본질 = audit-orchestrator agent 자체의 frontmatter tools 안 allowlist 강제 정확. v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 후보 (외부 spec 직접 인용 → 직접 정전화)."
    },
    {
      "id": "risk_4",
      "description": "orchestrator agent description 정합 본질 (ext_4 'description = Claude 자동 delegate 매칭 source'). 본 의도 본질 매칭 narrative 부재 시 main Claude 가 audit-orchestrator agent 자동 delegate 안 함 → INTENT motivation 효과 0 risk.",
      "mitigation": "DESIGN d_X 안 description narrative scope 결정 — (a) trigger keyword narrow (예: 'audit chain orchestration during /harness-meta --audit invocation') + (b) Claude 자동 delegate matching narrative (예: 'Use this agent when --audit flag is present + audit chain Step 1~5 execution') + (c) e3 정책 정합 narrative (사용자 결정 게이트 강제). v6.16 stage skill description 정합 패턴 (trigger keyword narrow) 자연 정합."
    },
    {
      "id": "risk_5",
      "description": "smoke 회귀 risk — 신규 agents/audit-orchestrator.md frontmatter schema (name + description + tools + model 4 필드 + Agent(...) syntax 정합) 검증 smoke 부재. 현 smoke 안 'agents/*.md frontmatter schema' 검증 항목 0 → 본 milestone 안 frontmatter 오류 (예: tools 안 잘못된 Agent literal 형식 + parens 누락 + 잘못된 agent name 참조) 회귀 차단 부재.",
      "mitigation": "sc_4 결정 분기 — (a) 신규 smoke `tests/smoke-agent-frontmatter-schema.sh` 도입 (Agent(...) literal 정합 + tools 필드 schema 검증 + 참조 agent 존재 검증) + (b) 기존 smoke 안 확장 (smoke-spec-verification 등) + (c) 본 milestone scope 외 (별 candidate). evidence-base 원칙 (v3.6 lightweight 모드 정합) — cycle 1 evidence (본 milestone) 도달 후 추가 cycle 누적 시 발의 자연 (또는 sc_4 자체가 trigger 충족 = (a) 본 milestone EXECUTE phase 안 통합)."
    },
    {
      "id": "risk_6",
      "description": "audit-orchestrator agent 신설 후 Step 6 synthesizer 책임 (`python scripts/audit_fact_verify.py --dir <audit-output>` 자동 호출 + markdown lint precheck + fact 인용 검증) 의 책임 분기 모호 risk. 현 cb_2 안 'synthesizer (메인 Claude orchestrator)' 명시 — audit-orchestrator agent 안 흡수 시 (a) orchestrator agent 안 inline 책임 (script 호출 + lint precheck) 또는 (b) 메인 Claude 잔존 (orchestrator scope 외) 분기.",
      "mitigation": "DESIGN d_X 안 결정 분기 — (a) opt_2 채택 시 orchestrator agent scope = Step 1~6 통합 (Step 6 synthesizer 흡수 자연) + (b) opt_1/opt_3 채택 시 orchestrator scope = Step 5 단독 → Step 6 synthesizer 메인 Claude 잔존 (현 책임 보존). 본 milestone INTENT oos_3 안 'orchestrator agent 안 추가 책임 흡수 (Step 6 synthesizer logic 흡수 등) — DESIGN 단계 잔존 시 별 candidate' 정합 — opt 결정 후 자연 분기."
    }
  ]
}
```

### Narrative

v6.20 의 'Agent(agent_type) syntax 흡수' 본질의 핵심 finding 4 (external) + 5 (codebase) + 4 (options) + 6 (risks) 정전화. context7 query 안 직접 spec evidence 확보 — frontmatter `tools` 필드 안 `Agent(worker, researcher), Read, Bash` 형식 = allowlist pattern (ext_1) + 3 state 분기 본질 명시 (ext_2: Agent 부재 / Agent(...) 명시 / transitive 비적용) + SDK 안 동치 pattern 차이 (ext_3) + description 자동 delegate 매칭 본질 (ext_4). codebase 안 'Agent(agent_type)' literal 0 match 확인 (cb_1) → 본 milestone 안 audit-orchestrator.md 신설 시 본 repo 안 첫 사례 자연. 'orchestrator = 메인 Claude' narrative cascade host ≥4 도달 — audit-team CLAUDE.md 6+ 위치 (cb_2) + harness-meta.md `--audit` 분기 (cb_3) + ARCHITECTURE.md § 4 paragraph 5 거명 (cb_4) → v3.21 narrative 정전화 3 단계 패턴 적용 자연 (host ≥2 trigger 충족, v6.10 next_candidates `v321-pattern-application-judgment-criterion-narrative` 정합).

Options 4 분기 — opt_1 (INTENT narrative 그대로, component-installer 만 allowlist) + opt_2 (5 멤버 모두 allowlist, INTENT 정정 candidate) + opt_3 (opt_1 + orchestrator scope 협소 = Step 5 단독) + opt_4 (parens 없는 Agent literal, spec 모호 + 효과 0 폐기). 본 RESEARCH 안 raw 제시 — 채택/폐기는 DESIGN 단일 책임. opt_2 의 자연성 = (a) audit-team D8 sequence 본질 보존 + (b) write 권한 단독 본질은 cb_5 안 component-installer 자체 frontmatter level 이미 정합 + (c) audit-team 외 agent (agents-md-sync / environment-auditor) spawn 차단 자연 scope. opt_1/opt_3 의 자연성 = INTENT narrative 직접 정합 + orchestrator scope 협소 자연 분기 (Step 5 단독). 결정 source = INTENT motivation 의도 ('component-installer 만 spawn') vs audit-team sequence 본질 보존 trade-off — DESIGN 단계 안 5 관점 검토 후 결정.

Risks 6 식별 + mitigation DESIGN d_X 위임 — cascade drift host ≥4 (risk_1, v3.21 패턴 적용) + opt 선택별 sequence 본질 변경 (risk_2) + ext_2 transitive 비적용 spec 정합 narrative 명료화 (risk_3, v5.7 spec-drift spike (c) 분기 후보) + description 정합 본질 (risk_4) + smoke 회귀 차단 (risk_5, sc_4 결정 분기) + Step 6 synthesizer 책임 분기 (risk_6, oos_3 정합). DESIGN 단계 안 결정 사항 = (a) opt 채택 (opt_1/opt_2/opt_3 중) + (b) audit-team CLAUDE.md narrative 흡수 scope + (c) slash command harness-meta.md flow 변경 깊이 + (d) smoke 신규 도입 여부 (sc_4) + (e) cascade host 매트릭스 확정 (v3.21 패턴 적용 시) + (f) Step 6 synthesizer 책임 분기 (risk_6 mitigation 매핑).

## DESIGN

(미작성 — Stage D DESIGN 에서 작성)

## APPROVE

(미작성 — Stage E APPROVE 에서 사용자 명시 승인)

## EXECUTE

(미작성 — Stage F EXECUTE 에서 phase 별 작성. 본책 = phase 진행 요약, 별책 = `execute/phase-{n}.md`)

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)

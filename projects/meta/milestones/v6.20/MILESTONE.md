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

(미작성 — Stage C RESEARCH 에서 작성)

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

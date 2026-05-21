---
phase: phase-1
milestone: v6.20
status: completed
---

# v6.20 phase-1 — agents/audit-orchestrator.md 신설

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "agents/audit-orchestrator.md 신규 파일 작성 — frontmatter 4 필드 (name: audit-orchestrator / description: trigger keyword narrow + Step 1~6 책임 명시 + e3 정책 정합 narrative / tools: Agent(project-scanner, harness-gap-analyzer, claude-docs-mapper, component-proposer, component-installer), Read, Bash, Edit, Grep, Glob — v2.1.33+ Claude Code Agent(agent_type) syntax allowlist 첫 사용 / model: opus) + body 6 H2 sections (## Scope + ext_2 transitive 비적용 Note hardcode / ## Input / ## Step 1~4 read-only sequence / ## Step 4↔5 USER DECISION GATE / ## Step 5 component-installer spawn / ## Step 6 synthesizer fact verify + markdown lint precheck / ## Output / ## Constraints / ## 관련 문서). ext_2 transitive 비적용 spec hardcode = v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 14번째 (외부 spec 직접 인용 → 직접 정전화).",
  "changes": [
    {
      "type": "create",
      "path": "agents/audit-orchestrator.md",
      "description": "신규 파일 ~140 LOC. frontmatter 4 필드 + body H2 9 sections. Agent(...) literal 본 repo 안 첫 사용 사례 (cb_1 안 0 match evidence). audit-team 5 멤버 allowlist (opt_2 정합)."
    },
    {
      "type": "create",
      "path": "projects/meta/milestones/v6.20/execute/phase-1.md",
      "description": "별책 신규 — phase-1 산출 trace (changes + verification + commit metadata)."
    },
    {
      "type": "edit",
      "path": "projects/meta/milestones/v6.20/MILESTONE.md",
      "description": "## EXECUTE 섹션 신규 작성 (phases_executed[].phase-1 status: completed + commits + summary)."
    }
  ],
  "verification": [
    {
      "method": "manual",
      "result": "PASS",
      "detail": "frontmatter parse 정합 (---/--- opening/closing + 4 필드 YAML 정합). tools 필드 안 Agent(...) literal 안 5 멤버 name typo 부재 — project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer 모두 agents/*.md 안 실제 존재 (cb_1 정합). description 안 trigger keyword (`--audit`) 포함 + Step 1~6 책임 명시 + e3 정책 정합 narrative 명시 (risk_4 mitigation 정합)."
    },
    {
      "method": "manual",
      "result": "PASS",
      "detail": "ext_2 transitive 비적용 spec ## Scope 끝 Note inline hardcode — RESEARCH ext_2 직접 인용 (`This restriction does not apply to subagents spawning other subagents.`) + 본 v6.20 본질 = self-spawn allowlist 정확 매핑 narrative 명시 (risk_3 mitigation v5.7 spike 패턴 (c) 정합)."
    },
    {
      "method": "pre-commit",
      "result": "PENDING",
      "detail": "phase-1 commit 시 자동 실행 — smoke-spec-verification + smoke-scope-contract + smoke-cross-ref + smoke-claude-md-drift + smoke-bundle-trigger + smoke-open-stage-discipline + smoke-entry-title-guideline + smoke-cascade-drift + smoke-candidate-draft-schema + smoke-audit-fact-verify 자동 차단."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): v6.20 EXECUTE phase-1 — agents/audit-orchestrator.md 신설 (Agent(agent_type) syntax 첫 사용)"
  }
}
```

## Narrative

phase-1 scope = `agents/audit-orchestrator.md` 신규 파일 작성 (DESIGN d_1 + d_2 + d_3 + d_6 자연 cascade origin, 본 agent body 안 Step 1~6 통합 책임 narrative 직접 명시). frontmatter 4 필드 (name + description + tools + model) + body 9 H2 sections (Scope + Input + Step 1~4 / Step 4↔5 GATE / Step 5 / Step 6 + Output + Constraints + 관련 문서) ~140 LOC.

frontmatter `tools: Agent(project-scanner, harness-gap-analyzer, claude-docs-mapper, component-proposer, component-installer), Read, Bash, Edit, Grep, Glob` = 본 repo 안 첫 `Agent(agent_type)` literal 사용 사례 (RESEARCH cb_1 안 `Grep 'Agent\('` 0 match evidence 정합). opt_2 채택 (DESIGN d_1) 자연 — audit-team 5 멤버 allowlist + write 권한 단독 본질은 component-installer 자체 frontmatter level (`tools: Bash, Edit, Read`, cb_5) 안 이미 정합 + audit-team 외 agent (agents-md-sync / environment-auditor 등) spawn 차단 sandbox 효과.

body ## Scope 끝 Note hardcode = ext_2 transitive 비적용 spec 직접 인용 (`This restriction does not apply to subagents spawning other subagents.`) + 본 v6.20 본질 narrative ('audit-orchestrator agent 의 frontmatter tools 는 self-spawn allowlist 본질 매핑 — `Agent(component-installer)` 명시 시 본 agent 안에서 component-installer spawn 가능. 메인 Claude 의 tools 는 본 agent 의 invoke 자체 제한 본질 (별 scope, v6.20 본질 외).'). v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 14번째 자연 발현 (외부 spec 직접 인용 → 직접 정전화, risk_3 mitigation 정합).

description narrative scope (risk_4 mitigation 정합) = trigger keyword narrow (`--audit` keyword 포함) + Step 1~6 책임 명시 (Claude 자동 delegate matching narrative ext_4 정합) + e3 정책 정합 narrative (사용자 결정 게이트 강제). v6.16 stage skill description 정합 패턴 (trigger keyword narrow) 자연 정합.

body Step 1~6 narrative = audit-team CLAUDE.md L25 D8 sequence 1차 source 와 1:1 정합 (architecture P2#1 정합 의무) — Step 1~4 spawn 본질 + Step 4↔5 USER DECISION GATE inline + Step 5 component-installer spawn (accept 시만) + Step 6 synthesizer fact verify (v6.6 자동 검출 + v6.9 5-step + v5.13 직접 매핑 잔여 + v5.16 lint precheck) 통합 책임. ## 관련 문서 안 6 cross-ref (audit-team CLAUDE.md + harness-meta.md + v6.20 MILESTONE.md + ARCHITECTURE § 4 매트릭스 #10/#5 row + v5.16 lint precheck + v5.18 Input Verification).

verification 본질 = (a) frontmatter parse 정합 manual PASS + (b) Agent(...) literal 안 5 멤버 typo 부재 manual PASS + (c) description trigger keyword + Step 1~6 책임 명시 manual PASS + (d) ext_2 spec hardcode manual PASS + (e) pre-commit hook 12+ smoke 자동 차단 PENDING (commit 시점). phase-1 완료 후 phase-2 진입 = cascade Edit 4 host (1차 source = audit-team CLAUDE.md + 3 cascade host).

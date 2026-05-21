---
phase: phase-3
milestone: v6.20
status: completed
---

# v6.20 phase-3 — smoke 신규 + pre-commit 등록 + cycle 1 evidence + v3.21 (c) VERIFY grep

## Spec

```json
{
  "phase": "phase-3",
  "status": "completed",
  "scope": "tests/smoke-agent-frontmatter-schema.sh 신규 작성 (3 검증 항목 = (a) agents/*.md frontmatter parse + (b) tools 필드 안 Agent(...) literal regex 정합 + (c) Agent(...) 참조 agent name 이 agents/{name}.md 안 실제 존재 검증) + .pre-commit-config.yaml 안 hook 등록 + 본 milestone 자체 cycle 1 evidence (audit-orchestrator.md 안 Agent(5 멤버 allowlist) 정합 PASS) + v3.21 narrative 정전화 3 단계 패턴 (c) VERIFY grep ('메인 Claude.*orchestrator' active narrative 0 match, historical milestone 산출물 안 보존).",
  "changes": [
    {
      "type": "create",
      "path": "tests/smoke-agent-frontmatter-schema.sh",
      "description": "신규 smoke ~95 LOC. v2.1 batched python heredoc 패턴 정합 + cp949 함정 회피 (sys.stdout.reconfigure utf-8). 3 검증 항목 = frontmatter parse + Agent(...) literal regex (name regex `^[a-z][a-z0-9_-]*$`) + 참조 agent agents/{name}.md 존재 검증."
    },
    {
      "type": "edit",
      "path": ".pre-commit-config.yaml",
      "description": "smoke-agent-frontmatter-schema hook 등록 (마지막 hook 다음). files = `^agents/[^/]+\\.md$|^tests/smoke-agent-frontmatter-schema\\.sh$`."
    }
  ],
  "verification": [
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "bash tests/smoke-agent-frontmatter-schema.sh 직접 실행 — 8 파일 검증 / 5 참조 검증 / 0 FAIL. cycle 1 evidence = agents/audit-orchestrator.md 안 Agent(...) literal 1건 (5 참조 = project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer 모두 agents/*.md 안 실제 존재) PASS. 7 기존 agent .md (Agent(...) literal 부재, 일반 tool list) frontmatter parse OK PASS."
    },
    {
      "method": "manual",
      "result": "PASS",
      "detail": "v3.21 narrative 정전화 3 단계 패턴 (c) VERIFY grep — `Grep '메인 Claude orchestrator|메인 Claude (orchestrator)|orchestrator = 메인 Claude'` 결과 13 파일 잔존. 분석 = (a) v6.20 milestone 산출물 (MILESTONE.md INTENT/RESEARCH/DESIGN/APPROVE 안 거명 + execute/phase-2.md 정정 narrative) = 본 정전화 작업 trace + history reference 보존 자연 + (b) agents/project-harness-audit-team/CLAUDE.md L27 = v6.20 정전화 Note 본문 안 'v6.20 이전 narrative 는 historical milestone 산출물 안 보존' + '메인 Claude 의 restriction 은 본 agent 의 invoke 자체 제한 본질, 별 scope' (정합 narrative 자연 보존, DESIGN d_5 narrative '정합 narrative 만 잔존' 정합) + (c) v4.0/v5.11/v5.13/v5.16/v5.18/v6.6/v6.9 milestone 산출물 = historical audit trail 보존 자연. active narrative 안 거명 = 0 match (sc_6 cascade host drift 부재 + v3.21 (c) 검증 정합)."
    },
    {
      "method": "pre-commit",
      "result": "PENDING",
      "detail": "phase-3 commit 시 자동 실행 — 12 + 1 (smoke-agent-frontmatter-schema 신규) = 13 smoke hook 자동 차단. 신규 smoke = cycle 1 evidence 검증 자연 PASS (smoke 직접 실행 evidence)."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): v6.20 EXECUTE phase-3 — smoke-agent-frontmatter-schema 신규 + pre-commit 등록 + cycle 1 evidence"
  }
}
```

## Narrative

phase-3 scope = tests/smoke-agent-frontmatter-schema.sh 신규 작성 + .pre-commit-config.yaml 등록 + 본 milestone 자체 cycle 1 evidence + v3.21 (c) VERIFY grep. DESIGN d_4 (smoke 신규 phase-3 안 통합, 사용자 R2 결정 정합) 의무 본질 정합.

smoke 작성 본질 = v2.1 batched python heredoc 패턴 정합 (memory `project_v2.1_smoke-spawn-batching` cp949 함정 회피 + python stdlib only) + 3 검증 항목 명시 — (a) agents/*.md frontmatter parse (`---\n...\n---\n` regex 매칭) + (b) tools 필드 안 Agent(...) literal regex (`Agent\(([^)]*)\)` + comma separated name list + name regex `^[a-z][a-z0-9_-]*$`) + (c) Agent(...) 참조 agent name 이 agents/{name}.md 안 실제 존재 검증 (agent_names set 안 name 매핑). standalone agents/*.md 만 검증 — sub-directory 안 CLAUDE.md (예: agents/project-harness-audit-team/CLAUDE.md) 제외.

cycle 1 evidence 직접 실행 = `bash tests/smoke-agent-frontmatter-schema.sh` PASS — 8 파일 검증 (agents/{agents-md-sync, audit-orchestrator, claude-docs-mapper, component-installer, component-proposer, environment-auditor, harness-gap-analyzer, project-scanner}.md) + 5 참조 검증 (audit-orchestrator.md 안 Agent(5 멤버 allowlist) literal 1건 안 5 name 모두 agents/{name}.md 존재) + 0 FAIL. 7 기존 agent .md 안 Agent(...) literal 부재 = 일반 tool list 자연 (frontmatter parse OK PASS, RESEARCH cb_1 안 0 match evidence 정합).

.pre-commit-config.yaml 등록 = 마지막 hook (smoke-audit-fact-verify) 다음에 신규 hook 추가. files = `^agents/[^/]+\.md$|^tests/smoke-agent-frontmatter-schema\.sh$` (agents/*.md edit 시 또는 smoke 자체 edit 시 자동 trigger). cycle 1 evidence 자연 PASS = 미래 cycle 2+ (oos_2 정합 — 다른 agent .md 안 Agent(...) syntax 흡수 시) 회귀 차단 자연.

v3.21 narrative 정전화 3 단계 패턴 (c) VERIFY grep 본질 = active narrative 안 '메인 Claude.*orchestrator|메인 Claude (orchestrator)|orchestrator = 메인 Claude' 0 match 또는 정합 narrative 만 잔존. grep 결과 13 파일 잔존 분석 = (a) v6.20 milestone 산출물 (현 milestone 정정 작업 trace + history reference 보존 자연) + (b) agents/project-harness-audit-team/CLAUDE.md L27 v6.20 정전화 Note 본문 안 'v6.20 이전 narrative 는 historical milestone 산출물 안 보존' + '메인 Claude 의 restriction 은 본 agent 의 invoke 자체 제한 본질, 별 scope' 정합 narrative 보존 (DESIGN d_5 narrative '정합 narrative 만 잔존' 직접 정합) + (c) v4.0/v5.11/v5.13/v5.16/v5.18/v6.6/v6.9 historical milestone 산출물 audit trail 보존 자연. active narrative 안 거명 = 0 match 자연 (sc_6 cascade host drift 부재 + v3.21 (c) 검증 정합).

phase-3 완료 후 Stage F EXECUTE 종료. Stage G VERIFY 진입 본질 = INTENT sc[1~6] 1:1 매핑 + smoke 회귀 부재 + criteria_check 종합.

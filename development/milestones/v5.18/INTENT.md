---
id: v5.18
title: audit chain agent prompt 'input 산출물 직접 Read 의무' 명시 + v5.13 fact 검증 절차 깊이 강화 (검증 method 분리) — v5.17 PROPOSE #1+#4 통합, cycle 9 evidence 도달 trigger
version: v5.18
stage: INTENT
status: completed
---

# INTENT — v5.18 audit-chain-direct-read-and-verification-depth

## Spec

```json
{
  "goal": "audit chain 4 read-only 멤버 agent (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer) 의 .md 정의 안 'input 산출물 직접 Read 의무' narrative 명시 + v5.13 fact 검증 절차 (claude/commands/harness-meta.md --audit 분기 + agents/project-harness-audit-team/CLAUDE.md D8) 안 검증 method 분리 (boolean / 표 / 수치 별 매핑 method) narrative 강화. v3.21 narrative 정전화 3 단계 패턴 19 번째 cycle 도그푸드 완성.",
  "success_criteria": [
    "audit chain 4 read-only 멤버 agent .md 안 'input 산출물 직접 Read 의무' narrative 추가 (project-scanner 는 input 부재 첫 멤버 = 예외 narrative 포함, harness-gap-analyzer / claude-docs-mapper / component-proposer 3 멤버 = 직접 Read 의무 명시)",
    "v5.13 절차 정전화 2 위치 (claude/commands/harness-meta.md --audit 분기 + agents/project-harness-audit-team/CLAUDE.md D8) 안 '검증 method 분리' narrative 추가 (boolean / 표 / 수치 별 매핑 method 명시)",
    "ARCHITECTURE.md § 4 끝 'Audit chain fact 인용 검증 의무' paragraph 안 검증 method 분리 + agent .md 안 Read 의무 narrative 흡수 (v3.21 3-layer 패턴 WHAT 위치)",
    "v3.21 narrative 정전화 3 단계 패턴 19 번째 cycle 도그푸드 완성 (v5.17 = 18 번째, v5.18 = 19 번째)",
    "INTENT.success_criteria ↔ DESIGN.phases 1:1 매핑 + VERIFY.criteria_check 모두 PASS",
    "pre-commit 14 hook 모두 PASS + 회귀 0",
    "memory feedback_subagent_fact_hallucination_correction.md 안 cycle 도달 narrative 갱신 (cycle 2 direct evidence → cycle 3+ 절차 강화 evidence 추가)",
    "INTENT.out_of_scope 6건 사실 진술 + RESEARCH.untouched_files_explicit / risks_identified 사실 진술 + DESIGN.decisions.rationale / phases.scope 사실 진술 부산물 = PROPOSE 안 통합 흡수 (v3.10 단일 origin 강제)"
  ],
  "out_of_scope": [
    "agent frontmatter Tools 필드 변경 부재 — v5.17 PROPOSE.next_candidates#8 (audit-agent-tool-permission-enhancement) 본질 = tool permission 강화 (다른 변경 축, agent .md 안 narrative 변경 vs frontmatter Tools 변경 = 단일 milestone 안 책임 분리 의도)",
    "component-installer agent 변경 부재 — 본 milestone scope = audit chain 4 read-only 멤버 (D8 Step 1~4) scope, installer 는 사용자 결정 후 apply 책임 (Step 5+, 다른 stage)",
    "외부 적용 (upbit 등 외부 projects audit cycle 호출) 부재 — 본 milestone 은 내부 절차 정전화, 외부 적용은 별 cycle (cycle 6+)",
    "v5.17 PROPOSE 7건 carry-over candidate (#2 markdown lint rule 확장 / #3 stability pattern / #5 § 4 끝 매트릭스화 / #6 self-loop 분류 / #7 § 3.1 baseline drift / #9 cost tracker spike / #10 R4 정량 threshold) 처리 부재 — 본 milestone scope = #1+#4 통합 만",
    "agent .md 안 'input 산출물 직접 Read 의무' 외 추가 기능 강화 부재 (예: agent 간 cross-validation, agent 산출물 자체 self-validation 등 = 별 본질, 별 milestone)",
    "agents/project-harness-audit-team/CLAUDE.md 안 D8 sequence 본문 structural 변경 부재 — D8 cycle count 갱신 + 검증 method 분리 narrative 추가만, D8 sequence 자체는 v5.13 baseline 유지"
  ]
}
```

## Motivation

v5.10 cycle 1 (component-proposer 12 항목 hallucination) ~ v5.17 cycle 9 (proposer Fleet 현황 fabricated) 누적 9 cycle, cycle 7+8+9 = 8건 정량 evidence 도달. v5.13 정전화 (3-layer 구조 WHAT § 4 끝 + WHERE D8 Note + HOW --audit step) 후에도 cycle 7~9 hallucination 8건 발생 = 절차 깊이 부족 evidence. root cause = agent prompt 안 'input 산출물 (예: analyzer-output.md) 직접 Read 의무' 부재 → 사용자 context 부족 시 agent 가 본질 추측 (fabricated) + 검증 method 분리 부재 → synthesizer 검증 시 boolean / 표 / 수치 별 매핑 분기 모호. v5.17 PROPOSE.next_candidates#1 (agent-prompt-direct-read-mandate, L1 origin) + #4 (fact-verification-depth-enhancement, L7 origin) 통합 처리 = 동일 root cause 단일 milestone 흡수 (ARCHITECTURE § 6.1 9-stage-bundled era 정합).

## Dependencies

- **prior**: v5.13 (audit chain fact 검증 절차 정전화 baseline, 3-layer 구조 WHAT/WHERE/HOW), v5.16 (audit output markdown lint precheck 정전화 — 본 milestone 의 정전화 위치 패턴 정합 source), v5.17 (PROPOSE.next_candidates#1+#4 origin, cycle 9 evidence + L1+L7 lessons)
- **next**: v5.17 PROPOSE.next_candidates#8 (audit-agent-tool-permission-enhancement) carry-over (분리, tool permission 변경 = 다른 본질), v5.17 PROPOSE.next_candidates#3 (audit-cycle-stability-pattern-canonicalization) carry-over (외부 적용 cycle 6+ 후 evaluation), v5.17 PROPOSE.next_candidates#5/#6/#7 carry-over (§ 4 끝 매트릭스화 / self-loop 분류 / § 3.1 baseline)

## narrative

### #1+#4 통합 본질

v5.17 PROPOSE 안 본 두 candidate 는 동일 root cause (audit chain hallucination cycle 9 누적 = cycle 7+8+9 8건 evidence 도달) 에서 origin — 분리 시 단순 narrative 중복 + 동일 evidence 2번 인용. 통합 시 3-layer 정전화 패턴 (v3.21) 정합 자연:

| Layer | 변경 위치 | #1 변경 | #4 변경 |
|---|---|---|---|
| WHAT (정의) | `projects/meta/ARCHITECTURE.md` § 4 끝 'Audit chain fact 인용 검증 의무' paragraph (v5.11 정전화) | cross-ref 갱신 (agent .md 안 Read 의무 narrative 흡수) | cross-ref 갱신 (검증 method 분리 narrative 흡수) |
| WHERE (orchestration) | `agents/project-harness-audit-team/CLAUDE.md` D8 (v5.13 정전화) + `agents/{4 멤버}.md` | 4 멤버 agent .md 안 'input 산출물 직접 Read 의무' narrative 추가 + D8 cycle count 갱신 | D8 sequence 안 '검증 method 분리' narrative 추가 (boolean / 표 / 수치 별 매핑) |
| HOW (workflow) | `claude/commands/harness-meta.md` --audit 분기 (v5.13 정전화) | step narrative 안 'agent prompt 안 Read 의무 명시' cross-ref | step narrative 안 '검증 method 분리' 명시 |

### v3.21 narrative 정전화 3 단계 패턴 19 번째 cycle 도그푸드

v3.21 도입 이후 18 번째 cycle (v5.17) 완성. 본 v5.18 = 19 번째 cycle (3 단계: DESIGN 1차 + EXECUTE Edit + VERIFY grep). 누적 cycle list = v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + v5.11 + v5.12 + v5.13 + v5.14 + v5.15 + v5.16 + v5.17 + 본 v5.18 = 19 cycle.

### v3.10 부산물 흡수 정합

- B (INTENT.out_of_scope 6건): 모두 **사실 진술** (변경 부재 진술, '본 milestone 이 무엇이 아닌가') — 'v5.17 PROPOSE #8 별 milestone' 같은 forward propose 명령형 부재. PROPOSE.next_candidates 안 통합 흡수 의도.
- C (RESEARCH.untouched_files_explicit / risks_identified): Stage C 작성 시 사실 진술 — '거명 candidate' 부재 (PROPOSE 통합 흡수 의도).
- D (DESIGN.decisions.rationale / phases.scope): Stage D 작성 시 결정 + 단계 범위 사실 진술 — 'next_candidates 진급 narrative' 부재 (PROPOSE 단일 origin).

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) v5.18
- milestones (1차 source): [`milestones.md`](milestones.md)
- v5.17 PROPOSE (origin): [`../v5.17/PROPOSE.md`](../v5.17/PROPOSE.md) #1 + #4
- v5.13 절차 정전화 baseline: [`../v5.13/REPORT.md`](../v5.13/REPORT.md)
- ARCHITECTURE § 4 끝 (WHAT 정의): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)

---
id: v5.12_bundled-skill-narrative-cleanup
title: PROPOSE v5.12
version: v5.12
stage: PROPOSE
status: completed
---

# PROPOSE — v5.12 bundled-skill-narrative-cleanup

## Spec

```json
{
  "next_candidates": [
    {
      "id": "audit-chain-fact-verification-protocol-procedure",
      "origin": "v5.11 PROPOSE#1 carry-over + v5.12 L1 cycle 3 evidence direct",
      "rationale": "v5.11 PROPOSE#1 trigger 조건 (사용자 명시 발의 ∧ evidence cycle 3 도달) 충족 — v5.12 L1 lesson cycle 3 direct evidence 도달. 절차 정전화 본질 = claude/commands/harness-meta.md Stage A 안 audit chain 산출물 fact 직접 검증 step 신규 또는 agents/project-harness-audit-team/CLAUDE.md 안 멤버 자체 검증 책임 명시. workflow self-improvement 본질 — 새 정체성 (project harness composer + ecosystem integrator + agent fleet maintainer) 부합 약함.",
      "trigger_condition": "사용자 명시 발의 (A_user) — trigger 누적 evidence 모두 충족, 사용자 결정 자연 타이밍",
      "decision": "거명만 (ROADMAP 등재 zero, 사용자 명시 default 동결 정합)"
    },
    {
      "id": "harness-meta-informal-terminology-spec-source-conflict-audit",
      "origin": "v5.12 L3 lesson 신규 origin",
      "rationale": "harness-meta 안 informal 용어 ('bundled skill 별칭' 등) ↔ spec source 안 정의된 용어 ('bundled skill' = prompt-based playbook) 충돌 사례 audit. v1.17 mapper origin 'bundled skill' 용어 = spec source 정합 부재 → v5.10 mapper cascade → v5.12 정정 cycle. 후속 informal 용어 (예: 'subagent', 'hook', 'skill' 등) audit cycle.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 추가 informal 용어 ↔ spec 충돌 사례 1+ 발견",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "context7-multi-source-verification-discipline-canonicalization",
      "origin": "v5.12 L7 lesson 신규 origin",
      "rationale": "narrative 정전화 milestone 안 RESEARCH context7 query 4+ source 다중 인용 의무 narrative. v5.12 = 5 source (glossary + skills + slash-commands + whats-new + changelog) 일관 명시 = spec 정합 확신 누적. 단일 source 시 drift origin 발견 risk (v5.10 mapper = 1 source 'skills' 안 'A few built-in commands available through the Skill tool' 잘못 해석). 워크플로우 강화 본질 — 새 정체성 부합 약함.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ workflow 강화 cycle 필요 명시",
      "decision": "거명만 (ROADMAP 등재 zero, workflow self-improvement 본질)"
    },
    {
      "id": "drift-origin-vs-cascade-target-narrative-canonicalization",
      "origin": "v5.12 L6 lesson 신규 origin",
      "rationale": "drift origin (정정 본질 위치) vs drift cascade target (정정 본질 부재 위치) 분기 narrative 정전화. v5.12 = v5.10 mapper-output.md (origin, [v5.12 정정] inline) vs v1.17 proposal-draft.md (cascade target, 정보성 footnote only). 후속 narrative cleanup milestone 안 분기 의무 narrative.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 2+ drift cycle 누적 후 분기 명확화 필요",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "audit-output-correction-pattern-canonicalization-cycle-2",
      "origin": "v5.11 PROPOSE#2 carry-over + v5.12 L5 cycle 2 추가",
      "rationale": "v5.11 L1 패턴 (agent 직접 산출 inline 정정 archive vs synthesizer 임시 산출 overwrite) cycle 2 적용 evidence — v5.10 mapper-output.md + diff-vs-v1.17.md 안 [v5.12 정정] footnote 추가. cycle 누적 2 → narrative 정전화 trigger 가능.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 2 cycle 누적 evidence 도달 (현재 cycle 2)",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "v5.10-propose-candidate-1-upbit-plugin-json-hooks-mcpservers-extension",
      "origin": "v5.10 PROPOSE.next_candidates#1 carry-over (v5.11 #3 → v5.12 #6)",
      "rationale": "upbit `.claude-plugin/plugin.json` 안 hooks + mcpServers 필드 미포함 (v1.17 G1 초안 대비 축소 적용, N4 gap). plugin install 단일 동작으로 hook/MCP 자동 활성화 = Plugin spec 정합. 외부 적용 milestone — upbit repo target. S2/S3 SPIKE 해소 선행 필요.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ S2/S3 SPIKE 해소 후 통합 결정",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "v5.10-propose-candidate-6-external-audit-team-cycle-3-call",
      "origin": "v5.10 PROPOSE.next_candidates#6 carry-over (v5.11 #5 → v5.12 #7)",
      "rationale": "audit-team 외부 호출 cycle 누적 = ecosystem integrator 정체성 vector 운용 evidence 강화. 본 v5.12 = meta self-loop + drift origin/cascade 정정 본질 (외부 vector 직접 운용 부재). cycle 3 trigger 조건 = 외부 적용 vector 추가 누적 + 사용자 명시 발의 AND.",
      "trigger_condition": "사용자 명시 발의 (A_user) — 외부 적용 vector 추가 누적 후",
      "decision": "거명만 (ROADMAP 등재 zero)"
    }
  ]
}
```

## Roadmap registration count

0

## Policy compliance

- **lightweight_default_freeze_compliance**: ROADMAP 등재 0건 = lightweight 모드 default 동결 정합. 본 v5.12 = lightweight 부재 (5 관점 subagent 사용자 명시 호출 + scope 재정의 cascade) — 다음 cycle 자연 lightweight 회귀 가능. § 6.2 폐지 narrative (v4.0) 자연 부합 — workflow self-improvement candidates (#1/#3/#4) = 새 정체성 부합 약함 표현 default.
- **ecosystem_integrator_alignment**: 본 PROPOSE next_candidates 7건 중 외부 vector 직접 trigger = #6 (upbit Plugin) + #7 (cycle 3 audit) = 2건 / drift origin 정정 cycle 누적 = #2 (informal 용어 audit) + #4 (drift origin/cascade 분기) + #5 (audit output 정정 cycle 2) = 3건 / workflow self-improvement = #1 (절차) + #3 (context7 multi-source) = 2건. ecosystem integrator vector evidence sub-metric = 2/7 = 28.6% (약화) — meta self-loop 본질 자연.
- **byproduct_absorption_compliance**: INTENT.out_of_scope 5건 (B 부산물) + RESEARCH.untouched_files_explicit 7건 (C 부산물) + RESEARCH.risks_identified 7건 (C 부산물) + DESIGN.decisions[i].rationale + phases[1].scope (D 부산물) 모두 (a) 사실 진술만 = forward propose 명령형 부재 검증 완료 (v3.10 정합).

## Roadmap status update pending

Stage I 종료 시점 projects/meta/ROADMAP.md 안 v5.12 entry status: in_progress → completed 갱신 + summary 본 REPORT 흡수 (Stage G+H+I 통합 chore commit 시점)

## narrative

본 PROPOSE 는 v5.12 milestone 의 후속 forward proposal. ROADMAP 등재 0건 (거명만) — 사용자 명시 결정 (lightweight 누적 default 동결 + § 6.2 폐지 narrative 정합).

### next_candidates 7건 거명

1. `audit-chain-fact-verification-protocol-procedure` (v5.11 PROPOSE#1 carry-over + v5.12 L1 cycle 3 direct evidence — trigger 조건 충족, 사용자 명시 default 동결 채택)
2. `harness-meta-informal-terminology-spec-source-conflict-audit` (v5.12 L3 origin — informal 용어 ↔ spec 충돌 audit cycle)
3. `context7-multi-source-verification-discipline-canonicalization` (v5.12 L7 origin — RESEARCH context7 4+ source 다중 인용 의무 narrative)
4. `drift-origin-vs-cascade-target-narrative-canonicalization` (v5.12 L6 origin — origin vs cascade target 분기 narrative)
5. `audit-output-correction-pattern-canonicalization-cycle-2` (v5.11 PROPOSE#2 carry-over + v5.12 L5 cycle 2 추가)
6. `upbit-plugin-json-hooks-mcpservers-extension` (v5.10 PROPOSE#1 carry-over)
7. `external-audit-team-cycle-3-call` (v5.10 PROPOSE#6 carry-over)

### v5.11 PROPOSE candidates 흡수 narrative

v5.11 PROPOSE 5건 안:

- v5.11#1 = 본 v5.12 PROPOSE#1 진급 (cycle 3 direct evidence 흡수)
- v5.11#2 = 본 v5.12 PROPOSE#5 진급 (cycle 2 추가 evidence)
- v5.11#3 = 본 v5.12 PROPOSE#6 carry-over (upbit Plugin)
- v5.11#4 = 본 v5.12 흡수 완료 (bundled-skill narrative cleanup) → 거명 제외
- v5.11#5 = 본 v5.12 PROPOSE#7 carry-over (cycle 3 audit)

### Stage I 종료 시점 ROADMAP 갱신

`projects/meta/ROADMAP.md` 안 v5.12 entry status: in_progress → completed + summary 본 REPORT 흡수 — Stage G+H+I 통합 chore commit 안 포함.

### ecosystem integrator vector evidence sub-metric

본 v5.12 = meta self-loop + drift origin/cascade 정정 본질 = 외부 vector 직접 운용 부재. self-loop 비례 누적 (15/15 = 100% 본 v5.12 추가, v5.11 시점 14/14 = 100% 동일 patterns). external vector evidence = 본 PROPOSE candidates 안 #6 + #7 = 2/7 = 28.6%. v5.10 second call 안 PROPOSE = 5/6 강력 vs 본 v5.12 = 2/7 약화 — meta narrative 정전화 본질 자연.

### v5.11 PROPOSE#1 trigger 충족 narrative + 사용자 default 동결 채택

v5.11 PROPOSE#1 trigger_condition = "사용자 명시 발의 (A_user) ∧ evidence cycle 3 도달" — 모두 충족:

- 사용자 명시 발의: v5.12 Stage I PROPOSE 사용자 결정 round (2026-05-18)
- evidence cycle 3: v5.12 L1 lesson cycle 3 direct evidence 도달

→ ROADMAP 등재 가능. 단 사용자 명시 default 동결 채택 = 거명만 (자연 타이밍 후 v5.13+ 명시 발의 단독 진행).

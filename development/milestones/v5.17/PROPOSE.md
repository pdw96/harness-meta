---
id: v5.17
title: PROPOSE v5.17
version: v5.17
stage: PROPOSE
status: completed
---

# PROPOSE — v5.17 external-audit-team-cycle-5-call

## Spec

```json
{
  "next_candidates": [
    {
      "id": "audit-chain-agent-prompt-direct-read-mandate",
      "origin": "v5.17 L1 lesson + cycle 9 hallucination 누적 trigger 가속",
      "rationale": "audit chain hallucination cycle 9 누적 (v5.10 cycle 1 ~ v5.17 cycle 9). cycle 8 (mapper S1/S3/S4 본질 fabricated) + cycle 9 (proposer Fleet 현황 fabricated) 모두 동일 root cause = agent prompt 안 'analyzer-output.md 직접 Read 의무' 부재 + 사용자 context 부족 시 본질 추측. agent 정의 (.md) 안 'input 산출물 직접 Read 의무' 명시 candidate. v5.16 PROPOSE#6 (audit-agent-tool-permission-enhancement) trigger 조건 evidence 누적 (9 cycle 도달).",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 10+ hallucination 추가 발생 또는 본 cycle 9 evidence 도달 정량 기준 (cycle 7+8+9 = 8건 누적)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, lightweight default 동결 정합)"
    },
    {
      "id": "audit-output-markdown-lint-rule-expansion-md038-md028",
      "origin": "v5.17 L2 lesson — MD038 도그푸드 + v5.16 PROPOSE#2 carry-over",
      "rationale": "v5.16 lint precheck 절차 첫 실전 적용 = MD022/MD031/MD032 hardcode 3 rule 모두 PASS, 단 MD038 (no-space-in-code) 1건 (scanner-output L220) 도그푸드 발현. v5.16 자체 MD028 (no-blanks-blockquote) 도그푸드 (L2 lesson origin) + 본 v5.17 MD038 도그푸드 = 누적 2 사례 (hardcode 외 rule). cycle 6+ 추가 발현 시 rule 확장 candidate (MD028 + MD038 동시 추가). 또는 본 milestone PROPOSE 안 사용자 명시 발의 시 즉시 trigger.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 6+ 추가 MD028 또는 MD038 발생 또는 새 rule 발현",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "audit-cycle-stability-pattern-canonicalization",
      "origin": "v5.17 L3 lesson — 3 cycle stability 누적",
      "rationale": "v1.17 (12 항목) + v1.19 (4 항목) + v1.20 (2 항목) = 18 apply 항목 100% stability 누적 evidence. cycle 1 (v1.17 apply ALL) + cycle 3 (v5.14 audit) + cycle 4 (v1.19 apply) + cycle 4 (v5.15 audit) + cycle 5 (v1.20 apply) + cycle 5 (v5.17 audit) = audit → apply → audit 순환 stability cycle pattern 명시. ARCHITECTURE.md § 4 끝 paragraph 정전화 candidate (audit cycle stability pattern).",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 6+ stability cycle 추가 누적",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "fact-verification-depth-enhancement",
      "origin": "v5.17 L7 lesson — hallucination 증가 추세 break + cycle 5 N=3 통계 시작",
      "rationale": "cycle 3 5건 → cycle 4 2건 (감소) → cycle 5 8건 (감소 추세 break). N=3 통계 의미 = 'audit chain hallucination 발생률 cycle 의존 + fact 검증 절차 깊이 의존'. v5.13 절차 안 'synthesizer 직접 매핑 검증' 의무는 명시되어 있으나 'agent input 산출물 직접 Read 의무' 부재 (L1 lesson 연계). v5.13 절차 강화 candidate = (a) agent input 직접 Read 의무 추가 (b) 검증 step 분리 명시 (boolean / 표 / 수치 별 검증 method 명시).",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ L1 + L7 연계 통합 처리 (cycle 10+ 추가 evidence 누적)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "architecture-section-4-end-paragraph-matrix-canonicalization",
      "origin": "v5.16 PROPOSE#1 carry-over (§ 4 끝 paragraph 6건+ 누적 trigger 대기, 본 v5.17 vector count 갱신만이라 paragraph 추가 부재 = 5건 유지)",
      "rationale": "ARCHITECTURE.md § 4 끝 paragraph 누적 5건 (v5.16 baseline 유지) — 본 v5.17 = paragraph 추가 부재 (vector count 갱신만, narrative 본문 무변경). 6건+ 누적 시 매트릭스화 trigger 충족. v5.16 PROPOSE#1 그대로 carry-over.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ § 4 끝 paragraph 6건+ 누적",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "self-loop-classification-criteria-definition",
      "origin": "v5.16 PROPOSE#4 carry-over",
      "rationale": "v5.16 self-loop 분류 = workflow narrative 강화 self-loop 정합 결정 (D3). v5.17 카운팅 정전화 18/23 = 78.3% 적용. 그러나 분류 기준 narrative 자체는 정전화 부재 — ARCHITECTURE.md 안 self-loop 분류 기준 paragraph 정전화 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 추가 카운팅 모호 사례 발생",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "architecture-section-3-1-baseline-drift-cleanup",
      "origin": "v5.16 PROPOSE#5 carry-over",
      "rationale": "v5.15 § 3.1 L77 v5.8 baseline narrative (92.3% self-loop) stale drift 누적. v5.10/v5.14/v5.15/v5.16/v5.17 cycle 누적 후 더욱 stale (현 78.3% vs baseline 92.3%).",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "audit-agent-tool-permission-enhancement",
      "origin": "v5.16 PROPOSE#6 carry-over + v5.17 L1 evidence 누적 강화",
      "rationale": "scanner agent Glob/Read 한계 + proposer .claude/ prefix systematic confusion (cycle 4 + cycle 6 + cycle 9). agent 정의 (.md) 변경 = ecosystem integrator vector 강화 본질. v5.17 cycle 9 evidence 누적 = trigger 가속.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ L1 통합 처리 가능",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "harness-cost-tracker-spike-reevaluation",
      "origin": "v5.16 PROPOSE#7 carry-over (F4 SPIKE 본 v5.17 decision_pending 유지)",
      "rationale": "F4 SPIKE = harness-cost-tracker (S2 의존). v1.19 S2 apply 완료 = 의존 해소. 본 v5.17 사용자 결정 = 추후 (decision_pending 유지). 독립 재평가 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "r4-quantitative-threshold-narrative",
      "origin": "v5.16 PROPOSE#8 carry-over",
      "rationale": "R4 mitigation narrative 안 'cycle 5+ 발생률 정량 evidence 누적 시' 정량 threshold (3 사례? 5 사례?) 부재. evidence-base 원칙 정합하나 trigger 임계값 narrative 명시 = future cycle carry-over 시 결정 모호 회피.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ MD028+MD038 hardcode 확장 milestone 발의 시 동시 처리 candidate",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    }
  ]
}
```

## Roadmap registration count

0

## Policy compliance

- **lightweight_default_freeze_compliance**: ROADMAP 등재 0건 (lightweight default 동결 정합). v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium (memory feedback_section_6_2_abolished 정합). 10 candidates 모두 거명만 — 사용자 명시 발의 + 추가 evidence 누적 시 진급 trigger 보존. v5.7 ~ v5.17 누적 11 cycle 동결 사례.
- **byproduct_absorption_compliance**: INTENT.out_of_scope 6건 + RESEARCH.untouched_files_explicit / risks_identified 사실 진술 + DESIGN.decisions rationale 본 PROPOSE 안 통합 흡수 (v3.10 단일 origin 강제). next_candidates 10건 = B/C/D 부산물 흡수 (7 carry-over from v5.16) + 본 milestone 신규 origin (3건 = L1/L2/L3 + L7). forward propose 명령형 부재 (B/C/D 안 거명 부재 검증).

## PROPOSE summary

v5.17 후속 forward proposal 10건 (거명만 10건, ROADMAP 등재 0). 신규 origin 4건 = (1) audit-chain-agent-prompt-direct-read-mandate (L1, cycle 9 도달) / (2) MD038+MD028 rule 확장 (L2, 도그푸드 누적 2 사례) / (3) audit-cycle-stability-pattern-canonicalization (L3, 3 cycle stability 누적) / (4) fact-verification-depth-enhancement (L7, hallucination 증가 추세 break + N=3 통계). carry-over 7건 = v5.16 PROPOSE.next_candidates#1+#4+#5+#6+#7+#8 (L4+L5+L6 + 매트릭스화 + self-loop 분류 + baseline drift cleanup + tool permission + cost tracker + threshold). 모두 lightweight default 동결 정합 (v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium). 누적 동결 11 cycle (v5.7 ~ v5.17). 사용자 결정 게이트 = F4 추후 + S1/S3/S4 현행 유지 = ROADMAP 등재 부재.

## narrative

### ROADMAP 등재 0건 — lightweight default 동결 정합

본 milestone 안 사용자 명시 신규 발의 부재. 모두 거명만 (lightweight default 동결, v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium). v5.7 ~ v5.17 누적 11 cycle 동결 사례 (feedback_section_6_2_abolished memory 정합).

### next_candidates 10건 분류

| ID | origin | trigger_condition | trigger_type |
|---|---|---|:-:|
| `audit-chain-agent-prompt-direct-read-mandate` | v5.17 L1 + cycle 9 누적 | cycle 10+ 또는 정량 trigger | C_improvement |
| `audit-output-markdown-lint-rule-expansion-md038-md028` | v5.17 L2 도그푸드 누적 2 | cycle 6+ 추가 발현 | C_improvement |
| `audit-cycle-stability-pattern-canonicalization` | v5.17 L3 stability 3 cycle | cycle 6+ stability 추가 | C_improvement |
| `fact-verification-depth-enhancement` | v5.17 L7 N=3 통계 시작 | L1 통합 처리 | C_improvement |
| `architecture-section-4-end-paragraph-matrix-canonicalization` | v5.16#1 carry-over | § 4 끝 6건+ 누적 | C_improvement |
| `self-loop-classification-criteria-definition` | v5.16#4 carry-over | 추가 모호 사례 | C_improvement |
| `architecture-section-3-1-baseline-drift-cleanup` | v5.16#5 carry-over | 사용자 명시 | C_improvement |
| `audit-agent-tool-permission-enhancement` | v5.16#6 carry-over + v5.17 L1 강화 | L1 통합 | C_improvement |
| `harness-cost-tracker-spike-reevaluation` | v5.16#7 carry-over (F4 decision_pending 유지) | 사용자 명시 | C_improvement |
| `r4-quantitative-threshold-narrative` | v5.16#8 carry-over | MD038 확장 동시 처리 | C_improvement |

### v3.10 부산물 통합 흡수 정합

- B (INTENT.out_of_scope 6건): v1.21 산출물 본체 / audit-team agent 정의 변경 / ARCHITECTURE § 3.1 본문 변경 / v5.13/v5.16 절차 변경 / component-installer 호출 / § 4 끝 paragraph 매트릭스화 — 사실 진술만, 명령형 부재 ✅
- C (RESEARCH.untouched_files_explicit + risks_identified): 식별 risk 7건 (R1~R7) — '재발의 candidate' 거명만, 명령형 부재 ✅
- D (DESIGN.decisions.rationale + phases.scope): 결정 기술 + 단계 범위 사실 — 명령형 부재 ✅

본 PROPOSE 안 origin 단일화 (v3.10 단일 origin 강제 정합).

### 사용자 결정 게이트 흡수

본 milestone Phase 1 안 사용자 결정 게이트 (AskUserQuestion 2 question) = F4 추후 (decision_pending 유지) + S1/S3/S4 현행 유지. upbit v1.21 milestone trigger 부재 = carry-over (PROPOSE.next_candidates#9 거명만, ROADMAP 등재 부재).

## 관련

- INTENT: [INTENT.md](INTENT.md)
- REPORT: [REPORT.md](REPORT.md)
- VERIFY: [VERIFY.md](VERIFY.md)
- v5.16 PROPOSE.md (7 carry-over origin)

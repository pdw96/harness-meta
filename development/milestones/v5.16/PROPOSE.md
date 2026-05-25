---
id: v5.16
title: PROPOSE v5.16
version: v5.16
stage: PROPOSE
status: completed
---

# PROPOSE — v5.16 audit-output-markdown-lint-precheck

## Spec

```json
{
  "next_candidates": [
    {
      "id": "architecture-section-4-end-paragraph-matrix-canonicalization",
      "origin": "v5.16 L1 lesson + architecture agent P1-1 권고",
      "rationale": "ARCHITECTURE.md § 4 끝 paragraph 누적 5건 도달 (v3.19+v3.20 word-fidelity drift / v5.9 ROADMAP drift / v5.10 cascade drift / v5.11 fact 검증 / v5.16 lint precheck). 모두 'X 의무/수용' 패턴 + cross-ref + evidence link 동일 구조 = 매트릭스화 candidate. 매트릭스 정전화 = paragraph 5건 → table 또는 nested list 형태로 변환 + 추가 paragraph 진입 시 매트릭스 row 추가. § 4 본문 비대화 회피.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ § 4 끝 paragraph 6건+ 누적 시 (cycle 6 누적 trigger)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, lightweight default 동결 정합)"
    },
    {
      "id": "audit-output-markdown-lint-rule-expansion-md028",
      "origin": "v5.16 L2 lesson — phase-1 1차 시도 MD028 도그푸드 재발 (정전화 milestone 자체 안 동일 rule 재발)",
      "rationale": "MD028 (no-blanks-blockquote) = v5.14 cycle 3 1건 발생 + 본 v5.16 phase-1 1차 1건 발생 = 누적 2 사례 도달 (cycle 4 부재 후 도그푸드 재발). 본 milestone scope = MD022/MD031/MD032 hardcode → MD028 미포함 (evidence-base 원칙 1 cycle 단일 발현 미흡 결정). 그러나 본 milestone 자체 도그푸드 재발 = trigger 조건 가속 (R4 narrative '추가 rule 시 본 절차 재발의 candidate' 정합). 향후 cycle 5+ 추가 누적 또는 도그푸드 재발 시 hardcode 확장 (MD028 추가) candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 5+ MD028 추가 발생 또는 도그푸드 재발 (3 사례 누적)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "external-audit-team-cycle-5-call",
      "origin": "v5.15 PROPOSE.next_candidates#3 carry-over (v5.15 L1 lesson)",
      "rationale": "v5.14 cycle 3 = 5 hallucination → v5.15 cycle 4 = 2 hallucination = 감소 추세이나 N=2 통계 약함. cycle 5+ 추가 누적 시 정량 evidence 강화. 본 v5.16 정전화 효과 검증 = cycle 5 호출 시점 = lint precheck 절차 + fact 검증 절차 (v5.13) 양 측면 evidence 강화. ecosystem integrator vector 5건 누적 가능.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ upbit v1.20 완료 후",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "self-loop-classification-criteria-definition",
      "origin": "v5.15 PROPOSE.next_candidates#4 carry-over",
      "rationale": "v5.15 § 6 디테일 분석 잠재 issue #1 — self-loop 분류 기준 정의 부재. ARCHITECTURE.md 안 self-loop 분류 기준 (audit narrative cleanup = self-loop? external vector 정의?) 정의 paragraph 정전화 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 추가 카운팅 모호 사례 발생",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "architecture-section-3-1-baseline-drift-cleanup",
      "origin": "v5.15 PROPOSE.next_candidates#5 carry-over",
      "rationale": "v5.15 § 6 디테일 분석 잠재 issue #4 — ARCHITECTURE § 3.1 L77 v5.8 baseline narrative (92.3% self-loop) stale drift 누적. v5.10/v5.14/v5.15/v5.16 cycle 누적 후 stale.",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "audit-agent-tool-permission-enhancement",
      "origin": "v5.15 PROPOSE.next_candidates#6 carry-over",
      "rationale": "scanner agent Glob/Read 한계 + proposer .claude/ prefix systematic confusion. agent 정의 (.md) 변경 = ecosystem integrator vector 강화 본질. v5.16 out_of_scope#1 정합 (별 milestone scope).",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "harness-cost-tracker-spike-reevaluation",
      "origin": "v5.15 PROPOSE.next_candidates#7 carry-over",
      "rationale": "F4 SPIKE = harness-cost-tracker (S2 의존). v1.19 S2 apply 완료 = 의존 해소. 독립 재평가 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "r4-quantitative-threshold-narrative",
      "origin": "v5.16 architecture agent P2-2 권고",
      "rationale": "R4 mitigation narrative 안 'cycle 5+ 발생률 정량 evidence 누적 시' 정량 threshold (3 사례? 5 사례?) 부재. evidence-base 원칙 정합하나 trigger 임계값 narrative 명시 = future cycle carry-over 시 결정 모호 회피. ARCHITECTURE § 4 끝 paragraph 안 정량 threshold 명시 paragraph 미세 보강 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ MD028 hardcode 확장 milestone 발의 시 동시 처리 candidate",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    }
  ]
}
```

## Roadmap registration count

0

## Policy compliance

- **lightweight_default_freeze_compliance**: ROADMAP 등재 0건 (lightweight default 동결 정합). v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium (memory feedback_section_6_2_abolished 정합). 8 candidates 모두 거명만 — 사용자 명시 발의 + 추가 evidence 누적 시 진급 trigger 보존. v5.7 ~ v5.16 누적 10 cycle 동결 사례.
- **byproduct_absorption_compliance**: INTENT.out_of_scope 5건 + RESEARCH.untouched_files_explicit / risks_identified 사실 진술 + DESIGN.decisions rationale 본 PROPOSE 안 통합 흡수 (v3.10 단일 origin 강제). next_candidates 8건 = B/C/D 부산물 흡수 (5 carry-over from v5.15) + 본 milestone 신규 origin (3건 = L1/L2/P2-2). forward propose 명령형 부재 (B/C/D 안 거명 부재 검증).

## PROPOSE summary

v5.16 후속 forward proposal 8건 (거명만 8건, ROADMAP 등재 0). 신규 origin 3건 = (1) § 4 끝 paragraph 5건 누적 매트릭스화 (L1 + architecture P1-1) / (2) MD028 도그푸드 재발 (L2, 2 사례 누적 도달이나 cycle 5 trigger 대기) / (3) R4 정량 threshold narrative (architecture P2-2). carry-over 5건 = v5.15 PROPOSE.next_candidates#3~#7 (cycle 5 호출 / self-loop 분류 / § 3.1 baseline drift / audit agent 도구 권한 / harness-cost-tracker SPIKE 재평가). 모두 lightweight default 동결 정합 (v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium). 누적 동결 10 cycle (v5.7 ~ v5.16).

## narrative

### ROADMAP 등재 0건 — lightweight default 동결 정합

본 milestone 안 사용자 명시 신규 발의 부재. 모두 거명만 (lightweight default 동결, v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium). v5.7 ~ v5.16 누적 10 cycle 동결 사례 (feedback_section_6_2_abolished memory 정합).

### next_candidates 8건 분류

| ID | origin | trigger_condition | trigger_type |
|---|---|---|:-:|
| `architecture-section-4-end-paragraph-matrix-canonicalization` | v5.16 L1 + architecture P1-1 | § 4 끝 6건+ 누적 | C_improvement |
| `audit-output-markdown-lint-rule-expansion-md028` | v5.16 L2 도그푸드 재발 | cycle 5+ MD028 추가 또는 도그푸드 3 사례 | C_improvement |
| `external-audit-team-cycle-5-call` | v5.15#3 carry-over | upbit v1.20 완료 후 | C_improvement |
| `self-loop-classification-criteria-definition` | v5.15#4 carry-over | 추가 모호 사례 | C_improvement |
| `architecture-section-3-1-baseline-drift-cleanup` | v5.15#5 carry-over | 사용자 명시 | C_improvement |
| `audit-agent-tool-permission-enhancement` | v5.15#6 carry-over | 사용자 명시 | C_improvement |
| `harness-cost-tracker-spike-reevaluation` | v5.15#7 carry-over | 사용자 명시 | C_improvement |
| `r4-quantitative-threshold-narrative` | v5.16 architecture P2-2 | MD028 확장 milestone 동시 처리 | C_improvement |

### v3.10 부산물 통합 흡수 정합

- B (INTENT.out_of_scope 5건): agent 정의 본문 / 자동 fix 도구 / pre-commit rule 확장 / cycle 5 호출 / MD022/MD031/MD032 외 rule — 사실 진술만, 명령형 부재 ✅
- C (RESEARCH.untouched_files_explicit + risks_identified): 식별 risk 5건 — '재발의 candidate' 거명만, 명령형 부재 ✅
- D (DESIGN.decisions.rationale + phases.scope): 결정 기술 + 단계 범위 사실 — 명령형 부재 ✅

본 PROPOSE 안 origin 단일화 (v3.10 단일 origin 강제 정합).

## 관련

- INTENT: [INTENT.md](INTENT.md)
- REPORT: [REPORT.md](REPORT.md)
- v5.15 PROPOSE.md (carry-over 5건 origin)

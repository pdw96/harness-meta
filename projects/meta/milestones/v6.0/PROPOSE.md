---
id: ai-native-operation-reframe-and-entry-title-guideline
title: AI Native 운영 reframe + entry title 가이드 정전화
version: v6.0
stage: PROPOSE
status: completed
---

# PROPOSE — v6.0

## Spec

```json
{
  "next_candidates": [
    {
      "id": "milestone-artifact-json-field-reduction",
      "title": "milestone 산출물 JSON 필드 감축 (AI Native 시리즈 v6.1)",
      "trigger": "B_byproduct",
      "trigger_type": "INTENT.oos_2",
      "origin_milestone": "v6.0",
      "target_version": "v6.1",
      "description": "현 INTENT/RESEARCH/DESIGN/REPORT/PROPOSE 산출물 JSON 필드 수 30~50개 → 적정 10~15개 감축. AI 컨텍스트 효율 면 후속 milestone. INTENT.oos_2 origin. v6.0 entry title 가이드 (≤ 60자) 와 동질 — JSON 필드 본질 부합도 분석 + 통합/제거 후보 결정"
    },
    {
      "id": "cascade-auto-sync-mechanism",
      "title": "cascade 자동 동기 mechanism (AI Native 시리즈 v6.2)",
      "trigger": "B_byproduct",
      "trigger_type": "INTENT.oos_3",
      "origin_milestone": "v6.0",
      "target_version": "v6.2",
      "description": "현 v3.21 narrative 정전화 3 단계 패턴 (DESIGN 1차 + EXECUTE Edit + VERIFY grep) cycle 25 도그푸드 누적 — 수동 cascade 갱신 cycle cost 큼. cascade 6+ host 안 keyword 갱신 자동화 mechanism 검토 (hook 확장 또는 신규 cascade-sync agent). 다중 AI 협업 면 후속 milestone"
    },
    {
      "id": "claude-autonomous-milestone-proposal",
      "title": "Claude 자율 milestone 발의 mechanism (AI Native 시리즈 v6.3)",
      "trigger": "B_byproduct",
      "trigger_type": "INTENT.oos_4",
      "origin_milestone": "v6.0",
      "target_version": "v6.3",
      "description": "현 사용자 명시 발의 의무 → Claude 가 ROADMAP/CHANGELOG 읽고 다음 milestone candidate 자동 제안 mechanism. 사용자 명시 결정 게이트 보존 (AskUserQuestion '진행할까?'). 자율성 면 후속 milestone"
    },
    {
      "id": "audit-chain-hallucination-auto-correction",
      "title": "audit chain hallucination 자동 정정 mechanism (AI Native 시리즈 v6.4)",
      "trigger": "B_byproduct",
      "trigger_type": "INTENT.oos_5",
      "origin_milestone": "v6.0",
      "target_version": "v6.4",
      "description": "v5.18 Input Verification narrative + v5.13 fact 검증 절차 narrative 안 수동 정정 cycle 9+ 누적 — agent 가 자체 산출물 안 hallucination 자동 detect + 정정 mechanism 검토. 다중 AI 협업 면 후속 milestone"
    },
    {
      "id": "ai-native-3-dimension-integration",
      "title": "AI Native 3 면 통합 (시리즈 v7.0 major)",
      "trigger": "B_byproduct",
      "trigger_type": "INTENT.dependencies",
      "origin_milestone": "v6.0",
      "target_version": "v7.0",
      "description": "v6.1~v6.4 시리즈 완성 후 3 면 cross-mechanism 통합 — 컨텍스트 효율 + 자율성 + 다중 AI 협업 mechanism 사이 cross-ref + 통합 검증. v7.0 major bump (시리즈 통합)"
    },
    {
      "id": "entry-title-guideline-smoke-verification",
      "title": "smoke-spec-verification 안 entry title 가이드 4 원칙 자동 검증 (P2 후속)",
      "trigger": "D_design",
      "trigger_type": "DESIGN.D11_p2",
      "origin_milestone": "v6.0",
      "target_version": "v6.1 또는 v6.2",
      "description": "DESIGN.D11 P2 — smoke 안 ROADMAP milestones[] entry + CHANGELOG bullet header 안 title 길이 (≤ 60자) + active form (동사 시작) 자동 검증 추가. 향후 long-title 재발 회피 mechanism"
    }
  ]
}
```

## PROPOSE summary

v6.0 = AI Native 운영 reframe 시리즈 첫 milestone. 정의 + entry title 가이드 + 7 retitle (self-dogfood) + cascade 6 host. 후속 시리즈 5건 (v6.1~v6.4 + v7.0) 예약 — 컨텍스트 효율 / 자율성 / 다중 AI 협업 3 면 각 면 별 mechanism 후속 milestone. 추가 P2 후속 1건 (entry title smoke 자동 검증). v6.0 첫 원안 폐기 narrative 자연 흡수 = INTENT.dep_5 + REPORT.lessons_learned L1.

## Archival cycle

- **current_milestones_count**: 6
- **completed_count**: 3
- **recent_3_preserved**: v6.0 (본, completed 후), v5.21, v5.20
- **archival_action**: v5.19 entry 이미 본 milestone phase-1 안 archival 완료 (D12). v6.0 completed 후 milestones[] = v6.0 completed + v5.21 + v5.20 + deferred 3 = 6 entry. recent 3 정합 — 추가 archival 부재

## 시리즈 outline 시각화

```
v6.0 (본) — 정의 + entry title 가이드 + 7 retitle + cascade 6 host  ✅
  ↓
v6.1 — milestone 산출물 JSON 필드 감축 (컨텍스트 효율)
  + entry title smoke 자동 검증 (P2 후속, v6.1 또는 v6.2)
  ↓
v6.2 — cascade 자동 동기 mechanism (다중 AI 협업)
  ↓
v6.3 — Claude 자율 milestone 발의 mechanism (자율성)
  ↓
v6.4 — audit chain hallucination 자동 정정 mechanism (다중 AI 협업)
  ↓
v7.0 — AI Native 3 면 통합 (major bump)
```

각 후속 milestone 발의 시 ARCHITECTURE.md § 7.1 안 3 면 매트릭스 안 어느 면을 향상시키는지 명시 의무 (§ 3.6 5요소 매트릭스 평가 절차 정합).

## 관련

- INTENT: [`INTENT.md`](INTENT.md) (oos_2 ~ oos_5 origin)
- DESIGN: [`DESIGN.md`](DESIGN.md) (D11 P2 origin)
- REPORT: [`REPORT.md`](REPORT.md) (lessons_learned 통합)
- ROADMAP next_candidates[] (등재 위치): [`../../ROADMAP.md`](../../ROADMAP.md)

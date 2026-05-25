---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: APPROVE
status: in_progress
---

# APPROVE — v6.1

## Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-19",
    "approved_decisions": ["D1: C4 Anthropic 하이브리드", "D2: YAML 5 필드", "D3: JSON id/title 제거", "D4: Markdown body 흡수", "D5: smoke 자동 식별", "D6: 2 phase 분할", "D7: mechanical 변환 규칙", "D8: cascade 6 host", "D9: smoke hardcode (외부 의존 없음)", "D10: phase-1 도그푸드", "D11: 5 관점 검토 inline"],
    "rationale": "사용자 명시 승인 (2026-05-19 round 7 답: '승인 — EXECUTE 진입'). 5 관점 pass-with-comments + decisive 0 + P1 5 + P2 1 흡수. C4 = ext_1~ext_3 + ext_5 Anthropic 직접 정합 × 2 + 효과 최고 (nested -83%) + 정합 최고."
  }
}
```

## 승인 trace — pre-PLAN 7 round 누적

| Round | 결정 |
|---|---|
| 1 (후보 선택) | "JSON 필드 감축" (2 candidate 중) |
| 2 (감축 기준) | "자연어 흡수" → 후 "접근 자체 재검토" 확장 |
| 3 (적용 범위) | "전체 backfill" → "active 27 건만" 축소 |
| 4 (유지 필드) | "접근 자체 재검토" (RESEARCH 외부 source 후 결정) |
| 5 (디렉토리 평탄화) | "v6.1 은 JSON 만, 디렉토리는 v6.2" |
| 6 (DESIGN 옵션) | "C4 Anthropic 하이브리드 (추천)" |
| **7 (APPROVE)** | **"승인 — EXECUTE 진입"** |

## EXECUTE 진입 trigger

본 APPROVE.md `approval.approved_by: "user"` + `date: "2026-05-19"` = smoke-scope-contract.sh approval gate 통과. phase-1 (smoke 갱신 + v6.1 자체 4건 도그푸드) 즉시 진행.

## 도그푸드 자기참조

본 APPROVE.md 는 phase-1 안 신규 schema 재작성 적용 — chicken-and-egg 회피 + v3.21 narrative 정전화 3 단계 패턴 cycle 26 도그푸드 정합.

## 관련

- DESIGN 11 결정: [`DESIGN.md`](DESIGN.md)
- INTENT/RESEARCH: [`INTENT.md`](INTENT.md) + [`RESEARCH.md`](RESEARCH.md)
- smoke-scope-contract approval gate: [`../../../../tests/smoke-scope-contract.sh`](../../../../tests/smoke-scope-contract.sh)
- memory: `feedback_approve_md_schema_wrap` (approval wrap 의무) + `feedback_iterative_pre_plan_review` (round 누적)

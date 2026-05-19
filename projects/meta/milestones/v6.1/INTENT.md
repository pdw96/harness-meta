---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: INTENT
status: in_progress
---

# INTENT — v6.1

## Spec

```json
{
  "goal": "milestone 산출물 (INTENT/RESEARCH/DESIGN/VERIFY/REPORT/PROPOSE) 의 JSON 필드 부풀음을 정량 감축. C4 Anthropic 정합 하이브리드 채택 (DESIGN 결정). AI Native 운영 § 7 컨텍스트 효율 면 첫 실 적용.",
  "success_criteria": [
    {"id": "sc_1", "description": "JSON 필드 정량 감축 — 평균 32 top + 106 nested → ≤ 16 top + ≤ 20 nested 도달"},
    {"id": "sc_2", "description": "정보 손실 0 — 제거 필드 내용은 YAML frontmatter 또는 Markdown body 흡수"},
    {"id": "sc_3", "description": "smoke 7 hook 모두 PASS 유지 (YAML frontmatter parser + 자동 식별 추가)"},
    {"id": "sc_4", "description": "active 28 milestone backfill 완료 (meta v4.0~v6.0 27 + upbit v1.4 1, _archive 40 제외)"},
    {"id": "sc_5", "description": "도그푸드 — v6.1 자체 산출물에 신규 schema 적용 (v3.21 narrative 3 단계 패턴 cycle 26)"},
    {"id": "sc_6", "description": "smoke-spec-verification.sh 갱신 — YAML frontmatter 자동 식별 + 신규/현 schema 양립"}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "milestone 산출물 디렉토리 평탄화", "reason": "v6.2 별 milestone (ROADMAP next_candidates#1 등재 완료)"},
    {"id": "oos_2", "item": "_archive 40 건 backfill (v1.0~v3.21)", "reason": "역사적 보존 의도 (v4.0 phase-2 분리 정합)"},
    {"id": "oos_3", "item": "entry-title-guideline-smoke-verification", "reason": "v6.2 bundling 후보 (target_version v6.1→v6.2 shift)"},
    {"id": "oos_4", "item": "AI Native 시리즈 후속 (cascade 자동 동기 / 자율 발의 / hallucination 자동 정정)", "reason": "v6.3+ 별 milestone"},
    {"id": "oos_5", "item": "신규 schema --fix mode 자동 정정", "reason": "smoke-spec-verification --fix 미지원 (현 직접 호출). 향후 별 milestone."}
  ]
}
```

## Motivation

사용자 명시 발의 (A_user, 2026-05-19) — v6.0 INTENT.oos_2 origin + ROADMAP next_candidates#1. 실측 평균 26 필드/산출물 (DESIGN 42 최대, RESEARCH 31). AI Native 시리즈 (v6.0 정의 → v6.1 JSON 필드 → v6.2 예약) 컨텍스트 효율 면 **첫 실 적용 milestone**.

pre-PLAN 7 round 누적 결정:

1. **후보 선택** — JSON 필드 감축 (entry title smoke 는 v6.2 와 bundling)
2. **감축 기준** — "자연어 흡수" → "접근 자체 재검토" 로 확장
3. **적용 범위** — active 28 (_archive 제외, 역사적 보존)
4. **유지 필드** — RESEARCH 외부 source 확인 후 결정
5. **디렉토리 평탄화** — v6.2 별 milestone (분리)
6. **DESIGN 옵션** — C4 Anthropic 하이브리드 채택
7. **APPROVE** — 승인

## Dependencies

- **dep_1**: pre-PLAN dialog 7 round (2026-05-19) — 사용자 결정 source
- **dep_2**: v6.0 INTENT.oos_2 + ROADMAP next_candidates#1 — origin
- **dep_3**: smoke-spec-verification.sh 강제 필드 schema (16 across 8 stage) — 보존 의무
- **dep_4**: ARCHITECTURE § 7 AI Native 운영 3 면 정의 (v6.0 정전화) — 컨텍스트 효율 면 cross-ref
- **dep_5**: memory `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` — 작업 톤 가이드
- **dep_6**: context7 `/websites/code_claude` library (Anthropic Claude Code docs) — RESEARCH 외부 source

## Harness engineering mapping

- **element**: Context (1차)
- **target**: (b) mechanism cross-ref 갱신 — § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref 갱신 (산출물 schema 효율)
- **rationale**: AI Native 운영 § 7.1 3 면 안 '컨텍스트 효율' 면 **첫 실 적용**. v6.0 = 정의, v6.1 = 첫 실 적용 cycle 2.

## 명료화

### 본 milestone 의 위치 — AI Native 시리즈 v6.1

| Version | 본질 | AI Native 면 |
|:-:|------|------|
| v6.0 (완료) | 정의 + entry title 가이드 | 정의 정전화 |
| **v6.1 (본)** | JSON 필드 감축 (Anthropic 하이브리드) | 컨텍스트 효율 |
| v6.2 (예약) | 디렉토리 평탄화 + entry title smoke 검증 | 컨텍스트 효율 + Verification |
| v6.3 (예약) | cascade 자동 동기 | 다중 AI 협업 |
| v6.4 (예약) | Claude 자율 발의 | 자율성 |
| v6.5 (예약) | hallucination 자동 정정 | 다중 AI 협업 |
| v7.0 (예약, major) | 3 면 통합 | — |

### 도그푸드 정합 (sc_5)

본 INTENT 는 phase-1 안 신규 schema 재작성 적용. v3.21 narrative 정전화 3 단계 패턴 cycle 26.

## 관련

- 1차 source: 2026-05-19 pre-PLAN round 7 (사용자 답 직접 인용 7건)
- origin: [`../v6.0/INTENT.md`](../v6.0/INTENT.md) oos_2 + [`../../ROADMAP.md`](../../ROADMAP.md)
- 강제 schema source: [`../../../../tests/smoke-spec-verification.sh`](../../../../tests/smoke-spec-verification.sh)
- AI Native 정의: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 7
- 5요소 매트릭스: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.3 Context 행
- memory: `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` + `feedback_token_efficiency_priority`
- milestones.md: [`milestones.md`](milestones.md)

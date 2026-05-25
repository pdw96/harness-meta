---
id: ai-native-operation-reframe-and-entry-title-guideline
title: AI Native 운영 reframe + entry title 가이드 정전화
version: v6.0
stage: INTENT
status: completed
---

# INTENT — v6.0

## Spec

```json
{
  "goal": "harness-meta repo 정체성을 'AI Native 운영' 시리즈 (v6.0 → v6.x → v7.0 ...) 로 reframe — 본 v6.0 = 시리즈 첫 milestone, '정의' + '작은 첫 변경 1건' 만. ARCHITECTURE.md 안 'AI Native 운영' 정의 신규 § 정전화 (3 면: 컨텍스트 효율 + 자율성 + 다중 AI 협업) + ROADMAP/CHANGELOG entry title 가이드 정전화 + 기존 가장 긴 long-title 3~5건 retitle.",
  "success_criteria": [
    {
      "id": "sc_1",
      "description": "ARCHITECTURE.md 안 'AI Native 운영' 정의 신규 § 정전화 — 1 paragraph + 3 면 매트릭스 (컨텍스트 효율 / 자율성 / 다중 AI 협업) 정의. v4.0 정체성 (composer + integrator + maintainer) 와 cross-ref (대체 아닌 보완)"
    },
    {
      "id": "sc_2",
      "description": "ROADMAP/CHANGELOG entry title 가이드 정전화 — 4 원칙: (a) 한 entry = 한 본질 (bundling 시 모자 본질만 title), (b) ≤ 60자 (한국어), (c) active form + 짧은 동사구 시작, (d) detail 은 summary 필드로 분리"
    },
    {
      "id": "sc_3",
      "description": "기존 가장 긴 long-title entry 3~5건 retitle — ROADMAP projects/meta/ROADMAP.md 안 milestones[] 안 가장 긴 title 부터. 본문은 summary 필드 안 흡수. trace 보존 (REPORT cross-ref)"
    },
    {
      "id": "sc_4",
      "description": "cascade host 동기 갱신 — ARCHITECTURE.md / CLAUDE.md / projects/meta/CLAUDE.md / CHANGELOG.md 안 'AI Native 운영' cross-ref + entry title 가이드 cross-ref"
    },
    {
      "id": "sc_5",
      "description": "회귀 0 — pre-commit 14 hook 모두 PASS, 기존 smoke 회귀 부재"
    },
    {
      "id": "sc_6",
      "description": "INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE schema smoke-spec-verification 통과 — 필드 누락 0 (memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap 정합)"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "9-stage 자동 전환 + per-stage 최소 권한 원칙 (PoLP) — v6.0 첫 원안 폐기",
      "reason": "사용자 명시 결정 (Stage E round 안 취소). 본질 = '워크플로우/산출물 지저분/복잡' 답답함의 직접 원인 아님. 향후 별 milestone (v6.x+) 안 재발의 가능. trace = 본 milestone Stage E round narrative + git log (원안 commit 부재)"
    },
    {
      "id": "oos_2",
      "item": "milestone 산출물 JSON 필드 수 감축 (INTENT/RESEARCH/DESIGN/REPORT/PROPOSE 안 30~50 필드 → 적정 10~15 필드)",
      "reason": "AI Native 시리즈 안 컨텍스트 효율 면 후속 milestone (v6.1 또는 v6.2). 본 milestone scope = entry title 만"
    },
    {
      "id": "oos_3",
      "item": "cascade 자동 동기 mechanism (현 v3.21 narrative 정전화 3 단계 패턴 수동 cycle)",
      "reason": "AI Native 시리즈 안 다중 AI 협업 면 후속 milestone. 본 milestone = 수동 cascade 그대로"
    },
    {
      "id": "oos_4",
      "item": "Claude 자율 milestone 발의 mechanism (ROADMAP 읽고 다음 milestone 자동 제안)",
      "reason": "AI Native 시리즈 안 자율성 면 후속 milestone. 본 milestone = 사용자 명시 발의 그대로"
    },
    {
      "id": "oos_5",
      "item": "audit chain hallucination 자동 정정 mechanism (v5.18 Input Verification narrative 자동화)",
      "reason": "AI Native 시리즈 안 다중 AI 협업 면 후속 milestone. 본 milestone = 수동 fact 검증 그대로"
    },
    {
      "id": "oos_6",
      "item": "ROADMAP entry 안 long-title 전체 retitle (15+ entry 일괄)",
      "reason": "본 milestone scope = 가장 긴 3~5건 만. 나머지는 archival cycle 발생 시 자연 갱신 또는 후속 milestone"
    }
  ]
}
```

## Motivation

사용자 명시 발의 (A_user, 2026-05-19 round 안 스무고개 round). 직접 인용 narrative: (1) '워크플로우/산출물 내용들이 너무 지저분하고 복잡해보임' — 첫 답답함 진술, (2) '파일 수보다는 구조 문제' + '파일/폴더 이름이 길고 너무 자세함, 이름만 읽어도 피로' — 답답함 구체화, (3) 'ROADMAP/CHANGELOG 안 entry title 문구' — 가장 자주 눈에 들어오는 long-text 위치, (4) '본질적으로는 AI Native하게 운영하기 위함' — 본질 reframe, (5) 자율성 면 '1+2+3 전부' + 다중 AI 협업 면 '전부다' — 모든 면 답답. 종합 = 한 milestone scope 으로 안 끝남, AI Native 운영 시리즈로 분리 + 본 v6.0 은 첫 milestone (정의 + 작은 첫 변경). v6.0 첫 원안 (9-stage 자동 전환 + PoLP) 은 사용자 명시 결정 게이트 (Stage E) 직전 취소 — Stage E round 안 사용자 비개발자 명시 + 스무고개 방식 선호 발의 (memory user_non_developer_role + feedback_iterative_dialog 신규 정전화).

## Dependencies

- **dep_1**: 스무고개 round (2026-05-19, 사용자 명시 발의 source) — reason: v6.0 본질 reframe 의 1차 source. INTENT.motivation 안 직접 인용 narrative 5건
- **dep_2**: v4.0 정체성 narrative — project harness composer + Claude Code ecosystem integrator + agent fleet maintainer — reason: 본 milestone 'AI Native 운영' 정의 = v4.0 정체성 보완 (대체 아님). cross-ref 의무
- **dep_3**: memory user_non_developer_role + feedback_iterative_dialog (2026-05-19 정전화) — reason: 본 milestone Stage F 안 실 작업 narrative 톤 가이드 — 사용자 비개발자 친화 표현 + 스무고개 방식 결정 게이트
- **dep_4**: ARCHITECTURE.md § 3 5요소 매트릭스 + § 4 끝 narrative 정전화 누적 매트릭스 — reason: 본 milestone 'AI Native 운영' 정의 위치 결정 + § 4 끝 row 추가 가능성 RESEARCH 안 분석
- **dep_5**: v6.0 첫 원안 산출물 (INTENT/RESEARCH/DESIGN/milestones.md, disk only, commit 부재) — overwrite 대상 — reason: 사용자 명시 결정 (overwrite 채택). 본 INTENT 가 첫 원안 overwrite

## Harness engineering mapping

- **element**: Trace (1차) + Context (2차)
- **classification_target**: (b) mechanism cross-ref 갱신 + (c) 정전 강화 — 'AI Native 운영' 정의 신규 § + entry title 가이드 = 정전 sub-mechanism 추가
- **rationale**: 본 milestone 본질 = Trace 메커니즘 (ROADMAP/CHANGELOG entry title 형식) 재정의 + Context 메커니즘 (AI 가 자료 흡수 시 컨텍스트 효율) 향상. § 3.3 5요소 매트릭스 안 Trace 행 (c) 정전 sub-mechanism 추가 (title 가이드) + Context 행 (b) mechanism cross-ref 갱신 (AI Native 운영 정의 cross-ref). v5.21 ROADMAP schema A2 (Trace 면 정전화) 와 직접 후속 — v5.21 = 'ROADMAP forward-looking 재정의', v6.0 = 'entry title 가이드 + 정의 정전화' = Trace 면 cycle 2 동일 본질

## 명료화

### 본 milestone 의 의미 — 시리즈 첫 milestone

v6.0 = **AI Native 운영 reframe 시리즈** 의 첫 milestone. 시리즈 전체 scope:

| Version | 본질 (예상) | 면 |
|:-:|------|------|
| **v6.0 (본)** | 정의 + entry title 가이드 + retitle 3~5건 | 컨텍스트 효율 (1차) + 정의 정전화 |
| v6.1 (예상) | milestone 산출물 JSON 필드 감축 | 컨텍스트 효율 |
| v6.2 (예상) | cascade 자동 동기 mechanism | 다중 AI 협업 |
| v6.3 (예상) | Claude 자율 milestone 발의 + 결정 게이트 자동화 | 자율성 |
| v6.4 (예상) | audit chain hallucination 자동 정정 mechanism | 다중 AI 협업 |
| v7.0 (예상, major) | 종합 — 3 면 cross-mechanism 통합 |  |

본 v6.0 = 시리즈 entry — 정의가 후속 milestone 발의 기준 (5요소 매트릭스 + AI Native 3 면). 작은 scope 정합 (lightweight 모드, 1 phase, 1 commit).

### v6.0 첫 원안 폐기 narrative

v6.0 첫 원안 = '9-stage 자동 전환 + per-stage 최소 권한 원칙 (PoLP) + 사전적 정의 1:1 매핑 강화'. 진행 = OPEN → INTENT → RESEARCH → DESIGN → 5 관점 검토 4 agent 호출 → 매트릭스 정정 + 명명 + 단일 source 결정 → Stage E 직전. 사용자 결정 = 'milestone 자체 재검토' 명시. round 안 사용자 비개발자 명시 + 스무고개 방식 선호. 본 milestone trace = git log 부재 (commit 부재) + 본 INTENT.dep_5 + Stage F 안 자연 overwrite.

### 비개발자 친화 톤

memory `user_non_developer_role` + `feedback_iterative_dialog` (2026-05-19 신규 정전화) 정합. 본 milestone 작업 narrative 안 jargon 회피 / 비유 사용 / 단계별 짚어가기 / 결정 부담 작게. 단 산출물 JSON schema 자체는 smoke-spec-verification 의무 정합 (필드 누락 0).

## 관련

- 1차 source narrative: 2026-05-19 round 스무고개 (사용자 답 5건 직접 인용)
- v5.21 PROPOSE.next_candidates#1 (v6.0 첫 원안 origin, 폐기됨)
- ARCHITECTURE.md § 3.3 5요소 매트릭스 (정의 위치 1 후보)
- v4.0 정체성 narrative — composer + integrator + maintainer (본 milestone 정의 보완 대상)
- memory: [`../../../../../.claude/projects/C--Users-qkreh-harness-meta/memory/user_non_developer_role.md`](../../../../../.claude/projects/C--Users-qkreh-harness-meta/memory/user_non_developer_role.md) + [`../../../../../.claude/projects/C--Users-qkreh-harness-meta/memory/feedback_iterative_dialog.md`](../../../../../.claude/projects/C--Users-qkreh-harness-meta/memory/feedback_iterative_dialog.md)
- milestones.md spec: [`milestones.md`](milestones.md)

---
id: milestone-v5.7-design
title: DESIGN v5.7
version: v5.7
stage: DESIGN
status: completed
---

# DESIGN — v5.7 spec-drift-spike-pattern-canonicalization

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "정전화 host 위치 = ARCHITECTURE.md § 6 본문 안 § 6.2 폐지 narrative paragraph 직후 + § 7 직전 (bold lead paragraph 형식, 표제 부재)",
      "rationale": "사용자 명시 결정 (Option A, 2026-05-16 round 1) — ARCHITECTURE.md 단일 source 강제 + cross-ref host 추가 zero. § 6 = '변경 시 주의 + era 정책' section 으로 운영 narrative section 정합 (정의 차원 § 3 와 분리). 표제 부재 = § 6.2 폐지 narrative (line 192 bold paragraph) 와 일관 형식.",
      "alternatives_rejected": [
        "Option B/C — harness-meta.md Stage C/D 안 절차 step 추가: INTENT.out_of_scope #5 (절차 자체 무변경) 위배 risk",
        "Option D — ARCHITECTURE 정전 + cross-ref 1줄: cross-ref host 추가 drift 위험 (lightweight cap LOC 안 cross-ref 포함 위험)",
        "§ 3.1 끝 paragraph 위치: § 3 = working definition (정의 차원), 본 milestone narrative = decisions cycle pattern (운영 차원) — section 책임 부합 약함",
        "§ 6.3 표제 부여: § 6.2 폐지 narrative 가 표제 부재 paragraph 형식 → § 6.3 표제만 단독 부여 시 numbering 어색"
      ]
    },
    {
      "id": "D2",
      "decision": "정전화 narrative 정확 문구 (markdown code block 1차 source, Stage F EXECUTE 안 Edit 그대로 삽입)",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 (DESIGN 1차 source + EXECUTE Edit + VERIFY grep) 도그푸드 적용 — 정확 문구 본 DESIGN 안 1차 source 박음 후 Stage F EXECUTE 안 Edit 으로 그대로 삽입.",
      "exact_text": "**spec-drift spike 패턴** (v5.7_spec-drift-spike-pattern-canonicalization, 2026-05-16): 외부 spec 안 정확 명시 부재 (context7 source narrative 표현 추정) 항목의 정정 cycle 3 단계 — (a) RESEARCH 단계 context7 source 추정 진행 (정확 spec 명시 부재 인식 + 추정 명시 의무) → (b) Stage D DESIGN 5 관점 spec-drift agent 검토 안 추정 risk 식별 → (c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정 → (d) DESIGN.decisions 또는 phase-{n}.md execution_notes 안 hardcode (정확 spec 값 string literal 명시, 동적 구성 회피). 자연 발현 origin 2건 — v4.2 = (a)→(b)→DESIGN 즉시 정정→(d) (Stage F 전 cycle, context7 standard pattern 정정), v5.6 = (a)→(b)→Stage F spike→(d) (Stage F 안 cycle, settings.json enabled key 검증). 정정 시점 차이 (DESIGN 즉시 vs Stage F spike) 는 spec 명시 부재 정도에 따라 자연 분기. ecosystem integrator 정체성 (§ 3.1 끝 paragraph) 직접 부합 — context7 spec 정합 가드레일. 자세히: [`milestones/v4.2/DESIGN.md`](milestones/v4.2/DESIGN.md) (D2 origin) + [`milestones/v5.6/DESIGN.md`](milestones/v5.6/DESIGN.md) (D10 origin) + [`milestones/v5.7/DESIGN.md`](milestones/v5.7/DESIGN.md) (정전화)."
    },
    {
      "id": "D3",
      "decision": "cross-ref 정책 = 단일 source (Option A, cross-ref host 추가 zero)",
      "rationale": "v3.20 D1 단일 source narrative 패턴 정합. CLAUDE.md (root) / 모듈 CLAUDE.md / harness-meta.md / AGENTS.md / README / GUARDRAILS cross-ref 추가 zero — drift 위험 회피 + lightweight LOC cap 정합.",
      "alternatives_rejected": [
        "Option D cross-ref 1줄: drift 위험 + cross-ref 위치 stale 가능성"
      ]
    },
    {
      "id": "D4",
      "decision": "phase 수 = 1-phase (정전화 narrative 단일 host paragraph 추가 = 1 commit)",
      "rationale": "v3.18/v3.20/v3.21/v4.3/v5.4 등 narrative 정전화 1-phase 패턴 정합. ARCHITECTURE § 6.1 line 180 (1-phase milestone 정합) narrative 직접 적용. milestones.md sub_milestones[0] 1 entry — phase-1 title 'ARCHITECTURE.md § 6 안 spec-drift spike 패턴 paragraph 1건 정전화' 로 교체.",
      "alternatives_rejected": [
        "2-phase 분할 (phase-1 narrative + phase-2 milestones.md 갱신): milestones.md sub_milestones[0] 갱신은 phase-1 commit 안 통합 가능 — 분할 부재"
      ]
    },
    {
      "id": "D5",
      "decision": "DESIGN 검토 운영 = Lightweight (5 관점 subagent 호출 생략)",
      "rationale": "사용자 명시 결정 (2026-05-16 round 1) — narrative 정전화 milestone (≤5 파일 + 충돌 부재 예상 + 도그푸드 자연성) 패턴 정합. v3.18/v3.20/v3.21/v4.3/v5.4 선례 정합. 자체 검토 narrative + DESIGN 안 정확 문구 1차 source 보장.",
      "alternatives_rejected": [
        "4 관점 (architecture + spec-drift + 회귀 risk + scope contract): scope 작음 → 호출 비용 vs 정확도 trade-off 불리",
        "3 관점 (architecture + spec-drift + scope contract): scope 작음 권고치 정합이나 사용자 lightweight 선택"
      ]
    },
    {
      "id": "D6",
      "decision": "§ 6.2 폐지 정합 narrative — 본 milestone narrative 안 폐지된 § 6.2 직접 거명 부재 (ecosystem integrator 정체성 직접 부합)",
      "rationale": "v4.0 도입 § 6.2 폐지 narrative 정합 (feedback_section_6_2_abolished 메모리). 본 milestone scope = spec-drift 가드레일 narrative 정전화 = ecosystem integrator 정체성 (context7 spec 정합 = ecosystem 정합) 직접 부합. workflow self-improvement 본질 미부합 검증 = D2 정확 문구 안 ecosystem integrator 정체성 cross-ref 명시.",
      "alternatives_rejected": [
        "§ 6.2 lightweight 모드 trigger 조건 거명 흡수: § 6.2 폐지 정합 위배 risk (메모리 정합)"
      ]
    },
    {
      "id": "D7",
      "decision": "도그푸드 narrative 표지 = REPORT.lessons_learned 안 표지 narrative",
      "rationale": "R2 mitigation. 본 milestone = narrative 정전화 milestone 으로 외부 spec 추정 자체 부재 → 정전화 대상 패턴 (spec-drift spike) 적용 사례 부재 (도그푸드 모순 표지). 다른 종류 도그푸드 = v3.21 narrative 정전화 3 단계 패턴 (DESIGN 1차 source + EXECUTE Edit + VERIFY grep) 자체 적용 (9 번째 cycle).",
      "alternatives_rejected": [
        "도그푸드 narrative 부재 (REPORT 안 거명 미루기): 모순 표지 lessons 의무 (v3.6 + v3.17 + v3.19 + v3.21 선례 정합)"
      ]
    },
    {
      "id": "D8",
      "decision": "VERIFY grep 키워드 = 3건",
      "rationale": "R5 mitigation. v3.21 narrative 정전화 3 단계 패턴 (c) VERIFY grep 키워드 = D2 정확 문구 안 cohesive 어휘 직접 추출. 3건 = (1) 'spec-drift spike 패턴', (2) '자연 발현 origin 2건', (3) 'ecosystem integrator 정체성'.",
      "alternatives_rejected": []
    },
    {
      "id": "D9",
      "decision": "INTENT~APPROVE commit 시점 = (b) Stage G VERIFY commit 안 포함 (기본값)",
      "rationale": "v3.1 L6 정합 — Stage G VERIFY commit 안 INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md 4건 포함 → 산출물 영구 보존 보장. 1-phase = phase-1 commit (narrative 정전화 단독) + Stage G chore commit (Stage B-G+H+I 통합) 2 commit 운용. v3.18+v3.20+v3.21+v4.3+v5.4 등 1-phase + lightweight 5 cycle 누적 evidence 정합.",
      "alternatives_rejected": [
        "(a) phase-1 commit 안 포함: 산출물 commit 시점 phase-1 안 통합 시 narrative + Stage B-E 산출물 묶음 — review 분리성 약화",
        "(c) 별도 chore commit: 추가 commit overhead"
      ]
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "ARCHITECTURE.md § 6 안 spec-drift spike 패턴 paragraph 1건 정전화 + milestones.md sub_milestones[] 동기 갱신",
      "scope": "ARCHITECTURE.md § 6 본문 안 § 6.2 폐지 narrative paragraph 직후 D2 정확 문구 Edit 1건 (bold lead paragraph 추가). 동시 milestones/v5.7/milestones.md sub_milestones[0] phase-1 title placeholder 교체.",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (§ 6 안 paragraph 1건 추가, ~12 line)",
        "projects/meta/milestones/v5.7/milestones.md (sub_milestones[0] title 동기 갱신)",
        "projects/meta/milestones/v5.7/execute/phase-1.md (phase-1 산출, status: complete)"
      ],
      "rationale": "1-phase 정전화 단일 host paragraph 추가. v3.18+v3.20+v3.21+v4.3+v5.4 narrative 정전화 1-phase 패턴 정합.",
      "risks": [
        "R3 host 위치 충돌 (D1 결정 흡수)",
        "R5 VERIFY grep 키워드 (D8 결정 흡수)"
      ]
    }
  ]
}
```

## Approach

ARCHITECTURE.md § 6 본문 안 § 6.2 폐지 narrative paragraph 직후 + § 7 직전 위치에 'spec-drift spike 패턴' bold lead paragraph 1건 정전화 (Option A 단일 source). v3.21 narrative 정전화 3 단계 패턴 도그푸드 적용 — 본 DESIGN 안 D2 정확 문구 1차 source + Stage F EXECUTE 안 Edit 그대로 삽입 + VERIFY 안 grep 키워드 3건 검증. lightweight 모드 (5 관점 subagent 생략) + 1-phase 1+1 commit. cross-ref host 추가 zero (단일 source 강제).

## Risk mitigation

- risk: R1 § 6.2 폐지 정합; mitigation: D6 — narrative 안 § 6.2 직접 거명 부재 + ecosystem integrator 정체성 cross-ref
- risk: R2 도그푸드 모순; mitigation: D7 — REPORT.lessons_learned 안 표지 narrative + v3.21 narrative 정전화 3 단계 패턴 적용 도그푸드 (9 번째 cycle)
- risk: R3 host 위치 충돌; mitigation: D1 — 사용자 명시 결정 게이트 (Option A 채택)
- risk: R4 LOC ~500 line; mitigation: D4 + D5 — 1-phase + lightweight 모드 자연 정합 추정
- risk: R5 VERIFY grep 키워드; mitigation: D8 — 3 키워드 명시 (cohesive 어휘 D2 정확 문구 안 직접 추출)
- risk: R6 spec-drift 위험 항목 정의 미모호; mitigation: D2 정확 문구 안 '외부 spec 안 정확 명시 부재 (context7 source narrative 표현 추정)' 정의 1줄 (v4.2 + v5.6 두 사례 정량 evidence)

## Review policy

- **mode**: lightweight
- **rationale**: 사용자 명시 결정 (D5). narrative 정전화 milestone + scope ≤5 파일 + 충돌 부재 예상 + 도그푸드 자연성 패턴 정합 (v3.18/v3.20/v3.21/v4.3/v5.4 선례).
- **subagent_review**: skipped
- **self_review_summary**: 본 milestone 은 narrative 정전화 단일 source (Option A, ARCHITECTURE.md § 6 paragraph 1건). 절차 본문 변경 zero, smoke 추가 zero, cross-ref host 추가 zero. INTENT.success_criteria 7건 모두 narrative 산출물 안 자연 검증 가능. R1~R6 risk 모두 D1~D9 결정 안 흡수. 도그푸드 모순 표지 (D7) 안 lessons 흡수. ecosystem integrator 정체성 (§ 3.1 끝 paragraph) 직접 부합 narrative (D6).

## narrative

Stage D — DESIGN 완료. 사용자 명시 결정 2건 (D1 Option A + D5 Lightweight) 흡수.

본 DESIGN 안 D2 정확 문구 = ARCHITECTURE.md § 6 안 정전화 narrative 1차 source. Stage F EXECUTE 안 Edit tool 안 D2 `exact_text` 필드 그대로 삽입 (v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source + (b) EXECUTE Edit 도그푸드 9 번째 cycle).

Stage D 완료 직전 의무 step (v3.5 phase-2 도입) — `milestones/v5.7/milestones.md` `sub_milestones[0].title` placeholder 교체는 Stage F phase-1 commit 안 통합 실행. DESIGN.phases[0].affected_files 안 명시.

다음 Stage E — APPROVE 게이트 진입.

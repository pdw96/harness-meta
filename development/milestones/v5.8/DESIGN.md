---
id: milestone-v5.8-design
title: DESIGN v5.8
version: v5.8
stage: DESIGN
status: completed
---

# DESIGN — v5.8 identity-application-vector-audit

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "title": "narrative 정전화 위치 = ARCHITECTURE.md § 3.1 끝 정체성 paragraph 직후",
      "rationale": "사용자 결정 round 1 D1 = O1 (Recommended). 정체성 narrative (project harness composer + ecosystem integrator + agent fleet maintainer) 직접 cross-ref + v3.18 D1 단일 source 패턴 + v3.20 D1 단일 source 패턴 정확 정합. § 6 끝 (v5.7 spec-drift spike paragraph 직후) 후보는 정체성 paragraph 와 거리 — 정체성 cross-ref 약함. 단일 host = § 3.1 끝 line 75 직후 + § 3.2 (line 77) 직전.",
      "scope": "single_source_canonicalization"
    },
    {
      "id": "D2",
      "title": "정확 문구 = bold lead paragraph 1건 (~15 line), markdown code block 1차 source (round 4 보강 진단 5건 흡수 전면 재작성)",
      "exact_text": "**정체성-운용 vector drift 수용** (v5.8_identity-application-vector-audit, 2026-05-17): 위 § 3.1 끝 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 도입 (v4.0, 2026-05-13) 후 ~4일 운영분 수 = 12 meta milestone (v4.0~v5.7, 100% self-loop = 9785 LOC 안 mechanical install/Plugin 44.1% + agent fleet evolution 22.2% + 정체성 pivot 19.0% + RESEARCH/narrative 14.7%) + 1 외부 적용 (upbit v1.17, 2026-05-14, `/harness-meta upbit --audit` audit-team chain 5 멤버 완전 작동 + 12 항목 mechanical apply, evidence 강력) = 13 / 12 self-loop = 92.3%. 운용 부합도 sub-metric (가중 평균 77.5%) — composer 50% × 0.4 (audit-team 작동 evidence 강력 / 빈도 1/13) + integrator 60% × 0.3 (spec drift detection 5건 / 벤치마크 routine 0건) + maintainer 70% × 0.3 (fleet 진화 3건 / 분할·통합·삭제 0건). drift 본질 = v5.0 Plugin pivot (2026-05-14) 자기 강화 cascade — spec-drift 자기 detect (v5.1/5.2/5.4) + environment-auditor 자기 진화 (v5.5/5.6) + narrative 정전화 자기 강화 (v5.7) 3축이 Plugin spec 자체를 self-recruit attractor 화. 가드레일 진화 trend = v3.6 § 6.2 강한 정책 → v3.17 PROPOSE 거명 약 → v3.19/v5.8 narrative 흡수 medium (v4.0 § 6.2 폐지로 strong 가드레일 자체 부재). drift 수용 — 진단 결과 narrative 정전화 (본 paragraph) 가 default, § 6.2 (v4.0 폐지) 재도입 등 실 가드레일 변경은 evidence-base trigger 만 (cycle 4 trigger 조건 = 외부 적용 5건 추가 누적 ∧ 사용자 명시 발의 AND, 현 reverse evidence 6건 누적 = deferred 동결 정량 정당화). 자세히: [`milestones/v5.8/RESEARCH.md`](milestones/v5.8/RESEARCH.md) 정량 1차 source + 보강 분석 § A1~A9.",
      "rationale": "사용자 round 4 결정 (2026-05-17, '디테일 분석' 요청 → '전면 재작성' 선택) 흡수 — 보강 진단 5건 (외부 vector 1건 evidence 강력 / 가중 평균 77.5% sub-metric / attractor cascade 자기 강화 / 가드레일 진화 trend / reverse evidence 6건 누적) 완전 반영. v3.21 narrative 정전화 3 단계 패턴 정확 정합 — (a) DESIGN.D2.exact_text 1차 source markdown code block + (b) Stage F EXECUTE Edit 정확 삽입 + (c) VERIFY grep 키워드 (D7). bold lead + 정량 sub-metric + attractor 본질 + 가드레일 진화 + cycle 4 trigger 조건 + reverse evidence + RESEARCH 1차 source link 포함."
    },
    {
      "id": "D3",
      "title": "phase 분할 = 1-phase (도그푸드 패턴)",
      "rationale": "v3.18/v3.20/v3.21 1-phase 1+1 commit 도그푸드 패턴 정확 정합 (자기 검토 라운드 lightweight 모드 누적 패턴). single source + 단일 narrative paragraph 추가 = phase 다중 분할 부적합. v3.x 1-phase 비율 70.6% (v3.17 진단) + v3.18~v3.21 100% 1-phase 연속.",
      "scope": "single_phase"
    },
    {
      "id": "D4",
      "title": "cascade 정책 = 단일 source (다른 host 추가 cross-ref 0건)",
      "rationale": "v3.18 D1 단일 source 패턴 + v3.20 D1 단일 source 패턴 정확 정합. 다른 host (root CLAUDE.md / 모듈 CLAUDE.md / harness-meta.md / CHANGELOG / AGENTS / README / GUARDRAILS) cross-ref 추가 0. ARCHITECTURE.md § 3.5 단일 source 정합 narrative 직접 부합.",
      "scope": "no_cascade"
    },
    {
      "id": "D5",
      "title": "lightweight 모드 = 5 관점 subagent 생략 + 산출물 LOC cap + self_reference_policy: avoid 표지",
      "rationale": "v3.6 § 6.2 (폐지) 정신 계승 — workflow self-improvement 자기 검토 라운드 (v3.6/v3.17/v3.19 + 본 v5.8 = 4번째) lightweight 모드 누적 패턴. 5 관점 subagent (architecture/spec-drift/회귀 risk/보안/scope contract) 생략 + 자기 검토 3 round narrative (본 DESIGN 안 직접) + 산출물 총 LOC ~1500 미만 cap.",
      "scope": "self_review_avoid"
    },
    {
      "id": "D6",
      "title": "commit timing = (a) phase-1 mechanical 1 commit + Stage G+H+I 통합 chore 1 commit",
      "rationale": "v3.17/v3.18/v3.19/v3.20/v3.21 1+1 commit 도그푸드 패턴 정확 정합 (5 cycle 누적 strong evidence). phase-1 = phase-1.md 작성 + ARCHITECTURE.md Edit + milestones.md sub_milestones[0] 갱신 동시 1 commit. Stage G+H+I = VERIFY + REPORT + PROPOSE 산출물 + ROADMAP status completed 갱신 통합 chore commit.",
      "scope": "one_plus_one_commit"
    },
    {
      "id": "D7",
      "title": "VERIFY grep 키워드 3건 — '정체성-운용 vector drift 수용' / '가중 평균 77.5%' / 'Plugin pivot (2026-05-14) 자기 강화 cascade'",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 (c) VERIFY grep 검증 — 정확 문구 안 cohesive 키워드 직접 추출. 첫 키워드 = bold lead 정확 문구 (drift 수용 narrative lead) + 둘째 = 운용 부합도 sub-metric 가중 평균 (보강 진단 본질 정량) + 셋째 = attractor 본질 (drift 진단의 mechanism 핵심). 3 키워드 모두 D2.exact_text 안 1:1 매칭 + round 4 보강 진단 cohesive.",
      "scope": "verify_3_keywords"
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "ARCHITECTURE.md § 3.1 끝 안 '정체성-운용 vector drift 수용' paragraph 1건 정전화 + milestones.md sub_milestones[] 동기 갱신",
      "scope": "DESIGN.D2.exact_text 그대로 ARCHITECTURE.md § 3.1 끝 (line 75 직후 / line 77 직전) 삽입 1 Edit + milestones.md sub_milestones[0] placeholder → 확정 title + status pending → complete (commit hash 등재) + phase-1.md 작성",
      "affected_files": [
        "projects/meta/milestones/v5.8/execute/phase-1.md (신규)",
        "projects/meta/ARCHITECTURE.md (Edit 1건, line 75 직후 paragraph 추가)",
        "projects/meta/milestones/v5.8/milestones.md (sub_milestones[0] 갱신)"
      ]
    }
  ]
}
```

## Milestone

v5.8_identity-application-vector-audit

## Self reference policy

avoid

## Subagent review policy

skipped

## Approach

- **step_1**: phase-1.md 작성 — DESIGN.D2.exact_text 정확 인용 + ARCHITECTURE.md line 75 직후 (§ 3.2 line 77 직전) Edit target line 명시 + DESIGN.affected_files 정합
- **step_2**: ARCHITECTURE.md Edit — § 3.1 끝 Historical narrative paragraph (line 75) 직후 + § 3.2 헤더 (line 77) 직전 위치에 D2.exact_text 그대로 삽입
- **step_3**: milestones.md sub_milestones[0] 갱신 — title placeholder → 확정 title + status open → in_progress + commit hash 등재 (phase-1 commit 후)
- **step_4**: phase-1 1 commit — phase-1.md + ARCHITECTURE.md + milestones.md 동시 commit (conventional: feat(meta): v5.8 phase-1 — 정체성-운용 vector drift narrative 정전화)
- **step_5**: Stage G VERIFY — pre-commit 14 hook + grep 3 키워드 + criteria_check 7건
- **step_6**: Stage H REPORT — lessons_learned (self-loop 회피 표지 4 cycle / lightweight 누적 / narrative 정전화 10 cycle / 외부 vector 자연 발현 정정 / cycle 4 trigger 조건)
- **step_7**: Stage I PROPOSE — next_candidates 거명만 (ROADMAP 등재 0건)
- **step_8**: Stage G+H+I 통합 chore commit (chore(meta): v5.8 Stage B-I — INTENT+RESEARCH+DESIGN+APPROVE+VERIFY+REPORT+PROPOSE + ROADMAP completed)

## Risk mitigation

- R1 self-loop 모순 → D3 (1-phase) + D5 (lightweight + LOC cap + self_reference_policy: avoid) + D6 (1+1 commit 도그푸드) 3중 mitigation
- R2 진단 정정 (외부 audit-team 호출 0건 → 1건 정정) → D2 정확 문구 안 'upbit v1.17 자연 발현' 정확 정량 (12/13 = 92.3%) 명시
- R3 cycle 4 trigger 조건 → D2 정확 문구 안 hardcode (외부 적용 5건 추가 누적 ∧ 사용자 명시 발의 AND) — deferred 3건 narrative 와 정합
- R4 candidate_draft[] 작동 0건 → PROPOSE 거명만 (사용자 환경 의존, ROADMAP 등재 X)
- R5 § 6.2 재도입 검토 → D2 정확 문구 안 '실 가드레일 변경은 evidence-base trigger 만' narrative 흡수 + PROPOSE 거명만
- R6 markdown lint (MD032 등) → phase-1.md 작성 시 Edit 직접 검증 (v4.1 L6 lesson 정합)

## Approval gate

Stage E APPROVE.md 사용자 명시 승인 후 Stage F EXECUTE 진입. approval 객체 wrap 의무 (v5.7 L1 lesson 준수)

## 자기 검토 narrative (lightweight, 5 관점 subagent 생략)

### Round 1 — architecture 관점 자기 검토

정체성 narrative (§ 3.1 끝 paragraph) 직접 인접 위치 — composer/integrator/maintainer 3 역할 narrative 와 drift 진단 cross-ref 자연. v4.0~v5.7 narrative 시퀀스 (v4.0 정체성 → v4.2 mechanical 분리 → v5.0 Plugin pivot → v4.3 Historical narrative) 끝에 v5.8 drift 수용 paragraph 자연 chronological 추가. § 3.5 단일 source 정합 narrative 직접 부합 (D4 단일 source 정합).

### Round 2 — spec-drift 관점 자기 검토

context7 spec 검증 대상 부재 — 본 milestone 은 내부 정체성-운용 drift 진단이며 외부 spec (Claude Code Plugin spec / sub-agents docs / settings docs) 정정 부재. v5.7 spec-drift spike 패턴 (RESEARCH 추정 → DESIGN spec-drift 식별 → Stage F spike) 적용 대상 부재 — 본 진단은 정전화된 정체성 (v4.0) ↔ 실 운용 (v4.0~v5.7) 의 사실 진단이며 외부 spec 추정 부재.

### Round 3 — scope contract 관점 자기 검토 + 도그푸드 모순 narrative

본 milestone 자체가 self-loop 13/14 → 14/15 (v1.17 외부 1건 정정 적용 후 정확 count) 재현 = 도그푸드 모순 명시 인지. 회피 책임 = (a) 1-phase + (b) lightweight (5 관점 생략) + (c) self_reference_policy: avoid 표지 + (d) PROPOSE 거명만 (실 외부 vector trigger 발의 X). out_of_scope 6건 모두 PROPOSE 거명 또는 별 milestone 후속 — scope 위반 risk 0. 본 도그푸드 모순 narrative 자체가 v3.6/v3.17/v3.19 자기 검토 라운드 lightweight 패턴 4 번째 정합.

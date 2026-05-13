# PROPOSE — v3.17_phase-distribution-audit

```json
{
  "id": "v3.17_phase-distribution-audit",
  "next_candidates": [
    {
      "id": "v3.X_option-a-natural-adaptation-narrative",
      "title": "Option A — 현 상태 자연 적응 narrative 추가 (no workflow change)",
      "approach": "ARCHITECTURE § 6.1 bundling era 정의 + CLAUDE.md narrative 1줄 cross-ref — '1-phase milestone 도 본 era 정합 — sub_milestones[] listing 이 1 entry 라도 narrative 1차 source 책임 충족'.",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — RESEARCH 분포표 + L1 lesson cross-ref 명시.",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합)",
      "implication_lesson_cross_ref": ["L1", "L3"]
    },
    {
      "id": "v4.0_milestone-unit-rationalization",
      "title": "Option B — milestone 단위 합리화 (1-phase → rolling milestone phase, breaking major bump)",
      "approach": "v4.0_milestone-unit-rationalization 신 era 도입 — 1-phase milestone 을 상위 rolling milestone phase 로 편입 + ARCHITECTURE § 6.1 era 정책 재정의 + smoke era 분기 추가. v3.0 선례 정합 (v2 → v3 재구성).",
      "trigger": "D_design",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone 다수 (≥10건) + 사용자 명시 발의 AND. § 6.2 동결 trigger 조건 정합. 본 milestone L2 lesson 의 '3축 결정적 구분 어려움' 해소 데이터 필요.",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결, breaking change risk)",
      "implication_lesson_cross_ref": ["L2", "L3"]
    },
    {
      "id": "v3.X_6.2-freeze-policy-refinement",
      "title": "Option C — § 6.2 동결 정책 완화 (workflow self-improvement 한정 동결, 비-workflow 후속 candidate ROADMAP 자연 등재 회복)",
      "approach": "ARCHITECTURE § 6.2 'default 동결 권고' 를 'workflow self-improvement 한정 동결' 으로 한정 narrative. 비-workflow 후속 candidate 는 ROADMAP 자연 등재 → bundling source 회복. minor bump.",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone 다수 + 비-workflow vs workflow 분류 명확 trigger AND. release train 재발 risk 평가 필요.",
      "ROADMAP_등재": "거명만 (§ 6.2 동결 + 본 milestone 자체가 § 6.2 변경 후보 = workflow self-improvement)",
      "implication_lesson_cross_ref": ["L2"]
    },
    {
      "id": "v3.X_bundling-era-narrative-clarification",
      "title": "Option D — bundling era 명칭 narrative 1줄 정정 (1-phase 자연 적응)",
      "approach": "ARCHITECTURE § 6.1 bundling era 정의에 '1-phase milestone 도 본 era 정합 — sub_milestones[] listing 은 1 entry 라도 narrative 1차 source 책임 충족' narrative 1줄 추가. milestones.md 의 sub_milestones 1 entry 도 유효 정전화.",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — Option A 와 유사. Option A vs Option D 차이 = A는 narrative 1줄 cross-ref / D는 era 정의 자체 narrative 갱신. 통합 가능.",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합)",
      "implication_lesson_cross_ref": ["L1"]
    }
  ],
  "propose_summary": "v3.17 진단 결과 본 milestone 자체가 1-phase 1+1 commit lightweight 모드 도그푸드. 4 options (A/B/C/D) 모두 PROPOSE.next_candidates 거명만 — ROADMAP 등재 0건 (§ 6.2 default 동결 정합). 사용자 명시 발의 (A_user) 시 만 후속 milestone 진행 trigger. § 6.2 자기참조 동결 정책 정합 + v3.6/v3.13/v3.14 lightweight 모드 선례 4건 정합.",
  "trigger_conditions_narrative": "후속 milestone 발의 trigger 조건 — Option A/D: 사용자 명시 발의 만 (단순 narrative 추가). Option C: 외부 적용 milestone 다수 ∧ non-workflow vs workflow 분류 명확 trigger AND. Option B: 외부 적용 milestone 다수 (≥10건) ∧ 사용자 명시 발의 AND (breaking change risk 큼). 모든 옵션 § 6.2 default 동결 정합 (workflow self-improvement 후속).",
  "absorbed_origins": {
    "user_explicit": "사용자 명시 의문 'milestone 하나에 phase가 1개로 진행되는게 이해가 안 간다' (A_user trigger)",
    "stage_b_byproduct": "INTENT.out_of_scope 6건 (워크플로우 변경 / § 6.2 본문 / § 6.1 본문 / smoke / deferred cycle 3 / 5 관점 subagent) — 모두 사실 진술, 후속 발의 명령형 없음 (v3.10 정책 정합)",
    "stage_c_byproduct": "RESEARCH.untouched_files_explicit 5건 (claude/commands/harness-meta.md / ARCHITECTURE § 6.1 § 6.2 / tests/ / CHANGELOG) + RESEARCH.options 4 raw 분석 → PROPOSE next_candidates 4건 (1:1 매핑)",
    "stage_d_byproduct": "DESIGN.decisions 7건 (D1~D7) 사실 진술 + DESIGN.phases[0].scope 사실 진술 — 후속 발의 명령형 없음 (v3.10 정책 정합)"
  }
}
```

## narrative

본 milestone PROPOSE 는 **dual origin 통합 흡수 책임** (v3.10 정책 정합):

1. **사용자 명시 발의** (A_user trigger) — '1-phase 65% 의문' (정확 측정 후 70.6%) 자체.
2. **B/C/D 부산물** — INTENT/RESEARCH/DESIGN 안 사실 진술이 PROPOSE 단계에서 후속 milestone 명명 + ROADMAP 등재 책임.

본 milestone 은 4 options 모두 ROADMAP 등재 0건 (§ 6.2 default 동결 정합) — 후속 milestone 발의는 사용자 명시 발의 (A_user) 시 만.

# PROPOSE — v3.13 pending-milestone-renumber-policy

본 milestone 의 후속 forward (next_candidates + ROADMAP 등록). 9-stage workflow Stage I — backward 종합 (lessons) 은 REPORT.md 분리 책임 (v2.0_workflow-word-fidelity).

```json
{
  "id": "v3.13_pending-milestone-renumber-policy",
  "next_candidates": [],
  "next_candidates_named_only": [
    {
      "origin": "REPORT.lessons L1 (A_user trigger 재분류 narrative cascade 패턴)",
      "name_only": "trigger-reclassification-narrative-pattern",
      "candidate_summary": "기존 pending entry 의 trigger (D_design / B_regression / C_improvement) 가 § 6.2 발의 금지 조건과 충돌하는 경우 A_user 재분류 narrative cascade 절차 (renumbered_from + INTENT.motivation + dependencies + ROADMAP entry trigger) 4 위치 강화 narrative 정전화. § 6.2 default 동결 권고 직접 적용 — workflow self-improvement (claude/commands/harness-meta.md narrative 강화) 본질 + 외부 적용 데이터 부재 = 등재 부재. 외부 projects/<name>, name ≠ meta 실 적용 milestone 1건 완료 + 정량 데이터 기반 사용자 명시 발의 시 재검토.",
      "trigger_type_if_revived": "A_user (evidence-base)"
    },
    {
      "origin": "REPORT.lessons L2 (ROADMAP schema 신 필드 자유 추가 패턴)",
      "name_only": "roadmap-schema-deferred-status-formalization",
      "candidate_summary": "ROADMAP schema_note 필드 안 status enum (`pending` / `in_progress` / `completed` / `deferred`) 명시 + deferred_reason 필드 명문화. 현재 schema_note 는 v3.0+ 신 schema 구조만 명시, status 값 자유. § 6.2 default 동결 권고 (workflow self-improvement narrative 강화) — 등재 부재. 정량 evidence (다른 milestone 에서 deferred 패턴 누적) 시 재검토.",
      "trigger_type_if_revived": "C_improvement (evidence-base)"
    },
    {
      "origin": "REPORT.lessons L3 (milestones.md placeholder 검출 smoke 자동화)",
      "name_only": "milestones-md-placeholder-detection-smoke",
      "candidate_summary": "milestones.md sub_milestones[].title 안 'placeholder' / 'Stage D DESIGN' 키워드 검출 smoke 자동 차단. Stage D 완료 직전 의무 step (v3.5 phase-2) 의 narrative 1차 source 외 자동 강제 부재 mitigation. § 6.2 default 동결 권고 (workflow self-improvement + smoke 인프라 강화) — 등재 부재. 외부 적용 milestone 에서 placeholder 잔존 회귀 사례 발생 시 evidence-base trigger 충족 → 재검토.",
      "trigger_type_if_revived": "B_regression (evidence-base)"
    },
    {
      "origin": "REPORT.lessons L4 (forward-only renumber 패턴 narrative 정전화)",
      "name_only": "forward-only-renumber-procedure-formalization",
      "candidate_summary": "v3.0+ 9-stage-bundled era renumber 절차 (신 ROADMAP entry 추가 + 구 entry 제거 + renumbered_from 필드 + milestones.md 스켈레톤 + 산출물 9건) 의 narrative 1차 source 위치 정전화 — 현재 claude/commands/harness-meta.md Stage A step 6/7 + ARCHITECTURE.md § 6.1 forward-only 정책 분산. § 6.2 default 동결 권고 — 등재 부재. v3.11 (실 실행 renumber) + v3.13 (정책 결정 renumber) 2 사례 누적 = 3 사례+ 필요 시 evidence-base trigger 충족.",
      "trigger_type_if_revived": "C_improvement (evidence-base)"
    }
  ],
  "propose_summary": "본 milestone 의 4 lessons (L1~L4) 모두 workflow self-improvement 본질 (claude/commands/harness-meta.md narrative 강화 / smoke 인프라 / ROADMAP schema 명문화). § 6.2 동결 정책 + lightweight 모드 정책 직접 부합 — 4 후속 candidate 모두 거명만 (ROADMAP 등재 부재). 외부 projects/<name>, name ≠ meta 실 적용 milestone 1건 완료 + 정량 데이터 기반 사용자 명시 발의 시 재검토. 본 milestone PROPOSE 단계 자체가 § 6.2 정책 narrative 의 세 번째 적용 사례 (v3.6 도입 + v3.10 부산물 통합 흡수 + v3.13 default 동결 권고)."
}
```

## ROADMAP actual operation

1. ✅ v3.13 entry status 'in_progress' → 'completed' 갱신
2. ✅ v3.13 entry summary 갱신 (REPORT.summary + lessons 흡수)
3. ❌ next_candidates ROADMAP 등재 부재 (§ 6.2 default 동결 권고 적용 — 거명만)
4. (pending) 사용자 push 확인

## § 6.2 default 동결 권고 narrative 정합

v3.6_overengineering-audit § 6.2 도입 시 명시:

> Workflow self-improvement milestone 동결 정책 (v3.6 권고 #1): workflow self-improvement (claude/commands/harness-meta.md / tests/CLAUDE.md / 본 ARCHITECTURE.md § 4 변경) 만을 본질로 하는 milestone 은 evidence-base trigger 만 발의 허용 — release train (정기 narrative 강화) 또는 lessons_learned 자동 후속 등재로 발의 금지.

본 milestone PROPOSE 단계 본질 = REPORT.lessons L1~L4 의 자동 후속 등재 의무 검토. § 6.2 직접 적용 → 거명만 (`next_candidates_named_only`) + ROADMAP 미등재. v3.6 (workflow self-improvement 9/24 milestone 비율 진단) + v3.13 (3 후속 자동 등재 거부) = 비율 안정화 효과.

## 자기참조 회피 표지 (cascade 5 위치 cf. REPORT.md 4 위치 → +1)

본 PROPOSE.md 자체가 § 6.2 정책 narrative 의 세 번째 적용 사례 — 회피 표지 narrative 자체가 self-referential narrative chain 의 일부이나 lightweight 모드 정책으로 LOC cap 정합 (예상 합계 ~673 줄, baseline 850 미만).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- REPORT: [`REPORT.md`](REPORT.md)
- ARCHITECTURE § 6.2: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- § 6.2 도입 milestone: [`../v3.6_overengineering_audit/`](../v3.6_overengineering_audit/)
- A_user trigger 예외 첫 사용: [`../v3.10/`](../v3.10/)
- renumber 첫 사례: [`../v3.11/`](../v3.11/)

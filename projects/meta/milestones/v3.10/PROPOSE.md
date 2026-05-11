# PROPOSE — v3.10 stage-byproduct-clarification

```json
{
  "id": "stage-byproduct-clarification",
  "next_candidates": [
    {
      "id": "v3.11_phase-skeleton-template-strengthening",
      "title": "execute/phase-{n}.md skeleton template 명문화 — 'phase' 필드 의무 + smoke-spec-verification Stage 7 강제 narrative",
      "trigger_type": "B_regression",
      "trigger": "v3.10 REPORT.lessons_learned L2 source — phase-1.md 첫 skeleton 작성 시 'phase' 필드 누락으로 1st commit FAIL (smoke-spec-verification Stage 7). claude/commands/harness-meta.md Stage F (EXECUTE) 절차 안 phase-{n}.md 의무 필드 narrative 추가 또는 별 skeleton template 안 phase 필드 첫 위치 명시. § 6.2 default 동결 권고 적용 — workflow narrative 강화 카테고리, 외부 적용 정량 데이터 또는 추가 사용자 명시 trigger 대기.",
      "rationale": "L2 lessons 의 직접 후속. workflow self-improvement 카테고리이나 narrative 1~2줄 추가로 시정 가능 (작은 변경). § 6.2 정합 — release train 자동 등재 회피, ROADMAP 미등재 상태로 거명만."
    },
    {
      "id": "v3.11_section-6-2-narrative-clarification",
      "title": "ARCHITECTURE § 6.2 안 'A_user trigger' 예외 경로 narrative 명시 강화",
      "trigger_type": "C_improvement",
      "trigger": "v3.10 REPORT.lessons_learned L4 source — § 6.2 'workflow self-improvement 동결 정책' 안 'evidence-base trigger' 명시 + 'A_user trigger' 예외 경로 narrative 부재. v3.10 자체가 A_user 예외 첫 사용 사례 — § 6.2 narrative 보강 가치. § 6.2 default 동결 권고 적용 — workflow narrative 강화 카테고리, 사용자 명시 trigger 대기.",
      "rationale": "L4 lessons 의 직접 후속. § 6.2 narrative 자체 보강 — workflow self-improvement 카테고리, 자기참조 사이클 재진입 risk 보유. ROADMAP 미등재 권고."
    }
  ],
  "propose_summary": "본 milestone (v3.10_stage-byproduct-clarification) 결과 9-stage workflow 의 단어 = 단일 책임 1:1 매핑 원칙 narrative 보강 완료. 도그푸드 정합 (본 milestone 산출물 안 forward propose 명령형 부재) + § 6.2 A_user trigger 예외 경로 첫 사용 사례. 잔여 후속 candidate 2건 (L2 / L4 source) 은 § 6.2 default 동결 권고 정합 — PROPOSE 안 거명만, ROADMAP 등재는 사용자 명시 trigger 대기. v3.6 PROPOSE catalog 안 기존 거명 3건 (upbit_v1.1_upbit-cross-ref-cleanup_activation / v3.6_deferred_recheck / v4.0_breaking-change-candidates) 상태 유지 — 외부 적용 정량 데이터 trigger 대기."
}
```

## 비고

본 PROPOSE.md 26줄 (cap < 80줄 정합). next_candidates 2건 모두 (1) 본 milestone REPORT.lessons_learned 부산물 source — B/C/D 부산물 통합 흡수 책임 (v3.10 narrative 첫 적용 도그푸드). (2) § 6.2 default 동결 권고 정합 — ROADMAP 미등재, 거명만.

## actual operation

1. ROADMAP `milestones[]` v3.10 entry `status: "in_progress"` → `"completed"` 갱신 (Stage G+H+I 통합 commit 안 포함).
2. next_candidates 2건 — ROADMAP 등재 회피 (§ 6.2 default 동결 권고). PROPOSE.md 안 거명 상태로 보존.
3. 사용자 확인 (`AskUserQuestion`) → Stage G+H+I 통합 commit → push 여부 결정.

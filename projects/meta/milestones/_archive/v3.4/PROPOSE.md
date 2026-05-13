# PROPOSE — v3.4 open-stage-milestones-md-protocol

```json
{
  "id": "v3.4_open-stage-milestones-md-protocol",
  "next_candidates": [
    {
      "id": "v3.5_open-stage-discipline-strengthening (bundle, sub-milestone 2건 통합)",
      "title": "OPEN/DESIGN stage milestones.md 동시 생성 절차 강화 — cascade 검증 smoke + Stage D narrative 동기 (bundle)",
      "trigger": "B_regression",
      "trigger_type": "lessons_learned",
      "summary": "v3.4 lessons L1 + L3 의 의미 grouping bundle. sub-milestone 1 (B_regression, L3 후속) — cascade 검증 smoke 신규 검토: v3.4 phase-1 의 절차 명문화는 narrative 강제만, Claude 가 Stage A step 7 누락 시 OPEN 종료 시점 milestones.md 부재 + ROADMAP entry status: in_progress 불일치 발생 가능. 옵션 (a) 신규 smoke (smoke-open-stage-discipline.sh) 도입 사전 차단 vs (b) smoke-bundle-trigger 검증 책임 확장. sub-milestone 2 (C_improvement, L1 후속) — Stage D 절차 narrative 동기 갱신: v3.4 step 7 narrative 안 'Stage D DESIGN 후 milestones.md sub_milestones 동기 갱신 의무' 명시했으나 Stage D 절차 자체 미명시, Stage D 절차에 'phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신' step 추가 (Stage A step 7 와 cross-ref). 두 sub-milestone 모두 같은 모듈 (claude/commands/harness-meta.md) + 같은 주제 (OPEN/DESIGN 절차 강제) 의미 grouping 부합 → v3.5 bundle 단일 entry. v3.5 OPEN 단계에서 의미 grouping 최종 확정 + phases[] 분할."
    }
  ],
  "propose_summary": "v3.4 lessons L1 (narrative 1차 source 시점-위치 결합) + L3 (보조 검증 step 자동 강제력 보존) 의 직접 후속 — 의미 grouping 부합 (같은 모듈 + 같은 주제) 으로 v3.5 bundle 단일 entry (sub-milestone 2건 통합 후보) 운용. smoke-bundle-trigger 자동 강제 (같은 version 둘 이상 entry 금지) 가 본 PROPOSE 작성 중 ROADMAP 갱신 시점에 즉시 검출 (L8 — bundling 자동 강제 PROPOSE 단계 실시간 작동 사례). v3.5 OPEN 단계에서 phases[] 분할 (a/b 옵션 결정 + Stage D narrative 동기 step 추가) 확정."
}
```

## narrative

v3.4 lessons L1/L3 의 직접 후속 candidates → 의미 grouping 부합 으로 v3.5 bundle 단일 entry 등재. 처음에 v3.5 sub-milestone 2건을 별 ROADMAP entry 로 등재 시도 → smoke-bundle-trigger FAIL 자동 검출 (같은 version 둘 이상 entry 금지) → bundle 1건 entry 로 통합 → smoke PASS. 본 사례는 v3.1 phase-3 도입 smoke 의 PROPOSE 단계 실시간 자동 강제 사례 (lessons L8 후속 candidate 가능). v3.5 OPEN 단계에서 (a) cascade 검증 smoke 옵션 결정 + (b) Stage D narrative 동기 step 추가 의 phases[] 분할 확정.

ROADMAP entry status: completed 갱신 + v3.5 bundle entry pending 등록 완료 (본 PROPOSE 작성 시점 동기).

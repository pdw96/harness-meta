# INTENT — v3.13 pending-milestone-renumber-policy

본 milestone 의 의도 (goal / motivation / success_criteria / out_of_scope / dependencies). 단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity) — 구현 detail (phase list / 파일 list / commit 메시지) 은 DESIGN.md 로 미룸.

```json
{
  "id": "v3.13_pending-milestone-renumber-policy",
  "title": "v1.x pending 3건의 9-stage workflow 적용 정책 결정 — § 6.2 동결 정책 적용 + defer narrative",
  "goal": "v2.0 lessons next_candidates#1 origin 의 v1.x pending 잔여 3건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 의 era 명명 vs workflow 일치 정책을 § 6.2 동결 정책 적용 = 'defer + 외부 적용 데이터 대기' 로 확정하고 ROADMAP narrative 에 반영한다.",
  "motivation": "v2.0_workflow-word-fidelity 가 9-stage 단어 부합 정정을 도입한 직후 lessons next_candidates#1 로 v1.x pending 4건의 era/workflow 일치 검토가 자동 등재되었다. 이후 v3.0_milestones-restructure 가 v3.0+ 9-stage-bundled era forward-only 정책을 박았고 (§ 6.1), v3.11_legacy-narrative-cleanup 이 4건 중 1건 (v1.5_legacy-narrative-cleanup) 의 forward-only renumber 첫 사례를 만들었다. 잔여 3건은 모두 workflow self-improvement 본질 (claude/commands/harness-meta.md / hook 구조 / RESEARCH 템플릿 강화) — v3.6_overengineering-audit § 6.2 동결 정책 직접 적용 대상이다. § 6.2 발의 trigger 조건 (외부 projects/<name> 실 적용 milestone 1건 완료 후 정량 데이터 기반 명시 발의) 미충족 상태에서 본 정책 milestone 자체가 'lessons_learned 자동 후속 등재' 형태로 ROADMAP 에 잔존했다. 사용자 명시 발의 (A_user trigger 재분류, v3.10 예외 선례) 로 본 milestone 진입 → ROADMAP narrative 정합화 + 잔여 3건 명시 defer 처리로 정책 자기참조 충돌 해소.",
  "success_criteria": [
    "(SC1) projects/meta/ROADMAP.md milestones[] 안 v1.4_hook-narrative-separation entry status 'pending' → 'deferred'",
    "(SC2) projects/meta/ROADMAP.md milestones[] 안 v1.4_design-review-trace entry status 'pending' → 'deferred'",
    "(SC3) projects/meta/ROADMAP.md milestones[] 안 v1.5_research-cascade-grep-discipline entry status 'pending' → 'deferred'",
    "(SC4) 위 3건 entry 각각 deferred_reason 필드 추가 (§ 6.2 동결 정책 cross-ref + 재발의 trigger 조건 명시)",
    "(SC5) projects/meta/ROADMAP.md deferred_note 필드 갱신 — 본 milestone 결정 narrative 추가 (기존 v3.6 narrative + 본 v3.13 결정 누적)",
    "(SC6) projects/meta/milestones/v3.13/milestones.md sub_milestones[] DESIGN phases[] 1:1 동기 갱신 (placeholder title 교체)",
    "(SC7) pre-commit 14 hook 모두 PASS (회귀 0), pre-commit 우회 (--no-verify) 사용 부재"
  ],
  "out_of_scope": [
    "v1.4_hook-narrative-separation 의 실제 구현 (post-report-write.sh narrative 분리) — 외부 적용 데이터 대기 후 재발의 대상 (본 milestone 은 정책 결정만)",
    "v1.4_design-review-trace 의 실제 구현 (Stage E 5 관점 raw 출력 보존) — 외부 적용 데이터 대기 후 재발의 대상",
    "v1.5_research-cascade-grep-discipline 의 실제 구현 (RESEARCH 템플릿 grep 패턴 강화) — 외부 적용 데이터 대기 후 재발의 대상",
    "claude/commands/harness-meta.md / tests/CLAUDE.md / projects/meta/ARCHITECTURE.md § 4 변경 — 본 milestone 본질은 ROADMAP entry policy 적용, workflow 자체 변경 부재",
    "기존 deferred_note 안 거명된 v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 의 재발의 결정 — 본 milestone 본질 외 (이미 v3.6_overengineering-audit PROPOSE 안 default 동결 권고 적용 상태)",
    "§ 6.2 동결 정책 자체의 재검토 — § 6.2 도입 milestone (v3.6) 의 결정을 본 milestone 이 재검토 부재 (정책 적용만, 정책 자체 신규/변경 부재)"
  ],
  "dependencies": {
    "선행": [
      "v2.0_workflow-word-fidelity — lessons next_candidates#1 origin (본 milestone 의 ROADMAP entry 자동 등재 source)",
      "v3.0_milestones-restructure — forward-only era 정책 (§ 6.1) 도입, renumber 의무 root cause",
      "v3.6_overengineering-audit — § 6.2 workflow self-improvement 동결 정책 도입",
      "v3.10_stage-byproduct-clarification — A_user trigger 예외 첫 사용 사례 (본 milestone trigger 재분류 선례)",
      "v3.11_legacy-narrative-cleanup — v1.5 → v3.11 renumber 첫 사례 (renumbered_from 필드 컨벤션)"
    ],
    "후행": [
      "외부 upbit milestone 1건 실 적용 + 정량 데이터 → 사용자 명시 발의 시 v1.x pending 3건 재발의 (§ 6.2 trigger 조건 충족 후)"
    ]
  }
}
```

## 정의 매트릭스 매핑 (ARCHITECTURE.md § 3.6)

본 milestone 은 5요소 매트릭스 중 **Trace** 요소 보강 — ROADMAP `milestones[]` 의 정책 narrative 가 본 시점 결정의 영속 기록 source. (c) 분류 정전 요소 보강 (§ 6.2 동결 정책 적용 narrative 의 ROADMAP 영속 기록).

부수적으로 **Workflow** 요소 안 § 6.2 동결 정책의 두 번째 적용 사례 (첫 사례 = v3.6 도입 자체) — 정책 narrative 의 정합성 강화.

## Lightweight 모드 표지 (§ 6.2)

본 milestone 은 lightweight 모드 trigger 3건 충족 → `self_reference_policy: avoid` 표지 + 5 관점 subagent 검토 생략 + 산출물 LOC cap 정합:

1. ✅ 본질이 ROADMAP entry policy narrative 변경 (외부 프로젝트 적용 부재)
2. ✅ 변경 scope 작음 (ROADMAP.md 단일 파일, 1 phase)
3. ✅ 5 관점 의견 충돌 부재 예상 (architecture / 보안 분기 부재 — 단순 status flip + narrative 추가)

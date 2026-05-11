# v3.13 — pending-milestone-renumber-policy (sub-milestone listing)

본 파일은 v3.0+ 9-stage-bundled era 의무 산출물 (per version sub-milestone listing). Stage A OPEN step 7 시점 스켈레톤 작성 → Stage D DESIGN 단계 `phases[]` 확정 후 `sub_milestones[]` 1:1 동기 갱신 (placeholder title 교체).

```json
{
  "version": "v3.13",
  "title": "v1.x pending 3건의 9-stage workflow 적용 정책 결정 — § 6.2 동결 정책 적용 + defer narrative",
  "status": "in_progress",
  "self_reference_policy": "avoid",
  "self_reference_rationale": "Lightweight 모드 적용 (§ 6.2 trigger 3건 충족: ROADMAP entry policy narrative + 단일 파일 변경 + 5 관점 충돌 부재 예상). 본 milestone 본질은 정책 결정 — workflow 자체 변경 부재 (claude/commands/harness-meta.md / tests/CLAUDE.md / ARCHITECTURE.md § 4 변경 부재). § 6.2 동결 정책 적용 대상 = v1.x pending 3건 (workflow self-improvement) — 본 milestone 자체는 ROADMAP entry status 갱신 + narrative 적용.",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "ROADMAP entry 3건 deferred 처리 + deferred_note 갱신",
      "status": "complete",
      "commit": "a86334c"
    }
  ]
}
```

## 의도 요약

v2.0_workflow-word-fidelity lessons next_candidates#1 origin — v1.x pending 4건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline) 의 era 명명 (v1.x) vs workflow (9-stage) 일치 검토 milestone. v1.5_legacy-narrative-cleanup 은 v3.11 로 renumber 완료 (forward-only § 6.1 의무 첫 적용 사례). 잔여 3건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 은 모두 workflow self-improvement 본질 → v3.6_overengineering-audit § 6.2 동결 정책 직접 적용 대상. 사용자 명시 발의 (A_user trigger 재분류) 로 본 milestone 진입하되, 결정 결과 = "defer + 외부 upbit 적용 데이터 대기" 사실상 강제. ROADMAP `milestones[]` 의 3건 entry 갱신 (`status: "pending"` → `"deferred"` + `deferred_reason` 필드 + § 6.2 cross-ref) + `deferred_note` 갱신.

## 관련

- 상위 ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (version=v3.13, id=pending-milestone-renumber-policy)
- era 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 (9-stage-bundled forward-only) + § 6.2 (Lightweight 모드 + workflow self-improvement 동결)
- 선행 origin milestone: [`../v2.0_workflow-word-fidelity/REPORT.md`](../v2.0_workflow-word-fidelity/REPORT.md) (lessons next_candidates#1)
- renumber 선례: [`../v3.11/`](../v3.11/) (v1.5_legacy-narrative-cleanup → v3.11 forward-only)
- 동결 정책 도입 milestone: [`../v3.6_overengineering_audit/`](../v3.6_overengineering_audit/) (§ 6.2)
- A_user trigger 예외 첫 사용 사례: [`../v3.10/`](../v3.10/) (v3.10_stage-byproduct-clarification)

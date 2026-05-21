---
phase: phase-2
milestone: v7.0
status: completed
---

# v7.0 phase-2 — 9-stage workflow 정정 (mandate #3+#6+#7 흡수)

## Spec

```json
{
  "phase": "phase-2",
  "status": "in_progress",
  "scope": "9-stage workflow 정정 — (a) tests/smoke-scope-contract.sh L127 out_of_scope 빈 배열 차단 logic 정정 (mandate #3 lift, mini-cycle 차단) + (b) claude/commands/harness-meta.md Stage I PROPOSE next_candidates 강제 narrative lift (mandate #3) + (c) Stage D 5 관점 review subagent 호출 default narrative 정정 (mandate #6 PoLP) + (d) skills/stage-*/SKILL.md context-check cross-ref 1줄 inject (mandate #7 context rot 방지, ARCHITECTURE § 7.1 cross-ref 거명만, narrative 정전화 단일 source 정합)",
  "changes": [
    {
      "type": "edit",
      "path": "tests/smoke-scope-contract.sh",
      "description": "L127 out_of_scope 빈 배열 차단 logic 정정 — 빈 배열 허용 (v3.10 정책 + mandate #3 lift, mini-cycle 차단 evidence direct)"
    },
    {
      "type": "edit",
      "path": "claude/commands/harness-meta.md",
      "description": "Stage I PROPOSE narrative lift — next_candidates 강제 default → 사용자 명시 발의 시만 등재 narrative 정정 (mandate #3)"
    },
    {
      "type": "edit",
      "path": "claude/commands/harness-meta.md",
      "description": "Stage D narrative 정정 — 5 관점 review subagent 호출 default → inline self-review default + subagent 호출 = 사용자 명시 발의 (mandate #6 PoLP)"
    },
    {
      "type": "skip",
      "path": "skills/stage-*/SKILL.md",
      "description": "9 skill 안 추가 cross-ref 부재 결정 (mandate #5 정합 — mechanism 추가 default 폐기) + ARCHITECTURE § 7.1 4번째 면 (context rot 방지) 정전화로 단일 source 정전화 충분. EXECUTE 도중 scope 정정 = mini-cycle 차단 evidence cycle 2 (INTENT round 2 + 본 phase-2 도중 scope 정정)."
    }
  ],
  "verification": [
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "smoke-spec-verification PASS 432/0 + smoke-scope-contract PASS 98/0 (빈 배열 허용 verified) + smoke-cascade-drift PASS + smoke-entry-title-guideline PASS"
    },
    {
      "method": "manual",
      "result": "PASS",
      "detail": "(a) tests/smoke-scope-contract.sh L127 빈 배열 차단 logic 제거 + (b) harness-meta.md Stage I PROPOSE next_candidates 강제 default 폐기 narrative + (d) harness-meta.md Stage D 5 관점 review subagent 호출 default 폐기 narrative inject 정합. (c) skill cross-ref 추가 scope 정정 = mini-cycle 차단 cycle 2 evidence direct."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): v7.0 phase-2 — 9-stage workflow 정정 (mandate #3+#6+#7 흡수)"
  }
}
```

## Narrative

phase-2 = 9-stage workflow 정정 layer. mandate #3 (workflow 의무 lift) + mandate #6 (PoLP 정전화) + mandate #7 (context rot 방지) 흡수. 4 sub-edit 통합 1 commit (atomic, 같은 의미 단위 = workflow 정정).

핵심 = (a) smoke-scope-contract.sh L127 out_of_scope 빈 배열 차단 logic 정정 = v7.0 INTENT round 2 안 발현 mini-cycle 직접 차단 evidence direct + v3.10 정책 본 의도 정합 (사실 진술 없으면 비움). (b) harness-meta.md Stage I + Stage D narrative 정정 = mandate #3 + mandate #6 직접 실현. (c) skills/stage-*/SKILL.md = cross-ref 거명만 (ARCHITECTURE § 7.1 정전화 단일 source 정합, narrative 중복 회피).

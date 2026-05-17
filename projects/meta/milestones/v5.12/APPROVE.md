# APPROVE — v5.12 bundled-skill-narrative-cleanup

```json
{
  "id": "v5.12_bundled-skill-narrative-cleanup",
  "approval": {
    "approved_by": "user",
    "date": "2026-05-18",
    "approval_summary": "Stage E APPROVE 게이트 사용자 명시 승인 (2026-05-18). DESIGN.D1~D9 결정 흡수 + 4 관점 subagent 검토 결과 (architecture pass_with_comments / spec-drift fail with decisive issue 흡수 후 scope 재정의 / 회귀 risk pass / scope contract pass) 명시 승인. scope 9 파일 = active source 7 (agents/claude-docs-mapper.md + agents/harness-gap-analyzer.md + agents/component-proposer.md + agents/project-harness-audit-team/CLAUDE.md + bootstrap/agents/CLAUDE.md + bootstrap/claude-code-catalog/README.md + projects/upbit/audit-2026-05-14/proposal-draft.md) + drift origin 2 (projects/upbit/audit-2026-05-18/mapper-output.md + projects/meta/milestones/v5.10/diff-vs-v1.17.md). D2.exact_text = '`/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교'. 1 phase 1+1 commit 패턴 (phase-1 + Stage G+H+I 통합 chore). v5.7 spec-drift spike 3 단계 패턴 + v3.21 narrative 정전화 3 단계 패턴 도그푸드 14 번째 cycle. audit chain hallucination cycle 3 도달 = v5.11 PROPOSE#1 trigger 조건 충족 = PROPOSE.next_candidates#1 진급 narrative 흡수."
  },
  "design_round_summary": {
    "rounds": 2,
    "round_1": "사전 결정 round (Stage A 진입 전): D1 scope 7 파일 + D2 'bundled skill 별칭' + D3 v5.7 spec-drift spike 3 단계 + D4 외부 vector 포함. INTENT/RESEARCH/DESIGN 1차 작성.",
    "round_2": "Stage E APPROVE 게이트 5 관점 subagent 검토 → spec-drift agent decisive issue 발견 ('bundled skill 별칭' 표현 = spec drift) → 사용자 명시 결정 옵션 A 채택 (scope 재정의 + D2.exact_text 재작성 + v5.10 mapper-output.md 6 위치 + diff-vs-v1.17.md 1 위치 cascade 포함). INTENT/RESEARCH/DESIGN 재작성 cascade. scope 7→9 파일."
  },
  "five_perspective_review_summary": {
    "architecture": {"verdict": "pass_with_comments", "decisive_issues": 0, "recommendations": 3},
    "spec_drift": {"verdict": "fail (decisive issue 흡수)", "decisive_issues": 1, "decisive_issue_text": "DESIGN.D2 본질 본 milestone 의 정정 narrative 자체가 spec drift — 'bundled skill' 용어 misappropriation. APPROVE 전 D2 재작성 의무.", "absorbed": "scope 재정의 + D2.exact_text 재작성 + INTENT/RESEARCH/DESIGN cascade 갱신"},
    "regression_risk": {"verdict": "pass", "decisive_issues": 0, "recommendations": 3},
    "scope_contract": {"verdict": "pass", "decisive_issues": 0, "recommendations": 3}
  },
  "next_step": "Stage F EXECUTE phase-1 진입 — execute/phase-1.md 작성 + 9 파일 Edit (hybrid: inline 4 + footnote 5) + pre-commit 14 hook 검증 + commit (`feat(meta): v5.12 phase-1 — bundled-skill narrative cleanup 9 파일 정정 + audit chain hallucination cycle 3 mapper drift cascade`)"
}
```

## narrative

본 APPROVE 는 v5.12 milestone 의 사용자 명시 승인 게이트.

### round 1 → round 2 narrative

- **round 1** (Stage A 진입 전): 사용자 명시 결정 4건 (D1 scope / D2 'bundled skill 별칭' / D3 패턴 / D4 vector). INTENT/RESEARCH/DESIGN 1차 작성.
- **round 2** (Stage E APPROVE 게이트): 5 관점 subagent 호출 (사용자 명시 요구) → spec-drift agent decisive issue 발견 ('/review·/security-review·/init = bundled skill 별칭' = spec drift) → 사용자 명시 결정 옵션 A (scope 재정의) → INTENT/RESEARCH/DESIGN cascade 재작성.

### round 2 결정 narrative

- D2.exact_text 재작성: 'bundled skill 별칭' → 'Skill tool 안 discover + execute 가능 built-in command, bundled skill 범주 아님'
- scope 확장: 7 → 9 파일 (drift origin v5.10 mapper-output.md 6 위치 + diff-vs-v1.17.md 1 위치 추가)
- audit chain hallucination cycle 3 도달 = v5.11 PROPOSE#1 trigger 조건 충족 사실 진술
- PROPOSE.next_candidates#1 진급 narrative (forward-only policy 정합)

### Stage F EXECUTE 진입 게이트 통과

memory feedback_approve_md_schema_wrap.md 정합 = top-level `approval` 객체 wrap. smoke-spec-verification Stage 5 PASS 보장.

Stage F 진입 — execute/phase-1.md 작성 + 9 파일 Edit + smoke + commit.

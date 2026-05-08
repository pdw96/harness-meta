# EXECUTE phase-3 — v1.4_cross-ref-propagation

```json
{
  "phase": 3,
  "title": "GUARDRAILS.md 전면 재작성 (cross-ref + sessions/→milestones/ + bootstrap 제거 + H/C 7-stage 정합 + 신규 H10)",
  "status": "in_progress",
  "scope_from_design": "host 자체 정전화 — sessions/ 거명 0, bootstrap C2~C6 제거, H/C 매트릭스 7-stage 정합, 신규 H10 DESIGN.approval gate, § 4 Scope contract 7-stage 정합, § 1 목적 안 정의 cross-ref 1줄, § 6 References / Evolution sessions/ path 갱신",
  "affected_files": [
    "GUARDRAILS.md",
    "projects/meta/milestones/v1.4_cross-ref-propagation/execute/phase-3.md"
  ],
  "rewrite_plan": {
    "section_1": "목적 — sessions/meta/ → milestones/v{X.Y}_{slug}/ path 갱신 + § 1 안에 정의 cross-ref 1줄 추가 (root CLAUDE.md L8 verbatim)",
    "section_2": "금지 행동 (Hard rules) — H 매트릭스 재할당 (H1~H8). H7/H9 제거, H1/H6 path 갱신, H2~H5 keep, H8 (구 H8 .harness.toml schema) keep, 신규 H8 (구 H10) DESIGN.approval gate 부재 EXECUTE 진입 차단",
    "section_3": "위험 작업 (Confirmation 의무) — C 매트릭스 재할당 (C1~C4). C2~C6 제거 (bootstrap 부재), C2 자리 'bootstrap/skills/** 변경' (실제 존재 + opt-in install) 1줄 대체, C7 (5+ 파일 동시 변경) keep, C8 reframe (vX.0 major bump path 갱신)",
    "section_4": "Scope contract 의무 — 4-tier S#/T#/sessions verbatim 거명 제거. 7-stage 정합 (PLAN.md 의무 3 필드: success_criteria / out_of_scope / dependencies + DESIGN.approval gate)",
    "section_5": "Smoke 회귀 의무 — keep (smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift / smoke-projects-scope-discipline)",
    "section_6": "References — sessions/ path 갱신 + 정의 host 거명 추가",
    "section_evolution": "변경은 milestones/v{X.Y}_guardrails-{topic}/ 별개 milestone, 4-tier 'S3 scope' 거명 제거"
  },
  "expected_commit_message": "feat(meta): v1.4 phase-3 — GUARDRAILS.md 전면 재작성 (sessions/→milestones/, bootstrap 제거, H/C 7-stage, 신규 H8 DESIGN.approval gate)",
  "verification_post_commit": [
    "grep 'sessions/' GUARDRAILS.md → 0 hits (sessions/ 거명 제거)",
    "grep 'bootstrap/templates|bootstrap/install-project-claude|bootstrap/manifest-schema|bootstrap/docs' GUARDRAILS.md → 0 hits (부재 디렉토리 거명 제거)",
    "grep '하네스 엔지니어링 정의' GUARDRAILS.md → 1+ hit (정의 cross-ref 추가)",
    "grep 'DESIGN.approval' GUARDRAILS.md → 1+ hit (신규 H8 게이트 명시)",
    "grep 'milestones/v{X.Y}_{slug}' GUARDRAILS.md → 1+ hit (7-stage path)",
    "grep '하네스 엔지니어링은 agent 의 행동을' GUARDRAILS.md → 0 hit (정의 본문 복제 0, R1 mitigation)",
    "grep 'Context.*Workflow.*Constraint.*Verification.*Trace' GUARDRAILS.md → 0 hit table 형식 (cross-ref 1줄 안 5요소 거명만 OK)",
    "smoke pre-commit hook PASS (markdownlint / spec-verification / scope-contract / cross-ref / claude-md-drift)"
  ],
  "execution_notes": ""
}
```

## 진행

phase-3 = GUARDRAILS.md 전면 재작성 (사용자 결정 의문 round 2 + spec-drift agent 권고안 전체 채택). 변경량 가장 큼 (현재 92줄 → 추정 70~90줄). DESIGN.decisions[5] (spec-drift 권고안 전체) + DESIGN.decisions[6] (§ 4 7-stage 정합) + DESIGN.decisions[7] (신규 H10/H8 DESIGN.approval gate) 적용.

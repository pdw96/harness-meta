# REPORT — v1.1_smoke-precommit-rewrite

```json
{
  "summary": "v1.0_workflow-redesign 이후 비활성화됐던 smoke 4종(spec-verification / scope-contract / cross-ref / claude-md-drift)을 새 7-stage JSON 포맷 + projects/<name>/milestones/ 경로에 완전 정합하도록 재작성하고 pre-commit hook으로 재활성화했다. smoke-spec-verification은 Python JSON 추출로 5 artifact type x 필수 필드를 검증하고, smoke-scope-contract는 DESIGN.approval.approved_by='user' 게이트를 enforce한다. smoke-cross-ref는 제외 패턴 갱신과 함께 43건 pre-existing broken ref를 정리했으며, smoke-claude-md-drift는 MODULE_PATHS를 현재 4개 모듈로 갱신했다. 4 phase, pre-commit full-pass, 회귀 0건. 2026-05-08.",
  "delta": {
    "files_changed": 10,
    "files_added": 9,
    "files_deleted": 0,
    "modules_affected": [
      "tests/smoke-spec-verification.sh",
      "tests/smoke-scope-contract.sh",
      "tests/smoke-cross-ref.sh",
      "tests/smoke-claude-md-drift.sh",
      "tests/CLAUDE.md",
      ".pre-commit-config.yaml",
      "docs/adr/*.md (43건 broken ref 정리)",
      "GUARDRAILS.md, docs/ARCHITECTURE.md, bootstrap/skills/audit/harness-roadmap-update/SKILL.md",
      "projects/upbit/ARCHITECTURE.md",
      "projects/meta/milestones/v1.1_meta-as-project/execute/ (phase field 통일)"
    ]
  },
  "lessons_learned": [
    "smoke-cross-ref --fix 실행 전 dry-run으로 삭제 계획 확인 필수 — 일부 broken ref는 삭제보다 경로 갱신이 더 적절 (ADR-006:114 사례).",
    "smoke-claude-md-drift S4: root CLAUDE.md가 아닌 tests/CLAUDE.md를 참조해야 함 — 패턴 파일이 다른 모듈에 있을 때 S4 기준 파일 명시 필요.",
    "Stage 3 check 패턴: 리터럴 문자열보다 실제 파일에서 grep으로 확인 후 정확한 패턴 사용 ('DESIGN.approval' → 'approval.approved_by').",
    "v1.1_meta-as-project execute/ 파일이 '\"n\":' 필드 사용 — 이번 재작성으로 '\"phase\":' 표준 확립. 향후 산출물은 phase 필드 사용."
  ],
  "next_candidates": [
    {
      "id": "v1.1_post-report-write-hook-update",
      "trigger": "B_regression",
      "trigger_type": "regression"
    },
    {
      "id": "v1.1_design-phases-execute-tracking-automation",
      "trigger": "D_design",
      "trigger_type": "design"
    }
  ]
}
```

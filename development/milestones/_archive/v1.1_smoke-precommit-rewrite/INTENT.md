# PLAN — v1.1_smoke-precommit-rewrite

```json
{
  "id": "v1.1_smoke-precommit-rewrite",
  "title": "smoke + pre-commit hook 4종 재작성 (새 7-stage 포맷 정합)",
  "goal": "v1.0_workflow-redesign 이후 비활성화된 smoke 4종(spec-verification / scope-contract / cross-ref / claude-md-drift)을 새 7-stage JSON 포맷 + 새 경로(projects/<name>/milestones/)에 정합하도록 재작성/갱신하고, .pre-commit-config.yaml에서 재활성화한다.",
  "motivation": "현재 smoke 4종이 disabled 상태(4-tier sessions/ 경로 + 마크다운 섹션 포맷 가정)로 v1.0+ 7-stage 산출물을 전혀 검증하지 않고 있어, PLAN/RESEARCH/DESIGN/VERIFY/REPORT JSON schema 정합·DESIGN.approval 게이트·cross-ref 정합이 pre-commit 단계에서 무방비 상태다.",
  "success_criteria": [
    "smoke-spec-verification.sh: projects/*/milestones/ 하위 7-stage 산출물 JSON schema 필수 필드 검증 + PASS",
    "smoke-scope-contract.sh: PLAN.out_of_scope 비어있지 않음 + execute/ 존재 시 DESIGN.approval.approved_by='user' 게이트 + PASS",
    "smoke-cross-ref.sh: 제외 패턴 projects/*/milestones/v*/**/*.md 갱신 + PASS (broken ref 0건)",
    "smoke-claude-md-drift.sh: MODULE_PATHS 갱신(sessions/CLAUDE.md→projects/meta/CLAUDE.md) + S4 tests/CLAUDE.md 기준 정합 + PASS",
    "pre-commit run --all-files full-pass (4 hook 재활성화 포함)",
    "tests/CLAUDE.md smoke count + hook table 갱신"
  ],
  "out_of_scope": [
    "--fix 모드 신규 구현 (smoke-spec-verification / smoke-scope-contract — JSON auto-fix는 복잡도 과다)",
    "CI workflow (.github/workflows/ci.yml) 갱신",
    "smoke-bash-permission-pattern / smoke-thinking-effort 등 다른 smoke 수정",
    "새 smoke 추가"
  ],
  "dependencies": {
    "predecessor": "v1.1_agents-md-cleanup (completed)",
    "successor": "v1.1_post-report-write-hook-update (pending)"
  }
}
```

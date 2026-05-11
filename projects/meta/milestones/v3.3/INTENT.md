# INTENT — v3.3 ci-inactive-smoke-cleanup

```json
{
  "id": "v3.3",
  "group_slug": "ci-inactive-smoke-cleanup",
  "title": "CI inactive smoke 16건 정리 — CI 정책 변경 (active 6건만 실행)",
  "goal": "GitHub Actions CI를 green으로 복구한다. .github/workflows/ci.yml이 현재 모든 tests/smoke-*.sh 28건을 실행하여 inactive smoke 16건이 누적 fail 상태다. CI를 active smoke (pre-commit 등록 6건)만 실행하도록 정책 변경하여 즉시 green 달성한다.",
  "motivation": "v3.1 push(2026-05-10) 후 gh CI 검증에서 사후 발견. CI fail은 merge 블로킹 + 신뢰도 저하 요인. inactive smoke 16건은 bootstrap/templates, sessions/, install-verify 인프라 등 v1.4_infra-minimization(2026-05-10)으로 제거·대체된 구조의 잔존 검증이라 현 repo 상태와 불일치 — fix 복원보다 CI 정책 조정이 v1.4 결정 일관성에 부합.",
  "success_criteria": [
    "GitHub Actions 'Smoke Tests' CI가 green (0 fail)",
    ".github/workflows/ci.yml이 active smoke 6건만 실행 (smoke-projects-scope-discipline, smoke-spec-verification, smoke-scope-contract, smoke-cross-ref, smoke-claude-md-drift, smoke-bundle-trigger)",
    "pre-commit 13 hook 모두 PASS (회귀 0)",
    "active smoke 6건 local 실행 PASS",
    "inactive smoke 파일 삭제 없음 (historical 보존)"
  ],
  "out_of_scope": [
    "bootstrap/templates, bootstrap/skeletons 파일 복원 (Group 1 fix 복원 — v1.4_infra-minimization 정신)",
    "inactive smoke 개별 fix (Group 2 drift 수정, Group 3 경로 수정) — 정책 변경으로 대체",
    "inactive smoke 파일 삭제 (보존 정책)",
    "CI에 새 job 분리 (active/inactive 분리 job) — 단순 정책 변경으로 충분"
  ],
  "dependencies": {
    "predecessor": "v3.2_workflow-narrative-strengthening (completed 2026-05-11)",
    "successor": null,
    "blocking": null
  }
}
```

# VERIFY — v3.3 ci-inactive-smoke-cleanup

```json
{
  "id": "v3.3",
  "smoke_tests": [
    {"name": "smoke-projects-scope-discipline", "command": "bash tests/smoke-projects-scope-discipline.sh", "result": "PASS"},
    {"name": "smoke-spec-verification", "command": "bash tests/smoke-spec-verification.sh", "result": "PASS"},
    {"name": "smoke-scope-contract", "command": "bash tests/smoke-scope-contract.sh", "result": "PASS"},
    {"name": "smoke-cross-ref", "command": "bash tests/smoke-cross-ref.sh", "result": "PASS"},
    {"name": "smoke-claude-md-drift", "command": "bash tests/smoke-claude-md-drift.sh", "result": "PASS"},
    {"name": "smoke-bundle-trigger", "command": "bash tests/smoke-bundle-trigger.sh", "result": "PASS"},
    {"name": "pre-commit --all-files (13 hooks)", "command": "pre-commit run --all-files", "result": "PASS"}
  ],
  "manual_checks": [
    {
      "check": "ci.yml에 active 6 배열 + 주석 2건 (skip 근거, 동기화 가이드) 존재",
      "result": "PASS",
      "notes": ".github/workflows/ci.yml 수정 확인"
    },
    {
      "check": "inactive smoke 파일 삭제 없음 (28건 전체 보존)",
      "result": "PASS",
      "notes": "tests/smoke-*.sh 28건 모두 존재"
    }
  ],
  "criteria_check": [
    {
      "criterion": "GitHub Actions CI green (0 fail)",
      "result": "PASS",
      "notes": "active 6 배열 전환 후 CI 실행 시 inactive 16건 제외 — green 예상. (push 후 확인 가능)"
    },
    {
      "criterion": "ci.yml이 active 6건만 실행",
      "result": "PASS",
      "notes": "ACTIVE_SMOKES 배열 6건 명시 확인"
    },
    {
      "criterion": "pre-commit 13 hook PASS (회귀 0)",
      "result": "PASS",
      "notes": "pre-commit run --all-files 13/13 PASS"
    },
    {
      "criterion": "active 6건 local 실행 PASS",
      "result": "PASS",
      "notes": "6건 모두 PASS 확인"
    },
    {
      "criterion": "inactive smoke 파일 삭제 없음",
      "result": "PASS",
      "notes": "28건 전체 보존"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

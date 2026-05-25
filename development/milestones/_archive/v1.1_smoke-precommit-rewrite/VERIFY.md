# VERIFY — v1.1_smoke-precommit-rewrite

```json
{
  "smoke_tests": [
    {
      "name": "smoke-spec-verification.sh",
      "command": "bash tests/smoke-spec-verification.sh",
      "result": "pass",
      "output": "PASS=37 FAIL=0 SKIP=27 — v1.0~v1.1 JSON schema 전부 OK, legacy v1.84~v1.88 SKIP"
    },
    {
      "name": "smoke-scope-contract.sh",
      "command": "bash tests/smoke-scope-contract.sh",
      "result": "pass",
      "output": "PASS=12 FAIL=0 SKIP=10 — out_of_scope 전부 OK, approve gate 전부 user, harness-meta.md 안내 존재"
    },
    {
      "name": "smoke-cross-ref.sh",
      "command": "bash tests/smoke-cross-ref.sh",
      "result": "pass",
      "output": "PASS=1 FAIL=0 SKIP=0 — broken ref 0건"
    },
    {
      "name": "smoke-claude-md-drift.sh",
      "command": "bash tests/smoke-claude-md-drift.sh",
      "result": "pass",
      "output": "PASS=13 FAIL=0 — S1~S4 전부 OK (MODULE_PATHS 4건, count 29 정합)"
    },
    {
      "name": "pre-commit run --all-files",
      "command": "pre-commit run --all-files",
      "result": "pass",
      "output": "5 smoke hook 포함 12 hook 전부 Passed"
    }
  ],
  "manual_checks": [
    {
      "check": "smoke-spec-verification.sh Stage 1-5 PLAN/RESEARCH/DESIGN/VERIFY/REPORT 필드 검증",
      "result": "pass",
      "notes": "v1.0~v1.1 5개 milestone 37 check PASS. legacy v1.84~v1.88 자동 SKIP"
    },
    {
      "check": "smoke-scope-contract.sh Stage 2 approve gate: execute/ 존재 시 DESIGN.approval.approved_by='user'",
      "result": "pass",
      "notes": "v1.0~v1.1 5개 milestone 모두 user 승인 확인"
    },
    {
      "check": "docs/adr/*.md + GUARDRAILS.md + bootstrap/skills SKILL.md 43건 stale ref 정리",
      "result": "pass",
      "notes": "--fix로 자동 삭제. ADR-006:114 milestones/ → projects/meta/milestones/ 경로 수동 수정"
    },
    {
      "check": "smoke-claude-md-drift.sh S4 count 29 정합",
      "result": "pass",
      "notes": "tests/CLAUDE.md 28→29 갱신 + S4 tests/CLAUDE.md 기준으로 수정"
    },
    {
      "check": "v1.1_meta-as-project/execute/ phase-*.md '\"n\":' → '\"phase\":' 필드명 통일",
      "result": "pass",
      "notes": "3개 파일 갱신 — smoke-spec-verification Stage 6 PASS"
    }
  ],
  "criteria_check": [
    {
      "criterion": "smoke-spec-verification.sh: projects/*/milestones/ 7-stage JSON schema 검증 PASS",
      "result": "pass"
    },
    {
      "criterion": "smoke-scope-contract.sh: out_of_scope 비어있지 않음 + DESIGN.approval.approved_by='user' 게이트 PASS",
      "result": "pass"
    },
    {
      "criterion": "smoke-cross-ref.sh: 제외 패턴 갱신 PASS (broken ref 0건)",
      "result": "pass"
    },
    {
      "criterion": "smoke-claude-md-drift.sh: MODULE_PATHS 갱신 + S4 갱신 PASS",
      "result": "pass"
    },
    {
      "criterion": "pre-commit run --all-files full-pass (4 hook 재활성화 포함)",
      "result": "pass"
    },
    {
      "criterion": "tests/CLAUDE.md smoke count + hook table 갱신",
      "result": "pass"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

# EXECUTE phase-3 — smoke-scope-contract.sh 전면 재작성

```json
{
  "phase": 3,
  "title": "smoke-scope-contract.sh 전면 재작성 (out_of_scope 의무 + DESIGN.approval 게이트)",
  "status": "in_progress",
  "changes": [
    {
      "file": "tests/smoke-scope-contract.sh",
      "action": "rewrite",
      "description": "sessions/ 기반 로직 제거. 3 Stage 신규: Stage1=PLAN.out_of_scope 비어있지 않음, Stage2=execute/ 존재 시 DESIGN.approval.approved_by='user', Stage3=harness-meta.md DESIGN.approval 안내 존재."
    }
  ],
  "commit": null,
  "execution_notes": null
}
```

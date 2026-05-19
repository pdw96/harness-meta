# scanner-output (fixture — boolean-mismatch)

audit chain `project-scanner` 산출 모방 fixture — boolean fact 인용 1건 mismatch (cycle 2 v5.11 evidence 모방).

```json
{
  "project": "harness-meta",
  "claude_md_in_repo": false,
  "agents_md_in_repo": true,
  "roadmap_in_repo": true,
  "language": "python+shell"
}
```

본 fixture 호출 시 `audit_fact_verify.py` 가 `claude_md_in_repo: false` (stated) vs 실제 true (BOOLEAN_LOOKUP 결과) 검출 → exit 1 FAIL + mismatch 보고.

# scanner-output (fixture — boolean-normal)

audit chain `project-scanner` 산출 모방 fixture — boolean fact 인용 모두 1차 source 와 일치.

```json
{
  "project": "harness-meta",
  "claude_md_in_repo": true,
  "agents_md_in_repo": true,
  "roadmap_in_repo": true,
  "license_in_repo": true,
  "pre_commit_config_in_repo": true,
  "language": "python+shell"
}
```

본 fixture 호출 시 `audit_fact_verify.py` 가 5 boolean key 모두 정합 → exit 0 PASS.

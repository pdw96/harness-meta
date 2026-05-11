# execute/phase-1 — v3.8 inactive-smoke-cd-path-fix

```json
{
  "phase": 1,
  "title": "8개 inactive smoke dirname/.. → ../.. 수정 + tests/CLAUDE.md 정책 추가",
  "status": "in_progress",
  "changes": [
    "tests/_inactive/smoke-detect-language.sh:6 — cd ../.. 수정",
    "tests/_inactive/smoke-roi-regression.sh:7 — cd ../.. 수정",
    "tests/_inactive/smoke-backup-cleanup.sh:29 — REPO_ROOT fallback ../.. 수정",
    "tests/_inactive/smoke-bootstrap-agents-md.sh:11 — META_ROOT ../.. 수정",
    "tests/_inactive/smoke-bootstrap-render.sh:7 — META_ROOT ../.. 수정",
    "tests/_inactive/smoke-skills-install.sh:34 — REPO_ROOT fallback ../.. 수정",
    "tests/_inactive/smoke-sync-agents.sh:19 — REPO_ROOT fallback ../.. 수정",
    "tests/_inactive/smoke-python-entry-boilerplate.sh:21 — git rev-parse fallback ../.. 수정",
    "tests/CLAUDE.md — inactive smoke 경로 규약 1줄 추가 (spec-drift 권고 흡수)"
  ],
  "commit": null,
  "execution_notes": "bash -n 8/8 PASS. smoke-detect-language 6/6 PASS + smoke-roi-regression 6/6 PASS (대표 검증)"
}
```

---
name: harness-review
description: Harness change review checklist — 5 items: ARCHITECTURE/ADR compliance, test existence, CRITICAL rules, buildability. Called from /harness-ship step 10-2.
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Grep
model: sonnet
---

Review the changes in this project.

First read the following documents:
- `/CLAUDE.md`
- Project ARCHITECTURE document (e.g., `/docs/core/ARCHITECTURE.md` or `@~/harness-meta/projects/{name}/ARCHITECTURE.md`. Actual path is in CLAUDE.md import declarations)
- Project DECISIONS/ADR document (e.g., `/docs/core/ADR.md`)
- If changed files belong to current milestone scope, also check:
  - `/docs/scope/{version}/PRD.md`
  - `/docs/scope/{version}/ADR.md`

Then review the changed files against the checklist below:

## Checklist

1. **Architecture compliance**: Does it follow the directory structure defined in ARCHITECTURE?
2. **Tech stack compliance**: Does it stay within the technology choices defined in DECISIONS/ADR?
3. **Tests exist**: Are tests written for new functionality?
4. **CRITICAL rules**: Does it comply with the prohibition rules declared in the project `CLAUDE.md` CRITICAL section? (Rules are project-specific)
5. **Buildable**: Run project build verification commands (tests, type-check, lint) **each separately** (chaining with `&&` silently skips later steps when earlier ones fail):
   ```bash
   {test_cmd}        # .harness.toml [testing].test_cmd
   {type_check_cmd}  # .harness.toml [testing].type_check_cmd (optional)
   {lint_cmd}        # .harness.toml [testing].lint_cmd (optional)
   # See harness-ship.md section 10-2 for per-language examples
   ```

## Output format

| Item | Result | Notes |
|------|--------|-------|
| Architecture compliance | PASS/FAIL | {detail} |
| Tech stack compliance | PASS/FAIL | {detail} |
| Tests exist | PASS/FAIL | {detail} |
| CRITICAL rules | PASS/FAIL | {detail} |
| Buildable | PASS/FAIL | {detail} |

If there are FAIL items, immediately suggest specific remediation.

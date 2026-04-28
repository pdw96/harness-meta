---
name: harness-run
description: Harness stages 8~9 — UAT dry-run → project executor execution. Activated only by explicit /harness-run call.
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
model: sonnet
---

Harness stages 8~9: UAT dry-run → execute.py execution

**Orchestrator**: runs Bash directly. Delegates to Agent(model="sonnet") for error analysis.

## Pre-flight Gate

1. `phases/{version}/{phase}/PLAN.md` exists → if not, route to `/harness-plan`
2. `phases/{version}/{phase}/index.json` exists → if not, route to `/harness-design`
3. `phases/{version}/{phase}/step0.md` exists → if not, route to `/harness-design`
4. Count of steps in index.json = count of step*.md files → if mismatch, route to `/harness-design`

---

## 8. UAT

```bash
{executor} {version}/{phase-name} --dry-run
# {executor} is the value of `.harness.toml [harness].executor`.
# Per-language examples:
#   Python: python3 scripts/execute.py
#   Node:   pnpm tsx scripts/execute.ts
#   Go:     go run ./cmd/execute
#   Rust:   ./target/release/execute
```

Verify (return to design stage immediately on failure):
- Step files exist (step{N}.md)
- Step number continuity (0, 1, 2, ...)
- Document path validity (all `/docs/...` references match actual files)
- Prompt size (~150K tokens recommended)
- `[DRY-RUN] Total prompt: N chars` output for cost estimation

UAT is read-only — no lock, branch checkout, or index mutation.

## 9. Execute

After user approval:

```bash
{executor} {version}/{phase-name} --push-per-step
# See `.harness.toml [harness].executor`. Per-language examples same as dry-run above.
```

### Error recovery commands

| Command | Behavior | When to use |
|---------|----------|-------------|
| `--status` | Print progress only (no changes) | Check how far execution got |
| `--reset-step N` | Set step N alone to pending (later steps preserved) | API 500 or transient failure |
| `--from-step N` | Set step N through end all to pending | Design change, prior output invalidated |

### Error handling

1. **API 500 / timeout**: `--reset-step N` then re-run (not a code issue)
2. **Code error (3 retries all failed)**: Insufficient step.md instructions. Delegate error analysis to Agent(model="sonnet"):
   ```
   Agent(
     description="step N error analysis",
     model="sonnet",
     prompt="Compare stderr/exitCode in phases/{version}/{phase}/step{N}-output.json with step{N}.md to identify insufficient or contradictory instructions. Propose fix."
   )
   ```
3. **blocked**: User intervention needed (API key, external dependency, etc.). Resolve then `--reset-step N`

### After execution completes

**No commit/push.** Must run `/harness-ship` for review first.

Output guidance:
```
Execution complete. No commit/push before review.
Next: /harness-ship
If context low: /clear → /harness-ship
```

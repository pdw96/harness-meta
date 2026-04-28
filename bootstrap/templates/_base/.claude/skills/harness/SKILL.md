---
name: harness
description: Harness dispatcher — reads current phase state and guides next step. Activated only by explicit /harness call.
disable-model-invocation: true
argument-hint: ""
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit
model: sonnet
---

Harness dispatcher. On `/harness`, reads current state and guides the next step.

## Workflow

| Command | Stage | Model strategy |
|---------|-------|----------------|
| `/harness-plan` | 1~4: explore→requirements→discussion→PLAN.md | Code analysis: delegate to Agent(model="opus") |
| `/harness-design` | 5~7: design→7D→step files | Grey area + step gen: delegate to Agent(model="opus") |
| `/harness-run` | 8~9: UAT(dry-run)→execute | Error analysis: delegate to Agent(model="sonnet") |
| `/harness-ship` | 10: Goal-backward→/harness-review→REPORT→push | Stub analysis: delegate to Agent(model="sonnet") |

commands = lightweight orchestrators (handle user dialogue), heavy work = delegate to Agent(model=...).
**User dialogue (discussion, approval) is handled directly by the orchestrator. Never delegate to Agent.**

> For state-only lookup, the `harness-dispatcher` subagent is available
> (`.claude/agents/harness-dispatcher.md`). Prevents main context pollution. Routing is isolated.

## State determination (must run)

**Read** the following to decide the next step:

0. If `phases/index.json` does not exist → "phases/ needs initialization. Check ROADMAP.md and create index.json + milestone.json." then route to `/harness-plan`
1. `phases/index.json` → identify version of first milestone where status != "completed". If all milestones done → "All milestones complete. Add next milestone to ROADMAP.md."
2. `phases/{version}/milestone.json` → if missing, route to `/harness-plan`. Otherwise find first phase dir where status != "completed"
3. Check files in `phases/{version}/{phase-dir}/`:

| File check | Result | Next |
|-----------|--------|------|
| No directory or no PLAN.md | — | `/harness-plan` |
| PLAN.md exists, no step0.md | — | `/harness-design` |
| Steps exist + pending in index.json | — | `/harness-run` |
| All steps completed, no REPORT.md | — | `/harness-ship` |
| REPORT.md exists | — | Phase complete. Guide to next phase or milestone |

**State path to user** (e.g., "Target: `phases/v1.5/2-foo-phase/`, Next: `/harness-plan`")

## Safety Gates

Check before routing:
1. **Error state**: error/blocked step in index.json → guide `--reset-step N` or `--from-step N`
2. **Lock file**: `.harness.lock` exists → another run in progress if PID alive, dead PID auto-cleaned
3. **Previous phase incomplete**: phase without REPORT.md in previous milestone → warn
4. **Dry-run recommended**: validate structure/doc-refs/prompt size with `--dry-run` before full run

## Gate system

| Gate | Behavior | On failure |
|------|----------|------------|
| **Pre-flight** | Required files exist | Route to previous step |
| **Revision** | Output quality (7D, /harness-review) | Fix then re-validate (max 3x) |
| **Escalation** | Unresolvable | Wait for user decision |
| **Abort** | Fatal state | Halt immediately + preserve state |

## Anti-patterns

- **No checklist questions** — start broad, drill into concerns
- **No scope creep** — outside ROADMAP → "Separate phase. Add to backlog?"
- **No full file reads** — light read of project ARCHITECTURE/scope docs only. Heavy analysis to Agent
- **Orchestrator never executes directly** — routing only. Analysis/implementation belongs to each command
- **No git add -A** — stage specific files only

## Lessons Learned

- v0.1: Windows UTF-8 forced, docs 93% compressed, status non-update auto-error
- v0.2: unified stdin input=, dry-run branch, Stop hook removed
- v1.0: API 500 recoverable with reset-step, frozen+dict incompatibility → Optional fields
- harness: agents cannot dialogue with user → commands(orchestrator) + Agent(model=...) delegation pattern
- v0.1.1 (2026-04-17): atomic lock(O_EXCL)+signal cleanup, --from-step applied first, retry metric accumulation, dry-run mutation blocked

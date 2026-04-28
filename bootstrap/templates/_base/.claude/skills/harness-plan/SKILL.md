---
name: harness-plan
description: Harness stages 1~4 — explore→requirements→discussion→PLAN.md generation. Activated only by explicit /harness-plan call.
disable-model-invocation: true
argument-hint: "[version/phase-name]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write(phases/**/PLAN.md)
  - Edit(phases/**/PLAN.md)
  - Bash(mkdir *)
model: opus
effort: xhigh
---

Harness stages 1~4: explore → requirements → discussion → PLAN.md generation

**Role division:**
- **Orchestrator (this command) handles directly**: user dialogue (discussion, questions, approval), light file Read, Write
- **Delegate to Agent(subagent_type="harness-explore", model="opus")**: code analysis, exploration, call relationships / config / test coverage collection

## Pre-flight Gate

1. Read `phases/ROADMAP.md` → confirm next milestone version (if "next milestone TBD", ask user to fill ROADMAP)
2. Read `phases/index.json` → check version status
3. If `PLAN.md` already exists:
   - **Edit intent** (user stated) → Read existing PLAN.md, continue discussion, update PLAN.md at end
   - **Otherwise** → Guide "Next: `/harness-design`" and stop
4. After confirming version and phase-name: `mkdir -p phases/{version}/{phase-name}`

## 0. Milestone structure (new — moved from design)

Declare the full phase structure of the milestone before starting the plan. Reasons:
- Remove implicit "1 milestone = 1 phase" assumption
- Auto-determine need for worktree parallel execution at plan time (Tier 4.5)
- Project executor `--status` accurately shows full milestone progress

### Procedure

1. Check if `phases/{version}/milestone.json` exists
2. If not, discuss with user to confirm **phase count / purpose of each phase**
   - Reference the milestone description in ROADMAP.md
   - If 1 phase is sufficient, proceed as before
   - If 2+ phases, decide each `dir` slug + independence (`independent: true/false`)
3. Write `phases/{version}/milestone.json` (example):
   ```json
   {
     "version": "{version}",
     "name": "{Milestone Name}",
     "status": "in-progress",
     "phases": [
       {"dir": "0-foo", "status": "pending", "independent": true},
       {"dir": "1-bar", "status": "pending", "independent": true},
       {"dir": "2-baz", "status": "pending", "independent": false}
     ]
   }
   ```
4. If project harness provides a worktree recommendation helper, auto-determine:
   - 3+ phases or 2+ `independent: true` → print worktree parallel execution recommendation
   - Otherwise → silent (sequential execution)

### Independence criteria

`independent: true` requires **all** of:
- Modified file regions do not overlap with other phases (e.g., `src/module_a/*` vs `src/module_b/*`)
- No dependency (does not require another phase's output)
- No expected merge conflicts

## Context Budget
- Read only project ARCHITECTURE and scope docs directly (e.g., `docs/scope/{version}/PRD.md`). Paths supplied by project CLAUDE.md + `projects/{name}/ARCHITECTURE.md`
- Delegate code analysis to Agent(subagent_type="harness-explore", model="opus")
- If context becomes heavy: "Context running low — recommend /clear then continue next step"

---

> **Plan Mode recommended**: Explore/discussion stage is read/grep-heavy. If needed, enter Plan Mode with `Shift+Tab ×2` to stay read-only until PLAN.md write. Proceed after `ExitPlanMode` approval.

## 1. Explore

Read directly:
- `phases/ROADMAP.md` — including Lessons Learned
- Project scope document (standard pattern: `docs/scope/{version}/PRD.md`. Override in project CLAUDE.md if different)
- Project ARCHITECTURE document (path in CLAUDE.md. e.g., `docs/core/ARCHITECTURE.md` or `@~/harness-meta/projects/{name}/ARCHITECTURE.md` include)

**Delegate code analysis to harness-explore agent:**
```
Agent(
  description="v2.0 code analysis",
  subagent_type="harness-explore",
  model="opus",
  prompt="Check current implementation, stubs, test count, settings fields for target modules"
)
```

Output: current state summary.

## 2. Requirements

- Extract scope from PRD → feature list (P0/P1/P2)
- Refine acceptance criteria
- Uncover hidden requirements (warmup, initialization, edge cases)

Output: requirements table.

## 3. Discussion (GSD Questioning pattern)

### Philosophy
**Be a thinking partner, not an interviewer.**

### Rules
- **No checklists** — start broad, drill into concerns
- **Refuse vagueness** — "good" → good how? "simple" → how so?
- **Abstract → concrete** — "What would actually happen?" "Give an example?"
- **Follow energy** — dig into what the user emphasizes
- **Prevent scope creep** — outside ROADMAP → "Separate phase. Add to backlog?"
- **Know when to stop** — once what/why/done-criteria are clear → propose moving forward

### Question types (for inspiration, not a checklist)
- **Motivation**: "Why is this needed?" "How does it work now?"
- **Concretization**: "Walk me through using this" "What does it actually look like?"
- **Clarification**: "You said X — is that A or B?"
- **Completion**: "How will we know this works?"

### Anti-patterns
- Checklist traversal, formulaic questions, shallow acceptance, rushing, leading with tech questions

### "Claude's discretion"
"You decide" → record in PLAN.md, free choice at design/execution time.

## 4. PLAN.md generation

**Template**: Read `.claude/skills/harness-plan/plan-template.md` then Write to `phases/{version}/{phase-name}/PLAN.md`.

Substitution placeholders: `{version}`, `{phase-name}`, `{N}` (test count).
Sections to fill:
- Current state (test count, target modules)
- Requirements table (AC as runnable commands, priority P0/P1/P2)
- Discussion decisions table (topic / decision / rationale)
- Claude discretion items, Step design draft, Grey Areas

> **Note**: 7-Dimension validation is output from the `/harness-design` stage. Do not include in PLAN.md (different timing).

Output guidance:
```
PLAN.md created.
Next: /harness-design
If context low: /clear → /harness-design
```

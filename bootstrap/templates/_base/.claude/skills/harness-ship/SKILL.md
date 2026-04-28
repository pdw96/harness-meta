---
name: harness-ship
description: Harness stage 10 — Goal-backward validation → /harness-review → REPORT → commit → push. Activated only by explicit /harness-ship call.
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit(phases/**)
  - Write(phases/**)
model: opus
effort: xhigh
---

Harness stage 10: Goal-backward validation → /harness-review → REPORT.md → commit → push

**Orchestrator**: runs validation directly. Delegates stub analysis to Agent(model="sonnet").

## Pre-flight Gate

1. Read `phases/{version}/{phase}/index.json` → confirm all steps completed → if pending/error, route to `/harness-run`
2. If `phases/{version}/{phase}/REPORT.md` exists → "Already shipped" message
3. Read `phases/{version}/{phase}/PLAN.md` to restore context
4. Check current git branch

**CRITICAL: Absolutely no commit/push until review PASS.**

---

> **Plan Mode recommended**: Step 10-1 Goal-backward validation is read/grep-heavy. If needed, enter Plan Mode with `Shift+Tab ×2` to stay read-only until validation complete, then proceed to REPORT.md / commit.

## 10-1. Goal-backward Validation (GSD verify-phase pattern)

**Core principle: Task complete ≠ Goal achieved**

### Step A: Establish Must-haves
Derive backward from **each requirement (R1~Rn)** in PLAN.md:
1. **Truths** — What must be TRUE for this feature to be achieved?
2. **Artifacts** — What files must EXIST for those Truths to hold?
3. **Wiring** — Are those files CONNECTED to the system?
4. **Tests** — Do tests that PROVE those Truths PASS?

> **Validation automation**: Can delegate to `harness-verifier` subagent.
> ```
> Agent(subagent_type="harness-verifier",
>       description="Goal-backward validation",
>       prompt="phase_path=v{X}/{phase}, plan_path=phases/v{X}/{phase}/PLAN.md")
> ```
> → Returns verdict table (VERIFIED/ORPHANED/STUB/MISSING). User only confirms Revision Gate.

### Step B: Artifact validation (4 levels)

| Level | Validation | Method |
|-------|-----------|--------|
| **1. Exists** | File exists | `Glob` or file existence check |
| **2. Substantive** | Real implementation (not stub) | Grep: `TODO\|FIXME\|PLACEHOLDER\|pass$\|return None.*stub` |
| **3. Wired** | Connected to system | Grep: `import.*{module}` + usage present |
| **4. Functional** | Actually works | Run project test command (`.harness.toml [testing].test_cmd`) |

### Step C: Verdict

| Exists | Substantive | Wired | Functional | Verdict |
|--------|-------------|-------|------------|---------|
| O | O | O | O | VERIFIED |
| O | O | X | - | ORPHANED (fail: unconnected code is dead code) |
| O | X | - | - | STUB (fail) |
| X | - | - | - | MISSING (fail) |

STUB/MISSING/ORPHANED → **Revision Gate**: report to user, fix then re-validate.

> Regex `pass$` may also match valid code like empty class bodies — always manually verify hit lines.

## 10-2. /harness-review checklist (5 items)

1. **Architecture compliance** — Read project ARCHITECTURE document (path in project CLAUDE.md) → compare structure
2. **Tech stack compliance** — Read project DECISIONS/ADR document → Grep for prohibited dependencies/patterns (specific rules supplied by project CLAUDE.md)
3. **Tests exist** — Run project test command (`.harness.toml [testing].test_cmd` or see `CLAUDE.md`)
4. **CRITICAL rules** — Read CRITICAL section of project CLAUDE.md → Grep for prohibited patterns (e.g., prohibited code in specific directories, direct access to specific APIs)
5. **Buildable** — Run project build verification commands (tests, type-check, lint) **each separately** (chaining with `&&` silently skips later steps when earlier ones fail):
   ```bash
   {test_cmd}        # .harness.toml [testing].test_cmd
   {type_check_cmd}  # .harness.toml [testing].type_check_cmd (optional)
   {lint_cmd}        # .harness.toml [testing].lint_cmd (optional)
   # Per-language examples:
   #   Python/uv:      uv run pytest; uv run mypy src; uv run ruff check
   #   TS/pnpm:        pnpm test; pnpm tsc --noEmit; pnpm biome check
   #   Go:             go test ./...; go vet ./...; golangci-lint run
   #   Rust:           cargo test; cargo clippy -- -D warnings
   ```

### Revision Gate
FAIL → fix → re-validate (max 3x). Exceeds 3x → **Escalation** (user decision).

## 10-3. REPORT.md generation

**Template**: Read `.claude/skills/harness-ship/report-template.md` then Write to `phases/{version}/{phase-name}/REPORT.md`.

Content to fill:
- Goal-backward table (10-1 results)
- Execution results table (`step*-output.json` metadata: time/cost/turns/retries)
- `/harness-review` results table (10-2 5 items)
- Output summary, Lessons Learned, test changes (before/after/delta)

## 10-4. State file sync

- `phases/ROADMAP.md` — add completion info + Lessons Learned
- `phases/index.json` — update milestone status "completed" + completed_at
- `phases/{version}/milestone.json` — auto-updated when project executor marks phase complete. Manual fix if missing
- If harness itself was modified, record in **harness-meta repo's `sessions/{project}/vX.Y-{name}/REPORT.md`** (use `/harness-meta` session). Project repo's `phases/HARNESS_CHANGELOG.md` is retained for legacy v0.x~v1.4 only.

## 10-5. Commit + Push

**Pre-check**: confirm clean working tree with `git status`. If dirty before main checkout, ask user to stash/commit.

```bash
git add phases/{version}/{phase}/REPORT.md phases/ROADMAP.md \
       phases/{version}/{phase}/index.json phases/{version}/milestone.json \
       phases/index.json
git commit -m "chore({phase}): mark phase completed + review report"

# Check dirty before moving to main (new files may remain from review)
git status --porcelain | head -1     # empty = OK

git checkout main
git pull origin main --ff-only       # non-fast-forward → abort → user decision
git merge feat-{phase-name} --no-edit
git push origin main
git branch -d feat-{phase-name}
```

> `pull --ff-only` failure means remote has other commits. Report to user instead of arbitrary rebase/merge.

Output guidance:
```
Phase complete.
Next milestone: /clear → /model sonnet → /harness
```

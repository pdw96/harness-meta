# harness-meta

**Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer** — distributed as a **Claude Code Plugin** (since v5.0). Analyzes target projects and composes appropriate harness components (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) using the Claude Code tool catalog from [code.claude.com/docs](https://code.claude.com/docs/) (docs + built-in slash commands + plugin/MCP). Plugin manifest (`.claude-plugin/plugin.json`) exposes agents/commands/hooks/skills paths; install via `claude plugin install harness-meta@harness-meta` (since v5.0). The `component-installer` agent absorbs custom component lifecycle (milestone artifact apply) — Plugin install lifecycle delegates to Claude Code CLI. Canonical definition: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 end.

**AI Native operation** (operational principles complement, v6.0): see [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 7 — 3-dimension matrix (context efficiency + autonomy + multi-AI collaboration) + entry title guidelines (4 principles). The v4.0 identity (responsibility / output) and AI Native operation (operational principles / method) are two orthogonal complementary dimensions.

License: MIT. See [README.md](README.md) for full project overview.

## Installation

Standard onboarding (since v5.0 — Claude Code Plugin spec):

```bash
# Option A: GitHub source (no clone needed — recommended for external users)
claude plugin marketplace add pdw96/harness-meta
claude plugin install harness-meta@harness-meta
```

```bash
# Option B: Local clone (for local dev / offline)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
claude plugin marketplace add ~/harness-meta
claude plugin install harness-meta@harness-meta
```

After install, Claude Code recognizes `.claude-plugin/plugin.json` automatically — no `~/.claude/{commands,hooks,statusline,skills,agents}/` symlink/junction creation needed. Plugin source resides at `~/.claude/plugins/cache/harness-meta/`. Use `claude plugin uninstall harness-meta` to remove, `claude plugin enable/disable harness-meta` to toggle.

**Migration from v4.x install** — `~/.claude/agents/` legacy SymbolicLinks for the 5-member audit-team (project-scanner, harness-gap-analyzer, claude-docs-mapper, component-proposer, component-installer) may persist. Verify with `ls ~/.claude/agents/` then remove (Linux/macOS) or `Remove-Item` (Windows) to avoid agent_type duplicate. See [README.md](README.md#installation) for OS-specific commands.

**Deprecated since v5.0** — natural-language invocation `~~harness-meta 설치해줘~~` (deprecated, v5.0+ inactive) + v4.1 D7 mechanical sequence (SymbolicLink/Junction/Copy fallback) is preserved only as historical narrative in v4.x milestone artifacts.

This repo has no build step and no runtime code beyond milestone artifacts.

## Code style

- Conventional Commits with scope: `docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`.
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Write in English for `AGENTS.md`, `README.md` headers, and `LICENSE`. Write in Korean for `CLAUDE.md` and milestone records.
- Milestone artifacts (v3.0+ 9-stage-bundled: INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + `milestones.md` (sub-milestone listing per version) + `execute/phase-{n}.md`; v2.0~v2.1 9-stage: same 7 artifacts + execute (no milestones.md); 7-stage era v1.0~v1.4: PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute) use **Anthropic-aligned hybrid format** (YAML frontmatter + reduced JSON + Markdown body, v6.1+ schema; pre-v6.1 = "MD + JSON code blocks"). YAML frontmatter has 5 fields (id/title/version/stage/status), JSON block has only smoke-required fields (id/title moved to frontmatter), Markdown body absorbs motivation/dependencies/etc. as natural prose.

## Project structure

- `ROADMAP.md` (root) — **thin index** of project ROADMAPs (`{ projects: [{ name, roadmap_path }] }` only). Milestones are NOT registered here — they live in `projects/<name>/ROADMAP.md` (`tests/smoke-projects-scope-discipline.sh` enforces this).
- `claude/` — global layer source: `commands/`, `hooks/`, `statusline/`. Symlinked to `~/.claude/`.
- `skills/` — global user skills (5 skills, plugin_root standard location, 1-level flat, v5.1+). `bootstrap/skills/` retains `CLAUDE.md` policy narrative only.
- `projects/<name>/` — per-project harness archive. Fixed structure: `ARCHITECTURE.md` (long-lived) + `ROADMAP.md` (JSON schema). meta also has `CLAUDE.md` (lazy load) + `milestones/` (this repo IS the meta workspace); other projects (e.g., upbit) have no `milestones/` here — milestone artifacts live in their own repos.
- `projects/meta/milestones/v{X.Y}_{slug}/` — meta milestones, 9-stage flow (v2.0+):
  - `INTENT.md` — intent (goal, motivation, success_criteria, out_of_scope, dependencies).
  - `RESEARCH.md` — investigation (external, codebase, options, risks_identified).
  - `DESIGN.md` — design decisions + phase breakdown + 5-perspective review.
  - `APPROVE.md` — user explicit approval gate (`approval.approved_by: "user"` + date ISO-8601).
  - `execute/phase-{n}.md` — per-phase implementation (changes, commit).
  - `VERIFY.md` — validation (smoke, criteria_check vs INTENT).
  - `REPORT.md` — backward synthesis (summary, delta, lessons_learned).
  - `PROPOSE.md` — forward follow-up (next_candidates ROADMAP registration).
- Module-level guides: `bootstrap/skills/CLAUDE.md` (skill policy narrative), `claude/CLAUDE.md`, `tests/CLAUDE.md`, `projects/meta/CLAUDE.md` — Claude Code on-demand loads these when working inside the corresponding directory.
- `tests/` — smoke tests + pre-commit autofix wrapper.
- `.github/workflows/ci.yml` — smoke tests auto-run on push and pull_request.
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — pre-commit hooks (shellcheck + markdownlint).
- `.env.example` — `HARNESS_META_ROOT` is the only meta-level environment variable.

Legacy era preservation: 4-tier milestones (`v1.84_*` ~ `v1.88_*`), 7-stage era milestones (`v1.0_workflow-redesign` ~ `v1.4_*`), and 9-stage era milestones (`v2.0_workflow-word-fidelity` ~ `v2.1_smoke-spawn-batching`) are preserved as historical records (forward-only policy). New work uses 9-stage-bundled format from `v3.0_milestones-restructure` onward — version-level 1 milestone (sub-milestone phase mapping, `milestones.md` per version). The v2.0 milestone itself uses 7-stage format as a self-reference avoidance marker; v3.0 onward adopts self-reference compliance (dogfooding). See [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6.1 for the era policy + bundling trigger conditions.

## Workflow

9-stage pipeline per milestone (v2.0+):

```
ROADMAP (input source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE
```

Each stage = single word, single responsibility (1:1 mapping, v2.0_workflow-word-fidelity correction):

- OPEN — mounts the milestone container + adds ROADMAP entry `in_progress`.
- INTENT — sets intent (what & why) — formerly PLAN (rename for word fidelity).
- RESEARCH — gathers findings (no decisions).
- DESIGN — makes design decisions + phase breakdown + 5-perspective subagent review.
- APPROVE — pure user explicit approval gate (`approval.approved_by: "user"` + date).
- EXECUTE — implements per-phase (one commit per phase).
- VERIFY — validates against INTENT.success_criteria.
- REPORT — backward synthesis (summary, delta, lessons_learned only).
- PROPOSE — forward follow-up (next_candidates ROADMAP registration) — formerly part of REPORT.

All milestone artifacts use the Anthropic-aligned hybrid format (v6.1+ schema): YAML frontmatter (5 fields: id/title/version/stage/status) + Markdown body with `## Spec` section containing a reduced JSON code block (smoke-required fields only). Pre-v6.1 artifacts used "MD + JSON code blocks" format (v6.1 phase-2 backfilled all 28 active milestones; _archive 40 milestones preserved as historical). 7-stage era (v1.0~v1.4) preserved milestones use the older 5-artifact set (PLAN/RESEARCH/DESIGN/VERIFY/REPORT). See [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6 for the era policy.

## Harness engineering definition

**Harness engineering definition** (canonical single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5-element matrix (Context / Workflow / Constraint / Verification / Trace). New milestones must map to one of these five elements.

## Boundaries

- Don't bypass `APPROVE.md` (or `DESIGN.approval` for 7-stage era preserved milestones). Do require explicit `approval.approved_by: "user"` + date ISO-8601 before EXECUTE.
- Don't skip pre-commit hooks (`--no-verify`) without explicit user approval.
- Don't create new milestones in the legacy 4-tier / 7-stage / 9-stage formats. Do use 9-stage-bundled format from `v3.0+` (version-level 1 milestone, sub-milestone phase mapping, `milestones.md` per version). The v2.0 milestone is the only 7-stage exception (self-reference avoidance marker); v3.0+ adopts self-reference compliance.
- Don't commit `.claude/settings.local.json`. Do stage specific files explicitly (`git add <paths>`); never `git add .` or `-A`.
- Don't push to `origin/main` without explicit user confirmation. Do commit locally first and wait for the user to approve push.
- Don't add tool-specific rule files (`GEMINI.md`, `.cursor/rules/main.mdc`, `CONVENTIONS.md`) proactively. Add them only when a contributor actively uses that tool.

## Key docs

- Operational manual (Korean, primary for Claude Code): [CLAUDE.md](CLAUDE.md)
- Project thin index: [ROADMAP.md](ROADMAP.md)
- Meta milestones (active): [projects/meta/ROADMAP.md](projects/meta/ROADMAP.md)
- Meta architecture: [projects/meta/ARCHITECTURE.md](projects/meta/ARCHITECTURE.md)
- ADRs: [docs/adr/README.md](docs/adr/README.md)
- Version highlights: [CHANGELOG.md](CHANGELOG.md)

## Status

Public repository, MIT licensed. Milestone history: see [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md).

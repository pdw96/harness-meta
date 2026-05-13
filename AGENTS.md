# harness-meta

**Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer.** Analyzes target projects and composes appropriate harness components (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) using the Claude Code tool catalog from [code.claude.com/docs](https://code.claude.com/docs/) (docs + built-in slash commands + plugin/MCP). Agent (`component-installer`) absorbs mechanical install/update/cleanup — no static install scripts (v4.0 B3). Canonical definition: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 end.

License: MIT. See [README.md](README.md) for full project overview.

## Installation

Clone the repo (once per machine):

```bash
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
```

Then, inside Claude Code, invoke in natural language: `harness-meta 설치해줘` (or English equivalent). The main Claude session uses Bash (PowerShell `New-Item -ItemType Junction` on Windows / `-ItemType SymbolicLink` or `ln -s` on Linux/macOS) to populate `~/.claude/{commands,hooks,statusline,skills,agents}/`. No static install script exists (v4.0 B3) — the `component-installer` subagent absorbs the mechanical work (v4.1 5-step D7 sequence with OS detect + primary attempt by OS).

This repo has no build step and no runtime code beyond milestone artifacts.

## Code style

- Conventional Commits with scope: `docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`.
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Write in English for `AGENTS.md`, `README.md` headers, and `LICENSE`. Write in Korean for `CLAUDE.md` and milestone records.
- Milestone artifacts (v3.0+ 9-stage-bundled: INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + `milestones.md` (sub-milestone listing per version) + `execute/phase-{n}.md`; v2.0~v2.1 9-stage: same 7 artifacts + execute (no milestones.md); 7-stage era v1.0~v1.4: PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute) use **MD + JSON code blocks** format (machine-parseable + human-readable).

## Project structure

- `ROADMAP.md` (root) — **thin index** of project ROADMAPs (`{ projects: [{ name, roadmap_path }] }` only). Milestones are NOT registered here — they live in `projects/<name>/ROADMAP.md` (`tests/smoke-projects-scope-discipline.sh` enforces this).
- `claude/` — global layer source: `commands/`, `hooks/`, `statusline/`. Symlinked to `~/.claude/`.
- `bootstrap/skills/` — global user skills source (`audit/`, `dev-tools/` 2 categories, 5 skills).
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
- Module-level guides: `bootstrap/skills/CLAUDE.md`, `claude/CLAUDE.md`, `tests/CLAUDE.md`, `projects/meta/CLAUDE.md` — Claude Code on-demand loads these when working inside the corresponding directory.
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

All milestone artifacts are MD files with JSON code blocks for structured data. 7-stage era (v1.0~v1.4) preserved milestones use the older 5-artifact set (PLAN/RESEARCH/DESIGN/VERIFY/REPORT). See [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6 for the era policy.

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

# harness-meta

Global integration layer and per-project architecture archive for Claude Code harness workflows.
License: MIT. See [README.md](README.md) for full project overview.

## Commands

Single-stage install (v1.0+):

- **Global**: `pwsh install.ps1` — creates symlinks under `~/.claude/{commands,hooks,statusline}` (3 categories).
- **User skills (opt-in)**: `pwsh install-skills.ps1 -All` — global user skills under `~/.claude/skills/`.
- **Verify**: `pwsh verify.ps1` (Windows) or `bash verify.sh` (macOS/Linux).
- **Force reinstall**: `pwsh install.ps1 -Force` — backs up existing files to `~/.claude/backup-<ts>/`.

This repo has no build step and no runtime code beyond install/verify scripts.

## Code style

- Conventional Commits with scope: `docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`.
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Write in English for `AGENTS.md`, `README.md` headers, and `LICENSE`. Write in Korean for `CLAUDE.md` and milestone records.
- Milestone artifacts (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + `execute/{n}phase.md`) use **MD + JSON code blocks** format (machine-parseable + human-readable).

## Project structure

- `ROADMAP.md` (root) — meta milestone index (id/title/status/summary/trigger).
- `claude/` — global layer source: `commands/`, `hooks/`, `statusline/`. Symlinked to `~/.claude/`.
- `bootstrap/skills/` — global user skills source (`audit/`, `dev-tools/` 2 categories, 5 skills).
- `projects/<name>/` — per-project harness architecture, 2 fixed docs: `ARCHITECTURE.md` (long-lived reference) + `ROADMAP.md` (JSON schema).
- `milestones/v{X.Y}_{slug}/` — work milestones, 7-stage flow:
  - `PLAN.md` — intent (goal, success_criteria, scope).
  - `RESEARCH.md` — investigation (findings, options, risks).
  - `DESIGN.md` — decisions + phase breakdown + user approval gate.
  - `execute/{n}phase.md` — per-phase implementation (changes, commit).
  - `VERIFY.md` — validation (smoke, criteria_check vs PLAN).
  - `REPORT.md` — synthesis (summary, lessons, next_candidates).
- Module-level guides: `bootstrap/skills/CLAUDE.md`, `claude/CLAUDE.md`, `tests/CLAUDE.md` — Claude Code on-demand loads these when working inside the corresponding directory.
- `tests/` — smoke tests + pre-commit autofix wrapper.
- `.github/workflows/ci.yml` — smoke tests auto-run on push and pull_request.
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — pre-commit hooks (shellcheck + markdownlint).
- `.env.example` — `HARNESS_META_ROOT` is the only meta-level environment variable.

Legacy 4-tier milestones (`milestones/v1.84_*` ~ `v1.88_*`) are preserved as historical records. New work uses 7-stage format from `v1.0_workflow-redesign` onward.

## Workflow

7-stage pipeline per milestone:

```
ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT
```

Each step has a single responsibility:

- PLAN — sets intent (what & why).
- RESEARCH — gathers findings (no decisions).
- DESIGN — makes decisions, breaks into phases, requires user approval.
- EXECUTE — implements per-phase (one commit per phase).
- VERIFY — validates against PLAN.success_criteria.
- REPORT — synthesizes for ROADMAP integration (summary, lessons, next triggers).

All milestone artifacts are MD files with JSON code blocks for structured data.

## Boundaries

- Don't bypass `DESIGN.approval`. Do require explicit `approved_by: "user"` + date before EXECUTE.
- Don't skip pre-commit hooks (`--no-verify`) without explicit user approval.
- Don't create new milestones in the legacy 4-tier format. Do use 7-stage format from `v1.0+`.
- Don't commit `.claude/settings.local.json`. Do stage specific files explicitly (`git add <paths>`); never `git add .` or `-A`.
- Don't push to `origin/main` without explicit user confirmation. Do commit locally first and wait for the user to approve push.
- Don't add tool-specific rule files (`GEMINI.md`, `.cursor/rules/main.mdc`, `CONVENTIONS.md`) proactively. Add them only when a contributor actively uses that tool.

## Key docs

- Operational manual (Korean, primary for Claude Code): [CLAUDE.md](CLAUDE.md)
- Active milestones: [ROADMAP.md](ROADMAP.md)
- ADRs: [docs/adr/README.md](docs/adr/README.md)
- Version highlights: [CHANGELOG.md](CHANGELOG.md)

## Status

Public repository, MIT licensed. Workflow redesign milestone `v1.0_workflow-redesign` in progress (2026-05-08).

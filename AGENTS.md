# harness-meta

Global integration layer and per-project architecture archive for Claude Code harness workflows.
License: MIT. See [README.md](README.md) for full project overview.

## Commands

Two-stage install (v1.8+):

- **Stage 1 — Global**: `pwsh install.ps1` — creates symlinks under `~/.claude/{commands,hooks,statusline}` (3 categories). Auto-cleans legacy symlinks from v1.7 and earlier.
- **Stage 2 — Per-project**: `pwsh bootstrap/install-project-claude.ps1` (Windows) or `bash bootstrap/install-project-claude.sh` (macOS/Linux) — copies `_base/.claude/` (17 files) into the target project's `.claude/`. After copy, run `/config → Output style → "Harness Engineer"` in Claude Code.
- Verify installation: `pwsh verify.ps1` — runs auto-checks (Z/A/B/C/D/E/F/G).
- Force reinstall after conflicts: `pwsh install.ps1 -Force` — backs up existing files to `~/.claude/backup-<ts>/`.

This repo has no build step and no runtime code beyond install/verify/bootstrap scripts.

## Code style

- Conventional Commits with scope: `docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`. Use `<project-name>` scope for per-project sessions.
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Write in English for `AGENTS.md`, `README.md` headers, and `LICENSE`. Write in Korean for `CLAUDE.md` and session records (primary maintainer's working language).

## Project structure

- `claude/` — source-of-truth for the global Claude Code layer (commands / agents / skills / hooks / statusline / output-styles). Distributed via symlink by `install.ps1`.
- `bootstrap/` — assets for new-project onboarding: `manifest-schema.md`, `docs/OWNERSHIP.md`, `docs/AGENTS_MD_STRATEGY.md`, templates.
- `projects/<name>/` — per-project harness architecture, 4 fixed docs: `ARCHITECTURE.md`, `DECISIONS.md`, `INTERVIEW.md`, `STACK.md`.
- `sessions/meta/vX.Y-<slug>/` and `sessions/<project>/vX.Y-<slug>/` — session records as `PLAN.md` + `REPORT.md` pairs only.

## Session workflow

- Every repo change is a session. Create `sessions/<target>/vX.Y-<slug>/PLAN.md` first, implement, then write `REPORT.md`.
- Session ownership is decided by the scope of changed files, not by CWD. Follow `bootstrap/docs/OWNERSHIP.md` S1–S7 scope classification + T1–T5 tie-breakers.
- Every PLAN.md must include a `## 세션 소속 근거 (self-apply)` block at the top, citing the applied S# / T# in 3–5 lines.

## Boundaries

- Don't edit `projects/<name>/` from a `sessions/meta/` session. Do open a matching `sessions/<name>/vX.Y-<slug>/` session for project-scoped changes (per OWNERSHIP T4).
- Don't create `index.json` or `step{N}.md` under any `sessions/` directory. Do use `PLAN.md` + `REPORT.md` only — this repo avoids recursive harness structure.
- Don't commit `.claude/settings.local.json`. Do stage specific files explicitly (`git add <paths>`); never `git add .` or `-A`.
- Don't push to `origin/main` without explicit user confirmation. Do commit locally first and wait for the user to approve push per commit.
- Don't add tool-specific rule files (`GEMINI.md`, `.cursor/rules/main.mdc`, `CONVENTIONS.md`) proactively. Do add them only when a contributor actively uses that tool, following `bootstrap/docs/AGENTS_MD_STRATEGY.md` §3 mapping matrix.

## Key docs

- Operational manual (Korean, primary for Claude Code): [CLAUDE.md](CLAUDE.md)
- Ownership rules: [bootstrap/docs/OWNERSHIP.md](bootstrap/docs/OWNERSHIP.md)
- AGENTS.md strategy (symlink / copy / mapping matrix): [bootstrap/docs/AGENTS_MD_STRATEGY.md](bootstrap/docs/AGENTS_MD_STRATEGY.md)
- Manifest schema: [bootstrap/manifest-schema.md](bootstrap/manifest-schema.md)
- Latest session: the most recent directory under `sessions/meta/`.

## Status

Public repository, MIT licensed. Formal external contributions (PRs / issues) will be accepted from v1.25 onward, pending `CONTRIBUTING.md` / `SECURITY.md` / `.github/` templates. Until then the repo is observable and forkable but not actively soliciting PRs.

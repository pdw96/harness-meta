# harness-meta

**LLM-agnostic harness engineering consultant + project harness composer + reference adapter (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)** — distributed today as a **Claude Code Plugin** (since v5.0). Analyzes target projects through the vendor-neutral harness model (Context / Workflow / Constraint / Verification / Trace), then maps recommendations to the active AI tool surface. The current production adapter composes Claude Code components (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) using the Claude Code catalog from [code.claude.com/docs](https://code.claude.com/docs/) (docs + built-in slash commands + plugin/MCP). Plugin manifest (`.claude-plugin/plugin.json`) exposes agents/commands/hooks/skills paths; install via `claude plugin install harness-meta@harness-meta` (since v5.0). The `component-installer` agent absorbs custom component lifecycle (milestone artifact apply) — Plugin install lifecycle delegates to Claude Code CLI. Canonical definition: [`development/ARCHITECTURE.md`](development/ARCHITECTURE.md) § 3.1 end.

**AI Native operation** (operational principles complement, v6.0): see [`development/ARCHITECTURE.md`](development/ARCHITECTURE.md) § 7 — 3-dimension matrix (context efficiency + autonomy + multi-AI collaboration) + entry title guidelines (4 principles). The § 3.1 identity (responsibility / output) and AI Native operation (operational principles / method) are two orthogonal complementary dimensions.

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

This repo has no build step. Runtime code is limited to repository automation and plugin assets: shell hooks/smokes, Python helper scripts, and skill scripts such as `skills/ai-ready-scorer/`.

## Code style

- Conventional Commits with scope: `docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`.
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Write in English for `AGENTS.md`, `README.md` headers, and `LICENSE`. Write in Korean for `CLAUDE.md` and milestone records.
- Current milestone artifacts use **Anthropic-aligned hybrid format** (YAML frontmatter + reduced JSON + Markdown body). New large changes use v6.2+ 9-stage-flattened `MILESTONE.md` with frontmatter 4 fields (`id/title/version/status`) plus stage H2 sections and `execute/phase-{n}.md`; small internal changes may use v8.1+ `LIGHTWEIGHT.md` with 4 H2 sections (`문제/결정/적용/기록`). Historical eras are preserved forward-only: v3.0~v6.1 9-stage-bundled split files, v2.0~v2.1 9-stage split files, v1.0~v1.4 7-stage, and v1.84~v1.88 4-tier records.

## Project structure

- `ROADMAP.md` (root) — **thin index** of roadmap pointers only: `development_roadmap` for this repo plus `projects[]` for external project views. Milestones are NOT registered here; they live in `development/ROADMAP.md` or `projects/<name>/ROADMAP.md` (`tests/smoke-projects-scope-discipline.sh` enforces this).
- `claude/` — Claude Code adapter source: `commands/`, `hooks/`, `statusline/`, exposed through `.claude-plugin/plugin.json` (no v5.0+ symlink/junction install).
- `agents/` — Claude Code subagents exposed by the plugin manifest.
- `skills/` — plugin skills (15 skills, plugin_root standard location, 1-level flat, v5.1+). `bootstrap/skills/` retains `CLAUDE.md` policy narrative only.
- `projects/<name>/` — per-project harness view. Fixed structure: `ARCHITECTURE.md` (long-lived) + `ROADMAP.md` (JSON schema). External project milestone artifacts live in their own repos.
- `development/` — harness-meta repo's own product-development workspace (`ARCHITECTURE.md`, `ROADMAP.md`, `CLAUDE.md`, `milestones/`).
- `development/milestones/v{X.Y}/` — current meta milestone containers:
  - `MILESTONE.md` — large changes, 9-stage-flattened H2 sections.
  - `LIGHTWEIGHT.md` — small changes, 4-section lightweight flow.
  - `execute/phase-{n}.md` — per-phase implementation notes when needed.
- Module-level guides: `bootstrap/skills/CLAUDE.md` (skill policy narrative), `claude/CLAUDE.md`, `tests/CLAUDE.md`, `development/CLAUDE.md` — Claude Code on-demand loads these when working inside the corresponding directory.
- `tests/` — smoke tests + pre-commit autofix wrapper.
- `.github/workflows/ci.yml` — smoke tests auto-run on push and pull_request.
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — pre-commit hooks (shellcheck + markdownlint).
- `.env.example` — `HARNESS_META_ROOT` is the only meta-level environment variable.

Adapter policy: the core methodology is LLM-agnostic. Claude Code is the current production adapter. Do not proactively add `GEMINI.md`, `.cursor/rules/main.mdc`, `CONVENTIONS.md`, or other tool-specific rule files unless a contributor actively uses that tool; future adapters should consume the same core spec instead of creating parallel methodology.

Legacy era preservation: 4-tier milestones (`v1.84_*` ~ `v1.88_*`), 7-stage era milestones (`v1.0_workflow-redesign` ~ `v1.4_*`), 9-stage era milestones (`v2.0_workflow-word-fidelity` ~ `v2.1_smoke-spawn-batching`), and v3.0~v6.1 9-stage-bundled milestones are preserved as historical records (forward-only policy). New work uses v6.2+ 9-stage-flattened `MILESTONE.md` for large changes or v8.1+ `LIGHTWEIGHT.md` for small changes. See [`development/ARCHITECTURE.md`](development/ARCHITECTURE.md) § 6.1 for the era policy + bundling trigger conditions.

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

Current milestone artifacts use the Anthropic-aligned hybrid format: YAML frontmatter (4 fields: `id/title/version/status`) + Markdown body. Historical v6.1-era artifacts used 5-field frontmatter (`stage` included), and pre-v6.1 artifacts used "MD + JSON code blocks"; these are preserved as historical records. See [`development/ARCHITECTURE.md`](development/ARCHITECTURE.md) § 6 for the era policy.

## Harness engineering definition

**Harness engineering definition** (canonical single source): [`development/ARCHITECTURE.md`](development/ARCHITECTURE.md) § 3 — working definition + 5-element matrix (Context / Workflow / Constraint / Verification / Trace). New milestones must map to one of these five elements.

## Boundaries

- Don't bypass `APPROVE.md` (or `DESIGN.approval` for 7-stage era preserved milestones). Do require explicit `approval.approved_by: "user"` + date ISO-8601 before EXECUTE.
- Don't skip pre-commit hooks (`--no-verify`) without explicit user approval.
- Don't create new milestones in the legacy 4-tier / 7-stage / 9-stage / 9-stage-bundled formats. For new meta work, use v6.2+ 9-stage-flattened `MILESTONE.md` for large changes or v8.1+ `LIGHTWEIGHT.md` for small internal changes.
- Don't commit `.claude/settings.local.json`. Do stage specific files explicitly (`git add <paths>`); never `git add .` or `-A`.
- Don't push to `origin/main` without explicit user confirmation. Do commit locally first and wait for the user to approve push.
- Don't add tool-specific rule files (`GEMINI.md`, `.cursor/rules/main.mdc`, `CONVENTIONS.md`) proactively. Add them only when a contributor actively uses that tool.

## Key docs

- Operational manual (Korean, primary for Claude Code): [CLAUDE.md](CLAUDE.md)
- Project thin index: [ROADMAP.md](ROADMAP.md)
- Meta milestones (active): [development/ROADMAP.md](development/ROADMAP.md)
- Meta architecture: [development/ARCHITECTURE.md](development/ARCHITECTURE.md)
- ADRs: [docs/adr/README.md](docs/adr/README.md)
- Version highlights: [CHANGELOG.md](CHANGELOG.md)

## Status

Public repository, MIT licensed. Milestone history: see [`development/ROADMAP.md`](development/ROADMAP.md).

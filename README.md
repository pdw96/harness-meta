# harness-meta

> **Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer** — distributed as a **Claude Code Plugin** (since v5.0).
> Analyzes target projects and composes appropriate harness components (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) using the Claude Code tool catalog from [code.claude.com/docs](https://code.claude.com/docs/) (docs + built-in slash commands + plugin/MCP). Plugin manifest (`.claude-plugin/plugin.json`) exposes agents/commands/hooks/skills paths — install via `claude plugin install harness-meta@harness-meta` (since v5.0). Agent (`component-installer`) absorbs custom component lifecycle (milestone artifact apply) — Plugin install lifecycle delegated to Claude Code CLI.
> Operational manual (Korean, for Claude Code sessions): [`CLAUDE.md`](CLAUDE.md) · Agent context: [`AGENTS.md`](AGENTS.md) · Canonical definition: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 end.

Harness wraps Claude Code sessions into a **9-stage workflow** (v2.0+): ROADMAP (input source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE. Each stage = single word, single responsibility (1:1 mapping). A per-project `.harness.toml` manifest activates the workflow; shared slash commands and skills are distributed from this repo to each project. Legacy 7-stage era (v1.0~v1.4) and 4-tier era (v1.84~v1.88) milestones are preserved historically — see [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6 for the era policy.

---

## Requirements

**All platforms**

- **Claude Code** installed and authenticated (Plugin spec required — v5.0+)
- Git

**Windows (primary)**

- Windows 11 — standard user privileges sufficient (Plugin install lifecycle eliminates Developer Mode dependency)
- PowerShell 7+ — `winget install Microsoft.PowerShell`
- Git Bash (included with Git for Windows) — required by hooks (`shell: "bash"`)

**macOS / Linux (secondary)**

- Bash 4+ (macOS ships Bash 3.2 — `brew install bash` if needed)

---

## Installation

Standard onboarding (since v5.0 — Claude Code Plugin spec):

```bash
# 1. Clone the repo (once per machine)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta

# 2. Add as local marketplace (inside Claude Code or via shell)
claude plugin marketplace add ~/harness-meta

# 3. Install (default scope: user / project / local — pick one)
claude plugin install harness-meta@harness-meta
```

After install, `claude plugin list` shows the active plugin. Use `claude plugin uninstall harness-meta` to remove, `claude plugin enable/disable harness-meta` to toggle. Plugin source resides at `~/.claude/plugins/cache/harness-meta/`. The `.claude-plugin/plugin.json` manifest exposes paths (agents/commands/hooks/skills) — Claude Code recognizes them automatically. No `~/.claude/{commands,hooks,statusline,skills,agents}/` symlink/junction creation needed.

**Migration from v4.x install** — `~/.claude/agents/` legacy SymbolicLinks for the 5-member audit-team may persist. Verify, then remove to avoid agent_type duplicate (Plugin install + legacy SymbolicLink coexistence):

```bash
# Linux/macOS — preview first, then remove:
ls ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md
rm ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md

# Windows PowerShell — preview first, then remove:
Get-ChildItem $env:USERPROFILE\.claude\agents\ -Filter '{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md'
Remove-Item $env:USERPROFILE\.claude\agents\project-scanner.md, $env:USERPROFILE\.claude\agents\harness-gap-analyzer.md, $env:USERPROFILE\.claude\agents\claude-docs-mapper.md, $env:USERPROFILE\.claude\agents\component-proposer.md, $env:USERPROFILE\.claude\agents\component-installer.md
```

**Deprecated since v5.0** — natural-language invocation `~~harness-meta 설치해줘~~` (deprecated, v5.0+ inactive) + v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction primary → Copy fallback → Cleanup retention) is preserved only as historical narrative in v4.x milestone artifacts. The `component-installer` agent now scopes its responsibility to custom component lifecycle (milestone artifact apply) — Plugin install lifecycle delegates to Claude Code CLI (`claude plugin install/uninstall/enable/disable`).

### Optional dev tooling

Pre-commit hooks catch issues before commit — shellcheck + markdownlint for syntax/style, plus harness smoke tests (spec-verification § + scope contract §).

**v1.64+** — smoke 실패 시 wrapper(`tests/precommit-autofix-or-fail.sh`)가 `--fix` 자동 시도 + 안내 후 abort. 사용자는 `git diff` 검토 → `git add -u` 재스테이징 → 재커밋.

```bash
pip install pre-commit   # or: pipx install pre-commit
pre-commit install       # one-time per clone
pre-commit run --all-files   # manual run
# individual smoke hooks:
pre-commit run smoke-spec-verification
pre-commit run smoke-scope-contract
```

Smoke tests (`tests/smoke-*.sh`) also run automatically on every push and pull request via [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

Environment variables: see [`.env.example`](.env.example) (only `HARNESS_META_ROOT` at the meta-repo level).

---

## Directory layout

```
harness-meta/
├── CLAUDE.md                       # Korean ops guide (Claude Code primary context)
├── README.md                       # This file
├── AGENTS.md                       # English agent context (all AI tools)
├── claude/                         # Global layer (symlink source, 3 items)
│   ├── commands/harness-meta.md    # /harness-meta command
│   ├── hooks/session-init.sh       # SessionStart hook
│   └── statusline/statusline.sh    # Live phase/step display
│
├── bootstrap/
│   └── skills/<name>/              # Global user-skills (ai-ready-scorer, developer-profile, etc.)
│
├── ROADMAP.md                       # Thin index — { projects: [{ name, roadmap_path }] } only (v1.1_meta-as-project+)
│
├── projects/                        # Per-project harness archives (homomorphic structure)
│   ├── meta/                        # This repo IS the meta workspace
│   │   ├── ARCHITECTURE.md          # Meta repo structure snapshot
│   │   ├── ROADMAP.md               # Meta milestones (v1.0+, v1.84~v1.88 historical)
│   │   ├── CLAUDE.md                # Lazy-load subdir guide (loads when working in projects/meta/)
│   │   └── milestones/  # v3.0+ 9-stage-bundled (v{X.Y}/ + milestones.md + 7 artifacts) / v2.0~v2.1 9-stage (v{X.Y}_{slug}/ + 7 artifacts) / v1.0~v1.4 7-stage (PLAN/.../REPORT) / v1.84~v1.88 4-tier preserved (era policy: ARCHITECTURE.md § 6.1)
│   └── <other-project>/             # e.g., upbit
│       ├── ARCHITECTURE.md
│       └── ROADMAP.md               # Project milestones (artifacts live in the project's own repo)
└── tests/smoke-projects-scope-discipline.sh  # Enforces thin-index discipline (root ROADMAP must NOT contain milestones[])
```

---

## Activating a project

Place a `.harness.toml` at the project root. The `session-init.sh` hook auto-detects it on Claude Code session start. Without the manifest the hook is a no-op — non-harness projects are unaffected.

**Minimal manifest:**

```toml
schema_version = "1.1"

[project]
name = "my-project"
language = "python"
package_manager = "uv"

[harness]
code_dir = "scripts/harness"
phases_dir = "phases"

[architecture]
meta_ref = "projects/my-project/ARCHITECTURE.md"
```

**Onboard a new project:**

```
/harness-meta <new-project-name>
```

When `.harness.toml` is absent, the workflow enters new-project onboarding mode — the first milestone's EXECUTE phase creates the manifest, architecture docs, and `projects/<name>/` scaffold.

---

## Usage

| Command | Purpose |
|---------|---------|
| `/harness-meta` | meta 또는 per-project harness milestone 9-stage workflow 진입 (v2.0+) |
| `/harness-meta <name>` | 특정 프로젝트 하네스 개선 또는 신규 프로젝트 온보딩 |

Milestone artifacts are stored under `projects/{meta or <name>}/milestones/` — directory layout per era. **v3.0+ 9-stage-bundled** (current): `milestones/v{X.Y}/` (sub-id absent) + `milestones.md` (sub-milestone listing per version) + INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE artifacts (1 per version, sub-milestones map to phases). **v2.0~v2.1 9-stage preserved**: `milestones/v{X.Y}_{slug}/` + 7 artifacts. **v1.0~v1.4 7-stage preserved**: PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT. See [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6.1 for era policy + bundling trigger conditions.

---

## Key docs

| Doc | Purpose |
|-----|---------|
| [`AGENTS.md`](AGENTS.md) | English agent context — repo overview, commands, structure, boundaries |
| [`CLAUDE.md`](CLAUDE.md) | Korean ops manual — detailed session workflows, directory rules, commands |
| [`GUARDRAILS.md`](GUARDRAILS.md) | Meta-repo session behavior guardrails (forbidden actions, scope contract obligations) |
| [`CHANGELOG.md`](CHANGELOG.md) | User-facing version highlights (Keep a Changelog format) |
| [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md) | Meta milestones (v2.0+ 9-stage active; v1.0~v1.4 7-stage era + v1.84–v1.88 4-tier era preserved) |
| [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) | Meta repo structural snapshot |
| `projects/<name>/ROADMAP.md` | Per-project harness milestones |

---

## License

MIT License — see [`LICENSE`](LICENSE).

Copyright (c) 2026 Dowon Park.

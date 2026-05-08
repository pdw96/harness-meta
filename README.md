# harness-meta

> Structured AI-assisted engineering workflow built on top of Claude Code.
> Operational manual (Korean, for Claude Code sessions): [`CLAUDE.md`](CLAUDE.md) · Agent context: [`AGENTS.md`](AGENTS.md)
> **Harness engineering definition** (canonical single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5-element matrix (Context / Workflow / Constraint / Verification / Trace). New milestones must map to one of these five elements.

Harness wraps Claude Code sessions into a **7-stage workflow**: ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT. A per-project `.harness.toml` manifest activates the workflow; shared slash commands and skills are distributed from this repo to each project.

---

## Requirements

**Windows (primary)**

- Windows 11 + Developer Mode ON (`Settings → System → For developers`) — required for symlink creation
- PowerShell 7+ — `winget install Microsoft.PowerShell`
- Git Bash (included with Git for Windows) — required by hooks (`shell: "bash"`)

**macOS / Linux (secondary)**

- Bash 4+ (macOS ships Bash 3.2 — `brew install bash` if needed)
- Git

All platforms require **Claude Code** installed and authenticated.

---

## Installation

### Stage 1 — Global (once per machine)

```powershell
# Windows
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1
```

```bash
# macOS / Linux
git clone https://github.com/pdw96/harness-meta ~/harness-meta
cd ~/harness-meta
bash ./install.sh
```

Creates symlinks under `~/.claude/{commands,hooks,statusline}/` (3 items). Auto-cleans legacy symlinks from v1.7 and earlier.

> **Reinstall (after layer changes)**: `pwsh ./install.ps1` — `settings.json` hooks are idempotent (v1.36e); regular reinstalls work without `-Force`. Use `-Force` only when file symlinks conflict (backs up to `~/.claude/backup-<ts>/`).

### Stage 2 — Global user-skills (optional, opt-in)

```powershell
# Windows
pwsh $HOME/harness-meta/install-skills.ps1
```

```bash
# macOS / Linux / Windows Git Bash
bash ~/harness-meta/install-skills.sh
```

Symlinks `bootstrap/skills/<name>/` (e.g., `ai-ready-scorer`) into `~/.claude/skills/`. Existing entries are backed up to `~/.claude/skills/<name>.bak-<ts>/` (no auto-cleanup; safe). Use `--all`, `--list`, or `--dry-run` for details.

### Verify

```powershell
# Windows
pwsh $HOME/harness-meta/verify.ps1
```

```bash
# macOS / Linux
bash ~/harness-meta/verify.sh
```

Runs Z/A/B/C/D/E/F/H/I auto-checks + G manual checklist. Use after install or when cloning to a new machine.

- **Z/A**: platform + env (Dev Mode auto-skipped on Linux/macOS)
- **B**: symlink integrity (LinkType + Target + MetaRoot scope)
- **C**: settings.json (BOM, JSON, statusLine, hooks.SessionStart) — `python3` or `jq` required
- **D/E**: hook + statusline smoke (`no-manifest`, `sample-project`, `empty-phases` fixtures)
- **F**: leftover `~/.claude/backup-*` info
- **H/I** (v1.23+): skill frontmatter + permission pattern checks
- **G**: manual checklist (Claude Code session)

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
├── install.ps1                     # Global symlink deploy
├── install-skills.ps1              # Optional: global user-skills (Windows, v1.19+)
├── install-skills.sh               # Same (macOS/Linux)
│
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
│   │   └── milestones/v{X.Y}_{slug}/  # 7-stage milestone artifacts (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md)
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
| `/harness-meta` | meta 또는 per-project harness milestone 7-stage workflow 진입 |
| `/harness-meta <name>` | 특정 프로젝트 하네스 개선 또는 신규 프로젝트 온보딩 |

Milestone artifacts are stored under `projects/{meta or <name>}/milestones/v{X.Y}_{slug}/` — one directory per milestone, 7-stage artifacts (PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT).

---

## Key docs

| Doc | Purpose |
|-----|---------|
| [`AGENTS.md`](AGENTS.md) | English agent context — repo overview, commands, structure, boundaries |
| [`CLAUDE.md`](CLAUDE.md) | Korean ops manual — detailed session workflows, directory rules, commands |
| [`GUARDRAILS.md`](GUARDRAILS.md) | Meta-repo session behavior guardrails (forbidden actions, scope contract obligations) |
| [`CHANGELOG.md`](CHANGELOG.md) | User-facing version highlights (Keep a Changelog format) |
| [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md) | Meta milestones (v1.0+; v1.84–v1.88 historical) |
| [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) | Meta repo structural snapshot |
| `projects/<name>/ROADMAP.md` | Per-project harness milestones |

---

## License

MIT License — see [`LICENSE`](LICENSE).

Copyright (c) 2026 Dowon Park.

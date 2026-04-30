# harness-meta

> Structured AI-assisted engineering workflow built on top of Claude Code.
> Operational manual (Korean, for Claude Code sessions): [`CLAUDE.md`](CLAUDE.md) · Agent context: [`AGENTS.md`](AGENTS.md)

Harness wraps Claude Code sessions into a **10-stage workflow**: plan → design → run → ship. A per-project `.harness.toml` manifest activates the workflow; shared slash commands, agents, and skills are distributed from this repo to each project.

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

v1.8+ uses a **two-stage install**:

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
bash ./install.sh   # coming in v1.21; for now use pwsh if available
```

Creates symlinks under `~/.claude/{commands,hooks,statusline}/` (3 items). Auto-cleans legacy symlinks from v1.7 and earlier.

> **Reinstall (after layer changes)**: `pwsh ./install.ps1` — `settings.json` hooks are idempotent (v1.36e); regular reinstalls work without `-Force`. Use `-Force` only when file symlinks conflict (backs up to `~/.claude/backup-<ts>/`).

### Stage 2 — Per-project (once per project, run at the project root)

```powershell
# Windows
pwsh $HOME/harness-meta/bootstrap/install-project-claude.ps1
```

```bash
# macOS / Linux
bash ~/harness-meta/bootstrap/install-project-claude.sh
```

Copies 14 files from `bootstrap/templates/_base/.claude/` (4 agents + 9 skills + 1 output-style) into the project's `.claude/`. For Python projects, also merges the `python/.claude/` overlay (adds `/harness-python` skill — see [Language overlay](#language-overlay-v111)).

After install, in Claude Code: `/config → Output style → "Harness Engineer"`.

> **Force reinstall (Stage 2)** (backs up existing files to `<proj>/.claude/backup-<ts>/`): add `-f` / `--force` (sh) or `-Force` (PowerShell).

### Stage 3 — Global user-skills (optional, opt-in)

```powershell
# Windows
pwsh $HOME/harness-meta/install-skills.ps1
```

```bash
# macOS / Linux / Windows Git Bash
bash ~/harness-meta/install-skills.sh
```

Symlinks `bootstrap/skills/<name>/` (e.g., `ai-ready-scorer`) into `~/.claude/skills/`. Existing entries are backed up to `~/.claude/skills/<name>.bak-<ts>/` (no auto-cleanup; safe). Use `--all`, `--list`, or `--dry-run` for details. See [`bootstrap/docs/SKILLS.md`](bootstrap/docs/SKILLS.md).

### Verify

```powershell
# Windows
pwsh $HOME/harness-meta/verify.ps1
```

```bash
# macOS / Linux
bash ~/harness-meta/verify.sh
```

Runs Z/A/B/C/D/E/F/H/I auto-checks + G manual checklist (10 stages, v1.23+). Use after install or when cloning to a new machine.

- **Z/A**: platform + env (Dev Mode auto-skipped on Linux/macOS)
- **B**: symlink integrity (LinkType + Target + MetaRoot scope)
- **C**: settings.json (BOM, JSON, statusLine, hooks.SessionStart) — `python3` or `jq` required
- **D/E**: hook + statusline smoke (`no-manifest`, `sample-project`, `empty-phases` fixtures)
- **F**: leftover `~/.claude/backup-*` info
- **H** (v1.23+): overlay matrix + `harness-*` prefix + SKILL.md frontmatter
- **I** (v1.23+): frontmatter 6-axis (V1/V5/V7/V8/V10 — see [`bootstrap/docs/PERMISSION_PATTERN.md`](bootstrap/docs/PERMISSION_PATTERN.md))
- **G**: manual checklist (Claude Code session)

### Optional dev tooling

Pre-commit hooks catch issues before commit — shellcheck + markdownlint for syntax/style, plus harness smoke tests (spec-verification § + scope contract §). Frontmatter-based directories (`bootstrap/skeletons/`, `bootstrap/templates/_base/.claude/`, `bootstrap/templates/python/.claude/`) are excluded via `.markdownlintignore`.

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
├── bootstrap/                      # New-project onboarding assets
│   ├── manifest-schema.md          # .harness.toml spec (v1.1)
│   ├── docs/                       # OWNERSHIP / AGENTS_MD_STRATEGY / OVERLAY / SKILLS / PHILOSOPHY
│   ├── install-project-claude.ps1  # Per-project .claude/ copy (Windows)
│   ├── install-project-claude.sh   # Same (macOS/Linux)
│   ├── skills/<name>/              # Global user-skills (v1.19+) — see bootstrap/docs/SKILLS.md
│   └── templates/
│       ├── _base/.claude/          # Language-agnostic baseline (14 files)
│       └── <language>/.claude/     # Language overlay (v1.11+) — see bootstrap/docs/OVERLAY.md
│
├── projects/<name>/                # Per-project harness architecture (4 fixed docs)
│   ├── ARCHITECTURE.md
│   ├── DECISIONS.md
│   ├── INTERVIEW.md
│   └── STACK.md
│
└── sessions/
    ├── meta/vX.Y-<slug>/           # This repo's own improvement sessions
    └── <project>/vX.Y-<slug>/      # Per-project harness improvement sessions
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

Full field reference: [`bootstrap/manifest-schema.md`](bootstrap/manifest-schema.md).

**Bootstrap a new project:**

```
/harness-meta <new-project-name>
```

When `.harness.toml` is absent, this enters Bootstrap mode: interview → generate manifest + `GUARDRAILS.md` + `.claude/` assets + `projects/<name>/` architecture docs.

---

## Usage

| Command | Stages | Purpose |
|---------|--------|---------|
| `/harness-plan` | 1–4 | Explore → requirements → discussion → `PLAN.md` |
| `/harness-design` | 5–7 | Design → 7-Dimension validation → step files |
| `/harness-run` | 8–9 | UAT dry-run → project executor |
| `/harness-ship` | 10 | Goal-backward validation → `REPORT.md` → commit → push |
| `/harness-meta` | — | This repo's own improvement (or per-project harness changes) |
| `/harness-python` | — | Python env check + mypy → ruff → pytest quality gate (Python projects only) |

Each session produces a `PLAN.md` + `REPORT.md` pair under `sessions/{meta or <project>}/vX.Y-<slug>/`. Session ownership follows [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md) S1–S7 scope rules.

---

## Language overlay (v1.11+)

Per-language skills are layered on top of the 14-file `_base` baseline during `install-project-claude`. The overlay directory is `bootstrap/templates/<language>/.claude/`.

**Currently active:**

| `[project].language` | Overlay | Added skill |
|----------------------|---------|-------------|
| `python` | `templates/python/.claude/` | `/harness-python` — env check (Python version / `.venv` / lock file / sync state) + mypy → ruff → pytest quality gate. Auto-detects package manager (`uv` / `poetry` / `pdm` / `hatch` / `pip`) from `.harness.toml`. |

Additional language overlays (TypeScript, Go, Rust, etc.) will be added evidence-driven. See [`bootstrap/docs/OVERLAY.md`](bootstrap/docs/OVERLAY.md) for the directory convention, merge algorithm, and language matrix (10 languages).

---

## Key docs

| Doc | Purpose |
|-----|---------|
| [`AGENTS.md`](AGENTS.md) | English agent context — repo overview, commands, structure, boundaries |
| [`CLAUDE.md`](CLAUDE.md) | Korean ops manual — detailed session workflows, directory rules, commands |
| [`GUARDRAILS.md`](GUARDRAILS.md) | Meta-repo session behavior guardrails (forbidden actions, scope contract obligations) |
| [`CHANGELOG.md`](CHANGELOG.md) | User-facing version highlights (Keep a Changelog format) |
| [`bootstrap/manifest-schema.md`](bootstrap/manifest-schema.md) | `.harness.toml` v1.1 full field reference |
| [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md) | Session ownership rules (S1–S7 scope + T1–T5 tie-breakers) |
| [`bootstrap/docs/OVERLAY.md`](bootstrap/docs/OVERLAY.md) | Language overlay convention and merge algorithm (v1.11+) |
| [`bootstrap/docs/AGENTS_MD_STRATEGY.md`](bootstrap/docs/AGENTS_MD_STRATEGY.md) | AGENTS.md standard — symlink/copy strategy, tool mapping matrix |
| [`sessions/meta/ROADMAP.md`](sessions/meta/ROADMAP.md) | Meta follow-up sessions — unified roadmap view (v1.36+, replaces EVIDENCE_DRIVEN_ROADMAP.md) |
| `projects/<name>/ROADMAP.md` | Per-project follow-up sessions (v1.36+, generated by Bootstrap S6) |

---

## License

MIT License — see [`LICENSE`](LICENSE).

Copyright (c) 2026 Dowon Park.

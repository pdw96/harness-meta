# Changelog

User-facing highlights for the harness-meta repo. For detailed change records, see `sessions/meta/vX.Y-<slug>/REPORT.md`.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/) at the `.harness.toml` schema level.

`!` after a version marker denotes a breaking change.

## [Unreleased]

### Added

- `.github/workflows/ci.yml` — smoke tests (13 files) auto-run on push and pull_request
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — shellcheck + markdownlint enforcement (frontmatter-based directories excluded)
- `GUARDRAILS.md` — meta-repo session behavior guardrails (forbidden actions, confirmation-required operations, scope contract obligations)
- `.env.example` — `HARNESS_META_ROOT` environment variable reference
- `CHANGELOG.md` — this file

## [v1.14] - 2026-04-28

### Changed

- Bootstrap interview simplified: 10 stages → 8 stages, 13 questions → 7 questions

## [v1.13] - 2026-04-28

### Added

- English `README.md` rewrite + `AGENTS.md` update (open-source entry)

## [v1.12] - 2026-04-27

### Changed

- `_base` skills + Python overlay fully translated to English

## [v1.11b] - 2026-04-27

### Added

- `bootstrap/templates/python/.claude/` overlay content — `harness-python` skill (env check + mypy → ruff → pytest quality gate, package-manager auto-detection)

## [v1.11] - 2026-04-27

### Added

- Language overlay infrastructure (`bootstrap/templates/<language>/.claude/` directory convention + Phase 2 merge logic in `install-project-claude.{sh,ps1}` + `harness-*` naming convention + 10-language matrix)

## [v1.10j] - 2026-04-27

### Added

- Scope contract discipline — `PLAN.md` "Scope inheritance" + "Out of scope" sections now mandatory (over-scope drift prevention)

## [v1.10c–v1.10h3] - 2026-04-26 ~ 2026-04-27

### Added

- Bootstrap AGENTS.md content defaults: `bootstrap_version` stamp, `install_cmd` (17 package-manager matrix), `license` 4-tier detection (SPDX header → multi-file dual → boilerplate 12 patterns → metadata 4 sources)

### Changed

- AGENTS.md L5 license line policy: 3-way rendering (Case 1/2/3) + `MAX_LENGTH=80` (EULA abuse guard)

## [v1.10] - 2026-04-26

### Added

- Bootstrap interview 10-stage flow (`/harness-meta <new-name>` mode)

## [v1.9] - 2026-04-25

### Added

- `bootstrap/detect-project.sh` — auto-detects language / package manager / test commands

### Changed

- `install-project-claude.{sh,ps1}` legacy cleanup logic (v1.9b)

## [v1.8] - 2026-04-25

### Changed (BREAKING)

- Global `claude/` layer reduced to 3 items (`commands/harness-meta.md`, `hooks/session-init.sh`, `statusline/statusline.sh`)
- `bootstrap/templates/_base/.claude/` introduced for project-level distribution
- Existing projects must run `install-project-claude.{ps1,sh}` to recover slash commands

### Changed

- `_base/.claude/commands/` 6 files migrated to `_base/.claude/skills/*/SKILL.md` (Anthropic preferred format) — v1.8b

## [v1.7] - 2026-04-25

### Added

- `.harness.toml` schema v1.1 (additive only): `runtime_version`, `locale`, `statusline_cmd`, `statusline_timeout_ms`, `state_file`, `[agents]`, `[build]`, `format_cmd`

### Deprecated

- `[project].python_version` → use `runtime_version` (retained for backward compatibility)

## [v1.6] - 2026-04-24

### Changed (BREAKING)

- Removed Python dependency from global hooks/statusline (bash-only). Multi-language project support unblocked.

## [v1.5] - 2026-04-24

### Added

- AGENTS.md open-standard adoption strategy + symlink/copy dual deployment (`bootstrap/docs/AGENTS_MD_STRATEGY.md`)

## [v1.0–v1.4] - 2026-04 (early)

### Added

- Initial harness-meta bootstrap: global symlink installer, session ownership rules (S1–S7 + T1–T5 tie-breakers), `.harness.toml` schema v1.0, project architecture document set (ARCHITECTURE / DECISIONS / INTERVIEW / STACK)

For details on v1.10 and earlier, see `sessions/meta/` directly.

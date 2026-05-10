# Changelog

User-facing highlights for the harness-meta repo. For detailed change records, see `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v2.0+ 9-stage era) 또는 `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v1.0~v1.4 7-stage era).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/) at the `.harness.toml` schema level.

`!` after a version marker denotes a breaking change.

## [v2.1] - 2026-05-10

### Performance

- `tests/smoke-spec-verification.sh` — per-call python3 spawn (~150회) 패턴을 단일 batched python3 호출로 통합. 66.4s → 0.63s (99.05% 감소).
- `tests/smoke-scope-contract.sh` — Stage 1+2 batched python3 + Stage 3 bash 유지 + bash `detect_era()` 함수 제거 (Python 일원화). 12.4s → 0.65s (94.76% 감소).
- 전체 `pre-commit run --all-files` — 93.3s → 15.4s (83.49% 감소).

### Fixed

- Windows cp949 콘솔에서 em dash (U+2014) `UnicodeEncodeError` 회피 — `sys.stdout.reconfigure(encoding='utf-8')` 추가 (`smoke-python-entry-boilerplate § P2` v1.87 패턴 차용).

## [v2.0]! - 2026-05-10

### Changed (BREAKING)

- 7-stage workflow → 9-stage workflow (`ROADMAP (입력 source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE`). 단어 = 단일 책임 1:1 매핑 정정.
- milestone 산출 파일명: `PLAN.md → INTENT.md` rename, `APPROVE.md` / `PROPOSE.md` 신규.
- Historical 7-stage era (v1.0~v1.4) 11개 milestone 의 PLAN.md → INTENT.md `git mv` 마이그레이션 (history 보존). 4-tier era (v1.84~v1.88) 는 era 보존 정책 적용.
- ARCHITECTURE.md § 3.3 5요소 매트릭스 — 'Workflow' 행 9-stage 갱신 + 'Constraint' 행 APPROVE.md.approved_by gate + 'Trace' 행 산출 7종 enumerate.
- Smoke (smoke-spec-verification / smoke-scope-contract) 에 era 자동 식별 메커니즘 추가 — 산출 파일명 자체로 9-stage / 7-stage / 4-tier era 분기 검증.

### Added

- `APPROVE.md` (사용자 명시 승인 게이트) + `PROPOSE.md` (next_candidates ROADMAP 등록 forward 분리) 신규 stage 산출물.
- ARCHITECTURE.md § 6 era 정책 명문화 (4-tier / 7-stage / 9-stage 3 era 매트릭스 + 본 v2.0 milestone 자기참조 표지 명시).
- claude/hooks/post-report-write.sh — 9-stage era file pattern + write 시점 분기 inject 메시지 (REPORT → PROPOSE 안내, APPROVE → EXECUTE 진입 게이트, PROPOSE → ROADMAP 등록 안내).

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

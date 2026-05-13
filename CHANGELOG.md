# Changelog

User-facing highlights for the harness-meta repo. For detailed change records, see `projects/meta/milestones/v{X.Y}/REPORT.md` (v3.0+ 9-stage-bundled era) 또는 `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage era).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/) at the `.harness.toml` schema level.

`!` after a version marker denotes a breaking change.

## [Unreleased]

## [v5.0]! - 2026-05-14

### Breaking changes

- **Install 정책 전면 재설계** — harness-meta repo 자체를 **Claude Code Plugin** 으로 변환. `.claude-plugin/plugin.json` (manifest, paths 명시) + `.claude-plugin/marketplace.json` (local marketplace, source = `.`) 신규. 사용자 onboarding flow 전면 갱신 — 표준 명령 `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta` 채택 (v4.0_harness-composer-pivot ecosystem integrator 정체성 정합 두 번째 major bump).
- **자연어 호출 `~~harness-meta 설치해줘~~` 폐기** (deprecated since v5.0, v5.0+ 환경에서는 비활성) — historical narrative 만 보존. v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup retention) 도 historical 보존, 신규 환경 안 적용 부재.
- **component-installer agent 책임 분리** — custom component lifecycle (산출물 mechanical apply + plugin.json paths 갱신 + ad-hoc 검증, verifier) 책임 보존 + Plugin install lifecycle (mechanical) Claude Code CLI 위임. D7 sequence 본문은 historical 만 보존.
- **사용자 명시 manual cleanup 권고** — v4.x 환경 안 `~/.claude/agents/` 안 5 멤버 audit-team SymbolicLink (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) 잔존 시 dual-active 회피 위해 수동 제거 narrative (OS 별 정확 명령 = README.md#installation).

### Added

- **`.claude-plugin/plugin.json`** — Plugin manifest (name=harness-meta, version=5.0.0, paths 명시 = agents/commands/hooks/skills replace-default + add-to-default). 7 멤버 (5 team + 2 standalone) 자동 인식 paths 명시.
- **`.claude-plugin/marketplace.json`** — local marketplace 등재 (single plugin, source = `.`).
- **`claude/hooks/hooks.json`** — Plugin schema PostToolUse Write|Edit + SessionStart matcher (existing `claude/hooks/{post-report-write,session-init}.sh` 매핑, `${CLAUDE_PLUGIN_ROOT}` 변수 활용).
- **README.md / AGENTS.md / CLAUDE.md (root) Installation section** — `claude plugin marketplace add` + `claude plugin install` 표준 명령 narrative + migration cleanup OS 분기 (Linux/macOS `rm` + Windows PowerShell `Remove-Item`) + deprecation 표지.
- **ARCHITECTURE.md § 3.1 'Install 정책 = Claude Code Plugin spec 전면 채택' paragraph** — Plugin 채택 narrative 정전화. v4.3 'Install 정책 본질 + Plugin spec 대안' paragraph 는 'Historical narrative' subsection 으로 source 보존.
- **bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 책임 (v5.0)** — Plugin spec 채택 + component-installer 책임 분리 narrative.
- **cascade narrative deprecation 표지 14 host** — 모든 install/symlink/junction/D7 키워드 사용 host 안 'deprecated since v5.0, v5.0+ 환경에서는 비활성' 표지 추가 (v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle).
- **5 관점 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 모두 PASS / PASS_WITH_COMMENTS, FAIL 0, 의견 충돌 0** + 7 권고 흡수 (D6 commands precedent + hooks.json minimum schema + D10 책임 분리 구체화 + D3 PowerShell 동치 + D9 dual-active 검출 step 5 + D2 'v5.0+ 환경에서는 비활성' 명시).

### Removed

- **`bootstrap/claude-code-catalog/README.md.bak`** — v4.0 phase-4 산출물 backup 추정 cleanup (untracked .bak 파일 제거).

## [v4.2] - 2026-05-14

### Added

- **`bootstrap/agents/audit/environment-auditor.md`** — standalone subagent (read-only audit). `verify.{ps1,sh}` + `verify-lib.{ps1,sh}` 4 script 폐기 후 흡수. 10 stage 매트릭스 (Z 플랫폼 / A 환경 / B Symlink 또는 Junction 무결성 / C settings.json / D Hook / E Statusline / F backup / I Frontmatter V1~V10 / J PostToolUse / G Runtime-only). Bash 화이트리스트 (read-only 만, write 일체 금지).
- **`bootstrap/agents/audit/agents-md-sync.md`** — standalone subagent (write drift sync, default `-Check`). `sync-agents.{ps1,sh}` 폐기 후 흡수. 7 adapter (CLAUDE / GEMINI / .github/copilot / .cursor / CONVENTIONS / .clinerules / .roo) SHA-256 drift 감지 + sync. e3 정책 게이트 (default `-Check` drift detect / `-SourceWins` write = 사용자 명시 결정 후).
- **`bootstrap/agents/CLAUDE.md` § Audit/Sync 책임** — standalone subagent vs team 책임 경계 narrative 정전화 (standalone = 자연어 사용자 호출 / team = e3 cycle 5 멤버 순차).
- **`projects/meta/ARCHITECTURE.md` § 3.1 끝 paragraph** — 'mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리' narrative 정전화 (단일 source, v3.21 narrative 정전화 3 단계 패턴 6 cycle 누적). spec 의무 컴포넌트 (`claude/hooks/{session-init.sh, post-report-write.sh}` + `claude/statusline/statusline.sh`) agent 흡수 불가능 narrative.
- **Makefile `make verify` target stub** — stub message + agent 안내 (v4.0 phase-3 install stub 패턴 정합). 외부 cron/CI 끊김 시 명시 안내.

### Removed

- **6 script git rm (mechanical 폐기)** — `verify.ps1` + `verify.sh` + `verify-lib.ps1` + `verify-lib.sh` + `sync-agents.ps1` + `sync-agents.sh`. 총 -1667 LOC. v4.0 phase-3 install script 폐기 패턴 정합 (mechanical 본질 agent 흡수).
- **2 inactive smokes git rm** — `tests/_inactive/smoke-sync-agents.sh` + `tests/_inactive/smoke-verify-sh-parity.sh`. 참조 대상 폐기 = 의미 zero. 총 -222 LOC.
- **`claude/CLAUDE.md`** Hook 추가 시 절차 안 'verify.{ps1,sh} 갱신' line 폐기.
- **`tests/CLAUDE.md`** inactive smoke 표 2 row (`smoke-sync-agents.sh` + `smoke-verify-sh-parity.sh`) 제거.

## [v4.0]! - 2026-05-13

### Breaking changes

- **정체성 전면 재정의** — harness-meta 가 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 로 pivot. 단일 source = `projects/meta/ARCHITECTURE.md` § 3.1 끝 paragraph. 5 host (root CLAUDE.md / AGENTS / README / projects/meta/CLAUDE.md / ARCHITECTURE) cross-ref 정전화.
- **§ 6.2 동결 정책 폐지** — 구 "Lightweight 모드 정책 + Workflow self-improvement 동결 + Narrative 정전화 3단계 + 선례 2건" paragraph 모두 ARCHITECTURE.md 안 제거. 새 정체성이 자연 가드레일.
- **install script 3개 폐기 (B3)** — `install.ps1` + `install-skills.ps1` + `install-skills.sh` 모두 삭제 (총 -1484 LOC). mechanical install/update/cleanup 작업은 agent (`component-installer`) 가 흡수 (D7 sequence). 첫 진입 = Claude Code 안 자연어 호출 (`harness-meta 설치해줘`).
- **메타 milestone 40 디렉토리 → `_archive/`** — v1.0~v3.21 모든 milestone 디렉토리 `projects/meta/milestones/_archive/` 일괄 git mv (history 보존). v4.0/ 만 활성 위치 유지. upbit (`projects/upbit/`) 현 위치 보존 (A2).

### Added

- **`bootstrap/agents/`** — 글로벌 subagent + agent team source-of-truth 디렉토리 신설. 두 층 구조 (글로벌 vs 프로젝트 특화 `projects/<name>/.claude/agents/`).
- **`bootstrap/agents/CLAUDE.md`** — 정책 narrative (두 층 + conflict resolution 4 case 매트릭스 + agent fleet lifecycle 5 case 매트릭스 + D7 mechanical sequence + 신규 추가 절차 + 벤치마크 cycle).
- **`bootstrap/claude-code-catalog/README.md`** — Claude Code 도구 카탈로그 단일 host (code.claude.com/docs context7 `/websites/code_claude` + built-in slash command 인벤토리 + plugin/MCP 인벤토리 + 자주 묻는 query 카탈로그).
- **첫 agent team `project-harness-audit-team`** (5 멤버) — `bootstrap/agents/audit/project-harness-audit-team/`:
  - `project-scanner` (read-only) — 코드베이스 scan + 메타데이터 JSON
  - `harness-gap-analyzer` (read-only) — 3 축 gap detection
  - `claude-docs-mapper` (read-only, mcp context7) — gap → 도구 카탈로그 매핑
  - `component-proposer` (Write draft, e3 게이트) — proposal draft markdown
  - `component-installer` (write apply, opus, Bash 화이트리스트) — D7 mechanical
- **`/harness-meta <name> --audit` opt-in** — `claude/commands/harness-meta.md` Stage A entry 안 conditional 분기. flag 명시 시 audit team 자동 호출, freeform default 보존 (회귀 0).
- **벤치마크 cycle routine** — `schedule` skill 활용 주 1회 cron (GitHub 인기 repo + Claude Code release notes/changelog). 산출물 host = `projects/meta/ROADMAP.md` 안 `candidate_draft[]` 신 필드 (e3 정책 정합).

### Changed

- **smoke `_archive/` sentinel 자동 skip** — `tests/smoke-bundle-trigger.sh` + `tests/smoke-cross-ref.sh` regex 안 `(_archive/)?` optional group 추가.
- **`bootstrap/skills/CLAUDE.md`** — 배포 섹션 + 신규 user-skill 추가 절차 안 install-skills.{ps1,sh} 명령 reference 제거. `bootstrap/agents/CLAUDE.md` 단일 source cross-ref.
- **ROADMAP `schema_note`** — `candidate_draft[]` 신 필드 정의 추가 (id/title/source/detected_at/rationale/category/decision_pending).

### Removed

- `install.ps1` (534 line) — root install script
- `install-skills.ps1` (610 line) — Windows user-skill install
- `install-skills.sh` (340 line) — POSIX user-skill install
- ARCHITECTURE.md § 6.2 (line 182~205) — paragraph 4건 (Lightweight + Workflow 동결 + Narrative 정전화 3단계 + 선례 2건)

### Migration

기존 `~/.claude/skills/` 5 symlink (ai-ready-scorer / harness-plan-verify / harness-roadmap-update / mindvault / developer-profile) 보존 — 현 작동 유지. 신규 install / reinstall / cleanup 필요 시 Claude Code 안 자연어 호출 (`harness-meta 설치해줘`) 또는 `component-installer` subagent 호출.

## [v3.16] - 2026-05-13

### Changed

- CHANGELOG.md [Unreleased] 섹션을 Keep a Changelog v1.1.0 권장 위치(최상단)로 이동. 5 항목(CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG) 을 v1.0~v1.4 entry로 귀속. [v3.15] entry 추가 (backfill 완료 기록). Lightweight 모드 누적 6건째. 단일 phase 1 commit (`e9dffa1`). pre-commit 14 hook PASS, 회귀 0.

## [v3.15] - 2026-05-13

### Added

- CHANGELOG.md v3.0~v3.14 14 entry backfill — v3.0 `!` BREAKING 마커 + v3.1~v3.14 13 entry 역순 삽입. Keep a Changelog v1.1.0 정합. Lightweight 모드 단일 phase 1 commit (`d3eddaa` + Stage G `74afedb`). pre-commit 14 hook PASS, 회귀 0.

## [v3.14] - 2026-05-13

### Changed

- ROADMAP `deferred_note` — `v3.14_deferred-revaluation-cycle-2` cycle 2 verdict 갱신 (옵션 A 동결 유지). v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline 3 entry `deferred_reason` 안 cycle 2 cross-ref 추가.
- v3.13 cycle 1 직접 후속 — § 6.2 재발의 trigger 조건 (1) PASS (10건 누적) ∧ 조건 (2) FAIL (direct 0 + indirect 0 + reverse 5) = AND FAIL → 재발의 trigger 미충족.
- Lightweight 모드 단일 phase 1 commit (`f50ad5d` + `a5a9178`). pre-commit 14 hook PASS, 회귀 0.

## [v3.13] - 2026-05-12

### Changed

- ROADMAP — v1.x pending 3건 (`v1.4_hook-narrative-separation` / `v1.4_design-review-trace` / `v1.5_research-cascade-grep-discipline`) status `pending` → `deferred` + `deferred_reason` 신 필드 + `deferred_note` 갱신.
- § 6.2 workflow self-improvement 동결 정책 직접 적용 — 외부 `projects/<name>` (name ≠ meta) 실 적용 milestone 1건 완료 + 정량 데이터 기반 명시 발의 trigger 조건 부재 시 동결 유지.
- v2.0_workflow-word-fidelity lessons `next_candidates#1` origin 사용자 명시 선택 (A_user 재분류).

### Added

- `renumbered_from` 필드 도입 — `v2.1_pending-milestone-renumber-policy` (v1.x era pending) → v3.13 forward-only renumber 첫 정식 사용.
- Lightweight 모드 자연 적용 (`a86334c`) — 5 관점 subagent 검토 생략, 산출물 LOC ~673 (baseline 850 미만). 1 phase 1 commit, pre-commit 14 hook PASS, 회귀 0.

## [v3.12] - 2026-05-12

### Changed

- `bootstrap/skills/audit/harness-{plan-verify,roadmap-update}/SKILL.md` — `sessions/` 거명 9건 일괄 정리. DEPRECATED 블록 내 역사적 서술 보존.
- Lightweight 모드 1 phase 1 commit (`446485b`), pre-commit 14 hook PASS, 회귀 0.

## [v3.11] - 2026-05-12

### Changed

- Stale narrative 3위치 일괄 정리: `claude/CLAUDE.md` L39 PostToolUse 섹션 9-stage-bundled era 표기 + `projects/upbit/ARCHITECTURE.md` L106 현행 안내 stale path + `CHANGELOG.md` L3 era 카테고리 정합화 (3 era).
- `v1.5_legacy-narrative-cleanup` (v1.x era pending) → v3.11 forward-only renumber (`renumbered_from` 필드 도입 첫 사례).
- Lightweight 모드 1 phase 1 commit (`40faa23`), pre-commit 14 hook PASS, 회귀 0.

## [v3.10] - 2026-05-11

### Changed

- `claude/commands/harness-meta.md` — Stage B/C/D 정의에 (a) 사실 진술 vs (b) 후속 발의 의미 분리 narrative 추가.
- Stage I (PROPOSE) — Stage B/C/D 부산물 통합 흡수 책임 + `A_user` dual origin 명시.
- `projects/meta/ARCHITECTURE.md` § 4 9-stage 표 직후 cross-ref 1줄 추가.
- Lightweight 모드 1 phase 1 commit (`4e1981f`). 도그푸드 정합 (산출물 안 forward propose 명령형 부재 grep 검증). pre-commit 14 hook PASS, 회귀 0.

## [v3.9] - 2026-05-12

### Added

- `tests/CLAUDE.md` — '회귀 검증 절차' 섹션 하단 `### smoke 파일 이동(git mv) 시 체크리스트` subsection 4단계 추가.
- 1 phase 1 commit (`9587f52`), pre-commit 14 hook PASS, 회귀 0.

## [v3.8] - 2026-05-11

### Fixed

- `tests/_inactive/` 이동 후 `cd '$(dirname $0)/..'` 가 `tests/` 로 잘못 해석되는 버그 8 파일 일괄 수정 (→ `../..`): `smoke-detect-language` / `smoke-roi-regression` / `smoke-backup-cleanup` / `smoke-bootstrap-agents-md` / `smoke-bootstrap-render` / `smoke-skills-install` / `smoke-sync-agents` / `smoke-python-entry-boilerplate`.

### Added

- `tests/CLAUDE.md` — inactive smoke 경로 규약 1줄 추가.
- 1 phase 1 commit (`2e25eff`), pre-commit 14 hook PASS, 대표 inactive smoke 2건 6/6 PASS.

## [v3.7] - 2026-05-11

### Added

- `tests/smoke-posttooluse-hook.sh` — INTENT/APPROVE/PROPOSE 9-stage 테스트 3건 (Tests T/U/V) 추가, 25/25 PASS. 헤더 카운트 19 → 22.
- v2.0_workflow-word-fidelity 의 INTENT/APPROVE/PROPOSE 분기 coverage gap 보완 (`absorbed_from: v2.1_smoke-posttooluse-9stage-tests`).
- 1 phase 1 commit (`030e68e`), pre-commit 14 hook PASS, 회귀 0.

## [v3.6] - 2026-05-11

### Added

- `projects/meta/ARCHITECTURE.md` § 6.2 — workflow self-improvement 동결 정책 narrative 신설 (lightweight 모드 trigger 3건 + narrative cap 정책 + 재발의 trigger 조건).
- `tests/_inactive/` — inactive smoke 22 archive (git mv, CI 정책 정합).

### Changed

- `.github/workflows/ci.yml` — inactive smoke 22 archive 정합화.
- Lightweight 모드 자기참조 회피 표지 적용 (v2.0_workflow-word-fidelity 선례 chicken-and-egg 회피) — 5 관점 subagent 검토 생략 + 산출물 LOC cap.
- 3 phase / 3 commit (`4ef8a74` + `9ba1eb1` + Stage G+H+I 통합), pre-commit 14 hook PASS, 회귀 0.

## [v3.5] - 2026-05-11

### Added

- `tests/smoke-open-stage-discipline.sh` 신규 + pre-commit hook 등록 (13 → 14 active).
- `claude/commands/harness-meta.md` Stage D 끝 sub-section 'Stage D 완료 직전 의무 step' — `phases[]` 확정 후 `milestones.md sub_milestones` 1:1 동기 갱신 의무.

### Changed

- `tests/CLAUDE.md` 매트릭스 5 영역 갱신 (헤더 28 → 29 / narrative 7 active / 핵심 정책 검증 표 row + 현행 hook 표 row + inactive 22 active 카운트).
- v3.0+ 9-stage-bundled era 두 번째 bundle 사례 (첫: v3.1). 2 phase 2 commit (`35c621c` + `a4aa8c7`), pre-commit 14 hook PASS (3회), 회귀 0.

## [v3.4] - 2026-05-11

### Changed

- `claude/commands/harness-meta.md` Stage A OPEN 절차에 step 7 신규 추가 — `milestones/v{X.Y}/milestones.md` 스켈레톤 즉시 작성 (v3.0+ 9-stage-bundled era 의무, narrative 1차 source).
- Stage F 선결 조건 게이트 블록 narrative 미세 갱신 — DRY 회피 + 보조 검증 step 명시.
- Skeleton 최소 필드 narrative 1차 source 위치 Stage F 게이트 → Stage A step 7 로 이동.
- 자기참조 부합 (도그푸드) — v3.4 OPEN 단계 자체가 본 절차 첫 적용.
- 단일 phase 1 commit (`c3c35a9`), pre-commit 13 hook PASS, 회귀 0.

## [v3.3] - 2026-05-11

### Changed

- `.github/workflows/ci.yml` — glob 28건 → active 6건 명시 배열 (`ACTIVE_SMOKES`). inactive smoke 16건 CI 제외로 즉시 green 복구.
- inactive smoke 파일 보존.
- 1 phase 1 commit (`14b36ff`), pre-commit 13 hook PASS, 회귀 0.

## [v3.2] - 2026-05-11

### Changed

- `claude/commands/harness-meta.md` Stage F 선결 조건 게이트 블록 신규 — milestones.md 선결 의무 CRITICAL + INTENT~APPROVE commit 시점 3 패턴.
- `tests/CLAUDE.md` — controlled 비교 cp949 mojibake 정상 작동 narrative.
- Skeleton 매트릭스 2 row — era 분류 vs schema 책임 분리 + status 기반 분기.
- 3 phase 3 commit (`1220a2d` + `6483d1b` + `de7f62a`), pre-commit 13 hook PASS, 회귀 0.

## [v3.1] - 2026-05-10

### Added

- `tests/smoke-bundle-trigger.sh` 신규 + pre-commit 등록 (12 → 13 hook, 자동 강제 누적).
- `milestones/v3.0/milestones.md` 신규 (R1 CRITICAL mitigation — v3.0+ 9-stage-bundled era narrative 1차 source).

### Changed

- `tests/CLAUDE.md` § '흔한 함정' 7번째 row 추가 — markdownlint trap narrative (MD049 spec 직접 인용).
- Historical era 적용 결정 — forward-only 강제 (v3.0 milestones.md unchanged D12 사용자 결정 P1).
- v3.0+ 9-stage-bundled era 첫 후속 통합 milestone 사례 (도그푸드 누적).
- 3 phase 3 commit (`0a86598` + `4bd4ec6` + `d136b2f`), pre-commit 13 hook PASS, 회귀 0.

## [v3.0]! - 2026-05-10

### Changed (BREAKING)

- milestone hierarchy 재구성 — `milestones/v{X.Y}_{slug}/` flat → `milestones/v{X.Y}/` (sub-id 부재) + `milestones.md` (sub-milestone listing per version) + version > sub-milestone > phase 계층화.
- ROADMAP `milestones[]` schema 변경 — `{version, id (group-slug), title, status, summary, trigger, milestones_path?}` 신 schema. v2.0~v2.1 / v1.0~v1.4 보존 entry 는 기존 schema (`id` flat = `v{X.Y}_{slug}`) 유지 (forward-only).
- smoke era 분기 도입 — `tests/_era_detect.py` 분리 (v2.2_era-detect-shared-module 흡수).
- 자기참조 부합 — v3.0 자체가 신 구조 첫 적용 사례 (도그푸드).
- breaking change → major bump (v2 → v3).

### Added

- `projects/meta/milestones/v3.0/milestones.md` (sub-milestone listing per version) 도입.
- v2.2_* 4건 흡수 (`absorbed_milestones`: `v2.2_era-detect-shared-module` phase-2 / `v2.2_smoke-cp949-encoding-pattern` phase-6 / `v2.2_smoke-controlled-comparison-pattern` phase-7 / `v2.2_historical-7stage-stage1-decision` phase-8).
- 8 phase (smoke era branching → `_era_detect.py` 분리 → 정책 명문화 → ROADMAP schema 변경 → `milestones.md` → cp949 / controlled-comparison / historical-decision 잔여 흡수).

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
- `.github/workflows/ci.yml` — smoke tests auto-run on push and pull_request
- `.pre-commit-config.yaml` + `.markdownlint.json` + `.markdownlintignore` — shellcheck + markdownlint enforcement (frontmatter-based directories excluded)
- `GUARDRAILS.md` — meta-repo session behavior guardrails (forbidden actions, confirmation-required operations, scope contract obligations)
- `.env.example` — `HARNESS_META_ROOT` environment variable reference
- `CHANGELOG.md` — this file

For details on v1.10 and earlier, see `sessions/meta/` directly.

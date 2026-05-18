# Changelog

User-facing highlights for the harness-meta repo. For detailed change records, see `projects/meta/milestones/v{X.Y}/REPORT.md` (v3.0+ 9-stage-bundled era) 또는 `projects/meta/milestones/v{X.Y}_{slug}/REPORT.md` (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage era).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/) at the `.harness.toml` schema level.

`!` after a version marker denotes a breaking change.

## [Unreleased]

## [v5.20] - 2026-05-19

### Changed

- **audit-team 외부 호출 cycle 7 + ARCHITECTURE § 4 끝 7 paragraph 매트릭스화 + agent namespace prefix cascade** — stability cycle 두 번째 완성 (cycle 5+6+7 동일 upbit baseline + R1+R2 3 cycle 연속 APPLIED + 신규 proposal 0건 converged). v5.19 PROPOSE#4+#8 + spec-drift D1 동시 흡수. § 4 끝 매트릭스 (7 narrative paragraph) 신규 + L135 vector count 6→7. agent namespace prefix cascade 7 위치 (Plugin spec v5.0+ namespace 정합). hallucination 2건 mapper origin + cascade inline 정정. narrative effect isolation 한계 첫 확인. v3.21 narrative 정전화 3 단계 패턴 cycle 21+22 도그푸드. 4 commit / 7 lessons. 자세히: [`projects/meta/milestones/v5.20/REPORT.md`](projects/meta/milestones/v5.20/REPORT.md)

## [v5.19] - 2026-05-19

### Changed

- **audit-team 외부 호출 cycle 6 + stability cycle 첫 완성** — upbit cycle 6 + v5.18 Input Verification H2 sub-section + 검증 method 분리 narrative 첫 실전 + stability cycle 첫 완성 (cycle 5+6 사이 upbit commit 0 + R1+R2 2 cycle 연속 APPLIED + 신규 gap 2 cycle 연속 0건). hallucination 0건 (혼합 origin, 분리 evidence cycle 7+ 필요). MD034 11건 inline 정정 (mapper-output.md). ecosystem integrator vector 6건 누적. self-loop monotonic 감소 (78.3% → 76%, 19/25). v3.21 cycle 19+20 도그푸드. 2 commit / 7 lessons. 자세히: [`projects/meta/milestones/v5.19/REPORT.md`](projects/meta/milestones/v5.19/REPORT.md)

## [v5.18] - 2026-05-18

### Added

- **audit chain agent prompt `## Input Verification` H2 sub-section 신규** — Read tool 보유 멤버 (scanner / harness-gap-analyzer) 직접 Read 의무 / Read tool 부재 멤버 (claude-docs-mapper / component-proposer) D10 우회 패턴 = orchestrator inline 첨부 본문 직접 인용. v5.13 절차 정전화 2 위치 안 '검증 method 분리 (boolean/표/수치 별 매핑 method)' sub-narrative 흡수. v5.17 PROPOSE#1+#4 통합 (audit chain hallucination cycle 9 누적 trigger). v3.21 cycle 19 도그푸드. 1 phase 통합 commit (2e44260, 8 파일 72+/2-). 7 lessons. 자세히: [`projects/meta/milestones/v5.18/REPORT.md`](projects/meta/milestones/v5.18/REPORT.md)

## [v5.17] - 2026-05-18

### Changed

- **audit-team 외부 호출 cycle 5** — upbit cycle 5 + v5.15 cycle 4 diff + v5.16 lint precheck 절차 첫 실전 적용 + v5.13 fact 검증 절차 세 번째 실전 (cycle 7+8+9 = 8건 inline 정정). ecosystem integrator vector 5건 누적. v1.20 R1+R2 stability. self-loop 78.3% (monotonic 감소). v3.21 cycle 18 도그푸드. 2 commit / 7 lessons. 자세히: [`projects/meta/milestones/v5.17/REPORT.md`](projects/meta/milestones/v5.17/REPORT.md)

## [v5.16] - 2026-05-18

### Added

- **audit chain 산출 markdown lint precheck 절차 정전화 — MD022/MD031/MD032 hardcode** — audit chain 산출물 산출 4 멤버 (project-scanner/harness-gap-analyzer/claude-docs-mapper/component-proposer, D8 Step 1~4) markdown 산출물의 markdownlint MD022 (blanks-around-headings) + MD031 (blanks-around-fences) + MD032 (blanks-around-lists) 3 rule 위반 사전 방지 절차 narrative 정전화. v5.13 3-layer cross-ref 구조 패턴 정합 (Layer A § 4 끝 paragraph + Layer B D8 Note v5.16 + Layer C --audit step). v5.15 PROPOSE#2 carry-over (v5.14 L7 + v5.15 L5 누적 2 사례). v3.21 cycle 17 도그푸드. lightweight 12/30 = 40% 첫 돌파. 1 phase 2 commit (be138c2 + 55c6dfa). 7 lessons. 자세히: [`projects/meta/milestones/v5.16/REPORT.md`](projects/meta/milestones/v5.16/REPORT.md)

## [v5.15] - 2026-05-18

### Changed

- **audit-team 외부 호출 cycle 4** — upbit cycle 4 + v5.14 cycle 3 diff + v5.13 fact 검증 절차 두 번째 실전 적용. ecosystem integrator vector 4건 누적 = self-loop 카운팅 정전화 (17/21=81% 정확 누적). 4 산출물 + diff-vs-cycle3 (v1.19 apply 4 항목 효과 검증 sub-section). v1.20 milestone trigger candidate. v3.21 cycle 16 도그푸드. 7 lessons. 자세히: [`projects/meta/milestones/v5.15/REPORT.md`](projects/meta/milestones/v5.15/REPORT.md)

## [v5.14] - 2026-05-18

### Changed

- **audit-team 외부 호출 cycle 3 + v5.13 fact 검증 절차 첫 실전 적용** — upbit cycle 3 + v5.10 audit diff. v5.13 3-layer 정전화 절차 첫 실전 = 4 산출물 안 총 5건 hallucination inline 정정 (scanner 1 + mapper 1 + proposer 3). gap: G1(stale cp 지속) / G2(CLAUDE.md symlink narrative 신규) / G3(session-init hook 지속) / S2(spike-investigator 재활성). 사용자 4건 모두 Accept → v1.19 upbit milestone trigger. ARCHITECTURE.md L135 vector count 2건→3건. 2-phase 2 commit (0335d01 + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.14/REPORT.md`](projects/meta/milestones/v5.14/REPORT.md)

## [v5.13] - 2026-05-18

### Added

- **audit chain fact 검증 절차 3-layer 정전화 (WHAT + WHERE + HOW)** — `claude/commands/harness-meta.md` --audit 분기 proposal-draft 직후 synthesizer fact 직접 검증 step + `agents/project-harness-audit-team/CLAUDE.md` D8 sequence 코드블록 직후 Note (v5.13) + ARCHITECTURE.md § 4 끝 cross-ref append. v5.12 PROPOSE#1 carry-over (cycle 3 evidence 도달). 3 관점 검토 pass_with_comments + blocking 없음. v3.21 cycle 15 도그푸드. 1-phase Lightweight. commit 5d673ba + chore. 7 lessons. 자세히: [`projects/meta/milestones/v5.13/REPORT.md`](projects/meta/milestones/v5.13/REPORT.md)

## [v5.12] - 2026-05-18

### Fixed

- **`/review`·`/security-review`·`/init` 'Skill tool 안 invoke 가능 built-in command' 분류 정확화 (bundled skill 별 분류 아님)** — v5.10 mapper-output.md L100/L102/L105/L180/L198/L215 6 위치 + diff-vs-v1.17.md L87 = drift origin = audit chain hallucination cycle 3 도달 (cycle 1 v5.10 proposer / cycle 2 v5.11 scanner / cycle 3 본 v5.12 mapper). v5.11 PROPOSE#1 trigger 충족. Stage E APPROVE 5 관점 검토 decisive issue 발견 후 scope 7→9 파일 재정의. hybrid 정정 (inline 4 + footnote 5). v3.21 cycle 14 도그푸드. 1 phase 2 commit (ed3ddbd + 74f99df). 7 lessons. 자세히: [`projects/meta/milestones/v5.12/REPORT.md`](projects/meta/milestones/v5.12/REPORT.md)

## [v5.11] - 2026-05-18

### Fixed

- **audit chain fact 인용 검증 의무 ARCHITECTURE § 4 끝 paragraph 정전화 + v5.10/v1.17 audit 산출물 hallucination 정정** — memory `feedback_subagent_fact_hallucination_correction` 누적 2 cycle direct evidence 도달 (v5.10 component-proposer 12 항목 표 hallucination + v5.11 project-scanner `claude_md_in_repo: false` hallucination). v5.10 audit chain 4 산출물 안 14 위치 inline 정정 (O1 archive with correction narrative, audit trail 보존). v5.10 PROPOSE#4 entry block stale 표지 + 정정 narrative. v3.21 cycle 13 도그푸드. 1 phase 2 commit (a6fcf4e + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.11/REPORT.md`](projects/meta/milestones/v5.11/REPORT.md)

## [v5.10] - 2026-05-18

### Added

- **외부 audit-team 두 번째 실 호출 (upbit) + v1.17 산출물 diff + ARCHITECTURE § 4 끝 cascade drift paragraph 정전화** — v5.9 PROPOSE#5 사용자 선택 후 Stage A OPEN 안 v1.17 (2026-05-14) 'first call' 사실 발견 → 'second call + diff' scope 재조정. audit chain 4 멤버 read-only 재호출 (`projects/upbit/audit-2026-05-18/` 안 4 산출물). proposer agent hallucination 1건 → synthesizer overwrite 정정 (L1). v3.21 cycle 12 도그푸드. 2 phase 2 commit (36d364b + 2bd6baa). 7 lessons. 자세히: [`projects/meta/milestones/v5.10/REPORT.md`](projects/meta/milestones/v5.10/REPORT.md)

## [v5.9] - 2026-05-17

### Changed

- **사전적 의미 vs 실 책임 3 축 (name + 9-stage + ROADMAP) 통합 부합도 audit + § 4 끝 'ROADMAP 단어 drift 수용' paragraph 정전화** — 축 A (harness-meta name) 77.5% 운용 / 축 B (9-stage) 86.1% baseline (v3.19 baseline 유지) / 축 C (ROADMAP) ~30~40% (v5.21 drift 해소 trigger 1차 source) 진단. ARCHITECTURE § 4 끝 #3 paragraph 정전화 (옵션 B 사용자 명시). lightweight 모드 5 cycle 누적 + v3.21 cycle 11 도그푸드. 2 commit (08b1719 + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.9/REPORT.md`](projects/meta/milestones/v5.9/REPORT.md)

## [v5.8] - 2026-05-17

### Added

- **v4.0 정체성 ↔ 실 운용 vector drift 진단 + ARCHITECTURE § 3.1 끝 '정체성-운용 vector drift 수용' paragraph 정전화** — 12 meta self-loop + 1 외부 v1.17 audit-team 완전 작동 = 92.3% self-loop / sub-metric 가중 평균 77.5% (composer 50% + integrator 60% + maintainer 70%). round 2 RESEARCH 보강 § A1~A9 + round 4 D2 전면 재작성 cascade. lightweight 모드 자기 검토 4번째. v3.21 cycle 10 도그푸드. 1-phase 2 commit (f4fef24 + chore). 7 lessons. 자세히: [`projects/meta/milestones/v5.8/REPORT.md`](projects/meta/milestones/v5.8/REPORT.md)

## [v5.7] - 2026-05-16

### Added

- **spec-drift spike 패턴 ARCHITECTURE § 6 정전화** — v4.2 + v5.6 두 origin 자연 발현 spec-drift spike 패턴 (RESEARCH 추정 → DESIGN 식별 → Stage F spike or DESIGN 즉시 정정 → DESIGN.decisions hardcode 4 단계) ARCHITECTURE.md § 6 본문 안 bold lead paragraph 1건 정전화. v3.21 narrative 정전화 3 단계 패턴 cycle 9 완성. Lightweight + 1-phase 2 commit (da94db7 + ff21e0a). 7 lessons. 자세히: [`projects/meta/milestones/v5.7/REPORT.md`](projects/meta/milestones/v5.7/REPORT.md)

## [v5.6] - 2026-05-14

### Added

- **environment-auditor Stage B 확장 — BP3 Plugin activation + BP4 G AUTO 통합 검증 신규** — Stage B 가 5 sub-step (B0/BP1/BP2/BP3/BP4) 으로 확장. BP3 = `claude plugin list --json` 출력 안 `harness-meta@harness-meta` entry 의 `enabled: true` 검증 (python3/jq parse, regex fallback). BP4 = G AUTO 부분 통합 single sub-step (commands/harness-meta.md 파일 존재 + skills/*/SKILL.md list + @ROADMAP.md grep + projects/meta/CLAUDE.md 파일 존재 + 5 subdir CLAUDE.md list). 10 stage 매트릭스 narrative 보존.
- **environment-auditor Bash 화이트리스트 § 확장** — `claude plugin list` / `claude plugin list --json` (read-only side-effect-free) + `Get-Command claude` (pwsh) / `command -v claude` (bash) D8 fallback 사전 check. `claude plugin details` 채택 회피 (docs 미등재).

### Changed

- **environment-auditor § G 5 항목 책임 표기 추가** — G 5 항목 (G1~G5) narrative 보존 + 각 항목에 'AUTO 부분 (BP4 흡수) + MANUAL 부분 (G 잔존)' 책임 표기. G 본질 = '실 세션 효과 인식, audit 책임 외'. 분류 기준 = audit 책임 (binary 상태 검증) 단일 책임 매핑.
- **D11 disabled 상태 분기 narrative + `/reload-plugins` cross-ref** — `claude plugin disable harness-meta` 후 audit 시 WARN 메시지 + `/reload-plugins` slash command 세션 적용 narrative 흡수 (spec-drift 4 관점 검토 권고).
- **bootstrap/agents/CLAUDE.md L110 cascade drift fix (v5.5 누락)** — environment-auditor 책임 narrative 안 'B Symlink 또는 Junction 무결성' (v5.5 이전 narrative 잔존) → 'B Plugin install + activation 검증 (5 sub-step, v5.5 Plugin 전환 + v5.6 BP3/BP4 신규)' 동기.

## [v5.5] - 2026-05-14

### Changed

- **environment-auditor Stage B — Plugin install 검증으로 전면 교체** — 기존 Stage B (Symlink/Junction 무결성 B1~B6) 를 Plugin install 검증 (B0 cache 존재 + BP1 agents/ + BP2 skills/) 으로 교체. v5.0+ Plugin install 환경에서 실질적 헬스 체크 수행.
- **environment-auditor A1 (Developer Mode 체크) 삭제** — Plugin install 기반으로 Developer Mode 의존 없음 — 불필요한 check 제거.
- **environment-auditor 해결 방안 narrative** — `harness-meta 설치해줘` → `claude plugin install harness-meta@harness-meta` 로 갱신.

### Removed

- **skills/harness-roadmap-update/SKILL.md 보안 표 install-skills 행 삭제** — v4.0 에서 폐기된 install-skills 스크립트 패턴 참조 제거.

## [v5.4] - 2026-05-14

### Changed

- **marketplace.json `source: "./"` 현행 유지 결정 (spec 검증)** — context7 Claude Code Plugin spec 재검증: Git repository marketplace (GitHub shorthand + local clone)에서 plugin entry source = `"./"` (relative path)가 spec-correct. GitHub source 객체 (`{ "source": "github", "repo": "..." }`)는 URL-based marketplace 전용 — Git repository marketplace에 적용 부적절. 코드 변경 없음, 결정 근거 milestone 산출물(v5.4 RESEARCH/DESIGN)에 영구 보존.

### Fixed

- **§ 6.2 cross-ref 잔존 drift 해소 (v4.0 cleanup cascade 누락)** — v4.0_harness-composer-pivot 에서 § 6.2 폐지 narrative 도입했으나 active 3 위치 cascade 누락. v5.4 사용자 review 중 발견 → 즉시 fix: `projects/meta/ARCHITECTURE.md` L129 (drift 수용 narrative) + `tests/CLAUDE.md` L9 (smoke 매트릭스 narrative) + L294 (archive narrative). `projects/meta/milestones/v5.4/PROPOSE.md` 신규 작성 안 잘못된 사용도 동시 fix.

## [v5.3] - 2026-05-14

### Added

- **외부 marketplace 등록 — GitHub shorthand onboarding (clone 불요)** — `claude plugin marketplace add pdw96/harness-meta` 를 PRIMARY 설치 경로로 추가. 기존 local clone 경로 (`~/harness-meta`) 는 ALTERNATIVE (로컬 dev / 오프라인) 로 재배치. GitHub shorthand 는 전체 repo clone → `.claude-plugin/marketplace.json` `"source": "./"` 정상 작동 (context7 spec 확인). marketplace.json 변경 없음.
- **cascade 7 파일 갱신** — `README.md` + `AGENTS.md` + `CLAUDE.md` + `agents/component-installer.md` + `bootstrap/agents/CLAUDE.md` + `projects/meta/ARCHITECTURE.md` + `Makefile` 안 install narrative 에 Option A (GitHub shorthand) / Option B (로컬 clone) 병렬 표기 적용.

## [v5.2] - 2026-05-14

### Fixed

- **agents functional audit path stale drift 해소** — `environment-auditor.md` + `harness-gap-analyzer.md` + `component-installer.md` + `bootstrap/claude-code-catalog/README.md` 내부 functional path (glob 대상 경로 + 신규 추가 위치 명시) 갱신. v5.1 Phase 1+2 git mv (agents/ flat + skills/ flat) 후 잔존 stale path 완전 해소. (`bootstrap/agents/audit/`, `bootstrap/skills/{audit,dev-tools}/` → `agents/`, `skills/` 신 위치).

## [v5.1] - 2026-05-14

### Fixed

- **Plugin 구성요소 인식 spec drift 해소** — `claude plugin details` Agents (0) + Skills (1 of 5) 인식 부족 (v5.0 VERIFY R1 drift 직접 후속). agents 필드 제거 (plugin_root `./agents/` default discovery) + skills 필드 `./bootstrap/skills/` → `./skills/` (1단계 flat) — 7 agents + 5 skills 전체 인식.

### Added

- **`agents/` (plugin_root standard location, v5.1+)** — 7 subagent `.md` 파일 `bootstrap/agents/` 에서 1단계 flat 재배치 (git mv). `bootstrap/agents/` = CLAUDE.md narrative-only 컨테이너 보존.
- **`skills/` (plugin_root standard location, v5.1+)** — 5 skill 디렉토리 `bootstrap/skills/{audit,dev-tools}/` 에서 1단계 flat 재배치 (git mv). `bootstrap/skills/` = CLAUDE.md narrative-only 컨테이너 보존.
- **cascade narrative 9 host 갱신** — `bootstrap/{agents,skills}/CLAUDE.md` + `GUARDRAILS.md` + `claude/CLAUDE.md` + `CLAUDE.md (root)` + `AGENTS.md` + `projects/meta/ARCHITECTURE.md § 3.1` + `bootstrap/claude-code-catalog/README.md` + `CHANGELOG.md`.

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

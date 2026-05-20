# 프로젝트: harness-meta

Claude Code 하네스의 **project harness composer + Claude Code ecosystem integrator + agent fleet maintainer** — v5.0 부터 **Claude Code Plugin** 으로 배포. 대상 프로젝트를 분석하고 [code.claude.com/docs](https://code.claude.com/docs/) 의 Claude Code 도구 카탈로그 (docs + built-in slash command + plugin/MCP) 를 활용하여 적재적소 harness 구성요소 (subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin) 를 만들어 배치한다. 본 repo 자체가 Claude Code Plugin (`.claude-plugin/plugin.json` manifest + paths 명시) — `claude plugin marketplace add pdw96/harness-meta` (외부, clone 불요) 또는 `claude plugin marketplace add ~/harness-meta` (로컬 clone) + `claude plugin install harness-meta@harness-meta` 표준 명령으로 install. `component-installer` agent 는 custom component lifecycle (milestone 산출물 mechanical apply) 책임 — Plugin install lifecycle 은 Claude Code CLI 위임. 정전 정의: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3.1 끝.

**License**: MIT ([LICENSE](LICENSE)) — 오픈소스 사용·포크·기여 허용.
**AGENTS.md 관계**: [`AGENTS.md`](AGENTS.md)는 영문 요약 (타 AI 도구 + 오픈소스 방문자용). 본 CLAUDE.md가 Claude Code 세션의 **primary** 컨텍스트이며 한국어 상세 운영 가이드.
**하네스 엔지니어링 정의** (정전 single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.
**AI Native 운영** (운영 원칙 보완, v6.0 도입): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 7 — 3 면 매트릭스 (컨텍스트 효율 + 자율성 + 다중 AI 협업) + entry title 가이드 4 원칙. v4.0 정체성 (책임/결과물) ↔ AI Native 운영 (원칙/운영 방식) 두 차원 직교 보완.

@ROADMAP.md

## 모듈별 가이드 (subdirectory on-demand 로드)

각 모듈 디렉토리 작업 시 Claude Code가 해당 CLAUDE.md를 자동 로드한다. 본 root는 진입점 + CRITICAL 규칙만 유지.

| 모듈 | 가이드 | 역할 |
|------|------|------|
| `bootstrap/skills/` | [`bootstrap/skills/CLAUDE.md`](bootstrap/skills/CLAUDE.md) | 글로벌 user-skill 5건 매트릭스 + 작성 규약 |
| `claude/` | [`claude/CLAUDE.md`](claude/CLAUDE.md) | 글로벌 레이어 (hook / statusline / slash command) |
| `tests/` | [`tests/CLAUDE.md`](tests/CLAUDE.md) | smoke 매트릭스 + `--fix` mode 패턴 + pre-commit |
| `projects/meta/` | [`projects/meta/CLAUDE.md`](projects/meta/CLAUDE.md) | **메타 milestone 컨테이너** (lazy load) + ARCHITECTURE.md + ROADMAP.md + milestones/ (v6.2+ 9-stage-flattened / v3.0~v6.1 9-stage-bundled / v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier era 보존) |
| `projects/upbit/` | — | upbit 프로젝트 ARCHITECTURE.md + ROADMAP.md (milestone 산출물 본체는 upbit repo) |

## 워크플로우 (v2.0+ 9-stage + v3.0+ bundling)

```
ROADMAP (입력 source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE
```

각 stage = **단어 = 단일 책임 1:1 매핑** (v2.0_workflow-word-fidelity 정정). 상위 stage 산출물만 입력. 모든 산출물은 **MD 파일 + JSON 코드블록** 포맷 (Claude 컨텍스트 자연 로드 + 자동화 파이프라인 친화).

| Stage | 파일 | 단어 책임 |
|:-:|------|----------|
| (입력) ROADMAP | `projects/<name>/ROADMAP.md` (forward-looking 이정표 단일 source, v5.21+ schema A2: `milestones[]` recent 3 + in_progress + deferred + `next_candidates[]` 별도 필드). 과거 completed entry archival = `CHANGELOG.md` (Keep a Changelog v1.1.0 정합). root `ROADMAP.md` 는 thin index — `{ projects: [{ name, roadmap_path }] }` 만 (smoke 차단) | milestones[] (recent + in_progress + deferred) + next_candidates[] (PROPOSE 발의 후보) |
| A. OPEN | v6.2+ 9-stage-flattened: `projects/meta/milestones/v{X.Y}/` (MILESTONE.md 단일 본책 + execute/ 별책) / v3.0~v6.1 9-stage-bundled: `milestones/v{X.Y}/` (개별 파일 + milestones.md) / v2.0~v2.1 보존: `milestones/v{X.Y}_{slug}/` | 컨테이너 마운트 + ROADMAP entry `in_progress` |
| B. INTENT | `.../INTENT.md` | 의도 (goal, motivation, success_criteria, out_of_scope, dependencies) |
| C. RESEARCH | `.../RESEARCH.md` | 조사 (external, codebase, options, risks_identified) |
| D. DESIGN | `.../DESIGN.md` | 설계 (decisions, approach, phases, risk_mitigation) + 5 관점 검토 |
| E. APPROVE | `.../APPROVE.md` | 사용자 명시 승인 게이트 (`approval.approved_by: "user"` + date) |
| F. EXECUTE | `.../execute/phase-{n}.md` | per-phase 구현 (changes, commit) |
| G. VERIFY | `.../VERIFY.md` | 검증 (smoke, criteria_check vs INTENT, verdict) |
| H. REPORT | `.../REPORT.md` | 종합 backward (summary, delta, lessons_learned) |
| I. PROPOSE | `.../PROPOSE.md` | 후속 forward (next_candidates ROADMAP 등록) |

v3.0+ 9-stage-bundled era — 같은 의미 단위 후속 candidates 를 version 단위 1 milestone (sub-milestone phase 매핑, `milestones.md` per version) 으로 통합. v2.0~v2.1 9-stage era 보존 (`milestones/v{X.Y}_{slug}/`). 7-stage era (v1.0~v1.4) 보존 milestone 은 산출 5종 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT) + execute. 4-tier era (v1.84~v1.88) 는 sub-plan 보존. 자세한 era 정책 + bundling trigger 조건 + 자기참조 부합: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6.1.

## 기술 스택

- Shell scripts (bash, PowerShell 7+) — hook / statusline
- Markdown + JSON 코드블록 — milestone 산출물 + 도메인 docs
- **Claude Code Plugin 배포** (v5.0+) — `.claude-plugin/plugin.json` manifest + `.claude-plugin/marketplace.json` (local marketplace) + paths 명시 (replace-default agents/commands + add-to-default skills/hooks). `claude plugin install harness-meta@harness-meta` 표준 명령으로 install — `~/.claude/plugins/cache/harness-meta/` 안 plugin source 거주, Claude Code 가 paths 자동 인식. v4.x SymbolicLink/Junction 매핑 (`~/.claude/{commands,hooks,statusline,skills,agents}/`) 은 deprecated since v5.0 (v5.0+ 환경에서는 비활성).

## 구조 규칙 (CRITICAL)

- **글로벌 레이어는 CWD 무관 로드**. 프로젝트별 활성화는 `.harness.toml` 존재 시만 (부재 시 hook no-op)
- 새 slash command / hook 추가 시 `claude/` 하위 Markdown 또는 `.sh` 만 추가 → `.claude-plugin/plugin.json` paths 명시 안 자동 인식 (v5.0+). Plugin install 후 `claude plugin enable harness-meta` 으로 활성 갱신 가능.
- 새 글로벌 user-skill 추가 시 `skills/<name>/SKILL.md` 작성 → `.claude-plugin/plugin.json` `skills` add-to-default 자동 인식 (v5.1+). 새 subagent 추가 시 `agents/<name>.md` 작성 → plugin_root `./agents/` default discovery 자동 인식.
- `projects/<name>/` 은 **고정 구조**: `ARCHITECTURE.md` (long-lived 참조) + `ROADMAP.md` (JSON 스키마). meta 만 추가로 `CLAUDE.md` (lazy load) + `milestones/` (본 repo 가 곧 작업 공간) 보유 — upbit/기타 프로젝트는 milestones/ 부재 (산출물은 해당 프로젝트 repo)
- milestone 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + `execute/phase-{n}.md`, v2.0+) 은 **Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body)** 포맷 의무 (v6.1+ 신규 schema, 이전 v1.0~v6.0 = "MD + JSON 코드블록" 적용, v6.1 phase-2 안 28 active milestone backfill 완료, _archive 40 건은 역사적 보존). YAML frontmatter 5 필드 = id/title/version/stage/status (v3.0~v6.1 bundled era), v6.2+ flattened era = **4 필드** (id/title/version/status, stage 제거 — milestone-level 통합 표지). JSON 코드 블록 = smoke 강제 필드만 (id/title 제거), Markdown body = motivation/dependencies 등 narrative 흡수. v3.0~v6.1 9-stage-bundled era 는 추가로 `milestones.md` (sub-milestone listing per version). **v6.2+ 9-stage-flattened era = `MILESTONE.md` 단일 본책 (H2 9 섹션 = 8 stage + ## SUB_MILESTONES) + `execute/phase-{n}.md` 별책** (v6.2_milestone-artifact-directory-flattening 도입, AI Native § 7.1 컨텍스트 효율 면 두 번째 실 적용). 7-stage era (v1.0~v1.4) 산출 5종 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT) + execute 도 동일 포맷.
- milestone 번호 정책 (era 별):
  - v6.2+ 9-stage-flattened: `MILESTONE.md` 단일 본책 + `execute/phase-{n}.md` 별책. 디렉토리 `milestones/v{X.Y}/` (sub-id 부재, bundled era 와 동일). bundling 정책 본질 = ## SUB_MILESTONES 섹션 안 흡수 (보존). ROADMAP `milestones_path` = `milestones/v{X.Y}/MILESTONE.md#sub-milestones` (anchor 포함).
  - v3.0~v6.1 9-stage-bundled (참조용 보존, 신규 금지): ROADMAP `milestones[]` entry 신 schema (`{version: "v{X.Y}", id: "{group-slug}", title, status, summary, trigger, milestones_path}`), 디렉토리 `milestones/v{X.Y}/` (sub-id 부재). 같은 의미 단위 후속 candidates 통합. v5.21+ schema A2 — `milestones[]` 안 recent 3 completed + in_progress + deferred 만 보존, `next_candidates[]` 별도 필드, 과거 completed entry CHANGELOG.md archival.
  - v2.0~v2.1 9-stage / v1.0~v1.4 7-stage 보존: 기존 schema (`id: "v{X.Y}_{slug}"` flat), 디렉토리 `milestones/v{X.Y}_{slug}/`.
  - 단조 증가 + breaking change 시 major bump (semver 정합).
- `projects/meta/milestones/v1.84~v1.88/` 는 historical 4-tier 포맷 (참조용 보존). 신규 작업은 **v6.2+ 9-stage-flattened 의무** (v3.0~v6.1 9-stage-bundled 신규 금지, forward-only era 정책 정합. v3.0_milestones-restructure 부터 자기참조 부합 — v6.2 도그푸드 cycle 2번째).
- root `ROADMAP.md` 는 thin index — milestone 등재 금지 (`tests/smoke-projects-scope-discipline.sh` 가 차단)
- APPROVE.md (`approval.approved_by: "user"` + date) 는 **사용자 명시 승인**만 사용 — EXECUTE 진입 게이트. 7-stage era 보존 milestone 은 `DESIGN.approval.approved_by` 동치.

## 개발 프로세스

- **모든 변경은 milestone 기록**. 신규 작업 시 OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE 순 (v2.0+ 9-stage)
- 커밋 메시지: conventional commits (`docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`)
- `~/harness-meta/` repo 변경은 **커밋 전 사용자 확인 필수**
- pre-commit hook 우회 (`--no-verify`)는 **사용자 명시 승인 후만**

## 명령어

### 설치 (v5.0+ — Claude Code Plugin spec)

```bash
# Option A: GitHub source (clone 불요 — 외부 방문자 권장)
claude plugin marketplace add pdw96/harness-meta
claude plugin install harness-meta@harness-meta
```

```bash
# Option B: 로컬 clone (로컬 개발 / 오프라인)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
claude plugin marketplace add ~/harness-meta
claude plugin install harness-meta@harness-meta
```

설치 후 Claude Code 가 `.claude-plugin/plugin.json` 자동 인식 — `~/.claude/{commands,hooks,statusline,skills,agents}/` 안 SymbolicLink/Junction 생성 불요. Plugin source 거주 위치 = `~/.claude/plugins/cache/harness-meta/`. `claude plugin uninstall harness-meta` 으로 제거, `claude plugin enable/disable harness-meta` 으로 토글.

**v4.x install 환경 migration** — 기존 `~/.claude/agents/` 안 5 멤버 audit-team SymbolicLink (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) 가 잔존 시 충돌 회피 위해 수동 제거 권고. Linux/macOS: `ls ~/.claude/agents/{...}` 사전 verify 후 `rm ~/.claude/agents/{...}`. Windows: `Get-ChildItem $env:USERPROFILE\.claude\agents\` 사전 verify 후 `Remove-Item ...`. 정확 명령 = [`README.md`](README.md#installation).

**Deprecated since v5.0** — 자연어 호출 `~~harness-meta 설치해줘~~` (deprecated, v5.0+ 환경에서는 비활성) + v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup) 는 historical narrative 만 보존 (v4.x milestone 산출물 안). `component-installer` agent 책임 = custom component lifecycle (milestone 산출물 mechanical apply) — Plugin install lifecycle 은 Claude Code CLI 위임.

```bash
# pre-commit (1회, 별도)
pip install pre-commit && pre-commit install
```

상세 충돌 정책: [`claude/CLAUDE.md`](claude/CLAUDE.md). pre-commit + smoke: [`tests/CLAUDE.md`](tests/CLAUDE.md).

### 세션 시작 (Claude Code 안에서)

| Command | 용도 |
|---------|------|
| `/harness-meta` | CWD basename target 추론 |
| `/harness-meta meta` | **repo 자체 개선 모드** |
| `/harness-meta <name>` | **프로젝트별 하네스 개선 모드** |

신규 프로젝트 도입은 첫 milestone (예: `v0.1_setup`)의 EXECUTE phase에서 `.harness.toml` + 프로젝트 docs 생성으로 처리.

### 프로젝트 활성화 여부

```bash
cat .harness.toml       # 존재 = 활성 / 부재 = no-op
```

### cascade 자동 동기 (v6.4+)

<!-- cascade-source: projects/meta/ARCHITECTURE.md#section-4-end-row-8 expected-hash:18b81d6adfd7e60a -->
> **cascade 자동 동기 mechanism**: `/cascade-sync` slash command 또는 `python scripts/cascade_sync.py --check|--apply` 으로 source narrative 변경 시 cascade host 자동 동기. 정의 + 사용법 1차 source = [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 4 끝 매트릭스 #8 row + paragraph 본문.

### Claude 자율 milestone 발의 (v6.5+)

<!-- cascade-source: projects/meta/ARCHITECTURE.md#section-4-end-row-9 expected-hash:2313949d4ddfff70 -->
> **Claude 자율 milestone 발의 mechanism**: `/propose-next` slash command 또는 `python scripts/propose_next.py --scan` 으로 ROADMAP + 최근 5 milestone PROPOSE + lessons P2 자동 종합 → 다음 milestone candidate 후보 제안 → 사용자 명시 결정 후 `candidate_draft[]` append. 자율 범위 = candidate 제안까지만. v6.8 surface 자동 dedupe 확장 (status `delta`/`passing` 분류, id 우선 + title fallback matching, scope `next_candidates[]` + `candidate_draft[]` 양쪽) — LLM Step 2 안 `delta` 우선 surface + `passing` 통계 only. 정의 + 사용법 1차 source = [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 4 끝 매트릭스 #9 row + paragraph 본문.

### audit chain hallucination 자동 검출 (v6.6+)

<!-- cascade-source: projects/meta/ARCHITECTURE.md#section-4-end-row-10 expected-hash:4aa43da602e1596f -->
> **audit chain hallucination 자동 검출 mechanism**: `--audit` flag opt-in 시 audit-team synthesizer step (Step 6 신규) 안 `python scripts/audit_fact_verify.py --dir <audit-output>` 자동 호출 → v5.13 정전화 3 method (boolean/표/수치) script-only fact 인용 detect → mismatch 보고 (사용자/orchestrator 수동 정정 게이트 보존, 자율 = 검출 only). 운영 책임 분리 = 3-step chain (`v6.7` 정전화) — (a) 수동 1차 source (`v5.13`/`v5.18`) → (b) 자동 검출 (본 mechanism Step 6) → (c) 수동 정정 (사용자/orchestrator). **v6.9 mismatch 보고 5-step 형식 enhancement** (Anthropic Claude Code debugger subagent 정합 capture/identify/isolate/fix/verify) — script 가 Capture/Identify/Isolate 3 자동 채움 + Fix/Verify 2 빈 슬롯 (null, LLM/사용자 채움). 정의 + 사용법 1차 source = [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 4 끝 매트릭스 #10 row + paragraph 본문.

## 환경변수

| 변수 | 기본값 | 용도 |
|------|--------|------|
| `HARNESS_META_ROOT` | `$HOME/harness-meta` | repo clone 위치 override |

그 외 하네스 런타임 환경변수는 각 프로젝트 repo의 `docs/HARNESS.md` 참조.

## 관련 문서 (핵심)

- 프로젝트 thin index: [`ROADMAP.md`](ROADMAP.md) (root)
- 메타 milestone 목록: [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md)
- 메타 ARCHITECTURE: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md)
- 프로젝트별 ROADMAP: `projects/<name>/ROADMAP.md`
- 핵심 ADR: [`docs/adr/README.md`](docs/adr/README.md)

상세 cross-ref는 각 모듈 CLAUDE.md 참조.

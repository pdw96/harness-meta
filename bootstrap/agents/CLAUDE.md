# bootstrap/agents/ 모듈 가이드

글로벌 subagent + agent team 의 정책·매트릭스 narrative 디렉토리. v5.1_plugin-component-discovery-fix (2026-05-14) 부터 실 executable .md 파일 = `agents/` (plugin_root standard location) 거주. 본 디렉토리 = CLAUDE.md narrative-only container (harness-gap-analyzer text reference 유지 의무).

상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)

## 구조 (v5.1_plugin-component-discovery-fix, 2026-05-14)

`harness-meta` 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 정합:

| Layer | 거주지 | 용도 | 사용자 |
|---|---|---|---|
| 글로벌 | `agents/<name>.md` (plugin_root standard, v5.1 이후) | 보편 subagent / team (어느 프로젝트든 유용) | 모든 사용자, 모든 프로젝트 |
| 프로젝트 특화 | `projects/<name>/.claude/agents/<name>/` | 도메인 특화 (예: upbit 의 trade-strategy-reviewer) | 해당 프로젝트만 |

`agents/` (plugin_root 안 standard location) = 글로벌 agent .md source-of-truth (v5.1 이후). 프로젝트 특화는 각 프로젝트 repo 의 `.claude/agents/`. 본 `bootstrap/agents/` = 정책·매트릭스 narrative container (CLAUDE.md 만 잔존).

## 매트릭스 (v4.0 첫 멤버 추가 phase-5 + v4.2 standalone 2 흡수)

| 카테고리 | Team / Standalone Subagent | 책임 | 권한 | model |
|---|---|---|---|---|
| `audit/` | `project-harness-audit-team/` (team, 5 멤버 — scanner/analyzer/mapper/proposer/installer) | 프로젝트 분석 + harness component proposal + e3 apply cycle | read + write (component-installer 만) | sonnet (installer 만 opus) |
| `audit/` | `environment-auditor.md` (standalone, v4.2 신규) | 환경 헬스 체크 read-only audit (`verify.{ps1,sh}` 흡수, 10 stage 매트릭스) | read-only (Bash 화이트리스트 + Read + Glob + Grep) | sonnet |
| `audit/` | `agents-md-sync.md` (standalone, v4.2 신규) | AGENTS.md canonical → 7 adapter SHA-256 drift sync (`sync-agents.{ps1,sh}` 흡수) | read + write (default `-Check`, `-SourceWins` 사용자 게이트 후) | sonnet |
| `dev-tools/` | (placeholder, 후속 발의 시 추가) | — | — | — |

매트릭스 갱신 — 새 team/subagent 추가 시 본 표에 row 추가 의무.

## 디렉토리 구조 (v5.1 이후 — plugin_root/agents/ standard)

```text
agents/                             # plugin_root standard location (v5.1 이후 executable .md 거주)
├── environment-auditor.md          # standalone subagent (audit 카테고리)
├── agents-md-sync.md               # standalone subagent (audit 카테고리)
├── project-scanner.md              # team 멤버 (audit/project-harness-audit-team)
├── harness-gap-analyzer.md         # team 멤버
├── claude-docs-mapper.md           # team 멤버
├── component-proposer.md           # team 멤버
├── component-installer.md          # team 멤버
└── project-harness-audit-team/
    └── CLAUDE.md                   # team orchestration narrative
bootstrap/agents/
└── CLAUDE.md                       # 정책·매트릭스 narrative (본 파일, narrative-only)
```

**카테고리 구분** (디렉토리 대신 매트릭스 column 으로):

- `audit`: environment-auditor + agents-md-sync + project-harness-audit-team 5 멤버
- `dev-tools`: (placeholder, 후속 발의 시 추가)

**Reserved**: `_*` prefix 는 sentinel. `component-installer` mechanical sequence 안 검증.

## Install / Update / Cleanup 책임 (v5.0 Plugin spec 채택, component-installer 책임 분리)

v5.0 정체성 = **Claude Code Plugin 으로 배포** (`.claude-plugin/plugin.json` manifest). 사용자 install = Claude Code CLI 표준 (`claude plugin marketplace add pdw96/harness-meta` 또는 `~/harness-meta` + `claude plugin install harness-meta@harness-meta`) — Plugin install lifecycle (mechanical 작업) Claude Code 위임. `component-installer` agent 책임 분리:

- **custom component lifecycle** (보존) — milestone 산출물 mechanical apply (예: 신규 agent .md 파일 작성, plugin.json paths 갱신, 충돌 conflict 4 case 매트릭스 + agent fleet 5 case 매트릭스 안 mechanical edit). `component-installer` system prompt 안 본 책임 보존.
- **Plugin install lifecycle** (Claude Code CLI 위임) — `claude plugin install/uninstall/enable/disable` 표준 명령. `~/.claude/plugins/cache/<plugin>/` 거주 + paths 자동 인식 = Claude Code 표준 메커니즘. agent 흡수 부재.

### Plugin install 표준 명령

```bash
# Option A: GitHub source (clone 불요 — 외부 방문자 권장)
claude plugin marketplace add pdw96/harness-meta
claude plugin install harness-meta@harness-meta

# Option B: 로컬 clone
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
claude plugin marketplace add ~/harness-meta
claude plugin install harness-meta@harness-meta
# (--scope user default / project / local 선택 가능)
```

Plugin install 후 `~/.claude/plugins/cache/harness-meta/` 안 plugin source 거주 + `agents/` standard location 자동 발견 (v5.1 이후 paths 명시 부재, default discovery) — `~/.claude/{commands,hooks,statusline,skills,agents}/` 안 SymbolicLink/Junction 생성 불요. 7 멤버 (`agents/<member>.md` flat, 5 team + 2 standalone) 자동 인식. `claude plugin uninstall harness-meta` 제거, `claude plugin enable/disable harness-meta` 토글.

### Component-installer custom lifecycle (보존)

`component-installer` agent 의 잔여 책임 (v5.0 책임 분리 후):

- milestone 산출물 안 신규 .md 파일 작성 (Write tool 부재 → Edit tool 안 mechanical apply 또는 메인 Claude 와 협력)
- `.claude-plugin/plugin.json` paths 갱신 (신규 agent/skill/command 추가 시)
- conflict 4 case 매트릭스 안 mechanical 결정 적용 (delete/keep/mix)
- agent fleet 5 case 매트릭스 안 mechanical apply (scope 확장 / 분할 / 신규 / 통합 / 삭제)
- Plugin install 후 ad-hoc 검증 (`Get-ChildItem ~/.claude/plugins/cache/harness-meta/` + subagent_type discovery + dual-active 검출)

허용 Bash 명령 화이트리스트 (보존): `Test-Path` / `Get-ChildItem` / `Copy-Item` / `Move-Item` (cleanup retention 책임 잔존) / `Remove-Item` (cleanup only) / `pwsh -Command` (OS detect, v4.x migration 진단 시).

### v4.x → v5.0 migration narrative

v4.x 환경 안 `~/.claude/agents/` 5 멤버 SymbolicLink (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) 잔존 시 충돌 회피 위해 manual cleanup 권고:

```bash
# Linux/macOS — preview 후 remove:
ls ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md
rm ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md

# Windows PowerShell — preview 후 remove:
Get-ChildItem $env:USERPROFILE\.claude\agents\
Remove-Item $env:USERPROFILE\.claude\agents\project-scanner.md, $env:USERPROFILE\.claude\agents\harness-gap-analyzer.md, $env:USERPROFILE\.claude\agents\claude-docs-mapper.md, $env:USERPROFILE\.claude\agents\component-proposer.md, $env:USERPROFILE\.claude\agents\component-installer.md
```

**Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — v4.0 narrative ('static install script 부재 + agent 흡수') + v4.1 D7 mechanical sequence (Backup → OS detect → SymbolicLink/Junction primary → Copy fallback → Cleanup retention) + v4.3 `.md 파일 영역 SymbolicLink default 정정` narrative = historical 만 보존. Plugin install lifecycle 채택 = Developer Mode 의존 0 + Junction/SymbolicLink/Copy 분기 narrative 자연 폐기. 자세히: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 3.1 'Install 정책 = Claude Code Plugin spec 전면 채택' paragraph.

## Audit/Sync 책임 (v4.2 verify-infra-agent-absorption, standalone subagent 흡수)

v4.0 정체성 (mechanical install/update/cleanup agent 흡수) 정합 확장 — verify/sync 본질 (환경 헬스 체크 + AGENTS.md drift sync) 도 agent 흡수. **두 standalone subagent** (project-harness-audit-team 와 책임 분리):

### `environment-auditor.md` (read-only audit)

- **책임**: harness-meta 설치 후 환경 헬스 체크 — 10 stage 매트릭스 (Z 플랫폼 전제 / A 환경 전제 / B Plugin install + activation 검증 (5 sub-step B0/BP1/BP2/BP3/BP4, v5.5 Plugin 전환 + v5.6 BP3 activation + BP4 G AUTO 통합) / C settings.json 구조 / D Hook 스모크 / E Statusline 스모크 / F backup 정보성 / I Frontmatter 검사 V1/V5/V7/V8/V10 / J PostToolUse 등록 / G Runtime-only 수동 체크리스트 — 실 세션 효과 인식, audit 책임 외, v5.6 책임 표기 추가)
- **권한**: read-only (`Bash + Read + Glob + Grep`, Bash 화이트리스트 = read 명령만, write 일체 금지)
- **호출**: 사용자 자연어 — `verify 해줘` / `environment audit 해줘`. 메인 Claude 가 `subagent_type="environment-auditor"` 호출
- **선례**: v4.2 도입 시 `verify.{ps1,sh}` + `verify-lib.{ps1,sh}` 4 script (~1252 LOC) 폐기 흡수

### `agents-md-sync.md` (write drift sync, default `-Check`)

- **책임**: AGENTS.md canonical → 7 adapter (CLAUDE.md / GEMINI.md / .github/copilot-instructions.md / .cursor/rules/main.mdc / CONVENTIONS.md / .clinerules/main.md / .roo/rules/main.md) SHA-256 drift 감지 + (사용자 명시 결정 후) sync
- **권한**: read + write (`Read + Bash + Edit`, default `-Check` 모드 = drift detect only, `-SourceWins` write = 사용자 명시 결정 게이트 후만 — e3 정책 정합)
- **호출**: 사용자 자연어 — `AGENTS.md drift 확인` / `agents-md sync 해줘`. 메인 Claude 가 `subagent_type="agents-md-sync"` 호출
- **선례**: v4.2 도입 시 `sync-agents.{ps1,sh}` 2 script (~384 LOC) 폐기 흡수

### Standalone vs team 책임 경계

- **standalone subagent** (`audit/<name>.md`) = 1 책임 1 subagent (단일 호출, 자연어 trigger). team orchestration 부재.
- **team** (`audit/<team-name>/`) = e3 정책 cycle (audit → propose → 사용자 결정 → apply) 5 멤버 순차. orchestration narrative `<team-name>/CLAUDE.md` 안 단일 source.
- 책임 경계 — write 권한 standalone (`agents-md-sync`) vs write 권한 team 멤버 (`component-installer`) 호출 trigger 본질 분리: standalone = 자연어 사용자 호출 (e.g., `AGENTS.md sync`), installer = team workflow 안 e3 게이트 후만 (`component-proposer` accepted draft 입력).

### 첫 진입 (~/.claude/plugins/ 안 harness-meta 부재)

사용자 Claude Code 안 표준 CLI 호출 — `claude plugin marketplace add pdw96/harness-meta` (외부, clone 불요) 또는 `~/harness-meta` (로컬) + `claude plugin install harness-meta@harness-meta` (scope user default). `README.md` + root `CLAUDE.md` 안 onboarding 상세. **Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — 자연어 호출 `~~harness-meta 설치해줘~~` 폐기 (v4.x historical narrative 만 보존).

## Conflict Resolution 4 case 매트릭스 (v4.0, e3 정책)

Custom (`bootstrap/agents/` 안 정의) vs Claude Code built-in (`code.claude.com/docs/en/sub-agents` 안 신규/개선) 충돌 시 결정 매트릭스:

| Case | 조건 | 권장 결정 |
|---|---|---|
| Superset | Built-in 이 custom 의 모든 기능 포함 + 추가 | **delete custom**, use built-in |
| 유사 다른 책임 | Built-in vs custom 유사한데 책임 다름 | **keep custom + add built-in** (mix) |
| 부분 cover | Built-in 이 custom 의 일부만 cover | **mix** (built-in default + custom 보완) |
| 무관 책임 | Built-in vs custom 책임 무관 | **둘 다 keep** |

결정 과정 = e3 정책 (audit → propose → 사용자 명시 결정 → apply). `project-harness-audit-team` (phase-5) 안 `harness-gap-analyzer` (detect) + `component-proposer` (proposal) 가 자동 진단 + 사용자 명시 결정 대기 + `component-installer` 가 apply.

## Agent Fleet Lifecycle 5 case 매트릭스 (v4.0, e3 정책)

Agent fleet 자체의 evolution (시간 경과 + 사용 패턴 변화):

| Case | Trigger | 권장 결정 |
|---|---|---|
| scope 확장 | 기존 agent 책임 외 자연 발견 case 누적 | 멤버 system prompt 안 책임 확장 (단순 Edit) |
| scope 분할 | agent 너무 광범위, context 부담 | 1 agent → 2 agent 분리 (예: scanner ↔ analyzer 분리) |
| 신규 추가 | 현 fleet 미커버 case + GitHub 인기 패턴 발견 | 신규 멤버 또는 신규 team 정의 |
| 통합 | 중복/유사 agent 책임 겹침 | 2 agent → 1 agent 통합 (책임 합) |
| 삭제 | built-in 으로 대체 / 사용 안 함 | agent 디렉토리 삭제 + ~/.claude/agents/ symlink 제거 |

> **Note** (v5.12 정정): 매트릭스 안 'built-in' (Conflict Resolution + Agent Fleet Lifecycle) = Claude Code built-in command 일반 (fixed-logic). 이 중 `/init`·`/review`·`/security-review` 는 Skill tool 안 discover + execute 가능 (`code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교.

결정 과정 = e3 정책 동일. `harness-gap-analyzer` detect + `component-proposer` 5 case 매트릭스 기반 proposal + 사용자 결정 + `component-installer` apply.

## 벤치마크 cycle (v4.0 phase-7 신규)

`schedule` skill 활용 주 1회 cron — GitHub 인기 repo (anthropics/* + 인기 agentic) + Claude Code release notes/changelog 검토. 산출물 host = `projects/meta/ROADMAP.md` 안 `candidate_draft[]` 신 필드 (D4 확정, schema_note 안 entry schema 정전화).

### Routine 등록 패턴 (schedule skill)

Claude Code 안 자연어 호출:

```text
schedule 명령으로 'harness-meta 주간 벤치마크' routine 등록해줘.
주기: 매주 월 09:00 (cron: 0 9 * * 1).
실행: project-harness-audit-team 호출 후 GitHub 인기 repo 분석 + Claude Code
release notes 검토 + 결과를 projects/meta/ROADMAP.md candidate_draft[] 에 append.
```

`/schedule` skill 이 본 prompt 를 받아 `~/.claude/scheduled_tasks` 안 cron entry 자동 생성. 본 repo 외부 — routine 정의는 사용자 환경 의존.

### 벤치마크 산출물 3축

1. **GitHub 인기 패턴 도입 candidate** (`category: "github-pattern"`) — 외부 repo (anthropics/* + 인기 agentic 예: `anthropics/courses`, `openai/swarm`, `microsoft/autogen` 등) 의 agent/hook/skill 패턴 차용 검토
2. **Claude Code release notes 신규 built-in command 도입 candidate** (`category: "claude-code-update"`) — `https://code.claude.com/docs/en/changelog` (또는 동치 source) 정기 검토 + Conflict Resolution 4 case 매트릭스 자동 적용
3. **Fleet evolution proposal** (`category: "fleet-evolution"`) — 본 repo 내 agent fleet 의 scope 확장/분할/통합/삭제 case detect (`harness-gap-analyzer` 5 case 매트릭스)

### Candidate draft entry 예시

```json
{
  "id": "introduce-swarm-pattern",
  "title": "OpenAI Swarm-style handoff 패턴 도입 검토",
  "source": "https://github.com/openai/swarm",
  "detected_at": "2026-05-20",
  "rationale": "본 repo 의 5 멤버 team 순차 sequence 와 비교 — swarm handoff 가 더 dynamic. fleet evolution 5 case 중 'scope 분할' candidate.",
  "category": "github-pattern",
  "decision_pending": true
}
```

사용자 명시 결정 후 → milestones[] 정식 등재 (e3 정책 정합 — propose → 사용자 결정 → milestone EXECUTE).

## 신규 subagent / team 추가 절차 (v5.1 이후)

1. **카테고리 결정** — `audit` (검증·평가·분석) 또는 `dev-tools` (개발 도구·context)
2. **`agents/<name>.md` 파일 작성** — yaml frontmatter + system prompt 형식 (code.claude.com/docs/en/sub-agents 권장). team 멤버 다수일 경우 개별 `agents/<member>.md` flat.
3. **team 일 때 `agents/<team-name>/CLAUDE.md` 추가** — orchestration narrative (호출 순서 + 사용자 게이트 + 결과 통합)
4. **milestone 기록** — `projects/meta/milestones/v{X.Y}/` 9-stage
5. **본 모듈 매트릭스 1 row 추가** (카테고리 column 명시)
6. **사용자 환경 배포** — Claude Code Plugin standard: `agents/` default discovery (plugin.json paths 명시 불요)

## 작업 시 주의

- **Source-of-truth 규약**: `agents/` (plugin_root standard, v5.1 이후) 만 git tracking. `bootstrap/agents/` = CLAUDE.md narrative-only (git tracking 유지, 실 executable 부재). `~/.claude/agents/` 는 v4.x symlink (또는 copy 사본) — git 대상 외.
- **Backup 위치**: `~/.claude/backups/agents/<name>.<YYYYMMDD-HHMMSS>/` (agents/ 외부 필수 — 내부 두면 Claude Code 가 backup 도 활성 agent 로 인식)
- **subagent yaml frontmatter** — `name` + `description` + `tools` + (옵션) `model` 필수. `code.claude.com/docs/en/sub-agents` 권장 형식
- **agent team CLAUDE.md** — orchestration sequence + 사용자 게이트 명시 (e3 정책 적용)

## 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- 두 층 패턴 reference: [`../skills/CLAUDE.md`](../skills/CLAUDE.md) (글로벌 user-skill 동일 패턴)
- 메타 ARCHITECTURE: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 3.1 끝 (정체성 단일 source)
- v4.0 milestone INTENT: [`../../projects/meta/milestones/v4.0/INTENT.md`](../../projects/meta/milestones/v4.0/INTENT.md)
- v4.0 DESIGN (D7 mechanical sequence): [`../../projects/meta/milestones/v4.0/DESIGN.md`](../../projects/meta/milestones/v4.0/DESIGN.md)
- code.claude.com primary source: context7 library ID `/websites/code_claude` (7393 snippets, score 81.68)
- agent teams docs: `https://code.claude.com/docs/en/agent-teams`
- subagents docs: `https://code.claude.com/docs/en/sub-agents`

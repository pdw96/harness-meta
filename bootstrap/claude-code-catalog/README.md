# Claude Code 도구 카탈로그 (v4.0_harness-composer-pivot, 2026-05-13)

`harness-meta` 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 의 **단일 source 도구 카탈로그**. `agents/` 안 `claude-docs-mapper.md` subagent 의 1차 source (phase-5 신규, v5.1+ `agents/` standard location). v5.0 부터 본 repo 자체가 Claude Code Plugin (`.claude-plugin/plugin.json` manifest) — 영역 3 (Plugin / MCP server) 와 동일 mechanism 채택.

상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)

## 카탈로그 4 영역

| # | 영역 | Primary source | 사용 도구 |
|---|---|---|---|
| 1 | code.claude.com/docs (Claude Code 공식 docs) | context7 library ID `/websites/code_claude` (7393 snippets, score 81.68, 본 세션 검증) | `mcp__plugin_context7_context7__query-docs` |
| 2 | Built-in / preset slash command (Claude Code 자체) | 본 카탈로그 (수동 인벤토리) + 시스템 available-skills reminder | `Skill` tool 또는 직접 `/<command>` |
| 3 | Plugin / MCP server (외부 통합) | Anthropic plugin marketplace + [modelcontextprotocol.io](https://modelcontextprotocol.io) | `/plugin install` + MCP 설정 |
| 4 | harness-meta canonical 자산 (본 repo 가 만들고 검증한 재사용 component) | 본 카탈로그 § 4 인벤토리 (v8.9 신설) | `component-installer` copy (e3 게이트 후) |

## 1. code.claude.com/docs 인벤토리

context7 query 패턴:

```python
# Step 1 — library ID 해결 (1회, 본 카탈로그 안 명시)
library_id = "/websites/code_claude"  # 사전 검증됨

# Step 2 — query 실행
mcp__plugin_context7_context7__query-docs(
    libraryId="/websites/code_claude",
    query="subagent definition file format and how to create custom subagents"
)
```

### 주요 페이지 (사전 인덱싱 확인)

| 페이지 URL | 핵심 콘텐츠 | 사용 case |
|---|---|---|
| `/docs/en/sub-agents` | subagent yaml frontmatter + `.claude/agents/` 구조 + tools allowlist | `agents/` 신규 멤버 작성 시 |
| `/docs/en/agent-teams` | multi-instance Claude Code 세션 coordination (team lead + teammates 독립 context) | agent team 본질 vs subagents 차이 (v4.0 phase-5 narrative 정합) |
| `/docs/en/agent-sdk/subagents` | Agent SDK `AgentDefinition` (python/typescript) | SDK 사용 시 (본 repo 는 Claude Code CLI session 중심, SDK 사용 부재) |
| `/docs/en/agent-sdk/overview` | Agent tool + `allowedTools` 필수 | subagent 호출 시 권한 매트릭스 |
| `/docs/en/best-practices` | security-reviewer 정의 예 + `.claude/agents/` 권장 | 신규 agent 정의 시 best-practice reference |
| `/docs/en/hooks` | Hooks 등록 + matcher pattern + SessionStart/PostToolUse 등 | `claude/hooks/` 신규 hook 추가 시 |
| `/docs/en/slash-commands` | slash command 정의 + frontmatter | `claude/commands/` 신규 command 추가 시 |
| `/docs/en/mcp` | MCP server 설정 + `~/.claude.json` 안 mcpServers | 신규 MCP plugin 통합 시 |
| `/docs/en/statusline` | statusline.sh + tmux/screen reference | `claude/statusline/` 변경 시 |
| `/docs/en/settings` | settings.json + permissions + env | settings.local.json 또는 settings.json 변경 시 |

신규 페이지 추가 또는 인덱싱 확인 — `claude-docs-mapper` subagent 가 phase-7 벤치마크 cycle 안 정기 검토.

## 2. Built-in / preset slash command 인벤토리

본 인벤토리 = Claude Code 자체 명령 + 시스템 available-skills (시스템 reminder 노출). v4.0 시점 인지된 활성 명령:

| Command | 책임 | Source |
|---|---|---|
| `/init` | 신규 repo CLAUDE.md 초기화 | Claude Code CLI built-in (시스템 available-skills) |
| `/review` | PR 리뷰 | 동상 |
| `/security-review` | 보안 리뷰 (current branch pending changes) | 동상 |
| `/loop` | 재귀 prompt 실행 (interval 또는 self-paced) | 동상 |
| `/schedule` | Cron scheduled remote agent | 동상 |
| `/clear` | 세션 컨텍스트 reset | Claude Code CLI built-in |
| `/help` | 도움말 | 동상 |
| `/config` | 설정 변경 | 동상 |
| `/plugin` | plugin marketplace install | 동상 |

> **Note** (v5.12 정정): 표 안 `/init`·`/review`·`/security-review` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). `/loop` 는 Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/claude-api` 와 동질) — 별 sub-classification. 다른 built-in command (`/schedule`·`/clear`·`/help`·`/config`·`/plugin`) 는 fixed-logic only (Skill tool invocable 부재).

User-invocable plugin skills (시스템 reminder 안 available-skills 카탈로그):

| Skill | Plugin | 책임 |
|---|---|---|
| `update-config` | (시스템) | settings.json 자동 편집 (hooks / permissions / env) |
| `keybindings-help` | (시스템) | `~/.claude/keybindings.json` 편집 |
| `fewer-permission-prompts` | (시스템) | transcript 분석 → permission allowlist 자동 추가 |
| `simplify` | (시스템) | 변경된 코드 reuse/quality/efficiency 리뷰 + fix |
| `claude-md-management:revise-claude-md` | claude-md-management | CLAUDE.md 갱신 (세션 learnings) |
| `claude-md-management:claude-md-improver` | 동상 | CLAUDE.md 품질 audit + 자동 update |
| `skill-creator:skill-creator` | skill-creator | skill 생성·수정·eval·optimize |

v4.0 phase-5 신규 (`project-harness-audit-team` 5 멤버) 는 본 인벤토리와 직교 — 글로벌 vs 본 repo 특화 두 층 구조 정합 (`bootstrap/agents/CLAUDE.md` 참조).

신규 built-in command 또는 plugin skill 발견 시 — phase-7 벤치마크 cycle 안 conflict resolution 4 case 매트릭스 적용 (`bootstrap/agents/CLAUDE.md` § Conflict Resolution).

## 3. Plugin / MCP server 인벤토리

현 세션 활성 MCP plugin:

| Plugin | 책임 | 본 repo 사용 case |
|---|---|---|
| `plugin:context7:context7` | 라이브러리/프레임워크 doc 실시간 fetch (`resolve-library-id` + `query-docs`) | `code.claude.com/docs` 1차 source (영역 1) + 일반 라이브러리 doc |
| `plugin:github` | GitHub API (issues / PR / search) | 벤치마크 cycle (phase-7) GitHub 인기 repo 검토 + issue/PR 자동화 |
| `plugin:playwright` | 브라우저 자동화 (headless) | 필요 시 docs scrape (context7 fallback) |
| `mcp__claude_ai_Google_Drive__*` | Google Drive 통합 | (현재 본 repo 사용 case 부재) |

외부 catalog (확장 후보):

- **Anthropic plugin marketplace**: `/plugin install` 안 표시되는 공식 카탈로그
- **modelcontextprotocol.io**: MCP server 표준 + 카탈로그 (<https://modelcontextprotocol.io>)
- **GitHub `modelcontextprotocol/servers`**: 공식 reference servers + 외부 contributions

벤치마크 cycle (phase-7) 안 정기 검토 대상 — 새 MCP server 등재 detect + Conflict Resolution 4 case 매트릭스 적용.

## 4. harness-meta canonical 자산 인벤토리 (v8.9 신설)

`harness-meta` 가 milestone 안에서 직접 만들고 검증(smoke 회귀)한 **재사용 component**. 영역 1~3(generic docs / built-in / plugin)과 직교 — audit-team 이 gap 을 채울 때 generic 문서 매핑 + 즉석 생성 대신 **본 검증 자산을 권고**(`extend`/`adopt`, heterogeneous 시 강요 아닌 격차 보강)할 수 있게 하는 단일 source. claude-docs-mapper Task 1 의 `harness-meta-asset` gap 분기 + harness-gap-analyzer Task 1 의 gap detect 기준(아래 '권고 case' 컬럼)이 본 표를 참조.

> **경량 인벤토리**: 본 § = 자산 인벤토리 표(v8.9 secret-scan 1 항목 seed). 자산 디렉토리 규약 / 버전관리 / 다수 자산 lifecycle 의 full 구조 정전화는 별도 후보(`hook-asset-library-canonicalization`). 2건째 자산 등록 시 detect 기준 일반화 재고 trigger.

| 자산 | source path | 책임 | 권고 case (gap 조건) | apply 방식 |
|---|---|---|---|---|
| `session-start-secret-scan.sh` (SessionStart hook) | [`claude/hooks/session-start-secret-scan.sh`](../../claude/hooks/session-start-secret-scan.sh) | `.claude/settings*.json` allow/deny 리스트의 평문 secret(Docker Hub PAT / Anthropic / GitHub PAT / AWS / JWT) SessionStart 시점 grep → systemMessage 경고 (warn-only, 차단 아님) | 대상이 `.claude/settings*.json` 기반 권한 운영(claude_dir=true) ∧ **발동 시점(event)이 SessionStart 인 hook 중 settings 파일 secret scan 책임 hook 부재**. 판별 = `harness_state.hooks[]` 의 matcher/event 가 `SessionStart` ∧ name 에 `secret`/`scan` 토큰(책임 신호) — write-time guard(matcher `Edit\|Write`, 예 `secret-guard.py`)는 책임 직교라 제외(gap 억제 못 함, v8.10 (C) false-negative 해소). SessionStart ∧ 토큰이나 책임(settings scan) 모호 시 agent 투명 보고 + 사용자 게이트(강제 권고 금지) | `component-installer` 가 대상 `.claude/hooks/` 로 copy + hooks.json SessionStart 등록 (e3 게이트 후) |

신규 자산 등록 — milestone 안에서 harness-meta 가 검증한 재사용 component 발생 시 본 표에 1 row append(자산명 / source path markdown link / 책임 / 권고 case / apply 방식). markdown link 의무 — `tests/smoke-cross-ref.sh` 가 자산 path drift 자동 차단.

## 자주 묻는 query 카탈로그 (≥ 3건)

`claude-docs-mapper` subagent (phase-5) 가 사용할 baseline query 패턴:

### Query 1 — Subagent 정의 + tools allowlist

```text
libraryId: /websites/code_claude
query: subagent definition file format yaml frontmatter and how to restrict tools allowlist
```

기대 결과: `/docs/en/sub-agents` + `/docs/en/best-practices` 페이지 코드 snippet (예: `tools: Read, Grep, Glob, Bash`).

### Query 2 — Hooks 등록 + matcher pattern

```text
libraryId: /websites/code_claude
query: how to register hooks with matcher pattern PostToolUse SessionStart settings.json
```

기대 결과: `/docs/en/hooks` 페이지 + matcher regex 예 (예: `Write|Edit|MultiEdit|NotebookEdit`).

### Query 3 — Agent team multi-instance orchestration

```text
libraryId: /websites/code_claude
query: multi-instance agent team orchestration with team lead coordinating teammates independently
```

기대 결과: `/docs/en/agent-teams` 페이지 + team lead vs subagents (single session) 차이 명시.

### 추가 query 등록 규약

신규 query 패턴 발견 시 — `claude-docs-mapper` subagent (`agents/claude-docs-mapper.md`) 안 system prompt 안 추가 + 본 카탈로그 매트릭스에 1 row 추가.

## 작업 시 주의

- **WebFetch fallback**: context7 query 부재 또는 인덱싱 stale 의심 시 WebFetch (`https://code.claude.com/docs/en/<page>`) 직접 호출. 다만 토큰 비용 ↑ — primary 는 context7
- **인덱싱 stale 검증**: 본 카탈로그 매트릭스 (page URL) 가 sample query 결과와 일치하는지 phase-7 벤치마크 cycle 안 자동 검증
- **단일 source 정합**: 본 README.md 가 도구 카탈로그 단일 source. `bootstrap/agents/CLAUDE.md` 또는 다른 host 안 cross-ref 만 (narrative 중복 회피)
- **신규 영역 추가** (예: 신규 plugin layer / 신규 docs site): 본 README.md 안 영역 4+ 추가 + `claude-docs-mapper` system prompt 갱신

## 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- 메타 ARCHITECTURE: [`../../development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 3.1 끝 (정체성 단일 source)
- v4.0 INTENT: [`../../development/milestones/v4.0/INTENT.md`](../../development/milestones/v4.0/INTENT.md)
- bootstrap/agents/ 두 층 구조 + 정책: [`../agents/CLAUDE.md`](../agents/CLAUDE.md)
- context7 1차 source library ID: `/websites/code_claude` (7393 snippets, score 81.68, Source Reputation: High)

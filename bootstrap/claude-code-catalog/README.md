---
last_audited:
  claude_code_version: v2.1.146
  audited_at: 2026-05-22
  new_features_found: 30
  absorbed_count: 0
  evaluated_count: 11
  drift_verified: 2
  next_audit_trigger: 사용자 명시 발의
audit_history:
  - from: v2.1.111
    to: v2.1.146
    audited_at: 2026-05-22
    found: 30
    evaluated: 11
    absorbed: 0
    drift_verified: 2
    notes: v7.0_mechanism-cleanup-external-pivot 안 stateful audit cycle 1 — 11 ecosystem 흡수 후보 평가만. A2 /goal + A3 hook type "mcp_tool" = spec-drift verified (대체 부적합, 보완 candidate). 즉시 도입 부재 (mandate #5 정합 — 자체 mechanism 추가 default 폐기, 외부 vector 운영 시 자연 발현 trigger 만).
  - from: v2.1.146
    to: v2.1.146
    audited_at: 2026-05-22
    found: 0
    evaluated: 4
    absorbed: 0
    drift_verified: 4
    notes: v7.1_bundled-skill-absorption-cycle-1 안 stateful audit cycle 2 — bundled skill 4 candidate 본질 한정 평가 (v6.19 + v6.21 L4/L5/L6 + dx P3#2 + security P3#3 origin). 본 세션 system reminder 안 자연 evidence direct = 거주 user-invocable skills 30+ 종합 (Anthropic 표준 `/init` `/review` `/security-review` `/loop` `/schedule` `/verify` `/code-review` `/claude-api` `/run` + 시스템 plugin `/update-config` `/keybindings-help` `/fewer-permission-prompts` + 본 repo plugin 14건 + 기타 plugin `/claude-md-management` 2건 + `/skill-creator` 1건) + 부재 4건 drift_verified (`/simplify` `/batch` `/debug` `/run-skill-generator`). 흡수 0건 (mandate #5 정합) + cross-ref 결정 4건 (cycle 1 dogfood 안 자연 outcome). catalog L120 안 `simplify` 거주 표기 stale fact direct → 표 아래 Note 정정.
---

# Claude Code 도구 카탈로그 (v4.0_harness-composer-pivot, 2026-05-13 + v7.0 stateful audit cycle 1, 2026-05-22)

`harness-meta` 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 의 **단일 source 도구 카탈로그**. `agents/` 안 `claude-docs-mapper.md` subagent 의 1차 source (phase-5 신규, v5.1+ `agents/` standard location). v5.0 부터 본 repo 자체가 Claude Code Plugin (`.claude-plugin/plugin.json` manifest) — 영역 3 (Plugin / MCP server) 와 동일 mechanism 채택.

## stateful audit mechanism (v7.0 정전화)

본 catalog 의 frontmatter (`last_audited` + `audit_history`) 는 **stateful audit mechanism** 의 single source state — Claude Code release 안 신규 features 식별 + 본 repo 흡수 결정 cycle 의 영속 trace. v7.0_mechanism-cleanup-external-pivot (2026-05-22) 안 cycle 1 evidence direct 정전화.

**책임 분리**:

- **main Claude orchestration** = audit cycle 진행 (catalog version 비교 + 신규 features list + 본 repo 흡수/유지 결정 narrative)
- **frontmatter state** = audit cycle 결과 영속 보존 (`last_audited` 최신 + `audit_history[]` array append)
- **사용자 명시 default** = audit cycle 발의 trigger 는 **사용자 명시 발의** 만 (예: '/harness-meta catalog audit', 자연어 'catalog 갱신 검토' 등). 자동 trigger default 폐기 (mandate #5 자체 mechanism 추가 default 폐기 정합).
- **/schedule 옵션** = stateful audit cycle 주기 발의 본질 시 사용자가 직접 `/schedule` slash command 활용 (예: 'Claude Code release 안 신규 features 매주 검토'). 본 repo 자체 mechanism 안 자동 cron 추가 default 폐기 (외부 vector / Claude Code built-in 활용 default).

**audit cycle 진행 step** (사용자 명시 발의 시):

1. 현 catalog `last_audited.claude_code_version` 대비 신규 release version 식별
2. 신규 features list (context7 `/websites/code_claude` query + Claude Code release notes)
3. 본 repo 정체성 + workflow 정합 검토 (4 case 매트릭스 = 흡수 / 보완 / 유지 / 폐기)
4. 흡수 결정 시 = 별 milestone 발의 (외부 vector 운영 mode 정합, 사용자 명시 발의 의무)
5. `audit_history[]` array 안 신규 entry append (`from` + `to` + `audited_at` + `found` + `evaluated` + `absorbed` + `drift_verified` + `notes`)
6. `last_audited` 최신 갱신 (claude_code_version + audited_at + new_features_found + absorbed_count + evaluated_count + drift_verified)

**cycle 1 evidence direct** (v7.0_mechanism-cleanup-external-pivot, 2026-05-22):

- catalog version `v2.1.111` (v4.0 시점 추정) → `v2.1.146` 신규 30 features found
- 11 ecosystem 후보 평가 (A1~A5 + B1~B5)
- 흡수 0건 (mandate #5 추가 default 폐기 정합)
- drift_verified 2건 (A2 `/goal` + A3 hook `type: "mcp_tool"`, RESEARCH ext_1+ext_2 정합)
- 외부 vector 운영 자연 candidate 9건 (A1 `/ultrareview` + A4 `/clear+/context` + A5 `/code-review` rename + B1~B5)

상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)

## 카탈로그 3 영역

| # | 영역 | Primary source | 사용 도구 |
|---|---|---|---|
| 1 | code.claude.com/docs (Claude Code 공식 docs) | context7 library ID `/websites/code_claude` (7393 snippets, score 81.68, 본 세션 검증) | `mcp__plugin_context7_context7__query-docs` |
| 2 | Built-in / preset slash command (Claude Code 자체) | 본 카탈로그 (수동 인벤토리) + 시스템 available-skills reminder | `Skill` tool 또는 직접 `/<command>` |
| 3 | Plugin / MCP server (외부 통합) | Anthropic plugin marketplace + [modelcontextprotocol.io](https://modelcontextprotocol.io) | `/plugin install` + MCP 설정 |

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

> **v7.1 cycle 2 drift_verified** (2026-05-22): 위 표 안 `simplify` row + Bundled skill (prompt-based playbook, L111 정합) 4건 (`simplify` `batch` `debug` `claude-api` `run-skill-generator`) 중 본 세션 system reminder 안 거주 = `claude-api` 1건, 부재 4건 (`/simplify` `/batch` `/debug` `/run-skill-generator`). bundled skill 카테고리 정전 (L111 v5.12 정합) — Claude Code 버전 분기 또는 plugin 별도 install 추정 (v6.21 L4 origin direct evidence). 본 v7.1 cycle 2 backfill 안 frontmatter `audit_history[1]` entry 거주.

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
- 메타 ARCHITECTURE: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 3.1 끝 (정체성 단일 source)
- v4.0 INTENT: [`../../projects/meta/milestones/v4.0/INTENT.md`](../../projects/meta/milestones/v4.0/INTENT.md)
- bootstrap/agents/ 두 층 구조 + 정책: [`../agents/CLAUDE.md`](../agents/CLAUDE.md)
- context7 1차 source library ID: `/websites/code_claude` (7393 snippets, score 81.68, Source Reputation: High)

# project-harness-audit-team — Orchestration

`agents/project-harness-audit-team/` 안 5 멤버 subagent 의 orchestration 단일 source. v4.0_harness-composer-pivot phase-5 신규 (2026-05-13).

상위 진입: [`../../bootstrap/agents/CLAUDE.md`](../../bootstrap/agents/CLAUDE.md) (bootstrap/agents/ 정책)

## 책임

대상 프로젝트를 분석하고 [code.claude.com/docs](https://code.claude.com/docs/) 의 도구 카탈로그를 활용하여 적재적소 harness 구성요소 (subagent / hook / skill / slash command / MCP) proposal 을 생성하고 (e3 정책 정합 = audit → propose → 사용자 결정 → apply) 사용자 명시 결정 후 mechanical install 까지 수행.

## 5 멤버 매트릭스 (D1 + D8)

| # | 멤버 | 책임 | 권한 | tools | model |
|---|---|---|---|---|---|
| 1 | `project-scanner` | 코드베이스 scan + 메타데이터 추출 | read | Read, Glob, Grep | sonnet |
| 2 | `harness-gap-analyzer` | 현 harness 진단 + built-in 충돌 + fleet evolution gap detect | read | Read, Grep, Bash | sonnet |
| 3 | `claude-docs-mapper` | code.claude.com/docs + built-in + plugin/MCP 매핑 | read | mcp__plugin_context7_context7__*, WebFetch | sonnet |
| 4 | `component-proposer` | 4 case + 5 case 매트릭스 기반 proposal draft 생성 | read-write (proposal draft 만) | Write | sonnet |
| 5 | `component-installer` | 사용자 결정 후 mechanical apply — v5.0+ custom component lifecycle (산출물 mechanical apply + plugin.json paths 갱신 + ad-hoc 검증) 책임. Plugin install lifecycle = Claude Code CLI 위임 ((Deprecated since v5.0) v4.1 D7 sequence) | **write** | Bash, Edit, Read | **opus** |

> **Note** (v5.12 정정): 표 안 'built-in' (gap-analyzer/mapper 책임 컬럼) = Claude Code built-in command 일반 (fixed-logic). 이 중 `/init`·`/review`·`/security-review` 는 Skill tool 안 discover + execute 가능 (`code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교.

## Orchestration sequence (D8)

순차 호출 — 각 단계 결과가 다음 단계 입력. 메인 Claude (orchestrator) 가 단계별 결과 다음 멤버 prompt 입력.

```text
┌─────────────────────────────────────────────────────────────────────┐
│ Step 1: project-scanner                                             │
│   Input: 대상 프로젝트 경로                                            │
│   Output: 구조 메타데이터 JSON (언어/프레임워크/harness 상태/구조)         │
└─────────────────────────────────────────────────────────────────────┘
                                ↓
┌─────────────────────────────────────────────────────────────────────┐
│ Step 2: harness-gap-analyzer                                        │
│   Input: scanner 결과                                                │
│   Output: gap list + conflict 후보 (4 case) + fleet evolution 후보 (5 case) │
└─────────────────────────────────────────────────────────────────────┘
                                ↓
┌─────────────────────────────────────────────────────────────────────┐
│ Step 3: claude-docs-mapper                                          │
│   Input: gap-analyzer 결과                                           │
│   Output: 매핑 table (gap ↔ Claude Code 도구 카탈로그 entry)            │
└─────────────────────────────────────────────────────────────────────┘
                                ↓
┌─────────────────────────────────────────────────────────────────────┐
│ Step 4: component-proposer                                          │
│   Input: docs-mapper 결과                                            │
│   Output: proposal draft markdown (각 component 별 4 case + 5 case   │
│           매트릭스 적용 + 권장 결정 + 사용자 명시 결정 필요 표지)            │
└─────────────────────────────────────────────────────────────────────┘
                                ↓
                  ┌─────────────────────────────────┐
                  │  USER DECISION GATE (e3 정책)   │  ← 메인 Claude 가 사용자 명시 결정 대기
                  │  proposal draft → 사용자 검토       │
                  │  → 명시 결정 (accept / reject / modify) │
                  └─────────────────────────────────┘
                                ↓
┌─────────────────────────────────────────────────────────────────────┐
│ Step 5: component-installer (사용자 결정 accept 시만)                  │
│   Input: 사용자 결정 + proposal                                       │
│   Output: install log — v5.0+ custom component lifecycle (산출물 .md │
│           신규/edit + .claude-plugin/plugin.json paths 갱신 + ad-hoc 검증). │
│           Plugin install lifecycle 자체는 Claude Code CLI 위임          │
└─────────────────────────────────────────────────────────────────────┘
```

> **Note** (v5.13): synthesizer (메인 Claude orchestrator) 는 Step 1~4 각 멤버 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 직접 source 매핑 검증 의무 (v5.13_audit-chain-fact-verification-protocol-procedure 절차화). hallucination 발견 시 (a) 산출물 archive 보존 + 정정 narrative inline 추가 + cascade 흡수 위치 동기 정정. 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Audit chain fact 인용 검증 의무**' paragraph (v5.11 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기.

추가 검증 의무 — markdown 구조 lint 측면 (v5.16 정전화):

> **Note** (v5.16): synthesizer (메인 Claude orchestrator) 는 Step 1~4 산출물 산출 4 멤버 (installer Step 5 제외) markdown 산출물을 repo 안 저장 시 markdownlint MD022 (blanks-around-headings) / MD031 (blanks-around-fences) / MD032 (blanks-around-lists) 3 rule 위반 사전 방지 의무 (v5.16_audit-output-markdown-lint-precheck 절차화). pre-write check — heading / fenced code block / list 직전·직후 blank line 1 줄 존재 패턴 검증. 위반 발견 시 inline blank line 정정 후 저장. 본 의무는 v5.13 Note 안 fact 검증과 직교 (별 책임 — fact 정확성 vs markdown 구조 lint). 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Agent 산출 markdown lint precheck 의무**' paragraph (v5.16 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기.

병렬 가능성 (D8 narrative 표지): Steps 1~3 은 read-only — Step 1 결과 받으면 Step 2/3 병렬 가능. 다만 단순성 우선 순차 default. 사용자 명시 시 병렬 선택 가능.

## 사용 case

### Case A — `/harness-meta <name> --audit` (phase-6 신규, v4.0)

`/harness-meta <name> --audit` 명령은 Stage A OPEN entry 안 conditional 분기 (D5) — `--audit` flag 명시 시 본 team 자동 호출. proposal draft 가 INTENT motivation 자연 입력.

### Case B — 사용자 자연어 호출

`harness-meta 안 X 프로젝트 audit 해줘` 같은 자연어 → 메인 Claude 가 Agent tool 으로 멤버 순차 호출.

### Case C — 도그푸드 (phase-8, v4.0)

`harness-meta` 자체에 본 team 적용 (phase-8 narrative). 결과 = v4.1+ 후속 candidate 만 거명, in-loop 처리 금지 (도그푸드 모순 회피, D6).

## e3 정책 정합

- propose ≠ apply 책임 분리 (Step 4 ↔ Step 5 사이 사용자 게이트)
- proposer = read + Write (draft 만), installer = write apply (mechanical)
- 사용자 명시 결정 부재 시 installer 호출 금지 (Step 5 skip)

## 관련 문서

- 상위 진입 (bootstrap/agents/ 정책): [`../../bootstrap/agents/CLAUDE.md`](../../bootstrap/agents/CLAUDE.md)
- 도구 카탈로그 (claude-docs-mapper 1차 source): [`../../bootstrap/claude-code-catalog/README.md`](../../bootstrap/claude-code-catalog/README.md)
- v4.0 DESIGN (D1/D7/D8): [`../../projects/meta/milestones/v4.0/DESIGN.md`](../../projects/meta/milestones/v4.0/DESIGN.md)
- 매트릭스 (4 case conflict + 5 case fleet): [`../../bootstrap/agents/CLAUDE.md`](../../bootstrap/agents/CLAUDE.md) § Conflict Resolution / Agent Fleet Lifecycle

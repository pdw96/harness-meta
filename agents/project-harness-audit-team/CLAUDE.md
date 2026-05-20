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

**Step 6 (v6.6 신규)** — synthesizer fact verify (orchestrator script invoke, subagent 부재):

```text
┌─────────────────────────────────────────────────────────────────────┐
│ Step 6: synthesizer fact verify (v6.6, proposer 직후 installer 직전) │
│   Invoke: 메인 Claude orchestrator (subagent 부재, deterministic)    │
│   Input: audit chain 4 산출물 디렉토리 (projects/<name>/audit-*/)    │
│   Action: python scripts/audit_fact_verify.py --dir <audit-output>  │
│   Output: stdout 안 mismatch 보고 (boolean/표/수치 3 method)         │
│           exit 0 (정상) / 1 (mismatch) / 2 (error)                  │
│   책임: 검출 only — 자동 정정 부재. 사용자/orchestrator 수동 정정      │
│         게이트 보존 (R1 결정, v5.7 spec-drift spike (c) 7번째 자연).  │
│   인용 method (cycle 4 v6.5) = LLM 추론 필요 → v6.6 scope 외 (oos_2). │
└─────────────────────────────────────────────────────────────────────┘
```

> **Note** (v5.13): synthesizer (메인 Claude orchestrator) 는 Step 1~4 각 멤버 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 직접 source 매핑 검증 의무 (v5.13_audit-chain-fact-verification-protocol-procedure 절차화). hallucination 발견 시 (a) 산출물 archive 보존 + 정정 narrative inline 추가 + cascade 흡수 위치 동기 정정. 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Audit chain fact 인용 검증 의무**' paragraph (v5.11 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기.

추가 검증 의무 — markdown 구조 lint 측면 (v5.16 정전화):

> **Note** (v5.16): synthesizer (메인 Claude orchestrator) 는 Step 1~4 산출물 산출 4 멤버 (installer Step 5 제외) markdown 산출물을 repo 안 저장 시 markdownlint MD022 (blanks-around-headings) / MD031 (blanks-around-fences) / MD032 (blanks-around-lists) 3 rule 위반 사전 방지 의무 (v5.16_audit-output-markdown-lint-precheck 절차화). pre-write check — heading / fenced code block / list 직전·직후 blank line 1 줄 존재 패턴 검증. 위반 발견 시 inline blank line 정정 후 저장. 본 의무는 v5.13 Note 안 fact 검증과 직교 (별 책임 — fact 정확성 vs markdown 구조 lint). 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Agent 산출 markdown lint precheck 의무**' paragraph (v5.16 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기.

추가 검증 의무 — agent runtime 직접 Read + 검증 method 분리 (v5.18 정전화):

> **Note** (v5.18): Step 1~4 산출 4 멤버 (installer Step 5 제외) 각 agent prompt (`agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer}.md` `## Input Verification` H2 sub-section) 안 'input 산출물 직접 Read 의무' narrative 명시 (v5.18_audit-chain-direct-read-and-verification-depth 정전화). Read tool 보유 멤버 (scanner / analyzer) = input 산출물 파일 직접 Read 의무. Read tool 부재 멤버 (mapper / proposer, D10 우회 패턴) = 메인 Claude orchestrator 가 prompt 입력 시점 input 산출물 본문 inline 첨부 의무 + 본 agent 는 첨부 본문 직접 인용 의무. 또한 v5.13 Note 안 synthesizer 직접 매핑 검증 의무는 **fact 종류 별 매핑 method 분리** 의무 흡수 — (i) boolean (예: `claude_md_in_repo: true`) = 파일 존재 여부 직접 매핑 (`ls` / `Test-Path` / Glob 1건 확인), (ii) 표 (예: 12 항목 표) = 표 안 각 row 1차 source 매핑 grep (row 별 source key 검증), (iii) 수치 (예: `loc_estimate: 18500`) = 1차 source 직접 카운팅 (Glob + Read sample 또는 Grep -c, tool-agnostic 양자 명시 — Windows Git Bash 환경 wc 부재 위험 회피). 본 의무는 v5.13 Note (fact 정확성) + v5.16 Note (markdown 구조 lint) 와 직교 추가 책임 (agent runtime 본질 + synthesizer 검증 method 분리). 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Audit chain fact 인용 검증 의무**' paragraph 절차화 sub-paragraph v5.18 cross-ref (v5.18 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step 본문.

추가 검증 의무 — script-only 자동 검출 (v6.6 정전화):

> **Note** (v6.6): v5.13 + v5.16 + v5.18 Note 누적 4번째. Step 6 (synthesizer fact verify, 위 sequence 안 신규 추가) 안 `python scripts/audit_fact_verify.py --dir <audit-output>` 자동 호출 — v5.13/v5.18 정전화 절차 (synthesizer 직접 source 매핑 검증 + boolean/표/수치 method 분리) 의 수동 cycle (v5.10~v6.5 누적 9+, evidence cycle 4) script-only 자동 검출. 자율 범위 = 검출 only (자동 정정 부재 — 재귀 hallucination 위험 차단 + 사용자 결정 게이트 보존, R1 결정). 인용 method (cycle 4 v6.5 evidence) = LLM 추론 필요 → script-only 불가능 → v6.6 scope 외 (oos_2), PROPOSE 후속. **표 schema 표준화 의무 (D3 4 agent column 본질)** — 4 agent 산출 표 column 본질 = (a) `project-scanner` 메타데이터 표 column = `# | key | value | source_path` / (b) `harness-gap-analyzer` gap list 표 = `# | gap | case | severity | source` / (c) `claude-docs-mapper` 매핑 표 = `# | gap | tool | source_url` / (d) `component-proposer` proposal 표 = `# | component | case | decision_pending | source_key`. 4 agent 산출 시 본 column 정의 따르는 의무 — 위반 시 v6.6 script 표 method detect 무력화 (source column 매핑 부재 시 row skip). 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**audit chain hallucination 자동 검출 mechanism**' paragraph + 매트릭스 #10 row (v6.6 정전화 + v6.9 5-step schema enhancement). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer step (Step 6) 본문. **v6.9 mismatch 보고 5-step 형식 enhancement**: Step 6 stdout 안 mismatch dict schema 6 필드 (method + capture/identify/isolate/fix/verify) — Anthropic Claude Code debugger subagent (<https://code.claude.com/docs/en/sub-agents>) 5-step prompt 정합. script 가 Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (null, LLM/사용자 채움, v6.6 R1 + v6.7 3-step chain 정합). isolate method-specific dict 보존 = boolean/numeric {stated, actual, key} / table {source_ref, issue}.

추가 확장 — NUMERIC_LOOKUP cycle 7 evidence + mechanism context scope (v6.14 정전화):

> **Note** (v6.14): v6.6 + v6.9 Note 누적 5번째. v6.6 mechanism 안 `NUMERIC_LOOKUP` empty {} no-op fallback 의 cycle 7 v5.17 evidence (scanner-output cycle 5 line 130 JSON 형식 `claude_md_lines: 148` + `claude_md_bytes: 9158` wc -l/-c 실측 정정) 자연 도달 = 2 entry (`claude_md_lines` + `claude_md_bytes` Python stdlib `read_text(encoding='utf-8')` + `splitlines()` len / `encode('utf-8')` len cross-platform safe) 자연 추가. **mechanism context scope 본질 명시 — harness-meta repo (REPO_ROOT 기준) context 한정 cover, target project (외부 repo 예 upbit) context 검증 oos** (v6.6 D10 path traversal 차단 narrative `safe_resolve` 안 REPO_ROOT prefix 검증 → 외부 path reject 직접 정합). 본 자기 한계 인정 narrative = 외부 context 검증 mechanism 필요 시 별 milestone 자연 (scanner agent.md `target_project_root` field 명시 + path traversal narrative 갱신). pre-PLAN 11 round 누적 결정 trace — round 5 finding (BOOLEAN_LOOKUP REPO_ROOT vs target project context mismatch) → round 9 finding (target project 외부 repo + path traversal 차단 narrative 외부 path 불허 = mechanism 작동 불가능) → round 10 (Y) 회귀 + (P1) 전면 재작성. 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**audit chain hallucination 자동 검출 mechanism**' paragraph + 매트릭스 #10 row (v6.6 정전화 + v6.9 5-step enhancement + v6.14 NUMERIC_LOOKUP cycle 7 evidence + context scope narrative).

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

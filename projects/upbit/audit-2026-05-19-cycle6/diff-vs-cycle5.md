# diff-vs-cycle5.md — upbit audit cycle 6 vs cycle 5

> **기준**: `audit-2026-05-18-cycle5/` (cycle 5, v5.17, 2026-05-18) → `audit-2026-05-19-cycle6/` (cycle 6, v5.19, 2026-05-19)
> **생성**: v5.19 phase-2 Step 1/8
> **구조**: 5+3 섹션 (D9 — v5.17 5+2 + stability cycle 정량 sub-section + lint precheck 두 번째 실전 sub-section + Input Verification 첫 실전 evidence sub-section)

## 1. 하네스 상태 delta (stability cycle)

| 항목 | cycle 5 | cycle 6 | delta |
|------|---------|---------|-------|
| plugin.json version | 1.1.0 | 1.1.0 | unchanged |
| plugin.json hooks.PreToolUse | 2건 (Bash + Write) | 2건 | unchanged |
| plugin.json hooks.PostToolUse | 1건 (post-edit-syntax-check) | 1건 | unchanged |
| plugin.json hooks.SessionStart | 1건 (session-start.sh) | 1건 | unchanged |
| plugin.json mcpServers.harness | declared (v1.18) | unchanged | stable |
| .claude-plugin/hooks/ | 2건 | 2건 | unchanged |
| .claude-plugin/agents/ count | 7 | 7 | unchanged |
| .claude-plugin/skills/ count | 7 | 7 | unchanged |
| settings.local.json stale cp | 0건 | 0건 | unchanged |
| CLAUDE.md lines | 148 | 148 | unchanged |
| CLAUDE.md L124~L125 (R1 apply) | `.claude-plugin/hooks/` + `plugin.json mcpServers.harness` | unchanged | **2 cycle 연속 APPLIED** |
| CLAUDE.md L37 (R2 apply) | `pre-commit hooks (v1.12):` | unchanged | **2 cycle 연속 APPLIED** |
| 최신 commit SHA | `5aeed93` (v1.20 chore) | `5aeed93` (불변) | **commit 0** = stability 확인 |
| untracked artifacts | 0건 | **2건** (v1.16 PROPOSE/REPORT) | 신규 untracked 발견 (audit value 부수) |

## 2. gap 분석 delta

| gap | cycle 5 상태 | cycle 6 상태 | delta |
|-----|------------|------------|-------|
| G1 (settings.local.json stale cp) | resolved (v1.19 apply) | unchanged | unchanged |
| G2 (CLAUDE.md L116~L118 symlink) | resolved (v1.19 apply) | unchanged | unchanged |
| G3 (session-init hook) | resolved (v1.19 apply) | unchanged | unchanged |
| S2 SPIKE (spike-investigator) | resolved (v1.19 apply) | unchanged | unchanged |
| R1 (CLAUDE.md L122~L125 stale narrative) | resolved (v1.20 apply) | unchanged | 2 cycle 연속 stability |
| R2 (CLAUDE.md L37 v1.20 forward reference) | resolved (v1.20 apply) | unchanged | 2 cycle 연속 stability |
| F4 SPIKE (harness-cost-tracker) | 독립 재평가 권고 (decision_pending) | **사용자 결정 Accept (a)** /usage built-in 우선 (mechanical apply 없음, P3 보류) | resolved (e3 정책, P3 유지) |
| S1/S3/S4 SPIKE | 보류 | 보류 | unchanged |
| **신규 gap** | 0건 | **0건** | unchanged (stability 강화) |

## 3. 산출물 fact 검증 delta

| 유형 | cycle 5 | cycle 6 |
|------|---------|---------|
| hallucination 건수 | scanner 2 + mapper 4 + proposer 2 = **8건** | **0건** |
| 절차 적용 | v5.13 3-layer 절차 **세 번째 실전 적용** | v5.13 3-layer 절차 **네 번째 실전 적용** + v5.18 검증 method 분리 narrative **첫 실전 적용** |
| inline 정정 방법 | 전체 inline 정정 (audit trail 보존) | 정정 대상 부재 (전 fact 1차 source 직접 매핑 PASS) |
| 절차 stability evidence | N=3 (8건 증가, 감소 추세 break) | N=4 (**0건 = 즉시 0건 달성**) — v5.18 narrative 효과 evidence 첫 cycle |
| 신 cycle hallucination 패턴 | cycle 7~9 = 8건 (scanner off-by-one + mapper SPIKE 본질 + proposer Fleet 현황) | **cycle 10 (가설) = 0건** — v5.18 Input Verification + 검증 method 분리 narrative 첫 실전 효과 |
| 누적 fact 검증 cycle | 9 cycle (1~9) | **10 cycle** (1~9 + cycle 10 = 0건) |

**hallucination 0건 달성 분석**: cycle 5 8건 → cycle 6 **0건**. 이유 = (a) **v5.18 Input Verification + 검증 method 분리 narrative 첫 실전 효과** (scanner/gap-analyzer 직접 Read 의무 + mapper/proposer D10 우회 orchestrator inline 첨부 본문 인용 + boolean/표/수치 method별 매핑 명시), (b) **stability cycle 본질** (cycle 5 → cycle 6 commit 0 = 새 fact source 부재 = hallucination 발생 base 축소). evidence N=4 통계 — 단 stability cycle 효과와 narrative 효과 단일 cycle 분리 불가 (혼합 origin). 정확 narrative 효과 검증 = cycle 7+ 추가 cycle 필요 (PROPOSE#1 후속 candidate).

## 4. proposal 비교

| # | cycle 5 proposal | cycle 6 proposal | delta |
|---|-----------------|-----------------|-------|
| P1 | (없음) | F4 SPIKE 결정 게이트 (옵션 a/b/c) | +1 (mapper 매핑 보강) |
| 총계 | 0건 | **1건** | +1 (F4 매핑 완성) |

**1건 narrative**: cycle 5 stability 도달 (신규 gap 0건). cycle 6 = stability cycle + F4 SPIKE 매핑 1건 신규 보강 (context7 + WebFetch 검증). 사용자 결정 = Accept (a) /usage built-in 우선 = mechanical apply 없음 = upbit v1.21 milestone trigger 제한적 (narrative 명시만).

## 5. ecosystem integrator vector count

| cycle | 날짜 | 대상 | 방식 |
|-------|------|------|------|
| 1 (v1.17) | 2026-05-14 | upbit | --audit 5 멤버 + installer ACCEPT ALL |
| 2 (v5.10) | 2026-05-18 | upbit | 4 멤버 read-only + diff vs cycle 1 |
| 3 (v5.14) | 2026-05-18 | upbit | 4 멤버 + v5.13 fact 검증 절차 첫 실전 적용 |
| 4 (v5.15) | 2026-05-18 | upbit | 4 멤버 + v5.13 절차 두 번째 실전 + v1.19 apply 효과 검증 |
| 5 (v5.17) | 2026-05-18 | upbit | 4 멤버 + v5.13 절차 세 번째 실전 + v5.16 lint precheck 첫 실전 + v1.20 apply 효과 검증 |
| **6 (v5.19)** | **2026-05-19** | **upbit** | **4 멤버 + v5.13 절차 네 번째 실전 + v5.16 lint precheck 두 번째 실전 + v5.18 Input Verification + 검증 method 분리 narrative 첫 실전 + stability cycle 정량 evidence** |

**누적**: 6건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth + v5.17 fifth + v5.19 sixth).

**self-loop 카운팅 정전화** (DESIGN.D3 결정):

- v4.0~v5.9 self-loop = 14 (v4.0/v4.1/v4.2/v4.3/v5.0/v5.1/v5.2/v5.3/v5.4/v5.5/v5.6/v5.7/v5.8/v5.9)
- v5.11/v5.12/v5.13/v5.16/v5.18 self-loop = 5 (audit narrative cleanup + workflow narrative 강화 = meta self-loop 카테고리)
- total self-loop = 19
- external vector = 6 (v1.17 + v5.10 + v5.14 + v5.15 + v5.17 + v5.19)
- total milestones = 25
- **self-loop ratio = 19/25 = 76%**

| baseline | self-loop ratio | 카운팅 baseline |
|---|---|---|
| v5.8 (2026-05-17) | 92.3% | 12 self-loop / 1 외부 |
| v5.10 | 87.5% | 14 / 16 |
| v5.14 (모호) | 82.4% | 14/17 |
| v5.15 (정전화) | 81% | 17/21 |
| v5.17 (갱신) | 78.3% | 18/23 |
| **v5.19 (갱신)** | **76%** | **19/25 (v5.18 self-loop 포함 + v5.19 외부)** |

monotonic 감소 추세 지속 (92.3% → 87.5% → 82.4% → 81% → 78.3% → 76%) = ecosystem integrator vector 운용 evidence 누적 정량 확인.

## 6. Stability cycle 정량 검증 sub-section (D9 v5.19 본질 가치 #1)

cycle 5 (2026-05-18) → cycle 6 (2026-05-19) 시간 간격 = 1일. 본 sub-section = stability cycle 본질 정량 evidence 기록.

| 측정 항목 | cycle 5 시점 | cycle 6 시점 | delta |
|-----------|------------|------------|-------|
| upbit 최신 commit SHA | `5aeed93` (v1.20 chore) | `5aeed93` (불변) | **0 commit 추가** |
| upbit working tree | clean (untracked 0건 가정) | untracked 2건 (v1.16 PROPOSE/REPORT) | 신규 untracked 발견 |
| upbit CLAUDE.md L37 (R2) | `pre-commit hooks (v1.12):` | 동일 | **2 cycle 연속 APPLIED** |
| upbit CLAUDE.md L124-L125 (R1) | `.claude-plugin/hooks/` + `plugin.json mcpServers.harness` | 동일 | **2 cycle 연속 APPLIED** |
| upbit plugin.json version | 1.1.0 | 1.1.0 | unchanged |
| upbit agents 7건 | 동일 | 동일 | unchanged |
| upbit skills 7건 | 동일 | 동일 | unchanged |

**stability evidence 정량**:

- **(a) commit 0 추가**: cycle 5 → cycle 6 사이 upbit repo 안 0 commit 추가 = harness-meta cycle 자체가 외부 변화 없이 audit 반복 = 첫 stability cycle 완성.
- **(b) v1.20 R1+R2 cycle 5+6 연속 APPLIED**: R1+R2 모두 2 cycle 연속 동일 상태 확인 = v1.20 apply (2026-05-18) 효과 1일 stability 유지. regression 0.
- **(c) 신규 gap 0건**: scanner + analyzer 모두 신규 gap 0건 = cycle 5 stability evidence (cycle 4→5 첫 0건) 본 cycle 6 = 2 cycle 연속 0건 = harness 안정 상태 확인.
- **(d) F4 SPIKE 결정 = mechanical apply 없음**: 사용자 Accept (a) /usage built-in 우선 = upbit repo 안 mechanical apply 없음 = stability cycle 결정 결과 정합 (audit-apply mechanism vs read-only stability detection 분리).
- **(e) audit 가치 재정의**: 신규 발견 부재 ≠ audit 가치 부재. stability evidence 자체가 audit 가치 (harness mechanical lifecycle 안정성 정량 evidence + audit-team 절차 stability evidence).

**부수 발견**: v1.16 PROPOSE/REPORT untracked 2건. scanner 결과 안 노출. v1.16 milestone 산출물 미커밋 상태 — v1.16 closing 누락 가능성. 본 v5.19 audit scope 외 (out_of_scope#1 = v1.21 산출물 본체) — 단 v1.21 안 cleanup 가능 narrative.

**INTENT.sc_5 충족 명시**: 본 sub-section = sc_5 "diff-vs-cycle5.md 생성 = v5.17 cycle 5 산출물 대비 delta 항목 정량 분류 + upbit 상태 stability/regression 검증 sub-section 포함" 직접 매핑 evidence.

## 7. v5.16 lint precheck 두 번째 실전 결과 sub-section (D9 v5.19 본질 가치 #2)

v5.16(audit-output-markdown-lint-precheck, 2026-05-18 completed)의 lint precheck 절차 두 번째 실전 적용 — synthesizer 4 산출물 저장 직전 MD022/MD031/MD032 검사 + 위반 시 inline 정정.

| 산출물 | MD022 (blanks-around-headings) | MD031 (blanks-around-fences) | MD032 (blanks-around-lists) | hardcode 외 발견 |
|--------|-------------------------------|------------------------------|----------------------------|-----------------|
| scanner-output.md | PASS | PASS | PASS | 0건 |
| analyzer-output.md | PASS | PASS | PASS | 0건 |
| mapper-output.md | PASS | PASS | PASS | **MD034 (no-bare-urls) 11건** — pre-commit markdownlint hook 단계 발견 (doc_ref URL 7건 + agent-sdk URL 1건 + F4 SPIKE 옵션 URL 3건) → 모두 `<URL>` 형식으로 inline 정정 → 재 commit PASS |
| proposal-draft.md | PASS | PASS | PASS | 0건 |
| **총계** | **0건** | **0건** | **0건** | **MD034 11건** (hardcode 외 rule) |

**검증 결과**: MD022/MD031/MD032 hardcode 3 rule 위반 0건 (4 산출물 × 3 rule = 12 cell 모두 PASS). 절차 두 번째 실전 적용 = procedure stability evidence (N=2 통계 시작).

**hardcode 외 발견 evidence — MD034 도그푸드**: mapper-output.md 안 bare URL 11건 = MD034 (no-bare-urls) 위반. v5.16 절차 hardcode 외 rule = pre-commit markdownlint hook 단계 발견 + inline 정정 (`<URL>` 형식). v5.18 PROPOSE.next_candidates#2 (`audit-output-markdown-lint-rule-expansion-md038-md028`) trigger 가속 evidence = **MD028 (no-blanks-blockquote) cycle 2 + MD038 cycle 1 + MD034 cycle 1 도그푸드 누적** = hardcode 외 rule 3종 발현 (rule 확장 candidate 보강).

**가치 분석**:

- **(a) hardcode 3 rule 효과 검증** ✓ — 4 산출물 × 3 rule = 12 cell 모두 PASS. 사전 방지 절차 작동 확인 (2 cycle 연속 PASS = procedure stability N=2).
- **(b) 절차 두 번째 실전 적용** ✓ — v5.16(2026-05-18) → v5.17 cycle 5 첫 실전 → 본 v5.19 cycle 6 두 번째 실전. evidence 누적.
- **(c) hardcode 외 rule evidence 누적 확장** ✓ — MD038 (v5.17, cycle 1) + MD034 (본 cycle 6, cycle 1) = hardcode 외 rule 2종 cycle 1씩 누적. MD028 (v5.16 자체 도그푸드) 포함 시 3종 누적.

**INTENT.sc_3 충족 명시**: 본 sub-section = sc_3 "v5.16 lint precheck 절차 적용 = synthesizer markdown 산출물 MD022/MD031/MD032 위반 검사 + 발견 위반 inline 정정 후 저장 (검사 실행 사실 기록, N=2 통계)" 직접 매핑 evidence.

## 8. v5.18 Input Verification + 검증 method 분리 narrative 첫 실전 evidence sub-section (D9 v5.19 본질 가치 #3)

v5.18(audit-chain-direct-read-and-verification-depth, 2026-05-18 completed)의 narrative 정전화 첫 실전 적용 — (a) 4 agent 안 `## Input Verification` H2 sub-section + (b) 검증 method 분리(boolean/표/수치) narrative.

### (a) Input Verification H2 sub-section 적용 evidence

| 멤버 | Read tool 보유 | 적용 method | 본 cycle 6 실제 적용 evidence |
|------|---------------|-----------|---------------------------|
| project-scanner | **보유** | 직접 Read 의무 (`C:/Users/qkreh/upbit/CLAUDE.md` 등) | Read 결과 인용: claude_md_lines 148 + L37 + L124-L125 + plugin.json version 1.1.0 등 1차 source 실측 PASS |
| harness-gap-analyzer | **보유** | 직접 Read 의무 (scanner-output.md) | analyzer-output.md fact 검증 표 안 scanner JSON 인용 + `ls .claude-plugin/agents/` 직접 실측 + cycle 5 baseline 비교 |
| claude-docs-mapper | **부재** | D10 우회 패턴 (orchestrator inline 첨부 본문 직접 인용) | mapper-output.md Input Verification 노트 = analyzer-output 인용 5건 (boolean/표/수치) method별 매핑 PASS + cycle 5 mapper 비교는 D10 우회 = synthesizer 첨부 부재 narrative 명시 |
| component-proposer | **부재** | D10 우회 패턴 (orchestrator inline 첨부 본문 직접 인용) | proposal-draft.md Input Verification 기록 = mapper-output 인용 5건 (boolean/표/수치) method별 매핑 PASS + cycle 5 proposal 비교는 D10 우회 |

**D10 우회 패턴 첫 실전 결과**: mapper + proposer 2 멤버 모두 inline 첨부 본문 인용으로 input 검증 수행. hallucination 0건. cycle 5 baseline 직접 비교 불가는 D10 우회 한계 = narrative 명시만 가능 (mapper delta 인용 간접 검증으로 우회).

### (b) 검증 method 분리 (boolean/표/수치) 적용 evidence

synthesizer fact 검증 시 v5.18 method 분리 narrative 적용:

| method | 본 cycle 6 적용 사례 | 검증 결과 |
|--------|--------------------|---------|
| boolean | `claude_md_in_repo=true` (Read 직접), `plugin_json=true` (Test-Path 직접), `mcp_json=false` (Test-Path 직접), `untracked_files: ["v1.16 PROPOSE", "v1.16 REPORT"]` (git status 직접) | 4건 모두 PASS |
| 표 | scanner directory_stats 표 (10 row × 2 col) row별 source grep, v1.20 R1+R2 apply evidence 표 (4 row × 4 col) source grep, mapper conflict_mappings 표 (3 row × 4 col) row별 source grep | 3 표 모두 PASS |
| 수치 | agents 7 (Glob), skills 7 (Glob), hooks 2 (Glob), tests 46 (Glob), bot 27 (Glob), docs 15 (Glob), claude_md_lines 148 (Read sample), scripts_files_py 107 (Glob 5종 합산), commits_since_cycle5 0 (`.git/refs/heads/main` Read SHA 비교) | 9건 모두 PASS |

**총 검증 evidence**: boolean 4 + 표 3 (총 row 17) + 수치 9 = **30 evidence 모두 PASS** (hallucination 0건). v5.18 narrative 첫 실전 효과 정량 확인.

**가치 분석**:

- **(a) Input Verification H2 sub-section 첫 실전** ✓ — Read tool 보유 멤버 (scanner/gap-analyzer) 직접 Read + 부재 멤버 (mapper/proposer) D10 우회 = 2-track narrative 작동 확인.
- **(b) 검증 method 분리 첫 실전** ✓ — boolean/표/수치 3 method 모두 적용 + 30 evidence 모두 PASS = narrative 정합 evidence 정량 확인.
- **(c) hallucination 0건 = narrative 효과 + stability cycle 본질 혼합 origin**: 단일 cycle 효과 분리 불가. 추가 cycle 7+ 통계 필요 (PROPOSE 후속 candidate).
- **(d) D10 우회 한계**: cycle 5 mapper-output / proposal-draft 직접 비교 불가 = synthesizer 첨부 의존. fallback narrative (input 부재 시 처리) = v5.18 PROPOSE#10 carry-over (`input-verification-narrative-fallback-pattern`) trigger candidate evidence 첫 사례.

**INTENT.sc_4 충족 명시**: 본 sub-section = sc_4 "v5.18 Input Verification H2 sub-section 효과 검증 = 4 agent 안 input 산출물 직접 Read (scanner/gap-analyzer) 또는 D10 우회 패턴 (mapper/proposer = orchestrator inline 첨부 본문 인용) 양 측면 실 운용 evidence 기록" 직접 매핑 evidence.

## 종합

cycle 5 → cycle 6 delta 종합:

- **resolved**: 1건 (F4 SPIKE = 사용자 Accept (a) e3 정책 결정 = P3 보류 유지) — mechanical apply 없음
- **new gap**: 0건 — cycle 6 = stability cycle 첫 완성 (2 cycle 연속 0건)
- **unchanged**: 7건 (G1/G2/G3/S2/R1/R2/S1/S3/S4 + C1/C2/C3) + R1/R2 2 cycle 연속 APPLIED
- **reclassified**: 0건
- **fleet +0**: 7+7 안정 (2 cycle 연속)
- **hallucination 0건**: cycle 10 가설 = 0건 = v5.18 narrative 첫 실전 효과 + stability cycle 혼합 origin (cycle 7+ 필요)
- **MD034 도그푸드**: 11건 발견 = v5.18 PROPOSE#2 trigger 가속 (MD034 추가 발현 누적)
- **vector 6건 누적**: self-loop 76% (정전화 갱신, monotonic 감소 지속)
- **사용자 결정**: F4 Accept (a) /usage built-in 우선 = mechanical apply 없음 = ROADMAP 등재 부재
- **stability cycle 첫 완성**: cycle 5 stability 도달 → cycle 6 = 2 cycle 연속 stability 확인 = harness 안정 상태 정량 evidence

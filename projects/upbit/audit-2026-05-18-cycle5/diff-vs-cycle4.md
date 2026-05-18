# diff-vs-cycle4.md — upbit audit cycle 5 vs cycle 4

> **기준**: `audit-2026-05-18-cycle4/` (cycle 4, v5.15, 2026-05-18) → `audit-2026-05-18-cycle5/` (cycle 5, v5.17, 2026-05-18)
> **생성**: v5.17 phase-2 Step 1/8
> **구조**: 5+2 섹션 (D9 — v5.15 5+1 + v5.16 lint precheck 첫 실전 결과 sub-section)

---

## 1. 하네스 상태 delta (v1.20 apply 결과)

| 항목 | cycle 4 | cycle 5 | delta |
|------|---------|---------|-------|
| plugin.json version | 1.1.0 | 1.1.0 | unchanged |
| plugin.json hooks.PreToolUse | 2건 (Bash + Write) | 2건 | unchanged |
| plugin.json hooks.PostToolUse | 1건 (post-edit-syntax-check) | 1건 | unchanged |
| plugin.json hooks.SessionStart | 1건 (session-start.sh) | 1건 | unchanged |
| plugin.json mcpServers.harness | declared (v1.18) | unchanged | stable |
| .claude-plugin/hooks/ | 2건 (post-edit + session-start) | 2건 | unchanged |
| .claude-plugin/agents/ count | 7 (spike-investigator 포함) | 7 | unchanged |
| .claude-plugin/skills/ count | 7 | 7 | unchanged |
| settings.local.json stale cp | 0건 (v1.19 apply 후) | 0건 | unchanged |
| CLAUDE.md L116~L118 symlink narrative | Deprecated since v5.0 | unchanged | stable |
| CLAUDE.md bytes | 9133 | **9158** (+25) | content cleanup 반영 (R1 string 길이 증가) |
| CLAUDE.md lines | 148 | 148 | unchanged |
| CLAUDE.md L122~L123 stale .claude/hooks/ + .mcp.json | identified (R1 LOW) | **L124~L125 교체 완료** (`.claude-plugin/hooks/` + `plugin.json mcpServers.harness`) | v1.20 R1 apply (line shift 122→124) |
| CLAUDE.md L37 v1.20 forward reference | identified (R2 LOW) | **`pre-commit hooks (v1.12):` 교체 완료** | v1.20 R2 apply |

## 2. gap 분석 delta

| gap | cycle 4 상태 | cycle 5 상태 | delta |
|-----|------------|------------|-------|
| G1 (settings.local.json stale cp) | resolved (v1.19 apply) | unchanged | unchanged |
| G2 (CLAUDE.md L116~L118 symlink) | resolved (v1.19 apply, L124~L125 R1 분리) | unchanged | unchanged |
| G3 (session-init hook) | resolved (v1.19 apply) | unchanged | unchanged |
| S2 SPIKE (spike-investigator) | resolved (v1.19 apply) | unchanged | unchanged |
| R1 (CLAUDE.md L122~L123 stale narrative) | identified (LOW) | **resolved** (v1.20 apply, L124~L125 교체) | 종결 |
| R2 (CLAUDE.md L37 v1.20 forward reference) | identified (LOW) | **resolved** (v1.20 apply, v1.12 대체) | 종결 |
| F4 SPIKE (harness-cost-tracker) | 독립 재평가 권고 (S2 해소 후) | **권고 유지** (decision_pending 사용자 결정) | unchanged (P2) |
| S1/S3/S4 SPIKE | 보류 | 보류 (현행 유지 사용자 결정) | unchanged |
| **신규 gap** | 2건 (R1+R2) | **0건** | -2 (cycle 5 stability 도달) |

## 3. 산출물 fact 검증 delta

| 유형 | cycle 4 | cycle 5 |
|------|---------|---------|
| hallucination 건수 | scanner claude_md_bytes 1 + proposer apply path 1 = **2건** | scanner 2 (lines off-by-one + bytes 추정) + mapper 4 (S1/S3/S4 본질 + F4 path) + proposer 2 (Fleet 현황 + Fact 검증 노트 mapper 1차 본질 임의 표기) = **8건** |
| 절차 적용 | v5.13 3-layer 절차 **두 번째 실전 적용** | v5.13 3-layer 절차 **세 번째 실전 적용** |
| inline 정정 방법 | 전체 inline 정정 (audit trail 보존) | 동일 방식 (v5.10/v5.14/v5.15 패턴 정합) |
| 절차 stability evidence | N=2 (5→2 감소 추세, 통계 약함) | N=3 (8건 증가) — 본 cycle 감소 추세 break, hallucination 증가 origin 분석 (R7 lint precheck 첫 실전 적용 evidence 누적 trigger) |
| 신 cycle hallucination 패턴 | cycle 5 (scanner bytes) + cycle 6 (proposer .claude prefix) | **cycle 7 (scanner off-by-one + 추정 부재) + cycle 8 (mapper S1/S3/S4 본질 + F4 path) + cycle 9 (proposer Fleet 현황 + Fact 노트 임의 표기)** |
| 누적 fact 검증 cycle | 6 cycle | **9 cycle** (cycle 1~9) |

**감소 추세 break 분석**: cycle 3 5건 → cycle 4 2건 → cycle 5 8건. 본 cycle 5에서 증가 = (a) 산출물 4 멤버 전체 hallucination 검증 강화 (이전 cycle 미발견 hallucination 본 cycle 발견 가능), (b) mapper agent 안 SPIKE 본질 추측 (analyzer-output.md 직접 Read 부재) — agent prompt 정정 candidate (v5.16 PROPOSE#6 audit-agent-tool-permission-enhancement trigger 가속).

## 4. proposal 비교

| # | cycle 4 proposal | cycle 5 proposal | delta |
|---|-----------------|-----------------|-------|
| P1 | R1+R2 bundled (CLAUDE.md cleanup) | (해당 없음) | apply 완료 (v1.20) |
| P2 | (없음) | (해당 없음) | — |
| 총계 | 1건 bundled | **0건** | -1 (apply 완료 + stability 도달) |

**0건 narrative**: cycle 5 신규 gap 0건 = 신규 proposal 0건. cycle 4 R1+R2 bundled proposal = v1.20 mechanical apply 완료 = OBSOLETE narrative. cycle 5 stability evidence 도달.

## 5. ecosystem integrator vector count

| cycle | 날짜 | 대상 | 방식 |
|-------|------|------|------|
| 1 (v1.17) | 2026-05-14 | upbit | --audit 5 멤버 + installer ACCEPT ALL |
| 2 (v5.10) | 2026-05-18 | upbit | 4 멤버 read-only + diff vs cycle 1 |
| 3 (v5.14) | 2026-05-18 | upbit | 4 멤버 + v5.13 fact 검증 절차 첫 실전 적용 |
| 4 (v5.15) | 2026-05-18 | upbit | 4 멤버 + v5.13 절차 두 번째 실전 + v1.19 apply 효과 검증 |
| **5 (v5.17)** | **2026-05-18** | **upbit** | **4 멤버 + v5.13 절차 세 번째 실전 + v5.16 lint precheck 첫 실전 + v1.20 apply 효과 검증** |

**누적**: 5건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth + v5.17 fifth).

**self-loop 카운팅 정전화** (DESIGN.D3 결정):

- v4.0~v5.9 self-loop = 14 (v4.0/v4.1/v4.2/v4.3/v5.0/v5.1/v5.2/v5.3/v5.4/v5.5/v5.6/v5.7/v5.8/v5.9)
- v5.11/v5.12/v5.13/v5.16 self-loop = 4 (audit narrative cleanup + workflow narrative 강화 = meta self-loop 카테고리)
- total self-loop = 18
- external vector = 5 (v1.17 + v5.10 + v5.14 + v5.15 + v5.17)
- total milestones = 23
- **self-loop ratio = 18/23 = 78.26% ≈ 78.3%**

| baseline | self-loop ratio | 카운팅 baseline |
|---|---|---|
| v5.8 (2026-05-17) | 92.3% | 12 self-loop / 1 외부 |
| v5.10 | 87.5% | 14 / 16 (v5.8/v5.9 추가 + v5.10 외부) |
| v5.14 (모호) | 82.4% | 14/17 (v5.11~v5.13 누락 카운팅) |
| v5.15 (정전화) | 81% | 17/21 (v5.11~v5.13 포함 정확 누적) |
| **v5.17 (갱신)** | **78.3%** | **18/23 (v5.16 self-loop 포함 + v5.17 외부)** |

monotonic 감소 추세 지속 (92.3% → 87.5% → 82.4% → 81% → 78.3%) = ecosystem integrator vector 운용 evidence 누적 정량 확인. integrator 정체성 운용 강화 검증.

---

## 6. v1.20 apply 효과 검증 sub-section (D9 v5.15 패턴 + 본 cycle 본질 가치)

v1.20 (upbit-audit-cycle4-apply, 2026-05-18 completed, commit 9d2862c phase-1 + 5aeed93 chore)의 mechanical apply 2 항목이 cycle 5 audit 결과 안 실제 적용 확인 — regression 0 = stability evidence.

| ID | v5.15 cycle 4 proposal | v1.20 apply 결과 (cycle 5 검증) | verdict |
|----|---------------------|-------------------------------|---------|
| **R1** | CLAUDE.md L122~L123 `.claude/hooks/post-edit-syntax-check.sh` + `.mcp.json` → `.claude-plugin/hooks/post-edit-syntax-check.sh` + `plugin.json mcpServers.harness` | scanner cycle 5 직접 Read 실측 = **L124**: `.claude-plugin/hooks/post-edit-syntax-check.sh` + **L125**: `plugin.json mcpServers.harness` (line 번호 shift L122~L123 → L124~L125, R2 apply 안 L37 변경 후 본문 line shift) | ✅ APPLIED |
| **R2** | CLAUDE.md L37 `pre-commit hooks (v1.20 C3)` → `pre-commit hooks (v1.12):` (Option A) | scanner cycle 5 직접 Read 실측 = L37: `pre-commit hooks (v1.12):` (v1.20 참조 부재) | ✅ APPLIED |

**검증 결과**: 2/2 항목 mechanical apply 완료. regression 0. 신 stability evidence 누적.

**가치 분석**:

- **(a) Stability 검증** ✓ — v1.20 apply 2 항목 모두 정확 적용 확인. regression 0 = harness mechanical lifecycle stability 누적 evidence (v1.17/v1.19 + 본 v1.20 = 3 cycle).
- **(b) Integrator vector evidence** ✓ — vector 5건 누적 정량 (v1.17 + v5.10 + v5.14 + v5.15 + v5.17). monotonic 감소 추세 지속 (92.3% → 78.3%).
- **(c) 절차 세 번째 + 첫 실전** ✓ — v5.13 3-layer fact 검증 절차 N=3 + v5.16 lint precheck 절차 N=1 동시 실전 적용.

**부수 가치**: cycle 5 신규 gap 0건 자체가 audit 가치 (stability cycle 본질 = audit-team apply 후 검증 cycle 유효성 증명).

**INTENT.sc_5 충족 명시**: 본 sub-section = sc_5 "diff-vs-cycle4.md ... + v1.20 apply 효과 검증 sub-section" 직접 매핑 evidence.

---

## 7. v5.16 lint precheck 첫 실전 결과 sub-section (D9 cycle 5 본질 가치)

v5.16(audit-output-markdown-lint-precheck, 2026-05-18 completed)의 lint precheck 절차 첫 실전 적용 — synthesizer 4 산출물 저장 직전 MD022/MD031/MD032 검사 + 위반 시 inline 정정.

| 산출물 | MD022 (blanks-around-headings) | MD031 (blanks-around-fences) | MD032 (blanks-around-lists) | hardcode 외 발견 |
|--------|-------------------------------|------------------------------|----------------------------|-----------------|
| scanner-output.md | PASS | PASS | PASS | **MD038 (no-space-in-code) 1건** — pre-commit 단계 발견 (L220 `` `- ` `` → `` `-` `` 정정) |
| analyzer-output.md | PASS | PASS | PASS | 0건 |
| mapper-output.md | PASS | PASS | PASS | 0건 |
| proposal-draft.md | PASS | PASS | PASS | 0건 |
| **총계** | **0건** | **0건** | **0건** | **MD038 1건** (hardcode 외 rule) |

**검증 결과**: MD022/MD031/MD032 hardcode 3 rule 위반 0건 (4 산출물 × 3 rule = 12 cell 모두 PASS). 절차 첫 실전 적용 = procedure stability evidence (N=1 baseline).

**hardcode 외 발견 evidence — MD038 도그푸드**: scanner-output.md L220 `` `- ` `` (backtick 안 trailing space) = MD038 (no-space-in-code) 위반. v5.16 절차 hardcode 외 rule = pre-commit markdownlint hook 단계 발견 + inline 정정 (`` `-` ``). v5.16 PROPOSE.next_candidates#2 (`audit-output-markdown-lint-rule-expansion-md028`) trigger 가속 evidence = **MD028 (no-blanks-blockquote) cycle 2 + MD038 cycle 1 도그푸드 누적** (rule 확장 candidate 보강).

**가치 분석**:

- **(a) hardcode 3 rule 효과 검증** ✓ — 4 산출물 × 3 rule = 12 cell 모두 PASS. 사전 방지 절차 작동 확인.
- **(b) 절차 첫 실전 적용** ✓ — v5.16 → v5.17 1 cycle 시간 간격 = 즉시 실전 trigger.
- **(c) hardcode 외 rule evidence 누적** ✓ — MD038 1건 발견 → MD028 (v5.16 PROPOSE#2 origin) + MD038 = rule 확장 trigger 가속 (사용자 명시 발의 + cycle 5+ 추가 발현 누적).

**INTENT.sc_3 충족 명시**: 본 sub-section = sc_3 "v5.16 lint precheck 절차 적용 = synthesizer markdown 산출물 MD022/MD031/MD032 위반 검사 + 발견 위반 inline 정정 후 저장 (검사 실행 사실 기록)" 직접 매핑 evidence.

---

## 종합

cycle 4 → cycle 5 delta 종합:

- **resolved**: 2건 (R1+R2) — v1.20 mechanical apply 완료
- **new gap**: 0건 — cycle 5 stability 도달
- **unchanged**: 7건 (G1/G2/G3/S2/S1/S3/S4 + C1/C2/C3)
- **reclassified**: 0건 (F4 권고 유지)
- **fleet +0**: 7+7 안정
- **hallucination cycle 7+8+9**: 3 cycle 추가 누적 (8건 inline 정정), 감소 추세 break = mapper agent prompt 정정 candidate trigger
- **MD038 도그푸드**: 1건 발견 = v5.16 PROPOSE#2 trigger 가속
- **vector 5건 누적**: self-loop 78.3% (정전화 갱신, monotonic 감소 지속)
- **사용자 결정**: F4 추후 (decision_pending 유지) + S1/S3/S4 현행 유지 = ROADMAP 등재 부재

# diff-vs-cycle3.md — upbit audit cycle 4 vs cycle 3

> **기준**: `audit-2026-05-18-cycle3/` (cycle 3, v5.14, 2026-05-18) → `audit-2026-05-18-cycle4/` (cycle 4, v5.15, 2026-05-18)
> **생성**: v5.15 phase-2 Step 1/8
> **구조**: 5+1 섹션 (D9 — v5.14 5 섹션 + v1.19 apply 효과 검증 sub-section)

---

## 1. 하네스 상태 delta (v1.19 apply 결과)

| 항목 | cycle 3 | cycle 4 | delta |
|------|---------|---------|-------|
| plugin.json version | 1.1.0 | 1.1.0 | unchanged |
| plugin.json hooks.PreToolUse | 2건 (Bash + Write) | 2건 | unchanged |
| plugin.json hooks.PostToolUse | 1건 (post-edit-syntax-check) | 1건 | unchanged |
| plugin.json hooks.SessionStart | **부재** | **신규** (session-start.sh) | v1.19 G3 apply |
| plugin.json mcpServers.harness | 신규 (v1.18) | unchanged | stable |
| .claude/hooks/ | 부재 (v1.17 git rename 완료) | unchanged | stable |
| .claude-plugin/hooks/ | post-edit-syntax-check.sh | **+session-start.sh** | v1.19 G3 신규 |
| .claude-plugin/agents/ count | 6 | **7** (+spike-investigator) | v1.19 S2 apply |
| .claude-plugin/skills/ count | 7 | 7 | unchanged |
| settings.local.json stale cp 4건 | L14~L17 잔존 | **제거** (grep 0 matches) | v1.19 G1 apply |
| CLAUDE.md L116~L118 symlink narrative | v4.x 잔존 | **Deprecated since v5.0 블록 교체** | v1.19 G2 apply |
| CLAUDE.md bytes | 9430 | **9133** (-297) | content cleanup 반영 |
| CLAUDE.md L124~L125 stale .claude/hooks/ + .mcp.json | 미식별 | **R1 신규 식별** | 신규 gap |
| CLAUDE.md L37 (v1.20 C3) | 미식별 | **R2 신규 식별** | 신규 gap |

## 2. gap 분석 delta

| gap | cycle 3 상태 | cycle 4 상태 | delta |
|-----|------------|------------|-------|
| G1 (settings.local.json stale cp) | identified (LOW) | **resolved** (v1.19 apply) | 종결 |
| G2 (CLAUDE.md L116~L118 symlink) | identified (LOW) | **부분 종결** (L116~L118 교체 / L124~L125 → R1 분리) | 부분 종결 |
| G3 (session-init hook 부재) | identified (LOW) | **resolved** (v1.19 apply) | 종결 |
| S2 SPIKE (재정의 활성) | active | **resolved** (spike-investigator agent 신규) | 종결 |
| R1 (CLAUDE.md L124~L125 stale narrative) | 미식별 | **신규 식별** (LOW) | 신규 gap |
| R2 (CLAUDE.md L37 v1.20 forward reference) | 미식별 | **신규 식별** (LOW) | 신규 gap |
| F4 SPIKE (harness-cost-tracker) | 보류 (S2 의존) | **독립 재평가 권고** (S2 해소 후) | reclassify |
| S1/S3/S4 SPIKE | 보류 | 보류 | unchanged |

## 3. 산출물 fact 검증 delta

| 유형 | cycle 3 | cycle 4 |
|------|---------|---------|
| hallucination 건수 | scanner claude_md_bytes 1 + mapper G2 path 1 + proposer 경로 3 = **5건** | scanner claude_md_bytes 1 + proposer apply path 1 = **2건** |
| 절차 적용 | v5.13 3-layer 절차 **첫 실전 적용** | v5.13 3-layer 절차 **두 번째 실전 적용** |
| inline 정정 방법 | 전체 inline 정정 (audit trail 보존) | 동일 방식 (cycle 3 패턴 정합) |
| 절차 stability evidence | N=1 (baseline) | N=2 (감소 추세 5→2, 단 통계 약함 N=2) |
| 신 cycle hallucination 패턴 | cycle 3 origin (mapper bundled skill) | cycle 5 (scanner bytes 추정) + cycle 6 (proposer .claude prefix 자동 추가) |

## 4. proposal 비교

| # | cycle 3 proposal | cycle 4 proposal | delta |
|---|-----------------|-----------------|-------|
| P1 | G1 stale cp 제거 | R1+R2 bundled (CLAUDE.md cleanup) | 교체 + bundling |
| P2 | G2 symlink narrative deprecated | (R1 포함) | 흡수 |
| P3 | G3 SessionStart hook | (해당 없음) | apply 완료 |
| P4 | S2 spike-investigator 재정의 | (해당 없음) | apply 완료 |
| 총계 | 4건 individual | **1건 bundled** | -3 (apply 완료) + 신규 1 bundled |

**bundling 이유**: R1 + R2 = 동일 파일 (CLAUDE.md) 동일 cleanup 유형 — single phase 권고 (Fleet evolution E4 통합 case 정합).

## 5. ecosystem integrator vector count

| cycle | 날짜 | 대상 | 방식 |
|-------|------|------|------|
| 1 (v1.17) | 2026-05-14 | upbit | --audit 5 멤버 + installer ACCEPT ALL |
| 2 (v5.10) | 2026-05-18 | upbit | 4 멤버 read-only + diff vs cycle 1 |
| 3 (v5.14) | 2026-05-18 | upbit | 4 멤버 + v5.13 fact 검증 절차 첫 실전 적용 |
| **4 (v5.15)** | **2026-05-18** | **upbit** | **4 멤버 + v5.13 절차 두 번째 실전 + v1.19 apply 효과 검증** |

**누적**: 4건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth).

**self-loop 카운팅 정전화** (DESIGN.D3 결정):

- v4.0~v5.9 self-loop = 14 (v4.0/v4.1/v4.2/v4.3/v5.0/v5.1/v5.2/v5.3/v5.4/v5.5/v5.6/v5.7/v5.8/v5.9)
- v5.11/v5.12/v5.13 self-loop = 3 (audit narrative cleanup도 meta self-loop 카테고리)
- total self-loop = 17
- external vector = 4 (v1.17 + v5.10 + v5.14 + v5.15)
- total milestones = 21
- **self-loop ratio = 17/21 = 80.95% ≈ 81%**

| baseline | self-loop ratio | 카운팅 baseline |
|---|---|---|
| v5.8 (2026-05-17) | 92.3% | 12 self-loop / 1 외부 |
| v5.10 | 87.5% | 14 / 16 (v5.8/v5.9 추가 + v5.10 외부) |
| v5.14 (모호) | 82.4% | 14/17 (v5.11~v5.13 누락 카운팅) |
| **v5.15 (정전화)** | **81%** | **17/21 (v5.11~v5.13 포함 정확 누적)** |

monotonic 감소 추세 = ecosystem integrator vector 운용 evidence 누적 정량 확인. integrator 정체성 운용 강화 검증.

---

## 6. v1.19 apply 효과 검증 sub-section (D9 신규 — cycle 4 본질 가치)

v1.19 (upbit-audit-cycle3-apply, 2026-05-18 completed)의 mechanical apply 4 항목이 cycle 4 audit 결과 안 실제 적용 확인 — regression 0 = stability evidence.

| ID | v5.14 cycle 3 proposal | v1.19 apply 결과 (cycle 4 검증) | verdict |
|----|---------------------|-------------------------------|---------|
| **G1** | settings.local.json L14~L17 stale cp 4건 제거 | scanner grep 결과 = `.claude/commands\|agents\|skills\|output-styles` 패턴 **0 matches** | ✅ APPLIED |
| **G2** | CLAUDE.md L114~L127 v4.x symlink narrative 7줄 → Deprecated 블록 교체 | CLAUDE.md L116~L118 = "Deprecated since v5.0 — SymbolicLink/Junction 수동 매핑 (~/.claude/{commands,hooks,statusline,skills,agents}/) 은 비활성. 현행 설치는 claude plugin install harness-meta@harness-meta 표준 명령 사용." | ✅ APPLIED (단 L124~L125 → R1 분리, 별 cleanup 필요) |
| **G3** | plugin.json SessionStart hook + .claude-plugin/hooks/session-start.sh 신규 | plugin.json hooks.SessionStart[0] = {type: 'command', command: 'bash ${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh'} + 물리 파일 거주 | ✅ APPLIED |
| **S2** | spike-investigator subagent 신규 | .claude-plugin/agents/spike-investigator.md 거주, agents count 6 → 7 | ✅ APPLIED |

**검증 결과**: 4/4 항목 mechanical apply 완료. regression 0. 신 stability evidence 누적.

**가치 분석**:

- **(a) Stability 검증** ✓ — v1.19 apply 4 항목 모두 정확 적용 확인. regression 0 = harness mechanical lifecycle stability.
- **(b) Integrator vector evidence** ✓ — vector 4건 누적 정량 (v1.17 + v5.10 + v5.14 + v5.15). monotonic 개선 추세 (92.3% → 81%).
- **(c) 절차 두 번째 적용** ✓ — v5.13 3-layer fact 검증 절차 N=2 누적. hallucination 5→2 감소 추세 evidence (통계 약하나 trend 명시).

**부수 가치**: cycle 4 신규 gap 2건 (R1+R2) 자체 발견 = audit 자체 가치 (v5.14 → v5.15 audit narrative cleanup 추가 trigger).

**INTENT.sc_3 충족 명시**: 본 sub-section = sc_3 "diff-vs-cycle3.md ... + v1.19 apply 4 항목 효과 검증 sub-section 포함" 직접 매핑 evidence.

---

## 종합

cycle 3 → cycle 4 delta 종합:

- **resolved**: 4건 (G1/G2 부분/G3/S2) — v1.19 mechanical apply 완료
- **new gap**: 2건 (R1+R2) — LOW severity bundled
- **unchanged**: 5건 (S1/S3/S4/C1/C2)
- **reclassified**: 1건 (F4 — S2 의존 해소 후 독립 재평가)
- **fleet +1**: spike-investigator (S2 apply)
- **hallucination cycle 5+6**: 2건 inline 정정 (cycle 3 5건 baseline 대비 감소 추세)
- **vector 4건 누적**: self-loop 81% (정전화 baseline)

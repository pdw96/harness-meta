# diff-vs-cycle6.md — upbit audit cycle 7 vs cycle 6

> **기준**: `audit-2026-05-19-cycle6/` (cycle 6, v5.19, 2026-05-19) → `audit-2026-05-19-cycle7/` (cycle 7, v5.20, 2026-05-19)
> **생성**: v5.20 phase-2 Step 1
> **구조**: 5+3 섹션 (D9 정합 — stability 본질 정량 sub-section + hallucination 재발 evidence sub-section + 3 cycle 연속 stability evidence sub-section)

## 1. 하네스 상태 delta (stability cycle 두 번째)

| 항목 | cycle 6 | cycle 7 | delta |
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
| CLAUDE.md lines | 148 (cycle 6 기재) | **149** (직접 Read 실측) | **+1 (cycle 6 집계 오차 정정, 내용 불변)** |
| CLAUDE.md L124~L125 (R1) | APPLIED | APPLIED | **3 cycle 연속 APPLIED** |
| CLAUDE.md L37 (R2) | APPLIED | APPLIED | **3 cycle 연속 APPLIED** |
| 최신 commit SHA | `5aeed93` (v1.20 chore) | `5aeed93` (불변) | **commit 0** = stability 두 번째 확인 |
| untracked artifacts | 2건 (v1.16 PROPOSE/REPORT) | 2건 (동일) | unchanged (v5.19 L7 carry-over) |

## 2. gap 분석 delta

| gap | cycle 6 상태 | cycle 7 상태 | delta |
|-----|------------|------------|-------|
| G1~G3 (cycle 3 resolved) | unchanged | unchanged | unchanged |
| R1 (CLAUDE.md L122~L125 stale narrative) | resolved (v1.20 apply) | unchanged | 3 cycle 연속 stability |
| R2 (CLAUDE.md L37 v1.20 forward reference) | resolved (v1.20 apply) | unchanged | 3 cycle 연속 stability |
| F4 SPIKE (harness-cost-tracker) | 사용자 결정 Accept (a) /usage built-in | unchanged (cycle 6 결정 carry-over) | resolved (e3 정책, P3 유지) |
| S1/S3/S4 SPIKE | 보류 | 보류 | unchanged |
| **신규 gap** | 0건 | **0건** | unchanged (stability 강화) |

## 3. 산출물 fact 검증 delta

| 유형 | cycle 6 | cycle 7 |
|------|---------|---------|
| hallucination 건수 | **0건** (v5.18 narrative 첫 실전 효과) | **2건** (mapper origin) — MD034 카운트 6→4 + F4 본질 cost-tracker→spike-investigator cascade |
| 절차 적용 | v5.13 3-layer 절차 **네 번째 실전** + v5.18 검증 method 분리 narrative **첫 실전** | v5.13 3-layer 절차 **다섯 번째 실전** + v5.18 narrative **두 번째 실전** |
| inline 정정 방법 | 정정 대상 부재 | 2건 inline 정정 (mapper + proposer cascade) + audit trail 보존 ([v5.20 정정] 표지) |
| 절차 stability evidence | N=4 (cycle 6 = 0건 즉시 달성) | N=5 (cycle 7 = 2건 재발, evidence isolation 한계 첫 발현) |
| 신 cycle hallucination 패턴 | cycle 6 = 0건 — v5.18 narrative 첫 실전 효과 | cycle 7 = 2건 — D10 우회 패턴 한계 evidence (mapper hallucination cascade → proposer) |
| 누적 fact 검증 cycle | 10 cycle | **11 cycle** (cycle 1~10 + cycle 11 = 2건) |

**중요 evidence — v5.19 L1 narrative effect isolation 한계 첫 발현**: cycle 6 (v5.18 narrative 첫 실전) = 0건 / cycle 7 (v5.18 narrative 두 번째 실전 + 동일 baseline) = 2건. 동일 narrative + 동일 baseline에서 cycle 별 hallucination 변동 = narrative 효과 단일 source 분리 미가능 evidence 직접 (cycle 6 0건 = narrative 효과 + 우연 / cycle 7 2건 = narrative 한계 + 우연). v5.18 PROPOSE#10 + v5.19 PROPOSE#1 trigger 추가 누적.

## 4. lint precheck delta (v5.16 절차 세 번째 실전)

| rule | cycle 6 결과 | cycle 7 결과 | delta |
|------|-----------|-----------|-------|
| MD022 (blanks-around-headings) | 4 산출물 12 cell PASS | 4 산출물 PASS | unchanged |
| MD031 (blanks-around-fences) | 4 산출물 12 cell PASS | 4 산출물 PASS | unchanged |
| MD032 (blanks-around-lists) | 4 산출물 12 cell PASS | 4 산출물 PASS | unchanged |
| MD034 (no-bare-urls) | 11건 발현 (mapper 7+1+3) inline 정정 | **4건** angle bracket 적용 PASS (mapper 4건 + proposer 1건) — 발현 감소 | **-7건 (mapper 안 doc_ref 표 cell 수 감소)** |
| 추가 rule (MD028/MD038) | MD028 v5.16 도그푸드 1건 (cycle 6 자체 페이지) / MD038 v5.17 1건 | 0건 | unchanged |

**lint precheck 절차 stability evidence**: 3 cycle 누적 (cycle 5 = MD038 1건 / cycle 6 = MD034 11건 / cycle 7 = MD034 4건). hardcode 외 rule (MD028/MD034/MD038) 3종 누적 — v5.19 PROPOSE#3 trigger 누적 evidence.

## 5. stability cycle evidence 누적

| 측면 | cycle 5 (baseline) | cycle 6 (stability 1st) | cycle 7 (stability 2nd) | verdict |
|------|---------|---------|---------|---------|
| upbit commit SHA | `5aeed93` | `5aeed93` (불변) | `5aeed93` (불변) | **3 cycle 동일** |
| R1 APPLIED | YES | 2 cycle 연속 | **3 cycle 연속** | strengthened |
| R2 APPLIED | YES | 2 cycle 연속 | **3 cycle 연속** | strengthened |
| 신규 gap | 0건 | 0건 | 0건 | **3 cycle 0건** |
| audit chain 산출물 수 | 4건 | 4건 + diff (5건) | 4건 + diff (5건) | unchanged |
| 신규 proposal | 1건 (F4 신규 매핑) | 1건 (F4 Accept (a)) | 0건 (carry-over) | converged |

**stability cycle pattern 정전화 trigger 충족** — 3 cycle 연속 baseline 동일 + R1+R2 3 cycle 연속 APPLIED + 신규 gap 0건 + 신규 proposal converged. ARCHITECTURE § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화 candidate (DESIGN D4 anchor).

## 6. v5.19 → v5.20 sub-section — narrative effect isolation 한계 evidence 첫 발현 (v5.19 L1 carry-over)

cycle 6 baseline (v5.18 narrative 첫 실전) hallucination 0건 결과 = (a) narrative 효과 + (b) 우연 (stability baseline 동일 + 우연 정확) 혼합. cycle 7 = 동일 baseline + 동일 narrative (v5.18 narrative 두 번째 실전) = hallucination 2건 발현 → (a) narrative 효과만으로는 0건 보장 부재 evidence + (b) 우연 분포 본질 evidence.

**해석**: cycle 6의 0건 = 우연 정확 발현 단일 cycle / cycle 7의 2건 = stability cycle 안 hallucination 발현 분포 본질. v5.19 PROPOSE#1 `audit-cycle-7-narrative-effect-isolation` trigger 조건 = "cycle 7+ commit 발생 후 호출 = 새 fact source 추가 = narrative 효과 단일 evidence 가능" — 본 cycle 7 = upbit commit 부재 → 새 fact source 부재 → narrative 효과 단일 evidence 도출 한계 직접 확인. cycle 8+ (commit 발생 후) 추가 호출 필요.

## 7. v5.19 → v5.20 sub-section — 3 cycle 연속 stability ARCHITECTURE § 4 정전화 trigger 충족

v5.19 PROPOSE#4 (`audit-cycle-stability-pattern-canonicalization-architecture`, v5.18 PROPOSE#3 carry-over) trigger 조건 = "사용자 명시 발의 (A_user) ∧ cycle 7+ 추가 stability cycle 누적 (3 cycle 연속 stability)". 본 v5.20 = 사용자 명시 발의 (A_user, 2026-05-19) ∧ cycle 7 호출 후 cycle 5+6+7 = 3 cycle 연속 stability 충족 → trigger 자연 충족.

본 phase-2 = ARCHITECTURE.md § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화 단일 책임. paragraph 본문 = stability cycle 정의 + evidence (cycle 5+6+7 baseline 동일 + R1+R2 3 cycle 연속 APPLIED + 신규 gap 0건) + 1차 source cross-ref (cycle 6/7 diff).

## 8. v5.19 → v5.20 sub-section — § 4 끝 paragraph 6→7 누적 매트릭스화 trigger 충족

v5.19 PROPOSE#8 (`architecture-section-4-end-paragraph-matrix-canonicalization`) trigger 조건 = "사용자 명시 발의 (A_user) ∧ § 4 끝 paragraph 6건+ 누적". 본 v5.20 phase-2 = stability paragraph 추가 시 7건 누적 → trigger 자연 충족. 단 매트릭스화 phase-3 = scenario B 결정 (의문 round 2 사용자 결정).

phase-3 = 7 paragraph 표 변환 + agent namespace prefix cascade 7 위치 통합 (의미 단위 bundling).

## lint precheck (v5.16 절차 세 번째 실전)

| 규칙 | 검사 결과 | 조치 |
|------|----------|------|
| MD022 | PASS | 없음 |
| MD031 | PASS | 없음 |
| MD032 | PASS | 없음 |
| MD034 | PASS — `<...>` angle bracket 부재 (본 파일 inline URL 없음) | 없음 |

**위반 건수**: 0건.

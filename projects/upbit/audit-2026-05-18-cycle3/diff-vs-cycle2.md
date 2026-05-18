# diff-vs-cycle2.md — upbit audit cycle 3 vs cycle 2

> **기준**: `audit-2026-05-18/` (cycle 2, v5.10, 2026-05-18) → `audit-2026-05-18-cycle3/` (cycle 3, v5.14, 2026-05-18)
> **생성**: v5.14 phase-2 Step 1/7

---

## 1. 하네스 상태 delta (v1.18 적용 결과)

| 항목 | cycle 2 | cycle 3 | delta |
|------|---------|---------|-------|
| plugin.json version | 1.0.0 | **1.1.0** | v1.18 bump |
| plugin.json hooks | 부재 (N4 gap) | **신규** (PreToolUse+PostToolUse) | N4 해소 |
| plugin.json mcpServers | 부재 (N4 gap) | **신규** (harness stdio) | N4 해소 |
| .mcp.json | 존재 | **삭제** | plugin.json 흡수 |
| .claude/hooks/ | post-edit-syntax-check.sh | **이전** → .claude-plugin/hooks/ | git rename 100% |
| .claude/settings.json hooks block | 존재 | **제거** | plugin.json 흡수 |
| claude_md_in_repo | false (HALLUCINATION) | **true** (9430 bytes) | v5.11 정정 + cycle 3 실측 확인 |

## 2. gap 분석 delta

| gap | cycle 2 상태 | cycle 3 상태 | delta |
|-----|------------|------------|-------|
| N4 (hooks/mcpServers 미선언) | open | **resolved** (v1.18) | 해소 |
| A2/G1 (settings.local.json stale cp) | identified | **identified** (미해소) | 지속 |
| A3/G3 (session-init hook 부재) | identified | **identified** (미해소) | 지속 |
| G2 (CLAUDE.md symlink narrative) | 미식별 | **신규 식별** | 신규 |
| S2 SPIKE (subagent 재정의) | 보류 | **재정의 활성** (v1.18 보류 사유 해소) | 활성화 |

## 3. 산출물 fact 검증 delta

| 유형 | cycle 2 | cycle 3 |
|------|---------|---------|
| hallucination 건수 | proposer 12 항목 표 1건 + scanner claude_md_in_repo 1건 = 2건 | scanner claude_md_bytes 1건 + mapper G2 path 1건 + proposer 경로 3건 = 5건 정정 |
| 정정 방법 | proposer = synthesizer overwrite / scanner = v5.11 inline 정정 | 전체 inline 정정 (v5.13 절차 정합) |
| v5.13 절차 적용 | N/A (절차 미존재) | **첫 실전 적용** — 3-layer HOW step 작동 확인 |

## 4. proposal 비교

| # | cycle 2 proposal | cycle 3 proposal | delta |
|---|-----------------|-----------------|-------|
| P1 | N4 hooks 선언 (v1.18 적용됨) | G1 stale cp 제거 | 교체 |
| P2 | N4 mcpServers 선언 (v1.18 적용됨) | G2 symlink narrative deprecated 표지 | 신규 |
| P3 | SPIKE 보류 2건 | G3 SessionStart hook | 교체 |
| P4 | (해당 없음) | S2 spike-investigator 재정의 | 신규 |
| 총계 | 3건 | 4건 | +1 |

## 5. ecosystem integrator vector count

| cycle | 날짜 | 대상 | 방식 |
|-------|------|------|------|
| 1 (v1.17) | 2026-05-14 | upbit | --audit 5 멤버 + installer ACCEPT ALL |
| 2 (v5.10) | 2026-05-18 | upbit | 4 멤버 read-only + diff vs cycle 1 |
| **3 (v5.14)** | **2026-05-18** | **upbit** | **4 멤버 + v5.13 fact 검증 절차 첫 실전 적용** |

**누적**: 3건 (v1.17 first + v5.10 second + v5.14 third)

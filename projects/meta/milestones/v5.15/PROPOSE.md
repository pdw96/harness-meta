---
id: v5.15
title: PROPOSE v5.15
version: v5.15
stage: PROPOSE
status: completed
---

# PROPOSE — v5.15 external-audit-team-cycle-4-call

## Spec

```json
{
  "next_candidates": [
    {
      "id": "upbit-v1.20-audit-cycle4-apply",
      "origin": "v5.15 Phase 1 사용자 ACCEPT ALL 결정 (R1+R2 bundled, R2 Option A) — A_user trigger",
      "rationale": "cycle 4 proposal R1+R2 bundled 사용자 ACCEPT 결정 — component-installer 적용 = upbit v1.20 milestone 직접 trigger. v5.14 PROPOSE.next_candidates#1 → upbit v1.19 → 본 v5.15 PROPOSE.next_candidates#1 → upbit v1.20 패턴 정합 (cycle audit + apply 분리 3 cycle 누적 evidence). v5.15 INTENT.out_of_scope#1 (v1.20 산출물 본체) + #5 (installer 호출) 정합.",
      "trigger_condition": "v5.15 완료 직후 — A_user trigger (사용자 ACCEPT ALL 결정 기록됨 — Stage F phase-1 Step 6 / APPROVE / VERIFY criteria sc_5 PASS)",
      "trigger_type": "A_user",
      "decision": "ROADMAP 등재 — upbit/ROADMAP.md milestones[] 추가",
      "apply_scope": [
        "R1: upbit/CLAUDE.md L124~L125 narrative 정정 (.claude/hooks/ → .claude-plugin/hooks/ + .mcp.json → plugin.json mcpServers.harness)",
        "R2: upbit/CLAUDE.md L37 (v1.20 C3) → (v1.12) 대체 (Option A)"
      ]
    },
    {
      "id": "audit-output-markdown-lint-precheck",
      "origin": "v5.14 PROPOSE.next_candidates#3 carry-over (origin: v5.14 L7 lesson) + v5.15 L5 재현 (markdownlint MD031/MD032 8건 회귀) = 2 사례 누적 trigger 조건 충족",
      "rationale": "agent 산출 markdown을 repo 저장 시 MD022/MD031/MD032 lint 위반 자동 발생 — v5.14 L7 origin (3건 발생) + 본 v5.15 L5 재현 (8건 발생) = 누적 2 사례. agent 산출 직후 lint 자동 검증 절차 정전화 (pre-write check 또는 inline blank line 패턴 명시) 필요. 향후 cycle 5+ 추가 누적 시 발생률 정량 evidence 강화.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 이미 2 사례 trigger 충족 (즉시 발의 가능)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, e3 정책 lightweight default 동결 정합)"
    },
    {
      "id": "external-audit-team-cycle-5-call",
      "origin": "v5.15 L1 lesson — v5.13 절차 stability evidence N=2 통계 약함, cycle 5+ 추가 누적 필요",
      "rationale": "v5.14 cycle 3 = 5 hallucination → v5.15 cycle 4 = 2 hallucination = 감소 추세이나 N=2 통계 약함. cycle 5+ 추가 누적 시 정량 evidence 강화. trigger 조건 — upbit v1.20 완료 후 OR 사용자 명시 발의. ecosystem integrator vector 5건 누적 = self-loop 비율 추가 갱신.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ v1.20 완료 후",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "self-loop-classification-criteria-definition",
      "origin": "v5.15 § 6 디테일 분석 잠재 issue #1 — self-loop 분류 기준 정의 부재 (root cause)",
      "rationale": "v5.14 baseline 모호 + 본 v5.15 D3 정전화는 본 milestone 단일 카운팅 결정. ARCHITECTURE.md 안 self-loop 분류 기준 (audit narrative cleanup = self-loop? external vector 정의?) 정의 부재 — 향후 milestone에서 동일 모호 재발 risk. ARCHITECTURE § 3.1 끝 또는 § 4 끝 분류 기준 정의 paragraph 정전화 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 추가 카운팅 모호 사례 발생",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "architecture-section-3-1-baseline-drift-cleanup",
      "origin": "v5.15 § 6 디테일 분석 잠재 issue #4 — ARCHITECTURE § 3.1 L77 v5.8 baseline narrative drift 누적",
      "rationale": "L77 v5.8 baseline (92.3% self-loop) 시점 paragraph 보존 — v5.10/v5.14/v5.15 cycle 누적 후 stale narrative. architecture agent 권고 = '본 milestone 갱신 불요 (out_of_scope#3 정합)'이나 별 milestone에서 stale narrative cleanup 의무. v3.20 ARCHITECTURE § 4 끝 paragraph 정전화 패턴 정합.",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "audit-agent-tool-permission-enhancement",
      "origin": "v5.15 L2 lesson — scanner agent Glob/Read 한계 + proposer .claude/ prefix systematic confusion",
      "rationale": "scanner agent에 Bash 권한 (wc -c) 추가 검토 + proposer agent prompt 안 path prefix confusion 회피 instruction 추가. agent 정의 (.md) 변경 = ecosystem integrator vector 강화 본질. cycle 5+ 누적 시 hallucination cycle 6 동질 패턴 재발 회피 evidence.",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "harness-cost-tracker-spike-reevaluation",
      "origin": "v5.15 cycle 4 analyzer F4 후보 (S2 의존 해소 후 독립 재평가 권고) + mapper fleet_evolution_candidates",
      "rationale": "F4 SPIKE = harness-cost-tracker (S2 의존). v1.19 S2 apply 완료 = 의존 해소. 독립 재평가 = (a) 필요성 검증 (b) 대안 (c) 본 fleet 안 흡수 결정. analyzer 거명 + mapper 거명 = 본 milestone scope 외 별 milestone candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    }
  ]
}
```

## Roadmap registration count

1

## Policy compliance

- **lightweight_default_freeze_compliance**: ROADMAP 등재 1건 (upbit-v1.20-audit-cycle4-apply) — A_user trigger 사용자 ACCEPT ALL 결정 기반. 나머지 6건 거명만 (lightweight default 동결 정합, v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium).
- **byproduct_absorption_compliance**: INTENT.out_of_scope 5건 사실 진술 + RESEARCH.untouched_files_explicit 사실 진술 + DESIGN.decisions rationale forward propose 명령형 부재 (v3.10 정합). 본 PROPOSE 안 B/C/D 부산물 1차 source 흡수 (단일 origin 강제).

## PROPOSE summary

v5.15 후속 forward proposal 7건 (등재 1건 + 거명만 6건). 등재 1건 = upbit v1.20 (사용자 ACCEPT 결정 직접 trigger, v5.14 → v1.19 → 본 패턴 3 cycle 누적). 거명만 6건 = (1) audit-output markdown lint precheck (v5.14 PROPOSE#3 carry-over + 재현 = 2 사례 trigger 충족) / (2) cycle 5 호출 (N=2 통계 약함 mitigation) / (3) self-loop 분류 기준 정의 (디테일 분석 § 6 잠재 issue #1) / (4) ARCHITECTURE § 3.1 L77 baseline drift cleanup (잠재 issue #4) / (5) audit agent 도구 권한 강화 (L2 scanner Bash + proposer prompt) / (6) harness-cost-tracker SPIKE 재평가 (analyzer F4).

## narrative

### ROADMAP 등재 1건 — upbit-v1.20-audit-cycle4-apply

사용자 ACCEPT ALL R1+R2 결정이 직접 trigger. upbit/ROADMAP.md에 v1.20 entry 등재 의무.

**Apply scope**:

- R1: `C:/Users/qkreh/upbit/CLAUDE.md` L124~L125 narrative 정정 (.claude/hooks/ → .claude-plugin/hooks/ + .mcp.json → plugin.json mcpServers.harness)
- R2: `C:/Users/qkreh/upbit/CLAUDE.md` L37 `(v1.20 C3)` → `(v1.12)` 대체 (Option A)

**v5.14 → v1.19 → v5.15 → v1.20 패턴 정합** (cycle audit + apply 분리 3 cycle 누적 evidence):

- v5.14 (cycle 3 audit) → v1.19 (apply 4 항목)
- v5.15 (cycle 4 audit) → v1.20 (apply R1+R2 bundled)

### next_candidates 6건 거명만 (ROADMAP 등재 zero)

1. `audit-output-markdown-lint-precheck` — v5.14 PROPOSE#3 carry-over + v5.15 L5 재현 = 2 사례 trigger 충족 (즉시 발의 가능)
2. `external-audit-team-cycle-5-call` — N=2 통계 약함 mitigation, cycle 5 추가 누적
3. `self-loop-classification-criteria-definition` — § 6 잠재 issue #1, 분류 기준 ARCHITECTURE 정전화
4. `architecture-section-3-1-baseline-drift-cleanup` — § 6 잠재 issue #4, L77 v5.8 baseline narrative drift
5. `audit-agent-tool-permission-enhancement` — L2 scanner Bash + proposer prompt instruction 강화
6. `harness-cost-tracker-spike-reevaluation` — analyzer F4 후보, S2 의존 해소 후 독립 재평가

### lightweight default 동결 정합

ROADMAP 등재 = 1건 (사용자 ACCEPT 결정 직접 trigger) — e3 정책 정합. 나머지 6건 거명만 = lightweight default 동결 정합 (v4.0 § 6.2 폐지 후 가드레일 narrative 흡수 medium 정합, memory feedback_section_6_2_abolished 정합).

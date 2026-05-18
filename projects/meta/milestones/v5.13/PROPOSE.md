# PROPOSE — v5.13 audit-chain-fact-verification-protocol-procedure

```json
{
  "id": "v5.13_audit-chain-fact-verification-protocol-procedure",
  "roadmap_registration_count": 0,
  "next_candidates": [
    {
      "id": "harness-meta-informal-terminology-spec-source-conflict-audit",
      "origin": "v5.12 PROPOSE#2 carry-over (L3 lesson)",
      "rationale": "harness-meta 안 informal 용어 ↔ spec source 정의 충돌 사례 audit cycle. v5.12 = 'bundled skill 별칭' spec drift 정정. 추가 informal 용어 (subagent / hook / skill 등) audit 필요성 유지. v5.13 = L1 lesson 'WHAT ↔ WHERE/HOW 분리 검증' 패턴 강화로 informal 용어 drift 식별 용이성 증가.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 추가 informal 용어 ↔ spec 충돌 사례 1+ 발견",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "three-layer-cross-ref-pattern-canonicalization",
      "origin": "v5.13 L2 lesson 신규 origin",
      "rationale": "정의(ARCHITECTURE) + orchestration(agent CLAUDE.md) + workflow step(command) 3-layer cross-ref 구조 패턴을 ARCHITECTURE § 6 또는 별도 section 안 정전화. v5.13 = 첫 3-layer 적용 사례. 향후 유사 책임 명시 시 재활용 기준 필요.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 2+ 사례 누적",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "context7-multi-source-verification-discipline-canonicalization",
      "origin": "v5.12 PROPOSE#3 carry-over",
      "rationale": "RESEARCH context7 query 4+ source 다중 인용 의무 narrative 정전화. v5.12 = 5 source 인용 일관 명시. v5.13 = context7 미사용 (텍스트 삽입 milestone) — carry-over 유지.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ workflow 강화 cycle 필요 명시",
      "decision": "거명만 (ROADMAP 등재 zero, workflow self-improvement 본질)"
    },
    {
      "id": "audit-output-correction-pattern-canonicalization-cycle-2",
      "origin": "v5.12 PROPOSE#5 carry-over",
      "rationale": "v5.11 L1 패턴 (agent 직접 산출 inline 정정 vs synthesizer 임시 산출 overwrite) cycle 2 적용 evidence 누적. v5.13 = 산출물 직접 정정 없음 — carry-over 유지.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 3+ evidence 누적",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "upbit-plugin-json-hooks-mcpservers-extension",
      "origin": "v5.12 PROPOSE#6 carry-over (v5.10 PROPOSE#1 origin)",
      "rationale": "upbit .claude-plugin/plugin.json hooks + mcpServers 필드 추가. v1.18 완료 (v5.12 기준). 현재 상태 재확인 필요 — v1.18 이미 완료 시 carry-over 종료.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ v1.18 완료 여부 재확인",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "external-audit-team-cycle-3-call",
      "origin": "v5.12 PROPOSE#7 carry-over (v5.10 PROPOSE#6 origin)",
      "rationale": "audit-team 외부 호출 cycle 3 — ecosystem integrator 정체성 vector 운용 evidence. v5.13 = meta self-loop (외부 vector 직접 운용 부재). v5.13 fact 검증 절차 정전화로 cycle 3 사전 준비 강화.",
      "trigger_condition": "사용자 명시 발의 (A_user) — 외부 적용 vector 추가 누적 후",
      "decision": "거명만 (ROADMAP 등재 zero)"
    }
  ],
  "policy_compliance": {
    "lightweight_default_freeze_compliance": "ROADMAP 등재 0건 = lightweight default 동결 정합. v5.13 = Lightweight 모드 (1-phase, 3 파일 텍스트 삽입) — 14/30 = 46.7% 누적.",
    "byproduct_absorption_compliance": "INTENT.out_of_scope 4건 (B 부산물) + RESEARCH.untouched_files + risks_identified (C 부산물) 모두 사실 진술만. DESIGN.decisions rationale + phases scope (D 부산물) forward propose 명령형 부재 확인 (v3.10 정합)."
  }
}
```

## narrative

v5.13 milestone 후속 forward proposal. ROADMAP 등재 0건 — lightweight default 동결 + § 6.2 폐지 narrative 정합.

### next_candidates 6건 거명

1. `harness-meta-informal-terminology-spec-source-conflict-audit` (v5.12 #2 carry-over)
2. `three-layer-cross-ref-pattern-canonicalization` (v5.13 L2 신규 origin — 3-layer 패턴 정전화)
3. `context7-multi-source-verification-discipline-canonicalization` (v5.12 #3 carry-over)
4. `audit-output-correction-pattern-canonicalization-cycle-2` (v5.12 #5 carry-over)
5. `upbit-plugin-json-hooks-mcpservers-extension` (v5.12 #6 carry-over — v1.18 완료 시 종료 가능)
6. `external-audit-team-cycle-3-call` (v5.12 #7 carry-over)

### v5.12 PROPOSE candidates 흡수 narrative

v5.12 PROPOSE 7건 안:

- #1 (audit-chain-fact-verification-protocol-procedure) = 본 v5.13 완료 → 거명 제외
- #2 = 본 v5.13 PROPOSE#1 carry-over
- #3 = 본 v5.13 PROPOSE#3 carry-over
- #4 (drift-origin-vs-cascade-target) = v5.13 신규 origin 충분하지 않아 carry-over 종료 (L2 흡수)
- #5 = 본 v5.13 PROPOSE#4 carry-over
- #6 = 본 v5.13 PROPOSE#5 carry-over (v1.18 완료 여부 재확인 필요)
- #7 = 본 v5.13 PROPOSE#6 carry-over

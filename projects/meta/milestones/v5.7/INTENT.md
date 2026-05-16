# INTENT — v5.7 spec-drift-spike-pattern-canonicalization

```json
{
  "id": "v5.7_spec-drift-spike-pattern-canonicalization",
  "title": "spec-drift spike 패턴 정전화 — context7 spec 추정 + Stage F EXECUTE 실 spike + DESIGN.decisions hardcode 3 단계 narrative",
  "goal": "v4.2 + v5.6 두 milestone 안 자연 발현한 spec-drift spike 패턴 (context7 source 추정 → Stage F EXECUTE 안 실 spike → DESIGN.decisions 안 hardcode 정정) 을 ARCHITECTURE.md 또는 harness-meta.md 안 narrative 1건 정전화. 향후 spec-drift 위험 항목 (외부 spec 안 추정 진행 milestone) 의 절차적 가드레일 효과.",
  "motivation": "v4.2_verify-infra-agent-absorption RESEARCH 단계에서 context7 standard pattern 을 '디렉토리+AGENT.md' 추정한 결과가 Stage D DESIGN 5 관점 spec-drift 검토에서 정정 (실 spec = standalone .md 파일). v5.6_environment-auditor-runtime-check-automation RESEARCH 안 settings.json plugin enabled key 도 추정 진행, Stage F EXECUTE D10 spike 안에서 실 검증 후 hardcode. 두 사례 공통 = (1) spec 추정의 위험 + (2) Stage F spike 안 자연 보정 + (3) DESIGN.decisions 에 hardcode 정정. 본 패턴이 자연 발현 누적 2건 — narrative 정전화 시 향후 milestone 안 자연 도구화. v3.21_narrative-canonicalization-3step-pattern (DESIGN 1차 source + EXECUTE Edit + VERIFY grep) 의 3 단계 패턴 정전화 사례 패턴 정확 정합 — 본 milestone 도 같은 정전화 3 단계 적용 (도그푸드).",
  "success_criteria": [
    "sc_1: spec-drift spike 패턴 narrative 1건 정전화 (단일 1차 source, host 1곳 — ARCHITECTURE.md § 6.X 또는 harness-meta.md Stage C/D, 위치는 Stage D DESIGN 결정)",
    "sc_2: 정전화 narrative 안 3 단계 명시 — (a) context7 source 추정 (RESEARCH) → (b) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) → (c) DESIGN.decisions 또는 phase-1.md execution_notes 안 hardcode 정정",
    "sc_3: v4.2 + v5.6 두 origin 사례 정량 cross-ref (정전 narrative 안 1차 source link 또는 milestone id 거명)",
    "sc_4: 도그푸드 — 본 milestone 자체가 정전화 3 단계 패턴 (v3.21) 적용 (DESIGN 정확 문구 1차 source + EXECUTE Edit 그대로 삽입 + VERIFY grep 키워드 검증)",
    "sc_5: VERIFY criteria_check 5건 모두 PASS + pre-commit 14 hook 모두 PASS + 회귀 0",
    "sc_6: § 6.2 폐지 정합 (v4.0 도입) — 본 milestone narrative 안 § 6.2 거론 부재 (workflow self-improvement 본질 미부합 검증)",
    "sc_7: 본 milestone 자체 narrative 안 forward propose 명령형 부재 (Stage B/C/D 부산물 정책 v3.10 정합 grep 검증)"
  ],
  "out_of_scope": [
    "spec-drift 위험 항목 정량 audit (v4.2 + v5.6 두 origin 사례 외 추가 사례 수집은 본 milestone scope 외)",
    "context7 standard pattern 확장 또는 변경 (v4.2 단일 결정 보존)",
    "spike 자동화 도구 (manual reasoning default — 자동화 의무 부재)",
    "5 관점 subagent 검토 scope 변경 (spec-drift agent 는 5 관점 중 1건으로 보존)",
    "ARCHITECTURE.md 또는 harness-meta.md 본문 절차 변경 (narrative 추가만 — Stage C/D 절차 자체는 무변경)"
  ],
  "dependencies": [
    "선행: v4.2_verify-infra-agent-absorption (context7 standard pattern 정정 origin — RESEARCH 추정 → DESIGN spec-drift 정정)",
    "선행: v5.6_environment-auditor-runtime-check-automation (D10 enabled key spike origin — RESEARCH 추정 → Stage F EXECUTE spike 안 hardcode)",
    "선행: v3.21_narrative-canonicalization-3step-pattern (정전화 3 단계 패턴 — 본 milestone 도그푸드 적용)",
    "선행: v3.10_stage-byproduct-clarification (Stage B/C/D 부산물 정책 — sc_7 검증 source)",
    "후행: 향후 spec-drift 위험 항목 milestone (자연 도구화 검증, success_criteria 외 forward 효과)"
  ]
}
```

## narrative

본 milestone 의 핵심 의도는 **자연 발현 패턴의 narrative 정전화** — v4.2 + v5.6 두 milestone 안 spec-drift 추정 → spike 정정 → hardcode 정정 cycle 이 자연 발현되었으며, 이를 ARCHITECTURE.md 또는 harness-meta.md 안 narrative 1건 정전화 시 향후 milestone 안 자연 도구화 가능.

본 milestone 자체가 v3.21 narrative 정전화 3 단계 패턴 (DESIGN 1차 source + EXECUTE Edit + VERIFY grep) 의 9 번째 cycle 적용 사례 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + 본 v5.7) — 자기참조 부합 도그푸드.

phase 분할 / 정확 host 위치 / 정확 narrative 문구 등 implementation detail 은 Stage D DESIGN 단계에서 5 관점 검토 후 결정.

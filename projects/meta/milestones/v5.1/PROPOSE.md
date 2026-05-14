# PROPOSE — v5.1 plugin-component-discovery-fix

```json
{
  "milestone": "v5.1_plugin-component-discovery-fix",
  "next_candidates": [
    {
      "id": "v5.2_agent-audit-path-cleanup",
      "title": "agents/environment-auditor.md + agents/harness-gap-analyzer.md 내부 functional audit path 갱신 — v5.1 Phase 1 agent move 결과 stale path 해소",
      "trigger": "B_regression",
      "trigger_condition": "VERIFY regressions 2건 — agents/environment-auditor.md:74 (bootstrap/skills/{audit,dev-tools}/*/SKILL.md → skills/*/SKILL.md + bootstrap/agents/audit/*.md → agents/*.md) + agents/harness-gap-analyzer.md:59 (bootstrap/agents/{audit,dev-tools}/ → agents/). 사용자 명시 발의 시 즉시 진행 가능 (scope 작음, 1 phase 예상)."
    },
    {
      "id": "v5.2_external-marketplace-registration",
      "title": "외부 marketplace 등록 — claude plugin marketplace add pdw96/harness-meta 표준 명령 추가 (v5.0 PROPOSE#5 carry-over)",
      "trigger": "A_user",
      "trigger_condition": "사용자 명시 발의. GitHub source marketplace 등록 = 오픈소스 방문자 onboarding 개선."
    },
    {
      "id": "v5.x_v4x-deprecation-narrative-cleanup",
      "title": "v4.x SymbolicLink narrative 정리 — ~/.claude/agents/ 5 멤버 broken SymbolicLink cleanup + deprecation 표지 전면 정리 (v5.0 PROPOSE#4 carry-over)",
      "trigger": "A_user",
      "trigger_condition": "사용자 명시 발의 또는 v4.x 환경 사용자 friction 증거 누적."
    },
    {
      "id": "v5.x_spec-drift-verification-pattern-canonicalization",
      "title": "spec-drift 검증 패턴 정전화 — context7 검증 + 실 install/runtime 검증 2 단계 의무 narrative 정전화 (v5.0 PROPOSE#3 carry-over)",
      "trigger": "A_user",
      "trigger_condition": "사용자 명시 발의. v5.0 + v5.1 의 두 번째 적용 cycle 완성 시점 정전화 조건 충족."
    }
  ],
  "propose_summary": "v5.1 주요 후속 candidate 4건. #1 (v5.2_agent-audit-path-cleanup) 은 B_regression origin — VERIFY regressions 2건 직접 후속, scope 작음 (1-phase 예상), 사용자 발의 즉시 진행 가능. #2~#4 는 v5.0 PROPOSE carry-over + A_user trigger 대기."
}
```

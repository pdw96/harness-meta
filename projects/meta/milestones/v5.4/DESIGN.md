# DESIGN — v5.4 marketplace-json-github-source

```json
{
  "decisions": [
    {
      "decision": "marketplace.json source 필드 './' 현행 유지 (GitHub source 객체 전환 기각)",
      "rationale": "context7 spec 명시 — Git repository marketplace(GitHub shorthand 클론 + local path 클론)에서 plugin entry source = relative path('./')가 spec-correct. GitHub source 객체({ 'source': 'github', 'repo': '...' })는 URL-based marketplace 전용. harness-meta는 Git repository marketplace만 지원하므로 전환 불필요, 오적용 시 regression 위험.",
      "alternatives_rejected": [
        "Option B (GitHub source 객체 전환): spec 외 적용 — URL-based marketplace에서만 유효. Git repository marketplace에서 동작 보장 없음. 기각."
      ]
    },
    {
      "decision": "CHANGELOG.md v5.4 entry 추가 + milestone 산출물이 정전 근거",
      "rationale": "코드 변경 없는 spec-verification milestone은 milestone 산출물(RESEARCH/DESIGN) + CHANGELOG entry로 결정 근거를 영구 보존. 향후 동일 의문 재발 시 단일 source.",
      "alternatives_rejected": []
    }
  ],
  "approach": "Lightweight 1-phase: CHANGELOG v5.4 entry 1줄 추가 + ROADMAP v5.4 status completed 갱신. marketplace.json 무변경. 산출물(INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE) commit + CHANGELOG commit = 2 commit.",
  "phases": [
    {
      "n": 1,
      "title": "CHANGELOG v5.4 entry 추가 + ROADMAP completed 갱신",
      "scope": [
        "CHANGELOG.md — [v5.4] entry 추가 (spec 검증 결과: './' 현행 유지)",
        "execute/phase-1.md"
      ],
      "affected_files": [
        "CHANGELOG.md",
        "projects/meta/milestones/v5.4/execute/phase-1.md"
      ],
      "rationale": "코드 변경 없음. CHANGELOG가 결정의 유일한 persistent artifact (milestone 산출물 외부).",
      "risks": []
    }
  ],
  "risk_mitigation": []
}
```

## 5 관점 검토 (scope = 1 파일 → 3 관점)

| # | 관점 | 결과 |
|:-:|------|------|
| 1 | architecture | milestone 산출물 구조 정합. 코드 변경 없으므로 구조 영향 없음. PASS |
| 2 | spec-drift | context7 명시 확인 완료 (Git repo marketplace = relative path correct). PASS |
| 3 | scope contract | INTENT.success_criteria 4건 → 모두 달성 가능 (spec 검증 ✓, 결정 명시 ✓, CHANGELOG ✓, pre-commit PASS 예상 ✓). PASS |

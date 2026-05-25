# DESIGN — v3.7 smoke-posttooluse-9stage-tests

```json
{
  "version": "v3.7",
  "decisions": [
    {
      "decision": "D1: Test T grep 패턴 — '다음: RESEARCH'로 좁힘",
      "rationale": "spec-drift 관점 권고 흡수 — 'RESEARCH' 단독은 OTHER 분기(RESEARCH.md 파일 감지) MSG에도 등장 가능해 false positive 위험. 'RESEARCH.md 작성으로 진행' 전체 구문 vs '다음: RESEARCH' — 두 방식 모두 INTENT MSG에만 등장하나 짧은 '다음: RESEARCH' 로 충분히 specific.",
      "alternatives_rejected": ["grep 'RESEARCH' (too-broad, OTHER branch false positive 위험)"]
    },
    {
      "decision": "D2: fixture path → projects/meta/milestones/v3.7/{파일명} 실제 경로",
      "rationale": "hook regex 'projects/[^/]+/milestones/v[^/]+/' 는 버전 무관. 실제 v3.7 경로 사용이 테스트 의도 명확 + dummy path 관리 불필요. architecture 관점 dummy 권장 의견은 기능 동치이므로 단순성 우선 채택.",
      "alternatives_rejected": ["v1.1_test dummy path (기존 패턴이지만 추가 필요 없음)"]
    },
    {
      "decision": "D3: 헤더 카운트 갱신 — smoke 파일 내 2곳 + tests/CLAUDE.md 수치 1곳",
      "rationale": "architecture FAIL 항목 흡수 — 헤더 L11 'dynamic 19 checks (A~S)' + L48 'Dynamic (19)' → 'Dynamic (22)' + '(A~V)'. tests/CLAUDE.md 도메인 별 회귀 표 '17 test' → '25 checks'.",
      "alternatives_rejected": []
    }
  ],
  "approach": "단일 파일 변경 (tests/_inactive/smoke-posttooluse-hook.sh) — Tests T/U/V 3건 추가 + 헤더 카운트 2곳 갱신. tests/CLAUDE.md narrative 1곳 갱신. 1 phase 1 commit. _inactive 위치 유지 (v3.6 archive 정책 § 6.2).",
  "phases": [
    {
      "n": 1,
      "title": "Tests T/U/V 추가 — INTENT/APPROVE/PROPOSE additionalContext 검증",
      "scope": "Tests T (INTENT→RESEARCH 안내), U (APPROVE→EXECUTE 게이트), V (PROPOSE→next_candidates 안내) 추가. 헤더 카운트 갱신 (Dynamic 19→22, A~S→A~V). tests/CLAUDE.md '17 test' → '25 checks'.",
      "affected_files": [
        "tests/_inactive/smoke-posttooluse-hook.sh",
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.7/execute/phase-1.md"
      ],
      "rationale": "단일 smoke 파일 + narrative 갱신 — 단일 commit으로 완결 가능.",
      "risks": ["헤더 카운트 미갱신 시 comment drift (낮음)"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "Test T false positive (OTHER branch MSG에 RESEARCH 키워드 등장)",
      "mitigation": "D1: '다음: RESEARCH' 패턴으로 좁힘 — INTENT MSG에만 등장"
    },
    {
      "risk": "Tests A~S 회귀",
      "mitigation": "VERIFY stage에서 smoke 직접 실행 1회 (bash tests/_inactive/smoke-posttooluse-hook.sh)"
    }
  ]
}
```

## 3 관점 검토 요약

| 관점 | verdict | 주요 권고 | 흡수 |
|------|---------|----------|------|
| architecture | pass-with-comments | D2 fixture path + D3 헤더 카운트 FAIL | D3 흡수 (헤더 2곳 + CLAUDE.md), D2 단순성 우선 |
| spec-drift | pass-with-comments | D1 Test T grep 패턴 좁히기 | 흡수 (다음: RESEARCH) |
| scope contract | pass-with-comments | phase constraints 명시 | DESIGN.phases[0].scope에 _inactive 위치 유지 명시 |

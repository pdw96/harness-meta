# DESIGN — v3.9 inactive-smoke-git-mv-checklist

```json
{
  "decisions": [
    {
      "decision": "체크리스트 위치: '회귀 검증 절차' 섹션에 독립 subsection (Option B)",
      "rationale": "architecture + scope contract 검토 일치 — 회귀 검증 절차 섹션이 '신규 추가 / 수정 / 이동' 3-케이스 절차 집합으로 완결. 성격 정합 (체크리스트 = 절차, 현행 hook 현황 = 현황 snapshot). 사용자 결정 확정.",
      "alternatives_rejected": [
        "Option A (inactive smoke 경로 규약 바로 아래 인라인) — 현행 hook 현황 섹션에 절차 혼재 → 섹션 경계 훼손, spec-drift 검토 단독 선호"
      ]
    },
    {
      "decision": "경로 깊이 규범은 line 285 cross-ref로 처리, 체크리스트 안 재서술 금지",
      "rationale": "spec-drift 권고 R1 — `$(dirname \"$0\")/../..` 정의는 tests/CLAUDE.md line 285 'inactive smoke 경로 규약 (v3.8)' 단락이 canonical source. 체크리스트가 동일 표현식을 재서술하면 다음 규약 변경 시 stale drift 발생.",
      "alternatives_rejected": [
        "체크리스트 내 경로 표현식 재정의 — 단일 source 위반"
      ]
    },
    {
      "decision": "체크리스트 단계 수: 4단계, 5줄 이내 cap",
      "rationale": "§ 6.2 lightweight 모드 정책. scope contract 권고 5줄 이내 + architecture 초안 5단계 → 중복 단계 통합. HARNESS_META_ROOT/rev-parse 확인 = grep 단계에 인라인 통합.",
      "alternatives_rejected": []
    }
  ],
  "approach": "tests/CLAUDE.md '회귀 검증 절차' 섹션 하단에 '### smoke 파일 이동(git mv) 시 체크리스트' subsection 신규 추가 (1 파일 변경). 체크리스트 4단계 (방향 확인 / grep 검증 / 수동 실행 / pre-commit 확인). 경로 규범은 cross-ref로 처리. 단일 phase 1 commit.",
  "phases": [
    {
      "n": 1,
      "title": "tests/CLAUDE.md — git mv 체크리스트 subsection 추가",
      "scope": "tests/CLAUDE.md '회귀 검증 절차' 섹션 하단에 ### smoke 파일 이동(git mv) 시 체크리스트 subsection 삽입 (4단계, 5줄 cap). milestones/v3.9/execute/phase-1.md 포함.",
      "affected_files": [
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.9/execute/phase-1.md"
      ],
      "rationale": "단일 파일 단일 변경 → phase 분할 불필요",
      "risks": ["smoke-claude-md-drift.sh 헤더 카운트 변화 — 가능성 낮음 (subsection 추가, 상위 헤더 카운트 불변)"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "smoke-claude-md-drift.sh 회귀",
      "mitigation": "commit 전 pre-commit run smoke-claude-md-drift 수동 실행 확인"
    },
    {
      "risk": "markdownlint MD032/MD049 자동 차단",
      "mitigation": "강조 직후 list 빈 줄 1개 의무 + backtick identifier escape 준수"
    }
  ]
}
```

## 3 관점 검토 결과 요약

| 관점 | 결론 | 핵심 권고 흡수 |
|------|------|--------------|
| architecture | pass — Option B 권고 | 성격 정합 + 확장성 확인 |
| spec-drift | pass-with-comments | R1 규범 재서술 금지 + cross-ref 의무 (D2 반영) |
| scope contract | pass — Option B 권고 | 성공 기준 3건 모두 충족 가능, smoke-claude-md-drift 주의 (risk_mitigation 반영) |

충돌 1건 (Option A vs B) → 사용자 결정: **Option B 확정**.

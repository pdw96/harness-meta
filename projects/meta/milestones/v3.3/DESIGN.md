# DESIGN — v3.3 ci-inactive-smoke-cleanup

```json
{
  "id": "v3.3",
  "decisions": [
    {
      "id": "D1",
      "decision": "CI glob → active 6 배열 hardcode (Option A)",
      "rationale": "변경 파일 1건, inactive smoke 보존, 즉시 green. v1.4_infra-minimization 정신 일관.",
      "alternatives_rejected": [
        "Option B (grep 디스커버리): smoke 16건 수정 필요로 scope 과대",
        "Option C (smoke 파일 삭제): INTENT out_of_scope, 사용자 결정 반함"
      ]
    },
    {
      "id": "D2",
      "decision": "CI YAML에 inactive skip 근거 주석 추가",
      "rationale": "architecture 관점 R1 권고 흡수 — 향후 기여자가 'CI에서 왜 실행 안 하나' 의문 방지.",
      "alternatives_rejected": []
    },
    {
      "id": "D3",
      "decision": "phase-1에 명시적 pre-commit run --all-files 검증 포함",
      "rationale": "scope-contract 관점 gap 해소 — criteria 3 (pre-commit 13 hook PASS) assumption 아닌 명시 검증으로 승격.",
      "alternatives_rejected": []
    },
    {
      "id": "D4",
      "decision": "CI YAML 배열 주석에 pre-commit hook 동기화 근거 명시",
      "rationale": "architecture 관점 R2 권고 흡수 — 새 active smoke 추가 시 ci.yml도 갱신해야 함을 주석으로 명시. 파일 컨벤션 강제 대신 주석으로 충분 (scope 최소화).",
      "alternatives_rejected": []
    },
    {
      "id": "D5",
      "decision": "passing inactive 6건 (agentic-safety-na 등)도 CI 제외 — active 정의 기준 적용",
      "rationale": "regression-risk 관점 확인 — CI/pre-commit 완전 격리. passing inactive 6건도 pre-commit 미등록이므로 active 정의 밖. 별도 처리 불필요.",
      "alternatives_rejected": []
    }
  ],
  "approach": "단일 파일(.github/workflows/ci.yml) 수정으로 CI glob을 active 6 smoke 명시 배열로 교체. 주석 2건 추가 (skip 근거 + 동기화 가이드). pre-commit 검증 포함 단일 commit.",
  "phases": [
    {
      "n": 1,
      "title": "ci.yml active smoke 배열 전환 + 검증",
      "scope": "CI glob → active 6 배열 + 주석 2건 추가",
      "affected_files": [
        ".github/workflows/ci.yml",
        "execute/phase-1.md"
      ],
      "rationale": "변경 파일 1건, 검증 포함 단일 commit으로 충분",
      "risks": ["active smoke 추가 시 ci.yml 수동 갱신 필요 — 주석으로 완화 (D4)"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "active smoke 추가 시 CI 갱신 누락",
      "mitigation": "ci.yml 배열 직전 주석에 '새 active smoke 추가 시 .pre-commit-config.yaml 등록과 동시에 이 배열에도 추가' 명시"
    },
    {
      "risk": "pre-commit 회귀 검증 누락",
      "mitigation": "phase-1 commit 전 pre-commit run --all-files 명시 실행 (D3)"
    }
  ]
}
```

## 3 관점 검토 요약

| 관점 | 판정 | 주요 발견 | 흡수 |
|------|------|---------|------|
| architecture | PASS-with-comments | R1: skip 근거 주석 / R2: 배열 동기화 가이드 / R3: 계층 커버리지 (현재 충분) | D2, D4 |
| scope-contract | PASS-with-comments | criteria 3 gap: pre-commit 검증 assumption → 명시 | D3 |
| regression-risk | PASS | CI/pre-commit 완전 격리. passing inactive 6건 CI 제외 risk 없음 | D5 |

# DESIGN — v3.8 inactive-smoke-cd-path-fix

```json
{
  "decisions": [
    {
      "decision": "Option A 채택 — dirname/../.. 직접 치환",
      "rationale": "경로 오류 수정만이 목적 (inactive smoke 기능 로직 무관). 최소 변경으로 명확한 범위.",
      "alternatives_rejected": ["Option B (git rev-parse 일괄 교체) — 변경량 과도 + 환경 의존성 신규 도입, out_of_scope 위배"]
    },
    {
      "decision": "spec-drift 권고 흡수 — tests/CLAUDE.md 에 inactive smoke 경로 정책 1줄 추가",
      "rationale": "spec-drift 검토 결과 `fail` — _inactive/ 경로 정책이 문서 미명시. 같은 phase 에서 1줄 추가로 해소, 추가 비용 없음.",
      "alternatives_rejected": ["별도 milestone 으로 분리 — 단순 1줄 추가를 위해 9-stage overhead 과도"]
    },
    {
      "decision": "단일 phase 1 commit",
      "rationale": "8개 파일 × 1라인 동일 패턴 치환 + 문서 1줄 추가 — 병렬 수정 가능, 원자성 확보.",
      "alternatives_rejected": []
    }
  ],
  "approach": "Edit 도구로 8개 파일 각각 `$(dirname \"$0\")/..` → `$(dirname \"$0\")/../..` 수정 + tests/CLAUDE.md inactive smoke 경로 정책 1줄 추가. bash -n syntax check 개별 검증 후 pre-commit commit.",
  "phases": [
    {
      "n": 1,
      "title": "8개 inactive smoke dirname/.. → ../.. 수정 + tests/CLAUDE.md 정책 추가",
      "scope": "문자열 치환 8개 파일 + tests/CLAUDE.md 1줄",
      "affected_files": [
        "tests/_inactive/smoke-detect-language.sh",
        "tests/_inactive/smoke-roi-regression.sh",
        "tests/_inactive/smoke-backup-cleanup.sh",
        "tests/_inactive/smoke-bootstrap-agents-md.sh",
        "tests/_inactive/smoke-bootstrap-render.sh",
        "tests/_inactive/smoke-skills-install.sh",
        "tests/_inactive/smoke-sync-agents.sh",
        "tests/_inactive/smoke-python-entry-boilerplate.sh",
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.8/execute/phase-1.md"
      ],
      "rationale": "동일 패턴 8건 + 정책 문서 1줄 — 원자적 단일 commit 이 적절",
      "risks": ["syntax error 도입 위험 → bash -n 개별 검증으로 mitigate"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "수정 후 syntax error",
      "mitigation": "bash -n 각 파일 개별 실행 후 commit"
    },
    {
      "risk": "active smoke 회귀",
      "mitigation": "pre-commit 14 hook 자동 실행 — 기존 active smoke 영향 없음 (inactive 파일만 수정)"
    }
  ]
}
```

## 5 관점 검토 요약

| 관점 | 결론 | 권고 흡수 여부 |
|------|------|-----------|
| architecture | pass | 장기 git rev-parse 통일 — 선택 보류 (out_of_scope) |
| spec-drift | fail → **흡수** | tests/CLAUDE.md inactive smoke 경로 정책 1줄 추가 → phase-1 포함 |
| scope-contract | pass | 없음 |

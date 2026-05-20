# roadmap (fixture — violation-missing-field)

candidate_draft schema 검증 violation fixture — `decision_pending` 필드 누락. Stage 1 기존 검증 (7 필드 존재) 안 FAIL expect.

```json
{
  "project": "fixture-violation-missing-field",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "valid-id",
      "title": "valid title example",
      "source": "fixture source narrative",
      "detected_at": "2026-05-20",
      "rationale": "valid rationale within 500 chars limit.",
      "category": "internal_synthesis"
    }
  ]
}
```

본 fixture 호출 시 `validate_candidate_draft()` 가 decision_pending 필드 누락 검출 → FAIL > 0 → expected exit 1 (violation).

# roadmap (fixture — violation-detected_at)

candidate_draft schema 검증 violation fixture — detected_at ISO 8601 형식 (`^\d{4}-\d{2}-\d{2}$`) 외 값. Stage 1 신규 검증 (ii) detected_at ISO 안 FAIL expect.

```json
{
  "project": "fixture-violation-detected_at",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "valid-id",
      "title": "valid title example",
      "source": "fixture source narrative",
      "detected_at": "May 20, 2026",
      "rationale": "valid rationale within 500 chars limit.",
      "category": "internal_synthesis",
      "decision_pending": "valid decision question"
    }
  ]
}
```

본 fixture 호출 시 `validate_candidate_draft()` 가 detected_at ISO 형식 위반 검출 → FAIL > 0 → expected exit 1 (violation).

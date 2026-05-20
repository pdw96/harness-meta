# roadmap (fixture — violation-category)

candidate_draft schema 검증 violation fixture — category enum (`internal_synthesis` | `benchmark_external`) 외 값. Stage 1 기존 검증 (category enum) 안 FAIL expect.

```json
{
  "project": "fixture-violation-category",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "valid-id",
      "title": "valid title example",
      "source": "fixture source narrative",
      "detected_at": "2026-05-20",
      "rationale": "valid rationale within 500 chars limit.",
      "category": "invalid_category_enum",
      "decision_pending": "valid decision question"
    }
  ]
}
```

본 fixture 호출 시 `validate_candidate_draft()` 가 category enum 위반 검출 → FAIL > 0 → expected exit 1 (violation).

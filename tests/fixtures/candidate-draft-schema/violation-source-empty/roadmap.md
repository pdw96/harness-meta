# roadmap (fixture — violation-source-empty)

candidate_draft schema 검증 violation fixture — source 빈 문자열 (strip 후 길이 0). Stage 1 신규 검증 (iv) source non-empty 안 FAIL expect.

```json
{
  "project": "fixture-violation-source-empty",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "valid-id",
      "title": "valid title example",
      "source": "",
      "detected_at": "2026-05-20",
      "rationale": "valid rationale within 500 chars limit.",
      "category": "internal_synthesis",
      "decision_pending": "valid decision question"
    }
  ]
}
```

본 fixture 호출 시 `validate_candidate_draft()` 가 source 빈 문자열 검출 → FAIL > 0 → expected exit 1 (violation).

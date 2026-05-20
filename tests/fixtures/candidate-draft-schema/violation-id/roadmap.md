# roadmap (fixture — violation-id)

candidate_draft schema 검증 violation fixture — id regex `^[a-z0-9-]+$` 위반 (대문자 + underscore 포함). Stage 1 신규 검증 (i) id regex 안 FAIL expect.

```json
{
  "project": "fixture-violation-id",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "INVALID_ID_WITH_CAPS_AND_UNDERSCORES",
      "title": "valid title example",
      "source": "fixture source narrative",
      "detected_at": "2026-05-20",
      "rationale": "valid rationale within 500 chars limit.",
      "category": "internal_synthesis",
      "decision_pending": "valid decision question"
    }
  ]
}
```

본 fixture 호출 시 `validate_candidate_draft()` 가 id regex 위반 검출 → FAIL > 0 → expected exit 1 (violation).

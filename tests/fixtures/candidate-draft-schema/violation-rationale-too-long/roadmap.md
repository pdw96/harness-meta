# roadmap (fixture — violation-rationale-too-long)

candidate_draft schema 검증 violation fixture — rationale length > 500자 (codepoint len). Stage 1 신규 검증 (iii) rationale length ≤ 500자 안 FAIL expect.

```json
{
  "project": "fixture-violation-rationale-too-long",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "valid-id",
      "title": "valid title example",
      "source": "fixture source narrative",
      "detected_at": "2026-05-20",
      "rationale": "This rationale exceeds the 500 character limit imposed by Stage 1 logic. We artificially extend the narrative with repeated phrases for the sole purpose of fixture violation detection. We artificially extend the narrative with repeated phrases for the sole purpose of fixture violation detection. We artificially extend the narrative with repeated phrases for the sole purpose of fixture violation detection. Additional padding text appended to ensure we comfortably cross the 500 char boundary by enough margin.",
      "category": "internal_synthesis",
      "decision_pending": "valid decision question"
    }
  ]
}
```

본 fixture 호출 시 `validate_candidate_draft()` 가 rationale length 초과 검출 → FAIL > 0 → expected exit 1 (violation).

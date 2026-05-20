# roadmap (fixture — normal)

candidate_draft schema 검증 정상 fixture — Stage 1 logic 7 필드 + category enum + 5 신규 검증 (id regex / detected_at ISO / rationale length / source / decision_pending non-empty) 모두 통과 expect.

```json
{
  "project": "fixture-normal",
  "updated": "2026-05-20",
  "candidate_draft": [
    {
      "id": "normal-valid-id",
      "title": "valid title example",
      "source": "fixture source narrative",
      "detected_at": "2026-05-20",
      "rationale": "valid rationale within 500 chars limit. minimal fixture for normal case (Stage 1 logic 모두 통과 expect).",
      "category": "internal_synthesis",
      "decision_pending": "valid decision question"
    }
  ]
}
```

본 fixture 호출 시 `smoke-candidate-draft-schema.sh` Stage 4 `validate_candidate_draft()` 함수 가 FAIL=0 반환 → expected exit 0 (PASS).

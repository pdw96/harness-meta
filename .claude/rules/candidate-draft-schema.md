---
description: ROADMAP candidate_draft[] decision_pending 필드 = string non-empty 본질 (boolean 아님) — smoke-candidate-draft-schema 강제
paths:
  - "projects/*/ROADMAP.md"
---

# candidate_draft[] decision_pending = string non-empty

ROADMAP `candidate_draft[]` entry 안 `decision_pending` 값 = **string 본질** (e.g., `"pending"` / `"approved"` / `"rejected"`). boolean 아님. `tests/smoke-candidate-draft-schema.sh` 의 `isinstance(dp, str) and dp.strip()` 강제 — boolean 또는 빈 문자열 시 FAIL.

v6.22 evidence — /propose-next 평가 도중 `"decision_pending": true` (boolean) 작성 → smoke FAIL=2 "decision_pending 빈 문자열" detect → `"pending"` string 정정 후 PASS.

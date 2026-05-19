# scanner-output (fixture — numeric-normal)

audit chain `project-scanner` 산출 모방 fixture — numeric fact 인용 포함 (수치 method 정의 정전화).

```json
{
  "project": "harness-meta",
  "loc_estimate": 18500,
  "total_milestones": 42,
  "active_smoke_count": 17
}
```

본 fixture 호출 시 `audit_fact_verify.py` 가 numeric pattern (`loc_estimate: 18500`, `total_milestones: 42`, `active_smoke_count: 17`) 검출하지만 `NUMERIC_LOOKUP` empty 초기 (v5.13 정전화 3 method 통합 narrative, evidence cycle 0) → **no-op fallback** → exit 0 PASS.

수치 method evidence 도달 시 `NUMERIC_LOOKUP` 안 lookup 추가 → 본 fixture 가 mismatch case 로 전환 가능 (자연 확장).

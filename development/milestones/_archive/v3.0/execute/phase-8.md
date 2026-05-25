# phase-8 — v2.2_historical-7stage-stage1-decision 흡수 + 결정 (a) 보존

```json
{
  "phase": 8,
  "status": "completed",
  "title": "historical 7-stage migrate milestone 의 Stage 1 검증 — (a) 그대로 보존 결정",
  "scope": [
    "tests/smoke-scope-contract.sh L173-176 (Stage 1 era='7-stage' 분기) narrative 강화 — 결정 (a) 기록",
    "milestones/v3.0/milestones.md sub-milestone-8 entry status: pending → completed + 결정 결과 명시"
  ],
  "rationale": "사용자 결정 (a) — historical migrate (PLAN→INTENT, hotfix 43472b7) milestone 의 out_of_scope 검증은 SKIP 보존. 이유: historical milestone 이 이미 완료 + 승인 받은 상태이므로 추가 검증 이득 부재. (b) Stage 1 INTENT.md fallback / (c) era 세분화 옵션 거부 — 복잡도 누적 vs 검증 이득 trade-off (era 분기 4 → 5 누적, fallback 검증 false positive risk).",
  "decisions_referenced": ["D14 (commit ref + dependencies.absorbed_from)"],
  "absorbed_from": "v2.2_historical-7stage-stage1-decision",
  "user_decision": {
    "option": "a",
    "option_description": "그대로 보존 (Stage 2 만 검증, narrative 명문화)",
    "rejected_options": [
      "(b) Stage 1 INTENT.md fallback 활성화 — 코드 변경, fallback false positive risk",
      "(c) era 세분화 (7-stage / 7-stage-historical) — era 분기 4 → 5 누적, ARCHITECTURE.md § 6.1 표 행 추가, _era_detect.py 갱신"
    ],
    "decided_date": "2026-05-10"
  },
  "verification": {
    "smoke_spec_verification": "PASS (변경 부재)",
    "smoke_scope_contract": "PASS (narrative 강화만, 코드 동작 변경 부재)",
    "no_code_change_in_logic": "true — fp = mdir / 'PLAN.md' 보존, narrative 만 갱신"
  }
}
```

## 작업 내용

1. **tests/smoke-scope-contract.sh L173-176** narrative 강화 — Stage 1 era='7-stage' 분기 주석에 v3.0 phase-8 (a) 결정 기록 + 옵션 (b/c) 거부 이유 명시
2. **milestones/v3.0/milestones.md** sub-milestone-8 entry status pending → completed + 결정 narrative 추가 (사용자 (a) 채택, b/c 거부)

## execution_notes

- 코드 동작 변경 부재 (narrative 만) — fp = `mdir / "PLAN.md"` 보존, era 분기 4건 (4-tier / 7-stage / 9-stage / 9-stage-bundled) 보존
- 결정 trade-off: 옵션 (b/c) 채택 시 검증 이득 최소 (historical milestone 이미 완료/승인) vs 복잡도 누적 (era 분기 5건 또는 fallback 코드)
- 본 결정은 trade-off 명시적 기록 — 향후 historical migrate milestone 검증 의문 재발 시 본 phase 결정 reference

## commit

```
feat(meta): v3.0 phase-8 — v2.2_historical-7stage-stage1-decision 흡수 (결정 (a) 보존)
```

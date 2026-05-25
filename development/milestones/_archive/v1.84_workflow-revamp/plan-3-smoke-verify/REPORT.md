# PLAN-3: smoke-verify — REPORT

**완료일**: 2026-05-06
**상태**: ✅ 완료 (single phase, 단순화)

## 최종 결과

- **변경 파일 1개**: `tests/smoke-scope-contract.sh` (enumerate glob 1행 추가 — `milestones/v[0-9]*_*/PLAN.md`)
- **검증**: milestone PLAN.md (`milestones/v1.84_workflow-revamp/PLAN.md`)이 § 의무 (Scope inheritance / Out of scope / Spec verification / 세션 소속 근거) 모두 보유 → smoke-scope-contract PASS 예상

## 구현 요약

PLAN의 phase 매트릭스가 2 phase에서 1 phase로 **단순화**:

- **Phase 1 (실행)**: smoke-scope-contract enumerate glob 1행 추가
- **Phase 2 (verify Stage K) 폐기**: 옵션이었으며, milestone tree sanity는 smoke-scope-contract가 흡수

추가 smoke 갱신 0:

- `smoke-cross-ref.sh`: `rglob('*.md')`가 milestones/ 자동 enumerate. plan-1 commit 시 본 milestone PLAN의 broken ref 모두 self-fix됨 (실 적용 결과 검증)
- `smoke-spec-verification.sh`: enumerate glob이 sessions/meta/만 포함. milestone PLAN은 검증 외 (후속 evidence 시 `smoke-spec-verification-milestone-glob`)
- `smoke-claude-md-drift.sh`: 5 module hardcoded. 영향 0

## 판정

| 성공 기준 | 결과 |
|---------|:----:|
| smoke-scope-contract milestone glob 추가 | ✅ |
| milestone PLAN § 의무 검증 흡수 | ✅ (자동) |
| smoke 회귀 0 | ⏳ Stage E 회귀 검증 시 확인 |

## Lessons Learned

- **L1 — smoke-cross-ref 자동 enumerate**: `rglob('*.md')` 패턴이 milestones/ 자동 포함 — 별도 glob 추가 불필요. 파일 추가는 자동 검증됨
- **L2 — smoke-spec-verification 확장은 후속**: sed regex가 `sessions/meta/v[0-9]+\.([0-9]+)`로 hard-coded. milestone path 매칭은 큰 변경 → 후속 evidence-driven `smoke-spec-verification-milestone-glob`
- **L3 — verify Stage K 옵션 처리**: `verify.{ps1,sh}` milestone Stage 추가는 옵션이었으며 단순화로 폐기. milestone tree sanity는 smoke-scope-contract가 흡수

## 후속 (이 plan 외)

- §3-B: `smoke-spec-verification-milestone-glob` (sed regex 확장 evidence 3+ 시)
- §3-B: `smoke-cross-ref-false-positive-fix` (plan-1 발견 5건 root cause, evidence 누적)
- §3-B: `verify-milestone-stage-k` (Stage K 신설 evidence 시)

## 관련

- 본 PLAN: [PLAN.md](PLAN.md)
- milestone PLAN: [../PLAN.md](../PLAN.md)
- smoke 갱신: [../../../tests/smoke-scope-contract.sh](../../../tests/smoke-scope-contract.sh)

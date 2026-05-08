# PLAN-3: smoke-verify — smoke milestone glob + verify checks

milestone PLAN ([../PLAN.md](../PLAN.md))의 세 번째 PLAN. v1.84 milestone 트리 인식 인프라.

## 목표

- smoke 4종에 milestone glob `milestones/v[0-9]*_*/` 추가 — Stage enumerate 정합
- `verify.{ps1,sh}` milestone Stage 추가 — 4-tier 구조 sanity check (옵션)
- plan-1 발견 false positive (smoke-cross-ref 5건) root cause 조사 (가능 시 fix)

## Phase 매트릭스 (단순화 — single phase)

| Phase | 변경 파일 | Commit |
|:-:|---------|--------|
| 1 | `tests/smoke-scope-contract.sh` (enumerate glob에 `milestones/v[0-9]*_*/PLAN.md` 1행 추가) — milestone PLAN의 § 의무 검증 흡수 | `test(meta): v1.84 plan-3 — smoke-scope-contract milestone glob` |

**Phase 2 (verify Stage K) 폐기** — 옵션이었고, 시간 절약 위해 skip. milestone tree sanity는 smoke-scope-contract가 흡수.

**smoke-cross-ref / smoke-spec-verification / smoke-claude-md-drift 변경 0**:

- `smoke-cross-ref.sh`: `rglob('*.md')` 자동으로 milestones/ 포함 — 추가 변경 0
- `smoke-spec-verification.sh`: enumerate glob 확장은 후속 (`smoke-spec-verification-milestone-glob`, evidence 시)
- `smoke-claude-md-drift.sh`: 5 모듈 hardcoded — 영향 0

## 변경 파일 (~6개)

| 파일 | Phase | 갱신 |
|------|:-:|------|
| `tests/smoke-cross-ref.sh` | 1 | enumerate find pattern에 `milestones/v[0-9]*_*/` 추가 |
| `tests/smoke-scope-contract.sh` | 1 | enumerate glob에 `milestones/v[0-9]*_*/PLAN.md` + `plan-*/PLAN.md` |
| `tests/smoke-spec-verification.sh` | 1 | PLAN/REPORT glob에 milestone tree 포함 |
| `tests/smoke-claude-md-drift.sh` | 1 | 영향 0 (module CLAUDE.md만 검사) |
| `verify.ps1` / `verify.sh` | 2 | Stage K (옵션) — milestone tree sanity (개수 / PLAN.md 존재 / regex) |

## 성공 기준

- [ ] smoke 4종 milestone glob 적용 후 회귀 0 (`milestones/v1.84_workflow-revamp/` enumerate)
- [ ] smoke-scope-contract milestone PLAN의 § 의무 검증 작동
- [ ] smoke-spec-verification milestone PLAN/REPORT § 검증 작동
- [ ] verify Stage K 추가 시 회귀 0 (옵션)
- [ ] (가능 시) cross-ref false positive 5건 root cause 식별

## 의존성

- 선행: plan-1-infra (S1d regex 정의, ADR-006), plan-2-roadmap-redesign (ROADMAP 정합)
- 후행: plan-4-dogfood (smoke 회귀 0 확인 후 dogfood 평가)

## 위험

- smoke-spec-verification이 milestone PLAN의 § 형식을 검증하면, 본 milestone PLAN.md(이미 commit됨)가 회귀 fail 가능 — § 5종 모두 작성됐으므로 PASS 예상
- verify Stage K는 옵션 — 시간 부족 시 phase-2 skip

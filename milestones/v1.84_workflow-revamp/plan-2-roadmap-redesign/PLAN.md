# PLAN-2: roadmap-redesign — ROADMAP §8/§9 milestone-summary 축소

milestone PLAN ([../PLAN.md](../PLAN.md))의 두 번째 PLAN. ROADMAP 비대화 차단 정책 도입.

## 목표

- `sessions/meta/ROADMAP.md` §8 "최근 완료" 정책 갱신 — v1.84+ milestone-summary 1 row만 stamp (phase 상세는 milestone REPORT.md 위임)
- §3-A에 후속 entry `project-workflow-extension` 등록
- §3-B에 후속 entry `smoke-cross-ref-false-positive-fix` 등록 (plan-1에서 발견)
- §1 audit 일자 갱신

## Phase 매트릭스 (single phase)

| Phase | 변경 파일 | Commit |
|:-:|---------|--------|
| 1 | `sessions/meta/ROADMAP.md` (§1 audit + §3-A + §3-B + §8 milestone-summary 정책 + v1.84 entry) | `refactor(meta): v1.84 plan-2 — ROADMAP §8 milestone-summary 정책 + v1.84 entry` |

## 변경 파일 (1개)

| 파일 | 갱신 |
|------|------|
| `sessions/meta/ROADMAP.md` | §1 audit 일자 / §3-A `project-workflow-extension` 행 추가 / §3-B `smoke-cross-ref-false-positive-fix` 행 추가 / §8 milestone-summary 정책 + v1.84 row |

## 성공 기준

- [ ] §1 audit 일자 v1.84 milestone 기준
- [ ] §3-A 17건 (16+1)
- [ ] §3-B에 false positive fix entry 추가
- [ ] §8 v1.84 milestone-summary row + 정책 1줄
- [ ] §9 legacy stamp 보존 (v1.0~v1.82 forward-only)

## 후속 (이 plan 외)

- §3-A `project-workflow-extension` 등록 (evidence-driven)
- ROADMAP §9 폐기는 후속 (사용자 확인 필요 — 지금은 보존)

## 의존성

- 선행: plan-1-infra (5-Stage + S1d + ADR-006 정의)
- 후행: plan-3-smoke-verify (smoke milestone glob 정의 시 본 정책 정합 확인)

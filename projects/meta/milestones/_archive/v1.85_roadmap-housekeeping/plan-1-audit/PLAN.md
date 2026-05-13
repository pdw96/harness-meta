# plan-1-audit — PLAN

## 목표

- [ ] §3-B `smoke-cross-ref-false-positive-fix` row 추가 (v1.84 §8 등록 누락)
- [ ] §3-B count 라벨 `(11건)` → `(12건)`
- [ ] §1 audit 일자 → `2026-05-06 (v1.85_roadmap-housekeeping milestone 기준)`

## Phase 매트릭스

| Phase | 변경 파일 | Commit 메시지 |
|-------|---------|------------|
| 1 | `sessions/meta/ROADMAP.md` | `docs(meta): v1.85 plan-1 phase-1 — ROADMAP §3-B 누락 항목 추가 + audit 일자 갱신` |

## 변경 파일

- `sessions/meta/ROADMAP.md` (1 파일)

## 성공 기준

- smoke-roadmap-sync PASS=31 (회귀 0)
- smoke-scope-contract PASS (회귀 0)
- smoke-spec-verification PASS (회귀 0)
- smoke-cross-ref PASS (회귀 0)

## 의존성

- 선행: milestone PLAN.md 확정
- 후행: milestone REPORT.md

# M2-drift-detection-infra — Phase ROADMAP

**Milestone**: M2
**Slug**: drift-detection-infra
**Status**: ✅ Complete (retro classify in v1.83)

## Phases

| # | Phase | Slug | 상태 | 세션 | 종료 일자 |
|:-:|-------|------|:----:|------|---------|
| 1 | claude-md-drift-smoke | `v1.79-claude-md-drift-smoke` | ✅ 완료 | [`../../sessions/meta/v1.79-claude-md-drift-smoke/`](../../sessions/meta/v1.79-claude-md-drift-smoke/) | 2026-05-05 |
| 2 | claude-md-drift-precommit | `v1.79b-claude-md-drift-precommit` | ✅ 완료 | [`../../sessions/meta/v1.79b-claude-md-drift-precommit/`](../../sessions/meta/v1.79b-claude-md-drift-precommit/) | 2026-05-05 |
| 3 | precommit-hook-entry-policy | `v1.80-precommit-hook-entry-policy` | ✅ 완료 | [`../../sessions/meta/v1.80-precommit-hook-entry-policy/`](../../sessions/meta/v1.80-precommit-hook-entry-policy/) | 2026-05-05 |
| 4 | roadmap-housekeeping | `v1.81-roadmap-housekeeping` | ✅ 완료 | [`../../sessions/meta/v1.81-roadmap-housekeeping/`](../../sessions/meta/v1.81-roadmap-housekeeping/) | 2026-05-06 |
| 5 | agents-md-drift-fix | `v1.82-agents-md-drift-fix` | ✅ 완료 | [`../../sessions/meta/v1.82-agents-md-drift-fix/`](../../sessions/meta/v1.82-agents-md-drift-fix/) | 2026-05-06 |

## 다음 Phase 후보 (active)

(없음 — 본 milestone 완료. drift evidence 재발 시 후속 milestone)

## Out of scope (trigger 대기)

| Phase 후보 | Trigger 조건 | 분리 milestone |
|----------|------------|--------------|
| `v1.83-agents-md-drift-smoke` | AGENTS.md ↔ root CLAUDE.md / README.md / ROADMAP §8 자동 drift 감지 smoke 신설. drift evidence 3+ 시 진입 valid (현재 1) | M-future |
| `v1.82b-sync-agents-execution` | 사용자 7 adapter 동기화 (`sync-agents.{ps1,sh}`) 필요 시 | 사용자 수동 (milestone 외) |

## Schedule 후보

(없음)

## 갱신 정책

- 본 milestone은 v1.83에서 retro classify되어 ✅ 종료 상태
- 추가 phase 발생 시 본 milestone 재오픈 가능 (drift detection 주제 확장)
- 후행 evidence-driven phase는 별도 milestone 신설 권장

## 관련

- Milestone PLAN: [`PLAN.md`](PLAN.md)
- REPORT: [`REPORT.md`](REPORT.md)
- 메타 ROADMAP §8: [`../../sessions/meta/ROADMAP.md`](../../sessions/meta/ROADMAP.md)
- ADR-006: [`../../docs/adr/ADR-006-milestone-phase-2tier.md`](../../docs/adr/ADR-006-milestone-phase-2tier.md)

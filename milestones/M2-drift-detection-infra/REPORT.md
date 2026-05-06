# M2-drift-detection-infra — Milestone REPORT (retro)

**Status**: ✅ Complete (retro classify in v1.83-milestone-phase-infra)
**Period**: 2026-05-05 ~ 2026-05-06 (5 phase, 2 days)

## 최종 결과

- **신규 파일**: smoke-claude-md-drift.sh + tests/CLAUDE.md §"Pre-commit hook entry 정책"
- **갱신 파일**: AGENTS.md (D1~D6) / ROADMAP.md / .pre-commit-config.yaml / tests/CLAUDE.md / CLAUDE.md
- **smoke 회귀 0**: claude-md-drift PASS 16/16 + spec-verification + scope-contract + cross-ref
- **Phase 5건 모두 완료**

## 각 Phase 요약

| # | Phase | 산출 | 학습 |
|:-:|-------|------|------|
| 1 | v1.79-claude-md-drift-smoke | `tests/smoke-claude-md-drift.sh` 신설 (4 Stage 16/16) — 모듈 존재 / back-ref / 중복 블록 / count 정합 | spec § 볼드 형식 필수 / 구조적 행 60% 필터로 false positive 0 / skills 계층 설계 / 단일 원자적 커밋 필수 |
| 2 | v1.79b-claude-md-drift-precommit | `.pre-commit-config.yaml`에 `smoke-claude-md-drift` hook entry 추가 (direct entry, wrapper 미경유) | wrapper vs 직접 호출 기준 (--fix 지원 여부)이 필요함을 인식 |
| 3 | v1.80-precommit-hook-entry-policy | `tests/CLAUDE.md` §"Pre-commit hook entry 정책" 신규 섹션 — wrapper vs direct 기준 명문화 + 4 hook 현황표 | trivial scope 패턴 답습 (1 파일 + docs-only + 5 관점 skip) |
| 4 | v1.81-roadmap-housekeeping | ROADMAP §3-E count 라벨 정합 + audit 일자 갱신 | count 라벨 drift v1.76 1건 후 1차 재발 / audit 일자 stale 1일 cadence 정책 묵시 합의 |
| 5 | v1.82-agents-md-drift-fix | AGENTS.md 6건 stale drift 정정 (D1~D6) + ROADMAP §8 cross-ref redirect 정책 | latest pointer redirect 정책 (수동 갱신 부담 0) / brace-expansion 표기 / drift=N/A 부분 N/A 함정 1차 재학습 / smoke-claude-md-drift 미감지 영역 (AGENTS.md) |

## Lessons Learned (milestone-level)

### L1 — drift detection은 점진 확장 가능

v1.79 smoke 인프라 → v1.79b precommit hook → v1.80 정책 → v1.81/v1.82 cleanup의 자연 흐름. smoke 인프라 1회 작성 후 hook + 정책 + audit cleanup이 incremental 추가됨.

### L2 — Pre-commit wrapper vs direct entry 기준 명문화 필요성

v1.79b에서 wrapper 미경유 결정 시 기준 부재 → v1.80에서 정책 명문화. 결정 → 정책 → 문서화 패턴 확립.

### L3 — AGENTS.md drift는 smoke-claude-md-drift 감지 영역 외

v1.82에서 AGENTS.md 6건 stale 발견 → smoke-claude-md-drift는 모듈 CLAUDE.md만 검사. AGENTS.md ↔ root CLAUDE.md drift는 별도 smoke 필요 (`v1.83-agents-md-drift-smoke` 후속 trigger 등록).

### L4 — Trivial scope 5 관점 검토 skip 패턴

v1.80/v1.81/v1.82 모두 trivial scope (1~6 파일 docs-only)으로 5 관점 검토 skip + Plan-verify drift=N/A 패턴 확립. ROI 효율적.

### L5 — Latest pointer redirect 정책

v1.82에서 AGENTS.md L58 latest meta session 수동 갱신 부담 회피 위해 ROADMAP §8 cross-ref redirect 정책 채택. 향후 stale 회귀 0.

## 다음 milestone 후보

| 후속 milestone | Trigger 조건 | 비고 |
|--------------|------------|-----|
| `v1.83-agents-md-drift-smoke` | drift evidence 3+ 시 (현재 1) | smoke-claude-md-drift 확장 또는 신설 |
| `v1.82b-sync-agents-execution` | 사용자 7 adapter 동기화 필요 시 | 사용자 수동 trigger (milestone 외) |
| `M3+ retro batches` | v1.83 인프라 안정화 후 | 22 cluster 후보 점진 retro |

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — retro classify된 historical record. 5 phase 각각의 spec verification은 phase REPORT에 기록 |
| **re-verify** | N/A |

## 관련

- Milestone PLAN: [`PLAN.md`](PLAN.md)
- ROADMAP: [`ROADMAP.md`](ROADMAP.md)
- 메타 ROADMAP §8: [`../../sessions/meta/ROADMAP.md`](../../sessions/meta/ROADMAP.md)
- 도입 milestone (v1.83): [`../M1-milestone-phase-infra/`](../M1-milestone-phase-infra/)

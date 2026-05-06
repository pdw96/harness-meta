# Milestone M2 — Drift Detection Infrastructure (retro)

**Status**: ✅ Complete (retro classify, v1.83에서 작성)
**Period**: 2026-05-05 ~ 2026-05-06
**Owner**: meta
**ID**: M2
**Slug**: drift-detection-infra

## 세션 소속 근거 (self-apply)

**소속**: `milestones/` (meta-only scope)

**근거**:

- 변경 파일: 5 phase의 다양한 파일 (smoke 신설 + pre-commit hook + 정책 docs + drift fix)
- T1 다수결 — 5 phase 모두 meta scope (S1a/S2/S3) → meta milestone
- 본 milestone은 v1.83에서 retro classify된 첫 사례 (M2 = creation-order 두 번째)

## Scope inheritance (verbatim from v1.83 retro classification)

**Source — v1.83-milestone-phase-infra Explore agent 분석 결과** (verbatim):

> "v1.78~v1.82 (drift), v1.43~v1.55 (scorer-na), v1.60~v1.65 (smoke fix) 정도만 retro M 할당. ~3 milestones."
>
> 22 cluster 후보 식별 결과 cluster 후보 #20 "nested-claude-md / drift" — v1.79 claude-md-drift-smoke + v1.79b precommit + v1.80 entry-policy + v1.81 housekeeping + v1.82 agents-md-drift = 5 phase로 의미 연속.

**Parsed sub-items (5)**:

1. **v1.79** — claude-md-drift-smoke 신설 (4 Stage 16/16 PASS)
2. **v1.79b** — claude-md-drift-precommit hook 등록 (direct entry, wrapper 미경유)
3. **v1.80** — precommit-hook-entry-policy 명문화 (wrapper vs direct 정책)
4. **v1.81** — roadmap-housekeeping (count 라벨 + audit 일자 정합)
5. **v1.82** — agents-md-drift-fix (AGENTS.md 6건 stale 정정)

## Out of scope (explicit rejection)

| ❌ Item | 분리 |
|--------|-----|
| v1.83-agents-md-drift-smoke (AGENTS.md 자동 drift 감지) | 후속 milestone (`v1.83b-agents-md-drift-smoke`, drift evidence 3+ 시) |
| sync-agents.{ps1,sh} 자동 실행 | 사용자 수동 (v1.82b § §3-A trigger) |
| 다른 cluster (scorer-na / smoke-autofix 등) retro classify | 후속 milestone (M3+) |

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 milestone은 v1.83에서 retro classify된 historical record. 5 phase 각각의 spec verification은 이미 phase REPORT에 기록 |
| **re-verify** | N/A |

**Citations**: 없음.

## Milestone 범위

본 M2는 **5 phase의 retro classify** — v1.79~v1.82가 의미상 1 milestone (drift detection / precommit hook / cleanup)이지만 v1.83 milestone 인프라 도입 직전이라 flat 구조. v1.83에서 "전체 retro classify" 정책에 따라 첫 retro 사례로 wrap.

### 주제 흐름

```
v1.79 (drift smoke 신설) → v1.79b (precommit hook 등록) → v1.80 (정책 명문화)
                                                          ↓
                                                     v1.81 (audit cleanup)
                                                          ↓
                                                     v1.82 (AGENTS.md 정정)
```

## Phase 의존성

```
v1.79 ── v1.79b ── v1.80 ── v1.81 ── v1.82
  (smoke)   (hook)   (policy)  (audit)  (drift fix)
```

각 phase는 직선적 후행 — v1.79 smoke 인프라 → v1.79b가 hook으로 활용 → v1.80이 정책으로 명문화 → v1.81이 cleanup → v1.82가 인접 영역 (AGENTS.md) drift 처리.

## 성공 기준 (milestone-level)

- [x] 5 phase 모두 완료 (v1.79~v1.82)
- [x] smoke-claude-md-drift.sh 회귀 0 (16/16 PASS)
- [x] pre-commit hook entry 정책 명문화 (`tests/CLAUDE.md` §"Pre-commit hook entry 정책")
- [x] AGENTS.md drift 0 (v1.82 6건 정정 후)
- [x] retro classify (v1.83에서 본 milestone wrap)

## 관련

- ROADMAP: [`ROADMAP.md`](ROADMAP.md)
- REPORT: [`REPORT.md`](REPORT.md)
- 선행 분석: [`../../sessions/meta/v1.83-milestone-phase-infra/PLAN.md`](../../sessions/meta/v1.83-milestone-phase-infra/PLAN.md)
- ADR: [`../../docs/adr/ADR-006-milestone-phase-2tier.md`](../../docs/adr/ADR-006-milestone-phase-2tier.md)
- Phase 1: [`../../sessions/meta/v1.79-claude-md-drift-smoke/`](../../sessions/meta/v1.79-claude-md-drift-smoke/)
- Phase 5: [`../../sessions/meta/v1.82-agents-md-drift-fix/`](../../sessions/meta/v1.82-agents-md-drift-fix/)

# Milestone M1 — milestone-phase 2-tier 인프라 도입

**Status**: 🚧 In progress
**Created**: 2026-05-06
**Owner**: meta
**ID**: M1
**Slug**: milestone-phase-infra

## 세션 소속 근거 (self-apply)

**소속**: `milestones/` (meta-only scope, v1.83+)

**근거**:

- 변경 파일: milestones/ 인프라 + S2 (OWNERSHIP / SPEC_VERIFICATION / 2 SKILL) + S3 (ADR / README / root CLAUDE.md) + S1a (harness-meta.md slash command) + 모듈 CLAUDE.md 2건 + smoke 4건
- T1 다수결 — 16+ 파일 모두 meta scope (S1a/S1b/S1c/S2/S3) → meta milestone
- T2 — milestone-phase 2-tier는 **구조적 정책 신설** (스펙 source). retro phase wrap은 T4 분할 (후속 milestone에서)

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (2026-05-06)** (verbatim):

> "지금 워크플로우 자체를 개선하고 싶은데, 그전에 논의 좀 하자. 하나의 큰 milestone에서 roadmap 구성하고, 그에 따른 phase들을 만들어서 진행하는 방식으로 하고 싶어."

**Parsed sub-items (8)** — 동일 내용 [`../../sessions/meta/v1.83-milestone-phase-infra/PLAN.md`](../../sessions/meta/v1.83-milestone-phase-infra/PLAN.md) 참조 (A1~A8).

## Out of scope (explicit rejection)

| ❌ Item | 분리 milestone |
|--------|--------------|
| 명백 cluster 21건 retro (M3~M22) | M3+ 후속 (`v1.84-milestone-retro-batch1`) |
| 단발 15~18건 retro wrap | M4+ 후속 (`v1.85-milestone-retro-batch2`) |
| Project ROADMAP milestone 적용 | evidence-driven 후속 milestone |
| 3순위 9 docs (도메인/모듈 CLAUDE.md/AGENTS.md) 갱신 | drift evidence 시 후속 |

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 repo 내부 정책 신설, 외부 spec 의존 0 |
| **re-verify** | N/A |

**Citations**: 없음.

## Milestone 범위

본 milestone M1은 **인프라 도입 + dogfood + M2 retro 1건**으로 구성된 단일 phase milestone (시작 시점). 후속 evidence-driven으로 phase 추가 가능.

### 동기 (4 axis)

1. 관련 세션 흐트림 (v1.78~v1.82 5세션 분산)
2. 큰 작업 분할 부담 (PLAN 1개 8단계 비대)
3. ROADMAP grouping 부재 (§3 trigger 묶임 없음)
4. 의존성 표현 부재 (선행/후행 텍스트 only)

### Milestone 단위 정책 (확정)

- **규모**: 주제별 (e.g., "drift detection infra" ≈ 4~5 phase)
- **ID**: 순차 M1, M2, ... (creation-order)
- **Layout**: PLAN + ROADMAP + REPORT 3 파일
- **Lifecycle**: Incremental (선언 → phase 진행 → REPORT 마지막)
- **Linkage**: 양방향 (frontmatter + cross-ref)
- **Scope**: Meta만 (project는 evidence-driven 후속)

## Phase 의존성

```
M1 phase 1 (v1.83-milestone-phase-infra) — 단일 phase
  └─ 후행 milestone (선택적):
      └─ M3+ retro batches (point release 형식, evidence-driven)
```

본 milestone은 **단일 phase**이므로 의존성 그래프 단순. 후행 milestone (M3+)이 본 M1 인프라에 의존.

## 성공 기준 (milestone-level)

- [ ] M1 phase 1 (v1.83) 완료 + REPORT.md
- [ ] dogfood 검증 — 본 milestone 자기 자신 인프라 정상 작동
- [ ] M2 retro 사례 작성 (별도 milestone)
- [ ] smoke 5종 회귀 0
- [ ] 후속 M3+ retro 가능 인프라 갖춤

## Milestone REPORT (placeholder)

마지막 phase 종료 시 작성. 의무 §:

- 최종 결과 (전체 phase 합산)
- 각 phase 요약 (표)
- Lessons Learned (milestone-level)
- 다음 milestone 후보

## 관련

- ROADMAP: [`ROADMAP.md`](ROADMAP.md)
- 선행 분석: 없음 (첫 milestone)
- ADR: [`../../docs/adr/ADR-006-milestone-phase-2tier.md`](../../docs/adr/ADR-006-milestone-phase-2tier.md)
- Phase 1: [`../../sessions/meta/v1.83-milestone-phase-infra/PLAN.md`](../../sessions/meta/v1.83-milestone-phase-infra/PLAN.md)

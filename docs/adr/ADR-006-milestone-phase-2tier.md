# ADR-006: milestone-phase 2-tier 구조 도입

- **상태**: Accepted
- **날짜**: 2026-05-06
- **세션**: [sessions/meta/v1.83-milestone-phase-infra/](../../sessions/meta/v1.83-milestone-phase-infra/)
- **Milestone**: [milestones/M1-milestone-phase-infra/](../../milestones/M1-milestone-phase-infra/)

## 결정

`harness-meta`의 세션 기록 구조에 **milestone 상위 계층**을 신설한다. 기존 `sessions/meta/vX.Y-{name}/` flat 구조는 phase 등가로 유지하되, 주제별 cluster를 `milestones/M{N}-{slug}/`로 wrap한다.

- **Milestone**: 주제별 단위 (e.g., "drift detection infra"). 1+ phase 포함
- **Phase**: 기존 세션 단위. `sessions/meta/vX.Y-{name}/PLAN.md + REPORT.md`
- **양방향 linkage**: phase PLAN.md frontmatter (`milestone: M{N}-{slug}`) + milestone ROADMAP.md §"Phases" 표 cross-ref
- **단발 wrap**: 1-phase milestone도 wrap (일관성)
- **M-번호**: 창설 순서 (`^M[1-9][0-9]*$`), 본 ADR 시점 M1 = milestone-phase-infra

## 배경

`v1.83` 도입 직전 상태:

- **flat 구조 한계 4건** (v1.78~v1.82 누적 evidence):
  - 관련 세션 흐트림 — v1.78~v1.82 5세션이 의미상 1 milestone (drift detection / precommit / cleanup)이지만 top-level 번호로 분산. "b" suffix(v1.78b)는 같은 번호 안에서만 작동
  - 큰 작업 분할 부담 — PLAN 1개로 8단계 진행 시 scope 비대. 자연스럽게 split해도 후속 세션 간 logical grouping 부재
  - ROADMAP grouping 부재 — `sessions/meta/ROADMAP.md` §3 trigger 대기 항목이 milestone별 묶임 없음
  - 의존성 표현 부재 — phase 간 선행/후행 관계가 REPORT 본문 텍스트 only
- **22 cluster 후보** retro 분류 가능 (v1.83 Explore agent 분석 결과)
- **사용자 결정 11회** (AskUserQuestion) — 동기 4 모두 + 주제별 규모 + 순차 M-번호 + 1-phase wrap + retro classify + Incremental lifecycle + Meta-only scope + 3 파일 layout + 점진 마이그레이션 + 양방향 linkage

## 결과

### 구조

```
milestones/M{N}-{slug}/
├── PLAN.md          # milestone 범위 선언 (incremental)
├── ROADMAP.md       # phase enumerate + 진척
└── REPORT.md        # 마지막 phase 종료 시 종합

sessions/meta/vX.Y-{name}/   # phase 등가 (기존 유지)
├── PLAN.md          # frontmatter `milestone: M{N}-{slug}`
└── REPORT.md
```

### Phase PLAN.md frontmatter

```yaml
---
milestone: M1-milestone-phase-infra
milestone-id: M1
phase: 1
---
```

- 자체 정의 frontmatter (Claude Code 표준 frontmatter 필드 무관)
- legacy phase (v1.0~v1.82)는 frontmatter 부재 허용 (smoke 회귀 0)
- v1.83+ 신규 phase는 frontmatter 의무

### Milestone ROADMAP §"Phases" 표

```markdown
| # | Phase | Slug | 상태 | 세션 | 종료 일자 |
|:-:|-------|------|:----:|------|---------|
| 1 | infra-introduce | v1.83-milestone-phase-infra | 🚧 진행 | path | (TBD) |
```

### Lifecycle (Incremental)

- 첫 phase 시작 전 milestone PLAN.md 선언 (전체 phase 사전 enumerate 불필요)
- phase 진행하면서 milestone ROADMAP.md §"Phases" 표 추가
- evidence-driven으로 phase 추가 또는 종료
- 마지막 phase 종료 시 milestone REPORT.md 작성 (선택, evidence-driven)

### 적용 범위

- ✅ **Meta scope** (`sessions/meta/` + `milestones/`)
- ❌ **Project scope** (`sessions/<project>/` + `projects/<name>/ROADMAP.md`) — evidence 발생 시 후속 milestone 도입 (`project-milestone-extension`)

### 마이그레이션 (점진)

- v1.83 = 인프라 + dogfood (M1) + retro 사례 1건 (M2-drift-detection-infra)
- v1.84+ = 22 cluster retro 점진 (명백 cluster 5~7건 / 단발 15~18건 wrap / 검증)

### Smoke 영향

- **smoke-cross-ref.sh** L77 `_VER_SESS` regex 확장 (`milestones/M\d+/` 추가)
- **smoke-spec-verification.sh** L217/L261/L418 glob 확장 (milestone PLAN/REPORT 포함)
- **smoke-scope-contract.sh** L198~L204 enumerate glob 확장
- **smoke-roadmap-sync.sh** L161 META_SESSIONS glob (조건부 — 본 ADR 시점은 sessions/meta/ROADMAP.md §8 형식 변경 없음)
- **smoke-claude-md-drift.sh** 영향 없음 (모듈 5건 무관)

### M-번호 정책

- 창설 순서 (creation-order, NOT history-order)
- M1 = 본 ADR (forward declaration)
- M2 = 첫 retro batch (drift-detection-infra v1.78~v1.82)
- M0 금지, padding 없음 (regex `^M[1-9][0-9]*$`)

## 트레이드오프

| 장점 | 단점 |
|------|------|
| 관련 세션 grouping (4 동기 axis 모두 해소) | 1-phase milestone wrap → 인프라 부담 (3 파일 추가) |
| 양방향 linkage → drift 검증 가능 | 마이그레이션 비용 (22 cluster retro classify) |
| Incremental lifecycle → 사전 계획 부담 0 | smoke 4건 갱신 필요 |
| Meta-only scope → 단순화 | project ROADMAP과 비대칭 (의도적, evidence-driven 후속 가능) |

## 관련 문서

- Scope 규약: [`bootstrap/docs/OWNERSHIP.md`](../../bootstrap/docs/OWNERSHIP.md)
- PLAN/REPORT 규약: [`sessions/CLAUDE.md`](../../sessions/CLAUDE.md)
- Spec verification §: [`bootstrap/docs/SPEC_VERIFICATION.md`](../../bootstrap/docs/SPEC_VERIFICATION.md)
- 8단계 흐름: [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- 도입 세션: [`sessions/meta/v1.83-milestone-phase-infra/`](../../sessions/meta/v1.83-milestone-phase-infra/)
- 첫 milestone (dogfood): [`milestones/M1-milestone-phase-infra/`](../../milestones/M1-milestone-phase-infra/)
- Retro 사례: [`milestones/M2-drift-detection-infra/`](../../milestones/M2-drift-detection-infra/)

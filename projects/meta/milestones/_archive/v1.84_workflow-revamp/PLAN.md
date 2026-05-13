# Milestone v1.84_workflow-revamp — PLAN

## 세션 소속 근거 (self-apply)

**세션 소속**: `milestones/v1.84_workflow-revamp/` (Meta-only, 새 milestone scope 정의)

**근거**:

- 변경 파일: S1a × 1 (`claude/commands/harness-meta.md`) + S1d × 1 (milestone 자체) + S2 × 2 (`bootstrap/docs/OWNERSHIP.md`, `docs/adr/ADR-006-workflow-revamp.md`) + S3 × 2 (`sessions/meta/ROADMAP.md`, root `CLAUDE.md`) + tests × 4 (`tests/smoke-*.sh`) — 다수파 = meta
- T1 경로 다수결 = meta. T5 워크플로우 자체 정의 = meta scope.

## Scope inheritance (verbatim from 사용자 발의 2026-05-06)

**Source — 사용자 발의 (2026-05-06 in-session)** (verbatim):

> "워크플로우 최적화 개선
> ROADMAP 생성 -> MILESTONE 생성 -> PLAN 생성 -> PHASE 생성 및 진행 -> 커밋 -> 푸시 및 머지
> 의 흐름으로 진행하면 ROADMAP 크기도 안커지면서 버전관리가 가능하지 않을까 싶은데. 어떻게 생각해"
>
> "v1.83 폐기"
>
> "Roadmap/v{X.Y}_milestone/n개 Plan/각 Plan의 Phase 이런식으로 관리하고 싶은데"

**Parsed sub-items (5)**:

1. **Stage A — ROADMAP read+update** — 매 milestone 진입 시 전역 `sessions/meta/ROADMAP.md` 갱신 단계 명시화
2. **Stage B — MILESTONE 컨테이너 생성** — `milestones/v{X.Y}_{slug}/` (vX.Y 식별자, M{N} 폐기)
3. **Stage C — N개 PLAN 사전 설계** — milestone 생성 시 N개 PLAN slug 사전 선언 (`plan-{n}-{slug}/`)
4. **Stage D — PHASE 진행** — 각 PLAN 안의 N phase, 각 phase = 1 commit
5. **Stage E — 푸시 + main 머지** — worktree branch → main, milestone 종료 신호

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `projects/<name>/ROADMAP.md` 동시 적용 | 후속 evidence-driven `project-workflow-extension` |
| 레거시 `sessions/meta/v1.0~v1.82` 마이그레이션 | forward-only soft-skip 유지 |
| smoke `--fix` workflow-aware 자동화 | evidence 3+ 시 후속 `smoke-workflow-aware-fix` |
| `bootstrap/skills/` SKILL × 2 (harness-plan-verify, harness-roadmap-update) 갱신 | 본 milestone에서 흡수 (plan-1 phase-2 OWNERSHIP 갱신 시 동반) |
| 푸시 전 `verify.{ps1,sh}` 전체 회귀 (Z/A/B/C/D/E/F/H/I 9 stage) | plan-3 phase-2 verify checks 추가 시 동반 |

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | (N/A) |
| topic | (N/A) |
| findings | (N/A) |
| drift | N/A |
| re-verify | (N/A) |

**Citations**: 사용자 자율 워크플로우 재설계, 외부 spec 의존 없음. v1.83 milestone-phase 2-tier(`d8ada7b`)는 1차 도입 후 폐기 (revert `295bd16`) — 본 milestone이 superseded 정의. drift=N/A 정합.

## 배경

- **v1.83 폐기 경위**: `sessions/meta/v1.83-milestone-phase-infra/` (5 sub-commit, squash merge `d8ada7b` to main, PR #1)에서 milestone-phase 2-tier 도입. 사용자 검토 후 4 차이 식별:
  1. phase별 PLAN.md 의무 → milestone당 N PLAN, 각 PLAN의 phase는 commit only
  2. ROADMAP 단계 명시 부재 → Stage A 신설
  3. 푸시·머지 단계 부재 → Stage E 신설
  4. M{N} 식별자 → v{X.Y}_{slug} 식별자로 통합 (vX.Y는 SemVer minor bump 자연 지속)
- **폐기 방식**: `git revert d8ada7b` (squash merge commit 단일 revert) → `295bd16` revert commit. 29 files, -1071 +49 lines. milestones/M{1,2}/, sessions/meta/v1.83/, ADR-006-milestone-phase-2tier 전부 제거.
- **forward path**: 본 milestone(v1.84)에서 4 PLAN 사전 설계로 새 워크플로우 도입 + dogfood.

## 4 PLAN 사전 선언

| # | PLAN | Phase 수 | 주제 | 변경 파일 |
|:-:|------|:-:|------|---------|
| 1 | `plan-1-infra` | 3 | 5-Stage 흐름 + v{X.Y}_{slug} 정책 + ADR | `claude/commands/harness-meta.md` (8단계 → 5-Stage) / `bootstrap/docs/OWNERSHIP.md` (S1d 새 정의) / `docs/adr/ADR-006-workflow-revamp.md` (신규, 번호 reuse) / `docs/adr/README.md` (인덱스) / 루트 `CLAUDE.md` (milestones 모듈) |
| 2 | `plan-2-roadmap-redesign` | 1 | ROADMAP §8/§9 milestone-summary 축소 | `sessions/meta/ROADMAP.md` (~50% 축소 목표, phase 상세는 milestone REPORT 위임) |
| 3 | `plan-3-smoke-verify` | 2 | smoke milestone glob + verify checks | `tests/smoke-{cross-ref,scope-contract,spec-verification,claude-md-drift}.sh` (4 개 + glob `v{X.Y}_*`) / `verify.{ps1,sh}` (milestone Stage 추가) |
| 4 | `plan-4-dogfood` | 1 | milestone REPORT.md + 푸시·머지 | `milestones/v1.84_workflow-revamp/REPORT.md` (전체 요약) / Stage E 푸시 + 사용자 확인 후 main 머지 |

## Phase별 commit 매트릭스

| # | Commit 메시지 | 대상 |
|:-:|------|------|
| 0 | `Revert "feat(meta): v1.83 milestone-phase 2-tier ..."` | `295bd16` (이미 적용됨) |
| 1 | `feat(meta): milestones/v1.84_workflow-revamp/PLAN.md (4 PLAN 사전 선언)` | 본 PLAN.md |
| 2 | `feat(meta): v1.84 plan-1 phase-1 — 5-Stage 흐름 (claude/commands/harness-meta.md)` | plan-1 phase-1 + plan-1/PLAN.md |
| 3 | `feat(meta): v1.84 plan-1 phase-2 — OWNERSHIP S1d v{X.Y}_{slug} + ADR-006-workflow-revamp` | plan-1 phase-2 |
| 4 | `feat(meta): v1.84 plan-1 phase-3 — root CLAUDE.md milestones 모듈` | plan-1 phase-3 + plan-1/REPORT.md |
| 5 | `refactor(meta): v1.84 plan-2 — ROADMAP §8/§9 milestone-summary 축소` | plan-2 (single phase + PLAN+REPORT) |
| 6 | `test(meta): v1.84 plan-3 phase-1 — smoke milestone glob (v{X.Y}_*)` | plan-3 phase-1 + plan-3/PLAN.md |
| 7 | `test(meta): v1.84 plan-3 phase-2 — verify checks` | plan-3 phase-2 + plan-3/REPORT.md |
| 8 | `docs(meta): v1.84 plan-4 + milestone REPORT.md` | plan-4 (single phase + PLAN+REPORT) + milestone REPORT.md |
| E | (no commit) | `git push origin claude/upbeat-ptolemy-cda2f1` + main 머지 (사용자 확인 후) |

**총 9 commit on branch** (revert 1 + milestone PLAN 1 + 7 phase commit). E는 commit 없음.

## 성공 기준

- [x] v1.83 인프라 폐기 (revert `295bd16` 확인 — milestones/M*/, sessions/meta/v1.83/, ADR-006-milestone-phase-2tier 부재)
- [ ] 5-Stage 흐름 명문화 (`claude/commands/harness-meta.md`)
- [ ] `v{X.Y}_{slug}/plan-{n}-{slug}/phase-{m}/` 구조 OWNERSHIP S1d 정의
- [ ] ADR-006-workflow-revamp 신규 작성 + 인덱스 등록
- [ ] root `CLAUDE.md` milestones 모듈 entry
- [ ] `sessions/meta/ROADMAP.md` §8/§9 ~50% 축소
- [ ] smoke 4 종 milestone glob 갱신 + 회귀 0
- [ ] verify checks milestone Stage
- [ ] milestone REPORT.md (본 milestone 자기 dogfood)
- [ ] Stage E 푸시 + 사용자 확인 후 main 머지

## 후속 세션

- §3-A: `project-workflow-extension` (projects/<name>/ROADMAP.md milestone 적용 — evidence-driven)
- §3-B: `smoke-workflow-aware-fix` (smoke `--fix` mode workflow-aware 자동화 — evidence 3+ 시)
- §3-E: 누락 시 추가 — `harness-roadmap-update-workflow-aware` (SKILL이 v{X.Y}_{slug} 인식 자동 갱신)

## 관련

- 폐기 대상: 부재 (v1.83 revert로 history만)

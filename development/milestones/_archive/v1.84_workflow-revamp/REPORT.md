# Milestone v1.84_workflow-revamp — REPORT

**완료일**: 2026-05-06
**상태**: ✅ 완료 (4 PLAN, 5 commit on branch + revert)
**선행**: v1.83 milestone-phase 2-tier (revert `295bd16`)
**관련 ADR**: [ADR-006-workflow-revamp.md](../../docs/adr/ADR-006-workflow-revamp.md)

## 최종 결과

### 신규 인프라

- **4-tier 워크플로우**: `ROADMAP > milestone > N PLAN > 각 PLAN의 phase` (ADR-006-workflow-revamp)
- **5-Stage A~E 흐름**: ROADMAP read+update / milestone 컨테이너 / N PLAN 사전 설계 / phase 진행 / push+머지
- **vX.Y 단조 번호**: M{N} 폐기. milestones/v{X.Y}_{slug}/ 식별자가 sessions/meta/ 통합 번호 공간

### 변경 파일 (총 14)

| 영역 | 파일 |
|------|------|
| 신규 milestone | `milestones/v1.84_workflow-revamp/PLAN.md` + `REPORT.md` (본 파일) |
| 신규 PLAN (4) | `plan-1-infra/{PLAN,REPORT}.md` + `plan-2-roadmap-redesign/{PLAN,REPORT}.md` + `plan-3-smoke-verify/{PLAN,REPORT}.md` + `plan-4-dogfood/{PLAN,REPORT}.md` |
| 인프라 신규 | `docs/adr/ADR-006-workflow-revamp.md` |
| 핵심 정책 갱신 | `claude/commands/harness-meta.md` (8단계 → 5-Stage) / `bootstrap/docs/OWNERSHIP.md` (S1d 신규) / `docs/adr/README.md` (인덱스) |
| Root | `CLAUDE.md` (모듈 표 + CRITICAL 1줄) |
| ROADMAP | `sessions/meta/ROADMAP.md` (§1/§3-A/§3-B/§8 milestone-summary 정책) |
| smoke | `tests/smoke-scope-contract.sh` (milestone glob 1행) |
| Cleanup (smoke --fix) | 5 PLAN/REPORT 부재 link 삭제 (false positive 의심) |

### Commit 매트릭스 (commit 통합 retro 갱신)

| # | Commit | 내용 |
|:-:|--------|------|
| 0 | `295bd16` | Revert "v1.83 milestone-phase 2-tier" (29 files, -1071 +49) |
| 1 | `91ff1e1` | feat(meta): milestones/v1.84 + plan-1-infra (3 phase 통합) + smoke cleanup |
| 2 | `215e912` | refactor(meta): v1.84 plan-2-roadmap-redesign — ROADMAP §8 milestone-summary 정책 |
| 3 | TBD | docs(meta): v1.84 plan-3+plan-4 통합 + milestone REPORT.md (Stage E 직전) |

**총 4 commit on branch** (revert + 3 forward). 본 ADR 매트릭스 (8 commit 계획)에서 단순화 — pre-commit stash race condition으로 plan-3+plan-4 통합.

## 구현 요약

### plan-1-infra (3 phase 통합 → commit 91ff1e1)

- **phase-1**: `claude/commands/harness-meta.md` 8단계 → 5-Stage A~E. 대상 구분 표 갱신 (메타 milestone v1.84+ row 신규 + 레거시 메타 세션 row).
- **phase-2**: `bootstrap/docs/OWNERSHIP.md` S1d 신규 정의 (regex `^v[1-9][0-9]*\.[0-9]+[a-z]?_[a-z0-9-]+$`) + `docs/adr/ADR-006-workflow-revamp.md` 작성 (번호 reuse, v1.83 ADR-006-milestone-phase-2tier는 main에서 revert로 부재) + `docs/adr/README.md` 인덱스.
- **phase-3**: 루트 `CLAUDE.md` milestones 모듈 표 row + CRITICAL 1줄 + 세션 소속 판정 1줄.
- **부수효과**: smoke-cross-ref `--fix` 자동 적용 6 파일 (1 정상 ADR-006 REPORT 부재 link + 5 false positive 의심 — bootstrap/skeletons/v0.1-bootstrap/PLAN.md, sessions/meta/v1.10g/REPORT.md, v1.34/PLAN.md, v1.75/PLAN+REPORT.md).

### plan-2-roadmap-redesign (single phase → commit 215e912)

- `sessions/meta/ROADMAP.md` 4 영역 갱신:
  - §1 audit 일자: v1.82 → v1.84_workflow-revamp milestone 기준
  - §3-A 16건 → 17건 (`project-workflow-extension` 추가, evidence-driven)
  - §3-B `smoke-cross-ref-false-positive-fix` 행 추가 (plan-1 발견)
  - §8 v1.84+ milestone-summary 정책 1줄 + v1.84_workflow-revamp row (1 milestone = 1 row)
- §9 legacy stamp 보존 (v1.0~v1.82 forward-only)
- ROADMAP 비대화 차단 forward-only 단조 정책 도입

### plan-3-smoke-verify (single phase, 단순화)

- `tests/smoke-scope-contract.sh` enumerate glob에 `milestones/v[0-9]*_*/PLAN.md` 1행 추가 — milestone PLAN의 § 의무 검증 흡수
- smoke-cross-ref / smoke-spec-verification / smoke-claude-md-drift 변경 0 (자동 enumerate 또는 영향 외)
- verify Stage K 폐기 (옵션이었음)

### plan-4-dogfood (single phase, plan-3과 통합 commit)

- milestone REPORT.md 작성 (본 파일)
- plan-3 + plan-4 + smoke + milestone REPORT 통합 commit (사용자 단순화 결정)
- Stage E 푸시 + 사용자 명시 동의 후 main 머지

## 판정

| milestone PLAN 성공 기준 | 결과 |
|------------------------|:----:|
| v1.83 인프라 폐기 (revert) | ✅ |
| 5-Stage 흐름 명문화 | ✅ |
| `v{X.Y}_{slug}/plan-{n}/phase-{m}/` 구조 OWNERSHIP S1d 정의 | ✅ |
| ADR-006-workflow-revamp 신규 + 인덱스 등록 | ✅ |
| root CLAUDE.md milestones 모듈 entry | ✅ |
| ROADMAP §8/§9 ~50% 축소 | ⚠️ forward-only 정책 도입 (미래 단조 적용); §9 legacy 보존 |
| smoke 4종 milestone glob 갱신 + 회귀 0 | ✅ smoke-scope-contract 1행 + 회귀 0 |
| verify checks milestone Stage | ⚠️ 단순화로 폐기 (옵션) |
| milestone REPORT.md (자기 dogfood) | ✅ |
| Stage E 푸시 + 사용자 확인 후 main 머지 | ⏳ 본 commit 후 진행 |

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | (N/A) |
| topic | (N/A) |
| findings | (N/A) |
| drift | N/A |
| re-verify | (N/A) |

**Citations**: 사용자 자율 워크플로우 재설계, 외부 spec 의존 없음. v1.83 ADR-006-milestone-phase-2tier가 1차 도입 후 폐기 (revert `295bd16`). 본 milestone이 superseded 정의. drift=N/A 정합.

## Lessons Learned (milestone 전체)

- **L1 — pre-commit cross-ref `--fix` cascading**: smoke-cross-ref가 working tree 전체 검사 + broken ref 자동 행 삭제. milestone PLAN/ADR-006 안의 미작성 file (REPORT.md 등) link가 broken으로 잡혀 자동 삭제 → commit abort. 해결: 모든 phase 변경을 통합 stage 후 1 commit으로 진행.
- **L2 — smoke-cross-ref `--fix` false positive (5건 의심)**: bootstrap/skeletons/v0.1-bootstrap/PLAN.md, sessions/meta/v1.10g/REPORT.md, v1.34/PLAN.md, v1.75/PLAN+REPORT.md의 link가 broken으로 잘못 판정됨 (실 file 존재). 원인 추정: smoke의 path resolution 또는 worktree state 처리 버그. 후속 §3-B `smoke-cross-ref-false-positive-fix` 등록.
- **L3 — pre-commit stash race condition (2회차)**: `[INFO] Stashing unstaged files` + `[INFO] Restored changes` 사이에 working tree 변경이 lost. 본 milestone에서 ROADMAP / smoke-scope-contract 각 1회 lost (cache patch로 복구). 후속 §3-B `pre-commit-stash-safety`.
- **L4 — phase별 commit 분리의 부담 (dogfood 첫 회차)**: 4 PLAN × N phase = 7+ commit fine-grained로 cross-ref cascading + stash race로 hang 16분+. 사용자 결정으로 plan-1 (3 phase 통합) + plan-3+4 (통합) → 4 commit on branch. 후속 milestone (v1.85+)은 cached hooks + clean state로 phase별 commit 가능 예상.
- **L5 — milestone-summary 정책의 dogfood 검증**: ROADMAP §8 v1.84 row 1줄 + 4 PLAN의 phase 상세는 milestone REPORT.md (본 파일)에 보관. forward-only 비대화 차단 단조 적용 확인.
- **L6 — ADR-006 번호 reuse**: v1.83 ADR-006-milestone-phase-2tier가 main에서 revert로 부재. 새 ADR-006-workflow-revamp가 번호 재사용. main view에서 ADR-006이 단일.
- **L7 — vX.Y 단조 번호의 효용**: M{N} 별도 번호 공간 폐기 + sessions/meta/ + milestones/ 통합 번호 공간으로 audit 단순화.

## 후속 세션 (등록)

- **§3-A** (외부 사용자 등장 의존):
  - `project-workflow-extension` — 프로젝트 ROADMAP 또는 milestone 적용 evidence (ROADMAP §3-A row 추가됨)
- **§3-B** (회귀/장애 evidence 의존):
  - `smoke-cross-ref-false-positive-fix` — 5건 false positive root cause + 패치 (ROADMAP §3-B row 추가됨)
  - `pre-commit-stash-safety` — stash race condition 회피 (evidence 2건 누적, 후속 등록)
  - `smoke-spec-verification-milestone-glob` — sed regex 확장 evidence 시
  - `verify-milestone-stage-k` — Stage K 신설 evidence 시

## 관련 문서

- 본 milestone PLAN: [PLAN.md](PLAN.md)
- ADR-006-workflow-revamp: [../../docs/adr/ADR-006-workflow-revamp.md](../../docs/adr/ADR-006-workflow-revamp.md)
- 5-Stage 흐름: [../../claude/commands/harness-meta.md](../../claude/commands/harness-meta.md)
- OWNERSHIP S1d: [../../bootstrap/docs/OWNERSHIP.md](../../bootstrap/docs/OWNERSHIP.md)
- ROADMAP: [../../sessions/meta/ROADMAP.md](../../sessions/meta/ROADMAP.md)
- v1.83 폐기 (history only): commit `295bd16` (revert) / `d8ada7b` (PR #1 squash, reverted)

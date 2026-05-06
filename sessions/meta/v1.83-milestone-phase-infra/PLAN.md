---
milestone: M1-milestone-phase-infra
milestone-id: M1
phase: 1
---

# PLAN — v1.83 milestone-phase 2-tier 인프라 도입 (M1 phase 1)

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: 신규 `milestones/` 디렉토리 + S2 (`bootstrap/docs/OWNERSHIP.md` / `bootstrap/docs/SPEC_VERIFICATION.md` / `bootstrap/skills/audit/<2 SKILL>/SKILL.md`) + S1a (`claude/commands/harness-meta.md`) + S3 (`README.md` / `CLAUDE.md` / `docs/adr/*.md`) + 모듈 CLAUDE.md 2건 (`sessions/CLAUDE.md` / `tests/CLAUDE.md`) + `tests/smoke-*.sh` 4건
- T1 다수결 — S1a + S1b + S1c + S2 + S3 모두 meta 소유 → 16+ 파일 모두 meta 소유
- T2 — milestone-phase 2-tier는 **구조적 정책 신설** (스펙 source). 후속 phase migration은 후속 세션에서 (T4 크로스 커팅 분할 원칙)

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-05-06 세션, AskUserQuestion 답변 11회)** (verbatim):

> "지금 워크플로우 자체를 개선하고 싶은데, 그전에 논의 좀 하자. 하나의 큰 milestone에서 roadmap 구성하고, 그에 따른 phase들을 만들어서 진행하는 방식으로 하고 싶어."
>
> 사용자 4 결정 confirmed (AskUserQuestion 11회) — 동기 4 모두 (흐트림 + 분할 + grouping + 의존성) / 규모 주제별 / 디렉토리 milestones/M{N}-{name}/ 상위 신설 / ID 순차 M1, M2, ... / 단발 1-phase wrap / 기존 82 세션 retro classify / Lifecycle Incremental / Scope Meta만 / Layout 3파일 / 마이그레이션 점진 / Linkage 양방향

**Parsed sub-items (8)**:

1. **A1 milestones/ 디렉토리 인프라** — `milestones/M{N}-{slug}/{PLAN,ROADMAP,REPORT}.md` 3 파일 규격 신설 + M-번호 정책 (`^M[1-9][0-9]*$`, 창설 순서)
2. **A2 양방향 linkage** — phase PLAN.md frontmatter `milestone: M{N}-{slug}` + milestones/M{N}/ROADMAP.md §"Phases" 표 cross-ref
3. **A3 dogfood M1** — 본 v1.83 자기 wrap (`milestones/M1-milestone-phase-infra/{PLAN,ROADMAP,REPORT}.md`)
4. **A4 ADR-006 신규** — `docs/adr/ADR-006-milestone-phase-2tier.md` 결정 기록
5. **A5 1순위 6 docs 갱신** — OWNERSHIP / SPEC_VERIFICATION / harness-meta.md / CLAUDE.md (root) / sessions/CLAUDE.md / smoke-spec-verification.sh
6. **A6 2순위 5 docs 갱신** — harness-plan-verify SKILL / harness-roadmap-update SKILL / tests/CLAUDE.md / README.md / docs/adr/README.md
7. **A7 smoke 4 갱신** — smoke-cross-ref.sh L77 regex / smoke-spec-verification.sh L217/L261/L418 / smoke-scope-contract.sh L198~L204 / smoke-roadmap-sync.sh L161 (조건부)
8. **A8 M2 retro 사례** — `milestones/M2-drift-detection-infra/{PLAN,ROADMAP,REPORT}.md` + v1.79~v1.82 5 PLAN.md frontmatter 추가

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 명백 cluster 21건 retro (M3~M22) | `v1.84-milestone-retro-batch1` (1순위 cluster 5~7건) |
| 단발 15~18건 retro wrap | `v1.85-milestone-retro-batch2` |
| Project ROADMAP (`projects/upbit/ROADMAP.md`) milestone 적용 | evidence 발생 시 후속 (`project-milestone-extension`) |
| 3순위 9 docs (도메인 docs 6 + 모듈 CLAUDE.md 3 + AGENTS.md) 갱신 | drift 발생 시 후속 (`smoke-claude-md-drift` 자동 감지 후) |
| harness-roadmap-update SKILL 8-step (자동 retro 추천) | evidence 3+ 시 (`harness-roadmap-update-auto-retro`) |
| Bootstrap 세션 (각 프로젝트 v0.1) milestone wrap | project scope 외 — Meta scope 한정 |
| `verify.ps1`/`verify.sh` Stage 추가 (milestone 디렉토리 검증) | 직접 영향 무 — verify는 설치 검증, smoke가 sessions/milestones 검증 |

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — milestone-phase 2-tier 구조는 **본 repo 내부 정책 신설** (sessions/meta/ROADMAP.md / OWNERSHIP.md / SPEC_VERIFICATION.md 모두 자체 단일 소스). Anthropic Claude Code docs (Frontmatter / Slash commands) 외부 spec 의존 0 — phase PLAN.md frontmatter `milestone:` 필드는 자체 정의 (Claude Code 표준 frontmatter 필드 무관) |
| **re-verify** | N/A |

**Citations**: 없음 (drift=N/A 분기, 외부 spec 의존 0). 본 repo `bootstrap/docs/OWNERSHIP.md` §Scope contract / `bootstrap/docs/SPEC_VERIFICATION.md` §2~5는 내부 docs 자체 단일 소스로 별도 spec verification 대상 아님.

## 배경

- **선행 세션**: `v1.82-agents-md-drift-fix` (2026-05-06) — AGENTS.md 6건 stale drift 정정. M2-drift-detection-infra의 마지막 phase, milestone-aware 도입 직전.
- **현 워크플로우 한계 4건**:
  - 관련 세션 흐트림 (v1.78~v1.82 5세션이 의미상 1 milestone이지만 top-level 번호로 분산)
  - 큰 작업 분할 부담 (PLAN 1개 8단계 시 scope 비대)
  - ROADMAP grouping 부재 (§3 trigger 대기 milestone 묶임 없음)
  - 의존성 표현 부재 (phase 간 선행/후행 텍스트 only)
- **누적 evidence**: 22 cluster 후보 retro 분류 가능 (Explore agent 1 결과). 본 세션은 **인프라 + dogfood + M2 retro 1건** 점진 시작.
- **사용자 결정**: AskUserQuestion 11회 confirmed (위 Scope inheritance §)

## 목표

- [ ] A1: `milestones/M{N}-{slug}/{PLAN,ROADMAP,REPORT}.md` 3 파일 규격 신설 (M-번호 정책 `^M[1-9][0-9]*$`)
- [ ] A2: 양방향 linkage 메커니즘 — phase PLAN.md frontmatter + milestone ROADMAP.md §"Phases" 표
- [ ] A3: dogfood — `milestones/M1-milestone-phase-infra/{PLAN,ROADMAP,REPORT}.md` 본 세션 wrap
- [ ] A4: `docs/adr/ADR-006-milestone-phase-2tier.md` 신규 + `docs/adr/README.md` 인덱스 row
- [ ] A5: 1순위 6 docs 갱신 (OWNERSHIP S# 확장 + SPEC_VERIFICATION milestone PLAN 의무 + harness-meta.md 8단계 milestone-aware + CLAUDE.md root 구조 규칙 + sessions/CLAUDE.md 디렉토리 트리 + smoke-spec-verification.sh glob 확장)
- [ ] A6: 2순위 5 docs 갱신 (harness-plan-verify SKILL Step 1 / harness-roadmap-update SKILL 5→6 step / tests/CLAUDE.md smoke 매트릭스 / README.md layout / ADR README)
- [ ] A7: smoke 4 갱신 (smoke-cross-ref.sh L77 regex + smoke-spec-verification.sh L217/L261/L418 + smoke-scope-contract.sh L198~L204 + smoke-roadmap-sync.sh L161 조건부)
- [ ] A8: M2 retro — `milestones/M2-drift-detection-infra/{PLAN,ROADMAP,REPORT}.md` + v1.79~v1.82 5 PLAN.md frontmatter 추가
- [ ] smoke 5종 회귀 0 (cross-ref / spec-verification / scope-contract / roadmap-sync / claude-md-drift)
- [ ] pre-commit hook PASS (4 hook)
- [ ] dogfood 검증 — M1 인프라 자체 사용 시연

## 변경 대상

### 신규 (8 파일)

| 파일 | 역할 |
|------|------|
| `milestones/M1-milestone-phase-infra/PLAN.md` | dogfood — milestone 범위 선언 |
| `milestones/M1-milestone-phase-infra/ROADMAP.md` | phase 1 = v1.83 (단일 phase) |
| `milestones/M1-milestone-phase-infra/REPORT.md` | v1.83 종료 시 (placeholder) |
| `milestones/M2-drift-detection-infra/PLAN.md` | retro 사례 (v1.78~v1.82 wrap) |
| `milestones/M2-drift-detection-infra/ROADMAP.md` | phase 1~5 enumerate |
| `milestones/M2-drift-detection-infra/REPORT.md` | retro 종합 |
| `docs/adr/ADR-006-milestone-phase-2tier.md` | 결정 기록 |
| `sessions/meta/v1.83-milestone-phase-infra/PLAN.md` | 본 파일 (frontmatter 적용 dogfood) |

### 갱신 (15 파일)

| 파일 | 변경 |
|------|------|
| `bootstrap/docs/OWNERSHIP.md` | §"Scope (S1~S7)"에 milestone 계층 명시 (S1 확장) + Evolution 조항 v1.83 링크 + "선행 세션" → "선행 phase OR 선행 milestone" |
| `bootstrap/docs/SPEC_VERIFICATION.md` | §2 PLAN 규격에 milestone PLAN 포함 + §11 cross-file matrix milestone-phase 쌍 + §7 legacy 정책 milestone 이전 skip |
| `claude/commands/harness-meta.md` | 8단계 milestone-aware 확장 (단계 1/2/3/9) + argument 분기 `<milestone-slug>` 추가 |
| `CLAUDE.md` (root) | "구조 규칙 (CRITICAL)"에 milestone 계층 + 모듈 가이드 표에 milestones/ 행 |
| `sessions/CLAUDE.md` | 디렉토리 트리 milestones/ + PLAN/REPORT 작성 규약 milestone-level 의무 § + Scope contract 등동성 |
| `tests/smoke-spec-verification.sh` | L217/L261/L418 glob에 `milestones/M*/PLAN.md` + `milestones/M*/REPORT.md` 추가 |
| `tests/smoke-cross-ref.sh` | L77 `_VER_SESS` regex 확장 (`v\d+\.\d+\|M\d+`) |
| `tests/smoke-scope-contract.sh` | L198~L204 enumerate glob에 milestones/M*/ 추가 |
| `tests/smoke-roadmap-sync.sh` | L161 META_SESSIONS glob (조건부 — 본 세션은 sessions/meta/ROADMAP.md 형식 변경 없음) |
| `bootstrap/skills/audit/harness-plan-verify/SKILL.md` | Step 1 path detection milestone 분기 + frontmatter `milestone:` 인식 |
| `bootstrap/skills/audit/harness-roadmap-update/SKILL.md` | 5-step → 6-step 확장 (Step 1 milestone target / Step 2 regex / Step 6 frontmatter-insert) |
| `tests/CLAUDE.md` | smoke 27 매트릭스 milestone-aware 표기 |
| `README.md` | "Directory layout" milestones/ 행 + 명령어 milestone 예시 |
| `docs/adr/README.md` | 인덱스 row ADR-006 |
| `sessions/meta/v1.83-milestone-phase-infra/REPORT.md` | 세션 종료 시 작성 |

### Frontmatter 추가 (5 파일, M2 retro)

| 파일 | 추가 내용 |
|------|---------|
| `sessions/meta/v1.79-claude-md-drift-smoke/PLAN.md` | frontmatter `milestone: M2-drift-detection-infra` `milestone-id: M2` `phase: 1` |
| `sessions/meta/v1.79b-claude-md-drift-precommit/PLAN.md` | phase 2 |
| `sessions/meta/v1.80-precommit-hook-entry-policy/PLAN.md` | phase 3 |
| `sessions/meta/v1.81-roadmap-housekeeping/PLAN.md` | phase 4 |
| `sessions/meta/v1.82-agents-md-drift-fix/PLAN.md` | phase 5 |

## 성공 기준

- [ ] `milestones/M1-milestone-phase-infra/` 3 파일 + M2 retro 3 파일 + ADR-006 = 신규 8 파일 작성
- [ ] 1순위 6 + 2순위 5 + smoke 4 = 갱신 15 파일 정합
- [ ] M2 retro 5 PLAN.md frontmatter 추가
- [ ] smoke 5종 회귀 0 (cross-ref + spec-verification + scope-contract + roadmap-sync + claude-md-drift)
- [ ] pre-commit hook 4종 PASS
- [ ] dogfood — M1-milestone-phase-infra/{PLAN,ROADMAP,REPORT}.md 자기 wrap 정상 작동
- [ ] 양방향 linkage 검증 — milestones/M1-/ROADMAP.md → sessions/meta/v1.83-/PLAN.md cross-ref 유효 + 역방향

## 커밋 전략

5 commit 분할 (각 작업 단위 사용자 확인 후):

1. `docs(meta): sessions/meta/v1.83-milestone-phase-infra` — 본 세션 PLAN.md (이미 적용된 frontmatter dogfood 포함)
2. `feat(meta): milestones/ 인프라 + M1-milestone-phase-infra dogfood + ADR-006` — milestone 디렉토리 신설 + 3 파일 + ADR-006
3. `feat(meta): smoke 4 glob/regex 확장 (cross-ref + spec-verification + scope-contract + roadmap-sync)` — milestones/ 디렉토리 인지
4. `docs(meta): 1순위 6 docs (OWNERSHIP + SPEC_VERIFICATION + harness-meta.md + CLAUDE.md root + sessions/CLAUDE.md + smoke-spec-verification.sh 위 commit 3에 흡수)` — rule + cross-ref
5. `docs(meta): 2순위 5 docs (SKILL × 2 + tests/CLAUDE.md + README + ADR README) + M2-drift-detection-infra retro` — SKILL 확장 + retro 사례

## 검토 절차

- **5 관점 검토**: 변경 파일 23+ → 5 관점 전체 (architecture / spec-drift / 회귀 risk / 보안 / scope contract). 단계 5에서 진행 (병렬 subagent dispatch).
- **Plan-verify (단계 6)**: drift=N/A 분기 self-apply 완료 (위 § 채움)
- **Plan 확정 (단계 7)**: 사용자 진입 승인 — 본 PLAN을 통한 ExitPlanMode (이미 승인 받음)

## 후속 세션 연결

- **선행 세션**: `v1.82-agents-md-drift-fix` (M2 마지막 phase)
- **후속 milestone (점진)**:
  - `M3+ retro` — `v1.84-milestone-retro-batch1` (명백 cluster 5~7건)
  - `v1.85-milestone-retro-batch2` (단발 15~18건 wrap)
  - `v1.86-milestone-verification` (잔존 정정 + 통계)
- **후속 evidence-driven**:
  - `project-milestone-extension` — projects/upbit/ROADMAP.md milestone 수요 시
  - `harness-roadmap-update-auto-retro` — 자동 retro 추천 evidence 3+ 시
- **AskUserQuestion 자동 invoke**: 단계 5 (5 관점 검토 시 의견 충돌 시) + 단계 9 (trigger 분류 애매 시)

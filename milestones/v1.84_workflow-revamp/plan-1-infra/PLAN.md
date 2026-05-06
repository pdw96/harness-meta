# PLAN-1: infra — 5-Stage 흐름 + v{X.Y}_{slug} 정책 + ADR

본 PLAN은 milestone `v1.84_workflow-revamp`의 첫 번째 PLAN — 새 워크플로우의 **인프라 정의**.
무거운 § (Scope inheritance / Out of scope / Spec verification / 세션 소속 근거)은 milestone PLAN ([../PLAN.md](../PLAN.md))에 있음. 본 PLAN은 phase 표 + 변경 파일만.

## 목표

- 5-Stage 흐름 명문화 (Stage A~E)
- `v{X.Y}_{slug}/plan-{n}-{slug}/phase-{m}/` 구조 정책 OWNERSHIP S1d
- ADR-006-workflow-revamp 신규 작성 (번호 reuse — v1.83 ADR-006-milestone-phase-2tier는 revert로 main에서 부재)
- root CLAUDE.md milestones 모듈 entry

## Phase 매트릭스

| Phase | 변경 파일 | Commit |
|:-:|---------|--------|
| 1 | `claude/commands/harness-meta.md` (기존 8단계 → 5-Stage 흐름) | `feat(meta): v1.84 plan-1 phase-1 — 5-Stage 흐름 (claude/commands/harness-meta.md)` |
| 2 | `bootstrap/docs/OWNERSHIP.md` (S1d 새 정의 — `milestones/v{X.Y}_{slug}/plan-{n}-{slug}/phase-{m}/` regex + 양방향 linkage 정책 갱신) + `docs/adr/ADR-006-workflow-revamp.md` (신규) + `docs/adr/README.md` (인덱스에 ADR-006 row 추가) | `feat(meta): v1.84 plan-1 phase-2 — OWNERSHIP S1d v{X.Y}_{slug} + ADR-006-workflow-revamp` |
| 3 | 루트 `CLAUDE.md` (milestones 모듈 entry — phase 운영 가이드 link) + `sessions/CLAUDE.md` (밀리스톤 진입 시 단계 참조 link) | `feat(meta): v1.84 plan-1 phase-3 — root CLAUDE.md milestones 모듈` |

## 변경 파일 (총 6개)

| 파일 | Phase | 설명 |
|------|:-:|------|
| `claude/commands/harness-meta.md` | 1 | 8단계 흐름 → 5-Stage. Stage A (ROADMAP read+update) / B (milestone 생성) / C (N PLAN 사전 설계) / D (phase 진행) / E (push+머지) |
| `bootstrap/docs/OWNERSHIP.md` | 2 | S1d (Meta milestone 트리) 재정의 — M{N} → v{X.Y}_{slug} regex 변경. 양방향 linkage 갱신 |
| `docs/adr/ADR-006-workflow-revamp.md` | 2 | 신규 ADR — 4-tier (ROADMAP > milestone > PLAN > phase) 결정 + v1.83 ADR-006 superseded 명시 |
| `docs/adr/README.md` | 2 | 인덱스 row 추가: ADR-006 workflow-revamp |
| `CLAUDE.md` (root) | 3 | "모듈별 가이드" 표에 milestones/ entry + S1d cross-ref |
| `sessions/CLAUDE.md` | 3 | milestone 진입 시 5-Stage 단계 참조 link |

## 성공 기준

- [ ] `claude/commands/harness-meta.md`의 절차 §이 5-Stage A~E 형식으로 명문화
- [ ] `bootstrap/docs/OWNERSHIP.md` S1d regex가 `^v[0-9]+\.[0-9]+[a-z]?_[a-z0-9-]+$` (또는 동등)
- [ ] `docs/adr/ADR-006-workflow-revamp.md` Accepted 상태, "Superseded — v1.83 ADR-006 (revert 295bd16)" 명시
- [ ] root `CLAUDE.md` 모듈 표에 milestones row 1줄
- [ ] 3 phase commit 모두 conventional commits 정합

## 의존성

- 선행: milestone PLAN.md (commit 1, 4 PLAN 사전 선언)
- 후행: plan-2-roadmap-redesign (S1d 정의 + ADR-006 의존)

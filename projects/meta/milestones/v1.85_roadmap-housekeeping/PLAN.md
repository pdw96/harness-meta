# Milestone v1.85_roadmap-housekeeping — PLAN

## 세션 소속 근거 (self-apply)

**세션 소속**: `milestones/v1.85_roadmap-housekeeping/` (Meta-only, ROADMAP 운영 docs)

**근거**:

- 변경 파일: S3 × 1 (`sessions/meta/ROADMAP.md`) — 단수 파일, S3 다수파
- T1 경로 다수결 = meta. ROADMAP.md는 repo 정책 단일 소스.

## Scope inheritance (verbatim from 사용자 발의 2026-05-06)

**Source — 사용자 발의 (AskUserQuestion 2026-05-06 in-session)** (verbatim):

> "ROADMAP / docs 정리"

**Parsed sub-items (3)**:

1. **§3-B `smoke-cross-ref-false-positive-fix` 누락 추가** — v1.84 §8 entry에서 명시됐으나 §3-B 표에 미등록
2. **§3-B count 라벨 `(11건)` → `(12건)`** — 항목 추가 반영
3. **§1 audit 일자 갱신** — v1.85_roadmap-housekeeping milestone 기준

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| §9 확정 세션에 v1.84 entry 추가 | milestone-summary 정책(v1.84+)으로 §8-only 확정 — 변경 없음 |
| §3-A/B/C/D/E 전체 trigger 도달 감사 | 본 세션 read-only 검토 후 promote 0건 확인 시 무변경 |
| ROADMAP §8 v1.85 entry 추가 | Stage E milestone REPORT + ROADMAP 갱신 시 처리 |

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | N/A |
| topic | N/A |
| findings | N/A |
| drift | N/A |
| re-verify | N/A |

**Citations**: docs-only ROADMAP 정리. 외부 spec 의존 없음. drift=N/A 정합.

## 배경

v1.84_workflow-revamp milestone §8 entry (line 178)에:
> "후속 §3-A `project-workflow-extension` (evidence-driven) + §3-B `smoke-cross-ref-false-positive-fix` (5건 false positive root cause)"

`project-workflow-extension`은 §3-A에 등록 완료 (line 44). `smoke-cross-ref-false-positive-fix`는 §3-B에 **미등록** (11건 목록에 부재). v1.81-roadmap-housekeeping 패턴 답습 (단일 파일 cleanup).

## 1 PLAN 사전 선언

| Plan | Slug | Phase 수 | 변경 파일 | Commit 메시지 |
|------|------|---------|---------|------------|
| plan-1 | audit | 1 | `sessions/meta/ROADMAP.md` × 1 | `docs(meta): v1.85 plan-1 phase-1 — ROADMAP §3-B 누락 항목 추가 + audit 일자 갱신` |

## 성공 기준

- [ ] §3-B `smoke-cross-ref-false-positive-fix` row 추가
- [ ] §3-B count `(11건)` → `(12건)`
- [ ] §1 audit 일자 v1.85 기준 갱신
- [ ] `bash tests/smoke-roadmap-sync.sh` PASS=31 (회귀 0)
- [ ] `bash tests/smoke-scope-contract.sh` PASS (회귀 0)
- [ ] `bash tests/smoke-spec-verification.sh` PASS (회귀 0)
- [ ] `bash tests/smoke-cross-ref.sh` PASS (회귀 0)

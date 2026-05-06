---
milestone: M2-drift-detection-infra
milestone-id: M2
phase: 4
---

<!-- milestone wrap: v1.83 retro classify (ADR-006) -->

# PLAN — v1.81 roadmap housekeeping

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `sessions/meta/ROADMAP.md` 1건 — 운영 docs 예외(`CLAUDE.md` "구조 규칙 (CRITICAL)" 명시), S2/S3 영역 (메타 전역 docs)
- T5 적용 — ROADMAP.md는 OWNERSHIP.md S1~S6 명시 매핑 부재 → "애매하면 meta"
- T2 보강 — 후속 세션 trigger 통합 view 단일 소스(스펙 성격) → meta 소유 정합

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-05-06 세션, AskUserQuestion 답변)** (verbatim):

> "ROADMAP 자체 정리/감사"

**Parsed sub-items (3)**:

1. **§3-E count 라벨 정합** — 라벨 `(6건)` vs 실제 5 row drift 정정 (v1.80에서 `v1.79c` 삭제 후 라벨 미갱신)
2. **audit 일자 갱신** — line 7 `2026-05-05 (v1.80-... 기준)` → `2026-05-06 (v1.81-roadmap-housekeeping 기준)`
3. **§3 trigger 도달 검토** — A/B/C/D/E 5 sub-section 전체 trigger 미발현 확인 (§2 promote 0건 — read-only 검증, 본문 무변경)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| §8 "최근 완료" v1.81 entry 추가 | 본 세션 REPORT 작성 후 `harness-roadmap-update` SKILL 자동 (단계 9-b) |
| §9 "확정 세션" v1.81 stamp | 동일 — 단계 9-b 자동 |
| 도메인 docs (`bootstrap/docs/*.md`) trigger 조건 정합 | 후속 — drift 발견 evidence 시 (현재 0건) |
| §4 Schedule 후보 cadence 재조정 | 후속 — 실 발생 빈도 evidence 누적 시 (현재 0건) |

## Spec verification (context7)

| sub-field | value |
|-----------|-------|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — ROADMAP.md는 내부 메타 docs (외부 라이브러리/SDK/CLI 의존 0). count 라벨 정합 + audit 일자 갱신은 내부 정합성 작업 |
| **re-verify** | N/A |

**Citations**: 없음 (drift=N/A 분기, 외부 spec 의존 0).

## 배경

- **선행 세션**: `v1.80-precommit-hook-entry-policy` (2026-05-05) — §3-E `v1.79c-precommit-hook-direct-vs-wrapper-doc` row 삭제 + audit 일자 v1.79b→v1.80 갱신. 그러나 §3-E 헤더 count 라벨 `(6건)` → `(5건)` 갱신 누락
- **drift evidence**: `awk` row count 검증 결과 §3-A 15/15 ✓ §3-B 10/10 ✓ §3-C 2/2 ✓ §3-D 1/1 ✓ §3-E **6 라벨 vs 5 row ✗**
- **audit cadence**: v1.76(2026-05-05) → v1.78(2026-05-05) → v1.80(2026-05-05) audit 일자 동일 일자 stale. 새 일자 진입 시 명시 갱신
- v1.76 패턴 답습 — 단일 파일 cleanup, 1 commit, 5 관점 검토 skip (trivial scope ROI)

## 목표

- [ ] §3-E count 라벨 `(6건)` → `(5건)` 갱신 (line 88)
- [ ] §1 audit 일자 line 7 `2026-05-05 (v1.80-precommit-hook-entry-policy 기준)` → `2026-05-06 (v1.81-roadmap-housekeeping 기준)` 갱신
- [ ] §3 5 sub-section 전체 trigger 도달 read-only 검증 (REPORT에 결과 명시) — §3-A/B/C/D/E 모두 미발현 확인 → 본문 무변경
- [ ] smoke-roadmap-sync.sh PASS (회귀 0)
- [ ] smoke-spec-verification.sh PASS (회귀 0)
- [ ] smoke-scope-contract.sh PASS (회귀 0)

## 변경 대상

| 파일 | 변경 |
|------|------|
| `sessions/meta/ROADMAP.md` | line 7 audit 일자 + line 88 §3-E count 라벨 (2 occurrence, 단일 commit) |
| `sessions/meta/v1.81-roadmap-housekeeping/PLAN.md` | 본 파일 (신규) |
| `sessions/meta/v1.81-roadmap-housekeeping/REPORT.md` | 세션 종료 시 작성 |

## 성공 기준

- [ ] ROADMAP §3-E count 라벨 = actual row count (5/5)
- [ ] §1 audit 일자 = 오늘 (2026-05-06)
- [ ] §3 trigger 도달 검토 결과 REPORT 본문 명시 (A/B/C/D/E 5 sub-section 각각 미발현 근거)
- [ ] smoke 3종 회귀 0 (roadmap-sync + spec-verification + scope-contract)
- [ ] 단일 commit (`docs(meta): sessions/meta/v1.81-roadmap-housekeeping ...`)

## 커밋 전략

단일 commit — ROADMAP.md 수정 2건(audit 일자 + §3-E 라벨) + PLAN.md + REPORT.md 동시.

## 검토 절차

- **5 관점 검토 skip** — trivial scope (≤5 파일 + docs-only + v1.76 패턴 동일)
- **Plan-verify (단계 6)** — drift=N/A 분기 self-apply만
- **Plan 확정 (단계 7)** — 사용자 진입 승인 (이미 진입 승인 받음 → 본 PLAN 작성 완료 후 곧장 단계 8)

## 후속 세션 연결

- **선행**: `v1.80-precommit-hook-entry-policy` — §3-E row 삭제 시 라벨 미갱신 → 본 세션 발의 trigger
- **후속 (잠재)**: §3-E count drift 재발 evidence 1+ 누적 시 `harness-roadmap-update` SKILL에 count 라벨 자동 정합 기능 추가 (현재 0건, 본 v1.81로 evidence 0→1 진척)

# Milestone v1.86_cross-ref-false-positive-fix — PLAN

**vX.Y**: v1.86
**slug**: cross-ref-false-positive-fix
**생성일**: 2026-05-07
**선행**: v1.85_roadmap-housekeeping

## 세션 소속 근거 (self-apply)

**세션 소속**: `milestones/v1.86_cross-ref-false-positive-fix/` (sessions/meta/ 이력 stamp)

**근거**:

- 변경 파일: `tests/smoke-cross-ref.sh` (S1a — 글로벌 UX) × 1
- T1 경로 다수결 → S1a 단독. T3 불필요 (검증 대상 = S1a 자체)

## Scope inheritance (verbatim from ROADMAP §3-B)

**Source — `sessions/meta/ROADMAP.md` §3-B "Out of scope (trigger 대기)" 표** (verbatim):

> `smoke-cross-ref-false-positive-fix` | `smoke-cross-ref.sh` false positive 5건 root cause 분석 + fix (v1.77 backtick filter 불완전 → `sessions/**/v*-*/*.md` 제외 정밀화). v1.84 L2 Lesson — 현재 5건 잔존 evidence 확인 시 진입 valid | `v1.84 milestone REPORT`

**Parsed sub-items (2)**:

1. **milestones/ 제외 추가** — `milestones/v*/` 하위 파일이 현재 스캔 대상. 미래 milestone PLAN.md가 미작성 REPORT.md 참조 시 broken 오판 → `--fix` 행 삭제(L1/L2 재발 경로). 역할: `sessions/` 제외와 동등 처리
2. **`_VER_SESS` depth 완화** — `[^/]+\.md$` → `.*\.md$`. 현재 sessions 서브디렉토리 없어 실질 영향 0이지만 방어적 정합

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| worktree HARNESS_META_ROOT 불일치 (pre-commit이 항상 main repo 스캔) | 별도 세션 — evidence 없음 |
| double-backtick ` ``code`` ` 필터 개선 | evidence 없음 (현재 PASS=1) |
| pre-commit stash race condition (v1.84 L3) | 별도 §3-B row `pre-commit-stash-safety` |

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | (N/A) |
| topic | (N/A) |
| findings | (N/A) |
| drift | N/A |
| re-verify | (N/A) |

**Citations**: 외부 spec 의존 없음 — `re.compile`, `pathlib.Path` Python stdlib. Anthropic Claude Code docs 참조 불필요. drift=N/A 정합.

## 배경

v1.84 milestone 개발 중 `smoke-cross-ref.sh --fix`가 자동 실행되면서 다음 6개 파일에서 링크 행을 삭제:

- 1건: ADR-006 REPORT.md 미작성 링크 (정상 broken)
- 5건: `bootstrap/skeletons/v0.1-bootstrap/PLAN.md`, `sessions/meta/v1.10g/REPORT.md`, `v1.34/PLAN.md`, `v1.75/PLAN.md`, `v1.75/REPORT.md` — 실 파일 존재 의심 (false positive)

현재 `milestones/v*/` 경로가 `should_exclude()` 미처리. 미래 milestone 작업 시 동일 재발 확실.

**선행 세션**: [v1.78-cross-ref-smoke-infra](../../sessions/meta/v1.78-cross-ref-smoke-infra/)

## N PLAN 사전 선언

| plan | slug | phases | 변경 파일 | commit 메시지 |
|:---:|------|:------:|---------|--------------|
| 1 | `milestone-exclusion` | 2 | `tests/smoke-cross-ref.sh` | `fix(meta): v1.86 plan-1 — smoke-cross-ref milestones/ 제외 추가` |

## 성공 기준

- [ ] `milestones/v*/` 하위 파일 모두 `should_exclude()` → `True` 반환
- [ ] `_VER_SESS` `.*\.md$` 갱신 (서브디렉토리 방어)
- [ ] E2E: milestone fixture PLAN.md (broken ref 포함) → smoke PASS (제외로 감지 안 됨)
- [ ] E2E: living doc (CLAUDE.md 등) broken ref → 여전히 FAIL (제외 영향 없음)
- [ ] 기존 smoke PASS=1 회귀 0
- [ ] smoke-scope-contract / smoke-spec-verification 회귀 0

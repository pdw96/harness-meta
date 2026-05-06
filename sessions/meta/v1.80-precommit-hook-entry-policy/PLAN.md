# PLAN — v1.80-precommit-hook-entry-policy

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `tests/CLAUDE.md` (S3 — Repo 정책·설치), ROADMAP.md (S3) — S3×2 다수
- T1: S3 다수파 → meta 소유

## Scope inheritance (verbatim from v1.79b)

**Source — `sessions/meta/v1.79b-claude-md-drift-precommit/REPORT.md` 다음 후보 섹션** (verbatim):

> `v1.79c-precommit-hook-direct-vs-wrapper-doc` — pre-commit hook entry에서 wrapper vs 직접 호출 기준 `tests/CLAUDE.md`에 명문화. evidence 3+ hook 추가 케이스

**Parsed sub-items (1)**:

1. **Hook entry 기준 명문화** — wrapper vs 직접 호출 결정 기준을 `tests/CLAUDE.md`에 새 섹션으로 추가

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 신규 smoke를 pre-commit에 등록하는 작업 | evidence-driven 후속 미정 |
| `--fix` mode가 없는 smoke에 `--fix` 추가 | 각 해당 smoke 세션 |
| pre-commit hook 순서 / 성능 최적화 | 후속 미정 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|----|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A |
| **re-verify** | N/A |

외부 라이브러리 spec 검증 불필요 — 본 세션은 harness-meta 내부 정책 문서화 전용. pre-commit hook `language: system` / `entry` 필드는 v1.78b context7에서 이미 검증 완료 (drift=no). 추가 query 불필요.

## 배경

- 선행 세션: [`../v1.79b-claude-md-drift-precommit/`](../v1.79b-claude-md-drift-precommit/)
- v1.78b에서 cross-ref hook을 **wrapper 경유**로 추가하고, v1.79b에서 claude-md-drift hook을 **직접 호출**로 추가하면서 두 패턴이 혼재됨
- v1.79b REPORT L1에서 "wrapper vs 직접 호출 기준 명확화 (--fix 지원 smoke에만 wrapper)" 확인
- 현재 4 hook: wrapper 3건 + direct 1건 — 패턴 명확하나 `tests/CLAUDE.md`에 명문화 없음
- §3-E `v1.79c` trigger 조건 "evidence 3+ hook 추가 케이스" → 현재 2건 (v1.78b + v1.79b)이지만 사용자 발의로 진입

## 목표

- [ ] **H1**: `tests/CLAUDE.md`에 §"Pre-commit hook entry 정책" 섹션 추가 (wrapper vs direct 기준 + 현행 4 hook 현황표)
- [ ] **H2**: `ROADMAP.md` §3-E `v1.79c` 항목 trigger 이행 완료 처리 (§8 최근 완료로 이동)

## 변경 대상

| 파일 | 변경 내용 |
|------|---------|
| `tests/CLAUDE.md` | §"Pre-commit hook entry 정책" 새 섹션 추가 (§"Pre-commit 통합" 이후) |
| `sessions/meta/ROADMAP.md` | §3-E v1.79c row 제거 + §8 최근 완료 entry 추가 |
| `sessions/meta/v1.80-*/PLAN.md` | 본 파일 |
| `sessions/meta/v1.80-*/REPORT.md` | 세션 종료 시 |

## 성공 기준

- [ ] `tests/CLAUDE.md`에 wrapper vs direct 기준 섹션 존재
- [ ] 현행 4 hook 현황표 (smoke 이름 / --fix 지원 여부 / entry 형식) 포함
- [ ] smoke 회귀 0: `pre-commit run smoke-claude-md-drift --all-files` PASS (count 정합)
- [ ] `tests/CLAUDE.md` smoke count 표기 변경 없음 (27 유지, 새 smoke 추가 없음)

## 커밋 전략

단일 커밋 (docs-only, trivial scope):

```
docs(meta): sessions/meta/v1.80-precommit-hook-entry-policy — pre-commit hook entry 기준 명문화
```

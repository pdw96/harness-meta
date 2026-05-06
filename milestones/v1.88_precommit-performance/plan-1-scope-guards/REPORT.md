# plan-1 REPORT — scope-guards

## 목표 vs 결과

- [x] `.pre-commit-config.yaml` 4 local hook의 `always_run: true` 제거
- [x] 각 hook에 의미론적 `files:` 패턴 추가 (4 hook 모두)
- [x] `tests/CLAUDE.md` hook 현황표 갱신 (v1.80 → v1.88 기준 + `files:` 컬럼)

## 구현 요약

| phase | commit | 변경 파일 | 핵심 변화 |
|-------|--------|---------|---------|
| 1 | `624379c` | `.pre-commit-config.yaml` (+ milestone PLAN docs 신규) | 4 hook `always_run: true` → `files:` 패턴 |
| 2 | `f88ab51` | `tests/CLAUDE.md` | 현황표 v1.80 → v1.88 + `files:` 컬럼 추가 |

## files: 패턴 검증 (실측)

phase-1 commit (4 staged files: `.pre-commit-config.yaml` + 2 milestone PLAN.md):

| hook | 결과 | 근거 |
|------|------|------|
| smoke-spec-verification | **PASSED** | `milestones/v1.88_*/PLAN.md` 매칭 |
| smoke-scope-contract | **SKIPPED (no files to check)** | sessions/OWNERSHIP/harness-meta.md 미매칭 ✅ |
| smoke-cross-ref | PASSED | `\.md$` 매칭 |
| smoke-claude-md-drift | **SKIPPED (no files to check)** | CLAUDE.md/smoke-*.sh 미매칭 ✅ |

phase-2 commit (1 staged file: `tests/CLAUDE.md`):

| hook | 결과 | 근거 |
|------|------|------|
| smoke-spec-verification | **SKIPPED** | sessions/milestones .md 미매칭 ✅ |
| smoke-scope-contract | **SKIPPED** | sessions/OWNERSHIP/harness-meta.md 미매칭 ✅ |
| smoke-cross-ref | PASSED | `\.md$` 매칭 |
| smoke-claude-md-drift | PASSED | `CLAUDE\.md$` 매칭 |

→ shell/python/yaml-only 커밋 시 4 smoke 모두 SKIP 예측 가능 (선험 검증).

## 변경 파일

- `.pre-commit-config.yaml` (4 hook entry)
- `tests/CLAUDE.md` (§"현행 4 hook 현황")

## 의존성

- 선행 PLAN: 없음
- 후행 PLAN: 없음 (milestone 유일 plan)

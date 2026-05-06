# plan-1 PLAN — scope-guards

## 목표

- [ ] `.pre-commit-config.yaml` 4 local hook의 `always_run: true` 제거
- [ ] 각 hook에 의미론적 `files:` 패턴 추가 (hook 목적에 맞는 파일 타입만 trigger)
- [ ] `tests/CLAUDE.md` hook 현황표에 `files:` 정보 추가 (운영 docs 갱신)

## Phase 매트릭스

| phase | 변경 파일 | commit 메시지 |
|-------|---------|-------------|
| 1 | `.pre-commit-config.yaml` | `chore(meta): v1.88 plan-1 phase-1 — pre-commit local hook files: 가드 추가` |
| 2 | `tests/CLAUDE.md` | `docs(meta): v1.88 plan-1 phase-2 — hook 현황표 files: 패턴 반영` |

## files: 패턴 설계

| hook id | `files:` 패턴 | 근거 |
|---------|------------|------|
| `smoke-spec-verification` | `sessions/.*\.md$\|milestones/.*\.md$` | session/milestone PLAN·REPORT 변경 시만 관련 |
| `smoke-scope-contract` | `sessions/.*\.md$\|bootstrap/docs/OWNERSHIP\.md$\|claude/commands/harness-meta\.md$` | Stage 1(session PLAN) + Stage 2(OWNERSHIP.md) + Stage 3(harness-meta.md) 검사 대상 3종 모두 포함 |
| `smoke-cross-ref` | `\.md$` | 임의 .md 변경이 ref 깨뜨릴 수 있음 (단 living docs만 실스캔) |
| `smoke-claude-md-drift` | `CLAUDE\.md$\|tests/smoke-.*\.sh$` | CLAUDE.md 변경 or smoke 파일 수 변동 시 count drift 발생 |

> **[architecture review 반영]** smoke-scope-contract 초안 `sessions/.*\.md$` 만으로는
> Stage 2(`OWNERSHIP.md`)·Stage 3(`harness-meta.md`) 단독 변경 시 hook skip → false negative.
> 두 파일 명시 추가.
>
> smoke-spec-verification Stage 5(SKILL.md frontmatter 검사): `bootstrap/skills/.../SKILL.md`
> 변경 시 hook skip 가능하나, SKILL.md 수정 빈도 낮음 + 수동 검증 가능 → acceptable omission.

## 변경 파일

- `.pre-commit-config.yaml` (1 파일)
- `tests/CLAUDE.md` (1 파일)

## 성공 기준

- `git stash` 후 shell-only 파일 스테이징 → 4 smoke hook 미실행
- `pre-commit run --all-files` → 기존 PASS 동일 (회귀 없음)
- smoke-spec-verification PASS=608+ 유지

## 의존성

- 선행 PLAN: 없음 (milestone 첫 번째이자 유일한 plan)
- 후행 PLAN: 없음

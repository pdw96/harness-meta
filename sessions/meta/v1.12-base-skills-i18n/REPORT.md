# meta v1.12-base-skills-i18n — REPORT

세션 완료: 2026-04-28
선행 세션: [`sessions/meta/v1.11b-overlay-python-skill/`](../v1.11b-overlay-python-skill/REPORT.md)

## 최종 결과

- 수정 파일 16건 (세션 문서 제외)
- smoke 11/11 PASS (회귀 0)
- 한국어 잔존 0건 (`grep -r '이다\|합니다\|하는\|이후'` 0 hit)

## 구현 요약

| Stage | 파일 | 비고 |
|-------|------|------|
| A — skills | `harness/SKILL.md` | workflow table, safety gates, anti-patterns, lessons 영문화 |
| A — skills | `harness-review/SKILL.md` | 체크리스트 5항목 영문화 |
| A — skills | `harness-plan/SKILL.md` | 1~4단계, GSD Questioning, PLAN.md 생성 영문화 |
| A — skills | `harness-plan/plan-template.md` | 템플릿 영문화 |
| A — skills | `harness-design/SKILL.md` | 5~7단계, grey area, 7D, 파일 생성 영문화 |
| A — skills | `harness-design/7d-checklist.md` | 7차원 체크리스트 영문화 |
| A — skills | `harness-run/SKILL.md` | 8~9단계, UAT, 에러 복구 영문화 |
| A — skills | `harness-ship/SKILL.md` | 10단계, Goal-backward, commit/push 영문화 |
| A — skills | `harness-ship/report-template.md` | REPORT 템플릿 영문화 |
| B — agents | `harness-dispatcher.md` | 한국어 섹션 헤더 영문화 |
| B — agents | `harness-explore.md` | 한국어 섹션 헤더 + 탐색 차원 영문화 |
| B — agents | `harness-grey-area.md` | 분석 차원 + output 형식 영문화 |
| B — agents | `harness-verifier.md` | 섹션 헤더 영문화 |
| C — output-style | `harness-engineer.md` | 응답 원칙, 워크플로우, 의사결정 영문화 |
| D — python overlay | `harness-python/SKILL.md` | argument 표, §0~§5 전체 영문화 |
| D — python overlay | `python-quality.md` | §1~§4 표 전체 영문화 |

## PLAN 체크박스 판정

- [x] `_base/.claude/` 14 파일 body 영문화 완료
- [x] `python/.claude/skills/harness-python/` 2 파일 영문화 완료
- [x] frontmatter `name:` / `description:` 값 영문
- [x] 파일명 · 기술용어 · 명령어 · 경로 불변
- [x] `tests/smoke-language-overlay.sh` 11/11 PASS (회귀 0)
- [x] 한국어 잔존 0건

## Lessons Learned

- **L1 — agent 파일은 영문 body가 이미 존재** — dispatcher/explore/grey-area/verifier 4개는 영문 body + 한국어 섹션 헤더 혼합이었음. description/name 값 + 섹션 헤더만 전환으로 완료
- **L2 — skill body는 전체 재작성** — harness/harness-plan/harness-design/harness-run/harness-ship 5개 skill은 한국어 body 전체를 영어로 재작성. 의미 보존 + 기술 용어 그대로 유지
- **L3 — template 파일은 placeholder 영문화 핵심** — plan-template.md, report-template.md의 placeholder 설명 텍스트(주석, 예시 값)도 영문화

## 후속

- upbit `.claude/` 재설치: `bash ~/harness-meta/bootstrap/install-project-claude.sh ~/upbit --force` (영문화 파일 배포)
- v1.13: README + AGENTS.md 오픈소스 진입점 작성
- v1.14: Bootstrap 흐름 단순화 (10 stages → 간결화)

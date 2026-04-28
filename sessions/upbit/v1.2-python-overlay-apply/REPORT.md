# upbit v1.2-python-overlay-apply — REPORT

세션 완료: 2026-04-28
선행 세션 (meta): [`sessions/meta/v1.11b-overlay-python-skill/`](../../meta/v1.11b-overlay-python-skill/REPORT.md)

## 최종 결과

- `install-project-claude.sh --force` exit 0
- `harness-python/SKILL.md` + `python-quality.md` upbit 배포 완료
- 기존 6 skill + 4 agent + output-style 전체 유지 (회귀 0)
- backup: `upbit/.claude/backup-20260428-221323/`

## 구현 요약

| 단계 | 내용 |
|------|------|
| Phase 1 | 충돌 11건 backup → _base 11 항목 재복사 |
| Phase 2 | `language = "python"` 감지 → `skills/harness-python` overlay 복사 (1 항목) |

**설치 후 `upbit/.claude/skills/`**: harness / harness-design / harness-plan / **harness-python** (신규) / harness-review / harness-run / harness-ship (7건)

**upbit `.harness.toml` → `harness-python` 동작:**
- `package_manager = "poetry"` → SKILL.md §0이 `poetry run` prefix 자동 감지
- `type_check_cmd = "poetry run mypy bot/ config/ --strict"` → §3 type_check 단계 사용
- `lint_cmd = "poetry run ruff check bot/ config/"` → §3 lint 단계 사용

## PLAN 체크박스 판정

- [x] `install-project-claude.sh --force` exit 0
- [x] `upbit/.claude/skills/harness-python/SKILL.md` 존재
- [x] `upbit/.claude/skills/harness-python/python-quality.md` 존재
- [x] 기존 6 skill 정상 유지 (회귀 0)

## 후속

- upbit `.claude/` 변경사항 upbit repo에 커밋 (team share 필요 시)
- `harness-python` 실 동작 검증: upbit 세션에서 `/harness-python` 호출

# plan-1-milestone-exclusion — REPORT

**완료일**: 2026-05-07
**commit**: `724baf0`
**상태**: ✅ 완료

## 목표 체크박스

- [x] `_VER_MILE` regex 신규 (`^milestones/v\d+\.\d+[^/]*/.*\.md$`)
- [x] `_VER_SESS` `[^/]+\.md$` → `.*\.md$`
- [x] `should_exclude()` — `_VER_MILE` OR 조건 추가
- [x] smoke comment (헤더) 제외 목록 갱신
- [x] E2E: milestone fixture broken ref → PASS (제외 동작 확인)
- [x] E2E: living doc broken ref → FAIL (기존 동작 유지)
- [x] smoke 회귀 0 (cross-ref PASS=1 + scope-contract PASS=194 + spec-verification PASS=608)

## 구현 요약

`tests/smoke-cross-ref.sh` 4줄 변경:

1. **comment 갱신**: `sessions/**/v*-*/*.md` → `sessions/**/v*-*/**/*.md` + 신규 줄 `milestones/v*/**/*.md` (PLAN/REPORT/NOTES 명시)
2. **`_VER_SESS` 개선**: `[^/]+\.md$` → `.*\.md$` — sessions 서브디렉토리 depth 방어적 확장
3. **`_VER_MILE` 신규**: `^milestones/v\d+\.\d+[^/]*/.*\.md$` — milestone 버전 디렉토리 하위 모든 .md 제외
4. **`should_exclude()` 갱신**: `if _VER_SESS.match(rel):` → `if _VER_SESS.match(rel) or _VER_MILE.match(rel):`

## 변경 파일

| 파일 | 변경 |
|------|------|
| `tests/smoke-cross-ref.sh` | +4 -3 (regex 2 + should_exclude 1 + comment 1) |

## E2E 검증

| 시나리오 | 결과 |
|---------|------|
| `milestones/v1.86_.../plan-1-.../PLAN.md`에 broken ref 주입 | smoke PASS=1 (제외 동작 ✓) |
| `tests/CLAUDE.md`에 broken ref 주입 | smoke FAIL=1 (감지 동작 ✓) |
| fixture 제거 후 최종 실행 | PASS=1 FAIL=0 ✓ |

## Lessons Learned

- **L1 — markdownlint MD032**: `**근거**:` 뒤 bullet list에 blank line 필수. pre-commit 첫 commit에서 catch → 수정 후 새 commit으로 해결. 향후 bullet list 앞 blank line 의무 체크.
- **L2 — commit message heredoc**: Windows Git Bash에서 heredoc 사용 시 pre-commit 종료 대기 필요 (background task 패턴).

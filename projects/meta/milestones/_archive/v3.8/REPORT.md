# REPORT — v3.8 inactive-smoke-cd-path-fix

```json
{
  "summary": "v3.7 L1 후속 — tests/_inactive/ 이동 후 `$(dirname \"$0\")/..` 경로가 tests/ 로 잘못 해석되는 버그를 8개 파일에서 일괄 수정 (→ `../..`). 3 관점 검토 (architecture pass / spec-drift fail→흡수 / scope-contract pass) 후 단일 phase 1 commit (2e25eff). pre-commit 14 hook 모두 PASS, 대표 inactive smoke 2건 수동 실행 6/6 PASS. 추가로 tests/CLAUDE.md 에 inactive smoke 경로 규약 명문화 (spec-drift 권고 흡수).",
  "delta": {
    "files_changed": 9,
    "files_added": 6,
    "files_deleted": 0,
    "modules_affected": ["tests/_inactive/ (8 smoke)", "tests/CLAUDE.md (정책 문서)", "projects/meta/milestones/v3.8/ (신규 산출물 6종)"]
  },
  "lessons_learned": [
    "L1: _inactive/ 이동 시 cd dirname 경로 자동 수정 부재 — git mv 후 수동 검토 필요 (v3.6_overengineering-audit #4 권고 적용 시 이 단계가 누락됨). 향후 smoke git mv 시 dirname 경로 일괄 갱신을 checklist 에 포함 고려.",
    "L2: spec-drift 검토가 문서 정책 공백을 잡아냄 (tests/CLAUDE.md inactive smoke 경로 정책 미명시) — 3 관점 검토 중 가장 작은 변경이어도 검토 가치 있음."
  ]
}
```

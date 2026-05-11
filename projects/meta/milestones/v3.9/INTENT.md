# INTENT — v3.9 inactive-smoke-git-mv-checklist

```json
{
  "id": "v3.9",
  "title": "smoke git mv 시 dirname 경로 자동 갱신 절차 명문화",
  "goal": "smoke 파일을 git mv 로 다른 디렉토리로 이동할 때 `cd $(dirname \"$0\")/..` 식의 상대 경로가 자동으로 깨지는 현상을 방지하기 위해, 이동 후 필수 수행 체크리스트를 tests/CLAUDE.md 에 명문화한다.",
  "motivation": "v3.8 L1 — v3.6_overengineering-audit #4 권고(inactive smoke 22건 tests/_inactive/ git mv) 적용 시 dirname 경로 깊이 갱신 단계가 누락되어 v3.7/v3.8 두 milestone에 걸쳐 버그 발견 + 수정이 반복됨. 이동 절차에 체크리스트가 없어서 이 실수가 '예방 가능했으나 누락된' 범주임을 v3.8 L1이 명시함.",
  "success_criteria": [
    "tests/CLAUDE.md 에 smoke git mv 체크리스트 섹션(또는 기존 섹션 보강)이 추가되고, dirname 경로 갱신 단계가 명시됨",
    "체크리스트 내용이 v3.6 → v3.7 → v3.8 버그 흐름을 충분히 예방할 수 있는 수준 (최소: mv 후 dirname 경로 깊이 확인 + grep 검증 명령어 예시)",
    "pre-commit 14 hook 모두 PASS, 회귀 0"
  ],
  "out_of_scope": [
    "smoke 파일 내부 로직 변경",
    "현재 active/inactive smoke 파일 경로 재조정",
    "git mv 자동화 스크립트 개발"
  ],
  "dependencies": {
    "upstream": ["v3.8_inactive-smoke-cd-path-fix (completed — L1 source)"],
    "downstream": []
  }
}
```

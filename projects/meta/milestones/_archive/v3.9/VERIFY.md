# VERIFY — v3.9 inactive-smoke-git-mv-checklist

```json
{
  "smoke_tests": [
    {
      "name": "pre-commit run --all-files",
      "command": "pre-commit run --all-files",
      "result": "PASS",
      "output": "14 hook 모두 Passed (fix end of files / trim trailing whitespace / check merge conflicts / check yaml / check large files / shellcheck / markdownlint / smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift / smoke-bundle-trigger / smoke-open-stage-discipline)"
    }
  ],
  "manual_checks": [
    {
      "check": "tests/CLAUDE.md '회귀 검증 절차' 섹션 내 git mv 체크리스트 subsection 존재",
      "result": "PASS",
      "notes": "### smoke 파일 이동(git mv) 시 체크리스트 — 4단계 확인"
    },
    {
      "check": "경로 깊이 규범 재서술 금지 (cross-ref 처리 확인)",
      "result": "PASS",
      "notes": "체크리스트 첫 줄이 §'현행 hook 현황 — inactive smoke 경로 규약 (v3.8)' cross-ref로 처리. 규범 표현식 재서술 없음."
    },
    {
      "check": "commit 9587f52 — 8 files changed, 188 insertions, 1 deletion",
      "result": "PASS",
      "notes": "1 phase 1 commit 정합"
    }
  ],
  "criteria_check": [
    {
      "criterion": "tests/CLAUDE.md에 smoke git mv 체크리스트 섹션(또는 기존 섹션 보강)이 추가되고, dirname 경로 갱신 단계가 명시됨",
      "result": "PASS",
      "notes": "'### smoke 파일 이동(git mv) 시 체크리스트' subsection 신규 추가, 단계 1에 dirname 경로 깊이 갱신 명시"
    },
    {
      "criterion": "체크리스트 내용이 v3.6 → v3.7 → v3.8 버그 흐름을 충분히 예방할 수 있는 수준 (최소: mv 후 dirname 경로 깊이 확인 + grep 검증 명령어 예시)",
      "result": "PASS",
      "notes": "단계 1 (방향+깊이 확인) + 단계 2 (grep -n 'dirname' 검증 명령어 예시) 모두 포함"
    },
    {
      "criterion": "pre-commit 14 hook 모두 PASS, 회귀 0",
      "result": "PASS",
      "notes": "pre-commit run --all-files 14 hook Passed, 회귀 없음"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

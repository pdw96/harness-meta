# VERIFY — v3.8 inactive-smoke-cd-path-fix

```json
{
  "smoke_tests": [
    {
      "name": "pre-commit 14 hook 전체",
      "command": "git commit (pre-commit 자동 실행)",
      "result": "pass",
      "output": "14 hook 모두 Passed (commit 2e25eff)"
    },
    {
      "name": "bash -n syntax check (8개 파일)",
      "command": "for f in 8 files; do bash -n tests/_inactive/$f; done",
      "result": "pass",
      "output": "8/8 OK"
    },
    {
      "name": "smoke-detect-language.sh 수동 실행",
      "command": "bash tests/_inactive/smoke-detect-language.sh",
      "result": "pass",
      "output": "PASS: 6 / 6"
    },
    {
      "name": "smoke-roi-regression.sh 수동 실행",
      "command": "bash tests/_inactive/smoke-roi-regression.sh",
      "result": "pass",
      "output": "PASS: 6 / 6"
    },
    {
      "name": "잔존 dirname/.. 패턴 확인",
      "command": "grep -n 'dirname.*\\..' tests/_inactive/*.sh | grep -v '..\\..'",
      "result": "pass",
      "output": "(잔존 없음)"
    }
  ],
  "manual_checks": [
    {
      "check": "HARNESS_META_ROOT fallback 파일 13건 미수정 — out_of_scope 준수",
      "result": "pass",
      "notes": "13건 모두 HARNESS_META_ROOT/git rev-parse 패턴, dirname 버그 없음, 미수정 확인"
    },
    {
      "check": "tests/CLAUDE.md inactive smoke 경로 규약 추가",
      "result": "pass",
      "notes": "spec-drift 권고 흡수 — '**inactive smoke 경로 규약** (v3.8)' 단락 추가"
    }
  ],
  "criteria_check": [
    {
      "criterion": "tests/_inactive/ 내 모든 `$(dirname \"$0\")/..` 패턴이 `../..` 로 수정됨",
      "result": "pass",
      "notes": "8개 파일 수정, 잔존 패턴 0"
    },
    {
      "criterion": "수정 대상 8개 파일 각각 bash -n PASS",
      "result": "pass",
      "notes": "8/8"
    },
    {
      "criterion": "active smoke (pre-commit 14 hook) 회귀 0건",
      "result": "pass",
      "notes": "commit 2e25eff — 14 hook 모두 Passed"
    },
    {
      "criterion": "smoke-open-stage-discipline.sh PASS",
      "result": "pass",
      "notes": "pre-commit 14 hook 안 포함 — milestones.md 존재 확인"
    },
    {
      "criterion": "inactive smoke 수동 실행 시 cd 경로 오류 제거 (대표 2건)",
      "result": "pass",
      "notes": "smoke-detect-language 6/6 + smoke-roi-regression 6/6"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

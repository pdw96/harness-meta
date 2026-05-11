# VERIFY — v3.7 smoke-posttooluse-9stage-tests

```json
{
  "version": "v3.7",
  "smoke_tests": [
    {
      "name": "smoke-posttooluse-hook.sh",
      "command": "bash tests/_inactive/smoke-posttooluse-hook.sh",
      "result": "PASS",
      "output": "Stage 1 (3) PASS + Stage 2 (22) PASS — 총 25/25 PASS. Tests T/U/V 신규 포함."
    },
    {
      "name": "pre-commit --all-files",
      "command": "pre-commit run --all-files",
      "result": "PASS",
      "output": "14 hooks all PASS (030e68e 커밋 시 자동 실행)"
    }
  ],
  "manual_checks": [
    {
      "check": "Tests A~S 회귀 0 확인",
      "result": "PASS",
      "notes": "smoke 실행 결과 A~S 전부 ✓"
    },
    {
      "check": "_inactive/ 위치 유지",
      "result": "PASS",
      "notes": "smoke 파일 위치 tests/_inactive/smoke-posttooluse-hook.sh 그대로"
    }
  ],
  "criteria_check": [
    {
      "criterion": "smoke T: Write + INTENT.md → additionalContext에 '다음: RESEARCH' 키워드 포함 확인",
      "result": "PASS"
    },
    {
      "criterion": "smoke U: Write + APPROVE.md → additionalContext에 'EXECUTE' 키워드 포함 확인",
      "result": "PASS"
    },
    {
      "criterion": "smoke V: Write + PROPOSE.md → additionalContext에 'next_candidates' 키워드 포함 확인",
      "result": "PASS"
    },
    {
      "criterion": "기존 tests A~S 회귀 0",
      "result": "PASS"
    },
    {
      "criterion": "smoke 파일은 tests/_inactive/ 위치 유지 (v3.6 archive 정책 준수)",
      "result": "PASS"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

# VERIFY — v3.16 changelog-unreleased-position-cleanup

```json
{
  "smoke_tests": [
    {
      "name": "pre-commit run --all-files (phase-1 commit 직전)",
      "command": "pre-commit run --all-files",
      "result": "PASS",
      "output": "14 hook 모두 PASS (end-of-file-fixer 1회 auto-fix 후 재실행 PASS). markdownlint PASS."
    }
  ],
  "manual_checks": [
    {
      "check": "[Unreleased] 섹션 위치 최상단 확인",
      "result": "PASS",
      "notes": "CHANGELOG.md L9 — 헤더(L1~L8) 직후, [v3.15] 위. Keep a Changelog 권장 정합."
    },
    {
      "check": "[Unreleased] 섹션 빈 섹션 확인",
      "result": "PASS",
      "notes": "L9 ## [Unreleased] 바로 다음 L10 blank, L11 ## [v3.15] — 내용 없음."
    },
    {
      "check": "[v3.15] entry 추가 확인",
      "result": "PASS",
      "notes": "L11 ## [v3.15] - 2026-05-13 + Added 섹션 backfill 완료 내용 포함."
    },
    {
      "check": "v1.0~v1.4 entry 5 항목 흡수 확인",
      "result": "PASS",
      "notes": "L299~L303 — 5 항목 (ci.yml / pre-commit / GUARDRAILS / .env.example / CHANGELOG) v1.0~v1.4 Added 섹션 흡수 완료."
    },
    {
      "check": "구 [Unreleased] 섹션(L190) 제거 확인",
      "result": "PASS",
      "notes": "[v2.0] entry 다음은 [v1.14] entry로 직결. 구 [Unreleased] 위치 섹션 없음."
    }
  ],
  "criteria_check": [
    {
      "criterion": "CHANGELOG.md 에서 [Unreleased] 섹션이 파일 헤더(L1~L8) 직후, 최신 versioned entry([v3.15]) 위에 위치한다",
      "result": "PASS",
      "evidence": "L9 ## [Unreleased], L11 ## [v3.15] — 순서 정합."
    },
    {
      "criterion": "[Unreleased] 내 5개 항목이 v1.0~v1.4 entry로 흡수되고 [Unreleased]가 빈 섹션으로 유지된다",
      "result": "PASS",
      "evidence": "v1.0~v1.4 Added에 5 항목 흡수. [Unreleased] L9 빈 섹션."
    },
    {
      "criterion": "[v3.15] entry 가 CHANGELOG.md 에 추가된다",
      "result": "PASS",
      "evidence": "L11 ## [v3.15] - 2026-05-13 Added 섹션 포함."
    },
    {
      "criterion": "Keep a Changelog v1.1.0 형식 정합 유지",
      "result": "PASS",
      "evidence": "역순 버전 보존. BREAKING ! 마커 [v3.0] / [v2.0] / [v1.8] 보존. 헤더 L1~L8 보존. markdownlint PASS."
    },
    {
      "criterion": "pre-commit 14 hook 모두 PASS, 회귀 0",
      "result": "PASS",
      "evidence": "pre-commit run --all-files 2회 실행 (1회 auto-fix, 2회 full PASS). commit hook PASS."
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

# VERIFY — v3.12 deprecated-skill-narrative-cleanup

```json
{
  "smoke_tests": [
    {
      "name": "pre-commit 14 hook 전체",
      "command": "git commit (pre-commit 자동 실행)",
      "result": "PASS",
      "output": "14 hook 모두 Passed (commit 446485b)"
    }
  ],
  "manual_checks": [
    {
      "check": "harness-plan-verify/SKILL.md sessions/ grep",
      "result": "PASS",
      "notes": "0건 확인"
    },
    {
      "check": "harness-roadmap-update/SKILL.md sessions/ 잔존 라인 확인",
      "result": "PASS",
      "notes": "잔존 6건 모두 DEPRECATED 블록 내 역사적 서술(L31, L37) + 본문 코드 예시(L44/L55/L59/L72) — historical 보존 의도 라인으로 INTENT success_criteria 제외 조건 충족"
    },
    {
      "check": "harness-roadmap-update/SKILL.md frontmatter allowed-tools 갱신",
      "result": "PASS",
      "notes": "Edit(sessions/meta/ROADMAP.md) → Edit(projects/meta/ROADMAP.md), Write(sessions/meta/ROADMAP.md) → Write(projects/meta/ROADMAP.md)"
    },
    {
      "check": "harness-roadmap-update/SKILL.md description L4 갱신",
      "result": "PASS",
      "notes": "sessions/meta/ROADMAP.md → projects/meta/ROADMAP.md"
    },
    {
      "check": "harness-plan-verify/SKILL.md description L4-5 갱신",
      "result": "PASS",
      "notes": "sessions/meta/**/PLAN.md → projects/meta/milestones/v{X.Y}/DESIGN.md"
    },
    {
      "check": "harness-plan-verify/SKILL.md 적용 대상 L27-28 갱신",
      "result": "PASS",
      "notes": "sessions/ → projects/ 현행 경로"
    },
    {
      "check": "harness-plan-verify/SKILL.md 관련 문서 L165-166 제거",
      "result": "PASS",
      "notes": "historical 세션 경로 2건 제거 완료"
    }
  ],
  "criteria_check": [
    {
      "criterion": "harness-plan-verify/SKILL.md sessions/ 거명 라인 교체 또는 제거",
      "result": "PASS",
      "notes": "6건 전부 교체 또는 제거 (grep 0건)"
    },
    {
      "criterion": "harness-roadmap-update/SKILL.md sessions/ 거명 라인 현행 표현 또는 DEPRECATED 문맥 정합으로 갱신",
      "result": "PASS",
      "notes": "대상 3건(L4/L22/L24) 모두 교체. 나머지 sessions/ 거명은 DEPRECATED 블록 내 역사적 서술 — 보존"
    },
    {
      "criterion": "smoke 14 hook 모두 PASS, 회귀 0",
      "result": "PASS",
      "notes": "commit 446485b pre-commit 14 hook 전부 Passed"
    },
    {
      "criterion": "두 파일에서 sessions/ grep 0건 (historical 보존 의도 라인 제외)",
      "result": "PASS",
      "notes": "harness-plan-verify 0건. harness-roadmap-update 잔존은 historical 보존 의도 라인 전부"
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

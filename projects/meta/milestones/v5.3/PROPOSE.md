---
id: milestone-v5.3-propose
title: PROPOSE v5.3
version: v5.3
stage: PROPOSE
status: completed
---

# PROPOSE — v5.3 external-marketplace-registration

## Spec

```json
{
  "next_candidates": [
    {
      "id": "v5.x_marketplace-json-github-source",
      "title": "marketplace.json plugin entry source 를 GitHub source 객체로 명시 전환 (optional 품질 개선)",
      "trigger": "A_user — 사용자 명시 발의 시만. 현 './' 는 GitHub shorthand 에서 작동 확인, 기능 불가 아님",
      "trigger_type": "optional"
    },
    {
      "id": "v5.x_readme-github-actions-badge",
      "title": "README.md CI 배지 + 외부 방문자 first-impression 개선 (GitHub public repo 기반)",
      "trigger": "A_user — 사용자 명시 발의 시",
      "trigger_type": "optional"
    }
  ]
}
```

## PROPOSE summary

v5.3 완료로 외부 방문자 onboarding 경로 (GitHub shorthand 2-step) 추가. 후속 candidates 는 기능 필수 아님 — 사용자 명시 발의 시만 진행 권고 (§ 6.2 동결 정합).

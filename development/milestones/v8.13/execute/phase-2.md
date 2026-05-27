---
phase: phase-2
milestone: v8.13
status: completed
---

# v8.13 phase-2 — release-publish.yml LIGHTWEIGHT.md fallback 분기

## Spec

```json
{
  "phase": "phase-2",
  "status": "completed",
  "scope": "release-publish.yml 에 가벼운 흐름 LIGHTWEIGHT.md fallback 분기 3곳 추가 (d_3) — MILESTONE.md 부재 시 LIGHTWEIGHT.md 사용. design-review spec-drift decisive(line 170~173 title 추출 세 번째 의존) 흡수.",
  "changes": [
    {
      "type": "edit",
      "path": ".github/workflows/release-publish.yml",
      "description": "(1) Locate step: MILESTONE.md 우선 → 부재 시 LIGHTWEIGHT.md fallback, path/track/section 3 output 산출 (9-stage='## REPORT' / lightweight='## 기록'). (2) Extract step: 하드코딩 awk 를 범용 awk -v sec (섹션 시작 ~ 다음 '^## ' 또는 EOF) 로 — 9-stage ## REPORT→## PROPOSE, lightweight ## 기록→EOF 양쪽 cover. body header 도 track/section 동적. (3) Create Release step: title 추출 하드코딩 MILESTONE_PATH 를 steps.milestone.outputs.path 로 치환 (MILESTONE.md/LIGHTWEIGHT.md frontmatter title 공통)."
    }
  ],
  "verification": [
    {
      "method": "manual",
      "result": "PASS",
      "detail": "python yaml.safe_load PASS (yaml OK). 로컬 awk 시뮬레이션 — lightweight v8.2 ## 기록 6줄 EOF 종료 추출 / 9-stage v8.8 ## REPORT 28줄 ## PROPOSE 종료 추출 / title fallback v8.2 LIGHTWEIGHT frontmatter='RESEARCH cascade host grep 3 형식 규율 보강' 추출. 3 step 모두 두 트랙 정상."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): [v8.13] phase-2 release-publish.yml 가벼운 흐름 LIGHTWEIGHT.md fallback 분기"
  }
}
```

## Narrative

phase-2 는 d_3 의 LIGHTWEIGHT.md fallback 을 워크플로우 3 step 에 구현했다. design-review spec-drift FAIL 의 핵심 — 초안이 Locate/Extract 2 step 만 fallback 으로 봤으나 Create Release step(구 line 170~173)이 title 추출에 `MILESTONE_PATH` 를 별도 재하드코딩해 가벼운 흐름에서 title 추출이 실패/pipefail 할 위험을 흡수했다. 이 step 의 awk 대상을 Locate output(`steps.milestone.outputs.path`)으로 통일해 세 번째 의존을 제거했다.

Extract step 의 범용 awk (`$0 ~ "^"sec {flag=1; next} /^## /{flag=0} flag`)가 두 트랙을 동시에 cover 하는 것이 핵심 — 9-stage 는 `## REPORT` 가 다음 H2 `## PROPOSE` 에서 종료, 가벼운 흐름은 `## 기록` 이 마지막 H2 라 다음 H2 (`/^## /`) 부재로 EOF 까지 자연 추출된다. 로컬 시뮬레이션으로 양쪽 + title fallback 정상 확인. 실 발행(workflow_dispatch)은 본 워크플로우가 main 에 push 된 후 phase-3 에서 검증.

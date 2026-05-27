---
phase: phase-4
milestone: v8.13
status: completed
---

# v8.13 phase-4 — milestones[] trim + 재발방지 smoke 신설

## Spec

```json
{
  "phase": "phase-4",
  "status": "completed",
  "scope": "development/ROADMAP.md milestones[] trim (16 completed → recent 3, d_5) + 재발방지 smoke 신설 (tests/smoke-roadmap-archival.sh, d_6) + pre-commit 등재. trim 선행 → smoke 가 PASS 상태 (risk_2 chicken-egg 회피).",
  "changes": [
    {
      "type": "edit",
      "path": "development/ROADMAP.md",
      "description": "milestones[] 안 v8.9~v6.23 completed 13건 제거 (publish-then-trim — phase-3 발행 후). 잔존 = v8.13(in_progress) + v8.12/v8.11/v8.10(recent 3 completed). v8.13 entry summary '6건→10건' 정정 (RESEARCH ext_2). updated 필드 갱신. 잘라낸 13건 trace = GitHub Release + REPORT.md/LIGHTWEIGHT.md + git log 3중 보존."
    },
    {
      "type": "create",
      "path": "tests/smoke-roadmap-archival.sh",
      "description": "development/ROADMAP.md milestones[] completed ≤ 3 강제 smoke. scope = development/ROADMAP.md 만 (사용자 결정 — upbit ROADMAP completed 21건이라 전체 적용 시 즉시 FAIL, upbit 는 포인터 인덱스라 제외). status=='completed' 정확 매칭 (in_progress/deferred 제외, risk_3). python3 부재 SKIP + SIZE_LIMIT 100KB."
    },
    {
      "type": "create",
      "path": "tests/fixtures/roadmap-archival/{normal-3,violation-4}.md",
      "description": "controlled 비교 fixture 2 — normal-3(completed 3, expected PASS) + violation-4(completed 4, expected FAIL). sc_4 위반 실증."
    },
    {
      "type": "edit",
      "path": ".pre-commit-config.yaml + tests/CLAUDE.md",
      "description": "pre-commit hook 등재 (direct entry, files=development/ROADMAP.md + smoke + fixtures) + smoke 매트릭스 row 추가 + count 13→14 + hook count 12→13 갱신 (smoke-claude-md-drift S4 정합)."
    }
  ],
  "verification": [
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "smoke-roadmap-archival — Stage 1 development/ROADMAP.md completed 3 (v8.12/v8.11/v8.10) ≤ 3 PASS + Stage 2 fixture normal-3 PASS / violation-4 FAIL 실증 (sc_4). smoke-claude-md-drift S4 count 14 정합."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): [v8.13] phase-4 milestones[] trim 16→3 + 재발방지 smoke-roadmap-archival 신설"
  }
}
```

## Narrative

phase-4 는 publish-then-trim 순서(risk_1)의 후행 — phase-3 발행 10건 완료 후 milestones[] 를 16 completed → recent 3 (v8.12/v8.11/v8.10) 으로 trim 했다. 잘라낸 13건은 GitHub Release(phase-3 발행) + REPORT.md/LIGHTWEIGHT.md + git log 3중 보존이라 forward 가시성 손실 0.

재발방지 smoke (d_6) 는 RESEARCH risk_5 가 실측으로 드러나 **scope 가 DESIGN d_6 의 '전체 ROADMAP' 에서 'development/ROADMAP.md 만' 으로 좁혀졌다** — upbit ROADMAP 가 completed 21건이라 전체 적용 시 즉시 FAIL 하고, recent-3 + GitHub Releases archival 은 harness-meta 고유 메커니즘(upbit 는 upbit repo milestone 포인터 인덱스, trace 는 upbit repo)이기 때문. 사용자 명시 결정 + oos_2('외부 project ROADMAP 별 트랙') 정합. risk_2(chicken-egg) mitigation = trim 선행 → smoke 가 completed 3 상태에서 PASS. sc_4 위반 실증 = fixture violation-4 → FAIL 검출.

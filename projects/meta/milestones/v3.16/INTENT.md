# INTENT — v3.16 changelog-unreleased-position-cleanup

```json
{
  "id": "v3.16",
  "slug": "changelog-unreleased-position-cleanup",
  "title": "CHANGELOG.md [Unreleased] 섹션 Keep a Changelog 권장 위치(최상단) 정합화",
  "goal": "CHANGELOG.md 의 [Unreleased] 섹션을 Keep a Changelog v1.1.0 권장 위치(최신 versioned entry 바로 위, 헤더 직후)로 이동하고, 섹션 내 5개 항목을 적절한 versioned entry로 흡수하여 외부 visible artifact 정합성을 회복한다.",
  "motivation": "v3.15_changelog-v3-backfill (2026-05-13) 에서 [Unreleased] 섹션이 [v2.0] 아래(L190)에 위치하는 Keep a Changelog 위반을 DESIGN D2로 발견했으나 scope 외 보존 결정(L2). [Unreleased] 내 5개 항목은 초기 infra 작업(CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG 자체)으로 v1.x 범위에 해당하며 현재 위치는 독자에게 미완료 기능 오해를 유발할 수 있다.",
  "success_criteria": [
    "CHANGELOG.md 에서 [Unreleased] 섹션이 파일 헤더(L1~L8) 직후, 최신 versioned entry([v3.15] 또는 [v3.16]) 위에 위치한다",
    "[Unreleased] 내 5개 항목이 적절한 versioned entry(v1.x 또는 v2.0)로 이동되거나, [Unreleased]가 빈 섹션으로 유지된다",
    "[v3.15] entry 가 CHANGELOG.md 에 추가된다 (v3.15 milestone 완료 기록)",
    "Keep a Changelog v1.1.0 형식 정합 유지 (역순 버전, BREAKING ! 마커, 헤더 보존)",
    "pre-commit 14 hook 모두 PASS, 회귀 0"
  ],
  "out_of_scope": [
    "CHANGELOG.md 이외 파일 변경",
    "workflow / smoke / hook 코드 변경",
    "[Unreleased] 항목 이외의 기존 versioned entry 내용 수정",
    "v3.17+ 후속 milestone 등재"
  ],
  "dependencies": {
    "predecessor": "v3.15_changelog-v3-backfill (2026-05-13 완료) — [Unreleased] 위치 보존 결정의 origin milestone",
    "successor": null
  }
}
```

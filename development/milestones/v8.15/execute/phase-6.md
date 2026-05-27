---
phase: phase-6
milestone: v8.15
status: completed
---

# v8.15 phase-6 — 잔존·inactive drift 정합

## Spec

```json
{
  "phase": "phase-6",
  "status": "completed",
  "scope": "본 milestone 자체 작업 — (a) tests/CLAUDE.md 하단 hook 현황 narrative 13→15 정합 + (b) tests/_inactive/ scorer smoke 4건 stale 경로 치환",
  "changes": [
    {
      "type": "edit",
      "path": "tests/CLAUDE.md",
      "description": "하단 '현행 hook 현황' 표 정합: (1) 헤더 additive sum 에 v8.15 2 hook (smoke-workflow-registration + smoke-plugin-manifest) 추가 + '총 13 → 15 hook active', (2) 상세 표에 3 row 추가 — smoke-agent-frontmatter-schema (pre-existing 누락 = narrative 는 count 했으나 표 row 부재) + smoke-workflow-registration + smoke-plugin-manifest, (3) line 260 'pre-commit 재검증 14 hook → 15 smoke hook', (4) Archive 단락 'active 7 → active 16 (pre-commit 강제 15 + manual 1)' (v3.6 era stale count 정합, line 9 표현 일관)"
    },
    {
      "type": "edit",
      "path": "tests/_inactive/smoke-roi-regression.sh",
      "description": "SCORER_DIR 경로 bootstrap/skills/audit/ai-ready-scorer/scripts → skills/ai-ready-scorer/scripts (scorer 이전 정합)"
    },
    {
      "type": "edit",
      "path": "tests/_inactive/smoke-detect-language.sh",
      "description": "UTILS + SCORER_DIR 경로 2건 치환 (동일)"
    },
    {
      "type": "edit",
      "path": "tests/_inactive/smoke-scorer-output-newline.sh",
      "description": "SCORER_DIR 경로 치환 ($ROOT/ prefix 보존)"
    },
    {
      "type": "edit",
      "path": "tests/_inactive/smoke-agentic-safety-na.sh",
      "description": "SCORER + RUBRIC 경로 2건 치환 (scripts + references/rubric.md)"
    }
  ],
  "verification": [
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "4 inactive scorer smoke 각각 rc=0 — smoke-roi-regression, smoke-detect-language, smoke-scorer-output-newline (5 PASS/0 FAIL), smoke-agentic-safety-na (5 PASS/0 FAIL). bootstrap/skills/audit/ 참조 grep 0건 (risk_2 mitigation)."
    },
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "smoke-claude-md-drift.sh 13/13 PASS (smoke count 정합 16=16) + smoke-cross-ref.sh PASS (broken ref 0). 하단 표 정합이 drift 재발 없음 (risk_3 mitigation)."
    },
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "전체 active 15 smoke 0 FAIL 실측 (sc_3)."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "fix(meta): [v8.15] phase-6 hook 현황 표 13→15 정합 + inactive scorer smoke 경로 치환 [release:v8.15]"
  }
}
```

## Narrative

phase-6 는 본 milestone 의 유일한 실작업 phase (phase-1~5 는 dedf1b2 retroactive). 실행 중 발견: tests/CLAUDE.md 하단 표가 d_4 가정(13→15, 2 row 추가)보다 1 row 더 어긋나 있었다 — narrative additive sum 은 smoke-agent-frontmatter-schema (v6.20) 를 count 했으나 상세 표에 해당 row 가 부재(pre-existing gap). 표를 실제 15 로 정직하게 맞추기 위해 3 row(agent-frontmatter-schema + 신규 2건)를 추가했다. 더해 line 260 '14 hook' + Archive 단락 'active 7' 두 stale count 도 같은 narrative 정합 범위로 갱신(line 9 표현과 일관).

inactive scorer smoke 4건은 경로 치환만으로 전부 복구(risk_2 — 경로 외 잔존 stale 참조 0 확인, 4건 rc=0). tests/_inactive/smoke-skills-install.sh 도 같은 옛 경로를 참조하나 이는 scorer logic 검증이 아닌 v4.x symlink install 메커니즘(deprecated since v5.0) 검증이라 phase-6 scope 밖 — SCOPE_OUT_NOTES 거명. 커밋은 CLAUDE.md '커밋 전 사용자 확인' 정합으로 사용자 재확인 후 진행 (sha pending).

# EXECUTE — phase 3

```json
{
  "milestone": "v1.0_workflow-redesign",
  "phase": 3,
  "title": "claude/commands/harness-meta.md 7-stage 흐름으로 재작성 + execute 파일 패턴 변경 ({n}phase → phase-{n})",
  "status": "complete",
  "changes": [
    {
      "file": "claude/commands/harness-meta.md",
      "action": "edit",
      "description": "rewrite — 4-tier 흐름 → 7-stage 흐름 (ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT). Bootstrap 모드 폐기 (첫 milestone EXECUTE에서 처리). Stage A~G 신설. AskUserQuestion 자동 invoke 매트릭스 갱신. 5 관점 병렬 검토 패턴 유지. 금지 항목 갱신 (4-tier 신규 작성 금지)."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/execute/1phase.md → execute/phase-1.md",
      "action": "edit",
      "description": "git mv 로 rename — execute/{n}phase.md → execute/phase-{n}.md 패턴 통일."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/{PLAN,RESEARCH,DESIGN}.md",
      "action": "edit",
      "description": "execute/{n}phase.md 또는 execute/1phase.md 텍스트 ref 모두 execute/phase-{n}.md / execute/phase-1.md로 갱신."
    },
    {
      "file": "CLAUDE.md, AGENTS.md",
      "action": "edit",
      "description": "execute/{n}phase.md → execute/phase-{n}.md ref 갱신."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/execute/phase-2.md",
      "action": "create",
      "description": "phase-2 retrospective 기록 (phase-1에서 누락 → phase-3 commit에 합류)."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/execute/phase-3.md",
      "action": "create",
      "description": "본 phase 실행 기록."
    }
  ],
  "commit": "feat(meta): v1.0 phase-3 — harness-meta.md 7-stage rewrite + execute 파일 패턴 phase-{n}.md + retro phase-2",
  "execution_notes": [
    "phase-{n}.md 패턴 통일 (사용자 요청 — 정렬 정합 + 가독성).",
    "harness-meta.md 7-stage 재작성 — 기존 263 라인에서 핵심 흐름만 유지하며 정리. bootstrap 모드 절차 8-stage 표는 'EXECUTE phase에서 처리' 1줄로 축소.",
    "phase-2 retro 누락은 향후 DESIGN.phases[n].affected_files에 execute/phase-{n}.md 명시 의무화로 차단 필요 (lesson learned)."
  ]
}
```

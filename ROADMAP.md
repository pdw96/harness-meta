# ROADMAP — harness-meta

```json
{
  "project": "harness-meta",
  "updated": "2026-05-08",
  "milestones": [
    {
      "id": "v1.1_smoke-precommit-rewrite",
      "title": "smoke + .pre-commit hook 4종 재작성 (새 7-stage 포맷 정합)",
      "status": "pending",
      "summary": "v1.0_workflow-redesign 후속 — disabled smoke-spec-verification / scope-contract / cross-ref / claude-md-drift을 새 JSON 포맷에 맞게 재작성. tests/CLAUDE.md 갱신 동반. 새 검증: PLAN/RESEARCH/DESIGN/VERIFY/REPORT JSON schema 정합 + execute/phase-{n}.md 명명 + DESIGN.approval 검증.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_post-report-write-hook-update",
      "title": "claude/hooks/post-report-write.sh 패턴 갱신",
      "status": "pending",
      "summary": "기존 sessions/.*/REPORT.(md|ipynb)$ 패턴 → milestones/v.*/(PLAN|RESEARCH|DESIGN|VERIFY|REPORT|execute/.*).md$ 패턴. 현재 silent NOOP 상태 — 갱신 시 REPORT 작성 감지 시 SKILL invoke 안내 동작 복원.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_upbit-cross-ref-cleanup",
      "title": "upbit repo 측 cross-ref 정리",
      "status": "pending",
      "summary": "upbit repo에서 폐기된 sessions/meta/ROADMAP.md / bootstrap/docs/* 참조 정리. upbit repo 자체 milestone으로 진행.",
      "trigger": "A_user"
    },
    {
      "id": "v1.1_design-phases-execute-tracking-automation",
      "title": "DESIGN.phases[n] execute/phase-{n}.md 자동 트래킹",
      "status": "pending",
      "summary": "DESIGN.phases[n].affected_files에 execute/phase-{n}.md 자동 등록. phase 시작 시 status: in_progress, 끝에 complete 자동 업데이트. v1.0 milestone phase-2 retro 누락 lesson 정합.",
      "trigger": "D_design"
    },
    {
      "id": "v1.0_workflow-redesign",
      "title": "7-stage workflow redesign — single-responsibility pipeline",
      "status": "completed",
      "summary": "기존 4-tier sessions/milestones 구조를 새 7-stage JSON-schema 기반 흐름(ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT)으로 완전 교체. 6 phase 분할 commit. ~370 파일 정리 + 12 신규. 회귀 0. 2026-05-08.",
      "trigger": null
    }
  ]
}
```

## 관련 문서

- 활성 milestone: [`milestones/v1.0_workflow-redesign/`](milestones/v1.0_workflow-redesign/) (completed, REPORT 참조)
- 워크플로우 진입점: [`/harness-meta` slash command](claude/commands/harness-meta.md)
- Historical (4-tier 포맷, v1.84~v1.88): `milestones/v1.84_*` ~ `milestones/v1.88_*` (참조용 이력 보존)

# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-08",
  "milestones": [
    {
      "id": "v1.1_meta-as-project",
      "title": "meta repo를 projects/meta/로 이관 — 모든 project 동형 구조 강제",
      "status": "in_progress",
      "summary": "root ROADMAP/milestones를 projects/meta/ 하위로 이관 + ARCHITECTURE.md 신규 + root ROADMAP은 thin index 화. /harness-meta 경로 resolution 갱신 + misclassified v1.1_upbit-cross-ref-cleanup 정리 + scope-discipline smoke 신규 추가. ROADMAP scope misclassification 물리적 차단.",
      "trigger": null
    },
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
      "summary": "기존 sessions/.*/REPORT.(md|ipynb)$ 패턴 → projects/meta/milestones/v.*/(PLAN|RESEARCH|DESIGN|VERIFY|REPORT|execute/.*).md$ 패턴. 현재 silent NOOP 상태 — 갱신 시 REPORT 작성 감지 시 SKILL invoke 안내 동작 복원.",
      "trigger": "B_regression"
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

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone: [`milestones/v1.1_meta-as-project/`](milestones/v1.1_meta-as-project/) (in_progress, 본 milestone — phase 2 git mv 후 본 경로로 이동 예정)
- Historical (4-tier 포맷): `milestones/v1.84_*` ~ `milestones/v1.88_*` (참조용 보존, 신규 작업은 v1.0+ 7-stage만)

## 비고 (2026-05-08, 본 milestone phase-1 시점)

이 ROADMAP은 v1.1_meta-as-project 의 phase-1 (additive scaffolding) 에서 신설됨. phase 2 (atomic flip) 에서 root ROADMAP.md 가 thin index 로 변환되며, 본 파일이 meta scope 의 단일 source of truth 가 된다.

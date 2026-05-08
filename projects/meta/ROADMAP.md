# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-08",
  "milestones": [
    {
      "id": "v1.1_meta-as-project",
      "title": "meta repo를 projects/meta/로 이관 — 모든 project 동형 구조 강제",
      "status": "completed",
      "summary": "root ROADMAP/milestones를 projects/meta/ 하위로 이관 (git mv 7 dirs, history 보존) + ARCHITECTURE.md 신규 + root ROADMAP을 thin index 변환 + projects/meta/CLAUDE.md (lazy subdir) 신설 + /harness-meta 경로 resolution 갱신 + misclassified v1.1_upbit-cross-ref-cleanup 이관 (root → projects/upbit/) + scope-discipline smoke 신규 + 단독 active 활성화 + 4 optional sweeps (settings.local.json prune / docs grep / harness-roadmap-update SKILL deprecation / pre-commit-config 주석 갱신). 3 phase commit (7bfa1a5 / 0fa3d32 / e2f59de), 회귀 0. 2026-05-08.",
      "trigger": null
    },
    {
      "id": "v1.1_readme-cleanup",
      "title": "README.md legacy 참조 (Bootstrap mode / DECISIONS|INTERVIEW|STACK / sessions/) 정리",
      "status": "pending",
      "summary": "v1.1_meta-as-project phase 3 에서 디렉토리 트리 + Key docs 갱신했으나 README.md 다른 섹션 (Activating a project / Bootstrap mode 안내 / 세션 산출물 'phases/' 표기) 잔존 stale. 사용자 trigger 시 별도 cleanup. v1.0 phase-4 에서 폐기된 DECISIONS/INTERVIEW/STACK 5-doc 표기도 본 milestone scope 외 — README cleanup 시 동반.",
      "trigger": "A_user"
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
- 최근 완료 milestone: [`milestones/v1.1_meta-as-project/`](milestones/v1.1_meta-as-project/) (REPORT 참조, 2026-05-08)
- 다음 직전 완료: [`milestones/v1.0_workflow-redesign/`](milestones/v1.0_workflow-redesign/) (REPORT 참조, 2026-05-08)
- Historical (4-tier 포맷): `milestones/v1.84_*` ~ `milestones/v1.88_*` (참조용 보존, 신규 작업은 v1.0+ 7-stage만)

## 비고

이 ROADMAP은 v1.1_meta-as-project (2026-05-08 완료) 에서 신설됨. 이전에는 root `ROADMAP.md` 가 meta scope 의 단일 source 였으나, 본 milestone 후 root는 thin index, 본 파일이 meta milestones[] 의 단일 source 가 됨.

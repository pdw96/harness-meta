# REPORT — v1.1_readme-cleanup

```json
{
  "id": "v1.1_readme-cleanup",
  "summary": "README.md에 잔존하던 구 10-stage 워크플로우 참조(10-stage tagline, /harness-plan·design·run·ship slash commands, sessions/ 경로, Bootstrap mode 문단, Stage 2 bootstrap 설치 절차, Language overlay 섹션, bootstrap/docs/·bootstrap/templates/ 링크, Key docs 미존재 4행)를 제거하고 현 7-stage 워크플로우 기반으로 교체했다. 2-phase 분할 구조(Phase 1: 제거, Phase 2: 재작성)로 각 diff가 명확하며 pre-commit full-pass로 회귀 0 확인.",
  "delta": {
    "files_changed": ["README.md"],
    "files_added": [
      "projects/meta/milestones/v1.1_readme-cleanup/INTENT.md",
      "projects/meta/milestones/v1.1_readme-cleanup/RESEARCH.md",
      "projects/meta/milestones/v1.1_readme-cleanup/DESIGN.md",
      "projects/meta/milestones/v1.1_readme-cleanup/execute/phase-1.md",
      "projects/meta/milestones/v1.1_readme-cleanup/execute/phase-2.md",
      "projects/meta/milestones/v1.1_readme-cleanup/VERIFY.md",
      "projects/meta/milestones/v1.1_readme-cleanup/REPORT.md"
    ],
    "files_deleted": [],
    "modules_affected": ["README.md (docs)"]
  },
  "lessons_learned": [
    "README.md는 실제 파일 존재 여부 확인(Glob) 없이 stale 여부를 판단하기 어렵다 — RESEARCH 단계에서 Glob으로 파일 실존을 확인하는 습관이 중요.",
    "Option A(최소 수정)를 선택하면 섹션 구조가 구 시스템 기반으로 남아 criteria 7(독자 혼동 없이 기술) 미충족 위험 — 3 관점 병렬 검토가 이 판단을 명확히 했다.",
    "2-phase 분할이 유효했다: Phase 1 diff(제거)가 명확해 리뷰 부담이 낮고, Phase 2 diff(재작성)가 별도로 추적 가능."
  ],
  "next_candidates": [
    {
      "id": "v1.1_agents-md-cleanup",
      "trigger": "README.md와 동일한 구 10-stage 참조가 AGENTS.md에도 잔존할 가능성이 높음",
      "trigger_type": "A_user"
    },
    {
      "id": "v1.1_smoke-precommit-rewrite",
      "trigger": "disabled smoke 4종(spec-verification·scope-contract·cross-ref·claude-md-drift)을 새 7-stage JSON 포맷에 맞게 재작성 — ROADMAP 기존 등재 항목",
      "trigger_type": "B_regression"
    }
  ]
}
```

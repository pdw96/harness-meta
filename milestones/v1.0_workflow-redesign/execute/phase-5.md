# EXECUTE — phase 5

```json
{
  "milestone": "v1.0_workflow-redesign",
  "phase": 5,
  "title": "sessions/ + bootstrap/ 폐기 + 미커밋 milestone 삭제 (mass deletion)",
  "status": "complete",
  "changes": [
    {
      "file": "sessions/",
      "action": "delete",
      "description": "전체 디렉토리 git rm -r — meta 116 + upbit 4 = ~120 vX.Y dirs + sessions/CLAUDE.md + sessions/meta/ROADMAP.md. 4-tier PLAN/REPORT 체계 폐기. git history 보존."
    },
    {
      "file": "bootstrap/CLAUDE.md",
      "action": "delete",
      "description": "bootstrap 모듈 가이드 폐기. 새 흐름은 첫 milestone EXECUTE에서 .harness.toml + 프로젝트 docs 생성으로 처리."
    },
    {
      "file": "bootstrap/docs/ (8 docs)",
      "action": "delete",
      "description": "OWNERSHIP / AGENTS_MD_STRATEGY / INTERVIEW_FLOW / OVERLAY / SKILLS / SPEC_VERIFICATION / PERMISSION_PATTERN / DETECTION 모두 폐기. 새 7-stage 흐름과 무관."
    },
    {
      "file": "bootstrap/{interview, manifest-schema, render-manifest.sh, detect-project.sh}",
      "action": "delete",
      "description": "Bootstrap 인터뷰 흐름 4 파일 폐기."
    },
    {
      "file": "bootstrap/install-project-claude.{ps1,sh}",
      "action": "delete",
      "description": "프로젝트별 .claude/ 배포 스크립트 2 파일 폐기. 새 흐름은 첫 milestone에서 처리."
    },
    {
      "file": "bootstrap/skeletons/",
      "action": "delete",
      "description": "AGENTS/CLAUDE/CLAUDE.override/GUARDRAILS .tmpl + projects/ + sessions/ skeleton 디렉토리 폐기."
    },
    {
      "file": "bootstrap/templates/",
      "action": "delete",
      "description": "_base/.claude/ 14 파일 + python/ overlay 폐기. 새 흐름은 첫 milestone에서 직접 작성."
    },
    {
      "file": "milestones/v1.85_project-workflow-extension/",
      "action": "delete",
      "description": "untracked 미커밋 디렉토리 (PLAN.md + plan-1-workflow-docs/PLAN.md + plan-2-project-roadmap/PLAN.md). v1.85 번호는 이미 v1.85_roadmap-housekeeping이 사용 — 충돌 + 4-tier 포맷이라 새 흐름과 부적합. rm -rf로 정리."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/execute/phase-5.md",
      "action": "create",
      "description": "본 phase 실행 기록."
    }
  ],
  "commit": "feat(meta): v1.0 phase-5 — sessions/ + bootstrap 툴링 폐기 (mass deletion ~362 entries)",
  "execution_notes": [
    "362 entries staged (sessions/ 가장 큰 비중). git history는 보존 — 필요 시 git log -- sessions/ 등으로 추적 가능.",
    "bootstrap/ 내 잔존: skills/ 하나만. 글로벌 user-skill 5종 (ai-ready-scorer / harness-plan-verify / harness-roadmap-update / mindvault / developer-profile) 보존.",
    "milestones/ 내 잔존: v1.0_workflow-redesign (활성, 새 포맷) + v1.84~v1.88 (historical 4-tier 보존).",
    "pre-commit hook 4 local hook은 phase-1에서 disable됨 — 본 phase 대규모 삭제도 정상 통과 예상.",
    "다음 phase-6: install.ps1 + verify.{ps1,sh}에서 본 phase 삭제 결과 반영 (bootstrap/templates/_base + install-project-claude refs 제거)."
  ]
}
```

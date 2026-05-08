# EXECUTE — phase 4

```json
{
  "milestone": "v1.0_workflow-redesign",
  "phase": 4,
  "title": "projects/upbit/ 정리 + ROADMAP JSON 마이그레이션",
  "status": "complete",
  "changes": [
    {
      "file": "projects/upbit/ROADMAP.md",
      "action": "edit",
      "description": "기존 §2 (pending 2) + §6 (completed 4) 표 → 단일 milestones[] JSON 배열 (6항목)로 통합. id 명명 v{X.Y}_{slug} 통일. trigger 필드 5종 (A_user/B_regression/C_env/D_design/E_priority) 분류. 마이그레이션 노트 1개 § 추가."
    },
    {
      "file": "projects/upbit/DECISIONS.md",
      "action": "delete",
      "description": "5종 표준 파일 폐기 (S4 스코프). 필요 시 ARCHITECTURE.md 또는 milestone RESEARCH.md에 흡수."
    },
    {
      "file": "projects/upbit/INTERVIEW.md",
      "action": "delete",
      "description": "5종 표준 파일 폐기. 초기 인터뷰 답변 — 필요 시 milestone RESEARCH.md에 스냅샷 기록."
    },
    {
      "file": "projects/upbit/STACK.md",
      "action": "delete",
      "description": "5종 표준 파일 폐기. 스택 정보는 .harness.toml manifest + ARCHITECTURE.md에 흡수."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/execute/phase-4.md",
      "action": "create",
      "description": "본 phase 실행 기록."
    }
  ],
  "commit": "feat(meta): v1.0 phase-4 — projects/upbit/ 정리 + ROADMAP JSON 마이그레이션",
  "execution_notes": [
    "ARCHITECTURE.md는 untouched — long-lived 참조 보존 (DESIGN decision #3 정합).",
    "git rm로 3 파일 삭제 — git history는 보존됨.",
    "ID 명명 변경: v1.4-statusline-cmd-migration → v1.4_statusline-cmd-migration (hyphen → underscore separator). 새 v{X.Y}_{slug} 컨벤션 정합.",
    "두 pending milestone 모두 v1.4로 등록 — promote 시 하나만 v1.4 유지, 다른 하나 v1.5 bump 정책 마이그레이션 노트에 명시.",
    "manifest-upgrade-1.1 → manifest-upgrade-1-1 — slug 내 period(.)는 path 호환 risk로 hyphen 변환.",
    "upbit repo 측 cross-ref 정리는 별도 후속 milestone (DESIGN out_of_scope 정합)."
  ]
}
```

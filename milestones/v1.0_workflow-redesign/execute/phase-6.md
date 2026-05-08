# EXECUTE — phase 6

```json
{
  "milestone": "v1.0_workflow-redesign",
  "phase": 6,
  "title": "install.ps1 + verify.ps1/sh 간소화",
  "status": "complete",
  "changes": [
    {
      "file": "install.ps1",
      "action": "edit",
      "description": "line 134-135 comments 갱신 — bootstrap/templates/_base + install-project-claude refs 제거. legacy cleanup 섹션은 유지 (구 symlink 정리용)."
    },
    {
      "file": "verify.ps1",
      "action": "edit",
      "description": "Stage list 11→10 (H 제거). Stage B7 (bootstrap/templates/_base/.claude/skills/ check) 제거. Stage H (Overlay 무결성, ~80 lines) 전체 제거. Stage I frontmatterFiles 리스트 정리 (bootstrap/templates 12 entries 제거 → bootstrap/skills/ 5 entries만 유지). Stage G 수동 체크리스트 갱신 (6항 → 4항, @bootstrap/docs/OWNERSHIP.md ref 제거)."
    },
    {
      "file": "verify.sh",
      "action": "edit",
      "description": "verify.ps1 mirror — Stage 헤더 (H 제거 + I 제목 변경), B7 stage 제거, H stage 제거, FRONTMATTER_FILES 리스트 정리, G 체크리스트 갱신 (6항 → 4항)."
    },
    {
      "file": "milestones/v1.0_workflow-redesign/execute/phase-6.md",
      "action": "create",
      "description": "본 phase 실행 기록."
    }
  ],
  "commit": "feat(meta): v1.0 phase-6 — install.ps1 + verify.{ps1,sh} 간소화 (Stage H/B7 제거, frontmatter 리스트 정리)",
  "execution_notes": [
    "install.ps1 legacy cleanup 섹션은 유지 — v1.7 이전 install로 만들어진 broken symlink 자동 정리용 (사용자 환경 무중단 마이그레이션 보장).",
    "verify.{ps1,sh} 큰 폭 정리. Stage 매트릭스: 기존 11 (Z/A/B/C/D/E/F/H/I/J/G) → 10 (Z/A/B/C/D/E/F/I/J/G). H stage Overlay 무결성은 bootstrap/templates 폐기와 함께 제거.",
    "Stage I frontmatterFiles 리스트 17건 → 6건 (bootstrap/templates/_base 11건 + python overlay 1건 제거 → claude/commands + bootstrap/skills/ 5 SKILL).",
    "Stage G 수동 체크리스트 갱신 — execute.py / output-style refs 제거 (4-tier 시대 잔재). @ROADMAP.md import 확인 + subdirectory CLAUDE.md on-demand 로드 확인 추가.",
    "verify-lib.{ps1,sh} 변경 없음 — 공유 helper는 stage 무관."
  ]
}
```

# EXECUTE — phase 2

```json
{
  "milestone": "v1.0_workflow-redesign",
  "phase": 2,
  "title": "root ROADMAP.md 신설 + CLAUDE.md/AGENTS.md/claude/CLAUDE.md/bootstrap/skills/CLAUDE.md 갱신",
  "status": "complete",
  "changes": [
    {
      "file": "ROADMAP.md",
      "action": "create",
      "description": "root JSON 스키마 — milestones 단일 배열. v1.0_workflow-redesign in_progress 1건 등록."
    },
    {
      "file": "CLAUDE.md",
      "action": "edit",
      "description": "rewrite — 7-stage 흐름 정의 + 모듈 매트릭스 4행 (bootstrap/skills/, claude/, tests/, milestones/) + @import 3건 (bootstrap/docs/OWNERSHIP, manifest-schema, AGENTS_MD_STRATEGY) 제거 + @ROADMAP.md 추가 + 명령어 단일 단계 (project-claude install 폐기)."
    },
    {
      "file": "AGENTS.md",
      "action": "edit",
      "description": "rewrite — 영문 7-stage workflow + project structure 갱신 (legacy 4-tier milestones historical 보존 명시) + Workflow 섹션 신설."
    },
    {
      "file": "claude/CLAUDE.md",
      "action": "edit",
      "description": "light — bootstrap/templates/_base ref 제거 + sessions/ 세션 refs 제거 + PERMISSION_PATTERN ref 제거. PostToolUse hook sessions/ 패턴 후속 갱신 명시."
    },
    {
      "file": "bootstrap/skills/CLAUDE.md",
      "action": "edit",
      "description": "light — 상위 ref 경로 정정 (../CLAUDE.md → ../../CLAUDE.md), bootstrap/docs/* refs 제거 (SKILLS, PERMISSION_PATTERN), milestone 기록 표기 갱신 (sessions → milestones)."
    }
  ],
  "commit": "feat(meta): v1.0 phase-2 — root ROADMAP/CLAUDE/AGENTS 신설/재작성 + 모듈 CLAUDE.md 갱신",
  "execution_notes": [
    "5 파일 단일 commit. pre-commit hook 모두 PASS (markdownlint 포함 — JSON 코드블록 fence language 'json' + diagram 블록은 무 language인데 PASS — 기존 .markdownlint.json이 MD040 disable로 추정).",
    "phase-1 단계에서 누락한 execute/phase-2.md는 phase-3 commit에서 retrospective로 함께 등록.",
    "@ROADMAP.md import 추가로 root 세션 시 ROADMAP 자동 로드.",
    "Cross-ref 검증: tests/CLAUDE.md, docs/adr/README.md, projects/upbit/ROADMAP.md 모두 현존 (phase-4에서 upbit ROADMAP migrate 예정)."
  ]
}
```

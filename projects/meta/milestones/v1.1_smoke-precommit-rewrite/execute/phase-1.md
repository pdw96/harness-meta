# EXECUTE phase-1 — smoke-cross-ref + smoke-claude-md-drift 최소 패치

```json
{
  "phase": 1,
  "title": "smoke-cross-ref + smoke-claude-md-drift 최소 패치",
  "status": "in_progress",
  "changes": [
    {
      "file": "tests/smoke-cross-ref.sh",
      "action": "edit",
      "description": "_VER_MILE regex: '^milestones/v\\d+' → '^projects/[^/]+/milestones/v\\d+'"
    },
    {
      "file": "tests/smoke-claude-md-drift.sh",
      "action": "edit",
      "description": "MODULE_PATHS: sessions/CLAUDE.md·bootstrap/CLAUDE.md 제거, projects/meta/CLAUDE.md 추가 (5→4건). S4: CLAUDE.md → tests/CLAUDE.md, 패턴 'smoke [0-9]+ 매트릭스' → '현 ([0-9]+) 파일'."
    }
  ],
  "commit": null,
  "execution_notes": null
}
```

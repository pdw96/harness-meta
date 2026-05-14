# execute/phase-2 — v5.1 skills 재배치

```json
{
  "phase": 2,
  "milestone": "v5.1_plugin-component-discovery-fix",
  "title": "skills 재배치 — 5 skill dirs git mv → ./skills/ flat + plugin.json skills 갱신",
  "status": "complete",
  "commit": "94d0740 (+ cleanup cdaa83e)",
  "changes": [
    "git mv bootstrap/skills/audit/ai-ready-scorer/ skills/ai-ready-scorer/",
    "git mv bootstrap/skills/audit/harness-plan-verify/ skills/harness-plan-verify/",
    "git mv bootstrap/skills/audit/harness-roadmap-update/ skills/harness-roadmap-update/",
    "git mv bootstrap/skills/dev-tools/mindvault/ skills/mindvault/",
    "git mv bootstrap/skills/dev-tools/developer-profile/ skills/developer-profile/",
    ".claude-plugin/plugin.json skills ./bootstrap/skills/ → ./skills/"
  ],
  "execution_notes": "smoke-cross-ref 6건 발견 (bootstrap/skills/CLAUDE.md + harness-roadmap-update/SKILL.md 내부 경로). --fix 삭제 후 새 경로로 수동 복원. .bak 파일 cleanup commit 추가 (cdaa83e). pre-commit 14 hook PASS."
}
```

# execute/phase-2 — v5.1 skills 재배치

```json
{
  "phase": 2,
  "milestone": "v5.1_plugin-component-discovery-fix",
  "title": "skills 재배치 — 5 skill dirs git mv → ./skills/ flat + plugin.json skills 갱신",
  "status": "in_progress",
  "changes": [
    "git mv bootstrap/skills/audit/ai-ready-scorer/ skills/ai-ready-scorer/",
    "git mv bootstrap/skills/audit/harness-plan-verify/ skills/harness-plan-verify/",
    "git mv bootstrap/skills/audit/harness-roadmap-update/ skills/harness-roadmap-update/",
    "git mv bootstrap/skills/dev-tools/mindvault/ skills/mindvault/",
    "git mv bootstrap/skills/dev-tools/developer-profile/ skills/developer-profile/",
    ".claude-plugin/plugin.json skills ./bootstrap/skills/ → ./skills/"
  ],
  "commit": null,
  "execution_notes": null
}
```

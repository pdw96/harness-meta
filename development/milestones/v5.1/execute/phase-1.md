# execute/phase-1 — v5.1 agents 재배치

```json
{
  "phase": 1,
  "milestone": "v5.1_plugin-component-discovery-fix",
  "title": "agents 재배치 — 7 agent .md git mv → ./agents/ flat + team CLAUDE.md → agents/project-harness-audit-team/ + 내부 경로 fix + plugin.json agents 필드 제거",
  "status": "complete",
  "commit": "7af00f2",
  "changes": [
    "git mv bootstrap/agents/audit/environment-auditor.md agents/environment-auditor.md",
    "git mv bootstrap/agents/audit/agents-md-sync.md agents/agents-md-sync.md",
    "git mv bootstrap/agents/audit/project-harness-audit-team/project-scanner.md agents/project-scanner.md",
    "git mv bootstrap/agents/audit/project-harness-audit-team/harness-gap-analyzer.md agents/harness-gap-analyzer.md",
    "git mv bootstrap/agents/audit/project-harness-audit-team/claude-docs-mapper.md agents/claude-docs-mapper.md",
    "git mv bootstrap/agents/audit/project-harness-audit-team/component-proposer.md agents/component-proposer.md",
    "git mv bootstrap/agents/audit/project-harness-audit-team/component-installer.md agents/component-installer.md",
    "git mv bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md agents/project-harness-audit-team/CLAUDE.md",
    "environment-auditor.md 내부 상대경로 ../CLAUDE.md → ../bootstrap/agents/CLAUDE.md",
    "agents-md-sync.md 내부 상대경로 ../CLAUDE.md → ../bootstrap/agents/CLAUDE.md",
    "component-installer.md 내부 상대경로 ../../../../projects/ → ../projects/",
    "agents/project-harness-audit-team/CLAUDE.md 내부 상대경로 3건 fix",
    ".claude-plugin/plugin.json agents 필드 제거"
  ],
  "execution_notes": "smoke-cross-ref --fix 가 claude/commands/harness-meta.md L87 삭제 → 새 경로로 수동 복원 (../../agents/project-harness-audit-team/CLAUDE.md). markdownlint MD012 blank line 2개 추가 수정. pre-commit 14 hook PASS."
}
```

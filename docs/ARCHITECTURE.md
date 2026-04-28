# harness-meta Architecture

## Overview

harness-meta is the **global integration layer** for the Claude Code harness workflow. It distributes shared assets (slash commands, agents, skills) to individual projects via symlink or copy, and maintains architecture records for each project.

## Layer Model

```
~/.claude/                          ← Global layer (symlinks from harness-meta)
  commands/harness-meta.md          ← Session entry point
  hooks/session-init.sh             ← SessionStart hook
  statusline/statusline.sh          ← Real-time phase/step display

~/harness-meta/                     ← This repo
  bootstrap/                        ← New project onboarding assets
    templates/_base/.claude/        ← Language-agnostic baseline (17 files)
    templates/<language>/.claude/   ← Language-specific overlay (v1.11+)
    docs/                           ← Design docs (OWNERSHIP, AGENTS_MD_STRATEGY, etc.)
    interview.md                    ← Bootstrap interview questions
    render-manifest.sh              ← .harness.toml generator
    detect-project.sh               ← Language/PM auto-detection

  projects/<name>/                  ← Per-project harness architecture records
    ARCHITECTURE.md                 ← Decisions, constraints, stack
    DECISIONS.md                    ← H-ADR log
    INTERVIEW.md                    ← Bootstrap Q&A
    STACK.md                        ← Tech stack snapshot

  sessions/<target>/vX.Y-{name}/   ← Session history
    PLAN.md                         ← Intent + scope contract
    REPORT.md                       ← Outcome + lessons
```

## Key Design Decisions

See `bootstrap/docs/` for detailed decision records:

| Document | Topic |
|----------|-------|
| [`OWNERSHIP.md`](../bootstrap/docs/OWNERSHIP.md) | Session scope classification (S1–S7, T1–T5) |
| [`AGENTS_MD_STRATEGY.md`](../bootstrap/docs/AGENTS_MD_STRATEGY.md) | AGENTS.md open standard adoption |
| [`OVERLAY.md`](../bootstrap/docs/OVERLAY.md) | Language overlay merge algorithm |
| [`PERMISSION_PATTERN.md`](../bootstrap/docs/PERMISSION_PATTERN.md) | frontmatter + Bash() 6-axis spec |
| [`PHILOSOPHY.md`](../bootstrap/docs/PHILOSOPHY.md) | Core design philosophy |

## Activation

A project activates the harness by placing `.harness.toml` in its root. Absence = no-op. Schema: [`bootstrap/manifest-schema.md`](../bootstrap/manifest-schema.md).

## Install Flow

1. `pwsh install.ps1` — deploys global layer (`~/.claude/{commands,hooks,statusline}/`)
2. `pwsh bootstrap/install-project-claude.ps1 -ProjectRoot <proj>` — copies `_base` + language overlay to `<proj>/.claude/`
3. `pwsh verify.ps1` — 30-check health report

## Test Suite

Shell-based smoke tests in `tests/`. Run: `make test` or `bash tests/smoke-v1.1.sh`.

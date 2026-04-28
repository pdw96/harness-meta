# Plan: {phase-name} ({version})

## Current State
- Tests: {N}
- Target: {modules + state}

## Requirements
| # | Feature | AC | Priority | Current Code |
|---|---------|-----|---------|--------------|
| R1 | ... | `{test_cmd}` <!-- .harness.toml [testing].test_cmd --> | P0 | `{src}/module_x.{ext}` not yet created |
| R2 | ... | ... | P1 | `{src}/module_y.{ext}:N` stub |

## Discussion Decisions
| Topic | Decision | Rationale |
|-------|----------|-----------|
| ... | ... | ... |

## Claude Discretion Items
- ... (items where user said "you decide")

## Step Design Draft
- step0: {module name}, {single-line responsibility}
- step1: ...
- step2: ...

## Grey Areas
- ... (areas requiring further exploration at design stage)

---

> **Writing principles**:
> - AC must be **runnable commands** (no abstractions)
> - Priority P0 (required) / P1 (recommended) / P2 (optional)
> - 7-Dimension validation results excluded — recorded in step files at `/harness-design`

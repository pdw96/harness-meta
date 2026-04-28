# Phase Report: {phase-name} ({version})

## Goal-backward Validation

| Requirement | Truth | Artifact (path) | Wired | Tested | Verdict |
|-------------|-------|----------------|-------|--------|---------|
| R1 | ... | `{src}/module_a.{ext}` | ✓ | `{tests}/test_module_a.{ext}` | VERIFIED |
| R2 | ... | `{src}/module_b.{ext}` | ✓ | `{tests}/test_module_b.{ext}` | VERIFIED |

**Summary**: VERIFIED N / ORPHANED N / STUB N / MISSING N

## Execution Results

| Step | Name | Time | Cost | Turns | Retries |
|------|------|------|------|-------|---------|
| 0 | ... | 120s | $0.45 | 12 | 0 |
| 1 | ... | ... | ... | ... | ... |

**Total**: {total_time}s / ${total_cost} / {total_turns} turns / {total_retries} retries

## /harness-review Results

| Item | Result | Rationale |
|------|--------|-----------|
| Architecture compliance | PASS | Project ARCHITECTURE rules followed (e.g., no prohibited code in designated directory) |
| Tech stack compliance | PASS | 0 prohibited items from project DECISIONS/ADR |
| Tests exist | PASS | Project test command `{test_cmd}` — N passed |
| CRITICAL rules | PASS | Each rule in project CLAUDE.md CRITICAL section checked |
| Buildable | PASS | Project type-check and lint error-free |

## Output Summary

- `{src}/module_a.{ext}` — ... (N lines)
- `{tests}/test_module_a.{ext}` — ... (N cases)
- `.env.example` — new fields {X, Y}
- `docs/scope/{version}/ADR.md` — ADR-NN added (follows project doc structure)

## Lessons Learned

- Success patterns: ...
- Failures / workarounds: ...
- Improvements for next phase: ...

## Test Changes

| | Before | After | Delta |
|---|--------|-------|-------|
| Total tests | N | M | +X |
| New files | - | `{tests}/test_xxx.{ext}` | +L files |

---

> This template lives at `.claude/skills/harness-ship/report-template.md`.
> Keep the skill file as single source of truth when editing.

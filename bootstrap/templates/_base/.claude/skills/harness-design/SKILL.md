---
name: harness-design
description: Harness stages 5~7 — design→7-Dimension validation→step file generation. Activated only by explicit /harness-design call.
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write(phases/**)
  - Edit(phases/**)
model: opus
effort: xhigh
---

Harness stages 5~7: Phase design → 7-Dimension validation → file generation

**Orchestrator**: lightweight coordinator. Delegate heavy analysis/file generation to Agent(model="opus").

## Pre-flight Gate

1. `phases/{version}/{phase}/PLAN.md` exists → if not, route to `/harness-plan`
2. Check "Step Design Draft" section in PLAN.md → if header only with no body (no lines/list) → `/harness-plan`
3. Read `phases/ROADMAP.md` Lessons Learned → incorporate past lessons
4. If `step*.md` already exists → confirm with user "Regenerate? (overwrite)" before proceeding

## Context Budget
- Read PLAN.md summary + only needed files
- Delegate step.md generation to Agent(model="opus") to protect main context
- If context becomes heavy: "Context running low — recommend /clear then resume"

---

## 5. Phase Design

Write detailed step instructions based on step design draft from PLAN.md.

Design principles:
1. **Minimize scope** — one module per step
2. **Self-contained** — independent Claude session. No external references.
3. **Force prerequisites** — include doc paths + previous step file paths
4. **Signature-level instructions** — interfaces only, core rules only
5. **AC as runnable commands** — use `.harness.toml [testing].test_cmd` value (no abstractions)
6. **Specific cautions** — "Do not do X. Reason: Y"
7. **Naming** — kebab-case slug

**Delegate grey area analysis to dedicated subagent:**
```
Agent(
  subagent_type="harness-grey-area",
  description="v{X} grey area analysis",
  prompt="Target: {module paths, language extensions}. PLAN.md: phases/v{X}/{phase}/PLAN.md"
)
```
→ Returns analysis across 5 dimensions (Edge Cases / Interface compatibility / Hidden dependencies / State management / Performance).
Explore agent is for general exploration; `harness-grey-area` is dedicated to harness-specific grey area analysis.

## 6. 7-Dimension Validation

**Checklist**: Read `.claude/skills/harness-design/7d-checklist.md`.

7 dimensions summary:
- **D1 Consistency** / **D2 Safety** / **D3 Performance** / **D4 Completeness** / **D5 Testability** / **D6 Operability** / **D7 Data Flow**

Add `## 7-Dimension Validation` table at the end of each step.md (PASS/FAIL/rationale).

### Revision Gate (max 3x)
FAIL → fix → re-validate. Exceeds 3x → **Escalation** (user decision).

### Validation result recording
- Add `## 7-Dimension Validation` section at the end of each step body with PASS/FAIL/rationale
- Full phase dimension results accumulated in `phases/{version}/{phase}/REPORT.md` (written at ship stage)

## 7. File Generation

**Delegate bulk file generation to Agent:**
```
Agent(
  description="step 0-3 file generation",
  model="opus",
  prompt="Based on PLAN.md, generate step0.md~step3.md. Include Pre-mortem in each step."
)
```

Generate:
- `phases/{version}/{phase}/index.json`
- `phases/{version}/{phase}/step{N}.md`

> **milestone.json**: Created in advance in `/harness-plan` Step 0. At design stage, only confirm `status=pending` for the current phase. If missing → return to `/harness-plan` Step 0.

Output guidance:
```
Step files generated.
Next: /harness-run
If context low: /clear → /harness-run
```

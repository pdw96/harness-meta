# 7-Dimension Validation Checklist

Evaluate each step across the 7 dimensions below with PASS/FAIL and record rationale.

## D1. Consistency
- [ ] Does it cover all requirements in PLAN.md without gaps?
- [ ] Are inter-step dependencies expressed as a DAG (no cycles)?
- [ ] Complies with directory rules in project ARCHITECTURE document?
- [ ] Complies with technology decisions in project DECISIONS/ADR?
- [ ] Complies with CRITICAL rules in project `CLAUDE.md` (rules are project-specific)?

## D2. Safety
- [ ] Are error cases explicitly enumerated?
- [ ] Recovery strategy (retry / fallback / graceful degrade) present?
- [ ] Backward compatibility maintained (existing tests not broken)?
- [ ] Concurrency issues (race condition, shared state) considered?

## D3. Performance
- [ ] No blocking operations in hot path (called every tick)?
- [ ] If LLM calls exist, token cost calculated + caching considered?
- [ ] No memory leaks (deque maxlen, buffer cleanup)?

## D4. Completeness
- [ ] Hidden requirements (warmup, initialization, edge cases) fully covered?
- [ ] Both inputs and outputs specified (public API types/semantics)?
- [ ] New fields in project config definition source + `.env.example` synchronized?

## D5. Testability
- [ ] AC expressed as **runnable commands**?
- [ ] Mock strategy specified (network, time, random, etc.)?
- [ ] Edge case tests included (0, None, empty array, max value)?

## D6. Operability
- [ ] Relevant metrics added to project metrics definition source?
- [ ] Alert criteria specified (consecutive failures, threshold exceeded)?
- [ ] Safe rollback possible via feature flag?

## D7. Data Flow
- [ ] Full path of project's main data pipeline traced? (input → processing → output)
- [ ] Compatible with stub implementations (e.g., paper → live environment switch)?
- [ ] Impact on inter-container / inter-process communication?

---

## Recording format (end of step.md)

```markdown
## 7-Dimension Validation

| Dimension | Result | Rationale |
|-----------|--------|-----------|
| D1 Consistency | PASS | PLAN R1~R3 all handled in `{src}/module_a.{ext}` |
| D2 Safety | PASS | network error: 3 retries, timeout 10s |
| D3 Performance | PASS | hot path O(1), cache 30s |
| D4 Completeness | FAIL | warmup initialization not specified → Revision 1 |
| D5 Testability | PASS | `{tests}/test_module_a.{ext}` 15 cases + 3 edge cases |
| D6 Operability | PASS | `module_a_state` counter metric added |
| D7 Data Flow | PASS | same module imported in both environments (e.g., paper/live) |
```

## Revision Gate

FAIL → modify step.md → re-validate (max 3x).
Exceeds 3x → Escalation (request user decision).

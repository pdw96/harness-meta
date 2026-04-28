---
name: harness-python
description: Python project integrated check — env verification + mypy → ruff → pytest quality gate. Auto-detects PM from .harness.toml.
disable-model-invocation: true
argument-hint: "[env|check|fix|all]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
model: sonnet
---

Full Python project check. PM detection via `.harness.toml` + `[testing]` field integration.

| argument | behavior |
|----------|----------|
| none / `all` | §2 env check → §3 full quality gate |
| `env` | §2 env check only |
| `check` | §3 quality gate only |
| `fix` | §4 auto-fix (ruff format + ruff --fix) |

---

## §0. Prerequisites

**1. Extract `.harness.toml` fields** (Bash grep+sed):

```bash
PM=$(grep -E '^package_manager\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
TYPE_CHECK=$(grep -E '^type_check_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
LINT=$(grep -E '^lint_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
FORMAT=$(grep -E '^format_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
TEST=$(grep -E '^test_cmd\s*=\s*"' .harness.toml 2>/dev/null \
     | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
```

**2. PM → prefix mapping** (see `python-quality.md §1`):

- `uv` → `uv run`
- `poetry` → `poetry run`
- `pdm` → `pdm run`
- `hatch` → `hatch run`
- `pip` / other / not detected → direct call (no prefix)

**3. Command fallback** — if field empty, use PM default (see `python-quality.md §2`).

**If `.harness.toml` missing**: ask user "`.harness.toml` not found. Enter PM (uv/poetry/pip):"

---

## §1. Argument dispatch

Normalize argument to lowercase then enter section per table above.

---

## §2. Env check (env)

Run in order and output ✓/✗:

| # | Item | Check command / condition |
|---|------|--------------------------|
| 1 | Python version | `python --version` (uv: `uv python list --only-installed \| head -1`) |
| 2 | Virtual env | `.venv/` directory exists (`[ -d .venv ]`) |
| 3 | Lock file | `uv.lock` or `poetry.lock` file exists |
| 4 | Lock sync state | uv → `uv sync --dry-run 2>&1 \| tail -5` / poetry → `poetry check --quiet` |

See `python-quality.md §3` for detailed check and fix commands.

**Output format:**
```
─── Python Environment ──────────────────────
  ✓ Python 3.12.x
  ✓ .venv present
  ✓ uv.lock present
  ✗ sync mismatch — run uv sync
─────────────────────────────────────────────
```

On ✗ → show 1-line cause + fix command.
Ask user whether to proceed with `check` (if ✗ items exist).

---

## §3. Quality gate (check)

**Execution order**: type_check → lint → format_check → test

Each step:
1. Print `▶ <command>`
2. Run via Bash
3. exit 0 → PASS / exit ≠ 0 → FAIL
4. On FAIL → show up to 10 lines of key errors + match against `python-quality.md §4` diagnosis patterns
5. After FAIL → ask "Continue? (y/n)". `n` → stop. `y` → next step.

**Final results table format:**
```
─── Quality Gate Results ─────────────────────
  type_check  ✓  (0 errors)
  lint        ✗  (3 issues)
  format      —  (skipped: user stopped)
  test        —  (skipped)
─────────────────────────────────────────────
  Summary: 1 PASS / 1 FAIL / 2 SKIPPED
```

On all PASS:
```
─── Quality Gate Results ─────────────────────
  type_check  ✓  (0 errors)
  lint        ✓  (0 issues)
  format      ✓  (clean)
  test        ✓  (42 passed, 0 failed)
─────────────────────────────────────────────
  Summary: 4/4 PASS ✓
```

---

## §4. Auto-fix (fix)

**Format fix** (first):
```bash
<prefix> ruff format .
```

**Lint auto-fix** (after):
```bash
<prefix> ruff check --fix .
```

Print count of modified files. Remaining errors after `ruff check --fix` require manual resolution.
After fix completes → ask "Run check? (y/n)".

---

## §5. Diagnosis hints

Grep FAIL error messages against `python-quality.md §4` pattern table → suggest cause + fix command.
Unrecognized patterns displayed as-is.

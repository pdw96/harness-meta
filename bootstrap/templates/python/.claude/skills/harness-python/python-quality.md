# Python Quality — PM mapping + quality gate reference

Supplementary reference for `harness-python/SKILL.md`. PM mapping, per-stage default commands, env check, and diagnosis pattern tables for Python integrated checks.

## §1. PM → command prefix mapping

| `package_manager` | prefix | example |
|-------------------|--------|---------|
| `uv` | `uv run` | `uv run mypy src` |
| `poetry` | `poetry run` | `poetry run mypy src` |
| `pdm` | `pdm run` | `pdm run mypy src` |
| `hatch` | `hatch run` | `hatch run mypy src` |
| `pip` / `rye` / other / not detected | (none) | `mypy src` |

## §2. Quality gate stage table

Use PM default when `type_check_cmd` / `lint_cmd` / `format_cmd` / `test_cmd` field is empty.

| Stage | `.harness.toml` field | uv default | poetry default | direct (pip) default |
|-------|-----------------------|------------|----------------|----------------------|
| type_check | `type_check_cmd` | `uv run mypy src` | `poetry run mypy src` | `mypy src` |
| lint | `lint_cmd` | `uv run ruff check .` | `poetry run ruff check .` | `ruff check .` |
| format_check | `format_cmd` | `uv run ruff format --check .` | `poetry run ruff format --check .` | `ruff format --check .` |
| test | `test_cmd` | `uv run pytest` | `poetry run pytest` | `pytest` |

**mypy target fallback**: use `mypy .` if `src/` directory does not exist.

## §3. Env check stage table

| # | Item | Check command | PASS condition | Fix command on ✗ |
|---|------|--------------|----------------|-------------------|
| 1 | Python version | `python --version` | output present + version confirmed | `uv python install 3.12` / `pyenv install 3.12` |
| 2 | Virtual env | `[ -d .venv ]` | directory exists | `uv venv` / `poetry install` / `python -m venv .venv` |
| 3a | uv.lock | `[ -f uv.lock ]` | file exists | `uv lock` |
| 3b | poetry.lock | `[ -f poetry.lock ]` | file exists | `poetry lock` |
| 4a | uv sync state | `uv sync --dry-run 2>&1` | "Nothing to do" or no changes | `uv sync` |
| 4b | poetry consistency | `poetry check --quiet` | exit 0 | `poetry install` / `poetry lock --no-update` |

## §4. Diagnosis pattern table

| Error pattern (grep keyword) | Cause | Fix command |
|------------------------------|-------|-------------|
| `ModuleNotFoundError` | dependency not installed / venv not activated | `uv sync` / `poetry install` |
| `Cannot find implementation or library stub` | mypy stub not installed | `uv add --dev types-<pkg>` |
| `No module named 'src'` | src/ layout + pythonpath not configured | add `pyproject.toml [tool.mypy] mypy_path = "src"` |
| `error: unresolved import` | import path mismatch | `PYTHONPATH=src uv run mypy` |
| `E501` | line length exceeded | `pyproject.toml [tool.ruff] line-length = 120` or `# noqa: E501` |
| `W291\|W293\|W391` | trailing whitespace / blank line | `ruff check --fix .` |
| `would reformat` | ruff format not applied | `ruff format .` (§4 fix) |
| `FAILED.*AssertionError` | pytest assertion failure | check test logic |
| `FAILED.*ImportError` | pytest import failure | check `conftest.py` or `pyproject.toml [tool.pytest.ini_options] pythonpath` |
| `collected 0 items` | tests not found | check paths with `pytest --collect-only` / verify `test_*.py` naming |
| `ERROR` (pytest setup) | fixture / conftest error | check conftest.py stack trace |
| `lockfile needs update\|outdated` | uv.lock stale | `uv lock` |
| `is not consistent\|lock.*outdated` | poetry.lock stale | `poetry lock --no-update` |
| `Segmentation fault\|SIGSEGV` | C extension / native module conflict | `uv sync --reinstall` then re-run |

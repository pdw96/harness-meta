# Python Quality — PM 매핑 + 품질 게이트 참조

`harness-python/SKILL.md` 보조 참조 파일. Python 통합 점검의 PM 매핑, 단계별 기본 명령, 환경 확인, 진단 패턴 표.

## §1. PM → 명령 prefix 매핑

| `package_manager` | prefix | 예시 |
|-------------------|--------|------|
| `uv` | `uv run` | `uv run mypy src` |
| `poetry` | `poetry run` | `poetry run mypy src` |
| `pdm` | `pdm run` | `pdm run mypy src` |
| `hatch` | `hatch run` | `hatch run mypy src` |
| `pip` / `rye` / 기타 / 미감지 | (없음) | `mypy src` |

## §2. 품질 게이트 단계 표

`type_check_cmd` / `lint_cmd` / `format_cmd` / `test_cmd` 필드 빈값 시 PM default 사용.

| 단계 | `.harness.toml` 필드 | uv default | poetry default | 직접(pip) default |
|------|---------------------|------------|----------------|-------------------|
| type_check | `type_check_cmd` | `uv run mypy src` | `poetry run mypy src` | `mypy src` |
| lint | `lint_cmd` | `uv run ruff check .` | `poetry run ruff check .` | `ruff check .` |
| format_check | `format_cmd` | `uv run ruff format --check .` | `poetry run ruff format --check .` | `ruff format --check .` |
| test | `test_cmd` | `uv run pytest` | `poetry run pytest` | `pytest` |

**mypy 대상 fallback**: `src/` 디렉토리 부재 시 `mypy .` 사용.

## §3. 환경 확인 단계 표

| # | 항목 | 확인 명령 | PASS 조건 | ✗ 시 수정 명령 |
|---|------|----------|----------|--------------|
| 1 | Python 버전 | `python --version` | 출력 존재 + 버전 확인 | `uv python install 3.12` / `pyenv install 3.12` |
| 2 | 가상환경 | `[ -d .venv ]` | 디렉토리 존재 | `uv venv` / `poetry install` / `python -m venv .venv` |
| 3a | uv.lock | `[ -f uv.lock ]` | 파일 존재 | `uv lock` |
| 3b | poetry.lock | `[ -f poetry.lock ]` | 파일 존재 | `poetry lock` |
| 4a | uv sync 상태 | `uv sync --dry-run 2>&1` | "Nothing to do" 또는 변경 없음 | `uv sync` |
| 4b | poetry 정합 | `poetry check --quiet` | exit 0 | `poetry install` / `poetry lock --no-update` |

## §4. 진단 패턴 표

| 오류 패턴 (grep 키워드) | 원인 | 해결 명령 |
|------------------------|------|----------|
| `ModuleNotFoundError` | 의존성 미설치 / venv 미활성 | `uv sync` / `poetry install` |
| `Cannot find implementation or library stub` | mypy stub 미설치 | `uv add --dev types-<pkg>` |
| `No module named 'src'` | src/ 레이아웃 + pythonpath 미설정 | `pyproject.toml [tool.mypy] mypy_path = "src"` 추가 |
| `error: unresolved import` | import 경로 불일치 | `PYTHONPATH=src uv run mypy` |
| `E501` | line-length 초과 | `pyproject.toml [tool.ruff] line-length = 120` 또는 `# noqa: E501` |
| `W291\|W293\|W391` | trailing whitespace / blank line | `ruff check --fix .` |
| `would reformat` | ruff format 미적용 | `ruff format .` (§4 fix) |
| `FAILED.*AssertionError` | pytest assertion 실패 | 해당 테스트 로직 확인 |
| `FAILED.*ImportError` | pytest import 실패 | `conftest.py` 또는 `pyproject.toml [tool.pytest.ini_options] pythonpath` 확인 |
| `collected 0 items` | 테스트 미발견 | `pytest --collect-only` 로 경로 확인 / `test_*.py` 네이밍 확인 |
| `ERROR` (pytest setup) | fixture / conftest 오류 | conftest.py 스택 트레이스 확인 |
| `lockfile needs update\|outdated` | uv.lock stale | `uv lock` |
| `is not consistent\|lock.*outdated` | poetry.lock stale | `poetry lock --no-update` |
| `Segmentation fault\|SIGSEGV` | C 확장 / 네이티브 모듈 충돌 | `uv sync --reinstall` 후 재실행 |

# `.harness.toml` — 프로젝트 매니페스트 스펙

하네스를 도입한 프로젝트가 루트에 두는 **단일 설정 파일**. 글로벌 `session-init.sh` hook과 `statusline.sh`가 CWD에서 이 파일을 찾아 프로젝트 메타를 로드한다. 부재 시 하네스 비활성 프로젝트로 간주 → hook / statusline **no-op**.

## 설계 원칙

- **1 파일 · 평탄 · 읽기 전용**: 하네스 런타임이 수정하지 않는다. 사용자 수동 또는 bootstrap 세션이 생성.
- **경로는 프로젝트 루트 기준 상대경로**. 절대경로 금지(이식성).
- **파싱 단순성**: 핵심 필드(`[project].name`, `[harness].code_dir`)는 `grep` / `sed`만으로 추출 가능. 깊은 파싱이 필요하면 Python `tomllib` 사용(프로젝트 Python 3.11+ 전제).
- **스키마 진화**: `schema_version` 필드로 호환성 추적.

## 현행 버전

`schema_version = "1.0"` — 본 문서 발간 시점 고정.

## 전체 스키마

```toml
schema_version = "1.0"

[project]
name = "upbit"                      # 필수. 하네스 식별자. hyphen↔underscore 동치
language = "python"                 # 필수. 예: python, typescript, go, rust
package_manager = "poetry"          # 필수. 예: poetry, pnpm, npm, uv, go-mod, cargo
python_version = "3.12"             # 선택. language=python일 때 권장

[harness]
code_dir = "scripts/harness"        # 필수. 하네스 코어 코드 위치 (프로젝트 루트 기준 상대)
phases_dir = "phases"               # 필수. 실행 산출물 루트
guardrails = "docs/GUARDRAILS.md"   # 선택. builders.load_guardrails() 대상
mcp_server = "harness"              # 선택. .mcp.json의 서버 이름. 관례 고정값 "harness"
executor = "scripts/execute.py"     # 선택. statusline이 --status로 호출

[architecture]
meta_ref = "projects/upbit/ARCHITECTURE.md"   # 필수. harness-meta repo 내부 경로

[testing]                           # 선택. 커스텀 테스트·검증 커맨드 (REPORT 자동 수집 시 사용)
test_cmd = "poetry run pytest tests/ -q"
harness_test_cmd = "poetry run pytest scripts/tests/ -q"
type_check_cmd = "poetry run mypy bot/ config/ --strict"
lint_cmd = "poetry run ruff check bot/ config/"

[notifications]                     # 선택. 프로젝트별 알림 채널 (CI 외부 알림용, 봇 runtime과 독립)
discord_webhook_env = "DISCORD_WEBHOOK_URL"
```

## 필드 상세

### `schema_version` (필수, string)

이 문서 발간 버전. 하네스 런타임이 미지원 버전 감지 시 경고 + 안전 모드(기본 hook no-op 유지).

### `[project]`

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `name` | string | ✅ | 프로젝트 식별자. 글로벌 slash command `/harness-meta <name>`의 target. 하네스-meta repo의 `sessions/{name}/`, `projects/{name}/`와 일치 |
| `language` | string | ✅ | 주 언어. bootstrap 인터뷰 재현·템플릿 선택 힌트 |
| `package_manager` | string | ✅ | 의존성 관리자. 하네스가 테스트·lint 명령 조립 시 힌트 |
| `python_version` / `node_version` / … | string | 선택 | 언어별 버전 pin 힌트 |

### `[harness]`

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `code_dir` | string | ✅ | 하네스 코어 코드 디렉토리 (프로젝트 루트 기준 상대). `session-init.sh`가 "하네스 활성" 판정 시 이 경로 존재 확인 |
| `phases_dir` | string | ✅ | `phases/` 디렉토리 위치. 기본값 `"phases"` |
| `guardrails` | string | 선택 | GUARDRAILS.md 위치. 부재 시 하네스는 `code_dir/../docs/GUARDRAILS.md` fallback 또는 경고 |
| `mcp_server` | string | 선택 | `.mcp.json`의 서버 이름. 기본값 `"harness"` (글로벌 slash command 가정값) |
| `executor` | string | 선택 | CLI entrypoint. 기본값 `code_dir/../execute.py` 추정. statusline이 `--status`로 호출 |

### `[architecture]`

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `meta_ref` | string | ✅ | harness-meta repo 내부 경로 (`projects/{name}/ARCHITECTURE.md` 관례). 프로젝트 `CLAUDE.md`의 `@~/harness-meta/{meta_ref}` include 대상 |

### `[testing]` (선택)

REPORT 자동 수집 시 실행할 명령. 부재 시 하네스는 언어·패키지매니저 기본값을 추론.

### `[notifications]` (선택)

프로젝트별 알림 채널. 하네스 세션 완료·실패 알림 대상(봇 runtime 알림과 독립).

## 참조 관계

```
.harness.toml
  ├─ [project].name            ── session-init.sh: 프로젝트 식별
  ├─ [harness].code_dir        ── session-init.sh: 하네스 활성 판정
  │                            ── statusline.sh: execute.py 위치 추정
  ├─ [harness].phases_dir      ── 글로벌 slash command: phases 경로 주입
  ├─ [harness].guardrails      ── harness builders.load_guardrails()
  ├─ [harness].executor        ── statusline.sh: `<executor> --status` 호출
  └─ [architecture].meta_ref   ── 프로젝트 CLAUDE.md의 import 타겟
```

## upbit 예시

```toml
schema_version = "1.0"

[project]
name = "upbit"
language = "python"
package_manager = "poetry"
python_version = "3.12"

[harness]
code_dir = "scripts/harness"
phases_dir = "phases"
guardrails = "docs/GUARDRAILS.md"
mcp_server = "harness"
executor = "scripts/execute.py"

[architecture]
meta_ref = "projects/upbit/ARCHITECTURE.md"

[testing]
test_cmd = "poetry run pytest tests/ -q"
harness_test_cmd = "poetry run pytest scripts/tests/ -q"
type_check_cmd = "poetry run mypy bot/ config/ --strict"
lint_cmd = "poetry run ruff check bot/ config/"

[notifications]
discord_webhook_env = "DISCORD_WEBHOOK_URL"
```

## 파싱 가이드

### Bash (hook·statusline 최소 경로)

```bash
# 프로젝트 이름 추출 (grep + sed)
project_name=$(grep -E '^name\s*=\s*"' .harness.toml | head -1 | sed -E 's/^name\s*=\s*"([^"]+)"/\1/')

# code_dir 추출
code_dir=$(grep -E '^code_dir\s*=\s*"' .harness.toml | head -1 | sed -E 's/^code_dir\s*=\s*"([^"]+)"/\1/')
```

### Python (깊은 파싱)

```python
import tomllib
from pathlib import Path

manifest = tomllib.loads(Path(".harness.toml").read_text(encoding="utf-8"))
project_name = manifest["project"]["name"]
code_dir = Path(manifest["harness"]["code_dir"])
```

## 향후 확장

- `schema_version = "1.1"`부터 예상 필드: `[ci]` (GitHub Actions workflow 경로), `[worktree]` (병렬 실행 힌트)
- breaking change는 `2.0`으로 bump. 하네스 런타임은 major 불일치 시 경고 + 기능 축소 모드

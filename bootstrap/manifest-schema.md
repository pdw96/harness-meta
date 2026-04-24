# `.harness.toml` — 프로젝트 매니페스트 스펙

하네스를 도입한 프로젝트가 루트에 두는 **단일 설정 파일**. 글로벌 `session-init.sh` hook과 `statusline.sh`가 CWD에서 이 파일을 찾아 프로젝트 메타를 로드한다. 부재 시 하네스 비활성 프로젝트 → hook/statusline **no-op**.

## 1. 설계 원칙

- **1 파일 · 평탄 · 읽기 전용**: 하네스 런타임이 수정하지 않는다. 사용자 수동 또는 bootstrap 세션이 생성.
- **경로는 프로젝트 루트 기준 상대경로**. 절대경로 금지 (이식성).
- **파싱 단순성**: 핵심 필드(`[project].name`, `[harness].code_dir`, `[harness].phases_dir`, `[harness].state_file`, `[harness].statusline_cmd`)는 `grep + sed` 만으로 추출 가능.
- **Additive 진화**: `schema_version` SemVer. minor bump = additive only (breaking 0), major bump = breaking change. 현재 `"1.1"`.
- **Backward compatibility**: 모든 v1.0 매니페스트(upbit 포함)는 무수정으로 v1.1 도구와 동작.

## 2. v1.0 → v1.1 변경 요약

| 분류 | 건수 | 상세 |
|------|:---:|------|
| Breaking | **0** | — |
| Deprecated (retained) | 1 | `[project].python_version` → `[project].runtime_version` 권장 |
| Additive (신규 필드) | 9 | `runtime_version`, `locale`, `statusline_cmd`, `statusline_timeout_ms`, `state_file`, `[agents].primary`, `[agents].secondary`, `[build]` 3필드, `[testing].format_cmd` |
| Additive (신규 섹션) | 2 | `[agents]`, `[build]` |

**결론**: v1.0 매니페스트는 **무변경으로 v1.1 도구와 100% 호환**. 신규 기능이 필요한 프로젝트만 선택적 필드 추가.

## 3. 파싱 호환성 제약

글로벌 `session-init.sh` / `statusline.sh`는 TOML 정식 파서가 아닌 **grep + sed** 방식으로 핵심 필드를 추출한다. 제약:

- **같은 이름의 키를 여러 섹션에 두지 말 것** — grep 첫 hit만 잡음 (섹션 순서 의존)
- **섹션 순서 권장**: `[project]` → `[harness]` → `[agents]` → `[architecture]` → `[build]` → `[testing]` → `[notifications]`
- **중첩 테이블 `[a.b]` 금지** — 평탄 구조만
- **한 줄에 여러 키 선언 금지** — `key = "value"` 한 줄에 한 키
- **트레일링 주석 허용** — `key = "val"  # comment` OK. `#`으로 시작하는 라인은 파싱 제외
- **주석 처리된 핵심 키 주의** — `# code_dir = ...` 주석 내에 핵심 키 쓰면 grep 오탐 가능. 주석 대신 **삭제 권장**
- **배열 값 bash 파싱 불가** — `secondary = ["cursor", "aider"]` 등은 tomllib 필요. bash hook은 해석하지 않음
- **숫자·boolean 값 bash string 추출만** — `statusline_timeout_ms = 3000` 같은 숫자는 사용자 `"3000"` 문자열로 써도 하네스 현재 구현은 동작 무관 (hook이 숫자 필드 읽지 않음)

v2.0에서 tomllib 기반 parser 도입 검토 중. 그 전까지 위 제약 준수.

## 4. 현행 버전

`schema_version = "1.1"` — SemVer minor (additive only, breaking 0). `"1.0"` 매니페스트도 계속 지원.

**SemVer 규칙 적용**:
- MINOR bump (1.0 → 1.1) = additive, 호환
- MAJOR bump (1.x → 2.0) = breaking, 마이그레이션 필요
- String 비교 시 SemVer ordering: `"1.10"` > `"1.9"` > `"1.1"`

## 5. 전체 스키마 (v1.1)

```toml
schema_version = "1.1"

[project]
name = "my-project"                     # 필수. 식별자. hyphen↔underscore 동치
language = "python"                     # 필수. python | typescript | javascript | go | rust | java | kotlin | csharp | ...
package_manager = "uv"                  # 필수. uv | poetry | pip | pnpm | npm | bun | yarn | go-mod | cargo | gradle | maven | dotnet | ...
runtime_version = "3.12"                # 선택 (v1.1 신규, 통일). 값 해석은 language 조합
locale = "en"                           # 선택 (v1.1 신규). 기본 "en". "ko" 등 지정 시 bootstrap이 언어별 symlink 선택 (v1.10+)
# python_version = "3.12"               # deprecated (v1.0). runtime_version 권장

[harness]
code_dir = "scripts/harness"            # 필수. 프로젝트 하네스 실행기 코드 위치
phases_dir = "phases"                   # 필수. 실행 산출물 루트. 기본 "phases"
guardrails = "docs/GUARDRAILS.md"       # 선택. step-level 주입용 압축 규칙 (5120 byte 상한). AGENTS.md와 다름 (§7-Guardrails 참조)
mcp_server = "harness"                  # 선택. .mcp.json의 서버 이름. 기본 "harness"
executor = "scripts/execute.py"         # 선택. 프로젝트 CLI entrypoint (언어별)
statusline_cmd = "python3 scripts/harness/statusline_stats.py"  # 선택 (v1.1 정식). statusline 출력 생성 명령
statusline_timeout_ms = 3000            # 선택 (v1.1 신규). statusline_cmd 실행 timeout (ms). hook 구현 하드코딩 3000과 일치
state_file = "phases/.harness-state.txt"  # 선택 (v1.1 정식). session-init이 cat해서 주입할 상태 텍스트 경로

[agents]                                # 선택 (v1.1 신규). 실 해석 v1.8+
primary = "claude-code"                 # 기본 "claude-code". 선택: cursor, codex-cli, gemini-cli, windsurf, cline, aider
secondary = ["cursor", "aider"]         # ⚠️ 배열 — bash 파싱 불가. tomllib 기반 도구(v1.8+)만 사용

[architecture]
meta_ref = "projects/<name>/ARCHITECTURE.md"  # 필수. harness-meta repo 내부 경로

[build]                                 # 선택 (v1.1 신규). 컴파일 언어 전용. 실 해석 v1.8+
tool = "cargo"                          # cargo | gradle | maven | go | dotnet | msbuild | cmake | ...
build_cmd = "cargo build --release"
artifact_dir = "target/release"

[testing]                               # 선택
test_cmd = "uv run pytest"
harness_test_cmd = "uv run pytest scripts/tests/"   # 선택
type_check_cmd = "uv run mypy src"                  # 선택 (컴파일 언어는 빈 값 허용)
lint_cmd = "uv run ruff check"
format_cmd = "uv run ruff format --check"           # v1.1 신규. 실 해석 v1.8+ harness-review

[notifications]                         # 선택
discord_webhook_env = "DISCORD_WEBHOOK_URL"
```

## 6. 필드 상세

### 6.1. `schema_version` (필수, string)

v1.1 기준 `"1.1"`. 미지정 시 하네스 런타임(v2.0+ tomllib parser)은 `"1.0"`으로 가정하고 deprecated 필드 WARN. 현 bash hook은 읽지 않음.

### 6.2. `[project]`

| 필드 | 타입 | 필수 | 버전 | 설명 |
|---|---|---|---|---|
| `name` | string | ✅ | 1.0 | 프로젝트 식별자. `/harness-meta <name>` target. `sessions/{name}/`, `projects/{name}/` 일치 |
| `language` | string | ✅ | 1.0 | 주 언어 |
| `package_manager` | string | ✅ | 1.0 | 의존성 관리자 |
| `runtime_version` | string | 선택 | 1.1 | 언어 런타임 버전 pin. 값 해석은 `language` 조합 (Python "3.12", Node "20.x", Go "1.22") |
| `locale` | string | 선택 | 1.1 | 작업 언어. 기본 "en". ISO 639-1 2자 또는 RFC 5646. 실 해석 bootstrap(v1.10+) |
| `python_version` | string | 선택 | 1.0 (deprecated) | `runtime_version` 권장. retained for backward compat |

### 6.3. `[harness]`

| 필드 | 타입 | 필수 | 버전 | 설명 |
|---|---|---|---|---|
| `code_dir` | string | ✅ | 1.0 | 하네스 코어 코드 디렉토리 |
| `phases_dir` | string | ✅ | 1.0 | phases 디렉토리. 기본 `"phases"` |
| `guardrails` | string | 선택 | 1.0 | step-level 주입 규칙 (5120 byte 상한). AGENTS.md와 다름 |
| `mcp_server` | string | 선택 | 1.0 | `.mcp.json`의 서버 이름. 기본 `"harness"` |
| `executor` | string | 선택 | 1.0 | 프로젝트 CLI entrypoint (언어별) |
| `statusline_cmd` | string | 선택 | 1.1 | statusline 출력 생성 명령. 프로젝트 루트에서 실행. stdout 전체 = statusline 텍스트 |
| `statusline_timeout_ms` | int | 선택 | 1.1 | statusline_cmd timeout (ms). 기본 3000. hook 구현 하드코딩 일치 |
| `state_file` | string | 선택 | 1.1 | session-init이 cat해서 additionalContext에 주입할 텍스트 파일 경로 |

### 6.4. `[agents]` (v1.1 신규)

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `primary` | string | 선택 | 주 adapter. 기본 `"claude-code"`. 값: `claude-code` \| `cursor` \| `codex-cli` \| `gemini-cli` \| `windsurf` \| `cline` \| `aider` |
| `secondary` | array | 선택 | 추가 대응 adapter 목록. ⚠️ bash 파싱 불가 |

**실 해석 시점**: v1.8-core-adapter-split에서 각 adapter 디렉토리 분기. 현재는 선언만.

### 6.5. `[architecture]`

| 필드 | 타입 | 필수 | 버전 | 설명 |
|---|---|---|---|---|
| `meta_ref` | string | ✅ | 1.0 | harness-meta repo 내부 경로. 프로젝트 `CLAUDE.md`의 `@~/harness-meta/{meta_ref}` include 대상 |

### 6.6. `[build]` (v1.1 신규)

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `tool` | string | 선택 | 빌드 도구: `cargo` \| `gradle` \| `maven` \| `go` \| `dotnet` \| `msbuild` \| `cmake` |
| `build_cmd` | string | 선택 | 빌드 명령 전문 |
| `artifact_dir` | string | 선택 | 빌드 산출물 디렉토리 |

**실 해석 시점**: v1.8+ harness-ship 확장. 현재는 선언만. Python/TS 인터프리터 언어는 섹션 생략.

### 6.7. `[testing]`

| 필드 | 타입 | 필수 | 버전 | 설명 |
|---|---|---|---|---|
| `test_cmd` | string | 선택 | 1.0 | 메인 테스트 명령 |
| `harness_test_cmd` | string | 선택 | 1.0 | 하네스 자체 테스트 명령 |
| `type_check_cmd` | string | 선택 | 1.0 | 타입 체크 명령 (컴파일 언어는 빈 값 허용) |
| `lint_cmd` | string | 선택 | 1.0 | 린트 명령 |
| `format_cmd` | string | 선택 | 1.1 | 포맷 검증 명령 (신규). 실 해석 v1.8+ harness-review 확장 |

### 6.8. `[notifications]`

| 필드 | 타입 | 필수 | 설명 |
|---|---|---|---|
| `discord_webhook_env` | string | 선택 | Discord webhook URL이 담긴 환경변수 이름 |

## 7. 관계 명시

### 7.1. `mcp_server` vs `agents.primary`

두 필드는 **서로 다른 레이어**를 지칭한다:

- `[harness].mcp_server` — **MCP 프로토콜 내부**: `.mcp.json`의 서버 등록 이름 (예: `"harness"`). 주로 Claude Code가 tool 호출에 사용
- `[agents].primary` — **툴 어댑터 상위**: 어느 AI 코딩 도구가 주로 사용되는지 (예: `"claude-code"`, `"cursor"`)

`primary = "cursor"` 프로젝트도 `mcp_server = "harness"` 유지 가능. 두 필드는 **겹치지 않음**.

### 7.2. `guardrails` vs AGENTS.md

- `[harness].guardrails` → **step-level 압축 규칙** (`docs/GUARDRAILS.md`, 5120 byte 상한, UTF-8). 하네스 `builders`가 매 step 프롬프트에 주입
- `AGENTS.md` → **프로젝트 전체 컨텍스트** (60~150 라인 권장). AI 에이전트가 세션 시작 시 로드. 표준: [agents.md](https://agents.md/)

두 파일은 **독립** — GUARDRAILS.md는 step 실행 시 주입되는 압축 가드, AGENTS.md는 세션 전체 baseline.

## 8. bash 파싱 가능 / 불가 필드

| 필드 | bash grep | tomllib | 현재 해석 주체 |
|-----|:---------:|:-------:|--------------|
| `schema_version` | O | O | **dead** (문서화 only) |
| `[project].name` | O | O | hook, statusline |
| `[project].language` | O | O | 사용자/bootstrap |
| `[project].package_manager` | O | O | 사용자/bootstrap |
| `[project].runtime_version` | O | O | 사용자/bootstrap |
| `[project].locale` | O | O | bootstrap(v1.10+) |
| `[project].python_version` (deprecated) | O | O | 사용자 legacy |
| `[harness].code_dir` | O | O | hook (존재 확인) |
| `[harness].phases_dir` | O | O | hook, statusline |
| `[harness].guardrails` | O | O | harness builders |
| `[harness].mcp_server` | O | O | `.mcp.json` 교차 |
| `[harness].executor` | O | O | 문서화, v1.8+ |
| `[harness].statusline_cmd` | O | O | statusline (v1.6) |
| `[harness].statusline_timeout_ms` | O | O | statusline (v1.6 구현은 하드코딩 3000. 필드 override는 tomllib 파서에서) |
| `[harness].state_file` | O | O | session-init (v1.6) |
| `[agents].primary` | O | O | **dead** (v1.8+) |
| `[agents].secondary` (array) | **X** | O | **dead** (v1.8+) |
| `[architecture].meta_ref` | O | O | CLAUDE.md @import |
| `[build].tool` | O | O | **dead** (v1.8+) |
| `[build].build_cmd` | O | O | **dead** (v1.8+) |
| `[build].artifact_dir` | O | O | **dead** (v1.8+) |
| `[testing].test_cmd` | O | O | harness-ship/review |
| `[testing].harness_test_cmd` | O | O | 동일 |
| `[testing].type_check_cmd` | O | O | 동일 |
| `[testing].lint_cmd` | O | O | 동일 |
| `[testing].format_cmd` | O | O | **dead** (v1.8+ review 확장) |
| `[notifications].discord_webhook_env` | O | O | 프로젝트 runtime |

**Dead field 현황**: 6개 (schema_version, [agents].primary, [agents].secondary, [build] 3필드, format_cmd). v1.8+ 세션에서 해석 주체 도입 예정.

## 9. 하위 호환 매트릭스

| 필드 | v1.0 동작 | v1.1 동작 | 마이그레이션 |
|------|---------|---------|-----------|
| `schema_version = "1.0"` | 유효 | 계속 유효 | 변경 불필요 |
| `schema_version = "1.1"` | — | 유효 | 신규 프로젝트 권장 |
| `[project].python_version` | 필수 (Python) | deprecated retained | `runtime_version` 병기 또는 교체 (선택) |
| `runtime_version` 부재 | — | OK, 기본 해석 없음 | — |
| `locale` 부재 | — | default "en" | 영문 사용자 생략 |
| `statusline_cmd` 부재 | — | minimal `[harness] {name}` fallback | 부재 무방 |
| `state_file` 부재 | — | "phases directory exists" minimal | 부재 무방 |
| `[agents]` 부재 | — | default primary="claude-code" | 기존 Claude Code 프로젝트 무영향 |
| `[build]` 부재 | — | skip (인터프리터 언어) | — |
| `format_cmd` 부재 | — | skip | — |

**Breaking 0, 필수 추가 0**. upbit 등 기존 v1.0 매니페스트 **무수정 계속 동작**.

## 10. 다언어 예시 (4종)

### 10.1. Python + uv

```toml
schema_version = "1.1"

[project]
name = "example-py"
language = "python"
package_manager = "uv"
runtime_version = "3.12"
locale = "en"

[harness]
code_dir = "scripts/harness"
phases_dir = "phases"
guardrails = "docs/GUARDRAILS.md"
mcp_server = "harness"
executor = "scripts/execute.py"
statusline_cmd = "python3 scripts/harness/statusline_stats.py"
statusline_timeout_ms = 3000
state_file = "phases/.harness-state.txt"

[agents]
primary = "claude-code"

[architecture]
meta_ref = "projects/example-py/ARCHITECTURE.md"

[testing]
test_cmd = "uv run pytest"
type_check_cmd = "uv run mypy src"
lint_cmd = "uv run ruff check"
format_cmd = "uv run ruff format --check"
```

### 10.2. TypeScript + pnpm

```toml
schema_version = "1.1"

[project]
name = "example-ts"
language = "typescript"
package_manager = "pnpm"
runtime_version = "20.x"
locale = "en"

[harness]
code_dir = "scripts/harness"
phases_dir = "phases"
executor = "pnpm tsx scripts/execute.ts"
statusline_cmd = "pnpm tsx scripts/harness/statusline.ts"
statusline_timeout_ms = 3000
state_file = "phases/.harness-state.txt"

[agents]
primary = "claude-code"
secondary = ["cursor"]

[architecture]
meta_ref = "projects/example-ts/ARCHITECTURE.md"

[build]
tool = "tsc"
build_cmd = "pnpm build"
artifact_dir = "dist"

[testing]
test_cmd = "pnpm test"
type_check_cmd = "pnpm tsc --noEmit"
lint_cmd = "pnpm biome check"
format_cmd = "pnpm biome format --check"
```

### 10.3. Go

```toml
schema_version = "1.1"

[project]
name = "example-go"
language = "go"
package_manager = "go-mod"
runtime_version = "1.22"
locale = "en"

[harness]
code_dir = "internal/harness"
phases_dir = "phases"
executor = "go run ./cmd/execute"
statusline_cmd = "go run ./cmd/harness-statusline"
statusline_timeout_ms = 3000
state_file = "phases/.harness-state.txt"

[agents]
primary = "claude-code"

[architecture]
meta_ref = "projects/example-go/ARCHITECTURE.md"

[build]
tool = "go"
build_cmd = "go build ./..."
artifact_dir = "bin"

[testing]
test_cmd = "go test ./..."
lint_cmd = "golangci-lint run"
format_cmd = "gofmt -l ."
```

### 10.4. Rust

```toml
schema_version = "1.1"

[project]
name = "example-rs"
language = "rust"
package_manager = "cargo"
runtime_version = "1.78"
locale = "en"

[harness]
code_dir = "src/harness"
phases_dir = "phases"
executor = "./target/release/harness-execute"
statusline_cmd = "./target/release/harness-statusline"
statusline_timeout_ms = 3000
state_file = "phases/.harness-state.txt"

[agents]
primary = "claude-code"

[architecture]
meta_ref = "projects/example-rs/ARCHITECTURE.md"

[build]
tool = "cargo"
build_cmd = "cargo build --release"
artifact_dir = "target/release"

[testing]
test_cmd = "cargo test"
lint_cmd = "cargo clippy -- -D warnings"
format_cmd = "cargo fmt --check"
```

**참고**: upbit 현 매니페스트는 `schema_version = "1.0"` Python/Poetry 기반으로 계속 작동. upbit의 v1.1 upgrade는 별도 세션에서 수행.

## 11. 파싱 가이드

### 11.1. Bash (hook / statusline 최소 경로)

```bash
# 최소 필드 추출 예시 (session-init.sh / statusline.sh 참조)
project_name=$(grep -E '^name[[:space:]]*=[[:space:]]*"' .harness.toml | head -1 \
    | sed -E 's/^name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
state_file=$(grep -E '^state_file[[:space:]]*=[[:space:]]*"' .harness.toml | head -1 \
    | sed -E 's/^state_file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
statusline_cmd=$(grep -E '^statusline_cmd[[:space:]]*=[[:space:]]*"' .harness.toml | head -1 \
    | sed -E 's/^statusline_cmd[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
```

### 11.2. Python (깊은 파싱, v2.0+ 예상)

```python
import tomllib
from pathlib import Path

manifest = tomllib.loads(Path(".harness.toml").read_text(encoding="utf-8"))
project_name = manifest["project"]["name"]
code_dir = Path(manifest["harness"]["code_dir"])
primary_agent = manifest.get("agents", {}).get("primary", "claude-code")
secondary_agents = manifest.get("agents", {}).get("secondary", [])  # array OK
```

## 12. 마이그레이션 가이드 + 향후 확장

### 12.1. v1.0 → v1.1 마이그레이션

**아무것도 안 해도 작동**. v1.0 매니페스트는 v1.1 도구로 문제없이 로드.

선택 업그레이드:
1. `schema_version = "1.1"` 로 bump (문서화 목적)
2. `python_version` → `runtime_version` (권장)
3. statusline 풍부한 출력 원하면: `[harness].statusline_cmd` + `state_file` 추가
4. 타 adapter 지원 선언: `[agents].primary` + `secondary`
5. 컴파일 언어 빌드 분리: `[build]` 섹션
6. format 검증 분리: `[testing].format_cmd`

### 12.2. 향후 확장

- **v1.2 후보**: `[ci]` (GitHub Actions 경로), `[worktree]` (병렬 실행 힌트), `[notifications]` 확장 (Slack/Teams)
- **v2.0 (breaking)**: tomllib parser 도입, deprecated 필드 제거 (`python_version`), 스키마 검증 CLI 도구
- **재평가 게이트**: v1.1 신규 필드 실사용 3+ 프로젝트 확보 후 재논의

## 관련 문서

- 세션 소속 규약: `docs/OWNERSHIP.md`
- AGENTS.md 채택 규약: `docs/AGENTS_MD_STRATEGY.md`
- 최신 스키마 변경 세션: `sessions/meta/v1.7-manifest-schema-v1.1/`
- 외부 참조: [SemVer](https://semver.org/) · [agents.md](https://agents.md/)

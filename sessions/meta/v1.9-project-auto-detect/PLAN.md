# meta v1.9-project-auto-detect — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.8b-commands-to-skills-migration/`](../v1.8b-commands-to-skills-migration/REPORT.md)
목적: 프로젝트 루트 파일 시그니처를 검사하여 **언어·패키지매니저·테스트명령** 자동 감지. bootstrap 인터뷰(v1.10+) 및 `.harness.toml` 초기값 생성을 위한 힌트 제공. bash-only 스크립트로 cross-platform.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `bootstrap/detect-project.sh` 신규 + `bootstrap/docs/DETECTION.md` 신규 + fixture + smoke → 전부 **S2**.
- **T1** S2 단일 scope → meta.

## 배경

### 목표 — Bootstrap 힌트 자동화

v1.10 `/harness-meta <new-name>` bootstrap 모드에서 사용자에게 인터뷰 질문 시, 자동 감지 결과를 **기본값 추천**으로 제공. 사용자는 확정만 하거나 override.

**현재**: 전부 수동 입력 (언어, PM, test_cmd 등) → 오탐/오입력 가능
**목표**: detect-project.sh가 감지 → interview.md가 제안 → 사용자 확정

### 감지 대상

| 언어 | Signature | PM 후보 |
|------|-----------|---------|
| Python | `pyproject.toml` or `setup.py` or `requirements.txt` | uv (`uv.lock`) > poetry (`[tool.poetry]`) > pip (`requirements.txt`) > pdm (`pdm.lock`) > rye (`rye.lock`) > hatch (`hatch.toml`) |
| Node (TS/JS) | `package.json` | pnpm (`pnpm-lock.yaml`) > bun (`bun.lockb`) > yarn (`yarn.lock`) > npm (`package-lock.json`) |
| Go | `go.mod` | go-mod (단일) |
| Rust | `Cargo.toml` | cargo (단일) |
| Java | `pom.xml` or `build.gradle[.kts]` | maven (`pom.xml`) / gradle (`build.gradle` or `build.gradle.kts`) |
| Kotlin | `build.gradle.kts` + `src/main/kotlin/` | gradle |
| C#/.NET | `*.csproj` or `*.sln` | dotnet |
| Ruby | `Gemfile` | bundler |
| Elixir | `mix.exs` | mix |

### TypeScript vs JavaScript

`package.json`에 `typescript` devDep 또는 `tsconfig.json` 존재 → TS, 아니면 JS.

### Monorepo 힌트

- `pnpm-workspace.yaml` → pnpm workspace
- `turbo.json` → Turborepo
- `nx.json` → Nx
- Cargo workspace: `[workspace]` in `Cargo.toml`
- Go workspace: `go.work`

### 감지 알고리즘 (bash-only)

```
1. 우선순위 표(lockfile > config)로 순차 test -f
2. 첫 매치 = 해당 언어·PM
3. 복합 (e.g. package.json + Cargo.toml) → polyglot 표시
4. test_cmd 힌트: package.json scripts.test / pyproject.toml scripts / 등
5. 출력: TOML snippet (stdout) or `--json` 옵션
```

### 한계 (명시)

- 감지는 **힌트** — 사용자 확정 필수
- custom 구조 (e.g. Python+Makefile) 완전 감지 불가
- monorepo 내 복수 언어: 최상위만 감지, 하위 패키지는 미지원

## 목표

- [ ] `bootstrap/detect-project.sh` 신규 — 프로젝트 루트 인자 받아 언어·PM·테스트명령 감지 후 TOML snippet 출력
- [ ] `bootstrap/docs/DETECTION.md` 신규 — 감지 규칙 + 우선순위 + 한계 + 확장 가이드
- [ ] fixture 4: Python/uv, Node/pnpm, Go, Rust (각 최소 signature 파일)
- [ ] smoke — 4 fixture 실행 → 각 기대 TOML 출력
- [ ] 매니페스트 fixture와 **별개** (감지 결과는 매니페스트 작성 힌트)
- [ ] Grey Area 결정
- [ ] 커밋 + push

## 범위

**포함**:
- `detect-project.sh` bash-only (cross-platform)
- 감지 규칙 문서화
- 4 언어 fixture + smoke
- 세션 기록

**제외 (T4 / 후속)**:
- Interview 통합 (`/harness-meta <new>` 흐름) → v1.10
- 감지 결과로 `.harness.toml` 자동 생성 → v1.10 또는 v1.22
- 폴리글랏 monorepo 다중 감지 → v1.23
- Tier 2 언어(Ruby/PHP/Swift/Elixir 등) → v1.24+ 커뮤니티
- JSON 출력 (`--json` flag) — TOML만 v1.9, JSON은 후속
- Python lockfile 세부 구분 (poetry v1 vs v2 detection) → v1.11+ templates
- 매니페스트 schema 1.1 `runtime_version` 자동 pin → v1.10 interview

## 변경 대상

### 신규 (2 + fixture 4 + smoke + 세션)

| 경로 | 역할 |
|------|------|
| `bootstrap/detect-project.sh` | 감지 bash 스크립트 |
| `bootstrap/docs/DETECTION.md` | 규칙·우선순위·확장 문서 |
| `tests/fixtures/detect-python-uv/pyproject.toml` + `uv.lock` | |
| `tests/fixtures/detect-node-pnpm/package.json` + `pnpm-lock.yaml` | |
| `tests/fixtures/detect-go/go.mod` | |
| `tests/fixtures/detect-rust/Cargo.toml` + `Cargo.lock` | |
| `sessions/meta/v1.9-project-auto-detect/{PLAN,REPORT,evidence/smoke-detect.txt}` | |

## detect-project.sh 설계

```bash
#!/usr/bin/env bash
# 프로젝트 루트 파일 시그니처로 언어·PM·test_cmd 힌트 추출
# Usage: bash detect-project.sh [<project-root>]
# Output: TOML snippet (stdout) — .harness.toml의 [project] + [testing] 섹션 힌트
set -e

ROOT="${1:-$PWD}"
ROOT="$(cd "$ROOT" && pwd)"

has() { [ -e "$ROOT/$1" ]; }
has_content() { [ -f "$ROOT/$1" ] && grep -q "$2" "$ROOT/$1" 2>/dev/null; }

# 1. 언어·PM 감지 (우선순위)
lang=""
pm=""
runtime_version=""
test_cmd=""
lint_cmd=""

# Python
if has pyproject.toml; then
    lang="python"
    if has uv.lock; then pm="uv"; test_cmd="uv run pytest"; lint_cmd="uv run ruff check"
    elif has_content pyproject.toml "\[tool.poetry\]"; then pm="poetry"; test_cmd="poetry run pytest"; lint_cmd="poetry run ruff check"
    elif has pdm.lock; then pm="pdm"; test_cmd="pdm run pytest"
    elif has rye.lock; then pm="rye"; test_cmd="rye run pytest"
    else pm="pip"; test_cmd="pytest"
    fi
elif has requirements.txt; then
    lang="python"; pm="pip"; test_cmd="pytest"
elif has setup.py; then
    lang="python"; pm="pip"; test_cmd="pytest"
# Node (TS/JS)
elif has package.json; then
    if has tsconfig.json; then lang="typescript"; else lang="javascript"; fi
    if has pnpm-lock.yaml; then pm="pnpm"; test_cmd="pnpm test"
    elif has bun.lockb; then pm="bun"; test_cmd="bun test"
    elif has yarn.lock; then pm="yarn"; test_cmd="yarn test"
    elif has package-lock.json; then pm="npm"; test_cmd="npm test"
    else pm="npm"; test_cmd="npm test"
    fi
# Go
elif has go.mod; then
    lang="go"; pm="go-mod"; test_cmd="go test ./..."; lint_cmd="go vet ./..."
# Rust
elif has Cargo.toml; then
    lang="rust"; pm="cargo"; test_cmd="cargo test"; lint_cmd="cargo clippy -- -D warnings"
# Java/Kotlin
elif has build.gradle.kts; then
    if [ -d "$ROOT/src/main/kotlin" ]; then lang="kotlin"; else lang="java"; fi
    pm="gradle"; test_cmd="./gradlew test"
elif has build.gradle; then
    lang="java"; pm="gradle"; test_cmd="./gradlew test"
elif has pom.xml; then
    lang="java"; pm="maven"; test_cmd="mvn test"
# .NET
elif ls "$ROOT"/*.csproj "$ROOT"/*.sln 2>/dev/null | grep -q .; then
    lang="csharp"; pm="dotnet"; test_cmd="dotnet test"
# Ruby
elif has Gemfile; then
    lang="ruby"; pm="bundler"; test_cmd="bundle exec rspec"
# Elixir
elif has mix.exs; then
    lang="elixir"; pm="mix"; test_cmd="mix test"
fi

# 2. Monorepo 감지 (informational)
monorepo=""
if has pnpm-workspace.yaml; then monorepo="pnpm-workspace"
elif has turbo.json; then monorepo="turborepo"
elif has nx.json; then monorepo="nx"
elif has go.work; then monorepo="go-workspace"
elif has Cargo.toml && has_content Cargo.toml "\[workspace\]"; then monorepo="cargo-workspace"
fi

# 3. 출력
cat <<EOF
# Auto-detected hints for $ROOT
# (Override freely in your final .harness.toml)

[project]
language = "${lang:-unknown}"
package_manager = "${pm:-unknown}"
${runtime_version:+runtime_version = \"$runtime_version\"}

[testing]
${test_cmd:+test_cmd = \"$test_cmd\"}
${lint_cmd:+lint_cmd = \"$lint_cmd\"}
${monorepo:+# monorepo detected: $monorepo}
EOF
```

## Grey Areas — 결정

| ID | 질문 | 결정 |
|----|------|------|
| G1 | JSON 출력 vs TOML only | **TOML only** (매니페스트와 동일 포맷). JSON은 별도 세션 |
| G2 | uv vs poetry 공존 pyproject.toml | uv.lock 우선 (lockfile이 실행 도구 결정). poetry v2는 `[tool.poetry]` 섹션 존재로 구분 |
| G3 | Java/Kotlin 혼재 | `src/main/kotlin/` 디렉토리 유무로 분기 |
| G4 | Python runtime_version 추출 | **v1.9 범위 외** — pyproject.toml `requires-python` 파싱 복잡. v1.10 interview에서 사용자 확정 |
| G5 | Node runtime_version | `.nvmrc` / `engines.node` — v1.10 |
| G6 | Unknown language 처리 | `language = "unknown"` + 사용자 수동 입력 지시 |
| G7 | Polyglot 감지 | **단일 언어만** v1.9 — 최상위 시그니처 기준. Monorepo는 주석으로 표시 |
| G8 | 감지 결과 `.harness.toml` 자동 생성 | **No** — 힌트만, 사용자 확정 필수 |
| G9 | Windows path 처리 | bash(Git Bash) 기본 / 경로 forward slash |
| G10 | PS port | **bash 단일** — cross-platform 충분. PS 필요 시 후속 |
| G11 | fixture 4개 최소 | Python/uv + Node/pnpm + Go + Rust — 가장 흔한 4 |
| G12 | Tier 2 언어 fixture | v1.24+ 커뮤니티 |
| G13 | detect가 .mcp.json 감지 | **No** — 별개 관심사 |
| G14 | runtime_version 필드 누락 | OK, 사용자가 v1.10에서 추가 |
| G15 | test_cmd가 없을 때 | 빈 문자열 skip |

## 성공 기준

- [ ] `detect-project.sh` 실행 시 각 fixture에서 기대 TOML 출력
- [ ] `DETECTION.md` 우선순위 표 + 한계 명시
- [ ] 4 fixture 존재
- [ ] smoke 4/4 PASS
- [ ] Grey Area 15건 결정
- [ ] 커밋 + push

## 커밋 전략

```
feat(meta): sessions/meta/v1.9-project-auto-detect — 프로젝트 자동 감지 스크립트

- add: bootstrap/detect-project.sh (bash-only, ~80 LOC)
    언어·PM·test_cmd·lint_cmd·monorepo 힌트 추출. TOML snippet 출력.
    9 언어 지원: python(uv/poetry/pdm/rye/pip), typescript/javascript(pnpm/bun/yarn/npm),
    go, rust, java(gradle/maven), kotlin(gradle), csharp, ruby, elixir.
- add: bootstrap/docs/DETECTION.md (규칙 + 우선순위 + 한계)
- add: tests/fixtures/detect-{python-uv,node-pnpm,go,rust}/ (4 fixture)
- add: sessions/meta/v1.9-project-auto-detect/{PLAN,REPORT,evidence/smoke-detect.txt}

v1.10 bootstrap interview의 힌트 제공 기반. 자동 생성 아니라 사용자 확정 필수.
Grey Area 15건. smoke 4/4 PASS.
```

## 후속

- v1.10 — bootstrap interview가 detect 결과 수용
- v1.11+ — 언어별 template overlay + detect 결과와 매핑

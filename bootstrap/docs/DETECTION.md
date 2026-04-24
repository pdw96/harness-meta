# `detect-project.sh` — 프로젝트 자동 감지

`bootstrap/detect-project.sh`는 프로젝트 루트 파일 시그니처를 검사하여 **언어·패키지매니저·테스트/린트 명령**을 감지하고 TOML snippet을 출력한다. v1.10+ bootstrap 인터뷰가 이 결과를 **기본값 추천**으로 사용자에게 제시.

## 설계 원칙

- **힌트 only** — 자동 `.harness.toml` 생성 아님. 사용자 확정 필수
- **Bash-only** — cross-platform (Git Bash / macOS / Linux)
- **단일 언어 top-level** — monorepo는 주석으로 표시, 하위 패키지 스캔 안 함
- **우선순위**: lockfile > config 파일 > 일반 패턴
- **확장 용이** — 새 언어/PM은 `elif` 블록 추가

## 지원 매트릭스 (v1.9)

| 언어 | 1차 Signature | PM 우선순위 | test_cmd 기본 |
|------|---------------|------------|-------------|
| **Python** | `pyproject.toml` | uv (`uv.lock`) > poetry (`[tool.poetry]`) > pdm (`pdm.lock`) > rye (`rye.lock`) > hatch > pip | `uv run pytest` / `poetry run pytest` / `pytest` 등 |
| **Python** | `requirements.txt` / `setup.py` (fallback) | pip | `pytest` |
| **TypeScript** | `package.json` + `tsconfig.json` | pnpm (`pnpm-lock.yaml`) > bun > yarn > npm | `pnpm test` 등 |
| **JavaScript** | `package.json` (no tsconfig) | 동일 | 동일 |
| **Go** | `go.mod` | go-mod | `go test ./...` |
| **Rust** | `Cargo.toml` | cargo | `cargo test` |
| **Kotlin** | `build.gradle.kts` + `src/main/kotlin/` | gradle | `./gradlew test` |
| **Java** | `build.gradle[.kts]` / `pom.xml` | gradle / maven | `./gradlew test` / `mvn test` |
| **C#/.NET** | `*.csproj` or `*.sln` | dotnet | `dotnet test` |
| **Ruby** | `Gemfile` | bundler | `bundle exec rspec` |
| **Elixir** | `mix.exs` | mix | `mix test` |

감지 안 될 경우: `language = "unknown"` 출력 → 사용자 수동 입력.

## 감지 우선순위 (탐색 순서)

1. Python family (pyproject → requirements → setup.py)
2. Node family (package.json)
3. Go
4. Rust
5. JVM (Kotlin more specific → Java Gradle → Java Maven)
6. .NET
7. Ruby
8. Elixir

**주의**: 여러 언어 공존 시(e.g. Python + Cargo.toml), **Python이 먼저 감지됨**. 진짜 polyglot monorepo는 v1.23+ 별도 세션.

## Monorepo 감지 (informational only)

- `pnpm-workspace.yaml` → `pnpm-workspace`
- `turbo.json` → `turborepo`
- `nx.json` → `nx`
- `go.work` → `go-workspace`
- `Cargo.toml` with `[workspace]` → `cargo-workspace`

출력은 TOML 주석으로만. 실제 monorepo 구조 처리는 별도.

## 사용 예

```bash
bash ~/harness-meta/bootstrap/detect-project.sh ~/my-project
```

출력 예 (Node/pnpm + Turborepo):
```toml
# Auto-detected hints for /home/user/my-project
# (User confirmation required — override freely in final .harness.toml)

[project]
language = "typescript"
package_manager = "pnpm"

[testing]
test_cmd = "pnpm test"
lint_cmd = "pnpm biome check"
format_cmd = "pnpm biome format --check"

# monorepo detected: turborepo
```

## 한계

- **Polyglot 불가**: 최상위 단일 언어만. Monorepo에 Python + TS + Go 공존하면 Python만 감지
- **Custom 구조 불가**: `Makefile`, shell scripts 등 비표준 설정은 무시
- **Runtime version 미감지**: `python 3.12` / `node 20.x` 등은 `requires-python`, `.nvmrc`, `engines.node` 등 복잡 파싱 필요 → v1.10 interview에서 사용자 확정
- **Framework 미감지**: Django / Next.js / FastAPI 등 프레임워크는 force_detect 못 함. 언어 + PM만 확정
- **Lockfile 없는 경우**: `package.json`만 있고 lock 없으면 default `npm` → 실제 pnpm/yarn일 수 있음

## 확장 가이드

새 언어 추가 시 `detect-project.sh`에 `elif has <signature>; then` 블록:

```bash
elif has Package.swift; then
    lang="swift"; pm="swift-pm"
    test_cmd="swift test"
    lint_cmd="swiftlint"
```

Tier 2/3 언어 (Swift/Dart/Haskell/OCaml 등)는 커뮤니티 PR 수용.

## v1.10 interview 통합 (계획)

```
1. detect-project.sh 실행 → TOML snippet 캡처
2. 인터뷰가 각 필드를 기본값으로 제시 ("language=python (감지됨). 변경? [y/N]")
3. 사용자 확정 → 최종 .harness.toml 작성
```

## 관련 문서

- `manifest-schema.md` — `.harness.toml` 스펙 (v1.1)
- `docs/OWNERSHIP.md` — 세션 소속 규약
- 최신 세션: `sessions/meta/v1.9-project-auto-detect/`

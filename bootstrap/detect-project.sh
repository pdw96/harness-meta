#!/usr/bin/env bash
# Auto-detect project language / package manager / test command from root file signatures.
# Output: TOML snippet (stdout) — .harness.toml의 [project] + [testing] 힌트.
# Usage:
#   bash detect-project.sh [<project-root>]
#
# Philosophy: hint only. Always requires user confirmation via interview (v1.10+).
# Limits: single-language top-level detection. Monorepo shown as comment.
#
# Supported (v1.9): Python (uv/poetry/pdm/rye/pip), TypeScript, JavaScript (pnpm/bun/yarn/npm),
#                   Go, Rust, Java/Kotlin (gradle/maven), C#/.NET, Ruby, Elixir.

set -e

ROOT="${1:-$PWD}"
ROOT="$(cd "$ROOT" && pwd)"

has() { [ -e "$ROOT/$1" ]; }
has_content() { [ -f "$ROOT/$1" ] && grep -q "$2" "$ROOT/$1" 2>/dev/null; }
has_glob() { compgen -G "$ROOT/$1" > /dev/null 2>&1; }

lang=""
pm=""
test_cmd=""
lint_cmd=""
format_cmd=""

# --- Python family ---
if has pyproject.toml; then
    lang="python"
    if has uv.lock; then
        pm="uv"
        test_cmd="uv run pytest"
        lint_cmd="uv run ruff check"
        format_cmd="uv run ruff format --check"
    elif has_content pyproject.toml "\[tool.poetry\]"; then
        pm="poetry"
        test_cmd="poetry run pytest"
        lint_cmd="poetry run ruff check"
    elif has pdm.lock; then
        pm="pdm"
        test_cmd="pdm run pytest"
    elif has rye.lock; then
        pm="rye"
        test_cmd="rye run pytest"
    elif has hatch.toml || has_content pyproject.toml "\[tool.hatch\]"; then
        pm="hatch"
        test_cmd="hatch run test"
    else
        pm="pip"
        test_cmd="pytest"
    fi
elif has requirements.txt; then
    lang="python"; pm="pip"; test_cmd="pytest"
elif has setup.py; then
    lang="python"; pm="pip"; test_cmd="pytest"

# --- Node family ---
elif has package.json; then
    if has tsconfig.json; then lang="typescript"; else lang="javascript"; fi
    if has pnpm-lock.yaml; then
        pm="pnpm"; test_cmd="pnpm test"
    elif has bun.lockb; then
        pm="bun"; test_cmd="bun test"
    elif has yarn.lock; then
        pm="yarn"; test_cmd="yarn test"
    elif has package-lock.json; then
        pm="npm"; test_cmd="npm test"
    else
        pm="npm"; test_cmd="npm test"
    fi
    if has biome.json; then
        lint_cmd="$pm biome check"
        format_cmd="$pm biome format --check"
    fi

# --- Go ---
elif has go.mod; then
    lang="go"; pm="go-mod"
    test_cmd="go test ./..."
    lint_cmd="go vet ./..."
    format_cmd="gofmt -l ."

# --- Rust ---
elif has Cargo.toml; then
    lang="rust"; pm="cargo"
    test_cmd="cargo test"
    lint_cmd="cargo clippy -- -D warnings"
    format_cmd="cargo fmt --check"

# --- JVM (Kotlin first — more specific) ---
elif has build.gradle.kts && [ -d "$ROOT/src/main/kotlin" ]; then
    lang="kotlin"; pm="gradle"
    test_cmd="./gradlew test"
    lint_cmd="./gradlew ktlintCheck"
    format_cmd="./gradlew ktlintFormat"
elif has build.gradle.kts || has build.gradle; then
    lang="java"; pm="gradle"
    test_cmd="./gradlew test"
elif has pom.xml; then
    lang="java"; pm="maven"
    test_cmd="mvn test"

# --- .NET ---
elif has_glob "*.csproj" || has_glob "*.sln"; then
    lang="csharp"; pm="dotnet"
    test_cmd="dotnet test"
    format_cmd="dotnet format --verify-no-changes"

# --- Ruby ---
elif has Gemfile; then
    lang="ruby"; pm="bundler"
    test_cmd="bundle exec rspec"

# --- Elixir ---
elif has mix.exs; then
    lang="elixir"; pm="mix"
    test_cmd="mix test"
    lint_cmd="mix credo"
fi

# --- Monorepo detection (informational) ---
monorepo=""
if has pnpm-workspace.yaml; then monorepo="pnpm-workspace"
elif has turbo.json; then monorepo="turborepo"
elif has nx.json; then monorepo="nx"
elif has go.work; then monorepo="go-workspace"
elif has Cargo.toml && has_content Cargo.toml "\[workspace\]"; then monorepo="cargo-workspace"
fi

# --- Output TOML snippet ---
echo "# Auto-detected hints for $ROOT"
echo "# (User confirmation required — override freely in final .harness.toml)"
echo ""
echo "[project]"
echo "language = \"${lang:-unknown}\""
echo "package_manager = \"${pm:-unknown}\""
echo ""
echo "[testing]"
[ -n "$test_cmd" ] && echo "test_cmd = \"$test_cmd\""
[ -n "$lint_cmd" ] && echo "lint_cmd = \"$lint_cmd\""
[ -n "$format_cmd" ] && echo "format_cmd = \"$format_cmd\""
[ -n "$monorepo" ] && echo ""
[ -n "$monorepo" ] && echo "# monorepo detected: $monorepo"

exit 0

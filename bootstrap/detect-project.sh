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

# --- License detection (v1.10e3 — T1 SPDX → T2-Multi → T2 boilerplate → T3 메타 → T4 fallback) ---
# T1 (v1.10e): SPDX-License-Identifier 헤더 (head -10)
# T2-Multi (v1.10e2): multi-file dual-license (LICENSE-MIT + LICENSE-APACHE 등 → SPDX expression)
# T2 (v1.10e2): boilerplate 매칭 12 패턴 (head -30) + GPL or-later/only suffix
# T2.5 (v1.10e3): Cargo license-file 사용자 정의 경로 → license_path 보강 (T1/T2 재시도용)
# T3 (v1.10e3): 메타데이터 4 source — pyproject (PEP 639/621/poetry) → npm package.json → Cargo.toml
#               + UNLICENSED → LicenseRef-UNLICENSED 정규화 + SEE LICENSE IN <file> 1회 재귀
# T4: output 없음 (silent fallback)
# Priority: LICENSE 콘텐츠 우선 (T1/T2 매칭 시 T3 skip). audit/A5 §1 결정.
license=""

# helper — case-insensitive LICENSE 4 우선순위
_license_file_first() {
    local root="$1"
    local f actual
    for f in LICENSE LICENSE.md LICENSE.txt COPYING; do
        actual=$(find "$root" -maxdepth 1 -iname "$f" -type f 2>/dev/null | head -1)
        if [ -n "$actual" ]; then
            echo "$actual"
            return 0
        fi
    done
    return 1
}

# helper — multi-file dual-license (Rust 컨벤션 LICENSE-MIT + LICENSE-APACHE 등)
_multi_dual_license() {
    local root="$1"
    local f actual base spdx_id
    local -a found_ids=()
    for f in LICENSE-MIT LICENSE-APACHE LICENSE-BSD LICENSE-ISC LICENSE-MPL; do
        # case-insensitive + suffix 변형 허용 (LICENSE-APACHE-2 등)
        actual=$(find "$root" -maxdepth 1 -iname "${f}*" -type f 2>/dev/null \
            | grep -v -i -E '\.(bak|draft|tmp|orig|swp)$' \
            | head -1)
        [ -z "$actual" ] && continue
        base=$(basename "$actual" | tr 'a-z' 'A-Z')
        case "$base" in
            LICENSE-MIT*)    spdx_id="MIT" ;;
            LICENSE-APACHE*) spdx_id="Apache-2.0" ;;
            LICENSE-BSD*)    spdx_id="BSD-3-Clause" ;;
            LICENSE-ISC*)    spdx_id="ISC" ;;
            LICENSE-MPL*)    spdx_id="MPL-2.0" ;;
            *)               continue ;;
        esac
        found_ids+=("$spdx_id")
    done
    if [ "${#found_ids[@]}" -ge 2 ]; then
        # sort + uniq + join with " OR "
        printf "%s\n" "${found_ids[@]}" | sort -u | paste -sd '|' - | sed 's/|/ OR /g'
        return 0
    fi
    return 1
}

# helper — GPL family or-later/only suffix from full body
_gpl_suffix() {
    local body="$1"
    if echo "$body" | grep -q -E "any later version"; then
        echo "or-later"
    else
        echo "only"
    fi
}

# helper — boilerplate 매칭 (head -30 + body for or-later)
_boilerplate_match() {
    local path="$1"
    local head_buf body
    head_buf=$(head -30 "$path" 2>/dev/null)
    body=$(cat "$path" 2>/dev/null)
    [ -z "$head_buf" ] && return 1

    # AGPL-3 (longest GPL family — first)
    if echo "$head_buf" | grep -q "GNU AFFERO GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 3"; then
        echo "AGPL-3.0-$(_gpl_suffix "$body")"; return 0
    fi
    # LGPL-3
    if echo "$head_buf" | grep -q "GNU LESSER GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 3"; then
        echo "LGPL-3.0-$(_gpl_suffix "$body")"; return 0
    fi
    # LGPL-2.1
    if echo "$head_buf" | grep -q "GNU LESSER GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 2\.1"; then
        echo "LGPL-2.1-$(_gpl_suffix "$body")"; return 0
    fi
    # GPL-3
    if echo "$head_buf" | grep -q "GNU GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 3"; then
        echo "GPL-3.0-$(_gpl_suffix "$body")"; return 0
    fi
    # GPL-2
    if echo "$head_buf" | grep -q "GNU GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 2(,| |$)"; then
        echo "GPL-2.0-$(_gpl_suffix "$body")"; return 0
    fi
    # Apache-2.0
    if echo "$head_buf" | grep -q -E "^[[:space:]]*Apache License" \
       && echo "$head_buf" | grep -q -E "Version 2\.0"; then
        echo "Apache-2.0"; return 0
    fi
    # MPL-2.0
    if echo "$head_buf" | grep -q "Mozilla Public License" \
       && echo "$head_buf" | grep -q -E "Version 2\.0"; then
        echo "MPL-2.0"; return 0
    fi
    # Unlicense
    if echo "$head_buf" | grep -q "This is free and unencumbered software released into the public domain"; then
        echo "Unlicense"; return 0
    fi
    # BSD-3-Clause (before BSD-2 — longer match)
    if echo "$head_buf" | grep -q "Redistribution and use" \
       && echo "$head_buf" | grep -q -E "3\. Neither (the name|the names)"; then
        echo "BSD-3-Clause"; return 0
    fi
    # BSD-2-Clause
    if echo "$head_buf" | grep -q "Redistribution and use"; then
        echo "BSD-2-Clause"; return 0
    fi
    # ISC (before MIT — different perm phrase)
    if echo "$head_buf" | grep -q "Permission to use, copy, modify, and/or distribute"; then
        echo "ISC"; return 0
    fi
    # MIT — header signal
    if echo "$head_buf" | grep -q -E '^[[:space:]]*(The )?MIT License' \
       && echo "$head_buf" | grep -q "Permission is hereby granted, free of charge"; then
        echo "MIT"; return 0
    fi
    # MIT — header 부재 fallback (Notion edge case)
    if echo "$head_buf" | grep -q "Permission is hereby granted, free of charge" \
       && echo "$head_buf" | grep -q -E "^Copyright \(c\)"; then
        echo "MIT"; return 0
    fi
    return 1
}

# helper — T1 SPDX 헤더 매칭 (재사용 위해 함수화)
_t1_match() {
    local path="$1"
    [ -f "$path" ] || return 1
    head -10 "$path" 2>/dev/null \
        | grep -E "^SPDX-License-Identifier:" \
        | head -1 \
        | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
        | sed -E 's/[[:space:]]+$//'
}

# helper — path traversal/DoS 방어 (audit/A3 §3.8)
_sanitize_path() {
    local path="$1"
    # 1KB 길이 상한 (DoS)
    [ "${#path}" -gt 1024 ] && return 1
    # 절대 경로 거부 (Unix /, Windows C:)
    case "$path" in /*|*:*) return 1 ;; esac
    # .. 포함 거부
    case "$path" in *..*) return 1 ;; esac
    # newline / CR 거부
    case "$path" in *$'\n'*|*$'\r'*) return 1 ;; esac
    # null 거부 (bash 자체가 null 라인 처리 못 함, 추가 방어)
    [ -z "$path" ] && return 1
    printf '%s\n' "$path"
}

# helper — pyproject [project].license PEP 639 modern (string)
_metadata_pyproject_pep639() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    awk '/^\[project\][[:space:]]*$/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}

# helper — pyproject [project].license PEP 621 inline {text = "..."}
_metadata_pyproject_pep621_text() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    awk '/^\[project\][[:space:]]*$/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*\{[[:space:]]*text/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/.*text[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}

# helper — pyproject [project].license PEP 621 inline {file = "..."} → T1/T2 재귀
_metadata_pyproject_pep621_file() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    local file
    file=$(awk '/^\[project\][[:space:]]*$/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*\{[[:space:]]*file/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/.*file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
    [ -z "$file" ] && return 1
    file=$(_sanitize_path "$file") || return 1
    [ -f "$root/$file" ] || return 1
    local result
    result=$(_t1_match "$root/$file" 2>/dev/null)
    [ -z "$result" ] && result=$(_boilerplate_match "$root/$file" 2>/dev/null || echo "")
    [ -n "$result" ] && printf '%s\n' "$result"
}

# helper — pyproject [tool.poetry].license (deprecated string)
_metadata_pyproject_poetry() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    awk '/^\[tool\.poetry\][[:space:]]*$/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}

# helper — package.json top-level "license" (string + legacy {type, url})
# Anchor 완화: multi-line indented + single-line minified 모두 처리.
# Root-only 가정 — nested dependencies 내부 license는 head -1로 회피 (root가 먼저 등장).
_metadata_npm() {
    local root="$1"
    [ -f "$root/package.json" ] || return 1
    local result
    # (a) string 형식 — "license": "..."
    result=$(grep -o -E '"license"[[:space:]]*:[[:space:]]*"[^"]+"' "$root/package.json" 2>/dev/null \
        | head -1 \
        | sed -E 's/^"license"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')
    # (b) legacy object — multi-line type 필드 (G5 부분 지원)
    if [ -z "$result" ] && grep -q -E '"license"[[:space:]]*:[[:space:]]*\{' "$root/package.json" 2>/dev/null; then
        result=$(awk '
            /"license"[[:space:]]*:[[:space:]]*\{/{f=1; line=0; next}
            f && line < 5 {
                line++
                if (/"type"[[:space:]]*:/) { print; exit }
                if (/}/) { exit }
            }' "$root/package.json" 2>/dev/null \
            | sed -E 's/.*"type"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')
    fi
    [ -n "$result" ] && printf '%s\n' "$result"
}

# helper — Cargo.toml [package].license (string)
_metadata_cargo() {
    local root="$1"
    [ -f "$root/Cargo.toml" ] || return 1
    awk '/^\[package\][[:space:]]*$/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$root/Cargo.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}

# helper — Cargo.toml [package].license-file (T2.5 보강 — license_path 보강용)
_metadata_cargo_license_file() {
    local root="$1"
    [ -f "$root/Cargo.toml" ] || return 1
    local file
    file=$(awk '/^\[package\][[:space:]]*$/{f=1;next} /^\[/{f=0} f && /^license-file[[:space:]]*=[[:space:]]*"/' "$root/Cargo.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license-file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
    [ -z "$file" ] && return 1
    file=$(_sanitize_path "$file") || return 1
    [ -f "$root/$file" ] || return 1
    printf '%s\n' "$root/$file"
}

# T1 — SPDX-License-Identifier 헤더 (v1.10e 우선)
license_path=$(_license_file_first "$ROOT" || echo "")

# T2.5 — Cargo license-file 보강 (license_path 부재 시 사용자 정의 경로 시도, v1.10e3)
if [ -z "$license_path" ]; then
    cargo_license_file=$(_metadata_cargo_license_file "$ROOT" 2>/dev/null || echo "")
    [ -n "$cargo_license_file" ] && license_path="$cargo_license_file"
fi

if [ -n "$license_path" ]; then
    license=$(_t1_match "$license_path" 2>/dev/null || echo "")
fi

# T2-Multi — multi-file dual-license (LICENSE-MIT + LICENSE-APACHE 등)
if [ -z "$license" ]; then
    license=$(_multi_dual_license "$ROOT" || echo "")
fi

# T2 — boilerplate 매칭 (single LICENSE 파일)
if [ -z "$license" ] && [ -n "$license_path" ]; then
    license=$(_boilerplate_match "$license_path" || echo "")
fi

# T3 — 메타데이터 (LICENSE 콘텐츠 미매칭 시만; audit/A5 §1 LICENSE 우선 정책, v1.10e3)
if [ -z "$license" ]; then
    license=$(_metadata_pyproject_pep639 "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_pyproject_pep621_text "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_pyproject_pep621_file "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_pyproject_poetry "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_npm "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_cargo "$ROOT" 2>/dev/null || echo "")

    # SEE LICENSE IN <file> 1회 재귀 (npm 컨벤션, audit/A4 R5)
    if echo "$license" | grep -q -E '^SEE LICENSE IN '; then
        rel_file=$(echo "$license" | sed -E 's/^SEE LICENSE IN //' | sed -E 's/[[:space:]]+$//')
        rel_file=$(_sanitize_path "$rel_file" 2>/dev/null || echo "")
        if [ -n "$rel_file" ] && [ -f "$ROOT/$rel_file" ]; then
            license=$(_t1_match "$ROOT/$rel_file" 2>/dev/null || echo "")
            [ -z "$license" ] && license=$(_boilerplate_match "$ROOT/$rel_file" 2>/dev/null || echo "")
        else
            license=""   # path traversal / file 부재 → silent
        fi
    fi

    # UNLICENSED → LicenseRef-UNLICENSED 정규화 (audit/A4 R4)
    [ "$license" = "UNLICENSED" ] && license="LicenseRef-UNLICENSED"
fi

# v1.10h R1 — license_file: actual LICENSE file relative path (T1/T2/T2-Multi/T2.5 매칭 시 set).
# T3 only (메타 매칭 + LICENSE 파일 부재) 시 empty → Claude(Bootstrap) L5 link 생략 분기.
# Cargo subdirectory license-file (e.g., "LICENSES/CUSTOM") edge case 자연 처리 (basename 아닌 relative path).
license_file=""
if [ -n "$license_path" ]; then
    license_file="${license_path#$ROOT/}"
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
# v1.10e/e2/e3: license는 manifest 외 콘텐츠 변수 (AGENTS.md.tmpl {{license}} 치환용).
# T1 (SPDX 헤더) → T2-Multi (dual) → T2 (boilerplate 12) → T2.5 (Cargo license-file)
#   → T3 (메타 4 source: pyproject 3 / npm / Cargo) → T4 (silent).
# LICENSE 콘텐츠 우선 (T1/T2 매칭 시 T3 skip — audit/A5).
# Claude(Bootstrap)이 stdout grep으로 추출 (license = "..." 라인).
[ -n "$license" ] && echo ""
[ -n "$license" ] && echo "license = \"$license\""
# v1.10h R1: license_file relative path (T1/T2/T2.5 매칭 시) — Claude(Bootstrap) L5 link 분기용
[ -n "$license_file" ] && echo "license_file = \"$license_file\""
[ -n "$monorepo" ] && echo ""
[ -n "$monorepo" ] && echo "# monorepo detected: $monorepo"

exit 0

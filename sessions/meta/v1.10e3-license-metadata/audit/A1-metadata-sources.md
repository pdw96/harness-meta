# A1 — 4 메타데이터 source 정밀 spec

본 audit는 v1.10e3 T3 메타데이터 4-tier 도입의 1차 spec 정합성 검증. 각 source의 공식 문서 quote + 변형 사례 + bash 파싱 가능 범위를 확정한다.

## §1. 4 source 매트릭스

| # | 파일 | 키 위치 | 형식 (current) | 형식 (legacy/variants) | 공식 spec |
|---|------|---------|--------------|-----------------------|----------|
| **M1** | `package.json` | top-level `"license"` | string SPDX expression | object `{type, url}` (deprecated) / array `"licenses"` (deprecated) | npm CLI v10 docs |
| **M2** | `pyproject.toml` | `[project].license` (PEP 639) | string SPDX expression | inline table `{text="..."}` / `{file="..."}` (PEP 621 deprecated) | PEP 639 Final (2024-05) |
| **M3** | `pyproject.toml` | `[tool.poetry].license` | string SPDX | (deprecated alias of M2) | Poetry docs |
| **M4** | `Cargo.toml` | `[package].license` | string SPDX 2.3 expression | `license-file = "LICENSE.txt"` (간접, indirect) | Cargo manifest spec |

## §2. M1 — package.json `license` 필드 (npm)

### §2.1. 공식 spec quote (npm CLI v10)

> "Single license: `\"license\": \"BSD-3-Clause\"`"
> "Multiple licenses: `\"license\": \"(ISC OR GPL-3.0)\"`"
> "Custom License: `\"license\": \"SEE LICENSE IN <filename>\"` where `<filename>` is a file at the package root."
> "No License: `\"license\": \"UNLICENSED\"`"

### §2.2. Deprecated 형식 (npm v6 이전)

> "Those styles are now deprecated. Instead, use SPDX expressions"

```json
"license": {
  "type": "ISC",
  "url": "https://opensource.org/licenses/ISC"
}
```

`"licenses"` (array, plural — deprecated):
```json
"licenses": [
  {"type": "MIT", "url": "..."},
  {"type": "Apache-2.0", "url": "..."}
]
```

### §2.3. v1.10e3 처리 정책

| 형식 | 처리 | 출력 예 |
|------|------|--------|
| 단순 SPDX string `"MIT"` | T3 매칭 | `MIT` |
| SPDX expression `"(ISC OR GPL-3.0)"` | T3 매칭 (괄호 + 표현식 그대로 보존) | `(ISC OR GPL-3.0)` |
| `"UNLICENSED"` (npm 컨벤션) | T3 매칭 → SPDX 표준화 | `LicenseRef-UNLICENSED` (G3 결정) |
| `"SEE LICENSE IN <file>"` | file 경로 추출 → 1회 재귀 (T1/T2 위임) | file이 매칭한 결과 또는 silent (G4) |
| `{type: "MIT", url: "..."}` (legacy object) | **부분 지원** (`type` 필드만 추출) (G5) | `MIT` |
| `"licenses"` (legacy array) | **검출 안 함** (사용자 마이그레이션 안내) | (silent) |

### §2.4. bash 파싱 알고리즘 (top-level "license" string)

```bash
# 단순 string 추출 — 첫 번째 매칭 (top-level "license": "...")
license=$(grep -E '^[[:space:]]*"license"[[:space:]]*:[[:space:]]*"' "$ROOT/package.json" 2>/dev/null \
    | head -1 \
    | sed -E 's/^[[:space:]]*"license"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')

# legacy object 형식 fallback
if [ -z "$license" ] && grep -q -E '^[[:space:]]*"license"[[:space:]]*:[[:space:]]*\{' "$ROOT/package.json" 2>/dev/null; then
    # multi-line "license": { "type": "MIT", ... } — type 필드 추출
    license=$(awk '/^[[:space:]]*"license"[[:space:]]*:[[:space:]]*\{/{f=1} f && /"type"[[:space:]]*:/{
        match($0, /"type"[[:space:]]*:[[:space:]]*"([^"]+)"/, m); print m[1]; exit
    }' "$ROOT/package.json" 2>/dev/null)
fi
```

### §2.5. 한계

- **Nested JSON**: `"license"`가 root가 아닌 다른 object 내부에 있으면 grep top-level 가정 위배 (e.g. workspace `packages.*.license`). v1.10e3 scope에서 root만 처리
- **JSON 주석**: 표준 JSON은 주석 미허용. JSON5/JSONC 사용 시 grep + sed가 주석 라인까지 캡처할 risk → 무시 (npm은 표준 JSON만 지원)
- **awk match() with capture groups**: GNU awk extension (`gawk`). BSD awk (macOS 기본) 미지원 → fallback 별도 필요. Decision in A3

## §3. M2 — pyproject.toml `[project].license` (PEP 621 + PEP 639)

### §3.1. 공식 spec quote (PEP 639 Final, 2024-05)

> "`license` key in the `[project]` table is defined to contain a top-level string value. It is a valid SPDX license expression"

Valid examples (verbatim):
- `license = "MIT"`
- `license = "MIT AND (Apache-2.0 OR BSD-2-clause)"`
- `license = "LicenseRef-Proprietary"`

> "Build tools SHOULD validate and perform case normalization of the expression."

### §3.2. PEP 621 backward compatibility (PEP 639이 대체)

PEP 621 inline table 형식 (deprecated):
```toml
[project]
license = {text = "MIT"}     # text 형식
license = {file = "LICENSE"} # file 형식
```

PEP 639 §Backward Compat:
> "If the new `license-files` key is present, build tools MUST raise an error if the `license` key is defined and has a value other than a single top-level string."
> "When `license-files` is absent, tools SHOULD issue a warning informing users it is deprecated and recommending a license expression as a top-level string key instead."

### §3.3. v1.10e3 처리 정책

| 형식 | 처리 | 출력 예 |
|------|------|--------|
| PEP 639 string `license = "MIT"` | T3 매칭 (modern, 우선) | `MIT` |
| PEP 639 SPDX expression `license = "MIT AND (Apache-2.0 OR BSD-2-clause)"` | T3 매칭 (그대로 보존) | `MIT AND (Apache-2.0 OR BSD-2-clause)` |
| `LicenseRef-*` 형식 | T3 매칭 (그대로) | `LicenseRef-Proprietary` |
| PEP 621 inline `license = {text = "MIT"}` | **deprecated 매칭** (legacy 호환, M2-legacy) | `MIT` |
| PEP 621 inline `license = {file = "LICENSE"}` | file 경로 추출 → T1/T2 위임 (1회 재귀) | LICENSE 매칭 결과 |

### §3.4. bash 파싱 알고리즘 — 3 변형 순차

```bash
# (a) PEP 639 modern string — [project] section 내 license = "..."
license=$(awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$ROOT/pyproject.toml" 2>/dev/null \
    | head -1 \
    | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')

# (b) PEP 621 inline table {text = "..."}
[ -z "$license" ] && license=$(awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*\{[[:space:]]*text/' "$ROOT/pyproject.toml" 2>/dev/null \
    | head -1 \
    | sed -E 's/.*text[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')

# (c) PEP 621 inline {file = "..."} — file 경로 추출 → T1/T2 재귀
if [ -z "$license" ]; then
    file=$(awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*\{[[:space:]]*file/' "$ROOT/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/.*file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
    if [ -n "$file" ] && [ -f "$ROOT/$file" ]; then
        # 1회 재귀 (T1 SPDX 헤더 → T2 boilerplate)
        license=$(_t1_match "$ROOT/$file" || _boilerplate_match "$ROOT/$file" || echo "")
    fi
fi
```

**awk section parse 패턴**: `/^\[project\]/{f=1;next} /^\[/{f=0} f && ...` — `[project]` 진입 시 flag on, 다른 `[section]` 진입 시 flag off. POSIX awk 표준 — macOS/BSD/GNU 모두 작동.

### §3.5. 한계

- **multi-line inline table**: `license = { text = "MIT" }` 한 줄 아닌 경우 (TOML 허용):
  ```toml
  license = {
      text = "MIT"
  }
  ```
  → grep + sed 미커버. tomllib 필요. v1.10e3 scope **단일 라인만 처리**. 사용자 안내 (PEP 639 modern 사용 권장)
- **dynamic license** (`dynamic = ["license"]`): 빌드 시 동적 결정. 정적 grep 불가. 미커버

## §4. M3 — pyproject.toml `[tool.poetry].license` (Poetry)

### §4.1. 공식 spec quote (Poetry docs)

> "An SPDX expression representing the license of the package."

Deprecated 알림:
> "Deprecated: Use `project.license` instead."
> "Specifying license as a table, e.g. `{ text = \"MIT\" }` is deprecated. If you used to specify a license file, e.g. `{ file = \"LICENSE\" }`, use `license-files` instead."

### §4.2. v1.10e3 처리 정책

Poetry는 PEP 621 [project].license를 우선 권장하므로 **M3는 M2 매칭 실패 시만 fallback**.

| 형식 | 처리 |
|------|------|
| `[tool.poetry] license = "MIT"` | T3 매칭 (M2 fallback) |
| `[tool.poetry] license = {text = "MIT"}` (deprecated table) | **검출 안 함** (Poetry 자체 deprecated → PEP 639 권장) |

### §4.3. bash 파싱 알고리즘

```bash
[ -z "$license" ] && license=$(awk '/^\[tool\.poetry\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$ROOT/pyproject.toml" 2>/dev/null \
    | head -1 \
    | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
```

awk section: `[tool.poetry]` 안에서 string 형식만.

### §4.4. M2 vs M3 우선순위

**M2 우선** (PEP 639 modern → PEP 621 legacy → poetry). 근거:
1. PEP 639 Final 2024-05 — Python packaging 공식 표준
2. Poetry 자체 deprecated `[tool.poetry].license` (모이는 곳: `[project].license`)
3. 동일 pyproject.toml 내 둘 다 명시 시 PEP 621이 권위

## §5. M4 — Cargo.toml `[package].license` (Cargo)

### §5.1. 공식 spec quote (Cargo manifest)

> "[crates.io](https://crates.io/) interprets the `license` field as an [SPDX 2.3 license expression](https://spdx.github.io/spdx-spec/v2.3/SPDX-license-expressions/). The name must be a known license from the [SPDX license list 3.20](https://github.com/spdx/license-list-data/tree/v3.20)."

> "SPDX license expressions support AND and OR operators to combine multiple licenses. Using `OR` indicates the user may choose either license. Using `AND` indicates the user must comply with both licenses simultaneously. The `WITH` operator indicates a license with a special exception."

Examples (verbatim):
- `license = "MIT OR Apache-2.0"`
- `license = "LGPL-2.1-only AND MIT AND BSD-2-Clause"`
- `license = "GPL-2.0-or-later WITH Bison-exception-2.2"`

`license-file` (대안):
> "If a package is using a nonstandard license, then the `license-file` field may be specified in lieu of the `license` field."

```toml
[package]
license-file = "LICENSE.txt"
```

> "**Note**: crates.io requires either `license` or `license-file` to be set."

### §5.2. v1.10e3 처리 정책

| 형식 | 처리 | 출력 예 |
|------|------|--------|
| `[package] license = "MIT"` | T3 매칭 | `MIT` |
| dual `license = "MIT OR Apache-2.0"` | T3 매칭 (보존) | `MIT OR Apache-2.0` |
| triple `license = "LGPL-2.1-only AND MIT AND BSD-2-Clause"` | T3 매칭 (보존) | 그대로 |
| WITH `license = "GPL-2.0-or-later WITH Bison-exception-2.2"` | T3 매칭 (보존) | 그대로 |
| `license-file = "LICENSE.txt"` (간접) | **검출 안 함** (T1/T2가 LICENSE.txt를 이미 read) | (T1/T2가 처리) |

### §5.3. bash 파싱 알고리즘

```bash
[ -z "$license" ] && license=$(awk '/^\[package\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$ROOT/Cargo.toml" 2>/dev/null \
    | head -1 \
    | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
```

### §5.4. license-file 처리

Cargo `license-file`은 LICENSE 4 우선순위 (LICENSE/LICENSE.md/LICENSE.txt/COPYING) 외 사용자 정의 파일을 가리킬 수 있음 (e.g. `LICENSE.custom`, `LEGAL.txt`). v1.10e/e2 `_license_file_first()`는 표준 4 파일만 검색 → license-file 지정 시 **detect-project.sh가 LICENSE 파일 못 찾아서 T1/T2 미진입** 가능.

**해결**: T3 진입 전 `license-file = "..."` grep해서 해당 파일을 `license_path`로 사용. T1/T2 재시도.

```bash
if [ -z "$license_path" ] && [ -f "$ROOT/Cargo.toml" ]; then
    custom_file=$(awk '/^\[package\]/{f=1;next} /^\[/{f=0} f && /^license-file[[:space:]]*=[[:space:]]*"/' "$ROOT/Cargo.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license-file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
    if [ -n "$custom_file" ] && [ -f "$ROOT/$custom_file" ]; then
        license_path="$ROOT/$custom_file"
        # T1/T2 재시도 (메인 flow에서)
    fi
fi
```

이는 **T3 진입 전 T1/T2 재시도 단계** — scope에 명시된 `license-file` indirect는 T1/T2 보강이지 T3 신규 분기 아님. PLAN.md "❌ 제외" 항목 (T2가 이미 처리)과 정합 — Cargo 외 standard 4 파일은 v1.10e2가 처리. Cargo `license-file` 사용자 지정 경로만 추가 보강.

**Decision**: `license-file` 처리는 **T3 진입 전 license_path 재계산 단계로 흡수**. T3 본체는 메타데이터 string 추출만.

## §6. 매트릭스 — 변형 처리 요약

| Source | Modern format | Legacy format | 변형/edge | v1.10e3 처리 |
|--------|--------------|--------------|----------|--------------|
| package.json | `"MIT"` string | `{type, url}` object / `licenses` array | `"UNLICENSED"` / `"SEE LICENSE IN <file>"` | string + object `type` 필드. `licenses` array 무시. UNLICENSED → `LicenseRef-UNLICENSED`. SEE LICENSE IN → 1회 재귀 |
| pyproject (PEP 639) | `license = "MIT"` | — | SPDX expression | string 그대로 보존 |
| pyproject (PEP 621) | — | `license = {text="..."}` | `{file="..."}` | text 매칭. file → 1회 재귀 |
| pyproject (poetry) | `[tool.poetry] license = "..."` (deprecated) | — | (table 형식 미커버) | string only. M2 fallback |
| Cargo.toml | `[package] license = "..."` | `license-file = "..."` | `OR`/`AND`/`WITH` expression | string 그대로 보존. license-file은 T3 진입 전 license_path 보강 |

## §7. SPDX expression 그대로 보존 결정

v1.10e3 T3 메타데이터는 **SPDX expression을 검증하지 않고 그대로 보존**. 근거:

1. **권위 도구 동일 전략**: GitHub Linguist / licensee / npm registry / crates.io 모두 메타데이터 license 필드를 string 그대로 read. 검증은 publish 시점 (npm publish / cargo publish)
2. **bash 검증 비현실**: SPDX 3.20 license list 600+ ID + AND/OR/WITH 문법 파서를 bash로 구현 불가능
3. **v1.10e2 multi-file dual과 정합**: 이미 SPDX expression `OR` 조립 (e.g. `Apache-2.0 OR MIT`) 보존. T3도 동일 정책

검증 책임은 **사용자**. AGENTS.md L5에 그대로 stamp → 사용자가 잘못된 expression이면 후속 수정.

## §8. 보안/안전성

### §8.1. Path traversal (SEE LICENSE IN / pyproject file)

`"SEE LICENSE IN ../../etc/passwd"` 같은 입력 가능. 처리:
- file 경로 추출 후 **basename만 사용** 또는 ROOT 안쪽 정규화 (`realpath` 또는 `[[ "$file" != *..* ]]`)
- **Decision**: file 경로에 `..` 포함 시 거부 + WARN. Decision in A3

### §8.2. 너무 긴 license string

`"license": "<10MB string>"` 같은 입력 — DoS risk 미미 (head 1 + sed 단일 라인). 다만 sed가 GB 라인은 안 끝남.
- **Decision**: head -c 1024로 truncate (1KB 상한). SPDX expression 1KB 초과는 비현실.

### §8.3. Shell metachar in license value

`"license": "MIT $(rm -rf /)"` 같은 명령 주입은 **render-manifest.sh가 5종 (`"`, `'`, `\n`, `$`, `\`) 거부** (interview.md "TOML 안전성"). T3가 추출한 `$license`도 동일 검증 통과 후 AGENTS.md.tmpl 치환에 사용. 즉 detect-project.sh는 read-only 추출만, 검증은 render 단계.

## §9. 한계 명시 (사용자 안내)

| 한계 | 대안 |
|------|------|
| multi-line TOML inline table (PEP 621 `license = {\n  text = "MIT"\n}`) | PEP 639 modern string 사용 권장 |
| `dynamic = ["license"]` | 빌드 후 메타데이터 read (v1.10e3 미지원). 사용자가 LICENSE 파일 명시 |
| npm `licenses` array (legacy v6 이전) | v8+ 마이그레이션 (`"license": "..."` 단일) |
| modified license / 신규-희귀 license (Boost / zlib / NCSA) | 사용자 SPDX 헤더 추가 (T1 우선) |
| monorepo 자식 packages (pnpm-workspace) | workspace root만. recursive 별도 후속 |
| JSON5/JSONC 주석 | 표준 JSON 사용 권장 |

## §10. 1차 spec 정합성 결론

4 source 모두 **SPDX expression 표준 채택**. v1.10e3는 string 그대로 보존하면 spec 정합성 자동 유지. legacy 형식 (object / table)은 부분 지원 + 사용자 마이그레이션 안내.

**검증된 spec 출처**:
- npm: https://docs.npmjs.com/cli/v10/configuring-npm/package-json
- PEP 639: https://peps.python.org/pep-0639/ (Final, 2024-05)
- Poetry: https://python-poetry.org/docs/pyproject/
- Cargo: https://doc.rust-lang.org/cargo/reference/manifest.html

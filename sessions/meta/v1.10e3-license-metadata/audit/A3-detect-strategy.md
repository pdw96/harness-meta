# A3 — 4-tier bash 알고리즘 + grep/awk 전략

본 audit는 v1.10e3 T3 메타데이터 4-tier 통합 알고리즘 + helper 함수 시그니처 + grep+sed/awk 트레이드오프 + 보안 검증 (path traversal / 재귀 깊이) 확정.

## §1. 통합 4-tier flow

기존 v1.10e2 3-tier에 **T3 메타데이터** 추가. **T2.5 license-file 보강**도 명시 (Cargo `license-file` 사용자 정의 경로 처리 — A1 §5.4).

```
[기존 v1.10e2]
license=""
license_path = _license_file_first(ROOT)              # LICENSE / LICENSE.md / LICENSE.txt / COPYING

# T1 — SPDX 헤더 (license_path 있을 때)
[ -n "$license_path" ] && license = (head -10 → SPDX-License-Identifier:)

# T2-Multi — 다중 파일 dual
[ -z "$license" ] && license = _multi_dual_license(ROOT)

# T2 — boilerplate (license_path 있을 때)
[ -z "$license" ] && [ -n "$license_path" ] && license = _boilerplate_match(license_path)

[v1.10e3 추가]
# T2.5 — Cargo license-file (license_path 부재 시 보강)
[ -z "$license_path" ] && [ -f "$ROOT/Cargo.toml" ] && {
    custom_file = grep [package].license-file
    [ -n "$custom_file" ] && [ -f "$ROOT/$custom_file" ] && {
        license_path = "$ROOT/$custom_file"
        # T1/T2 재시도 — license 비어있으면
        [ -z "$license" ] && license = _t1_match(license_path) || _boilerplate_match(license_path)
    }
}

# T3 — 메타데이터 (license 비어있고 LICENSE 콘텐츠 매칭 안 된 경우만)
[ -z "$license" ] && {
    # M2 (PEP 639 modern) → M2-legacy (PEP 621 inline) → M3 (poetry) → M1 (npm) → M4 (Cargo)
    license = _metadata_pyproject_pep639(ROOT) ||
              _metadata_pyproject_pep621_text(ROOT) ||
              _metadata_pyproject_pep621_file(ROOT) ||
              _metadata_pyproject_poetry(ROOT) ||
              _metadata_npm(ROOT) ||
              _metadata_cargo(ROOT)

    # SEE LICENSE IN <file> 1회 재귀 (npm 컨벤션)
    if echo "$license" | grep -q -E '^SEE LICENSE IN '; then
        file = sanitize_path(license)
        if [ -n "$file" ] && [ -f "$ROOT/$file" ]; then
            license = _t1_match("$ROOT/$file") || _boilerplate_match("$ROOT/$file") || ""
        else
            license = ""   # path traversal 또는 file 부재 → silent
        fi
    fi

    # UNLICENSED 정규화 (G3)
    [ "$license" = "UNLICENSED" ] && license="LicenseRef-UNLICENSED"
}

# T4 — silent (license 그대로 비어있음. main flow가 출력 안 함)
```

## §2. T3 source 우선순위 결정 (G2)

**M2 → M2-legacy → M3 → M1 → M4** 순서. 근거:

| # | source | 우선 근거 |
|---|--------|---------|
| 1 | M2 (PEP 639 modern) | Python packaging 공식 표준 (Final 2024-05). 가장 strong signal |
| 2 | M2-legacy (PEP 621 inline `{text}`) | 동일 pyproject 내 PEP 621 deprecated 형식 — modern 부재 시 fallback |
| 3 | M2-file (PEP 621 inline `{file}`) | file 경로 → T1/T2 재귀 (T3 진입 전 license_path 보강과 유사하나 메타 source) |
| 4 | M3 (Poetry) | Poetry 자체 deprecated 알림 — 동일 pyproject에서 PEP 621과 충돌 시 PEP 621 권위 |
| 5 | M1 (npm) | 다른 언어 source. 단일 프로젝트가 동시 보유는 비현실 (monorepo 외) |
| 6 | M4 (Cargo) | 동일 |

**Multi-language 프로젝트** (예: pyproject + package.json 동시): pyproject 우선. 이유: Python이 더 strict spec (PEP 639 Final). package.json은 frontend bundling 보조 사례 多. **첫 매칭 + early return**으로 단순화 — sample evidence 부재 시 디폴트.

**Cross-language conflict edge case**: 만약 pyproject MIT + package.json Apache 동시 존재 → pyproject `MIT` 출력. 사용자 conflict는 detect 단계에서 해결 안 함 (사용자 책임 — 메타가 강한 declaration이라는 가정).

## §3. helper 함수 시그니처 (5개 신규)

기존 v1.10e2 helper (4개) + 신규 (5개) = 총 9개.

### §3.1. `_metadata_pyproject_pep639(root)` (신규)

```bash
# PEP 639 modern: [project] license = "MIT"
_metadata_pyproject_pep639() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}
```

**section parse**: `/^\[project\]/{f=1;next}` flag on, `/^\[/{f=0}` flag off (다른 section 진입). `f && ...` 조건부 출력. POSIX awk — macOS/BSD/GNU 호환.

**실패 처리**: 파일 부재 → return 1 (sed 출력 빈 문자열 → caller `[ -z "$license" ]` 분기).

### §3.2. `_metadata_pyproject_pep621_text(root)` (신규)

```bash
# PEP 621 deprecated inline: [project] license = {text = "MIT"}
_metadata_pyproject_pep621_text() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*\{[[:space:]]*text/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/.*text[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}
```

**한계** (A1 §3.5): multi-line inline table 미커버. 사용자에게 PEP 639 modern 권장.

### §3.3. `_metadata_pyproject_pep621_file(root)` (신규)

```bash
# PEP 621 deprecated inline: [project] license = {file = "LICENSE"}
# 추출한 file을 license_path로 export → main flow에서 T1/T2 재시도
_metadata_pyproject_pep621_file() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    local file
    file=$(awk '/^\[project\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*\{[[:space:]]*file/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/.*file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
    [ -z "$file" ] && return 1
    file=$(_sanitize_path "$root" "$file") || return 1
    [ -f "$root/$file" ] || return 1
    # T1 → T2 boilerplate 재시도 (1회만)
    local result
    result=$(head -10 "$root/$file" 2>/dev/null \
        | grep -E "^SPDX-License-Identifier:" \
        | head -1 \
        | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
        | sed -E 's/[[:space:]]+$//')
    [ -z "$result" ] && result=$(_boilerplate_match "$root/$file" 2>/dev/null || echo "")
    echo "$result"
}
```

**1회 재귀**: T1/T2를 file에 직접 적용. 추가 재귀 (그 file이 또 license-file을 가리키는 등) 없음.

### §3.4. `_metadata_pyproject_poetry(root)` (신규)

```bash
# Poetry deprecated: [tool.poetry] license = "MIT"
_metadata_pyproject_poetry() {
    local root="$1"
    [ -f "$root/pyproject.toml" ] || return 1
    awk '/^\[tool\.poetry\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$root/pyproject.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}
```

`[tool.poetry]` section parse — `\.`로 dot escape.

### §3.5. `_metadata_npm(root)` (신규 — 가장 복잡)

```bash
# package.json: top-level "license": "..." (string) 또는 legacy {type, url} (object)
_metadata_npm() {
    local root="$1"
    [ -f "$root/package.json" ] || return 1
    local result
    # (a) string 형식 — 단일 라인 grep
    result=$(grep -E '^[[:space:]]*"license"[[:space:]]*:[[:space:]]*"' "$root/package.json" 2>/dev/null \
        | head -1 \
        | sed -E 's/^[[:space:]]*"license"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')

    # (b) legacy object — multi-line type 필드 추출 (G5 부분 지원)
    if [ -z "$result" ] && grep -q -E '^[[:space:]]*"license"[[:space:]]*:[[:space:]]*\{' "$root/package.json" 2>/dev/null; then
        # awk: license object 진입 → "type" 매칭 (3 라인 안쪽으로 제한)
        result=$(awk '
            /^[[:space:]]*"license"[[:space:]]*:[[:space:]]*\{/{f=1; line=0; next}
            f && line < 5 {
                line++
                if (match($0, /"type"[[:space:]]*:[[:space:]]*"([^"]+)"/, m)) { print m[1]; exit }
                if (/}/) { exit }
            }
        ' "$root/package.json" 2>/dev/null)
    fi

    echo "$result"
}
```

**`awk match()` capture group GNU extension 우려**: `match($0, /regex/, arr)` 3-arg form은 GNU awk 전용 (BSD/macOS 미지원). **POSIX 대안**:

```bash
# POSIX 대안 — sed로 후처리
result=$(awk '/^[[:space:]]*"license"[[:space:]]*:[[:space:]]*\{/{f=1; line=0; next}
              f && line < 5 { line++; if (/"type"/) { print; exit }; if (/}/) { exit } }' "$root/package.json" 2>/dev/null \
    | sed -E 's/.*"type"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')
```

→ POSIX awk + sed 후처리 채택. macOS/BSD/GNU 모두 호환.

### §3.6. `_metadata_cargo(root)` (신규)

```bash
# Cargo.toml: [package] license = "MIT OR Apache-2.0"
_metadata_cargo() {
    local root="$1"
    [ -f "$root/Cargo.toml" ] || return 1
    awk '/^\[package\]/{f=1;next} /^\[/{f=0} f && /^license[[:space:]]*=[[:space:]]*"/' "$root/Cargo.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/'
}
```

`[package]` section parse. license-file은 별도 함수 (T2.5).

### §3.7. `_metadata_cargo_license_file(root)` (T2.5 보강)

```bash
# Cargo: license-file = "LICENSE.txt" (사용자 정의 경로) → license_path 보강용
_metadata_cargo_license_file() {
    local root="$1"
    [ -f "$root/Cargo.toml" ] || return 1
    local file
    file=$(awk '/^\[package\]/{f=1;next} /^\[/{f=0} f && /^license-file[[:space:]]*=[[:space:]]*"/' "$root/Cargo.toml" 2>/dev/null \
        | head -1 \
        | sed -E 's/^license-file[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/')
    [ -z "$file" ] && return 1
    file=$(_sanitize_path "$root" "$file") || return 1
    [ -f "$root/$file" ] || return 1
    echo "$root/$file"   # 절대 경로 반환 → main flow가 license_path로 사용
}
```

### §3.8. `_sanitize_path(root, path)` (보안 — 신규)

```bash
# Path traversal 방지: ../ 포함 거부, 절대경로 거부, 너무 긴 경로 거부
_sanitize_path() {
    local root="$1" path="$2"
    # 1KB 길이 상한 (DoS)
    [ "${#path}" -gt 1024 ] && return 1
    # 절대 경로 거부
    case "$path" in /*|*:*) return 1 ;; esac
    # .. 포함 거부 (단순 grep — realpath 검증보다 보수적)
    case "$path" in *..*) return 1 ;; esac
    # null byte, newline 거부
    case "$path" in *$'\n'*|*$'\r'*) return 1 ;; esac
    echo "$path"
}
```

**검증 정책**: relative path만, `..` 미포함, 절대경로 거부. realpath 미사용 (Windows MINGW에서 안 정확) — 보수적 grep.

## §4. UNLICENSED 정규화 (G3 결정)

```bash
# G3 — UNLICENSED → LicenseRef-UNLICENSED (SPDX 표준)
[ "$license" = "UNLICENSED" ] && license="LicenseRef-UNLICENSED"
```

**근거** (A1 §2.3 + A4 G3):
- `UNLICENSED`는 npm 자체 컨벤션 (SPDX 비표준)
- SPDX 표준은 `LicenseRef-<id>` (사용자 정의 license 표기)
- AGENTS.md L5 출력 시 SPDX 정합 유지

**대안 (G3 후보)**:
- (a) `UNLICENSED` 그대로 (npm 컨벤션 보존)
- (b) **`LicenseRef-UNLICENSED` (SPDX 표준)** ✓ 채택
- (c) `proprietary` (semantic, 비표준)

(b) 채택 — SPDX 표준 정합 + downstream 도구 (Linguist 등) 호환.

## §5. SEE LICENSE IN 처리 (G4 결정)

```bash
if echo "$license" | grep -q -E '^SEE LICENSE IN '; then
    file=$(echo "$license" | sed -E 's/^SEE LICENSE IN //' | sed -E 's/[[:space:]]+$//')
    file=$(_sanitize_path "$root" "$file") || file=""
    if [ -n "$file" ] && [ -f "$root/$file" ]; then
        license=$(head -10 "$root/$file" 2>/dev/null \
            | grep -E "^SPDX-License-Identifier:" \
            | head -1 \
            | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
            | sed -E 's/[[:space:]]+$//')
        [ -z "$license" ] && license=$(_boilerplate_match "$root/$file" 2>/dev/null || echo "")
    else
        license=""   # path traversal / file 부재 → silent
    fi
fi
```

**1회 재귀 정당화** (G4):
- 무제한 재귀 risk: `A → SEE LICENSE IN B`, `B → SEE LICENSE IN C`, ... 무한 루프 가능 (사용자 실수 또는 악의)
- 1회 충분: npm 컨벤션은 단일 LICENSE 파일 가정. 체인 비현실
- 구현 단순: depth counter 불필요, 코드 가독성 ✓

**대안 (G4 후보)**:
- (a) **1회만** ✓ 채택
- (b) 무제한 (depth ≤ 5)

(a) 채택.

## §6. grep+sed vs awk 트레이드오프

| 패턴 | grep+sed | awk section parse |
|------|---------|-------------------|
| top-level JSON `"key": "value"` | ✅ 단순 | 과도 |
| TOML `[section]` 안의 key | ✗ (다른 section 캡처 risk) | ✅ 정확 |
| Multi-line 형식 (legacy object) | ✗ | ✅ |

**채택**:
- M1 (package.json top-level): grep+sed (단순). legacy object fallback은 awk
- M2/M3/M4 (TOML section-bound): awk + section flag

**POSIX 호환성** (macOS/BSD/GNU):
- POSIX awk는 `match($0, /regex/, arr)` 3-arg form 미지원 (GNU 전용)
- 대안: section flag로 라인 캡처 → sed 후처리 (§3.5에서 채택)
- `/^\[project\]/{f=1;next}` POSIX 표준 — 모든 awk 호환

## §7. tomllib/jq 회피 정당화

**tomllib (Python 3.11+)**:
- 정확 TOML 파서. multi-line inline table / nested 모두 처리
- 단점: Python 3.11 의존. detect-project.sh는 bash-only (POSIX 환경 가정)
- bash hook 환경 (session-init.sh, statusline.sh)에서 Python 호출은 부담

**jq**:
- 정확 JSON 파서. nested object / array 모두 처리
- 단점: 외부 도구 의존. macOS 기본 미설치, Windows MINGW 미보장
- detect-project.sh의 v1.9 철학 (bash-only POSIX) 위배

**v1.10e3 결정**: tomllib/jq 회피, bash + grep + sed + awk 단독. 한계 명시 (multi-line inline table / nested JSON / 주석 미처리). 사용자 안내로 보강.

**미래 v2.0 후보** (manifest-schema.md §12.2): tomllib 기반 parser 도입 검토 시 본 v1.10e3 한계 자동 해결.

## §8. main flow 통합 — 의사코드

```bash
# detect-project.sh main flow (T3 추가 후)

license=""
license_path=$(_license_file_first "$ROOT" || echo "")

# T2.5 Cargo license-file 보강 (license_path 부재 시)
if [ -z "$license_path" ]; then
    cargo_license_file=$(_metadata_cargo_license_file "$ROOT" 2>/dev/null || echo "")
    [ -n "$cargo_license_file" ] && license_path="$cargo_license_file"
fi

# T1 SPDX 헤더
if [ -n "$license_path" ]; then
    license=$(head -10 "$license_path" 2>/dev/null \
        | grep -E "^SPDX-License-Identifier:" \
        | head -1 \
        | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
        | sed -E 's/[[:space:]]+$//')
fi

# T2-Multi
if [ -z "$license" ]; then
    license=$(_multi_dual_license "$ROOT" || echo "")
fi

# T2 boilerplate
if [ -z "$license" ] && [ -n "$license_path" ]; then
    license=$(_boilerplate_match "$license_path" || echo "")
fi

# T3 메타데이터 (LICENSE 매칭 안 됐을 때만)
if [ -z "$license" ]; then
    license=$(_metadata_pyproject_pep639 "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_pyproject_pep621_text "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_pyproject_pep621_file "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_pyproject_poetry "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_npm "$ROOT" 2>/dev/null || echo "")
    [ -z "$license" ] && license=$(_metadata_cargo "$ROOT" 2>/dev/null || echo "")

    # SEE LICENSE IN 1회 재귀
    if echo "$license" | grep -q -E '^SEE LICENSE IN '; then
        file=$(echo "$license" | sed -E 's/^SEE LICENSE IN //' | sed -E 's/[[:space:]]+$//')
        file=$(_sanitize_path "$ROOT" "$file" 2>/dev/null || echo "")
        if [ -n "$file" ] && [ -f "$ROOT/$file" ]; then
            license=$(head -10 "$ROOT/$file" 2>/dev/null \
                | grep -E "^SPDX-License-Identifier:" \
                | head -1 \
                | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
                | sed -E 's/[[:space:]]+$//')
            [ -z "$license" ] && license=$(_boilerplate_match "$ROOT/$file" 2>/dev/null || echo "")
        else
            license=""
        fi
    fi

    # G3 정규화
    [ "$license" = "UNLICENSED" ] && license="LicenseRef-UNLICENSED"
fi

# T4 — silent fallback (license 비어있으면 출력 안 함)
```

**guard chain**: 각 helper 호출이 `[ -z "$license" ] &&`로 가드. 첫 매칭 시 short-circuit early return. v1.10e2와 동일 철학 — 단순 + 검증 용이.

## §9. 보안 점검 매트릭스

| 위협 | 위험도 | 대응 |
|------|------|------|
| Path traversal (SEE LICENSE IN `../../etc/passwd`) | 중 | `_sanitize_path` — `..` 거부 + 절대경로 거부 + 길이 제한 |
| 명령 주입 (license value `"MIT $(rm -rf /)"`) | 낮 | render-manifest.sh 5종 검증 (`"`, `'`, `\n`, `$`, `\`) — detect는 read-only |
| DoS (수십 MB license string) | 낮 | `head -1` + sed 단일 라인 — bash 자체 메모리 제한 |
| Symlink follow (LICENSE → /etc/passwd) | 낮 | `[ -f "$path" ]` 체크는 symlink follow → 추가 검증 안 함 (detect 환경 신뢰 가정) |
| Null byte (path에 `\0`) | 낮 | `_sanitize_path` — newline/CR 거부 |

**non-trust 환경 사용 가정 안 함**: detect-project.sh는 사용자가 own 프로젝트 root에서 실행. 외부 untrusted input source 아님. 보수적 검증은 일반 sanity 수준.

## §10. 실행 시간 추정

helper 함수 추가 영향:

| 함수 | 비용 (ms 추정) |
|------|--------------|
| `_metadata_pyproject_pep639` | ~5ms (awk pyproject.toml 단일 pass) |
| `_metadata_pyproject_pep621_text` | ~5ms |
| `_metadata_pyproject_pep621_file` | ~5ms + T1/T2 재귀 ~10ms = ~15ms |
| `_metadata_pyproject_poetry` | ~5ms |
| `_metadata_npm` | ~5ms (단순) ~ ~10ms (legacy fallback) |
| `_metadata_cargo` | ~5ms |
| `_metadata_cargo_license_file` | ~5ms |
| `_sanitize_path` | <1ms |

**T3 worst case**: 6 helper 순차 호출 + SEE LICENSE IN 재귀 = ~50ms 추가.

기존 v1.10e2 detect-project.sh ~100ms → v1.10e3 ~150ms (worst case). 인터뷰 단계에서 1회 호출이라 사용자 체감 차이 없음 (interview UX는 사용자 응답 대기 위주).

## §11. 통합 결론

- **bash 단독 4-tier 구현 가능** — POSIX awk + grep + sed 조합. tomllib/jq 회피
- **POSIX 호환** — macOS/BSD/GNU/MINGW 모두 작동 (GNU awk extension 회피)
- **보안** — path traversal 차단 (sanitize_path) + 1회 재귀 (depth bomb 차단) + render-manifest.sh 5종 검증 (명령 주입 차단)
- **단순성** — guard chain + early return 패턴 (v1.10e2 동일 철학)
- **성능** — worst case ~50ms 추가, 사용자 체감 무관

**구현 라인 수 추정** (v1.10e2 ~110 라인 추가 → v1.10e3 ~70-90 라인 추가):
- helper 함수 6개 신규 (~70 라인)
- main flow guard chain ~15 라인
- sanitize_path ~10 라인

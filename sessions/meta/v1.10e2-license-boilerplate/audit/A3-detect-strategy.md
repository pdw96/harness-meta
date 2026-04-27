# A3 — Detect 전략 + bash 알고리즘 (T1 + T2 + T3 3-tier)

본 v1.10e2의 `detect-project.sh` License 함수 **bash 구현 명세**. T1 (SPDX 헤더, v1.10e) 보존 + T2 (boilerplate) 추가 + T3 (fallback).

## 1. 3-tier 알고리즘 의사코드

```
detect_license(ROOT):
    LICENSE_FILES = [LICENSE, LICENSE.md, LICENSE.txt, COPYING] (case-insensitive)
    DUAL_FILES    = [LICENSE-MIT, LICENSE-APACHE, LICENSE-BSD, LICENSE-ISC, LICENSE-MPL]
                    (case-insensitive)

    # ==== T1 — SPDX-License-Identifier 헤더 (v1.10e 보존) ====
    for fname in LICENSE_FILES:
        path = case_insensitive_match(ROOT, fname)
        if not exist: continue
        spdx_id = grep_spdx_header(path, head=10)
        if spdx_id: return spdx_id    # T1 wins all

    # ==== T2-Multi — Multi-file dual-license (Rust 컨벤션) ====
    found_files = list of existing case-insensitive matches in DUAL_FILES
    if len(found_files) >= 2:
        ids = [map_filename_suffix_to_spdx(f) for f in found_files]
        return " OR ".join(sorted_unique(ids))    # e.g. "MIT OR Apache-2.0"

    # ==== T2 — boilerplate 매칭 (head -30 buffer) ====
    for fname in LICENSE_FILES:
        path = case_insensitive_match(ROOT, fname)
        if not exist: continue
        head_buf = head -30 of path

        # priority order: longest-marker-first (audit/A1 §6)
        for pattern in [AGPL_3, LGPL_3, LGPL_21, GPL_3, GPL_2, APACHE_2, MPL_2,
                        UNLICENSE, BSD_3, BSD_2, ISC, MIT, MIT_no_header]:
            if pattern.match(head_buf):
                spdx = pattern.id
                if pattern.is_gpl_family:
                    if grep "any later version" in entire body:
                        spdx += "-or-later"
                    else:
                        spdx += "-only"
                # NOTICE 보조 (Apache-2.0 — informational only)
                if spdx == "Apache-2.0" and exist(ROOT/NOTICE):
                    log "NOTICE file present (Apache-2.0 confirmed)"
                return spdx

    # ==== T3 — fallback ====
    return None    # silent, no output
```

## 2. bash 구현 — `detect_license` 함수 신규 (~100 라인 추가)

`bootstrap/detect-project.sh` 끝부분 (현재 v1.10e T1 section)을 확장.

### 2-1. helper 함수

```bash
# Case-insensitive filename match (LICENSE 4 우선순위)
license_file_first() {
    local root="$1"
    for f in LICENSE LICENSE.md LICENSE.txt COPYING; do
        local actual=$(find "$root" -maxdepth 1 -iname "$f" -type f 2>/dev/null | head -1)
        if [ -n "$actual" ]; then
            echo "$actual"
            return 0
        fi
    done
    return 1
}

# Multi-file dual-license detection (LICENSE-MIT, LICENSE-APACHE, ...)
multi_dual_license() {
    local root="$1"
    local -a found=()
    local -a spdx_ids=()
    for f in LICENSE-MIT LICENSE-APACHE LICENSE-APACHE-2 LICENSE-BSD LICENSE-ISC LICENSE-MPL; do
        local actual=$(find "$root" -maxdepth 1 -iname "$f*" -type f 2>/dev/null | head -1)
        if [ -n "$actual" ]; then
            found+=("$actual")
            case "$(basename "$actual" | tr 'a-z' 'A-Z')" in
                LICENSE-MIT*)         spdx_ids+=("MIT") ;;
                LICENSE-APACHE*)      spdx_ids+=("Apache-2.0") ;;
                LICENSE-BSD*)         spdx_ids+=("BSD-3-Clause") ;;
                LICENSE-ISC*)         spdx_ids+=("ISC") ;;
                LICENSE-MPL*)         spdx_ids+=("MPL-2.0") ;;
            esac
        fi
    done
    if [ "${#found[@]}" -ge 2 ]; then
        # Sort + uniq + join with " OR "
        printf "%s\n" "${spdx_ids[@]}" | sort -u | paste -sd '|' - | sed 's/|/ OR /g'
        return 0
    fi
    return 1
}
```

### 2-2. T1 SPDX (v1.10e 보존)

```bash
spdx_from_header() {
    local path="$1"
    head -10 "$path" 2>/dev/null \
        | grep -E "^SPDX-License-Identifier:" \
        | head -1 \
        | sed -E 's/^SPDX-License-Identifier:[[:space:]]*//' \
        | sed -E 's/[[:space:]]+$//'
}
```

### 2-3. T2 boilerplate 매칭

```bash
# priority order — audit/A1 §6
boilerplate_match() {
    local path="$1"
    local head_buf
    head_buf=$(head -30 "$path" 2>/dev/null)
    [ -z "$head_buf" ] && return 1
    
    local body
    body=$(cat "$path" 2>/dev/null)
    
    # AGPL-3 (longest GPL family)
    if echo "$head_buf" | grep -q "GNU AFFERO GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 3"; then
        _emit_gpl_family "AGPL-3.0" "$body"; return 0
    fi
    
    # LGPL-3
    if echo "$head_buf" | grep -q "GNU LESSER GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 3"; then
        _emit_gpl_family "LGPL-3.0" "$body"; return 0
    fi
    
    # LGPL-2.1
    if echo "$head_buf" | grep -q "GNU LESSER GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 2\.1"; then
        _emit_gpl_family "LGPL-2.1" "$body"; return 0
    fi
    
    # GPL-3
    if echo "$head_buf" | grep -q "GNU GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 3"; then
        _emit_gpl_family "GPL-3.0" "$body"; return 0
    fi
    
    # GPL-2
    if echo "$head_buf" | grep -q "GNU GENERAL PUBLIC LICENSE" \
       && echo "$head_buf" | grep -q -E "Version 2(,| |$)"; then
        _emit_gpl_family "GPL-2.0" "$body"; return 0
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
    if echo "$head_buf" | grep -q -E "^[[:space:]]*(The )?MIT License(\s|\(MIT\)|$)" \
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

# GPL family or-later/only suffix
_emit_gpl_family() {
    local base="$1"
    local body="$2"
    if echo "$body" | grep -q -E "any later version"; then
        echo "${base}-or-later"
    else
        echo "${base}-only"
    fi
}
```

### 2-4. main flow integration

`detect-project.sh` 현 v1.10e T1 section 자리에 본 통합 함수 호출:

```bash
# --- License detection (v1.10e2 — T1 SPDX → T2-Multi → T2 boilerplate → T3 fallback) ---
license=""

# T1 — SPDX-License-Identifier 헤더 (v1.10e 우선순위 보존)
license_path=$(license_file_first "$ROOT")
if [ -n "$license_path" ]; then
    license=$(spdx_from_header "$license_path")
fi

# T2-Multi — multi-file dual-license (LICENSE-MIT + LICENSE-APACHE 등)
if [ -z "$license" ]; then
    license=$(multi_dual_license "$ROOT" || echo "")
fi

# T2 — boilerplate 매칭 (single LICENSE 파일)
if [ -z "$license" ] && [ -n "$license_path" ]; then
    license=$(boilerplate_match "$license_path" || echo "")
fi

# NOTICE 보조 (informational — log only, output 동일)
if [ "$license" = "Apache-2.0" ] || echo "$license" | grep -q "^Apache-2"; then
    if [ -f "$ROOT/NOTICE" ] || [ -f "$ROOT/NOTICE.md" ] || [ -f "$ROOT/NOTICE.txt" ]; then
        : # log 가능 (현재는 silent — INTERVIEW_FLOW.md preview 표시용)
    fi
fi

# T3 — output 없음 (fallback). 미식별 시 emit 안 함
[ -n "$license" ] && echo "license = \"$license\""
```

위치: 현재 v1.10e의 `# --- License detection ...` block 통째 교체. monorepo 출력 전.

## 3. 매칭 우선순위 결정 (G4 — audit/A4)

**채택**: `(a) 첫 매칭 + longest-marker first` (audit/A1 §2-2 참조)

**순서**:
1. T1 (SPDX 헤더) — 항상 우선
2. T2-Multi (multi-file dual)
3. T2 (boilerplate, longest-marker first):
   - AGPL-3 → LGPL-3 → LGPL-2.1 → GPL-3 → GPL-2 (GPL family longest first)
   - Apache-2.0 → MPL-2.0 → Unlicense (specific markers)
   - BSD-3-Clause → BSD-2-Clause (3-clause longer match)
   - ISC → MIT (다른 perm phrase로 disambiguation)
   - MIT no-header fallback (Notion edge case)
4. T3 (output 없음)

**제외 대안**:
- (b) 단순 첫 매칭 — GPL-2가 GPL-3 본문도 매칭 risk
- (c) weighted score — bash 복잡도 ↑, 디버깅 어려움

## 4. NOTICE 파일 보조 (G5 — audit/A4)

**채택**: `(a) informational only`

**근거**:
- Apache-2.0 boilerplate 매칭 + NOTICE 파일 존재 → confidence 보강
- 단 NOTICE 부재가 Apache-2.0 부정 신호 아님 (NOTICE 선택 사항)
- 현 v1.10e2는 출력 동일 (`license = "Apache-2.0"`) — 단 INTERVIEW_FLOW.md preview에 `(NOTICE present)` 표시 옵션 검토

**제외 대안**:
- (b) confidence boost (Apache-2.0 strict — NOTICE 부재 시 매칭 거부) — false negative 증가 (NOTICE 선택사항이므로 부적절)
- (c) 보조 미적용 — 단순화 가능하지만 evidence 활용도 ↓

## 5. Multi-file dual-license 처리

**Rust 컨벤션** (대표):
```
LICENSE-MIT
LICENSE-APACHE
```

**감지**:
- `LICENSE-*` 패턴 case-insensitive grep
- 2건 이상 detect 시 `<id1> OR <id2>` SPDX expression stamp
- 단일 LICENSE만 있으면 → 일반 T2 처리

**예시 결과**:
- `LICENSE-MIT` + `LICENSE-APACHE` → `MIT OR Apache-2.0`
- `LICENSE-MIT` + `LICENSE-BSD` → `BSD-3-Clause OR MIT` (sort -u → 알파벳 순)
- `LICENSE-MIT` + `LICENSE-APACHE` + `LICENSE-MIT.bak` (백업파일) → `Apache-2.0 OR MIT` (백업 제외 필요)

**한계**: 백업 파일 / 변형 파일명 처리는 매트릭스 한정 (LICENSE-{MIT, APACHE, BSD, ISC, MPL}만). 임의 파일명은 미커버.

## 6. T1 우선순위 검증 — smoke Stage 14

T1 SPDX 헤더가 항상 T2 우선:
```
LICENSE 파일 콘텐츠:
SPDX-License-Identifier: MIT
                                 Apache License
                           Version 2.0, January 2004

→ 출력: license = "MIT"  (T1 wins, T2 boilerplate Apache 무시)
```

audit/A4 R6 명시: T1 sample 추출 시 T2 호출 안 함 (early return).

## 7. 후속 분기 — 본 v1.10e2 한계

bash detection 한계 → **v1.10e3** (메타데이터 license 필드):
- `package.json` `"license"` field
- `pyproject.toml` `[project].license` (PEP 621)
- `Cargo.toml` `[package].license`

→ T2 boilerplate 매칭 false negative 케이스 (modified license, 헤더 변형) 회복 가능.

## 관련 문서

- 본 audit: `A1-boilerplate-regex.md` (regex spec) · `A2-recovery-rate.md` (sample 검증) · `A4-policy-decisions.md` (정책)
- v1.10e: `../v1.10e-detect-license/audit/A3-detect-strategy.md` (T1 only 알고리즘)
- 외부: [SPDX Expression](https://spdx.github.io/spdx-spec/v2.3/SPDX-license-expressions/) (multi-file dual `OR` 연산자)

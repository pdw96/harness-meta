#!/usr/bin/env bash
# v1.10e3 smoke — T3 메타데이터 4 source + UNLICENSED + SEE LICENSE IN + LICENSE 우선순위 + path traversal
# (audit `sessions/meta/v1.10e3-license-metadata/audit/A1-A5`)
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
DETECT="$HARNESS_META_ROOT/bootstrap/detect-project.sh"

[ -x "$DETECT" ] || { echo "FAIL — $DETECT 부재 또는 실행 불가"; exit 1; }

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

PASS_COUNT=0
TOTAL=0

run_stage() {
    local n="$1"; local name="$2"; local expect="$3"; local dir="$4"
    TOTAL=$((TOTAL + 1))
    echo "=== Stage $n — $name ==="
    local out
    out=$(bash "$DETECT" "$dir" 2>/dev/null)
    if [ -z "$expect" ]; then
        # T4 fallback expected — license 라인 emit 안 됨
        if echo "$out" | grep -q '^license = '; then
            echo "FAIL Stage $n — T4 fallback 위반 (license 매칭됨)"
            echo "STDOUT:"; echo "$out"; exit 1
        else
            echo "PASS Stage $n — T4 fallback (output 없음)"
            PASS_COUNT=$((PASS_COUNT + 1))
        fi
    else
        if echo "$out" | grep -q "^license = \"$expect\"$"; then
            echo "PASS Stage $n — license = \"$expect\""
            PASS_COUNT=$((PASS_COUNT + 1))
        else
            echo "FAIL Stage $n — 기대 \"$expect\" 미매칭"
            echo "STDOUT:"; echo "$out"; exit 1
        fi
    fi
    echo ""
}

# Stage 1 — M1 npm package.json string
D=$TMPDIR/s1; mkdir -p "$D"
printf '{"license": "MIT"}\n' > "$D/package.json"
run_stage 1 "M1 npm string MIT" "MIT" "$D"

# Stage 2 — M2 PEP 639 modern string
D=$TMPDIR/s2; mkdir -p "$D"
cat > "$D/pyproject.toml" <<'EOF'
[project]
name = "s2"
license = "Apache-2.0"
EOF
run_stage 2 "M2 PEP 639 modern string Apache-2.0" "Apache-2.0" "$D"

# Stage 3 — M2-legacy PEP 621 inline {text}
D=$TMPDIR/s3; mkdir -p "$D"
cat > "$D/pyproject.toml" <<'EOF'
[project]
name = "s3"
license = {text = "MIT"}
EOF
run_stage 3 "M2-legacy PEP 621 inline {text} MIT" "MIT" "$D"

# Stage 4 — M3 Poetry deprecated
D=$TMPDIR/s4; mkdir -p "$D"
cat > "$D/pyproject.toml" <<'EOF'
[tool.poetry]
name = "s4"
license = "GPL-3.0"
EOF
run_stage 4 "M3 Poetry GPL-3.0" "GPL-3.0" "$D"

# Stage 5 — M4 Cargo string
D=$TMPDIR/s5; mkdir -p "$D"
cat > "$D/Cargo.toml" <<'EOF'
[package]
name = "s5"
version = "0.1.0"
license = "MIT OR Apache-2.0"
EOF
run_stage 5 "M4 Cargo string MIT OR Apache-2.0" "MIT OR Apache-2.0" "$D"

# Stage 6 — UNLICENSED → LicenseRef-UNLICENSED 정규화
D=$TMPDIR/s6; mkdir -p "$D"
printf '{"license": "UNLICENSED"}\n' > "$D/package.json"
run_stage 6 "UNLICENSED → LicenseRef-UNLICENSED" "LicenseRef-UNLICENSED" "$D"

# Stage 7 — SEE LICENSE IN <file> 1회 재귀 + T1 SPDX 헤더 매칭
D=$TMPDIR/s7; mkdir -p "$D"
printf '{"license": "SEE LICENSE IN custom.txt"}\n' > "$D/package.json"
printf 'SPDX-License-Identifier: BSD-3-Clause\n\nCopyright (c) ...\n' > "$D/custom.txt"
run_stage 7 "SEE LICENSE IN custom.txt → T1 BSD-3-Clause" "BSD-3-Clause" "$D"

# Stage 8 — LICENSE 콘텐츠 우선 (T2 over T3)
D=$TMPDIR/s8; mkdir -p "$D"
printf '{"license": "Apache-2.0"}\n' > "$D/package.json"
cat > "$D/LICENSE" <<'EOF'
MIT License

Copyright (c) 2026 Example Author

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software...
EOF
run_stage 8 "LICENSE 우선 (T2 MIT over 메타 Apache-2.0)" "MIT" "$D"

# Stage 9 — LICENSE 부재 + 메타 only (v1.10e3 신규 회복)
D=$TMPDIR/s9; mkdir -p "$D"
printf '{"name": "s9", "license": "ISC"}\n' > "$D/package.json"
run_stage 9 "LICENSE 부재 + 메타 ISC (v1.10e3 신규 회복)" "ISC" "$D"

# Stage 10 — T4 silent (메타 부재 + LICENSE 부재)
D=$TMPDIR/s10; mkdir -p "$D"
printf '{"name": "s10"}\n' > "$D/package.json"
run_stage 10 "T4 silent (메타 부재)" "" "$D"

# Stage 11 — pyproject 우선순위 (PEP 639 over poetry)
D=$TMPDIR/s11; mkdir -p "$D"
cat > "$D/pyproject.toml" <<'EOF'
[project]
name = "s11"
license = "MIT"

[tool.poetry]
license = "GPL-3.0"
EOF
run_stage 11 "pyproject 우선순위 (PEP 639 MIT over poetry GPL-3.0)" "MIT" "$D"

# Stage 12 — Path traversal 차단 (SEE LICENSE IN ../../etc/passwd)
D=$TMPDIR/s12; mkdir -p "$D"
printf '{"license": "SEE LICENSE IN ../../etc/passwd"}\n' > "$D/package.json"
run_stage 12 "Path traversal 차단 → silent" "" "$D"

# Stage 13 (Bonus) — Cargo license-file 보강 (T2.5)
D=$TMPDIR/s13; mkdir -p "$D"
cat > "$D/Cargo.toml" <<'EOF'
[package]
name = "s13"
version = "0.1.0"
license-file = "LICENSE-CUSTOM.txt"
EOF
printf 'SPDX-License-Identifier: ISC\n' > "$D/LICENSE-CUSTOM.txt"
run_stage 13 "T2.5 Cargo license-file 보강 → ISC" "ISC" "$D"

# Stage 14 (Bonus) — npm legacy {type, url} object 부분 지원
D=$TMPDIR/s14; mkdir -p "$D"
cat > "$D/package.json" <<'EOF'
{
  "name": "s14",
  "license": {
    "type": "MIT",
    "url": "https://opensource.org/licenses/MIT"
  }
}
EOF
run_stage 14 "npm legacy {type, url} object 부분 지원 → MIT" "MIT" "$D"

echo ""
echo "=========================================="
echo "Total: $PASS_COUNT/$TOTAL stages PASS"
echo "=========================================="

if [ "$PASS_COUNT" -ne "$TOTAL" ]; then
    exit 1
fi
exit 0

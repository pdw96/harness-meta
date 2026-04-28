#!/usr/bin/env bash
# v1.10e smoke — T1 SPDX-License-Identifier 헤더 감지 + T3 fallback 검증
# Option C — T1 only. T2 boilerplate 매칭은 v1.10e2 후속.
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
DETECT="$HARNESS_META_ROOT/bootstrap/detect-project.sh"

[ -x "$DETECT" ] || { echo "FAIL — $DETECT 부재 또는 실행 불가"; exit 1; }

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# Stage 1 — T1 SPDX MIT
echo "=== Stage 1 — T1 SPDX MIT ==="
mkdir -p "$TMPDIR/s1"
{ echo "SPDX-License-Identifier: MIT"; echo ""; echo "MIT License"; } > "$TMPDIR/s1/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s1" 2>/dev/null)
if echo "$OUT" | grep -q 'license = "MIT"'; then
    echo "PASS Stage 1"
else
    echo "FAIL Stage 1 — T1 MIT 미매칭"
    echo "STDOUT:"
    echo "$OUT"
    exit 1
fi

# Stage 2 — T1 SPDX Apache-2.0
echo ""
echo "=== Stage 2 — T1 SPDX Apache-2.0 ==="
mkdir -p "$TMPDIR/s2"
echo "SPDX-License-Identifier: Apache-2.0" > "$TMPDIR/s2/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s2" 2>/dev/null)
if echo "$OUT" | grep -q 'license = "Apache-2.0"'; then
    echo "PASS Stage 2"
else
    echo "FAIL Stage 2 — T1 Apache-2.0 미매칭"
    echo "STDOUT:"
    echo "$OUT"
    exit 1
fi

# Stage 3 — T1 SPDX dual-license expression
echo ""
echo "=== Stage 3 — T1 SPDX dual-license expression (MIT OR Apache-2.0) ==="
mkdir -p "$TMPDIR/s3"
echo "SPDX-License-Identifier: MIT OR Apache-2.0" > "$TMPDIR/s3/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s3" 2>/dev/null)
if echo "$OUT" | grep -q 'license = "MIT OR Apache-2.0"'; then
    echo "PASS Stage 3"
else
    echo "FAIL Stage 3 — T1 dual-license expression 미매칭"
    echo "STDOUT:"
    echo "$OUT"
    exit 1
fi

# Stage 4 — T3 fallback (boilerplate만, SPDX 헤더 없음)
echo ""
echo "=== Stage 4 — T3 fallback (boilerplate만, SPDX 헤더 없음) ==="
mkdir -p "$TMPDIR/s4"
{ echo "MIT License"; echo ""; echo "Copyright (c) 2026 Test"; } > "$TMPDIR/s4/LICENSE"

OUT=$(bash "$DETECT" "$TMPDIR/s4" 2>/dev/null)
if echo "$OUT" | grep -q '^license = '; then
    echo "FAIL Stage 4 — T3 fallback 위반 (boilerplate 매칭됨, T2는 v1.10e2 후속)"
    echo "STDOUT:"
    echo "$OUT"
    exit 1
else
    echo "PASS Stage 4 — T3 fallback (boilerplate-only LICENSE → output 없음)"
fi

# Bonus — LICENSE 파일명 변형 (LICENSE.md case)
echo ""
echo "=== Stage 5 — LICENSE.md case (T1 우선순위 검증) ==="
mkdir -p "$TMPDIR/s5"
echo "SPDX-License-Identifier: ISC" > "$TMPDIR/s5/LICENSE.md"

OUT=$(bash "$DETECT" "$TMPDIR/s5" 2>/dev/null)
if echo "$OUT" | grep -q 'license = "ISC"'; then
    echo "PASS Stage 5 — LICENSE.md 우선순위"
else
    echo "FAIL Stage 5 — LICENSE.md 미감지"
    echo "STDOUT:"
    echo "$OUT"
    exit 1
fi

echo ""
echo "============================="
echo "smoke-bootstrap-license-detect PASS — 5/5"
echo "============================="

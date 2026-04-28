#!/usr/bin/env bash
# v1.10e2 smoke — T2 boilerplate 12 패턴 + multi-file dual + GPL or-later + T1 우선순위
# (audit `sessions/meta/v1.10e2-license-boilerplate/audit/A1-A5`)
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
        # T3 fallback expected — license 라인 emit 안 됨
        if echo "$out" | grep -q '^license = '; then
            echo "FAIL Stage $n — T3 fallback 위반 (license 매칭됨)"
            echo "STDOUT:"; echo "$out"; exit 1
        else
            echo "PASS Stage $n — T3 fallback (output 없음)"
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

# ===== Stage 1 — MIT boilerplate (header) =====
mkdir -p "$TMPDIR/s1"
cat > "$TMPDIR/s1/LICENSE" <<'EOF'
MIT License

Copyright (c) 2026 Test

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction.
EOF
run_stage 1 "MIT boilerplate (header)" "MIT" "$TMPDIR/s1"

# ===== Stage 2 — Apache-2.0 boilerplate (leading whitespace) =====
mkdir -p "$TMPDIR/s2"
cat > "$TMPDIR/s2/LICENSE" <<'EOF'

                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
EOF
run_stage 2 "Apache-2.0 boilerplate (leading WS)" "Apache-2.0" "$TMPDIR/s2"

# ===== Stage 3 — GPL-2.0-only =====
mkdir -p "$TMPDIR/s3"
cat > "$TMPDIR/s3/LICENSE" <<'EOF'
                    GNU GENERAL PUBLIC LICENSE
                       Version 2, June 1991

 Copyright (C) 1989, 1991 Free Software Foundation, Inc.
EOF
run_stage 3 "GPL-2.0-only (no or-later)" "GPL-2.0-only" "$TMPDIR/s3"

# ===== Stage 4 — GPL-3.0-or-later =====
mkdir -p "$TMPDIR/s4"
cat > "$TMPDIR/s4/LICENSE" <<'EOF'
                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc.
 either version 3 of the License, or (at your option) any later version.
EOF
run_stage 4 "GPL-3.0-or-later (any later version)" "GPL-3.0-or-later" "$TMPDIR/s4"

# ===== Stage 5 — AGPL-3.0-only =====
mkdir -p "$TMPDIR/s5"
cat > "$TMPDIR/s5/LICENSE" <<'EOF'
                    GNU AFFERO GENERAL PUBLIC LICENSE
                       Version 3, 19 November 2007

 Copyright (C) 2007 Free Software Foundation, Inc.
EOF
run_stage 5 "AGPL-3.0-only (longest GPL family priority)" "AGPL-3.0-only" "$TMPDIR/s5"

# ===== Stage 6 — LGPL-2.1-or-later =====
mkdir -p "$TMPDIR/s6"
cat > "$TMPDIR/s6/LICENSE" <<'EOF'
                    GNU LESSER GENERAL PUBLIC LICENSE
                       Version 2.1, February 1999

 either version 2.1 of the License, or (at your option) any later version.
EOF
run_stage 6 "LGPL-2.1-or-later" "LGPL-2.1-or-later" "$TMPDIR/s6"

# ===== Stage 7 — LGPL-3.0-only =====
mkdir -p "$TMPDIR/s7"
cat > "$TMPDIR/s7/LICENSE" <<'EOF'
                    GNU LESSER GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007
EOF
run_stage 7 "LGPL-3.0-only" "LGPL-3.0-only" "$TMPDIR/s7"

# ===== Stage 8 — BSD-3-Clause =====
mkdir -p "$TMPDIR/s8"
cat > "$TMPDIR/s8/LICENSE" <<'EOF'
Copyright (c) 2026 Test

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice
2. Redistributions in binary form must reproduce the above copyright notice
3. Neither the name of the copyright holder nor the names of its contributors
EOF
run_stage 8 "BSD-3-Clause (3. Neither marker)" "BSD-3-Clause" "$TMPDIR/s8"

# ===== Stage 9 — BSD-2-Clause =====
mkdir -p "$TMPDIR/s9"
cat > "$TMPDIR/s9/LICENSE" <<'EOF'
Copyright (c) 2026 Test

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice
2. Redistributions in binary form must reproduce the above copyright notice
EOF
run_stage 9 "BSD-2-Clause (no 3. Neither marker)" "BSD-2-Clause" "$TMPDIR/s9"

# ===== Stage 10 — ISC =====
mkdir -p "$TMPDIR/s10"
cat > "$TMPDIR/s10/LICENSE" <<'EOF'
Copyright (c) 2026 Test

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
EOF
run_stage 10 "ISC (different perm phrase from MIT)" "ISC" "$TMPDIR/s10"

# ===== Stage 11 — MPL-2.0 =====
mkdir -p "$TMPDIR/s11"
cat > "$TMPDIR/s11/LICENSE" <<'EOF'
Mozilla Public License Version 2.0

1. Definitions
EOF
run_stage 11 "MPL-2.0" "MPL-2.0" "$TMPDIR/s11"

# ===== Stage 12 — Unlicense =====
mkdir -p "$TMPDIR/s12"
cat > "$TMPDIR/s12/LICENSE" <<'EOF'
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

For more information, please refer to <https://unlicense.org>
EOF
run_stage 12 "Unlicense" "Unlicense" "$TMPDIR/s12"

# ===== Stage 13 — multi-file dual-license (Rust 컨벤션) =====
mkdir -p "$TMPDIR/s13"
cat > "$TMPDIR/s13/LICENSE-MIT" <<'EOF'
MIT License

Copyright (c) 2026 Test

Permission is hereby granted, free of charge, to any person obtaining a copy
EOF
cat > "$TMPDIR/s13/LICENSE-APACHE" <<'EOF'

                                 Apache License
                           Version 2.0, January 2004
EOF
run_stage 13 "Multi-file dual (LICENSE-MIT + LICENSE-APACHE)" "Apache-2.0 OR MIT" "$TMPDIR/s13"

# ===== Stage 14 — T1 우선순위 (SPDX wins over body Apache boilerplate) =====
mkdir -p "$TMPDIR/s14"
cat > "$TMPDIR/s14/LICENSE" <<'EOF'
SPDX-License-Identifier: MIT

                                 Apache License
                           Version 2.0, January 2004
EOF
run_stage 14 "T1 우선순위 (SPDX MIT wins over Apache body)" "MIT" "$TMPDIR/s14"

# ===== Stage 15 — Notion edge (header 부재 MIT — body+copyright fallback) =====
mkdir -p "$TMPDIR/s15"
cat > "$TMPDIR/s15/LICENSE" <<'EOF'
Copyright (c) Test contributors
Copyright (c) 2026 Anonymous Inc.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files
EOF
run_stage 15 "Notion edge (header 부재 MIT)" "MIT" "$TMPDIR/s15"

# ===== Stage 16 — T3 fallback (LICENSE 부재) =====
mkdir -p "$TMPDIR/s16"
# LICENSE 미작성
run_stage 16 "T3 fallback (LICENSE 부재)" "" "$TMPDIR/s16"

# ===== Stage 17 — T3 fallback (LICENSE 존재, boilerplate 미매칭 — proprietary EULA) =====
mkdir -p "$TMPDIR/s17"
cat > "$TMPDIR/s17/LICENSE" <<'EOF'
PROPRIETARY SOFTWARE LICENSE AGREEMENT

Copyright (c) 2026 Acme Corp.

All rights reserved. This software is proprietary and confidential.
Unauthorized copying or distribution is strictly prohibited.
EOF
run_stage 17 "T3 fallback (proprietary EULA — boilerplate 미매칭)" "" "$TMPDIR/s17"

# ===== Stage 18 — multi-file backup 제외 (LICENSE-MIT.bak 무시 — false positive 방지) =====
mkdir -p "$TMPDIR/s18"
cat > "$TMPDIR/s18/LICENSE-MIT" <<'EOF'
MIT License
EOF
cat > "$TMPDIR/s18/LICENSE-APACHE" <<'EOF'
                                 Apache License
                           Version 2.0
EOF
cat > "$TMPDIR/s18/LICENSE-MIT.bak" <<'EOF'
MIT License (backup — should be ignored, not added as 3rd license)
EOF
# 결과: LICENSE-MIT + LICENSE-APACHE (2건) → "Apache-2.0 OR MIT". .bak는 글로브 제외 패턴으로 무시
run_stage 18 "multi-file .bak 제외 (LICENSE-MIT + LICENSE-APACHE + LICENSE-MIT.bak → 2건만 사용)" "Apache-2.0 OR MIT" "$TMPDIR/s18"

echo ""
echo "============================="
echo "smoke-bootstrap-license-boilerplate PASS — $PASS_COUNT/$TOTAL"
echo "============================="

if [ "$PASS_COUNT" -ne "$TOTAL" ]; then
    echo "FAIL — $((TOTAL - PASS_COUNT)) stage 미통과"
    exit 1
fi

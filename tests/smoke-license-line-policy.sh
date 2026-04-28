#!/usr/bin/env bash
# v1.10h smoke — L5 license 라인 3-way + MAX_LENGTH=80 + license_file relative path
# Stage 1 (detect-project.sh source 검증) + Stage 2 (interview.md 3-way + MAX_LENGTH)
# + Stage 3 (INTERVIEW_FLOW.md HM_LICENSE_FILE 각주) + Stage 4 (end-to-end fixture)
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

DETECT="bootstrap/detect-project.sh"
INTV="bootstrap/interview.md"
FLOW="bootstrap/docs/INTERVIEW_FLOW.md"

PASS=0; FAIL=0
ok()   { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

# Stage 1 — detect-project.sh source 검증 (2 checks)
echo "=== Stage 1 — detect-project.sh license_file (R1) ==="
if grep -qE '^license_file=""' "$DETECT"; then
    ok "license_file 변수 정의 (line ~427)"
else
    fail "license_file 변수 정의 부재"
fi
if grep -qE 'echo "license_file = ' "$DETECT"; then
    ok "license_file echo 출력 라인"
else
    fail "license_file echo 출력 부재"
fi

# Stage 2 — interview.md 3-way + MAX_LENGTH (3 checks)
echo ""
echo "=== Stage 2 — interview.md R2+R3 (3-way + MAX_LENGTH=80) ==="
if grep -q 'HM_LICENSE_FILE' "$INTV"; then
    ok "HM_LICENSE_FILE 변수 사용"
else
    fail "HM_LICENSE_FILE 변수 미사용"
fi
if grep -qE 'MAX_LENGTH=80|len\(HM_LICENSE\) > 80' "$INTV"; then
    ok "MAX_LENGTH=80 명시"
else
    fail "MAX_LENGTH=80 미명시"
fi
# 3-way: Case 1 / Case 2 / Case 3 모두 명시
case_count=$(grep -cE '^\| (1|2|3) \|' "$INTV" || true)
if [ "$case_count" -ge 3 ]; then
    ok "3-way Case 1/2/3 표 명시 ($case_count rows)"
else
    fail "3-way Case 1/2/3 표 부재 ($case_count rows)"
fi

# Stage 3 — INTERVIEW_FLOW.md (2 checks)
echo ""
echo "=== Stage 3 — INTERVIEW_FLOW.md R4 ==="
if grep -q 'license_file' "$FLOW"; then
    ok "{{license}} description에 license_file 언급"
else
    fail "license_file 언급 부재"
fi
if grep -q 'HM_LICENSE_FILE' "$FLOW"; then
    ok "HM_LICENSE_FILE env 각주"
else
    fail "HM_LICENSE_FILE env 각주 부재"
fi

# Stage 4 — end-to-end fixture (2 checks, mktemp)
echo ""
echo "=== Stage 4 — end-to-end fixture (실 detect-project.sh 실행) ==="
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

# Fixture A: MIT LICENSE 파일 존재 → license_file = "LICENSE"
mkdir -p "$TMPDIR/fixtureA"
cat > "$TMPDIR/fixtureA/LICENSE" <<'EOF'
MIT License

Copyright (c) 2026 test

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.
EOF

outA=$(bash "$DETECT" "$TMPDIR/fixtureA" 2>/dev/null || echo "")
if echo "$outA" | grep -qE '^license = "MIT"$'; then
    ok "Fixture A: license = \"MIT\" (T2 boilerplate)"
else
    fail "Fixture A: license = \"MIT\" 추출 실패. out=[$outA]"
fi
if echo "$outA" | grep -qE '^license_file = "LICENSE"$'; then
    ok "Fixture A: license_file = \"LICENSE\" (R1 출력)"
else
    fail "Fixture A: license_file = \"LICENSE\" 출력 실패"
fi

# Fixture B: pyproject license + LICENSE 파일 부재 → license set + license_file empty
mkdir -p "$TMPDIR/fixtureB"
cat > "$TMPDIR/fixtureB/pyproject.toml" <<'EOF'
[project]
name = "test-pkg"
license = "MIT"
EOF

outB=$(bash "$DETECT" "$TMPDIR/fixtureB" 2>/dev/null || echo "")
if echo "$outB" | grep -qE '^license = "MIT"$'; then
    ok "Fixture B: license = \"MIT\" (T3 메타)"
else
    fail "Fixture B: license = \"MIT\" 추출 실패. out=[$outB]"
fi
if echo "$outB" | grep -qE '^license_file = '; then
    fail "Fixture B: license_file 출력 — T3 only인데 출력됨 (LICENSE 부재여야 empty)"
else
    ok "Fixture B: license_file 출력 부재 (T3 only — LICENSE 파일 부재 정상)"
fi

# 결과
echo ""
echo "=== 결과: $PASS PASS / $FAIL FAIL ==="
[ "$FAIL" -eq 0 ] || exit 1
echo "v1.10h smoke 9/9 PASS — L5 license 라인 정책 정상"

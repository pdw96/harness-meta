#!/usr/bin/env bash
# smoke-detect-language.sh — v1.53 detect_language priority tie-breaking + Shell 등재 검증
# Stage 1: 정적 3 checks  |  Stage 2: 동적 3 checks  |  Total: 6/6

set -euo pipefail
cd "$(dirname "$0")/.."

PASS=0; FAIL=0
ok()   { echo "  ✓ $*"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $*"; FAIL=$((FAIL+1)); }

UTILS="bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py"

echo "=== Stage 1 — Static (3) ==="

# S1: _LANG_PRIORITY 상수 존재
if grep -q '_LANG_PRIORITY' "$UTILS"; then
    ok "_LANG_PRIORITY 상수 존재"
else
    fail "_LANG_PRIORITY 상수 누락"
fi

# S2: detect_language 내 priority tie-breaking 패턴 존재
if grep -q '_LANG_PRIORITY.get(k, 0)' "$UTILS"; then
    ok "detect_language: _LANG_PRIORITY.get(k, 0) tie-breaking 패턴 존재"
else
    fail "detect_language: priority tie-breaking 패턴 누락"
fi

# S3: lang_map에 Shell 등재
if grep -q '".sh": "Shell"' "$UTILS"; then
    ok 'lang_map: ".sh": "Shell" 존재'
else
    fail 'lang_map: Shell 미등재'
fi

echo ""
echo "=== Stage 2 — Dynamic (3) ==="

SCORER_DIR="bootstrap/skills/audit/ai-ready-scorer/scripts"

# D1: .py + .toml tie → "Python" (priority 기반 우선)
D1_OUT=$(python3 -c "
import sys; sys.path.insert(0, '$SCORER_DIR')
from utils import detect_language
from pathlib import Path
import tempfile, os

with tempfile.TemporaryDirectory() as td:
    r = Path(td)
    (r / 'main.py').write_text('x = 1')
    (r / 'pyproject.toml').write_text('[project]')
    tracked = [r / 'main.py', r / 'pyproject.toml']
    lang = detect_language(r, tracked)
    assert lang == 'Python', f'expected Python, got {lang!r}'
    print('ok')
" 2>&1)
if [ "$D1_OUT" = "ok" ]; then
    ok "D1: .py + .toml tie → Python (priority 100 > 0)"
else
    fail "D1: .py + .toml tie 결과 오류. output: $D1_OUT"
fi

# D2: .sh + .md tie → "Shell" (priority 70 > 0)
D2_OUT=$(python3 -c "
import sys; sys.path.insert(0, '$SCORER_DIR')
from utils import detect_language
from pathlib import Path
import tempfile

with tempfile.TemporaryDirectory() as td:
    r = Path(td)
    (r / 'install.sh').write_text('#!/bin/bash')
    (r / 'README.md').write_text('# readme')
    tracked = [r / 'install.sh', r / 'README.md']
    lang = detect_language(r, tracked)
    assert lang == 'Shell', f'expected Shell, got {lang!r}'
    print('ok')
" 2>&1)
if [ "$D2_OUT" = "ok" ]; then
    ok "D2: .sh + .md tie → Shell (priority 70 > 0)"
else
    fail "D2: .sh + .md tie 결과 오류. output: $D2_OUT"
fi

# D3: tiny Python repo (1 .py, no deps) → is_shell_markdown_only_repo True (N/A 보호 유지)
D3_OUT=$(python3 -c "
import sys; sys.path.insert(0, '$SCORER_DIR')
from utils import is_shell_markdown_only_repo
from pathlib import Path
import tempfile

with tempfile.TemporaryDirectory() as td:
    r = Path(td)
    py = r / 'script.py'
    py.write_text('print(\"hello\")')
    tracked = [py]
    result = is_shell_markdown_only_repo(r, tracked, 'Python')
    assert result is True, f'expected True (tiny Python gets N/A), got {result}'
    print('ok')
" 2>&1)
if [ "$D3_OUT" = "ok" ]; then
    ok "D3: tiny Python (1 .py, no deps) → is_shell_markdown_only_repo True (N/A 보호 유지)"
else
    fail "D3: tiny Python N/A 보호 오류. output: $D3_OUT"
fi

echo ""
echo "=== Summary ==="
echo "PASS: $PASS / $((PASS+FAIL))"
if [ "$FAIL" -gt 0 ]; then
    echo "FAIL: $FAIL"
    exit 1
fi

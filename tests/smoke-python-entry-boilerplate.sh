#!/usr/bin/env bash
# smoke-python-entry-boilerplate.sh — v1.87
#
# Python entry-point boilerplate audit (cross-platform 화석화).
#
#   P1 — `*.write_text(...)` 호출은 `newline="\n"` 인자 의무
#        (v1.69 lesson: Windows CRLF universal newline 변환 차단)
#        Python 3.10+ `pathlib.Path.write_text(data, encoding=None, errors=None, newline=None)`
#
#   P2 — `if __name__ == "__main__":` + `print(...)` 보유 script는
#        `sys.stdout.reconfigure(encoding=...)` 의무
#        (v1.18d lesson: Windows cp949 default emoji UnicodeEncodeError 차단)
#        Python 3.7+ `io.TextIOWrapper.reconfigure(*, encoding, errors, newline, ...)`
#
# AST 기반 정적 audit (parens-aware, false positive 차단).
# Stage 1+2 dogfood: bootstrap/skills/**/*.py
# Stage 3 E2E: mktemp fixture violation/clean detection.

set -euo pipefail

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || (cd "$(dirname "$0")/.." && pwd))
cd "$REPO_ROOT"

SCAN_GLOB="bootstrap/skills"
PASS=0
FAIL=0
DOGFOOD_FAIL_LINES=()

audit_file() {
    # Args: $1=path. Exit 0 if PASS, 1 if violations. Prints "FAIL\t<path>\t<reason>" lines.
    python3 - "$1" <<'PYEOF'
import ast
import sys
from pathlib import Path

path_str = sys.argv[1]
src = Path(path_str).read_text(encoding="utf-8")

try:
    tree = ast.parse(src)
except SyntaxError as e:
    print(f"FAIL\t{path_str}\tsyntax error: {e}")
    sys.exit(1)

violations = []

# P1: *.write_text(...) without newline= kwarg
for node in ast.walk(tree):
    if isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute):
        if node.func.attr == "write_text":
            kwarg_names = [kw.arg for kw in node.keywords]
            if "newline" not in kwarg_names:
                violations.append(f"P1:line {node.lineno}:write_text without newline=")

# P2: module-level `if __name__ == "__main__":` block
has_main_block = False
for node in tree.body:
    if isinstance(node, ast.If):
        test = node.test
        if (isinstance(test, ast.Compare)
                and isinstance(test.left, ast.Name)
                and test.left.id == "__name__"
                and len(test.ops) == 1
                and isinstance(test.ops[0], ast.Eq)
                and len(test.comparators) == 1
                and isinstance(test.comparators[0], ast.Constant)
                and test.comparators[0].value == "__main__"):
            has_main_block = True
            break

has_print_call = False
has_reconfigure_call = False
for node in ast.walk(tree):
    if isinstance(node, ast.Call):
        if isinstance(node.func, ast.Name) and node.func.id == "print":
            has_print_call = True
        if isinstance(node.func, ast.Attribute) and node.func.attr == "reconfigure":
            kwarg_names = [kw.arg for kw in node.keywords]
            if "encoding" in kwarg_names:
                has_reconfigure_call = True

if has_main_block and has_print_call and not has_reconfigure_call:
    violations.append("P2:__main__ + print() without sys.stdout.reconfigure(encoding=...)")

if violations:
    for v in violations:
        print(f"FAIL\t{path_str}\t{v}")
    sys.exit(1)
sys.exit(0)
PYEOF
}

# ---------- Stage 1+2: dogfood ----------
mapfile -t PY_FILES < <(find "$SCAN_GLOB" -type f -name '*.py' -not -path '*/__pycache__/*' 2>/dev/null | sort)

if [ "${#PY_FILES[@]}" -eq 0 ]; then
    echo "[WARN] No .py files under $SCAN_GLOB"
fi

for f in "${PY_FILES[@]}"; do
    if output=$(audit_file "$f" 2>&1); then
        PASS=$((PASS + 1))
    else
        FAIL=$((FAIL + 1))
        if [ -n "$output" ]; then
            DOGFOOD_FAIL_LINES+=("$output")
        fi
    fi
done

# ---------- Stage 3: E2E fixture ----------
TMPDIR=$(mktemp -d)
# shellcheck disable=SC2064
trap 'rm -rf "$TMPDIR"' EXIT

cat > "$TMPDIR/violation_p1.py" <<'PYEOF'
from pathlib import Path
Path("x").write_text("hi", encoding="utf-8")
PYEOF

cat > "$TMPDIR/violation_p2.py" <<'PYEOF'
def main():
    print("hello")

if __name__ == "__main__":
    main()
PYEOF

cat > "$TMPDIR/clean.py" <<'PYEOF'
import sys
from pathlib import Path

def main():
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    print("hello")
    Path("x").write_text("hi", encoding="utf-8", newline="\n")

if __name__ == "__main__":
    main()
PYEOF

E2E_PASS=0
E2E_FAIL=0

run_e2e() {
    local f="$1" expected="$2" label="$3"
    if audit_file "$f" >/dev/null 2>&1; then
        actual="pass"
    else
        actual="fail"
    fi
    if [ "$actual" = "$expected" ]; then
        echo "[Stage 3] PASS: $label (expected=$expected)"
        E2E_PASS=$((E2E_PASS + 1))
    else
        echo "[Stage 3] FAIL: $label (expected=$expected got=$actual)"
        E2E_FAIL=$((E2E_FAIL + 1))
    fi
}

run_e2e "$TMPDIR/violation_p1.py" "fail" "P1 write_text without newline"
run_e2e "$TMPDIR/violation_p2.py" "fail" "P2 __main__ + print without reconfigure"
run_e2e "$TMPDIR/clean.py"        "pass" "clean fixture (P1+P2 satisfied)"

# ---------- Summary ----------
echo ""
echo "================================="
echo "smoke-python-entry-boilerplate.sh"
echo "================================="
echo "Stage 1+2 (dogfood, $SCAN_GLOB): PASS=$PASS FAIL=$FAIL (total=${#PY_FILES[@]})"
echo "Stage 3 (E2E fixture):           PASS=$E2E_PASS FAIL=$E2E_FAIL"

if [ "$FAIL" -gt 0 ]; then
    echo ""
    echo "Dogfood violations:"
    for line in "${DOGFOOD_FAIL_LINES[@]}"; do
        echo "  $line"
    done
fi

if [ "$FAIL" -eq 0 ] && [ "$E2E_FAIL" -eq 0 ]; then
    echo ""
    echo "RESULT: PASS"
    exit 0
fi

echo ""
echo "RESULT: FAIL"
exit 1

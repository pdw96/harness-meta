#!/usr/bin/env bash
# smoke-workflow-registration.sh
#
# Verifies that active smoke tests stay registered consistently across:
#   1. .pre-commit-config.yaml local smoke hooks
#   2. .github/workflows/ci.yml ACTIVE_SMOKES
#   3. Makefile smoke target
#
# This catches the automation drift where a smoke can be pre-commit-only or CI-only.

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

PASS=0
FAIL=0
SKIP=0

echo "=== Stage 1 — active smoke registration parity ==="

if ! command -v python3 >/dev/null 2>&1; then
    echo "  ⚠ python3 not available; skip registration parity check"
    SKIP=$((SKIP + 1))
else
    if python3 <<'PY'
from __future__ import annotations

import re
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(".")


def read(path: str) -> str:
    return (ROOT / path).read_text(encoding="utf-8", errors="replace")


precommit = read(".pre-commit-config.yaml")
ci = read(".github/workflows/ci.yml")
makefile = read("Makefile")

precommit_smokes = set()
for line in precommit.splitlines():
    if re.match(r"\s*entry:\s+bash\b", line):
        precommit_smokes.update(re.findall(r"tests/smoke-[\w-]+\.sh", line))
ci_smokes = set(re.findall(r"tests/smoke-[\w-]+\.sh", ci))

make_match = re.search(r"^smoke:\n(?P<body>.*?)(?:\n\S|\Z)", makefile, re.S | re.M)
make_body = make_match.group("body") if make_match else ""
make_smokes = set(re.findall(r"tests/smoke-[\w-]+\.sh", make_body))

failures: list[str] = []
if not precommit_smokes:
    failures.append(".pre-commit-config.yaml has no smoke hooks")
if not ci_smokes:
    failures.append(".github/workflows/ci.yml has no ACTIVE_SMOKES entries")
if not make_smokes:
    failures.append("Makefile smoke target has no smoke entries")

for label, current in (("CI", ci_smokes), ("Makefile", make_smokes)):
    missing = sorted(precommit_smokes - current)
    extra = sorted(current - precommit_smokes)
    if missing:
        failures.append(f"{label} missing: {', '.join(missing)}")
    if extra:
        failures.append(f"{label} extra: {', '.join(extra)}")

all_refs = precommit_smokes | ci_smokes | make_smokes
missing_files = sorted(path for path in all_refs if not (ROOT / path).is_file())
if missing_files:
    failures.append(f"referenced smoke files missing: {', '.join(missing_files)}")

if failures:
    for item in failures:
        print(f"FAIL: {item}")
    raise SystemExit(1)

print(
    "OK: active smoke registrations match "
    f"(pre-commit={len(precommit_smokes)}, CI={len(ci_smokes)}, Makefile={len(make_smokes)})"
)
PY
    then
        echo "  ✓ active smoke registrations are synchronized"
        PASS=$((PASS + 1))
    else
        echo "  ✗ active smoke registrations drifted"
        FAIL=$((FAIL + 1))
    fi
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
exit $((FAIL == 0 ? 0 : 1))

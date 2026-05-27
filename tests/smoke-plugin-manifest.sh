#!/usr/bin/env bash
# smoke-plugin-manifest.sh
#
# Verifies that .claude-plugin/plugin.json points at existing plugin assets and
# that explicitly listed agents match the standalone agents/*.md inventory.

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

PASS=0
FAIL=0
SKIP=0

echo "=== Stage 1 — Claude plugin manifest inventory ==="

if ! command -v python3 >/dev/null 2>&1; then
    echo "  ⚠ python3 not available; skip plugin manifest check"
    SKIP=$((SKIP + 1))
else
    if python3 <<'PY'
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(".")
MANIFEST = ROOT / ".claude-plugin" / "plugin.json"

failures: list[str] = []

try:
    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
except Exception as exc:
    print(f"FAIL: cannot parse {MANIFEST}: {exc}")
    raise SystemExit(1)

for key in ("name", "version", "description", "commands", "agents", "hooks", "skills"):
    if key not in manifest:
        failures.append(f"missing manifest key: {key}")

if manifest.get("name") != "harness-meta":
    failures.append(f"name mismatch: {manifest.get('name')!r}")

version = manifest.get("version", "")
if not re.match(r"^[0-9]+\.[0-9]+\.[0-9]+$", str(version)):
    failures.append(f"version is not semver-like: {version!r}")

for path in manifest.get("commands", []):
    p = ROOT / path
    if not p.is_dir():
        failures.append(f"commands path missing or not directory: {path}")
    elif not list(p.glob("*.md")):
        failures.append(f"commands path has no markdown commands: {path}")

hooks_path = ROOT / str(manifest.get("hooks", ""))
if not hooks_path.is_file():
    failures.append(f"hooks path missing: {manifest.get('hooks')!r}")
else:
    try:
        hooks = json.loads(hooks_path.read_text(encoding="utf-8"))
    except Exception as exc:
        failures.append(f"hooks JSON parse failed: {hooks_path}: {exc}")
    else:
        for command in re.findall(r"\$\{CLAUDE_PLUGIN_ROOT\}/([^\"']+)", hooks_path.read_text(encoding="utf-8")):
            if not (ROOT / command).is_file():
                failures.append(f"hook command target missing: {command}")
        if not hooks.get("hooks"):
            failures.append(f"hooks JSON missing top-level hooks object: {hooks_path}")

skills_path = ROOT / str(manifest.get("skills", ""))
if not skills_path.is_dir():
    failures.append(f"skills path missing or not directory: {manifest.get('skills')!r}")
else:
    skill_dirs = sorted(p for p in skills_path.iterdir() if p.is_dir())
    if not skill_dirs:
        failures.append("skills path has no skill directories")
    missing_skill_md = [p.name for p in skill_dirs if not (p / "SKILL.md").is_file()]
    if missing_skill_md:
        failures.append(f"skill directories missing SKILL.md: {', '.join(missing_skill_md)}")

manifest_agents = [ROOT / path for path in manifest.get("agents", [])]
for path in manifest.get("agents", []):
    if not (ROOT / path).is_file():
        failures.append(f"agent path missing: {path}")

actual_agents = sorted((ROOT / "agents").glob("*.md"))
manifest_agent_set = {p.resolve() for p in manifest_agents}
actual_agent_set = {p.resolve() for p in actual_agents}

missing_from_manifest = sorted(p.relative_to(ROOT).as_posix() for p in actual_agents if p.resolve() not in manifest_agent_set)
extra_in_manifest = sorted(p.relative_to(ROOT).as_posix() for p in manifest_agents if p.resolve() not in actual_agent_set)

if missing_from_manifest:
    failures.append(f"agents/*.md not listed in manifest: {', '.join(missing_from_manifest)}")
if extra_in_manifest:
    failures.append(f"manifest agents not standalone agents/*.md: {', '.join(extra_in_manifest)}")

if failures:
    for item in failures:
        print(f"FAIL: {item}")
    raise SystemExit(1)

print(
    "OK: plugin manifest inventory matches "
    f"(agents={len(actual_agents)}, skills={len(list(skills_path.iterdir())) if skills_path.is_dir() else 0})"
)
PY
    then
        echo "  ✓ plugin manifest inventory is valid"
        PASS=$((PASS + 1))
    else
        echo "  ✗ plugin manifest inventory drifted"
        FAIL=$((FAIL + 1))
    fi
fi

echo ""
echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
exit $((FAIL == 0 ? 0 : 1))

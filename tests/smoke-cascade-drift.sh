#!/usr/bin/env bash
# smoke-cascade-drift.sh
#
# Purpose: v6.4 cascade 자동 동기 mechanism 의 drift 자동 차단.
#   Host 안 `<!-- cascade-source: <path>#<anchor> expected-hash:<16-hex> -->` marker
#   가 source paragraph 의 실 hash 와 일치하는지 검증. 불일치 시 FAIL + 사용자
#   `/cascade-sync apply` 또는 `python scripts/cascade_sync.py --apply` trigger.
#
# 검증 scope (entry-form artifact closed-set, D7):
#   - repo-wide *.md (excluding .git / node_modules / .venv / _archive)
#   - marker comment 안 source path + anchor + expected hash
#
# 본 smoke 책임 = drift detect 만 (read-only). marker 갱신 책임 = scripts/cascade_sync.py (--apply).
#
# 활성: pre-commit hook (local 9건째 등재, v6.4_cascade-auto-sync-mechanism).
# Algo: V1 (python3 + regex + SHA-256). python3 부재 시 SKIP exit 0 (환경 가드).
# Defense-in-depth: SIZE_LIMIT 100KB 초과 host = WARN skip (silent SKIP 폐기, D12).
# ReDoS 차단: marker regex length-bounded (<path> {1,200} + <anchor> {1,100} + hash {16}).
# Path traversal 차단: marker <path> resolve 후 is_relative_to(REPO_ROOT) 검증 (D12).
#
# v3.21 narrative 정전화 3 단계 패턴 cycle 29 (사이드 effect — 본질 = mechanism creation 1차).

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-cascade-drift: SKIP (python3 not available)" >&2
    exit 0
fi

# script 부재 시 SKIP (mechanism 미설치 환경)
if [[ ! -f "scripts/cascade_sync.py" ]]; then
    echo "smoke-cascade-drift: SKIP (scripts/cascade_sync.py not found)" >&2
    exit 0
fi

# Delegate to script --check (script 가 단일 source of mechanism logic, D10)
# script 의 exit code 가 smoke exit code 정합:
#   0 = all hosts in sync (PASS)
#   1 = drift detected (FAIL)
#   2 = ERROR (path traversal / source 부재 / anchor 부재 / HTML escape 위반)
exec python3 scripts/cascade_sync.py --check

#!/usr/bin/env bash
# smoke-roadmap-archival.sh — v8.13_archival-mechanism-reconciliation
#
# 책임: development/ROADMAP.md milestones[] 안 status=='completed' entry 개수 <= 3 (recent 3, schema A2 규칙) 강제.
#       archival trim 누락 (v8.6 이후 16건 누적 같은 드리프트) 을 정적으로 차단.
#
# scope = development/ROADMAP.md 만 (meta 자체). projects/*/ROADMAP.md 는 제외 —
#         recent-3 + GitHub Releases archival 은 harness-meta 고유 메커니즘이고
#         upbit ROADMAP 는 upbit repo milestone 을 가리키는 포인터 인덱스(trace=upbit repo,
#         이 repo GitHub Releases archival 대상 아님). v8.13 사용자 결정 + oos_2 정합.
#
# in_progress / deferred 는 count 제외 (risk_3 — status 정확 매칭).
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$SCRIPT_DIR" || exit 1

PASS=0; FAIL=0; SKIP=0

if ! command -v python3 >/dev/null 2>&1; then
    echo "  - python3 미설치 — SKIP"
    echo "=== 결과: PASS=0 FAIL=0 SKIP=1 ==="
    exit 0
fi

# 공통 validator — 인자: <roadmap-path> <max-completed>
#   exit 0 = PASS (completed <= max) / 1 = violation (> max) / 2 = milestones[] 부재 (skip) / 3 = SIZE_LIMIT
validate() {
    python3 - "$1" "$2" <<'PYEOF'
import sys, re, json, os
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
path, maxc = sys.argv[1], int(sys.argv[2])
if not os.path.exists(path):
    print("file 부재"); sys.exit(2)
if os.path.getsize(path) > 100 * 1024:
    print("SIZE_LIMIT 100KB 초과"); sys.exit(3)
t = open(path, encoding='utf-8', errors='replace').read()
blocks = re.findall(r'```json\n(.*?)\n```', t, re.S)
ms = None
for b in blocks:
    try:
        d = json.loads(b)
    except Exception:
        continue
    if isinstance(d, dict) and 'milestones' in d:
        ms = d['milestones']; break
if ms is None:
    print("milestones[] 부재"); sys.exit(2)
comp = [e.get('version', '?') for e in ms if e.get('status') == 'completed']
if len(comp) > maxc:
    print(f"completed {len(comp)} > {maxc}: {comp}"); sys.exit(1)
print(f"completed {len(comp)} <= {maxc}: {comp}"); sys.exit(0)
PYEOF
}

echo "=== Stage 1 — development/ROADMAP.md milestones[] completed <= 3 ==="
out=$(validate "development/ROADMAP.md" 3); rc=$?
if [ $rc -eq 0 ]; then
    echo "  ✓ $out"; PASS=$((PASS+1))
elif [ $rc -eq 2 ]; then
    echo "  - SKIP ($out)"; SKIP=$((SKIP+1))
elif [ $rc -eq 3 ]; then
    echo "  ✗ $out"; FAIL=$((FAIL+1))
else
    echo "  ✗ $out (archival trim 누락 — recent 3 초과, REPORT/PROPOSE 또는 ## 기록 시점 archival 미수행)"; FAIL=$((FAIL+1))
fi

echo "=== Stage 2 — fixture (controlled 비교) ==="
out=$(validate "tests/fixtures/roadmap-archival/normal-3.md" 3); rc=$?
if [ $rc -eq 0 ]; then
    echo "  ✓ normal-3 → PASS as expected ($out)"; PASS=$((PASS+1))
else
    echo "  ✗ normal-3 → rc=$rc (expected 0): $out"; FAIL=$((FAIL+1))
fi
out=$(validate "tests/fixtures/roadmap-archival/violation-4.md" 3); rc=$?
if [ $rc -eq 1 ]; then
    echo "  ✓ violation-4 → FAIL detected as expected ($out)"; PASS=$((PASS+1))
else
    echo "  ✗ violation-4 → rc=$rc (expected 1): $out"; FAIL=$((FAIL+1))
fi

echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
exit $((FAIL == 0 ? 0 : 1))

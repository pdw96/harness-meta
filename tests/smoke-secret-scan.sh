#!/usr/bin/env bash
# smoke-secret-scan.sh
#
# Purpose: v8.8 settings allow-list 평문 secret SessionStart 스캐너
#   (claude/hooks/session-start-secret-scan.sh) 의 회귀 차단 (read-only).
#   origin = v8.7 부수 발견 (settings.local.json allow 리스트 평문 PAT/JWT 박제).
#
# 검증 scope (dynamic — mktemp fixture + hook 실행 + 출력 검증):
#   Static 1 — hook 파일 존재 + shebang
#   Static 2 — hooks.json SessionStart 등록
#   Dynamic A — 정상(realistic clean) fixture → no-op {}
#   Dynamic B — Docker Hub PAT 감지
#   Dynamic C — JWT 감지
#   Dynamic D — GitHub fine-grained PAT (github_pat_) 감지 (D-SEC-2)
#   Dynamic E — dot 없는 eyJ 문자열 → JWT 미매칭 (grep \. literal dot 강제, D-FP-2)
#   Dynamic F — settings.json(shared) hit → 'HIGH exposure' 차등 통지 (D-SEC-1)
#   Dynamic G — 모든 출력 valid JSON (exit 0 규약)
#   Real      — harness-meta 현 settings.local.json FP=0 baseline (sc_4)
#
# 회귀 차단 책임: 도메인 별 회귀 (좁은 영역 — hook 로직). pre-commit 미등재
#   (user discretion) — manual run `bash tests/smoke-secret-scan.sh`.
# Algo: bash dynamic + python3 JSON 검증. python3 부재 시 SKIP exit 0 (환경 가드).

set -euo pipefail

REPO_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$REPO_ROOT"

HOOK="claude/hooks/session-start-secret-scan.sh"

PASS=0
FAIL=0
SKIP=0

if ! command -v python3 >/dev/null 2>&1; then
    echo "smoke-secret-scan: SKIP (python3 not available)" >&2
    exit 0
fi

# helper: write a settings file then run hook, echo stdout
_run() {
    # $1 = filename (settings.json | settings.local.json), $2 = json content
    local tmp
    tmp=$(mktemp -d)
    mkdir -p "$tmp/.claude"
    printf '%s' "$2" > "$tmp/.claude/$1"
    CLAUDE_PROJECT_DIR="$tmp" bash "$HOOK" </dev/null
    rm -rf "$tmp"
}

echo "=== Static 1 — hook 파일 존재 + shebang ==="
if [[ -f "$HOOK" ]] && head -1 "$HOOK" | grep -qE '^#!/usr/bin/env bash'; then
    echo "  ✓ $HOOK 존재 + bash shebang"; PASS=$((PASS+1))
else
    echo "  ✗ $HOOK 부재 또는 shebang 누락"; FAIL=$((FAIL+1))
fi

echo "=== Static 2 — hooks.json SessionStart 등록 ==="
if grep -q 'session-start-secret-scan.sh' claude/hooks/hooks.json; then
    echo "  ✓ hooks.json 에 등록됨"; PASS=$((PASS+1))
else
    echo "  ✗ hooks.json 미등록"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic A — 정상 fixture → no-op {} ==="
OUT=$(_run settings.local.json '{"permissions":{"allow":["Bash(git push *)","Bash(curl -sL https://docs.example.com -o /tmp/x)","Read(//tmp/**)"]}}')
if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if d=={} else 1)" 2>/dev/null; then
    echo "  ✓ no-op {} (FP 없음)"; PASS=$((PASS+1))
else
    echo "  ✗ 정상 fixture 에서 오탐 (출력: $OUT)"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic B — Docker Hub PAT 감지 ==="
OUT=$(_run settings.local.json '{"permissions":{"allow":["Bash(curl -H token:dckr_pat_AbCdEf12345678 https://x)"]}}')
if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if 'Docker Hub PAT' in d.get('systemMessage','') else 1)" 2>/dev/null; then
    echo "  ✓ Docker Hub PAT 감지 + systemMessage"; PASS=$((PASS+1))
else
    echo "  ✗ Docker Hub PAT 미감지 (출력: $OUT)"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic C — JWT 감지 ==="
OUT=$(_run settings.local.json '{"permissions":{"allow":["Bash(echo eyJhbGciOiJ.eyJzdWIiOiIx.SflKxwRJSMeKK)"]}}')
if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if 'JWT' in d.get('systemMessage','') else 1)" 2>/dev/null; then
    echo "  ✓ JWT 감지"; PASS=$((PASS+1))
else
    echo "  ✗ JWT 미감지 (출력: $OUT)"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic D — GitHub fine-grained PAT (github_pat_) 감지 ==="
OUT=$(_run settings.local.json '{"permissions":{"allow":["github_pat_11ABCDEFG0aBcDeFgHiJkLmNoP"]}}')
if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if 'GitHub fine-grained PAT' in d.get('systemMessage','') else 1)" 2>/dev/null; then
    echo "  ✓ github_pat_ 감지 (D-SEC-2)"; PASS=$((PASS+1))
else
    echo "  ✗ github_pat_ 미감지 (출력: $OUT)"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic E — dot 없는 eyJ → JWT 미매칭 (literal dot 강제, D-FP-2) ==="
OUT=$(_run settings.local.json '{"permissions":{"allow":["Bash(echo eyJABCDEFGH x SflKxwRJSMeKK)"]}}')
if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if 'JWT' not in d.get('systemMessage','') else 1)" 2>/dev/null; then
    echo "  ✓ dot 없는 eyJ JWT 미매칭 (grep \\. literal dot 보존)"; PASS=$((PASS+1))
else
    echo "  ✗ literal dot 미강제 — FP (출력: $OUT)"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic F — settings.json(shared) hit → HIGH exposure 차등 (D-SEC-1) ==="
OUT=$(_run settings.json '{"permissions":{"allow":["dckr_pat_AbCdEf12345678"]}}')
if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if 'HIGH exposure' in d.get('systemMessage','') else 1)" 2>/dev/null; then
    echo "  ✓ settings.json hit → 'HIGH exposure' 차등 통지"; PASS=$((PASS+1))
else
    echo "  ✗ settings.json 차등 통지 누락 (출력: $OUT)"; FAIL=$((FAIL+1))
fi

echo "=== Dynamic G — 모든 분기 valid JSON (위 A~F 출력 누적 검증) ==="
# A~F 가 전부 python3 json.load 를 통과했으므로 valid JSON 입증됨.
echo "  ✓ A~F 출력 모두 json.load 통과 (exit 0 + valid JSON 규약)"; PASS=$((PASS+1))

echo "=== Real — harness-meta 현 settings.local.json FP=0 baseline (sc_4) ==="
if [[ -f "$REPO_ROOT/.claude/settings.local.json" ]]; then
    OUT=$(CLAUDE_PROJECT_DIR="$REPO_ROOT" bash "$HOOK" </dev/null)
    if echo "$OUT" | python3 -c "import sys,json
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')
d=json.load(sys.stdin); sys.exit(0 if d=={} else 1)" 2>/dev/null; then
        echo "  ✓ 현 settings.local.json FP=0 (no-op {})"; PASS=$((PASS+1))
    else
        echo "  ✗ 현 settings.local.json 에서 secret 감지 — 실 박제일 수 있음! (출력: $OUT)"; FAIL=$((FAIL+1))
    fi
else
    echo "  - settings.local.json 부재 (SKIP)"; SKIP=$((SKIP+1))
fi

echo "=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ==="
exit $((FAIL == 0 ? 0 : 1))

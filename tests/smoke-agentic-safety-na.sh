#!/usr/bin/env bash
# smoke-agentic-safety-na.sh — v1.55 에이전틱 안전 N/A 분기 회귀 감지
#
# 정적 2 + 동적 3 = 5 checks
#  S1: categories_ops.py score_agentic_safety()에 na_repo 추출 + 3 N/A 분기 존재
#  S2: rubric.md §"적용 체크" 28건 + 에이전틱 안전 3행
#  D1: shell-only repo (no 3 files) → 3 N/A=perfect
#  D2: shell-only repo (all 3 files) → 3 PASS (no N/A)
#  D3: Python repo (no 3 files) → 3 FAIL (no N/A)

set -euo pipefail

ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
SCORER="$ROOT/bootstrap/skills/audit/ai-ready-scorer/scripts"
RUBRIC="$ROOT/bootstrap/skills/audit/ai-ready-scorer/references/rubric.md"

PASS=0
FAIL=0

ok() { echo "  ✓ $1"; PASS=$((PASS+1)); }
fail() { echo "  ✗ $1"; FAIL=$((FAIL+1)); }

echo "=== smoke-agentic-safety-na.sh (v1.55) ==="

# Stage 1 — 정적 검증
echo "[Stage 1] 정적 — categories_ops.py + rubric.md"

# S1: na_repo 추출 + 3 N/A 분기 존재
# awk: score_agentic_safety 함수 시작 line 직후부터 다음 def 라인까지 추출
SAFETY_BODY=$(awk '/^def score_agentic_safety/{f=1; next} f && /^def /{exit} f' "$SCORER/categories_ops.py")
if echo "$SAFETY_BODY" | grep -q 'na_repo = is_shell_markdown_only_repo' \
   && echo "$SAFETY_BODY" | grep -q 'if not env_example and na_repo:' \
   && echo "$SAFETY_BODY" | grep -q 'if not perm and na_repo:' \
   && echo "$SAFETY_BODY" | grep -q 'if not guard and na_repo:'; then
    ok "S1 categories_ops.py — na_repo 추출 + 3 sub-check N/A 분기 존재"
else
    fail "S1 — score_agentic_safety() 내 na_repo 또는 3 N/A 분기 부재"
fi

# S2: rubric.md 28건 + 에이전틱 안전 3행
if grep -q '### 적용 체크 (28건)' "$RUBRIC" \
   && grep -q '에이전틱 안전 | \.env\.example | Helper 1 | v1\.55' "$RUBRIC" \
   && grep -q '에이전틱 안전 | Claude Code 권한 설정 | Helper 1 | v1\.55' "$RUBRIC" \
   && grep -q '에이전틱 안전 | 가드레일 파일 | Helper 1 | v1\.55' "$RUBRIC"; then
    ok "S2 rubric.md — §적용 체크 28건 + 3 sub-check 등록"
else
    fail "S2 rubric.md — 28건 헤더 또는 3 sub-check 행 부재"
fi

# Stage 2 — 동적 검증 (mock repo)
echo "[Stage 2] 동적 — mock repo 시뮬레이션"

# CI 환경: git user.name/email 미설정 시 commit 실패 방지
export GIT_AUTHOR_NAME="CI-Test"
export GIT_AUTHOR_EMAIL="ci@test.local"
export GIT_COMMITTER_NAME="CI-Test"
export GIT_COMMITTER_EMAIL="ci@test.local"

TMPROOT=$(mktemp -d)
trap 'rm -rf "$TMPROOT"' EXIT

mock_score() {
    local repo="$1"
    SCORER_PATH="$SCORER" REPO_PATH="$repo" python3 <<'PYEOF'
import os, sys, subprocess
from pathlib import Path
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
sys.path.insert(0, os.environ['SCORER_PATH'])
from categories_ops import score_agentic_safety
from utils import detect_language
repo = Path(os.environ['REPO_PATH']).resolve()
out = subprocess.check_output(['git', 'ls-files'], cwd=repo, text=True)
tracked = [repo / f for f in out.strip().split('\n') if f]
lang = detect_language(repo, tracked)
checks = score_agentic_safety(repo, tracked, lang)
# ASCII slug 매핑 — Windows cp949 콘솔 호환
SLUG = {
    '.env.example': 'env_example',
    'Claude Code 권한 설정': 'claude_perm',
    '가드레일 파일': 'guardrails',
}
for c in checks:
    if c.name in SLUG:
        flag = 'NA' if c.na else ('PASS' if c.passed else 'FAIL')
        print(f'{SLUG[c.name]}|{flag}|{c.score}/{c.max_score}')
PYEOF
}

# D1: shell-only without 3 files → 3 N/A
D1="$TMPROOT/d1"
mkdir -p "$D1" && cd "$D1" && git init -q
echo "# Test" > README.md && echo "echo hi" > script.sh
git add -A && git commit -q -m init
out=$(mock_score "$D1")
if echo "$out" | grep -q '^env_example|NA|2/2$' \
   && echo "$out" | grep -q '^claude_perm|NA|2/2$' \
   && echo "$out" | grep -q '^guardrails|NA|1/1$'; then
    ok "D1 shell-only (no 3 files) — 3 N/A=perfect"
else
    fail "D1 — 기대: 3 N/A. 실제: $(echo "$out" | tr '\n' ' ')"
fi

# D2: shell-only with all 3 files → 3 PASS
D2="$TMPROOT/d2"
mkdir -p "$D2/.claude" "$D2/docs" && cd "$D2" && git init -q
echo "# Test" > README.md && echo "echo hi" > script.sh
touch .env.example && echo '{}' > .claude/settings.json && echo "# Guardrails" > docs/GUARDRAILS.md
git add -A && git commit -q -m init
out=$(mock_score "$D2")
if echo "$out" | grep -q '^env_example|PASS|2/2$' \
   && echo "$out" | grep -q '^claude_perm|PASS|2/2$' \
   && echo "$out" | grep -q '^guardrails|PASS|1/1$'; then
    ok "D2 shell-only (all 3 files) — 3 PASS (N/A 미진입)"
else
    fail "D2 — 기대: 3 PASS. 실제: $(echo "$out" | tr '\n' ' ')"
fi

# D3: Python repo (na_repo=False) without 3 files → 3 FAIL
D3="$TMPROOT/d3"
mkdir -p "$D3" && cd "$D3" && git init -q
echo "# Test" > README.md
for i in 1 2 3 4 5 6 7 8 9 10; do echo "x = $i" > "f$i.py"; done
printf '[project]\ndependencies=["requests"]\n' > pyproject.toml
git add -A && git commit -q -m init
out=$(mock_score "$D3")
if echo "$out" | grep -q '^env_example|FAIL|0/2$' \
   && echo "$out" | grep -q '^claude_perm|FAIL|0/2$' \
   && echo "$out" | grep -q '^guardrails|FAIL|0/1$'; then
    ok "D3 Python (na_repo=False, no 3 files) — 3 FAIL (N/A 미진입)"
else
    fail "D3 — 기대: 3 FAIL. 실제: $(echo "$out" | tr '\n' ' ')"
fi

echo ""
echo "=== 결과: $PASS PASS / $FAIL FAIL ==="

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0

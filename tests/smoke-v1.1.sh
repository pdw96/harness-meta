#!/usr/bin/env bash
# v1.1 manifest fixture smoke — v1.6 bash hook/statusline이 v1.1 신규 필드 파싱 정상 + 회귀 없음
set -e
FIXTURE="$HOME/harness-meta/tests/fixtures/schema-v1.1-full"
HOOK="$HOME/harness-meta/claude/hooks/session-init.sh"
STATUSLINE="$HOME/harness-meta/claude/statusline/statusline.sh"

echo "== hook (v1.1 fixture) =="
CLAUDE_PROJECT_DIR="$FIXTURE" bash "$HOOK"
echo
echo
echo "== statusline (v1.1 fixture) =="
CLAUDE_PROJECT_DIR="$FIXTURE" bash "$STATUSLINE"
echo
echo
echo "PASS: bash hook/statusline parses schema v1.1 fixture"

#!/usr/bin/env bash
# Harness 글로벌 statusline — 현재 milestone / phase / step 표시
#
# 동작 원칙:
#   1. $CLAUDE_PROJECT_DIR/.harness.toml 없으면 조용히 종료 (no-op)
#   2. .harness.toml 있으면 [harness].code_dir에서 statusline_stats.py 경로 추론
#   3. statusline_stats.py + phases/index.json + milestone.json 존재 시 기존 포맷 출력
#   4. 없으면 프로젝트 이름만 또는 최소 정보
#
# 호출: ~/.claude/settings.json의 statusLine.command = "$HOME/.claude/statusline/statusline.sh"
# 주기: Claude Code가 시작 시 + 주기적으로 실행

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MANIFEST="$PROJECT_DIR/.harness.toml"

# 1. 매니페스트 없으면 no-op (하네스 비활성 프로젝트)
if [ ! -f "$MANIFEST" ]; then
    exit 0
fi

# 2. 매니페스트 파싱 (grep + sed, 평탄 TOML 가정)
code_dir=$(grep -E '^code_dir\s*=\s*"' "$MANIFEST" 2>/dev/null | head -1 | sed -E 's/^code_dir\s*=\s*"([^"]+)"/\1/')
phases_dir=$(grep -E '^phases_dir\s*=\s*"' "$MANIFEST" 2>/dev/null | head -1 | sed -E 's/^phases_dir\s*=\s*"([^"]+)"/\1/')

# 기본값
code_dir="${code_dir:-scripts/harness}"
phases_dir="${phases_dir:-phases}"

PHASES_INDEX="$PROJECT_DIR/$phases_dir/index.json"
STATS_MOD="$PROJECT_DIR/$code_dir/statusline_stats.py"

# 3-a. phases/index.json 없으면 미초기화 안내만
if [ ! -f "$PHASES_INDEX" ]; then
    printf '[harness] phases 미초기화'
    exit 0
fi

# 3-b. statusline_stats.py 없으면 minimal
if [ ! -f "$STATS_MOD" ]; then
    printf '[harness] stats 모듈 없음'
    exit 0
fi

# 4. 기존 로직 (프로젝트 statusline_stats.py 위임)
version=$(python3 "$STATS_MOD" current-version "$PHASES_INDEX" 2>/dev/null)

if [ -z "$version" ]; then
    printf '[harness] all milestones OK'
    exit 0
fi

MS="$PROJECT_DIR/$phases_dir/$version/milestone.json"
if [ ! -f "$MS" ]; then
    printf '[harness] %s: milestone.json 미존재' "$version"
    exit 0
fi

phase=$(python3 "$STATS_MOD" current-phase "$MS" 2>/dev/null)

if [ -z "$phase" ]; then
    printf '[harness] %s OK' "$version"
    exit 0
fi

PIDX="$PROJECT_DIR/$phases_dir/$version/$phase/index.json"
if [ ! -f "$PIDX" ]; then
    printf '[harness] %s/%s 미시작' "$version" "$phase"
    exit 0
fi

stats=$(python3 "$STATS_MOD" phase-stats "$PIDX" 2>/dev/null)
cost=$(python3 "$STATS_MOD" milestone-cost "$PHASES_INDEX" "$version" 2>/dev/null)
cache_info=$(python3 "$STATS_MOD" cache-hit "$MS" 2>/dev/null)

printf '[harness] %s/%s · %s%s%s' "$version" "$phase" "$stats" "$cost" "$cache_info"

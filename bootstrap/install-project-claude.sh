#!/usr/bin/env bash
# 프로젝트 루트에 harness-meta의 _base/.claude/ 템플릿을 복사한다 (Claude Code local).
#
# v1.8+ 구조: 하네스 실행 명령(commands/agents/skills/output-styles)은 프로젝트
# local `.claude/`로 배포. symlink 아닌 Copy.
#
# Usage:
#   bash install-project-claude.sh [<project-root>] [-f|--force]
#
# Env:
#   HARNESS_META_ROOT — harness-meta repo 위치 (기본 $HOME/harness-meta)

set -e

PROJECT_ROOT=""
FORCE=0
for arg in "$@"; do
    case "$arg" in
        -f|--force) FORCE=1 ;;
        -h|--help)
            grep -E '^# ' "$0" | sed 's/^# \?//'
            exit 0
            ;;
        *) PROJECT_ROOT="$arg" ;;
    esac
done

PROJECT_ROOT="${PROJECT_ROOT:-$PWD}"
PROJECT_ROOT="$(cd "$PROJECT_ROOT" && pwd)"
META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
BASE="$META_ROOT/bootstrap/templates/_base/.claude"
DEST="$PROJECT_ROOT/.claude"
MANIFEST="$PROJECT_ROOT/.harness.toml"

info() { printf '[INFO] %s\n' "$1"; }
ok()   { printf '[OK]   %s\n' "$1"; }
warn() { printf '[WARN] %s\n' "$1" >&2; }
err()  { printf '[ERR]  %s\n' "$1" >&2; }

# 1. 검증
if [ ! -f "$MANIFEST" ]; then
    err ".harness.toml 미발견: $MANIFEST"
    err "하네스 비활성 프로젝트에는 설치하지 않는다. bootstrap 먼저 수행."
    exit 1
fi
if [ ! -d "$BASE" ]; then
    err "base template 미발견: $BASE"
    err "HARNESS_META_ROOT env 또는 argument 확인."
    exit 1
fi

info "ProjectRoot: $PROJECT_ROOT"
info "MetaRoot:    $META_ROOT"

mkdir -p "$DEST"

# 2. 카테고리별 충돌 스캔 + 복사
categories=("commands" "agents" "skills" "output-styles")
conflicts=()
for cat in "${categories[@]}"; do
    src="$BASE/$cat"
    dst="$DEST/$cat"
    [ ! -d "$src" ] && continue
    for item in "$src"/*; do
        [ -e "$item" ] || continue
        name="$(basename "$item")"
        if [ -e "$dst/$name" ]; then
            conflicts+=("$cat/$name")
        fi
    done
done

# 2.5. Legacy cleanup (--force 전용, v1.9b+)
# _base 템플릿 카테고리 변경(예: v1.8b에서 commands 삭제) 시 dest에 잔존한
# harness-* 파일을 backup 이동. 사용자 custom 파일(harness prefix 아님)은 건드리지 않음.
backup_root=""
legacy_moved=()
if [ "$FORCE" -eq 1 ]; then
    for cat in "${categories[@]}"; do
        src="$BASE/$cat"
        dst="$DEST/$cat"
        [ ! -d "$dst" ] && continue
        for d in "$dst"/harness*; do
            [ -e "$d" ] || continue
            name="$(basename "$d")"
            if [ ! -e "$src/$name" ]; then
                if [ -z "$backup_root" ]; then
                    ts="$(date +%Y%m%d-%H%M%S)"
                    backup_root="$DEST/backup-$ts"
                    mkdir -p "$backup_root"
                fi
                mkdir -p "$backup_root/$cat"
                mv "$d" "$backup_root/$cat/$name"
                legacy_moved+=("$cat/$name")
            fi
        done
    done
    if [ ${#legacy_moved[@]} -gt 0 ]; then
        warn "legacy cleanup — ${#legacy_moved[@]}건 backup: $backup_root"
        for lm in "${legacy_moved[@]}"; do
            warn "  - $lm"
        done
    fi
fi

# 3. 충돌 처리
if [ ${#conflicts[@]} -gt 0 ]; then
    if [ "$FORCE" -eq 0 ]; then
        err "충돌 발견 (${#conflicts[@]}건). 기존 유지 → 수동 제거, 덮어쓰기 → -f/--force"
        for c in "${conflicts[@]}"; do err "  - $DEST/$c"; done
        exit 1
    fi
    ts="$(date +%Y%m%d-%H%M%S)"
    backup_root="$DEST/backup-$ts"
    mkdir -p "$backup_root"
    for c in "${conflicts[@]}"; do
        cat_name="${c%%/*}"
        file_name="${c##*/}"
        mkdir -p "$backup_root/$cat_name"
        mv "$DEST/$c" "$backup_root/$cat_name/$file_name"
    done
    warn "충돌 ${#conflicts[@]}건 backup: $backup_root"
fi

# 4. 재귀 복사
total=0
for cat in "${categories[@]}"; do
    src="$BASE/$cat"
    [ ! -d "$src" ] && continue
    mkdir -p "$DEST/$cat"
    for item in "$src"/*; do
        [ -e "$item" ] || continue
        cp -r "$item" "$DEST/$cat/"
        total=$((total + 1))
        name="$(basename "$item")"
        ok "copied: $cat/$name"
    done
done

echo
ok "완료 — $total 항목 복사 ($DEST)"
echo
info "다음 단계:"
info "  1. Claude Code 세션 재시작 (또는 새 세션으로 $PROJECT_ROOT 진입)"
info "  2. /config 실행 → Output style → 'Harness Engineer' 선택"
info "     (output-styles/harness-engineer.md 활성화)"
info "  3. /harness 입력 → 슬래시 명령 인식 확인"
info "  4. 프로젝트 repo에 .claude/ 커밋 (team share)"

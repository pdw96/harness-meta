#!/usr/bin/env bash
# v1.19+: harness-meta 글로벌 user-skill 배포 스크립트 (opt-in, symlink 기반).
#
# 동작:
#   bootstrap/skills/<name>/ → ~/.claude/skills/<name>/ symlink 생성.
#   기존 ~/.claude/skills/<name>/ 존재 시 ~/.claude/backups/skills/<name>.<ts>/로 backup.
#   (~/.claude/skills/ 내부에 backup 두면 Claude Code가 SKILL.md 자동 인식 → 충돌)
#
# 전제:
#   - $HOME/harness-meta/ clone 또는 $HARNESS_META_ROOT 설정
#   - macOS / Linux: 기본 작동
#   - Windows: Git Bash의 ln -s가 기본적으로 디렉토리 복사로 fallback 하므로
#             자동으로 install-skills.ps1로 위임 (pwsh 필요)
#
# Usage:
#   bash install-skills.sh [skill-name]    # 기본: ai-ready-scorer
#   bash install-skills.sh --all           # bootstrap/skills/ 모두 install
#   bash install-skills.sh --list          # 사용 가능 skill 목록
#   bash install-skills.sh --dry-run [name|--all]   # 계획만 출력

set -euo pipefail

META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
SKILLS_SRC="$META_ROOT/bootstrap/skills"
SKILLS_DEST="$HOME/.claude/skills"
BACKUP_ROOT="$HOME/.claude/backups/skills"

color_info()  { printf '\033[36m[INFO]\033[0m %s\n' "$1"; }
color_ok()    { printf '\033[32m[OK]\033[0m   %s\n' "$1"; }
color_warn()  { printf '\033[33m[WARN]\033[0m %s\n' "$1"; }
color_err()   { printf '\033[31m[ERR]\033[0m  %s\n' "$1" >&2; }

# ── Windows 감지 시 .ps1로 위임 ────────────────────────────────────────
# Git Bash의 ln -s는 MSYS 기본 모드에서 디렉토리 복사로 동작 (NTFS symlink 아님).
# Windows에서는 install-skills.ps1이 New-Item -ItemType SymbolicLink로 정상 처리.
case "$(uname -s 2>/dev/null || echo unknown)" in
    MINGW*|MSYS*|CYGWIN*)
        if command -v pwsh >/dev/null 2>&1; then
            color_info "Windows detected — delegating to install-skills.ps1 (pwsh)"
            exec pwsh "$META_ROOT/install-skills.ps1" "$@"
        else
            color_err "Windows detected but pwsh not found in PATH."
            color_err "Install PowerShell 7+ (https://aka.ms/PowerShell) or run install-skills.ps1 directly."
            exit 3
        fi
        ;;
esac

usage() {
    sed -n '2,21p' "$0" | sed 's/^# //' | sed 's/^#$//'
    exit 0
}

list_skills() {
    if [ ! -d "$SKILLS_SRC" ]; then
        color_warn "no bootstrap/skills/ — nothing to install"
        exit 0
    fi
    color_info "Available skills in $SKILLS_SRC:"
    for d in "$SKILLS_SRC"/*/; do
        [ -d "$d" ] || continue
        name=$(basename "$d")
        printf '  - %s\n' "$name"
    done
    exit 0
}

# ── 인자 파싱 ──────────────────────────────────────────────────────────
DRY_RUN=0
ALL=0
SKILL_NAME=""

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)   usage ;;
        --list)      list_skills ;;
        --dry-run)   DRY_RUN=1; shift ;;
        --all)       ALL=1; shift ;;
        --*)         color_err "unknown flag: $1"; exit 2 ;;
        *)           SKILL_NAME="$1"; shift ;;
    esac
done

if [ ! -d "$SKILLS_SRC" ]; then
    color_err "bootstrap/skills/ not found: $SKILLS_SRC"
    exit 2
fi

mkdir -p "$SKILLS_DEST"
mkdir -p "$BACKUP_ROOT"

# ── install 함수 ───────────────────────────────────────────────────────
install_one() {
    local name="$1"
    local src="$SKILLS_SRC/$name"
    local dest="$SKILLS_DEST/$name"
    local ts
    ts=$(date +%Y%m%d-%H%M%S)

    if [ ! -d "$src" ]; then
        color_err "skill not found: $src"
        return 1
    fi

    # 이미 정상 symlink (target == src) → no-op
    if [ -L "$dest" ]; then
        local current_target
        current_target=$(readlink "$dest")
        if [ "$current_target" = "$src" ]; then
            color_info "$name: already symlinked (no-op)"
            return 0
        fi
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            color_info "[dry-run] $name: backup $dest → $BACKUP_ROOT/$name.$ts, then symlink $src → $dest"
        else
            color_info "[dry-run] $name: symlink $src → $dest"
        fi
        return 0
    fi

    # backup 분기 (외부 위치)
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local bak="$BACKUP_ROOT/$name.$ts"
        mv "$dest" "$bak"
        color_warn "$name: backed up to $bak"
    fi

    ln -s "$src" "$dest"

    # symlink 정상 검증
    if [ ! -L "$dest" ]; then
        color_err "$name: symlink creation failed (not a symlink — possibly Windows fallback)"
        # rollback: backup 복원 시도
        if [ -n "${bak:-}" ] && [ -d "$bak" ]; then
            mv "$bak" "$dest"
            color_warn "$name: rolled back from $bak"
        fi
        return 1
    fi

    color_ok "$name: symlinked $src → $dest"
}

# ── 실행 ───────────────────────────────────────────────────────────────
if [ "$ALL" -eq 1 ]; then
    found=0
    for d in "$SKILLS_SRC"/*/; do
        [ -d "$d" ] || continue
        name=$(basename "$d")
        install_one "$name"
        found=1
    done
    if [ "$found" -eq 0 ]; then
        color_warn "no skills found in $SKILLS_SRC"
    fi
else
    name="${SKILL_NAME:-ai-ready-scorer}"
    install_one "$name"
fi

color_ok "install-skills 완료"

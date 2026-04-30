#!/usr/bin/env bash
# v1.22+: harness-meta 글로벌 user-skill 배포 스크립트 (opt-in, symlink 또는 copy 기반).
#
# 동작:
#   bootstrap/skills/<name>/ → ~/.claude/skills/<name>/ symlink 생성.
#   symlink 생성 실패 시(Windows 또는 권한 부재) copy mode로 자동 fallback.
#   기존 ~/.claude/skills/<name>/ 존재 시 ~/.claude/backups/skills/<name>.<ts>/로 backup.
#   설치 모드는 ~/.claude/skills/.harness-install-mode 에 기록됨.
#   (~/.claude/skills/ 내부에 backup 두면 Claude Code가 SKILL.md 자동 인식 → 충돌)
#
# 전제:
#   - $HOME/harness-meta/ clone 또는 $HARNESS_META_ROOT 설정
#   - macOS / Linux: 기본 symlink 작동 (--copy-mode로 명시 copy 가능)
#   - Windows: Git Bash의 ln -s가 기본적으로 디렉토리 복사로 fallback 하므로
#             자동으로 install-skills.ps1로 위임 (pwsh 필요)
#
# Usage:
#   bash install-skills.sh [skill-name]                          # 기본: ai-ready-scorer
#   bash install-skills.sh --all                                 # bootstrap/skills/ 모두 install
#   bash install-skills.sh --list                                # 사용 가능 skill 목록
#   bash install-skills.sh --dry-run [name|--all]                # 계획만 출력
#   bash install-skills.sh --copy-mode                           # symlink 대신 copy로 설치
#   bash install-skills.sh --cleanup [name]                      # backup 정리 (v1.30+)
#   bash install-skills.sh --cleanup-after [name|--all]          # install 후 backup 정리
#   bash install-skills.sh --retain N --grace-days D --yes       # 정리 정책 + 실 삭제 확인
#
# v1.30+ Cleanup 정책:
#   --cleanup       — backup 정리 후 종료 (skill install 안 함)
#   --cleanup-after — install 후 cleanup 1회 수행
#   --retain N      — skill별 최근 N개 유지 (default 3)
#   --grace-days D  — D일 미만 mtime backup 보존 (default 7)
#   --yes           — 실 삭제 확인 (없으면 dry-run-equivalent + WARN)
#
# env override:
#   HARNESS_SKILLS_BACKUP_ROOT — backup root 위치 (default ~/.claude/backups/skills, 테스트/고급용)

set -euo pipefail

META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
SKILLS_SRC="$META_ROOT/bootstrap/skills"
SKILLS_DEST="$HOME/.claude/skills"
BACKUP_ROOT="${HARNESS_SKILLS_BACKUP_ROOT:-$HOME/.claude/backups/skills}"
# 설치 모드 파일 (dotfile — Claude Code 스캔 대상 아님)
MODE_FILE="$SKILLS_DEST/.harness-install-mode"

color_info()  { printf '\033[36m[INFO]\033[0m %s\n' "$1"; }
color_ok()    { printf '\033[32m[OK]\033[0m   %s\n' "$1"; }
color_warn()  { printf '\033[33m[WARN]\033[0m %s\n' "$1"; }
color_err()   { printf '\033[31m[ERR]\033[0m  %s\n' "$1" >&2; }

# ── Windows 감지 시 .ps1로 위임 (플래그 변환 맵 포함) ────────────────────
# Git Bash의 ln -s는 MSYS 기본 모드에서 디렉토리 복사로 동작 (NTFS symlink 아님).
# Windows에서는 install-skills.ps1이 New-Item -ItemType SymbolicLink로 정상 처리.
case "$(uname -s 2>/dev/null || echo unknown)" in
    MINGW*|MSYS*|CYGWIN*)
        if command -v pwsh >/dev/null 2>&1; then
            color_info "Windows detected — delegating to install-skills.ps1 (pwsh)"
            # bash 플래그를 PowerShell 파라미터로 변환 (D6 버그 해소)
            _ps_args=()
            _expect_value=0
            for arg in "$@"; do
                if [ "$_expect_value" -eq 1 ]; then
                    _ps_args+=("$arg")
                    _expect_value=0
                    continue
                fi
                case "$arg" in
                    --all)            _ps_args+=("-All") ;;
                    --dry-run)        _ps_args+=("-DryRun") ;;
                    --list)           _ps_args+=("-List") ;;
                    --copy-mode)      _ps_args+=("-CopyMode") ;;
                    --cleanup)        _ps_args+=("-Cleanup") ;;
                    --cleanup-after)  _ps_args+=("-CleanupAfter") ;;
                    --yes)            _ps_args+=("-Yes") ;;
                    --retain)         _ps_args+=("-Retain"); _expect_value=1 ;;
                    --grace-days)     _ps_args+=("-GraceDays"); _expect_value=1 ;;
                    -h|--help)        _ps_args+=("-?") ;;
                    *)                _ps_args+=("$arg") ;;
                esac
            done
            exec pwsh "$META_ROOT/install-skills.ps1" "${_ps_args[@]}"
        else
            color_err "Windows detected but pwsh not found in PATH."
            color_err "Install PowerShell 7+ (https://aka.ms/PowerShell) or run install-skills.ps1 directly."
            exit 3
        fi
        ;;
esac

usage() {
    sed -n '2,22p' "$0" | sed 's/^# //' | sed 's/^#$//'
    exit 0
}

list_skills() {
    if [ ! -d "$SKILLS_SRC" ]; then
        color_warn "no bootstrap/skills/ — nothing to install"
        exit 0
    fi
    color_info "Available skills in $SKILLS_SRC (v1.36+ 2-tier <category>/<name>):"
    # v1.36: 2단계 카테고리 enumerate (audit/, dev-tools/ 등)
    for cat_dir in "$SKILLS_SRC"/*/; do
        [ -d "$cat_dir" ] || continue
        cat_name=$(basename "$cat_dir")
        # 카테고리 디렉토리는 SKILL.md 없음 (skill은 더 안쪽 1단계)
        [ -f "$cat_dir/SKILL.md" ] && continue
        for d in "$cat_dir"*/; do
            [ -d "$d" ] || continue
            [ -f "$d/SKILL.md" ] || continue
            name=$(basename "$d")
            printf '  - %s/%s\n' "$cat_name" "$name"
        done
    done
    exit 0
}

# v1.36: 2단계 lookup — legacy `<name>` 입력 시 `bootstrap/skills/*/<name>/`로 자동 prefix
# 0/1/2+ 매치 분기:
#   0 → exit 1 + WARN
#   1 → echo "<category>/<name>" stdout (caller가 사용)
#   2+ → exit 2 + WARN (typosquatting 방어; AskUserQuestion은 Claude가 호출)
# 보안: regex validation + bootstrap/skills/ prefix 강제
resolve_skill_name() {
    local input="$1"
    # 보안 R5/R7 — regex validation (alphanumeric + - + _ only, 첫 char alphanumeric)
    if ! [[ "$input" =~ ^[a-z0-9][a-z0-9_-]*(/[a-z0-9][a-z0-9_-]*)?$ ]]; then
        color_err "invalid skill name (regex ^[a-z0-9][a-z0-9_-]*(/...)?$): $input"
        return 2
    fi

    # 이미 <category>/<name> 형식이면 정확 path 검증
    if [[ "$input" == */* ]]; then
        local target="$SKILLS_SRC/$input"
        if [ -d "$target" ] && [ -f "$target/SKILL.md" ]; then
            printf '%s\n' "$input"
            return 0
        fi
        color_err "skill not found: $target"
        return 1
    fi

    # legacy `<name>` — 모든 카테고리 검색
    local matches=()
    local cat_dir
    for cat_dir in "$SKILLS_SRC"/*/; do
        [ -d "$cat_dir" ] || continue
        local cat_name
        cat_name=$(basename "$cat_dir")
        if [ -d "$cat_dir$input" ] && [ -f "$cat_dir$input/SKILL.md" ]; then
            matches+=("$cat_name/$input")
        fi
    done

    case "${#matches[@]}" in
        0)
            color_err "skill '$input' not found in any category under $SKILLS_SRC"
            return 1
            ;;
        1)
            printf '%s\n' "${matches[0]}"
            return 0
            ;;
        *)
            color_err "skill '$input' matches multiple categories — specify <category>/<name>:"
            local m
            for m in "${matches[@]}"; do
                color_err "  - $m"
            done
            return 2
            ;;
    esac
}

# ── 인자 파싱 ──────────────────────────────────────────────────────────
DRY_RUN=0
ALL=0
COPY_MODE=0
CLEANUP=0
CLEANUP_AFTER=0
YES=0
RETAIN=3
GRACE_DAYS=7
SKILL_NAME=""

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)        usage ;;
        --list)           list_skills ;;
        --dry-run)        DRY_RUN=1; shift ;;
        --all)            ALL=1; shift ;;
        --copy-mode)      COPY_MODE=1; shift ;;
        --cleanup)        CLEANUP=1; shift ;;
        --cleanup-after)  CLEANUP_AFTER=1; shift ;;
        --yes)            YES=1; shift ;;
        --retain)
            [ $# -ge 2 ] || { color_err "--retain requires N"; exit 2; }
            [[ "$2" =~ ^[0-9]+$ ]] || { color_err "--retain N must be non-negative integer: $2"; exit 2; }
            RETAIN="$2"; shift 2 ;;
        --grace-days)
            [ $# -ge 2 ] || { color_err "--grace-days requires D"; exit 2; }
            [[ "$2" =~ ^[0-9]+$ ]] || { color_err "--grace-days D must be non-negative integer: $2"; exit 2; }
            GRACE_DAYS="$2"; shift 2 ;;
        --*)              color_err "unknown flag: $1"; exit 2 ;;
        *)                SKILL_NAME="$1"; shift ;;
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
    local input="$1"
    # v1.36: 2단계 resolve — input은 `<name>` 또는 `<category>/<name>`
    local resolved
    if ! resolved=$(resolve_skill_name "$input"); then
        return 1
    fi
    # resolved = "<category>/<name>" 형식
    local name="${resolved##*/}"   # symlink target은 1단계 평탄 (Claude Code SKILL 인식 호환)
    local src="$SKILLS_SRC/$resolved"
    local dest="$SKILLS_DEST/$name"
    local ts
    ts=$(date +%Y%m%d-%H%M%S)

    if [ ! -d "$src" ]; then
        color_err "skill not found: $src"
        return 1
    fi

    # 이미 정상 symlink (target == src) → no-op (symlink mode만)
    if [ "$COPY_MODE" -eq 0 ] && [ -L "$dest" ]; then
        local current_target
        current_target=$(readlink "$dest")
        if [ "$current_target" = "$src" ]; then
            color_info "$name: already symlinked (no-op)"
            return 0
        fi
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        local action
        action=$([ "$COPY_MODE" -eq 1 ] && echo "copy" || echo "symlink (fallback: copy)")
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            color_info "[dry-run] $name: backup $dest → $BACKUP_ROOT/$name.$ts, then $action $src → $dest"
        else
            color_info "[dry-run] $name: $action $src → $dest"
        fi
        return 0
    fi

    # backup 분기 (외부 위치)
    local bak=""
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        bak="$BACKUP_ROOT/$name.$ts"
        mv "$dest" "$bak"
        color_warn "$name: backed up to $bak"
    fi

    if [ "$COPY_MODE" -eq 1 ]; then
        # 명시적 copy mode
        cp -r "$src" "$dest"
        printf 'copy' > "$MODE_FILE"
        color_ok "$name: copied (copy mode) $src → $dest"
        return 0
    fi

    # symlink 시도
    ln -s "$src" "$dest"

    # symlink 정상 검증
    if [ ! -L "$dest" ]; then
        color_warn "$name: symlink creation failed — falling back to copy mode"
        # symlink 실패 시 잔여물 제거 후 copy
        rm -rf "$dest" 2>/dev/null || true
        if cp -r "$src" "$dest"; then
            printf 'copy' > "$MODE_FILE"
            color_ok "$name: copied (copy mode fallback) $src → $dest"
        else
            color_err "$name: copy also failed"
            # rollback: backup 복원 시도
            if [ -n "$bak" ] && [ -d "$bak" ]; then
                mv "$bak" "$dest"
                color_warn "$name: rolled back from $bak"
            fi
            return 1
        fi
        return 0
    fi

    printf 'symlink' > "$MODE_FILE"
    color_ok "$name: symlinked $src → $dest"
}

# ── cleanup 함수 (v1.30+) ─────────────────────────────────────────────
# distinct skill prefix 추출 (BACKUP_ROOT 안의 <name>.<YYYYMMDD-HHMMSS> dir에서)
distinct_skills() {
    [ -d "$BACKUP_ROOT" ] || return 0
    local d name
    for d in "$BACKUP_ROOT"/*/; do
        [ -d "$d" ] || continue
        name=$(basename "$d")
        # R4-2 strict 매치 — ad-hoc dir skip
        [[ "$name" =~ ^.+\.[0-9]{8}-[0-9]{6}$ ]] || continue
        printf '%s\n' "${name%.*}"
    done | sort -u
}

# skill별 cleanup — count + grace 결합
cleanup_one() {
    local skill="$1"
    [ -d "$BACKUP_ROOT" ] || { color_info "$skill: no backups (BACKUP_ROOT 부재)"; return 0; }

    # 해당 skill의 backup dir 수집 (ts desc 정렬 — name 마지막 .<ts> = lexical desc)
    local backups=()
    local d name
    while IFS= read -r d; do
        backups+=("$d")
    done < <(
        for d in "$BACKUP_ROOT"/*/; do
            [ -d "$d" ] || continue
            name=$(basename "$d")
            [[ "$name" =~ ^.+\.[0-9]{8}-[0-9]{6}$ ]] || continue
            [ "${name%.*}" = "$skill" ] || continue
            printf '%s\n' "$d"
        done | sort -r
    )

    if [ "${#backups[@]}" -eq 0 ]; then
        color_info "$skill: no backups"
        return 0
    fi

    # purge-all guard (R4 / D6)
    if [ "$RETAIN" -eq 0 ] && [ "$GRACE_DAYS" -eq 0 ] && [ "$YES" -eq 0 ] && [ "$DRY_RUN" -eq 0 ]; then
        color_err "$skill: destructive purge (--retain 0 --grace-days 0) requires --yes"
        return 1
    fi

    # 분류
    local to_delete=()
    local i=0
    local b
    for b in "${backups[@]}"; do
        if [ "$i" -lt "$RETAIN" ]; then
            i=$((i+1))
            continue
        fi
        # grace 검사 — find -mtime +D = mtime > D일 (POSIX standard, GNU/BSD 동등)
        if find "$b" -maxdepth 0 -mtime +"$GRACE_DAYS" 2>/dev/null | grep -q .; then
            to_delete+=("$b")
        fi
        i=$((i+1))
    done

    color_info "$skill: ${#backups[@]} backup(s), retain=$RETAIN grace=${GRACE_DAYS}d → delete ${#to_delete[@]}"

    if [ "${#to_delete[@]}" -eq 0 ]; then
        return 0
    fi

    if [ "$DRY_RUN" -eq 1 ] || [ "$YES" -eq 0 ]; then
        local note
        note=$([ "$DRY_RUN" -eq 1 ] && echo "[dry-run]" || echo "[plan — use --yes to confirm]")
        for b in "${to_delete[@]}"; do
            color_info "$note would delete: $b"
        done
        [ "$YES" -eq 0 ] && [ "$DRY_RUN" -eq 0 ] && color_warn "$skill: --yes not specified, no changes made"
        return 0
    fi

    # 실 삭제
    local deleted=0
    for b in "${to_delete[@]}"; do
        # R4-1 path traversal 방어 — BACKUP_ROOT prefix 강제
        case "$b" in
            "$BACKUP_ROOT"/*) ;;
            *) color_err "skip (path traversal guard): $b"; continue ;;
        esac
        rm -rf "$b" && deleted=$((deleted+1)) && color_ok "deleted: $b"
    done
    color_ok "$skill: cleanup complete ($deleted deleted)"
}

cleanup_all() {
    local skills
    skills=$(distinct_skills)
    if [ -z "$skills" ]; then
        color_info "no backups to cleanup"
        return 0
    fi
    if [ -n "$SKILL_NAME" ]; then
        cleanup_one "$SKILL_NAME"
    else
        local s
        while IFS= read -r s; do
            [ -n "$s" ] && cleanup_one "$s"
        done <<< "$skills"
    fi
}

# ── 실행 ───────────────────────────────────────────────────────────────

# --cleanup 단독: install 안 함, cleanup 후 종료
if [ "$CLEANUP" -eq 1 ]; then
    cleanup_all
    color_ok "install-skills cleanup 완료"
    exit 0
fi

if [ "$ALL" -eq 1 ]; then
    # v1.36: 2단계 enumerate — bootstrap/skills/<category>/<name>/SKILL.md
    found=0
    for cat_dir in "$SKILLS_SRC"/*/; do
        [ -d "$cat_dir" ] || continue
        cat_name=$(basename "$cat_dir")
        # 카테고리 디렉토리 자체는 SKILL.md 없음
        [ -f "$cat_dir/SKILL.md" ] && continue
        for d in "$cat_dir"*/; do
            [ -d "$d" ] || continue
            [ -f "$d/SKILL.md" ] || continue
            name=$(basename "$d")
            install_one "$cat_name/$name"
            found=1
        done
    done
    if [ "$found" -eq 0 ]; then
        color_warn "no skills found in $SKILLS_SRC"
    fi
else
    name="${SKILL_NAME:-ai-ready-scorer}"
    install_one "$name"
fi

# --cleanup-after: install 후 cleanup 1회
if [ "$CLEANUP_AFTER" -eq 1 ]; then
    color_info "running cleanup after install (--cleanup-after)"
    cleanup_all
fi

color_ok "install-skills 완료"

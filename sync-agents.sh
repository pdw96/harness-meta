#!/usr/bin/env bash
# sync-agents.sh — per-project AGENTS.md drift 감지 + 동기화 (v1.22+)
#
# 프로젝트 루트에서 실행. AGENTS.md를 canonical source로 하여
# CLAUDE.md 등 7개 대상 파일의 drift를 감지/해소한다.
# symlink/junction 파일은 자동 skip (drift 없음으로 처리).
#
# 전제:
#   - 프로젝트 루트에 AGENTS.md 존재
#   - macOS / Linux: 기본 작동
#   - Windows Git Bash: pwsh 있으면 sync-agents.ps1로 위임
#
# Usage:
#   bash ~/harness-meta/sync-agents.sh               # drift 감지 + warn-and-prompt
#   bash ~/harness-meta/sync-agents.sh --source-wins  # AGENTS.md → 대상 덮어쓰기
#   bash ~/harness-meta/sync-agents.sh --check        # 감지만, 파일 변경 없음 (exit 1 if drift)
#   bash ~/harness-meta/sync-agents.sh --dry-run      # 계획 출력 (파일 변경 없음)
#   bash ~/harness-meta/sync-agents.sh --list-targets # 감지 대상 목록 출력

set -euo pipefail

META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"

color_info()  { printf '\033[36m[INFO]\033[0m %s\n' "$1"; }
color_ok()    { printf '\033[32m[OK]\033[0m   %s\n' "$1"; }
color_warn()  { printf '\033[33m[WARN]\033[0m %s\n' "$1"; }
color_err()   { printf '\033[31m[ERR]\033[0m  %s\n' "$1" >&2; }

# ── Windows 감지 시 .ps1로 위임 ──────────────────────────────────────────
case "$(uname -s 2>/dev/null || echo unknown)" in
    MINGW*|MSYS*|CYGWIN*)
        if command -v pwsh >/dev/null 2>&1; then
            color_info "Windows detected — delegating to sync-agents.ps1 (pwsh)"
            _ps_args=()
            for arg in "$@"; do
                case "$arg" in
                    --source-wins)  _ps_args+=("-SourceWins") ;;
                    --check)        _ps_args+=("-Check") ;;
                    --dry-run)      _ps_args+=("-DryRun") ;;
                    --list-targets) _ps_args+=("-ListTargets") ;;
                    -h|--help)      _ps_args+=("-?") ;;
                    *)              _ps_args+=("$arg") ;;
                esac
            done
            exec pwsh "$META_ROOT/sync-agents.ps1" "${_ps_args[@]}"
        else
            color_err "Windows detected but pwsh not found in PATH."
            color_err "Install PowerShell 7+ (https://aka.ms/PowerShell) or run sync-agents.ps1 directly."
            exit 3
        fi
        ;;
esac

# ── 인자 파싱 ────────────────────────────────────────────────────────────
SOURCE_WINS=0
CHECK_ONLY=0
DRY_RUN=0
LIST_TARGETS=0

while [ $# -gt 0 ]; do
    case "$1" in
        --source-wins)  SOURCE_WINS=1; shift ;;
        --check)        CHECK_ONLY=1; shift ;;
        --dry-run)      DRY_RUN=1; shift ;;
        --list-targets) LIST_TARGETS=1; shift ;;
        -h|--help)
            sed -n '2,16p' "$0" | sed 's/^# //' | sed 's/^#$//'
            exit 0
            ;;
        --*) color_err "unknown flag: $1"; exit 2 ;;
    esac
done

# ── SHA-256 함수 (3단 fallback) ─────────────────────────────────────────
if command -v sha256sum >/dev/null 2>&1; then
    hash_of() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
    hash_of() { shasum -a 256 "$1" | awk '{print $1}'; }
else
    hash_of() {
        python3 -c \
            "import hashlib,sys; print(hashlib.sha256(open(sys.argv[1],'rb').read()).hexdigest())" \
            "$1"
    }
fi

# ── AGENTS.md 검증 ───────────────────────────────────────────────────────
CANONICAL="AGENTS.md"
if [ ! -f "$CANONICAL" ]; then
    color_err "AGENTS.md not found in current directory ($(pwd))"
    color_err "Run this script from the project root."
    exit 1
fi

# ── 대상 매핑 (AGENTS_MD_STRATEGY.md §3 기반) ──────────────────────────
AGENT_MAPPINGS=(
    "CLAUDE.md"
    "GEMINI.md"
    ".github/copilot-instructions.md"
    ".cursor/rules/main.mdc"
    "CONVENTIONS.md"
    ".clinerules/main.md"
    ".roo/rules/main.md"
)

# ── --list-targets ───────────────────────────────────────────────────────
if [ "$LIST_TARGETS" -eq 1 ]; then
    color_info "Sync targets for $(pwd)/AGENTS.md:"
    for target in "${AGENT_MAPPINGS[@]}"; do
        if [ -f "$target" ]; then
            if [ -L "$target" ]; then
                printf '  %s (symlink — skipped)\n' "$target"
            else
                printf '  %s\n' "$target"
            fi
        else
            printf '  %s (absent)\n' "$target"
        fi
    done
    exit 0
fi

# ── 비대화형 감지 ────────────────────────────────────────────────────────
NON_INTERACTIVE=0
if [ ! -t 0 ] || [ -n "${CI:-}" ]; then
    NON_INTERACTIVE=1
fi

# ── drift 감지 ───────────────────────────────────────────────────────────
canonical_hash=$(hash_of "$CANONICAL")

DRIFT=()
for target in "${AGENT_MAPPINGS[@]}"; do
    # 파일 없으면 skip (absent = 해당 adapter 미사용)
    [ -f "$target" ] || continue
    # symlink → drift 없음으로 처리 (canonical 직접 참조)
    [ -L "$target" ] && continue
    target_hash=$(hash_of "$target")
    if [ "$target_hash" != "$canonical_hash" ]; then
        DRIFT+=("$target")
    fi
done

# ── drift 없음 ─────────────────────────────────────────────────────────
if [ "${#DRIFT[@]}" -eq 0 ]; then
    color_ok "All agent files are in sync with AGENTS.md."
    exit 0
fi

# ── --check ─────────────────────────────────────────────────────────────
if [ "$CHECK_ONLY" -eq 1 ]; then
    color_warn "Drift detected in ${#DRIFT[@]} file(s):"
    for t in "${DRIFT[@]}"; do printf '  %s\n' "$t"; done
    exit 1
fi

# ── --dry-run ────────────────────────────────────────────────────────────
if [ "$DRY_RUN" -eq 1 ]; then
    color_info "Drift detected in ${#DRIFT[@]} file(s) (dry-run — no changes):"
    for t in "${DRIFT[@]}"; do printf '  %s\n' "$t"; done
    exit 0
fi

# ── --source-wins ────────────────────────────────────────────────────────
if [ "$SOURCE_WINS" -eq 1 ]; then
    for target in "${DRIFT[@]}"; do
        # 대상 디렉토리 생성 (예: .cursor/rules/)
        target_dir=$(dirname "$target")
        [ "$target_dir" = "." ] || mkdir -p "$target_dir"
        cp -f "$CANONICAL" "$target"
        color_ok "overwritten: $target"
    done
    exit 0
fi

# ── warn-and-prompt ──────────────────────────────────────────────────────
if [ "$NON_INTERACTIVE" -eq 1 ]; then
    color_warn "Drift detected in ${#DRIFT[@]} file(s) (non-interactive: use --source-wins to sync):"
    for t in "${DRIFT[@]}"; do color_warn "  drift: $t"; done
    exit 1
fi

printf '\n\033[33m[WARN]\033[0m Drift detected in %d file(s):\n' "${#DRIFT[@]}"
for i in "${!DRIFT[@]}"; do printf '  %d. %s\n' "$((i+1))" "${DRIFT[$i]}"; done
printf '\n'

for target in "${DRIFT[@]}"; do
    printf '  Overwrite %s with AGENTS.md? [y/n/q]: ' "$target"
    answer=""
    if read -r answer </dev/tty 2>/dev/null; then
        case "$answer" in
            [Yy])
                target_dir=$(dirname "$target")
                [ "$target_dir" = "." ] || mkdir -p "$target_dir"
                cp -f "$CANONICAL" "$target"
                color_ok "overwritten: $target"
                ;;
            [Qq])
                color_info "Aborted."
                break
                ;;
            *)
                color_info "skipped: $target"
                ;;
        esac
    else
        color_warn "no TTY — skipped: $target"
    fi
done

exit 0

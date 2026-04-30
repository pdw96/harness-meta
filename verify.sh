#!/usr/bin/env bash
# harness-meta 설치 후 자가 검증 스크립트 (read-only). macOS/Linux 용.
#
# Usage: bash verify.sh [META_ROOT] [TIMEOUT]
#   META_ROOT: harness-meta repo 루트 (기본: $HARNESS_META_ROOT 또는 $HOME/harness-meta)
#   TIMEOUT  : Hook/statusline 실행 최대 대기(초). 기본 30
#
# Stage:
#   Z : 플랫폼 전제        (uname=Linux/Darwin, bash 4+, MetaRoot 정규화)
#   A : 환경 전제          (Dev Mode N/A, MetaRoot 구조, bash/python3)
#   B : Symlink 무결성     (3 카테고리 · LinkType=symlink · Target 실존 · MetaRoot 하위 · _base SKILL.md)
#   C : settings.json      (BOM 부재 · JSON 파싱 · statusLine · hooks.SessionStart) — python3 또는 jq 필요. 양쪽 부재 시 SKIP+WARN
#   D : Hook 스모크        (no-manifest / F1 / F2)
#   E : Statusline 스모크  (no-manifest / F1 / F2)
#   F : 정보성             (~/.claude/backup-* 열거)
#   H : Overlay 무결성     (overlay 매트릭스 + harness-* prefix + SKILL.md frontmatter)
#   I : Frontmatter 6축    (V1/V5/V7/V8/V10 — bootstrap/docs/PERMISSION_PATTERN.md)
#   J : PostToolUse 등록   (hooks.PostToolUse[Edit|Write|MultiEdit] 등록 · command · type · shell) — v1.38+, v1.40+
#   G : Runtime-only 체크리스트 (Claude Code 세션 내 수동 확인)

set -u
# (set -e 안 함 — 개별 체크 실패가 전체 종료를 일으키면 안 됨)

META_ROOT="${1:-${HARNESS_META_ROOT:-$HOME/harness-meta}}"
TIMEOUT="${2:-30}"

# 색 (TTY일 때만)
if [ -t 1 ]; then
    C_INFO=$'\033[36m'; C_OK=$'\033[32m'; C_WARN=$'\033[33m'; C_ERR=$'\033[31m'; C_HEAD=$'\033[35m'; C_END=$'\033[0m'
else
    C_INFO=''; C_OK=''; C_WARN=''; C_ERR=''; C_HEAD=''; C_END=''
fi

write_info() { echo "${C_INFO}[INFO]${C_END} $*"; }
write_ok()   { echo "${C_OK}[OK]${C_END}   $*"; }
write_warn() { echo "${C_WARN}[WARN]${C_END} $*"; }
write_err()  { echo "${C_ERR}[ERR]${C_END}  $*"; }

PASS=0
FAIL=0
WARN=0

check_ok()   { write_ok   "$1 $2"; PASS=$((PASS + 1)); }
check_fail() { write_err  "$1 $2"; FAIL=$((FAIL + 1)); }
check_warn() { write_warn "$1 $2"; WARN=$((WARN + 1)); }

write_info "harness-meta verify 시작 (MetaRoot=$META_ROOT, Timeout=${TIMEOUT}s)"
echo

# ═══ Z. 플랫폼 전제 ══════════════════════════════════════════════════
echo "${C_HEAD}== Z. 플랫폼 전제 ==${C_END}"

UNAME_S=$(uname -s 2>/dev/null || echo "")
case "$UNAME_S" in
    Linux|Darwin)
        check_ok "Z1" "OS 감지 ($UNAME_S)"
        ;;
    *)
        check_fail "Z1" "지원되지 않는 OS '$UNAME_S' (verify.sh는 Linux/Darwin 전용 — Windows는 verify.ps1)"
        echo
        write_err "플랫폼 전제 실패로 조기 종료."
        exit 1
        ;;
esac

if [ -z "${BASH_VERSINFO+x}" ] || [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    check_fail "Z2" "bash < 4 (필요: 4+. 현재: ${BASH_VERSION:-unknown})"
    exit 1
else
    check_ok "Z2" "bash ${BASH_VERSION}"
fi

if [ ! -d "$META_ROOT" ]; then
    check_fail "Z3" "MetaRoot 디렉토리 없음: $META_ROOT"
    echo
    exit 1
fi
META_ROOT=$(cd "$META_ROOT" && pwd -P)
check_ok "Z3" "MetaRoot 정규화 완료: $META_ROOT"

# verify-lib.sh source
LIB="$META_ROOT/verify-lib.sh"
if [ ! -f "$LIB" ]; then
    check_fail "Z4" "verify-lib.sh 부재: $LIB"
    exit 1
fi
# shellcheck disable=SC1090
. "$LIB"
check_ok "Z4" "verify-lib.sh source"

echo

# ═══ A. 환경 전제 ════════════════════════════════════════════════════
echo "${C_HEAD}== A. 환경 전제 ==${C_END}"

# A1: Linux/macOS는 자연 symlink 권한 보유. info 레벨로만 표시
write_info "A1 Developer Mode N/A (Linux/macOS는 자연 symlink 권한 보유)"

STRUCT_OK=1
MISSING=()
for sub in claude/commands claude/hooks claude/statusline; do
    if [ ! -d "$META_ROOT/$sub" ]; then
        STRUCT_OK=0
        MISSING+=("$sub")
    fi
done
if [ "$STRUCT_OK" -eq 1 ]; then
    check_ok "A2" "MetaRoot 하위 3 카테고리 구조 유효 (v1.8+)"
else
    check_fail "A2" "MetaRoot 하위 누락: ${MISSING[*]}"
fi

# A3a: system bash (Linux/macOS는 자연)
write_info "A3a Git Bash 명시 탐지 N/A (system bash 사용)"

# A3b: python3
if command -v python3 >/dev/null 2>&1; then
    PY3=$(command -v python3)
    check_ok "A3b" "python3: $PY3"
    HAS_PYTHON3=1
else
    check_warn "A3b" "python3 부재 — C 단계 settings.json 검증에 jq fallback 시도"
    HAS_PYTHON3=0
fi

# jq fallback 가용성
if command -v jq >/dev/null 2>&1; then
    HAS_JQ=1
else
    HAS_JQ=0
fi

echo

# ═══ B. Symlink 무결성 ════════════════════════════════════════════════
echo "${C_HEAD}== B. Symlink 무결성 ==${C_END}"

CLAUDE_DIR="$HOME/.claude"

# B1. 3 카테고리 디렉토리 존재
B1_MISS=()
for cat in commands hooks statusline; do
    [ ! -d "$CLAUDE_DIR/$cat" ] && B1_MISS+=("$cat")
done
if [ "${#B1_MISS[@]}" -eq 0 ]; then
    check_ok "B1" "~/.claude/ 3 카테고리 존재 (v1.8+)"
else
    check_fail "B1" "~/.claude/ 누락 카테고리: ${B1_MISS[*]}"
fi

# B2~B6. 기대 파일 enumerate + 무결성
declare -a EXPECTED_NAMES
declare -a EXPECTED_SRCS
declare -a EXPECTED_DSTS
declare -a EXPECTED_CATS

# 카테고리별 패턴
B2_count=0
B2_groups=()
for cat_pat in "commands:harness-meta.md" "hooks:*.sh" "statusline:statusline.sh"; do
    cat="${cat_pat%%:*}"
    pat="${cat_pat##*:}"
    src_dir="$META_ROOT/claude/$cat"
    [ ! -d "$src_dir" ] && continue
    cnt=0
    for f in "$src_dir"/$pat; do
        [ -e "$f" ] || continue
        name=$(basename "$f")
        EXPECTED_NAMES+=("$name")
        EXPECTED_SRCS+=("$f")
        EXPECTED_DSTS+=("$CLAUDE_DIR/$cat/$name")
        EXPECTED_CATS+=("$cat")
        cnt=$((cnt + 1))
        B2_count=$((B2_count + 1))
    done
    B2_groups+=("${cat}×${cnt}")
done
check_ok "B2" "기대 파일 ${B2_count}개 (${B2_groups[*]})"

# B3. 1:1 대응
B3_MISS=()
for i in "${!EXPECTED_DSTS[@]}"; do
    dst="${EXPECTED_DSTS[$i]}"
    [ ! -e "$dst" ] && [ ! -L "$dst" ] && B3_MISS+=("${EXPECTED_CATS[$i]}/${EXPECTED_NAMES[$i]}")
done
if [ "${#B3_MISS[@]}" -eq 0 ]; then
    check_ok "B3" "1:1 대응 완료 (누락 0건)"
else
    check_fail "B3" "누락 ${#B3_MISS[@]}건: ${B3_MISS[*]}"
fi

# B4~B6. LinkType + Target + MetaRoot 하위
B4_BAD=()
B5_BAD=()
B6_BAD=()
for i in "${!EXPECTED_DSTS[@]}"; do
    dst="${EXPECTED_DSTS[$i]}"
    src="${EXPECTED_SRCS[$i]}"
    label="${EXPECTED_CATS[$i]}/${EXPECTED_NAMES[$i]}"
    [ ! -L "$dst" ] && [ ! -e "$dst" ] && continue   # B3에서 카운트
    if reason=$(test_symlink_integrity "$dst" "$META_ROOT" "$src" 2>&1); then
        :
    else
        case "$reason" in
            LinkType*)            B4_BAD+=("$label: $reason") ;;
            target_not_exist*)    B5_BAD+=("$label: $reason") ;;
            target_outside_meta*) B6_BAD+=("$label: $reason") ;;
            target_mismatch*)     B5_BAD+=("$label: $reason") ;;
            *)                    B5_BAD+=("$label: $reason") ;;
        esac
    fi
done
[ "${#B4_BAD[@]}" -eq 0 ] && check_ok "B4" "LinkType=symlink 전부 확인" || for m in "${B4_BAD[@]}"; do check_fail "B4" "$m"; done
[ "${#B5_BAD[@]}" -eq 0 ] && check_ok "B5" "Target 실존 전부 확인" || for m in "${B5_BAD[@]}"; do check_fail "B5" "$m"; done
[ "${#B6_BAD[@]}" -eq 0 ] && check_ok "B6" "Target 모두 MetaRoot 하위" || for m in "${B6_BAD[@]}"; do check_fail "B6" "$m"; done

# B7. _base/skills/ SKILL.md
BASE_SKILLS_DIR="$META_ROOT/bootstrap/templates/_base/.claude/skills"
if [ -d "$BASE_SKILLS_DIR" ]; then
    B7_MISS=()
    B7_TOTAL=0
    for d in "$BASE_SKILLS_DIR"/*/; do
        [ -d "$d" ] || continue
        B7_TOTAL=$((B7_TOTAL + 1))
        if [ ! -f "$d/SKILL.md" ]; then
            B7_MISS+=("$(basename "$d")")
        fi
    done
    if [ "$B7_TOTAL" -eq 0 ]; then
        check_ok "B7" "_base/skills/ 디렉토리 비어있음 (skill 없음)"
    elif [ "${#B7_MISS[@]}" -eq 0 ]; then
        check_ok "B7" "_base/skills/ SKILL.md 존재 ${B7_TOTAL}/${B7_TOTAL} skills"
    else
        check_fail "B7" "_base/skills/ SKILL.md 누락: ${B7_MISS[*]}"
    fi
else
    check_fail "B7" "_base/skills/ 디렉토리 부재: $BASE_SKILLS_DIR"
fi

echo

# ═══ C. settings.json ════════════════════════════════════════════════
echo "${C_HEAD}== C. settings.json ==${C_END}"

SETTINGS="$CLAUDE_DIR/settings.json"
C_ABORT=0

if [ ! -f "$SETTINGS" ]; then
    check_fail "C0" "settings.json 부재: $SETTINGS"
    C_ABORT=1
elif [ "$HAS_PYTHON3" -eq 0 ] && [ "$HAS_JQ" -eq 0 ]; then
    check_warn "C" "JSON parser 부재 (python3/jq) — settings.json 검증 SKIP"
    C_ABORT=1
else
    # C0 BOM
    BOM=$(head -c 3 "$SETTINGS" | od -An -tx1 | tr -d ' \n')
    if [ "$BOM" = "efbbbf" ]; then
        check_fail "C0" "settings.json에 UTF-8 BOM 검출 (Claude Code JSON 파서 호환성 ↓)"
    else
        check_ok "C0" "UTF-8 no BOM"
    fi
fi

# JSON 파싱 helper
parse_json() {
    local file="$1"
    local jq_expr="$2"
    local py_expr="$3"
    if [ "$HAS_PYTHON3" -eq 1 ]; then
        python3 -c "$py_expr" "$file" 2>/dev/null
    else
        jq -r "$jq_expr" "$file" 2>/dev/null
    fi
}

if [ "$C_ABORT" -eq 0 ]; then
    # C1 JSON parse
    if parse_json "$SETTINGS" '.' 'import json,sys; json.load(open(sys.argv[1]))' >/dev/null; then
        check_ok "C1" "JSON 파싱 성공"
    else
        check_fail "C1" "JSON 파싱 실패"
        C_ABORT=1
    fi
fi

if [ "$C_ABORT" -eq 0 ]; then
    # C2 statusLine.type
    sl_type=$(parse_json "$SETTINGS" '.statusLine.type // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d.get("statusLine",{}).get("type",""))')
    if [ "$sl_type" = "command" ]; then
        check_ok "C2" "statusLine.type == 'command'"
    else
        check_fail "C2" "statusLine.type != 'command' (실제: '$sl_type')"
    fi

    # C3 statusLine.command
    sl_cmd=$(parse_json "$SETTINGS" '.statusLine.command // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d.get("statusLine",{}).get("command",""))')
    EXP_CMD='$HOME/.claude/statusline/statusline.sh'
    if [ "$sl_cmd" = "$EXP_CMD" ]; then
        check_ok "C3" "statusLine.command literal 일치"
    else
        check_fail "C3" "statusLine.command != '$EXP_CMD' (실제: '$sl_cmd')"
    fi

    # C4 hooks.SessionStart length
    ss_len=$(parse_json "$SETTINGS" '(.hooks.SessionStart // []) | length' 'import json,sys; d=json.load(open(sys.argv[1])); print(len(d.get("hooks",{}).get("SessionStart",[])))')
    case "$ss_len" in
        1)   check_ok   "C4" "hooks.SessionStart 배열 길이 1" ;;
        0)   check_fail "C4" "hooks.SessionStart 부재 또는 빈 배열"; C_ABORT=1 ;;
        ''|*[!0-9]*) check_fail "C4" "hooks.SessionStart length 추출 실패: '$ss_len'"; C_ABORT=1 ;;
        *)   check_warn "C4" "hooks.SessionStart 배열 길이 $ss_len (다른 SessionStart hook과 공존 — install.ps1은 첫 원소만 관리)" ;;
    esac
fi

if [ "$C_ABORT" -eq 0 ]; then
    # C5~C9: 첫 SessionStart 원소 검사
    matcher=$(parse_json "$SETTINGS" '.hooks.SessionStart[0].matcher // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d["hooks"]["SessionStart"][0].get("matcher",""))')
    [ "$matcher" = "startup" ] && check_ok "C5" "matcher == 'startup'" || check_fail "C5" "matcher != 'startup' (실제: '$matcher')"

    h_type=$(parse_json "$SETTINGS" '.hooks.SessionStart[0].hooks[0].type // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d["hooks"]["SessionStart"][0]["hooks"][0].get("type",""))')
    [ "$h_type" = "command" ] && check_ok "C6" "hooks[0].type == 'command'" || check_fail "C6" "hooks[0].type != 'command' (실제: '$h_type')"

    h_cmd=$(parse_json "$SETTINGS" '.hooks.SessionStart[0].hooks[0].command // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d["hooks"]["SessionStart"][0]["hooks"][0].get("command",""))')
    EXP_HOOK='$HOME/.claude/hooks/session-init.sh'
    [ "$h_cmd" = "$EXP_HOOK" ] && check_ok "C7" "hooks[0].command literal 일치" || check_fail "C7" "hooks[0].command != '$EXP_HOOK' (실제: '$h_cmd')"

    h_shell=$(parse_json "$SETTINGS" '.hooks.SessionStart[0].hooks[0].shell // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d["hooks"]["SessionStart"][0]["hooks"][0].get("shell",""))')
    [ "$h_shell" = "bash" ] && check_ok "C8" "hooks[0].shell == 'bash'" || check_fail "C8" "hooks[0].shell != 'bash' (실제: '$h_shell')"

    h_to=$(parse_json "$SETTINGS" '.hooks.SessionStart[0].hooks[0].timeout // empty' 'import json,sys; d=json.load(open(sys.argv[1])); print(d["hooks"]["SessionStart"][0]["hooks"][0].get("timeout",""))')
    [ "$h_to" = "10" ] && check_ok "C9" "hooks[0].timeout == 10" || check_fail "C9" "hooks[0].timeout != 10 (실제: '$h_to')"
fi

echo

# ═══ D/E Fixture 준비 ═══════════════════════════════════════════════
FIXTURE_ROOT="$META_ROOT/tests/fixtures"
F1="$FIXTURE_ROOT/sample-project"
F2="$FIXTURE_ROOT/empty-phases"

NO_MANIFEST=$(mktemp -d -t harness-verify-nomanifest-XXXXXXXX)

HOOK_SCRIPT="$META_ROOT/claude/hooks/session-init.sh"
SL_SCRIPT="$META_ROOT/claude/statusline/statusline.sh"

invoke_bash() {
    local script="$1"
    local proj="$2"
    local stdout_file
    stdout_file=$(mktemp)
    local stderr_file
    stderr_file=$(mktemp)
    CLAUDE_PROJECT_DIR="$proj" bash "$script" >"$stdout_file" 2>"$stderr_file"
    local rc=$?
    INVOKE_STDOUT=$(cat "$stdout_file")
    INVOKE_STDERR=$(cat "$stderr_file")
    rm -f "$stdout_file" "$stderr_file"
    return $rc
}

# ═══ D. Hook 스모크 ═══════════════════════════════════════════════════
echo "${C_HEAD}== D. Hook 스모크 ==${C_END}"

# D1 no-manifest → exact "{}"
if invoke_bash "$HOOK_SCRIPT" "$NO_MANIFEST"; then
    trim=$(echo "$INVOKE_STDOUT" | tr -d '[:space:]')
    if [ "$trim" = "{}" ]; then
        check_ok "D1" "no-manifest → exact '{}' (exit 0)"
    else
        check_fail "D1" "no-manifest 결과 이상 (stdout='$INVOKE_STDOUT', stderr='$INVOKE_STDERR')"
    fi
else
    check_fail "D1" "exit != 0. stderr='$INVOKE_STDERR'"
fi

# D2 F1 → "not initialized"
if [ -d "$F1" ]; then
    if invoke_bash "$HOOK_SCRIPT" "$F1"; then
        if echo "$INVOKE_STDOUT" | grep -q '"hookEventName"\s*:\s*"SessionStart"' && \
           echo "$INVOKE_STDOUT" | grep -q 'not initialized'; then
            check_ok "D2" "F1 → SessionStart + 'not initialized' 포함"
        else
            check_fail "D2" "기대 keyword 부재. stdout='$INVOKE_STDOUT'"
        fi
    else
        check_fail "D2" "exit != 0. stderr='$INVOKE_STDERR'"
    fi
else
    check_warn "D2" "F1 fixture 부재: $F1"
fi

# D3 F2 → "phases directory exists"
if [ -d "$F2" ]; then
    if invoke_bash "$HOOK_SCRIPT" "$F2"; then
        if echo "$INVOKE_STDOUT" | grep -q 'phases directory exists'; then
            check_ok "D3" "F2 → 'phases directory exists' 포함"
        else
            check_fail "D3" "기대 keyword 부재. stdout='$INVOKE_STDOUT'"
        fi
    else
        check_fail "D3" "exit != 0. stderr='$INVOKE_STDERR'"
    fi
else
    check_warn "D3" "F2 fixture 부재: $F2"
fi

echo

# ═══ E. Statusline 스모크 ═════════════════════════════════════════════
echo "${C_HEAD}== E. Statusline 스모크 ==${C_END}"

# E1 no-manifest → 빈 출력
if invoke_bash "$SL_SCRIPT" "$NO_MANIFEST"; then
    if [ -z "$(echo "$INVOKE_STDOUT" | tr -d '[:space:]')" ]; then
        check_ok "E1" "no-manifest → 빈 출력 (exit 0)"
    else
        check_fail "E1" "no-manifest 결과 이상 (stdout='$INVOKE_STDOUT')"
    fi
else
    check_fail "E1" "exit != 0. stderr='$INVOKE_STDERR'"
fi

# E2 F1 → "[harness] sample-project"
if [ -d "$F1" ]; then
    if invoke_bash "$SL_SCRIPT" "$F1"; then
        out=$(echo "$INVOKE_STDOUT" | sed 's/[[:space:]]*$//' | head -1)
        EXP='[harness] sample-project'
        [ "$out" = "$EXP" ] && check_ok "E2" "F1 → '$EXP'" || check_fail "E2" "F1 결과 이상 (stdout='$out', 기대='$EXP')"
    else
        check_fail "E2" "exit != 0. stderr='$INVOKE_STDERR'"
    fi
else
    check_warn "E2" "F1 fixture 부재"
fi

# E3 F2 → "[harness] empty-phases"
if [ -d "$F2" ]; then
    if invoke_bash "$SL_SCRIPT" "$F2"; then
        out=$(echo "$INVOKE_STDOUT" | sed 's/[[:space:]]*$//' | head -1)
        EXP='[harness] empty-phases'
        [ "$out" = "$EXP" ] && check_ok "E3" "F2 → '$EXP'" || check_fail "E3" "F2 결과 이상 (stdout='$out', 기대='$EXP')"
    else
        check_fail "E3" "exit != 0. stderr='$INVOKE_STDERR'"
    fi
else
    check_warn "E3" "F2 fixture 부재"
fi

# no-manifest 정리
rm -rf "$NO_MANIFEST"

echo

# ═══ F. 정보성 ════════════════════════════════════════════════════════
echo "${C_HEAD}== F. 정보성 ==${C_END}"

BACKUPS=()
if [ -d "$CLAUDE_DIR" ]; then
    while IFS= read -r d; do
        BACKUPS+=("$d")
    done < <(find "$CLAUDE_DIR" -maxdepth 1 -type d -name 'backup-*' 2>/dev/null)
fi
if [ "${#BACKUPS[@]}" -gt 0 ]; then
    write_info "~/.claude/backup-* 디렉토리 ${#BACKUPS[@]}개 존재 (수동 삭제 권장):"
    for b in "${BACKUPS[@]}"; do write_info "  - $b"; done
else
    write_info "leftover backup 디렉토리 없음"
fi

echo

# ═══ H. Overlay 무결성 ════════════════════════════════════════════════
echo "${C_HEAD}== H. Overlay 무결성 ==${C_END}"

TPL_ROOT="$META_ROOT/bootstrap/templates"
LANG_MATRIX="python typescript javascript go rust java kotlin csharp ruby elixir"

# H1: enumerate
H1_BAD=()
H1_LANGS=()
if [ -d "$TPL_ROOT" ]; then
    for d in "$TPL_ROOT"/*/; do
        [ -d "$d" ] || continue
        name=$(basename "$d")
        case "$name" in
            _*) continue ;;   # _base 등 sentinel
        esac
        # matrix 검사
        if echo " $LANG_MATRIX " | grep -q " $name "; then
            H1_LANGS+=("$name")
        else
            H1_BAD+=("$name")
        fi
    done
fi
if [ "${#H1_BAD[@]}" -eq 0 ]; then
    if [ "${#H1_LANGS[@]}" -eq 0 ]; then
        check_ok "H1" "overlay 매트릭스 enumerate (실재 0건 — 정합)"
    else
        check_ok "H1" "overlay 매트릭스 enumerate (실재: ${H1_LANGS[*]})"
    fi
else
    check_fail "H1" "OVERLAY.md §3 매트릭스 외 디렉토리: ${H1_BAD[*]}"
fi

# H2: harness-* prefix convention (각 카테고리 내)
H2_BAD=()
for lang in "${H1_LANGS[@]}"; do
    for cat in commands agents skills output-styles; do
        cat_dir="$TPL_ROOT/$lang/.claude/$cat"
        [ -d "$cat_dir" ] || continue
        for item in "$cat_dir"/*; do
            [ -e "$item" ] || continue
            iname=$(basename "$item")
            [ "$iname" = ".gitkeep" ] && continue
            case "$iname" in
                harness-*) ;;
                harness*) ;;   # harness/ (디렉토리) 자체 허용
                *) H2_BAD+=("$lang/$cat/$iname") ;;
            esac
        done
    done
done
if [ "${#H2_BAD[@]}" -eq 0 ]; then
    check_ok "H2" "overlay item harness-* prefix convention 준수"
else
    check_fail "H2" "harness-* prefix 위반 ${#H2_BAD[@]}건: ${H2_BAD[*]}"
fi

# H3: SKILL.md frontmatter 최소 필드
H3_BAD=()
H3_TOTAL=0
for lang in "${H1_LANGS[@]}"; do
    skill_dir="$TPL_ROOT/$lang/.claude/skills"
    [ -d "$skill_dir" ] || continue
    for sd in "$skill_dir"/*/; do
        [ -d "$sd" ] || continue
        skill_md="$sd/SKILL.md"
        if [ ! -f "$skill_md" ]; then
            H3_BAD+=("$lang/skills/$(basename "$sd"): SKILL.md 부재")
            continue
        fi
        H3_TOTAL=$((H3_TOTAL + 1))
        if ! grep -qE '^name:' "$skill_md"; then
            H3_BAD+=("$lang/skills/$(basename "$sd"): name: 필드 부재")
        fi
        if ! grep -qE '^description:' "$skill_md"; then
            H3_BAD+=("$lang/skills/$(basename "$sd"): description: 필드 부재")
        fi
    done
done
if [ "${#H3_BAD[@]}" -eq 0 ]; then
    check_ok "H3" "overlay SKILL.md frontmatter 정합 (${H3_TOTAL}건)"
else
    check_fail "H3" "frontmatter 위반: ${H3_BAD[*]}"
fi

echo

# ═══ I. Frontmatter 6축 ═══════════════════════════════════════════════
echo "${C_HEAD}== I. Frontmatter 6축 (V1/V5/V7/V8/V10) ==${C_END}"

FRONTMATTER_FILES=(
    "claude/commands/harness-meta.md"
    "bootstrap/templates/_base/.claude/skills/harness/SKILL.md"
    "bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md"
    "bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md"
    "bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md"
    "bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md"
    "bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md"
    "bootstrap/templates/_base/.claude/agents/harness-dispatcher.md"
    "bootstrap/templates/_base/.claude/agents/harness-explore.md"
    "bootstrap/templates/_base/.claude/agents/harness-grey-area.md"
    "bootstrap/templates/_base/.claude/agents/harness-verifier.md"
    "bootstrap/templates/python/.claude/skills/harness-python/SKILL.md"
    # v1.36: 글로벌 user-skill 2단계 카테고리 (audit/ + dev-tools/)
    "bootstrap/skills/audit/harness-plan-verify/SKILL.md"
    "bootstrap/skills/audit/harness-roadmap-update/SKILL.md"
    "bootstrap/skills/audit/ai-ready-scorer/SKILL.md"
    "bootstrap/skills/dev-tools/mindvault/SKILL.md"
    "bootstrap/skills/dev-tools/developer-profile/SKILL.md"
)

# I1: V1 — 콜론 없는 Bash(\w+\*) 0건
I1_total=0
I1_files=()
for rel in "${FRONTMATTER_FILES[@]}"; do
    f="$META_ROOT/$rel"
    [ -f "$f" ] || continue
    n=$(grep -cE 'Bash\([a-z][a-z\-]*\*\)' "$f" 2>/dev/null || echo 0)
    if [ "$n" -gt 0 ]; then
        I1_total=$((I1_total + n))
        I1_files+=("$rel:$n")
    fi
done
[ "$I1_total" -eq 0 ] && check_ok "I1" "V1 콜론 없음 패턴 0건" || check_fail "I1" "V1 위반 ${I1_total}건: ${I1_files[*]}"

# I2: V5 — auto-allow set declare 0건
AUTO_SET='Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)'
I2_total=0
I2_files=()
for rel in "${FRONTMATTER_FILES[@]}"; do
    f="$META_ROOT/$rel"
    [ -f "$f" ] || continue
    n=$(grep -cE "$AUTO_SET" "$f" 2>/dev/null || echo 0)
    if [ "$n" -gt 0 ]; then
        I2_total=$((I2_total + n))
        I2_files+=("$rel:$n")
    fi
done
[ "$I2_total" -eq 0 ] && check_ok "I2" "V5 auto-allow set declare 0건" || check_fail "I2" "V5 위반 ${I2_total}건: ${I2_files[*]}"

# I3: V7 — slash command allowed-tools: 필드
SLASH="$META_ROOT/claude/commands/harness-meta.md"
if [ -f "$SLASH" ]; then
    if grep -qE '^allowed-tools:' "$SLASH"; then
        check_ok "I3" "V7 slash command allowed-tools: 필드 (claude/commands/harness-meta.md)"
    else
        check_fail "I3" "V7 위반 — claude/commands/harness-meta.md에 'allowed-tools:' 부재"
    fi
else
    check_fail "I3" "V7 — slash command 파일 부재: $SLASH"
fi

# I4: V8 — single-line 콤마 separator 0건
I4_total=0
I4_files=()
for rel in "${FRONTMATTER_FILES[@]}"; do
    f="$META_ROOT/$rel"
    [ -f "$f" ] || continue
    n=$(grep -cE '^(allowed-tools|tools):.+,' "$f" 2>/dev/null || echo 0)
    if [ "$n" -gt 0 ]; then
        I4_total=$((I4_total + n))
        I4_files+=("$rel:$n")
    fi
done
[ "$I4_total" -eq 0 ] && check_ok "I4" "V8 콤마 separator 0건" || check_fail "I4" "V8 위반 ${I4_total}건: ${I4_files[*]}"

# I5: V10 — ^thinking: 0건
I5_total=0
I5_files=()
for rel in "${FRONTMATTER_FILES[@]}"; do
    f="$META_ROOT/$rel"
    [ -f "$f" ] || continue
    n=$(grep -cE '^thinking:' "$f" 2>/dev/null || echo 0)
    if [ "$n" -gt 0 ]; then
        I5_total=$((I5_total + n))
        I5_files+=("$rel:$n")
    fi
done
[ "$I5_total" -eq 0 ] && check_ok "I5" "V10 thinking: 필드 0건 (silent ignore 회피)" || check_fail "I5" "V10 위반 ${I5_total}건: ${I5_files[*]}"

echo

# ═══ J. PostToolUse[Edit|Write|MultiEdit] 등록 ════════════════════════
echo "${C_HEAD}== J. PostToolUse[Edit|Write|MultiEdit] 등록 ==${C_END}"

if [ "$C_ABORT" -eq 0 ]; then
    ptu_len=$(parse_json "$SETTINGS" \
        '(.hooks.PostToolUse // []) | length' \
        'import json,sys; d=json.load(open(sys.argv[1])); print(len(d.get("hooks",{}).get("PostToolUse",[])))')
    if [ -z "$ptu_len" ] || [ "$ptu_len" = "0" ]; then
        check_fail "J1" "hooks.PostToolUse 부재 또는 빈 배열 (install.ps1 재실행 필요)"
    else
        check_ok "J1" "hooks.PostToolUse 배열 존재 ($ptu_len 항목)"
        j_idx=$(parse_json "$SETTINGS" \
            '(.hooks.PostToolUse // []) | to_entries[] | select(.value.matcher == "Edit|Write|MultiEdit") | .key' \
            'import json,sys; d=json.load(open(sys.argv[1])); ptu=d.get("hooks",{}).get("PostToolUse",[]); idx=[i for i,e in enumerate(ptu) if e.get("matcher")=="Edit|Write|MultiEdit"]; print(idx[0] if idx else "")')
        if [ -z "$j_idx" ]; then
            check_fail "J2" "matcher='Edit|Write|MultiEdit' 항목 부재 (install.ps1 재실행 필요)"
        else
            check_ok "J2" "matcher='Edit|Write|MultiEdit' 항목 발견 (index=$j_idx)"
            EXP_PTU_CMD='$HOME/.claude/hooks/post-report-write.sh'
            j3_cmd=$(parse_json "$SETTINGS" \
                ".hooks.PostToolUse[$j_idx].hooks[0].command // empty" \
                "import json,sys; d=json.load(open(sys.argv[1])); print(d['hooks']['PostToolUse'][$j_idx]['hooks'][0].get('command',''))")
            [ "$j3_cmd" = "$EXP_PTU_CMD" ] && check_ok "J3" "command literal 일치" || check_fail "J3" "command != '$EXP_PTU_CMD' (실제: '$j3_cmd')"
            j4_type=$(parse_json "$SETTINGS" \
                ".hooks.PostToolUse[$j_idx].hooks[0].type // empty" \
                "import json,sys; d=json.load(open(sys.argv[1])); print(d['hooks']['PostToolUse'][$j_idx]['hooks'][0].get('type',''))")
            [ "$j4_type" = "command" ] && check_ok "J4" "type == 'command'" || check_fail "J4" "type != 'command' (실제: '$j4_type')"
            j5_shell=$(parse_json "$SETTINGS" \
                ".hooks.PostToolUse[$j_idx].hooks[0].shell // empty" \
                "import json,sys; d=json.load(open(sys.argv[1])); print(d['hooks']['PostToolUse'][$j_idx]['hooks'][0].get('shell',''))")
            [ "$j5_shell" = "bash" ] && check_ok "J5" "shell == 'bash'" || check_fail "J5" "shell != 'bash' (실제: '$j5_shell')"
        fi
    fi
else
    check_warn "J1" "settings.json 파싱 실패로 Stage J skip"
fi

echo

# ═══ G. Runtime-only 체크리스트 ═══════════════════════════════════════
echo "${C_HEAD}== G. Runtime-only 수동 확인 체크리스트 ==${C_END}"
echo "  [ ] Claude Code 세션에서 'What skills are available?' → harness-{plan,design,ship} 노출"
echo "  [ ] /harness-meta 입력 → slash command 인식"
echo "  [ ] .mcp.json에 harness 서버 선언된 프로젝트에서 mcp__harness__* deferred tools 노출"
echo "  [ ] output-style 'Harness Engineer' 선택 → 응답 스타일 반영"
echo "  [ ] CLAUDE.md의 @bootstrap/docs/OWNERSHIP.md 내용 자동 로드 확인"
echo "  [ ] 활성 프로젝트에서 execute.py --doctor → 0 FAIL"

echo

# ═══ 요약 ═════════════════════════════════════════════════════════════
echo "${C_HEAD}== 요약 ==${C_END}"
TOTAL=$((PASS + FAIL))
if [ "$FAIL" -eq 0 ]; then
    write_ok "$PASS/$TOTAL PASS (WARN: $WARN) — 자동화 검증 통과"
    write_info "G 체크리스트(6항)는 Claude Code 세션 내 수동 확인 필요"
    exit 0
else
    write_err "$PASS/$TOTAL PASS · $FAIL FAIL (WARN: $WARN)"
    exit 1
fi

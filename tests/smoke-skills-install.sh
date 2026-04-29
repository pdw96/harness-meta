#!/usr/bin/env bash
# v1.22+ smoke: install-skills.{sh,ps1} + bootstrap/skills/ 인프라 검증.
# v1.20+: mindvault + developer-profile 이관 매트릭스 확장.
# v1.22+: copy mode fallback + 플래그 변환 맵 + .harness-install-mode 검증.
#
# 정적 (9):
#   ✓ bootstrap/skills/ai-ready-scorer/SKILL.md 존재
#   ✓ bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py 존재
#   ✓ install-skills.sh: Windows 위임 + backup 외부 위치 + symlink 검증 분기 grep
#   ✓ install-skills.ps1: New-Item SymbolicLink + try/catch + backup root 외부 grep
#   ✓ bootstrap/docs/SKILLS.md 존재 + 핵심 keyword 매치
#   ✓ bootstrap/skills/mindvault/SKILL.md 존재 + disable-model-invocation:true (v1.20)
#   ✓ bootstrap/skills/developer-profile/SKILL.md 존재 + user-invocable:false (v1.20)
#   ✓ install-skills.ps1: CopyMode + try { + harness-install-mode (v1.22)
#   ✓ install-skills.sh: copy-mode + _ps_args + harness-install-mode (v1.22)
#
# Dynamic (6, Linux/macOS only — Windows는 .ps1 위임이라 본 smoke가 검증 안 함):
#   환경 분기:
#     - Linux/macOS: ln -s가 정상 symlink 생성 가능 → dynamic 진행
#     - Windows Git Bash: install-skills.sh가 .ps1로 위임, smoke는 정적만
#
#   Linux/macOS dynamic (symlink, 기존 3건):
#     ✓ tmpdir HOME으로 install-skills.sh 실행 → exit 0
#     ✓ tmpdir/.claude/skills/ai-ready-scorer가 symlink (test -L)
#     ✓ symlink target == bootstrap/skills/ai-ready-scorer
#
#   Linux/macOS dynamic (copy mode, v1.22 신규 3건):
#     ✓ tmpdir HOME으로 install-skills.sh --copy-mode 실행 → exit 0
#     ✓ tmpdir/.claude/skills/ai-ready-scorer가 directory (NOT symlink)
#     ✓ tmpdir/.claude/skills/.harness-install-mode에 "copy" 포함

set -euo pipefail

REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

PASS=0
FAIL=0
LINES=()

check() {
    local name="$1"; local cmd="$2"
    if eval "$cmd" >/dev/null 2>&1; then
        LINES+=("✓ $name")
        PASS=$((PASS + 1))
    else
        LINES+=("✗ $name")
        FAIL=$((FAIL + 1))
    fi
}

# ── 정적 (5) ───────────────────────────────────────────────────────────
check "bootstrap/skills/ai-ready-scorer/SKILL.md 존재" \
    "[ -f '$REPO_ROOT/bootstrap/skills/ai-ready-scorer/SKILL.md' ]"

check "bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py 존재" \
    "[ -f '$REPO_ROOT/bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py' ]"

check "install-skills.sh: Windows 위임 + backup 외부 + symlink 검증" \
    "grep -q 'MINGW' '$REPO_ROOT/install-skills.sh' && \
     grep -q 'BACKUP_ROOT=.*backups/skills' '$REPO_ROOT/install-skills.sh' && \
     grep -q 'symlink creation failed' '$REPO_ROOT/install-skills.sh'"

check "install-skills.ps1: SymbolicLink + try/catch + backup root 외부" \
    "grep -q 'New-Item -ItemType SymbolicLink' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'try {' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'backups.*skills' '$REPO_ROOT/install-skills.ps1'"

check "bootstrap/docs/SKILLS.md 존재 + 핵심 keyword" \
    "[ -f '$REPO_ROOT/bootstrap/docs/SKILLS.md' ] && \
     grep -q '글로벌 user-skill' '$REPO_ROOT/bootstrap/docs/SKILLS.md' && \
     grep -q 'install-skills' '$REPO_ROOT/bootstrap/docs/SKILLS.md' && \
     grep -q 'backups/skills' '$REPO_ROOT/bootstrap/docs/SKILLS.md'"

# ── v1.22: copy mode + 플래그 변환 맵 검증 ──────────────────────────────
check "install-skills.ps1: CopyMode + try { + harness-install-mode" \
    "grep -q 'CopyMode' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'try {' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'harness-install-mode' '$REPO_ROOT/install-skills.ps1'"

check "install-skills.sh: copy-mode + _ps_args + harness-install-mode" \
    "grep -q 'copy.mode' '$REPO_ROOT/install-skills.sh' && \
     grep -q '_ps_args' '$REPO_ROOT/install-skills.sh' && \
     grep -q 'harness-install-mode' '$REPO_ROOT/install-skills.sh'"

# ── v1.20: mindvault + developer-profile 이관 검증 ─────────────────────
check "bootstrap/skills/mindvault/SKILL.md 존재 + disable-model-invocation:true" \
    "[ -f '$REPO_ROOT/bootstrap/skills/mindvault/SKILL.md' ] && \
     grep -qE '^disable-model-invocation:[[:space:]]*true' '$REPO_ROOT/bootstrap/skills/mindvault/SKILL.md' && \
     grep -q 'archived 2026-04-14' '$REPO_ROOT/bootstrap/skills/mindvault/SKILL.md'"

check "bootstrap/skills/developer-profile/SKILL.md 존재 + user-invocable:false" \
    "[ -f '$REPO_ROOT/bootstrap/skills/developer-profile/SKILL.md' ] && \
     grep -qE '^user-invocable:[[:space:]]*false' '$REPO_ROOT/bootstrap/skills/developer-profile/SKILL.md'"

# ── Dynamic (3, Linux/macOS only) ──────────────────────────────────────
case "$(uname -s 2>/dev/null || echo unknown)" in
    Linux|Darwin)
        TMPHOME=$(mktemp -d)
        export HARNESS_META_ROOT="$REPO_ROOT"
        if HOME="$TMPHOME" bash "$REPO_ROOT/install-skills.sh" >/dev/null 2>&1; then
            LINES+=("✓ install-skills.sh 실행 → exit 0 (tmpdir)")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ install-skills.sh 실행 실패")
            FAIL=$((FAIL + 1))
        fi
        check "tmpdir/.claude/skills/ai-ready-scorer가 symlink" \
            "[ -L '$TMPHOME/.claude/skills/ai-ready-scorer' ]"
        check "symlink target == bootstrap/skills/ai-ready-scorer" \
            "[ \"\$(readlink '$TMPHOME/.claude/skills/ai-ready-scorer')\" = '$REPO_ROOT/bootstrap/skills/ai-ready-scorer' ]"
        rm -rf "$TMPHOME"

        # ── copy mode dynamic (v1.22 신규) ─────────────────────────────
        TMPHOME2=$(mktemp -d)
        export HARNESS_META_ROOT="$REPO_ROOT"
        if HOME="$TMPHOME2" bash "$REPO_ROOT/install-skills.sh" --copy-mode ai-ready-scorer >/dev/null 2>&1; then
            LINES+=("✓ install-skills.sh --copy-mode 실행 → exit 0 (tmpdir)")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ install-skills.sh --copy-mode 실행 실패")
            FAIL=$((FAIL + 1))
        fi
        check "tmpdir/.claude/skills/ai-ready-scorer가 directory (copy mode)" \
            "[ ! -L '$TMPHOME2/.claude/skills/ai-ready-scorer' ] && [ -d '$TMPHOME2/.claude/skills/ai-ready-scorer' ]"
        check ".harness-install-mode에 copy 기록" \
            "grep -q 'copy' '$TMPHOME2/.claude/skills/.harness-install-mode'"
        rm -rf "$TMPHOME2"
        ;;
    *)
        LINES+=("⏭  dynamic skip (non-Linux/Darwin: $(uname -s))")
        ;;
esac

# ── 결과 ───────────────────────────────────────────────────────────────
printf '\n=== smoke-skills-install ===\n'
for line in "${LINES[@]}"; do printf '  %s\n' "$line"; done
printf '\n  PASS=%d  FAIL=%d\n' "$PASS" "$FAIL"

[ "$FAIL" -eq 0 ]

#!/usr/bin/env bash
# v1.19+ smoke: install-skills.{sh,ps1} + bootstrap/skills/ 인프라 검증.
#
# 정적 (5):
#   ✓ bootstrap/skills/ai-ready-scorer/SKILL.md 존재
#   ✓ bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py 존재
#   ✓ install-skills.sh: Windows 위임 + backup 외부 위치 + symlink 검증 분기 grep
#   ✓ install-skills.ps1: New-Item SymbolicLink + LinkType 검증 + backup root 외부 grep
#   ✓ bootstrap/docs/SKILLS.md 존재 + 핵심 keyword 매치
#
# Dynamic (3, Linux/macOS only — Windows는 .ps1 위임이라 본 smoke가 검증 안 함):
#   환경 분기:
#     - Linux/macOS: ln -s가 정상 NTFS symlink 생성 가능 → dynamic 진행
#     - Windows Git Bash: install-skills.sh가 .ps1로 위임, smoke는 정적만
#
#   Linux/macOS dynamic:
#     ✓ tmpdir HOME으로 install-skills.sh 실행 → exit 0
#     ✓ tmpdir/.claude/skills/ai-ready-scorer가 symlink (test -L)
#     ✓ symlink target == bootstrap/skills/ai-ready-scorer

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

check "install-skills.ps1: SymbolicLink + LinkType 검증 + backup root 외부" \
    "grep -q 'New-Item -ItemType SymbolicLink' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'LinkType' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'backups.*skills' '$REPO_ROOT/install-skills.ps1'"

check "bootstrap/docs/SKILLS.md 존재 + 핵심 keyword" \
    "[ -f '$REPO_ROOT/bootstrap/docs/SKILLS.md' ] && \
     grep -q '글로벌 user-skill' '$REPO_ROOT/bootstrap/docs/SKILLS.md' && \
     grep -q 'install-skills' '$REPO_ROOT/bootstrap/docs/SKILLS.md' && \
     grep -q 'backups/skills' '$REPO_ROOT/bootstrap/docs/SKILLS.md'"

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

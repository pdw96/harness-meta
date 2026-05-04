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
# v1.36: 2단계 카테고리 — bootstrap/skills/audit/<name>/ + bootstrap/skills/dev-tools/<name>/
check "bootstrap/skills/audit/ai-ready-scorer/SKILL.md 존재 (v1.36 2-tier)" \
    "[ -f '$REPO_ROOT/bootstrap/skills/audit/ai-ready-scorer/SKILL.md' ]"

check "bootstrap/skills/audit/ai-ready-scorer/scripts/score_codebase.py 존재" \
    "[ -f '$REPO_ROOT/bootstrap/skills/audit/ai-ready-scorer/scripts/score_codebase.py' ]"

# v1.36: 2단계 carry-over — 기존 1단계 경로는 부재
check "bootstrap/skills/ai-ready-scorer/ 1단계 부재 (이관 완료)" \
    "[ ! -d '$REPO_ROOT/bootstrap/skills/ai-ready-scorer' ]"

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

# ── v1.20+v1.36: mindvault + developer-profile 이관 검증 (2단계) ───────
check "bootstrap/skills/dev-tools/mindvault/SKILL.md 존재 + disable-model-invocation:true" \
    "[ -f '$REPO_ROOT/bootstrap/skills/dev-tools/mindvault/SKILL.md' ] && \
     grep -qE '^disable-model-invocation:[[:space:]]*true' '$REPO_ROOT/bootstrap/skills/dev-tools/mindvault/SKILL.md' && \
     grep -q 'archived 2026-04-14' '$REPO_ROOT/bootstrap/skills/dev-tools/mindvault/SKILL.md'"

check "bootstrap/skills/dev-tools/developer-profile/SKILL.md 존재 + user-invocable:false" \
    "[ -f '$REPO_ROOT/bootstrap/skills/dev-tools/developer-profile/SKILL.md' ] && \
     grep -qE '^user-invocable:[[:space:]]*false' '$REPO_ROOT/bootstrap/skills/dev-tools/developer-profile/SKILL.md'"

# v1.36: 신규 글로벌 SKILL — harness-roadmap-update (Commit 3에서 신설)
check "bootstrap/skills/audit/harness-plan-verify/SKILL.md 존재" \
    "[ -f '$REPO_ROOT/bootstrap/skills/audit/harness-plan-verify/SKILL.md' ]"

# v1.36: install-skills.{sh,ps1} 2단계 lookup 검증
# v1.74: 3-tier 확장 — regex {0,2} + matches multiple paths + sentinel _* 처리
check "install-skills.sh: resolve_skill_name + 0/1/2+ 분기 (v1.74 paths msg)" \
    "grep -q 'resolve_skill_name' '$REPO_ROOT/install-skills.sh' && \
     grep -q 'matches multiple paths' '$REPO_ROOT/install-skills.sh'"

check "install-skills.ps1: Resolve-SkillName + 0/1/2+ 분기 (v1.74 paths msg)" \
    "grep -q 'Resolve-SkillName' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'matches multiple paths' '$REPO_ROOT/install-skills.ps1'"

# ── v1.74: 3-tier 인프라 검증 (R3-1 정적) ────────────────────────────────
check "install-skills.sh: regex {0,2} quantifier (3-tier 허용)" \
    "grep -qF '{0,2}' '$REPO_ROOT/install-skills.sh'"

check "install-skills.ps1: regex {0,2} quantifier (3-tier 허용)" \
    "grep -qF '{0,2}' '$REPO_ROOT/install-skills.ps1'"

check "install-skills.sh: sentinel _* 카테고리 skip 분기" \
    "grep -qF 'in _*)' '$REPO_ROOT/install-skills.sh'"

check "install-skills.ps1: sentinel _* like 분기" \
    "grep -qF -- \"-like '_*'\" '$REPO_ROOT/install-skills.ps1'"

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
        check "tmpdir/.claude/skills/ai-ready-scorer가 symlink (1단계 평탄)" \
            "[ -L '$TMPHOME/.claude/skills/ai-ready-scorer' ]"
        # v1.36: 2단계 source → 1단계 dest (symlink target은 audit/ 카테고리)
        check "symlink target == bootstrap/skills/audit/ai-ready-scorer (2단계 source)" \
            "[ \"\$(readlink '$TMPHOME/.claude/skills/ai-ready-scorer')\" = '$REPO_ROOT/bootstrap/skills/audit/ai-ready-scorer' ]"
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

        # ── v1.74 3-tier dynamic (R3-2: 3-segment fixture / R3-3: sentinel / R3-4: 회귀) ──
        # R3-2: temp 3-tier fixture 생성 → resolve_skill_name 3-segment 입력 검증
        FIXTURE_CAT="$REPO_ROOT/bootstrap/skills/_fixture_cat"
        FIXTURE_PATH="$FIXTURE_CAT/_fixture_sub/test-skill"
        # _* 카테고리는 sentinel이라 enumerate에서 자동 skip되므로 직접 path 검증으로 동작
        # 실제 3-tier 테스트는 정상 카테고리 하위에 임시 fixture 배치
        FIXTURE_REAL="$REPO_ROOT/bootstrap/skills/audit/test-subcat-v74/test-skill-v74"
        mkdir -p "$FIXTURE_REAL"
        cat > "$FIXTURE_REAL/SKILL.md" <<'FIXTURE_EOF'
---
name: test-skill-v74
description: v1.74 smoke fixture — 3-tier resolve test
---
FIXTURE_EOF
        # R3-2: 3-segment 정확 path 입력 → resolve 정상
        TMPHOME3=$(mktemp -d)
        # source-only function 호출 — full install은 skip, regex/lookup만 검증
        # bash 함수 export를 위해 install-skills.sh source 후 resolve_skill_name 직접 호출
        # 단, install-skills.sh는 main 실행 — function-only source 어려움 → grep 기반 정적 검증 + 직접 path 검증
        if [ -f "$FIXTURE_REAL/SKILL.md" ]; then
            LINES+=("✓ R3-2 fixture 생성 audit/test-subcat-v74/test-skill-v74")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ R3-2 fixture 생성 실패")
            FAIL=$((FAIL + 1))
        fi
        # R3-2 동적 install 검증 — 3-segment input 정상 resolve + symlink 생성
        if HOME="$TMPHOME3" bash "$REPO_ROOT/install-skills.sh" audit/test-subcat-v74/test-skill-v74 >/dev/null 2>&1; then
            LINES+=("✓ R3-2 install-skills.sh audit/test-subcat-v74/test-skill-v74 → exit 0")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ R3-2 install-skills.sh 3-tier 입력 실패")
            FAIL=$((FAIL + 1))
        fi
        check "R3-2 ~/.claude/skills/test-skill-v74 1단계 평탄 dest" \
            "[ -L '$TMPHOME3/.claude/skills/test-skill-v74' ] || [ -d '$TMPHOME3/.claude/skills/test-skill-v74' ]"

        # R3-3: sentinel _* prefix 입력 거부
        if ! HOME="$TMPHOME3" bash "$REPO_ROOT/install-skills.sh" _test-invalid >/dev/null 2>&1; then
            LINES+=("✓ R3-3 _test-invalid (sentinel _*) regex 거부")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ R3-3 _test-invalid 거부 실패 (regex 허용 버그)")
            FAIL=$((FAIL + 1))
        fi

        # R3-4: 회귀 — 1-segment legacy 입력이 3-tier fixture 존재 상태에서도 정상 (test-skill-v74)
        TMPHOME4=$(mktemp -d)
        if HOME="$TMPHOME4" bash "$REPO_ROOT/install-skills.sh" test-skill-v74 >/dev/null 2>&1; then
            LINES+=("✓ R3-4 legacy 1-segment input → 3-tier 자동 resolve")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ R3-4 legacy resolve 실패")
            FAIL=$((FAIL + 1))
        fi

        # cleanup
        rm -rf "$FIXTURE_REAL"
        rmdir "$REPO_ROOT/bootstrap/skills/audit/test-subcat-v74" 2>/dev/null || true
        rm -rf "$TMPHOME3" "$TMPHOME4"
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

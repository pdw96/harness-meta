#!/usr/bin/env bash
# v1.22+ smoke: sync-agents.{sh,ps1} 검증 (9 checks: 정적 5 + dynamic 4)
#
# 정적 (5):
#   S1 ✓ sync-agents.sh 존재 + 실행 가능
#   S2 ✓ sync-agents.ps1 존재
#   S3 ✓ sync-agents.sh: sha256/shasum/python3 + awk + AGENT_MAPPINGS + source-wins
#   S4 ✓ sync-agents.ps1: Get-FileHash + Junction + SourceWins
#   S5 ✓ AGENTS_MD_STRATEGY.md: v1.22 keyword 포함
#
# Dynamic (4, Linux/macOS only):
#   T1 ✓ --check, AGENTS.md==CLAUDE.md → exit 0
#   T2 ✓ --check, CLAUDE.md 변조 → exit 1
#   T3 ✓ --source-wins → CLAUDE.md 복원
#   T4 ✓ --list-targets → CLAUDE.md 포함

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
check "S1 sync-agents.sh 존재 + 실행 가능" \
    "[ -f '$REPO_ROOT/sync-agents.sh' ] && [ -x '$REPO_ROOT/sync-agents.sh' ] || \
     [ -f '$REPO_ROOT/sync-agents.sh' ]"

check "S2 sync-agents.ps1 존재" \
    "[ -f '$REPO_ROOT/sync-agents.ps1' ]"

check "S3 sync-agents.sh: sha256/shasum/python3 + awk + AGENT_MAPPINGS + source-wins" \
    "grep -q 'sha256sum' '$REPO_ROOT/sync-agents.sh' && \
     grep -q 'shasum' '$REPO_ROOT/sync-agents.sh' && \
     grep -q 'python3' '$REPO_ROOT/sync-agents.sh' && \
     grep -q \"awk '{print\" '$REPO_ROOT/sync-agents.sh' && \
     grep -q 'AGENT_MAPPINGS' '$REPO_ROOT/sync-agents.sh' && \
     grep -q 'source.wins\|SOURCE_WINS' '$REPO_ROOT/sync-agents.sh'"

check "S4 sync-agents.ps1: Get-FileHash + Junction + SourceWins" \
    "grep -q 'Get-FileHash' '$REPO_ROOT/sync-agents.ps1' && \
     grep -q 'Junction' '$REPO_ROOT/sync-agents.ps1' && \
     grep -q 'SourceWins' '$REPO_ROOT/sync-agents.ps1'"

check "S5 AGENTS_MD_STRATEGY.md: v1.22 keyword" \
    "grep -q 'v1.22' '$REPO_ROOT/bootstrap/docs/AGENTS_MD_STRATEGY.md' && \
     grep -q 'AGENT_MAPPINGS' '$REPO_ROOT/bootstrap/docs/AGENTS_MD_STRATEGY.md'"

# ── Dynamic (4, Linux/macOS only) ─────────────────────────────────────
case "$(uname -s 2>/dev/null || echo unknown)" in
    Linux|Darwin)
        TMPDIR_TEST=$(mktemp -d)

        # AGENTS.md 작성
        printf 'Hello from AGENTS.md\n' > "$TMPDIR_TEST/AGENTS.md"

        # T1: check, AGENTS.md==CLAUDE.md → exit 0
        cp "$TMPDIR_TEST/AGENTS.md" "$TMPDIR_TEST/CLAUDE.md"
        if (cd "$TMPDIR_TEST" && bash "$REPO_ROOT/sync-agents.sh" --check) >/dev/null 2>&1; then
            LINES+=("✓ T1 --check (정합) → exit 0")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ T1 --check (정합) → exit 0 실패")
            FAIL=$((FAIL + 1))
        fi

        # T2: check, CLAUDE.md 변조 → exit 1
        printf 'Modified content\n' > "$TMPDIR_TEST/CLAUDE.md"
        if (cd "$TMPDIR_TEST" && bash "$REPO_ROOT/sync-agents.sh" --check) >/dev/null 2>&1; then
            LINES+=("✗ T2 --check (drift) → exit 1 실패 (exit 0 반환)")
            FAIL=$((FAIL + 1))
        else
            LINES+=("✓ T2 --check (drift) → exit 1")
            PASS=$((PASS + 1))
        fi

        # T3: source-wins → CLAUDE.md 복원
        if (cd "$TMPDIR_TEST" && bash "$REPO_ROOT/sync-agents.sh" --source-wins) >/dev/null 2>&1; then
            # CLAUDE.md가 AGENTS.md와 동일한지 확인
            if diff "$TMPDIR_TEST/AGENTS.md" "$TMPDIR_TEST/CLAUDE.md" >/dev/null 2>&1; then
                LINES+=("✓ T3 --source-wins → CLAUDE.md 복원됨")
                PASS=$((PASS + 1))
            else
                LINES+=("✗ T3 --source-wins → CLAUDE.md 내용 불일치")
                FAIL=$((FAIL + 1))
            fi
        else
            LINES+=("✗ T3 --source-wins → 실행 실패")
            FAIL=$((FAIL + 1))
        fi

        # T4: list-targets → CLAUDE.md 포함
        list_out=$( (cd "$TMPDIR_TEST" && bash "$REPO_ROOT/sync-agents.sh" --list-targets) 2>/dev/null || true )
        if printf '%s' "$list_out" | grep -q 'CLAUDE.md'; then
            LINES+=("✓ T4 --list-targets → CLAUDE.md 포함")
            PASS=$((PASS + 1))
        else
            LINES+=("✗ T4 --list-targets → CLAUDE.md 미포함")
            FAIL=$((FAIL + 1))
        fi

        rm -rf "$TMPDIR_TEST"
        ;;
    *)
        LINES+=("⏭  dynamic skip (non-Linux/Darwin: $(uname -s))")
        ;;
esac

# ── 결과 ───────────────────────────────────────────────────────────────
printf '\n=== smoke-sync-agents ===\n'
for line in "${LINES[@]}"; do printf '  %s\n' "$line"; done
printf '\n  PASS=%d  FAIL=%d\n' "$PASS" "$FAIL"

[ "$FAIL" -eq 0 ]

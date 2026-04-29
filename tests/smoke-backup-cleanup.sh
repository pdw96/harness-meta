#!/usr/bin/env bash
# v1.30+ smoke: install-skills.{sh,ps1} backup cleanup mechanism 검증.
#
# 정적 (10):
#   ✓ install-skills.sh: --cleanup / --cleanup-after / --retain / --grace-days / --yes 플래그
#   ✓ install-skills.sh: distinct_skills() / cleanup_one() / cleanup_all() 함수
#   ✓ install-skills.sh: HARNESS_SKILLS_BACKUP_ROOT env override
#   ✓ install-skills.sh: regex strict ^.+\.[0-9]{8}-[0-9]{6}$ (R4-2)
#   ✓ install-skills.sh: BACKUP_ROOT prefix path traversal guard (R4-1)
#   ✓ install-skills.ps1: -Cleanup / -CleanupAfter / -Retain / -GraceDays / -Yes 파라미터
#   ✓ install-skills.ps1: Get-DistinctSkills / Invoke-CleanupOne / Invoke-CleanupAll 함수
#   ✓ install-skills.ps1: HARNESS_SKILLS_BACKUP_ROOT env override
#   ✓ install-skills.ps1: regex strict + LastWriteTime AddDays 비교
#   ✓ bootstrap/docs/SKILLS.md: §4 "Backup 자동 정리 (v1.30+)" 섹션 + retain/grace/yes 키워드
#
# Dynamic (8, Linux/macOS + Windows Git Bash 위임 모두):
#   Setup: tmpdir에 8 모의 backup 생성 (5 ai-ready-scorer + 2 mindvault + 1 ad-hoc)
#   ✓ Test 1: --cleanup (no --yes) → ERR/WARN, 변경 0 (plan only)
#   ✓ Test 2: --retain 0 --grace-days 0 → ERR (purge guard)
#   ✓ Test 3: --retain 3 --grace-days 30 → 0 deletion (grace 우선)
#   ✓ Test 4: --dry-run + --yes → plan only (dry-run override)
#   ✓ Test 5: --cleanup ai-ready-scorer (단일 skill) → ai-ready-scorer만 처리
#   ✓ Test 6: --cleanup --retain 3 --grace-days 7 --yes → 2 ai-ready-scorer 삭제
#   ✓ Test 7: ad-hoc dir manual-snapshot 보존 (regex strict)
#   ✓ Test 8: 회귀 — bash install-skills.sh --list 변경 무

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

# ── 정적 (10) ──────────────────────────────────────────────────────────
check "install-skills.sh: 5 cleanup 플래그" \
    "grep -q '\-\-cleanup)' '$REPO_ROOT/install-skills.sh' && \
     grep -q '\-\-cleanup-after)' '$REPO_ROOT/install-skills.sh' && \
     grep -q '\-\-retain)' '$REPO_ROOT/install-skills.sh' && \
     grep -q '\-\-grace-days)' '$REPO_ROOT/install-skills.sh' && \
     grep -q '\-\-yes)' '$REPO_ROOT/install-skills.sh'"

check "install-skills.sh: cleanup 함수 3종" \
    "grep -q 'distinct_skills()' '$REPO_ROOT/install-skills.sh' && \
     grep -q 'cleanup_one()' '$REPO_ROOT/install-skills.sh' && \
     grep -q 'cleanup_all()' '$REPO_ROOT/install-skills.sh'"

check "install-skills.sh: HARNESS_SKILLS_BACKUP_ROOT env override" \
    "grep -q 'HARNESS_SKILLS_BACKUP_ROOT' '$REPO_ROOT/install-skills.sh'"

check "install-skills.sh: regex strict 매치 (R4-2)" \
    "grep -F '[0-9]{8}-[0-9]{6}' '$REPO_ROOT/install-skills.sh' >/dev/null"

check "install-skills.sh: BACKUP_ROOT prefix guard (R4-1)" \
    "grep -q 'path traversal guard' '$REPO_ROOT/install-skills.sh'"

check "install-skills.ps1: 5 cleanup 파라미터" \
    "grep -q '\\[switch\\]\\\$Cleanup' '$REPO_ROOT/install-skills.ps1' && \
     grep -q '\\[switch\\]\\\$CleanupAfter' '$REPO_ROOT/install-skills.ps1' && \
     grep -q '\\[switch\\]\\\$Yes' '$REPO_ROOT/install-skills.ps1' && \
     grep -q '\\[int\\]\\\$Retain' '$REPO_ROOT/install-skills.ps1' && \
     grep -q '\\[int\\]\\\$GraceDays' '$REPO_ROOT/install-skills.ps1'"

check "install-skills.ps1: cleanup 함수 3종" \
    "grep -q 'function Get-DistinctSkills' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'function Invoke-CleanupOne' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'function Invoke-CleanupAll' '$REPO_ROOT/install-skills.ps1'"

check "install-skills.ps1: HARNESS_SKILLS_BACKUP_ROOT env override" \
    "grep -q 'HARNESS_SKILLS_BACKUP_ROOT' '$REPO_ROOT/install-skills.ps1'"

check "install-skills.ps1: regex strict + LastWriteTime AddDays" \
    "grep -F '\\.\\d{8}-\\d{6}' '$REPO_ROOT/install-skills.ps1' >/dev/null && \
     grep -q 'AddDays' '$REPO_ROOT/install-skills.ps1' && \
     grep -q 'LastWriteTime' '$REPO_ROOT/install-skills.ps1'"

check "SKILLS.md: §4 backup 자동 정리 (v1.30+) 섹션" \
    "grep -q 'Backup 자동 정리 (v1.30+)' '$REPO_ROOT/bootstrap/docs/SKILLS.md' && \
     grep -q 'retain=3' '$REPO_ROOT/bootstrap/docs/SKILLS.md' && \
     grep -q 'grace-days=7' '$REPO_ROOT/bootstrap/docs/SKILLS.md'"

# ── Dynamic (8) ────────────────────────────────────────────────────────
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT
BR="$TMPDIR/skills"
mkdir -p "$BR"

# Setup: 8 모의 backup (5 ai-ready-scorer + 2 mindvault + 1 ad-hoc)
for entry in \
    "ai-ready-scorer.20260429-120000:1" \
    "ai-ready-scorer.20260428-120000:2" \
    "ai-ready-scorer.20260427-120000:3" \
    "ai-ready-scorer.20260420-120000:10" \
    "ai-ready-scorer.20260410-120000:20" \
    "mindvault.20260429-100000:1" \
    "mindvault.20260415-100000:15" \
    "manual-snapshot:5"; do
    name="${entry%:*}"; days="${entry#*:}"
    mkdir -p "$BR/$name"
    touch -d "$days days ago" "$BR/$name" 2>/dev/null || \
        touch -t "$(date -j -v-${days}d +%Y%m%d%H%M 2>/dev/null || date +%Y%m%d%H%M)" "$BR/$name" 2>/dev/null || true
done

run_clean() {
    HARNESS_SKILLS_BACKUP_ROOT="$BR" bash "$REPO_ROOT/install-skills.sh" --cleanup "$@" 2>&1
}

# Test 1: no --yes (plan only, 변경 없음)
check "Test 1 — --cleanup --retain 3 --grace-days 7 (no --yes) plan only" \
    "out=\$(run_clean --retain 3 --grace-days 7); \
     echo \"\$out\" | grep -qE '(plan|would delete|destructive purge|Yes not specified)' && \
     [ -d '$BR/ai-ready-scorer.20260410-120000' ] && \
     [ -d '$BR/ai-ready-scorer.20260420-120000' ]"

# Test 2: purge guard
check "Test 2 — --retain 0 --grace-days 0 (no --yes) → ERR purge guard" \
    "out=\$(run_clean --retain 0 --grace-days 0); \
     echo \"\$out\" | grep -q 'destructive purge'"

# Test 3: grace 우선
check "Test 3 — --retain 3 --grace-days 30 → 0 deletion (grace 우선)" \
    "out=\$(run_clean --retain 3 --grace-days 30); \
     echo \"\$out\" | grep -q 'delete 0' && \
     [ -d '$BR/ai-ready-scorer.20260410-120000' ]"

# Test 4: --dry-run override --yes
check "Test 4 — --dry-run + --yes → plan only (dry-run override)" \
    "out=\$(run_clean --retain 0 --grace-days 0 --yes --dry-run); \
     echo \"\$out\" | grep -q 'dry-run' && \
     [ -d '$BR/ai-ready-scorer.20260410-120000' ] && \
     [ -d '$BR/mindvault.20260415-100000' ]"

# Test 5: 단일 skill
check "Test 5 — --cleanup ai-ready-scorer (단일 skill) (no --yes) → ai-ready-scorer만 plan" \
    "out=\$(run_clean ai-ready-scorer --retain 1); \
     echo \"\$out\" | grep -q 'ai-ready-scorer:' && \
     ! echo \"\$out\" | grep -q 'mindvault:'"

# Test 6: 실 삭제
check "Test 6 — --retain 3 --grace-days 7 --yes → 2 ai-ready-scorer 삭제" \
    "run_clean --retain 3 --grace-days 7 --yes >/dev/null 2>&1; \
     [ ! -d '$BR/ai-ready-scorer.20260410-120000' ] && \
     [ ! -d '$BR/ai-ready-scorer.20260420-120000' ] && \
     [ -d '$BR/ai-ready-scorer.20260427-120000' ] && \
     [ -d '$BR/ai-ready-scorer.20260428-120000' ] && \
     [ -d '$BR/ai-ready-scorer.20260429-120000' ]"

# Test 7: ad-hoc dir 보존
check "Test 7 — manual-snapshot ad-hoc dir 보존 (regex strict)" \
    "[ -d '$BR/manual-snapshot' ]"

# Test 8: 회귀 — --list 변경 무
check "Test 8 — 회귀: --list 정상 동작" \
    "bash '$REPO_ROOT/install-skills.sh' --list 2>&1 | grep -q 'ai-ready-scorer'"

# ── 결과 ───────────────────────────────────────────────────────────────
echo "=== smoke-backup-cleanup ==="
for line in "${LINES[@]}"; do
    echo "  $line"
done
echo
echo "=== 결과: PASS=$PASS FAIL=$FAIL ==="

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
exit 0

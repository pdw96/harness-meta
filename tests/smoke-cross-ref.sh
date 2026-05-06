#!/usr/bin/env bash
# tests/smoke-cross-ref.sh — living docs cross-ref 정합 검증 (v1.78)
# 도입 세션: sessions/meta/v1.78-cross-ref-smoke-infra/
#
# Stage 1 — living docs cross-ref 추출 + broken ref 검출. FAIL.
# --fix:    broken ref 행 자동 삭제 (.bak 백업, python3 위임)
#
# 검사 대상:
#   - repo .md 파일 전체
#   - 제외: sessions/**/v*-*/*.md  (immutable history — PLAN/REPORT)
#           bootstrap/templates/** (placeholder)
#           bootstrap/skeletons/** (placeholder)
#   - 포함: sessions/CLAUDE.md + sessions/meta/ROADMAP.md (living docs)
#
# 링크 패턴:
#   - @path/to/file.md   → repo root 기준 절대 경로 resolve
#   - [text](path.md)    → 파일 위치 기준 상대 경로 resolve
#
# False positive 제외 (v1.77 L1 Lesson 기반):
#   - ``` ... ``` 코드 블록 내부
#   - `...` inline backtick 내부
#   - http/https/mailto/절대경로 링크
#
# Usage:
#   bash tests/smoke-cross-ref.sh                  # 검증만 (default)
#   bash tests/smoke-cross-ref.sh --fix            # broken ref 행 삭제
#   bash tests/smoke-cross-ref.sh --fix --dry-run  # 계획만 출력
#   bash tests/smoke-cross-ref.sh --help

set -euo pipefail
# v1.83 — pre-commit hook + worktree 호환: git rev-parse 우선
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/harness-meta")}"
cd "$HARNESS_META_ROOT"

FIX_MODE=0
DRY_RUN=0

usage() {
    cat <<'USAGE'
Usage: bash tests/smoke-cross-ref.sh [--fix [--dry-run]]

Default: living docs cross-ref broken ref 검출 → FAIL.

--fix:     broken ref 행 삭제 (.bak 백업, python3 위임)
--dry-run: --fix와 함께 — 변경 없이 계획만 출력
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --fix)     FIX_MODE=1; shift ;;
        --dry-run) DRY_RUN=1; shift ;;
        --help|-h) usage; exit 0 ;;
        --*) echo "Unknown option: $1 (try --help)" >&2; exit 2 ;;
        *)   echo "Unknown argument: $1 (try --help)" >&2; exit 2 ;;
    esac
done

PASS=0; FAIL=0; SKIP=0

# ─── Stage 1 — cross-ref 검출 ─────────────────────────────────────────────────

echo "=== Stage 1 — living docs cross-ref 검출 ==="

# temp file for broken refs (python3 - arg 패턴 — MSYS2 path translation 대응)
TMP_BROKEN=$(mktemp)
trap 'rm -f "$TMP_BROKEN"' EXIT

python3 - "$HARNESS_META_ROOT" "$TMP_BROKEN" <<'PYEOF'
import re
import sys
from pathlib import Path

repo_root = Path(sys.argv[1]).resolve()
out_file  = Path(sys.argv[2])

# 제외 판정 — sessions/**/v*-*/*.md (버전 디렉토리) + milestones/M*/*.md (v1.83+ M-versioned 컨테이너)
_VER_SESS = re.compile(
    r'^(?:sessions/[^/]+/v\d+\.\d+[^/]*|milestones/M\d+[^/]*)/[^/]+\.md$'
)

def should_exclude(p: Path) -> bool:
    rel = p.relative_to(repo_root).as_posix()
    if _VER_SESS.match(rel):
        return True
    if rel.startswith(('bootstrap/templates/', 'bootstrap/skeletons/')):
        return True
    return False

AT_IMPORT = re.compile(
    r'@([\w/._-]+\.(?:md|sh|ps1|toml|json|yaml|yml|py|txt))'
)
MD_LINK = re.compile(r'\[[^\]]*\]\(([^)#\s]+)(?:#[^)]*)?\)')

def extract_broken(content: str, fp: Path) -> list:
    broken = []
    in_code = False
    for lineno, line in enumerate(content.splitlines(), 1):
        # 코드 블록 토글
        if line.lstrip().startswith('```'):
            in_code = not in_code
            continue
        if in_code:
            continue
        # inline backtick 제거 (false positive 차단)
        clean = re.sub(r'`[^`]*`', '', line)

        # @path → repo root 기준 절대 경로 resolve
        for m in AT_IMPORT.finditer(clean):
            target = repo_root / m.group(1)
            if not target.exists():
                broken.append(
                    f"{fp.relative_to(repo_root).as_posix()}:{lineno}: {m.group(0)}"
                )

        # [text](path) → 파일 위치 기준 상대 경로 resolve
        for m in MD_LINK.finditer(clean):
            lnk = m.group(1)
            if lnk.startswith(('http://', 'https://', 'mailto:', '/')):
                continue
            target = (fp.parent / lnk).resolve()
            if not target.exists():
                broken.append(
                    f"{fp.relative_to(repo_root).as_posix()}:{lineno}: {m.group(0)}"
                )

    return broken

results = []
for p in sorted(repo_root.rglob('*.md')):
    if should_exclude(p):
        continue
    try:
        content = p.read_text(encoding='utf-8', errors='replace')
    except Exception:
        continue
    results.extend(extract_broken(content, p))

out_file.write_text(
    '\n'.join(results) + ('\n' if results else ''),
    encoding='utf-8',
    newline='\n',
)
PYEOF

# 결과 처리
BROKEN_COUNT=0
if [ -s "$TMP_BROKEN" ]; then
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        echo "  ✗ $line"
        BROKEN_COUNT=$((BROKEN_COUNT+1))
    done < "$TMP_BROKEN"
fi

if [ "$BROKEN_COUNT" -eq 0 ]; then
    echo "  ✓ broken ref 0건 — PASS"
    PASS=$((PASS+1))
else
    echo "  → broken ref ${BROKEN_COUNT}건 발견"
    FAIL=$((FAIL+1))
fi

# ─── --fix mode ───────────────────────────────────────────────────────────────

if [ "$FIX_MODE" -eq 1 ] && [ "$BROKEN_COUNT" -gt 0 ]; then
    echo
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "=== --fix mode (dry-run) — 삭제 계획 ==="
    else
        echo "=== --fix mode — broken ref 행 삭제 (.bak 백업) ==="
    fi

    python3 - "$HARNESS_META_ROOT" "$TMP_BROKEN" "$DRY_RUN" <<'PYEOF'
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from pathlib import Path
from collections import defaultdict

repo_root    = Path(sys.argv[1]).resolve()
broken_file  = Path(sys.argv[2])
dry_run      = sys.argv[3] == "1"

file_lines: dict = defaultdict(set)
for entry in broken_file.read_text(encoding='utf-8').splitlines():
    if not entry:
        continue
    parts = entry.split(':', 2)
    if len(parts) < 2:
        continue
    try:
        rel_path = parts[0]
        lineno   = int(parts[1])
        file_lines[rel_path].add(lineno)
    except (ValueError, IndexError):
        continue

for rel_path, linenos in file_lines.items():
    target = repo_root / rel_path
    if not target.exists():
        print(f"  [SKIP] {rel_path} — 파일 없음")
        continue

    content = target.read_text(encoding='utf-8', errors='replace')
    lines   = content.splitlines(keepends=True)

    if dry_run:
        for ln in sorted(linenos):
            print(f"  [dry-run] {rel_path}:{ln}: 삭제 예정")
        continue

    # .bak 백업 (idempotent — 이미 있으면 skip)
    bak = Path(str(target) + '.bak')
    if not bak.exists():
        bak.write_text(content, encoding='utf-8', newline='\n')

    # 역순 삭제 (행 번호 이동 방지)
    new_lines = [l for i, l in enumerate(lines, 1) if i not in linenos]
    target.write_text(''.join(new_lines), encoding='utf-8', newline='\n')
    print(f"  ✓ {rel_path}: {len(linenos)}행 삭제 (.bak 저장)")
PYEOF
fi

# ─── 결과 ────────────────────────────────────────────────────────────────────

echo
echo "=== 결과: PASS=${PASS} FAIL=${FAIL} SKIP=${SKIP} ==="

[ "$FAIL" -eq 0 ] && exit 0 || exit 1

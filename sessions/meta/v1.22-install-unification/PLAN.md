# meta v1.22-install-unification — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/PLAN.md) — legacy cleanup overlay-aware 기반 + v1.22 E+C scope 명시 분리

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c 2 (`install-skills.{ps1,sh}` 수정) + S3 2 (`sync-agents.{ps1,sh}` 신규) + S2 2 (`bootstrap/docs/SKILLS.md` + `AGENTS_MD_STRATEGY.md` 갱신) + S3 1 (`README.md`) = **7/7 meta**
- **T1 경로 다수결** — 전체 meta scope
- **T2 스펙 vs 값** — copy mode 정책 + sync-agents 인터페이스 = 모든 프로젝트에 영향

## Scope inheritance (verbatim from v1.21)

**Source — `sessions/meta/v1.21-install-cleanup-foundation/PLAN.md` Out of scope 표 (verbatim)**:

> | install-skills + sync-agents 통합 | **v1.22-install-unification** (E+C 묶음) |
> | copy mode fallback (Windows symlink 권한 부재 시) | v1.22-install-unification |

**Parsed sub-items (2)**:

1. **E: copy mode fallback** — `install-skills.{ps1,sh}`에서 Windows symlink 권한 부재 시 copy 모드로 자동 fallback. 모드 파일 `~/.claude/skills/.harness-install-mode` 기록.
2. **C: sync-agents 통합** — `sync-agents.{ps1,sh}` 신규 생성. AGENTS.md → CLAUDE.md 등 copy 모드 동기화 + SHA-256 drift 감지. `bootstrap/docs/AGENTS_MD_STRATEGY.md` §4.2 "실제 구현: v1.21" → "v1.22"로 갱신.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| verify.sh 신설 + verify.ps1 overlay/frontmatter 통합 | **v1.23-verify-unification** |
| macOS/Linux dynamic CI 검증 (제3 기기) | **v1.24-multi-os-validation** |
| pre-commit hook으로 sync-agents 자동 실행 | 별 후속 evidence-driven |
| sync-agents Windows Developer Mode 심층 분기 | 본 세션은 basic copy fallback — 고급 분기는 v1.22b+ |
| AGENTS.md 다언어 번역본 sync (`AGENTS.ko.md` 등) | v1.5 §8.3 manual policy 유지 + 별 후속 |
| backup 누적 자동 정리 (`~/.claude/backups/skills/`) | 별 후속 evidence-driven |
| `.harness-mode` 파일 per-project 세분화 | 별 후속 (현재는 `~/.claude/skills/.harness-install-mode` 글로벌 단일 파일) |
| sync-agents 리버스 방향 (`target-wins`) 전체 구현 | `warn-and-prompt` (기본) + `--source-wins` 만 v1.22 scope. `target-wins`는 v1.22b+ |
| install-project-claude에 copy mode fallback 적용 | 별 후속 (project-level install은 현재 abort 정책 유지) |
| `sync-agents --list-mappings` / `--status` 서브커맨드 | 별 후속 evidence-driven |

## 1. 문제

### E: copy mode fallback 부재

`install-skills.ps1`은 현재 symlink 생성 실패(Developer Mode OFF + 권한 부재) 시 **abort**. 사용자가 `pwsh` + 권한 없이 설치를 시도하면:

```
[ERR]  symlink creation failed (Developer Mode OFF or no SeCreateSymbolicLinkPrivilege)
```

copy mode fallback이 없으면 Windows 일반 사용자 → global skills 설치 불가. SKILLS.md §6이 "copy mode fallback 검토 → v1.21-cross-platform-install"로 미뤄왔음.

### C: sync-agents 부재

`bootstrap/docs/AGENTS_MD_STRATEGY.md` §4.2는 `sync-agents.{ps1, sh}` 구현 예정을 "(실제 구현: v1.21-cross-platform-install)"로 명시. 그러나 v1.21이 G만 처리 → 구현 이연. 현재 copy 모드로 AGENTS.md → CLAUDE.md 배포한 프로젝트는 **drift 감지 수단이 없음**.

## 2. 결정 (R1 ~ R9) — audit/A1 반영

> audit/A1-analysis.md (D1~D44 + context7) 반영. 변경된 R에 `*` 표시.

### R1 — copy mode fallback 메커니즘 (install-skills.ps1)

**순서**: symlink 시도 → `New-Item -ItemType SymbolicLink` try/catch → copy fallback.

```powershell
try {
    New-Item -ItemType SymbolicLink -Path $dest -Target $src -Force | Out-Null
    # 사후 LinkType 검증 (D2)
    $created = Get-Item -Path $dest -Force
    if ($created.LinkType -ne 'SymbolicLink') { throw "LinkType verification failed" }
    "symlink" | Set-Content $ModeFile   # D9: PS7 기본 UTF-8 NoBOM ✓
    Write-Ok "$Name: symlinked"
} catch {
    Write-Warn "$Name: symlink failed — $($_.Exception.Message)"
    if ($CopyMode -or $true) {   # 자동 fallback
        # $dest 부재 상태에서 Copy-Item → $dest 생성 (D3 확인)
        Copy-Item -Path $src -Destination $dest -Recurse -Force
        "copy" | Set-Content $ModeFile
        Write-Ok "$Name: copied (copy mode)"
    }
}
```

**모드 파일**: `~/.claude/skills/.harness-install-mode`

- dotfile → Claude Code 스캔 대상 아님 (D7 확인) ✓
- 글로벌 단일 파일. `-All` 시 마지막 skill 모드로 덮어써짐 (D11 허용)
- `--list` / `--dry-run` 시 미기록 (D10 보장)
- `.harness-mode` (per-project) 와 명명 충돌 없음 (D8 확인) ✓

**`-CopyMode` 플래그**: 명시 copy 모드. 권한 있어도 copy 원할 때.

```
pwsh install-skills.ps1 -CopyMode        # 명시 copy 모드
pwsh install-skills.ps1                  # symlink 시도 → 실패 시 자동 fallback
```

**Rollback**: try/catch에서 잡힌 경우 backup (`$bak`)에서 `$dest` 복원 (D5).

### R2* — install-skills.sh copy mode + Git Bash 위임 플래그 변환 (D6 bugfix 포함)

Linux/macOS 기본:

```bash
bash install-skills.sh --copy-mode      # 명시 copy 모드
bash install-skills.sh                   # symlink (Linux/macOS 기본)
```

**Git Bash 위임: 전체 플래그 변환 맵 추가 (D6 잠재 버그 해소)**:

현재 `exec pwsh "$META_ROOT/install-skills.ps1" "$@"` → bash `--all` 등을 PS에 그대로 전달 시 positional arg로 파싱될 위험. v1.22에서 `--copy-mode` 추가 기회에 전체 변환 맵 구현:

```bash
_ps_args=()
for arg in "$@"; do
    case "$arg" in
        --all)       _ps_args+=("-All") ;;
        --dry-run)   _ps_args+=("-DryRun") ;;
        --list)      _ps_args+=("-List") ;;
        --copy-mode) _ps_args+=("-CopyMode") ;;
        *)           _ps_args+=("$arg") ;;
    esac
done
exec pwsh "$META_ROOT/install-skills.ps1" "${_ps_args[@]}"
```

### R3 — 모드 파일 스펙

| 파일 | 경로 | 내용 | 작성 시점 |
|------|------|------|---------|
| `.harness-install-mode` | `~/.claude/skills/.harness-install-mode` | `symlink` 또는 `copy` | install-skills 실설치 시만 (DryRun/List 제외) |

### R4* — sync-agents.{ps1,sh} 인터페이스 (META_ROOT 불필요로 단순화)

**위치**: `~/harness-meta/sync-agents.{ps1,sh}`

**실행 위치**: 프로젝트 루트에서 (`<proj>/AGENTS.md` 기준). **`HARNESS_META_ROOT` 불필요** — CWD의 파일만 처리 (D4 수정).

```bash
# project root에서:
bash ~/harness-meta/sync-agents.sh             # drift 감지 + warn-and-prompt
bash ~/harness-meta/sync-agents.sh --source-wins   # AGENTS.md → 덮어쓰기
bash ~/harness-meta/sync-agents.sh --check     # drift 있으면 exit 1 (파일 변경 없음)
bash ~/harness-meta/sync-agents.sh --dry-run   # 계획 출력 (파일 변경 없음)
bash ~/harness-meta/sync-agents.sh --list-targets  # 감지된 대상 목록
```

| 플래그 | 동작 | exit code |
|--------|------|-----------|
| (없음) | warn-and-prompt (비대화형 시 warn + exit 1) | 0=정합, 1=drift+비대화형 |
| `--source-wins` | AGENTS.md → 대상 파일 덮어쓰기 (바이너리 cp) | 0 |
| `--check` | 감지만, 파일 변경 없음 | 0=정합, 1=drift |
| `--dry-run` | 계획 출력, 파일 변경 없음 | 0 |
| `--list-targets` | 현재 CWD의 감지 대상 목록 | 0 |

**AGENTS.md 부재**: exit 1 (D22).

**비대화형 감지** (D19):

- bash: `[ ! -t 0 ] || [ -n "${CI:-}" ]`
- PS: `[Console]::IsInputRedirected -or ($null -ne $env:CI)`
- → warn-and-prompt 모드에서 warn + exit 1 (파일 변경 없음)

### R5* — sync-agents FILE_MAPPINGS + 알고리즘 (D15, D17, D18 반영)

배열명: `AGENT_MAPPINGS` (D5 명확성):

```bash
AGENT_MAPPINGS=(
    "CLAUDE.md"
    "GEMINI.md"
    ".github/copilot-instructions.md"
    ".cursor/rules/main.mdc"
    "CONVENTIONS.md"
    ".clinerules/main.md"
    ".roo/rules/main.md"
)
```

**SHA-256 cross-platform (D15 실증 검증)**:

```bash
# sha256sum 출력: "<hash>  <file>" or "<hash> *<file>" → awk '{print $1}' 안전
if command -v sha256sum >/dev/null 2>&1; then
    hash_of() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
    hash_of() { shasum -a 256 "$1" | awk '{print $1}'; }
else
    hash_of() { python3 -c \
        "import hashlib,sys; print(hashlib.sha256(open(sys.argv[1],'rb').read()).hexdigest())" "$1"; }
fi
```

`cut -d' ' -f1` 대신 `awk '{print $1}'` — sha256sum 이진 모드(`*` prefix) 안정 처리 (D15).

**bash 감지 로직 (D17)**:

```bash
[ -f "$target" ] || continue          # 파일 존재 (broken symlink 자동 제외)
[ -L "$target" ] && { ... skip; }     # symlink → drift check 불필요
target_hash=$(hash_of "$target")
```

**PS 감지 로직 (D18 — Junction 추가)**:

```powershell
$item = Get-Item $target -Force
if ($item.LinkType -in @('SymbolicLink', 'Junction')) { ... skip ... }
```

**source-wins 바이너리 복사 (D20)**:

- bash: `cp -f "AGENTS.md" "$target"` (인코딩 변환 없음)
- PS: `Copy-Item -Path "AGENTS.md" -Destination $target -Force` (바이너리 복사)

### R6* — warn-and-prompt 구현 (D24, D19 반영)

```bash
# bash warn-and-prompt
if [ "$NON_INTERACTIVE" -eq 1 ]; then
    for t in "${DRIFT[@]}"; do color_warn "drift: $t (non-interactive: use --source-wins)"; done
    exit 1
fi

printf '[WARN] drift detected in %d file(s):\n' "${#DRIFT[@]}"
for i in "${!DRIFT[@]}"; do printf '  %d. %s\n' "$((i+1))" "${DRIFT[$i]}"; done

for target in "${DRIFT[@]}"; do
    printf '  %s [y/n/q]: ' "$target"
    read -r answer </dev/tty 2>/dev/null || { color_warn "no TTY, skip $target"; continue; }
    case "$answer" in
        [Yy]) cp -f AGENTS.md "$target"; color_ok "overwritten: $target" ;;
        [Qq]) break ;;
        *)    color_info "skipped: $target" ;;
    esac
done
```

**exit code (D29)**:

- 기본(warn-and-prompt): 사용자 처리 후 exit 0 (intentional skip도 OK)
- `--check`: drift 있으면 exit 1 (CI 파이프라인 의도)
- 비대화형 warn-and-prompt: exit 1

### R7 — 문서 갱신 (항목 확장)

- `bootstrap/docs/SKILLS.md` §5: copy mode 행 추가 (D13)
- `bootstrap/docs/SKILLS.md` §6 OS 분기 표: Windows 권한 부재 → copy fallback (D13 수정)
- `bootstrap/docs/AGENTS_MD_STRATEGY.md` §4.2: "실제 구현: v1.22" + 인터페이스 스펙 + exit code 정책 (D29/D36)
- install-skills.ps1 `.DESCRIPTION` + `.PARAMETER CopyMode` + `.EXAMPLE` (D41)
- install-skills.sh header/Usage copy mode 설명 (D42)

### R8 — Smoke (항목 확장)

**`tests/smoke-skills-install.sh` 갱신** (정적 2건 추가 + dynamic 3건 추가):

정적 추가:

```bash
check "install-skills.ps1: CopyMode + try/catch + harness-install-mode" \
    "grep -q 'CopyMode' '...' && grep -q 'try {' '...' && grep -q 'harness-install-mode' '...'"

check "install-skills.sh: copy-mode + 플래그 변환 맵 + harness-install-mode" \
    "grep -q 'copy.mode' '...' && grep -q '_ps_args' '...' && grep -q 'harness-install-mode' '...'"
```

Dynamic 추가 (Linux — `--copy-mode` 명시):

```bash
HOME="$TMPHOME" bash install-skills.sh --copy-mode ai-ready-scorer
[ ! -L "$TMPHOME/.claude/skills/ai-ready-scorer" ]   # symlink 아님
[ -d  "$TMPHOME/.claude/skills/ai-ready-scorer" ]     # directory ✓
grep -q "copy" "$TMPHOME/.claude/skills/.harness-install-mode"  # 모드 파일
```

**`tests/smoke-sync-agents.sh` 신규** (정적 5 + dynamic 4 = 9 checks):

| # | Check | 방식 |
|---|-------|------|
| S1 | sync-agents.sh 존재 + 실행 가능 | 정적 |
| S2 | sync-agents.ps1 존재 | 정적 |
| S3 | sync-agents.sh: sha256/shasum/python3 + awk + AGENT_MAPPINGS + source-wins + Junction | 정적 |
| S4 | sync-agents.ps1: Get-FileHash + Junction + source-wins | 정적 |
| S5 | AGENTS_MD_STRATEGY.md: v1.22 keyword | 정적 |
| T1 | `--check` AGENTS.md=CLAUDE.md → exit 0 | dynamic |
| T2 | `--check` CLAUDE.md modified → exit 1 | dynamic |
| T3 | `--source-wins` → CLAUDE.md 복원 | dynamic |
| T4 | `--list-targets` → CLAUDE.md 포함 | dynamic |

**`tests/smoke-scope-contract.sh` 갱신**: `v1.22*/PLAN.md` glob 추가 (D43).

**`tests/smoke-skills-install.sh`**: 기존 7건 + 정적 2건 + dynamic 3건 = 12건 (Linux/macOS dynamic 6건).

### R9 — 변경 대상 최종 집계

수정 (4):

- `install-skills.ps1` — R1 (copy mode + CopyMode + 모드 파일 + .DESCRIPTION 갱신)
- `install-skills.sh` — R2* (copy mode + 플래그 변환 맵)
- `bootstrap/docs/SKILLS.md` — R7
- `bootstrap/docs/AGENTS_MD_STRATEGY.md` — R7

신규 (5):

- `sync-agents.sh` — R4~R6*
- `sync-agents.ps1` — R4~R6*, D18
- `tests/smoke-sync-agents.sh` — R8 (9 checks)
- `sessions/meta/v1.22-.../PLAN.md` — 본 파일
- `sessions/meta/v1.22-.../REPORT.md` — 종료 시

갱신 (2):

- `tests/smoke-skills-install.sh` — R8 (+5건)
- `tests/smoke-scope-contract.sh` — R8 (v1.22 glob)

## 3. 변경 대상

### 수정 (4)

| 경로 | scope | 변경 |
|------|------|------|
| `install-skills.ps1` | S1c | R1 — `-CopyMode` 플래그 + symlink catch + copy fallback + `.harness-install-mode` 기록 |
| `install-skills.sh` | S1c | R2 — `--copy-mode` 플래그 + fallback + Git Bash 위임 시 플래그 전달 + `.harness-install-mode` 기록 |
| `bootstrap/docs/SKILLS.md` | S2 | R8 — §5 충돌 정책 + §6 OS 분기에 copy mode 내용 추가 |
| `bootstrap/docs/AGENTS_MD_STRATEGY.md` | S2 | R8 — §4.2 "실제 구현: v1.22" + 인터페이스 스펙 |

### 신규 (5)

| 경로 | scope | 역할 |
|------|------|------|
| `sync-agents.sh` | S3 | R4 — per-project AGENTS.md drift 감지 + sync (bash) |
| `sync-agents.ps1` | S3 | R4 — 동등 PowerShell mirror |
| `tests/smoke-sync-agents.sh` | S3 | R9 — 9 checks |
| `sessions/meta/v1.22-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.22-.../REPORT.md` | meta | 세션 종료 시 |

### 선택 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `README.md` | S3 | R8 — sync-agents 명령 섹션 1줄 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [x] **audit/A1-analysis.md 작성 (D1~D44 + context7)**
- [x] PLAN R 갱신 (audit 반영)
- [ ] **사용자 진입 확인**
- [ ] Stage A — install-skills.ps1 (R1: try/catch + CopyMode + 모드 파일 + SYNOPSIS 갱신)
- [ ] Stage B — install-skills.sh (R2*: --copy-mode + 플래그 변환 맵 + 모드 파일 + header 갱신)
- [ ] Stage C — sync-agents.sh 신규 (R4*~R6*)
- [ ] Stage D — sync-agents.ps1 신규 (R4*~R6*, D18 Junction)
- [ ] Stage E — docs 갱신 (R7: SKILLS.md + AGENTS_MD_STRATEGY.md)
- [ ] Stage F — smoke-skills-install.sh 갱신 (R8: +5건 = 정적2+dynamic3)
- [ ] Stage G — smoke-sync-agents.sh 신규 (R8: 9 checks)
- [ ] Stage H — smoke-scope-contract.sh 갱신 (v1.22 glob)
- [ ] Stage I — smoke 실행 (전체 PASS)
- [ ] Stage J — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] install-skills.ps1: `-CopyMode` + try/catch + copy fallback + `.harness-install-mode` + .DESCRIPTION 갱신
- [ ] install-skills.sh: `--copy-mode` + 플래그 변환 맵(`_ps_args`) + `.harness-install-mode` + header 갱신
- [ ] `sync-agents.sh` 존재 + 실행 가능: sha256/shasum/python3 삼단 + awk + AGENT_MAPPINGS 7건
- [ ] `sync-agents.ps1` 존재: Get-FileHash + Junction skip + source-wins
- [ ] sync-agents `--check`: 정합 exit 0, drift exit 1 (Linux dynamic 검증)
- [ ] sync-agents `--source-wins`: AGENTS.md 내용으로 대상 파일 덮어쓰기 + 검증 (Linux dynamic)
- [ ] sync-agents symlink/junction 파일 skip ✓
- [ ] sync-agents 비대화형(non-TTY) → warn + exit 1 (파일 변경 없음)
- [ ] AGENTS_MD_STRATEGY.md §4.2: "실제 구현: v1.22" + 인터페이스 스펙 갱신
- [ ] SKILLS.md §5+6: copy mode 행 추가
- [ ] smoke-skills-install.sh: +5건 PASS (정적 2 + dynamic copy mode 3)
- [ ] smoke-sync-agents.sh 9/9 PASS
- [ ] smoke-scope-contract.sh v1.22 self-test PASS
- [ ] **회귀 0** — smoke-legacy-cleanup-overlay.sh + smoke-language-overlay.sh PASS 유지

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.22-install-unification — install-skills copy mode + sync-agents

- update: install-skills.{ps1,sh} copy mode fallback + .harness-install-mode 기록 (R1+R2)
- add: sync-agents.{sh,ps1} — per-project AGENTS.md drift 감지 + sync (R4~R7)
- update: bootstrap/docs/SKILLS.md §5+6 copy mode 내용 (R8)
- update: bootstrap/docs/AGENTS_MD_STRATEGY.md §4.2 실제 구현 갱신 (R8)
- update: tests/smoke-skills-install.sh copy mode 2건 (R9)
- add: tests/smoke-sync-agents.sh 9 checks (R9)
- update: tests/smoke-scope-contract.sh v1.22 glob (R9)
- add: sessions/meta/v1.22-.../{PLAN,REPORT}.md

Scope: install-skills copy mode fallback (Windows Developer Mode 불필요) +
       sync-agents per-project AGENTS.md drift 감지.
Smoke: smoke-sync-agents 9/9 + smoke-skills-install 갱신 PASS.
```

## 7. 후속 분기

| 후속 세션 | 포함 | 의존성 |
|-----------|------|------|
| `v1.23-verify-unification` | verify.sh 신설 + verify.ps1 overlay/frontmatter 6축 통합 | v1.22 install 흐름 안정 후 |
| `v1.24-multi-os-validation` | macOS/Linux dynamic CI 검증 | v1.21~v1.23 누적 후 |
| `v1.22b-sync-agents-target-wins` | `target-wins` 정책 + per-project config | sync-agents 실 사용 사례 발생 시 |

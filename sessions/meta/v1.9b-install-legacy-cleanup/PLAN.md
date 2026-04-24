# meta v1.9b-install-legacy-cleanup — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/upbit/v1.1-skills-migration/`](../../upbit/v1.1-skills-migration/REPORT.md)
목적: `install-project-claude.{ps1,sh}`에 **legacy cleanup 로직** 추가. `_base`에서 사라진 카테고리(예: commands)의 프로젝트 local harness-* 파일을 자동 backup. upbit v1.1 세션에서 발견된 수동 `git rm` 재발 방지.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**: 변경 2 파일 (install-project-claude.ps1 + .sh) → **S2**. T1 단일 scope → meta.

## 배경

### upbit v1.1에서 발견된 결함

`install-project-claude.ps1 -Force` 실행 시:
- `_base/.claude/commands/` 부재 (v1.8b에서 삭제됨)
- 스크립트 `$categories`는 4 카테고리 (commands/agents/skills/output-styles)에 대해 루프
- `[ ! -d $srcDir ]` 체크로 **source 없는 카테고리 skip** → upbit `.claude/commands/` 잔존 무관심
- 결과: upbit 6개 legacy commands 수동 삭제 필요

### 해결 방안 — v1.8 install.ps1 패턴 이식

v1.8 install.ps1은 글로벌 `~/.claude/`에서 동일 문제(legacy cleanup) 해결. 패턴:

1. 각 category 디렉토리에 `harness-*` 파일 스캔
2. 현 `$categories` 패턴에 **없는 파일**이면 (legacy)
3. backup 디렉토리로 Move-Item

**install-project-claude 버전**: _base 템플릿과 비교하여 dest에만 있는 `harness-*` 파일을 backup 이동. 단 사용자 custom 파일(harness prefix 아님)은 건드리지 않음.

## 목표

- [ ] `install-project-claude.ps1`에 cleanup 로직 추가 (-Force 시에만 실행)
- [ ] `install-project-claude.sh`에 동일 로직 추가
- [ ] smoke — 임시 디렉토리에 legacy commands + _base skills 혼재 상태 시뮬레이션 → -Force 실행 → commands 자동 cleanup 검증
- [ ] Grey Area 결정
- [ ] 커밋 + push

## 범위

**포함**:
- 2 install-project-claude 스크립트 수정
- smoke 시나리오 신규 (legacy + _base 혼재)
- evidence
- 세션 기록

**제외**:
- 글로벌 install.ps1 수정 (이미 cleanup 있음)
- upbit 재적용 (v1.1에서 완료)

## 변경 대상

### 수정 2

| 파일 | 변경 |
|------|------|
| `bootstrap/install-project-claude.ps1` | cleanup 단계 추가 (-Force 전용) |
| `bootstrap/install-project-claude.sh` | 동일 |

### 신규 evidence 1

`sessions/meta/v1.9b-install-legacy-cleanup/evidence/smoke-legacy.txt`

## 설계 — Cleanup 로직

### 알고리즘

```
IF -Force:
  FOR each category in (commands, agents, skills, output-styles):
    IF dest/<category>/ exists:
      list dest/<category>/harness*
      FOR each file:
        IF file not in _base/<category>/ (source 부재):
          MOVE file → .claude/backup-<ts>/<category>/<file>
      IF dest/<category>/ empty after cleanup:
        rmdir (선택적)
```

### 안전 장치

- `-Force` 플래그 전제 (non-destructive default 유지)
- 패턴은 **`harness*`** 엄격 prefix (사용자 custom 파일 무해)
- backup 이동 (삭제 아님) — 되돌리기 가능
- backup 디렉토리 동일 (`.claude/backup-<ts>/`)

### PowerShell 구현 (핵심)

```powershell
if ($Force) {
    $legacyMoved = @()
    foreach ($cat in $categories) {
        $srcDir = Join-Path $BaseTemplate $cat
        $dstDir = Join-Path $ProjectClaude $cat
        if (-not (Test-Path $dstDir)) { continue }

        # dest에 있는 harness* 파일 목록
        $destItems = Get-ChildItem -Path $dstDir -Filter 'harness*' -Force -ErrorAction SilentlyContinue
        foreach ($d in $destItems) {
            $srcItem = Join-Path $srcDir $d.Name
            # _base에 동일 이름 없으면 legacy
            if (-not (Test-Path $srcItem)) {
                if (-not $backupRoot) {
                    $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
                    $backupRoot = Join-Path $ProjectClaude "backup-$ts"
                    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
                }
                $catBk = Join-Path $backupRoot $cat
                if (-not (Test-Path $catBk)) { New-Item -ItemType Directory -Path $catBk -Force | Out-Null }
                Move-Item -Path $d.FullName -Destination (Join-Path $catBk $d.Name) -Force
                $legacyMoved += "$cat/$($d.Name)"
            }
        }
    }
    if ($legacyMoved.Count -gt 0) {
        Write-Warn "legacy cleanup — $($legacyMoved.Count)건: $($legacyMoved -join ', ')"
    }
}
```

### Bash 구현 (핵심)

```bash
if [ "$FORCE" -eq 1 ]; then
    legacy_moved=()
    for cat in "${categories[@]}"; do
        src="$BASE/$cat"
        dst="$DEST/$cat"
        [ ! -d "$dst" ] && continue
        for d in "$dst"/harness*; do
            [ -e "$d" ] || continue
            name="$(basename "$d")"
            if [ ! -e "$src/$name" ]; then
                # backup_root 지연 생성
                if [ -z "$backup_root" ]; then
                    ts="$(date +%Y%m%d-%H%M%S)"
                    backup_root="$DEST/backup-$ts"
                    mkdir -p "$backup_root"
                fi
                mkdir -p "$backup_root/$cat"
                mv "$d" "$backup_root/$cat/$name"
                legacy_moved+=("$cat/$name")
            fi
        done
    done
    if [ ${#legacy_moved[@]} -gt 0 ]; then
        warn "legacy cleanup — ${#legacy_moved[@]}건: ${legacy_moved[*]}"
    fi
fi
```

## Grey Areas — 결정

| ID | 질문 | 결정 |
|----|------|------|
| G1 | `-Force` 전용 vs 항상 실행 | **`-Force` 전용** — non-destructive default. 우발적 삭제 방지 |
| G2 | 패턴 `harness*` vs 전체 | **`harness*` prefix** — 사용자 custom 무해 |
| G3 | backup 디렉토리 공유 vs 별도 | **공유** (`.claude/backup-<ts>/` 하위 category별) — 기존 충돌 backup과 동일 루트 |
| G4 | 빈 카테고리 디렉토리 rmdir | 미수행 — 복잡 + git 관점 무의미 (빈 디렉토리는 git 추적 안 됨) |
| G5 | legacy 0건 시 출력 | silent (정상 흐름 노이즈 방지) |
| G6 | -Force 없이 legacy 감지 시 | **정보성 WARN만** — "-Force 필요" 안내 |
| G7 | `_base/agents/`는 v1.8b 후 건재 | 정상. cleanup 대상 아님 |
| G8 | cleanup 순서 | **신규 복사 전** (충돌 스캔 후, 복사 전) — 다음 복사에서 동일 파일명이 오면 이미 backup됨 |
| G9 | dry-run 모드 | **본 세션 범위 외** (v1.22+ bootstrap-e2e에서 검토) |
| G10 | smoke 시나리오 | legacy commands 2 + _base skills 2 혼재 → -Force 실행 → commands 2 backup + skills 2 복사 |

## 성공 기준

- [ ] PowerShell + Bash 2 스크립트 cleanup 로직
- [ ] smoke — 임시 디렉토리에 legacy + _base 혼재 시뮬레이션 → -Force 실행 → 기대 출력
- [ ] evidence 저장
- [ ] 기존 smoke (v1.8 smoke-install-project.txt 재현) 회귀 없음
- [ ] Grey Area 10건 결정
- [ ] 커밋 + push

## 커밋 전략

```
feat(meta): sessions/meta/v1.9b-install-legacy-cleanup — install-project-claude legacy cleanup 추가

- update: bootstrap/install-project-claude.ps1
    Step 2.5 cleanup 단계 추가 — -Force 시 _base 부재 카테고리의
    legacy harness-* 파일 자동 backup
- update: bootstrap/install-project-claude.sh — 동일 로직
- add: sessions/meta/v1.9b-install-legacy-cleanup/{PLAN,REPORT,evidence}

upbit v1.1-skills-migration에서 발견 — _base에서 commands 카테고리 삭제
후 upbit .claude/commands/ 6 파일 수동 git rm 필요했던 재발 방지.
Grey Area 10건 결정. smoke PASS.

Non-destructive default — -Force 전용. harness* prefix 엄격.
```

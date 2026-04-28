# meta v1.19-scorer-skill-distribution — REPORT

세션 종료: 2026-04-29
선행 세션: [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/) — score_codebase.py 변경분(57 lines) git 미추적 위치(~/.claude/skills/) 손실 위험. 본 세션이 영구 해소

## 최종 결과

| 항목 | 결과 |
|------|------|
| 신규 디렉토리 규약 | `bootstrap/skills/<name>/` (S1c) — 글로벌 user-skill source 단일화 |
| 첫 이관 skill | ai-ready-scorer (4 파일: SKILL.md + scripts/score_codebase.py + references/rubric.md + evals/evals.json) |
| 신규 배포 스크립트 | `install-skills.{ps1,sh}` opt-in (Windows 자동 .ps1 위임) |
| backup 위치 | `~/.claude/backups/skills/<name>.<ts>/` (외부) |
| 사용자 environment | NTFS symlink (`<SYMLINKD>`) 생성 검증 완료 |
| harness-meta 자기 재스코어 | **93/100 (S)** — v1.18b와 동일 (회귀 0) |
| Smoke | 5/5 PASS (정적). Dynamic은 Linux/macOS 전용 (Windows skip) |

## 구현 요약

### 수정 A — `bootstrap/skills/ai-ready-scorer/` 4 파일 이관

```bash
cp -r ~/.claude/skills/ai-ready-scorer/ ~/harness-meta/bootstrap/skills/
```

이관 source가 git 미추적이라 `git mv` 의미 0 → `cp` 채택 (PLAN R1).

### 수정 B — `install-skills.sh` (Windows 위임 + backup 외부 + symlink 검증)

```bash
# Windows 감지 시 .ps1 위임 (Git Bash ln -s 디렉토리 복사 fallback 회피)
case "$(uname -s 2>/dev/null || echo unknown)" in
    MINGW*|MSYS*|CYGWIN*)
        if command -v pwsh >/dev/null 2>&1; then
            exec pwsh "$META_ROOT/install-skills.ps1" "$@"
        else
            color_err "Install PowerShell 7+ or run install-skills.ps1 directly."
            exit 3
        fi
        ;;
esac
```

backup 위치 외부화:
```bash
BACKUP_ROOT="$HOME/.claude/backups/skills"
mv "$dest" "$BACKUP_ROOT/$name.$ts"
```

symlink 검증:
```bash
if [ ! -L "$dest" ]; then
    color_err "$name: symlink creation failed"
    [ -d "$bak" ] && mv "$bak" "$dest"   # rollback
    return 1
fi
```

### 수정 C — `install-skills.ps1` (LinkType 검증 + backup 외부)

```powershell
$BackupRoot = Join-Path $HOME '.claude\backups\skills'
$bak = Join-Path $BackupRoot "$Name.$ts"

New-Item -ItemType SymbolicLink -Path $dest -Target $src -Force
$created = Get-Item -Path $dest -Force
if ($created.LinkType -ne 'SymbolicLink') {
    Write-Err "${Name}: symlink creation failed (LinkType=$($created.LinkType))"
    # rollback: backup 복원
    Move-Item -LiteralPath $bak -Destination $dest -Force
    return
}
```

### 수정 D — 문서 (SKILLS.md + OWNERSHIP S1c + README + CLAUDE.md)

- `bootstrap/docs/SKILLS.md` 신설 (10 §): 디렉토리 규약 + frontmatter 표준 + install-skills 사용법 + 충돌 정책 + OS 분기 (Git Bash ln -s fallback 동작 명시) + v1.18b → v1.19 이관 사례 + 다른 skill 추가 절차 + 후속 분기
- `bootstrap/docs/OWNERSHIP.md`: S1c 행 추가 + Evolution "글로벌 user-skill 신설 (2026-04-29 v1.19)" §
- `README.md`: 설치 Stage 3 § (선택, opt-in)
- `CLAUDE.md`: 디렉토리 구조 트리 + "관련 문서" SKILLS.md cross-ref

### Stage D' — 사용자 environment cleanup + 재install

```bash
# 1. v2 PLAN 결과 cleanup
rm -rf ~/.claude/skills/ai-ready-scorer                              # cp 사본 삭제
mkdir -p ~/.claude/backups/skills
mv ~/.claude/skills/ai-ready-scorer.bak-20260429-030700 \
   ~/.claude/backups/skills/ai-ready-scorer.20260429-030700          # 외부 위치 이전

# 2. v3 install-skills.ps1 직접 실행 (Windows)
pwsh ~/harness-meta/install-skills.ps1
# → [OK] ai-ready-scorer: symlinked ... (LinkType=SymbolicLink)
```

### 검증

```
$ cmd /c dir ~/.claude/skills | grep ai-ready
2026-04-29 ... <SYMLINKD>     ai-ready-scorer [C:\Users\qkreh\harness-meta\bootstrap\skills\ai-ready-scorer]
                              ^^^^^^^^^^^^^^ NTFS symbolic link directory ✓

$ python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py ~/harness-meta --json-only
total=93.0 grade=S
automation=13/15 A   ← v1.18b 결과 그대로 (회귀 0)
```

## 사후 결함 + 해결 (v3 정정)

### 결함 1 — Git Bash `ln -s` fallback to copy

PLAN v2 위험 표 #1은 "Windows symlink 권한 부재"로 가정했으나, 실제 결함은 다른 영역.

**검증** (실측):
```bash
# 기본 환경 (MSYS=unset, MSYSTEM=MINGW64)
$ ln -sfn /tmp/_t_src /tmp/_t_link
$ ls -la /tmp/_t_link
drwxr-xr-x ...    # ← 디렉토리 (l 아님)

# MSYS=winsymlinks:nativestrict 설정 시
$ MSYS=winsymlinks:nativestrict ln -sfn ...
$ ls -la /tmp/_t_link
lrwxrwxrwx ... -> /tmp/_t_src    # ← 정상 NTFS symlink ✓
```

→ Cygwin/MSYS 호환층의 의도적 정책 (symlink 권한이 있어도 기본은 copy). PowerShell `New-Item -ItemType SymbolicLink`만 NTFS symlink 직접 생성.

**해결**: install-skills.sh가 Windows 감지 시 자동 `pwsh install-skills.ps1` 위임.

### 결함 2 — backup이 ~/.claude/skills/ 내부에서 SKILL.md 자동 인식

context7 `/zebbern/claude-code-guide` 인용: "Personal skill: `~/.claude/skills/<skill-name>/SKILL.md`. detection 기준 = SKILL.md 존재." backup prefix 무시 정책 없음.

**증상**: v2 실행 후 system-reminder에 ai-ready-scorer 두 번 등록 (현재 + .bak-20260429-030700) — 이중 invocation 충돌.

**해결**: backup 위치를 `~/.claude/skills/` → **`~/.claude/backups/skills/`** 외부로 이동. 이후 system-reminder에서 backup 사라짐 검증 ✓.

## 판정 (PLAN v3 체크박스)

| 목표 | 결과 |
|------|:---:|
| `bootstrap/skills/ai-ready-scorer/` 4 파일 존재 | ✅ |
| `install-skills.ps1` + `.sh` 작성 + 실행 가능 | ✅ |
| install-skills.sh Windows 감지 → .ps1 자동 위임 | ✅ |
| backup 위치 외부화 (`~/.claude/backups/skills/`) | ✅ |
| symlink 정상 검증 + 실패 시 rollback | ✅ |
| `bootstrap/docs/SKILLS.md` 10 § 작성 | ✅ |
| `OWNERSHIP.md` S1c 행 추가 + Evolution § 추가 | ✅ |
| `README.md` Stage 3 § 추가 | ✅ |
| `CLAUDE.md` cross-ref 추가 | ✅ |
| `tests/smoke-skills-install.sh` 5/5 PASS | ✅ |
| 사용자 environment: NTFS symlink (`<SYMLINKD>`) 생성 | ✅ |
| harness-meta 재스코어: 93/100 (S) 회귀 0 | ✅ |

## Lessons Learned

- **L1 — Windows Git Bash `ln -s` 동작은 권한이 아닌 MSYS 모드 의존**: 기본 모드(`MSYS=` unset)에서 디렉토리 복사 fallback. 사전 PLAN에서 권한만 위험으로 분류해 결함 미인지. 실측 또는 context7 검증으로 사후 발견. → 향후 Windows symlink 작업 시 PowerShell 직접 호출이 안전 default.

- **L2 — Skill detector는 디렉토리 위치가 SKILL.md 존재 기반**: backup prefix(`*.bak-*`) 자동 무시 안 함 (context7 docs 미정의). backup은 항상 `~/.claude/skills/` 외부에 보관. 본 세션이 표준 디렉토리(`~/.claude/backups/skills/`) 명시.

- **L3 — Source 단일화의 본질은 symlink, copy로는 무산**: cp 모드는 source 변경 시 매번 install 재실행 필요 → "단일 source" 의도 약화. NTFS symlink (`<SYMLINKD>`) 또는 POSIX symlink만 의도 충족.

- **L4 — install 스크립트 마지막에 자체 검증 의무**: symlink 생성 후 즉시 LinkType/`-L` 확인. 실패 시 명시적 에러 + backup 복원 rollback. silent fail 차단의 결정적 mechanism.

- **L5 — PLAN 위험 분석은 사후 발견 결함을 위해 v3 정정 가능**: PLAN v2의 "권한 부재" 가정은 실측에서 부정확. 사용자 보고 후 v3 정정 + 정확한 위험 (MSYS 기본 모드 + skill detector) 등록 → 향후 작업의 학습 자산.

- **L6 — context7으로 외부 spec 검증**: Anthropic 공식 docs(`/websites/code_claude`)에 skill detection 영역 explicit 정의 부재 → 커뮤니티 가이드(`/zebbern/claude-code-guide`)로 보완. 권위가 약하지만 부재보단 가치 있는 신호.

## 다음 후보 (보류 — 후속 분기)

| 항목 | 조건 |
|------|------|
| `v1.18c-scorer-package-manifest-na` | 본 세션 후 git 보호 하에 진행. multi-repo evidence 1+ 시 |
| `v1.18d-scorer-stdout-encoding` | cp949 fix 1줄. 본 세션 후 |
| `v1.18e-scorer-html-na-ui` | HTML UI + multi-repo 회귀 sample |
| `v1.21-cross-platform-install` | install-skills + sync-agents 통합. Linux/macOS dynamic 검증. copy mode fallback. **본 세션의 .sh→.ps1 위임 패턴을 sync-agents에도 적용 검토** |
| `v1.20-other-global-skills-migration` | mindvault 등 이관 (사용자 명시 요청 시) |
| `v1.22-skills-categories` | `bootstrap/skills/<category>/<name>/` 2단계 구조. evidence 5+ 후 |

## 사용자 후속 권장

1. **backup 디렉토리 정리** (수동):
   ```bash
   ls ~/.claude/backups/skills/
   # 확인 후 불필요한 backup 디렉토리 수동 삭제
   ```

2. **다른 기기 재설치** (예: 새 PC clone 시):
   ```bash
   git clone https://github.com/pdw96/harness-meta ~/harness-meta
   pwsh ~/harness-meta/install.ps1                       # 글로벌 레이어
   pwsh ~/harness-meta/install-skills.ps1                # 글로벌 user-skill (선택)
   ```

3. **다른 글로벌 skill 추가** (mindvault 등): `bootstrap/skills/<new-name>/` 신설 + `install-skills` 재실행. 절차는 SKILLS.md §8 참조.

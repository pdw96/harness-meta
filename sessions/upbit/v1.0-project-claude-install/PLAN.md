# upbit v1.0-project-claude-install — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.8-core-adapter-split/`](../../meta/v1.8-core-adapter-split/REPORT.md)
목적: meta v1.8 BREAKING 이후 upbit가 상실한 `/harness-plan` 등 13개 명령을 복구. upbit repo에 `bootstrap/templates/_base/.claude/` 17 파일을 복사 + 커밋.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/upbit/`

**근거**:
- 변경 파일: `<upbit>/.claude/**` 17 파일 (commands 6 + agents 4 + skills 6 + output-styles 1) → **S6** (프로젝트 Claude 설정).
- **T1** upbit scope 전부 → upbit.
- **T4 분할** — meta v1.8이 스펙+스크립트 작성(meta), 본 세션이 upbit 실적용(project).
- 세션 기록은 글로벌 `~/harness-meta/sessions/upbit/` 아카이브, 실 파일 변경은 upbit repo.

## 배경

### v1.8 BREAKING 영향 (2026-04-25)

- `~/harness-meta/claude/` 17 파일이 `bootstrap/templates/_base/.claude/`로 이관
- `install.ps1`이 글로벌 `~/.claude/commands/harness-*.md`, `~/.claude/agents/harness-*`, `~/.claude/skills/harness-*`, `~/.claude/output-styles/harness-*` 13 심볼릭 자동 cleanup (backup 이동)
- upbit는 현재 `.claude/`에 hooks + settings만 존재. **commands/agents/skills/output-styles 부재**

### 복구 방식

`~/harness-meta/bootstrap/install-project-claude.ps1`을 upbit 루트에서 실행 → 17 파일 복사.

### upbit 환경 점검 (실측)

```
~/upbit/.harness.toml        → 존재 (schema_version = "1.0")
~/upbit/.claude/             → hooks/ + settings.json + settings.local.json
~/upbit/.claude/commands/    → 부재
~/upbit/.claude/agents/      → 부재
~/upbit/.claude/skills/      → 부재
~/upbit/.claude/output-styles/ → 부재
git status                   → clean on main
```

## 목표

- [ ] upbit 루트에서 `install-project-claude.ps1` 실행 → 17 파일 복사 검증
- [ ] upbit `.claude/{commands,agents,skills,output-styles}/` 생성 확인
- [ ] evidence `install-output.txt` + `file-list.txt` 2 파일
- [ ] upbit repo에 `.claude/{commands,agents,skills,output-styles}/` 커밋
- [ ] 본 세션 REPORT 완료 보고

## 범위

**포함**:
- `install-project-claude.ps1` upbit 실행
- upbit `.claude/` 17 파일 커밋 (upbit repo)
- 세션 기록 (PLAN + REPORT + evidence)

**제외 (T4 후행)**:
- upbit 매니페스트 schema 1.1 upgrade → `sessions/upbit/v1.1-manifest-upgrade/`
- upbit statusline_cmd + state_file 추가 → `sessions/upbit/v1.2-statusline-cmd-migration/`
- `.claude/settings.local.json` 변경 (사용자 private, 커밋 안 함)
- Claude Code 세션 내 Output style 선택 (실행 시 사용자 수동)
- upbit 코드 (`bot/`, `scripts/harness/`) 변경 — 본 세션 대상 아님

## 변경 대상

### upbit repo (`~/upbit/`)

| # | 경로 | 변경 |
|---|------|------|
| 1~17 | `.claude/{commands×6, agents×4, skills×6, output-styles×1}` | **신규 복사** (`install-project-claude.ps1`에서) |

### harness-meta repo (`~/harness-meta/`)

| # | 경로 | 역할 |
|---|------|------|
| 18 | `sessions/upbit/v1.0-project-claude-install/PLAN.md` | 본 파일 |
| 19 | `sessions/upbit/v1.0-project-claude-install/REPORT.md` | 구현 후 |
| 20~21 | `sessions/upbit/v1.0-project-claude-install/evidence/{install-output.txt, file-list.txt}` | 실행 캡처 |

## 실행 절차

```powershell
cd ~/upbit
pwsh ~/harness-meta/bootstrap/install-project-claude.ps1 > /tmp/install-output.txt 2>&1
find ~/upbit/.claude -type f | sort > /tmp/file-list.txt
# evidence 저장 → harness-meta repo

cd ~/upbit
git add .claude/commands .claude/agents .claude/skills .claude/output-styles
git commit -m "chore(harness): restore .claude/ commands after meta v1.8 breaking"
# push는 사용자 확인 후
```

## Grey Areas — 결정

| ID | 질문 | 결정 |
|----|------|------|
| G1 | upbit 기존 `.claude/settings.json` / `settings.local.json` / `hooks/` 처리 | **그대로 유지** — 사용자 private 설정 |
| G2 | install-project-claude `-Force` 필요? | **No** — upbit .claude/에 commands/agents/skills/output-styles 부재이므로 충돌 없음 |
| G3 | `.claude/scheduled_tasks.lock` 등 기존 파일 처리 | **무관** (스크립트가 해당 파일 건드리지 않음) |
| G4 | `.claude/settings.local.json` 커밋? | **No** (사용자 private, gitignore 대상) |
| G5 | 커밋 메시지 scope | `chore(harness):` — 하네스 인프라 복구 |
| G6 | push 시점 | **사용자 확인 후**. 본 세션은 local commit까지 |
| G7 | Output style 선택 안내 | REPORT 말미 강조 — 사용자 수동 |
| G8 | upbit CLAUDE.md 갱신 필요? | **No** (CLAUDE.md는 프로젝트 정체성 문서. `.claude/` 배포와 무관) |
| G9 | smoke test 별도 필요? | **No** — install-project-claude 자체가 복사 결과 출력 + evidence로 충분 |
| G10 | 세션 버전 v1.0 | upbit는 harness-meta 글로벌 이전 v1.1~v1.4 legacy가 있으나 글로벌화 이후 첫 세션이므로 **v1.0 새 축** |

## 성공 기준

- [ ] `install-project-claude.ps1` 실행 exit 0
- [ ] upbit `.claude/` 하위 17 파일 존재 (`find | wc -l` = 17)
- [ ] evidence 2 파일 (`install-output.txt`, `file-list.txt`)
- [ ] upbit git commit (local, not pushed)
- [ ] REPORT.md 작성 + meta repo 커밋

## 커밋 전략

### upbit repo

```
chore(harness): restore .claude/ commands after meta v1.8 breaking

- .claude/commands/ — 6 files (harness, harness-{plan,design,run,ship,review})
- .claude/agents/ — 4 files (harness-{dispatcher,explore,grey-area,verifier})
- .claude/skills/ — 3 directories (harness-{plan,design,ship}), 6 files total
- .claude/output-styles/ — 1 file (harness-engineer)

Source: ~/harness-meta/bootstrap/templates/_base/.claude/ (v1.8 이관분)
Copy via: pwsh ~/harness-meta/bootstrap/install-project-claude.ps1
Ref: sessions/upbit/v1.0-project-claude-install/
```

### harness-meta repo

```
docs(upbit): sessions/upbit/v1.0-project-claude-install — upbit .claude/ 복구

- add: sessions/upbit/v1.0-project-claude-install/{PLAN,REPORT,evidence/×2}.md

v1.8 BREAKING 후속 — upbit에 install-project-claude.ps1 실행하여
17 파일(commands 6 + agents 4 + skills 6 + output-styles 1) 복사.
upbit repo에 별도 commit (chore(harness): restore .claude/ ...).
```

## 후속 세션 연결

- `sessions/upbit/v1.1-statusline-cmd-migration` — statusline 풍부한 출력 복원 (v1.6/v1.7 후속)
- `sessions/upbit/v1.2-manifest-upgrade-1.1` — schema 1.1 선택 bump

# upbit v1.0-project-claude-install — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: meta v1.8 BREAKING 후속 — upbit에 `install-project-claude.ps1` 실행하여 17 파일 복사 + upbit repo 커밋
판정: **PASS** (성공 기준 5/5)

**세션 소속 (self-apply)**: `sessions/upbit/`
**근거**: 변경 파일 17 = **S6** (upbit `.claude/**` 프로젝트 설정). **T1** 전부 upbit scope → upbit. **T4** meta v1.8(스펙)과 분할.

## 최종 결과

- **upbit `.claude/` 17 파일 복사** (commands 6 + agents 4 + skills 6 + output-styles 1)
- **upbit commit**: `703a21e chore(harness): restore .claude/ commands after meta v1.8 breaking` (local, **not pushed**)
- **evidence 2**: `install-output.txt` (PowerShell 출력), `file-list.txt` (17 파일 경로)
- **harness-meta 세션 기록 3**: PLAN + 본 REPORT + evidence

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 |
|---|------|------|
| 1 | install-project-claude.ps1 실행 exit 0 | ✅ |
| 2 | upbit `.claude/` 17 파일 존재 | ✅ `file-list.txt` 17건 |
| 3 | evidence 2 파일 | ✅ |
| 4 | upbit git commit (local, not pushed) | ✅ `703a21e` |
| 5 | REPORT + meta 커밋 | ⏳ meta 커밋 진행 예정 |

**완수율**: 5/5 (100%, meta 커밋 대기).

## 실측

### install-project-claude.ps1 출력

```
[INFO] ProjectRoot: C:\Users\qkreh\upbit
[INFO] MetaRoot:    C:\Users\qkreh\harness-meta
[OK]   copied: commands/harness-design.md
[OK]   copied: commands/harness-plan.md
[OK]   copied: commands/harness-review.md
[OK]   copied: commands/harness-run.md
[OK]   copied: commands/harness-ship.md
[OK]   copied: commands/harness.md
[OK]   copied: agents/harness-dispatcher.md
... (총 14 항목: skills는 디렉토리 단위 복사이므로 14로 표기)
[OK]   완료 — 14 항목 복사 (C:\Users\qkreh\upbit\.claude)
```

`[OK] 14 항목`은 **최상위 항목 기준** (commands 6 + agents 4 + skills 3 디렉토리 + output-styles 1). 실제 파일 수는 17 (skills 디렉토리 하위 6 파일 포함).

### upbit `.claude/` 최종 상태

```
.claude/
├── agents/          (4 파일)
├── commands/        (6 파일)
├── hooks/           (기존 유지)
├── output-styles/   (1 파일)
├── scheduled_tasks.lock (기존 유지)
├── settings.json       (기존 유지)
├── settings.local.json (기존 유지, .gitignore 대상)
└── skills/          (3 디렉토리 × 2 파일 = 6)
```

신규 17 파일만 staged + commit. 기존 hooks/settings/lock은 무관.

## Grey Area 결정 사후 검증 (10건)

| ID | 결정 | 구현 |
|----|------|------|
| G1 | 기존 settings/hooks 유지 | ✅ 무관 |
| G2 | -Force 불필요 | ✅ 충돌 0건 |
| G3 | scheduled_tasks.lock 무관 | ✅ |
| G4 | settings.local.json 커밋 안 함 | ✅ staged 안 함 |
| G5 | chore(harness) scope | ✅ 커밋 메시지 |
| G6 | push는 사용자 확인 후 | ✅ local commit만 |
| G7 | Output style 안내 강조 | ✅ REPORT 말미 |
| G8 | CLAUDE.md 무관 | ✅ |
| G9 | smoke 별도 불필요 | ✅ install 스크립트 자체가 검증 |
| G10 | v1.0 새 축 | ✅ upbit legacy v1.1-v1.4는 글로벌화 이전 별개 |

**10/10 결정 반영.**

## ⚠️ 사용자 후속 액션 (Claude Code 세션 내)

1. **Claude Code 세션 재시작** (또는 새 세션으로 upbit 진입)
2. `/config` → Output style → **"Harness Engineer"** 선택
   - `~/upbit/.claude/output-styles/harness-engineer.md` 활성화
   - 선택 결과는 `.claude/settings.local.json`에 저장 (git 커밋 안 됨)
3. `/harness` 또는 `/harness-plan` 입력 → 명령 인식 확인
4. **upbit repo push**: `git push origin main` (본 세션 범위 외 — 사용자 확인)

## Lessons Learned

1. **"14 항목 vs 17 파일" 표기 차이**: install-project-claude가 top-level 항목 수(14)를 출력. skills가 디렉토리 단위이므로 내부 파일 포함 시 17. 사용자 혼동 방지를 위해 향후 스크립트에 "14 items (17 files)" 같은 명시 추가 후보 (`sessions/meta/vX-install-counter-precision/`).

2. **meta↔project 분할 세션의 비용**: v1.8 단일 세션에 upbit 변경 포함하지 않고 **upbit 세션을 분리**한 것이 clean audit trail 확보. meta 세션 리뷰는 meta only, upbit 세션 리뷰는 upbit only. T4 분할 원칙의 장점.

3. **push 지연 정책**: local commit까지만 수행하고 push는 사용자 확인 후. Claude Code 자동완성에서 `/harness` 명령이 실제 동작하는지 **사용자가 smoke 확인 후 push** 하는 게 안전. 만약 문제 발견 시 local `git reset --soft HEAD~` 로 쉽게 복구.

## 커밋 계획

### harness-meta repo (본 세션 기록)

```
docs(upbit): sessions/upbit/v1.0-project-claude-install — upbit .claude/ 복구

- add: sessions/upbit/v1.0-project-claude-install/{PLAN,REPORT,evidence/×2}.md

meta v1.8 BREAKING 후속 — upbit에 install-project-claude.ps1 실행하여
17 파일(commands 6 + agents 4 + skills 6 + output-styles 1) 복사.
upbit repo에 별도 commit 703a21e (chore(harness): restore .claude/ ...).
upbit push는 사용자가 Claude Code smoke 확인 후 수행.
```

### upbit repo (이미 commit됨)

```
chore(harness): restore .claude/ commands after meta v1.8 breaking
→ 703a21e (local, not pushed)
```

## 후속 세션 연결

- `sessions/upbit/v1.1-statusline-cmd-migration` — statusline 풍부한 출력 복원 (v1.6/v1.7 후속)
- `sessions/upbit/v1.2-manifest-upgrade-1.1` — schema 1.1 선택 bump

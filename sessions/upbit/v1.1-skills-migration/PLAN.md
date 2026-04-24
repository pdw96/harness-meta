# upbit v1.1-skills-migration — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.8b-commands-to-skills-migration/`](../../meta/v1.8b-commands-to-skills-migration/REPORT.md)
목적: meta v1.8b (commands→skills 통합) 반영을 위해 upbit `.claude/` 재배포 + legacy commands 파일 수동 제거 + `.claude/backup-*/` gitignore + 커밋.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/upbit/`

**근거**:
- 변경 파일: `<upbit>/.claude/**` (commands 6 삭제 + skills 3 신규 + skills 3 수정 + backup 1 gitignore) + `<upbit>/.gitignore` → **S6** 전부.
- **T1** upbit scope 전부 → upbit.
- **T4** meta v1.8b(스펙)와 분할.

## 배경

### v1.8b 적용 시 발견된 gap

`install-project-claude.ps1 -Force` 실행 결과:
- _base에 없는 카테고리(commands) → install 스크립트가 **skip**
- upbit `.claude/commands/harness*.md` 6개 **stale 잔존**
- skills 3 수정 + skills 3 신규 정상 복사
- 8건 backup (기존 skills 3 + 예외 5) → `.claude/backup-20260425-024716/`

### 수동 복구 필요

1. `.claude/commands/` 6 파일 `git rm` (해당 명령은 이제 skills에서 제공)
2. `.claude/backup-*/` 디렉토리 `.gitignore` 추가 (일회성 백업)
3. 신규/변경 skills commit

### install-project-claude 보강 (후속 meta 세션)

`install-project-claude.{ps1,sh}`에 "_base에 없지만 upbit에 있는 legacy harness-* 파일 자동 backup" 로직 추가 → `sessions/meta/vX-install-legacy-cleanup/` (별도 세션, 본 세션 범위 외).

## 목표

- [ ] upbit `.claude/commands/` 6 파일 `git rm`
- [ ] upbit `.gitignore`에 `.claude/backup-*/` 추가
- [ ] 신규 + 변경 skills 파일 add
- [ ] upbit repo commit (local, not pushed)
- [ ] meta repo에 본 세션 PLAN/REPORT 커밋

## 범위

**포함**:
- upbit `.claude/commands/` 삭제
- upbit `.gitignore` 갱신
- upbit skills 변경분 commit

**제외 (후속)**:
- install-project-claude 보강 → meta 별도 세션
- `.claude/backup-20260425-024716/` 삭제 여부 — 사용자 수동 (gitignore만 추가, 실 파일 유지)
- push — 사용자 확인 후

## 변경 대상

### upbit repo

| 동작 | 경로 | 파일 수 |
|------|------|--------|
| `git rm` | `.claude/commands/harness{,-plan,-design,-run,-ship,-review}.md` | 6 |
| 수정 staged | `.claude/skills/harness-{plan,design,ship}/SKILL.md` | 3 |
| 신규 | `.claude/skills/{harness,harness-run,harness-review}/SKILL.md` | 3 |
| 수정 | `.gitignore` (`.claude/backup-*/` 추가) | 1 |

### harness-meta repo

| 경로 | 역할 |
|------|------|
| `sessions/upbit/v1.1-skills-migration/PLAN.md` | 본 파일 |
| `sessions/upbit/v1.1-skills-migration/REPORT.md` | 구현 후 |
| `sessions/upbit/v1.1-skills-migration/evidence/final-state.txt` | upbit `.claude/` 최종 상태 |

## Grey Areas — 결정

| ID | 질문 | 결정 |
|----|------|------|
| G1 | backup 디렉토리 유지 여부 | 유지 (사용자 수동 삭제 가능). `.gitignore`로 git 추적만 차단 |
| G2 | backup 파일 안의 내용은 meta session에 수집? | No — 이미 git history로 충분 (v1.0-project-claude-install에 commit됨) |
| G3 | install-project-claude 보강은 본 세션? | No — meta 별도 세션 (T4) |
| G4 | commands 6 삭제로 슬래시 UX 영향 | skill의 `name: harness-plan` 으로 slash 이름 동일 유지 → 영향 없음 |
| G5 | push 시점 | 사용자 확인 후 |

## 성공 기준

- [ ] upbit `.claude/commands/` 부재
- [ ] upbit `.claude/skills/` 6 디렉토리 (harness, harness-plan, harness-design, harness-run, harness-ship, harness-review)
- [ ] `.gitignore`에 `.claude/backup-*/` 존재
- [ ] upbit commit (local)
- [ ] meta session 기록 commit + push

## 커밋 전략

### upbit repo

```
chore(harness): migrate .claude/ commands→skills per meta v1.8b

- rm: .claude/commands/ (6 files) — legacy deprecated by Anthropic
- add: .claude/skills/harness{,-run,-review}/SKILL.md (3 new)
- update: .claude/skills/harness-{plan,design,ship}/SKILL.md (name 수정 + 통합)
- update: .gitignore — .claude/backup-*/ 제외

Source: pwsh ~/harness-meta/bootstrap/install-project-claude.ps1 -Force
Ref: harness-meta sessions/meta/v1.8b-commands-to-skills-migration/
```

### harness-meta repo

```
docs(upbit): sessions/upbit/v1.1-skills-migration — commands→skills 적용

meta v1.8b 후속 — upbit에 install-project-claude -Force 실행 후 수동 정리.
install 스크립트가 _base 부재 카테고리를 skip하는 한계 발견 →
후속 메타 세션에서 legacy cleanup 로직 추가 예정.
```

# upbit v1.1-skills-migration — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: meta v1.8b(commands→skills) 반영. upbit `.claude/commands/` 6 삭제 + skills 6 정리 + backup gitignore
판정: **PASS** (성공 기준 5/5)

**세션 소속 (self-apply)**: `sessions/upbit/`
**근거**: 변경 전부 `<upbit>/.claude/**` + `<upbit>/.gitignore` → **S6**. T1 upbit scope → upbit. T4 meta v1.8b와 분할.

## 최종 결과

- **upbit commit**: `a535053 chore(harness): migrate .claude/ commands→skills per meta v1.8b` (local, not pushed)
- **rename 3** (git rename-detect): harness, harness-run, harness-review
- **delete 3**: harness-design, harness-plan, harness-ship (기존 skills와 merge로 rename 임계 미달 → delete+modify로 표시. 내용은 skills에 통합됨)
- **modified 3**: skills/harness-{plan,design,ship}/SKILL.md
- **.gitignore**: `.claude/backup-*/` 추가
- **final state**: skills 9 파일(6 SKILL + 3 template) + agents 4 + output-styles 1 = 14. commands 0.

## Install-project-claude 한계 발견

본 세션 진행 중 실측:
- `install-project-claude.ps1 -Force` 실행 시 **`_base`에 없는 카테고리(commands)는 skip**
- 결과: upbit `.claude/commands/` 6개 **stale 잔존** → 수동 `git rm` 필요

**후속 meta 세션**: `sessions/meta/vX-install-legacy-cleanup/` — install-project-claude에 v1.8 install.ps1의 legacy cleanup 패턴 이식.

## Lessons Learned

1. **Copy 기반 스크립트의 "삭제 대응" 어려움**: install-project-claude는 source→dest 복사만. source에 사라진 파일이 dest에 잔존하는 경우 무관심.

2. **.gitignore `.claude/backup-*/` 유효**: `-Force` 시 타임스탬프 backup 누적 → git 추적 차단.

3. **git rename-detect 임계 가변**: 3개는 commands→skills 1:1 이동 → rename 감지. 3개는 기존 template-role SKILL.md와 merge → delete+modify. 이력은 `git log --follow`로 추적 가능.

## 후속

- `sessions/meta/vX-install-legacy-cleanup` — install-project-claude에 legacy cleanup 로직
- v1.10-bootstrap-interview — detect + interview + `.harness.toml` 자동 생성

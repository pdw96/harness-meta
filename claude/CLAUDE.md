# claude/ 모듈 가이드

글로벌 레이어 source. `~/.claude/{commands,hooks,statusline}/`로 symlink 배포되는 3 카테고리.

상위 진입: [`../CLAUDE.md`](../CLAUDE.md)

## 디렉토리 구성

```
claude/
├── commands/
│   └── harness-meta.md             # /harness-meta 슬래시 명령 (메타 세션 진입)
├── hooks/
│   ├── session-init.sh             # SessionStart hook (.harness.toml 감지 → additionalContext 주입)
│   └── post-report-write.sh        # PostToolUse hook (Edit/Write/MultiEdit/NotebookEdit 감지 → SKILL invoke 안내)
└── statusline/
    └── statusline.sh               # 실시간 phase/step 표시 (CWD .harness.toml 감지)
```

## 핵심 규약

### 배포 메커니즘

`install.ps1`이 본 디렉토리의 3 카테고리를 `~/.claude/{commands,hooks,statusline}/`로 symlink. 충돌 시 `-Force` 플래그로 `~/.claude/backup-<ts>/` 이동 후 덮어쓰기.

**정기 재실행 시 `-Force` 불필요** — `settings.json`의 `hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]` 모두 idempotent no-op. 파일 symlink 자체 충돌 시에만 `-Force` 필요.

### Hook 정책

#### SessionStart (`session-init.sh`)

- CWD `.harness.toml` 감지. 부재 시 빈 출력으로 종료 (no-op)
- 매니페스트 핵심 필드 grep+sed 추출 → additionalContext JSON 주입
- bash-only — Windows에서도 Git Bash 사용

#### PostToolUse (`post-report-write.sh`)

- 매처: `Write|Edit|MultiEdit|NotebookEdit`
- 현행 패턴 (v2.0+ 9-stage 이후): `projects/meta/milestones/v{X.Y}/(INTENT|RESEARCH|DESIGN|APPROVE|VERIFY|REPORT|PROPOSE|execute/phase-{n})\.md$` (v3.0+ 9-stage-bundled era) + `v{X.Y}_{slug}/` (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage 보존, 7-stage 는 PLAN.md). 진화 이력: v1.1_post-report-write-hook-update 에서 4-tier `sessions/*/REPORT.(md|ipynb)$` → 7-stage 패턴, v2.0_workflow-word-fidelity 에서 9-stage 패턴, v3.0_milestones-restructure 에서 9-stage-bundled `v{X.Y}/` 패턴 흡수.
- `python3` 미설치 시 grep fallback (R1 WARN), 양쪽 파서 실패 시 silent NOOP 차단 (R2 WARN)

### Statusline (`statusline.sh`)

- CWD `.harness.toml` 부재 시 빈 출력 → Claude Code default statusline 사용
- 매니페스트 `statusline_cmd` 정의 시 해당 명령 실행 (timeout 3000ms)
- 빈 정의 또는 명령 실패 시 minimal `[harness] {name}` fallback

### 슬래시 명령 (`commands/harness-meta.md`)

- 본 repo의 **유일한 글로벌 슬래시 명령**. 메타 세션 진입점
- frontmatter `allowed-tools:` YAML list
- model `sonnet` (라우팅 책임) + effort 미명시 (default `high` inherit)
- argument 분기: `meta` / `<name>` (Bootstrap 모드는 첫 milestone EXECUTE에서 처리)

## 작업 가이드

### Hook 추가 시

1. `claude/hooks/<new-hook>.sh` 작성 (bash-only, LF 라인 종결)
2. `install.ps1`의 hooks symlink 패턴이 `*.sh`로 모든 .sh 자동 흡수
3. `settings.json` 등록은 install.ps1 idempotent merge (matcher-level lookup) — 별도 수동 설정 불필요
4. `tests/smoke-posttooluse-hook.sh` 또는 신규 smoke로 dynamic 검증
5. `verify.{ps1,sh}` 갱신

### 슬래시 명령 추가 시

- `claude/commands/<name>.md` 추가 → `install.ps1`이 symlink로 `~/.claude/commands/`에 배포
- frontmatter `allowed-tools:` YAML list 의무
- model + effort 책임 기반 선택 (라우팅=sonnet / 논의=opus xhigh)

### Statusline 변경 시

- 본 repo `statusline.sh`는 글로벌 default — 프로젝트별 statusline은 매니페스트 `statusline_cmd` 필드로 override
- 매니페스트 unset 시 본 default 사용 → 모든 프로젝트 영향 (BREAKING 가능)

## CRITICAL 제약

- **bash-only**: hook + statusline 모두 Windows에서 Git Bash 의존. PowerShell 7+ install 자체는 다른 영역
- **LF 라인 종결**: CRLF로 commit 시 `$'\r': command not found` 오류. `.gitattributes`에 `*.sh text eol=lf` 명시
- **legacy harness-* 자동 cleanup**: install.ps1이 구 symlink 자동 정리

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md)
- 글로벌 user-skill 디렉토리: [`../bootstrap/skills/CLAUDE.md`](../bootstrap/skills/CLAUDE.md)

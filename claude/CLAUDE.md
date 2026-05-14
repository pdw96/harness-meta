# claude/ 모듈 가이드

글로벌 레이어 source. v5.0+ `.claude-plugin/plugin.json` paths 명시 (`commands: ["./claude/commands/"]` replace-default + `hooks: "./claude/hooks/hooks.json"`) 으로 Plugin install 시 자동 인식. statusline 은 Plugin spec 안 직접 매핑 부재 — `~/.claude/settings.json` 안 명시 메커니즘 보존 (Plugin manifest 외).

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

### 배포 메커니즘 (v5.0 Plugin spec 채택)

`.claude-plugin/plugin.json` 안 `commands: ["./claude/commands/"]` (replace-default agents/commands 패턴) + `hooks: "./claude/hooks/hooks.json"` paths 명시 — Plugin install (`claude plugin install harness-meta@harness-meta`) 후 Claude Code 가 본 디렉토리 안 .md / .sh 파일 자동 인식. Plugin source 거주 위치 = `~/.claude/plugins/cache/harness-meta/claude/{commands,hooks,statusline}/`.

statusline 은 Plugin spec 안 직접 매핑 부재 (Complete Plugin Manifest Schema 검증, context7) — `~/.claude/settings.json` 안 `statusLine` 필드 명시 메커니즘 보존 (Plugin manifest 외 mechanism). 사용자 환경 안 settings.json 안 명시 1줄: `"statusLine": { "type": "command", "command": "${HOME}/.claude/plugins/cache/harness-meta/claude/statusline/statusline.sh" }` 또는 동치 — README 안 narrative 의무 (v5.0 cascade narrative 정합).

**Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — v4.1 D7 5 step sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup retention) 안 `~/.claude/{commands,hooks,statusline}/` 매핑은 historical 만 보존. Plugin install lifecycle 채택 = Developer Mode 의존 0 + OS 분기 narrative 자연 폐기. 자세히: [`../bootstrap/agents/CLAUDE.md`](../bootstrap/agents/CLAUDE.md) § Install/Update/Cleanup 책임.

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

### Hook 추가 시 (v5.0+)

1. `claude/hooks/<new-hook>.sh` 작성 (bash-only, LF 라인 종결)
2. `claude/hooks/hooks.json` 안 matcher + command 항목 추가 — `${CLAUDE_PLUGIN_ROOT}/claude/hooks/<new-hook>.sh` 형식
3. Plugin install 환경 안 `claude plugin enable harness-meta` 또는 Claude Code 재시작 후 자동 인식
4. `tests/smoke-posttooluse-hook.sh` 또는 신규 smoke로 dynamic 검증

### 슬래시 명령 추가 시 (v5.0+)

- `claude/commands/<name>.md` 추가 → `.claude-plugin/plugin.json` 안 `commands: ["./claude/commands/"]` add-to-directory 패턴 자연 인식. plugin.json 갱신 불요 (디렉토리 명시 안 nested 인식).
- frontmatter `allowed-tools:` YAML list 의무
- model + effort 책임 기반 선택 (라우팅=sonnet / 논의=opus xhigh)

### Statusline 변경 시

- 본 repo `statusline.sh`는 글로벌 default — 프로젝트별 statusline은 매니페스트 `statusline_cmd` 필드로 override
- 매니페스트 unset 시 본 default 사용 → 모든 프로젝트 영향 (BREAKING 가능)

## CRITICAL 제약

- **bash-only**: hook + statusline 모두 Windows에서 Git Bash 의존. Plugin install lifecycle 자체는 다른 영역.
- **LF 라인 종결**: CRLF로 commit 시 `$'\r': command not found` 오류. `.gitattributes`에 `*.sh text eol=lf` 명시
- **legacy ~/.claude/{commands,hooks,statusline}/ cleanup**: v4.x SymbolicLink/Junction 잔존 시 manual cleanup 권고 (자세히: [`../README.md`](../README.md#installation)). v5.0+ Plugin install 시 `~/.claude/plugins/cache/harness-meta/` 안 거주 = 자연 분리.

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md)
- 글로벌 user-skill 정책·매트릭스: [`../bootstrap/skills/CLAUDE.md`](../bootstrap/skills/CLAUDE.md) (narrative-only container, 실 skill = `../skills/`)

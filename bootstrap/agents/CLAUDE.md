# bootstrap/agents/ 모듈 가이드

글로벌 subagent + agent team 의 source-of-truth 디렉토리. `~/.claude/agents/` 는 본 디렉토리의 symlink (또는 copy mode 사본). `bootstrap/skills/` 두 층 패턴 정확 정합.

상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)

## 두 층 구조 (v4.0_harness-composer-pivot, 2026-05-13)

`harness-meta` 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 정합:

| Layer | 거주지 | 용도 | 사용자 |
|---|---|---|---|
| 글로벌 | `bootstrap/agents/<category>/<name>/` → `~/.claude/agents/<name>/` | 보편 subagent / team (어느 프로젝트든 유용) | 모든 사용자, 모든 프로젝트 |
| 프로젝트 특화 | `projects/<name>/.claude/agents/<name>/` | 도메인 특화 (예: upbit 의 trade-strategy-reviewer) | 해당 프로젝트만 |

본 디렉토리 (`bootstrap/agents/`) = 글로벌 source-of-truth. 프로젝트 특화는 각 프로젝트 repo 의 `.claude/agents/`.

## 매트릭스 (placeholder — v4.0 첫 멤버 추가는 phase-5)

| 카테고리 | Team / Subagent | 책임 | 권한 | model |
|---|---|---|---|---|
| `audit/` | `project-harness-audit-team/` (v4.0 phase-5 신규 예정, 5 멤버) | 프로젝트 분석 + harness component proposal + e3 apply | read + write (component-installer 만) | sonnet (installer 만 opus) |
| `dev-tools/` | (placeholder, 후속 발의 시 추가) | — | — | — |

매트릭스 갱신 — 새 team/subagent 추가 시 본 표에 row 추가 의무.

## 디렉토리 구조 (`bootstrap/skills/` 패턴 정합)

```text
bootstrap/agents/
├── CLAUDE.md                       # 본 파일
├── audit/                          # 검증·평가·분석 카테고리
│   └── <team-name>/                # team 디렉토리 (멤버 N markdown + CLAUDE.md orchestration)
│       ├── CLAUDE.md               # team orchestration narrative
│       ├── <member-1>.md           # subagent 정의 (yaml frontmatter + system prompt)
│       └── <member-N>.md
└── dev-tools/                      # 개발 도구·context 카테고리 (placeholder)
```

**Reserved**: `_*` prefix 는 sentinel — `bootstrap/skills/` 정합. install 시 자동 거부 (`component-installer` mechanical sequence 안 검증).

## Install / Update / Cleanup 책임 (v4.0 B3, component-installer 흡수)

v4.0 정체성 = **static install script 부재**. 모든 mechanical 작업은 agent (`component-installer`) 또는 메인 Claude 가 Bash 으로 진행.

### Component-installer mechanical sequence (D7)

1. **Backup 우선** — 기존 `~/.claude/agents/<name>/` 존재 시 `~/.claude/backups/agents/<name>.<YYYYMMDD-HHMMSS>/` git mv (또는 Move-Item)
2. **Symlink 시도** — Bash `New-Item -ItemType SymbolicLink -Path ~/.claude/agents/<name> -Target <repo>/bootstrap/agents/<category>/<name>` (Windows Developer Mode 의무, macOS/Linux 기본 동작)
3. **Symlink 실패 시 copy fallback** — 권한 또는 OS 제약 시 `Copy-Item -Recurse -Force` 또는 `cp -r`
4. **Cleanup retention** — default retain 3 backup + grace 7 days, `--yes` flag 으로 실 삭제 (default dry-run)

`component-installer` system prompt 안 허용 Bash 명령 화이트리스트: `New-Item` / `Copy-Item` / `Remove-Item` / `Move-Item` / `Test-Path` / `Get-ChildItem` (D1 security mitigation).

### 첫 진입 (~/.claude/ 비어있을 때)

clone 후 사용자 Claude Code 안 자연어 호출 — `harness-meta 설치해줘` (또는 영어 동치). 메인 Claude session 이 `~/.claude/{commands,hooks,statusline,skills,agents}/` 자동 구성. `README.md` + root `CLAUDE.md` 안 onboarding 1줄 instruction.

## Conflict Resolution 4 case 매트릭스 (v4.0, e3 정책)

Custom (`bootstrap/agents/` 안 정의) vs Claude Code built-in (`code.claude.com/docs/en/sub-agents` 안 신규/개선) 충돌 시 결정 매트릭스:

| Case | 조건 | 권장 결정 |
|---|---|---|
| Superset | Built-in 이 custom 의 모든 기능 포함 + 추가 | **delete custom**, use built-in |
| 유사 다른 책임 | Built-in vs custom 유사한데 책임 다름 | **keep custom + add built-in** (mix) |
| 부분 cover | Built-in 이 custom 의 일부만 cover | **mix** (built-in default + custom 보완) |
| 무관 책임 | Built-in vs custom 책임 무관 | **둘 다 keep** |

결정 과정 = e3 정책 (audit → propose → 사용자 명시 결정 → apply). `project-harness-audit-team` (phase-5) 안 `harness-gap-analyzer` (detect) + `component-proposer` (proposal) 가 자동 진단 + 사용자 명시 결정 대기 + `component-installer` 가 apply.

## Agent Fleet Lifecycle 5 case 매트릭스 (v4.0, e3 정책)

Agent fleet 자체의 evolution (시간 경과 + 사용 패턴 변화):

| Case | Trigger | 권장 결정 |
|---|---|---|
| scope 확장 | 기존 agent 책임 외 자연 발견 case 누적 | 멤버 system prompt 안 책임 확장 (단순 Edit) |
| scope 분할 | agent 너무 광범위, context 부담 | 1 agent → 2 agent 분리 (예: scanner ↔ analyzer 분리) |
| 신규 추가 | 현 fleet 미커버 case + GitHub 인기 패턴 발견 | 신규 멤버 또는 신규 team 정의 |
| 통합 | 중복/유사 agent 책임 겹침 | 2 agent → 1 agent 통합 (책임 합) |
| 삭제 | built-in 으로 대체 / 사용 안 함 | agent 디렉토리 삭제 + ~/.claude/agents/ symlink 제거 |

결정 과정 = e3 정책 동일. `harness-gap-analyzer` detect + `component-proposer` 5 case 매트릭스 기반 proposal + 사용자 결정 + `component-installer` apply.

## 벤치마크 cycle (v4.0 phase-7 신규)

`schedule` skill 활용 주 1회 cron — GitHub 인기 repo (anthropics/* + 인기 agentic) + Claude Code release notes/changelog 검토. 산출물 host = `projects/meta/ROADMAP.md` 안 `candidate_draft[]` 신 필드 (D4 확정, schema_note 안 entry schema 정전화).

### Routine 등록 패턴 (schedule skill)

Claude Code 안 자연어 호출:

```text
schedule 명령으로 'harness-meta 주간 벤치마크' routine 등록해줘.
주기: 매주 월 09:00 (cron: 0 9 * * 1).
실행: project-harness-audit-team 호출 후 GitHub 인기 repo 분석 + Claude Code
release notes 검토 + 결과를 projects/meta/ROADMAP.md candidate_draft[] 에 append.
```

`/schedule` skill 이 본 prompt 를 받아 `~/.claude/scheduled_tasks` 안 cron entry 자동 생성. 본 repo 외부 — routine 정의는 사용자 환경 의존.

### 벤치마크 산출물 3축

1. **GitHub 인기 패턴 도입 candidate** (`category: "github-pattern"`) — 외부 repo (anthropics/* + 인기 agentic 예: `anthropics/courses`, `openai/swarm`, `microsoft/autogen` 등) 의 agent/hook/skill 패턴 차용 검토
2. **Claude Code release notes 신규 built-in command 도입 candidate** (`category: "claude-code-update"`) — `https://code.claude.com/docs/en/changelog` (또는 동치 source) 정기 검토 + Conflict Resolution 4 case 매트릭스 자동 적용
3. **Fleet evolution proposal** (`category: "fleet-evolution"`) — 본 repo 내 agent fleet 의 scope 확장/분할/통합/삭제 case detect (`harness-gap-analyzer` 5 case 매트릭스)

### Candidate draft entry 예시

```json
{
  "id": "introduce-swarm-pattern",
  "title": "OpenAI Swarm-style handoff 패턴 도입 검토",
  "source": "https://github.com/openai/swarm",
  "detected_at": "2026-05-20",
  "rationale": "본 repo 의 5 멤버 team 순차 sequence 와 비교 — swarm handoff 가 더 dynamic. fleet evolution 5 case 중 'scope 분할' candidate.",
  "category": "github-pattern",
  "decision_pending": true
}
```

사용자 명시 결정 후 → milestones[] 정식 등재 (e3 정책 정합 — propose → 사용자 결정 → milestone EXECUTE).

## 신규 subagent / team 추가 절차

1. **카테고리 결정** — `audit/` (검증·평가·분석) 또는 `dev-tools/` (개발 도구·context)
2. **`bootstrap/agents/<category>/<name>/` 디렉토리 생성** — yaml frontmatter + system prompt 형식 (code.claude.com/docs/en/sub-agents 권장)
3. **team 일 때 `<name>/CLAUDE.md` 추가** — orchestration narrative (호출 순서 + 사용자 게이트 between proposer/installer + 결과 통합)
4. **milestone 기록** — `projects/meta/milestones/v{X.Y}/` 9-stage
5. **본 모듈 매트릭스 1 row 추가**
6. **사용자 환경 배포** — Claude Code 안 자연어 호출 (`<team-name> 설치해줘` 또는 `harness-meta 설치해줘`) → `component-installer` 또는 메인 Claude 가 Bash 으로 symlink 생성 (D7 sequence)

## 작업 시 주의

- **Source-of-truth 규약**: `bootstrap/agents/` 만 git tracking. `~/.claude/agents/` 는 symlink (또는 copy 사본) — git 대상 외
- **Backup 위치**: `~/.claude/backups/agents/<name>.<YYYYMMDD-HHMMSS>/` (agents/ 외부 필수 — 내부 두면 Claude Code 가 backup 도 활성 agent 로 인식)
- **subagent yaml frontmatter** — `name` + `description` + `tools` + (옵션) `model` 필수. `code.claude.com/docs/en/sub-agents` 권장 형식
- **agent team CLAUDE.md** — orchestration sequence + 사용자 게이트 명시 (e3 정책 적용)

## 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- 두 층 패턴 reference: [`../skills/CLAUDE.md`](../skills/CLAUDE.md) (글로벌 user-skill 동일 패턴)
- 메타 ARCHITECTURE: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 3.1 끝 (정체성 단일 source)
- v4.0 milestone INTENT: [`../../projects/meta/milestones/v4.0/INTENT.md`](../../projects/meta/milestones/v4.0/INTENT.md)
- v4.0 DESIGN (D7 mechanical sequence): [`../../projects/meta/milestones/v4.0/DESIGN.md`](../../projects/meta/milestones/v4.0/DESIGN.md)
- code.claude.com primary source: context7 library ID `/websites/code_claude` (7393 snippets, score 81.68)
- agent teams docs: `https://code.claude.com/docs/en/agent-teams`
- subagents docs: `https://code.claude.com/docs/en/sub-agents`

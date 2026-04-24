# meta v1.8-core-adapter-split — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.7-manifest-schema-v1.1/`](../v1.7-manifest-schema-v1.1/REPORT.md)
목적: `claude/` 글로벌 레이어의 **구조적 분리**. 하네스 실행 명령·agents·skills·output-styles 17 파일을 **프로젝트 소유** `bootstrap/templates/_base/.claude/`로 이관. `harness-meta.md` + hooks + statusline만 글로벌 잔존. Claude Code 자동완성 노이즈 제거 + 프로젝트별 자율성 확보.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `claude/**` 축소(17 이관 + 3 잔존) + `bootstrap/templates/_base/.claude/**` 신규 + `install.ps1` + `verify.ps1` + `bootstrap/install-project-claude.{ps1,sh}` + `bootstrap/templates/_base/README.md` + `bootstrap/docs/OWNERSHIP.md` + `README.md`/`CLAUDE.md`/`AGENTS.md` → **S1** + **S2** + **S3** 복합.
- **T1** meta scope 다수결. **T2** 구조 스펙은 repo-global → meta.
- upbit 실제 복구(프로젝트 `.claude/` 설치)는 **T4 후행 세션** `sessions/upbit/vX-project-claude-install/`.

## 배경

### 사용자 아키텍처 전환 (2026-04-25)

- 현: `~/harness-meta/claude/`에 모든 하네스 명령 글로벌 배치 → 글로벌 symlink 일괄 배포
- 문제: `.harness.toml` 없는 프로젝트에서도 `/harness-plan` 등이 슬래시 자동완성 노출 → 무관 프로젝트 개발자 노이즈
- 목표: `.harness.toml` 있는 프로젝트에서만 하네스 명령 제공

### Claude Code 공식 문서 검증 (context7)

[code.claude.com/docs/en/agent-sdk/slash-commands](https://code.claude.com/docs/en/agent-sdk/slash-commands):

> Project commands … stored in `.claude/commands/` **(legacy format, prefer `.claude/skills/`)**.
> Personal commands … stored in `~/.claude/commands/` **(legacy format, prefer `~/.claude/skills/`)**.

**함의**:
- **`.claude/commands/` 는 Anthropic 공식 legacy 선언** (2026-04 기준)
- **`.claude/skills/` 가 preferred format**
- v1.8은 **과도기적 이관** — commands 그대로 옮김. 장기적으로 **v1.8b-commands-to-skills-migration** 등 후행 세션에서 skills 통합 재설계

**추가 공식 확인**:
- `.claude/output-styles/` — "**project-scoped, team-wide styles**" (harness-engineer가 정확히 이 케이스) ✅
- `.claude/skills/` 자동 discovery — `settingSources: ["user", "project"]` 기본 ✅
- user + project settings **동시 로드** — scope 분리 (override 아님) ✅
- namespacing subdirectory 가능 (`.claude/commands/harness/plan.md` → `/plan (project:harness)`) — **flat 유지 결정**

### 새 구조

| 위치 | 파일 | 배포 방식 |
|------|------|----------|
| `~/harness-meta/claude/commands/harness-meta.md` | 1 | **글로벌 symlink** 유지 |
| `~/harness-meta/claude/hooks/session-init.sh` | 1 | **글로벌 symlink** 유지 |
| `~/harness-meta/claude/statusline/statusline.sh` | 1 | **글로벌 symlink** 유지 |
| `~/harness-meta/bootstrap/templates/_base/.claude/**` | 17 | **프로젝트 복사** (commands 6 + agents 4 + skills 6 + output-styles 1) |

### 깨지는 효과 — BREAKING

현 upbit 사용자: 글로벌 symlink로 `/harness-plan` 등 받는 상태. v1.8 배포 후:
1. `install.ps1` 재실행 → **cleanup 단계**가 broken/legacy symlink 13개 자동 제거 (backup 이동)
2. upbit 프로젝트에 `.claude/` 부재 → `/harness-plan` **명령 미인식**
3. **복구 필수**: 사용자가 별도 세션에서 `pwsh ~/harness-meta/bootstrap/install-project-claude.ps1 ~/upbit` 실행

**세션 종료 직후 사용자 액션 2단계**:
1. `pwsh ~/harness-meta/install.ps1` (글로벌 업데이트 — cleanup)
2. `cd ~/upbit && pwsh ~/harness-meta/bootstrap/install-project-claude.ps1` (upbit 복구)

### 디렉토리 이름 — `_base/`

- `templates/default/`: language-neutral 의미 불명
- `templates/_common/`: 철자
- **`_base/`** 채택 — underscore 예약 관례, 언어별 variant 오버라이드 의도 명확

### Copy 방식 (symlink 아님)

- Windows `core.symlinks=false` 기본 문제 회피 (v1.5b AGENTS.md 결정 동일)
- 프로젝트 drift 허용 (자율성 feature)
- 중앙 sync는 별도 도구 (보류)

## 목표

- [ ] 17 파일 **`git mv`** — `claude/**` → `bootstrap/templates/_base/.claude/**` (이력 보존)
- [ ] `claude/` 잔존 3 파일 + 빈 카테고리 디렉토리(`agents/`, `skills/`, `output-styles/`) **완전 삭제**
- [ ] `install.ps1` 재작성 — **cleanup 단계 추가** (broken/legacy symlink 자동 제거 + backup), `$categories` 6→3
- [ ] `verify.ps1` 재작성 — A2 3 카테고리, B2 3 파일, B7 재정의(삭제 또는 `_base/` 대상)
- [ ] `bootstrap/install-project-claude.ps1` 신규 — PowerShell, `-Force` 지원, Output style 선택 안내
- [ ] `bootstrap/install-project-claude.sh` 신규 — bash, chmod +x
- [ ] `bootstrap/templates/_base/README.md` 신규 — _base 설명 + commands legacy 경고
- [ ] `bootstrap/docs/OWNERSHIP.md` — **S1a/S1b split** + S6 확장 + Evolution 조항 + commands legacy 인지
- [ ] `README.md` / `CLAUDE.md` / `AGENTS.md` — 2단계 설치 안내
- [ ] smoke `evidence/smoke-install-project.txt` — 임시 디렉토리에 install-project-claude 실행 PASS
- [ ] 기존 `~/.claude/` 실 상태에서 cleanup 실측 (실제 broken 제거 확인)
- [ ] verify.ps1 재실행 PASS (새 기준)
- [ ] Grey Area 45건 결정 기록
- [ ] 커밋 + push (`!` BREAKING 태그)

## 범위

**포함**:
- `claude/` 축소 + `bootstrap/templates/_base/.claude/` 신설 (17 `git mv`)
- install.ps1 재작성 (cleanup 추가)
- verify.ps1 재작성 (기대값 축소)
- `bootstrap/install-project-claude.{ps1,sh}` 2 파일
- `bootstrap/templates/_base/README.md` 1 파일
- 문서 4개 갱신 (OWNERSHIP, README, CLAUDE, AGENTS)
- smoke + evidence

**제외 (T4 후행)**:
- **upbit `.claude/` 실제 설치** → `sessions/upbit/vX-project-claude-install`
- **commands → skills 통합** → `sessions/meta/v1.8b-commands-to-skills-migration` (또는 v1.11+)
- **언어별 variant** (`python-uv/`, `go-mod/` 등) → v1.11~v1.13
- variant overlay 메커니즘 (`-Language` flag) → v1.11+
- `.mcp.json` 템플릿 → v1.14+
- 다른 adapter(cursor/codex-cli/etc) → v1.14~v1.20
- 프로젝트 `.claude/` 중앙 sync 도구 → 별도
- settings.local.json 처리 (사용자 private)

## 변경 대상 (상세)

### git mv 대상 17 파일

```bash
git mv claude/commands/harness.md                      bootstrap/templates/_base/.claude/commands/harness.md
git mv claude/commands/harness-plan.md                 bootstrap/templates/_base/.claude/commands/harness-plan.md
git mv claude/commands/harness-design.md               bootstrap/templates/_base/.claude/commands/harness-design.md
git mv claude/commands/harness-run.md                  bootstrap/templates/_base/.claude/commands/harness-run.md
git mv claude/commands/harness-ship.md                 bootstrap/templates/_base/.claude/commands/harness-ship.md
git mv claude/commands/harness-review.md               bootstrap/templates/_base/.claude/commands/harness-review.md
git mv claude/agents/harness-dispatcher.md             bootstrap/templates/_base/.claude/agents/harness-dispatcher.md
git mv claude/agents/harness-explore.md                bootstrap/templates/_base/.claude/agents/harness-explore.md
git mv claude/agents/harness-grey-area.md              bootstrap/templates/_base/.claude/agents/harness-grey-area.md
git mv claude/agents/harness-verifier.md               bootstrap/templates/_base/.claude/agents/harness-verifier.md
git mv claude/skills/harness-plan/SKILL.md             bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md
git mv claude/skills/harness-plan/plan-template.md     bootstrap/templates/_base/.claude/skills/harness-plan/plan-template.md
git mv claude/skills/harness-design/SKILL.md           bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md
git mv claude/skills/harness-design/7d-checklist.md    bootstrap/templates/_base/.claude/skills/harness-design/7d-checklist.md
git mv claude/skills/harness-ship/SKILL.md             bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md
git mv claude/skills/harness-ship/report-template.md   bootstrap/templates/_base/.claude/skills/harness-ship/report-template.md
git mv claude/output-styles/harness-engineer.md        bootstrap/templates/_base/.claude/output-styles/harness-engineer.md
```

총 17 파일 `git mv`. 이력 보존.

### 삭제 대상

- `claude/agents/.gitkeep` + `agents/` 디렉토리
- `claude/skills/.gitkeep` + `skills/` 디렉토리 (하위 3 skill 디렉토리 포함)
- `claude/output-styles/.gitkeep` + `output-styles/` 디렉토리
- `claude/commands/.gitkeep` (존재 시)

### 잔존 (claude/)

- `claude/commands/harness-meta.md`
- `claude/hooks/session-init.sh` + `claude/hooks/.gitkeep`
- `claude/statusline/statusline.sh` + `claude/statusline/.gitkeep`

### install.ps1 재작성 핵심

```powershell
# 추가: Step 0 — Legacy cleanup
# v1.8 이관 후 ~/.claude/ 에 과거 symlink(commands/harness-{plan,design,...},
# agents/harness-*, skills/harness-*, output-styles/harness-*)가 broken 상태로 잔존 가능.
# MetaRoot 하위 target이었던 것만 식별해 backup 이동.
$legacyPatterns = @(
    @{ Dir = 'commands';      Pattern = 'harness-*.md';     Exclude = 'harness-meta.md' }
    @{ Dir = 'agents';        Pattern = 'harness-*.md';     Exclude = $null }
    @{ Dir = 'skills';        Pattern = 'harness-*';        Exclude = $null }
    @{ Dir = 'output-styles'; Pattern = 'harness-*.md';     Exclude = $null }
)
# 각 패턴 스캔 → LinkType=SymbolicLink + Target MetaRoot 하위 (broken 포함) → backup

# 축소 categories (기존 6 → 3)
$categories = @(
    @{ name = 'commands';   type = 'file'; pattern = 'harness-meta.md' }
    @{ name = 'hooks';      type = 'file'; pattern = 'session-init.sh' }
    @{ name = 'statusline'; type = 'file'; pattern = 'statusline.sh' }
)
```

### verify.ps1 재작성

- A2: `@('claude/commands', 'claude/hooks', 'claude/statusline')` 3 카테고리
- B2: 기대 파일 **3**
- B7 (SKILL.md 체크): **삭제** — `_base/` 대상은 설치 대상 아님. 필요 시 별도 fixture 체크로 재정의 (본 세션 단순화: 삭제)
- 전체 체크 수 재산정 (약 27~29로 변동, PASS/FAIL 비교는 수치 변경에도 의미 동일)

### install-project-claude 공통 계약

```
인자: <project-root> (기본 CWD)
플래그: -Force / --force
환경: HARNESS_META_ROOT (기본 $HOME/harness-meta)

동작:
  1. <project-root>/.harness.toml 존재 확인 (없으면 exit 1)
  2. $META_ROOT/bootstrap/templates/_base/.claude/ 존재 확인
  3. <project-root>/.claude/ 생성
  4. 4 카테고리(commands, agents, skills, output-styles) 재귀 복사
  5. 충돌 시: -Force 없으면 중단 / 있으면 .claude/backup-<ts>/ 이동
  6. 완료 후 안내:
     - "복사 완료 (N 파일)"
     - "/config → Output style → Harness Engineer 선택 필요"
     - "다음: Claude Code 세션 재시작"
```

### `bootstrap/templates/_base/README.md` 내용 요지

- `_base`의 역할 (언어 불문 공통 baseline)
- `install-project-claude.{ps1,sh}`로 배포
- ⚠️ commands legacy 경고 + 향후 skills 통합 계획
- 언어별 variant는 v1.11+ 후속 (`python-uv/`, `go-mod/` 등 overlay 예정)
- 약 30~50 라인

## Grey Areas — 결정 (45건)

### 이관 메커니즘 (G1~G10)

| ID | 결정 |
|----|------|
| G1 | `_base/` 이름 (underscore 예약) |
| G2 | Copy 방식 (symlink 아님, Windows 호환 + drift 허용) |
| G3 | 기존 `~/.claude/` 파일 자동 cleanup (backup) |
| G4 | upbit 즉시 브레이크 인정. 사용자 복구 필수 |
| G5 | verify.ps1 기대 파일 17 → 3 |
| G6 | PowerShell + Bash 2 스크립트 |
| G7 | install-project-claude Copy (symlink 아님) |
| G8 | `_base/.claude/` 하위 .gitkeep 불필요 (파일 있음) |
| G9 | `_base/.claude/hooks`, `statusline` 제외 (글로벌 책임 유지) |
| G10 | pre-existing project `.claude/` 커스텀 파일 non-destructive default |

### install.ps1 재작성 (G11~G17)

| ID | 결정 |
|----|------|
| G11 | `$categories` 3 entries |
| G12 | **cleanup 로직 편입** (legacy broken symlink 자동 제거) |
| G13 | cleanup 대상 4 디렉토리 (agents/skills/output-styles 전체 + commands/harness-[plan,design,run,ship,review,dispatcher,explore,grey-area,verifier].md) |
| G14 | cleanup은 Test-SymlinkIntegrity 기반 — MetaRoot target인 symlink만 제거. regular file/타인 symlink 건드리지 않음 |
| G15 | A2 구조 체크 3 카테고리 |
| G16 | settings.json 경로 변경 없음 |
| G17 | Invoke-Rollback 확장 (cleanup 백업도 복원) |

### verify.ps1 재작성 (G18~G22)

| ID | 결정 |
|----|------|
| G18 | B2 기대 3 |
| G19 | A2 3 카테고리 |
| G20 | B7 **삭제** (`_base/`는 설치 대상 아님) |
| G21 | D hook smoke 영향 없음 |
| G22 | E statusline smoke 영향 없음 |

### install-project-claude (G23~G30)

| ID | 결정 |
|----|------|
| G23 | `.harness.toml` 부재 시 exit 1 |
| G24 | `-Force` 시 backup 이동 |
| G25 | `Copy-Item -Recurse` (PS) / `cp -r` (bash) |
| G26 | **완료 후 Output style 선택 안내** 필수 |
| G27 | PATH 정규화 (Resolve-Path / realpath) |
| G28 | bash 스크립트 `#!/usr/bin/env bash` |
| G29 | HARNESS_META_ROOT env 지원 |
| G30 | chmod +x (Unix) |

### OWNERSHIP (G31~G34)

| ID | 결정 |
|----|------|
| G31 | S1a (글로벌 최소) + S1b (_base 템플릿) split |
| G32 | S2 그대로 (bootstrap 자산) |
| G33 | S6 확장 `<proj>/.claude/**` |
| G34 | Evolution 예시 "claude 이관 2026-04-25 v1.8" |

### Smoke / Evidence (G35~G37)

| ID | 결정 |
|----|------|
| G35 | 임시 디렉토리 smoke 1 시나리오 |
| G36 | cleanup 자동 rm -rf |
| G37 | evidence 캡처 |

### 후행 의존성 (G38~G39)

| ID | 결정 |
|----|------|
| G38 | upbit 복구 세션 즉시 필요 — REPORT 말미 강조 |
| G39 | install-project-claude은 매니페스트 있는 프로젝트만 (bootstrap 후) |

### context7 재검증 후 추가 (G40~G45)

| ID | 결정 |
|----|------|
| **G40** | commands 공식 legacy 인지 — OWNERSHIP/_base README에 명시 |
| **G41** | commands→skills 통합은 **v1.8b** 등 별도 세션 |
| **G42** | skills frontmatter `name` 유지하면 `/harness-plan` UX 동일 |
| **G43** | 현 skills `disable-model-invocation: true`는 v1.8b에서 재평가 |
| **G44** | namespacing subdirectory 사용 안 함 (flat 유지) |
| **G45** | `.agents/skills/` 공존은 v1.14+ adapter 세션 |

## 성공 기준

- [ ] `bootstrap/templates/_base/.claude/` 17 파일 (commands 6 + agents 4 + skills 6 + output-styles 1)
- [ ] `claude/` 잔존 3 파일
- [ ] 17 파일 `git mv` 이력 보존
- [ ] `claude/{agents,skills,output-styles}/` 디렉토리 완전 삭제
- [ ] `install.ps1` cleanup 로직 + 축소 categories
- [ ] `verify.ps1` A2 3 / B2 3 / B7 삭제
- [ ] `bootstrap/install-project-claude.ps1` + `.sh` 2 파일 + bash chmod +x
- [ ] `bootstrap/templates/_base/README.md` (commands legacy 경고 포함)
- [ ] `OWNERSHIP.md` S1a/S1b split + S6 확장 + Evolution 예시 (commands legacy 명시)
- [ ] `README.md` / `CLAUDE.md` / `AGENTS.md` 2단계 설치 안내
- [ ] smoke install-project-claude PASS + evidence
- [ ] 실 `~/.claude/` 적용 실측 (cleanup + 새 글로벌 설치)
- [ ] verify.ps1 PASS (새 기준)
- [ ] Grey Area 45건 결정
- [ ] 커밋 메시지 `!` BREAKING 태그
- [ ] push + 사용자 복구 세션 안내

## 커밋 전략

```
feat(meta)!: sessions/meta/v1.8-core-adapter-split — claude/ 이관 (글로벌 축소)

- move (git mv 17): claude/{commands×6, agents×4, skills×6, output-styles×1}
        → bootstrap/templates/_base/.claude/ (이력 보존)
- keep: claude/{commands/harness-meta.md, hooks/, statusline/} (3 파일 글로벌)
- refactor: install.ps1 — cleanup 단계 추가 (legacy broken symlink 자동 제거 + backup)
                          + $categories 6 → 3
- refactor: verify.ps1 — A2 3 카테고리 / B2 3 파일 / B7 삭제
- add: bootstrap/install-project-claude.{ps1,sh}
       프로젝트 루트에서 실행 시 _base/.claude/ 복사. Output style 선택 안내
- add: bootstrap/templates/_base/README.md
       _base 설명 + commands legacy 경고 + 후행 세션 (v1.8b commands→skills)
- update: bootstrap/docs/OWNERSHIP.md — S1a/S1b split + S6 확장 + Evolution 예시
- update: README.md / CLAUDE.md / AGENTS.md — 2단계 설치 안내
- add: sessions/meta/v1.8-core-adapter-split/{PLAN,REPORT,evidence}

BREAKING CHANGE: 기존 upbit는 글로벌 symlink로 받던 /harness-plan 등
13개 명령을 즉시 잃음. 복구는 sessions/upbit/vX-project-claude-install/
에서 `pwsh bootstrap/install-project-claude.ps1 ~/upbit` 실행 (T4 분할).

Copy 방식 (symlink 아님) — Windows 호환 + 프로젝트 drift 허용.
Anthropic 공식 문서상 .claude/commands/는 legacy format (2026-04).
v1.8은 과도기 이관, 후속 v1.8b에서 skills 통합 재설계 예정.
Grey Area 45건 결정.
```

## 후속 세션 연결

### 즉시 필수 (사용자 액션)

1. `sessions/upbit/vX-project-claude-install` — upbit 복구 (S6 upbit)

### 대기 후행

- `sessions/upbit/vX-statusline-cmd-migration` — v1.6/v1.7 후속, statusline 풍부한 출력 복원
- `sessions/upbit/vX-manifest-upgrade-1.1` — upbit 매니페스트 optional upgrade
- **`sessions/meta/v1.8b-commands-to-skills-migration`** — commands legacy → skills preferred 전환 (Anthropic 공식 권장)

### meta 측 후행 v1.9~

- v1.9-project-auto-detect
- v1.10-bootstrap-interview
- v1.11~v1.13 bootstrap-templates (언어별 variant + overlay 메커니즘)
- v1.14~v1.20 adapter-* (cursor/codex-cli/gemini-cli/windsurf/cline/aider)
- v1.21-cross-platform-install
- v1.22-bootstrap-e2e-orchestration
- v1.25-opensource-readiness

### 보류 후보

- `sessions/meta/vX-sync-project-claude` — 프로젝트 `.claude/` 중앙 업데이트 전파
- `sessions/meta/vX-mcp-json-template` — `.mcp.json` 언어별 템플릿

### 3개월 재평가 게이트

`_base` 언어 중립 유지 가능성 평가. Claude Code commands → skills 공식 deprecation 완전 제거 시 본 구조 재평가.

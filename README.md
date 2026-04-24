# harness-meta

> Claude Code 하네스의 글로벌 통합 레이어 + 프로젝트별 하네스 아키텍처 기록소.

본 repo는 하네스의 **공통 자산**(slash commands, subagents, skills, hooks, statusline, output-styles, bootstrap 템플릿)과 **세션 이력**을 단일 위치에 모은다. 개별 프로젝트는 `.harness.toml` 매니페스트 한 개로 하네스를 활성화하고, 프로젝트 고유의 `scripts/harness/` 코드만 각자 repo에서 진화시킨다.

---

## 목차

1. [개요](#개요)
2. [요구사항](#요구사항)
3. [설치](#설치)
4. [디렉토리 구조](#디렉토리-구조)
5. [프로젝트 활성화](#프로젝트-활성화)
6. [사용법](#사용법)
7. [세션 소속 판정](#세션-소속-판정)
8. [버전 축](#버전-축)
9. [타 기기 재현](#타-기기-재현)
10. [트러블슈팅](#트러블슈팅)
11. [관련 문서](#관련-문서)

---

## 개요

하네스(Harness)는 Claude Code 세션의 워크플로우를 **10단계**로 구조화하는 툴체인이다.

| 단계 | 명령 | 산출물 |
|------|------|--------|
| 1–4 | `/harness-plan` | `PLAN.md` |
| 5–7 | `/harness-design` | `step{N}.md`, `index.json` |
| 8–9 | `/harness-run` | `execute.py` 실행 + 커밋 |
| 10 | `/harness-ship` | `REPORT.md`, main 병합, push |
| — | `/harness-meta` | 하네스 자체 개선 세션 (본 repo 소속) |

프로젝트별로 `scripts/harness/` 실행기 코드가 존재하고, 본 repo는 **프로젝트 간 공유되는 UX·문서·자산**을 보관한다.

---

## 요구사항

- **Windows 11** + **Developer Mode ON** (`설정 → 시스템 → 개발자용`)
  - 레지스트리 검증: `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock\AllowDevelopmentWithoutDevLicense = 1`
  - symlink 생성에 필요
- **PowerShell 7+** — `winget install Microsoft.PowerShell`
- **Git Bash** (Git for Windows 포함) — hook 실행용 (`shell: "bash"`)
- **Claude Code** 설치 + 사용자 계정 로그인

---

## 설치

```powershell
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1
```

`install.ps1`의 동작:
1. `~/.claude/{commands,agents,skills,output-styles,hooks,statusline}/`에 symlink 6 카테고리 생성
2. `~/.claude/settings.json`의 `hooks.SessionStart` / `statusLine.command` 필드 추가
3. 충돌 감지 시 **중단 + 경고** (파괴 방지)

**덮어쓰기 강제**는 `--force` 옵션만 허용 (기존 파일을 `~/.claude/backup-<timestamp>/`에 백업 후 교체).

### 레이어 변경 후 재설치

새 slash command 추가 등 `claude/` 하위 파일 구조가 바뀌면:

```powershell
pwsh ~/harness-meta/install.ps1
```

기존 symlink는 target 경로로 검증되며, 누락/변경 시 재생성.

---

## 디렉토리 구조

```
harness-meta/
├── CLAUDE.md                       # repo 진입점 (Claude Code 자동 로드)
├── README.md                       # 본 파일 (설명서)
├── install.ps1                     # 글로벌 symlink 배포 스크립트
│
├── claude/                         # 글로벌 레이어 (symlink source)
│   ├── commands/*.md               # /harness-*
│   ├── agents/*.md                 # harness-{dispatcher,explore,grey-area,verifier}
│   ├── skills/harness-*/           # plan/design/ship 템플릿
│   ├── hooks/session-init.sh       # SessionStart 훅
│   ├── statusline/statusline.sh    # 실시간 상태 표시
│   └── output-styles/harness-engineer.md
│
├── bootstrap/                      # 신규 프로젝트 도입 자산
│   ├── manifest-schema.md          # .harness.toml 스펙
│   ├── docs/                       # OWNERSHIP / PHILOSOPHY / PATTERNS
│   └── templates/                  # 언어·PM별 뼈대 (예정)
│
├── projects/<name>/                # 프로젝트별 하네스 아키텍처 4종
│   ├── ARCHITECTURE.md             # scripts/harness/ 레이아웃 스냅샷
│   ├── DECISIONS.md                # H-ADR (하네스 설계 결정)
│   ├── INTERVIEW.md                # bootstrap 인터뷰 답변
│   └── STACK.md                    # 도구·버전 pin
│
└── sessions/
    ├── meta/vX.Y-{name}/           # 본 repo 자체 개선
    │   ├── PLAN.md
    │   └── REPORT.md
    └── <project>/vX.Y-{name}/      # 프로젝트별 하네스 개선
        ├── PLAN.md
        └── REPORT.md
```

---

## 프로젝트 활성화

### 활성화 방식

대상 프로젝트 루트에 `.harness.toml`을 두면 `session-init.sh`가 자동 감지한다. 매니페스트 부재 시 글로벌 훅은 **no-op**(무관 프로젝트에 간섭하지 않음).

### 최소 매니페스트 예시

```toml
schema_version = "1.0"

[project]
name = "my-project"
language = "python"
package_manager = "poetry"

[harness]
code_dir = "scripts/harness"
phases_dir = "phases"

[architecture]
meta_ref = "projects/my-project/ARCHITECTURE.md"
```

전체 필드와 파싱 규칙은 [`bootstrap/manifest-schema.md`](bootstrap/manifest-schema.md).

### 신규 프로젝트 도입

```
/harness-meta <new-project-name>
```

`.harness.toml` 부재 시 **Bootstrap 모드** 진입 → 인터뷰 → `scripts/harness/`, `phases/`, `.harness.toml`, `docs/GUARDRAILS.md` 자동 생성 + `projects/<name>/` 4종 문서 작성.

---

## 사용법

### 세션 종류별 명령

| 명령 | 모드 | 대상 |
|------|------|------|
| `/harness-meta meta` | repo 자체 개선 | 본 repo의 글로벌 레이어 · bootstrap · README · CLAUDE.md |
| `/harness-meta <name>` | 프로젝트별 하네스 개선 | `projects/<name>/` 및 해당 프로젝트 repo의 `scripts/harness/` 등 |
| `/harness-meta <new-name>` | Bootstrap | `.harness.toml` 부재 프로젝트 신규 도입 |
| `/harness-meta` | 자동 추론 | CWD basename을 target으로 추론 (hyphen↔underscore 동치) |

### 세션 기록 규칙

- 각 세션은 `sessions/{meta or <name>}/vX.Y-{slug}/PLAN.md` + `REPORT.md` 한 쌍
- `index.json` / `step{N}.md` **생성 금지** (재귀 회피 — meta 세션은 `/harness-plan`~`/harness-ship` 자동 플로우와 분리된 수동 문서 흐름)
- 커밋 전 사용자 확인 필수

---

## 세션 소속 판정

**"어느 세션 디렉토리에 기록할지"** 판정 규칙은 [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md)의 단일 소스를 따른다.

요약:
- 글로벌 레이어·bootstrap·repo 정책 수정 → `sessions/meta/`
- 프로젝트 아키텍처 문서·실행기 코드·매니페스트 수정 → `sessions/<name>/`
- 비즈니스 코드(`bot/` 등) → meta 세션 대상 아님 (정식 `/harness-plan`~`/harness-ship` 플로우)

상세 규약은 [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md) 참조.

---

## 버전 축

본 repo는 **2중 버전 축**을 사용한다.

| 축 | 대상 | 예시 |
|---|---|---|
| **repo semver** | 본 repo 전체 (`sessions/meta/`와 `sessions/<project>/`가 같은 축 공유) | v1.0, v1.1, v1.2 |
| **프로젝트 비즈니스 semver** | 각 프로젝트의 기능 개발 (본 repo와 무관) | 예: upbit 봇 `phases/v0.1 ~ v1.5` |

---

## 타 기기 재현

1. Windows Dev Mode ON 확인 (`AllowDevelopmentWithoutDevLicense = 1`)
2. PowerShell 7+ 설치 (`winget install Microsoft.PowerShell`)
3. Git Bash 설치 확인 (`where bash`)
4. `git clone https://github.com/pdw96/harness-meta $HOME/harness-meta`
5. `cd $HOME/harness-meta && pwsh ./install.ps1`
6. 각 대상 프로젝트 clone 후 루트에 `.harness.toml` 존재 확인
7. Claude Code 세션 재시작 → `What skills are available?` 응답에 `harness-*` 목록 노출 확인

`HARNESS_META_ROOT` 환경변수로 clone 위치 override 가능 (기본: `$HOME/harness-meta`).

---

## 트러블슈팅

### `install.ps1`이 "symlink 생성 실패"로 중단

- Dev Mode 꺼짐 가능성 → 레지스트리 키 재확인
- 관리자 PowerShell 재시도
- 기존 파일 충돌 → `pwsh install.ps1 --force`로 백업 후 덮어쓰기

### 세션 시작 시 harness 관련 context가 주입되지 않음

- CWD에 `.harness.toml` 존재 여부 확인 (`cat .harness.toml`)
- `~/.claude/hooks/session-init.sh`가 `~/harness-meta/claude/hooks/session-init.sh`로 symlink 유지 중인지 확인
- Claude Code 세션 완전 재시작

### statusline이 `[harness] ...`를 출력하지 않음

- 위 "session-init 미작동"과 동일 원인 점검
- `bash ~/harness-meta/claude/statusline/statusline.sh`를 수동 실행하여 에러 확인

### slash command / agent / skill이 노출되지 않음

- `ls ~/.claude/commands/` 결과에 `harness-*.md`가 symlink로 존재하는지 확인
- 대상 경로가 유효한지 `readlink`로 확인
- 손상 시 `pwsh ~/harness-meta/install.ps1 --force`로 재배포

### `/harness-meta` 세션이 잘못된 디렉토리에 생성됨

- CWD basename 기준 자동 추론이 부정확할 수 있음
- 명시적 argument 지정: `/harness-meta meta` 또는 `/harness-meta <name>`
- 판정 규약: [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md)

---

## 관련 문서

- 세션 소속 규약: [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md)
- `.harness.toml` 스펙: [`bootstrap/manifest-schema.md`](bootstrap/manifest-schema.md)
- 하네스 철학·패턴: [`bootstrap/docs/PHILOSOPHY.md`](bootstrap/docs/PHILOSOPHY.md) · [`bootstrap/docs/PATTERNS.md`](bootstrap/docs/PATTERNS.md) (진행 중)
- 최신 meta 세션: [`sessions/meta/v1.2-ownership-rules/PLAN.md`](sessions/meta/v1.2-ownership-rules/PLAN.md)
- Claude Code 진입 컨텍스트: [`CLAUDE.md`](CLAUDE.md)

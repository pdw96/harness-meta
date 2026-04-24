# harness-meta

> Claude Code 하네스의 글로벌 통합 레이어 + 프로젝트별 하네스 아키텍처 기록소.

각 프로젝트(`upbit`, `dowon_trading` 등)에 설치된 `scripts/harness/` 코드는 프로젝트 고유 진화.
이 repo는 그 진화에 필요한 **공통 자산**과 **이력**을 모은다.

## 레이아웃

- `claude/` — user-level symlink 대상 (slash commands, subagents, skills, output-styles, hooks, statusline)
- `bootstrap/` — 신규 프로젝트 도입 자산 (interview, templates, docs)
- `projects/{name}/` — 프로젝트별 하네스 아키텍처 4종 (ARCHITECTURE/DECISIONS/INTERVIEW/STACK)
- `sessions/{meta_or_project}/vX.Y-{name}/` — 개선 세션 기록 (PLAN + REPORT)

## 설치

### 요구사항

- Windows 11 + **Developer Mode ON** (`설정 → 시스템 → 개발자용`). 레지스트리 검증:
  `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock\AllowDevelopmentWithoutDevLicense = 1`
- **PowerShell 7+** (`winget install Microsoft.PowerShell`)
- **Git Bash** (Git for Windows 설치 시 포함) — hook 실행용 (`shell: "bash"`)

### 절차

```powershell
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1
```

`install.ps1`이 `~/.claude/{commands,agents,skills,output-styles,hooks,statusline}/`에
symlink 6 카테고리 생성하고 `~/.claude/settings.json`에 hook/statusLine 필드 추가.

**충돌 정책**: 동일 이름 파일·링크 존재 시 **중단 + 경고**. `--force` 플래그로만 `~/.claude/backup-<timestamp>/`에 이동 후 덮어쓰기.

### 프로젝트별 활성화

프로젝트 루트에 `.harness.toml` 존재 시 `session-init.sh`가 자동 감지.
부재 시 글로벌 hook은 no-op (무관 프로젝트 무간섭).

`.harness.toml` 스펙: [`bootstrap/manifest-schema.md`](bootstrap/manifest-schema.md)

## 버전 축 (2중)

| 축 | 대상 | 예시 |
|---|---|---|
| repo semver | 이 repo 전체 (`sessions/meta/`와 `sessions/{project}/`가 같은 축 공유) | v1.0, v1.1, v1.2 |
| 프로젝트 비즈니스 semver | 각 프로젝트의 기능 개발 (본 repo와 무관) | upbit 봇 `phases/v0.1~v1.5` |

**upbit 레거시 이력**: 글로벌화 이전 upbit 하네스 이력(v0.x~v1.4는 `upbit/phases/HARNESS_CHANGELOG.md` 요약, v1.5~v1.41은 `upbit/harness-meta/vX.Y/`)은 **upbit repo git history에 영구 보존**. 글로벌 repo로 이관하지 않음 — 핵심 결정 요약은 `projects/upbit/DECISIONS.md`의 H-ADR 참조. 상세 맥락은 `git -C <upbit> show <sha>:harness-meta/vX.Y/REPORT.md`.

**차후 세션 명명**:
- harness-meta repo 자체 개선: `sessions/meta/vX.Y-{name}/` (예: `v1.1-bootstrap-templates`)
- 프로젝트별 하네스 개선: `sessions/{project}/vX.Y-{name}/` (repo semver와 동기)
- 프로젝트 초기 도입: `sessions/{project}/v0.1-bootstrap/`

## 타 기기 재현 절차

1. Windows Dev Mode ON 확인 (`AllowDevelopmentWithoutDevLicense = 1`)
2. PowerShell 7+ 설치 (`winget install Microsoft.PowerShell`)
3. Git Bash 설치 확인 (`where bash`)
4. `git clone https://github.com/pdw96/harness-meta $HOME/harness-meta`
5. `cd $HOME/harness-meta && pwsh ./install.ps1`
6. 각 대상 프로젝트 clone 후 루트에 `.harness.toml` 존재 확인
7. Claude Code 세션 재시작 → `What skills are available?` 응답에 harness-* 목록 노출 확인

`HARNESS_META_ROOT` 환경변수로 clone 위치 오버라이드 가능 (기본: `$HOME/harness-meta`).

## 대상 프로젝트

<!-- 프로젝트 추가 세션 REPORT 체크리스트에서 이 섹션 갱신 의무 -->

- [upbit](projects/upbit/ARCHITECTURE.md) — 업비트 자동매매 봇 (Python 3.12 + Poetry + Docker)

## 관련 문서

- 현재 세션: [`sessions/meta/v1.0-bootstrap/PLAN.md`](sessions/meta/v1.0-bootstrap/PLAN.md)
- `.harness.toml` 스펙: [`bootstrap/manifest-schema.md`](bootstrap/manifest-schema.md)
- 하네스 철학·패턴: [`bootstrap/docs/PHILOSOPHY.md`](bootstrap/docs/PHILOSOPHY.md), [`bootstrap/docs/PATTERNS.md`](bootstrap/docs/PATTERNS.md)

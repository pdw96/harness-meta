# harness-meta v1.0-bootstrap Plan

## 배경

- 지금까지 하네스는 `C:/Users/qkreh/upbit/` 로컬 자산으로 관리됨.
  - 통합 레이어: `upbit/.claude/{commands,agents,skills,output-styles,hooks}/harness-*`
  - 코어 코드: `upbit/scripts/harness/`
  - 이력: `upbit/harness-meta/v1.1~v1.4/`
- 두 번째 프로젝트 `C:/Users/qkreh/dowon_trading/`가 등장. 하네스 미설치 상태.
- upbit 하네스를 그대로 복사하면 각 프로젝트 특성을 반영 못 함. 또한 개선 이력이 프로젝트별 분산 → 교차 비교·재사용 불가.
- 해결: 별도 git repo `pdw96/harness-meta`로 **글로벌 통합 레이어 + 프로젝트별 아키텍처 기록소**를 분리. 각 프로젝트의 `scripts/harness/` 코어 코드는 독립 유지(L3 보류).
- 사용자 결정 요약:
  - 1. repo 위치 `C:/Users/qkreh/harness-meta/`
  - 2. remote `https://github.com/pdw96/harness-meta` (PUBLIC)
  - 3. 설치 = symlink (Dev Mode ON 확인 완료)
  - 4. upbit 로컬 `.claude/harness-*` 제거
  - 5. upbit `scripts/harness/` 현 위치 유지 (L3 별도)
  - 6. repo 자체 개선 세션 ID = `sessions/meta/`
  - 7. `projects/{name}/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md`는 meta canonical + 프로젝트 CLAUDE.md 참조

## 목표

- [x] **Step 0 완료** (`research.md` 참조): 확정 사항 — `@~/...` 홈 확장 지원 / settings는 project override + array concat / hook은 `.sh` 단일 + `shell: "bash"` / output-style 자동 활성화 없음 / symlink는 설치 후 실제 세션으로 재검증
- [ ] harness-meta repo 뼈대 확정 + 커밋·푸시
- [ ] 글로벌 통합 레이어 전부 이관 + **프로젝트-중립화** (upbit 전용 문구 제거, `phases/{version}/{phase}/` 구조는 표준 고정)
- [ ] `statusline.sh` 글로벌 승격 + CWD 기반 프로젝트 자동감지
- [ ] `install.ps1` 작성: `~/.claude/{commands,agents,skills,output-styles,hooks,statusline}/`에 harness-* symlink + Dev Mode 검증 + **충돌 시 중단 + 경고** (`--force`로만 덮어쓰기)
- [ ] `install.ps1` 실행 → upbit 루트에서 `/harness`, `/harness-plan` 등 글로벌 경로 동작 확인
- [ ] `.harness.toml` 스펙 정의 + upbit용 파일 작성 (프로젝트 매니페스트)
- [ ] upbit `.claude/commands,agents,skills/harness-*` + `output-styles/harness-engineer.md` + `statusline.sh` + `hooks/session-init.*` 제거
- [ ] upbit `.claude/settings.json` 분할: 글로벌 이식 필드(hook 경로) 제거, 프로젝트 전용(permissions, enabledMcpjsonServers) 유지
- [ ] upbit `.mcp.json` **유지** (MCP 서버는 프로젝트 로컬). 이름은 `harness` 고정 관례
- [ ] upbit `harness-meta/v1.1~v1.4/` → `harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/` 파일 복사 (`-legacy` 접미사로 글로벌화 이전 시절 식별, 커밋 메시지에 원 SHA 명시), upbit 로컬은 제거
- [ ] upbit `harness-meta/` 디렉토리 → `README.md` 1개로 축약 (이력 위치 안내)
- [ ] upbit `phases/HARNESS_CHANGELOG.md` **유지** + `harness-meta/sessions/upbit/README.md`에 참조 링크만
- [ ] `projects/upbit/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md` 현 상태 정확 덤프
- [ ] upbit `CLAUDE.md`에 `@~/harness-meta/projects/upbit/ARCHITECTURE.md` include 추가 (홈 확장 문법 확정)
- [ ] `~/.claude/settings.json` 신규 작성: `hooks.SessionStart` + `statusLine.command` 2필드만 (shell=bash)
- [ ] `session-init` hook에 **프로젝트 자동감지** (CWD + `.harness.toml` 우선, 부재 시 `scripts/harness/` 존재 여부로 fallback, 둘 다 없으면 no-op)
- [ ] `harness-meta/.gitattributes` 작성 (`*.sh text eol=lf`)
- [ ] README.md에 **버전 축 2중 구분** (repo semver / 프로젝트-비즈니스 semver) + upbit `-legacy` 설명 + **타 기기 재현 절차** 섹션 + **대상 프로젝트 목록** (수동 유지)
- [ ] 후속 세션(프로젝트 추가 시) REPORT 체크리스트에 "README 대상 프로젝트 섹션 갱신" 항목 의무화 (본 세션 REPORT 템플릿에 명시)
- [ ] `bootstrap/` 자산 초안 (interview.md, templates/ 디렉토리 목록 + python-poetry 템플릿 스펙 정의만 — 실제 구현은 다음 세션)
- [ ] 두 repo(harness-meta, upbit) 모두 초기 커밋·푸시

## 범위

### 포함

- **Step 0: Claude Code 공식 문서 조사 (WebFetch)** — import/settings merge/hook OS/output-style/symlink 인식
- harness-meta repo 구조 생성 + 초기 자산
- 글로벌 통합 레이어 이관 + 프로젝트-중립화
- `statusline` 글로벌 승격 + CWD 감지
- `.harness.toml` 스펙 정의 + upbit 파일 생성
- upbit 로컬 잔재 제거 + 이력 이관
- upbit ARCHITECTURE 4종 초기 덤프
- `install.ps1` + Dev Mode 검증 + 충돌 안전 정책
- session-init hook 글로벌화 + `.harness.toml` 기반 판별
- `.gitattributes` 줄바꿈 규칙
- README에 버전 축 구분 + 타 기기 재현 절차

### 제외 (명시)

- dowon_trading 부트스트랩 → `sessions/dowon_trading/v0.1-bootstrap` 별도 세션
- `bootstrap/templates/python-poetry/` 실제 구현 → 별도 세션 (`sessions/meta/v1.1-bootstrap-templates`)
- upbit 봇 phase 재편 (Control-Plane-Foundation 등) → 본 세션과 무관, 글로벌화 완료 후 `phases/v1.5/` 신규 PLAN
- L3 (scripts/harness 코어 추출) → 최소 2개 프로젝트 운영 후 재검토
- harness-meta 자체의 CI·테스트 자동화 → 별도 세션
- 프롬프트 이중언어화 → 현재 한국어 유지

## 변경 대상

### harness-meta repo (신규)

```
C:/Users/qkreh/harness-meta/
├── README.md                            # 철학 + 설치/사용 + 버전축 + 재현절차
├── install.ps1                          # ~/.claude/ symlink + 충돌 안전
├── .gitignore                           # *.log, .DS_Store 등
├── .gitattributes                       # *.sh text eol=lf
├── claude/                              # 글로벌 통합 레이어
│   ├── commands/harness-*.md            # 7개 (upbit 이관 + 일반화)
│   ├── agents/harness-*.md              # 4개
│   ├── skills/harness-*/                # 3개
│   ├── output-styles/harness-engineer.md
│   ├── hooks/session-init.sh      # CWD + .harness.toml 감지
│   └── statusline/statusline.sh   # CWD 기반 프로젝트별 execute.py --status 호출
├── bootstrap/
│   ├── interview.md                     # 신규 도입 질문 템플릿
│   ├── manifest-schema.md               # .harness.toml 스펙
│   ├── templates/                       # (디렉토리만, 내용은 별도 세션)
│   └── docs/
│       ├── PHILOSOPHY.md                # PLAN→DESIGN→RUN→SHIP, 7D, Goal-backward
│       └── PATTERNS.md                  # GUARDRAILS, index.json, step 규약
├── projects/
│   └── upbit/
│       ├── ARCHITECTURE.md
│       ├── DECISIONS.md                 # H-ADR
│       ├── INTERVIEW.md                 # upbit 회고 덤프 (현 구조를 역산)
│       └── STACK.md
└── sessions/
    ├── meta/
    │   └── v1.0-bootstrap/
    │       ├── PLAN.md                  # 이 파일
    │       ├── research.md              # Step 0 WebFetch 결과 (임시, 세션 종료 시 유지)
    │       └── REPORT.md                # 세션 종료 시
    └── upbit/                           # upbit/harness-meta/ 이관
        ├── README.md                    # 레거시 HARNESS_CHANGELOG 참조 링크
        ├── v1.1-legacy/
        ├── v1.2-legacy/
        ├── v1.3-legacy/
        └── v1.4-legacy/
```

### upbit repo (수정)

- `upbit/.claude/commands/harness-*.md` (7개) → 삭제
- `upbit/.claude/agents/harness-*.md` (4개) → 삭제
- `upbit/.claude/skills/harness-*/` (3개) → 삭제
- `upbit/.claude/output-styles/harness-engineer.md` → 삭제
- `upbit/.claude/hooks/session-init.*` → 삭제 (글로벌 hook이 대체)
- `upbit/.claude/statusline.sh` → 삭제 (글로벌이 대체)
- `upbit/.claude/settings.json` → 필드별 분할 (아래 표)
  | 필드 | 처리 |
  |---|---|
  | `permissions.allow/deny` | upbit 유지 (프로젝트 전용) |
  | `hooks` (session-init 경로) | 제거 (글로벌이 대체) |
  | `statusLine` | 제거 (글로벌이 대체) |
  | `enabledMcpjsonServers` | upbit 유지 (MCP는 프로젝트 로컬) |
  | `outputStyle` | 제거하거나 유지 — Step 0 결과에 따라 |
- `upbit/.mcp.json` → **유지** (harness MCP 서버는 프로젝트 로컬)
- `upbit/harness-meta/v1.1~v1.4/` → 삭제 (harness-meta repo로 이관)
- `upbit/harness-meta/README.md` → "이력은 `C:/Users/qkreh/harness-meta/sessions/upbit/` 참조" stub
- `upbit/phases/HARNESS_CHANGELOG.md` → **유지** (레거시 원본 보존)
- `upbit/CLAUDE.md` → ARCHITECTURE include + 하네스 명령 사용법 섹션을 "글로벌 설치 기반" 설명으로 교체 (경로 형식은 Step 0 결정)
- `upbit/.harness.toml` → 신규 작성 (프로젝트 매니페스트)

### 사용자 환경 (`~/.claude/`)

- `~/.claude/commands/harness-*.md` → harness-meta/claude/commands/*.md symlink (7개)
- `~/.claude/agents/harness-*.md` → symlink (4개)
- `~/.claude/skills/harness-*/` → symlink (디렉토리 단위, 3개)
- `~/.claude/output-styles/harness-engineer.md` → symlink
- `~/.claude/hooks/session-init.sh` → symlink
- `~/.claude/statusline/statusline.sh` → symlink (또는 Claude Code가 요구하는 위치)
- 충돌 정책: 동일 이름 파일·링크 존재 시 **install.ps1이 중단 + 경고**. `--force` 플래그로만 백업·덮어쓰기
- 사용자 개인 `~/.claude/CLAUDE.md` → **건드리지 않음** (harness-agnostic 유지)

## Grey Areas / 논의 결정

- **G1. 프롬프트 일반화 범위**
  - upbit-specific 문구(`bot/`, ADR-XXX 번호, `docs/scope/{version}/` 경로) 전부 제거 → **각 프로젝트 CLAUDE.md + projects/{name}/ARCHITECTURE.md에서 주입**
  - `phases/{version}/{phase}/` 구조는 **공통 가정**으로 유지 (dowon_trading이 다른 구조 원하면 그때 재추상화)
  - `index.json` 스키마도 공통. 프로젝트별 차이는 optional 필드로 흡수
  - 판정: 글로벌 프롬프트는 "어떤 프로젝트에서도 문법적으로 유효" 기준. 도메인 용어는 ARCHITECTURE가 공급

- **G2. session-init hook의 프로젝트 판별**
  - 우선순위: (a) CWD가 git repo root이고 (b) `scripts/harness/` 존재하면 해당 프로젝트 = CWD basename
  - basename 정규화: hyphen↔underscore 동치 (`dowon-trading` ↔ `dowon_trading`)
  - `scripts/harness/` 없으면 hook은 no-op (harness 없는 repo 간섭 방지)
  - 다중 프로젝트 cross-edit 시나리오(`/harness-meta upbit`을 dowon_trading에서 호출)는 command 프롬프트에서 arg 기반 override 처리, hook 관여 안 함

- **G3. upbit 이력 이관 방식**
  - cross-repo라 git history 보존 불가
  - 각 REPORT.md 첫 줄에 `> 원출처: upbit@<SHA> path:harness-meta/v1.X/REPORT.md` 주석 추가
  - 이관 커밋 1건 메시지에 upbit 원본 SHA 범위 명시

- **G4. 글로벌 hook의 조건부 로드**
  - user-level hook은 모든 Claude 세션에서 실행 → harness 없는 repo(예: `~` 홈)에서도 호출됨
  - hook 첫 줄에서 `scripts/harness/` 존재 확인, 없으면 즉시 exit 0 (침묵)
  - WSL/Unix 혼용: `.sh`, `.ps1` 양쪽 제공. Claude Code가 OS에 맞게 선택

- **G5. PS 5.1 vs PS 7**
  - install.ps1은 PowerShell 7 (`pwsh`) 기준으로 작성. 첫 줄 `#Requires -Version 7.0`
  - symlink 생성은 `New-Item -ItemType SymbolicLink` (PS 7 안정)
  - 사용자 환경에 pwsh 7.5.5 확인 완료

- **G6. ARCHITECTURE 4종 작성 시기**
  - 본 세션에서 **upbit 현 상태를 덤프**하는 것만 수행 (변경 유도 아님)
  - INTERVIEW.md는 "역산": 현재 upbit 구조를 기반으로 "이런 질문에 어떤 답이었을지" 회고 작성
  - 이후 upbit 하네스 개선 시 DECISIONS.md 추가분 누적

- **G7. `.claude/settings.json` 분할 정책**
  - 필드별 범위 매트릭스 (변경 대상 §upbit repo 표 참조)
  - 머지 규칙(user vs project)은 Step 0의 WebFetch로 확정 — 현 가정: project override
  - 글로벌로 올릴 필요 없는 필드는 이관 안 함 (permissions는 프로젝트 성격 강함)
  - `outputStyle` 필드: 자동 활성화 원치 않음 → 프로젝트 CLAUDE.md에서 수동 `/output-style harness-engineer` 권장. settings.json에 박지 않음

- **G8. `.mcp.json` / harness MCP 서버 범위**
  - MCP 서버는 **프로젝트 로컬**. 경로가 프로젝트 내부 `scripts/harness/`를 가리키므로 글로벌화 불가
  - 관례: 서버 이름 **`harness` 고정**. 글로벌 슬래시 명령이 MCP 서버 이름 참조 시 이 이름에 의존
  - dowon_trading bootstrap 시 `.mcp.json`도 생성 (harness 서버 등록)

- **G9. statusLine 글로벌 승격**
  - `claude/statusline/statusline.sh`로 이관
  - CWD에서 `.harness.toml` 읽고 `[harness].code_dir`의 `execute.py` 호출해 진행 상태 출력
  - `.harness.toml` 없으면 statusline은 빈 문자열 출력 (하네스 비활성 프로젝트 무간섭)
  - Claude Code의 statusLine 설치 경로는 Step 0에서 확인 (settings.json `statusLine.command` 기반일 가능성)

- **G10. output-style 자동 활성화 범위**
  - 기본 활성화 없음. 사용자가 `/output-style harness-engineer` 수동 호출
  - upbit CLAUDE.md에 "하네스 세션에서 `harness-engineer` 사용 권장" 가이드만 추가
  - settings.json `outputStyle` 필드 건드리지 않음

- **G11. CLAUDE.md import 경로 이식성**
  - 절대경로 `@C:/Users/qkreh/harness-meta/...` 사용 시 다른 기기·사용자명에서 깨짐
  - Step 0에서 Claude Code `@` import의 지원 문법 확인:
    - `@~/...` 홈 확장 가능?
    - `@$ENV_VAR/...` 환경변수 확장 가능?
    - symlink 경유 참조 가능? (예: `upbit/.harness/architecture.md → ../../harness-meta/projects/upbit/ARCHITECTURE.md`)
  - 가능한 방식 우선순위:
    - (1) `@~/harness-meta/projects/upbit/ARCHITECTURE.md` — 홈 확장 지원 시
    - (2) 프로젝트 내부 symlink `upbit/.harness/architecture.md` → meta, CLAUDE.md는 `@.harness/architecture.md` (상대경로)
    - (3) 절대경로 하드코딩 + README에 "기기 이동 시 CLAUDE.md 경로 수정 필요" 경고
  - 본 세션 결정: Step 0 결과 반영

- **G12. `phases/{version}/{phase}/` 경로 가정**
  - G1 판정에 따라 **공통 표준으로 고정**
  - 일반화 작업 중 프롬프트 파일들의 `upbit` 고유명사만 제거. 구조 패턴은 유지
  - dowon_trading이 다른 구조 원하면 그때 재추상화 (L3 논의에 포함)

- **G13. GUARDRAILS.md 위치**
  - `.harness.toml`의 `[harness].guardrails` 필드로 프로젝트별 선언
  - `builders.load_guardrails()`가 현재 경로를 어떻게 찾는지 확인 필요 → 본 세션에서 점검. 하드코딩이면 매니페스트 기반 조회로 소폭 수정 가능하나, L3 보류 방침이므로 **upbit는 현재 동작 그대로 두고 dowon_trading bootstrap 때 규약을 먼저 고정**

- **G14. `phases/HARNESS_CHANGELOG.md` 처리**
  - upbit에 **유지** (레거시 원본)
  - harness-meta/sessions/upbit/README.md에 참조 링크만

- **G15. hook OS 선택 메커니즘**
  - Step 0에서 Claude Code의 hook 실행 규칙 확인 (settings.json hooks 엔트리에 OS 분기가 있는지)
  - 가능 시나리오:
    - (a) `.ps1`, `.sh` 양쪽 두고 settings.json에서 OS별 엔트리 명시
    - (b) 확장자 기반 자동 선택
    - (c) 단일 wrapper(`session-init.cmd`/`.sh`)가 내부에서 OS 분기
  - 결정은 Step 0 이후

- **G16. 줄바꿈·인코딩**
  - `harness-meta/.gitattributes`에 `*.sh text eol=lf` 강제
  - `*.ps1 text eol=crlf` (Windows 기본)
  - `*.md text` (auto)

- **G17. user-level `~/.claude/CLAUDE.md`**
  - 현 상태 확인: 한국어 응답 스타일만 있음 (harness 무관)
  - **건드리지 않음** 명시. harness 지시는 user CLAUDE.md가 아니라 user commands/skills로만 제공

- **G18. 프로젝트 매니페스트 `.harness.toml`** (G2/G12/G13 통합 해결)
  - 스키마 초안:
    ```toml
    [project]
    name = "upbit"
    language = "python"
    package_manager = "poetry"

    [harness]
    code_dir = "scripts/harness"
    phases_dir = "phases"
    guardrails = "docs/GUARDRAILS.md"
    mcp_server = "harness"

    [architecture]
    meta_ref = "projects/upbit/ARCHITECTURE.md"  # harness-meta repo 내부 경로
    ```
  - 글로벌 hook이 CWD에서 이 파일을 찾아 프로젝트 메타 로드. 없으면 no-op
  - 본 세션에서 **스펙 정의 + upbit용 파일 생성**까지. parser 구현은 bootstrap 세션에서 필요해지면

- **G19. `~/.claude/` 기존 자산 충돌**
  - 확인된 상태: `skills/` 에 `developer-profile`, `mindvault` (harness와 이름 충돌 없음)
  - `commands/`, `agents/`, `output-styles/`, `hooks/`, `statusline/` 디렉토리 존재 여부 install.ps1 실행 시 먼저 점검
  - 충돌 정책: **중단 + 경고**. `--force` 옵션 시에만 `~/.claude/backup-<timestamp>/`에 이동 후 덮어쓰기
  - 디렉토리 자체는 부재 시 자동 생성

- **G20. 버전 축 2중 구분** (README 명시 필수, 단순화 채택)
  - (1) **repo semver**: harness-meta repo 전체. `sessions/meta/vX.Y/`와 `sessions/{project}/vX.Y/`가 **같은 축 공유**. 본 세션 = v1.0
  - (2) **프로젝트별 비즈니스 semver**: 각 프로젝트 기능 개발 (upbit 봇 `phases/v0.1~v1.5` 등). 본 repo와 무관
  - **upbit 레거시 이관**: 기존 v1.1~v1.4는 `sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/` 접미사로 식별 (글로벌화 이전 프로젝트-내부 관리 시절)
  - **본 세션 upbit 관점**: 별도 `sessions/upbit/v1.0-*/` 디렉토리 만들지 않음. 본 세션(`sessions/meta/v1.0-bootstrap/`)이 repo 전체를 다루고, upbit 관점 요약은 `projects/upbit/DECISIONS.md`에 "글로벌화 이전/이후" 섹션으로 흡수
  - **차후 upbit-전용 개선**: `sessions/upbit/vX.Y-{name}/` (repo semver와 동기. 예: repo v1.1 사이클 중 upbit만의 개선 → `sessions/upbit/v1.1-{name}/`)

- **G21. 타 기기 재현 절차** (README 섹션 필수)
  - 단계:
    1. `git clone https://github.com/pdw96/harness-meta ~/harness-meta` (경로는 권장치, 다르면 `HARNESS_META_ROOT` 환경변수 설정)
    2. Windows Dev Mode ON 확인
    3. PowerShell 7+ 설치
    4. `cd ~/harness-meta && pwsh ./install.ps1`
    5. 각 프로젝트 clone 후 해당 프로젝트에 `.harness.toml` 존재 확인
    6. Claude Code 세션 재시작
  - README에 위 절차 + `HARNESS_META_ROOT` 기본값 문서화

## 성공 기준

- [ ] Step 0 `research.md` 작성 완료 (5개 문항 전부 답 확정)
- [ ] `C:/Users/qkreh/harness-meta/` 구조 전부 존재 + 파일 작성 완료
- [ ] `.gitattributes` 존재 + `*.sh eol=lf` 규칙 적용
- [ ] `bootstrap/manifest-schema.md`에 `.harness.toml` 스펙 기재
- [ ] `upbit/.harness.toml` 작성 + 필드 5개(project/harness/architecture) 전부 채워짐
- [ ] `~/.claude/commands/harness-*.md` 등 symlink 5 카테고리(commands/agents/skills/output-styles/hooks) + statusline 생성 + `Get-Item` 속성에 `ReparsePoint` 플래그 확인
- [ ] `~/.claude/settings.json` 존재 + `hooks.SessionStart`, `statusLine.command` 2 필드 로드 가능
- [ ] install.ps1이 충돌 시 **중단 + 경고** 동작 수동 테스트 통과
- [ ] upbit 루트에서 새 Claude Code 세션 열었을 때:
  - [ ] `What skills are available?` 응답에 harness-* 목록(meta/plan/design/run/ship/review) 노출 — symlink 인식 실증 (R6 회피)
  - [ ] `/harness` 글로벌 경로에서 로드
  - [ ] `/harness-plan`, `/harness-design`, `/harness-run`, `/harness-ship`, `/harness-review`, `/harness-meta` 모두 실행 가능
  - [ ] session-init hook이 `.harness.toml`에서 "프로젝트=upbit" 정상 판별 (로그 확인)
  - [ ] statusline이 진행 phase/step 표시 (기존 동작 유지)
- [ ] upbit `poetry run pytest tests/ -q` 회귀 0건
- [ ] upbit `poetry run pytest scripts/tests/ -q` 회귀 0건
- [ ] upbit `poetry run mypy bot/ config/ --strict` 회귀 0건
- [ ] upbit `.claude/commands,agents,skills/harness-*` / `output-styles/harness-engineer.md` / `statusline.sh` / `hooks/session-init.*` 부재 확인
- [ ] upbit `.mcp.json` 유지 확인 (서버 이름 `harness`)
- [ ] upbit `phases/HARNESS_CHANGELOG.md` 유지 확인
- [ ] upbit `harness-meta/` 디렉토리에 README.md 1개만 존재
- [ ] `projects/upbit/ARCHITECTURE.md`가 현 `scripts/harness/` 레이아웃과 일치 (수동 대조)
- [ ] README.md에 버전 축 3중 표 + 타 기기 재현 절차 섹션 존재
- [ ] 두 repo 모두 commit + push 완료
- [ ] 무관 프로젝트(예: 홈 디렉토리)에서 Claude Code 세션 열 때 글로벌 hook 무간섭 확인
- [ ] dowon_trading 루트에서 Claude Code 세션 열 때 `.harness.toml` 부재로 hook no-op 확인, `/harness-meta dowon_trading` 호출 시 **bootstrap 분기** 메시지 확인 (실제 bootstrap은 별도 세션)

## 커밋 전략

- harness-meta repo: 작업 단위별 커밋 (순서)
  - (1) `chore: scaffold repo structure + gitattributes`
  - (2) `docs(meta): v1.0-bootstrap plan + step 0 research`
  - (3) `feat: manifest schema for .harness.toml`
  - (4) `feat: global claude integration layer (project-neutralized)`
  - (5) `feat: statusline script with cwd detection`
  - (6) `feat: session-init hook with manifest-based detection`
  - (7) `feat: projects/upbit snapshot (architecture/decisions/stack/interview)`
  - (8) `docs: migrate upbit v1.1~v1.4 history (origin: upbit@<SHA>)`
  - (9) `feat: install.ps1 with dev-mode guard + safe conflict policy` ← **upbit `.harness.toml` 배치 후 install**
  - 세션 종료 시 (10) `docs: v1.0-bootstrap report` + README 최종 업데이트
- upbit repo 커밋 순서:
  - (A) `feat(harness): add .harness.toml manifest` — **harness-meta commit 9(install) 전에 먼저** 수행. 이후 install 실행 시 upbit는 이미 매니페스트 활성 상태 → statusline/hook 즉시 정상 작동
  - (B) `refactor(harness): migrate to global harness-meta repo` — 로컬 `.claude/harness-*`, `harness-meta/v1.1~v1.4/` 제거 + `CLAUDE.md`에 `@~/harness-meta/projects/upbit/ARCHITECTURE.md` include. install 실행 + 동작 검증 **후**
- **교차 시퀀싱**:
  1. harness-meta: commits 1~8 완료 + push
  2. upbit: commit A (`.harness.toml` 추가) + push
  3. harness-meta: commit 9 (install.ps1) + push
  4. 사용자 환경에서 install.ps1 실행 → symlink 생성
  5. 동작 검증 (harness-* skill 목록 노출, statusline 정상, session-init 정상)
  6. upbit: commit B (로컬 잔재 제거) + push
  7. harness-meta: commit 10 (REPORT) + push
- 각 repo 최종 commit 전 사용자 확인 (CLAUDE.md 규칙: "커밋·배포 전 확인 요청")

## 후속 세션 연결

- `sessions/meta/v1.1-bootstrap-templates` — `bootstrap/templates/python-poetry/` 실제 구현 + 인터뷰 기반 생성기
- `sessions/dowon_trading/v0.1-bootstrap` — dowon_trading에 하네스 최초 도입 (인터뷰 → 생성 → ARCHITECTURE 4종 작성)
- `sessions/meta/v1.2-ci` — harness-meta repo에 CI(프롬프트 linter, symlink 검증) 추가
- `phases/v1.5/` (upbit 봇) — Control-Plane-Foundation 기획 재개 (글로벌화 완료 후)

## 위험 / 롤백

- **R1**: symlink 생성 실패 → `install.ps1`이 중단하고 기존 상태 보존. 사용자는 upbit 로컬 `.claude/harness-*` 제거 전에 설치 검증 선행
- **R2**: 글로벌 프롬프트 일반화 중 upbit 맥락 손실 → 이관 후 테스트 회귀로 감지. 실패 시 해당 파일 git revert 후 재작업
- **R3**: upbit 로컬 제거 후 문제 발견 → 두 repo 모두 git 이력으로 복원. push 직전까지는 로컬 reset 가능
- **R4**: Dev Mode 재비활성화 시 symlink 깨짐 → install.ps1이 매번 검증, 깨지면 경고
- **R5**: hook이 harness 없는 repo에서 오동작 → G4 조건부 로드 + G18 매니페스트 부재 시 no-op으로 이중 보호
- **R6**: Step 0 문서 확인 결과 Claude Code가 user-level symlink된 commands/skills를 인식 안 하면 설계 근간 붕괴 → 대안 즉시 검토 (직접 복사 + 업데이트 스크립트 제공)
- **R7**: `.claude/settings.json` merge 규칙이 예상과 다르면 upbit에서 필드 제거 시 동작 변경 → Step 0 결과로 검증, 불확실하면 upbit settings는 건드리지 않고 글로벌은 추가만
- **R8**: statusline 글로벌화 후 upbit에서 기존처럼 동작 안 하면 UX 후퇴 → Step 0에서 statusLine 설정 위치 확인, 문제 시 upbit-local 유지 fallback (G9-b)
- **R9**: `@` import 절대경로가 이식성 깨면 다른 PC에서 CLAUDE.md 수작업 필요 → Step 0 후 symlink 경유 상대경로로 전환 여지 열어둠 (G11)

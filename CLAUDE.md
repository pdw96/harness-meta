# 프로젝트: harness-meta

Claude Code 하네스의 **글로벌 통합 레이어** + **프로젝트별 하네스 아키텍처 기록소**.
개별 프로젝트(`upbit` 등)의 `scripts/harness/` 코드가 프로젝트 고유로 진화하는 동안, 본 repo는 **공통 자산**과 **이력**을 단일 소스로 보관한다.

**License**: MIT ([LICENSE](LICENSE)) — 오픈소스 사용·포크·기여 허용.
**AGENTS.md 관계**: [`AGENTS.md`](AGENTS.md)는 영문 60~80행 요약 (타 AI 도구 + 오픈소스 방문자용). 본 CLAUDE.md가 Claude Code 세션의 **primary** 컨텍스트이며 한국어 상세 운영 가이드. 둘은 의도적으로 다름(baseline + override 패턴). 규약: [`bootstrap/docs/AGENTS_MD_STRATEGY.md`](bootstrap/docs/AGENTS_MD_STRATEGY.md).

## 기술 스택
- Shell scripts (bash, PowerShell 7+) — hook / statusline / install 자동화
- Markdown — slash commands, agents, skills, output-styles, 문서
- Git submodule / symlink 기반 배포 (`~/.claude/` 아래 6 카테고리)
- `.harness.toml` 매니페스트 (TOML v1.0 스키마) — 프로젝트 활성화 진입점

## 구조 규칙 (CRITICAL)

- **글로벌 레이어는 CWD 무관하게 로드**되지만, 각 프로젝트에 간섭하려면 해당 프로젝트 루트에 `.harness.toml`이 있어야 함. 매니페스트 부재 프로젝트는 **no-op** 원칙 유지
- 새 slash command / agent / skill 추가 시 `claude/` 하위에 Markdown 파일만 추가하면 `install.ps1`이 symlink로 배포. **프로젝트별 복제 금지**
- 프로젝트별 하네스 아키텍처 문서(`projects/<name>/`)는 5종(ARCHITECTURE · DECISIONS · INTERVIEW · STACK · ROADMAP) 고정. 새 프로젝트 도입 시 Bootstrap 세션이 5종 모두 생성 (v1.36+)
- 세션 기록은 `sessions/{meta 또는 <project>}/vX.Y-{name}/` 디렉토리에 `PLAN.md` + `REPORT.md` 한 쌍. **index.json / step{N}.md 생성 금지** (재귀 회피). 단, `sessions/<target>/ROADMAP.md` 1 파일은 운영 docs 예외 허용 (v1.36+ 후속 트리거 통합 view 단일 소스)
- 세션 소속 판정은 `bootstrap/docs/OWNERSHIP.md`의 S1–S7 + T1–T5 규약을 따름. PLAN.md 상단에 "세션 소속 근거" 섹션 의무

세부 규약은 @bootstrap/docs/OWNERSHIP.md 참조.
매니페스트 스펙은 @bootstrap/manifest-schema.md 참조.
AGENTS.md 표준 채택·symlink/copy 이중 전략은 @bootstrap/docs/AGENTS_MD_STRATEGY.md 참조.

## 개발 프로세스

- **문서 변경 = 세션 기록**. 스펙·규약 변경은 `sessions/meta/vX.Y-{name}/PLAN.md` 먼저 작성 → 사용자 확인 → 구현 → `REPORT.md` 확정 → 커밋
- 커밋 메시지: conventional commits (`docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`)
- `~/harness-meta/` repo 변경은 **커밋 전 사용자 확인** 필수 (글로벌 레이어는 모든 프로젝트에 영향)
- 세션 간 연결은 REPORT의 "후속 세션" · "선행 세션" 섹션으로만 (T4 크로스 커팅 분할 원칙)

## 명령어

### 설치 / 재설치 (v1.8+ 2단계)
```powershell
# 1단계 — 글로벌 (최초 1회)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1

# 2단계 — 각 프로젝트 (1회, .harness.toml 있는 루트에서)
pwsh $HOME/harness-meta/bootstrap/install-project-claude.ps1   # Windows
bash ~/harness-meta/bootstrap/install-project-claude.sh    # macOS/Linux

# 레이어 변경 후 재설치 (글로벌) — settings.json 설정 idempotent (v1.36e). 파일 충돌 시만 -Force
pwsh $HOME/harness-meta/install.ps1

# 설치 후 자가 검증 (Z/A/B/C/D/E/F/H/I 자동 + G 수동 체크리스트, v1.23+)
pwsh $HOME/harness-meta/verify.ps1   # Windows
bash ~/harness-meta/verify.sh         # macOS/Linux

# pre-commit hook 설치 (1회, smoke-spec-verification + smoke-scope-contract 자동 검증, v1.39+)
pip install pre-commit && pre-commit install
```

- `install.ps1`이 `~/.claude/{commands,hooks,statusline}/` **3 카테고리만** symlink (v1.8+ 축소). legacy harness-* 심볼릭 자동 cleanup. **정기 재실행 시 `-Force` 불필요** — settings.json `hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]` 모두 idempotent no-op (v1.36e). 파일 symlink 충돌 시에만 `-Force` 필요.
- `install-project-claude.{ps1,sh}`가 `bootstrap/templates/_base/.claude/` **17 파일을 프로젝트에 복사** (symlink 아님). 완료 후 `/config → Output style → "Harness Engineer"` 수동 선택.
- `verify.{ps1,sh}`은 read-only 검증 전용 — 타 기기 이전·회귀 감지·설치 직후 점검. **v1.23+** Stage H (overlay 무결성) + Stage I (frontmatter 6축 — `bootstrap/docs/PERMISSION_PATTERN.md` V1/V5/V7/V8/V10) 통합.

**충돌 정책**: 동일 이름 파일 존재 시 **중단 + 경고**. `--force` 플래그로만 `~/.claude/backup-<timestamp>/`에 이동 후 덮어쓰기.

### 프로젝트 활성화 여부 확인
```bash
# 프로젝트 루트에서
cat .harness.toml       # 존재 = 활성 / 부재 = no-op 대상
```

`session-init.sh`와 `statusline.sh`는 CWD의 `.harness.toml`을 찾으며, 부재 시 빈 출력으로 종료.

### 세션 시작 (Claude Code 안에서)

| Command | 용도 |
|---------|------|
| `/harness-meta` | CWD basename을 target으로 추론. hyphen↔underscore 동치 |
| `/harness-meta meta` | **repo 자체 개선 모드** (글로벌 레이어 / bootstrap / README / CLAUDE.md 수정) |
| `/harness-meta <name>` | **프로젝트별 하네스 개선 모드** (`projects/<name>/`, 해당 프로젝트의 `scripts/harness/` 등) |
| `/harness-meta <new-name>` | **Bootstrap 모드** — `.harness.toml` 부재 프로젝트 신규 도입 (사용자 확인 필요) |

세션 소속(meta vs `<name>`) 판정 기준은 @bootstrap/docs/OWNERSHIP.md 참조.

## 디렉토리 구조

```
harness-meta/
├── CLAUDE.md                       # 본 파일 — repo 진입점
├── README.md                       # 설명서 (설치·구조·사용법·트러블슈팅)
├── install.ps1                     # 글로벌 symlink 배포
├── install-skills.ps1              # 글로벌 user-skill 배포 (opt-in, v1.19+)
├── install-skills.sh               # 동일 (macOS/Linux)
├── claude/                         # 글로벌 레이어 (symlink source, v1.8+ 축소)
│   ├── commands/harness-meta.md    # /harness-meta (메타 세션 진입만 글로벌)
│   ├── hooks/session-init.sh       # SessionStart hook (bash-only)
│   └── statusline/statusline.sh    # 실시간 phase/step 표시 (bash-only)
├── bootstrap/                      # 신규 프로젝트 도입 자산
│   ├── manifest-schema.md          # .harness.toml 스펙 (v1.1)
│   ├── docs/                       # OWNERSHIP / AGENTS_MD_STRATEGY / OVERLAY / SKILLS / PHILOSOPHY / PATTERNS
│   ├── install-project-claude.ps1  # 프로젝트별 .claude/ 복사 (Windows)
│   ├── install-project-claude.sh   # 동일 (macOS/Linux)
│   ├── skills/<name>/              # 글로벌 user-skill source (v1.19+) — see bootstrap/docs/SKILLS.md §1
│   └── templates/
│       ├── _base/.claude/          # 언어 불문 baseline (17 파일: commands/agents/skills/output-styles)
│       └── <language>/             # 언어별 overlay (v1.11+ 예정)
├── projects/<name>/                # 프로젝트별 하네스 아키텍처 (4종 고정)
│   ├── ARCHITECTURE.md
│   ├── DECISIONS.md                # H-ADR
│   ├── INTERVIEW.md                # bootstrap 답변 역산
│   └── STACK.md
└── sessions/
    ├── meta/vX.Y-{name}/           # repo 자체 개선 세션
    │   ├── PLAN.md
    │   └── REPORT.md
    └── <project>/vX.Y-{name}/      # 프로젝트별 하네스 개선 세션
        ├── PLAN.md
        └── REPORT.md
```

## 환경변수

| 변수 | 기본값 | 용도 |
|------|--------|------|
| `HARNESS_META_ROOT` | `$HOME/harness-meta` | repo clone 위치 override. `install.ps1`과 hook이 참조 |

그 외 하네스 런타임 환경변수는 각 프로젝트 repo의 `docs/HARNESS.md` 참조 (예: `upbit/docs/HARNESS.md`).

## 관련 문서

- 세션 소속 규약: @bootstrap/docs/OWNERSHIP.md
- `.harness.toml` 스펙: @bootstrap/manifest-schema.md
- AGENTS.md 표준 채택 규약: @bootstrap/docs/AGENTS_MD_STRATEGY.md
- Language overlay 규약 (v1.11+ 인프라): @bootstrap/docs/OVERLAY.md
- 글로벌 user-skill 디렉토리 + 배포 (v1.19+, v1.24 매트릭스 4 skill): @bootstrap/docs/SKILLS.md
- Spec verification (context7) PLAN § 의무 + `harness-plan-verify` SKILL (v1.24+): @bootstrap/docs/SPEC_VERIFICATION.md
- 후속 세션 통합 view (v1.36+, meta + 프로젝트 분리): @sessions/meta/ROADMAP.md (메타 전역) · `projects/<name>/ROADMAP.md` (프로젝트별)
- Bootstrap 인터뷰 흐름 (`/harness-meta <new-name>` 8-stage, 7 유효 질문 + 자동 적용 10건 — manifest 7: Q7/Q8/Q9 자동화 포함 + AGENTS.md 콘텐츠 3: bootstrap_version v1.10b + install_cmd PM 매핑 v1.10c + license 4-tier v1.10e/e2/e3, v1.14 간결화): @bootstrap/interview.md · @bootstrap/docs/INTERVIEW_FLOW.md
- 최신 meta 세션: @sessions/meta/v1.11-language-overlay-infra/PLAN.md (`bootstrap/templates/<language>/.claude/` 언어별 overlay **인프라**만 도입 — 디렉토리 규약 10 lang matrix + Phase 1/2 merge logic + `harness-*` prefix naming convention + placeholder `python/.claude/.gitkeep` + `bootstrap/docs/OVERLAY.md` 14 § 단일 소스. 실 overlay 콘텐츠 0 — v1.11b+ evidence-driven. **Scope contract 첫 정식 적용** — D1~D17 3단계 면밀 분석 + smoke-scope-contract.sh 자동 enumerate 자기 검증 도입. Smoke 8/8 + 회귀 13/13 + stress test A1~A8 = 43/43 PASS)
- frontmatter + Bash() + model/effort 6축 spec: @bootstrap/docs/PERMISSION_PATTERN.md
- 핵심 아키텍처 결정 기록 (ADR): @docs/adr/README.md
- 대상 프로젝트별 문서: `projects/<name>/ARCHITECTURE.md`

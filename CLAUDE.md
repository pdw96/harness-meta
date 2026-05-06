# 프로젝트: harness-meta

Claude Code 하네스의 **글로벌 통합 레이어** + **프로젝트별 하네스 아키텍처 기록소**.
개별 프로젝트(`upbit` 등)의 `scripts/harness/` 코드가 프로젝트 고유로 진화하는 동안, 본 repo는 **공통 자산**과 **이력**을 단일 소스로 보관한다.

**License**: MIT ([LICENSE](LICENSE)) — 오픈소스 사용·포크·기여 허용.
**AGENTS.md 관계**: [`AGENTS.md`](AGENTS.md)는 영문 60~80행 요약 (타 AI 도구 + 오픈소스 방문자용). 본 CLAUDE.md가 Claude Code 세션의 **primary** 컨텍스트이며 한국어 상세 운영 가이드. 둘은 의도적으로 다름(baseline + override 패턴). 규약: [`bootstrap/docs/AGENTS_MD_STRATEGY.md`](bootstrap/docs/AGENTS_MD_STRATEGY.md).

## 모듈별 가이드 (v1.73+ on-demand 로드)

각 모듈 디렉토리 작업 시 Claude Code가 해당 CLAUDE.md를 자동 로드한다 (subdirectory on-demand). 본 root는 진입점 + CRITICAL 규칙만 유지.

| 모듈 | 가이드 | 역할 |
|------|------|------|
| `bootstrap/` | [`bootstrap/CLAUDE.md`](bootstrap/CLAUDE.md) | 인터뷰 / 매니페스트 / templates / 도메인 docs |
| `bootstrap/skills/` | [`bootstrap/skills/CLAUDE.md`](bootstrap/skills/CLAUDE.md) | 글로벌 user-skill 5건 매트릭스 + 작성 규약 |
| `claude/` | [`claude/CLAUDE.md`](claude/CLAUDE.md) | 글로벌 레이어 (hook / statusline / slash command) |
| `tests/` | [`tests/CLAUDE.md`](tests/CLAUDE.md) | smoke 27 매트릭스 + `--fix` mode 패턴 + pre-commit |
| `sessions/` | [`sessions/CLAUDE.md`](sessions/CLAUDE.md) | PLAN/REPORT 규약 + Scope contract + Spec verification + ROADMAP |
| `milestones/` (v1.84+) | — | 메타 milestone 4-tier 컨테이너 — `v{X.Y}_{slug}/{PLAN.md, plan-{n}-{slug}/{PLAN,REPORT}.md, REPORT.md}`. 5-Stage A~E 흐름. ADR-006-workflow-revamp. Meta-only scope (project ROADMAP은 evidence-driven 후속) |

## 기술 스택

- Shell scripts (bash, PowerShell 7+) — hook / statusline / install 자동화
- Markdown — slash commands, agents, skills, output-styles, 문서
- Symlink 기반 배포 (`~/.claude/{commands,hooks,statusline}/`)
- `.harness.toml` 매니페스트 (TOML v1.1) — 프로젝트 활성화 진입점

## 구조 규칙 (CRITICAL)

- **글로벌 레이어는 CWD 무관 로드**되지만 각 프로젝트 간섭은 `.harness.toml` 존재 시만. 매니페스트 부재 프로젝트는 **no-op**
- 새 slash command / agent / skill 추가 시 `claude/` 하위 Markdown만 추가 → `install.ps1`이 symlink 배포. **프로젝트별 복제 금지**
- `projects/<name>/`은 **5종 고정** (ARCHITECTURE · DECISIONS · INTERVIEW · STACK · ROADMAP, v1.36+). Bootstrap 세션이 5종 모두 생성
- 세션 기록은 `sessions/{meta 또는 <project>}/vX.Y-{name}/` 디렉토리에 `PLAN.md` + `REPORT.md` 한 쌍. **index.json / step{N}.md 생성 금지** (재귀 회피). 단, `sessions/<target>/ROADMAP.md` 1 파일은 운영 docs 예외 허용 (v1.36+)
- (v1.84+) **메타 milestone**은 `milestones/v{X.Y}_{slug}/` 4-tier 컨테이너 — milestone PLAN + N개 plan-{n}-{slug}/PLAN+REPORT + 각 PLAN의 phase + milestone REPORT. 5-Stage A~E 흐름. M{N}/ 폐기 (v1.83 revert `295bd16`). ADR-006-workflow-revamp
- 세션 소속 판정은 [`bootstrap/docs/OWNERSHIP.md`](bootstrap/docs/OWNERSHIP.md)의 S1–S7 + T1–T5 규약 (v1.84+ S1d 4-tier 트리). PLAN.md 상단에 "세션 소속 근거" § 의무

세부 규약:

- @bootstrap/docs/OWNERSHIP.md — 세션 소속 + Scope contract
- @bootstrap/manifest-schema.md — `.harness.toml` 스펙
- @bootstrap/docs/AGENTS_MD_STRATEGY.md — AGENTS.md 표준 + symlink/copy 이중 전략

## 개발 프로세스

- **문서 변경 = 세션 기록**. 스펙·규약 변경은 `sessions/meta/vX.Y-{name}/PLAN.md` 먼저 → 사용자 확인 → 구현 → `REPORT.md` 확정 → 커밋
- 커밋 메시지: conventional commits (`docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`)
- `~/harness-meta/` repo 변경은 **커밋 전 사용자 확인 필수** (글로벌 레이어는 모든 프로젝트 영향)
- 세션 간 연결은 REPORT의 "후속 세션" / "선행 세션" 섹션으로만 (T4 크로스 커팅 분할)

상세 PLAN/REPORT 작성 + Scope contract: [`sessions/CLAUDE.md`](sessions/CLAUDE.md).

## 명령어 (요약)

### 설치 / 재설치 (v1.8+ 2단계)

```powershell
# 1단계 — 글로벌 (최초 1회)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1

# 2단계 — 각 프로젝트 (1회, .harness.toml 있는 루트에서)
pwsh $HOME/harness-meta/bootstrap/install-project-claude.ps1   # Windows
bash ~/harness-meta/bootstrap/install-project-claude.sh        # macOS/Linux

# 자가 검증 (Z/A/B/C/D/E/F/H/I 자동 + G 수동, v1.23+)
pwsh $HOME/harness-meta/verify.ps1   # Windows
bash ~/harness-meta/verify.sh         # macOS/Linux

# pre-commit (1회)
pip install pre-commit && pre-commit install
```

상세 충돌 정책 / Force / overlay: [`claude/CLAUDE.md`](claude/CLAUDE.md) + [`bootstrap/CLAUDE.md`](bootstrap/CLAUDE.md). pre-commit + smoke: [`tests/CLAUDE.md`](tests/CLAUDE.md).

### 세션 시작 (Claude Code 안에서)

| Command | 용도 |
|---------|------|
| `/harness-meta` | CWD basename target 추론 |
| `/harness-meta meta` | **repo 자체 개선 모드** |
| `/harness-meta <name>` | **프로젝트별 하네스 개선 모드** |
| `/harness-meta <new-name>` | **Bootstrap 모드** (사용자 확인) |

세션 소속 판정 기준: @bootstrap/docs/OWNERSHIP.md.

### 프로젝트 활성화 여부

```bash
cat .harness.toml       # 존재 = 활성 / 부재 = no-op
```

## 환경변수

| 변수 | 기본값 | 용도 |
|------|--------|------|
| `HARNESS_META_ROOT` | `$HOME/harness-meta` | repo clone 위치 override |

그 외 하네스 런타임 환경변수는 각 프로젝트 repo의 `docs/HARNESS.md` 참조.

## 관련 문서 (핵심)

- 후속 세션 통합 view: @sessions/meta/ROADMAP.md (메타 전역) · `projects/<name>/ROADMAP.md` (프로젝트별)
- 최신 meta 세션 이력: @sessions/meta/ROADMAP.md §8 (최근 완료)
- 세션 소속 + Scope contract: @bootstrap/docs/OWNERSHIP.md
- AGENTS.md 표준: @bootstrap/docs/AGENTS_MD_STRATEGY.md
- 핵심 ADR: @docs/adr/README.md

상세 cross-ref는 각 모듈 CLAUDE.md 참조.

# 프로젝트: harness-meta

Claude Code 하네스의 **글로벌 통합 레이어** + **프로젝트별 하네스 아키텍처 기록소**.
개별 프로젝트(`upbit` 등)의 `scripts/harness/` 코드가 프로젝트 고유로 진화하는 동안, 본 repo는 **공통 자산**과 **이력**을 단일 소스로 보관한다.

**License**: MIT ([LICENSE](LICENSE)) — 오픈소스 사용·포크·기여 허용.
**AGENTS.md 관계**: [`AGENTS.md`](AGENTS.md)는 영문 요약 (타 AI 도구 + 오픈소스 방문자용). 본 CLAUDE.md가 Claude Code 세션의 **primary** 컨텍스트이며 한국어 상세 운영 가이드.
**하네스 엔지니어링 정의** (정전 single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.

@ROADMAP.md

## 모듈별 가이드 (subdirectory on-demand 로드)

각 모듈 디렉토리 작업 시 Claude Code가 해당 CLAUDE.md를 자동 로드한다. 본 root는 진입점 + CRITICAL 규칙만 유지.

| 모듈 | 가이드 | 역할 |
|------|------|------|
| `bootstrap/skills/` | [`bootstrap/skills/CLAUDE.md`](bootstrap/skills/CLAUDE.md) | 글로벌 user-skill 5건 매트릭스 + 작성 규약 |
| `claude/` | [`claude/CLAUDE.md`](claude/CLAUDE.md) | 글로벌 레이어 (hook / statusline / slash command) |
| `tests/` | [`tests/CLAUDE.md`](tests/CLAUDE.md) | smoke 매트릭스 + `--fix` mode 패턴 + pre-commit |
| `projects/meta/` | [`projects/meta/CLAUDE.md`](projects/meta/CLAUDE.md) | **메타 milestone 컨테이너** (lazy load) + ARCHITECTURE.md + ROADMAP.md + 9-stage milestones/ (v2.0+; v1.x 7-stage era + v1.84~v1.88 4-tier era 보존) |
| `projects/upbit/` | — | upbit 프로젝트 ARCHITECTURE.md + ROADMAP.md (milestone 산출물 본체는 upbit repo) |

## 워크플로우 (v2.0+ 9-stage)

```
ROADMAP (입력 source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE
```

각 stage = **단어 = 단일 책임 1:1 매핑** (v2.0_workflow-word-fidelity 정정). 상위 stage 산출물만 입력. 모든 산출물은 **MD 파일 + JSON 코드블록** 포맷 (Claude 컨텍스트 자연 로드 + 자동화 파이프라인 친화).

| Stage | 파일 | 단어 책임 |
|:-:|------|----------|
| (입력) ROADMAP | `projects/<name>/ROADMAP.md` (milestone 등재 단일 source). root `ROADMAP.md` 는 thin index — `{ projects: [{ name, roadmap_path }] }` 만 (smoke 차단) | milestone 목록 (id/title/status/summary/trigger) |
| A. OPEN | `projects/meta/milestones/v{X.Y}_{slug}/` (meta) 또는 프로젝트 repo `milestones/v{X.Y}_{slug}/` (프로젝트) | 컨테이너 마운트 + ROADMAP entry `in_progress` |
| B. INTENT | `.../INTENT.md` | 의도 (goal, motivation, success_criteria, out_of_scope, dependencies) |
| C. RESEARCH | `.../RESEARCH.md` | 조사 (external, codebase, options, risks_identified) |
| D. DESIGN | `.../DESIGN.md` | 설계 (decisions, approach, phases, risk_mitigation) + 5 관점 검토 |
| E. APPROVE | `.../APPROVE.md` | 사용자 명시 승인 게이트 (`approval.approved_by: "user"` + date) |
| F. EXECUTE | `.../execute/phase-{n}.md` | per-phase 구현 (changes, commit) |
| G. VERIFY | `.../VERIFY.md` | 검증 (smoke, criteria_check vs INTENT, verdict) |
| H. REPORT | `.../REPORT.md` | 종합 backward (summary, delta, lessons_learned) |
| I. PROPOSE | `.../PROPOSE.md` | 후속 forward (next_candidates ROADMAP 등록) |

7-stage era (v1.0~v1.4) 보존 milestone 은 산출 5종 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT) + execute. 4-tier era (v1.84~v1.88) 는 sub-plan 보존. 자세한 era 정책: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 6.

## 기술 스택

- Shell scripts (bash, PowerShell 7+) — hook / statusline / install 자동화
- Markdown + JSON 코드블록 — milestone 산출물 + 도메인 docs
- Symlink 기반 배포 (`~/.claude/{commands,hooks,statusline,skills}/`)

## 구조 규칙 (CRITICAL)

- **글로벌 레이어는 CWD 무관 로드**. 프로젝트별 활성화는 `.harness.toml` 존재 시만 (부재 시 hook no-op)
- 새 slash command / hook 추가 시 `claude/` 하위 Markdown만 추가 → `install.ps1`이 symlink 배포
- 새 글로벌 user-skill 추가 시 `bootstrap/skills/<category>/<name>/` → `install-skills.{ps1,sh}` 배포
- `projects/<name>/` 은 **고정 구조**: `ARCHITECTURE.md` (long-lived 참조) + `ROADMAP.md` (JSON 스키마). meta 만 추가로 `CLAUDE.md` (lazy load) + `milestones/` (본 repo 가 곧 작업 공간) 보유 — upbit/기타 프로젝트는 milestones/ 부재 (산출물은 해당 프로젝트 repo)
- milestone 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + `execute/phase-{n}.md`, v2.0+) 은 **MD + JSON 코드블록** 포맷 의무. 7-stage era (v1.0~v1.4) 산출 5종 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT) + execute 도 동일 포맷.
- milestone 번호는 **단조 증가** (`v1.0`부터 시작, underscore로 slug 분리: `v{X.Y}_{slug}`). breaking change 시 major bump.
- `projects/meta/milestones/v1.84~v1.88/` 는 historical 4-tier 포맷 (참조용 보존). 신규 작업은 v2.0+ 9-stage만 (단 `v2.0_workflow-word-fidelity` 자체는 자기참조 회피로 7-stage 포맷 — 예외 표지)
- root `ROADMAP.md` 는 thin index — milestone 등재 금지 (`tests/smoke-projects-scope-discipline.sh` 가 차단)
- APPROVE.md (`approval.approved_by: "user"` + date) 는 **사용자 명시 승인**만 사용 — EXECUTE 진입 게이트. 7-stage era 보존 milestone 은 `DESIGN.approval.approved_by` 동치.

## 개발 프로세스

- **모든 변경은 milestone 기록**. 신규 작업 시 OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE 순 (v2.0+ 9-stage)
- 커밋 메시지: conventional commits (`docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`)
- `~/harness-meta/` repo 변경은 **커밋 전 사용자 확인 필수**
- pre-commit hook 우회 (`--no-verify`)는 **사용자 명시 승인 후만**

## 명령어

### 설치 / 재설치

```powershell
# 글로벌 (최초 1회)
git clone https://github.com/pdw96/harness-meta $HOME/harness-meta
cd $HOME/harness-meta
pwsh ./install.ps1

# 글로벌 user-skill (선택, opt-in)
pwsh ./install-skills.ps1 -All

# 자가 검증
pwsh $HOME/harness-meta/verify.ps1   # Windows
bash ~/harness-meta/verify.sh         # macOS/Linux

# pre-commit (1회)
pip install pre-commit && pre-commit install
```

상세 충돌 정책 / Force: [`claude/CLAUDE.md`](claude/CLAUDE.md). pre-commit + smoke: [`tests/CLAUDE.md`](tests/CLAUDE.md).

### 세션 시작 (Claude Code 안에서)

| Command | 용도 |
|---------|------|
| `/harness-meta` | CWD basename target 추론 |
| `/harness-meta meta` | **repo 자체 개선 모드** |
| `/harness-meta <name>` | **프로젝트별 하네스 개선 모드** |

신규 프로젝트 도입은 첫 milestone (예: `v0.1_setup`)의 EXECUTE phase에서 `.harness.toml` + 프로젝트 docs 생성으로 처리.

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

- 프로젝트 thin index: [`ROADMAP.md`](ROADMAP.md) (root)
- 메타 milestone 목록: [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md)
- 메타 ARCHITECTURE: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md)
- 프로젝트별 ROADMAP: `projects/<name>/ROADMAP.md`
- 핵심 ADR: [`docs/adr/README.md`](docs/adr/README.md)

상세 cross-ref는 각 모듈 CLAUDE.md 참조.

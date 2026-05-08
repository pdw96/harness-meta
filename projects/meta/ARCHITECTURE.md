# meta — Harness Architecture

harness-meta repo 자체의 **하네스** 아키텍처 스냅샷. 글로벌 통합 레이어(slash command / hook / statusline / skills) + 메타 milestone trace 보유. 본 repo가 곧 'meta project'의 작업 공간 — `projects/upbit/` 와 비대칭 (upbit milestones는 upbit repo, meta milestones는 본 repo의 `projects/meta/milestones/`).

> 운영 가이드 + CRITICAL 규칙: root [`../../CLAUDE.md`](../../CLAUDE.md). 글로벌 시스템 도식: [`../../docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md). 영문 요약: [`../../AGENTS.md`](../../AGENTS.md).

## 1. 디렉토리 구조

```
harness-meta/
├── ROADMAP.md                      # thin index — { projects: [{name, roadmap_path}] }
├── CLAUDE.md                       # root 운영 가이드 (@ROADMAP.md 자동 로드)
├── AGENTS.md                       # 영문 요약 (외부 AI 도구 / 오픈소스 방문자용)
├── README.md                       # 사용자 진입 (영문)
├── projects/
│   ├── meta/                       # ★ 본 디렉토리 (meta as project)
│   │   ├── CLAUDE.md               # subdirectory guide — meta 작업 시 lazy load
│   │   ├── ARCHITECTURE.md         # 본 파일
│   │   ├── ROADMAP.md              # meta milestones 5건
│   │   └── milestones/             # 7-stage milestone 산출물
│   │       └── v{X.Y}_{slug}/
│   │           ├── PLAN.md         # intent (goal/success_criteria/out_of_scope/dependencies)
│   │           ├── RESEARCH.md     # findings (external/codebase/options/risks_identified)
│   │           ├── DESIGN.md       # decisions/approach/phases/risk_mitigation/approval
│   │           ├── execute/phase-{n}.md  # per-phase 구현
│   │           ├── VERIFY.md       # smoke/criteria_check/verdict
│   │           └── REPORT.md       # summary/delta/lessons/next_candidates
│   └── upbit/
│       ├── ARCHITECTURE.md
│       └── ROADMAP.md              # upbit milestones는 upbit repo 자체에 위치
├── claude/                         # 글로벌 레이어 (commands/hooks/statusline)
├── bootstrap/skills/               # 글로벌 user-skill 매트릭스
├── tests/                          # smoke + pre-commit autofix
└── docs/{adr,ARCHITECTURE.md}      # 아키텍처 docs + ADR
```

## 2. 모듈 책임 요약

| 모듈 | 역할 | 위임 |
|---|---|---|
| `claude/{commands,hooks,statusline}/` | 글로벌 layer (slash command + hook + statusline) | [`../../claude/CLAUDE.md`](../../claude/CLAUDE.md) |
| `bootstrap/skills/` | 글로벌 user-skill (audit / dev / etc.) | [`../../bootstrap/skills/CLAUDE.md`](../../bootstrap/skills/CLAUDE.md) |
| `tests/` | smoke + pre-commit autofix-or-fail wrapper | [`../../tests/CLAUDE.md`](../../tests/CLAUDE.md) |
| `projects/meta/milestones/` | 메타 milestone 7-stage 기록 | (본 디렉토리) |
| `docs/adr/` | ADR (architecture decision records) | [`../../docs/adr/README.md`](../../docs/adr/README.md) |
| `docs/ARCHITECTURE.md` | 글로벌 시스템 도식 | [`../../docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md) |

## 3. 7-stage workflow

```
ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT
```

자세한 단계별 책임 + 산출 파일 매트릭스는 root [`../../CLAUDE.md`](../../CLAUDE.md) § "워크플로우 (v1.0+ 7-stage)" + slash command [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 참조.

## 4. 비대칭 의도 (CRITICAL)

`projects/meta/milestones/` 는 본 repo 안에 존재하지만 `projects/upbit/milestones/` 는 **부재** — upbit milestone 산출물은 upbit repo 자체에 위치한다 (root CLAUDE.md "프로젝트별 하네스 개선" 컨벤션). meta는 본 repo가 곧 자체 작업 공간이므로 본 repo의 `projects/meta/milestones/` 보유.

이 비대칭은 의도적: `projects/<name>/` 는 "harness-meta 가 인지하는 프로젝트 trace 의 view" 이며, meta 만 본 repo 가 곧 작업 repo 이므로 milestones/ 디렉토리 보유. 미래 N 개 프로젝트 추가 시 동일 패턴 — 작업 repo 가 곧 본 repo 인 경우만 `projects/<name>/milestones/` 보유, 나머지는 ROADMAP + ARCHITECTURE 만.

## 5. 변경 시 주의

- root `CLAUDE.md` / `AGENTS.md` / `docs/ARCHITECTURE.md` 갱신 시 본 ARCHITECTURE.md 동기 검토 (drift risk)
- 신규 milestone 진입 시 `projects/meta/milestones/v{X.Y}_{slug}/` 생성 (root `milestones/` 부활 금지)
- `v1.84` ~ `v1.88` historical (4-tier) 는 참조용 보존, 신규 작업은 7-stage 만
- root ROADMAP.md 는 thin index 유지 — milestones[] 키 추가 금지 (smoke `tests/smoke-projects-scope-discipline.sh` 가 차단)

## 6. 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- 영문 요약: [`../../AGENTS.md`](../../AGENTS.md)
- 글로벌 시스템 도식: [`../../docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md)
- ADR: [`../../docs/adr/README.md`](../../docs/adr/README.md)
- subdirectory CLAUDE.md (lazy): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone (메타): [`ROADMAP.md`](ROADMAP.md)

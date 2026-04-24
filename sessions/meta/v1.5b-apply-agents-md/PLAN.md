# meta v1.5b-apply-agents-md — PLAN

세션 시작: 2026-04-24
선행 세션: [`sessions/meta/v1.5-agents-md-strategy/`](../v1.5-agents-md-strategy/REPORT.md)
목적: **v1.5에서 확정한 AGENTS.md 규약을 본 `~/harness-meta/` repo에 실적용**하여 dogfood 검증한다. 2026-04 최신 실증 데이터(Princeton 2,500+ repo 연구, morphllm 2026 가이드, Claude Code 2026-02 regression 보고) 기반으로 분량·구조·Do/Don't 페어링 최적화.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/harness-meta/{AGENTS.md (신규), CLAUDE.md, README.md}` → 전부 **S3** (repo 정책·루트 문서).
- **T1 경로 다수결** — 3/3 S3 → meta 소유 확정.

## 배경

### v1.5 규약 요약

- **Source of truth**: `AGENTS.md` (영문, §8-1)
- **Claude Code 호환**: `CLAUDE.md`는 symlink 또는 override 파일 (§6 시나리오 A)
- **이중 배포**: Symlink (primary) + Copy (fallback, §4)

### 현 환경 실측 (2026-04-24, 본 repo)

```
git config core.symlinks  → false (Git for Windows 기본값, 변경 불가 권장)
Dev Mode                  → ON
SeCreateSymbolicLinkPrivilege → 없음 (표준 사용자)
```

**결과**: Copy 모드를 본 repo의 영구 모드로 선택 (public repo + 다환경 clone 안전성).

### 2026-04 최신 실증 데이터 기반 재설계

5개 결정 사항 (사용자 승인 2026-04-24):

1. **분량 60~80 라인** (기존 80-120에서 축소) — Princeton 2,500+ repo 연구 기반 150 라인 초과 시 **20-23% 비용 상승 + 성능 저하**. Codex 32 KiB silent truncation cap.
2. **6 essential categories 구조** — morphllm 2026 가이드: Commands / Code style / Project structure / Testing(본 repo는 Session workflow로 대체) / Git workflow(Session workflow로 통합) / Boundaries.
3. **"Rules for AI agents" → "Boundaries" with Do/Don't pairing** — "15+ sequential don'ts cause over-conservative behavior" 실증. 모든 금지 규칙에 구체적 대안 페어링.
4. **"What this repo is / is not" 섹션 제거** — README 중복. "auto-generated AGENTS.md that duplicated README reduced task success" (morphllm).
5. **README.md 상단 개요에 AGENTS.md 언급 (옵션 B)** — 오픈소스 방문자에게 첫인상 시그널.

### AGENTS.md와 CLAUDE.md 의도적 역할 분리

2026-04 실측:
- Claude Code는 CLAUDE.md 우선, AGENTS.md 보조로 읽음
- Claude Code의 AGENTS.md/CLAUDE.md 준수 신뢰성 하락 보고 (2026-02 이후 regression)
- 결론: **CLAUDE.md primary + 한국어 상세**, **AGENTS.md secondary + 영문 요약**

## 목표

- [ ] `~/harness-meta/AGENTS.md` 신규 — **영문, 60~80 라인**, 6 essential categories (Commands / Code style / Project structure / Session workflow / Boundaries / Key docs) + Status
- [ ] 모든 Boundaries 항목 **Do/Don't 페어링**
- [ ] README.md와 **content 중복 80% 미만**
- [ ] **상대경로 only** (절대경로 0건)
- [ ] `~/harness-meta/CLAUDE.md` License 라인 뒤에 "AGENTS.md 관계" 1~2줄 + AGENTS.md 링크
- [ ] `~/harness-meta/README.md` 상단 개요에 AGENTS.md 언급 1줄 (옵션 B) + 관련 문서 섹션 링크 1줄
- [ ] Claude Code `@imports` 미사용 (AGENTS.md 표준 Markdown만)
- [ ] 민감 정보 (Windows user path 등) 0건
- [ ] 본 세션 REPORT — 규약 적용 결과 + dogfood 검증 기록

## 범위

**포함**:
- AGENTS.md 신규 작성 (영문, 60~80 라인)
- CLAUDE.md 최소 갱신 (관계 명시)
- README.md 개요 + 관련 문서 섹션 갱신
- 세션 기록 (PLAN + REPORT)

**제외**:
- Symlink 생성 (Windows `core.symlinks=false` + public repo 안전성)
- Drift 감지 자동화 — v1.21
- 다른 adapter 대응 파일 (GEMINI.md · CONVENTIONS.md · `.cursor/rules/` 등) — 본 repo 공식 편집자 없음
- `.agents/skills/` 신설 — v1.8
- verify.ps1 확장 — v1.21
- upbit AGENTS.md 도입 — S6 별도 세션 (T4 분할)

## 변경 대상

### 신규 파일 (1)

| 경로 | scope | 역할 | 분량 |
|------|-------|------|------|
| `~/harness-meta/AGENTS.md` | S3 | 영문 baseline. 6 essential categories. | **60~80 라인** (150 cap 대비 50%) |

### 수정 파일 (2)

| 경로 | scope | 변경 |
|------|-------|------|
| `~/harness-meta/CLAUDE.md` | S3 | License 라인 뒤에 "AGENTS.md 관계" 1~2줄 (미세 조정: Claude Code 신뢰성 반영) |
| `~/harness-meta/README.md` | S3 | (a) 상단 개요에 AGENTS.md 언급 1줄 (옵션 B) + (b) 관련 문서 섹션 링크 1줄 |

### 세션 기록 (2)

`PLAN.md` (본 파일) / `REPORT.md` (구현 후 작성)

## AGENTS.md 구조 — 6 essential categories

| # | 섹션 | 본 repo 매핑 |
|---|------|------------|
| 1 | Commands | `install.ps1` / `verify.ps1` (build step 없음 명시) |
| 2 | Code style | Conventional Commits · Markdown GFM · 파일명:줄번호 · 영문/한국어 분리 |
| 3 | Project structure | `claude/` · `bootstrap/` · `projects/<name>/` · `sessions/` |
| 4 | Session workflow | PLAN→REPORT 쌍 · OWNERSHIP.md S1-S7+T1-T5 · 세션 소속 근거 헤더 |
| 5 | Boundaries | 5개 Do/Don't 페어링 |
| 6 | Key docs | CLAUDE.md(Korean operational) · OWNERSHIP · AGENTS_MD_STRATEGY · manifest-schema |
| 7 | Status | Public / MIT / v1.25까지 observation-only |

총 7 섹션 + Title/License 1줄 + description 1줄 = ~68 라인 목표.

## 확정 AGENTS.md 초안 (68 라인, 영문)

```markdown
# harness-meta

Global integration layer and per-project architecture archive for Claude Code harness workflows.
License: MIT. See [README.md](README.md) for full project overview.

## Commands

- Install global layer: `pwsh install.ps1` (Windows) — creates symlinks under `~/.claude/`.
- Verify installation: `pwsh verify.ps1` — runs 30 auto-checks (Z/A/B/C/D/E/F/G).
- Force reinstall after conflicts: `pwsh install.ps1 -Force` — backs up existing files to `~/.claude/backup-<ts>/`.

This repo has no build step and no runtime code beyond install/verify scripts.

## Code style

- Conventional Commits with scope: `docs(meta):`, `feat(meta):`, `fix(meta):`, `chore(meta):`. Use `<project-name>` scope for per-project sessions.
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Write in English for `AGENTS.md`, `README.md` headers, and `LICENSE`. Write in Korean for `CLAUDE.md` and session records (primary maintainer's working language).

## Project structure

- `claude/` — source-of-truth for the global Claude Code layer (commands / agents / skills / hooks / statusline / output-styles). Distributed via symlink by `install.ps1`.
- `bootstrap/` — assets for new-project onboarding: `manifest-schema.md`, `docs/OWNERSHIP.md`, `docs/AGENTS_MD_STRATEGY.md`, templates.
- `projects/<name>/` — per-project harness architecture, 4 fixed docs: `ARCHITECTURE.md`, `DECISIONS.md`, `INTERVIEW.md`, `STACK.md`.
- `sessions/meta/vX.Y-<slug>/` and `sessions/<project>/vX.Y-<slug>/` — session records as `PLAN.md` + `REPORT.md` pairs only.

## Session workflow

- Every repo change is a session. Create `sessions/<target>/vX.Y-<slug>/PLAN.md` first, implement, then write `REPORT.md`.
- Session ownership is decided by the scope of changed files, not by CWD. Follow `bootstrap/docs/OWNERSHIP.md` S1–S7 scope classification + T1–T5 tie-breakers.
- Every PLAN.md must include a `## 세션 소속 근거 (self-apply)` block at the top, citing the applied S# / T# in 3–5 lines.

## Boundaries

- Don't edit `projects/<name>/` from a `sessions/meta/` session. Do open a matching `sessions/<name>/vX.Y-<slug>/` session for project-scoped changes (per OWNERSHIP T4).
- Don't create `index.json` or `step{N}.md` under any `sessions/` directory. Do use `PLAN.md` + `REPORT.md` only — this repo avoids recursive harness structure.
- Don't commit `.claude/settings.local.json`. Do stage specific files explicitly (`git add <paths>`); never `git add .` or `-A`.
- Don't push to `origin/main` without explicit user confirmation. Do commit locally first and wait for the user to approve push per commit.
- Don't add tool-specific rule files (`GEMINI.md`, `.cursor/rules/main.mdc`, `CONVENTIONS.md`) proactively. Do add them only when a contributor actively uses that tool, following `bootstrap/docs/AGENTS_MD_STRATEGY.md` §3 mapping matrix.

## Key docs

- Operational manual (Korean, primary for Claude Code): [CLAUDE.md](CLAUDE.md)
- Ownership rules: [bootstrap/docs/OWNERSHIP.md](bootstrap/docs/OWNERSHIP.md)
- AGENTS.md strategy (symlink / copy / mapping matrix): [bootstrap/docs/AGENTS_MD_STRATEGY.md](bootstrap/docs/AGENTS_MD_STRATEGY.md)
- Manifest schema: [bootstrap/manifest-schema.md](bootstrap/manifest-schema.md)
- Latest session: the most recent directory under `sessions/meta/`.

## Status

Public repository, MIT licensed. Formal external contributions (PRs / issues) will be accepted from v1.25 onward, pending `CONTRIBUTING.md` / `SECURITY.md` / `.github/` templates. Until then the repo is observable and forkable but not actively soliciting PRs.
```

**실측 라인 수**: 약 68 라인 (공백 포함). Princeton 150-line cap의 **45%**.

## CLAUDE.md 갱신 (확정 diff)

기존 License 라인 뒤에:

```markdown
**License**: MIT ([LICENSE](LICENSE)) — 오픈소스 사용·포크·기여 허용.
**AGENTS.md 관계**: [`AGENTS.md`](AGENTS.md)는 영문 60~80행 요약 (타 AI 도구 + 오픈소스 방문자용). 본 CLAUDE.md가 Claude Code 세션의 **primary** 컨텍스트이며 한국어 상세 운영 가이드. 둘은 의도적으로 다름(baseline + override 패턴). 규약: [`bootstrap/docs/AGENTS_MD_STRATEGY.md`](bootstrap/docs/AGENTS_MD_STRATEGY.md).
```

## README.md 갱신 (확정 diff, 옵션 B)

### (a) 상단 개요 (기존 3번째 줄 다음에 추가)

```markdown
> 영문 요약은 [`AGENTS.md`](AGENTS.md) 참조 (AI 에이전트 및 오픈소스 방문자용, 60~80 라인).
```

### (b) 관련 문서 섹션

`AGENTS_MD_STRATEGY.md` 줄 바로 위에:

```markdown
- 영문 baseline (AI 에이전트용): [`AGENTS.md`](AGENTS.md)
```

## Grey Areas — 최종 결정 (25건)

| ID | 질문 | 결정 | 근거 |
|----|------|------|------|
| G1 | symlink 적용 | **No** | Windows `core.symlinks=false` + public repo |
| G2 | AGENTS.md ≠ CLAUDE.md 내용 | **의도적 다름** | 영문 baseline vs 한국어 상세. drift 대상 아님 |
| G3 | 다른 adapter 파일 생성 | **No** | 본 repo 공식 편집자 없음 |
| G4 | 분량 | **60~80 라인** | Princeton 연구 150 cap, 비용 20-23% |
| G5 | `.agents/skills/` 신설 | **No** | v1.8 범위 |
| G6 | verify.ps1 확장 | **No** | v1.21 범위 |
| G7 | Claude Code가 AGENTS.md 읽을지 | **무관** | CLAUDE.md primary 전제 |
| G8 | AGENTS.md 언어 | **영문** | §8-1 locale |
| G9 | Status 섹션 포함 | **포함** | 오픈소스 방문자 시그널 |
| G10 | 루트 배치 | **루트** | AGENTS.md 표준 |
| G11 | 섹션 구조 | **6 essential categories + Status** | morphllm 2026 가이드 |
| G12 | License 표기 | **상단 1줄** | LICENSE 파일이 권위 |
| G13 | 세션 번호 표기 | **"most recent directory" 추상** | drift 방지 |
| G14 | 한/영 혼재 | **고유명 한국어 유지, 설명 영문** | 호환성 |
| G15 | 기여자 확대 대비 | **Boundaries에 "proactively No"** | v1.25 이후 대비 |
| G16 | Claude Code 신뢰성 하락 | **짧게 유지** | 2026-02 regression |
| G17 | `@imports` 사용 | **No** | AGENTS.md 표준 준수 |
| G18 | README 중복 방지 | **"What is/not" 섹션 제거** | morphllm 실증 |
| G19 | markdownlint 적용 | **No** | v1.25 범위 |
| G20 | 경로 | **상대경로 only** | PII 방지 |
| G21 | Do/Don't 페어링 | **Boundaries 5/5 페어링 의무** | over-conservative 방지 |
| G22 | License 배치 | **상단 1줄** | 단일 권위 |
| G23 | Claude Code 네이티브 지원 후 | **별도 세션 재평가** | AGENTS_MD_STRATEGY §13-1 |
| G24 | README 상단 vs 관련 문서만 | **옵션 B (둘 다)** | 방문자 첫인상 시그널 |
| G25 | CLAUDE.md 관계 문구 | **"primary" 명시 + 의도적 다름 명시** | Claude Code 신뢰성 대응 |

## 성공 기준

- [ ] `AGENTS.md` 신규 + 영문 + **60~80 라인** + 6 essential categories + Status
- [ ] 모든 Boundaries 항목 **Do/Don't 페어링** (5/5)
- [ ] README와 **content 중복 80% 미만**
- [ ] **상대경로 only** (절대경로 0건, Windows user path 0건)
- [ ] Claude Code `@imports` 미사용 (AGENTS.md 내)
- [ ] `CLAUDE.md` License 라인 뒤에 "AGENTS.md 관계" 1~2줄 + AGENTS.md 링크
- [ ] `README.md` 상단 개요 1줄 + 관련 문서 섹션 1줄 (옵션 B)
- [ ] Grey Area 25건 결정 기록
- [ ] 커밋 + push

## 커밋 전략

단일 커밋:

```
docs(meta): sessions/meta/v1.5b-apply-agents-md — AGENTS.md 본 repo 실적용

- add: AGENTS.md (영문 baseline, ~68 라인)
    6 essential categories: Commands / Code style / Project structure /
    Session workflow / Boundaries (Do/Don't 페어링) / Key docs + Status
- update: CLAUDE.md — AGENTS.md 관계 (primary/secondary 명시)
- update: README.md — 상단 개요 + 관련 문서 링크 (옵션 B)
- add: sessions/meta/v1.5b-apply-agents-md/{PLAN,REPORT}.md

v1.5 규약 dogfood. Copy 모드 (Windows core.symlinks=false).
Princeton 2,500+ repo 연구 기반 분량 최적화 (150 cap 대비 45%).
AGENTS.md 영문 + CLAUDE.md 한국어 의도적 분리.
Grey Area 25건 결정.
```

## 후속 세션 연결

### 직접 연계

- **v1.6-language-neutral-claude-layer** (S1) — hook/statusline/commands Python 하드코딩 제거
- **v1.7-manifest-schema-v1.1** (S2) — `[agents]` + `locale` + `[build]` 필드

### 보류 후보

- `sessions/upbit/vX-agents-md-migration/` — upbit repo의 CLAUDE.md → AGENTS.md (T4 분할, upbit 소유)
- `sessions/meta/vX-claude-native-agents/` — Claude Code AGENTS.md 네이티브 지원 시 재평가
- `sessions/meta/vX-sync-agents-script/` — v1.21보다 앞서 간이 sync 스크립트 구현 (필요 시)

### 3개월 재평가 게이트

본 세션의 "copy 모드 영구 선택"은 Git for Windows 기본값이 유지되는 한 유효. 또한 "분량 60~80 라인" 결정은 Princeton 연구가 유효한 한 지속. Claude Code AGENTS.md 네이티브 지원 시 symlink 모드 전환 재평가.

# meta v1.10b-bootstrap-agents-md — PLAN

세션 시작: 2026-04-27
직접 선행 세션:
- [`sessions/meta/v1.5-agents-md-strategy/`](../v1.5-agents-md-strategy/REPORT.md) — AGENTS.md 채택 규약 (source of truth)
- [`sessions/meta/v1.5b-apply-agents-md/`](../v1.5b-apply-agents-md/REPORT.md) — 본 repo에 AGENTS.md dogfood 적용 (51 라인 baseline)
- [`sessions/meta/v1.10-bootstrap-interview/`](../v1.10-bootstrap-interview/REPORT.md) — Bootstrap 10-stage 흐름 + skeletons

목적: v1.5 규약(AGENTS.md = source of truth, 영문 baseline)을 v1.10 Bootstrap 흐름에 통합. 신규 프로젝트가 부트스트랩 직후 **AGENTS.md baseline (영문) + CLAUDE.md (`@AGENTS.md` import 포함) + 선택 CLAUDE.override.md** 구조로 시작하도록 한다.

본 세션 후 신규 프로젝트는 v1.5 규약 §6 시나리오 A (Claude Code AGENTS.md 미지원 시점) 준수 — CLAUDE.md가 AGENTS.md 내용을 `@import`로 흡수.

## 옵션 B 분할 (T4 — 본 세션 본질 + v1.10c 콘텐츠 자동화 분리)

피라미드 기초 강화 원칙. 검토 7 라운드 누적 후 PLAN 비대화 인지 → **본질만 v1.10b / 콘텐츠 자동화는 v1.10c-bootstrap-content-defaults**.

### v1.10b 본질 (3 산출 + 최소 부수)
- AGENTS.md.tmpl 8 sections (구조 baseline + bootstrap_version stamp + footer link)
- CLAUDE.md.tmpl 3 import 재작성
- CLAUDE.override.md.tmpl 옵션 (Q13 트리거)
- Q13 추가 + S5 sub-step a-e 통합
- v1.10 자산 갱신 (interview.md / INTERVIEW_FLOW.md / slash command / projects skeleton)
- AGENTS.md.tmpl 콘텐츠 자동 default 라인은 **placeholder 형태** — `Install deps: <see project README, PM-specific>` / `License: see LICENSE`. 사용자가 v1.10c 적용 전까지 직접 편집 가능

### v1.10c-bootstrap-content-defaults (후속, S2)
- AGENTS.md.tmpl placeholder → 자동 변수 치환:
  - `License: see LICENSE` → `License: {{license}}` + sed `MIT` default (M2+N8)
  - `Install deps: <see project README>` → `Install deps: {{install_cmd}}` + Claude(Bootstrap) 17개 PM 매핑 (Q1+Q4+N22)
- 신규 변수 2 (license / install_cmd) — sed 13 → 15
- 자동 적용 5 → 7 (manifest 4 + bootstrap_version + license + install_cmd)
- detect-project.sh 변경 검토 (NN23 — install_cmd output 추가 옵션)
- S3 preview 콘텐츠 default 표 example 명세 (G22+W20)
- License MIT default 사용자 의도 차이 안전장치 (G23+Q16)
- install_cmd vs build_cmd 책임 분리 (G24+Q4 — cargo: install=`cargo fetch` / build=`cargo build --release`)

### 분할 근거
- v1.10b 본질 = "AGENTS.md baseline + 시나리오 A 구조 완성" — 사용자 즉시 사용 가능 + 콘텐츠는 placeholder로 미루기
- v1.10c 보강 = "콘텐츠 자동 default + 17 PM 매핑" — 풍부함 향상
- T4 일관성: 각 세션 단일 책임. 본 v1.10b가 만든 AGENTS.md는 사용자가 직접 편집 가능 상태 (license / install_cmd 라인 명시 placeholder), v1.10c가 자동화 적용

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: 신규 3 (모두 S2 — `AGENTS.md.tmpl` + `CLAUDE.override.md.tmpl` + `tests/smoke-bootstrap-agents-md.sh`) + 수정 10 (S2: CLAUDE.md.tmpl + interview.md + INTERVIEW_FLOW.md + projects/ARCHITECTURE.md + projects/INTERVIEW.md + sessions/v0.1-bootstrap/PLAN.md + sessions/v0.1-bootstrap/REPORT.md = 7 / S1a: slash command harness-meta.md = 1 / S3: harness-meta CLAUDE.md + README.md = 2) → 합산 **S2(10) + S1a(1) + S3(2) = 13/13 meta** (NN 라운드 카운트 재산출).
- **T1 경로 다수결** — meta scope 13/13 → meta 확정.
- **T2 스펙 vs 값** — Bootstrap 흐름에 AGENTS.md baseline 추가는 "흐름 스펙" 정의. 각 신규 프로젝트의 AGENTS.md 실 작성·번역은 별도 `sessions/<name>/v0.1-bootstrap/` 세션 (T4 분할).

## 배경

### 현재 격차

v1.10이 Bootstrap 흐름을 10-stage로 고정했으나, **신규 프로젝트는 CLAUDE.md only** 상태 — v1.5 규약 §1 ("AGENTS.md를 source of truth로 채택") 미준수.

```
v1.10 Bootstrap 산출:
  ✅ <proj>/.harness.toml
  ✅ <proj>/CLAUDE.md (skeletons/CLAUDE.md.tmpl)  ← Korean, ARCHITECTURE @import
  ✅ <proj>/docs/GUARDRAILS.md
  ✅ <proj>/{phases_dir}/.gitkeep
  ✅ <proj>/.claude/** (14 파일)
  ❌ <proj>/AGENTS.md                              ← v1.5 §1 source of truth 부재
  ❌ <proj>/CLAUDE.override.md                     ← v1.5 §6 시나리오 A 옵션
```

v1.10 Lessons Forward에 명시된 "신규 프로젝트는 일시적으로 CLAUDE.md only ... v1.10b 후속에서 적용"의 직접 후속.

### 기대 흐름 변화

v1.10의 10-stage S5 (부수 자산 생성)에 `AGENTS.md baseline` 추가 + CLAUDE.md.tmpl 재구성:

```
S5 프로젝트 부수 자산 생성:
   a) <proj>/AGENTS.md (skeletons/AGENTS.md.tmpl, 영문 baseline ~60~80줄)  ← 신규
   b) <proj>/CLAUDE.md (skeletons/CLAUDE.md.tmpl, @AGENTS.md + @ARCHITECTURE.md import + Korean note)
   c) <proj>/CLAUDE.override.md (옵션, Q13 응답 시만 — skeletons/CLAUDE.override.md.tmpl)
   d) <proj>/{HM_GUARDRAILS}/GUARDRAILS.md placeholder
   e) <proj>/{HM_PHASES_DIR}/.gitkeep
```

**Stage 카운트는 10 유지** (S5 안에 a-e sub-step). v1.5 PLAN의 "S5와 S6 사이 S5.5" 제안보다 단순 통합.

### v1.5 규약 §6 시나리오 A 매핑

```
AGENTS.md          ← source of truth (영문, 본 세션 신규)
CLAUDE.md          → @AGENTS.md import + Korean Claude-specific note
CLAUDE.override.md ← (선택) Claude 전용 지시 (Q13 응답 시만 생성)
```

Claude Code가 AGENTS.md 네이티브 지원하면(미래) CLAUDE.md → 단순 symlink 또는 제거 가능 (v1.5 §13.1 트리거 시).

### 본 세션이 미커버 (v1.21로 이연)

- **symlink/copy 자동 분기** (Windows Dev Mode 감지) — v1.21-cross-platform-install 책임
- **AGENTS.ko.md / AGENTS.ja.md 다언어 번역** — v1.5 §8.3 manual policy. locale="ko" 시 placeholder만 안내, 자동 번역 안 함
- **adapter 7종 매핑** (`.cursor/rules/main.mdc`, `.github/copilot-instructions.md` 등) — v1.14~v1.20

## 목표

- [ ] **`bootstrap/skeletons/AGENTS.md.tmpl`** 신규 — 영문 baseline ~80줄 (v1.10b strict). **7 categories + Status = 8 sections** (Setup commands / Code style / Project structure / Session workflow / Testing instructions / PR instructions / Boundaries / Status). 공식 [agents.md](https://agents.md/) sample 4 § 일치 (W5+W11+N14+N21) + Testing instructions § (W5+W11+W15) + AGENTS.md/README.md 관계 (N17) + locale 분기 일반화 + Boundaries generic + Boundaries 3에 `.harness/backups/` 추가 (W17) + bootstrap_version stamp (N27) + footer link (W14+W22). **license / install_cmd는 placeholder 형태 (v1.10c 후속에서 자동 변수 치환)**
- [ ] **`bootstrap/skeletons/CLAUDE.md.tmpl` 재작성** — `@AGENTS.md` + `@~/harness-meta/projects/{{name}}/ARCHITECTURE.md` import + 말미 `@CLAUDE.override.md` import (N1) + Korean Claude Code 전용 안내(output style + override 안내만, AGENTS.md 중복 제거)
- [ ] **`bootstrap/skeletons/CLAUDE.override.md.tmpl`** 신규 — Q13 응답 시만 생성. 빈 § 3개 (사용자 후속) + `## Claude-specific context (Q13 자유 응답)` §에 `{{q13_claude_specific}}` 흡수 (N9)
- [ ] **`bootstrap/interview.md` 갱신** — Q13 신규 + sanity 검증(메타 문자) + 빈 처리 정책 + UX 12 → 13 갱신 + 자유 응답 카운트 2 → 3 본문 정정 (N4)
- [ ] **`bootstrap/docs/INTERVIEW_FLOW.md` 갱신** — Stage S5 sub-step a-e + tmpl 변수 매핑 파일별 분리 표 (AGENTS:14 / CLAUDE:1 / override:2) + Q13 env 미매핑 표기 (N5) + idempotency backup 일원화 (`.harness/backups/<file>.<ts>`)
- [ ] **`bootstrap/skeletons/projects/INTERVIEW.md` 갱신** — Q13 자리 추가 + "명시적 omit 7건 → 9건" 카운트 갱신 (N3, AGENTS.md adapter 7종 + AGENTS.{locale}.md 추가)
- [ ] **`bootstrap/skeletons/projects/ARCHITECTURE.md` 갱신** — "## 5. 후속 작업"의 "AGENTS.md baseline (v1.10b 후속)" → "AGENTS.md baseline 자동 생성 (v1.10b 흐름)"로 정정 (N2)
- [ ] **`bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md`** 갱신 — S5 sub-step a-e 체크박스 확장 + AGENTS.md / CLAUDE.override.md 산출물 표 추가
- [ ] **`claude/commands/harness-meta.md` 갱신** — Stage S5 표 sub-step + 자유 응답 카운트 12 → 13 (N6) + tools list 유지 (v1.10에서 추가됨)
- [ ] **`tests/smoke-bootstrap-agents-md.sh`** 신규 — 6 stage. AGENTS.md.tmpl(**8 sections / 13 sed 변수 + license/install_cmd placeholder**) + CLAUDE.md.tmpl(`@AGENTS.md`+`@ARCHITECTURE.md`+`@CLAUDE.override.md` 3 import) + CLAUDE.override.md.tmpl 검증 (N7 W7) + sed **13 변수** 치환 + `{{` 잔존 0건 + 절대경로 0 + Do/Don't 5 + N17 README 관계 검증 + bootstrap_version stamp 검증 + W17 Boundaries 3 `.harness/backups/` 검증 + W14+W22 footer link 검증 + license/install_cmd placeholder 잔존 검증 (v1.10c 후속에서 sed 추가 검증)
- [ ] **`CLAUDE.md` / `README.md` 갱신** — Bootstrap 흐름 1줄에 AGENTS.md baseline 포함 명시
- [ ] **Grey Area 결정** (옵션 B 분할 후 — v1.10b 본질 21건 + v1.10c 이연 7건)
- [ ] 본 세션 REPORT — 결정 + 차기 세션 + smoke 결과
- [ ] 사용자 확인 후 단일 커밋 + push

## 범위

**포함** (v1.10b 갱신 카운트):
- 인터뷰 질문 — **코어 7 + 옵션 manifest 3 + 자유 3 = 13** (v1.10 12 → v1.10b 13, Q13 신규)
- 자동 적용 — **manifest 4 (v1.10) + AGENTS.md 콘텐츠 3 (v1.10b 신규: license / install_cmd / bootstrap_version) = 합 7**
- skeletons/ — **9종 placeholder** (v1.10 7종: projects 4 + sessions 2 + CLAUDE.md.tmpl + GUARDRAILS.md.tmpl, v1.10b 신규 2종: AGENTS.md.tmpl + CLAUDE.override.md.tmpl)
- AGENTS.md.tmpl 영문 baseline (공식 [agents.md](https://agents.md/) sample 명칭 일치) + CLAUDE.md.tmpl 재구성 (3 import: `@AGENTS.md` + `@~/harness-meta/projects/{{name}}/ARCHITECTURE.md` + 조건부 `@CLAUDE.override.md`)
- smoke 신규 (`tests/smoke-bootstrap-agents-md.sh`, 6 stage — 8 sections + 13 sed 변수 + 3 imports + override marker + footer link + license/install_cmd placeholder)
- v1.10 자산 일관 갱신 (interview.md / INTERVIEW_FLOW.md / slash command / projects skeleton 4종 / sessions skeleton 2종)

**제외 (T4 분할 / 후속 세션)**:
- **symlink/copy 자동 분기** — v1.21-cross-platform-install (`install.sh/.ps1` Dev Mode 감지)
- **AGENTS.ko.md 등 다언어 자동 번역** — v1.5 §8.3 정책 (사용자 manual). locale="ko"면 placeholder 안내만
- **adapter 7종 추가 파일** (`.cursor/rules/`, `.github/copilot-instructions.md`, `GEMINI.md` 등) — v1.14~v1.20 각 adapter 세션
- **`<proj>/AGENTS.md` ↔ `<proj>/CLAUDE.md` drift 감지** (sync-agents.sh) — v1.21
- **upbit retroactive 적용** — upbit는 이미 부트스트랩 완료 (Idempotency). 별도 `sessions/upbit/vX-agents-md-migration/`에서 처리 (T4)
- **v1.10 자산 무변경 명시 (Q3)**: render-manifest.sh / detect-project.sh / install-project-claude.{ps1,sh} / projects-skeleton/{DECISIONS,STACK}.md / sessions-skeleton의 v0.1-bootstrap PLAN/REPORT 외 항목 / GUARDRAILS.md.tmpl — **본 세션 무수정**. install_cmd 매핑은 Claude 처리 (NN22+Q1)

## 변경 대상

### 신규 (3 파일 + 세션)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/skeletons/AGENTS.md.tmpl` | S2 | 영문 baseline (v1.10b strict), **7 categories + Status = 8 sections**, **~80줄** (Princeton 150 cap 53%). 공식 [agents.md](https://agents.md/) sample 4 § 일치 (W5+W11+N14+N21) + AGENTS.md/README.md 관계 1줄 (N17) + locale 분기 일반화 (W1+W3) + Boundaries generic (W2+N10) + Boundaries 3 `.harness/backups/` (W17) + `{{bootstrap_version}}` 자동 stamp (N27) + footer link (W14+W22). **license / install_cmd는 placeholder 형태 (v1.10c 후속)** |
| `bootstrap/skeletons/CLAUDE.override.md.tmpl` | S2 | Claude Code 전용 override placeholder. Q13 응답 시만 생성. `## Claude-specific context (Q13)` § + 빈 § 3개 (N9) |
| `tests/smoke-bootstrap-agents-md.sh` | S2 | 6 stage 검증 — AGENTS.md.tmpl 마커/변수/치환/절대경로/Do-Dont + CLAUDE.md.tmpl 3 import + override.tmpl 마커 |
| `sessions/meta/v1.10b-bootstrap-agents-md/{PLAN,REPORT,evidence/smoke-bootstrap-agents-md.txt}` | meta | 본 세션 기록 |

### 수정 (10) — N12 정정 후

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skeletons/CLAUDE.md.tmpl` | S2 | 재작성 — 3 import (`@AGENTS.md` + `@~/harness-meta/projects/{{name}}/ARCHITECTURE.md` + `@CLAUDE.override.md`) + Korean note 축소 (output style / override 안내만, AGENTS.md 중복 제거 W5+N1) |
| `bootstrap/interview.md` | S2 | Q13 자유 응답 추가 (sanity 검증 + 빈 처리 정책 B) + UX 12 → 13 표시 (W4) + 자유 응답 카운트 본문 2 → 3 (N4) + Stage S5 sub-step a-e 명시 |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | Stage S5 sub-step a-e + tmpl 변수 매핑 파일별 분리 (AGENTS:13 / CLAUDE:1 / override:2) (N13, v1.10b strict) + Q13 env 미매핑 + Claude(Bootstrap) sanity wrap 책임 명시 (Q12) + idempotency backup 일원화 + @import depth ≤ 5 hops (N25). **Stage S3 preview 콘텐츠 default 표 + PM 매핑 17개 매트릭스는 v1.10c 후속** |
| `bootstrap/skeletons/projects/INTERVIEW.md` | S2 | Q13 자리 추가 (Q12 다음, upbit 형식 준용) + "명시적 omit 7 → 9건" 카운트 갱신 (N3) + **"자동 적용 4 → 7건" 갱신 (Q7 — manifest 4 + 콘텐츠 3: license / install_cmd / bootstrap_version)** |
| `bootstrap/skeletons/projects/ARCHITECTURE.md` | S2 | "후속 작업"의 v1.10b 후속 표기 정정 — 자동 생성됨으로 (N2) |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/PLAN.md` | S2 | S5 체크박스 a-e 확장 (AGENTS.md / CLAUDE.md / override / GUARDRAILS / .gitkeep) |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/REPORT.md` | S2 | S5 sub-step 통과 표 + 산출물 표에 AGENTS.md / CLAUDE.override.md 추가 |
| `claude/commands/harness-meta.md` | S1a | Stage S5 표 sub-step 표기 + 자유 응답 카운트 12 → 13 (N6+Q6 — Bootstrap 절차 표 §"S2 인터뷰" 행, 구현 시 grep으로 정확 위치 확인 후 갱신) |
| `CLAUDE.md` | S3 | "Bootstrap 인터뷰 흐름 ... AGENTS.md baseline 포함" 1줄 갱신 |
| `README.md` | S3 | 동일 1줄 갱신 + v1.5 §6 시나리오 A 명시 |

## AGENTS.md.tmpl — 영문 baseline 설계 (7 categories + Status = 8 sections, v1.10b strict)

v1.5b의 51줄 baseline 패턴을 신규 프로젝트용 placeholder로 일반화. **본 세션은 구조 + bootstrap_version stamp + footer link만**. 콘텐츠 자동 default (license / install_cmd) 는 **placeholder 형태로 표기** — v1.10c에서 자동 변수 치환.

```markdown
# {{name}}

<!-- TODO: 1-line project description (post-bootstrap manual edit) -->
Project bootstrapped via Bootstrap v{{bootstrap_version}} flow.
License: see LICENSE. See [README.md](README.md) for project overview (human-readable).

> AGENTS.md complements README.md. AGENTS.md houses build steps / tests / conventions
> for AI coding agents. README.md is for human contributors. (per agents.md spec)

## Setup commands

- Install deps: <see project README, PM-specific> <!-- v1.10c: 자동 추론 (HM_INSTALL_CMD) -->
- Run dev: (project-specific, user adds post-bootstrap)
- Build (compiled languages only): `{{build_cmd}}`
- Harness session: `/harness-plan` → `/harness-design` → `/harness-run` → `/harness-ship`

## Testing instructions

- Run all tests: `{{test_cmd}}`
- Lint: `{{lint_cmd}}`
- Format check: `{{format_cmd}}`
- Type check: `{{type_check_cmd}}`
- All checks must pass before commit (per Boundaries §).
- Add or update tests for the code you change, even if nobody asked. (per agents.md spec)
- Find the CI plan in `.github/workflows/` (or project-specific CI location).

## Code style

- {{language}} {{runtime_version}} ({{package_manager}})
- Markdown: GitHub-flavored. Prefer GFM tables for matrix data over prose. Use `filename:line` syntax for code references.
- Per-project working language: `{{locale}}` for `CLAUDE.md` and session records. English for `AGENTS.md`, `README.md` headers, and `LICENSE` (per `~/harness-meta/bootstrap/docs/AGENTS_MD_STRATEGY.md` §8).

## Project structure

- `{{code_dir}}/` — harness implementation (v1.11+ language overlay or user-authored)
- `{{phases_dir}}/` — execution artifacts: `<version>/<phase>/{PLAN.md, REPORT.md, index.json, step{N}.md}`
- `.harness.toml` — manifest (schema 1.1, generated by Bootstrap interview)
- `.claude/` — Claude Code local config (14 files copied by `install-project-claude.{ps1,sh}`)
- `docs/GUARDRAILS.md` — step-level injected rules (5120 byte cap)
- `CLAUDE.md` — project context (imports this file + per-project ARCHITECTURE.md + optional CLAUDE.override.md)

## Session workflow

- Every change is a session. Create `sessions/<target>/vX.Y-<slug>/PLAN.md` first, implement, then write `REPORT.md`.
- Session ownership is decided by changed-file scope, not by CWD. Follow `~/harness-meta/bootstrap/docs/OWNERSHIP.md` S1–S7 + T1–T5.
- Every PLAN.md must include `## 세션 소속 근거 (self-apply)` block at the top, citing the applied S# / T# in 3–5 lines.

## PR instructions

- Title format: `<type>({{name}}): <subject>` (Conventional Commits — `feat`, `fix`, `docs`, `chore`, etc.)
- Before commit: run `{{test_cmd}}` and `{{lint_cmd}}`. All checks must pass.
- Before push: see Boundaries § (user confirmation required).

## Boundaries

- Don't recursively invoke harness commands from a meta/improvement session. Do open `sessions/<target>/vX.Y-<slug>/` per OWNERSHIP T4 (recursion-free).
- Don't create `index.json` or `step{N}.md` under `sessions/`. Do use `PLAN.md` + `REPORT.md` only.
- Don't commit `.claude/settings.local.json` or `.harness/backups/`. Do stage specific files explicitly (`git add <paths>`); never `git add .` or `-A`.
- Don't push to `origin/main` without user confirmation. Do commit locally first, wait for approval.
- Don't add tool-specific rule files (`.cursor/rules/`, `.github/copilot-instructions.md`, `GEMINI.md`, `CONVENTIONS.md`, `.windsurfrules`, `.clinerules/`, `.roo/rules/`, etc.) proactively. Do add when contributors actively use that tool, per `~/harness-meta/bootstrap/docs/AGENTS_MD_STRATEGY.md` §3 (8 adapter mapping matrix).

## Status

- Bootstrap version: v{{bootstrap_version}}
- Locale: `{{locale}}` (AGENTS.md is English regardless; non-English locales use user-authored `AGENTS.<locale>.md`)
- Adapter: claude-code (single, v1.5 §6 Scenario A — `CLAUDE.md` imports this file via `@AGENTS.md`). Multi-adapter support: v1.14+

---

> Bootstrap flow: [pdw96/harness-meta](https://github.com/pdw96/harness-meta) (Bootstrap v{{bootstrap_version}})
> AGENTS.md spec: [agents.md](https://agents.md/) (open format, Linux Foundation / Agentic AI Foundation)
```

**원칙 (v1.10b strict — 옵션 B)**:
- ~80 라인 (v1.5b 51줄 + 프로젝트 변수 7 sed + 8 sections + footer expansion. license/install_cmd 자동 default는 v1.10c에서 추가, 본 세션은 placeholder)
- **7 categories + Status = 8 sections** (W5+W11+N14+N21 — `Setup commands` / `Code style` / `Project structure` / `Session workflow` / `Testing instructions` / `PR instructions` / `Boundaries` / `Status`). 공식 [agents.md](https://agents.md/) sample 4 § 일치 + PLAN 고유 4 §
- 절대경로 0건 / Do/Don't 5 / `@imports` 미사용 (v1.5b 패턴 준용)
- **본 세션 sed 변수 13개** (name / language / runtime_version / package_manager / code_dir / phases_dir / locale / test_cmd / lint_cmd / format_cmd / type_check_cmd / build_cmd / bootstrap_version) + description placeholder 주석. **license / install_cmd는 v1.10c 후속에서 sed 추가 (placeholder 형태로 표기 유지)**
- **{{description}}** = TODO 주석 + 안전 fallback 1줄 (M3+N7)
- **{{bootstrap_version}}** = sed 치환 시 `1.10b` (N27)
- **placeholder 표기** (v1.10c 적용 전 사용자 직접 편집 가능):
  - `Install deps: <see project README, PM-specific>` ← v1.10c에서 `{{install_cmd}}`로
  - `License: see LICENSE` ← v1.10c에서 `{{license}}`로
- **공식 sample 일치** (N14+N21): `Setup commands` / `Testing instructions` / `PR instructions` 명칭. README.md 관계 1줄 (N17)
- **Code style locale 일반화** (W1) / **Boundaries 1 generic** (W2+N10) / **Status locale "non-English"** (W3) / **Boundaries 3 `.harness/backups/`** (W17) / **Boundaries 5 adapter "etc."** (Q5)
- **footer link** (W14+W22): pdw96/harness-meta + agents.md spec
- **CLAUDE.md** Project structure 항목 — "imports ... + optional CLAUDE.override.md" (N1 정합)

## CLAUDE.md.tmpl — 재작성 (v1.10 → v1.10b)

```markdown
# 프로젝트: {{name}}

<!-- 이 파일은 Bootstrap v0.1 + v1.10b로 자동 생성. 자유롭게 수정. -->
<!-- v1.5 규약 §6 시나리오 A — AGENTS.md 내용을 import하여 단일 source of truth 유지. -->

@AGENTS.md

@~/harness-meta/projects/{{name}}/ARCHITECTURE.md

## Claude Code 전용 안내

- **출력 스타일**: `/config → Output style → "Harness Engineer"` 선택 (S6 install-project-claude 후 수동)
- **Override 파일**: 본 파일 말미 `@CLAUDE.override.md` import (조건부 — Q13 응답 시만 Bootstrap이 import 라인 + 파일 둘 다 생성. Q13 빈 응답 시 import 라인 + 파일 둘 다 미생성 = 안전 분기)

@CLAUDE.override.md

## 후속 작성

- 도메인·비즈니스 규칙은 본 파일 하단에 추가 (영문 baseline은 `AGENTS.md`, Claude 전용 지시는 `CLAUDE.override.md`)
```

**핵심 변화**:
- 본문(기술 스택·하네스 통합·작업 규칙)이 AGENTS.md.tmpl로 이전 → CLAUDE.md는 thin pointer
- **3 import 라인** (N1 반영):
  1. `@AGENTS.md` — v1.5 §6 시나리오 A 핵심
  2. `@~/harness-meta/projects/{{name}}/ARCHITECTURE.md` — 프로젝트별 아키텍처 (v1.10 본문 유지)
  3. `@CLAUDE.override.md` — v1.5 §6 시나리오 A 보강. **Q13 응답 시만 Bootstrap이 import 라인 + override.md 파일 둘 다 생성**. Q13 빈 응답 시 둘 다 생성 안 함
- **Korean note 축소** (W5 + N26 반영) — AGENTS.md Boundaries 4 ("user confirmation before commit/push") + AGENTS.md Session workflow § 중복 항목(세션 기록 형식) 모두 제거. **Claude Code 고유** (output style / override 안내)만 유지
- **`@CLAUDE.override.md` 부재 시 동작** (N16 정정) — context7 [code.claude.com 검증](https://code.claude.com/docs/en/memory)에서 부재 파일 silent skip vs error 명시 답변 부재. **PLAN의 안전 분기**: Bootstrap이 Q13 응답 시에만 import 라인을 추가 → 부재 케이스 자체 회피. 사용자가 수동 import 추가 후 파일 삭제하는 edge case는 사용자 책임
- **Claude Code @import depth ≤ 5 hops** (N25 + context7 검증) — 본 PLAN의 CLAUDE.md.tmpl 3 import 모두 자체 import 미보유 → depth 1 (max 5 대비 여유). 미래 skeleton 추가 시 이 제약 검증 필요

## CLAUDE.override.md.tmpl — Claude 전용 override (Q13 응답 시만 생성)

```markdown
# {{name}} — Claude Code Override

<!-- v1.5 규약 §7. AGENTS.md baseline에 추가되는 Claude Code 전용 지시. -->
<!-- AGENTS.md 내용 중복 금지 — 추가·덮어쓰기만. -->

## Claude-specific tools (사용자 후속 작성)

(예: subagent / skill / output style 호출 정책)

## Claude-specific thinking budget (사용자 후속 작성)

(예: 복잡 task에서 thinking high 강제 등)

## Claude-specific context (Q13 자유 응답)

{{q13_claude_specific}}
```

**생성 조건** (그룹 B + N9 반영):
- Q13 응답을 trim 후 빈 문자열 / "skip" / "-" / "(미설정)" 중 하나면 → **파일 미생성** + CLAUDE.md.tmpl `@CLAUDE.override.md` import 라인 미추가 (W10)
- 그 외 응답 시 → 파일 생성. 응답은 **`## Claude-specific context (Q13 자유 응답)` § 단독 흡수** (위 Claude-specific tools / thinking budget § 2개는 빈 placeholder 유지, 사용자 후속) (N9)
- **응답 sanity 검증 (M5+Q12)**: **Claude(Bootstrap) 자체 처리** — bash helper 미사용 (Q13은 manifest 외부). Claude가 응답 trim → 메타 문자 (`@`, `{{`, `}}`, `<!--`, `<script`) 검출 → 발견 시 fenced code block (\`\`\`text...\`\`\`) 안에 강제 wrap → CLAUDE.override.md.tmpl `{{q13_claude_specific}}` 위치에 삽입. markdown injection 방지

```markdown
## Claude-specific context (Q13 자유 응답)

```
{{q13_claude_specific}}
```
```

(actual nested fence 처리는 Bootstrap이 알아서 — 4-tick 또는 backtick 카운트 증가)

## 인터뷰 변경 — Q13 추가

기존 12 (코어 7 + 옵션 manifest 3 + 자유 2) → **13 (코어 7 + 옵션 manifest 3 + 자유 3)**

| # | 매핑 | 질문 | env |
|---|----|----|----|
| Q11 | INTERVIEW.md + STACK.md / ARCHITECTURE.md | 관측·트레이싱 스택? | (env 미매핑, Claude 메모리만) |
| Q12 | INTERVIEW.md + STACK.md / ARCHITECTURE.md | CI/CD 인프라? | (env 미매핑) |
| **Q13 (신규)** | INTERVIEW.md + CLAUDE.override.md (옵션) | Claude Code 전용 지시? (subagent / skill / thinking 등). skip 가능 | (env 미매핑, sanity 검증 후 fenced wrap) |

**UX 변경 (W4)** — interview.md / INTERVIEW_FLOW.md / slash command의 "한 번에 12 표시"를 **"한 번에 13 표시"**로 일괄 갱신. 자유 응답 카운트 본문 표기 "2 → 3" (N4/N6).

## tmpl 변수 매핑 — 파일별 분리 (v1.10b strict, 옵션 B)

| 파일 | 변수 카운트 | 변수 목록 |
|---|:---:|---|
| `AGENTS.md.tmpl` | **13** sed + 1 placeholder | name / language / runtime_version / package_manager / code_dir / phases_dir / locale / test_cmd / lint_cmd / format_cmd / type_check_cmd / build_cmd / bootstrap_version (+ description은 placeholder 주석, sed 변수 아님). **license / install_cmd는 v1.10c 후속에서 sed 추가** |
| `CLAUDE.md.tmpl` | **1** | name |
| `CLAUDE.override.md.tmpl` | **2** | name / q13_claude_specific |
| `skeletons/projects/*.md` (v1.10 정의) | 15+ | name / language / runtime_version / package_manager / code_dir / phases_dir / meta_ref / guardrails_path / locale / test_cmd / lint_cmd / format_cmd / type_check_cmd / q11_observability / q12_ci |
| `skeletons/sessions/v0.1-bootstrap/*.md` (v1.10 정의) | 4 | name / phases_dir / code_dir / date |

**v1.10b 신규 변수 (3)** — 본 세션 한정:

| 신규 marker | env source | Fallback / 처리 |
|---|---|---|
| `{{bootstrap_version}}` (N27) | (Bootstrap 시점 자동 stamp) | 본 세션 시점 = `1.10b`. 향후 v1.20 등 자동 갱신 |
| `{{q13_claude_specific}}` | (Q13 자유 응답) | sanity 검증 + fenced wrap 후 삽입 (M5). 빈 응답 시 파일 미생성 (W10) |
| `{{description}}` | (env 미정의) | placeholder 주석 처리 (M3+N7) — sed 변수 아님. AGENTS.md.tmpl에 `<!-- TODO -->` + 안전 fallback 1줄로 직접 작성 |

**v1.10c 후속에서 추가될 변수 (2)**:

| 변수 | 처리 |
|---|---|
| `{{license}}` | sed 치환 시 `MIT` 강제. v1.10b는 `License: see LICENSE` placeholder 유지 |
| `{{install_cmd}}` | Claude(Bootstrap) PM 매핑 17개 (uv→`uv sync` 등) 추론. v1.10b는 `Install deps: <see project README, PM-specific>` placeholder 유지 |

## 자동 적용 카운트 (v1.10b strict)

v1.10: manifest 자동 적용 4건 (schema_version + mcp_server + agents.primary + [build]).

v1.10b 신규 추가 (1건):
- `{{bootstrap_version}} → "1.10b"` (Bootstrap 시점 자동 stamp, N27)

→ **v1.10b 자동 적용 = manifest 4 + 콘텐츠 1 = 총 5**.

v1.10c 후속에서 추가될 자동 적용 (2건):
- `{{license}} → "MIT"` (sed 강제, M2+N8)
- `{{install_cmd}}` → 17개 PM 매핑 추론 (Q1+Q4+N22)

→ **v1.10c 적용 후 = manifest 4 + 콘텐츠 3 = 총 7**.

## 명시적 omit (v1.10 7건 + 본 세션 2건 = 9건)

v1.10 omit 7건 그대로 + 추가:
- **AGENTS.md adapter 매핑 파일** (`.cursor/rules/main.mdc`, `.github/copilot-instructions.md`, `GEMINI.md` 등) — v1.14~v1.20 adapter 세션
- **AGENTS.{locale}.md 다언어 번역본** — v1.5 §8.3 manual policy (사용자 후속)

**v1.10 INTERVIEW.md skeleton의 "omit 7건" 표기 갱신 (N3)**: skeletons/projects/INTERVIEW.md 끝의 카운트를 **9건**으로 정정.

## smoke 시나리오 (`tests/smoke-bootstrap-agents-md.sh`, 6 stage)

그룹 A (M1+W7+W8) + v4 그룹 G/M (N14+N21+N27) + v6 W5/W11/W17/W22 반영 — sed **13 변수** (v1.10b strict) + Stage 6 override 검증 + 변수 카운트 명세 (13 sed + 1 placeholder = 14 변수 위치) + **8 sections** + bootstrap_version stamp + Testing instructions § + Boundaries 3 `.harness/backups/` + footer link + license/install_cmd placeholder. install_cmd PM 매핑 17개 + license sed `MIT`는 v1.10c 후속.

```bash
#!/usr/bin/env bash
# v1.10b smoke — AGENTS.md.tmpl + CLAUDE.md.tmpl + CLAUDE.override.md.tmpl 검증 (6 stage)
set -euo pipefail
META_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Stage 1: AGENTS.md.tmpl 존재 + 8 sections (7 categories + Status, W5+W11+N14+N21 반영)
TMPL="$META_ROOT/bootstrap/skeletons/AGENTS.md.tmpl"
[ -f "$TMPL" ] || { echo FAIL S1 AGENTS.md.tmpl missing; exit 1; }
for marker in "## Setup commands" "## Code style" "## Project structure" "## Session workflow" "## Testing instructions" "## PR instructions" "## Boundaries" "## Status"; do
    grep -q "^$marker$" "$TMPL" || { echo "FAIL S1 section missing: $marker"; exit 1; }
done
echo "[Stage 1] AGENTS.md.tmpl 8 sections PASS (공식 agents.md sample 4 § 일치 + PLAN 고유 4 §)"

# Stage 2: AGENTS.md.tmpl 13 sed 변수 (v1.10b strict) + description placeholder + N17 README 관계 + license/install_cmd placeholder
for var in "{{name}}" "{{language}}" "{{runtime_version}}" "{{package_manager}}" \
           "{{code_dir}}" "{{phases_dir}}" "{{locale}}" \
           "{{test_cmd}}" "{{lint_cmd}}" "{{format_cmd}}" \
           "{{type_check_cmd}}" "{{build_cmd}}" "{{bootstrap_version}}"; do
    grep -q "$var" "$TMPL" || { echo "FAIL S2 var missing: $var"; exit 1; }
done
# description은 placeholder 주석 검증 (M3+N7)
grep -q '<!-- TODO: 1-line project description' "$TMPL" || { echo FAIL S2 description placeholder; exit 1; }
# license / install_cmd는 v1.10b strict에서 placeholder 형태 (v1.10c 후속에서 sed 변수 추가)
grep -q 'License: see LICENSE' "$TMPL" || { echo FAIL S2 license placeholder \(v1.10c 이연\); exit 1; }
grep -q 'Install deps: <see project README' "$TMPL" || { echo FAIL S2 install_cmd placeholder \(v1.10c 이연\); exit 1; }
# AGENTS.md complements README.md 명시 (N17)
grep -q 'AGENTS.md complements README.md' "$TMPL" || { echo FAIL S2 README relation; exit 1; }
echo "[Stage 2] AGENTS.md.tmpl 13 sed vars + placeholders (description/license/install_cmd) + README relation PASS"

# Stage 3: CLAUDE.md.tmpl 3 import 라인 (N1 반영)
CLAUDE_TMPL="$META_ROOT/bootstrap/skeletons/CLAUDE.md.tmpl"
grep -q '^@AGENTS.md$' "$CLAUDE_TMPL" || { echo FAIL S3 @AGENTS.md import; exit 1; }
grep -q '@~/harness-meta/projects/{{name}}/ARCHITECTURE.md' "$CLAUDE_TMPL" || { echo FAIL S3 ARCHITECTURE import; exit 1; }
grep -q '^@CLAUDE.override.md$' "$CLAUDE_TMPL" || { echo FAIL S3 @CLAUDE.override.md import; exit 1; }
echo "[Stage 3] CLAUDE.md.tmpl 3 imports PASS"

# Stage 4: AGENTS.md.tmpl sed 치환 mock (13 변수, v1.10b strict — license/install_cmd는 placeholder 그대로, bootstrap_version stamp)
TMP="$(mktemp)"
sed -e 's/{{name}}/my-pyuv/g' \
    -e 's/{{language}}/python/g' \
    -e 's/{{runtime_version}}/3.12/g' \
    -e 's/{{package_manager}}/uv/g' \
    -e 's|{{code_dir}}|scripts/harness|g' \
    -e 's/{{phases_dir}}/phases/g' \
    -e 's|{{test_cmd}}|uv run pytest|g' \
    -e 's|{{lint_cmd}}|uv run ruff check|g' \
    -e 's|{{format_cmd}}|uv run ruff format --check|g' \
    -e 's|{{type_check_cmd}}|uv run mypy src|g' \
    -e 's/{{build_cmd}}//g' \
    -e 's/{{locale}}/ko/g' \
    -e 's/{{bootstrap_version}}/1.10b/g' \
    "$TMPL" > "$TMP"
grep -q '^# my-pyuv$' "$TMP" || { echo FAIL S4 name substitution; exit 1; }
grep -q 'python 3.12 (uv)' "$TMP" || { echo FAIL S4 stack substitution; exit 1; }
grep -q 'License: see LICENSE' "$TMP" || { echo FAIL S4 license placeholder \(v1.10c 이연\); exit 1; }
grep -q 'Install deps: <see project README' "$TMP" || { echo FAIL S4 install_cmd placeholder \(v1.10c 이연\); exit 1; }
grep -q 'Bootstrap version: v1.10b' "$TMP" || { echo FAIL S4 bootstrap_version stamp; exit 1; }
# description은 sed 대상 아님 — placeholder 주석 + fallback 1줄 그대로 잔존 (정상)
! grep -q '{{' "$TMP" || { echo "FAIL S4 unsubstituted vars remain:"; grep '{{' "$TMP"; exit 1; }
echo "[Stage 4] sed 13-var + bootstrap_version stamp + license/install_cmd placeholder PASS — {{ 잔존 0"

# Stage 5: AGENTS.md.tmpl 절대경로 0 + Do/Don't 페어링 5
! grep -E '/c/Users|C:\\\\|qkreh' "$TMPL" || { echo FAIL S5 absolute path detected; exit 1; }
dont_count=$(grep -c '^- Don'\''t' "$TMPL" || echo 0)
[ "$dont_count" -ge 5 ] || { echo "FAIL S5 Do/Don't pairing < 5: $dont_count"; exit 1; }
echo "[Stage 5] absolute path 0 + Do/Don't $dont_count PASS"

# Stage 6: CLAUDE.override.md.tmpl 존재 + Q13 marker + Header (W7 + N9 반영)
OVERRIDE="$META_ROOT/bootstrap/skeletons/CLAUDE.override.md.tmpl"
[ -f "$OVERRIDE" ] || { echo FAIL S6 override.tmpl missing; exit 1; }
grep -q '{{q13_claude_specific}}' "$OVERRIDE" || { echo FAIL S6 q13 marker; exit 1; }
grep -q '^# .* — Claude Code Override$' "$OVERRIDE" || { echo FAIL S6 header; exit 1; }
grep -q '## Claude-specific context' "$OVERRIDE" || { echo FAIL S6 Q13 absorb section; exit 1; }
echo "[Stage 6] CLAUDE.override.md.tmpl marker + header + Q13 § PASS"

rm -f "$TMP"
echo
echo "PASS — bootstrap agents-md smoke (6 stages)"
```

**검증 포인트 (6 stage, v1.10b strict — 옵션 B)**:
1. Stage 1: AGENTS.md.tmpl **8 sections** (7 categories + Status. 공식 agents.md sample 4 § 일치 + PLAN 고유 4 §)
2. Stage 2: 13 sed 변수 마커 + description placeholder 주석 + N17 README 관계 1줄 + W14+W22 footer link + license/install_cmd placeholder 표기 (v1.10c 이연 마커)
3. Stage 3: CLAUDE.md.tmpl 3 import 라인 (`@AGENTS.md` + `@ARCHITECTURE.md` + `@CLAUDE.override.md`, N1)
4. Stage 4: sed 13 변수 치환 후 `{{` 잔존 0 + bootstrap_version stamp + description/license/install_cmd placeholder 그대로
5. Stage 5: 절대경로 0 + Do/Don't 페어링 5+ + Boundaries 3 `.harness/backups/` 명시 (W17)
6. Stage 6: CLAUDE.override.md.tmpl 존재 + Q13 marker + header + 흡수 §

**변수 카운트 명세 (v1.10b strict)**:
- AGENTS.md.tmpl: **13 sed 변수** + 1 placeholder 주석 (description) + 2 v1.10c-이연 placeholder (license / install_cmd 라인) = 총 16 표기 위치
- CLAUDE.md.tmpl: 1 변수 (`{{name}}`)
- CLAUDE.override.md.tmpl: 2 변수 (`{{name}}`, `{{q13_claude_specific}}`)

## Grey Areas — 결정 (옵션 B 분할 후, 21건 v1.10b 본질 + 7건 v1.10c 이연)

**v1.10b 본질 21건**: G1~G15, G17 (bootstrap_version), G18~G21, G25, G26 (Testing instructions §), G27 (footer link), G28 (Bash audit 별도).

**v1.10c-bootstrap-content-defaults로 이연 7건**:
- **G13** description+license — description은 v1.10b (placeholder), license MIT default는 v1.10c
- **G16** install_cmd 변수 + 17 PM 매핑 → v1.10c
- **G22** S3 preview 콘텐츠 default 표 → v1.10c (license/install_cmd 추가 후 의미)
- **G23** License MIT default 안내 → v1.10c
- **G24** install_cmd vs build_cmd 분리 (cargo) → v1.10c

| ID | 질문 | 결정 |
|---|------|------|
| **G1** | AGENTS.md baseline 언어 — 영문 강제 vs locale follow | **영문 강제** (v1.5 §8.1). 한국어 사용자도 AGENTS.md는 영문, CLAUDE.md에 locale 일반화 표기 (W1) |
| **G2** | CLAUDE.md 처리 — symlink vs `@AGENTS.md` import vs copy | **3 import** — `@AGENTS.md` + `@ARCHITECTURE.md` + 조건부 `@CLAUDE.override.md` (N1). symlink는 v1.21 |
| **G3** | CLAUDE.override.md 자동 생성 vs 옵션 | **옵션 (Q13 응답 시만)** — 빈/skip/-/(미설정) 응답 시 파일 + import 라인 둘 다 미생성 (W10) |
| **G4** | AGENTS.md 위치 — root만 vs nested 허용 | **root만** (v1.5 §3 표준). monorepo nested는 v1.23+ |
| **G5** | AGENTS.md 길이 — 51 (v1.5b) vs 60~80 권장 | **~80 라인** (v1.10b strict) — v1.5b 51 + 프로젝트 변수 (13 sed) + PR instructions § + Testing instructions § + README 관계 + footer link expansion. Princeton 150 cap **53%**. v1.10c 적용 후 ~85 라인 (license/install_cmd 변수 치환은 라인 수 무영향) |
| **G6** | AGENTS.{locale}.md placeholder 생성 vs 안내만 | **안내만** (v1.5 §8.3 manual policy). locale="en" 시 redundant 회피 (W3 — Status §에 "non-English locales" 일반화) |
| **G7** | 기존 AGENTS.md / CLAUDE.override.md 처리 (rebootstrap) | manifest와 동일 패턴 (M4) — abort + 사용자 확인 → `<proj>/.harness/backups/<file>.<YYYYMMDD-HHMMSS>` 이동. 디렉토리 + .gitignore append 일원화 |
| **G8** | AGENTS.md content 출처 — v1.5b 51줄 vs from-scratch | **v1.5b 패턴 준용** — 5 category + Status, 프로젝트 변수 주입. Boundaries 1은 generic 화 (W2+N10 — `execute.py` 미언급) |
| **G9** | Stage S5 sub-step (a-e) vs S5.5 신설 | **sub-step** — 10-stage 카운트 유지. PLAN의 S5.5 제안보다 단순 |
| **G10** | adapter 7종 매핑 파일 (`.cursor/rules/`, `.github/copilot-instructions.md` 등) | **본 세션 외** — v1.14~v1.20 adapter 세션 별도. AGENTS.md만 신규 프로젝트에 |
| **G11** | smoke 위치 — 단일 vs `tests/smoke/` 디렉토리 | **`tests/smoke-bootstrap-agents-md.sh`** (단일 파일, v1.10 패턴 일치) |
| **G12** | upbit retroactive 적용 | **본 세션 범위 외** — 별도 `sessions/upbit/vX-agents-md-migration/`. T4 분할 |
| **G13** | `{{description}}` / `{{license}}` 처리 | **description = placeholder 주석** (v1.10b 본질, M3+N7). **license = `License: see LICENSE` placeholder** (v1.10b strict — sed `MIT` default는 v1.10c 이연). Q 카운트 13 유지 |
| **G14** | Q13 응답 markdown injection 방지 | **sanity 검증 + fenced wrap** (M5+Q12) — `@`, `{{`, `<!--`, `<script` 등 메타 문자 포함 시 \`\`\`text \`\`\` block 강제 wrap. **Claude(Bootstrap) 자체 처리** (bash helper 미사용 — Q13 manifest 외부) |
| **G15** | AGENTS.md.tmpl section 명칭 — 공식 sample vs PLAN 자체 dogfood (N14) | **공식 agents.md sample 명칭 일치** — `## Setup commands` (PLAN 원안 `## Commands`에서 변경) + `## PR instructions` § 신규 (N21 — 분산된 PR 흐름 통합). cross-tool 호환 향상 (Codex / Gemini / Cursor 등 기본 인식) |
| **G16** | `{{install_cmd}}` 변수 추가 (N22+Q1+Q4) — **v1.10c 이연** | **v1.10b 본 세션 미포함** — Setup commands에 `Install deps: <see project README, PM-specific>` placeholder만. v1.10c-bootstrap-content-defaults에서 Claude(Bootstrap) PM 매핑 17개 추가 + install_cmd vs build_cmd 분리 |
| **G17** | `{{bootstrap_version}}` 변수 도입 (N27) | **도입** — Bootstrap 시점 자동 stamp (`1.10b`). tmpl 하드코드 회피. 향후 v1.20 등 자동 갱신. AGENTS.md.tmpl Status § 안 |
| **G18** | `@CLAUDE.override.md` 부재 시 동작 (N16 정정) | **context7 검증 — 공식 spec 명시 답변 부재**. 안전 분기: Bootstrap이 Q13 응답 시에만 import 라인 + 파일 둘 다 생성 → 부재 케이스 회피. PLAN 원안 "silent skip 확인됨" 표기 정정 |
| **G19** | AGENTS.md vs README.md 관계 명시 (N17) | **AGENTS.md.tmpl 헤더 직후 1줄 명시** — agents.md 공식 spec "AGENTS.md complements README.md" 핵심 |
| **G20** | @import depth 5 hops 제약 명세 (N25) | **CLAUDE.md.tmpl + INTERVIEW_FLOW.md에 명시** — context7 검증 (max depth 5). 본 PLAN의 3 import는 depth 1 (여유). skeleton 추가 시 검증 |
| **G21** | CLAUDE.md Korean note "세션 기록 형식" 항목 (N26) | **제거** — AGENTS.md Session workflow §와 정보 중복. v1.5 §7.3 baseline 중복 금지 일관 적용 |
| **G22** | Stage S3 preview 범위 — **v1.10c 이연** | v1.10b strict: manifest preview only (v1.10 그대로). v1.10c에서 license/install_cmd 자동 default 추가 시 콘텐츠 default 표 동시 표시 (옵션 A) |
| **G23** | License MIT default 안내 (Q16) — **v1.10c 이연** | v1.10b는 `License: see LICENSE` placeholder. v1.10c에서 sed `MIT` 강제 + S10 후속 안내 (사용자가 LICENSE 파일 직접 편집) |
| **G24** | install_cmd vs build_cmd 책임 분리 (Q4) — **v1.10c 이연** | v1.10c-bootstrap-content-defaults에서 cargo install=`cargo fetch` / build=`cargo build --release` 분리 결정 |
| **G25** | 슬래시 명령 본문 12 → 13 표기 위치 명세 (Q6) | **slash command Bootstrap 절차 표 §"S2 인터뷰" 행** — v1.10이 갱신한 "코어 7 + 옵션 manifest 3 + 자유 2 = 12" 라인. 구현 시 grep으로 정확 위치 확인 후 13으로 갱신 |
| **G26** | `## Testing instructions` § 추가 + Setup commands 축소 (W5+W11+W15) | **추가** — 공식 agents.md sample 4 § 중 핵심. Setup commands에서 test/lint/format/type-check 분리. Testing instructions에 공식 instruction 흡수 ("Add or update tests for the code you change", "All checks must pass before commit", "Find the CI plan in .github/workflows"). § 카운트 7 → 8 |
| **G27** | AGENTS.md.tmpl Status — sessions/ 경로 generic 표기 + footer link (W14+W22) | **경로 제거 + footer 분리** — `Bootstrap version: v{{bootstrap_version}}` 단일 라인. footer에 [pdw96/harness-meta](https://github.com/pdw96/harness-meta) + [agents.md spec](https://agents.md/) link. 다른 컴퓨터/팀원 호환 |
| **G28** | `Bash(git*)` vs `Bash(git:*)` 패턴 audit (W2+W8) | **본 v1.10b 범위 외** — v1.10에서 결정한 frontmatter 변경. context7 공식 sample은 `Bash(cmd:*)` (콜론). PLAN v1.10은 `Bash(cmd*)` (콜론 없음). 별도 chore 세션 `v1.10d-bash-permission-pattern-audit`에서 검증·정정 |

## 성공 기준

- [ ] `bootstrap/skeletons/AGENTS.md.tmpl` 존재 — 7 categories + Status (8 sections) + ~80 라인 (v1.10b strict) + 절대경로 0 + Do/Don't 5 + locale 일반화 + Boundaries generic + Boundaries 3 `.harness/backups/` (W17) + description placeholder + **license/install_cmd placeholder (v1.10c 이연)** + bootstrap_version stamp + AGENTS.md vs README.md 관계 1줄 (N17) + 공식 sample 4 § 일치 (W5+N14+N21) + Testing instructions § (W5+W11+W15) + footer link (W14+W22)
- [ ] `bootstrap/skeletons/CLAUDE.md.tmpl` 재작성 — 3 import (`@AGENTS.md` + `@~/harness-meta/projects/{{name}}/ARCHITECTURE.md` + `@CLAUDE.override.md`) + Korean note 축소 (output style + override 안내만, 세션 기록 형식 항목 제거 N26)
- [ ] `bootstrap/skeletons/CLAUDE.override.md.tmpl` 존재 — Claude 전용 placeholder + Q13 § 흡수 + 빈 § 2개
- [ ] `bootstrap/interview.md` Q13 추가 + sanity 검증 + 빈 처리 정책 + UX 12 → 13 + 자유 응답 카운트 2 → 3
- [ ] `bootstrap/docs/INTERVIEW_FLOW.md` Stage S5 sub-step a-e + tmpl 변수 매핑 파일별 분리 + Q13 env 미매핑 + idempotency backup 일원화 + @import depth ≤ 5 hops 명세 (N25) + Stage S3 preview 표 example (W20 — manifest TOML + AGENTS.md 콘텐츠 default 표 + 사용자 확정 분기 yes/no/back)
- [ ] `bootstrap/skeletons/projects/INTERVIEW.md` Q13 자리 추가 + omit 7 → 9건 정정 (N3) + **자동 적용 4 → 7건 갱신 (Q7 — manifest 4 + 콘텐츠 3)**
- [ ] `bootstrap/skeletons/projects/ARCHITECTURE.md` "후속 작업" v1.10b 후속 → 자동 생성 정정 (N2)
- [ ] `bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md` S5 sub-step a-e 체크박스
- [ ] `claude/commands/harness-meta.md` Stage S5 sub-step + 자유 응답 카운트 12 → 13 (N6)
- [ ] `tests/smoke-bootstrap-agents-md.sh` 6 stage PASS (13 sed 변수 + 8 sections + 3 imports + override marker + footer link + Boundaries 3 backups + license/install_cmd placeholder 잔존 검증)
- [ ] `CLAUDE.md` / `README.md` Bootstrap 1줄 갱신
- [ ] Grey Area 21건 결정 + REPORT 반영 (v1.10c 이연 7건은 v1.10c PLAN에서 결정)
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋 — 본 세션은 v1.10 흐름의 AGENTS.md baseline 통합. 부분 적용 시 Q13 / S5 sub-step 명세 깨짐.

```
feat(meta): sessions/meta/v1.10b-bootstrap-agents-md — AGENTS.md baseline + CLAUDE.md @import 통합

- add: bootstrap/skeletons/AGENTS.md.tmpl (영문 baseline v1.10b strict, 7 categories + Status = 8 sections, ~80 라인, 공식 agents.md sample 4 § 일치 + Testing instructions § + PR instructions § + AGENTS.md/README.md 관계 + bootstrap_version stamp + Boundaries 3 .harness/backups/ + footer link. license/install_cmd는 placeholder 형태 — v1.10c 후속에서 자동 변수 치환)
- add: bootstrap/skeletons/CLAUDE.override.md.tmpl (Q13 응답 시만 생성, sanity wrap)
- update: bootstrap/skeletons/CLAUDE.md.tmpl (3 import — @AGENTS.md + @ARCHITECTURE.md + @CLAUDE.override.md, Korean note 축소 — output style + override 안내만)
- update: bootstrap/interview.md (Q13 + sanity 검증 + UX 12→13 + 카운트 본문 정정)
- update: bootstrap/docs/INTERVIEW_FLOW.md (S5 sub-step a-e + tmpl 매핑 파일별 분리 + Q13 env 미매핑 + backup 일원화 + @import depth ≤ 5 명세)
- update: bootstrap/skeletons/projects/INTERVIEW.md (Q13 자리 + omit 7→9 정정)
- update: bootstrap/skeletons/projects/ARCHITECTURE.md ("후속 작업" v1.10b stamp 정정)
- update: bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md (S5 sub-step a-e)
- update: claude/commands/harness-meta.md (S5 sub-step + 자유 카운트 12→13)
- update: CLAUDE.md / README.md (AGENTS.md baseline 명시)
- add: tests/smoke-bootstrap-agents-md.sh (6 stage, 13 sed 변수 + 8 sections + 3 imports + override marker + footer link + Boundaries 3 backups + license/install_cmd placeholder)
- add: sessions/meta/v1.10b-bootstrap-agents-md/{PLAN,REPORT,evidence/smoke-bootstrap-agents-md.txt}

v1.5 규약 §6 시나리오 A 신규 프로젝트 적용. CLAUDE.md = 3 import (AGENTS+ARCH+override).
공식 agents.md spec 일치 (Setup commands / PR instructions / README.md 관계 명시).
Claude Code @import context7 검증 (max depth 5 hops, 본 PLAN depth 1).
v1.21이 symlink 자동 분기, v1.14~v1.20이 adapter 매핑 추가.

Smoke 6/6 PASS — AGENTS.md 8 sections (공식 agents.md sample 4 § 일치 + PLAN 고유 4 §) + 13 sed 변수 (v1.10b strict) + bootstrap_version stamp + description/license/install_cmd placeholder + README 관계 + Boundaries 3 `.harness/backups/` 명시 + footer link + CLAUDE.md 3 import + override Q13 § + 절대경로 0 + Do/Don't 5.
Grey Area 21건 결정 (v1.10b 본질) + 7건 v1.10c 이연 (G13 license / G16 install_cmd / G22 S3 preview 콘텐츠 default 표 / G23 License MIT 안내 / G24 install_cmd vs build_cmd 분리).
옵션 B T4 분할 — v1.10c-bootstrap-content-defaults 후속 세션 명시.
```

사용자 확인 후 push.

## 후속 세션 연결

### 직접 연계

- **v1.11~v1.13 bootstrap-templates** (S2) — 언어별 overlay (`bootstrap/templates/<language>/`). 본 세션의 AGENTS.md.tmpl은 언어 중립 baseline. overlay에서 언어 특화 카테고리(예: Python: `pyproject.toml` 항목, TS: `tsconfig.json`) 추가 검토
- **v1.14~v1.20 adapter-{cursor,gemini,...}** (S2) — 각 adapter 7종 (Cursor, Gemini CLI, Codex, Windsurf, Cline, Aider, Copilot) 매핑 파일 생성. 본 세션의 AGENTS.md.tmpl을 기반으로 symlink/copy 결정
- **v1.21-cross-platform-install** (S3) — `install.sh/.ps1`이 OS 분기로 symlink vs copy 자동 결정. CLAUDE.md `@AGENTS.md` import → symlink로 전환 옵션 제공
- **v1.22-bootstrap-noninteractive** (S2) — 본 세션 Q13 포함한 13 질문을 JSON config로 일괄 입력
- **v1.23-monorepo-polyglot** (S2) — nested AGENTS.md (서브패키지별)
- **v1.10c-bootstrap-content-defaults** (S2, T4 분할 — **옵션 B 결정**) — v1.10b의 placeholder를 자동 변수 치환으로 변환:
  1. `License: see LICENSE` → `License: {{license}}` + sed `MIT` 강제 (G13+G23+M2+N8)
  2. `Install deps: <see project README>` → `Install deps: {{install_cmd}}` + Claude(Bootstrap) 17개 PM 매핑 (G16+G22+G24+Q1+Q4+N22)
  3. AGENTS.md.tmpl sed 변수 13 → 15
  4. 자동 적용 manifest 4 + 콘텐츠 1 (v1.10b) → manifest 4 + 콘텐츠 3 (v1.10c, +license +install_cmd)
  5. Stage S3 preview 콘텐츠 default 표 example 명세 (W20)
  6. install_cmd vs build_cmd 분리 (cargo: install=`cargo fetch` / build=`cargo build --release`)
  7. detect-project.sh install_cmd output 추가 검토 (NN23)
- **v1.10d-bash-permission-pattern-audit** (S1a, T4 분할) — context7 공식 sample (`Bash(cmd:*)` 콜론) vs PLAN v1.10이 추가한 8종 권한 (`Bash(cmd*)` 콜론 없음) 패턴 audit. 두 형식 작동 차이 검증 + 정정 (필요 시). 본 v1.10b 무수정 (G28)

### 적용 사례

- 신규 프로젝트 추가 시점에 본 v1.10 + v1.10b 흐름 호출 → `sessions/<new-name>/v0.1-bootstrap/`
- upbit는 `sessions/upbit/vX-agents-md-migration/` 별도 세션 (T4 분할)

### Lessons Forward

- v1.5 dogfood 검증 → v1.10 흐름 → v1.10b AGENTS.md 통합 = **3-단계 점진 적용**. T4 분할의 모범 사례
- 신규 프로젝트는 v1.10b 후 v1.5 §6 시나리오 A 완전 준수
- AGENTS.md / CLAUDE.md drift 감지(`sync-agents.sh`)는 v1.21로 이연 — 본 세션은 `@import` 패턴으로 drift 자체를 회피
- **자산 cross-version stamp 정책 (N11)** — 선행 세션이 후속 적용 시 stale될 표기를 갖는 경우, 후속 세션 적용 시 선행 자산의 표기 정정. v1.10 ARCHITECTURE.md skeleton의 "v1.10b 후속" 표기를 본 세션에서 "자동 생성됨"으로 갱신. 이력 보존(v1.9c 원칙)은 **sessions/ 기록물에만 적용**, skeletons/ 같은 운영 자산은 현행 갱신
- **자유 응답 카운트 정책 (W9)** — v1.10 sessions/ 기록의 "자유 응답 2 = 12 질문" 표기는 stale 그대로 유지 (이력 불변). 현행 자산(interview.md / INTERVIEW_FLOW.md / slash command / projects skeleton)만 13으로 갱신
- **공식 spec 일치 정책 (N14+N17+N21)** — v1.5b 51줄 baseline은 자체 dogfood이지만, 신규 프로젝트용 AGENTS.md는 공식 [agents.md](https://agents.md/) sample 명칭 일치 (Setup commands / PR instructions / README.md complement). cross-tool 호환 (Codex / Gemini / Cursor / Copilot 등) 향상. 본 repo의 AGENTS.md는 v1.5b 그대로 보존 (자체 운영 vs 신규 프로젝트는 다른 audience)
- **context7 검증 정책 (N16+N25)** — Claude Code @import 동작은 [code.claude.com 공식 spec](https://code.claude.com/docs/en/memory)에서 검증 (max depth 5 hops 명시, 부재 파일 silent skip 미명시). PLAN의 "확인됨" 표기는 공식 spec 검증 결과 기반으로만 사용 — 미검증 추정은 "안전 분기" 또는 "동작 미보증"으로 표기
- **`{{bootstrap_version}}` stamp 자동 갱신 (N27)** — 본 세션은 `1.10b` 하드코드 sed 치환. 향후 v1.20 등 새 흐름 도입 시 stamp 값만 갱신 (tmpl 본문 무수정). 미래 유지보수 비용 ↓
- **README.md "17 파일" stale (v1.8b 이후 14)** — 본 세션 범위 외, 별도 chore 세션
- **v1.10 자산 무변경 명시 (Q3)** — render-manifest.sh / detect-project.sh / install-project-claude.{ps1,sh} / projects-skeleton/{DECISIONS,STACK}.md / GUARDRAILS.md.tmpl 본 세션 무수정. install_cmd는 detect.sh 출력 추가가 아닌 Claude(Bootstrap) 매핑 (NN22+Q1) — v1.9 자산 보존, T4 분할
- **License MIT default 사용자 의도 차이 (Q16)** — S10 후속 안내에 "License가 MIT 외(Apache-2.0/GPL/proprietary)면 AGENTS.md `License:` 라인 + LICENSE 파일 직접 편집" 명시. detect-project.sh의 LICENSE 파일 SPDX 추출은 v1.10c+ 검토
- **PM 매핑 매트릭스 17개 (Q1) — v1.10c 이연** — detect-project.sh 지원 PM 전부. v1.10b는 placeholder, v1.10c에서 매핑 완성
- **install_cmd vs build_cmd 책임 분리 (Q4) — v1.10c 이연** — cargo 통합 PM은 install=`cargo fetch` / build=`cargo build --release`
- **공식 agents.md sample 4 § 일치 (W5+W11+W15+W16)** — Setup commands / Code style / Testing instructions / PR instructions 4개를 PLAN AGENTS.md.tmpl 8 sections에 포함. cross-tool 호환 (Codex / Cursor / Gemini / Copilot 등 공식 인식). Dev environment tips (공식 5번째)는 monorepo 위주라 v1.23-monorepo-polyglot 이연
- **Boundaries 3 git 추적 오염 방지 (W17)** — `.harness/backups/` 미커밋 안내
- **Status footer link generic 표기 (W14+W22)** — `Bootstrap version: v{{bootstrap_version}}` 단일 라인 + footer에 pdw96/harness-meta + agents.md spec link
- **Bash permission pattern audit (G28)** — 별도 후속 세션 `v1.10d-bash-permission-pattern-audit` (T4 분할)
- **옵션 B T4 분할 (본 PLAN 핵심 결정)** — 검토 7 라운드 누적으로 PLAN 비대화 인지. 본질만 v1.10b (3 산출 + bootstrap_version stamp + footer link + Boundaries 갱신) / 콘텐츠 자동화는 v1.10c (license MIT + install_cmd 17 PM 매핑). 각 세션 단일 책임. v1.10b 적용 후 사용자가 즉시 사용 가능 + license/install_cmd 라인은 placeholder로 직접 편집 가능. v1.10c 적용 후 자동화 완성

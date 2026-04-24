# meta v1.8b-commands-to-skills-migration — PLAN

세션 시작: 2026-04-25
선행 세션: [`sessions/meta/v1.8-core-adapter-split/`](../v1.8-core-adapter-split/REPORT.md)
목적: `_base/.claude/commands/harness*.md` 6개를 **Anthropic 공식 preferred format `.claude/skills/harness-*/SKILL.md`**로 통합 마이그레이션. commands/ 디렉토리 완전 제거 (글로벌 `harness-meta.md`는 별건). skill `name` frontmatter로 slash 호출 UX 유지.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `bootstrap/templates/_base/.claude/commands/*` 6 삭제 + `_base/.claude/skills/*/SKILL.md` 6 신규/재작성 + template 파일 3 유지 + install-project-claude 검증 + `_base/README.md` + OWNERSHIP Evolution → 전부 **S1b/S2**.
- **T1** meta scope 다수결 → meta.
- **T2** commands→skills 스펙 전환 자체가 template 규약 변경 → meta. 각 프로젝트의 `.claude/` 재배포는 T4 후행.

## 배경

### v1.8 REPORT에서 확인된 Anthropic 공식 방향

[code.claude.com/docs/en/agent-sdk/slash-commands](https://code.claude.com/docs/en/agent-sdk/slash-commands) 2026-04:

> Project commands … stored in `.claude/commands/` **(legacy format, prefer `.claude/skills/`)**.

### context7 SKILL.md frontmatter 명세 실측

```yaml
---
name: my-skill                    # slash 호출 이름 (예: /my-skill)
description: What this skill does # Claude 자동 로드 판단 기준
disable-model-invocation: true    # 모델 자동 호출 차단, 사용자 slash만 허용
allowed-tools: Read Grep          # skill 권한 제한 (선택)
argument-hint: "<target>"         # slash 자동완성 힌트 (선택)
---
```

**핵심**: `name` 필드가 동일하면 `/harness-plan` 호출 UX는 **현재와 완전 동일**.

### 현 `_base/.claude/` 파일 구조 실측

```
_base/.claude/
├── commands/          (6)  ← legacy, 삭제 대상
│   ├── harness.md           → skills/harness/SKILL.md
│   ├── harness-plan.md      → skills/harness-plan/SKILL.md
│   ├── harness-design.md    → skills/harness-design/SKILL.md
│   ├── harness-run.md       → skills/harness-run/SKILL.md
│   ├── harness-ship.md      → skills/harness-ship/SKILL.md
│   └── harness-review.md    → skills/harness-review/SKILL.md
├── agents/            (4)   ← subagent, 유지 (slash와 다른 개념)
├── skills/
│   ├── harness-plan/ (SKILL.md disable-model-invocation:true + plan-template.md)
│   ├── harness-design/ (SKILL.md + 7d-checklist.md)
│   └── harness-ship/ (SKILL.md + report-template.md)
└── output-styles/     (1)   ← 유지
```

### agents는 통합 대상 아님

- `agents/harness-{dispatcher,explore,grey-area,verifier}.md` — **subagent** (Task tool 통해 호출)
- skill은 **slash 호출 대상**. 두 개념은 별개
- agents 그대로 유지

### 기존 3 skill의 문제 — `disable-model-invocation: true` 해석

v1.8 `_base/.claude/skills/harness-plan/SKILL.md`는 현재:
```yaml
---
name: harness-plan-template
description: Harness PLAN.md 생성을 위한 템플릿과 작성 가이드...
disable-model-invocation: true
---
```

- `name: harness-plan-template` — slash 이름이 `/harness-plan-template` (우리 의도와 다름!)
- `disable-model-invocation: true` — **사용자 slash는 허용** (context7 확인). 모델 자동 로드만 차단

**결정**: 
- `name`을 **`harness-plan`으로 변경** (slash UX 유지)
- `disable-model-invocation: true` **유지** (사용자 slash + 모델 자동 로드 방지 → 의도적 명시 호출만)

### 신규 skill 3 (harness, harness-run, harness-review)

현재 skill 없음. 신규 SKILL.md 생성. frontmatter:
```yaml
---
name: harness-run
description: Harness 8~9단계 ...
disable-model-invocation: true
argument-hint: ""
---

<기존 commands/harness-run.md 내용>
```

### BREAKING 영향 예측

- `/harness-plan` slash UX — **동일** (name 유지)
- commands/ 디렉토리 부재 — `install-project-claude` 복사 로직이 4 카테고리에서 **commands 빈 상태 skip**. 문제 없음 (이미 `[ ! -d $src ]` 체크 있음)
- upbit는 본 세션 후 `install-project-claude` **재실행 필요** → `.claude/commands/` 삭제 + `.claude/skills/` 업데이트
- 이는 **또 다른 upbit 후행 세션** `sessions/upbit/v1.x-skills-migration/` 필요

## 목표

- [ ] commands 6 삭제 (`git rm`)
- [ ] skills 6개 SKILL.md 재작성 또는 신규:
  - `harness/SKILL.md` (신규, 기존 commands/harness.md 내용)
  - `harness-plan/SKILL.md` (name 수정 + commands/harness-plan.md 통합)
  - `harness-design/SKILL.md` (name 수정 + commands/harness-design.md 통합)
  - `harness-run/SKILL.md` (신규)
  - `harness-ship/SKILL.md` (name 수정 + commands/harness-ship.md 통합)
  - `harness-review/SKILL.md` (신규)
- [ ] template 파일 3 유지 (plan-template.md, 7d-checklist.md, report-template.md)
- [ ] 각 SKILL.md frontmatter: `name`, `description`, `disable-model-invocation: true`, `argument-hint`(선택), `allowed-tools`(선택)
- [ ] `_base/README.md` 갱신 — 파일 수 / legacy 경고 제거 / skills-only 반영
- [ ] OWNERSHIP.md Evolution — v1.8b 항목 추가
- [ ] install-project-claude 확인 — commands 디렉토리 부재 처리 정상
- [ ] smoke — 임시 디렉토리에 install-project-claude 실행 → 13 파일 복사 (commands 6 제거 + skills 6 신규 포함 = 기존 17 → 14 파일 or 동일하게 17? 확인 필요)
- [ ] Grey Area 결정

## 범위

**포함**:
- `_base/.claude/commands/*` 6 삭제
- `_base/.claude/skills/harness-*/` 6 SKILL.md (기존 3 재작성 + 신규 3)
- template 파일 3 유지
- `_base/README.md` 갱신
- OWNERSHIP.md Evolution
- smoke test

**제외 (T4)**:
- upbit `.claude/` 재배포 → `sessions/upbit/v1.1-skills-migration/` (후속)
- install-project-claude.ps1 로직 변경 — 필요 시 반영 (commands 디렉토리 skip 이미 구현)
- agents → skill 통합 (agents는 subagent 용도, skill과 별개 개념 유지)

## 변경 대상

### 삭제 (git rm 6)

```
bootstrap/templates/_base/.claude/commands/harness.md
bootstrap/templates/_base/.claude/commands/harness-plan.md
bootstrap/templates/_base/.claude/commands/harness-design.md
bootstrap/templates/_base/.claude/commands/harness-run.md
bootstrap/templates/_base/.claude/commands/harness-ship.md
bootstrap/templates/_base/.claude/commands/harness-review.md
```

그리고 빈 디렉토리 `bootstrap/templates/_base/.claude/commands/` 삭제.

### 신규/재작성 (6 SKILL.md)

| 경로 | 동작 | 내용 |
|------|------|------|
| `_base/.claude/skills/harness/SKILL.md` | **신규** | harness.md 내용 (dispatcher) |
| `_base/.claude/skills/harness-plan/SKILL.md` | **재작성** | name 수정 + harness-plan.md 통합 |
| `_base/.claude/skills/harness-design/SKILL.md` | **재작성** | name 수정 + harness-design.md 통합 |
| `_base/.claude/skills/harness-run/SKILL.md` | **신규** | harness-run.md 내용 |
| `_base/.claude/skills/harness-ship/SKILL.md` | **재작성** | name 수정 + harness-ship.md 통합 |
| `_base/.claude/skills/harness-review/SKILL.md` | **신규** | harness-review.md 내용 |

### 유지 (3 template)

- `_base/.claude/skills/harness-plan/plan-template.md`
- `_base/.claude/skills/harness-design/7d-checklist.md`
- `_base/.claude/skills/harness-ship/report-template.md`

### 수정 (3 문서)

- `bootstrap/templates/_base/README.md` — skills-only 구조 반영
- `bootstrap/docs/OWNERSHIP.md` — Evolution v1.8b 항목
- (선택) `install-project-claude.{ps1,sh}` — commands 삭제로 14 항목 복사 (17 파일)

### 세션 기록

- `sessions/meta/v1.8b-commands-to-skills-migration/{PLAN,REPORT}.md`
- `sessions/meta/v1.8b-commands-to-skills-migration/evidence/smoke-v1.8b.txt`

## SKILL.md frontmatter 전략 (6개 공통)

```yaml
---
name: <harness 또는 harness-plan 등>
description: <commands .md의 description 발췌>
disable-model-invocation: true
argument-hint: "<기존 commands argument-hint 복사>"
allowed-tools: <기존 commands tools 복사 — Bash, Read, Glob, Grep 등>
model: <기존 commands model 필드 복사 — opus / sonnet / haiku>
thinking: <기존 commands thinking 필드 — high / ...>
---

<기존 commands/*.md 본문 그대로 이관>
```

**주의**: 기존 `harness-plan/SKILL.md`(v1.0)는 **template 역할**. 재작성 시 기존 내용을 `plan-template.md`에 이미 있으므로 SKILL.md에서는 **commands/harness-plan.md 내용으로 대체**.

## Grey Areas — 결정

| ID | 질문 | 결정 |
|----|------|------|
| G1 | agents/harness-*.md도 skill로 통합? | **No** — subagent는 Task tool 호출 대상, skill과 별개 개념 |
| G2 | 기존 harness-plan/SKILL.md (template 용도) 내용 어디에? | plan-template.md에 이미 있으므로 SKILL.md는 commands/harness-plan.md 내용으로 **교체** |
| G3 | `disable-model-invocation: true` 유지 여부 | **유지** — 사용자 slash 허용 + 모델 자동 호출 차단 (의도적 명시 호출만) |
| G4 | `name` 필드 값 | commands 원래 이름 유지 (예: `harness-plan`). slash UX 불변 |
| G5 | 기존 template 파일 3 유지 | ✅ 재사용 가치 + SKILL.md에서 참조 가능 |
| G6 | commands 빈 디렉토리 처리 | **삭제** — install-project-claude에 빈 dir skip 로직 이미 존재 |
| G7 | install-project-claude 수정 필요? | **불필요** — `[ ! -d "$src" ]` 체크로 commands 부재 무관 |
| G8 | smoke 기대 파일 수 | 17 → **11** (commands 6 삭제, skills 6 SKILL.md 신규/재작성 = net -3 또는 -6 여부 실측 필요) |
| G9 | frontmatter `allowed-tools` 정확성 | 기존 commands frontmatter에서 그대로 복사. 엄격한 권한 재검토는 별도 세션 |
| G10 | SKILL.md description 길이 | **50~150자** — Claude 자동 로드 판단에 적절 |
| G11 | upbit 후행 세션 필요? | **필요** — `sessions/upbit/v1.1-skills-migration/`에서 재배포 |
| G12 | Anthropic commands deprecation 완전 제거 시점 대비 | 본 세션이 정확히 그 대비. 공식 제거 시 아무 변경 불필요 |
| G13 | skill 이름 collision (`harness` vs `harness-plan`) | 별 문제 없음 — slash도 각각 독립 |
| G14 | `model` / `thinking` frontmatter 필드 | commands 원본 그대로 복사 (opus+high 등) |
| G15 | SKILL.md가 복잡한 본문 허용 범위 | Claude Code 문서상 제한 명시 없음. commands.md 전체 이관 OK |

## 성공 기준

- [ ] `_base/.claude/commands/` 디렉토리 부재
- [ ] `_base/.claude/skills/` 6개 디렉토리 (harness, harness-plan, harness-design, harness-run, harness-ship, harness-review)
- [ ] 각 skill에 SKILL.md + 선택적 template 파일
- [ ] 각 SKILL.md frontmatter `name` 필드가 해당 slash 이름과 일치
- [ ] smoke — install-project-claude 실행 → 임시 디렉토리에 새 구조 복사 PASS
- [ ] `_base/README.md` 업데이트 (파일 수 / legacy 경고 제거)
- [ ] OWNERSHIP Evolution v1.8b 항목
- [ ] Grey Area 15건 결정
- [ ] 커밋 + push (BREAKING `!` 태그 — 각 프로젝트 재배포 필요)

## 커밋 전략

```
feat(meta)!: sessions/meta/v1.8b-commands-to-skills-migration

- delete: _base/.claude/commands/ (6 files)
- rewrite: _base/.claude/skills/harness-{plan,design,ship}/SKILL.md
           (name 수정 + commands 내용 통합)
- add: _base/.claude/skills/harness{,-run,-review}/SKILL.md (3 신규)
- keep: template 파일 3 (plan-template.md, 7d-checklist.md, report-template.md)
- update: _base/README.md — skills-only 구조
- update: bootstrap/docs/OWNERSHIP.md — Evolution v1.8b
- add: sessions/meta/v1.8b-commands-to-skills-migration/{PLAN,REPORT,evidence}

Anthropic 공식 .claude/commands/ legacy → .claude/skills/ preferred 전환.
skill frontmatter name 유지로 slash UX 불변.
disable-model-invocation:true로 사용자 명시 호출만 허용.

BREAKING: 각 프로젝트는 install-project-claude 재실행 필요.
upbit 후속: sessions/upbit/v1.1-skills-migration/
```

## 후속

- `sessions/upbit/v1.1-skills-migration` — upbit `.claude/` 재배포

---
name: stage-open
description: milestone OPEN stage 진입 시 새 milestone 디렉토리 + MILESTONE.md skeleton + ROADMAP entry 추가 mechanical task. 사용 case = 사용자가 'OPEN stage 진입' / 'milestone v{X.Y} 새로 시작' / 'new milestone 시작' 언급 또는 9-stage workflow Stage A (컨테이너 마운트 + ROADMAP entry in_progress) 진행. SKIP = 'open file' 등 일반 파일 열기 / 'open issue' 등 다른 도메인. 본 skill = ARCHITECTURE.md § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-open — milestone OPEN stage 작성 checklist

> 본 skill 은 `development/ARCHITECTURE.md` § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.16_stage-templated-task-canonicalization-and-skill-pilot 에서 도입 (시범 2 stage skill 중 OPEN). 본 skill 은 stage 본질 = `MILESTONE.md 안 H2 section 1 칸 작성 task` 의 OPEN stage 진입 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

## 입력

이전 stage 위치 = **부재** (OPEN = workflow 시작 stage, 입력 stage 없음). 단 ROADMAP `next_candidates[]` 안 등재된 candidate 1건 = 본 stage trigger source (PROPOSE 발의 후보).

읽을 곳:

- `projects/<name>/ROADMAP.md` — `next_candidates[]` 안 본 milestone candidate entry (id / title / trigger / origin_milestone / target_version / description)
- `projects/<name>/ARCHITECTURE.md` — 정전 single source (§ 3 working definition + § 4 9-stage workflow + § 7 AI Native 운영, name=meta 인 경우)

## 작성할 것

3 mechanical task — narrative judgment 부재 (모두 schema-strict):

### 1. milestone 디렉토리 생성

```
projects/<name>/milestones/v{X.Y}/
```

- `<name>` = meta 또는 외부 project (예: upbit)
- `v{X.Y}` = semver 단조 증가 (직전 milestone + 1, breaking change 시 major bump)
- 디렉토리 명 정합 = `^v\d+\.\d+$` 정규식 (밑줄 부재, sub-id 부재 — v6.2+ 9-stage-flattened era)

### 2. MILESTONE.md skeleton 작성

```yaml
---
id: {kebab-case-slug}
title: {≤ 60자 + Active form 본질 동사 종결 + 한 본질}
version: v{X.Y}
status: open
---

# v{X.Y} — {title}

## INTENT

(미작성 — Stage B INTENT 에서 작성)

## RESEARCH

(미작성 — Stage C RESEARCH 에서 작성)

## DESIGN

(미작성 — Stage D DESIGN 에서 작성)

## APPROVE

(미작성 — Stage E APPROVE 에서 사용자 명시 승인)

## EXECUTE

(미작성 — Stage F EXECUTE 에서 phase 별 작성. 본책 = phase 진행 요약, 별책 = `execute/phase-{n}.md`)

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
```

> **조건부 H2 — `## SCOPE_OUT_NOTES`** (v7.0 T1.3): SUB_MILESTONES 선례 정합 — **거명 있을 때만** 생성하는 선택 섹션 (고정 10 H2 아님). Stage D design-review (N+ 가변) 안 scope 외 거명이 발생하면 PROPOSE 뒤 + SUB_MILESTONES 뒤에 append. next_candidates 자동 등재 부재 (PROPOSE 안 사용자 명시 결정 후만). 1차 source = [`../../development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 11.4.

frontmatter 필드 (v6.2+ flattened era):

- `id`: kebab-case-slug — title 영문 변환 (예: `stage-templated-task-canonicalization-and-skill-pilot`). regex `^[a-z0-9-]+$`.
- `title`: ≤ 60자 (한국어 codepoint) + Active form 본질 동사 종결 (`도입` / `재정의` / `정전화` / `보강` / `갱신` 등) + 한 본질 (' + ' literal 부재).
- `version`: `v{X.Y}` semver (regex `^v\d+\.\d+$`).
- `status`: `open` (OPEN stage 단계) → 진행 stage 따라 `in_progress` → 완료 시 `completed`.

H2 9 섹션 = 8 stage 단어 fidelity + 1 SUB_MILESTONES (v2.0_workflow-word-fidelity 정전화 정합). + 조건부 `## SCOPE_OUT_NOTES` (v7.0 T1.3 — 거명 있을 때만, 고정 섹션 아님).

### 3. ROADMAP entry 추가

`projects/<name>/ROADMAP.md` 안 `milestones[]` array 첫 번째 위치 (recent 안 가장 위) 에 entry append:

```json
{
  "version": "v{X.Y}",
  "id": "{kebab-case-slug}",
  "title": "{title}",
  "status": "in_progress",
  "trigger": "{A_user|B_byproduct|B_regression|D_design}",
  "milestones_path": "milestones/v{X.Y}/MILESTONE.md#sub-milestones",
  "summary": "{origin + 결정 narrative + 후속 자연}"
}
```

추가 후 `updated` 필드 갱신 (예: `2026-05-21-v6.16-open`).

archival 필요 (recent 3 초과) 시 — v5.21+ schema A2 정합. archival 대상 entry 는 REPORT 단계(9-stage)/`## 기록` 시점(가벼운 흐름)에서 처리 (= GitHub Release 발행 + milestones[] trim, v6.19+ GitHub Releases / v8.13 정합. CHANGELOG.md 는 v6.19 까지 historical).

## 검증

OPEN stage 완료 후 회귀 차단 smoke 2건:

```bash
bash tests/smoke-open-stage-discipline.sh
bash tests/smoke-spec-verification.sh
```

기대 결과 = 둘 다 PASS. `meta/v{X.Y}#intent ... #propose` 7개 stage 는 SKIP 자연 (아직 작성 전).

추가 smoke (필요 시):

```bash
bash tests/smoke-entry-title-guideline.sh
```

= title 가이드 (1) ' + ' literal 부재 + (2) ≤ 60자 자동 검증.

## 관련

1차 source narrative:

- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 7.3 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 4 — 9-stage workflow (단어 = 단일 책임 1:1 매핑)
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 6.1 — era 정책 (9-stage-flattened era v6.2+ 의무)
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 7.2 — Entry title 가이드 (4 원칙)

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드 + 워크플로우 진입점
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command (workflow orchestrator)

9 stage skill cross-ref (workflow 순서, v6.18 확장 후 9 stage 전체 cover):

- `skills/stage-open/` — A. OPEN stage (본 skill, v6.16 시범 첫 번째)
- `skills/stage-intent/` — B. INTENT stage (v6.18 확장)
- `skills/stage-research/` — C. RESEARCH stage (v6.18 확장)
- `skills/stage-design/` — D. DESIGN stage (v6.18 확장)
- `skills/stage-approve/` — E. APPROVE stage (v6.18 확장)
- `skills/stage-execute/` — F. EXECUTE stage (v6.18 확장)
- `skills/stage-verify/` — G. VERIFY stage (v6.18 확장)
- `skills/stage-report/` — H. REPORT stage (v6.18 확장)
- `skills/stage-propose/` — I. PROPOSE stage (v6.16 시범 두 번째)

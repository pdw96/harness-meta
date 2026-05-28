---
name: stage-propose
description: milestone PROPOSE stage 작성 시 ## PROPOSE section 안 next_candidates 등재 + ROADMAP `next_candidates[]` append mechanical task. 사용 case = 사용자가 'PROPOSE stage 작성' / 'next_candidates 등재' / 'milestone PROPOSE 진입' 언급 또는 9-stage workflow Stage I (후속 forward — next_candidates ROADMAP 등록) 진행. SKIP = 'propose change' 등 일반 제안 / propose_next 자율 발의 mechanism (= 별 mechanism, /propose-next slash command). 본 skill = WORKFLOW.md § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-propose — milestone PROPOSE stage 작성 checklist

> 본 skill 은 `development/WORKFLOW.md` § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.16_stage-templated-task-canonicalization-and-skill-pilot 에서 도입 (시범 2 stage skill 중 PROPOSE). 본 skill 은 stage 본질 = `MILESTONE.md 안 H2 section 1 칸 작성 task` 의 PROPOSE stage 작성 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## REPORT` 섹션 (Stage H 산출물). REPORT 안 lessons_learned + delta + summary 가 PROPOSE next_candidates 발의 source.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안:
  - `## INTENT` → out_of_scope 안 본 milestone scope 외 항목 (별 milestone candidate)
  - `## RESEARCH` → risks_identified 안 mitigation 부재 항목 (후속 candidate)
  - `## DESIGN` → decisions[].rationale 안 'oos 명시 거명' 항목 (별 milestone candidate)
  - `## REPORT` → lessons_learned 안 P2 라벨 항목 (후속 candidate)
- `projects/<name>/ROADMAP.md` — `next_candidates[]` 안 기존 등재 candidate (dedupe 회피)

자동 발의 mechanism (v6.5+) = `/propose-next` slash command 또는 `python scripts/propose_next.py --scan` (별 mechanism, 본 skill 과 facing 다름). 본 skill = PROPOSE stage 산출물 작성 본질, `/propose-next` = 자율 candidate 제안 mechanism.

## 작성할 것

2 task — narrative judgment 부분 (P2/P3 라벨링) + mechanical part (schema 적용):

### 1. MILESTONE.md `## PROPOSE` 섹션 작성

MILESTONE.md 안 `## PROPOSE` H2 section 안 다음 구조 추가:

- H3 `### Spec` 안 JSON 코드블록 — `next_candidates[]` array + `next_candidates_named_only[]` array
- H3 다음 narrative 본문 — 각 candidate origin + 본질 + dependency 보강

JSON spec schema (필수 필드):

```json
{
  "next_candidates": [
    {
      "id": "{kebab-case-slug}",
      "title": "{≤ 60자 + Active form 본질 동사 종결 + 한 본질}",
      "trigger": "{A_user|B_byproduct|B_regression|D_design}",
      "origin_milestone": "v{X.Y}",
      "target_version": "v{X+1.Y} 또는 v{X.Y+1}",
      "description": "{왜 후보인지 narrative — origin 지점 + 본질 요약 + dependency narrative}"
    }
  ],
  "next_candidates_named_only": [
    "{거명만 — 본 milestone scope 외 본질이지만 별 milestone 발의 불확정 (mention only)}"
  ]
}
```

next_candidates 본질 = forward-looking 후보 (실 등재 의도). next_candidates_named_only = 거명만 (mention only, evidence 누적 시 발의 후보).

### 2. ROADMAP `next_candidates[]` append

> **사용자 명시 결정 게이트 후만** (v7.0 T1.2): lessons P2/P3 또는 Stage D review 부산물 (`## SCOPE_OUT_NOTES`) 의 자동 append 폐지. 부산물은 candidate source 일 뿐 — PROPOSE 안 사용자 명시 결정 후만 등재 (부산물 cycle 차단). 1차 source = [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) § Stage I.

`projects/<name>/ROADMAP.md` 안 `next_candidates[]` array 끝에 entry append (위 next_candidates 와 1:1 매핑):

```json
{
  "id": "{kebab-case-slug}",
  "title": "{title}",
  "trigger": "{A_user|B_byproduct|B_regression|D_design}",
  "origin_milestone": "v{X.Y}",
  "target_version": "v{X+1.Y} 또는 v{X.Y+1}",
  "description": "{왜 후보인지 narrative}"
}
```

field 정합:

- `id`: regex `^[a-z0-9-]+$` (kebab-case-slug, path-safe)
- `title`: ≤ 60자 + Active form + 한 본질
- `trigger`: 4 enum — `A_user` (외부 사용자 발의) / `B_byproduct` (부산물 흡수) / `B_regression` (회귀 evidence) / `D_design` (설계 결정 선행)
- `origin_milestone`: 본 milestone version (예: `v6.16`)
- `target_version`: 후속 milestone 예정 version (예: `v6.x` 미확정 또는 `v6.17` 확정)
- `description`: 1-3 sentence narrative

archival 처리 (recent 3 초과 시) = REPORT 단계 책임 (본 stage 외).

## 검증

PROPOSE stage 완료 후 회귀 차단 smoke 2건:

```bash
bash tests/smoke-spec-verification.sh
bash tests/smoke-candidate-draft-schema.sh
```

기대 결과 = 둘 다 PASS. PROPOSE 섹션 안 JSON 코드블록 형식 + ROADMAP `next_candidates[]` schema 검증.

추가 smoke:

```bash
bash tests/smoke-entry-title-guideline.sh
```

= candidate title 가이드 (1) ' + ' literal 부재 + (2) ≤ 60자 자동 검증 (`next_candidates[].title` 포함).

## 관련

1차 source narrative:

- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 2 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 — 9-stage workflow Stage I (PROPOSE) 책임 = `next_candidates ROADMAP 등록`
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 끝 #9 row paragraph — Claude 자율 milestone 발의 mechanism (v6.5+v6.8, `/propose-next` slash command)
- [`development/ROADMAP.md`](../../development/ROADMAP.md) — schema_note 안 `next_candidates[]` 6 필드 + `candidate_draft[]` 7 필드 (`/propose-next` mechanism append)

관련 mechanism (별 facing):

- [`claude/commands/propose-next.md`](../../claude/commands/propose-next.md) — `/propose-next` slash command (자율 candidate 제안 mechanism)
- [`scripts/propose_next.py`](../../scripts/propose_next.py) — deterministic enumerate script

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` workflow orchestrator

9 stage skill cross-ref (workflow 순서, v6.18 확장 후 9 stage 전체 cover):

- `skills/stage-open/` — A. OPEN stage (v6.16 시범 첫 번째)
- `skills/stage-intent/` — B. INTENT stage (v6.18 확장)
- `skills/stage-research/` — C. RESEARCH stage (v6.18 확장)
- `skills/stage-design/` — D. DESIGN stage (v6.18 확장)
- `skills/stage-approve/` — E. APPROVE stage (v6.18 확장)
- `skills/stage-execute/` — F. EXECUTE stage (v6.18 확장)
- `skills/stage-verify/` — G. VERIFY stage (v6.18 확장)
- `skills/stage-report/` — H. REPORT stage (v6.18 확장)
- `skills/stage-propose/` — I. PROPOSE stage (본 skill, v6.16 시범 두 번째)

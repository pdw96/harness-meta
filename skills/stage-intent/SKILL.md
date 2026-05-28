---
name: stage-intent
description: milestone INTENT stage 작성 시 ## INTENT section 안 의도 정의 (goal / motivation / success_criteria / out_of_scope / dependencies) mechanical task. 사용 case = 사용자가 'INTENT stage 작성' / 'milestone INTENT 진입' / '## INTENT 섹션 작성' 언급 또는 9-stage workflow Stage B (의도 정의) 진행. SKIP = 'intent' 일반 의도 표현 (예: '본 코드의 intent') / commit message 안 'intent' 표현. 본 skill = WORKFLOW.md § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-intent — milestone INTENT stage 작성 checklist

> 본 skill 은 `development/WORKFLOW.md` § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage B (INTENT 의도) 진행 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `의도` (intent) — milestone 자체의 'goal + motivation + success_criteria + out_of_scope + dependencies' 5 본질 정의.

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## INTENT` 섹션 (Stage B 자체 산출물) — OPEN 단계에서 skeleton (미작성 placeholder) 작성된 후 본 stage 안 채움. 단 외부 입력 본질 = ROADMAP `milestones[].in_progress` entry (OPEN 단계 작성).

읽을 곳:

- `projects/<name>/ROADMAP.md` — `milestones[]` 안 본 milestone in_progress entry (id / title / trigger / summary) — OPEN 단계 산출
- `projects/<name>/ARCHITECTURE.md` — 정전 single source (§ 3 working definition). name=meta 인 경우 워크플로우 = [`../../development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 + AI Native 운영 정의 = [`../../development/OPERATIONS.md`](../../development/OPERATIONS.md) § 3 분리 (v9.1+ 본질 분리). 외부 project (upbit 등) 는 ARCHITECTURE.md 단일 거주 — milestone goal/motivation 정합 본질 source
- 사용자 자연어 표현 (pre-PLAN round 누적) — goal/motivation/sc 결정 직접 input source

## 작성할 것

MILESTONE.md 안 `## INTENT` H2 section 안 `### Spec` JSON 코드블록 + `### Narrative` 본문 작성. narrative judgment 본질 보존 — LLM at runtime, schema template forcing function 보조.

### 1. `### Spec` 안 JSON schema

```json
{
  "id": "{kebab-case-slug — frontmatter id 정합}",
  "title": "{≤ 60자 + Active form + 한 본질 — frontmatter title 정합}",
  "goal": "{본 milestone 의 단일 본질 목표 narrative — 1~3 sentence}",
  "motivation": "{왜 본 milestone 이 필요한지 — origin (이전 milestone PROPOSE / 사용자 발의 / 부산물) + 본질 요약}",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "{검증 가능 명시 조건 — boolean 검증 가능 또는 정량 기준}"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "{본 milestone scope 외 본질 명시 + 별 milestone candidate narrative (origin 참조)}"
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "{이전 milestone version + slug 또는 외부 source (ARCHITECTURE section / spec)}",
      "purpose": "{왜 본 dependency 가 필요한지 — 본 milestone 의도 안 영향 narrative}"
    }
  ]
}
```

필드 정합:

- `id`: regex `^[a-z0-9-]+$` (frontmatter id 정합)
- `title`: ≤ 60자 + Active form + 한 본질 (frontmatter title 정합)
- `success_criteria[].id`: regex `^sc_\d+$` (sc_1, sc_2, ...)
- `out_of_scope[].id`: regex `^oos_\d+$`
- `dependencies[].id`: regex `^dep_\d+$`

### 2. `### Narrative` 본문

본 milestone 의 motivation + 5 본질 (goal/sc/oos/dep) 요약 1~3 paragraph. LLM judgment 본질 — origin 본질 narrative + 핵심 결정 (pre-PLAN round 누적) trace + scope 본질 명시.

narrative judgment 본질 보존 — LLM at runtime, schema template forcing function 보조 (mechanical content 부재 자연, narrative-heavy stage 본질).

## 검증

INTENT stage 작성 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. INTENT 섹션 안 ```json``` 코드블록 형식 + id/title 필드 강제 검증.

추가 smoke (필요 시):

```bash
bash tests/smoke-entry-title-guideline.sh
```

= title 가이드 (1) ' + ' literal 부재 + (2) ≤ 60자 자동 검증.

## 관련

1차 source narrative:

- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 2 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 — 9-stage workflow Stage B (INTENT) 책임 = `의도 (goal, motivation, success_criteria, out_of_scope, dependencies)`
- [`development/OPERATIONS.md`](../../development/OPERATIONS.md) § 4 — Entry title 가이드 (4 원칙)

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드 + 워크플로우 진입점
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command (workflow orchestrator)

9 stage skill cross-ref (workflow 순서):

- `skills/stage-open/` — A. OPEN stage (이전)
- `skills/stage-intent/` — B. INTENT stage (본 skill)
- `skills/stage-research/` — C. RESEARCH stage (다음)
- `skills/stage-design/` — D. DESIGN stage
- `skills/stage-approve/` — E. APPROVE stage
- `skills/stage-execute/` — F. EXECUTE stage
- `skills/stage-verify/` — G. VERIFY stage
- `skills/stage-report/` — H. REPORT stage
- `skills/stage-propose/` — I. PROPOSE stage

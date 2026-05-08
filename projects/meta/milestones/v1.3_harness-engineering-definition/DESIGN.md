# DESIGN — v1.3_harness-engineering-definition

```json
{
  "id": "v1.3_harness-engineering-definition",
  "decisions": [
    {
      "decision": "정의 host = projects/meta/ARCHITECTURE.md (Option B)",
      "rationale": "(1) ARCHITECTURE 책임명 부합 — 메타 repo 자체 아키텍처 = 하네스 엔지니어링 정의의 자연 host. (2) v1.1_meta-as-project 신설 fresh 문서, stale risk 0. (3) lazy load 약점은 root CLAUDE.md cross-ref 1줄로 충분 강제. (4) primary CLAUDE.md (122줄) 비대화 회피. 3 관점 (architecture / spec-drift / scope contract) 모두 합의.",
      "alternatives_rejected": [
        "Option A (root CLAUDE.md) — 운영 가이드 / 정전 정의 책임 혼재 + 본문 비대화 (122 → 180줄+)",
        "Option C (docs/HARNESS-ENGINEERING.md 신규) — ARCHITECTURE.md 와 책임 중복, 단일 source 원칙 위반",
        "Option D (docs/ARCHITECTURE.md 정전화 + cleanup 동반) — scope creep, stale 4-tier 잔존 cleanup 은 별개 milestone 분량"
      ]
    },
    {
      "decision": "5요소 매트릭스 = 4컬럼 (요소 / 책임 / 메커니즘 cross-ref / 정전 vs 임시방편)",
      "rationale": "PLAN.success_criteria #2 (a)(b)(c) 3속성 1:1 매핑 + RESEARCH risk #2 ('5요소가 추상적 → 운영성 상실') mitigation 직접 충족. 신규 milestone 발의 시 (c) 컬럼이 평가 잣대 역할.",
      "alternatives_rejected": [
        "5컬럼 (+ (d) 외부 컨벤션 매핑) — spec-drift agent 권장이었으나 사용자 결정으로 4컬럼 채택 + 외부 매핑은 본문 단락 서술 (표 외, 폭 절약)",
        "3컬럼 (요소 / 책임 / 메커니즘 cross-ref) — (c) 분류 누락 시 운영성 상실"
      ]
    },
    {
      "decision": "사용자 working philosophy 정의 본문에 명문화 (narrative + 파일 trace 우선, 인프라 자동화 최소화)",
      "rationale": "메모리 (`v1.75 manual context injection`, `feedback_token_efficiency_priority`) 만 존재하던 원칙을 repo 트리에 박아 Claude 세션 간 일관성 확보. 정의 본문 1~2문장 + 5요소 매트릭스 (c) 컬럼 분류 기준이 본 philosophy 에 정합.",
      "alternatives_rejected": [
        "사용자 philosophy 별도 항목 분리 — 정의 본문과 분리 시 Claude 가 정의만 읽고 philosophy 누락 risk"
      ]
    },
    {
      "decision": "cross-ref 갱신 범위 = 보수 (root CLAUDE.md 1줄만, host 본 milestone 자체)",
      "rationale": "AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md 는 영문·stale 이슈 동반 → 별개 cleanup milestone (v1.4_cross-ref-propagation 후속 발의). PLAN.out_of_scope #5 정신 준수 + scope creep 회피. 사용자 결정.",
      "alternatives_rejected": [
        "통합 (4곳 all) — 영문 외부 가시성 + 1 milestone 완결성 우세하나 stale risk 동반 + scope creep"
      ]
    },
    {
      "decision": "2-phase 분할 (phase-1 정의 본문 / phase-2 cross-ref)",
      "rationale": "v1.2 lessons '단순 메시지 교체도 phase 분리가 smoke 격리 이득'. 정전 본체 (phase-1) 와 가시성 확장 (phase-2) audit trail 분리. commit 메시지 명확화.",
      "alternatives_rejected": [
        "1 phase 통합 — scope ≤5 파일이라 가능하나 정전 본체 / cross-ref 책임 혼재, lessons 위반"
      ]
    },
    {
      "decision": "PLAN.success_criteria #5 (next_candidates 등록) 재해석 — Stage G REPORT 책임으로 분류 (PLAN.md 본문 수정 X)",
      "rationale": "scope contract agent 식별 — '관측 가능한 milestone 성공 결과' 가 PLAN.success_criteria 정의이나 #5 는 REPORT 단계 산출물. PLAN 본문 수정은 narrative trace 손상 → DESIGN 의 본 결정으로 재해석 명시. PLAN.dependencies.successors_anticipated 가 입력 준비 책임.",
      "alternatives_rejected": [
        "PLAN.md 본문 수정 (success_criteria #5 제거) — narrative trace 손상, milestone 진입 후 PLAN 정정은 메모리 `feedback_hard_reset_for_direction_change` 정신과도 충돌 (commit 안 됐어도 작성된 의도)"
      ]
    },
    {
      "decision": "smoke 신규 (smoke-harness-definition.sh) OFF",
      "rationale": "scope contract agent 가 권장했으나 PLAN.out_of_scope #4 ('smoke 신규 추가 — 정의가 박힌 다음에야 검증 가능, 후속 milestone') 명시 위반. 본 milestone scope 보호.",
      "alternatives_rejected": [
        "smoke 신규 동반 추가 — out_of_scope 침범 risk + scope creep"
      ]
    }
  ],
  "approach": "projects/meta/ARCHITECTURE.md (현재 77줄) 의 § 2~3 사이에 신규 § '하네스 엔지니어링 정의' 삽입. 본문은 (1) 1~2문장 working definition + (2) 사용자 working philosophy 1~2문장 + (3) 5요소 4컬럼 매트릭스 표 + (4) 외부 컨벤션 관계 1단락 서술 (표 외). 이후 root CLAUDE.md L4 직후에 cross-ref 1줄 ('> 하네스 엔지니어링 정의 + 5요소 매트릭스: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md)'). 2-phase commit, pre-commit smoke full-pass.",
  "phases": [
    {
      "phase": 1,
      "title": "정의 본문 + 5요소 매트릭스 박기 (projects/meta/ARCHITECTURE.md)",
      "scope": "정전 본체 추가 — 1~2문장 working definition + working philosophy + 4컬럼 5요소 매트릭스 + 외부 컨벤션 관계 단락",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/milestones/v1.3_harness-engineering-definition/execute/phase-1.md"
      ],
      "rationale": "정전 본체가 박혀야 phase-2 의 cross-ref 가 의미를 가짐. phase-1 만으로 PLAN.success_criteria #1~3 충족 가능 (host grep / 매트릭스 / philosophy).",
      "risks": [
        "본문 추가로 ARCHITECTURE.md 가 77 → 110~120줄 추정 — 운영 적정 (L130 이하 유지 목표)",
        "5요소 매트릭스 (c) 분류 (정전 vs 임시) 가 모호하면 신규 milestone 발의 평가 불가 → 본 milestone 자체 + 기존 8 milestone 회고로 (c) 컬럼 채워 운영성 즉시 검증",
        "정의 문구가 길거나 modal 어휘 (~할 수도 있다 등) → 정전성 약화. 1~2문장 단정문 강제"
      ]
    },
    {
      "phase": 2,
      "title": "root CLAUDE.md cross-ref 1줄 추가",
      "scope": "lazy load 약점 보강 — root CLAUDE.md L4 영역에 정의 host cross-ref 1줄 추가",
      "affected_files": [
        "CLAUDE.md",
        "projects/meta/milestones/v1.3_harness-engineering-definition/execute/phase-2.md"
      ],
      "rationale": "root CLAUDE.md 가 자동 로드 primary host. cross-ref 1줄로 Claude 가 매 세션 정의 host 인지 가능. AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md cross-ref 는 후속 v1.4_cross-ref-propagation milestone 분리.",
      "risks": [
        "cross-ref 위치가 부적절하면 본문 흐름 끊김 — L4 (운영 가이드 한 줄 직후) 가 자연스러운 위치",
        "cross-ref 가 너무 자세하면 본문 침범 — 1줄 (제목 + 링크) 강제"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "정의 본문 자주 바뀜 → 정전 기능 상실",
      "mitigation": "5요소 매트릭스 (b) 메커니즘 컬럼은 cross-ref 형태로만 (예: 'tests/smoke-*.sh — 상세 tests/CLAUDE.md'). 메커니즘 변경 시 cross-ref 만 갱신, 본 정의 본문은 부동."
    },
    {
      "risk": "5요소가 추상적 → 운영성 상실",
      "mitigation": "(c) 정전 vs 임시방편 분류 컬럼 — 신규 milestone 발의 시 어느 요소의 어느 분류 (정전 보강 vs 임시방편 정리) 인지 즉시 평가 가능."
    },
    {
      "risk": "정의 host 가 stale 문서면 정전성 약화",
      "mitigation": "Option B 채택으로 fresh 문서 (v1.1_meta-as-project 신설) 사용 — stale risk 0. docs/ARCHITECTURE.md (4-tier stale) / GUARDRAILS.md (sessions/ stale) / AGENTS.md (Status stale) 는 별개 cleanup."
    },
    {
      "risk": "정의 본문 / 매트릭스가 다른 host (AGENTS.md / README.md) 에 누설 → drift",
      "mitigation": "본 milestone 은 단일 source 결정 + cross-ref 1줄 (root CLAUDE.md 만) 로 한정. AGENTS.md / README.md cross-ref 는 후속 milestone 에서 일괄 처리. 정의 본문에 '★ 단일 source: projects/meta/ARCHITECTURE.md' 명시."
    },
    {
      "risk": "scope creep — phase 진행 중 cross-ref 4곳 통합 유혹",
      "mitigation": "DESIGN.phases.affected_files 가 화이트리스트 — phase-2 affected_files 는 root CLAUDE.md + execute/phase-2.md 만. AGENTS.md / README.md 추가 시 PLAN.out_of_scope #5 위반 + DESIGN 결정 위반."
    },
    {
      "risk": "후속 milestone (#1/#2/#3 + cross-ref-propagation) 미발의 → 정전이 박혔으나 적용 0",
      "mitigation": "Stage G REPORT.md next_candidates 에 4건 (v1.4_infra-minimization / v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.4_cross-ref-propagation) 등록 + ROADMAP.milestones[] status:pending 등재 의무."
    }
  ],
  "external_relation_narrative": "외부 컨벤션 (Anthropic / Claude Code) 의 'agent harness' 는 명시 working definition 부재 — hooks / settings.json permission / sub-agents / SKILL 등 메커니즘 묶음으로 사용. 본 정의는 외부 spec 추수가 아니라 사용자·repo 자체 working definition 정전화 (RESEARCH external#1). 5요소 (b) 메커니즘 cross-ref 가 외부 컨벤션 (hook / settings / SKILL / sub-agent) 에 자연 매핑되며, 'Trace' 요소는 외부 컨벤션 부재 — 메타 고유 차별화 지점 (REPORT.md + execute/phase-{n}.md). 본 단락은 ARCHITECTURE.md 본문에 표 외 형태로 포함.",
  "definition_draft": {
    "working_definition": "하네스 엔지니어링은 agent 의 행동을 Markdown narrative + 파일 trace 로 결속하여 인프라 자동화 의존을 최소화하는 활동이다. 5요소 (Context / Workflow / Constraint / Verification / Trace) 가 정전 분류이며, 신규 작업 발의는 본 5요소 중 하나에 매핑되어야 한다.",
    "clarifying_paragraph": "여기서 '인프라 자동화 의존 최소화' 란: SKILL 자동 invoke / hook hard-code / smoke 키워드 강제 / settings.json permission gate 같은 자동화 메커니즘에 작업의 **정합성·의사결정·trace** 를 맡기지 않는다는 뜻이다. 자동화는 **보조**이며, PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 narrative + 사용자 명시 approval gate 가 **1차 source**. 자동화 자체를 거부하지는 않는다 — 다만 자동화가 1차 source 가 되면 narrative 와 drift 하고 (예: v1.2 lessons '메시지 1건 변경 → smoke 6건 연쇄') 정전성이 약화되므로, 자동화는 항상 narrative 의 보조 역할로 위치한다.",
    "user_philosophy_statement": "★ harness-meta 의 working philosophy: narrative + 파일 trace 우선, 인프라 자동화 최소화, 단일 source 정합. SKILL 인프라·자동 hook gate 보다 PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 의 MD narrative + 사용자 명시 approval gate 를 1차 source 로 둔다.",
    "matrix_columns": [
      "요소",
      "(a) 책임",
      "(b) 메커니즘 cross-ref",
      "(c) 정전 vs 임시방편 분류"
    ],
    "matrix_rows": [
      {
        "element": "Context",
        "responsibility": "agent 가 작업 시 흡수하는 정보 source 의 결속",
        "mechanism_cross_ref": "root [`CLAUDE.md`](../../CLAUDE.md) 자동 로드 + 모듈 CLAUDE.md lazy load + 메모리 (auto memory) + sub-agent prompt 의 manual inject (v1.75 컨벤션, SKILL 자동 invoke 거부)",
        "classification": "정전 (manual injection 컨벤션 채택, SKILL 자동 invoke 부분만 임시방편)"
      },
      {
        "element": "Workflow",
        "responsibility": "milestone 단위 작업의 단계 분할 + 산출물 형식 통일",
        "mechanism_cross_ref": "7-stage pipeline (ROADMAP → MILESTONE → PLAN → RESEARCH → DESIGN → EXECUTE → VERIFY → REPORT), [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 에 진입점 정의, 모든 산출물 MD + JSON 코드블록",
        "classification": "정전 (v1.0_workflow-redesign 으로 확립)"
      },
      {
        "element": "Constraint",
        "responsibility": "agent 가 위반하면 안 되는 규칙·금지·승인 게이트",
        "mechanism_cross_ref": "root [`CLAUDE.md`](../../CLAUDE.md) CRITICAL 섹션 + DESIGN.approval (`approved_by: \"user\"` + date) + [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) 금지 목록 + settings.json permission",
        "classification": "정전 (DESIGN.approval 게이트 + CRITICAL narrative). settings.json permission 은 보조 메커니즘"
      },
      {
        "element": "Verification",
        "responsibility": "산출물 정합·schema·회귀 자동 검증",
        "mechanism_cross_ref": "[`tests/smoke-*.sh`](../../tests/) 22종 + pre-commit hook (.pre-commit-config.yaml) + `.github/workflows/ci.yml` + `VERIFY.md` (criteria_check)",
        "classification": "혼재 — VERIFY.md narrative = 정전. smoke shell 인프라 = 임시방편 (후속 v1.4_infra-minimization 평가 대상)"
      },
      {
        "element": "Trace",
        "responsibility": "의사결정·실행 이력의 영속 보존 — 외부 컨벤션 부재, 메타 고유",
        "mechanism_cross_ref": "[`milestones/v{X.Y}_{slug}/`](.) 7-stage 산출물 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md) + git history + ROADMAP.milestones[]",
        "classification": "정전 (메타 고유 차별화 — 외부 'agent harness' 컨벤션 부재 지점)"
      }
    ]
  },
  "approval": {
    "approved_by": "user",
    "date": "2026-05-09"
  }
}
```

## 종합 narrative

3 관점 검토 결과 모든 핵심 결정이 합의됐고 (Option B / 2-phase / 4컬럼), 사용자 결정으로 cross-ref 보수 + 외부 매핑 본문 단락 화 가 추가 확정됐다. 정의 본문 / 매트릭스 / philosophy 시안은 `definition_draft` 에 박혀 있어 EXECUTE 단계는 본 시안을 ARCHITECTURE.md 에 옮기는 작업으로 단순화. PLAN.success_criteria #5 는 본 문서로 재해석 (PLAN 본문 수정 없이 narrative trace 보존), Stage G REPORT 단계가 next_candidates 등록 책임. smoke 신규 추가 (scope contract agent 권장) 는 PLAN.out_of_scope #4 위반으로 OFF.

## EXECUTE 진입 게이트

`approval.approved_by: "user"` + `approval.date: YYYY-MM-DD` 갱신 시까지 phase-1 commit 진입 금지.

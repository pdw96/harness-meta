---
id: multi-llm-adapter-tiers
title: Multi-LLM 어댑터 tier 정책 도입
version: v9.0
status: in_progress
---

# v9.0 — Multi-LLM 어댑터 tier 정책 도입

## OPEN

본 milestone 은 외부 LLM 도구 (codex) 의 진단 — "현재 harness-meta 는 Claude Code 에서만 사용할 수 있는 구조" — 를 trigger 로, 사용자 명시 큰 건 결정 (2026-05-28) 으로 개시한다. 두 차례 cross-check 라운드 (Claude ↔ codex) 안 본질 분리 + 방향 합의에 도달 — 본 OPEN 은 그 합의 안 mechanical 진입 본질만 기록하고, 정체성 문장 변경 / tier 분류 / Claude 만의 자동화 가치 보존 방식 결정은 INTENT / DESIGN stage 로 보류한다.

### 왜 본 milestone 을 연다 (origin)

- **외부 진단** (codex): 본 repo 의 방법론 (9-stage + 5요소 + milestone schema) 은 이미 LLM-agnostic 이나, 제품 패키징·자동화 표면 (subagent / hook / skill / slash command / plugin manifest / statusline) 이 Claude Code 전용. 단순 어댑터 markdown 추가 (GEMINI.md / .codex/ / .cursor/rules/) 만으로는 부분 해소.
- **현 정체성 진단**: 본 repo 의 진입 narrative 첫 줄 = "LLM-agnostic harness engineering consultant + project harness composer + **Claude Code adapter maintainer**" (단수, [`../../../CLAUDE.md`](../../../CLAUDE.md):3). "Claude Code adapter maintainer" 가 단수형으로 박혀 있어 멀티 LLM 어댑터화는 정체성 첫 줄 직접 변경 후보 → breaking change 본질 → major bump v9.0 자연.
- **사용자 명시 결정** (2026-05-28): codex 외부 검토 보완 후 v9.0 OPEN 진입 승인.

### 후보 방향 (INTENT 까지 정식 결정 보류)

cross-check 라운드 안 자연 도출된 3 층 분리 + tier 분류 — 본 OPEN 은 candidate 거명만, 채택은 INTENT/DESIGN 게이트:

- **Core methodology** (LLM-agnostic): 9-stage pipeline, 5요소 모델 (Context / Workflow / Constraint / Verification / Trace), milestone format, ROADMAP discipline, verification policy. 본 층은 도구 무관 정전 유지.
- **Adapter docs** (per-tool, 얇은 운영 지침): Claude=`CLAUDE.md` + `.claude-plugin/plugin.json`, Codex=`AGENTS.md`, Gemini=`GEMINI.md`, Cursor=`.cursor/rules/`. 각 도구가 읽는 표면만 정합 변환.
- **Portable tools** (CLI-first, MCP 2차): smoke tests, ROADMAP/milestone schema validation, milestone scaffold, spec verification, cascade sync. CLI 안정화 후 MCP wrapper 는 점진 이식.

### INTENT/DESIGN 으로 보류된 결정 항목 (본 OPEN 안 미확정)

1. **정체성 첫 줄 재정의**: "Claude Code adapter maintainer" (단수) → "reference adapter maintainer + portable adapter coordinator" (이중 책임) 류 후보. CLAUDE.md / README.md / AGENTS.md / ARCHITECTURE.md 첫 narrative cascade 영향.
2. **tier 분류 정식 schema**: Core methodology / Reference adapter (Claude) / Portable adapters (Codex, Gemini, Cursor) / Optional integration layer (MCP). 어느 ROADMAP/ARCHITECTURE 섹션 안 정식 박을지.
3. **Claude 만의 자동화 가치 보존 방식**: 5 관점 병렬 subagent 검토 (cycle 1~3 evidence — 2.4×/1.75×/1.09× 누적 증가, memory `feedback_subagent_parallel_review_evidence` 보존) 가 Claude subagent mechanism 종속이라 1:1 포팅 불가. 처리 후보 = (a) 포기 / (b) 수동 prompt 시리즈 fallback / (c) Claude retain + 다른 어댑터엔 동일 관점 목록 + 순차 절차 제공.
4. **핵심 원칙 한 줄 정전** (codex 제안 정합): "목표는 LLM 도구 간 자동화 동등성이 아니라, 도구별 자동화 tier 를 인정하는 이식 가능한 방법론이다" — INTENT 안 scope + candidate 거명 (정확 한국어 표현은 DESIGN 안 finalize 후 ARCHITECTURE 정식 박기).
5. **portable tools 분류**: Claude 전용 (subagent / slash command / hook lifecycle / plugin manifest / statusline) vs Portable 후보 (smoke / schema validation / artifact scaffold / fact verification / cascade sync) 의 매트릭스.

### Stage 진행 게이트

- INTENT: 의도 정식화 (goal / motivation / success_criteria / out_of_scope / dependencies) — 위 5 보류 항목 안 (1)(4) 의 scope + candidate direction 확정 (정확 word 는 DESIGN 안 finalize, stage 책임 분리 정합).
- RESEARCH: tier taxonomy 정합 minimal capability survey (각 LLM 도구 호출 표면 docs / hook / agent / plugin 대략 분류만 — 실 mechanism 깊은 조사는 oos_1~3 별 milestone 자연) + Claude Code 자동화 표면 분류 정합 (oos_4 부분 거명 차원, 정식 매트릭스는 별 milestone).
- DESIGN: 3 층 분리 + tier 분류 schema + Claude 전용 가치 보존 방식 (위 (3)) + 5 관점 design-review.
- APPROVE: 사용자 명시 승인 게이트 (정체성 첫 줄 변경 = breaking change 본질, 사용자 결정 필수).
- EXECUTE: phase 분해 (codex 5단계 ≈ EXECUTE phase 분해 후보 — ARCHITECTURE 문서화 / Codex 최소 어댑터 / 자동화 분류 / CLI 정리 / MCP 보류).

## INTENT

### Spec

```json
{
  "id": "multi-llm-adapter-tiers",
  "title": "Multi-LLM 어댑터 tier 정책 도입",
  "goal": "본 repo 의 정체성을 단일 LLM 도구 (Claude Code) 종속에서 multi-LLM 어댑터 tier 정책으로 재정의하고 (정체성 첫 줄 = breaking change), 핵심 원칙 한 줄 ('automation parity 아니라 portable methodology with adapter-specific tiers') 을 ARCHITECTURE 안 정전한다. tier 분류 schema (Core methodology / Reference adapter / Portable adapters / Optional integration) 도 ARCHITECTURE 안 정식 박힘. 정확 word 는 DESIGN 안 finalize. 실 어댑터 보강 / 자동화 표면 분류 / portable scripts CLI 정리 / MCP wrapper 는 별 milestone (v9.1+).",
  "motivation": "origin = codex 외부 진단 ('현재 harness-meta 는 Claude Code 에서만 사용할 수 있는 구조', 2026-05-28) + 두 차례 cross-check 라운드 안 본질 분리 + 사용자 명시 큰 건 결정. 본질 = 본 repo 의 방법론 (9-stage + 5요소 + milestone schema) 은 이미 LLM-agnostic 이나, 진입 narrative 첫 줄 (CLAUDE.md:3) 의 'Claude Code adapter maintainer' 단수형이 멀티 LLM 화 시 본질 drift — 정책 박혀야 후속 어댑터 박기가 일관 (정책 없이 어댑터 박으면 drift). v8.15 codex-authored-change-absorption 사례 (codex 가 실 작성자 역할) 가 멀티 LLM 의도 origin 직접 증거. 정전화만 본질 = 헌법만 박고 후속 입법 (실 어댑터 / 자동화 분류 / CLI / MCP) 은 별 milestone 분해 — 한 본질 원칙 정합 + 작은 milestone 권장 정합.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "정체성 첫 줄 재정의 — CLAUDE.md:3 의 'Claude Code adapter maintainer' 단수형 → tier 정책 정합 표현 (정확 word 는 DESIGN 안 finalize, 후보 = 'reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)' 등)"
    },
    {
      "id": "sc_2",
      "criterion": "핵심 원칙 한 줄 정전 — development/ARCHITECTURE.md 안 § 신규 또는 § 3 확장 안 한국어 정전 + 영어 derived 박힘 (codex 제안 정합 후보 = '목표는 LLM 도구 간 자동화 동등성이 아니라, 도구별 자동화 tier 를 인정하는 이식 가능한 방법론이다' / 'The goal is not automation parity across LLM tools, but portable methodology with adapter-specific automation tiers')"
    },
    {
      "id": "sc_3",
      "criterion": "tier 분류 schema 정전 — development/ARCHITECTURE.md 안 § 신규 안 4 tier 정식 박힘 (Core methodology = LLM-agnostic canonical spec / Reference adapter = Claude Code richest / Portable adapters = Codex+Gemini+Cursor docs+CLI-first / Optional integration = MCP wrappers)"
    },
    {
      "id": "sc_4",
      "criterion": "정체성 cascade 정합 — 정체성 첫 줄 변경 안 narrative host 5건 (CLAUDE.md / README.md / AGENTS.md / development/ARCHITECTURE.md / development/CLAUDE.md) 모두 정합 (변경 전 단수 표현 모두 새 tier 표현 cascade). drift 부재 검증 = grep + smoke-cross-ref 정합"
    },
    {
      "id": "sc_5",
      "criterion": "active smoke 15건 모두 PASS — 본 milestone 산출 후 회귀 부재 검증"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "Codex 어댑터 보강 (AGENTS.md 안 9-stage 진입 절차 / tier 정합 표현 / harness-meta workflow 안내 등 강화) — v9.1 별 milestone 자연. origin = codex 5단계 (2). v8.15 codex 작성자 사례 안 codex 가 본 repo 를 더 잘 다루도록 어댑터 표면 강화 본질."
    },
    {
      "id": "oos_2",
      "item": "Gemini 어댑터 (GEMINI.md 추가 / Gemini Code Assist 정합) — v9.2+ 별 milestone. origin = codex 5단계 (2)."
    },
    {
      "id": "oos_3",
      "item": "Cursor 어댑터 (.cursor/rules/ 추가 / Cursor IDE 정합) — v9.2+ 별 milestone. origin = codex 5단계 (2)."
    },
    {
      "id": "oos_4",
      "item": "자동화 표면 분류 매트릭스 — Claude 전용 (subagent / hook lifecycle / plugin manifest / statusline) vs Portable 후보 (smoke / schema validation / scaffold / fact verification / cascade sync) 정식 매트릭스 작성. DESIGN 안 부분 거명 가능 (tier schema 정합 차원), 정식 매트릭스는 별 milestone. origin = codex 5단계 (3)."
    },
    {
      "id": "oos_5",
      "item": "portable scripts CLI-first 재정리 — 현 shell scripts (smoke / cascade_sync.py / propose_next.py) 를 scripts/harness-meta/ 안 통일 + CLI 표면 정규화. v9.3+ 별 milestone. origin = codex 5단계 (4)."
    },
    {
      "id": "oos_6",
      "item": "MCP wrapper — portable CLI 안정화 후 MCP server 안 wrapping (Claude / Codex / Gemini / Cursor 모두 MCP 표면 호출). v10.0+ 별 milestone. origin = codex 5단계 (5). MCP-first 폐기 + CLI-first 후 MCP 2차 정합."
    },
    {
      "id": "oos_7",
      "item": "Claude 만 자동화 가치 (5 관점 병렬 subagent 검토 등 — memory feedback_subagent_parallel_review_evidence cycle 1~3 evidence) 의 portable adapter fallback 정식 작성 — '동일 관점 목록 + 순차 실행 절차' manual prompt 시리즈 등. DESIGN 안 fallback 후보 거명 가능 (tier schema 의 Reference vs Portable 차이 본질), 정식 fallback 작성은 별 milestone. origin = 본 milestone OPEN 안 보류 항목 (3)."
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "development/ARCHITECTURE.md § 3 (working definition) + § 3.1 (harness-meta repo 정체성)",
      "purpose": "본 milestone 의 정체성 재정의 + tier schema 박기 안 직접 영향 source. § 3.1 끝 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' (v4.0 도입) 가 변경 영향 narrative."
    },
    {
      "id": "dep_2",
      "ref": "CLAUDE.md:3 (root primary host narrative 첫 줄)",
      "purpose": "정체성 cascade primary source. 현 'LLM-agnostic harness engineering consultant + project harness composer + Claude Code adapter maintainer' 안 'Claude Code adapter maintainer' 단수형 변경 직접 영향."
    },
    {
      "id": "dep_3",
      "ref": "README.md (외부 visible 정체성 paragraph)",
      "purpose": "외부 방문자 narrative — 정체성 cascade 대상. v8.0 meta 재분류 (development/) 정합 narrative 이미 변경된 사례 (v8.15 흡수 안 정합)."
    },
    {
      "id": "dep_4",
      "ref": "AGENTS.md (영문 요약, codex 등 외부 LLM 도구 진입 source)",
      "purpose": "codex 가 본 repo 를 인식하는 1차 source. 정체성 cascade 대상 + 향후 v9.1 codex 어댑터 보강 안 직접 영향."
    },
    {
      "id": "dep_5",
      "ref": "memory feedback_subagent_parallel_review_evidence",
      "purpose": "Claude 만 자동화 가치 본질 evidence (cycle 1~3, 2.4×/1.75×/1.09× 누적 증가). tier 분류 안 Reference adapter (Claude) vs Portable adapters 의 자동화 가치 차이 본질 source. oos_7 fallback 거명 안 직접 source."
    },
    {
      "id": "dep_6",
      "ref": "development/milestones/v8.15/MILESTONE.md (codex-authored-change-absorption REPORT)",
      "purpose": "codex 가 실 작성자 역할 한 사례 — 멀티 LLM 의도 origin 직접 증거. v8.15 안 'cross-check 트랙 역할 역전 (codex 가 작성)' narrative 가 본 milestone motivation 직접 source."
    }
  ]
}
```

### Narrative

본 milestone 은 외부 LLM 도구 (codex) 의 진단 — "현재 harness-meta 는 Claude Code 에서만 사용할 수 있는 구조" — 를 origin 으로, 본 repo 의 진입 narrative 첫 줄 (CLAUDE.md:3) 의 "Claude Code adapter maintainer" 단수형이 본 repo 의 방법론 (이미 LLM-agnostic 인 9-stage + 5요소 + milestone schema) 과 정합 부재인 본질을 해소한다. 두 차례 cross-check 라운드 (Claude ↔ codex) 안 합의된 3 층 분리 (Core methodology / Adapter docs / Portable tools) + 4 tier 분류 (reference Claude / portable Codex+Gemini+Cursor / optional integration MCP) 를 ARCHITECTURE 안 정전화하는 것이 본 milestone 의 단일 본질이다. 정체성 첫 줄 변경 = breaking change 본질 — major bump v9.0 자연 정합.

본 milestone 의 범위는 "정전화만" (= 헌법 박기) 으로 좁힌다 — 실 어댑터 보강 (Codex / Gemini / Cursor / oos_1~3) + 자동화 표면 분류 매트릭스 (oos_4) + portable scripts CLI-first 재정리 (oos_5) + MCP wrapper (oos_6) + Claude 만 가치 portable fallback 작성 (oos_7) 은 모두 별 milestone (v9.1~v10.0+) 으로 분해. 이유는 (a) 본 repo 의 9-stage 자체가 작은 milestone 권장 — 한 본질 원칙 정합 / (b) 정책이 박혀야 후속 어댑터 박기가 일관 — 정책 없이 어댑터 박으면 drift / (c) major bump 정당화는 정체성 첫 줄 breaking change 만으로 충분 — 실 어댑터 박기 없어도 됨. codex 가 INTENT 안 박을 것 권한 "automation parity 아니라 portable methodology with adapter-specific tiers" 원칙은 sc_2 안 정전 대상 — 정확 한국어 표현은 DESIGN 안 finalize.

success_criteria 5건 (sc_1~5) 은 모두 검증 가능 — sc_1 (정체성 첫 줄 재정의) + sc_2 (핵심 원칙 한 줄 정전) + sc_3 (tier 분류 schema 정전) 가 핵심 산출, sc_4 (narrative host 5건 cascade) 가 cascade 정합 검증 (drift 부재 grep + smoke-cross-ref), sc_5 (active smoke 15건 PASS) 가 회귀 부재 검증. dependencies 6건 (dep_1~6) 안 dep_5 (memory subagent_parallel_review_evidence) + dep_6 (v8.15 codex 작성자 사례) 가 본 milestone 의 motivation 직접 증거 source — 전자는 "Claude 만 가치 본질" + 후자는 "멀티 LLM 의도 origin" 양 본질 source.

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

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음. INTENT/DESIGN 안 sub-milestone 분리 필요성 재평가 가능.)

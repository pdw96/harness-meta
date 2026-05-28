---
id: multi-llm-adapter-tiers
title: Multi-LLM 어댑터 tier 정책 도입
version: v9.0
status: open
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
4. **핵심 원칙 한 줄 정전** (codex 제안 정합): "목표는 LLM 도구 간 자동화 동등성이 아니라, 도구별 자동화 tier 를 인정하는 이식 가능한 방법론이다" — INTENT 안 정식 박기.
5. **portable tools 분류**: Claude 전용 (subagent / slash command / hook lifecycle / plugin manifest / statusline) vs Portable 후보 (smoke / schema validation / artifact scaffold / fact verification / cascade sync) 의 매트릭스.

### Stage 진행 게이트

- INTENT: 의도 정식화 (goal / motivation / success_criteria / out_of_scope / dependencies) — 위 5 보류 항목 안 (1)(4) 정식 결정.
- RESEARCH: codex / Gemini / Cursor 의 실 mechanism 조사 (context7 + 외부 docs) + Claude Code 자동화 표면 분류 정합.
- DESIGN: 3 층 분리 + tier 분류 schema + Claude 전용 가치 보존 방식 (위 (3)) + 5 관점 design-review.
- APPROVE: 사용자 명시 승인 게이트 (정체성 첫 줄 변경 = breaking change 본질, 사용자 결정 필수).
- EXECUTE: phase 분해 (codex 5단계 ≈ EXECUTE phase 분해 후보 — ARCHITECTURE 문서화 / Codex 최소 어댑터 / 자동화 분류 / CLI 정리 / MCP 보류).

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

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음. INTENT/DESIGN 안 sub-milestone 분리 필요성 재평가 가능.)

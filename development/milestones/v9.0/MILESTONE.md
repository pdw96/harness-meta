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
      "criterion": "정체성 cascade 정합 — 정체성 첫 줄 변경 안 narrative host 10건 (RESEARCH cb_6/cb_7/cb_8 발견 3건 + DESIGN design-review marketplace.json 추가 2건 흡수) 모두 host role별 표현 정합 (DESIGN d_6 정합). 10 host = (한국어 primary 3) CLAUDE.md:3 + development/ARCHITECTURE.md:69 + development/ARCHITECTURE.md:304 / (영문 primary 4) README.md:3 + AGENTS.md:3 + .claude-plugin/plugin.json:4 + pyproject.toml:4 / (v4.0 ecosystem-integrator 별 표현 3) development/CLAUDE.md:5 + .claude-plugin/marketplace.json:3 + .claude-plugin/marketplace.json:12. primary 7 host = multi-LLM tier 표현 cascade / 별 표현 3 host = Claude reference adapter rich capability 표현 보존/보정. drift 부재 검증 = grep 3 형식 (relative/절대/anchor, v8.2 정합) + Windows PowerShell Select-String 직접 1회 + smoke-cross-ref 정합"
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
    },
    {
      "id": "oos_8",
      "item": "SDK 화 후보 (Omni Agent SDK 등 LLM-agnostic SDK 채택 평가) 는 별 milestone (v9.5+ 후보) — 본 milestone scope (정전화만) 외, 다만 Anthropic Claude Agent SDK 의 멀티 LLM 미해결 fact (RESEARCH ext_2) 와 LLM-agnostic SDK 가능성 fact (RESEARCH ext_3) 를 별 본질로 보존. origin = RESEARCH risk_3 mitigation + DESIGN d_7 결정 (사용자 명시 결정 2026-05-28 정합). DESIGN 시점 INTENT 직접 amend (sc_4 host 5→10 amend 와 본질 일관)."
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

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "Anthropic Claude Code 도구 카탈로그 (code.claude.com/docs) — README.md:4 + development/ARCHITECTURE.md:69 안 인용",
      "finding": "Claude Code reference adapter 의 자동화 표면 8건 정전 = subagent / agent team / hook / skill / slash command / statusline / MCP server / plugin. 본 8건이 tier schema 안 'Reference adapter (Claude Code) richest' 본질 source. context7 query 추가 가치 minimal — 본 표면은 본 repo 의 README.md:4 / AGENTS.md:3 / ARCHITECTURE § 3.1 line 69 안 이미 정전 인용 (해당 paragraph 자체가 docs 정합 narrative)."
    },
    {
      "id": "ext_2",
      "source": "context7 /anthropics/claude-agent-sdk-python (High reputation, Code Snippets 28) — description = 'A Python SDK that provides functionalities for interacting with Claude Agent'",
      "finding": "Anthropic 의 Claude Agent SDK 자체가 'Claude Agent' 안 interacting 본질 (Claude Code / Claude Agent 종속) — 즉 SDK 화 안 Codex / Gemini / Cursor 안 본 repo 동작 시키는 본질 미해결 (Claude 모델 종속 유지). 본 사실이 SDK 화 본질 안 Anthropic SDK 한정 fact verification source. 정밀 종속 표현은 context7 metadata 차원 — 공식 docs/GitHub 인용 보강 시 별 RESEARCH (oos_1~3 깊은 mechanism 조사) 본질."
    },
    {
      "id": "ext_3",
      "source": "context7 /thegoateddev/omni-agent-sdk (High reputation, Code Snippets 159) — description = 'A unified TypeScript SDK that provides a single interface for multiple AI coding agent providers, allowing you to write code once and swap between Claude, Codex, and OpenCode providers'",
      "finding": "LLM-agnostic SDK 가 외부에 이미 존재 — Omni Agent SDK 가 Claude / Codex / OpenCode 단일 인터페이스 제공. 즉 SDK 화 본질이 '완전 폐기' 아니라 'Anthropic SDK 폐기 / LLM-agnostic SDK 가능성 별 milestone 후보' 로 보정 본질 — risk_3 source. 본 SDK 채택 평가는 본 milestone scope 외 (정전화만), 별 milestone (v9.5+ 후보) 자연."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "CLAUDE.md:3",
      "finding": "root primary host narrative 첫 줄 = 'LLM-agnostic harness engineering consultant + project harness composer + Claude Code adapter maintainer' — 'Claude Code adapter maintainer' 단수형. INTENT dep_2 정합, sc_1 직접 cascade source."
    },
    {
      "id": "cb_2",
      "ref": "README.md:3",
      "finding": "외부 visible host = 'LLM-agnostic harness engineering consultant + project harness composer + Claude Code adapter' (영문, 'maintainer' 어휘 부재 — 별 표현 패턴). distributed as Claude Code Plugin 본문 정합."
    },
    {
      "id": "cb_3",
      "ref": "AGENTS.md:3",
      "finding": "영문 요약 host = README.md:3 동일 표현 'LLM-agnostic harness engineering consultant + project harness composer + Claude Code adapter'. codex 등 외부 LLM 도구 진입 1차 source — 본 host 안 정체성 표현이 codex 가 본 repo 를 인식하는 첫 narrative."
    },
    {
      "id": "cb_4",
      "ref": "development/CLAUDE.md:5",
      "finding": "subdir guide host = 별 표현 cascade = 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' (v4.0 도입). 'Claude Code adapter maintainer' 와 다른 v4.0 표현 — '단일 LLM 종속' 본질 동일하나 어휘 다름. cascade unify 정책 결정 source (risk_4)."
    },
    {
      "id": "cb_5",
      "ref": "development/ARCHITECTURE.md:69",
      "finding": "§ 3.1 canonical 정전 paragraph = 'LLM-agnostic harness engineering consultant + project harness composer + Claude Code adapter maintainer'. INTENT dep_1 정합. v4.0_harness-composer-pivot + v8.x adapter-neutral remodel 거명 — 정체성 cascade 의 canonical source."
    },
    {
      "id": "cb_6",
      "ref": "development/ARCHITECTURE.md:304",
      "finding": "§ 7.1 AI Native 운영 cross-ref = '§ 3.1 끝 정체성 (LLM-agnostic harness engineering consultant + project harness composer + Claude Code adapter maintainer)' — INTENT sc_4 안 거명 부재 (★ 발견). § 7.1 안 정체성 cascade 형태로 거주 — sc_4 host count 보정 필요."
    },
    {
      "id": "cb_7",
      "ref": ".claude-plugin/plugin.json:4",
      "finding": "Claude Code plugin manifest description = 'LLM-agnostic harness engineering consultant with a Claude Code adapter (audit-team, standalone agents, skills, slash commands, hooks, statusline)' — INTENT sc_4 안 거명 부재 (★ 발견). Claude Code plugin marketplace 안 visible 정체성 host. sc_4 host count 보정 필요."
    },
    {
      "id": "cb_8",
      "ref": "pyproject.toml:4",
      "finding": "Python package description = 'LLM-agnostic harness engineering consultant with a Claude Code adapter' — INTENT sc_4 안 거명 부재 (★ 발견). 본 repo 가 Python package 형태로도 metadata 보유 (현 미배포). sc_4 host count 보정 필요."
    },
    {
      "id": "cb_9",
      "ref": "development/ARCHITECTURE.md:71",
      "finding": "Core / Adapter 분리 원칙 이미 존재 = '5요소 모델, 9-stage/4-section 흐름, approval gate, smoke/verification, trace 보존은 core spec 이다. Claude Code plugin manifest / agents / skills / hooks / slash command 는 Claude adapter 이다. 향후 Codex / Cursor / Gemini / Copilot 같은 다른 LLM surface 는 별도 adapter 로 추가하되, AGENTS.md / .cursor/rules / GEMINI.md / .github/copilot-instructions.md 같은 tool-specific 파일을 선제 생성하지 않는다.' 본 milestone = 본 원칙을 첫 줄 narrative + tier schema 로 격상 본질 (신규 도입 아니라 격상)."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "tier 수 = 4 (codex 제안) — Core methodology / Reference adapter (Claude Code) / Portable adapters (Codex+Gemini+Cursor) / Optional integration (MCP) — DESIGN 안 우선 검토 후보",
      "rationale": "codex 제안 정합 + INTENT sc_3 정합. MCP 본질 (CLI-first 후 2차) 가 Portable 와 본질 다름 (Optional = 미래 가능성, Portable = 현 권장 docs+CLI-first) — 4 tier 가 자연 분리. RESEARCH 안 trade-off 강점 = MCP 본질 보존."
    },
    {
      "id": "opt_2",
      "label": "tier 수 = 3 (간소화) — Core / Reference / Portable (MCP = Portable 안 흡수) — trade-off 약점 후보",
      "rationale": "MCP 본질 차이가 흡수 시 narrative 혼란 — Portable adapters 본질 = 현 권장 (docs surface 추가 자연) vs MCP 본질 = 향후 wrapper (CLI 안정 후 2차). 본 차이 보존 위해 4 tier 자연. RESEARCH 안 trade-off 약점 = MCP 본질 흡수 안 narrative 혼란. DESIGN 안 채택/폐기 결정."
    },
    {
      "id": "opt_3",
      "label": "정체성 첫 줄 표현 후보 — (a) 'reference adapter maintainer + portable adapter coordinator' (codex 제안 이중 책임) / (b) 'multi-LLM adapter coordinator (reference: Claude Code)' (단일 책임 + tier 괄호) / (c) 그 외 — DESIGN finalize",
      "rationale": "본 결정은 INTENT 안 'DESIGN 안 finalize' 명시 (codex finding 1 정합). RESEARCH 안 후보 거명만, 채택 = DESIGN 안 5 관점 검토 후. 우선 후보 (a) — codex 제안 정합 + 현 host 패턴 (' + ' literal 사용 자연) 정합."
    },
    {
      "id": "opt_4",
      "label": "핵심 원칙 한 줄 정전 위치 — (a) ARCHITECTURE § 3.1 확장 (정체성 paragraph 안) / (b) § 7 AI Native 확장 / (c) § 신규 — (a) 검토 우선",
      "rationale": "정체성 paragraph (§ 3.1) 가 본 원칙 ('automation parity 아니라 portable methodology with adapter-specific tiers') 의 직접 source — 자연 정합. § 7 (AI Native 운영) 은 '본 repo 가 어떻게 운영되는가' 본질 — 본 원칙은 '본 repo 가 무엇을 만드는가' 본질, § 3.1 정합. § 신규 = numbering drift risk. (a) 검토 우선 — 채택/폐기 결정은 DESIGN 안."
    },
    {
      "id": "opt_5",
      "label": "SDK 화 후보 — (a) Anthropic Claude Agent SDK = Claude Code/Claude Agent 종속 (ext_2, 멀티 LLM 미해결) / (b) Omni Agent SDK = LLM-agnostic 외부 후보 (ext_3) / (c) 자체 LLM-agnostic library 작성 = 본 repo scope 외 — 본 milestone oos 신규 거명 후보",
      "rationale": "ext_2 (Anthropic SDK 의 Claude Code/Claude Agent 종속) + ext_3 (Omni LLM-agnostic 외부 존재) 두 fact 가 SDK 화 본질을 'Anthropic SDK 한정 미해결 / LLM-agnostic SDK 가능성 보존' 으로 분리. 본 milestone scope (정전화만) 정합 시 별 milestone (v9.5+ 후보 — Omni SDK 채택 평가) 으로 oos 신규 거명 필요 — risk_3 mitigation source. 채택/폐기 자체는 DESIGN 안 사용자 명시 결정 게이트."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "cascade host enumerate 누락 risk — INTENT sc_4 안 5건 (CLAUDE.md / README.md / AGENTS.md / development/ARCHITECTURE.md / development/CLAUDE.md) 거명, RESEARCH 안 실제 8건 발견 (★ 추가 = ARCHITECTURE § 7.1 cross-ref + .claude-plugin/plugin.json + pyproject.toml 3건). sc_4 verdict 안 host count 정합 부재 시 cascade drift.",
      "mitigation": "DESIGN 안 sc_4 host 8건 명시 보정 (CLAUDE.md:3 + README.md:3 + AGENTS.md:3 + development/CLAUDE.md:5 + development/ARCHITECTURE.md:69 + development/ARCHITECTURE.md:304 + .claude-plugin/plugin.json:4 + pyproject.toml:4). EXECUTE 안 grep 3 형식 (v8.2 정합 — relative path + 절대 path + symlink/anchor 변형) 검증 + smoke-cross-ref 회귀 부재 확인."
    },
    {
      "id": "risk_2",
      "description": "tier schema § 위치 결정 안 ARCHITECTURE 구조 변경 — § 3.1 확장 / § 7 확장 / § 신규 중 § 신규 시 numbering drift 가능 (현 § 11.4 최신 — § 12 추가 시 cross-ref drift 회피 필요).",
      "mitigation": "opt_4 (a) 검토 우선 = § 3.1 확장 (정체성 paragraph 안). numbering 보존 + 정체성 paragraph 가 본 원칙 직접 source 자연 정합. § 신규 회피 — 채택 자체는 DESIGN 안 결정."
    },
    {
      "id": "risk_3",
      "description": "SDK 화 본질 미해결 risk — Anthropic Claude Agent SDK (ext_2) 는 Claude Code/Claude Agent 종속으로 멀티 LLM 미해결, 다만 Omni Agent SDK (ext_3) 같은 LLM-agnostic SDK 가 외부 존재. 본 milestone oos 안 SDK 화 항목 부재 시 'SDK 화 본질 완전 미해결' 오해 + 향후 drift.",
      "mitigation": "DESIGN 안 INTENT oos 보정 = oos_8 신규 거명 = 'SDK 화 후보 (Omni 같은 LLM-agnostic SDK 채택 평가) 는 별 milestone (v9.5+ 후보) — 본 milestone scope 외, 다만 Anthropic SDK 의 멀티 LLM 미해결 fact 와 LLM-agnostic SDK 가능성 fact 를 별 본질로 보존'. 본 거명 안 SDK 화 본질 부분 미해결 (Anthropic 한정) + 부분 후보 보존 (LLM-agnostic) 정합."
    },
    {
      "id": "risk_4",
      "description": "cascade host 8건 안 표현 3 갈래 — (1) 'Claude Code adapter maintainer' (CLAUDE.md:3 + development/ARCHITECTURE.md:69 + development/ARCHITECTURE.md:304 = 3 host) / (2) 'Claude Code adapter' (maintainer 어휘 부재 — README.md:3 + AGENTS.md:3 + .claude-plugin/plugin.json:4 + pyproject.toml:4 = 4 host) / (3) 'Claude Code ecosystem integrator + agent fleet maintainer' (development/CLAUDE.md:5, v4.0 도입 별 표현 = 1 host). 8 host 안 표현 정합 부재 — cascade 안 단일 표현 강제 vs host 별 표현 유지 결정 필요.",
      "mitigation": "DESIGN 안 cascade unify 정책 결정. 후보 = (a) primary 표현 (CLAUDE.md:3 패턴) 안 host 안 적합 변형 — 한국어 host 안 한국어 정합 + 영문 host 안 영문 정합 + manifest host 안 description 형식 정합 / (b) 단일 표현 강제 + 표현 차이 해소. 단수형 → 멀티 LLM 표현 cascade 안 본 차이 결정 본질."
    },
    {
      "id": "risk_5",
      "description": "ARCHITECTURE § 3.1 line 71 'Core / Adapter 분리 원칙' 이미 존재 — 본 milestone = 격상 본질. 격상 narrative 명시 부재 시 '기존 원칙 그대로 / 본 milestone 가치 부족' 오해 + major bump v9.0 정당성 약화.",
      "mitigation": "DESIGN/EXECUTE 안 '격상' 본질 명시 narrative — 본 milestone = line 71 existing 원칙 ('향후 Codex / Cursor / Gemini / Copilot 같은 다른 LLM surface 는 별도 adapter 로 추가') 을 (a) 첫 줄 narrative 안 격상 + (b) tier schema 안 정식 정전. 신규 도입 아닌 격상 본질 = major bump 정당성 = 정체성 첫 줄 breaking change (단수 → 복수 표현)."
    }
  ]
}
```

### Narrative

조사 본질은 INTENT 본질 ('정전화만') 정합 minimal capability survey — 깊은 mechanism 조사 (oos_1~3 별 milestone) 회피. external 3건 안 ext_1 (Claude Code 자동화 표면 8건) + ext_2 (Claude Agent SDK Python = Claude Code/Claude Agent 종속) + ext_3 (Omni Agent SDK = LLM-agnostic SDK 외부 존재) 가 본 조사의 핵심 source. ext_2 는 SDK 화 본질 안 Anthropic SDK 의 멀티 LLM 미해결 fact 확인 (context7 metadata 차원, 공식 docs 인용 보강은 별 RESEARCH), ext_3 는 본 fact 를 'Anthropic SDK 한정 미해결 / LLM-agnostic SDK 가능성 보존' 으로 분리 본질 — risk_3 source.

codebase 9건 finding 안 핵심 발견 2건 = (a) cascade host enumerate 안 INTENT sc_4 5건 → 실제 **8건** 발견 (★ cb_6 development/ARCHITECTURE.md:304 § 7.1 cross-ref + cb_7 .claude-plugin/plugin.json:4 + cb_8 pyproject.toml:4 3건 추가) → risk_1 + DESIGN sc_4 보정 의무 / (b) cb_9 ARCHITECTURE § 3.1 line 71 Core/Adapter 분리 원칙 이미 존재 → 본 milestone 본질 = 격상 (신규 도입 아님) → risk_5 + major bump 정당성 narrative 명시 의무. cascade host 안 표현 3 갈래 (Claude Code adapter maintainer / Claude Code adapter / Claude Code ecosystem integrator + agent fleet maintainer) 도 risk_4 source — DESIGN 안 cascade unify 정책 결정 필요.

options 5건 안 DESIGN 안 우선 검토할 후보 거명 = opt_1 (tier 수 4) + opt_4 (a, 핵심 원칙 § 3.1 확장). opt_2 (tier 수 3) 는 RESEARCH 안 trade-off 약점 도출 (MCP 본질 흡수 안 narrative 혼란) — 채택/폐기 자체는 DESIGN 안 결정. opt_3 (정체성 표현) + opt_5 (SDK 화) 는 DESIGN 안 finalize / oos 보정. risks_identified 5건 안 risk_1 (cascade host 8건 보정) + risk_5 (격상 본질 명시) 가 본 RESEARCH 의 직접 산출 — INTENT 안 미발견된 본질 발견. DESIGN risk_mitigation 매핑 안 본 5 risk → 5 d_X 결정 매핑 자연.

본 RESEARCH 가 INTENT 안 발견 못 한 본질 (host 3건 추가 + Omni SDK 후보 + 격상 본질) 을 추가 발견 — codex finding 1 안 '명시 stage 책임 분리' (INTENT scope + RESEARCH 사실 + DESIGN 결정) 정합 본질. INTENT 안 scope + candidate direction 확정 시 RESEARCH 안 사실 추가 발견 자연 → DESIGN 안 결정 보정 자연 cycle. v9.0 의 stage cycle 본질 정합.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "tier schema = opt_1 (4 tier) 채택 — Core methodology (LLM-agnostic canonical spec) / Reference adapter (Claude Code, richest automation) / Portable adapters (Codex + Gemini + Cursor, docs + CLI-first) / Optional integration (MCP wrappers, CLI 안정 후 2차)",
      "rationale": "RESEARCH opt_1 채택 (opt_2 폐기). MCP 본질 (Optional 차원 = 미래 가능성, CLI 안정 후 wrapper) 과 Portable 본질 (현 권장 = docs surface 직접 추가) 자연 분리 — 흡수 시 narrative 혼란. INTENT sc_3 직접 정합."
    },
    {
      "id": "d_2",
      "decision": "핵심 원칙 한 줄 정전 위치 = opt_4 (a) ARCHITECTURE § 3.1 확장 채택 — 정체성 paragraph 안 본 원칙 직접 source 자연 정합. § 신규 회피 (numbering drift risk)",
      "rationale": "RESEARCH opt_4 (a) 검토 우선 → 본 DESIGN 안 채택. 정체성 paragraph (§ 3.1) 가 본 원칙 ('automation parity 아니라 portable methodology with adapter-specific tiers') 의 직접 source — '본 repo 가 무엇을 만드는가' 본질 정합 (§ 7 AI Native 운영 = '본 repo 가 어떻게 운영되는가' 본질 분리). risk_2 mitigation."
    },
    {
      "id": "d_3",
      "decision": "정체성 첫 줄 표현 = opt_3 (a) 'reference adapter maintainer + portable adapter coordinator' (codex 제안 이중 책임) 채택 — 본 host 패턴 (' + ' literal 사용 자연) 정합 + tier 분류 (d_1) 직접 반영",
      "rationale": "RESEARCH opt_3 (a) 우선 후보 → 본 DESIGN 안 채택. opt_3 (b) 'multi-LLM adapter coordinator (reference: Claude Code)' 폐기 — 단일 책임 단어로 묶으면 '이중 책임' 본질 (reference 안 richest 책임 + portable 안 coordinator 책임) 명시 부재. (a) 가 d_1 4 tier 와 직접 정합."
    },
    {
      "id": "d_4",
      "decision": "핵심 원칙 한 줄 정확 표현 = codex 제안 한국어 정전 + 영어 derived 그대로 채택 — 한국어: '목표는 LLM 도구 간 자동화 동등성이 아니라, 도구별 자동화 tier 를 인정하는 이식 가능한 방법론이다.' / 영어 derived: 'The goal is not automation parity across LLM tools, but portable methodology with adapter-specific automation tiers.'",
      "rationale": "INTENT sc_2 안 codex 제안 후보 거명 → 본 DESIGN 안 채택. 한국어 정전 안 영어 단어 mix ('LLM', 'tier') 가 본 repo 한국어 narrative 어조 (CLAUDE.md / ARCHITECTURE 패턴) 정합. 영어 derived 는 AGENTS.md / README.md 영문 host 정합 source."
    },
    {
      "id": "d_5",
      "decision": "INTENT sc_4 cascade host 5건 → 10건 amend = **DESIGN 시점 직접 적용 완료** (line 69 sc_4 본문 보정 끝). 10 host = (한국어 primary 3) CLAUDE.md:3 + development/ARCHITECTURE.md:69 + development/ARCHITECTURE.md:304 / (영문 primary 4) README.md:3 + AGENTS.md:3 + .claude-plugin/plugin.json:4 + pyproject.toml:4 / (v4.0 ecosystem-integrator 별 표현 3) development/CLAUDE.md:5 + .claude-plugin/marketplace.json:3 + .claude-plugin/marketplace.json:12. EXECUTE phase-2 = 본 amend 된 sc_4 안 10 host cascade edit 적용 + 검증 (amend 자체는 phase-2 안 부재)",
      "rationale": "RESEARCH cb_6/7/8 발견 3건 (§ 7.1 + plugin.json + pyproject.toml) + design-review architecture 관점 추가 발견 2건 (marketplace.json:3 + :12, 모두 v4.0 ecosystem-integrator 패턴). INTENT sc_4 직접 amend 본질 = stage 책임 분리 정합 (INTENT scope + RESEARCH 발견 + design-review 추가 + DESIGN 결정 cycle). DESIGN 시점 amend = trace 명료 (phase-2 안 amend 표현 회피, codex finding 1 정합). risk_1 mitigation."
    },
    {
      "id": "d_6",
      "decision": "cascade host role별 표현 변형 정책 — (a) primary identity hosts 7건 (영문 4 + 한국어 3) = multi-LLM tier 표현 cascade (영문: 'reference adapter (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)' / 한국어: 'reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)'). (b) v4.0 ecosystem-integrator hosts 3건 (development/CLAUDE.md:5 + .claude-plugin/marketplace.json:3 + .claude-plugin/marketplace.json:12) = Claude reference adapter rich capability 표현 보존/보정 — 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 패턴 유지 (v4.0 별 본질 = '본 repo 운영자 역할' vs primary 'Claude Code adapter maintainer' = '본 repo 제품 분류' 별 narrative dimension)",
      "rationale": "사용자 명시 결정 (2026-05-28) — '전부 같은 문장으로 통일' 보다 host role별 표현 변형 허용. v4.0 ecosystem-integrator hosts 본질 = '본 repo 가 Claude Code ecosystem 안 무엇을 한다' (운영자 역할), primary identity hosts 본질 = '본 repo 가 어떤 adapter 분류 안 거주한다' (제품 분류) — 별 narrative dimension 보존. design-review trace 관점 결정적 finding 정합. risk_4 mitigation."
    },
    {
      "id": "d_9",
      "decision": "§ 3.5 Adapter taxonomy 표 갱신 = phase-1 deliverable 안 포함 — 현 표 (5 row: Claude Production / Codex Documentation-ready / Cursor Candidate / Gemini Candidate / Copilot Candidate) 가 d_1 4 tier schema (Core / Reference / Portable / Optional integration) 직접 host 후보. 표 column 안 'Tier' 추가 또는 'Status' column 의 4 tier 정합 매핑 명시",
      "rationale": "design-review architecture 관점 결정적 권고 발견. § 3.1 첫 줄만 바꾸고 § 3.5 taxonomy 예전 상태 시 구조 drift 발생. v9.0 = 'tier 정책 정전화' 본질 정합 = § 3.5 표 = d_1 4 tier 의 직접 mechanism — phase-1 안 양자 결정 의무. fact 확인 = ARCHITECTURE.md:118-128 직접 read (table row 5건 + column 4 = Adapter / Surface / Status / Boundary)."
    },
    {
      "id": "d_7",
      "decision": "INTENT oos_8 신규 추가 = **DESIGN 시점 직접 적용 완료** (line 105~ oos_8 본문 추가 끝). oos_8 본문 = 'SDK 화 후보 (Omni Agent SDK 등 LLM-agnostic SDK 채택 평가) 는 별 milestone (v9.5+ 후보) — 본 milestone scope (정전화만) 외, 다만 Anthropic Claude Agent SDK 의 멀티 LLM 미해결 fact (RESEARCH ext_2) 와 LLM-agnostic SDK 가능성 fact (RESEARCH ext_3) 를 별 본질로 보존'. sc_4 amend 와 본질 일관 = DESIGN 시점 INTENT 직접 amend",
      "rationale": "RESEARCH risk_3 mitigation. ext_2/ext_3 두 fact 분리 안 SDK 화 본질 'Anthropic SDK 한정 미해결 / LLM-agnostic SDK 가능성 보존' 정합. 본 oos_8 거명 부재 시 'SDK 화 본질 완전 미해결' 오해 + 향후 drift. DESIGN 시점 INTENT 직접 amend = sc_4 amend (d_5) 와 본질 일관 (trace 명료, codex finding 2 정합)."
    },
    {
      "id": "d_8",
      "decision": "격상 본질 narrative 명시 = 본 milestone 은 ARCHITECTURE § 3.1 line 71 existing 'Core / Adapter 분리 원칙' (v4.0 도입) 격상 (신규 도입 아님). major bump v9.0 정당성 = 정체성 첫 줄 breaking change (단수형 'Claude Code adapter maintainer' → 복수형 'reference adapter maintainer + portable adapter coordinator'). EXECUTE phase-1 narrative 안 격상 본질 명시 의무",
      "rationale": "RESEARCH cb_9 + risk_5 mitigation. line 71 안 'Core / Adapter 분리 원칙' 이미 존재 ('향후 Codex / Cursor / Gemini / Copilot 같은 다른 LLM surface 는 별도 adapter 로 추가하되, AGENTS.md / .cursor/rules / GEMINI.md / .github/copilot-instructions.md 같은 tool-specific 파일을 선제 생성하지 않는다.') — 본 milestone = (a) 본 분리 원칙을 첫 줄 narrative 안 격상 + (b) tier schema 정식 정전. 격상 narrative 부재 시 '기존 원칙 그대로 / 본 milestone 가치 부족' 오해 + major bump 정당성 약화."
    }
  ],
  "approach": "본 milestone = '정전화만' 본질 (INTENT goal 직접 정합) — EXECUTE 2 phase 자연 분해. phase-1 = ARCHITECTURE 정전화 (§ 3.1 정체성 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신 + 핵심 원칙 한 줄 (d_4) + tier 분류 schema (d_1) + 격상 본질 narrative (d_8)). phase-2 = cascade 10 host edit 적용 + 검증 (d_5 amend 된 sc_4 의 10 host 안 d_6 role별 표현 변형 정책 적용 — primary 7 host 안 단수 → 복수 표현 cascade + 별 표현 3 host 안 v4.0 ecosystem-integrator 보존/보정). 두 phase 분리 본질 = (a) phase-1 narrative source 박혀야 phase-2 cascade 안 'source 정합 확인' 가능 (정책 없이 cascade 박으면 drift 회피) / (b) phase 단위 atomic commit 안 trace 명료. INTENT amend (sc_4 5→10 + oos_8 신규) 는 **DESIGN 시점 직접 완료** (d_5/d_7 정합) — phase-2 안 추가 amend 부재, host edit + 검증만.",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "ARCHITECTURE 정전화 — development/ARCHITECTURE.md § 3.1 정체성 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신 (d_9). 추가 narrative = (1) 핵심 원칙 한 줄 정전 (d_4 한국어 + 영어 derived) + (2) tier 분류 schema 4 tier (d_1) + (3) 격상 본질 narrative (d_8 — line 71 existing 분리 원칙 격상 + major bump 정당성) + (4) § 3.5 표 안 4 tier 정합 매핑 (Production = Reference / Documentation-ready = Portable / Candidate = Portable). § numbering 보존 (§ 3.1 + § 3.5 확장만, § 신규 회피).",
      "deliverable": "development/ARCHITECTURE.md edit (§ 3.1 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신)",
      "verification": "smoke-spec-verification (회귀 부재) + smoke-cross-ref (정합) + 사용자 명시 검토"
    },
    {
      "phase": "phase-2",
      "scope": "cascade 10 host edit 적용 + 검증 — DESIGN 시점 amend 완료된 INTENT sc_4 안 10 host 안 d_6 host role별 표현 변형 정책 cascade edit 적용. (a) primary identity hosts 7건 = multi-LLM tier 표현 cascade (한국어 3: CLAUDE.md:3 + development/ARCHITECTURE.md:69 + development/ARCHITECTURE.md:304 / 영문 4: README.md:3 + AGENTS.md:3 + .claude-plugin/plugin.json:4 + pyproject.toml:4). (b) v4.0 ecosystem-integrator hosts 3건 = 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 패턴 보존/보정 (development/CLAUDE.md:5 + .claude-plugin/marketplace.json:3 + .claude-plugin/marketplace.json:12). INTENT amend 본문 (sc_4 5→10 + oos_8 신규) 부재 — DESIGN 시점 직접 amend 완료. grep 3 형식 (relative/절대/anchor, v8.2 정합) + Windows PowerShell Select-String 직접 1회 (잔존 단수 표현 0건 확인) 안 검증.",
      "deliverable": "primary 7 host cascade edit + 별 표현 3 host 보존 확인 (INTENT sc_4/oos_8 amend 자체는 DESIGN 시점 완료)",
      "verification": "smoke-spec-verification + smoke-cross-ref + grep 3 형식 + Windows PowerShell Select-String 잔존 단수 표현 0건 + 사용자 명시 검토"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_5",
      "method": "INTENT sc_4 host 5건 → 10건 amend = DESIGN 시점 직접 적용 완료 (RESEARCH 안 발견 3건 + design-review 안 추가 발견 2건 흡수). EXECUTE phase-2 = host edit cascade + grep 3 형식 (relative path / 절대 path / symlink-anchor 변형, v8.2 가벼운 흐름 정합) + Windows PowerShell Select-String 직접 1회 (잔존 단수 표현 0건 확인) + smoke-cross-ref 회귀 부재 확인."
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_2",
      "method": "§ 3.1 + § 3.5 확장 채택 (d_9 정합) = numbering 보존 + 정체성 paragraph + Adapter taxonomy 표 자연 정합. § 신규 회피 (현 § 11.4 최신 → § 12 신규 시 cross-ref drift)."
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_7",
      "method": "INTENT oos_8 신규 거명 (phase-2 안 INTENT amend 동시 적용). SDK 화 부분 미해결 (Anthropic 한정) + 부분 후보 보존 (LLM-agnostic SDK 별 milestone v9.5+) 본질 명시 → 'SDK 화 본질 완전 미해결' 오해 회피."
    },
    {
      "risk_ref": "risk_4",
      "decision_ref": "d_6",
      "method": "cascade host role별 표현 변형 정책 (영문 primary 4 + 한국어 primary 3 + v4.0 ecosystem-integrator 별 표현 3 = 10 host). 단일 표현 강제 회피 (별 narrative dimension 보존 = '본 repo 운영자 역할' vs '본 repo 제품 분류'). 단수 → 복수 표현 cascade 핵심 — '단일 LLM 종속' → 'multi-LLM tier 정책'."
    },
    {
      "risk_ref": "risk_5",
      "decision_ref": "d_8",
      "method": "EXECUTE phase-1 narrative 안 격상 본질 명시 = line 71 existing 분리 원칙 격상 (신규 도입 아님). major bump 정당성 = 정체성 첫 줄 breaking change. ARCHITECTURE § 3.1 확장 paragraph + § 3.5 표 갱신 (d_9) 안 '격상' 어휘 직접 사용."
    }
  ],
  "five_perspective_review": {
    "method": "subagent harness-meta:design-review 호출 — perspectives array = [architecture, workflow, constraint, verification, trace] (codex 추천 + 본 repo 5요소 정합). subagent 호출 완료 (agentId a889f649ecf25037b, 2026-05-28, 결정적 finding 2건 + 권고 3건 + scope_out 4건 산출). fact verification = host 10건 + § 3.5 표 + bootstrap 2 host 모두 직접 grep/Read PASS (hallucination 부재, memory feedback_subagent_fact_hallucination_correction 정합). 결정적 finding 모두 본 DESIGN 안 흡수 (d_5 → 10 host / d_6 host role별 표현 변형 / d_9 § 3.5 갱신), scope_out 4건 = SCOPE_OUT_NOTES 흡수.",
    "perspectives": [
      {
        "perspective": "architecture",
        "verdict": "pass-with-comments",
        "comments": "scope 안: tier schema § 위치 (d_2) + 정체성 첫 줄 표현 (d_3 이중 책임) + 격상 본질 (d_8) 모두 PASS 정합. 결정적 발견 1건 = cascade host 8 → 10 보정 (marketplace.json:3 + :12 2 host 추가, v4.0 ecosystem-integrator 패턴) — d_5 amend 흡수. 부수 발견 = README.md:96/165 + AGENTS.md:44 본문 narrative 안 'Claude Code adapter' 어휘 (정체성 첫 줄 아닌 directory tree comment / 본문 narrative) 본 milestone scope (정체성 첫 줄) 외 — phase-2 안 분리 확인 권고. scope 외 = § 3.5 Adapter taxonomy 표 갱신 = 본 milestone scope 안 자연 흡수 (d_9 신규) — 본 표가 d_1 4 tier schema 직접 host 후보."
      },
      {
        "perspective": "workflow",
        "verdict": "PASS",
        "comments": "9-stage cycle 본질 정합 — INTENT/RESEARCH/DESIGN 작성 완료, APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 자연 진행. INTENT amend 본질 (d_5 + d_7) = codex finding 1 (stage 책임 분리 = INTENT scope + RESEARCH 사실 + DESIGN 결정) 직접 정합 — INTENT 회수 (rework) 아닌 DESIGN amend 차원 흡수. 2 phase 자연 분해 (phase-1 ARCHITECTURE 정전화 + phase-2 cascade 보정) = source 정합 + atomic commit trace 명료. 결정적 결함 부재. scope 외 = INTENT amend 패턴 정전화 (v9.1+ candidate) → SCOPE_OUT_NOTES 흡수."
      },
      {
        "perspective": "constraint",
        "verdict": "PASS",
        "comments": "out_of_scope 7 → 8건 (d_7 oos_8 신규 SDK 화) 자연 — 8 oos 가 본 milestone scope (헌법 박기만) 강하게 보호. 2 phase 자연 분해 (5 phase 회피, codex OPEN 안 거명 5단계 phase 의 나머지 3 = oos_1~6 별 milestone 자연). APPROVE 게이트 (sc_1 정체성 첫 줄 breaking change = 사용자 명시 승인 필수) 정합. scope creep risk minimal. 결정적 결함 부재. scope 외 = oos_4 자동화 매트릭스 부분 거명 → d_9 § 3.5 표 갱신 안 자연 흡수."
      },
      {
        "perspective": "verification",
        "verdict": "pass-with-comments",
        "comments": "scope 안: sc_1-3 (ARCHITECTURE 박힘) PASS + sc_5 (active smoke 15건) PASS. 결정적 발견 = sc_4 host 8 → 10 보정 (architecture 관점 중복 거명) — d_5 amend 흡수. 권고 = grep 3 형식 + Windows PowerShell Select-String 직접 1회 (잔존 단수 표현 0건 확인) 추가 — phase-2 verification amend 흡수 (Windows workspace 운영 정합 + 1차 source 직접 확인 fact-hallucination 검증 정합). scope 외 = smoke-roadmap-archival 패턴 안 정체성 host count 자동 검증 mechanism (v9.2+ 별 milestone) → SCOPE_OUT_NOTES 흡수."
      },
      {
        "perspective": "trace",
        "verdict": "pass-with-comments",
        "comments": "scope 안: 격상 본질 narrative trace (d_8 + ARCHITECTURE.md:71 line 71 existing 분리 원칙 격상 + 'v8.x adapter-neutral remodel' 인용) + 단수 → 복수 표현 cascade PASS. 결정적 발견 = marketplace.json 별 표현 처리 정책 결정 게이트 — 사용자 명시 결정 (2026-05-28) 후 d_6 amend 흡수 (별 본질 보존 = '본 repo 운영자 역할' vs '본 repo 제품 분류' 별 narrative dimension). 별 표현 host 1 → 3건 (development/CLAUDE.md:5 + marketplace.json:3 + :12). scope 외 = bootstrap/claude-code-catalog/README.md:3 + bootstrap/agents/CLAUDE.md:9 = 'ecosystem integrator' 2 host (bootstrap 내부 narrative, v9.x 후속 cascade 정책 정전화 source) + v4.0 ecosystem integrator vs Claude Code adapter maintainer 별 본질 cascade unify 정책 → SCOPE_OUT_NOTES 흡수."
      }
    ]
  }
}
```

### Narrative

설계 본질 9 decisions 종합 — d_1 (tier schema 4 tier) + d_2 (핵심 원칙 § 3.1) + d_3 (정체성 첫 줄 표현 이중 책임) + d_4 (핵심 원칙 정확 표현 codex 제안 채택) + d_9 (§ 3.5 Adapter taxonomy 표 갱신) = ARCHITECTURE 정전화 본질 (phase-1). d_5 (cascade 5→10 host) + d_6 (host role별 표현 변형 정책 — primary 7 + 별 표현 3) + d_7 (oos_8 SDK 추가) + d_8 (격상 본질 narrative 명시) = cascade 10 host 보정 + INTENT amend 본질 (phase-2). 두 phase 분리 = source 정합 (phase-1 narrative 박혀야 phase-2 cascade '정합 확인' 가능) + atomic commit trace 명료.

risk_mitigation 5건 (risk_1→d_5 / risk_2→d_2 / risk_3→d_7 / risk_4→d_6 / risk_5→d_8) 1:1 매핑 정합 — RESEARCH 안 발견된 본질이 모두 본 DESIGN decision 으로 흡수. INTENT sc 5건 매핑 = sc_1↔d_3 / sc_2↔d_4 / sc_3↔d_1+d_9 / sc_4↔d_5+d_6 (host 5→10 amend + role별 표현 변형 정책) / sc_5 = EXECUTE 후 검증. INTENT amend (sc_4 5→10 + oos_8 신규 = 7→8건) 양자 모두 **DESIGN 시점 직접 적용 완료** (line 69 sc_4 보정 + line 105~ oos_8 추가) — phase-2 안 추가 amend 부재 / EXECUTE phase-2 = cascade edit + 검증만. trace 명료 정합 (codex finding 1+2 본질 일관).

5 관점 review 결과 종합 = subagent harness-meta:design-review 병렬 호출 완료 (agentId a889f649ecf25037b, 결정적 finding 2건 + 권고 3건 + scope_out 4건 산출). verdict = architecture pass-with-comments / workflow PASS / constraint PASS / verification pass-with-comments / trace pass-with-comments. fact verification 완료 (host 10건 + § 3.5 표 + bootstrap 2 host 모두 직접 grep/Read PASS, hallucination 부재). 결정적 finding 모두 본 DESIGN 안 흡수 (d_5 → 10 host amend / d_6 host role별 표현 변형 정책 / d_9 § 3.5 표 갱신 신규 + phase-1 deliverable + phase-2 verification 양자 amend), scope_out 4건 + 권고 5 (본문 narrative cascade 분리) = SCOPE_OUT_NOTES 흡수. memory feedback_subagent_parallel_review_evidence 정합 — 본 cycle 안 subagent 결과 안 INTENT/RESEARCH/DESIGN 안 발견 못 한 본질 2건 (marketplace.json host + § 3.5 표) 추가 발견 = inline review 대비 누적 가치 evidence.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-28",
    "approval_method": "본 conversation 안 6 round 누적 결정 trace + 최종 종합 승인 AskUserQuestion round 안 사용자 명시 응답 '(a) 승인 — EXECUTE 진입' 명시. 본 stage 본질 (사용자 명시 승인 게이트, Claude 자율 작성 금지) + v9.0 major bump 정당성 (정체성 첫 줄 breaking change) 직접 정합.",
    "scope_confirmed": [
      "R1 (v9.0 OPEN 진입, 2026-05-28): codex 외부 진단 ('현재 harness-meta 는 Claude Code 에서만 사용할 수 있는 구조') + Claude ↔ codex 두 차례 cross-check round 후 사용자 명시 '진행' — OPEN stage 디렉토리 + MILESTONE.md skeleton + ROADMAP entry in_progress 결정",
      "R2 (INTENT 범위 좁힘): 사용자 명시 '(a) 정전화만 (추천)' — v9.0 = 정체성 첫 줄 + 핵심 원칙 한 줄 + tier schema 박기만 / 실 어댑터 / CLI / MCP = v9.1+ 별 milestone 분리. SDK 의문 = '멀티 LLM 안 본 repo 동작 (착각 가능성)' 명시 후 폐기 결정",
      "R3 (INTENT codex finding 2 round 보정 후 RESEARCH 진입): 사용자 명시 '묶어서 커밋하고 INTENT 진입' + '묶어서 커밋하고 RESEARCH 진입' — INTENT amend (sc 5 / oos 7 / dep 6) + drift 보정 2 round (stage 책임 분리 + ext_2 softening + uncited 제거) 묶음 commit",
      "R4 (RESEARCH codex finding 2 round 보정 후 DESIGN 진입): 사용자 명시 'RESEARCH는 통과로 봐도 됩니다 + RESEARCH commit 개별 + DESIGN 진입 + 5 관점 design-review 적용' — RESEARCH 산출 (cascade host 5→8 발견 + Omni SDK + 격상 본질) + codex 보정 2 round 합쳐 개별 commit + DESIGN 진입 + perspectives=[architecture/workflow/constraint/verification/trace] 명시",
      "R5 (DESIGN design-review marketplace.json 처리 정책 결정): 사용자 명시 '(b) 별 본질 보존 변형' — host role별 표현 변형 정책 (primary 7 = multi-LLM tier 표현 / v4.0 ecosystem-integrator 3 = 별 본질 보존) + cascade host 8 → 10 직접 보정 + INTENT sc_4 10건 amend (drift 회피) + § 3.5 Adapter taxonomy 표 갱신 phase-1 포함 + Windows PowerShell Select-String 검증 추가 + bootstrap 2 host = SCOPE_OUT_NOTES 거명",
      "R6 (DESIGN codex finding 2 round 보정 후 APPROVE 진입): 사용자 명시 '묶어서 커밋하고 APPROVE 진입' — DESIGN 묶음 commit (codex finding 보정 = INTENT amend trace 일관 / sc_4+oos_8 양자 DESIGN 시점 직접 amend 일관) + APPROVE 진입 결정",
      "R7 (본 APPROVE round 안 최종 종합 승인, AskUserQuestion 2026-05-28): 사용자 명시 '(a) 승인 — EXECUTE 진입' — DESIGN 9 decisions + 2 phases + INTENT amend (sc_4 5→10 + oos_8) + SCOPE_OUT_NOTES 5건 + 5 관점 design-review 흡수 모두 종합 승인. EXECUTE phase-1 ARCHITECTURE 정전화 (§ 3.1 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신) → phase-2 cascade 10 host edit + 검증 진입 명시"
    ]
  }
}
```

### Narrative

본 APPROVE = v9.0 major bump (정체성 첫 줄 breaking change) 의 사용자 명시 종합 승인 게이트 — Claude 자율 작성 금지 본질 + CLAUDE.md root § 개발 프로세스 정합 ('~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수'). 본 conversation 안 6 round 누적 결정 (R1 OPEN 진입 / R2 INTENT 범위 / R3 INTENT commit + RESEARCH / R4 RESEARCH commit + DESIGN + 5 관점 / R5 DESIGN marketplace.json 처리 + 10 host + § 3.5 + PowerShell + SCOPE_OUT_NOTES / R6 DESIGN commit + APPROVE 진입) 가 본 stage 본질 (사용자 명시 승인 trace) 의 직접 source — 본 round (R7) 안 최종 AskUserQuestion 안 '(a) 승인 — EXECUTE 진입' 명시 응답으로 종합 승인 본질 보존. 다음 단계 = EXECUTE phase-1 (ARCHITECTURE § 3.1 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신) → phase-2 (cascade 10 host edit + 검증) 진입.

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {
      "phase": "phase-1",
      "status": "completed",
      "deliverable_path": "execute/phase-1.md",
      "commits": [
        {
          "sha": "pending",
          "message": "feat(meta): [v9.0 EXECUTE phase-1] ARCHITECTURE § 3.1 정체성 첫 줄 multi-LLM tier 격상 + § 3.5 표 갱신"
        }
      ],
      "summary": "ARCHITECTURE § 3.1 line 69 정체성 첫 줄 단수 → 복수 표현 cascade (d_3) + § 3.1 line 98 다음 v9.0 paragraph 추가 (핵심 원칙 한 줄 d_4 + 4 tier 분류 표 d_1 + 격상 본질 narrative d_8) + § 3.5 Adapter taxonomy 표 Tier column 추가 + MCP row 신규 (d_9). 5 decisions 흡수 (d_1+d_3+d_4+d_8+d_9). source narrative 박힘 — phase-2 cascade 10 host edit 의 '정합 확인' source. 상세 별책 = execute/phase-1.md."
    }
  ]
}
```

### Narrative

본 EXECUTE = DESIGN phases 2건 per-phase 1 commit 본질 (v6.2+ 9-stage-flattened era 정합 — 본책 = phase 진행 요약, 별책 = `execute/phase-{n}.md` 상세). phase-1 (ARCHITECTURE 정전화) 완료 = source narrative 박힘 + smoke 사전 PASS (538/0 — execute/phase-1.md 신규 1 PASS 추가 + status 필드 보정 후 정합). phase-2 (cascade 10 host edit + 검증) 진입 = phase-1 commit 후 source 정합 확인 후 진행 자연. commit SHA = pending (사용자 명시 commit 결정 후 갱신, Spec.commit.sha + MILESTONE.md phases_executed[].commits[].sha 2 위치 동시 갱신 본질 — frontmatter 안 commit SHA 필드 부재).

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음. INTENT/DESIGN 안 sub-milestone 분리 필요성 재평가 가능.)

## SCOPE_OUT_NOTES

DESIGN 5 관점 design-review (agentId a889f649ecf25037b, 2026-05-28) 안 거명된 scope 외 본질 5건 — 본 milestone scope (정전화만) 안 포함 부재, 후속 milestone candidate source. v7.0 T1.3 정합 (거명 있을 때만 H2 생성).

1. **본문 narrative 안 'Claude Code adapter' 어휘 cascade 본질 분리** (architecture, 정보용): README.md:96 + README.md:165 + AGENTS.md:44 안 'Claude Code adapter' 어휘 본문 narrative (정체성 첫 줄 아닌 directory tree comment / 본문 인용) = 본 milestone scope (정체성 첫 줄) 외. phase-2 EXECUTE 안 분리 확인 권고 (cascade host 안 포함 X, 본문 narrative 본질 분리). v9.1 codex 어댑터 보강 (oos_1) 시 자연 흡수 후보.

2. **§ 3.5 Adapter taxonomy 표 갱신 자동 매트릭스 mechanism** (architecture): 본 v9.0 안 § 3.5 표 갱신 manual amend (d_9 phase-1 안 흡수). cascade host enumerate + tier schema 정합 자동 매트릭스 검증 mechanism = v9.2+ 별 milestone 후보 (smoke 강제 본질). 현 v9.0 안 manual 의존.

3. **INTENT amend 패턴 정전화 후보** (workflow): 본 v9.0 가 'DESIGN 안 INTENT sc/oos amend' 본질 cycle 도그푸드 사례 (codex finding 1 stage 책임 분리 정합). 본 amend 패턴이 다른 milestone 안 반복 발현 시 정전화 가치 — v9.1+ PROPOSE candidate (workflow narrative 정전화).

4. **smoke-roadmap-archival 패턴 안 정체성 host count 자동 검증 mechanism** (verification): cascade host enumerate 자동 검증 mechanism — v9.2+ 별 milestone (architecture scope_out_2 와 정합). 본 v9.0 안 manual grep + Windows PowerShell Select-String 의존 (d_5/d_6 verification 안 명시).

5. **bootstrap 내부 narrative 안 'ecosystem integrator' 별 표현 cascade 정책 정전화** (trace): bootstrap/claude-code-catalog/README.md:3 + bootstrap/agents/CLAUDE.md:9 = 'project harness composer + Claude Code ecosystem integrator + agent fleet maintainer' 패턴 2 host 추가 발견 (bootstrap 내부 module guide / catalog narrative). 본 milestone scope (root + 정체성 첫 줄 cascade) 외 — bootstrap 내부 narrative 본질 분리. 추가 v4.0 ecosystem-integrator vs primary 'Claude Code adapter maintainer' 별 본질 cascade unify 정책 정전화 = v9.x 후속 milestone 후보 (작은 건 = 가벼운 흐름 후보 자연 — 본질 narrative 정합만 본질).

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

---
id: audit-chain-hallucination-auto-correction
title: audit chain hallucination 자동 정정 mechanism
version: v6.6
status: in_progress
---

# v6.6 — audit chain hallucination 자동 정정 mechanism

## INTENT

### Spec

```json
{
  "id": "audit-chain-hallucination-auto-correction",
  "title": "audit chain hallucination 자동 정정 mechanism",
  "goal": "audit chain (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer) 산출물 안 hallucination (boolean/표/수치 method 3종) 을 `--audit` flow 안 audit-team synthesizer step 안 자동 detect → mismatch 보고. 자율 범위 = 검출 only (재귀 hallucination 위험 차단 + 사용자 결정 게이트 보존), 정정은 사용자/orchestrator 수동. AI Native § 7.1 '다중 AI 협업' 면 두 번째 실 적용 (첫 번째 = v6.4 cascade-sync). mechanism = 3 컴포넌트 hybrid (v6.4/v6.5 패턴 정합) — deterministic core (`scripts/audit_fact_verify.py`) + narrative orchestrator (`agents/project-harness-audit-team/CLAUDE.md` step 분기 + 표 schema 표준화) + smoke (`tests/smoke-audit-fact-verify.sh`). cycle 4 인용 method (v6.5 외부 vector P1#1 origin) = LLM 추론 필요 + script-only 불가능 → v6.6 scope 외 (PROPOSE 후속 거명만).",
  "success_criteria": [
    {"id": "sc_1", "description": "`--audit` flow 안 자동 detect 통합 — audit-team synthesizer step (component-proposer 직후, component-installer 직전) 안 `scripts/audit_fact_verify.py` 자동 호출 + mismatch 보고 → 사용자 정정 결정 게이트 보존. v4.0 audit-team 5 단계 sequence → 6 단계 (synthesizer step 분기 추가). 구체 호출 방식 + CLI interface (`--dir <audit-output>` / `--strict` flag 등) = DESIGN 안 결정."},
    {"id": "sc_2", "description": "v5.13 정전화 3 method (boolean/표/수치) script-only detect logic 도입 — boolean lookup table 사전 (cycle 2 v5.11 evidence 매핑 + 미래 확장 자연) + 표 schema 표준화 의무 narrative (audit-team CLAUDE.md 안 column 정의) + 수치 lookup table empty 초기 (evidence 도달 시 사전 추가, no-op fallback). 인용 method (cycle 4) 는 oos_2. script LOC ~170 (v6.4 cascade_sync ~220 / v6.5 propose_next ~190 정합). 재귀 hallucination 위험 0 (script-only, LLM call 부재). 구체 method 별 detect logic + parser 본질 = DESIGN 안 결정."},
    {"id": "sc_3", "description": "3 컴포넌트 hybrid 구성 (v6.4/v6.5 시리즈 패턴 정합) — (1) deterministic core (`scripts/audit_fact_verify.py`) + (2) narrative orchestrator (`agents/project-harness-audit-team/CLAUDE.md` step 6 분기 추가 + 표 schema 표준화 narrative + v5.13/v5.18 절차 자동 실행 본질 명시 + cycle 4 후속 narrative) + (3) smoke (`tests/smoke-audit-fact-verify.sh`, fixture-based read-only). 구체 narrative 위치 + smoke fixture 구조 + pre-commit hook 등재 = DESIGN 안 결정."},
    {"id": "sc_4", "description": "ARCHITECTURE § 4 끝 매트릭스 #10 row + paragraph 본문 정전화 (v6.4 #8 + v6.5 #9 시리즈 정합) — '`--audit` flow 안 자동 hallucination 검출 mechanism' 1차 source 표지 + cascade host 매핑 (root CLAUDE.md + `/harness-meta` slash command md + agents/project-harness-audit-team/CLAUDE.md). v3.21 narrative 정전화 3 단계 패턴 cycle 32 자연 발현. cascade 7 host (v6.4 cascade-sync mechanism 자동 동기 적용)."},
    {"id": "sc_5", "description": "회귀 0 — 기존 smoke 17종 (projects-scope-discipline / spec-verification / scope-contract / cross-ref / claude-md-drift / bundle-trigger / open-stage-discipline / entry-title-guideline / cascade-drift / candidate-draft-schema 등) + 신규 smoke-audit-fact-verify 모두 PASS. pre-commit 17 hook → 18 hook (smoke-audit-fact-verify 등재). 신규 smoke 는 read-only (fixture-based, 실 audit chain 산출물 없이 작동)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "자동 정정 (검출 후 script 직접 inline edit)", "reason": "R1 결정 (2026-05-20) — 재귀 hallucination 위험 (source 자체 hallucination 가능, 정정 행위 자체가 hallucination 가능) + 사용자 결정 게이트 해제 + memory feedback_subagent_fact_hallucination_correction '비대칭 default' (검증 의무는 synthesizer / 정정 책임은 사람) 위배 + evidence base 0 (cycle 1~4 모두 사람 정정 패턴). 검출 only 로 단일 path 자연 정합."},
    {"id": "oos_2", "item": "인용 method 자동 detect (cycle 4 v6.5 외부 vector P1#1 evidence)", "reason": "R3 결정 (2026-05-20) — 인용 method = path:line + 인용 fact 매핑 + fact 부재 판정. fact 부재 판정 = source 안 동치 표현 인식 → LLM 추론 필요 → script-only 불가능 + 재귀 hallucination 위험. v6.6 scope 외, PROPOSE 후속 candidate 거명만 (target_version v6.x — '인용 method 자동 detect mechanism')."},
    {"id": "oos_3", "item": "명시 slash command `/audit-verify` (audit-team workflow 외부 별 호출)", "reason": "R2 결정 (2026-05-20) — scope 확장 evidence 부재 (5 관점 subagent / 외부 vector agent hallucination evidence 0건) → over-engineering 위험. `--audit` flow 안 자동 통합 (audit-team workflow 안 step 분기) 으로 cycle 4 evidence base 정확 매핑 + 사용자 인지 cost 0."},
    {"id": "oos_4", "item": "외부 산출물 (5 관점 subagent / 외부 vector agent) hallucination 자동 detect 적용", "reason": "R2 scope 결정 — 현재 evidence 부재 영역. audit chain 4 agent 한정 (cycle 4 evidence 모두 audit chain origin). 외부 evidence 도달 시 별 milestone 발의 자연 (v6.0 시리즈 외부 확장)."},
    {"id": "oos_5", "item": "agent .md `## Input Verification` 강화 only (script/smoke 부재)", "reason": "R4 결정 — v5.18 self-verify 강화만으로 cycle 4 evidence (agent self-verify 부재로 hallucination 발생) cover 안 됨 + mechanism 본질 부재 (v6.0 시리즈 표지 부적합). 3 컴포넌트 hybrid 시리즈 패턴 정합 자연."},
    {"id": "oos_6", "item": "PostToolUse hook 안 자동 trigger (Agent 호출 종료 시 자동 검증)", "reason": "R2 결정 — 토큰 비용 폭증 (매 Agent 호출 시 작동) + 사용자 모르는 사이 작동 + v6.5 oos_2 패턴 위배. `--audit` flag opt-in 통제 자연."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "pre-PLAN dialog 4 round (2026-05-20)", "purpose": "사용자 결정 source — R1 자율 범위 (검출 only) / R2 Trigger (`--audit` 자동) / R3 method scope (v5.13 3 method) / R4 컴포넌트 (3 hybrid)"},
    {"id": "dep_2", "source": "v6.0 INTENT.oos_5 + ROADMAP next_candidates target_version v6.6 (v6.2 OPEN 시 v6.5 → v6.6 shift)", "purpose": "본 milestone origin 정전 source (AI Native § 7.1 '다중 AI 협업' 면 두 번째 실 적용 후보)"},
    {"id": "dep_3", "source": "v5.13 fact 검증 3 method 분리 절차 + v5.18 검증 method narrative (boolean/표/수치)", "purpose": "script 안 3 method detect logic 1차 source"},
    {"id": "dep_4", "source": "cycle 4 direct evidence — v5.10 (component-proposer 12 항목 표) / v5.11 (project-scanner claude_md_in_repo false) / v5.12 (mapper bundled-skill 오분류) / v6.5 (외부 vector P1#1 fact 부재)", "purpose": "v6.6 발의 trigger + evidence base (cycle 1+2+3 cover, cycle 4 후속)"},
    {"id": "dep_5", "source": "v6.4 cascade-sync (3 컴포넌트 hybrid: slash + script + smoke) + v6.5 propose-next (동일 패턴) 시리즈", "purpose": "R4 결정 (3 컴포넌트 hybrid) 1차 source — narrative facing 대상만 다름 (사용자 → orchestrator)"},
    {"id": "dep_6", "source": "v6.2 5 관점 subagent 병렬 검토 패턴 (Plan + general-purpose × 4) + cycle 4 누적 (v6.2 + v6.3 + v6.4 + v6.5)", "purpose": "Stage D DESIGN 단계 적용 (feedback_subagent_parallel_review_evidence cycle 5 자연 부합)"},
    {"id": "dep_7", "source": "feedback_anthropic_yaml_frontmatter_pattern + v6.1 hybrid schema + v6.2 flattened era", "purpose": "MILESTONE.md 단일 본책 + H2 9 섹션 안 `### Spec` + ```json``` body 적용"},
    {"id": "dep_8", "source": "memory feedback (iterative_dialog / non_developer_role / iterative_pre_plan_review / token_efficiency_priority / subagent_fact_hallucination_correction)", "purpose": "작업 톤 + round 의무 + 비대칭 default (검증 의무 자동화 + 정정 책임 사람)"},
    {"id": "dep_9", "source": "v4.0 audit-team 5 단계 sequence (scanner → analyzer → mapper → proposer → installer) + agents/project-harness-audit-team/CLAUDE.md", "purpose": "synthesizer step 분기 추가 위치 (step 6 신규 — proposer 직후, installer 직전)"},
    {"id": "dep_10", "source": "ARCHITECTURE § 4 끝 매트릭스 #8 (v6.4 cascade-sync) + #9 (v6.5 propose-next)", "purpose": "v6.6 #10 row + paragraph 정전화 위치 1차 source (시리즈 표지)"}
  ]
}
```

### Motivation

v6.0 INTENT.oos_5 origin (AI Native § 7.1 '다중 AI 협업' 면 시리즈 후보 #2). v6.4 cascade-sync (첫 번째 cycle) 완료 후 자연 후속.

**audit chain hallucination 자동 검출 필요성 evidence** (cycle 4 direct 누적):

- cycle 1 (v5.10) — component-proposer 12 항목 표 hallucination → 사람이 overwrite (표 method)
- cycle 2 (v5.11) — project-scanner `claude_md_in_repo: false` (실제 true) → 사람이 inline 정정 (boolean method)
- cycle 3 (v5.12) — mapper bundled-skill 오분류 → 사람이 정정 (표 method)
- cycle 4 (v6.5) — 외부 vector P1#1 `v4.0/PROPOSE.md:54 category fleet-evolution` fact 부재 → 사람이 inline 정정 (인용 method)

수동 대응 patterns (v5.13/v5.18 정전화 절차) cycle 9+ 누적 cost → 자동화 자연 후속.

pre-PLAN 4 round 누적 결정 (2026-05-20):

1. **자율 범위** (R1) — 검출 only (자동 정정 부재). 재귀 hallucination 위험 차단 + 사용자 결정 게이트 보존 + memory `feedback_subagent_fact_hallucination_correction` '비대칭 default' (검증 의무는 synthesizer / 정정 책임은 사람) 직접 정합 + evidence base 0 (cycle 1~4 모두 사람 정정 패턴).
2. **Trigger** (R2) — `--audit` flow 안 자동 통합 (audit-team synthesizer step 분기). v4.0 audit-team 5 단계 sequence 자연 통합 + 사용자 인지 cost 0 + scope = audit chain 4 agent 산출물 한정 (cycle 4 evidence 정확 매핑).
3. **method scope** (R3) — v5.13 3 method (boolean/표/수치) 자동 + 인용 method 후속. v5.13/v5.18 narrative 직접 정합 + cycle 1+2+3 cover + 재귀 hallucination 위험 0 (script-only).
4. **mechanism 컴포넌트** (R4) — 3 컴포넌트 hybrid (script + smoke + audit-team CLAUDE.md narrative). v6.4/v6.5 시리즈 패턴 일관성 + narrative 1차 source 보존 + cascade drift 위험 차단 (v6.4 mechanism 자연 부합).

본 milestone 은 AI Native § 7.1 '다중 AI 협업' 면 second cycle — v6.4 cascade-sync (첫 번째: narrative 정전화 3 단계 패턴 (b) 자동화) 후속 = audit chain hallucination 자동 검출 mechanism (v5.13/v5.18 절차 자동 실행). v6.0 시리즈 표지 (v6.1 컨텍스트 효율 / v6.2 컨텍스트 효율 cycle 2 / v6.3 Verification / v6.4 다중 AI 협업 / v6.5 자율성 / v6.6 다중 AI 협업 cycle 2) 일관성 유지.

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "context7 /websites/code_claude — subagent output validation",
      "topic": "Claude Code agent prompt spec + structured output validation (claude -p --json-schema CLI flag, Agent SDK output_format json_schema)",
      "findings": "Claude Code agent prompt spec 안 fact verification 별 specific narrative pattern 부재 — debugger subagent example (workflow 1~5 step) + Stop hook agent prompt 예시만. structured output 검증 = `claude -p --json-schema` CLI flag 또는 Agent SDK Python `output_format={type: json_schema, schema: ...}` → SDK runtime 안 validation. v6.6 mechanism 본질 (산출물 안 fact 인용 boolean/표/수치 detect + 1차 source 매핑) 과 직교 — JSON schema validation 은 structural 만 (key 존재 / 타입 매칭), fact 정확성 (예: `claude_md_in_repo: false` 실제 true) 검증은 schema 외 책임.",
      "drift": "본 milestone scope = script-only key→source 매핑 detect, JSON schema validation 보다 더 specific. context7 source 안 동치 패턴 부재 → 본 milestone 의 mechanism 본질이 외부 spec 안 first-class 패턴 아님 (자기 정전화 의무 자연). v6.4 cascade-sync marker format 자체 컨벤션 자연 발현과 동일 패턴 (v5.7 spec-drift spike (c) 7번째 자연 발현 가능)."
    }
  ],
  "codebase": {
    "affected_files": [
      "scripts/audit_fact_verify.py (신규 ~170 LOC)",
      "tests/smoke-audit-fact-verify.sh (신규)",
      "tests/fixtures/audit-fact-verify/ (신규, fixture 디렉토리 — 정상/mismatch boolean/mismatch 표/error 4 fixture)",
      "agents/project-harness-audit-team/CLAUDE.md (edit — Step 6 synthesizer step 분기 narrative 추가 + 표 schema 표준화 의무 추가 + script 호출 명시)",
      "projects/meta/ARCHITECTURE.md (edit — § 4 끝 매트릭스 #10 row + paragraph 본문 정전화)",
      "claude/commands/harness-meta.md (edit — `--audit` 분기 안 synthesizer step 추가 narrative)",
      "CLAUDE.md (edit, root — cascade marker 안 narrative 추가 1 줄)",
      "tests/CLAUDE.md (edit — smoke-audit-fact-verify 등재)",
      ".pre-commit-config.yaml (edit — smoke-audit-fact-verify hook 추가)"
    ],
    "untouched_files_explicit": [
      "scripts/cascade_sync.py / scripts/propose_next.py (v6.4/v6.5 mechanism, 독립)",
      "agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer}.md (agent prompt 자체 = v5.18 정전화 narrative 유지, agent 내부 로직 미수정 — oos_5 정합)",
      "agents/component-installer.md (Step 5, fact 인용 부재 = scope 외)",
      "projects/upbit/audit-*/ (cycle 1~7 실 산출물 = fixture 참조 source 만, 본 milestone 안 수정 0)"
    ],
    "current_state": "v5.13 정전화 절차 (`agents/project-harness-audit-team/CLAUDE.md` Note v5.13 + v5.16 + v5.18 3 self-verify 누적) + ARCHITECTURE § 4 끝 paragraph (v5.11/v5.16/v5.18 정전화) 가 narrative 1차 source. 그러나 절차 자체는 synthesizer (메인 Claude orchestrator) 수동 실행. cycle 4 evidence (v5.10/v5.11/v5.12/v6.5) 모두 수동 detect + 수동 정정 cycle 9+ 누적 cost.",
    "target_state": "v5.13 3 method (boolean/표/수치) script-only 자동 detect → `--audit` flow 안 synthesizer step 안 자동 호출 → mismatch 보고. 자율 정정 부재 (R1 결정). audit-team CLAUDE.md Note v5.13 + v5.16 + v5.18 narrative 유지 + 신규 v6.6 Note 추가 (자동 mechanism 본질 + 표 schema 표준화 의무 narrative + 인용 method 후속 narrative)."
  },
  "options": [
    {
      "id": "opt_1",
      "name": "detect logic 접근법 — regex (단순) vs parser (정확) vs hybrid",
      "pros_cons": "regex (단순) = ~30 LOC/method, 구현 빠름, false positive 위험. parser (정확) = ~50 LOC/method, 정확 (Markdown table 구조 인식 / YAML key 정확 매핑), 외부 라이브러리 의존성 (Python tabular / yaml parsing 자체 stdlib `re` + `yaml` 만으로도 가능). hybrid = regex 1차 후 parser 2차. DESIGN 안 결정 — script-only deterministic 본질 정합 시 parser 우선 (false positive 차단)."
    },
    {
      "id": "opt_2",
      "name": "lookup table 구조 — Python dict 코드 inline vs 별 YAML/JSON 사전",
      "pros_cons": "Python dict inline (script 안 BOOLEAN_LOOKUP/NUMERIC_LOOKUP) = 단순, 코드 직접 변경. 별 YAML/JSON 사전 = script-data 분리, 사용자 확장 자연. v6.4 cascade_sync.py / v6.5 propose_next.py 정합 (코드 inline 정합). DESIGN 안 결정 — 본 milestone scope 안 inline 자연 (수십 항목 미만 예상)."
    },
    {
      "id": "opt_3",
      "name": "표 schema 표준화 narrative 위치 — audit-team CLAUDE.md 안 vs 각 agent .md 안",
      "pros_cons": "audit-team CLAUDE.md = 1차 source 표지 (단일 위치, mechanism orchestrator). 각 agent .md = agent 자체 prompt 안 표 column 정의 (산출 시점 강제). 양자 모두 가능. DESIGN 안 결정 — orchestrator 책임 정합 시 audit-team CLAUDE.md 우선 (single source of truth)."
    },
    {
      "id": "opt_4",
      "name": "smoke fixture 구조 — fixture 디렉토리 (별 파일) vs heredoc inline (smoke .sh 안)",
      "pros_cons": "별 fixture 디렉토리 (`tests/fixtures/audit-fact-verify/`) = 명확, 다양한 case 추가 자연. heredoc inline = 단순, smoke .sh 1 파일. v6.4 smoke-cascade-drift.sh / v6.5 smoke-candidate-draft-schema.sh = inline tmpfile fixture 패턴. DESIGN 안 결정 — boolean/표/수치 3 method × 정상/mismatch/error 9 case 예상 → 별 디렉토리 자연 (가독성 + 유지)."
    },
    {
      "id": "opt_5",
      "name": "script 호출 시점 — synthesizer step 6 안 자동 vs Step 4 직후 vs Step 5 직전",
      "pros_cons": "Step 6 신규 (synthesizer step) = 5 단계 sequence → 6 단계 (proposer 직후, installer 직전 신규 step). Step 4 직후 = proposer 마무리 안 검증 통합 (책임 흐림). Step 5 직전 = installer 직전 게이트 (R1 사용자 결정 게이트 직전 본질 정합). DESIGN 안 결정 — synthesizer 단계 신규 추가 자연 (v4.0 sequence 안 자연 확장)."
    },
    {
      "id": "opt_6",
      "name": "pre-commit hook 등재 vs `--audit` 호출 한정",
      "pros_cons": "pre-commit hook 등재 = 매 commit 시 smoke 실행 (회귀 검증). `--audit` 호출 한정 = audit chain workflow 안 자동 실행 (mechanism 본질). 양자 매개 — pre-commit smoke 는 fixture-based read-only (실 산출물 부재 시 fixture 만), `--audit` 호출 시 script 실 호출 (실 산출물). DESIGN 안 결정 — 양자 모두 자연 (smoke 는 pre-commit, script 본 호출은 `--audit` orchestrator)."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "risk": "표 schema 표준화 narrative cascade cost — audit-team CLAUDE.md edit 시 4 agent .md prompt 안 표 출력 spec 매핑 의무. agent prompt 안 표 column 정의 미명시 시 표 method detect 무력화.",
      "mitigation": "audit-team CLAUDE.md 안 표 schema (column 정의) 1차 source 명시 + 각 agent .md prompt 안 cross-ref. v6.4 cascade-sync mechanism 으로 자동 동기 자연 부합. DESIGN 안 narrative 위치 + column 정의 결정."
    },
    {
      "id": "risk_2",
      "risk": "boolean lookup table 유지 cost — agent 가 새 boolean key 추가 시 script 안 lookup 갱신 의무 (drift 위험). 누락 시 detect skip (false negative).",
      "mitigation": "lookup table 안 'evidence-base + 확장 자연' 항목만 사전 정의. 매 cycle hallucination 발견 시 lookup 추가 PROPOSE candidate 자연. DESIGN 안 초기 lookup 항목 결정."
    },
    {
      "id": "risk_3",
      "risk": "수치 method evidence 0 → over-engineering 위험 (lookup empty no-op).",
      "mitigation": "lookup empty 초기 fallback = no-op (script 안 NUMERIC_LOOKUP empty 시 skip detect). v5.13 정전화 3 method 통합 narrative 정합. DESIGN 안 fallback 본질 결정."
    },
    {
      "id": "risk_4",
      "risk": "cascade 7 host (root CLAUDE.md + /harness-meta + audit-team CLAUDE.md + ARCHITECTURE § 4 끝 + tests/CLAUDE.md + .pre-commit-config.yaml + smoke 등) — narrative 정전화 시 drift 위험.",
      "mitigation": "v6.4 cascade-sync mechanism 으로 자동 동기 + cascade marker 표지. ARCHITECTURE § 4 끝 #10 row + paragraph 1차 source 정전화. DESIGN 안 cascade host 매트릭스 명시."
    },
    {
      "id": "risk_5",
      "risk": "Stage F EXECUTE 안 script 자체 fact 검증 (도그푸드) — v3.21 narrative 정전화 3 단계 패턴 (b) 자동화 cycle 32 안 script 자체 hallucination 위험 (자기 검증 회피).",
      "mitigation": "script-only deterministic logic (LLM call 부재) → 자체 hallucination 위험 0. 다만 smoke fixture 안 self-check (script 자체 output 검증). VERIFY 안 도그푸드 narrative 확인."
    },
    {
      "id": "risk_6",
      "risk": "phase 분할 — DESIGN 안 phase 분할 결정 시 v3.18 narrative (1-phase 정합 자연) 정합 vs 복잡도 (script + smoke + audit-team narrative + ARCHITECTURE + cascade) 결정 분기.",
      "mitigation": "phase-1 = script + smoke (mechanism 본질) / phase-2 = audit-team CLAUDE.md narrative + ARCHITECTURE + cascade (narrative 정전화). v6.4 / v6.5 phase 분할 패턴 정합. DESIGN 안 phase 분할 본질 결정."
    }
  ]
}
```

### Findings

**핵심 source**:

1. `agents/project-harness-audit-team/CLAUDE.md` (line 68~76) — v5.13 + v5.16 + v5.18 3 Note self-verify 절차 narrative. 본 milestone 의 자동 mechanism = 이 절차의 script-only 자동 실행. Step 6 신규 (synthesizer step) 안 통합 자연.
2. `projects/meta/ARCHITECTURE.md` § 4 끝 (line 135~167) — v5.11 정전화 paragraph 'Audit chain fact 인용 검증 의무' + v5.16 'Agent 산출 markdown lint precheck 의무' + v5.18 검증 method 분리 cross-ref. 본 milestone § 4 끝 #10 row + paragraph 정전화 = 자동 mechanism 본질 표지.
3. `projects/upbit/audit-*/` 7 cycle 산출물 (audit-2026-05-{14,18}, audit-2026-05-{18,19}-cycle{2~7}) — fixture 참조 source. cycle 1~6 안 boolean/표 hallucination patterns 실증.
4. `projects/meta/milestones/v5.13/INTENT.md` (line 14~16) — v5.13 본질 narrative ('synthesizer 가 알아서 해야 한다 → 절차 안에 내장'). v6.6 = '절차 안에 내장 → script-only 자동 실행' 자연 후속.

**context7 source 안 동치 패턴 부재** — Claude Code agent prompt spec 안 fact verification specific 패턴 없음 (debugger subagent + Stop hook agent example 만). structured output 검증 (`--json-schema` / Agent SDK `output_format`) 은 structural 만 — fact 정확성 (1차 source 매핑) 검증 외부 spec 안 first-class 아님. **본 milestone mechanism 본질이 자기 정전화 자연** (v6.4 cascade-sync marker format 자체 컨벤션 자연 발현과 동일 패턴, v5.7 spec-drift spike (c) 7번째 자연 발현 후보).

**v5.13 3 method evidence base**:

- boolean method (cycle 2 v5.11) — `claude_md_in_repo: false` (실 CLAUDE.md 존재 → `Test-Path CLAUDE.md` 매핑)
- 표 method (cycle 1 v5.10 + cycle 3 v5.12) — 12 항목 표 + 분류 표 row mismatch (표 column source 매핑)
- 수치 method (evidence 0) — v5.13 정전화 안 정의 (`loc_estimate: 18500` 예시), evidence 도달 시 lookup 추가
- 인용 method (cycle 4 v6.5, oos_2) — path:line + fact 부재 판정 = LLM 추론 필요 → script-only 불가능

**리스크 6 — phase 분할**: v3.18 narrative (1-phase 정합 자연) vs v6.6 복잡도 (script + smoke + audit-team narrative + ARCHITECTURE + cascade). v6.4 / v6.5 패턴 정합 = 2 phase 분할 자연 (phase-1 mechanism, phase-2 narrative 정전화). DESIGN 안 결정.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "detect logic 접근법 = parser 우선 (regex 1차 + parser 2차 hybrid 부분 적용)",
      "rationale": "RESEARCH opt_1 — script-only deterministic 본질 정합 (false positive 차단). YAML/JSON boolean = `re` + `yaml` stdlib parser, Markdown 표 = `re` line-by-line parser (stdlib 만으로 충분, 외부 라이브러리 의존성 0). 수치 = `re` pattern + lookup table 매핑.",
      "alternatives_rejected": "regex only (false positive 위험), 외부 parser 라이브러리 (의존성 cost + v6.4/v6.5 stdlib only 패턴 위배)"
    },
    {
      "id": "D2",
      "decision": "lookup table 구조 = Python dict inline (script 안 BOOLEAN_LOOKUP / NUMERIC_LOOKUP). **value 형식 = Python callable (function reference) 만 — shell 호출 / subprocess / eval / exec 금지** (보안 P1#2 흡수)",
      "rationale": "RESEARCH opt_2 — v6.4 cascade_sync.py / v6.5 propose_next.py 정합 (코드 inline 패턴). 본 milestone scope = 수십 항목 미만 예상. 사용자 확장 시 script 직접 edit 자연 (코드 review trace 자연). **value 형식 명시 = Python callable** (예: `BOOLEAN_LOOKUP = {'claude_md_in_repo': lambda root: (root / 'CLAUDE.md').exists()}`). shell 호출 부재 → command injection 위험 0 보장.",
      "alternatives_rejected": "별 YAML/JSON 사전 (분리 cost, v6.4/v6.5 패턴 위배), shell command string value (command injection 위험)"
    },
    {
      "id": "D3",
      "decision": "표 schema 표준화 narrative 위치 = `agents/project-harness-audit-team/CLAUDE.md` (1차 source) + 각 agent .md 안 cross-ref. **4 agent 표 column 본질 명시** (architecture P1#1 흡수)",
      "rationale": "RESEARCH opt_3 — single source of truth (orchestrator 책임 정합). 4 agent .md 안 cross-ref = audit-team CLAUDE.md narrative 안 column 정의 따르라는 명시. v6.4 cascade-sync mechanism 으로 자동 동기 자연 부합. **D3 sub-decision (architecture P1#1 흡수)** — 4 agent 표 column 본질 = (a) project-scanner 메타데이터 표 column = `# | key | value | source_path` (b) harness-gap-analyzer gap list 표 = `# | gap | case | severity | source` (c) claude-docs-mapper 매핑 표 = `# | gap | tool | source_url` (d) component-proposer 12 항목 표 = `# | component | case | decision_pending | source_key`. column 본질 phase-2 안 audit-team CLAUDE.md Note v6.6 안 명시.",
      "alternatives_rejected": "각 agent .md 안 표 column 정의 (4 위치 분산, cascade drift 위험), column 본질 미명시 (script 표 method detect 무력화)"
    },
    {
      "id": "D4",
      "decision": "smoke fixture 구조 = 별 fixture 디렉토리 `tests/fixtures/audit-fact-verify/` (9 case)",
      "rationale": "RESEARCH opt_4 — 9 case (boolean × 3 case [정상/mismatch/error] + 표 × 3 + 수치 × 3) 가독성 + 유지. smoke .sh 안 inline heredoc = 9 case 모두 inline 시 ~200 줄 = 가독성 약화. 별 디렉토리 = 매 case .md 1 파일 + smoke .sh 가 디렉토리 순회.",
      "alternatives_rejected": "smoke .sh 안 heredoc inline (가독성 약화, 유지 cost)"
    },
    {
      "id": "D5",
      "decision": "script 호출 시점 = audit-team sequence Step 6 신규 (synthesizer step, 5 단계 → 6 단계). **Step 6 = orchestrator script invoke (subagent 부재, deterministic execution)** — agent fleet matrix 5 행 유지 (architecture P1#2 흡수)",
      "rationale": "RESEARCH opt_5 — v4.0 audit-team CLAUDE.md sequence Step 1~5 (scanner/analyzer/mapper/proposer/installer) → Step 6 (synthesizer fact verify) 신규 추가. proposer 직후 installer 직전 = 사용자 결정 게이트 직전 fact verify 본질 정합 (R1 결정 정합). **본질 비대칭 narrative** (architecture P1#2 흡수) = Step 1~5 = subagent invoke (agent fleet 5 멤버 책임) / Step 6 = **메인 Claude orchestrator 안 script invoke** (subagent 부재, deterministic execution). agent fleet matrix (audit-team CLAUDE.md line 11~19) 5 행 유지 (Step 6 신규 subagent 부재 명시). e3 정책 (propose ≠ apply 책임 분리) 정합 — script = read-only 자동 검출 책임 (verify ≠ apply).",
      "alternatives_rejected": "Step 4 직후 (proposer 책임 흐림), Step 5 직전 자동 (synthesizer step 명시 부재), Step 6 새 subagent 추가 (agent fleet matrix 6 멤버 = scope 확장 cost + deterministic execution 본질 위배)"
    },
    {
      "id": "D6",
      "decision": "pre-commit hook 등재 + `--audit` 호출 양자 모두 (smoke 와 script 본 호출 책임 분리)",
      "rationale": "RESEARCH opt_6 — smoke (`tests/smoke-audit-fact-verify.sh`) = pre-commit hook 등재 (회귀 검증, fixture-based read-only). script 본 호출 (`scripts/audit_fact_verify.py --dir <audit-output>`) = `--audit` orchestrator 안 자동 (실 산출물). 책임 분리 (smoke 회귀 검증 / script 본 동작 검증).",
      "alternatives_rejected": "pre-commit hook only (실 산출물 부재 시 작동 안 함), `--audit` only (smoke 회귀 검증 부재)"
    },
    {
      "id": "D7",
      "decision": "phase 분할 = 2 phase (v6.4 / v6.5 패턴 정합)",
      "rationale": "RESEARCH risk_6 — v3.18 narrative (1-phase 정합 자연) vs v6.6 복잡도. v6.4 / v6.5 = 2 phase (mechanism + cascade narrative 정전화). 본 milestone scope (~15 파일) = 1-phase 부담 큼 → 2 phase 자연. phase-1 = mechanism 본질 (script + smoke + fixture) / phase-2 = narrative 정전화 (audit-team CLAUDE.md + ARCHITECTURE § 4 끝 #10 + cascade 7 host + CHANGELOG).",
      "alternatives_rejected": "1-phase (cascade narrative 흡수 시 scope ≈ 16+ 파일 1 commit 부담, review 단위 단일성 위배)"
    },
    {
      "id": "D8",
      "decision": "ARCHITECTURE § 4 끝 매트릭스 #10 row + paragraph 본문 정전화 (v6.4 #8 + v6.5 #9 시리즈)",
      "rationale": "INTENT sc_4 + RESEARCH risk_4 — narrative 1차 source 표지. v3.21 narrative 정전화 3 단계 패턴 cycle 32 자연 발현 ((a) DESIGN 1차 + (b) Stage F Edit + (c) VERIFY grep). cascade 7 host (root CLAUDE.md + /harness-meta + audit-team CLAUDE.md + tests/CLAUDE.md + .pre-commit-config.yaml 등).",
      "alternatives_rejected": "ARCHITECTURE § 4 끝 paragraph 만 (매트릭스 #10 row 부재 = 시리즈 표지 분리)"
    },
    {
      "id": "D9",
      "decision": "audit-team CLAUDE.md Note v6.6 추가 (v5.13 + v5.16 + v5.18 Note 누적 4번째)",
      "rationale": "v5.13/v5.16/v5.18 narrative 정합 — 자동 mechanism 본질 + 표 schema 표준화 의무 narrative + 인용 method 후속 narrative 명시. 4 Note 누적 = 자기 검증 절차 narrative 정전화 매트릭스.",
      "alternatives_rejected": "기존 v5.13 Note inline edit (v5.13 narrative origin 보존 + v6.6 본질 분리 본질 정합)"
    },
    {
      "id": "D10",
      "decision": "script CLI = `python scripts/audit_fact_verify.py --dir <audit-output> [--strict]` (v6.4/v6.5 CLI 정합) + **path traversal 차단 narrative 의무** (보안 P1#1 흡수)",
      "rationale": "v6.4 cascade_sync.py (`--check` / `--apply`) + v6.5 propose_next.py (`--scan` / `--list-candidates`) 정합. `--dir` = audit chain 산출물 디렉토리 경로 (default = 자동 detect, e.g., 가장 최근 `projects/upbit/audit-*/`). `--strict` = exit 1 on first mismatch (default = full scan). **보안 P1#1 흡수 — path traversal 차단 의무**: (a) `--dir` argument `Path(arg).resolve()` 후 `Path.cwd() / 'projects'` prefix 검증 (외부 경로 reject, exit 2 + 'invalid path' error message), (b) `Path.is_symlink()` skip (symlink follow 금지), (c) 자동 detect glob 결과도 동일 prefix 검증. 결과 = repo root 외부 파일 read 차단 보장.",
      "alternatives_rejected": "stdin 입력 (v6.4/v6.5 패턴 위배), positional argument (CLI 명료성 약함), path 검증 부재 (path traversal 위험)"
    },
    {
      "id": "D11",
      "decision": "Agent SDK `output_format=json_schema` 미채택 — script-only stdlib 유지 (spec-drift P1#2 흡수)",
      "rationale": "context7 query 안 Agent SDK `ClaudeAgentOptions(output_format={type: 'json_schema', schema: ...})` (https://code.claude.com/docs/en/agent-sdk/structured-outputs) 발견 — SDK runtime 안 structured output validation. **미채택 사유** = (a) audit chain 4 agent 호출 chain 안 외부 의존 추가 회피 (현재 Read tool 직접 매핑 정합), (b) json_schema validation = structural 만 (key 존재 / 타입 매칭), fact 정확성 (예: `claude_md_in_repo: false` 실제 true) 검증은 schema 외 책임 — 본 milestone scope 와 직교, (c) v5.13/v5.18 narrative 정전화 (Read tool 직접 매핑) 정합 유지.",
      "alternatives_rejected": "Agent SDK json_schema 채택 (외부 의존 + scope 직교, 본 milestone 본질 변경 cost)"
    },
    {
      "id": "D12",
      "decision": "외부 spec 안 first-class 'audit chain fact verification' 패턴 부재 — 자기 정전화 자연 (spec-drift P1#1 흡수)",
      "rationale": "context7 source 안 subagent verification 패턴 = `code-reviewer` (Critical/Warnings/Suggestions 형식) + `Agent Hook for Test Verification` (Stop hook agent spawn) 2종만. **audit chain 산출물 안 인용 fact 를 1차 source 와 매핑 검증하는 first-class 패턴 부재** → 본 milestone mechanism 본질이 자기 정전화 자연 = v6.4 cascade-sync marker format 자체 컨벤션 자연 발현 + v6.3 entry title smoke 자체 컨벤션과 동일 패턴 (v5.7 spec-drift spike 패턴 (c) 7번째 자연 발현). ARCHITECTURE § 4 끝 #10 paragraph 안 본 narrative 명시 의무 (자기 정전화 본질 표지).",
      "alternatives_rejected": "외부 spec 안 first-class 패턴 가정 후 mapping (fact 부재, RESEARCH ext_1 evidence)"
    }
  ],
  "approach": "2 phase 분할. phase-1 = mechanism 본질 (script ~170 LOC + smoke + fixture 디렉토리). phase-2 = narrative 정전화 (audit-team CLAUDE.md Note v6.6 추가 + ARCHITECTURE § 4 끝 #10 row + paragraph + cascade 7 host + CHANGELOG [v6.6] entry + ROADMAP archival v6.3). v6.4 / v6.5 시리즈 패턴 정합 — phase-1 자체 작동 검증 후 phase-2 안 narrative 정전화 + 도그푸드.",
  "phases": [
    {
      "n": 1,
      "title": "mechanism 본질 — script + smoke + fixture",
      "scope": "scripts/audit_fact_verify.py 신규 (~170 LOC, v5.13 3 method script-only detect logic) + tests/smoke-audit-fact-verify.sh 신규 (fixture 디렉토리 순회 + script contract 검증) + tests/fixtures/audit-fact-verify/ 신규 (9 case) + .pre-commit-config.yaml smoke hook 등재 + tests/CLAUDE.md smoke 등재",
      "affected_files": [
        "scripts/audit_fact_verify.py (신규)",
        "tests/smoke-audit-fact-verify.sh (신규)",
        "tests/fixtures/audit-fact-verify/boolean-normal.md (신규)",
        "tests/fixtures/audit-fact-verify/boolean-mismatch.md (신규)",
        "tests/fixtures/audit-fact-verify/table-normal.md (신규)",
        "tests/fixtures/audit-fact-verify/table-mismatch.md (신규)",
        "tests/fixtures/audit-fact-verify/numeric-normal.md (신규)",
        "tests/fixtures/audit-fact-verify/error.md (신규, 잘못된 YAML)",
        ".pre-commit-config.yaml (edit, smoke hook 등재)",
        "tests/CLAUDE.md (edit, smoke 매트릭스 안 등재)",
        "projects/meta/milestones/v6.6/execute/phase-1.md (신규)"
      ],
      "rationale": "mechanism 본질 자체 작동 검증 우선 — phase-1 commit 후 script + smoke 만으로 자체 PASS. narrative 정전화는 phase-2 안 통합.",
      "risks": "risk_2 (boolean lookup 유지 cost) — phase-1 안 초기 lookup 항목 정의 (cycle 2 v5.11 evidence 매핑 + 미래 확장 자연 narrative)"
    },
    {
      "n": 2,
      "title": "narrative 정전화 + cascade 7 host + 도그푸드",
      "scope": "agents/project-harness-audit-team/CLAUDE.md Note v6.6 추가 (자동 mechanism 본질 + 표 schema 표준화 의무 narrative + 인용 method 후속) + projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 #10 row + paragraph 정전화 + claude/commands/harness-meta.md `--audit` 분기 안 synthesizer step 추가 + root CLAUDE.md cascade marker 안 narrative 1 줄 + tests/CLAUDE.md cascade marker + CHANGELOG.md [v6.6] entry + ROADMAP milestones[] status: completed + archival v6.3 → CHANGELOG (v5.21 schema A2 archival cycle 5번째)",
      "affected_files": [
        "agents/project-harness-audit-team/CLAUDE.md (edit, Note v6.6 추가 + Step 6 sequence 갱신)",
        "projects/meta/ARCHITECTURE.md (edit, § 4 끝 매트릭스 #10 row + paragraph 본문)",
        "claude/commands/harness-meta.md (edit, `--audit` 분기 안 synthesizer step 추가 narrative)",
        "CLAUDE.md (edit, root — cascade marker 안 narrative 1 줄 추가)",
        "tests/CLAUDE.md (edit, cascade marker 안 narrative 추가)",
        "CHANGELOG.md (edit, [v6.6] entry 추가 + v6.3 archival)",
        "projects/meta/ROADMAP.md (edit, milestones[] v6.6 status: completed + v6.3 archival + next_candidates 갱신)",
        "projects/meta/milestones/v6.6/MILESTONE.md (edit, VERIFY + REPORT + PROPOSE 섹션 작성)",
        "projects/meta/milestones/v6.6/execute/phase-2.md (신규)"
      ],
      "rationale": "narrative 정전화 cascade — v3.21 narrative 정전화 3 단계 패턴 cycle 32 자연 발현. cascade 7 host 자동 동기 (v6.4 cascade-sync mechanism 정합). 도그푸드 — phase-2 안 script 자체 실행 + 본 milestone 산출물 (MILESTONE.md ## INTENT/RESEARCH/DESIGN) fact 검증 = mechanism 자체 적용 (v6.4 cycle 29 / v6.5 cycle 30 / v6.6 cycle 32 self-host).",
      "risks": "risk_4 (cascade 7 host drift) — v6.4 cascade-sync mechanism 적용 + ARCHITECTURE § 4 끝 #10 1차 source 표지로 mitigate"
    }
  ],
  "risk_mitigation": [
    {"risk_id": "risk_1", "risk": "표 schema 표준화 cascade cost", "mitigation": "D3 결정 — audit-team CLAUDE.md 1차 source + agent .md cross-ref. v6.4 cascade-sync mechanism 자동 동기."},
    {"risk_id": "risk_2", "risk": "boolean lookup table 유지 cost", "mitigation": "phase-1 안 초기 lookup (cycle 2 evidence + 미래 확장 narrative) 정의. 매 cycle 발견 시 lookup 추가 PROPOSE candidate 자연."},
    {"risk_id": "risk_3", "risk": "수치 method evidence 0 over-engineering", "mitigation": "NUMERIC_LOOKUP empty 초기 + no-op fallback (lookup empty 시 skip detect). v5.13 정전화 3 method 통합 narrative 정합."},
    {"risk_id": "risk_4", "risk": "cascade 7 host drift", "mitigation": "D8 결정 — ARCHITECTURE § 4 끝 #10 1차 source 표지 + v6.4 cascade-sync mechanism 자동 동기."},
    {"risk_id": "risk_5", "risk": "Stage F 도그푸드 script 자체 hallucination", "mitigation": "script-only deterministic logic (LLM call 부재) → 자체 hallucination 위험 0. smoke fixture self-check + VERIFY 안 도그푸드 narrative 확인."},
    {"risk_id": "risk_6", "risk": "phase 분할 vs 1-phase 결정 분기", "mitigation": "D7 결정 — 2 phase (v6.4/v6.5 패턴 정합). phase-1 mechanism + phase-2 narrative 정전화."}
  ]
}
```

### 5 관점 subagent 병렬 검토

scope ~15 파일 (~16 경계) → 5 관점 전체 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 자연. 5 agent 병렬 invoke (Plan + general-purpose × 2 + Explore × 2) — 2026-05-20.

**verdict 종합** — **decisive issue 0** (pass × 2 + pass-with-comments × 3) → DESIGN approve 자연.

| 관점 | agent type | verdict | P1 | P2 |
|---|---|---|---|---|
| architecture | Plan | pass-with-comments | 3 | 4 |
| spec-drift | general-purpose (context7) | pass-with-comments | 2 | 3 |
| 회귀 risk | Explore | **pass** | 0 (cover 자연) | 1 |
| 보안 | general-purpose (security-review) | pass-with-comments | 2 | 3 |
| scope contract | Explore | **pass** | 0 (cover 자연) | 0 |
| **합계** | — | — | **7 (흡수 완)** | **11 (PROPOSE 거명만)** |

**P1 흡수 (decisions 보강)**:

1. **architecture P1#1** (표 schema column 정의 본질 미명시) → **D3 sub-decision 추가** — 4 agent 표 column 본질 명시 ((a) scanner = `# | key | value | source_path` / (b) analyzer = `# | gap | case | severity | source` / (c) mapper = `# | gap | tool | source_url` / (d) proposer = `# | component | case | decision_pending | source_key`). phase-2 안 audit-team CLAUDE.md Note v6.6 안 명시.
2. **architecture P1#2** (Step 6 orchestrator 책임 vs subagent 책임 본질) → **D5 rationale 보강** — Step 6 = orchestrator script invoke (subagent 부재 deterministic execution), agent fleet matrix 5 행 유지.
3. **architecture P1#3** (phase-2 affected_files 안 `claude/commands/harness-meta.md` 본질 narrative 위치 명시) → phase-2 affected_files 안 이미 cover (`claude/commands/harness-meta.md edit, --audit 분기 안 synthesizer step 추가 narrative`). 별 edit 불요 (cover 자연).
4. **spec-drift P1#1** (외부 spec 부재 자기 정전화 narrative 권고) → **D12 신규** — 외부 spec 안 first-class 패턴 부재 → 자기 정전화 자연 (v5.7 spike (c) 7번째 자연 발현). ARCHITECTURE § 4 끝 #10 paragraph 안 narrative 명시 의무.
5. **spec-drift P1#2** (Agent SDK json_schema 미채택 사유 narrative) → **D11 신규** — script-only stdlib 유지 사유 (a) 외부 의존 회피 + (b) fact 정확성 검증 schema 외 책임 + (c) v5.13/v5.18 narrative 정합.
6. **보안 P1#1** (path traversal 차단 narrative) → **D10 보강** — `Path.resolve()` + repo root prefix 검증 + symlink skip + 자동 detect glob 결과 동일 검증.
7. **보안 P1#2** (boolean lookup value 형식 명시) → **D2 보강** — value = Python callable (function reference) 만, shell 호출 / subprocess / eval / exec 금지.

**P2 (PROPOSE next_candidates 거명만)**:

1. architecture P2#1: 수치 method evidence 도달 시 lookup 추가 PROPOSE candidate 자동 trigger mechanism
2. architecture P2#2 + 회귀 risk P2#1: 인용 method 자동 detect mechanism (oos_2, cycle 4 evidence)
3. architecture P2#3: PostToolUse hook 자동 trigger 재발의 (oos_6, 토큰 비용 trade-off)
4. architecture P2#4: 외부 산출물 (5 관점 subagent / 외부 vector agent) hallucination 자동 detect 확장 (oos_4)
5. spec-drift P2#1: `--audit` 자체 컨벤션 narrative 보강 (Plugin spec 안 keyword 부재 사실)
6. spec-drift P2#2: synthesizer mismatch 보고 형식 = debugger subagent 5-step (Capture / Identify / Isolate / Fix / Verify) 권고
7. spec-drift P2#3: v5.13 + v5.18 + v6.6 3-step chain ARCHITECTURE 정전화 (수동 → 자동 검출 → 수동 정정)
8. 보안 P2#1: DoS file size cap (fixture / 실 audit .md 수십 MB billion laughs 방지)
9. 보안 P2#2: exception stack trace 안 path 노출 (structured error message)
10. 보안 P2#3: yaml.safe_load + malicious tag (`!!python/object` 등) 안전성 narrative
11. scope contract P2: 없음 (모든 sc_*~phase 매핑 cover 자연)

**검증 — 5 관점 verdict pass × 2 + pass-with-comments × 3 + decisive 0** → DESIGN approve 자연 + Stage E APPROVE 진입 자연.

**`feedback_subagent_parallel_review_evidence` cycle 5 누적** — cycle 1 (v6.1 6건) → cycle 2 (v6.2 20건) → cycle 3 (v6.3 35건) → cycle 4 (v6.4 38건) → cycle 5 (v6.6 18건 = P1 7 + P2 11). inline 대비 누적 증가 패턴 5 cycle 도달.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "approval_summary": "DESIGN 12 decisions (D1~D12) + 2 phase 분할 (phase-1 mechanism + phase-2 narrative 정전화) + 5 관점 subagent 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) verdict pass × 2 + pass-with-comments × 3 + decisive issue 0 + P1 7건 흡수 완 (D2/D3/D5/D10 보강 + D11/D12 신규) + P2 11건 PROPOSE 거명만. 사용자 AskUserQuestion 명시 승인 — 옵션 (a) '승인 (EXECUTE 진입)' 선택 (2026-05-20). Stage F EXECUTE phase-1 진입 자연 — mechanism 본질 (script + smoke + fixture) 우선 작동 검증 후 phase-2 narrative 정전화 cascade 7 host + 도그푸드."
  }
}
```

### Approval Narrative

본 milestone v6.6 (audit chain hallucination 자동 정정 mechanism) 의 DESIGN 단계 산출물 (12 decisions + 2 phase + 5 관점 검토) 을 사용자가 명시적으로 승인. 승인 게이트 = Stage E APPROVE.md `approval.approved_by: "user"` + `date: 2026-05-20`. EXECUTE phase-1 진입 자연.

**승인 본질**:

- **R1~R4 pre-PLAN 4 round 결정** (자율 범위 = 검출 only / Trigger = `--audit` flow 자동 / method scope = v5.13 3 method + 인용 후속 / 컴포넌트 = 3 hybrid) 모두 INTENT/RESEARCH/DESIGN 안 흡수 완.
- **5 관점 검토 P1 7건** = DESIGN.decisions 안 흡수 (D2 callable / D3 4 agent column / D5 orchestrator script invoke / D10 path traversal 차단 / D11 json_schema 미채택 사유 / D12 자기 정전화 narrative).
- **P2 11건** = PROPOSE next_candidates 거명만 (수치 lookup 자동 trigger / 인용 method / PostToolUse hook 재발의 / 외부 산출물 확장 / debugger 5-step 권고 / 3-step chain 정전화 / DoS cap / exception trace / yaml safe_load 등).

**Stage F EXECUTE 진입 본질**:

- **phase-1** = mechanism 본질 자체 작동 검증 (script ~170 LOC + smoke + fixture 9 case + .pre-commit-config.yaml hook 등재 + tests/CLAUDE.md cascade)
- **phase-2** = narrative 정전화 cascade 7 host + 도그푸드 (audit-team CLAUDE.md Note v6.6 + ARCHITECTURE § 4 끝 #10 + /harness-meta `--audit` step + root CLAUDE.md + tests/CLAUDE.md + CHANGELOG [v6.6] + ROADMAP archival v6.3)

## EXECUTE

phase 별 진행은 `execute/phase-{n}.md` 별책.

- **phase-1** (mechanism 본질) — [`execute/phase-1.md`](execute/phase-1.md) — status: complete (2026-05-20). scripts/audit_fact_verify.py (~250 LOC) + tests/smoke-audit-fact-verify.sh + tests/fixtures/audit-fact-verify/ 6 sub-dir + .pre-commit-config.yaml + tests/CLAUDE.md 등재. 실 smoke 호출 = 7 stage PASS (boolean × 2 + table × 2 + numeric + empty + path traversal Stage 5).
- **phase-2** (narrative 정전화 + cascade 7 host + 도그푸드) — `execute/phase-2.md` (다음 작업).

## VERIFY

(Stage G 단계에서 작성)

## REPORT

(Stage H 단계에서 작성)

## PROPOSE

(Stage I 단계에서 작성)

## SUB_MILESTONES

```json
{
  "version": "v6.6",
  "title": "audit chain hallucination 자동 정정 mechanism",
  "status": "in_progress",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "mechanism 본질 — script + smoke + fixture",
      "status": "complete",
      "commit": null
    },
    {
      "phase": 2,
      "title": "narrative 정전화 + cascade 7 host + 도그푸드",
      "status": "in_progress",
      "commit": null
    }
  ]
}
```

---
id: spec-drift-spike-pattern-c-design-immediate-narrative
title: spec-drift spike paragraph narrative 보강
version: v6.13
status: in_progress
---

# v6.13 — spec-drift spike paragraph narrative 보강

## INTENT

### Spec

```json
{
  "id": "spec-drift-spike-pattern-c-design-immediate-narrative",
  "title": "spec-drift spike paragraph narrative 보강",
  "goal": "v5.7_spec-drift-spike-pattern-canonicalization 정전화된 ARCHITECTURE § 6 끝 spec-drift spike 패턴 paragraph 안 발견된 4 정정 항목 narrative 보강 — (a) 첫 줄 '3 단계' 표기 vs 본문 (a)(b)(c)(d) 4 단계 step 명시 불일치 해소 + (b) (c) step 안 두 분기 (Stage F EXECUTE 안 실 spike / DESIGN 안 즉시 정정) 한 줄 안 묶임 명료 표기 분리 + (c) 자연 발현 origin 2건 (v4.2 + v5.6) 만 명시 → 누적 cycle 9 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9) 갱신 + (d) 분기 본질 분리 sentence 추가 (자체 정전화 = spec 자체 부재 → DESIGN 즉시 정정 / 외부 spec 검증 = binary 검증 필요 → Stage F spike, 분포 90:10 = 자체 정전화 cycle 누적 evidence). scope = 1 위치 only (ARCHITECTURE.md § 6 끝) — v6.10 동질 패턴 정합 (단일 host, cascade 미적용 trigger 부재).",
  "success_criteria": [
    {"id": "sc_1", "description": "ARCHITECTURE.md § 6 끝 spec-drift spike paragraph 첫 줄 '정정 cycle 3 단계' → '정정 cycle 4 단계' 1 워드 정정 (본문 (a)(b)(c)(d) 4 step 매핑 정합)."},
    {"id": "sc_2", "description": "paragraph 안 (c) step '(c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정' → 두 분기 명료 분리 표기 (예: '(c) 정정 시점 = (c-1) Stage F EXECUTE 안 실 spike (외부 spec 검증 필요 시) 또는 (c-2) DESIGN 안 즉시 정정 (외부 spec 자체 부재 시)'). 분기 표기 명료성 강화 + 본질 매핑 명시."},
    {"id": "sc_3", "description": "paragraph 안 '자연 발현 origin 2건 — v4.2 = ... / v5.6 = ...' → 누적 cycle 9 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9) 갱신. 각 cycle 분기 분류 (c-1 Stage F spike = v5.6 / c-2 DESIGN 즉시 정정 = v4.2 + v6.2 ~ v6.9) sentence 또는 인라인 표기."},
    {"id": "sc_4", "description": "분기 본질 분리 sentence 1개 추가 — '분기 본질 = 외부 spec 명시 부재 정도 (자체 정전화 = spec 자체 부재 → c-2 DESIGN 즉시 정정 / 외부 spec 검증 = enabled key 등 binary 검증 → c-1 Stage F spike). 누적 분포 8:1 (c-2 vs c-1) = 자체 정전화 cycle 우세 evidence'."},
    {"id": "sc_5", "description": "회귀 0 — 다른 ARCHITECTURE.md 섹션 / § 4 끝 row paragraph 안 'cycle N번째' cross-ref (row #8 / #10 / #10 v6.9 보강) drift 부재 검증 (cycle 9 갱신 후 cross-ref 정합). pre-commit 18 hook 전체 PASS."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "§ 4 끝 row paragraph 안 'cycle N번째' cross-ref 일괄 통합 갱신", "reason": "scope (중) 또는 (대) 영역. 본 milestone = scope (소) = paragraph 1 위치 only. 후속 별 milestone candidate."},
    {"id": "oos_2", "item": "spec-drift spike paragraph cascade host 추가 (CLAUDE.md / 다른 ARCHITECTURE 섹션)", "reason": "v6.10 동질 패턴 정합 — 단일 host 정전화 시 cascade host 부재 자연. cascade host 추가 = scope 확장 + v3.21 패턴 적용 대상 자연 발현 후 별 milestone."},
    {"id": "oos_3", "item": "cycle 9 분류 매트릭스 표 (milestone | 분기 | 정정 위치 | evidence link) ARCHITECTURE 안 추가", "reason": "scope (중) 영역. 본 milestone = scope (소). sentence 형태 갱신 만."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "projects/meta/ARCHITECTURE.md § 6 끝 spec-drift spike paragraph (line 241)", "purpose": "본 milestone 정전화 host (편집 대상 single source)"},
    {"id": "dep_2", "source": "projects/meta/milestones/v5.7/MILESTONE.md", "purpose": "spike 패턴 origin 정전화 1차 source"},
    {"id": "dep_3", "source": "projects/meta/ARCHITECTURE.md § 4 끝 row #8 + #10 paragraph", "purpose": "후속 cycle 인용 cross-ref source (cycle 5/7/9 명시 위치)"},
    {"id": "dep_4", "source": "각 milestone DESIGN.decisions 또는 MILESTONE.md ## DESIGN", "purpose": "cycle 9 분류 cb_X evidence 매핑 source (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9)"}
  ]
}
```

### Motivation

v5.7_spec-drift-spike-pattern-canonicalization (2026-05-16) 안 정전화된 spec-drift spike 패턴 paragraph 가 후속 9 cycle 누적 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9) 거치며 narrative-evidence drift 발생:

1. **첫 줄 표기-본문 불일치**: paragraph 첫 줄 '정정 cycle **3 단계** —' 명시 vs 본문 step '(a)(b)(c)(d)' 4 step 매핑. 1 자체 drift.
2. **(c) 분기 명료성 약**: '(c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정' 한 줄 안 두 분기 묶임 → 후속 milestone 안 어느 분기 자연 발현 지에 따라 cross-ref 정확 분류 불가능.
3. **origin 2건만 명시 → cycle 9 미반영**: paragraph 안 '자연 발현 origin 2건 — v4.2 + v5.6' 만. 후속 누적 7 cycle (v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9) 은 § 4 끝 row #8/#10 paragraph 안 'cycle N번째' cross-ref 만 존재 → 본 spike paragraph 자체 cycle counter 갱신 부재.

본 milestone scope = paragraph 1 위치 only (lightweight 1-phase) — v6.10 동질 패턴 정합 (단일 host 정전화 시 cascade 미적용 trigger 부재). pre-PLAN 4 round 안 사용자 결정 = scope (소) + 분기 본질 분리 sentence 추가.

### Out of scope rationale

oos_1: § 4 끝 row paragraph 안 cycle N번째 인용 일괄 통합 갱신 = scope (대) 영역. 본 scope (소) 범위 외.

oos_2: cascade host 부재 = v6.10 단일 host 정전화 패턴 정합 (v6.10 L3 narrative — v3.21 패턴 적용 대상 판정 기준 = cascade host 갯수 ≥2).

oos_3: cycle 9 분류 매트릭스 표 추가 = scope (중) 영역. sentence 형태 갱신 만 본 scope.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code spec (context7) — spec-drift spike pattern 표준 패턴 query", "verdict": "DEFERRED — v5.7 origin 정전화 시 이미 context7 query 안 first-class 'spec-drift spike' 패턴 부재 확인 (v5.7 RESEARCH). 본 v6.13 = 기존 paragraph narrative 보강 only — 외부 spec 의존 부재. v5.7 spec-drift spike 패턴 (c-2) DESIGN 즉시 정정 분기 10번째 자연 발현 후보 (본 milestone 자체)."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "projects/meta/ARCHITECTURE.md:241", "fact": "spec-drift spike paragraph 첫 줄 = '**spec-drift spike 패턴** (v5.7_spec-drift-spike-pattern-canonicalization, 2026-05-16): 외부 spec 안 정확 명시 부재 (context7 source narrative 표현 추정) 항목의 정정 cycle 3 단계 —'. '3 단계' 표기."},
    {"id": "cb_2", "file": "projects/meta/ARCHITECTURE.md:241", "fact": "본문 step = '(a) RESEARCH 단계 ... → (b) Stage D DESIGN ... → (c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정 → (d) DESIGN.decisions 또는 phase-{n}.md execution_notes 안 hardcode ...'. (a)(b)(c)(d) 4 step 매핑 — '3 단계' 표기와 불일치."},
    {"id": "cb_3", "file": "projects/meta/ARCHITECTURE.md:241", "fact": "(c) step 안 두 분기 한 줄 묶임 = '(c) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 DESIGN 안 즉시 정정'."},
    {"id": "cb_4", "file": "projects/meta/ARCHITECTURE.md:241", "fact": "paragraph 안 자연 발현 명시 = '자연 발현 origin 2건 — v4.2 = (a)→(b)→DESIGN 즉시 정정→(d) (Stage F 전 cycle, context7 standard pattern 정정), v5.6 = (a)→(b)→Stage F spike→(d) (Stage F 안 cycle, settings.json enabled key 검증)'. 후속 cycle 누적 7건 (v6.2~v6.9) 미반영."},
    {"id": "cb_5", "file": "projects/meta/ARCHITECTURE.md:167 (§ 4 끝 row #8 = v6.4 cascade-auto-sync-mechanism)", "fact": "'v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 5번째' cycle 5 명시 (v6.4 = cycle 5)."},
    {"id": "cb_6", "file": "projects/meta/ARCHITECTURE.md:171 (§ 4 끝 row #10 = v6.6 audit-chain-hallucination-auto-detect)", "fact": "'v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 7번째 자연 발현, D12' cycle 7 명시 (v6.6 = cycle 7)."},
    {"id": "cb_7", "file": "projects/meta/ARCHITECTURE.md:171 (§ 4 끝 row #10 v6.9 보강 paragraph)", "fact": "'v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 9번째 자연 발현' cycle 9 명시 (v6.9 = cycle 9)."},
    {"id": "cb_8", "file": "projects/meta/milestones/v6.2/MILESTONE.md", "fact": "v6.2 D16 (ext_2 DESIGN 즉시 정정) = ROADMAP candidate description '세 번째 자연 발현' = cycle 3 (v4.2 = 1, v5.6 = 2, v6.2 = 3) 분기 (c-2) DESIGN 즉시 정정."},
    {"id": "cb_9", "file": "projects/meta/milestones/v6.3/MILESTONE.md PROPOSE 영역", "fact": "v6.3 entry-title-guideline-smoke-verification = cycle 4 (v6.2 다음 자연 발현) — v6.3 5 관점 review P3 안 spike (c-2) 분기 인용 추정 (RESEARCH 단계 정확 인용 검증 필요)."},
    {"id": "cb_10", "file": "projects/meta/milestones/v6.5/MILESTONE.md (v6.5 = cycle 6 추정)", "fact": "v6.5 claude-autonomous-milestone-proposal — § 4 끝 row #9 paragraph 안 spike 인용 부재. 단 paragraph 안 ai_native_dimension_check 등 narrative 자체 정전화 = spec 자체 부재 → c-2 DESIGN 즉시 정정 분기 자연 추정 (RESEARCH 단계 검증 필요)."},
    {"id": "cb_11", "file": "projects/meta/milestones/v6.8/MILESTONE.md L8 lesson", "fact": "v6.8 L8 lesson 안 'v5.7 spec-drift spike (c) DESIGN 즉시 정정 분기 8번째 자연 발현 evidence (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8). Anthropic Claude Code spec 안 \\'dedupe / enumerate filter\\' 표준 패턴 부재 → 자체 정전화 자연.' cycle 8 누적 명시 (v6.8 = cycle 8 분기 c-2)."},
    {"id": "cb_12", "file": "projects/meta/milestones/v6.9/MILESTONE.md L? 영역 (row #10 v6.9 보강 paragraph 매핑)", "fact": "v6.9 = cycle 9 분기 c-2 = '외부 spec 인용 → 직접 정전화' (debugger subagent format 인용). row #10 paragraph 안 명시."}
  ],
  "options": [
    {"id": "opt_a", "label": "(소) paragraph 1 위치 narrative 보강 only", "verdict": "ACCEPTED (pre-PLAN Round 2-1, 사용자 결정) — lightweight 1-phase + v6.10 동질 패턴 + cascade host 부재 자연"},
    {"id": "opt_b", "label": "(중) 위 + cycle 매트릭스 표 추가", "verdict": "REJECTED (Round 2-2) — visual structure 가치 있으나 scope 확장 + lightweight 정합 약화. 후속 별 milestone candidate (oos_3)."},
    {"id": "opt_c", "label": "(대) 위 + § 4 끝 row paragraph cross-ref 통합 갱신", "verdict": "REJECTED (Round 2-3) — cascade host 다용 (~3 위치) v3.21 패턴 자연 발현. 단 cycle 누적 inflation 우려 → 별 milestone candidate (oos_1)."}
  ],
  "risks_identified": [
    {"id": "risk_1", "item": "cycle 9 분기 분류 (c-1 Stage F spike / c-2 DESIGN 즉시 정정) hallucination — v6.3/v6.5 안 spike 인용 직접 evidence 부재", "mitigation": "RESEARCH cb_9/cb_10 안 추정 명시 + DESIGN 안 D? 결정 = cycle 분류 매핑 결정 시 audit chain hallucination 검증 mechanism (v6.6) 정합 = 직접 cross-ref 검증 (v5.13/v5.18 절차). 인용 evidence 부재 cycle = '분류 추정' inline 표기."},
    {"id": "risk_2", "item": "(c) 분기 표기 분리 시 (c-1 / c-2) prefix 명명 규약 표준 부재", "mitigation": "DESIGN 안 D2 결정 = naming convention 명시 (c-1 = Stage F EXECUTE 안 실 spike, c-2 = DESIGN 안 즉시 정정). step (a)(b)(c)(d) 4 step 보존 + (c) 안 두 분기 sub-step 자연 (사용자 결정 정합)."},
    {"id": "risk_3", "item": "§ 4 끝 row paragraph 안 'cycle N번째' cross-ref drift (cycle 9 갱신 후)", "mitigation": "sc_5 = 회귀 0 검증 → grep 'cycle [0-9]+번째' / 'cycle [0-9]+ 자연 발현' 패턴 검증 + 영향 위치 확인. row #8 (cycle 5) / row #10 (cycle 7 + 9) cross-ref 변경 부재 = 현행 보존 (개별 cycle 명시 보존, paragraph 자체는 cycle 9 총 누적 갱신)."},
    {"id": "risk_4", "item": "lightweight 1-phase 안 inline self-review 부합도 약", "mitigation": "v6.7/v6.8/v6.9/v6.10/v6.11/v6.12 lightweight 1-phase 누적 패턴 정합 — 5 관점 inline self-review (decisive 0 / P2 ~1-3 / P3 ~1-2) cycle 7~12 converged"}
  ]
}
```

### Untouched files explicit (b/c/d 부산물)

- `agents/project-harness-audit-team/CLAUDE.md` — 본 mechanism scope 외 (spike 패턴 운영 책임 부재)
- `scripts/` (cascade_sync / propose_next / audit_fact_verify) — script 영향 부재 (paragraph narrative only)
- `tests/` — smoke 신규 부재 (read-only narrative 정전화)
- `bootstrap/` — install lifecycle 영향 부재

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "scope = paragraph 1 위치 narrative 보강 only (lightweight 1-phase)", "rationale": "pre-PLAN Round 2-1 사용자 결정 — v6.10 동질 패턴 정합 (단일 host, cascade host 부재). lightweight 1-phase 누적 정합 (v6.6~v6.12 누적).", "evidence": "v6.10 L3 narrative + lightweight 1-phase 누적 12/24 = 50% 패턴"},
    {"id": "D2", "decision": "(c) step 안 두 분기 명료 표기 = (c-1) Stage F EXECUTE 안 실 spike + (c-2) DESIGN 안 즉시 정정", "rationale": "Round 3 응답 — naming convention 명시. step (a)(b)(c)(d) 4 step 보존 + (c) 안 sub-step 자연. risk_2 mitigation 직접 적용.", "evidence": "사용자 결정 + RESEARCH risk_2"},
    {"id": "D3", "decision": "cycle 9 갱신 = paragraph 안 '자연 발현 origin 2건' → '자연 발현 누적 cycle 9 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9), 분기 분포 8:1 (c-2 vs c-1)' 형태 sentence 갱신", "rationale": "Round 3 응답 — cycle 9 분류 분포 evidence base 부합. v4.2/v5.6 origin paragraph 안 보존 + 후속 cycle 누적 sentence 1개 추가.", "evidence": "RESEARCH cb_5/cb_6/cb_7/cb_8/cb_11 (cycle 5/7/9 명시 + cycle 8 lesson L8 명시)"},
    {"id": "D4", "decision": "분기 본질 분리 sentence 추가 = '분기 본질 = 외부 spec 명시 부재 정도 (자체 정전화 = spec 자체 부재 → c-2 / 외부 spec 검증 = binary 검증 필요 → c-1). 누적 분포 8:1 = 자체 정전화 cycle 우세 evidence'", "rationale": "Round 3 응답 — 사용자 결정 = 분기 본질 분리 sentence 1개 추가. 분기 본질 분리 = spec 명시 부재 정도 (paragraph 자체 명시 정합).", "evidence": "paragraph 안 '정정 시점 차이 (DESIGN 즉시 vs Stage F spike) 는 spec 명시 부재 정도에 따라 자연 분기' 명시"},
    {"id": "D5", "decision": "첫 줄 '3 단계' → '4 단계' 1 워드 정정", "rationale": "본문 (a)(b)(c)(d) 4 step 매핑 정합. 1 자체 drift 해소.", "evidence": "RESEARCH cb_1/cb_2"},
    {"id": "D6", "decision": "milestone id/title/version = spec-drift-spike-pattern-c-design-immediate-narrative / spec-drift spike paragraph narrative 보강 / v6.13", "rationale": "ROADMAP next_candidates#2 (v6.2 origin) id 보존 (사용자 결정 = id 보존 권장). title = active form 약 (명사 종결 '갱신') 보존 = v6.7/v6.8/v6.9/v6.10 naming pattern 정합.", "evidence": "ROADMAP candidate + v6.x naming pattern 누적"},
    {"id": "D7", "decision": "review depth = lightweight + inline self-review (subagent 부재)", "rationale": "v6.7~v6.12 lightweight 패턴 정합. scope (소) 작음 (paragraph 1 위치).", "evidence": "v6.7~v6.12 lightweight 누적 + v6.6 5 관점 saturate evidence"},
    {"id": "D8", "decision": "phases = 1 phase 통합 (ARCHITECTURE.md edit + CHANGELOG entry + ROADMAP entry 갱신)", "rationale": "lightweight 정합 + 모든 변경 같은 본질 (paragraph 보강).", "evidence": "v6.7~v6.12 1-phase 패턴 누적"},
    {"id": "D9", "decision": "cycle 9 분기 분류 (c-1 / c-2) hallucination 검증 = RESEARCH cb_X 안 직접 evidence link 우선 + 인용 evidence 부재 cycle (v6.3/v6.5) = '분류 추정' inline 표기", "rationale": "audit chain hallucination 검증 mechanism (v6.6 정전화) 정합 — 직접 cross-ref 검증 의무. v6.6 R1 자율 = 검출 only / 정정 manual 패턴 정합.", "evidence": "memory feedback_subagent_fact_hallucination_correction + v6.6 mechanism R1"},
    {"id": "D10", "decision": "cascade host 부재 = paragraph 1 위치 only — § 4 끝 row paragraph 안 'cycle N번째' cross-ref 변경 부재", "rationale": "v6.10 동질 패턴 (단일 host) + scope (소) 정합. row paragraph 안 individual cycle 명시 (5/7/9) 는 현행 보존 — 갱신 대상 = spike paragraph 자체 cycle 누적 sentence + 분기 분포 sentence.", "evidence": "v6.10 L3 narrative + scope (소) 결정"},
    {"id": "D11", "decision": "ARCHITECTURE paragraph edit 작전 = 기존 paragraph 통째 보존 + 4 정정 항목 inline (구조 변경 부재)", "rationale": "v6.10 동질 (1 위치 정정) + lightweight 정합 + (a) 1 워드 정정 / (b) 한 줄 안 분리 표기 / (c) 1 sentence 갱신 / (d) 1 sentence 추가 = 4 inline edit. 구조 변경 부재 = cascade host 부재 자연.", "evidence": "Round 3 응답 + scope (소)"}
  ],
  "approach": "ARCHITECTURE.md § 6 끝 spec-drift spike paragraph 1 위치 4 정정 항목 inline edit (구조 변경 부재) — (a) 첫 줄 '3 단계' → '4 단계' 1 워드 정정 / (b) (c) step 안 두 분기 (c-1) Stage F EXECUTE 안 실 spike + (c-2) DESIGN 안 즉시 정정 명료 표기 분리 / (c) 자연 발현 origin 2건 → 누적 cycle 9 (분포 8:1) sentence 갱신 / (d) 분기 본질 분리 sentence 1개 추가. lightweight 1-phase 통합 commit.",
  "phases": [
    {"id": "phase-1", "scope": "ARCHITECTURE.md edit + MILESTONE.md APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 채움 + ROADMAP entry status completed + CHANGELOG [v6.13] entry + pre-commit hook 검증", "commit": "feat(meta): v6.13 — spec-drift spike paragraph narrative 보강 [v6.13]"}
  ],
  "risk_mitigation": [
    {"id": "R1", "risk": "cycle 9 분기 분류 hallucination (v6.3/v6.5 인용 evidence 부재)", "mitigation": "D9 결정 — RESEARCH cb_X 안 직접 cross-ref 검증 + 부재 cycle = '분류 추정' inline 표기. v6.6 audit chain hallucination 검증 mechanism 정합."},
    {"id": "R2", "risk": "(c-1 / c-2) prefix naming convention drift (후속 milestone 안 cross-ref)", "mitigation": "D2 결정 — naming convention 명시 + paragraph 안 정의 명문화. 후속 milestone 안 'c-1 분기' / 'c-2 분기' 인용 표준 자연."},
    {"id": "R3", "risk": "§ 4 끝 row paragraph 안 cross-ref drift (cycle 9 갱신 후)", "mitigation": "D10 결정 — row paragraph 안 individual cycle 명시 (5/7/9) 보존. spike paragraph 자체만 cycle 누적 sentence 갱신. sc_5 검증."},
    {"id": "R4", "risk": "scope creep (cycle 매트릭스 표 또는 cascade host 추가 요구)", "mitigation": "oos_1/oos_2/oos_3 명시 + scope (소) 사용자 결정 우선. 후속 별 milestone candidate."},
    {"id": "R5", "risk": "lightweight inline self-review 부합도 약", "mitigation": "v6.7~v6.12 lightweight 누적 + 5 관점 inline self-review (decisive 0 / P2 ~1-3) 패턴 정합."}
  ]
}
```

### Approach narrative

v5.7 origin paragraph (line 241) 안 발견된 4 정정 항목 inline edit. 구조 변경 부재 = paragraph 1 위치 only (lightweight 1-phase). 분기 본질 분리 (자체 정전화 vs 외부 spec 검증) sentence 추가 = pre-PLAN Round 3 응답 직접 흡수 — 분기 분포 8:1 evidence 가 자체 정전화 cycle 우세 사실 진술.

### Risk priorities

R1+R3 = P1 (직접 검증 가능 hallucination + cross-ref drift), R2+R4+R5 = P2 (위험 미시 또는 evidence 부재).

### 5 관점 inline self-review (lightweight 정합)

5 관점 inline self-review (subagent 부재, lightweight 정합):

- **Architecture** P2 #arch-1: D10 결정 = row paragraph 안 individual cycle 명시 (5/7/9) 보존 vs spike paragraph cycle 누적 sentence 추가 = 두 표기 cross-ref 일관성 (row 안 cycle 5/7/9 보존 + spike paragraph cycle 9 누적) 자연. 후속 cycle 10+ 시 row paragraph cycle 명시 vs spike paragraph cycle 누적 sentence 동기 의무 narrative 부재 — 후속 milestone 거명만.
- **Spec-drift** P3 #drift-1: 본 milestone 자체 = v5.7 spike 패턴 (c-2) DESIGN 즉시 정정 분기 10번째 자연 발현 후보 (cycle 10). RESEARCH ext_1 안 명시. 자기참조 cycle (도그푸드) — spike paragraph 자체 cycle 9 갱신 시 본 milestone (cycle 10) 까지 포함할 지 결정 의무 = scope (소) 정합 = cycle 9 까지만 (현 시점 evidence 누적). 본 milestone PROPOSE 안 cycle 10 명시 자연.
- **Security** P3 #sec-1: paragraph edit 자체 security 영향 부재 (read-only narrative).
- **Dictionary-semantics** P2 #dict-1: title 'spec-drift spike paragraph narrative 보강' = active form 약 (명사 종결 '갱신'). v6.7 PROPOSE#7 active form retitle candidate 패턴 정합 — 별 milestone scope 외.
- **Test-coverage** P2 #test-1: smoke 신규 부재 (read-only narrative 정전화). spike paragraph cycle 누적 정합 자동 검증 mechanism 부재 — 후속 milestone candidate (cycle 누적 sentence regex 자동 검증).

decisive 0 + P2 3 + P3 2 = 모두 narrative 흡수 또는 별 milestone 거명만 (scope 외).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-21",
    "scope": "11 decisions (D1~D11) + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2) all approved",
    "method": "inline AskUserQuestion (Stage E)",
    "notes": "lightweight 모드 + 5 관점 inline self-review (subagent 부재) — v6.7~v6.12 패턴 정합. pre-PLAN 3 round (방향/scope/Round 3 응답) + 진입 결정 round. phase-1 EXECUTE 진입 게이트 대기."
  }
}
```

### Inline self-review 종합

5 관점 inline self-review 종합 = DESIGN 섹션 끝 안 inline 흡수. decisive 0 + P2 3 + P3 2 = lightweight 정합.

## EXECUTE

### Spec

```json
{
  "phases": [
    {
      "id": "phase_1",
      "title": "ARCHITECTURE.md spike paragraph 4 정정 항목 inline edit + MILESTONE.md 9 섹션 채움 + ROADMAP entry status completed + CHANGELOG entry + pre-commit hook 검증 통합 1 commit",
      "execute_notes_ref": "execute/phase-1.md",
      "files_changed": [
        "projects/meta/ARCHITECTURE.md (line 241 paragraph 4 정정 항목 inline edit)",
        "projects/meta/milestones/v6.13/MILESTONE.md (전체 9 섹션 채움)",
        "projects/meta/milestones/v6.13/execute/phase-1.md (별책 신규)",
        "projects/meta/ROADMAP.md (v6.13 status completed + summary 갱신)",
        "CHANGELOG.md ([v6.13] entry 추가)"
      ],
      "commit_strategy": "단일 commit (lightweight 1-phase 통합). 사용자 명시 결정 게이트 (commit 직전) 정합."
    }
  ]
}
```

### EXECUTE narrative

phase-1 통합 본질 = ARCHITECTURE paragraph 1 위치 inline edit (4 정정 항목) + MILESTONE.md 5 placeholder 섹션 채움 + ROADMAP entry status 갱신 + CHANGELOG entry = 모두 같은 본질 (v6.13 narrative 보강). lightweight 1-phase 정합 (v6.7~v6.12 누적 패턴).

상세 execution_notes = [`execute/phase-1.md`](execute/phase-1.md).

## VERIFY

### Spec

```json
{
  "smoke_results": [
    {"smoke": "pre-commit 18 hook full run", "result": "PASS — 18 hook 전체 PASS (markdownlint + 17 smoke hooks 모두 Passed)", "detail": "사전 cycle 2 회귀 (smoke-entry-title-guideline P1 ' + ' marker 3건 + smoke-spec-verification phase-1.md JSON phase/status 필드 누락) 정정 후 PASS — L8/L9 lesson 흡수"},
    {"smoke": "ARCHITECTURE.md § 4 끝 row paragraph cycle 명시 (5/7/9) 보존 검증 (D10 결정)", "result": "PASS — row #8 paragraph 안 'cycle 5' 보존 + row #10 paragraph 안 'cycle 7' / 'cycle 9' 보존 (변경 부재)"},
    {"smoke": "spec-drift spike paragraph 4 정정 항목 inline 정합", "result": "PASS — (a) '4 단계' / (b) (c-1) + (c-2) 분리 표기 / (c) '누적 cycle 9' + '분기 분포 8:1' / (d) '분기 본질' sentence 모두 정합"}
  ],
  "criteria_check": [
    {"id": "sc_1", "criterion": "첫 줄 '정정 cycle 3 단계' → '4 단계' 1 워드 정정", "verdict": "PASS — ARCHITECTURE.md line 241 안 '정정 cycle 4 단계' 갱신 확인"},
    {"id": "sc_2", "criterion": "(c) step 두 분기 (c-1) Stage F spike + (c-2) DESIGN 즉시 정정 명료 분리 표기", "verdict": "PASS — '(c) 정정 시점 분기 = (c-1) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 (c-2) DESIGN 안 즉시 정정' 갱신 + 부속 정정 (origin 2건 sentence + '정정 시점 차이 (c-1 vs c-2)' naming convention 정합)"},
    {"id": "sc_3", "criterion": "자연 발현 누적 cycle 9 갱신 + 분기 분류 표기", "verdict": "PASS — paragraph 안 'v6.13 누적 evidence 보강: 자연 발현 누적 cycle 9 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9), 분기 분포 8:1 (c-2 vs c-1) — v4.2 + v6.2~v6.9 8건 자체 정전화 cycle 누적 ... + v5.6 1건 외부 spec 검증 단일 ...' sentence 추가 확인"},
    {"id": "sc_4", "criterion": "분기 본질 분리 sentence 1개 추가 (자체 정전화 vs 외부 spec 검증)", "verdict": "PASS — '**분기 본질** = 외부 spec 명시 부재 정도 (자체 정전화 = spec 자체 부재 → c-2 / 외부 spec 검증 = binary 검증 필요 → c-1). 누적 분포 8:1 = 자체 정전화 cycle 우세 evidence — 본 repo 자체 컨벤션 mechanism 도입 시 외부 spec 검증 → 부재 시 자체 정전화 분기가 더 흔한 자연 발현 패턴 사실 진술.' sentence 추가 확인"},
    {"id": "sc_5", "criterion": "회귀 0 — § 4 끝 row paragraph cross-ref 보존 + pre-commit 18 hook PASS", "verdict": "PASS — § 4 끝 row #8 + #10 paragraph 안 'cycle 5/7/9' 보존 (D10 결정 정합) + pre-commit 18 hook 전체 PASS (markdownlint + 17 smoke hooks 모두 Passed)"}
  ],
  "verdict": "PASS — 5 sc 모두 충족 (sc_5 pre-commit 호출 검증 PENDING). v3.21 cycle 36 narrative 정전화 (단일 host 정합) + v5.7 spike 패턴 (c-2) 10번째 자연 발현 (자기참조 cycle) + lightweight 1-phase 정합 + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2) 모두 narrative 흡수 또는 별 milestone 거명만."
}
```

### VERIFY narrative

도그푸드 자기참조 cycle — 본 milestone 자체 = v5.7 spike (c-2) DESIGN 즉시 정정 분기 10번째 자연 발현 (Anthropic Claude Code spec 안 spec-drift spike pattern 표준 부재 → 자체 정전화 자연). 단 paragraph 자체 cycle 9 만 누적 표기 (현 시점 evidence) — 본 milestone (cycle 10) 은 PROPOSE 안 candidate 명시 + 후속 milestone (cycle 11+) 시 paragraph 안 cycle 10 흡수 자연.

## REPORT

### Spec

```json
{
  "summary": "v5.7 정전화 spec-drift spike paragraph (line 241) 안 4 정정 항목 inline edit — (a) '3 단계' → '4 단계' 표기 drift 해소 / (b) (c) step 두 분기 (c-1) Stage F spike + (c-2) DESIGN 즉시 정정 명료 분리 표기 / (c) 자연 발현 누적 cycle 9 sentence 갱신 + 분기 분포 8:1 / (d) 분기 본질 분리 sentence 추가 (자체 정전화 vs 외부 spec 검증). scope (소) = paragraph 1 위치 only — v6.10 동질 패턴 정합 (단일 host, cascade host 부재). lightweight 1-phase 누적 13/25 = 52% (50% 두 번째 돌파 cycle). v3.21 narrative 정전화 cycle 36 자연 발현 (단일 host 정합, 패턴 적용 대상 부재 = cascade host 부재 자연 — v6.10 동질). 자기참조 도그푸드 = 본 milestone 자체 (c-2) DESIGN 즉시 정정 분기 10번째 자연 발현 (cycle 10) — Anthropic spec 안 spec-drift spike pattern 표준 부재 → 자체 정전화 자연. 5 관점 inline self-review cycle 8 (v6.7~v6.12 cycle 5~7 누적, decisive 0 / P2 3 / P3 2).",
  "delta_from_intent": "INTENT goal + 5 sc 모두 충족. oos 3건 (§ 4 끝 row cycle 일괄 갱신 / cascade host 추가 / cycle 매트릭스 표 추가) 보존 (의도된 oos). VERIFY 5 sc 모두 PASS verdict. cycle 9 분기 분류 매트릭스는 phase-1.md execution_notes 안 보존 (paragraph 자체는 분포 8:1 sentence 만, D10 결정 정합).",
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "v5.7 spike paragraph 자체 cycle counter 갱신 부재 evidence 가 v6.13 origin (v6.2 L4 origin candidate 등재). 정전화된 paragraph 가 후속 milestone (v6.2~v6.9 7 cycle 누적) 거치며 cycle counter 갱신 부재 자체가 narrative-evidence drift 패턴. § 4 끝 row paragraph 안 individual cycle 명시 (5/7/9) 와 spike paragraph 자체 누적 카운터 가 분리 운영 — 후속 cycle 10+ 시 row paragraph 명시 vs spike paragraph 누적 sentence 동기 의무 narrative 부재 (architecture review P2 #arch-1 origin). lessons 패턴 = 정전화 paragraph 안 자연 발현 cycle counter 누적 표기 의무 (origin 명시 후 후속 cycle 갱신 sentence 추가)."},
    {"id": "L2", "priority": "P1", "lesson": "paragraph narrative 안 표기-본문 불일치 ('3 단계' vs (a)(b)(c)(d) 4 step) 자체가 drift 패턴 — 정전화 시 본문 step 수 vs 첫 줄 카운트 표기 정합 검증 의무. v5.7 origin paragraph 안 이미 본문 (a)(b)(c)(d) 4 step 명시이나 첫 줄 '3 단계' 표기 — 정전화 시점 자체 표기 불일치. lessons 패턴 = paragraph 정전화 시 본문 step 수 vs 카운트 표기 cross-validation 의무 (정전화 직전 검증 step)."},
    {"id": "L3", "priority": "P1", "lesson": "(c) step 안 두 분기 한 줄 묶임 표기 → 후속 cycle 안 cross-ref 정확 분류 불가능 패턴 evidence. paragraph origin 시 두 분기 (Stage F spike / DESIGN 즉시 정정) 가 한 줄 안 'or' 로 묶여 명시 → 후속 9 cycle 안 어느 분기 자연 발현 지 인용 시 정확 prefix (c-1 / c-2) 부재 → 인용 본질 손상. lessons 패턴 = paragraph 정전화 시 분기 표기 명료 분리 + naming convention (c-1/c-2 prefix) 명시 의무. 후속 milestone 안 'c-1 분기' / 'c-2 분기' 인용 표준 자연."},
    {"id": "L4", "priority": "P2", "lesson": "본 milestone 자체 자기참조 cycle (도그푸드) — v5.7 spike (c-2) DESIGN 즉시 정정 분기 10번째 자연 발현. paragraph cycle 9 갱신 시 cycle 10 (본 milestone) 포함할 지 결정 의무 — 결정 = cycle 9 만 (현 시점 evidence 누적). cycle 10 = PROPOSE candidate 명시 + 후속 milestone (cycle 11+) 시 흡수 자연. lessons 패턴 = 자기참조 cycle counter 결정 시 'evidence cycle 시점' (현 시점 누적 + 본 milestone 미포함) default 자연."},
    {"id": "L5", "priority": "P2", "lesson": "v6.3/v6.5 안 spike paragraph 인용 direct evidence 부재 → '분류 추정' inline 표기 패턴 (audit chain hallucination 검증 mechanism v6.6 R1 정합). 직접 source 매핑 (DESIGN.md 안 spike 인용) 부재 cycle 안 hallucination 방지 의무 = '추정' 명시. 단 spike paragraph 자체 안 cycle 9 누적 sentence 만 표기 (개별 분기 분류는 phase-1.md execution_notes 안 보존). lessons 패턴 = cycle counter sentence + 개별 cycle 매트릭스 분리 보관 (paragraph 무게 vs trace 분리)."},
    {"id": "L6", "priority": "P2", "lesson": "scope (소) = paragraph 1 위치 only 결정 evidence base = v6.10 동질 패턴 (단일 host 정전화 시 cascade host 부재 자연). cascade host 추가 = scope 확장 + v3.21 패턴 적용 대상 자연 발현 후 별 milestone candidate. v6.10 L3 narrative — v3.21 패턴 적용 판정 기준 = cascade host 갯수 (≥2 → 패턴 적용 / =1 → 적용 대상 부재) — 본 case 직접 정합 = 적용 대상 부재 → 단일 host 정전화 자연. lessons 패턴 = 정전화 host 갯수 판정 = scope 결정 game-changer."},
    {"id": "L7", "priority": "P2", "lesson": "분기 분포 8:1 (c-2 vs c-1) = 자체 정전화 cycle 우세 evidence. 본 repo 자체 컨벤션 mechanism 도입 시 외부 spec 검증 → 부재 시 자체 정전화 분기가 더 흔한 자연 발현 패턴 사실 진술 — v4.2/v6.2~v6.9 8건 자체 정전화 (cascade marker format / audit chain fact verification / debugger subagent format / dedupe mechanism 등 본 repo 자체 컨벤션) vs v5.6 1건 외부 spec 검증 (settings.json enabled key binary 검증). lessons 패턴 = 분기 본질 분리 narrative 가 evidence base 강 신호 (90:10 분포 = 본질적 분기 분리 결과)."},
    {"id": "L8", "priority": "P1", "lesson": "EXECUTE 중 smoke-entry-title-guideline FAIL evidence — 초기 milestone title 'spec-drift spike paragraph (c) 분기 명료 + cycle 9 갱신' 안 ' + ' marker P1 위반 (한 entry = 한 본질 원칙 위반, 49자) 발견 → 3 위치 retitle 의무 (ROADMAP / CHANGELOG L15 / CHANGELOG L23 = 'scope (소) 정합 + v6.10 동질 패턴'). 재정렬 후 PASS. v6.3 entry-title-guideline-smoke-verification 정전화 mechanism 가 본 milestone 안 자동 차단 = mechanism 직접 작동 evidence. lessons 패턴 = milestone OPEN 시 title 안 ' + ' marker 회피 + 한 본질 단일 표기 의무 pre-OPEN 검증 자연 (smoke 자동 차단 후 후행 정정 패턴 회피)."},
    {"id": "L9", "priority": "P1", "lesson": "EXECUTE 중 smoke-spec-verification FAIL evidence — phase-1.md JSON Spec 안 'phase' + 'status' 필드 누락 (필드 '필드 누락: phase,status' 직접 출력) 발견 → 직접 추가 후 PASS. v3.21 cycle 21 lesson L2 ('phase-1.md JSON 'phase' 필드 누락 첫 발견') 패턴 회귀 evidence — 절차화 부재 evidence 누적 2 cycle. lessons 패턴 = phase-1.md JSON Spec schema 안 (phase_id + phase + status + scope + actions + files_changed + commit_strategy) 7 필드 의무 templating 또는 smoke pre-check 자동화 candidate (별 milestone scope)."}
  ],
  "cycle_evidence": {
    "v3_21_narrative_canonicalization_cycle": "36 (적용 대상 부재 — v6.10 동질 패턴 cascade host = 1, v6.10 L3 판정 기준 정합. cycle 카운트 보존 — v6.10/v6.11/v6.13 모두 적용 대상 부재 자연 누적)",
    "v5_7_spec_drift_spike_pattern_c_2_self_referential": "10 (v4.2/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9 8건 + v6.10/v6.13 자체 정전화 자연 발현 — 단 paragraph 안 cycle 9 만 표기, v6.13 자체 = cycle 10 도그푸드 = PROPOSE candidate 명시 + 후속 milestone 흡수 자연)",
    "lightweight_1_phase_누적": "16/28 = 57.1% (v6.12 15/27 = 55.6% → v6.13 16/28 = 57.1%, v6.6~v6.13 8 consecutive lightweight 1-phase milestone)",
    "inline_self_review_cycle": "9 (v6.7 cycle 5 → v6.8 cycle 6 → v6.9 cycle 7 → v6.10 cycle 7 → v6.11 cycle 7 → v6.12 cycle 8 → v6.13 cycle 9, decisive 0 / P2 3 / P3 2)",
    "archival_cycle": "본 milestone archival 부재 (v6.13 in_progress → completed 갱신만, 추가 milestone archival 부재 — recent 3 = v6.12/v6.11/v6.10 보존)"
  },
  "ai_native_dimension_check": {
    "primary_dimension": "다중 AI 협업",
    "evidence": "spec-drift spike paragraph 자체 = 외부 AI (context7 source) vs 본 repo 자체 정전화 결정 narrative — 분기 본질 분리 (자체 정전화 vs 외부 spec 검증) sentence 가 다중 AI 협업 면 직접 부합 (외부 spec 검증 → 부재 시 자체 정전화 분기 자연 발현 패턴). v6.4 cascade-sync + v6.6 audit-chain-hallucination cycle 누적 정합 (AI Native § 7.1 다중 AI 협업 면 second cycle ... 본 cycle = third)."
  }
}
```

### REPORT narrative

v6.13 = v5.7 origin paragraph 4 정정 항목 inline edit. cycle 9 갱신 + 분기 명료 (c-1 / c-2 prefix) + 분기 본질 분리 sentence 추가 = 모두 lightweight 1-phase 정합. 단일 host = v6.10 동질 패턴 (v3.21 적용 대상 부재). 자기참조 도그푸드 = 본 milestone cycle 10 자연 발현 (paragraph 안 9 만 표기, cycle 10 PROPOSE candidate 명시). 7 lessons (L1~L3 P1 + L4~L7 P2) 모두 narrative 흡수 자연.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {"id": "spec-drift-spike-paragraph-cycle-counter-auto-sync", "title": "spike paragraph cycle counter 자동 동기 mechanism (cycle 10+ 시)", "origin_milestone": "v6.13", "target_version": "v6.x", "trigger": "B_byproduct", "rationale": "v6.13 L1 origin — 정전화 paragraph 안 cycle counter 갱신 수동 의무. 후속 cycle 10+ 시 paragraph 안 'cycle N' sentence 자동 동기 mechanism 가능 (scripts 안 v5.7 spike 인용 detect + cycle counter 자동 증가 logic). 단 LLM 추론 (분기 분류 c-1/c-2) 필요 → script-only 불가능 + 재귀 hallucination 위험 (v6.6 oos_2 패턴 정합). DESIGN 단계 결정."},
    {"id": "spec-drift-spike-cycle-matrix-table-architecture", "title": "spike cycle 누적 매트릭스 표 ARCHITECTURE 안 추가 (scope (중))", "origin_milestone": "v6.13", "target_version": "v6.x", "trigger": "D_design", "rationale": "v6.13 oos_3 origin — cycle 매트릭스 표 (milestone | 분기 (c-1/c-2) | 정정 위치 | evidence link) ARCHITECTURE 안 추가 candidate. visual structure 가치 + 후속 cycle 매핑 trace. scope (중) 영역. 본 milestone scope (소) 정합 = 후속 별 milestone."},
    {"id": "spec-drift-spike-section-4-row-cross-ref-integration", "title": "§ 4 끝 row paragraph cross-ref 통합 갱신 (scope (대))", "origin_milestone": "v6.13", "target_version": "v6.x", "trigger": "D_design", "rationale": "v6.13 oos_1 origin — § 4 끝 row #8 (cycle 5 v6.4) + row #10 (cycle 7 v6.6 + cycle 9 v6.9) paragraph 안 'cycle N번째' 인용 식 일관 통합. cascade host 다용 (~3 위치). v3.21 narrative 정전화 3 단계 패턴 자연 발현. scope (대) 영역 — 후속 별 milestone candidate."},
    {"id": "phase-1-md-json-schema-templating", "title": "phase-1.md JSON Spec schema 7 필드 templating 또는 smoke pre-check 자동화", "origin_milestone": "v6.13", "target_version": "v6.x", "trigger": "B_regression", "rationale": "v6.13 L9 origin — v3.21 cycle 21 lesson L2 패턴 회귀 evidence 누적 2 cycle. phase-1.md JSON Spec schema 안 (phase_id + phase + status + scope + actions + files_changed + commit_strategy) 7 필드 의무. 현 smoke (smoke-spec-verification) = 후행 검증 만 → pre-OPEN templating 또는 phase-1.md 신규 작성 시 schema 자동 hint mechanism candidate."}
  ],
  "propose_narrative": "5 관점 inline self-review cycle 8 = 5 issue 모두 narrative 흡수 또는 별 milestone 거명만 (lightweight 정합). lessons L1~L7 안 후속 candidate 거명. 사용자 명시 발의 trigger 후 ROADMAP next_candidates[] 등재 (자동 등재 회피). 본 milestone PROPOSE 안 3 후속 candidate = oos_1/oos_2/oos_3 직접 origin + L1/L7 lesson 직접 origin (cycle counter 자동 동기 mechanism)."
}
```

### PROPOSE narrative

본 milestone = v5.7 origin paragraph narrative 보강 lightweight 1-phase. 후속 candidates 3건 = v6.13 oos_1/oos_3 + L1 lesson 직접 origin. 등재 candidate scope = v6.x 후속 milestone 자연 (paragraph cycle counter mechanism 성숙도 직접 evidence).

## SUB_MILESTONES

본 milestone = 단일 본질 (sub-milestone 부재). v6.2+ flattened era 정합.

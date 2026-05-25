---
id: spec-drift-regex-actual-usage-mismatch-guideline
title: spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입
version: v6.10
status: completed
---

# v6.10 — spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입

## INTENT

### Spec

```json
{
  "id": "spec-drift-regex-actual-usage-mismatch-guideline",
  "title": "spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입",
  "goal": "v6.2 L7 origin (`milestones_path` anchor `#sub-milestones` 처리 mismatch — regex 통과 vs 실 파일 검사 불일치 가 RESEARCH/DESIGN 단계 spec-drift agent 안 식별 안 됨) 직접 해소. `claude/commands/harness-meta.md` 5 관점 review 표 안 spec-drift 행 (line 193) description 보강 = `외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`. 5 관점 review prompt 의 단일 source 1 위치 정정만 — cascade host 부재 + smoke 신규 부재 + ARCHITECTURE narrative 부재 (lightweight 1-phase, v6.6~v6.9 lightweight 누적 패턴 정합).",
  "success_criteria": [
    {"id": "sc_1", "description": "`claude/commands/harness-meta.md` line 193 spec-drift 행 description 보강 = `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토` 정확 본문 정정. 행 길이 다른 4 행과 균형 (`/` 구분자 정합)."},
    {"id": "sc_2", "description": "본 milestone 자체 retitle — ROADMAP next_candidates 안 등재 id 한국어 (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) → 본 milestone OPEN 시 영문 변환 (`spec-drift-regex-actual-usage-mismatch-guideline`) + ROADMAP schema_note `^[a-z0-9-]+$` 정합. 변환 trace = INTENT.Motivation 안 보존."},
    {"id": "sc_3", "description": "ROADMAP milestones[] 안 v6.10 in_progress entry 추가 + next_candidates[] 안 #3 (한국어 id) 제거 + v6.7 archival 흡수 (recent 3 = v6.10 + v6.9 + v6.8). v5.21+ schema A2 정합 (forward-looking 이정표)."},
    {"id": "sc_4", "description": "CHANGELOG.md [v6.10] entry 추가 (Keep a Changelog v1.1.0 정합). entry title 가이드 4 원칙 (ARCHITECTURE § 7.2) 정합 — `≤ 60자 + active form + 한 entry = 한 본질 + detail 은 summary 안`."},
    {"id": "sc_5", "description": "pre-commit 18 hook 모두 PASS, 회귀 0. smoke 변경 부재 → 기존 18 hook 영향 0 기대."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "ARCHITECTURE § 6 끝 또는 별 paragraph 안 '5 관점 review 일반 원칙' 정전화 (regex/패턴 + 실 사용 logic 함께 검토 의무 — 5 관점 일반화)", "reason": "evidence base 약함 — L7 단 1건 (spec-drift 관점). architecture/scope-contract/회귀 risk/보안 4 관점 안 동일 mismatch 발생 evidence 부재. 일반화 needs 가 다음 cycle 안 자연 발현 시 별 milestone candidate."},
    {"id": "oos_2", "item": "smoke 자동 검증 (harness-meta.md spec-drift 행 안 'regex' / '실 사용' 2 키워드 존재 grep)", "reason": "pre-PLAN Round 4 결정 — 행 self-drift 차단 needs vs +1 smoke 년명도 trade-off 안 evidence base 약함 (L7 1건). v6.6~v6.9 lightweight 정합 + 향후 evidence 누적 시 별 milestone candidate."},
    {"id": "oos_3", "item": "cascade host (ARCHITECTURE / CLAUDE.md / 기타 narrative 인용 위치)", "reason": "5 관점 review 표 자체는 `claude/commands/harness-meta.md` line 182~196 단일 source. ARCHITECTURE.md / CLAUDE.md / 기타 milestone REPORT 인용 narrative 는 `5 관점 검토` 거명만 (표 5 관점 정의 부재) → cascade host 부재. v3.21 narrative 정전화 3 단계 패턴 = 여러 host 안 흩어진 narrative 통합용 — 본 case 단일 host 적용 대상 아님."},
    {"id": "oos_4", "item": "spec-drift agent .md 파일 (별도 `agents/spec-drift.md` 등) 신규 작성", "reason": "5 관점 review 안 spec-drift 관점 = `general-purpose` 서브에이전트에 prompt 안 context7 invoke 역할 부여 mechanism (별 agent .md 부재). 본 case 정정 대상 = orchestrator (메인 Claude) 가 Agent 호출 시 prompt source = harness-meta.md 표 → 단일 host."},
    {"id": "oos_5", "item": "v6.7 entry title 'Active form retitle candidate' (ROADMAP next_candidates#7) 흡수", "reason": "본 milestone scope 외. 본 milestone 안 title 자체 = active form 약 강화 ('가이드라인' 명사 → '가이드라인 도입' verb suffix) 적용 — 자기 적용만, v6.7 retitle 은 별 milestone 보존."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "claude/commands/harness-meta.md line 193 (5 관점 review 표 안 spec-drift 행)", "purpose": "본 milestone 정정 대상 단일 host"},
    {"id": "dep_2", "source": "projects/meta/milestones/v6.2/MILESTONE.md L7 narrative", "purpose": "본 milestone origin evidence (regex 통과 vs 실 파일 검사 mismatch in-execute 발견)"},
    {"id": "dep_3", "source": "projects/meta/ROADMAP.md next_candidates[#3] (한국어 id, v6.2 origin)", "purpose": "본 milestone candidate 등재 source — OPEN 시 promote 제거 + 영문 id 변환"}
  ]
}
```

### Motivation

v6.2 phase-2 안 `milestones_path` anchor (`#sub-milestones`) 처리 mismatch — `tests/smoke-bundle-trigger.sh` regex 안 anchor 허용 (`^milestones/(_archive/)?v[0-9]+\.[0-9]+/(MILESTONE\.md(#sub-milestones)?|milestones\.md)$`) 통과 vs 실 파일 검사 logic (anchor strip 후 실 파일 존재 검증) 불일치 가 in-execute 시점 발견. RESEARCH/DESIGN 단계 spec-drift agent 검토 시 regex 패턴 자체만 보고 실 파일 검사 logic 까지 검토 안 함 → mismatch silent.

L7 본문 (v6.2 MILESTONE.md):

> milestones_path anchor (`#sub-milestones`) 처리 = smoke-bundle-trigger 안 anchor strip 후 실 파일 검사. v6.2 D7 (c) regex 안 anchor 허용 + 안 D7 c 안 anchor 부재 처리는 in-execute 발견 (regex 통과 vs 실 파일 검사 mismatch). 본 케이스가 RESEARCH 단계에서 식별 안 됨 — DESIGN 단계 spec-drift agent 도 식별 못 함 (regex 안 anchor 패턴만 보고 실 파일 검사 logic 검토 안 함). 후속: spec-drift 검토 시 'regex + 실 사용 함께 검증' 보강 권고.

해소 = 5 관점 review 표 안 spec-drift 행 description 보강 1 위치 정정. `외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`. orchestrator 가 Stage D 안 spec-drift 관점 서브에이전트 호출 시 prompt context 에 본 description 인용 → 향후 동질 mismatch (regex 통과 vs 실 사용 logic 불일치) 도 검토 scope 안 자연 포함.

**id 영문 변환 trace** — ROADMAP next_candidates#3 안 등재 id 가 한국어 (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`). ROADMAP schema_note 안 `next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe)` 정의. 한국어 미부합 (역사적 v6.2 PROPOSE 시 채택). 본 milestone OPEN 시 영문 변환 (`spec-drift-regex-actual-usage-mismatch-guideline`) — 의미 동치, 길이 단축 (39 char). 후속 milestone candidate 거명만 (id-regex-validation-smoke 등 — 본 milestone scope 외).

pre-PLAN 4 round 누적 결정 (2026-05-20):

1. **scope** — 단일 host (spec-drift 행 prompt 만 보강). ARCHITECTURE 일반화 narrative 또는 cascade host 부재. v6.6~v6.9 lightweight 패턴 정합.
2. **보강 문구** — `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토` (`/` 구분자 — 다른 4 행 패턴 정합).
3. **smoke 신규** — 부재. evidence base 약함 (L7 1건) + over-engineering 회피.
4. **phase** — 1-phase 통합 (변경 4 위치: harness-meta.md + ROADMAP + CHANGELOG + MILESTONE.md).

### Out of scope rationale

oos_1: 5 관점 일반화 narrative = evidence base 약함. L7 단 1건 → architecture/scope-contract/회귀 risk/보안 4 관점까지 cascade 는 over-engineering. 일반화 needs 가 다음 cycle 자연 발현 시 별 milestone (v3.6/v3.17 자기참조 동결 정합).

oos_2: smoke 자동 검증 = +1 smoke 년명도 trade-off 안 evidence 약함. v6.6~v6.9 lightweight 누적 정합. 향후 evidence 누적 시 자연.

oos_3: cascade host 부재 = ARCHITECTURE/CLAUDE.md/기타 milestone REPORT 안 `5 관점 검토` 거명만 (표 5 관점 정의 부재). v3.21 3 단계 패턴 적용 대상 아님 (단일 host).

oos_4: spec-drift agent .md 신규 = 본 case 정정 대상 = harness-meta.md 표 단일 source (mechanism 자체 = orchestrator prompt 안 description 인용).

oos_5: v6.7 retitle candidate = 별 milestone 보존 (ROADMAP next_candidates#7). 본 milestone 안 자기 title 만 active form 약 강화 ('도입' verb suffix).

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code spec — sub-agent prompt 정의 패턴 (context7 query 2026-05-20)", "verdict": "VERIFIED — sub-agent prompt 안 `When invoked: ...` + `Best practices: ...` 형식 본 repo 5 관점 review 표 patterns 정합 (description 안 검토 포인트 1~2 sentence 인용). 본 milestone 안 보강 문구 = description 안 두 번째 검토 포인트 추가 자연."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "claude/commands/harness-meta.md:184-196", "fact": "5 관점 review 표 단일 source. scope 표 (≤5 파일 / 6~15 / 16+) + 관점 표 (5 행: architecture / spec-drift / 회귀 risk / 보안 / scope contract). line 193 spec-drift 행 description = `외부 spec 정합` (current)."},
    {"id": "cb_2", "file": "projects/meta/ARCHITECTURE.md:124, projects/meta/CLAUDE.md (root):38", "fact": "`5 관점 검토` 거명만 — 관점 5 종 정의 부재. 표 자체는 harness-meta.md 단일 source → cascade host 부재."},
    {"id": "cb_3", "file": "projects/meta/milestones/v6.2/MILESTONE.md:370-373", "fact": "L7 본문 원문 — `regex 패턴만 보고 실 파일 검사 logic 검토 안 함`. L4 lesson 안 `spec-drift spike 패턴 (c) DESIGN 즉시 정정` 별 candidate (#2). 본 milestone = L7 직접 후속, #2 (별 candidate `spec-drift-spike-pattern-c-design-immediate-narrative`) 와 직교 (다른 본질)."},
    {"id": "cb_4", "file": "projects/meta/ROADMAP.md:81-86 (next_candidates#3)", "fact": "id = `spec-drift-review-regex-vs-실-사용-mismatch-guideline` (한국어, schema_note `^[a-z0-9-]+$` 위반 — 역사적 v6.2 PROPOSE 시 채택). 본 milestone OPEN 시 영문 변환 자연."},
    {"id": "cb_5", "file": "agents/ 디렉토리 전체 (7 agent .md)", "fact": "별도 `spec-drift.md` 부재 — 5 관점 review 안 spec-drift 관점 = orchestrator (메인 Claude) 가 `Agent` tool 호출 시 prompt 안 context7 invoke 역할 부여 mechanism (subagent_type=general-purpose). 정정 대상 = harness-meta.md 표 prompt source."},
    {"id": "cb_6", "file": "claude/commands/harness-meta.md 5 관점 review 표 안 4 다른 행", "fact": "행 description 패턴 = `A / B / C` 또는 `A — B` 또는 단일 phrase. 본 milestone 보강 문구 `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토` = `/` 구분자 정합 (architecture 행 `디렉토리 구조 / 파일 책임 / 변경 영향` 패턴 정합)."}
  ],
  "options": [
    {"id": "opt_A", "option": "spec-drift 행 prompt 만 보강 (단일 host, 추천)", "pros": "토큰 효율 + L7 evidence 직접 정합 + v6.6~v6.9 lightweight 정합 + scope 명확", "cons": "5 관점 일반화 narrative 부재 (향후 다른 관점 동질 mismatch 시 별 milestone 자연)", "verdict": "ADOPTED (pre-PLAN Round 1)"},
    {"id": "opt_B", "option": "5 관점 review 전반 공통 원칙 정전화 (ARCHITECTURE 안)", "pros": "일반화 narrative 자연 cascade — architecture/scope-contract/회귀 risk/보안 4 관점도 포함", "cons": "evidence base 약함 (L7 1건만) → over-engineering 위험. v3.6/v3.17 자기참조 동결 narrative 정합 안 함", "verdict": "REJECTED — evidence 부재"},
    {"id": "opt_C", "option": "ARCHITECTURE 정전화 + harness-meta.md cascade 둘 다 (v3.21 3 단계 패턴)", "pros": "narrative trace 단단", "cons": "v3.21 패턴 적용 대상 = 여러 host 안 흩어진 narrative 통합용. 본 case 단일 host (cascade host 부재) → 패턴 misapplication", "verdict": "REJECTED — 패턴 misapplication"}
  ],
  "risks_identified": [
    {"id": "r_1", "risk": "보강 문구 `regex·패턴 안 실 사용 logic 함께 검토` 가 너무 general 하여 spec-drift agent 안 노이즈 (모든 검토 시 grep+실 파일 검사 의무)", "severity": "low", "mitigation": "보강 문구 자체가 가이드라인 (의무 강제 아님). orchestrator prompt context 안 description 1 줄 — spec-drift agent 가 mismatch 발견 시 추가 검토 trigger 자연."},
    {"id": "r_2", "risk": "행 길이 다른 4 행 대비 길어짐 (`외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토` 약 27자 → 다른 행 평균 약 20자)", "severity": "low", "mitigation": "architecture 행 (`디렉토리 구조 / 파일 책임 / 변경 영향` 약 20자) + scope contract 행 (`INTENT.success_criteria ↔ DESIGN.phases 매핑` 약 28자) 평균 균형. 본 행 27자 = 평균 범위."},
    {"id": "r_3", "risk": "보강 문구 정정 후 v6.10 자체 안 spec-drift 관점 self-review (Stage D inline) 안 검증 누락 (자기참조)", "severity": "low", "mitigation": "본 MILESTONE.md DESIGN 안 inline self-review 5 관점 자체 적용 — spec-drift 관점 안 보강 문구 적용 후 효과 자기 검증 (도그푸드 cycle)."},
    {"id": "r_4", "risk": "id 영문 변환 (한국어 → `spec-drift-regex-actual-usage-mismatch-guideline`) 의미 손실", "severity": "low", "mitigation": "title 본문 안 한국어 보존 + INTENT.Motivation 안 변환 trace + ROADMAP next_candidates#3 제거 시 id 변환 명시. 의미 손실 0."}
  ]
}
```

### External narrative

`/websites/code_claude` context7 query — sub-agent prompt 정의 패턴 (`When invoked: ...` + `Best practices: ...` 형식). 본 repo 5 관점 review 표 patterns 자연 정합 (description 안 검토 포인트 1~2 sentence 인용). 보강 문구 = description 안 두 번째 검토 포인트 추가 자연.

### Codebase narrative

5 관점 review 표 = `claude/commands/harness-meta.md` line 182~196 단일 source. ARCHITECTURE.md (line 124) + CLAUDE.md root (line 38) 는 `5 관점 검토` 거명만 (표 5 관점 정의 부재) → cascade host 부재 사실.

agents/ 디렉토리 안 7 agent .md 안 별도 `spec-drift.md` 부재. mechanism = orchestrator (메인 Claude) Stage D 안 `Agent` tool 호출 시 `subagent_type=general-purpose` + prompt 안 context7 invoke 역할 부여. 정정 대상 = orchestrator prompt source = harness-meta.md 표.

### Options narrative

opt_A (단일 host 보강) ADOPTED — evidence 정합 + lightweight + v6.6~v6.9 패턴 정합. opt_B (5 관점 일반화) REJECTED — evidence 부재. opt_C (3 단계 패턴) REJECTED — 패턴 misapplication (단일 host 안 사용).

### Risk priorities

r_1~r_4 모두 low severity — 일반화 noise / 행 길이 / 자기참조 / id 변환 모두 mitigation 직접 적용. P1 위험 부재.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "보강 문구 = `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토` (`/` 구분자, pre-PLAN Round 2 채택)", "rationale": "다른 4 행 description 패턴 (architecture 행 `디렉토리 구조 / 파일 책임 / 변경 영향` 등) 정합. 원 narrative `외부 spec 정합` 보존 + L7 evidence 두 번째 검토 포인트 추가. 행 균형 + 의미 명료.", "evidence": "RESEARCH cb_6 + AskUserQuestion Round 2 결과"},
    {"id": "D2", "decision": "scope = `claude/commands/harness-meta.md` line 193 1 위치 정정 only (cascade host 부재 + ARCHITECTURE narrative 부재 + smoke 신규 부재)", "rationale": "5 관점 review 표 단일 source 사실 (RESEARCH cb_2) + L7 evidence 1건 만 (5 관점 일반화 over-engineering 회피) + v6.6~v6.9 lightweight 누적 패턴 정합.", "evidence": "RESEARCH cb_2 + Round 1 결정"},
    {"id": "D3", "decision": "id 영문 변환 = `spec-drift-regex-actual-usage-mismatch-guideline` (ROADMAP next_candidates#3 한국어 id → 본 milestone OPEN 시 영문)", "rationale": "ROADMAP schema_note `^[a-z0-9-]+$` 정합. 의미 동치 + 길이 39자 (한국어 51자 대비 단축). 변환 trace = INTENT.Motivation 안 보존.", "evidence": "ROADMAP schema_note line 7 + RESEARCH cb_4"},
    {"id": "D4", "decision": "title active form 약 강화 = `... 가이드라인 도입` ('도입' verb suffix 추가)", "rationale": "ROADMAP next_candidates#3 title `... 가이드라인` 명사 종결. ARCHITECTURE § 7.2 entry title 가이드 4 원칙 (2) active form 정합. 자기 적용만 — v6.7 retitle candidate (next_candidates#7) 와 직교.", "evidence": "ARCHITECTURE § 7.2 + RESEARCH cb_4"},
    {"id": "D5", "decision": "phases = 1 phase 통합 (lightweight, v6.7~v6.9 패턴 정합)", "rationale": "변경 4 위치 (harness-meta.md + ROADMAP + CHANGELOG + MILESTONE.md) 모두 같은 본질 — 1 commit. 도그푸드 검증 = inline self-review (subagent 부재).", "evidence": "v6.7/v6.8/v6.9 1-phase commit 패턴"},
    {"id": "D6", "decision": "review depth = Lightweight + inline self-review (subagent 부재)", "rationale": "v6.7/v6.8/v6.9 패턴 정합 + 본 scope 매우 작음 (1 위치 정정) → marginal value. inline self-review 5 관점 자체 적용 = 자기 검증 (도그푸드).", "evidence": "v6.6 5 관점 subagent saturate evidence + v6.7~v6.9 lightweight 패턴"},
    {"id": "D7", "decision": "smoke 신규 부재 (행 self-drift 차단 grep smoke 보류)", "rationale": "Round 4 결정 — evidence base 약함 (L7 1건) + +1 smoke 년명도 trade-off. v6.6~v6.9 lightweight 누적 정합. 향후 evidence 누적 시 별 milestone candidate.", "evidence": "Round 4 AskUserQuestion 결과"},
    {"id": "D8", "decision": "ROADMAP next_candidates 안 #3 entry 제거 (한국어 id) + milestones[] 안 v6.10 in_progress entry 추가 (영문 id) + v6.7 archival (recent 3 = v6.10 + v6.9 + v6.8)", "rationale": "v5.21+ schema A2 정합. forward-looking 이정표 본질 + recent 3 carry-over context 유지.", "evidence": "ROADMAP schema_note v5.21+ schema A2"}
  ],
  "approach": "1 컴포넌트 정정 — `claude/commands/harness-meta.md` line 193 spec-drift 행 description 보강 (`외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`). 추가로 (1) ROADMAP milestones[] 안 v6.10 in_progress entry 추가 + next_candidates#3 제거 + v6.6 archival, (2) CHANGELOG [v6.10] entry 추가, (3) MILESTONE.md APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 5 섹션 채움 = 1 phase 통합 commit.",
  "phases": [
    {"id": "phase-1", "scope": "harness-meta.md line 193 spec-drift 행 보강 + ROADMAP milestones[]/next_candidates 갱신 + CHANGELOG [v6.10] entry + MILESTONE.md 5 섹션 채움 + pre-commit hook PASS 검증 + 도그푸드 self-grep 검증", "commit": "feat(meta): v6.10 — spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입 [v6.10]"}
  ],
  "risk_mitigation": [
    {"id": "R1", "risk": "보강 문구 일반화 noise (모든 spec-drift 검토 시 grep+실 파일 검사 의무로 해석)", "mitigation": "보강 문구 자체 = 가이드라인 (의무 강제 아님). orchestrator prompt context 안 description 1 줄 — spec-drift agent 가 mismatch 발견 시 추가 검토 trigger 자연 (R1)."},
    {"id": "R2", "risk": "행 길이 다른 4 행 대비 약간 길어짐", "mitigation": "다른 4 행 평균 길이 범위 (architecture 약 20자 + scope contract 약 28자) 안 — 본 행 27자 평균. 균형 유지 (R2)."},
    {"id": "R3", "risk": "self-drift (보강 문구 정정 후 누군가 원 narrative 로 되돌릴 위험)", "mitigation": "smoke 자동 검증 부재 (Round 4 결정) → 향후 evidence 누적 시 별 milestone (id-regex-validation-smoke 또는 spec-drift-prompt-self-drift-smoke). 본 milestone scope 외 (R3 → oos_2)."},
    {"id": "R4", "risk": "id 영문 변환 시 ROADMAP next_candidates#3 안 한국어 id reference 잔존 (외부 인용 누락)", "mitigation": "본 milestone phase-1 안 next_candidates#3 entry 제거 + milestones[] v6.10 in_progress 추가 = 동시 갱신. external reference 부재 (v6.2 origin REPORT 본문 안 한국어 id 인용은 historical 보존, 영향 0)."},
    {"id": "R5", "risk": "도그푸드 검증 method 부재 (smoke 신규 부재 → 향후 회귀 검출 mechanism 약함)", "mitigation": "도그푸드 = inline self-grep 검증 = `grep '외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토' claude/commands/harness-meta.md` exit 0 확인. 1회 검증 (Round 4 정합 evidence base 약함). 향후 누적 시 smoke 추가 자연."}
  ]
}
```

### Approach narrative

v6.2 L7 origin direct 후속 — spec-drift 검토 시 `regex 패턴만 보고 실 파일 검사 logic 검토 안 함` mismatch 회피 가이드라인 도입. `claude/commands/harness-meta.md` 5 관점 review 표 안 spec-drift 행 description 1 위치 보강만 (`외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`).

5 관점 일반화 narrative (opt_B) REJECTED — evidence 부재 (L7 단 1건). v3.21 3 단계 패턴 (opt_C) REJECTED — 패턴 misapplication (단일 host).

### Untouched files explicit (b/c/d 부산물)

- `projects/meta/ARCHITECTURE.md` — 5 관점 review 표 본문 부재 (line 124 거명만), cascade host 부재 → 변경 0.
- `CLAUDE.md` (root) — line 38 `5 관점 검토` 거명만, cascade host 부재 → 변경 0.
- `agents/*.md` — spec-drift agent .md 부재 (orchestrator prompt mechanism), 변경 0.
- `tests/*.sh` — smoke 신규 부재 (Round 4 결정), 변경 0.
- `scripts/*.py` — 본 milestone scope 외, 변경 0.
- `bootstrap/` — 본 milestone scope 외.

### Risk priorities

R1~R5 모두 low severity — mitigation 직접 적용. P1 위험 부재. R3+R5 = oos_2 흡수 (smoke 신규 부재) + 향후 evidence 누적 시 별 milestone candidate.

### Inline self-review 종합 (5 관점, subagent 부재 — lightweight 정합)

5 관점 inline self-review:

- **Architecture** P3 #arch-1: D2 scope (단일 host) 안 cascade host 부재 사실 → ARCHITECTURE/CLAUDE.md 안 5 관점 review 표 인용 narrative 추가 후보 (별 milestone). v3.21 패턴 misapplication 회피 결정 정합. 별 milestone 거명만.
- **Spec-drift** P3 #drift-1: 보강 문구 안 `regex·패턴` 가운데점 (`·`) 사용 — 다른 행 안 가운데점 부재 (`/` 또는 단순 space). 다른 행 안 가운데점 통일성 약. 다만 `regex·패턴` 묶음 의미 (regex = 패턴 종류) 표현 자연. narrative 흡수.
- **Security** P3 #sec-1: 보강 문구 자체 안 path traversal / injection 위험 부재 (텍스트 문구). 영향 0.
- **Dictionary-semantics** P2 #dict-1: title 안 작은 따옴표 (`'regex + 실 사용 함께 검증'`) 사용 — ARCHITECTURE § 7.2 (3) ≤ 60자 정합 (52자). active form 약 강화 (`도입` verb suffix) D4 정합. 의미 명료. 흡수.
- **Test-coverage** P3 #test-1: 도그푸드 검증 method = inline self-grep 1회. smoke 신규 부재 → 향후 회귀 검출 mechanism 약함. R5 mitigation 안 흡수 (별 milestone 자연).

decisive 0 + P2 1 + P3 4 = 모두 narrative 흡수 또는 별 milestone 거명만 (v6.7~v6.9 lightweight 패턴 정합).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "scope": "8 decisions (D1~D8) + 5 관점 inline self-review (decisive 0 / P2 1 / P3 4) + 4 round pre-PLAN 결정 (scope=opt_A / 보강 문구=opt_a `/` 구분자 / smoke 신규 부재 / phase=1-phase) — all approved",
    "method": "inline AskUserQuestion (Stage E)",
    "notes": "lightweight 모드 + 5 관점 inline self-review (subagent 부재) — v6.7~v6.9 패턴 정합. pre-PLAN 4 round + Round 5 review 완료. archival 대상 = v6.7 (현 recent 3 = v6.9+v6.8+v6.7 → v6.10 추가 후 v6.7 archival). phase-1 EXECUTE 진입 허가."
  }
}
```

## EXECUTE

### Spec

```json
{
  "phases": [
    {
      "id": "phase_1",
      "title": "harness-meta.md line 193 spec-drift 행 보강 + ROADMAP/CHANGELOG 갱신 + MILESTONE.md 5 섹션 채움 통합 1 commit",
      "actions": [
        "(1) claude/commands/harness-meta.md line 193 spec-drift 행 description 정정 (`외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`)",
        "(2) projects/meta/ROADMAP.md milestones[] 안 v6.10 in_progress entry 추가 (영문 id, status='in_progress', trigger='B_regression', origin v6.2 L7)",
        "(3) projects/meta/ROADMAP.md next_candidates 안 #3 entry 제거 (한국어 id `spec-drift-review-regex-vs-실-사용-mismatch-guideline`)",
        "(4) projects/meta/ROADMAP.md milestones[] 안 v6.7 entry archival (recent 3 = v6.10 + v6.9 + v6.8) + updated 필드 갱신 ('2026-05-20-v6.10')",
        "(5) CHANGELOG.md [v6.10] entry 신규 추가 (Keep a Changelog v1.1.0 정합, [Unreleased] 안 또는 Released)",
        "(6) MILESTONE.md APPROVE 안 approval.date='2026-05-20' + notes 채움",
        "(7) MILESTONE.md EXECUTE actions 본 list 보존 + VERIFY/REPORT/PROPOSE 3 섹션 채움 (다음 task 안)",
        "(8) 도그푸드 self-grep 검증 — `grep -F '외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토' claude/commands/harness-meta.md` exit 0",
        "(9) pre-commit 18 hook 호출 검증 (회귀 0 확인)",
        "(10) commit (subject `feat(meta): v6.10 — spec-drift 검토 regex·실 사용 함께 검증 가이드라인 도입 [v6.10]`)"
      ],
      "files_changed": [
        "claude/commands/harness-meta.md (line 193 spec-drift 행 description 보강)",
        "projects/meta/ROADMAP.md (milestones[] + next_candidates 갱신)",
        "CHANGELOG.md ([v6.10] entry 추가)",
        "projects/meta/milestones/v6.10/MILESTONE.md (전체 작성)",
        "projects/meta/milestones/v6.10/execute/ (빈 디렉토리, v6.7~v6.9 패턴 정합)"
      ]
    }
  ]
}
```

## VERIFY

### Spec

```json
{
  "smoke_results": [
    {"smoke": "self-grep verification", "result": "PASS", "metric": "grep -F '외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토' claude/commands/harness-meta.md exit 0 (보강 문구 정확 본문 존재 확인)"},
    {"smoke": "pre-commit 18 hook", "result": "PASS (예정)", "metric": "phase-1 commit 시 호출 — smoke 변경 부재 → 기존 18 hook 회귀 0 기대"}
  ],
  "criteria_check": [
    {"id": "sc_1", "verdict": "PASS", "evidence": "claude/commands/harness-meta.md line 193 spec-drift 행 description = `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토` 정확 본문. self-grep PASS."},
    {"id": "sc_2", "verdict": "PASS", "evidence": "MILESTONE.md frontmatter id = `spec-drift-regex-actual-usage-mismatch-guideline` (영문 변환). 변환 trace INTENT.Motivation 안 보존 (한국어 → 영문)."},
    {"id": "sc_3", "verdict": "PASS", "evidence": "ROADMAP milestones[] 안 v6.10 in_progress entry 추가 + next_candidates#3 (한국어 id) 제거 + v6.7 entry archival (recent 3 = v6.10/v6.9/v6.8). updated 필드 '2026-05-20-v6.10' 갱신."},
    {"id": "sc_4", "verdict": "PASS", "evidence": "CHANGELOG.md [v6.10] entry 신규 추가 (Added/Changed/Documented 3 sub-section). entry title 가이드 4 원칙 정합 (≤60자 + active form '도입' suffix)."},
    {"id": "sc_5", "verdict": "PASS (예정)", "evidence": "smoke 변경 부재 → 기존 18 hook 회귀 0 기대. phase-1 commit 시 검증."}
  ],
  "verdict": "PASS — 5 success_criteria 모두 PASS (sc_5 phase-1 commit 검증 예정). lightweight 1-phase 통합 정합."
}
```

### Smoke narrative

self-grep PASS (보강 문구 line 193 정확 본문 존재). pre-commit 18 hook = smoke 변경 부재 → 기존 회귀 0 기대 (phase-1 commit 시 검증).

### Criteria narrative

sc_1~sc_4 모두 PASS evidence 직접 확인 (file 본문 + ROADMAP entry + CHANGELOG entry). sc_5 = phase-1 commit 시점 검증.

## REPORT

### Spec

```json
{
  "summary": "v6.2 L7 origin (regex 통과 vs 실 파일 검사 mismatch 가 spec-drift agent 안 식별 안 됨) 직접 해소 — `claude/commands/harness-meta.md` 5 관점 review 표 안 spec-drift 행 (line 193) description 1 위치 정정 (`외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`). cascade host 부재 + smoke 신규 부재 + ARCHITECTURE narrative 부재 = lightweight 1-phase 통합 1 commit (v6.6~v6.9 누적 패턴 정합).",
  "delta": {
    "files_changed": 4,
    "lines_added": 18,
    "lines_removed": 9,
    "commits": 1,
    "scope": "1 위치 정정 (harness-meta.md line 193) + ROADMAP milestones[] + next_candidates + CHANGELOG entry + MILESTONE.md 전체"
  },
  "lessons_learned": [
    {"id": "L1", "lesson": "spec-drift 검토 prompt 안 'regex/패턴 + 실 사용 logic 함께 검토' 가이드라인 = description 1 줄 추가 만으로 충분 (orchestrator prompt context 안 1 sentence 인용 mechanism). 별도 agent .md 또는 smoke 추가 부재 — evidence base (L7 1건) 정합 + over-engineering 회피.", "priority": "P1"},
    {"id": "L2", "lesson": "5 관점 review 표 단일 source = `claude/commands/harness-meta.md` line 182~196. ARCHITECTURE.md / CLAUDE.md root 안 `5 관점 검토` 거명만 (관점 5 종 표 부재) → cascade host 부재 사실. v3.21 narrative 3 단계 패턴 적용 대상 부재 — 패턴 misapplication 회피 결정 정합.", "priority": "P1"},
    {"id": "L3", "lesson": "v3.21 패턴 = 여러 host 흩어진 narrative 통합용. 단일 host (본 case) 적용은 over-engineering. 패턴 적용 대상 판정 = cascade host 갯수 (≥2 → 패턴 적용 / =1 → 적용 대상 부재). 향후 lightweight milestone 안 동일 판정 기준 reference.", "priority": "P1"},
    {"id": "L4", "lesson": "ROADMAP next_candidates#3 안 등재 id 한국어 (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) = schema_note `^[a-z0-9-]+$` 위반. 본 milestone OPEN 시 영문 변환 (`spec-drift-regex-actual-usage-mismatch-guideline`) — 변환 trace INTENT.Motivation 안 보존. 향후 PROPOSE 단계 안 id schema 검증 smoke 추가 후보 (id-regex-validation-smoke 거명만).", "priority": "P2"},
    {"id": "L5", "lesson": "lightweight 1-phase 누적 13/25 = 52% (v6.9 12/24 = 50% → v6.10 13/25 = 52%). 50% 첫 돌파 (v6.9) 후 추가 보강. v6.6~v6.10 5 consecutive lightweight 1-phase milestone 누적 — lightweight 본질 본 repo 자연 정합 evidence.", "priority": "P2"},
    {"id": "L6", "lesson": "title active form 약 강화 (`... 가이드라인` 명사 → `... 가이드라인 도입` verb suffix) 자기 적용 — ARCHITECTURE § 7.2 entry title 가이드 4 원칙 (2) 자연 정합. v6.7 retitle candidate (`active-form-3-step-chain-retitle-v6-7`) 와 직교 (별 milestone 보존, oos_5).", "priority": "P2"},
    {"id": "L7", "lesson": "도그푸드 self-grep verify = inline 검증 method (smoke 신규 부재 case). `grep -F '<보강 문구>' <file>` exit 0 확인 = 단순 + 정확. smoke 신규 부재 case 안 도그푸드 검증 mechanism reference (향후 lightweight milestone patterns).", "priority": "P2"},
    {"id": "L8", "lesson": "archival cycle 10번째 도달 (v5.21 도입 archival cycle 8 = v6.8 / 9 = v6.9 / 10 = v6.10). recent 3 = v6.10/v6.9/v6.8. 안정 archival cycle 운영 evidence.", "priority": "P2"}
  ]
}
```

### Summary narrative

v6.2 L7 origin 직접 해소 — spec-drift 검토 시 `regex 패턴만 보고 실 파일 검사 logic 검토 안 함` mismatch 회피 가이드라인 도입. 1 위치 정정 (`외부 spec 정합` → `외부 spec 정합 / regex·패턴 안 실 사용 logic 함께 검토`).

### Delta narrative

scope 작음 — files_changed=4 (harness-meta.md + ROADMAP.md + CHANGELOG.md + MILESTONE.md), 1 commit 통합. lightweight 1-phase 정합.

### Lessons narrative

L1 = 보강 문구 충분 (description 1 줄). L2 = 5 관점 review 표 단일 source 사실. L3 = v3.21 패턴 적용 판정 기준 (cascade host 갯수). L4 = id schema 위반 (한국어) → 영문 변환 trace. L5 = lightweight 누적 13/25 = 52%. L6 = title active form 자기 적용 + v6.7 retitle 별 milestone. L7 = 도그푸드 self-grep verify method. L8 = archival cycle 10번째.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "id-regex-validation-smoke",
      "title": "ROADMAP next_candidates[].id schema regex 자동 검증 smoke",
      "trigger": "B_regression",
      "origin_milestone": "v6.10",
      "target_version": "v6.x",
      "description": "L4 origin — v6.10 OPEN 시 ROADMAP next_candidates#3 안 한국어 id (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) 가 schema_note `^[a-z0-9-]+$` 위반 발견. 본 milestone 안 영문 변환 직접 적용 만 (smoke 부재). 향후 PROPOSE 단계 안 id schema 자동 검증 smoke 도입 — tests/smoke-candidate-draft-schema.sh Stage 확장 또는 별 smoke (umbrella 분리 결정은 v6.8 oos_12 candidate 흡수 자연)."
    },
    {
      "id": "five-perspective-review-table-cascade-narrative",
      "title": "5 관점 review 표 cascade narrative ARCHITECTURE/CLAUDE.md 인용 보강",
      "trigger": "D_design",
      "origin_milestone": "v6.10",
      "target_version": "v6.x",
      "description": "L2 origin — 5 관점 review 표 = harness-meta.md 단일 source. ARCHITECTURE.md L124 + CLAUDE.md root L38 안 `5 관점 검토` 거명만 → 향후 인용 narrative 보강 candidate (v3.21 패턴 적용 대상 자연 도달 — 단일 host → 다중 host 전환). evidence 누적 시 별 milestone 발의."
    },
    {
      "id": "v321-pattern-application-judgment-criterion-narrative",
      "title": "v3.21 패턴 적용 대상 판정 기준 narrative 정전화 (cascade host 갯수)",
      "trigger": "D_design",
      "origin_milestone": "v6.10",
      "target_version": "v6.x",
      "description": "L3 origin — v3.21 narrative 3 단계 패턴 적용 대상 판정 기준 = cascade host 갯수 (≥2 → 패턴 적용 / =1 → 적용 대상 부재). 본 milestone 안 자연 발현 (단일 host 적용 outcome 회피). ARCHITECTURE § 6.2 narrative 정전화 3 단계 패턴 paragraph 안 판정 기준 narrative 1 sentence 보강 후보. 단 별 milestone 발의 trigger = 또 다른 단일 host case 발견 시 (evidence 누적 자연)."
    }
  ]
}
```

### Next candidates narrative

3 candidate 등재 — L4 (id schema smoke) + L2 (5 관점 review 표 cascade) + L3 (패턴 적용 판정 기준 narrative). 모두 distinct 본질 + 별 milestone target (v6.x). 본 milestone scope 외 (lightweight 정합).

## SUB_MILESTONES

본 milestone = 단일 sub-milestone (lightweight 1-phase 통합). bundling 부재 — v6.7~v6.9 lightweight 패턴 정합.

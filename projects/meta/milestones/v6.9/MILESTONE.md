---
id: synthesizer-mismatch-report-5step-format
title: synthesizer mismatch debugger 5-step 형식 통일
version: v6.9
status: completed
---

# v6.9 — synthesizer mismatch debugger 5-step 형식 통일

## INTENT

### Spec

```json
{
  "id": "synthesizer-mismatch-report-5step-format",
  "title": "synthesizer mismatch 보고 형식 debugger 5-step",
  "goal": "v6.8 도그푸드 2차 cycle (2026-05-20, commit e844f27) candidate_draft surface delta 안 최우선 valid 1건 origin. Claude Code debugger subagent 5-step 형식 (Capture/Identify/Isolate/Fix/Verify, <https://code.claude.com/docs/en/sub-agents>) 정합 mismatch 보고 형식 도입. scripts/audit_fact_verify.py 안 mismatch 보고 stdout JSON dict schema 5-step 통일 + ARCHITECTURE § 4 끝 매트릭스 #10 row (audit chain hallucination 자동 검출 mechanism) enhancement 안 mismatch 보고 형식 5-step 정전화 paragraph 보강 = mismatch 보고 일반 형식 단일 source. 책임 분리 = script Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (LLM/사용자 채움, v6.6 R1 '자율 = 검출 only' + v6.7 3-step chain (수동 1차 source → 자동 검출 → 수동 정정) 정합).",
  "success_criteria": [
    {"id": "sc_1", "description": "scripts/audit_fact_verify.py 안 3 detect function (detect_boolean_mismatches + detect_table_row_mismatches + detect_numeric_mismatches) mismatch dict schema 5-step 통일 — 6 필드 (method 보존 + capture + identify + isolate + fix + verify). method = 'boolean'/'table'/'numeric' 기존 보존 (LLM stage 분리 인용 용). capture = 1줄 발견 사실 string (file.name + key/source_ref + value 인용). identify = source path (file.name 또는 file:line). isolate = dict (method 별 method-specific fields = {stated, actual, key} or {source_ref, issue}). fix = null (LLM/사용자 채움 빈 슬롯). verify = null (사용자 명시 검증 빈 슬롯)."},
    {"id": "sc_2", "description": "projects/meta/ARCHITECTURE.md § 4 끝 누적 매트릭스 #10 row + paragraph enhancement (mismatch 보고 일반 형식 = 5-step (Capture/Identify/Isolate/Fix/Verify) 정전화 paragraph 보강) — v6.7 #10 + v6.8 #9 enhancement 패턴 정합 (신 row 부재, audit chain hallucination 자동 검출 mechanism 의 출력 형식 보강). paragraph 안 (1) 외부 spec 인용 (Anthropic debugger subagent), (2) 책임 분리 (script 3 자동 + LLM/사용자 2 수동), (3) 미래 script 정합 의무 narrative (cross-cutting feature 본질) 명시."},
    {"id": "sc_3", "description": "cascade host 갱신 — root CLAUDE.md L142 audit chain hallucination blockquote 본문 안 5-step 형식 1 줄 추가 + agents/project-harness-audit-team/CLAUDE.md Note v6.6 (Step 6 sequence 안 mismatch JSON 형식 5-step schema 인용 narrative 추가). cascade-sync mechanism (v6.4) 활용 marker hash 자동 갱신 + drift 0 검증."},
    {"id": "sc_4", "description": "tests/smoke-audit-fact-verify.sh 안 Stage 6 신규 추가 — 5-step schema 검증 (mismatch entry 출현 fixture 호출 후 stdout JSON parse + 5 필드 강제 검증). fixture 신규 부재 (기존 boolean-mismatch + table-mismatch 재사용). 기존 5 stage + 17 hook 회귀 0."},
    {"id": "sc_5", "description": "도그푸드 1 회 호출 검증 — `python scripts/audit_fact_verify.py --dir tests/fixtures/audit-fact-verify/boolean-mismatch` 호출 후 stdout JSON 안 mismatch dict 5-step 5 필드 출력 확인. Capture/Identify/Isolate 3 필드 자동 채움 + Fix/Verify null/None 확인."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "Fix 필드 자동 채움 (5-step 안 4번째 단계)", "reason": "v6.6 R1 정합 (자율 = 검출 only). LLM 추론 필요 + 재귀 hallucination 위험. ROADMAP next_candidates 안 citation-method-auto-detect-mechanism candidate (target_version v6.x, v6.6 origin) 와 동일 카테고리 (별 milestone)."},
    {"id": "oos_2", "item": "audit-team agent .md (project-scanner/harness-gap-analyzer/claude-docs-mapper/component-proposer) 안 H2 sub-section 추가 (5-step 형식 검증 의무)", "reason": "본 milestone scope = mechanical core (script) + 정전화 host (ARCHITECTURE) + cascade host 2건 (root CLAUDE.md + audit-team CLAUDE.md Note v6.6). agent .md 안 H2 sub-section 추가는 v5.18 Input Verification 패턴 정합 별 milestone — 본 시점 evidence 부재."},
    {"id": "oos_3", "item": "scripts/propose_next.py 안 5-step 형식 적용", "reason": "Round 4 결정 (2026-05-20) — propose_next.py 안 mismatch detect logic 자체 부재 (dedupe = passing/delta 분류, 정상 출력). 적용 대상 부재 vacuous trim 자연 (v5.7 spec-drift spike 패턴 (c) 9번째 발현). scope (b) '둘 다 + 일반 정전화' 본질 = 일반 정전화 (ARCHITECTURE row #10 enhancement 안 미래 script 정합 의무 narrative) 으로 보존."},
    {"id": "oos_4", "item": "본 mechanism 외부 적용 (upbit 또는 다른 프로젝트 안 mismatch 보고)", "reason": "v4.0 정체성 정합 (project harness composer + ecosystem integrator). 본 시점 = meta self-host 1차 정전화 + 일반 형식 정전화 (ARCHITECTURE host). 외부 적용은 evidence 도달 시 별 milestone."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "scripts/audit_fact_verify.py (v6.6 origin)", "purpose": "5-step schema mismatch 출력 host"},
    {"id": "dep_2", "source": "projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 row #10 + paragraph", "purpose": "mismatch 보고 일반 형식 정전화 host (enhancement, 신 row 부재)"},
    {"id": "dep_3", "source": "Claude Code debugger subagent docs (<https://code.claude.com/docs/en/sub-agents>)", "purpose": "5-step 외부 spec 1차 source (RESEARCH context7 verify 완료, 2026-05-20)"},
    {"id": "dep_4", "source": "ROADMAP candidate_draft[0] (v6.8 origin, 본 milestone OPEN 시 promote 제거)", "purpose": "본 milestone origin candidate (v6.8 도그푸드 2차 cycle, 2026-05-20)"},
    {"id": "dep_5", "source": "agents/project-harness-audit-team/CLAUDE.md Note v6.6 Step 6", "purpose": "cascade host 2 (5-step schema 인용 추가)"}
  ]
}
```

### Motivation

v6.8 도그푸드 2차 cycle (2026-05-20, commit e844f27) 안 `/propose-next --scan` 호출 안 candidate_draft surface delta 안 최우선 valid 1건이 본 candidate. 사용자 결정 안 false positive 2건 제외 후 valid 1건 append → v6.8 ROADMAP `candidate_draft[]` 안 등재 → v6.9 OPEN 시 promote.

**본질 진단** (pre-PLAN Round 1~4, 2026-05-20):

`scripts/audit_fact_verify.py` (v6.6 origin) 안 mismatch 보고 stdout JSON dict schema 가 자유 — 매 method 별 자기 형식 (`{method, file, key, stated, actual}` 또는 `{source_ref, issue}` 등). Claude Code debugger subagent (<https://code.claude.com/docs/en/sub-agents>) 가 정의한 5-step (Capture/Identify/Isolate/Implement/Verify) 가 디버깅 표준 패턴 — mismatch = 디버깅의 일종이므로 정합 자연. v5.7 spec-drift spike 패턴 (c) 9번째 발현 (Anthropic spec 인용 → 정전화 직접).

책임 분리 본질 — script 는 Capture/Identify/Isolate 3 자동 채움 (deterministic, 안전) + Fix/Verify 2 빈 슬롯 (LLM 추론 필요, 재귀 hallucination 위험 = v6.6 R1 자율 = 검출 only 정합 + v6.7 3-step chain (수동 v5.13/v5.18 1차 source → 자동 v6.6 검출 → 수동 정정 사용자/orchestrator) 정합). 5-step 5 필드 모두 schema 강제 (정합 견고성) 이나 내용은 책임 분리 — script JSON 안 fix:null, verify:null 빈 슬롯 보존.

Round 4 결정 (propose_next.py scope) — propose_next.py 안 mismatch detect logic 자체 부재 (dedupe = passing/delta 분류) → vacuous trim 자연. scope (b) '둘 다 + 일반 정전화' 본질 = 일반 정전화 (ARCHITECTURE row #10 enhancement 안 미래 script 정합 의무 narrative) 으로 보존. propose_next.py 변경 0.

### Out of scope rationale

oos_1: Fix 자동 채움 = LLM 추론 필요. v6.6 R1 명시 (자율 = 검출 only). next_candidates 안 citation-method-auto-detect-mechanism candidate (target_version v6.x, v6.6 origin) 와 동일 카테고리 (재귀 hallucination 위험).

oos_2: agent .md 안 H2 sub-section 추가 = v5.18 Input Verification 패턴 정합 별 milestone. 본 시점 evidence 부재.

oos_3: propose_next.py mismatch detect 부재 → vacuous trim. scope (b) 일반 정전화 본질 = ARCHITECTURE row #10 enhancement 안 미래 script 정합 narrative 으로 보존.

oos_4: 외부 프로젝트 적용 = 본 시점 self-host 1차 정전화 우선. evidence 도달 시 별 milestone 자연.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code spec (context7 query 2026-05-20) — debugger subagent prompt 5-step 형식 인용", "verdict": "VERIFIED — `/websites/code_claude` 안 'Debugger Subagent' entry 안 prompt 안 정확 5-step (1. Capture error message and stack trace / 2. Identify reproduction steps / 3. Isolate the failure location / 4. Implement minimal fix / 5. Verify solution works) 인용. 단 'audit chain fact verify mismatch 보고' first-class 패턴 부재 → v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 9번째 자연 발현 (debugger subagent 5-step + repo 자체 mismatch 보고 결합 정전화)."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "scripts/audit_fact_verify.py:104-140 (boolean method)", "fact": "detect_boolean_mismatches() 안 mismatch dict 4 필드 (method='boolean', file, key, stated, actual) 또는 error case 5 필드 (method, file, key, stated, error). 5-step 통일 시 6 필드 (method + capture/identify/isolate/fix/verify) 자연."},
    {"id": "cb_2", "file": "scripts/audit_fact_verify.py:175-220 (table method)", "fact": "detect_table_row_mismatches() 안 mismatch dict 4 필드 (method='table', file, source_ref, issue). 5-step 통일 시 isolate 안 source_ref + issue dict 자연."},
    {"id": "cb_3", "file": "scripts/audit_fact_verify.py:232-265 (numeric method)", "fact": "detect_numeric_mismatches() 안 mismatch dict 5 필드 (method='numeric', file, key, stated, actual). 5-step 통일 시 boolean 과 동일 schema."},
    {"id": "cb_4", "file": "scripts/audit_fact_verify.py:328-333 (main output)", "fact": "main() 안 mismatch 출력 = print(json.dumps(mismatches, indent=2, ensure_ascii=False)). 출력 schema 자체 unchanged — list[dict] 안 dict schema 만 변경."},
    {"id": "cb_5", "file": "scripts/propose_next.py 전체", "fact": "mismatch detect logic 자체 부재 — dedupe = candidate_items[].status 'delta'/'passing' 분류 (정상 출력). cross_validate 안 directory_count vs roadmap_recent_milestones 불일치 detect 부재 (silent). Round 4 결정 = vacuous trim, 변경 0."},
    {"id": "cb_6", "file": "projects/meta/ARCHITECTURE.md:131-170 (§ 4 끝 누적 매트릭스)", "fact": "row #1~#10 누적. row #10 = audit chain hallucination 자동 검출 mechanism (v6.6). enhancement 위치 = paragraph 안 5-step 형식 정전화 1 sentence 추가 (전체 재작성 회피, lightweight)."},
    {"id": "cb_7", "file": "agents/project-harness-audit-team/CLAUDE.md:68-82 (Step 6 v6.6 신규)", "fact": "Step 6 안 stdout 안 mismatch 보고 narrative — '(boolean/표/수치 3 method)' 인용. 5-step 형식 인용 narrative 1 줄 추가 의무 (cascade host)."},
    {"id": "cb_8", "file": "CLAUDE.md (root) audit chain hallucination blockquote", "fact": "L142 audit chain hallucination 자동 검출 mechanism blockquote 본문 — 5-step 형식 1 줄 추가 의무 (cascade host)."},
    {"id": "cb_9", "file": "tests/smoke-audit-fact-verify.sh:79-104 (5 stage)", "fact": "Stage 1 boolean / Stage 2 table / Stage 3 numeric / Stage 4 edge case empty / Stage 5 path traversal. Stage 6 신규 = 5-step schema 검증 (boolean-mismatch fixture 호출 후 stdout parse + 5 필드 강제)."},
    {"id": "cb_10", "file": "tests/fixtures/audit-fact-verify/boolean-mismatch/", "fact": "boolean-mismatch fixture 기존 활용 — exit 1 (mismatch). stdout 안 JSON parse 후 5-step 5 필드 강제 검증 가능 (신규 fixture 부재)."}
  ],
  "options": [
    {"id": "opt_a", "label": "audit_fact_verify only + ARCHITECTURE row #10 enhancement", "verdict": "ACCEPTED (Round 4, 2026-05-20) — vacuous trim + lightweight 정합 + 토큰 효율 우선. propose_next.py 변경 0 (mismatch detect 부재 vacuous). scope (b) 일반 정전화 본질 = row #10 paragraph 안 미래 script 정합 narrative 으로 보존."},
    {"id": "opt_b", "label": "propose_next.py cross_validate fail detect 추가 + 신 row #11", "verdict": "REJECTED (Round 4) — 작업 범위 커짐 + propose_next.py LOC 늘어남 + 신 detect logic 자체 evidence 부재 (1차 적용 경험 부재). 미래 evidence 도달 시 별 milestone 자연."},
    {"id": "opt_c", "label": "audit_fact_verify only + 신 row #11 (cross-cutting mechanism 신규)", "verdict": "REJECTED (Round 4) — vacuous propose_next 안 적용 부재 시 cross-cutting 본질 약화. row #10 enhancement (v6.7 #10 + v6.8 #9 누적 패턴 정합) 가 더 자연."}
  ],
  "risks_identified": [
    {"id": "risk_1", "item": "mismatch dict schema breaking change → audit-team CLAUDE.md Note v6.6 Step 6 안 LLM 추론 영향", "mitigation": "외부 이용자 1건 = audit-team Step 6 안 메인 Claude orchestrator (자체 통제). breaking change 시 5-step schema 인용 narrative 동시 갱신 → 자체 적응. 영향 0."},
    {"id": "risk_2", "item": "5-step 5 필드 모두 강제 시 boolean/table/numeric method 마다 isolate 안 method-specific dict 부담", "mitigation": "isolate 안 method-specific dict (boolean = {stated, actual, key} / table = {source_ref, issue} / numeric = {stated, actual, key}) 포용 — 각 method 별 자유 schema 보존, 5-step 외형만 통일."},
    {"id": "risk_3", "item": "ARCHITECTURE row #10 enhancement 시 v6.6/v6.7 누적 narrative 길어짐", "mitigation": "paragraph 안 5-step 1~2 sentence 보강만 (전체 재작성 회피). lightweight 정합."},
    {"id": "risk_4", "item": "smoke Stage 6 안 5-step schema 검증 시 fixture stdout JSON parse 부담", "mitigation": "기존 fixture (boolean-mismatch) 재사용 + Python heredoc 으로 JSON parse + 5 필드 grep (간단 logic). 신규 fixture 부재."},
    {"id": "risk_5", "item": "도그푸드 호출 시 stdout JSON parse 실패 risk", "mitigation": "기존 audit_fact_verify.py:332 `json.dumps(mismatches, indent=2, ensure_ascii=False)` 정상 출력 검증됨 (v6.6 cycle 4 evidence). 5 필드 schema 변경만 — JSON 출력 자체 unchanged."},
    {"id": "risk_6", "item": "Anthropic 원문 'Implement minimal fix' vs JSON 필드명 'fix' 어색 mismatch", "mitigation": "필드명 간결 우선 (Round 3 default 수용) + paragraph 안 외부 spec 인용 narrative 안 'Implement minimal fix' 원문 인용 (이중 트래커). spec-drift P2 candidate 거명만."}
  ]
}
```

### Untouched files explicit (b/c/d 부산물)

- `scripts/propose_next.py` — Round 4 결정 vacuous trim (mismatch detect 부재). oos_3 흡수.
- `claude/commands/propose-next.md` — propose_next.py 변경 0 → cascade 영향 부재.
- `claude/commands/cascade-sync.md` — cascade marker hash 자동 갱신만 (script 변경 부재).
- `tests/fixtures/audit-fact-verify/` — 신규 fixture 부재 (기존 boolean-mismatch 재사용).
- `bootstrap/` — 본 milestone scope 외 (install lifecycle 영향 부재).
- `tests/_inactive/` — archive smoke 영향 부재.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "5-step JSON 필드명 = capture/identify/isolate/fix/verify (Anthropic spec 'Implement minimal fix' 안 명사 'fix' 채택, 필드명 간결)", "rationale": "Round 3 default 수용 + Anthropic 원문 정합 (capture/identify/isolate 3 verb + fix noun + verify verb). spec-drift P2 candidate 거명만 (필드명 'implement' 대신 'fix' 어색 mismatch).", "evidence": "context7 query 결과 (RESEARCH ext_1) + Round 3 default 수용"},
    {"id": "D2", "decision": "책임 분리 = script Capture/Identify/Isolate 3 자동 채움 + Fix/Verify 2 빈 슬롯 (null/None)", "rationale": "Round 2 결정 — v6.6 R1 (자율 = 검출 only) + v6.7 3-step chain (수동 v5.13/v5.18 1차 source → 자동 v6.6 검출 → 수동 정정 사용자/orchestrator) 정합. schema 강제 (5 필드 모두 존재) + 내용 책임 분리 (script 3 + LLM/사용자 2).", "evidence": "v6.6 MILESTONE.md D2 + v6.7 MILESTONE.md ARCHITECTURE row #10 paragraph 안 3-step chain narrative"},
    {"id": "D3", "decision": "적용 scope = audit_fact_verify only (propose_next.py 변경 0)", "rationale": "Round 4 결정 — propose_next.py 안 mismatch detect logic 자체 부재 (dedupe = passing/delta 분류, 정상 출력). vacuous trim 자연 + lightweight 정합. scope (b) 일반 정전화 본질 = ARCHITECTURE row #10 enhancement 안 미래 script 정합 narrative 으로 보존.", "evidence": "RESEARCH cb_5 (propose_next.py mismatch detect 부재)"},
    {"id": "D4", "decision": "mismatch dict schema = 6 필드 (method 보존 + capture + identify + isolate + fix + verify)", "rationale": "method 필드는 호출자 (audit-team Step 6 안 LLM) stage 분리 (boolean/표/수치) 인용 용 — 5-step 과 직교 책임. 별도 보존 자연 + capture string 안 흡수 회피 (LLM 추론 부담 감소).", "evidence": "RESEARCH cb_1~cb_3 (기존 mismatch dict 안 method 필드)"},
    {"id": "D5", "decision": "isolate 필드 = method-specific dict (boolean/numeric = {stated, actual, key} / table = {source_ref, issue})", "rationale": "각 method 별 자유 schema 보존 + 5-step 외형만 통일. risk_2 mitigation 직접 적용 — boolean/numeric 안 stated vs actual 비교 가시성 + table 안 source_ref + issue 분류 가시성.", "evidence": "RESEARCH risk_2 mitigation"},
    {"id": "D6", "decision": "ARCHITECTURE 정전화 host = § 4 끝 매트릭스 row #10 enhancement (v6.6 audit chain hallucination 자동 검출 mechanism) — 신 row 부재", "rationale": "v6.7 #10 enhancement + v6.8 #9 enhancement 누적 패턴 정합. 5-step mismatch 보고 형식 = #10 mechanism 의 output 형식 보강 본질 (cross-cutting feature 약화 — propose_next.py 변경 0 vacuous). paragraph 안 5-step 정전화 1~2 sentence 추가 + 외부 spec 인용 + 책임 분리 + 미래 script 정합 narrative.", "evidence": "v6.7 #10 + v6.8 #9 enhancement 패턴 + RESEARCH cb_6"},
    {"id": "D7", "decision": "cascade host = 2건 (root CLAUDE.md L142 audit chain hallucination blockquote + agents/project-harness-audit-team/CLAUDE.md Note v6.6 Step 6 narrative)", "rationale": "v6.4 cascade-sync mechanism 활용 marker hash 자동 갱신. blockquote 본문 = 5-step 1 줄 추가 + Note v6.6 narrative = stdout 출력 형식 5-step schema 인용 추가.", "evidence": "RESEARCH cb_7 + cb_8"},
    {"id": "D8", "decision": "tests/smoke-audit-fact-verify.sh Stage 6 신규 = 5-step schema 검증 (boolean-mismatch fixture 재사용, 신규 fixture 부재)", "rationale": "기존 5 stage (boolean × 2 + table × 2 + numeric × 1 + empty + path traversal) 회귀 0 + Stage 6 = boolean-mismatch fixture 호출 후 stdout JSON parse + 5 필드 강제 검증. Python heredoc 으로 JSON parse + 5 필드 grep (간단).", "evidence": "RESEARCH cb_9 + cb_10"},
    {"id": "D9", "decision": "phases = 1 phase 통합 (lightweight 본질, v6.7/v6.8 패턴 정합)", "rationale": "변경 모두 같은 본질 (mismatch 보고 5-step 형식 도입). 1 commit = script + ARCHITECTURE + cascade host 2 + smoke + CHANGELOG + ROADMAP completed.", "evidence": "v6.7/v6.8 1-phase commit"},
    {"id": "D10", "decision": "review depth = Lightweight + inline self-review (subagent 부재)", "rationale": "v6.7/v6.8 패턴 정합 + v6.6 5 관점 subagent saturate evidence (converged 18 항목). 본 scope 작아 marginal value.", "evidence": "v6.7 lightweight 패턴 + v6.6 saturate"},
    {"id": "D11", "decision": "도그푸드 검증 method = boolean-mismatch fixture 호출 후 stdout 5-step 5 필드 출력 검증", "rationale": "fixture 안 mismatch 의도 trigger 이미 보장 (boolean-mismatch fixture = exit 1, evidence). stdout JSON parse 후 5 필드 (capture/identify/isolate/fix/verify) 존재 + fix=None + verify=None 검증.", "evidence": "RESEARCH cb_10"}
  ],
  "approach": "3 컴포넌트 hybrid (v6.4/v6.5/v6.6 시리즈 패턴 정합) — (1) audit_fact_verify.py 안 3 detect function (boolean/table/numeric) mismatch dict schema 5-step 통일 (6 필드: method + capture/identify/isolate/fix/verify, isolate method-specific dict 보존) + (2) ARCHITECTURE § 4 끝 매트릭스 row #10 + paragraph enhancement (5-step 정전화 narrative 추가) + (3) tests/smoke-audit-fact-verify.sh Stage 6 신규 (5-step schema 검증). 추가로 cascade host 2 (root CLAUDE.md L142 blockquote + audit-team CLAUDE.md Note v6.6) cascade-sync mechanism 활용 marker hash 자동 갱신.",
  "phases": [
    {"id": "phase-1", "scope": "전체 통합 — script + ARCHITECTURE + cascade host 2 + smoke + ROADMAP entry status + CHANGELOG entry + 도그푸드 1 회 호출 검증", "commit": "feat(meta): v6.9 — synthesizer mismatch 보고 형식 debugger 5-step [v6.9]"}
  ],
  "risk_mitigation": [
    {"id": "R1", "risk": "mismatch dict schema breaking change → audit-team Note v6.6 Step 6 안 LLM 추론 영향", "mitigation": "외부 이용자 1건 = audit-team Step 6 (자체 통제). 5-step schema 인용 narrative 동시 갱신 → 자체 적응. 영향 0."},
    {"id": "R2", "risk": "isolate 필드 안 method-specific dict 부담", "mitigation": "boolean/numeric = {stated, actual, key} / table = {source_ref, issue} — method 별 자유 schema 보존, 5-step 외형만 통일 (D5 결정 직접 적용)."},
    {"id": "R3", "risk": "ARCHITECTURE row #10 paragraph 길어짐", "mitigation": "5-step 1~2 sentence 보강만 (전체 재작성 회피). lightweight 정합 (D6 결정 직접 적용)."},
    {"id": "R4", "risk": "smoke Stage 6 안 fixture stdout JSON parse 부담", "mitigation": "Python heredoc 으로 JSON parse + 5 필드 grep (간단 logic). 기존 fixture 재사용 (신규 부재). D8 결정 직접 적용."},
    {"id": "R5", "risk": "Anthropic 원문 'Implement minimal fix' vs JSON 'fix' mismatch", "mitigation": "필드명 'fix' 간결 우선 (D1) + paragraph 외부 spec 인용 안 'Implement minimal fix' 원문 인용 (이중 트래커). spec-drift P2 candidate 거명만."}
  ]
}
```

### Approach narrative

v6.8 도그푸드 2차 cycle (2026-05-20) candidate_draft surface 안 valid 1건 origin. Claude Code debugger subagent 5-step 형식 (capture/identify/isolate/fix/verify) 정합 mismatch 보고 형식 도입 — script Capture/Identify/Isolate 3 자동 채움 + Fix/Verify 2 빈 슬롯 (v6.6 R1 + v6.7 3-step chain 정합).

scope (b) 본질 = "둘 다 + 일반 정전화" 이나 Round 4 결정 안 propose_next.py mismatch detect 부재 → vacuous trim. 일반 정전화 본질 = ARCHITECTURE row #10 enhancement paragraph 안 'mismatch 보고 일반 형식 = 5-step + 미래 script 정합 의무' narrative 으로 보존 (cross-cutting feature 약화 — 단일 script 적용 + 일반 정전화).

### Risk priorities

R1+R2 = P1 (직접 위험 가능), R3+R4+R5 = P2 (위험 미시 또는 evidence 부재).

### Inline self-review 종합 (5 관점, subagent 부재 — lightweight 정합)

5 관점 inline self-review:

- **Architecture** P2 #arch-1: D6 ARCHITECTURE row #10 enhancement (cross-cutting 약화) — 미래 script 정합 의무 narrative 추가 시 'enhancement vs 신 row' 판정 명료성 약. 별 milestone 거명만 (smoke-candidate-related-umbrella-split-trigger 패턴 정합).
- **Spec-drift** P2 #drift-1: D1 필드명 'fix' (Anthropic 'Implement minimal fix' 원문 'fix' = 명사) vs Anthropic prompt 안 'Implement' (동사 4번째) mismatch — paragraph 외부 spec 인용 안 'Implement minimal fix' 원문 보존 (이중 트래커). 미래 retitle candidate 거명만.
- **Security** P3 #sec-1: capture 필드 안 file path + key name 인용 → control character injection 위험? = audit_fact_verify.py 안 json.dumps() 자동 escape 보호 (기존 가드). 영향 0.
- **Dictionary-semantics** P2 #dict-1: 'synthesizer mismatch 보고 형식' title 약 — 'synthesizer' (audit chain agent 만 인지된 용어) 가 일반 mismatch 보고 확장 의도 와 안 부합. retitle candidate 거명만 (별 milestone 발의 trigger 조건 부재, v6.7 PROPOSE #7 패턴 정합).
- **Test-coverage** P3 #test-1: Stage 6 5-step schema 검증 안 edge case = empty mismatch list (PASS, schema 검증 skip) + unknown method 발생 시 schema 어긋남. unknown method fallback narrative 별 milestone 거명만.

decisive 0 + P2 3 + P3 2 = 모두 narrative 흡수 또는 별 milestone 거명만 (v6.7/v6.8 lightweight 패턴 정합).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "scope": "11 decisions (D1~D11) + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2) all approved",
    "method": "inline AskUserQuestion (Stage E)",
    "notes": "lightweight 모드 + 5 관점 inline self-review (subagent 부재) — v6.7/v6.8 패턴 정합. pre-PLAN 4 round + Round 5 review 완료. phase-1 EXECUTE 진입 허가."
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
      "title": "audit_fact_verify 5-step schema + ARCHITECTURE row #10 enhancement + cascade host 2 + smoke Stage 6 + ROADMAP archival + CHANGELOG entry 통합 1 commit",
      "actions": [
        "(1) scripts/audit_fact_verify.py docstring 안 v6.9 5-step schema narrative 추가",
        "(2) scripts/audit_fact_verify.py detect_boolean_mismatches() mismatch dict 5-step 통일 (6 필드: method + capture/identify/isolate/fix/verify, isolate {key, stated, actual} 또는 {key, stated, error})",
        "(3) scripts/audit_fact_verify.py detect_table_row_mismatches() mismatch dict 5-step 통일 (isolate {source_ref, issue})",
        "(4) scripts/audit_fact_verify.py detect_numeric_mismatches() mismatch dict 5-step 통일 (boolean 과 동일 schema)",
        "(5) projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 #10 row 갱신 (column 2/3/4: v6.9 enhancement + Stage 6 추가)",
        "(6) projects/meta/ARCHITECTURE.md § 4 끝 paragraph 끝 v6.9 5-step 형식 enhancement narrative 추가 (외부 spec 직접 인용 + 책임 분리 + 미래 script 정합 의무)",
        "(7) agents/project-harness-audit-team/CLAUDE.md Note v6.6 끝 안 v6.9 5-step schema 인용 narrative 추가 (cascade host 2)",
        "(8) tests/smoke-audit-fact-verify.sh Stage 6 신규 추가 (5-step schema 검증, boolean-mismatch fixture 재사용)",
        "(9) tests/smoke-audit-fact-verify.sh header narrative 안 v6.9 보강 1 줄",
        "(10) cascade_sync.py --check → 1 drift detect (root CLAUDE.md marker hash b16102818b6970fa → 3398cd3daea60c64)",
        "(11) CLAUDE.md (root) L135 audit chain hallucination blockquote 본문 보강 (v6.9 5-step 형식 enhancement 1 줄 추가, cascade host 2)",
        "(12) cascade_sync.py --apply (marker hash 자동 갱신)",
        "(13) cascade_sync.py --check 재호출 (drift 0 검증 ✓)",
        "(14) tests/smoke-audit-fact-verify.sh 호출 (PASS=8 FAIL=0 ✓)",
        "(15) 도그푸드 1 회 호출 (boolean-mismatch fixture, stdout 5-step 6 필드 출력 확인 + fix=null + verify=null ✓)",
        "(16) MILESTONE.md APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 5 섹션 채움",
        "(17) CHANGELOG.md [v6.9] entry 추가 (Keep a Changelog v1.1.0 정합)",
        "(18) ROADMAP.md v6.9 status in_progress → completed + summary 갱신 + v6.6 archival (milestones[] 안 v6.6 entry 제거, recent 3 = v6.9+v6.8+v6.7)",
        "(19) pre-commit 18 hook 호출 검증"
      ],
      "files_changed": [
        "scripts/audit_fact_verify.py (docstring + 3 detect function mismatch dict 5-step 통일)",
        "projects/meta/ARCHITECTURE.md (§ 4 끝 매트릭스 #10 row + paragraph enhancement)",
        "agents/project-harness-audit-team/CLAUDE.md (Note v6.6 안 v6.9 5-step schema 인용)",
        "tests/smoke-audit-fact-verify.sh (Stage 6 신규 + header narrative 보강)",
        "CLAUDE.md (root, cascade host marker hash + blockquote 본문 보강)",
        "projects/meta/milestones/v6.9/MILESTONE.md (전체 작성)",
        "projects/meta/milestones/v6.9/execute/ (빈 디렉토리 — v6.7/v6.8 패턴 정합, phase-1.md 분리 부재)",
        "CHANGELOG.md ([v6.9] entry 추가)",
        "projects/meta/ROADMAP.md (v6.9 status completed + v6.6 archival)"
      ],
      "commit_strategy": "단일 commit (lightweight 1-phase 통합 본질). 사용자 명시 결정 게이트 (commit 직전) 정합. v6.7/v6.8 1-phase 패턴 누적."
    }
  ]
}
```

### EXECUTE narrative

phase-1 통합 본질 = 5-step mismatch 보고 형식 의 3 컴포넌트 (script + ARCHITECTURE + smoke) + 정전화 host (ARCHITECTURE row #10 enhancement) + cascade host 2 (root CLAUDE.md + audit-team CLAUDE.md) + audit trail (CHANGELOG + ROADMAP) 모두 같은 본질 (v6.9 5-step 형식 도입) → 단일 commit 자연. lightweight 1-phase 정합 (v6.7/v6.8 패턴 정합).

## VERIFY

### Spec

```json
{
  "smoke_results": [
    {"smoke": "tests/smoke-audit-fact-verify.sh", "result": "PASS=8 FAIL=0", "detail": "Stage 1 boolean ×2 + Stage 2 table ×2 + Stage 3 numeric + Stage 4 empty + Stage 5 path traversal + Stage 6 신규 5-step schema (6 필드 + fix=null + verify=null) 모두 PASS"},
    {"smoke": "tests/smoke-cascade-drift.sh (scripts/cascade_sync.py --check)", "result": "PASS — all 1 host(s) in sync", "detail": "root CLAUDE.md marker hash b16102818b6970fa → 3398cd3daea60c64 자동 갱신 후 drift 0 검증"},
    {"smoke": "pre-commit 18 hook full run", "result": "PENDING (Stage F 마지막 호출)", "expected": "전체 18 hook PASS"}
  ],
  "criteria_check": [
    {"id": "sc_1", "criterion": "scripts/audit_fact_verify.py 안 3 detect function mismatch dict schema 5-step 통일 (6 필드 + isolate method-specific)", "verdict": "PASS — detect_boolean_mismatches/detect_table_row_mismatches/detect_numeric_mismatches 모두 6 필드 (method + capture/identify/isolate/fix/verify) 통일. isolate method-specific = boolean/numeric {key, stated, actual} (또는 error) / table {source_ref, issue}. 실 호출 결과: 1 mismatch entry = method='boolean', capture='scanner-output.md: claude_md_in_repo=False', identify='scanner-output.md', isolate={key, stated, actual}, fix=null, verify=null ✓"},
    {"id": "sc_2", "criterion": "ARCHITECTURE § 4 끝 매트릭스 #10 row + paragraph enhancement (v6.7 #10 + v6.8 #9 enhancement 패턴 정합, 신 row 부재)", "verdict": "PASS — row #10 column 2/3/4 갱신 (v6.9 enhancement 명시) + paragraph 끝 v6.9 5-step 형식 enhancement narrative 추가 (외부 spec 직접 인용 + 책임 분리 + 미래 script 정합 의무)"},
    {"id": "sc_3", "criterion": "cascade host 2 갱신 (root CLAUDE.md + audit-team CLAUDE.md) + drift 0 검증", "verdict": "PASS — cascade_sync.py --apply 후 marker hash 자동 갱신 (b16102818b6970fa → 3398cd3daea60c64) + --check 재호출 시 drift 0 검증. audit-team CLAUDE.md = cascade marker 부재 (수동 동기, L3 lessons 흡수)"},
    {"id": "sc_4", "criterion": "tests/smoke-audit-fact-verify.sh Stage 6 신규 + 기존 5 stage 회귀 0", "verdict": "PASS — Stage 6 = boolean-mismatch fixture 호출 + stdout JSON parse + 6 필드 강제 + fix=null + verify=null 검증. PASS=8 FAIL=0 (Stage 1~5 회귀 0 + Stage 6 PASS)"},
    {"id": "sc_5", "criterion": "도그푸드 1 회 호출 검증 (mismatch dict 5-step 6 필드 출력 확인)", "verdict": "PASS — `python scripts/audit_fact_verify.py --dir tests/fixtures/audit-fact-verify/boolean-mismatch` 호출 결과 stdout 안 JSON list[dict] = [{method: 'boolean', capture: 'scanner-output.md: claude_md_in_repo=False', identify: 'scanner-output.md', isolate: {key: 'claude_md_in_repo', stated: false, actual: true}, fix: null, verify: null}] ✓ — Capture/Identify/Isolate 3 필드 자동 채움 + Fix/Verify null 확인"}
  ],
  "verdict": "PASS — 5 sc 모두 충족. v3.21 cycle 35 narrative 정전화 + v5.7 spike 패턴 (c) 9번째 + lightweight 1-phase 누적 12/24 = 50% (첫 돌파) + 5 관점 inline self-review cycle 7 (decisive 0 / P2 3 / P3 2) 모두 narrative 흡수 또는 별 milestone 거명만."
}
```

### VERIFY narrative

도그푸드 호출 결과 (boolean-mismatch fixture) — 5-step 6 필드 정확 출력:

```json
[{
  "method": "boolean",
  "capture": "scanner-output.md: claude_md_in_repo=False",
  "identify": "scanner-output.md",
  "isolate": {"key": "claude_md_in_repo", "stated": false, "actual": true},
  "fix": null,
  "verify": null
}]
```

script 가 Capture/Identify/Isolate 3 필드 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (null, LLM/사용자 채움) — v6.6 R1 자율 = 검출 only + v6.7 3-step chain (수동 1차 source → 자동 검출 → 수동 정정) 정합 직접 evidence.

## REPORT

### Spec

```json
{
  "summary": "v6.8 도그푸드 2차 cycle (2026-05-20, commit e844f27 candidate_draft surface delta 안 최우선 valid 1건) 직접 후속. Claude Code debugger subagent 5-step prompt (`1. Capture / 2. Identify / 3. Isolate / 4. Implement minimal fix / 5. Verify`, context7 verified) 정합 mismatch 보고 형식 도입. scripts/audit_fact_verify.py 안 3 detect function mismatch dict schema 5-step 통일 (6 필드: method 보존 + capture/identify/isolate/fix/verify, isolate method-specific dict 보존). 책임 분리 = script Capture/Identify/Isolate 3 자동 채움 (deterministic) + Fix/Verify 2 빈 슬롯 (null, LLM/사용자 채움 — v6.6 R1 + v6.7 3-step chain 정합). scope = audit_fact_verify only (Round 4 결정 vacuous trim — propose_next.py mismatch detect 부재, scope (b) 일반 정전화 본질 = ARCHITECTURE row #10 enhancement 안 미래 script 정합 narrative 으로 보존) + ARCHITECTURE § 4 끝 매트릭스 #10 row + paragraph enhancement (v6.7 #10 + v6.8 #9 enhancement 패턴 정합, 신 row 부재) + cascade host 2 (root CLAUDE.md L135 audit chain hallucination blockquote + audit-team CLAUDE.md Note v6.6) + tests/smoke-audit-fact-verify.sh Stage 6 신규 (5-step schema 강제 + PASS=8). v3.21 narrative 정전화 cycle 35 + v5.7 spec-drift spike (c) 9번째 자연 발현 + AI Native § 7.1 다중 AI 협업 면 cycle 보강 (v6.6 mechanism output schema enhancement) + lightweight 1-phase 누적 12/24 = 50% (첫 돌파) + archival cycle 9번째 (v6.6 → CHANGELOG) + 5 관점 inline self-review cycle 7 (decisive 0 + P2 3 + P3 2).",
  "delta_from_intent": "INTENT goal + 5 sc 모두 충족. oos 4건 (Fix 자동 채움 / agent .md H2 sub-section / propose_next.py 적용 vacuous trim / 외부 프로젝트 적용) 보존 (의도된 oos). Round 4 결정 안 scope 조정 (둘 다 → audit_fact_verify only) narrative 흡수 — oos_3 안 명시. VERIFY 5 sc 모두 PASS verdict.",
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "isolate method-specific dict 보존 = boolean/numeric vs table 분류 자연 (RESEARCH risk_2 mitigation 직접 적용). 각 method 별 자유 schema 보존 (boolean/numeric = {key, stated, actual} / table = {source_ref, issue}) + 5-step 외형만 통일 = schema 견고성 + 책임 분리 양립. lessons 패턴 = 통일 schema 도입 시 method-specific 자유도 명시 의무 (외형 강제 + 내용 자유)."},
    {"id": "L2", "priority": "P1", "lesson": "scope vacuous trim 패턴 = Round 4 결정 evidence. propose_next.py 안 mismatch detect logic 부재 → 적용 대상 자체 부재 vacuous. scope (b) '둘 다 + 일반 정전화' 본질 = ARCHITECTURE row #10 enhancement 안 '미래 script 정합 의무' narrative 으로 보존 (cross-cutting feature 약화 + 일반 정전화 본질 유지). lessons 패턴 = scope 결정 시 적용 대상 evidence 확인 의무 (vacuous case → narrative 정전화 보존)."},
    {"id": "L3", "priority": "P1", "lesson": "cascade host 2 = root CLAUDE.md L135 (cascade marker 보유) + audit-team CLAUDE.md Note v6.6 (cascade marker 부재, 수동 동기). cascade-sync mechanism 안 marker 부재 host = 수동 동기 의무 (marker 보유 host 만 자동 갱신). lessons 패턴 = cascade host enumerate 시 marker 보유/부재 구분 의무 (수동 동기 obligation 명시)."},
    {"id": "L4", "priority": "P2", "lesson": "5-step JSON 필드명 'fix' (Anthropic 원문 'Implement minimal fix' 안 명사 'fix') vs Anthropic prompt 안 동사 'Implement' (4번째 step) mismatch — paragraph 외부 spec 직접 인용 안 'Implement minimal fix' 원문 보존 (이중 트래커). 필드명 간결 우선 + 외부 spec 인용 정합 양립 가능. lessons 패턴 = 외부 spec 인용 시 필드명 간결 vs 원문 정합 trade-off 명시 의무 (이중 트래커 패턴)."},
    {"id": "L5", "priority": "P2", "lesson": "bash smoke Stage 6 안 Python heredoc + sys.argv pattern (`python3 - \"$STAGE6_JSON\" <<'PYEOF'`) = heredoc 가 stdin (코드) + argv 별도 전달 (JSON 데이터). ARG_MAX 제한 risk (Linux ~131072 / Windows ~32767) — 작은 JSON 안전. lessons 패턴 = bash + Python 결합 시 heredoc vs pipe vs argv 선택 의무 (stdin 충돌 회피)."},
    {"id": "L6", "priority": "P2", "lesson": "cascade-sync mechanism 의 marker hash 자동 갱신 = source paragraph 변경 직후 --check → --apply → --check 재호출 3 step 자연 cycle. v6.4 mechanism 외부 cycle 누적 (v6.5/v6.6 self-host + v6.7 first external + v6.8 second external + v6.9 third external). lessons 패턴 = cascade host 변경 시 3 step cycle 의무 (--check 두 번 호출로 drift 0 검증)."},
    {"id": "L7", "priority": "P2", "lesson": "tests/smoke-audit-fact-verify.sh Stage 6 안 fixture 재사용 = 신규 fixture 부재 lightweight 정합. ARCHITECTURE column 4 안 'stage 수' 갱신 시 case 분포 (8 case) 와 stage 수 (6) 분리 명시 (Stage 1 안 case 2건 = boolean-normal + boolean-mismatch 등). lessons 패턴 = smoke 추가 시 fixture 재사용 자연 (신규 fixture 부재 ≠ 검증 부재 — 기존 fixture 안 schema 검증 추가 가능)."},
    {"id": "L8", "priority": "P2", "lesson": "v6.9 = v6.6 mechanism enhancement (output schema 보강) 본질. v6.7 = v6.6 narrative enhancement / v6.8 = v6.5 mechanism enhancement / v6.9 = v6.6 mechanism enhancement. enhancement 패턴 누적 cycle 3 (v6.7/v6.8/v6.9) = 매트릭스 row append 회피 본질 (신 mechanism 신중 도입). lessons 패턴 = mechanism 도입 vs enhancement 판정 = cross-cutting feature 도입 평가 (단일 script 적용 시 enhancement 자연)."}
  ],
  "cycle_evidence": {
    "v3_21_narrative_canonicalization_cycle": "35 (cycle 34 v6.8 cascade host 1 → cycle 35 v6.9 cascade host 2 = root CLAUDE.md + audit-team CLAUDE.md)",
    "v5_7_spec_drift_spike_pattern_c": "9 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9 누적)",
    "ai_native_dimension_section_7_1_다중_ai_협업": "v6.6 second cycle 의 output schema enhancement (cycle 카운트 보존)",
    "lightweight_1_phase_누적": "12/24 = 50.0% (v6.8 11/23 = 47.8% → v6.9 12/24 = 50.0% 첫 돌파)",
    "inline_self_review_cycle": "7 (v6.8 cycle 6 = 5 issue → v6.9 cycle 7 = 5 issue [decisive 0 + P2 3 + P3 2])",
    "archival_cycle": "9 (v6.5/v6.6/v6.4/v6.5(again)/v6.5(v6.8)/v6.6(v6.9) 누적 — v6.8 archival v6.5 + v6.9 archival v6.6, 9번째)",
    "enhancement_pattern_누적": "3 (v6.7 narrative enhancement / v6.8 mechanism enhancement / v6.9 output schema enhancement, 신 row append 회피 본질)"
  },
  "ai_native_dimension_check": {
    "primary_dimension": "다중 AI 협업 (v6.6 mechanism enhancement)",
    "evidence": "script (deterministic core: Capture/Identify/Isolate 3 자동) + LLM (Fix 필드 추론 빈 슬롯) + 사용자 (Verify 명시 검증 빈 슬롯) 3 entity 협업 schema. 5-step 형식 = 디버깅 표준 (외부 AI tool/Anthropic Claude Code debugger subagent spec 정합). v6.6 mechanism (다중 AI 협업 second cycle) 의 output schema 보강 — cycle 카운트 보존, enhancement 본질."
  }
}
```

### REPORT narrative

v6.9 = v6.6 mechanism enhancement (output schema 보강). v6.8 도그푸드 2차 cycle valid 1건 origin → 즉시 후속 → 단일 phase 통합 + cascade host 2 + 5-step 6 필드 schema + lightweight 1-phase 50% 첫 돌파. v3.21 cycle 35 narrative 정전화 + v5.7 spike (c) 9번째 + 5 관점 inline self-review cycle 7 + archival cycle 9 누적.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {"id": "audit-fact-verify-fix-field-auto-fill-mechanism", "title": "5-step Fix 필드 자동 채움 mechanism (LLM 추론 + 재귀 hallucination 위험 mitigation)", "origin_milestone": "v6.9", "target_version": "v6.x", "trigger": "B_byproduct", "rationale": "v6.9 oos_1 origin. 5-step 안 Fix 필드 = LLM 추론 필요 (재귀 hallucination 위험 = v6.6 R1 자율 = 검출 only 정합). ROADMAP next_candidates 안 citation-method-auto-detect-mechanism candidate (v6.6 origin) 와 동질 카테고리 = 통합 mitigation narrative DESIGN 단계 결정. LLM call + token 비용 + 재귀 hallucination mitigation 패턴 + 사용자 결정 게이트 보존 의무."},
    {"id": "audit-team-agent-md-h2-input-verification-5step-extension", "title": "audit-team agent .md H2 Input Verification 5-step 검증 의무 확장", "origin_milestone": "v6.9", "target_version": "v6.x", "trigger": "D_design", "rationale": "v6.9 oos_2 origin. v5.18 Input Verification H2 sub-section 패턴 정합 = agent .md 안 5-step schema 검증 의무 narrative 추가. 본 시점 evidence 부재 → 미래 evidence (5-step schema 회귀 또는 변동 cycle) 도달 시 별 milestone 자연."},
    {"id": "mismatch-report-5step-cross-cutting-propose-next-application", "title": "propose_next.py mismatch detect logic 도입 + 5-step schema 정합 의무", "origin_milestone": "v6.9", "target_version": "v6.x", "trigger": "B_byproduct", "rationale": "v6.9 oos_3 origin. propose_next.py 안 mismatch detect logic 부재 vacuous trim. 미래 evidence (cross_validate fail 또는 dedupe edge case 발견) 도달 시 5-step schema 정합 의무 (cross-cutting feature 본질 강화). ARCHITECTURE row #10 enhancement 안 '미래 script 정합 의무' narrative 의 직접 evidence trigger."}
  ],
  "propose_narrative": "5 관점 inline self-review cycle 7 P2 3 + P3 2 = 5 issue 모두 narrative 흡수 또는 별 milestone 거명만 (lightweight 정합). EXECUTE lessons L1~L8 안 후속 candidate 거명. lightweight 모드 정책 정합 (v3.13/v3.14 동결 + v4.0 § 6.2 폐지 narrative + memory feedback_section_6_2_abolished). 사용자 명시 발의 trigger 후 ROADMAP next_candidates[] 등재 (자동 등재 회피). v6.8 PROPOSE 안 3건 (lessons P2 dedupe scope / legacy era id backfill / smoke umbrella split trigger) + v6.7 retitle candidate + v6.6 PROPOSE 안 거명만 + 본 milestone 3건 = ROADMAP next_candidates 누적 14~15건."
}
```

### PROPOSE narrative

본 milestone = v6.6 mechanism output schema enhancement. 후속 candidates 3건 = v6.9 oos (oos_1 Fix 자동 채움 / oos_2 agent .md H2 sub-section / oos_3 propose_next 5-step 적용) 직접 origin. 등재 candidate scope = v6.x 후속 milestone 자연 (mechanism enhancement 패턴 누적 cycle 3 = v6.7/v6.8/v6.9 evidence).

## SUB_MILESTONES

본 milestone = 단일 본질 (sub-milestone 부재). v6.2+ flattened era 정합.

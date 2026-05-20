---
id: propose-next-surface-dedupe-mechanism
title: /propose-next surface 자동 dedupe mechanism
version: v6.8
status: in_progress
---

# v6.8 — /propose-next surface 자동 dedupe mechanism

## INTENT

### Spec

```json
{
  "id": "propose-next-surface-dedupe-mechanism",
  "title": "/propose-next surface 자동 dedupe mechanism",
  "goal": "v6.5 mechanism 외부 cycle 1 evidence (2026-05-20) — scan 출력 안 enumerated_milestones 9건 중 8건 (89%) 이 이미 ROADMAP next_candidates[] 안 등재 → LLM surface 시 duplicate 위험. scripts/propose_next.py 안 dedupe logic 직접 도입 (deterministic, LLM 누락 risk 0) + claude/commands/propose-next.md Step 2 prompt 재정의 (delta 우선 surface + passing 통계 only) + ARCHITECTURE § 4 끝 #9 paragraph 안 dedupe narrative 보강 (v3.21 narrative 정전화 3 단계 패턴 cycle 34 자연 발현). matching key = id 우선 + title fallback (PROPOSE schema 변동 era 안전망). dedupe scope = next_candidates[] + candidate_draft[] 양쪽 (이미 인지한 후보 통합 의미 — buffer 안 entry 재 surface 위험 0).",
  "success_criteria": [
    {"id": "sc_1", "description": "scripts/propose_next.py 안 dedupe logic 도입 — id 우선 + title fallback matching key + next_candidates[] + candidate_draft[] 양쪽 scope. PROPOSE entries 안 id + title 추출 (regex 확장) + cross-ref 후 candidate_items[].status 'delta' | 'passing' 분류. 기존 candidate_titles (list of strings) → candidate_items (list of {id, title, status}) breaking change (외부 이용자 1건 = slash command 안 LLM Bash 호출만, 자체 통제)."},
    {"id": "sc_2", "description": "claude/commands/propose-next.md Step 2 prompt 재정의 — delta 우선 surface (status: delta 안 최우선 1건 우선 보고) + passing 통계 only ('이미 N건 등재 (passing). 신규 M건 (delta) 우선 검토.' narrative). 비유 표현 가이드 (D12 dialog) 정합 — passing = '이미 인지한 후보 (등재 또는 buffer)', delta = '신규 surface 대상'."},
    {"id": "sc_3", "description": "ARCHITECTURE § 4 끝 매트릭스 #9 row + paragraph 안 dedupe 본질 보강 (v6.4 #8 + v6.5 #9 + v6.6 #10 시리즈 정전화 host 패턴 정합). v3.21 narrative 정전화 3 단계 패턴 cycle 34 자연 발현 — (a) DESIGN 1차 (본 MILESTONE.md ## DESIGN) + (b) EXECUTE Edit (ARCHITECTURE) + (c) VERIFY grep. cascade host 1 = root CLAUDE.md propose-next blockquote 본문 1 줄 갱신."},
    {"id": "sc_4", "description": "tests/smoke-candidate-draft-schema.sh 안 신 candidate_items schema 강제 (또는 별 smoke 분리 = DESIGN 안 결정). v6.5 smoke pattern 정합 — fixture 부재 read-only logic 검증. 회귀 0 — 기존 17 smoke 모두 PASS."},
    {"id": "sc_5", "description": "도그푸드 1 회 호출 검증 — /propose-next --scan 호출 후 출력 안 delta count + passing count 확인 + LLM Step 2 안 'delta 우선' narrative 실 surface 검증. v6.5 외부 cycle 1 evidence 와 비교 — 89% duplicate → 0% duplicate 본질 도달 검증."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "PROPOSE entries 안 id 부재 era (v3~v5) 의 자동 backfill", "reason": "Round 2-1 결정 (2026-05-20) — id 우선 + title fallback 로 legacy era PROPOSE 안 id 부재 안전 처리. 자동 backfill = scope 확장 (별 milestone)."},
    {"id": "oos_2", "item": "candidate_draft → next_candidates promote 자동화 (사용자 결정 게이트 제거)", "reason": "v6.5 R1 정합 (자율 = candidate 제안까지만). promote 자체는 사용자 명시 결정 게이트 보존 의무."},
    {"id": "oos_3", "item": "lessons_learned P2 라벨 항목 dedupe scope 포함", "reason": "현재 enumerated_milestones 출력 안 lessons_p2_count (count only). title/id 추출 부재 → dedupe 대상 자체 부재. 도달 시 별 milestone (script 안 P2 항목 title 추출 logic 추가)."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "scripts/propose_next.py (v6.5 origin)", "purpose": "본 mechanism dedupe logic 추가 host"},
    {"id": "dep_2", "source": "claude/commands/propose-next.md (v6.5 origin)", "purpose": "Step 2 prompt 재정의 host"},
    {"id": "dep_3", "source": "projects/meta/ARCHITECTURE.md § 4 끝 #9 paragraph", "purpose": "dedupe narrative 보강 정전화 host (v3.21 패턴 cycle 34)"},
    {"id": "dep_4", "source": "ROADMAP candidate_draft[0] = propose-next-roadmap-next-candidates-dedupe", "purpose": "본 milestone origin candidate (v6.5 mechanism 외부 cycle 1 evidence, 2026-05-20)"}
  ]
}
```

### Motivation

v6.5 Claude 자율 milestone 발의 mechanism 도입 (2026-05-20) 후 첫 외부 활용 session (2026-05-20, commit ed44bed) 안 직접 evidence 발생 — `/propose-next --scan` 출력 안 `enumerated_milestones` (최근 5 milestone PROPOSE 안 candidate titles) 9건 중 8건 (89%) 이 이미 `roadmap_next_candidates` 안 등재. 사용자가 surface 도중 duplicate 인지 + 결정 보류 → 1건만 candidate_draft append. memory `feedback_propose_next_dedupe_check` (2026-05-20) 안 직접 evidence 기록.

**본질 진단** (pre-PLAN Round 1, 2026-05-20):

PROPOSE `candidates_named_only` → ROADMAP `next_candidates[]` promote 는 표준 flow → 자연히 8/9 (89%) duplicate 가 정상. 실제 "신규 surface 대상" 은 **PROPOSE 안 거명되나 아직 next_candidates 미등재** 의 delta 만이어야 자연. 단순 LLM cross-check (옵션 a) 안 본질 부재 — script 자체가 enumerated 를 둘로 분리 (옵션 b+) 해야 deterministic + token cost 0 + LLM 누락 risk 0 도달.

### Out of scope rationale

oos_1: PROPOSE entries 안 id 보유 표준이 v6.x era 누적이나 v3~v5 era 안 id 부재 가능. title fallback 안전망 보존 — 자동 backfill 은 scope 확장.

oos_2: v6.5 R1 정합 (자율 = candidate 제안까지만, 사용자 결정 게이트 보존). promote 자동화는 evidence 부재.

oos_3: 현 script lessons_p2_count = count only (title/id 추출 부재). dedupe 대상 부재.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code spec (context7) — dedupe/enumerate filter 표준 패턴 query", "verdict": "DEFERRED (script-only deterministic logic, 외부 spec 의존 부재). v6.4/v6.5/v6.6 시리즈 자체 정전화 패턴 정합 — 본 mechanism 도 자체 정전화 자연. v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 8번째 자연 발현 후보."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "scripts/propose_next.py:56-67", "fact": "NAMED_ONLY_REGEX (line 56-58) + TITLE_REGEX (line 66) — title 만 추출. id 추출 부재. dedupe matching key 추가 시 ID_REGEX 신설 의무."},
    {"id": "cb_2", "file": "scripts/propose_next.py:117-126", "fact": "grep_named_only() — TITLE_REGEX.findall(inner) 으로 title 리스트만 반환. {id, title} pair 반환 으로 확장 의무. type signature: list[str] → list[dict]."},
    {"id": "cb_3", "file": "scripts/propose_next.py:152-197", "fact": "cmd_scan() — proposals_by_milestone[].candidate_titles (list of str) 출력. dedupe 부재. roadmap_next_candidates + candidate_draft_count 별 필드 출력. matching scope 확장 의무 = candidate_draft entries 도 cross-ref."},
    {"id": "cb_4", "file": "claude/commands/propose-next.md:30-50", "fact": "Step 2 — 'JSON 분석 후 사용자에게 최우선 1 candidate 우선 보고' narrative. dedupe 절차 부재. delta 우선 surface + passing 통계 only narrative 추가 의무."},
    {"id": "cb_5", "file": "projects/meta/ROADMAP.md:9-19 (commit ed44bed)", "fact": "candidate_draft[0] = propose-next-roadmap-next-candidates-dedupe (2026-05-20). v6.5 mechanism 외부 cycle 1 evidence (surface 9건 중 8건 duplicate, 89%) origin."},
    {"id": "cb_6", "file": "projects/meta/milestones/v6.6/MILESTONE.md + v6.7/MILESTONE.md PROPOSE next_candidates", "fact": "PROPOSE entries 안 id + title 둘 다 보유 확인 (v6.x era 표준). matching key id 우선 + title fallback 안전."},
    {"id": "cb_7", "file": "projects/meta/ARCHITECTURE.md:131-146 (§ 4 끝 누적 매트릭스)", "fact": "row #1~#10 누적. v6.6 row #10 last. v6.8 → row #11 append 의무 (v3.21 narrative 정전화 3 단계 패턴 (b) EXECUTE Edit 자동 동기)."},
    {"id": "cb_8", "file": "projects/meta/ARCHITECTURE.md:168 (§ 4 끝 #9 paragraph)", "fact": "Claude 자율 milestone 발의 mechanism 정전화 paragraph. dedupe 본질 보강 의무 (책임 분리 narrative 추가 — passing/delta 분류 = script / surface 우선 = LLM)."},
    {"id": "cb_9", "file": "tests/smoke-candidate-draft-schema.sh:43-99", "fact": "현 책임 = ROADMAP candidate_draft[] 7 필드 + category enum 강제 (Stage 1 only). 본 mechanism = script stdout candidate_items schema 검증 (별 source / 같은 'candidate-related schema' umbrella) → Stage 2 자연 확장."},
    {"id": "cb_10", "file": "claude/CLAUDE.md (root) 안 propose-next blockquote", "fact": "v6.5 mechanism 1 줄 blockquote 본문 보유 — dedupe 본질 narrative 1 줄 cascade host 추가 의무 (cascade-sync mechanism 자동 적용)."}
  ],
  "options": [
    {"id": "opt_a", "label": "Prompt 명시", "verdict": "REJECTED (Round 1) — LLM cross-check 매 호출 token cost + 누락 risk 존속 (89%→0% 보장 불가)"},
    {"id": "opt_b", "label": "Script 필드 (already_in_next_candidates_ids 추가)", "verdict": "REJECTED → 진화 (Round 1) — 단순 표지 추가는 LLM surface 책임 보존, surface 자체 dedupe 부재"},
    {"id": "opt_b_plus", "label": "Script 자체 enumerated 둘로 분리 (passing/delta status)", "verdict": "ACCEPTED (Round 1) — 본질적 해결 deterministic + LLM 누락 risk 0 + token cost 0"},
    {"id": "opt_c", "label": "Hybrid (b+ script + a prompt)", "verdict": "REJECTED (Round 1) — over-engineering, script 자체 deterministic 시 prompt 처리 자연 폐기"}
  ],
  "risks_identified": [
    {"id": "risk_1", "item": "matching key drift (id rephrase vs title rephrase)", "mitigation": "id 우선 + title fallback (Round 2-1) — PROPOSE entries 안 id 보유 era 안 robust, legacy era (v3~v5) 안 title fallback 안전망"},
    {"id": "risk_2", "item": "passing 정보 부재 risk (β 옵션 hide)", "mitigation": "α 옵션 채택 (Round 3-2) — passing 통계 narrative 보존 (cross-validate 안전 렌즈)"},
    {"id": "risk_3", "item": "candidate_items breaking change (외부 이용자 영향)", "mitigation": "외부 이용자 1건 = slash command 안 LLM Bash 호출만 (자체 통제) → 영향 0"},
    {"id": "risk_4", "item": "smoke 책임 확장 시 'era 분류 vs entry schema 혼재 금지' 정신 위배", "mitigation": "두 source 모두 'candidate-related schema' umbrella 자연. Stage 2 추가 + Stage 명시 분리 (책임 명료)"}
  ]
}
```

### Untouched files explicit (b/c/d 부산물)

- `agents/project-harness-audit-team/CLAUDE.md` — 본 mechanism scope 외 (audit-team workflow 안 영향 부재)
- `tests/_inactive/` — archive smoke 영향 부재
- `bootstrap/` — install lifecycle 영향 부재

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "dedupe 본질 = script 자체 enumerated 둘로 분리 (passing/delta status)", "rationale": "Round 1 결정 — deterministic + LLM 누락 risk 0 + token cost 0. 89% duplicate 본질이 PROPOSE → next_candidates 표준 promote flow 자연 결과 → 실 surface 대상 = delta only.", "evidence": "v6.5 mechanism 외부 cycle 1 (commit ed44bed, 2026-05-20)"},
    {"id": "D2", "decision": "matching key = id 우선 + title fallback", "rationale": "Round 2-1 — id 종별 멱구 안 정확 매칭 (v6.x era 표준, PROPOSE 안 id 보유 확인 v6.6/v6.7) + legacy era (v3~v5) 안전망 (PROPOSE schema 변동 era 안 id 부재 시 title fallback).", "evidence": "RESEARCH cb_6 (v6.6/v6.7 PROPOSE id+title 둘 다)"},
    {"id": "D3", "decision": "출력 구조 = candidate_items (list of {id, title, status}) 교체 (breaking)", "rationale": "Round 2-2 — 토큰 효율 우월 + LLM Step 2 안 'status: delta' 자채 우선 (명령 simple). breaking change 이나 외부 이용자 1건 = slash command 안 LLM Bash 호출만 (자체 통제, 영향 0).", "evidence": "RESEARCH risk_3 mitigation"},
    {"id": "D4", "decision": "dedupe scope = next_candidates[] + candidate_draft[] 양쪽", "rationale": "Round 3-1 — passing = '이미 인지한 후보' 통합 의미 (등재 완료 OR buffer 안). candidate_draft 안 entry 재 surface 위험 0 (역방향 duplicate 차단).", "evidence": "v6.5 mechanism 외부 cycle 1 동질 패턴 가능"},
    {"id": "D5", "decision": "Step 2 prompt 재정의 = delta 우선 surface + passing 통계 only", "rationale": "Round 3-2 — '이미 N건 등재 (passing). 신규 M건 (delta) 우선 검토.' narrative 명시. 사용자 passing 존재 인지 확보 + 토큰 절감 (passing entries 안 surface 안 함).", "evidence": "Round 3-2 직접 결정"},
    {"id": "D6", "decision": "milestone id/title/version = propose-next-surface-dedupe-mechanism / /propose-next surface 자동 dedupe mechanism / v6.8", "rationale": "Round 4-1 — v6.4 cascade-auto-sync-mechanism naming pattern 정합. version v6.8 = v6.7 후속 자연.", "evidence": "v6.4/v6.5/v6.6 mechanism naming 누적"},
    {"id": "D7", "decision": "review depth = Lightweight + inline self-review", "rationale": "Round 4-2 — scope 작음 (script 1 + slash 1 + smoke 1 stage + ARCHITECTURE 1 paragraph). v6.7 lightweight 패턴 정합. 5 관점 subagent converged (v6.6 evidence 18 항목 saturate).", "evidence": "v6.7 lightweight 패턴 + v6.6 5 관점 saturate"},
    {"id": "D8", "decision": "ARCHITECTURE 정전화 host = § 4 끝 #9 row + paragraph 보강 (enhancement 책임 — v6.8 dedupe 는 v6.5 propose-next mechanism 의 sub-feature, 새 mechanism 부재 → 신 row #11 부재. v6.7 #10 enhancement 패턴 정합)", "rationale": "Round 4-3 + Stage F 정밀화 — v6.7 narrative 정전화 (v6.6 #10 row 안 3-step chain 보강) 패턴 정합. v6.8 dedupe = v6.5 propose-next 의 surface dedupe enhancement (별 mechanism 부재) → #9 row verification method 갱신 + paragraph 본문 안 dedupe narrative 추가. v3.21 narrative 정전화 3 단계 패턴 cycle 34 자연 발현 ((a) DESIGN 1차 본 spec + (b) EXECUTE Edit ARCHITECTURE + (c) VERIFY grep). cascade host 1 = root CLAUDE.md propose-next blockquote 1 줄 본문 갱신.", "evidence": "v6.7 #10 enhancement 패턴 + v6.4 cycle 28 + v6.5 cycle 30 + v6.6 cycle 32 누적"},
    {"id": "D9", "decision": "smoke 책임 = tests/smoke-candidate-draft-schema.sh Stage 2 확장 (script propose_next.py --scan 호출 + candidate_items schema 강제)", "rationale": "두 source (ROADMAP candidate_draft + script stdout candidate_items) 모두 'candidate-related schema 강제' umbrella 자연. 별 smoke 신규 회피 = lightweight 정합 (v6.7 패턴). 책임 명시 = Stage 1 (ROADMAP) + Stage 2 (script) 분리.", "evidence": "tests/CLAUDE.md '같은 smoke 두 책임 혼재 금지' context = era 분류 vs entry schema (다른 책임). 본 경우 둘 다 candidate-related (같은 책임 umbrella)"},
    {"id": "D10", "decision": "phases = 1 phase 통합 (script + slash command + smoke + ARCHITECTURE + cascade host)", "rationale": "lightweight 정합 + 모든 변경 같은 본질 (dedupe mechanism). v6.7 1-phase 패턴 누적.", "evidence": "v6.7 1-phase commit"},
    {"id": "D11", "decision": "Active form retitle = milestone id 'mechanism' 명사 종결 보존 (v6.4 cascade-auto-sync-mechanism naming pattern 정합, 우선순위 = naming consistency > active form ideal)", "rationale": "ARCHITECTURE § 7.2 (3) Active form ideal vs (1) 한 entry = 한 본질 + naming consistency trade-off. v6.4/v6.5/v6.6 mechanism naming pattern 누적 → consistency 우선. v6.7 PROPOSE #7 (active form retitle candidate 거명만) 패턴 정합 — 별 milestone scope 외 처리.", "evidence": "v6.7 PROPOSE #7 candidate 거명만 패턴"}
  ],
  "approach": "3 컴포넌트 hybrid (v6.4/v6.5/v6.6 시리즈 패턴 정합) — (1) script 안 dedupe logic 추가 (id+title 추출 regex 확장 + roadmap_next_candidates + candidate_draft 안 id set 매칭 + candidate_items {id, title, status} 분류) + (2) slash command Step 2 prompt 재정의 (delta 우선 surface + passing 통계 narrative + 비유 표현 추가) + (3) smoke Stage 2 확장 (script invoke + schema check). 추가로 ARCHITECTURE § 4 끝 #9 paragraph 안 dedupe 본질 보강 + 매트릭스 row #11 append + root CLAUDE.md cascade host 1 줄 갱신.",
  "phases": [
    {"id": "phase-1", "scope": "전체 통합 — script + slash command + smoke + ARCHITECTURE + cascade host + ROADMAP entry status 갱신 + CHANGELOG entry [v6.8] + 도그푸드 1 회 호출 검증", "commit": "feat(meta): v6.8 — /propose-next surface 자동 dedupe mechanism [v6.8]"}
  ],
  "risk_mitigation": [
    {"id": "R1", "risk": "PROPOSE entries 안 id 부재 era (v3~v5)", "mitigation": "title fallback 안전망 — id 추출 부재 시 title exact match 로 매칭. 정확도는 v6.x era 안 만 보장, legacy era 안 false negative 가능 (oos_1 명시)"},
    {"id": "R2", "risk": "candidate_items breaking change 시 외부 이용자 (slash command 외) 안 영향", "mitigation": "외부 이용자 0 (확인 = grep `candidate_titles` 사용처) — slash command 안 LLM Bash 호출만 (자체 통제)"},
    {"id": "R3", "risk": "smoke 책임 확장 시 미래 신규 smoke 필요 분리 trigger 부재", "mitigation": "Stage 명시 분리 + Stage 마다 책임 명시 narrative. 미래 분리 필요 시 별 smoke 분리 자연"},
    {"id": "R4", "risk": "lightweight 모드 안 inline self-review 의 미흡한 부합 (5 관점 subagent 대비)", "mitigation": "v6.7 lightweight 패턴 + v6.6 5 관점 saturate evidence (converged 18 항목). 본 scope 작아 marginal value"},
    {"id": "R5", "risk": "도그푸드 1 회 호출 검증 시 delta 0건 case (모든 후보 이미 등재)", "mitigation": "delta 0건 = passing 통계 only 출력 정상 (mechanism 자체 break 아님). LLM Step 2 narrative '신규 후보 부재. passing 통계: N건' 표지 자연"}
  ]
}
```

### Approach narrative

v6.5 mechanism 외부 cycle 1 evidence 의 89% duplicate 본질은 PROPOSE `candidates_named_only` → ROADMAP `next_candidates[]` promote 표준 flow 안 자연 결과 (PROPOSE 안 거명된 후속 candidate 가 ROADMAP 안 명시 등재되는 것이 정상). LLM cross-check 책임 (옵션 a) 은 token cost + 누락 risk 존속 → script 자체가 enumerated 를 둘로 분리 (옵션 b+) 가 본질적 해결.

신 candidate_items schema = `{id, title, status: 'delta' | 'passing'}` 의 자연 표지. `status: passing` = next_candidates 또는 candidate_draft 안 이미 등재 (id 우선 + title fallback 매칭). `status: delta` = 신규 surface 대상 (어디에도 부재). LLM Step 2 안 `status: delta` 자채 우선 + passing 통계 narrative ('이미 N건 등재 (passing). 신규 M건 (delta) 우선 검토.') 만 surface.

### Risk priorities

R1+R2 = P1 (직접 위험 가능), R3+R4+R5 = P2 (위험 미시 또는 evidence 부재).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "scope": "11 decisions (D1~D11) + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2) all approved",
    "method": "inline AskUserQuestion (Stage E)",
    "notes": "lightweight 모드 + 5 관점 inline self-review (subagent 부재) — v6.7 패턴 정합. pre-PLAN 4 round + Round 5 review 완료. phase-1 EXECUTE 진입 허가."
  }
}
```

### Inline self-review 종합

5 관점 inline self-review (subagent 부재, lightweight 정합):

- **Architecture** P2 #arch-1: D9 smoke 책임 확장 'candidate-related' umbrella 정의 명료성 약 — 후속 milestone 분리 trigger 조건 narrative 부재 (별 milestone 거명만)
- **Spec-drift** P3 #drift-1: v5.7 spike (c) DESIGN 즉시 정정 분기 8번째 자연 발현 evidence (별 milestone 거명만)
- **Security** P3 #sec-1: candidate_items[].title control character = json.dumps() 자동 escape 보호 (기존 가드)
- **Dictionary-semantics** P2 #dict-1: D11 retitle candidate 거명만 (v6.7 PROPOSE #7 패턴 정합)
- **Test-coverage** P2 #test-1: edge case fixture 부재 — 도그푸드 호출 시 우연 발견 가능 (별 milestone 거명만)

decisive 0 + P2 3 + P3 2 = 모두 narrative 흡수 또는 별 milestone 거명만 (scope 외).

## EXECUTE

### Spec

```json
{
  "phases": [
    {
      "id": "phase_1",
      "title": "script + slash command + smoke + ARCHITECTURE + cascade host + CHANGELOG 통합 1 commit",
      "actions": [
        "(1) scripts/propose_next.py — ID_REGEX + ENTRY_BLOCK_REGEX 신규 추가 (length-bounded ReDoS 차단)",
        "(2) scripts/propose_next.py — NAMED_ONLY_REGEX 종결자 명시 `\\]\\s*[,}]` 변경 (lazy match jam 회귀 차단, v6.5 PROPOSE rationale `[]` 안 `]` 잘림 evidence)",
        "(3) scripts/propose_next.py — grep_named_only() return type list[str] → list[dict] (id + title pair 추출)",
        "(4) scripts/propose_next.py — cmd_scan() dedupe logic 추가 (known_ids + known_titles set + status 분류)",
        "(5) scripts/propose_next.py — cross_validate.dedupe_stats 4 필드 신규 + instructions narrative 재정의",
        "(6) scripts/propose_next.py — docstring 안 v6.8 dedupe 본질 추가",
        "(7) claude/commands/propose-next.md — Step 2 prompt 재정의 (delta 우선 surface + passing 통계 only + 비유 표현 3 entry 추가)",
        "(8) tests/smoke-candidate-draft-schema.sh — Stage 2 확장 (script invoke + candidate_items + dedupe_stats schema 검증) + header narrative 갱신",
        "(9) projects/meta/ARCHITECTURE.md § 4 끝 #9 row + paragraph 보강 (v6.7 enhancement 패턴 정합, 신 row #11 부재)",
        "(10) cascade_sync.py --check → 1 drift detect (root CLAUDE.md marker hash 5af4794bf53712fa → 2313949d4ddfff70)",
        "(11) CLAUDE.md (root) L130 blockquote 본문 보강 (v6.8 dedupe 1 줄 추가)",
        "(12) cascade_sync.py --apply (marker hash 자동 갱신)",
        "(13) cascade_sync.py --check 재호출 (drift 0 검증 ✓)",
        "(14) tests/smoke-candidate-draft-schema.sh 호출 (Stage 1 + Stage 2 PASS 검증 ✓)",
        "(15) MILESTONE.md APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 5 섹션 채움",
        "(16) CHANGELOG.md [v6.8] entry 추가 (Keep a Changelog v1.1.0 정합)",
        "(17) ROADMAP.md v6.8 status in_progress → completed + summary 갱신 + v6.5 archival (milestones[] 안 v6.5 entry 제거, recent 3 = v6.8+v6.7+v6.6)",
        "(18) pre-commit 18 hook 호출 검증"
      ],
      "files_changed": [
        "scripts/propose_next.py (regex 추가 + 종결자 fix + dedupe logic + dedupe_stats)",
        "claude/commands/propose-next.md (Step 2 prompt 재정의)",
        "tests/smoke-candidate-draft-schema.sh (Stage 2 확장)",
        "projects/meta/ARCHITECTURE.md (§ 4 끝 #9 row + paragraph 보강)",
        "CLAUDE.md (root, cascade host marker hash + blockquote 본문 보강)",
        "projects/meta/milestones/v6.8/MILESTONE.md (전체 작성)",
        "projects/meta/milestones/v6.8/execute/ (빈 디렉토리 — v6.7 패턴 정합, phase-1.md 분리 부재)",
        "CHANGELOG.md ([v6.8] entry 추가)",
        "projects/meta/ROADMAP.md (v6.8 status completed + v6.5 archival)"
      ],
      "commit_strategy": "단일 commit (lightweight 1-phase 통합 본질). 사용자 명시 결정 게이트 (commit 직전) 정합. v6.4/v6.5/v6.6 시리즈 = 2-phase (mechanism + 도그푸드 분리) vs v6.7/v6.8 = 1-phase (lightweight 본질)."
    }
  ]
}
```

### EXECUTE narrative

phase-1 통합 본질 = surface dedupe mechanism 의 3 컴포넌트 (script + slash command + smoke) + 정전화 host (ARCHITECTURE) + cascade host (root CLAUDE.md) + audit trail (CHANGELOG + ROADMAP) 모두 같은 본질 (v6.8 dedupe 도입) → 단일 commit 자연. lightweight 1-phase 정합.

## VERIFY

### Spec

```json
{
  "smoke_results": [
    {"smoke": "tests/smoke-candidate-draft-schema.sh", "result": "PASS=2 FAIL=0", "stage_1": "candidate_draft[] empty (v6.8 promote 완료)", "stage_2": "dedupe_stats 4 필드 ✓ + candidate_items 3 필드 + status enum 2 값 ✓ (28건 items 5 milestones)"},
    {"smoke": "tests/smoke-cascade-drift.sh", "result": "PASS — all 1 host(s) in sync", "detail": "marker hash 2313949d4ddfff70 동기 검증"},
    {"smoke": "pre-commit 18 hook full run", "result": "PENDING (Stage F 마지막 호출)", "expected": "전체 18 hook PASS"}
  ],
  "criteria_check": [
    {"id": "sc_1", "criterion": "scripts/propose_next.py dedupe logic 도입 (id + title fallback + scope next_candidates + candidate_draft)", "verdict": "PASS — ENTRY_BLOCK_REGEX + ID_REGEX 추가 + grep_named_only return type 확장 + cmd_scan dedupe logic 통합. 실 호출 결과 delta=21 / passing=7 / known_ids=9 / known_titles=9 (28건 items 5 milestones)"},
    {"id": "sc_2", "criterion": "claude/commands/propose-next.md Step 2 prompt 재정의 (delta 우선 + passing 통계 only)", "verdict": "PASS — Step 2 narrative 재작성 + delta 0건 case 별도 narrative + 비유 표현 3 entry 추가"},
    {"id": "sc_3", "criterion": "ARCHITECTURE § 4 끝 #9 row + paragraph 보강 + cascade host 1 갱신", "verdict": "PASS — row #9 verification method Stage 1 + Stage 2 분리 표기 + paragraph 본문 안 v6.8 surface 자동 dedupe 확장 paragraph 추가 + cascade-sync marker hash 자동 갱신 + drift 0 검증"},
    {"id": "sc_4", "criterion": "tests/smoke-candidate-draft-schema.sh Stage 2 확장 + 회귀 0", "verdict": "PASS — Stage 2 = script invoke + candidate_items schema + dedupe_stats 검증. 회귀 = 다른 smoke 영향 부재 (별 source / 별 책임)"},
    {"id": "sc_5", "criterion": "도그푸드 1 회 호출 검증 (mechanism 작동 확인)", "verdict": "PASS — `python scripts/propose_next.py --scan` 호출 결과 dedupe_stats 정상 + 89% duplicate → 25% duplicate (delta 21 / passing 7 = 21/28 = 75% delta surface) 본질 도달. v6.8 schema A2 정합 (v6.8 in_progress entry 도 known_ids 안 등재 → v6.8 PROPOSE 안 후속 candidates 도 즉시 passing 분류 가능)"}
  ],
  "verdict": "PASS — 5 sc 모두 충족. v3.21 cycle 34 narrative 정전화 + v5.7 spike 패턴 (c) 8번째 + lightweight 1-phase 정합 + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2) 모두 narrative 흡수 또는 별 milestone 거명만."
}
```

### VERIFY narrative

도그푸드 1 회 호출 결과 dedupe 실 작동 확인:

| Milestone | Total | delta | passing |
|---|---|---|---|
| v6.8 | 0 | 0 | 0 (아직 PROPOSE 부재) |
| v6.7 | 3 | 0 | 3 (모두 next_candidates 등재) |
| v6.6 | 7 | 5 | 2 |
| v6.5 | 7 | 5 | 2 |
| v6.4 | 11 | 11 | 0 |
| **합계** | **28** | **21** | **7** |

passing 비율 = 7/28 = 25% (v6.5 mechanism cycle 1 안 89% → 25% 변화 = 신규 후보 surface 안 dedupe 적용 자연 발현). LLM Step 2 안 delta 21건 우선 surface + passing 7건 통계 only narrative 자연.

## REPORT

### Spec

```json
{
  "summary": "v6.5 mechanism 외부 cycle 1 evidence (2026-05-20, commit ed44bed — 89% duplicate) 직접 후속. scripts/propose_next.py 안 dedupe logic 직접 도입 (deterministic + LLM 누락 risk 0 + token cost 0). candidate_titles → candidate_items 교체 (breaking) — status enum 2 값 'delta' / 'passing'. matching key = id 우선 + title fallback. scope = next_candidates[] + candidate_draft[] 양쪽. Step 2 prompt 재정의 (delta 우선 + passing 통계 only). ARCHITECTURE § 4 끝 #9 row + paragraph enhancement (v6.7 #10 enhancement 패턴 정합, 신 row #11 부재). v3.21 narrative 정전화 cycle 34 + AI Native § 7.1 '자율성' 면 second cycle + v5.7 spec-drift spike (c) 8번째 자연 발현 + lightweight 1-phase 누적 11/23 = 47.8% (40% 첫 돌파). 5 관점 inline self-review cycle 6 (decisive 0 + P2 3 + P3 2).",
  "delta_from_intent": "INTENT goal + 5 sc 모두 충족. oos 3건 (legacy era id 자동 backfill / promote 자동화 / lessons_learned P2 dedupe scope 포함) 보존 (의도된 oos). VERIFY 5 sc 모두 PASS verdict.",
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "scripts/propose_next.py 안 NAMED_ONLY_REGEX 의 pre-existing lazy match `(.*?)\\]` 가 entry rationale 안 `[]` 문자열 안 `]` 에서 잘림 = v6.5 PROPOSE rationale `\"candidate_draft[]...\"` direct evidence. lazy match jam 패턴 = 종결자 명시 (`\\]\\s*[,}]`) 으로 회피. ENTRY_BLOCK_REGEX 의 `{[^{}]}` 패턴 도입 시 inner 가 truncated 인 경우 ENTRY_BLOCK 매칭 0 → 회귀 즉시 발견. lessons 패턴 = regex-based JSON parse 안전망 (`}` 종결자 명시 의무)."},
    {"id": "L2", "priority": "P1", "lesson": "Round 1~4 pre-PLAN 4 round + Round 5 review = 5 round 안 핵심 결정 11건 흡수. 사용자 결정 단계 명시 게이트 (스무고개 방식) 정합. 비교 = v6.7 pre-PLAN 4 round + v6.6 pre-PLAN 4 round 누적. round 본질 = 1차 의문 → option 분리 → 사용자 결정 → 다음 round 확장. round 단조 증가 (5 round) = scope 명료성 직접 evidence."},
    {"id": "L3", "priority": "P1", "lesson": "ARCHITECTURE 정전화 host 결정 안 'enhancement vs new mechanism' 분류 의무 = D8 정밀화 evidence. 본 v6.8 dedupe = v6.5 propose-next mechanism 의 sub-feature → row #9 enhancement (v6.7 #10 enhancement 패턴 정합) 자연. 신 row #11 부재 의도 = 매트릭스 grow pattern 단조 증가 회피 + cross-ref 정합. lessons 패턴 = '신 mechanism 도입' vs '기존 mechanism 확장' 분류 = D8 결정 game-changer 의무."},
    {"id": "L4", "priority": "P2", "lesson": "smoke 책임 확장 시 'candidate-related schema 강제' umbrella 자연 정합. tests/CLAUDE.md '같은 smoke 두 책임 혼재 금지' context = era 분류 vs entry schema (다른 책임). 본 경우 둘 다 candidate-related (같은 책임 umbrella) → 별 smoke 신규 회피 lightweight 정합. 향후 분리 trigger 조건 narrative 부재 = 후속 milestone 거명만."},
    {"id": "L5", "priority": "P2", "lesson": "v6.8 in_progress entry 자체가 known_ids set 안 등재 → v6.8 PROPOSE 안 후속 candidates 도 자동 passing 분류 가능. 도그푸드 cycle 안 self-referential dedupe = mechanism 견고성 직접 evidence (mechanism 자체 milestone entries 도 dedupe scope 안 자연 포함). 후속 PROPOSE candidates 안 passing 표시 = ROADMAP entry 안 이미 인지된 사실 표지 자연."},
    {"id": "L6", "priority": "P2", "lesson": "matching key id 우선 + title fallback 의 legacy era 안전망 본질 = D2 결정 정합. PROPOSE schema 변동 era (v3~v5) 안 id 부재 시 title 동일 검사 → 등재 자연. 정확도는 v6.x era 안 만 보장, legacy era false negative 가능 (oos_1 명시). lessons 패턴 = matching key 결정 시 schema 표준 era + legacy era 호환성 양립 의무."},
    {"id": "L7", "priority": "P2", "lesson": "candidate_items breaking change 안전 evidence = 외부 이용자 0 (slash command 안 LLM Bash 호출만, 자체 통제) = R2 mitigation 직접 적용. 본 case = repo internal mechanism 변경 시 외부 callee enumeration 후 breaking 자연 결정 가능. lessons 패턴 = breaking change 결정 시 callee scope (외부 vs 내부) 명시 의무."},
    {"id": "L8", "priority": "P2", "lesson": "v5.7 spec-drift spike (c) DESIGN 즉시 정정 분기 8번째 자연 발현 evidence (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8). Anthropic Claude Code spec 안 'dedupe / enumerate filter' 표준 패턴 부재 → 자체 정전화 자연. lessons 패턴 = repo 자체 컨벤션 mechanism 도입 시 외부 spec 검증 → 부재 시 자체 정전화 분기 자연."}
  ],
  "cycle_evidence": {
    "v3_21_narrative_canonicalization_cycle": "34 (cycle 33 v6.7 self-host → cycle 34 v6.8 cascade host 1 = root CLAUDE.md propose-next blockquote)",
    "v5_7_spec_drift_spike_pattern_c": "8 (v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8 누적)",
    "ai_native_dimension_section_7_1_자율성": "second cycle (v6.5 first / v6.8 second)",
    "lightweight_1_phase_누적": "11/23 = 47.8% (40% 첫 돌파, v6.7 10/22 → v6.8 11/23)",
    "inline_self_review_cycle": "6 (v6.7 cycle 5 = 2 issue → v6.8 cycle 6 = 5 issue [decisive 0 + P2 3 + P3 2])",
    "archival_cycle": "8 (v5.21 도입, v6.4/v6.5/v6.6/v6.7 누적 → v6.8 = v6.5 archival)"
  },
  "ai_native_dimension_check": {
    "primary_dimension": "자율성",
    "evidence": "script 자체 dedupe 분리 (LLM 누락 risk 0) + LLM surface 책임 축소 (delta 우선 surface, passing 통계 only) + 사용자 최종 결정 (mechanism 도입 게이트). round 1 자율 범위 = candidate 제안까지만 정합 (v6.5 round 1 결정 보존)."
  }
}
```

### REPORT narrative

v6.8 = v6.5 mechanism 직접 enhancement. 89% duplicate 본질 자연 결과 → 25% (delta 21 / 28) dedupe 적용 = 본질적 해결 도달. 신 row 부재 (v6.7 #10 enhancement 패턴 정합) + lightweight 1-phase + cascade host 1 + 8 lessons (L1~L3 P1 + L4~L8 P2) = 모두 narrative 흡수 자연.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {"id": "propose-next-lessons-p2-dedupe-scope-extension", "title": "lessons_learned P2 항목 dedupe scope 포함", "origin_milestone": "v6.8", "target_version": "v6.x", "trigger": "B_byproduct", "rationale": "v6.8 oos_3 origin. 현 script lessons_p2_count = count only (title/id 추출 부재). dedupe 대상 자체 부재 → 별 milestone 안 lessons title 추출 logic 추가 후 dedupe scope 확장. P2 lessons title 추출 regex + dedupe scope 합산 narrative DESIGN 단계 결정."},
    {"id": "propose-next-legacy-era-id-backfill", "title": "PROPOSE entries 안 id 부재 era (v3~v5) 의 자동 backfill", "origin_milestone": "v6.8", "target_version": "v6.x", "trigger": "D_design", "rationale": "v6.8 oos_1 origin. id 우선 + title fallback 안전망 보존 (legacy era PROPOSE 안 id 부재 안전 처리). 자동 backfill = scope 확장 mechanism. archival 본질 + legacy era 영향 분석 + cascade impact narrative DESIGN 단계 결정."},
    {"id": "smoke-candidate-related-umbrella-split-trigger", "title": "smoke-candidate-draft-schema umbrella 책임 분리 trigger 조건 narrative", "origin_milestone": "v6.8", "target_version": "v6.x", "trigger": "D_design", "rationale": "v6.8 L4 origin. 본 milestone D9 결정 = 두 source 'candidate-related' umbrella 자연 정합 (lightweight 정합) 이나 미래 신규 source 추가 시 분리 trigger 조건 narrative 부재. 향후 third source (예: lessons_learned scope) 추가 시 umbrella 확장 vs 분리 결정 가이드라인 candidate."}
  ],
  "propose_narrative": "5 관점 inline self-review cycle 6 P2 3 + P3 2 = 5 issue 모두 narrative 흡수 또는 별 milestone 거명만 (lightweight 정합). EXECUTE lessons L1~L8 안 후속 candidate 거명. lightweight 모드 정책 정합 (v3.13/v3.14 동결 + v4.0 § 6.2 폐지 narrative + memory feedback_section_6_2_abolished). 사용자 명시 발의 trigger 후 ROADMAP next_candidates[] 등재 (자동 등재 회피). v6.7 retitle candidate (PROPOSE #7 거명만 보존) + v6.6 PROPOSE 안 7 후속 거명만 (외부 산출물 확장 / PostToolUse 재발의 / debugger 5-step format / DoS+exception path / numeric lookup auto-trigger 등) — ROADMAP next_candidates 안 현 9건 + 본 milestone 3건 = 12건 등재."
}
```

### PROPOSE narrative

본 milestone = v6.5 mechanism 직접 enhancement. 후속 candidates 3건 = v6.8 lessons (L4 umbrella trigger / L6 legacy era id backfill / oos_3 P2 lessons scope) 직접 origin. 등재 candidate scope = v6.x 후속 milestone 자연 (mechanism 성숙도 직접 evidence).

## SUB_MILESTONES

본 milestone = 단일 본질 (sub-milestone 부재). v6.2+ flattened era 정합.

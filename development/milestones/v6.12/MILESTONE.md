---
id: smoke-stage-3-tests-fixture-pattern
title: smoke-candidate-draft-schema fixture sub-dir 자동화
version: v6.12
status: completed
---

# v6.12 — smoke-candidate-draft-schema fixture sub-dir 자동화

## INTENT

### Spec

```json
{
  "id": "smoke-stage-3-tests-fixture-pattern",
  "title": "smoke-candidate-draft-schema fixture sub-dir 자동화",
  "goal": "v6.11 lessons L3 origin 직접 해소 — v6.11 안 violation 주입 controlled 비교가 수동 (bash + python heredoc 1 종, id regex 만). v6.6 smoke-audit-fact-verify 안 6 sub-dir fixture 패턴 (boolean-normal/boolean-mismatch/...) 동질 mechanism 자연 확장. 해소 = (1) tests/smoke-candidate-draft-schema.sh 안 Stage 4 신규 추가 (umbrella 확장, R1) + tests/_fixtures/candidate-draft-schema/ 7 sub-dir 신규 (normal + 6 violation, R2 comprehensive). (2) Stage 1 logic 확장 5 신규 검증 (id regex + detected_at ISO + rationale length ≤ 500자 + source/decision_pending non-empty, R2 + EXECUTE 직전 round 5 정정 — ROADMAP next_candidates#3 candidate 자연 흡수). (3) ARCHITECTURE.md § 4 끝 매트릭스 #11 row + paragraph 신규 (R3 cascade host 3, v3.21 패턴 cycle 3). (4) tests/CLAUDE.md smoke 매트릭스 행 description 갱신 + CHANGELOG.md [v6.12] entry. title length 검증 = v6.3 smoke 책임 보존 (R4, 중복 회피). 1-phase 통합 (lightweight 누적 12/24 = 50% 정합).",
  "success_criteria": [
    {"id": "sc_1", "description": "`tests/smoke-candidate-draft-schema.sh` 안 Stage 4 신규 추가 — `tests/_fixtures/candidate-draft-schema/` 7 sub-dir loop (normal + violation-{id, category, missing-field, detected_at, rationale-too-long, source-empty}). 각 sub-dir 안 fixture ROADMAP-like JSON + `expected.txt` (PASS/FAIL 기대값). Stage 4 안 fixture 각각 Stage 1 호출 → exit code 기대값 일치 검증 (normal=PASS, violation=FAIL invert)."},
    {"id": "sc_2", "description": "Stage 1 logic 확장 — 5 신규 검증 추가 (현행 7 필드 존재 + category enum 위에 누적): (i) id regex `^[a-z0-9-]+$` (schema_note 정전화 정합, candidate_draft[].id 책임) + (ii) detected_at ISO 8601 형식 (regex `^\\d{4}-\\d{2}-\\d{2}$`) + (iii) rationale length ≤ 500자 (codepoint len) + (iv) source non-empty (strip 후 길이 > 0) + (v) decision_pending non-empty. Stage 3 책임 = next_candidates[].id (책임 중복 부재, scope 분리). 본 sc_2 안 (i) id regex = EXECUTE 직전 round 5 정정 (책임 분리 명료화 — Stage 1 = candidate_draft / Stage 3 = next_candidates). ROADMAP next_candidates#3 candidate (`candidate-draft-id-regex-extension`) 자연 흡수 (Stage 3 확장 본질 → Stage 1 추가 본질 책임 분리, 검증 effect 동일)."},
    {"id": "sc_3", "description": "`ARCHITECTURE.md` § 4 끝 매트릭스 #11 row 신규 추가 (mechanism: fixture-based smoke 자동화 패턴) + 후행 paragraph 본문 신규 — v6.6 cycle 1 (smoke-audit-fact-verify) → v6.12 cycle 2 (smoke-candidate-draft-schema) evidence 명시 + R1~R4 결정 narrative. cascade host 3 = smoke 자체 + tests/CLAUDE.md 매트릭스 행 + ARCHITECTURE § 4 끝 #11 row. v3.21 narrative 정전화 3 단계 패턴 cycle 3 (cascade host ≥ 2 판정 기준 도달, v6.11 L3 정합)."},
    {"id": "sc_4", "description": "`tests/CLAUDE.md` smoke 매트릭스 안 smoke-candidate-draft-schema 행 description 갱신 — Stage 4 추가 표기 + Stage 1 logic 확장 4 항목 명시 + fixture 패턴 cycle 2 (v6.6 → v6.12) 명시. v6.12 phase-1 신규 (v6.12_smoke-stage-3-tests-fixture-pattern 흡수) narrative 추가."},
    {"id": "sc_5", "description": "`CHANGELOG.md` [v6.12] entry 추가 — Keep a Changelog v1.1.0 정합 + entry title 가이드 4 원칙 (≤ 60자 + active form + 한 entry = 한 본질 + detail 은 summary 안)."},
    {"id": "sc_6", "description": "도그푸드 — `bash tests/smoke-candidate-draft-schema.sh` 호출 시 Stage 1 + Stage 4 PASS, fixture 7 sub-dir 모두 expected exit code 일치 (normal=0 PASS, violation 6건=1 FAIL → Stage 4 invert 후 PASS). Stage 4 PASS=7 (또는 단일 line 'Stage 4 fixture loop PASS 7/7')."},
    {"id": "sc_7", "description": "`ROADMAP.md` milestones[] 안 v6.12 entry status `in_progress` → `completed` 갱신 (REPORT 단계 후) + updated 필드 `2026-05-20-v6.12` confirm. v5.21+ schema A2 정합 (recent 3 → v6.12/v6.11/v6.10)."},
    {"id": "sc_8", "description": "pre-commit 11 hook 모두 PASS, 회귀 0. 변경 파일 = smoke 자체 + 7 fixture sub-dir + ARCHITECTURE + tests/CLAUDE.md + CHANGELOG + ROADMAP + MILESTONE.md → 영향 hook = smoke-candidate-draft-schema 자체 + smoke-claude-md-drift + smoke-cross-ref + smoke-cascade-drift + smoke-entry-title-guideline + smoke-spec-verification + smoke-scope-contract 등 모두 PASS."},
    {"id": "sc_9", "description": "v3.21 narrative 정전화 3 단계 패턴 cycle 3 검증 — (a) RESEARCH 단계 안 1차 source 식별 (smoke 자체 hardcode logic) + (b) EXECUTE 안 Edit (3 host 동시 갱신) + (c) VERIFY 안 grep (cascade host 3 모두 cycle 2 narrative 존재 확인). cascade-sync marker 자동 drift 차단은 oos_2 (R3 옵션 2 선택 opt out)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "title length 검증 (≤ 60자) 추가", "reason": "R4 결정 — `tests/smoke-entry-title-guideline.sh` (v6.3) 가 이미 ROADMAP/CHANGELOG 안 모든 title (milestones[]/next_candidates[]/candidate_draft[]) length 강제. candidate_draft schema Stage 1 안 length 검증 추가 = 책임 중복. fixture 안 violation-title sub-dir 도 제외 (책임 분리 보존). 단 v6.3 책임 = ROADMAP/CHANGELOG path 검사만, fixture 파일 (별 path) 안 length 위반 자동 차단 부재 → 별 milestone candidate 자연 (evidence 누적 시)."},
    {"id": "oos_2", "item": "v6.4 cascade-sync marker 자동 drift 차단 활용", "reason": "R3 옵션 2 선택, opt out (옵션 3 cascade-sync 활용 거절). 본 milestone = narrative 정전화 cycle 3 (수동 cascade host 3 갱신) only. 별 milestone candidate `cascade-sync-blockquote-content-auto-sync-mechanism` (next_candidates#7) 동질 본질이나 marker 활용 본질 다름 → 별 candidate 거명만 자연."},
    {"id": "oos_3", "item": "v6.8 smoke-candidate-related-umbrella-split-trigger candidate 첫 발현 evidence narrative 정전화", "reason": "본 milestone = umbrella 확장 자연 채택 (R1, lightweight 정합). 분리 trigger 가이드라인 별 candidate (`smoke-candidate-related-umbrella-split-trigger`, next_candidates#11) 보존. 본 milestone PROPOSE 안 evidence trace 만 명시 (별 milestone scope 외)."},
    {"id": "oos_4", "item": "milestones[] / next_candidates[] schema 확장 (예: milestones[].id regex 검증)", "reason": "milestones[].id 안 historical era (v2.x/v1.x flat `v{X.Y}_{slug}` 점 포함) 위반 보유 → exclusion logic 필요. 별 milestone scope. 본 milestone scope = candidate_draft[] 자체 만 + next_candidates[].id (Stage 3 책임 보존)."},
    {"id": "oos_5", "item": "regex / enum 자체 변경 (예: detected_at 형식 확장 ISO 8601 datetime 까지 / category enum 확장)", "reason": "schema_note 정전화 그대로 적용. 본 milestone = fixture controlled 비교 자동화 + Stage 1 logic 확장 (현 schema 검증)만. schema 자체 변경 별 milestone scope (evidence base 약, 현 schema 안 violation 부재)."},
    {"id": "oos_6", "item": "source/rationale/decision_pending 의 detailed 형식 검증 (예: rationale 안 path-format / decision_pending 안 question mark)", "reason": "자유 텍스트 본질 보존 — Stage 1 logic 확장 = 단순 non-empty (strip 후 길이 > 0) + length 검증만. detailed 형식 = 자유도 제약 본질 (별 milestone, evidence base 약)."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "tests/smoke-candidate-draft-schema.sh (v6.5 phase-1 신규 + v6.8 phase-1 Stage 2 확장 + v6.11 phase-1 Stage 3 추가)", "purpose": "본 milestone 확장 대상 단일 host — Stage 4 신규 추가 + Stage 1 logic 확장 4 항목"},
    {"id": "dep_2", "source": "tests/smoke-audit-fact-verify.sh + tests/fixtures/audit-fact-verify/{boolean-normal,boolean-mismatch,table-normal,table-mismatch,numeric-normal,empty-targets}/ (v6.6 phase-1 신규)", "purpose": "fixture sub-dir 패턴 1차 reference — 6 sub-dir 패턴 + Stage 5 path traversal 차단 + expected exit code 매핑 자연 정합. 본 milestone 안 7 sub-dir 동질 mechanism 적용 cycle 2 evidence"},
    {"id": "dep_3", "source": "projects/meta/milestones/v6.11/MILESTONE.md ## REPORT lessons L3", "purpose": "본 milestone origin evidence — 수동 violation 주입 controlled 비교 (bash + python heredoc 1 종) → 자동화 후속 자연"},
    {"id": "dep_4", "source": "projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 (#1~#10 row + paragraph 본문)", "purpose": "#11 row 추가 대상 — mechanism: fixture-based smoke 자동화 패턴 (v6.6 cycle 1 + v6.12 cycle 2)"},
    {"id": "dep_5", "source": "tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행", "purpose": "Stage 4 + Stage 1 확장 4 항목 + cycle 2 narrative 갱신 대상 (보조 cascade host)"},
    {"id": "dep_6", "source": "tests/smoke-entry-title-guideline.sh (v6.3 phase-1 신규)", "purpose": "title length 검증 책임 보존 (R4) — 본 milestone scope 외 (oos_1 evidence)"}
  ]
}
```

### Motivation

v6.11 phase-1 commit (2e203be) 안 Stage 3 신규 추가 — `next_candidates[].id` regex 자동 검증 mechanism 정착. 단 Stage 3 violation 주입 controlled 비교 (smoke 자체 FAIL → 원복 패턴) = `bash + python heredoc 1 종` 수동 실행 → 향후 회귀 시 매번 수동 검증 부담 + 다른 violation 종류 (category enum 외, 필드 누락 등) 자동 검증 부재.

대조 = v6.6 phase-1 commit (29a3ab1) 안 `tests/smoke-audit-fact-verify.sh` 의 fixture sub-dir 6 패턴 (`boolean-normal/boolean-mismatch/table-normal/table-mismatch/numeric-normal/empty-targets`) — 각 sub-dir 안 fixture 파일 + expected exit code → smoke loop 자동 검증. 외부 spec (Anthropic Claude Code docs) 안 first-class 패턴 부재 (v5.7 spec-drift spike (c) 7번째 자연 발현 D12) 였으나 본 repo 자체 정전화 패턴 정합.

v6.11 L3 lesson 본문 직접 인용:

> Stage 3 violation 주입 controlled 비교 = 본 milestone 안 수동 (bash + python heredoc 1 종, id regex 만). v6.6 smoke-audit-fact-verify 안 6 sub-dir fixture 패턴 (boolean-normal/boolean-mismatch/...) 동일 적용 candidate — smoke-candidate-draft-schema 안 fixture 기반 violation 주입 자동화. evidence 누적 (Stage 4 신규 + 동질 mechanism) 시 별 milestone.

해소 = (1) `tests/_fixtures/candidate-draft-schema/` 7 sub-dir 신규 (normal + 6 violation, R2 comprehensive) + Stage 4 loop logic (R1 umbrella 확장). (2) Stage 1 logic 확장 4 신규 검증 (detected_at ISO + rationale length + source/decision_pending non-empty, R2). (3) ARCHITECTURE § 4 끝 매트릭스 #11 row + paragraph 본문 신규 (R3 host 3, v3.21 패턴 cycle 3). (4) tests/CLAUDE.md smoke 매트릭스 행 갱신 + CHANGELOG entry.

**Pre-PLAN 4 round 누적 결정** (2026-05-20):

1. **R1 umbrella** — Stage 4 신규 추가 (기존 검증 안 확장, lightweight 누적 정합).
2. **R2 scope** — comprehensive (Stage 1 logic 확장 + 7 필드 violation 망라).
3. **R3 narrative** — ARCHITECTURE § 4 끝 매트릭스 #11 row + paragraph 신규 (cascade host 3, v3.21 패턴 cycle 3). cascade-sync marker 자동 drift 차단은 opt out (oos_2).
4. **R4 책임** — title length 검증 = v6.3 smoke 책임 보존 (책임 중복 회피), fixture 안 violation-title sub-dir 제외.

본 milestone = v6.11 직접 후속 + lightweight 1-phase (v6.6~v6.11 누적 12/24 = 50% 첫 돌파 후 두 번째 정합).

### Out of scope rationale

oos_1: title length 검증 = v6.3 smoke (smoke-entry-title-guideline) 책임 보존 (R4). 책임 중복 회피 default. fixture 파일 안 length 위반 자동 차단 부재 evidence 누적 시 별 milestone candidate 자연 (v6.3 책임 vs candidate_draft schema 책임 분리).

oos_2: v6.4 cascade-sync marker 자동 drift 차단 활용 = R3 옵션 2 선택 (opt out). 본 milestone = 수동 cascade host 3 갱신 + v3.21 패턴 cycle 3 narrative 정전화 only. marker 활용 별 candidate 거명만 자연.

oos_3: v6.8 smoke-candidate-related-umbrella-split-trigger candidate 첫 발현 evidence = umbrella 확장 자연 채택 (lightweight 정합). 분리 trigger 가이드라인 별 candidate 보존.

oos_4: milestones[] / next_candidates[] schema 확장 = historical era exclusion logic 필요. 별 milestone scope.

oos_5: regex / enum 자체 변경 = schema_note 정전화 그대로 적용. 본 milestone = fixture controlled 비교 자동화 + Stage 1 검증 logic 확장만.

oos_6: source/rationale/decision_pending 의 detailed 형식 검증 = 자유 텍스트 본질 보존. 단순 non-empty + length 검증만.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code docs (code.claude.com/docs)", "finding": "smoke / hook / sub-agent fixture-based controlled 비교 패턴 first-class 명시 부재 — v5.7 spec-drift spike (c) DESIGN 즉시 정정 분기 자연 발현 8번째 (v6.6 cycle 1 첫 발현 시점 7번째 → v6.12 cycle 2 자연 발현 8번째). 본 repo 자체 정전화 (v6.6 phase-1 + v6.12 phase-1) 단일 source. context7 query 부재 (lightweight 정합, R3 cascade host 3 갱신 충분)."},
    {"id": "ext_2", "source": "Keep a Changelog v1.1.0 spec", "finding": "[v6.12] entry 작성 표준 = `## [v{X.Y}] - YYYY-MM-DD` heading + Added/Changed/Fixed sub-section bullet. v6.3~v6.11 CHANGELOG entry 형식 정합."}
  ],
  "codebase": [
    {"id": "cb_1", "source": "tests/smoke-audit-fact-verify.sh (v6.6 phase-1)", "finding": "fixture loop 패턴 1차 reference — (i) `FIXTURE_DIR=tests/fixtures/audit-fact-verify`, (ii) `run_case(name, expected_exit)` 함수 = script 호출 + actual vs expected 비교, (iii) 6 sub-dir 매핑 (boolean-normal=0 / boolean-mismatch=1 / table-normal=0 / table-mismatch=1 / numeric-normal=0 / empty-targets=0), (iv) Stage 5 path traversal 차단 (`/etc` reject), (v) Stage 6 5-step schema 검증 (v6.9 흡수). 본 milestone 안 동질 패턴 cycle 2 적용 자연."},
    {"id": "cb_2", "source": "tests/fixtures/audit-fact-verify/boolean-mismatch/scanner-output.md", "finding": "fixture 파일 구조 = (a) heading + narrative + (b) ```json``` 코드 블록 + (c) expected behavior narrative. expected.txt 별 파일 부재 — sub-dir name → expected exit code mapping = smoke 내부 hardcode (D7 design choice 자연). 본 milestone fixture 도 동일 구조 정합."},
    {"id": "cb_3", "source": "tests/smoke-candidate-draft-schema.sh (v6.5 + v6.8 + v6.11)", "finding": "현 3 Stage logic — Stage 1 (7 필드 + category enum) / Stage 2 (propose_next.py --scan 출력 candidate_items) / Stage 3 (next_candidates[].id regex + schema_note drift). Stage 4 신규 추가 = umbrella 확장 (R1) 자연. Stage 1 logic 확장 4 신규 검증 = 동일 python heredoc 안 누적 (별 stage 분리 부재, R2)."},
    {"id": "cb_4", "source": "tests/smoke-entry-title-guideline.sh (v6.3 phase-1)", "finding": "title length ≤ 60자 + ' + ' 부재 검증 책임 = ROADMAP/CHANGELOG 안 모든 title (milestones[]/next_candidates[]/candidate_draft[]) 망. 본 milestone candidate_draft Stage 1 안 length 검증 추가 = 책임 중복 (R4 결정 — v6.3 책임 보존). fixture 안 violation-title sub-dir 도 oos."},
    {"id": "cb_5", "source": "projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 (#1~#10 row + paragraph 본문)", "finding": "현 10 row 매트릭스 = mechanism (#3 drift 수용, #4 cascade drift, #8 cascade-sync, #9 propose-next, #10 audit-fact-verify) + 본 milestone 안 #11 row 추가 (mechanism: fixture-based smoke 자동화 패턴) + paragraph 본문 신규 (v6.6 cycle 1 → v6.12 cycle 2 evidence + R1~R4 decision narrative)."},
    {"id": "cb_6", "source": "tests/CLAUDE.md smoke 매트릭스 row smoke-candidate-draft-schema", "finding": "현 description = Stage 1~3 명시 + v6.11 phase-1 Stage 3 추가 narrative. 본 milestone 갱신 = Stage 4 추가 + Stage 1 확장 4 항목 + fixture 패턴 cycle 2 (v6.6 → v6.12) 명시."}
  ],
  "options": [
    {"id": "opt_R1", "title": "umbrella 확장 vs 별 smoke 분리", "decision": "umbrella 확장 (Stage 4 신규) — v6.6~v6.11 lightweight 누적 정합, v6.8 split-trigger candidate 첫 발현 evidence (별 milestone 거명만)"},
    {"id": "opt_R2", "title": "violation 망 범위 (minimal / standard / comprehensive)", "decision": "comprehensive — Stage 1 logic 확장 + 7 필드 violation 망라 (R4 보정 후 6 violation, title 제외)"},
    {"id": "opt_R3", "title": "ARCHITECTURE narrative 보강 (cascade host 3) vs 거명만", "decision": "host 3 보강 — cascade-sync marker 자동 drift 차단 opt out, v3.21 패턴 cycle 3 narrative 정전화 only"},
    {"id": "opt_R4", "title": "title length 책임 위치 (v6.3 보존 vs Stage 1 중복 vs cross-smoke 호출)", "decision": "v6.3 책임 보존 + fixture 안 violation-title 제외 — 책임 중복 회피"}
  ],
  "risks_identified": [
    {"id": "r1", "risk": "fixture sub-dir path drift — preview narrative 안 `tests/_fixtures/` (underscore) 표시되었으나 v6.6 실 path = `tests/fixtures/` (underscore 부재). 본 milestone 안 잘못된 path 사용 시 v6.6 패턴 정합 깨짐", "mitigation": "INTENT.Spec sc_1 안 `tests/_fixtures/...` → `tests/fixtures/...` 정정 (v6.6 cb_1 evidence 정합) — phase-1 EXECUTE 안 즉시 정정 (v5.7 spec-drift spike (c) DESIGN 즉시 정정 분기 9번째 자연 발현)"},
    {"id": "r2", "risk": "Windows cp949 콘솔 mojibake — smoke Python heredoc 안 한글/em dash 출력 시 UnicodeEncodeError 우려 (v3.0 phase-6 cp949 패턴 흡수). 본 milestone 안 Stage 4 신규 logic 추가 시 reconfigure boilerplate 의무 유지", "mitigation": "기존 Stage 1~3 logic 안 `sys.stdout.reconfigure(encoding='utf-8', errors='replace')` 존재 (v6.5 phase-1 도입) — 본 milestone Stage 4 안 별도 추가 부재 (단일 python heredoc 안 누적). smoke-python-entry-boilerplate AST audit 자동 강제 (v1.87)"},
    {"id": "r3", "risk": "Stage 4 fixture loop 안 expected exit code mapping = smoke 내부 hardcode. fixture sub-dir 추가/삭제 시 mapping 직접 갱신 의무 (drift 자동 검출 부재)", "mitigation": "v6.6 cb_1 패턴 정합 (단일 source = smoke 자체). 추가 drift 자동 검출 mechanism 별 milestone candidate 자연 (evidence base 약, lightweight 정합)"},
    {"id": "r4", "risk": "Stage 1 logic 확장 4 신규 검증 — 기존 PASS=4 카운트 변경 (현 1 PASS per ROADMAP). 회귀 검증 단계 안 baseline 변경 인지 의무", "mitigation": "controlled 비교 패턴 (v2.1 L3) 적용 — git show HEAD vs post diff. CRLF 정규화 후 출력 동치 확인. 의도된 변경 (PASS 카운트 + 신규 검증 줄 4건) 인 경우 REPORT.lessons_learned narrative 기록"},
    {"id": "r5", "risk": "ARCHITECTURE § 4 끝 매트릭스 #11 row 추가 위치 — 현 #10 (audit-fact-verify mechanism) 후 단순 append vs 별 분류 (smoke 자동화 vs audit mechanism 책임 직교)", "mitigation": "단순 #11 append default (lightweight 정합). 별 분류 = 매트릭스 재구성 본질 (별 milestone scope, evidence base 약)"},
    {"id": "r6", "risk": "v3.21 narrative 정전화 3 단계 패턴 cycle 3 적용 — cascade host 3 동시 갱신 + (c) VERIFY grep 수동 (cascade-sync marker opt out). drift 자동 차단 부재 → 수동 검증 의무", "mitigation": "VERIFY 단계 안 `grep -n 'cycle 2'` 3 host (smoke + tests/CLAUDE.md + ARCHITECTURE) 확인 의무. 별 milestone candidate (`cascade-sync-blockquote-content-auto-sync-mechanism`, next_candidates#7) 자연 후보 보존"},
    {"id": "r7", "risk": "fixture 안 ROADMAP-like JSON 파일 안 entry 가 candidate_draft schema 안 7 필드 violation 의도로 구성. smoke 가 fixture 호출 시 (i) projects/*/ROADMAP.md glob 안 fixture 포함 vs (ii) fixture 명시적 path 호출 (별 entry-point) 두 갈래", "mitigation": "(ii) 명시적 path 호출 default (v6.6 cb_1 패턴 정합 — `audit_fact_verify.py --dir <fixture>`). 본 milestone 안 smoke Stage 4 logic 안 fixture path 명시 호출 (별 함수 또는 분기 logic). projects/*/ROADMAP.md glob 안 fixture path 포함 부재 (path 분리)"}
  ]
}
```

### Findings narrative

본 RESEARCH 단계 안 핵심 발견:

1. **v6.6 fixture path = `tests/fixtures/` (underscore 부재)** — preview narrative 안 `tests/_fixtures/` 잘못 표시. INTENT.Spec 안 path 정정 의무 (r1, EXECUTE 안 즉시 정정 = v5.7 spike (c) 분기 9번째).
2. **fixture 파일 구조 = heading + narrative + ```json``` + expected narrative** — `expected.txt` 별 파일 부재 (sub-dir name → exit code mapping = smoke 내부 hardcode, v6.6 cb_2). 본 milestone fixture 도 동일 구조.
3. **Stage 4 logic = python heredoc 안 누적** — 별 Stage 분리 logic (별 python heredoc) 부재 (v6.6 패턴 정합). Stage 1 logic 확장 4 신규 검증 = 동일 python heredoc 안 누적 (cb_3).
4. **ARCHITECTURE § 4 끝 매트릭스 = 10 row** — #11 row append default (lightweight, cb_5). 매트릭스 재분류 별 milestone scope.
5. **v6.3 책임 보존 (R4) evidence = cb_4** — title length 검증 = ROADMAP/CHANGELOG path 망. candidate_draft schema Stage 1 안 length 검증 추가 = 책임 중복.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "topic": "umbrella 확장 vs 분리", "decision": "umbrella 확장 — Stage 4 신규 추가 (lightweight 정합, R1)"},
    {"id": "D2", "topic": "violation 망 범위", "decision": "comprehensive — Stage 1 logic 확장 + 6 violation fixture (title 제외, R2 + R4)"},
    {"id": "D3", "topic": "ARCHITECTURE narrative 보강", "decision": "cascade host 3 — smoke + tests/CLAUDE.md + ARCHITECTURE § 4 끝 매트릭스 #11 row (R3). cascade-sync marker opt out (oos_2)"},
    {"id": "D4", "topic": "title length 책임", "decision": "v6.3 smoke 책임 보존 + fixture 안 violation-title 제외 (R4)"},
    {"id": "D5", "topic": "fixture path naming", "decision": "`tests/fixtures/candidate-draft-schema/` (underscore 부재, v6.6 cb_1 정합). INTENT.Spec 원본 `tests/_fixtures/...` 정정 의무 (r1 mitigation = EXECUTE 안 즉시 정정, v5.7 spec-drift spike (c) 9번째 자연 발현)"},
    {"id": "D6", "topic": "fixture sub-dir 7 종 mapping", "decision": "`{normal: 0, violation-id: 1, violation-category: 1, violation-missing-field: 1, violation-detected_at: 1, violation-rationale-too-long: 1, violation-source-empty: 1}` — smoke 내부 hardcode (v6.6 cb_2 정합)"},
    {"id": "D7", "topic": "fixture 파일 구조", "decision": "각 sub-dir 안 `roadmap.md` 파일 1건 (heading + narrative + ```json``` 코드블록 + expected behavior narrative). ROADMAP-like minimal (projects + candidate_draft + next_candidates + milestones[] 최소 필드). expected.txt 별 파일 부재 (D6 hardcode mapping)"},
    {"id": "D8", "topic": "Stage 4 logic 안 fixture 호출 mechanism", "decision": "fixture path 명시 호출 (별 entry-point) — Stage 4 안 fixture sub-dir loop + 각 sub-dir 안 `roadmap.md` path 로 Stage 1 logic 재호출 (별 함수 `validate_roadmap(path)` 분리). projects/*/ROADMAP.md glob 안 fixture 포함 부재 (r7 mitigation)"},
    {"id": "D9", "topic": "Stage 1 logic 확장 5 신규 검증 위치", "decision": "기존 python heredoc 안 누적 (별 stage 분리 부재, R2). 검증 항목 = (i) id regex `^[a-z0-9-]+$` + (ii) detected_at ISO 8601 regex `^\\d{4}-\\d{2}-\\d{2}$` + (iii) rationale length ≤ 500자 (codepoint len) + (iv) source non-empty (strip 후 len > 0) + (v) decision_pending non-empty. Stage 3 책임 = next_candidates[].id (책임 중복 부재, scope 분리). EXECUTE 직전 round 5 정정 (책임 분리 명료화) — ROADMAP next_candidates#3 candidate 자연 흡수"},
    {"id": "D10", "topic": "Stage 4 출력 형식", "decision": "v6.6 cb_1 정합 — `Stage 4 — fixture sub-dir loop (candidate-draft-schema)` 헤더 + 각 sub-dir `✓ <name> (exit=<actual>, expected=<expected>)` 또는 `✗ <name> (exit=..., expected=...)` 줄. 합계 PASS=7 FAIL=0 expected"},
    {"id": "D11", "topic": "ARCHITECTURE § 4 끝 매트릭스 #11 row 위치", "decision": "현 #10 (audit-fact-verify mechanism) 후 단순 append (lightweight, r5). #11 row 내용 = `| #11 | smoke 자동화 패턴 | fixture-based smoke controlled 비교 (sub-dir + expected exit code mapping) | v6.6 (audit-fact-verify) + v6.12 (candidate-draft-schema) |`"},
    {"id": "D12", "topic": "ARCHITECTURE paragraph 본문 위치", "decision": "현 매트릭스 직후 paragraph 본문 안 #11 row narrative 추가 — v6.6 cycle 1 → v6.12 cycle 2 evidence + Anthropic spec 안 first-class 패턴 부재 (v5.7 spike (c) 자연 발현 cycle 누적) + 본 repo 자체 정전화 단일 source narrative"},
    {"id": "D13", "topic": "phase 수", "decision": "1-phase 통합 (lightweight 누적 12/24 → 13/25 = 52% 정합, v3.18 1-phase paragraph 정합)"},
    {"id": "D14", "topic": "v3.21 narrative 정전화 3 단계 패턴 적용", "decision": "(a) RESEARCH cb_1~cb_6 안 1차 source 식별 완료 / (b) EXECUTE 안 3 host (smoke + tests/CLAUDE.md + ARCHITECTURE) 동시 Edit / (c) VERIFY 안 `grep -n 'cycle 2\\|v6.12'` 3 host 확인. cascade-sync marker opt out → 수동 grep (r6 mitigation)"}
  ],
  "approach": {
    "summary": "1-phase 통합 — (Step 1) fixture 7 sub-dir 신규 (`tests/fixtures/candidate-draft-schema/`) + (Step 2) smoke Stage 4 신규 + Stage 1 logic 확장 (`tests/smoke-candidate-draft-schema.sh`) + (Step 3) ARCHITECTURE § 4 끝 매트릭스 #11 row + paragraph 신규 + (Step 4) tests/CLAUDE.md smoke 매트릭스 행 갱신 + (Step 5) CHANGELOG.md [v6.12] entry + (Step 6) 도그푸드 (bash tests/smoke-candidate-draft-schema.sh PASS) + (Step 7) ROADMAP milestones[] v6.12 in_progress → completed 갱신 (REPORT 단계 후)",
    "rollback_strategy": "phase commit revert (git revert <phase-1 SHA>) — controlled 비교 패턴 적용 (baseline HEAD vs post). 의도되지 않은 회귀 시 phase commit revert (r4 mitigation)"
  },
  "phases": [
    {"id": "phase_1", "title": "통합 EXECUTE — fixture + smoke + ARCHITECTURE + tests/CLAUDE.md + CHANGELOG", "scope": "Step 1~5 통합 single commit", "expected_changes": [
      "신규: tests/fixtures/candidate-draft-schema/{normal,violation-id,violation-category,violation-missing-field,violation-detected_at,violation-rationale-too-long,violation-source-empty}/roadmap.md (7 파일)",
      "수정: tests/smoke-candidate-draft-schema.sh (Stage 4 신규 + Stage 1 logic 확장 4 항목)",
      "수정: projects/meta/ARCHITECTURE.md (§ 4 끝 매트릭스 #11 row + paragraph 본문 신규)",
      "수정: tests/CLAUDE.md (smoke 매트릭스 행 description 갱신)",
      "수정: CHANGELOG.md ([v6.12] entry 추가)",
      "수정: projects/meta/milestones/v6.12/MILESTONE.md (## VERIFY + ## REPORT + ## PROPOSE 본문 채움)",
      "수정: projects/meta/ROADMAP.md (milestones[] v6.12 status in_progress → completed)"
    ]}
  ],
  "risk_mitigation": [
    {"risk_id": "r1", "mitigation": "INTENT.Spec sc_1 안 path 정정 EXECUTE 안 즉시 (`tests/_fixtures/` → `tests/fixtures/`). v5.7 spike (c) 9번째 자연 발현 narrative VERIFY 안 명시"},
    {"risk_id": "r2", "mitigation": "기존 reconfigure boilerplate 보존 (단일 python heredoc 안 Stage 1~4 누적). smoke-python-entry-boilerplate AST audit 자동 강제"},
    {"risk_id": "r3", "mitigation": "v6.6 패턴 정합 (단일 source = smoke 자체). 추가 drift 자동 검출 별 milestone candidate 자연"},
    {"risk_id": "r4", "mitigation": "controlled 비교 패턴 (git show HEAD vs post diff). 의도된 변경 narrative 기록"},
    {"risk_id": "r5", "mitigation": "#11 단순 append (lightweight)"},
    {"risk_id": "r6", "mitigation": "VERIFY 안 grep 3 host 수동 확인. 별 candidate 보존"},
    {"risk_id": "r7", "mitigation": "fixture path 명시 호출 default (D8). glob 분리 보존"}
  ]
}
```

### 5 관점 inline self-review (cycle 8)

**(1) architecture** — D1 umbrella 확장 / D13 1-phase 통합 = v6.6~v6.11 lightweight 누적 50% 정합. D11 #11 단순 append = 매트릭스 재구성 회피 (lightweight). PASS-with-comments — P2#1 = ARCHITECTURE § 4 매트릭스 #11 row 위치 (현 #10 audit-fact-verify mechanism 후) = audit / verify mechanism 책임 분류 vs smoke 자동화 책임 분리 자연도 약. 별 분류 milestone candidate 자연 (lightweight 보존, 본 milestone scope 외).

**(2) spec-drift** — D5 fixture path 정정 (`tests/_fixtures/` → `tests/fixtures/`) = v5.7 spec-drift spike (c) DESIGN 즉시 정정 분기 9번째 자연 발현. PASS — Anthropic Claude Code spec 안 fixture-based 패턴 first-class 부재 (ext_1) → 본 repo 자체 정전화 단일 source 정합. P2#2 = D9 detected_at regex (`^\\d{4}-\\d{2}-\\d{2}$`) = ISO 8601 date format full 정합 부재 (시각/timezone 제외). 본 milestone scope = date 만 (datetime 별 milestone, oos_5).

**(3) security** — D7 fixture 파일 구조 = ROADMAP-like minimal (외부 source 인용 부재). D8 fixture path 명시 호출 = projects/*/ROADMAP.md glob 분리 (r7 mitigation). PASS — path traversal 차단 logic v6.6 Stage 5 패턴 적용 검토 필요. P2#3 = Stage 4 안 fixture path 명시 호출 시 path traversal 차단 logic 부재 (v6.6 Stage 5 별 검증 = `/etc` reject). 본 milestone fixture path = repo 내부 hardcode (smoke 내부 enum) → 외부 path 가능성 부재 → traversal 위험 부재. 별 Stage 검증 부재 자연 (단순도 정합).

**(3') dictionary-semantics** — D11 #11 row "fixture-based smoke controlled 비교" = 단어 의미 정합 (사전적 "controlled experiment" = 통제 변수 조작 후 결과 측정). PASS-with-comments — P3#1 = D10 "Stage 4 — fixture sub-dir loop (candidate-draft-schema)" 헤더 안 "loop" 단어 = 반복 본질 정합 (각 sub-dir 순회). 명사 종결 — entry title 가이드 4 원칙 (3) active form 약 (v6.7 PROPOSE 안 active-form-3-step-chain-retitle candidate 패턴 정합). 본 milestone scope 외 (재진입 부담).

**(4) story** — pre-PLAN 4 round 결정 narrative (R1~R4) = INTENT.Motivation 안 압축 + DESIGN.decisions 안 D1~D4 cross-reference. PASS — 사용자 (비개발자) 스무고개 방식 milestone 결정 정합 (메모리 feedback_iterative_dialog). R3 옵션 2 선택 (cascade-sync marker opt out) narrative = oos_2 + r6 보존. P3#2 = R3 narrative 안 "host 3" 카운트 = (i) smoke 자체 + (ii) tests/CLAUDE.md + (iii) ARCHITECTURE 셋. 4 host 까지 확장 시 (예: projects/meta/CLAUDE.md 도 추가) cycle 4 자연 발현 evidence 누적 후 별 milestone candidate. 본 milestone scope 외.

**(5) testing-discipline** — sc_6 도그푸드 (bash tests/smoke-candidate-draft-schema.sh PASS) + sc_8 pre-commit 11 hook 모두 PASS = 회귀 검증 4-step 패턴 (v2.1 L3 controlled 비교) 적용. PASS — fixture 7 sub-dir 안 violation 자동 차단 mechanism 자체 fixture 패턴 정합. 별 controlled 비교 4-step 필요 부재 (자동화 본질). P2#4 = Stage 4 fixture loop 안 expected exit code mapping 변경 시 drift 자동 검출 부재 (r3 mitigation 보존). 별 milestone candidate 자연 (lightweight 보존, evidence base 약).

**5 관점 종합** — decisive 0건 + P2 4건 (architecture #1 row 위치 / spec-drift #2 ISO datetime / security #3 path traversal / testing #4 mapping drift) + P3 2건 (dictionary #1 active form / story #2 host 카운트 확장). 모두 narrative 흡수 또는 별 milestone 거명만 (lightweight 정합, v6.6~v6.11 누적 7 cycle 패턴 정합). cycle 8 도그푸드.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-20",
    "approval_summary": "EXECUTE phase-1 통합 승인 — fixture 7 sub-dir 신규 + smoke Stage 4 추가 + Stage 1 logic 확장 4 항목 + ARCHITECTURE § 4 끝 매트릭스 #11 row + tests/CLAUDE.md + CHANGELOG. 1-phase 통합 (lightweight 누적 13/25 = 52% 정합).",
    "approved_scope": [
      "tests/fixtures/candidate-draft-schema/{normal + 6 violation}/roadmap.md (7 파일 신규)",
      "tests/smoke-candidate-draft-schema.sh (Stage 4 신규 + Stage 1 logic 확장 4 항목)",
      "projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 #11 row + paragraph 본문 신규",
      "tests/CLAUDE.md smoke 매트릭스 행 description 갱신",
      "CHANGELOG.md [v6.12] entry 추가",
      "projects/meta/milestones/v6.12/MILESTONE.md (## VERIFY + ## REPORT + ## PROPOSE 본문)",
      "projects/meta/ROADMAP.md milestones[] v6.12 status in_progress → completed (REPORT 후)"
    ],
    "pre_plan_rounds": ["R1 umbrella 확장 (Stage 4 신규)", "R2 comprehensive (Stage 1 logic 확장 + 6 violation 망)", "R3 cascade host 3 (smoke + tests/CLAUDE.md + ARCHITECTURE)", "R4 v6.3 책임 보존 + violation-title 제외"],
    "five_perspective_review": "cycle 8 inline self-review — decisive 0 + P2 4 + P3 2 (모두 narrative 흡수 또는 별 milestone 거명만, lightweight 정합)"
  }
}
```

## EXECUTE

_(APPROVE 후 phase 별 별책 execute/phase-{n}.md 안 진행. 본 섹션은 phase 요약.)_

## VERIFY

### Spec

```json
{
  "smoke": [
    {"id": "sc_6", "check": "bash tests/smoke-candidate-draft-schema.sh", "result": "PASS=11 FAIL=0 — Stage 1 1 ROADMAP entry (candidate_draft 비어있음, no-op) + Stage 2 dedupe_stats + Stage 3 schema_note + next_candidates 13건 + Stage 4 fixture 7 sub-dir (normal=0 + violation 6=1) actual_exit vs expected mapping 모두 일치"},
    {"id": "sc_8", "check": "pre-commit run --all-files", "result": "11 hook 모두 PASS (1차 FAIL evidence — smoke-entry-title-guideline CHANGELOG L17 안 ' + ' marker 위반 → ' · ' 정정 → 재호출 PASS, EXECUTE 안 controlled 비교 패턴 정합)"}
  ],
  "criteria_check": [
    {"sc": "sc_1", "result": "PASS — tests/smoke-candidate-draft-schema.sh 안 Stage 4 신규 추가 + tests/fixtures/candidate-draft-schema/ 7 sub-dir (normal + violation 6) + expected exit code mapping smoke 내부 hardcode + validate_candidate_draft() 함수 재호출 silent mode"},
    {"sc": "sc_2", "result": "PASS — Stage 1 logic 확장 5 신규 검증 (id regex / detected_at ISO / rationale length / source non-empty / decision_pending non-empty) 추가. Stage 3 책임 = next_candidates[].id (scope 분리, 책임 중복 부재)"},
    {"sc": "sc_3", "result": "PASS — projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 #11 row 신규 추가 + paragraph 본문 신규 (v6.6 cycle 1 → v6.12 cycle 2 evidence + R1~R4 narrative). cascade host 3 = smoke + tests/CLAUDE.md + ARCHITECTURE § 4 끝 #11"},
    {"sc": "sc_4", "result": "PASS — tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행 description 갱신 (Stage 1·2·3·4 4 단계 명시 + Stage 1 logic 5 신규 검증 + Stage 4 fixture 7 sub-dir + fixture 패턴 cycle 2 narrative)"},
    {"sc": "sc_5", "result": "PASS — CHANGELOG.md [v6.12] entry 추가 (Keep a Changelog v1.1.0 정합 + entry title 가이드 4 원칙 정합, ' + ' marker EXECUTE 안 1차 회귀 발견 후 정정)"},
    {"sc": "sc_6", "result": "PASS — bash tests/smoke-candidate-draft-schema.sh 결과 PASS=11 FAIL=0 (Stage 1 + Stage 2 + Stage 3 + Stage 4 fixture 7 sub-dir 모두 expected exit code 일치). 도그푸드 중 1차 회귀 — violation-rationale-too-long fixture rationale length 498자 (target > 500) → 정정 후 PASS"},
    {"sc": "sc_7", "result": "PENDING — REPORT 단계 후 v6.12 entry status `in_progress` → `completed` 갱신 (REPORT 직후 step)"},
    {"sc": "sc_8", "result": "PASS — pre-commit run --all-files 결과 11 hook 모두 PASS (1차 smoke-entry-title-guideline FAIL evidence 보존, 정정 후 재호출 PASS)"},
    {"sc": "sc_9", "result": "PASS — grep 'fixture-based smoke 자동화\\|cycle 2' cascade host 3 모두 hit (smoke + tests/CLAUDE.md + ARCHITECTURE) + MILESTONE.md 4번째 host 자연 (1차 source 자체)"}
  ],
  "regression_check": [
    {"id": "rc_1", "scope": "Stage 1 logic 확장 5 신규 검증 — 기존 candidate_draft[] 안 entry 영향", "result": "PASS — projects/meta/ROADMAP.md candidate_draft 비어있음 (v6.12 promote 후), projects/upbit/ROADMAP.md candidate_draft 부재. 영향 entry 0건. SIZE_LIMIT 100KB 초과 부재"},
    {"id": "rc_2", "scope": "Stage 4 fixture loop 안 validate_candidate_draft() 재호출 = Stage 1 안 호출과 동일 logic. 분리 logic 부재 (단일 source 책임 분리 본질 정합, v6.6 D8 패턴)", "result": "PASS — 도그푸드 PASS=11 검증"},
    {"id": "rc_3", "scope": "ARCHITECTURE § 4 끝 매트릭스 #11 row + paragraph 본문 신규 — 기존 #1~#10 row + 다른 paragraph 영향", "result": "PASS — append-only 변경 (현 paragraph 본문 #8/#9/#10 hash 영향 부재 = cascade-sync marker drift 부재, smoke-cascade-drift PASS)"},
    {"id": "rc_4", "scope": "v6.12 milestone 산출물 smoke-spec-verification + smoke-scope-contract 영향", "result": "PASS — v6.12 INTENT/RESEARCH/DESIGN/APPROVE/VERIFY 5 stage 모두 ```json``` 보유 시 PASS, REPORT/PROPOSE 부재 SKIP 정상"}
  ],
  "verdict": "PASS — sc_1~sc_6, sc_8, sc_9 모두 PASS, sc_7 REPORT 단계 후 보류. 1차 회귀 2건 (rationale 길이 부족 + ' + ' marker) EXECUTE 안 즉시 정정. 회귀 0 도달"
}
```

## REPORT

### Spec

```json
{
  "summary": "v6.11 lessons L3 origin 직접 해소 — violation 주입 controlled 비교 수동 (bash + python heredoc 1 종, id regex만) → 자동화 fixture sub-dir 패턴 cycle 2 (v6.6 cycle 1 동질 mechanism 적용). 결과: (1) tests/smoke-candidate-draft-schema.sh Stage 4 신규 + Stage 1 logic 확장 5 신규 검증 + validate_candidate_draft() 함수 추출. (2) tests/fixtures/candidate-draft-schema/ 7 sub-dir 신규 (normal + 6 violation). (3) ARCHITECTURE § 4 끝 매트릭스 #11 row + paragraph 본문 신규 (v3.21 narrative 정전화 3 단계 패턴 cycle 3). (4) tests/CLAUDE.md smoke 매트릭스 행 + CHANGELOG [v6.12] entry. pre-PLAN 4 round + EXECUTE 직전 round 5 정정 (책임 분리 명료화) + 5 관점 inline self-review cycle 8. lightweight 1-phase 누적 15/27 = 55.6% (v6.6~v6.12 7 consecutive lightweight).",
  "delta": {
    "files_created": [
      "tests/fixtures/candidate-draft-schema/normal/roadmap.md",
      "tests/fixtures/candidate-draft-schema/violation-id/roadmap.md",
      "tests/fixtures/candidate-draft-schema/violation-category/roadmap.md",
      "tests/fixtures/candidate-draft-schema/violation-missing-field/roadmap.md",
      "tests/fixtures/candidate-draft-schema/violation-detected_at/roadmap.md",
      "tests/fixtures/candidate-draft-schema/violation-rationale-too-long/roadmap.md",
      "tests/fixtures/candidate-draft-schema/violation-source-empty/roadmap.md",
      "projects/meta/milestones/v6.12/MILESTONE.md"
    ],
    "files_modified": [
      "tests/smoke-candidate-draft-schema.sh (header docstring + Stage 1 logic 함수 추출 + 5 신규 검증 + Stage 4 fixture loop)",
      "projects/meta/ARCHITECTURE.md (§ 4 끝 매트릭스 #11 row + paragraph 본문 신규)",
      "tests/CLAUDE.md (smoke 매트릭스 행 description 갱신)",
      "CHANGELOG.md ([v6.12] entry 추가, ' + ' marker 1차 회귀 후 ' · ' 정정)",
      "projects/meta/ROADMAP.md (candidate_draft 비움 + milestones[] v6.12 in_progress entry + updated 갱신)"
    ],
    "phase_count": 1,
    "commit_count_expected": 1
  },
  "lessons_learned": [
    {"id": "L1", "label": "P1", "lesson": "violation 주입 controlled 비교 자동화 = fixture sub-dir 패턴 cycle 2 (v6.6 cycle 1 → v6.12 cycle 2). evidence-base trigger 2건 도달 시 자연 정전화 (ARCHITECTURE § 4 끝 #11 row)"},
    {"id": "L2", "label": "P1", "lesson": "EXECUTE 직전 round 5 정정 evidence — pre-PLAN 4 round 결정 (R1~R4) 후 EXECUTE 단계 시작 직전에도 INTENT/DESIGN 모순 발견 가능 (책임 분리 명료화). 'Stage 3 책임 보존' narrative 가 candidate_draft[].id regex 검증 부재 evidence 직접 발견 → Stage 1 안 5 신규 검증 (4 → 5). 메모리 feedback_iterative_pre_plan_review 정합"},
    {"id": "L3", "label": "P1", "lesson": "violation-rationale-too-long fixture rationale length 498자 (target > 500) — 도그푸드 1차 회귀 evidence. fixture 작성 시 boundary value 측정 의무 (실 length 계산 후 작성). 정정 후 PASS 도달"},
    {"id": "L4", "label": "P2", "lesson": "smoke-entry-title-guideline (v6.3) 안 ' + ' marker 검증 = bullet bold header (`- **<title>**`) 안 title 만 적용, body narrative 무시 — body 안 ' + ' free 허용. bold header 안 두 본질 결합 marker 회피 의무 (' · ' / '및' / 괄호 대체)"},
    {"id": "L5", "label": "P1", "lesson": "ARCHITECTURE § 4 끝 매트릭스 #11 row + paragraph 본문 append-only 변경 = 기존 #1~#10 hash 영향 부재 (cascade-sync marker drift 부재). 매트릭스 row 추가는 cascade host 단일 source 분리 본질 정합"},
    {"id": "L6", "label": "P2", "lesson": "lightweight 1-phase 누적 7 consecutive (v6.6~v6.12) = 15/27 = 55.6% 도달. v3.18 1-phase paragraph 정합 + lightweight 모드 (v3.6 정전화) 7 consecutive 자연 cycle. 50% 첫 돌파 (v6.9) → 55% 두 번째 돌파 (v6.12)"},
    {"id": "L7", "label": "P1", "lesson": "fixture-based smoke 자동화 패턴 = 본 repo 자체 정전화 단일 source (Anthropic Claude Code spec 안 first-class 패턴 부재, v5.7 spec-drift spike (c) 10번째 자연 발현). v6.6 = subprocess (별 script) / v6.12 = in-process (함수 분리) — 책임 단일 source 분리 본질 동일"},
    {"id": "L8", "label": "P2", "lesson": "5 관점 inline self-review cycle 8 = decisive 0 + P2 4 + P3 2 = 6 issue 모두 narrative 흡수 또는 별 milestone 거명만 (lightweight 정합). architecture #1 row 위치 + spec-drift #2 ISO datetime + security #3 path traversal + testing #4 mapping drift = P2 / dictionary #1 active form + story #2 host 카운트 확장 = P3"}
  ],
  "next_candidates_named_only": [
    {"id": "violation-title-fixture-via-v6-3-smoke-cross-call", "rationale": "L1 + R4 origin — title length 위반 fixture = v6.3 smoke (smoke-entry-title-guideline) 책임 보존 default. fixture 파일 안 length 위반 자동 차단 mechanism 부재 (path 분리, v6.3 = ROADMAP/CHANGELOG path 만). cross-smoke 호출 또는 별 path 등록 mechanism candidate. evidence 누적 시 별 milestone"},
    {"id": "fixture-mapping-drift-auto-detect", "rationale": "L4 origin — Stage 4 expected exit code mapping = smoke 내부 hardcode. fixture sub-dir 추가/삭제 시 mapping 직접 갱신 의무 (drift 자동 검출 부재). 별 mechanism candidate (예: smoke 안 mapping vs 디렉토리 enumerate 비교)"},
    {"id": "architecture-section-4-end-matrix-row-reclassification", "rationale": "5 관점 architecture P2#1 origin — § 4 끝 매트릭스 #11 row 위치 (현 #10 audit-fact-verify mechanism 후 단순 append) = audit / verify mechanism vs smoke 자동화 패턴 책임 분류 자연도 약. 별 분류 candidate (evidence 누적 시 매트릭스 재구성 본질 별 milestone scope)"},
    {"id": "detected-at-iso-8601-datetime-extension", "rationale": "5 관점 spec-drift P2#2 origin — Stage 1 logic 확장 (ii) detected_at regex `^\\d{4}-\\d{2}-\\d{2}$` = ISO 8601 date 만 (datetime + timezone 제외). 미래 detected_at 안 시각 포함 evidence 누적 시 별 milestone candidate"}
  ]
}
```

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "violation-title-fixture-via-v6-3-smoke-cross-call",
      "title": "title length 위반 fixture v6.3 smoke cross-call mechanism",
      "trigger": "D_design",
      "origin_milestone": "v6.12",
      "target_version": "v6.x",
      "description": "L1 + R4 origin — title length 위반 fixture = v6.3 smoke 책임 보존 default (oos_1). fixture 파일 안 length 위반 자동 차단 mechanism 부재 (v6.3 = ROADMAP/CHANGELOG path 만). cross-smoke 호출 또는 별 path 등록 mechanism candidate. evidence 누적 시 별 milestone."
    },
    {
      "id": "fixture-mapping-drift-auto-detect",
      "title": "Stage 4 fixture mapping drift 자동 검출 mechanism",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.12",
      "target_version": "v6.x",
      "description": "L4 + r3 origin — Stage 4 expected exit code mapping = smoke 내부 hardcode. fixture sub-dir 추가/삭제 시 mapping 직접 갱신 의무 (drift 자동 검출 부재). 별 mechanism candidate — smoke 안 mapping vs 디렉토리 enumerate 비교 logic 추가."
    },
    {
      "id": "architecture-section-4-end-matrix-row-reclassification",
      "title": "ARCHITECTURE § 4 끝 매트릭스 row 분류 재구성",
      "trigger": "D_design",
      "origin_milestone": "v6.12",
      "target_version": "v6.x",
      "description": "5 관점 architecture P2#1 origin — § 4 끝 매트릭스 #11 row 위치 (현 #10 audit-fact-verify mechanism 후 단순 append) = audit / verify mechanism vs smoke 자동화 패턴 책임 분류 자연도 약. 별 분류 candidate (evidence 누적 시 매트릭스 재구성 본질 별 milestone scope)."
    },
    {
      "id": "detected-at-iso-8601-datetime-extension",
      "title": "detected_at ISO 8601 datetime regex 확장",
      "trigger": "D_design",
      "origin_milestone": "v6.12",
      "target_version": "v6.x",
      "description": "5 관점 spec-drift P2#2 origin — Stage 1 logic 확장 (ii) detected_at regex `^\\d{4}-\\d{2}-\\d{2}$` = ISO 8601 date 만 (datetime + timezone 제외). 미래 detected_at 안 시각 포함 evidence 누적 시 별 milestone candidate."
    }
  ],
  "propose_narrative": "5 관점 inline self-review cycle 8 P2 4 + P3 2 = 6 issue 모두 narrative 흡수 또는 별 milestone 거명만 (lightweight 정합). EXECUTE lessons L1~L8 안 후속 candidate 거명. lightweight 모드 정책 정합 (v3.13/v3.14 동결 + v4.0 § 6.2 폐지 narrative + memory feedback_section_6_2_abolished). 사용자 명시 발의 trigger 후 ROADMAP next_candidates[] 등재 (자동 등재 회피). v6.11 PROPOSE 안 3 candidate (smoke-stage-3-tests-fixture-pattern = 본 milestone 직접 origin 흡수 / schema-note-target-version-regex-validation = passing carry-over / candidate-draft-id-regex-extension = Stage 1 안 자연 흡수, mechanism 위치 다름) 처리. 본 milestone 4 candidate 등재 시 ROADMAP next_candidates 누적 14건 (현 13건 + 본 4건 - 1건 흡수 - 0 stable)."
}
```

### PROPOSE narrative

본 milestone = v6.11 직접 후속 + lightweight 1-phase (v6.6~v6.12 7 consecutive lightweight 누적 15/27 = 55.6%). 후속 candidates 4건 = v6.12 lessons (L1+R4 cross-smoke / L4 mapping drift / 5 관점 P2 architecture row 분류 / P2 spec-drift ISO datetime) 직접 origin. 등재 candidate scope = v6.x 후속 milestone 자연.

fixture-based smoke 자동화 패턴 cycle 2 정전화 (ARCHITECTURE § 4 끝 매트릭스 #11 row) 자체가 본 milestone 최대 성과 — Anthropic Claude Code spec 안 first-class 패턴 부재 (v5.7 spec-drift spike (c) 10번째 자연 발현) → 본 repo 자체 정전화 단일 source 도달. v6.6 cycle 1 → v6.12 cycle 2 evidence-base trigger 2건 도달 시 자연 정전화 사이클 정합 (v3.21 narrative 정전화 3 단계 패턴 cycle 3 동시 적용).

v6.11 PROPOSE 안 3 candidate 처리:

1. `smoke-stage-3-tests-fixture-pattern` (v6.11 PROPOSE next_candidates#1) = 본 milestone 직접 origin (candidate_draft → milestones[] promote, /propose-next 자율 mechanism 첫 실 작동 + 사용자 명시 결정 + OPEN 진입 cycle)
2. `schema-note-target-version-regex-validation` (v6.11 PROPOSE next_candidates#2) = passing carry-over (ROADMAP 등재 부재, evidence 누적 시 별 milestone)
3. `candidate-draft-id-regex-extension` (v6.11 PROPOSE next_candidates#3) = 본 milestone Stage 1 안 id regex 추가로 자연 흡수 (검증 effect 동일, mechanism 위치 다름 — 책임 분리)

## SUB_MILESTONES

본 milestone = single-scope 본질 (lightweight 1-phase 누적 15/27 = 55.6% 정합, v3.18 1-phase paragraph 정합). sub-milestone 부재 — bundling 의미 grouping 대상 부재 (단일 후속 candidate v6.11 L3 origin → 1-phase 통합 직접 적용).

| sub-id | title | status | phase | 비고 |
|---|---|---|---|---|
| — | — | — | — | single-scope 본질, sub-milestone 부재 |

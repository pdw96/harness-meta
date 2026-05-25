---
id: id-regex-validation-smoke
title: ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입
version: v6.11
status: completed
---

# v6.11 — ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입

## INTENT

### Spec

```json
{
  "id": "id-regex-validation-smoke",
  "title": "ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입",
  "goal": "v6.10 L4 origin 직접 해소 — v6.10 OPEN 시 ROADMAP next_candidates#3 안 한국어 id (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) 가 schema_note `^[a-z0-9-]+$` 위반 발견. v6.10 안 영문 변환 직접 적용 만 (smoke 부재) → 향후 회귀 차단 mechanism 부재. 해소 = `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (candidate-related umbrella 자연 흡수, ROADMAP next_candidates#11 description 명시) — projects/*/ROADMAP.md 안 next_candidates[].id regex `^[a-z0-9-]+$` 검증 + v6.10 L7 가이드라인 정합 (smoke hardcode regex + schema_note 명시값 일치 검증, 2 위치 drift 자동 차단). lightweight 1-phase 통합 1 commit 패턴 (v6.6~v6.10 누적 정합).",
  "success_criteria": [
    {"id": "sc_1", "description": "`tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 — projects/*/ROADMAP.md 안 next_candidates[].id 가 regex `^[a-z0-9-]+$` 정합 검증. id 부재 entry SKIP (legacy era 안전, 별 milestone `propose-next-legacy-era-id-backfill` candidate 보존)."},
    {"id": "sc_2", "description": "Stage 3 안 schema_note 일치 검증 — projects/meta/ROADMAP.md 안 schema_note 본문 안 regex 명시값 (`^[a-z0-9-]+$`) 과 smoke hardcode regex 동일 확인 (v6.10 L7 가이드라인 정합: regex·패턴 안 실 사용 logic 함께 검토). 2 위치 drift 자동 차단."},
    {"id": "sc_3", "description": "도그푸드 — `bash tests/smoke-candidate-draft-schema.sh` 호출 시 Stage 3 PASS (현재 next_candidates 14 entry 모두 영문 group-slug id, regex 정합)."},
    {"id": "sc_4", "description": "violation 주입 검증 — 임시 ROADMAP 안 한국어 id (또는 점/공백 포함 id) entry 추가 시 Stage 3 FAIL (exit 1) 정상. 검증 후 원복."},
    {"id": "sc_5", "description": "ROADMAP milestones[] 안 v6.11 in_progress entry 추가 + next_candidates[] 안 `id-regex-validation-smoke` entry 제거 (promote 자연). updated 필드 `2026-05-20-v6.11` 갱신. v5.21+ schema A2 정합."},
    {"id": "sc_6", "description": "tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행 description 갱신 — Stage 3 추가 표기 (v6.11 phase-1 신규)."},
    {"id": "sc_7", "description": "CHANGELOG.md [v6.11] entry 추가 (Keep a Changelog v1.1.0 정합). entry title 가이드 4 원칙 정합 (≤ 60자 + active form + 한 entry = 한 본질)."},
    {"id": "sc_8", "description": "pre-commit 11 hook 모두 PASS, 회귀 0. smoke 자체 변경 + ROADMAP/CHANGELOG/MILESTONE 갱신 → smoke-candidate-draft-schema 자체 + smoke-projects-scope-discipline + smoke-bundle-trigger + smoke-open-stage-discipline + smoke-entry-title-guideline + smoke-spec-verification + smoke-scope-contract + smoke-cross-ref + smoke-claude-md-drift + smoke-cascade-drift + smoke-audit-fact-verify 모두 PASS."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "candidate_draft[].id + milestones[].id regex 검증 확장", "reason": "pre-PLAN Round 1 결정 = `next_candidates[].id` 만 검증 (v6.10 직접 evidence 정합). candidate_draft[].id 는 동질 group-slug 본질이나 현 smoke-candidate-draft-schema Stage 1 안 7 필드 존재 검증만, 별 regex 검증 부재 → 별 milestone candidate 자연. milestones[].id 는 era 별 다른 schema (v3.0+ group-slug vs v2.x/v1.x flat `v{X.Y}_{slug}` 점 포함) → exclusion logic 필요, 본 scope 외."},
    {"id": "oos_2", "item": "id 부재 entry 자동 backfill (legacy era PROPOSE entry 안 id 누락)", "reason": "별 milestone candidate `propose-next-legacy-era-id-backfill` (ROADMAP next_candidates#10) 보존. 본 milestone scope = id 존재 시 regex 검증만 (id 누락 SKIP 안전)."},
    {"id": "oos_3", "item": "umbrella 분리 (별 smoke 신규 `tests/smoke-roadmap-id-regex.sh`)", "reason": "ROADMAP next_candidates#11 description 안 `tests/smoke-candidate-draft-schema.sh Stage 확장 또는 별 smoke (umbrella 분리 결정은 smoke-candidate-related-umbrella-split-trigger candidate 흡수 자연)` 명시 — 본 milestone umbrella 확장 자연 채택 (lightweight 정합). 분리 trigger 가이드라인 candidate 별 보존 (`smoke-candidate-related-umbrella-split-trigger`, next_candidates#11)."},
    {"id": "oos_4", "item": "regex 자체 변경 (예: 길이 제한 추가 / underscore 허용)", "reason": "schema_note 안 정전화된 `^[a-z0-9-]+$` 그대로 적용. 본 milestone = 자동 검증 도입만, regex 정의 변경 별 본질 (별 milestone 자연 도달 evidence base 시)."},
    {"id": "oos_5", "item": "ARCHITECTURE narrative 보강 (5 관점 review 표 본문 cascade)", "reason": "v6.10 oos_3 정합 — cascade host 부재 사실 (단일 host = harness-meta.md 표). 본 milestone scope 외, 별 candidate (`five-perspective-review-table-cascade-narrative`, next_candidates#12) 보존."},
    {"id": "oos_6", "item": "v3.21 narrative 정전화 3 단계 패턴 적용", "reason": "smoke 신규 추가 단일 host (smoke-candidate-draft-schema.sh) + tests/CLAUDE.md 매트릭스 보조 cascade 만 → cascade host 갯수 ≤ 2 안. v6.10 L3 판정 기준 (≥2 → 패턴 적용 / =1 → 적용 대상 부재) 정합 — 본 case 적용 대상 약. v6.10 패턴 misapplication 회피 결정 정합."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "tests/smoke-candidate-draft-schema.sh (v6.5 phase-1 신규 + v6.8 phase-1 Stage 2 확장)", "purpose": "본 milestone 확장 대상 — Stage 3 신규 추가 단일 host"},
    {"id": "dep_2", "source": "projects/meta/ROADMAP.md schema_note (line 7 안 `next_candidates[].id regex: ^[a-z0-9-]+$`)", "purpose": "regex 정전화 1차 source — smoke hardcode 와 일치 검증 대상"},
    {"id": "dep_3", "source": "projects/meta/milestones/v6.10/MILESTONE.md L4", "purpose": "본 milestone origin evidence (한국어 id 위반 발견 → 영문 변환 → 향후 회귀 차단 mechanism 부재 후속)"},
    {"id": "dep_4", "source": "tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행", "purpose": "Stage 3 추가 narrative 보조 cascade 갱신"}
  ]
}
```

### Motivation

v6.10 phase-1 OPEN 시점 ROADMAP next_candidates#3 안 등재 id `spec-drift-review-regex-vs-실-사용-mismatch-guideline` 가 schema_note `^[a-z0-9-]+$` 위반 발견 — 한국어 (`실-사용`) + path-safe 위반. v6.10 안 영문 변환 직접 적용 만 (`spec-drift-regex-actual-usage-mismatch-guideline`) — 다른 14 entry 모두 영문 group-slug 정합이나, **회귀 차단 mechanism 부재** = 향후 PROPOSE 단계 안 동질 위반 silent 자연 가능.

v6.10 L4 lesson 본문 직접 인용:

> ROADMAP next_candidates#3 안 등재 id 한국어 (`spec-drift-review-regex-vs-실-사용-mismatch-guideline`) = schema_note `^[a-z0-9-]+$` 위반. 본 milestone OPEN 시 영문 변환 (`spec-drift-regex-actual-usage-mismatch-guideline`) — 변환 trace INTENT.Motivation 안 보존. 향후 PROPOSE 단계 안 id schema 검증 smoke 추가 후보 (id-regex-validation-smoke 거명만).

해소 = `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (candidate-related umbrella 확장 자연). v6.10 L7 가이드라인 (regex·패턴 안 실 사용 logic 함께 검토) 자기 적용 — smoke hardcode regex `^[a-z0-9-]+$` + projects/meta/ROADMAP.md 안 schema_note 명시값 grep 후 일치 검증 (2 위치 drift 자동 차단). 즉 (i) regex 자체 검증 logic + (ii) regex 정의 위치 drift 검증 logic 동시 자동화.

**pre-PLAN 2 round 누적 결정** (2026-05-20):

1. **scope** — `next_candidates[].id` 만 (v6.10 직접 evidence). candidate_draft / milestones[] 별 milestone candidate 보존.
2. **regex 위치** — smoke hardcode + schema_note 일치 검증 (v6.10 L7 가이드라인 정합, drift 자동 검출).

본 milestone = v6.10 직접 후속 + lightweight 1-phase (v6.6~v6.10 누적 패턴 정합).

### Out of scope rationale

oos_1: candidate_draft[].id / milestones[].id 확장 = 본 case scope 외. milestones[].id 안 historical era v2.x/v1.x flat `v{X.Y}_{slug}` 형식 (점 포함) 위반 보유 — exclusion 또는 era 분리 필요 → 복잡도 증가. evidence base 약함 (v6.10 직접 evidence 만).

oos_2: id 부재 entry 자동 backfill = 별 milestone candidate (`propose-next-legacy-era-id-backfill`) 보존. 본 milestone scope = id 존재 시 regex 검증만.

oos_3: 별 smoke 신규 = umbrella 확장 자연 채택 (lightweight 정합). 분리 trigger 가이드라인 별 candidate 보존.

oos_4: regex 자체 변경 = schema_note 정전화 그대로 적용. 본 milestone = 자동 검증 도입만.

oos_5: ARCHITECTURE narrative 보강 = v6.10 oos_3 정합 (cascade host 부재). 별 candidate 보존.

oos_6: v3.21 패턴 적용 = cascade host ≤ 2 안 (smoke + tests/CLAUDE.md 매트릭스 행). v6.10 L3 판정 기준 정합 — 적용 대상 약. misapplication 회피.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "ROADMAP schema_note (projects/meta/ROADMAP.md:7) 안 `next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe)` 정전화", "verdict": "VERIFIED — v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화 + v6.5_claude-autonomous-milestone-proposal candidate_draft[] 도입 시 schema_note 안 명시. 본 milestone hardcode 대상 regex 단일 source."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "tests/smoke-candidate-draft-schema.sh:1-204", "fact": "현 구조 = Stage 1 (candidate_draft[] entry 7 필드 검증, v6.5 phase-1) + Stage 2 (propose_next.py --scan 출력 candidate_items + dedupe_stats schema 검증, v6.8 phase-1). umbrella name = 'candidate-related schema 강제'. Python heredoc + json.load + REPO_ROOT 환경 가드 + cp949 reconfigure 의무 boilerplate 적용."},
    {"id": "cb_2", "file": "projects/meta/ROADMAP.md:7", "fact": "schema_note 본문 안 `next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe)` 정확 본문. `target_version regex: ^v[0-9]+\\.[0-9]+$` (semver) 별 정전화 부재 (별 candidate 자연 발의 시점)."},
    {"id": "cb_3", "file": "projects/meta/ROADMAP.md:63-175 (next_candidates 14 entry)", "fact": "14 entry 모두 영문 group-slug id (예: `post-report-write-hook-flattened-era-trigger`, `id-regex-validation-smoke`). 모두 `^[a-z0-9-]+$` 정합 (도그푸드 PASS 기대)."},
    {"id": "cb_4", "file": "projects/upbit/ROADMAP.md", "fact": "next_candidates[] 안 entry 부재 또는 영문 group-slug id (upbit cycle 7 적용 시점 마지막 확인). 본 smoke enumerate scope = projects/*/ROADMAP.md → upbit 도 자동 포함 (umbrella 정합)."},
    {"id": "cb_5", "file": "tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행", "fact": "현 description = `Stage 1 (v6.5) + Stage 2 (v6.8)` 표기. 본 milestone phase-1 안 Stage 3 추가 표기 갱신 필요 (보조 cascade)."},
    {"id": "cb_6", "file": "tests/smoke-candidate-draft-schema.sh:30-33 (python3 부재 SKIP) + :47 (SIZE_LIMIT 100KB)", "fact": "환경 가드 + SIZE_LIMIT 패턴 = 본 milestone Stage 3 안 동일 적용 자연 (Python heredoc 안 동일 환경). 신규 환경 가드 부재."},
    {"id": "cb_7", "file": "tests/smoke-candidate-draft-schema.sh:73 (json 코드 블록 추출 regex)", "fact": "ROADMAP.md 안 ```json``` 추출 단일 source — Stage 3 안 동일 추출 logic 재사용 자연 (별 추출 불필요)."}
  ],
  "options": [
    {"id": "opt_A", "option": "Stage 3 신규 추가 (umbrella 확장, 추천)", "pros": "토큰 효율 + ROADMAP next_candidates#11 description 명시 정합 + lightweight (별 smoke 추가 부재) + Stage 1/2 의 Python heredoc 환경 가드 재사용", "cons": "umbrella name = 'candidate-related schema' → next_candidates 도 candidate-related 본질이나 약간 확장 (smoke 이름 자체는 'candidate-draft' 명시). 분리 trigger 별 candidate 보존 mitigation", "verdict": "ADOPTED (pre-PLAN 정합)"},
    {"id": "opt_B", "option": "별 smoke 신규 (`tests/smoke-roadmap-id-regex.sh`)", "pros": "smoke 이름 명료 (smoke-candidate-draft-schema 와 책임 직교)", "cons": "+1 smoke = lightweight 정합 약함. ROADMAP next_candidates#11 description 안 'umbrella 분리 결정은 smoke-candidate-related-umbrella-split-trigger candidate 흡수 자연' 명시 — 본 milestone scope 외", "verdict": "REJECTED — 별 candidate (`smoke-candidate-related-umbrella-split-trigger`) 보존"},
    {"id": "opt_C", "option": "Stage 1 안 흡수 (candidate_draft[] 7 필드 검증 + id regex 추가)", "pros": "Stage 신규 부재 (가장 lightweight)", "cons": "Stage 1 책임 (candidate_draft[] entry schema) 와 Stage 3 책임 (next_candidates[].id regex) 본질 다름 (candidate_draft = 자율 발의 큐 / next_candidates = PROPOSE 발의 후보). Stage 책임 직교 보존 자연", "verdict": "REJECTED — Stage 책임 mixing 회피"}
  ],
  "risks_identified": [
    {"id": "r_1", "risk": "regex hardcode `^[a-z0-9-]+$` 가 schema_note 명시값 (`^[a-z0-9-]+$ (group-slug, path-safe)`) 안 괄호 주석 포함 — 일치 검증 시 정확 grep 패턴 결정 필요", "severity": "low", "mitigation": "schema_note 안 regex 부분만 추출 (정확 `^[a-z0-9-]+$` substring 검색) — Python re.search 안 escape 처리. 괄호 주석 (`(group-slug, path-safe)`) 일치 검증 scope 외 (regex 자체만 비교)."},
    {"id": "r_2", "risk": "Stage 3 추가 후 도그푸드 시 PASS 기대 → 실 violation 주입 (한국어 id) 검증 시 임시 ROADMAP 수정 → 원복 누락 위험 (회귀)", "severity": "medium", "mitigation": "violation 주입 = git stash 또는 임시 별 ROADMAP 파일 (tmpdir 안) 사용 — projects/meta/ROADMAP.md 직접 수정 회피. controlled 비교 patterns (v2.1 L3 + v3.0 phase-7) 정합."},
    {"id": "r_3", "risk": "Stage 3 안 schema_note 일치 검증 logic 시 ROADMAP.md 자체 읽기 → schema_note 없는 ROADMAP (예: upbit) 안 SKIP 분기 부재 → FAIL silent", "severity": "low", "mitigation": "schema_note 일치 검증 = projects/meta/ROADMAP.md 전용 (1 위치 정전화 source). 다른 ROADMAP (upbit) 안 schema_note 부재 → Stage 3 안 메타 ROADMAP only 검증 scope 명시."},
    {"id": "r_4", "risk": "Stage 3 에러 메시지 안 위반 entry id 출력 시 한국어 등 비-ASCII 포함 가능 → cp949 콘솔 출력 fail", "severity": "low", "mitigation": "기존 Stage 1/2 동일 boilerplate (sys.stdout.reconfigure(encoding='utf-8', errors='replace')) 재사용 자연. tests/smoke-python-entry-boilerplate.sh AST audit 자동 강제."},
    {"id": "r_5", "risk": "smoke-cascade-drift hook 안 marker 본문 hash 변경 — 본 milestone 안 cascade marker 신규 부재 (단일 host) → 영향 0", "severity": "low", "mitigation": "본 milestone scope 안 cascade host 추가 부재 (oos_5 + oos_6 정합). cascade-drift hook 영향 0 기대."}
  ]
}
```

### External narrative

ROADMAP schema_note 안 `next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe)` 정전화 (v5.21 + v6.5 도입). 본 milestone hardcode regex 대상 단일 source = schema_note 명시값. v6.10 L7 가이드라인 (regex·패턴 안 실 사용 logic 함께 검토) 정합 = smoke hardcode + schema_note 일치 검증 양방향.

### Codebase narrative

`tests/smoke-candidate-draft-schema.sh` 현 구조 = Stage 1 (v6.5 candidate_draft[] 7 필드) + Stage 2 (v6.8 candidate_items + dedupe_stats). umbrella name = 'candidate-related schema 강제' — Stage 3 (next_candidates[].id regex) 흡수 자연 (candidate-related 본질 정합). Python heredoc + json.load + cp949 reconfigure boilerplate + SIZE_LIMIT 100KB 가드 모두 재사용 자연.

ROADMAP next_candidates 14 entry 모두 영문 group-slug id (도그푸드 PASS 기대). 14 entry id 예: `post-report-write-hook-flattened-era-trigger`, `id-regex-validation-smoke`, `propose-next-legacy-era-id-backfill` 등 — 모두 `^[a-z0-9-]+$` 정합.

upbit ROADMAP 안 next_candidates[] 부재 또는 영문 (cycle 7 적용 시점). Stage 3 enumerate scope = projects/*/ROADMAP.md → upbit 자동 포함 (umbrella 정합).

tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행 description 갱신 필요 (Stage 3 추가 표기, 보조 cascade).

### Options narrative

opt_A (Stage 3 추가, umbrella 확장) ADOPTED — ROADMAP next_candidates#11 description 명시 정합 + lightweight + 환경 가드 재사용. opt_B (별 smoke) REJECTED — 별 candidate (`smoke-candidate-related-umbrella-split-trigger`) 보존, lightweight 정합 약함. opt_C (Stage 1 흡수) REJECTED — Stage 책임 직교 본질 보존 (candidate_draft = 자율 발의 큐 / next_candidates = PROPOSE 발의 후보).

### Risk priorities

r_1~r_5 모두 low~medium severity, P1 위험 부재. r_2 (violation 주입 시 원복 누락) = medium → controlled 비교 패턴 (git stash 또는 tmpdir 별 ROADMAP) 적용. r_1 (regex 일치 검증 정확 substring) = mitigation 직접 적용. r_3 (메타 only scope) = scope 명시. r_4 (cp949) = 기존 boilerplate 재사용. r_5 (cascade-drift 영향 0) = cascade host 신규 부재.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "Stage 3 신규 추가 (`tests/smoke-candidate-draft-schema.sh` umbrella 확장)", "rationale": "ROADMAP next_candidates#11 description 명시 정합 + lightweight + 환경 가드 재사용 + candidate-related 본질 정합 (Stage 1 candidate_draft + Stage 2 candidate_items + Stage 3 next_candidates 모두 candidate-related).", "evidence": "RESEARCH opt_A + ROADMAP next_candidates#11 description"},
    {"id": "D2", "decision": "Stage 3 enumerate scope = projects/*/ROADMAP.md (메타 + upbit 양쪽 자동 포함)", "rationale": "Stage 1 동일 enumerate scope (line 61 `roadmaps = sorted(REPO_ROOT.glob('projects/*/ROADMAP.md'))`) 재사용 자연. 신규 ROADMAP (향후 다른 프로젝트) 자동 포함.", "evidence": "RESEARCH cb_1 + opt_A pros"},
    {"id": "D3", "decision": "Stage 3 안 regex hardcode `^[a-z0-9-]+$` (smoke 안 직접 명시) + projects/meta/ROADMAP.md schema_note 안 일치 검증 (별 Stage 3-bis 또는 Stage 3 내부 sub-step)", "rationale": "v6.10 L7 가이드라인 정합 (regex·패턴 안 실 사용 logic 함께 검토). hardcode = 명확성 + drift 자동 검출 (2 위치 비교). schema_note 일치 검증 = 향후 schema_note 변경 시 smoke 자동 fail → 사용자 명시 정정 게이트.", "evidence": "AskUserQuestion Round 2 결과 + v6.10 L7 가이드라인"},
    {"id": "D4", "decision": "id 부재 entry SKIP (legacy era 안전 mechanism)", "rationale": "별 milestone candidate `propose-next-legacy-era-id-backfill` (next_candidates#10) 보존. 본 milestone scope = id 존재 시 regex 검증만. 안전 mechanism = entry.get('id') 부재 시 continue.", "evidence": "RESEARCH oos_2"},
    {"id": "D5", "decision": "violation 주입 검증 = 임시 별 ROADMAP 파일 (tmpdir 안) 사용 — projects/meta/ROADMAP.md 직접 수정 회피", "rationale": "controlled 비교 patterns (v2.1 L3 + v3.0 phase-7) 정합. 회귀 위험 0 (실 ROADMAP 미수정).", "evidence": "RESEARCH r_2 mitigation + tests/CLAUDE.md 회귀 검증 절차"},
    {"id": "D6", "decision": "schema_note 일치 검증 scope = projects/meta/ROADMAP.md only (1 위치 정전화 source)", "rationale": "upbit 등 다른 ROADMAP 안 schema_note 부재 사실 (RESEARCH r_3). 메타 ROADMAP 단일 source 정전화 정합. Stage 3 안 scope 명시 (`if 'schema_note' in data: ...` 분기 또는 메타 only 명시).", "evidence": "RESEARCH r_3 + cb_2"},
    {"id": "D7", "decision": "phases = 1 phase 통합 (lightweight, v6.6~v6.10 누적 패턴 정합)", "rationale": "변경 4 위치 (smoke-candidate-draft-schema.sh + ROADMAP + CHANGELOG + tests/CLAUDE.md) + MILESTONE.md 자체 = 5 위치 모두 같은 본질 (Stage 3 도입 1 commit). 1+1 commit (smoke + ROADMAP/CHANGELOG/MILESTONE 한 commit + 별 commit 부재 자연).", "evidence": "v6.7/v6.8/v6.9/v6.10 lightweight 1-phase commit 패턴"},
    {"id": "D8", "decision": "review depth = Lightweight + inline self-review (subagent 부재)", "rationale": "v6.7~v6.10 lightweight 패턴 정합 + 본 scope 매우 작음 (smoke Stage 1 신규 추가) → marginal value. inline self-review 5 관점 자체 적용.", "evidence": "v6.6 5 관점 subagent saturate evidence + v6.7~v6.10 lightweight 패턴"},
    {"id": "D9", "decision": "ROADMAP milestones[] 안 v6.11 in_progress entry 추가 + next_candidates[] 안 `id-regex-validation-smoke` entry 제거 (promote). archival 부재 (v6.11 in_progress → v6.8 archival 부재)", "rationale": "v5.21+ schema A2 정합. forward-looking 이정표 본질 + recent 3 completed (v6.10/v6.9/v6.8) 그대로 보존 (v6.11 in_progress 추가). v6.11 completed 처리 시 v6.8 archival 자연.", "evidence": "ROADMAP schema_note v5.21+ schema A2"},
    {"id": "D10", "decision": "tests/CLAUDE.md 안 smoke-candidate-draft-schema 행 description 갱신 — Stage 3 추가 표기 (보조 cascade, 본 milestone phase-1 안 통합)", "rationale": "narrative trace 보조 — 매트릭스 행 description 정합 유지. v6.5/v6.8 phase-1 안 동일 패턴 (Stage 1/2 추가 시 매트릭스 갱신). v3.21 narrative 3 단계 패턴 적용 대상 부재 (cascade host ≤ 2 = smoke 본체 + 매트릭스 행).", "evidence": "tests/CLAUDE.md smoke 매트릭스 + v6.5/v6.8 패턴"}
  ],
  "approach": "1 컴포넌트 확장 — `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (next_candidates[].id regex 검증 + schema_note 일치 검증). 추가로 (1) projects/meta/ROADMAP.md milestones[] 안 v6.11 in_progress entry 추가 + next_candidates#11 (id-regex-validation-smoke) entry 제거 + updated 갱신, (2) tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행 description Stage 3 추가 표기, (3) MILESTONE.md APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 5 섹션 채움, (4) CHANGELOG.md [v6.11] entry 추가 = 1 phase 통합 commit.",
  "phases": [
    {"id": "phase-1", "scope": "smoke Stage 3 추가 + ROADMAP milestones[]/next_candidates 갱신 + tests/CLAUDE.md 매트릭스 행 갱신 + CHANGELOG entry + MILESTONE.md 5 섹션 채움 + 도그푸드 (smoke 호출 PASS) + violation 주입 검증 (tmpdir 임시 ROADMAP) + pre-commit 11 hook PASS 검증", "commit": "feat(meta): v6.11 — ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입 [v6.11]"}
  ],
  "risk_mitigation": [
    {"id": "R1", "risk": "regex hardcode 일치 검증 시 schema_note 안 괄호 주석 (`(group-slug, path-safe)`) 포함 — 정확 substring 추출 필요", "mitigation": "schema_note 안 `^[a-z0-9-]+$` 정확 substring 검색 (re.search 안 escape 처리). 괄호 주석 일치 검증 scope 외 (regex 자체만 비교). R1 mitigation."},
    {"id": "R2", "risk": "violation 주입 검증 시 실 ROADMAP 수정 → 원복 누락 위험", "mitigation": "violation 주입 = tmpdir 안 임시 ROADMAP 파일 + 환경 변수 또는 별 호출 patterns. 실 projects/meta/ROADMAP.md 미수정. controlled 비교 patterns 정합 (R2)."},
    {"id": "R3", "risk": "Stage 3 안 메타 only scope → 향후 upbit 등 다른 ROADMAP 안 schema_note 도입 시 silent 누락", "mitigation": "Stage 3 안 schema_note 일치 검증 logic = `if 'schema_note' in data and contains_regex_definition: verify` 분기 → 향후 다른 ROADMAP 도입 시 자동 포함 (조건 분기 자연 확장). R3 mitigation."},
    {"id": "R4", "risk": "cp949 콘솔 출력 (위반 entry id 안 한국어 등 비-ASCII)", "mitigation": "기존 Stage 1/2 동일 cp949 reconfigure boilerplate 재사용. tests/smoke-python-entry-boilerplate.sh AST audit 자동 강제 (R4)."},
    {"id": "R5", "risk": "cascade-drift hook 안 marker 본문 hash 변경 — 본 milestone 안 cascade marker 신규 부재", "mitigation": "본 milestone scope 안 cascade host 추가 부재 (oos_5 + oos_6). cascade-drift hook 영향 0 기대 (R5)."}
  ]
}
```

### Approach narrative

v6.10 L4 origin direct 후속 — ROADMAP next_candidates[].id schema regex `^[a-z0-9-]+$` 자동 검증 mechanism 도입. `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (umbrella 확장, candidate-related 본질 정합). v6.10 L7 가이드라인 자기 적용 — smoke hardcode regex + projects/meta/ROADMAP.md schema_note 일치 검증 (2 위치 drift 자동 차단).

별 smoke (opt_B) REJECTED — 별 candidate (`smoke-candidate-related-umbrella-split-trigger`) 보존. Stage 1 흡수 (opt_C) REJECTED — Stage 책임 직교 본질 보존.

### Untouched files explicit (b/c/d 부산물)

- `projects/meta/ARCHITECTURE.md` — v3.21 패턴 적용 대상 부재 (cascade host ≤ 2) + 5 관점 review 표 본문 부재 → 변경 0.
- `CLAUDE.md` (root) — cascade host 부재 (smoke 매트릭스 narrative 단일 source = tests/CLAUDE.md) → 변경 0.
- `agents/*.md` — 본 milestone scope 외 → 변경 0.
- `scripts/*.py` — propose_next.py 안 id 생성 logic 부재 (LLM 채움 mechanism, dedupe scope 외) → 변경 0.
- `claude/commands/*.md` — propose-next.md 안 id schema 명시 부재 (schema_note 단일 source 정합) → 변경 0.
- `bootstrap/` — 본 milestone scope 외 → 변경 0.
- `tests/_inactive/*.sh` — 본 milestone scope 외 → 변경 0.

### Risk priorities

R1~R5 모두 low~medium severity. R2 medium → controlled 비교 패턴 (tmpdir) 적용. P1 위험 부재.

### Inline self-review 종합 (5 관점, subagent 부재 — lightweight 정합)

5 관점 inline self-review:

- **Architecture** P2 #arch-1: Stage 책임 직교 본질 (Stage 1 candidate_draft / Stage 2 candidate_items / Stage 3 next_candidates) — umbrella 확장 시 책임 mixing 위험. 다만 본 case = 모두 candidate-related (entry schema 검증 본질) → mixing 위험 약. opt_C (Stage 1 흡수) REJECTED 결정 정합 (책임 mixing 회피). 흡수 narrative.
- **Spec-drift** P2 #drift-1: schema_note 안 `^[a-z0-9-]+$ (group-slug, path-safe)` 본문 안 괄호 주석 포함 — smoke 안 regex 추출 시 정확 substring 검색 의무 (괄호 주석 제외). R1 mitigation 직접 적용. v6.10 L7 가이드라인 (regex·실 사용 함께 검토) 자기 적용 — 본 milestone 본질 정합.
- **Security** P3 #sec-1: smoke Python heredoc 안 신규 외부 입력 부재 (ROADMAP.md 읽기만, 기존 Stage 1 동일 scope). path traversal 위험 0 (REPO_ROOT 안 glob). 영향 0.
- **Dictionary-semantics** P3 #dict-1: title `ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입` = 50자, active form (`도입` verb suffix). entry title 가이드 4 원칙 정합. 한 entry = 한 본질 (regex 검증 smoke 도입). 흡수.
- **Test-coverage** P2 #test-1: violation 주입 검증 = tmpdir 임시 ROADMAP (D5). 실 ROADMAP 미수정 → 회귀 위험 0. controlled 비교 패턴 정합. PASS 도그푸드 + FAIL 도그푸드 (violation 주입) 양방향 검증 = 신규 smoke 추가 시 의무 (tests/CLAUDE.md Step 4 정합).

decisive 0 + P2 3 + P3 2 = 모두 narrative 흡수 또는 별 milestone 거명만 (v6.7~v6.10 lightweight 패턴 정합).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "scope": "10 decisions (D1~D10) + 5 관점 inline self-review (decisive 0 / P2 3 / P3 2) + 2 round pre-PLAN 결정 (scope=next_candidates[].id only / regex 위치=smoke hardcode + schema_note 일치 검증) — all approved",
    "method": "inline AskUserQuestion (Stage E)",
    "notes": "lightweight 모드 + 5 관점 inline self-review (subagent 부재) — v6.7~v6.10 패턴 정합. pre-PLAN 2 round + Round 3 review (수용 → EXECUTE) 완료. archival 대상 부재 (v6.11 in_progress, v6.8 archival 은 v6.11 completed 처리 시 자연). phase-1 EXECUTE 진입 허가."
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
      "title": "smoke Stage 3 추가 + ROADMAP/CHANGELOG/tests-CLAUDE.md 갱신 + MILESTONE.md 5 섹션 채움 통합 1 commit",
      "actions": [
        "(1) tests/smoke-candidate-draft-schema.sh 안 Stage 3 신규 추가 — projects/*/ROADMAP.md 안 next_candidates[].id regex `^[a-z0-9-]+$` 검증 + projects/meta/ROADMAP.md schema_note 안 regex 명시값 일치 검증",
        "(2) projects/meta/ROADMAP.md milestones[] 안 v6.11 in_progress entry 추가 (영문 id, status='in_progress', trigger='B_regression', origin v6.10 L4) + updated 필드 갱신 ('2026-05-20-v6.11')",
        "(3) projects/meta/ROADMAP.md next_candidates[] 안 #11 entry 제거 (`id-regex-validation-smoke`, origin v6.10)",
        "(4) tests/CLAUDE.md 안 smoke-candidate-draft-schema 행 description 갱신 — Stage 3 추가 표기",
        "(5) CHANGELOG.md [v6.11] entry 신규 추가 (Keep a Changelog v1.1.0 정합)",
        "(6) MILESTONE.md APPROVE 안 approval.approved_by='user' + date='2026-05-20' + notes 채움 (사용자 승인 후)",
        "(7) MILESTONE.md EXECUTE actions 본 list 보존 + VERIFY/REPORT/PROPOSE 3 섹션 채움",
        "(8) 도그푸드 PASS — `bash tests/smoke-candidate-draft-schema.sh` 호출 시 Stage 3 PASS (14 entry 모두 영문 group-slug)",
        "(9) violation 주입 검증 — tmpdir 안 임시 ROADMAP 안 한국어 id entry 추가 + 별 호출로 Stage 3 FAIL (exit 1) 정상 확인. 실 ROADMAP 미수정",
        "(10) pre-commit 11 hook 호출 검증 (회귀 0 확인)",
        "(11) commit (subject `feat(meta): v6.11 — ROADMAP next_candidates[].id schema regex 자동 검증 smoke 도입 [v6.11]`)"
      ],
      "files_changed": [
        "tests/smoke-candidate-draft-schema.sh (Stage 3 신규 추가)",
        "projects/meta/ROADMAP.md (milestones[] 안 v6.11 in_progress + next_candidates#11 제거 + updated 갱신)",
        "tests/CLAUDE.md (smoke-candidate-draft-schema 행 description Stage 3 추가)",
        "CHANGELOG.md ([v6.11] entry 추가)",
        "projects/meta/milestones/v6.11/MILESTONE.md (전체 작성)",
        "projects/meta/milestones/v6.11/execute/ (빈 디렉토리, v6.7~v6.10 패턴 정합)"
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
    {"smoke": "tests/smoke-candidate-draft-schema.sh (Stage 3 도그푸드 PASS)", "result": "PASS", "metric": "현 13 next_candidates entry (id-regex-validation-smoke 제거 후) 모두 영문 group-slug id. exit 0 + Stage 3 PASS=2 (schema_note 일치 + meta next_candidates 13건 regex PASS). 총 PASS=4 FAIL=0."},
    {"smoke": "violation 주입 controlled 비교 (한국어 id entry 임시 주입 → 복원)", "result": "PASS", "metric": "1차 주입 → smoke exit_code=1 + Stage 3 FAIL 정상 (위반 entry id '한국어-id-테스트' 정확 검출). 2차 복원 → smoke exit_code=0 + Stage 3 PASS 회귀 0. 양방향 검증 PASS."},
    {"smoke": "pre-commit 11 hook", "result": "PENDING", "metric": "phase-1 commit 시 호출 — smoke-candidate-draft-schema 자체 + smoke-projects-scope-discipline + smoke-bundle-trigger + smoke-open-stage-discipline + smoke-entry-title-guideline + smoke-spec-verification + smoke-scope-contract + smoke-cross-ref + smoke-claude-md-drift + smoke-cascade-drift + smoke-audit-fact-verify 모두 PASS 기대"}
  ],
  "criteria_check": [
    {"id": "sc_1", "verdict": "PASS", "evidence": "tests/smoke-candidate-draft-schema.sh:206-272 Stage 3 신규 추가 본문 확인 — projects/*/ROADMAP.md glob + next_candidates[].id regex `^[a-z0-9-]+$` 검증. id 부재 entry SKIP."},
    {"id": "sc_2", "verdict": "PASS", "evidence": "tests/smoke-candidate-draft-schema.sh Stage 3 (a) sub-step — projects/meta/ROADMAP.md schema_note 안 `^[a-z0-9-]+$` substring 검증 logic 추가. 도그푸드 결과 `schema_note 안 regex '^[a-z0-9-]+$' 일치 (smoke hardcode 와 drift 없음)` 출력 확인."},
    {"id": "sc_3", "verdict": "PASS", "evidence": "도그푸드 호출 결과 `Stage 3 PASS=2 / projects/meta/ROADMAP.md: next_candidates[].id regex PASS (13건)`. 총 PASS=4 FAIL=0 exit 0."},
    {"id": "sc_4", "verdict": "PASS", "evidence": "violation 주입 (next_candidates[11].id = '한국어-id-테스트') → smoke exit_code=1 + Stage 3 FAIL 정상. 복원 후 exit_code=0 회귀 0."},
    {"id": "sc_5", "verdict": "PASS", "evidence": "projects/meta/ROADMAP.md milestones[] 안 v6.11 in_progress entry 추가 + next_candidates#11 (id-regex-validation-smoke) 제거 + updated 갱신 `2026-05-20-v6.11`."},
    {"id": "sc_6", "verdict": "PASS", "evidence": "tests/CLAUDE.md smoke 매트릭스 안 smoke-candidate-draft-schema 행 description Stage 1+2+3 3 단계 명시 갱신. v6.11 phase-1 Stage 3 추가 표기."},
    {"id": "sc_7", "verdict": "PASS", "evidence": "CHANGELOG.md [v6.11] entry 신규 추가 (Added 2 + Changed 2 + Documented 5). entry title 가이드 4 원칙 정합 (≤ 60자 + active form + 한 entry = 한 본질)."},
    {"id": "sc_8", "verdict": "PENDING", "evidence": "phase-1 commit 시 pre-commit 11 hook 호출 — 회귀 0 기대"}
  ],
  "verdict": "PASS — 7/8 success_criteria PASS (sc_8 phase-1 commit 시 검증). 도그푸드 양방향 (PASS + FAIL violation 주입) controlled 비교 검증 완료. lightweight 1-phase 통합 정합."
}
```

## REPORT

### Spec

```json
{
  "summary": "v6.10 L4 origin 직접 해소 — ROADMAP next_candidates[].id schema regex `^[a-z0-9-]+$` 자동 검증 mechanism 도입. `tests/smoke-candidate-draft-schema.sh` 안 Stage 3 신규 추가 (candidate-related umbrella 자연 확장, v6.5 Stage 1 + v6.8 Stage 2 + v6.11 Stage 3 3 단계 누적). v6.10 L7 가이드라인 (regex·패턴 안 실 사용 logic 함께 검토) 자기 적용 — smoke hardcode regex + projects/meta/ROADMAP.md schema_note 일치 검증 (2 위치 drift 자동 차단). lightweight 1-phase 통합 1 commit (v6.6~v6.10 누적 패턴 정합).",
  "delta": {
    "files_changed": 5,
    "lines_added": "~140",
    "lines_removed": "~15",
    "commits": 1,
    "scope": "smoke Stage 3 신규 (~65 LOC) + ROADMAP milestones[]/next_candidates 갱신 + tests/CLAUDE.md 매트릭스 행 갱신 + CHANGELOG [v6.11] entry + MILESTONE.md 8 섹션 전체"
  },
  "lessons_learned": [
    {"id": "L1", "lesson": "v6.10 L7 가이드라인 (regex·패턴 안 실 사용 logic 함께 검토) 자기 적용 cycle 완성 — v6.10 가이드라인 narrative 도입 → v6.11 mechanism 자동 강제 (smoke hardcode + schema_note 일치 검증). 가이드라인 → 자동화 cycle 1번째 evidence. 향후 동질 spec-drift mismatch 발견 시 narrative 도입 직후 mechanism 자동화 milestone 자연 (가이드라인 단독 시 self-drift 위험 mitigation).", "priority": "P1"},
    {"id": "L2", "lesson": "candidate-related smoke umbrella 3 Stage 확장 자연 — Stage 1 (v6.5 candidate_draft 7 필드) + Stage 2 (v6.8 candidate_items + dedupe_stats) + Stage 3 (v6.11 next_candidates[].id regex). 공통 본질 = candidate-related entry schema. umbrella 분리 trigger 가이드라인 별 candidate (`smoke-candidate-related-umbrella-split-trigger`) 보존 — 다음 추가 시점 trigger 평가 자연.", "priority": "P1"},
    {"id": "L3", "lesson": "violation 주입 controlled 비교 양방향 검증 = 신규 smoke 추가 시 의무 patterns. (1) 임시 violation 주입 (실 ROADMAP 직접 수정 또는 tmpdir 별 ROADMAP) → smoke FAIL exit 1 + 위반 entry 정확 검출 확인 → (2) 복원 → smoke PASS exit 0 회귀 0 확인. tests/CLAUDE.md 회귀 검증 절차 정합 + R2 mitigation 직접 적용.", "priority": "P1"},
    {"id": "L4", "lesson": "id 부재 entry SKIP mechanism = legacy era 안전 — propose_next.py 안 id 없는 PROPOSE entry (v3~v5 era) 존재 가능. smoke Stage 3 안 `if 'id' not in entry: continue` 안전 분기. 별 milestone candidate (`propose-next-legacy-era-id-backfill`) 보존 — backfill 본질 별 milestone scope.", "priority": "P2"},
    {"id": "L5", "lesson": "lightweight 1-phase 누적 14/26 = 53.8% (v6.10 13/25 = 52% → v6.11 14/26 = 53.8%). v6.6~v6.11 6 consecutive lightweight 1-phase milestone 누적. lightweight 본질 본 repo 자연 정합 누적 evidence (50% 안정 유지).", "priority": "P2"},
    {"id": "L6", "lesson": "v3.21 narrative 정전화 3 단계 패턴 적용 대상 부재 (cycle 카운트 보존) — 본 milestone cascade host ≤ 2 (smoke 본체 + tests/CLAUDE.md 매트릭스 행). v6.10 L3 판정 기준 (≥2 → 패턴 적용 / =1 → 적용 대상 부재) 정합. cycle 카운트 보존 → 누적 36 그대로 (cycle 37 적용 대상 후속 case 자연 대기).", "priority": "P2"},
    {"id": "L7", "lesson": "v5.7 spec-drift spike (c) 패턴 10번째 자연 발현 — schema_note 안 regex 정전화 (외부 spec) → smoke hardcode (실 사용) 안 일치 검증 (drift 자동 차단). 누적 = v4.2/v5.6/v6.2/v6.3/v6.4/v6.5/v6.6/v6.8/v6.9/v6.11 (cycle 9 v6.9 → cycle 10 v6.11, v6.10 본 패턴 발현 부재).", "priority": "P2"},
    {"id": "L8", "lesson": "archival cycle 보류 — v6.11 in_progress 단계 milestones[] = v6.11 + v6.10/v6.9/v6.8 (recent 3 completed) + deferred 3. v6.11 status='completed' 처리 시점에 v6.8 archival 자연 (archival cycle 11번째). 본 commit 안 v6.11 status='completed' 갱신 + v6.8 archival 통합 자연.", "priority": "P2"}
  ]
}
```

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "smoke-stage-3-tests-fixture-pattern",
      "title": "violation 주입 fixture-based smoke 패턴 candidate (controlled 비교 자동화)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.11",
      "target_version": "v6.x",
      "description": "L3 origin — violation 주입 controlled 비교 = 본 milestone 안 수동 (bash + python 한 줄). v6.6 smoke-audit-fact-verify 안 fixture sub-dir 패턴 (6 sub-dir = boolean-normal/boolean-mismatch/...) 동일 적용 candidate — smoke-candidate-draft-schema 안 fixture 기반 violation 주입 자동화. evidence 누적 (Stage 4 신규 + 동질 mechanism) 시 별 milestone."
    },
    {
      "id": "schema-note-target-version-regex-validation",
      "title": "schema_note 안 target_version regex (`^v[0-9]+\\.[0-9]+$`) 자동 검증",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.11",
      "target_version": "v6.x",
      "description": "schema_note 안 `target_version regex: ^v[0-9]+\\.[0-9]+$` 정전화 부재 evidence (Stage 3 안 id regex 만 검증). 동질 pattern 자동 검증 mechanism (next_candidates[].target_version semver 정합) 추가 candidate — Stage 3 확장 또는 Stage 4 신규. evidence 누적 (target_version 위반 발견) 시 별 milestone."
    },
    {
      "id": "candidate-draft-id-regex-extension",
      "title": "candidate_draft[].id regex 검증 Stage 3 확장 (next_candidates 정합)",
      "trigger": "D_design",
      "origin_milestone": "v6.11",
      "target_version": "v6.x",
      "description": "oos_1 origin — Stage 3 scope = next_candidates[].id only. candidate_draft[].id 는 동질 group-slug 본질 (v6.5 정전화) 이나 본 milestone scope 외. 향후 candidate_draft 안 비-group-slug id 발견 시 별 milestone 발의 자연. propose_next.py 안 id 생성 logic 정합 검증 함께 진행 가능."
    }
  ]
}
```

### Next candidates narrative

3 candidate 등재 — L3 (fixture-based smoke 패턴) + target_version regex 자동 검증 (oos_4 indirect) + candidate_draft[].id 확장 (oos_1). 모두 distinct 본질 + 별 milestone target (v6.x). 본 milestone scope 외 (lightweight 정합).

## SUB_MILESTONES

본 milestone = 단일 sub-milestone (lightweight 1-phase 통합). bundling 부재 — v6.7~v6.10 lightweight 패턴 정합.

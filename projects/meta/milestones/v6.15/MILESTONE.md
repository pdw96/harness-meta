---
id: v6-4-v6-9-entry-title-active-form-redefinition
title: v6.4~v6.9 entry title active form 재정의
version: v6.15
status: in_progress
---

# v6.15 — v6.4~v6.9 entry title active form 재정의

## INTENT

### Spec

```json
{
  "id": "v6-4-v6-9-entry-title-active-form-redefinition",
  "title": "v6.4~v6.9 entry title active form 재정의",
  "goal": "v6.4~v6.9 6 milestone frontmatter title (`mechanism` 4건 / `정전화` 1건 / `5-step` 1건 모두 명사 종결) 안 ARCHITECTURE § 7.2 (3) Active form 원칙 약함 누적 패턴 해소 — case-by-case suffix 추가 (5건 `도입` + 1건 `통일`) 으로 본질 동사 종결 통일. 부수 frontmatter cleanup 흡수 = v6.6/v6.8/v6.9 frontmatter status: in_progress 잔존 drift 3건 → completed 갱신 (B). CHANGELOG entry bullet bold (v6.7/v6.8/v6.9 명사 종결 3건) 동기 갱신. v6.6 frontmatter `자동 정정` ↔ R1 결정 `검출 only` 표기 drift (C) = 별 milestone PROPOSE 거명만 (본 scope 외, spec-drift 본질). v3.21 narrative 정전화 3 단계 패턴 적용 대상 부재 (v6.10 L3 판정 기준 = cascade host ≥2 → 적용 / =1 → 적용 대상 부재, 본 milestone = frontmatter title 정전 source 자체 정합 본질 단일 host).",
  "success_criteria": [
    {"id": "sc_1", "description": "v6.4~v6.9 6 frontmatter title 정확 retitle — v6.4 `cascade 자동 동기 mechanism` → `cascade 자동 동기 mechanism 도입` + v6.5 `Claude 자율 milestone 발의 mechanism` → `Claude 자율 milestone 발의 mechanism 도입` + v6.6 `audit chain hallucination 자동 정정 mechanism` → `audit chain hallucination 자동 정정 mechanism 도입` (C 표기 drift 별 milestone 보존, suffix only) + v6.7 `v5.13/v5.18/v6.6 3-step chain 정전화` → `v5.13/v5.18/v6.6 3-step chain 정전화 도입` + v6.8 `/propose-next surface 자동 dedupe mechanism` → `/propose-next surface 자동 dedupe mechanism 도입` + v6.9 `synthesizer mismatch 보고 형식 debugger 5-step` → `synthesizer mismatch debugger 5-step 형식 통일`."},
    {"id": "sc_2", "description": "v6.6/v6.8/v6.9 frontmatter `status: in_progress` → `status: completed` 갱신 (실 milestone 완료 evidence — ROADMAP archived + CHANGELOG entry 존재). 3 위치 mechanical edit."},
    {"id": "sc_3", "description": "CHANGELOG entry bullet bold (`### Added` 첫 bullet) 동기 갱신 — v6.7 `audit chain 운영 책임 분리 3-step chain narrative 정전화` → `audit chain 운영 책임 분리 3-step chain narrative 정전화 도입` + v6.8 `/propose-next surface 자동 dedupe mechanism` → `/propose-next surface 자동 dedupe mechanism 도입` + v6.9 `synthesizer mismatch 5-step format 정합` → `synthesizer mismatch debugger 5-step 형식 통일`. (v6.4/v6.5/v6.6 = 이미 `신규 도입` suffix 보유, 갱신 부재 자연.)"},
    {"id": "sc_4", "description": "ROADMAP milestones[] 갱신 — v6.15 in_progress entry 추가 + next_candidates[#5] `active-form-3-step-chain-retitle-v6-7` 제거 (promote). archival 대상 = v6.12 (CHANGELOG entry 보존, recent 3 = v6.14/v6.13/v6.15 → REPORT 시점 갱신). updated `2026-05-21-v6.15`."},
    {"id": "sc_5", "description": "CHANGELOG.md [v6.15] entry 신규 추가 (Keep a Changelog v1.1.0 정합). entry title 가이드 4 원칙 (ARCHITECTURE § 7.2) 자기 적용 — 본 milestone bullet bold = `v6.4~v6.9 entry title active form 재정의` (≤ 60자 + Active form 본질 동사 `재정의` 종결 + 한 본질)."},
    {"id": "sc_6", "description": "회귀 0 — pre-commit 18 hook 전체 PASS. smoke-entry-title-guideline (v6.3 도입) 영향 0 또는 +0 (frontmatter title scope 외 / CHANGELOG bullet 동기 갱신 후 Active form 정합). 다른 milestone cross-ref 안 v6.4~v6.9 title 인용 drift 부재 grep 검증."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "(C) v6.6 frontmatter `자동 정정` ↔ R1 결정 `검출 only` 표기 drift fix", "reason": "본 milestone 본질 = entry title active form 재정의 (umbrella cleanup). v6.6 표기 drift = R1 결정 정합 spec-drift 본질 (별 본질 축). 사용자 결정 (A)+(B) 옵션 = (C) 별 milestone PROPOSE 거명. § 7.2 (1) 한 entry = 한 본질 정합 본질 분리."},
    {"id": "oos_2", "item": "v6.4~v6.9 milestone 안 본문 narrative (INTENT/RESEARCH/DESIGN body) 안 self-reference title 인용 일괄 갱신", "reason": "본문 narrative 안 title 자체 cross-ref grep 시 frontmatter title 인용 위치 다수 가능. 본 milestone scope = frontmatter title (정전 source) + CHANGELOG entry bullet (외부 visible) 양방. 본문 narrative 자기 cross-ref = audit trail (역사적 narrative 보존) 자연. 별 milestone 거명만."},
    {"id": "oos_3", "item": "ARCHITECTURE § 7.2 (3) Active form smoke 자동 강제 도입 (mechanism)", "reason": "v6.3 entry-title-guideline-smoke-verification 안 (3) Active form + (4) Detail summary 분리 = AI 판단 위임 (자동 검증 제외 — 휴리스틱 false-positive 위험 + 의미 차원) 결정 정합. 자동 강제 mechanism = over-engineering 위험 + AI 판단 본질 위배. 향후 evidence 누적 시 별 milestone candidate (단 v6.3 결정 정합 본질 → 추가 발의 trigger 부재 자연)."},
    {"id": "oos_4", "item": "v6.0~v6.3 또는 v6.10~v6.14 entry title active form 확장 retitle", "reason": "scope 명시 = v6.4~v6.9 6 milestone (사용자 결정 본질). v6.0~v6.3 = 영문 slug 본질 (cleanup 외) + v6.10~v6.14 = 의식적 active form (`도입`/`보강`/`자동화`/`확장` 동사 종결) 자연 정합. v6.x 누적 패턴 evidence 6건 only (사용자 결정 정합 본질)."},
    {"id": "oos_5", "item": "5 관점 subagent 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract)", "reason": "scope ~9 위치 mechanical edit (lightweight 1-phase 본질). v6.6~v6.14 lightweight 1-phase 9 consecutive cycle 누적 패턴 정합. inline self-review (decisive 0 / P2 거명 / P3 거명) cycle 11 자연."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "projects/meta/ROADMAP.md next_candidates[#5] `active-form-3-step-chain-retitle-v6-7` (origin_milestone v6.7, target_version v6.x, trigger D_design)", "purpose": "본 milestone origin 정전 source. v6.7 5 관점 inline self-review dictionary-semantics P3#1 candidate 거명."},
    {"id": "dep_2", "source": "projects/meta/ARCHITECTURE.md § 7.2 (3) Active form 원칙 (line 265) + v6.3 smoke 자동 강제 narrative (line 268)", "purpose": "본 milestone 정합 본질 외부 spec (자기 정전 source). 4 원칙 + (3) 본질 동사 예시 `재정의/도입/정전화/분리/통합/흡수/갱신` 매핑 본질."},
    {"id": "dep_3", "source": "projects/meta/milestones/v6.4~v6.9/MILESTONE.md frontmatter 6 위치", "purpose": "본 milestone edit 대상 1차 source (정전 single source)"},
    {"id": "dep_4", "source": "CHANGELOG.md v6.7/v6.8/v6.9 `### Added` 첫 bullet bold 3 위치", "purpose": "본 milestone edit 대상 cascade source (외부 visible artifact, § 7.2 smoke scope)"}
  ]
}
```

### Motivation

v6.7 5 관점 inline self-review dictionary-semantics P3#1 origin (2026-05-20) — v6.7 entry title `v5.13/v5.18/v6.6 3-step chain 정전화` 안 ARCHITECTURE § 7.2 (3) Active form 약 `정전화` 명사 종결 식별. v6.x 누적 패턴 (v6.4~v6.9 6 milestone 모두 명사 종결 — `mechanism` 4 / `정전화` 1 / `5-step` 1) evidence. v6.10 안 의식적 active form 이전 (v6.10 `... 가이드라인 도입` / v6.11 `... 도입` / v6.12 `... 자동화` / v6.13 `... 보강` / v6.14 `... 확장`) 후 v6.4~v6.9 6건 retrospective cleanup 본질.

ROADMAP next_candidates[#5] description 명시 = "retitle candidate 거명만 — '3-step chain narrative 정전화 도입' 등. v6.x 후속 milestone scope". 본 milestone OPEN 시 candidate 본질 흡수 + scope 확장 (v6.7 single → v6.4~v6.9 6건 일괄, RESEARCH 단계 evidence 6건 누적 패턴 확인) + 부수 frontmatter cleanup (v6.6/v6.8/v6.9 status drift) 자연 흡수.

**자기 적용 본질** — 본 milestone title `v6.4~v6.9 entry title active form 재정의` = § 7.2 (3) 본질 동사 `재정의` 종결 + (2) ≤ 60자 (39자) + (1) 한 본질 + (4) detail summary 분리. § 7.2 가이드 자기 도그푸드 cycle (v6.3 smoke 자기 적용 cycle 2 — v6.3 자체 entry title 도그푸드 + v6.15 본 milestone 도그푸드).

pre-PLAN 4 round 누적 결정 (2026-05-21):

1. **방향성** — narrative 정전화 (사용자 결정 — `narrative 정전화` 4 후보 그룹 안 선택)
2. **후보 선택** — #5 v6.7 active form retitle (`디테일 비교 분석` 후 사용자 결정 — trigger 충족 + § 7.2 자기 적용 첫 evidence + lightweight 본질)
3. **scope** — v6.4~v6.9 6건 명사 종결 일괄 retitle (Option B, evidence 누적 6건 사실 확인 후 ad-hoc 회피 결정)
4. **추가 발견 흡수** — (A)+(B) = retitle 6 + status drift fix 3 흡수 + (C) v6.6 표기 drift 별 milestone 보존
5. **suffix 표준** — case-by-case (5건 `도입` + v6.9 `통일`, 본질 정확도 우선)

### Out of scope rationale

oos_1: v6.6 `자동 정정` ↔ `검출 only` R1 결정 표기 drift = spec-drift 본질 (entry title cleanup 본질과 별축). 별 milestone PROPOSE 거명 자연 — `v66-frontmatter-spec-drift-detect-vs-correct-narrative` 등.

oos_2: 본문 narrative 안 self-reference title 인용 = audit trail (역사적 narrative 보존) 본질. forward-only 정정은 frontmatter (정전 source) + CHANGELOG entry bullet (외부 visible) 양방 만 자연.

oos_3: § 7.2 (3) Active form smoke 자동 강제 = v6.3 결정 (AI 판단 위임) 정합 본질 위배. 후보 발의 trigger 부재 자연.

oos_4: scope = v6.4~v6.9 6건 사용자 결정 본질. v6.10+ active form 정합 evidence + v6.0~v6.3 영문 slug 본질 = 확장 trigger 부재.

oos_5: lightweight 본질 → inline self-review 자연. scope ~9 위치 = subagent 병렬 overhead 부적합 본질.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Anthropic Claude Code spec (context7) — entry title active form 표준 패턴 query", "verdict": "DEFERRED — § 7.2 entry title 가이드 4 원칙 = 본 repo 자체 컨벤션 (v6.0 정전화). Anthropic Claude Code spec 안 first-class 'entry title active form retitle' 패턴 부재 (Conventional Commits / Keep a Changelog 안 entry title style guide 부재). 본 milestone = 기존 § 7.2 (3) 원칙 자기 적용 only — 외부 spec 의존 부재. v5.7 spec-drift spike 패턴 (c-2) DESIGN 즉시 정정 분기 12번째 자연 발현 후보 (본 milestone 자체)."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "projects/meta/ARCHITECTURE.md:265", "fact": "§ 7.2 (3) `Active form + 짧은 동사구 시작 — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사. 명사구 시작 회피.` — 본 milestone 적용 본질 source."},
    {"id": "cb_2", "file": "projects/meta/milestones/v6.4/MILESTONE.md:3", "fact": "frontmatter `title: cascade 자동 동기 mechanism` — `mechanism` 명사 종결."},
    {"id": "cb_3", "file": "projects/meta/milestones/v6.5/MILESTONE.md:3", "fact": "frontmatter `title: Claude 자율 milestone 발의 mechanism` — `mechanism` 명사 종결."},
    {"id": "cb_4", "file": "projects/meta/milestones/v6.6/MILESTONE.md:3+5", "fact": "frontmatter `title: audit chain hallucination 자동 정정 mechanism` (`mechanism` 명사 종결) + `status: in_progress` (drift, 실 milestone 완료). 표기 drift `자동 정정` ↔ R1 결정 `검출 only` = (C) 별 본질."},
    {"id": "cb_5", "file": "projects/meta/milestones/v6.7/MILESTONE.md:3", "fact": "frontmatter `title: v5.13/v5.18/v6.6 3-step chain 정전화` — `정전화` 명사 종결 (본질 동사 derivative이나 § 7.2 (3) 동사구 시작 부재 + suffix 동사형 약). ROADMAP candidate origin 정전 source."},
    {"id": "cb_6", "file": "projects/meta/milestones/v6.8/MILESTONE.md:3+5", "fact": "frontmatter `title: /propose-next surface 자동 dedupe mechanism` (`mechanism` 명사 종결) + `status: in_progress` (drift)."},
    {"id": "cb_7", "file": "projects/meta/milestones/v6.9/MILESTONE.md:3+5", "fact": "frontmatter `title: synthesizer mismatch 보고 형식 debugger 5-step` (`5-step` 명사 종결, 본질 동사 부재) + `status: in_progress` (drift)."},
    {"id": "cb_8", "file": "CHANGELOG.md v6.4~v6.6 `### Added` 첫 bullet bold", "fact": "v6.4 `cascade 자동 동기 mechanism 신규 도입` + v6.5 `Claude 자율 milestone 발의 mechanism 신규 도입` + v6.6 `audit chain hallucination 자동 검출 mechanism 신규 도입` — `신규 도입` suffix 보유 (Active form 정합 ✓, 갱신 부재 자연). v6.6 CHANGELOG = `자동 검출` (R1 결정 정합) ↔ frontmatter `자동 정정` (drift, (C) 별 본질)."},
    {"id": "cb_9", "file": "CHANGELOG.md v6.7 `### Added` 첫 bullet bold", "fact": "`audit chain 운영 책임 분리 3-step chain narrative 정전화` — `정전화` 명사 종결 (suffix 부재). § 7.2 smoke scope (CHANGELOG bullet bold) 안 갱신 대상."},
    {"id": "cb_10", "file": "CHANGELOG.md v6.8 `### Added` 첫 bullet bold", "fact": "`/propose-next surface 자동 dedupe mechanism` — `mechanism` 명사 종결 (suffix 부재). § 7.2 smoke scope 안 갱신 대상."},
    {"id": "cb_11", "file": "CHANGELOG.md v6.9 `### Added` 첫 bullet bold", "fact": "`synthesizer mismatch 5-step format 정합` — `정합` 명사 종결 (suffix 부재). § 7.2 smoke scope 안 갱신 대상. frontmatter title (`...debugger 5-step`) ↔ CHANGELOG (`5-step format 정합`) 표기 차이 = 동질 본질 다른 표기 (역사적 audit trail 보존)."},
    {"id": "cb_12", "file": "tests/smoke-entry-title-guideline.sh", "fact": "v6.3 도입 smoke = (1) ` + ` literal space + lookbehind/lookahead non-whitespace P1 mechanical proxy + (2) Python `len(title)` codepoint > 60 검출. scope = ROADMAP `milestones[]/next_candidates[]/candidate_draft[]` title 필드 + CHANGELOG bullet bold header. **frontmatter title scope 외** — 본 milestone retitle 후 smoke 영향 = CHANGELOG bullet bold (sc_3) 동기 갱신 후 회귀 0 보장."}
  ],
  "options": [
    {"id": "opt_a", "label": "(A) only — frontmatter title 6 위치 retitle", "verdict": "REJECTED (Round 4-1 사용자 결정) — (B) status drift 동질 frontmatter cleanup umbrella 본질 흡수 자연. (A) only 시 (B) 별 milestone overhead."},
    {"id": "opt_b", "label": "(A)+(B) — retitle 6 + status fix 3", "verdict": "ACCEPTED (Round 4-2 사용자 결정) — frontmatter cleanup umbrella 본질 정합. § 7.2 (1) 한 본질 = `frontmatter entry cleanup` umbrella 자연. lightweight 1-phase 유지 (mechanical edit ~9 위치)."},
    {"id": "opt_c", "label": "(A)+(B)+(C) — v6.6 표기 drift 동시 fix", "verdict": "REJECTED (Round 4-3 사용자 결정) — (C) 본질 = spec-drift (R1 결정 정합) 본 milestone 본질 (entry title cleanup) 과 별축. § 7.2 (1) 한 본질 위배 위험 + scope creep."},
    {"id": "opt_d", "label": "suffix 표준 = `도입` 6건 균일", "verdict": "REJECTED (Round 5-1 사용자 결정) — v6.9 `5-step 도입` 어색함 + v6.9 본질 = format 통일 (`debugger 5-step 형식 통일` 의미 정확)."},
    {"id": "opt_e", "label": "suffix 표준 = case-by-case (5건 `도입` + v6.9 `통일`)", "verdict": "ACCEPTED (Round 5-2 사용자 결정) — 본질 정확도 우선. v6.9 = format 통일 본질 (debugger 5-step schema 통일 mechanism) + `통일` § 7.2 (3) 예시 안 직접 명시 부재이나 본질 동사 (`재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신` 매트릭스 안 `통합` 인접 본질)."}
  ],
  "risks_identified": [
    {"id": "risk_1", "item": "frontmatter title 갱신 후 본문 narrative 안 self-reference title 인용 위치 drift 누적", "mitigation": "본문 narrative cross-ref = audit trail (역사적 narrative 보존) 자연 (oos_2 정합). 본문 안 title 인용 = 본문 작성 시점 frontmatter title 보존 = 역사적 정합 본질. 단 ROADMAP milestones[] entry title (사용 시점 정전 source) + CHANGELOG bullet bold (외부 visible) 양방 만 forward 갱신."},
    {"id": "risk_2", "item": "CHANGELOG bullet bold 갱신 시 § 7.2 smoke 회귀 위험 — (1) ` + ` literal space + (2) ≤ 60자 baseline 위반 가능성", "mitigation": "EXECUTE 단계 안 CHANGELOG 갱신 후 즉시 `bash tests/smoke-entry-title-guideline.sh` 또는 `pre-commit run smoke-entry-title-guideline --all-files` 호출 검증. retitle 후 codepoint length 모두 ≤ 60 사전 확인 (v6.4 27자 / v6.5 36자 / v6.6 46자 / v6.7 37자 / v6.8 42자 / v6.9 45자 = 모두 ≤ 60 ✓). ` + ` literal space 부재 (모두 single 본질 표기) ✓."},
    {"id": "risk_3", "item": "frontmatter title 갱신 시 다른 cross-ref host (root CLAUDE.md / 다른 milestone narrative / scripts) 안 인용 위치 drift", "mitigation": "EXECUTE 직전 grep `cascade 자동 동기 mechanism|Claude 자율 milestone 발의 mechanism|...자동 정정 mechanism|3-step chain 정전화|/propose-next surface 자동 dedupe mechanism|debugger 5-step` 6 패턴 모두 검색 → cross-ref host 식별 후 cascade impact 결정 (각 host 별 본질 검토 — audit trail 보존 vs forward 갱신). 사전 검증 본 RESEARCH 안 cb_8~cb_11 = CHANGELOG bullet bold 외 cross-ref 식별 결과 = `projects/meta/ARCHITECTURE.md` 안 row #8/#9/#10 paragraph 안 `cycle N번째` cross-ref 패턴은 title 인용 부재 (cycle counter 만)."},
    {"id": "risk_4", "item": "v6.6 frontmatter `자동 정정` 표기 보존 안 `자동 정정 mechanism 도입` suffix only 추가 시 R1 결정 정합 잔존 drift", "mitigation": "(C) 별 milestone 분리 결정 명시 (oos_1). 본 milestone REPORT 안 lesson 등재 + PROPOSE 안 별 milestone candidate 거명 (id 후보 = `v66-frontmatter-spec-drift-detect-vs-correct-narrative` 등). audit trail 명시 보존."},
    {"id": "risk_5", "item": "inline self-review 5 관점 부합도 약 (lightweight scope ~9 위치)", "mitigation": "v6.7~v6.14 lightweight 1-phase 8 consecutive 누적 패턴 정합. inline self-review (decisive 0 / P2 거명 / P3 거명) cycle 11 자연. DESIGN 안 5 관점 inline matrix self-review 적용."}
  ]
}
```

### Findings

**핵심 source**:

1. `projects/meta/ROADMAP.md` next_candidates[#5] — 본 milestone origin candidate 등재.
2. `projects/meta/ARCHITECTURE.md` § 7.2 (3) Active form 원칙 + v6.3 smoke 자동 강제 narrative — 본 milestone 적용 외부 spec (자기 정전 source).
3. `projects/meta/milestones/v6.4~v6.9/MILESTONE.md` frontmatter 6 위치 — 본 milestone edit 대상 정전 single source.
4. `CHANGELOG.md` v6.7/v6.8/v6.9 `### Added` 첫 bullet bold 3 위치 — 본 milestone edit 대상 cascade source (외부 visible artifact, § 7.2 smoke scope).
5. `tests/smoke-entry-title-guideline.sh` — v6.3 도입 smoke, 본 milestone scope 회귀 검증 mechanism.

**evidence 누적 6건 사실 확인**:

| version | 현 frontmatter title | 종결 패턴 | retitle |
|---|---|---|---|
| v6.4 | `cascade 자동 동기 mechanism` | mechanism 명사 | `... mechanism 도입` |
| v6.5 | `Claude 자율 milestone 발의 mechanism` | mechanism 명사 | `... mechanism 도입` |
| v6.6 | `audit chain hallucination 자동 정정 mechanism` | mechanism 명사 | `... mechanism 도입` (표기 drift (C) 별 본질 보존) |
| v6.7 | `v5.13/v5.18/v6.6 3-step chain 정전화` | 정전화 명사 (본질 동사 derivative) | `... 정전화 도입` |
| v6.8 | `/propose-next surface 자동 dedupe mechanism` | mechanism 명사 | `... mechanism 도입` |
| v6.9 | `synthesizer mismatch 보고 형식 debugger 5-step` | 5-step 명사 (본질 동사 부재) | `... debugger 5-step 형식 통일` |

**status drift 3건 사실 확인**: v6.6 / v6.8 / v6.9 frontmatter `status: in_progress` 잔존 — 실 milestone 완료 evidence (ROADMAP archived + CHANGELOG entry 보유). frontmatter cleanup umbrella 동질 본질 자연 흡수.

**v6.7~v6.14 lightweight 1-phase 8 consecutive 누적 패턴 evidence**: v6.7 (1 commit) / v6.8 (1 commit) / v6.9 (1 commit) / v6.10 (1 commit) / v6.11 (1 commit) / v6.12 (1 commit) / v6.13 (2 commit) / v6.14 (2 commit). 본 v6.15 = 1+1 commit (phase-1 + REPORT) 자연 patterns.

### Untouched files explicit (b/c/d 부산물)

- `scripts/` (cascade_sync / propose_next / audit_fact_verify) — 본 milestone narrative-only, script logic 영향 부재.
- `tests/` smoke 신규 부재 — 기존 smoke-entry-title-guideline 영향 0 또는 +0 (회귀 검증 only).
- `agents/` — agent prompt 영향 부재 (frontmatter title scope 외).
- `bootstrap/` / `.claude-plugin/` / `claude/commands/` — 영향 부재.
- `projects/upbit/` — meta scope 본질.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "frontmatter title 6 위치 retitle 정확 suffix = case-by-case (v6.4~v6.8 = `도입` + v6.9 = `통일`)",
      "rationale": "INTENT sc_1 + RESEARCH opt_e (Round 5-2 사용자 결정). v6.9 본질 = debugger 5-step format schema 통일 mechanism (capture/identify/isolate/fix/verify 6 필드 통일) → `통일` 본질 동사 정확. v6.4/v6.5/v6.6/v6.7/v6.8 = mechanism/정전화 신규 도입 본질 → `도입` 본질 동사 정확. § 7.2 (3) 본질 동사 예시 `재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신` + `통일`/`통합` 인접 본질 자연.",
      "alternatives_rejected": "균일 `도입` 6건 (opt_d, v6.9 어색함), 균일 `재정의` 6건 (본질 부정확 — milestone 본질 = 신규 도입, 재정의 본질 아님)"
    },
    {
      "id": "D2",
      "decision": "v6.6 frontmatter `자동 정정` 표기 보존 (suffix only 추가 = `audit chain hallucination 자동 정정 mechanism 도입`)",
      "rationale": "사용자 결정 (A)+(B) 옵션 정합 = (C) 별 milestone 보존. 본 milestone scope = entry title active form (suffix) cleanup. R1 결정 표기 정합 = 별 본질 (oos_1). REPORT lesson + PROPOSE 안 별 milestone candidate 등재 = audit trail 명시 보존.",
      "alternatives_rejected": "표기 `자동 정정` → `자동 검출` 동시 변경 (opt_c, 사용자 결정 reject)"
    },
    {
      "id": "D3",
      "decision": "status drift fix 3 위치 = v6.6/v6.8/v6.9 frontmatter `status: in_progress` → `completed` mechanical edit (B 본질)",
      "rationale": "RESEARCH cb_4/cb_6/cb_7 evidence — 실 milestone 완료 (ROADMAP archived + CHANGELOG entry 존재) ↔ frontmatter status 잔존 drift. frontmatter cleanup umbrella 동질 본질 자연 흡수 (Round 4-2 사용자 결정).",
      "alternatives_rejected": "(B) 별 milestone 분리 (Round 4-1 (A) only, 사용자 결정 reject — umbrella 본질 정합)"
    },
    {
      "id": "D4",
      "decision": "CHANGELOG entry bullet bold (v6.7/v6.8/v6.9 3 위치) 동기 갱신 = sc_3 정합",
      "rationale": "§ 7.2 가이드 적용 대상 명시 = ROADMAP + CHANGELOG bullet bold (smoke scope). frontmatter title (정전 source) + CHANGELOG bullet bold (외부 visible) 양방 동기 자연. v6.4/v6.5/v6.6 = `신규 도입` suffix 이미 보유 = 갱신 부재 자연 (역사적 정합).",
      "alternatives_rejected": "CHANGELOG 갱신 부재 (frontmatter vs CHANGELOG drift 잔존, § 7.2 smoke scope 미정합)"
    },
    {
      "id": "D5",
      "decision": "phase 분할 = lightweight 1-phase (phase-1 통합 commit = 12 mechanical edit + 1 commit REPORT)",
      "rationale": "scope ~9 frontmatter + 3 CHANGELOG = 12 mechanical edit + ROADMAP/MILESTONE/REPORT 갱신. v6.7~v6.14 lightweight 1-phase 8 consecutive 누적 패턴 정합. 2-phase 분할 = overhead 과잉.",
      "alternatives_rejected": "2-phase (frontmatter + CHANGELOG 분리, 본 scope mechanical edit 동질 본질 분리 의미 부재)"
    },
    {
      "id": "D6",
      "decision": "5 관점 검토 = inline self-review (architecture / spec-drift / 회귀 risk / 보안 / scope contract)",
      "rationale": "RESEARCH oos_5 = lightweight scope ~9 위치 = subagent 병렬 overhead 부적합. v6.7~v6.14 inline self-review 8 cycle 누적 정합. DESIGN 안 inline matrix 채움.",
      "alternatives_rejected": "5 관점 subagent 병렬 (scope mismatch, overhead 과잉)"
    },
    {
      "id": "D7",
      "decision": "ROADMAP entry summary = retitle 6건 narrative + status fix 3건 + (C) 별 milestone 보존 명시 + lightweight 1-phase 누적 patterns",
      "rationale": "사용자 결정 (A)+(B) 본질 + (C) 분리 명시 의무. summary 안 본질 + 후속 별 milestone 거명 자연.",
      "alternatives_rejected": "summary 안 (C) narrative 부재 (audit trail 약화)"
    },
    {
      "id": "D8",
      "decision": "본 milestone 도그푸드 cycle 2 (v6.3 cycle 1 후속) = § 7.2 entry title 가이드 자기 적용 evidence",
      "rationale": "v6.3 entry-title-guideline-smoke-verification (2026-05-20) = § 7.2 (1)+(2) 자동 강제 + 자기 적용 cycle 1 (v6.3 자체 entry title 도그푸드). 본 v6.15 = § 7.2 (3) Active form 자기 적용 cycle 2 (smoke 자동 강제 외 AI 판단 위임 본질). REPORT 안 도그푸드 cycle 명시.",
      "alternatives_rejected": "도그푸드 narrative 부재 (자기 적용 evidence 약화)"
    },
    {
      "id": "D9",
      "decision": "v5.7 spec-drift spike (c-2) DESIGN 즉시 정정 분기 12번째 자연 발현 = v6.13 cycle 10 → v6.14 cycle 11 → v6.15 cycle 12 누적 (ARCHITECTURE § 6 끝 paragraph cycle counter 갱신 의무)",
      "rationale": "RESEARCH ext_1 = Anthropic Claude Code spec 안 `entry title active form retitle` first-class 패턴 부재 (Conventional Commits / Keep a Changelog 안 entry title style guide 부재) → 자체 정전화 자연 = (c-2) 분기 본질. v6.13 paragraph 정정 후 cycle counter inline 갱신 의무 (v6.13/v6.14 cycle 12 인용 패턴 정합).",
      "alternatives_rejected": "cycle counter 갱신 부재 (cross-ref drift 누적 위험)"
    }
  ],
  "approach": "사용자 명시 APPROVE 후 phase-1 일괄 mechanical edit — (1) v6.4~v6.9 frontmatter 6 title retitle (suffix `도입` 5건 + `통일` 1건) + (2) v6.6/v6.8/v6.9 frontmatter status `in_progress` → `completed` 3건 + (3) CHANGELOG v6.7/v6.8/v6.9 bullet bold 3건 동기 갱신 + (4) ROADMAP milestones[] v6.15 in_progress entry 추가 + next_candidates#5 promote 제거 + (5) ARCHITECTURE § 6 끝 spec-drift spike paragraph cycle counter 12 갱신 + (6) CHANGELOG [v6.15] entry 추가 + (7) MILESTONE.md ## EXECUTE 안 phase-1 1차 commit narrative + (8) ## VERIFY/REPORT/PROPOSE 갱신 + 2차 commit.",
  "phases": [
    {
      "phase": 1,
      "scope": "frontmatter retitle 6 + status fix 3 + CHANGELOG bullet bold 3 + ROADMAP v6.15 in_progress + ARCHITECTURE § 6 cycle 12 + CHANGELOG [v6.15] entry + MILESTONE.md ## EXECUTE 갱신 — 1 commit",
      "expected_commit_message": "feat(meta): EXECUTE phase-1 v6.15 — v6.4~v6.9 entry title active form 재정의 + status cleanup"
    },
    {
      "phase": "REPORT",
      "scope": "MILESTONE.md ## VERIFY/REPORT/PROPOSE/SUB_MILESTONES 갱신 + ROADMAP status completed — 1 commit",
      "expected_commit_message": "feat(meta): REPORT v6.15 — lessons + PROPOSE candidates"
    }
  ],
  "risk_mitigation": [
    {"risk_id": "risk_1", "addressed_by": "oos_2 본문 narrative 자기 cross-ref = audit trail 보존 명시 + EXECUTE scope 정확 한정 (frontmatter + CHANGELOG bullet bold 양방 만)"},
    {"risk_id": "risk_2", "addressed_by": "D4 + EXECUTE 안 retitle 후 즉시 pre-commit smoke 호출 검증 (≤ 60자 사전 codepoint 검증 + ` + ` literal space 부재 사전 확인)"},
    {"risk_id": "risk_3", "addressed_by": "EXECUTE 직전 grep 6 패턴 cross-ref 검색 (host 식별 후 audit trail 보존 vs forward 갱신 결정)"},
    {"risk_id": "risk_4", "addressed_by": "D2 + REPORT 안 lesson + PROPOSE 안 (C) 별 milestone candidate 등재 (id 후보 거명 명시)"},
    {"risk_id": "risk_5", "addressed_by": "D6 inline matrix self-review + v6.7~v6.14 패턴 정합 본질"}
  ]
}
```

### 5 관점 inline self-review

| 관점 | 결과 | 발견 |
|---|---|---|
| **architecture** | PASS | § 7.2 (3) Active form 원칙 자기 적용 + § 7.2 (1) 한 본질 (umbrella `frontmatter entry cleanup`) 정합 + lightweight 1-phase 9 consecutive 누적 patterns. P3#1 = 자기 적용 도그푸드 cycle 2 narrative 명시 권고 (REPORT 안 흡수). |
| **spec-drift** | PASS | Anthropic Claude Code spec 안 entry title style guide 부재 = 자체 정전화 자연 (v5.7 spike (c-2) cycle 12). § 7.2 본 repo 자체 컨벤션 (v6.0 정전화) 자기 적용 본질. P2#1 = v5.7 paragraph cycle counter 12 갱신 의무 (D9 흡수). |
| **회귀 risk** | PASS | smoke-entry-title-guideline (v6.3) 회귀 0 보장 (codepoint length 사전 검증 ≤ 60 ✓ + ` + ` literal space 부재 ✓ 모두 사전 확인). pre-commit 18 hook 영향 0 또는 +0 (CHANGELOG bullet bold 갱신 후 정합 강화). P3#1 = EXECUTE 후 즉시 pre-commit `--all-files` 호출 검증 명시 권고 (D4 흡수). |
| **보안** | PASS (vacuous) | 본 milestone narrative-only mechanical edit = 보안 영향 부재 (input validation / 외부 호출 / 인증 영역 부재). vacuous trim 자연. |
| **scope contract** | PASS | INTENT.success_criteria 6건 + out_of_scope 5건 명시 + 사용자 결정 (A)+(B) 흡수 (C) 분리 본질 정합. P2#1 = oos_1 (C) 별 milestone candidate id 후보 거명 명시 권고 (PROPOSE 안 흡수). |

**inline self-review 종합**: decisive 0 + P2 2 (D9 + oos_1 narrative, EXECUTE/PROPOSE 안 흡수) + P3 2 (architecture + 회귀 risk narrative 권고, REPORT/EXECUTE 안 흡수). v6.7~v6.14 inline self-review 8 cycle 누적 정합 (decisive 0 / P2 1~3 / P3 1~2 converged trend).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-21",
    "decision_basis": "사용자 명시 승인 (2026-05-21) — EXECUTE plan 전체 (frontmatter title 6 retitle + status fix 3 + CHANGELOG bullet bold 3 + ARCHITECTURE § 6 cycle 12 + CHANGELOG [v6.15] entry + 2 commit 분할) 그대로 진행 승인.",
    "pre_plan_rounds_count": 5,
    "pre_plan_rounds_summary": "Round 1 = 방향성 (narrative 정전화) / Round 2 = 후보 선택 (#5 v6.7 active form retitle, 디테일 비교 분석 후) / Round 3 = scope (v6.4~v6.9 6건 일괄, Option B) / Round 4 = 추가 발견 흡수 ((A)+(B) = retitle 6 + status fix 3, (C) 별 본질 보존) / Round 5 = suffix 표준 (case-by-case = 5건 `도입` + v6.9 `통일`)",
    "execute_gate": "approved — phase-1 EXECUTE 진입"
  }
}
```

**Approval 본질**: EXECUTE 진입 게이트. 사용자 명시 결정 후 본 섹션 `approved_by: "user"` + `date: "YYYY-MM-DD"` 갱신.

## EXECUTE

phase-1 별책 위임 — [`execute/phase-1.md`](execute/phase-1.md). 2026-05-21 사용자 명시 승인 후 진행 — frontmatter title 6 retitle + status fix 3 + CHANGELOG bullet bold 3 동기 + ARCHITECTURE § 6 cycle 12 + CHANGELOG [v6.15] entry + ROADMAP v6.15 in_progress = 12 mechanical edit + 1 phase-1.md 별책 + pre-commit 18 hook PASS 검증.

phase-1 commit message (expected): `feat(meta): EXECUTE phase-1 v6.15 — v6.4~v6.9 entry title active form 재정의 + status cleanup`.

phase-2 (REPORT) 후 별 commit — `feat(meta): REPORT v6.15 — lessons + PROPOSE candidates`.

## VERIFY

(EXECUTE 완료 후 갱신 — smoke 결과 + criteria_check vs INTENT.success_criteria)

## REPORT

(EXECUTE 완료 후 갱신 — summary + delta + lessons_learned)

## PROPOSE

(EXECUTE 완료 후 갱신 — next_candidates ROADMAP 등재)

## SUB_MILESTONES

본 milestone 단일 본질 = entry title cleanup umbrella (frontmatter title retitle + status drift fix 동질 frontmatter cleanup). sub-milestone 부재 (1 의미 단위, bundling 정책 v6.2+ flattened era 안 흡수 본질).

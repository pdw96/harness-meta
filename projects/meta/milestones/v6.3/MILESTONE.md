---
id: entry-title-guideline-smoke-verification
title: entry title 가이드 smoke 자동 검증
version: v6.3
status: in_progress
---

# v6.3 — entry title 가이드 smoke 자동 검증

## INTENT

### Spec

```json
{
  "goal": "ARCHITECTURE § 7.2 entry title 가이드 4 원칙 중 (1) 한 entry = 한 본질 + (2) ≤ 60자 자동 검증 도입 — 신규 smoke-entry-title-guideline.sh 단일 책임 (tests/CLAUDE.md v3.1 L3 D16 정합). ROADMAP entries + CHANGELOG bullet headers 양 source cover. Corrective + Preventive 통합 — smoke 도입 + 15 long-title 일괄 정정 (title 만 retitle, id 보존). (3) Active form + (4) Detail summary 분리 = 자동 검증 제외 (휴리스틱 false-positive 위험 + 의미 차원 = AI 판단 영역). AI Native 운영 § 7.1 'Verification' 면 첫 실 적용 milestone.",
  "success_criteria": [
    {"id": "sc_1", "description": "신규 tests/smoke-entry-title-guideline.sh — (1) ' + ' 정밀 regex (코드 식별자 R1+R2 / C++ 형태 제외 — 공백 양옆 + 만 매칭) + (2) char count > 60 자동 검출. enumerate scope = projects/*/ROADMAP.md (milestones[] / next_candidates[] / deferred title 필드) + CHANGELOG.md (bullet bold `**title**` form). pre-commit hook 등재 (entry 직접 호출, --fix 미지원)."},
    {"id": "sc_2", "description": "Corrective 일괄 정정 — 3 source union 합산 ≈ **43건** (meta ROADMAP 15 + upbit ROADMAP 14 + CHANGELOG bullet 14, P1 ∨ P2 합집합) / intersection ≈ **30건** (P1 ∧ P2 교집합, '> 60자 ∧ '+' 동시 위반). title 만 retitle (id 보존 + summary 안 detail context 보강). cascade host = ROADMAP entry retitle 만 — milestone 산출물 안 title (REPORT.md / milestones.md / MILESTONE.md frontmatter) 은 historical artifact 동결 (regression p1_4 흡수). git log = immutable (rewrite 금지)."},
    {"id": "sc_3", "description": "smoke 자체 self-check — 의도 violation 주입 (long-title 1건 + ' + ' 1건) → FAIL → 정정 → PASS controlled 비교 4-step (tests/CLAUDE.md § 회귀 검증 절차 정합)."},
    {"id": "sc_4", "description": "회귀 0 — 기존 smoke **7종** (projects-scope-discipline / spec-verification / scope-contract / cross-ref / claude-md-drift / bundle-trigger / open-stage-discipline) 및 pre-commit 현 **11 hook** (local 7 + upstream 4: end-of-file-fixer / trailing-whitespace / check-merge-conflict / check-yaml / check-added-large-files / shellcheck / markdownlint) 모두 PASS. v6.3 도입 후 = 신규 smoke 추가로 pre-commit 12 hook. v6.3 자체 entry title (`entry title 가이드 smoke 자동 검증`, 22자) 도 자동 검증 PASS."},
    {"id": "sc_5", "description": "ARCHITECTURE § 7.2 4 원칙 paragraph 안 'smoke 자동 검증 정전화 — (1)+(2) auto / (3)+(4) AI 판단 위임' narrative 추가 (v3.21 narrative 정전화 3 단계 패턴 cycle 28 도그푸드)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "(3) Active form 자동 검증", "reason": "한국어 동사 종결 휴리스틱 false-positive 위험 + 현재 위반 0건 (cost > benefit). LLM 직접 판단 위임. v6.x 후속 자율성 면 milestone 시점 재검토 가능."},
    {"id": "oos_2", "item": "(4) Detail summary 분리 자동 검증", "reason": "의미 차원 = AI 판단 영역. 자동 검증 logic 부재."},
    {"id": "oos_3", "item": "milestone id renumber (예: ai-native-operation-reframe-and-entry-title-guideline → ai-native-reframe)", "reason": "id 보존 결정 (pre-PLAN round 3). renumber 시 cascade 영향 (REPORT.md / git log / CHANGELOG cross-ref) 크고 v3.11 renumber 패턴은 신중 적용."},
    {"id": "oos_4", "item": "pre-v6.3 entry waiver 필드 (grandfather 방식)", "reason": "corrective + preventive 통합 결정 (pre-PLAN round 2). waiver = 때때로 stale narrative 지속 우려, 수용 거부."},
    {"id": "oos_5", "item": "CHANGELOG bullet 외 narrative (REPORT.md / DESIGN.md 안 title 인용) 자동 검증", "reason": "§ 7.2 정의 entry-form artifact 한정 = ROADMAP entry + CHANGELOG bullet header. 본문 narrative 안 title 인용은 자동 검증 scope 외."}
  ]
}
```

### Motivation

v6.0 DESIGN.D11 P2 origin (`entry-title-guideline-smoke-verification`, target v6.3). v6.2 OPEN 안 v6.2 → v6.3 shift 결정 (디렉토리 평탄화 단독 scope, bundling 안 함).

현 3 source 합산 위반 (2026-05-19g 실측):

- **meta ROADMAP**: 35 titles 중 **15건** > 60자 (43%) + **15건** ' + ' (cross-cohort 동일 set)
- **upbit ROADMAP**: 21 titles 중 **14건** > 60자 (67%) + **12건** ' + '
- **CHANGELOG bullet**: 98 titles 중 **14건** > 60자 + **14건** ' + '
- **합계** ≈ 30~43 unique = entry title 가이드 4 원칙 실 misuse

§ 7.2 정의는 v6.0 정전화이나 자동 강제 부재 → 재발 회피 logic 필요.

pre-PLAN 3 round 누적 결정 (2026-05-19g):

1. **smoke 위치** — 신규 `smoke-entry-title-guideline.sh` (단일 책임, tests/CLAUDE.md v3.1 L3 D16 정합)
2. **Corrective + Preventive 통합** — smoke 도입 즉시 fail 이 corrective phase 분기
3. **자동 검증 범위** — (1) + (2) 둘 다 (정밀 regex + 길이) / (3) + (4) 제외 (휴리스틱 위험 + 의미 차원)
4. **정정 방향** — title 만 retitle, id 보존 (cascade 영향 회피)
5. **Scope 대상** — ROADMAP + CHANGELOG bullet 모두

### Dependencies

- **dep_1**: pre-PLAN dialog 3 round (2026-05-19g) — 사용자 결정 source
- **dep_2**: ARCHITECTURE § 7.2 entry title 가이드 4 원칙 (v6.0 정전화) — 검증 기준 source
- **dep_3**: ROADMAP next_candidates `entry-title-guideline-smoke-verification` (v6.0 D11 P2 origin) — 본 milestone origin
- **dep_4**: tests/CLAUDE.md § smoke 매트릭스 + v3.1 L3 D16 책임 분리 원칙 — 신규 smoke 단일 책임 정합
- **dep_5**: v6.2 안 5 관점 subagent 병렬 검토 패턴 (Plan + general-purpose 4) — DESIGN stage 적용 예정 (cascade host ≥ 3, 정보 손실 위험 = 중간)
- **dep_6**: feedback_anthropic_yaml_frontmatter_pattern + v6.1 hybrid schema — INTENT/RESEARCH/DESIGN H2 안 `### Spec` + ```json``` body 적용 (v6.2 정합)
- **dep_7**: memory `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` + `feedback_token_efficiency_priority` — 작업 톤 가이드

### Harness engineering mapping

- **element**: Verification (1차)
- **target**: (b) mechanism cross-ref 갱신 — § 3.3 5요소 매트릭스 Verification 행 sub-mechanism cross-ref **자동 강제 entry-form 첫 확장** (기존 milestone 산출물 schema / scope-contract / bundle-trigger 외 entry title 가이드 추가)
- **rationale**: AI Native § 7.1 3 면 안 **Verification 면 첫 실 적용** (v6.0 정의 + v6.1 컨텍스트 효율 cycle 1 + v6.2 cycle 2 → v6.3 = Verification 면 첫 milestone, Constraint = 가드레일과 직교).

### 명료화

#### 본 milestone 의 위치 — AI Native 시리즈 v6.3

| Version | 본질 | AI Native 면 |
|:-:|------|------|
| v6.0 (완료) | 정의 + entry title 가이드 | 정의 정전화 |
| v6.1 (완료) | JSON 필드 감축 (Anthropic 하이브리드) | 컨텍스트 효율 (cycle 1) |
| v6.2 (완료) | 디렉토리 평탄화 (b) 하이브리드 | 컨텍스트 효율 (cycle 2) |
| **v6.3 (본)** | entry title 가이드 smoke 자동 검증 | **Verification (첫 실 적용)** |
| v6.4 (예약) | cascade 자동 동기 | 다중 AI 협업 |
| v6.5 (예약) | Claude 자율 발의 | 자율성 |
| v6.6 (예약) | hallucination 자동 정정 | 다중 AI 협업 |
| v7.0 (예약, major) | 3 면 통합 | — |

#### Corrective + Preventive 통합 정당

도입 즉시 fail (15건 long-title) = corrective phase 분기 자연. 두 책임 1 milestone 통합 — phase 구분 (phase-1 smoke 도입 + phase-2 corrective 일괄 정정) 또는 1 phase 통합 결정 = DESIGN stage 안.

#### (3) (4) 제외 정당

- **(3) Active form** — 한국어 동사 종결 휴리스틱 검증 시 false-positive 위험 (한국어 변형 다양). 현재 ROADMAP 35 entries 안 (3) 위반 0건 (한자어 동사 종결 well-followed). cost > benefit.
- **(4) Detail summary 분리** — 의미 차원 = AI 판단 영역. 자동 검증 logic 부재.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "memory/feedback_anthropic_yaml_frontmatter_pattern + v6.1 hybrid schema", "finding": "Anthropic / GitHub Claude Code 패턴 안 entry title 길이 / active form 표준 부재 — internal 정전화 (§ 7.2 v6.0). 외부 source 부재 → RESEARCH 본 milestone scope 안 ext 의존 회피, internal 검증 단일 source."},
    {"id": "ext_2", "source": "context7 `/davidanson/markdownlint` (Stage D 5 관점 spec-drift 검증 완료)", "finding": "markdownlint MD013 = line length (default 80, `heading_line_length` 별도 옵션 default 80) 만 line-level 검증, **entry title (JSON 안 title key 또는 CHANGELOG bullet bold) semantic structure 별도 lint rule 부재 확인**. 본 milestone 60자 baseline vs MD013 default 80 char = -25% (한국어 entry-form artifact 특수 baseline 채택 — 시각 폭 동치 ≈ 영문 120자, MD013 line-level 과 직교). 외부 표준 비의존 internal 정전화 정합."},
    {"id": "ext_3", "source": "context7 `/websites/conventionalcommits` + `/websites/keepachangelog_en_1_1_0` (Stage D 5 관점 spec-drift 검증 완료)", "finding": "**spec-drift 정정 의무 흡수** (v5.7 spike 패턴 c DESIGN 즉시 정정 분기). (a) Conventional Commits spec 본문 안 50/72 char header 제한 **미명시** (Git tpope 50/72 관례 origin, Conventional Commits 자체는 description 길이 자유). (b) Keep a Changelog v1.1.0 안 'noteworthy differences', 'human-readable' 가독성 권고만, **bullet title 길이/구조 별도 강제 부재** ('semantic structure 명시' over-claim 정정). 본 60자 baseline = 외부 표준 비의존 internal 정전화 (한국어 entry-form artifact 특수 baseline)."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "projects/meta/ARCHITECTURE.md:247-254", "finding": "§ 7.2 4 원칙 정전화 단일 source (v6.0 도입). (1)+(2)+(3)+(4) Markdown body 4 bullet. 본 milestone phase 안 'smoke 자동 검증 정전화 — (1)+(2) auto / (3)+(4) AI 판단 위임' narrative 추가 cascade host #1."},
    {"id": "cb_2", "file": "projects/meta/ROADMAP.md (next_candidates 안 v6.3 entry 제거 후 milestones[] 안 in_progress 이동 완료 — OPEN stage)", "finding": "smoke enumerate scope = milestones[].title + next_candidates[].title + deferred entry title 모두 cover. JSON 안 'title' 키 regex `\"title\":\\s*\"([^\"]+)\"` 추출 안전 (size_limit 100KB defense-in-depth, smoke-bundle-trigger 패턴 정합)."},
    {"id": "cb_3", "file": "projects/upbit/ROADMAP.md", "finding": "upbit ROADMAP 21 titles 중 14건 > 60자 + 12건 ' + ' 위반. 본 smoke 가 enumerate 시 projects/*/ROADMAP.md 모두 cover. corrective phase 안 14건 일괄 정정 의무."},
    {"id": "cb_4", "file": "CHANGELOG.md", "finding": "bullet bold form `- **{title}** —` 형식. 98 titles 중 14건 > 60자 + 14건 ' + ' 위반. regex 추출 = `^[\\s]*-[\\s]+\\*\\*([^*]+)\\*\\*` (multi-line bold 위험 회피 — `[^*]+` 단일 라인 한정)."},
    {"id": "cb_5", "file": "tests/smoke-bundle-trigger.sh:33-68", "finding": "V1 algo 정합 — python3 heredoc + json.load + dict-key assertions + SIZE_LIMIT 100KB defense-in-depth + python3 부재 시 SKIP exit 0. 본 smoke 도 동일 V1 패턴 채택 (단일 source)."},
    {"id": "cb_6", "file": "tests/smoke-projects-scope-discipline.sh:28-100", "finding": "ROADMAP JSON 추출 패턴 (extract_json_block 함수) 정합. milestones[] + next_candidates[] enumerate 시 `data.get('milestones', []) + data.get('next_candidates', [])` 패턴 채택."},
    {"id": "cb_7", "file": "tests/CLAUDE.md § smoke 매트릭스 안 핵심 정책 검증 row", "finding": "신규 smoke = 영향 범위 모든 세션 = 핵심 정책 검증 카테고리. 본 매트릭스 1 row 추가 — `smoke-entry-title-guideline.sh` / ARCHITECTURE § 7.2 4 원칙 (1)+(2) auto. cascade host #4."},
    {"id": "cb_8", "file": ".pre-commit-config.yaml", "finding": "현 **local 7 hook + upstream 4 = 총 11 hook active** (regression p1_1 실측 정정). 본 smoke 추가 시 local 8 hook + upstream 4 = 총 12 hook. `entry` 형식 = direct (`bash tests/smoke-entry-title-guideline.sh`, --fix 미지원). `files:` 패턴 = `ROADMAP\\.md$|projects/.*/ROADMAP\\.md$|CHANGELOG\\.md$`. cascade host #5."},
    {"id": "cb_9", "file": "claude/commands/harness-meta.md — workflow stage narrative", "finding": "Stage I PROPOSE 안 next_candidates 등재 시 본 가이드 적용 명시. 본 milestone scope 외 — v6.x 후속 별 milestone (verbatim cascade). cascade host #6 (선택, oos)."},
    {"id": "cb_10", "file": "projects/meta/milestones/v6.0/PROPOSE.md:62-65", "finding": "v6.0 PROPOSE 안 next_candidate id=entry-title-guideline-smoke-verification / title='smoke-spec-verification 안 entry title 가이드 4 원칙 자동 검증 (P2 후속)' / trigger_type='DESIGN.D11_p2'. origin 확인 = v6.0 DESIGN.D11 cascade host 4→6 review 시 5 관점 검토 안 spec-drift P2 후속 발의 (P2 흡수 deferred). 본 v6.3 = D11_p2 trigger 직접 후속 (smoke 위치 결정 변경 = smoke-spec-verification → 신규 smoke-entry-title-guideline.sh, pre-PLAN round 1 결정)."}
  ],
  "options": [
    {"id": "opt_1", "name": "(opt-A) python heredoc V1 (smoke-bundle-trigger 정합)", "summary": "python3 heredoc + regex 정밀 + SIZE_LIMIT + SKIP exit 0. JSON 추출 = json.load (ROADMAP) / regex (CHANGELOG bullet). 자동 위반 보고 + exit code 1 fail.", "pros": ["기존 smoke V1 패턴 정합 (단일 source)", "JSON 파싱 안전", "context7 spec-drift 패턴 정합"], "cons": ["python3 의존 (환경 가드 SKIP)"]},
    {"id": "opt_2", "name": "(opt-B) bash grep + arithmetic (외부 의존 0)", "summary": "shell grep + awk + sed로 직접 추출 + bash `${#var}` length 비교.", "pros": ["python3 미의존"], "cons": ["JSON 추출 어려움 (multi-line title 위험)", "CHANGELOG bullet 양식 정확 매칭 어려움", "V1 단일 source 부정 — 책임 분리 깨짐"]},
    {"id": "opt_3", "name": "(opt-C) jq + bash (외부 의존 jq)", "summary": "jq 로 ROADMAP JSON 추출 + bash length 비교.", "pros": ["JSON 추출 명확"], "cons": ["jq 외부 의존 (선택적, tests/CLAUDE.md § 외부 의존 안 명시 but 의존 추가)", "CHANGELOG bullet 처리 별도 (잘 안 맞음)", "V1 단일 source 부정"]}
  ],
  "risks_identified": [
    {"id": "r_1", "description": "False-positive — ' + ' 정밀 regex 안 코드 식별자 (R1+R2 / C++ / v1.7+v1.12+v1.13) 부적절 검출", "mitigation": "공백 양옆 + 만 매칭 (`\\s\\+\\s`). 인접 alphanumeric+ 차단. DESIGN 단계 안 정확 regex 명시."},
    {"id": "r_2", "description": "Corrective scope expansion (15 → ~43건) — 단일 phase 일괄 처리 시 risk", "mitigation": "phase 분할 (phase-1 smoke 도입 + phase-2 corrective 일괄 정정) — DESIGN 단계 안 결정. v6.1 + v6.2 = 2 phase 패턴 정합."},
    {"id": "r_3", "description": "Cascade host drift — REPORT.md / milestone summary 안 self-referenced title 인용 (예: v6.0 REPORT 안 'AI Native 운영 reframe + entry title 가이드 정전화' 인용)", "mitigation": "id 보존 결정 = REPORT.md / git log 안 id reference 보호. title 인용 narrative = corrective phase 안 grep + 1:1 갱신 (controlled scope)."},
    {"id": "r_4", "description": "Smoke enumerate scope — next_candidates[] / deferred / candidate_draft[] 모두 cover 안 함 위험", "mitigation": "DESIGN 안 enumerate scope 명시 = `data['milestones']` + `data['next_candidates']` + `data.get('candidate_draft', [])` + deferred entries (status 필드 무관 모든 title 검증)."},
    {"id": "r_5", "description": "CHANGELOG bullet 양식 변형 — multi-line bold 또는 nested list 안 bold", "mitigation": "regex `^[\\s]*-[\\s]+\\*\\*([^*]+)\\*\\*` (`[^*]+` 단일 라인 한정) + line-by-line scanning. multi-line bold 매칭 거부 (false-positive 회피)."},
    {"id": "r_6", "description": "Corrective phase 안 retitle 실수 → smoke 자체 self-check FAIL", "mitigation": "phase-2 안 commit 전 smoke 직접 실행 (manual gate, pre-commit autofix 부재). controlled 비교 4-step (tests/CLAUDE.md § 회귀 검증 절차)."},
    {"id": "r_7", "description": "v6.3 자체 entry title self-check 회귀 위험", "mitigation": "title `entry title 가이드 smoke 자동 검증` = 22자 (안전) + ' + ' 부재 (안전). 자동 검증 PASS 보장. ROADMAP v6.3 in_progress entry 확인 (OPEN stage 완료)."}
  ]
}
```

### 코드베이스 grep 결과 정리

#### enumerate scope 3 source

| Source | 위치 | titles | > 60자 | ' + ' |
|---|---|---:|---:|---:|
| meta ROADMAP | `projects/meta/ROADMAP.md` | 35 | 15 | 15 |
| upbit ROADMAP | `projects/upbit/ROADMAP.md` | 21 | 14 | 12 |
| CHANGELOG bullet | `CHANGELOG.md` | 98 | 14 | 14 |
| **합계** | | **154** | **43** | **41** |

cross-cohort (= 같은 entry 가 > 60자 ∧ ' + ' 둘 다 위반) ≈ 30~40 unique 위반.

#### cascade host 6건 (smoke 등록 1 + narrative cascade 5)

| # | Host | 책임 |
|:-:|---|---|
| 1 | ARCHITECTURE.md § 7.2 4 원칙 paragraph | 'smoke 자동 검증 정전화 — (1)+(2) auto / (3)+(4) AI 판단 위임' 추가 (v3.21 cycle 28 narrative 정전화) |
| 2 | tests/CLAUDE.md § smoke 매트릭스 안 핵심 정책 검증 row | 신규 smoke 1 row 추가 |
| 3 | .pre-commit-config.yaml | hook 8건째 등록 (entry direct, --fix 미지원, files: `ROADMAP\\.md$\|.../ROADMAP\\.md$\|CHANGELOG\\.md$`) |
| 4 | projects/meta/CLAUDE.md (시점에 smoke count 정합 cascade) | smoke 매트릭스 narrative cascade 시점에 갱신 (smoke-claude-md-drift trigger) |
| 5 | CHANGELOG.md [v6.3] entry (Added/Changed) | smoke 등록 + corrective 정정 narrative |
| 6 | ROADMAP.md (이미 OPEN stage 완료, recent 3 갱신은 REPORT stage 안) | — |

### Options 비교

| opt | 단일 source 정합 | JSON 추출 안전 | CHANGELOG 처리 | 외부 의존 |
|---|---|---|---|---|
| (opt-A) python heredoc V1 | ✅ | ✅ | ✅ | python3 (기존 동일) |
| (opt-B) bash grep | ❌ (V1 단일 source 부정) | ⚠️ multi-line 위험 | ⚠️ 양식 매칭 어려움 | 0 |
| (opt-C) jq + bash | ❌ (V1 단일 source 부정) | ✅ | ⚠️ 별도 처리 | jq 추가 |

**추천 (채택)**: (opt-A) python heredoc V1 — smoke-bundle-trigger / smoke-projects-scope-discipline 정합 + V1 단일 source 보존 + ARCHITECTURE § 6 spec-drift spike 패턴 정합.

### Risks 요약

7 위험 (r_1~r_7). 가장 큰 = r_2 (corrective scope expansion ~43건, phase 분할 mitigation) + r_3 (cascade host drift, id 보존 mitigation) + r_4 (enumerate scope 정확 — next_candidates+deferred 모두 cover).

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "(opt-A) python heredoc V1 채택 — smoke-bundle-trigger / smoke-projects-scope-discipline 정합. python3 heredoc + json.load + regex 정밀. **(보강, security p1_2 흡수)** python3 부재 = SKIP exit 0 (환경 가드, smoke-bundle-trigger 정합) / SIZE_LIMIT 100KB 초과 = **stderr 경고 + exit 1 FAIL** (silent SKIP 폐기 — 정책 우회 channel 차단, 보안 게이트 우선). 두 경우 의미 분리 명시."},
    {"id": "D2", "decision": "' + ' 정밀 regex = `(?<=\\S) \\+ (?=\\S)` (literal space 양옆 + lookbehind/lookahead non-whitespace) — newline/tab 매칭 차단 (security p2_1 흡수). 코드 식별자 (R1+R2 / C++ / v1.7+v1.12+v1.13) 제외 = 인접 alphanumeric 차단 자연 정합 (literal space 만 매칭). Python `re.search` line 별 검사. **(보강, semantics p1_1 흡수)** 본 검출 = § 7.2 P1 mechanical proxy (P1 충분조건 부분집합) — 형식 marker (' + ') 만 검출, 의미 차원 multi-essence (and / 및 / 와 / 그리고) 자동 검출 = oos_2 (4 원칙 의미 차원) 동질 위임. 위반 예: 'A + B' / 안전 예: 'R1+R2'."},
    {"id": "D3", "decision": "Char count > 60 검증 = Python `len(title)` (한국어 codepoint 동치). 한국어 한 글자 = 1 char (UTF-8 multi-byte 와 별개 — character count 단위). > 60 fail / ≤ 60 pass. **(보강, semantics p1_2 흡수)** § 7.2 (2) '한국어 60자 ≈ 영문 120자' = 시각 폭 baseline — 한국어 codepoint 1 ≈ 영문 2 column (≈ 동등 시각 폭). 본 D3 codepoint 단위 = 시각 폭 단위 양립 (한국어 entry-form artifact 특수 baseline)."},
    {"id": "D4", "decision": "Enumerate scope 명시 = ROADMAP JSON 안 모든 `title` 키 (status 무관) — `data.get('milestones', [])` + `data.get('next_candidates', [])` + `data.get('candidate_draft', [])`. milestones[] 안 status='deferred' entry 도 포함 (architecture p1_3 흡수). **(보강, regression p1_6 + semantics p1_4 흡수)** `if key == 'title'` 만 검사, `id` / `summary` / `description` / `deferred_reason` 등 다른 필드 제외 (long-id false-positive 회피). entry-form artifact closed-set boundary 명시 = ROADMAP 4 array (milestones/next_candidates/candidate_draft + deferred 부분) 안 title 필드 + CHANGELOG.md bullet bold header. § 7.2 '기타 entry-form artifact' open-set 은 본 milestone scope 외 (후속 candidate)."},
    {"id": "D5", "decision": "CHANGELOG regex = `^[\\s]*-[\\s]+\\*\\*([^*\\n]{1,500})\\*\\*` (line-by-line iteration + length-bounded `{1,500}` ReDoS 차단 + `[^*\\n]` newline 제외) — security p1_1 흡수. Python 구현 = `for line in content.splitlines(): if len(line) > 4096: continue (skip); re.match(REGEX, line)`. multi-line bold 거부 + 단일 line 길이 cap 4096 (catastrophic backtracking 완전 차단). nested list 안 bullet 도 cover (들여쓰기 무관 leading whitespace 허용)."},
    {"id": "D6", "decision": "Phase 분할 = 2 phase. phase-1 = 신규 smoke 구현 + 자체 self-check controlled 비교 4-step + pre-commit 등재 + 5 acceptance 게이트. phase-2 = corrective ~43건 일괄 정정 + cascade 5 host narrative 정전화 (D14) + ARCHITECTURE § 7.2 paragraph 추가 + CHANGELOG [v6.3] entry. **(보강, architecture p1_5 + regression p1_5 흡수)** phase-1 acceptance 5 게이트 명시: (a) smoke 구현 + (b) controlled 비교 4-step PASS (mktemp tmpfile 가짜 ROADMAP/CHANGELOG fixture 사용, 실 파일 unchanged) + (c) v6.3 자체 entry PASS 검증 + (d) pre-commit 12 hook 모두 PASS + (e) smoke-claude-md-drift L7 'active 7→8' 갱신 후 PASS. (a)~(e) 모두 PASS 시만 phase-2 진입."},
    {"id": "D7", "decision": "5 관점 subagent 병렬 호출 — architecture (Plan) + general-purpose 4 (spec-drift / regression-risk / security-impact / dictionary-semantics). v6.2 패턴 정합. **(보강, architecture p1_4 흡수)** 본 milestone scope (cascade host 5 < 10) 정합 의문은 사용자 결정 (2026-05-19g) 으로 흡수. 실 결과 = 5 관점 모두 pass-with-comments / decisive 0 / P1 21 + P2 14 = v6.2 (20건) 대비 1.75배 검출 — 객관 검토자 가치 evidence 재확인."},
    {"id": "D8", "decision": "Cascade 정전화 5 host (D14, **6→5 정련**, regression p2_2 가짜 host #4 제거) — (1) `projects/meta/ARCHITECTURE.md` § 7.2 4 원칙 paragraph 안 'smoke 자동 검증 정전화 — (1)+(2) auto / (3)+(4) AI 판단 위임' 추가 / (2) `tests/CLAUDE.md` 통합 (= smoke 매트릭스 row 추가 + L7 'active 7→8' caption + '현행 hook 현황' 표 8 row 동시 갱신, single phase-1 commit 안 atomic + architecture p1_1+p1_2 + regression p1_2 흡수) / (3) `.pre-commit-config.yaml` hook 등재 (local 7→8) / (4) `CHANGELOG.md` [v6.3] entry / (5) ROADMAP entry retitle 결과 narrative (phase-2 corrective). v3.21 narrative 정전화 3 단계 패턴 cycle 28 (D16 사이드 effect 명시)."},
    {"id": "D9", "decision": "Corrective ~43건 일괄 정정 — title 만 retitle (id 보존). 정정 원칙: (a) ' + ' → '와 / 및 / 안' 한국어 자연 변환 또는 단일 본질 추출 / (b) > 60자 → 핵심 본질만 추출, detail 은 summary 필드 안 보강. **(보강, regression p1_4 + architecture p1_3 흡수)** milestone 산출물 (REPORT.md / milestones.md / MILESTONE.md frontmatter) title 은 **historical artifact 동결** (ROADMAP 만 retitle). git log = immutable (rewrite 절대 금지). deferred entry 3건 (v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline) 도 corrective 대상 명시 — title 검사 시 deferred 1건 ('RESEARCH 단계 cascade grep ...') 60자 + '+' 위반 확인됨."},
    {"id": "D10", "decision": "v6.0 D11_p2 trigger origin cross-ref — v6.0 PROPOSE 안 entry-title-guideline-smoke-verification candidate 의 origin = DESIGN.D11_p2 (cascade host 4→6 review 시 spec-drift P2 후속 발의). 본 v6.3 = D11_p2 직접 후속. smoke 위치 변경 (smoke-spec-verification → 신규 smoke) = pre-PLAN round 1 결정 (책임 분리 v3.1 L3 D16 정합)."},
    {"id": "D11", "decision": "Pre-commit entry = direct (`bash tests/smoke-entry-title-guideline.sh`, --fix 미지원). files: `ROADMAP\\.md$\\|projects/.*/ROADMAP\\.md$\\|CHANGELOG\\.md$`. tests/CLAUDE.md § pre-commit hook entry 정책 정합 (--fix 미지원 = direct 호출). **(보강, regression p1_3 흡수)** trigger overlap 의도 = ROADMAP edit 시 3 smoke (projects-scope-discipline + bundle-trigger + entry-title-guideline) 동시 실행 = 책임 직교 (thin index vs bundling vs title 가이드, 의도된 설계). `CHANGELOG.md` trigger = **pre-commit 첫 CHANGELOG-trigger smoke 도입** (기존 hook 중 cover 부재). 실패 시 출력 prefix = `[smoke-entry-title-guideline] FAIL: ...` (사용자 혼동 회피)."},
    {"id": "D12", "decision": "v6.3 자체 entry title self-check — 본 milestone title `entry title 가이드 smoke 자동 검증` (22자, ' + ' 부재) = 자동 검증 PASS. ROADMAP v6.3 in_progress entry 도 위반 부재 (OPEN stage 후 검증). dogfood 자기 일관성 보장. (참조: dictionary-semantics p2_2 = title 자체 P3 'Active form + 동사구 시작' 부합도 = 명사구 시작 = oos_1 (P3 자동 검증 제외) 정합 — 본 milestone retitle scope 외 v6.x 후속 candidate.)"},
    {"id": "D13", "decision": "5 관점 검토 결과 = pass-with-comments × 5 / decisive 0 / P1 21건 (architecture 5 + spec-drift 3 + regression 6 + security 2 + dictionary-semantics 5) 모두 DESIGN edit 흡수 + P2 14건 PROPOSE deferred. v6.2 (P1 11 + P2 9 = 20건) 대비 1.75배 — feedback_subagent_parallel_review_evidence cycle 2 확장 evidence."},
    {"id": "D14", "decision": "Cascade host 6→5 정련 (regression p2_2 흡수) — 원안 host #4 (`projects/meta/CLAUDE.md` smoke 매트릭스 narrative cascade) 가 실 확인 시 가짜 host (projects/meta/CLAUDE.md 안 smoke 매트릭스 narrative 부재, navigator 역할만). 정련 결과 = 5 host (ARCHITECTURE / tests/CLAUDE.md 통합 / .pre-commit-config.yaml / CHANGELOG / ROADMAP retitle)."},
    {"id": "D15", "decision": "spec-drift 즉시 정정 (RESEARCH ext_2 + ext_3) — v5.7 spike 패턴 (c) DESIGN 즉시 정정 분기 **4번째 자연 발현 cycle** (v4.2 + v5.6 + v6.2 + v6.3). ext_2 markdownlint MD013 default 80 vs 본 60자 baseline 비교 narrative + ext_3 Conventional Commits 50/72 미명시 + Keep a Changelog semantic structure over-claim 정정 — RESEARCH 갱신 완료 (spec-drift P1 3건 흡수)."},
    {"id": "D16", "decision": "v3.21 narrative 정전화 3 단계 패턴 cycle 28 = **사이드 effect cycle 명시** (dictionary-semantics p1_5 흡수) — 본 milestone 본질 = mechanism creation (smoke + corrective 1차) + narrative 정전화 cascade (2차 사이드 effect). cycle 27 (v6.2) 와 동질 패턴 — narrative 정전화 단독 cycle 아닌 cascade 동반 cycle."},
    {"id": "D17", "decision": "P2 14건 PROPOSE deferred 등재 (Stage I) — architecture p2_1~p2_3 (3건) + spec-drift p2_1 (1건) + regression p2_1~p2_4 (4건) + security p2_1~p2_3 (3건) + dictionary-semantics p2_1~p2_3 (3건). 본 milestone scope 외 사이드 effect 흡수 + 후속 candidate 명시."}
  ],
  "phases": [
    {"phase": 1, "name": "신규 tests/smoke-entry-title-guideline.sh 구현 + 자체 self-check + pre-commit 등재 + v6.3 자체 entry PASS 검증", "commit": "pending", "execute": "execute/phase-1.md"},
    {"phase": 2, "name": "corrective ~43건 일괄 정정 + cascade 6 host narrative 정전화 + ARCHITECTURE § 7.2 paragraph 추가 + CHANGELOG [v6.3] entry", "commit": "pending", "execute": "execute/phase-2.md"}
  ]
}
```

### Risk mitigation

| risk | severity | mitigation |
|---|---|---|
| r_1: False-positive — ' + ' regex 코드 식별자 검출 | med | D2 `(?<=\S) \+ (?=\S)` (literal space + lookbehind/lookahead) — 인접 alphanumeric 자연 차단 + newline/tab 매칭 차단 (security p2_1) |
| r_2: Corrective scope expansion ~43건 | high | D6 2 phase 분할 + phase-1 acceptance 5 게이트 (architecture p1_5) — phase-2 corrective 독립 처리 |
| r_3: Cascade host drift (REPORT.md / git log self-ref) | med | D9 id 보존 + **milestone 산출물 historical artifact 동결** (regression p1_4) — ROADMAP 만 retitle / git log immutable (rewrite 금지) / REPORT.md / milestones.md / MILESTONE.md frontmatter title 동결 (cascade scope 자연 한정) |
| r_4: Smoke enumerate scope 누락 | med | D4 명시 — milestones+next_candidates+candidate_draft+deferred 모두 + `if key == 'title'` 만 검사 (regression p1_6) + entry-form artifact closed-set (semantics p1_4) |
| r_5: CHANGELOG bullet 양식 변형 + ReDoS | high | D5 length-bounded `[^*\n]{1,500}` regex + line-by-line iteration + 단일 line 4096 cap (security p1_1) |
| r_6: Corrective phase 안 retitle 실수 | low | phase-2 commit 전 smoke 직접 실행 (manual gate) + controlled 비교 4-step (tmpfile fixture, regression p1_5) |
| r_7: v6.3 자체 entry title self-check 회귀 | low | D12 자기 일관성 검증 (22자 안전, ' + ' 부재) |
| r_8: SIZE_LIMIT 100KB silent SKIP 정책 우회 channel (security p1_2) | high | D1 보강 — SIZE_LIMIT 초과 시 stderr 경고 + **exit 1 FAIL** (silent SKIP 폐기) |

### 5 관점 검토 결과

| 관점 | verdict | decisive | P1 | P2 | 핵심 |
|---|---|:-:|:-:|:-:|---|
| 1. architecture (Plan) | pass-with-comments | 0 | 5 | 3 | cascade host #2 (tests/CLAUDE.md L7 + 매트릭스 row + 현행 hook 표) 통합 + phase-1 acceptance 5 게이트 (D6) + deferred entry scope 명시 (D9) + 5 관점 정합 가치 narrative (D7) |
| 2. spec-drift (general-purpose) | pass-with-comments | 0 | 3 | 1 | ext_3 Conventional Commits 50/72 부재 + Keep a Changelog over-claim 정정 (RESEARCH 즉시 갱신, v5.7 spike 패턴 c 분기 4번째) + ext_2 MD013 default 80 vs 본 60 비교 narrative (D15 흡수) |
| 3. regression-risk (general-purpose) | pass-with-comments | 0 | 6 | 4 | sc_4 '4종→7종' / '14 hook→11 hook' 실측 정정 + trigger overlap 의도 (D11) + retitle cross-ref 보호 (D9) + tmpfile fixture (D6) + title-only 검사 (D4) + cascade commit atomic (D8) |
| 4. security-impact (general-purpose) | pass-with-comments | 0 | 2 | 3 | CHANGELOG regex ReDoS 차단 `{1,500}` length-bounded (D5) + SIZE_LIMIT 초과 FAIL exit 1 (D1, silent SKIP 폐기) |
| 5. dictionary-semantics (general-purpose) | pass-with-comments | 0 | 5 | 3 | ' + ' = P1 mechanical proxy 명료화 (D2) + codepoint vs 시각 폭 cross-ref (D3) + sc_2 union vs intersection 단어 분리 + entry-form artifact closed-set boundary (D4) + cycle 28 사이드 effect 명시 (D16) |
| **합계** | | **0** | **21** | **14** | P1 21건 DESIGN edit 흡수 완료 + P2 14건 PROPOSE deferred 등재 예정. v6.2 (20건) 대비 1.75배 — feedback_subagent_parallel_review_evidence cycle 2 확장. |

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "scope": "v6.3 entry-title-guideline-smoke-verification — phase-1 (신규 smoke-entry-title-guideline.sh 구현 + tmpfile controlled 비교 4-step + tests/CLAUDE.md cascade + .pre-commit-config.yaml hook 등재 + 5 acceptance 게이트) + phase-2 (corrective ~43건 일괄 정정 + ARCHITECTURE § 7.2 paragraph 추가 + CHANGELOG [v6.3] entry + ROADMAP retitle).",
    "out_of_scope_acknowledged": [
      "oos_1: (3) Active form 자동 검증 제외 (한국어 동사 종결 휴리스틱 false-positive)",
      "oos_2: (4) Detail summary 분리 자동 검증 제외 (의미 차원)",
      "oos_3: milestone id renumber 회피 (cascade 영향)",
      "oos_4: pre-v6.3 entry waiver 필드 거부 (corrective 통합)",
      "oos_5: CHANGELOG bullet 외 narrative 안 title 인용 자동 검증 제외"
    ],
    "p1_absorption_acknowledged": "DESIGN edit 안 21건 모두 흡수 — architecture P1 5 (cascade #2 통합 + acceptance 5 게이트 + deferred entry scope + 5 관점 narrative + cascade host 정확화) + spec-drift P1 3 (Conventional Commits 50/72 부재 + Keep a Changelog over-claim + MD013 비교 narrative) + regression P1 6 (smoke 4→7 / 14→11 hook 실측 + cascade commit atomic + trigger overlap + retitle scope + tmpfile fixture + title-only) + security P1 2 (ReDoS length-bounded + SIZE_LIMIT FAIL) + dictionary-semantics P1 5 (mechanical proxy + 시각 폭 + union/intersection + closed-set + cycle 28 사이드 effect).",
    "p2_acknowledged": "14건 PROPOSE deferred 등재 예정 (Stage I) — architecture P2 3 (AGENTS/README narrative / harness-meta.md Stage I / root ROADMAP SKIP narrative) + spec-drift P2 1 (Anthropic CLAUDE.md 200 lines cross-ref) + regression P2 4 (cb_2 narrative / era-agnostic 보강 / git log immutable r_3 추가 / cascade host #4 가짜 정정) + security P2 3 (\\s newline 매칭 / JSON parse error 명시 / symlink path traversal) + dictionary-semantics P2 3 (한국어 동사 종결 정량 평가 / v6.3 자체 P3 부합 retitle / 50자 vs 60자 narrative).",
    "execute_constraint": "각 phase commit 전 smoke 직접 실행 (manual gate) + pre-commit 자동 검증 + controlled 비교 4-step (tmpfile fixture). phase-1 acceptance 5 게이트 모두 PASS 시만 phase-2 진입.",
    "pre_plan_dialog_rounds": 3,
    "stage_review_rounds": 1,
    "subagent_parallel_review": "5 관점 (architecture Plan + spec-drift + regression-risk + security-impact + dictionary-semantics) 병렬 호출 완료"
  }
}
```

### 승인 narrative

사용자 명시 승인 (2026-05-20, 1 round 'APPROVE 게이트 — v6.3 milestone EXECUTE 진입 명시 승인?' = '승인 + EXECUTE phase-1 진행'). 본 milestone scope 정합 + P1 21건 DESIGN 흡수 완료 + 5 관점 검토 decisive 0 + risk_mitigation 8건 명시 = EXECUTE 게이트 통과.

## EXECUTE

> Stage F EXECUTE pending. phase 별 본책 = `execute/phase-{n}.md`.

## VERIFY

> Stage G VERIFY pending.

## REPORT

> Stage H REPORT pending.

## PROPOSE

> Stage I PROPOSE pending.

## SUB_MILESTONES

> 본 milestone = 단일 sub-milestone (entry title 가이드 smoke 자동 검증). 추가 sub-milestone 부재.

## 관련

- 상위 ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- ARCHITECTURE § 7.2 entry title 가이드 4 원칙: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- 직전 milestone (참조): [`../v6.2/MILESTONE.md`](../v6.2/MILESTONE.md)
- v6.0 origin (DESIGN.D11 P2): [`../_archive/v6.0/`](../_archive/v6.0/) (archive 확인 — 추후 RESEARCH 안 cross-ref)

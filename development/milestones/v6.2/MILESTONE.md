---
id: milestone-artifact-directory-flattening
title: milestone 산출물 디렉토리 평탄화 (단일 파일 통합)
version: v6.2
status: completed
---

# v6.2 — milestone 산출물 디렉토리 평탄화 (단일 파일 통합)

## INTENT

### Spec

```json
{
  "goal": "milestone 산출물 디렉토리 구조 평탄화 — (b) 하이브리드 채택 — 1 milestone 디렉토리 = MILESTONE.md 본책 (## INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE/SUB_MILESTONES H2 9 섹션) + execute/phase-{n}.md 별책. AI 1 Read 으로 milestone 전체 흡수. (1) v6.2~ 신규만 적용, v3.0~v6.1 디렉토리 era 보존 (era 분기 자연 확장). AI Native 운영 § 7.1 컨텍스트 효율 면 두 번째 실 적용.",
  "success_criteria": [
    {"id": "sc_1", "description": "MILESTONE.md schema 정전 정의 — YAML frontmatter 4 필드 + 축소 JSON + H2 9 섹션 + execute/ 별책. ARCHITECTURE § 6.1 era 정책 안 v6.2+ flattened era paragraph 정전화 (단일 source)."},
    {"id": "sc_2", "description": "smoke 4종 (spec-verification + scope-contract + bundle-trigger + open-stage-discipline) era 분기 PASS — v3.0~v6.1 디렉토리 era + v6.2~ 단일 파일 era 둘 다 정확 검출 (회귀 0)."},
    {"id": "sc_3", "description": "cascade host 12건 갱신 — ARCHITECTURE / CLAUDE.md (root + projects/meta + claude + tests) / harness-meta.md / _era_detect.py / smoke 4종 + posttooluse-hook + post-report-write."},
    {"id": "sc_4", "description": "v6.2 자체 도그푸드 retrofit (phase-2) — 개별 파일 4건 (INTENT/RESEARCH/DESIGN/APPROVE.md) + milestones.md → MILESTONE.md 단일 통합. VERIFY/REPORT/PROPOSE 는 통합 후 H2 섹션 누적."},
    {"id": "sc_5", "description": "pre-commit 14 hook 모두 PASS, 회귀 0 (phase-1 + phase-2 각 commit 별)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "v3.0~v6.1 28 active milestone backfill", "reason": "(1) 신규만 결정 (pre-PLAN round 3). 정보 손실 위험 회피 + era 분기 자연 확장."},
    {"id": "oos_2", "item": "_archive 40 건 (v1.0~v3.21)", "reason": "역사적 보존 의도 (v4.0 phase-2 분리 정합)."},
    {"id": "oos_3", "item": "entry-title-guideline-smoke-verification", "reason": "v6.3 별 milestone (bundling 안 함 결정, pre-PLAN round 1)."},
    {"id": "oos_4", "item": "AI Native 시리즈 후속 (cascade 자동 동기 v6.4 / 자율 발의 v6.5 / hallucination 자동 정정 v6.6)", "reason": "별 milestone 예약."},
    {"id": "oos_5", "item": "post-report-write hook 자동 era 분기 검출", "reason": "phase-1 안 수동 갱신만 (단일 파일 era trigger 점 = MILESTONE.md 안 ## REPORT 섹션 추가, hook 안 분기 로직 최소화). 후속 v6.x deferred."}
  ]
}
```

### Motivation

v6.1 PROPOSE#1 origin (`milestone-artifact-directory-flattening`, target_version v6.2). AI Native 운영 § 7.1 컨텍스트 효율 면 **두 번째 실 적용 milestone** (v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화).

현 milestone 디렉토리 구조 = 6~8 파일 흩어짐 (`INTENT.md` + `RESEARCH.md` + `DESIGN.md` + `APPROVE.md` + `VERIFY.md` + `REPORT.md` + `PROPOSE.md` + `milestones.md` + `execute/phase-{n}.md`). AI 가 1 milestone 전체 흡수 시 multi-Read 필요 (8 file × 평균 200 LOC ≈ 1600 LOC 분산). 단일 파일 통합 = 1 Read.

pre-PLAN 6 round 누적 결정 (2026-05-19):

1. **scope** — 디렉토리 평탄화 단독 (entry-title smoke 는 v6.3 별 milestone)
2. **형태** — (b) 하이브리드 (MILESTONE.md 본책 + execute/phase-{n}.md 별책)
3. **적용 범위** — (1) v6.2~ 신규만 (v3.0~v6.1 디렉토리 era 보존)
4. **파일명** — `MILESTONE.md` (대문자, repo docs 정합)
5. **sub-milestones** — (a) `## SUB_MILESTONES` 섹션 흡수 (별도 `milestones.md` 부재)
6. **phase** — (2) 2-phase (phase-1 smoke+cascade / phase-2 v6.2 자체 retrofit)

### Dependencies

- **dep_1**: pre-PLAN dialog 6 round (2026-05-19) — 사용자 결정 source
- **dep_2**: v6.1 PROPOSE#1 (`milestone-artifact-directory-flattening`) + ROADMAP next_candidates — origin
- **dep_3**: v6.1 hybrid schema (YAML frontmatter + 축소 JSON + Markdown body) — 단일 파일 안 H2 섹션 마다 동일 schema 적용
- **dep_4**: ARCHITECTURE § 6.1 era 정책 — v6.2+ flattened era paragraph 신규 추가
- **dep_5**: smoke 4종 위치 grep (Stage C RESEARCH 안 식별) — `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` + `tests/smoke-bundle-trigger.sh` + `tests/smoke-open-stage-discipline.sh`
- **dep_6**: cascade host 식별 (Stage C RESEARCH 안 식별, 12건 확정)
- **dep_7**: memory `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` + `feedback_token_efficiency_priority` + `feedback_anthropic_yaml_frontmatter_pattern` — 작업 톤 가이드

### Harness engineering mapping

- **element**: Context (1차)
- **target**: (b) mechanism cross-ref 갱신 — § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref **두 번째 갱신** (디렉토리 구조 효율). v6.1 첫 갱신 (JSON 필드 schema 효율) + v6.2 두 번째 (디렉토리 구조 효율).
- **rationale**: AI Native 운영 § 7.1 3 면 안 '컨텍스트 효율' 면 두 번째 실 적용. v6.0 정의 → v6.1 JSON 필드 (파일 안 schema 변경) → v6.2 디렉토리 평탄화 (**파일 구조 변경**, 더 큰 단계).

### 명료화

#### 본 milestone 의 위치 — AI Native 시리즈 v6.2

| Version | 본질 | AI Native 면 |
|:-:|------|------|
| v6.0 (완료) | 정의 + entry title 가이드 | 정의 정전화 |
| v6.1 (완료) | JSON 필드 감축 (Anthropic 하이브리드) | 컨텍스트 효율 (cycle 1) |
| **v6.2 (본)** | 디렉토리 평탄화 (b) 하이브리드 | 컨텍스트 효율 (cycle 2) |
| v6.3 (예약) | entry-title 가이드 smoke 자동 검증 | Verification |
| v6.4 (예약) | cascade 자동 동기 | 다중 AI 협업 |
| v6.5 (예약) | Claude 자율 발의 | 자율성 |
| v6.6 (예약) | hallucination 자동 정정 | 다중 AI 협업 |
| v7.0 (예약, major) | 3 면 통합 | — |

#### v6.1 vs v6.2 차이 — 파일 안 schema vs 파일 구조

- **v6.1** = 각 산출물 파일 안 schema 변경 (JSON top 32→14 등). 파일 자체는 그대로 (INTENT.md / RESEARCH.md / ... 분리 유지).
- **v6.2** = 파일 자체를 합침 (`INTENT.md + RESEARCH.md + ... → MILESTONE.md`). 디렉토리 구조 자체 변경 = **더 큰 단계**. 정보 손실 위험 (sc_5 회귀 0 가드).

#### 도그푸드 retrofit 시점 (sc_4)

본 milestone Stage A~E 산출물은 v6.1 era 동치로 개별 파일 작성 (INTENT/RESEARCH/DESIGN/APPROVE.md). Stage F phase-2 안 MILESTONE.md 단일 통합 retrofit. VERIFY/REPORT/PROPOSE 는 통합 후 H2 섹션 신규 작성. 본 MILESTONE.md 자체가 phase-2 retrofit 산출물.

v3.21 narrative 정전화 3 단계 패턴 cycle 27.

#### era 분기 정책 (sc_2)

| Era | 디렉토리 구조 | 적용 milestone |
|---|---|---|
| v1.0~v1.4 | 7-stage flat (`PLAN/RESEARCH/DESIGN/VERIFY/REPORT.md` + execute/) | _archive |
| v2.0~v2.1 | 9-stage flat (`INTENT/RESEARCH/.../PROPOSE.md` + execute/, `milestones/v{X.Y}_{slug}/`) | _archive |
| v3.0~v6.1 | 9-stage-bundled (`INTENT/RESEARCH/.../PROPOSE.md` + `milestones.md` + execute/, `milestones/v{X.Y}/`) | _archive + active 28 |
| **v6.2+** | **9-stage-flattened** (`MILESTONE.md` 단일 + execute/, `milestones/v{X.Y}/`) | **v6.2~ 신규** |

smoke 4종 = era 분기 + version 비교 로직 추가.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "memory/feedback_anthropic_yaml_frontmatter_pattern", "finding": "Anthropic Claude Code 표준 = YAML frontmatter + Markdown body. v6.1 도입 schema 정합 — MILESTONE.md 안 H2 섹션도 동일 schema 적용 (frontmatter 1건 + H2 9 섹션 안 축소 JSON 코드블록 + Markdown body)."},
    {"id": "ext_2", "source": "context7 (Stage D DESIGN 안 spec-drift agent 추정 검증 — Anthropic CLAUDE.md 단일 파일 vs 디렉토리 패턴, D16 안 DESIGN 즉시 정정)", "finding": "RESEARCH 시점 추정 표지 — Anthropic 공식 patterns 안 CLAUDE.md = 1 repo 1 파일 단일 본책. agent .md / SKILL.md / hooks 안 '1 entity = 1 primary file' 패턴 정합 → milestone 1건 = MILESTONE.md 1 본책 + execute/ 별책 디렉토리. D16 DESIGN 즉시 정정 분기 채택, phase-1 spike 부재."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "tests/_era_detect.py:27-36", "finding": "era 분류 단일 source. 9-stage-flattened 신규 era 추가 시 검사 순서 우선 변경 의무 (MILESTONE.md 검사 = milestones.md 검사 직전, D6)."},
    {"id": "cb_2", "file": "tests/smoke-spec-verification.sh:222,233", "finding": "9-stage era 시 INTENT.md/APPROVE.md 파일 fp 존재 검증. v6.2+ flattened era = MILESTONE.md 안 H2 섹션 grep 추가 (D7 a)."},
    {"id": "cb_3", "file": "tests/smoke-scope-contract.sh:164-196", "finding": "detect_era 호출 + 9-stage/9-stage-bundled era 시 INTENT.md/APPROVE.md 검사. v6.2+ flattened era 분기 = MILESTONE.md 안 ## INTENT/## APPROVE H2 추출 (D7 b)."},
    {"id": "cb_4", "file": "tests/smoke-bundle-trigger.sh:47 (실 spike, phase-1)", "finding": "정확 regex = `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/milestones\\.md$`. v6.2 갱신 regex = `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` — era 양립 + `_archive/` prefix 보존 (D7 c, regression P1 #1 흡수)."},
    {"id": "cb_5", "file": "tests/smoke-open-stage-discipline.sh:44,64-69", "finding": "9-stage-bundled era 표지 = 디렉토리 명 + milestones.md 페어링. v6.2+ era 양립 = (MILESTONE.md OR milestones.md) (D7 d)."},
    {"id": "cb_6", "file": "claude/hooks/post-report-write.sh:177-179", "finding": "REPORT_BASENAME 매칭 inject. v6.2 D8 결정 = MILESTONE.md edit 시 hook trigger 부재 (단순함 우선, 사용자 manual PROPOSE 진행). hook 안 milestones.md NOOP 패턴 정합으로 MILESTONE.md 도 NOOP 추가."},
    {"id": "cb_7", "file": "projects/meta/ARCHITECTURE.md:195-218", "finding": "§ 6.1 era 정책 표 4 row + 5 paragraph. v6.2+ 5번째 row + flattened era paragraph 정전화 (D9 #1)."},
    {"id": "cb_8", "file": "CLAUDE.md (root) — milestone 산출물 narrative", "finding": "현 narrative = '산출물 ... Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body) 포맷 의무 (v6.1+)'. v6.2+ flattened era + 4 필드 frontmatter cascade."},
    {"id": "cb_9", "file": "projects/meta/CLAUDE.md — milestone 산출물 narrative", "finding": "현 narrative = '`milestones/v{X.Y}/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `milestones.md` + `execute/phase-{n}.md`'. v6.2+ flattened era 추가 cascade."},
    {"id": "cb_10", "file": "tests/CLAUDE.md — smoke 매트릭스", "finding": "smoke-spec-verification + smoke-scope-contract + smoke-bundle-trigger + smoke-open-stage-discipline + smoke-posttooluse-hook 5 row narrative 갱신 (architecture P1 #2 + regression P2 #2)."},
    {"id": "cb_11", "file": "claude/commands/harness-meta.md — workflow stage narrative", "finding": "Stage A OPEN step 7 안 'milestones/v{X.Y}/milestones.md 스켈레톤 즉시 작성'. v6.2+ era 분기 — MILESTONE.md 안 ## SUB_MILESTONES 섹션 첫 작성."},
    {"id": "cb_12", "file": "claude/CLAUDE.md — PostToolUse narrative (architecture P1 #1, 11→12 보정)", "finding": "현행 패턴 narrative = `v{X.Y}/(INTENT|RESEARCH|.../PROPOSE|execute/phase-{n})\\.md$`. v6.2+ MILESTONE.md NOOP 패턴 + 진화 이력 추가."}
  ],
  "options": [
    {"id": "opt_1", "name": "(opt-A) 단순 era 분기 (v3.0~v6.1 보존 + v6.2~ 신규)", "summary": "_era_detect.py 안 9-stage-flattened 분류 신규 추가 (검사 순서 우선) + 4 smoke era 분기 + 12 narrative cascade.", "pros": ["era 분기 자연 확장 + (1) 신규만 결정 정합", "v3.0~v6.1 디렉토리 era 완전 보존 (정보 손실 0)"], "cons": ["smoke 분기 복잡도 누적 (forward-only trade-off 직접 비용)"]},
    {"id": "opt_2", "name": "(opt-B) glob 별 분기 (디렉토리 detect)", "summary": "era 분기 대신 each milestone 디렉토리 안 MILESTONE.md vs 개별 파일 존재 검사 glob 직접 처리.", "pros": ["era 분류 logic 우회"], "cons": ["era 분류 단일 source 부정 — 책임 분리 깨짐", "smoke 마다 중복 로직", "ARCHITECTURE § 6.1 narrative 4 row 표 깨짐"]},
    {"id": "opt_3", "name": "(opt-C) version 비교 분기 (v6.2 hardcode)", "summary": "directory 이름 v6.2 이상 = flattened era 가정.", "pros": ["가장 단순"], "cons": ["사용자 결정 (3) (1) 신규만 정합 안 함 — v6.2~ '신규 milestone 만' 의도가 'v6.2+ 모든 디렉토리' 로 변질", "phase-2 retrofit 시점 안 짧은 기간 era 모호", "future schema migration 시 hardcode 누적"]}
  ],
  "risks_identified": [
    {"id": "r_1", "description": "정보 손실 — Stage A~E 개별 파일 작성 후 phase-2 안 MILESTONE.md 통합 시 H2 섹션 경계 misalignment", "mitigation": "D12 통합 procedure 명시 (YAML frontmatter 1건 + 각 stage 산출물 1 H2 섹션 매핑 + 코드블록 fenced ```json 보존)"},
    {"id": "r_2", "description": "smoke 회귀 — era 분기 신규 logic 안 v3.0~v6.1 28 milestone PASS 유지", "mitigation": "phase-1 안 controlled 비교 4-step (tests/CLAUDE.md § 회귀 검증 절차 직접 참조, regression P2 #1 흡수)"},
    {"id": "r_3", "description": "외부 visible artifact drift — CHANGELOG.md [v6.2] entry 안 잘못된 link", "mitigation": "Stage I PROPOSE 안 cross-ref 정합 + smoke-cross-ref.sh autofix"},
    {"id": "r_4", "description": "post-report-write hook 모호 — MILESTONE.md ## REPORT 섹션 추가 검출 logic", "mitigation": "D8 결정 = hook trigger 부재 (사용자 manual PROPOSE). tests/smoke-posttooluse-hook.sh NOOP 경로 검증 추가."},
    {"id": "r_5", "description": "smoke-bundle-trigger milestones_path regex anchor false-positive + `_archive/` 누락", "mitigation": "D7 (c) regex 엄격 = `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` (regression P1 #1 흡수)"},
    {"id": "r_6", "description": "chicken-and-egg — v6.2 schema 정의 (phase-1) vs v6.2 자체 retrofit (phase-2)", "mitigation": "D11 phase 순서 정합 (schema 먼저, 적용 나중) — v6.1 동일 패턴 정합"},
    {"id": "r_7", "description": "phase-2 retrofit 중간 동시 존재 (MILESTONE.md + 개별 파일)", "mitigation": "D17 atomic commit 강제 (architecture P1 #3 흡수). detect_era 검사 순서 (flattened 우선, D6) deterministic 보장."},
    {"id": "r_8", "description": "smoke-spec-verification PROPOSE stage 8 flattened 분기 미명시", "mitigation": "D7 (a) 안 8 stage 분기 모두 flattened 정합 명시 (regression P2 #2 흡수)"}
  ]
}
```

### 코드베이스 grep 결과 정리

#### smoke 4종 영향 + cascade host 12건

| smoke | 현 era 분기 | v6.2+ flattened era 갱신 |
|---|---|---|
| smoke-spec-verification | 모든 milestone fp 존재 검증 (era 분기 부재) | MILESTONE.md 안 H2 섹션 grep 추가 (8 stage 모두) |
| smoke-scope-contract | detect_era + 9-stage/9-stage-bundled INTENT.md/APPROVE.md 검사 | flattened era 분기 추가 + h2_name 인자 |
| smoke-bundle-trigger | milestones_path regex (`^milestones/(_archive/)?v[0-9]+\.[0-9]+/milestones\.md$`) | era 양립 regex (`_archive/` prefix 보존) |
| smoke-open-stage-discipline | 디렉토리 명 + milestones.md 페어링 | era 양립 = (MILESTONE.md OR milestones.md) |

cascade narrative host 6건 (smoke 외) + smoke 4종 + post-report-write hook + posttooluse-hook smoke = 총 12 host (D9 host 표 본문 안 명시).

### Options 비교

| opt | 책임 분리 | 단일 source 보존 | 사용자 결정 정합 | 작업량 |
|---|---|---|---|---|
| (opt-A) era 분기 | 정합 | 정합 | 정합 | 12 host |
| (opt-B) glob 별 분기 | **위배** (era 단일 source 부정) | **위배** | 모호 | 4 smoke + 6 narrative |
| (opt-C) version hardcode | 정합 | 정합 | **위배** (3 (1) 신규만 의도 변질) | 4 smoke |

**추천 (채택)**: (opt-A) era 분기 — 사용자 결정 (3) (1) 신규만 정합 + era 단일 source 보존 + ARCHITECTURE § 6.1 forward-only 정책 일관.

### Risks 요약

8 위험 (r_1~r_8, D12~D17 mitigation 누적 후). 가장 큰 = r_1 (정보 손실, D12 통합 procedure) + r_2 (smoke 회귀, phase-1 controlled 비교 4-step) + r_7 (phase-2 atomic commit, D17).

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "(opt-A) era 분기 자연 확장 채택 — _era_detect.py 안 9-stage-flattened 신규 era 추가."},
    {"id": "D2", "decision": "MILESTONE.md schema = YAML frontmatter (milestone-level, 1건) + H2 9 섹션 (## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES). 각 H2 안 = `### Spec ` + ```json``` 축소 JSON 코드 블록 + Markdown body."},
    {"id": "D3", "decision": "YAML frontmatter **4 필드** (v6.1 5 필드 → v6.2 4 필드 reduction) = id (milestone-level slug) + title (active form, ≤60자) + version (v{X.Y}) + status (in_progress/completed). stage 필드 제거 — milestone-level 통합 표지 (H2 섹션 자체가 stage 표지). 5 관점 spec-drift P1 #1 흡수 (자기모순 정정)."},
    {"id": "D4", "decision": "execute/ 별책 보존 — execute/phase-{n}.md 별도 디렉토리 유지 (v6.1 형태 그대로). 본책 (MILESTONE.md) 안 ## EXECUTE 섹션 = phase 별 summary table + execute/phase-{n}.md cross-ref."},
    {"id": "D5", "decision": "## SUB_MILESTONES 섹션 = 기존 milestones.md 흡수. 구조 = `### Spec ` + ```json``` (`sub_milestones[]` array) + Markdown Notes (origin / trigger / scope 결정 / out_of_scope / 5요소 매핑 / 버전 bump / AI Native 시리즈 위치 등)."},
    {"id": "D6", "decision": "era 분기 — `tests/_era_detect.py` 안 9-stage-flattened 신규 분류 추가. 검사 순서 = 9-stage-flattened (디렉토리 명 `^v\\d+\\.\\d+$` + MILESTONE.md 존재) → 9-stage-bundled (디렉토리 명 + milestones.md) → 9-stage (INTENT+APPROVE+PROPOSE) → 7-stage → skip. 둘 동시 존재 케이스 = MILESTONE.md 우선 채택 (deterministic)."},
    {"id": "D7", "decision": "smoke 4종 변경 — (a) smoke-spec-verification.sh: H2 섹션 grep + JSON 추출 (8 stage 분기 모두 flattened 정합, regression P2 #2 흡수), (b) smoke-scope-contract.sh: detect_era + flattened 시 MILESTONE.md ## INTENT/## APPROVE 안 JSON 추출 (h2_name 인자), (c) smoke-bundle-trigger.sh: regex = `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` (regression P1 #1 흡수), (d) smoke-open-stage-discipline.sh: 디렉토리 명 + (MILESTONE.md OR milestones.md) 페어링."},
    {"id": "D8", "decision": "post-report-write hook 영향 = 부재 처리 + smoke-posttooluse-hook NOOP 경로 검증 행 추가. MILESTONE.md edit 시 hook trigger 부재 (단순함 우선, 사용자 manual PROPOSE 진행). tests/smoke-posttooluse-hook.sh NOOP 검증 Test W 추가 (architecture P1 #2). post-report-write 자동 era 분기는 후속 v6.x deferred (architecture P2 #1)."},
    {"id": "D9", "decision": "cascade 정전화 **12 host** (v3.21 narrative 정전화 3 단계 패턴 cycle 27) — ARCHITECTURE § 6.1 + CLAUDE.md (root + projects/meta + claude + tests) + harness-meta.md + _era_detect.py + smoke 4종 + smoke-posttooluse-hook + post-report-write hook narrative."},
    {"id": "D10", "decision": "2 phase 분할 — phase-1: 12 host 갱신 + schema 정전 정의 + smoke regression PASS 검증. phase-2: v6.2 자체 retrofit (개별 파일 4건 + milestones.md → MILESTONE.md 통합) + VERIFY/REPORT/PROPOSE H2 섹션 신규 작성 + execute/phase-{n}.md + ROADMAP milestones_path 갱신."},
    {"id": "D11", "decision": "도그푸드 sc_4 — phase-1 시점에 schema 정전 정의 → phase-2 시점에 v6.2 자체 retrofit (chicken-and-egg 회피 — schema 정의 먼저, 적용 나중). v6.1 동일 패턴."},
    {"id": "D12", "decision": "정보 손실 mitigation (r_1) — 통합 procedure 명시. (a) frontmatter 4 필드 보존 (stage 제거), (b) 각 stage 산출물 → 1 H2 섹션 1:1 매핑 (## Spec → ### Spec 강등), (c) ## 관련 1 통합 섹션, (d) milestones.md → ## SUB_MILESTONES."},
    {"id": "D13", "decision": "5 관점 검토 = subagent 병렬 호출. 결과: pass-with-comments × 4 + pass × 1 / decisive 0 / P1 11 + P2 9 모두 흡수."},
    {"id": "D14", "decision": "MILESTONE.md H2 9 섹션 = **8 stage + 1 listing 책임 명시 분리** (dictionary-semantics P1 #3). H2 8 stage = v2.0_workflow-word-fidelity 정전화 단어 = 단일 책임 1:1 매핑 보존. H2 +1 (## SUB_MILESTONES) = sub-milestone listing 별 책임."},
    {"id": "D15", "decision": "bundling 정책 v6.2+ era 보존 — ARCHITECTURE § 6.1 bundling 본질 = ## SUB_MILESTONES 섹션 흡수 (dictionary-semantics P1 #2). era 명명 분리 ≠ bundling 폐기."},
    {"id": "D16", "decision": "ext_2 context7 추정 후속 = DESIGN 즉시 정정 (spec-drift P1 #3, v5.7 spike 패턴 (c) 분기 채택). Anthropic patterns 안 '1 entity = 1 primary file' 정합 — MILESTONE.md 1 본책 + execute/ 별책 디렉토리."},
    {"id": "D17", "decision": "phase-2 retrofit atomic commit 강제 (architecture P1 #3 + regression P1 #2). git rm 5건 + git add MILESTONE.md = 단일 atomic commit. git rm 5건 N:1 매핑 = commit 메시지 안 source 5 파일 hash 인용 (R5 mitigation)."}
  ],
  "phases": [
    {"phase": 1, "name": "smoke 4종 era 분기 + cascade 12 host 정전화 + schema 정전 정의", "commit": "059206c", "execute": "execute/phase-1.md"},
    {"phase": 2, "name": "v6.2 자체 retrofit (개별 파일 + milestones.md → MILESTONE.md) + VERIFY/REPORT/PROPOSE H2 신규", "commit": "pending", "execute": "execute/phase-2.md"}
  ]
}
```

### Risk mitigation

| risk | severity | mitigation |
|---|---|---|
| r_1: 정보 손실 — phase-2 통합 H2 경계 misalignment | high | D12 통합 procedure (4 필드 frontmatter + 1:1 H2 매핑 + ## 관련 통합) |
| r_2: smoke 회귀 — era 분기 신규 logic | high | phase-1 controlled 비교 4-step (regression P2 #1) |
| r_3: CHANGELOG drift | low | Stage I PROPOSE 안 cross-ref 정합 + smoke-cross-ref.sh autofix |
| r_4: post-report-write hook 모호 | med | D8 hook trigger 부재 + smoke-posttooluse-hook NOOP 검증 |
| r_5: smoke-bundle-trigger regex anchor + `_archive/` | med | D7 (c) era 양립 + `_archive/` prefix 보존 (regression P1 #1) + commit 메시지 hash 인용 (regression P1 #2) |
| r_6: chicken-and-egg | low | D11 phase 순서 정합 |
| r_7: phase-2 중간 동시 존재 | med | D17 atomic commit (architecture P1 #3) + D6 검사 순서 deterministic |
| r_8: PROPOSE stage 8 flattened 분기 미명시 | low | D7 (a) 8 stage 분기 모두 정합 명시 (regression P2 #2) |

### 5 관점 검토 결과

| 관점 | verdict | 핵심 |
|---|---|---|
| architecture | pass-with-comments | cascade host 11→12 + smoke-posttooluse-hook NOOP + atomic commit 강제 |
| spec-drift | pass-with-comments | D3 자기모순 정정 + cb_4 regex hardcode + ext_2 DESIGN 즉시 정정 |
| regression | pass-with-comments | r_5 regex `_archive/` 보존 + git rm history 보존 + controlled 비교 4-step + PROPOSE stage 8 분기 |
| security | **pass** | 외부 입력 부재 + side effect 부재 + git history 보존. 보안 표면 변화 부재 |
| dictionary-semantics | pass-with-comments | '평탄화'/'하이브리드'/'본책+별책'/'MILESTONE.md 대문자'/title 4 원칙 = pass. ## SUB_MILESTONES = 8 stage + 1 listing 책임 분리 명시 |

**verdict**: pass-with-comments. **decisive 0건**. **P1 11건 + P2 9건 모두 흡수**.

### 신규 schema 명세 (MILESTONE.md)

#### 구조 (D2/D3/D12 정합)

본 MILESTONE.md 자체가 신규 schema 의 정전 적용 예. 구조:

- YAML frontmatter 4 필드 (id/title/version/status)
- H1 본문 제목 (`# v{X.Y} — <title>`)
- H2 9 섹션:
  - `## INTENT` (`### Spec` JSON + `### Motivation/Dependencies/Harness engineering mapping/명료화`)
  - `## RESEARCH` (`### Spec` JSON + 코드베이스 grep / Options / Risks)
  - `## DESIGN` (`### Spec` JSON + Risk mitigation / 5 관점 검토 / schema 명세 / era 분기 구현 / cascade host)
  - `## APPROVE` (`### Spec` JSON + 승인 narrative)
  - `## EXECUTE` (phase summary table + cross-ref)
  - `## VERIFY` (Stage G 진입 시 신규 작성)
  - `## REPORT` (Stage H 진입 시 신규 작성)
  - `## PROPOSE` (Stage I 진입 시 신규 작성)
  - `## SUB_MILESTONES` (`### Spec` JSON sub_milestones[] + `### Notes`)
- `## 관련` (통합 cross-ref)

### era 표지 (D6 정합)

- 디렉토리 명: `^v\d+\.\d+$` (밑줄 부재, v3.0+ bundled era 와 동일)
- 본책 파일: `MILESTONE.md` (대문자, milestone-level 통합)
- 별책 디렉토리: `execute/` (보존)
- 부재 파일: `milestones.md` (## SUB_MILESTONES 흡수)
- 부재 파일 5건: `INTENT.md` / `RESEARCH.md` / `DESIGN.md` / `APPROVE.md` (그 외 VERIFY/REPORT/PROPOSE 도 부재 — H2 섹션 흡수)

### era 분기 구현 (smoke + _era_detect.py, phase-1 commit 059206c)

`tests/_era_detect.py:detect_era()` 안 9-stage-flattened 신규 분류 첫 검사. smoke 4종 era 분기 추가. 자세히 = phase-1 execute 일지 ([`execute/phase-1.md`](execute/phase-1.md)).

### cascade host 정전화 (12 host, D9)

| # | host | 갱신 keyword |
|---|---|---|
| 1 | `projects/meta/ARCHITECTURE.md` § 6.1 | 표 5 row + flattened era paragraph 정전화 |
| 2 | `CLAUDE.md` (root) | v6.2+ flattened era + 4 필드 frontmatter |
| 3 | `projects/meta/CLAUDE.md` | MILESTONE.md 본책 + execute/ 별책 |
| 4 | `claude/CLAUDE.md` (P1 #1 신규) | PostToolUse MILESTONE.md NOOP + 진화 이력 |
| 5 | `tests/CLAUDE.md` | smoke 매트릭스 5 row era 분기 + posttooluse-hook Test W |
| 6 | `claude/commands/harness-meta.md` | Stage A OPEN MILESTONE.md ## SUB_MILESTONES 첫 작성 |
| 7 | `tests/_era_detect.py` | 9-stage-flattened 분류 + docstring |
| 8 | `tests/smoke-spec-verification.sh` | extract_h2 + flattened loop |
| 9 | `tests/smoke-scope-contract.sh` | era 분기 + h2_name 인자 |
| 10 | `tests/smoke-bundle-trigger.sh` | regex era 양립 + `_archive/` prefix |
| 11 | `tests/smoke-open-stage-discipline.sh` | 페어링 era 양립 |
| 12 | `tests/smoke-posttooluse-hook.sh` (Test W) + `claude/hooks/post-report-write.sh` (narrative + grep) | hook trigger 부재 (D8) |

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-19",
    "scope": "DESIGN 핵심 7건 + 5 관점 검토 종합 (decisive 0 / P1 11 + P2 9 모두 흡수) + 2-phase 구조. Stage F EXECUTE 진입."
  }
}
```

### 승인 narrative

사용자 명시 승인 (2026-05-19, "Stage F EXECUTE 진입 승인").

**승인 항목**: DESIGN.decisions D1~D17 + risk_mitigation r_1~r_8 + 5 관점 검토 결과 (pass-with-comments × 4 + pass × 1 / decisive 0 / P1 11 + P2 9 모두 흡수) + phases 2 (phase-1 + phase-2).

**EXECUTE 진입 게이트**:

- DESIGN 안 사용자 결정 7건 명시 → APPROVE 일괄 승인 (단어 결정 1:1 매핑 보존)
- 5 관점 검토 decisive 0건 = 구현 막는 결정적 이슈 부재
- v6.1 패턴 정합 (phase-1 도그푸드 + phase-2 광범위 적용)

## EXECUTE

| phase | name | commit | execute file |
|:-:|---|---|---|
| 1 | smoke 4종 era 분기 + cascade 12 host 정전화 + schema 정전 정의 | `059206c` | [`execute/phase-1.md`](execute/phase-1.md) |
| 2 | v6.2 자체 retrofit (개별 파일 + milestones.md → MILESTONE.md) + VERIFY/REPORT/PROPOSE H2 신규 | `171d4f4` | [`execute/phase-2.md`](execute/phase-2.md) |

## VERIFY

### Spec

```json
{
  "smoke_results": [
    {"smoke": "smoke-spec-verification", "result": "PASS", "metric": "PASS=254 FAIL=0 SKIP=47 — v6.2 flattened era 자동 식별 + H2 4 stage (INTENT/RESEARCH/DESIGN/APPROVE) PASS + 3 stage placeholder (VERIFY/REPORT/PROPOSE) skip (Stage G/H/I 진입 후 본 작업 완료 시 PASS 전환)"},
    {"smoke": "smoke-scope-contract", "result": "PASS", "metric": "PASS=60 FAIL=0 SKIP=2 — v6.2 flattened era 분기 (MILESTONE.md ## INTENT.out_of_scope + ## APPROVE.approval.approved_by='user') 정합"},
    {"smoke": "smoke-bundle-trigger", "result": "PASS", "metric": "v6.2 entry milestones_path = milestones/v6.2/MILESTONE.md#sub-milestones regex 통과 (anchor strip 후 실 파일 검증 정합)"},
    {"smoke": "smoke-open-stage-discipline", "result": "PASS", "metric": "bundled/flattened checked=30, historical skipped=1 (v6.2 + MILESTONE.md 페어링 인식)"},
    {"smoke": "pre-commit 14 hook", "result": "PASS", "metric": "14 hook 모두 통과 — markdownlint / shellcheck / smoke 7 + 기타 6"}
  ],
  "criteria_check": [
    {"id": "sc_1", "description": "MILESTONE.md schema 정전 정의 + ARCHITECTURE § 6.1 flattened era paragraph", "verdict": "PASS", "evidence": "ARCHITECTURE.md § 6.1 표 5 row + flattened era paragraph (phase-1 commit 059206c). 단일 source 정전화."},
    {"id": "sc_2", "description": "smoke 4종 era 분기 PASS — v3.0~v6.1 + v6.2~ 둘 다 회귀 0", "verdict": "PASS", "evidence": "smoke 4종 모두 PASS (PASS=254/60/1/1). v3.0~v6.1 28 active milestone 모두 bundled era 분류 유지 + v6.2 flattened era 분류 동시 PASS."},
    {"id": "sc_3", "description": "cascade host 12건 갱신", "verdict": "PASS", "evidence": "phase-1 commit 059206c 안 12 host 모두 갱신 — ARCHITECTURE/CLAUDE.md root/projects/meta/claude/tests + harness-meta.md + _era_detect.py + smoke 4종 + posttooluse-hook + post-report-write."},
    {"id": "sc_4", "description": "v6.2 자체 도그푸드 retrofit", "verdict": "PASS", "evidence": "phase-2 commit 171d4f4 안 git rm 5건 + MILESTONE.md 단일 통합 + execute/phase-2.md. 본 ## VERIFY 섹션 작성 = 자체 도그푸드 cycle 완성 (Stage G H I MILESTONE.md 안 누적)."},
    {"id": "sc_5", "description": "pre-commit 14 hook PASS, 회귀 0 (phase-1 + phase-2 각 commit 별)", "verdict": "PASS", "evidence": "phase-1 commit (059206c) + phase-2 commit (171d4f4) 모두 pre-commit 14 hook PASS. 회귀 0."}
  ],
  "verdict": "pass-with-comments"
}
```

### verdict 종합

**pass-with-comments** — decisive 0건. 5 success_criteria 모두 PASS. P1 11건 + P2 9건 (DESIGN 안 흡수 완료) 회귀 없음. v6.2 자체가 9-stage-flattened era 첫 적용 milestone (도그푸드 cycle 27 narrative 정전화 3 단계 패턴 완성).

phase-2 retrofit 도중 발견된 부수 정정 (in-execute):

1. RESEARCH.md JSON 필드명 (`external_sources/codebase_findings` → `external/codebase`) — v6.1 schema 정합 정정
2. DESIGN.md schema 명세 외부 fence ` ```text ` → ` ````text ` (4 백틱 wrap, nested ```json``` 정합)
3. DESIGN.md table column count fix (regex 안 `|` → `\|` escape)
4. smoke-bundle-trigger.sh anchor strip 로직 추가 (실 파일 검사 시 `#sub-milestones` 제거)
5. MILESTONE.md 안 bullet 안 `## INTENT` 등 → 백틱 inline code escape (markdownlint MD022 회피)

모두 의도 변경 안 함 — schema/regex 정합 + lint 정합 보강만.

## REPORT

### Spec

```json
{
  "summary": "v6.2 milestone-artifact-directory-flattening 완료 — AI Native 운영 § 7.1 컨텍스트 효율 면 두 번째 실 적용 (cycle 2, v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화). 1 milestone 디렉토리 = MILESTONE.md 본책 (H2 9 섹션) + execute/phase-{n}.md 별책 (b) 하이브리드 채택. (1) v6.2~ 신규만 적용 — v3.0~v6.1 디렉토리 era 보존 (era 분기 자연 확장, forward-only 정책 정합). v6.2 자체가 9-stage-flattened era 첫 적용 milestone (도그푸드 sc_4 충족). pre-PLAN 6 round 결정 → 5 관점 검토 (subagent 병렬, decisive 0 / P1 11 + P2 9 모두 흡수) → 2-phase 분할 (phase-1 smoke 4종 + cascade 12 host + schema 정전 정의 / phase-2 v6.2 자체 retrofit atomic commit).",
  "delta": {
    "phase_1_commit": "059206c",
    "phase_2_commit": "171d4f4",
    "files_changed": 29,
    "loc_delta": "+1309 / -615 = net +694",
    "cascade_host_count": 12,
    "smoke_4종_pass_count": "PASS=254+60+1+1, FAIL=0",
    "pre_commit_14_hook": "PASS",
    "v3_21_narrative_canonicalization_cycle": 27,
    "ai_native_컨텍스트_효율_cycle": 2
  },
  "lessons_learned": [
    {"id": "L1", "lesson": "에라 분기 검사 순서 우선 — 신규 era 도입 시 표지 검사를 검사 순서 첫 번째로 두면 phase-2 retrofit 일시 동시 존재 케이스 (MILESTONE.md + milestones.md 둘 다 존재) deterministic 보장. _era_detect.py:detect_era() 안 9-stage-flattened 첫 검사 채택 (D6) — v6.1 schema 변경 (파일 안 schema) 보다 큰 단계 (파일 구조 변경) 도 안전 통과."},
    {"id": "L2", "lesson": "atomic commit 강제 — N:1 매핑 retrofit (git rm 5건 + git add 1건 = 단일 통합) 은 git mv 직접 불가. commit 메시지 안 source 파일 phase-1 hash 인용 narrative 정전화 = git history 추적 보존 mitigation. architecture P1 #3 + regression P1 #2 cross-cover 패턴 — phase 책임 분리 (phase-1 schema 정전 + phase-2 자체 retrofit) 시 source 파일 phase-1 add → phase-2 retrofit 동일 milestone 안 cycle 완성."},
    {"id": "L3", "lesson": "subagent 병렬 5 관점 검토 = inline self-review 보다 강 — v6.1 = inline self-review (decisive 0 / P1 5 + P2 1). v6.2 = subagent 병렬 5 관점 (decisive 0 / P1 11 + P2 9). 동일 규모 milestone 안 P1+P2 누적 5→11+9 = 2.4배 증가 — 객관적 검토자 = 발견 issue 더 많음. 토큰 비용 trade-off 정당."},
    {"id": "L4", "lesson": "spec-drift spike 패턴 (v5.7 정전화) 외 (c) DESIGN 즉시 정정 분기 = phase-1 spike 부재 시 자연 대안. ext_2 context7 추정 표지 → D16 DESIGN 즉시 정정 (`1 entity = 1 primary file` 정합 명시). v4.2 (Stage F 전 cycle) + v5.6 (Stage F 안 cycle) + v6.2 (DESIGN 즉시 정정) = 세 가지 자연 분기 누적, ARCHITECTURE § 6 끝 spec-drift spike paragraph (v5.7 정전화) 안 (c) 분기 narrative 보강 후보."},
    {"id": "L5", "lesson": "markdownlint nested ```json``` 안 외부 ```text``` blocks 처리 = 4 백틱 ````text wrap 정합. CommonMark spec 안 fenced code block 시작 백틱 수와 동일 또는 더 많은 백틱으로 닫음. 3 백틱 외부 + 3 백틱 내부 = parser 가 first 내부 ``` 으로 외부 닫힘 인식. v6.2 DESIGN.md schema 명세 외부 ```` 4 백틱 wrap = 표준 정합."},
    {"id": "L6", "lesson": "phase-2 retrofit 시 source 파일 (INTENT/RESEARCH/DESIGN/APPROVE.md) 안 H2 → H3 강등 + 모든 ## H2 → ### H3 매핑 = D12 (b) 정합. 단 source 파일 명료화 안 ### H3 sub-headings → #### H4 강등도 자연 cascade (예: INTENT.md `### 본 milestone 의 위치` → MILESTONE.md `## INTENT` 안 `### 명료화` 안 `#### 본 milestone 의 위치`). markdown 표준 정합 + 정보 손실 0."},
    {"id": "L7", "lesson": "milestones_path anchor (`#sub-milestones`) 처리 = smoke-bundle-trigger 안 anchor strip 후 실 파일 검사. v6.2 D7 (c) regex 안 anchor 허용 + 안 D7 c 안 anchor 부재 처리는 in-execute 발견 (regex 통과 vs 실 파일 검사 mismatch). 본 케이스가 RESEARCH 단계에서 식별 안 됨 — DESIGN 단계 spec-drift agent 도 식별 못 함 (regex 안 anchor 패턴만 보고 실 파일 검사 logic 검토 안 함). 후속: spec-drift 검토 시 'regex + 실 사용 함께 검증' 보강 권고."}
  ]
}
```

### Lessons 7건 narrative

- **L1 era 분기 검사 순서**: 단순 단일 코드 변경이지만 forward-only 정책 핵심 보장 — v6.1 (파일 안 schema) 보다 큰 단계 (파일 구조) 도 deterministic 처리.
- **L2 atomic commit + hash 인용**: N:1 retrofit 패턴 정전화 — 후속 milestone 안 큰 schema migration 시 동일 패턴 활용 가능 (regression P1 #2 mitigation 본 직접 evidence).
- **L3 subagent 병렬 vs inline**: 5 관점 검토 방식 결정 trade-off — v6.x 후속 milestone 결정 reference.
- **L4 spec-drift 분기 확장**: v5.7 정전화 패턴 (a)(b)(c)(d) 안 (c) Stage F 안 cycle / DESIGN 즉시 정정 두 분기 자연 발현 — narrative 보강 후보 (v6.x).
- **L5 markdownlint nested fence**: 표준 정합 + 향후 유사 케이스 (외부 ```text``` 안 내부 ```json``` etc) 동일 패턴 적용.
- **L6 H2 강등 cascade**: D12 (b) 정합 + H3 → H4 자연 cascade — 정보 손실 0.
- **L7 regex vs 실 사용 mismatch**: spec-drift 검토 보강 권고 후속.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "post-report-write-hook-flattened-era-trigger",
      "title": "post-report-write hook 자동 flattened era 분기 (MILESTONE.md ## REPORT 섹션 검출)",
      "trigger": "B_byproduct",
      "origin_milestone": "v6.2",
      "target_version": "v6.x",
      "description": "v6.2 D8 결정 = hook trigger 부재 (단순함 우선, 사용자 manual PROPOSE). architecture P2 #1 deferred 등재. MILESTONE.md edit 시 ## REPORT 섹션 신규 출현 자동 검출 logic = Edit/Write hook 안 diff 분석. 토큰 비용 vs 자동화 trade-off DESIGN 단계 안 결정."
    },
    {
      "id": "spec-drift-spike-pattern-c-design-immediate-narrative",
      "title": "spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 narrative 보강",
      "trigger": "D_design",
      "origin_milestone": "v6.2",
      "target_version": "v6.x",
      "description": "L4 origin — v6.2 D16 (ext_2 DESIGN 즉시 정정) = v5.7 정전화 패턴 (c) 분기 세 번째 자연 발현 사례. ARCHITECTURE § 6 끝 spec-drift spike paragraph 안 (c) 분기 narrative 보강 — DESIGN 즉시 정정 vs Stage F spike 두 분기 명료 명시."
    },
    {
      "id": "spec-drift-review-regex-vs-실-사용-mismatch-guideline",
      "title": "spec-drift 검토 'regex + 실 사용 함께 검증' 가이드라인",
      "trigger": "B_regression",
      "origin_milestone": "v6.2",
      "target_version": "v6.x",
      "description": "L7 origin — v6.2 phase-2 안 milestones_path anchor (`#sub-milestones`) 처리 mismatch (regex 통과 vs 실 파일 검사) 가 RESEARCH/DESIGN 단계 식별 안 됨. 후속: spec-drift agent prompt 안 'regex pattern + 실 사용 logic 함께 검토' 가이드라인 명시."
    }
  ]
}
```

### next_candidates 흡수 narrative

- **#1 post-report-write hook 자동 era 분기** (D8 deferred 등재, architecture P2 #1): 단순함 vs 자동화 trade-off — 후속 milestone 안 결정.
- **#2 spec-drift 패턴 (c) narrative 보강** (L4 origin): ARCHITECTURE 정전화 cascade — 향후 spec-drift cycle 통합 narrative.
- **#3 spec-drift 검토 가이드라인** (L7 origin): subagent prompt 명시 보강 — regex + 실 사용 함께 검토 의무 명시.

### ROADMAP cascade

본 milestone 완료 → v6.2 entry status `in_progress → completed`. archival cycle (v5.21+ schema A2 recent 3 정합) — v5.21 entry → CHANGELOG.md archival (별 commit). 신규 next_candidates 3건 (위 #1~#3) → ROADMAP `next_candidates[]` 등재.

CHANGELOG.md `[v6.2]` entry 추가 — Keep a Changelog v1.1.0 정합.

## SUB_MILESTONES

### Spec

```json
{
  "version": "v6.2",
  "title": "milestone 산출물 디렉토리 평탄화 (단일 파일 통합)",
  "status": "in_progress",
  "trigger": "B_byproduct",
  "sub_milestones": [
    {
      "id": "phase-1-smoke-update-and-cascade",
      "title": "smoke 4종 era 분기 갱신 + cascade 12 host 정전화 + schema 정전 정의",
      "status": "complete",
      "phase": 1,
      "commit": "059206c"
    },
    {
      "id": "phase-2-v6_2-self-retrofit-and-dogfood",
      "title": "v6.2 자체 도그푸드 retrofit (개별 파일 → MILESTONE.md 통합)",
      "status": "complete",
      "phase": 2,
      "commit": "171d4f4"
    }
  ]
}
```

### Notes

- **origin**: v6.1 PROPOSE#1 (`milestone-artifact-directory-flattening`) + ROADMAP next_candidates (target_version v6.2)
- **trigger**: B_byproduct (v6.1 진행 중 자연 식별 — AI Native 시리즈 컨텍스트 효율 면 두 번째 후속)
- **scope 결정 (pre-PLAN round 6건)**:
  - (1) scope = 디렉토리 평탄화 단독 (entry-title smoke `entry-title-guideline-smoke-verification` 은 v6.3 별 milestone 으로 분리)
  - (2) 형태 = (b) 하이브리드 — `MILESTONE.md` 본책 (## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES) + `execute/phase-{n}.md` 별책
  - (3) 적용 범위 = (1) v6.2~ 신규만 (v3.0~v6.1 디렉토리 era 보존, `_archive/` 40 건 + active 28 건 모두 면제). era 분기 자연 확장.
  - (4) 파일명 = `MILESTONE.md` (대문자, ARCHITECTURE.md / ROADMAP.md / CHANGELOG.md / INTENT.md / ... 정합)
  - (5) sub-milestones = (a) `## SUB_MILESTONES` 섹션 흡수 (별도 `milestones.md` 파일 부재, v6.2~ era).
  - (6) phase = (2) 2-phase (phase-1 smoke + cascade + schema 정전 정의 / phase-2 v6.2 자체 retrofit + 도그푸드).
- **out_of_scope**:
  - backfill (v3.0~v6.1 28 active milestone 디렉토리 era 보존)
  - entry-title-guideline-smoke-verification (v6.3 별 milestone)
  - cascade-auto-sync-mechanism (v6.4)
- **5요소 매핑**: Context (컨텍스트 효율) — § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref 갱신 (v6.1 첫 갱신 + v6.2 두 번째)
- **버전 bump**: v6.2 minor (additive — era 분기 신규 추가, v3.0~v6.1 기존 era 보존 = breaking 없음)
- **AI Native 시리즈 위치**: 컨텍스트 효율 면 두 번째 적용 milestone (v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화)
- **도그푸드 retrofit**: Stage A~E 산출물은 v6.1 era 동치로 개별 파일 (INTENT/RESEARCH/DESIGN/APPROVE.md) 작성 후 phase-2 안 MILESTONE.md 단일 파일 통합 = 본 MILESTONE.md 자체.

## 관련

- 1차 source: 2026-05-19 pre-PLAN round 6 (사용자 답 6건 직접 인용)
- origin: [`../v6.1/MILESTONE.md`](../v6.1/MILESTONE.md) (v6.1 PROPOSE#1, bundled era 본책 = milestones.md 동치) + [`../../ROADMAP.md`](../../ROADMAP.md)
- 강제 schema source: [`../../../../tests/smoke-spec-verification.sh`](../../../../tests/smoke-spec-verification.sh)
- AI Native 정의: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 7
- 5요소 매트릭스: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.3 Context 행
- era 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- era 분류 source: [`../../../../tests/_era_detect.py`](../../../../tests/_era_detect.py)
- v6.1 schema source: v6.1 (bundled era) — 별파일 INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md
- phase-1 execute 일지: [`execute/phase-1.md`](execute/phase-1.md)
- phase-2 execute 일지: [`execute/phase-2.md`](execute/phase-2.md)
- memory: `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` + `feedback_token_efficiency_priority` + `feedback_anthropic_yaml_frontmatter_pattern`

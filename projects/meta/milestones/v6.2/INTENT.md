---
id: milestone-artifact-directory-flattening
title: milestone 산출물 디렉토리 평탄화 (단일 파일 통합)
version: v6.2
stage: INTENT
status: in_progress
---

# INTENT — v6.2

## Spec

```json
{
  "goal": "milestone 산출물 디렉토리 구조 평탄화 — (b) 하이브리드 채택 — 1 milestone 디렉토리 = MILESTONE.md 본책 (## INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE/SUB_MILESTONES H2 9 섹션) + execute/phase-{n}.md 별책. AI 1 Read 으로 milestone 전체 흡수. (1) v6.2~ 신규만 적용, v3.0~v6.1 디렉토리 era 보존 (era 분기 자연 확장). AI Native 운영 § 7.1 컨텍스트 효율 면 두 번째 실 적용.",
  "success_criteria": [
    {"id": "sc_1", "description": "MILESTONE.md schema 정전 정의 — YAML frontmatter 5 필드 + 축소 JSON + H2 9 섹션 + execute/ 별책. ARCHITECTURE § 6.1 era 정책 안 v6.2+ flattened era paragraph 정전화 (단일 source)."},
    {"id": "sc_2", "description": "smoke 4종 (spec-verification + scope-contract + bundle-trigger + open-stage-discipline) era 분기 PASS — v3.0~v6.1 디렉토리 era + v6.2~ 단일 파일 era 둘 다 정확 검출 (회귀 0)."},
    {"id": "sc_3", "description": "cascade host N건 갱신 (RESEARCH 후 확정, 추정 8건 ±) — ARCHITECTURE / CLAUDE.md (root + projects/meta) / tests/CLAUDE.md / claude/commands/harness-meta.md / 후크 등."},
    {"id": "sc_4", "description": "v6.2 자체 도그푸드 retrofit (phase-2) — 개별 파일 4건 (INTENT/RESEARCH/DESIGN/APPROVE.md) + milestones.md → MILESTONE.md 단일 통합. VERIFY/REPORT/PROPOSE 는 통합 후 H2 섹션 누적."},
    {"id": "sc_5", "description": "pre-commit 14 hook 모두 PASS, 회귀 0 (phase-1 + phase-2 각 commit 별)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "v3.0~v6.1 28 active milestone backfill", "reason": "(1) 신규만 결정 (pre-PLAN round 3). 정보 손실 위험 회피 + era 분기 자연 확장."},
    {"id": "oos_2", "item": "_archive 40 건 (v1.0~v3.21)", "reason": "역사적 보존 의도 (v4.0 phase-2 분리 정합)."},
    {"id": "oos_3", "item": "entry-title-guideline-smoke-verification", "reason": "v6.3 별 milestone (bundling 안 함 결정, pre-PLAN round 1)."},
    {"id": "oos_4", "item": "AI Native 시리즈 후속 (cascade 자동 동기 v6.4 / 자율 발의 v6.5 / hallucination 자동 정정 v6.6)", "reason": "별 milestone 예약."},
    {"id": "oos_5", "item": "post-report-write hook 자동 era 분기 검출", "reason": "phase-1 안 수동 갱신만 (단일 파일 era trigger 점 = MILESTONE.md 안 ## REPORT 섹션 추가, hook 안 분기 로직 최소화)."}
  ]
}
```

## Motivation

v6.1 PROPOSE#1 origin (`milestone-artifact-directory-flattening`, target_version v6.2). AI Native 운영 § 7.1 컨텍스트 효율 면 **두 번째 실 적용 milestone** (v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화).

현 milestone 디렉토리 구조 = 6~8 파일 흩어짐 (`INTENT.md` + `RESEARCH.md` + `DESIGN.md` + `APPROVE.md` + `VERIFY.md` + `REPORT.md` + `PROPOSE.md` + `milestones.md` + `execute/phase-{n}.md`). AI 가 1 milestone 전체 흡수 시 multi-Read 필요 (8 file × 평균 200 LOC ≈ 1600 LOC 분산). 단일 파일 통합 = 1 Read.

pre-PLAN 6 round 누적 결정 (2026-05-19):

1. **scope** — 디렉토리 평탄화 단독 (entry-title smoke 는 v6.3 별 milestone)
2. **형태** — (b) 하이브리드 (MILESTONE.md 본책 + execute/phase-{n}.md 별책)
3. **적용 범위** — (1) v6.2~ 신규만 (v3.0~v6.1 디렉토리 era 보존)
4. **파일명** — `MILESTONE.md` (대문자, repo docs 정합)
5. **sub-milestones** — (a) `## SUB_MILESTONES` 섹션 흡수 (별도 `milestones.md` 부재)
6. **phase** — (2) 2-phase (phase-1 smoke+cascade / phase-2 v6.2 자체 retrofit)

## Dependencies

- **dep_1**: pre-PLAN dialog 6 round (2026-05-19) — 사용자 결정 source
- **dep_2**: v6.1 PROPOSE#1 (`milestone-artifact-directory-flattening`) + ROADMAP next_candidates — origin
- **dep_3**: v6.1 hybrid schema (YAML frontmatter + 축소 JSON + Markdown body) — 단일 파일 안 H2 섹션 마다 동일 schema 적용
- **dep_4**: ARCHITECTURE § 6.1 era 정책 — v6.2+ flattened era paragraph 신규 추가
- **dep_5**: smoke 4종 위치 grep (Stage C RESEARCH 안 식별) — `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` + `tests/smoke-bundle-trigger.sh` + `tests/smoke-open-stage-discipline.sh`
- **dep_6**: cascade host 식별 (Stage C RESEARCH 안 식별, 추정 8건 ±)
- **dep_7**: memory `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` + `feedback_token_efficiency_priority` — 작업 톤 가이드

## Harness engineering mapping

- **element**: Context (1차)
- **target**: (b) mechanism cross-ref 갱신 — § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref **두 번째 갱신** (디렉토리 구조 효율). v6.1 첫 갱신 (JSON 필드 schema 효율) + v6.2 두 번째 (디렉토리 구조 효율).
- **rationale**: AI Native 운영 § 7.1 3 면 안 '컨텍스트 효율' 면 두 번째 실 적용. v6.0 정의 → v6.1 JSON 필드 (파일 안 schema 변경) → v6.2 디렉토리 평탄화 (**파일 구조 변경**, 더 큰 단계).

## 명료화

### 본 milestone 의 위치 — AI Native 시리즈 v6.2

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

### v6.1 vs v6.2 차이 — 파일 안 schema vs 파일 구조

- **v6.1** = 각 산출물 파일 안 schema 변경 (JSON top 32→14 등). 파일 자체는 그대로 (INTENT.md / RESEARCH.md / ... 분리 유지).
- **v6.2** = 파일 자체를 합침 (`INTENT.md + RESEARCH.md + ... → MILESTONE.md`). 디렉토리 구조 자체 변경 = **더 큰 단계**. 정보 손실 위험 (sc_5 회귀 0 가드).

### 도그푸드 retrofit 시점 (sc_4)

본 milestone Stage A~E 산출물은 v6.1 era 동치로 개별 파일 작성 (INTENT/RESEARCH/DESIGN/APPROVE.md). Stage F phase-2 안 MILESTONE.md 단일 통합 retrofit. VERIFY/REPORT/PROPOSE 는 통합 후 H2 섹션 신규 작성. 본 INTENT.md 도 phase-2 retrofit 대상.

v3.21 narrative 정전화 3 단계 패턴 cycle 27.

### era 분기 정책 (sc_2)

| Era | 디렉토리 구조 | 적용 milestone |
|---|---|---|
| v1.0~v1.4 | 7-stage flat (`PLAN/RESEARCH/DESIGN/VERIFY/REPORT.md` + execute/) | _archive |
| v2.0~v2.1 | 9-stage flat (`INTENT/RESEARCH/.../PROPOSE.md` + execute/, `milestones/v{X.Y}_{slug}/`) | _archive |
| v3.0~v6.1 | 9-stage-bundled (`INTENT/RESEARCH/.../PROPOSE.md` + `milestones.md` + execute/, `milestones/v{X.Y}/`) | _archive + active 28 |
| **v6.2+** | **9-stage-flattened** (`MILESTONE.md` 단일 + execute/, `milestones/v{X.Y}/`) | **v6.2~ 신규** |

smoke 4종 = era 분기 + version 비교 로직 추가.

## 관련

- 1차 source: 2026-05-19 pre-PLAN round 6 (사용자 답 6건 직접 인용)
- origin: [`../v6.1/PROPOSE.md`](../v6.1/PROPOSE.md) #1 + [`../../ROADMAP.md`](../../ROADMAP.md)
- 강제 schema source: [`../../../../tests/smoke-spec-verification.sh`](../../../../tests/smoke-spec-verification.sh)
- AI Native 정의: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 7
- 5요소 매트릭스: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.3 Context 행
- era 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- memory: `feedback_iterative_dialog` + `user_non_developer_role` + `feedback_iterative_pre_plan_review` + `feedback_token_efficiency_priority` + `feedback_anthropic_yaml_frontmatter_pattern`
- milestones.md: [`milestones.md`](milestones.md)

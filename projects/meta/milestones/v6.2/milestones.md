# v6.2 — sub-milestone listing

## Spec

```json
{
  "version": "v6.2",
  "title": "milestone 산출물 디렉토리 평탄화 (단일 파일 통합)",
  "status": "in_progress",
  "trigger": "B_byproduct",
  "sub_milestones": [
    {
      "id": "phase-1-smoke-update-and-cascade",
      "title": "smoke 4종 era 분기 갱신 + cascade host 정전화 + schema 정전 정의",
      "status": "pending",
      "phase": 1,
      "commit": null
    },
    {
      "id": "phase-2-v6_2-self-retrofit-and-dogfood",
      "title": "v6.2 자체 도그푸드 retrofit (개별 파일 → MILESTONE.md 통합)",
      "status": "pending",
      "phase": 2,
      "commit": null
    }
  ]
}
```

## sub-milestone listing

(Stage A OPEN skeleton. Stage D DESIGN 안 phase 분해 확정 후 갱신.)

## Notes

- **origin**: v6.1 PROPOSE#1 (`milestone-artifact-directory-flattening`) + ROADMAP next_candidates (target_version v6.2)
- **trigger**: B_byproduct (v6.1 진행 중 자연 식별 — AI Native 시리즈 컨텍스트 효율 면 두 번째 후속)
- **scope 결정 (pre-PLAN round 6건)**:
  - (1) scope = 디렉토리 평탄화 단독 (entry-title smoke `entry-title-guideline-smoke-verification` 은 v6.3 별 milestone 으로 분리)
  - (2) 형태 = (b) 하이브리드 — `MILESTONE.md` 본책 (## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES) + `execute/phase-{n}.md` 별책 (실 구현 일지 분리, 동시 편집 가능)
  - (3) 적용 범위 = (1) v6.2~ 신규만 (v3.0~v6.1 디렉토리 era 보존, `_archive/` 40 건 + active 28 건 모두 면제). era 분기 자연 확장.
  - (4) 파일명 = `MILESTONE.md` (대문자, ARCHITECTURE.md / ROADMAP.md / CHANGELOG.md / INTENT.md / ... 정합)
  - (5) sub-milestones = (a) `MILESTONE.md` 안 `## SUB_MILESTONES` 섹션 흡수 (단/복수 구별 — `MILESTONE.md` 본체 / `## SUB_MILESTONES` listing). 별도 `milestones.md` 파일 부재 (v6.2~ era).
  - (6) phase = (2) 2-phase (phase-1 smoke + cascade + schema 정전 정의 / phase-2 v6.2 자체 retrofit + 도그푸드). smoke era 분기 위험 격리.
- **out_of_scope**:
  - backfill (v3.0~v6.1 28 active milestone 디렉토리 era 보존 = (1) 신규만 결정)
  - entry-title-guideline-smoke-verification (v6.3 별 milestone)
  - cascade-auto-sync-mechanism (v6.4)
- **5요소 매핑**: Context (컨텍스트 효율) — § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref 갱신 예정 (v6.1 첫 갱신 + v6.2 두 번째)
- **버전 bump**: v6.2 minor (additive — era 분기 신규 추가, v3.0~v6.1 기존 era 보존 = breaking 없음)
- **AI Native 시리즈 위치**: 컨텍스트 효율 면 두 번째 적용 milestone (v6.0 = 정의 + entry title 가이드 / v6.1 = JSON 필드 감축 / v6.2 = 디렉토리 평탄화 / v6.3 예약 = entry-title smoke / v6.4 예약 = cascade-auto-sync / v6.5 예약 = autonomous proposal / v6.6 예약 = hallucination auto-correction / v7.0 시리즈 통합)
- **도그푸드 retrofit**: Stage A~E 산출물은 v6.1 era 동치로 개별 파일 (INTENT.md / RESEARCH.md / DESIGN.md / APPROVE.md) 작성, Stage F phase-2 안 MILESTONE.md 단일 파일 통합 (V/H/I 는 통합 후 H2 섹션 누적). 이 milestones.md 파일 자체도 phase-2 안 ## SUB_MILESTONES 섹션 흡수 후 삭제.

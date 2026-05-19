# v6.1 — sub-milestone listing

## Spec

```json
{
  "version": "v6.1",
  "title": "milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)",
  "status": "in_progress",
  "trigger": "B_byproduct",
  "sub_milestones": [
    {
      "id": "phase-1-smoke-update-and-self-dogfood",
      "title": "smoke 갱신 + v6.1 자체 4건 도그푸드",
      "status": "complete",
      "phase": 1,
      "commit": "TBD"
    },
    {
      "id": "phase-2-mechanical-backfill-and-cascade",
      "title": "28 milestone backfill + cascade 6 host 정전화",
      "status": "pending",
      "phase": 2,
      "commit": null
    }
  ]
}
```

## sub-milestone listing

(RESEARCH 결과 후 사용자 결정 게이트 통과 시 DESIGN 안에서 phase 분해. 본 milestones.md = OPEN 시점 skeleton.)

## Notes

- **origin**: v6.0 INTENT.oos_2 + ROADMAP next_candidates#1 (`milestone-artifact-json-field-reduction`, target_version v6.1)
- **trigger**: B_byproduct (v6.0 진행 중 자연 식별 — AI Native 시리즈 컨텍스트 효율 면 첫 후속)
- **scope 결정 (pre-PLAN round 5건)**:
  - 감축 기준 = 자연어 단락 흡수 (1차 사용자 답) → 후 "접근 자체 재검토" 로 확장 (RESEARCH 안 외부 source 확인 후 다시 제안)
  - 적용 범위 = active 27 meta + upbit 1 = 28 milestone backfill (`_archive/` 40 건 제외, 역사적 보존)
  - 디렉토리 평탄화 = **v6.2 별 milestone** 으로 분리 (본 milestone out_of_scope)
- **5요소 매핑**: Context (컨텍스트 효율) — § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref 갱신 예정
- **버전 bump**: v6.1 minor (additive — 기존 schema 강제 필드 부분집합 유지 + 자연어 흡수 추가, breaking 없음)
- **AI Native 시리즈 위치**: 컨텍스트 효율 면 첫 적용 milestone (v6.0 = 정의 + entry title 가이드, v6.1 = JSON 필드, v6.2 예약 = 디렉토리 평탄화)

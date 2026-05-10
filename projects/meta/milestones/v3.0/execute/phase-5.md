# phase-5 — milestones.md 신규 작성 + spec picture-frame

```json
{
  "phase": 5,
  "status": "completed",
  "title": "milestones/v3.0/milestones.md 신규 — sub-milestone listing per version + spec picture-frame",
  "scope": [
    "milestones/v3.0/milestones.md 신규 (D5/D17 picture-frame)",
    "spec 섹션 — 신 schema 정식 키 매핑 (spec_version, milestone_id, sub_milestones[] 구조)",
    "instance 섹션 — v3.0_milestones-restructure 의 sub_milestones[] 8건 (phase 1-8 매핑, dependencies + absorbed_from)",
    "흡수 추적성 표 (v2.2_* 4건 → phase 2/6/7/8)",
    "의존 그래프 (critical path + 병렬 가능 phase)"
  ],
  "rationale": "spec-drift 권고 #2 (picture-frame, D5) — 신 schema 의 정식 키 매핑을 본 파일 상단에 박음. R7 (정보 손실 방지, D14 dependencies.absorbed_from) — sub-milestone entry 마다 absorbed_from 필드 + 흡수 추적성 표. 자기참조 부합 (D7) — v3.0 자체가 milestones.md 신 구조 첫 적용 사례.",
  "decisions_referenced": ["D5 (milestones.md 내용)", "D7 (자기참조 부합)", "D10 (9-stage-bundled era 표지)", "D14 (commit ref + dependencies.absorbed_from)", "D17 (picture-frame)"],
  "side_effect": "v3.0 milestone 의 era 분류 변환 — milestones.md 작성 후 detect_era 결과 = '9-stage-bundled' (디렉토리 명 ^v\\d+\\.\\d+$ + milestones.md 존재 동시 충족, D10). 7-stage fallback (transient state) 종료 → smoke-scope-contract Stage 1+2 가 v3.0 INTENT.md / APPROVE.md 검증 활성화 (R2 mitigation 완성).",
  "verification": {
    "smoke_spec_verification": "PASS (Stage 1-9 모두 동치)",
    "smoke_scope_contract": "PASS (v3.0 = 9-stage-bundled era 분류 → INTENT.out_of_scope + APPROVE.approval 검증 활성화)",
    "smoke_cross_ref": "PASS (milestones.md cross-ref 정합)",
    "milestones_md_smoke_match_excluded": "post-report-write.sh hook NOOP (D16, phase-1 갱신)"
  }
}
```

## 작업 내용

1. **milestones/v3.0/milestones.md 신규**:
   - 상단 narrative + 정전 cross-ref (ARCHITECTURE.md § 6.1)
   - **Spec** 섹션 — JSON 코드블록 (spec_version / fields / sub_milestone_fields)
   - **Instance** 섹션 — JSON 코드블록 (v3.0_milestones-restructure 의 sub_milestones[] 8건)
   - **흡수 추적성 표** — 4 v2.2_* → phase 2/6/7/8
   - **의존 그래프** — text-art (critical path)

2. **side effect — v3.0 era 분류 변환**:
   - milestones.md 작성 후 v3.0 = 9-stage-bundled era (D10 표지 동시 충족)
   - smoke-scope-contract Stage 2 가 v3.0 의 APPROVE.md 검증 활성화 (era_in 9-stage-bundled, in_check D9 갱신)
   - APPROVE.md 의 approval.approved_by="user" + date="2026-05-10" 확인 (Stage E 사용자 명시 승인)

## execution_notes

- spec picture-frame: 신 schema 정식 키 매핑 박음. 향후 9-stage-bundled era 신규 milestone 작성 시 본 spec reference
- sub_milestones[] 8건 dependencies = phase 번호 list (within version) — critical path 명확
- absorbed_from 필드 = 정보 추적성 (R7 mitigation) — phase-2/6/7/8 에 명시
- v3.0 era 분류 transition state 종료 — phase-1 ~ phase-4 에는 7-stage fallback (transient cost), phase-5 commit 후 9-stage-bundled 정착

## commit

```
feat(meta): v3.0 phase-5 — milestones.md (sub-milestone listing per version)
```

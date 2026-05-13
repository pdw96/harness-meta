# phase-4 — ROADMAP schema 변경 (version + id 분리) + v2.2_* 4건 entry 제거

```json
{
  "phase": 4,
  "status": "completed",
  "title": "ROADMAP `milestones[]` schema 신 형식 적용 + 흡수 entry 제거",
  "scope": [
    "projects/meta/ROADMAP.md `schema_note` 필드 신규 (신/기존 schema 공존 명시, ARCHITECTURE.md § 6.1 cross-ref)",
    "projects/meta/ROADMAP.md v3.0 entry 신 schema 변환 (id flat → version + id 분리, milestones_path + absorbed_milestones 필드 추가)",
    "projects/meta/ROADMAP.md v2.2_* 4건 entry 제거 (era-detect / cp949 / controlled-comparison / historical-decision — v3.0 sub-milestone phase 2/6/7/8 흡수)",
    "v2.0~v2.1 / v1.0~v1.4 보존 entry 는 기존 schema (id flat) 유지 (forward-only — schema 강제 변환 부재)"
  ],
  "rationale": "신 schema (version + id 분리) v3.0+ 적용 + 보존 entry 는 forward-only 정책상 기존 schema 유지. 두 schema 공존 — schema_note 필드 명시로 검증자 혼란 회피. v2.2_* 4건 entry 제거는 v3.0 sub-milestone phase 2/6/7/8 흡수 결정 (D14 commit ref).",
  "decisions_referenced": ["D3 (ROADMAP entry version 단위 1 entry, v3.0+)", "D11 (ROADMAP transition state 종료)", "D14 (commit ref + dependencies.absorbed_from)", "D17 (breaking change → major bump)"],
  "absorbed_from": [
    "v2.2_era-detect-shared-module (phase-2 흡수, ROADMAP entry 제거)",
    "v2.2_smoke-cp949-encoding-pattern (phase-6 흡수 예정, ROADMAP entry 제거)",
    "v2.2_smoke-controlled-comparison-pattern (phase-7 흡수 예정, ROADMAP entry 제거)",
    "v2.2_historical-7stage-stage1-decision (phase-8 흡수 예정, ROADMAP entry 제거)"
  ],
  "rollback": "git diff HEAD~ HEAD -- projects/meta/ROADMAP.md 후 manual revert (D18). v2.2_* 4건 entry 부활은 git show HEAD~:projects/meta/ROADMAP.md 로 복구.",
  "verification": {
    "smoke_spec_verification": "PASS (ROADMAP 직접 parse 안 함)",
    "smoke_scope_contract": "PASS (ROADMAP 직접 parse 안 함)",
    "smoke_projects_scope_discipline": "PASS (root ROADMAP thin index 만 검증, projects/meta/ROADMAP.md 영향 없음)"
  }
}
```

## 작업 내용

1. **ROADMAP.md schema_note** 신규 — 신/기존 schema 공존 명시
2. **v3.0 entry 신 schema 변환** — `version: "v3.0"` + `id: "milestones-restructure"` (group-slug) + `milestones_path: "milestones/v3.0/milestones.md"` + `absorbed_milestones[]` (4건)
3. **v2.2_* 4건 entry 제거** — phase-2 (era-detect), phase-6 (cp949), phase-7 (controlled-comparison), phase-8 (historical-decision) 으로 흡수
4. **updated 필드 갱신**: 2026-05-10g → 2026-05-10h

## execution_notes

- 신 schema 적용 범위 = v3.0+ entry (forward-only). 보존 entry (v2.0~v2.1 / v1.0~v1.4) 는 기존 schema 그대로 — 두 schema 공존 인정
- v2.2_* 4건 entry 제거 시 v2.2 group entry 신규 추가 부재 (사용자 결정 = 흡수, group 별 entry 부재)
- 정보 추적성: absorbed_milestones[] 필드 + commit 메시지 reference + milestones.md sub-milestone listing (phase-5 작성)
- 두 schema 공존 시 smoke 영향 부재 — smoke-spec-verification + smoke-scope-contract 모두 ROADMAP 직접 parse 안 함

## commit

```
feat(meta): v3.0 phase-4 — ROADMAP schema (version+id 분리) + v2.2_* 4건 entry 제거
```

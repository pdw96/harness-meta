---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: PROPOSE
status: completed
---

# PROPOSE — v6.1

## Spec

```json
{
  "next_candidates": [
    {"id": "nested-additional-reduction", "title": "nested 필드 추가 감축 mechanism", "trigger": "B_byproduct", "origin": "v6.1 L2 + sc_1_nested FAIL-ACK", "target_version": "v6.4 또는 별도", "description": "success_criteria/out_of_scope/risks_identified item 객체 → string 단순화 또는 array 의무 자체 해체. 현 nested 60 → ≤30 목표. risk_2 narrative 정합."},
    {"id": "long-title-systematic-cleanup", "title": "long-title milestone entry 일괄 정정", "trigger": "B_byproduct", "origin": "v6.1 migration script WARN — title 60자 초과 milestone 5+건 (v4.0/v5.8/v5.9 등 100+자)", "target_version": "v6.2 또는 별도", "description": "v6.0 entry title 가이드 4 원칙 (≤60자, active form) 정합 위해 backfill 시점 보존된 long-title 일괄 retitle. v6.0 sc_3 일부 후속."},
    {"id": "frontmatter-yaml-parser-enhancement", "title": "smoke YAML parser nested 키 지원", "trigger": "D_design", "origin": "v6.1 D5 limitation — 현 parser = 평탄 key:value 만", "target_version": "v6.5+", "description": "현 단순 regex parser 가 nested YAML (예: list, mapping) 지원 부재. 향후 frontmatter 구조 확장 시 PyYAML 의존 검토 또는 자체 parser 강화."},
    {"id": "migrate-script-permanent-tool", "title": "schema 변환 도구 permanent 인프라 화", "trigger": "B_byproduct", "origin": "v6.1 D6 임시 + 삭제 패턴 자연 발현", "target_version": "v6.5+", "description": "v6.1 임시 migration script 의 lint-friendly 변환 로직은 향후 schema 변경 시 재사용 가능. scripts/ 안 permanent 도구 화 검토 — 단 자체 시스템 인프라 부풀음 vs 재사용 trade-off 평가 필요."}
  ]
}
```

## PROPOSE summary

v6.1 후속 candidate 4건 거명. 모두 sc_5 lessons learned 또는 acknowledged miss (sc_1_nested) 안 자연 발현. 동결 정책 정합 (사용자 명시 발의 trigger 의무 — 자동 등재 회피).

| ID | trigger | target | priority |
|---|---|---|---|
| `nested-additional-reduction` | B_byproduct | v6.4+ | med (sc_1_nested ACK) |
| `long-title-systematic-cleanup` | B_byproduct | v6.2 | med (v6.0 sc_3 후속) |
| `frontmatter-yaml-parser-enhancement` | D_design | v6.5+ | low (현 한계 미증) |
| `migrate-script-permanent-tool` | B_byproduct | v6.5+ | low (인프라 잔존 trade-off) |

본 PROPOSE 시점에 ROADMAP next_candidates[] 자동 등재 부재 — 사용자 명시 trigger 후 등재 (memory `feedback_iterative_pre_plan_review` + `feedback_section_6_2_abolished` 정합).

## Archival cycle

본 v6.1 완료로 ROADMAP `milestones[]` recent 3 = v6.1 (in_progress → completed) + v6.0 + v5.21. v5.20 entry → CHANGELOG archival 대상 (v5.21 도입 archival cycle 정합). 본 archival 은 별도 commit 또는 다음 milestone 안 통합 검토.

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT: [`INTENT.md`](INTENT.md) + [`RESEARCH.md`](RESEARCH.md) + [`DESIGN.md`](DESIGN.md) + [`APPROVE.md`](APPROVE.md) + [`VERIFY.md`](VERIFY.md) + [`REPORT.md`](REPORT.md)
- v5.21 archival cycle 정전화: [`../v5.21/REPORT.md`](../v5.21/REPORT.md)
- v6.0 entry title 가이드 4 원칙: [`../v6.0/REPORT.md`](../v6.0/REPORT.md)
- ROADMAP next_candidates[] 등재 의무 source: [`../../ROADMAP.md`](../../ROADMAP.md)

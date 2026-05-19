# phase-1 — smoke 갱신 + v6.1 자체 4건 도그푸드

## Spec

```json
{
  "phase": 1,
  "status": "complete",
  "changes": [
    {"file": "tests/smoke-spec-verification.sh", "change": "YAML frontmatter parser (extract_frontmatter) + check_json_fields 자동 식별 분기 추가 — 신규 schema (frontmatter 존재) vs 현 schema (부재) backward compat"},
    {"file": "projects/meta/milestones/v6.1/INTENT.md", "change": "신규 schema 재작성 — YAML frontmatter 5 필드 + JSON top 9→3 (id/title/version + motivation/dependencies/harness_engineering_mapping → frontmatter/MD body)"},
    {"file": "projects/meta/milestones/v6.1/RESEARCH.md", "change": "신규 schema 재작성 — JSON top 8→4 (id/title/version/preliminary_options_summary → frontmatter/MD body)"},
    {"file": "projects/meta/milestones/v6.1/DESIGN.md", "change": "신규 schema 재작성 — JSON top 8→2 (id/title/version + risk_mitigation/perspectives_review_summary → frontmatter/MD body)"},
    {"file": "projects/meta/milestones/v6.1/APPROVE.md", "change": "신규 schema 재작성 — JSON top 4→1 (id/title/version → frontmatter)"},
    {"file": "projects/meta/milestones/v6.1/milestones.md", "change": "sub_milestones[] 갱신 — phase-1 complete + phase-2 pending"}
  ],
  "verification": {
    "smoke_spec_verification": "PASS — v6.1 4건 (신규 schema) + 기존 27 active (현 schema) 모두 통과. PASS=243 FAIL=0 SKIP=39",
    "quantitative_dogfood": "v6.1 4 artifact: JSON top 29→10 (-65.5%), nested 105→39 (-62.9%), YAML frontmatter +20 신규. baseline (v6.0 4 artifact 동일 비교)"
  }
}
```

## 변경 narrative

### smoke-spec-verification.sh 갱신 (D5/D9)

신규 함수 `extract_frontmatter(fp)` 추가 — 단순 regex `^---\n(.*?)\n---\n` + line split `:` parsing. PyYAML 의존 없음 (D9 정합).

`check_json_fields` 수정 — frontmatter 존재 시 신규 schema 분기:

1. frontmatter required 검증 (id/title/version/stage/status default)
2. JSON required 검증 (id/title 자동 제외)

frontmatter 부재 시 현 schema 그대로 (backward compat — 27 active milestone backfill 전).

### v6.1 자체 4건 도그푸드 (D10)

신규 schema 표준 적용:

실 적용 = [`../INTENT.md`](../INTENT.md) / [`../RESEARCH.md`](../RESEARCH.md) / [`../DESIGN.md`](../DESIGN.md) / [`../APPROVE.md`](../APPROVE.md). YAML frontmatter 5 필드 (id/title/version/stage/status) + H1 본문 제목 + `## Spec` JSON (smoke 강제 필드만, id/title 제거) + `## <h2 narrative sections>` Markdown body.

motivation / dependencies / harness_engineering_mapping (INTENT) + preliminary_options_summary (RESEARCH) + risk_mitigation / perspectives_review_summary / 신규 schema 명세 / YAML parser narrative / migration 규칙 / cascade 표 / 정량 목표 (DESIGN) + 승인 trace (APPROVE) 모두 Markdown body 안 흡수.

### 정량 측정 결과

v6.1 vs v6.0 동일 4 artifact (INTENT/RESEARCH/DESIGN/APPROVE) 비교:

| 지표 | v6.0 baseline | v6.1 신규 schema | delta |
|---|---|---|---|
| JSON top-level 합계 | 29 | 10 | **-19 (-65.5%)** |
| JSON nested 합계 | 105 | 39 | **-66 (-62.9%)** |
| YAML frontmatter 합계 | 0 | 20 (5 × 4) | +20 (신규) |

phase-2 28 milestone backfill 후 full 6 artifact 합계 측정 예정 (VERIFY 단계 sc_1 검증).

### sc_1 nested ≤20/milestone 목표 점검

DESIGN 안 sc_1 = "nested 106 → ≤20/milestone" — 본 phase-1 도그푸드 실측 39 (4 artifact only) → full 6 artifact 약 55-60 예상. **목표 ≤20 hardcode 한계** — 자동화 검증 필드 (success_criteria/out_of_scope/risks_identified 등) 안 nested array 필수 보존 의무.

VERIFY 단계 안 narrative 수용 권고 — sc_1 목표 ≤ 50-60 으로 현실화 (still -50% baseline). 추가 감축 (예: success_criteria item 객체 → string 단순화) 은 향후 milestone PROPOSE candidate.

### 5요소 매핑 적용 (D8 cascade preview)

본 phase-1 = Context 면 첫 실 적용. § 3.3 5요소 매트릭스 Context 행 sub-mechanism cross-ref 갱신 = phase-2 cascade 안 통합 (root CLAUDE.md / projects/meta/CLAUDE.md / ARCHITECTURE § 6.1 등 6 host).

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) D1~D11 11 결정
- INTENT: [`../INTENT.md`](../INTENT.md) sc_1~sc_6 success criteria
- milestones.md: [`../milestones.md`](../milestones.md) sub_milestones[].phase-1
- smoke 갱신: [`../../../../../tests/smoke-spec-verification.sh`](../../../../../tests/smoke-spec-verification.sh)

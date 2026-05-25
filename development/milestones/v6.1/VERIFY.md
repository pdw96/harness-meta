---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: VERIFY
status: completed
---

# VERIFY — v6.1

## Spec

```json
{
  "verdict": "PASS-WITH-COMMENTS",
  "criteria_check": [
    {"id": "sc_1_top", "criterion": "JSON 필드 정량 감축 — top-level 평균 32 → ≤ 16", "result": "PASS", "evidence": "active 28 milestone 측정 — top 32.3 → 13.9 (-57.1%), 목표 ≤ 16 충족"},
    {"id": "sc_1_nested", "criterion": "JSON 필드 정량 감축 — nested 106 → ≤ 20", "result": "FAIL-ACKNOWLEDGED", "evidence": "active 28 milestone 측정 — nested 106 → 60.1 (-43.3%). 목표 ≤ 20 미충족 — narrative 흡수 한계 (smoke 강제 nested array 보존 의무). risk_2 mitigation 정합. 후속 PROPOSE candidate"},
    {"id": "sc_2", "criterion": "정보 손실 0 — 제거 필드 → YAML/JSON/MD body 흡수", "result": "PASS", "evidence": "migration script `_sanitize_inline` + `_short_json` 변환 100% 보존. cascade source narrative + git diff 검증 가능"},
    {"id": "sc_3", "criterion": "smoke 7 hook 모두 PASS 유지", "result": "PASS", "evidence": "pre-commit 14 hook (7 smoke + 7 기타) phase-1 + phase-2 commit 직전 모두 PASS"},
    {"id": "sc_4", "criterion": "active 28 milestone backfill 완료 — meta 27 + upbit 1", "result": "PASS", "evidence": "phase-2 commit 5d7164a 안 189 artifact migrated (27 meta × 6-7 + upbit v1.4 7 = 189), _archive 40 건 보존"},
    {"id": "sc_5", "criterion": "도그푸드 — v6.1 자체 산출물 신규 schema 적용", "result": "PASS", "evidence": "phase-1 commit 10ffa2c 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 + phase-2 안 milestones.md + execute/phase-{1,2}.md + 본 VERIFY 도 신규 schema. v3.21 cycle 26 도그푸드 완성"},
    {"id": "sc_6", "criterion": "smoke-spec-verification.sh 갱신 — YAML 자동 식별 + backward compat", "result": "PASS", "evidence": "phase-1 commit 10ffa2c 안 extract_frontmatter() + check_json_fields() 자동 식별 분기. 신규 schema (frontmatter 존재) + 현 schema (부재) 양립 검증"}
  ],
  "smoke_tests": [
    {"id": "st_1", "name": "smoke-spec-verification.sh", "result": "PASS", "notes": "active 28 milestone (신규 schema) + v6.1 자체 4건 + execute phase-* 검증"},
    {"id": "st_2", "name": "smoke-scope-contract.sh", "result": "PASS", "notes": "APPROVE.md approval gate + INTENT.out_of_scope 의무"},
    {"id": "st_3", "name": "smoke-bundle-trigger.sh", "result": "PASS", "notes": "ROADMAP milestones[] schema (recent 3 + in_progress + deferred + next_candidates[] 분리) 정합"},
    {"id": "st_4", "name": "smoke-open-stage-discipline.sh", "result": "PASS", "notes": "v6.1/milestones.md ↔ 디렉토리 페어링"},
    {"id": "st_5", "name": "smoke-cross-ref.sh", "result": "PASS", "notes": "cascade 5 host 갱신 후 broken link 0"},
    {"id": "st_6", "name": "smoke-claude-md-drift.sh", "result": "PASS", "notes": "root ↔ 모듈 CLAUDE.md drift 0"},
    {"id": "st_7", "name": "smoke-projects-scope-discipline.sh", "result": "PASS", "notes": "root ROADMAP thin index 보존"}
  ],
  "verdict_rationale": "5 sc 중 5 PASS + 1 FAIL-ACKNOWLEDGED (sc_1_nested, narrative 흡수 한계). pre-commit 14 hook 모두 PASS. 28 milestone backfill 정량 평가 -57% top + -43% nested. risk_1~5 모두 mitigation 적용 완료. v3.21 narrative 정전화 3 단계 패턴 cycle 26 도그푸드 완성 (DESIGN D8 → EXECUTE phase-2 Edit → 본 VERIFY grep). 후속 nested 추가 감축은 별 milestone candidate."
}
```

## Manual checks

- **cascade drift grep**: `MD + JSON 코드블록` 잔존 0건 in active hosts. _archive 40 건은 역사적 보존 (의도 정합)
- **YAML frontmatter regex**: 5 필드 (id/title/version/stage/status) 모두 존재 — sample 검증 (v4.0/INTENT.md / v5.10/DESIGN.md / v6.0/REPORT.md)
- **smoke 자동 식별 분기 작동**: 신규 (v4.0~v6.0 + v6.1, frontmatter 존재) + 현 (없음 — _archive backfill 부재) 양 분기 모두 PASS (backward compat 검증)
- **post-report-write hook 영향 부재** (risk_5): hook 안 schema 필드 직접 참조 부재 — 신규 schema 안 변화 영향 없음. phase-1 도그푸드 시 REPORT.md trigger 정합 검증

## Quantitative measurement (sc_1)

active 28 milestone 평균 baseline vs post-v6.1:

| 지표 | baseline | post-v6.1 | delta | sc_1 목표 | result |
|---|---|---|---|---|---|
| top-level JSON avg/milestone | 32.3 | 13.9 | **-57.1%** | ≤ 16 | ✓ |
| top-level JSON max/milestone | 48 | 14 | -71% | — | — |
| nested JSON avg/milestone | 106.0 | 60.1 | -43.3% | ≤ 20 | ✗ ACK |
| nested JSON max/milestone | 185 | 94 | -49% | — | — |
| YAML frontmatter avg/milestone | 0 | 34.5 | +34.5 | 신규 5 × 6-7 | ✓ |

nested 미충족 narrative — smoke 강제 nested array (success_criteria[] / out_of_scope[] / decisions[] / external[] / codebase[] / options[] / risks_identified[] 등) 필수 보존 의무. ≤ 20 hardcode 한계 인지. 후속 추가 감축 mechanism (예: success_criteria item 객체 → string 단순화) 은 PROPOSE candidate.

## Regressions

검증된 회귀 0건:

- pre-commit 14 hook 모두 PASS (phase-1 + phase-2 commit 직전)
- markdownlint config 조정 (MD025/MD037) 으로 기존 파일 영향 없음 — upbit audit-* 디렉토리 안 underscore emphasis 패턴 보존
- post-report-write hook 작동 정합
- _archive 40 건 영향 없음 (역사적 보존 의도 정합)

## Smoke fix acknowledgement

- smoke-spec-verification.sh 갱신 — D9 hardcode 패턴 정합 (외부 의존 0, 단순 regex)
- markdownlint config 갱신 정당화 — Anthropic 표준 패턴 정합 + 기존 파일 호환 보존

## 관련

- DESIGN: [`DESIGN.md`](DESIGN.md) sc_1~sc_6 + risk_1~5
- phase-1 commit: 10ffa2c
- phase-2 commit: 5d7164a
- v3.21 narrative 3 단계 패턴 cycle 26 도그푸드: ARCHITECTURE § 6.2

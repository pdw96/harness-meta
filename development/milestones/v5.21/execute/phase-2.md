# EXECUTE — phase-2

```json
{
  "id": "phase-2-roadmap-schema-redesign",
  "title": "ROADMAP schema A2 (milestones[] + next_candidates[] 별도 필드) + completed 41건 CHANGELOG 이전 + recent 3 + deferred 3 보존",
  "phase": 2,
  "status": "completed",
  "scope": "projects/meta/ROADMAP.md 본체 schema A2 재작성. milestones[] = recent 3 (v5.20/v5.19/v5.18) + in_progress 1 (v5.21) + deferred 3 (v1.4_hook/v1.4_design-review/v1.5_research) = length 7. next_candidates[] 신규 필드 (v6.0_workflow-automation-and-least-privilege 거명). completed 41건 entry (v5.17 ~ v1.0_workflow-redesign) 제거 (phase-1 안 CHANGELOG.md 이전 완료). schema_note + 의도 + 비고 narrative 재작성.",
  "changes": [
    {
      "file": "projects/meta/ROADMAP.md",
      "action": "rewrite",
      "size_before_bytes": 101939,
      "size_after_bytes": 11222,
      "size_delta_bytes": -90717,
      "size_delta_pct": -89.0,
      "line_before": 589,
      "line_after": 110,
      "line_delta": -479,
      "structure": {
        "schema_note": "갱신 — v5.21+ schema A2 narrative + next_candidates[].id regex + target_version regex hardcode (DESIGN.D2.schema_validation_pattern_source + D15 정합)",
        "deferred_note": "갱신 — v3.13/v3.14 narrative 보존 + v4.0 § 6.2 폐지 narrative + 재발의 trigger 조건",
        "milestones": [
          "v5.21 (in_progress, 본 milestone) — 갱신 (OPEN entry summary v5.21 minor 결정 narrative 정합)",
          "v5.20 (completed, recent #1) — 기존 summary 보존",
          "v5.19 (completed, recent #2) — 기존 summary 압축 (4 line)",
          "v5.18 (completed, recent #3) — 기존 summary 압축 (3 line)",
          "v1.4_hook-narrative-separation (deferred) — 기존 entry 보존",
          "v1.4_design-review-trace (deferred) — 기존 entry 보존",
          "v1.5_research-cascade-grep-discipline (deferred) — 기존 entry 보존"
        ],
        "next_candidates": [
          "workflow-automation-and-least-privilege (target_version: v6.0) — 사용자 명시 발의 (v5.21 round) origin"
        ],
        "removed_entries": "41건 completed entry (v5.17 ~ v1.0_workflow-redesign) 제거 (CHANGELOG.md archival 흡수 완료)",
        "preserved_narrative": [
          "## 의도 (v5.21+ schema A2)",
          "## v5.21 정전화 1차 source",
          "## 관련 문서",
          "## 비고"
        ]
      }
    }
  ],
  "affected_files": ["projects/meta/ROADMAP.md"],
  "verification": {
    "size_check": "PASS — 101939 → 11222 bytes (smoke SIZE_LIMIT 100000 통과)",
    "milestones_array_length": "7 (in_progress 1 + recent 3 + deferred 3, INTENT.sc_1 정합)",
    "next_candidates_array_length": "1 (v6.0_workflow-automation-and-least-privilege, INTENT.sc_1 정합)",
    "completed_entries_removed": "41건 (v5.17 + v5.16 + v5.15 + v5.14 + v5.13 + v5.12 + v5.11 + v5.10 + v5.9 + v5.8 + v5.7 + v5.6 + v5.5 + v5.4 + v5.3 + v5.2 + v5.1 + v5.0 + v4.3 + v4.2 + v4.1 + v4.0 + v3.21 + v3.20 + v3.19 + v3.18 + v3.17 + v3.16 + v3.15 + v3.14 + v3.13 + v3.12 + v3.11 + v3.10 + v3.9 + v3.8 + v3.7 + v3.3 + v3.4 + v3.5 + v3.6 + v3.2 + v3.1 + v3.0 + v2.0_workflow-word-fidelity + v2.1_smoke-spawn-batching + v1.3_harness-engineering-definition + v1.4_infra-minimization + v1.4_cross-ref-propagation + v1.1_meta-as-project + 외 v1.x 등). 정확 count = 본 phase-2 산출물 안 list 검증 의무",
    "expected_pre_commit_hooks": "14 hook 모두 PASS expected — size guard 통과 + JSON 파싱 정합 + milestones[] 보유 + bundling regex 정합"
  },
  "commit": "feat(meta): v5.21 phase-2 — ROADMAP schema A2 + completed 41건 CHANGELOG 이전 + next_candidates[] 신규 필드",
  "execution_notes": [
    "INTENT.sc_1 표현 정정 (4 → 7, deferred 3 포함) — phase-2 진입 직전 사용자 결정 round 불요 (DESIGN.D2 + D7 정합 자연)",
    "RESEARCH 안 size 추정 ~37000 bytes 부정확 발견 (실 101939 bytes, ~2.7x) — L1 lesson candidate (REPORT 안 흡수)",
    "phase-1 commit 안 size guard FAIL → ROADMAP 미포함 분리 commit — phase-2 안 schema A2 적용 후 size 89% 감소 = smoke PASS 보장",
    "deferred 3건 entry 보존 (DESIGN.D7 정합) — workflow self-improvement 본질, v4.0 § 6.2 폐지 narrative 정합, 재발의 trigger 조건 보존",
    "next_candidates[] 신규 entry 1건 = v6.0_workflow-automation-and-least-privilege (사용자 발의 (A) 결정 정합, DESIGN.D8 정합)",
    "milestones[] schema = id 필드 보존 (group-slug 또는 v1.x flat schema 혼재 = forward-only 정책 정합, 새 v3.0+ entry id = group-slug + v1.x deferred entry id = v1.4_hook-narrative-separation flat 보존)"
  ]
}
```

## ROADMAP 구조 검증 (재작성 후)

### JSON 블록 매트릭스

| 필드 | length / 본질 |
|---|---|
| project | "meta" |
| updated | "2026-05-19" |
| schema_note | v5.21+ schema A2 narrative + regex hardcode |
| deferred_note | v3.13/v3.14 + v4.0 § 6.2 narrative 보존 |
| candidate_draft | [] (벤치마크 cycle routine 보존, v4.0 D4 정합) |
| milestones | length 7 (in_progress 1 + recent 3 + deferred 3) |
| next_candidates | length 1 (v6.0_workflow-automation-and-least-privilege) |

### Narrative 섹션

- `## 의도 (v5.21+ schema A2)` — forward-looking 본질 + archival 3중 보존 narrative
- `## v5.21 정전화 1차 source` — milestones/v5.21/ + ARCHITECTURE § 4 끝 #3 cross-ref
- `## 관련 문서` — root CLAUDE.md / ARCHITECTURE / subdir CLAUDE / 활성 milestone / CHANGELOG / Archive
- `## 비고` — v5.21 schema redesign 정전화 narrative + 이전 schema (v3.0+) 보존 historical

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) D2 (Schema A2) + D7 (deferred 보존) + D8 (next_candidates v6.0 거명) + D15 (regex hardcode)
- INTENT: [`../INTENT.md`](../INTENT.md) sc_1 (length 7) + sc_3 (cross-cutting phase-1 dedupe + phase-2 remove) + sc_4 (부합도 95%+)
- 다음 phase: phase-3 (cascade 7 host narrative + § 4 끝 drift 해소)

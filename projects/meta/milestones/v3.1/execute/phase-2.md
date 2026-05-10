# execute/phase-2 — v3.1_workflow-policy-fine-tuning

```json
{
  "phase": 2,
  "title": "ARCHITECTURE.md § 6.1 — milestones.md historical era 적용 결정 (forward-only 강제)",
  "status": "completed",
  "sub_milestone_id": "milestones-md-historical-decision",
  "absorbed_from": "v3.1_milestones-md-spec-formalization (v3.0 PROPOSE next_candidates)",
  "scope_implemented": [
    "projects/meta/ARCHITECTURE.md § 6.1 안 'era 영구화 trade-off (forward-only)' 단락 직후 'milestones.md spec historical era 적용 결정 (v3.1 phase-2 흡수)' 1단락 추가 — 옵션 (a) forward-only 강제 채택 narrative + rationale 3건 (1) v2.x 9-stage flat 구조 부적합 (2) v1.x 7-stage / 4-tier 동일 (3) forward-only 정책 일관 + 옵션 (b)/(c) 거부 narrative + spec picture-frame cross-ref 'projects/meta/milestones/v3.0/milestones.md' 1줄",
    "projects/meta/milestones/v3.0/milestones.md unchanged (D12 — architecture P1 권고 흡수, 사용자 결정 2026-05-10)",
    "projects/meta/milestones/v3.1/milestones.md sub_milestones[0] status: completed → sub_milestones[1] status: in_progress 갱신",
    "projects/meta/milestones/v3.1/execute/phase-1.md status: in_progress → completed (commit_sha: 0a86598 추가)"
  ],
  "affected_files": [
    "projects/meta/ARCHITECTURE.md",
    "projects/meta/milestones/v3.1/milestones.md",
    "projects/meta/milestones/v3.1/execute/phase-1.md",
    "projects/meta/milestones/v3.1/execute/phase-2.md"
  ],
  "self_check_pre_commit": {
    "markdownlint": "tests pass — ARCHITECTURE.md 새 narrative 안 underscore identifier (`v{X.Y}_{slug}` / `v2.x_*`) 백틱 escape 적용",
    "smoke_cross_ref": "ARCHITECTURE.md 안 새 cross-ref `projects/meta/milestones/v3.0/milestones.md` 정합 검증",
    "smoke_spec_verification": "milestones/v3.1/ era 분류 9-stage-bundled 보존 + execute/phase-2.md schema 검증",
    "smoke_scope_contract": "v3.1 9-stage-bundled era 분기 PASS"
  },
  "execution_notes": "phase-2 narrative-only — 구현 부담 0. v3.0 milestones.md 본문 unchanged (D12 사용자 결정 P1 수용 — 단방향 cross-ref 만 ARCHITECTURE.md § 6.1 안에서 v3.0 milestones.md 를 가리키는 형태). 본 결정 narrative 가 향후 v4.0+ era 도입 milestone 또는 milestones.md spec 의 historical era 적용 검토 시 reference 가능 (D5 rationale 강화 narrative — narrative-only 도 독립적 commit 가치 보유).",
  "commit_message_intent": "feat(meta): v3.1 phase-2 — ARCHITECTURE.md § 6.1 milestones.md historical era 적용 결정 (forward-only 강제, v3.1_milestones-md-spec-formalization 흡수)"
}
```

## 진행 narrative

phase-2 = milestones.md spec picture-frame (v3.0 phase-5 도입) 의 historical era 적용 결정. 옵션 (a) forward-only 강제 채택 — v3.0 ARCHITECTURE.md § 6.1 forward-only 정책 직접 일관:

- v2.x 9-stage flat 구조 = 디렉토리 명 `v{X.Y}_{slug}` 단위 1 milestone (sub-milestone 부재) → milestones.md 의 sub_milestones[] phase 매핑 본질 부적합
- v1.x 7-stage / 4-tier 동일 (동등 부적합)
- forward-only 정책 (§ 6.1 'era 영구화 trade-off') 직접 일관 — historical 디렉토리 unchanged

옵션 (b) v2.x retroactive 거부 — 본질 부적합 + git mv history 위험. 옵션 (c) 신규만 = (a) 와 사실상 동치 (구분 모호).

본 결정은 narrative-only — 구현 부담 0. v3.0 milestones.md 본문 unchanged (D12, architecture P1 권고 흡수, 사용자 결정 2026-05-10 P1 제거 채택). spec picture-frame cross-ref 만 ARCHITECTURE.md § 6.1 안에서 단방향 (v3.0 milestones.md 를 가리키는 형태).

향후 v4.0+ era 도입 milestone 또는 milestones.md spec 의 historical era 적용 재검토 시 본 결정 narrative reference 가능.

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) (D1/D12/D17 + phase-2 scope)
- 상위 정전: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md) § 6.1
- spec picture-frame source: [`../../v3.0/milestones.md`](../../v3.0/milestones.md)
- v3.0 PROPOSE 흡수 source: [`../../v3.0/PROPOSE.md`](../../v3.0/PROPOSE.md) (next_candidates v3.1_milestones-md-spec-formalization)

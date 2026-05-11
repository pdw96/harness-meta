# EXECUTE phase-1 — ROADMAP entry 3건 deferred 처리 + deferred_note 갱신

DESIGN.phases[0] 의 실 구현 trace. 단어 책임 1:1 매핑 (v2.0_workflow-word-fidelity).

```json
{
  "phase": 1,
  "title": "ROADMAP entry 3건 deferred 처리 + deferred_note 갱신",
  "status": "in_progress",
  "changes": [
    {
      "file": "projects/meta/ROADMAP.md",
      "edits": [
        {
          "target": "deferred_note 필드 갱신",
          "before_summary": "v3.6 narrative 만 (v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 거명)",
          "after_summary": "v3.6 narrative + v3.13 결정 narrative 누적 — v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline 도 § 6.2 동결 정책 적용 defer (외부 적용 데이터 대기) 추가"
        },
        {
          "target": "v1.4_hook-narrative-separation entry",
          "before_summary": "status: pending, trigger: D_design",
          "after_summary": "status: deferred + deferred_reason 필드 (§ 6.2 cross-ref + workflow 영향 본질 + 재발의 trigger 조건 + v3.13 결정 거명)"
        },
        {
          "target": "v1.4_design-review-trace entry",
          "before_summary": "status: pending, trigger: D_design",
          "after_summary": "status: deferred + deferred_reason 필드"
        },
        {
          "target": "v1.5_research-cascade-grep-discipline entry",
          "before_summary": "status: pending, trigger: B_regression",
          "after_summary": "status: deferred + deferred_reason 필드"
        }
      ]
    }
  ],
  "execution_notes": [
    "OPEN stage (이전 step) 에서 추가된 v3.13 entry 와 v2.1_pending-milestone-renumber-policy entry 제거는 본 phase 의무 외 (Stage A 책임).",
    "Stage I PROPOSE 에서 v3.13 entry status 'in_progress' → 'completed' 갱신 책임.",
    "historical milestone 산출물 (v1.4_cross-ref-propagation/REPORT.md 등 거명 위치) 은 forward-only 보존 정책 — cleanup 부재 (D7).",
    "ROADMAP `updated` 필드 = 2026-05-12 (today 일치) — 명시적 noop, 갱신 부재.",
    "INTENT~APPROVE 4 산출물 (INTENT.md / RESEARCH.md / DESIGN.md / APPROVE.md) + milestones.md + execute/phase-1.md 는 본 phase commit 안 미포함 — Stage G (VERIFY) commit 안 포함 패턴 (b) 채택 (산출물 영구 보존 보장)."
  ],
  "verification_pre_commit": "pre-commit run --all-files 실행 후 14 hook 모두 PASS 확인 의무. smoke-bundle-trigger.sh / smoke-spec-verification.sh / smoke-scope-contract.sh / smoke-open-stage-discipline.sh 안 status 'deferred' / deferred_reason 신 필드 검증 부재 → 회귀 0 예상.",
  "commit": null
}
```

## 변경 detail

### ROADMAP.md (1 파일)

#### Edit 1: `deferred_note` (line 7)

기존 narrative + v3.13 결정 narrative 누적 (v3.6 narrative 보존 + 3 entry 거명 명시).

#### Edit 2~4: v1.x pending 3건 entry

각 entry 의 `status` `"pending"` → `"deferred"` + `deferred_reason` 필드 추가 (§ 6.2 cross-ref + workflow 영향 본질 + 재발의 trigger 조건 + v3.13 결정 거명).

## 검증 (commit 후 갱신)

- pre-commit run --all-files 결과
- smoke-bundle-trigger.sh 직접 실행 결과 (status: 'deferred' / deferred_reason 신 필드 통과 확인)
- ROADMAP json block parse 정합

## 관련

- DESIGN.phases[0]: [`../DESIGN.md`](../DESIGN.md)
- APPROVE: [`../APPROVE.md`](../APPROVE.md)

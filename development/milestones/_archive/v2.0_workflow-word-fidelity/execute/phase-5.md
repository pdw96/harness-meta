# EXECUTE phase-5 — Historical 7-stage era 11개 milestone PLAN.md → INTENT.md git mv + 본문 cross-ref

```json
{
  "phase": 5,
  "title": "Historical 7-stage era 11개 milestone PLAN.md → INTENT.md git mv + 본문 cross-ref 갱신",
  "status": "complete",
  "scope_recap": "7-stage era 11개 milestone 의 PLAN.md → INTENT.md git mv (history 보존) + 각 milestone 디렉토리 내부 본문 (RESEARCH/DESIGN/VERIFY/REPORT/execute/phase-N.md) 의 'PLAN.md' 문자열 거명 → 'INTENT.md' sed 일괄 갱신. 본 v2.0_workflow-word-fidelity milestone 자체는 7-stage era 자기참조 표지 (D12) 로 PLAN.md 유지 — rename 제외. 4-tier era (v1.84~v1.88) 는 D8 정책에 따라 rename 제외. PLAN.success_criteria / PLAN.motivation 등 필드 거명은 7-stage era 의미로 보존 (cross-ref 만 갱신). git mv + sed 일괄을 단일 commit 으로 묶어 era migration 단일 revert 단위 보장 (보안 검토 R1 권고).",
  "changes": [
    "git mv projects/meta/milestones/v1.0_workflow-redesign/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.1_agents-md-cleanup/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.1_design-phases-execute-tracking-automation/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.1_meta-as-project/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.1_post-report-write-hook-update/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.1_readme-cleanup/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.1_smoke-precommit-rewrite/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.2_post-report-write-message-rewrite/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.3_harness-engineering-definition/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.4_cross-ref-propagation/PLAN.md → INTENT.md",
    "git mv projects/meta/milestones/v1.4_infra-minimization/PLAN.md → INTENT.md",
    "11 milestone 디렉토리 내부 .md 본문에서 'PLAN.md' 문자열 → 'INTENT.md' sed 일괄 갱신 (cross-ref 만; PLAN.success_criteria 등 필드 거명은 보존)"
  ],
  "execution_notes": "git mv 로 history 보존 (--follow 추적 가능). 본 v2.0 milestone 디렉토리는 rename 대상 외 (D12 자기참조 표지). phase commit 후 grep 'PLAN.md' 잔존 검증 — 본 v2.0 milestone 본인 + 정의 host 의 era 보존 narrative 만 허용.",
  "commit": "feat(meta): v2.0 phase-5 — historical 7-stage era 11개 PLAN.md → INTENT.md git mv + 본문 cross-ref"
}
```

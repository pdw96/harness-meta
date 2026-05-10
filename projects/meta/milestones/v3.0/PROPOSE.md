# PROPOSE — v3.0_milestones-restructure

```json
{
  "next_candidates": [
    {
      "id": "v3.1_markdownlint-trap-narrative",
      "title": "tests/CLAUDE.md § 흔한 함정 7번째 항목 — markdownlint MD032/MD049 trap (underscore escape + list 빈 줄)",
      "trigger": "B_regression",
      "trigger_type": "lessons_learned (v3.0 L10)",
      "summary": "v3.0 phase-3 commit 시 markdownlint MD032 (blanks-around-lists) + MD049 (emphasis-style underscore) 위반 발견 — INTENT.md 안 v{X.Y}_{slug} underscore가 emphasis 오인, APPROVE.md/DESIGN.md list 앞뒤 빈 줄 부재. tests/CLAUDE.md § 흔한 함정 7번째 항목 추가 (백틱 escape + 강조 직후 빈 줄 의무). 단독 narrative 만 — 향후 추가 narrative 후보와 bundling 가능. v3.0 9-stage-bundled era 첫 후속 적용 사례."
    },
    {
      "id": "v3.1_milestones-md-spec-formalization",
      "title": "milestones.md spec picture-frame 의 다른 era 적용 검토 — historical milestone 에 milestones.md 도입 여부",
      "trigger": "C_improvement",
      "trigger_type": "design_decision",
      "summary": "v3.0 phase-5 milestones.md spec picture-frame 은 v3.0+ 만 적용 (forward-only). 검토: historical milestone (v2.0~v2.1, v1.0~v1.4) 에 milestones.md 도입 시 ROADMAP 단순화 (sub-milestone 정보 → milestones.md 위임) vs forward-only 정책 위반 trade-off. 옵션 (a) 적용 안 함 (forward-only 강제) / (b) v2.x retroactive 적용 / (c) 신규 milestone 만 적용. 별도 milestone 으로 검토."
    },
    {
      "id": "v3.1_smoke-bundle-trigger-validation",
      "title": "smoke 추가 — bundling trigger 조건 (의미 단위 grouping) 자동 검증",
      "trigger": "B_regression",
      "trigger_type": "policy_enforcement",
      "summary": "ARCHITECTURE.md § 6.1 bundling 정책 — 의미 단위 grouping (같은 모듈 / 주제 / lessons_learned) 후속 candidates 통합. 현재 narrative 만 — smoke 자동 강제 부재. ROADMAP entry 신규 (status: pending) 시 같은 version 의 다른 entry 와 의미 단위 정합 검사 smoke 추가 검토. inactive 22 smoke 확장."
    }
  ],
  "propose_summary": "v3.0 의 직접 후속 3건 (markdownlint 함정 narrative / milestones.md historical 적용 / bundling trigger smoke). 모두 v3.0+ 9-stage-bundled era 정책의 fine-tuning. v3.1 통합 milestone 으로 bundling 가능 — 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning). 또는 단독 milestone N건 분리. 사용자 결정 (PROPOSE 후 ROADMAP 등록 시).",
  "ROADMAP_operations": [
    "v3.0 entry status: in_progress → completed (본 milestone 완료)",
    "v3.1_markdownlint-trap-narrative entry 신규 (status: pending, trigger: B_regression)",
    "v3.1_milestones-md-spec-formalization entry 신규 (status: pending, trigger: C_improvement)",
    "v3.1_smoke-bundle-trigger-validation entry 신규 (status: pending, trigger: B_regression)"
  ]
}
```

## next_candidates 종합

3건 후속 모두 v3.0+ 9-stage-bundled era 의 fine-tuning:

1. **markdownlint trap narrative** (lessons L10) — tests/CLAUDE.md § 흔한 함정 7번째 항목 추가 (자동 강제 부재, narrative 만)
2. **milestones.md historical 적용 검토** — forward-only vs retroactive trade-off 결정
3. **bundling trigger smoke** — 의미 단위 grouping 정합 자동 검증

3건 모두 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 영향 → **v3.1 통합 milestone (sub-milestone 3건) bundling 가능** (D6 swap 적용 사례). 또는 단독 milestone N건 분리.

## ROADMAP 갱신 작업

다음 작업 진행 시 사용자 확인:

1. v3.0 entry status: `in_progress` → `completed`
2. next_candidates 3건 ROADMAP entry 신규 등록 (신 schema, status: pending) — 또는 v3.1 통합 entry 1건 (사용자 결정)

## push + PR 결정

local commit 8건 (phase-1~8) + Stage G/H/I commit (VERIFY/REPORT/PROPOSE 추가). 사용자 확인 후 push:

```bash
git push origin main
# 또는 PR 생성:
gh pr create --title "milestone v3.0_milestones-restructure" --body "..."
```

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md)
- VERIFY: [`VERIFY.md`](VERIFY.md) (verdict: pass)
- REPORT: [`REPORT.md`](REPORT.md) (10 lessons_learned)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)

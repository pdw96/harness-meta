# INTENT — v3.17_phase-distribution-audit

```json
{
  "id": "v3.17_phase-distribution-audit",
  "title": "v3.x 17건 phase 분포 진단 — 1-phase 65% 현상 정량화 + 원인 분석 + 해결책 후보 PROPOSE",
  "goal": "v3.0+ 9-stage-bundled era 도입 narrative (같은 의미 단위 후속 candidates 를 version 단위 1 milestone 에 sub-milestone phase 로 통합) 와 v3.x 17 milestone 실 진행 (1-phase ≥ 11/17, RESEARCH 단계 정확 측정) 사이 정량 괴리를 정전화 + 원인 추정 3축 documented + 해결책 후보 PROPOSE 거명. 실 워크플로우 변경 zero (decision-only).",
  "motivation": "사용자 명시 의문 (A_user trigger) — /harness-meta meta 자유 발의 round 안 'milestone 하나에 phase가 1개로 진행되는게 이해가 안 간다'. v3.0_milestones-restructure (2026-05-10) 도입 narrative 와 v3.11~v3.16 누적 6건 lightweight + 1-phase 패턴 사이 괴리가 작업 흐름 자체에서 느껴짐. 본 milestone 은 진단 만 — 정량 데이터 + 원인 분석 + 해결책 거명 → PROPOSE next_candidates. 후속 적용은 별 milestone (v3.6_overengineering-audit 선례 정합).",
  "success_criteria": [
    "v3.0~v3.16 17 milestone phase count 분포 표 작성 (version × phase_count × commit_count × mode lightweight 여부) — RESEARCH.md 안 1차 source",
    "1-phase milestone 비율 정량화 (RESEARCH 정확 측정 후 확정, OPEN 시점 estimate ≥ 11/17 = 64.7%) + lightweight 모드 milestone 비율 정량화 — RESEARCH.md 안 1차 source",
    "원인 추정 3축 documented — (a) § 6.2 default 동결 부작용 (bundling source 메마름) / (b) milestone 입자 자체가 1 commit 가치 작음 / (c) lightweight 모드 누적 동치화. 각 축 evidence + counter-evidence 명시",
    "해결책 후보 ≥3 개 PROPOSE.next_candidates 안 거명 (실 적용 milestone 으로 ROADMAP 등재 0건 — § 6.2 default 동결 정합)",
    "INTENT/RESEARCH/DESIGN/APPROVE artifact 4건 Stage G commit 안 영구 보존 (commit timing (b) default)",
    "pre-commit 14 hook 모두 PASS + 회귀 0 + smoke spec-verification/scope-contract PASS",
    "VERIFY.criteria_check 안 본 success_criteria 6건 1:1 매핑 PASS"
  ],
  "out_of_scope": [
    "워크플로우 자체 변경 (claude/commands/harness-meta.md 본문 수정 0) — 진단 only, 실 적용은 후속 milestone",
    "§ 6.2 동결 정책 본문 변경 (workflow self-improvement 동결 narrative 유지) — 본 milestone 진단 결과가 § 6.2 완화/강화/유지 결정의 input 일 수 있으나, 결정 자체는 후속 milestone",
    "ARCHITECTURE.md § 6.1 bundling era 정의 본문 변경 (1-phase 정당화 narrative 추가 등) — 후속 milestone 사용자 발의 후 별도 진행",
    "smoke 추가/변경 0 — tests/ 디렉토리 touch 없음",
    "v1.x deferred 3건 + v3.6/v3.7 deferred 2건 cycle 3 재평가 진입 — 별 milestone (v3.14 패턴 정합)",
    "5 관점 subagent 검토 — lightweight 모드 정합 (§ 6.2 자기참조 회피 표지)"
  ],
  "dependencies": {
    "input": [
      "projects/meta/ROADMAP.md — v3.0~v3.16 17 milestone entry 본문 (phase count / commit / mode 추출 source)",
      "projects/meta/milestones/v3.0~v3.16/ — 각 milestone REPORT.md / DESIGN.phases (정확 phase 수 cross-check)",
      "projects/meta/ARCHITECTURE.md § 6.1 (bundling era 정의) + § 6.2 (overengineering audit lightweight + 동결 정책)"
    ],
    "downstream": [
      "PROPOSE.next_candidates 안 거명되는 해결책 후보 ≥3 건 — 실 적용은 사용자 명시 발의 (A_user) 후 별 milestone"
    ]
  },
  "mode": "lightweight",
  "self_reference_handling": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지 — 진단 만 + 실 적용 후속 분리)"
}
```

## narrative

본 milestone 은 v3.6_overengineering-audit 의 직접 후속 사례 — workflow self-improvement 본질이나 **진단 만** 진행 (실 적용은 후속 milestone). § 6.2 lightweight 모드 정합.

`out_of_scope` 항목은 **본 milestone 의 negative scope 사실 진술** 만 (v3.10_stage-byproduct-clarification 정책 정합 — 후속 milestone 발의 명령형 표현 금지). 거명된 후속 candidate 는 Stage I (PROPOSE) `next_candidates` 안 통합 흡수.

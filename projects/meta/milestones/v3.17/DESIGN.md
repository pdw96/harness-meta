# DESIGN — v3.17_phase-distribution-audit

```json
{
  "id": "v3.17_phase-distribution-audit",
  "mode": "lightweight",
  "self_reference_policy": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지)",
  "subagent_review_policy": "skipped (lightweight 모드, v3.6/v3.10/v3.13/v3.14 선례 정합)",
  "decisions": [
    {
      "id": "D1",
      "decision": "lightweight 모드 채택 — 5 관점 subagent 검토 생략 + 산출물 LOC cap (총 ~1500 LOC 미만 권고)",
      "rationale": "v3.6_overengineering-audit § 6.2 자기참조 회피 표지 선례 정합. 본 milestone 자체가 workflow self-improvement 본질이므로 표준 모드 (5 관점 subagent) 진행 시 self-improvement 사이클 정면 재진입. v3.10 / v3.13 / v3.14 모두 lightweight 적용 정합.",
      "alternatives_rejected": [
        "표준 모드 (5 관점 subagent 전부 invoke) — self-improvement 사이클 재진입 + § 6.2 도입 의도 위배"
      ]
    },
    {
      "id": "D2",
      "decision": "진단 only (decision-only) — 워크플로우 본문 변경 zero. claude/commands/harness-meta.md / ARCHITECTURE § 6.1 § 6.2 본문 touch 0.",
      "rationale": "INTENT.out_of_scope #1 / #2 / #3 정합. 4 options (A/B/C/D) 분석 결과 자체가 산출물. 실 적용 결정은 후속 milestone (사용자 명시 발의 시) 책임.",
      "alternatives_rejected": [
        "Option B (v4.0 breaking) 본 milestone 안 실 적용 — § 6.2 동결 정면 위배 + era cascade 비용",
        "Option C (§ 6.2 동결 완화) 본 milestone 안 실 적용 — workflow 본문 변경 = 자기참조 사이클 재진입",
        "Option D (narrative 1줄 정정) 본 milestone 안 실 적용 — 진단 결과 종합 후 별 milestone 분리 정합 (v3.6 권고 #1/#4/#6/#7 → 본 milestone 안 실 적용 패턴 정합 가능하나, 사용자 첫 발의 의도 = 진단 only 답변. 실 적용은 별도 결정)"
      ]
    },
    {
      "id": "D3",
      "decision": "4 options (A/B/C/D) 모두 PROPOSE.next_candidates 안 거명만 — ROADMAP 등재 0건",
      "rationale": "§ 6.2 default 동결 권고 정합 (workflow self-improvement 후속 candidate ROADMAP 등재 차단). 사용자 명시 발의 (A_user trigger) 시 만 후속 milestone 진행 — 본 milestone 결과는 평가 source 역할.",
      "alternatives_rejected": [
        "Option A 만 ROADMAP 등재 (가장 보수적) — § 6.2 정합 미충족 (workflow self-improvement 후속 candidate)",
        "Option C 만 ROADMAP 등재 (bundling 본질 복권) — release train 재발 risk + § 6.2 동결 위배"
      ]
    },
    {
      "id": "D4",
      "decision": "phase 분할 = 단일 phase 1 commit (1-phase 패턴 정합)",
      "rationale": "본 milestone 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7건 + milestones.md + execute/phase-1.md = 9 file) 모두 narrative 작성 한 묶음 + 워크플로우 변경 zero. 분할 비효율 (각 산출물이 독립 sub-주제 아님). **자기참조 모순 표지** — '1-phase 70.6% 진단 milestone' 자체가 1-phase = 진단 결과 그대로 도그푸드. 본 모순은 narrative 안 명시 표지 (회피 아님, 의도적 정전화).",
      "alternatives_rejected": [
        "2-phase 분할 (RESEARCH + DESIGN 후 1 commit / VERIFY+REPORT+PROPOSE 후 1 commit) — 단일 산출물 묶음 분할 비효율, 사용자 명시 발의 본질 정합 미충족",
        "3-phase 분할 (v3.6 선례 정합) — v3.6 는 실 적용 3건 (권고 #1 + #4 + #6 + #7) 분할이었으나 본 milestone 은 실 적용 zero"
      ]
    },
    {
      "id": "D5",
      "decision": "INTENT~APPROVE commit timing = (b) Stage G commit 안 포함 (default)",
      "rationale": "v3.1 L6 + v3.11~v3.16 누적 6건 (b) 정합. INTENT/RESEARCH/DESIGN/APPROVE 4건 산출물 + milestones.md + execute/phase-1.md 모두 phase-1 commit 직전 git add → 1 commit 안 통합.",
      "alternatives_rejected": [
        "(a) phase-1 commit 안 포함 — 동치 (본 milestone phase-1 = Stage G commit)",
        "(c) 별도 chore commit — 1-phase milestone 안 split 비효율"
      ]
    },
    {
      "id": "D6",
      "decision": "phase-1 title 확정 — 'v3.17 진단 산출물 통합 작성 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7건 + milestones.md + execute/phase-1.md) + ROADMAP entry status: completed 갱신 + INTENT/ROADMAP cascade 정정 (11→12)'",
      "rationale": "본 milestone 단일 phase 의 실 작업 범위 1:1. milestones.md sub_milestones[0].title placeholder 교체 source. Stage D 완료 직전 의무 step (v3.5 phase-2 도입) 정합.",
      "alternatives_rejected": [
        "더 짧은 title ('v3.17 진단') — 작업 범위 1:1 매핑 약화"
      ]
    },
    {
      "id": "D7",
      "decision": "RESEARCH 단계 발견 drift (OPEN 11/17 → RESEARCH 12/17) 정정 cascade 본 milestone 안 흡수",
      "rationale": "사용자 처음 보고 11/17 = 64.7% 가 정확하지 않음 확인 (v3.4 추가 발견). INTENT.success_criteria #2 + ROADMAP entry summary 본 phase-1 commit 안 정정. R2 risk_mitigation.",
      "alternatives_rejected": [
        "별 milestone 으로 cascade 정정 — overhead"
      ]
    }
  ],
  "approach": "단일 phase 1 commit lightweight 모드. RESEARCH 분포표 정확 측정 + 원인 추정 3축 documented + 4 options 거명만 → PROPOSE.next_candidates 4건. 워크플로우 본문 변경 zero. 본 milestone 자체가 1-phase 패턴 정합 = 진단 결과 도그푸드 (의도적 표지).",
  "phases": [
    {
      "n": 1,
      "title": "v3.17 진단 산출물 통합 작성 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7건 + milestones.md + execute/phase-1.md) + ROADMAP entry status: completed 갱신 + INTENT/ROADMAP cascade 정정 (11→12)",
      "scope": "본 milestone 디렉토리 안 9 file 작성 + projects/meta/ROADMAP.md entry status / summary cascade 정정. 워크플로우 본문 변경 zero, smoke 추가 zero, tests/ touch zero.",
      "affected_files": [
        "projects/meta/milestones/v3.17/INTENT.md (작성됨, drift 정정 적용)",
        "projects/meta/milestones/v3.17/RESEARCH.md (작성됨, 분포표 1차 source)",
        "projects/meta/milestones/v3.17/DESIGN.md (본 파일)",
        "projects/meta/milestones/v3.17/APPROVE.md (Stage E 단계 작성)",
        "projects/meta/milestones/v3.17/VERIFY.md (Stage G 단계 작성)",
        "projects/meta/milestones/v3.17/REPORT.md (Stage H 단계 작성)",
        "projects/meta/milestones/v3.17/PROPOSE.md (Stage I 단계 작성)",
        "projects/meta/milestones/v3.17/milestones.md (작성됨, Stage D 완료 직전 sub_milestones[0].title 교체)",
        "projects/meta/milestones/v3.17/execute/phase-1.md (Stage F 단계 작성)",
        "projects/meta/ROADMAP.md (entry 등재 in_progress + Stage I 완료 시 completed 갱신 + summary cascade 정정)"
      ],
      "rationale": "본 milestone 모든 산출물이 narrative 작성 한 묶음. 분할 비효율 + 자기참조 모순 표지 의도적.",
      "risks": [
        "R1 자기참조 — lightweight 모드 + 진단 only + 워크플로우 변경 zero 3중 차단 표지",
        "R2 drift +1 — 본 phase 안 cascade 정정 흡수",
        "R3 후속 행동 자연 누락 — PROPOSE 안 trigger 조건 narrative 거명",
        "R4 3축 결정적 구분 어려움 — narrative 안 '3축 모두 부분 기여' 표지"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "mitigation": "lightweight 모드 표지 + 진단 only (decision-only) + 워크플로우 본문 변경 zero + 5 관점 subagent 생략 = 4중 자기참조 차단 표지. v3.6 / v3.10 / v3.13 / v3.14 선례 4건 정합."
    },
    {
      "risk_id": "R2",
      "mitigation": "INTENT.success_criteria #2 + ROADMAP entry summary cascade 정정 (11→12, 65%→70.6%) 본 phase-1 commit 안 흡수. RESEARCH.md 가 1차 source."
    },
    {
      "risk_id": "R3",
      "mitigation": "PROPOSE.next_candidates 안 4 options 거명 + trigger 조건 narrative (외부 적용 데이터 + 사용자 명시 발의 AND, v3.6 § 6.2 trigger 조건 정합) 명시. 후속 milestone 발의 자유도 보장."
    },
    {
      "risk_id": "R4",
      "mitigation": "RESEARCH 안 3축 direct evidence + counter-evidence 표 1차 source. 결정적 구분 어려움 = '3축 모두 부분 기여' narrative 정착 정전화. REPORT.lessons_learned 안 lesson 으로 흡수."
    }
  ]
}
```

## narrative

### 자기참조 모순 표지 (도그푸드)

본 milestone 자체가 **1-phase 1 commit lightweight 모드** — 진단 결과 '1-phase 70.6% + lightweight consecutive 7건' 의 정확한 도그푸드. 이 모순은 **회피하지 않고 명시 표지** — 진단 only milestone 의 모든 산출물이 narrative 작성 한 묶음이라 분할 비효율 + § 6.2 자기참조 회피 표지 정합. 본 표지는 REPORT.lessons_learned 안 lesson 으로 흡수.

### Stage D 완료 직전 의무 step (v3.5 phase-2 도입)

`phases[0].title` 확정 (D6) 직후 → `projects/meta/milestones/v3.17/milestones.md` `sub_milestones[0].title` placeholder 교체 의무. 본 DESIGN 작성 직후 Edit 으로 동기 갱신.

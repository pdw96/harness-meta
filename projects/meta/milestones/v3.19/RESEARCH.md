# RESEARCH — v3.19_word-fidelity-audit-v2

```json
{
  "id": "v3.19_word-fidelity-audit-v2",
  "external": [
    {
      "source": "Merriam-Webster Dictionary",
      "topic": "roadmap",
      "findings": "'a detailed plan to guide progress toward a goal' — 목표를 향한 진행을 안내하는 상세 계획",
      "drift_baseline": "forward-looking plan"
    },
    {
      "source": "Oxford English Dictionary",
      "topic": "roadmap",
      "findings": "'a plan or strategy intended to achieve a particular goal' — 특정 목표 달성을 위한 계획 또는 전략",
      "drift_baseline": "forward-looking"
    },
    {
      "source": "Cambridge English Dictionary",
      "topic": "roadmap",
      "findings": "'a plan or strategy for achieving something, especially one showing clearly what the steps involved are' — 단계가 명확히 드러나는 달성 계획",
      "drift_baseline": "step-by-step visibility (forward)"
    },
    {
      "source": "product management 일반 (Pendo / Roadmunk / Aha! 등 표준 컨벤션)",
      "topic": "product roadmap",
      "findings": "시간 축 위에 기능/마일스톤/릴리스를 배치한 시각화 계획. 3 속성: time-bound + goal-oriented + step-by-step visibility",
      "drift_baseline": "time-bound + forward-looking"
    },
    {
      "source": "Merriam-Webster",
      "topic": "open (verb)",
      "findings": "'to make available for entry or passage by moving away barriers'; 'to start (a session/meeting)'; 'to make accessible'",
      "drift_baseline": "시작 / 개방 / accessible 화"
    },
    {
      "source": "Merriam-Webster",
      "topic": "intent (noun)",
      "findings": "'the act or fact of intending : PURPOSE'; 'a usually clearly formulated or planned intention : AIM'",
      "drift_baseline": "의도 / 목적 / AIM"
    },
    {
      "source": "Merriam-Webster",
      "topic": "research (noun/verb)",
      "findings": "'studious inquiry or examination; especially : investigation or experimentation aimed at the discovery and interpretation of facts'",
      "drift_baseline": "체계적 조사 / 사실 발견"
    },
    {
      "source": "Merriam-Webster",
      "topic": "design (verb)",
      "findings": "'to create, fashion, execute, or construct according to plan : DEVISE, CONTRIVE'; 'to conceive and plan out in the mind'",
      "drift_baseline": "계획 / 구성 / DEVISE"
    },
    {
      "source": "Merriam-Webster",
      "topic": "approve (verb)",
      "findings": "'to give formal or official sanction to : RATIFY'; 'to accept as satisfactory'",
      "drift_baseline": "공식 승인 / RATIFY"
    },
    {
      "source": "Merriam-Webster",
      "topic": "execute (verb)",
      "findings": "'to carry out fully : put completely into effect'; 'to do what is provided or required by'",
      "drift_baseline": "carry out / 실행"
    },
    {
      "source": "Merriam-Webster",
      "topic": "verify (verb)",
      "findings": "'to establish the truth, accuracy, or reality of'; 'to confirm or substantiate in law by oath'",
      "drift_baseline": "사실/정확성 확인"
    },
    {
      "source": "Merriam-Webster",
      "topic": "report (verb/noun)",
      "findings": "'to give an account of : RELATE'; 'to make a written record or summary of'; 'to convey information'",
      "drift_baseline": "사실/관찰 결과 진술 / 요약"
    },
    {
      "source": "Merriam-Webster",
      "topic": "propose (verb)",
      "findings": "'to form or put forward a plan or intention'; 'to set before the mind'; 'to set forth for acceptance or rejection'",
      "drift_baseline": "제시 (수용/거부 결정은 외부)"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/milestones/v3.19/INTENT.md (작성 완료)",
      "projects/meta/milestones/v3.19/RESEARCH.md (본 파일)",
      "projects/meta/milestones/v3.19/DESIGN.md (Stage D 작성 예정)",
      "projects/meta/milestones/v3.19/APPROVE.md (Stage E)",
      "projects/meta/milestones/v3.19/execute/phase-1.md (Stage F)",
      "projects/meta/milestones/v3.19/VERIFY.md (Stage G)",
      "projects/meta/milestones/v3.19/REPORT.md (Stage H)",
      "projects/meta/milestones/v3.19/PROPOSE.md (Stage I)",
      "projects/meta/milestones/v3.19/milestones.md (Stage D 단계 sub_milestones 1:1 동기)",
      "projects/meta/ROADMAP.md (v3.19 entry in_progress → completed 갱신)"
    ],
    "untouched_files_explicit": [
      "claude/commands/harness-meta.md (워크플로우 본문) — out_of_scope #1 정합, 변경 zero",
      "projects/meta/ARCHITECTURE.md § 4 (9-stage 정의) / § 6.1 (bundling) / § 6.2 (동결) — 변경 zero",
      "tests/ smoke 모두 — out_of_scope #4 정합, 추가/변경 zero",
      "CHANGELOG.md — Stage I PROPOSE 시점 검토 candidate (별 milestone)",
      "CLAUDE.md (root) / claude/CLAUDE.md / tests/CLAUDE.md / projects/meta/CLAUDE.md — 모듈 가이드 변경 zero"
    ],
    "current_state": {
      "roadmap_entry_count_by_status": {
        "in_progress": 1,
        "completed": 32,
        "deferred": 3,
        "pending": 0,
        "total": 36
      },
      "roadmap_forward_looking_ratio": "0/36 = 0% (pending entry 부재)",
      "roadmap_backward_ratio": "32/36 = 88.9% (completed)",
      "roadmap_frozen_ratio": "3/36 = 8.3% (deferred — v1.4 hook-narrative-separation / v1.4 design-review-trace / v1.5 research-cascade-grep-discipline)",
      "stage_word_fidelity_estimate": {
        "OPEN": "90% — open a milestone 의미 정확. milestones.md skeleton 작성 (v3.4) 은 'initialize' 책임 영역 미세 침범",
        "INTENT": "80% — goal+motivation+success_criteria 정합. out_of_scope (scope 책임) + dependencies (planning 책임) 인접 침범",
        "RESEARCH": "85% — investigation+facts 정합. options pros/cons 분석 (DESIGN 인접) 약한 침범",
        "DESIGN": "80% — 결정+단계 분할 정합. 5 관점 subagent 검토 (review 책임) 침범",
        "APPROVE": "100% 🎯 — 단일 책임 완벽 정합 (사용자 명시 승인)",
        "EXECUTE": "85% — carry out 정합. smoke 회귀 검증 (verify 책임) pre-commit hook 의무로 침범",
        "VERIFY": "95% 🎯 — INTENT.success_criteria ↔ VERIFY.criteria_check 1:1 매핑이 verify 본질 그 자체",
        "REPORT": "90% — backward 종합 정합. v2.0 PROPOSE 분리 효과 정합 (forward 미포함)",
        "PROPOSE": "70% ⚠️ — propose 본질 = 제시만, 결정 외부. 현재 next_candidates 거명 + ROADMAP 등재 실 operation 혼재. register 책임 침범"
      },
      "stage_word_fidelity_average": "(90+80+85+80+100+85+95+90+70) / 9 = 775/9 ≈ 86.1%",
      "highest_fidelity_stage": "APPROVE (100%) — 단일 책임 완벽",
      "lowest_fidelity_stage": "PROPOSE (70%) — register 책임 침범 가장 큼"
    },
    "target_state": {
      "audit_artifact_canonical_source": "DESIGN.md (decisions[] 안 부합도 점수 + drift 본질 + root cause 공유 narrative)",
      "roadmap_text_change": "v3.19 entry status: in_progress → completed (Stage I 시점, summary 갱신 포함)",
      "workflow_body_change_count": 0,
      "smoke_change_count": 0
    }
  },
  "options": [
    {
      "option_id": "A",
      "title": "진단만 (lightweight, v3.17 패턴) — Stage A OPEN 시점 사용자 채택",
      "approach": "9-stage 부합도 정량 진단 + ROADMAP-PROPOSE root cause 공유 narrative 정전화. 워크플로우 본문 변경 zero, smoke 변경 zero. 후속 candidate 거명만 (§ 6.2 default 동결 정합). lightweight 모드 (5 관점 subagent 생략, 1 phase 1+1 commit).",
      "pros": [
        "v3.17 (1-phase 진단) + v3.18 (Option A narrative 정전화) 패턴 정합 — lightweight 누적 7/19 = 36.8% (자기참조 모순 표지)",
        "§ 6.2 default 동결 정합 — workflow self-improvement 본질이지만 진단 산출물만",
        "토큰 효율 우선 (v3.18 lesson L3 정합) — INTENT~PROPOSE 산출물 LOC cap (~800)",
        "도그푸드 정합 — 진단 자체가 자기참조 검토 (v3.17 패턴 두 번째 적용)"
      ],
      "cons": [
        "실 drift 해소 없음 — 후속 milestone 까지 차이 누적",
        "ROADMAP-PROPOSE 책임 모호 그대로 유지 — drift narrative 만 정전화"
      ]
    },
    {
      "option_id": "B",
      "title": "PROPOSE drift 실 변경 (10-stage REGISTER 단계 신설)",
      "approach": "PROPOSE 의 'register' 책임 (ROADMAP 등재 실 operation) 을 신규 REGISTER 단계로 분리 — 9-stage → 10-stage. claude/commands/harness-meta.md 본문 변경. breaking change → v4.0.",
      "pros": [
        "PROPOSE 단어-책임 부합도 70% → ~100% 회복 가능",
        "사전적 정의 완벽 부합 — propose = 제시, register = 등재 책임 분리"
      ],
      "cons": [
        "v2.0_workflow-word-fidelity 의 9-stage 안정성 18일만에 깨짐 — 워크플로우 3회 major bump (v2/v3/v4)",
        "외부 적용 (upbit v1.x 14건) 모두 9-stage 기반 — 마이그레이션 cost",
        "§ 6.2 동결 정책 강한 대상 — workflow self-improvement 본질 + 외부 적용 데이터 기반 정량 evidence 부재"
      ]
    },
    {
      "option_id": "C",
      "title": "ROADMAP 재정의 실 변경 (forward-looking 회복 또는 명명 변경)",
      "approach": "(c1) pending entry 다수 등재 + completed CHANGELOG 이관 (forward-looking 회복) 또는 (c2) ROADMAP.md → MILESTONES.md / LEDGER.md 재명명 (현 실 역할 반영). breaking change.",
      "pros": [
        "ROADMAP 단어-사전 정의 부합 회복 (c1) 또는 단어-역할 부합 (c2)",
        "CHANGELOG.md 와 책임 중복 해소"
      ],
      "cons": [
        "§ 6.2 default 동결 정합 정책 자체와 충돌 — pending 등재 회피가 default ↔ pending 다수 등재 (c1) 모순",
        "MILESTONES.md 명명 변경 (c2) 은 모든 cross-ref host (~10곳) cascade 필요 — breaking change",
        "외부 적용 데이터 기반 정량 evidence 부재"
      ]
    },
    {
      "option_id": "D",
      "title": "narrative 정전화 (drift 수용)",
      "approach": "ARCHITECTURE.md 안 word-fidelity drift 수용 narrative paragraph 추가 — drift 의 의도성 / pragmatic 절충 정전화. 변경 없음 (산출물만 정전화). v3.18 패턴 정합 (단일 source narrative).",
      "pros": [
        "v3.18 패턴 정확 정합 — 진단 후 narrative 정전화 자연 후속",
        "외부 visible artifact (ARCHITECTURE.md) 안 drift 자기 진단 결과 영구 정전화",
        "lightweight 모드 정합 — 변경 ~1 paragraph"
      ],
      "cons": [
        "본 milestone (v3.19) 자체가 진단만 — 별 milestone (v3.20+) 가 narrative 정전화 더 자연 (PROPOSE 분리 책임 정합)",
        "옵션 A 와 책임 겹침 — 옵션 A 안 narrative 정전화 포함 ↔ 별 milestone 분리"
      ]
    }
  ],
  "risks_identified": [
    {
      "risk_id": "R1",
      "risk": "RESEARCH.options 자체가 PROPOSE 책임 침범 (decision-narrowing) — 후속 옵션 4건 raw 분석으로 결정 narrowing risk",
      "severity": "낮음",
      "mitigation": "DESIGN.decisions 안 채택 옵션 명시 + 비채택 alternatives_rejected 안 옵션 B/C/D 명시. options pros/cons 는 raw 분석만 (v3.10 RESEARCH options 부산물 정책 정합)"
    },
    {
      "risk_id": "R2",
      "risk": "lightweight 모드 5 관점 subagent 생략 → architecture / scope contract 검토 누락 risk",
      "severity": "낮음",
      "mitigation": "v3.6 / v3.10 / v3.13 / v3.14 / v3.17 / v3.18 누적 6/18 검증된 lightweight 패턴 정합. 진단만 + 산출물 변경 zero → 회귀 risk 본질적 부재. self_reference_policy: avoid 표지 명시"
    },
    {
      "risk_id": "R3",
      "risk": "옵션 A 채택 narrative 가 v3.18 Option A 패턴 (narrative 정전화) 와 책임 겹침 → 본 milestone 진단 → 후속 narrative milestone 자연 분리 모호 risk",
      "severity": "중간",
      "mitigation": "Stage I PROPOSE 안 v3.X_drift-narrative-canonicalization 후속 candidate 거명 (§ 6.2 동결 정합) — 본 milestone 은 진단만 (옵션 D 차원 narrative 변경 zero)"
    },
    {
      "risk_id": "R4",
      "risk": "ROADMAP-PROPOSE root cause 공유 진단 narrative 가 'register' 책임 분리 발의 (옵션 B) trigger 로 해석 risk",
      "severity": "낮음",
      "mitigation": "DESIGN.decisions 안 옵션 B 채택 아님 명시 + § 6.2 동결 trigger 미충족 narrative + Stage I PROPOSE 후속 candidate 거명만"
    },
    {
      "risk_id": "R5",
      "risk": "본 milestone 자체가 lightweight 모드 누적 7/19 = 36.8% — '자기참조 모순 표지' 의도 vs '워크플로우 진단 동결 정책 위반' 해석 충돌 risk",
      "severity": "낮음",
      "mitigation": "v3.17 / v3.18 lessons (lightweight 누적 동치화 narrative) 정합 — 진단만 + 사용자 명시 발의 (A_user) 충족 = § 6.2 정합"
    }
  ]
}
```

## narrative

본 RESEARCH 는 **lightweight 모드 정합** — external 13건 (사전 4 source + Merriam-Webster 9 stage 정의) + codebase 정량 측정 + options 4건 raw 분석 (DESIGN 안 채택은 옵션 A) + risks 5건.

`codebase.current_state` 안 부합도 점수는 **추정** (사용자 발의 검토 결과 그대로 정량화) — DESIGN.decisions 안 최종 채택. options pros/cons 도 raw 분석만 (v3.10 부산물 정책 정합, PROPOSE 단계 결정 narrowing 회피).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- milestones.md: [`milestones.md`](milestones.md)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.19)
- v2.0 word-fidelity 1차: [`../v2.0_workflow-word-fidelity/RESEARCH.md`](../v2.0_workflow-word-fidelity/RESEARCH.md)
- § 6.2 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)

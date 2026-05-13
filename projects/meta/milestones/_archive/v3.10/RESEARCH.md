# RESEARCH — v3.10 stage-byproduct-clarification

```json
{
  "id": "stage-byproduct-clarification",
  "external": [
    {
      "source": "v2.0_workflow-word-fidelity (내부 spec)",
      "topic": "단어 = 단일 책임 1:1 매핑 원칙",
      "findings": "OPEN/INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 9 stage 각 단어가 단일 책임에 1:1 매핑되도록 정정. PLAN→INTENT (의도만), DESIGN→ approach+decisions+phases (3 책임 통합 후 APPROVE/PROPOSE 분리). 후속 발의 (forward propose) 는 PROPOSE 단어의 단일 책임.",
      "drift": "운영 안 INTENT.out_of_scope / RESEARCH.untouched_files_explicit / DESIGN.decisions[i] 가 후속 milestone 명명 표현을 포함하여 PROPOSE 단어 책임 침범. v3.6/v1.4 실 사례 3건 정량 확인."
    },
    {
      "source": "v3.6_overengineering-audit § 6.2 동결 정책",
      "topic": "workflow self-improvement 동결 + A_user trigger 예외 경로",
      "findings": "workflow 자체 변경은 default 동결. evidence-base trigger (외부 적용 정량 데이터) 또는 A_user (사용자 명시 발의) 만 예외 경로.",
      "drift": "본 milestone 자체가 § 6.2 A_user 예외 경로 첫 사용 사례 — INTENT.dependencies 명시 의무 충족."
    }
  ],
  "codebase": {
    "affected_files": [
      "claude/commands/harness-meta.md (Stage B/C/D/I 정의 표 + 본문 narrative 보강)",
      "projects/meta/ARCHITECTURE.md § 4 9-stage workflow 섹션 line ~108-115 (cascade narrative 1줄 이상)",
      "projects/meta/milestones/v3.10/* (본 milestone 산출물 7~9건)"
    ],
    "untouched_files_explicit": [
      "claude/hooks/* (hook 변경 부재 — 사실 진술, 본 milestone 책임 외)",
      "claude/statusline/* (statusline 변경 부재 — 사실 진술)",
      "tests/* (smoke 변경 부재 — 범위 Y 채택 결과, 사실 진술)",
      "bootstrap/skills/* (skill 변경 부재 — 사실 진술)",
      "projects/meta/milestones/v3.6/INTENT.md (침범 사례 1, retroactive 정리 부재 — 사실 진술, historical 보존)",
      "projects/meta/milestones/v3.6/DESIGN.md (침범 사례 2, retroactive 정리 부재 — 사실 진술, historical 보존)",
      "projects/meta/milestones/v1.4_cross-ref-propagation/RESEARCH.md (침범 사례 3, retroactive 정리 부재 — 사실 진술, historical 보존)"
    ],
    "current_state": "claude/commands/harness-meta.md Stage B 정의 line 118 = 'out_of_scope (명시적 제외 list)' — (a) negative scope 사실 진술 vs (b) 후속 발의 의미 미분리. Stage C 정의 line 131-132 = 'codebase (affected_files, untouched_files, current_state, target_state)' — untouched_files 의 후속 발의 의미 미분리. Stage D 정의 line 146 = 'decisions (decision/rationale/alternatives_rejected)' — rationale 의 후속 발의 의미 미분리. Stage I 정의 line 249 = 'next_candidates (id/title/trigger/trigger_type list)' — B/C/D 부산물의 통합 흡수 책임 narrative 부재. ARCHITECTURE.md § 4 line ~108-115 단어-책임 매핑 표는 stage 별 단어 책임만, (a)/(b) 의미 분리 narrative 부재.",
    "target_state": "Stage B/C/D 정의에 (a) negative scope/사실 진술/본 결정 vs (b) 후속 발의 의미 분리 narrative 추가 + 후속 발의 표현은 PROPOSE 단어 책임 명시. Stage I 정의에 B/C/D 부산물 통합 흡수 narrative 추가 (next_candidates 단일 origin 강제). ARCHITECTURE.md § 4 단어-책임 표 직후 cross-ref 1줄 ('B/C/D 부산물의 PROPOSE 흡수 narrative: claude/commands/harness-meta.md Stage B/C/D/I 정의 참조')."
  },
  "options": [
    {
      "option": "Y1. Stage B/C/D 정의만 보강 (Stage I 미변경)",
      "pros": ["산출 LOC 최소", "Stage I 책임은 이미 정의에 'next_candidates ROADMAP 등록' 명시되어 흡수 책임 implicit"],
      "cons": ["통합 흡수 narrative explicit 부재 → 작성자 재량 가능 → drift 재발생 risk", "single source 명료성 저하"]
    },
    {
      "option": "Y2. + Stage I PROPOSE 통합 흡수 narrative (Recommended)",
      "pros": ["B/C/D 부산물 → PROPOSE next_candidates 흡수 경로 single source explicit", "drift 재발 방지 narrative 강화", "self-documenting"],
      "cons": ["Stage I 정의 본문 추가 LOC ~5줄 (cap 무관)"]
    },
    {
      "option": "Y3. + ARCHITECTURE.md § 4 cascade",
      "pros": ["§ 4 9-stage 표 cascade 1줄 추가 — 정전 single source 정합", "외부 reader (AGENTS.md 등) 단일 진입"],
      "cons": ["cascade 1 host 추가, smoke-cross-ref autofix 자동 처리 가능"]
    }
  ],
  "risks_identified": [
    {"id": "R1", "risk": "narrative 보강 자체가 또 다른 자기참조 사이클 진입 (workflow self-improvement)", "severity": "low", "mitigation": "v3.6 § 6.2 A_user trigger 예외 경로 + lightweight 모드 (subagent 검토 생략 또는 축소) 적용"},
    {"id": "R2", "risk": "본 milestone 자체 도그푸드 위반 — INTENT.out_of_scope / DESIGN.phase[scope] 안 'PROPOSE.md next_candidates 발의' 표현 사용 (재귀 침범)", "severity": "medium", "mitigation": "INTENT.success_criteria #7 (도그푸드 명시) + VERIFY 단계 grep 검증"},
    {"id": "R3", "risk": "cascade 누락 — ARCHITECTURE.md § 4 갱신 미적용 → drift", "severity": "low", "mitigation": "Y3 옵션 채택 + smoke-cross-ref autofix"},
    {"id": "R4", "risk": "narrative 보강이 실제 운영 안 가치 발휘 부재 (외부 적용 정량 데이터 없이 발의)", "severity": "medium", "mitigation": "REPORT.lessons_learned 안 명시, 향후 milestone 작성 시 본 narrative 적용 여부 정량 측정 (예: v3.11+ 산출물 안 침범 표현 부재 정량 카운트)"},
    {"id": "R5", "risk": "Stage I 통합 흡수 narrative 추가 시 next_candidates 의 다른 origin (사용자 발의 = A_user trigger) 과의 관계 모호", "severity": "low", "mitigation": "Stage I narrative 안 'B/C/D 부산물 통합 흡수 + A_user 직접 발의 dual origin' 명시"}
  ]
}
```

## 비고

본 RESEARCH.md 70줄 (lightweight cap < 150줄 정합). external source 는 내부 spec (v2.0 / v3.6) 만 — 외부 spec 부재 (workflow 정의는 메타 고유). codebase.untouched_files_explicit 7건 모두 사실 진술 (후속 milestone 명명 표현 부재, 도그푸드).

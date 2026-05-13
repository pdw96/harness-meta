# INTENT — v3.18_option-a-natural-adaptation-narrative

```json
{
  "id": "v3.18_option-a-natural-adaptation-narrative",
  "title": "Option A — 1-phase milestone era 정합 narrative 정착 (ARCHITECTURE § 6.1 + CLAUDE.md cross-ref)",
  "goal": "v3.17_phase-distribution-audit 진단 결과 (1-phase 12/17 = 70.6%, v3.7~v3.16 100% 1-phase, sub_milestones_meaningful = no 12/17) 정합 narrative 1줄 정전화 — '1-phase milestone 도 v3.0+ 9-stage-bundled era 정합, sub_milestones[] listing 이 1 entry 라도 narrative 1차 source 책임 충족'. ARCHITECTURE § 6.1 본문 + 필요 시 모듈 CLAUDE.md cross-ref. 워크플로우 절차 본문 변경 zero, smoke 변경 zero.",
  "motivation": "사용자 명시 발의 (A_user trigger) — /harness-meta meta 라운드 'Option A 진행해줘' 명시 선택. v3.17 PROPOSE.next_candidates Option A 직접 후속. v3.0 도입 narrative ('같은 의미 단위 후속 candidates 를 version 단위 1 milestone (sub-milestone phase 매핑) 으로 통합') 와 v3.7~v3.16 실 진행 (1-phase 100%) 사이 정량 괴리가 era 정의 narrative 명료화 부재로 stale 상태. 본 milestone 은 narrative 1줄 추가 — era 의미 재정의 (Option B v4.0 breaking) 아닌 현 실 운용 자연 적응 정전화.",
  "success_criteria": [
    "ARCHITECTURE § 6.1 본문에 1-phase milestone 정합 narrative 1줄 추가 — 본 milestone 진행 결과 검증 가능 (grep '1-phase milestone' projects/meta/ARCHITECTURE.md)",
    "narrative 정확 문구 = '1-phase milestone (sub_milestones[] 1 entry) 도 본 era 정합 — sub_milestones[] 가 1 entry 라도 milestones.md 가 narrative 1차 source 책임 충족. 본 era 의 phase 다중 통합 의도는 같은 의미 단위 후속 candidates 가 ≥2 건일 때 자연 활용, 단일 후속 시 1-phase 정전화' 또는 동치 의미 (RESEARCH 단계 정확 위치 + 정확 문구 확정)",
    "필요 시 CLAUDE.md / projects/meta/CLAUDE.md / claude/commands/harness-meta.md cross-ref 1줄 (RESEARCH 단계 결정) — 신 narrative 정의 host 가 ARCHITECTURE § 6.1 single source 정합 유지",
    "워크플로우 절차 본문 변경 zero — claude/commands/harness-meta.md Stage A~I 절차 / ARCHITECTURE § 6.2 동결 정책 / tests/ smoke 추가 zero (INTENT.out_of_scope #1~#4)",
    "INTENT/RESEARCH/DESIGN/APPROVE artifact 4건 phase-1 commit 안 영구 보존 (commit timing (b) 정합, v3.17 lesson L4 = (b)/(c) 실 동치 운용)",
    "pre-commit 14 hook 모두 PASS + 회귀 0 + smoke spec-verification/scope-contract/bundle-trigger 모두 PASS",
    "VERIFY.criteria_check 안 본 success_criteria 7건 1:1 매핑 PASS"
  ],
  "out_of_scope": [
    "워크플로우 절차 본문 변경 (claude/commands/harness-meta.md Stage A~I 절차 / Stage F 선결 조건 / commit timing 3 패턴 narrative 갱신 등) — Option B/C/D 영역, 본 milestone Option A 한정",
    "ARCHITECTURE § 6.2 동결 정책 본문 변경 (workflow self-improvement 동결 narrative 유지) — Option C 영역",
    "milestones.md 신 필드 추가 또는 smoke 신 검증 추가 — narrative 1줄 추가 한정 본질",
    "tests/ touch zero (smoke 추가 / 변경 / inactive 정리 등)",
    "ARCHITECTURE § 6.1 본문 외 era 정의 본문 변경 (예: § 3 working definition / § 4 9-stage 표 갱신) — narrative 1줄 cross-ref 한정",
    "5 관점 subagent 검토 — lightweight 모드 정합 (v3.6/v3.10/v3.13/v3.14/v3.17 선례 5건)"
  ],
  "dependencies": {
    "input": [
      "v3.17_phase-distribution-audit RESEARCH 분포표 (1-phase 12/17 = 70.6% 정량) + REPORT.lessons_learned L1 (1-phase era 정합 narrative implication) + PROPOSE.next_candidates Option A",
      "projects/meta/ARCHITECTURE.md § 6.1 (bundling era 정의 본문 — narrative 추가 대상 host)",
      "projects/meta/CLAUDE.md + CLAUDE.md root + claude/commands/harness-meta.md (cross-ref 후보 host)"
    ],
    "downstream": [
      "후속 milestone 발의 시 본 narrative cross-ref 가능 — 1-phase milestone 정합 narrative 안정화"
    ]
  },
  "mode": "lightweight",
  "self_reference_handling": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지) — 본 milestone 자체 1-phase 1+1 commit 도그푸드 정합 (v3.17 lesson L6 패턴)"
}
```

## narrative

v3.17 PROPOSE.next_candidates Option A 직접 후속. narrative 1줄 추가 = era 의미 자연 적응 정전화. workflow 절차 변경 zero + smoke 변경 zero + § 6.2 동결 정책 유지.

`out_of_scope` 항목 = 본 milestone negative scope 사실 진술 만 (v3.10 정책 정합) — 후속 발의 명령형 표현 부재.

# INTENT — v3.10 stage-byproduct-clarification

```json
{
  "id": "stage-byproduct-clarification",
  "title": "9-stage stage 영역 침범 narrative 명료화 — INTENT/RESEARCH/DESIGN 부산물 정의 + PROPOSE 흡수 책임",
  "goal": "9-stage workflow 의 단어 = 단일 책임 1:1 매핑 (v2.0_workflow-word-fidelity) 원칙 운영 안 영역 침범 3건 확정 → claude/commands/harness-meta.md Stage B/C/D 정의를 보강하여 out_of_scope / untouched_files_explicit / decisions[i] 의 (a) negative scope 사실 진술 vs (b) 후속 발의 의미를 narrative 로 분리 + PROPOSE 통합 흡수 책임 명문화.",
  "motivation": "사용자 발의 (현 세션, 2026-05-11) — 'pending 후보가 왜 자동 등재되는지' 의문에서 시작하여 각 stage 가 다른 stage 의 책임을 침범하고 있다는 진단. 정량 확인 3건: (1) projects/meta/milestones/v3.6/INTENT.md L19~21 의 out_of_scope entry 가 '별 milestone 분리' 라는 forward propose 표현 명시 (PROPOSE 책임 침범), (2) projects/meta/milestones/v3.6/DESIGN.md L65 phase-3 scope 가 'PROPOSE.md next_candidates 안 ... 발의 narrative' 로 PROPOSE 책임 직접 거명, (3) v1.4_cross-ref-propagation RESEARCH.untouched_files_explicit 6건 묶음이 v1.5_legacy-narrative-cleanup 으로 직접 발의 (RESEARCH 단계가 후속 milestone 명명). v2.0_workflow-word-fidelity 의 '단어 = 단일 책임 1:1 매핑' 원칙 위배. 옵션 A (자연 부산물로 재해석) 채택 — B/C/D 의 부산물은 본 stage 책임 안 정당, 단 후속 발의 표현은 PROPOSE 가 단일 origin 으로 통합 흡수.",
  "success_criteria": [
    "claude/commands/harness-meta.md Stage B (INTENT) 정의 안 out_of_scope 가 (a) negative scope 사실 진술 vs (b) 후속 발의 의미를 분리하는 narrative 1 row 이상 추가 (후속 발의 표현 금지 명시)",
    "claude/commands/harness-meta.md Stage C (RESEARCH) 정의 안 untouched_files_explicit / risks_identified 가 (a) 사실 진술 vs (b) 후속 발의 의미를 분리하는 narrative 1 row 이상 추가",
    "claude/commands/harness-meta.md Stage D (DESIGN) 정의 안 decisions[i].rationale / phases[n].scope 가 (a) 본 milestone 결정 vs (b) 후속 발의 명명 의미를 분리하는 narrative 1 row 이상 추가",
    "claude/commands/harness-meta.md Stage I (PROPOSE) 정의 안 B/C/D 부산물의 통합 흡수 책임 명문화 narrative 추가 — next_candidates 단일 origin 강제",
    "projects/meta/ARCHITECTURE.md § 4 9-stage 섹션 cascade — 각 stage 단어 = 단일 책임 매핑 narrative 의 (a)/(b) 의미 분리 cross-ref 1줄 이상",
    "pre-commit 14 hook 모두 PASS, 회귀 0",
    "본 milestone 자체 도그푸드 — 본 INTENT.out_of_scope 안 '별 milestone 분리' 표현 부재 + DESIGN.phase[scope] 안 'PROPOSE.md next_candidates 발의' 표현 부재 (재귀 회피)"
  ],
  "out_of_scope": [
    "smoke 차단 hook 신규 추가 — 범위 Y (narrative 명료화만) 채택, smoke grep 차단은 범위 Z 의 영역으로 본 milestone scope 외 (재귀 회피 도그푸드)",
    "기존 milestone 산출물 retroactive 정리 (v3.6 / v1.4 등 침범 사례 본문 교정) — narrative 보강 후 미래 작성분에 적용, 과거 산출물은 historical 보존",
    "9-stage trim / 5 관점 trim / 4 era forward migration — breaking change, 본 milestone scope 외 사실 진술 (v3.6 PROPOSE v4.0_breaking-change-candidates catalog 안 거명 상태 유지)",
    "ARCHITECTURE.md § 6.2 동결 정책 자체의 정정 — 본 milestone 은 § 6.2 A_user trigger 예외 경로 사용 사례이며, § 6.2 정책 정전 자체는 본 milestone scope 외"
  ],
  "dependencies": {
    "prior": [
      "v2.0_workflow-word-fidelity — '단어 = 단일 책임 1:1 매핑' 원칙 정의 (정정 대상 원칙)",
      "v3.6_overengineering-audit — § 6.2 동결 정책 + lightweight 모드 선례 (본 milestone 도 lightweight 모드 candidate)"
    ],
    "section_6_2_exception": "본 milestone = workflow self-improvement 카테고리 (claude/commands/harness-meta.md 변경). ARCHITECTURE.md § 6.2 'workflow self-improvement 동결 정책' 적용 대상이나, A_user trigger (사용자 명시 발의, 2026-05-11 현 세션) 예외 경로 부합. evidence-base trigger 는 외부 적용 정량 데이터 (upbit 등) 부재이나, 내부 정량 진단 (현 세션 영역 침범 3건 확정 — v3.6 INTENT.out_of_scope L19~21 / v3.6 DESIGN.phase-3 / v1.4 RESEARCH.untouched_files) 기반 사용자 명시 결정 (옵션 A 채택). v3.6 § 6.2 정합 — 동결 default 권고 유지하되 A_user trigger 예외 경로 첫 사용 사례.",
    "successor": null
  }
}
```

## 비고

본 INTENT.md 51줄 (lightweight cap < 80줄 정합). 도그푸드 — out_of_scope entry 4건 모두 negative scope 사실 진술만, 후속 milestone 명명 표현 부재. dependencies.section_6_2_exception narrative 명시 의무 충족.

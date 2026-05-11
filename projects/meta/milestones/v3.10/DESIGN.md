# DESIGN — v3.10 stage-byproduct-clarification

```json
{
  "id": "stage-byproduct-clarification",
  "decisions": [
    {
      "id": "D1",
      "decision": "옵션 Y2 채택 — Stage B/C/D 정의 보강 + Stage I PROPOSE 통합 흡수 narrative 추가",
      "rationale": "RESEARCH options Y1 (Stage I 미변경) 은 통합 흡수 narrative explicit 부재로 drift 재발 risk. Y2 는 single source 명료성 확보. Y3 (ARCHITECTURE.md § 4 cascade) 도 흡수 — D4 별 결정.",
      "alternatives_rejected": ["Y1 — implicit 흡수 narrative drift risk", "X (Stage B/C/D 만, Stage I 미변경 + cascade 부재) — 최소 보강이나 drift 재발 risk", "Z (smoke 차단 추가) — 사용자 범위 Y 결정 정합, 재귀 회피"]
    },
    {
      "id": "D2",
      "decision": "lightweight 모드 적용 — 5 관점 subagent 검토 생략",
      "rationale": "v3.6_overengineering-audit 선례 (자기참조 회피 표지). 본 milestone = workflow self-improvement 카테고리, § 6.2 A_user trigger 예외 경로. 5 관점 subagent 검토 자체가 자기참조 사이클 재진입 risk. scope 작음 (≤5 파일) + narrative-only 변경.",
      "alternatives_rejected": ["3 관점 subagent 검토 (scope 작음 default) — 자기참조 사이클 재진입 risk", "4 관점 (회귀 risk 추가) — scope 정합 부재"]
    },
    {
      "id": "D3",
      "decision": "1 phase 1 commit",
      "rationale": "narrative-only 변경, 의미 단위 단일 (영역 침범 명료화), scope 작음. v3.5 lessons 안 '의미 단위 1 phase 1 commit' 권고 정합.",
      "alternatives_rejected": ["2 phase (harness-meta narrative + ARCHITECTURE cascade 분리) — 의미 단위 단일성 위배"]
    },
    {
      "id": "D4",
      "decision": "ARCHITECTURE.md § 4 9-stage 표 직후 cross-ref 1줄 추가 (Y3 흡수)",
      "rationale": "정전 single source 정합 — § 4 stage 정의 표를 본 narrative 단일 진입점으로. AGENTS.md / 외부 reader 도 § 4 진입 시 cross-ref 1줄 확인.",
      "alternatives_rejected": ["cascade 부재 — single source drift risk", "AGENTS.md 동시 갱신 — 영문 cascade 는 본 milestone scope 외 (정량 가치 부재)"]
    },
    {
      "id": "D5",
      "decision": "본 milestone 자체 도그푸드 — phase[scope] / decisions[i].rationale / out_of_scope 안 후속 발의 명령형 표현 회피",
      "rationale": "v3.10 의 핵심 narrative (B/C/D 부산물 → PROPOSE 흡수, 후속 발의는 PROPOSE 단일 origin) 자체가 본 milestone 산출물 안에서도 적용되어야 self-consistent. VERIFY 단계 grep 검증 (success_criteria #7).",
      "alternatives_rejected": ["도그푸드 미적용 — self-inconsistent narrative"]
    },
    {
      "id": "D6",
      "decision": "기존 milestone (v3.6 / v1.4) 침범 사례 retroactive 정리 부재",
      "rationale": "INTENT.out_of_scope #2 정합. historical 보존 — narrative 보강은 미래 작성분에 적용. 과거 산출물 정정은 가치 부재 + historical drift.",
      "alternatives_rejected": ["v3.6 INTENT.out_of_scope L19~21 표현 정정 — historical 보존 위배"]
    }
  ],
  "approach": "claude/commands/harness-meta.md Stage B/C/D/I 정의 본문 4곳에 (a) 사실 진술/negative scope/본 결정 vs (b) 후속 발의 의미 분리 narrative 추가 (각 5~10줄 cap) + Stage I 정의 본문에 B/C/D 부산물 통합 흡수 narrative 추가 (next_candidates 단일 origin 명시, A_user 직접 발의 dual origin 보충) + projects/meta/ARCHITECTURE.md § 4 9-stage 표 직후 cross-ref 1줄 → 단일 commit. 5 관점 subagent 검토 생략 (v3.6 lightweight 선례). 본 milestone 산출물 자체 도그푸드 — 후속 발의 명령형 표현 회피.",
  "phases": [
    {
      "n": 1,
      "title": "Stage B/C/D/I 정의 narrative 보강 + ARCHITECTURE § 4 cascade",
      "scope": "claude/commands/harness-meta.md Stage B/C/D/I 4곳 정의 본문 narrative 추가 (각 5~10줄) + projects/meta/ARCHITECTURE.md § 4 9-stage 표 직후 cross-ref 1줄 + execute/phase-1.md 기록",
      "affected_files": [
        "claude/commands/harness-meta.md",
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/milestones/v3.10/execute/phase-1.md"
      ],
      "rationale": "narrative-only, 의미 단위 단일 (영역 침범 명료화), scope 작음 — 1 phase 1 commit 합리적",
      "risks": [
        "markdownlint 경고 가능 (mitigation: pre-commit auto-fix)",
        "cascade 누락 risk (mitigation: 본 phase 안 ARCHITECTURE.md 동시 갱신)",
        "narrative LOC 초과 risk (mitigation: 각 stage 정의 안 narrative < 10줄 cap)"
      ]
    }
  ],
  "risk_mitigation": {
    "R1": "lightweight 모드 (D2) + § 6.2 A_user 예외 경로 (INTENT.dependencies 명시)",
    "R2": "INTENT.success_criteria #7 + D5 도그푸드 결정 + VERIFY grep 검증",
    "R3": "D4 cascade 결정 + phase-1 안 ARCHITECTURE 동시 갱신 + smoke-cross-ref autofix",
    "R4": "REPORT.lessons_learned 명시 + 정량 측정 plan (v3.11+ 산출물 안 침범 표현 부재 카운트, 본 milestone scope 외)",
    "R5": "Stage I narrative 안 'B/C/D 부산물 통합 흡수 + A_user 직접 발의' dual origin 명시"
  },
  "expected_loc_cap": {
    "DESIGN.md": "약 100줄 (lightweight cap < 200줄 정합)",
    "APPROVE.md": "< 40줄",
    "execute/phase-1.md": "< 80줄",
    "VERIFY.md": "< 100줄",
    "REPORT.md": "< 100줄",
    "PROPOSE.md": "< 80줄",
    "claude/commands/harness-meta.md 추가 narrative": "총 < 50줄 (4 stage × ~10줄)",
    "projects/meta/ARCHITECTURE.md cascade": "1줄"
  }
}
```

## 5 관점 검토 결과 (lightweight 모드 — 생략)

v3.6_overengineering-audit 선례 정합 — 본 milestone scope 작음 (≤5 파일, narrative-only) + workflow self-improvement § 6.2 자기참조 회피 표지. 5 관점 subagent 검토 생략 (architecture / spec-drift / scope contract 의 self-check 만 본 DESIGN.md 안 narrative 로 흡수).

**Self-check (architecture)**: 변경 host 2 파일 (`claude/commands/harness-meta.md` Stage B/C/D/I 정의 본문 + `projects/meta/ARCHITECTURE.md` § 4 표 직후). 디렉토리 구조 변경 부재. ✅ pass.

**Self-check (spec-drift)**: 외부 spec 부재 (workflow 정의는 메타 고유). 내부 spec (v2.0_workflow-word-fidelity 원칙) 정합 — 본 milestone 이 원칙 운영 narrative 보강. ✅ pass.

**Self-check (scope contract)**: INTENT.success_criteria 7건 ↔ DESIGN.phases[0] 매핑 — phase-1 의 affected_files + scope narrative 가 success_criteria #1~#5 직접 cover, #6 (pre-commit 14 hook) 은 VERIFY 단계, #7 (도그푸드) 은 D5 결정 + VERIFY grep. ✅ pass.

## 비고

본 DESIGN.md 약 92줄 (lightweight cap < 200줄 정합). 도그푸드 — phases[0].scope / decisions[i].rationale 안 'PROPOSE.md next_candidates 발의' 명령형 표현 부재 ('narrative 추가' / '정의 보강' / '단일 origin 명시' 등 사실 진술/본 결정 표현만).

# DESIGN — v1.4_infra-minimization

PLAN.success_criteria + RESEARCH.options Option A 채택. 3 phase 분할.

```json
{
  "id": "v1.4_infra-minimization",
  "decisions": [
    {
      "id": "D1",
      "decision": "RESEARCH.options Option A (보수적 슬림화 + 매트릭스 정전화) 채택",
      "rationale": "사용자 PLAN 분기 (Verification 인프라 슬림화 + 분류 정전화) + RESEARCH 의향 (Option A) 1:1. RESEARCH '핵심 발견 요약' 전체 — narrative 우위 가 이미 cross-ref 패턴 8 host 에 내재되어 있어 매트릭스 (c) 표기만 lag, drift 항목 (legacy 2건) 단순 제거 + tests/CLAUDE.md 명시 강화 만으로 '정전화 = narrative 1차 source 명문화' 가 자연 도출. 단일 책임 + 회귀 최소.",
      "alternatives_rejected": [
        "Option B (적극적 슬림화) — RESEARCH R5/R6 책임 중복 정밀 감사 부담 + verify.ps1/sh slim 시 onboarding 자가 검증 약화 risk. 단일 책임 위반.",
        "Option C (분류 갱신 only) — 사용자 PLAN 분기에서 거부됨, success_criteria #1~#5 미충족."
      ]
    },
    {
      "id": "D2",
      "decision": "drift smoke 2건 (smoke-l5-readme-link-cleanup.sh / smoke-v1.1.sh) 단순 제거",
      "rationale": "tests/CLAUDE.md 매트릭스 미거명 + .pre-commit-config.yaml 미연결 + RESEARCH 거명 8 host 에서 narrative 책임 명시 부재 = '회귀 차단 책임 부재 + 인프라 잔존 = drift'. 정의 § 3.1 명료화 단락 'narrative + 사용자 명시 게이트 가 1차' 정신에 따라 narrative source 부재 인프라는 정전화 정신과 맞물려 단순 제거 정당.",
      "alternatives_rejected": [
        "보존 + 매트릭스 등재 — 이미 4-tier era / v1.1 sessions/ 시대 잔존, 등재 시 narrative drift 후행. 정전화 정신 위배.",
        "보존 + manual run 가치 명시 — RESEARCH R1 정밀 확인 결과 manual run 가치 부재 (smoke 코드 자체가 4-tier 포맷 기반, 7-stage 포맷 미적용). 4-tier vs 7-stage 포맷 비교 증거는 Phase 1 execute/phase-1.md execution_notes 에 보존 (scope contract 검토 권고)."
      ]
    },
    {
      "id": "D3",
      "decision": "tests/CLAUDE.md 매트릭스 갱신 — '회귀 차단 책임' 컬럼 추가 + active 5 vs inactive 24 명시 + drift 1건 정정 (smoke-projects-scope-discipline 카테고리 등재)",
      "rationale": "narrative 1차 source 위치를 매트릭스 표 자체에서 명시 — '회귀 차단 책임' 명시 = active 5 (= pre-commit 가 narrative 보조로 강제) 와 inactive 24 (= 매트릭스 narrative 가 책임 명시 + 인프라 manual run leverage 가능) 구분. RESEARCH external#5 의 sub-drift (smoke-projects-scope-discipline 누락) 동시 정정.",
      "alternatives_rejected": [
        "active vs inactive 분리 표 추가 — 컬럼 추가가 inline 표기로 충분 (토큰 효율).",
        "현행 매트릭스 무수정 — drift 1건 + narrative 책임 명시 부재 미해결."
      ]
    },
    {
      "id": "D4",
      "decision": "ARCHITECTURE.md § 3.3 매트릭스 'Verification' 행 (c) 갱신 표현 = '정전 — VERIFY.md narrative 가 1차 source. smoke shell / install / verify 인프라 는 narrative 보조 (drift 항목 제거 후 잔존 인프라가 tests/CLAUDE.md 매트릭스에 회귀 차단 책임 명시)'",
      "rationale": "PLAN.success_criteria #6 의 '정확한 표현은 5 관점 검토 합의 후 DESIGN.decisions 에 확정'. 본 표기는 (1) narrative 우위 명시 + (2) 잔존 인프라가 보조 위치 명시 + (3) tests/CLAUDE.md 매트릭스 cross-ref. 정의 § 3.1 명료화 단락 정신 직접 적용.",
      "alternatives_rejected": [
        "'정전 (narrative 1차)' 단순 표기 — 보조 인프라 위치 미명시 → 잔존 smoke / install / verify 의 정당성 narrative drift 가능.",
        "'정전 — 모든 자동화 부재' 표기 — 사실 위반 (active 5 + install + verify 잔존)."
      ]
    },
    {
      "id": "D5",
      "decision": "phase 순서 = drift 정리 → narrative 강화 → 정의 갱신 (역순 부재)",
      "rationale": "정의 § 3.3 갱신 (Phase 3) 의 표기 'drift 항목 제거 후 잔존 인프라가 ... 회귀 차단 책임 명시' 가 Phase 1 (drift 제거) + Phase 2 (tests/CLAUDE.md 매트릭스 갱신) 결과를 직접 인용. 따라서 정의 갱신을 마지막 phase 로 두는 것이 cascade 정합. 또한 drift 정리 → 정합 narrative 강화 → 정의 표기 = 'narrative 우위 자연 도출' 흐름과 일치.",
      "alternatives_rejected": [
        "정의 갱신 → 정정 → narrative 강화 (정의 우선) — § 3.3 (c) 표기가 아직 미실현 상태를 인용하므로 self-referential lag.",
        "1 phase 통합 — 단일 책임 위반 + 회귀 추적성 ↓."
      ]
    },
    {
      "id": "D6",
      "decision": "단일 source 정합 직접 검증 (§ 3.5) — Phase 3 EXECUTE 사전 grep 으로 cross-ref host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 매트릭스 본문 중복 부재 확인",
      "rationale": "정의 § 3.5 '본 § 3 는 본 파일이 단일 source. 다른 문서는 cross-ref 만, 정의 본문·매트릭스 중복 금지'. RESEARCH R4 — cascade 영향 zero 가정이지만 직접 grep 으로 확인 의무 (cascade grep discipline 정신, v1.5_research-cascade-grep-discipline pending 존재).",
      "alternatives_rejected": [
        "cascade grep 생략 — § 3.5 직접 검증 부재 시 정전화 신뢰도 ↓."
      ]
    },
    {
      "id": "D7",
      "decision": "tests/CLAUDE.md 매트릭스 갱신 시 inactive 24 의 narrative 책임 표기 — 카테고리 표 보존 + 'inactive (manual run gleva — pre-commit 미연결)' 칼럼 또는 인라인 표기 추가",
      "rationale": "inactive 22건 (드 매트릭스 거명 보유) 의 narrative 책임 = 회귀 차단 의무 부재 + manual run leverage 가능. narrative 1차 source (= 매트릭스) 가 책임 명시. 단순 제거 부재.",
      "alternatives_rejected": [
        "inactive 24 도 같이 제거 — RESEARCH 핵심 발견 #5/#6 위배 (책임 중복 정밀 감사 필요 = Option B scope), 본 milestone Option A scope 외."
      ]
    },
    {
      "id": "D8",
      "decision": "phase 분할 = 3 phase (drift 제거 / narrative 강화 / 정의 갱신). 각 phase = 1 commit.",
      "rationale": "각 phase 단일 책임. phase 간 회귀 차단 위해 pre-commit hook (smoke-claude-md-drift smoke count 검증 등) 자동 실행. cascade 영향 phase 별 격리.",
      "alternatives_rejected": [
        "1 phase 통합 — 단일 책임 위배.",
        "5 phase (Option B 흐름) — Option A 거부."
      ]
    },
    {
      "id": "D9",
      "decision": "drift 2건 제거에 대한 narrative 대체 메커니즘 1:1 매핑 명시 — (a) tests/CLAUDE.md 매트릭스 = inactive smoke 들의 narrative 1차 source 위치 (D3 갱신 결과로 강화), (b) 사용자 manual run leverage 가능 = drift 2건 자체는 매트릭스 미거명이라 manual run 책임 명시 부재 → 이 가용성 부재가 곧 narrative 대체 정당성 (narrative 책임 부재 = 인프라 잔존 정당성 부재), (c) 본 DESIGN.decisions D2 + Phase 1 execute/phase-1.md execution_notes = narrative 대체 결정의 영속 trace (Trace 5요소 정전).",
      "rationale": "PLAN.success_criteria #4 '제거된 smoke·인프라 항목별 narrative 대체 메커니즘 1:1 매핑' 직접 충족. scope contract 검토 권고 (success_criteria #4 표기 강화) 반영. 본 milestone 의 narrative 우위 정전화는 '인프라 제거 = narrative 책임 부재 확인 + DESIGN/execute trace 보존' 으로 구현됨을 명시.",
      "alternatives_rejected": [
        "사용자 명시 approval 게이트만으로 매핑 — DESIGN.approval 은 본 milestone 자체 게이트, 제거 항목 별 1:1 매핑 효력 부재.",
        "GUARDRAILS.md 거명만으로 매핑 — drift smoke 2건 GUARDRAILS 거명 부재 (RESEARCH 사전 확인)."
      ]
    }
  ],
  "approach": "RESEARCH.options Option A 채택. 3 phase 단일 책임 흐름: (1) drift 2건 제거 (tests/smoke-l5-readme-link-cleanup.sh + tests/smoke-v1.1.sh) → (2) tests/CLAUDE.md 매트릭스 갱신 (active 5 vs inactive 24 표기 + 회귀 차단 책임 컬럼 + drift 1건 정정 + smoke 카운트 27) → (3) ARCHITECTURE.md § 3.3 'Verification' (c) 정전 갱신 + § 3.5 단일 source 정합 cascade grep 검증. 매 phase = 1 commit, pre-commit hook 5건 (smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift) 자동 실행. 회귀 0 + ARCHITECTURE 단일 source 정합 보존.",
  "phases": [
    {
      "n": 1,
      "title": "drift smoke 2건 제거",
      "scope": "narrative 책임 부재 + 매트릭스 미거명 + pre-commit 미연결 = drift 2건 단순 제거",
      "affected_files": [
        "tests/smoke-l5-readme-link-cleanup.sh (삭제)",
        "tests/smoke-v1.1.sh (삭제)",
        "tests/CLAUDE.md (L7 count 1줄 갱신: '현 29 파일' → '현 27 파일' — drift 2건 제거의 기계적 cascade, 매트릭스 표 narrative 강화는 Phase 2 책임)",
        "projects/meta/milestones/v1.4_infra-minimization/execute/phase-1.md"
      ],
      "rationale": "정의 § 3.1 'narrative + 사용자 명시 게이트 가 1차' 정신 직접 적용. narrative source 부재 인프라 = drift = 단순 제거 정당. tests/CLAUDE.md 매트릭스 cascade 영향 없음 (미거명).",
      "risks": [
        "smoke-claude-md-drift 의 'smoke count 정합' 검증 — 본 phase 단독 실행 시 tests/CLAUDE.md L7 '현 29' 와 실제 27 mismatch → smoke FAIL. 동기화 의무 = Phase 2 가 cover.",
        "Phase 1 commit 자체는 tests/CLAUDE.md 갱신 부재 → smoke-claude-md-drift FAIL 가능. 회귀 mitigation: Phase 1 을 Phase 2 와 sequential 진행, Phase 1 commit 시 tests/CLAUDE.md count 동기 갱신 inline 포함 (또는 phase-1.md scope 확장)"
      ]
    },
    {
      "n": 2,
      "title": "tests/CLAUDE.md 매트릭스 갱신 (active vs inactive + 회귀 차단 책임 + drift 1건 정정)",
      "scope": "narrative 1차 source 위치 명시 강화 — 회귀 차단 책임 컬럼 추가 (enum: 'active = pre-commit 강제 회귀 차단' / 'inactive = manual run leverage 가능, 회귀 차단 의무 부재') + active 5 vs inactive 22 명시 (Phase 1 drift 2건 제거 후 = inactive 22) + smoke-projects-scope-discipline 카테고리 등재 (drift 1건 정정). L7 count (현 27) 는 Phase 1 에서 cascade 갱신 완료, Phase 2 는 매트릭스 표 narrative 강화에 단일 책임 집중",
      "affected_files": [
        "tests/CLAUDE.md (갱신)",
        "projects/meta/milestones/v1.4_infra-minimization/execute/phase-2.md"
      ],
      "rationale": "RESEARCH external#5 sub-drift + 'narrative 1차 source 위치 매트릭스 표 자체' 강화. Phase 1 cascade (smoke 카운트 27) 동기 반영.",
      "risks": [
        "smoke-cross-ref autofix 가 매트릭스 표 markdown link 정합 자동 정정 가능 — wrapper 경유 자동 정정 수용.",
        "smoke-claude-md-drift 'smoke count 정합' 검증 통과 의무 — L7 카운트 27 동기 갱신 + 매트릭스 row 카운트 일관성"
      ]
    },
    {
      "n": 3,
      "title": "ARCHITECTURE.md § 3.3 'Verification' (c) 정전화 + § 3.5 단일 source 정합 cascade grep",
      "scope": "정의 § 3.3 매트릭스 'Verification' 행 (c) 갱신 + § 3.5 cascade host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 본문 중복 부재 grep 검증 (수정 부재 시 grep 결과만 phase-3.md 에 기록). cascade grep 패턴은 v1.4_cross-ref-propagation phase-3.md 패턴 재활용 (5요소 매트릭스 표 형식 + (c) 분류 본문 형식)",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (§ 3.3 'Verification' 행 (c) 갱신)",
        "projects/meta/milestones/v1.4_infra-minimization/execute/phase-3.md (cascade grep 결과 명시)"
      ],
      "rationale": "Phase 1+2 결과 = drift 제거 + narrative 강화 → § 3.3 (c) '정전' 표기의 사실 근거. § 3.5 직접 검증 = R4 mitigation.",
      "risks": [
        "정의 § 3.5 cross-ref host 5곳 grep 결과 본문 중복 발견 시 — 별도 cleanup phase 필요 (Option A scope 확장). 단 RESEARCH R7 '8 host cascade 정상' 사전 검증 결과 기반 risk 낮음.",
        "smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift active 5 통과 의무"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1 — drift smoke 2건 제거 시 manual run leverage 손실",
      "mitigation": "RESEARCH 추가 감사 결과 manual run 가치 부재 확인 (smoke 코드 자체 4-tier 포맷 기반, 7-stage 미적용). DESIGN D2 alternatives_rejected 명시."
    },
    {
      "risk": "R2 — tests/CLAUDE.md 매트릭스 갱신 cascade (smoke-claude-md-drift count 검증)",
      "mitigation": "Phase 2 의 affected_files = tests/CLAUDE.md 단독, L7 카운트 27 + 매트릭스 row 일관성 동기 갱신. Phase 1 + 2 sequential — Phase 1 commit 시 tests/CLAUDE.md count 동기 inline 갱신 (phase-1.md scope 확장 1건 — count 만)"
    },
    {
      "risk": "R3 — active 5 hook 본 milestone 산출물 자체 검증",
      "mitigation": "본 milestone PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md JSON schema 정합 의무. 5 hook (smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift) 산출물 작성 단계마다 자동 실행 (pre-commit). v1.4_cross-ref-propagation 사례 사전 통과 검증."
    },
    {
      "risk": "R4 — § 3.5 단일 source 정합 cascade",
      "mitigation": "Phase 3 사전 grep 으로 cross-ref host 5곳 본문 중복 부재 직접 확인 (D6). 결과 phase-3.md 에 명시."
    },
    {
      "risk": "R5/R6 — Option B 책임 중복",
      "mitigation": "Option A 채택으로 회피. R5/R6 은 후속 milestone (Option B 채택 시) 평가 대상."
    },
    {
      "risk": "R7 — narrative 1차 source 8 host 정합",
      "mitigation": "RESEARCH 사전 cascade 확인 결과 정상. 본 milestone EXECUTE 영향 zero. Phase 3 cascade grep 으로 추가 검증."
    },
    {
      "risk": "Phase 1 단독 commit 시 tests/CLAUDE.md count drift",
      "mitigation": "Phase 1 의 affected_files 에 tests/CLAUDE.md L7 count 갱신 (29 → 27) inline 포함. 즉 Phase 1 = drift 2건 삭제 + tests/CLAUDE.md L7 count 1줄 갱신. Phase 2 의 매트릭스 표 갱신 (active vs inactive + drift 1건 정정 + 회귀 차단 책임 컬럼) 과 분리 — 단일 책임 (count vs narrative 강화) 보존."
    }
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-10"
  }
}
```

## Phase 분할 요약

| n | 제목 | 핵심 산출 | commit 메시지 |
|:-:|------|---------|------------|
| 1 | drift smoke 2건 제거 | smoke-l5-readme-link-cleanup.sh + smoke-v1.1.sh 삭제 + tests/CLAUDE.md L7 count 갱신 (29 → 27) | `feat(meta): v1.4 phase-1 — drift smoke 2건 제거 (smoke-l5 / smoke-v1.1) + tests/CLAUDE.md count 동기` |
| 2 | tests/CLAUDE.md 매트릭스 narrative 강화 | active vs inactive 표기 + 회귀 차단 책임 컬럼 + smoke-projects-scope-discipline 카테고리 등재 | `feat(meta): v1.4 phase-2 — tests/CLAUDE.md 매트릭스 narrative 강화 (active vs inactive + 회귀 차단 책임)` |
| 3 | ARCHITECTURE § 3.3 정전화 + § 3.5 cascade grep | § 3.3 'Verification' (c) 정전 갱신 + § 3.5 cross-ref host 5곳 grep 검증 | `feat(meta): v1.4 phase-3 — ARCHITECTURE § 3.3 매트릭스 'Verification' 정전화` |

## 5 관점 → 4 관점 검토 적용

scope = 7 파일 (4 본 + 3 phase 산출물) = 중간 (6~15) → 4 관점 (architecture / spec-drift / 회귀 risk / scope contract). 보안 관점 부재 (CRUD 부재, side-effect 부재, path traversal 부재).

## 관련 문서

- PLAN: [`PLAN.md`](PLAN.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 정의 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)

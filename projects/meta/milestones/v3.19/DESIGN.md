# DESIGN — v3.19_word-fidelity-audit-v2

```json
{
  "id": "v3.19_word-fidelity-audit-v2",
  "decisions": [
    {
      "id": "D1",
      "decision": "옵션 A 채택 — 진단만 (lightweight, v3.17 패턴)",
      "rationale": "Stage A OPEN 시점 사용자 명시 선택 (Recommended). v3.17 + v3.18 lightweight 모드 패턴 정합. § 6.2 default 동결 정합 (workflow self-improvement 본질 + 사용자 명시 발의 A_user trigger 충족 + 진단 산출물만). 산출물 변경 zero → 회귀 risk 본질 부재.",
      "alternatives_rejected": [
        "옵션 B (PROPOSE drift 실 변경, 10-stage REGISTER 단계 신설) — § 6.2 동결 정책 강한 대상, breaking change v4.0 risk, 외부 적용 데이터 기반 정량 evidence 부재",
        "옵션 C (ROADMAP 재정의 실 변경) — § 6.2 동결 정합 정책 자체와 충돌 (pending 등재 회피 default ↔ pending 다수 등재 모순), breaking change risk",
        "옵션 D (narrative 정전화) — 본 milestone 진단 책임과 narrative 정전화 책임 겹침 → 별 milestone (v3.20_*) 자연 분리 (Stage I PROPOSE 거명만)"
      ]
    },
    {
      "id": "D2",
      "decision": "9-stage 단어-책임 부합도 정량 점수 정전화 (RESEARCH.codebase.current_state.stage_word_fidelity_estimate 채택)",
      "rationale": "사용자 발의 검토 결과 추정 점수를 DESIGN 단계에서 채택 — APPROVE 100% (단일 책임 완벽) / VERIFY 95% (criteria_check 1:1 매핑) / REPORT 90% (PROPOSE 분리 효과) / OPEN 90% (skeleton initialize 미세 침범) / EXECUTE 85% (smoke verify 침범) / RESEARCH 85% (options analysis 침범) / INTENT 80% (out_of_scope scope 책임 침범) / DESIGN 80% (5 관점 review 침범) / PROPOSE 70% (register 책임 침범). 평균 ~86.1%.",
      "alternatives_rejected": [
        "5 관점 subagent 안 정량 재측정 — lightweight 모드 (§ 6.2 자기참조 회피 표지) 정합 생략. 사용자 검토 결과 = 정량 source 1차 source",
        "외부 source (예: OpenAI / Anthropic workflow word-fidelity reference) 안 부합도 점수 — 본 milestone 9-stage 가 내부 정의이므로 외부 비교 의미 약함"
      ]
    },
    {
      "id": "D3",
      "decision": "drift 본질 = 인접 stage 책임 침범 (pragmatic 절충 의도성)",
      "rationale": "측정된 drift 7건 (OPEN/INTENT/RESEARCH/DESIGN/EXECUTE/REPORT/PROPOSE) 모두 인접 stage 책임 침범 패턴 — initialize / scope / analysis / review / verify / register 등. 절차 효율성을 위한 의도적 통합 (e.g., EXECUTE 안 smoke 회귀 검증 = pre-commit hook 의무, EXECUTE 분리 시 procedure 비효율). v2.0_workflow-word-fidelity 정정 시 의도적 design choice 였을 가능성 강함.",
      "alternatives_rejected": [
        "drift = 단어-책임 모호성 (unintended) — RESEARCH source 가 v2.0 정정 narrative 와 모순 (v2.0 의 의도 = 단어-책임 1:1)",
        "drift = 자기참조 사이클 부작용 (v3.6 § 6.2 trigger 와 같은) — 부분 기여 가능하나 단일 결정적 원인 아님"
      ]
    },
    {
      "id": "D4",
      "decision": "ROADMAP-PROPOSE root cause 공유 진단 — '단일 책임 모호' (PROPOSE 의 register 책임 침범 ↔ ROADMAP 의 forward-looking 정의 미부합)",
      "rationale": "PROPOSE 단계 70% drift = 'register' (ROADMAP 등재 실 operation) 책임 침범. ROADMAP 88.9% completed = forward-looking 부재. 두 사실은 같은 원인의 양면 — ROADMAP 이 forward-looking artifact 면 PROPOSE 는 등재 (register) 가 부합하지만, ROADMAP 이 실질적으로 audit ledger (backward) 면 PROPOSE 의 등재 책임 자체가 모호해짐. § 6.2 default 동결 정책이 두 모호성 모두 부분 완화 (pending 미등재 default → 'register' 호출 빈도 감소) 하지만 단어-책임 자체 drift 해소는 아님.",
      "alternatives_rejected": [
        "두 drift 가 독립적 — RESEARCH evidence (PROPOSE 안 ROADMAP 등재 책임 단어 정합 검토) 가 공유 패턴 시사, 독립적 해석 약함",
        "ROADMAP 이 forward-looking 부재 = CHANGELOG 와 책임 중복만 — PROPOSE 책임 침범 본질과 직접 연관 약하다는 해석, RESEARCH evidence 와 모순"
      ]
    },
    {
      "id": "D5",
      "decision": "산출물 변경 zero 정합 (워크플로우 본문 / smoke / cross-ref host 변경 0건)",
      "rationale": "본 milestone 은 진단만 — INTENT/RESEARCH/DESIGN/APPROVE/execute/VERIFY/REPORT/PROPOSE.md 8건 신규 + milestones.md 1건 + ROADMAP 1 entry 갱신 = 10건. 워크플로우 본문 (claude/commands/harness-meta.md) / ARCHITECTURE.md / smoke / 모듈 가이드 변경 zero. v3.17 + v3.18 패턴 정합.",
      "alternatives_rejected": [
        "ARCHITECTURE.md § 6.X 안 drift 진단 결과 narrative 추가 (옵션 D 일부) — 별 milestone (v3.20_drift-narrative-canonicalization) 자연 분리 (Stage I PROPOSE 거명만)"
      ]
    },
    {
      "id": "D6",
      "decision": "phase 분할 = 1 phase (lightweight 1+1 commit)",
      "rationale": "lightweight 모드 (5 관점 subagent 생략 + 산출물 변경 zero) 정합. v3.17 + v3.18 1-phase 1+1 commit 패턴 정합. INTENT~APPROVE+execute/phase-1 = phase-1 commit 1건 + Stage G+H+I 통합 chore commit 1건 = 총 2 commit.",
      "alternatives_rejected": [
        "2 phase 분할 (RESEARCH + DESIGN 별 commit) — lightweight 모드 단일 phase 패턴 위반",
        "phase 없음 (단일 chore commit) — execute/phase-1.md 트래킹 의무 위반"
      ]
    }
  ],
  "approach": "lightweight 모드 (§ 6.2 자기참조 회피 표지) 정합 진단 milestone. 9-stage 단어-책임 부합도 정량 점수 (평균 ~86.1%) + drift 본질 (인접 stage 책임 침범) + ROADMAP-PROPOSE root cause 공유 ('단일 책임 모호') 3 진단 산출물을 DESIGN.decisions 정전화. 워크플로우 본문 변경 zero, smoke 변경 zero, 후속 candidate 거명만 (§ 6.2 default 동결 정합). 1 phase 1+1 commit (v3.17 + v3.18 lightweight 패턴 정합, 누적 7/19 = 36.8%). 자기참조 모순 표지 (진단 결과 자체가 워크플로우 자기 검토 라운드 누적 3번째 = v3.6 / v3.17 / v3.19).",
  "phases": [
    {
      "n": 1,
      "title": "진단 산출물 단일 phase commit — INTENT/RESEARCH/DESIGN/APPROVE/execute/phase-1.md + milestones.md 동기 갱신",
      "scope": "Stage B-E 산출물 4종 (INTENT/RESEARCH/DESIGN/APPROVE.md) + execute/phase-1.md + milestones.md sub_milestones 1:1 동기 갱신. ROADMAP entry status: in_progress 유지 (Stage I 까지). 사실 진술만 — 후속 milestone 발의 명령형 부재.",
      "affected_files": [
        "projects/meta/milestones/v3.19/INTENT.md",
        "projects/meta/milestones/v3.19/RESEARCH.md",
        "projects/meta/milestones/v3.19/DESIGN.md",
        "projects/meta/milestones/v3.19/APPROVE.md",
        "projects/meta/milestones/v3.19/milestones.md",
        "projects/meta/milestones/v3.19/execute/phase-1.md",
        "projects/meta/ROADMAP.md"
      ],
      "rationale": "lightweight 모드 1-phase 패턴 (v3.17 + v3.18 정합). INTENT~APPROVE commit timing = (a) phase-1 commit 안 포함 (v3.17 + v3.18 lightweight 1-phase 정합, commit timing 옵션 (b) 안 적용은 multi-phase 시).",
      "risks": [
        "pre-commit 14 hook 일부 (smoke-spec-verification / smoke-scope-contract) milestones.md sub_milestones 검증 시 placeholder 잔존 → era 분류 오인 risk → DESIGN 단계 끝에서 milestones.md sub_milestones 1:1 동기 갱신 의무 (Stage D 완료 직전 의무 step, v3.5 도입)",
        "본 milestone 진단 narrative 가 후속 옵션 B/C 발의 trigger 로 해석 risk (R4 정합) → next_candidates ROADMAP 등재 0건 (§ 6.2 동결 정합)"
      ]
    }
  ],
  "risk_mitigation": {
    "R1": "DESIGN.decisions D1 안 옵션 A 채택 명시 + alternatives_rejected 안 옵션 B/C/D 명시. options pros/cons 는 raw 분석만",
    "R2": "lightweight 모드 v3.17 + v3.18 검증된 패턴 정합. 진단만 + 산출물 변경 zero → 회귀 risk 본질 부재. self_reference_policy: avoid 표지",
    "R3": "Stage I PROPOSE 안 v3.X_drift-narrative-canonicalization 후속 candidate 거명 (§ 6.2 동결 정합)",
    "R4": "DESIGN.decisions D1/D4 안 옵션 B 비채택 + § 6.2 동결 trigger 미충족 명시. PROPOSE 거명만",
    "R5": "v3.17 / v3.18 lessons 정합 narrative — 진단만 + 사용자 명시 발의 (A_user) 충족 = § 6.2 정합. lightweight 누적 7/19 = 자기참조 모순 표지 의도성"
  },
  "self_reference_policy": "avoid (§ 6.2 자기참조 회피 표지) — 5 관점 subagent 검토 생략, 워크플로우 자기 검토 결과 narrative 자기 진단 시 도그푸드 모순 의도 표지. v3.6 / v3.10 / v3.13 / v3.14 / v3.17 / v3.18 누적 6/18 = 33.3% lightweight 패턴 → 본 milestone 누적 7/19 = 36.8% 갱신",
  "subagent_review_policy": "skipped — lightweight 모드 5 관점 subagent 생략 (v3.6 도입 정합). 산출물 변경 zero + 진단만 → 회귀 risk 본질 부재"
}
```

## narrative

본 DESIGN 은 **lightweight 모드 정합** — 6 decisions (D1~D6) + approach + 1 phase + risk_mitigation 5건. 5 관점 subagent 검토 생략 (§ 6.2 자기참조 회피 표지, v3.17 + v3.18 패턴 정합).

D1 옵션 A 채택 (Stage A OPEN 사용자 명시 선택 정합) + D2 부합도 정량 점수 정전화 + D3 drift 본질 (인접 stage 침범 pragmatic 절충) + D4 ROADMAP-PROPOSE root cause 공유 ('단일 책임 모호') + D5 산출물 변경 zero + D6 1 phase 1+1 commit. 모든 decisions 사실 진술만 (v3.10 부산물 정책 정합, forward propose 명령형 부재).

## Stage D 완료 직전 의무 step (v3.5 도입)

`phases[]` 확정 직후 (1 phase) → `milestones.md sub_milestones[]` 1:1 동기 갱신 의무. placeholder title → phase-1 실 title 교체 진행.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- milestones.md (sub_milestones 1:1 동기 갱신 대상): [`milestones.md`](milestones.md)
- § 6.2 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- v3.17 lightweight 패턴 source: [`../v3.17/DESIGN.md`](../v3.17/DESIGN.md)
- v3.18 narrative 정전화 패턴 source: [`../v3.18/DESIGN.md`](../v3.18/DESIGN.md)

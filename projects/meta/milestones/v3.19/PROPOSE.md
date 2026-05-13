# PROPOSE — v3.19_word-fidelity-audit-v2

```json
{
  "id": "v3.19_word-fidelity-audit-v2",
  "next_candidates": [
    {
      "id": "v3.X_drift-narrative-canonicalization",
      "title": "drift 진단 결과 narrative 정전화 (옵션 D 후속) — ARCHITECTURE.md 안 word-fidelity drift 수용 paragraph",
      "approach": "RESEARCH.options Option D — ARCHITECTURE.md 안 word-fidelity drift 수용 narrative paragraph 추가. drift 의 의도성 (pragmatic 절충) + 평균 부합도 86.1% + APPROVE 100% / PROPOSE 70% 정량 cross-ref. v3.18 패턴 정합 (단일 source narrative). lightweight 모드 자연 후속.",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — v3.19 진단 결과 narrative 정전화 효과 평가 후 발의. § 6.2 default 동결 정합 (narrative 변경만이지만 워크플로우 self-improvement 본질).",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합, ROADMAP 미등재)",
      "implication_lesson_cross_ref": ["v3.19 L1", "v3.19 L2"]
    },
    {
      "id": "v3.X_propose-register-책임-separation-evaluation",
      "title": "PROPOSE 의 register 책임 분리 가능성 평가 (옵션 B 후속) — workflow self-improvement 본질",
      "approach": "RESEARCH.options Option B — PROPOSE 의 register 책임 (ROADMAP 등재 실 operation) 을 신규 REGISTER 단계로 분리 가능성 평가. 9-stage → 10-stage 안 + breaking change v4.0 시나리오 분석. v3.19 L1 (root cause 공유) narrative 의 실 변경 후속.",
      "trigger": "D_design",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone ≥10건 추가 누적 ∧ 사용자 명시 발의 AND. § 6.2 동결 정책 강한 정합 (workflow self-improvement 본질 + breaking change risk). v3.14 cycle 2 + v3.19 진단 결과 누적 evidence 기반.",
      "ROADMAP_등재": "거명만 (§ 6.2 동결, breaking change risk)",
      "implication_lesson_cross_ref": ["v3.19 L1", "v3.19 L5"]
    },
    {
      "id": "v3.X_roadmap-redefinition-evaluation",
      "title": "ROADMAP 사전 정의 부합 회복 또는 명명 변경 평가 (옵션 C 후속)",
      "approach": "RESEARCH.options Option C — (c1) pending entry 다수 등재 + completed CHANGELOG 이관 (forward-looking 회복) 또는 (c2) ROADMAP.md → MILESTONES.md / LEDGER.md 재명명. § 6.2 동결 정합 정책과 충돌 가능성 검토. v3.19 L1 (root cause 공유) 의 ROADMAP 측 실 변경 후속.",
      "trigger": "D_design",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone 다수 누적 ∧ § 6.2 동결 정책 완화 결정 AND. v3.14 deferred 3건 재평가 cycle 3 trigger 와 일부 정합.",
      "ROADMAP_등재": "거명만 (§ 6.2 동결, § 6.2 정합 정책 충돌)",
      "implication_lesson_cross_ref": ["v3.19 L1"]
    },
    {
      "id": "v3.X_lightweight-1phase-commit-timing-a-canonicalization",
      "title": "lightweight 1-phase commit timing (a) default 화 narrative 정전화 (v3.19 L4 후속)",
      "approach": "v3.19 L4 narrative — lightweight 1-phase 일 때 commit timing (a) (phase-1 commit 안 INTENT~APPROVE 포함) 가 자연 default. claude/commands/harness-meta.md Stage F EXECUTE 선결 조건 안 commit timing 3 패턴 중 lightweight 1-phase 분기 narrative 추가. 매우 작은 narrative 변경 (1~2 줄).",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — lightweight 누적 ≥10건 시점 정합 (현재 7/19, 향후 3건+ 누적 시 trigger 자연).",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합)",
      "implication_lesson_cross_ref": ["v3.19 L4"]
    }
  ],
  "propose_summary": "v3.19 진단 결과 후속 candidate 4건 거명만 (ROADMAP 미등재 0건, § 6.2 default 동결 정합). 모든 candidate 사용자 명시 발의 (A_user) trigger 대기 — 자동 후속 milestone 발의 부재 (도그푸드 자기참조 모순 표지 회피). v3.19 L1 (root cause 공유) 의 두 측면 (PROPOSE register 책임 / ROADMAP forward-looking 정의) 각각 옵션 B/C 후속 candidate 등재 — 단 § 6.2 동결 trigger 미충족 유지.",
  "trigger_conditions_narrative": "후속 milestone 발의 trigger 조건 — drift-narrative-canonicalization: 사용자 명시 발의 AND. propose-register-책임-separation: 외부 적용 ≥10건 ∧ 사용자 명시 발의 AND. roadmap-redefinition: § 6.2 동결 완화 결정 ∧ 사용자 명시 발의 AND. lightweight-1phase-commit-timing: lightweight 누적 ≥10건 ∧ 사용자 명시 발의 AND. 모든 옵션 § 6.2 default 동결 정합.",
  "absorbed_origins": {
    "user_explicit": "사용자 명시 발의 'milestone으로 발의해줘' (A_user trigger, /harness-meta meta 자유 발의 round 안 워크플로우 자기 검토 결과 직후)",
    "stage_b_byproduct": "INTENT.out_of_scope 6건 — 워크플로우 본문 변경 / ROADMAP 재정의 실 변경 / PROPOSE 책임 실 분리 / smoke / 5 관점 subagent / 다른 워크플로우 self-improvement candidate. 모두 사실 진술, 후속 발의 명령형 없음 (v3.10 부산물 정책 정합)",
    "stage_c_byproduct": "RESEARCH.untouched_files_explicit 5건 + RESEARCH.options 4건 (A 채택 / B/C/D 비채택 alternatives_rejected) — 모두 사실 진술, 후속 발의 직접 거명 부재",
    "stage_d_byproduct": "DESIGN.decisions 6건 (D1~D6) 모두 사실 진술 — 후속 발의 명령형 부재",
    "v3.10_dual_origin_check": "PROPOSE.next_candidates 4건 모두 dual origin 통합 흡수 — (1) 사용자 명시 발의 A_user direct + (2) B/C/D 부산물 사실 진술 source. v3.10 정책 정합"
  }
}
```

## narrative

본 PROPOSE 는 **dual origin 통합 흡수 책임** (v3.10 정책 정합):

1. **사용자 명시 발의** (A_user) — 'milestone으로 발의해줘' (워크플로우 자기 검토 결과 직후, /harness-meta meta 자유 발의 round 안)
2. **B/C/D 부산물** — INTENT.out_of_scope + RESEARCH.untouched/options + DESIGN.decisions 사실 진술 → PROPOSE 단계 후속 흡수 (next_candidates 4건 거명만)

모든 next_candidates `ROADMAP 등재 0건` (§ 6.2 default 동결 정합) — workflow self-improvement 본질 milestone 안 자기참조 모순 표지 의도성 정합. v3.17 + v3.18 패턴 정확 정합.

## 관련

- INTENT (out_of_scope 6건 source): [`INTENT.md`](INTENT.md)
- RESEARCH (untouched 5 + options 4 source): [`RESEARCH.md`](RESEARCH.md)
- DESIGN (decisions 6 source): [`DESIGN.md`](DESIGN.md)
- REPORT (lessons_learned 6건 cross-ref): [`REPORT.md`](REPORT.md)
- v3.18 PROPOSE 패턴 source: [`../v3.18/PROPOSE.md`](../v3.18/PROPOSE.md)
- v3.17 PROPOSE 패턴 source: [`../v3.17/PROPOSE.md`](../v3.17/PROPOSE.md)
- § 6.2 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)

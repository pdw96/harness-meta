# PROPOSE — v3.20_drift-narrative-canonicalization

```json
{
  "id": "v3.20_drift-narrative-canonicalization",
  "next_candidates": [
    {
      "id": "v3.X_lightweight-1phase-commit-timing-a-canonicalization",
      "title": "lightweight 1-phase commit timing (a) default narrative 정전화 (v3.20 L1 + v3.19 next_candidates#4 직접 후속)",
      "approach": "v3.20 L1 lesson + v3.19 PROPOSE.next_candidates#4 직접 cross-ref. claude/commands/harness-meta.md Stage F EXECUTE 선결 조건 안 commit timing 3 패턴 narrative 갱신 — lightweight 1-phase 분기 narrative 추가 ('lightweight 모드 + 1-phase 일 때 commit timing (a) 자연 default — 누적 4 cycle v3.17/v3.18/v3.19/v3.20 정량 evidence'). 매우 작은 narrative 변경 (1~2 줄)",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — v3.20 L1 + v3.19 next_candidates#4 cross-ref 누적 evidence 강화 후 발의 자연. § 6.2 default 동결 정합 (workflow self-improvement 본질이지만 narrative 변경만)",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합, ROADMAP 미등재)",
      "implication_lesson_cross_ref": ["v3.20 L1", "v3.19 next_candidates#4"]
    },
    {
      "id": "v3.X_diagnose-then-canonicalize-pattern",
      "title": "'진단 milestone → narrative 정전화 milestone' 2 cycle 패턴 정전화 (v3.20 L2 후속)",
      "approach": "v3.20 L2 lesson — v3.17 진단 → v3.18 정전화 / v3.19 진단 → v3.20 정전화 2 cycle 패턴 명문화. ARCHITECTURE.md 또는 claude/commands/harness-meta.md 안 패턴 narrative 추가 가능. 단 lessons_learned 자동 후속 발의 금지 (§ 6.2 정합)",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — 3 cycle 누적 후 정전화 권장 (현재 2 cycle, 3 cycle 누적 시 정전화 trigger 자연)",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합)",
      "implication_lesson_cross_ref": ["v3.20 L2"]
    },
    {
      "id": "v3.X_propose-register-책임-separation-evaluation",
      "title": "PROPOSE 의 register 책임 분리 가능성 평가 (v3.19 next_candidates#2 carry-over) — v3.20 drift narrative 정전화 후 책임 분리 implication 누적 강화",
      "approach": "v3.19 PROPOSE.next_candidates#2 carry-over — PROPOSE 의 register 책임 (ROADMAP 등재 실 operation) 신규 REGISTER 단계 분리 가능성 평가. 9-stage → 10-stage 안 + breaking change v4.0 시나리오. v3.20 drift narrative 정전화 후 'drift 수용 default + 실 변경 evidence-base trigger 만' narrative 강화 → 분리 trigger 미충족 narrative 강화",
      "trigger": "D_design",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone ≥10건 추가 누적 ∧ 사용자 명시 발의 AND. § 6.2 동결 강한 정합 (workflow self-improvement + breaking change risk)",
      "ROADMAP_등재": "거명만 (§ 6.2 동결, breaking change risk)",
      "implication_lesson_cross_ref": ["v3.20 본 paragraph 안 'drift 수용 default'", "v3.19 PROPOSE.next_candidates#2"]
    },
    {
      "id": "v3.X_roadmap-redefinition-evaluation",
      "title": "ROADMAP 사전 정의 부합 회복 또는 명명 변경 평가 (v3.19 next_candidates#3 carry-over)",
      "approach": "v3.19 PROPOSE.next_candidates#3 carry-over — (c1) pending entry 다수 등재 + completed CHANGELOG 이관 또는 (c2) ROADMAP.md → MILESTONES.md 재명명. § 6.2 default 동결 정합 정책 자체와 충돌 가능성 검토",
      "trigger": "D_design",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone 다수 누적 ∧ § 6.2 동결 정책 완화 결정 AND",
      "ROADMAP_등재": "거명만 (§ 6.2 동결, § 6.2 정합 정책 충돌)",
      "implication_lesson_cross_ref": ["v3.19 PROPOSE.next_candidates#3"]
    }
  ],
  "propose_summary": "v3.20 후속 candidate 4건 거명만 (ROADMAP 미등재 0건, § 6.2 default 동결 정합). 4건 중 2건 (#1 timing-a-canonicalization + #2 diagnose-then-canonicalize-pattern) = v3.20 lessons (L1/L2) 신규 origin / 2건 (#3 propose-register-separation + #4 roadmap-redefinition) = v3.19 next_candidates carry-over. 모든 candidate 사용자 명시 발의 (A_user) trigger 대기 — 자동 후속 milestone 발의 부재 (도그푸드 자기참조 모순 표지 회피, § 6.2 정합).",
  "trigger_conditions_narrative": "후속 milestone 발의 trigger 조건 — #1 timing-a-canonicalization: 사용자 명시 발의 AND (누적 4 cycle evidence 강화 후 자연). #2 diagnose-then-canonicalize: 3 cycle 누적 ∧ 사용자 명시 발의 AND. #3 propose-register-separation: 외부 적용 ≥10건 ∧ 사용자 명시 발의 AND (v3.19 동일). #4 roadmap-redefinition: § 6.2 동결 완화 결정 ∧ 사용자 명시 발의 AND (v3.19 동일). 모든 옵션 § 6.2 default 동결 정합.",
  "absorbed_origins": {
    "user_explicit": "사용자 명시 발의 'v3.19 L1 후속: drift-narrative-canonicalization' (A_user trigger, /harness-meta meta 자유 발의 round Stage A AskUserQuestion 선택)",
    "stage_b_byproduct": "INTENT.out_of_scope 7건 — 워크플로우 본문 / ROADMAP 재정의 / § 6.2 본문 / tests / 9-stage 표 / L4 bundle / 5 관점 subagent. 모두 사실 진술, 후속 발의 명령형 없음 (v3.10 정책 정합)",
    "stage_c_byproduct": "RESEARCH.untouched_files_explicit 6건 (워크플로우 본문 / § 6.2 / § 4 표 / tests / CHANGELOG / 다른 host) + RESEARCH.options 4건 (Option 1 채택 / 2/3/4 alternatives_rejected) + risks 6건 — 모두 사실 진술, 후속 발의 직접 거명 부재",
    "stage_d_byproduct": "DESIGN.decisions 6건 (D1~D6) 모두 사실 진술 + DESIGN.byproduct_check '사실 진술만, forward propose 명령형 부재' 직접 검증",
    "v3.10_dual_origin_check": "PROPOSE.next_candidates 4건 dual origin 통합 흡수 — (1) 사용자 명시 발의 A_user direct + (2) B/C/D 부산물 사실 진술 source + (3) v3.20 lessons L1/L2 신규 origin + (4) v3.19 next_candidates#2/#3 carry-over. v3.10 정책 정합"
  }
}
```

## narrative

본 PROPOSE 는 **dual origin 통합 흡수 책임** (v3.10 정책 정합):

1. **사용자 명시 발의** (A_user) — 'v3.19 L1 후속: drift-narrative-canonicalization' (Stage A AskUserQuestion 선택)
2. **B/C/D 부산물** — INTENT.out_of_scope + RESEARCH.untouched/options/risks + DESIGN.decisions 사실 진술 → PROPOSE 단계 후속 흡수
3. **v3.20 lessons 신규 origin** — L1 (commit timing (a) default) + L2 (진단 → 정전화 cycle 패턴) → next_candidates #1/#2
4. **v3.19 next_candidates carry-over** — #2 propose-register-separation + #3 roadmap-redefinition → next_candidates #3/#4

모든 next_candidates `ROADMAP 등재 0건` (§ 6.2 default 동결 정합) — workflow self-improvement 본질 milestone 안 자기참조 모순 표지 의도성 정합. v3.17 + v3.18 + v3.19 패턴 정확 정합 (4 cycle 누적).

## 관련

- INTENT (out_of_scope source): [`INTENT.md`](INTENT.md)
- RESEARCH (untouched/options/risks source): [`RESEARCH.md`](RESEARCH.md)
- DESIGN (decisions source): [`DESIGN.md`](DESIGN.md)
- VERIFY (PASS_WITH_NOTE L1 trigger): [`VERIFY.md`](VERIFY.md)
- REPORT (lessons L1~L6 cross-ref): [`REPORT.md`](REPORT.md)
- v3.19 PROPOSE (next_candidates#1 origin + #2/#3 carry-over source): [`../v3.19/PROPOSE.md`](../v3.19/PROPOSE.md)
- v3.18 PROPOSE 패턴 source: [`../v3.18/PROPOSE.md`](../v3.18/PROPOSE.md)
- v3.17 PROPOSE 패턴 source: [`../v3.17/PROPOSE.md`](../v3.17/PROPOSE.md)
- § 6.2 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)

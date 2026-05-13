# PROPOSE — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "next_candidates": [
    {
      "id": "v3.X_lightweight-1phase-commit-timing-a-canonicalization",
      "title": "lightweight 1-phase commit timing (a) default narrative 정전화 (v3.21 L5 + v3.20 PROPOSE.next_candidates#1 + v3.19 #4 carry-over)",
      "approach": "v3.21 L5 lesson + v3.20 #1 carry-over. claude/commands/harness-meta.md Stage F EXECUTE 선결 조건 안 commit timing 3 패턴 narrative 갱신 — lightweight 1-phase 분기 narrative 추가 ('lightweight 모드 + 1-phase 일 때 commit timing (a) 자연 default — 누적 5 cycle v3.17/v3.18/v3.19/v3.20/v3.21 정량 evidence'). 매우 작은 narrative 변경 (1~2 줄). 본 milestone § 6.2 신 paragraph (Narrative 정전화 3단계 패턴) 직접 적용 가능 — DESIGN 정확 문구 + EXECUTE Edit 그대로 + VERIFY grep 검증",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — 5 cycle 누적 evidence 강화 완료 (v3.21 L5), 정전화 권장 trigger 충족. § 6.2 default 동결 정합 (workflow self-improvement 본질이지만 narrative 변경만)",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합, ROADMAP 미등재)",
      "implication_lesson_cross_ref": ["v3.21 L5", "v3.20 PROPOSE.next_candidates#1", "v3.19 PROPOSE.next_candidates#4"]
    },
    {
      "id": "v3.X_diagnose-then-canonicalize-pattern",
      "title": "'진단 milestone → narrative 정전화 milestone' 2-cycle 패턴 정전화 (v3.20 PROPOSE.next_candidates#2 carry-over, v3.21 부분 흡수)",
      "approach": "v3.20 #2 carry-over + v3.21 부분 흡수. v3.17 진단 → v3.18 정전화 / v3.19 진단 → v3.20 정전화 / v3.21 (3단계 패턴 명문화 자체가 정전화) 의 메타-cycle 패턴 명문화. ARCHITECTURE.md 또는 § 6.2 안 추가 paragraph 가능. 단 lessons_learned 자동 후속 발의 금지 (§ 6.2 정합)",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — 본 milestone v3.21 = 3단계 패턴 정전화 자체가 본 cycle 의 일부 (자기참조 cycle 3번째), 메타-cycle 정전화는 추가 cycle 누적 후 자연",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합)",
      "implication_lesson_cross_ref": ["v3.20 PROPOSE.next_candidates#2", "v3.21 본 milestone 자기참조 cycle 3번째"]
    },
    {
      "id": "v3.X_propose-register-책임-separation-evaluation",
      "title": "PROPOSE 의 register 책임 분리 가능성 평가 (v3.20 PROPOSE.next_candidates#3 + v3.19 #2 carry-over)",
      "approach": "v3.20 #3 + v3.19 #2 carry-over — PROPOSE 의 register 책임 (ROADMAP 등재 실 operation) 신규 REGISTER 단계 분리 가능성 평가. 9-stage → 10-stage 안 + breaking change v4.0 시나리오. v3.21 § 6.2 신 paragraph 'drift 수용 default + 실 변경 evidence-base trigger 만' narrative 강화 → 분리 trigger 미충족 narrative 강화 (v3.20 패턴 정합)",
      "trigger": "D_design",
      "trigger_type": "deferred",
      "trigger_condition": "외부 적용 milestone ≥10건 추가 누적 ∧ 사용자 명시 발의 AND. § 6.2 동결 강한 정합 (workflow self-improvement + breaking change risk)",
      "ROADMAP_등재": "거명만 (§ 6.2 동결, breaking change risk)",
      "implication_lesson_cross_ref": ["v3.20 PROPOSE.next_candidates#3", "v3.19 PROPOSE.next_candidates#2", "v3.21 § 6.2 신 paragraph drift 수용 default"]
    },
    {
      "id": "v3.X_phase-1-md-schema-canonicalization",
      "title": "phase-1.md JSON schema 'phase' 필드 의무 narrative 정전화 (v3.21 L2 후속)",
      "approach": "v3.21 L2 후속 — phase-1.md 작성 시 'phase' (정수) 필드 의무 narrative 정전화. claude/commands/harness-meta.md Stage F EXECUTE 절차 안 'execute/phase-{n}.md 작성 시 JSON 필드 의무' narrative 강화 또는 tests/CLAUDE.md 안 phase-1.md JSON schema 의무 narrative. 매우 작은 narrative 변경 (1~2 줄). 본 milestone § 6.2 신 paragraph (Narrative 정전화 3단계 패턴) 직접 적용 가능",
      "trigger": "C_improvement",
      "trigger_type": "deferred",
      "trigger_condition": "사용자 명시 발의 (A_user) — v3.21 L2 첫 발견 후 추가 누적 시점 자연. § 6.2 default 동결 정합 (workflow self-improvement narrative)",
      "ROADMAP_등재": "거명만 (§ 6.2 default 동결 정합)",
      "implication_lesson_cross_ref": ["v3.21 L2"]
    }
  ],
  "propose_summary": "v3.21 후속 candidate 4건 거명만 (ROADMAP 미등재 0건, § 6.2 default 동결 정합). 4건 중 1건 (#1 timing-a-canonicalization) = 5 cycle 누적 evidence 충족 (정전화 권장 trigger) / 1건 (#2 diagnose-then-canonicalize) = v3.20 carry-over / 1건 (#3 propose-register-separation) = v3.20 carry-over / 1건 (#4 phase-1-md-schema) = v3.21 L2 신규 origin. 모든 candidate 사용자 명시 발의 (A_user) trigger 대기 — 자동 후속 milestone 발의 부재 (도그푸드 자기참조 모순 표지 회피, § 6.2 정합). v3.20 PROPOSE.next_candidates#4 (roadmap-redefinition-evaluation) 는 § 6.2 동결 완화 결정 trigger 미충족 — 명시 carry-over 부재 (release train 회피 정합).",
  "trigger_conditions_narrative": "후속 milestone 발의 trigger 조건 — #1 timing-a-canonicalization: 사용자 명시 발의 AND (5 cycle 누적 evidence 충족 = 정전화 권장 trigger 자연 충족). #2 diagnose-then-canonicalize: 사용자 명시 발의 AND (추가 cycle 누적 후 자연). #3 propose-register-separation: 외부 적용 ≥10건 ∧ 사용자 명시 발의 AND (v3.20 동일). #4 phase-1-md-schema: 사용자 명시 발의 AND (v3.21 L2 첫 발견). 모든 옵션 § 6.2 default 동결 정합.",
  "absorbed_origins": {
    "user_explicit": "사용자 명시 발의 'narrative 정전화 3단계 패턴 명문화' (A_user trigger, /harness-meta meta 자유 발의 round Stage A AskUserQuestion 옵션 2 선택)",
    "stage_b_byproduct": "INTENT.out_of_scope 7건 — 워크플로우 본문 / smoke / 다른 host cross-ref / v3.20 carry-over / 5 관점 / 다른 host 거명 / L4 외 lessons. 모두 사실 진술, 후속 발의 명령형 없음 (v3.10 정책 정합)",
    "stage_c_byproduct": "RESEARCH.untouched_files_explicit 6건 (harness-meta.md / CLAUDE.md root / projects/meta/CLAUDE.md / tests / CHANGELOG / 다른 host) + RESEARCH.options 4건 (Option 3 채택 / 1/2/4 alternatives_rejected) + risks 6건 — 모두 사실 진술",
    "stage_d_byproduct": "DESIGN.decisions 6건 (D1~D6) 모두 사실 진술 + DESIGN.byproduct_check '사실 진술만, forward propose 명령형 부재' 직접 검증",
    "v3.10_dual_origin_check": "PROPOSE.next_candidates 4건 dual origin 통합 흡수 — (1) 사용자 명시 발의 A_user direct (#1 lightweight-1phase-commit-timing-a 직접) + (2) B/C/D 부산물 사실 진술 source + (3) v3.21 lessons L2/L5 신규 origin (#1 timing-a 5 cycle 충족 + #4 phase-1-md-schema) + (4) v3.20 next_candidates #2/#3 carry-over. v3.10 정책 정합"
  }
}
```

## narrative

본 PROPOSE 는 **dual origin 통합 흡수 책임** (v3.10 정책 정합):

1. **사용자 명시 발의** (A_user) — 'narrative 정전화 3단계 패턴 명문화' (Stage A AskUserQuestion 옵션 2 선택)
2. **B/C/D 부산물** — INTENT.out_of_scope 7건 + RESEARCH.untouched/options/risks + DESIGN.decisions 6건 사실 진술 → PROPOSE 단계 후속 흡수
3. **v3.21 lessons 신규 origin** — L2 (phase-1.md JSON schema phase 필드 의무) + L5 (commit timing (a) 5 cycle 누적) → next_candidates #4/#1
4. **v3.20 next_candidates carry-over** — #2 diagnose-then-canonicalize + #3 propose-register-separation → next_candidates #2/#3

모든 next_candidates `ROADMAP 등재 0건` (§ 6.2 default 동결 정합) — workflow self-improvement 본질 milestone 안 자기참조 모순 표지 의도성 정합. v3.17 + v3.18 + v3.19 + v3.20 패턴 정확 정합 (5 cycle 누적).

## 3단계 패턴 자기 적용 도그푸드 (메타-narrative)

본 PROPOSE 안 next_candidates #1 (timing-a-canonicalization) 가 발의될 때, 본 v3.21 § 6.2 신 paragraph 'Narrative 정전화 3단계 패턴' 가 직접 cross-ref 가능 — (a) DESIGN 정확 문구 1차 source + (b) EXECUTE Edit 그대로 + (c) VERIFY grep 검증 패턴 적용. 자기참조 cycle 메타-narrative.

## 관련

- INTENT (out_of_scope source): [`INTENT.md`](INTENT.md)
- RESEARCH (untouched/options/risks source): [`RESEARCH.md`](RESEARCH.md)
- DESIGN (decisions source): [`DESIGN.md`](DESIGN.md)
- VERIFY (PASS 8/8): [`VERIFY.md`](VERIFY.md)
- REPORT (lessons L1~L6 cross-ref): [`REPORT.md`](REPORT.md)
- v3.20 PROPOSE (next_candidates#2 origin + #3 carry-over source): [`../v3.20/PROPOSE.md`](../v3.20/PROPOSE.md)
- v3.19 PROPOSE 패턴 source: [`../v3.19/PROPOSE.md`](../v3.19/PROPOSE.md)
- v3.18 PROPOSE 패턴 source: [`../v3.18/PROPOSE.md`](../v3.18/PROPOSE.md)
- § 6.2 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
- § 6.2 신 paragraph (Narrative 정전화 3단계 패턴): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2 안 'Workflow self-improvement 동결 정책' 직후

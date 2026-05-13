# PROPOSE — v5.0 plugin-pivot

```json
{
  "next_candidates": [
    {
      "id": "plugin-component-discovery-fix",
      "title": "Plugin paths nested 인식 spec drift fix — Agents (0) + Skills (1 of 5) 인식 부족 해소",
      "origin": "v5.0 L7 lesson + Stage G VERIFY 발견 — claude plugin details 안 Agents (0) + Skills (1 of 5) 인식 부족 (R1 mitigation 안 'Stage G VERIFY 실 검증 mandatory' 정합 발견). paths 명시 array entry 형식 + sub-dir nested 인식 spec drift",
      "trigger": "A_user",
      "trigger_type": "spec_drift_fix",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "본 candidate 의 구체 책임 narrative + 추가 context7 검증 필요 + paths 형식 alternative 옵션 (agents/ root flat symlink/copy vs ${CLAUDE_PLUGIN_ROOT} 변수 활용 vs paths 부재 default 활용) 결정 — 사용자 명시 결정 후 ROADMAP 등재 (e3 정책 정합 v4.0~v4.3 패턴 누적)."
    },
    {
      "id": "narrative-canonicalization-3step-pattern-cycle-9",
      "title": "narrative 정전화 3단계 패턴 9 번째 cycle — v5.0 8 cycle 누적 후 추가 cycle (대상 milestone 분리, 사용자 발의 시)",
      "origin": "v5.0 L4 lesson — v3.21 패턴 누적 8 cycle 완성. cycle 9 trigger 조건 = cascade narrative 정전화 scope 큼 milestone (16+ 파일) + 사용자 명시 발의",
      "trigger": "C_improvement",
      "trigger_type": "narrative_canonicalization_pattern_continuation",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "패턴 자체 정전화 부재 (v3.21 안 명시 완료). 추가 cycle 은 자연 발현 default — narrative 거명만, ROADMAP 등재 부재 (자기참조 회피 표지)."
    },
    {
      "id": "spec-drift-verification-pattern-canonicalization",
      "title": "spec-drift 검증 패턴 narrative 정전화 — context7 검증 + 실 install/runtime 검증 2 단계 의무 명문화",
      "origin": "v5.0 L1 + L2 lesson — Plugin spec drift 3건 모두 Stage G 실 검증 시점 발견 + 즉시 보정. context7 검증 결과 100% 정합 부재 본질 narrative 정전화 잠재",
      "trigger": "C_improvement",
      "trigger_type": "workflow_narrative_canonicalization",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "workflow self-improvement 본질 = workflow narrative 자유 발의 (v4.0 § 6.2 폐지 후 자유). 다만 candidate 거명만 (사용자 명시 결정 후 ROADMAP 등재)."
    },
    {
      "id": "v5x-v4x-deprecation-narrative-cleanup",
      "title": "v5.0+ 환경 정착 후 v4.x deprecation 표지 narrative 자연 제거 — historical 보존 narrative 만 유지",
      "origin": "v5.0 D2 deprecation 표지 narrative — historical 보존 + 'deprecated since v5.0, v5.0+ 환경에서는 비활성' 표지 추가. v5.x cycle 자연 제거 carry-over",
      "trigger": "A_user",
      "trigger_type": "narrative_cleanup_natural_decay",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "본 candidate 의 trigger 조건 = v5.x 환경 정착 (v5.1+ 후속 milestone 누적 + 사용자 환경 안 v4.x 자연 cleanup 누적). 정확 trigger 시점 미확정 — 사용자 명시 발의 후 ROADMAP 등재."
    },
    {
      "id": "external-marketplace-registration",
      "title": "외부 marketplace 등록 (GitHub source) — claude plugin marketplace add pdw96/harness-meta 표준 onboarding 추가",
      "origin": "v5.0 INTENT.out_of_scope#3 사실 진술 — 본 milestone scope = local marketplace 만 (외부 marketplace 등록 부재). GitHub source 채택 시 사용자 onboarding 한 step 감소 (clone 부재, marketplace add 만)",
      "trigger": "A_user",
      "trigger_type": "onboarding_simplification",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "본 candidate 의 trade-off (local clone 보존 vs GitHub source 간소화) + GitHub repo public 정합 + tag/release 관리 narrative 결정 필요 — 사용자 명시 결정 후 ROADMAP 등재."
    }
  ],
  "propose_summary": "v5.0 milestone 의 forward proposal — next_candidates 5건 모두 narrative 거명만 (ROADMAP 등재 0건, e3 정책 정합 v4.0~v4.3 패턴 누적 5 번째). 단일 origin 통합 흡수 — (1) L7 paths nested 인식 drift (#1) + (2) L4 패턴 cycle continuation (#2) + (3) L1+L2 spec-drift 검증 패턴 (#3) + (4) D2 deprecation cleanup (#4) + (5) INTENT.out_of_scope#3 external marketplace (#5). v3.10 부산물 정책 정합 — 본 PROPOSE 단일 source 통합 흡수.\n\n본 milestone 의 핵심 forward = v5.1+ 후속 milestone 발의 narrative + ROADMAP entry 등재 (사용자 명시 결정 후만). v4.0 (정체성) → v4.3 (RESEARCH) → v5.0 (적용) 3 단계 cycle 완성, v5.1+ cycle 진입 (cleanup/extension 본질). 새 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 가 자연 가드레일."
}
```

## narrative

v5.0 milestone 의 forward 후속 = 5 candidates narrative 거명만. 본 milestone 산출물 안 forward propose 책임 단일 source = 본 PROPOSE.md + ROADMAP entry status: completed 갱신 (v5.0 자체).

origin 통합 분포:

- L1+L2 spec-drift 검증 패턴 origin: 1건 (#3)
- L4 narrative 정전화 3 단계 패턴 9 번째 cycle origin: 1건 (#2)
- L7 Plugin paths nested 인식 drift origin: 1건 (#1, R1 mitigation 직접 후속)
- D2 deprecation 표지 cleanup origin: 1건 (#4)
- INTENT.out_of_scope#3 external marketplace origin: 1건 (#5)

모두 narrative 거명 — 사용자 명시 결정 + 구체 책임 narrative 후 ROADMAP 등재. e3 정책 정합 (propose ≠ apply 분리, v4.0~v4.3 패턴 누적 5 번째).

## ROADMAP entry status 갱신 (Stage I 의무)

- 본 milestone (`v5.0_plugin-pivot`) status: `in_progress` → `completed` (Stage I 작업 시점, Stage G+H+I 통합 commit 안 일괄)
- next_candidates 5건 = narrative 거명만 (ROADMAP entry 등재 0)

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT: 모두 [`INTENT.md`](INTENT.md) ~ [`REPORT.md`](REPORT.md)
- 본 milestone next_candidates origin 명세: 위 next_candidates[] entry 안 `origin` 필드 (lessons_learned L1/L2/L4/L7 + INTENT.out_of_scope#3 + D2)
- e3 정책 정합 (propose ≠ apply 분리): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 + v4.0~v4.3 패턴
- v5.0 핵심 fix 3건 narrative source: [`VERIFY.md`](VERIFY.md) § "fix 3건 narrative"

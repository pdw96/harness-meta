# DESIGN — v3.14 deferred-revaluation-cycle-2

```json
{
  "id": "v3.14_deferred-revaluation-cycle-2",
  "self_reference_policy": "avoid",
  "subagent_review_policy": "skipped (§ 6.2 lightweight 모드 trigger 3 조건 모두 충족 — 메타 인프라 자체 변경 + scope ≤5 파일 + 5 관점 의견 충돌 부재 예상)",
  "decisions": [
    {
      "id": "D1",
      "decision": "옵션 A (동결 유지 cycle 2) 채택",
      "rationale": "RESEARCH evidence_summary 정합 — direct_naming 0 + indirect_impact 0 + reverse_evidence 5 = § 6.2 조건 (2) FAIL. 조건 (1) PASS (10건 누적) ∧ 조건 (2) FAIL = AND FAIL → 재발의 trigger 미충족. 옵션 B (재발의) 는 § 6.2 정책 위반 + 자기참조 사이클 재진입 risk (R2).",
      "alternatives_rejected": [
        "옵션 B (1건+ 재발의): evidence 0건 상태에서 재발의 시 release train 변질 risk + 자기참조 사이클 재진입 risk + v3.6 진단 경고 정면 위반"
      ]
    },
    {
      "id": "D2",
      "decision": "단일 phase 1 commit",
      "rationale": "lightweight 모드 정합 (v3.13 cycle 1 동일 패턴). 산출물 7종 (milestones.md + INTENT + RESEARCH + DESIGN + APPROVE + execute/phase-1 + VERIFY + REPORT + PROPOSE) 중 본질 변경 1건 = ROADMAP.md. INTENT~APPROVE commit 시점 패턴 (b) 채택 — Stage G VERIFY commit 안 4건 통합 (v3.13 패턴 정합)",
      "alternatives_rejected": [
        "다 phase 분할: ROADMAP 단일 변경 scope 작음 (≤1 파일) → 분할 의미 부재",
        "INTENT~APPROVE 별도 commit (패턴 c): 산출물 4건 통합 시 단일 commit 으로 충분"
      ]
    },
    {
      "id": "D3",
      "decision": "ROADMAP 갱신 범위 — `deferred_note` 본문 cycle 2 narrative 추가 + deferred 3건 entry `deferred_reason` 필드 cycle 2 cross-ref 갱신",
      "rationale": "단일 source 정합 — deferred_note 가 narrative 1차 source, 3 entry deferred_reason 은 cross-ref. v3.13 narrative 패턴 정합 (deferred_note 본문 + 3 entry deferred_reason 동시 갱신)",
      "alternatives_rejected": [
        "deferred_note 만 갱신 (entry deferred_reason 미변): cycle 누적 trace 단편화 risk",
        "신 필드 추가 (cycle_2_revaluation_cross_ref): schema 복잡도 증가 + 단일 source 분산 risk"
      ]
    },
    {
      "id": "D4",
      "decision": "다음 cycle trigger 조건 narrative — Stage I PROPOSE 안 명시 (본 DESIGN 안 phase scope 부재)",
      "rationale": "R5 mitigation (검토 사이클 무한 반복 risk) — 자동 cycle 진입 금지 narrative 가 forward propose 책임 (v3.10 부산물 정책 정합). DESIGN 안 narrative 명시 시 영역 침범 (forward propose 명령형 표현 risk)",
      "alternatives_rejected": [
        "DESIGN 안 trigger 조건 명시: v3.10 Stage B/C/D 부산물 정책 위반 (decisions[i].rationale = 사실 진술만)"
      ]
    },
    {
      "id": "D5",
      "decision": "본 milestone 자기참조 회피 표지 — milestones.md `self_reference_policy: avoid` + 본 DESIGN `subagent_review_policy: skipped` 명시",
      "rationale": "§ 6.2 lightweight 모드 정책 정합 + 도그푸드 (본 milestone 자체가 § 6.2 정책 적용 사례 trace)",
      "alternatives_rejected": [
        "자기참조 부합 (도그푸드) 표지: v3.6 진단 경고 정면 위반 risk + 자기참조 사이클 재진입"
      ]
    }
  ],
  "approach": "RESEARCH evidence 검증 (5 외부 적용 milestone 안 direct 0 + indirect 0 + reverse 5) → 옵션 A 단일 결정 → 단일 phase 1 commit (ROADMAP deferred_note + 3 entry deferred_reason cycle 2 cross-ref 갱신) → Stage G VERIFY commit 안 산출물 4건 통합 → Stage I PROPOSE 다음 cycle trigger 조건 narrative 추가. lightweight 모드 표지 (self_reference_policy: avoid + 5 관점 subagent 생략 + LOC cap 적용).",
  "phases": [
    {
      "n": 1,
      "title": "ROADMAP narrative 갱신 — deferred_note cycle 2 + 3 entry deferred_reason cross-ref",
      "scope": "projects/meta/ROADMAP.md 단일 파일 갱신 — (a) deferred_note 본문 cycle 2 narrative 추가 (cycle 1 narrative 압축 + cycle 2 신규 evidence 카운트 명시 + AND FAIL verdict + 옵션 A 채택 narrative), (b) deferred 3건 entry (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) deferred_reason 필드 cycle 2 cross-ref 갱신 (v3.14_deferred-revaluation-cycle-2 + 2026-05-13 명시), (c) updated 필드 2026-05-13 갱신 (이미 OPEN 단계에서 갱신 완료).",
      "affected_files": [
        "projects/meta/ROADMAP.md",
        "projects/meta/milestones/v3.14/execute/phase-1.md"
      ],
      "rationale": "lightweight 모드 정합 + 단일 phase 1 commit 결정 (D2) 정합. ROADMAP 단일 파일 변경으로 cycle 2 결정 narrative 완결.",
      "risks": [
        "R4 (deferred_note narrative 길이 폭증) — mitigation: cycle 1 narrative 압축 + cycle 2 신규 narrative 추가 시 단일 단락 유지 (총 length 200% 이내 권고)",
        "R3 (cycle 2 narrative 중복 risk) — mitigation: cycle 2 신규 evidence (v1.10~v1.14 5건 추가 누적 + AND FAIL verdict + reverse_evidence 5 카운트) 명시 — cycle 1 와 명확히 구분"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "description": "cycle 검토 사이클 진입 자체 의문 (검토 의식 over-engineering)",
      "mitigation": "본 milestone 자체가 § 6.2 정책 evidence-base trigger 정상 작동 trace — cycle 진입 자체가 정책 검증 목적 정합. memory project_deferred_3_freeze_decision_2026_05_12.md 누적 (cycle 0/1/2) trace 단일 source 보존"
    },
    {
      "risk_id": "R2",
      "description": "본 milestone 자체가 workflow self-improvement 영역 인접 → § 6.2 동결 정책 위반 risk",
      "mitigation": "§ 6.2 정책 narrative 자체 변경 부재 (out_of_scope #1 명시) + lightweight 모드 표지 (self_reference_policy: avoid milestones.md + subagent_review_policy: skipped DESIGN) + LOC cap 적용 + 5 관점 subagent 검토 생략. 정책 적용 검토 ≠ 정책 narrative 변경"
    },
    {
      "risk_id": "R3",
      "description": "옵션 A 결정 narrative 가 cycle 1 (v3.13) 와 중복 risk",
      "mitigation": "cycle 2 신규 evidence 추가 명시 — v1.10~v1.14 5건 외부 적용 milestone reverse_evidence 카운트 (5건) + 누적 카운트 명시 변경 (cycle 1 시점 9건 → cycle 2 시점 10건 / cycle 1 narrative 누적 3회 → cycle 2 시점 4회) + AND verdict 명시 (조건 (1) PASS ∧ 조건 (2) FAIL = AND FAIL)"
    },
    {
      "risk_id": "R4",
      "description": "ROADMAP deferred_note narrative 길이 폭증 risk",
      "mitigation": "cycle 1 narrative 압축 + cycle 2 신규 narrative 추가 — 전체 length 단일 단락 유지 (총 length 200% 이내 권고, 약 1300자 임계)"
    },
    {
      "risk_id": "R5",
      "description": "검토 사이클 자체 무한 반복 (cycle 3, 4, 5 ...) risk",
      "mitigation": "Stage I PROPOSE 단계에서 다음 cycle trigger 조건 명시 — '추가 외부 적용 milestone 5건 이상 누적 + 사용자 명시 발의' AND 조건 (v3.13 cycle 1 → v3.14 cycle 2 시점 5건 추가 누적 패턴 정합 — 동일 임계 적용). 자동 cycle 진입 금지 narrative + 사용자 의식 발의만 trigger"
    }
  ]
}
```

## 5 관점 subagent 검토 생략 표지

§ 6.2 lightweight 모드 정책 정합 — 본 milestone trigger 3 조건 모두 충족:

1. 본질이 workflow / smoke / cross-ref / era 분기 등 메타 인프라 자체 변경 (외부 프로젝트 적용 부재) ✓ — ROADMAP narrative 갱신 본질
2. 변경 scope 작음 (≤5 파일 또는 narrative 강화 중심) ✓ — 단일 파일 (ROADMAP.md) 갱신
3. 5 관점 의견 충돌 부재 예상 (architecture / 보안 분기 부재) ✓ — 정책 narrative 변경 부재 + 단순 cross-ref 갱신

선례 정합: v2.0_workflow-word-fidelity (자기참조 회피 표지) + v3.6_overengineering-audit (§ 6.2 도입 자체가 lightweight 모드) + v3.13_pending-milestone-renumber-policy (cycle 1 동일 패턴) + v3.10/11/12 (Lightweight 모드 narrative cleanup 적용).

## 자기참조 회피 검증 (도그푸드)

본 DESIGN 안 forward propose 명령형 표현 부재 검증 — `decisions[i].rationale` 와 `phases[n].scope` 안 'PROPOSE.md `next_candidates` 발의 narrative' / '별 milestone 으로' / '후속 milestone 안 처리' 등 forward propose 명령형 표현 0건 (v3.10 부산물 정책 정합). 후속 발의 책임 = Stage I PROPOSE 단일 흡수.

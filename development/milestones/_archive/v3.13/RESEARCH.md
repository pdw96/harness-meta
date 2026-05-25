# RESEARCH — v3.13 pending-milestone-renumber-policy

본 milestone 의 조사 (external / codebase / options / risks_identified). 결정 (decisions) 은 DESIGN.md 로 미룸.

```json
{
  "id": "v3.13_pending-milestone-renumber-policy",
  "external": [
    {
      "source": "projects/meta/ARCHITECTURE.md § 6.2",
      "topic": "Workflow self-improvement milestone 동결 정책 (v3.6 권고 #1)",
      "findings": "workflow self-improvement (claude/commands/harness-meta.md / tests/CLAUDE.md / 본 ARCHITECTURE.md § 4 변경) 만을 본질로 하는 milestone 은 evidence-base trigger 만 발의 허용 — release train (정기 narrative 강화) 또는 lessons_learned 자동 후속 등재로 발의 금지. 발의 trigger 조건: 외부 프로젝트 (projects/<name>/, name ≠ meta) 실 적용 milestone 1건 완료 후, 그 정량 데이터에 근거한 명시적 사용자 발의만. 본 milestone 대상 v1.x pending 3건이 모두 이 정책 직접 적용 대상 (workflow self-improvement 본질 + 외부 적용 데이터 부재).",
      "drift": "없음 (정책 source 직접 인용)"
    },
    {
      "source": "projects/meta/ARCHITECTURE.md § 6.1",
      "topic": "era 정책 (forward-only) + bundling",
      "findings": "v3.0+ 9-stage-bundled era 만 신규 작업 의무 (forward-only). v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier 는 참조용 보존. ROADMAP `milestones[]` entry 의 id 가 v1.x_{slug} / v2.x_{slug} 형태인 pending 항목은 신 era 작업 시 v3.X 신 schema 로 renumber 의무 (renumbered_from 필드).",
      "drift": "없음 (v3.11_legacy-narrative-cleanup 가 동일 패턴 첫 적용 사례)"
    },
    {
      "source": "projects/meta/milestones/v3.11/ROADMAP entry + RESEARCH.md + REPORT.md",
      "topic": "renumber 선례 — v1.5_legacy-narrative-cleanup → v3.11_legacy-narrative-cleanup",
      "findings": "ROADMAP entry 갱신 패턴: (1) 신 v3.X entry 추가 (신 schema version/id 분리 + milestones_path + renumbered_from 필드), (2) 구 v1.x entry 제거 (forward-only). v3.13 동일 패턴 적용 (OPEN stage 에서 이미 ROADMAP 갱신 완료).",
      "drift": "없음 (v3.11 패턴 1:1 적용)"
    },
    {
      "source": "projects/meta/milestones/v3.10_stage-byproduct-clarification/",
      "topic": "A_user trigger 예외 첫 사용 사례",
      "findings": "v3.10 가 사용자 명시 발의 (A_user trigger) 로 § 6.2 동결 정책 적용 대상이 될 수 있는 영역 침범 narrative 명료화를 진행. INTENT.dependencies 안 A_user trigger 충족 명시. 본 v3.13 도 사용자 명시 선택 (v2.1_pending-milestone-renumber-policy pending entry 사용자 직접 선택) 으로 A_user trigger 재분류 — § 6.2 예외 두 번째 사용 사례.",
      "drift": "없음 (v3.10 선례 1:1 적용)"
    },
    {
      "source": "projects/meta/milestones/v2.0_workflow-word-fidelity/REPORT.md lessons next_candidates",
      "topic": "본 milestone 의 ROADMAP entry 자동 등재 origin",
      "findings": "v2.0 lessons next_candidates#1 = 'v1.x pending milestone 4건의 9-stage workflow 적용 정책 결정'. v2.0 D11 (out_of_scope) 의 직접 후속. 이 자동 등재 자체가 § 6.2 발의 금지 조건 'lessons_learned 자동 후속 등재' 와 정확히 일치 → 본 milestone 진입 자체가 사용자 명시 발의로 재분류 (A_user trigger) 의무.",
      "drift": "ROADMAP 안 v2.1_pending-milestone-renumber-policy entry trigger 필드가 'D_design' 으로 표기됨 (자동 등재 시점 v2.0 REPORT 가 'D_design' 으로 분류) — 본 milestone 진입 시점에 'A_user' 로 재분류 (renumbered_from 필드와 동시)"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ROADMAP.md (1 file)"
    ],
    "untouched_files_explicit": [
      "projects/meta/milestones/v1.4_cross-ref-propagation/REPORT.md — historical 보존 (v1.5_legacy-narrative-cleanup origin RESEARCH 안 v1.4 next_candidates 거명, forward-only)",
      "projects/meta/milestones/v1.4_infra-minimization/REPORT.md — historical 보존 (v1.4 pending next_candidates 자연 cross-ref)",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/REPORT.md — historical 보존 (lessons next_candidates#1 origin, v3.13 OPEN 시점 source)",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/PROPOSE.md, DESIGN.md — historical 보존 (v2.1 era 9-stage 자연 cross-ref)",
      "projects/meta/milestones/v1.3_harness-engineering-definition/{INTENT,DESIGN,VERIFY,REPORT}.md — historical 보존 (v1.4 next_candidates 거명, era 정책 부합)",
      "claude/commands/harness-meta.md — 본 milestone out_of_scope (workflow 자체 변경 부재)",
      "tests/CLAUDE.md — 본 milestone out_of_scope (smoke 변경 부재)",
      "projects/meta/ARCHITECTURE.md — 본 milestone out_of_scope (§ 4 정의 변경 부재, § 6.2 정책 적용만)"
    ],
    "current_state": {
      "roadmap_v1.4_hook-narrative-separation_status": "pending",
      "roadmap_v1.4_design-review-trace_status": "pending",
      "roadmap_v1.5_research-cascade-grep-discipline_status": "pending",
      "roadmap_deferred_note": "v3.6 시점 narrative 만 보유 — 'v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 (구 pending) 는 v3.6_overengineering-audit 에 의해 defer'. v1.x pending 3건 의 deferred 처리 narrative 부재",
      "roadmap_v3.13_entry": "OPEN stage 에서 추가 완료 (status: in_progress, milestones_path 명시, renumbered_from 명시)",
      "roadmap_v2.1_pending-milestone-renumber-policy_entry": "OPEN stage 에서 제거 완료 (v3.11 선례 forward-only)"
    },
    "target_state": {
      "roadmap_v1.4_hook-narrative-separation_status": "deferred",
      "roadmap_v1.4_design-review-trace_status": "deferred",
      "roadmap_v1.5_research-cascade-grep-discipline_status": "deferred",
      "roadmap_3_entries_deferred_reason": "각 entry 에 deferred_reason 필드 추가 — § 6.2 동결 정책 cross-ref + 재발의 trigger 조건 (외부 upbit 적용 데이터 + 사용자 명시 발의) 명시",
      "roadmap_deferred_note": "v3.6 + v3.13 narrative 누적 — v1.x pending 3건 도 § 6.2 동결 정책 직접 적용으로 defer (외부 적용 데이터 대기)",
      "roadmap_v3.13_entry": "Stage I PROPOSE 에서 status 'completed' 갱신"
    }
  },
  "options": [
    {
      "id": "A",
      "label": "defer + 외부 적용 데이터 대기 (§ 6.2 동결 정책 직접 적용)",
      "pros": [
        "§ 6.2 동결 정책 직접 부합 (workflow self-improvement 발의 trigger 조건 충족까지 대기)",
        "Lightweight 모드 자연 적용 (ROADMAP.md 단일 파일 변경, 5 관점 subagent 생략)",
        "ROADMAP 안 'pending' status 잔존이 § 6.2 동결과 모순 → status 'deferred' 명시로 narrative drift 해소",
        "v3.6_overengineering-audit 결정 후 두 번째 적용 사례 (정책 narrative 강화)",
        "외부 upbit milestone 적용 후 정량 데이터 기반 재발의 = evidence-base 부합"
      ],
      "cons": [
        "v1.x pending 3건 자체의 실 구현은 외부 데이터까지 미룸 (즉각 효용 부재)",
        "deferred_reason 필드 추가 = 신 ROADMAP 스키마 필드 (선례 v3.11 entry 안 deferred_note 와 별개)"
      ]
    },
    {
      "id": "B",
      "label": "v3.13 bundle 로 3건 sub-milestone 실행 (§ 6.2 위배)",
      "pros": [
        "v1.x pending 3건의 ROADMAP 잔존 해소 (즉각 완료)",
        "v3.0+ 9-stage-bundled era bundling 패턴 활용"
      ],
      "cons": [
        "§ 6.2 동결 정책 위배 (외부 적용 데이터 부재 상태에서 workflow self-improvement 3건 실행)",
        "v3.6_overengineering-audit 결정 직접 위반 → 정책 narrative 정합성 훼손",
        "Lightweight 모드 부적합 (3 phase × workflow narrative = LOC cap 위배 위험)"
      ]
    },
    {
      "id": "C",
      "label": "개별 v3.14/v3.15/v3.16 분리 milestone 으로 renumber (release train 위배)",
      "pros": [
        "각 milestone 의 책임 분리 (forward-only era 정책 부합)",
        "v3.11 선례 동일 패턴 (1:1 renumber)"
      ],
      "cons": [
        "§ 6.2 동결 정책 위배 (3개 workflow self-improvement milestone 동시 발의 = release train 패턴 자체)",
        "v3.6_overengineering-audit 진단 결과 'workflow self-improvement 9/24 milestone' 비율 악화"
      ]
    }
  ],
  "risks_identified": [
    {
      "risk": "deferred_reason 필드가 신 ROADMAP 스키마 필드 → 기존 smoke 가 unknown 필드를 차단할 가능성",
      "mitigation": "DESIGN 단계에서 smoke (smoke-spec-verification / smoke-scope-contract) 의 ROADMAP schema 검증 수준 확인 → 필요 시 schema_note 갱신",
      "severity": "low"
    },
    {
      "risk": "ROADMAP `updated` 필드 갱신 누락 (2026-05-12 → 그대로) → 본 milestone 변경 시점 trace 손실",
      "mitigation": "EXECUTE phase 에서 ROADMAP `updated` 동일 (today=2026-05-12) 확인",
      "severity": "low"
    },
    {
      "risk": "ROADMAP `deferred_note` narrative 추가 시 기존 v3.6 narrative 와 cascade 부정합 (v3.6 narrative 만 보유 → v3.13 narrative 추가 후 entry 거명 명시 부재 시)",
      "mitigation": "EXECUTE phase 에서 deferred_note 안 본 milestone (v3.13) 거명 + v1.x pending 3건 entry 거명 명시",
      "severity": "low"
    },
    {
      "risk": "v1.x pending 3건 entry 의 origin RESEARCH/REPORT (historical milestone) 안 'next_candidates' / 'pending' 거명이 status 변경 후 narrative drift 가능성",
      "mitigation": "historical milestone 산출물은 forward-only 보존 (v3.11 패턴, ARCHITECTURE § 6.1) — 산출 시점 narrative 그대로 유지, 본 milestone 의 ROADMAP entry 갱신만 1차 source 갱신",
      "severity": "low"
    },
    {
      "risk": "본 milestone 진입 자체가 § 6.2 발의 금지 조건 (lessons_learned 자동 후속 등재) 와 정확히 일치 — A_user trigger 재분류 narrative 가 약하면 정책 위배 사례",
      "mitigation": "INTENT.motivation + dependencies 안 사용자 명시 발의 narrative 명시 완료 (v3.10 선례 동일 패턴). ROADMAP entry renumbered_from 필드 + trigger A_user 표기 cascade",
      "severity": "low"
    },
    {
      "risk": "smoke-bundle-trigger.sh 가 v3.13 entry status: in_progress + milestones_path 필드 + 실 파일 존재 3 조건 검증 — milestones.md 미작성 시 FAIL",
      "mitigation": "OPEN stage step 7 에서 milestones.md 스켈레톤 작성 완료 (이미 충족, v3.4_open-stage-milestones-md-protocol 부합)",
      "severity": "low (이미 mitigated)"
    }
  ]
}
```

## 자기참조 회피 표지

본 milestone 은 Lightweight 모드 (§ 6.2 trigger 3건 충족) — 자기참조 도그푸드 거부 + 회피 표지 의무. milestones.md 안 `self_reference_policy: "avoid"` + `self_reference_rationale` 필드 표기 (OPEN stage 에서 명시 완료).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- ARCHITECTURE § 6.1 + § 6.2: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- renumber 선례: [`../v3.11/`](../v3.11/) (v1.5 → v3.11)
- 동결 정책 도입: [`../v3.6_overengineering_audit/`](../v3.6_overengineering_audit/)
- A_user trigger 예외 첫 사용: [`../v3.10/`](../v3.10/)
- 자동 등재 origin: [`../v2.0_workflow-word-fidelity/REPORT.md`](../v2.0_workflow-word-fidelity/REPORT.md)

# DESIGN — v3.13 pending-milestone-renumber-policy

본 milestone 의 설계 (decisions / approach / phases / risk_mitigation). § 6.2 lightweight 모드 — 5 관점 subagent 검토 생략 (trigger 3건 충족: ROADMAP entry policy narrative + 단일 파일 변경 + 충돌 부재 예상). v3.10 / v3.11 lightweight 선례 동일 패턴.

```json
{
  "id": "v3.13_pending-milestone-renumber-policy",
  "decisions": [
    {
      "id": "D1",
      "decision": "옵션 A 채택 — § 6.2 동결 정책 직접 적용 + defer + 외부 적용 데이터 대기",
      "rationale": "v1.x pending 3건이 모두 workflow self-improvement 본질 (claude/commands/harness-meta.md / hook 구조 / RESEARCH 템플릿 강화). § 6.2 발의 trigger 조건 (외부 projects/<name> 실 적용 milestone 1건 완료 후 정량 데이터 기반 명시 발의) 미충족 → 옵션 B (즉시 실행) 는 정책 직접 위반, 옵션 C (개별 renumber 실행) 는 release train 패턴. 옵션 A 만 § 6.2 부합 + lightweight 모드 자연 적용.",
      "alternatives_rejected": [
        "옵션 B (v3.13 bundle 3건 실행) — § 6.2 위배",
        "옵션 C (개별 v3.14/v3.15/v3.16 분리) — release train 위배 + workflow self-improvement 비율 악화"
      ]
    },
    {
      "id": "D2",
      "decision": "Lightweight 모드 표지 + 5 관점 subagent 생략",
      "rationale": "§ 6.2 trigger 3건 충족: (1) 본질이 ROADMAP entry policy narrative (외부 프로젝트 적용 부재), (2) 변경 scope = ROADMAP.md 단일 파일 1 phase, (3) 5 관점 의견 충돌 부재 예상 (architecture / 보안 분기 부재 — 단순 status flip + narrative 추가). milestones.md 안 self_reference_policy: 'avoid' + self_reference_rationale 명시 완료 (OPEN stage).",
      "alternatives_rejected": [
        "5 관점 병렬 subagent 검토 — lightweight 모드 부적합 (LOC cap 위반 risk + v3.6 동결 정책과 모순 — workflow self-improvement 검토 자체가 본 정책 위반)"
      ]
    },
    {
      "id": "D3",
      "decision": "ROADMAP entry 3건 status 'pending' → 'deferred' + deferred_reason 필드 신규 도입",
      "rationale": "smoke-bundle-trigger.sh 가 status: pending 일 때 milestones_path 부재 허용 (continue) / in_progress|completed 일 때 검증 의무. 'deferred' 는 신 status — smoke 직접 검증 부재 (continue 동치 처리, unknown status 차단 부재 확인). deferred_reason 필드는 신 ROADMAP 스키마 필드, smoke unknown 필드 통과 (smoke-bundle-trigger.sh 안 status='pending' continue / 그 외 milestones_path 검증만, status 값 enumerate 부재).",
      "alternatives_rejected": [
        "status 'pending' 유지 + deferred_note 만 갱신 — narrative drift (status 와 narrative 불일치)",
        "ROADMAP schema 정식 변경 (deferred status enum 추가) — out_of_scope, workflow 변경 부재 원칙 위반"
      ]
    },
    {
      "id": "D4",
      "decision": "ROADMAP `deferred_note` 필드 갱신 — 기존 v3.6 narrative + 본 v3.13 결정 누적",
      "rationale": "기존 deferred_note 는 v3.6_milestones-md-validation-extension + v3.7_workflow-narrative-strengthening-v2 거명만. v1.x pending 3건의 deferred 처리 narrative 부재 → 본 milestone 결정 후 deferred_note 안 'v1.x pending 3건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 도 § 6.2 동결 정책 적용으로 defer (외부 upbit 적용 데이터 대기, v3.13 결정)' 추가.",
      "alternatives_rejected": [
        "각 entry 의 deferred_reason 만 갱신 + deferred_note unchanged — 단일 narrative source 부재 (v3.6 narrative cascade 위반)"
      ]
    },
    {
      "id": "D5",
      "decision": "v3.13 ROADMAP entry 는 OPEN stage 추가 완료 — EXECUTE 에서 변경 부재, Stage I PROPOSE 에서 status 'in_progress' → 'completed'",
      "rationale": "v3.11 선례 동일 패턴. OPEN step 6 에서 신 schema entry 추가 + step 7 에서 milestones.md 스켈레톤 작성. EXECUTE phase-1 의 ROADMAP 갱신 책임은 v1.x pending 3건 entry 만 (v3.13 entry 자체는 PROPOSE 책임).",
      "alternatives_rejected": [
        "EXECUTE phase 안 v3.13 entry status 갱신 — Stage 책임 혼재 (PROPOSE 단일 책임 위반)"
      ]
    },
    {
      "id": "D6",
      "decision": "단일 phase (phase-1) — ROADMAP.md 단일 파일 변경",
      "rationale": "lightweight 모드 정합 — 3 entry status flip + 1 narrative 갱신 = atomic 변경. phase 분할 시 산출물 LOC 양산 (v3.6 progressive disclosure 부합).",
      "alternatives_rejected": [
        "3 phase 분리 (각 entry per phase) — overengineering, lightweight 위반"
      ]
    },
    {
      "id": "D7",
      "decision": "historical milestone 산출물 안 거명 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 은 forward-only 보존 — cleanup 부재",
      "rationale": "v3.11 선례 동일 패턴. RESEARCH untouched_files_explicit 안 명시 완료 (v1.4_cross-ref-propagation/REPORT.md, v1.4_infra-minimization/REPORT.md, v1.3_harness-engineering-definition/* 등 historical 산출물 모두 unchanged). § 6.1 forward-only 정책 직접 부합.",
      "alternatives_rejected": [
        "historical 산출물 안 status 'pending' → 'deferred' cascade 갱신 — forward-only 정책 위배 + git history 위험"
      ]
    },
    {
      "id": "D8",
      "decision": "A_user trigger 재분류 narrative 명시 — ROADMAP v3.13 entry trigger 'A_user' + renumbered_from 필드 + INTENT.motivation/dependencies 명시",
      "rationale": "본 milestone 자동 등재 origin (v2.0 lessons next_candidates#1, D_design trigger) 이 § 6.2 발의 금지 조건 정확히 일치. 사용자 명시 발의로 재분류 → v3.10 예외 첫 사용 사례 동일 패턴. 정책 위배 narrative 약화 시 본 milestone 자체가 § 6.2 위반 사례.",
      "alternatives_rejected": [
        "trigger D_design 유지 — § 6.2 발의 금지 조건 일치, 본 milestone 진입 자체 정책 위반"
      ]
    }
  ],
  "approach": "단일 phase 안에서 ROADMAP.md 의 v1.x pending 3건 entry 갱신 (status 'pending' → 'deferred' + deferred_reason 신 필드 추가) + ROADMAP.deferred_note 갱신 (v3.13 결정 narrative 누적). v3.13 entry 는 OPEN stage 추가 완료, Stage I PROPOSE 에서 status 'completed' 갱신 (EXECUTE 변경 부재). historical milestone 산출물 forward-only 보존. pre-commit 14 hook 검증 후 commit.",
  "phases": [
    {
      "n": 1,
      "title": "ROADMAP entry 3건 deferred 처리 + deferred_note 갱신",
      "scope": "projects/meta/ROADMAP.md 단일 파일 갱신 — v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline 의 status 'pending' → 'deferred' + 각 entry 에 deferred_reason 필드 추가 (§ 6.2 동결 정책 cross-ref + 재발의 trigger 조건 명시) + deferred_note 갱신 (v3.6 narrative + v3.13 결정 누적).",
      "affected_files": [
        "projects/meta/ROADMAP.md",
        "projects/meta/milestones/v3.13/execute/phase-1.md"
      ],
      "rationale": "단일 atomic 변경 — lightweight 모드 정합. Stage D 완료 시점에 milestones.md sub_milestones[] 1:1 동기 갱신 (placeholder title 교체).",
      "risks": [
        "pre-commit 14 hook 안 smoke-bundle-trigger.sh 가 status: 'deferred' 를 unknown 으로 처리 시 FAIL 가능성 — 검증 의무 (risk_mitigation R1 참조)",
        "deferred_reason 신 필드가 smoke schema 검증 차단 가능성 — 검증 의무 (R1)",
        "ROADMAP json block parse error (콤마 / 따옴표 escape) — Edit tool 사용 + 사후 pre-commit 검증으로 mitigate"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "smoke-bundle-trigger.sh 가 status: 'deferred' 를 unknown 으로 처리 시 FAIL",
      "mitigation": "smoke 코드 재확인 — `if status == 'pending': continue` (line 93-94). 그 외 status 는 milestones_path 검증으로 진행. v1.x_{slug} flat entry (version 필드 부재) 는 line 86-88 에서 historical entry skip (`if not isinstance(version, str): continue`). 즉 v1.x_{slug} entry 의 status 값 자체는 smoke 무시 → 'deferred' 변경 safe.",
      "severity": "low"
    },
    {
      "risk": "deferred_reason 신 필드가 smoke schema 검증 차단",
      "mitigation": "smoke-bundle-trigger.sh + smoke-projects-scope-discipline.sh 모두 unknown 필드 추가 검증 부재 (allowlist 패턴 부재) — safe. ROADMAP JSON schema 정식 정의 부재 = 신 필드 자유 추가 가능.",
      "severity": "low"
    },
    {
      "risk": "ROADMAP `deferred_note` narrative 안 cascade 부정합 (v3.6 narrative vs v3.13 narrative)",
      "mitigation": "EXECUTE phase 에서 deferred_note 안 (1) 기존 v3.6 narrative 보존 + (2) v3.13 결정 추가 + (3) entry 거명 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 명시.",
      "severity": "low"
    },
    {
      "risk": "ROADMAP `updated` 필드 갱신 누락 → 본 milestone 변경 시점 trace 손실",
      "mitigation": "EXECUTE phase 에서 ROADMAP `updated` 확인 (today=2026-05-12, 이미 today 와 일치 — 갱신 부재 가능). 일치 시 명시적 noop, 부일치 시 갱신.",
      "severity": "low"
    },
    {
      "risk": "본 milestone 진입 자체 § 6.2 발의 금지 조건 일치 → A_user trigger 재분류 narrative 약화 시 정책 위반 사례",
      "mitigation": "INTENT.motivation + INTENT.dependencies + ROADMAP entry trigger 'A_user' + renumbered_from 3중 cascade 로 narrative 강화 (D8 부합). v3.10 선례 동일 패턴.",
      "severity": "low (이미 mitigated)"
    },
    {
      "risk": "milestones.md placeholder title 교체 누락 (Stage D 완료 직전 의무 step, v3.5 phase-2 도입)",
      "mitigation": "DESIGN 완료 직후 milestones.md sub_milestones[0].title 교체 (DESIGN.phases[0].title 와 동치 갱신). v3.5_open-stage-discipline-strengthening phase-2 narrative 부합.",
      "severity": "medium"
    }
  ]
}
```

## 5 관점 자기 검토 (lightweight, 1~2 문장 명시)

| 관점 | 검토 결과 (자기 검토) |
|------|----------------------|
| architecture | ROADMAP.md 단일 파일 변경 + 기존 schema 호환 (unknown 필드 자유 추가) — 디렉토리 구조 / 파일 책임 변경 부재. |
| spec-drift | § 6.2 동결 정책 (ARCHITECTURE.md L194) 직접 cross-ref + v3.6 narrative cascade (deferred_note) — 외부 spec 정합. |
| 회귀 risk | pre-commit 14 hook 모두 status 'deferred' / deferred_reason 필드 검증 부재 확인 — 회귀 0 예상. VERIFY 단계 검증. |
| 보안 | 분기 부재 — ROADMAP narrative 갱신만 (외부 호출 / 권한 변경 부재). |
| scope contract | INTENT.success_criteria 7건 → DESIGN.phases[0] 1:1 매핑 (SC1~SC5 = ROADMAP 갱신 / SC6 = milestones.md 동기 / SC7 = pre-commit). |

## Stage D 완료 직전 의무 step (v3.5 phase-2 도입)

`phases[]` 확정 직후 → `milestones/v3.13/milestones.md` `sub_milestones[]` 를 `phases[]` 와 1:1 동기 갱신 의무. 본 DESIGN 작성 직후 동시 갱신 실행 (1 entry placeholder title 교체).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- ARCHITECTURE § 6.1 + § 6.2: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- Lightweight 선례: [`../v3.11/`](../v3.11/), [`../v3.10/`](../v3.10/), [`../v3.6_overengineering_audit/`](../v3.6_overengineering_audit/)
- smoke-bundle-trigger source: [`../../../../tests/smoke-bundle-trigger.sh`](../../../../tests/smoke-bundle-trigger.sh)

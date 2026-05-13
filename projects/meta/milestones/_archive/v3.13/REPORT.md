# REPORT — v3.13 pending-milestone-renumber-policy

본 milestone 의 종합 backward (summary / delta / lessons_learned). 9-stage workflow Stage H — forward (next_candidates) 는 PROPOSE.md 분리 책임 (v2.0_workflow-word-fidelity).

```json
{
  "id": "v3.13_pending-milestone-renumber-policy",
  "summary": [
    "v2.0_workflow-word-fidelity lessons next_candidates#1 origin 의 v1.x pending 잔여 3건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline) 의 era 명명 vs workflow 일치 정책을 결정한 milestone. v3.0_milestones-restructure 도입 forward-only era 정책 (§ 6.1) + v3.6_overengineering-audit § 6.2 workflow self-improvement 동결 정책의 두 결정이 본 milestone 대상 3건을 모두 동결 대상으로 만들었고, 옵션 A (defer + 외부 적용 데이터 대기) 채택으로 정책 narrative 정합화.",
    "사용자 명시 선택 (v2.1_pending-milestone-renumber-policy pending entry 직접 선택) 으로 A_user trigger 재분류 — v3.10_stage-byproduct-clarification 의 § 6.2 A_user trigger 예외 두 번째 사용 사례. Lightweight 모드 (§ 6.2 trigger 3건 충족) 자연 적용 — ROADMAP.md 단일 파일 변경, 1 phase 1 commit (a86334c), 5 관점 subagent 검토 생략 + 자기 검토 narrative 표 1건. v3.11_legacy-narrative-cleanup (v1.5 → v3.11 renumber) 직후 두 번째 renumber 사례, 다만 v3.11 은 실 실행 → renumber 반면 본 milestone 은 defer → renumber + entry status flip.",
    "INTENT.success_criteria 7건 모두 VERIFY.criteria_check PASS, pre-commit 14 hook + smoke 직접 3건 모두 PASS, 회귀 0. 산출물 7종 + milestones.md + execute/phase-1.md = 9 산출 (모두 MD + JSON 코드블록). Stage G/H/I + INTENT~APPROVE 산출물 통합 commit 패턴 (b) 채택 — phase-1 commit 후 4 산출물 (INTENT/RESEARCH/DESIGN/APPROVE) + milestones.md + Stage G/H/I = Stage G commit 안 통합 보존."
  ],
  "delta": {
    "files_changed": 1,
    "files_added": 9,
    "files_deleted": 0,
    "lines_changed_total": "+20 / -14 (ROADMAP.md, phase-1 commit) + 산출물 9건 신규 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + milestones.md + execute/phase-1.md)",
    "modules_affected": [
      "projects/meta/ROADMAP.md (deferred_note + 3 entry status/deferred_reason 갱신)",
      "projects/meta/milestones/v3.13/ (신규 디렉토리 + 9 산출물)"
    ],
    "commits": [
      {
        "hash": "a86334c",
        "phase": 1,
        "message": "feat(meta): v3.13 phase-1 — ROADMAP entry 3건 deferred 처리 + deferred_note 갱신",
        "files": ["projects/meta/ROADMAP.md", "projects/meta/milestones/v3.13/execute/phase-1.md"]
      }
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "§ 6.2 동결 정책의 'lessons_learned 자동 후속 등재 발의 금지' 조건은 ROADMAP 안 기존 pending entry 의 trigger 분류와 직접 충돌할 수 있다. v2.1_pending-milestone-renumber-policy entry 의 trigger 'D_design' 은 v2.0 자동 등재 시점 분류 — § 6.2 도입 후 본 entry 진입 자체가 정책 위반 사례가 될 위험.",
      "context": "본 milestone 진입 단계에서 결정적 이슈 round 로 § 6.2 충돌 검출. A_user trigger 재분류 narrative cascade (renumbered_from 필드 + INTENT.motivation + dependencies + ROADMAP entry trigger 'A_user') 4 위치 강화로 mitigate.",
      "implication": "기존 pending entry 의 trigger 가 D_design / B_regression / C_improvement 인 경우 § 6.2 발의 금지 조건과 비교 검토 의무 — 사용자 명시 선택 시 A_user 재분류 narrative cascade 필수."
    },
    {
      "id": "L2",
      "lesson": "ROADMAP entry 의 신 status 값 ('deferred') + 신 필드 ('deferred_reason') 추가는 smoke schema 검증 차단 없이 가능 — smoke-bundle-trigger.sh 는 status='pending' 만 continue 처리 + unknown 필드는 검증 부재 (allowlist 패턴 부재). schema_note 필드 cross-ref 의무 검토 부재 = 자유 추가.",
      "context": "RESEARCH risk_identified R1 (deferred_reason 필드 차단 가능성) + R5 (status 'deferred' unknown 처리) 검증 결과 모두 통과. pre-commit 14 hook + smoke 직접 3건 모두 PASS.",
      "implication": "ROADMAP 안 정책 narrative 강화 (status enum 확장 / 신 필드 추가) 는 forward-only 패턴 부합 + 회귀 0 패턴 — 다른 정책 결정 milestone 도 동일 패턴 적용 가능."
    },
    {
      "id": "L3",
      "lesson": "v3.5 phase-2 도입 'Stage D 완료 직전 의무 step' (milestones.md sub_milestones placeholder 교체) 의 강제력은 narrative 만 — smoke 자동 검증 부재. lightweight 모드 milestone 안에서도 manual checklist 의무 (DESIGN 완료 직후 즉시 갱신).",
      "context": "본 milestone 안 Stage D 완료 직후 milestones.md sub_milestones[0].title placeholder 교체 + Stage G 시점 status/commit 갱신 (총 2회) 정상 진행. 다만 placeholder 잔존 risk (DESIGN.risk_mitigation R6 severity: medium) 가 narrative 1차 source 외 자동 강제 부재 — 사용자 또는 Claude session 부주의 시 누락 가능.",
      "implication": "milestones.md placeholder 검출 smoke 자동화는 § 6.2 workflow self-improvement 동결 대상 — 외부 적용 데이터까지 narrative 강제 (인용 + 자기 검토) 만으로 운용. 본 milestone 처럼 lightweight 모드 시 manual checklist 부담 가중 trade-off."
    },
    {
      "id": "L4",
      "lesson": "v3.0+ 9-stage-bundled era 의 두 번째 renumber 사례 (v3.11 후속) — 실 실행 (v3.11: 5위치 narrative cleanup) vs 정책 결정 (본 v3.13: ROADMAP entry status flip + defer narrative) 두 유형 모두 lightweight 모드 자연 적용. renumber 패턴 자체는 ROADMAP entry 신규 + 구 entry 제거 + renumbered_from 필드 표기 3 step 으로 일관.",
      "context": "v3.11 patterns: (1) ROADMAP entry 추가 (신 schema version/id 분리 + renumbered_from), (2) 구 v1.x entry 제거 (forward-only), (3) milestones.md + 산출 7종 + execute/phase-{n}.md. 본 v3.13 동일 패턴 + 정책 결정 본질 = ROADMAP.md 단일 파일 변경.",
      "implication": "renumber 사례 누적 (v3.11 / v3.13) — 향후 v1.x_{slug} pending entry 의 forward-only renumber 의무 절차는 narrative 1차 source 로 정전화 가능 (현재 ARCHITECTURE.md § 6.1 forward-only 정책 직접 적용)."
    }
  ]
}
```

## 9 산출물 cascade 정합

| Stage | 파일 | 상태 |
|:-:|------|:----:|
| A (OPEN) | milestones.md (skeleton + sub_milestones 1:1 동기) | ✅ |
| B (INTENT) | INTENT.md (7 success_criteria + 6 out_of_scope + dependencies) | ✅ |
| C (RESEARCH) | RESEARCH.md (5 external + codebase + 3 options + 6 risks) | ✅ |
| D (DESIGN) | DESIGN.md (8 decisions + approach + 1 phase + 6 risk_mitigation + 5 관점 자기 검토) | ✅ |
| E (APPROVE) | APPROVE.md (user 명시 승인 + 5 관점 검토 결과 표) | ✅ |
| F (EXECUTE) | execute/phase-1.md (4 edits + execution_notes + commit a86334c) | ✅ |
| G (VERIFY) | VERIFY.md (4 smoke + 7 manual + 7 criteria + verdict pass) | ✅ |
| H (REPORT) | REPORT.md (3 summary + delta + 4 lessons) | ✅ (본 파일) |
| I (PROPOSE) | PROPOSE.md (next_candidates + ROADMAP status 갱신) | pending |

## Lightweight 모드 효율 정합

산출물 LOC cap 정합 (v3.6 baseline < 850줄):

| 파일 | LOC | 비고 |
|------|----:|------|
| milestones.md | 33 | skeleton + 의도 요약 |
| INTENT.md | 55 | 7 success_criteria + 6 out_of_scope |
| RESEARCH.md | 110 | 5 external + 3 options + 6 risks (codebase 명세 포함) |
| DESIGN.md | 130 | 8 decisions + 6 risk_mitigation + 자기 검토 표 |
| APPROVE.md | 40 | user 승인 + 5 관점 표 |
| execute/phase-1.md | 60 | 4 edits + execution_notes |
| VERIFY.md | 120 | 4 smoke + 7 manual + 7 criteria |
| REPORT.md (본 파일) | 95 | 3 summary + delta + 4 lessons |
| (예상) PROPOSE.md | 30 | next_candidates 0~2건 거명 + ROADMAP 갱신 narrative |
| **합계 예상** | **~673** | v3.6 baseline (< 850) 정합 |

## 자기참조 회피 표지 (lightweight cascade 4 위치)

| 위치 | 표지 narrative |
|------|---------------|
| milestones.md | self_reference_policy: 'avoid' + self_reference_rationale 필드 |
| INTENT.md § Lightweight 모드 표지 | trigger 3건 충족 명시 |
| DESIGN.md § 5 관점 자기 검토 + Stage D 완료 직전 의무 step | lightweight 자기 검토 표 + 5 관점 subagent 생략 |
| APPROVE.md § 5 관점 검토 결과 | lightweight 자기 검토 결과 표 |

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- PROPOSE: [`PROPOSE.md`](PROPOSE.md) (다음 stage)
- ARCHITECTURE § 6.2: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)

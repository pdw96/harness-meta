# APPROVE — v2.1_smoke-spawn-batching

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-10",
    "approval_summary": "사전 RESEARCH (시간 측정 + 정합성 평가) → INTENT (success_criteria 7건 + out_of_scope 7건) → RESEARCH (R1~R10 식별 + 4 options 분석, Approach A 사용자 채택) → DESIGN (D1~D11 11 decisions + risk_mitigation 10건) → 3 관점 병렬 검토 (architecture / 회귀 risk / scope contract, 모두 pass-with-comments + 의견 충돌 0) → DESIGN 보강 (D12~D17 7 decisions + R11~R13 3 risks 추가) 후 사용자 명시 승인."
  },
  "review_perspectives": [
    {
      "perspective": "architecture",
      "agent_type": "Plan",
      "verdict": "pass-with-comments",
      "summary": "phase 분리 (D2) + 출력 contract (D4) + phase 단위 (2개) 적정. 단일 source 위반 (D5 detect_era 이중 구현) → 옵션 e 채택으로 보강 (bash 함수 제거 + Python 일원화). 함수 분리 (D12), heredoc quoting (D13), flush=True (D14), spec-verification era 통합 (D15), REPORT 시간 측정 별첨 (D17) 7건 보강 흡수."
    },
    {
      "perspective": "회귀 risk",
      "agent_type": "Explore",
      "verdict": "pass-with-comments",
      "summary": "R2 traceback / R4 era 분기 / R8 카운트 동치 critical → DESIGN risk_mitigation 명시. R11 (heredoc quoting) + R12 (post-report-write.sh 메시지 동치) 2 risks 추가. Stage G 회귀 검증 명령어 list 8 항목 (baseline 캡처 / 카운트 비교 / edge case 주입 / 4 분기 milestone 검증 / 다른 4 smoke 회귀 / 시간 측정 / traceback 격리 / 자기 검증 게이트) 직접 차용 — VERIFY.md 작성 시 그대로 적용."
    },
    {
      "perspective": "scope contract",
      "agent_type": "Explore",
      "verdict": "pass-with-comments",
      "summary": "Forward 매핑 (success_criteria 7건 → DESIGN.phases) 모두 검증 가능 ✓. Backward (out_of_scope 7건 보존) 모두 ✓. D11 검토 관점 변경 (spec-drift → 회귀 risk) transparency 권고 → 본 milestone 은 INTENT 적용 보류 (harness-meta.md 갱신 후속 candidate). DESIGN.phases.verify_targets 필드 신설 권고 → 후속 candidate. era baseline 라인번호 → D16 으로 흡수."
    }
  ],
  "design_consolidated": {
    "decisions_count": 17,
    "decisions_added_after_review": ["D12", "D13", "D14", "D15", "D16", "D17"],
    "decisions_revised_after_review": ["D5"],
    "risk_mitigation_count": 13,
    "risks_added_after_review": ["R11", "R12", "R13"],
    "phases_count": 2,
    "perspective_conflicts": 0,
    "additional_user_decisions_required": 0
  },
  "execute_gate": {
    "phases_authorized": [
      {
        "n": 1,
        "title": "smoke-spec-verification.sh batched python3 통합",
        "commit_message_format": "feat(meta): v2.1 phase-1 — smoke-spec-verification python3 spawn batching"
      },
      {
        "n": 2,
        "title": "smoke-scope-contract.sh batched python3 통합 (Stage 1+2) + Stage 3 bash 유지",
        "commit_message_format": "feat(meta): v2.1 phase-2 — smoke-scope-contract python3 spawn batching"
      }
    ],
    "no_verify_authorization": false,
    "destructive_operations_authorized": [
      "smoke-scope-contract.sh 의 bash detect_era() 함수 제거 (D5 옵션 e — 호출자 0 이므로 안전)"
    ]
  }
}
```

## 승인 narrative

사용자 (<qkrehdnjs111@gmail.com>) 가 2026-05-10 에 본 milestone 의 DESIGN 최종안을 명시 승인 — `AskUserQuestion` "DESIGN 최종안 승인 여부?" → "승인 — EXECUTE 진입" 응답 (Recommended 옵션).

### 승인 흐름 요약

1. **사용자 발의** (2026-05-10) — "commit test 가 소요하는 시간이 너무 많은거 같은데, 정합성 검토해봐"
2. **사전 RESEARCH** — 5 active smoke 시간 측정 (smoke-spec-verification 66.4s + smoke-scope-contract 12.4s = 84% 점유, 17 milestones × 8 stage spawn 패턴)
3. **개선 옵션 3건 제시 + 사용자 채택** — Approach A (단일 batched python3 호출, 절감 가장 큼)
4. **OPEN** — `v2.1_smoke-spawn-batching` slug 결정 + ROADMAP entry in_progress + 컨테이너 디렉토리 마운트
5. **INTENT** — success_criteria 7건 + out_of_scope 7건 + dependencies (선행 v1.1_smoke-precommit-rewrite + v2.0_workflow-word-fidelity)
6. **RESEARCH** — external 7건 (사용자 의도 / spawn cost / tests/CLAUDE.md 함정 / ARCHITECTURE Verification 정전 / 선행 milestone 책임) + codebase (affected 2 / untouched 7) + options 4건 + risks_identified R1~R10
7. **DESIGN draft** — D1~D11 11 decisions + approach + phases 2건 + risk_mitigation 10건 + 5 관점 검토 (3 관점 채택, D11)
8. **3 관점 병렬 검토** — architecture / 회귀 risk / scope contract (pass-with-comments × 3, 의견 충돌 0)
9. **DESIGN 보강** — D5 정정 (옵션 e), D12~D17 6 decisions 추가, R11~R13 3 risks 추가
10. **사용자 명시 승인** — 본 APPROVE.md (현재 시점)

### 미승인 / 후속 candidate

다음은 본 milestone 에서 승인 보류, PROPOSE.next_candidates 로 이연 (Stage I):

- **review_perspectives 필드 도입** — INTENT.md 에 검토 관점 명시 (scope contract review #1 권고). harness-meta.md 갱신 + 향후 milestone 영향 큼 → 별도 milestone 의무.
- **phases.verify_targets 필드** — affected_files + implicit untouched 명시 (scope contract review #2). DESIGN 템플릿 변경.
- **tests/_era_detect.py 분리** — 두 smoke detect_era 본문 동일성 drift 방지 (architecture A2 + R13). 본 milestone scope 외, 향후 era 추가 시 검토.

### EXECUTE 권한

phase-1 + phase-2 의 commit 진행 권한 부여. `--no-verify` 사용 권한 부여 안 함 (CRITICAL: pre-commit 자기 검증 게이트가 R6/R10 mitigation 의 핵심).

destructive operation 1건 (bash detect_era() 제거) 권한 부여 — 호출자 0 이므로 안전 (D5 옵션 e rationale).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.3 5요소 매트릭스 'Constraint' 행 (APPROVE.md.approved_by 게이트)

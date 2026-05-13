# INTENT — v3.20_drift-narrative-canonicalization

```json
{
  "id": "v3.20_drift-narrative-canonicalization",
  "title": "word-fidelity drift 수용 narrative 정전화 — ARCHITECTURE.md 안 86.1% 부합도 + PROPOSE 70% drift 의도성 paragraph 추가",
  "goal": "v3.19_word-fidelity-audit-v2 진단 결과 (9-stage 부합도 평균 86.1% / APPROVE 100% / PROPOSE 70% 가장 큰 drift / root cause 공유 진단) 의 ARCHITECTURE.md 안 narrative 정전화 — drift 의 의도성 (pragmatic 절충, 단일 책임 100% 부합 추구 시 workflow 비대해짐) + 정량 cross-ref (평균 86.1% / APPROVE 100% / PROPOSE 70%) paragraph 1건 추가. 위치 host (§ 3 / § 4 / § 6) 및 정확 문구는 RESEARCH/DESIGN 단계 확정.",
  "motivation": "사용자 명시 발의 (A_user trigger) — /harness-meta meta 라운드 'v3.19 L1 후속: drift-narrative-canonicalization' 명시 선택. v3.19 PROPOSE.next_candidates#1 직접 후속. v3.19 진단 결과 (부합도 86.1% / PROPOSE 70% drift) 가 milestone 산출물 안에만 보존된 상태로, ARCHITECTURE.md (외부 visible 단일 source) 안 drift 의도성 (pragmatic 절충) narrative 부재. 본 milestone 은 narrative 1 paragraph 추가 — drift 실 변경 (Option B 10-stage REGISTER 분리 / Option C ROADMAP 재정의) 아닌 현 상태 의도성 정전화 (Option D 옵션).",
  "success_criteria": [
    "ARCHITECTURE.md 안 word-fidelity drift 수용 narrative paragraph 1건 추가 — 본 milestone 진행 결과 검증 가능 (grep 'word-fidelity drift' projects/meta/ARCHITECTURE.md 또는 동치 키워드)",
    "narrative 안 정량 cross-ref 3건 포함 — 평균 부합도 86.1% + APPROVE 100% (최고 부합) + PROPOSE 70% (최대 drift) — RESEARCH 단계 정확 문구 확정",
    "narrative 안 drift 의도성 narrative 포함 — pragmatic 절충 / 단일 책임 100% 부합 시 workflow 비대 / v3.19 진단 결과 cross-ref",
    "워크플로우 절차 본문 변경 zero — claude/commands/harness-meta.md Stage A~I 절차 / ARCHITECTURE § 6.2 동결 정책 본문 / tests/ smoke 추가 zero (out_of_scope #1~#4)",
    "INTENT/RESEARCH/DESIGN/APPROVE artifact 4건 phase-1 commit 안 영구 보존 (commit timing (b) default, v3.17 L4 / v3.18 L3 정합)",
    "pre-commit 14 hook 모두 PASS + 회귀 0 + smoke spec-verification / scope-contract / bundle-trigger 모두 PASS",
    "VERIFY.criteria_check 안 본 success_criteria 7건 1:1 매핑 PASS"
  ],
  "out_of_scope": [
    "워크플로우 절차 본문 변경 (claude/commands/harness-meta.md Stage A~I 절차 / commit timing 3 패턴 / Stage F 선결 조건 narrative) — Option B 10-stage REGISTER 분리 영역, 본 milestone Option D 한정",
    "ROADMAP 재정의 또는 재명명 (forward-looking pending 등재 / MILESTONES.md / LEDGER.md) — Option C 영역, 본 milestone Option D 한정",
    "ARCHITECTURE § 6.2 동결 정책 본문 변경 — workflow self-improvement 동결 narrative 유지",
    "tests/ touch zero (smoke 추가 / 변경 / inactive 정리 등)",
    "5 관점 subagent 검토 — lightweight 모드 정합 (v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19 선례 7건)",
    "v3.19 L4 후속 (lightweight 1-phase commit-timing (a) default narrative) bundle — 사용자 명시 'L1 단독' 선택, 별 milestone 분리",
    "9-stage 표 (§ 4) 본문 또는 단어 책임 정의 변경 — narrative 1 paragraph 추가 한정 (drift 자체 수정 아닌 수용)"
  ],
  "dependencies": {
    "input": [
      "v3.19_word-fidelity-audit-v2 RESEARCH.codebase.current_state.stage_word_fidelity_estimate (9 stage 부합도 점수 + 평균 86.1% 계산) — 본 milestone narrative 정량 cross-ref source",
      "v3.19 DESIGN/REPORT/PROPOSE — drift 의도성 + root cause 공유 + Option A~D 분석",
      "projects/meta/ARCHITECTURE.md (§ 3 / § 4 / § 6 — narrative 추가 host 후보, RESEARCH 단계 확정)"
    ],
    "downstream": [
      "후속 milestone 발의 시 drift narrative cross-ref 가능 — workflow word-fidelity drift 의도성 정전화 안정",
      "v3.X_propose-register-책임-separation-evaluation (v3.19 PROPOSE next_candidates#2) — 본 narrative 가 분리 trigger 미충족 narrative source 보강"
    ]
  },
  "mode": "lightweight",
  "self_reference_handling": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지) — 본 milestone 자체 1-phase 1+1 commit 도그푸드 정합 (v3.17 L6 / v3.18 L2 / v3.19 L2 패턴 세 번째 적용)"
}
```

## narrative

v3.19 PROPOSE.next_candidates#1 직접 후속. narrative 1 paragraph 추가 = drift 수용 정전화. workflow 절차 변경 zero + smoke 변경 zero + § 6.2 동결 정책 유지.

`out_of_scope` 항목 = 본 milestone negative scope **사실 진술** 만 (v3.10 정책 정합) — 후속 발의 명령형 표현 부재. L4 bundle 거부도 사용자 선택 사실 진술 (forward propose 표현 부재).

## 관련

- v3.19 진단 origin: [`../v3.19/`](../v3.19/) (RESEARCH 부합도 표 source, PROPOSE next_candidates#1)
- v3.18 narrative 정전화 패턴 1차: [`../v3.18/`](../v3.18/) (v3.17 진단 → narrative 정전화 cycle 1차 source)
- bundling 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- workflow 자기참조 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2

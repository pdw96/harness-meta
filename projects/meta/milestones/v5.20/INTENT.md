---
id: v5.20
title: audit-team 외부 호출 cycle 7 + ARCHITECTURE § 4 끝 7 paragraph 매트릭스화 + agent namespace prefix cascade — stability 3 cycle 연속 (5+6+7) + v5.19 PROPOSE#4+#8 동시 흡수 + Plugin spec v5.0+ namespace 정합
version: v5.20
stage: INTENT
status: completed
---

# INTENT — v5.20 audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade

## Spec

```json
{
  "goal": "scenario B 3-phase bundling 적용 — (1) project-harness-audit-team 4 멤버 (scanner → gap-analyzer → docs-mapper → proposer) upbit 대상 일곱 번째 read-only 실 호출 + v5.19 cycle 6 산출물 diff + stability 3 cycle 연속 (5+6+7 동일 upbit v1.20 baseline) evidence + (2) ARCHITECTURE.md § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화 + L135 vector count 6→7 + (3) § 4 끝 7 paragraph 매트릭스화 (표 변환 + cross-ref) + agent namespace prefix narrative cascade 7 위치 정합 (Plugin spec v5.0+).",
  "success_criteria": [
    "sc_1: audit-team 4 멤버 (scanner → gap-analyzer → docs-mapper → proposer) upbit 대상 일곱 번째 read-only 실 호출 완료 — 4 산출물 생성",
    "sc_2: v5.19 cycle 6 산출물 diff (diff-vs-cycle6.md) 생성 — stability 본질 정확화 evidence 정량 capture",
    "sc_3: v5.13 3-layer fact 검증 절차 다섯 번째 실전 적용 — hallucination 발현 시 inline 정정",
    "sc_4: v5.16 lint precheck 세 번째 실전 적용 — MD022/MD031/MD032 hardcode 3 rule + 추가 발현 추적",
    "sc_5: v5.18 Input Verification H2 sub-section + 검증 method 분리 두 번째 실전 — D10 우회 재현",
    "sc_6: stability 3 cycle 연속 (5+6+7) evidence 정량 정전화 — R1+R2 3 cycle 연속 APPLIED + 신규 gap 0건 추세",
    "sc_7: ARCHITECTURE.md § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화",
    "sc_8: vector count 6→7 갱신 (ARCHITECTURE.md L135)",
    "sc_9: self-loop counting 갱신 (외부 1건 추가 + self-loop 2건 추가 = 21/27 ≈ 77.8%, 분자 자체 paragraph 정전화 + 매트릭스화)",
    "sc_10: pre-commit 14 hook PASS + 회귀 0건",
    "sc_11: milestones.md sub_milestones 3 phase 1:1 동기 갱신 (Stage D 의무, v3.5)",
    "sc_12: lightweight 이탈 (3-phase + cascade) — bundling 정당화 narrative 정전화 (REPORT.lessons 안)",
    "sc_13: v3.21 narrative 정전화 3 단계 패턴 21~22+ cycle 도그푸드 (stability paragraph 21번째 + 매트릭스화 22번째)",
    "sc_14: ARCHITECTURE § 4 끝 7 paragraph 매트릭스화 — 표 변환 + cross-ref 매핑 (v5.19 PROPOSE#8 trigger 충족)",
    "sc_15: agent namespace prefix narrative cascade 7 위치 — claude/commands/harness-meta.md 5 (project-scanner/harness-gap-analyzer/claude-docs-mapper/component-proposer/component-installer) + agents/agents-md-sync.md 1 + agents/environment-auditor.md 1 = Plugin spec v5.0+ `harness-meta:<name>` 표기 정합"
  ],
  "out_of_scope": [
    "v5.19 L1 evidence isolation (narrative 효과 단일 source 분리) — upbit commit 부재로 trigger 미충족, cycle 8+ 계승 (사실 진술)",
    "audit-team component-installer 호출 (read-only 4 멤버만, v5.10 패턴 정합)",
    "mapper-output.md MD034 11건 hardcode rule 확장 (v5.19 PROPOSE#3 carry-over, cycle 8+ 추가 evidence 시)",
    "§ 3.1 baseline drift cleanup (v5.18 PROPOSE#5 carry-over)",
    "self-loop classification criteria definition (v5.18 PROPOSE#7 carry-over)",
    "audit agent tool permission enhancement (v5.18 PROPOSE#4 carry-over)",
    "harness cost tracker spike reevaluation (v5.18 PROPOSE#9 carry-over)",
    "upbit v1.16 untracked artifact cleanup (v5.19 L7, upbit scope)",
    "agent .md (project-scanner/harness-gap-analyzer/claude-docs-mapper/component-proposer/component-installer) `## Input Verification` H2 sub-section 안 prefix narrative 갱신 (v5.18 narrative 정전화 후 변경 부재, 본 phase-3 = call-site cascade 단일 책임)"
  ]
}
```

## Motivation

v5.19 PROPOSE.next_candidates#4 (`audit-cycle-stability-pattern-canonicalization-architecture`) + #8 (`architecture-section-4-end-paragraph-matrix-canonicalization`) 동시 trigger 조건 충족 + 4 관점 검토 spec-drift D1 (agent .md narrative `subagent_type="<name>"` prefix 부재 vs 실 환경 Plugin namespace `harness-meta:<name>` mismatch) cascade 흡수. v3.0+ bundling 키워드 정합 — 같은 의미 단위 (audit-team 운용 evidence + § 4 끝 narrative 정전화/매트릭스화 + Plugin spec namespace). 사용자 의문 round 1+2 결정 = scenario B 채택 (scope 확장, lightweight 이탈 정당화). v5.13 fact 검증 다섯 번째 + v5.16 lint precheck 세 번째 + v5.18 Input Verification + 검증 method 분리 narrative 두 번째 실전 적용 = 절차 안정성 추가 evidence 누적.

## Dependencies

- **preceding**: v5.19_external-audit-team-cycle-6-call (completed, 2026-05-19) — cycle 6 stability 첫 완성 + 4 산출물 baseline + v5.19 PROPOSE#4 trigger condition source, v5.18_audit-chain-direct-read-and-verification-depth (completed, 2026-05-18) — Input Verification H2 sub-section + 검증 method 분리 narrative source, v5.17_external-audit-team-cycle-5-call (completed, 2026-05-18) — cycle 5 baseline (stability cycle 시발점), v5.16_audit-output-markdown-lint-precheck (completed, 2026-05-18) — lint precheck 절차 narrative source, v5.13_audit-chain-fact-verification-protocol-procedure (completed, 2026-05-18) — 3-layer fact 검증 절차 narrative source, v4.0_harness-composer-pivot (completed, 2026-05-13) — project-harness-audit-team 5 멤버 + --audit opt-in 분기 source
- **following**: v5.20 PROPOSE.next_candidates[] (forward) — cycle 8+ commit 발생 시 evidence isolation trigger 계승 + 기타 carry-over

## narrative

### 본 milestone scope (단일 책임)

cycle 7 호출 자체 + stability 3 cycle 연속 evidence 확보 + ARCHITECTURE § 4 끝 paragraph 정전화 — 3가지 핵심 산출. v5.19 cycle 6의 부분 충족 trigger (L1 evidence isolation 미충족) scope 축소 (사용자 결정).

### 의문 round 1 결과 (Stage A OPEN 진입 전)

upbit commit 부재 (v5.19 baseline 이후 0 commit) → cycle 7 = cycle 5+6과 동일 v1.20 baseline. 사용자 결정 = 강행 + stability 정전화 scope 축소 (Recommended) — L1 evidence isolation cycle 8+ 계승.

### v3.10 부산물 정책 정합

`out_of_scope` 8건 모두 (a) 사실 진술 = '본 milestone 이 무엇이 **아닌가**'. (b) 후속 milestone 발의 표현 부재 — 후속 발의는 Stage I PROPOSE 단일 책임.

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) `milestones[]` 안 v5.20
- milestones.md skeleton: [`milestones.md`](milestones.md)
- v5.19 cycle 6 산출물 (diff baseline): `projects/upbit/audit-2026-05-19-cycle6/`
- v5.19 PROPOSE.next_candidates#4 (trigger origin): `../v5.19/PROPOSE.md`
- v4.0 project-harness-audit-team 정의: `../../../agents/project-harness-audit-team/CLAUDE.md`

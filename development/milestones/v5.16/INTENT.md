---
id: v5.16
title: agent 산출 markdown lint precheck 절차 정전화 — MD022/MD031/MD032 위반 사전 방지 (v5.15 PROPOSE#2 carry-over, v5.14 L7 + v5.15 L5 누적 2 사례 trigger 충족)
version: v5.16
stage: INTENT
status: completed
---

# INTENT — v5.16 audit-output-markdown-lint-precheck

## Spec

```json
{
  "goal": "audit chain agent 4 멤버 (scanner / analyzer / mapper / proposer) 산출 markdown 을 repo 에 저장 시 markdownlint MD022 / MD031 / MD032 위반 사전 방지 절차를 narrative 안 정전화한다. v5.13 정전화 3-layer cross-ref 구조 패턴 정합 (ARCHITECTURE WHAT + agents D8 sequence WHERE + claude/commands HOW).",
  "success_criteria": [
    "sc_1: ARCHITECTURE.md § 4 끝에 'agent 산출 markdown lint precheck 절차' bold lead paragraph 1건 추가됨 (WHAT layer, v5.13 § 4 끝 패턴 정합).",
    "sc_2: agents/project-harness-audit-team/CLAUDE.md D8 sequence 코드블록 직후에 Note (v5.16) 추가됨 — agent 산출 직후 synthesizer lint precheck step 의무 명시 (WHERE layer).",
    "sc_3: claude/commands/harness-meta.md --audit 분기 sequence 안 synthesizer fact 검증 step 직후 lint precheck step 추가됨 (HOW layer). 3-layer cross-ref 구조 완성.",
    "sc_4: hardcode 대상 rule = MD022 (heading blanks) + MD031 (fenced code blanks) + MD032 (list blanks) 3개. 추가 rule 확장은 본 milestone 외.",
    "sc_5: pre-commit 14 hook PASS, 회귀 0건.",
    "sc_6: VERIFY 단계에서 v3.21 narrative 정전화 3 단계 패턴 (DESIGN.D2.exact_text 1차 source + EXECUTE Edit 정확 삽입 + VERIFY grep 3 키워드) 17 번째 cycle 도그푸드 완성 verdict (v5.15 = 16 번째 memory 1차 source, v5.16 = 17 번째).",
    "sc_7: 1-phase 1+1 commit 패턴 (phase-1 implementation + Stage G+H+I 통합 chore) — lightweight 모드 누적 12/30 = 40% 갱신.",
    "sc_8: 5 관점 subagent 검토 생략 (scope=작음 ≤5 파일, 3 관점 = architecture / spec-drift / scope contract). lightweight 정책 정합 (사용자 결정 Q2)."
  ],
  "out_of_scope": [
    "agent 정의 (.md) 자체 prompt 본문 변경 — v5.15 PROPOSE.next_candidates#5 (`audit-agent-tool-permission-enhancement`) 별 milestone scope.",
    "markdownlint 자동 fix 도구 도입 (mdformat / markdownlint --fix 등) — Q1 결정에서 narrative 절차 우선 채택 후 별 milestone candidate (3 사례 누적 시).",
    "pre-commit hook 자체 markdownlint rule 확장 (현행 .markdownlint.json 변경) — 본 milestone 은 절차 정전화, rule set 자체는 무변경.",
    "v5.15 PROPOSE.next_candidates#3 (`external-audit-team-cycle-5-call`) — 본 milestone 정전화 후 cycle 5 호출 시 절차 검증 evidence 강화.",
    "MD022/MD031/MD032 외 markdownlint rule 위반 일반화 검토 — Q3 결정에서 3 rule hardcode 채택 (evidence-base 원칙)."
  ]
}
```

## Motivation

v5.14 L7 origin (cycle 3 audit 안 3건 발생) + v5.15 L5 재현 (cycle 4 audit 안 8건 발생) = 누적 2 사례 trigger 충족 (v5.15 PROPOSE.next_candidates#2 description '향후 cycle 5+ 추가 누적 시 발생률 정량 evidence 강화'). cycle 5+ 추가 누적 전에 절차 정전화하여 회귀 예방. agent 산출 직후 markdown 회귀 = local pre-commit hook 다수 회 실패 → 재시도 / 정정 cost 누적. 본 milestone scope = 절차 narrative 정전화 (workflow step + agent prompt instruction 패턴). 자동화 도구 도입은 별 milestone scope (사용자 명시 결정 Q1 Recommended = narrative 절차 정전화).

## Dependencies

- 선행: v5.15 (external-audit-team-cycle-4-call, 2026-05-18 완료) — PROPOSE.next_candidates#2 origin.
- 선행: v5.13 (audit-chain-fact-verification-protocol-procedure, 2026-05-18 완료) — 3-layer cross-ref 구조 패턴 정합 (ARCHITECTURE § 4 끝 WHAT + agents/...team/CLAUDE.md D8 sequence WHERE + claude/commands/harness-meta.md --audit 분기 HOW).
- 선행: v3.21 (narrative-canonicalization-3step-pattern, 2026-05-14 완료) — 3 단계 narrative 정전화 패턴 (DESIGN.D2.exact_text + EXECUTE Edit + VERIFY grep) 16 번째 cycle 도그푸드.
- 후행: v5.15 PROPOSE.next_candidates#3 (external-audit-team-cycle-5-call) — 본 절차 정전화 후 cycle 5 호출 시 lint precheck 효과 검증 evidence.

## narrative

### Goal 정련

audit chain 4 멤버 (scanner / analyzer / mapper / proposer) 가 markdown 산출 시 markdownlint MD022 / MD031 / MD032 rule 위반이 자동 발생하는 패턴이 v5.14 / v5.15 2 사이클 연속 재현됨. 본 milestone 은 agent 산출 직후 synthesizer (메인 Claude) 가 lint precheck 를 수행하도록 절차를 narrative 안 정전화한다. 자동화 도구 도입은 본 scope 외 (out_of_scope#2).

### Motivation evidence

| cycle | milestone | 발생 건수 | rule 분포 |
|:-:|:-:|:-:|:--|
| v5.14 (cycle 3) | upbit audit-2026-05-18 | 3건 | MD031/MD032 |
| v5.15 (cycle 4) | upbit audit-2026-05-18-cycle4 | 8건 | MD022/MD031/MD032 |

증가 추세 (3 → 8) — cycle 5+ 추가 누적 시 회귀 cost 증가 예상.

### Out of scope 사실 진술 (v3.10 정합)

5건 모두 본 milestone 의 negative scope 사실 진술. 후속 milestone 발의 명령형 표현 부재 — forward propose 책임은 Stage I (PROPOSE) 단일.

## 관련

- 메타 ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- 직접 origin: v5.15 PROPOSE.next_candidates#2
- 정전화 패턴 source: v5.13 INTENT.md (3-layer cross-ref 구조), v3.21 narrative 정전화 3 단계 패턴

# PLAN — v1.4_infra-minimization

## 의도

5요소 매트릭스 (정의 [§ 3.3](../../ARCHITECTURE.md#33-5요소-매트릭스)) 의 'Verification' 행 (c) 분류 = **혼재** 를 **정전** 으로 갱신한다. `VERIFY.md` narrative 가 1차 source 임을 매트릭스 + 운영 문서 narrative 에 명시하고, smoke shell / `install.ps1` / `verify.{ps1,sh}` 인프라 중 narrative 대체 가능한 부분을 식별·제거하여 § 3.1 명료화 단락의 '인프라 자동화 의존 최소화' 정신을 직접 적용한다.

```json
{
  "id": "v1.4_infra-minimization",
  "title": "인프라 최소화 — install/verify 제거 + smoke 합리화 (5요소 'Verification 혼재' 정전화)",
  "goal": "ARCHITECTURE.md § 3.3 매트릭스 'Verification' 행 (c) 분류를 '혼재' → '정전' 으로 갱신하고, smoke / install / verify 인프라 중 narrative 대체 가능 부분을 식별·제거하여 자동화 의존을 최소화한다.",
  "motivation": "v1.3_harness-engineering-definition 에서 정의 § 3.3 매트릭스 'Verification' 행 (c) 를 '혼재 — VERIFY.md narrative = 정전, smoke shell 인프라 = 임시방편 (후속 v1.4_infra-minimization 평가 대상)' 으로 명시. 본 milestone 이 그 평가 후속이며, § 3.1 명료화 단락의 '자동화는 narrative 의 보조' 원칙을 Verification 인프라에 적용한다.",
  "success_criteria": [
    "install.ps1 / verify.ps1 / verify.sh 의 책임 감사 결과를 RESEARCH.codebase 에 명시 (각 파일 = '정전 보조' / '임시방편' / 'narrative 대체 가능' 중 하나로 분류)",
    "tests/ 디렉토리의 smoke 스크립트 N종 (RESEARCH 단계에서 정확히 카운트) 각각의 narrative 대체 가능 여부를 RESEARCH.options 에 분류",
    "narrative 대체 가능으로 식별된 항목별로 DESIGN.decisions 에 '제거 / 보존 / 슬림화' 결정 + 근거 기록",
    "제거 결정된 smoke·인프라 항목 각각에 대해 narrative 대체 메커니즘 (사용자 명시 approval 게이트 / GUARDRAILS 거명 / 운영 문서 narrative 명시 / DESIGN.decisions 거명 중 하나 이상) 을 DESIGN.decisions 에 1:1 매핑 — 단순 제거가 아니라 narrative 대체 보장 (정전화 정신 = '자동화는 narrative 보조' 직접 적용)",
    "EXECUTE 단계에서 결정된 제거·슬림화 commit 완료 + 회귀 0 (보존된 smoke 모두 PASS, ARCHITECTURE 단일 source 정합 유지, pre-commit hook config cascade 갱신 후 통과)",
    "ARCHITECTURE.md § 3.3 매트릭스 'Verification' 행 (c) 분류 갱신 = '정전' (narrative 우위 표기 + 잔존 인프라가 narrative 보조임을 명시) — 정확한 표현은 5 관점 검토 합의로 DESIGN.decisions 에 확정"
  ],
  "out_of_scope": [
    "Context 행 (c) 'SKILL 자동 invoke 임시방편' 분류 정전화 (사용자 PLAN 분기 결정: Verification 만, Context 는 별도 milestone 으로 분리)",
    "post-report-write.sh additionalContext hard-code 메시지 narrative 분리 (별도 milestone v1.4_hook-narrative-separation 등재)",
    "Stage E 5 관점 검토 raw 출력 보존 (별도 milestone v1.4_design-review-trace 등재)",
    "legacy sessions/ stale narrative 잔존 정리 (별도 milestone v1.5_legacy-narrative-cleanup 등재)",
    "RESEARCH cascade grep 패턴 강화 (별도 milestone v1.5_research-cascade-grep-discipline 등재)",
    "신규 인프라 추가 — 본 milestone 은 '제거·슬림화' 방향 단방향"
  ],
  "dependencies": {
    "preceding": [
      "v1.3_harness-engineering-definition — 정의 § 3.3 매트릭스 'Verification' 행 (c) = 혼재 + 본 milestone 을 평가 대상으로 명시 거명",
      "v1.4_cross-ref-propagation — 정의 cross-ref host 5곳 안정화 + GUARDRAILS.md 재작성 + docs/ARCHITECTURE.md 폐기 → 매트릭스 단일 source 정합 보장 (본 milestone 의 매트릭스 갱신 cascade 영향 단순화)"
    ],
    "succeeding": [
      "v1.4_hook-narrative-separation — Context 행 'hook hard-code 메시지' 임시방편 정전화 (본 milestone 결과로 narrative 우위 원칙 확립 후 자연 적용)",
      "v1.4_design-review-trace — Trace 행 보강 (5 관점 검토 raw 출력 보존)"
    ]
  }
}
```

## 5요소 매핑

본 milestone 은 정의 § 3.3 매트릭스의 **Verification** 행 (c) 분류 정전화를 직접 다룬다. § 3.6 신규 milestone 평가 절차 step 2 의 세 가지 작업 유형 — '정전 보강 / 임시방편 정전화 / 혼재의 임시방편 부분 narrative 대체' — 중 **세 번째**에 해당.

## 비고

- success_criteria #4 의 '제거·슬림화 commit' 의 실제 범위는 RESEARCH 감사 후 DESIGN 단계에서 결정. PLAN 은 의도만 — implementation detail 은 DESIGN 에 위임 (root [`CLAUDE.md`](../../../../CLAUDE.md) 단일 책임 원칙).
- success_criteria #5 의 매트릭스 갱신 표현은 5 관점 검토 (Stage E) 시 합의 도출 → DESIGN.decisions 에 최종 표기 → EXECUTE 에서 ARCHITECTURE 갱신.
- 회귀 risk: 기존 smoke 일부 제거 시 pre-commit hook config (`.pre-commit-config.yaml`) cascade 갱신 필요 — DESIGN.risk_mitigation 에 매핑.

## 관련 문서

- 정의 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- 직전 완료 milestone: [`../v1.4_cross-ref-propagation/`](../v1.4_cross-ref-propagation/)
- 직전 직전 완료 milestone (정의 source): [`../v1.3_harness-engineering-definition/`](../v1.3_harness-engineering-definition/)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)

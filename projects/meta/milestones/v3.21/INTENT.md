# INTENT — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "title": "narrative 정전화 3단계 패턴 명문화 — DESIGN 정확 문구 1차 source + EXECUTE Edit 그대로 삽입 + VERIFY grep 검증 (v3.20 L4 후속)",
  "goal": "v3.18 + v3.20 두 narrative 정전화 milestone 안 자연 발현한 3단계 패턴 — (a) DESIGN 안 정확 문구 1차 source (markdown code block) (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 (c) VERIFY 안 grep 검증 키워드 (정확 문구 안 cohesive 키워드 추출) — 을 단일 source narrative 로 정전화 → 후속 narrative 정전화 milestone 에 일관 적용 명문화.",
  "motivation": "v3.20 L4 lesson 1차 source — v3.18 D3 패턴이 v3.20 두 번째 적용된 시점에서 '3 단계 정합 패턴' 으로 명확히 발현. 이 패턴은 narrative 정전화 milestone (ARCHITECTURE.md / claude/commands/harness-meta.md 등 문서 host 안 단일 paragraph 추가) 의 정합 메커니즘 — DESIGN 안 정확 문구가 1차 source 면 EXECUTE Edit 가 정확히 그 문구를 삽입할 수 있고, VERIFY grep 키워드도 그 문구 안 cohesive 표현에서 직접 추출 가능 = 산출물 간 narrative drift 차단. 명문화 부재 시 후속 narrative 정전화 milestone 마다 패턴 재발견 비용 발생 + 변형 risk. v3.18 / v3.20 패턴 정합 2 cycle 누적 = strong evidence (3 cycle 누적 정책 권장 trigger 미충족이지만 본 milestone 자체가 패턴 도그푸드 = 자기참조 cycle 자체로 3 cycle 누적 완성).",
  "success_criteria": [
    "3단계 패턴 narrative 단일 source 위치 host 1곳 결정 (ARCHITECTURE.md § 4 또는 § 6 또는 claude/commands/harness-meta.md Stage D 직후 등 후보 중 1곳 — Stage C RESEARCH/D DESIGN 단계 결정)",
    "host 안 정확 문구 (markdown code block + 3 단계 (a)/(b)/(c) 명시 + v3.18/v3.20 cross-ref + 적용 trigger '문서 host 안 단일 paragraph 추가 narrative 정전화 milestone') 신규 paragraph 1건 추가",
    "본 milestone 자체가 3단계 패턴 자기 적용 도그푸드 — DESIGN 안 정확 문구 1차 source + EXECUTE Edit 그대로 삽입 + VERIFY grep 키워드 검증",
    "워크플로우 본문 (Stage A~I 9-stage 절차) 변경 zero — 본 milestone 은 패턴 명문화 + cross-ref 만, 절차 자체는 불변",
    "smoke 추가 / 변경 zero — 본 milestone 은 narrative 정전화 + cross-ref 만 (v3.18 / v3.20 정합)",
    "다른 host cross-ref 추가 zero (단일 source 전략, v3.18 D1 패턴 정합) — 후보 host 중 1곳 만 변경",
    "pre-commit 14 hook 모두 PASS + 회귀 0",
    "산출물 LOC 총 ≤700 line (lightweight cap 1500 권고 약 47% 활용도 — v3.17~v3.20 평균 ~493 정합)"
  ],
  "out_of_scope": [
    "워크플로우 본문 (9-stage 절차) 변경 — 본 milestone 패턴 명문화 + cross-ref 만, 절차 변경 부재",
    "smoke 신규 / 변경 — narrative 정전화 milestone 에 smoke 자동화 강제 부재 (v3.18 / v3.20 정합)",
    "다른 host cascade cross-ref — 단일 source 전략 (v3.18 D1 패턴 정합) 위배 회피",
    "v3.20 PROPOSE next_candidates #1 (commit timing (a) canonicalization) / #2 (diagnose→canonicalize pattern) — 본 milestone scope 와 별개, § 6.2 default 동결 정합",
    "5 관점 subagent 검토 (lightweight 모드 예상 시 생략) — Stage D DESIGN 단계 결정",
    "ARCHITECTURE.md / harness-meta.md 외 host 거명 (CHANGELOG.md / 다른 모듈 CLAUDE.md 등) — 본 milestone 단일 source 정합",
    "L4 lesson 외 v3.20 lessons (L1/L2/L3/L5/L6) 후속 — 별 후속 milestone 흡수 책임 (PROPOSE 단계 통합 흡수, v3.10 정책 정합)"
  ],
  "dependencies": {
    "predecessor": [
      "v3.20_drift-narrative-canonicalization (L4 1차 source lesson)",
      "v3.18_option-a-natural-adaptation-narrative (D3 패턴 발현 1차 source)",
      "v3.6_overengineering-audit (§ 6.2 자기참조 회피 표지 정책)"
    ],
    "successor": []
  },
  "byproduct_check": "out_of_scope 7건 모두 사실 진술 — 본 milestone 의 negative scope 만 표기. 후속 milestone 발의 명령형 ('별 milestone 으로') 부재 — v3.10 부산물 정책 정합. v3.20 lessons 후속 흡수 책임은 PROPOSE 단계 통합 흡수 명문화."
}
```

## narrative

본 INTENT 는 **의도 (의도 = 무엇을 / 왜 / 성공 기준 / 제외 / 의존)** 책임만 — implementation detail (phase 분할 / host 결정 / 정확 문구) 은 Stage D DESIGN 으로 미룸 (v2.0_workflow-word-fidelity word-책임 1:1 정합).

`success_criteria` 8건 — host 위치 결정 (#1) / 정확 문구 추가 (#2) / 자기 적용 도그푸드 (#3) / 절차 zero (#4) / smoke zero (#5) / 단일 source (#6) / pre-commit 14 PASS (#7) / LOC cap (#8).

`out_of_scope` 7건 — 워크플로우 본문 / smoke / 다른 host cross-ref / v3.20 carry-over / 5 관점 / 다른 host 거명 / L4 외 lessons. 모두 negative scope **사실 진술** — 후속 발의 명령형 부재 (v3.10 정책 정합).

`dependencies.predecessor` 3건 — v3.20 (L4 1차 source) / v3.18 (D3 패턴 발현) / v3.6 (§ 6.2 정책).

## 도그푸드 정합

본 milestone 자체가 **3단계 패턴 자기 적용 도그푸드** — Stage D DESIGN 안 정확 문구 1차 source + Stage F EXECUTE Edit 그대로 삽입 + Stage G VERIFY grep 키워드 검증. v3.18 / v3.20 narrative 정전화 패턴 2 cycle 누적 + 본 milestone = 3 cycle 누적 완성 자기참조 회피 표지 (lightweight 모드 예상).

## 관련

- v3.20 REPORT (L4 1차 source): [`../v3.20/REPORT.md`](../v3.20/REPORT.md)
- v3.18 DESIGN (D3 패턴 1차): [`../v3.18/DESIGN.md`](../v3.18/DESIGN.md)
- bundling 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- workflow 자기참조 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
- v3.10 부산물 정책: [`../v3.10/DESIGN.md`](../v3.10/DESIGN.md)

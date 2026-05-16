# INTENT — v5.8 identity-application-vector-audit

```json
{
  "id": "v5.8_identity-application-vector-audit",
  "title": "v4.0 정체성 (composer/integrator/maintainer) ↔ 실 운용 vector drift 진단 + ARCHITECTURE narrative 정전화 (lightweight 자기 검토 라운드 4 번째)",
  "trigger": "A_user",
  "self_reference_policy": "avoid",
  "subagent_review_policy": "skipped",
  "mode": "lightweight",
  "goal": "v4.0 도입 후 운영분 (v4.0~v5.7, 8 milestone, ~3일) 의 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) ↔ 실 운용 vector 부합도 정량 진단 + ARCHITECTURE.md 안 진단 결과 narrative 정전화 1건. self-loop (meta repo 자체 인프라 정합화) vs 외부 적용 vector 부재 root cause 명문화.",
  "motivation": "사용자 자유 질의 round (2026-05-17 /clear 후) 안 '존재 목적 ↔ meta repo 일치도' 측정 결과 = 선언적 정합 ~95% (.claude-plugin manifest + agents 7 + skills 5 + audit-team 5 멤버 + 카탈로그) vs 운용적 정합 ~30~40% (v4.0~v5.7 8/8 self-loop / 외부 audit-team 호출 0건 / candidate_draft[]=[] / deferred 3건 cycle 1+2 AND FAIL). 부합도 ~60% 정량 진단 후 사용자 명시 '진단 milestone 발의' 결정 — v3.6 § 6.2 폐지가 의도한 가드레일 (workflow self-improvement 자기참조 사이클 동결) 이 v4.0 새 정체성 하에 벡터만 회전한 채 (workflow → Plugin 인프라) 재현 중인지 명문화하고 향후 외부 적용 vector trigger 조건 narrative 정합화.",
  "success_criteria": [
    "sc_1: RESEARCH.md 안 v4.0~v5.7 8 milestone 분류 표 (self-loop vs 외부 적용) + 정량 (8/8 self-loop = 100%)",
    "sc_2: RESEARCH.md 안 외부 적용 vector evidence — upbit v1.4~v1.16 12 milestone audit-team 호출 여부 + candidate_draft[] 상태 + deferred 3건 cycle 1+2 결과 정량",
    "sc_3: DESIGN.md 안 narrative 정전화 위치 + 정확 문구 1차 source 확정 (v3.21 narrative 정전화 3 단계 패턴 정합)",
    "sc_4: ARCHITECTURE.md 안 narrative 정전화 paragraph 1건 추가 (정확 문구 그대로 삽입)",
    "sc_5: VERIFY.md grep 키워드 3건 모두 PASS (정확 문구 안 cohesive 키워드)",
    "sc_6: pre-commit 14 hook 모두 PASS + 회귀 0",
    "sc_7: lightweight 모드 정합 — 5 관점 subagent 생략 + 산출물 LOC cap ~1500 미만 + 1-phase 1+1 commit + self_reference_policy: avoid 표지 명시"
  ],
  "out_of_scope": [
    "외부 audit-team (`/harness-meta <name> --audit`) 실 호출 first 시도 — 사용자 결정 D2 Recommended scope 외, PROPOSE 거명만",
    "§ 6.2 (v4.0 폐지) 재도입 — 사용자 결정 D2 Recommended scope 외, PROPOSE 거명만",
    "deferred 3건 cycle 4 evaluation — 본 milestone 진단 결과 흡수 가능하나 별 milestone (사용자 결정 D2 Recommended scope 외)",
    "candidate_draft[] 작동 검증 (벤치마크 cycle routine) — RESEARCH 정량 측정만, 작동 자체 검증은 별 milestone",
    "v4.0 정체성 (3 역할) 재정의 — 본 진단은 정의 ↔ 운용 drift 정전화이며 정의 자체 변경 아님",
    "workflow 자체 변경 (claude/commands/harness-meta.md / 9-stage) — § 6.2 폐지 narrative 정신 계승 (self-improvement 회피)"
  ],
  "dependencies": [
    "v4.0_harness-composer-pivot REPORT.md (정체성 도입 1차 source)",
    "v3.6_overengineering-audit REPORT.md (자기 검토 라운드 1번째 선례 + § 6.2 도입 narrative)",
    "v3.17_phase-distribution-audit REPORT.md (자기 검토 라운드 2번째 선례)",
    "v3.19_word-fidelity-audit-v2 REPORT.md (자기 검토 라운드 3번째 선례)",
    "v3.13_pending-milestone-renumber-policy REPORT.md (deferred 3건 cycle 1)",
    "v3.14_deferred-revaluation-cycle-2 REPORT.md (deferred 3건 cycle 2, AND FAIL evidence)",
    "v3.21_narrative-canonicalization-3step-pattern REPORT.md (narrative 정전화 3 단계 패턴 정전화 source)",
    "ARCHITECTURE.md § 3.1 끝 정체성 paragraph (v4.0 도입) + § 6 끝 spec-drift spike paragraph (v5.7 도입)",
    "projects/meta/ROADMAP.md (milestone 정량 source) + projects/upbit/ROADMAP.md (외부 적용 정량 source)"
  ]
}
```

## narrative

본 milestone 은 v3.6 / v3.17 / v3.19 자기 검토 라운드 4 번째 — 누적 패턴 = 진단 milestone 자체가 lightweight + self_reference_policy: avoid 표지 + 1-phase 1+1 commit 도그푸드. v3.6 § 6.2 폐지 (v4.0) 후 첫 자기 검토 라운드이기에 § 6.2 가드레일 정신을 새 정체성 하에 어떻게 표현할지 narrative 정전화 책임.

scope 보수 (사용자 결정 D2 Recommended) — 진단 결과 외부 적용 vector trigger candidate 와 § 6.2 재도입 검토는 PROPOSE 거명만. ROADMAP candidate_draft[] 작동 자체 검증 + deferred 3건 cycle 4 도 본 scope 외 (별 milestone 후속 candidate).

self-loop 모순 (8/8 → 9/9 재현) 회피 책임 = (a) 본 milestone 자체가 1-phase + narrative 1건 정전화 = 산출물 최소 + (b) self_reference_policy: avoid 표지 명시 + (c) 도그푸드 narrative (본 milestone 자체가 self-loop 9 번째 사례임을 명시 인지). 단 본 milestone scope 자체는 진단 + 정전화 — 자기 검토 라운드 (v3.6/3.17/3.19) 선례 정합.

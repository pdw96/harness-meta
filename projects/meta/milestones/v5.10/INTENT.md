# INTENT — v5.10 external-audit-team-second-call-with-diff

```json
{
  "id": "v5.10_external-audit-team-second-call-with-diff",
  "title": "외부 audit-team 두 번째 실 호출 (upbit, proposer까지 read-only) + v1.17 산출물 diff 비교 + v5.8/v5.9 'audit-team 호출 0건' narrative drift 정정",
  "goal": "`/harness-meta upbit --audit` 분기를 통한 audit chain 4 멤버 (scanner → analyzer → mapper → proposer) 재호출로 upbit 현 상태 read-only audit 산출 + v1.17 (2026-05-14) 산출물과의 diff 비교로 시간 경과 후 spec/repo state drift 검출 + v5.8/v5.9 'audit-team 호출 0건' narrative drift 정정 ARCHITECTURE.md 정전화.",
  "motivation": "v5.9 PROPOSE.next_candidates#5 사용자 명시 선택 (`external-audit-team-first-call`) 후 Stage A OPEN 단계 중 v1.17 upbit milestone 안 audit chain 완전 실행 사실 발견 → 'first call' 전제 자체 폐기. 동시에 v5.8 RESEARCH § A 정량 진단 + v5.9 RESEARCH 안 '외부 audit-team 호출 0건' 진술이 v1.17 사실 (commit 16722fd, 5 멤버 sequence 완전 실행 + 12 항목 ACCEPT ALL apply) 과 모순 → evidence-base 진단 reliability 회복 필요. Option B (사용자 명시 결정) = 'second call + diff + narrative drift 정정' 통합 milestone.",
  "success_criteria": [
    "sc_1: audit chain 4 멤버 (scanner → analyzer → mapper → proposer) 모두 호출 완료 + 각 멤버 산출물 produced (proposal-draft.md 최종 산출)",
    "sc_2: 본 milestone proposal-draft 와 v1.17 audit-2026-05-14/proposal-draft.md (12 항목) 의 diff 산출 (added/removed/changed item 분류)",
    "sc_3: v5.8 RESEARCH + v5.9 RESEARCH 안 'audit-team 호출 0건' narrative 위치 grep 식별 + drift 정정 위치 결정 (ARCHITECTURE.md 안 narrative 정전화)",
    "sc_4: ARCHITECTURE.md 안 'audit-team 실 호출 사실 누적 (v1.17 + v5.10 = 2건)' 정전화 paragraph 1건 추가",
    "sc_5: 본 milestone 9-stage 산출물 9건 모두 작성 + pre-commit 14 hook 모두 PASS",
    "sc_6: v3.21 narrative 정전화 3 단계 패턴 (DESIGN 1차 source + EXECUTE Edit 정확 삽입 + VERIFY grep) cycle 누적 (v5.7 9 cycle / v5.8 10 / v5.9 11 / 본 v5.10 = 12) 도그푸드",
    "sc_7: ecosystem integrator 정체성 vector 운용 evidence 1건 명시적 산출 (audit-team 외부 호출 = 핵심 vector)",
    "sc_8: installer 미호출 강제 (read-only 전제) + upbit repo 실 파일 변경 0건 (안전 게이트)"
  ],
  "out_of_scope": [
    "#1: installer 호출 (component-installer) — read-only 전제로 명시 제외. apply 권고는 후속 milestone 으로.",
    "#2: v1.17 milestone narrative 자체 정정 (upbit ROADMAP.md / milestones/v1.17/) — v1.17 산출물은 historical fact 으로 보존, 정정 대상은 v5.8/v5.9 'audit-team 호출 0건' narrative 만.",
    "#3: audit-team 5 멤버 자체 수정 (agents/*.md) — 본 milestone 은 호출만, agent definition 변경 부재.",
    "#4: ROADMAP schema 변경 (v5.9 #1 후보) — 별도 milestone 후속 발의 대상.",
    "#5: harness-meta naming 변경 (v5.9 #2 후보) — 별도 milestone 후속 발의 대상."
  ],
  "dependencies": {
    "preceding": [
      "v1.17_upbit-harness-plugin-pivot-and-audit-componentry (audit chain first call 사실 + proposal-draft.md 1차 source)",
      "v5.9_dictionary-semantics-integrated-audit (next_candidates#5 origin)",
      "v5.8_identity-application-vector-audit (out_of_scope carry-over + 'audit-team 호출 0건' narrative drift origin)",
      "v4.0_harness-composer-pivot (audit-team 도입 + /harness-meta --audit opt-in 분기 도입)"
    ],
    "following": [
      "TBD: diff 결과에 따른 후속 milestone (installer 호출 / Plugin 컴포넌트 추가 / spec drift 정정 등)는 Stage I PROPOSE 에서 next_candidates 거명"
    ]
  }
}
```

## narrative

### Goal

`/harness-meta upbit --audit` 분기 second call 실행 (read-only, proposer 까지) + v1.17 산출물 diff 비교 + narrative drift 정정 3축 통합.

### Motivation

v5.9 PROPOSE.next_candidates#5 (`external-audit-team-first-call`) 사용자 명시 선택 (2026-05-18) 후 Stage A OPEN 단계 중 v1.17 사실 발견 → 'first call' 전제 폐기. v5.8 / v5.9 RESEARCH 안 'audit-team 호출 0건' 진단이 v1.17 사실과 모순 → evidence-base 진단 reliability 회복 + ecosystem integrator vector 운용 evidence 누적 두 마리 토끼.

### Success criteria 8건

- sc_1: 4 멤버 sequence 완전 호출
- sc_2: v1.17 산출물과 diff
- sc_3: drift narrative 위치 식별
- sc_4: ARCHITECTURE 정전화 paragraph 1건
- sc_5: 9-stage 산출물 + pre-commit PASS
- sc_6: v3.21 narrative 정전화 3 단계 12 cycle 도그푸드
- sc_7: ecosystem integrator vector 운용 evidence
- sc_8: installer 미호출 / upbit 실 파일 변경 0건

### Out of scope 5건 (사실 진술만)

- #1: installer 호출 미수행 (read-only)
- #2: v1.17 historical fact 보존
- #3: agent definition 변경 부재
- #4: ROADMAP schema 변경 (v5.9 #1, 별 milestone)
- #5: naming 변경 (v5.9 #2, 별 milestone)

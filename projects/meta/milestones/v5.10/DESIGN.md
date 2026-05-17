# DESIGN — v5.10 external-audit-team-second-call-with-diff

```json
{
  "id": "v5.10_external-audit-team-second-call-with-diff",
  "mode": "lightweight",
  "self_reference_policy": "avoid (자기참조 자연 — 사용자 명시 결정 D9, lightweight 모드 표지 + v3.21 11 cycle 누적 정합)",
  "subagent_review_policy": "skipped (사용자 명시 결정 D1, scope = 작음 ≤ 5 파일)",
  "review_round_history": [
    "Round 1 (자체 의문 round, 사용자 'Stage E 보류' trigger) — 결정적 이슈 3건 식별 → 사용자 명시 결정 흡수 D3+D4+D9 갱신"
  ],
  "decisions": [
    {
      "id": "D1",
      "decision": "lightweight 모드 채택 (5 관점 subagent 생략)",
      "rationale": "사용자 명시 결정 D1. scope = 작음 (≤ 5 파일 영향) → 3 관점 기준치 정합. v5.7~v5.9 lightweight 패턴 3 cycle 누적 정합. lightweight 누적 9/26 → 10/27 (v5.10 = 37%).",
      "alternatives_rejected": ["3 관점 (architecture / spec-drift / scope contract) — LOC + 시간 cost vs v5.7~v5.9 정합 trade-off 에서 lightweight 우위"]
    },
    {
      "id": "D2",
      "decision": "narrative drift 정정 위치 = ARCHITECTURE.md § 4 끝 (drift 수용 paragraph cluster)",
      "rationale": "사용자 명시 결정 D2. v3.20 word-fidelity drift (§ 4 끝 추가) + v5.9 ROADMAP drift (§ 4 끝 추가) cluster 누적 위치. cascade drift = narrative drift family 자연 합류. 3 cycle 누적 = drift 수용 narrative cluster 자연 형성.",
      "alternatives_rejected": ["§ 3.1 끝 (정체성 paragraph 근접) — ecosystem integrator vector 관점 자연, but cascade drift 본질 narrative discipline → § 4 우위", "§ 6 끝 (spec-drift spike 직후) — cascade drift = internal narrative (spec-drift 아님), 의미 부합 약함"]
    },
    {
      "id": "D3",
      "decision": "2 phase 분할 (phase-1 audit chain 호출 / phase-2 diff + ARCHITECTURE + cascade)",
      "rationale": "사용자 명시 결정 D3 (Round 1 의문 #2 흡수). audit chain 4 agent 호출 (각 수백~수천 line 출력) + audit 산출물 = phase-1 책임 단일. diff narrative + ARCHITECTURE § 4 paragraph + cascade = phase-2 narrative 책임 단일. 책임 분리 + commit 각각 점검 가능. LOC 큰 risk mitigation.",
      "alternatives_rejected": ["1 phase 통합 — lightweight 패턴 정합 but audit chain LOC 큰 risk vs 책임 분리 우위에서 2 phase 채택"]
    },
    {
      "id": "D4",
      "decision": "audit 산출물 위치 = projects/upbit/audit-2026-05-18/ (v1.17 패턴 정합)",
      "rationale": "사용자 명시 결정 D4 (Round 1 의문 #1 흡수). v1.17 패턴 = projects/upbit/audit-2026-05-14/ (target 디렉토리 안 audit 회차 누적). 본 v5.10 = projects/upbit/audit-2026-05-18/ (회차 누적 trace 자연). audit-team 산출물 = target 디렉토리 자연 정합. diff narrative 만 milestone 디렉토리 안 별도 파일 (diff-vs-v1.17.md) 로 흡수.",
      "alternatives_rejected": ["projects/meta/milestones/v5.10/audit-output/ — meta milestone 내 자연 but v1.17 패턴 이탈"]
    },
    {
      "id": "D5",
      "decision": "2+1 commit 패턴 (phase-1 + phase-2 + Stage G+H+I 통합 chore)",
      "rationale": "D3 phase 분할 정합. phase-1 = audit chain 호출 + audit 산출물 (upbit/audit-2026-05-18/). phase-2 = diff narrative + ARCHITECTURE 정전화 + cascade (.markdownlintignore + milestones.md). Stage G+H+I commit = VERIFY/REPORT/PROPOSE.md 3건 + ROADMAP status: completed 갱신.",
      "alternatives_rejected": ["1+1 commit (phase-1 통합 + chore) — D3 와 모순"]
    },
    {
      "id": "D6",
      "decision": "ARCHITECTURE § 4 끝 추가 paragraph 정확 문구 1차 source (v3.21 narrative 정전화 3 단계 패턴 12 cycle 도그푸드)",
      "rationale": "v3.21 패턴 = (a) DESIGN 안 정확 문구 1차 source (markdown code block) + (b) phase EXECUTE 안 Edit tool 정확 문구 그대로 삽입 + (c) VERIFY 안 grep 검증 키워드. 본 milestone = 12 번째 cycle 도그푸드.",
      "exact_text": "**Narrative cascade drift 검증 의무 (v5.8 → v5.9 → v5.10 cascade)**: 정전화된 fact 가 후속 milestone carry-over 시 cascade 누락되어 동일 drift 재발 가능. v5.10 evidence — v5.8 RESEARCH (R2 + L172) 가 'audit-team 호출 0건' → '1건 (v1.17 upbit, 2026-05-14)' 1차 정정 + 부합도 60% → 65% upgrade. v5.9 carry-over 시 cascade 누락 → PROPOSE.next_candidates#5 안 'v4.0 도입 후 호출 0건' / INTENT.out_of_scope 안 'first 시도' 재 misclassification 재발. v5.10 second call (audit chain 4 멤버 read-only 재호출 + v1.17 산출물 diff) 가 cascade drift 정정 + audit-team 호출 누적 정확 정량 = 2건 (v1.17 first + v5.10 second). cascade drift 회피 의무 = 후속 milestone PROPOSE/INTENT carry-over 시 origin milestone RESEARCH 안 정정 fact 1차 cross-ref 검증."
    },
    {
      "id": "D7",
      "decision": ".markdownlintignore 갱신 = projects/upbit/audit-2026-05-18/ 추가",
      "rationale": "audit 산출물 = audit-team 자동 생성 narrative (markdown lint 형식 부합 의무 부재). v1.17 패턴 정합 (.markdownlintignore 안 projects/upbit/audit-2026-05-14/ 등재). pre-commit lint 통과 보장.",
      "alternatives_rejected": ["lint 부합 형식 강제 — audit-team 산출물 자동 생성 narrative 형식 통제 어려움"]
    },
    {
      "id": "D8",
      "decision": "audit chain 호출 순서 = scanner → analyzer → mapper → proposer 4 멤버 순차 호출",
      "rationale": "agents/project-harness-audit-team/CLAUDE.md spec 정합. 각 멤버 = subagent_type 명시 호출 (Agent tool). installer (Step 5) 미호출 = read-only 강제 (INTENT.sc_8 + INTENT.OOS#1).",
      "alternatives_rejected": ["병렬 호출 — chain 의존 위배"]
    },
    {
      "id": "D9",
      "decision": "D6 정확 문구 안 'v5.10' 자기참조 자연 표지 (lightweight 모드 + v3.21 11 cycle 누적 정합)",
      "rationale": "사용자 명시 결정 D9 (Round 1 의문 #3 흡수). v3.21 패턴 11 cycle 누적 (v5.7~v5.9 모두 자기 거명). lightweight 모드 = 자기참조 회피 표지 (mode: lightweight + self_reference_policy: avoid + subagent_review_policy: skipped). narrative 구체성 우선 (일반화 시 약화).",
      "alternatives_rejected": ["일반화 ('v{X.Y} cascade' 표현) — narrative 구체성 약화 → 자기참조 자연 우위"]
    }
  ],
  "approach": "Stage F = 2 phase 분할. phase-1 = audit chain 4 멤버 순차 호출 → projects/upbit/audit-2026-05-18/ 산출 (proposal-draft.md + scanner/analyzer/mapper intermediate snapshot). phase-2 = projects/meta/milestones/v5.10/diff-vs-v1.17.md 산출 (v1.17 12 항목 vs 본 milestone proposal-draft 1:1 매핑 표 + narrative) + ARCHITECTURE.md § 4 끝 D6 정확 문구 Edit 삽입 + .markdownlintignore 갱신 + milestones.md sub_milestones 동기 갱신. 각 phase 1 commit. Stage G+H+I 통합 chore commit.",
  "phases": [
    {
      "n": 1,
      "title": "audit chain 4 멤버 순차 호출 + projects/upbit/audit-2026-05-18/ 산출",
      "scope": [
        "Agent(project-scanner) 호출 → upbit 메타데이터 추출",
        "Agent(harness-gap-analyzer) 호출 → gap/conflict/fleet evolution detect",
        "Agent(claude-docs-mapper) 호출 → Claude Code 도구 카탈로그 매핑",
        "Agent(component-proposer) 호출 → proposal-draft.md 산출",
        "projects/upbit/audit-2026-05-18/ 디렉토리 생성 + proposal-draft.md 저장 + intermediate snapshot 저장 (선택)"
      ],
      "affected_files": [
        "projects/meta/milestones/v5.10/execute/phase-1.md (신규)",
        "projects/upbit/audit-2026-05-18/proposal-draft.md (신규, audit chain 산출)",
        "projects/upbit/audit-2026-05-18/scanner-output.md (선택, intermediate)",
        "projects/upbit/audit-2026-05-18/analyzer-output.md (선택, intermediate)",
        "projects/upbit/audit-2026-05-18/mapper-output.md (선택, intermediate)"
      ],
      "rationale": "phase-1 책임 단일 = audit chain 호출 + 산출물 저장. v1.17 패턴 (target 디렉토리 안 audit 회차) 정합.",
      "risks": ["R1 audit chain LOC 큰 risk → intermediate snapshot 선택적 저장 (proposer 결과만 필수)", "R3 markdownlint 침범 → phase-2 안 .markdownlintignore 갱신 cascade"]
    },
    {
      "n": 2,
      "title": "diff narrative + ARCHITECTURE § 4 끝 cascade drift paragraph + cascade 갱신",
      "scope": [
        "projects/meta/milestones/v5.10/diff-vs-v1.17.md 산출 (v1.17 12 항목 vs 본 milestone proposal 1:1 매핑 표 + added/removed/changed 분류 + narrative)",
        "ARCHITECTURE.md § 4 끝 D6 정확 문구 Edit 정확 삽입 (v3.21 3 단계 패턴 (b) 단계)",
        ".markdownlintignore 갱신 (projects/upbit/audit-2026-05-18/ 등재)",
        "milestones.md sub_milestones[] phase-2 entry 추가 (phase-1 갱신 직후)"
      ],
      "affected_files": [
        "projects/meta/milestones/v5.10/execute/phase-2.md (신규)",
        "projects/meta/milestones/v5.10/diff-vs-v1.17.md (신규, diff narrative)",
        "projects/meta/ARCHITECTURE.md (§ 4 끝 cascade drift paragraph 추가)",
        ".markdownlintignore (projects/upbit/audit-2026-05-18/ 등재)",
        "projects/meta/milestones/v5.10/milestones.md (sub_milestones[] 2 entry 갱신)"
      ],
      "rationale": "phase-2 책임 단일 = diff narrative + narrative 정전화 + cascade. ARCHITECTURE § 4 끝 D6 정확 문구 Edit 삽입 = v3.21 3 단계 패턴 (b) 도그푸드.",
      "risks": ["R2 정정 위치 → D2 § 4 끝 확정", "R4 도그푸드 위배 → narrative drift 정정 + ecosystem integrator vector 자연 부합"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1 audit chain 재호출 LOC 큰 risk",
      "mitigation": "phase-1 분리 (D3) + intermediate snapshot 선택 저장 + diff narrative 정량 표 + 200 line cap."
    },
    {
      "risk": "R2 narrative drift 정정 위치 결정 분기",
      "mitigation": "D2 사용자 결정 = § 4 끝 확정."
    },
    {
      "risk": "R3 audit 산출물 markdownlint 침범",
      "mitigation": "phase-2 안 .markdownlintignore 갱신 cascade (D7). v1.17 패턴 정합."
    },
    {
      "risk": "R4 ecosystem integrator vector evidence 강조 도그푸드 위배 risk",
      "mitigation": "본 milestone = audit-team 외부 호출 본질 + narrative drift 정정 본질 = ecosystem integrator 정체성 자연 부합."
    },
    {
      "risk": "R5 lightweight vs 정식 결정 분기",
      "mitigation": "D1 사용자 결정 = lightweight 확정."
    },
    {
      "risk": "R6 self-reference 위배 risk (D6 안 'v5.10' 거명)",
      "mitigation": "D9 사용자 결정 = 자기참조 자연 (lightweight 표지 + v3.21 11 cycle 누적 정합)."
    }
  ]
}
```

## narrative

### Decisions 9건 (Round 1 의문 round 후 D3+D4+D9 갱신)

- D1: lightweight 모드 (5 관점 생략)
- D2: ARCHITECTURE § 4 끝 위치
- D3: **2 phase 분할** (갱신)
- D4: **projects/upbit/audit-2026-05-18/** (갱신, v1.17 패턴 정합)
- D5: **2+1 commit** (갱신, D3 정합)
- D6: D6 정확 문구 1차 source (v3.21 12 cycle 도그푸드)
- D7: .markdownlintignore 갱신
- D8: audit chain 4 멤버 순차 호출
- D9: **자기참조 자연 표지** (신규, lightweight + v3.21 정합)

### Approach (Stage F 2 phase)

- phase-1 = audit chain 호출 + projects/upbit/audit-2026-05-18/ 산출
- phase-2 = diff narrative + ARCHITECTURE 정전화 + cascade
- Stage G+H+I 통합 chore commit

### Phases 2 (2 phase 분할)

- phase-1 = audit chain 4 멤버 + 산출물 저장 (책임 단일)
- phase-2 = diff narrative + ARCHITECTURE § 4 끝 D6 정확 문구 Edit + cascade

### Risk mitigation 6 (R1~R6, R6 신규)

R1 LOC → 분리 + 정량 표 / R2 위치 → § 4 끝 / R3 lint → .markdownlintignore / R4 도그푸드 → 자연 부합 / R5 mode → lightweight / R6 자기참조 → D9 자연 표지.

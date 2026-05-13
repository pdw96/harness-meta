# DESIGN — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "mode": "lightweight",
  "self_reference_policy": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지)",
  "subagent_review_policy": "skipped (5 관점 subagent 생략, v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20 누적 8건 패턴 정합 — 9번째 적용)",
  "decisions": [
    {
      "decision_id": "D1",
      "decision": "narrative host 위치 = ARCHITECTURE.md § 6.2 Lightweight 모드 안 'Workflow self-improvement 동결 정책' paragraph 직후 (line 199 직후) + '선례' subsection 직전 (line 200 직전) 새 paragraph 1건 삽입",
      "rationale": "사용자 명시 선택 (AskUserQuestion D1 — Option 3 § 6.2 Recommended). § 6.2 Lightweight 모드 영역 = narrative 정전화 milestone (lightweight 모드 default 적용 사례) 와 직접 일치 영역. 'Workflow self-improvement 동결 정책' paragraph 직후 = '정책 (동결) → 정합 메커니즘 (3단계 패턴) → 선례' 자연 cascade. RESEARCH options Option 3 채택.",
      "alternatives_rejected": [
        "Option 1 (§ 4 끝) — 단어 책임 정의 영역 (drift 수용 paragraph) cascade 약화 + lightweight 메커니즘 본질 영역 부적합",
        "Option 2 (§ 6.1 Bundling) — bundling 정책 영역 (의미 grouping / 운용) vs 3단계 패턴 (narrative 정전화 정합 메커니즘) 책임 차원 차이",
        "Option 4 (§ 6.3 sub-section 신설) — paragraph 1건 분량 vs sub-section 신설 과대 + 단일 source 전략 (v3.18 D1 / v3.20 D3) 정합 위배 risk"
      ]
    },
    {
      "decision_id": "D2",
      "decision": "narrative 정확 문구 = '**Narrative 정전화 3단계 패턴** (v3.18_option-a-natural-adaptation-narrative + v3.20_drift-narrative-canonicalization 발현 + v3.21_narrative-canonicalization-3step-pattern 정전화)' bold lead + 3 단계 (a)/(b)/(c) 정의 + v3.18/v3.20 cross-ref + grep 검증 키워드 예시 (v3.20) + 적용 trigger + 도그푸드 자기 적용 표지",
      "rationale": "v3.18 D3 + v3.20 D2 정확 문구 패턴 정확 정합 (1 paragraph 안 bold lead + cross-ref + 예시 + 적용 trigger). VERIFY grep 검증 키워드 = '(a)' + '(b)' + '(c)' + 'v3.18' + 'v3.20' + 'narrative 정전화' + 'lightweight' (정확 문구 안 cohesive 키워드 직접 추출).",
      "alternatives_rejected": [
        "긴 multi-paragraph 분할 — v3.18 / v3.20 패턴 부재 + lightweight 모드 LOC cap 위반 risk",
        "(a)/(b)/(c) 추상 정의만 (예시 부재) — VERIFY grep 검증 키워드 cohesive 약화"
      ]
    },
    {
      "decision_id": "D3",
      "decision": "단일 source 전략 = ARCHITECTURE.md § 6.2 만 변경 + 다른 host (CLAUDE.md / 모듈 가이드 / harness-meta.md / CHANGELOG / AGENTS / README / GUARDRAILS) cross-ref 추가 zero",
      "rationale": "v3.18 D1 Option 1 + v3.20 D3 패턴 정확 정합 (v1.4_cross-ref-propagation 정책 정합). § 3.5 단일 source 정합 narrative 직접 적용 ('본 § 3 (정의) 는 본 파일이 단일 source. 다른 문서는 cross-ref 만') 가 § 4 / § 6 영역에도 일관 적용 — narrative 본문 1곳 + 다른 host cross-ref zero. 본 milestone 자체가 단일 source 전략 자기 적용 (도그푸드).",
      "alternatives_rejected": [
        "다른 host cross-ref 추가 (CLAUDE.md root § 워크플로우 또는 projects/meta/CLAUDE.md) — drift narrative cascade 책임 본 milestone scope 외 (cross-ref 무한 확장 risk, v3.20 R6 mitigation 정합)"
      ]
    },
    {
      "decision_id": "D4",
      "decision": "lightweight 모드 채택 (5 관점 subagent 생략 + 산출물 LOC cap < 800)",
      "rationale": "§ 6.2 Lightweight 모드 trigger 3 조건 모두 충족 — (1) 본질: workflow self-improvement (ARCHITECTURE.md § 6.2 변경, 외부 프로젝트 적용 부재), (2) scope 작음: ≤5 파일 + narrative 강화 중심, (3) 5 관점 의견 충돌 부재 예상: host 위치 사용자 명시 결정 + 정확 문구 D2 명시 + 단일 source D3 명시. self_reference_policy: avoid 표지 명시. v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20 누적 8/20 = 40% 패턴 정합 (9번째 적용).",
      "alternatives_rejected": [
        "일반 모드 (5 관점 subagent 검토) — scope 작음 (1 파일 변경 + 1 paragraph narrative 추가) 대비 over-engineering, v3.18/v3.19/v3.20 패턴 부재"
      ]
    },
    {
      "decision_id": "D5",
      "decision": "phase 분할 = 1 phase (ARCHITECTURE.md 1 paragraph 추가 + 산출물 통합 1 commit)",
      "rationale": "narrative 정전화 1 paragraph = 의미 단위 1건 → 1 phase 자연. v3.18/v3.20 패턴 정합 (1-phase 1+1 commit 도그푸드). § 6.1 1-phase milestone 정합 narrative 정확 정합 (v3.17 진단 + v3.18 정전화). 본 milestone 자체가 narrative 정전화 3단계 패턴 자기 적용 = 1-phase 도그푸드 = 자기참조 cycle 누적 3 cycle (v3.18 + v3.20 + 본 milestone) 정확 정전화.",
      "alternatives_rejected": [
        "다중 phase 분할 — D3 단일 source 채택 결과 cross-ref 추가 zero → phase-2 scope 부재"
      ]
    },
    {
      "decision_id": "D6",
      "decision": "commit timing = (b) default 명시 narrative — 단 lightweight 1-phase 시 (a)/(b)/(c) 실 동치 (v3.17 L4 + v3.18 L3 + v3.19 L4 + v3.20 L1 4 cycle 누적 evidence). 실 운용 시 phase-1 commit 안 ARCHITECTURE.md 변경만 + Stage G chore commit 안 산출물 7건 + milestones.md 갱신 + ROADMAP completed",
      "rationale": "v3.20 D6 패턴 정확 정합. lightweight 1-phase 시 (b) default narrative 보존 + 실 운용 (a) (phase-1 commit 안 INTENT~APPROVE 포함) 도 동치 인정 — v3.20 L1 lesson 1차 source.",
      "alternatives_rejected": [
        "(a) phase-1 commit 안 INTENT~APPROVE 포함 명시 — lightweight 1-phase 시 (a)/(b) 실 동치, narrative 단일 표현 (b) default 보존"
      ]
    }
  ],
  "approach": "ARCHITECTURE.md § 6.2 Lightweight 모드 안 'Workflow self-improvement 동결 정책' paragraph 직후 + '선례' subsection 직전 새 paragraph 1건 추가 (D1 위치 + D2 정확 문구). 단일 source 전략 (D3) — 다른 host 변경 zero. lightweight 모드 (D4) — 5 관점 subagent 생략, 1 phase 1+1 commit, commit timing (b) default. milestones.md sub_milestones[0] placeholder title 본 DESIGN 단계 phase-1 정확 title 교체 (Stage D 의무 step, v3.5 도입).",
  "phases": [
    {
      "n": 1,
      "title": "ARCHITECTURE.md § 6.2 Narrative 정전화 3단계 패턴 paragraph 추가 — 'Workflow self-improvement 동결 정책' 직후 (선례 직전) + commit",
      "scope": "ARCHITECTURE.md § 6.2 안 1 paragraph (3단계 패턴 narrative 정전화). 다른 host 변경 zero. 워크플로우 본문 (Stage A~I 9-stage 절차) 변경 zero. smoke 추가 zero.",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md (§ 6.2 narrative 1 paragraph 추가 — 'Workflow self-improvement 동결 정책' 직후 + '선례' 직전)",
        "projects/meta/milestones/v3.21/execute/phase-1.md (본 phase 추적)",
        "projects/meta/milestones/v3.21/milestones.md (sub_milestones[0].title placeholder 교체 + Stage G commit 시 status complete + commit hash)",
        "projects/meta/milestones/v3.21/INTENT.md (작성됨, Stage G chore commit 안 포함)",
        "projects/meta/milestones/v3.21/RESEARCH.md (작성됨, Stage G chore commit 안 포함)",
        "projects/meta/milestones/v3.21/DESIGN.md (본 파일, Stage G chore commit 안 포함)",
        "projects/meta/milestones/v3.21/APPROVE.md (Stage E 작성, Stage G chore commit 안 포함)",
        "projects/meta/milestones/v3.21/VERIFY.md (Stage G 작성)",
        "projects/meta/milestones/v3.21/REPORT.md (Stage H 작성)",
        "projects/meta/milestones/v3.21/PROPOSE.md (Stage I 작성)",
        "projects/meta/ROADMAP.md (entry in_progress 등재됨 + Stage I completed 갱신 + updated 2026-05-14)"
      ],
      "rationale": "narrative 정전화 1 paragraph = 1 phase 자연 (D5). v3.18/v3.20 패턴 정합 (1-phase 1+1 commit 도그푸드).",
      "risks": [
        "ARCHITECTURE.md 1 paragraph 추가 시 markdownlint MD031 (fenced code blocks blank lines) 또는 MD049 (emphasis style) trigger risk — pre-commit hook 자동 차단, v3.1 L1 + v3.20 D risk mitigation 패턴 정합",
        "narrative 정확 문구 cohesive 부재 risk — VERIFY criteria_check 안 grep 검증 1:1 매핑"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "risk": "host 위치 narrowing",
      "mitigation": "AskUserQuestion Stage D D1 사용자 명시 선택 (Option 3 § 6.2) → 결정 사용자 위임. RESEARCH options 4건 raw 분석 (v3.10 부산물 정책 정합)"
    },
    {
      "risk_id": "R2",
      "risk": "narrative cohesive 부재",
      "mitigation": "D2 정확 문구 1차 source (본 DESIGN ## Phase 1 정확 narrative 정문구 섹션) + VERIFY grep 검증 키워드 ((a)/(b)/(c) + v3.18/v3.20 + narrative 정전화 + lightweight 키워드)"
    },
    {
      "risk_id": "R3",
      "risk": "단일 source 위배",
      "mitigation": "D3 단일 source 채택 명시 (v3.18 D1 / v3.20 D3 패턴 정확 정합) — ARCHITECTURE.md § 6.2 1곳만 narrative + 다른 host cross-ref 추가 zero"
    },
    {
      "risk_id": "R4",
      "risk": "lightweight 5 관점 생략",
      "mitigation": "v3.6~v3.20 누적 8/20 검증 패턴 정합 + self_reference_policy: avoid 표지 명시. 1 파일 변경 + 1 paragraph narrative 추가 = architecture 검토 본질 부재"
    },
    {
      "risk_id": "R5",
      "risk": "자기참조 모순 표지 (3단계 패턴 명문화 milestone 자체가 3단계 패턴 적용 = 패턴 자체로 패턴 명문화 = 도그푸드 cycle 3번째)",
      "mitigation": "self_reference_policy: avoid 명시 + 도그푸드 정합 narrative (본 DESIGN 안 ## 도그푸드 정합 섹션) + § 6.2 trigger 3건 충족 검증 — 의도성 표지 정합"
    },
    {
      "risk_id": "R6",
      "risk": "markdownlint trap (MD031 fenced code blocks blank lines / MD049 emphasis style)",
      "mitigation": "v3.1 L1 + v3.20 R6 mitigation 패턴 정합 — pre-commit hook 자동 차단, 정확 문구 안 markdown 호환 표현 사용 (bold lead + 정확 인용 부호 + 정확 cross-ref link 형식)"
    }
  ],
  "byproduct_check": "DESIGN.decisions[i].rationale + phases[n].scope 모두 사실 진술 — 'PROPOSE.next_candidates 발의' / '별 milestone 분리' 등 forward propose 명령형 표현 부재 (v3.10 부산물 정책 정합)",
  "review": {
    "mode": "lightweight",
    "subagent_review_policy": "skipped (5 관점 subagent 생략, v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20 누적 8건 패턴 정합)",
    "self_reference_policy": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지)",
    "self_reference_rationale": "본 milestone 자체 1-phase 1+1 commit + narrative 정전화 3단계 패턴 자기 적용 도그푸드 = v3.17 lesson L6 + v3.18 D4 + v3.20 D5 패턴 정확 정합. 3단계 패턴 명문화 milestone 자체가 3단계 패턴 적용 = 자기참조 cycle 3번째 (v3.18 + v3.20 + 본 milestone)"
  }
}
```

## narrative

본 DESIGN 은 **lightweight 모드 정합** — 6 decisions (D1~D6) + 1 phase + 6 risk_mitigation + 5 관점 subagent 생략 (review.mode: lightweight).

D1 host 위치 (§ 6.2 Lightweight 모드 안) = 사용자 명시 선택 (AskUserQuestion Option 3). D2 정확 문구 (3단계 (a)/(b)/(c) + v3.18/v3.20 cross-ref + grep 키워드 예시 + 적용 trigger) = INTENT.success_criteria 2 검증 가능. D3 단일 source = v3.18 D1 / v3.20 D3 패턴 정확 정합. D4 lightweight = § 6.2 trigger 3건 충족. D5 1 phase + D6 commit timing (b) default = v3.20 패턴 정합.

`decisions[i].rationale` + `phases[n].scope` 모두 사실 진술 — forward propose 명령형 부재 (v3.10 부산물 정책 정합).

## Phase 1 정확 narrative 정문구

ARCHITECTURE.md § 6.2 안 'Workflow self-improvement 동결 정책' paragraph 직후 (line 199 직후) + '**선례**:' subsection 직전 (line 200 직전) 삽입 paragraph (D2 정확 문구):

```markdown
**Narrative 정전화 3단계 패턴** (v3.18_option-a-natural-adaptation-narrative + v3.20_drift-narrative-canonicalization 발현 + v3.21_narrative-canonicalization-3step-pattern 정전화): 문서 host (ARCHITECTURE.md / CLAUDE.md 등) 안 단일 paragraph 추가로 narrative 정전화하는 lightweight 모드 milestone 의 정합 메커니즘 = 3 단계 1:1 결속. **(a) DESIGN 안 정확 문구 1차 source** — DESIGN.md 안 sub-header `## Phase 1 정확 narrative 정문구` + markdown code block 안 정확 문구 1차 source. DESIGN 단계 안 narrative 자체가 paragraph 형태로 확정되어 후속 단계 변형 차단. **(b) phase-1 EXECUTE Edit 그대로 삽입** — phase-1 EXECUTE 안 Edit tool 으로 (a) 정확 문구 그대로 호스트 파일에 삽입. Edit 의 exact-match 의무가 narrative 일관성 보장. **(c) VERIFY grep 검증 키워드** — VERIFY.md `criteria_check` 안 grep 검증 키워드 = (a) 정확 문구 안 cohesive 키워드 직접 추출 (예: v3.20 = `86.1%` + `APPROVE 100%` + `PROPOSE 70%` + `drift 의도성`). grep 검증이 (a) 와 (b) 의 정합을 직접 검증. 적용 trigger = ARCHITECTURE.md / CLAUDE.md 등 문서 host 안 1 paragraph 추가 narrative 정전화 milestone (lightweight 모드 default). 본 패턴 부재 시 후속 milestone 마다 패턴 재발견 비용 + 변형 risk. 본 paragraph 자체가 본 패턴 자기 적용 (도그푸드).
```

## milestones.md sub_milestones 동기 갱신 (Stage D 의무 step, v3.5 도입)

`projects/meta/milestones/v3.21/milestones.md` sub_milestones[0] placeholder title 본 DESIGN phase-1 title 정확 교체:

- placeholder: `<placeholder, Stage D DESIGN 단계에서 정확한 phase 분할 후 갱신>`
- 정확 title: `ARCHITECTURE.md § 6.2 Narrative 정전화 3단계 패턴 paragraph 추가 — 'Workflow self-improvement 동결 정책' 직후 (선례 직전) + commit`

## 도그푸드 정합

본 milestone 자체가 **3단계 패턴 자기 적용** — (a) 본 DESIGN ## Phase 1 정확 narrative 정문구 섹션 안 markdown code block 정확 문구 = 1차 source / (b) phase-1 EXECUTE Edit 정확 문구 그대로 삽입 / (c) VERIFY grep 키워드 검증. 자기참조 cycle 3번째 (v3.18 + v3.20 + 본 milestone = 3 cycle 누적 = 정전화 권장 trigger 충족).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- milestones.md: [`milestones.md`](milestones.md)
- v3.18 패턴 1차 발현: [`../v3.18/DESIGN.md`](../v3.18/DESIGN.md) (## Phase 1 정확 narrative 정문구 섹션)
- v3.20 패턴 두 번째 발현: [`../v3.20/DESIGN.md`](../v3.20/DESIGN.md) (## Phase 1 정확 narrative 정문구 섹션)
- v3.20 L4 1차 source: [`../v3.20/REPORT.md`](../v3.20/REPORT.md) (L4 lesson)
- ARCHITECTURE.md insertion target: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2 'Workflow self-improvement 동결 정책' 직후
- § 6.2 lightweight 모드 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
- v3.10 부산물 정책: [`../v3.10/DESIGN.md`](../v3.10/DESIGN.md)

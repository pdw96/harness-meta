# RESEARCH — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "external": [
    {
      "source": "v3.20 REPORT.md L4 lesson",
      "topic": "3단계 패턴 발현 1차 source",
      "findings": "v3.20 REPORT L4: 'ARCHITECTURE.md narrative 정전화 milestone 안 정확 문구 1차 source 위치 = DESIGN.md 안 \"Phase 1 정확 narrative 정문구\" 섹션 (markdown code block) — v3.18 D3 패턴 정전화 두 번째 적용. 본 패턴 = (a) DESIGN 안 정확 문구 1차 source (b) phase-1 EXECUTE 안 Edit tool 정확 문구 그대로 삽입 (c) VERIFY 안 grep 검증 키워드 (정확 문구 안 cohesive 키워드 추출). 3 단계 정합 패턴'",
      "drift": "patterns 2 cycle 누적 (v3.18 + v3.20) — 명문화 부재 = 후속 milestone 마다 패턴 재발견 비용"
    },
    {
      "source": "v3.18 DESIGN.md L121~127 ('## Phase 1 정확 narrative 정문구' 섹션 + markdown code block)",
      "topic": "3단계 패턴 (a) DESIGN 1차 source 발현 1차",
      "findings": "v3.18 DESIGN.md 안 sub-header '## Phase 1 정확 narrative 정문구' + markdown code block 안 ARCHITECTURE § 6.1 line 166 직후 삽입 paragraph 정확 문구 (1-phase 정합 narrative 70.6%) 1차 source. EXECUTE 안 Edit tool 정확 문구 그대로 삽입.",
      "drift": "v3.18 D3 decision 안 narrative 정확 문구 텍스트로 정의됨 — sub-header markdown code block 패턴 v3.18 발현"
    },
    {
      "source": "v3.20 DESIGN.md L121~127 ('## Phase 1 정확 narrative 정문구' 섹션 + markdown code block)",
      "topic": "3단계 패턴 두 번째 발현",
      "findings": "v3.20 DESIGN.md 안 동일 sub-header '## Phase 1 정확 narrative 정문구' + markdown code block 안 ARCHITECTURE § 4 line 117 직후 삽입 paragraph 정확 문구 (drift 수용 paragraph) 1차 source. v3.18 패턴 정확 재현.",
      "drift": "동일 sub-header 이름 사용 = 자연 도그푸드 (의도 부재, 패턴 자연 발현)"
    },
    {
      "source": "ARCHITECTURE.md § 4 line 117~119 (B/C/D 부산물 흡수 + drift 수용 paragraph)",
      "topic": "narrative 정전화 결과 (v3.20 phase-1 commit b929cd8)",
      "findings": "ARCHITECTURE.md § 4 끝 line 119 'Word-fidelity drift 수용' bold lead paragraph 1건 = v3.20 phase-1 commit 결과 = (b) EXECUTE Edit 그대로 삽입 결과물",
      "drift": "검증 grep 키워드 = '86.1%' + 'APPROVE 100%' + 'PROPOSE 70%' + 'drift 의도성' = (c) VERIFY grep 검증 출처"
    },
    {
      "source": "v3.20 VERIFY.md criteria_check (file_path: projects/meta/milestones/v3.20/VERIFY.md — 본 RESEARCH 직접 검증 불필요)",
      "topic": "3단계 (c) grep 검증 발현",
      "findings": "v3.20 VERIFY.md criteria_check 7건 모두 grep '86.1%' + 'APPROVE 100%' + 'PROPOSE 70%' + 'drift 의도성' + '§ 6.2' 키워드 검증 — D2 narrative 정확 문구 안 cohesive 키워드 직접 추출",
      "drift": "(c) grep 검증 키워드 = D2 정확 문구 안 cohesive 표현 직접 추출 패턴 v3.18 / v3.20 모두 발현"
    },
    {
      "source": "v3.10 부산물 정책 (DESIGN.decisions[i].rationale + phases[n].scope 사실 진술만)",
      "topic": "byproduct 정책 정합",
      "findings": "본 milestone 3단계 패턴 명문화 narrative = 사실 진술 (패턴이 v3.18/v3.20 안 자연 발현했다 + 명문화 = 후속 milestone 일관 적용 보장) — forward propose 명령형 부재 의무 (v3.10 정합)",
      "drift": "본 RESEARCH 안 forward propose 명령형 (예: '별 milestone 으로 명문화') 부재 — 사실 진술만"
    }
  ],
  "codebase": {
    "affected_files_candidate": [
      "projects/meta/ARCHITECTURE.md (host 위치 1곳 결정 후 narrative paragraph 1건 추가) — Stage D 결정",
      "projects/meta/ROADMAP.md (entry status: in_progress 추가됨, Stage I completed 갱신 예정)",
      "projects/meta/milestones/v3.21/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md (작성 중)",
      "projects/meta/milestones/v3.21/milestones.md (skeleton 작성됨, Stage D phase title 교체)",
      "projects/meta/milestones/v3.21/execute/phase-1.md (Stage F 작성)"
    ],
    "untouched_files_explicit": [
      "claude/commands/harness-meta.md (워크플로우 본문 변경 zero — INTENT.out_of_scope #1)",
      "CLAUDE.md root (단일 source 전략, v3.18 D1 / v3.20 D3 패턴 정합)",
      "projects/meta/CLAUDE.md (lazy load 모듈 가이드, cross-ref 추가 zero — INTENT.out_of_scope #3)",
      "tests/* (smoke 추가 / 변경 zero — INTENT.out_of_scope #2)",
      "CHANGELOG.md (외부 visible artifact, 본 milestone scope 외 — INTENT.out_of_scope #6)",
      "AGENTS.md / README.md / GUARDRAILS.md (다른 host 거명 zero — INTENT.out_of_scope #6)"
    ],
    "current_state": "ARCHITECTURE.md § 4 끝 (line 117 B/C/D 흡수 + line 119 drift 수용 paragraph) + § 4.1 Bundling (line 121~) + § 6.1 era 정책 (line 153~178) + § 6.2 Lightweight 모드 (line 182~203). 3단계 패턴 명문화 narrative 부재.",
    "target_state": "ARCHITECTURE.md 안 host 1곳 (§ 4 / § 4.1 / § 6.1 / § 6.2 중 1, Stage D 결정) 에 'Narrative 정전화 3단계 패턴' bold lead paragraph 1건 추가 — (a)/(b)/(c) 정의 + v3.18/v3.20 cross-ref + 적용 trigger ('문서 host 안 단일 paragraph 추가 narrative 정전화 milestone'). 다른 host 변경 zero (단일 source)."
  },
  "options": [
    {
      "option_id": "Option 1 (§ 4 끝, drift 수용 paragraph 직후)",
      "position": "ARCHITECTURE.md § 4 끝 (line 119 'Word-fidelity drift 수용' paragraph 직후, § 4.1 Bundling 헤더 직전)",
      "pros": [
        "v3.20 drift 수용 paragraph 직후 = 'word-fidelity drift 수용 (정의) → narrative 정전화 패턴 (메커니즘)' 자연 cascade",
        "단어 책임 정의 영역 (§ 4) 안 = 9-stage 단어 책임 정의 직접 영향 (DESIGN/EXECUTE/VERIFY 3 stage 책임 narrative 정전화 메커니즘)",
        "§ 4 안 다른 paragraph 들과 균형 (B/C/D 부산물 흡수 + drift 수용 + 3단계 패턴 = 3 paragraph 균형)"
      ],
      "cons": [
        "3단계 패턴 본질 = workflow 자체보다 narrative 정전화 milestone 메커니즘 = § 6 (운용 정책) 영역이 더 정확",
        "§ 4 단어 책임 정의 영역 cascade 약화 risk (drift 수용 paragraph 와 책임 차원 차이)"
      ]
    },
    {
      "option_id": "Option 2 (§ 4.1 Bundling 안, 1-phase 정합 paragraph 직후)",
      "position": "ARCHITECTURE.md § 6.1 line 170 '1-phase milestone 정합' paragraph 직후 (자기참조 부합 paragraph 직전)",
      "pros": [
        "v3.18 1-phase 정합 paragraph 직후 = 'bundling 1-phase 정합 (정의) → narrative 정전화 패턴 (메커니즘)' cascade",
        "§ 6.1 운용 영역 안 (bundling 정책) = 9-stage-bundled era 운용 narrative 자연 위치",
        "v3.18 narrative 정전화 위치 (§ 6.1 line 170) 와 동일 영역 = 패턴 1차 발현 영역과 같은 host"
      ],
      "cons": [
        "§ 6.1 = bundling 정책 영역 (의미 grouping / 운용 / 자기참조 / breaking change / forward-only / spec historical) = 3단계 패턴 본질 (narrative 정전화 메커니즘) 영역 약간 약화",
        "§ 6.1 paragraph 수 누적 (이미 7 paragraph) → 8 paragraph"
      ]
    },
    {
      "option_id": "Option 3 (§ 6.2 Lightweight 모드 안, '선례' subsection 직전)",
      "position": "ARCHITECTURE.md § 6.2 line 199 'Workflow self-improvement milestone 동결 정책' paragraph 직후 (line 200 '선례' subsection 직전)",
      "pros": [
        "lightweight 모드 적용 milestone (v3.18/v3.20) 발현 패턴 = § 6.2 영역과 직접 일치",
        "narrative 정전화 milestone = lightweight 모드 default 적용 = § 6.2 운용 메커니즘 자연 cascade",
        "'적용 시 차이' (산출물 LOC cap + 5 관점 생략 + 도그푸드 회피) + 'workflow self-improvement 동결 정책' + 'narrative 정전화 3단계 패턴' = 3 메커니즘 균형"
      ],
      "cons": [
        "§ 6.2 영역 = '자기참조 회피' 정책 본질 영역 = '3단계 패턴' (정합 메커니즘) = 영역 다소 다름 (정책 vs 메커니즘)",
        "'선례' subsection 직전 = subsection 흐름 단절 risk"
      ]
    },
    {
      "option_id": "Option 4 (§ 6.3 sub-section 신설)",
      "position": "ARCHITECTURE.md § 6.2 끝 + 신규 § 6.3 'Narrative 정전화 3단계 패턴'",
      "pros": [
        "독립 sub-section = 패턴 명문화 영역 명확 + 미래 확장 여지",
        "다른 § 6 sub-section (6.1 era / 6.2 Lightweight) 과 sibling 균형"
      ],
      "cons": [
        "sub-section 신설 = ARCHITECTURE.md 구조 변경 (paragraph 추가보다 큰 변경)",
        "1 paragraph narrative 분량 = sub-section 신설 과대",
        "단일 source 전략 (v3.18 D1 / v3.20 D3) 정합 위배 가능성 (sub-section 신설 = structural change)"
      ]
    }
  ],
  "risks_identified": [
    {
      "risk_id": "R1",
      "risk": "host 위치 선택 narrowing — 4 options 중 단일 결정 어려움",
      "mitigation": "AskUserQuestion Stage D D1 사용자 명시 선택 (preview field 활용 가능, v3.20 L5 패턴 정합)"
    },
    {
      "risk_id": "R2",
      "risk": "3단계 패턴 정확 narrative cohesive 부재 — 3 단계 정의 + cross-ref + 적용 trigger 정확 문구",
      "mitigation": "DESIGN D2 정확 문구 1차 source + VERIFY grep 검증 키워드 ((a)/(b)/(c) + v3.18/v3.20 + narrative 정전화 키워드) — 패턴 자체 자기 적용 (3단계 패턴으로 3단계 패턴 명문화)"
    },
    {
      "risk_id": "R3",
      "risk": "단일 source 위배 — 다른 host (CLAUDE.md / 모듈 CLAUDE.md / harness-meta.md / CHANGELOG.md) cross-ref 추가 유혹",
      "mitigation": "DESIGN D3 단일 source 채택 명시 (v3.18 D1 / v3.20 D3 패턴 정확 정합) — ARCHITECTURE.md 1곳만 narrative + 다른 host cross-ref 추가 zero"
    },
    {
      "risk_id": "R4",
      "risk": "lightweight 모드 5 관점 생략 — narrative 정전화 milestone 8/21 = 38% 누적, 자기참조 사이클 risk",
      "mitigation": "self_reference_policy: avoid 명시 (§ 6.2 trigger 3건 충족: narrative 정전화 + ≤5 파일 + 충돌 부재 예상). v3.6/v3.10/v3.13/v3.14/v3.17/v3.18/v3.19/v3.20 누적 8건 + 본 milestone = 9건 패턴 정합"
    },
    {
      "risk_id": "R5",
      "risk": "자기참조 모순 표지 — 본 milestone 자체가 3단계 패턴 명문화 + 3단계 패턴 자기 적용 = 패턴 자체로 패턴 명문화",
      "mitigation": "도그푸드 정합 의도성 명시 — INTENT.도그푸드 정합 섹션 + DESIGN narrative 안 자기 적용 표지. v3.18 D5 / v3.20 D5 / v3.17 L6 패턴 정합"
    },
    {
      "risk_id": "R6",
      "risk": "ARCHITECTURE.md markdownlint trap (MD031 fenced code blocks blank lines / MD049 emphasis style)",
      "mitigation": "v3.1 L1 mitigation 패턴 정합 — pre-commit hook 자동 차단, 정확 문구 안 markdown 호환 표현 사용 (bold lead + 정확 인용 부호 + 정확 cross-ref link 형식)"
    }
  ]
}
```

## narrative

본 RESEARCH 는 **조사 (external / codebase / options / risks_identified)** 책임만 — 결정 (decisions) 은 Stage D DESIGN 으로 미룸 (v2.0 word-책임 1:1 정합).

`external` 6건 — v3.20 L4 (1차 source) + v3.18 DESIGN (a 발현) + v3.20 DESIGN (a 두 번째 발현) + ARCHITECTURE § 4 line 119 (b 결과물) + v3.20 VERIFY (c grep 검증) + v3.10 부산물 정책 정합.

`options` 4건 — § 4 끝 / § 4.1 Bundling / § 6.2 Lightweight / § 6.3 sub-section 신설. 각 pros/cons 사실 진술 raw 분석. 채택 결정은 DESIGN D1 위임.

`untouched_files_explicit` 6건 — harness-meta.md / CLAUDE.md root / projects/meta/CLAUDE.md / tests / CHANGELOG / AGENTS+README+GUARDRAILS. 모두 사실 진술 (v3.10 정합) — 후속 milestone 발의 명령형 없음.

`risks_identified` 6건 — R1 host narrowing / R2 narrative cohesive / R3 단일 source 위배 / R4 lightweight 5 관점 / R5 자기참조 모순 / R6 markdownlint trap.

## 도그푸드 정합

본 milestone 자체가 **3단계 패턴 자기 적용** — 본 RESEARCH 안 evidence 6건 + 4 options 분석 후 DESIGN D2 정확 문구 1차 source 작성 + EXECUTE Edit 그대로 삽입 + VERIFY grep 검증. 자기참조 cycle 자체로 3 cycle 누적 완성 (v3.18 + v3.20 + 본 milestone = 3 cycle 정전화 권장 trigger 충족).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- v3.20 L4 1차 source: [`../v3.20/REPORT.md`](../v3.20/REPORT.md) (L4 lesson)
- v3.18 패턴 1차 발현: [`../v3.18/DESIGN.md`](../v3.18/DESIGN.md) (## Phase 1 정확 narrative 정문구 섹션)
- v3.20 패턴 두 번째 발현: [`../v3.20/DESIGN.md`](../v3.20/DESIGN.md) (## Phase 1 정확 narrative 정문구 섹션)
- ARCHITECTURE.md (host 후보): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 4 / § 4.1 / § 6.2 / § 6.3 신설
- v3.10 부산물 정책: [`../v3.10/DESIGN.md`](../v3.10/DESIGN.md)
- § 6.2 lightweight 모드 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2

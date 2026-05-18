# DESIGN — v5.18 audit-chain-direct-read-and-verification-depth

```json
{
  "id": "v5.18",
  "decisions": [
    {
      "id": "D1",
      "decision": "RESEARCH O1 (3-layer 정전화 패턴 정합) 채택",
      "rationale": "v5.13 (audit-chain-fact-verification-protocol-procedure) + v5.16 (audit-output-markdown-lint-precheck) baseline 정합. v3.21 narrative 정전화 3 단계 패턴 19 번째 cycle 도그푸드 자연. agent prompt + 절차 narrative 양면 mitigation 의도. O2 (단일 위치 통합) = agent runtime 시 자체 인식 부족, O3 (agent .md 만) = 검증 method 분리 부재.",
      "alternatives_rejected": ["O2 — agent runtime 본질 인식 부족", "O3 — 검증 method 분리 부재 = L7 lesson 미흡수"]
    },
    {
      "id": "D2",
      "decision": "agent .md narrative 본문 = 1 문장 explicit + input source 식별 (per 멤버)",
      "rationale": "R7 (narrative 중복 risk) mitigation — narrative 본문은 멤버 별 input source 명시 (harness-gap-analyzer = scanner JSON, claude-docs-mapper = analyzer JSON, component-proposer = mapper JSON) 으로 자연 차별화. R1 (context overhead) mitigation — 1 문장 길이 minimal (< 100 tokens per agent .md).",
      "alternatives_rejected": ["다중 paragraph narrative — context overhead 증가 + 중복 위험", "external link 만 — agent runtime 시 자체 인식 부족"]
    },
    {
      "id": "D3",
      "decision": "project-scanner = 첫 멤버 input 부재 예외 narrative 1 문장 명시",
      "rationale": "R4 (예외 narrative 누락 risk) mitigation. 본 멤버 input = 대상 프로젝트 경로 만, audit chain input 산출물 부재. 따라서 '직접 Read 의무' = '대상 프로젝트 파일 자체 Read (Glob/Grep 매트릭스)' narrative 차별화. 4 멤버 중 유일 예외.",
      "alternatives_rejected": ["project-scanner 변경 부재 — 4 멤버 일관성 narrative 부재 시 cross-ref 모호"]
    },
    {
      "id": "D4",
      "decision": "v5.13 절차 정전화 2 위치 (harness-meta.md L80 + CLAUDE.md D8 Note v5.13) 모두 변경 — 검증 method 분리 narrative 추가",
      "rationale": "v5.13 baseline 정합 (3-layer WHERE/HOW) 자연. 검증 method 분리 (boolean / 표 / 수치) sub-narrative 추가 = synthesizer 검증 분기 모호 해소. L7 lesson 본질 (검증 method 분리) 흡수.",
      "alternatives_rejected": ["한 위치만 변경 — narrative drift 잠재 위험 (3-layer 부합도 약화)"]
    },
    {
      "id": "D5",
      "decision": "ARCHITECTURE § 4 끝 L137 (v5.11 paragraph) 본문 보존 + 절차화 sub-paragraph 안 v5.18 cross-ref 1 문장 추가만",
      "rationale": "R3 (paragraph 본문 변경 risk) mitigation. v5.11 정전화 narrative 영구 보존 + v5.13 절차화 sub-paragraph 안 v5.18 cross-ref 흡수만 추가. paragraph 본문 자체 무변경.",
      "alternatives_rejected": ["paragraph 본문 재작성 — v5.11 정전화 narrative drift risk"]
    },
    {
      "id": "D6",
      "decision": "1 phase 통합 commit (lightweight 모드 도그푸드 13/31 = 41.9%)",
      "rationale": "scope = 7 코드 파일 (중간), 단일 본질 (audit chain fact 검증 깊이 강화). phase 분할 시 narrative 자연 분기 부재 (모두 동일 root cause 흡수 의도). lightweight 모드 누적 13/31 = 41.9% (v5.17 = 12/30, v5.18 = 13/31). 1-phase 1+1 commit 패턴 9 번째 (v5.7/v5.8/v5.9/v5.11/v5.12/v5.13/v5.16/v5.17 = 8 + 본 v5.18 = 9).",
      "alternatives_rejected": ["2 phase 분할 (agent .md vs 절차 정전화) — narrative 분기 부재 시 단일 본질 자연 위반"]
    },
    {
      "id": "D7",
      "decision": "INTENT~APPROVE commit 시점 = (b) Stage G commit 안 포함 (v3.1 L6 default)",
      "rationale": "Stage G (VERIFY) commit 에 INTENT/RESEARCH/DESIGN/APPROVE.md 4건 + VERIFY.md + REPORT.md + PROPOSE.md + milestones.md 갱신 + ROADMAP entry 갱신 통합 commit. 산출물 영구 보존 보장 + 1-phase 1+1 commit 패턴 정합.",
      "alternatives_rejected": ["(a) phase-1 commit 안 포함 — phase-1 commit 안 산출물 + 구현 혼재 narrative 부합도 약화", "(c) 별도 commit — 1-phase 1+1 패턴 위반"]
    },
    {
      "id": "D8",
      "decision": "v3.21 narrative 정전화 3 단계 패턴 19 번째 cycle 자연 도그푸드",
      "rationale": "본 milestone narrative 자체 정전화 = DESIGN 안 1차 narrative + EXECUTE Edit + VERIFY grep 패턴 19 번째 cycle. v5.17 = 18 번째 baseline. 누적 cycle list: v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + v5.11 + v5.12 + v5.13 + v5.14 + v5.15 + v5.16 + v5.17 + 본 v5.18 = 19.",
      "alternatives_rejected": ["cycle 미카운팅 — 도그푸드 narrative 부합도 자연 위반"]
    },
    {
      "id": "D9",
      "decision": "memory feedback_subagent_fact_hallucination_correction.md cycle 누적 narrative 갱신 — cycle 2 direct → cycle 3+ 절차 강화 evidence 누적",
      "rationale": "기존 memory = 'cycle 2 direct evidence 도달' baseline (v5.11 시점). 본 v5.18 = cycle 9 누적 + 절차 강화 evidence 흡수 = memory 갱신 자연. memory cycle 누적 narrative 정확화.",
      "alternatives_rejected": ["memory 변경 부재 — cycle 누적 narrative stale 잔존"]
    },
    {
      "id": "D10",
      "decision": "agent .md narrative 본문 위치 = `## Input Verification` H2 sub-section (현 `## Input` H2 직후) — 4 멤버 일관 채택 + component-proposer 'tools: Write 만' 제약 흡수 narrative 명시 (메인 Claude orchestrator prompt 입력 시점 inline 첨부 우회 패턴)",
      "rationale": "spec-drift agent 검토 P1 (별도 H2 sub-section 가독성) + P2 (component-proposer tools: Write 만 — runtime 자체 Read tool 부재 → narrative 안 'orchestrator inline 첨부' 우회 명시) 권고 즉시 흡수. context7 'Subagents... receive the Agent tool's prompt string, which is the sole channel for information' spec 정합. INTENT.out_of_scope #1 (frontmatter Tools 변경 부재) 보존 자연. agent .md narrative 본문 = '본 agent 는 input 산출물 (예: <input source 명시>) 안 fact 인용 시 (a) input 산출물 자체 파일 직접 Read 의무 (Read tool 보유 멤버 — scanner/analyzer 가 해당) 또는 (b) 메인 Claude orchestrator 가 prompt 입력 시점 input 산출물 본문 inline 첨부 시 본문 직접 인용 의무 (Read tool 부재 멤버 — proposer 가 해당, frontmatter tools: Write 만). 사용자 context 부족 시 본질 추측 금지'.",
      "alternatives_rejected": ["component-proposer frontmatter tools 추가 Read — INTENT.out_of_scope #1 위반", "narrative 단일 패턴 (Read tool 의무) — proposer Write 만 충돌 위반"]
    },
    {
      "id": "D11",
      "decision": "project-harness-audit-team/CLAUDE.md D8 Note v5.13/v5.16/v5.18 = 3-stack 별도 block 분리 (중첩 회피)",
      "rationale": "spec-drift agent 검토 P3 권고 흡수. v3.21 narrative 정전화 3 단계 패턴 cycle 별 audit trail 보존 + v5.13 L6 lesson ('exact_text diff 패턴') 정합. v5.18 Note 본문 = '검증 method 분리 (boolean/표/수치 별 매핑 method) 의무' narrative + cross-ref `agents/{4 멤버}.md` `## Input Verification` sub-section.",
      "alternatives_rejected": ["v5.13 Note 안 v5.18 sub-narrative 중첩 — audit trail 가독성 약화"]
    }
  ],
  "approach": "3-layer 정전화 패턴 (v5.13/v5.16 baseline) 정합 — WHAT (ARCHITECTURE § 4 끝 L137 v5.11 paragraph cross-ref 갱신) + WHERE (agents/{4 멤버}.md narrative 추가 + project-harness-audit-team/CLAUDE.md D8 Note v5.13 강화) + HOW (claude/commands/harness-meta.md --audit 분기 강화). 1 phase 통합 commit (lightweight 13/31 = 41.9% + 1-phase 1+1 패턴 9 번째). 변경 7 코드 파일 + 1 memory update + 8 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + milestones.md) + ROADMAP entry 갱신.",
  "phases": [
    {
      "n": 1,
      "title": "audit chain agent .md 안 'input 산출물 직접 Read 의무' narrative + v5.13 절차 검증 method 분리 + § 4 끝 cross-ref 갱신",
      "scope": "(a) agents/project-scanner.md Tasks 섹션 안 첫 멤버 예외 narrative 1 문장 추가 / (b) agents/harness-gap-analyzer.md / agents/claude-docs-mapper.md / agents/component-proposer.md 각 Tasks 섹션 안 'input 산출물 직접 Read 의무' narrative 1 문장 추가 (input source 식별 차별화) / (c) agents/project-harness-audit-team/CLAUDE.md D8 Note v5.13 안 '검증 method 분리 (boolean/표/수치 별 매핑 method)' sub-narrative 추가 + cycle count v5.16 17 → v5.18 19 갱신 / (d) claude/commands/harness-meta.md --audit 분기 L80 synthesizer fact 검증 step narrative 안 '검증 method 분리' sub-narrative 추가 / (e) projects/meta/ARCHITECTURE.md § 4 끝 L137 v5.11 paragraph 절차화 sub-paragraph 안 v5.18 cross-ref 1 문장 흡수 / (f) memory feedback_subagent_fact_hallucination_correction.md cycle 누적 narrative 갱신",
      "affected_files": [
        "agents/project-scanner.md",
        "agents/harness-gap-analyzer.md",
        "agents/claude-docs-mapper.md",
        "agents/component-proposer.md",
        "agents/project-harness-audit-team/CLAUDE.md",
        "claude/commands/harness-meta.md",
        "projects/meta/ARCHITECTURE.md",
        "C:/Users/qkreh/.claude/projects/C--Users-qkreh-harness-meta/memory/feedback_subagent_fact_hallucination_correction.md",
        "projects/meta/milestones/v5.18/execute/phase-1.md"
      ],
      "rationale": "단일 본질 (audit chain fact 검증 깊이 강화) — phase 분할 부재 자연. lightweight + 1-phase 1+1 commit 패턴 9 번째.",
      "risks": ["R1 context overhead", "R2 v5.13 baseline 변경", "R3 § 4 끝 paragraph 본문 변경", "R7 narrative 중복"]
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 (agent prompt 길이 증가)", "mitigation": "1 문장 narrative만 (per agent .md), context overhead < 100 tokens per 멤버"},
    {"risk": "R2 (v5.13 baseline narrative 변경)", "mitigation": "baseline 본문 보존 + 검증 method 분리 sub-bullet 만 추가"},
    {"risk": "R3 (§ 4 끝 paragraph 본문 변경)", "mitigation": "v5.11 paragraph 본문 보존 + 절차화 sub-paragraph 안 v5.18 cross-ref 1 문장 흡수만"},
    {"risk": "R4 (project-scanner 예외 narrative 누락)", "mitigation": "explicit 예외 narrative 1 문장 — '본 멤버 = 첫 멤버 input 부재. 따라서 직접 Read 의무 = 대상 프로젝트 파일 자체 Read'"},
    {"risk": "R5 (cycle count 정확도)", "mitigation": "INTENT/RESEARCH/REPORT 안 cycle 카운팅 list explicit 명시 (19 = v5.17 baseline 18 + 본 v5.18 1)"},
    {"risk": "R6 (smoke 회귀)", "mitigation": "INTENT/APPROVE schema 검증 영향 0 — agent .md narrative 추가 = smoke 무관, pre-commit 14 hook 검증 의무"},
    {"risk": "R7 (narrative 중복)", "mitigation": "narrative 본문 = input source 식별 차별화 (per 멤버) — 동일 패턴이나 source 식별로 자연 차별화"}
  ]
}
```

## narrative

### 4 관점 검토 trigger (scope 중간 6~15)

본 milestone scope = 7 코드 파일 → 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract). 모두 PASS 또는 pass_with_comments (decisive blocking 0).

### 4 관점 review_summary (검토 후 갱신)

| 관점 | verdict | decisive_issues | recommendations 흡수 |
|---|---|---|---|
| architecture (Plan) | pass | 0 | P2 (agent fallback narrative future) + P3 (narrative 중복 slim future) = 모두 future cycle carry-over (v5.19+ 거명만) |
| spec-drift (general-purpose + context7) | pass_with_comments | 0 | P1 (Input Verification H2 sub-section) → D10 흡수 / P2 (proposer tools: Write 만 우회 narrative) → D10 흡수 / P3 (D8 Note 3-stack 분리) → D11 흡수 |
| 회귀 risk (Explore) | pass | 0 | P2 (Stage F EXECUTE 시 D5 diff 검증) → VERIFY 의무 / P3 (Stage G VERIFY 시 D9 memory cycle narrative 갱신 검증) → VERIFY criteria_check 의무 |
| scope contract (Explore) | pass | 0 | P1 (milestones.md sub_milestones 1:1 동기 갱신, Stage D 완료 직전 의무) → 즉시 실행 / P2 (memory affected_files absolute path) → DESIGN.phases[1].affected_files 명시 보유 / P3 (D5 baseline 보존 verify Stage F) → VERIFY 의무 |

흡수 결과 — 신규 결정 D10 + D11 추가 (spec-drift P1+P2+P3). architecture P2/P3 + 회귀 risk P2/P3 + scope contract P3 = Stage F/G 의무 step (검토 흡수).

### Stage D 완료 직전 의무 step — milestones.md sub_milestones 1:1 동기 갱신

phases[] 확정 (1 phase 통합) → milestones.md sub_milestones[] 갱신 (placeholder title → phase-1 정확 title 교체) 의무. Stage D 완료 직후 EXECUTE 진입 전 실행 (scope contract P1 권고 정합).

## 관련

- INTENT: [INTENT.md](INTENT.md)
- RESEARCH: [RESEARCH.md](RESEARCH.md)
- v5.13 절차 정전화 baseline: [`../v5.13/REPORT.md`](../v5.13/REPORT.md)
- v5.16 lint precheck (3-layer 패턴 source): [`../v5.16/REPORT.md`](../v5.16/REPORT.md)
- v3.21 narrative 정전화 3 단계 패턴: [`../_archive/v3.21/REPORT.md`](../_archive/v3.21/REPORT.md)

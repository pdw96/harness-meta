---
id: v5.18
title: RESEARCH v5.18
version: v5.18
stage: RESEARCH
status: completed
---

# RESEARCH — v5.18 audit-chain-direct-read-and-verification-depth

## Spec

```json
{
  "external": [
    {
      "source": "v5.10 ~ v5.17 milestone REPORT.md L1/L7 lesson trace",
      "topic": "audit chain hallucination 누적 cycle + 정량 evidence",
      "findings": "cycle 1 (v5.10 component-proposer 12 항목) + cycle 2 (v5.11 project-scanner claude_md_in_repo: false) + cycle 3 (v5.12 mapper bundled skill misclassification) + cycle 4 (v5.14 mapper) + cycle 5 (v5.15 cycle 4 detect) + cycle 6 (v5.15 cycle 4 proposer) + cycle 7 (v5.17 mapper Fleet S1/S3/S4) + cycle 8 (v5.17 mapper) + cycle 9 (v5.17 proposer Fleet 현황) = 누적 9 cycle. cycle 7+8+9 = 8건 정량 evidence (v5.17 L7 N=3 통계 시작). cycle 8+9 root cause 명시 = 'agent prompt 안 input 산출물 직접 Read 의무 부재 + 사용자 context 부족 시 본질 추측' (v5.17 L1 lesson 원문).",
      "drift": "v5.13 정전화 (3-layer 구조 WHAT § 4 끝 + WHERE D8 Note + HOW --audit step) 후에도 cycle 7~9 8건 발생 = 절차 깊이 부족 evidence. 'synthesizer 직접 매핑 검증' 의무 명시 (v5.13) 만으로는 hallucination 발생 자체 차단 부재 — agent runtime 시 input 직접 Read 부재 = synthesizer 검증 부담 누적 + 검증 method 분기 모호 (boolean / 표 / 수치 별 매핑 method 부재)."
    },
    {
      "source": "v5.7 spec-drift-spike-pattern-canonicalization + v5.13 audit-chain-fact-verification-protocol-procedure",
      "topic": "정전화 3-layer 패턴 source",
      "findings": "v5.13 정전화 안 3-layer 구조 (WHAT § 4 끝 paragraph + WHERE D8 Note + HOW --audit step) 가 baseline. v5.16 (lint precheck) = 동일 3-layer 패턴 정합 + 신규 정전화 (4 cycle 누적). 본 v5.18 = 동일 3-layer 패턴 정합 (WHAT § 4 끝 + WHERE D8 + agent .md / HOW --audit step).",
      "drift": "본 v5.18 변경은 v5.13 baseline narrative 본문 본격 재작성 부재 — 'agent .md 안 Read 의무 추가' + '검증 method 분리 (boolean/표/수치) sub-bullet 추가' 만. v5.11 paragraph (§ 4 끝) 본문 보존 + cross-ref 갱신만."
    },
    {
      "source": "v3.21 narrative-canonicalization-3step-pattern",
      "topic": "narrative 정전화 3 단계 패턴 누적 cycle count",
      "findings": "v3.18 (cycle 1) + v3.20 (cycle 2) + v3.21 (cycle 3) + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + v5.11 + v5.12 + v5.13 + v5.14 + v5.15 + v5.16 + v5.17 = 누적 18 cycle. 본 v5.18 = 19 cycle.",
      "drift": "도그푸드 (DESIGN 1차 + EXECUTE Edit + VERIFY grep) 패턴 — 본 milestone 자체가 정전화 cycle 19 번째 도그푸드 적용."
    }
  ],
  "codebase": {
    "affected_files": [
      "agents/project-scanner.md (Tasks 섹션 안 input 부재 예외 narrative — 첫 멤버 input = 대상 프로젝트 경로 만)",
      "agents/harness-gap-analyzer.md (Tasks 섹션 안 'input 산출물 (project-scanner JSON) 직접 Read 의무' narrative 추가)",
      "agents/claude-docs-mapper.md (Tasks 섹션 안 'input 산출물 (harness-gap-analyzer JSON) 직접 Read 의무' narrative 추가)",
      "agents/component-proposer.md (Tasks 섹션 안 'input 산출물 (claude-docs-mapper JSON) 직접 Read 의무' narrative 추가)",
      "agents/project-harness-audit-team/CLAUDE.md (D8 Note v5.13 안 '검증 method 분리 (boolean/표/수치 별 매핑 method)' sub-narrative 추가 + cycle count v5.16 17 → v5.18 19 갱신)",
      "claude/commands/harness-meta.md (--audit 분기 L80 synthesizer fact 검증 step narrative 안 '검증 method 분리 (boolean/표/수치 별 매핑 method)' sub-narrative 추가)",
      "projects/meta/ARCHITECTURE.md § 4 끝 L137 (v5.11 Audit chain fact 인용 검증 의무 paragraph) cross-ref 갱신 — agents/{4 멤버}.md 안 'input 산출물 직접 Read 의무' 추가 narrative 흡수 + 검증 method 분리 narrative 흡수)"
    ],
    "untouched_files_explicit": [
      "agents/component-installer.md — D8 Step 5 (apply scope, audit chain read-only Step 1~4 외)",
      "agents/agents-md-sync.md — audit chain 무관",
      "agents/environment-auditor.md — audit chain 무관 (별 audit type)",
      "agent frontmatter Tools 필드 (4 멤버) — v5.17 PROPOSE #8 본질 (tool permission 강화, 다른 변경 축 = INTENT.out_of_scope #1 사실 진술)",
      "agents/project-harness-audit-team/CLAUDE.md D8 sequence 본문 (코드블록) — narrative 추가만, sequence step 1~5 자체 structural 변경 부재 (INTENT.out_of_scope #6 사실 진술)",
      "ARCHITECTURE.md § 4 끝 L139 (v5.16 Agent 산출 markdown lint precheck 의무 paragraph) — 본 v5.18 무관 변경 (별 정전화 cycle)"
    ],
    "current_state": {
      "agents/{4 멤버}.md Tasks 섹션": "input 명시 paragraph 보유 (예: harness-gap-analyzer 'Input: project-scanner 의 메타데이터 JSON'). 그러나 'input 산출물 직접 Read 의무' narrative 부재 — agent runtime 시 메인 Claude orchestrator 가 prompt 안 input 산출물 텍스트 inline 인용 시 agent 가 자체 Read 부재로 본질 추측 가능.",
      "v5.13 절차 정전화 2 위치 (harness-meta.md L80 + CLAUDE.md D8 Note v5.13)": "'synthesizer 직접 매핑 검증' 의무 narrative 보유. 그러나 검증 method 분리 (boolean / 표 / 수치 별 매핑 method) sub-narrative 부재 — synthesizer 검증 시 분기 모호.",
      "ARCHITECTURE.md § 4 끝 L137 (v5.11 정전화)": "audit chain 4 멤버 fact 인용 검증 의무 paragraph 보유 (evidence cycle 2 도달). cross-ref = harness-meta.md L80 + CLAUDE.md D8 Note. 본 v5.18 변경 후 cross-ref + 검증 method 분리 narrative 흡수 의무."
    },
    "target_state": {
      "agents/{harness-gap-analyzer/claude-docs-mapper/component-proposer}.md Tasks 섹션": "'## Input Verification' 또는 동치 sub-section 추가 — 'input 산출물 (예: harness-gap-analyzer 의 경우 project-scanner JSON) 안 fact 인용 시 agent 가 input 텍스트 직접 Read 의무 (메인 Claude orchestrator 가 prompt 안 inline 인용한 fact 가 partial 또는 추측 가능, agent 가 input 산출물 파일 (예: scanner-output.md) 직접 Read 으로 검증)' 1 문장 narrative 추가.",
      "agents/project-scanner.md": "첫 멤버 input 부재 예외 narrative 추가 — '본 멤버는 첫 멤버 = input 산출물 부재 (input = 대상 프로젝트 경로 만). 따라서 직접 Read 의무 = 대상 프로젝트 파일 자체 Read (Glob/Grep 매트릭스 기반)' 1 문장 narrative.",
      "v5.13 절차 정전화 2 위치 (harness-meta.md L80 + CLAUDE.md D8 Note v5.13)": "'검증 method 분리' sub-narrative 추가 — 'fact 종류 별 매핑 method: (i) boolean = 파일 존재 여부 (`ls` 또는 Glob 1건 확인), (ii) 표 = 표 안 각 row 1차 source 매핑 grep, (iii) 수치 = 1차 source 직접 카운팅 (wc -l 또는 Grep -c)' 1 문장 narrative 추가.",
      "ARCHITECTURE.md § 4 끝 L137 (v5.11 paragraph)": "paragraph 본문 보존 + 절차화 (v5.13) sub-paragraph 안 'v5.18: agents/{4 멤버}.md 안 input 산출물 직접 Read 의무 narrative 추가 + 검증 method 분리 (boolean/표/수치 별 매핑 method) narrative 추가' cross-ref 1 문장 흡수."
    }
  },
  "options": [
    {
      "name": "O1 — 3-layer 정전화 패턴 정합 (recommended)",
      "scope": "agents/{4 멤버}.md narrative 추가 + project-harness-audit-team/CLAUDE.md D8 Note 강화 + harness-meta.md --audit 분기 강화 + ARCHITECTURE § 4 끝 cross-ref 갱신",
      "pros": [
        "v5.13/v5.16 3-layer 정전화 패턴 정합 자연 — v3.21 19 번째 cycle 도그푸드",
        "agent prompt 안 의무 + 절차 narrative 강화 동시 = 양면 mitigation",
        "synthesizer + agent 양쪽 책임 명확화"
      ],
      "cons": [
        "변경 위치 7 = 중간 scope (6~15)",
        "narrative 중복 risk (4 멤버 agent .md 안 동일 1 문장 패턴)"
      ]
    },
    {
      "name": "O2 — project-harness-audit-team/CLAUDE.md 한 곳 통합",
      "scope": "CLAUDE.md D8 안 통합 narrative + 4 agent .md 변경 부재",
      "pros": [
        "단일 narrative 위치 — 중복 0",
        "변경 위치 1 = 최소 scope"
      ],
      "cons": [
        "agent runtime 시 자체 인식 부족 — agent prompt 안 의무 부재 = orchestration narrative 의존만, agent 본질 변경 부재",
        "L1 lesson 본질 (agent prompt 안 Read 의무 명시) 미흡수"
      ]
    },
    {
      "name": "O3 — agent .md 만 변경",
      "scope": "4 agent .md narrative 추가 + 절차 정전화 변경 부재",
      "pros": [
        "agent prompt 안 의무 명확화 — L1 lesson 본질 흡수"
      ],
      "cons": [
        "절차 정전화 (v5.13 baseline) 변경 부재 = synthesizer 검증 method 분리 narrative 부재",
        "L7 lesson 본질 (검증 method 분리) 미흡수"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "name": "agent prompt 길이 증가 → context overhead",
      "likelihood": "low",
      "impact": "low",
      "mitigation": "1 문장 narrative 만 추가 (per agent .md), 길이 minimal. agent runtime 시 prompt 안 추가 context overhead < 100 tokens."
    },
    {
      "id": "R2",
      "name": "v5.13 baseline narrative 변경 risk",
      "likelihood": "low",
      "impact": "medium",
      "mitigation": "v5.13 baseline narrative 본문 보존 + 검증 method 분리 sub-bullet 만 추가. inline addition (paragraph 추가 부재, paragraph 안 sub-narrative)."
    },
    {
      "id": "R3",
      "name": "ARCHITECTURE § 4 끝 paragraph 본문 변경 risk",
      "likelihood": "low",
      "impact": "medium",
      "mitigation": "v5.11 paragraph 본문 보존. 절차화 (v5.13) 1 문장 sub-paragraph 안 v5.18 cross-ref 1 문장 추가만. paragraph 본문 자체 무변경."
    },
    {
      "id": "R4",
      "name": "project-scanner 첫 멤버 예외 narrative 누락 risk",
      "likelihood": "medium",
      "impact": "low",
      "mitigation": "explicit 예외 narrative 1 문장 추가 — '본 멤버 = 첫 멤버 = input 산출물 부재. 따라서 직접 Read 의무 = 대상 프로젝트 파일 자체 Read'."
    },
    {
      "id": "R5",
      "name": "도그푸드 cycle count 정확도 (v3.21 19 번째 cycle)",
      "likelihood": "low",
      "impact": "low",
      "mitigation": "INTENT/RESEARCH/REPORT 안 cycle 카운팅 list explicit 명시 (v3.18 + v3.20 + v3.21 + ... + v5.17 + 본 v5.18 = 19). v5.17 = 18 baseline."
    },
    {
      "id": "R6",
      "name": "smoke-spec-verification 회귀 risk",
      "likelihood": "low",
      "impact": "low",
      "mitigation": "INTENT/APPROVE schema 검증 영향 0 — agent .md narrative 추가 = smoke 무관. memory feedback_intent_md_schema_required.md 정합 (id + title 필드 보유 검증)."
    },
    {
      "id": "R7",
      "name": "narrative 중복 위치 (4 멤버 agent .md 안 동일 1 문장 패턴)",
      "likelihood": "medium",
      "impact": "low",
      "mitigation": "narrative 본문은 멤버 별 input source 명시 (예: harness-gap-analyzer = project-scanner JSON, claude-docs-mapper = harness-gap-analyzer JSON) — 동일 패턴이나 source 식별로 자연 차별화."
    }
  ]
}
```

## narrative

### v5.13 절차 깊이 부족 evidence cycle 7~9 8건

v5.13 (2026-05-18 정전화) 후 cycle 7+8+9 (v5.17 audit) = 8건 hallucination 누적. 본 8건 모두 동일 root cause = 'agent prompt 안 input 산출물 직접 Read 의무 부재 + 사용자 context 부족 시 본질 추측' (v5.17 L1 lesson 원문). v5.13 정전화 안 'synthesizer 직접 매핑 검증' 의무는 명시되어 있으나 'agent 자체 input 직접 Read 의무' 부재 + '검증 method 분리 (boolean/표/수치) 명시' 부재 — 양 측면 보완 의도.

### 3-layer 정전화 패턴 (v5.13/v5.16 baseline 정합)

| Layer | 변경 위치 | 본 v5.18 변경 |
|---|---|---|
| WHAT (정의) | `projects/meta/ARCHITECTURE.md` § 4 끝 L137 'Audit chain fact 인용 검증 의무' paragraph (v5.11) | 절차화 sub-paragraph 안 v5.18 cross-ref 1 문장 추가 (agent .md 안 Read 의무 + 검증 method 분리 narrative 흡수) |
| WHERE (orchestration) | `agents/project-harness-audit-team/CLAUDE.md` D8 Note v5.13 + `agents/{4 멤버}.md` Tasks 섹션 | (a) D8 Note v5.13 안 '검증 method 분리' sub-narrative 추가 + (b) 4 멤버 agent .md 안 'input 산출물 직접 Read 의무' narrative 추가 |
| HOW (workflow) | `claude/commands/harness-meta.md` `--audit` 분기 L80 synthesizer fact 검증 step | step narrative 안 '검증 method 분리' sub-narrative 추가 |

## 관련

- INTENT: [INTENT.md](INTENT.md)
- v5.17 PROPOSE (origin): [`../v5.17/PROPOSE.md`](../v5.17/PROPOSE.md) #1 + #4
- v5.13 절차 정전화 baseline: [`../v5.13/REPORT.md`](../v5.13/REPORT.md)
- v5.16 lint precheck 정전화 (3-layer 패턴 source): [`../v5.16/REPORT.md`](../v5.16/REPORT.md)
- v3.21 narrative 정전화 3 단계 패턴: [`../_archive/v3.21/REPORT.md`](../_archive/v3.21/REPORT.md)

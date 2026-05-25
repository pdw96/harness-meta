---
id: v5.20
title: RESEARCH v5.20
version: v5.20
stage: RESEARCH
status: completed
---

# RESEARCH — v5.20 external-audit-team-cycle-7-stability-canonicalization

## Spec

```json
{
  "external": [
    {
      "source": "projects/upbit/audit-2026-05-19-cycle6/diff-vs-cycle5.md",
      "topic": "cycle 5 → cycle 6 stability cycle 첫 완성 evidence (baseline source for cycle 7 diff)",
      "findings": [
        "upbit 최신 commit = 5aeed93 (v1.20 chore Stage B-I artifacts) — cycle 5+6 동일 baseline",
        "R1 (CLAUDE.md L124~L125, hooks + mcpServers narrative) = 2 cycle 연속 APPLIED",
        "R2 (CLAUDE.md L37, pre-commit hooks v1.12) = 2 cycle 연속 APPLIED",
        "신규 gap = 0건 (cycle 5+6 동일)",
        "F4 SPIKE = cycle 6 사용자 결정 Accept (a) /usage built-in 우선 (P3 보류, mechanical apply 없음)",
        "hallucination cycle 6 = 0건 (cycle 5 = 8건, v5.18 narrative 첫 실전 효과)",
        "untracked 2건 (v1.16 PROPOSE/REPORT) — v5.19 L7 신규 발견 (audit value 부수)",
        "lint precheck 두 번째 실전 = MD022/MD031/MD032 12 cell PASS + MD034 11건 inline 정정 (mapper-output.md)"
      ],
      "drift": "cycle 7 baseline 예상 — upbit commit 부재 (v5.19 baseline 이후 0 commit 직접 확인, git -C $HOME/upbit log) = cycle 7 = cycle 5+6과 동일 v1.20 baseline. R1+R2 3 cycle 연속 APPLIED 예상. 신규 gap 0건 예상. hallucination cycle 7 = 0건 또는 재발 evidence 둘 다 가능 (narrative 효과 + stability 본질 혼합 origin)."
    },
    {
      "source": "ARCHITECTURE.md § 4 끝 paragraph (L129~L139)",
      "topic": "정전화 anchor 후보 위치 + 누적 paragraph 매트릭스 (v5.19 PROPOSE#8 carry-over '6건+ 매트릭스화 trigger')",
      "findings": [
        "L129: B/C/D 부산물 PROPOSE 흡수 책임 (v3.10)",
        "L131: Word-fidelity drift 수용 (v3.20)",
        "L133: ROADMAP 단어 drift 수용 (v5.9)",
        "L135: Narrative cascade drift 검증 의무 (v5.10) — vector count 6건 명시 (v1.17 + v5.10 + v5.14 + v5.15 + v5.17 + v5.19)",
        "L137: Audit chain fact 인용 검증 의무 (v5.11 + v5.18 보완)",
        "L139: Agent 산출 markdown lint precheck 의무 (v5.16)"
      ],
      "drift": "본 v5.20 정전화 추가 시 = 7건 누적 → v5.19 PROPOSE#8 trigger 조건 '§ 4 끝 paragraph 6건+ 누적' 자연 충족 (매트릭스화 candidate trigger). 단 매트릭스화 자체는 본 milestone scope 외 (단일 책임 = stability cycle pattern paragraph 정전화). 매트릭스화는 v5.21+ candidate."
    },
    {
      "source": "v5.19 PROPOSE.md (next_candidates#4)",
      "topic": "trigger origin — 'audit-cycle-stability-pattern-canonicalization-architecture'",
      "findings": [
        "rationale: 'audit-apply-audit 순환 stability pattern narrative ARCHITECTURE.md § 4 끝 paragraph 정전화 candidate'",
        "trigger_condition: '사용자 명시 발의 (A_user) ∧ cycle 7+ 추가 stability cycle 누적 (3 cycle 연속 stability)'",
        "decision (v5.19): '거명만 (ROADMAP 등재 zero)'",
        "v5.18 PROPOSE#3 carry-over (origin v5.17 PROPOSE#3 → v5.18#3 → v5.19#4)"
      ],
      "drift": "본 v5.20 = trigger 자연 충족 path (사용자 명시 발의 2026-05-19 + cycle 7 호출 = 3 cycle 연속 stability 누적 가능). 정전화 narrative 본문 작성 source = v5.19 cycle 6 stability 첫 완성 evidence + 본 v5.20 cycle 7 추가 stability evidence."
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ROADMAP.md (v5.20 entry — status: in_progress → completed)",
      "projects/meta/milestones/v5.20/milestones.md (sub_milestones[] 1:1 동기 갱신 — Stage D 후)",
      "projects/meta/milestones/v5.20/INTENT.md (작성 완료)",
      "projects/meta/milestones/v5.20/RESEARCH.md (본 파일)",
      "projects/meta/milestones/v5.20/DESIGN.md (Stage D)",
      "projects/meta/milestones/v5.20/APPROVE.md (Stage E)",
      "projects/meta/milestones/v5.20/execute/phase-1.md (Stage F phase-1 = audit-team 호출 + 산출물 5건)",
      "projects/meta/milestones/v5.20/execute/phase-2.md (Stage F phase-2 = ARCHITECTURE § 4 끝 stability cycle pattern paragraph 정전화 + § 4 L135 vector count 6→7 + self-loop 갱신)",
      "projects/meta/milestones/v5.20/VERIFY.md (Stage G)",
      "projects/meta/milestones/v5.20/REPORT.md (Stage H)",
      "projects/meta/milestones/v5.20/PROPOSE.md (Stage I)",
      "projects/upbit/audit-2026-05-19-cycle7/scanner-output.md (Stage F phase-1)",
      "projects/upbit/audit-2026-05-19-cycle7/analyzer-output.md (Stage F phase-1)",
      "projects/upbit/audit-2026-05-19-cycle7/mapper-output.md (Stage F phase-1)",
      "projects/upbit/audit-2026-05-19-cycle7/proposal-draft.md (Stage F phase-1)",
      "projects/upbit/audit-2026-05-19-cycle7/diff-vs-cycle6.md (Stage F phase-2)",
      "projects/meta/ARCHITECTURE.md (Stage F phase-2 — § 4 끝 stability cycle pattern paragraph 신규 + L135 vector count 갱신)",
      "CHANGELOG.md (Stage H — v5.20 entry)"
    ],
    "untouched_files_explicit": [
      "projects/meta/ARCHITECTURE.md § 3.1 끝 (baseline drift cleanup = v5.18 PROPOSE#5 carry-over, out_of_scope#4)",
      "agents/*.md (Input Verification narrative = v5.18 정전화 후 본 milestone 무변경)",
      "claude/commands/harness-meta.md (절차 narrative = v5.13/v5.16/v5.18 정전화 후 본 milestone 무변경)",
      "agents/project-harness-audit-team/CLAUDE.md (D8 sequence Note = v5.18 정전화 후 본 milestone 무변경)",
      "tests/ (smoke test 정의 = 본 milestone 변경 부재)"
    ],
    "current_state": "v5.19 cycle 6 stability 첫 완성 (cycle 5+6 baseline 동일, R1+R2 2 cycle 연속 APPLIED, 신규 gap 0건, hallucination 0건 = v5.18 narrative 첫 실전 효과). § 4 끝 stability cycle pattern paragraph 부재 — v5.19 PROPOSE#4 carry-over candidate.",
    "target_state": "cycle 7 호출 + stability 3 cycle 연속 (5+6+7 동일 baseline) evidence 정량 확보 + ARCHITECTURE § 4 끝 'audit-apply-audit stability cycle pattern' paragraph 정전화 + vector count 6→7 갱신 + self-loop 갱신."
  },
  "options": [
    {
      "id": "O1",
      "name": "1-phase 통합 (audit chain 호출 + 정전화 동시)",
      "pros": [
        "1 commit lightweight 모드 정합",
        "audit chain 산출물 + 정전화 narrative 안 동시 cross-ref 작성 효율"
      ],
      "cons": [
        "audit chain 호출 결과 (예: hallucination 재발 / stability break) 가 정전화 narrative 본문에 영향 시 commit 안 재작성 필요",
        "phase scope 큼 (4 agent 호출 + 산출물 5건 + ARCHITECTURE 갱신)"
      ]
    },
    {
      "id": "O2",
      "name": "2-phase 분리 (phase-1 audit chain 호출 + phase-2 정전화) — v5.19 패턴 정합",
      "pros": [
        "phase-1 결과 안정 확인 후 phase-2 정전화 = narrative 본문 정확화",
        "v5.19 cycle 6 2-phase 패턴 정합 (cycle 5+6 stability 본질 정합)",
        "각 phase scope 명확 (4 + 1)"
      ],
      "cons": [
        "2 commit (phase-1 + phase-2) = lightweight 1-phase 정책 약간 이탈 (v5.19도 동일)"
      ]
    },
    {
      "id": "O3",
      "name": "phase-1 audit chain 호출 + phase-2 정전화 + phase-3 chore (3-phase)",
      "pros": [
        "각 stage 산출물 분리 commit"
      ],
      "cons": [
        "3 commit 과다 — lightweight 정책 이탈 누적",
        "현 v5.x 패턴 (1+1 또는 2+1) 비대화"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "cycle 7 hallucination 재발 (cycle 5 8건 → cycle 6 0건 패턴 break 가능성) — v5.18 narrative 효과 단일 검증 evidence isolation 부재 baseline 동일",
      "severity": "medium",
      "mitigation": "v5.13 3-layer fact 검증 절차 다섯 번째 실전 적용 + inline 정정 audit trail 보존. 재발 evidence = cycle 8+ 추가 호출 candidate (out_of_scope 사실 진술)."
    },
    {
      "id": "R2",
      "risk": "stability 본질 evidence (동일 baseline 반복 호출 시 결과 동일) 가 검증 실패 — 예측 외 변동 (untracked 발견 / mapper delta 등) 발견 시 정전화 narrative 본문 수정 필요",
      "severity": "low",
      "mitigation": "phase-1 결과 확인 후 phase-2 정전화 = 2-phase 분리 (O2). v5.19 cycle 6 untracked 2건 신규 발견 사례 precedent — stability 본질 = audit chain 결과 vs harness apply 결과 분리 가능."
    },
    {
      "id": "R3",
      "risk": "MD028/MD034/MD038 lint 위반 재발 (v5.19 MD034 11건 cycle 6 발현) — hardcode 3 rule (MD022/MD031/MD032) 외 rule 추가 발현",
      "severity": "low",
      "mitigation": "lint precheck 세 번째 실전 + 발현 시 inline 정정. v5.19 PROPOSE#3 carry-over candidate (cycle 7+ 추가 발현 시 rule 확장 trigger 누적)."
    },
    {
      "id": "R4",
      "risk": "ARCHITECTURE § 4 끝 paragraph 6 → 7 누적 = v5.19 PROPOSE#8 (`§ 4 끝 6건+ 매트릭스화 trigger`) 자연 충족 → 매트릭스화 즉시 vs deferred 선택 필요",
      "severity": "low",
      "mitigation": "out_of_scope #4 정합 — 본 milestone 단일 책임 = stability cycle pattern paragraph 정전화. 매트릭스화는 v5.21+ candidate (out_of_scope 사실 진술 + PROPOSE.next_candidates 흡수)."
    },
    {
      "id": "R5",
      "risk": "vector count 6→7 갱신 시 L135 narrative 본문 cascade drift 위험 (v5.10 patterns 정합)",
      "severity": "low",
      "mitigation": "Edit 후 grep -c verify (v3.21 narrative 정전화 3 단계 패턴 c step). 본 v5.20 cascade drift origin 자체 = audit-team 호출 누적 정확 정량 (v1.17 + v5.10 + v5.14 + v5.15 + v5.17 + v5.19 + 본 v5.20 = 7건)."
    },
    {
      "id": "R6",
      "risk": "self-loop counting 모호 사례 — 본 milestone 자체 self-loop 카운팅 (외부 1건 추가 + self-loop 1건 추가 = 20/26 vs 19+1/25+1) 결정 필요",
      "severity": "low",
      "mitigation": "v5.19 baseline = 19/25 = 76%. 본 v5.20 = 외부 audit-team 호출 (vector 1건 추가) + self-loop 운용 (stability paragraph 정전화 도그푸드 = self-loop 1건 추가) → 20/26 ≈ 77%. 단일 source = ARCHITECTURE.md § 3.1 끝 또는 R2 baseline narrative (v5.18 PROPOSE#5 carry-over scope 외)."
    },
    {
      "id": "R7",
      "risk": "lightweight 모드 누적 15/33 = 45.5% (43.75% 직전 → 45% 첫 돌파 candidate) — 1-phase 정책 정합 vs 2-phase 분리 (O2 선택 시) 비대화 risk",
      "severity": "low",
      "mitigation": "2-phase 분리 + lightweight 모드 정합 (v5.19 cycle 6 정합 = 2-phase 2 commit). 1-phase 강행 시 lightweight 강 정합이나 phase scope 비대화 risk 높음."
    }
  ]
}
```

## narrative

### 결정 (decisions) 보류 — DESIGN.md 안 통합

본 RESEARCH 안 raw 분석만. 옵션 O1/O2/O3 + risks_identified R1~R7 매핑 → DESIGN.decisions 안 흡수.

### v3.10 부산물 정책 정합

`codebase.untouched_files_explicit` 5건 + `risks_identified` 7건 = 모두 (a) 사실 진술 (영향 부재 파일 / 식별 risk). (b) 후속 milestone 명명 표현 부재 — 명명 + ROADMAP 등재는 PROPOSE 단일 책임.

## 관련

- INTENT: [INTENT.md](INTENT.md)
- 직전 cycle 6 baseline: `projects/upbit/audit-2026-05-19-cycle6/diff-vs-cycle5.md`
- ARCHITECTURE § 4 끝 paragraph 현 상태: `projects/meta/ARCHITECTURE.md` L129~L139
- v5.19 PROPOSE#4 trigger origin: `../v5.19/PROPOSE.md`

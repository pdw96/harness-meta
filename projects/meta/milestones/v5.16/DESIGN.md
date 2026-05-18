# DESIGN — v5.16 audit-output-markdown-lint-precheck

```json
{
  "id": "v5.16",
  "decisions": [
    {
      "decision": "D1: O1 (3-layer narrative 정전화) 채택 — 자동 fix 도구 도입 부재",
      "rationale": "v5.13 정전화 3-layer cross-ref 구조 패턴 정합. 사용자 결정 Q1 Recommended 직접 수용. 자동 fix 도구 도입 (O2) = 도구 dependency / scope 확대 — evidence (2 사례 누적) 약함, defer 정합. 하이브리드 (O3) = scope 2 파트 lightweight 위배. defer (O4) = trigger_condition 정합 안 함.",
      "alternatives_rejected": ["O2 (자동 fix 도구)", "O3 (하이브리드)", "O4 (defer)"]
    },
    {
      "decision": "D2: ARCHITECTURE.md § 4 끝 'Agent 산출 markdown lint precheck 의무' paragraph 정전화 (Layer A WHAT) — 정확 exact_text 1차 source",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 1차 source = DESIGN.D2.exact_text. Layer A WHAT 정의 책임. v5.11 'Audit chain fact 인용 검증 의무' paragraph 직후 자연 위치 — fact 검증 (의미 검증) 과 lint precheck (구조 검증) 직교 (두 검증 단계). R1 흡수 결정 = § 4 끝 유지 (§ 6 분리 거부, '검증 의무' 단일 책임 군집).",
      "alternatives_rejected": ["§ 6 본문 직접 추가 (R1, spec-drift 패턴과 군집 불일치)", "별 § 신설 (scope 확대)"],
      "exact_text": "**Agent 산출 markdown lint precheck 의무** (v5.16_audit-output-markdown-lint-precheck 정전화): audit chain 산출물 산출 4 멤버 (`project-scanner` / `harness-gap-analyzer` / `claude-docs-mapper` / `component-proposer` — D8 Step 1~4, installer Step 5 제외) markdown 산출물을 repo 안 저장 시 markdownlint MD022 (blanks-around-headings) / MD031 (blanks-around-fences) / MD032 (blanks-around-lists) 3 rule 위반이 자동 발생하는 패턴 evidence cycle 2 도달 — (1) v5.14 L7 origin (cycle 3 audit 3건 발생) + (2) v5.15 L5 재현 (cycle 4 audit 8건 발생). 검증 운용 의무 — (a) agent 산출 직후 synthesizer (메인 Claude orchestrator) 가 markdown 본문 안 heading / fenced code block / list 직전·직후 blank line 1 줄 존재 패턴 검증 (pre-write check), (b) 위반 발견 시 inline blank line 정정 후 저장 — agent 산출물 archive 보존 + 정정 narrative inline 추가 (v5.11 fact 검증 패턴 정합 — overwrite 회피). MD022/MD031/MD032 hardcode (evidence-base 원칙) — 추가 rule (예: MD028 재발 또는 신 rule 발현) 시 본 절차 재발의 candidate. 정의 + 누적 evidence 1차 source = [`milestones/v5.14/REPORT.md`](milestones/v5.14/REPORT.md) L58-L59 + [`milestones/v5.15/VERIFY.md`](milestones/v5.15/VERIFY.md) L10-L11. 절차화 = [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기 안 synthesizer fact 검증 step 직후 lint precheck step + [`../../agents/project-harness-audit-team/CLAUDE.md`](../../agents/project-harness-audit-team/CLAUDE.md) D8 sequence 섹션 Note (v5.16)."
    },
    {
      "decision": "D3: agents/project-harness-audit-team/CLAUDE.md D8 sequence Note (v5.16) 추가 (Layer B WHERE)",
      "rationale": "v5.13 Note (synthesizer fact 검증) 직후 자연 위치 — Note (v5.16) 안 fact 검증과의 직교 명시 (R2 흡수). 별 책임 = fact 정확성 vs markdown 구조 lint. D2 exact_text 1차 source 와 cross-ref.",
      "alternatives_rejected": ["v5.13 Note fusion (책임 혼동 R2)", "별 섹션 신설 (scope 확대)"],
      "exact_text": "> **Note** (v5.16): synthesizer (메인 Claude orchestrator) 는 Step 1~4 산출물 산출 4 멤버 (installer Step 5 제외) markdown 산출물을 repo 안 저장 시 markdownlint MD022 (blanks-around-headings) / MD031 (blanks-around-fences) / MD032 (blanks-around-lists) 3 rule 위반 사전 방지 의무 (v5.16_audit-output-markdown-lint-precheck 절차화). pre-write check — heading / fenced code block / list 직전·직후 blank line 1 줄 존재 패턴 검증. 위반 발견 시 inline blank line 정정 후 저장. 본 의무는 v5.13 Note 안 fact 검증과 직교 (별 책임 — fact 정확성 vs markdown 구조 lint). 정의 단일 source: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 '**Agent 산출 markdown lint precheck 의무**' paragraph (v5.16 정전화). 절차 step: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) `--audit` 분기."
    },
    {
      "decision": "D4: claude/commands/harness-meta.md `--audit` 분기 sequence 안 synthesizer fact 검증 step 직후 lint precheck step 추가 (Layer C HOW)",
      "rationale": "R3 흡수 — fact 검증 (의미) → lint precheck (구조) sequence 자연 (산출물 검증 단계 순서). D2/D3 exact_text 와 cross-ref. step 추가 위치 = L80 (synthesizer fact 검증) 직후, L81 (사용자 명시 결정 게이트) 직전.",
      "alternatives_rejected": ["사용자 게이트 직후 위치 (산출물 저장 후 검증 = 회귀 검출 시점 지연)", "별 step 부재 (HOW layer 누락 = 3-layer 미완성)"],
      "exact_text": "  → [synthesizer] audit chain markdown 산출물 lint precheck (MD022 blanks-around-headings / MD031 blanks-around-fences / MD032 blanks-around-lists — heading / fenced code block / list 직전·직후 blank line 1 줄 검증, 위반 시 inline 정정 후 저장. ARCHITECTURE.md § 4 끝 'Agent 산출 markdown lint precheck 의무' 정의 준수, v5.16 정전화)"
    },
    {
      "decision": "D5: MD022 + MD031 + MD032 3 rule hardcode (Q3 결정 정합)",
      "rationale": "v5.14 (MD022 + MD032 + MD028 3건) + v5.15 (MD031 + MD032 8건) = 누적 2 사례 rule 분포 evidence-base. MD022/MD031/MD032 = 2 사례 안 발생 rule 합집합 (MD031 1 cycle 8건, MD032 2 cycle 다, MD022 1 cycle 1건). MD028 = 1 cycle 단일 발현 (재발 부재) — hardcode 미포함, 재발 시 별 milestone candidate.",
      "alternatives_rejected": ["repo .markdownlint.json 전체 참조 (over-coverage, evidence 없음)", "context7 markdownlint canonical rule 전체 참조 (결정 지연)", "MD022 + MD032 만 hardcode (MD031 1 cycle 8건 = evidence 강 무시)"]
    },
    {
      "decision": "D6: Lightweight 1-phase + 3 관점 (architecture / spec-drift / scope contract) 검토 (Q2 결정 정합)",
      "rationale": "scope = 3 host 파일 변경 + 1 milestone phase-1.md = 4 파일 = ≤5 파일 작음. v3.6 도입 lightweight 정책 정합. 5 관점 검토 (회귀 risk + 보안) = scope 확대 / 아키텍처 변경 없음 = over-engineering risk.",
      "alternatives_rejected": ["5 관점 전체 검토 (over-engineering)", "관점 검토 부재 (lightweight 미적용)"]
    },
    {
      "decision": "D7: 1+1 commit 패턴 (phase-1 implementation + Stage G+H+I 통합 chore)",
      "rationale": "v3.18+v3.19+v3.20+v3.21+v5.8+v5.9+v5.10 (phase-1) + 본 v5.16 = 1+1 commit 패턴 8 번째. Stage B-E artifacts (INTENT/RESEARCH/DESIGN/APPROVE) 는 phase-1 commit 안 포함 = (a) 패턴 (사용자 재량). 또는 Stage G commit 에 포함 = (b) 권장. 본 milestone = (a) phase-1 commit 안 포함 (도그푸드 자기참조 정합 + scope 작음).",
      "alternatives_rejected": ["별 artifacts chore commit (c) (scope 작음 = 분할 over)"]
    },
    {
      "decision": "D8: v3.21 narrative 정전화 3 단계 패턴 17 번째 cycle 도그푸드 (v5.15 = 16 번째 memory 1차 source)",
      "rationale": "DESIGN.D2.exact_text 1차 source (본 문서) + EXECUTE 안 정확 삽입 Edit + VERIFY grep 3 키워드 ('Agent 산출 markdown lint precheck 의무' + 'v5.16' + 'MD022') 검증. memory 1차 source 카운팅 — v5.15 memory '`v3.21 16번째 cycle 도그푸드`' (2026-05-18) 명시. v5.14 = 외부 audit 호출 별 책임 (narrative 정전화 cycle 비해당, narrative 정전화 cycle 카운트 skip). v5.13 (15) → v5.15 (16) → 본 v5.16 (17). spec-drift agent P2-2 + architecture agent P1-2 권고 흡수 — 사전 정확 카운팅.",
      "alternatives_rejected": ["패턴 미적용 (v3.21 정전화 본질 위배)"]
    },
    {
      "decision": "D9: lightweight 모드 누적 12/30 = 40% 갱신",
      "rationale": "v3.6 lightweight 도입 후 누적 v5.7+v5.8+v5.9+v5.10+v5.11+v5.12+v5.13+v5.14+v5.15+본 v5.16 = baseline 11/29 (v5.15 시점) → 12/30 (v5.16 추가). 40% 임계 갱신.",
      "alternatives_rejected": ["full 5 관점 (lightweight 위배)"]
    },
    {
      "decision": "D10: out_of_scope#1 강제 — agent 정의 (.md) 본문 변경 부재 (v5.15 PROPOSE#5 별 milestone)",
      "rationale": "본 milestone scope = workflow narrative 절차 정전화 (3 host: ARCHITECTURE + agents/project-harness-audit-team/CLAUDE.md + claude/commands/harness-meta.md). 4 agent 본문 (agents/project-scanner.md, agents/harness-gap-analyzer.md, agents/claude-docs-mapper.md, agents/component-proposer.md) 무변경 = v5.15 PROPOSE.next_candidates#5 (`audit-agent-tool-permission-enhancement`) 별 milestone scope.",
      "alternatives_rejected": ["agent 본문 prompt instruction 동시 추가 (scope 확대)"]
    }
  ],
  "approach": "3-layer narrative 정전화 (WHAT/WHERE/HOW) 동시 변경 = 1 phase 1 commit. Layer A (ARCHITECTURE § 4 끝, v5.11 paragraph 직후 위치) — 정의 1차 source. Layer B (agents/project-harness-audit-team/CLAUDE.md D8 Note v5.16) — sequence 절차. Layer C (claude/commands/harness-meta.md `--audit` 분기 lint precheck step) — sequence 절차. v3.21 narrative 정전화 3 단계 패턴 (DESIGN.D2.exact_text 1차 source + EXECUTE 안 정확 삽입 + VERIFY grep 검증) 16 번째 cycle 도그푸드.",
  "phases": [
    {
      "n": 1,
      "title": "3-layer narrative 정전화 동시 변경 (ARCHITECTURE § 4 끝 + agents D8 Note v5.16 + claude/commands `--audit` 분기 lint precheck step)",
      "scope": "3 host 동시 변경 + phase-1.md 작성 + Stage B-E artifacts (INTENT/RESEARCH/DESIGN/APPROVE) commit 안 포함",
      "affected_files": [
        "projects/meta/milestones/v5.16/execute/phase-1.md",
        "projects/meta/ARCHITECTURE.md (Layer A — § 4 끝, v5.11 paragraph 직후)",
        "agents/project-harness-audit-team/CLAUDE.md (Layer B — D8 sequence 섹션 안 v5.13 Note 직후)",
        "claude/commands/harness-meta.md (Layer C — `--audit` 분기 안 synthesizer fact 검증 step 직후)",
        "projects/meta/milestones/v5.16/INTENT.md",
        "projects/meta/milestones/v5.16/RESEARCH.md",
        "projects/meta/milestones/v5.16/DESIGN.md",
        "projects/meta/milestones/v5.16/APPROVE.md",
        "projects/meta/milestones/v5.16/milestones.md",
        "projects/meta/ROADMAP.md (v5.16 entry 추가)"
      ],
      "rationale": "3-layer 동시 변경 = 1 phase 단일 책임 (narrative 정전화 일관성). 분할 시 cross-ref drift risk (R5).",
      "risks": ["R5 narrative 동기화 누락 — DESIGN.D2/D3/D4 exact_text 1차 source 사용 + VERIFY grep 검증 mitigation"]
    }
  ],
  "risk_mitigation": [
    {"risk": "R1: § 4 끝 위치 부적합", "mitigation": "D2 rationale = v5.11 'Audit chain fact 인용 검증 의무' 직후 자연 위치 (검증 의무 군집), § 6 spec-drift 패턴과 군집 불일치"},
    {"risk": "R2: D8 Note 책임 중복", "mitigation": "D3 exact_text 안 'fact 검증과 직교 (별 책임 — fact 정확성 vs markdown 구조 lint)' 명시"},
    {"risk": "R3: claude/commands step sequence 순서", "mitigation": "D4 rationale = fact 검증 (의미) → lint precheck (구조) 자연 순서. L80 직후 L81 직전 위치"},
    {"risk": "R4: hardcode rule 외 신 rule 발현 시 outdated", "mitigation": "D2 exact_text 안 '추가 rule (예: MD028 재발 또는 신 rule 발현) 시 본 절차 재발의 candidate' 명시. D5 alternatives_rejected 안 정합"},
    {"risk": "R5: 3-layer 동기화 누락", "mitigation": "v3.21 패턴 — DESIGN.D2/D3/D4 exact_text 1차 source + EXECUTE Edit 정확 삽입 + VERIFY grep 3 키워드 검증"}
  ]
}
```

## narrative

### 5 관점 → 3 관점 lightweight 적용 근거 (D6)

scope = 4 affected files (3 host + phase-1.md) = ≤5 파일 작음. v3.6 도입 lightweight 정책 정합. 3 관점 검토 = architecture / spec-drift / scope contract.

### 3 관점 subagent 검토 결과 흡수

| 관점 | verdict | 결정적 이슈 | P1 권고 흡수 | P2 권고 흡수 |
|:-:|:-:|:--|:--|:--|
| architecture (Plan) | pass_with_comments | 부재 | P1-1 (§ 4 끝 paragraph 매트릭스화 candidate) → PROPOSE 안 거명 / P1-2 (D8 cycle count 사전 정확화) → D8 정정 흡수 (16 → 17) | P2-1 (D8 'Step 1~4 산출물 산출 4 멤버' explicit) → D2/D3 exact_text 정정 흡수 / P2-2 (R4 정량 threshold) → PROPOSE 안 명시 |
| spec-drift (general-purpose + context7) | pass_with_comments | 부재 | 부재 | P2-1 (MD031 canonical alias `blanks-around-fences` 병기) → D2/D3/D4 exact_text 정정 흡수 / P2-2 (D8 cycle 사전 정확화) → D8 정정 흡수 (memory 1차 source 카운팅) |
| scope contract (Explore) | pass_with_comments | 부재 (APPROVE/phase-1.md '부재' = Stage E/F 미진입 자연, 검토 시점 오해) | sc_5 sc_6 EXECUTE/VERIFY 미진입 자연 (Stage D 검토 시점) | P2-1 (D8 grep 키워드 사전 마킹) → D8 narrative 흡수 / P2-2 (Layer A/B/C cross-ref 동기) → D2/D3 cross-ref 확인 (포함) / P2-3 (lightweight 기수 EXECUTE 후 재계산) → VERIFY 단계 흡수 |

흡수 후 DESIGN.md 갱신 — D2/D3/D4 exact_text 안 MD031 canonical alias `blanks-around-fences` 병기 + '산출물 산출 4 멤버 (installer Step 5 제외)' explicit + D8 cycle count 정정 (15 → 17 누적, memory 1차 source 카운팅). 결정적 이슈 부재 = APPROVE 게이트 진입 조건 충족.

### v3.21 narrative 정전화 3 단계 패턴 17 cycle 도그푸드 (D8)

```
Step 1: DESIGN.D2/D3/D4.exact_text (1차 source — 본 문서)
        ↓
Step 2: EXECUTE phase-1.md 안 정확 삽입 Edit (Layer A/B/C 동시 commit)
        ↓
Step 3: VERIFY grep 3 키워드 (`Agent 산출 markdown lint precheck 의무` + `v5.16` + `MD022`)
```

memory 1차 source 카운팅: v5.15 = 16 번째 (memory 'v3.21 16번째 cycle 도그푸드' 명시, 2026-05-18). v5.14 = 외부 audit 호출 별 책임 (narrative 정전화 cycle 비해당). v5.13 (15) → v5.15 (16) → 본 v5.16 = **17 번째**. 사전 정확 카운팅 (3 관점 검토 P1-2 / P2-2 흡수).

### decisions/phases 부산물 사실 진술 (v3.10 정합)

D1~D10 rationale + phases[1].scope 모두 본 milestone 의 결정 / 단계 범위 사실 진술. forward propose 명령형 표현 부재 (D5 alternatives_rejected 안 'MD028 재발 시 별 milestone candidate' = 거명만, 명령형 부재).

## 관련

- INTENT: [INTENT.md](INTENT.md)
- RESEARCH: [RESEARCH.md](RESEARCH.md)
- 정전화 패턴 source: v5.13 DESIGN.md + v3.21 DESIGN.md
- 누적 evidence 1차 source: v5.14 REPORT.md L58-L59 + v5.15 VERIFY.md L10-L11

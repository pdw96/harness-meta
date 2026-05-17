# REPORT — v5.11 audit-chain-fact-verification-discipline

```json
{
  "id": "v5.11_audit-chain-fact-verification-discipline",
  "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.10 PROPOSE.next_candidates#4 (`upbit-claude-md-repo-root-creation`) 사용자 명시 선택 후 Stage A OPEN 단계 결정적 이슈 round 안 upbit/CLAUDE.md 실존 발견 (v1.17 phase-3 commit a856ddc, 2026-05-14 cascade narrative 변경 시점부터 거주, 9430 bytes) → v5.10 audit-2026-05-18 chain (scanner → analyzer → mapper → proposer) 4 산출물 안 `claude_md_in_repo: false` (scanner L77) 시발 + 3 산출물 cascade 흡수 + v5.10 PROPOSE.md next_candidates#4 5 차 위치 인용 누적 stale 확인. memory `feedback_subagent_fact_hallucination_correction` 누적 2 cycle direct evidence 도달 (v5.10 L1 component-proposer 12 항목 hallucination origin + 본 v5.11 project-scanner hallucination 신규). 9 결정 (D1 ARCHITECTURE § 4 끝 단일 source / D2 exact_text + v3.21 3 단계 패턴 / D3 O1 archive with correction narrative / D4 1-phase Lightweight + 누적 11/28 / D5 (b) commit / D6 v1.17 부재 흡수 / D7 ROADMAP 정정 부재 / D8 PROPOSE#4 stale 표지 / D9 자기참조 도그푸드). 1 phase 1+1 commit 패턴 (phase-1 a6fcf4e + Stage G+H+I 통합 chore 예정). ARCHITECTURE.md § 4 끝 L137 'Audit chain fact 인용 검증 의무' paragraph 정전화 (v3.21 narrative 정전화 3 단계 패턴 13 번째 cycle 도그푸드 완성). audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 (O1 archive with correction narrative — audit trail 보존 + memory 'evidence 보존' 원칙 정합). v5.10 PROPOSE.md next_candidates#4 entry block _v5_11_correction 필드 추가. v1.17 audit chain hallucination 부재 사실 진술 흡수 (D6, sc_5 PASS_WITH_NOTE). lightweight 모드 (5 관점 subagent 생략 + 자기참조 회피 표지) — 누적 11/28 = 39.3% 갱신. INTENT.success_criteria 8건 모두 VERIFY.criteria_check PASS (6 PASS + 2 PASS_WITH_NOTE). pre-commit 14 hook 모두 PASS, 회귀 0. 2026-05-18.",
  "delta": {
    "files_changed": 9,
    "files_added": 8,
    "files_deleted": 0,
    "lines_added": 90,
    "lines_deleted": 14,
    "net_lines": 76,
    "modules_affected": [
      "projects/meta/ARCHITECTURE.md (§ 4 끝 + L137 paragraph 정전화, ~16 segment narrative)",
      "projects/meta/ROADMAP.md (v5.11 entry 신규 등재 + updated 갱신)",
      "projects/meta/milestones/v5.10/PROPOSE.md (next_candidates#4 _v5_11_correction 필드)",
      "projects/upbit/audit-2026-05-18/scanner-output.md (3 위치 inline 정정)",
      "projects/upbit/audit-2026-05-18/analyzer-output.md (4 위치 inline 정정)",
      "projects/upbit/audit-2026-05-18/mapper-output.md (3 위치 inline 정정)",
      "projects/upbit/audit-2026-05-18/proposal-draft.md (4 위치 inline 정정)",
      "projects/meta/milestones/v5.11/ (신규 milestone 컨테이너 8 산출물 — INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + milestones.md + execute/phase-1.md)"
    ]
  },
  "commits": [
    {"phase": 1, "hash": "a6fcf4e", "subject": "feat(meta): v5.11 phase-1 — ARCHITECTURE § 4 audit chain fact 검증 의무 paragraph 정전화 + v5.10 audit chain hallucination cascade 14 위치 inline 정정 + PROPOSE#4 stale 표지"},
    {"phase": "Stage G+H+I", "hash": "PENDING_AT_COMMIT", "subject": "chore(meta): v5.11 Stage B-I — INTENT+RESEARCH+DESIGN+APPROVE+VERIFY+REPORT+PROPOSE artifacts + ROADMAP completed + milestones.md commit hash"}
  ],
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "audit chain fact 인용 hallucination 의 5 차 위치 누적 cascade 패턴 (scanner 1 origin → analyzer/mapper/proposal-draft 3 cascade → ROADMAP/PROPOSE entry 5 차 인용) 정량 첫 사례",
      "evidence": "v5.10 scanner-output.md L77 `claude_md_in_repo: false` 1 origin → analyzer A4 entry + mapper A4 entry + proposal A4 entry + proposal next_milestone#4 + ROADMAP entry summary 안 PROPOSE next_candidates#4 origin = 5 차 위치 누적. 본 v5.11 = scanner hallucination 발견 후 4 산출물 14 위치 inline 정정 + PROPOSE.md _v5_11_correction 단일 위치 정정 정량.",
      "carry_over": "synthesizer 가 audit chain 산출물 안 fact 인용 (boolean / 표 / 수치) 발견 시 직접 source 매핑 검증 의무 = ARCHITECTURE § 4 끝 v5.11 paragraph 정전화 narrative 정합."
    },
    {
      "id": "L2",
      "lesson": "memory feedback 작성 시점과 실 운용 시점 사이 동일 hallucination 재현 — feedback memory 자체가 사용자 의도된 가드레일이지만, synthesizer 가 PROPOSE 작성 시점 검증 운용 부재 = direct evidence cycle 2 자연 도달 trigger",
      "evidence": "memory feedback_subagent_fact_hallucination_correction = v5.10 L1 origin 시점 (2026-05-18 직후) 작성. 본 v5.11 = 동일 세션 안 v5.10 PROPOSE 작성 후 발견된 scanner hallucination 미검증 사실 = feedback 작성 시점 ≠ 운용 시점 cycle 자연 발견. ARCHITECTURE 정전화 = narrative 정전화 = 향후 동일 cycle 재진입 시 trigger narrative.",
      "carry_over": "feedback memory 와 ARCHITECTURE narrative 이중 layer 정합 (memory = 세션 컨텍스트 + ARCHITECTURE = 공식 1차 source). 향후 audit chain 호출 시 본 paragraph 자연 cross-ref."
    },
    {
      "id": "L3",
      "lesson": "Stage A OPEN 단계 결정적 이슈 round 안 sub-agent 산출물 fact 직접 검증 = scope rewrite 자연 발견 패턴 누적",
      "evidence": "v5.10 = Stage A 안 v1.17 audit chain 완전 실행 fact 발견 → 'first call' → 'second call + diff' scope rewrite + v5.11 = Stage A 안 upbit/CLAUDE.md 거주 fact 발견 → 'upbit-claude-md-repo-root-creation' → 'audit-chain-fact-verification-discipline' scope rewrite. 누적 2 cycle (v5.10 + v5.11) 동일 패턴.",
      "carry_over": "Stage A OPEN 단계 = sub-agent 산출물 또는 v5.10 PROPOSE candidates 의 fact 직접 검증 의무 자연 default. memory feedback_iterative_pre_plan_review 정합 ('진입 전 의문 round 의무, 매 round마다 결정적 이슈 trigger')."
    },
    {
      "id": "L4",
      "lesson": "v3.21 narrative 정전화 3 단계 패턴 13 번째 cycle 도그푸드 완성 — v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 + v5.0 + v5.7 + v5.8 + v5.9 + v5.10 + 본 v5.11 = 12 누적 후 13 번째",
      "evidence": "(a) DESIGN.D2.exact_text 정확 문구 markdown code block 1차 source / (b) phase-1 EXECUTE Edit tool `new_string` 정확 삽입 a6fcf4e / (c) VERIFY grep 3 키워드 cohesive 단일 위치 = L137 검증. 3 단계 패턴 정합 완전. ARCHITECTURE § 4 끝 4 paragraph (B/C/D 부산물 + Word-fidelity + ROADMAP 단어 + Narrative cascade drift) → 5 번째 paragraph v5.11 추가 = cascade 의미 인접 자연.",
      "carry_over": "narrative 정전화 패턴 안정 default — 신규 ARCHITECTURE 정전화 시 동일 3 단계 적용."
    },
    {
      "id": "L5",
      "lesson": "lightweight 모드 + 도그푸드 비대칭 정합 6 번째 사례 (v3.18 + v3.20 + v3.21 + v5.7 + v5.10 + 본 v5.11)",
      "evidence": "lightweight 모드 자기참조 회피 표지 = workflow self-improvement 본질의 인접 본질 회피. 도그푸드 = 본 milestone 자체가 audit chain fact 검증 narrative 정전화의 첫 적용. 두 정책 동시 적용 = 비대칭 정합 (회피 표지 ≠ 도그푸드 부정, 회피 표지 = self-loop 강화 회피 + 도그푸드 = 자기참조 사용 evidence). 본 v5.11 안 D4 lightweight + D9 도그푸드 = 두 결정 양립 narrative.",
      "carry_over": "lightweight 모드 default + 도그푸드 evidence 두 narrative 동시 default. 향후 동일 cycle 안 두 narrative 단일 source 안 흡수."
    },
    {
      "id": "L6",
      "lesson": "O1 archive with correction narrative 패턴 첫 사용 = v5.10 L1 component-proposer overwrite 정정 패턴과 비대칭 정합",
      "evidence": "v5.10 L1 = component-proposer hallucination overwrite 정정 (synthesizer 산출 안 12 항목 표 직접 교체, audit trail 손실 허용 — proposer 산출 자체는 synthesizer 가 final output 안 임시 재작성 본질). 본 v5.11 = scanner-output.md hallucination 안 inline 정정 (audit trail 보존, scanner agent 직접 산출 자체 보존 — agent 산출 = audit chain evidence 본질). 두 패턴 비대칭 = '산출 본질 (synthesizer 임시 vs agent 직접)' 별 default 정정 패턴.",
      "carry_over": "audit chain 안 hallucination 정정 default = agent 직접 산출은 inline 정정 (archive with correction) + synthesizer 임시 산출은 overwrite. 향후 동일 결정 시 본 비대칭 narrative cross-ref."
    },
    {
      "id": "L7",
      "lesson": "self-loop 비례 = 14 번째 사례 (v4.0 ~ v5.11 누적 = 12 meta self-loop / 외부 vector evidence 2건 = v1.17 + v5.10 audit chain 호출)",
      "evidence": "v5.8 RESEARCH 안 self-loop sub-metric = 'meta self-loop / 외부 vector evidence' 분모 통합. v4.0~v5.11 누적 12 meta self-loop (본 v5.11 포함) / 외부 vector evidence 2 = self-loop 비례 12/14 = 85.7% (v5.10 시점 12/13 = 92.3% 대비 -6.6pp). 외부 vector 직접 운용 vector = v5.10 second call audit chain 단독, 본 v5.11 = 직접 외부 vector 아님 (audit chain narrative 정전화 = meta 자체).",
      "carry_over": "self-loop 비례 evidence sub-metric 계속 monitor. 외부 vector 추가 누적 trigger = cycle 3 audit-team 호출 + upbit 외 외부 적용 milestone (v5.10 PROPOSE candidates #1~#4)."
    }
  ]
}
```

## narrative

본 REPORT 는 v5.11 milestone 의 backward 종합 단일 source. summary + delta + commits + lessons_learned 7건.

### 핵심 산출물 evidence

- ARCHITECTURE.md L137 'Audit chain fact 인용 검증 의무' paragraph 정전화 (v3.21 3 단계 패턴 13 번째 cycle 도그푸드)
- v5.10 audit-2026-05-18/ 4 산출물 안 14 위치 inline 정정 (O1 archive with correction narrative)
- v5.10 PROPOSE.md next_candidates#4 `_v5_11_correction` 필드 추가 (stale 표지)
- v1.17 audit chain hallucination 부재 사실 진술 흡수 (D6, sc_5 PASS_WITH_NOTE)

### lessons_learned forward-only 정책 정합 (v3.10 + v5.8)

lessons_learned 7건 모두 (a) 사실 진술 + (b) carry_over narrative — `next_candidates` 후속 milestone 명명 표현은 Stage I PROPOSE 통합 흡수. forward propose 책임 분리.

### 도그푸드 narrative 자기 검증

본 milestone 자체가 audit chain fact 인용 검증 의무 narrative 정전화 의 첫 도그푸드 — Stage A OPEN 단계 결정적 이슈 round 안 upbit/CLAUDE.md 거주 fact 검증 = synthesizer 직접 매핑 검증 의무 D2 narrative 부합 evidence. RESEARCH 단계 v1.17 audit chain hallucination 부재 검증 = 동일 패턴 evidence.

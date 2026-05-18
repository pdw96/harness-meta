# DESIGN — v5.17 external-audit-team-cycle-5-call

```json
{
  "id": "v5.17",
  "decisions": [
    {
      "id": "D1",
      "decision": "Option A 채택 — 4 멤버 전체 audit chain (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer)",
      "rationale": "v5.14/v5.15 cycle 3/4 동일 scope 정합 = 1:1 diff 가능. ecosystem integrator vector 완전 evidence 5건 누적. Option B(2 멤버 경량)는 비대칭 scope = diff 1:1 불가 + proposer 산출물 부재 + lint precheck 첫 실전 evidence 부분만. Option C(diff 강화 + 4 멤버)는 diff narrative LOC 증가 trade-off — 본 milestone에서 D9(diff 구조 정책)로 흡수 가능.",
      "alternatives_rejected": ["Option B 경량 2 멤버: vector evidence 미달 + 1:1 diff 불가 + 사용자 게이트 입력 미생성 + lint precheck 첫 실전 evidence 부분만", "Option C diff 강화 full: D9 diff 구조로 흡수 가능 (별 옵션 채택 불요)"]
    },
    {
      "id": "D2",
      "decision": "audit 산출물 디렉토리: `projects/upbit/audit-2026-05-18-cycle5/` (날짜+cycle suffix)",
      "rationale": "v5.14/v5.15 cycle 3/4 패턴 정합 (`audit-2026-05-18-cycle3/`, `audit-2026-05-18-cycle4/`). 동일 날짜 동일 upbit 대상 = cycle suffix로 순서 명시. v5.10 cycle 2(`audit-2026-05-18/` 무접미사) + v5.14/v5.15 cycle 3/4 baseline 보존.",
      "alternatives_rejected": ["audit-2026-05-19/ 신규 날짜: 실제 실행 일자 2026-05-18과 불일치 drift", "audit-cycle-5/ 날짜 부재: 날짜 trace 누락"]
    },
    {
      "id": "D3",
      "decision": "self-loop 카운팅 정책 — v5.15 정전화 그대로 + v5.16 = self-loop 분류 = 18 self-loop + 5 외부 = 18/23 = 78.3%",
      "rationale": "v5.15 정전화 = 17/21 = 81% (v4.0~v5.9 = 14 + v5.11/v5.12/v5.13 = 3 = 17 self-loop). v5.16 audit-output-markdown-lint-precheck = workflow narrative 자체 강화 (lint precheck 절차 정전화) = self-loop 카테고리 정합. 외부 vector v5.17 = 5 (v1.17/v5.10/v5.14/v5.15/v5.17). 본 v5.17 = 카운팅 정전화 후속 cycle. 결과 ratio = 18/23 = 78.26% ≈ 78.3%. 단일 source — v5.16 분류 정합 narrative 본 milestone REPORT 안 명시.",
      "alternatives_rejected": ["옵션 B v5.16 = 외부 분류 (17/22 = 77.3%): v5.16 본질 = workflow narrative 강화 = self-loop 정합. 외부 분류 misclassification", "옵션 C v5.17 자체 포함 카운팅: 본 milestone 자체 카운팅 시점 모호 (in_progress 시점 포함 여부)"],
      "explicit_counting": {
        "v4_0_to_v5_9_self_loop": ["v4.0", "v4.1", "v4.2", "v4.3", "v5.0", "v5.1", "v5.2", "v5.3", "v5.4", "v5.5", "v5.6", "v5.7", "v5.8", "v5.9"],
        "v4_0_to_v5_9_count": 14,
        "post_v5_9_meta_self_loop": ["v5.11", "v5.12", "v5.13", "v5.16"],
        "post_v5_9_count": 4,
        "v5_15_baseline_inherited": "v5.15 정전화 = 17 self-loop (v4.0~v5.9 14 + v5.11/v5.12/v5.13 3) + 4 외부 (v1.17/v5.10/v5.14/v5.15) = 17/21 = 81%. v5.16 = self-loop 추가 (workflow narrative 강화 본질) = 18 self-loop. 외부 vector 5 (v5.17 추가). v5.17 시점 정전화 = 18 self-loop + 5 외부 = 23 total, ratio = 18/23 = 78.26% ≈ 78.3%.",
        "total_self_loop_at_v5_17": 18,
        "external_vector_at_v5_17": 5,
        "total_milestones_at_v5_17": 23,
        "self_loop_ratio_at_v5_17": "18/23 = 78.26% ≈ 78.3%"
      }
    },
    {
      "id": "D4",
      "decision": "ARCHITECTURE.md § 4 exact_text 갱신 — vector count 4건 → 5건",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 (v5.7~v5.16 누적 패턴, 본 milestone 18번째 cycle): (a) DESIGN exact_text 사전 정의 → (b) EXECUTE Edit → (c) VERIFY grep 키워드.",
      "exact_text_old": "audit-team 호출 누적 정확 정량 = 4건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth)",
      "exact_text_new": "audit-team 호출 누적 정확 정량 = 5건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth + v5.17 fifth)",
      "verify_grep_keyword": "5건.*v1.17.*v5.10.*v5.14.*v5.15.*v5.17",
      "alternatives_rejected": ["별도 paragraph 신규 추가: 단일 source paragraph 비대화 risk + v5.14/v5.15 패턴 일관성 미달"]
    },
    {
      "id": "D5",
      "decision": "2-phase 분할 — Phase 1(audit chain 실행 + 사용자 게이트) / Phase 2(diff + ARCHITECTURE 갱신 + Stage G+H+I 산출물)",
      "rationale": "v5.14/v5.15 2-phase 패턴 정합. Phase 1 안 사용자 결정 게이트 위치 → Phase 2 = accept 이후 확정 산출물. 1-phase 통합 시 사용자 게이트가 단일 commit 분리 불가. 본 milestone scope 16~17 파일 (v5.15 scope과 동일) — 2-phase 분할이 자연.",
      "alternatives_rejected": ["1-phase 통합: 사용자 게이트 위치 ambiguous → commit 분리 불가", "3-phase 분할 (audit + diff + Stage G+H+I): over-engineering"]
    },
    {
      "id": "D6",
      "decision": "commit 패턴 (b) — Phase 1 commit + Phase 2 commit(Stage G+H+I 통합 chore)",
      "rationale": "v5.10/v5.11/v5.12/v5.13/v5.14/v5.15 누적 패턴 정합. Stage G VERIFY 전 Phase 1 산출물 영구 보존 보장.",
      "alternatives_rejected": ["패턴 (a) phase-1 commit 안 INTENT~APPROVE 포함: phase-1 commit message 비대화", "패턴 (c) 별도 chore commit: 3건 commit으로 분산 — 2건이면 충분"]
    },
    {
      "id": "D7",
      "decision": "fact 검증 scope — v5.15 D7 동일 + v1.20 apply 2 항목 (R1 + R2) 직접 매핑 검증 추가",
      "rationale": "v5.15 D7 (v5.14 D6 + v1.19 apply 4 항목) 패턴 정합 + v1.20 apply 2 항목 (R1 CLAUDE.md L122~L123 + R2 L37) 직접 검증 = cycle 5 = v1.20 apply 효과 측정. scanner / analyzer 산출물 안 2 항목 적용 사실 inline 검증. RESEARCH 시점 사전 verify 완료 (L37 = 'pre-commit hooks (v1.12)' + L122~L123 = `.claude-plugin/hooks/...` + `plugin.json mcpServers.harness`).",
      "alternatives_rejected": ["v5.15 D7만 (apply 검증 부재): cycle 5 본질 가치 (v1.20 apply 효과 측정) 누락"]
    },
    {
      "id": "D8",
      "decision": "lightweight 모드 — 3 관점 (architecture / scope-contract / spec-drift)",
      "rationale": "v5.14/v5.15 lightweight 3 관점 패턴 정합. 본 milestone scope = audit chain 호출 (read-only) + diff + 산출물 + ARCHITECTURE 수치 갱신 = 신규 narrative 부재 + procedural 통일. 5 관점 풀 over-engineering. memory feedback_token_efficiency_priority 정합 — token 효율 우선.",
      "alternatives_rejected": ["5 관점 풀 (회귀 risk + 보안 추가): 본 milestone scope 안 보안 위협 부재 (read-only audit + 산출물 추가) + 회귀 risk smoke로 자동 검증"]
    },
    {
      "id": "D9",
      "decision": "diff-vs-cycle4.md 구조 — v5.15 diff-vs-cycle3.md 5+1 섹션 패턴 정합 + v1.20 apply 2 항목 검증 sub-section + lint precheck 첫 실전 결과 sub-section = 5+2 섹션",
      "rationale": "v5.15 diff-vs-cycle3.md = 5+1 섹션 (5 v5.14 패턴 + v1.19 apply 효과 sub-section). 본 milestone diff-vs-cycle4.md = 동일 5 섹션 + 6번째 'v1.20 apply 효과 검증' sub-section (R1/R2 2 항목 일대일 검증 표) + 7번째 'v5.16 lint precheck 첫 실전 결과' sub-section (4 산출물별 MD022/MD031/MD032 위반 검사 결과 표) = v5.15 + cycle 5 본질 가치 (lint precheck 첫 실전) 흡수.",
      "alternatives_rejected": ["v5.15 5+1 섹션 그대로 follow: v5.16 lint precheck 첫 실전 evidence 누락 (sc_3 미달)"]
    },
    {
      "id": "D10",
      "decision": "lint precheck 절차 첫 실전 적용 방식 — synthesizer 매 audit 산출물 저장 직전 MD022/MD031/MD032 검사 + 위반 inline 정정 + diff-vs-cycle4.md 안 결과 표 기록",
      "rationale": "v5.16 lint precheck 절차 (3-layer cross-ref 정전화) 첫 실전 적용. 매 audit 산출물(scanner-output/analyzer-output/mapper-output/proposal-draft) Write 직전 grep 검사 + 위반 발견 시 inline 정정 후 저장. diff-vs-cycle4.md 안 7번째 섹션 = 4 산출물 × 3 rule = 12 cell 검사 결과 표 + 위반 발견 시 inline 정정 사실 기록. MD028 등 hardcode 외 rule 발견 시 별 row 추가 (R7 mitigation evidence 누적).",
      "alternatives_rejected": ["산출물 저장 후 batch 검사 + 별 commit 정정: 단일 phase 안 워크플로우 break", "synthesizer 검사 생략 (markdownlint pre-commit hook 의존): 사전 방지 절차 본 milestone 실전 적용 evidence 부재"]
    }
  ],
  "approach": "v5.14/v5.15 cycle 3/4 패턴 정합 — 4 멤버 audit chain (read-only) + v5.13 3-layer fact 검증 절차 세 번째 실전 적용 + v5.16 lint precheck 절차 첫 실전 적용 + v1.20 apply 2 항목 효과 검증 + ARCHITECTURE.md § 4 vector count 4→5 + self-loop 카운팅 정전화 (18/23 = 78.3%). 2-phase 분할 (Phase 1 = audit chain + 게이트 / Phase 2 = diff + ARCHITECTURE + Stage G+H+I).",
  "phases": [
    {
      "n": 1,
      "title": "audit-team 4 멤버 순차 호출 + synthesizer fact 검증 (v5.13 세 번째 실전) + lint precheck (v5.16 첫 실전) + v1.20 apply 2 항목 검증 + 사용자 결정 게이트",
      "scope": "Agent(project-scanner) → Agent(harness-gap-analyzer) → Agent(claude-docs-mapper) → Agent(component-proposer) 순차 호출. 4 산출물을 `projects/upbit/audit-2026-05-18-cycle5/`에 저장. synthesizer D7 fact 검증 수행 (scanner boolean + proposer 표 + 수치 + v1.20 apply 2 항목). 매 산출물 저장 직전 D10 lint precheck (MD022/MD031/MD032) 적용. proposal-draft 산출 후 사용자 AskUserQuestion 결정 게이트(accept/reject 항목별). Phase 1 commit.",
      "affected_files": [
        "projects/upbit/audit-2026-05-18-cycle5/scanner-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle5/analyzer-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle5/mapper-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle5/proposal-draft.md (신규)",
        "projects/meta/milestones/v5.17/execute/phase-1.md (신규)"
      ],
      "rationale": "사용자 결정 게이트(accept/reject)가 Phase 1 완료 후에 위치해야 Phase 2 확정 산출물과 분리 가능. v5.14/v5.15 패턴 정합.",
      "risks": ["proposer/scanner/mapper hallucination cycle 7+ 위험 — D7 fact 검증으로 mitigate", "delta 작을 가능성 (v1.20 mechanical apply 단일 책임, RESEARCH 시점 사전 verify) — 본 milestone 가치 재정의 (stability + vector + 절차 세 번째/첫 실전)로 흡수", "lint precheck rule 한계 (MD028 등 hardcode 외) 발견 시 evidence 기록 (R7 mitigation)"]
    },
    {
      "n": 2,
      "title": "v5.15 diff 문서 (5+2 섹션) + ARCHITECTURE § 4 vector count 갱신 + self-loop 카운팅 정전화 + 9-stage Stage G+H+I 산출물",
      "scope": "diff-vs-cycle4.md 생성 (D9 5+2 섹션 — 5 섹션 v5.14/v5.15 패턴 정합 + v1.20 apply 효과 검증 sub-section + lint precheck 첫 실전 결과 sub-section). ARCHITECTURE.md § 4 D4 exact_text 적용 (4건→5건). self-loop 카운팅 정전화 (D3 결정 narrative 본 milestone REPORT 안 명시, ARCHITECTURE 변경 부재). VERIFY.md + REPORT.md + PROPOSE.md 작성. milestones.md sub_milestones phase-1 title 교체 + phase-2 추가. Stage G+H+I 통합 chore commit.",
      "affected_files": [
        "projects/upbit/audit-2026-05-18-cycle5/diff-vs-cycle4.md (신규)",
        "projects/meta/ARCHITECTURE.md (§ 4 exact_text edit)",
        "projects/meta/milestones/v5.17/VERIFY.md (신규)",
        "projects/meta/milestones/v5.17/REPORT.md (신규)",
        "projects/meta/milestones/v5.17/PROPOSE.md (신규)",
        "projects/meta/milestones/v5.17/milestones.md (sub_milestones 갱신)",
        "projects/meta/milestones/v5.17/execute/phase-2.md (신규)",
        "projects/meta/ROADMAP.md (v5.17 status completed 갱신)"
      ],
      "rationale": "9-stage 산출물과 meta 파일 갱신은 Phase 1 accept 이후 확정 단계에서 통합 처리. v5.14/v5.15 Phase 2 패턴 정합.",
      "risks": ["ARCHITECTURE § 4 edit 위치 오류 — D4 exact_text 사전 정의 + VERIFY grep mitigate", "diff-vs-cycle4.md LOC 증가 (5+2 섹션, ~300~400 line) — D9 명시로 risks 인지 + 본 milestone 가치 정당화"]
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 self-loop 카운팅 v5.16 분류 결정 필요", "mitigation": "D3 정책 결정 (옵션 A v5.16 = self-loop 분류 = 18/23 = 78.3%) + explicit_counting block 안 milestone list 명시"},
    {"risk": "R2 새 발견 0건 가능 (v1.20 apply 외 변화 부재 예측, high)", "mitigation": "본 milestone 가치 재정의 — (a) stability 검증 (b) integrator vector 5건 evidence (c) 3-layer 절차 세 번째 + lint precheck 절차 첫 실전 적용. 새 발견은 부수 가치. INTENT.sc 8건 중 새 발견 sc 부재 (모두 누적 evidence + 절차 적용 sc) → 가치 재정의 narrative 정합. RESEARCH 시점 사전 verify 결과 v1.20 apply 정확 + 부수 변경 0건 확인 = R2 high likelihood 명시"},
    {"risk": "R3 audit chain hallucination 재발 (cycle 7+ origin 가능)", "mitigation": "D7 fact 검증 (v5.15 D7 + v1.20 apply 2 항목 추가) — synthesizer 직접 매핑 검증 + 발견 시 inline 정정 (audit trail 보존)"},
    {"risk": "R4 pre-commit smoke 회귀 (산출물 9개 + ARCHITECTURE)", "mitigation": "pre-commit hook 자동 실행 + INTENT/APPROVE schema 검증 사전 인지 (memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap) + D10 markdownlint MD022/MD031/MD032 사전 적용"},
    {"risk": "R5 vector 가설 (~78%) 검증 — v5.15 정전화 81% → v5.17 18/23 78.3%", "mitigation": "D3 정확 카운팅 정전화 → 실 비율 = 18/23 = 78.26% ≈ 78.3% (단일 source). v5.15 → v5.17 변화 = 81% → 78.3% = monotonic 감소 추세 지속 evidence"},
    {"risk": "R6 audit 디렉토리 명명 충돌", "mitigation": "D2 cycle5 suffix 명시 — v5.10/v5.14/v5.15 baseline 보존"},
    {"risk": "R7 lint precheck rule 한계 (MD028 등 hardcode 외) 발견 가능", "mitigation": "D10 절차 안 hardcode 외 rule 발견 시 inline 정정 + diff-vs-cycle4.md 안 별 row 추가 → v5.16 PROPOSE#2 (audit-output-markdown-lint-rule-expansion-md028) trigger 조건 가속 evidence"}
  ],
  "five_perspective_review": {
    "scope_size": "medium (audit 산출물 5 + meta 산출물 9 + ARCHITECTURE 1 + ROADMAP 1 = 16 파일)",
    "perspectives_applied": 3,
    "perspectives_skipped": ["회귀 risk (lightweight 모드, smoke 자동 검증 충분)", "보안 (read-only audit, side effect 부재)"],
    "results": [
      {
        "perspective": "architecture",
        "agent_type": "Plan",
        "verdict": "pass_with_comments",
        "decisive_issues": 0,
        "absorbed": [
          "INTENT.sc_1 + ROADMAP.summary 디렉토리명 audit-2026-05-18-cycle5/ 동기 (v5.14/v5.15 baseline 정합)",
          "D3 self-loop ratio 단일 source 18/23 = 78.3% 정전화 (81% baseline → 78.3% monotonic 감소 evidence)",
          "D10 lint precheck 절차 첫 실전 적용 method = synthesizer 매 산출물 직전 검사 + inline 정정 + diff 결과 표 (v5.16 정전화 절차 정합 evidence)"
        ],
        "rejected": ["§ 3.1 L77 v5.8 baseline paragraph 갱신 — D4 § 4 단일 source 충분, out_of_scope#3 정합", "5 관점 풀 — D8 lightweight 정당화 충분"]
      },
      {
        "perspective": "scope_contract",
        "agent_type": "Explore",
        "verdict": "pass_with_comments",
        "decisive_issues": 0,
        "absorbed": [
          "VERIFY grep 키워드 '18/23' 또는 '78.3%' 명시 (D3 정전화 evidence)",
          "REPORT 안 v1.20 apply 효과 측정 sub-section 단일 source 명시",
          "REPORT 안 lint precheck 첫 실전 결과 (4 산출물 × 3 rule = 12 cell 표) sub-section 단일 source 명시"
        ],
        "mapping_table": "sc_1~sc_8 8건 모두 PASS, OOS 6건 충돌 0"
      },
      {
        "perspective": "spec_drift",
        "agent_type": "general-purpose",
        "verdict": "pass_with_comments",
        "decisive_issues": 0,
        "absorbed": [
          "RESEARCH.md 디렉토리 명명 audit-2026-05-18-cycle5/ 정합 (v5.10 무접미사 → v5.14/v5.15 cycle3/4 → v5.17 cycle5 monotonic suffix 패턴)",
          "D3 single source 18/23 = 78.3% 확정",
          "INTENT.sc_3 + D10 lint precheck 첫 실전 결과 sub-section 명시 (정량 기준 4 산출물 × 3 rule = 12 cell 표)",
          "INTENT.sc_5 D7 v1.20 apply 2 항목 검증 명시 (sub-section 정량 기준 확정)"
        ],
        "spec_drift_findings": [
          "v5.13 절차 ↔ D7 정합 PASS",
          "v5.16 절차 ↔ D10 정합 PASS",
          "v5.14 D6 + v5.15 D7 ↔ v5.17 D7 = 강화 (drift 아님)",
          "ARCHITECTURE § 4 D4 매핑 PASS (v3.21 정전화 3 단계 18번째 cycle)"
        ]
      }
    ],
    "conflicts": 0,
    "rationale_for_lightweight": "v5.14/v5.15 lightweight 3 관점 패턴 정합 + scope 본질 = procedural 통일 + read-only audit + 신규 narrative 부재 + memory feedback_token_efficiency_priority. 5 관점 over-engineering risk."
  }
}
```

## narrative

**결정 요약**: 10 결정 (D1~D10) — Option A 채택 / cycle5 디렉토리 / self-loop 18/23 = 78.3% / ARCHITECTURE exact_text 4→5 / 2-phase 분할 / commit 패턴 (b) / fact 검증 D7+v1.20 2 항목 / lightweight 3 관점 / diff 5+2 섹션 / lint precheck 첫 실전 method.

**접근 (approach)**: v5.14/v5.15 cycle 3/4 패턴 정합 + cycle 5 본질 가치 (v1.20 apply 효과 검증 + v5.16 lint precheck 첫 실전) 추가 + self-loop 카운팅 정전화 (v5.15 81% → v5.17 78.3% monotonic 감소).

**phases**: 2 phase (v5.14/v5.15 동일 패턴) — Phase 1(audit chain + 게이트 + lint precheck) / Phase 2(diff 5+2 섹션 + ARCHITECTURE + Stage G+H+I).

**risk_mitigation**: 7건 (R1~R7) — RESEARCH 안 risks_identified 1:1 매핑.

**5 관점 검토 — lightweight 모드 3 관점 적용 (architecture / scope_contract / spec_drift)**:

- architecture (Plan agent simulation) — pass_with_comments, 결정적 이슈 0, 3건 흡수 (디렉토리명 / D3 정전화 / D10 method)
- scope_contract (Explore agent simulation) — pass_with_comments, sc_1~sc_8 모두 PASS, OOS 6건 충돌 0
- spec_drift (general-purpose + context7 simulation) — pass_with_comments, v5.13/v5.16 절차 정합 PASS, ARCHITECTURE § 4 D4 매핑 PASS

5 관점 풀 (회귀 risk + 보안) 생략 = D8 lightweight rationale 정합 (read-only audit + smoke 자동 검증).

Stage D 완료 직전 의무 step — `phases[]` 확정 후 `milestones/v5.17/milestones.md` `sub_milestones[]` 동기 갱신 (Stage F 진입 전 처리).

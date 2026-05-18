# DESIGN — v5.15 external-audit-team-cycle-4-call

```json
{
  "id": "v5.15",
  "decisions": [
    {
      "id": "D1",
      "decision": "Option A 채택 — 4 멤버 전체 audit chain (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer)",
      "rationale": "v5.14 cycle 3 동일 scope 정합 = 1:1 diff 가능. ecosystem integrator vector 완전 evidence 4건 누적. Option B(2 멤버 경량)는 비대칭 scope = diff 1:1 불가 + proposer 산출물 부재. Option C(diff 강화 + 4 멤버)는 diff narrative LOC 증가 trade-off — 본 milestone에서 D5(phase 분할 정책)로 흡수 가능.",
      "alternatives_rejected": ["Option B 경량 2 멤버: vector evidence 미달 + 1:1 diff 불가 + 사용자 게이트 입력 미생성", "Option C diff 강화 full: D5 phase 분할로 흡수 가능 (별 옵션 채택 불요)"]
    },
    {
      "id": "D2",
      "decision": "audit 산출물 디렉토리: `projects/upbit/audit-2026-05-18-cycle4/` (날짜+cycle suffix)",
      "rationale": "v5.14 cycle 3 패턴 정합 (`audit-2026-05-18-cycle3/`). 동일 날짜 동일 upbit 대상 = cycle suffix로 순서 명시. v5.10 cycle 2(`audit-2026-05-18/` 무접미사)와 v5.14 cycle 3 baseline 보존.",
      "alternatives_rejected": ["audit-2026-05-19/ 신규 날짜: 실제 실행 일자 2026-05-18과 불일치 drift", "audit-cycle-4/ 날짜 부재: 날짜 trace 누락"]
    },
    {
      "id": "D3",
      "decision": "self-loop 카운팅 정책 — 옵션 B 채택: 정확 누적 카운팅 (v4.0~v5.14 모든 meta milestone 포함). 단일 source ratio = 17/21 = 81%.",
      "rationale": "v5.14 REPORT 카운팅 '14 self-loop' 모호 (v5.11/v5.12/v5.13 audit narrative cleanup milestone 포함 여부 불명). 본 v5.15 = 카운팅 명시 정전화 기회. 정확 누적: v4.0~v5.9 = 14 self-loop (v4.0/v4.1/v4.2/v4.3/v5.0/v5.1/v5.2/v5.3/v5.4/v5.5/v5.6/v5.7/v5.8/v5.9) + v5.11/v5.12/v5.13 = 3 self-loop (audit narrative cleanup도 meta self-loop 카테고리 안 포함) = total 17 self-loop. 외부 vector = v1.17 + v5.10 + v5.14 + v5.15 = 4. total 21. self-loop = 17/21 = 80.95% ≈ 81%. 단일 source 정전화 — 78.9%/15/19 가설 carry-over 제거.",
      "alternatives_rejected": ["옵션 A v5.14 카운팅 그대로 follow (14/18 = 77.8%): 카운팅 모호 persist", "옵션 C 가중 평균: 단순 카운팅 대비 narrative 비대화"],
      "explicit_counting": {
        "v4_0_to_v5_9_self_loop": ["v4.0", "v4.1", "v4.2", "v4.3", "v5.0", "v5.1", "v5.2", "v5.3", "v5.4", "v5.5", "v5.6", "v5.7", "v5.8", "v5.9"],
        "v4_0_to_v5_9_count": 14,
        "post_v5_9_meta_self_loop": ["v5.11", "v5.12", "v5.13"],
        "post_v5_9_count": 3,
        "v5_8_baseline_history": "v5.8 L77 baseline (2026-05-17) = 12 (v4.0~v5.7) + 1 외부 (v1.17). v5.10 시점 (2026-05-18) = v5.8/v5.9 추가 = 14 + 2 외부 (v1.17, v5.10) = 14/16 = 87.5%. v5.14 시점 (2026-05-18) = v5.11/v5.12/v5.13 추가 = 17 + 3 외부 (v1.17, v5.10, v5.14) = 17/20 = 85% (단 v5.14 REPORT는 '14/17 = 82.4%' 카운팅 — v5.11~v5.13 누락 모호). v5.15 본 milestone 정전화 = 17 self-loop + 4 외부 = 21 total, ratio = 17/21 = 81%.",
        "total_self_loop_at_v5_15": 17,
        "external_vector_at_v5_15": 4,
        "total_milestones_at_v5_15": 21,
        "self_loop_ratio_at_v5_15": "17/21 = 80.95% ≈ 81.0%"
      }
    },
    {
      "id": "D4",
      "decision": "ARCHITECTURE.md § 4 L135 exact_text 갱신 — vector count 3건 → 4건",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴 (v5.7~v5.14 누적 패턴, 본 milestone 16번째 cycle): (a) DESIGN exact_text 사전 정의 → (b) EXECUTE Edit → (c) VERIFY grep 키워드.",
      "exact_text_old": "audit-team 호출 누적 정확 정량 = 3건 (v1.17 first + v5.10 second + v5.14 third)",
      "exact_text_new": "audit-team 호출 누적 정확 정량 = 4건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth)",
      "verify_grep_keyword": "4건.*v1.17.*v5.10.*v5.14.*v5.15",
      "alternatives_rejected": ["별도 paragraph 신규 추가: 단일 source paragraph 비대화 risk + v5.14 패턴 일관성 미달"]
    },
    {
      "id": "D5",
      "decision": "2-phase 분할 — Phase 1(audit chain 실행 + 사용자 게이트) / Phase 2(diff + ARCHITECTURE 갱신 + Stage G+H+I 산출물)",
      "rationale": "v5.14 2-phase 패턴 정합. Phase 1 안 사용자 결정 게이트 위치 → Phase 2 = accept 이후 확정 산출물. 1-phase 통합 시 사용자 게이트가 단일 commit 분리 불가. 본 milestone scope 16 파일 (v5.14 scope과 동일) — 2-phase 분할이 자연.",
      "alternatives_rejected": ["1-phase 통합: 사용자 게이트 위치 ambiguous → commit 분리 불가", "3-phase 분할 (audit + diff + Stage G+H+I): over-engineering"]
    },
    {
      "id": "D6",
      "decision": "commit 패턴 (b) — Phase 1 commit + Phase 2 commit(Stage G+H+I 통합 chore)",
      "rationale": "v5.10/v5.11/v5.12/v5.13/v5.14 누적 패턴 정합. Stage G VERIFY 전 Phase 1 산출물 영구 보존 보장.",
      "alternatives_rejected": ["패턴 (a) phase-1 commit 안 INTENT~APPROVE 포함: phase-1 commit message 비대화", "패턴 (c) 별도 chore commit: 3건 commit으로 분산 — 2건이면 충분"]
    },
    {
      "id": "D7",
      "decision": "fact 검증 scope — v5.14 D6 동일 + v1.19 apply 4 항목 직접 매핑 검증 추가",
      "rationale": "v5.14 D6 (scanner boolean + proposer 표 + 수치) + v1.19 apply 4 항목 (G1 stale cp / G2 symlink narrative / G3 SessionStart hook / S2 spike-investigator) 직접 검증 = cycle 4 = v1.19 apply 효과 측정. scanner / analyzer 산출물 안 4 항목 적용 사실 inline 검증.",
      "alternatives_rejected": ["v5.14 D6만 (apply 검증 부재): cycle 4 본질 가치 (v1.19 apply 효과 측정) 누락"]
    },
    {
      "id": "D8",
      "decision": "lightweight 모드 — 3 관점 (architecture / scope-contract / spec-drift)",
      "rationale": "v5.14 lightweight 3 관점 패턴 정합. 본 milestone scope = audit chain 호출 (read-only) + diff + 산출물 + ARCHITECTURE 수치 갱신 = 신규 narrative 부재 + procedural 통일. 5 관점 풀 over-engineering. memory feedback_token_efficiency_priority 정합 — token 효율 우선.",
      "alternatives_rejected": ["5 관점 풀 (회귀 risk + 보안 추가): 본 milestone scope 안 보안 위협 부재 (read-only audit + 산출물 추가) + 회귀 risk smoke로 자동 검증"]
    },
    {
      "id": "D9",
      "decision": "diff-vs-cycle3.md 구조 — v5.14 diff-vs-cycle2.md 5 섹션 패턴 정합 + v1.19 apply 4 항목 검증 sub-section 추가",
      "rationale": "v5.14 diff-vs-cycle2.md = 5 섹션 (하네스 상태 delta / gap 분석 delta / fact 검증 delta / proposal 비교 / vector count). 본 milestone diff-vs-cycle3.md = 동일 5 섹션 + 6번째 'v1.19 apply 효과 검증' sub-section (G1/G2/G3/S2 4 항목 일대일 검증 표) = v5.14 + cycle 4 본질 가치 흡수.",
      "alternatives_rejected": ["v5.14 5 섹션 그대로 follow: v1.19 apply 효과 검증 누락"]
    }
  ],
  "approach": "v5.14 cycle 3 패턴 정합 — 4 멤버 audit chain (read-only) + v5.13 3-layer fact 검증 절차 두 번째 실전 적용 + v1.19 apply 4 항목 효과 검증 + ARCHITECTURE.md § 4 L135 vector count 3→4 + self-loop 카운팅 정전화 (17/21 = 81%). 2-phase 분할 (Phase 1 = audit chain + 게이트 / Phase 2 = diff + ARCHITECTURE + Stage G+H+I).",
  "phases": [
    {
      "n": 1,
      "title": "audit-team 4 멤버 순차 호출 + synthesizer fact 검증 (v5.13 두 번째 실전) + v1.19 apply 4 항목 검증 + 사용자 결정 게이트",
      "scope": "Agent(project-scanner) → Agent(harness-gap-analyzer) → Agent(claude-docs-mapper) → Agent(component-proposer) 순차 호출. 4 산출물을 `projects/upbit/audit-2026-05-18-cycle4/`에 저장. synthesizer D7 fact 검증 수행 (scanner boolean + proposer 표 + 수치 + v1.19 apply 4 항목). proposal-draft 산출 후 사용자 AskUserQuestion 결정 게이트(accept/reject 항목별). Phase 1 commit.",
      "affected_files": [
        "projects/upbit/audit-2026-05-18-cycle4/scanner-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle4/analyzer-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle4/mapper-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle4/proposal-draft.md (신규)",
        "projects/meta/milestones/v5.15/execute/phase-1.md (신규)"
      ],
      "rationale": "사용자 결정 게이트(accept/reject)가 Phase 1 완료 후에 위치해야 Phase 2 확정 산출물과 분리 가능. v5.14 패턴 정합.",
      "risks": ["proposer/scanner/mapper hallucination cycle 5 위험 — D7 fact 검증으로 mitigate", "delta 작을 가능성 (v1.19 mechanical apply 단일 책임) — 본 milestone 가치 재정의 (stability + vector + 절차 두 번째)로 흡수"]
    },
    {
      "n": 2,
      "title": "v5.14 diff 문서 (5+1 섹션) + ARCHITECTURE § 4 L135 vector count 갱신 + self-loop 카운팅 정전화 + 9-stage Stage G+H+I 산출물",
      "scope": "diff-vs-cycle3.md 생성 (D9 5+1 섹션 — 5 섹션 v5.14 패턴 정합 + v1.19 apply 효과 검증 sub-section). ARCHITECTURE.md § 4 L135 D4 exact_text 적용 (3건→4건). self-loop 카운팅 정전화 (D3 결정 narrative 본 milestone REPORT 안 명시, ARCHITECTURE 변경 부재). VERIFY.md + REPORT.md + PROPOSE.md 작성. milestones.md sub_milestones phase-1 title 교체 + phase-2 추가. Stage G+H+I 통합 chore commit.",
      "affected_files": [
        "projects/upbit/audit-2026-05-18-cycle4/diff-vs-cycle3.md (신규)",
        "projects/meta/ARCHITECTURE.md (L135 exact_text edit)",
        "projects/meta/milestones/v5.15/VERIFY.md (신규)",
        "projects/meta/milestones/v5.15/REPORT.md (신규)",
        "projects/meta/milestones/v5.15/PROPOSE.md (신규)",
        "projects/meta/milestones/v5.15/milestones.md (sub_milestones 갱신)",
        "projects/meta/milestones/v5.15/execute/phase-2.md (신규)",
        "projects/meta/ROADMAP.md (v5.15 status completed 갱신)"
      ],
      "rationale": "9-stage 산출물과 meta 파일 갱신은 Phase 1 accept 이후 확정 단계에서 통합 처리. v5.14 Phase 2 패턴 정합.",
      "risks": ["ARCHITECTURE L135 edit 위치 오류 — D4 exact_text 사전 정의 + VERIFY grep mitigate", "diff-vs-cycle3.md LOC 증가 (5+1 섹션) — D9 명시로 risks 인지 + 본 milestone 가치 정당화"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1 self-loop 카운팅 모호 (v5.14 inherited)",
      "mitigation": "D3 정책 결정 + explicit_counting block 안 milestone list 명시"
    },
    {
      "risk": "R2 새 발견 0건 가능 (v1.19 apply 외 변화 부재 예측)",
      "mitigation": "본 milestone 가치 재정의 — (a) stability 검증 (b) integrator vector 4건 evidence (c) 3-layer 절차 두 번째 적용. 새 발견은 부수 가치. INTENT.success_criteria 7건 중 새 발견 sc 부재 (모두 누적 evidence + 절차 적용 sc) → 가치 재정의 narrative 정합"
    },
    {
      "risk": "R3 audit chain hallucination 재발 (cycle 4 origin)",
      "mitigation": "D7 fact 검증 (v5.14 D6 + v1.19 apply 4 항목 추가) — synthesizer 직접 매핑 검증 + 발견 시 inline 정정 (audit trail 보존)"
    },
    {
      "risk": "R4 pre-commit smoke 회귀 (산출물 9개 + ARCHITECTURE)",
      "mitigation": "pre-commit hook 자동 실행 + INTENT/APPROVE schema 검증 사전 인지 (memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap)"
    },
    {
      "risk": "R5 vector 가설 (78%) 검증 실패 (카운팅 baseline 변경)",
      "mitigation": "D3 정확 카운팅 정전화 → 실 비율 = 17/21 = 81% (단일 source). 가설 78% 와 실 81% 차이 = ~3pp = 카운팅 baseline 차이 (v5.14 REPORT 14 self-loop vs 정확 17 self-loop) 정량 명시 narrative 안 흡수"
    },
    {
      "risk": "R6 audit 디렉토리 명명 충돌",
      "mitigation": "D2 cycle4 suffix 명시 — v5.10/v5.14 baseline 보존"
    }
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
          "INTENT.sc_1 + ROADMAP.summary 디렉토리명 audit-2026-05-18b/ → audit-2026-05-18-cycle4/ 동기 (v5.14 baseline 정합)",
          "D3 self-loop ratio 단일 source 17/21 = 81% 정전화 (78.9%/15/19 carry-over 제거)"
        ],
        "rejected": ["§ 3.1 L77 v5.8 baseline paragraph 갱신 — D4 § 4 L135 단일 source 충분, out_of_scope#3 정합"]
      },
      {
        "perspective": "scope_contract",
        "agent_type": "Explore",
        "verdict": "pass_with_comments",
        "decisive_issues": 0,
        "absorbed": [
          "VERIFY grep 키워드 '17/21' 또는 '81.0%' 명시 (D3 정전화 evidence)",
          "REPORT 안 v1.19 apply 효과 측정 sub-section 단일 source 명시"
        ],
        "mapping_table": "sc_1~sc_7 7건 모두 PASS, OOS 5건 충돌 0"
      },
      {
        "perspective": "spec_drift",
        "agent_type": "general-purpose",
        "verdict": "pass_with_comments",
        "decisive_issues": 0,
        "absorbed": [
          "RESEARCH.md L40~41 디렉토리 명명 audit-2026-05-18/cycle4/ → audit-2026-05-18-cycle4/ 정정",
          "D3 single source 17/21 = 81% 확정",
          "INTENT.sc_3 D9 v1.19 apply 4 항목 검증 명시 (sub-section 정량 기준 확정)"
        ],
        "spec_drift_findings": [
          "v5.13 절차 ↔ D7 정합 PASS",
          "v5.14 D6 ↔ v5.15 D7 = 강화 (drift 아님)",
          "ARCHITECTURE L135 D4 매핑 PASS (v3.21 정전화 3 단계 16번째 cycle)"
        ]
      }
    ],
    "conflicts": 0,
    "rationale_for_lightweight": "v5.14 lightweight 3 관점 패턴 정합 + scope 본질 = procedural 통일 + read-only audit + 신규 narrative 부재 + memory feedback_token_efficiency_priority. 5 관점 over-engineering risk."
  }
}
```

## narrative

**결정 요약**: 9 결정 (D1~D9) — Option A 채택 / cycle4 디렉토리 / self-loop 옵션 B 정확 카운팅 / ARCHITECTURE exact_text 3→4 / 2-phase 분할 / commit 패턴 (b) / fact 검증 D6+v1.19 4 항목 / lightweight 3 관점 / diff 5+1 섹션.

**접근 (approach)**: v5.14 cycle 3 패턴 정합 + cycle 4 본질 가치 (v1.19 apply 효과 검증) 추가 + self-loop 카운팅 정전화.

**phases**: 2 phase (v5.14 동일 패턴) — Phase 1(audit chain + 게이트) / Phase 2(diff + ARCHITECTURE + Stage G+H+I).

**risk_mitigation**: 6건 (R1~R6) — RESEARCH 안 risks_identified 1:1 매핑.

**5 관점 검토 — lightweight 모드 3 관점 (예정)**:

- architecture (Plan agent)
- scope_contract (Explore agent)
- spec_drift (general-purpose agent + context7)

DESIGN 완료 후 5 관점 병렬 invoke + 결과 흡수 → APPROVE 게이트 진입.

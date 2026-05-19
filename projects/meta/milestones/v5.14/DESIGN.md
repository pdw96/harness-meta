---
id: v5.14
title: DESIGN v5.14
version: v5.14
stage: DESIGN
status: completed
---

# DESIGN — v5.14 external-audit-team-cycle-3-call

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option A 채택 — 4 멤버 전체 audit chain (project-scanner → harness-gap-analyzer → claude-docs-mapper → component-proposer)",
      "rationale": "ecosystem integrator 정체성 운용 vector 완전 evidence 생성 + v5.10 4 파일 1:1 diff 가능 + proposer 산출물 = 사용자 결정 게이트 직접 입력. Option B(2 멤버 경량)는 vector evidence 미달 + 사용자 게이트 입력 미생성으로 부적합.",
      "alternatives_rejected": [
        "Option B — 2 멤버(scanner + gap-analyzer만): ecosystem integrator vector 완전 evidence 미달, proposer 산출물 없어 사용자 게이트 무의미"
      ]
    },
    {
      "id": "D2",
      "decision": "audit 산출물 디렉토리: `projects/upbit/audit-2026-05-18-cycle3/` (날짜+cycle suffix)",
      "rationale": "v5.10 cycle 2와 같은 날짜(2026-05-18)에 동일 upbit 대상 재실행이므로 날짜 단독으로는 구분 불가. suffix `-cycle3`으로 순서 명시. diff 기준 파일(cycle 2, 4건)은 `audit-2026-05-18/`에 그대로 보존.",
      "alternatives_rejected": [
        "날짜 신규 디렉토리(audit-2026-05-19/): 실행 날짜와 불일치 가능성 → drift 위험"
      ]
    },
    {
      "id": "D3",
      "decision": "2-phase 분할 — Phase 1(audit chain 실행 + 사용자 게이트) / Phase 2(diff + ARCHITECTURE 갱신 + 9-stage 산출물)",
      "rationale": "v5.10 선례(phase-1 audit chain / phase-2 diff + ARCHITECTURE) 정합. Phase 1이 사용자 결정 게이트를 포함하므로 Phase 2는 accept 이후 확정 산출물만 담당.",
      "alternatives_rejected": [
        "1-phase 통합: 사용자 게이트가 중간에 삽입되어 단일 commit 분리 불가"
      ]
    },
    {
      "id": "D4",
      "decision": "ARCHITECTURE.md § 4 L135 exact_text 갱신 — vector count 2건 → 3건",
      "rationale": "v3.21 narrative 정전화 3 단계 패턴: (a) DESIGN exact_text 사전 정의 → (b) EXECUTE Edit → (c) VERIFY grep 키워드.",
      "exact_text_old": "audit-team 호출 누적 정확 정량 = 2건 (v1.17 first + v5.10 second)",
      "exact_text_new": "audit-team 호출 누적 정확 정량 = 3건 (v1.17 first + v5.10 second + v5.14 third)",
      "verify_grep_keyword": "3건.*v1.17.*v5.10.*v5.14",
      "alternatives_rejected": [
        "별도 paragraph 신규 추가: 단일 source paragraph 비대화 risk"
      ]
    },
    {
      "id": "D5",
      "decision": "commit 패턴 (b) — Phase 1 commit + Phase 2 commit(Stage G+H+I 통합 chore)",
      "rationale": "v5.10/v5.11/v5.12/v5.13 누적 패턴 정합. Stage G VERIFY 전 Phase 1 산출물 영구 보존 보장.",
      "alternatives_rejected": [
        "패턴 (c) 별도 chore commit: 2건 commit으로 충분, chore commit 추가 불필요"
      ]
    },
    {
      "id": "D6",
      "decision": "fact 검증 scope — scanner boolean(claude_md_in_repo / harness_toml / plugin_json) + proposer 표(proposal 항목) + 수치(agents_count / skills_count) 직접 매핑 검증",
      "rationale": "v5.11 회귀 hallucination 유형 2건(claude_md_in_repo false + proposer 표 upbit 무관 항목) 직접 target. v5.13 3-layer HOW step 절차 정합.",
      "alternatives_rejected": [
        "전체 산출물 전수 검증: 과도한 synthesizer 부담, fact 인용 위치 targeted 검증으로 충분"
      ]
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "audit-team 4 멤버 순차 호출 + synthesizer fact 검증 + proposal-draft + 사용자 결정 게이트",
      "scope": "Agent(project-scanner) → Agent(harness-gap-analyzer) → Agent(claude-docs-mapper) → Agent(component-proposer) 순차 호출. 4 산출물을 `projects/upbit/audit-2026-05-18-cycle3/`에 저장. synthesizer D6 fact 검증 수행. proposal-draft 산출 후 사용자 AskUserQuestion 결정 게이트(accept/reject). Phase 1 commit.",
      "affected_files": [
        "projects/upbit/audit-2026-05-18-cycle3/scanner-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle3/analyzer-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle3/mapper-output.md (신규)",
        "projects/upbit/audit-2026-05-18-cycle3/proposal-draft.md (신규)",
        "projects/meta/milestones/v5.14/execute/phase-1.md (신규)"
      ],
      "rationale": "사용자 결정 게이트(accept/reject)가 Phase 1 완료 후에 위치해야 Phase 2 확정 산출물과 분리 가능.",
      "risks": [
        "proposer hallucination 위험 — D6 fact 검증으로 mitigate"
      ]
    },
    {
      "n": 2,
      "title": "v5.10 diff 문서 + ARCHITECTURE § 4 L135 vector count 갱신 + 9-stage Stage G+H+I 산출물",
      "scope": "diff-vs-cycle2.md 생성(v5.10 cycle2 4 파일 대비 delta 정량). ARCHITECTURE.md § 4 L135 D4 exact_text 적용(2건→3건). VERIFY.md + REPORT.md + PROPOSE.md 작성. milestones.md sub_milestones phase-1 title 교체 + phase-2 추가. Stage G+H+I 통합 chore commit.",
      "affected_files": [
        "projects/upbit/audit-2026-05-18-cycle3/diff-vs-cycle2.md (신규)",
        "projects/meta/ARCHITECTURE.md (L135 exact_text edit)",
        "projects/meta/milestones/v5.14/VERIFY.md (신규)",
        "projects/meta/milestones/v5.14/REPORT.md (신규)",
        "projects/meta/milestones/v5.14/PROPOSE.md (신규)",
        "projects/meta/milestones/v5.14/milestones.md (sub_milestones 갱신)",
        "projects/meta/milestones/v5.14/execute/phase-2.md (신규)",
        "projects/meta/ROADMAP.md (v5.14 status completed 갱신)"
      ],
      "rationale": "9-stage 산출물과 meta 파일 갱신은 Phase 1 accept 이후 확정 단계에서 통합 처리.",
      "risks": [
        "ARCHITECTURE L135 edit 위치 오류 — D4 exact_text 사전 정의로 mitigate"
      ]
    }
  ]
}
```

## Approach

4 멤버 audit chain을 upbit 대상으로 세 번째 실행하고, v5.13 3-layer fact 검증 절차를 첫 실전 적용한다. 2-phase 구조로 Phase 1(chain 실행 + fact 검증 + 사용자 결정 게이트) → Phase 2(diff + ARCHITECTURE 갱신 + 9-stage 산출물)를 분리한다.

## Risk mitigation

- risk: proposer hallucination (cycle 4); mitigation: D6 fact 검증 — scanner boolean + proposer 표 직접 매핑 검증 의무 (v5.13 HOW step 실전 적용)
- risk: ARCHITECTURE L135 edit 위치 오류; mitigation: D4 exact_text_old/new 사전 정의 + VERIFY grep keyword 확정
- risk: audit 산출물 디렉토리 혼동 (cycle2 vs cycle3); mitigation: D2 `-cycle3` suffix 명시 + diff 기준선 디렉토리(cycle2) read-only 보존

## Five perspective review

- **scope_size**: small (5 파일 이하 meta 산출물 + audit 산출물 분리)
- **perspectives_applied**: 3
- **results**: [{"perspective": "architecture", "verdict": "pass_with_comments", "absorbed": ["Phase 2 sub-milestone milestones.md 추가", "audit 산출물 디렉토리명 D2 명시", "ARCHITECTURE exact_text D4 v3.21 패턴"]}, {"perspective": "scope_contract", "verdict": "pass_with_comments", "absorbed": ["Phase 2 명시화 — diff + ARCHITEC...
- **conflicts**: 0

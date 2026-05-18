# PROPOSE — v5.21

```json
{
  "id": "roadmap-forward-looking-redesign-and-changelog-archival",
  "title": "ROADMAP forward-looking 재정의 + CHANGELOG.md v5.7~v5.20 14 entry backfill + completed 41건 archival + cascade 7 host narrative",
  "propose_summary": "v5.21 schema A2 + cascade 정전화 완료 후 자연 발의 후보 거명. (1) v6.0_workflow-automation-and-least-privilege 는 이미 ROADMAP.next_candidates[]#1 등재 (사용자 명시 발의 A_user, 2026-05-19, scope 분리 (A) 결정 정합) — 본 PROPOSE 안 재거명만. (2) v5.21 lessons L1~L7 기반 추가 candidates 7건 거명만 (e3 정책 + lightweight default 동결 누적 15 cycle, ROADMAP.next_candidates[] 등재 0건). (3) archival cycle 첫 적용 도그푸드 — Stage I 안 ROADMAP `milestones[]` v5.21 status:completed 갱신 + 가장 오래된 completed entry (v5.18) archival cycle 적용 (이미 [v5.18] CHANGELOG entry 보유, 단순 ROADMAP entry 제거).",
  "next_candidates": [
    {
      "id": "workflow-automation-and-least-privilege",
      "title": "9-stage 자동 전환 + per-stage 최소 권한 원칙 (PoLP) 적용 + 사전적 정의 1:1 매핑 강화",
      "trigger": "A_user",
      "trigger_type": "user-explicit",
      "origin_milestone": "v5.21",
      "target_version": "v6.0",
      "registration_status": "ROADMAP.next_candidates[]#1 이미 등재 (사용자 명시 발의 (A) 결정 정합)",
      "description": "사용자 명시 발의 (A_user, 2026-05-19) — 'MD+JSON 자동 전환 구현 + 각 stage 사전적 정의에 따른 최소 권한 원칙 적용'. v5.21 PROPOSE next_candidates#1 진급. 9 stage 별 도구 권한 매트릭스 정의 + 구현 메커니즘 후보 4건 (9 stage slash command 분리 / 9 stage agent 신규 + orchestrator / Hook 확장 / 단일 slash command 인자 분기). v6.0 major bump (Workflow 본질 재정의 = breaking)."
    },
    {
      "id": "research-quantitative-metric-direct-measurement-pattern",
      "title": "RESEARCH 단계 정량 metric 직접 측정 의무 narrative 정전화 (L1 origin)",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합, ROADMAP 등재 zero)",
      "description": "v5.21 L1 lesson origin — RESEARCH 안 ROADMAP size 추정 ~37000 bytes 부정확 (실 101939 = 2.7x) → phase-1 commit FAIL trigger. file size / line count / entry count 등 정량 metric 은 `wc -c` / `wc -l` 직접 측정 의무 narrative 정전화 candidate (RESEARCH 템플릿 보강). v1.5_research-cascade-grep-discipline (deferred) 동질 본질 — workflow self-improvement, v4.0 § 6.2 폐지 narrative 정합 deferred 후보."
    },
    {
      "id": "smoke-cross-ref-autofix-natural-pattern-canonicalization",
      "title": "smoke-cross-ref --fix 자연 발현 패턴 정전화 (L3 origin) — REPORT.md placeholder 사전 작성 narrative",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합)",
      "description": "v5.21 L3 lesson origin — phase-3 commit 1차 시도 시 smoke-cross-ref --fix 자연 발현 (REPORT.md 미작성 시점 broken ref 자동 삭제). 패턴 정전화 = phase-3 commit 직전 REPORT.md placeholder 사전 작성 narrative (cross-ref 보존 목적). v5.20 동일 패턴 누적 누적 (L1 v5.20 동일 lesson). 누적 2 cycle 도달 — 본 candidate 가 정전화 trigger 후보 (단 e3 정책 default 동결)."
    },
    {
      "id": "changelog-md024-no-duplicate-heading-pattern-canonicalization",
      "title": "CHANGELOG entry 안 같은 분류 ### sub-section 중복 회피 narrative 정전화 (L4 origin)",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합)",
      "description": "v5.21 L4 lesson origin — phase-3 commit 1차 시도 시 [v5.21] entry 안 ### Changed 2 sub-section MD024 FAIL. Keep a Changelog 권장 순서 (Added / Changed / Deprecated / Removed / Fixed / Security) 정합 단일 sub-section 통합 narrative 정전화 candidate. v5.16 markdownlint MD022/MD031/MD032 hardcode 와 동질 본질 — 추가 rule (MD024) hardcode 후보."
    },
    {
      "id": "narrative-canonicalization-cycle-25-stability-pattern",
      "title": "v3.21 narrative 정전화 3 단계 패턴 cycle 25+ stability 첫 완성 (L5 origin)",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합)",
      "description": "v5.21 L5 lesson origin — v3.21 narrative 정전화 3 단계 패턴 cycle 24 누적 도달. 누적 25+ cycle 안 패턴 stability cycle 첫 완성 가능 후보. v5.20 stability cycle (audit-apply-audit 본질) 정합 narrative — narrative 정전화 패턴 자체의 stability cycle 검증 candidate."
    },
    {
      "id": "propose-register-meaning-resolution-narrative-canonicalization",
      "title": "PROPOSE register 책임 의미 부분 자연 해소 narrative (단어-책임 분리 본질 아님) 정전화 (L6 origin)",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합)",
      "description": "v5.21 L6 lesson origin — Schema A2 의 next_candidates[] 별도 필드 도입으로 PROPOSE drift 70% → ~90% 자연 해소. 단 PROPOSE 단어-책임 자체 분리 아님 (10-stage 분리 본질 아님). 등재 위치만 변경. § 4 끝 #2 paragraph 안 cross-ref 흡수 완료. 추가 narrative 정전화 candidate (e.g., Workflow row 안 명시 흡수)."
    },
    {
      "id": "user-round-iteration-pattern-canonicalization",
      "title": "사용자 명시 발의 + AskUserQuestion 9 round 자연 정합 패턴 정전화 (L7 origin)",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합)",
      "description": "v5.21 L7 lesson origin — 본 milestone 안 사용자 AskUserQuestion 9 round (trigger 명료화 → 방향 → archival/recent/bump → backfill scope → MD+JSON 자동 전환 → scope 분리 → Schema option → 권고 흡수 → APPROVE 게이트). memory feedback_iterative_pre_plan_review + feedback_token_efficiency_priority 균형 안 자연. 패턴 정전화 candidate (claude/commands/harness-meta.md Stage A~E 안 사용자 round 권장 narrative 추가)."
    },
    {
      "id": "smoke-cascade-natural-absorption-pattern-canonicalization",
      "title": "smoke logic 갱신은 schema 변경 cascade 의 자연 일부 — DESIGN.phase 분할 narrative 와 미세 충돌 수용 (L2 origin)",
      "trigger": "C_improvement",
      "trigger_type": "naming-only",
      "origin_milestone": "v5.21",
      "registration_status": "거명만 (e3 정책 정합)",
      "description": "v5.21 L2 lesson origin — smoke-bundle-trigger.sh L93 deferred 분기 추가가 phase-2 commit scope 안 자연 포함. DESIGN.D4 phase 분할 narrative 가 strict scope contract 아닌 책임 분리 가이드. cascade 자연 효과로 phase scope 안 자연 흡수 narrative 정전화 candidate."
    }
  ],
  "archival_cycle_application": {
    "trigger_condition": "milestones[] 안 completed entry count > 3",
    "current_state_before_stage_i": "milestones[] = in_progress 1 (v5.21) + completed 3 (v5.20/v5.19/v5.18) + deferred 3 = 7 entry",
    "state_after_stage_i": "milestones[] = completed 1 (v5.21, status:completed 갱신) + completed 3 (v5.20/v5.19/v5.18) = 4 → archival cycle trigger (count > 3)",
    "oldest_completed_to_archive": "v5.18 (2026-05-18, audit-chain-direct-read-and-verification-depth)",
    "archival_status": "이미 [v5.18] CHANGELOG entry 보유 (phase-1 backfill 완료, [v5.18] - 2026-05-18 entry). 단순 ROADMAP `milestones[]` entry 제거",
    "post_archival_milestones_length": "6 (in_progress 0 + completed 3 = recent 3 (v5.21 + v5.20 + v5.19) + deferred 3)",
    "dogfooding_note": "archival cycle 첫 적용 = v5.21 milestone 자체의 self-application. v3.0_milestones-restructure 안 자기참조 부합 도그푸드 선례 정합. Stage I 안 ROADMAP 갱신 후 별 chore commit (Stage G+H+I 통합)"
  }
}
```

## actual operation (v5.21+ schema A2 정합)

본 Stage I 안 수행 예정:

1. ROADMAP `milestones[]` 배열에서 본 milestone (v5.21) `status: "in_progress"` → `"completed"` 갱신
2. `next_candidates` 8건 중 #1 (workflow-automation-and-least-privilege) 은 이미 ROADMAP `next_candidates[]` 등재 — 재거명 narrative (본 PROPOSE)
3. **Archival cycle 첫 적용** (v5.21+ 도그푸드): milestones[] completed count = 4 (v5.21+v5.20+v5.19+v5.18) > 3 → 가장 오래된 completed entry v5.18 의 ROADMAP entry 제거 (CHANGELOG [v5.18] entry 보유로 archival 완료). post-archival state = milestones[] length 6 (recent 3 + deferred 3)
4. 본 milestone 의 lessons L1~L7 candidates 7건 PROPOSE 안 narrative 거명만 (ROADMAP 등재 zero, e3 정책 정합)
5. Stage G+H+I 통합 chore commit (사용자 확인 후)

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- REPORT: [`REPORT.md`](REPORT.md)
- 신 schema 안 archival cycle narrative: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) Stage I step 3 (v5.21 phase-3 추가)

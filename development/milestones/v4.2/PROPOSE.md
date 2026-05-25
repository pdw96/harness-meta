---
id: milestone-v4.2-propose
title: PROPOSE v4.2
version: v4.2
stage: PROPOSE
status: completed
---

# PROPOSE — v4.2 verify-infra-agent-absorption

## Spec

```json
{
  "next_candidates": [
    {
      "id": "broken-ref-prevention-narrative",
      "title": "신규 산출물 안 미작성 산출 cross-ref 사전 거명 회피 narrative — Stage F EXECUTE 산출물 안 REPORT.md 등 후속 stage 산출물 거명 시점 규약",
      "origin": "v4.2 VERIFY L1 lesson + smoke-cross-ref --fix 자동 정리 사례 (phase-1 첫 commit FAIL → re-commit PASS)",
      "trigger": "C_improvement",
      "trigger_type": "workflow_self-improvement",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "v4.0 § 6.2 폐지 후 workflow self-improvement 자유 발의 narrative — 단 candidates 거명만 (사용자 명시 결정 후 ROADMAP 등재, e3 정책 정합 v4.0/v4.1 패턴 누적). 새 정체성 (project harness composer + agent fleet maintainer) 가 자연 가드레일."
    },
    {
      "id": "environment-auditor-runtime-verification",
      "title": "environment-auditor + agents-md-sync 첫 호출 실 검증 — 사용자 자연어 'verify 해줘' / 'AGENTS.md drift 확인' 시점 실행 결과 narrative 보고",
      "origin": "v4.2 phase-1 신규 subagent 2 추가 후 첫 호출 검증 부재 (component-installer 통합 검증 ad-hoc R2 mitigation 패턴 정합)",
      "trigger": "A_user",
      "trigger_type": "runtime_validation",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "runtime 검증 본질 — milestone 형식 아닌 사용자 자연어 호출 시점 실 실행 + 결과 narrative report. 별도 milestone 부재 가능."
    },
    {
      "id": "agents-md-drift-routine",
      "title": "AGENTS.md drift 정기 routine 등록 — schedule skill 안 cron entry (주 1회 또는 매 PR 직전 -Check)",
      "origin": "v4.2 agents-md-sync standalone subagent 도입 + bootstrap/agents/CLAUDE.md § 벤치마크 cycle 패턴 정합",
      "trigger": "A_user",
      "trigger_type": "schedule_routine_registration",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "사용자 환경 의존 — `/schedule` skill 안 cron entry 등록은 본 repo 외부 (사용자 ~/.claude/scheduled_tasks/). 별도 milestone 부재."
    },
    {
      "id": "junction-recognition-adhoc-verification",
      "title": "ad-hoc Junction 인식 검증 (Windows 환경) — environment-auditor 통합 검증 첫 호출 시 yaml frontmatter resolve 보장 + Claude Code session 안 subagent_type 등재 확인",
      "origin": "v4.1 R2 mitigation 누적 (R2 ad-hoc 검증 narrative) + environment-auditor 첫 호출 시 동일 검증 책임 흡수 가능",
      "trigger": "B_regression",
      "trigger_type": "runtime_validation",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "runtime 검증 본질 — environment-auditor 자체가 본 검증 책임 보유 (B 단계 Symlink/Junction 무결성 6 check). 별도 milestone 부재."
    },
    {
      "id": "dev-tools-category-standalone-subagent",
      "title": "bootstrap/agents/dev-tools/ 카테고리 신규 standalone subagent 추가 — placeholder 해소 (예: code-style-auditor / dependency-analyzer 등)",
      "origin": "bootstrap/agents/CLAUDE.md 매트릭스 안 dev-tools/ row placeholder + v4.0/v4.1 PROPOSE carry-over (dev-tools 카테고리 부재)",
      "trigger": "A_user",
      "trigger_type": "agent_fleet_expansion",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "구체 책임 (어떤 dev-tool subagent) 미결정 — 사용자 명시 발의 + 구체 책임 명시 후 ROADMAP 등재. e3 정책 정합 (propose narrative → 사용자 결정 → milestone)."
    },
    {
      "id": "verify-infra-cross-platform-validation",
      "title": "environment-auditor cross-platform 실 검증 — Linux/macOS 환경 안 첫 호출 결과 narrative (Windows 환경 v4.2 단일 검증)",
      "origin": "v4.1 (Junction Windows + Symlink Linux/macOS Option D) + v4.2 environment-auditor 흡수 narrative — Linux/macOS 환경 첫 호출 검증 부재 (v4.2 사용자 환경 Windows 단일)",
      "trigger": "B_regression",
      "trigger_type": "cross_platform_validation",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "runtime 검증 본질 — 사용자 환경 의존 (Linux/macOS 환경 부재 시 검증 불가능). 사용자 환경 변경 또는 외부 적용 시 별 검증 narrative."
    }
  ]
}
```

## PROPOSE summary

v4.2 milestone 의 forward proposal — next_candidates 6건 모두 narrative 거명만 (ROADMAP 등재 0건). 정합 origin: (1) VERIFY L1 lesson (broken ref 패턴) → workflow self-improvement (#1). (2) phase-1 신규 subagent 2 첫 호출 검증 부재 → runtime 검증 (#2 + #6). (3) agents-md-sync 정기 routine → schedule skill (#3). (4) Junction 인식 검증 v4.1 R2 누적 → environment-auditor 책임 흡수 (#4). (5) dev-tools/ placeholder 해소 → agent fleet 확장 (#5). 모두 사용자 명시 발의 + 구체 책임 결정 후 ROADMAP 등재 (e3 정책 정합 v4.0/v4.1 패턴 누적). § 6.2 폐지 (v4.0) 후 workflow self-improvement 자유 발의 narrative — 다만 새 정체성 (project harness composer + agent fleet maintainer) 가 자연 가드레일.

## narrative

v4.2 milestone 의 forward 후속 — 6 candidates 모두 narrative 거명만 (ROADMAP 등재 0건, v4.0/v4.1 패턴 정합). 본 milestone 산출물 안 forward propose 책임 단일 source = 본 PROPOSE.md (B/C/D 부산물 통합 흡수, v3.10 정합).

origin 통합 분포:

- VERIFY lessons_learned origin: 1건 (#1, L1)
- runtime 검증 origin: 3건 (#2 / #4 / #6, 신규 subagent 호출 시점 + cross-platform)
- schedule 외부 의존 origin: 1건 (#3)
- agent fleet 확장 origin: 1건 (#5, dev-tools placeholder)

모두 narrative 거명 — 사용자 명시 결정 + 구체 책임 narrative 후 ROADMAP 등재. e3 정책 정합 (propose ≠ apply 분리).

## ROADMAP entry status 갱신 (Stage I 의무)

- 본 milestone (`v4.2 verify-infra-agent-absorption`) status: `in_progress` → `completed`
- next_candidates 6건 = narrative 거명만 (ROADMAP entry 등재 0)

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT: 모두 [`INTENT.md`](INTENT.md) ~ [`REPORT.md`](REPORT.md)
- 본 milestone next_candidates origin 명세: 위 next_candidates[] entry 안 `origin` 필드
- e3 정책 정합 (propose ≠ apply 분리): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝 정체성 paragraph
- bootstrap/agents/ § Audit/Sync 책임: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)

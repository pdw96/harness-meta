---
id: milestone-v4.3-propose
title: PROPOSE v4.3
version: v4.3
stage: PROPOSE
status: completed
---

# PROPOSE — v4.3 subagent-discovery-path-research

## Spec

```json
{
  "next_candidates": [
    {
      "id": "scope-rewrite-pattern-canonicalization",
      "title": "scope rewrite 패턴 정전화 — Stage D 진입 직후 또는 APPROVE 게이트 직전 의문 raise 안 INTENT/RESEARCH 재작성 + scope_rewritten_from 필드 정합 narrative",
      "origin": "v4.3 L1 lesson + v4.1 첫 사례 + v4.3 두 번째 사례 두 cycle 누적 — workflow narrative 안 명시 부재",
      "trigger": "C_improvement",
      "trigger_type": "workflow_self-improvement_narrative",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "v4.0 § 6.2 폐지 narrative 안 workflow self-improvement 자유 발의 — 다만 본 candidate 거명만 (사용자 명시 결정 후 ROADMAP 등재, e3 정책 정합 v4.0/v4.1/v4.2 패턴 누적). 새 정체성 (project harness composer + agent fleet maintainer) 가 자연 가드레일."
    },
    {
      "id": "subagent-runtime-validation-carry-over",
      "title": "v4.3 원래 scope (subagent-runtime-validation) carry-over — v5.0_plugin-pivot 안 두 신규 standalone subagent Plugin 안 거주 + 첫 호출 실 검증 통합",
      "origin": "v4.3 scope rewrite 안 보류 — 원래 v4.2 PROPOSE #2 + #4 bundle (environment-auditor + agents-md-sync 첫 호출 + Junction 인식 ad-hoc 검증)",
      "trigger": "A_user",
      "trigger_type": "runtime_validation_carry-over",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "v5.0_plugin-pivot 안 자연 통합 가능 — Plugin 안 agents/ 자동 인식 후 두 subagent_type 등재 + 첫 호출 검증 자연 흐름. v5.0 EXECUTE phase 안 흡수 가능 (별 milestone 부재 가능)."
    },
    {
      "id": "v4.1-narrative-drift-correction-cascade",
      "title": "v4.1 narrative drift 전체 cascade 정전화 — Junction directory only + .md 파일 영역 SymbolicLink default + copy fallback 동작 narrative 다른 host (root CLAUDE.md / claude/CLAUDE.md / README.md / AGENTS.md) 전파",
      "origin": "v4.3 L4 lesson — bootstrap/agents/CLAUDE.md L63 단일 host 정전화만 진행, 다른 host narrative 안 v4.1 'Junction Windows default' 잔존 거명 가능성",
      "trigger": "C_improvement",
      "trigger_type": "narrative_cascade",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "v5.0_plugin-pivot 안 install narrative cascade 자연 흡수 가능 (Plugin 채택 시 D7 sequence 자체 폐기 narrative 부분, v4.1 narrative 자체는 historical 보존). 별 milestone 부재 가능 — v5.0 phase 안 통합."
    },
    {
      "id": "ask-user-question-round-pattern-narrative",
      "title": "사용자 의문 round depth-first 패턴 narrative — 각 round 답변이 다음 의문 trigger, AskUserQuestion 운영 원칙 확장",
      "origin": "v4.3 L2 lesson — round 2 'symlink' → round 3 'install' → round 4 'install 외 경로' depth-first 진화 패턴 발견",
      "trigger": "C_improvement",
      "trigger_type": "workflow_narrative_extension",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "workflow narrative 안 명시 잠재 — 다만 candidate 거명만 (사용자 명시 결정 후 ROADMAP 등재). § 6.2 폐지 후 자유 발의 패턴 정합."
    },
    {
      "id": "lightweight-mode-trigger-canonicalization",
      "title": "lightweight 모드 trigger 조건 정전화 — scope 작음 ≤5 파일 + RESEARCH 자기 검토 충분 + 의견 충돌 0 예상 + narrative 중심",
      "origin": "v4.3 L5 lesson — lightweight 누적 10/22 = 45.5%, trigger 조건 ad-hoc narrative 부재",
      "trigger": "C_improvement",
      "trigger_type": "workflow_narrative_canonicalization",
      "narrative_only": true,
      "rationale_for_no_roadmap_entry": "v4.0 § 6.2 폐지 후 lightweight 자유 — 다만 trigger 조건 narrative 부재 시 mode 선택 ad-hoc risk. candidate 거명 + 사용자 명시 결정 후 ROADMAP 등재."
    }
  ]
}
```

## PROPOSE summary

v4.3 milestone 의 forward proposal — next_candidates 5건 모두 narrative 거명만 (ROADMAP 등재 0건, e3 정책 정합 v4.0/v4.1/v4.2 패턴 누적). 단일 ROADMAP 등재 = v5.0_plugin-pivot pending entry (DESIGN.D2 + Stage F EXECUTE 시점, 사용자 round 4 (a) 명시 결정). next_candidates origin 통합 분포: (1) L1 scope rewrite 패턴 (#1) / (2) L2 round 패턴 (#4) / (3) L4 v4.1 cascade (#3) / (4) L5 lightweight trigger (#5) / (5) scope rewrite 안 보류 carry-over (#2). 모두 사용자 명시 발의 + 구체 책임 narrative 후 ROADMAP 등재 (e3 정책 정합). v4.0 § 6.2 폐지 후 workflow self-improvement 자유 발의 narrative — 다만 새 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 가 자연 가드레일. 본 milestone 의 핵심 forward = v5.0_plugin-pivot ROADMAP pending entry 등재 (Stage F EXECUTE 안 완료). v4.0 (정체성 pivot) → v4.3 (진단) → v5.0 (적용) 3 단계 cycle 의 두 번째 단계 완료, 세 번째 단계 (v5.0) ROADMAP 표지.

## narrative

v4.3 milestone 의 forward 후속 = 5 candidates narrative 거명만 + 1 ROADMAP entry 등재 (v5.0_plugin-pivot pending, Stage F EXECUTE 시점 완료). 본 milestone 산출물 안 forward propose 책임 단일 source = 본 PROPOSE.md + ROADMAP entry (B/C/D 부산물 통합 흡수, v3.10 정합).

origin 통합 분포:

- L1 scope rewrite 패턴 origin: 1건 (#1)
- L2 사용자 의문 round 패턴 origin: 1건 (#4)
- L4 v4.1 narrative drift cascade origin: 1건 (#3)
- L5 lightweight 모드 trigger origin: 1건 (#5)
- scope rewrite 안 보류 carry-over origin: 1건 (#2) — v4.2 PROPOSE #2 + #4 bundle, v5.0 안 흡수 잠재

모두 narrative 거명 — 사용자 명시 결정 + 구체 책임 narrative 후 ROADMAP 등재. e3 정책 정합 (propose ≠ apply 분리).

## ROADMAP entry status 갱신 (Stage I 의무)

- 본 milestone (`v4.3 subagent-discovery-path-research`) status: `in_progress` → `completed` (Stage I 작업 시점, Stage G+H+I 통합 commit 안 일괄)
- v5.0_plugin-pivot pending entry = Stage F EXECUTE phase-1 안 등재 완료 (status: pending 유지, 사용자 명시 결정 후 in_progress 전환)
- next_candidates 5건 = narrative 거명만 (ROADMAP entry 등재 0)

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT: 모두 [`INTENT.md`](INTENT.md) ~ [`REPORT.md`](REPORT.md)
- 본 milestone next_candidates origin 명세: 위 next_candidates[] entry 안 `origin` 필드 (lessons_learned L1/L2/L4/L5 + scope rewrite carry-over)
- e3 정책 정합 (propose ≠ apply 분리): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝 정체성 paragraph + v4.3 paragraph (Install 정책 본질 + Plugin spec 대안)
- v5.0_plugin-pivot pending entry: [`../../ROADMAP.md`](../../ROADMAP.md) milestones[] 안

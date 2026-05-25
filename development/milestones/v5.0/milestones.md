# v5.0 — plugin-pivot

```json
{
  "version": "v5.0",
  "title": "Install 정책 전면 재설계 — harness-meta 를 Claude Code Plugin 으로 변환 (breaking major bump, ecosystem integrator 정체성 강화)",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "Plugin manifest 신규 + 사용자 onboarding cascade (3 host + hooks.json 신규)",
      "status": "completed",
      "commit": "5505010"
    },
    {
      "phase": 2,
      "title": "내부 narrative cascade — 10 host edit (claude/CLAUDE.md + bootstrap/* + projects/meta/ARCHITECTURE.md + tests/CLAUDE.md + Makefile + .env.example + claude/commands/harness-meta.md + GUARDRAILS.md + bootstrap/claude-code-catalog/README.md + bootstrap/agents/CLAUDE.md)",
      "status": "completed",
      "commit": "e7ec60f"
    },
    {
      "phase": 3,
      "title": "D7 책임 분리 narrative (component-installer.md + team CLAUDE.md) + CHANGELOG [v5.0]! breaking entry + bootstrap/claude-code-catalog/README.md.bak cleanup",
      "status": "completed",
      "commit": "251063e"
    }
  ]
}
```

## 의도 (skeleton)

v4.3_subagent-discovery-path-research RESEARCH 결과 직접 후속. Claude Code Plugin spec 안 plugin marketplace local source + plugin 안 agents/commands/hooks/statusline/skills 자동 인식 = install (~/.claude/{category}/ SymbolicLink/Copy 매핑) 회피 경로 활용 milestone. 두 번째 major bump (v4.0 정체성 pivot 직접 후속).

본 `milestones.md` 는 OPEN 단계 스켈레톤 — Stage D DESIGN 단계 `phases[]` 확정 후 `sub_milestones[]` 1:1 동기 갱신 의무.

## 상세

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) v5.0
- INTENT: `INTENT.md` (Stage B 작성 예정)
- RESEARCH: `RESEARCH.md` (Stage C 작성 예정)
- DESIGN: `DESIGN.md` (Stage D 작성 예정)
- APPROVE: `APPROVE.md` (Stage E 게이트)
- EXECUTE: `execute/phase-{n}.md` (Stage F)
- VERIFY: `VERIFY.md` (Stage G)
- REPORT: `REPORT.md` (Stage H)
- PROPOSE: `PROPOSE.md` (Stage I)

## 선행 milestone

- v4.0_harness-composer-pivot (정체성 pivot, 첫 major bump)
- v4.3_subagent-discovery-path-research (RESEARCH 1차 source, Plugin spec local source 발견)

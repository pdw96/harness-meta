# INTENT — v5.0 plugin-pivot

```json
{
  "id": "v5.0_plugin-pivot",
  "title": "Install 정책 전면 재설계 — harness-meta 를 Claude Code Plugin 으로 변환 (breaking major bump, ecosystem integrator 정체성 강화)",
  "goal": "harness-meta repo 자체를 Claude Code Plugin 으로 변환 (P1 전면 채택) — `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json` 추가 + paths 명시 + 사용자 onboarding flow 를 표준 Claude Code CLI (`claude plugin marketplace add ./harness-meta` + `claude plugin install <name>@harness-meta`) 으로 전환. 현 자연어 'harness-meta 설치해줘' + D7 mechanical sequence (SymbolicLink/Junction/Copy fallback) 폐기. 본 milestone 은 v4.0_harness-composer-pivot (정체성 pivot, 첫 major bump) 의 직접 후속 두 번째 major bump (v4→v5).",
  "motivation": "v4.3_subagent-discovery-path-research RESEARCH 결과 (context7 4 source 검증) 직접 후속 — Claude Code Plugin spec 안 plugin marketplace local source (`./harness-meta` 등 directory path) 지원 + plugin 안 agents/commands/hooks/statusline/skills 자동 인식 + plugin.json paths 명시 으로 임의 위치 (e.g., bootstrap/agents/audit/*.md) 매핑 가능 = install (~/.claude/<category>/ SymbolicLink/Copy 매핑) 회피 경로 단일 발견. v4.0 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 안 'ecosystem integrator' 책임 강화 = Claude Code 표준 메커니즘 (Plugin spec) 채택 정합. 현 install 정책의 trade-off (Developer Mode 의존 / SymbolicLink/Junction OS 분기 narrative / 5 멤버 audit-team 만 배포되고 2 standalone subagent 미배포) 가 Plugin install lifecycle 으로 자연 해소 — plugin install scope 선택 가능 (user/project/local) + enable/disable/uninstall 표준 지원 + Developer Mode 의존 0 (plugin 안 agents/ 자동 인식, SymbolicLink 불요).",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "harness-meta repo root 안 `.claude-plugin/plugin.json` 존재 — manifest 안 paths 명시 (agents/commands/hooks/statusline/skills) 으로 bootstrap/agents/audit/*.md + bootstrap/skills/*/SKILL.md + claude/commands/*.md + claude/hooks/*.sh + claude/statusline/statusline.sh 자동 인식. context7 plugin.json schema 정합."
    },
    {
      "id": "sc_2",
      "criterion": "harness-meta repo root 안 `.claude-plugin/marketplace.json` 존재 — local marketplace 등재 가능. plugin entry (name: harness-meta, version, source) 명시. context7 marketplace.json schema 정합."
    },
    {
      "id": "sc_3",
      "criterion": "사용자 onboarding flow narrative cascade 갱신 — README.md + AGENTS.md + root CLAUDE.md 안 표준 명령 (`claude plugin marketplace add ./harness-meta` + `claude plugin install <name>@harness-meta`) 명시. 현 'harness-meta 설치해줘' 자연어 호출 narrative 폐기 (또는 deprecation 표지)."
    },
    {
      "id": "sc_4",
      "criterion": "component-installer agent (bootstrap/agents/audit/project-harness-audit-team/component-installer.md) 의 D7 sequence narrative 책임 분리 — custom component lifecycle (harness-meta 안 산출물 작성/edit/cleanup) vs Plugin install lifecycle (Claude Code 표준 CLI 명령) 책임 경계 명시. D7 mechanical sequence (Backup → OS detect → Primary attempt by OS → Copy fallback → Cleanup retention) 안 SymbolicLink/Junction/Copy 부분 폐기 또는 deprecation."
    },
    {
      "id": "sc_5",
      "criterion": "v4.0~v4.2 install narrative cascade 전체 정전화 — 영향 host (ARCHITECTURE.md / bootstrap/agents/CLAUDE.md / claude/CLAUDE.md / root CLAUDE.md / README.md / AGENTS.md / GUARDRAILS.md / Makefile / .env.example 등) 안 install (~/.claude/<category>/) symlink/copy narrative 잔존 거명 0 (또는 historical 보존 표지). Stage C RESEARCH 단계 정량 inventory 의무."
    },
    {
      "id": "sc_6",
      "criterion": "두 신규 standalone subagent (environment-auditor + agents-md-sync) 가 Plugin manifest 안 거주 — 현 ~/.claude/agents/ 미배포 상태 자연 해소. plugin install 후 두 subagent_type discovery 정합 (수동 또는 자동 검증)."
    },
    {
      "id": "sc_7",
      "criterion": "5 멤버 audit-team (project-scanner/harness-gap-analyzer/claude-docs-mapper/component-proposer/component-installer) Plugin manifest 안 거주 + 사용자 명시 가능한 migration narrative — 현 ~/.claude/agents/ SymbolicLink 배포 본 milestone 안 cleanup narrative (manual 또는 cleanup CLI 명령 권고) 명시."
    },
    {
      "id": "sc_8",
      "criterion": "CHANGELOG.md 안 [v5.0]! breaking entry — install 정책 전면 재설계 narrative + 사용자 onboarding flow 변경 narrative + deprecation 표지. v4.0 [v4.0]! breaking entry 패턴 정합."
    },
    {
      "id": "sc_9",
      "criterion": "회귀 0 — pre-commit 14 hook 모두 PASS + 기존 5 멤버 audit-team SymbolicLink 작동 부분 유지 (사용자 명시 결정 후 cleanup), workflow self-improvement (9-stage / lightweight / smoke 본문) 변경 0."
    },
    {
      "id": "sc_10",
      "criterion": "ROADMAP entry status: in_progress → completed + milestones_path 정합 + 본 milestone 안 next_candidates ROADMAP 등재 결정 narrative 명시 (PROPOSE 단계)."
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "workflow self-improvement (9-stage 변경 / lightweight trigger 변경 / commit timing 패턴 변경)",
      "rationale_factual": "본 milestone 은 install 정책 재설계 scope — workflow 자체 본질 변경 부재. v4.0 § 6.2 폐지 후 workflow self-improvement 자유 발의 narrative 정합 — 본 milestone 안 workflow 변경 부재 (사실 진술)."
    },
    {
      "id": "oos_2",
      "item": "Plugin Discovery 추가 메커니즘 탐색 (Plugin spec 외 다른 install 우회 경로)",
      "rationale_factual": "v4.3 RESEARCH 결과 = Plugin spec 단일 install 우회 메커니즘. settings.json 안 additional agentsPaths field 부재 (사실 진술). 추가 메커니즘 탐색은 본 milestone scope 밖."
    },
    {
      "id": "oos_3",
      "item": "외부 marketplace 등록 (GitHub source / Git URL / Remote URL)",
      "rationale_factual": "본 milestone scope = local marketplace (`./harness-meta` directory path) 만 — 외부 marketplace 등록 (e.g., GitHub `pdw96/harness-meta` 직접 add) 은 본 milestone 안 미포함. 사실 진술 — 후속 candidate 거명은 PROPOSE 단계 통합 흡수."
    },
    {
      "id": "oos_4",
      "item": "bot 동작 변경 (upbit 등 다른 프로젝트 영향)",
      "rationale_factual": "본 milestone scope = harness-meta repo install 정책 변경. upbit 등 외부 프로젝트는 자체 .harness.toml 안 manifest 만 보유 — 본 milestone 의 Plugin install 메커니즘 영향 부재 (사실 진술)."
    },
    {
      "id": "oos_5",
      "item": "5 멤버 audit-team / 2 standalone subagent 책임 narrative 갱신 (D7 책임 분리 외)",
      "rationale_factual": "본 milestone scope = install 메커니즘 + Plugin manifest 거주. 각 agent 의 책임 narrative (예: project-scanner = read-only scan / component-installer = mechanical apply) 본질 변경 부재 (사실 진술)."
    },
    {
      "id": "oos_6",
      "item": "v4.3 RESEARCH carry-over 외 추가 RESEARCH 본질",
      "rationale_factual": "Plugin spec 본질 (4 source 검증) 은 v4.3 RESEARCH 1차 source 인용. 본 milestone Stage C RESEARCH 는 plugin.json schema 정확 필드 검증 + marketplace.json schema 검증 + cascade host 정량 inventory 추가만 (사실 진술)."
    }
  ],
  "dependencies": {
    "precedes": [],
    "depends_on": [
      {
        "milestone": "v4.3_subagent-discovery-path-research",
        "relation": "RESEARCH 1차 source — context7 4 source 검증 결과 (Plugin spec local source 발견 narrative)"
      },
      {
        "milestone": "v4.0_harness-composer-pivot",
        "relation": "정체성 narrative (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) — 본 milestone 안 ecosystem integrator 책임 강화"
      },
      {
        "milestone": "v4.1_install-strategy-reaudit",
        "relation": "현 install narrative cascade (D7 sequence 5 step OS 분기) — 본 milestone 안 폐기 또는 deprecation 대상"
      },
      {
        "milestone": "v4.2_verify-infra-agent-absorption",
        "relation": "2 standalone subagent (environment-auditor + agents-md-sync) 신규 + verify/sync 6 script 폐기 narrative — 본 milestone 안 두 standalone subagent Plugin 안 거주 narrative 정합"
      }
    ]
  }
}
```

## narrative

본 INTENT 의 핵심 의도 — **harness-meta 를 Claude Code Plugin 으로 변환 (P1 전면 채택)**. v4.3 RESEARCH 결과 Plugin spec 발견 narrative 직접 후속 + v4.0 정체성 안 'ecosystem integrator' 책임 강화 = 본 milestone 의 두 정합 source. breaking major bump (v4→v5) 정전 — v4.0 정체성 pivot (첫 major bump) 와 동일 패턴 후속.

## v3.10 부산물 정책 정합 (out_of_scope 사실 진술)

본 INTENT.out_of_scope 6 entry 모두 **사실 진술** ('본 milestone 의 scope 가 아니다') 형식 — 후속 milestone 발의 표현 (예: '~을 별 milestone 으로 진행하자', '후속 milestone 안 처리') 부재. forward propose 책임은 Stage I (PROPOSE) 단일 source (v3.10 부산물 정책 정합).

## 관련

- v4.3 RESEARCH (1차 source): [`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md) + [`../v4.3/DESIGN.md`](../v4.3/DESIGN.md) + [`../v4.3/PROPOSE.md`](../v4.3/PROPOSE.md)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
- v4.1 install 정책 narrative: [`../v4.1/REPORT.md`](../v4.1/REPORT.md) (D7 sequence 5 step)
- v4.2 standalone subagent 신규: [`../v4.2/REPORT.md`](../v4.2/REPORT.md) (environment-auditor + agents-md-sync)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) milestones[] 안 v5.0_plugin-pivot

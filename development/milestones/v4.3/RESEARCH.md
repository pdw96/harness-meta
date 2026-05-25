---
id: milestone-v4.3-research
title: RESEARCH v4.3
version: v4.3
stage: RESEARCH
status: completed
---

# RESEARCH — v4.3 subagent-discovery-path-research (scope rewritten)

## Spec

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude — sub-agents docs (https://code.claude.com/docs/en/sub-agents)",
      "topic": "Standard subagent discovery 경로",
      "findings": "Claude Code 는 두 위치 안 .md 파일 평면 scan: (1) `~/.claude/agents/` (user scope, global, 모든 프로젝트) + (2) `.claude/agents/` (project scope, CWD walk-up, version-controllable). subagent_type 등록 = .md 파일 yaml frontmatter `name:` 필드. `--add-dir` 디렉토리는 file access grant 만, scan 대상 아님.",
      "drift": "spec 안 추가 discovery 경로 (e.g., settings.json agentsPaths, 환경 변수) 명시 부재 — 표면적으로 두 위치 강제. 그러나 Plugin spec (별 source) 안 plugin install 시 추가 위치 인식 가능 — 다음 source 참조."
    },
    {
      "source": "context7 /websites/code_claude — plugins-reference (https://code.claude.com/docs/en/plugins-reference)",
      "topic": "Plugin 디렉토리 구조 + agents/ 자동 인식",
      "findings": "Plugin 표준 구조 = `.claude-plugin/plugin.json` (manifest) + `agents/<name>.md` (sub-agent 자동 인식, default 디렉토리). 또한 `commands/`, `hooks/`, `statusline/`, `skills/`, `output-styles/`, `themes/`, `monitors/`, `.mcp.json`, `.lsp.json`, `bin/`, `settings.json`, `scripts/` 모두 plugin 안 standard 디렉토리. **plugin.json 안 `agents` 필드** = default 디렉토리 (agents/) 대체 가능, 임의 경로 명시 가능 (예: `./custom-agents/reviewer.md`).",
      "drift": "현 harness-meta repo 구조 (`bootstrap/agents/` + `bootstrap/skills/` + `claude/{commands,hooks,statusline}/`) 는 plugin 표준 구조 (`agents/` + `skills/` + `commands/` + `hooks/` + `statusline/`) 와 prefix 차이만 — paths 명시 (plugin.json 안 agents/commands/hooks/statusline 필드) 시 정합 가능. **즉 현 구조 보존 + plugin manifest 추가만으로 plugin 변환 가능** (Option II 정합)."
    },
    {
      "source": "context7 /websites/code_claude — plugin-marketplaces (https://code.claude.com/docs/en/plugin-marketplaces)",
      "topic": "Plugin marketplace local source 지원",
      "findings": "`claude plugin marketplace add <source>` 안 4 source 지원: (1) GitHub (`acme-corp/claude-plugins`), (2) Git URL (`https://gitlab.example.com/.../plugins.git`), (3) Remote URL (`https://example.com/marketplace.json`), (4) **Local path** (`./my-marketplace`). 즉 `~/harness-meta/` 자체를 local marketplace 으로 등록 가능 — `claude plugin marketplace add ~/harness-meta` (또는 동치). marketplace.json 안 plugin entry 등재 후 `claude plugin install <plugin>@<marketplace>` 으로 install.",
      "drift": "사용자 입장 onboarding flow = `git clone` + `claude plugin marketplace add ./harness-meta` + `claude plugin install <name>@harness-meta-marketplace` — 현 'harness-meta 설치해줘' 자연어 호출 + 메인 Claude D7 sequence 보다 명확 (Claude Code CLI 표준 명령). install scope 선택 가능 (`-s user/project/local`)."
    },
    {
      "source": "context7 /websites/code_claude — plugins-reference (claude plugin install command)",
      "topic": "Plugin install scope + lifecycle",
      "findings": "`claude plugin install <plugin> [options]` 안 `--scope` (default `user`) — `user` (전체 사용자, `~/.claude/`) / `project` (현 프로젝트, `.claude/settings.json` 안 share) / `local` (현 프로젝트, gitignored). 또한 plugin uninstall / enable / disable / list 모두 표준 CLI 명령 지원.",
      "drift": "현 harness-meta 의 'install' (~/.claude/<category>/<name>/ symlink 또는 copy) 본질 = `user` scope plugin install 정합. project scope (`.claude/settings.json` 안 share) 도 잠재 (예: harness-meta 자체가 plugin 으로 install 후 .claude/settings.json 안 enabled-plugins 정전화) — 사용자가 직접 결정 가능. drift 회피 (symlink) vs project share 가능성 (plugin) 두 trade-off."
    },
    {
      "source": "context7 /websites/code_claude — settings docs (https://code.claude.com/docs/en/settings)",
      "topic": "Settings 안 plugin marketplace + subagent 구성",
      "findings": "settings.json 안 subagent 표준 구성 = `~/.claude/agents/` (user) + `.claude/agents/` (project) — additional path field 부재. 그러나 marketplace 구성 (Git source / Directory source) 은 settings.json 안 가능 — `{ \"source\": \"directory\", \"path\": \"/opt/acme-corp/approved-marketplaces\" }`.",
      "drift": "settings.json 안 추가 agentsPaths 명시 부재 — Plugin spec 가 유일한 install 우회 메커니즘 (또는 ~/.claude/agents/ 안 직접 symlink/copy 만). 즉 install 외 경로 후보 = **Plugin spec 단일**."
    }
  ],
  "codebase": {
    "current_state_install": "현 harness-meta install 정책 (v4.0~v4.2):\n- bootstrap/agents/audit/ + bootstrap/skills/<category>/ + claude/{commands,hooks,statusline}/ source-of-truth (git tracked).\n- `~/.claude/<category>/` 안 SymbolicLink (Windows Developer Mode 활성) 또는 Copy fallback (D7 step 4).\n- component-installer agent (D7 sequence 5 step) 안 mechanical 흡수 (v4.0 phase-5/B3).\n- 5 멤버 audit-team SymbolicLink 작동 확인 (lrwxrwxrwx, Developer Mode=1).\n- 2 신규 standalone subagent (environment-auditor + agents-md-sync) ~/.claude/agents/ 안 미배포 (v4.2 phase-1 source 만, deployment 부재).",
    "current_state_drift": "v4.1 narrative drift (.md 파일 영역 Junction 불가능 — Junction = directory only spec drift + SymbolicLink default 미명시) + v4.0/4.1 narrative 안 install 본질 정당성 진술 부족 — 사용자 의문 본질 (왜 install 인가, 어떤 trade-off, 대안 부재 근거).",
    "potential_changes_lightweight": [
      "(a) ARCHITECTURE.md 안 install 정책 narrative 정전화 (Why install / Plugin spec 대안 / trade-off) — Lightweight 1줄~1 paragraph",
      "(b) bootstrap/agents/CLAUDE.md 안 D7 sequence 정정 (.md 파일 영역 SymbolicLink default + Junction = directory only spec drift 명시) — Lightweight 1줄~1 paragraph",
      "(c) ROADMAP entry 안 후속 milestone (v4.4 또는 v5.0_plugin-pivot) 발의 narrative"
    ],
    "potential_changes_v4.4_or_v5.0_carry-over": [
      "harness-meta 안 `.claude-plugin/plugin.json` 추가 + paths 명시 (현 구조 보존 + plugin manifest 만 추가)",
      "harness-meta 안 `.claude-plugin/marketplace.json` 추가 — local marketplace 등록 가능",
      "사용자 onboarding 문서 갱신 (README/AGENTS/root CLAUDE.md) — `claude plugin marketplace add ./harness-meta` + `claude plugin install ...` 표준 flow",
      "v4.0/4.1/4.2 install narrative cascade 전체 정전화",
      "두 신규 standalone subagent (environment-auditor + agents-md-sync) plugin 안 거주 (현 SymbolicLink 미배포 자연 해소)"
    ],
    "untouched_files_explicit_for_this_milestone": [
      "claude/commands/harness-meta.md — workflow 정의 본문 (본 milestone 은 workflow self-improvement 가 아님)",
      "tests/smoke-*.sh — smoke 회귀 0 보장 외 변경 부재",
      ".pre-commit-config.yaml — 신규 hook 추가 부재",
      "bootstrap/agents/audit/{environment-auditor,agents-md-sync}.md — source 변경 부재 (deployment 결정 carry-over)",
      "5 멤버 audit-team SymbolicLink — 본 milestone 안 재배포 부재 (사실 진술)"
    ]
  },
  "options": [
    {
      "id": "P1",
      "title": "Plugin spec 채택 — harness-meta 자체를 plugin 으로 변환 (전면)",
      "approach": "harness-meta 안 .claude-plugin/plugin.json + .claude-plugin/marketplace.json 추가 + 현 구조 (bootstrap/ + claude/) 보존 + plugin.json 안 paths 명시 (예: `agents: ['./bootstrap/agents/audit/*.md']` 또는 default 디렉토리 정합 'agents/' 재구성). install script 3개 폐기 narrative 후속 완성 (v4.0 phase-3 B3 의 자연 후속).",
      "pros": [
        "Claude Code 표준 메커니즘 (Plugin spec, ecosystem integrator 정체성 정합)",
        "사용자 onboarding 표준 (`claude plugin install`)",
        "Developer Mode 의존 0 (Plugin 안 agents/ 자동 인식, SymbolicLink 불요)",
        "install scope 선택 가능 (user/project/local)",
        "plugin lifecycle (enable/disable/uninstall) 표준 지원"
      ],
      "cons": [
        "Breaking change (v5.0 잠재 major bump)",
        "현 install narrative cascade 전체 재작성",
        "사용자 onboarding flow 변경 (자연어 'harness-meta 설치해줘' → CLI 명령)",
        "Plugin spec 안 paths 명시 narrative 정합 필요"
      ]
    },
    {
      "id": "P2",
      "title": "Plugin spec 점진 채택 — .claude-plugin/plugin.json 추가 + 현 install 메커니즘 보존 (병행)",
      "approach": ".claude-plugin/plugin.json 추가 + paths 명시 + 사용자 결정 후 plugin install 가능 (옵션). 현 자연어 'harness-meta 설치해줘' + D7 sequence 도 보존 (deprecation 없이 dual). v4.4 안 점진 cascade.",
      "pros": [
        "Breaking change 부재 (v4.4 minor bump)",
        "현 install narrative 보존",
        "사용자 선택권 보유 (자연어 install vs Plugin install)",
        "점진 도입 — Plugin 적응 후 D7 narrative 폐기 별 milestone"
      ],
      "cons": [
        "이중 구조 (현 install + Plugin) — 사용자 혼란",
        "narrative 정합 부담 (두 경로 narrative 균형)",
        "최종 단순화 (Plugin only) 까지 추가 cycle 필요"
      ]
    },
    {
      "id": "P3",
      "title": "현 install 정책 유지 + narrative 정전화만 (Plugin 채택 안 함)",
      "approach": "Plugin spec 도입 부재 + v4.1 narrative drift 정전화 (.md 파일 영역 SymbolicLink + Junction = directory only + copy fallback narrative). install 본질 narrative 정전화 (Why ~/.claude/agents/ 매핑, trade-off).",
      "pros": [
        "현 구조 그대로",
        "narrative 정합도만 보강",
        "breaking change 부재"
      ],
      "cons": [
        "사용자 의문 본질 (install 회피 경로 탐색) 부분 해소만",
        "Developer Mode 의존 narrative 그대로",
        "ecosystem integrator 정체성 약화 (Plugin spec 미활용)"
      ]
    },
    {
      "id": "P4",
      "title": "본 v4.3 = RESEARCH 결과 정전화만 + Plugin 채택 자체는 별 milestone (v5.0_plugin-pivot) 후속",
      "approach": "본 v4.3 안 RESEARCH 결과 narrative + DESIGN 안 후속 milestone (v5.0_plugin-pivot 또는 v4.4_install-path-canonicalization) 설계 + ROADMAP entry (pending 또는 narrative 거명만) — 실 적용 부재.",
      "pros": [
        "본 v4.3 의 'RESEARCH + 경로 발견' 본질 정합 (사용자 결정 (I) 정합)",
        "후속 milestone 명확 분리",
        "Plugin 채택 실 결정 carry-over (사용자 깊은 검토 시간 보유)"
      ],
      "cons": [
        "본 v4.3 EXECUTE 산출물 작음 (narrative 정전화 1-phase Lightweight)",
        "carry-over milestone 등재 결정 필요"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "description": "Plugin spec 안 paths 명시 시 현 구조 (bootstrap/agents/audit/{environment-auditor,agents-md-sync}.md + bootstrap/agents/audit/project-harness-audit-team/<member>.md) 의 sub-디렉토리 안 거주 패턴 — plugin.json `agents` 필드 안 glob 또는 multiple paths 명시 가능 여부 확인 필요 (context7 1차 검증 안 명시).",
      "severity": "medium",
      "mitigation_hint": "context7 추가 검증 또는 후속 milestone 안 실 적용 시 확인 (본 RESEARCH 단계 narrative 거명)."
    },
    {
      "id": "R2",
      "description": "Plugin install 시 ~/.claude/ 안 정확한 디렉토리 구조 (e.g., ~/.claude/plugins/<plugin-name>/agents/) — 현 5 멤버 SymbolicLink (~/.claude/agents/<member>.md) 와 다른 위치 가능. 사용자 환경 안 둘 공존 가능 여부 확인 필요.",
      "severity": "medium",
      "mitigation_hint": "Plugin install scope user 시 ~/.claude/plugins/ 안 plugin 거주 추정 — context7 추가 검증 또는 후속 milestone 안 실 검증."
    },
    {
      "id": "R3",
      "description": "Plugin 채택 시 v4.0 정체성 narrative ('static install script 부재, agent 흡수') 와 충돌 — Plugin install 은 CLI 명령 (`claude plugin install`) 안 mechanical 작업. 즉 component-installer agent 역할 일부 (D7 sequence) 가 CLI 명령으로 대체. narrative 정합 필요.",
      "severity": "low",
      "mitigation_hint": "후속 milestone 안 narrative 정전화 — 'component-installer = harness-meta 안 component 의 lifecycle 관리 (custom)' + 'Plugin install = Claude Code 표준 lifecycle (CLI 명령)' 책임 분리. 둘 다 정합 가능."
    },
    {
      "id": "R4",
      "description": "본 milestone 자체 산출물 안 forward propose 명령형 — v3.10 부산물 정책 위반 risk. INTENT/RESEARCH/DESIGN 안 '후속 milestone v4.4/v5.0' 거명 narrative 안 'forward propose 명령형' (예: '~을 별 milestone 으로 진행하자') 회피 의무.",
      "severity": "low",
      "mitigation_hint": "사실 진술만 사용 ('본 milestone 의 범위가 아니다' 또는 '후속 milestone 발의 narrative' 명시). PROPOSE 단계 안 단일 source 통합 흡수."
    },
    {
      "id": "R5",
      "description": "scope rewrite 두 번째 사례 — workflow 흐름 안 scope rewrite 패턴 누적. v4.1 의 첫 사례 (APPROVE 게이트 직전 의문 raise → 폐기) vs 본 v4.3 의 두 번째 사례 (Stage D 진입 직후 의문 raise → INTENT/RESEARCH 재작성). 패턴 자체 narrative 정전화 잠재 후속 (v2.0 word-fidelity → scope rewrite 패턴 narrative 필요).",
      "severity": "low",
      "mitigation_hint": "후속 milestone 안 'scope rewrite 패턴 정전화' candidate 거명 가능 (또는 본 milestone PROPOSE 안 narrative 거명)."
    }
  ]
}
```

## narrative

본 RESEARCH 의 핵심 발견 = **Claude Code Plugin spec 안 plugin marketplace local source 지원** + **plugin 안 agents/ 자동 인식 메커니즘** — install (~/.claude/agents/ 매핑) 회피 경로 발견. context7 4 source 검증 (sub-agents docs / plugins-reference / plugin-marketplaces docs / plugin install CLI / settings docs) 결과 일관 narrative.

→ INTENT.success_criteria 1번 (RESEARCH 결과 1건 이상 발견 + 검증 narrative) **PASS** (Plugin spec 발견 + 4 source primary 검증).

## options 비교 narrative

P4 (RESEARCH 결과 정전화만 + 후속 milestone) 가 **사용자 결정 (I) 정합** — 본 v4.3 = '진단 + 경로 발견' milestone, 실 적용 carry-over. P1 (전면) / P2 (점진) / P3 (현 유지) 는 후속 milestone 안 결정.

DESIGN 단계 안 narrative:

- **D1**: P4 채택 (사용자 결정 (I) 정합) — 본 v4.3 lightweight (RESEARCH 결과 narrative 정전화 + 후속 milestone 설계).
- **D2**: 후속 milestone 발의 — v4.4_plugin-research-application (P2 점진) 또는 v5.0_plugin-pivot (P1 전면) — DESIGN 안 trade-off 분석 + ROADMAP 등재 결정.
- **D3**: 본 v4.3 EXECUTE 산출물 = (1) ARCHITECTURE.md 안 install 정책 narrative 정전화 (Why install + Plugin spec 대안 + trade-off) 1 paragraph + (2) bootstrap/agents/CLAUDE.md 안 D7 sequence 정정 (.md 파일 영역 SymbolicLink default + Junction directory only spec drift) — Lightweight 1-phase.
- **D4**: 3 관점 검토 (scope 작음 ≤5 파일 → architecture / spec-drift / scope contract). v4.0 § 6.2 폐지 후 lightweight 모드 자유.

## DESIGN 단계 결정 게이트 (예고)

- D1: option (P1~P4) 채택 — 본 RESEARCH 안 P4 권장 (사용자 결정 (I) 정합), 사용자 명시 결정 게이트 (Stage E APPROVE 안 명시)
- D2: 후속 milestone 발의 — v4.4 (점진) vs v5.0 (전면) — narrative 거명만 (ROADMAP 미등재) vs pending entry 등재 결정
- D3: 본 v4.3 phase 분할 — 1-phase Lightweight (narrative 정전화) vs 2-phase (narrative 정전화 + ROADMAP 등재 분리)
- D4: 3 관점 검토 (architecture / spec-drift / scope contract)

## 관련

- INTENT (scope rewrite 후): [`INTENT.md`](INTENT.md)
- v4.2 PROPOSE 원래 origin (carry-over): [`../v4.2/PROPOSE.md`](../v4.2/PROPOSE.md) `next_candidates` #2 + #4
- v4.1 narrative drift: [`../v4.1/REPORT.md`](../v4.1/REPORT.md) (Option D narrative + D7 sequence)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
- context7 primary source: `/websites/code_claude` library
  - sub-agents: `https://code.claude.com/docs/en/sub-agents`
  - plugins-reference: `https://code.claude.com/docs/en/plugins-reference`
  - plugin-marketplaces: `https://code.claude.com/docs/en/plugin-marketplaces`
  - settings: `https://code.claude.com/docs/en/settings`

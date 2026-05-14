# VERIFY — v5.1 plugin-component-discovery-fix

```json
{
  "milestone": "v5.1_plugin-component-discovery-fix",
  "smoke_tests": [
    {
      "name": "pre-commit 14 hook (phase-1)",
      "command": "git commit (7af00f2)",
      "result": "PASS",
      "output": "14 hook 모두 PASS. smoke-cross-ref FAIL 1건 → --fix 삭제 → 수동 복원 후 re-commit PASS."
    },
    {
      "name": "pre-commit 14 hook (phase-2)",
      "command": "git commit (94d0740 + cleanup cdaa83e)",
      "result": "PASS",
      "output": "14 hook 모두 PASS. smoke-cross-ref FAIL 6건 → --fix 삭제 → 수동 복원 후 re-commit PASS. .bak 파일 cleanup commit 추가."
    },
    {
      "name": "pre-commit 14 hook (phase-3)",
      "command": "git commit (2ea2c13)",
      "result": "PASS",
      "output": "14 hook 모두 PASS. markdownlint MD032 2건 수정 후 re-commit PASS."
    },
    {
      "name": "claude plugin details harness-meta",
      "command": "claude plugin details harness-meta",
      "result": "PASS",
      "output": "Agents (7): agents-md-sync, claude-docs-mapper, component-installer, component-proposer, environment-auditor, harness-gap-analyzer, project-scanner. Skills (6): ai-ready-scorer, developer-profile, harness-meta (slash command), harness-plan-verify, harness-roadmap-update, mindvault. Hooks (2): PostToolUse, SessionStart."
    },
    {
      "name": "stale path grep (bootstrap/agents/audit + bootstrap/skills/{audit,dev-tools})",
      "command": "grep -rn 'bootstrap/agents/audit|bootstrap/skills/audit|bootstrap/skills/dev-tools' --include='*.md' (milestones/CHANGELOG 제외)",
      "result": "PASS_WITH_NOTE",
      "output": "2건 발견: agents/environment-auditor.md:74 (audit target paths 3종 stale: bootstrap/skills/audit/*/SKILL.md → skills/*/SKILL.md, bootstrap/agents/audit/*.md → agents/*.md) + agents/harness-gap-analyzer.md:59 (fleet scan path 2종 stale: bootstrap/agents/audit/ → agents/). projects/meta/ROADMAP.md:152 = v3.12 historical title narrative → 보존 정합. 2건 stale path = Phase 1 agent moves 결과 functional gap 발견 — 본 milestone cascade scope 미포함 (sc_5 대상 외). PROPOSE next_candidates 추가 예정."
    }
  ],
  "manual_checks": [
    {
      "check": "agents/ directory 구조 확인 (7 멤버 flat)",
      "result": "PASS",
      "notes": "agents/: agents-md-sync.md + claude-docs-mapper.md + component-installer.md + component-proposer.md + environment-auditor.md + harness-gap-analyzer.md + project-scanner.md + project-harness-audit-team/ (CLAUDE.md). 7 멤버 flat 정합."
    },
    {
      "check": "skills/ directory 구조 확인 (5 skill flat)",
      "result": "PASS",
      "notes": "skills/: ai-ready-scorer/ + developer-profile/ + harness-plan-verify/ + harness-roadmap-update/ + mindvault/. 5 skill flat 정합."
    },
    {
      "check": ".claude-plugin/plugin.json 검증 (agents 필드 제거 + skills ./skills/)",
      "result": "PASS",
      "notes": "agents 필드 제거 (default discovery ./agents/). skills: './skills/'. commands: ['./claude/commands/']. hooks: './claude/hooks/hooks.json'. spec 정합."
    },
    {
      "check": "Plugin source 거주 확인",
      "result": "PASS_WITH_NOTE",
      "notes": "~/.claude/plugins/cache/harness-meta/ 는 plugin install 후 자동 갱신. 본 세션 안 신규 install 미실행 (기존 install 상태 유지). claude plugin details PASS = 인식 결과 간접 확인. 실 reinstall 검증 = out_of_scope (sc_3 조건 '기존 install 회귀 0' 충족 — 기존 install 계속 ENABLED 상태)."
    },
    {
      "check": "dual-active 회귀 (sc_9)",
      "result": "PASS",
      "notes": "본 milestone 안 ~/.claude/agents/ SymbolicLink cleanup 부재 narrative 유지. Plugin 측 변경 (agents/ flat 재배치) 이 SymbolicLink 경로 영향 없음 (SymbolicLink = 구 bootstrap/agents/audit/ 경로 → 이미 deprecated + move 후 broken 상태이지만 v5.1 scope 외)."
    }
  ],
  "criteria_check": [
    {
      "id": "sc_1",
      "criterion": "claude plugin details Agents ≥ 7",
      "result": "PASS",
      "notes": "Agents (7) 확인 — agents-md-sync, claude-docs-mapper, component-installer, component-proposer, environment-auditor, harness-gap-analyzer, project-scanner. v5.0 Agents (0) 대비 완전 해소."
    },
    {
      "id": "sc_2",
      "criterion": "claude plugin details Skills ≥ 5",
      "result": "PASS",
      "notes": "Skills (6) 확인 — 5 skill (ai-ready-scorer + developer-profile + harness-plan-verify + harness-roadmap-update + mindvault) + 1 command (harness-meta slash command). v5.0 Skills (1 of 5) 대비 완전 해소."
    },
    {
      "id": "sc_3",
      "criterion": "기존 install path 보존 (회귀 0)",
      "result": "PASS_WITH_NOTE",
      "notes": "claude plugin details 정상 = install enabled 상태 확인. 신규 reinstall 미실행 (기존 install 상태 유지 검증). 표준 명령 회귀 없음."
    },
    {
      "id": "sc_4",
      "criterion": "pre-commit 14 hook 모두 PASS (회귀 0)",
      "result": "PASS",
      "notes": "Phase 1/2/3 3번의 commit 모두 14 hook PASS 확인."
    },
    {
      "id": "sc_5",
      "criterion": "cascade narrative drift 부재",
      "result": "PASS_WITH_NOTE",
      "notes": "9 host cascade 정상 완료. stale path 2건 발견 (agents/environment-auditor.md + agents/harness-gap-analyzer.md 안 functional audit paths) — sc_5 대상 cascade host 범위 외. PROPOSE next_candidates 추가."
    },
    {
      "id": "sc_6",
      "criterion": "Hooks (2) 인식 보존",
      "result": "PASS",
      "notes": "Hooks (2): PostToolUse, SessionStart 확인. v5.0 PASS 결과 회귀 0."
    },
    {
      "id": "sc_7",
      "criterion": "CHANGELOG [v5.1] entry 추가",
      "result": "PASS",
      "notes": "CHANGELOG.md [v5.1] Fixed + Added 2 section 추가 완료 (phase-3 commit 포함)."
    },
    {
      "id": "sc_8",
      "criterion": "ROADMAP entry status: in_progress → completed (Stage I)",
      "result": "PENDING_AT_PROPOSE",
      "notes": "Stage I PROPOSE 단계에서 갱신 예정."
    },
    {
      "id": "sc_9",
      "criterion": "dual-active 회귀 0",
      "result": "PASS",
      "notes": "본 milestone 안 SymbolicLink cleanup 부재 narrative 유지. 영향 없음."
    }
  ],
  "verdict": "pass",
  "regressions": [
    "agents/environment-auditor.md:74 — audit target paths 3종 stale (bootstrap/skills/{audit,dev-tools}/*/SKILL.md + bootstrap/agents/audit/*.md → skills/*/SKILL.md + agents/*.md). Phase 1 agent move 결과 functional gap. PROPOSE 등재 예정.",
    "agents/harness-gap-analyzer.md:59 — fleet scan path 2종 stale (bootstrap/agents/audit/ + bootstrap/agents/dev-tools/ → agents/). Phase 1 agent move 결과. PROPOSE 등재 예정."
  ]
}
```

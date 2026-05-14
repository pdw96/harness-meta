# REPORT — v5.1 plugin-component-discovery-fix

```json
{
  "milestone": "v5.1_plugin-component-discovery-fix",
  "verdict": "pass",
  "summary": "v5.0 VERIFY R1 drift (claude plugin details Agents 0 / Skills 1 of 5) 를 3 phase 로 완전 해소. Phase 1: 7 agents git mv (bootstrap/agents/audit/ → agents/ flat, plugin_root standard). Phase 2: 5 skills git mv (bootstrap/skills/{audit,dev-tools}/ → skills/ flat, 1단계 flat). Phase 3: 9 host cascade narrative 갱신 + CHANGELOG [v5.1]. 결과 = claude plugin details Agents (7) + Skills (6 = 5 skill + 1 command) + Hooks (2) 완전 인식. pre-commit 14 hook 3 commit 모두 PASS. v5.0 R1 mitigation 'Stage G VERIFY 실 검증 mandatory' 패턴 정합 두 번째 cycle 완성.",
  "delta": {
    "files_changed": 21,
    "files_added": 12,
    "files_deleted": 0,
    "modules_affected": [
      "agents/ (신규 — 7 멤버 flat, plugin_root standard)",
      "skills/ (신규 — 5 skill flat, plugin_root standard)",
      ".claude-plugin/plugin.json (agents 필드 제거 + skills 경로 갱신)",
      "bootstrap/agents/ (narrative-only container 전환)",
      "bootstrap/skills/ (narrative-only container 전환)",
      "cascade 9 host (CLAUDE.md root + AGENTS.md + GUARDRAILS.md + claude/CLAUDE.md + ARCHITECTURE.md + bootstrap/{agents,skills}/CLAUDE.md + claude-code-catalog/README.md + CHANGELOG.md)"
    ],
    "commits": [
      "7af00f2 — Phase 1: 7 agents flat (git mv + plugin.json agents 필드 제거 + internal paths fix 5건)",
      "94d0740 — Phase 2: 5 skills flat (git mv + plugin.json skills 갱신)",
      "cdaa83e — Phase 2 cleanup: .bak 파일 제거",
      "2ea2c13 — Phase 3: cascade narrative 9 host + CHANGELOG [v5.1]"
    ]
  },
  "lessons_learned": [
    "L1: Plugin spec default discovery (agents/ flat) vs paths 명시 (배열 개별) trade-off — default discovery 채택 시 paths array 관리 부재 + spec 정합 동시 달성. 신규 subagent 추가 시 agents/<name>.md 작성만으로 자동 인식 (plugin.json 갱신 불요).",
    "L2: smoke-cross-ref --fix 삭제 패턴 재확인 — Phase 1 (1건) + Phase 2 (6건) 연속 발생. git mv 후 MD 내부 링크는 자동 갱신 불가 → 수동 복원 의무. DESIGN D6 A2 assumption 충족 사전 명시 효과 (회귀 아님 판정).",
    "L3: .bak 파일 unintended staging 패턴 재발 (Phase 2) — git add 전 git status 확인 의무. cleanup commit 패턴 (Phase 2 cdaa83e) 정착.",
    "L4: markdownlint MD032 (blanks-around-lists) — bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md 2건 Phase 3 commit 시 재발. 목록 앞 빈 줄 규약 의무 재확인.",
    "L5: agents/environment-auditor.md + agents/harness-gap-analyzer.md 안 functional audit path 2건 stale 발견 (Phase 1 agent move 결과) — cascade narrative scope 에 agent 내부 functional path 포함 의무 표지. v5.2 cleanup 후보.",
    "L6: claude plugin details Skills 카운트에 slash command 포함 — Skills (6) = 5 skill + 1 command (harness-meta). 이는 Claude Code Plugin spec 안 commands 와 skills 가 Claude-facing 동일 category 로 표시되는 스펙. sc_2 '≥ 5' 조건 정합 (6 ≥ 5 PASS)."
  ]
}
```

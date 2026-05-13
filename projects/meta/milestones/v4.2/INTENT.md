# INTENT — v4.2 verify-infra-agent-absorption

```json
{
  "id": "v4.2_verify-infra-agent-absorption",
  "title": "verify/sync infrastructure agent 흡수 검토 — verify.{ps1,sh} + verify-lib.{ps1,sh} + sync-agents.{ps1,sh} 폐기 후 agent (component-installer 또는 신규 subagent) 흡수",
  "goal": "verify/sync 6 script (verify.{ps1,sh} + verify-lib.{ps1,sh} + sync-agents.{ps1,sh}) 의 'mechanical' 본질 (환경 헬스 체크 + agent 동기화) 을 component-installer 또는 신규 subagent 안 흡수 가능성 검토 + 흡수/유지/일부 흡수 결정 + 실 흡수 실행 (script 폐기 + agent 신규 또는 확장 + cascade narrative cleanup) 까지 동일 milestone bundling. v4.0 정체성 ('project harness composer + agent fleet maintainer' + 'mechanical install/update/cleanup 도 agent 흡수') 확장.",
  "motivation": "v4.0_harness-composer-pivot phase-3 안 install script 3개 (install.ps1 + install-skills.{ps1,sh}) 가 폐기되었으나, 동일 'mechanical' 본질을 공유하는 verify/sync 6 script 는 잔존. v4.0 정체성 narrative 의 'mechanical install/update/cleanup' 안 'verify (환경 헬스 체크)' + 'sync (agent 동기화)' 도 포괄 — 정합 확장 후보. v4.1_install-strategy-reaudit 가 D7 5 step sequence 안 mechanical 작업 (backup → OS detect → primary attempt → copy fallback → cleanup retention) 을 component-installer 안 흡수한 패턴 (실 흡수 실행 동일 milestone bundling) 정합. § 6.2 폐지 (v4.0 안) → workflow self-improvement 자유 발의 정합. 사용자 명시 발의 (A_user, 2026-05-13 v4.1 종료 후 round 안 'verify/sync 도 폐기 신규 milestone 발의' 명시 선택).",
  "success_criteria": [
    {
      "id": "sc_1",
      "description": "verify/sync 6 script inventory + 책임 매트릭스 명문화 (각 script 의 check/operation 갯수 + 책임 영역 + agent 흡수 가능성 분류). 1차 source = RESEARCH.codebase.affected_files",
      "verification": "RESEARCH.md 안 6 script 별 check 갯수 + 책임 영역 정량 (e.g., verify.ps1: 30+ check 매트릭스 / sync-agents.ps1: bootstrap/agents/<host> 디렉토리 sync 책임)"
    },
    {
      "id": "sc_2",
      "description": "각 script 별 흡수/유지/일부 흡수 결정 (총 6 결정). 흡수 결정 시 host agent (component-installer 확장 vs 신규 subagent) + tool catalog 등재 위치 명시",
      "verification": "DESIGN.decisions[] 안 6 script 별 결정 entry + rationale + alternatives_rejected"
    },
    {
      "id": "sc_3",
      "description": "Claude Code hook (session-init.sh / post-report-write.sh) + statusline (statusline.sh) 책임 분리 narrative 명문화 — 실 실행 컴포넌트 (bash/PowerShell, Claude Code spec 의무) 는 agent 흡수 불가능, verify/sync 와 본질 분리. ARCHITECTURE.md 또는 claude/CLAUDE.md 단일 source",
      "verification": "ARCHITECTURE.md 또는 claude/CLAUDE.md 안 'mechanical 본질 vs Claude Code spec 의무 컴포넌트' 분리 paragraph 1건 정전화"
    },
    {
      "id": "sc_4",
      "description": "흡수 결정 script 의 실 실행 — script 파일 폐기 (git rm) + agent (component-installer 확장 또는 신규 subagent) 정의 갱신 + tool catalog (bootstrap/claude-code-catalog/README.md 또는 bootstrap/agents/CLAUDE.md) 등재",
      "verification": "phase-{n} commit 안 script 파일 git rm + agent 파일 (bootstrap/agents/<category>/<name>/AGENT.md 또는 CLAUDE.md) 갱신 또는 신규"
    },
    {
      "id": "sc_5",
      "description": "cascade narrative cleanup — verify/sync 거명 host (README.md / AGENTS.md / CLAUDE.md root / claude/CLAUDE.md / GUARDRAILS.md / Makefile / .env.example / ARCHITECTURE.md / bootstrap/agents/CLAUDE.md / bootstrap/skills/CLAUDE.md / 6 script 자체 narrative) 정합 갱신. v4.1 12 host pattern 정합",
      "verification": "grep 패턴 (verify\\.ps1|verify\\.sh|verify-lib|sync-agents) cascade host 전수 검증 + 폐기 script 거명 0 (또는 historical 보존 명시)"
    },
    {
      "id": "sc_6",
      "description": "smoke 회귀 0 — pre-commit 14 hook 모두 PASS + 회귀 0건",
      "verification": "pre-commit 14 hook 출력 + git diff main..HEAD 안 smoke FAIL 0"
    },
    {
      "id": "sc_7",
      "description": "VERIFY.criteria_check 안 본 success_criteria 7건 1:1 매핑 PASS",
      "verification": "VERIFY.md 안 criteria_check entry 7건 PASS"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "description": "Claude Code hook (session-init.sh / post-report-write.sh) + statusline (statusline.sh) 자체 폐기 — 실 실행 컴포넌트, Claude Code spec 의무. 본 milestone 은 책임 분리 narrative 만 명문화 (sc_3)",
      "fact_only_statement": "본 milestone 은 hook/statusline 폐기 milestone 이 아니다 — 실 실행 컴포넌트 본질 차이 (Claude Code spec)"
    },
    {
      "id": "oos_2",
      "description": "upbit 등 외부 projects/<name>/ 안 verify/sync 영향 — 외부 적용은 별 milestone (외부 적용 사용자 명시 발의 또는 § 6.2 trigger 충족 시 발의)",
      "fact_only_statement": "본 milestone 은 meta scope 만 — upbit 등 외부 projects/<name>/ 영향 milestone 아니다"
    },
    {
      "id": "oos_3",
      "description": "v4.0 phase-3 안 폐기된 install script 3개 (install.ps1 + install-skills.{ps1,sh}) 추가 정리 — v4.1 phase-2 안 stale 9건 cleanup 완료, 본 milestone 추가 정리 부재",
      "fact_only_statement": "본 milestone 은 v4.0 phase-3 install script 폐기 + v4.1 phase-2 cleanup 후속 cleanup milestone 아니다"
    },
    {
      "id": "oos_4",
      "description": "9-stage workflow 자체 변경 — § 6.2 폐지 후 workflow self-improvement 자유 발의이나 본 milestone 은 verify/sync infrastructure 영역 한정",
      "fact_only_statement": "본 milestone 은 9-stage workflow 변경 milestone 아니다 — agent fleet 확장 milestone"
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "milestone": "v4.0_harness-composer-pivot",
      "relation": "선행",
      "description": "v4.0 정체성 정의 (project harness composer + agent fleet maintainer + 'mechanical install/update/cleanup agent 흡수' narrative) + § 6.2 폐지 + bootstrap/agents/ scaffold + project-harness-audit-team 5 멤버 + component-installer (D7 sequence host) — 본 milestone 의 'agent 흡수' 기반"
    },
    {
      "id": "dep_2",
      "milestone": "v4.1_install-strategy-reaudit",
      "relation": "선행",
      "description": "v4.1 안 D7 5 step sequence rewrite (Backup → OS detect → Primary attempt by OS → Copy fallback → Cleanup retention) — verify/sync 흡수 시 동일 sequence 패턴 적용 가능. cascade narrative 12 host 정합 패턴 정합"
    }
  ]
}
```

## narrative

본 milestone 은 v4.0 정체성 ('project harness composer + agent fleet maintainer') 정합 확장 — v4.0 phase-3 안 폐기된 install script 3개 외 'mechanical' 본질을 공유하는 verify/sync 6 script (verify.{ps1,sh} + verify-lib.{ps1,sh} + sync-agents.{ps1,sh}) 의 agent 흡수 가능성 검토 + 결정 + 실 흡수 실행 까지 동일 milestone bundling.

scope 선택 (검토 + 결정 + 실 흡수 실행, 사용자 명시 결정 1차) — v4.1 패턴 (D7 sequence rewrite 실 실행 동일 milestone bundling) 정합. analysis-only 후속 분리 옵션 거부 (v4.0 phase-3 install 폐기 패턴 = 결정 + 실행 동일 milestone).

검토 + 결정 + 실 흡수 실행 3 본질 모두 본 milestone 안 흡수. 실 흡수 결정은 RESEARCH inventory 후 DESIGN decisions 안 명시. 흡수 결정 script 의 실 실행은 phase-{n} EXECUTE 안 git rm + agent 갱신/신규 + cascade cleanup.

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) 안 `v4.2` entry
- milestones.md: [`milestones.md`](milestones.md)
- 선행 milestone: [`../v4.0/REPORT.md`](../v4.0/REPORT.md) (정체성 정의) / [`../v4.1/REPORT.md`](../v4.1/REPORT.md) (D7 sequence rewrite)
- bootstrap/agents/ scaffold: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)
- 워크플로우 정의: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)

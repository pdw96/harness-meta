# RESEARCH — v4.2 verify-infra-agent-absorption

```json
{
  "external": [
    {
      "source": "code.claude.com/docs/en/sub-agents",
      "topic": "subagent yaml frontmatter spec — name/description/tools/model 필수, read-only tools (Read/Glob/Grep/Bash) 권한 부여 가능",
      "findings": "신규 subagent (environment-auditor / agents-md-sync) 정의 시 yaml frontmatter + system prompt 형식 준수. Bash tool 만 부여 시 read-only audit 가능 (write 권한 분리). component-installer 패턴 정확 정합.",
      "drift": "없음 — v4.0 phase-5 / v4.1 패턴 정합"
    },
    {
      "source": "code.claude.com/docs/en/hooks (Claude Code spec)",
      "topic": "hook command 실행 컴포넌트 — bash/PowerShell script 실 실행, settings.json hooks.SessionStart.command / hooks.PostToolUse.command 안 등록 의무",
      "findings": "session-init.sh / post-report-write.sh 는 settings.json 안 'command' 필드 등록된 실 실행 script — Claude Code 가 직접 호출. agent 흡수 불가능 (agent 는 Claude Code session 안 호출, hook 은 OS-level subprocess).",
      "drift": "없음 — out_of_scope #1 narrative 1차 source"
    },
    {
      "source": "code.claude.com/docs/en/statusline",
      "topic": "statusLine.command 안 등록된 bash script — Claude Code 가 매 turn 직접 호출",
      "findings": "statusline.sh 는 settings.json statusLine.command 안 등록된 실 실행 script — hook 과 동일 메커니즘 (OS-level subprocess). agent 흡수 불가능.",
      "drift": "없음 — out_of_scope #1 narrative 1차 source"
    },
    {
      "source": "v4.0_harness-composer-pivot REPORT.md",
      "topic": "phase-3 안 install script 3개 (install.ps1 + install-skills.{ps1,sh}) 폐기 결정 narrative",
      "findings": "'mechanical install/update/cleanup 도 agent 흡수' 정체성 (정전 single source: bootstrap/agents/CLAUDE.md § Install/Update/Cleanup) — verify/sync 도 동일 본질 확장 가능. 다만 v4.0 phase-3 안 폐기 대상은 'install' (write) 만 — verify (read-only audit) / sync-agents (write, drift detect + copy) 는 별 본질.",
      "drift": "없음 — 본 milestone 이 v4.0 정체성 확장 후속"
    },
    {
      "source": "v4.1_install-strategy-reaudit REPORT.md / DESIGN.md",
      "topic": "D7 5 step sequence rewrite (Option D: Junction Windows + Symlink Linux/macOS) + cascade narrative 12 host pattern",
      "findings": "component-installer 안 D7 5 step sequence 정합 + cascade host pattern. 본 milestone 도 동일 cascade pattern 적용 — verify/sync 거명 host (Makefile / tests/CLAUDE.md / claude/CLAUDE.md / CHANGELOG / inactive smokes 등) cleanup.",
      "drift": "없음 — v4.1 패턴 정합 적용"
    }
  ],
  "codebase": {
    "affected_files": [
      {
        "path": "verify.ps1",
        "lines": "~628 LOC",
        "current_state": "환경 헬스 체크 (Z/A/B/C/D/E/F/I/J/G 10 stage, ~30 check). settings.json 구조 + symlink 무결성 + hook/statusline smoke + frontmatter 검사. read-only audit (write 권한 부재). PowerShell 7+ 전용 Windows.",
        "target_state": "git rm — agent (environment-auditor) 흡수 후 폐기"
      },
      {
        "path": "verify.sh",
        "lines": "~595 LOC",
        "current_state": "verify.ps1 의 Linux/Darwin mirror. bash 4+ 전용. python3/jq fallback. Z~J 10 stage 동일.",
        "target_state": "git rm — environment-auditor 흡수 후 폐기"
      },
      {
        "path": "verify-lib.ps1",
        "lines": "~30 LOC head (전체 미확인, helper 함수)",
        "current_state": "verify.ps1 의 helper — Test-SymlinkIntegrity 등. dot-source 의존.",
        "target_state": "git rm — verify.ps1 폐기 시 자연 폐기 (단독 효용 부재)"
      },
      {
        "path": "verify-lib.sh",
        "lines": "~30 LOC head (전체 미확인)",
        "current_state": "verify.sh 의 helper — test_symlink_integrity. source 의존.",
        "target_state": "git rm — verify.sh 폐기 시 자연 폐기"
      },
      {
        "path": "sync-agents.ps1",
        "lines": "~172 LOC",
        "current_state": "AGENTS.md (canonical) → CLAUDE.md/GEMINI.md/.github/copilot-instructions.md/.cursor/rules/main.mdc/CONVENTIONS.md/.clinerules/main.md/.roo/rules/main.md 7 adapter SHA-256 drift 감지 + warn-and-prompt / -SourceWins / -Check / -DryRun / -ListTargets. PowerShell 7+ Windows.",
        "target_state": "git rm — agent (agents-md-sync) 흡수 후 폐기. 또는 component-installer 확장 흡수 (옵션)"
      },
      {
        "path": "sync-agents.sh",
        "lines": "~212 LOC",
        "current_state": "sync-agents.ps1 의 Linux/Darwin mirror. Windows Git Bash 감지 시 pwsh delegate.",
        "target_state": "git rm — agents-md-sync 흡수 후 폐기"
      },
      {
        "path": "Makefile",
        "lines": "L6 + L19~20 (verify target + help text)",
        "current_state": "`make verify` target = `pwsh ./verify.ps1` + help text L6 `make verify Run verify.ps1 (30-check health report)`",
        "target_state": "verify target 폐기 + help text L6 cleanup (또는 'verify' line 자체 제거)"
      },
      {
        "path": "tests/CLAUDE.md",
        "lines": "L31~32 (inactive smoke 표 row)",
        "current_state": "L31 `smoke-sync-agents.sh` row + L32 `smoke-verify-sh-parity.sh` row (inactive smoke 매트릭스 안 row 2건)",
        "target_state": "L31~32 row 2건 제거 또는 historical 보존 narrative 정합"
      },
      {
        "path": "claude/CLAUDE.md",
        "lines": "L51 (Hook 추가 시 verify.{ps1,sh} 갱신)",
        "current_state": "L51 `5. verify.{ps1,sh} 갱신` — Hook 추가 시 cascade 의무 narrative",
        "target_state": "L51 line 폐기 (verify 부재 시 cascade 의무 부재)"
      },
      {
        "path": "tests/_inactive/smoke-sync-agents.sh",
        "lines": "~122 LOC head",
        "current_state": "이미 inactive (v3.6 archive). sync-agents.{sh,ps1} 거명 9 checks. 참조 대상 부재 시 의미 zero.",
        "target_state": "git rm — sync-agents 폐기 시 inactive smoke 도 거명 대상 부재 → 폐기"
      },
      {
        "path": "tests/_inactive/smoke-verify-sh-parity.sh",
        "lines": "~100 LOC head",
        "current_state": "이미 inactive. verify.{ps1,sh} parity 검증. 참조 대상 부재 시 의미 zero.",
        "target_state": "git rm — verify 폐기 시 inactive smoke 도 거명 대상 부재 → 폐기"
      },
      {
        "path": "CHANGELOG.md",
        "lines": "L9 (Unreleased section 직전 [v4.2] entry 추가 위치)",
        "current_state": "Unreleased section 최상단 (v3.16_changelog-unreleased-position-cleanup), [v4.1] / [v4.0] entry 보유",
        "target_state": "[v4.2] entry 추가 — verify/sync 폐기 + agent 흡수 narrative"
      },
      {
        "path": "bootstrap/agents/CLAUDE.md",
        "lines": "§ Install/Update/Cleanup 책임 + 매트릭스 (placeholder)",
        "current_state": "install/update/cleanup 책임은 component-installer (D7 sequence) 명문화. 매트릭스 안 audit/ 카테고리 = project-harness-audit-team (5 멤버) 만",
        "target_state": "audit/ 카테고리 매트릭스 row 추가 (environment-auditor + agents-md-sync 2 멤버) + verify/sync 흡수 narrative (Install/Update/Cleanup 직후 sub-section 또는 별도 § Audit/Sync 책임)"
      },
      {
        "path": "bootstrap/agents/audit/environment-auditor/AGENT.md (또는 .md)",
        "lines": "신규 ~150 LOC",
        "current_state": "부재 (신규)",
        "target_state": "신규 subagent — yaml frontmatter (name: environment-auditor, description: 환경 헬스 체크 read-only audit, tools: Bash + Read + Glob + Grep, model: sonnet) + system prompt (Z~J 10 stage 매트릭스 narrative + 출력 형식)"
      },
      {
        "path": "bootstrap/agents/audit/agents-md-sync/AGENT.md (또는 .md)",
        "lines": "신규 ~120 LOC",
        "current_state": "부재 (신규)",
        "target_state": "신규 subagent — yaml frontmatter (name: agents-md-sync, description: AGENTS.md canonical drift 감지 + sync, tools: Read + Bash + Edit, model: sonnet) + system prompt (7 adapter mapping + drift 감지 + sync 모드 narrative)"
      },
      {
        "path": "projects/meta/ROADMAP.md",
        "lines": "v4.2 entry summary",
        "current_state": "v4.2 entry status: in_progress (Stage A OPEN 완료)",
        "target_state": "Stage I PROPOSE 종료 시 status: completed + summary 갱신"
      }
    ],
    "untouched_files_explicit": [
      {
        "path": "projects/meta/milestones/_archive/v3.x/**",
        "reason": "archived milestone artifacts — historical, 거명 보존 의무"
      },
      {
        "path": "projects/meta/milestones/v4.0/** + v4.1/**",
        "reason": "recent milestone artifacts (v4.0 phase-2 archive 정책 적용 외) — historical 보존"
      },
      {
        "path": "claude/hooks/{session-init.sh, post-report-write.sh}",
        "reason": "out_of_scope #1 — Claude Code spec 의무 (settings.json hooks.command 등록), agent 흡수 불가능"
      },
      {
        "path": "claude/statusline/statusline.sh",
        "reason": "out_of_scope #1 — Claude Code spec 의무 (settings.json statusLine.command), agent 흡수 불가능"
      },
      {
        "path": "install*.ps1 / install*.sh",
        "reason": "out_of_scope #3 — v4.0 phase-3 안 이미 폐기"
      },
      {
        "path": "bootstrap/agents/audit/project-harness-audit-team/**",
        "reason": "본 milestone scope 외 — environment-auditor + agents-md-sync 는 별 team 또는 audit/ 카테고리 직접 root 거주 검토 (DESIGN 단계 결정)"
      }
    ],
    "current_state_summary": "6 script (verify.{ps1,sh} + verify-lib.{ps1,sh} + sync-agents.{ps1,sh}) 잔존 상태. v4.0 phase-3 install script 3개 폐기 후 잔존한 'mechanical' 본질 script. 본 repo root 안 거주, ~1750 LOC. agent fleet 안 environment 검증 + AGENTS.md drift sync 책임 부재 (gap). 활성 cascade host = Makefile + tests/CLAUDE.md + claude/CLAUDE.md + inactive smoke 2건 + CHANGELOG. archived milestone artifact (v1.x~v4.1) 안 거명은 historical 보존.",
    "target_state_summary": "6 script 폐기 + 2 신규 subagent (environment-auditor + agents-md-sync) 또는 1 신규 + component-installer 확장 + active cascade 5+ host cleanup. agent fleet 안 audit/ 카테고리 row 2건 추가 (또는 1 추가). hook/statusline 책임 분리 narrative 1건 ARCHITECTURE.md 또는 claude/CLAUDE.md 정전화. CHANGELOG [v4.2] entry."
  },
  "options": [
    {
      "id": "P1",
      "approach": "6 script 모두 폐기, agent 흡수 부재",
      "pros": [
        "단순 — git rm 6 + cascade cleanup 만",
        "scope 최소"
      ],
      "cons": [
        "INTENT goal 위배 — '결정 (흡수/유지/일부 흡수) + 실 흡수 실행' 안 흡수 부재",
        "environment 검증 책임 + AGENTS.md drift sync 책임 자체가 fleet 안 부재 — 사용자 자연어 호출 ('verify 해줘') 시 메인 Claude 가 매 호출마다 ad-hoc 작성",
        "v4.0 정체성 (mechanical install/update/cleanup agent 흡수) 확장 안 함"
      ]
    },
    {
      "id": "P2",
      "approach": "verify → environment-auditor 신규 subagent / sync-agents → agents-md-sync 신규 subagent / verify-lib 자연 폐기",
      "pros": [
        "책임 분리 — read-only audit (verify) ↔ write drift sync (sync-agents) 본질 차이를 별 subagent 로 분리",
        "agent fleet 자연 확장 (audit/ 카테고리 row 2건 추가)",
        "v4.0 정체성 정합 — 'mechanical 도 agent 흡수' 확장",
        "tools 권한 분리 — environment-auditor (Bash read-only) / agents-md-sync (Bash + Edit write)"
      ],
      "cons": [
        "신규 subagent 2 추가 — bootstrap/agents/ 매트릭스 + 매뉴얼 추가",
        "scope 다소 큼 (6 폐기 + 2 신규 + 5+ host cleanup)"
      ]
    },
    {
      "id": "P3",
      "approach": "verify → environment-auditor 신규 / sync-agents → component-installer 확장 흡수 / verify-lib 자연 폐기",
      "pros": [
        "신규 subagent 1만 추가 (audit/environment-auditor)",
        "component-installer 가 write 권한 보유 — sync 책임 자연 흡수"
      ],
      "cons": [
        "component-installer 책임 비대화 — D7 mechanical install + sync drift 두 책임 혼재 (project-harness-audit-team 안 single responsibility 위배)",
        "audit 본질 (drift detect) vs apply 본질 (install) 분리 원칙 위배"
      ]
    },
    {
      "id": "P4",
      "approach": "모두 component-installer 확장 (verify + sync 모두 흡수)",
      "pros": [
        "신규 subagent 부재 — 매트릭스 변경 zero"
      ],
      "cons": [
        "component-installer 책임 비대화 극심 — install (write) + audit (read-only) + sync (write) 3 책임 혼재",
        "tools 권한 모호 — Bash + Edit + Read 가 모두 부여되지만 책임별 분리 narrative 부재",
        "옵션 P3 con 동일 (분리 원칙 위배)"
      ]
    },
    {
      "id": "P5",
      "approach": "폐기만 — agent 흡수 사용자 자연어 호출 시점 lazy 생성",
      "pros": [
        "scope 최소 + 신규 agent 부재"
      ],
      "cons": [
        "INTENT out_of_scope drift (실 흡수 실행 명시 scope)",
        "재현성 부재 — 매 호출마다 메인 Claude 가 ad-hoc 작성, 토큰 비효율 + 결과 비결정"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "verify-lib.ps1 / verify-lib.sh 의 helper 함수 (Test-SymlinkIntegrity / test_symlink_integrity) 가 verify 외 다른 script 에서 source 되고 있을 가능성",
      "evidence": "grep 결과 verify-lib 거명 host 가 verify.{ps1,sh} 본체 외에는 _archive milestone 산출물만 — active 거명 부재 추정",
      "mitigation": "Stage F EXECUTE 안 git rm 직전 grep 한 번 더 검증"
    },
    {
      "id": "R2",
      "risk": "신규 subagent (environment-auditor / agents-md-sync) 의 Bash tool 권한 부여 시 R/W 차이 명확화 부재 → agent 호출 시 prompt 안 의도 외 write 작업 발생 가능",
      "evidence": "component-installer 의 Bash 화이트리스트 패턴 (v4.0 D1 / v4.1 갱신) 정확 정합 부재 시 risk",
      "mitigation": "environment-auditor system prompt 안 '허용 명령 화이트리스트' (Test-Path / Get-ChildItem / pwsh -Command read 등) 명시 + 금지 명령 명시. agents-md-sync 도 동일 패턴 (Copy-Item / Edit 만 허용 - install/remove 금지)"
    },
    {
      "id": "R3",
      "risk": "Makefile `make verify` target 폐기 시 사용자 외부 cron/CI 안 호출 끊김",
      "evidence": "Makefile 직접 거명 host 외 외부 호출 host 검증 불가능 (사용자 환경 의존)",
      "mitigation": "Makefile verify target 안 stub message 추가 — 'verify target 폐기 (v4.2). environment-auditor subagent 호출: Claude Code 안 자연어 \\'verify 해줘\\''. install target 패턴 정합 (v4.0 phase-3 install stub)"
    },
    {
      "id": "R4",
      "risk": "_archive milestone 산출물 안 verify/sync 거명을 historical 보존 (변경 금지) vs cleanup 의 경계 모호",
      "evidence": "_archive/v3.x/v1.x/ 안 거명 ~25 files (RESEARCH/DESIGN/VERIFY 등)",
      "mitigation": "v4.0 phase-2 _archive 정책 정합 — _archive/ 안 거명은 변경 금지 (snapshot 보존). active 거명만 cleanup. cascade grep 검증 시 _archive/ 제외 정규식"
    },
    {
      "id": "R5",
      "risk": "tests/_inactive/smoke-sync-agents.sh + smoke-verify-sh-parity.sh 폐기 vs 보존 결정 모호",
      "evidence": "v3.6 안 inactive 이동 정책 narrative — 'inactive smoke 파일 보존' (CI 제외). 다만 참조 대상 (sync-agents/verify) 폐기 시 inactive smoke 도 거명 대상 부재 → 보존 의미 zero",
      "mitigation": "Stage D DESIGN 안 결정 — '거명 대상 폐기 시 inactive smoke 도 git rm' default 또는 '보존' 사용자 결정 게이트"
    },
    {
      "id": "R6",
      "risk": "신규 subagent 가 bootstrap/agents/audit/ 안 거주 시 project-harness-audit-team 의 5 멤버와 혼동",
      "evidence": "audit/ 안 현재 project-harness-audit-team/ team 디렉토리 만 — 신규 standalone subagent (non-team) 거주 위치 불명",
      "mitigation": "Stage D DESIGN 안 결정 — (a) audit/environment-auditor/ 직접 root (standalone) 또는 (b) audit/infra-team/ 신규 team 안 흡수 또는 (c) project-harness-audit-team/ 안 6/7 멤버 추가. bootstrap/agents/CLAUDE.md 매트릭스 정합"
    },
    {
      "id": "R7",
      "risk": "Stage F EXECUTE 안 git rm 6 script + 신규 agent 2 추가 + cascade cleanup 5+ host 동일 phase 처리 시 phase-1.md 비대화",
      "evidence": "v4.1 _archive/.. 패턴 (2 phase: mechanical + cascade)",
      "mitigation": "Stage D 안 phase 분할 결정 — 추정 P2 옵션 시 (phase-1: agent fleet 흡수 신규 / phase-2: 6 script 폐기 + cascade narrative cleanup) 또는 3 phase"
    },
    {
      "id": "R8",
      "risk": "smoke 회귀 — pre-commit hook 14 PASS 검증 시 v4.2 변경이 smoke FAIL 유발 risk",
      "evidence": "v4.0 phase-2 안 _archive regex 추가 사례 (smoke regex cascade)",
      "mitigation": "Stage F 각 phase commit 직전 pre-commit 14 hook PASS 확인 + smoke FAIL 시 즉시 rollback"
    },
    {
      "id": "R9",
      "risk": "ARCHITECTURE.md 안 'mechanical 본질 vs Claude Code spec 의무 컴포넌트' narrative 추가 위치 모호 — § 3 (working definition) / § 3.1 (정체성) / § 4 (9-stage) 중 어디?",
      "evidence": "v4.0_harness-composer-pivot DESIGN 안 정체성 § 3.1 끝 paragraph 정전화 + § 6.2 폐지. 본 narrative 는 정체성 cascade 확장",
      "mitigation": "Stage D DESIGN 안 위치 결정 + 사용자 명시 결정 (AskUserQuestion) 가능. 패턴 = v3.21 narrative 정전화 3 단계 (DESIGN 정확 문구 + EXECUTE Edit + VERIFY grep)"
    }
  ]
}
```

## narrative

본 단계는 RESEARCH — 의도 (INTENT) 조사 정량화. 6 script 의 본질 + 흡수 가능성을 5 option (P1~P5) 으로 raw 분석. 결정은 DESIGN 단계 (decisions[] + rationale) 로 미룸.

핵심 통찰 3건:

1. **3 본질 분리** — verify (read-only audit) / verify-lib (helper) / sync-agents (write drift sync) 세 책임 본질 차이. P2 (verify → environment-auditor + sync-agents → agents-md-sync + verify-lib 자연 폐기) 가 책임 분리 본질 정합 우위.

2. **archive 정책 정합** — `_archive/v1.x~v3.21/` 안 verify/sync 거명 ~25 file 은 v4.0 phase-2 안 archived snapshot — 변경 금지 (historical). active cascade 5+ host (Makefile / tests/CLAUDE.md / claude/CLAUDE.md / inactive smokes / CHANGELOG / bootstrap/agents/CLAUDE.md) 만 cleanup. v4.0/v4.1 milestone artifacts 도 historical 보존 (REPORT/VERIFY/PROPOSE 안 verify 거명은 milestone snapshot).

3. **hook/statusline 본질 차이 narrative** — out_of_scope #1 entry 본질 = Claude Code spec 의무 컴포넌트 (settings.json 안 등록된 OS-level subprocess). verify/sync 는 1회/주기 사용자 호출 = agent 흡수 가능. narrative 정전화 1건 (sc_3) — DESIGN 단계 host 위치 결정 (R9).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- 선행 v4.0 정체성: [`../v4.0/REPORT.md`](../v4.0/REPORT.md)
- 선행 v4.1 D7 sequence: [`../v4.1/DESIGN.md`](../v4.1/DESIGN.md)
- bootstrap/agents/ 매트릭스: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)
- component-installer 패턴: [`../../../../bootstrap/agents/audit/project-harness-audit-team/component-installer.md`](../../../../bootstrap/agents/audit/project-harness-audit-team/component-installer.md)

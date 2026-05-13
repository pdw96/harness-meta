# DESIGN — v4.2 verify-infra-agent-absorption

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "P2 옵션 채택 — verify → environment-auditor 신규 subagent (read-only audit) / sync-agents → agents-md-sync 신규 subagent (write drift sync) / verify-lib 자연 폐기",
      "rationale": "사용자 명시 결정 (Stage D entry round AskUserQuestion D1). RESEARCH.options P2 본질 = 책임 분리 (read-only audit ↔ write drift sync) 본질 차이를 별 subagent 로 분리. v4.0 정체성 (project harness composer + agent fleet maintainer + mechanical install/update/cleanup agent 흡수) 정합 확장. P3 (sync-agents → component-installer 확장) 거부 = installer 책임 비대화 (D7 install + drift sync 혼재).",
      "alternatives_rejected": [
        "P1 — 6 script 모두 폐기, agent 흡수 부재 (INTENT scope 위배)",
        "P3 — sync-agents → component-installer 확장 (책임 비대화)",
        "P4 — 모두 component-installer 확장 (책임 비대화 극심)",
        "P5 — 폐기만, lazy ad-hoc (재현성 부재)"
      ]
    },
    {
      "id": "D2",
      "decision": "신규 subagent 거주 = **standalone .md 파일** — `bootstrap/agents/audit/environment-auditor.md` + `bootstrap/agents/audit/agents-md-sync.md` (디렉토리 부재, 단일 .md 파일)",
      "rationale": "spec-drift 검토 권고 (context7 `/websites/code_claude` standard pattern `.claude/agents/<name>.md` 단일 파일 형식). 사용자 명시 결정 (Stage D entry round AskUserQuestion D2 'audit/<name>/ standalone — project-harness-audit-team 과 고립') 의 sub-decision 으로 spec-drift 권고 흡수 — 디렉토리 vs 단일 파일 형식 결정. Claude Code 자동 인식 보장 + project-harness-audit-team/ (team = 디렉토리) 과 명확 구분 (standalone = .md 파일).",
      "alternatives_rejected": [
        "audit/<name>/AGENT.md 디렉토리 형식 — Claude Code spec 안 명시 인식 패턴 부재 risk + project-harness-audit-team 패턴 (team = 디렉토리 멤버 N) 혼동 risk",
        "audit/infra-team/ 신규 team 안 흡수 — 1 team 안 2 멤버 만 부재, e3 cycle 책임 vs 단일 책임 본질 차이 무시",
        "project-harness-audit-team 안 6/7 멤버 — team 책임 경계 (audit cycle proposal+apply) 와 standalone 책임 (단일 audit/sync) 본질 혼재"
      ]
    },
    {
      "id": "D3",
      "decision": "inactive smokes 2건 (tests/_inactive/smoke-sync-agents.sh + tests/_inactive/smoke-verify-sh-parity.sh) git rm 폐기",
      "rationale": "사용자 명시 결정 (Stage D entry round AskUserQuestion D3). 참조 대상 (sync-agents/verify) 폐기 시 의미 zero. v3.6 inactive smoke 정책 narrative ('참조 대상 폐기 시 inactive 도 git rm') default 정합.",
      "alternatives_rejected": [
        "보존 (historical) — stale narrative 관리 대상 추가 + 의미 zero"
      ]
    },
    {
      "id": "D4",
      "decision": "Makefile `make verify` target = stub message + agent 안내",
      "rationale": "사용자 명시 결정 (Stage D entry round AskUserQuestion D4). v4.0 phase-3 install target 패턴 정합 — 'verify target 폐기 (v4.2). environment-auditor subagent 호출: Claude Code 안 자연어 \\'verify 해줘\\''. 외부 cron/CI 호출 끊김 시 명시 안내 (R3 mitigation).",
      "alternatives_rejected": [
        "완전 제거 — 외부 의존 명시 안내 부재 (R3 risk)"
      ]
    },
    {
      "id": "D5",
      "decision": "3 phase 분할 — phase-1 agent fleet 신규 (mechanical) / phase-2 script 폐기 + Makefile stub + inactive smokes git rm (mechanical) / phase-3 cascade narrative cleanup",
      "rationale": "architecture + 회귀 risk 검토 일치 권고. agent 부재 상태 script 폐기 시 사용자 호출 불가 gap window 회피 (phase-1 → phase-2 순서 의무). phase-2 + phase-3 통합 시 commit diff 안 6 script git rm + 9 host narrative cleanup 혼재 → atomic revert + 단일 책임 본질 위해 분리. v4.1 패턴 (2 phase: mechanical + cascade) 와 차이 = agent 추가 별 phase 필요.",
      "alternatives_rejected": [
        "2 phase (mechanical + cascade) — v4.1 패턴 정합이나 agent 부재 gap window risk",
        "4 phase (agent / script 폐기 / Makefile + smoke / cascade) — 입자 너무 작음 + 1-phase 70.6% 도그푸드 정합 (v3.17 진단)"
      ]
    },
    {
      "id": "D6",
      "decision": "environment-auditor yaml frontmatter — name: environment-auditor, description: 환경 헬스 체크 read-only audit (verify.{ps1,sh} 의 Z/A/B/C/D/E/F/I/J/G 10 stage 흡수 + ~/.claude/ 안 symlink/junction 무결성 + settings.json 구조 + frontmatter 검사 + hook/statusline smoke + backup 디렉토리 정보), tools: Bash, Read, Glob, Grep, model: sonnet",
      "rationale": "RESEARCH.codebase 안 verify 10 stage 책임 그대로 흡수. read-only audit 본질 — Bash (read-only 명령만 화이트리스트) + Read (settings.json 등) + Glob (frontmatter 파일 enumerate) + Grep (V1/V5/V7/V8/V10 frontmatter 검사). model: sonnet (audit 결과 narrative 보고, opus 불요).",
      "alternatives_rejected": [
        "model: opus — read-only audit 책임 수준 낮음, sonnet 충분",
        "tools 안 Edit 추가 — write 책임 부재"
      ]
    },
    {
      "id": "D7",
      "decision": "environment-auditor system prompt 안 Bash 화이트리스트 의무 (R2 mitigation) — 허용: Test-Path, Get-ChildItem, Get-FileHash, Select-String, Get-Content, Get-ItemProperty, pwsh -Command (read-only), bash 호출, head, cat, file, ls, find (read-only). 금지: New-Item, Copy-Item, Move-Item, Remove-Item, Edit, rm, mv, cp (write 일체)",
      "rationale": "component-installer 패턴 정합 (v4.1 D1 security mitigation). agent 가 read-only audit 명령만 실행 보장. spec-drift agent SDK quickstart 권고 ('read-only tools = Read/Glob/Grep' + Bash read-only 화이트리스트) 정합.",
      "alternatives_rejected": [
        "화이트리스트 부재 (Bash tool 자유) — security risk + 의도 외 write 작업 가능"
      ]
    },
    {
      "id": "D8",
      "decision": "agents-md-sync yaml frontmatter — name: agents-md-sync, description: AGENTS.md canonical → 7 adapter (CLAUDE.md/GEMINI.md/.github/copilot-instructions.md/.cursor/rules/main.mdc/CONVENTIONS.md/.clinerules/main.md/.roo/rules/main.md) SHA-256 drift 감지 + sync (default -Check mode, write 는 사용자 명시 결정 후), tools: Read, Bash, Edit, model: sonnet",
      "rationale": "RESEARCH.codebase 안 sync-agents 책임 그대로 흡수. Read (AGENTS.md + 7 adapter), Bash (SHA-256 계산 — Get-FileHash / sha256sum / shasum), Edit (canonical → adapter overwrite). model: sonnet.",
      "alternatives_rejected": [
        "tools 안 Write 추가 — Edit 으로 충분 (overwrite 도 Edit 으로 가능)",
        "model: opus — sync 책임 수준 낮음"
      ]
    },
    {
      "id": "D9",
      "decision": "agents-md-sync default mode = `-Check` (drift detect only) — write 호출 (`-SourceWins`) 은 사용자 명시 결정 게이트 후만 (e3 정책 정합)",
      "rationale": "spec-drift 검토 권고. propose ≠ apply 책임 분리 (v4.0 component-proposer ↔ component-installer 패턴 정합). agent default 호출 시 drift detect 결과 markdown report 출력만 + 사용자가 'sync 실행' 명시 후 write. agent 자체 안 게이트 narrative system prompt 안 명시.",
      "alternatives_rejected": [
        "default -SourceWins — 자동 write, propose ≠ apply 분리 위배",
        "default warn-and-prompt — agent context 안 TTY 부재 (Console.IsInputRedirected detect 메커니즘 부재)"
      ]
    },
    {
      "id": "D10",
      "decision": "sc_3 narrative (hook/statusline = Claude Code spec 의무 실 실행 컴포넌트 ≠ mechanical 본질 = agent 흡수 가능) 정전화 host = **ARCHITECTURE.md § 3.1 끝 정체성 paragraph 직후** 1 paragraph 신규",
      "rationale": "spec-drift 검토 권고 (v4.0 정체성 단일 source 정합 + v3.21 narrative 정전화 3 단계 패턴 = DESIGN 정확 문구 + EXECUTE Edit + VERIFY grep). 정전 single source 강제 — claude/CLAUDE.md / bootstrap/agents/CLAUDE.md 안 cross-ref 추가 zero. v3.20 narrative 단일 source 패턴 정합.",
      "alternatives_rejected": [
        "§ 3 5요소 매트릭스 Verification 행 — 매트릭스 row 추가는 행 책임 confusion risk",
        "§ 4 9-stage 안 — 9-stage workflow 본질과 mechanical/spec 분리 본질 무관",
        "claude/CLAUDE.md 안 host — 정체성 단일 source 정합 위배 (ARCHITECTURE.md primary)"
      ]
    },
    {
      "id": "D11",
      "decision": "bootstrap/agents/CLAUDE.md cascade — (a) 매트릭스 표 audit/ 카테고리 row 2건 추가 (environment-auditor + agents-md-sync) + (b) § '디렉토리 구조' 트리 narrative 안 standalone subagent 거주 패턴 1줄 추가 + (c) § Install/Update/Cleanup 책임 직후 신규 sub-section § 'Audit/Sync 책임' (verify/sync 흡수 narrative)",
      "rationale": "architecture 검토 권고. 매트릭스 row 추가만으로는 standalone subagent 거주 패턴 모호 (현재 § '디렉토리 구조' 트리 narrative 안 team 패턴만 명시). § Audit/Sync 책임 sub-section 으로 environment-auditor + agents-md-sync 호출 패턴 + 사용자 자연어 호출 narrative 정전화.",
      "alternatives_rejected": [
        "매트릭스 row 추가만 — standalone 거주 narrative 부재 (모호)",
        "별 .md 파일 분리 — 단일 source 정합 위배"
      ]
    },
    {
      "id": "D12",
      "decision": "cascade host scope = active 거명 8건 — (1) verify.ps1 git rm / (2) verify.sh git rm / (3) verify-lib.ps1 git rm / (4) verify-lib.sh git rm / (5) sync-agents.ps1 git rm / (6) sync-agents.sh git rm / (7) Makefile stub + help / (8) tests/_inactive/smoke-sync-agents.sh git rm / (9) tests/_inactive/smoke-verify-sh-parity.sh git rm / (10) claude/CLAUDE.md L51 line 폐기 / (11) tests/CLAUDE.md L31~32 inactive 표 row 제거 / (12) bootstrap/agents/CLAUDE.md 매트릭스 + 트리 + § Audit/Sync 책임 / (13) ARCHITECTURE.md § 3.1 끝 paragraph / (14) CHANGELOG.md [v4.2] entry. **AGENTS.md + bootstrap/skills/CLAUDE.md + GUARDRAILS.md + README.md + .env.example grep 결과 0 — cascade scope 외**",
      "rationale": "architecture 검토 권고 (cascade host 3건 (AGENTS/skills/GUARDRAILS) 추가 검증) 흡수 결과 — 모두 0 검출. v4.1 12 host pattern 정합 검증 완료. _archive/v1.x~v4.1/ artifacts (~25 file) 은 historical 보존 (v4.0 phase-2 _archive 정책 정합).",
      "alternatives_rejected": [
        "AGENTS.md / GUARDRAILS.md / skills/CLAUDE.md cascade 추가 — 거명 부재 = 작업 불요"
      ]
    },
    {
      "id": "D13",
      "decision": "신규 subagent .md 파일 frontmatter 검사 책임 — verify.ps1 안 frontmatterFiles 배열 (V1/V5/V7/V8/V10 검사) 가 verify 폐기와 동시에 폐기되므로 별도 검사 부재. environment-auditor subagent 안 frontmatter audit 책임 흡수 시 자동 적용",
      "rationale": "spec-drift 검토 권고 (verify.ps1 frontmatterFiles 배열에 신규 .md 파일 추가 또는 glob 패턴 도입). 본 milestone scope 안 environment-auditor system prompt 안 frontmatter audit 책임 (verify.ps1 I1~I5 흡수) 포함. glob `bootstrap/agents/**/*.md` + `bootstrap/skills/**/*.md` 패턴 자동 enumerate.",
      "alternatives_rejected": [
        "별 frontmatter smoke 추가 — 본 milestone scope 외 (V8 검사 자체가 verify 안 거주)"
      ]
    }
  ],
  "approach": "P2 옵션 (책임 분리, 2 신규 standalone .md subagent) + 3 phase 분할 (agent 신규 → script 폐기 → cascade narrative) + 14 host cascade scope. v4.0 정체성 정합 확장 + v4.1 cascade pattern 정합 + v3.21 narrative 정전화 3 단계 패턴 적용 (sc_3 narrative ARCHITECTURE.md § 3.1 끝 정전화). agent 부재 gap window 회피 위해 phase-1 (agent fleet 신규) → phase-2 (script 폐기) → phase-3 (cascade narrative) 순서 강제.",
  "phases": [
    {
      "n": 1,
      "title": "신규 standalone subagent 2 추가 — environment-auditor + agents-md-sync",
      "scope": "bootstrap/agents/audit/ 안 단일 .md 파일 2건 신규 (yaml frontmatter + system prompt 형식). verify.{ps1,sh} 의 Z/A/B/C/D/E/F/I/J/G 10 stage 책임을 environment-auditor system prompt 안 흡수 + Bash 화이트리스트 명시 (D7). sync-agents.{ps1,sh} 의 7 adapter SHA-256 drift detect + sync 책임을 agents-md-sync system prompt 안 흡수 + default -Check 모드 + write 게이트 narrative (D9).",
      "affected_files": [
        "bootstrap/agents/audit/environment-auditor.md (신규)",
        "bootstrap/agents/audit/agents-md-sync.md (신규)",
        "projects/meta/milestones/v4.2/execute/phase-1.md (실행 노트)"
      ],
      "rationale": "agent 부재 상태 script 폐기 시 사용자 호출 불가 gap window 회피 (phase-1 선결 의무). standalone .md 파일 단일 형식 — context7 standard pattern + 자동 인식 보장.",
      "risks": [
        "R2 — Bash tool 권한 화이트리스트 부재 시 의도 외 write — system prompt 안 화이트리스트 명시 (D7 mitigation)",
        "신규 subagent 호출 검증 ad-hoc (component-installer 안 미통과 — 본 milestone scope 안 미포함)"
      ]
    },
    {
      "n": 2,
      "title": "6 script 폐기 + Makefile stub + inactive smokes git rm (mechanical)",
      "scope": "verify.ps1 + verify.sh + verify-lib.ps1 + verify-lib.sh + sync-agents.ps1 + sync-agents.sh 6건 git rm. Makefile L1 PHONY 안 verify 제거 (또는 stub 유지) + L6 help text stub + L19~20 verify target stub message. tests/_inactive/smoke-sync-agents.sh + tests/_inactive/smoke-verify-sh-parity.sh git rm.",
      "affected_files": [
        "verify.ps1 (git rm)",
        "verify.sh (git rm)",
        "verify-lib.ps1 (git rm)",
        "verify-lib.sh (git rm)",
        "sync-agents.ps1 (git rm)",
        "sync-agents.sh (git rm)",
        "Makefile (L1/L6/L19~20 갱신)",
        "tests/_inactive/smoke-sync-agents.sh (git rm)",
        "tests/_inactive/smoke-verify-sh-parity.sh (git rm)",
        "projects/meta/milestones/v4.2/execute/phase-2.md (실행 노트)"
      ],
      "rationale": "phase-1 안 신규 subagent 배포 후 script 폐기 — gap window 회피. mechanical 본질 그룹화 (git rm + Makefile stub 단순 mechanical, narrative 변경 부재).",
      "risks": [
        "R1 — verify-lib helper 함수 외부 source 가능성 → git rm 직전 grep 재검증 (Stage F EXECUTE 안 수행)",
        "R3 — Makefile 외부 cron/CI 호출 끊김 (stub message 안내로 완화)",
        "R8 — pre-commit 14 hook smoke FAIL risk (verify/sync 거명 active smoke 부재 — 회귀 검토 결과 risk 0 추정)"
      ]
    },
    {
      "n": 3,
      "title": "cascade narrative cleanup — claude/CLAUDE.md + tests/CLAUDE.md + bootstrap/agents/CLAUDE.md + ARCHITECTURE.md + CHANGELOG",
      "scope": "(a) claude/CLAUDE.md L51 'verify.{ps1,sh} 갱신' line 폐기. (b) tests/CLAUDE.md L31~32 inactive 표 2 row 제거. (c) bootstrap/agents/CLAUDE.md — 매트릭스 표 audit/ row 2건 추가 (environment-auditor + agents-md-sync) + § '디렉토리 구조' 트리 안 standalone subagent 패턴 1줄 추가 + § Install/Update/Cleanup 직후 신규 sub-section § 'Audit/Sync 책임' 추가 (verify/sync 흡수 narrative). (d) ARCHITECTURE.md § 3.1 끝 정체성 paragraph 직후 신규 paragraph 1건 정전화 — 'mechanical 본질 vs Claude Code spec 의무 실 실행 컴포넌트' 분리. (e) CHANGELOG.md [v4.2] entry 추가 (Unreleased 직후, v4.1 entry 직전).",
      "affected_files": [
        "claude/CLAUDE.md (L51)",
        "tests/CLAUDE.md (L31~32)",
        "bootstrap/agents/CLAUDE.md (매트릭스 + 트리 + § Audit/Sync 책임)",
        "projects/meta/ARCHITECTURE.md (§ 3.1 끝 paragraph)",
        "CHANGELOG.md ([v4.2] entry)",
        "projects/meta/milestones/v4.2/execute/phase-3.md (실행 노트)"
      ],
      "rationale": "narrative 정전화 책임 그룹화. sc_3 narrative ARCHITECTURE.md § 3.1 끝 단일 source (v3.21 3 단계 패턴 적용) + bootstrap/agents/CLAUDE.md audit/ 카테고리 매트릭스 확장 + cascade host cleanup 일괄 처리.",
      "risks": [
        "R9 — ARCHITECTURE.md narrative 위치 결정 → § 3.1 끝 고정 (D10 mitigation)",
        "v3.21 narrative 정전화 3 단계 패턴 정합 — DESIGN 안 정확 문구 명시 + EXECUTE Edit + VERIFY grep"
      ]
    }
  ],
  "risk_mitigation": {
    "R1": "verify-lib helper 외부 source 가능성 — Stage F phase-2 git rm 직전 `Grep verify-lib` 재검증 (_archive 제외)",
    "R2": "신규 subagent Bash 권한 화이트리스트 — environment-auditor + agents-md-sync system prompt 안 명시 (D7 + D9)",
    "R3": "Makefile 외부 cron/CI 끊김 — stub message + agent 안내 (D4)",
    "R4": "_archive milestone artifacts cleanup 경계 — _archive/ 제외 regex (v4.0 phase-2 정책 정합)",
    "R5": "inactive smoke 폐기 결정 — D3 사용자 명시 결정 (git rm)",
    "R6": "거주 위치 — D2 standalone .md 파일 (spec-drift 권고 흡수)",
    "R7": "phase 분할 — D5 3 phase (architecture + 회귀 risk 일치)",
    "R8": "smoke 회귀 — phase 별 pre-commit 14 hook PASS 확인 (회귀 risk 검토 결과 risk 0 추정)",
    "R9": "ARCHITECTURE narrative 위치 — D10 § 3.1 끝 고정 (spec-drift 권고 흡수)"
  },
  "review_results": {
    "agents": [
      {"agent": "Plan (architecture)", "verdict": "pass-with-comments", "key_findings": ["standalone subagent 거주 narrative 트리 안 부재 → D11 흡수", "agents-md-sync backup 책임 narrative 부재 → agent default -Check 모드 + write 게이트 (D9) 흡수", "cascade host 3건 AGENTS/skills/GUARDRAILS 검증 → 0 검출", "phase 분할 3 vs 2 rationale → D5 흡수"]},
      {"agent": "general-purpose (spec-drift, context7)", "verdict": "pass-with-comments", "key_findings": ["거주 위치 standalone .md 파일 권장 (context7 standard pattern) → D2 정정 흡수", "yaml frontmatter spec 정합", "hook/statusline spec 정합 (out_of_scope #1 PASS)", "agents-md-sync default -Check + 게이트 → D9 흡수", "ARCHITECTURE § 3.1 끝 narrative 위치 → D10 흡수"]},
      {"agent": "Explore (회귀 risk)", "verdict": "pass-with-comments", "key_findings": ["pre-commit 14 hook + CI ACTIVE_SMOKES 6 — verify/sync 거명 0 (회귀 risk 0)", "phase-1 신규 / phase-2 폐기 + cascade 권고 (3 phase 정합)", "verify-lib grep 재검증 (R1) + system prompt 화이트리스트 (R2) + inactive smoke git rm (R5) 흡수"]},
      {"agent": "Explore (scope contract)", "verdict": "pass-with-comments", "key_findings": ["sc_1~sc_7 phases 1:1 매핑 가능", "out_of_scope 4건 phases 안 침범 부재", "dependencies dep_1+dep_2 정합"]}
    ],
    "conflicts": "0건 — 4 agent verdict 모두 pass-with-comments, 권고 충돌 부재 (architecture + spec-drift 두 권고 모두 D11 + D2 흡수)",
    "absorbed_recommendations": 13
  },
  "narrative_canonicalization_3step": {
    "design_canonical_text": "## Stage D 정확 문구 1차 source (ARCHITECTURE.md § 3.1 끝 신규 paragraph)\n\n```markdown\n**mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리** (v4.2_verify-infra-agent-absorption 도입): harness-meta 안 'mechanical install/update/cleanup' 본질 책임 (script 폐기 후 agent 흡수 가능 — v4.0 install + v4.2 verify/sync) 과 Claude Code spec 의무 실 실행 컴포넌트 (settings.json 안 등록된 OS subprocess — `claude/hooks/{session-init.sh, post-report-write.sh}` + `claude/statusline/statusline.sh`) 는 본질 분리. spec 의무 컴포넌트는 agent 흡수 불가능 (agent = Claude Code session 안 Task 호출, hook = OS-level subprocess, recursion 차단). 정체성 (project harness composer + agent fleet maintainer) 확장 시 본 분리 narrative 정합.\n```",
    "execute_insertion": "phase-3 안 ARCHITECTURE.md § 3.1 끝 정체성 paragraph 직후 (line ~67 다음) 본 문구 Edit tool 그대로 삽입",
    "verify_grep_keywords": ["mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리", "v4.2_verify-infra-agent-absorption 도입", "spec 의무 컴포넌트는 agent 흡수 불가능"]
  }
}
```

## narrative

본 단계는 DESIGN — 사용자 결정 4건 + 4 관점 검토 13 권고 통합. P2 옵션 (verify → environment-auditor / sync-agents → agents-md-sync / verify-lib 자연 폐기) + standalone .md 파일 거주 (spec-drift critical drift 정정) + 3 phase 분할 + 14 host cascade scope.

핵심 결정 13건 (D1~D13) 안 정합 cluster:

- **권한/책임 분리** (D1 + D6 + D7 + D8 + D9): read-only audit (Bash 화이트리스트) ↔ write drift sync (default -Check + 사용자 게이트) ↔ component-installer (D7 install/update/cleanup) 3 본질 분리.
- **거주/형식** (D2 + D11 + D13): standalone .md 파일 + 매트릭스 row 2건 추가 + 트리 narrative 갱신 + § Audit/Sync 책임 sub-section. team (디렉토리 멤버 N) ↔ standalone (단일 .md) 패턴 명료화.
- **phase/cascade** (D5 + D12): 3 phase 분할 + 14 host cascade (active 거명 8 + 매트릭스 + 트리 + narrative + CHANGELOG, _archive 제외).
- **narrative 정전화** (D10): ARCHITECTURE.md § 3.1 끝 정전 single source — v3.21 3 단계 패턴 (DESIGN 정확 문구 + EXECUTE Edit + VERIFY grep) 적용. cross-ref 추가 zero (v3.20 단일 source 패턴 정합).

phase scope 정합 — sc_1 (RESEARCH 완료) + sc_2 (DESIGN.decisions 13건) + sc_3 (phase-3 ARCHITECTURE narrative) + sc_4 (phase-1 agent 신규 + phase-2 script 폐기) + sc_5 (phase-3 cascade) + sc_6 (VERIFY pre-commit 14 PASS) + sc_7 (VERIFY criteria_check 1:1). out_of_scope 4건 phases 안 침범 0.

## 관련

- INTENT: [`INTENT.md`](INTENT.md) (success_criteria 7건 + out_of_scope 4건 + dependencies 2건)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md) (5 options + 9 risks + 14 affected_files)
- bootstrap/agents/CLAUDE.md: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md) (매트릭스 + 두 층 + Install/Update/Cleanup 단일 source)
- ARCHITECTURE.md: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) (정전 single source, § 3.1 끝 정전화 host)
- v4.1 cascade pattern: [`../v4.1/DESIGN.md`](../v4.1/DESIGN.md) (12 host pattern, v4.2 = 8 host)
- v3.21 narrative 정전화 3 단계 패턴: [`../_archive/v3.21/DESIGN.md`](../_archive/v3.21/DESIGN.md)

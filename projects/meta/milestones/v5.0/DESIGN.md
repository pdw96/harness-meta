# DESIGN — v5.0 plugin-pivot

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "O1 채택 — Plugin 변환 + paths 명시 (replace-default agents/commands) + 현 디렉토리 구조 (bootstrap/agents/audit/ + bootstrap/skills/ + claude/{commands,hooks,statusline}/) 보존.",
      "rationale": "사용자 round 1 명시 결정 'O1 (Recommended)'. v4.0 정체성 (ecosystem integrator) + 현 디렉토리 구조 (bootstrap/ prefix = global 격리, claude/ prefix = layer 격리) 보존 narrative 정합. RESEARCH O2 (Plugin 표준 flat 재구성) 의 git history + cross-ref 14 host cascade 추가 갱신 부담 회피.",
      "alternatives_rejected": ["O2 — 디렉토리 대대적 재구성 narrative 부담 + 격리 narrative 약화", "O3 (점진 P2) — v4.3 DESIGN.D2 사용자 결정 (a) 와 모순 (전면 채택 결정)", "O4 (multi-plugin marketplace) — scope 거대화 + team orchestration source-of-truth 분산"]
    },
    {
      "id": "D2",
      "decision": "현 자연어 'harness-meta 설치해줘' narrative deprecation 표지 — cascade host 안 narrative 보존 + 'deprecated, 새 표준: claude plugin install' 표지 추가. v5.x cycle 안 자연 제거 carry-over.",
      "rationale": "사용자 round 1 명시 결정 'Deprecation 표지 (Recommended)'. breaking change narrative 균형 — 즉시 폐기 시 v4.x 사용자 환경 단절 risk + 보존 narrative 안 'deprecated' 표지로 migration 자연 유도. v4.0 phase-3 폐기 패턴 (B3 install script 3개 폐기, 즉시 git rm) 과 다른 narrative — 본 milestone 은 사용자 onboarding flow 변경, 즉시 단절 risk 회피.",
      "alternatives_rejected": ["즉시 폐기 (cascade 안 자연어 호출 narrative 즉시 git rm) — 사용자 환경 단절 risk + breaking change narrative 균형 무너짐", "그대로 보존 (dual) — 두 경로 narrative 경합 + 사용자 혼란"]
    },
    {
      "id": "D3",
      "decision": "기존 ~/.claude/agents/ 5 멤버 audit-team SymbolicLink — Plugin install 후 manual cleanup 권고 narrative. README/AGENTS/root CLAUDE.md 안 명시 '본 plugin install 후 ~/.claude/agents/ 안 5 멤버 SymbolicLink 가 잔존 시 충돌 방지 위해 수동 제거 권고'.",
      "rationale": "사용자 round 1 명시 결정 'Cleanup 권고 (Recommended)'. 자동 cleanup (component-installer 안 cleanup 트리거 추가) 시 D7 sequence 본문 변경 부담 + 사용자 환경 의도치 않은 제거 risk. Dual (그대로 공존) 시 agent_type duplicate risk (~/.claude/agents/ + ~/.claude/plugins/<plugin>/agents/ 둘 다 인식). manual 권고 = 사용자 선택권 보유 + 충돌 회피.",
      "alternatives_rejected": ["자동 cleanup — component-installer D7 sequence 본문 변경 부담 + 사용자 환경 의도치 않은 제거 risk", "Dual 보존 — agent_type duplicate risk + 명시 narrative 부재 시 혼란"]
    },
    {
      "id": "D4",
      "decision": "3 phase 분할 채택 — phase-1: `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json` 신규 + 사용자 onboarding cascade (README.md + AGENTS.md + root CLAUDE.md). phase-2: 내부 narrative cascade (10 host). phase-3: D7 책임 분리 narrative (component-installer.md + team CLAUDE.md) + CHANGELOG [v5.0]! breaking entry + bootstrap/claude-code-catalog/README.md.bak cleanup.",
      "rationale": "사용자 round 1 명시 결정 '3 phase (Recommended)'. 사용자-facing 핵심 (manifest + onboarding) phase-1 분리 → 사용자 가치 우선 + 내부 cascade phase-2 분리 → narrative 정합 부담 격리 + D7 책임 분리 + CHANGELOG + cleanup phase-3 분리 → 종결 narrative 격리. 각 phase = 1 commit (conventional commits).",
      "alternatives_rejected": ["2 phase — phase-1 (manifest + 전체 cascade) phase-2 (CHANGELOG + 종결) — phase-1 LOC 과대화 + 사용자-facing/내부 narrative 혼재", "1 phase lightweight — scope 큼 (16+ 파일) + breaking major bump = lightweight 부적합. v3.21 3 단계 패턴 cycle 안 lightweight 는 narrative 정전화 ≤5 파일 scope 안 default"]
    },
    {
      "id": "D5",
      "decision": "plugin install scope default = `user` (전역). README/AGENTS/root CLAUDE.md 안 명시 — `claude plugin install harness-meta@harness-meta` (scope user default) + 프로젝트 별 share 시 `--scope project` (.claude/settings.json 안 share) optional narrative.",
      "rationale": "v4.x narrative 'user scope' 정합 — 현 ~/.claude/agents/ 안 SymbolicLink 패턴 = user scope. .harness.toml 활용 프로젝트 (upbit 등) 안 project scope 도 잠재 — narrative 안 두 패턴 명시.",
      "alternatives_rejected": ["project scope default — 현 v4.x 패턴 (user scope) 와 모순 + 사용자 onboarding 부담 (각 프로젝트 별 install)"]
    },
    {
      "id": "D6",
      "decision": "paths 명시 형식 — agents 필드 안 sub-dir 별 안전 명시 + 디렉토리 명시 sub-dir nested 인식 실 검증. plugin.json 안 `agents: ['./bootstrap/agents/audit/environment-auditor.md', './bootstrap/agents/audit/agents-md-sync.md', './bootstrap/agents/audit/project-harness-audit-team/']` 명시. 디렉토리 명시 (`./bootstrap/agents/audit/project-harness-audit-team/`) 시 안 .md 자동 인식 = Stage G VERIFY 안 실 검증.",
      "rationale": "RESEARCH R1 mitigation — context7 1차 검증 안 sub-dir nested 인식 동작 명시 부족. 안전 옵션 = 2 standalone subagent (environment-auditor + agents-md-sync) 개별 파일 명시 + project-harness-audit-team/ 디렉토리 명시 (5 멤버 일괄 인식). 실 검증 후 결과 narrative 안 정전화 가능.",
      "alternatives_rejected": ["전체 디렉토리 명시 (`./bootstrap/agents/audit/`) — sub-dir nested 인식 미확정 risk", "각 7 멤버 (2 standalone + 5 team) 모두 개별 파일 명시 — paths 길이 + 5 멤버 추가/제거 시 manifest 갱신 부담"]
    },
    {
      "id": "D7",
      "decision": "marketplace name + plugin name = 'harness-meta' 단일 (marketplace + plugin 동일 이름). source = `.` (plugin root = marketplace root 통합). marketplace.json 안 plugins[0].source = `.` 명시. 사용자 명령 = `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta`.",
      "rationale": "RESEARCH R3 mitigation — context7 marketplace.json 예시 안 'source: \"./plugins/formatter\"' 패턴 vs harness-meta 단일 plugin marketplace 통합. source = `.` 정합 + 명명 단순화 (harness-meta@harness-meta). 분리 (e.g., marketplace = 'harness-meta-marketplace' + plugin = 'harness-meta') 시 사용자 onboarding 명령 복잡화.",
      "alternatives_rejected": ["marketplace name = 'harness-meta-marketplace' + plugin name = 'harness-meta' — 사용자 명령 복잡화 + repo 이름 그대로 사용 narrative 약화"]
    },
    {
      "id": "D8",
      "decision": "bootstrap/claude-code-catalog/README.md.bak cleanup — phase-3 안 `git rm` 으로 cleanup. v4.0 phase-4 산출물 backup 추정 (catalog README 작성 시 임시 backup), 본 milestone scope 안 cleanup 정합.",
      "rationale": "RESEARCH R8 mitigation — git status 안 untracked 표지 + .bak 확장자 = backup 잠재. 본 milestone narrative cascade scope 안 cleanup 자연 흡수. 사용자 결정 게이트 부재 (의도치 않은 file).",
      "alternatives_rejected": ["OOS (보존) — backup 파일 보존 narrative 부재 + git untracked 상태 잔존 risk"]
    },
    {
      "id": "D9",
      "decision": "Stage G VERIFY 안 실 plugin install 검증 의무 — (1) `claude plugin marketplace add ~/harness-meta` 실행 후 `~/.claude/plugins/marketplaces/` 안 등재 확인. (2) `claude plugin install harness-meta@harness-meta` 실행 후 `~/.claude/plugins/cache/harness-meta/` 또는 동치 위치 안 plugin 거주 확인. (3) Claude Code 세션 안 subagent_type discovery (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer / environment-auditor / agents-md-sync 7 멤버) 검증. (4) commands 인식 (`/harness-meta`) 검증.",
      "rationale": "사용자 환경 안 ~/.claude/plugins/ 디렉토리 이미 존재 (RESEARCH 발견) — 즉시 실 검증 가능. context7 1차 검증 안 추정 부분 (R1/R2/R3) 의 실 검증 자연 정합.",
      "alternatives_rejected": ["VERIFY 안 manual 검증 부재 (smoke 14 hook 만) — paths 명시 sub-dir 인식 / Plugin install lifecycle / agent_type discovery 모두 사용자 환경 안 실 검증 의무"]
    },
    {
      "id": "D10",
      "decision": "D7 sequence 책임 분리 narrative — component-installer.md (bootstrap/agents/audit/project-harness-audit-team/) 본문 안 명시 — (a) custom component lifecycle = harness-meta 안 산출물 작성/edit/cleanup (milestone 산출물, .md 파일 신규 등), (b) Plugin install lifecycle = Claude Code 표준 CLI 명령 (`claude plugin install/uninstall/enable/disable`). D7 sequence 5 step 안 SymbolicLink/Junction/Copy fallback 부분 = deprecated 표지 (historical 보존, 현 v5.0 안 Plugin install lifecycle 채택). project-harness-audit-team/CLAUDE.md 안 e3 정책 install gate narrative 갱신 — Plugin install 시점 사용자 명시 게이트 narrative.",
      "rationale": "RESEARCH cascade narrative drift component_installer_responsibility 항목 mitigation. 책임 분리 narrative 정전화 = component-installer agent 의 본질 책임 (custom component lifecycle) 보존 + Plugin install (mechanical) Claude Code 표준 위임. v4.0 phase-3 + v4.1 D7 sequence narrative 직접 후속.",
      "alternatives_rejected": ["component-installer 폐기 — custom component lifecycle 책임 부재 시 audit-team 5 멤버 중 4 멤버만 활성, team orchestration narrative 약화", "D7 sequence 본문 즉시 삭제 — historical 보존 narrative 부재 + audit-team 5 멤버 narrative 부담"]
    },
    {
      "id": "D11",
      "decision": "narrative cascade 14 host edit — v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle 누적 적용. (a) DESIGN 안 정확 문구 1차 source (본 § 'cascade 표준 narrative' section + 각 host 별 정확 문구 정전화) + (b) phase-1/phase-2 EXECUTE Edit tool 안 정확 문구 그대로 삽입 + (c) phase-3 / Stage G VERIFY 안 grep 검증 (`claude plugin install` + `plugin marketplace add` + `.claude-plugin/plugin.json` 3 키워드).",
      "rationale": "v3.21 정전화 3 단계 패턴 누적 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 = 7 번째). 본 v5.0 = 8 번째 cycle. 14 host cascade 정확 문구 drift risk (R5) mitigation.",
      "alternatives_rejected": ["host 별 narrative 자유 작성 — 정확 문구 drift risk + cascade 부합도 측정 부재"]
    },
    {
      "id": "D12",
      "decision": "commit timing (b) — Stage G (VERIFY) commit 안 INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md/ROADMAP 통합 commit. phase-1/phase-2/phase-3 = 각각 1 commit (mechanical edit), Stage G 통합 commit 안 stage 산출물 + 갱신.",
      "rationale": "v4.1/v4.2/v4.3 패턴 정합. 산출물 영구 보존 보장 (commit 후 Stage G 갱신 산출물 git tracked).",
      "alternatives_rejected": ["commit timing (a) — phase-1 안 INTENT~APPROVE 포함, 산출물 분산 risk", "commit timing (c) — 별 chore commit, commit 개수 증가"]
    },
    {
      "id": "D13",
      "decision": "본 v5.0 산출물 안 forward propose 명령형 회피 — INTENT/RESEARCH/DESIGN 안 후속 milestone 거명 (예: 'v5.1 cleanup', 'v5.x 자연어 제거') 모두 사실 진술 형식 + PROPOSE 단계 안 단일 source 통합 흡수.",
      "rationale": "v3.10 부산물 정책 정합. forward propose 책임 = Stage I PROPOSE 단일 source. 본 milestone 산출물 안 forward propose 명령형 ('~을 별 milestone 으로 진행하자' 등) 사용 부재 grep 검증 의무 (Stage G).",
      "alternatives_rejected": []
    }
  ],
  "approach": "v5.0_plugin-pivot 의 전체 전략 = (1) `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json` 신규 (Plugin 변환 핵심) + (2) paths 명시 (replace-default agents/commands) 으로 현 디렉토리 구조 보존 + (3) 사용자 onboarding flow 전면 갱신 (`claude plugin marketplace add` + `claude plugin install`) + (4) 내부 narrative cascade 11 host 갱신 (D7 deprecation 표지 + claude plugin install 표준 명시) + (5) D7 책임 분리 narrative (custom component lifecycle vs Plugin install lifecycle) + (6) CHANGELOG [v5.0]! breaking entry + (7) bootstrap/claude-code-catalog/README.md.bak cleanup. 3 phase 분할 1 commit per phase. v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle 적용.",
  "phases": [
    {
      "n": 1,
      "title": "Plugin manifest 신규 + 사용자 onboarding cascade (3 host: README + AGENTS + root CLAUDE.md)",
      "scope": "본 phase 의 정확 범위 (사실 진술): (a) `.claude-plugin/plugin.json` 신규 작성 — manifest schema (name: 'harness-meta', version: '5.0.0', description, author, homepage, repository, license: 'MIT', keywords) + paths 명시 (agents/commands/hooks/statusline/skills 각 필드). (b) `.claude-plugin/marketplace.json` 신규 작성 — marketplace schema (name: 'harness-meta', owner, plugins[0]: {name: 'harness-meta', source: '.', description, version}). (c) README.md cascade edit — '## 설치' section 재작성: `git clone` + `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta` (scope user default) + 'deprecated: 자연어 \\'harness-meta 설치해줘\\' + D7 mechanical sequence' 표지 + Plugin install 후 ~/.claude/agents/ 잔존 SymbolicLink manual cleanup 권고 narrative. (d) AGENTS.md cascade edit — 영문 onboarding narrative 동치 갱신. (e) root CLAUDE.md cascade edit — '## 명령어 / ### 설치 (clone 후 1회)' section 재작성 동치.",
      "affected_files": [
        "projects/meta/milestones/v5.0/execute/phase-1.md",
        ".claude-plugin/plugin.json (신규)",
        ".claude-plugin/marketplace.json (신규)",
        "claude/hooks/hooks.json (신규, Plugin schema PostToolUse + SessionStart matcher)",
        "README.md (설치 section 재작성)",
        "AGENTS.md (영문 onboarding 동치)",
        "CLAUDE.md (root 설치 section 동치)"
      ],
      "rationale": "사용자-facing 핵심 (manifest 신규 + onboarding) 우선 분리. 사용자 가치 우선 + 외부 visibility (README/AGENTS) 명확.",
      "risks": [
        "plugin.json paths 명시 sub-dir nested 인식 미확정 (R1) — D6 안 안전 옵션 (sub-dir 별 명시) + Stage G 실 검증",
        "사용자 onboarding narrative 정확 문구 drift (R5) — D11 안 v3.21 3 단계 패턴 적용",
        "marketplace.json source 형식 (R3) — D7 안 source = '.' 정전 + Stage G 실 검증"
      ]
    },
    {
      "n": 2,
      "title": "내부 narrative cascade — 10 host edit (claude/CLAUDE.md + bootstrap/* + projects/meta/ARCHITECTURE.md + tests/CLAUDE.md + Makefile + .env.example + claude/commands/harness-meta.md + GUARDRAILS.md + bootstrap/claude-code-catalog/README.md + bootstrap/agents/CLAUDE.md)",
      "scope": "본 phase 의 정확 범위: 내부 narrative cascade 10 host edit — 각 host 안 install/symlink/junction/D7 sequence 관련 narrative 안 'deprecated, 새 표준: Plugin install' 표지 추가 + cascade 표준 narrative 정합. 구체 host: (1) claude/CLAUDE.md (8 occurrence — 글로벌 layer + 충돌 정책), (2) bootstrap/agents/CLAUDE.md (41 occurrence — agent 두 층 매트릭스 + § Install/Update/Cleanup), (3) bootstrap/skills/CLAUDE.md (10 occurrence — skill 배포 narrative), (4) projects/meta/ARCHITECTURE.md (4 occurrence — § 3.1 끝 install 정책 본질 paragraph + Plugin spec 본질 흡수), (5) tests/CLAUDE.md (7 occurrence — smoke 매트릭스 안 install 거명), (6) Makefile (8 occurrence — install target 폐기 또는 plugin 명령 대체), (7) .env.example (1 occurrence — HARNESS_META_ROOT narrative), (8) claude/commands/harness-meta.md (3 occurrence — D7 sequence 거명 갱신), (9) GUARDRAILS.md (3 occurrence — install/deploy 가드레일 narrative), (10) bootstrap/claude-code-catalog/README.md (3 occurrence — catalog narrative).",
      "affected_files": [
        "projects/meta/milestones/v5.0/execute/phase-2.md",
        "claude/CLAUDE.md",
        "bootstrap/agents/CLAUDE.md",
        "bootstrap/skills/CLAUDE.md",
        "projects/meta/ARCHITECTURE.md",
        "tests/CLAUDE.md",
        "Makefile",
        ".env.example",
        "claude/commands/harness-meta.md",
        "GUARDRAILS.md",
        "bootstrap/claude-code-catalog/README.md"
      ],
      "rationale": "내부 narrative 정합 부담 격리 — 사용자-facing phase-1 commit 안 단순 + 내부 cascade 별 commit 안 정합 부담 격리. 10 host scope 명확.",
      "risks": [
        "host 별 정확 문구 drift (R5) — D11 안 v3.21 3 단계 패턴 적용 + DESIGN 안 표준 narrative 정전화 (§ 'cascade 표준 narrative')",
        "bootstrap/agents/CLAUDE.md 41 occurrence + § Install/Update/Cleanup 책임 narrative 변경 부담 — phase-3 안 D7 책임 분리 narrative 와 일관 의무",
        "Makefile install target 폐기 vs 'install: @echo deprecated' stub 대체 — DESIGN.D8 패턴 (v4.2 Makefile stub) 참조 + Stage G smoke 회귀 검증"
      ]
    },
    {
      "n": 3,
      "title": "D7 책임 분리 narrative (component-installer.md + team CLAUDE.md) + CHANGELOG [v5.0]! breaking entry + bootstrap/claude-code-catalog/README.md.bak cleanup",
      "scope": "본 phase 의 정확 범위: (a) component-installer.md (bootstrap/agents/audit/project-harness-audit-team/) edit — D7 5 step sequence 본문 안 SymbolicLink/Junction/Copy fallback 부분 'deprecated 표지' 추가 + 책임 분리 narrative (custom component lifecycle vs Plugin install lifecycle) 신규 section. (b) project-harness-audit-team/CLAUDE.md edit — e3 정책 install gate narrative 갱신 (Plugin install 시점 사용자 명시 게이트). (c) CHANGELOG.md edit — [v5.0]! breaking entry 신규 (install 정책 전면 재설계 + 사용자 onboarding flow 변경 + Plugin manifest 신규 + cascade 14 host narrative). (d) bootstrap/claude-code-catalog/README.md.bak `git rm` cleanup.",
      "affected_files": [
        "projects/meta/milestones/v5.0/execute/phase-3.md",
        "bootstrap/agents/audit/project-harness-audit-team/component-installer.md",
        "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md",
        "CHANGELOG.md",
        "bootstrap/claude-code-catalog/README.md.bak (cleanup)"
      ],
      "rationale": "종결 narrative 격리 — D7 책임 분리 (audit-team source-of-truth) + CHANGELOG breaking entry + cleanup 자연 통합. 본 phase 종료 후 Stage G VERIFY 진입.",
      "risks": [
        "component-installer.md D7 sequence 본문 책임 분리 narrative 정합 부담 — 14 occurrence 키워드 보존 + deprecated 표지 + 새 책임 narrative 정합",
        "CHANGELOG [v5.0]! breaking entry 안 14 host cascade 거명 정합 — phase-1/phase-2 narrative 와 backward 정합 의무",
        "bootstrap/claude-code-catalog/README.md.bak cleanup 시 산출물 본문 손실 risk — RESEARCH 안 사실 진술 (backup 추정), 본 milestone scope 안 cleanup 결정 (D8)"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "description": "paths 명시 안 sub-dir nested .md 인식 동작 미확정",
      "mitigation": "D6 안 안전 옵션 — 2 standalone subagent 개별 파일 명시 + project-harness-audit-team/ 디렉토리 명시. Stage G VERIFY 안 실 검증 (`claude plugin install` 후 7 멤버 subagent_type discovery)."
    },
    {
      "risk_id": "R2",
      "description": "Plugin install 후 ~/.claude/agents/ 5 멤버 SymbolicLink 공존 시 agent_type duplicate risk",
      "mitigation": "D3 — manual cleanup 권고 narrative (README/AGENTS/root CLAUDE.md). Plugin install 안 namespacing 자동 적용 가능성 (context7 추가 검증 = Stage G VERIFY 안 실 확인)."
    },
    {
      "risk_id": "R3",
      "description": "marketplace.json source 형식 (단일 plugin marketplace)",
      "mitigation": "D7 — source = '.' 단일 plugin marketplace 채택. Stage G VERIFY 안 `claude plugin marketplace add ~/harness-meta` 후 marketplaces[] 등재 확인."
    },
    {
      "risk_id": "R4",
      "description": "scope default (user vs project)",
      "mitigation": "D5 — user scope default + project scope optional narrative. README/AGENTS/root CLAUDE.md 안 두 패턴 명시."
    },
    {
      "risk_id": "R5",
      "description": "14 host cascade 정확 문구 drift",
      "mitigation": "D11 — v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle. DESIGN 안 cascade 표준 narrative 정전화 + EXECUTE Edit 정확 문구 그대로 + VERIFY grep 키워드 3건 검증."
    },
    {
      "risk_id": "R6",
      "description": "5 멤버 audit-team orchestration narrative 정합",
      "mitigation": "현 bootstrap/agents/audit/project-harness-audit-team/ + CLAUDE.md 보존 + plugin manifest 안 paths 명시. team CLAUDE.md narrative 변경 부재 (sub-dir 자체 거주)."
    },
    {
      "risk_id": "R7",
      "description": "smoke 회귀 risk",
      "mitigation": "Stage G VERIFY 안 pre-commit 14 hook 의무 + D9 안 manual plugin install 검증."
    },
    {
      "risk_id": "R8",
      "description": "bootstrap/claude-code-catalog/README.md.bak cleanup",
      "mitigation": "D8 — phase-3 안 `git rm` cleanup. backup 잠재 사실 진술 + 본 milestone scope 안 자연 cleanup."
    },
    {
      "risk_id": "R9",
      "description": "D7 sequence 본문 책임 분리 narrative 정합 부담 (component-installer.md 14 occurrence)",
      "mitigation": "D10 — deprecated 표지 + 책임 분리 narrative 신규 section. historical 보존 + 새 책임 narrative 정전화."
    },
    {
      "risk_id": "R10",
      "description": "forward propose 명령형 risk (v3.10 부산물 정책 위반)",
      "mitigation": "D13 — 사실 진술만 사용 + Stage G VERIFY 안 grep 검증 ('별 milestone 으로' / '후속 milestone 안 처리' 등 명령형 패턴 0)."
    }
  ]
}
```

## cascade 표준 narrative (DESIGN 1차 source, v3.21 3 단계 패턴 (a))

본 v5.0 안 14 host cascade 표준 narrative — phase-1/phase-2/phase-3 EXECUTE Edit tool 안 정확 문구 그대로 삽입 의무 (v3.21 3 단계 패턴 (b) — host 별 자연 조정 허용, 표준 narrative 핵심 키워드 보존).

**핵심 키워드 3건 (VERIFY grep 검증 의무, v3.21 3 단계 패턴 (c))**:

- `claude plugin install` (Plugin install CLI 표준)
- `plugin marketplace add` (local marketplace 등록 명령)
- `.claude-plugin/plugin.json` (Plugin manifest 위치)

**deprecation 표지 표준 문구**:

> ~~harness-meta 설치해줘~~ (deprecated since v5.0) — 새 표준: `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta`.

**Plugin install 후 cleanup 권고 표준 문구**:

> Plugin install 후 `~/.claude/agents/` 안 v4.x SymbolicLink 잔존 시 충돌 회피 위해 수동 제거 권고. Linux/macOS: `rm ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md`. Windows: 동치 PowerShell `Remove-Item` 명령.

**onboarding 표준 narrative**:

> 1. `git clone https://github.com/pdw96/harness-meta $HOME/harness-meta`
> 2. `claude plugin marketplace add ~/harness-meta`
> 3. `claude plugin install harness-meta@harness-meta` (또는 `--scope user`/`project`/`local`)
> 4. (선택) v4.x SymbolicLink 잔존 cleanup
> 5. (선택) `pip install pre-commit && pre-commit install` (별도)

## phase-1 plugin.json 안 paths 명시 1차 source

```json
{
  "name": "harness-meta",
  "version": "5.0.0",
  "description": "Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer (5 멤버 audit-team + 2 standalone subagent + skills + slash commands + hooks + statusline)",
  "author": {
    "name": "Dowon Park",
    "email": "qkrehdnjs111@gmail.com",
    "url": "https://github.com/pdw96"
  },
  "homepage": "https://github.com/pdw96/harness-meta",
  "repository": "https://github.com/pdw96/harness-meta",
  "license": "MIT",
  "keywords": ["harness", "claude-code", "subagent", "skill", "workflow", "9-stage", "audit"],
  "agents": [
    "./bootstrap/agents/audit/environment-auditor.md",
    "./bootstrap/agents/audit/agents-md-sync.md",
    "./bootstrap/agents/audit/project-harness-audit-team/"
  ],
  "commands": [
    "./claude/commands/"
  ],
  "hooks": "./claude/hooks/hooks.json",
  "skills": "./bootstrap/skills/"
}
```

**참고** — `hooks` 필드 = `./claude/hooks/hooks.json` 명시 (또는 inline JSON). 현 claude/hooks/ 디렉토리 안 .sh 파일 직접 거주 → Plugin schema 안 hooks.json 정전 의무. **Stage F phase-1 안 claude/hooks/hooks.json 신규 작성 또는 inline JSON 명시 분기 결정** (Stage G VERIFY 안 실 검증).

## phase-1 marketplace.json 안 plugin entry 1차 source

```json
{
  "name": "harness-meta",
  "owner": {
    "name": "Dowon Park",
    "email": "qkrehdnjs111@gmail.com"
  },
  "plugins": [
    {
      "name": "harness-meta",
      "source": ".",
      "description": "Project harness composer + Claude Code ecosystem integrator + agent fleet maintainer",
      "version": "5.0.0",
      "author": {
        "name": "Dowon Park"
      },
      "homepage": "https://github.com/pdw96/harness-meta",
      "repository": "https://github.com/pdw96/harness-meta",
      "license": "MIT",
      "keywords": ["harness", "claude-code", "subagent", "skill", "workflow", "9-stage", "audit"],
      "category": "productivity"
    }
  ]
}
```

## 5 관점 검토 결과 (scope 큼 18 파일, 5 관점 전체 의무)

본 milestone scope = 18 affected_files (3 신규 + 14 cascade + 1 cleanup) → 5 관점 검토 전체 의무. 5 관점 병렬 subagent invoke 완료 (architecture: Plan / spec-drift: general-purpose context7 / 회귀 risk: Explore / 보안: general-purpose / scope contract: Explore). **5 관점 모두 PASS 또는 PASS_WITH_COMMENTS, FAIL 0건, 의견 충돌 0건**.

### 관점 별 verdict + 핵심 findings

- **architecture (Plan)**: PASS_WITH_COMMENTS — 4 권고 (phase-1 hooks.json 결정 명시화 / D10 책임 분리 narrative 구체화 / phase-1 transient note / D6 sub-dir nested 인식 결과 정전화 의무). 핵심 정합 (D1 정체성 narrative / phase 분할 self-contained).
- **spec-drift (general-purpose + context7)**: PASS_WITH_COMMENTS — 3 권고 (D6 commands precedent narrative / hooks.json minimum schema enumeration / statusline 필드 부재 narrative). 핵심 정합 (D7 source `.` / D6 paths 명시 / 모든 metadata 필드).
- **회귀 risk (Explore)**: PASS_WITH_COMMENTS — 7 active smoke + 14 pre-commit hook 회귀 risk LOW. 5 조건 Stage G 흡수 의무 (manifest jq 검증 / D11 narrative discipline / smoke-cross-ref --fix 시점 / phase 별 JSON 유효성).
- **보안 (general-purpose + security-review SKILL)**: PASS_WITH_COMMENTS — 3 권고 (D3 PowerShell 동치 + 사전 verify / D9 dual-active 검출 / D2 명시화). 핵심 정합 (Plugin spec trust model = 사용자 환경 위임, harness-meta 신규 vector 부재).
- **scope contract (Explore)**: PASS — sc 10/10 매핑 + oos 6/6 사실 진술 + forward propose 명령형 0건 + v3.10 부산물 정책 정합. recommendation = keep.

### 권고 흡수 narrative (총 7 권고, 모두 DESIGN narrative 1~3 줄 보정 수준)

| 권고 # | 출처 관점 | 보정 위치 | 흡수 narrative |
|--|--|--|--|
| 1 | architecture / spec-drift | D6 rationale + phase-1 paths 명시 1차 source | sub-dir 디렉토리 명시 (`./bootstrap/agents/audit/project-harness-audit-team/`) 는 spec **commands array 안 디렉토리 entry 예시** 으로부터 inferred (context7 plugin-marketplaces Advanced Plugin Entry Configuration 안 `commands: ['./commands/core/', ...]`). `agents` 필드 안 디렉토리 entry 동작은 spec 안 직접 documented 부재 — **Stage G VERIFY 실 검증 mandatory** (optional 확인 아님). 검증 결과 narrative REPORT.md 안 정전화 의무. |
| 2 | architecture / spec-drift | phase-1 hooks.json 결정 + minimum schema | **phase-1 affected_files 안 `.claude-plugin/hooks.json` 또는 `./claude/hooks/hooks.json` 신규 추가**. minimum schema: (a) PostToolUse matcher (`Write\|Edit` 등) + command `${CLAUDE_PLUGIN_ROOT}/claude/hooks/post-report-write.sh`, (b) SessionStart matcher + command `${CLAUDE_PLUGIN_ROOT}/claude/hooks/session-init.sh`. claude/hooks/{session-init,post-report-write}.sh 본문 변경 부재 (RESEARCH.untouched_files 정합) + hooks.json 신규 작성만. |
| 3 | architecture | D10 책임 분리 narrative 구체화 | component-installer 잔여 책임 narrative phase-3 안 명시 의무 — (a) Plugin install 후 ~/.claude/agents/ 잔존 cleanup 검증 (verifier 책임) + (b) custom component lifecycle 보존 (milestone 산출물 mechanical apply). 5 멤버 team narrative 회귀 방지. |
| 4 | architecture | phase-1 transient note | phase-1 commit 후 phase-2 완료 전 사용자-facing/내부 narrative drift mitigation — phase-1 EXECUTE 안 README/AGENTS/root CLAUDE.md edit 시 내부 cascade 진행 표지 부재 = pre-commit smoke-claude-md-drift 의 false positive risk 자연 흡수 (3 phase 모두 commit 후 smoke-cross-ref --fix 시점 통합). 추가 narrative 부재 채택 — pre-commit hook은 phase 별 단독 PASS 가능 (회귀 risk Explore PASS 정합). |
| 5 | 보안 | D3 cleanup 권고 narrative 강화 | Windows PowerShell 동치 명령 명시 + 사전 verify 1단계 권고: <br>`# Linux/macOS:`<br>`ls ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md`<br>`rm ~/.claude/agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md`<br>`# Windows PowerShell:`<br>`Get-ChildItem $env:USERPROFILE\.claude\agents\{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md`<br>`Remove-Item $env:USERPROFILE\.claude\agents\{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md` |
| 6 | 보안 | D9 VERIFY 안 dual-active 검출 | Stage G VERIFY 안 plugin install 검증 step 5 신규 — (5) ~/.claude/agents/ 안 5 멤버 SymbolicLink 잔존 검출 (`Get-ChildItem ~/.claude/agents/`) 후 plugin cache (`~/.claude/plugins/`) 안 동명 plugin 거주 시 dual-active 표지 narrative 보고. cleanup 권고 narrative 정합 (D3). |
| 7 | 보안 | D2 deprecation 표지 명시화 | cascade 표준 narrative 안 deprecation 표지 — `~~harness-meta 설치해줘~~ (deprecated since v5.0, v5.0+ 환경에서는 비활성)` 형식 ('v5.0+ 환경에서는 비활성' 명시 추가). |

### D6 보정 narrative (권고 #1)

D6 rationale 안 추가 narrative: "context7 plugin-marketplaces (Advanced Plugin Entry Configuration) 안 `commands: ['./commands/core/', ...]` 디렉토리 entry 예시 확인 — `agents` 필드 안 디렉토리 entry 동작은 spec 안 직접 documented 부재. inferred by analogy with `commands` array. Stage G VERIFY 실 검증 **mandatory** (optional 확인 아님). 검증 결과 narrative REPORT.md 안 정전화 의무."

### phase-1 plugin.json 안 hooks.json 결정 (권고 #2)

phase-1 affected_files 안 `.claude-plugin/hooks.json` 또는 `./claude/hooks/hooks.json` 신규 추가. plugin.json 안 `hooks` 필드 = `./claude/hooks/hooks.json` (또는 `./.claude-plugin/hooks.json` 분기). hooks.json 최소 schema:

```json
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit",
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/claude/hooks/post-report-write.sh"
        }
      ]
    }
  ],
  "SessionStart": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/claude/hooks/session-init.sh"
        }
      ]
    }
  ]
}
```

본 hooks.json 신규 작성 = phase-1 affected_files 추가 1건. claude/hooks/{session-init,post-report-write}.sh 본문 변경 부재.

### statusline 필드 narrative (권고 #2 분기)

Plugin manifest 안 `statusline` 필드 spec 부재 — phase-1 plugin.json 안 statusline 필드 명시 부재. claude/statusline/statusline.sh 의 plugin 안 거주 narrative = Plugin spec 안 직접 매핑 부재 = harness-meta 안 settings.json 배포 (또는 plugin 안 settings.json field) 통해 활성. **본 milestone 안 statusline 배포는 Plugin manifest 외 mechanism 보존** (`~/.claude/settings.json` 안 statusline 명시 패턴 보존, deprecated narrative 부재). REPORT.md 안 narrative 정전화.

### D10 책임 분리 narrative 구체화 (권고 #3)

phase-3 component-installer.md edit 안 책임 분리 narrative 구체화 의무: (a) Plugin install 후 ~/.claude/agents/ 잔존 SymbolicLink cleanup 검증 책임 + (b) custom component lifecycle (milestone 산출물 안 .md 신규 mechanical apply) 보존 책임. 두 책임 정합 → 5 멤버 audit-team narrative 보존 (team CLAUDE.md § Orchestration sequence 안 component-installer Step 5 = (a) verifier + (b) custom apply 통합).

### D9 VERIFY 5 step (권고 #6)

Stage G VERIFY 안 실 plugin install 검증 5 step (기존 4 step + 1 신규):

1. `claude plugin marketplace add ~/harness-meta` 실행 후 `~/.claude/plugins/marketplaces/` 안 등재 확인
2. `claude plugin install harness-meta@harness-meta` 실행 후 `~/.claude/plugins/cache/harness-meta/` 또는 동치 위치 안 plugin 거주 확인
3. Claude Code 세션 안 subagent_type discovery (7 멤버) 검증
4. commands 인식 (`/harness-meta`) 검증
5. **dual-active 검출** — `Get-ChildItem ~/.claude/agents/` (5 멤버 SymbolicLink 잔존) + `Get-ChildItem ~/.claude/plugins/cache/harness-meta/` 비교 narrative 보고 (cleanup 권고 narrative 정합).

### D2 deprecation 표지 명시화 (권고 #7)

cascade 표준 narrative 안 deprecation 표지 갱신:

> ~~harness-meta 설치해줘~~ (deprecated since v5.0, v5.0+ 환경에서는 비활성) — 새 표준: `claude plugin marketplace add ~/harness-meta` + `claude plugin install harness-meta@harness-meta`.

### 5 관점 검토 결과 종합

7 권고 모두 narrative 1~3 줄 보정 수준 (DESIGN.md 내부 흡수 완료, structural 변경 없음). 5 관점 verdict 합산 결과 = PASS (FAIL 0건 + 의견 충돌 0건). Stage E APPROVE 게이트 진입 정합.

## Stage D 완료 직전 의무 step (v3.5 도입)

`phases[]` 확정 직후 → `milestones/v5.0/milestones.md` `sub_milestones[]` 를 `phases[]` (3 phase) 와 1:1 동기 갱신 (placeholder title 교체). 본 step 다음 진행.

## narrative

본 DESIGN 의 핵심 narrative — **harness-meta repo 를 Claude Code Plugin 으로 변환** (O1 채택, 사용자 round 1 명시). 현 디렉토리 구조 보존 + paths 명시 (replace-default) + 사용자 onboarding flow 전면 갱신 (CLI 명령 표준화) + 자연어 호출 narrative deprecation 표지 + 5 멤버 SymbolicLink manual cleanup 권고. 3 phase 분할 + v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle 적용. v4.0 (정체성 pivot) + v4.3 (Plugin spec 발견) 직접 후속 두 번째 major bump (v4→v5).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH (context7 5 source 검증): [`RESEARCH.md`](RESEARCH.md)
- v4.3 RESEARCH (1차 source): [`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md)
- v4.1 D7 sequence: [`../v4.1/DESIGN.md`](../v4.1/DESIGN.md)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
- v3.21 narrative 정전화 3 단계 패턴: [`../_archive/v3.21/DESIGN.md`](../_archive/v3.21/DESIGN.md)

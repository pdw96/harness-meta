# RESEARCH — v5.0 plugin-pivot

```json
{
  "external": [
    {
      "source": "context7 /websites/code_claude — plugins-reference (https://code.claude.com/docs/en/plugins-reference) — Complete Plugin Manifest Schema",
      "topic": "plugin.json 완전 schema + 필드별 의미",
      "findings": "plugin.json 안 명시 필드: name (string, kebab-case), version (semver), description, author (object: name/email/url), homepage, repository, license, keywords (array). component path 필드: `skills` (string 경로 — default `skills/` 에 **추가** add-to-default 동작), `commands` (string 경로 또는 array — default `commands/` **대체** replace-default 동작), `agents` (array of paths — default `agents/` **대체**), `hooks` (string 경로 또는 inline JSON), `mcpServers` (string 경로 또는 inline), `outputStyles` (string 경로), `lspServers` (string 경로). 모든 paths = plugin root 기준 relative + `./` prefix 의무. paths array entry = 디렉토리 (`./commands/core/`) 또는 개별 .md 파일 (`./custom/agents/reviewer.md`) 둘 다 지원. 디렉토리 명시 시 안 .md 파일 자동 인식.",
      "drift": "glob (`./bootstrap/agents/audit/**/*.md` 등) 명시 부재 — array entry = 디렉토리 또는 개별 파일. 본 harness-meta 안 sub-dir nested .md (예: `bootstrap/agents/audit/project-harness-audit-team/<member>.md` 5 멤버) = 디렉토리 명시 (`./bootstrap/agents/audit/project-harness-audit-team/`) 으로 일괄 인식 가능. 즉 paths 명시 시 `agents: ['./bootstrap/agents/audit/']` (audit 디렉토리 + sub-dir 자동 인식 검증 필요 — 또는 sub-dir 별 명시 ['./bootstrap/agents/audit/project-harness-audit-team/', './bootstrap/agents/audit/environment-auditor.md', './bootstrap/agents/audit/agents-md-sync.md']) 의 분기 — DESIGN 단계 검증 의무."
    },
    {
      "source": "context7 /websites/code_claude — plugins-reference (https://code.claude.com/docs/en/plugins-reference) — Standard Claude Plugin Directory Structure",
      "topic": "Plugin 표준 디렉토리 구조",
      "findings": "표준 구조: `.claude-plugin/plugin.json` (manifest, optional) + `skills/<name>/SKILL.md` + `commands/*.md` (flat) + `agents/<name>.md` (flat) + `output-styles/<name>.md` + `themes/*.json` + `monitors/monitors.json` + `hooks/hooks.json` + `bin/` (executables, PATH 추가) + `settings.json` (defaults) + `.mcp.json` + `.lsp.json` + `scripts/` + `LICENSE` + `CHANGELOG.md`. agents/ 표준 = flat `.md` 파일.",
      "drift": "본 harness-meta 안 nested 구조 (bootstrap/agents/audit/<member>.md + bootstrap/agents/audit/project-harness-audit-team/<member>.md) ↔ Plugin 표준 (flat agents/<name>.md) — 정합 위해 paths 명시 (replace-default agents 필드) 활용 가능. v4.2 narrative 안 'standalone subagent .md 단일 파일 거주' (environment-auditor.md / agents-md-sync.md) + 'team 5 멤버 sub-dir 거주' 패턴 보존 정합."
    },
    {
      "source": "context7 /websites/code_claude — plugin-marketplaces (https://code.claude.com/docs/en/plugin-marketplaces) — Define Company Tools Marketplace + Create the marketplace file",
      "topic": "marketplace.json schema + plugin entry source 형식",
      "findings": "marketplace.json 안 필수 필드: `name` (marketplace 이름), `owner` (object: name/email), `plugins` (array). 각 plugin entry: `name` (필수), `source` (필수 — 문자열 local path `./plugins/formatter` 또는 객체 `{source: 'github', repo: '...'}` 또는 `{source: 'git', repo: '...'}` 또는 `{source: 'url', url: '...'}`), `description`, `version`, `author`, `keywords`, `category`, `homepage`, `repository`, `license`, 또한 plugin 자체 component path 필드 (`commands`/`agents`/`hooks`/`mcpServers`) inline 명시 가능 (plugin.json 안 명시와 동치).",
      "drift": "harness-meta 안 marketplace.json 동시 publish 시 — name: 'harness-meta' (또는 별칭) + plugins[0] = {name: 'harness-meta', source: '.', ...} 또는 source: './' (plugin root) 정합. 사용자 입장: `claude plugin marketplace add ~/harness-meta` 후 `claude plugin install harness-meta@harness-meta` (또는 marketplace name 분리 시 `harness-meta-marketplace@harness-meta`)."
    },
    {
      "source": "context7 /websites/code_claude — plugins-reference (https://code.claude.com/docs/en/plugins-reference) — claude plugin install + uninstall + Configure Custom Path Behavior",
      "topic": "Plugin install/uninstall CLI + paths 명시 동작",
      "findings": "`claude plugin install <plugin>[@<marketplace>] [-s|--scope <user|project|local>]` — user (default, 전역) / project (.claude/settings.json 안 share) / local (gitignored). `claude plugin uninstall <plugin> [--prune]` — prune 옵션 안 auto-installed dependency cleanup. `agents`/`commands` 필드 명시 시 **replace default** — 즉 명시 시 default 디렉토리 (`agents/`/`commands/`) 무시. `skills`/`hooks`/`mcpServers` 는 **add-to-default**. paths 는 plugin root 기준 relative, `./` prefix 의무.",
      "drift": "harness-meta 본 milestone scope = paths 명시 (replace-default) 활용 — 현 구조 (`bootstrap/agents/`) 보존 + plugin.json 안 `agents: ['./bootstrap/agents/audit/', './bootstrap/agents/audit/project-harness-audit-team/']` 또는 동치 명시. install scope = **user** default 채택 권고 (현 `~/.claude/agents/` 5 멤버 SymbolicLink 패턴 정합 + 사용자 전역 활성)."
    },
    {
      "source": "context7 /websites/code_claude — Advanced Plugin Entry Configuration + ${CLAUDE_PLUGIN_ROOT} variable",
      "topic": "marketplace.json 안 plugin entry 안 paths inline 명시 + ${CLAUDE_PLUGIN_ROOT} 변수",
      "findings": "marketplace.json 안 plugin entry 가 plugin.json 안 모든 필드 inline 명시 가능 (commands/agents/hooks/mcpServers 등). hooks 안 command 경로 = `${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh` 패턴 — install 후 plugin 실제 위치 (e.g., ~/.claude/plugins/<plugin>/) 참조. mcpServers 안 args 도 동치.",
      "drift": "harness-meta 안 claude/hooks/*.sh + claude/statusline/statusline.sh 거주 — Plugin manifest 안 hooks 필드 명시 시 `${CLAUDE_PLUGIN_ROOT}/claude/hooks/<hook>.sh` 형식 채택 정합. 단 본 milestone 안 hooks/statusline 명시는 sc_1 의무 (paths 명시) 안 포함."
    }
  ],
  "codebase": {
    "current_state": {
      "install_mechanism": "v4.0~v4.2 install 정책: bootstrap/agents/audit/ + bootstrap/skills/<category>/ + claude/{commands,hooks,statusline}/ source-of-truth (git tracked) → `~/.claude/<category>/` 안 SymbolicLink (Windows Developer Mode 활성) 또는 Junction (Windows default, directory only) 또는 Copy fallback (D7 step 4) → component-installer agent (D7 sequence 5 step) 안 mechanical 흡수.",
      "deployment_reality": "현 ~/.claude/agents/ 안 5 멤버 audit-team SymbolicLink 작동 확인 (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer). 2 standalone subagent (environment-auditor + agents-md-sync) ~/.claude/agents/ 안 미배포 (v4.2 phase-1 source 만, deployment 부재).",
      "plugin_system_already_active": "**중요 발견** — 사용자 환경 안 ~/.claude/plugins/ 디렉토리 이미 존재: marketplaces/, known_marketplaces.json, installed_plugins.json, cache/, blocklist.json, install-counts-cache.json, data/. 즉 Claude Code plugin system 이미 활성 — v5.0 안 plugin 등록 시 즉시 인식 가능 (실 검증 가능).",
      "no_claude_plugin_dir": "harness-meta repo 안 `.claude-plugin/` 디렉토리 부재 — Glob `.claude-plugin/**/*` 결과 No files found. v5.0 의 첫 산출물 = `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json` 신규 작성."
    },
    "cascade_host_inventory": {
      "narrative_total_occurrences": "install/symlink/junction/component-installer 키워드 총 178 occurrence (메타 milestone 산출물 제외 active host 14건 + tests/_inactive 1건 + bootstrap/claude-code-catalog/README.md.bak 1건).",
      "active_hosts_with_count": [
        {"host": "bootstrap/agents/CLAUDE.md", "occurrences": 41, "scope": "agent 두 층 매트릭스 + Component-installer mechanical sequence (D7) + § Install/Update/Cleanup 책임 narrative"},
        {"host": "CHANGELOG.md", "occurrences": 17, "scope": "v3.x~v4.x install/symlink/Junction narrative entry 안 historical"},
        {"host": "bootstrap/agents/audit/project-harness-audit-team/component-installer.md", "occurrences": 14, "scope": "D7 5 step sequence 본문 + agent 책임 narrative"},
        {"host": "README.md", "occurrences": 12, "scope": "사용자 onboarding narrative — 'harness-meta 설치해줘' 자연어 호출 + install 명령 narrative"},
        {"host": "bootstrap/skills/CLAUDE.md", "occurrences": 10, "scope": "skill 배포 narrative + install lifecycle"},
        {"host": "claude/CLAUDE.md", "occurrences": 8, "scope": "글로벌 레이어 install/deploy 충돌 정책 + symlink narrative"},
        {"host": "Makefile", "occurrences": 8, "scope": "install target + verify stub"},
        {"host": "tests/CLAUDE.md", "occurrences": 7, "scope": "smoke 매트릭스 안 install 관련 smoke 거명"},
        {"host": "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md", "occurrences": 6, "scope": "team orchestration 안 component-installer 거명 + e3 정책 install gate"},
        {"host": "CLAUDE.md (root)", "occurrences": 6, "scope": "설치 (clone 후 1회) section + 'harness-meta 설치해줘' 호출 narrative"},
        {"host": "AGENTS.md", "occurrences": 4, "scope": "영문 사용자 onboarding narrative — install command 거명"},
        {"host": "projects/meta/ARCHITECTURE.md", "occurrences": 4, "scope": "§ 3.1 끝 install 정책 본질 paragraph (v4.3 도입) + § 3.1 mechanical 본질 paragraph (v4.2 도입)"},
        {"host": "bootstrap/claude-code-catalog/README.md", "occurrences": 3, "scope": "catalog 안 install 관련 명령 + plugin 카테고리 narrative"},
        {"host": "GUARDRAILS.md", "occurrences": 3, "scope": "install/deploy 가드레일 narrative — Developer Mode 의존성"},
        {"host": "claude/commands/harness-meta.md", "occurrences": 3, "scope": "신규 프로젝트 도입 narrative 안 component-installer subagent 거명 + D7 sequence 거명"},
        {"host": ".env.example", "occurrences": 1, "scope": "HARNESS_META_ROOT 환경변수 narrative"}
      ],
      "inactive_hosts": [
        {"host": "tests/_inactive/smoke-skills-install.sh", "rationale": "v3.x archive smoke, 본 milestone 영향 부재"},
        {"host": "bootstrap/claude-code-catalog/README.md.bak", "rationale": "git status 안 untracked 표지, 임시/cleanup 후보. RESEARCH 안 사실 진술 — 본 milestone scope 안 cleanup 결정 가능 (DESIGN 단계)"}
      ]
    },
    "affected_files_estimate": {
      "new_files": [
        ".claude-plugin/plugin.json (manifest, 신규)",
        ".claude-plugin/marketplace.json (local marketplace catalog, 신규)"
      ],
      "edit_cascade_install_narrative": [
        "README.md (사용자 onboarding flow 갱신, 12 occurrence)",
        "AGENTS.md (영문 onboarding, 4 occurrence)",
        "CLAUDE.md (root, 설치 section 재작성, 6 occurrence)",
        "claude/CLAUDE.md (8 occurrence)",
        "bootstrap/agents/CLAUDE.md (41 occurrence — D7 narrative 책임 분리)",
        "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md (6 occurrence — e3 install gate narrative)",
        "bootstrap/agents/audit/project-harness-audit-team/component-installer.md (14 occurrence — D7 sequence 책임 분리)",
        "bootstrap/skills/CLAUDE.md (10 occurrence)",
        "projects/meta/ARCHITECTURE.md (4 occurrence — § 3.1 끝 'Install 정책 본질 + Plugin spec 대안' paragraph v4.3 narrative 흡수 + 정전화)",
        "claude/commands/harness-meta.md (3 occurrence — D7 sequence 거명 갱신)",
        "GUARDRAILS.md (3 occurrence)",
        "bootstrap/claude-code-catalog/README.md (3 occurrence)",
        "tests/CLAUDE.md (7 occurrence — install smoke narrative)",
        "Makefile (8 occurrence — install target 폐기 또는 plugin 명령 대체)",
        ".env.example (1 occurrence)",
        "CHANGELOG.md ([v5.0]! breaking entry 신규)"
      ],
      "untouched_files_explicit": [
        "claude/hooks/session-init.sh + claude/hooks/post-report-write.sh (spec 의무 컴포넌트, plugin manifest 안 paths 명시만 — 본문 변경 부재)",
        "claude/statusline/statusline.sh (spec 의무 컴포넌트, 동치)",
        "bootstrap/agents/audit/{environment-auditor,agents-md-sync}.md (source 변경 부재, 단 plugin manifest 안 paths 명시 안 거주)",
        "bootstrap/agents/audit/project-harness-audit-team/*.md (5 멤버 source 변경 부재, plugin manifest 안 paths 명시 안 거주)",
        "bootstrap/skills/*/SKILL.md (skills 본문 변경 부재)",
        "tests/smoke-*.sh (회귀 0 보장 — install smoke 변경은 narrative 만)",
        ".pre-commit-config.yaml (신규 hook 추가 부재)",
        "v3.x archive milestone 산출물 (historical 보존)"
      ]
    },
    "current_install_narrative_drift": {
      "developer_mode_dependency": "v4.1 D7 sequence 안 'Junction default Windows / SymbolicLink default Linux/macOS' narrative — plugin install lifecycle 채택 시 Developer Mode 의존 0 narrative 갱신 의무.",
      "harness_meta_natural_language": "현 'harness-meta 설치해줘' 자연어 호출 narrative (README/AGENTS/root CLAUDE.md) — plugin install CLI (`claude plugin install`) 표준화 시 deprecation 또는 폐기 narrative 의무.",
      "two_standalone_subagent_undeployed": "v4.2 phase-1 source 신규 (environment-auditor + agents-md-sync) ~/.claude/agents/ 미배포 — plugin manifest 안 paths 명시 시 자연 해소.",
      "component_installer_responsibility": "v4.0 phase-3 component-installer agent (D7 sequence 5 step) — plugin install lifecycle 채택 시 D7 sequence 책임 일부 (SymbolicLink/Junction/Copy fallback mechanical) Claude Code CLI 대체. 책임 분리 narrative 의무 (sc_4)."
    }
  },
  "options": [
    {
      "id": "O1",
      "title": "Plugin 변환 (P1 전면) + paths 명시 (replace-default) — 현 구조 보존",
      "approach": "harness-meta 안 `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json` 신규 + plugin.json 안 paths 명시 (agents/commands/hooks/statusline/skills 각 필드 안 replace-default 경로). 현 bootstrap/agents/audit/ + bootstrap/skills/<category>/ + claude/{commands,hooks,statusline}/ 디렉토리 구조 보존 — paths 명시만 추가. 사용자 onboarding flow 전면 갱신 (`claude plugin marketplace add ./harness-meta` + `claude plugin install harness-meta@harness-meta`). install script 3개 (v4.0 phase-3 폐기 완료) + D7 sequence (component-installer agent) 자연어 install 부분 폐기 또는 deprecation.",
      "pros": [
        "현 디렉토리 구조 (bootstrap/agents/audit/ 등) 보존 — git history + cross-ref 정합",
        "Claude Code 표준 메커니즘 채택 (Plugin spec)",
        "사용자 onboarding 표준 (CLI 명령)",
        "Developer Mode 의존 0",
        "install scope 선택 가능 (user/project/local)",
        "plugin lifecycle (enable/disable/uninstall) 표준 지원",
        "2 standalone subagent 미배포 자연 해소",
        "v4.0 ecosystem integrator 정체성 정합"
      ],
      "cons": [
        "Breaking change (v5.0 major bump)",
        "install narrative cascade 14 host 전체 재작성",
        "사용자 onboarding flow 변경 (자연어 → CLI)",
        "paths 명시 sub-dir nested 인식 검증 의무 (DESIGN 단계)"
      ]
    },
    {
      "id": "O2",
      "title": "Plugin 변환 + 디렉토리 재구성 (Plugin 표준 flat 구조 정합)",
      "approach": "Plugin 표준 (agents/<name>.md flat + commands/*.md flat + skills/<name>/SKILL.md) 으로 디렉토리 재구성. bootstrap/agents/audit/ → agents/ 이동 + bootstrap/skills/ → skills/ 이동 + claude/{commands,hooks,statusline}/ → commands/+hooks/+statusline/ 이동. paths 명시 부재 (default directory 활용).",
      "pros": [
        "Plugin 표준 정확 정합",
        "paths 명시 narrative 단순화"
      ],
      "cons": [
        "디렉토리 구조 대대적 재구성 — git history + cross-ref 14 host 추가 갱신 부담",
        "프로젝트 격리 narrative (bootstrap/ 안 거주 = global vs claude/ 안 거주 = layer 별) 사라짐",
        "v4.0 phase-3 narrative 정합 약화 (bootstrap/ prefix 분리 의도)"
      ]
    },
    {
      "id": "O3",
      "title": "Plugin 점진 채택 (P2) — 현 install 메커니즘 보존 + Plugin install 옵션 추가",
      "approach": ".claude-plugin/plugin.json 추가 + paths 명시 + 사용자 선택권 (자연어 install vs Plugin install). 현 D7 sequence 보존 (deprecation 없이 dual).",
      "pros": [
        "Breaking change 부재 (v4.4 minor bump)",
        "사용자 선택권 보유"
      ],
      "cons": [
        "이중 구조 narrative — 사용자 혼란",
        "narrative cascade 부담 (두 경로 균형)",
        "최종 단순화 (Plugin only) 까지 추가 cycle 필요",
        "v4.3 DESIGN.D2 사용자 결정 (a) v5.0_plugin-pivot pending entry 등재 narrative 와 모순"
      ]
    },
    {
      "id": "O4",
      "title": "harness-meta 가 분리된 marketplace + 별도 plugin 모듈 (multi-plugin marketplace)",
      "approach": "marketplace.json 안 단일 plugin 'harness-meta' 거주 vs 복수 plugin ('harness-meta-core' + 'harness-meta-audit-team' + 'harness-meta-skills' 등 분리). 각 plugin 별 독립 install.",
      "pros": [
        "사용자 선택권 (audit-team 만 install / skill 만 install 등)",
        "plugin 격리 narrative 강화"
      ],
      "cons": [
        "marketplace.json + 복수 plugin.json 관리 부담",
        "5 멤버 audit-team 의존성 narrative 복잡화 (team orchestration source-of-truth 분산)",
        "사용자 onboarding 부담 (단일 명령 vs 복수 명령)",
        "본 milestone scope 거대화"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "description": "paths 명시 안 sub-dir nested .md 인식 동작 — plugin.json `agents: ['./bootstrap/agents/audit/']` 시 sub-dir (project-harness-audit-team/) 안 .md 자동 인식 여부 미확정. context7 1차 검증 안 명시 부족.",
      "severity": "medium",
      "mitigation_hint": "DESIGN 단계 안 안전 옵션 = sub-dir 별 명시 (`['./bootstrap/agents/audit/environment-auditor.md', './bootstrap/agents/audit/agents-md-sync.md', './bootstrap/agents/audit/project-harness-audit-team/']`) 또는 7 멤버 각 .md 직접 명시. 실 검증 = `claude plugin marketplace add ./harness-meta` + `claude plugin install harness-meta@harness-meta` 후 agent_type discovery 확인 (Stage G VERIFY 의무)."
    },
    {
      "id": "R2",
      "description": "Plugin install 후 ~/.claude/plugins/<plugin>/ 안 거주 + 현 ~/.claude/agents/ 5 멤버 SymbolicLink 공존 가능성. 둘 다 활성 시 subagent_type duplicate 또는 충돌 risk.",
      "severity": "medium",
      "mitigation_hint": "사용자 명시 결정 게이트 — Plugin install 후 기존 ~/.claude/agents/ 안 5 멤버 SymbolicLink cleanup 권고 narrative (Stage E APPROVE 안 cleanup 동의 게이트). 또는 plugin name namespacing 으로 충돌 회피 (agent name 안 plugin prefix 자동 추가 가능, context7 추가 검증 필요)."
    },
    {
      "id": "R3",
      "description": "marketplace.json 안 plugin source 형식 — local marketplace 경우 source 가 plugin root 기준 relative path. harness-meta repo 자체 = marketplace root + plugin root 통합 (단일 plugin 구조). source = '.' 또는 './' 정합 검증 필요.",
      "severity": "low",
      "mitigation_hint": "context7 marketplace.json 예시 안 'source: \"./plugins/formatter\"' = marketplace root 안 sub-dir. 본 milestone 안 단일 plugin = 'source: \".\"' 또는 'source: \"./\"' 정합 (DESIGN 안 결정). 실 검증 = `claude plugin marketplace add ./harness-meta` 후 marketplaces[] 안 등재 확인."
    },
    {
      "id": "R4",
      "description": "사용자 명시 install scope (user/project/local) 권고 default — v4.x narrative 'user scope' 정합 (전역 활성). 단 .harness.toml 활용 프로젝트 (upbit 등) 안 project scope (.claude/settings.json 안 share) 권고 narrative 추가 필요.",
      "severity": "low",
      "mitigation_hint": "DESIGN 단계 안 narrative — user scope default + project scope (특정 프로젝트 share) optional 권고. README/AGENTS/root CLAUDE.md narrative 안 두 패턴 명시."
    },
    {
      "id": "R5",
      "description": "v4.0/4.1/4.2 narrative cascade 14 host 전체 갱신 시 정확 문구 drift risk + sub-host 누락 risk. v3.21 narrative 정전화 3 단계 패턴 (DESIGN 정확 문구 1차 source + EXECUTE Edit 그대로 + VERIFY grep) 적용 의무.",
      "severity": "medium",
      "mitigation_hint": "DESIGN 단계 안 각 host 별 정확 문구 1차 source + EXECUTE 단계 안 Edit tool 정확 문구 그대로 삽입 + VERIFY 단계 안 grep 키워드 (e.g., 'claude plugin install' + 'plugin marketplace add' + '.claude-plugin/plugin.json') 검증. v3.21 패턴 7~8 번째 cycle."
    },
    {
      "id": "R6",
      "description": "5 멤버 audit-team 의존성 narrative — 5 멤버 안 orchestration (project-scanner → analyzer → mapper → proposer → installer) source-of-truth = bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md. plugin manifest 안 5 멤버 거주 시 team orchestration narrative 정합 의무.",
      "severity": "low",
      "mitigation_hint": "현 bootstrap/agents/audit/project-harness-audit-team/ 디렉토리 + CLAUDE.md 보존 + plugin manifest 안 paths 명시. team CLAUDE.md narrative 변경 부재 (sub-dir 자체 거주). DESIGN 단계 검증."
    },
    {
      "id": "R7",
      "description": "smoke 회귀 risk — tests/smoke-*.sh 안 install 관련 smoke (tests/_inactive/smoke-skills-install.sh archive) 외 active smoke 안 install 본질 검증 부재. 본 milestone smoke 회귀 0 보장 자연.",
      "severity": "low",
      "mitigation_hint": "Stage G VERIFY 안 pre-commit 14 hook 의무 + manual install 검증 (`claude plugin marketplace add ./harness-meta` + `claude plugin install harness-meta@harness-meta` 실행 후 subagent_type discovery + commands 인식 확인)."
    },
    {
      "id": "R8",
      "description": "bootstrap/claude-code-catalog/README.md.bak 파일 — git status 안 untracked 표지. 본 milestone scope 안 cleanup 결정 가능 또는 OOS (v4.0 phase-4 산출물 backup 잠재).",
      "severity": "low",
      "mitigation_hint": "DESIGN 단계 안 사용자 명시 결정 — 본 milestone scope 안 cleanup vs OOS. 사실 진술 — README.md.bak 거주 사실 확인만."
    }
  ]
}
```

## narrative

본 RESEARCH 의 핵심 발견 3건:

1. **plugin.json schema 정확 필드 검증** — paths 명시 (replace-default agents/commands vs add-to-default skills/hooks) 동작 차이 + array entry 디렉토리/개별 파일 둘 다 지원. glob 부재, sub-dir nested 인식 검증 의무 (R1).
2. **사용자 환경 plugin system 이미 활성** — `~/.claude/plugins/` 디렉토리 + `marketplaces/`, `installed_plugins.json` 등 인프라 존재 = v5.0 안 plugin 등록 시 즉시 실 검증 가능. v4.3 RESEARCH 안 추정 (Plugin install 후 ~/.claude/plugins/ 안 거주) 확정.
3. **cascade host 14 active + 정량 178 occurrence** — install/symlink/junction/component-installer 키워드 분포 측정. bootstrap/agents/CLAUDE.md (41) + CHANGELOG.md (17) + component-installer.md (14) + README.md (12) 상위 4 host = 84/178 = 47.2%. 본 milestone 안 narrative cascade 14 host 전체 갱신 의무.

## options 비교 narrative

O1 (Plugin 변환 + paths 명시 + 현 구조 보존) 채택 권고 — INTENT.goal 정합 + 현 디렉토리 구조 (bootstrap/agents/audit/ 등) 보존 = git history + cross-ref 정합 + v4.0 정체성 narrative 정합. O2 (디렉토리 재구성) 는 cascade 부담 + 격리 narrative 약화. O3 (점진 P2) 는 v4.3 사용자 결정 (a) 와 모순. O4 (multi-plugin) 는 scope 거대화. DESIGN 단계 안 사용자 명시 결정 게이트.

## 관련

- v4.3 RESEARCH (1차 source): [`../v4.3/RESEARCH.md`](../v4.3/RESEARCH.md)
- v4.3 DESIGN.D2 사용자 결정 (a) v5.0_plugin-pivot 등재: [`../v4.3/DESIGN.md`](../v4.3/DESIGN.md)
- v4.1 D7 sequence: [`../v4.1/DESIGN.md`](../v4.1/DESIGN.md)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
- context7 primary source: `/websites/code_claude` library
  - plugins-reference: `https://code.claude.com/docs/en/plugins-reference`
  - plugin-marketplaces: `https://code.claude.com/docs/en/plugin-marketplaces`
  - plugins (getting started): `https://code.claude.com/docs/en/plugins`
  - sub-agents: `https://code.claude.com/docs/en/sub-agents`
  - settings: `https://code.claude.com/docs/en/settings`

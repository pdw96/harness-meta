# scanner-output — upbit project scan (2026-05-18)

> **생성**: project-scanner (project-harness-audit-team 멤버 1/5)
> **대상**: `C:\Users\qkreh\upbit`
> **이전 audit**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-14\proposal-draft.md` (511 LOC)
> **용도**: Step 2 harness-gap-analyzer 입력
> **harness-meta milestone**: v5.10_external-audit-team-second-call-with-diff Stage F phase-1 Step 1/4

---

## 메타데이터 JSON

```json
{
  "project_path": "C:\\Users\\qkreh\\upbit",
  "language": "python",
  "frameworks": ["asyncio", "pydantic-settings", "httpx", "websockets", "prometheus-client", "pandas", "numpy"],
  "build_tool": "poetry",
  "runtime_version": "3.12",
  "harness_state": {
    "harness_toml": true,
    "harness_toml_schema_version": "1.1",
    "claude_dir": true,
    "claude_plugin_dir": true,
    "plugin_json": true,
    "plugin_json_path": ".claude-plugin/plugin.json",
    "plugin_name": "upbit-harness",
    "plugin_version": "1.0.0",
    "plugin_agents_path": "./agents",
    "plugin_skills_path": "./skills",
    "plugin_hooks": "not declared in plugin.json",
    "plugin_mcp_servers": "not declared in plugin.json",
    "agents": [
      ".claude-plugin/agents/harness-dispatcher.md",
      ".claude-plugin/agents/harness-explore.md",
      ".claude-plugin/agents/harness-verifier.md",
      ".claude-plugin/agents/harness-grey-area.md",
      ".claude-plugin/agents/trading-safety-checker.md",
      ".claude-plugin/agents/paper-trading-gate.md"
    ],
    "skills": [
      ".claude-plugin/skills/harness/SKILL.md",
      ".claude-plugin/skills/harness-design/SKILL.md",
      ".claude-plugin/skills/harness-plan/SKILL.md",
      ".claude-plugin/skills/harness-run/SKILL.md",
      ".claude-plugin/skills/harness-ship/SKILL.md",
      ".claude-plugin/skills/harness-review/SKILL.md",
      ".claude-plugin/skills/harness-python/SKILL.md"
    ],
    "claude_dir_hooks": [
      {
        "name": "post-edit-syntax-check.sh",
        "matcher": "PostToolUse(Edit|Write|MultiEdit)",
        "type": "command",
        "registered_in": ".claude/settings.json"
      }
    ],
    "claude_dir_inline_hooks": [
      {
        "matcher": "PreToolUse(Bash)",
        "type": "inline command in settings.json",
        "behavior": "rm -rf / force push / reset --hard / .env 덮어쓰기 / secret/password 할당 차단"
      },
      {
        "matcher": "PreToolUse(Write)",
        "type": "inline command in settings.json",
        "behavior": ".env 파일 쓰기 차단"
      }
    ],
    "output_styles": [".claude/output-styles/harness-engineer.md"],
    "settings_json": true,
    "settings_local_json": true,
    "mcp_json": true,
    "mcp_servers": ["harness"],
    "mcp_server_cmd": "poetry run python scripts/harness/mcp_server.py",
    "session_init_hook": false,
    "claude_md_in_repo": false,
    "harness_toml_fields": {
      "project_name": "upbit",
      "language": "python",
      "package_manager": "poetry",
      "runtime_version": "3.12",
      "locale": "ko",
      "harness_code_dir": "scripts/harness",
      "phases_dir": "phases",
      "guardrails": "docs/GUARDRAILS.md",
      "mcp_server": "harness",
      "executor": "scripts/execute.py",
      "statusline_cmd": "python3 -m scripts.harness.statusline_stats summary phases/index.json",
      "test_cmd": "poetry run pytest tests/ -q",
      "harness_test_cmd": "poetry run pytest scripts/tests/ -q",
      "type_check_cmd": "poetry run mypy bot/ config/ --strict",
      "lint_cmd": "poetry run ruff check bot/ config/",
      "format_cmd": "poetry run ruff format --check bot/ config/",
      "discord_webhook_env": "DISCORD_WEBHOOK_URL"
    }
  },
  "structure": {
    "file_count_estimate": 280,
    "depth_max": 6,
    "loc_estimate_py": 18000,
    "test_dirs": ["tests/unit/", "tests/integration/", "scripts/tests/harness/", "scripts/tests/ci/"],
    "test_framework": "pytest",
    "test_count_last_known": 637,
    "source_dirs": ["bot/", "config/", "scripts/harness/", "scripts/ci/"],
    "ci_workflows": [
      ".github/workflows/ci.yml",
      ".github/workflows/quality.yml",
      ".github/workflows/deploy-local.yml",
      ".github/workflows/rollback-local.yml",
      ".github/workflows/grafana-provision.yml",
      ".github/workflows/grafana-dashboard-force.yml",
      ".github/workflows/actionlint.yml"
    ]
  },
  "harness_infra": {
    "harness_version_last_known": "v1.41",
    "harness_modules_count": 45,
    "harness_executor_subpkg": true,
    "harness_mcp_subpkg": true,
    "phases_milestones": [
      "v0.1/0-mvp (completed)",
      "v0.2/1-regime-consensus (completed)",
      "v1.0/2-strategy-diversify (completed)",
      "v1.1/3-docker-desktop (completed)",
      "v1.2/4-grafana-dashboards (completed)",
      "v1.3/5-discord-migration (completed)",
      "v1.4/6-github-deploy (completed)",
      "v1.5/7-dashboard-provisioning (completed)"
    ],
    "latest_phase_status": "v1.5 completed (2026-04-23)",
    "coverage_gate": "100% (fail_under=100, pragma: no cover 적용)"
  }
}
```

---

## 이전 audit (2026-05-14) 대비 변경 사항 diff 요약

### v1.17 적용 완료 항목 (audit 산출물 → 실제 적용 확인)

| 항목 | 2026-05-14 proposal | 2026-05-18 현재 상태 |
|------|---------------------|---------------------|
| G1 plugin.json | 신규 생성 권고 | **적용됨** — `.claude-plugin/plugin.json` 존재 (v1.0.0, agents+skills paths) |
| G5/F1 trading-safety-checker | 신규 권고 | **적용됨** — `.claude-plugin/agents/trading-safety-checker.md` (sonnet, Read/Grep/Glob) |
| G6 paper-trading-gate | 신규 권고 | **적용됨** — `.claude-plugin/agents/paper-trading-gate.md` (haiku, Read/Grep) |
| G8 quality.yml ruff S + pip-audit | 신규 권고 | **적용됨** — `quality.yml` 안 두 step 확인 |
| G2/F5 backup dirs | 삭제 권고 | 확인 불가 (backup dirs glob 결과 없음 — 삭제된 것으로 추정) |
| G3 CLAUDE.md narrative | v5.0+ 교체 권고 | 확인 필요 (CLAUDE.md repo 내 부재) |
| F2 harness-verifier CI scope | append 권고 | **적용됨** — `harness-verifier.md` 안 "CI Workflow Verification" 섹션 확인 |
| F6 harness-grey-area ADR-021 | append 권고 | **적용됨** — `harness-grey-area.md` 안 "Docker Memory Limit (ADR-021)" 섹션 확인 |
| C1 harness-review description | 분리 권고 | **적용됨** — description에 "built-in /review 보완 (upbit 특화 ADR/GUARDRAILS compliance)" 명시 |
| F4 harness-cost-tracker | CONDITIONAL ACCEPT (G7 spike 의존) | SPIKE 보류 유지 — 미적용 (확인) |
| S1~S4 SPIKE | 보류 | 보류 유지 (미적용) |

### v1.17 이후 신규 감지 변경 (proposal 외)

| 변경 | 위치 | 비고 |
|------|------|------|
| harness-explore agent 신규 | `.claude-plugin/agents/harness-explore.md` | v1.17 proposal 외 신규 추가 — `/harness-plan` 전용 탐색 subagent |
| harness-review SKILL 신규 | `.claude-plugin/skills/harness-review/SKILL.md` | v1.17 이후 추가된 것으로 보임 (proposal에 description 수정만 언급) |
| harness-python SKILL 신규 | `.claude-plugin/skills/harness-python/SKILL.md` | python-quality.md 포함 — v1.17 이후 추가 추정 |
| plugin.json hooks/mcpServers 필드 부재 | `.claude-plugin/plugin.json` | proposal draft에는 hooks + mcpServers 필드 포함 예정이었으나 현재 agents+skills 2 필드만 존재 |
| settings.local.json cp 명령 stale ref | `.claude/settings.local.json` 안 allow 목록 | `cp C:/Users/qkreh/upbit/.claude/commands/harness-*.md` 등 — `.claude/commands/` 경로가 v1.17 git mv 이후 `.claude-plugin/` 으로 이동했으나 cp 명령은 구 경로 참조 |

---

## 구조 이상 / 주의 사항 6건

1. **plugin.json 필드 불완전**: `agents` + `skills` string path만 존재. `hooks` / `mcpServers` 필드 부재. v1.17 proposal-draft G1 초안 대비 축소된 형태로 적용됨. harness MCP server (`.mcp.json`) + PostToolUse hook 이 plugin.json에 미등록 = Plugin spec 자동 인식 배제 상태 유지 가능성.

2. **settings.local.json stale cp 명령**: `.claude/commands/`, `.claude/agents/`, `.claude/skills/` 경로 참조 cp 명령이 allow 목록에 잔존. v1.17 git mv 이후 실제 경로는 `.claude-plugin/`. 오류 실행 위험 낮음(allow 목록 선언이므로 자동 실행 안 됨)이나 혼란 유발.

3. **session-init hook 부재**: `docs/HARNESS.md` 에는 `SessionStart` session-init.sh 가 언급되나 실제 `.claude/hooks/` 에는 `post-edit-syntax-check.sh` 만 존재. v1.17 이전부터 이미 부재했던 것으로 추정.

4. **CLAUDE.md 부재 in repo root**: `docs/HARNESS.md` 안에 `CLAUDE.md` 를 참조하나 repo 루트에 `CLAUDE.md` 가 존재하지 않음. 사용자 글로벌 `~/.claude/CLAUDE.md` 로 운용 중인 것으로 추정.

5. **harness-meta milestones 없음 (v1.18+)**: harness-meta `projects/upbit/ROADMAP.md` 최신 등재는 v1.17. v1.18+ pending candidates (A_user trigger 대기 4건 + cycle 3 trigger 1건) 는 ROADMAP 미등재 상태.

6. **phases v1.5 최신 (2026-04-23 완료)**: harness 자체는 v1.41 까지 진화했으나 upbit bot 기능 milestone은 v1.5에서 멈춤. v1.6+ 기능 milestone 미착수.

---

_이 파일은 project-scanner (project-harness-audit-team 멤버 1/5) 가 read-only 스캔으로 생성. Step 2 harness-gap-analyzer 가 이 파일을 입력으로 사용._

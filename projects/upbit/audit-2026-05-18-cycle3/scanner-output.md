# scanner-output — upbit project scan (cycle 3, 2026-05-18)

> **생성**: project-scanner (project-harness-audit-team 멤버 1/5) — agent 산출 후 synthesizer fact 검증 (v5.14 D6, v5.13 절차 첫 실전 적용)
> **대상**: `C:\Users\qkreh\upbit`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18\scanner-output.md` (cycle 2, v5.10)
> **용도**: Step 2 harness-gap-analyzer 입력
> **harness-meta milestone**: v5.14_external-audit-team-cycle-3-call Stage F phase-1 Step 1/6

---

## fact 검증 노트 (v5.14 D6 synthesizer 직접 검증)

| 필드 | scanner 산출 | 실 검증 | 결과 |
|------|-------------|---------|------|
| `claude_md_in_repo` | `true` | `CLAUDE.md` 존재 확인 (Read) | ✓ |
| `claude_md_bytes` | `5847` | `wc -c` → **9430 bytes** | ⚠ **HALLUCINATION** — 실측 9430으로 정정 |
| `mcp_json` | `false` | `ls .mcp.json` → "not found" | ✓ |
| `plugin_version` | `1.1.0` | plugin.json 직접 읽기 확인 | ✓ |
| `agents_count` | 6 | `ls .claude-plugin/agents/` → 6건 | ✓ |
| `skills_count` | 7 | `ls .claude-plugin/skills/` → 7건 | ✓ |
| `stale cp 4건` | settings.local.json L14~L17 | grep 직접 확인 4줄 | ✓ |

**정정**: `claude_md_bytes: 5847` → **9430** (v5.11 correction annotation 정합 — v5.11 정정 source: memory project_v5.11 "9430 bytes")

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
    "plugin_version": "1.1.0",
    "plugin_agents_path": "./agents",
    "plugin_skills_path": "./skills",
    "plugin_hooks": {
      "declared": true,
      "PreToolUse": [
        {"matcher": "Bash", "type": "inline command", "behavior": "rm -rf / force push / reset --hard / .env 덮어쓰기 / secret/password 할당 차단"},
        {"matcher": "Write", "type": "inline command", "behavior": ".env 파일 쓰기 차단"}
      ],
      "PostToolUse": [
        {"matcher": "Edit|Write|MultiEdit", "type": "command", "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/post-edit-syntax-check.sh", "timeout": 10}
      ]
    },
    "plugin_mcp_servers": {
      "declared": true,
      "harness": {
        "type": "stdio",
        "command": "poetry",
        "args": ["run", "python", "scripts/harness/mcp_server.py"],
        "description": "Harness MCP — index.json schema-enforced 조회·갱신 + ROADMAP 읽기"
      }
    },
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
    "hooks_physical_location": ".claude-plugin/hooks/post-edit-syntax-check.sh",
    "hooks_registered_in": "plugin.json PostToolUse (${CLAUDE_PLUGIN_ROOT}/hooks/)",
    "claude_dir_hooks": [],
    "output_styles": [".claude/output-styles/harness-engineer.md"],
    "settings_json": true,
    "settings_local_json": true,
    "mcp_json": false,
    "mcp_servers_registered_in": "plugin.json mcpServers.harness (v1.18 이후 .mcp.json 삭제됨)",
    "session_init_hook": false,
    "claude_md_in_repo": true,
    "claude_md_path": "CLAUDE.md",
    "claude_md_bytes": 9430,
    "_claude_md_bytes_correction": "scanner 산출 5847 → synthesizer 실측 9430 (wc -c 직접 검증, v5.14 D6 fact 검증)",
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
    "file_count_py_estimate": 155,
    "file_count_total_estimate": 330,
    "depth_max": 6,
    "loc_estimate_py": 19500,
    "test_dirs": ["tests/unit/", "tests/integration/", "scripts/tests/harness/", "scripts/tests/ci/"],
    "test_framework": "pytest",
    "test_count_last_known": 638,
    "source_dirs": ["bot/", "config/", "scripts/harness/", "scripts/ci/"],
    "ci_workflows": [
      ".github/workflows/ci.yml",
      ".github/workflows/quality.yml",
      ".github/workflows/deploy-local.yml",
      ".github/workflows/rollback-local.yml",
      ".github/workflows/grafana-provision.yml",
      ".github/workflows/grafana-dashboard-force.yml",
      ".github/workflows/actionlint.yml"
    ],
    "pre_commit_hooks": ["ruff", "ruff-format", "test-docstring", "mypy-harness (pre-push)", "detect-secrets"]
  },
  "harness_infra": {
    "harness_modules_count": 32,
    "harness_executor_subpkg": true,
    "harness_mcp_subpkg": true,
    "phases_milestones_last_completed": "v1.5 (2026-04-23)",
    "ruff_version_pinned": "v0.15.12",
    "ruff_rules": ["E", "F", "UP", "B", "SIM", "I", "S"],
    "coverage_gate": "fail_under=100"
  }
}
```

---

## cycle 2 (v5.10) 대비 cycle 3 변경사항 delta

| 항목 | cycle 2 상태 | cycle 3 현재 상태 |
|------|-------------|-----------------|
| plugin.json version | 1.0.0 | **1.1.0** (v1.18) |
| plugin.json hooks | 부재 (N4 gap) | **신규** — PreToolUse(Bash/Write) + PostToolUse(Edit\|Write\|MultiEdit) |
| plugin.json mcpServers | 부재 (N4 gap) | **신규** — harness stdio |
| .claude/hooks/ | post-edit-syntax-check.sh 거주 | .claude-plugin/hooks/ **git rename** 완료 |
| .mcp.json | 존재 | **삭제됨** (plugin.json 흡수) |
| .claude/settings.json hooks block | 존재 | **제거됨** |
| claude_md_in_repo | false (HALLUCINATION → v5.11 정정) | **true** (9430 bytes, 최신) |

---

## 미해소 이슈 (신규 감지 포함)

1. **settings.local.json stale cp 명령 4건** (cycle 2 이슈 지속): L14~L17에 `.claude/commands/`, `.claude/agents/`, `.claude/skills/`, `.claude/output-styles/` 구 경로 참조 — v1.17 git mv 이후 실제 경로 `.claude-plugin/`으로 이전됨. 자동 실행 없으나 혼란 유발.
2. **CLAUDE.md L114~L127 v4.x symlink narrative 부분 잔존** (신규 감지): v5.0+ Plugin spec 도입 이후에도 "~/.claude/에 symlink" 기반 서술 유지. v1.17 phase-3 cascade 업데이트가 부분 반영됐으나 완전 현행화 미완.
3. **session_init_hook 부재** (지속): plugin.json SessionStart hook 미등록.

---

_project-scanner 산출 (Step 1/6). 이후 harness-gap-analyzer가 입력으로 사용. synthesizer fact 검증 완료 (v5.14 D6)._

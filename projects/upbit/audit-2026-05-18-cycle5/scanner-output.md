# scanner-output — upbit project scan (cycle 5, 2026-05-18)

> **생성**: project-scanner (project-harness-audit-team 멤버 1/5) — v5.13 fact 검증 절차 세 번째 실전 적용
> **대상**: `C:\Users\qkreh\upbit`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle4\scanner-output.md` (cycle 4, v5.15)
> **용도**: Step 2 harness-gap-analyzer 입력
> **harness-meta milestone**: v5.17 — audit cycle 5 (upbit v1.20 mechanical apply 검증)

---

## v1.20 apply 검증 (직접 Read 실측 — fact 검증 의무)

CLAUDE.md 직접 Read + awk 실측 결과:

| ID | v5.15 residual 설명 | 적용 후 기대값 | 실측 (CLAUDE.md) | verdict |
|----|-------------------|--------------|----------------|---------|
| **R1** | `.claude/hooks/post-edit-syntax-check.sh` + `.mcp.json` 서술 | `.claude-plugin/hooks/post-edit-syntax-check.sh` + `plugin.json mcpServers.harness` | **L124**: `.claude-plugin/hooks/post-edit-syntax-check.sh` / **L125**: `plugin.json mcpServers.harness` | **APPLIED** |
| **R2** | L37 `pre-commit hooks (v1.20 C3)` forward reference | `pre-commit hooks (v1.12)` | L37: `pre-commit hooks (v1.12):` | **APPLIED** |

R1 + R2 모두 **적용 완료** 확인. 신규 잔존 gap 없음 (본 cycle 기준).

**[synthesizer fact 검증 cycle 7 정정 — line 번호 misattribution]**: v5.17 RESEARCH.md 안 R1 위치 = `L122~L123` 기재는 cycle 5 실측 시점에서 부정확 (실 위치 = L124-L125). RESEARCH 시점 sed range 120,130p 안 L122=`.harness.toml` / L123=`.claude/settings.json` / L124=`.claude-plugin/hooks/...` / L125=`plugin.json mcpServers...` 였음. RESEARCH inline 정정 사항 = REPORT.md L_n 안 명시 (audit trail 보존). v5.13 fact 검증 절차 cycle 7 누적 (cycle 1 v5.10 proposer / cycle 2 v5.11 scanner / cycle 3 v5.12 mapper / cycle 4 v5.14 proposer / cycle 5 v5.15 scanner / cycle 6 v5.15 proposer / cycle 7 본 v5.17 RESEARCH 안 line 번호 misattribution).

**R1 실측 상세**:

- `CLAUDE.md:124` = `- \`.claude-plugin/hooks/post-edit-syntax-check.sh\` — Python AST syntax check (PostToolUse, upbit 로컬 유지)`
- `CLAUDE.md:125` = `- plugin.json \`mcpServers.harness\` — \`harness\` MCP 서버 (프로젝트 로컬 \`scripts/harness/mcp_server.py\` 지정)`

**R2 실측 상세**:

- `CLAUDE.md:37` = `pre-commit hooks (v1.12): \`poetry run pre-commit install && poetry run pre-commit install --hook-type pre-push\` 1회. 이후 커밋 시 ruff/ruff-format/test-docstring 자동, push 시 mypy --strict.`

---

## 메타데이터 JSON

```json
{
  "project_path": "C:\\Users\\qkreh\\upbit",
  "scan_cycle": 5,
  "scan_date": "2026-05-18",
  "baseline": "audit-2026-05-18-cycle4/scanner-output.md",
  "language": "python",
  "frameworks": ["asyncio", "pydantic-settings", "httpx", "websockets", "prometheus-client", "pandas", "numpy"],
  "build_tool": "poetry",
  "runtime_version": "3.12",
  "harness_state": {
    "harness_toml": true,
    "harness_toml_path": "C:\\Users\\qkreh\\upbit\\.harness.toml",
    "harness_toml_schema_version": "1.1",
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
    },
    "claude_plugin_dir": true,
    "plugin_json": true,
    "plugin_json_path": ".claude-plugin/plugin.json",
    "plugin_name": "upbit-harness",
    "plugin_version": "1.1.0",
    "agents_count": 7,
    "agents": [
      ".claude-plugin/agents/harness-dispatcher.md",
      ".claude-plugin/agents/harness-explore.md",
      ".claude-plugin/agents/harness-verifier.md",
      ".claude-plugin/agents/harness-grey-area.md",
      ".claude-plugin/agents/trading-safety-checker.md",
      ".claude-plugin/agents/paper-trading-gate.md",
      ".claude-plugin/agents/spike-investigator.md"
    ],
    "skills_count": 7,
    "skills": [
      ".claude-plugin/skills/harness/SKILL.md",
      ".claude-plugin/skills/harness-design/SKILL.md",
      ".claude-plugin/skills/harness-plan/SKILL.md",
      ".claude-plugin/skills/harness-run/SKILL.md",
      ".claude-plugin/skills/harness-ship/SKILL.md",
      ".claude-plugin/skills/harness-review/SKILL.md",
      ".claude-plugin/skills/harness-python/SKILL.md"
    ],
    "plugin_hooks": {
      "declared": true,
      "PreToolUse": [
        {"matcher": "Bash", "behavior": "rm -rf / force push / reset --hard / .env 덮어쓰기 / secret/password 할당 차단"},
        {"matcher": "Write", "behavior": ".env 파일 쓰기 차단"}
      ],
      "PostToolUse": [
        {"matcher": "Edit|Write|MultiEdit", "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/post-edit-syntax-check.sh", "timeout": 10}
      ],
      "SessionStart": [
        {"command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh"}
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
    "hooks_physical": [
      ".claude-plugin/hooks/post-edit-syntax-check.sh",
      ".claude-plugin/hooks/session-start.sh"
    ],
    "claude_dir_hooks": [],
    "output_styles": [".claude/output-styles/harness-engineer.md"],
    "settings_json": true,
    "settings_local_json": true,
    "mcp_json": false,
    "session_init_hook": true,
    "session_init_hook_source": ".claude-plugin/hooks/session-start.sh (plugin.json SessionStart 등록)",
    "claude_md_in_repo": true,
    "claude_md_path": "C:\\Users\\qkreh\\upbit\\CLAUDE.md",
    "claude_md_lines": 148,
    "claude_md_bytes": 9158
  },
  "v1_20_apply_verification": {
    "R1": {
      "applied": true,
      "evidence_location": "CLAUDE.md:124-125",
      "before": ["CLAUDE.md cycle 4 .claude/hooks/post-edit-syntax-check.sh", "CLAUDE.md cycle 4 .mcp.json harness MCP"],
      "after": ["CLAUDE.md:L124 .claude-plugin/hooks/post-edit-syntax-check.sh", "CLAUDE.md:L125 plugin.json mcpServers.harness"],
      "note": "RESEARCH.md 안 L122~L123 misattribution → 실 위치 L124-L125 (synthesizer 정정 cycle 7)"
    },
    "R2": {
      "applied": true,
      "evidence_location": "CLAUDE.md:37",
      "before": "pre-commit hooks (v1.20 C3)",
      "after": "pre-commit hooks (v1.12):",
      "note": "forward reference 제거 완료. 현재 텍스트에 v1.20 참조 부재"
    }
  },
  "directory_stats": {
    "bot_files_py": 27,
    "config_files_py": 2,
    "scripts_files_py": 103,
    "tests_files_py": 46,
    "docs_files_md": 10,
    "infra_files": 11,
    "test_framework": "pytest"
  },
  "git_log_last5": [
    "5aeed93 chore(harness): v1.20 Stage B-I artifacts + milestones.md + phase-1 status complete",
    "9d2862c feat(harness): v1.20 phase-1 — audit cycle 4 R1+R2 apply",
    "2a8e88c chore(harness): v1.19 Stage B-I 산출물 + ROADMAP completed + milestones.md",
    "b86ad81 feat(harness): v1.19 phase-1 — audit cycle 3 proposal 4건 적용",
    "8c3ad01 chore(upbit): v1.18 Stage B-I — INTENT+RESEARCH+DESIGN+APPROVE+VERIFY+REPORT+PROPOSE artifacts + milestones.md + phase-1 status complete"
  ],
  "delta_vs_cycle4": {
    "changed": [
      "CLAUDE.md:37 (v1.20 C3 → v1.12, R2 apply)",
      "CLAUDE.md:124-125 (stale .claude/hooks/ + .mcp.json → .claude-plugin/hooks/ + plugin.json mcpServers, R1 apply)"
    ],
    "unchanged": [
      "plugin.json (version 1.1.0, hooks, mcpServers — 전체 동일)",
      ".harness.toml (schema_version 1.1 — 전체 동일)",
      "agents 7건 (spike-investigator 포함 cycle 4 동일)",
      "skills 7건 (동일)",
      "hooks 2건 (post-edit-syntax-check.sh + session-start.sh 동일)",
      ".mcp.json 부재 (cycle 4 동일)",
      "stale_cp 0건 (settings.local.json 동일)"
    ],
    "residual_issues": []
  }
}
```

---

## fact 검증 노트 (v5.13 절차 세 번째 실전 적용)

| 필드 | 실측 방법 | 결과 | 이슈 |
|------|----------|------|------|
| `claude_md_lines` | wc -l 실측 | 148 | scanner 1차 산출 = 149 (off-by-one), 본 정정 = 148 |
| `claude_md_bytes` | wc -c 실측 | 9158 | scanner 1차 산출 = 미측정 (cycle 4 9133 참조), 본 정정 = 9158 (실측 가능) |
| `R1 applied` | CLAUDE.md:124-125 직접 Read | `.claude-plugin/hooks/post-edit-syntax-check.sh` + `plugin.json mcpServers.harness` | PASS — RESEARCH.md L122~L123 misattribution 정정 |
| `R2 applied` | CLAUDE.md:37 직접 Read | `pre-commit hooks (v1.12):` 텍스트 확인 | PASS |
| `mcp_json` | Glob `.mcp.json` → No files found | false | PASS |
| `plugin_version` | plugin.json 직접 Read | 1.1.0 | PASS |
| `agents_count` | Glob `.claude-plugin/agents/*` → 7건 | 7 | PASS |
| `skills_count` | Glob `.claude-plugin/**/*` + SKILL.md filter → 7 디렉토리 | 7 | PASS |
| `hooks_count` | Glob `.claude-plugin/hooks/*` → 2건 | 2 | PASS |
| `git_log_last5` | `.git/logs/HEAD` Read | 5건 확인 (5aeed93 최신) | PASS |

**hallucination 2건 발견 (synthesizer cycle 7 정정)**:

1. `claude_md_lines: 149` → `148` (실측 wc -l, 1 off-by-one)
2. `claude_md_bytes: 미측정` → `9158` (실측 wc -c 가능, 추정 부기재 정책 부적용 케이스 — 실측 가능 fact)

추가 정정 1건 (RESEARCH.md 안 misattribution):

3. R1 위치 = `L122~L123` (RESEARCH 시점) → `L124~L125` (cycle 5 실측). RESEARCH 시점 sed range 잘못 매핑. inline footnote 추가 (overwrite 회피, audit trail 보존).

---

## markdown lint precheck (v5.16 절차 첫 실전 적용)

검사 대상: 본 산출물 전문

| 규칙 | 검사 결과 | 조치 |
|------|----------|------|
| MD022 (blanks-around-headings) | PASS — 모든 `##` heading 직전/직후 blank line 1줄 확보 | 없음 |
| MD031 (blanks-around-fences) | PASS — ` ```json ` 블록 직전/직후 blank line 1줄 확보 | 없음 |
| MD032 (blanks-around-lists) | PASS — `-` list marker 직전/직후 blank line 1줄 확보 | 없음 |

**위반 건수: 0건**

---

**scan 완료 요약 (synthesizer 전달용 핵심 delta — Step 2 harness-gap-analyzer 입력):**

**v1.20 R1+R2 전체 적용 확인 (직접 Read 실측 PASS):**

- **R1 APPLIED**: `C:\Users\qkreh\upbit\CLAUDE.md:124-125` — `.claude-plugin/hooks/post-edit-syntax-check.sh` + `plugin.json mcpServers.harness` 정확 기재 (구 `.claude/hooks/` + `.mcp.json` 서술 교체 완료)
- **R2 APPLIED**: `C:\Users\qkreh\upbit\CLAUDE.md:37` — `pre-commit hooks (v1.12):` (구 `v1.20 C3` forward reference 제거 완료)

**cycle 5 신규 잔존 gap: 0건** (R1+R2 모두 해소, cycle 4 잔존 이슈 종결)

**v5.13 fact 검증 절차 세 번째 실전 — hallucination cycle 7 정정 inline (off-by-one + RESEARCH misattribution)**

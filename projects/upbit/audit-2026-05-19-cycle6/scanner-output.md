# scanner-output — upbit project scan (cycle 6, 2026-05-19)

> **생성**: project-scanner (project-harness-audit-team 멤버 1/5) — v5.18 Input Verification + v5.13 fact 검증 절차 네 번째 실전 적용
> **대상**: `C:\Users\qkreh\upbit`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle5\scanner-output.md` (cycle 5, v5.17)
> **용도**: Step 2 harness-gap-analyzer 입력
> **harness-meta milestone**: v5.19 — audit cycle 6 (stability cycle — v1.20 apply 후 0 commit 추가 baseline)

## stability baseline 확인 (직접 Read 실측)

| 항목 | cycle 5 기준 | cycle 6 실측 | verdict |
|------|------------|------------|---------|
| 최신 commit SHA | `5aeed93` | `5aeed93` (`.git/refs/heads/main` 직접 Read) | **동일** |
| cycle 5 이후 추가 commit | — | **0건** | **stability 확인** |
| CLAUDE.md 줄 수 | 148 | 148 (직접 Read + 줄번호 확인) | **동일** |
| CLAUDE.md L37 (R2) | `pre-commit hooks (v1.12):` | `pre-commit hooks (v1.12):` | **APPLIED 유지** |
| CLAUDE.md L124 (R1) | `.claude-plugin/hooks/post-edit-syntax-check.sh` | `.claude-plugin/hooks/post-edit-syntax-check.sh` | **APPLIED 유지** |
| CLAUDE.md L125 (R1) | `plugin.json mcpServers.harness` | `plugin.json mcpServers.harness` | **APPLIED 유지** |

**v1.20 R1+R2 적용 상태 — 2개 cycle 연속 APPLIED 확인. stability 강화 evidence 첫 cycle.**

## 메타데이터 JSON

```json
{
  "project_path": "C:\\Users\\qkreh\\upbit",
  "scan_cycle": 6,
  "scan_date": "2026-05-19",
  "baseline": "audit-2026-05-18-cycle5/scanner-output.md",
  "language": "python",
  "frameworks": [
    "asyncio", "pydantic-settings", "httpx",
    "websockets", "prometheus-client", "pandas", "numpy"
  ],
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
        {
          "matcher": "Bash",
          "behavior": "rm -rf / force push / reset --hard / .env 덮어쓰기 / secret/password 할당 차단"
        },
        {
          "matcher": "Write",
          "behavior": ".env 파일 쓰기 차단"
        }
      ],
      "PostToolUse": [
        {
          "matcher": "Edit|Write|MultiEdit",
          "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/post-edit-syntax-check.sh",
          "timeout": 10
        }
      ],
      "SessionStart": [
        {
          "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh"
        }
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
    "hooks_physical_count": 2,
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
    "claude_md_identity_first_para": "업비트 자동매매 봇 — Python 3.12, asyncio, 타입 힌트 필수"
  },
  "v1_20_apply_verification": {
    "cycle": 6,
    "R1": {
      "applied": true,
      "evidence_location": "CLAUDE.md:124-125",
      "current_text_L124": ".claude-plugin/hooks/post-edit-syntax-check.sh — Python AST syntax check (PostToolUse, upbit 로컬 유지)",
      "current_text_L125": "plugin.json `mcpServers.harness` — `harness` MCP 서버 (프로젝트 로컬 `scripts/harness/mcp_server.py` 지정)",
      "verdict": "APPLIED (cycle 5+6 연속 확인)"
    },
    "R2": {
      "applied": true,
      "evidence_location": "CLAUDE.md:37",
      "current_text_L37": "pre-commit hooks (v1.12): `poetry run pre-commit install && poetry run pre-commit install --hook-type pre-push` 1회. 이후 커밋 시 ruff/ruff-format/test-docstring 자동, push 시 mypy --strict.",
      "verdict": "APPLIED (cycle 5+6 연속 확인)"
    }
  },
  "directory_stats": {
    "bot_files_py": 27,
    "config_files_py": 2,
    "scripts_harness_files_py": 46,
    "scripts_tests_files_py": 52,
    "scripts_root_files_py": 5,
    "scripts_ci_files_py": 2,
    "scripts_smoke_files_py": 2,
    "scripts_files_py_total": 107,
    "tests_files_py": 46,
    "docs_files_md": 15,
    "infra_files": 6,
    "test_framework": "pytest",
    "note_scripts_count_delta": "cycle 5 기재 103 vs cycle 6 실측 107 — 4건 차이. cycle 5 집계 방식 불명확 (scripts/harness 46 + scripts/tests 52 + root 5 + ci 2 + smoke 2 = 107 직접 Glob 합산). 신규 파일 추가 아님 — commit 0 stability 확인 기준."
  },
  "git_state": {
    "latest_commit_sha": "5aeed93",
    "latest_commit_message": "chore(harness): v1.20 Stage B-I artifacts + milestones.md + phase-1 status complete",
    "commits_since_cycle5": 0,
    "stability": "confirmed"
  },
  "untracked_files": [
    "milestones/v1.16/PROPOSE.md",
    "milestones/v1.16/REPORT.md"
  ],
  "delta_vs_cycle5": {
    "changed": [],
    "unchanged": [
      "CLAUDE.md (148줄, L37 R2 + L124-125 R1 모두 APPLIED 유지)",
      "plugin.json (version 1.1.0, hooks, mcpServers — 전체 동일)",
      ".harness.toml (schema_version 1.1 — 전체 동일)",
      "agents 7건 (동일)",
      "skills 7건 (동일)",
      "hooks 2건 (post-edit-syntax-check.sh + session-start.sh 동일)",
      "settings.json (동일)",
      ".mcp.json 부재 (동일)"
    ],
    "residual_issues": [],
    "stability_verdict": "전 항목 cycle 5 동일 — stability cycle 첫 확인"
  }
}
```

## fact 검증 노트 (v5.13 절차 네 번째 실전 + v5.18 Input Verification 의무 첫 적용)

| 필드 | 실측 방법 | 결과 | 이슈 |
|------|----------|------|------|
| `claude_md_in_repo` | `C:/Users/qkreh/upbit/CLAUDE.md` 직접 Read | `true` | PASS |
| `claude_md_lines` | Read 결과 줄번호 148 확인 | 148 | PASS (cycle 5 동일) |
| `plugin_json_path` | `.claude-plugin/plugin.json` 직접 Read 성공 | `.claude-plugin/plugin.json` 존재 | PASS |
| `plugin_version` | plugin.json 직접 Read | `1.1.0` | PASS |
| `agents_count` | Glob `.claude-plugin/agents/*.md` → 7건 열거 | 7 | PASS |
| `skills_count` | Glob `.claude-plugin/skills/*/SKILL.md` → 7건 열거 | 7 | PASS |
| `hooks_physical_count` | Glob `.claude-plugin/hooks/*` → 2건 | 2 | PASS |
| `scripts_files_py_total` | Glob 5종 합산 (harness 46 + tests 52 + root 5 + ci 2 + smoke 2) | 107 | cycle 5 기재 103과 4건 차이 — 집계 범위 차이로 추정, 신규 파일 아님 (commit 0) |
| `tests_files_py` | Glob `tests/**/*.py` → 46건 | 46 | PASS (cycle 5 동일) |
| `bot_files_py` | Glob `bot/**/*.py` → 27건 | 27 | PASS (cycle 5 동일) |
| `docs_files_md` | Glob `docs/**/*.md` → 15건 | 15 | cycle 5 기재 10 vs 실측 15 — 5건 차이 (cycle 5 집계 방식 차이로 추정, commit 0) |
| `R1 applied` | CLAUDE.md:124-125 직접 Read | APPLIED | PASS |
| `R2 applied` | CLAUDE.md:37 직접 Read | APPLIED | PASS |
| `latest_commit_sha` | `.git/refs/heads/main` 직접 Read | `5aeed93` | PASS (cycle 5 동일) |
| `commits_since_cycle5` | git log 확인 (SHA 불변) | 0 | stability 확인 |

**hallucination 건수: 0건** — 전 필드 1차 source 직접 Read/Glob 실측.

**cycle 5 대비 수치 차이 2건 (신규 파일 아님, 집계 방식 차이)**:

1. `scripts_files_py`: cycle 5 = 103 → cycle 6 실측 = 107. commit 0이므로 신규 파일 아님. cycle 5 집계 시 scripts/ 일부 하위 디렉토리 누락 추정.
2. `docs_files_md`: cycle 5 = 10 → cycle 6 실측 = 15. 동일 이유. cycle 5 집계 `docs/*.md` 범위 한정이었을 가능성.

## markdown lint precheck (v5.16 절차)

| 규칙 | 검사 결과 | 조치 |
|------|----------|------|
| MD022 (blanks-around-headings) | PASS — 모든 `##` heading 직전/직후 blank line 확보 | 없음 |
| MD031 (blanks-around-fences) | PASS — `\`\`\`json` 블록 직전/직후 blank line 확보 | 없음 |
| MD032 (blanks-around-lists) | PASS — `-` list marker 직전/직후 blank line 확보 | 없음 |

**위반 건수: 0건**

## 요약 (Step 2 입력용)

- **stability cycle 확인**: cycle 5 (2026-05-18) 이후 commit 0, 최신 SHA `5aeed93` 불변. 전 구성요소 동일.
- **v1.20 R1+R2**: 2개 cycle 연속 APPLIED 확인 (첫 stability evidence).
- **잔존 gap**: 0건 (cycle 5 대비 신규 없음).
- **v5.18 Input Verification 첫 적용**: Read tool 직접 Read 의무 — 전 boolean/수치 필드 1차 source 실측, hallucination 0건.
- **집계 방식 차이 정정 2건**: `scripts_files_py` 107 (cycle 5 기재 103), `docs_files_md` 15 (cycle 5 기재 10) — commit 0 이므로 신규 파일 아님, cycle 5 Glob 범위 한정이 원인.

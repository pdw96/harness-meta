# scanner-output — upbit project scan (cycle 4, 2026-05-18)

> **생성**: project-scanner (project-harness-audit-team 멤버 1/5) — agent 산출 후 synthesizer fact 검증 (v5.15 D7, v5.13 절차 두 번째 실전 적용)
> **대상**: `C:\Users\qkreh\upbit`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle3\scanner-output.md` (cycle 3, v5.14)
> **용도**: Step 2 harness-gap-analyzer 입력
> **harness-meta milestone**: v5.15_external-audit-team-cycle-4-call Stage F phase-1 Step 1/6

---

## fact 검증 노트 (v5.15 D7 synthesizer 직접 검증 — v5.13 절차 두 번째 실전 적용)

| 필드 | scanner 산출 | 실 검증 | 결과 |
|------|-------------|---------|------|
| `claude_md_in_repo` | `true` | `CLAUDE.md` 존재 (149 lines) | ✓ |
| `claude_md_bytes` | `">9430" 추정` | `wc -c` → **9133 bytes** | ⚠ **HALLUCINATION cycle 5** — 실측 9133 (cycle 3 9430 대비 -297 bytes 줄음), agent 추정 부정확 |
| `mcp_json` | `false` | `ls .mcp.json` → "not found" | ✓ |
| `plugin_version` | `1.1.0` | plugin.json 직접 읽기 | ✓ |
| `agents_count` | 7 | cycle 3 = 6, v1.19 S2 apply = +1 (spike-investigator) | ✓ |
| `skills_count` | 7 | cycle 3 = 7 동일 | ✓ |
| `session_init_hook` | `true` | plugin.json SessionStart 등록 확인 (v1.19 G3 apply) | ✓ |
| `stale_cp_4_count` | 0 | settings.local.json grep 0 matches (v1.19 G1 apply) | ✓ |
| `spike_investigator_present` | `true` | `.claude-plugin/agents/spike-investigator.md` 존재 (v1.19 S2 apply) | ✓ |
| `v1_20_reference_at_CLAUDE.md:37` | (scanner 미감지 → synthesizer 발견) | `CLAUDE.md:37` 확인 = "pre-commit hooks (v1.20 C3)" 라벨, upbit ROADMAP v1.20 entry 부재 = forward reference | ⚠ **noted issue — gap-analyzer 분석 의무** |

**정정 cycle 5**: `claude_md_bytes` 추정 `">9430"` → **9133 bytes** (실측). scanner agent의 Glob/Read 도구 한계 — byte 수 직접 측정 불가, 추정 부정확. v5.13 fact 검증 절차 적용으로 inline 정정 (audit trail 보존, overwrite 회피). origin = scanner agent, cascade target = 본 산출물 + analyzer/mapper/proposer 산출물 안 carry-over 시 검증 의무.

**v5.15 D7 fact 검증 cycle 5 누적 패턴**:

- cycle 1 (v5.10): proposer 12 항목 표 hallucination (django/ai-ready-scorer 무관)
- cycle 2 (v5.11): scanner `claude_md_in_repo: false` hallucination
- cycle 3 (v5.12): mapper bundled skill 분류 spec drift
- cycle 4 (v5.14): proposer 경로 hallucination 3건 (.claude → .claude-plugin)
- cycle 5 (본 v5.15): scanner `claude_md_bytes ">9430"` 추정 부정확 (실측 9133 < cycle 3 9430)

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
        {"matcher": "Bash", "type": "command", "behavior": "rm -rf / force push / reset --hard / .env 덮어쓰기 / secret/password 할당 차단"},
        {"matcher": "Write", "type": "command", "behavior": ".env 파일 쓰기 차단"}
      ],
      "PostToolUse": [
        {"matcher": "Edit|Write|MultiEdit", "type": "command", "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/post-edit-syntax-check.sh", "timeout": 10}
      ],
      "SessionStart": [
        {"type": "command", "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh"}
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
    "hooks_physical_location": [
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
    "claude_md_lines": 149,
    "claude_md_bytes": 9133,
    "_claude_md_bytes_correction": "scanner 산출 '">9430" 추정' → synthesizer 실측 9133 bytes (wc -c 직접 검증, v5.15 D7 fact 검증 cycle 5). cycle 3 baseline 9430 → cycle 4 9133 = -297 bytes 감소 (실 narrative cleanup 가능성, gap-analyzer 추가 분석 의무)",
    "claude_md_byte_delta_vs_cycle3": -297,
    "stale_cp_4_count": 0,
    "stale_cp_locations": [],
    "stale_cp_note": "settings.local.json 내 .claude/commands|agents|skills|output-styles 패턴 grep 0건 — G1 적용 확인",
    "stale_cp_residual_in_claude_md": {
      "present": true,
      "locations": ["CLAUDE.md:124 (.claude/hooks/post-edit-syntax-check.sh)", "CLAUDE.md:125 (.mcp.json harness MCP 서버 narrative)"],
      "note": "G1은 settings.local.json 대상 — CLAUDE.md 본문 L124~L125 stale 서술은 별도 미해소 이슈 (residual_issue R1)"
    },
    "spike_investigator_present": true,
    "spike_investigator_path": ".claude-plugin/agents/spike-investigator.md",
    "v1_20_forward_reference": {
      "found": true,
      "location": "CLAUDE.md:37",
      "text": "pre-commit hooks (v1.20 C3)",
      "note": "upbit ROADMAP v1.20 entry 부재 = forward reference. 의도된 미래 milestone 참조 또는 stale future label — gap-analyzer 의무 분석"
    },
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
  "v1_19_apply_verification": {
    "G1_stale_cp": {
      "applied": true,
      "evidence": "settings.local.json grep '.claude/commands|agents|skills|output-styles' → 0 matches. 현재 settings.local.json는 permissions.allow 10건만 포함 (16줄). cycle 3 stale cp 4건 완전 제거됨."
    },
    "G2_symlink_narrative": {
      "applied": true,
      "evidence": "CLAUDE.md L116~L118: 'Deprecated since v5.0 — SymbolicLink/Junction 수동 매핑 (~/.claude/{commands,hooks,statusline,skills,agents}/) 은 비활성. 현행 설치는 claude plugin install harness-meta@harness-meta 표준 명령 사용.' — v4.x symlink 기반 서술에서 Deprecated 블록으로 교체됨"
    },
    "G3_session_start_hook": {
      "applied": true,
      "evidence": "plugin.json hooks.SessionStart[0]: {type: 'command', command: 'bash ${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh'}. 물리 파일: .claude-plugin/hooks/session-start.sh (bash, .harness.toml 존재 조건부 ruff statistics + pytest collect 출력)"
    },
    "S2_spike_investigator": {
      "applied": true,
      "evidence": ".claude-plugin/agents/spike-investigator.md 존재 확인 (Glob 결과). cycle 3 agents 6건 → cycle 4 7건으로 증가"
    }
  },
  "delta_vs_cycle3": {
    "unchanged_count": 9,
    "changed_count": 4,
    "new_count": 3,
    "removed_count": 0,
    "summary": "4건 변경 (G1 stale cp 제거 / G2 symlink Deprecated 블록 교체 / G3 SessionStart 신규 등록 / CLAUDE.md 내용 -297 bytes 감소 — synthesizer 정정 cycle 5 fact), 3건 신규 (spike-investigator.md agent / session-start.sh hook 파일 / plugin.json SessionStart 블록). 미해소 residual: (a) CLAUDE.md L124~L125 stale .claude/hooks/ + .mcp.json narrative / (b) v1.20 forward reference at L37 (upbit ROADMAP v1.20 entry 부재)"
  },
  "directory_stats": {
    "bot_files_py": 27,
    "scripts_files_py": 103,
    "scripts_harness_modules": 46,
    "tests_files_py": 44,
    "test_framework": "pytest"
  },
  "residual_issues": [
    {
      "id": "R1",
      "severity": "low",
      "location": "CLAUDE.md:124-125",
      "description": ".claude/hooks/post-edit-syntax-check.sh + .mcp.json 서술 잔존 — v1.17/v1.18 이후 실제 경로 .claude-plugin/hooks/ + plugin.json mcpServers 이전됨. G1 대상(settings.local.json)과 별개 이슈"
    },
    {
      "id": "R2",
      "severity": "low",
      "location": "CLAUDE.md:37",
      "description": "pre-commit hooks (v1.20 C3) — upbit ROADMAP v1.20 entry 부재 = forward reference. 의도된 미래 milestone 참조 또는 stale future label. gap-analyzer 의무 분석 (R1과 동일 cleanup scope 가능)"
    }
  ]
}
```

---

**scan 완료 요약 (synthesizer 전달용 핵심 delta — Step 2 harness-gap-analyzer 입력):**

**v1.19 4항목 전체 적용 확인** (D7 fact 검증 PASS):

- **G1 applied**: `C:\Users\qkreh\upbit\.claude\settings.local.json` — stale cp 4건 완전 제거
- **G2 applied**: `C:\Users\qkreh\upbit\CLAUDE.md:116~118` — Deprecated since v5.0 블록으로 교체
- **G3 applied**: `C:\Users\qkreh\upbit\.claude-plugin\plugin.json:40~49` + `.claude-plugin\hooks\session-start.sh` 물리 파일 신규
- **S2 applied**: `C:\Users\qkreh\upbit\.claude-plugin\agents\spike-investigator.md` 존재 (agents 6→7)

**v5.13 fact 검증 절차 두 번째 실전 적용 — cycle 5 hallucination 1건 발견 + inline 정정**:

- scanner `claude_md_bytes ">9430" 추정` → 실측 9133 (-297 bytes vs cycle 3) — agent 도구 한계 (Glob/Read 만 사용, wc -c 부재)

**잔존 이슈 (gap-analyzer 분석 의무) 2건**:

- R1: CLAUDE.md L124~L125 stale narrative (.claude/hooks/ + .mcp.json 구 경로)
- R2: CLAUDE.md L37 v1.20 forward reference (upbit ROADMAP entry 부재)

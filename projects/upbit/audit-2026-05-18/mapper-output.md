# mapper-output — upbit Claude Code docs 매핑 (2026-05-18)

> **생성**: claude-docs-mapper (project-harness-audit-team 멤버 3/5)
> **대상**: `C:\Users\qkreh\upbit`
> **입력**: scanner-output.md + analyzer-output.md
> **1차 source**: context7 `/websites/code_claude` (https://code.claude.com/docs/)
> **milestone**: v5.10 Stage F phase-1 Step 3/4
> **immediate_decisions_required**: 0 (informational + Step 4 narrative enrichment)

---

## 매핑 결과 JSON

```json
{
  "meta": {
    "role": "claude-docs-mapper",
    "milestone": "harness-meta v5.10",
    "stage": "F phase-1 Step 3/4",
    "primary_source": "/websites/code_claude",
    "generated": "2026-05-18",
    "immediate_decisions_required": 0,
    "purpose": "informational — Step 4 component-proposer narrative enrichment"
  },
  "gap_mappings": [
    {
      "gap_id": "N4/A1",
      "category": "plugin",
      "name": "plugin.json hooks + mcpServers 필드 부재",
      "claude_doc_ref": "https://code.claude.com/docs/en/plugins-reference",
      "apply_path": ".claude-plugin/plugin.json",
      "topic": "Plugin hooks + mcpServers 필드 정의",
      "spec_schema": {
        "hooks": {
          "PostToolUse": [
            {"matcher": "Write|Edit", "hooks": [{"type": "command", "command": "${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"}]}
          ],
          "SessionStart": [
            {"matcher": "", "hooks": [{"type": "command", "command": "${CLAUDE_PLUGIN_ROOT}/hooks/session-init.sh"}]}
          ]
        },
        "mcpServers": {
          "harness-api": {"command": "${CLAUDE_PLUGIN_ROOT}/servers/harness-server", "args": ["--port", "8080"], "env": {"HARNESS_ROOT": "${CLAUDE_PLUGIN_ROOT}"}}
        }
      },
      "mapping_narrative": "plugin.json 최상위 'hooks' 필드는 plugin-level hook 등록 경로. 현재 upbit plugin.json 에 hooks 키 부재 = 글로벌 .claude/settings.json 의존 상태. 표준 경로: plugin.json 안 hooks 블록으로 이전 시 plugin install 단일 동작으로 hook 활성화. mcpServers 도 동일.",
      "drift_detect": {"current_state": "plugin.json 에 hooks/mcpServers 키 없음", "spec_state": "plugins-reference §hooks, §mcpServers 양 필드 공식 지원", "drift_severity": "medium — 기능 누락 아님, plugin 배포 편의성 저하"}
    },
    {
      "gap_id": "A3",
      "category": "hook",
      "name": "session-init hook 부재 (SessionStart)",
      "claude_doc_ref": "https://code.claude.com/docs/en/hooks",
      "apply_path": ".claude/hooks/session-init.sh (글로벌) 또는 plugin.json > hooks > SessionStart",
      "topic": "SessionStart hook event schema",
      "spec_schema": {
        "event": "SessionStart",
        "input_fields": {"session_id": "string", "hook_event_name": "SessionStart", "source": "startup | resume | clear | compact", "model": "string", "agent_type": "string (optional)", "cwd": "string", "transcript_path": "string"},
        "supported_types": ["command", "mcp_tool"]
      },
      "mapping_narrative": "SessionStart hook 는 세션 시작/재개 시 1회 실행. .harness.toml 존재 여부 체크 + 환경 변수 주입 + 프로젝트 컨텍스트 로드 적합. source 필드로 startup vs resume 분기 가능 (startup 만 초기화 로직 실행).",
      "drift_detect": {"current_state": "upbit .harness.toml 존재, SessionStart hook 미등록", "spec_state": "SessionStart 공식 이벤트, startup/resume source 분기 지원", "drift_severity": "low — 기능 없음이지 위반 아님"}
    },
    {
      "gap_id": "A4",
      "category": "memory",
      "name": "upbit repo root CLAUDE.md 부재",
      "claude_doc_ref": "https://code.claude.com/docs/en/memory",
      "apply_path": "upbit-repo/CLAUDE.md 또는 upbit-repo/.claude/CLAUDE.md",
      "topic": "CLAUDE.md project-level instruction loading",
      "spec_schema": {
        "locations": {"project_root": "./CLAUDE.md", "claude_dir": "./.claude/CLAUDE.md", "local_only": "./CLAUDE.local.md"},
        "load_order": "managed-policy > user (~/.claude/CLAUDE.md) > project (./CLAUDE.md) > local (./CLAUDE.local.md)",
        "code_review_integration": "Code Review reads CLAUDE.md and REVIEW.md for review guidance"
      },
      "mapping_narrative": "upbit repo 에 CLAUDE.md 없으면 Claude 가 프로젝트 컨벤션/아키텍처를 매 세션 재학습. /init 명령으로 자동 초안 생성 가능 (CLAUDE_CODE_NEW_INIT=1 interactive flow).",
      "drift_detect": {"current_state": "upbit repo root 에 CLAUDE.md 없음", "spec_state": "CLAUDE.md 는 ./CLAUDE.md 또는 ./.claude/CLAUDE.md 양 위치 공식 지원", "drift_severity": "medium — 프로젝트 컨텍스트 자동 로드 누락"}
    },
    {
      "gap_id": "S2-SPIKE",
      "category": "MCP",
      "name": "harness MCP server 도입 가능성 (SPIKE 보류)",
      "claude_doc_ref": "https://code.claude.com/docs/en/mcp",
      "apply_path": ".claude-plugin/plugin.json > mcpServers + servers/harness-server",
      "topic": "MCP server 등록 + plugin.json mcpServers 통합",
      "spec_schema": {
        "plugin_json_mcpServers": {"harness-server": {"command": "${CLAUDE_PLUGIN_ROOT}/servers/harness-server", "args": ["--port", "8080"], "env": {"HARNESS_ROOT": "${CLAUDE_PLUGIN_ROOT}"}}},
        "subagent_mcpServers_inline": "yaml frontmatter 안 mcpServers 필드 (stdio/http/sse transport)",
        "transport_types": ["stdio", "http", "sse"]
      },
      "mapping_narrative": "SPIKE 보류 — informational only. MCP server 등록 2 경로 = (1) plugin.json mcpServers (자동 기동), (2) .mcp.json/claude mcp add 명령. subagent frontmatter 안 mcpServers 필드도 subagent 스코프 한정 가능.",
      "drift_detect": {"current_state": "SPIKE 보류 — 미구현", "spec_state": "plugin.json mcpServers 공식 지원", "drift_severity": "none — scope outside current milestone"}
    }
  ],
  "conflict_mappings": [
    {
      "conflict_id": "N2-C1",
      "custom": "harness-review SKILL",
      "builtin": "/review (bundled skill)",
      "claude_doc_ref": "https://code.claude.com/docs/en/skills",
      "builtin_classification": "bundled skill — /review, /security-review, /init 는 'A few built-in commands available through the Skill tool' 으로 분류 (built-in command 가 아닌 bundled skill).",
      "equivalence": "부분 — /review = 세션 내 범용 리뷰, harness-review = upbit 도메인 특화 규칙 (ruff/pytest/async). 보완 관계.",
      "resolution_status": "resolved (analyzer 결론 유지)",
      "spec_drift_correction": "v1.17 proposal-draft 안 '/review built-in' 표현 → 정확히는 'bundled skill'. minor docs drift 정정."
    },
    {
      "conflict_id": "N3-C5",
      "custom": "harness-python SKILL",
      "builtin": "/doctor",
      "claude_doc_ref": "https://code.claude.com/docs/en/commands",
      "builtin_responsibility": "/doctor = Claude Code 설치/설정 진단 (skill budget, config 충돌, MCP 연결). Python 가상환경/poetry/ruff 등 프로젝트 도구 체크 미포함.",
      "equivalence": "비해당 — 대상 레이어 완전 상이.",
      "resolution_status": "resolved (analyzer 결론 유지)"
    }
  ],
  "evolution_mappings": [
    {
      "case_id": "N1",
      "decision": "fleet 신규 추가 — 적용 완료",
      "subject": "harness-explore (upbit)",
      "apply_path": ".claude-plugin/agents/harness-explore.md (적용 완료)",
      "frontmatter_summary": "model: opus, tools: Read/Glob/Grep, disable-model-invocation: true",
      "claude_doc_ref": "https://code.claude.com/docs/en/sub-agents",
      "spec_anchor": "Choose a model — model: opus for complex exploration tasks",
      "mapping_narrative": "신규 fleet 멤버. /harness-plan 전용 read-only 탐색 subagent. 표준 frontmatter 정합."
    },
    {
      "case_id": "N2",
      "decision": "신규 추가 (SKILL 전체 생성, v1.17 C1 description 분리 적용 포함)",
      "subject": "harness-review SKILL (upbit)",
      "apply_path": ".claude-plugin/skills/harness-review/SKILL.md (적용 완료)",
      "frontmatter_summary": "disable-model-invocation: true, /harness-ship 10-2 호출",
      "claude_doc_ref": "https://code.claude.com/docs/en/skills",
      "spec_anchor": "Bundled skills vs custom skills",
      "mapping_narrative": "/review (bundled skill) 와 보완. description 안 '/review built-in 보완 (upbit 특화 ADR/GUARDRAILS compliance)' 명시."
    },
    {
      "case_id": "N3",
      "decision": "신규 추가",
      "subject": "harness-python SKILL (upbit)",
      "apply_path": ".claude-plugin/skills/harness-python/SKILL.md (적용 완료)",
      "frontmatter_summary": "disable-model-invocation: true, argument-hint [env|check|fix|all]",
      "claude_doc_ref": "https://code.claude.com/docs/en/skills",
      "spec_anchor": "SKILL.md frontmatter — argument-hint, disable-model-invocation",
      "mapping_narrative": "/doctor 와 대상 레이어 상이. Python 환경 + mypy/ruff/pytest 품질 게이트 통합."
    },
    {
      "case_id": "N4-fleet",
      "decision": "plugin.json 확장 (SPIKE 의존 보류)",
      "subject": "plugin.json hooks + mcpServers 블록",
      "apply_path": ".claude-plugin/plugin.json",
      "snippet_summary": "hooks 블록 추가 시 plugin install 단일 동작으로 hook 활성화. mcpServers 는 S2 SPIKE 해소 시 동시 추가.",
      "claude_doc_ref": "https://code.claude.com/docs/en/plugins-reference",
      "spec_anchor": "Plugin hooks field — hooks block in plugin.json",
      "mapping_narrative": "보류 — S2/S3 SPIKE 해소 후 통합 결정."
    }
  ],
  "spike_hold_mappings": [
    {"spike_id": "S1", "name": "mypy cold-start latency 실측 (G4 hook)", "claude_doc_ref": "https://code.claude.com/docs/en/hooks", "spike_reason": "PostToolUse hook 실 latency 측정 환경 필요"},
    {"spike_id": "S2", "name": "harness MCP server 위치 + tool 추가", "claude_doc_ref": "https://code.claude.com/docs/en/mcp", "spike_reason": "MCP server 실행 파일 설계/구현 필요"},
    {"spike_id": "S3", "name": "PostToolUse stdin JSON schema 검증", "claude_doc_ref": "https://code.claude.com/docs/en/hooks", "spike_reason": "구현체 내용 설계 필요"},
    {"spike_id": "S4", "name": "dispatcher 통합 — 중복 skill 위치", "claude_doc_ref": "https://code.claude.com/docs/en/skills", "spike_reason": "dispatcher 패턴 검토 필요"},
    {"spike_id": "F4", "name": "harness-cost-tracker (S2 의존)", "claude_doc_ref": "https://code.claude.com/docs/en/sub-agents", "spike_reason": "S2 SPIKE 미완 (조건부)"}
  ],
  "indexing_validation": {
    "context7_library": "/websites/code_claude",
    "queries_executed": 4,
    "pages_verified": [
      {"url": "https://code.claude.com/docs/en/plugins-reference", "topic": "mcpServers + hooks in plugin.json", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/hooks", "topic": "SessionStart schema + all hook types", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/memory", "topic": "CLAUDE.md project-level placement", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/sub-agents", "topic": "model alias + tools frontmatter", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/code-review", "topic": "/review vs Code Review service distinction", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/commands", "topic": "/doctor /review /init built-in list", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/mcp", "topic": "MCP server registration plugin.json integration", "status": "confirmed"},
      {"url": "https://code.claude.com/docs/en/skills", "topic": "/review bundled skill classification", "status": "confirmed"}
    ],
    "stale_detected": false,
    "minor_drift_correction": "v1.17 proposal-draft '/review built-in' → 'bundled skill' 정확화 (skills docs §Bundled skills 명시). harness-meta narrative 안 'built-in skill' 표현은 정확히 'bundled skill'."
  }
}
```

---

## 핵심 요약 (Step 4 proposer 입력)

### gap_mappings 4건 (severity 별)

- **N4/A1 medium** — plugin.json hooks/mcpServers 부재 → plugin install 편의성 저하
- **A3 low** — SessionStart hook 미등록 → UX 향상 옵션
- **A4 medium** — upbit CLAUDE.md 부재 → 프로젝트 컨텍스트 자동 로드 누락
- **S2-SPIKE none** — harness MCP server (scope 외)

### conflict_mappings 2건 (resolved)

- **N2-C1** — harness-review vs /review **bundled skill** (분류 정확화 — v1.17 narrative '/review built-in' 정정)
- **N3-C5** — harness-python vs /doctor (대상 레이어 상이)

### evolution_mappings 4건 (3건 적용 완료 + 1건 SPIKE 의존 보류)

- **N1** harness-explore 적용 완료
- **N2** harness-review 적용 완료
- **N3** harness-python 적용 완료
- **N4-fleet** plugin.json hooks/mcpServers 확장 (보류)

### spike_hold_mappings 5건

S1 mypy / S2 MCP server / S3 hook stdin / S4 dispatcher / F4 cost-tracker — 전원 본 milestone scope 외.

### docs validation

- context7 8 페이지 검증 — drift 없음
- minor drift correction = `/review` 분류 정확화 ('built-in' → 'bundled skill')
- v1.17 proposal-draft narrative 정정 후속 결정 거명만 (본 milestone scope 외)

---

_이 파일은 claude-docs-mapper (project-harness-audit-team 멤버 3/5) 가 생성. Step 4 component-proposer 입력._

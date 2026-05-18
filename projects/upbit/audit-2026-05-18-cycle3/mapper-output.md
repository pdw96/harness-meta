# mapper-output — upbit harness gap → Claude Code 카탈로그 매핑 (cycle 3, 2026-05-18)

> **생성**: claude-docs-mapper (project-harness-audit-team 멤버 3/5) — agent 산출 후 synthesizer fact 검증 (v5.14 D6)
> **harness-meta milestone**: v5.14 Step 3/6
> **입력**: audit-2026-05-18-cycle3/analyzer-output.md

---

## fact 검증 노트 (v5.14 D6 synthesizer 직접 검증)

| 필드 | mapper 산출 | 실 검증 | 결과 |
|------|------------|---------|------|
| G2 apply_path | `.claude\CLAUDE.md` | `ls` → `CLAUDE.md`(루트) 존재, `.claude\CLAUDE.md` **부재** | ⚠ **정정** — 루트 `CLAUDE.md` |

**정정**: G2 `apply_path` = `C:\Users\qkreh\upbit\.claude\CLAUDE.md` → **`C:\Users\qkreh\upbit\CLAUDE.md`** (루트)

---

```json
{
  "meta": {
    "audit_cycle": 3,
    "base_date": "2026-05-18",
    "harness_version": "v5.14",
    "step": "3/6",
    "cycle2_baseline": "audit-2026-05-18/mapper-output.md"
  },
  "gap_mappings": [
    {
      "gap_id": "G1",
      "name": "settings.local.json-stale-cp",
      "severity": "LOW",
      "description": "settings.local.json 안 stale cp 항목 4건 — v5.0+ Plugin 전환 이후 의미 소멸된 구 .claude/ 경로 복사본",
      "apply_path": "C:\\Users\\qkreh\\upbit\\.claude\\settings.local.json",
      "action": "stale cp 4건 제거 (permissions/env 실 유효 항목만 잔존)",
      "catalog_category": "settings",
      "doc_note": "settings.local.json = personal override (gitignored). stale 항목은 Claude Code가 허용만 하고 자동 실행 안 함 — 혼동 유발이므로 제거 권장."
    },
    {
      "gap_id": "G2",
      "name": "CLAUDE.md-symlink-narrative-stale",
      "severity": "LOW",
      "is_new_in_cycle3": true,
      "description": "upbit CLAUDE.md L114~L127 v4.x SymbolicLink/Junction install narrative 잔존 — v5.0+ Plugin 전환 이후 deprecated",
      "apply_path": "C:\\Users\\qkreh\\upbit\\CLAUDE.md",
      "_apply_path_correction": "mapper 산출 '.claude\\CLAUDE.md' → synthesizer 실측 루트 'CLAUDE.md' (ls 직접 검증, v5.14 D6)",
      "action": "symlink/junction 설치 블록 제거 또는 'Deprecated since v5.0' 표지 한 줄로 대체",
      "catalog_category": "documentation",
      "doc_note": "CLAUDE.md = instructions loaded every session. harness-meta CLAUDE.md 'Deprecated since v5.0' 정책과 정합 — v5.0+ 환경에서 symlink narrative는 비활성 경로."
    },
    {
      "gap_id": "G3",
      "name": "session-init-hook-absent",
      "severity": "LOW",
      "description": "SessionStart hook 미등록 — 세션 시작 시 .harness.toml 확인 + 환경변수 초기화 자동화 부재",
      "apply_path": "C:\\Users\\qkreh\\upbit\\.claude\\settings.json (hooks.SessionStart) + .claude\\hooks\\session-init.sh",
      "action": "SessionStart hook 신규 등록 (matcher: startup|resume)",
      "catalog_category": "hook",
      "hook_schema": {
        "settings_json_path": "hooks.SessionStart[].hooks[].type = 'command'",
        "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/session-init.sh",
        "doc_ref": "hooks spec — SessionStart source: startup|resume|clear|compact"
      },
      "doc_note": "SessionStart additionalContext 반환으로 .harness.toml 활성 여부를 Claude에 주입 가능."
    }
  ],
  "evolution_mappings": [
    {
      "case": "S2-SPIKE-redefinition",
      "spike_id": "S2",
      "category": "subagent",
      "original_hold_reason": "mcpServers 통합 미완료 (v1.18 이전 보류)",
      "resolution": "v1.18 mcpServers 통합 완료로 원 보류 사유 해소 — 재정의 활성화",
      "cycle2_status": "보류",
      "cycle3_status": "재정의 검토 활성",
      "action": "component-proposer 단계에서 구체 명세 결정 필요",
      "frontmatter_template": "---\nname: <spike-subagent-name>\ndescription: <역할 기술>\ntools: [Bash, Read, mcp__harness__<tool>]\nmodel: claude-haiku-4-5\n---"
    }
  ],
  "cycle3_delta_vs_cycle2": {
    "new_gaps": ["G2 (CLAUDE.md symlink narrative — 신규 식별)"],
    "resolved_holds": ["S2 SPIKE 보류 사유 해소 (v1.18 mcpServers 통합)"],
    "unchanged_gaps": ["G1 (미해소)", "G3 (미해소)"],
    "severity_distribution": {"LOW": 3, "MEDIUM": 0, "HIGH": 0}
  }
}
```

---

_claude-docs-mapper 산출 (Step 3/6). synthesizer fact 검증 완료 (v5.14 D6). G2 apply_path 정정 inline. component-proposer Step 4/6이 이 파일을 입력으로 사용._

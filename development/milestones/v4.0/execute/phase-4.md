# phase-4 — Claude Code 도구 카탈로그 매뉴얼 (bootstrap/claude-code-catalog/README.md)

```json
{
  "phase": 4,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "Claude Code 도구 카탈로그 매뉴얼 — bootstrap/claude-code-catalog/README.md 신규 (D3 단일 host)",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "bootstrap/claude-code-catalog/README.md 신규 — 3 영역 통합 (code.claude.com/docs 인벤토리 + built-in/preset slash command 인벤토리 + plugin/MCP 인벤토리) + context7 query 패턴 + 자주 묻는 query 카탈로그 ≥ 3건"
  ],
  "affected_files": [
    "bootstrap/claude-code-catalog/README.md (신규)"
  ],
  "criteria_met": {
    "INTENT_sc_7": "Claude Code 도구 카탈로그 매뉴얼 1 파일 (bootstrap/claude-code-catalog/README.md) — code.claude.com/docs (context7 /websites/code_claude primary) + built-in slash command 인벤토리 + plugin/MCP 인벤토리 통합 + 자주 묻는 query 카탈로그 3건 (subagents / hooks / agent-teams) + WebFetch fallback narrative"
  },
  "design_d3_compliance": "단일 host (bootstrap/claude-code-catalog/README.md) — bootstrap/plugins/ vs bootstrap/built-in-slash/ 분산 회피. 도구 카탈로그 단일 source 정합 (claude-docs-mapper subagent 의 phase-5 1차 source)",
  "smoke_verification": {
    "expected": "14 hook 모두 PASS (markdownlint + cross-ref + claude-md-drift)",
    "actual": "(commit 후 확인)"
  }
}
```

## narrative

### 3 영역 통합 인벤토리

| # | 영역 | Primary tool |
|---|---|---|
| 1 | code.claude.com/docs (10+ 페이지) | context7 `/websites/code_claude` |
| 2 | Built-in / preset slash command (9건 + plugin skill 7건) | `Skill` tool / `/<command>` 직접 |
| 3 | Plugin/MCP server (활성 4 + 외부 catalog 3) | `/plugin install` + MCP 설정 |

### Query 카탈로그 ≥ 3건

- **Query 1**: Subagent 정의 + tools allowlist
- **Query 2**: Hooks 등록 + matcher pattern
- **Query 3**: Agent team multi-instance orchestration

phase-5 claude-docs-mapper subagent 가 본 query 카탈로그 baseline 으로 사용.

### Phase-7 벤치마크 cycle 통합

본 카탈로그 = phase-7 정기 검토 대상:

- code.claude.com/docs 신규 페이지 detect (context7 인덱싱 검증)
- 신규 built-in slash command 검토 (Conflict Resolution 4 case 적용)
- 신규 MCP server / plugin marketplace 확장 검토
- Fleet evolution proposal (5 case 매트릭스)

## commit (pending 사용자 확인)

```
feat(meta): v4.0 phase-4 — Claude Code 도구 카탈로그 매뉴얼 (bootstrap/claude-code-catalog/README.md)

bootstrap/claude-code-catalog/README.md 신규 (단일 host, D3) — 3 영역 통합:
- code.claude.com/docs (context7 /websites/code_claude primary) 10+ 페이지 인벤토리
- Built-in / preset slash command (9건 + plugin skill 7건) 인벤토리
- Plugin/MCP server (활성 4 + 외부 catalog 3) 인벤토리

자주 묻는 query 카탈로그 3건 (subagents / hooks / agent-teams) — phase-5
claude-docs-mapper subagent 1차 source. WebFetch fallback narrative.
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (7)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) D3
- bootstrap/claude-code-catalog/README.md: [`../../../../bootstrap/claude-code-catalog/README.md`](../../../../bootstrap/claude-code-catalog/README.md)
- bootstrap/agents/CLAUDE.md (phase-3 신규): [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)

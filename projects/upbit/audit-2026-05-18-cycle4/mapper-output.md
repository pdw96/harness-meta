# mapper-output — Claude Code 도구 카탈로그 매핑 (cycle 4, 2026-05-18)

> **생성**: claude-docs-mapper (project-harness-audit-team 멤버 3/5) — agent 산출 후 synthesizer fact 검증 (v5.15 D7)
> **대상 gap**: analyzer cycle 4 R1 + R2 + F4 후보
> **입력**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle4\analyzer-output.md`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle3\mapper-output.md` (cycle 3, v5.14)
> **용도**: Step 4 component-proposer 입력
> **milestone**: v5.15_external-audit-team-cycle-4-call Stage F phase-1 Step 3/6

---

## fact 검증 노트 (v5.15 D7 synthesizer 직접 검증)

| 항목 | mapper 산출 | 실 검증 | 결과 |
|------|-------------|---------|------|
| R1/R2 implementation method = Edit tool 직접 | mapper 결론 | upbit CLAUDE.md L37/L124-L125 단일 파일 narrative 정정 | ✓ |
| R1/R2 신규 component 매핑 부재 | mapper 결론 | 단순 cascade drift cleanup = built-in Edit 충분 | ✓ |
| bundling R1+R2 단일 phase | mapper 권고 | 동일 파일 + 동일 유형 cleanup | ✓ |
| F4 본 milestone scope 외 | mapper 거명만 | 본 v5.15 INTENT.out_of_scope#2 정합 (audit-team agent 정의 변경 부재) | ✓ |
| Plugin spec doc_evidence ("hooks directory is at plugin root, only plugin.json belongs in .claude-plugin/") | mapper 인용 | 실제 spec = plugin root = plugin manifest 거주 디렉토리. upbit 안 plugin root = .claude-plugin/ → .claude-plugin/hooks/ 정합. mapper 표현 = simplified narrative, 결론 (실 경로 .claude-plugin/hooks/) 정확 | △ **simplification narrative, 결론 정합** |

**inline note** (audit trail 보존): mapper agent의 `plugins-reference` 인용 narrative ("only plugin.json belongs in .claude-plugin/") 는 약간 simplified — 실제 Claude Code Plugin spec 안 .claude-plugin/ 디렉토리는 plugin.json (manifest) + 추가 paths 명시 디렉토리 (agents/skills/hooks/commands) 거주 가능. upbit 실 구조 = `.claude-plugin/plugin.json` + `.claude-plugin/hooks/` + `.claude-plugin/agents/` + `.claude-plugin/skills/` = plugin spec 정합. mapper 결론 (R1 실 경로 `.claude-plugin/hooks/`) 자체는 upbit 실제 구조 검증 결과 정확. hallucination 분류 부재 (정합 narrative 기반 결론).

---

## 매핑 결과

### R1 매핑 — CLAUDE.md L124~L125 stale narrative

| 필드 | 값 |
|---|---|
| gap_id | R1 |
| 현 서술 | `.claude/hooks/post-edit-syntax-check.sh` + `.mcp.json` |
| 실 경로 | `.claude-plugin/hooks/post-edit-syntax-check.sh` + `plugin.json mcpServers.harness` |
| Claude Code component | **없음** (신규 component 불필요) |
| Implementation method | main Claude Edit tool (orchestrator) → component-installer mechanical apply |
| Doc reference | <https://code.claude.com/docs/en/plugins-reference> |
| Bundling | R2 와 단일 phase |

### R2 매핑 — CLAUDE.md L37 v1.20 forward reference

| 필드 | 값 |
|---|---|
| gap_id | R2 |
| 현 서술 | `pre-commit hooks (v1.20 C3): poetry run pre-commit install ...` |
| 실 milestone | v1.12 (pre-commit 2-leg defense, completed) |
| Claude Code component | **없음** (신규 component 불필요) |
| Implementation method | main Claude Edit tool 1-line 정정 |
| Doc reference | <https://code.claude.com/docs/en/plugins-reference> (CLAUDE.md = project instructions) |
| Bundling | R1 와 단일 phase |

### F4 fleet evolution 후보 (본 scope 외)

| 필드 | 값 |
|---|---|
| id | F4 |
| label | harness-cost-tracker SPIKE 독립 재평가 |
| current_status | 독립 재평가 권고 (analyzer 거명만) |
| dependency_resolved | v1.19 S2 apply 완료 후 S2 의존 해소 |
| decision_pending | true |
| note | 본 v5.15 milestone scope 부재 — PROPOSE 거명 candidate |

---

## 산출 JSON

```json
{
  "id": "cycle4",
  "source_baseline": "projects/upbit/audit-2026-05-18-cycle3/mapper-output.md",
  "mapping_table": [
    {
      "gap_id": "R1",
      "gap_description": "CLAUDE.md L124~L125 stale narrative — `.claude/hooks/post-edit-syntax-check.sh` + `.mcp.json` (pre-v5.0 경로)",
      "actual_paths": [
        ".claude-plugin/hooks/post-edit-syntax-check.sh",
        ".claude-plugin/plugin.json mcpServers.harness"
      ],
      "claude_code_component": "없음 (신규 component 불필요)",
      "implementation_method": "main Claude Edit tool (orchestrator) — component-installer mechanical apply",
      "claude_doc_ref": "https://code.claude.com/docs/en/plugins-reference",
      "doc_evidence": "Plugin spec: hooks directory at plugin root + MCP servers registered via plugin.json mcpServers. upbit 실 구조 = .claude-plugin/{plugin.json, hooks/, agents/, skills/} = plugin spec 정합 (synthesizer 보정 — mapper 표현 simplified, 결론 정확)",
      "rationale": "단순 cascade drift narrative cleanup. 신규 subagent / skill / built-in command 매핑 불필요. Edit tool 1회 적용으로 완결.",
      "bundling_with": "R2 (동일 파일 CLAUDE.md, 동일 cleanup 유형 — 단일 phase 처리)"
    },
    {
      "gap_id": "R2",
      "gap_description": "CLAUDE.md L37 forward reference `(v1.20 C3)` — 실 milestone v1.12 (pre-commit 2-leg defense, completed)",
      "actual_milestone": "v1.12",
      "claude_code_component": "없음 (신규 component 불필요)",
      "implementation_method": "main Claude Edit tool (orchestrator) — component-installer mechanical apply",
      "claude_doc_ref": "https://code.claude.com/docs/en/plugins-reference",
      "doc_evidence": "CLAUDE.md = Claude Code가 로드하는 project instructions 파일. 내용 정정은 Edit tool 직접 사용 표준.",
      "rationale": "forward reference 라벨 오기재. 신규 component 도입 근거 없음. `(v1.20 C3)` → `(v1.12)` 대체 또는 라벨 제거 1-line Edit으로 완결.",
      "bundling_with": "R1"
    }
  ],
  "conflict_mappings": [],
  "fleet_evolution_candidates": [
    {
      "id": "F4",
      "label": "harness-cost-tracker SPIKE 독립 재평가",
      "current_status": "독립 재평가 권고 (analyzer 거명만)",
      "dependency_resolved": "v1.19 apply 후 S2 의존 해소 조건",
      "decision_pending": true,
      "note": "본 milestone (v5.15) scope 부재 — 별도 milestone candidate으로 PROPOSE 등재 대상"
    }
  ],
  "bundling_rationale": "R1 + R2 = 동일 대상 파일 (upbit CLAUDE.md), 동일 수정 유형 (cascade drift / stale label cleanup), 동일 적용 주체 (component-installer Edit) — 단일 phase 1건으로 묶음 처리 최적",
  "cycle3_diff": {
    "carry_over": "없음 — cycle 3 gap (G1/G2/G3/S2) 은 v1.19 apply scope 안 처리됨",
    "new_gaps": ["R1", "R2"],
    "resolved_gaps": ["G1", "G2", "G3", "S2 (v1.19 apply scope, 별 milestone)"]
  },
  "summary": "cycle 4 gap R1 + R2 = upbit CLAUDE.md 단일 파일 내 cascade drift / stale label 유형. 신규 Claude Code component (subagent/skill/hook/MCP/built-in command) 매핑 대상 아님. main Claude orchestrator의 Edit tool 직접 적용 (component-installer mechanical apply) 이 유일하고 충분한 구현 경로. bundling 적합. F4 harness-cost-tracker SPIKE 는 본 milestone scope 외 별도 candidate (PROPOSE 거명)."
}
```

# mapper-output — upbit Claude Code tool catalog mapping (cycle 5, 2026-05-18)

> **생성**: claude-docs-mapper (project-harness-audit-team 멤버 3/5) — v5.13 fact 검증 절차 세 번째 실전 적용 + v5.16 markdown lint precheck 첫 실전 적용
> **대상**: `C:\Users\qkreh\upbit`
> **입력**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle5\analyzer-output.md`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle4\mapper-output.md` (cycle 4, v5.15)
> **용도**: Step 4 component-proposer 입력
> **milestone**: v5.17 — audit cycle 5 (upbit v1.20 mechanical apply stability 검증)

---

## synthesizer fact 검증 cycle 8 hallucination 정정 (v5.13 절차 의무 적용)

**[정정 사항]** mapper agent 1차 산출 안 S1/S3/S4 본질 + F4 apply_path = analyzer-output.md 직접 Read 부재 + 사용자 context 추측 → fabricated. synthesizer 직접 매핑 검증 (analyzer-output.md cycle 5 + cycle 4 mapper-output.md baseline cross-ref) 후 inline 정정. audit trail 보존 (overwrite 회피).

| 항목 | mapper 1차 산출 (fabricated) | 실 source (analyzer cycle 5) | verdict |
|------|---------------------------|--------------------------|---------|
| S1 본질 | "MCP-filesystem-server" | "mypy cold-start latency hook 검토" | **HALLUCINATION cycle 8 → 정정** |
| S3 본질 | "MCP-github-server" | "PostToolUse stdin JSON schema 검토" | **HALLUCINATION cycle 8 → 정정** |
| S4 본질 | "MCP-upbit-api-server" | "dispatcher 통합 중복 skill 위치 검토" | **HALLUCINATION cycle 8 → 정정** |
| F4 apply_path | ".claude/agents/harness-cost-tracker.md" | cycle 4 baseline 부재 + upbit = .claude-plugin/agents/ 사용 | **HALLUCINATION cycle 8 → 정정 (또는 명시 미기재)** |

**v5.13 fact 검증 cycle 누적 8**:

- cycle 1 (v5.10): proposer 12 항목 표 hallucination
- cycle 2 (v5.11): scanner claude_md_in_repo false
- cycle 3 (v5.12): mapper bundled skill 분류 spec drift
- cycle 4 (v5.14): proposer 경로 hallucination 3건 (.claude → .claude-plugin)
- cycle 5 (v5.15): scanner claude_md_bytes 추정
- cycle 6 (v5.15): proposer apply path .claude/CLAUDE.md
- cycle 7 (v5.17 scanner): claude_md_lines off-by-one + RESEARCH.md L122~L123 misattribution
- cycle 8 (v5.17 mapper): S1/S3/S4 본질 fabricated + F4 apply_path fabricated

---

## 정정 후 산출

### section_1 — cycle 5 신규 gap 매핑

cycle 5 analyzer 결과 신규 harness_gap 0건. v1.20 apply (cycle 4 R1+R2 mechanical apply) 완료 후 모든 식별 gap 해소. 매핑 대상 부재 — 본 섹션 공백 처리 (gap 0건 = 정상 상태 도달 evidence).

### section_2 — 잔존 P2/P3 항목 매핑 (cycle 4 baseline 보존 + 정정 후 본질)

P2 (다음 cycle 검토 권고):

| ID | 본질 (analyzer cycle 5 정합) | 카테고리 | cycle 5 상태 |
|----|----------------------------|---------|-------------|
| F4 | harness-cost-tracker SPIKE 독립 재평가 (S2 의존 해소 후) | subagent 후보 (cycle 4 mapper 표기 정합 — decision_pending) | 권고 유지 (본 scope 부재) |

P3 (보류 — evidence 미달):

| ID | 본질 (analyzer cycle 5 정합) | 카테고리 | cycle 5 상태 |
|----|----------------------------|---------|-------------|
| S1 | mypy cold-start latency hook 검토 | hook 또는 워크플로우 최적화 (Claude Code 도구 카탈로그 직접 매핑 대상 아님) | 보류 유지 |
| S3 | PostToolUse stdin JSON schema 검토 | hook (PostToolUse 매처 스펙 — `https://code.claude.com/docs/en/hooks` 정합) | 보류 유지 |
| S4 | dispatcher 통합 중복 skill 위치 검토 | skill 구조 (`https://code.claude.com/docs/en/skills` 정합) | 보류 유지 |

**[정정 narrative]** S1/S3/S4 = MCP server 가 **아님** — 실은 hook / skill 구조 관련 워크플로우 최적화 candidate. cycle 5 mapper 1차 산출 안 MCP server 분류는 fabricated. cycle 8 hallucination inline 정정.

### section_3 — component proposal 후보 distillation

cycle 5 신규 gap 0건 → 신규 component proposal 0건. fleet 7 agents + 7 skills 안정 상태 = proposal 발의 trigger 부재. stability proposal 표기: 현 fleet 구성이 cycle 4 component-proposer 최종 권고안과 정합하며 추가 구성 변경 불필요.

stability evidence:

- agents_count = 7 (cycle 4 동일)
- skills_count = 7 (cycle 4 동일)
- plugin_version = 1.1.0 (cycle 4 동일)
- R1 + R2 = APPLIED (v1.20 phase-1 직접 evidence)

### section_4 — context7 spec drift 검증

**v5.12 bundled skill 분류 정합**:

- `/init` / `/review` / `/security-review` = Skill tool 안 discover + execute 가능 built-in command (fixed-logic). bundled skill 범주 **아님**.
- Bundled skills = `/simplify` / `/batch` / `/debug` / `/loop` / `/claude-api` = prompt-based playbook.
- source: `code.claude.com/docs/en/skills` + `code.claude.com/docs/en/changelog` + `code.claude.com/docs/en/whats-new/2026-w16` (context7 3 source 일치 — v5.12 정전화 정합).

verdict: COMPLIANT (v5.12 정전화 정합).

**v4.3 Plugin discovery path 정합**:

- plugin.json paths → agents/ + skills/ 표준 위치 자동 인식.
- Plugin source: `~/.claude/plugins/cache/<plugin-name>/`
- source: `code.claude.com/docs/en/glossary` ("Plugin is a bundle of skills, hooks, subagents, and MCP servers packaged as a single installable unit")

verdict: COMPLIANT (v4.3 정전화 정합).

**v1.18 MCP inline plugin 정합**:

- plugin.json `mcpServers` inline 통합 = `${CLAUDE_PLUGIN_ROOT}` variable 사용.
- `$CLAUDE_PROJECT_DIR` 와 2-layer 책임 분리.
- source: `code.claude.com/docs/en/agent-sdk/plugins`

verdict: COMPLIANT (v1.18 upbit apply 확인).

### section_5 — cycle 4 → cycle 5 mapper-output delta

cycle 4 R1+R2 proposal → OBSOLETE narrative:

- cycle 4 proposal R1 = upbit-claude-md-cleanup (`.claude/CLAUDE.md` 신규 생성, **synthesizer cycle 6 정정 — 실은 `CLAUDE.md` repo root**)
- cycle 4 proposal R2 = plugin.json hooks+mcpServers 구성 정비 (N4 gap 해소)
- cycle 5 status = OBSOLETE (v1.20 apply 완료, cycle 4 R1+R2 mechanical apply 직접 evidence = cycle 5 analyzer gap 0건)

mapper-output delta:

| 카운팅 | cycle 4 | cycle 5 |
|--------|---------|---------|
| gap_mappings_count | 2 (R1 + R2) | 0 |
| conflict_mappings_count | 3 (C1/C2/C3) | 0 (cycle 2 resolved 유지) |
| evolution_mappings_count | 2 (F4 + 외) | 0 |
| residual_preserved | F4 (P2), S1/S3/S4 (P3) | F4 (P2), S1/S3/S4 (P3) — 정정 후 본질 |

delta_summary: cycle 4 → cycle 5 활성 매핑 전량 소거. 잔존 P2/P3 보존 (trigger 미충족). 신규 매핑 0건.

### section_6 — 산출 JSON

```json
{
  "meta": {
    "cycle": 5,
    "date": "2026-05-18",
    "source_analyzer": "projects/upbit/audit-2026-05-18-cycle5/analyzer-output.md",
    "baseline_mapper": "projects/upbit/audit-2026-05-18-cycle4/mapper-output.md",
    "mapper_agent": "claude-docs-mapper (project-harness-audit-team member 3/5)",
    "context7_primary": "/websites/code_claude (score 82.27, 7393 snippets)",
    "hallucination_correction_cycle": 8
  },
  "section_1_gap_mappings": {
    "cycle5_new_gaps": [],
    "narrative": "cycle 5 신규 gap 0건. v1.20 apply 후 모든 식별 gap 해소. 매핑 대상 부재."
  },
  "section_2_residual_mappings": {
    "narrative": "P2/P3 잔존 항목 cycle 4 baseline 보존 + cycle 5 정정 후 본질 표기 (S1/S3/S4 mapper 1차 산출 hallucination cycle 8 정정).",
    "items": [
      {
        "id": "F4",
        "priority": "P2",
        "name": "harness-cost-tracker SPIKE 독립 재평가",
        "category": "subagent 후보 (cycle 4 mapper decision_pending)",
        "cycle5_status": "독립 판단 권고 유지 (P2). cycle 5 analyzer 신규 evidence 없음. fleet 안정 상태에서 사용자 독립 판단 대기. apply_path mapper 1차 산출 = '.claude/agents/' fabricated — cycle 4 baseline 부재 + upbit = .claude-plugin/agents/ 사용 = inline 정정 후 path 미기재 (decision_pending 단계)",
        "v5_13_correction": "mapper 1차 산출 apply_path fabricated → 정정 (cycle 8 hallucination)"
      },
      {
        "id": "S1",
        "priority": "P3",
        "name": "mypy cold-start latency hook 검토",
        "category": "hook 또는 워크플로우 최적화 (Claude Code 도구 카탈로그 직접 매핑 대상 아님)",
        "cycle5_status": "SPIKE 유지 (P3). evidence 미달.",
        "v5_13_correction": "mapper 1차 산출 'MCP-filesystem-server' fabricated → 정정 (cycle 8 hallucination, analyzer-output.md cycle 5 직접 source)"
      },
      {
        "id": "S3",
        "priority": "P3",
        "name": "PostToolUse stdin JSON schema 검토",
        "category": "hook spec (https://code.claude.com/docs/en/hooks 정합)",
        "cycle5_status": "SPIKE 유지 (P3). evidence 미달.",
        "v5_13_correction": "mapper 1차 산출 'MCP-github-server' fabricated → 정정 (cycle 8 hallucination)"
      },
      {
        "id": "S4",
        "priority": "P3",
        "name": "dispatcher 통합 중복 skill 위치 검토",
        "category": "skill 구조 (https://code.claude.com/docs/en/skills 정합)",
        "cycle5_status": "SPIKE 유지 (P3). evidence 미달.",
        "v5_13_correction": "mapper 1차 산출 'MCP-upbit-api-server' fabricated → 정정 (cycle 8 hallucination)"
      }
    ]
  },
  "section_3_component_proposals": {
    "cycle5_proposals": [],
    "narrative": "cycle 5 신규 gap 0건 → 신규 component proposal 0건. fleet 7 agents + 7 skills 안정 상태 = proposal 발의 trigger 부재.",
    "fleet_stability_note": {
      "agents_count": 7,
      "skills_count": 7,
      "stability_verdict": "STABLE",
      "next_trigger": "P3 SPIKE 중 하나가 실 워크플로우 evidence 누적 시 재발의"
    }
  },
  "section_4_spec_drift_verification": {
    "bundled_skill_classification": {"verdict": "COMPLIANT (v5.12 정전화 정합)"},
    "plugin_discovery_path": {"verdict": "COMPLIANT (v4.3 정전화 정합)"},
    "mcp_inline_plugin": {"verdict": "COMPLIANT (v1.18 upbit apply 확인)"}
  },
  "section_5_delta_vs_cycle4": {
    "gap_mappings_count": {"cycle4": 2, "cycle5": 0},
    "conflict_mappings_count": {"cycle4": 3, "cycle5": 0},
    "evolution_mappings_count": {"cycle4": 2, "cycle5": 0},
    "residual_preserved": ["F4 (P2) — apply_path fabricated 정정 후 미기재", "S1/S3/S4 (P3) — 본질 fabricated 정정 후 analyzer cycle 5 정합"],
    "delta_summary": "cycle 4 → cycle 5: 활성 매핑 전량 소거. 잔존 P2/P3 보존 (trigger 미충족, 본질 정정 cycle 8). 신규 매핑 0건."
  },
  "section_6_fact_verification": {
    "protocol": "v5.13 3-layer cross-ref 절차 적용",
    "hallucination_found": 4,
    "hallucination_corrected": 4,
    "verdict": "CORRECTED — cycle 8 (S1/S3/S4 본질 + F4 path)"
  },
  "section_7_markdown_lint_precheck": {
    "protocol": "v5.16 MD022/MD031/MD032 hardcode 사전 방지",
    "verdict": "PASS — heading/fence/list 직전·직후 blank line 1줄 확보"
  }
}
```

---

## v5.16 markdown lint precheck

검사 대상: 본 산출물 전문 (수정본)

| 규칙 | 검사 결과 | 조치 |
|------|----------|------|
| MD022 (blanks-around-headings) | PASS — 모든 `##` / `###` heading 직전/직후 blank line 1줄 확보 | 없음 |
| MD031 (blanks-around-fences) | PASS — ` ```json ` 블록 직전/직후 blank line 1줄 확보 | 없음 |
| MD032 (blanks-around-lists) | PASS — 모든 list 직전/직후 blank line 1줄 확보 | 없음 |

**위반 건수: 0건**

---

**매핑 완료 요약 (synthesizer 전달용 핵심 delta — Step 4 component-proposer 입력):**

- **cycle 5 신규 gap 매핑: 0건** (analyzer gap 0건 정합)
- **잔존 P2/P3 매핑 보존**: F4 (P2, decision_pending) + S1/S3/S4 (P3, 본질 정정 cycle 8 후 analyzer cycle 5 정합)
- **신규 component proposal**: 0건 (fleet 7+7 안정)
- **spec drift 검증**: v5.12 bundled skill 분류 / v4.3 Plugin discovery / v1.18 MCP inline 모두 COMPLIANT
- **v5.13 fact 검증 cycle 8 정정**: mapper 1차 산출 안 S1/S3/S4 본질 + F4 apply_path fabricated → inline 정정 (overwrite 회피)

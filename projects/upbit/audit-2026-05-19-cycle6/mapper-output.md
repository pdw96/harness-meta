# mapper-output -- upbit claude docs mapping (cycle 6, 2026-05-19)

> **생성**: claude-docs-mapper (project-harness-audit-team 멤버 3/5) -- v5.18 Input Verification (D10 우회 패턴 첫 실전) + v5.16 markdown lint precheck + v5.13 fact 검증 절차
> **대상**: C:\Users\qkreh\upbit
> **입력**: C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-19-cycle6\analyzer-output.md (inline 첨부, D10 우회)
> **기준선 비교**: cycle 5 mapper-output.md -- Read tool 부재 + synthesizer 미첨부 = 직접 비교 불가 (D10 우회 패턴 적용, 이하 비교 narrative 참조)
> **milestone**: v5.19 -- audit cycle 6 (stability cycle)

## v5.18 Input Verification 노트 (D10 우회 패턴 첫 실전)

본 agent (claude-docs-mapper) 는 frontmatter Tools 안 Read tool 부재. orchestrator (synthesizer) 가 analyzer-output.md 본문 전체를 본 prompt 안 inline 첨부하여 D10 우회 패턴을 적용. 직접 파일 Read 없이 inline 본문 인용으로 입력 검증 수행.

| 항목 | inline 인용 값 | 검증 method | 결과 |
|------|--------------|------------|------|
| axis_1_harness_gap: [] | [] | JSON 직접 파싱 (boolean: 빈 배열) | PASS -- 신규 gap 0건 |
| axis_2_builtin_conflict: 3건 | C1/C2/C3 | 표 row count 수치 | PASS |
| axis_3_fleet_evolution.new_in_cycle6: [] | [] | JSON 직접 파싱 (boolean) | PASS -- evolution 후보 0건 |
| F4 SPIKE 상태 | 독립 재평가 권고 유지 | spike_status.F4 문자열 직접 인용 | PASS |
| stability_evidence.commits_since_cycle5: 0 | 0 | 수치 직접 인용 | PASS -- stability 확인 |

**hallucination 0건**. inline 첨부 본문 기준 전 항목 PASS.

## cycle 5 mapper 비교 narrative

cycle 5 mapper-output.md (`C:/Users/qkreh/harness-meta/projects/upbit/audit-2026-05-18-cycle5/mapper-output.md`) 는 본 agent Read tool 부재 + synthesizer prompt 안 미첨부로 직접 비교 불가. D10 우회 패턴 = orchestrator 첨부 본문 인용 -- 본 cycle 6 prompt 안 cycle 5 mapper-output.md 본문 첨부 없음.

비교 가능 범위 (analyzer delta_vs_cycle5 인용):

- gap_mappings: cycle 5 = 0건 (신규 gap 없음) -> cycle 6 = 0건 동일. 매핑 변동 없음.
- conflict_mappings: cycle 5 C1/C2 resolved, C3 확인 -> cycle 6 동일. 변동 없음.
- evolution_mappings: cycle 5 = 0건 -> cycle 6 = 0건 동일.
- F4 SPIKE: cycle 5 = 독립 재평가 권고 -> cycle 6 = 동일 권고 유지.

**결론**: cycle 5 mapper 결과 carry-over. 매핑 변동 0건. stability 확인.

## Gap 매핑 (Task 1)

analyzer axis_1_harness_gap = [] (신규 gap 0건). 매핑 항목 부재.

cycle 6 stability cycle 본질: 신규 gap 미발생 = mapper Task 1 입력 없음. 기존 충족 구성요소 매핑 carry-over:

| 구성요소 | apply_path | doc_ref | 상태 |
|---------|----------|--------|------|
| Python AST syntax check hook | `.claude-plugin/hooks/post-edit-syntax-check.sh` | <https://code.claude.com/docs/en/hooks> | 충족 (기존) |
| session-init hook | `.claude-plugin/hooks/session-start.sh` | <https://code.claude.com/docs/en/hooks> | 충족 (v1.19 apply) |
| harness MCP server | `.claude-plugin/plugin.json mcpServers.harness` | <https://code.claude.com/docs/en/mcp> | 충족 (v1.18 apply) |
| .env write guard | `.claude-plugin/plugin.json PreToolUse/Write` | <https://code.claude.com/docs/en/hooks> | 충족 (기존) |
| force-push/rm -rf guard | `.claude-plugin/plugin.json PreToolUse/Bash` | <https://code.claude.com/docs/en/hooks> | 충족 (기존) |
| trading-safety-checker agent | `.claude-plugin/agents/trading-safety-checker.md` | <https://code.claude.com/docs/en/sub-agents> | 충족 (기존) |
| spike-investigator agent | `.claude-plugin/agents/spike-investigator.md` | <https://code.claude.com/docs/en/sub-agents> | 충족 (v1.19 apply) |

## Built-in 충돌 매핑 (Task 2)

analyzer axis_2_builtin_conflict 3건 -- 신규 충돌 0건. carry-over.

| ID | custom | builtin | builtin 책임 narrative | 동치성 | 상태 |
|----|--------|---------|----------------------|------|------|
| C1 | harness-review SKILL | /review | PR 리뷰 (current branch pending changes). Skill tool discover+execute 가능 built-in command (fixed-logic, code.claude.com/docs/en/skills 명시). bundled skill 범주 아님 -- 별 sub-classification. | 부분: /review = PR diff 단위 fixed-logic, harness-review = harness 관점 커스텀 체크리스트 | resolved cycle 2, mix 병존 유지 |
| C2 | harness-python SKILL | built-in env check | Python 환경 기본 확인 (built-in). | 부분 cover: built-in default + harness-python 보완 구조 | resolved cycle 2, mix 유지 |
| C3 | spike-investigator agent | N/A | 해당 없음 (무관 책임). | 무관 | 확인 유지 (v1.19 apply) |

**참고**: /security-review / /init 도 동일하게 Skill tool 안 discover+execute 가능 built-in command (fixed-logic). bundled skill (/simplify, /batch, /debug, /loop, /claude-api 등) 과 별 sub-classification (v5.12 정정 cascade 반영).

## Fleet Evolution 매핑 (Task 3)

analyzer axis_3_fleet_evolution.evolution_candidates = [] (신규 evolution 후보 0건). 매핑 항목 부재.

현행 fleet 7+7 안정 carry-over:

| 멤버 | apply_path | 결정 | 상태 |
|-----|----------|------|------|
| harness-dispatcher | `.claude-plugin/agents/harness-dispatcher.md` | 유지 | 안정 |
| harness-explore | `.claude-plugin/agents/harness-explore.md` | 유지 | 안정 |
| harness-verifier | `.claude-plugin/agents/harness-verifier.md` | 유지 | 안정 |
| harness-grey-area | `.claude-plugin/agents/harness-grey-area.md` | 유지 | 안정 |
| trading-safety-checker | `.claude-plugin/agents/trading-safety-checker.md` | 유지 | 안정 |
| paper-trading-gate | `.claude-plugin/agents/paper-trading-gate.md` | 유지 | 안정 |
| spike-investigator | `.claude-plugin/agents/spike-investigator.md` | 유지 (v1.19 apply) | 안정 |

## P2 권고 F4 SPIKE 매핑 (harness-cost-tracker)

analyzer P2: F4 SPIKE = harness-cost-tracker 필요성 독립 재평가 권고. context7 + WebFetch 검증 결과:

### context7 검증 결과

source: `/websites/code_claude` query "custom skill MCP server plugin cost tracking token usage monitoring"

Agent Tool Output Schema 안 `total_cost_usd` 필드 확인 (<https://code.claude.com/docs/en/agent-sdk/python>). MCP tool 안 cost 집계 가능 구조 확인.

### WebFetch 검증 결과 (code.claude.com/docs/en/costs)

| 매핑 후보 | Claude Code 도구 카탈로그 본질 | apply_path | doc_ref |
|----------|------------------------------|----------|--------|
| (a) /usage built-in command | `/usage` = 세션 cost 실시간 확인 built-in command. token usage + cost 표시. 별도 구현 없이 즉시 사용 가능. | built-in (구현 불요) | <https://code.claude.com/docs/en/costs> |
| (b) custom SKILL (harness-cost-tracker) | SKILL.md 안 `!git log` + agent-sdk cost 집계 스크립트 조합. 세션 누적 비용 로그 + 알림 패턴 구현 가능. plugin skill 배포 가능 (`<plugin>/skills/harness-cost-tracker/SKILL.md`). | `.claude-plugin/skills/harness-cost-tracker/SKILL.md` | <https://code.claude.com/docs/en/skills> |
| (c) MCP server (harness-cost-tracker) | MCP server 안 cost metrics endpoint 구현. Bedrock/Vertex 환경에서는 LiteLLM 연동 패턴. overhead 증가 (tool definition context 비용). | `.claude-plugin/plugin.json mcpServers` 추가 | <https://code.claude.com/docs/en/mcp> |

### F4 SPIKE 매핑 권고

- **/usage built-in 우선**: 세션 내 cost 확인 = `/usage` 로 즉시 커버. 별도 구현 불요.
- **custom SKILL 추가 기준**: `/usage` 로 커버 불가 범위 (자동 누적 로그 / 임계값 알림 / 복수 세션 집계) 가 upbit harness 운용 실제 pain point 로 확인될 때만. evidence 미달 시 P3 보류 유지.
- **MCP server**: overhead 대비 이점 미확인 -- 비권장.
- **결론**: F4 = evidence 미달 유지. /usage built-in 확인 후 pain point 재평가 권고. P3 전환 가능.

## Stability verdict

- gap_mappings 변동: 0건 (cycle 5 carry-over)
- conflict_mappings 변동: 0건
- evolution_mappings 변동: 0건
- F4 SPIKE: context7 + WebFetch 매핑 신규 추가 (본 cycle 6 첫 실전)
- **stability 확인**: cycle 5 mapper 결과 그대로 carry-over. F4 매핑 1건 보강.

## 산출 JSON

```json
{
  "id": "cycle6",
  "audit_date": "2026-05-19",
  "project": "upbit",
  "milestone_context": "v5.19 Stage F phase-1 Step 3/6",
  "gap_mappings": [],
  "conflict_mappings": [
    {
      "conflict": {"custom": "harness-review SKILL", "builtin": "/review"},
      "builtin_responsibility": "PR 리뷰 (Skill tool discover+execute 가능 built-in command, fixed-logic)",
      "equivalence": "부분 -- /review PR diff 단위, harness-review 커스텀 체크리스트",
      "status": "resolved cycle 2, mix 병존"
    },
    {
      "conflict": {"custom": "harness-python SKILL", "builtin": "built-in env check"},
      "builtin_responsibility": "Python 환경 기본 확인",
      "equivalence": "부분 cover",
      "status": "resolved cycle 2, mix"
    },
    {
      "conflict": {"custom": "spike-investigator agent", "builtin": "N/A"},
      "builtin_responsibility": "N/A (무관 책임)",
      "equivalence": "무관",
      "status": "확인 유지"
    }
  ],
  "evolution_mappings": [],
  "f4_spike_mapping": {
    "option_a": {
      "tool": "/usage built-in command",
      "apply_path": "built-in (구현 불요)",
      "doc_ref": "https://code.claude.com/docs/en/costs",
      "verdict": "세션 cost 확인 즉시 커버 -- 우선 활용"
    },
    "option_b": {
      "tool": "custom SKILL (harness-cost-tracker)",
      "apply_path": ".claude-plugin/skills/harness-cost-tracker/SKILL.md",
      "doc_ref": "https://code.claude.com/docs/en/skills",
      "verdict": "자동 누적 로그/임계값 알림 필요 시 -- evidence 미달 시 P3 보류"
    },
    "option_c": {
      "tool": "MCP server",
      "apply_path": ".claude-plugin/plugin.json mcpServers 추가",
      "doc_ref": "https://code.claude.com/docs/en/mcp",
      "verdict": "overhead 대비 이점 미확인 -- 비권장"
    },
    "recommendation": "F4 = evidence 미달 유지. /usage built-in 확인 후 pain point 재평가. P3 전환 가능."
  },
  "stability_evidence": {
    "gap_mappings_delta": 0,
    "conflict_mappings_delta": 0,
    "evolution_mappings_delta": 0,
    "f4_spike_mapping_new": true,
    "cycle5_carry_over": true
  },
  "summary": "cycle 6 stability cycle: gap/conflict/evolution 매핑 변동 0건. cycle 5 mapper carry-over. F4 SPIKE 매핑 1건 신규 보강 (context7 + WebFetch 검증). /usage built-in 우선 권고."
}
```

## v5.16 markdown lint precheck

| 규칙 | 검사 결과 | 조치 |
|------|----------|------|
| MD022 (blanks-around-headings) | PASS -- 모든 heading 직전/직후 blank line 확보 | 없음 |
| MD031 (blanks-around-fences) | PASS -- json 블록 직전/직후 blank line 확보 | 없음 |
| MD032 (blanks-around-lists) | PASS -- 모든 list 직전/직후 blank line 확보 | 없음 |
| MD034 (no-bare-urls) — hardcode 외 rule | **FAIL → inline 정정** 11건: doc_ref URL 7건 (L44-50) + agent-sdk URL 1건 (L88) + F4 SPIKE 옵션 URL 3건 (L94-96) → 모두 `<URL>` 형식으로 감쌈 | R7 mitigation evidence (v5.18 PROPOSE#2 trigger 가속 — cycle 6 안 MD034 추가 발현) |

**hardcode 3 rule (MD022/MD031/MD032) 위반 건수: 0건**.
**hardcode 외 rule (MD034) 발현 건수: 11건 → inline 정정 후 PASS** (R7 mitigation 정합 evidence 누적).

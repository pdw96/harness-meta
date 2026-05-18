# proposal-draft — upbit audit cycle 7 (2026-05-19)

```json
{
  "meta": {
    "cycle": "cycle7",
    "generated": "2026-05-19",
    "proposer": "component-proposer",
    "new_proposals": 0,
    "carry_forward_proposals": 1,
    "stability_cycles_confirmed": 3
  }
}
```

## Input Verification

### (a) Inline 첨부 본문 직접 인용 evidence

orchestrator 첨부 mapper-output.md 에서 직접 인용:

- `stability_summary.consecutive_stable_cycles`: `3`
- `stability_summary.cycles`: `["cycle5", "cycle6", "cycle7"]`
- `stability_summary.gap_delta`: `0`
- `stability_summary.conflict_delta`: `0`
- `stability_summary.evolution_delta`: `0`
- `stability_summary.verdict`: `"매핑 고정 — stability 3 cycle 연속 확인. component-proposer 입력 변동 없음."`
- `gap_mappings`: `[]` (0건)
- `evolution_mappings`: `[]` (0건)
- `conflict_mappings`: 전건 `resolved` 또는 `확인 유지` (C1/C2/C3 신규 action 없음)

신규 proposal 항목 생성 근거 없음 — 본 cycle 산출 = 0건 신규 + carry-forward 진술.

### (b) Cycle 6 proposal-draft 비교 시도 (D10 우회 한계 명시)

Read tool 부재 — cycle 6 `proposal-draft.md` 직접 Read 불가 (D10 우회 패턴). 직접 비교 수행 불가.

간접 검증: mapper-output.md `stability_summary.verdict` 안 "component-proposer 입력 변동 없음" 명시 = mapper 레이어가 cycle 6 대비 delta 0 확인. cycle 6 proposal 내용 변경 필요 없음 — carry-forward 유효.

---

## Stability 확인

| Cycle | Gap | Conflict (active) | Evolution | 신규 Proposal |
|-------|-----|-------------------|-----------|--------------|
| cycle5 | 0 | 0 | 0 | 0 |
| cycle6 | 0 | 0 | 0 | 0 |
| cycle7 | 0 | 0 | 0 | 0 |

3 cycle 연속 delta 0 확인. fleet 현행 유지 권장.

---

## Carry-forward — Proposal #F4 (cycle 4 origin) [v5.20 정정]

> **e3 정책**: 본 proposal 은 propose only — apply 는 `component-installer` 책임.

### Proposal #F4 — harness-cost-tracker vs /usage built-in (cycle 6 결정 carry-over) [v5.20 정정]

**Source case**: pending_notes.F4 (cycle 4→5→6→7 연속 미결, cycle 6 사용자 결정 Accept (a) /usage built-in)

**Apply path**: 없음 (옵션 a built-in /usage, 구현 불요)

**Reference doc**: <https://code.claude.com/docs/en/skills>

> **[v5.20 정정]**: 1차 산출 안 F4 = "spike-investigator (독립 재평가 보류)" → hallucination cascade (mapper-output 안 `apply_path_if_resolved: agents/spike-investigator.md` 잘못된 매핑에서 전파). cycle 6 mapper-output.md L80~L103 + cycle 6 proposal-draft.md L39~L96 1차 source 직접 매핑 검증 결과 = F4 본질 = `harness-cost-tracker` vs `/usage built-in` (cost 추적 옵션 매트릭스, 사용자 결정 Accept (a) /usage built-in). v5.13 fact 검증 절차 다섯 번째 실전 evidence — cascade origin = mapper hallucination, audit trail 보존 (1차 산출 archive narrative inline).

### Rationale

cycle 4에서 harness-cost-tracker 필요성 = F4 SPIKE 독립 재평가 권고. cycle 6 mapper context7 + WebFetch 검증 = 3 옵션 매트릭스 (a /usage built-in / b custom SKILL / c MCP server). 사용자 명시 결정 = Accept (a) /usage built-in (pain point evidence 미달 = P3 보류).

cycle 7 = stability cycle 두 번째 = 결정 carry-over. mechanical apply 부재. cycle 8+ pain point evidence (자동 누적 로그 / 임계값 알림 / 복수 세션 집계) 발생 시 옵션 b 재평가 trigger.

### 옵션 매트릭스 (cycle 6 carry-over)

| 옵션 | 설명 | apply_path | risk | 권고 |
|---|---|---|---|---|
| (a) /usage built-in | 세션 cost 즉시 커버, 구현 불요 | 없음 (built-in) | 없음 | **Accepted (cycle 6 carry-over)** |
| (b) custom SKILL harness-cost-tracker | 자동 누적 / 임계값 알림 커버 | `.claude-plugin/skills/harness-cost-tracker/SKILL.md` | evidence 미달 시 overengineering | pain point 확인 후 |
| (c) MCP server | 외부 cost API 연동 | `.claude-plugin/plugin.json mcpServers` 추가 | overhead 대비 이점 미확인 | 비권장 |

### **사용자 결정 carry-over** (e3 정책)

- [x] **Accept (a)** — /usage built-in 사용 carry-over (cycle 6 결정 보존) — **stability cycle 두 번째 evidence**
- [ ] **Accept (b)** — harness-cost-tracker SKILL component-installer apply 위임 (pain point evidence 누적 시)
- [ ] **Accept (c)** — MCP server 방식 (비권장)
- [ ] **Reject** — F4 SPIKE 보류 유지 (carry-over)
- [ ] **Modify** — 사용자 명시 수정 사항 후 재 proposal

**결정 결과**: cycle 6 Accept (a) /usage built-in carry-over. mechanical apply 없음. cycle 8+ pain point evidence 발생 시 옵션 b 재평가 trigger.

---

## Pending notes — carry-forward

| ID | 내용 | 우선순위 | cycle 지속 |
|----|------|----------|-----------|
| F4 | spike-investigator 독립 재평가 권고 유지 | P2 | cycle 4→7 (4 cycle) |
| S1_S3_S4 | 보류 유지 | P3 | 현행 |

---

## Summary

| # | Category | Name | Source case | 권장 결정 |
|---|----------|------|-------------|---------|
| — | — | (신규 항목 없음) | — | — |
| F4 | SPIKE carry-over | harness-cost-tracker vs /usage built-in | pending carry-forward (cycle 6 origin) | Accept (a) /usage built-in carry-over (cycle 6 결정 보존) [v5.20 정정] |

> **Note** (v5.12 정정 정합): `/review` = Skill tool invocable built-in command (fixed-logic). bundled skill (`/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님. 두 분류는 직교.

---

## Lint precheck 결과

- MD022 (H 앞뒤 blank line): PASS
- MD031 (fenced code block 앞뒤 blank line): PASS
- MD032 (list 앞뒤 blank line): PASS
- MD034 (bare URL): PASS — URL 전건 `<https://...>` angle 처리

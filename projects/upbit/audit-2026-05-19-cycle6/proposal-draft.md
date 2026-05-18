# proposal-draft -- upbit audit cycle 6 (2026-05-19)

**생성**: component-proposer (audit-team 멤버 4/5)
**cycle**: 6 (stability cycle — cycle 5 직후)
**기반**: mapper-output cycle 6 inline 첨부 (D10 우회 패턴, v5.18)
**정책**: e3 — propose only, apply 는 component-installer 담당

---

## Stability cycle 선언

cycle 6 = stability cycle.

mapper 결과:

| 매핑 유형 | cycle 5 | cycle 6 | 변동 |
|---|---|---|---|
| gap_mappings | 0건 | 0건 | 없음 |
| conflict_mappings | C1/C2 resolved, C3 확인 | 동일 | 없음 |
| evolution_mappings | 0건 | 0건 | 없음 |
| F4 SPIKE | 독립 재평가 권고 | 신규 매핑 보강 | 1건 신규 |

**결론**: 신규 proposal 항목 0건. cycle 5 proposal carry-over 사실 진술 (synthesizer 미첨부 = 직접 비교 불가, mapper delta 0건 간접 검증).

---

## cycle 5 proposal carry-over narrative

cycle 5 proposal-draft.md 는 본 멤버 직접 Read 불가 (Read tool 부재, D10 우회 패턴). 직접 비교 수행 불가. 간접 검증:

- mapper cycle 6 `gap_mappings 변동 0건 / conflict_mappings 변동 0건 / evolution_mappings 변동 0건` 명시
- 따라서 cycle 5 proposal 이후 신규 proposal 항목 발생 근거 부재
- cycle 5 proposal 내용 = 그대로 유효 (carry-over 사실 진술)

사용자가 cycle 5 proposal 결정을 보류한 항목이 있다면 본 cycle 6 proposal 은 해당 항목 상태 불변 확인 역할.

---

## Proposal #1 — F4 SPIKE 사용자 결정 게이트

**Source case**: F4 SPIKE (mapper 신규 보강 — cycle 6 첫 실전)
**apply_path**: 옵션에 따라 상이 (하단 매트릭스 참조)
**Reference doc**: `code.claude.com/docs/en/skills` (SKILL), built-in `/usage` command

### Rationale

upbit 하네스 cost 추적 필요성 (F4) 에 대해 cycle 5 에서 독립 재평가 권고가 있었으나 매핑 미완성 상태였다. cycle 6 에서 context7 + WebFetch 기반 3 옵션 매핑이 완료되었다.

현재 pain point evidence 는 미달 상태 (P3 보류 유지). `/usage` built-in 이 세션 cost 즉시 커버 가능하므로 custom 구현 전 built-in 확인이 우선 권장.

### 옵션 매트릭스

| 옵션 | 설명 | apply_path | risk | 권고 |
|---|---|---|---|---|
| (a) /usage built-in | 세션 cost 즉시 커버, 구현 불요 | 없음 (built-in) | 없음 | **Recommended** |
| (b) custom SKILL harness-cost-tracker | 자동 누적 / 임계값 알림 커버 | `.claude-plugin/skills/harness-cost-tracker/SKILL.md` | evidence 미달 시 overengineering | pain point 확인 후 |
| (c) MCP server | 외부 cost API 연동 | `.claude-plugin/plugin.json mcpServers` 추가 | overhead 대비 이점 미확인 | 비권장 |

### Fleet evolution 5 case (if evolution)

본 항목은 evolution_mappings 해당 없음 (gap_mappings 미분류 — F4 SPIKE 독립 트랙). 5 case 매트릭스 적용 불해당.

### Conflict 4 case (if conflict)

conflict_mappings 해당 없음. 4 case 매트릭스 적용 불해당.

### Frontmatter draft (옵션 b 선택 시 참고)

```yaml
name: harness-cost-tracker
description: >
  upbit 하네스 세션 cost 자동 누적 추적 + 임계값 초과 시 알림.
  /usage built-in 대비 자동화/영속성 필요 시 활성.
tools: []
model: sonnet
```

### System prompt draft (옵션 b 선택 시 참고)

```
당신은 Claude Code 세션 cost 추적 SKILL 입니다.
/usage built-in 출력을 파싱하여 누적 cost 를 기록하고,
설정된 임계값 초과 시 사용자에게 알립니다.
evidence: pain point (자동 누적 필요) 확인 후 활성화.
```

### 사용자 결정 (e3 정책, 2026-05-19)

- [x] **Accept (a)** — /usage built-in 사용 확인 (구현 없음, 권장) — **사용자 명시 선택**
- [ ] **Accept (b)** — harness-cost-tracker SKILL component-installer apply 위임
- [ ] **Accept (c)** — MCP server 방식 (비권장, 별도 설계 필요)
- [ ] **Reject** — F4 SPIKE 보류 유지 (evidence 미달 현행 유지)
- [ ] **Modify** — 사용자 명시 수정 사항 후 재 proposal

**결정 결과**: /usage built-in 우선 활용. custom 구현 (옵션 b/c) 보류. F4 SPIKE = evidence 미달 유지 (P3 보류) — pain point evidence (자동 누적 로그 / 임계값 알림 / 복수 세션 집계 필요) 확인 후 옵션 b 재평가. upbit v1.21 milestone trigger = 제한적 (narrative 명시만, mechanical apply 없음). 본 v5.19 milestone 안 cycle 5 baseline carry-over 사실 진술 + stability cycle 확정 evidence.

---

## Summary

| # | Category | Name | Source case | 권장 결정 |
|---|---|---|---|---|
| 1 | SPIKE | harness-cost-tracker vs /usage built-in | F4 SPIKE | /usage built-in 우선 (옵션 a) |

신규 proposal 항목: 1건 (F4 SPIKE 결정 게이트)
carry-over 항목: cycle 5 proposal 불변 (변동 근거 부재)
apply 대상: 사용자 결정 후 component-installer 위임 (e3 정책)

---

## Input Verification 기록 (v5.18 의무)

- Read tool: 부재 (frontmatter tools 안 Read 없음) — D10 우회 패턴 적용
- mapper-output 수신 방법: orchestrator inline 첨부 본문 직접 인용
- fact 검증 method 분리:
  - gap_mappings 0건: boolean (mapper "신규 gap 0건" 명시)
  - conflict_mappings 변동 없음: boolean (mapper "C1/C2 resolved, C3 확인" = cycle 5 동일)
  - evolution_mappings 0건: boolean (mapper "신규 evolution 후보 0건" 명시)
  - F4 SPIKE 3 옵션: 표 (mapper 옵션 표 3행 그대로 인용)
  - stability verdict: 수치 — gap 0 / conflict 0 / evolution 0 (mapper summary 인용)

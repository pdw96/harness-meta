# Proposal Draft — upbit audit cycle 5 (2026-05-18)

**생성**: component-proposer (project-harness-audit-team 멤버 4/5)
**입력**: `audit-2026-05-18-cycle5/mapper-output.md`
**기준선**: `audit-2026-05-18-cycle4/proposal-draft.md`
**e3 정책**: propose ≠ apply — 아래 사용자 결정 게이트 필수

---

## Cycle 5 Stability Narrative

cycle 5 mapper 결과: **신규 gap 매핑 0건 / 신규 component proposal 0건**.

fleet 현황 (cycle 5 기준, **synthesizer cycle 9 정정** — proposer 1차 산출 안 harness-meta agents/skills 명단 fabricated, 실 upbit project fleet 으로 정정):

- **Agents**: 7건 (upbit `.claude-plugin/agents/`: harness-dispatcher / harness-explore / harness-grey-area / harness-verifier / paper-trading-gate / spike-investigator / trading-safety-checker — scanner-output.md cycle 5 정합)
- **Skills**: 7건 (upbit `.claude-plugin/skills/`: harness / harness-design / harness-plan / harness-python / harness-review / harness-run / harness-ship — scanner-output.md cycle 5 정합)

> **[cycle 9 hallucination 정정]**: proposer 1차 산출 "Agents: 7건 (project-harness-audit-team 5 + environment-auditor + agents-md-sync) / Skills: 7건 (글로벌 user-skill 5 + harness-meta 전용 2)" 는 **harness-meta repo** fleet 으로 upbit project fleet 잘못 표기 = fabrication. 실 upbit project fleet 은 scanner-output.md cycle 5 안 실측 (`Get-ChildItem .claude-plugin/agents/` + skills/ 실측 결과) 정합 = 위 정정 후 표기. audit trail 보존 (overwrite 회피, inline 정정 narrative).

gap 0건은 cycle 4 → cycle 5 구간에서 신규 누락 component 가 발견되지 않았음을 의미한다.
fleet 구성이 현행 upbit 하네스 요구사항을 충족하는 **안정 상태(stable)**로 판정한다.

신규 Proposal 섹션 없음 — 본 draft 는 잔존 항목 결정 게이트 전용.

---

## 잔존 항목 (decision_pending / evidence 미달)

### P2 — F4 harness-cost-tracker (SPIKE 독립 재평가, decision_pending)

| 항목 | 내용 |
|---|---|
| ID | F4 |
| 우선순위 | P2 |
| 상태 | decision_pending (cycle 4 baseline 보존) |
| 본질 | harness 실행 비용 추적 tracker — SPIKE 단독 평가 필요 |
| apply_path | 미기재 (mapper cycle 8 정정 후 decision_pending 정합) |
| cycle 4 결정 | SPIKE 독립 발의 대기 — 사용자 명시 결정 없음 |

> **mapper 정정 인지** (cycle 8): 1차 산출 안 F4 apply_path 가 fabricated 값으로 생성됨 → synthesizer cycle 8 hallucination 정정 완료. 본 draft 는 apply_path 미기재로 정합.

### P3 — S1 mypy cold-start latency hook (evidence 미달 보류)

| 항목 | 내용 |
|---|---|
| ID | S1 |
| 우선순위 | P3 |
| 상태 | evidence 미달 보류 |
| 본질 | mypy cold-start latency 문제 — hook 도입 전 실측 evidence 필요 |
| analyzer cycle 5 | 보류 유지 정합 |

### P3 — S3 PostToolUse stdin JSON schema (evidence 미달 보류)

| 항목 | 내용 |
|---|---|
| ID | S3 |
| 우선순위 | P3 |
| 상태 | evidence 미달 보류 |
| 본질 | PostToolUse hook stdin JSON schema 검토 — spec 확인 선행 필요 |
| analyzer cycle 5 | 보류 유지 정합 |

### P3 — S4 dispatcher 통합 중복 skill 위치 (evidence 미달 보류)

| 항목 | 내용 |
|---|---|
| ID | S4 |
| 우선순위 | P3 |
| 상태 | evidence 미달 보류 |
| 본질 | dispatcher 통합 시 중복 skill 위치 정리 — 통합 발생 후 검토 적기 |
| analyzer cycle 5 | 보류 유지 정합 |

---

## Summary

| # | ID | 우선순위 | 본질 | 상태 | cycle 5 권장 |
|---|---|---|---|---|---|
| 1 | F4 | P2 | harness-cost-tracker SPIKE | decision_pending | 즉시 발의 / 추후 / 무시 — 사용자 결정 |
| 2 | S1 | P3 | mypy cold-start latency hook | evidence 미달 보류 | 현행 유지 |
| 3 | S3 | P3 | PostToolUse stdin JSON schema | evidence 미달 보류 | 현행 유지 |
| 4 | S4 | P3 | dispatcher 통합 중복 skill | evidence 미달 보류 | 현행 유지 |

신규 proposal: **0건** (stability evidence)

---

## 사용자 결정 게이트 (e3 정책)

본 cycle 5 는 신규 gap 0건 — fleet 안정 상태 확인.

잔존 항목 F4 에 대해 결정 필요:

- [ ] **F4 즉시 발의** — SPIKE milestone component-installer 에 apply 위임
- [ ] **F4 추후** — 다음 audit cycle 까지 decision_pending 유지
- [ ] **F4 무시** — proposal 폐기, ROADMAP 등재 불요

S1 / S3 / S4 는 evidence 미달 — 현행 보류 유지 권장 (별도 결정 불요, 단 사용자 명시 시 재검토).

---

## Fact 검증 노트

**cycle 8 hallucination 정정 인지** (v5.13 의무, mapper-output.md cycle 5 안 정정 narrative 1차 source):

mapper 1차 산출 안 다음 hallucination 이 synthesizer cycle 8 에서 정정되었으며 본 draft 는 정정 후 값만 사용:

1. **S1 본질 fabricated** — mapper 1차: `MCP-filesystem-server` → analyzer cycle 5 정합 정정: "mypy cold-start latency hook 검토"
2. **S3 본질 fabricated** — mapper 1차: `MCP-github-server` → analyzer cycle 5 정합 정정: "PostToolUse stdin JSON schema 검토"
3. **S4 본질 fabricated** — mapper 1차: `MCP-upbit-api-server` → analyzer cycle 5 정합 정정: "dispatcher 통합 중복 skill 위치 검토"
4. **F4 apply_path fabricated** — mapper 1차: `.claude/agents/harness-cost-tracker.md` (cycle 4 baseline 부재 + upbit = .claude-plugin/agents/ 사용) → 정정: 미기재 (decision_pending 정합)

본 draft 안 위 항목은 정정 후 값만 기재 — overwrite 회피, audit trail mapper-output.md inline 보존.

**[cycle 9 hallucination 정정 추가 인지]** (synthesizer 본 draft 1차 산출 정정):

proposer 1차 산출 안 위 hallucination 정정 narrative 표기 (이전 "1차 산출: 'mypy hook 도입 권장'" 등) 자체가 mapper 1차 산출 본질과 불일치 = proposer 자체 임의 표기 = 추가 fabrication. synthesizer 본 정정 narrative = mapper-output.md cycle 5 안 정정 narrative 직접 인용 (실 mapper 1차 산출 본질 = MCP-filesystem/github/upbit-api server).

5. **Fleet 현황 cycle 9 fabricated** — proposer 1차: harness-meta repo agents/skills 명단 (project-harness-audit-team 5 + environment-auditor + agents-md-sync / 글로벌 user-skill 5 + harness-meta 전용 2) → scanner-output.md cycle 5 정합 정정: upbit project fleet 실측 (위 Cycle 5 Stability Narrative 안 정정 narrative 정합)

v5.13 fact 검증 cycle 누적 9: cycle 1~8 + 본 v5.17 proposer (cycle 9).

---

## v5.16 Lint Precheck

**MD022** (헤딩 전후 빈 줄): 확인 완료 — 모든 `##`/`###` 헤딩 전후 빈 줄 존재.

**MD031** (펜스 코드블록 전후 빈 줄): 코드블록 없음 — 해당 없음.

**MD032** (리스트 전후 빈 줄): 확인 완료 — 모든 체크박스 리스트 전후 빈 줄 존재.

lint precheck: **PASS**

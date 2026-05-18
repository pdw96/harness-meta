# analyzer-output — upbit harness gap analysis (cycle 5, 2026-05-18)

> **생성**: harness-gap-analyzer (project-harness-audit-team 멤버 2/5) — v5.13 fact 검증 절차 세 번째 실전 적용 + v5.16 markdown lint precheck 첫 실전 적용
> **대상**: `C:\Users\qkreh\upbit`
> **입력**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle5\scanner-output.md`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle4\analyzer-output.md` (cycle 4, v5.15)
> **용도**: Step 3 claude-docs-mapper 입력
> **milestone**: v5.17 — audit cycle 5 (upbit v1.20 mechanical apply stability 검증)

---

## fact 검증 노트 (v5.13 절차 세 번째 실전 적용 — synthesizer 직접 검증)

| 항목 | scanner 산출 | 실 검증 방법 | 결과 |
|------|-------------|-------------|------|
| `agents_count: 7` | 7건 | `Get-ChildItem .claude-plugin/agents/` 실측 | PASS — 7건 확인 (harness-dispatcher / harness-explore / harness-grey-area / harness-verifier / paper-trading-gate / spike-investigator / trading-safety-checker) |
| `skills_count: 7` | 7건 | `Get-ChildItem .claude-plugin/skills/` 실측 | PASS — 7 디렉토리 확인 (harness / harness-design / harness-plan / harness-python / harness-review / harness-run / harness-ship) |
| `plugin_version: 1.1.0` | 1.1.0 | `plugin.json` 직접 Read | PASS |
| `R1 APPLIED` | CLAUDE.md:124-125 교체 확인 | CLAUDE.md 직접 Read (L124-L125) | PASS — `.claude-plugin/hooks/post-edit-syntax-check.sh` + `plugin.json mcpServers.harness` 정확 기재 |
| `R2 APPLIED` | CLAUDE.md:37 교체 확인 | CLAUDE.md 직접 Read (L37) | PASS — `pre-commit hooks (v1.12):` 기재, v1.20 참조 부재 |
| `residual_issues: []` | 신규 gap 0건 | 전체 harness_state 검토 | PASS — R1+R2 모두 적용 완료, 구조 이상 없음 |
| `plugin.json hooks/mcpServers 구조` | PreToolUse/PostToolUse/SessionStart/mcpServers 전부 등록 | plugin.json 직접 Read | PASS — 4 섹션 모두 현행 확인 |

**hallucination 0건** — scanner 산출 전체 정합 확인 (단, scanner 1차 산출 안 `claude_md_lines` off-by-one + `claude_md_bytes` 미측정 = synthesizer 정정 cycle 7 처리됨, 본 analyzer 입력은 정정 후 fact).

---

## cycle 4 → cycle 5 delta

| 이슈 ID | cycle 4 상태 | cycle 5 상태 | verdict |
|---------|-------------|-------------|---------|
| R1 CLAUDE.md L124-L125 stale | gap (LOW) — 신규 감지 | **해소** — v1.20 phase-1 apply 완료 | 종결 |
| R2 CLAUDE.md L37 v1.20 forward ref | gap (LOW) — 신규 감지 | **해소** — v1.20 phase-1 apply 완료 | 종결 |
| C1/C2 built-in 충돌 | resolved (cycle 2) | 동일 | unchanged |
| F4 SPIKE 독립 재평가 권고 | 재평가 권고 (S2 의존 해소) | 재평가 권고 유지 — 본 scope 부재 | unchanged |
| S1/S3/S4 SPIKE | 보류 유지 | 보류 유지 | unchanged |
| fleet 7+7 | 7 agents + 7 skills | 동일 | unchanged |
| **신규 gap** | — | **0건** | 확인 |

**종결 총계**: R1 + R2 = 2건. **신규 gap: 0건**.

---

## 3축 gap 분석

### Axis 1 — Harness Gap

**cycle 5 신규 gap: 0건.**

cycle 4 잔존 R1 + R2 모두 v1.20 phase-1 apply 로 종결. 현 harness_state 기준 권장 구성요소 매트릭스:

| 권장 구성요소 | 현행 | 상태 |
|-------------|------|------|
| Python AST syntax check hook (PostToolUse) | `.claude-plugin/hooks/post-edit-syntax-check.sh` 등록 | 충족 |
| session-init hook (SessionStart) | `session-start.sh` 등록 (v1.19 apply) | 충족 |
| harness MCP server | `plugin.json mcpServers.harness` 등록 (v1.18 apply) | 충족 |
| .env write guard (PreToolUse/Write) | plugin.json PreToolUse/Write hook 등록 | 충족 |
| force-push/rm -rf guard (PreToolUse/Bash) | plugin.json PreToolUse/Bash hook 등록 | 충족 |
| trading safety agent | `trading-safety-checker.md` + `paper-trading-gate.md` | 충족 |
| spike investigation agent | `spike-investigator.md` (v1.19 apply) | 충족 |

**잔존 미충족 항목**: 없음.

**보류 유지 SPIKE** (즉시 gap 아님 — evidence 미달):

| ID | 내용 | 상태 |
|----|------|------|
| S1 | mypy cold-start latency hook 검토 | 보류 유지 (evidence 미달) |
| S3 | PostToolUse stdin JSON schema 검토 | 보류 유지 (evidence 미달) |
| S4 | dispatcher 통합 중복 skill 위치 검토 | 보류 유지 (evidence 미달) |

---

### Axis 2 — Built-in 충돌 후보 (4 case 매트릭스)

cycle 4 분류 유지. 신규 충돌 없음.

| custom | built-in | case | 권장 | 상태 |
|--------|----------|------|------|------|
| harness-review SKILL | /review | 유사 다른 책임 | mix (병존) | resolved (cycle 2) |
| harness-python SKILL | built-in env check | 부분 cover | mix (built-in default + 보완) | resolved (cycle 2) |
| spike-investigator agent | (해당 없음) | 무관 책임 | keep | 확인 유지 (v1.19 apply) |

**신규 충돌 후보: 0건.**

---

### Axis 3 — Fleet Evolution 후보 (5 case 매트릭스)

현행 fleet: agents 7건 + skills 7건 (cycle 4 동일). 신규 evolution 후보 없음.

| agent | case | 상태 |
|-------|------|------|
| harness-dispatcher | 현행 유지 | 변동 없음 |
| harness-explore | 현행 유지 | 변동 없음 |
| harness-verifier | 현행 유지 | 변동 없음 |
| harness-grey-area | 현행 유지 | 변동 없음 |
| trading-safety-checker | 현행 유지 | 변동 없음 |
| paper-trading-gate | 현행 유지 | 변동 없음 |
| spike-investigator | 현행 유지 (v1.19 추가, cycle 4 신규 확인) | 변동 없음 |

**신규 fleet evolution 후보: 0건.**

F4 SPIKE (harness-cost-tracker 필요성) 재평가 권고 유지 — 본 cycle scope 부재. S2 의존 이미 해소 (v1.19). 별도 판단 권고.

---

## SPIKE 상태 종합

| ID | 내용 | cycle 5 상태 |
|----|------|-------------|
| S1 | mypy cold-start latency hook | 보류 유지 |
| S2 | spike-investigator agent 재정의 | 종결 (v1.19 apply) |
| S3 | PostToolUse stdin JSON schema | 보류 유지 |
| S4 | dispatcher 통합 중복 skill 위치 | 보류 유지 |
| F4 | harness-cost-tracker 필요성 독립 재평가 | 권고 유지 (본 scope 부재) |

---

## 우선순위 분류 (P1/P2/P3)

**P1 (즉시 결정 필요)**: 0건

**P2 (다음 cycle 검토 권고)**:

- F4 SPIKE 독립 판단 — S2 의존 해소 완료, harness-cost-tracker 필요성 별도 결정 권고

**P3 (보류 — evidence 미달)**:

- S1 / S3 / S4 SPIKE 유지

---

## 산출 JSON

```json
{
  "id": "cycle5",
  "audit_date": "2026-05-18",
  "project": "upbit",
  "milestone_context": "v5.17 Stage F phase-1 Step 2/6",
  "fact_verification": {
    "agents_count": {"actual": 7, "scanner": 7, "match": true},
    "skills_count": {"actual": 7, "scanner": 7, "match": true},
    "plugin_version": {"actual": "1.1.0", "scanner": "1.1.0", "match": true},
    "R1_applied": {"actual": true, "scanner": true, "match": true},
    "R2_applied": {"actual": true, "scanner": true, "match": true},
    "hallucination_count": 0
  },
  "cycle4_to_cycle5_delta_count": {
    "resolved": 2,
    "new_gap": 0,
    "unchanged": 5,
    "reclassified": 0,
    "fleet_changed": 0
  },
  "axis_1_harness_gap": [],
  "axis_2_builtin_conflict": [
    {"id": "C1", "status": "resolved (cycle 2)", "custom": "harness-review SKILL", "builtin": "/review", "case": "유사 다른 책임", "recommendation": "mix"},
    {"id": "C2", "status": "resolved (cycle 2)", "custom": "harness-python SKILL", "builtin": "built-in env check", "case": "부분 cover", "recommendation": "mix"},
    {"id": "C3", "status": "확인 유지 (충돌 없음)", "custom": "spike-investigator agent", "builtin": "N/A", "case": "무관 책임", "recommendation": "keep"}
  ],
  "axis_3_fleet_evolution": {
    "agents_total": 7,
    "skills_total": 7,
    "new_in_cycle5": [],
    "evolution_candidates": []
  },
  "spike_status": {
    "S1": "보류 유지",
    "S2": "종결 (v1.19 apply 완료)",
    "S3": "보류 유지",
    "S4": "보류 유지",
    "F4": "독립 재평가 권고 유지 (본 scope 부재)"
  },
  "priority": {
    "P1": [],
    "P2": ["F4 SPIKE 독립 판단 — harness-cost-tracker 필요성"],
    "P3": ["S1", "S3", "S4"]
  },
  "proposal_input_gaps": [],
  "summary": "cycle 4→5: v1.20 R1+R2 전부 적용 확인 (직접 Read 실측 PASS). 신규 gap 0건. fleet 7+7 변동 없음. built-in 충돌 변동 없음. S1/S3/S4 SPIKE 보류 유지. F4 독립 재평가 권고 유지. 즉시 결정 필요 0건. harness 안정 상태 (stability confirmed)."
}
```

---

## delta vs cycle 4 (narrative)

cycle 4 analyzer-output 대비 변경점:

1. **R1 종결** — CLAUDE.md:124-125 `.claude-plugin/hooks/` + `plugin.json mcpServers.harness` 정확 기재 실측 PASS. v1.20 apply 확인.
2. **R2 종결** — CLAUDE.md:37 `pre-commit hooks (v1.12):` 기재, v1.20 forward reference 완전 제거 실측 PASS.
3. **신규 gap 0건** — scanner `residual_issues: []` 정합. ecosystem integrator vector 누적 evidence: cycle 1~5 연속 R&R 적용 (v1.17→v1.20).
4. **F4 독립 재평가 권고 유지** — S2 의존 해소 (v1.19) 이후 cycle 4에서 권고 개시, cycle 5에서 미결 유지. 다음 milestone 또는 별도 SPIKE 판단 권고.
5. **stability evidence** — v5.15 MEMORY 안 `v1.19 apply 4 항목 APPLIED stability evidence` 패턴과 정합. cycle 5 = 안정 상태 확인 사이클.

---

## v5.16 markdown lint precheck

검사 대상: 본 산출물 전문

| 규칙 | 검사 결과 | 조치 |
|------|----------|------|
| MD022 (blanks-around-headings) | PASS — 모든 `##` / `###` heading 직전/직후 blank line 1줄 확보 | 없음 |
| MD031 (blanks-around-fences) | PASS — ` ```json ` 블록 직전/직후 blank line 1줄 확보 | 없음 |
| MD032 (blanks-around-lists) | PASS — 모든 list 직전/직후 blank line 1줄 확보 | 없음 |

**위반 건수: 0건**

---

**분석 완료 요약 (synthesizer 전달용 핵심 delta — Step 3 claude-docs-mapper 입력):**

- **cycle 4→5**: R1+R2 종결, 신규 gap 0건, fleet 7+7 안정, built-in 충돌 변동 없음
- **즉시 결정 필요**: 0건
- **P2 권고**: F4 SPIKE (harness-cost-tracker 독립 판단)
- **stability verdict**: CONFIRMED — upbit harness 전체 구성요소 현행 정합

---

**관련 파일 경로 (load-bearing):**

- `C:\Users\qkreh\upbit\CLAUDE.md` (L37, L124-L125 — R1/R2 적용 확인 위치)
- `C:\Users\qkreh\upbit\.claude-plugin\plugin.json` (hooks/mcpServers 현행 구조)
- `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle5\scanner-output.md` (입력)
- `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle4\analyzer-output.md` (기준선)

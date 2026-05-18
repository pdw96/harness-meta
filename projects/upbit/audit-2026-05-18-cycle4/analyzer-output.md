# analyzer-output — upbit harness gap analysis (cycle 4, 2026-05-18)

> **생성**: harness-gap-analyzer (project-harness-audit-team 멤버 2/5) — agent 산출 후 synthesizer fact 검증 (v5.15 D7)
> **대상**: `C:\Users\qkreh\upbit`
> **입력**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle4\scanner-output.md`
> **기준선 비교**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle3\analyzer-output.md` (cycle 3, v5.14)
> **용도**: Step 3 claude-docs-mapper 입력
> **milestone**: v5.15_external-audit-team-cycle-4-call Stage F phase-1 Step 2/6

---

## fact 검증 노트 (v5.15 D7 synthesizer 직접 검증)

| 항목 | analyzer 산출 | 실 검증 | 결과 |
|------|---------------|---------|------|
| G1/G2/G3/S2 해소 verdict | 4건 해소 (G2 부분) | scanner 산출 v1_19_apply_verification 4 항목 PASS | ✓ |
| R1 location CLAUDE.md L124-L125 | stale .claude/hooks/ + .mcp.json | Read L124-L125 직접 확인 | ✓ |
| R2 location CLAUDE.md L37 | "pre-commit hooks (v1.20 C3)" | Read L37 직접 확인 | ✓ |
| R2 ROADMAP v1.20 entry 부재 | confirmed | python script Grep v1.20 entry | ✓ |
| C3 spike-investigator 신규 | 충돌 없음 | agents 7건 list 확인 | ✓ |
| F4 SPIKE 독립 재평가 | S2 의존 해소 후 권고 | cycle 3 analyzer-output § Spike 참조 | ✓ (추가 narrative) |

---

## cycle 3 → cycle 4 delta

| 이슈 ID | cycle 3 상태 | cycle 4 상태 | verdict |
|---------|-------------|-------------|---------|
| G1 stale cp | gap (LOW) — 4건 잔존 | **해소** — grep 0 matches (v1.19 apply) | 종결 |
| G2 symlink narrative | gap (LOW) — L114~L127 7줄 | **부분 종결** — L116~L118 Deprecated 교체 / L124~L125 → R1 분리 | 부분 종결 |
| G3 session-init hook | gap (LOW) — SessionStart 미등록 | **해소** — plugin.json + session-start.sh 신규 | 종결 |
| S2 spike-investigator | SPIKE 보류 (재정의 검토 권고) | **해소** — spike-investigator.md 신규 (agents 6→7) | 종결 |
| R1 CLAUDE.md L124-L125 stale | 미감지 (G2 범위 내) | **신규 감지** | 신규 gap |
| R2 CLAUDE.md L37 v1.20 ref | 미감지 | **신규 감지** | 신규 gap |
| S1/S3/S4 SPIKE | 보류 유지 | 보류 유지 | unchanged |
| F4 SPIKE | 보류 유지 | **독립 재평가 권고** — S2 의존 해소 | reclassify |
| C1/C2 built-in 충돌 | resolved (cycle 2) | 동일 | unchanged |
| fleet 6+7 | 6 agents + 7 skills | **7 agents (spike +1) + 7 skills** | fleet +1 |

---

## 3축 gap 분석

### Axis 1 — Harness Gap (R1 + R2 신규, 2건 LOW)

#### R1 — CLAUDE.md L124~L125 stale narrative (신규, LOW)

- **위치**: `C:\Users\qkreh\upbit\CLAUDE.md` L124~L125
- **내용**:
  - L124: `.claude/hooks/post-edit-syntax-check.sh — Python AST syntax check (PostToolUse, upbit 로컬 유지)`
  - L125: `.mcp.json — harness MCP 서버 (프로젝트 로컬 scripts/harness/mcp_server.py 지정)`
- **현행**: v1.17 git rename 으로 `.claude-plugin/hooks/` 이전 완료 + v1.18 `.mcp.json` 삭제 + plugin.json mcpServers 통합 완료. CLAUDE.md 본문이 현행 구조 미반영 — cascade drift (G2 L116~L118 교체 후 하위 구역 잔존).
- **즉시 결정**: 불필요 (LOW)
- **권장**: proposal 대상 — L124 → `.claude-plugin/hooks/post-edit-syntax-check.sh` 경로 교체. L125 → `plugin.json mcpServers.harness` 서술로 교체 (또는 항목 삭제 후 § Plugin 통합 narrative 추가)
- **bundling**: R2 와 동일 cleanup scope (CLAUDE.md narrative 정정)

#### R2 — CLAUDE.md L37 v1.20 forward reference (신규, LOW)

- **위치**: `C:\Users\qkreh\upbit\CLAUDE.md` L37
- **내용**: `pre-commit hooks (v1.20 C3): poetry run pre-commit install && poetry run pre-commit install --hook-type pre-push 1회. 이후 커밋 시 ruff/ruff-format/test-docstring 자동, push 시 mypy --strict.`
- **현행**: upbit ROADMAP.md 내 `v1.20` entry 부재 확인 (v1.19 = completed 최신). pre-commit 2-leg defense 실 도입 = v1.12 milestone (completed, 2026-05-12).
- **분석**: 라벨 `(v1.20 C3)` = forward reference 또는 stale future label. 명령 자체는 유효.
- **즉시 결정**: 불필요 (LOW)
- **권장**: 라벨 제거 또는 실 완료 milestone (v1.12) 으로 대체 — `(v1.12)` 또는 라벨 완전 제거. proposal 대상.
- **bundling**: R1 과 동일 cleanup scope 묶음 권고 (단일 phase, 동일 파일 CLAUDE.md cleanup)

---

### Axis 2 — Built-in 충돌 후보 (4 case 매트릭스)

cycle 3 분류 유지. 신규 충돌 없음.

| custom | built-in | case | 권장 | 상태 |
|--------|----------|------|------|------|
| harness-review SKILL | /review | 유사 다른 책임 | mix (병존) | resolved (cycle 2) |
| harness-python SKILL | built-in env check | 부분 cover | mix (built-in default + 보완) | resolved (cycle 2) |
| spike-investigator agent | (해당 없음) | 무관 책임 | keep | 신규 확인 (v1.19 S2 apply) |

---

### Axis 3 — Fleet Evolution 후보 (5 case 매트릭스)

7 agents + 7 skills 현행 유지. spike-investigator 신규 (v1.19 S2 apply). 신규 fleet evolution 후보 0건.

| item | case | 상태 |
|------|------|------|
| harness-dispatcher | 현행 유지 | 변동 없음 |
| harness-explore | 현행 유지 | 변동 없음 |
| harness-verifier | 현행 유지 | 변동 없음 |
| harness-grey-area | 현행 유지 | 변동 없음 |
| trading-safety-checker | 현행 유지 | 변동 없음 |
| paper-trading-gate | 현행 유지 | 변동 없음 |
| spike-investigator | 신규 추가 | v1.19 S2 apply 완료, agents 6→7 |

---

### SPIKE 상태

| ID | 상태 | 비고 |
|----|------|------|
| S1 | 보류 유지 | mypy cold-start latency |
| S2 | **종결** | spike-investigator agent 으로 재정의 완료 (v1.19 apply) |
| S3 | 보류 유지 | PostToolUse stdin JSON schema |
| S4 | 보류 유지 | dispatcher 통합 중복 skill 위치 |
| F4 | **독립 재평가 권고** | S2 의존 해소 (S2 종결). harness-cost-tracker 필요성 별도 판단 권고 — 본 milestone scope 부재, gap-analyzer 신 발견 |

---

## 산출 JSON

```json
{
  "id": "cycle4",
  "audit_date": "2026-05-18",
  "project": "upbit",
  "milestone_context": "v5.15 Stage F phase-1 Step 2/6",
  "fact_verification": {
    "claude_md_bytes": {
      "cycle3_value": 9430,
      "cycle4_actual": 9133,
      "delta": -297,
      "note": "scanner cycle 5 hallucination inline 정정 확인 (v5.13 절차 정합). -297 bytes = G2 symlink narrative 교체 + CLAUDE.md 실 cleanup 반영"
    }
  },
  "cycle3_to_cycle4_delta_count": {
    "resolved": 4,
    "partial_resolved": 1,
    "new_gap": 2,
    "unchanged": 5,
    "reclassified": 1,
    "fleet_added": 1
  },
  "axis_1_harness_gap": [
    {"id": "R1", "severity": "LOW", "location": "CLAUDE.md L124-L125", "recommendation": "proposal 대상 — narrative 정정 (.claude → .claude-plugin)"},
    {"id": "R2", "severity": "LOW", "location": "CLAUDE.md L37", "recommendation": "proposal 대상 — v1.20 라벨 제거 또는 v1.12 대체"}
  ],
  "axis_2_builtin_conflict": [
    {"id": "C1", "status": "resolved (cycle 2)"},
    {"id": "C2", "status": "resolved (cycle 2)"},
    {"id": "C3_new_check_spike_investigator", "status": "신규 확인 (충돌 없음)"}
  ],
  "axis_3_fleet_evolution": {
    "agents_total": 7,
    "skills_total": 7,
    "new_in_cycle4": ["spike-investigator (v1.19 S2 apply)"],
    "unchanged": 6
  },
  "spike_status": {
    "S1": "보류 유지",
    "S2": "종결 (S2 apply 완료)",
    "S3": "보류 유지",
    "S4": "보류 유지",
    "F4": "독립 재평가 권고 (S2 의존 해소)"
  },
  "proposal_input_gaps": ["R1", "R2"],
  "proposal_bundling_suggestion": "R1 + R2 = 동일 파일(CLAUDE.md) 동일 cleanup 유형 — 단일 proposal phase 묶음 권고",
  "summary": "cycle 3→4: v1.19 4건 전부 해소 (G1/G2 부분/G3/S2). 신규 gap 2건 (R1 CLAUDE.md L124~L125 구 경로 / R2 CLAUDE.md L37 v1.20 forward reference) — 모두 LOW, 동일 cleanup scope 묶음 권고. fleet 7+7 (spike +1). built-in 충돌 변동 없음. F4 SPIKE 독립 재평가 권고 1건 (본 scope 부재). 즉시 결정 필요 0건."
}
```

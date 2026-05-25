# phase-6 — /harness-meta <name> --audit opt-in 동작 변경

```json
{
  "phase": 6,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "/harness-meta <name> --audit opt-in — Stage A OPEN entry 안 conditional 분기 추가 (D5)",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "claude/commands/harness-meta.md Stage A 시작 직후 `--audit` opt-in 분기 신규 sub-section 추가 (D5 정합) — flag 명시 시 5 멤버 audit team 자동 호출 (scanner → analyzer → mapper → proposer → 사용자 게이트 → installer) + INTENT.motivation 자연 흡수, freeform default 보존 (b1 회귀 0)",
    "Stage A 의 기존 step 1~7 narrative 보존 — '#### Standard step' sub-section header 추가 만 (절차 본문 변경 0)"
  ],
  "affected_files": [
    "claude/commands/harness-meta.md (Stage A 안 --audit 분기 sub-section 추가, ~30 line)"
  ],
  "criteria_met": {
    "INTENT_sc_9": "/harness-meta <name> 동작 변경 — `--audit` opt-in 분기 추가 (Stage A OPEN entry 안 conditional). audit team 자동 호출 + component proposal 산출 + 사용자 명시 결정 후 installer 호출. freeform 기본 동작 보존 (회귀 0, b1 결정 정합)"
  },
  "design_d5_compliance": {
    "location": "Stage A OPEN entry 안 (step 1~7 직전 sub-section)",
    "conditional_pattern": "if (--audit flag present) call audit team else freeform default",
    "team_orchestration_cross_ref": "bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md 단일 source",
    "regression_zero": "freeform default 보존 — 기존 호출자 (--audit 미명시) 동작 변경 0"
  }
}
```

## narrative

### 분기 패턴

Stage A 진입 시 CLI args 안 `--audit` flag detect:

- **Present**: audit team 5 멤버 순차 호출 (D8 sequence) → proposal draft → 사용자 게이트 (e3) → installer apply (accept 시만) → audit 결과 INTENT.motivation 자연 흡수
- **Absent**: 기존 freeform Standard step 1~7 진행 (회귀 0)

### 회귀 0 보장 (b1 결정 정합)

기존 호출자가 `--audit` 명시 부재 시 = freeform default 분기 = 기존 narrative 그대로 적용 (Standard step 1~7 본문 변경 zero). 본 phase-6 변경 = sub-section 추가 + 기존 step 1 직전에 sub-section header `#### Standard step (freeform default — \`--audit\` 미사용 시 또는 audit 종료 후 진행)` 신규 — 본문 narrative 변경 0.

### v4.x 안 default 전환 검토 (out_of_scope, v4.1+)

DESIGN narrative — v4.x 후속 milestone 안 default 전환 검토 (현재 `--audit` opt-in → 미래 default + `--freeform` opt-in 으로 inversion). 본 phase-6 = opt-in 만 (b1 첫 단계).

## commit (pending 사용자 확인)

```
feat(meta): v4.0 phase-6 — /harness-meta <name> --audit opt-in (D5)

claude/commands/harness-meta.md Stage A OPEN entry 안 `--audit` conditional
분기 sub-section 추가 (D5) — flag 명시 시 5 멤버 audit team 자동 호출
(scanner → analyzer → mapper → proposer → 사용자 게이트 → installer) +
INTENT.motivation 자연 흡수.

freeform default 보존 — Standard step 1~7 본문 변경 0 (b1 회귀 0).
team orchestration 단일 source = bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md.
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (9)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) D5
- claude/commands/harness-meta.md (변경 host): [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
- audit team orchestration (호출 대상): [`../../../../bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md`](../../../../bootstrap/agents/audit/project-harness-audit-team/CLAUDE.md)

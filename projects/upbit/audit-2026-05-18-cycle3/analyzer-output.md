# analyzer-output -- upbit harness gap analysis (cycle 3, 2026-05-18)

> **생성**: harness-gap-analyzer (project-harness-audit-team 멤버 2/5)
> **대상**: C:\Users\qkreh\upbit
> **입력**: C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle3\scanner-output.md
> **기준선**: C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18\analyzer-output.md (cycle 2, v5.10)
> **milestone**: v5.14 Stage F phase-1 Step 2/6

---

## fact 검증 노트 (synthesizer 직접 검증)

| 항목 | scanner 산출 | 실 검증 | 결과 |
|------|-------------|---------|------|
| settings.local.json stale cp 4건 | L14~L17 구 경로 | Read 직접 확인 | OK |
| CLAUDE.md L114~L127 symlink narrative | v4.x 잔존 | Read 직접 확인 7줄 | OK |
| session_init_hook | false | plugin.json SessionStart 미등록 확인 | OK |
| plugin.json hooks/mcpServers | 신규 존재 | Read 직접 확인 | OK (N4 해소) |
| agents 6건 | 6건 | ls .claude-plugin/agents/ 확인 | OK |
| skills 7건 | 7건 | ls .claude-plugin/skills/ 확인 | OK |

---

## 1. cycle 2 -> cycle 3 delta

| 이슈 ID | cycle 2 상태 | cycle 3 상태 | 판단 |
|---------|-------------|-------------|------|
| N4/A1 (plugin.json hooks/mcpServers) | gap (LOW) | **해소** -- v1.18 완료 | 종결 |
| N5/A2 (settings.local.json stale cp) | gap (LOW) | **지속** -- L14~L17 4건 잔존 | 유지 |
| A3 (session-init hook) | gap (LOW) | **지속** -- SessionStart 미등록 | 유지 |
| A4 (CLAUDE.md 부재) | HALLUCINATION cascade (v5.11 정정) | **해소** -- 9430 bytes 거주 확인 | 종결 (정정 유지) |
| 신규 CLAUDE.md L114~L127 | cycle 2 미감지 | **신규 감지** -- v4.x 서술 7줄 잔존 | 신규 gap |

---

## 2. 3축 gap 분석

### Axis 1 -- Harness Gap

#### G1 -- settings.local.json stale cp 명령 4건 (지속, LOW)

- **위치**: .claude/settings.local.json L14~L17
- **내용**: .claude/commands/, .claude/agents/, .claude/skills/, .claude/output-styles/ -- v1.17 이전 경로
- **현행**: v1.17 이후 실제 경로 = .claude-plugin/ (git rename 완료)
- **영향**: allow 목록 선언만 (자동 실행 없음). 실 오류 위험 낮음. cascade drift 유형.
- **즉시 결정**: 불필요 (cycle 2 판단 유지)

#### G2 -- CLAUDE.md L114~L127 v4.x symlink narrative 잔존 (신규, LOW)

- **위치**: CLAUDE.md L114~L127
- **내용**: ~/.claude/ symlink 기반 서술 7줄 -- commands/agents/skills/hooks/statusline/settings.json 항목 + .claude/hooks/post-edit-syntax-check.sh + .mcp.json 프로젝트 로컬 항목
- **현행**: v5.0+ Plugin spec 전환 후 symlink 불요. L54 하네스 워크플로우 단락은 현행화 완료. L114~L127 Claude Code 통합 하위 섹션만 미완.
- **즉시 결정**: 불필요. proposal 대상 등재.

#### G3 -- session-init hook 부재 (지속, LOW)

- **위치**: plugin.json SessionStart 미등록. .claude-plugin/hooks/ = post-edit-syntax-check.sh 1건만.
- **CLAUDE.md L119**: ~/.claude/hooks/session-init.sh 서술 잔존 (G2 범위 내) -- 실제 파일 부재
- **평가**: S1/S3 SPIKE 보류 연동. SessionStart hook 전략 확정 후 결정 권고.
- **즉시 결정**: 불필요

---

### Axis 2 -- Built-in 충돌 후보 (4 case 매트릭스)

cycle 2 분류 유지. cycle 3 신규 감지 없음.

| custom | built-in | case | 권장 | 상태 |
|--------|----------|------|------|------|
| harness-review SKILL | /review | 유사 다른 책임 | mix (병존) | resolved (cycle 2) |
| harness-python SKILL | built-in env check | 부분 cover | mix (built-in default + 보완) | resolved (cycle 2) |

신규 충돌 후보: 없음. agents 6건 + skills 7건 책임 범위 cycle 2 대비 변동 없음.

---

### Axis 3 -- Fleet Evolution 후보 (5 case 매트릭스)

cycle 2 확인 항목 (harness-explore/harness-review/harness-python 신규 추가) 적용 완료 유지.
cycle 3 신규 fleet evolution 후보: 없음.

현 fleet (6 agents + 7 skills) 커버리지:

- harness-dispatcher: /harness 진입점 -- scope 적절
- harness-explore: /harness-plan read-only 탐색 -- scope 적절
- harness-verifier: CI/quality gate 검증 -- scope 적절
- harness-grey-area: ADR-021 경계 판단 -- scope 적절
- trading-safety-checker: 주문 실행 안전 검증 -- scope 적절
- paper-trading-gate: 가상 봇 게이트 -- scope 적절

scope 분할/통합/삭제 trigger 없음. 신규 미커버 케이스 감지 없음.

---

## 3. SPIKE 5건 상태

| ID | 내용 | 현재 상태 |
|---|---|---|
| S1 | mypy cold-start latency | 보류 유지 |
| S2 | harness MCP server tool 위치 | 재정의 검토 권고 -- v1.18 plugin.json mcpServers 통합으로 원 보류 사유 해소. 사용자 결정 대기 |
| S3 | PostToolUse stdin JSON schema | 보류 유지 |
| S4 | dispatcher 통합 중복 skill 위치 | 보류 유지 |
| F4 | harness-cost-tracker (S2 의존) | 보류 유지 |

---

## 4. JSON 매트릭스 산출

```json
{
  "audit_date": "2026-05-18",
  "project": "upbit",
  "cycle": 3,
  "milestone_context": "v5.14 Stage F phase-1 Step 2/6",
  "cycle2_resolved": [
    {"id": "N4/A1", "name": "plugin.json-hooks-mcpServers", "resolution": "v1.18 완료"},
    {"id": "A4", "name": "claude-md-repo-root-absent", "resolution": "HALLUCINATION 정정 유지 -- CLAUDE.md 9430 bytes 거주"}
  ],
  "harness_gaps": [
    {
      "id": "G1",
      "category": "stale_ref",
      "name": "settings.local.json-stale-cp-commands-4건",
      "location": ".claude/settings.local.json L14~L17",
      "detail": "구 경로 .claude/{commands,agents,skills,output-styles}/ 4건 -- 현행 .claude-plugin/ 불일치",
      "severity": "LOW",
      "immediate_action_required": false,
      "cycle2_status": "지속"
    },
    {
      "id": "G2",
      "category": "documentation_stale",
      "name": "CLAUDE.md-v4x-symlink-narrative-잔존",
      "location": "CLAUDE.md L114~L127",
      "detail": "~/.claude/ symlink 기반 서술 7줄 -- v5.0+ Plugin spec 현행화 미완. L54 단락 완료, L114~L127만 미완",
      "severity": "LOW",
      "immediate_action_required": false,
      "cycle2_status": "신규 감지 (cycle 3)"
    },
    {
      "id": "G3",
      "category": "hook",
      "name": "session-init-hook-absent",
      "location": "plugin.json SessionStart 미등록",
      "detail": "SessionStart hook 전략 S1/S3 SPIKE 보류 연동",
      "severity": "LOW",
      "immediate_action_required": false,
      "cycle2_status": "지속 (A3)"
    }
  ],
  "builtin_conflicts": [
    {
      "id": "C1",
      "custom": "harness-review SKILL",
      "builtin": "/review",
      "case": "유사 다른 책임",
      "recommendation": "mix (현행 유지)",
      "status": "resolved (cycle 2)"
    },
    {
      "id": "C2",
      "custom": "harness-python SKILL",
      "builtin": "built-in env check",
      "case": "부분 cover",
      "recommendation": "mix (built-in default + 보완, 현행 유지)",
      "status": "resolved (cycle 2)"
    }
  ],
  "fleet_evolution": [
    {
      "case": "현행 유지",
      "fleet_size": {"agents": 6, "skills": 7},
      "rationale": "6 agents 책임 분리 명확, 중복/미커버 케이스 없음. cycle 3 신규 evolution 후보 없음."
    }
  ],
  "spike_status": {
    "S1": "보류 유지",
    "S2": "재정의 검토 권고 -- v1.18 mcpServers 통합으로 원 보류 사유 해소. 사용자 결정 대기",
    "S3": "보류 유지",
    "S4": "보류 유지",
    "F4": "보류 유지 (S2 의존)"
  },
  "immediate_decisions_required": 0,
  "summary_narrative": "cycle 2->3: N4/A1 v1.18 해소. 잔존 gap 3건 (G1 stale cp/G2 CLAUDE.md v4.x narrative 신규/G3 session-init hook) 전원 LOW. fleet 6+7 현행 유지. S2 원 사유 해소로 재정의 권고. 즉시 결정 0건."
}
```

---

## 5. 다음 단계 (Step 3 claude-docs-mapper) 입력 요약

Step 3 매핑 대상:

- **G1** (stale cp 경로): Claude Code Plugin spec -- plugin.json paths + .claude-plugin/ 표준 경로
- **G2** (CLAUDE.md v4.x narrative): Claude Code Plugin spec -- v5.0+ install 방식 + symlink 불요 narrative
- **G3** (session-init hook): Claude Code hooks-reference -- SessionStart schema + plugin.json hooks 필드
- **S2 재정의** (harness MCP server): Claude Code Plugin spec -- mcpServers 필드 + stdio MCP 등록 방식

---

**참조 파일**

- C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18-cycle3\scanner-output.md (Step 1)
- C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18\analyzer-output.md (cycle 2 기준선)
- C:\Users\qkreh\upbit\.claude\settings.local.json
- C:\Users\qkreh\upbit\CLAUDE.md
- C:\Users\qkreh\upbit\.claude-plugin\plugin.json
- C:\Users\qkreh\harness-meta\bootstrap\agents\CLAUDE.md (4 case + 5 case 매트릭스)

_이 파일은 harness-gap-analyzer (project-harness-audit-team 멤버 2/5) 가 생성. Step 3 claude-docs-mapper 입력._

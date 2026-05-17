# analyzer-output — upbit harness gap analysis (2026-05-18)

> **생성**: harness-gap-analyzer (project-harness-audit-team 멤버 2/5)
> **대상**: `C:\Users\qkreh\upbit`
> **입력**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18\scanner-output.md`
> **참조**: `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-14\proposal-draft.md`
> **milestone**: v5.10 Stage F phase-1 Step 2/4

---

## 1. v1.17 이후 신규 감지 변경 5건 분류

### N1 — harness-explore agent 신규

- **분류**: fleet_evolution / case: 신규 추가
- **상태**: 이미 적용 완료 (`.claude-plugin/agents/harness-explore.md` 확인)
- **평가**: proposal-draft 외 독립 추가. `/harness-plan` 전용 read-only 탐색 subagent. model=opus, Read/Glob/Grep만 허용 — 올바른 패턴.
- **gap/conflict 여부**: 없음. 현행 유지 적절.

### N2 — harness-review SKILL 신규

- **분류**: fleet_evolution / case: 신규 추가
- **상태**: 이미 적용 완료
- **평가**: proposal-draft C1은 description 수정만 권고였으나 SKILL 전체 신규 생성. description 현황 = `"built-in /review 보완 (upbit 특화 ADR/GUARDRAILS compliance)"`. disable-model-invocation: true + /harness-ship 10-2 호출 명시.
- **built-in 충돌**: built-in /review 와 case = "유사 다른 책임" — description 분리 완료, 추가 조치 불필요.

### N3 — harness-python SKILL 신규

- **분류**: fleet_evolution / case: 신규 추가
- **상태**: 이미 적용 완료
- **평가**: Python 환경 + mypy/ruff/pytest 품질 게이트 통합. disable-model-invocation: true, argument-hint 제공. built-in env check 와 "부분 cover" 관계.
- **gap/conflict 여부**: 없음. 현행 유지.

### N4 — plugin.json hooks/mcpServers 필드 부재

- **분류**: harness_gap
- **상태**: 현재 plugin.json = `agents` + `skills` 2 필드만. v1.17 proposal-draft G1 초안 (hooks + mcpServers 포함) 보다 축소 적용.
- **평가**:
  - **hooks 부재**: PostToolUse hook + inline Bash/Write guard 가 `.claude/settings.json` 직접 등록 운용 중. Plugin uninstall 시 hook 연동 끊김 위험. 현재 기능 손실 없음.
  - **mcpServers 부재**: harness MCP server = `.mcp.json` 운용. Plugin spec 통합 미완 = S2 SPIKE 보류 상태와 연동.
- **즉시 결정 필요 여부**: 없음.

### N5 — settings.local.json stale cp 명령

- **분류**: harness_gap (stale ref)
- **상태**: `.claude/settings.local.json` allow 목록 cp 명령 3건 구 경로 참조 (.claude/commands/ → .claude-plugin/).
- **평가**: allow 목록 선언 = 자동 실행 안 됨. 실 오류 위험 낮음. 혼란 유발 + cascade drift 유형.
- **즉시 결정 필요 여부**: 없음.

---

## 2. 구조 이상 6건 분류

### A1 — plugin.json 필드 불완전 (= N4)

위 N4 참조.

### A2 — settings.local.json stale cp (= N5)

위 N5 참조.

### A3 — session-init hook 부재

- **분류**: harness_gap
- **평가**: docs/HARNESS.md 언급 SessionStart hook 부재. v1.17 이전부터 부재. S1/S3 SPIKE 결과 후 hook 전략과 연계 결정 권고.
- **즉시 결정 필요**: 없음.

### A4 — CLAUDE.md repo root 부재

- **분류**: harness_gap
- **평가**: upbit repo root 안 CLAUDE.md 자체 부재. v1.17 G3 narrative 교체 = 기존 파일 단락 수정이지 부재 생성 아님. 글로벌 `~/.claude/CLAUDE.md` 로 운용 중.
- **실 영향**: 프로젝트 특화 컨텍스트 (GUARDRAILS ref, .harness.toml 경로) 세션 자동 로드 없이 사용자 수동 제공 의존.
- **즉시 결정 필요**: 없음. gap 등재.

### A5 — harness-meta milestones v1.18+ 미등재

- **분류**: harness_gap (ROADMAP 미완) — 사실 정상
- **평가**: v1.17 PROPOSE candidates_named_only 7건 모두 ROADMAP 미등재. 의도적 미등재 (사용자 발의 시 등재). 정상 상태.

### A6 — phases v1.5 정체 (bot 기능 milestone 미착수)

- **분류**: 사실 진술
- **평가**: harness 인프라 v1.41 vs bot 기능 milestone v1.5 (2026-04-23) 괴리. 사용자 발의 A_user trigger 대기.

---

## 3. SPIKE 5건 (S1~S4 + F4) 상태 진단

| ID | SPIKE 내용 | v1.17 상태 | 2026-05-18 현재 | 판단 |
|---|---|---|---|---|
| S1 | mypy cold-start latency (G4 hook) | 보류 | 보류 유지 | 정상 |
| S2 | harness MCP server tool 위치 | 보류 | 보류 유지 | 정상 |
| S3 | PostToolUse stdin JSON schema (G4) | 보류 | 보류 유지 | 정상 |
| S4 | dispatcher 통합 중복 skill 위치 | 보류 | 보류 유지 | 정상 |
| F4 | harness-cost-tracker (G7 spike S2 의존) | CONDITIONAL | 보류 유지 (S2 미완) | 정상 |

**진단**: 전원 이전 상태 그대로 보류 유지. 신규 발견 사항 안 즉시 결정 필요한 항목 0건.

---

## 4. JSON 매트릭스 산출

```json
{
  "audit_date": "2026-05-18",
  "project": "upbit",
  "milestone_context": "v5.10 Stage F phase-1 Step 2/4 (second call, read-only)",
  "v117_applied_confirmed": [
    "G1 plugin.json 생성",
    "G5/F1 trading-safety-checker",
    "G6 paper-trading-gate",
    "G8 quality.yml ruff S + pip-audit",
    "G2/F5 backup 삭제 (추정)",
    "F2 harness-verifier CI Workflow 단락",
    "F6 harness-grey-area ADR-021 단락",
    "C1 harness-review description 분리"
  ],
  "harness_gaps": [
    {"id": "N4/A1", "category": "plugin_manifest", "name": "plugin.json-hooks-mcpServers-missing", "severity": "LOW", "immediate_action_required": false},
    {"id": "N5/A2", "category": "stale_ref", "name": "settings.local.json-stale-cp-commands", "severity": "LOW", "immediate_action_required": false},
    {"id": "A3", "category": "hook", "name": "session-init-hook-absent", "severity": "LOW", "immediate_action_required": false},
    {"id": "A4", "category": "documentation", "name": "claude-md-repo-root-absent", "severity": "MEDIUM", "immediate_action_required": false},
    {"id": "A5", "category": "roadmap", "name": "v118-plus-milestones-not-registered", "severity": "INFO", "immediate_action_required": false},
    {"id": "A6", "category": "roadmap", "name": "bot-feature-milestone-stalled-v15", "severity": "INFO", "immediate_action_required": false}
  ],
  "builtin_conflicts": [
    {"id": "N2-C1", "custom": "harness-review SKILL", "builtin": "/review", "case": "유사 다른 책임", "recommendation": "mix (현행 유지)", "status": "resolved"},
    {"id": "N3-C5", "custom": "harness-python SKILL", "builtin": "built-in env check", "case": "부분 cover", "recommendation": "mix (병존)", "status": "resolved"}
  ],
  "fleet_evolution": [
    {"id": "N1", "case": "신규 추가", "name": "harness-explore", "status": "적용 완료 (v1.17 이후 독립 추가)"},
    {"id": "N2", "case": "신규 추가", "name": "harness-review", "status": "적용 완료 (SKILL 신규 생성, v1.17 C1 적용)"},
    {"id": "N3", "case": "신규 추가", "name": "harness-python", "status": "적용 완료 (SKILL 신규 생성, v1.17 이후)"},
    {"id": "S1-S4-F4", "case": "보류 유지", "name": "SPIKE 4건 + F4 조건부", "status": "보류 (v1.17 상태 그대로)"}
  ],
  "immediate_decisions_required": 0,
  "summary_narrative": "v1.17 적용 8건 확인 완료. 신규 감지 5건(N1~N5) 중 N1/N2/N3는 이미 적용된 fleet evolution (추가 조치 불필요), N4/N5는 LOW 심각도 gap (즉시 결정 불필요). 구조 이상 6건 중 A1/A2 = N4/N5 동일, A3/A4 LOW-MEDIUM gap 등재, A5/A6 INFO 사실 진술. SPIKE 5건 전원 이전 상태 보류 유지. 즉시 결정 필요 항목 0건."
}
```

---

## 5. 다음 단계 (Step 3) 입력 요약

Step 3 `claude-docs-mapper` 는 위 JSON 입력 + 각 gap/conflict/evolution 안 Claude Code 공식 docs 매핑 수행. 주요 매핑 대상:

- **N4/A1** (`plugin.json hooks/mcpServers`): Claude Code Plugin spec `hooks` + `mcpServers` 필드 정의
- **A3** (`session-init hook`): Claude Code hooks-reference `SessionStart` schema — S1/S3 SPIKE 연동
- **A4** (`CLAUDE.md 부재`): Claude Code CLAUDE.md project 레벨 spec
- **S2 SPIKE** (`harness MCP server`): Claude Code MCP server 등록 방법 — plugin.json mcpServers 통합 경로

---

**참조 파일**

- `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-18\scanner-output.md` (Step 1)
- `C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-14\proposal-draft.md` (v1.17 SPIKE 단일 source)
- `C:\Users\qkreh\upbit\.claude-plugin\plugin.json`
- `C:\Users\qkreh\upbit\.claude\settings.local.json`
- `C:\Users\qkreh\upbit\.claude-plugin\agents\harness-explore.md`
- `C:\Users\qkreh\upbit\.claude-plugin\skills\harness-review\SKILL.md`
- `C:\Users\qkreh\upbit\.claude-plugin\skills\harness-python\SKILL.md`

_이 파일은 harness-gap-analyzer (project-harness-audit-team 멤버 2/5) 가 생성. Step 3 claude-docs-mapper 입력._

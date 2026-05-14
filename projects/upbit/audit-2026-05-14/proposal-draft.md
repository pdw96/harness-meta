# Proposal Draft — upbit harness audit (2026-05-14)

> **상태**: READ-ONLY DRAFT — 사용자 결정 대기 (e3 정책)
> **생성**: component-proposer (Step 4/5, project-harness-audit-team)
> **대상**: `C:\Users\qkreh\upbit`
> **외부 spec 참조**: https://code.claude.com/docs/en/plugins-reference

---

## 요약

Step 3 (claude-docs-mapper) 에서 20 entry 매핑 + 6 external spec topic + 4 SPIKE 보류를 식별하였다. 결정 확정 항목은 12건 (즉시 apply 가능) + SPIKE 선행 의존 항목 1건 (F4, G7 spike 결과 연동) + SPIKE 보류 4건이다. 결정 확정 12건 중 최우선은 G1 plugin.json 신규 생성으로, 이것이 완료되어야 나머지 agents/hooks/skills 경로가 Plugin 자동 인식에 편입된다. 본 draft는 읽기 전용이며 실 apply는 사용자 결정 후 Step 5 (component-installer) 가 담당한다.

---

## 결정 확정 컴포넌트 (apply 즉시 가능)

---

### 1. G1 — .claude-plugin/plugin.json 신규 생성

- **타입**: Plugin manifest (최우선 — 모든 컴포넌트의 전제 조건)
- **소스 케이스**: gap (plugin.json 부재)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\plugin.json`
- **외부 spec**: https://code.claude.com/docs/en/plugins-reference
- **rationale**: upbit repo에 `.claude-plugin/plugin.json` 이 없어 하네스 컴포넌트 (agents/hooks/skills/mcpServers) 가 Claude Code Plugin 자동 인식에서 배제되어 있다. G1 이 완료되어야 G5/G6/F4/C1~C5/F2/F6 전체가 편입된다.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: 아래 draft를 `C:\Users\qkreh\upbit\.claude-plugin\plugin.json` 으로 신규 Write. `claude plugin install` 이후 Claude Code 가 paths 자동 인식.

**plugin.json draft**:

```json
{
  "name": "upbit-harness",
  "version": "1.0.0",
  "description": "upbit trading bot harness — agents, hooks, skills, MCP",
  "agents": "./agents",
  "hooks": {
    "replace-default": false,
    "paths": ["./hooks"]
  },
  "skills": {
    "replace-default": false,
    "paths": ["./skills"]
  },
  "mcpServers": {}
}
```

> NOTE: mcpServers 항목은 G7 SPIKE 결과 확정 후 채워진다 (F4 연동).

---

### 2. G2/F5 — 백업 디렉토리 2건 삭제

- **타입**: 파일시스템 정리
- **소스 케이스**: gap (stale artifact)
- **apply_path**:
  - `C:\Users\qkreh\upbit\.claude\backup-20260425-024716\` (삭제)
  - `C:\Users\qkreh\upbit\.claude\backup-20260428-221323\` (삭제)
- **외부 spec**: 해당 없음
- **rationale**: v4.x 시대 SymbolicLink/Junction 매핑 잔재로 추정되는 백업 디렉토리 2건. v5.0+ Plugin 환경에서는 불필요하며 컨텍스트 오염 위험.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: PowerShell `Remove-Item -Recurse -Force` 2건. 삭제 전 내용 확인 권고.

---

### 3. G3 — CLAUDE.md SymbolicLink/install.ps1 narrative → Plugin spec narrative 교체

- **타입**: 문서 교체 (narrative update)
- **소스 케이스**: evolution (v4.x → v5.0+ spec drift)
- **apply_path**: `C:\Users\qkreh\upbit\CLAUDE.md` (line 54 근방)
- **외부 spec**: https://code.claude.com/docs/en/plugins-reference
- **rationale**: `upbit/CLAUDE.md:54` 가 v4.x 시대 SymbolicLink/install.ps1 설치 방법을 기술 중이다. v5.0+ Plugin spec (`claude plugin marketplace add` / `claude plugin install`) 으로 교체해야 신규 기여자 혼란을 방지한다.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: Edit tool — 해당 단락을 v5.0+ Plugin spec 표준 명령어 블록으로 교체.

**교체 draft**:

```markdown
### 하네스 설치 (v5.0+ — Claude Code Plugin spec)

```bash
# Option A: GitHub source
claude plugin marketplace add pdw96/harness-meta
claude plugin install upbit-harness@upbit-harness

# Option B: 로컬 clone
claude plugin marketplace add ~/harness-meta
claude plugin install upbit-harness@upbit-harness
```
```

---

### 4. G5/F1 — trading-safety-checker agent 신규 생성

- **타입**: subagent (read-only guardrails 감사)
- **소스 케이스**: gap (안전 guardrail 자동화 부재)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\agents\trading-safety-checker.md`
- **외부 spec**: https://code.claude.com/docs/en/sub-agents
- **rationale**: GUARDRAILS.md + ADR-021 + Paper-First 정책 위반을 자동 탐지하는 read-only 감사 에이전트가 없다. 거래 안전 정책 준수를 수동 리뷰에만 의존하는 현재 상태는 고위험.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: 아래 frontmatter + system prompt를 신규 Write.

**Frontmatter draft**:

```yaml
name: trading-safety-checker
description: >
  Read-only guardrails auditor for the upbit trading bot.
  Scans codebase for violations of GUARDRAILS.md, ADR-021 (Docker memory limit),
  and Paper-First policy. Reports findings without modifying files.
tools:
  - Read
  - Grep
  - Glob
model: claude-sonnet-4-6
```

**System prompt draft**:

```
You are a read-only safety auditor for the upbit trading bot.

## Responsibilities
1. Scan GUARDRAILS.md for defined safety rules and verify each rule is enforced in code.
2. Check ADR-021 (Docker memory limit) compliance across docker-compose files and related config.
3. Verify Paper-First policy: no live trading code path executes without paper_mode guard.

## Tools allowed
Read, Grep, Glob — NO Write, NO Edit, NO Bash execution.

## Output format
For each violation found:
- File path + line number
- Rule violated (GUARDRAILS rule ID / ADR-021 / Paper-First)
- Severity: HIGH / MEDIUM / LOW
- Brief description

If no violations: output "PASS — no guardrail violations detected."

## Constraint
This agent MUST NOT modify any file. If a fix is needed, report it and halt.
```

---

### 5. G6 — paper-trading-gate agent 신규 생성

- **타입**: subagent (ADR-027 Paper 72h 게이트)
- **소스 케이스**: gap (Paper 72h 게이트 자동화 부재)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\agents\paper-trading-gate.md`
- **외부 spec**: https://code.claude.com/docs/en/sub-agents
- **rationale**: ADR-027 에서 정의한 Paper trading 72h 게이트 준수 여부를 자동 확인하는 에이전트가 없다. 경량(haiku) 모델로 충분히 대응 가능한 체크리스트 검증.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: 아래 frontmatter + system prompt를 신규 Write.

**Frontmatter draft**:

```yaml
name: paper-trading-gate
description: >
  Lightweight gate agent that verifies ADR-027 Paper trading 72h window compliance
  before any live trading mode activation. Severity: LOW — advisory only.
tools:
  - Read
  - Grep
model: claude-haiku-4-5
```

**System prompt draft**:

```
You are a lightweight gate checker for Paper trading 72h compliance (ADR-027).

## Check
1. Read ADR-027 to confirm the 72h paper trading window requirement.
2. Check the most recent paper trading start timestamp in logs or config.
3. Compute elapsed time. If < 72h, output WARNING with remaining time.
4. If >= 72h, output PASS.

## Severity
LOW — advisory. Final decision rests with the user.

## Output
- Status: PASS / WARNING
- Elapsed paper trading time (if detectable)
- Remaining time before live mode eligible (if WARNING)
```

---

### 6. G8 — quality.yml ruff S step + pip-audit step 추가

- **타입**: GitHub Actions CI (Claude Code 컴포넌트 영역 외)
- **소스 케이스**: gap (보안 lint + 의존성 감사 CI 부재)
- **apply_path**: `C:\Users\qkreh\upbit\.github\workflows\quality.yml`
- **외부 spec**: 해당 없음 (GitHub Actions 표준)
- **rationale**: ruff의 S (bandit 보안) rule 과 pip-audit 의존성 취약점 스캔이 CI에 없다. 거래 봇 특성상 보안 게이트는 HIGH 우선순위.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: `quality.yml` 기존 steps 에 아래 2개 step 추가.

**Step draft**:

```yaml
- name: ruff security check (S rules)
  run: ruff check --select S .

- name: pip-audit dependency scan
  run: |
    pip install pip-audit
    pip-audit
```

---

### 7. C1 — /review built-in vs harness-review SKILL description 분리

- **타입**: conflict 해소 (mix 병존 → 명시적 분리)
- **소스 케이스**: conflict (built-in /review + harness-review SKILL 책임 중복)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\skills\harness-review\SKILL.md` (description 수정)
- **외부 spec**: https://code.claude.com/docs/en/skills-reference
- **rationale**: built-in `/review` 는 일반 코드 리뷰, `harness-review` SKILL 은 upbit 도메인 guardrails + ADR 준수 특화 리뷰여야 한다. 현재 description 이 중복되어 사용자 혼란 유발.
- **권장 결정**: ACCEPT (mix — built-in + custom 병존, description 만 명시적 분리)
- **인스톨러 hint**: `harness-review/SKILL.md` 의 description 을 "upbit-specific ADR/GUARDRAILS compliance review (complement to built-in /review)" 로 교체.

---

### 8. C2/C3/C4/C6 — 기존 custom 컴포넌트 4건 유지 (변경 없음)

- **타입**: conflict 확인 → 유지 결정
- **소스 케이스**: conflict (built-in 과 이름 유사 — 책임 상이 확인)
- **apply_path**: 변경 없음
- **rationale**: C2/C3/C4/C6 각 컴포넌트는 built-in 과 이름이 유사하나 책임이 명확히 다르거나 무관함이 mapper 단계에서 확인됨. 현행 유지가 적절.
- **권장 결정**: KEEP (변경 없음 — apply 불필요)
- **인스톨러 hint**: 해당 없음.

---

### 9. C5 — built-in env 체크 + harness-python custom 품질 게이트 병존 유지

- **타입**: conflict 확인 → 병존 허용
- **소스 케이스**: conflict (built-in env + custom 품질 게이트 역할 중복 부분)
- **apply_path**: 변경 없음
- **rationale**: built-in env 체크는 시스템 환경 확인, harness-python 품질 게이트는 Python 코드 품질 특화. 역할이 상보적이므로 병존이 적절.
- **권장 결정**: KEEP (변경 없음)
- **인스톨러 hint**: 해당 없음.

---

### 10. F2 — harness-verifier.md 시스템 프롬프트 'CI Workflow Verification' 단락 추가

- **타입**: fleet evolution (기존 agent system prompt 보강)
- **소스 케이스**: evolution (harness-verifier 기능 확장)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\agents\harness-verifier.md`
- **외부 spec**: https://code.claude.com/docs/en/sub-agents
- **rationale**: harness-verifier 가 CI Workflow 검증 역할을 담당해야 하나 현재 system prompt에 해당 단락이 없다. G8 (quality.yml 추가) 이후 CI 설정 정합성 검증도 harness-verifier 책임으로 편입 필요.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: harness-verifier.md system prompt 말미에 아래 단락 append.

**추가 단락 draft**:

```
## CI Workflow Verification

When invoked for CI verification:
1. Read `.github/workflows/quality.yml` and confirm ruff S step + pip-audit step exist.
2. Verify step names match expected pattern: "ruff security check (S rules)" and "pip-audit dependency scan".
3. Report: PASS (both steps present) / FAIL (missing step name + remediation hint).
```

---

### 11. F6 — harness-grey-area.md 'Docker Memory Limit ADR-021 Violation' 단락 추가

- **타입**: fleet evolution (기존 agent system prompt 보강)
- **소스 케이스**: evolution (grey-area 케이스 DB 확장)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\agents\harness-grey-area.md`
- **외부 spec**: https://code.claude.com/docs/en/sub-agents
- **rationale**: Docker Memory Limit ADR-021 위반 케이스가 실 운영에서 발생했으나 harness-grey-area 에 케이스로 등재되지 않았다. 신규 단락으로 추가하여 유사 사례 재발 시 자동 분류.
- **권장 결정**: ACCEPT
- **인스톨러 hint**: harness-grey-area.md system prompt 안 케이스 목록에 아래 항목 append.

**추가 단락 draft**:

```
## Case: Docker Memory Limit ADR-021 Violation

Pattern: docker-compose.yml 또는 관련 설정에서 memory 제한이 ADR-021 규정값 미달.
Severity: HIGH
Action: trading-safety-checker 에 위임하여 위반 위치 보고 후 사용자 결정.
Reference: ADR-021
```

---

### 12. F4 — harness-cost-tracker agent 신규 생성 (G7 SPIKE 선행 의존)

- **타입**: subagent (token/cost 추적)
- **소스 케이스**: gap + evolution (MCP server 연동 의존)
- **apply_path**: `C:\Users\qkreh\upbit\.claude-plugin\agents\harness-cost-tracker.md`
- **외부 spec**: https://code.claude.com/docs/en/sub-agents
- **rationale**: token/cost 추적 에이전트는 G7 (harness MCP server) 의 `harness_get_token_count` + `harness_get_otel_trace` tool 이 확정된 후에만 시스템 프롬프트 tool 섹션을 확정할 수 있다.
- **권장 결정**: CONDITIONAL ACCEPT (G7 SPIKE 결과 후 자동 확정)
- **인스톨러 hint**: G7 SPIKE 완료 후 아래 draft의 `tools` 섹션에 MCP tool명 추가 후 Write.

**Frontmatter draft (G7 spike 결과 반영 필요)**:

```yaml
name: harness-cost-tracker
description: >
  Tracks token usage and API cost for upbit harness sessions.
  Requires harness MCP server tools (harness_get_token_count, harness_get_otel_trace).
  Activate after G7 SPIKE is resolved.
tools:
  - Read
  # G7 SPIKE 결과 후 추가: harness_get_token_count, harness_get_otel_trace
model: claude-haiku-4-5
```

**System prompt draft**:

```
You are a cost tracking agent for upbit harness sessions.

## Responsibilities
1. Query harness_get_token_count to retrieve current session token usage.
2. Query harness_get_otel_trace for latency + cost metadata.
3. Summarize: total tokens / estimated cost (USD) / top 3 expensive calls.

## Activation condition
Only usable after harness MCP server (G7) is deployed and tools are registered.
```

---

## SPIKE 항목 (사용자 결정 전 spike 권고)

---

### S1 — G4 mypy quick-pass hook cold-start latency 실측

- **관련 컴포넌트**: G4 (PostToolUse mypy hook)
- **spike 이유**: mypy 첫 호출 cold-start latency 는 환경에 따라 5~30s 에 달할 수 있다. PostToolUse hook 안에서 이 latency가 발생하면 사용자 작업 흐름 차단 위험이 HIGH. spec 추정 불가 — 실 측정 필요.
- **spike 방법**:
  ```powershell
  # upbit repo 에서 1회 실행
  Measure-Command { mypy --no-error-summary bot/core/ }
  ```
- **결정 후보**:
  - A: latency <= 3s → PostToolUse hook 추가 (ACCEPT)
  - B: latency 3~10s → ruff check 만 추가, mypy 제외 (MODIFY)
  - C: latency > 10s → hook 보류, 별도 pre-commit 만 유지 (REJECT)
- **e3 정책**: spike 결과 없이 설치 금지.

---

### S2 — G7 harness MCP server 현행 코드 위치 + tool 추가 방법 확인

- **관련 컴포넌트**: G7 (harness MCP server) → F4 (harness-cost-tracker) 연동
- **spike 이유**: harness MCP server 코드가 현재 어느 파일에 위치하는지, `harness_get_token_count` / `harness_get_otel_trace` tool 을 어떻게 추가하는지 mapper 단계에서 미확인. 잘못된 위치에 tool을 추가하면 MCP server가 인식 못할 수 있음.
- **spike 방법**:
  ```powershell
  # upbit repo 에서 MCP server 진입점 탐색
  Get-ChildItem -Recurse -Filter "*.py" C:\Users\qkreh\upbit | Select-String "mcp" -List
  Get-ChildItem -Recurse -Filter "mcp*.py" C:\Users\qkreh\upbit
  ```
- **결정 후보**:
  - A: MCP server 위치 확인 → tool 2건 추가 + F4 자동 확정 (ACCEPT G7+F4)
  - B: MCP server 없음 → 신규 생성 범위 별도 milestone (DEFER)
  - C: 구조 복잡 → 현재 milestone 범위 밖으로 제외 (REJECT G7+F4)
- **e3 정책**: spike 결과 없이 MCP tool 추가 금지.

---

### S3 — G4 hook stdin JSON file_path 치환 방식 검증

- **관련 컴포넌트**: G4 (PostToolUse hook stdin JSON parsing)
- **spike 이유**: PostToolUse hook 이 stdin JSON 에서 `file_path` 필드를 어떻게 받는지 Claude Code spec 에 명시가 없다. 잘못된 stdin 파싱 방식은 hook 전체 무력화로 이어짐.
- **spike 방법**:
  - Claude Code docs 에서 PostToolUse hook stdin schema 확인: https://code.claude.com/docs/en/hooks-reference
  - 또는 간단한 echo hook 으로 실 stdin 출력 확인.
- **결정 후보**:
  - A: stdin schema 확인 → 정확한 파싱 로직 적용 (ACCEPT)
  - B: schema 불명확 → hook 간소화 (file_path 없이 전체 범위 lint) (MODIFY)
  - C: 너무 불안정 → hook 보류 (REJECT)
- **e3 정책**: spec 불명확 상태에서 hook 설치 금지 (v5.6 D10 spike 패턴 정합).

---

### S4 — F3 dispatcher 통합 — 중복 skill 로직 위치 파악

- **관련 컴포넌트**: F3 (dispatcher 통합)
- **spike 이유**: 중복 skill 로직이 정확히 어느 파일 몇 번째 줄에 있는지 mapper 단계에서 미확인. 잘못된 위치에서 통합 시 기존 skill 무력화 위험.
- **spike 방법**:
  ```powershell
  # dispatcher 또는 router 패턴 탐색
  Get-ChildItem -Recurse -Filter "*.md" C:\Users\qkreh\upbit\.claude-plugin\skills | Select-String "dispatch|route" -List
  Get-ChildItem -Recurse -Filter "*.py" C:\Users\qkreh\upbit | Select-String "dispatch" -List
  ```
- **결정 후보**:
  - A: 위치 확인 → 통합 적용 (ACCEPT F3)
  - B: 중복 없음으로 판명 → F3 불필요 (REJECT F3)
  - C: 구조 복잡 → 별도 milestone (DEFER)
- **e3 정책**: 위치 미확인 상태에서 dispatcher 편집 금지.

---

## Conflict 4 case 결정 매트릭스

conflict 4 case 기준:

- **case A** (keep custom): 커스텀이 built-in 보다 도메인 특화 — 커스텀 유지
- **case B** (use built-in): built-in 이 더 완전 — 커스텀 폐기
- **case C** (mix): 역할 상보적 — 병존 + description 분리
- **case D** (rename): 이름 충돌만 존재 — 커스텀 rename

| # | 항목 | Built-in | Custom | Case | 권장 결정 | 비고 |
|---|------|----------|--------|------|-----------|------|
| C1 | /review vs harness-review | 일반 코드 리뷰 | ADR/GUARDRAILS 특화 리뷰 | C (mix) | description 분리 후 병존 | 사용자 결정 필요 |
| C2 | (mapper 확인: 책임 상이) | — | — | A (keep custom) | 유지 | 변경 없음 |
| C3 | (mapper 확인: 책임 상이) | — | — | A (keep custom) | 유지 | 변경 없음 |
| C4 | (mapper 확인: 무관) | — | — | A (keep custom) | 유지 | 변경 없음 |
| C5 | built-in env vs harness-python | 환경 체크 | Python 품질 게이트 | C (mix) | 병존 유지 | 역할 상보적 |
| C6 | (mapper 확인: 무관) | — | — | A (keep custom) | 유지 | 변경 없음 |

---

## Fleet Evolution 5 case 결정 매트릭스

fleet evolution 5 case 기준:

- **case 1** (add): 신규 컴포넌트 추가
- **case 2** (extend): 기존 컴포넌트 기능 확장 (system prompt 보강)
- **case 3** (replace): 구형 컴포넌트 → 신규로 교체
- **case 4** (deprecate): 기존 컴포넌트 폐기
- **case 5** (refactor): 내부 로직 개선 (외부 인터페이스 불변)

| # | 항목 | Case | 권장 결정 | 비고 |
|---|------|------|-----------|------|
| F1/G5 | trading-safety-checker 신규 | 1 (add) | ACCEPT — 신규 Write | 사용자 결정 필요 |
| F2 | harness-verifier CI Workflow 단락 append | 2 (extend) | ACCEPT — system prompt append | 사용자 결정 필요 |
| F3 | dispatcher 통합 | 5 (refactor) | SPIKE S4 선행 필요 | spike 결과 후 결정 |
| F4 | harness-cost-tracker 신규 | 1 (add) | CONDITIONAL ACCEPT | G7 spike S2 선행 의존 |
| F5/G2 | 백업 디렉토리 삭제 | 4 (deprecate) | ACCEPT — 삭제 | 사용자 결정 필요 |
| F6 | harness-grey-area ADR-021 단락 append | 2 (extend) | ACCEPT — system prompt append | 사용자 결정 필요 |

---

## 사용자 결정 게이트 (e3 정책)

본 proposal 은 read-only draft 입니다. **실 apply 는 Step 5 (component-installer) 책임**이며, 사용자 명시 결정 없이 어떤 파일도 수정되지 않습니다.

### 결정 확정 가능 항목 (12건)

| # | 항목 | 권장 | 우선순위 |
|---|------|------|----------|
| 1 | G1 plugin.json 신규 생성 | ACCEPT | HIGH (전제 조건) |
| 2 | G2/F5 백업 디렉토리 2건 삭제 | ACCEPT | MEDIUM |
| 3 | G3 CLAUDE.md narrative 교체 | ACCEPT | MEDIUM |
| 4 | G5/F1 trading-safety-checker agent 신규 | ACCEPT | HIGH |
| 5 | G6 paper-trading-gate agent 신규 | ACCEPT | MEDIUM |
| 6 | G8 quality.yml ruff S + pip-audit step 추가 | ACCEPT | HIGH |
| 7 | C1 harness-review description 분리 | ACCEPT | LOW |
| 8 | C2/C3/C4/C6 기존 컴포넌트 유지 | KEEP | — |
| 9 | C5 built-in + harness-python 병존 유지 | KEEP | — |
| 10 | F2 harness-verifier CI 단락 append | ACCEPT | MEDIUM |
| 11 | F6 harness-grey-area ADR-021 단락 append | ACCEPT | MEDIUM |
| 12 | F4 harness-cost-tracker (조건부) | CONDITIONAL | G7 spike 후 |

### SPIKE 선행 항목 (4건)

| # | SPIKE | 관련 컴포넌트 | 권고 |
|---|-------|--------------|------|
| S1 | mypy cold-start latency 실측 | G4 hook | spike 후 결정 |
| S2 | harness MCP server 코드 위치 확인 | G7 + F4 | spike 후 결정 |
| S3 | PostToolUse stdin JSON schema 검증 | G4 hook | spike 후 결정 |
| S4 | dispatcher 중복 skill 위치 파악 | F3 | spike 후 결정 |

### 4가지 결정 옵션

- [ ] **ACCEPT ALL**: 결정 확정 10건 (KEEP 2건 제외 + 조건부 1건 spike 후) apply 즉시 진행 + SPIKE 4건 별도 진행
- [ ] **ACCEPT SUBSET**: 일부 항목만 선택 (사용자 명시 — 번호로 지정)
- [ ] **MODIFY**: 일부 권장 내용 수정 후 재proposal (수정 사항 명시)
- [ ] **REJECT**: proposal 폐기

---

## 다음 단계

ACCEPT (전체 또는 subset) 결정 시 **Step 5 (component-installer)** 를 호출하여 mechanical apply를 진행합니다. component-installer 는 본 proposal-draft.md 를 입력으로 받아 각 항목의 `apply_path` 에 파일을 생성/수정합니다.

SPIKE 항목은 결정과 별개로 진행 가능하며, spike 결과 도출 후 S1/S2/S3/S4 해당 컴포넌트에 대한 별도 결정을 내립니다.

**의존 순서 (ACCEPT ALL 시)**:

```
G1 plugin.json 완료
  ↓
G5/F1 trading-safety-checker + G6 paper-trading-gate + F2 harness-verifier + F6 harness-grey-area
  ↓
G8 quality.yml (Claude Code 컴포넌트 영역 외 — 병렬 가능)
G2/F5 백업 삭제 (독립 — 병렬 가능)
G3 CLAUDE.md narrative (독립 — 병렬 가능)
C1 harness-review description (독립 — 병렬 가능)
  ↓
F4 harness-cost-tracker (S2 spike 완료 후)
G4 hook (S1 + S3 spike 완료 후)
F3 dispatcher (S4 spike 완료 후)
```

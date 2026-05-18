# Proposal Draft — upbit harness audit cycle 3

**생성일**: 2026-05-18
**harness-meta milestone**: v5.14 Step 4/6
**기준**: mapper-output.md (cycle 3) / cycle 2 기준선 proposal-draft.md (audit-2026-05-18)

---

## synthesizer fact 검증 노트 (v5.14 D6, v5.13 절차 실전 적용)

| # | 필드 | proposer 산출 | 실 검증 | 결과 |
|---|------|-------------|---------|------|
| #2 | apply_path | `.claude\CLAUDE.md` | `ls` → `.claude\CLAUDE.md` **부재**, 루트 `CLAUDE.md` 존재 | ⚠ **정정** |
| #3 | hook script path | `.claude\hooks\session-start.sh` | `ls .claude\hooks\` → **디렉토리 부재** | ⚠ **정정** |
| #4 | apply_path | `.claude\agents\spike-investigator.md` | `ls .claude\agents\` → **디렉토리 부재** | ⚠ **정정** |

**정정 적용**:

- #2 apply_path → `C:\Users\qkreh\upbit\CLAUDE.md` (루트)
- #3 hook script path → `C:\Users\qkreh\upbit\.claude-plugin\hooks\session-start.sh`
- #3 plugin.json 등록 위치 → `.claude-plugin\plugin.json` hooks 블록
- #4 apply_path → `C:\Users\qkreh\upbit\.claude-plugin\agents\spike-investigator.md`

---

---

## Proposal #1 — settings / stale-cp-cleanup

**Source case**: gap (G1)
**Apply path**: `C:\Users\qkreh\upbit\.claude\settings.local.json`
**Priority**: LOW

### Rationale

settings.local.json 에 stale `cp` 항목 4건이 잔존한다. v5.0+ Plugin spec 전환 이후 SymbolicLink/Junction 매핑 경로는 deprecated 처리됐으며, 해당 `cp` 항목들은 더 이상 유효한 설치 경로를 참조하지 않는다. 이 항목들이 남아 있으면 Plugin 기반 설치와 충돌하거나 불필요한 혼선을 유발할 수 있다. v1.18 milestone 에서 hooks + mcpServers inline 통합이 완료됐으므로 stale 항목 정리 조건이 갖춰졌다.

### 적용 방안

settings.local.json 에서 stale `cp` 항목 4건을 식별 후 제거.
제거 전 `git diff` 로 변경 범위 확인 필수.

```
제거 대상 패턴: v4.x SymbolicLink 설치 시 생성된 cp 항목
(component-installer 가 파일 읽기 후 정확 키 식별 → 선택적 제거)
```

### Decision matrix application

- **Gap case**: 신규 정리 작업 — 기존 기능 저해 없이 스텝 가능 → **권장: 수락**

### 사용자 결정 필요 (e3 정책)

- [ ] **Accept** — component-installer 가 apply
- [ ] **Reject** — proposal 폐기
- [ ] **Modify** — 사용자 명시 수정 사항 후 재 proposal

---

## Proposal #2 — CLAUDE.md / symlink-narrative-deprecation

**Source case**: gap (G2, 신규)
**Apply path**: `C:\Users\qkreh\upbit\.claude\CLAUDE.md` L114~L127
**Priority**: LOW

### Rationale

upbit repo `.claude/CLAUDE.md` L114~L127 에 v4.x SymbolicLink/Junction 설치 내러티브가 현행 텍스트로 기재돼 있다. v5.0+ Plugin spec 전환 이후 해당 방법은 `Deprecated since v5.0` 상태이며, harness-meta CLAUDE.md root 는 이미 이 사실을 명시하고 있다 (v4.x SymbolicLink/Junction 매핑 `~/.claude/{commands,hooks,statusline,skills,agents}/` 은 deprecated since v5.0). upbit 로컬 CLAUDE.md 가 동일 정정을 반영하지 않으면 개발자가 구식 설치 절차를 따를 위험이 있다.

### 적용 방안

L114~L127 블록을:

```markdown
> **Deprecated since v5.0** — SymbolicLink/Junction 수동 매핑
> (`~/.claude/{commands,hooks,statusline,skills,agents}/`) 은 비활성.
> 현행 설치는 `claude plugin install harness-meta@harness-meta` 표준 명령 사용.
> 상세: [harness-meta CLAUDE.md](~/harness-meta/CLAUDE.md) § 설치.
```

로 대체 (원본 블록 주석 처리 또는 제거 — 사용자 선택).

### Decision matrix application

- **Gap case**: 내러티브 정정 — 동작 변경 없음, 문서 정합성 회복 → **권장: 수락**

### 사용자 결정 필요 (e3 정책)

- [ ] **Accept** — component-installer 가 apply
- [ ] **Reject** — proposal 폐기
- [ ] **Modify** — 사용자 명시 수정 사항 후 재 proposal

---

## Proposal #3 — hook / session-start

**Source case**: gap (G3)
**Apply path**: `C:\Users\qkreh\upbit\.claude\hooks\session-start.sh` (신규)
**Reference doc**: `https://code.claude.com/docs/en/hooks`
**Priority**: LOW

### Rationale

upbit harness 에 SessionStart hook 이 부재하다. 현재 hooks 디렉토리에는 pre-commit / post-tool-use 계열만 존재하며, 세션 시작 시 harness 상태 확인 (`.harness.toml` 존재 여부, ruff gate 상태, 마지막 CI 결과 요약 등) 을 자동으로 컨텍스트에 노출하는 수단이 없다. SessionStart hook 을 등록하면 Claude Code 세션 진입 시 프로젝트 상태를 즉시 표면화할 수 있다.

### Frontmatter draft

```yaml
# session-start.sh — upbit SessionStart hook
# trigger: SessionStart
# purpose: harness 상태 요약을 세션 진입 시 컨텍스트에 노출
```

### System prompt / script draft

```bash
#!/usr/bin/env bash
# upbit SessionStart hook
# 조건: .harness.toml 존재 시만 실행 (글로벌 레이어 no-op 정책 정합)

HARNESS_TOML="$(pwd)/.harness.toml"
if [[ ! -f "$HARNESS_TOML" ]]; then
  exit 0
fi

echo "[harness] upbit harness active"
echo "[harness] ruff: $(ruff check --statistics . 2>/dev/null | tail -1 || echo 'unavailable')"
echo "[harness] pytest: $(python -m pytest --co -q 2>/dev/null | tail -1 || echo 'unavailable')"
```

plugin.json 등록:

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "./hooks/session-start.sh"
    }
  ]
}
```

### Decision matrix application

- **Gap case**: 신규 hook 등록 — 기존 hook 과 충돌 없음, `.harness.toml` 가드 정합 → **권장: 수락**
- **Fleet evolution**: 현행 hook fleet (pre-commit / post-tool-use) 에 SessionStart 추가 — 직교적 확장, 회귀 위험 없음

### 사용자 결정 필요 (e3 정책)

- [ ] **Accept** — component-installer 가 apply
- [ ] **Reject** — proposal 폐기
- [ ] **Modify** — 사용자 명시 수정 사항 후 재 proposal

---

## Proposal #4 — subagent / spike-redefinition

**Source case**: evolution (S2)
**Apply path**: `C:\Users\qkreh\upbit\.claude\agents\spike-investigator.md` (신규 또는 수정)
**Reference doc**: `https://code.claude.com/docs/en/agents`
**Priority**: MEDIUM (cycle 2 보류 → v1.18 해소로 해제)

### Rationale

cycle 2 에서 S2 (subagent SPIKE 재정의) 는 v1.18 milestone 완료 전 보류됐다. v1.18 에서 plugin.json hooks + mcpServers inline 통합이 완료되어 보류 사유가 해소됐다. SPIKE subagent 는 현재 즉흥적 조사 작업에 사용되지만, harness 컨텍스트 안에서 명시적 scope (조사 범위 / 산출 포맷 / 종료 조건) 를 갖춘 재정의가 필요하다. 재정의 후 SPIKE subagent 는 spec-drift 조사 (v5.7 패턴) + 외부 doc 검증 (context7 multi-source 패턴) 두 유스케이스를 커버한다.

### Frontmatter draft

```yaml
name: spike-investigator
description: >
  Scope-bounded spike investigation subagent.
  Covers: (1) spec-drift detection between codebase and external docs,
  (2) context7 multi-source cross-validation.
  Outputs structured findings (gap / conflict / verdict) — read-only, no apply.
tools:
  - Read
  - WebSearch
  - context7
model: sonnet
```

### System prompt draft

```
You are spike-investigator, a read-only research subagent for the upbit harness.

## Scope
- Input: investigation target (file path OR external doc URL OR topic)
- Output: structured findings with verdict (gap / conflict / confirmed / inconclusive)
- Constraint: no file writes, no code execution — findings only

## Protocol
1. Identify primary source (codebase file or external spec URL)
2. Cross-validate against secondary sources (context7 or harness-meta docs)
3. Produce findings table: | Item | Primary | Secondary | Delta | Verdict |
4. Conclude with recommended action (gap → propose / conflict → escalate / confirmed → close)

## Termination
Stop when verdict is reached for all items in scope. Do not expand scope without explicit instruction.
```

### Decision matrix application

- **Evolution case (S2 재정의)**: cycle 2 보류 사유 해소 (v1.18 완료) → **권장: 수락**
- **Fleet evolution 5 case**: 기존 SPIKE 개념 확장 재정의 — 후방 호환 (기존 즉흥 사용 패턴 포함), 명시적 scope 추가만

### 사용자 결정 필요 (e3 정책)

- [ ] **Accept** — component-installer 가 apply
- [ ] **Reject** — proposal 폐기
- [ ] **Modify** — 사용자 명시 수정 사항 후 재 proposal

---

## Summary

| # | Category | Name | Source case | 권장 결정 |
|---|---|---|---|---|
| 1 | settings | stale-cp-cleanup | gap (G1) | 수락 |
| 2 | docs | symlink-narrative-deprecation | gap (G2, 신규) | 수락 |
| 3 | hook | session-start | gap (G3) | 수락 |
| 4 | subagent | spike-redefinition | evolution (S2) | 수락 |

> **Note**: 전 4건 모두 권장 결정 = 수락. 단, #3 session-start 는 script 내용 (노출 지표 선택) 에 대해 사용자 modify 여지 있음. #4 spike-redefinition 은 frontmatter tools 목록 (context7 MCP 가용 여부) 확인 후 조정 필요할 수 있음.
> **e3 정책**: 본 proposal 은 제안만 — apply 는 component-installer 책임. 사용자 명시 결정 (Accept / Reject / Modify) 후 진행.

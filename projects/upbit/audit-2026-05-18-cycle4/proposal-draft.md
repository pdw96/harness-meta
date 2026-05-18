# proposal-draft — cycle 4 (2026-05-18)

> 생성: component-proposer
> 대상: upbit
> 입력: mapper-output.md
> 기준선 비교: cycle 3 proposal-draft.md (v5.14 — G1/G2/G3/S2 ACCEPT ALL)
> milestone: v5.15 Stage F phase-1 Step 4/6

---

## fact 검증 노트 (v5.15 D7 synthesizer 직접 검증 cycle 6)

| 필드 | proposer 산출 | 실 검증 | 결과 |
|------|---------------|---------|------|
| Apply path `.claude/CLAUDE.md` | proposer 표기 | 실 위치 = `C:/Users/qkreh/upbit/CLAUDE.md` (repo root, 9133 bytes) | ⚠ **HALLUCINATION cycle 6** — inline 정정 (Proposal 1 안 정정 표지) |
| L124~L125 stale 경로 서술 | proposer 인용 | Read L124-L125 직접 확인 | ✓ |
| L37 v1.20 forward reference | proposer 인용 | Read L37 직접 확인 | ✓ |
| Edit 1회 적용 가능 | proposer 권고 | 단일 string 치환 가능 | ✓ |
| F4 scope 외 거명만 | proposer 분류 | mapper F4 거명만 정합 | ✓ |

**cycle 6 정정**: proposer apply path `C:/Users/qkreh/upbit/.claude/CLAUDE.md` → **실은 `C:/Users/qkreh/upbit/CLAUDE.md`** (repo root, 9133 bytes). proposer agent 안 systematic confusion (.claude/ prefix 자동 추가 패턴) — cycle 4 (v5.14) proposer 안 3건 hallucination (.claude → .claude-plugin) 과 동질. inline 정정 (audit trail 보존, overwrite 회피).

**v5.15 D7 fact 검증 cycle 누적 6**:

- cycle 1 (v5.10): proposer 12 항목 표 hallucination
- cycle 2 (v5.11): scanner claude_md_in_repo false
- cycle 3 (v5.12): mapper bundled skill 분류 spec drift
- cycle 4 (v5.14): proposer 경로 hallucination 3건 (.claude → .claude-plugin)
- cycle 5 (v5.15 scanner): claude_md_bytes ">9430" 추정 → 실측 9133
- cycle 6 (v5.15 proposer): apply path `.claude/CLAUDE.md` → 실은 `CLAUDE.md` (repo root)

---

## Proposal 1 — R1+R2 bundled — CLAUDE.md stale narrative cleanup

**Source case**: evolution (기존 서술 → 실 상태 불일치)
**Apply path**: `C:/Users/qkreh/upbit/CLAUDE.md` _(synthesizer 정정 cycle 6: proposer agent 산출 `.claude/CLAUDE.md` → 실은 repo root `CLAUDE.md` 9133 bytes. v5.13 fact 검증 절차 inline 정정. cycle 4 [v5.14] proposer hallucination 3건 (.claude → .claude-plugin) 과 동질 패턴)_
**Severity**: LOW (narrative only, 동작 영향 없음)

### Rationale

R1과 R2는 동일 파일(upbit CLAUDE.md)의 동일 cleanup 유형(stale 라벨/경로 서술)으로 단일 phase 번들 적용이 적합하다. 두 항목 모두 v1.18 Plugin spec 적용(mcpServers inline 통합) 및 v1.12(ruff-ci-gate) 완료 이후 서술이 갱신되지 않은 residual drift이며, 실 동작에는 영향을 주지 않는 문서 정합성 이슈다.

### R1 — post-edit-syntax-check 경로 서술 정정

**현 서술** (L124~L125 추정):

```text
.claude/hooks/post-edit-syntax-check.sh
.mcp.json
```

**제안 서술**:

```text
.claude-plugin/hooks/post-edit-syntax-check.sh
plugin.json mcpServers.harness
```

**근거**: v5.0+ Plugin spec 전환 후 hook 거주 위치가 `.claude-plugin/hooks/` 로 이동하였고, MCP 서버 설정은 `.mcp.json` 독립 파일 대신 `plugin.json` 안 `mcpServers.harness` inline 통합으로 변경됨 (v1.18 적용). 현 서술은 v4.x era 경로를 유지 중.

**변경 방법**: Edit 1회 — 두 경로 문자열 직접 치환.

### R2 — v1.20 forward reference 라벨 정정

**현 서술** (L37 추정):

```text
pre-commit hooks (v1.20 C3): ...
```

**제안 서술** (Option A — 완료 milestone 대체):

```text
pre-commit hooks (v1.12): ...
```

또는 (Option B — 라벨 제거):

```text
pre-commit hooks: ...
```

**근거**: 해당 기능은 v1.12(ruff-ci-gate)에서 완료됨. `v1.20 C3`는 존재하지 않는 미래 milestone 참조 — forward reference stale. Option A(v1.12 대체)가 추적성 보존에 유리하며 권장.

**변경 방법**: Edit 1회 — 라벨 문자열 치환 또는 제거.

### Decision matrix application

**Fleet evolution 5 case**:

- **E1 (책임 재정의)**: 해당 없음 — agent/hook 신규 없음
- **E2 (신규 추가)**: 해당 없음
- **E3 (분할)**: 해당 없음
- **E4 (통합)**: R1+R2 동일 파일 동일 유형 → single phase 번들 적용 (E4 정합)
- **E5 (삭제)**: 해당 없음

**4 case 충돌 매트릭스** (built-in command 충돌 여부):

- C1/C2 mix 유지: cycle 3 대비 변동 없음 — 본 proposal은 CLAUDE.md 서술 정정이므로 built-in command 충돌 없음
- C3 (spike-investigator): 해당 없음

**권장 결정**: ACCEPT — LOW severity narrative cleanup, Edit 2회(R1+R2 각 1회), 리스크 없음.

### 사용자 명시 결정 필요 (e3 정책)

- [ ] **Accept** — component-installer 가 R1+R2 Edit apply (다음 milestone 또는 즉시 inline)
- [ ] **Reject** — proposal 폐기 (stale narrative 유지)
- [ ] **Modify** — 수정 사항 명시 후 재 proposal (예: Option B 선택, 라인 번호 확인 후 재검토 등)

---

## ACCEPT ALL 권고 narrative

본 cycle 4 proposal은 2건 모두 **LOW severity narrative-only cleanup**이다.

- 실 동작(hook 실행, MCP 서버 연결, pre-commit 작동)에 영향 없음
- cycle 3 G1/G2/G3/S2 ACCEPT ALL 패턴과 동질 — 문서 정합성 회복
- Edit 2회로 완결 가능, 별도 테스트 불요
- 거부 시 v5.0+ Plugin spec 전환 이후 지속되는 경로 서술 불일치가 잔존

**권장**: R1+R2 bundled ACCEPT → component-installer inline apply (v5.15 단일 phase 마무리).

---

## decision matrix

| id | 내용 | accept | reject | modify |
|---|---|---|---|---|
| R1 (bundled) | post-edit-syntax-check 경로 + mcp 서술 정정 | [ ] | [ ] | [ ] |
| R2 (bundled) | v1.20 forward reference → v1.12 대체 | [ ] | [ ] | [ ] |

> R1+R2는 단일 phase 번들. Accept/Reject는 묶음 결정 권장. Modify 시 항목별 명시 가능.

---

## fleet evolution candidates (별 milestone — PROPOSE 거명만)

| id | 거명 | trigger 조건 | 현재 상태 |
|---|---|---|---|
| F4 | harness-cost-tracker SPIKE 독립 재평가 | 사용자 명시 발의 | scope 외 — 본 milestone 포함 안 함 |

> F4는 본 cycle 4 scope 외. PROPOSE stage에서 next_candidates 거명 예정. 사용자 명시 발의 시 별 milestone 신규 등재.

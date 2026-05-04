# meta v1.57-hook-notebookedit — PLAN

세션 시작: 2026-05-04
선행 세션: [`sessions/meta/v1.40-multiedit-trigger/`](../v1.40-multiedit-trigger/PLAN.md) (MultiEdit 지원) · [`sessions/meta/v1.54-hook-debug-log/`](../v1.54-hook-debug-log/PLAN.md) (stderr WARN 추가)

목적: `post-report-write.sh` PostToolUse hook에 **NotebookEdit** 도구 지원 추가. 현재 `Write|Edit|MultiEdit`만 감지하는 matcher를 `NotebookEdit`까지 확장. NotebookEdit은 `file_path` 대신 `notebook_path` 파라미터를 사용하므로 Python 파서 + grep fallback 양쪽 수정 필요.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1a(2) `claude/hooks/post-report-write.sh` + `install.ps1` · S3(3) `verify.ps1` + `verify.sh` + `tests/smoke-posttooluse-hook.sh` = **5/5 meta**
- **T1 경로 다수결** — S1a + S3 = 5/5 meta scope
- **T2 스펙 vs 값** — hook matcher 확장은 글로벌 레이어 인터페이스 변경 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.40-multiedit-trigger/REPORT.md` "다음 후보 (보류)" 표** (verbatim):

> | Delete / NotebookEdit 등 추가 파일 수정 도구 | evidence-driven |

**Parsed sub-items (1)**:

1. **Delete / NotebookEdit 추가 파일 수정 도구 지원** — `post-report-write.sh` hook이 현재 지원하지 않는 도구(Delete, NotebookEdit)도 감지하도록 확장 (evidence-driven)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| **Delete 도구 지원** | 의미론적 제외 (Delete = REPORT.md 삭제 → roadmap update 불필요. Write가 재작성 시 이미 발화) |
| `Bash` 통한 REPORT.md 작성 감지 | 별 후속 (evidence-driven — PostToolUse hook은 file tool에 특화) |
| REPORT.ipynb 섹션 추출 (notebook cell 파싱) | 별 후속 (evidence-driven. 현 구현은 `has_markers=True` 기본값으로 보수적 처리) |
| `v1.39b` smoke hook 확장 | 별 세션 (trigger 조건 미충족) |
| `v1.40d` PLAN.md 등 패턴 확장 | 별 세션 (trigger 조건 미충족) |
| MSG `"REPORT.md write detected"` `.ipynb` 편집 시 오도적 | v1.57b (evidence-driven. 현재 기능 동작에 영향 없음) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | NotebookEdit tool_name, PostToolUse hook, tool_input.notebook_path, file_path 공존 여부 |
| **findings** | see citations below |
| **drift** | no — `NotebookEditInput.notebook_path` 공식 확인. `file_path` 필드 없음(공존 불가). `tool_response.success` 동일 패턴. PLAN 결정과 정합 |
| **re-verify** | Claude Code NotebookEdit tool_input 스펙 변경 시 (notebook_path 필드명 또는 구조 변경) |

**Citations**:

- C1 — `NotebookEditInput.notebook_path: string` — 공식 입력 스키마 확인, `file_path` 필드 없음 (Source: `https://code.claude.com/docs/en/agent-sdk/typescript`)
- C2 — `PostToolUseHookInput.tool_input: dict[str, Any]` — hook에서 tool_input 직접 접근 확인 (Source: `https://code.claude.com/docs/en/agent-sdk/python`)
- C3 — PostToolUse hook example: `"tool_response": {"success": true}` — success 필드 패턴 동일 (Source: `https://code.claude.com/docs/en/hooks`)

## 1. 배경

v1.40에서 `Write|Edit|MultiEdit` 3 도구를 감지하게 됐다. 당시 REPORT에서 "Delete / NotebookEdit 등 추가 파일 수정 도구" 를 `evidence-driven` 보류 항목으로 등록했다. 사용자가 이번 세션으로 진행 결정.

`NotebookEdit`는 Jupyter notebook(`.ipynb`) 편집 도구다. `file_path` 대신 **`notebook_path`** 파라미터를 사용하므로:

- 현재 Python 파서: `d.get("tool_input", {}).get("file_path", "")` → `notebook_path` 누락
- 현재 grep fallback: `grep -o '"file_path":"[^"]*"'` → `notebook_path` 누락
- 현재 case 매처: `Write|Edit|MultiEdit)` → NotebookEdit 제외

감지 패턴도 `REPORT\.md$` → `REPORT\.(md|ipynb)$` 로 확장이 필요하다(notebooks는 `.ipynb` 파일).

**Delete 제외 이유**: 삭제는 REPORT 작성 완료 신호가 아니다. Claude가 REPORT.md를 Delete 후 Write로 재작성하는 경우, Write hook이 발화한다. Delete만 단독으로 발화해야 할 근거 없음.

## 2. 결정 (R1 ~ R3)

### R1 — hook case 매처 + 파싱 확장

**`claude/hooks/post-report-write.sh`**:

**case 매처**:

```bash
case "$TOOL_NAME" in
    Write|Edit|MultiEdit|NotebookEdit) ;;   # v1.57: NotebookEdit 추가
    *) printf '%s\n' "$NOOP"; exit 0 ;;
esac
```

**Python 파서 변경** (2개소):

1. `file_path` 추출 분기 추가:

```python
# NotebookEdit은 notebook_path, 그 외는 file_path
if t == "NotebookEdit":
    f = d.get("tool_input", {}).get("notebook_path", "")
else:
    f = d.get("tool_input", {}).get("file_path", "")
```

2. `has_markers` 처리 (NotebookEdit: 보수적 True) — **`has_edits` 블록 이후에 삽입**해 edits 키 유무와 무관하게 강제 오버라이드:

```python
# has_edits 블록 이후에 위치 — NotebookEdit은 edits 없으므로 보수적 True 강제
if t == "NotebookEdit":
    has_markers = True
```

3. 섹션 추출 — NotebookEdit은 `secs` 빈 리스트 (cell source 파싱 미구현):

```python
elif t == "NotebookEdit":
    pass  # notebook cell 섹션 추출 미구현 (v1.57 scope 외)
```

**grep fallback 변경**: `TOOL_NAME` 추출 후 `FILE_PATH` 빈값이고 tool이 NotebookEdit이면 `notebook_path` 그랩:

```bash
# NotebookEdit fallback: notebook_path 추출
if [ -z "$FILE_PATH" ] && [ "$TOOL_NAME" = "NotebookEdit" ]; then
    FILE_PATH=$(printf '%s' "$INPUT" | grep -o '"notebook_path":"[^"]*"' | head -1 \
                | sed 's/^"notebook_path":"//;s/"$//' | tr '\\' '/') || FILE_PATH=''
fi
```

**패턴 확장**:

```bash
printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/REPORT\.(md|ipynb)$'
```

**헤더 갱신**:

```bash
# v1.57  — NotebookEdit: notebook_path 추출 + REPORT.(md|ipynb) 패턴 확장.
```

### R2 — install.ps1 matcher 갱신 (3단계 migration 패턴)

```powershell
$ourMatcher    = 'Edit|Write|MultiEdit|NotebookEdit'  # v1.57: NotebookEdit 추가
$legacyMatcher = 'Edit|Write|MultiEdit'               # v1.40 구 matcher
```

3단계 migration:

1. 신규 matcher(`Edit|Write|MultiEdit|NotebookEdit`) 탐색 → 발견 시 no-op
2. 미발견 + legacy(`Edit|Write|MultiEdit`) + 동일 command → in-place 교체 (migration)
3. 미발견 + legacy 미발견 → append

**추가 갱신 (Arch Review 지적 #1)**: 하드코딩된 `Write-Info/Err/Warn/Ok` 메시지 4개소도 `Edit|Write|MultiEdit|NotebookEdit`로 갱신:

- `Write-Info "PostToolUse[Edit|Write|MultiEdit] 이미 등록됨 (no-op)"` → `...NotebookEdit...`
- `Write-Err "PostToolUse[Edit|Write|MultiEdit]에 이미 다른 command..."` → `...NotebookEdit...`
- `Write-Warn "PostToolUse[Edit|Write|MultiEdit] 덮어쓰기 (-Force)"` → `...NotebookEdit...`
- `Write-Ok "PostToolUse[Edit|Write|MultiEdit] 추가..."` → `...NotebookEdit...`

### R3 — verify.ps1 + verify.sh Stage J 갱신

**verify.ps1** (3개소):

- `.DESCRIPTION` 블록 (18번째 줄): `PostToolUse[Edit|Write|MultiEdit]` → `PostToolUse[Edit|Write|MultiEdit|NotebookEdit]`
- `Write-Host "== J. PostToolUse[Edit|Write|MultiEdit] 등록 =="` → `...NotebookEdit...`
- J2: `$_.matcher -eq 'Edit|Write|MultiEdit|NotebookEdit'`

**verify.sh** (3개소):

- 주석 헤더 (18번째 줄): `PostToolUse[Edit|Write|MultiEdit]` → `PostToolUse[Edit|Write|MultiEdit|NotebookEdit]`
- `echo "== J. PostToolUse[Edit|Write|MultiEdit] 등록 =="` → `...NotebookEdit...`
- python3 경로: `e.get("matcher")=="Edit|Write|MultiEdit|NotebookEdit"`
- jq fallback: `select(.value.matcher == "Edit|Write|MultiEdit|NotebookEdit")`

## 3. 변경 대상 (5 수정)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | S1a | R1 — 헤더 + case + Python 파서 + grep fallback + 패턴 확장 |
| `install.ps1` | S1a | R2 — ourMatcher/legacyMatcher 갱신 + 3단계 migration |
| `verify.ps1` | S3 | R3 — Stage J 헤더 + J2 matcher string |
| `verify.sh` | S3 | R3 — Stage J 헤더 + J2 python3/jq 양쪽 |
| `tests/smoke-posttooluse-hook.sh` | S3 | R4 — S2 grep 갱신 + Test M + Test N (15→17) |

## 4. Smoke 설계 (R4)

**S2 정적 갱신** (2개소):

- `grep -q "Edit|Write|MultiEdit"` → `grep -q "Edit|Write|MultiEdit|NotebookEdit"`
- ok/fail 메시지: `"(Edit|Write|MultiEdit)"` → `"(Edit|Write|MultiEdit|NotebookEdit)"`

**Test M — NotebookEdit + REPORT.ipynb → additionalContext** (신규):

```bash
M_IN='{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"/home/user/harness-meta/sessions/meta/v1.57-test/REPORT.ipynb"},"tool_response":{"success":true}}'
# → additionalContext 포함 + harness-roadmap-update 포함
```

**Test N — NotebookEdit + non-REPORT notebook → NOOP** (신규):

```bash
N_IN='{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"/home/user/harness-meta/some/other/notebook.ipynb"},"tool_response":{"success":true}}'
# → '{}'
```

헤더 갱신: `15/15` → `17/17`, `A~L` → `A~N`.

## 5. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [x] **Plan-verify (context7 spec 검증)** — drift=no, C1~C3
- [ ] **사용자 PLAN 확정**
- [ ] Stage A — `post-report-write.sh` (R1 전체)
- [ ] Stage B — `install.ps1` (R2 matcher 갱신)
- [ ] Stage C — `verify.ps1` (R3 Stage J)
- [ ] Stage D — `verify.sh` (R3 Stage J)
- [ ] Stage E — `smoke-posttooluse-hook.sh` (R4 S2 + Test M+N)
- [ ] 전체 smoke 회귀 확인
- [ ] REPORT.md 작성
- [ ] 커밋 (사용자 확인 후)

## 6. 성공 기준

- [ ] `smoke-posttooluse-hook.sh` 17/17 PASS (기존 15 + 신규 M+N)
- [ ] NotebookEdit + REPORT.ipynb path → additionalContext (Test M)
- [ ] NotebookEdit + non-REPORT → `{}` (Test N)
- [ ] install.ps1 재실행: `Edit|Write|MultiEdit` → `Edit|Write|MultiEdit|NotebookEdit` in-place
- [ ] verify.ps1/sh Stage J 갱신 (matcher string 정합)
- [ ] 회귀 0 — 기존 Test A~L 유지

## 7. 커밋 전략

```
feat(meta): v1.57-hook-notebookedit — PostToolUse hook NotebookEdit 지원

- update: claude/hooks/post-report-write.sh (R1 — NotebookEdit case + notebook_path 추출 + REPORT.(md|ipynb) 패턴)
- update: install.ps1 (R2 — ourMatcher NotebookEdit 추가 + legacy migration)
- update: verify.ps1 (R3 — Stage J NotebookEdit matcher)
- update: verify.sh (R3 — 동상)
- update: tests/smoke-posttooluse-hook.sh (R4 — Test M+N 신규, 15→17)
- add: sessions/meta/v1.57-hook-notebookedit/{PLAN,REPORT}.md

ROADMAP §3-B v1.40c-hook-more-tools trigger 이행.
Delete 제외 (의미론적 — REPORT 삭제는 작성 완료 신호 아님).
smoke 17/17 + 회귀 0.
```

## 8. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.40d-hook-pattern-expand` | PLAN.md 등 다른 파일 패턴 확장 evidence |
| `v1.57b-hook-notebookedit-cell-extract` | REPORT.ipynb 실사용 + cell source에서 섹션명 추출 요구 evidence |

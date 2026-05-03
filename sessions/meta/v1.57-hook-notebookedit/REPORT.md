# meta v1.57-hook-notebookedit — REPORT

세션 완료: 2026-05-04
선행 세션: [`sessions/meta/v1.40-multiedit-trigger/`](../v1.40-multiedit-trigger/) · [`sessions/meta/v1.54-hook-debug-log/`](../v1.54-hook-debug-log/)

## 최종 결과

- 테스트: `smoke-posttooluse-hook.sh` **17/17 PASS** (기존 15 + 신규 M+N)
- verify.ps1 **43/43 PASS** (Stage J `Edit|Write|MultiEdit|NotebookEdit` 정합)
- install.ps1 재실행: legacy `Edit|Write|MultiEdit` → 신규 `Edit|Write|MultiEdit|NotebookEdit` in-place migration 정상
- 변경 파일: 5 파일 (hook.sh / install.ps1 / verify.ps1 / verify.sh / smoke)
- 회귀 0 — smoke-spec-verification 360/360 + smoke-scope-contract 134/134 + smoke-roi-regression 6/6 PASS

## 구현 요약

| 목표 | 구현 | 상태 |
|------|------|------|
| `post-report-write.sh` case + Python `notebook_path` 분기 + grep fallback + 패턴 확장 | R1 5개소 갱신 (헤더 v1.57 / case `\|NotebookEdit` / Python notebook_path 분기 / has_markers 강제 True / grep notebook_path fallback / 패턴 `REPORT\.(md\|ipynb)$`) | ✅ |
| `install.ps1` matcher + 4 메시지 갱신 | R2 — `ourMatcher='Edit\|Write\|MultiEdit\|NotebookEdit'` + `legacyMatcher='Edit\|Write\|MultiEdit'` + Write-Info/Err/Warn/Ok 4 리터럴 갱신 | ✅ |
| `verify.ps1` Stage J 갱신 | R3 — `.DESCRIPTION` 18줄 + Write-Host 헤더 + J2 matcher 3개소 | ✅ |
| `verify.sh` Stage J 갱신 | R3 — 주석 18줄 + echo 헤더 + python3/jq 양쪽 4개소 | ✅ |
| `smoke-posttooluse-hook.sh` Test M+N (15→17) | R4 — 헤더 갱신 + S2 grep+ok 메시지 갱신 + Stage 2 14 + Test M (NotebookEdit + REPORT.ipynb) + Test N (NotebookEdit + non-REPORT) | ✅ |

### 세부 변경

**Stage A — `claude/hooks/post-report-write.sh`** (5개소):

```bash
# 1) 헤더 추가
# v1.57  — NotebookEdit: notebook_path 추출 + REPORT.(md|ipynb) 패턴 확장.

# 2) Python: NotebookEdit notebook_path 분기 (file_path 대신)
if t == "NotebookEdit":
    f = d.get("tool_input", {}).get("notebook_path", "")
else:
    f = d.get("tool_input", {}).get("file_path", "")

# 3) Python: has_markers 보수적 True (has_edits 블록 이후 강제 오버라이드)
if t == "NotebookEdit":
    has_markers = True

# 4) Python: 섹션 추출 분기 (no-op — Out of scope)
elif t == "NotebookEdit":
    pass

# 5) grep fallback: notebook_path 보강 + has_markers 강제 True
if [ -z "$FILE_PATH" ] && [ "$TOOL_NAME" = 'NotebookEdit' ]; then
    FILE_PATH=$(... grep '"notebook_path":"...' ...)
fi
if [ "$TOOL_NAME" = 'NotebookEdit' ]; then
    HAS_MARKERS='true'
fi

# 6) case 매처 + 패턴 확장
case "$TOOL_NAME" in
    Write|Edit|MultiEdit|NotebookEdit) ;;
    ...
grep -qE 'sessions/[^/]+/[^/]+/REPORT\.(md|ipynb)$'
```

**Stage B — `install.ps1`** (5개소):
- `$ourMatcher = 'Edit|Write|MultiEdit|NotebookEdit'` (v1.57 신규)
- `$legacyMatcher = 'Edit|Write|MultiEdit'` (v1.40 → migration)
- `Write-Info/Err/Warn/Ok` 4 리터럴: `Edit|Write|MultiEdit` → `Edit|Write|MultiEdit|NotebookEdit`
- migration 메시지: `(v1.40 migration)` → `(v1.57 migration)`

**Stage C — `verify.ps1`** (3개소):
- `.DESCRIPTION` 18줄 헤더 갱신
- `Write-Host "== J. PostToolUse[Edit|Write|MultiEdit|NotebookEdit] 등록 =="`
- J2 `Where-Object { $_.matcher -eq 'Edit|Write|MultiEdit|NotebookEdit' }` + 메시지 2건

**Stage D — `verify.sh`** (4개소):
- 주석 18줄 헤더
- `echo "== J. PostToolUse[Edit|Write|MultiEdit|NotebookEdit] 등록 =="`
- python3 경로: `e.get("matcher")=="Edit|Write|MultiEdit|NotebookEdit"`
- jq fallback: `select(.value.matcher == "Edit|Write|MultiEdit|NotebookEdit")` + 메시지

**Stage E — `tests/smoke-posttooluse-hook.sh`** (4개소):
- 헤더 v1.57 추가, `15/15` → `17/17`, `A~L` → `A~N`
- S2 grep + ok/fail 메시지: `Edit|Write|MultiEdit|NotebookEdit`
- Stage 2 헤더: `(7)` → `(14)`
- Test M: NotebookEdit + REPORT.ipynb (notebook_path) → additionalContext + harness-roadmap-update
- Test N: NotebookEdit + non-REPORT notebook → `{}`

## 판정

| 성공 기준 | 결과 |
|---------|------|
| smoke-posttooluse-hook.sh 17/17 PASS | ✅ |
| NotebookEdit + REPORT.ipynb path → additionalContext (Test M) | ✅ |
| NotebookEdit + non-REPORT → `{}` (Test N) | ✅ |
| install.ps1 재실행: `Edit\|Write\|MultiEdit` → `Edit\|Write\|MultiEdit\|NotebookEdit` in-place | ✅ (실행 로그 `(v1.57 migration)` 확인) |
| verify.ps1/sh Stage J 갱신 (matcher string 정합) | ✅ (verify.ps1 43/43 PASS) |
| 회귀 0 — 기존 Test A~L 유지 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | NotebookEdit tool_name, PostToolUse hook, tool_input.notebook_path, file_path 공존 여부 |
| **findings** | no new findings |
| **drift** | no — `NotebookEditInput.notebook_path` 공식 확인, `file_path` 필드 없음(공존 불가). PLAN drift=no 유지 |
| **re-verify** | Claude Code NotebookEdit tool_input 스펙 변경 시 (notebook_path 필드명 또는 구조 변경) |

## Lessons Learned

- **L1** — 3 관점 병렬 검토(architecture / scope contract / regression risk)에서 architecture 관점이 install.ps1 하드코딩 메시지 4개소 + verify.ps1/sh `.DESCRIPTION`/주석 18줄 + smoke S2 메시지 등 **PLAN 작성 시 놓친 변경점 4건을 추가 발견**. 다각적 검토의 가치 재확인.
- **L2** — Architecture 관점이 지적한 `file_path` 공존 우려는 context7 `NotebookEditInput` 스키마 확인으로 **즉시 해소** (필드 자체가 없음). Spec verification §의 가치 — 추측이 아니라 권위 source로 검증.
- **L3** — install.ps1 3단계 migration 패턴(신규 탐색 → legacy in-place → append)이 v1.36b → v1.40 → v1.57 3회 연속 회귀 0 보존. 패턴 답습의 검증된 가치.
- **L4** — has_markers 오버라이드를 `has_edits` 블록 **이후**에 위치시키는 명시적 결정. python 코드 라인 순서가 의미를 결정하는 케이스 — PLAN에서 "삽입 위치"를 명시하지 않으면 구현 시 오류 가능.

## 다음 후보 (보류)

| 항목 | trigger 종류 | trigger |
|------|:----------:|---------|
| `v1.57b-hook-notebookedit-cell-extract` | A | REPORT.ipynb 실사용 + cell source에서 섹션명 추출 요구 evidence |
| `v1.57c-hook-msg-dynamic-filename` | E | MSG `"REPORT.md write detected"` `.ipynb` 편집 시 오도적 — 동적 파일명 반영 요구 |
| `v1.40d-hook-pattern-expand` | B | PLAN.md / ROADMAP.md 등 다른 파일 패턴 확장 evidence |
| `v1.39b-hooks-expand` | B | pre-commit에 smoke-posttooluse-hook.sh 등 다른 hook 포함 (실패 빈도 evidence 누적 후) |

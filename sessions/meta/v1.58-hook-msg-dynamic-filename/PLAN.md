# meta v1.58-hook-msg-dynamic-filename — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.57-hook-notebookedit/`](../v1.57-hook-notebookedit/)
ROADMAP 출처: `sessions/meta/ROADMAP.md` §3-E `v1.57d-hook-msg-dynamic-filename`

목적: `post-report-write.sh`의 additionalContext MSG에서 `"REPORT.md write detected"`로 하드코딩된 파일명을 실제 감지된 파일명(`REPORT.md` 또는 `REPORT.ipynb` 등)으로 동적 치환.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` + S3(1) `tests/smoke-posttooluse-hook.sh` = **2/2 meta**
- T1 경로 다수결 — meta scope 100%

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-E (verbatim)**:

> `v1.57d-hook-msg-dynamic-filename` | MSG `"REPORT.md write detected"` `.ipynb` 편집 시 오도적 — 동적 파일명 반영 요구 | `v1.57 REPORT`

**Parsed sub-items (1)**:

1. **MSG 동적 파일명** — additionalContext MSG의 `"REPORT.md write detected"` 하드코딩을 `NORM_PATH` basename으로 치환

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| NotebookEdit cell 섹션명 추출 | `v1.57b` (evidence-driven) |
| Bash 경로 hook 미발화 해소 | `v1.57c` (evidence-driven) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (hook 내부 MSG 문자열 치환만) |
| **re-verify** | N/A |

## 1. 문제

`post-report-write.sh` 135~139줄:

```bash
if [ -n "$SECTIONS" ]; then
    MSG="REPORT.md write detected (sections: ${SECTIONS}). ..."
else
    MSG="REPORT.md write detected. ..."
fi
```

`NORM_PATH`가 `sessions/meta/v1.58-.../REPORT.ipynb`인 경우에도 MSG는 `REPORT.md write detected`를 출력 → 사용자에게 오도적.

## 2. 수정 (변경 2곳)

### 2-1. `claude/hooks/post-report-write.sh`

`NORM_PATH` 계산 직후(`basename` 추출) + MSG 치환:

```bash
# ── path 정규화 + REPORT.(md|ipynb) 패턴 ──
NORM_PATH=$(printf '%s' "$FILE_PATH" | tr '\\' '/')
printf '%s' "$NORM_PATH" | grep -qE 'sessions/[^/]+/[^/]+/REPORT\.(md|ipynb)$' \
    || { printf '%s\n' "$NOOP"; exit 0; }

# ── 동적 파일명 추출 (v1.58) ─────────────────────────────────────────────────
REPORT_BASENAME=$(basename "$NORM_PATH")
```

MSG 부분:
```bash
if [ -n "$SECTIONS" ]; then
    MSG="${REPORT_BASENAME} write detected (sections: ${SECTIONS}). ..."
else
    MSG="${REPORT_BASENAME} write detected. ..."
fi
```

헤더 주석 1줄 추가: `# v1.58  — REPORT_BASENAME: 동적 파일명 (REPORT.md|REPORT.ipynb) 반영.`

### 2-2. `tests/smoke-posttooluse-hook.sh`

Test O 신규 추가: NotebookEdit + REPORT.ipynb → MSG에 `REPORT.ipynb` 포함 검증.

```bash
# Test O — NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 포함 (v1.58 동적 파일명)
O_NB_PATH='/home/user/harness-meta/sessions/meta/v1.57-test/REPORT.ipynb'
O_IN=$(printf '{"tool_name":"NotebookEdit","tool_input":{"notebook_path":"%s","new_source":"## 판정","cell_type":"markdown","edit_mode":"replace"},"tool_response":{"success":true}}' "$O_NB_PATH")
O_OUT=$(run_hook "$O_IN")
if printf '%s' "$O_OUT" | grep -q "REPORT.ipynb"; then
    ok "O: NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 포함 (v1.58 동적 파일명)"
else
    fail "O: NotebookEdit + REPORT.ipynb → MSG에 'REPORT.ipynb' 없음. got: $O_OUT"
fi
```

헤더 주석 갱신: `v1.58: Test O (NotebookEdit + MSG에 REPORT.ipynb 포함)` + 카운트 `18/18`.

## 3. 변경 대상 (2 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | S1a | REPORT_BASENAME 추출 + MSG 치환 (2개소) + 헤더 1줄 |
| `tests/smoke-posttooluse-hook.sh` | S3 | Test O 신규 + 헤더/카운트 갱신 |

## 4. 목표

- [ ] 세션 디렉토리 + PLAN.md 생성
- [ ] 사용자 PLAN 확인
- [ ] hook 수정 (REPORT_BASENAME + MSG 2개소)
- [ ] smoke Test O 추가
- [ ] smoke 18/18 PASS 검증
- [ ] REPORT.md 작성
- [ ] ROADMAP 갱신
- [ ] 커밋

## 5. 성공 기준

- [ ] `REPORT.ipynb` 감지 시 MSG에 `REPORT.ipynb write detected` 포함
- [ ] `REPORT.md` 감지 시 MSG에 `REPORT.md write detected` 포함 (회귀 0)
- [ ] smoke 18/18 PASS (Test O 신규 1 포함)
- [ ] 기존 A~N 17 테스트 회귀 0

## 6. 커밋 전략

```
fix(meta): v1.58-hook-msg-dynamic-filename — MSG 동적 파일명 반영

- update: claude/hooks/post-report-write.sh — REPORT_BASENAME 추출 + MSG 2개소 치환
- update: tests/smoke-posttooluse-hook.sh — Test O 신규 (REPORT.ipynb MSG 검증, 18/18)

ROADMAP §3-E v1.57d trigger 이행.
회귀 0 (A~N 17 tests).
```

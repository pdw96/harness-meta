# meta v1.41-multiedit-content-filter — PLAN

세션 시작: 2026-05-01
선행 세션: [`sessions/meta/v1.40-multiedit-trigger/`](../v1.40-multiedit-trigger/)

목적: `post-report-write.sh`에서 MultiEdit의 `tool_input.edits` 배열을 읽어 `new_string` 콘텐츠에 섹션 마커(`## `)가 존재하는지 검사. 마커 없으면 NOOP (false positive 필터). Write / Edit 는 기존 동작 유지.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` + S3(1) `tests/smoke-posttooluse-hook.sh` = **2/2 meta**
- **T1 경로 다수결** — 글로벌 hook + smoke = meta scope 2/2

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.40-multiedit-trigger/REPORT.md` 다음 후보 표** (verbatim):

> | MultiEdit `edits` 배열 내 콘텐츠 검사 | evidence-driven |

**Parsed sub-items (2)**:

1. **edits 배열 콘텐츠 검사** — MultiEdit `tool_input.edits[*].new_string`에서 REPORT 섹션 마커(`## `) 유무 확인
2. **false positive 필터** — 마커 없는 경우(typo 수정 등 소소한 편집) NOOP 처리

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Edit tool의 new_string 콘텐츠 검사 | evidence-driven 후속 |
| Write tool의 content 필드 검사 | evidence-driven 후속 |
| 섹션 마커 기반 메시지 강화 (감지된 섹션명 포함) | 후속 세션 (v1.41b) |
| Delete / NotebookEdit 도구 지원 (v1.40c) | evidence-driven 후속 |
| REPORT.md 외 파일 패턴 확장 (v1.40d) | evidence-driven 후속 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | MultiEdit tool_input.edits 구조, new_string 필드, PostToolUse tool_input |
| **findings** | see citations below |
| **drift** | no — MultiEdit `edits` 배열 스키마 공식 문서 미공개이나 v1.40 실 동작 검증으로 구조 확인. 문서 부재 = spec drift 아님 |
| **re-verify** | MultiEdit tool_input 구조가 공식 문서에 추가되거나 변경 시 |

**Citations**:
- C1 — Claude Code hooks 공식 문서에 MultiEdit tool_input.edits 배열 스키마 미공개. Edit 도구만 `{file_path, old_string, new_string}` 명시. (Source: `https://code.claude.com/docs/en/hooks`)

## 1. 문제

`post-report-write.sh` (v1.40)는 MultiEdit + REPORT.md path 매칭만으로 ROADMAP 갱신 안내를 trigger함. REPORT.md에 작은 수정(typo fix, whitespace 조정 등)도 같은 trigger를 발생시켜 불필요한 사용자 noise 유발.

MultiEdit의 `tool_input.edits` 배열에는 각 편집의 `new_string`이 포함되어 있어, 이 콘텐츠를 검사하면 "의미 있는 REPORT 작성"과 "소소한 수정"을 구분 가능.

## 2. 결정

### R1 — 콘텐츠 가드 로직

| 조건 | 동작 |
|------|------|
| MultiEdit + REPORT.md + edits 있음 + 마커 있음 | trigger (기존과 동일) |
| MultiEdit + REPORT.md + edits 있음 + 마커 없음 | NOOP (신규 필터) |
| MultiEdit + REPORT.md + edits 없음 | trigger (보수적 — edits 부재 시 필터 미적용) |
| Write / Edit + REPORT.md | trigger (기존 동작 완전 유지) |

**마커 기준**: `## ` (Markdown 레벨-2 섹션 헤더 시작). REPORT.md의 핵심 섹션(`## 최종 결과`, `## 판정`, `## Lessons Learned` 등) 모두 해당.

### R2 — python3 경로 변경

4번째 출력 라인 `has_markers` 추가 (기존 3 → 4 라인):

```python
edits = d.get("tool_input", {}).get("edits", [])
has_edits = len(edits) > 0
# conservative: edits 없으면 필터 미적용
has_markers = (not has_edits)
if has_edits:
    combined = " ".join(e.get("new_string", "") for e in edits)
    has_markers = "## " in combined
print(t)
print(f)
print("true" if s is True else "false")
print("true" if has_markers else "false")
```

bash 코드 갱신 (3 → 4 라인):
```bash
TOOL_NAME=$(printf '%s' "$_result" | sed -n '1p')
FILE_PATH=$(printf '%s' "$_result" | sed -n '2p')
SUCCESS=$(printf '%s' "$_result" | sed -n '3p')
HAS_MARKERS=$(printf '%s' "$_result" | sed -n '4p')
```

초기값 `HAS_MARKERS=true` (python3 실패 시 보수적 trigger 유지). grep fallback도 `HAS_MARKERS` 갱신.

### R3 — grep+sed fallback 변경

```bash
# edits 배열 존재 여부 + new_string 내 ## 마커 검사
if printf '%s' "$INPUT" | grep -q '"edits"'; then
    _m=$(printf '%s' "$INPUT" | grep -oE '"new_string":"[^"]*"' \
         | grep -c '## ' 2>/dev/null) || _m=0
    [ "$_m" -gt 0 ] && HAS_MARKERS=true || HAS_MARKERS=false
fi
# edits 키 없으면 HAS_MARKERS=true (초기값 유지 — 보수적)
```

**한계**: `new_string`에 내부 이중따옴표 포함 시 grep 매칭 오동작 가능. python3 경로에서 정확히 처리되므로 fallback 수용 가능.

### R4 — 가드 위치

path 매칭 직후, message 생성 직전:

```bash
# ── MultiEdit 콘텐츠 가드 ─────────────────────────────────────────────────────
if [ "$TOOL_NAME" = 'MultiEdit' ] && [ "$HAS_MARKERS" = 'false' ]; then
    printf '%s\n' "$NOOP"
    exit 0
fi
```

### R5 — Smoke 테스트 (10→12)

| Test | 입력 | 기대 |
|------|------|------|
| H (신규) | MultiEdit + REPORT.md + edits `{"new_string":"## 판정\n..."}` | additionalContext 포함 |
| I (신규) | MultiEdit + REPORT.md + edits `{"new_string":"typo fix"}` | no-op `{}` |

기존 Test F (edits 없음) → 보수적 동작으로 여전히 trigger. **회귀 0**.

## 3. 변경 대상 (2 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | S1a | R2/R3/R4 — python3 4라인 출력 + HAS_MARKERS 변수 + grep fallback + 콘텐츠 가드 |
| `tests/smoke-posttooluse-hook.sh` | S3 | R5 — Test H + I 추가 (10→12), 헤더 갱신 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 초안 작성
- [ ] Spec verification (context7) § 채우기
- [ ] 사용자 PLAN 확정
- [ ] Stage A — `post-report-write.sh` 콘텐츠 가드 구현
- [ ] Stage B — `smoke-posttooluse-hook.sh` Test H + I 추가
- [ ] Stage C — smoke 12/12 PASS 확인
- [ ] REPORT.md 작성
- [ ] 커밋

## 5. 성공 기준

- [ ] Test H: MultiEdit + REPORT.md + edits with `## 판정` → additionalContext 포함
- [ ] Test I: MultiEdit + REPORT.md + edits without `## ` → `{}`
- [ ] Test F: MultiEdit + REPORT.md + edits 없음 → additionalContext 포함 (회귀 0)
- [ ] Test A~G 전체 PASS (회귀 0)
- [ ] smoke 12/12 PASS

## 6. 커밋 전략

```
feat(meta): v1.41-multiedit-content-filter — MultiEdit edits 콘텐츠 가드

- update: claude/hooks/post-report-write.sh — MultiEdit edits.new_string '## ' 마커 검사.
  edits 없으면 보수적 trigger 유지. 마커 없으면 NOOP.
- update: tests/smoke-posttooluse-hook.sh — Test H(마커 있음→trigger) + I(마커 없음→NOOP) (10→12)
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.41b-content-message-enhance` | 감지된 섹션명을 additionalContext 메시지에 포함. evidence-driven |
| `v1.40c-hook-more-tools` | Delete / NotebookEdit 지원 evidence |
| `v1.40d-hook-pattern-expand` | PLAN.md 등 패턴 확장 evidence |

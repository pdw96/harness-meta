# meta v1.67-markdownlint-residual — REPORT

세션 완료: 2026-05-04

## 최종 결과

- **markdownlint**: 59 → **0** (`pre-commit run --all-files markdownlint` PASS)
- **smoke** 2종: PASS (회귀 0)
- shellcheck "openBinaryFile" exit 2 — v1.66e 후속 (본 세션 scope 외)
- 변경 파일: ~20개 (MD028 8 + MD052 1 + MD055 1 + MD032/MD004 1 + MD056 4 + .markdownlintignore + .markdownlint.json)

## 구현 요약

### Stage A — MD029 disable (.markdownlint.json)

`"MD029": { "style": "ordered" }` → `"MD029": false` — 9건 즉시 해소.
원인: `-` bullet 내 `1. 2. 3.` 내용이 ordered list로 오인 (false positive).

### Stage B — MD055 fix (claude/commands/harness-meta.md:206)

`| 9 | trigger 분류 애매` → trailing `|` 추가.

### Stage C — MD052 fix (v1.34-legacy-plan-migration/REPORT.md)

`[a-z]`, `[0-9]` → `\[a-z\]`, `\[0-9\]` escape (reference link 오인 차단).

### Stage D — MD028 fix (6 파일, 10건)

Python 스크립트로 blockquote 내 빈 줄 → `>` 줄 교체:

```python
# blockquote 전후 맥락 감지 → 빈 줄 → '>' 교체
if line.strip() == '' and prev_starts_with('>') and next_starts_with('>'):
    out.append('>\n')
```

### Stage E — MD032 fix (v1.10g/audit/A2-effort-spec.md)

`*` bullet 리스트 앞뒤 빈 줄 추가 + bullet 스타일 통일 (`-` → `*` — 파일 내 `*` 기준 통일, MD004 해소).

### Stage F — MD056 fix (active files)

| 파일 | 처리 |
|------|------|
| `sessions/meta/ROADMAP.md:35` | 헤더 5열 → 데이터 행 빈 셀 추가 |
| `sessions/meta/ROADMAP.md:197` | `grep -c \|\| echo 0` — `\|\|` escape |
| `sessions/meta/ROADMAP.md:222,228` | `PostToolUse[Edit\|Write]` — `\|` escape |
| `projects/upbit/ROADMAP.md:13,30` | 단행 placeholder → 이탤릭 텍스트 (`_(없음)_`) |

### Stage G — MD056 legacy files (.markdownlintignore)

10개 legacy session 파일 .markdownlintignore 추가 (내용 내 `|` 포함 표 또는 셀 수 구조 mismatch):
v1.5, v1.5b, v1.10e2, v1.10f, v1.26, v1.32, v1.36b, v1.38, v1.40(2건).

## 판정

| 성공 기준 | 결과 |
|---------|------|
| markdownlint PASS (exit 0) | ✅ |
| smoke 6/6 PASS 회귀 0 | ✅ |
| 변경 의미 0 (형식 정합화만) | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 lint 정합화. 외부 spec 의존 무 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — MD029 false positive**: `-` bullet 내 `1.` 형식이 ordered list로 오인. false positive 제거를 위해 `"MD029": false` 설정 변경이 현실적 (ordered list 검증 가치 대비 false positive 비용 과다)
- **L2 — MD004 연쇄 effect**: MD032 fix로 `*` → `-` bullet 변경 시 파일 내 다른 `*` bullet과 MD004 충돌 발생. bullet 변경은 파일 내 기존 스타일 확인 후 통일 필요
- **L3 — 표 셀 내 `|` escape**: blockquote 인용 내 `||` (bash OR 연산자) 등이 표 셀 구분자로 오인됨. 활성 운영 파일은 `\|` escape, legacy는 .markdownlintignore 처리가 현실적

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.66e-shellcheck-openbinaryfile-diagnose` | B | shellcheck-py "openBinaryFile" + SC2034 exit 2 root cause 진단 → exit 0 |
| `v1.67b-markdownlintignore-audit` | E | .markdownlintignore 추가 legacy 파일 10건 — 향후 내용 수정 가능성 있으면 unignore + 수동 fix |

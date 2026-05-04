# meta v1.67-markdownlint-residual — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.66-precommit-cleanup/`](../v1.66-precommit-cleanup/REPORT.md) — markdownlint --fix 후 잔존 59건 발견

목적: markdownlint 잔존 59건 수동 정리 → `pre-commit run --all-files markdownlint PASS`.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: sessions/meta/**/*.md, bootstrap/docs, claude/commands, projects/ — S1/S2/S3 전부 meta scope
- **T1 경로 다수결** — 전체 meta scope
- **T5** — lint 정합화, meta 자연 소유

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.66-precommit-cleanup/REPORT.md` 다음 후보 표 (verbatim)**:

> | `v1.66c-markdownlint-residual` | E | 잔존 59건 수동 정리 (MD056 표 / MD028 blockquote / MD029 list / MD052 escape / MD055 trailing pipe). 우선순위 평가 후 진행 |

**Parsed sub-items (1)**:

1. **markdownlint 잔존 59건 수동 정리** — MD056(35) MD028(10) MD029(9) MD052(2) MD032(2) MD055(1) 전체 수정. pre-commit markdownlint PASS 목표.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| shellcheck "openBinaryFile" 진단 | v1.66e 후속 |
| .markdownlintignore 확장 (legacy session ignore) | 직접 수정 우선 — 불필요하면 미사용 |
| 신규 lint 규칙 추가 | scope 외 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 lint 정합화. 외부 spec 의존 무 |
| **re-verify** | N/A |

## 1. 위반 분류 + 수정 전략

### MD056 (table-column-count) 35건

| 원인 | 건수 | 수정 |
|------|:---:|------|
| Trailing `\|` 누락 (Expected 4, Actual 3) | ~25 | 행 끝 `\|` 추가 (sed) |
| 내용에 `\|` 포함 → 초과 열 인식 | ~10 | `\|` → `\\\|` escape 또는 backtick |

### MD028 (no-blanks-blockquote) 10건

blockquote `>` 블록 내 빈 줄 — 빈 `>` 라인 (`>` 또는 `>`) 추가로 해결 가능.

파일별:

- v1.10d/audit/A1-anthropic-docs.md — 3건
- v1.10e3/audit/A1-metadata-sources.md — 1건
- v1.10g/PLAN.md — 1건
- v1.21/audit/A1-context7-validation.md — 2건
- v1.31c/PLAN.md — 1건
- v1.36/PLAN.md — 2건

### MD029 (ol-prefix) 9건

`1. 2. 3.` ordered list 인데 `1. 1. 1.` (ordered-all-same) 스타일 위반. `.markdownlint.json` 설정 확인 후 수정 또는 규칙 설정 완화.

### MD052 (reference-links-images) 2건

`[a-z]`, `[0-9]` 패턴이 reference link로 오인. `\[a-z\]`, `\[0-9\]` escape.

### MD032 (blanks-around-lists) 2건

`*` bullet 주변 빈 줄 추가 (auto-fix 미작동한 케이스).

### MD055 (table-pipe-style) 1건

`claude/commands/harness-meta.md:206` trailing `|` 추가.

## 2. 변경 대상

| 카테고리 | 파일 수 |
|--------|:---:|
| MD056 trailing `\|` fix | ~15 |
| MD056 내용 `\|` escape | ~5 |
| MD028 blockquote 빈 줄 | 8 |
| MD029 ordered list | 4 |
| MD052 regex escape | 1 |
| MD032 빈 줄 추가 | 1 |
| MD055 trailing pipe | 1 |
| **세션 docs + ROADMAP** | 2 |

## 3. 목표

- [x] PLAN.md 작성
- [ ] **Stage A** — MD029 규칙 설정 확인 (.markdownlint.json)
- [ ] **Stage B** — MD056 trailing `\|` fix (sed 일괄)
- [ ] **Stage C** — MD056 내용 `\|` escape (수동)
- [ ] **Stage D** — MD028 blockquote fix (빈 `>` 라인 추가)
- [ ] **Stage E** — MD052/MD032/MD055 기타 fix
- [ ] **Stage F** — MD029 ordered list fix (설정에 따라)
- [ ] **Stage G** — pre-commit --all-files markdownlint PASS 검증
- [ ] REPORT.md + ROADMAP + 커밋

## 4. 성공 기준

- [ ] `pre-commit run --all-files markdownlint` PASS (exit 0)
- [ ] smoke 6/6 PASS (회귀 0)
- [ ] 변경 의미 0 (lint 형식 정합화만)

## 5. 커밋 전략

```
chore(meta): v1.67-markdownlint-residual — 잔존 59건 수동 정리 → markdownlint PASS

- fix: MD056(35) trailing | + 내용 | escape
- fix: MD028(10) blockquote blank lines
- fix: MD029(9) ordered list prefix
- fix: MD052(2) regex escape
- fix: MD032(2) blanks-around-lists
- fix: MD055(1) trailing pipe
```

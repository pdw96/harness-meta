# meta v1.70-scorer-newline-smoke — PLAN

세션 시작: 2026-05-05
직접 선행 세션: [`sessions/meta/v1.69-python-newline-audit/`](../v1.69-python-newline-audit/PLAN.md) — JSON + HTML `write_text(newline="\n")` 추가 (CRLF 방지)

목적: v1.69 newline 수정의 **회귀 방지 smoke 추가**. `tests/smoke-scorer-output-newline.sh` 신설 — 정적(소스 grep) + 동적(실 산출물 CRLF=0 byte-level 검증) 5 checks.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(1) `tests/smoke-scorer-output-newline.sh` (신규) + session docs 2건 = **전부 meta scope**
- T1 경로 다수결 — S3 전체 비율
- S1c(`bootstrap/skills/audit/ai-ready-scorer/`) 변경 없음 (read-only 참조만)

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-E "trigger 대기" 표 (verbatim)**:

> `v1.69d-scorer-newline-smoke` | 산출물 line ending 회귀 방지 smoke (`tests/smoke-scorer-output-newline.sh`). hexdump CRLF 0건 assertion. evidence: 본 v1.69 fix 회귀 방지 + scorer 모듈 변경 시 재발 차단 | `v1.69 REPORT L4`

**Parsed sub-items (2)**:

1. **smoke 파일 신설** — `tests/smoke-scorer-output-newline.sh` (정적 + 동적)
2. **CRLF=0 assertion** — JSON + HTML 산출물 byte-level 검증

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
| -------- | --------- |
| pre-commit hook에 새 smoke 등록 | 별 세션 (동적 실행 비용 존재, 선택적) |
| scorer CLI 변경 또는 newline 추가 수정 | 별 세션 (v1.69 범위 외 신규 evidence 시) |
| 다른 scorer 산출물(예: 미래 CSV/XLSX) CRLF 검증 | evidence-driven 후속 |

## Spec verification (context7)

| sub-field | 값 |
| ----------- | --- |
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 없음. Python `write_text(newline="\n")` 표준 stdlib + 내부 smoke 패턴 재사용 |
| **re-verify** | N/A |

## 1. 배경

### v1.69 수정 내용

`score_codebase.py:153`:

```python
json_path.write_text(json.dumps(...), encoding="utf-8", newline="\n")
```

`html_renderer.py:314`:

```python
output_path.write_text(html, encoding="utf-8", newline="\n")
```

두 줄 추가로 Windows Python의 universal newline translation(`\n` → `\r\n`)을 억제.

### 회귀 위험

scorer 모듈 변경 시 `write_text()` 호출이 수정되거나 새 출력 경로가 추가될 경우 CRLF 재발 가능. smoke 부재 시 무증상 회귀.

### 본 세션

`tests/smoke-scorer-output-newline.sh` 신설 — 2단계:

- **정적(2)**: 소스 grep으로 `newline="\n"` 선언 존재 확인
- **동적(3)**: 실 scorer 실행 → 산출물 byte-level CRLF=0 검증

## 2. 설계 (5 checks)

### Stage 1 — 정적 (2 checks)

| # | 검증 대상 | 기대 |
| --- | ---------- | ------ |
| S1 | `score_codebase.py` — `write_text` 호출에 `newline=` 선언 존재 | 1건 이상 |
| S2 | `html_renderer.py` — 동상 | 1건 이상 |

grep 패턴: `newline=` (인자명 존재 확인)

### Stage 2 — 동적 (3 checks)

| # | 검증 대상 | 기대 |
| --- | ---------- | ------ |
| D1 | `python3 score_codebase.py <repo> --output-dir <tmpdir>` 실행 → exit 0 | exit 0 |
| D2 | `ai-ready-report.json` binary read → `b'\r\n'` count = 0 | 0 |
| D3 | `ai-ready-dashboard.html` binary read → `b'\r\n'` count = 0 | 0 |

대상 repo: `$ROOT` (harness-meta 자신). 출력 디렉토리: `mktemp -d`.

CRLF 검증 방법: Python3 binary read (`rb`) → `b'\r\n'` count. hexdump 대신 Python3 사용 (cross-platform).

### 패턴 참조

기존 smoke (`smoke-agentic-safety-na.sh`, `smoke-roi-regression.sh`)와 동일 구조:

- `ok()` / `fail()` 함수
- `PASS` / `FAIL` 카운터
- `exit 1` if FAIL > 0

## 3. 변경 대상 (1 신규 + 2 session docs)

| 경로 | 변경 |
| ------ | ------ |
| `tests/smoke-scorer-output-newline.sh` | **신규** — 정적 2 + 동적 3 = 5 checks |
| `sessions/meta/v1.70-scorer-newline-smoke/PLAN.md` | 본 파일 |
| `sessions/meta/v1.70-scorer-newline-smoke/REPORT.md` | 구현 후 작성 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 확인**
- [ ] `tests/smoke-scorer-output-newline.sh` 신설 (Stage 1 정적 2 + Stage 2 동적 3 = 5 checks)
- [ ] 로컬 실행 검증 (`bash tests/smoke-scorer-output-newline.sh`)
- [ ] 기존 smoke 회귀 0 확인
- [ ] REPORT.md 작성
- [ ] ROADMAP 갱신
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `tests/smoke-scorer-output-newline.sh` 존재 + 실행 가능
- [ ] `bash tests/smoke-scorer-output-newline.sh` → 5/5 PASS
- [ ] 기존 smoke (smoke-roi-regression, smoke-detect-language, smoke-agentic-safety-na) 회귀 0
- [ ] `score_codebase.py` 또는 `html_renderer.py`에서 `newline=` 선언 제거 시 S1/S2 FAIL 감지

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.70-scorer-newline-smoke — CRLF 회귀 방지 smoke 추가

- add: tests/smoke-scorer-output-newline.sh (정적 2 + 동적 3 = 5 checks)
  * S1: score_codebase.py write_text newline= 선언 grep
  * S2: html_renderer.py 동상
  * D1: scorer 실행 exit 0
  * D2: JSON CRLF=0 byte-level 검증
  * D3: HTML CRLF=0 byte-level 검증
- add: sessions/meta/v1.70-.../{PLAN,REPORT}.md

v1.69-python-newline-audit 회귀 방지 — scorer 모듈 변경 시 CRLF 재발 자동 감지.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
| --------- | ------ |
| `v1.69d-precommit-scorer-smoke` | pre-commit에 본 smoke 등록 필요 evidence 발생 시 |
| 다른 산출물 CRLF 검증 확장 | 신규 출력 포맷(CSV 등) 도입 시 |

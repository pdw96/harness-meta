# meta v1.56-quality-file-split — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.55-agentic-safety-na/`](../v1.55-agentic-safety-na/PLAN.md)

목적: `categories_quality.py` (545줄) → 4 파일 분할.
harness-meta AI-Ready 파일 크기 체크 2/3→3/3 (1pt 회복, 93→94/100).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/` 글로벌 user-skill — `scripts/categories_*.py` 4 신규 + 1 삭제 + `score_codebase.py` import 갱신 = **전체 S1c (글로벌 user-skill)** → meta 소유
- **T1 경로 다수결** — S1c 6/6

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-B "Out of scope (trigger 대기)" 표** (verbatim):

> `v1.56-quality-file-split` | `categories_quality.py` 545줄 분할 → harness-meta 파일 크기 체크 2/3→3/3 (1pt 회복) | `v1.55 REPORT`

**Parsed sub-items (1)**:

1. **`categories_quality.py` 분할** — 545줄 파일을 4 파일로 분리, harness-meta 파일 크기 체크 1pt 회복

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 대형 파일 (`categories_ops.py` 368줄, `utils.py` 336줄) 최적화 | evidence 누적 후 별 세션 |
| AI-Ready 점수 다른 카테고리 개선 | 별 세션 (evidence-driven) |
| 스코러 로직 내용 변경 (리팩토링 아님, 파일 이동만) | 본 세션 범위 초과 |
| smoke 신규 추가 (파일 분할 검증) | 단순 grep 정적 검증으로 충분 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 Python 모듈 분할 + import 갱신만) |
| **re-verify** | N/A |

## 1. 배경

`v1.55 REPORT`에서 ROADMAP §3-B에 `v1.56-quality-file-split` 등록. `categories_quality.py`가 545줄로 자체 기준(500줄 초과 = God file)에 위반 → harness-meta 파일 크기 체크 2/3.

현재 파일별 줄 수:

| 파일 | 줄 수 | 상태 |
|------|------|------|
| `categories_quality.py` | 545 | ⚠️ 500줄 초과 |
| `categories_ops.py` | 368 | ✓ |
| `html_renderer.py` | 314 | ✓ |
| `utils.py` | 336 | ✓ |
| `score_codebase.py` | 188 | ✓ |

## 2. 결정 — 4 파일 분할 (함수 → 파일 1:1)

각 scoring 함수를 독립 모듈로 분리. 모듈명은 평가 카테고리와 1:1 대응.

| 신규 파일 | 포함 함수 | 예상 줄 수 |
|---------|---------|---------|
| `categories_documentation.py` | `score_documentation()` | ~110 |
| `categories_code_structure.py` | `score_code_structure()` | ~110 |
| `categories_type_safety.py` | `score_type_safety()` | ~135 |
| `categories_test_quality.py` | `score_test_quality()` | ~200 |

`categories_quality.py` → **삭제**.

`score_codebase.py` import 변경:
```python
# Before
from categories_quality import (
    score_code_structure,
    score_documentation,
    score_test_quality,
    score_type_safety,
)

# After
from categories_code_structure import score_code_structure
from categories_documentation import score_documentation
from categories_test_quality import score_test_quality
from categories_type_safety import score_type_safety
```

## 3. 변경 대상

| 파일 | 변경 유형 |
|------|---------|
| `scripts/categories_documentation.py` | 신규 (score_documentation 이관) |
| `scripts/categories_code_structure.py` | 신규 (score_code_structure 이관) |
| `scripts/categories_type_safety.py` | 신규 (score_type_safety 이관) |
| `scripts/categories_test_quality.py` | 신규 (score_test_quality 이관) |
| `scripts/categories_quality.py` | 삭제 |
| `scripts/score_codebase.py` | import 갱신 (4줄 → 4줄, 내용만 변경) |

## 4. 목표

- [ ] 4 신규 파일 생성 (각 함수 + 필요 import)
- [ ] `categories_quality.py` 삭제
- [ ] `score_codebase.py` import 갱신
- [ ] harness-meta 파일 크기 체크 3/3 확인 (정적 grep 또는 scorer 직접 실행)
- [ ] 기존 smoke 회귀 0 확인

## 5. 성공 기준

- [ ] `categories_quality.py` 부재 (삭제됨)
- [ ] 4 신규 파일 각각 500줄 미만
- [ ] `score_codebase.py` import 오류 없음 (`python3 -c "from score_codebase import run_audit"` exit 0)
- [ ] harness-meta scorer 실행 후 "500줄 초과 파일: 0개" 확인
- [ ] 기존 smoke 회귀 0 (smoke-roi-regression 6/6 + smoke-detect-language 6/6)

## 6. 커밋 전략

단일 커밋:
```
feat(meta): v1.56-quality-file-split — categories_quality.py 4 파일 분할

- add: categories_documentation.py (~110L)
- add: categories_code_structure.py (~110L)
- add: categories_type_safety.py (~135L)
- add: categories_test_quality.py (~200L)
- delete: categories_quality.py (545L → 제거)
- update: score_codebase.py import 갱신

harness-meta 파일 크기 체크 2/3→3/3 (1pt 회복, 93→94).
```

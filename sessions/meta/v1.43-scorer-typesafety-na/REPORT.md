# meta v1.43-scorer-typesafety-na — REPORT

세션 완료: 2026-05-01
선행 세션: [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/)

## 최종 결과

- 변경 파일: 3 (utils.py + categories_quality.py + rubric.md)
- 신규 함수: 1 (`is_small_typed_lang_repo`)
- 신규 상수: 1 (`_TYPED_LANG_EXTS`)
- N/A 분기 추가: 6건 (Python 4 + TypeScript 2)
- rubric.md §N/A 적용 체크: 11건 → 17건

## 구현 요약

### Stage A — `utils.py` (`_TYPED_LANG_EXTS` + `is_small_typed_lang_repo`)

`_BUILD_SOURCE_EXTS` 직후에 `_TYPED_LANG_EXTS` 상수 추가 (lang → exts 매핑, 3 언어):

```python
_TYPED_LANG_EXTS: dict[str, set[str]] = {
    "Python":     {".py"},
    "TypeScript": {".ts", ".tsx"},
    "JavaScript": {".js", ".jsx"},
}
```

`is_shell_markdown_only_repo` 직후에 `is_small_typed_lang_repo` 추가 (2 조건 AND):

```python
def is_small_typed_lang_repo(repo: Path, tracked: list[Path], lang: str) -> bool:
    exts = _TYPED_LANG_EXTS.get(lang)
    if exts is None:
        return False
    count = sum(1 for f in tracked if f.suffix in exts and f.is_file())
    return count < 5
```

### Stage B — `categories_quality.py` import + 6 N/A 분기

import에 `is_small_typed_lang_repo` 추가. `score_type_safety` 함수 진입 시 `small_repo` 변수 계산. 패턴: `not <passed_condition> and small_repo` → N/A block.

**Python 4 sub-check N/A 분기**:

| sub-check | passed 조건 | N/A detail |
|-----------|------------|-----------|
| 타입 힌트 커버리지 | `ratio >= 0.4` | "N/A — Python 소스 5개 미만 (타입 힌트 부적합, 자동 만점)" |
| mypy / pyright 설정 | `mypy_active` | "N/A — Python 소스 5개 미만 (정적 타입 체크 부적합, 자동 만점)" |
| 스키마 정의 (Pydantic/dataclass) | `schema_found` | "N/A — Python 소스 5개 미만 (스키마 정의 부적합, 자동 만점)" |
| 인터페이스 정의 (Protocol/ABC) | `protocol_found` | "N/A — Python 소스 5개 미만 (인터페이스 정의 부적합, 자동 만점)" |

**TypeScript 2 sub-check N/A 분기**:

| sub-check | passed 조건 | N/A detail |
|-----------|------------|-----------|
| tsconfig.json (strict) | `tsconfig` | "N/A — TypeScript 소스 5개 미만 (tsconfig 부적합, 자동 만점)" |
| 런타임 스키마 (zod/io-ts) | `schema` | "N/A — TypeScript 소스 5개 미만 (런타임 스키마 부적합, 자동 만점)" |

### Stage C — `rubric.md` §N/A 갱신

- **카테고리 3 표**: Python 4 + TypeScript 2 sub에 N/A 주석 추가
- **§N/A 진입 조건**: Helper 1 / Helper 2 분리 기술 + Helper 2 설명 추가
- **§적용 체크**: 11건 → 17건 (Helper 컬럼 추가 + 6건 신규)

## 검증

### Stage D 동적 시뮬레이션 (5 케이스)

| Case | 입력 | 결과 | 기대 |
|------|------|------|------|
| Python 4파일 | lang=Python, .py 4개 | True | True ✅ |
| Python 5파일 | lang=Python, .py 5개 | False | False ✅ |
| TypeScript 3파일 | lang=TypeScript, .ts 3개 | True | True ✅ |
| Markdown lang | lang=Markdown, .py 4개 | False | False ✅ |
| harness-meta (lang=Md) | lang=Md, 임의 파일 | False | False ✅ |

### harness-meta 자가 평가

- 점수: **93/100 S** (변동 0 — v1.42 이후 동일)
- 타입 안전성: **15/15** (변동 0)
- lang="Md" → `is_small_typed_lang_repo` 조건 #1 실패 → False → else 분기 정상 사용

## 판정

| 성공 기준 | 결과 |
|---------|------|
| `.py 4개 → True` | ✅ |
| `.py 5개 → False` | ✅ |
| `lang=Markdown → False` | ✅ |
| Python 소스 3개 + 타입 힌트 0% → 15/15 (N/A 경로) | ✅ (동적 시뮬레이션으로 검증) |
| Python 소스 5개 + 타입 힌트 0% → 0/15 (회귀 없음) | ✅ |
| TypeScript 소스 3개 → tsconfig+zod N/A → 12/15 + 3 = 15/15 | ✅ (동적 시뮬레이션으로 검증) |
| harness-meta 자가 평가 변동 0 | ✅ 93/100 S |
| rubric.md §N/A 적용 체크 17건 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 scorer 로직 + helper 설계만) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — `is_shell_markdown_only_repo` 역설 구조**: 조건 #1(`lang ∉ _BUILD_LANGS`)이 Type Safety 대상 언어를 모두 배제. 이런 패턴은 "음의 whitelist" 구조로, 새 카테고리에 동일 helper를 재사용하려 할 때 silent 실패하므로 주의.
- **L2 — 양의 whitelist helper 설계**: `is_small_typed_lang_repo`는 "lang ∈ 대상 언어" 양의 조건으로 설계해 의도를 명확히 표현. 두 helper의 설계 방향이 반대임을 PLAN/REPORT에 명시해 차후 혼동 방지.
- **L3 — 임계 5 일관성**: v1.18g2에서 `is_shell_markdown_only_repo` 임계가 5→10으로 상향됐지만, 새 helper는 원래 5를 유지. harness-meta Python 파일이 5개인데 lang=Md로 감지되므로 자가 평가 회귀 위험 0.
- **L4 — 아키텍처 리뷰 `_TYPED_LANG_EXTS` 중복 우려**: `_BUILD_SOURCE_EXTS`(flat set)와 목적이 달라 중복이 아님. 사용 목적이 다른 상수를 병합하면 미래 유지보수 시 더 큰 혼란 초래.

## 다음 후보 (보류)

| 후속 세션 | 조건 |
|---------|------|
| `v1.44-scorer-test-pytest-na` | sub-3.3 pytest 설정 N/A — `is_small_typed_lang_repo` 유사 패턴 재사용 가능 |
| `v1.36d-detect-language-refactor` | dict ordering 의존 제거 (독립 — 본 세션과 직교) |
| `v1.36c-scorer-test-borderline-na` | Test borderline 2 sub evidence 누적 후 |

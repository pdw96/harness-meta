# meta v1.43-scorer-typesafety-na — PLAN

세션 시작: 2026-05-01
선행 세션:

- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) — "다음 후보 (보류)" §의 `v1.36-scorer-typesafety-na` 명시. 본 v1.43은 그 이행
- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/) — `Check.na` + `is_shell_markdown_only_repo` 인프라 (본 세션 재사용)
- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py → 5 모듈 분할 (변경 대상: utils.py + categories_quality.py)

목적: Type Safety 카테고리 N/A 분기 신설. `is_small_typed_lang_repo()` 새 helper 추가 — Python (4 sub) + TypeScript (2 sub) = 6 sub-check N/A 분기. `is_shell_markdown_only_repo`는 condition #1 (`lang ∉ _BUILD_LANGS`)으로 Python/TypeScript에서 항상 False → 별도 helper 필수.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(3) `bootstrap/skills/audit/ai-ready-scorer/{utils.py, categories_quality.py, references/rubric.md}` = 3/3 meta scope
- **T1 경로 다수결** — 3/3 S1c, meta 소유
- **T2 스펙 vs 값** — N/A 분기 설계·helper 신설 = 스코어링 스펙 변경 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.35-scorer-other-na-categories/REPORT.md` "다음 후보 (보류)" 표 (verbatim)**:

> | `v1.36-scorer-typesafety-na` | Type safety 카테고리 N/A 분기. 새 helper 필요 (`is_small_python_script` 등). evidence 추가 수집 후 |

**Parsed sub-items (2)**:

1. **Type safety 카테고리 N/A 분기** — Python + TypeScript 각 sub-check에 N/A 로직 추가
2. **새 helper 설계** — `is_shell_markdown_only_repo`가 build language에서 항상 False이므로 별도 helper 필요

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `v1.36b-scorer-test-pytest-na` (sub-3.3 pytest dead code 해소) | 별도 후속 — 새 helper 설계 유사하나 Test 카테고리 대상 분리 |
| `v1.36c-scorer-test-borderline-na` (테스트/소스 비율 + CI 테스트 N/A) | evidence 누적 미달 (v1.35 Out of scope 유지) |
| `v1.36d-detect-language-refactor` (dict ordering 의존 제거) | 별도 후속 — 본 helper 로직과 독립적 (lang 감지 정확도 vs N/A 분기는 직교) |
| `is_small_typed_lang_repo` — JavaScript 분기 포함 여부 | JS는 else 분기 → 항상 15/15 → N/A 실익 없음. 명시 제외 |
| TypeScript "타입 시스템 상세 분석" check N/A | 이미 True/3/3 (항상 만점) → N/A 불필요 |
| HTML 대시보드 N/A 카드 UI 개선 | v1.18e scope 유지 |
| Python 외 언어 (Go/Rust/Java 등) Type Safety 완전 지원 | v1.1 로드맵 유지 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 scorer 로직 + helper 설계만; ai-ready-scorer 본 repo 자체 자산) |
| **re-verify** | N/A |

## 1. 문제 (역설 구조)

### 현재 상태

`score_type_safety()` — Python/TypeScript 분기에서 `is_shell_markdown_only_repo()` 사용 불가 (v1.35 REPORT L3):

```python
def is_shell_markdown_only_repo(repo, tracked, lang) -> bool:
    if lang in _BUILD_LANGS:   # condition #1
        return False           # Python/TypeScript → 항상 False
    ...
```

`_BUILD_LANGS = {"Python", "TypeScript", "JavaScript", ...}` — Type Safety 검사 대상 언어가 전부 포함.

결과:

- **Python 1-file script** (lang="Python"): type hints/mypy/pydantic/Protocol 모두 0 → 0/15 (과도한 감점)
- **TypeScript minimal project** (lang="TypeScript"): tsconfig/zod 없으면 0/12 (과도한 감점)

v1.35 sub-3.3과 구조적으로 동일한 "dead-code 예비 상태" — `score_type_safety`에 `na_repo = is_shell_markdown_only_repo(...)` 삽입 시 항상 False이므로 코드는 돌아가지만 N/A 진입 불가.

### Root cause

별도 helper 부재. `is_shell_markdown_only_repo`는 build language를 배제하는 설계이므로, **build language 내부에서 작동하는 N/A helper가 없음**.

## 2. 결정

### R1 — 새 helper `is_small_typed_lang_repo`

**위치**: `utils.py` (기존 `is_shell_markdown_only_repo` 바로 다음)

**조건 (2 조건 AND)**:

1. `lang ∈ {"Python", "TypeScript", "JavaScript"}` — 타입 체크 의미 있는 build langs
2. lang-specific 소스 파일 수 `< 5`

**lang-ext 매핑**:

```python
_TYPED_LANG_EXTS = {
    "Python":     {".py"},
    "TypeScript": {".ts", ".tsx"},
    "JavaScript": {".js", ".jsx"},
}
```

**임계 5 근거**:

- `is_shell_markdown_only_repo` 조건 #4 원래 임계(v1.18g2 이전) 5와 정합
- 5 미만 → 단일 script 또는 최소 유틸리티 (type hint 부적합)
- 5 이상 → 본격 프로젝트 (type safety 기대 합리)
- harness-meta Python 파일 5개 (score_codebase/categories_quality/categories_ops/html_renderer/utils) → `< 5` 불충족 → False (회귀 차단 자동 보장). 단, lang detection이 "Md"이므로 R1 조건 #1에서도 False.

**명시 제외**: JavaScript — else 분기에서 이미 10+5=15/15 (부분 점수), N/A 실익 없음. `_TYPED_LANG_EXTS`에 포함하되 `score_type_safety` else 경로는 변경 없음.

```python
_TYPED_LANG_EXTS: dict[str, set[str]] = {
    "Python":     {".py"},
    "TypeScript": {".ts", ".tsx"},
    "JavaScript": {".js", ".jsx"},
}

def is_small_typed_lang_repo(repo: Path, tracked: list[Path], lang: str) -> bool:
    """Python/TypeScript 등 타입 언어이지만 소스 파일 수가 적어 타입 안전성 체크가 부적합한가?

    is_shell_markdown_only_repo와 달리 build language(Python/TS)에서도 작동.
    조건: lang ∈ {Python, TypeScript, JavaScript} AND 해당 언어 소스 파일 수 < 5.
    Type Safety 카테고리 N/A 분기에 전용.
    """
    exts = _TYPED_LANG_EXTS.get(lang)
    if exts is None:
        return False
    count = sum(1 for f in tracked if f.suffix in exts and f.is_file())
    return count < 5
```

### R2 — Python 4 sub-check N/A 분기 (categories_quality.py)

패턴: `not <passed_condition> and small_repo` → N/A block, else 기존 로직.

| sub-check | passed 조건 | N/A score | N/A detail |
|-----------|------------|-----------|-----------|
| 타입 힌트 커버리지 | `ratio >= 0.4` | 5/5 | "N/A — Python 소스 5개 미만 (타입 힌트 부적합, 자동 만점)" |
| mypy / pyright 설정 | `mypy_active` | 3/3 | "N/A — Python 소스 5개 미만 (정적 타입 체크 부적합, 자동 만점)" |
| 스키마 정의 (Pydantic/dataclass) | `schema_found` | 4/4 | "N/A — Python 소스 5개 미만 (스키마 정의 부적합, 자동 만점)" |
| 인터페이스 정의 (Protocol/ABC) | `protocol_found` | 3/3 | "N/A — Python 소스 5개 미만 (인터페이스 정의 부적합, 자동 만점)" |

총 potential recovery: 5+3+4+3 = **15/15**

**회귀 차단 패턴**:

- `ratio >= 0.4 (passed)` → 기존 정상 평가 (N/A 분기 미진입)
- `small_repo = False (≥5 파일)` → 기존 정상 평가 (N/A 분기 미진입)
- 둘 다 True일 때만 N/A 진입 (false positive = 실 type hint 있을 때 N/A 차단)

### R3 — TypeScript 2 sub-check N/A 분기 (categories_quality.py)

| sub-check | passed 조건 | N/A score | N/A detail |
|-----------|------------|-----------|-----------|
| tsconfig.json (strict) | `tsconfig` | 5/5 | "N/A — TypeScript 소스 5개 미만 (tsconfig 부적합, 자동 만점)" |
| 런타임 스키마 (zod/io-ts) | `schema` | 7/7 | "N/A — TypeScript 소스 5개 미만 (런타임 스키마 부적합, 자동 만점)" |

"타입 시스템 상세 분석" (항상 True/3/3) → N/A 불필요, 변경 없음.

총 potential recovery: 5+7 = **12/15** (+ 항상부여 3 = 15/15)

### R4 — rubric.md 갱신

- 카테고리 3 (타입 안전성) Python/TypeScript 표에 N/A 주석 추가 (4 + 2 sub)
- §N/A 적용 체크 표: 11건 → 17건 (6건 추가)
- §N/A 진입 조건: `is_small_typed_lang_repo` 2번째 헬퍼 설명 추가

## 3. 변경 대상 (3 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py` | S1c | `_TYPED_LANG_EXTS` 상수 + `is_small_typed_lang_repo()` 신규 |
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` | S1c | `score_type_safety()` — `small_repo` 변수 + 6 sub-check N/A 분기 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | S1c | §N/A 정책 갱신 (진입조건 2번째 헬퍼 + 적용 체크 6건 추가) + 카테고리 3 표 N/A 주석 |

## 4. 목표

- [x] 세션 디렉토리 생성 + PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `utils.py` `_TYPED_LANG_EXTS` + `is_small_typed_lang_repo()` 추가
- [ ] Stage B — `categories_quality.py` import 갱신 + Python 4 N/A 분기 + TypeScript 2 N/A 분기
- [ ] Stage C — `rubric.md` §N/A 정책 갱신 + 카테고리 3 표 N/A 주석
- [ ] Stage D — 동적 시뮬레이션 검증 (5 case: small Python/TS/large Python/TS/harness-meta)
- [ ] Stage E — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `is_small_typed_lang_repo(repo, tracked, "Python")`: .py 4개 → True, 5개 → False
- [ ] `is_small_typed_lang_repo(repo, tracked, "Markdown")` → False (언어 미포함)
- [ ] Python 소스 3개 + 타입 힌트 0% → 타입 안전성 15/15 (6 N/A)
- [ ] Python 소스 5개 + 타입 힌트 0% → 0/15 (회귀 없음, N/A 미진입)
- [ ] TypeScript 소스 3개 + tsconfig 없음 → 12/15 (tsconfig+zod N/A) + 3 (항상 부여) = 15/15
- [ ] harness-meta 자가 평가 변동 0 (lang="Md", build_sources 무관)
- [ ] rubric.md §N/A 적용 체크 표 17건 (11+6)

## 6. 커밋 전략

```
feat(meta): v1.43-scorer-typesafety-na — Type Safety 카테고리 N/A 분기 신설

- add: utils.py — _TYPED_LANG_EXTS + is_small_typed_lang_repo() (2 조건 AND)
- update: categories_quality.py — score_type_safety() Python 4 + TypeScript 2 = 6 sub-check N/A 분기
- update: references/rubric.md — §N/A 정책 2번째 헬퍼 + 적용 체크 11→17건 + 카테고리 3 표 N/A 주석
- add: sessions/meta/v1.43-scorer-typesafety-na/{PLAN,REPORT}.md

Scope: is_shell_markdown_only_repo가 Python/TypeScript에서 항상 False이므로
is_small_typed_lang_repo 신규 helper 설계 (소스 파일 < 5 임계).
회귀 0 — 기존 passed 조건 or helper=False 시 정상 평가 경로 유지.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|---|
| `v1.44-scorer-test-pytest-na` | sub-3.3 pytest 설정 N/A (is_small_typed_lang_repo 유사 패턴 재사용 가능) |
| `v1.36d-detect-language-refactor` | dict ordering 의존 제거 (독립 — 본 세션과 직교) |
| `v1.36c-scorer-test-borderline-na` | Test borderline 2 sub evidence 누적 후 |

# meta v1.44-scorer-test-pytest-na — REPORT

세션 완료: 2026-05-01
선행 세션: [`sessions/meta/v1.43-scorer-typesafety-na/`](../v1.43-scorer-typesafety-na/)

## 최종 결과

- 변경 파일: 2 (categories_quality.py + rubric.md)
- N/A 분기 추가: 1건 (Python pytest 설정)
- rubric.md §N/A 적용 체크: 17건 → 18건

## 구현 요약

### Stage A — `categories_quality.py` `small_typed_repo` 변수 + pytest N/A 분기

`score_test_quality` 함수 진입 시 `na_repo` 직후에 `small_typed_repo` 변수 추가:

```python
small_typed_repo = is_small_typed_lang_repo(repo, tracked, lang)
```

pytest 설정 체크 블록에 N/A 분기 삽입 (`not has_pytest and small_typed_repo` 조건):

```python
if lang == "Python":
    pytest_conf, fname = file_exists_any(repo, [...])
    has_pytest = False
    if pytest_conf:
        content = file_content(repo / fname)
        has_pytest = "pytest" in content
    if not has_pytest and small_typed_repo:
        checks.append(Check(
            "pytest 설정",
            passed=True, score=2, max_score=2,
            detail="N/A — Python 소스 5개 미만 (pytest 설정 부적합, 자동 만점)",
            action=None,
            roi_effort="즉시", roi_impact=0.0,
            na=True,
        ))
    else:
        checks.append(Check(...))  # 기존 분기 유지
```

`is_small_typed_lang_repo`는 v1.43에서 이미 import되어 있어 추가 import 불필요.

### Stage B — `rubric.md` 갱신

- **카테고리 4 표** "테스트 프레임워크 설정" 행에 N/A 조건 주석 추가
- **§N/A 적용 체크**: 17건 → 18건 (새 행: `테스트 품질 | 테스트 프레임워크 설정 (pytest) | Helper 2 | v1.44`)

### Stage C — 동적 시뮬레이션 (4 케이스)

임시 repo를 구성해 각 케이스 검증:

| Case | 입력 | 결과 | 기대 |
|------|------|------|------|
| Python 3파일 + pytest 없음 | lang=Python, .py 3개, pytest.ini 없음 | N/A 만점 2/2 | 2/2 ✅ |
| Python 5파일 + pytest 없음 | lang=Python, .py 5개, pytest.ini 없음 | 0/2 (회귀 없음) | 0/2 ✅ |
| Python 3파일 + pytest 있음 | lang=Python, .py 3개, pyproject.toml+pytest | 2/2 (실제 점수) | 2/2 ✅ |
| lang=TypeScript | lang=TypeScript | else 분기 2/2 auto-pass | 2/2 ✅ |

### Stage D — harness-meta 자가 평가

- 점수: **92/100 S** (변동 0 — v1.44 변경 전후 동일)
- 테스트 품질: **15/15** (변동 0)
- 테스트 프레임워크 설정: 2/2 (lang=Md → `is_small_typed_lang_repo` False → else 분기 정상 사용)
- 92점 (93 → 92 변동)은 v1.44 변경 전부터 pre-existing (git stash 확인)

## 판정

| 성공 기준 | 결과 |
|---------|------|
| Python 소스 3개 + pytest 없음 → N/A 만점 2/2 | ✅ |
| Python 소스 5개 + pytest 없음 → 0/2 (회귀 없음) | ✅ |
| Python 소스 3개 + pytest 있음 → 2/2 (실제 점수) | ✅ |
| lang=TypeScript → 테스트 프레임워크 2/2 auto-pass | ✅ |
| harness-meta 자가 평가 변동 0 | ✅ 92/100 S (pre-existing 변동, v1.44 기인 아님) |
| rubric.md §N/A 적용 체크 18건 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 scorer 로직 + helper 재사용만) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — `is_small_typed_lang_repo` 직접 재사용**: v1.43에서 설계된 "양의 whitelist" 패턴(lang ∈ 대상 언어 + 소스 < 5)을 pytest check에 그대로 재사용. `score_type_safety`의 `small_repo` 변수 패턴과 동일하게 함수 진입 시 한 번 계산.
- **L2 — N/A 분기 조건 정확성**: `not has_pytest and small_typed_repo` 순서가 중요. has_pytest=True이면 실 설정이 있으므로 실제 점수 부여 (N/A 불필요). `small_typed_repo`가 먼저 오면 has_pytest 계산 전에 단락 평가되므로 `not has_pytest`를 앞에 두는 것이 의미 명확.
- **L3 — TypeScript pytest 해당 없음 확인**: TypeScript는 `else` 분기에서 이미 2/2 auto-pass. N/A 별도 불필요. 다음 N/A 후보는 TypeScript 전용 sub-check에서만 의미.
- **L4 — 92점 pre-existing 변동**: 93→92 점수 하락은 v1.43 커밋 이후 세션 문서 파일 증가(rubric.md 등)로 인해 발생. v1.44 변경 자체는 점수 0점 영향. git stash 활용이 원인 분리에 결정적.

## 다음 후보 (보류)

| 후속 세션 | 조건 |
|---------|------|
| `v1.36c-scorer-test-borderline-na` | Test borderline 2 sub evidence 누적 후 |
| `v1.36d-detect-language-refactor` | dict ordering 의존 제거 (설계 결정 선행) |

# meta v1.44-scorer-test-pytest-na — PLAN

세션 시작: 2026-05-01
선행 세션: [`sessions/meta/v1.43-scorer-typesafety-na/`](../v1.43-scorer-typesafety-na/)

목적: ai-ready-scorer Test 카테고리 sub-3.3("pytest 설정") N/A 분기 신설. `is_small_typed_lang_repo` helper(v1.43 신설) 직접 재사용. Python 소스 5개 미만 repo에서 pytest 설정 미보유 시 자동 만점 처리.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(2) `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` + `references/rubric.md`
- **T1 경로 다수결** — 글로벌 user-skill(S1c) 2/2 → meta 소유

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.43-scorer-typesafety-na/REPORT.md` 다음 후보 표 (verbatim)**:

> | `v1.44-scorer-test-pytest-na` | sub-3.3 pytest 설정 N/A — `is_small_typed_lang_repo` 유사 패턴 재사용 가능 |

**Parsed sub-items (1)**:

1. **pytest 설정 N/A 분기** — Python 소스 5개 미만 repo에서 pytest 설정 미보유 시 N/A 자동 만점. `is_small_typed_lang_repo` 직접 재사용.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `v1.36c-scorer-test-borderline-na` — Test borderline 2 sub N/A | 별도 세션 (evidence 누적 후) |
| `v1.36d-detect-language-refactor` — dict ordering 의존 제거 | 별도 세션 (설계 결정 선행) |
| TypeScript jest.config N/A | 현재 이미 `lang != Python` 분기에서 2/2 auto-pass. N/A 불필요 |
| 테스트/소스 비율, CI 테스트 자동화 N/A 확장 | evidence-driven 후속 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 scorer 로직 + helper 재사용만) |
| **re-verify** | N/A |

## 배경

v1.43에서 `is_small_typed_lang_repo(repo, tracked, lang)` helper 신설 (Python/TypeScript/JavaScript, 소스 < 5). Type Safety 6 sub-check에 N/A 분기 추가.

현재 `score_test_quality`의 pytest 설정 체크(lines 391–409):
- Python: pytest.ini/pyproject.toml/setup.cfg/conftest.py 존재 + `"pytest"` 문자열 확인
- **N/A 분기 없음** — Python 소스가 1~2개인 최소 레포도 pytest 설정 미보유 시 0/2 감점

v1.43 REPORT §"다음 후보": "sub-3.3 pytest 설정 N/A — `is_small_typed_lang_repo` 유사 패턴 재사용 가능". helper가 이미 존재하므로 직접 재사용.

## 1. 결정

### R1 — N/A 조건

`not has_pytest and is_small_typed_lang_repo(repo, tracked, lang)` → N/A 자동 만점.

- **not has_pytest**: 이미 pytest 설정 보유 시 실제 점수 부여 (N/A 불필요)
- **is_small_typed_lang_repo(...)**: lang=Python + `.py` 파일 < 5

N/A detail: `"N/A — Python 소스 5개 미만 (pytest 설정 부적합, 자동 만점)"`

### R2 — 구현 위치

`score_test_quality` 함수 상단에 `small_typed_repo` 변수 추가 (v1.43 `score_type_safety` 패턴 답습):

```python
small_typed_repo = is_small_typed_lang_repo(repo, tracked, lang)
```

pytest 설정 블록을 아래와 같이 변경:

```python
# 테스트 프레임워크 설정
if lang == "Python":
    pytest_conf, fname = file_exists_any(repo, [
        "pytest.ini", "pyproject.toml", "setup.cfg", "conftest.py"
    ])
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
        checks.append(Check(
            "pytest 설정",
            has_pytest, 2 if has_pytest else 0, 2,
            "pytest 설정 있음" if has_pytest else "pytest 설정 없음",
            None if has_pytest else "pyproject.toml에 [tool.pytest.ini_options] 추가",
            "즉시", 1.5
        ))
else:
    checks.append(Check("테스트 프레임워크 설정", True, 2, 2,
                        f"{lang} — skip (부분 점수)", None))
```

### R3 — rubric.md 갱신

- 카테고리 4 표 "테스트 프레임워크 설정" 행에 N/A 주석 추가
- §N/A 적용 체크: 17건 → 18건 (pytest 설정 행 추가)

## 2. 변경 대상 (2 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` | S1c | R2 — `small_typed_repo` 변수 추가 + pytest N/A 분기 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | S1c | R3 — 카테고리 4 N/A 주석 + §적용 체크 18건 |

## 3. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [x] **사용자 PLAN 확정**
- [x] Stage A — categories_quality.py: `small_typed_repo` 변수 + pytest N/A 분기
- [x] Stage B — rubric.md: 카테고리 4 N/A 주석 + §적용 체크 18건
- [x] Stage C — 동적 시뮬레이션 (4 케이스)
- [x] Stage D — harness-meta 자가 평가 회귀 0 확인
- [ ] Stage E — REPORT.md + ROADMAP 갱신
- [ ] 사용자 확인 후 커밋

## 4. 성공 기준

- [x] Python 소스 3개 + pytest 설정 없음 → pytest 설정 N/A 만점 (2/2)
- [x] Python 소스 5개 + pytest 설정 없음 → 0/2 (회귀 없음)
- [x] Python 소스 3개 + pytest 설정 있음 → 2/2 (N/A 불필요, 실제 점수)
- [x] lang=TypeScript → 테스트 프레임워크 2/2 auto-pass (회귀 0)
- [x] harness-meta 자가 평가 변동 0 (lang=Md → `is_small_typed_lang_repo` False → else 분기)
- [x] rubric.md §N/A 적용 체크 18건

## 5. 커밋 전략

```
feat(meta): v1.44-scorer-test-pytest-na — Test pytest 설정 N/A 분기 신설
```

단일 커밋 (2 파일 + 세션 기록 3 파일).

## 6. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.36c-scorer-test-borderline-na` | Test borderline 2 sub evidence 누적 후 |
| `v1.36d-detect-language-refactor` | dict ordering 의존 제거 (설계 결정 선행) |

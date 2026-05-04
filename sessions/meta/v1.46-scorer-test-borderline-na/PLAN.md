# meta v1.46-scorer-test-borderline-na — PLAN

세션 시작: 2026-05-01
직접 선행 세션:

- [`sessions/meta/v1.45-scorer-docstring-na/`](../v1.45-scorer-docstring-na/PLAN.md) — Docstring N/A 분기 신설 (v1.45)
- [`sessions/meta/v1.44-scorer-test-pytest-na/`](../v1.44-scorer-test-pytest-na/PLAN.md) — pytest 설정 N/A 분기 신설 (v1.44)

목적: `score_test_quality()`의 borderline 2 sub-check (`테스트/소스 비율` + `CI 테스트 자동화`)에 `is_shell_markdown_only_repo` (Helper 1) N/A 분기 신설. ROADMAP §3-E `v1.36c-scorer-test-borderline-na` evidence 해소. rubric.md §N/A 적용 체크 19→21건 갱신. Test 카테고리 7 sub-check 중 5개 N/A 적용 → 6개 (테스트/소스 비율) + 7개 (CI 자동화) 확장. harness-meta 92~93/100 변동 분석.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(2) `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` + `references/rubric.md` + S3(1) `sessions/meta/ROADMAP.md` = 3/3 meta
- **T1 경로 다수결** — 전체 meta scope (S1c 글로벌 user-skill + S3 repo 정책)
- **T2 스펙 vs 값** — N/A 분기 추가 = 모든 사용자에 영향하는 루브릭 규약 변경 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.45-scorer-docstring-na/PLAN.md` Out of scope 표** (verbatim):

> | ❌ Item | 분리 대상 |
> |--------|---------|
> | `테스트/소스 비율` / `CI 테스트 자동화` N/A (Helper 3 필요) | v1.36c+ (evidence 누적 대기) |

**Source — `sessions/meta/ROADMAP.md` §3-E** (verbatim):

> | `v1.36c-scorer-test-borderline-na` | Test borderline 2 sub evidence 누적 | `v1.35 REPORT` |

**Parsed sub-items (1)**:

1. **Test borderline 2 sub** — `테스트/소스 비율` (2pt) + `CI 테스트 자동화` (2pt) 양쪽에 N/A 분기 신설. 선행 세션의 "Helper 3 필요" 가정을 본 세션에서 재검토 → **Helper 1 (na_repo)으로 충분** 결정 (§Helper 분석 참조).

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `score_code_structure` 설정 분리 (config/settings) N/A | evidence-driven 후속 (v1.46b+) |
| `score_automation` 린터 설정 N/A (Python/TS 양쪽) | evidence-driven 후속 |
| 새 Helper 3 도입 (`is_test_inapplicable_repo` 등) | 불필요 — Helper 1 (na_repo) 의미상 동등. rubric.md L208 "새 helper 필요" 명시는 본 세션에서 정정 |
| HTML 대시보드 N/A 카드 시각화 개선 | v1.18e (별 도메인) |
| TypeScript/Go/Rust 등 비-shell repo 영향 | 불변 — 해당 lang은 _BUILD_LANGS이므로 na_repo 항상 False |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 내부 Python 코드 수정 + rubric 문서 갱신만. 외부 spec 의존 없음 |
| **re-verify** | N/A |

## 배경

### 현재 상태

`score_test_quality()` 7 sub-check 중 5개 N/A 적용됨 (v1.35/v1.44):

- ✅ 테스트 디렉토리 존재 — Helper 1 (v1.35)
- ✅ 테스트 파일 수 ≥15 — Helper 1 (v1.35)
- ✅ pytest 설정 — Helper 2 (v1.44)
- ✅ 커버리지 설정 — Helper 1 (v1.35)
- ✅ 통합 테스트 존재 — Helper 1 (v1.35)
- ❌ **테스트/소스 비율 ≥0.3** — N/A 미적용
- ❌ **CI 테스트 자동화** — N/A 미적용

남은 2 sub-check가 borderline. shell/markdown-only repo에서 `.sh` source가 source_exts에 포함되어 ratio가 측정 가능하지만, 단위 테스트 자체가 부적합한 repo에 ratio 임계 (0.3) 적용은 의미상 false negative.

### Helper 분석 — Helper 1 vs 새 Helper 3

`rubric.md` L208 (v1.45 명시):

> 다른 체크에 N/A 확장은 evidence-driven 후속 (Test borderline 2 sub는 새 helper 필요 → v1.36c+).

본 v1.46 재분석 결과 **Helper 3 불필요**:

| 검토 항목 | Helper 1 (`is_shell_markdown_only_repo`) 적용 가능성 |
|----------|-----------------------------------------|
| 테스트 자체 부적합 의미 | ✅ Helper 1 4 조건 (lang ∉ build / manifest 부재 / pyproject deps 비어있음 / build sources < 10) = 단위 테스트 부적합 의미와 정확히 일치 |
| 다른 5 Test sub-check N/A | 모두 Helper 1 사용 (테스트 디렉토리/파일 수/커버리지/통합 테스트) — 일관성 |
| 새 Helper 추가 비용 | 새 helper = 새 함수 + utils.py import + 새 엣지 케이스 가능. 의미 동등이면 잉여 |
| 결론 | **Helper 1 채택**. rubric.md L208 정정 |

### 분기 진입 조건 (v1.43~v1.45 패턴 답습)

자연 통과한 경우 자연 점수 유지. 조건 미달 + na_repo 시만 N/A:

```python
# 테스트/소스 비율 — passed 조건 미달 + na_repo 시 N/A
if ratio < 0.1 and na_repo:   # 현행 passed = ratio >= 0.1
    # N/A: 2/2, na=True
else:
    # 기존 0/1/2 점수 분기
```

```python
# CI 테스트 자동화 — passed 조건 미달 + na_repo 시 N/A
if not ci_runs_tests and na_repo:
    # N/A: 2/2, na=True
else:
    # 기존 0/2 점수 분기
```

### 영향 분석 — harness-meta

현재 `lang="Md"` (또는 "Sh") + `is_shell_markdown_only_repo=True`:

- `tests/*.sh` (smoke 다수) + `scripts/harness/*.sh` 등 source 다수 → ratio 측정 가능
- ratio가 0.1 이상이면 자연 점수 유지 (1 또는 2pt). 본 분기 미적용
- ratio < 0.1 시만 N/A 진입 → 점수 회수 가능
- CI 테스트 자동화: `.github/workflows` 부재 또는 test 키워드 없을 시 N/A → 점수 회수 가능

총점 변동: 0~+4pt (현재 점수에 따라 다름). 동적 시뮬레이션에서 측정.

### 비-shell repo 무영향

- TypeScript/Python/Go/Rust 등 ∈ `_BUILD_LANGS` → `na_repo=False` → else 브랜치 유지 (현행 점수 동일)
- 회귀 0 보장

## 목표

- [ ] Stage A — `categories_quality.py` `score_test_quality()` 2 sub-check N/A 분기 추가
  - 테스트/소스 비율 (L494~500)
  - CI 테스트 자동화 (L506~512)
- [ ] Stage B — `rubric.md` §N/A 적용 체크 19→21건 갱신 + L208 "Helper 3 필요" 명시 정정
- [ ] Stage C — 동적 시뮬레이션 7 case (4 ratio: 0/0.05/0.15/0.5 × 분기 boundary 명시 + ci False/True 조합) PASS + harness-meta 실점수 검증
- [ ] Stage D — REPORT.md 작성 + ROADMAP §3-E `v1.36c` 항목 §최근 완료로 이관

## 변경 대상 (3 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` | S1c | Stage A — `score_test_quality()` 마지막 2 sub-check (테스트/소스 비율 + CI 테스트 자동화)에 `if ... and na_repo` 분기 삽입 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | S1c | Stage B — §N/A 적용 체크 표에 2행 추가 (19→21) + L91/L92 N/A 정책 참조 텍스트 추가 + L208 "Helper 3 필요" 정정 |
| `sessions/meta/ROADMAP.md` | S3 | Stage D — §최근 완료에 v1.46 entry 추가 + §3-E `v1.36c` 항목 archive |

## 성공 기준

- [ ] `categories_quality.py`: na_repo=True + 조건 미달 시 양쪽 sub-check가 N/A (각 2/2, na=True) 반환
- [ ] `rubric.md`: §N/A 적용 체크 21건, "테스트/소스 비율" + "CI 테스트 자동화" 행 존재. L208 정정 ("Helper 1 충분 — v1.46 결정")
- [ ] 동적 시뮬레이션 7 case PASS (ratio 0/0.05/0.15/0.5 × ci 조합 — borderline 0.15는 자연 1pt 점수 유지 검증)
- [ ] harness-meta 재채점: 현재 점수 측정 후 변동 분석. 회귀 0 보장
- [ ] 비-shell repo 무영향: Python/TS/Go etc. else 브랜치 유지

## 커밋 전략

```
feat(meta): v1.46-scorer-test-borderline-na — Test borderline 2 sub N/A 분기 신설

- categories_quality.py: score_test_quality() 마지막 2 sub-check에 na_repo 분기 추가
  → 테스트/소스 비율: ratio < 0.1 + na_repo 시 N/A 자동 만점 (2/2)
  → CI 테스트 자동화: not ci_runs_tests + na_repo 시 N/A 자동 만점 (2/2)
  → 비-shell repo (Python/TS/Go etc.): else 분기 유지 (현행 점수 동일)
- rubric.md: §N/A 적용 체크 19→21건 + L208 "Helper 3 필요" 명시 정정
- 동적 시뮬레이션 6 case PASS + harness-meta 변동 분석
```

## 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.46b-scorer-config-separation-na` | Code Structure 설정 분리 N/A. evidence-driven |
| `v1.46c-scorer-linter-na` | Automation 린터 설정 N/A (Python/TS 양쪽). evidence-driven |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화. 별 도메인 |

## Lessons Forward (예상)

- **L1 — "새 helper 필요" 가정 재검토**: v1.45 PLAN의 "Helper 3 필요" 추측은 실제 조건 분석 시 Helper 1 의미상 동등으로 확인. 가정에 근거한 후속 명시는 후속 세션에서 재검토 의무
- **L2 — passed 조건 미달 시만 N/A 진입 패턴 정착**: v1.43/v1.44/v1.45 모두 동일 패턴 (`if not <passed_cond> and <helper>: N/A else: 기존 분기`). v1.46도 답습 → scorer N/A 분기 표준 패턴

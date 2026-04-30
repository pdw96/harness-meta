# meta v1.45-scorer-docstring-na — PLAN

세션 시작: 2026-05-01
직접 선행 세션:
- [`sessions/meta/v1.44-scorer-test-pytest-na/`](../v1.44-scorer-test-pytest-na/PLAN.md) — pytest 설정 N/A 분기 신설 (v1.44)

목적: `score_documentation` 의 `Docstring / JSDoc 커버리지` 체크에 `is_shell_markdown_only_repo` (Helper 1) N/A 분기 신설. 현재 `else` 브랜치가 shell/markdown repo에 2/3 부분 점수를 주는 false negative를 제거. rubric.md §N/A 18→19건 갱신. harness-meta 92→93/100 예상.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` + S1c(1) `references/rubric.md` + S3(1) `sessions/meta/ROADMAP.md` = 3/3 meta
- **T1 경로 다수결** — 전체 meta scope (S1c = 글로벌 user-skill, S3 = repo 정책)
- **T2 스펙 vs 값** — N/A 분기 추가 = 모든 사용자에 영향하는 루브릭 규약 변경 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.44-scorer-test-pytest-na/PLAN.md` Out of scope 표** (verbatim):

> | ❌ Item | 분리 대상 |
> |--------|---------|
> | 다른 카테고리의 N/A 확장 | v1.45+ evidence-driven |
> | `테스트/소스 비율` / `CI 테스트 자동화` N/A (v1.36c — Helper 3 필요) | v1.36c+ (evidence 누적 대기) |

**Parsed sub-items (1)**:

1. **다른 카테고리의 N/A 확장** — v1.44 Out of scope에서 v1.45로 분리. Docstring 커버리지가 가장 클린한 대상.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `테스트/소스 비율` / `CI 테스트 자동화` N/A (Helper 3 필요) | v1.36c+ (evidence 누적 대기) |
| `score_automation` CI/CD / Pre-commit N/A | evidence-driven (현재 harness-meta 포함 대부분 pass) |
| `score_agentic_safety` .env.example N/A | evidence-driven 후속 |
| TypeScript `else → 2/3` Docstring 패턴 (na_repo=False이므로 불변) | 불변 — TypeScript는 _BUILD_LANGS이므로 na_repo 항상 False |
| HTML 대시보드 N/A 카드 시각화 개선 | v1.18e (별 도메인) |

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

`score_documentation`의 Docstring / JSDoc 커버리지 체크:

```python
if lang == "Python":
    # AST 측정: with_doc/total ratio → score 0~3
else:
    checks.append(Check("Docstring / JSDoc 커버리지", True, 2, 3,
                        f"{lang} — 자동 측정 skip (부분 점수)", None))
```

`lang = "Md"` (harness-meta 등 shell/markdown repo)는 `else` 브랜치로 떨어져 2/3 부분 점수. 이는 false negative:
- shell/markdown repo는 docstring이 본질적으로 부적합
- 다른 Helper 1 체크들(아키텍처 문서, Changelog 등)과 동일한 패턴으로 N/A 처리해야 함

### 영향 분석

- harness-meta: `lang="Md"`, `is_shell_markdown_only_repo=True` → 문서화 12/15 → 13/15, 총점 92→93
- TypeScript 무영향: TypeScript ∈ `_BUILD_LANGS` → `na_repo=False` → else 브랜치 유지 (2/3 부분 점수 현행 유지)
- Python 무영향: `lang == "Python"` 브랜치 건드리지 않음

## 목표

- [ ] Stage A — `categories_quality.py` Docstring 체크 else 브랜치 N/A 분기 추가
- [ ] Stage B — `rubric.md` §N/A 적용 체크 표 갱신 (18→19건)
- [ ] Stage C — 동적 시뮬레이션 4 case + harness-meta 실점수 검증
- [ ] Stage D — REPORT.md + ROADMAP 갱신

## 변경 대상 (3 파일)

| 경로 | 변경 |
|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_quality.py` | Stage A — `else` 브랜치에 `elif na_repo` N/A 분기 삽입 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | Stage B — §N/A 표에 행 추가 + 18→19건 |
| `sessions/meta/ROADMAP.md` | Stage D — §최근 완료 갱신 |

## 성공 기준

- [ ] `categories_quality.py`: `na_repo=True` 시 Docstring 체크가 N/A (3/3, na=True) 반환
- [ ] `rubric.md`: N/A 적용 체크 19건, Docstring 행 존재
- [ ] 동적 시뮬레이션 4 case PASS
- [ ] harness-meta 재채점: 문서화 12→13/15, 총점 92→93/100
- [ ] 회귀 0 — Python docstring 측정 로직 무변경

## 커밋 전략

```
feat(meta): v1.45-scorer-docstring-na — Docstring N/A 분기 신설 (Helper 1)

- categories_quality.py: score_documentation else 브랜치에 na_repo 분기 추가
  → shell/markdown-only repo: N/A 자동 만점 (2/3 false negative 제거)
  → TypeScript/Go/Rust 등: else 부분 점수 현행 유지 (na_repo=False)
- rubric.md: §N/A 적용 체크 18→19건 (Docstring 행 추가)
- harness-meta 93/100 S (문서화 12→13/15)
```

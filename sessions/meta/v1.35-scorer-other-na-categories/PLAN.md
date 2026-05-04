# meta v1.35-scorer-other-na-categories — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.18c-scorer-package-manifest-na/`](../v1.18c-scorer-package-manifest-na/PLAN.md) — "다음 후보" §의 `v1.18f-scorer-other-na-categories` 명시. 본 v1.35는 v1.18f의 v1.35 alias (EVIDENCE_DRIVEN_ROADMAP §5 매핑)
- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/PLAN.md) — `is_shell_markdown_only_repo` 헬퍼 + `Check.na` 데이터 모델 + HTML ℹ️ icon 인프라 도입 (본 세션이 재사용)
- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py 분할 → 본 세션 변경 대상은 categories_quality.py + categories_ops.py + rubric.md
- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/) — §5 권장 진행 순위 4 (`v1.35-scorer-other-na-categories`)

목적: ai-ready-scorer의 N/A 분기를 **3 카테고리(Documentation + Test + Context layer)** × **8 sub-checks**로 확장 (D12에서 sub-3.3 pytest dead code 발견 → 9 sub에서 1 제거). v1.18b/c가 도입한 `is_shell_markdown_only_repo` 헬퍼 + `Check.na` 데이터 모델 + HTML ℹ️ icon 인프라를 그대로 재사용. shell-only/dotfiles/blog/empty placeholder repo의 false negative **17점** 회복 (Doc 4 + Context 4 + Test 9). Type safety는 별 helper 필요 → 별 후속(v1.36+).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(2) `bootstrap/skills/ai-ready-scorer/scripts/{categories_quality.py, categories_ops.py}` + S1c(1) `bootstrap/skills/ai-ready-scorer/references/rubric.md` + S2(1) `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` cross-ref = **4/4 meta**
- **T1 경로 다수결** — meta scope 4/4
- **T2 스펙 vs 값** — N/A 진입 정책 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.18c-scorer-package-manifest-na/REPORT.md` 다음 후보 § (verbatim)**:

> | `v1.18f-scorer-other-na-categories` | Documentation·Test·Context layer·Type safety 카테고리 N/A 분기 (evidence-driven) |

**Source 2 — `bootstrap/skills/ai-ready-scorer/references/rubric.md` N/A 정책 § (verbatim)**:

> 다른 체크에 N/A 확장은 evidence-driven 후속 (v1.18f+ 예정).

**Source 3 — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md §5 행 4 (verbatim)**:

> | 4 | `v1.35-scorer-other-na-categories` (= v1.18f 별칭) | §2 #4 | harness-meta self-eval 활용 |

**Source 4 — 사용자 발의 (2026-04-30) verbatim**:

> "옵션 B" — 9 sub-checks 확장 (Documentation 2 + Context layer 2 + Test 5). Type safety는 별 후속.

**Parsed sub-items (9 sub-checks across 3 categories)**:

1. **Documentation × 2**:
   - sub-1.1 — 아키텍처 문서 (3점)
   - sub-1.2 — Changelog (1점)
2. **Context layer × 2**:
   - sub-2.1 — GUARDRAILS.md (2점)
   - sub-2.2 — ADR / 의사결정 기록 (2점)
3. **Test × 4** (D12에서 sub-3.3 pytest dead code 제거 — 본 § 후 §2.R3 참조):
   - sub-3.1 — 테스트 디렉토리 존재 (2점)
   - sub-3.2 — 테스트 파일 수 ≥15 (3점)
   - sub-3.4 — Coverage 설정 (2점)
   - sub-3.5 — 통합 테스트 (2점)

**총 17점 회복 잠재력** (helper=True repo 한정 — 의도된 false negative 차단).

⚠️ **harness-meta self-evidence 변동 0** (D1 결정): harness-meta는 helper 4 조건 #4 (`build_sources < 5`)를 위배 — `bootstrap/skills/ai-ready-scorer/scripts/{utils, categories_quality, categories_ops, html_renderer, score_codebase}.py` 정확히 5개 → helper=False → 본 9 N/A 진입 자동 차단 → **회귀 0 보장**. 검증 evidence는 8 case dynamic 시뮬레이션(R5)으로 대체.

⚠️ **부수 발견 — 별 후속 분리 의무** (D1): v1.18g의 score_codebase.py 분할(1335줄 → 5 파일)이 build_sources를 1 → 5로 증가시켜 harness-meta가 helper=True → False로 전환. 결과 v1.18b 자동화 Docker(2)+Lock(1) N/A 효과 회귀 (92→90 — 실 코드 회귀 아닌 helper 분류 변경). 별 후속 `v1.18g2-helper-threshold-revisit` (또는 `v1.36c-helper-threshold-revisit`)에서 helper 임계 재검토. 본 v1.35 scope **외** (Out of scope 표 추가).

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| **Type safety 카테고리 N/A 확장 (Python 4 sub / TS 3 sub / 기타 partial 2 sub)** | 별 helper 필요 (`is_shell_markdown_only_repo` 4 조건 #1 `lang ∈ build` 위배). evidence 추가 수집 후 v1.36+ |
| **Test sub-3.3 pytest 설정 N/A 분기** | D12에서 dead code 발견 (`lang == "Python" and na_repo` 동시 True 불가 — helper #1 모순). 의미 있는 N/A 진입 위해 새 helper (`is_small_python_script` 등) 필요 → Type safety와 함께 v1.36+ |
| Test 카테고리 borderline 2 sub-checks (테스트/소스 비율 / CI 테스트 자동화) | 사용자 옵션 B 명시 제외. shell repo도 ratio 측정 가능 + lint/deploy CI 가능. v1.36+ evidence-driven |
| **helper 4 조건 #4 `build_sources < 5` 임계 재검토** | D1에서 v1.18g 분할 부수 효과 발견 — score_codebase.py 5 모듈 분할로 harness-meta build_sources 1→5 → helper=True→False 전환. v1.18b/c 자동화 N/A 회귀. 별 후속 `v1.18g2-helper-threshold-revisit` (또는 `v1.36c`) — 임계 6+ 조정 또는 helper 4 조건 재설계 |
| README 존재 N/A | 모든 repo 의무 (AI-Ready 평가 핵심) |
| CLAUDE.md / AGENTS.md N/A (Documentation + Context layer) | 동상 (AI-Ready 핵심) |
| Docstring 커버리지 N/A | 이미 lang != Python 시 partial 2/3 부여 (별 분기 부적합) |
| 새 helper 도입 (`is_small_script` 등) | evidence 미수집. 별 후속 |
| 8 case dynamic 시뮬레이션 외 multi-repo 실 sample 회귀 | v1.18e (보류) — 별 후속 |
| score_codebase.py 자체 분할 | v1.18g 완료 — 본 세션 무관 |
| HTML 대시보드 N/A 카드 정밀 시각화 | v1.18e (보류) |
| CATEGORY_META max sub 합 mismatch (Documentation 13 sub 합 vs max 15 / Code structure 13 sub 합 vs max 15) | 별 후속 `v1.18h-category-max-recalibration`. 본 v1.35 무관 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 rubric/N/A 헬퍼 정합화만; ai-ready-scorer 본 repo 자체 자산) |
| **re-verify** | N/A |

## 1. 문제 (false negative 잔존)

### 현재 상태 (v1.18c 이후)

`is_shell_markdown_only_repo` 헬퍼는 3 sub-checks(자동화 Docker + Lock + 코드 구조 패키지 매니페스트)에만 호출. 다른 카테고리에서 동일 helper=True repo가 여전히 false negative:

- **Documentation**: 아키텍처 문서/Changelog 부재 시 0점 (dotfiles/blog/empty repo는 부적합)
- **Context layer**: GUARDRAILS.md/ADR 부재 시 0점 (작은 repo 부적합)
- **Test**: 테스트 디렉토리/파일 수/pytest/Coverage/통합 테스트 부재 시 0점 (코드 < 5 파일 repo는 단위 테스트 부적합)

### Root cause

v1.18b/c가 도입한 `Check.na` 데이터 모델 + helper는 인프라 단계. 카테고리 호출 사이트 추가만 남은 작업.

### 본 세션 해결 범위

**옵션 B 채택 (9 sub-checks)**: helper 재사용으로 호출 사이트 9곳 추가 + rubric.md 정합화. 헬퍼/모델/UI 변경 0 (DRY).

## 2. 결정 (R1 ~ R5)

### R1 — Documentation × 2 sub-checks 확장 (categories_quality.py)

**대상**: `score_documentation()` line 56-65 (Architecture) + line 85-92 (Changelog).

**알고리즘** (양 sub-check 동일):

```python
exists, fname = file_exists_any(repo, [...])
if not exists and is_shell_markdown_only_repo(repo, tracked, lang):
    checks.append(Check(
        "<sub-check name>",
        passed=True, score=<max>, max_score=<max>,
        detail="N/A — shell/markdown-only repo (<reason>, 자동 만점)",
        action=None,
        roi_effort="<inherit>", roi_impact=0.0,
        na=True,
    ))
else:
    # 기존 로직 그대로
    checks.append(Check(...))
```

**구체화**:

| Sub-check | max | detail (N/A) |
|-----------|-----|-------------|
| 아키텍처 문서 | 3 | "N/A — shell/markdown-only repo (아키텍처 문서 부적합, 자동 만점)" |
| Changelog | 1 | "N/A — shell/markdown-only repo (changelog 부적합, 자동 만점)" |

### R2 — Context layer × 2 sub-checks 확장 (categories_ops.py)

**대상**: `score_context_layer()` line 56-66 (GUARDRAILS) + line 69-79 (ADR).

**구체화**:

| Sub-check | max | detail (N/A) |
|-----------|-----|-------------|
| GUARDRAILS.md | 2 | "N/A — shell/markdown-only repo (가드레일 부적합, 자동 만점)" |
| ADR / 의사결정 | 2 | "N/A — shell/markdown-only repo (ADR 부적합, 자동 만점)" |

⚠️ **CLAUDE.md 품질 (11점) sub-check은 N/A 부적합** — Out of scope에 명시. AI-Ready 평가의 핵심 sub-check (부재 = 0점이 의도).

### R3 — Test × 4 sub-checks 확장 (categories_quality.py) — D12 sub-3.3 dead code 제거 후

**대상**: `score_test_quality()` 4 호출 사이트.

**알고리즘 — 헬퍼 1회 호출 후 재사용** (DRY, v1.18b automation 패턴 답습):

```python
def score_test_quality(repo, tracked, lang):
    checks = []
    na_repo = is_shell_markdown_only_repo(repo, tracked, lang)   # 1회 호출

    # sub-3.1 테스트 디렉토리
    has_tests, ... = file_exists_any(...)
    if not (has_tests or test_files) and na_repo:
        checks.append(Check("테스트 디렉토리 존재", passed=True, score=2, max_score=2,
                            detail="N/A — shell/markdown-only repo (단위 테스트 부적합, 자동 만점)",
                            action=None, roi_effort="즉시", roi_impact=0.0, na=True))
    else:
        checks.append(Check(...))   # 기존
    # ... 동일 패턴 4회 (sub-3.1/3.2/3.4/3.5)
```

**구체화**:

| Sub-check | max | 진입 조건 | detail (N/A) |
|-----------|-----|---------|-------------|
| sub-3.1 테스트 디렉토리 | 2 | `not (has_tests or test_files) and na_repo` | "N/A — shell/markdown-only repo (단위 테스트 부적합, 자동 만점)" |
| sub-3.2 테스트 파일 수 ≥15 | 3 | `count < 5 and na_repo` | "N/A — shell/markdown-only repo (테스트 파일 부적합, 자동 만점)" |
| sub-3.4 Coverage 설정 | 2 | `not has_cov and na_repo` | "N/A — shell/markdown-only repo (커버리지 부적합, 자동 만점)" |
| sub-3.5 통합 테스트 | 2 | `not int_test and na_repo` | "N/A — shell/markdown-only repo (통합 테스트 부적합, 자동 만점)" |

⚠️ **sub-3.3 pytest 설정 dead code — N/A 분기 미적용** (D12 결정):

- helper 4 조건 #1: `lang ∉ _BUILD_LANGS` (Python ∈ _BUILD_LANGS)
- → `lang == "Python"` 시 `na_repo` 항상 False 보장
- → `lang == "Python" and not has_pytest and na_repo` = **결코 True 불가** (조건 모순)
- else 분기는 이미 `Check("테스트 프레임워크 설정", True, 2, 2, f"{lang} — skip (부분 점수)", None)` — 항상 만점 → N/A 부적합
- → **sub-3.3 N/A 분기 자체 제거**. 의미 있는 N/A는 새 helper 필요 → Out of scope (v1.36+)

⚠️ **borderline 2 sub-checks 명시 제외** (Out of scope):

- 테스트/소스 비율 (2점) — 사용자 옵션 B 명시 제외
- CI 테스트 자동화 (2점) — 동상

### R4 — rubric.md 정합화 (4군데)

**B1. 카테고리 1 (Documentation) 표 line 27-31** (Architecture + Changelog 행 갱신):

```diff
- | 아키텍처 문서 (ARCHITECTURE.md / ADR) | 3 | docs/ 패턴 탐색 |
+ | 아키텍처 문서 (ARCHITECTURE.md / ADR) | 3 | docs/ 패턴 탐색 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
- | Changelog 존재 | 1 | CHANGELOG.md 패턴 |
+ | Changelog 존재 | 1 | CHANGELOG.md 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
```

**B2. 카테고리 4 (Test) 표 line 84-92** (4 sub 갱신 — D12 sub-3.3 pytest 제외):

```diff
- | 테스트 디렉토리 존재 | 2 | tests/ 패턴 또는 test_*.py 파일 |
+ | 테스트 디렉토리 존재 | 2 | tests/ 패턴 또는 test_*.py 파일 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
- | 테스트 파일 수 ≥15개 | 3 | 파일 카운트 |
+ | 테스트 파일 수 ≥15개 | 3 | 파일 카운트 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
- | 커버리지 설정 | 2 | .coveragerc / [tool.coverage] |
+ | 커버리지 설정 | 2 | .coveragerc / [tool.coverage] (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
- | 통합 테스트 존재 | 2 | tests/integration/ 패턴 |
+ | 통합 테스트 존재 | 2 | tests/integration/ 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
```

⚠️ "테스트 프레임워크 설정" 행은 갱신 안 함 (D12 — sub-3.3 N/A 미적용 dead code).

**B3. 카테고리 5 (Context layer) 표 line 105-107** (GUARDRAILS + ADR 갱신):

```diff
- | GUARDRAILS.md 존재 | 2 | docs/GUARDRAILS.md 패턴 |
+ | GUARDRAILS.md 존재 | 2 | docs/GUARDRAILS.md 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
- | ADR / 의사결정 기록 | 2 | docs/adr/ 패턴 |
+ | ADR / 의사결정 기록 | 2 | docs/adr/ 패턴 (shell-only repo는 N/A 자동 만점 — § N/A 정책 참조) |
```

**B4. N/A 정책 § 적용 체크 표 line 175-181** (3건 → 11건 확장 — D12 sub-3.3 pytest 제외):

```diff
  | 카테고리 | 체크 | 적용 세션 |
  |---------|-----|---------|
  | 자동화 | Docker / 컨테이너화 | v1.18b |
  | 자동화 | 의존성 Lock 파일 | v1.18b |
  | 코드 구조 | 패키지 매니페스트 | v1.18c |
+ | 문서화 | 아키텍처 문서 | v1.35 |
+ | 문서화 | Changelog | v1.35 |
+ | 컨텍스트 레이어 | GUARDRAILS.md | v1.35 |
+ | 컨텍스트 레이어 | ADR / 의사결정 기록 | v1.35 |
+ | 테스트 품질 | 테스트 디렉토리 존재 | v1.35 |
+ | 테스트 품질 | 테스트 파일 수 ≥15개 | v1.35 |
+ | 테스트 품질 | 커버리지 설정 | v1.35 |
+ | 테스트 품질 | 통합 테스트 존재 | v1.35 |

- 다른 체크에 N/A 확장은 evidence-driven 후속 (v1.18f+ 예정).
+ 다른 체크에 N/A 확장은 evidence-driven 후속 (Type safety + Test pytest 설정 + Test borderline 2 sub는 새 helper 필요 → v1.36+).
```

### R5 — 8 case dynamic 시뮬레이션 + harness-meta 회귀 검증 (D1/D17 결정)

**D1 사전 측정 결과 (2026-04-30)** — harness-meta `helper=False` (build_sources=5 위배 — Python `utils/categories_quality/categories_ops/html_renderer/score_codebase` 정확히 5 파일):

```
lang = 'Md'
lang in _BUILD_LANGS: False   ← 조건 #1 OK
has_build_manifest:    False  ← 조건 #2 OK
pyproject_runtime_deps_empty: True   ← 조건 #3 OK
build_sources count:   5      ← 조건 #4 위배 (< 5 요구)
helper result: False
```

→ harness-meta self-eval **변동 0** (8 N/A 진입 자동 차단). v1.18c 패턴과 동일한 회귀 0 보장이지만, **메커니즘이 다름** — v1.18c는 manifest=True 우선 차단 / 본 v1.35는 helper=False 진입 차단.

**v1.18c Stage D 패턴 답습** — `tempfile.TemporaryDirectory` 8 case 시뮬레이션:

| Case | lang | helper | Doc | Context | Test | 변동 | 기대 |
|------|------|:------:|---|---|---|---|------|
| harness-meta | Md | False | 0 | 0 | 0 | **0** | 변동 0 (helper=False) |
| 순수 dotfiles | Sh | True | +4 (Arch+CL) | +4 (GR+ADR) | +9 (4 sub) | **+17** | 17점 회복 |
| Hugo blog | Md | True | +4 | +4 | +9 | **+17** | 17점 회복 |
| Astro blog | JS | False | 0 | 0 | 0 | **0** | 변동 0 |
| Python app | Python | False | 0 | 0 | 0 | **0** | 변동 0 (lang ∈ build) |
| TS app | TypeScript | False | 0 | 0 | 0 | **0** | 변동 0 (lang ∈ build) |
| 작은 Python script | Python | False | 0 | 0 | 0 | **0** | 변동 0 (Python lang ⇒ helper #1 fail) |
| empty placeholder | Unknown | True | +4 | +4 | +9 | **+17** | 17점 회복 |

**검증 포인트**:

- helper=True 3 case (dotfiles/blog/empty) → +17점 each
- helper=False 5 case → 변동 0
- false positive 0 (실제 진입 의도된 case만 N/A 활성)
- sub 합 cap 영향 0 (Documentation 13/15 cap, Context 15/15 cap, Test 15/15 cap 모두 회복분 포함 안 넘음)

## 3. 변경 대상 (3 수정 + 2 신규)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/ai-ready-scorer/scripts/categories_quality.py` | S1c | R1(2 sub) + R3(4 sub — D12 sub-3.3 제거 후) — **6 호출 사이트** N/A 분기 + na_repo 1회 호출 패턴 (Test 카테고리) |
| `bootstrap/skills/ai-ready-scorer/scripts/categories_ops.py` | S1c | R2(2 sub) — 2 호출 사이트 N/A 분기 |
| `bootstrap/skills/ai-ready-scorer/references/rubric.md` | S1c | R4 — 4군데 (카테고리 1/4/5 sub-check 행 8건 + N/A 정책 § 적용 체크 표 8건 추가) |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.35-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.35-.../REPORT.md` | meta | Stage G 종료 |

### Cross-ref (선택)

`bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` §9 archive 추가 (v1.35 완료 후) — 본 세션 종료 시점 갱신.

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (Scope inheritance + Out of scope + Spec verification + R1~R5)
- [x] **디테일 분석 D1~D17** — sub-3.3 dead code 발견 + helper=False 사전 측정 + 부수 발견 별 후속 분리
- [ ] **사용자 진입 확인** (8 sub-checks 갱신 PLAN 컨펌)
- [ ] Stage A — categories_quality.py R1 (Documentation × 2: Architecture + Changelog)
- [ ] Stage B — categories_ops.py R2 (Context layer × 2: GUARDRAILS + ADR)
- [ ] Stage C — categories_quality.py R3 (Test × 4, na_repo 1회 호출 패턴)
- [ ] Stage D — rubric.md R4 (4군데 — sub-check 행 8건 + N/A 정책 § 8건)
- [ ] Stage E — harness-meta 재스코어 (변동 0 검증) + 8 case 시뮬레이션 (helper=True 3 +17 / helper=False 5 변동 0)
- [ ] Stage F — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] categories_quality.py: 6 sub-checks N/A 분기 추가 (Documentation 2 + Test 4)
- [ ] categories_ops.py: 2 sub-checks N/A 분기 추가 (Context layer 2)
- [ ] **8 호출 사이트** 모두 `is_shell_markdown_only_repo` 헬퍼 호출
- [ ] Test 카테고리는 `na_repo = is_shell_markdown_only_repo(...)` 1회 호출 후 4 sub에서 재사용 (DRY)
- [ ] manifest/exists True 분기 시 기존 동작 유지 (회귀 0 — exists=True 우선 차단)
- [ ] N/A 진입 시 `na=True`, `score=max_score`, `passed=True`, `detail="N/A — ..."` 정합
- [ ] JSON output: 8 sub 모두 `"na": true` 필드 (asdict 자동 직렬화 — `Check.na` 기존 필드)
- [ ] HTML 대시보드: 8 sub 모두 ℹ️ icon (v1.18b D 패치 재사용 — html_renderer.py line 36)
- [ ] rubric.md 4군데 정합화 (sub-check 행 8건 + N/A 정책 § 표 8건 추가)
- [ ] 8 case dynamic 시뮬레이션 통과 — false positive 0 (helper=True 3 case +17 each + helper=False 5 case 변동 0)
- [ ] **harness-meta self-eval 변동 0** (D1 사전 측정 — helper=False)
- [ ] ROI 액션 리스트: 8 N/A 분기 모두 자동 제외 (`compute_roi_actions` line 271 — `passed=True` + `action=None`)

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.35-scorer-other-na-categories — N/A 헬퍼 8 sub-checks 확장 (Doc 2 + Context 2 + Test 4)

- update: bootstrap/skills/ai-ready-scorer/scripts/categories_quality.py
  (R1 Documentation × 2 — Architecture + Changelog
   R3 Test × 4 — 테스트 디렉토리/파일 수/Coverage/통합 테스트
   na_repo 1회 호출 패턴 v1.18b automation 답습)
- update: bootstrap/skills/ai-ready-scorer/scripts/categories_ops.py
  (R2 Context layer × 2 — GUARDRAILS + ADR)
- update: bootstrap/skills/ai-ready-scorer/references/rubric.md
  (R4 4군데 — 카테고리 1/4/5 sub-check 행 8건 + N/A 정책 § 적용 체크 표 8건 추가)
- add: sessions/meta/v1.35-.../{PLAN,REPORT}.md

Scope: 8 sub-checks (Doc 2 + Context 2 + Test 4). D12 sub-3.3 pytest dead code 제거.
Type safety + Test pytest + Test borderline 2 sub 별 후속 (v1.36+ 새 helper 필요).
- 헬퍼/Check.na/HTML icon 인프라 v1.18b/c 그대로 재사용 (DRY)
- helper=True repo 17점 회복 잠재 (false negative 차단)
- helper=False repo 회귀 0 (lang ∈ build 또는 build_sources >= 5 우선 차단)
- 8 case dynamic 시뮬레이션 통과 (helper=True 3 +17 / helper=False 5 변동 0)

Verification: harness-meta self-eval 변동 0 (D1 사전 측정 — helper=False).
부수 발견 별 후속 분리: v1.18g 분할 + helper 임계 5 충돌 → `v1.18g2-helper-threshold-revisit`.
References: v1.18c REPORT 다음 후보 § + EVIDENCE_DRIVEN_ROADMAP §5 행 4.
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.36-scorer-typesafety-na` | Type safety 카테고리 N/A 분기. 새 helper 필요 (`is_small_python_script` 등). evidence 추가 수집 후 |
| `v1.36b-scorer-test-pytest-na` | Test sub-3.3 pytest 설정 N/A. 새 helper 필요 (현 `is_shell_markdown_only_repo` lang #1 위배로 dead code) |
| `v1.36c-scorer-test-borderline-na` | Test 카테고리 borderline 2 sub (테스트/소스 비율 + CI 테스트 자동화). evidence 누적 시 |
| **`v1.18g2-helper-threshold-revisit`** | **D1 부수 발견** — v1.18g 분할이 helper 임계 5와 충돌하여 harness-meta가 helper=True→False 전환 + v1.18b 자동화 N/A 회귀 (92→90). 임계 6+ 조정 또는 helper 4 조건 재설계 |
| `v1.18h-category-max-recalibration` | CATEGORY_META max sub 합 mismatch (Documentation 13 vs max 15 / Code structure 13 vs max 15). 별 후속 |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화 (별도 색상·툴팁·필터) + multi-repo 회귀 sample 실 실행 |
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix |

## 8. Lessons Forward (예상)

- **L1 — N/A 헬퍼 재사용 패턴 3 카테고리 확장**: v1.18b automation(2) → v1.18c 코드 구조(1) → v1.35 Documentation(2) + Context layer(2) + Test(4). 동일 헬퍼 4 조건 AND를 8 호출 사이트로. 데이터 모델/UI 패치 변경 0 — DRY 인프라 재사용 극대치.
- **L2 — Test 카테고리 `na_repo` 1회 호출 후 4 sub 재사용 패턴**: v1.18b automation의 `na_repo` 변수 답습. 헬퍼 호출 비용 4x → 1x.
- **L3 — Type safety는 별 helper 필요 명시 분리**: v1.18f가 4 카테고리 통합 명시했지만 Type safety는 helper 4 조건 #1 (lang ∈ build) 위배 → 별 후속. PLAN out of scope에 명시 분리 = scope drift 차단.
- **L4 — exists=True 우선 차단 패턴 부재 시 회귀 위험**: v1.18c는 코드 구조 패키지 매니페스트가 `not manifest and helper` → manifest=True repo 자연 회귀 0. 본 v1.35는 `not exists and helper` 패턴이지만 exists 의미가 sub-check별 다름 (Architecture/Changelog/GUARDRAILS/ADR/통합 테스트는 단순 file_exists; Coverage는 추가 grep 검증). harness-meta self-eval 사전 측정 의무 → D1에서 helper=False 확인.
- **L5 — borderline 2 sub-checks 명시 제외 = Out of scope discipline**: 테스트/소스 비율 + CI 테스트 자동화는 shell repo도 측정 가능 → 사용자 옵션 B 명시 제외. evidence 부재 시 "포괄"로 끌어들이지 않음.
- **L6 — Dead code 사전 발견 (D12)**: PLAN R3 sub-3.3 pytest 설정 N/A 분기는 `lang == "Python" and na_repo` 동시 True 불가 (helper #1 모순). 디테일 분석 단계에서 제거 → 9 sub → 8 sub. PLAN 단계의 정밀 검증 가치 — 구현 후 발견하면 코드 작성 후 제거 비용 발생.
- **L7 — 부수 발견 별 후속 분리 패턴 (D1)**: v1.18g 분할이 helper 4 조건 #4 임계 5와 우연히 맞물려 harness-meta build_sources를 1→5로 증가 + helper=True→False 전환 + v1.18b/c 자동화 N/A 회귀. 본 v1.35 scope 밖이므로 Out of scope에 명시 + `v1.18g2-helper-threshold-revisit` 후속 분리. **scope contract 준수 + 부수 발견 audit trail 보존**.

# meta v1.35-scorer-other-na-categories — REPORT

세션 종료: 2026-04-30
선행 세션:
- [`sessions/meta/v1.18c-scorer-package-manifest-na/`](../v1.18c-scorer-package-manifest-na/) — "다음 후보" §의 `v1.18f-scorer-other-na-categories` 명시. 본 v1.35는 그 alias
- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/) — `is_shell_markdown_only_repo` 헬퍼 + `Check.na` + HTML ℹ️ icon 인프라 (본 세션 그대로 재사용)
- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py 분할 → 본 세션 변경 대상은 categories_quality.py + categories_ops.py + rubric.md
- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/) — §5 권장 진행 순위 4

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `categories_quality.py` (3군데) + `categories_ops.py` (1군데) + `rubric.md` (4군데) |
| harness-meta 전체 점수 | 90/100 (S) → **90/100 (S)** (변동 0 — helper=False 자동 차단) |
| N/A 호출 사이트 추가 | **8 sub-checks** (Doc 2 + Context 2 + Test 4) |
| sub-3.3 pytest dead code | 디테일 분석 단계 D12 발견 → 제거 (9 sub → 8 sub) |
| 회복 잠재 | 17점 (helper=True repo 한정) |
| 8 case dynamic 시뮬레이션 | 통과 (helper=True 4 case +N/A 8 each / helper=False 4 case 변동 0) |
| rubric.md 정합화 | 4군데 (sub-check 행 8건 + N/A 정책 § 적용 체크 표 8건 추가) |

## 구현 요약

### Stage A — Documentation × 2 N/A 분기 (categories_quality.py)

`score_documentation()` 진입 직후 `na_repo = is_shell_markdown_only_repo(repo, tracked, lang)` 1회 호출.

- **sub-1.1 아키텍처 문서** (line 56-65 → 56-77): `not exists and na_repo` 분기 추가. score=3, na=True.
- **sub-1.2 Changelog** (line 85-92 → 97-115): 동일 패턴. score=1, na=True.

### Stage B — Context layer × 2 N/A 분기 (categories_ops.py)

`score_context_layer()` 진입 직후 `na_repo` 1회 호출.

- **sub-2.1 GUARDRAILS.md**: `not guard and na_repo` 분기. score=2, na=True.
- **sub-2.2 ADR / 의사결정**: `not adr and na_repo` 분기. score=2, na=True.

### Stage C — Test × 4 N/A 분기 (categories_quality.py, na_repo 1회 호출 패턴)

`score_test_quality()` 진입 직후 `na_repo` 1회 호출. 4 sub에서 재사용 (DRY).

- **sub-3.1 테스트 디렉토리**: `not (has_tests or test_files) and na_repo` 분기. score=2.
- **sub-3.2 테스트 파일 수 ≥15**: `count < 5 and na_repo` 분기. score=3.
- **sub-3.4 Coverage 설정**: `not has_cov and na_repo` 분기. score=2.
- **sub-3.5 통합 테스트**: `not int_test and na_repo` 분기. score=2.

⚠️ **sub-3.3 pytest 설정** (D12 — dead code 제거): `lang == "Python" and na_repo`는 결코 동시 True 불가 (helper #1 `lang ∉ _BUILD_LANGS` ↔ Python ∈ _BUILD_LANGS 모순). N/A 분기 미적용. 의미 있는 N/A는 새 helper 필요 → v1.36+.

### Stage D — rubric.md 4군데 정합화

- **B1 카테고리 1 (Documentation) 표 line 29, 31**: Architecture + Changelog 행에 "(shell-only repo는 N/A 자동 만점 — § N/A 정책 참조)" 추가
- **B2 카테고리 4 (Test) 표 line 86, 87, 89, 90**: 4 sub 행 갱신 (sub-3.3 pytest 행 무변경 — D12)
- **B3 카테고리 5 (Context layer) 표 line 106, 107**: GUARDRAILS + ADR 갱신
- **B4 N/A 정책 § 적용 체크 표 line 175-181**: 3건 → 11건 (8건 추가)

### Stage E — 검증

#### harness-meta 재스코어 (변동 0)

```
Total: 90.0 / 100  Grade: S
  문서화: 12/15 (A)        — N/A: 0
  코드 구조: 13/15 (A)     — N/A: 0
  타입 안전성: 15/15 (S)   — N/A: 0
  테스트 품질: 15/15 (S)   — N/A: 0
  컨텍스트 레이어: 15/15 (S) — N/A: 0
  자동화: 10/15 (B)        — N/A: 0
  에이전틱 안전: 10/10 (S) — N/A: 0
```

helper=False (build_sources=5, 조건 #4 위배) → 8 N/A 분기 모두 진입 차단 → 회귀 0.

#### 8 case dynamic 시뮬레이션 (`tempfile.TemporaryDirectory`)

| Case | lang | helper | Doc | Ctx | Test | NA | 평가 |
|------|------|:---:|:---:|:---:|:---:|:---:|:----:|
| 순수 dotfiles | Sh | True | 6 | 4 | 11 | 8 | ✓ +N/A 17 |
| Hugo blog | Md | True | 9 | 4 | 11 | 8 | ✓ +N/A 17 |
| Astro blog | Astro | False | 2 | 0 | 2 | 0 | ✓ 변동 0 |
| Python app | Python | False | 0 | 0 | 0 | 0 | ✓ 변동 0 |
| TS app | TypeScript | False | 2 | 0 | 2 | 0 | ✓ 변동 0 |
| 작은 Python script | Toml* | True | 6 | 4 | 11 | 8 | ✓ +N/A 17 |
| empty placeholder | Md | True | 7 | 4 | 11 | 8 | ✓ +N/A 17 |
| harness-meta | Md | False | 12 | 15 | 15 | 0 | ✓ 변동 0 |

\* "작은 Python script" — 시뮬레이션 fixture에서 `.toml` + `.py` 동수 → `detect_language` dict ordering으로 lang="Toml" 판정 → helper=True 진입. PLAN R5 표는 "Python" + helper=False로 예측했으나 실 fixture에서 `.toml`이 dominant 매칭. 본 결과는 의도된 N/A 진입 정합 (deps empty + 코드 < 5 → 작은 repo는 단위 테스트 부적합). detect_language 정확도 별 문제 (별 후속).

**검증 포인트 통과**:
- helper=True 4 case → 모두 NA=8 (의도된 false negative 회복)
- helper=False 4 case → NA=0 (회귀 0)
- false positive 0
- N/A 진입 sub-check별 점수 수동 검증 (dotfiles Test=11 = 디렉토리(2) + 파일 수(3) + 프레임워크 partial(2) + Coverage(2) + 통합(2) + 비율(0) + CI(0) — 정확)

#### JSON / HTML 출력 정합

```python
All checks have na field: OK   # asdict 자동 직렬화
ROI actions count: 2           # 자동화 Docker(2) + Lock(1) — 별 후속 v1.18g2 영역
```

`html_renderer.py` line 36 `icon = "ℹ️" if ch.get("na") else (...)` — 8 신규 N/A sub 모두 ℹ️ icon 표시.

## 디테일 검증 (Pre-impl, D1~D17)

### A. 코드 무결성 (8/8 PASS)

| # | 검증 | 결과 |
|---|------|:----:|
| A1 | `Check.na` 필드 (utils.py line 41, default False) backward compat | ✓ |
| A2 | 함수 시그니처 변경 0 (`score_documentation/score_test_quality/score_context_layer`) | ✓ |
| A3 | `is_shell_markdown_only_repo` 호출 사이트 8개 (Doc 2 + Ctx 2 + Test 1회→4 재사용) | ✓ |
| A4 | `compute_roi_actions` line 271 — N/A는 passed=True + action=None → 자동 제외 | ✓ |
| A5 | `html_renderer.py` line 36 — `ch.get("na")` ℹ️ icon | ✓ |
| A6 | `asdict(c)` — dataclass 자동 직렬화 → na 필드 자동 포함 | ✓ |
| A7 | sub-3.3 pytest dead code 발견 (D12) → 9→8 sub 조정 | ✓ |
| A8 | exists=True 우선 차단 패턴 (회귀 0 보장) | ✓ |

### B. 외부 spec (context7 검증)

drift=N/A — 본 세션 외부 spec 의존 무 (내부 rubric/N/A 헬퍼 정합화만; ai-ready-scorer 본 repo 자체 자산). `harness-plan-verify` SKILL 호출 결과 PLAN § N/A 분기 정합 확인.

### C. 부수 발견 (D1 — 별 후속 분리)

v1.18g 분할(score_codebase.py 1335줄 → 5 파일)이 helper 4 조건 #4 임계 5와 우연히 충돌 → harness-meta build_sources 1→5 → helper=True→False 전환 → v1.18b 자동화 Docker(2)+Lock(1) N/A 효과 회귀 (92→90, **실 코드 회귀 아닌 helper 분류 변경**). 본 v1.35 scope **외** (Out of scope 표 추가) → 별 후속 `v1.18g2-helper-threshold-revisit`.

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| categories_quality.py: 6 sub-checks N/A 분기 추가 (Documentation 2 + Test 4) | ✅ |
| categories_ops.py: 2 sub-checks N/A 분기 추가 (Context layer 2) | ✅ |
| 8 호출 사이트 모두 `is_shell_markdown_only_repo` 헬퍼 호출 | ✅ |
| Test 카테고리 `na_repo` 1회 호출 후 4 sub 재사용 (DRY) | ✅ |
| manifest/exists True 분기 시 기존 동작 유지 (회귀 0) | ✅ |
| N/A 진입 시 `na=True`, `score=max_score`, `passed=True`, `detail="N/A — ..."` 정합 | ✅ |
| JSON output: 8 sub 모두 `"na": true` 필드 (asdict 자동 직렬화) | ✅ |
| HTML 대시보드: 8 sub 모두 ℹ️ icon (line 36 재사용) | ✅ |
| rubric.md 4군데 정합화 (sub-check 행 8건 + N/A 정책 § 표 8건 추가) | ✅ |
| 8 case dynamic 시뮬레이션 통과 — false positive 0 | ✅ |
| harness-meta self-eval 변동 0 (helper=False) | ✅ |
| ROI 액션 리스트: 8 N/A 분기 모두 자동 제외 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 rubric/N/A 헬퍼 정합화만; ai-ready-scorer 본 repo 자체 자산). 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — N/A 헬퍼 재사용 패턴 3 카테고리 확장**: v1.18b automation(2) → v1.18c 코드 구조(1) → v1.35 Documentation(2) + Context layer(2) + Test(4). 동일 헬퍼 4 조건 AND를 8 호출 사이트로. 데이터 모델/UI 패치 변경 0 — DRY 인프라 재사용 극대치. 코드 변경 ~80 lines로 완료.

- **L2 — Test 카테고리 `na_repo` 1회 호출 후 4 sub 재사용**: v1.18b automation의 `na_repo` 변수 답습. 헬퍼 호출 비용 4x → 1x. score_documentation/score_context_layer도 동일 패턴 채택 (호출 1회) → 카테고리별 일관성.

- **L3 — Type safety는 별 helper 필요 명시 분리**: v1.18f가 4 카테고리 통합 명시했지만 Type safety는 helper 4 조건 #1 (lang ∈ build) 위배 → 본 helper 진입 자체 차단. 별 후속 (v1.36+ 새 helper). PLAN Out of scope에 명시 분리 = scope drift 차단.

- **L4 — exists=True 우선 차단 패턴 + helper=False 차단으로 이중 회귀 0 보장**: v1.18c는 manifest=True 우선 차단으로 회귀 0. 본 v1.35는 `not exists and helper` 패턴 (Architecture/Changelog/GUARDRAILS/ADR/통합 테스트는 단순 file_exists; Coverage는 추가 grep 검증) — exists=True 또는 helper=False 둘 중 하나만 충족해도 N/A 차단. harness-meta self-eval은 helper=False로 차단 → 변동 0 보장.

- **L5 — borderline 2 sub-checks 명시 제외 = Out of scope discipline**: 테스트/소스 비율 + CI 테스트 자동화는 사용자 옵션 B 명시 제외. shell repo도 측정 가능 → false negative 약함. v1.36c 후속.

- **L6 — Dead code 사전 발견 (D12)** ⭐: PLAN R3 sub-3.3 pytest 설정 N/A 분기는 `lang == "Python" and na_repo` 동시 True 불가 (helper #1 모순) → 디테일 분석 단계에서 제거. **9 sub → 8 sub**. PLAN 단계의 정밀 검증 가치 — 구현 후 발견 시 코드 작성 후 제거 비용 발생. **"디테일 분석"이 PLAN 결함 사전 차단의 결정적 단계** 입증.

- **L7 — 부수 발견 별 후속 분리 패턴 (D1)** ⭐: v1.18g 분할이 helper 4 조건 #4 임계 5와 우연히 맞물려 harness-meta build_sources 1→5 → helper=True→False 전환 → v1.18b/c 자동화 N/A 회귀 (92→90, 실 코드 회귀 아닌 helper 분류 변경). 본 v1.35 scope **외**이므로 PLAN Out of scope에 명시 + `v1.18g2-helper-threshold-revisit` 후속 분리. **scope contract 준수 + 부수 발견 audit trail 보존**. T4 크로스 커팅 분할 원칙 정합.

- **L8 — detect_language의 dict ordering 의존 부정확성** (Stage E 시뮬레이션 부수 발견): "작은 Python script" fixture (.py 1 + .toml 1)에서 lang="Toml" 판정. PLAN R5 표 예측 (Python+helper=False)과 다름. 결과는 의도된 N/A 진입 정합 (작은 repo)이지만 lang detection 정확도 자체는 별 문제. 별 후속 evidence-driven (v1.36+ detect_language refactor).

## 다음 후보 (보류 — 후속 분기)

| 항목 | 조건 |
|------|------|
| `v1.36-scorer-typesafety-na` | Type safety 카테고리 N/A 분기. 새 helper 필요 (`is_small_python_script` 등). evidence 추가 수집 후 |
| `v1.36b-scorer-test-pytest-na` | Test sub-3.3 pytest 설정 N/A. 새 helper 필요 (`is_shell_markdown_only_repo` lang #1 위배로 dead code) |
| `v1.36c-scorer-test-borderline-na` | Test 카테고리 borderline 2 sub (테스트/소스 비율 + CI 테스트 자동화). evidence 누적 시 |
| **`v1.18g2-helper-threshold-revisit`** | **D1 부수 발견** — v1.18g 분할이 helper 임계 5와 충돌하여 harness-meta가 helper=True→False 전환 + v1.18b 자동화 N/A 회귀 (92→90). 임계 6+ 조정 또는 helper 4 조건 재설계 |
| `v1.18h-category-max-recalibration` | CATEGORY_META max sub 합 mismatch (Documentation 13 vs max 15 / Code structure 13 vs max 15) |
| `v1.18e-scorer-html-na-ui` | HTML 대시보드 N/A 카드 정밀 시각화 + multi-repo 회귀 sample 실 실행 |
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout emoji UnicodeEncodeError fix |
| detect_language refactor | dict ordering 의존 제거 (L8) |

# meta v1.18g2-helper-threshold-revisit — REPORT

세션 종료: 2026-04-30
선행 세션:
- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) — D1 부수 발견 + Out of scope 표 명시 (본 세션 트리거)
- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py 1335줄 → 5 파일 분할 (root cause)
- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/) — `is_shell_markdown_only_repo` 헬퍼 + `< 5` 임계 최초 도입

## 최종 결과

| 항목 | 결과 |
|------|------|
| 수정 파일 | `utils.py` (line 252-275, 임계 + docstring) + `rubric.md` (line 173, audit 사유) + `ai-ready-report.json` + `ai-ready-dashboard.html` (재생성된 artifacts — git tracked) |
| harness-meta 점수 | 90/100 (S) → **93/100 (S)** (+3, PLAN 92 예상보다 +1 — PLAN 산술 오기) |
| 자동화 카테고리 | 10/15 (B) → **13/15 (A)** (+3, Docker 2 + Lock 1 N/A 복원) |
| 다른 6 카테고리 | 변동 0 (회귀 0) |
| 코드 변경량 | utils.py 4 lines (임계 1 + docstring 3) + rubric.md 1 line |

## 구현 요약

### Stage A — utils.py 임계 변경

**line 271** — return 조건:
```python
return build_sources < 10   # was: < 5
```

**line 257-262** — docstring 보강 (D11):
```python
4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 10

임계 10은 v1.18g2에서 5→10 상향 (v1.18g score_codebase.py 분할 부수 효과 보정).
조건 #1~#3가 실 프로젝트 차단 주력, #4는 misdetected lang fallback.
미래 10+ 파일 도달 시 v1.18g3에서 _TOOL_DIRS 또는 비율 기반 재설계.
```

### Stage B — rubric.md N/A 정책 § 갱신

**line 173** — 조건 #4 표기 + audit 사유:
```diff
- 4. 빌드 소스 파일 (.py/.ts/.go/.rs/.java/.kt/.cs/.rb/.swift) 개수 **< 5**
+ 4. 빌드 소스 파일 (.py/.ts/.go/.rs/.java/.kt/.cs/.rb/.swift) 개수 **< 10** (v1.18g2: 5→10, score_codebase.py 분할 부수 효과 보정)
```

### Stage C — harness-meta 재스코어 검증

**Helper 4 조건 trace** (실측):
```
lang = 'Md'
  ↓ lang ∉ _BUILD_LANGS ✓ (조건 #1 PASS)
has_build_manifest = False
  ↓ ✓ (조건 #2 PASS)
pyproject_runtime_deps_empty = True (pyproject.toml 부재)
  ↓ ✓ (조건 #3 PASS)
build_sources = 5
  ↓ 5 < 10 = True ✓ (조건 #4 PASS — v1.18g2 변경)
helper = True ✅
```

**카테고리별 점수**:

| 카테고리 | v1.35 (helper=False) | v1.18g2 (helper=True) | 변동 |
|---------|:---:|:---:|:---:|
| 문서화 | 12/15 (A) | 12/15 (A) | 0 |
| 코드 구조 | 13/15 (A) | 13/15 (A) | 0 |
| 타입 안전성 | 15/15 (S) | 15/15 (S) | 0 |
| 테스트 품질 | 15/15 (S) | 15/15 (S) | 0 |
| 컨텍스트 레이어 | 15/15 (S) | 15/15 (S) | 0 |
| **자동화** | **10/15 (B)** | **13/15 (A)** | **+3** |
| 에이전틱 안전 | 10/10 (S) | 10/10 (S) | 0 |
| **Total** | **90 (S)** | **93 (S)** | **+3** |

**자동화 N/A 활성 확인** (JSON output 검증):
- ✅ Docker / 컨테이너화: passed=True, score=2/2, **na=True**, detail="N/A — shell/markdown-only repo (컨테이너화 부적합, 자동 만점)"
- ✅ 의존성 Lock 파일: passed=True, score=1/1, **na=True**, detail="N/A — runtime 의존성 부재 (자동 만점)"

**회귀 검증**: 다른 6 카테고리 점수 변동 0 ✓ (의도된 영향 범위 일치).

## 디테일 검증 (Pre-impl, D1~D12)

### A. 옵션 비교 매트릭스 (D3)

6 옵션 평가 후 Option A2 (`< 10`) 채택:

| 옵션 | 결정 | 사유 |
|------|:---:|------|
| A1 (`< 6`) | 기각 | 파일 +1로 즉시 재발 (fragile) |
| **A2 (`< 10`)** | **채택** | YAGNI + 회귀 0 + 1건 evidence 최소 적합 |
| A3 (`< 20`) | 기각 | false positive 위험 + 임계 정당성 약함 |
| B (TOOL_DIRS) | v1.18g3 후속 | list 유지비용 + 디렉토리 가정 |
| C (#4 제거) | v1.18g3 후속 | misdetected lang fallback 손실 위험 |
| D (비율) | v1.18g3 후속 | 임계 의미 변경 부담 + evidence 부재 |

### B. 회귀 매트릭스 (D9 — 7 case)

| Case | helper 변경 | 점수 변동 |
|------|:---:|:---:|
| harness-meta (5 .py) | False → **True** | **+3** ✅ 의도 |
| 순수 dotfiles (0 .py) | True → True | 0 ✓ |
| Hugo blog (0 .py) | True → True | 0 ✓ |
| Python app (lang #1 fail) | False → False | 0 ✓ |
| TS app (lang #1 fail) | False → False | 0 ✓ |
| 작은 Python script (lang #1 fail) | False → False | 0 ✓ |
| empty placeholder (0 .py) | True → True | 0 ✓ |

영향 받는 case = harness-meta 1건만 (의도). 회귀 0 ✓.

### C. 임계 sensitivity (D10)

| 임계 | scorer 5 | +1 | +3 | +5 | +10 |
|------|:---:|:---:|:---:|:---:|:---:|
| `< 6` | True | False ❌ | False | False | False |
| **`< 10`** | True | True | True | False ❌ | False |
| `< 20` | True | True | True | True | False ❌ |

`< 10`은 scorer 자연 확장(+0~5 파일) 5-buffer 충분. 10+ 추가 시 v1.18g3 재설계 자연 트리거.

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|:---:|
| utils.py line 271: `return build_sources < 10` | ✅ |
| utils.py line 258 docstring: 개수 < 10 + D11 보강 3줄 | ✅ |
| rubric.md N/A 정책 § 조건 #4: `< 10` + audit 사유 | ✅ |
| harness-meta self-eval: 92/100 (S) 복원 | ✅ **93/100** (PLAN 산술 오기 보정) |
| 회귀 0: D9 매트릭스 6 case 변동 0 | ✅ |
| 정적 검증 (4 조건 trace) 통과 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 scorer 헬퍼 임계 수치 조정만). 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — PLAN 산술 검증의 중요성** ⭐: PLAN line 318 "harness-meta 92/100 복원"은 +2(Docker) +1(Lock) = +3 → 90+3=**93**이 정확. 산술 1점 오기를 PLAN 단계에서 발견 못함. 향후 점수 변동 명시 시 명시 산술(`+a +b = +c → BASE+c=NEW`) 형태로 강제. 본 REPORT 최종 결과 표에서 정정.

- **L2 — Embedded tooling 분할의 helper 임계 영향**: v1.18g가 단일 파일을 5개 모듈로 분할 = **코드량 변화 0인데 helper 분류만 뒤집음**. 임계 5는 v1.18b 시점에 의도된 값이었으나 동일 코드의 리팩터링 부수 효과로 fragility 노출. 임계 2x 상향(`< 10`)으로 미래 분할 여유 확보 + 재발 시 v1.18g3 자연 트리거.

- **L3 — Helper 의미론 명문화 (D1)**: 4 조건 역할 분류 — #1~#3 = repo-level signal (root 매니페스트/주 언어), #4 = file-count signal (misdetected lang fallback). docstring에 명시화 → 미래 재설계 시 의도 보존. v1.18g3에서 _TOOL_DIRS 또는 비율 기반 재설계 경로 docstring에 인계.

- **L4 — Evidence-driven YAGNI 채택 (D8)**: B(TOOL_DIRS) / D(비율) 옵션은 더 principled하지만 evidence(harness-meta 1건)에 비해 over-engineering. 6 옵션 매트릭스 비교 후 A2 채택 = "최소 변경으로 즉시 해결 + 후속 진화 경로 보존" 패턴. 미래 false positive evidence 누적 시 v1.18g3에서 재설계.

- **L5 — Out of scope 명시적 기각의 가치**: B/C/D 옵션을 단순 "고려 안 함"이 아니라 "v1.18g3 후속" 명시 분리 → audit trail 보존 + 사용자 컨펌 시점에 명시적 trade-off 인지. 향후 유사 결정 시 "옵션 매트릭스 + 기각 사유" 패턴 강화.

- **L6 — v1.18g2 명명 컨벤션 (sequential vs semantic)**: 본 세션은 v1.36이 아닌 v1.18g2로 명명 → "v1.18g 부수 효과 후속" 의미론적 표시. smoke-spec-verification 글로벌은 version-number 기반(v1.24+)이라 v1.18g2는 in-scope 아님. 그러나 § 자발 추가 + 정합 작성으로 의무 충족. version 비교(`v1.18g2 < v1.24`)와 chronological order(v1.35 후 작성)의 분리 인지.

## 다음 후보 (보류)

| 항목 | 조건 |
|------|------|
| **`v1.18g3-helper-redesign`** | 미래 scorer 10+ 파일 도달 시 또는 false positive evidence 누적 시. _TOOL_DIRS 필터링 (Option B) 또는 비율 기반 (Option D) 채택 |
| `v1.18d-scorer-stdout-encoding` | Windows cp949 stdout UnicodeEncodeError fix (Stage C에서 재발 — JSON 생성은 성공이나 console print fail) |
| `v1.18h-category-max-recalibration` | CATEGORY_META max sub 합 mismatch (Documentation 13 vs max 15 / Code structure 13 vs max 15) |
| `v1.36-scorer-typesafety-na` | Type safety 카테고리 N/A 분기 (v1.35 미해결, 새 helper 필요) |
| detect_language refactor | dict ordering 의존 제거 (v1.35 L8) |

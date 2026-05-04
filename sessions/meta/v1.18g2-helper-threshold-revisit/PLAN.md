# meta v1.18g2-helper-threshold-revisit — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/PLAN.md) — D1 부수 발견 + Out of scope 표 명시 (`v1.18g2-helper-threshold-revisit`)
- [`sessions/meta/v1.18g-score-codebase-py-split/`](../v1.18g-score-codebase-py-split/) — score_codebase.py 1335줄 → 5 파일 분할 (본 세션의 root cause)
- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/) — `is_shell_markdown_only_repo` 헬퍼 + `build_sources < 5` 임계 최초 도입

목적: `is_shell_markdown_only_repo` 헬퍼의 조건 #4 임계(`build_sources < 5`)를 재조정. v1.18g 분할로 harness-meta Python 파일이 1개→5개가 되어 helper=True→False 전환 + Docker/Lock N/A 회귀 (92→90). 임계를 `< 10`으로 상향해 harness-meta를 shell/markdown-only repo로 올바르게 재분류.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/skills/ai-ready-scorer/scripts/utils.py` + S1c(1) `bootstrap/skills/ai-ready-scorer/references/rubric.md` = **2/2 meta**
- **T1 경로 다수결** — meta scope 2/2
- **T2 스펙 vs 값** — helper 4 조건 #4 임계 = 모든 scorer 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.35-scorer-other-na-categories/PLAN.md` Out of scope 표 (verbatim)**:

> | **helper 4 조건 #4 `build_sources < 5` 임계 재검토** | D1에서 v1.18g 분할 부수 효과 발견 — score_codebase.py 5 모듈 분할로 harness-meta build_sources 1→5 → helper=True→False 전환. v1.18b/c 자동화 N/A 회귀. 별 후속 `v1.18g2-helper-threshold-revisit` (또는 `v1.36c`) — 임계 6+ 조정 또는 helper 4 조건 재설계 |

**Source 2 — `sessions/meta/v1.35-scorer-other-na-categories/REPORT.md` "다음 후보" § (verbatim)**:

> | **`v1.18g2-helper-threshold-revisit`** | **D1 부수 발견** — v1.18g 분할이 helper 임계 5와 충돌하여 harness-meta가 helper=True→False 전환 + v1.18b 자동화 N/A 회귀 (92→90). 임계 6+ 조정 또는 helper 4 조건 재설계 |

**Parsed sub-items (1)**:

1. **helper 4 조건 #4 임계 재조정** — `build_sources < 5` → 상향 (임계 6+ 또는 재설계). harness-meta 재분류(helper=True) + Docker/Lock N/A 복원 (90→92)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| helper 조건 #1~#3 변경 (lang/manifest/pyproject 기준 재설계) | 별 후속 (evidence 없음 — 현 조건 3개 검증됨) |
| **Option B (`_TOOL_DIRS` 필터링) 채택** | `v1.18g3-helper-redesign` (미래 scorer 10+ 파일 도달 시 또는 false positive evidence 누적 시) |
| **Option D (비율 기반) 채택** | 동상 (v1.18g3 후속) |
| **Option C (#4 제거) 채택** | misdetected lang fallback 손실 위험 — evidence 누적 후 v1.18g3 검토 |
| 새 helper 함수 도입 (`is_small_python_script` 등) | v1.36+ Type safety N/A 세션 |
| Type safety / Test-pytest N/A 분기 | v1.36+ (본 세션 scope 외) |
| rubric.md N/A 정책 § 외 다른 § 갱신 | 별 후속 |
| detect_language refactor (dict ordering 의존) | v1.35 L8 별 후속 evidence-driven |
| CATEGORY_META max 재조정 | v1.18h 별 후속 |
| utils.py 모듈 헤더 history 주석 (D12b) | omit — git blame 충분 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 scorer 헬퍼 임계 수치 조정만) |
| **re-verify** | N/A |

## 1. 문제

### Root cause

v1.18g(`score_codebase.py` 1335줄 → 5 파일 분할)로 harness-meta git-tracked `.py` 파일이 1개→5개로 증가:

```
bootstrap/skills/ai-ready-scorer/scripts/
├── categories_ops.py      ← v1.18g 신규
├── categories_quality.py  ← v1.18g 신규
├── html_renderer.py       ← v1.18g 신규
├── score_codebase.py      ← 기존 (1135줄 → 분할 후 축소)
└── utils.py               ← v1.18g 신규
```

`is_shell_markdown_only_repo` 조건 #4:

```python
build_sources = sum(1 for f in tracked if f.suffix in _BUILD_SOURCE_EXTS and f.is_file())
return build_sources < 5   # harness-meta: 5 < 5 = False
```

- **v1.18g 이전**: build_sources=1 → 1 < 5 = True → helper=True → Docker/Lock N/A → 92점
- **v1.18g 이후**: build_sources=5 → 5 < 5 = False → helper=False → Docker/Lock 실점 → 90점

### 왜 helper=True가 올바른가

harness-meta는:

- lang="Md" (Shell/Markdown repo) ✓ 조건 #1 OK
- pyproject.toml 없음, 빌드 매니페스트 없음 ✓ 조건 #2/#3 OK
- 5 Python 파일 = **embedded tooling** (`bootstrap/skills/ai-ready-scorer/scripts/`) — 전체 342 tracked 파일 중 1.5%

Docker 컨테이너화와 Lock 파일은 harness-meta(Shell/Markdown docs tool)에 **본질적으로 부적합** → N/A가 올바른 판정.

### 임계 재설계 분석 (D1~D10)

#### D1 — Helper 의미론

`is_shell_markdown_only_repo`의 본질적 질문: "이 repo가 Docker + Lock이 의미 있는 '소프트웨어 제품 프로젝트'인가?"

4 조건 역할 분류:

- **#1~#3** = **repo-level signal** (root 매니페스트/주 언어) → "real programming project" 1차 검출
- **#4** = **file-count signal** → **misdetected lang fallback** (lang="Md" 오판정 + 실제로는 Python script collection인 edge case 차단)

#### D2 — `< 5` 임계의 historical context

| 시점 | harness-meta build_sources | helper 결과 |
|------|:---:|:---:|
| v1.18b 도입 시 | 1 (score_codebase.py만) | True (1<5) |
| v1.18g 분할 후 | 5 (5 모듈로 분산) | **False (5<5) 회귀** |
| v1.18g2 후 (`< 10`) | 5 | True (5<10) 복원 |
| 미래 scorer +5 파일 | 10 | False (10<10) — 재설계 트리거 |

**핵심**: v1.18g는 **단일 파일을 5개로 분할** = 코드 양 변화 0인데 helper 분류만 뒤집음 → 임계 fragility 증명.

#### D3 — 옵션 매트릭스 (6 후보)

| 옵션 | 변경 | 장점 | 단점 | 미래 내성 |
|------|------|------|------|:---:|
| **A1**: `< 5` → `< 6` | 1 line | 최소 변경 | 파일 +1로 즉시 재발 | ❌ |
| **A2**: `< 5` → `< 10` | 1 line + docstring | 단순, 2x 여유 | +5 파일 시 재발 | ⚠️ |
| **A3**: `< 5` → `< 20` | 1 line + docstring | 큰 여유 | false positive 위험 ↑ | ✅ |
| **B**: TOOL_DIRS 필터링 | ~10 line + docstring | 의미론적 정합 | 디렉토리 list 유지비용 | ✅ |
| **C**: #4 제거 (#1~#3만) | -2 line + docstring | 가장 단순 | misdetected lang false positive | 🟡 |
| **D**: 비율 기반 (`source/total < 10%`) | ~5 line | 스케일 무관 | 임계 의미 변경 (해석 부담) | ✅ |

#### D4 — Option B (TOOL_DIRS 필터링) 상세

**의미론**: "embedded tooling은 메인 프로젝트 코드가 아니다"

```python
_TOOL_DIRS = {"bootstrap", "scripts", "tools", "bin", "helpers", ".github"}

def _is_in_tool_dir(path: Path) -> bool:
    return any(p in _TOOL_DIRS for p in path.parts)

# 변경: tool 디렉토리 외부 소스만 카운트
main_sources = sum(
    1 for f in tracked
    if f.suffix in _BUILD_SOURCE_EXTS and f.is_file() and not _is_in_tool_dir(f)
)
return main_sources < 5
```

검증:

| Case | tool_dirs 외부 .py | 기대 helper | 결과 |
|------|:---:|:---:|:---:|
| harness-meta (5 .py in bootstrap/) | 0 | True | ✅ |
| Python app (src/main.py + 50 .py) | 50+ | False | ✅ (조건 #1도 fail) |
| Hugo blog + bootstrap/ Python helper | 0 | True | ✅ |

**위험**: 사용자가 메인 코드를 `tools/`나 `bootstrap/`에 두면 false positive. TOOL_DIRS list 유지비용 추가.

#### D5 — Option D (비율) 상세

```python
total_files = sum(1 for f in tracked if f.is_file())
build_sources = sum(...)
return total_files == 0 or (build_sources / total_files) < 0.10
```

| Case | source/total | 결과 |
|------|:---:|:---:|
| harness-meta | 5/342 = 1.5% | True ✅ |
| Python app | 50/100 = 50% | False ✅ |
| Hugo blog | 5/200 = 2.5% | True ✅ |
| 작은 Python script (lang misdetect) | 8/15 = 53% | False ✅ |

**장점**: 스케일 무관. **단점**: 임계 의미 변경 (절대 → 비율) — 해석 부담.

#### D6 — False positive 정량 분석

**시나리오 1**: 작은 Python 유틸리티 (7 .py, lang="Md" misdetect, no pyproject.toml):

| 옵션 | helper 결과 | 적절성 |
|------|:---:|:---:|
| A2 (`< 10`) | True (7<10) | ❌ Docker N/A 부정확 |
| B (TOOL_DIRS) | depends (.py 위치) | ⚠️ |
| C (제거) | True | ❌ |
| D (비율) | False (47%) | ✅ |

**시나리오 2**: 미래 scorer 10+ 파일 확장:

| 옵션 | helper 결과 | 적절성 |
|------|:---:|:---:|
| A2 | False ❌ 회귀 | 부적절 |
| B | True (모두 bootstrap/) | ✅ |
| D | True (10/350=2.9%) | ✅ |

**시나리오 3**: 사용자 코드를 `tools/`에 두는 Python project (lang="Md" misdetect):

| 옵션 | helper 결과 |
|------|:---:|
| A2 | depends on count |
| B | True ❌ (TOOL_DIRS 함정) |
| D | depends on ratio |

#### D7 — 권장 옵션 비교

| 기준 | 1순위 | 2순위 | 3순위 |
|------|:---:|:---:|:---:|
| 단순성 | **A2** | A1 | C |
| 의미론적 정합 | **B** | D | A2 |
| 미래 내성 | **D** | B | A3 |
| 회귀 위험 0 | **A2** | A1 | B |
| 코드 변경량 | **A1/A2/A3** | C | B |

#### D8 — 최종 권장: Option A2 (`< 10`) + 문서화

**채택 이유** (YAGNI + Single Responsibility):

1. **즉시 해결**: harness-meta 5 파일 즉시 복원 (90→92)
2. **변경 최소**: 1 line + docstring (verify 부담 0, 회귀 검증 단순)
3. **Evidence 부재**: harness-meta 외 임계 영향 받은 사례 0 → B/D over-engineering 회피
4. **재발 시 후속 진화 경로 보존**: 미래 scorer 10+ 파일 도달 시 `v1.18g3-helper-redesign`에서 B 또는 D로 재설계 (evidence 누적 후)
5. **시나리오 1 false positive**: lang misdetect + no pyproject.toml + 5~9 .py = 매우 드문 edge case → 무시 비용 < B/D 채택 비용

**기각 옵션 사유**:

- **A1 (`< 6`)**: 파일 +1로 재발 → 단기 처방
- **A3 (`< 20`)**: false positive 위험 ↑ + 임계 정당성 약함
- **B (TOOL_DIRS)**: TOOL_DIRS list 유지비용 + 사용자 디렉토리 컨벤션 가정 + harness-meta 특화 위험
- **C (제거)**: misdetected lang fallback 손실 → 안전장치 제거
- **D (비율)**: 임계 의미 변경 부담 + evidence 부재

#### D9 — 회귀 시나리오 (Option A2)

| Case | v1.18g2 전 helper | v1.18g2 후 helper | 점수 변동 |
|------|:---:|:---:|:---:|
| harness-meta (5 .py) | False | **True** | +2 (Docker N/A) +1 (Lock N/A) = **+3** |
| 순수 dotfiles (0 .py) | True | True | 0 |
| Hugo blog (0 .py) | True | True | 0 |
| Python app (lang #1 fail) | False | False | 0 |
| TS app (lang #1 fail) | False | False | 0 |
| 작은 Python script (lang #1 fail) | False | False | 0 |
| empty placeholder (0 .py) | True | True | 0 |

**영향 받는 case = harness-meta 1건만** (의도). 회귀 0 ✅.

#### D10 — 임계 sensitivity

미래 scorer 확장 시:

| 임계 | scorer 5 | +1 | +3 | +5 | +10 |
|------|:---:|:---:|:---:|:---:|:---:|
| `< 6` | True | **False ❌** | False | False | False |
| **`< 10`** | True | True | True | **False ❌** | False |
| `< 20` | True | True | True | True | **False ❌** |

**`< 10` rationale**: scorer 자연 확장(N/A 카테고리 추가 등) 시 +0~5 파일 예상. 5-buffer 충분. 10+ 추가는 재설계 신호 → 후속 세션 자연 트리거.

#### D11 — Docstring 보강

```python
"""4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 10

   임계 10은 v1.18g2에서 5→10 상향 (v1.18g score_codebase.py 분할 부수 효과 보정).
   조건 #1~#3가 실 프로젝트 차단의 주력이며 #4는 misdetected lang fallback.
   미래 scorer 10+ 파일 도달 시 v1.18g3에서 _TOOL_DIRS 필터링 또는 비율 기반 재설계.
"""
```

#### D12 — 추가 안전장치 (선택)

**D12a**: rubric.md N/A 정책 § 임계 변경 사유 1줄 (audit trail)
**D12b**: utils.py 모듈 헤더에 v1.18g2 history 주석 (선택, 본 세션에서는 omit — git blame 충분)

## 2. 결정 (Option A2 채택)

### R1 — utils.py 임계 변경

**line 271**:

```python
# 변경 전
    return build_sources < 5

# 변경 후
    return build_sources < 10
```

**line 258 docstring** (D11 보강):

```python
# 변경 전
    4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 5

# 변경 후
    4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 10
       임계 10은 v1.18g2에서 상향 (v1.18g score_codebase.py 분할 부수 효과 보정).
       조건 #1~#3가 실 프로젝트 차단 주력, #4는 misdetected lang fallback.
       미래 10+ 파일 도달 시 v1.18g3에서 _TOOL_DIRS 또는 비율 기반 재설계.
```

### R2 — rubric.md N/A 정책 § 갱신 (D12a)

```diff
- 4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 5
+ 4. 빌드 소스 파일(.py/.ts/.go 등) 개수 < 10  (v1.18g2: 5→10, 분할 보정)
```

### R3 — 회귀 검증

#### R3a — harness-meta self-eval

**기대**: 90/100 (S) → **92/100 (S)** (Docker 2점 + Lock 1점 N/A 복원).

#### R3b — Helper 결정 시뮬레이션 (코드 실행 없이 정적 검증)

`utils.py` 진입 후 4 조건 trace:

```
lang = 'Md'
  ↓ lang ∉ _BUILD_LANGS ✓ (조건 #1 PASS)
has_build_manifest = False (no package.json/Cargo.toml/go.mod/build.gradle*/pom.xml)
  ↓ ✓ (조건 #2 PASS)
pyproject_runtime_deps_empty = True (pyproject.toml 부재)
  ↓ ✓ (조건 #3 PASS)
build_sources = 5 (5 .py in bootstrap/skills/ai-ready-scorer/scripts/)
  ↓ 5 < 10 = True ✓ (조건 #4 PASS — v1.18g2 변경)
helper = True ✅
```

#### R3c — 기타 case 회귀 검증 (D9 매트릭스)

7 case 중 영향 받는 것은 harness-meta 1건만 (의도). 변경 전후 6 case 점수 변동 0.

## 3. 변경 대상

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/ai-ready-scorer/scripts/utils.py` | S1c | R1 — line 258(docstring) + line 271(return 조건) `< 5` → `< 10` |
| `bootstrap/skills/ai-ready-scorer/references/rubric.md` | S1c | R2 — N/A 정책 § 조건 #4 `< 5` → `< 10` |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.18g2-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.18g2-.../REPORT.md` | meta | Stage D 종료 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (D1~D12 분석 + R1~R3)
- [ ] **사용자 진입 확인** (Option A2 채택 + D8 기각 사유 컨펌)
- [ ] Stage A — utils.py: line 258 docstring + line 271 임계 `< 5` → `< 10`
- [ ] Stage B — rubric.md: N/A 정책 § 조건 #4 갱신
- [ ] Stage C — harness-meta 재스코어: 92/100 복원 검증
- [ ] Stage D — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `utils.py` line 271: `return build_sources < 10`
- [ ] `utils.py` line 258 docstring: `개수 < 10` + D11 보강 3줄 (분할 보정 사유 + 미래 재설계 경로)
- [ ] `rubric.md` N/A 정책 § 조건 #4: `< 10  (v1.18g2: 5→10, 분할 보정)`
- [ ] harness-meta self-eval: **92/100 (S)** 복원 (Docker + Lock N/A 재활성)
- [ ] 회귀 0: D9 매트릭스 6 case (harness-meta 외) 점수 변동 0
- [ ] 정적 검증 (R3b 4 조건 trace) 통과

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.18g2-helper-threshold-revisit — helper build_sources 임계 5→10 상향

- fix: bootstrap/skills/ai-ready-scorer/scripts/utils.py
  (is_shell_markdown_only_repo 조건 #4: build_sources < 5 → < 10
   docstring D11 보강 — 분할 보정 사유 + 미래 재설계 경로 명시)
- fix: bootstrap/skills/ai-ready-scorer/references/rubric.md
  (N/A 정책 § 조건 #4 표기 + audit 사유 1줄 추가)
- add: sessions/meta/v1.18g2-helper-threshold-revisit/{PLAN,REPORT}.md

Root cause: v1.18g score_codebase.py 분할(1→5 파일)로 harness-meta build_sources 1→5
→ helper=True→False 전환 → Docker/Lock N/A 회귀 (92→90).

Decision: Option A2 (`< 10`) 채택 (6 옵션 D3 매트릭스 비교).
- A1(`< 6`) 기각: +1 파일 재발 / A3(`< 20`) 기각: false positive 위험
- B(TOOL_DIRS) 기각: list 유지비용 + 사용자 디렉토리 가정
- C(제거) 기각: misdetected lang fallback 손실
- D(비율) 기각: 임계 의미 변경 부담 + evidence 부재
- A2 채택: YAGNI + 회귀 위험 0 + harness-meta 1건 evidence 최소 적합

Verification: helper=True 복원 (4 조건 trace) + 7 case 회귀 매트릭스 (영향 1건 의도).
References: v1.35 PLAN Out of scope 표 + REPORT 다음 후보 §.
```

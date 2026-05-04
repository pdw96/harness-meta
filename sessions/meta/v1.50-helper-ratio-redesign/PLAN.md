# meta v1.50-helper-ratio-redesign — PLAN

세션 시작: 2026-05-04
선행 세션: [`sessions/meta/v1.49-scorer-html-na-ui/`](../v1.49-scorer-html-na-ui/PLAN.md)

목적: `is_shell_markdown_only_repo` 조건 #4를 **count 기반 → ratio 기반**으로 재설계.
scorer 모듈이 10+ .py로 성장해도 harness-meta의 N/A 보호가 유지되도록 구조적 안정성 확보.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(2) `bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py` + `references/rubric.md`
- **T1 경로 다수결** — S1c(글로벌 user-skill) 2/2

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-B (verbatim)**:

> `v1.18g3-helper-redesign` (_TOOL_DIRS 또는 비율): scorer 10+ 파일 도달 또는 false positive evidence 누적

**Parsed sub-items (1)**:

1. **Helper 재설계 (ratio 기반)** — `is_shell_markdown_only_repo` 조건 #4를 count < 10에서 비율 < 0.10으로 교체. scorer 성장에 대한 구조적 안정성 확보.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `is_small_typed_lang_repo` 재설계 (Helper 2) | evidence-driven 후속 |
| `_TOOL_DIRS` 상수 신설 + 경로 기반 제외 | ratio 채택으로 불필요 결정 |
| 새 N/A 분기 추가 (다른 sub-check) | evidence-driven 별 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 무 (순수 내부 로직 변경) |
| **re-verify** | N/A |

## 1. 문제

### 현황

`is_shell_markdown_only_repo` 조건 #4 (v1.18g2 이후):

```python
build_sources = sum(
    1 for f in tracked
    if f.suffix in _BUILD_SOURCE_EXTS and f.is_file()
)
return build_sources < 10
```

| 항목 | 값 |
|------|---|
| harness-meta Python 파일 수 | **5** (모두 `bootstrap/skills/ai-ready-scorer/scripts/`) |
| 전체 tracked 파일 수 | **394** |
| 비율 | **1.3%** |
| 현재 임계 | 10 |
| 안전 여유 | 5 파일 (2x 성장까지만) |

### 위험

scorer 기능 확장 시 Python 모듈 추가 필연적. 10+ .py 도달 시:

- 조건 #4 실패 → `is_shell_markdown_only_repo` = False → `na_repo = False`
- 적용 25개 체크 전체에서 N/A 보호 소실
- harness-meta 점수: Docker/lock/패키지 매니페스트 등 체크 실패 → 93 → ~70점대 예상

### Root cause

count 기반 임계는 절대값이므로, "도구 스크립트만 포함한 대형 문서 repo" vs "소형 Python 프로젝트"를 구분하지 못함.

## 2. 결정: ratio 기반 재설계

### R1 — 조건 #4 교체 (OR 접근 — 회귀 0 보장)

count < 10 조건을 **보존**하고 ratio 조건을 OR로 추가. 기존 True 케이스는 항상 True 유지.

**Before**:

```python
build_sources = sum(
    1 for f in tracked
    if f.suffix in _BUILD_SOURCE_EXTS and f.is_file()
)
return build_sources < 10
```

**After**:

```python
if not tracked:
    return True
build_sources = sum(
    1 for f in tracked
    if f.suffix in _BUILD_SOURCE_EXTS and f.is_file()
)
return build_sources < 10 or build_sources / len(tracked) < _BUILD_SOURCE_RATIO_THRESHOLD
```

새 상수: `_BUILD_SOURCE_RATIO_THRESHOLD = 0.10`

OR 의미: 다음 중 하나라도 충족하면 na_repo=True (N/A)

- `count < 10` — 기존 동작 완전 보존 (회귀 0)
- `ratio < 10%` — 신규: 10+ 빌드 소스가 있어도 전체 파일의 10% 미만이면 도구 스크립트로 판단

### R2 — 임계 0.10 (10%) + OR 전략 검증

| 시나리오 | count | ratio | 기존 | 신규 (OR) |
|---------|------:|------:|:----:|:--------:|
| harness-meta 현재 (5/394) | 5 | 1.3% | True | True (5<10) ✓ |
| harness-meta +10py (15/404) | 15 | 3.7% | **False** | **True** (3.7%<10%) ✓ fixed |
| harness-meta +35py (40/429) | 40 | 9.3% | False | **True** (9.3%<10%) ✓ fixed |
| harness-meta +45py (50/444) | 50 | 11.3% | False | False ✓ (Python 프로젝트) |
| tiny Python (8/20) | 8 | 40% | True | True (8<10) ✓ 회귀 없음 |
| small Python (10/50) | 10 | 20% | False | False (20%>10%) ✓ |
| real Python (50/100) | 50 | 50% | False | False ✓ |
| empty repo (0/0) | — | guard | True | True ✓ |

safety margin: harness-meta 1.3% → 임계 10% = **8.7%p 여유**. 현재 5개 → ~76개 .py로 성장해야 임계 도달.

### R3 — `_TOOL_DIRS` 접근 기각

경로 기반 제외는 repo 구조에 종속(예: harness-meta의 `bootstrap/skills/` 경로를 하드코딩). ratio 기반이 구조 무관 + 일반화 가능. Out of scope로 분류.

### R4 — rubric.md 갱신

`## N/A 진입 조건 → Helper 1 조건 #4` 설명:

- Before: `개수 **< 10** (v1.18g2: 5→10 ...)`
- After: `**비율 < 10%** (v1.50: count→ratio 재설계; harness-meta 1.3% 기준 safety margin ~8x)`

## 3. 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/utils.py` | S1c | R1 — `_BUILD_SOURCE_RATIO_THRESHOLD` 상수 신설 + 조건 #4 교체 + docstring 갱신 |
| `bootstrap/skills/audit/ai-ready-scorer/references/rubric.md` | S1c | R4 — Helper 1 조건 #4 설명 갱신 + 세션 history |

## 4. 목표

- [x] 세션 디렉토리 + PLAN.md 작성
- [ ] Stage A — `utils.py` ratio 재설계 (R1)
- [ ] Stage B — `rubric.md` Helper 1 조건 #4 갱신 (R4)
- [ ] Stage C — 동적 시뮬레이션 4 case 검증
- [ ] Stage D — harness-meta 점수 회귀 없음 확인 (93/100)
- [ ] Stage E — REPORT.md + ROADMAP 갱신
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `_BUILD_SOURCE_RATIO_THRESHOLD = 0.10` 상수 존재
- [ ] 조건 #4가 `count < 10 or ratio < _BUILD_SOURCE_RATIO_THRESHOLD` 형식
- [ ] empty repo guard (`if not tracked: return True`) 존재
- [ ] rubric.md Helper 1 조건 #4: "비율 < 10% (v1.50)" 표기
- [ ] 동적 시뮬레이션 4/4 PASS
- [ ] harness-meta 93/100 변동 없음 (회귀 0)

## 6. 커밋 전략

```
feat(meta): v1.50-helper-ratio-redesign — is_shell_markdown_only_repo count→ratio 재설계
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.51-helper2-redesign` | `is_small_typed_lang_repo` false positive evidence 3+ 누적 시 |
| `v1.18g3+` (ROADMAP §3-B 항목 삭제 → archive) | 본 세션 완료로 trigger 해소 |

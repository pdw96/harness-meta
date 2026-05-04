# meta v1.50-helper-ratio-redesign — REPORT

세션 종료: 2026-05-04
선행 PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- 변경 파일: 2 (`utils.py` + `rubric.md`)
- 신규 상수: 1 (`_BUILD_SOURCE_RATIO_THRESHOLD = 0.10`)
- 동적 시뮬레이션: 6/6 PASS
- harness-meta 점수: 93/100 S (변동 0)

## 구현 요약

### Stage A — utils.py

1. `_BUILD_SOURCE_RATIO_THRESHOLD = 0.10` 상수 신설 (`_BUILD_SOURCE_EXTS` 직후)
2. `is_shell_markdown_only_repo` 조건 #4 교체:
   - Before: `return build_sources < 10`
   - After: `if not tracked: return True` guard 추가 + `return build_sources < 10 or build_sources / len(tracked) < _BUILD_SOURCE_RATIO_THRESHOLD`
3. docstring 갱신: "count < 10 OR 비율 < 10% (v1.50: OR 접근)"

### Stage B — rubric.md

Helper 1 조건 #4 설명:

- Before: `개수 **< 10** (v1.18g2: 5→10 ...)`
- After: `**count < 10 OR 비율 < 10%** (v1.50: OR 접근 — count<10 기존 보존 + ratio<10% 신규. harness-meta ~1.3% 기준 safety margin ~8x)`

### Stage C — 동적 시뮬레이션 6/6 PASS

| Case | 입력 | 결과 |
|------|------|------|
| harness-meta 현재 (5py/394) | ratio 1.3% | na=True ✓ |
| harness-meta +10py (15py/404) | ratio 3.7% | na=True ✓ (기존 False → 신규 True) |
| harness-meta +35py (40py/429) | ratio 9.3% | na=True ✓ (기존 False → 신규 True) |
| tiny Python (8py/20, 회귀 확인) | count 8 < 10 | na=True ✓ 회귀 없음 |
| real Python (50py/100) | ratio 50% | na=False ✓ |
| empty repo | guard | na=True ✓ |

### Stage D — 회귀 확인

harness-meta: **93/100 S** (변동 0)

## 판정

- [x] `_BUILD_SOURCE_RATIO_THRESHOLD = 0.10` 상수 존재
- [x] 조건 #4: `count < 10 or ratio < _BUILD_SOURCE_RATIO_THRESHOLD` 형식
- [x] empty repo guard 존재
- [x] rubric.md Helper 1 조건 #4: "비율 < 10% (v1.50)" 표기
- [x] 동적 시뮬레이션 6/6 PASS
- [x] harness-meta 93/100 변동 없음 (회귀 0)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 무 (순수 내부 로직 변경) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — OR 접근이 ratio 단독보다 안전**: count < 10 보존으로 기존 tiny-repo (8py/20) 케이스가 자연 보호됨. 순수 ratio 교체보다 OR이 회귀 0 보장 측면에서 우월.
- **L2 — 동적 시뮬레이션에 "회귀 확인" 케이스 필수**: Case 4(tiny Python 8py/20)가 없었다면 architecture review 지적 후 blind spot 남을 수 있었음.
- **L3 — 상수 주석에 OR 의미 명시**: `_BUILD_SOURCE_RATIO_THRESHOLD` 바로 위 주석 2줄로 "OR 접근 — 회귀 0 + scorer 성장 안정성" 의도를 코드에 내장.

## 다음 후보 (보류)

| 후속 세션 | 조건 |
|---------|------|
| `v1.51-helper2-redesign` | `is_small_typed_lang_repo` false positive evidence 3+ 누적 시 |

# meta v1.51-roi-action-bug-fix — REPORT

세션 종료: 2026-05-04
선행 세션: [`sessions/meta/v1.50-helper-ratio-redesign/`](../v1.50-helper-ratio-redesign/REPORT.md)

## 최종 결과

- 변경 파일: 3 (categories_ops.py / score_codebase.py / html_renderer.py)
- ROI 액션: 0건 → **1건** (harness-meta 기준)
- 총점: 93/100 S **변동 없음** (회귀 0)

## 구현 요약

### 근본 원인

전체 scorer 코드에서 `passed=False`로 설정하는 코드가 한 줄도 없음. 모든 체크가 `passed=True`이므로 `not ch["passed"]` 조건은 영구적으로 False → ROI 액션 항상 빈 리스트.

### 수정 (3 파일)

**`categories_ops.py` L323** — `compute_roi_actions`:

```python
# Before
if not ch["passed"] and ch.get("action"):
# After
if ch["score"] < ch["max_score"] and not ch.get("na", False) and ch.get("action"):
```

**`score_codebase.py` L90** — `top_actions` per category:

```python
# Before
for c in checks_raw if not c.passed and c.action
# After
for c in checks_raw if c.score < c.max_score and not c.na and c.action
```

**`html_renderer.py` L43-44** — 체크 아이콘 + 액션 표시:

```python
# Before
icon = "ℹ️" if is_na else ("✅" if ch["passed"] else "❌")
action_html = ... if not ch["passed"] and ch.get("action") else ""
# After
is_partial = not is_na and ch["score"] < ch["max_score"]
icon = "ℹ️" if is_na else ("⚠️" if is_partial else "✅")
action_html = ... if is_partial and ch.get("action") else ""
```

## 판정

- [x] `compute_roi_actions` 조건 수정 (1줄)
- [x] `top_actions` 조건 수정 (1줄)
- [x] `html_renderer` 아이콘 + action_html 조건 수정 (2줄)
- [x] 동적 검증: harness-meta ROI 액션 1건 (`코드 구조 / 파일 크기 적정 +1pt`)
- [x] 회귀 0: harness-meta 93/100 S 유지

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 버그 픽스, 외부 spec 의존 무 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — `passed=False` 데드 코드**: 설계 시 planned이었으나 실제 구현에서 부분 점수(2/3 등) 패턴으로 대체됨. 조건이 죽어있었는데 ROI 리스트가 비어있어도 별도 smoke가 없어 수개월간 미감지
- **L2 — HTML 렌더러 일관성**: `❌` 아이콘은 현재 렌더러에서 실제로 표시되지 않았음. `⚠️`(부분 점수)로 교체하여 아이콘 3종 (✅/⚠️/ℹ️) 체계가 실제 데이터와 정합

## 다음 후보 (보류)

| 후속 세션 | trigger 종류 | 조건 |
|---------|:---:|------|
| `v1.51b-roi-smoke` | B | ROI 액션 0건 회귀 감지 smoke 추가 (evidence-driven) |
| `v1.52-categories-quality-refactor` | E | `categories_quality.py` 500줄 초과 리팩토링 (사용자 요청 시) |

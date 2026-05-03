# meta v1.51-roi-action-bug-fix — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.50-helper-ratio-redesign/`](../v1.50-helper-ratio-redesign/PLAN.md)

목적: `compute_roi_actions`의 `not ch["passed"]` 조건이 실제로는 항상 False여서 ROI 액션이 영구적으로 빈 리스트로 반환되는 버그 수정. 조건을 `ch["score"] < ch["max_score"]` 기반으로 변경.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_ops.py`
- **T1 경로 다수결** — 글로벌 user-skill 변경 → meta scope

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-05-04)**:

> "AI-Ready Scorer ROI 액션 버그 픽스 — compute_roi_actions 조건을 'not passed' → 'score < max_score'로 변경"

**Parsed sub-items (1)**:

1. **ROI 액션 생성 조건 수정** — `not ch["passed"]` → `ch["score"] < ch["max_score"] and not ch.get("na", False)`

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| categories_quality.py 500줄 초과 리팩토링 | 별도 세션 (evidence-driven) |
| HTML 대시보드 ROI 섹션 시각화 개선 | evidence-driven 후속 |
| passed=False 기반 체크 도입 | 설계 방향 검토 필요 — 별 후속 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 버그 픽스만) |
| **re-verify** | N/A |

## 1. 문제

### 근본 원인

`categories_quality.py` + `categories_ops.py` 전체에서 `passed=False`로 설정하는 코드가 **한 줄도 없음**. 모든 체크가 `passed=True`로 생성되므로:

```python
# 현재 (버그)
if not ch["passed"] and ch.get("action"):   # → 항상 False
```

`harness-meta` 기준 실제 데이터:
- "파일 크기 적정 (≤500줄)": `score=2/3`, `passed=True`, `action="God file을 책임별 모듈로 분리"` → ROI 누락
- "Md 타입 시스템": `score=10/15`, `passed=True`, `action=None` → 액션 없으므로 무관

### 영향

모든 리포지토리에서 ROI 액션 리스트가 항상 빈 리스트 반환. 대시보드/텍스트 리포트의 "ROI 우선순위 액션" 섹션이 미출력.

## 2. 결정

### 수정 조건 (1줄 변경)

```python
# 수정 후
if ch["score"] < ch["max_score"] and not ch.get("na", False) and ch.get("action"):
```

**N/A 체크 제외 근거**: N/A 체크는 해당 리포지토리 특성상 적용 불가 → 개선 액션 불필요.

**`ch.get("action")` 유지**: action=None인 체크(예: "Md 타입 시스템")는 액션 없으므로 ROI 후보 아님.

### recoverable 계산

기존 `ch["max_score"] - ch["score"]` 그대로 유효. 부분 점수(score=2, max=3) → recoverable=1 정확.

## 3. 변경 대상 (3 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/categories_ops.py` | S1c | L323: `compute_roi_actions` 조건 수정 |
| `bootstrap/skills/audit/ai-ready-scorer/scripts/score_codebase.py` | S1c | L90: `top_actions` 생성 조건 수정 |
| `bootstrap/skills/audit/ai-ready-scorer/scripts/html_renderer.py` | S1c | L43-44: icon ⚠️ + action_html 조건 수정 |

## 4. 목표

- [ ] `compute_roi_actions` 조건 수정 (1줄)
- [ ] 동적 검증: harness-meta ROI 액션 ≥ 1건 확인
- [ ] 회귀 0: harness-meta 93/100 S 변동 없음
- [ ] REPORT.md 작성

## 5. 성공 기준

- [ ] harness-meta 재채점 시 `roi_actions` ≥ 1건 (현재 0건)
- [ ] "파일 크기 적정" 체크에 대한 ROI 액션 포함
- [ ] total_score 변동 없음 (93/100 S 유지)

## 6. 커밋 전략

```
fix(meta): v1.51-roi-action-bug-fix — ROI 액션 passed=True 항상 버그 수정
```

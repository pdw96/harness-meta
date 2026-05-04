# meta v1.52-roi-smoke-regression — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.51-roi-action-bug-fix/`](../v1.51-roi-action-bug-fix/PLAN.md)

목적: v1.51에서 `compute_roi_actions` ROI 액션 0건 버그를 수정했으나 회귀 감지 smoke가 없음. `tests/smoke-roi-regression.sh` 신설로 `score < max_score and not na` 조건 보호.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/` 관련 smoke + S3(1) `tests/smoke-roi-regression.sh` (신규) = **meta scope 2/2**
- **T1 경로 다수결** — S1c + S3 모두 meta. S4~S6 파일 0

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-B (verbatim)**:

> `v1.51b-roi-smoke` | ROI 액션 0건 회귀 감지 smoke 추가 — `ai-ready-report.json` roi_actions 길이 체크 | `v1.51 REPORT`

**Parsed sub-items (1)**:

1. **ROI 액션 0건 회귀 감지 smoke** — `compute_roi_actions`가 eligible check에 대해 비어있지 않은 결과를 반환하는지 정적 + 동적 검증

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| scorer 전체 통합 테스트 (실제 repo 전체 점수 검증) | 별 도메인 (시간 비용) |
| `top_actions` 회귀 (CategoryResult 내부 필드) | 정적 grep으로 충분 (§ 2.1 R2 포함) |
| pre-commit hook에 smoke 추가 | v1.39c (evidence-driven 후속) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 smoke 스크립트 신설만) |
| **re-verify** | N/A |

## 1. 문제

### 현재 상태

v1.51에서 `compute_roi_actions` + `top_actions` + `html_renderer` 3개소의 `not passed` 조건을 `score < max_score and not na`로 수정했다. 그러나 이 수정을 보호하는 smoke가 없어 미래 변경 시 조용히 회귀 가능.

### 회귀 시나리오

- `not passed` 조건으로 되돌아가면 → eligible check가 있어도 roi_actions = []
- `na` 조건 누락 → N/A 체크도 ROI 액션에 포함되어 오탐
- `action` 필드 누락 체크 → filter 로직 바뀌면 silent drop

### 본 세션 해결 범위

`tests/smoke-roi-regression.sh` 신설 — 정적 4 checks + 동적 2 checks = **6 checks total**.

## 2. 결정

### R1 — 정적 체크 (4건)

| # | 대상 파일 | 체크 내용 |
|:-:|---------|---------|
| S1 | `categories_ops.py` | `score < max_score and not ch.get("na", False)` 조건 존재 |
| S2 | `categories_ops.py` | `ch.get("action")` 필터 존재 |
| S3 | `score_codebase.py` | `top_actions`에서 `c.score < c.max_score and not c.na` 조건 존재 |
| S4 | `score_codebase.py` | `roi_actions=roi` 할당 존재 (report 객체에 포함) |

### R2 — 동적 체크 (2건)

**D1 — compute_roi_actions mock test**:

```bash
python3 -c "
import sys; sys.path.insert(0, 'bootstrap/skills/audit/ai-ready-scorer/scripts')
from categories_ops import compute_roi_actions
from utils import CategoryResult, Check
from dataclasses import asdict

# eligible: score < max_score and not na and has action
c1 = Check(name='test-check', passed=False, score=1.0, max_score=3.0,
           detail='partial', action='Fix this', roi_effort='단기', roi_impact=1.0, na=False)
# na=True → 제외
c2 = Check(name='na-check', passed=False, score=0.0, max_score=2.0,
           detail='na', action='Should be excluded', roi_effort='단기', roi_impact=1.0, na=True)
# score == max_score → 제외
c3 = Check(name='perfect', passed=True, score=2.0, max_score=2.0,
           detail='done', action='Already done', roi_effort='단기', roi_impact=1.0, na=False)

cat = CategoryResult(id='t', name_ko='테스트', score=3.0, max_score=7,
                     grade='B', color='orange',
                     checks=[asdict(c1), asdict(c2), asdict(c3)], top_actions=[])
result = compute_roi_actions([cat])
assert len(result) == 1, f'expected 1, got {len(result)}: {result}'
assert result[0]['check'] == 'test-check', f'unexpected check: {result[0]}'
print('ok')
"
```

→ exit 0이면 PASS (roi_actions 정확히 1건 — eligible c1만 포함).

**D2 — na=True 배제 검증**:

```bash
python3 -c "
import sys; sys.path.insert(0, 'bootstrap/skills/audit/ai-ready-scorer/scripts')
from categories_ops import compute_roi_actions
from utils import CategoryResult, Check
from dataclasses import asdict

# na=True만 있는 경우 → roi_actions == []
c_na = Check(name='na-only', passed=False, score=0.0, max_score=3.0,
             detail='na', action='excluded', roi_effort='단기', roi_impact=1.0, na=True)
cat = CategoryResult(id='t', name_ko='테스트', score=0.0, max_score=3,
                     grade='F', color='red',
                     checks=[asdict(c_na)], top_actions=[])
result = compute_roi_actions([cat])
assert result == [], f'expected [], got {result}'
print('ok')
"
```

→ exit 0이면 PASS (na=True만 있으면 ROI 액션 0건이 **올바른** 동작).

### R3 — Check + CategoryResult dataclass import 가정

`utils.py`에 `Check` + `CategoryResult` dataclass가 존재 (`Check.passed`, `Check.detail` 필수 필드 포함). `categories_ops.py`에 `compute_roi_actions` 함수 export. mock test는 이 두 파일에 의존.

## 3. 변경 대상

### 신규 (1)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-roi-regression.sh` | S3 | R1 정적 4 + R2 동적 2 = 6 checks |

### 세션 문서 (2)

| 경로 | 역할 |
|------|------|
| `sessions/meta/v1.52-roi-smoke-regression/PLAN.md` | 본 파일 |
| `sessions/meta/v1.52-roi-smoke-regression/REPORT.md` | 종료 시 작성 |

## 4. 목표

- [x] PLAN.md 작성
- [ ] **사용자 PLAN 확정**
- [ ] Stage A — `tests/smoke-roi-regression.sh` 신설 (정적 4 + 동적 2)
- [ ] Stage B — smoke 실행 검증 (6/6 PASS)
- [ ] Stage C — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `tests/smoke-roi-regression.sh` 존재 + executable
- [ ] 정적 체크 4/4 PASS (조건식 존재 grep)
- [ ] 동적 체크 2/2 PASS (mock compute_roi_actions 동작 검증)
- [ ] 기존 smoke 21+ 회귀 0

## 6. 커밋 전략

단일 커밋:

```
feat(meta): v1.52-roi-smoke-regression — ROI 액션 0건 회귀 감지 smoke 신설

- add: tests/smoke-roi-regression.sh (정적 4 + 동적 2 = 6/6 checks)
  - 정적: compute_roi_actions 조건식 존재 + top_actions 조건식 + roi 할당
  - 동적: mock eligible/na/perfect 3 check → roi_actions 1건 + na-only → 0건 검증
- session: sessions/meta/v1.52-roi-smoke-regression/PLAN.md + REPORT.md

ROADMAP §3-B v1.51b-roi-smoke trigger 이행.
```

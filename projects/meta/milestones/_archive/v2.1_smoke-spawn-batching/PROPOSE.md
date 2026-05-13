# PROPOSE — v2.1_smoke-spawn-batching

```json
{
  "next_candidates": [
    {
      "id": "v2.2_smoke-cp949-encoding-pattern",
      "title": "smoke 작성 표준에 Windows cp949 콘솔 인코딩 회피 패턴 강제",
      "trigger": "B_regression",
      "trigger_type": "lessons_learned#L1",
      "summary": "v2.1 phase-1 에서 Windows cp949 콘솔의 em dash (U+2014) UnicodeEncodeError 발견. smoke-python-entry-boilerplate § P2 v1.87 가 sys.stdout.reconfigure 패턴 표준화했으나 신규 smoke 작성 시 자동 적용되지 않음. tests/CLAUDE.md § '흔한 함정' 5건 외 6번째 항목 (cp949 콘솔 인코딩) 추가 + smoke 작성 5-step Step 3 (Generate) 의무 명시 + AST audit smoke (smoke-python-entry-boilerplate) 에 sys.stdout.reconfigure 검증 의무 추가."
    },
    {
      "id": "v2.2_historical-7stage-stage1-decision",
      "title": "historical 7-stage migrate milestone 의 Stage 1 (out_of_scope) 검증 누락 결정",
      "trigger": "D_design",
      "trigger_type": "lessons_learned#L6",
      "summary": "v2.0 hotfix 43472b7 가 detect_era 에 INTENT.md only 케이스 추가 (era='7-stage' 분류). 그러나 smoke-scope-contract Stage 1 코드는 era='7-stage' 시 fp=PLAN.md 만 체크 → historical 7-stage migrate (PLAN→INTENT) milestone 의 out_of_scope 검증은 SKIP 처리. 의도된 동작인지 hotfix 범위 밖이었는지 결정 의무. 옵션: (a) 그대로 보존 (Stage 2 만 검증, hotfix 범위 명시) / (b) Stage 1 도 INTENT.md fallback 활성화 / (c) era 분류를 더 세분화 (7-stage / 7-stage-historical)."
    },
    {
      "id": "v2.2_era-detect-shared-module",
      "title": "tests/_era_detect.py 분리 — 두 smoke 의 def detect_era drift 방지",
      "trigger": "D_design",
      "trigger_type": "lessons_learned#L4 + architecture A2",
      "summary": "v2.1 에서 spec-verification + scope-contract 두 smoke 모두 동일 def detect_era 본문 보유 (D5/R13). 본 milestone 동시 작성으로 drift 위험 mitigate 했으나, 향후 era 추가 시 양쪽 갱신 의무 = drift risk 잠재. tests/_era_detect.py 분리 + 두 smoke 공통 import. Python module import 비용은 spawn 1회 안에서만 발생 = 본 milestone spawn 단축 효과 보존. architecture A2 권고 직접 후속."
    },
    {
      "id": "v2.2_smoke-controlled-comparison-pattern",
      "title": "tests/CLAUDE.md § '회귀 검증 절차' 에 controlled 비교 패턴 (git show HEAD~N + diff CRLF 정규화) 추가",
      "trigger": "C_improvement",
      "trigger_type": "lessons_learned#L3",
      "summary": "v2.1 phase-2 검증 시 단순 baseline vs post 비교는 milestone 상태 변화로 PASS/SKIP 분포 차이. controlled 비교 (git show HEAD:smoke.sh > /tmp/old.sh + bash /tmp/old.sh + diff <(tr -d '\\r' < new) <(tr -d '\\r' < old)) 가 동치 검증 강력 도구. tests/CLAUDE.md § '회귀 검증 절차' 의 '기존 smoke 수정 시' 항목에 controlled 비교 패턴 명시."
    }
  ],
  "propose_summary": "본 milestone 에서 발견된 7 lessons (L1~L7) 중 4 건을 ROADMAP 등록 후보로 분리. 우선순위 순 — L1 (cp949 콘솔 인코딩, 즉시 회귀 방어) / L6 (historical 7-stage migrate 결정, 잠재적 잘못된 동작 명료화) / L4+A2 (era_detect 모듈 분리, drift 방지) / L3 (controlled 비교 패턴, 회귀 검증 도구). 나머지 3건 (L2 review_perspectives 필드 도입 / L5 Skeleton 매트릭스 'bash+python 혼재' 시나리오 / L7 ARCHITECTURE 9-stage 두 번째 실 적용 사례 cross-ref) 은 작거나 다른 milestone 에 자연 흡수 가능 — 본 propose 에서 등록 보류."
}
```

## 후속 narrative

### ROADMAP 등록 후보 4건

| 우선 | id | trigger | 요점 |
|:-:|---|---|---|
| 1 | v2.2_smoke-cp949-encoding-pattern | B_regression | 즉시 회귀 방어 — phase-1 에서 직접 발견한 함정 |
| 2 | v2.2_historical-7stage-stage1-decision | D_design | 잠재적 잘못된 동작 결정 — 옵션 3개 중 1 채택 |
| 3 | v2.2_era-detect-shared-module | D_design | 본 milestone 의 drift risk (R13) 의 후속 정전화 |
| 4 | v2.2_smoke-controlled-comparison-pattern | C_improvement | 검증 도구 표준화 |

### 등록 보류 3건 (lessons L2, L5, L7)

- **L2** (review_perspectives 필드 도입) — INTENT 템플릿 변경 영향 큼. 이미 별도 후속 candidate (scope contract review #1) 로 식별됨. ROADMAP 등록은 기존 `v2.1_pending-milestone-renumber-policy` 또는 신규 milestone 에 자연 흡수 검토.
- **L5** (Skeleton 매트릭스 'bash+python 혼재') — tests/CLAUDE.md 의 작은 추가. 다른 tests/ 변경 milestone 에 sweep 으로 자연 흡수 가능.
- **L7** (ARCHITECTURE 9-stage 두 번째 적용 사례 cross-ref) — `v2.1_pending-milestone-renumber-policy` 의 후속 사례 중 하나로 자연 흡수 가능.

### actual operation (ROADMAP 갱신 + push)

1. ROADMAP `milestones[]` 의 `v2.1_smoke-spawn-batching` `status: in_progress → completed` + summary 최종 갱신 (시간 단축 수치 포함)
2. 신규 4 candidates ROADMAP `milestones[]` 에 `status: pending` + `trigger` 필드로 등록
3. 사용자 확인 (`AskUserQuestion`) → push 결정

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- REPORT: [`REPORT.md`](REPORT.md)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)

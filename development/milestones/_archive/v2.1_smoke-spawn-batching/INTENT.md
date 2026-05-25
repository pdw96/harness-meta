# INTENT — v2.1_smoke-spawn-batching

```json
{
  "id": "v2.1_smoke-spawn-batching",
  "title": "smoke-spec-verification + smoke-scope-contract python3 spawn batching",
  "goal": "pre-commit 시 milestone N × stage M 마다 python3 프로세스를 새로 spawn 하는 비효율을 단일 spawn 일괄 검증으로 정정해 commit 시간을 1m33s → ~25s 로 단축한다.",
  "motivation": "사용자 발의 (2026-05-10) — commit 시 pre-commit hook 소요 시간이 너무 길어 개발 워크플로우 저해. 측정 결과 전체 1m33s 중 smoke-spec-verification 66s + smoke-scope-contract 12s = 78s (84%) 가 python3 spawn overhead. 17 milestones × 8 stage = ~150 회 × Windows MSYS2 spawn cost 0.376s ≈ 57s 가 단순히 인터프리터 시작 비용. 검증 로직 자체는 단순한 JSON parse + 필드 존재 확인이라 batching 으로 spawn 1회만 하면 동일 결과 얻을 수 있다. 5요소 매트릭스 'Verification' 행 정전 — 인프라 자동화 의존 최소화 정신과 부합 (실행 비용 최소화).",
  "success_criteria": [
    "smoke-spec-verification.sh 실행 시간 10s 이하 (현 66s, 85%+ 감소)",
    "smoke-scope-contract.sh 실행 시간 5s 이하 (현 12s, 58%+ 감소)",
    "전체 `pre-commit run --all-files` 시간 30s 이하 (현 1m33s, 67%+ 감소)",
    "검증 로직 동치 — 동일 milestone set 입력 시 PASS/FAIL/SKIP count 가 변경 전후 1:1 일치",
    "기존 pre-commit pipeline 회귀 0 — 다른 4 smoke (cross-ref/claude-md-drift/projects-scope-discipline/spec-verification) 영향 없음",
    "era 자동 식별 (D10 — 9-stage / 7-stage / 4-tier 분기) 동치 보존",
    "`--fix` mode 가 있는 smoke (현재 spec-verification/scope-contract 모두 ❌, 영향 없음) 와 정합 유지"
  ],
  "out_of_scope": [
    "smoke-cross-ref / smoke-claude-md-drift / smoke-projects-scope-discipline 의 변경 (이미 충분히 빠름, 각 1~3s)",
    "inactive 22 smoke 의 pre-commit 활성화 또는 시간 단축 (별도 milestone)",
    "shellcheck / markdownlint / 내장 pre-commit-hooks 의 시간 단축 (외부 의존, 별도 검토)",
    "Approach B (smoke 전체를 .sh → .py 로 재작성) — 변경 범위 과대",
    "Approach C (jq 사용으로 Python 제거) — 외부 의존 추가, OS 차이 risk",
    "smoke 검증 정책/책임 변경 (책임은 v1.1_smoke-precommit-rewrite 에서 정전)",
    "active smoke 갯수 변경 (5건 그대로 — 책임 정합성은 본 사전 RESEARCH 에서 확인)"
  ],
  "dependencies": {
    "predecessors": [
      "v1.1_smoke-precommit-rewrite (2026-05-08) — 현 5 active smoke 작성 / 검증 로직 정전 source",
      "v2.0_workflow-word-fidelity (2026-05-10) — smoke-spec-verification + smoke-scope-contract 에 era 자동 식별 (9-stage / 7-stage / 4-tier) 추가 — 본 milestone 은 동일 era 분기 보존 의무"
    ],
    "successors": []
  }
}
```

## 의도

사용자 발의: "commit test가 소요하는 시간이 너무 많은거 같은데, 정합성 검토해봐" (2026-05-10).

사전 RESEARCH (시간 측정 + 정합성 평가) 결과:

| smoke | 시간 | spawn | 정합성 |
|---|---:|---:|---|
| smoke-projects-scope-discipline | 0.9s | 0 | 책임/시간 정합 ✅ |
| **smoke-spec-verification** | **66.4s** | ~150 | 책임 정합 ✅ / 시간 비효율 ⚠️ |
| smoke-scope-contract | 12.4s | ~34 | 책임 정합 ✅ / 시간 비효율 ⚠️ |
| smoke-cross-ref | 0.9s | 0 | 책임/시간 정합 ✅ |
| smoke-claude-md-drift | 2.4s | ~3 | 책임/시간 정합 ✅ |
| **전체 pre-commit** | **1m33s** | | smoke 78s + 외부 hook ~15s |

5 active smoke 의 책임은 모두 정합 (중복 0, 누락 0). 문제는 spec-verification + scope-contract 의 **구현 패턴** — `check_*` 함수가 매 호출마다 python3 새로 spawn (heredoc 내장). 단일 python3 호출로 batching 하면 spawn cost 가 N배에서 1배로 감소.

본 milestone 은 검증 로직 / 책임 / 출력 contract 는 변경하지 않고, 오직 spawn 횟수 단축에만 집중.

## 검증 가능한 게이트

`success_criteria` 의 7건 모두 자동 측정 가능:

- 시간 3건: `time bash tests/<smoke>.sh` 측정 → 임계 비교
- 동치 1건: 변경 전 PASS/FAIL/SKIP count 캡처 → 변경 후 비교
- 회귀 1건: 다른 4 smoke + pre-commit run --all-files
- era 분기 1건: 9-stage / 7-stage / 4-tier 각 1+ milestone 에서 분기 동치 검증
- `--fix` 정합 1건: 현재 두 smoke 모두 `--fix` 부재 → 변경 후도 부재 유지 (또는 후속 별도 milestone)

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 5요소 매트릭스 'Verification' 행
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
- 선행 milestone: [`../v1.1_smoke-precommit-rewrite/REPORT.md`](../v1.1_smoke-precommit-rewrite/REPORT.md), [`../v2.0_workflow-word-fidelity/REPORT.md`](../v2.0_workflow-word-fidelity/REPORT.md)

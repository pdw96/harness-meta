# PROPOSE — v3.7 smoke-posttooluse-9stage-tests

```json
{
  "version": "v3.7",
  "next_candidates": [
    {
      "id": "v3.8_inactive-smoke-cd-path-fix",
      "title": "inactive smoke 22건 cd 경로 버그 일괄 수정 (../..) — v3.7 L1 후속",
      "trigger_type": "C_improvement",
      "trigger": "v3.7 L1 발견: _inactive/ 이동 후 cd '$(dirname $0)/..' 가 tests/ 를 가리켜 Stage 1 static check FAIL. 나머지 21건 inactive smoke 도 동일 문제 잠재. 수동 실행 시 모두 FAIL. evidence-base 충족 — v3.7 에서 직접 확인."
    }
  ],
  "propose_summary": "v3.7 주 목표 (Tests T/U/V) 완료. L1 (cd 경로 버그) 은 이번 smoke 만 수정했으나 나머지 21건 inactive smoke 도 동일 문제 잠재 → v3.8 후속 candidate 등재. v3.6 § 6.2 workflow self-improvement 동결 정합 — v3.8 는 narrative 강화 아닌 실 버그 fix."
}
```

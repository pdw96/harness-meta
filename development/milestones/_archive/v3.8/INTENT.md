# INTENT — v3.8 inactive-smoke-cd-path-fix

```json
{
  "id": "v3.8",
  "title": "inactive smoke 21건 cd 경로 버그 일괄 수정 (../.. 경로)",
  "goal": "tests/_inactive/ 로 이동된 smoke 스크립트 중 `cd \"$(dirname \"$0\")/..\"` 패턴이 tests/ 를 가리키는 경로 버그를 `../..` 로 일괄 수정하여, inactive smoke 수동 실행 시 Stage 1 static check FAIL 을 제거한다.",
  "motivation": "v3.7 milestone (030e68e) 에서 smoke-posttooluse-hook.sh 1건의 cd 버그를 수정하며 나머지 21건에도 동일 문제가 잠재함을 L1 로 기록. inactive smoke 는 CI 에서 제외되어 자동 검출이 없으므로, 수동 실행 시 경로 오류로 즉시 FAIL — 디버깅 비용 발생. 일괄 수정으로 inactive smoke 의 수동 실행 신뢰성 보장.",
  "success_criteria": [
    "tests/_inactive/ 내 모든 `$(dirname \"$0\")/..` 패턴이 `$(dirname \"$0\")/../..` 로 수정됨",
    "수정 대상 8개 파일 각각 bash -n (syntax check) PASS",
    "active smoke (pre-commit 14 hook) 회귀 0건 — pre-commit full PASS",
    "smoke-open-stage-discipline.sh PASS (milestones.md 존재 검증)",
    "inactive smoke 수동 실행 시 cd 경로 오류로 인한 FAIL 제거 (smoke-detect-language.sh + smoke-roi-regression.sh 대표 검증)"
  ],
  "out_of_scope": [
    "HARNESS_META_ROOT $HOME fallback 패턴 수정 (dirname 버그와 별개 — _inactive/ 이동과 무관)",
    "inactive smoke 의 실제 기능 로직 수정 (경로 수정만)",
    "inactive smoke 를 다시 active 로 전환",
    "CI 워크플로우 변경"
  ],
  "dependencies": {
    "predecessor": "v3.7 smoke-posttooluse-9stage-tests (completed, L1 발의)",
    "successor": null
  }
}
```

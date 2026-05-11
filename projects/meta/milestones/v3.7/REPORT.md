# REPORT — v3.7 smoke-posttooluse-9stage-tests

```json
{
  "version": "v3.7",
  "summary": "v2.0_workflow-word-fidelity 에서 post-report-write.sh 에 INTENT/APPROVE/PROPOSE 9-stage 분기가 추가됐으나, tests/_inactive/smoke-posttooluse-hook.sh 의 동적 검증은 PLAN.md/REPORT.md/execute/phase-N.md 패턴만 커버하고 있었다. v3.7 은 Tests T/U/V 3건을 추가해 이 coverage gap 을 보완했다. 겸: _inactive/ 이동 시 cd 경로 버그 (tests/ → tests/_inactive/ 후 ../..) 수정. 1 phase 1 commit (030e68e), pre-commit 14 hook PASS, 회귀 0.",
  "delta": {
    "files_changed": 2,
    "files_added": 7,
    "files_deleted": 0,
    "modules_affected": ["tests/_inactive", "tests (CLAUDE.md)", "projects/meta/milestones/v3.7", "projects/meta/ROADMAP.md"]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "_inactive/ 이동 smoke 의 cd 경로 버그 — v3.6 git mv 시 모든 smoke 의 cd '$(dirname $0)/..' 가 tests/ 를 가리키게 됨. inactive smoke 를 수동 실행하려면 ../.. 가 필요. 다른 inactive smoke 22건도 동일 문제 잠재.",
      "impact": "smoke 수정 시 cd 경로 같이 수정 필수"
    },
    {
      "id": "L2",
      "lesson": "INTENT.md 분기 grep 패턴 — 'RESEARCH' 단독은 OTHER branch(RESEARCH.md 파일 감지) 에도 등장 가능. '다음: RESEARCH' 로 좁혀야 false positive 제거. spec-drift 관점 검토가 이를 사전 포착.",
      "impact": "hook MSG 변경 시 test assertion 도 동시 갱신 필요"
    }
  ]
}
```

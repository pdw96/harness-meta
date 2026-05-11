# REPORT — v3.3 ci-inactive-smoke-cleanup

```json
{
  "id": "v3.3",
  "summary": "GitHub Actions CI를 green으로 복구했다. 원인은 .github/workflows/ci.yml이 tests/smoke-*.sh 28건을 glob으로 전부 실행하면서 bootstrap/templates, sessions/, install-verify 인프라 부재로 inactive smoke 16건이 v3.0 push 시점부터 누적 fail한 것이었다. v1.4_infra-minimization(2026-05-10) 결정과 일관되게 fix 복원 없이 CI 정책 변경으로 해결했다. .github/workflows/ci.yml 1파일 수정 — ACTIVE_SMOKES 배열 6건 명시 + inactive skip 근거 주석 + 동기화 가이드 주석. inactive smoke 22건은 historical 보존, 삭제 없음.",
  "delta": {
    "files_changed": 1,
    "files_added": 7,
    "files_deleted": 0,
    "commits": ["14b36ff"],
    "modules_affected": [".github/workflows", "projects/meta/milestones/v3.3"]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "Stage A OPEN에서 ROADMAP status를 in_progress로 전환하면 smoke-bundle-trigger가 milestones_path + 실 파일 존재를 즉시 요구한다.",
      "implication": "v3.3 OPEN 중 bundle-trigger 신규 fail 발생 → milestones.md 스켈레톤 즉시 생성 + ROADMAP milestones_path 추가로 해소. ROADMAP OPEN 절차에 '동시에 milestones.md 스켈레톤 생성' 단계 명시 필요."
    },
    {
      "id": "L2",
      "lesson": "CI glob 정책 변경은 passing inactive smoke(6건)도 CI 제외한다. 의도적이나 문서화 필요.",
      "implication": "ACTIVE_SMOKES 배열 주석에 이미 반영. 향후 inactive → active 전환 시 배열 추가 필요."
    }
  ]
}
```

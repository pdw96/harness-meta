# REPORT — v1.2_post-report-write-message-rewrite

```json
{
  "id": "v1.2_post-report-write-message-rewrite",
  "summary": "post-report-write.sh의 additionalContext 메시지에서 deprecated SKILL 참조(harness-roadmap-update / harness-plan-verify)를 제거하고 7-stage 흐름 안내로 교체했다. PLAN.md 감지 시 'RESEARCH.md 작성으로 진행하세요 (/harness-meta)', REPORT type 감지 시 '7-stage 다음 단계로 진행하세요 (/harness-meta)' 메시지로 변경. smoke 6건(A/F/H/K/P/R) 키워드도 동시 갱신. 2 phase, 2 commit, smoke 22/22, pre-commit full-pass, 회귀 0.",
  "delta": {
    "files_changed": 2,
    "files_added": 5,
    "files_deleted": 0,
    "modules_affected": ["claude/hooks", "tests"]
  },
  "lessons_learned": [
    "메시지 교체처럼 단순해 보이는 변경도 smoke 키워드 6건이 연쇄적으로 영향받는다 — phase-1/2 분리가 smoke 실패를 명확히 격리해줬다.",
    "architecture agent가 한국어 UTF-8 + JSON printf 조합에서 이스케이프 문제 없음을 사전 확인해 실행 중 예상치 못한 오류를 막았다."
  ],
  "next_candidates": []
}
```

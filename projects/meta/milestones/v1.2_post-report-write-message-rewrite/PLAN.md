# PLAN — v1.2_post-report-write-message-rewrite

```json
{
  "id": "v1.2_post-report-write-message-rewrite",
  "title": "post-report-write.sh additionalContext 메시지 재작성 (7-stage 안내)",
  "goal": "post-report-write.sh의 additionalContext 메시지에서 deprecated SKILL 참조(harness-roadmap-update / harness-plan-verify)를 제거하고, 7-stage 흐름 기반의 다음 단계 안내 메시지로 교체한다.",
  "motivation": "v1.60 경로 패턴 갱신 후 hook은 올바른 경로를 감지하지만 메시지는 여전히 존재하지 않는 SKILL(/harness-roadmap-update, /harness-plan-verify)을 참조하고 있어 사용자에게 오해를 줄 수 있다.",
  "success_criteria": [
    "additionalContext 메시지에 'harness-roadmap-update' 문자열 미포함",
    "additionalContext 메시지에 'harness-plan-verify' 문자열 미포함",
    "PLAN.md 감지 시 '7-stage 다음 단계' 또는 'RESEARCH' 키워드를 포함한 안내 출력",
    "REPORT type 산출물 감지 시 '7-stage' 또는 '/harness-meta' 키워드를 포함한 안내 출력",
    "smoke-posttooluse-hook.sh 22 tests 모두 갱신 후 pass",
    "pre-commit hook full-pass (회귀 0)"
  ],
  "out_of_scope": [
    "FILE_BASENAME별 세분화 라우팅 (RESEARCH→DESIGN, DESIGN→EXECUTE 등 단계별 개별 메시지)",
    "python3 파싱 로직 변경",
    "sections 추출 로직 변경",
    "경로 패턴 변경 (v1.60에서 완료)"
  ],
  "dependencies": {
    "predecessors": ["v1.1_post-report-write-hook-update"],
    "successors": []
  }
}
```

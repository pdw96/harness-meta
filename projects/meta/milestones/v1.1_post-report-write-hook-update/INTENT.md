# PLAN — v1.1_post-report-write-hook-update

```json
{
  "id": "v1.1_post-report-write-hook-update",
  "title": "claude/hooks/post-report-write.sh 패턴 갱신",
  "goal": "post-report-write.sh의 경로 매처를 구 sessions/ 기반에서 신규 7-stage projects/meta/milestones/ 기반으로 교체한다. 갱신 후 REPORT 작성 시 additionalContext 안내가 정상 출력되어야 한다.",
  "motivation": "v1.0_workflow-redesign에서 7-stage 흐름이 도입됐으나 hook 매처는 구 sessions/ 패턴을 그대로 유지 중. 현재 milestone 산출물(PLAN/RESEARCH/DESIGN/VERIFY/REPORT/execute/phase-{n}.md) 작성 시 hook이 silent NOOP — 안내 메시지가 전혀 출력되지 않는다.",
  "success_criteria": [
    "post-report-write.sh가 projects/meta/milestones/v{X.Y}_{slug}/REPORT.md 경로를 감지하여 additionalContext 출력",
    "post-report-write.sh가 projects/meta/milestones/v{X.Y}_{slug}/INTENT.md 경로를 감지하여 additionalContext 출력",
    "post-report-write.sh가 projects/meta/milestones/v{X.Y}_{slug}/execute/phase-{n}.md 경로를 감지하여 additionalContext 출력",
    "sessions/ 경로는 더 이상 매치하지 않음 (구 패턴 제거)",
    "smoke-posttooluse-hook.sh 또는 inline 검증으로 신규 패턴 통과 확인",
    "pre-commit hook full-pass (회귀 0)"
  ],
  "out_of_scope": [
    "hook 메시지 내용 개선 (additionalContext 문구 재작성은 별도 milestone)",
    "harness-roadmap-update / harness-plan-verify SKILL 자체 변경",
    "NotebookEdit 경로 지원 확장",
    "projects/upbit/ 경로 지원 (upbit는 별도 프로젝트 repo에 산출물)",
    "python3 파싱 로직 변경"
  ],
  "dependencies": {
    "predecessors": ["v1.1_smoke-precommit-rewrite"],
    "successors": []
  }
}
```

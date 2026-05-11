# INTENT — v3.12 deprecated-skill-narrative-cleanup

```json
{
  "id": "v3.12",
  "title": "bootstrap/skills/audit/harness-{plan-verify,roadmap-update}/SKILL.md sessions/ 거명 일괄 정리",
  "goal": "harness-plan-verify/SKILL.md 와 harness-roadmap-update/SKILL.md 두 파일 안에 잔존하는 deprecated sessions/meta/* / sessions/<project>/* 경로 거명을 현행 경로 또는 DEPRECATED 문맥에 맞는 표현으로 일괄 정리한다.",
  "motivation": "v3.11 VERIFY drift 검증 시 발견. v1.0_workflow-redesign(2026-05-08) 이후 sessions/ 디렉토리가 제거됐음에도 SKILL.md 본문 narrative 가 미갱신 상태로 잔존 — 신규 기여자 또는 Claude Code 가 SKILL.md 를 읽을 때 존재하지 않는 경로를 정규 경로로 오인할 위험.",
  "success_criteria": [
    "harness-plan-verify/SKILL.md 의 sessions/ 거명 라인 (L4/L5/L27/L28/L165/L166 기준) 이 현행 milestones/ 경로 또는 적절한 대체 표현으로 교체 또는 제거됨",
    "harness-roadmap-update/SKILL.md 의 sessions/ 거명 라인 (L4/L22/L24 기준) 이 현행 표현 또는 DEPRECATED 문맥 정합으로 갱신됨",
    "smoke 14 hook 모두 PASS, 회귀 0",
    "두 파일에서 sessions/ 문자열 grep 결과 0건 (historical 보존 의도 라인 제외)"
  ],
  "out_of_scope": [
    "harness-plan-verify SKILL 의 기능 로직 변경 (Step 1~3 흐름 자체는 현행 유지)",
    "harness-roadmap-update SKILL 의 재설계 또는 DEPRECATED 상태 변경 (historical 보존 정책 유지)",
    "다른 SKILL.md 또는 문서의 sessions/ 거명 탐색 및 정리 (본 milestone 범위 외)"
  ],
  "dependencies": {
    "predecessors": ["v3.11_legacy-narrative-cleanup (완료)"],
    "successors": []
  }
}
```

# PLAN — v1.1_agents-md-cleanup

```json
{
  "id": "v1.1_agents-md-cleanup",
  "title": "AGENTS.md legacy 참조 정리 (README.md cleanup 후속)",
  "goal": "AGENTS.md에 잔존하는 구 milestone 상태·workflow 설명 오류를 제거하고 현재 7-stage 상태를 정확히 반영한다.",
  "motivation": "v1.1_readme-cleanup 이후 README.md는 갱신됐지만 AGENTS.md(타 AI 도구 + 오픈소스 방문자용 영문 요약)는 동기화가 누락됨. 잘못된 milestone 상태('v1.1_meta-as-project in progress')와 기타 stale 내용이 외부 방문자에게 혼란을 줄 수 있다.",
  "success_criteria": [
    "AGENTS.md Status 섹션이 완료된 milestone(v1.0, v1.1_meta-as-project, v1.1_readme-cleanup)을 completed로 표기",
    "AGENTS.md에 구 10-stage·Bootstrap mode·구 slash command 참조가 없음",
    "pre-commit full-pass (markdownlint + shellcheck)",
    "AGENTS.md 내용이 README.md·CLAUDE.md 현재 상태와 정합"
  ],
  "out_of_scope": [
    "AGENTS.md 전체 재작성 또는 새 섹션 추가",
    "README.md·CLAUDE.md 추가 변경",
    "다른 docs/ 파일 정리"
  ],
  "dependencies": {
    "predecessor": "v1.1_readme-cleanup (completed)",
    "successor": "v1.1_smoke-precommit-rewrite (pending)"
  }
}
```

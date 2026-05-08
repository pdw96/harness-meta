# PLAN — v1.1_readme-cleanup

```json
{
  "id": "v1.1_readme-cleanup",
  "title": "README.md legacy 참조 정리",
  "goal": "README.md 내 구 워크플로우(10-stage, /harness-plan·design·run·ship, sessions/, Bootstrap mode, DECISIONS/INTERVIEW/STACK) 참조를 현 7-stage 워크플로우 및 디렉토리 구조에 맞게 정정하고 stale 섹션을 제거한다.",
  "motivation": "v1.0_workflow-redesign과 v1.1_meta-as-project에서 CLAUDE.md·ARCHITECTURE.md·ROADMAP.md는 갱신됐으나 README.md의 다수 섹션이 갱신되지 않아 외부 방문자와 신규 세션에 혼동을 유발하는 잘못된 정보가 잔존한다.",
  "success_criteria": [
    "README.md 내 '10-stage workflow' 표현이 사라지고 현 7-stage workflow로 교체된다",
    "Bootstrap mode 안내 문단이 제거 또는 현 신규 프로젝트 도입 절차로 교체된다",
    "구 slash command 표(/harness-plan·design·run·ship)가 제거 또는 /harness-meta 단일 명령으로 교체된다",
    "sessions/ 경로 참조가 projects/meta/milestones/ 또는 현 milestone 경로로 교체된다",
    "DECISIONS/INTERVIEW/STACK 5-doc 표기가 README.md에 잔존하지 않는다",
    "pre-commit run으로 markdownlint + scope-discipline smoke가 통과한다",
    "README.md가 현재 설치·사용 흐름을 독자 혼동 없이 기술한다"
  ],
  "out_of_scope": [
    "AGENTS.md 갱신 (별도 milestone 후보)",
    "CLAUDE.md / ARCHITECTURE.md / ROADMAP.md 변경",
    "bootstrap/ 스크립트·템플릿 코드 변경",
    "기능 추가 — 문서 정확성 회복만"
  ],
  "dependencies": {
    "predecessors": ["v1.1_meta-as-project (completed)", "v1.0_workflow-redesign (completed)"],
    "successors": []
  }
}
```

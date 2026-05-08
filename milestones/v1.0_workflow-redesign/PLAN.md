# PLAN — v1.0_workflow-redesign

```json
{
  "id": "v1.0_workflow-redesign",
  "title": "7-stage workflow redesign — single-responsibility pipeline",
  "goal": "기존 4-tier sessions/milestones 구조를 새 7-stage JSON-schema 기반 흐름으로 완전 교체. 버전 v1.0부터 리셋.",
  "motivation": "사용자 설계 의도 — 단일 책임 단계 분리(PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT) + 자동화 파이프라인 친화적 JSON 구조 + 컨텍스트 효율을 위한 ROADMAP 간소화",
  "success_criteria": [
    "root ROADMAP.md 새 JSON schema (id/title/status/summary/trigger 5필드) 정합",
    "claude/commands/harness-meta.md 7-stage 흐름 반영",
    "sessions/ 디렉토리 전체 git rm",
    "projects/upbit/ 에 ARCHITECTURE.md + ROADMAP.md(JSON) 만 존재",
    "milestones/v1.85_project-workflow-extension/ (untracked) 삭제됨",
    "bootstrap/skills/ 유지됨 (글로벌 user skills 보존)",
    "bootstrap/{docs,skeletons,templates}/ 삭제됨",
    ".pre-commit-config.yaml 의 sessions/-의존 hook 4종 disable",
    "install.ps1 의 bootstrap/templates/_base + install-project-claude 참조 제거",
    "verify.ps1 + verify.sh 의 sessions/ 검증 stage 제거",
    "module CLAUDE.md cross-ref 정리 (claude/, bootstrap/skills/)",
    "VERIFY.md + REPORT.md 작성 완료"
  ],
  "out_of_scope": [
    "tests/ smoke 스크립트 내용 (sessions/ 의존 smoke는 disable만, 갱신은 후속 milestone)",
    "tests/CLAUDE.md 갱신 (smoke 갱신과 동반)",
    "claude/hooks/post-report-write.sh 패턴 갱신 (sessions/.*/REPORT 패턴 — 동일 후속)",
    "claude/agents/, claude/output-styles/ (변경 없음)",
    "install-skills.{ps1,sh}, sync-agents.{ps1,sh}, verify-lib.{ps1,sh} (변경 없음)",
    "milestones/v1.84~v1.88/ 구 포맷 마이그레이션 (역사 기록 유지)",
    "자동화 파이프라인 구현 (스키마만 정의)",
    "upbit repo 측 cross-ref 정리 (별도 후속)"
  ],
  "dependencies": {
    "preceding": null,
    "following": [
      "smoke + .pre-commit + tests/CLAUDE.md 갱신 milestone (회귀 evidence 시)",
      "claude/hooks/post-report-write.sh 패턴 갱신 milestone (동일)",
      "upbit repo cross-ref 정리 (upbit 측 milestone)"
    ]
  }
}
```

# RESEARCH — v1.1_agents-md-cleanup

```json
{
  "external": [
    {
      "source": "AGENTS.md 전체 스캔",
      "topic": "legacy 참조 실재 여부",
      "findings": "구 10-stage·Bootstrap mode·구 slash command(/harness-plan 등)·sessions/ 경로 참조는 없음. 단 하나: line 84 Status 섹션에 'v1.1_meta-as-project in progress' 표기가 잔존 — 실제론 2026-05-08 completed.",
      "drift": "minor — Status 1줄만 stale"
    },
    {
      "source": "projects/meta/ROADMAP.md",
      "topic": "현재 milestone 상태 ground-truth",
      "findings": "v1.0_workflow-redesign(completed), v1.1_meta-as-project(completed), v1.1_readme-cleanup(completed), v1.1_agents-md-cleanup(in_progress), 나머지 3건 pending",
      "drift": null
    }
  ],
  "codebase": {
    "affected_files": ["AGENTS.md"],
    "untouched_files": ["README.md", "CLAUDE.md", "docs/", "claude/", "tests/"],
    "current_state": "AGENTS.md line 84 Status 섹션: v1.1_meta-as-project 'in progress' — stale",
    "target_state": "v1.0·v1.1_meta-as-project·v1.1_readme-cleanup completed 표기 + v1.1_agents-md-cleanup 현재 작업 중 표기"
  },
  "options": [
    {
      "id": "A",
      "description": "Status 1줄 핀포인트 수정 (최소 변경)",
      "pros": ["변경 범위 최소", "회귀 없음"],
      "cons": ["없음"]
    },
    {
      "id": "B",
      "description": "Status 섹션 전체 재작성",
      "pros": ["더 많은 정보 포함 가능"],
      "cons": ["scope 초과 — PLAN.out_of_scope에 해당", "검토 비용 증가"]
    }
  ],
  "risks_identified": [
    "markdownlint line-length 경고 (현재 line 84 이미 길어서 패스 중인지 확인 필요)"
  ]
}
```

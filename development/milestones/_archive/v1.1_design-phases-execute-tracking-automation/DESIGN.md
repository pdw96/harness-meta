# DESIGN — v1.1_design-phases-execute-tracking-automation

```json
{
  "id": "v1.1_design-phases-execute-tracking-automation",
  "decisions": [
    {
      "decision": "Option A 채택 — harness-meta.md 지침 텍스트 2지점 갱신",
      "rationale": "최소 변경으로 목표 달성. smoke 추가(Option C)는 out_of_scope 명시. 템플릿 예시(Option B)는 과도한 비대화.",
      "alternatives_rejected": ["Option B (phases 예시 JSON)", "Option C (smoke 검증 — out_of_scope)"]
    },
    {
      "decision": "Stage E phases 설명에 execute/phase-{n}.md 포함 의무 문구 추가",
      "rationale": "DESIGN 작성 시점에서 누락 방지 — 작성자가 phases[n].affected_files에 execute 파일을 pre-populate하도록 안내.",
      "alternatives_rejected": []
    },
    {
      "decision": "Stage F step 1에 DESIGN.phases[n].affected_files 갱신 절차 추가",
      "rationale": "execute/phase-{n}.md 생성 직후 DESIGN 갱신을 묶어서 누락 방지.",
      "alternatives_rejected": []
    }
  ],
  "approach": "claude/commands/harness-meta.md 2지점 수정. (1) Stage E phases 필드 설명 줄에 execute/phase-{n}.md 포함 의무 추가. (2) Stage F step 1 설명에 DESIGN.phases[n].affected_files 갱신 절차 명시. 1-phase, 1-commit.",
  "phases": [
    {
      "n": 1,
      "title": "harness-meta.md Stage E/F 지침 갱신",
      "scope": "Stage E phases 필드 설명 + Stage F step 1 설명 2지점",
      "affected_files": [
        "claude/commands/harness-meta.md",
        "execute/phase-1.md"
      ],
      "rationale": "단일 파일 단일 commit으로 bisect 최적화",
      "risks": ["smoke-claude-md-drift 검사 — harness-meta.md 변경 시 root CLAUDE.md와 drift 발생 가능성"]
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 (drift)", "mitigation": "pre-commit smoke-claude-md-drift 자동 검증"},
    {"risk": "R2 (순서 충돌)", "mitigation": "step 1 마지막에 DESIGN 갱신 절차 추가 (파일 생성 직후)"}
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```

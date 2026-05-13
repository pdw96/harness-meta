# DESIGN — v1.1_agents-md-cleanup

```json
{
  "decisions": [
    {
      "decision": "Option A 채택: AGENTS.md line 84 Status 1줄 핀포인트 수정",
      "rationale": "변경 범위 최소 + PLAN.out_of_scope(전체 재작성 금지) 준수. 형식 변경(리스트 포맷)은 미래 milestone으로 미룸.",
      "alternatives_rejected": [
        "Option B (Status 섹션 리스트 포맷 전환) — architecture agent 중기 권장이나 본 milestone scope 초과"
      ]
    }
  ],
  "approach": "AGENTS.md line 84의 'v1.1_meta-as-project in progress' 표기를 v1.0·v1.1_meta-as-project·v1.1_readme-cleanup completed + v1.1_agents-md-cleanup in progress로 갱신. 1 phase, 1 commit.",
  "phases": [
    {
      "n": 1,
      "title": "AGENTS.md Status 갱신",
      "scope": "line 84 1줄 수정",
      "affected_files": ["AGENTS.md", "execute/phase-1.md"],
      "rationale": "scope가 단일 라인 수정이므로 phase 분할 불필요",
      "risks": "markdownlint line-length — 수정 후 길이 점검 필요"
    }
  ],
  "risk_mitigation": [
    {
      "risk": "line-length 경고",
      "mitigation": "pre-commit hook이 자동 검사 — 실패 시 줄바꿈 조정"
    }
  ],
  "parallel_review_summary": {
    "architecture": "적합. 역할·책임 영향 없음. 리스트 포맷은 중기 권장(본 milestone 외).",
    "spec_drift": "AGENTS.md line 84만 stale. README.md는 이상 없음 (직접 확인 완료).",
    "scope_contract": "success_criteria 1-3 충족. out_of_scope 미침범. 즉시 진행 가능."
  },
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```

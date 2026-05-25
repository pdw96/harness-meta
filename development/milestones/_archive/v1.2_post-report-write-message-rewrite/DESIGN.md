# DESIGN — v1.2_post-report-write-message-rewrite

```json
{
  "id": "v1.2_post-report-write-message-rewrite",
  "decisions": [
    {
      "decision": "Option A 채택 — FILE_TYPE 2분기 유지, 메시지 텍스트만 교체",
      "rationale": "out_of_scope '세분화 라우팅 금지' 명시. 최소 변경으로 deprecated ref 제거 목표 달성.",
      "alternatives_rejected": ["Option B (FILE_BASENAME 세분화) — out_of_scope 위반"]
    },
    {
      "decision": "새 PLAN 메시지: '7-stage 다음: RESEARCH.md 작성으로 진행하세요 (/harness-meta)'",
      "rationale": "success criteria 'RESEARCH 키워드 포함' 정합. /harness-meta 진입점 명시.",
      "alternatives_rejected": []
    },
    {
      "decision": "새 REPORT 메시지: '7-stage 다음 단계로 진행하세요 (/harness-meta)'",
      "rationale": "success criteria '/harness-meta 키워드 포함' 정합. sections 있을 때도 동일 suffix.",
      "alternatives_rejected": []
    },
    {
      "decision": "smoke 6건 키워드 교체: harness-roadmap-update → /harness-meta, harness-plan-verify → RESEARCH",
      "rationale": "success criteria 정합. 기존 테스트 의도(additionalContext 포함 확인)는 유지.",
      "alternatives_rejected": []
    }
  ],
  "approach": "2-phase. phase-1: hook 메시지 3줄 교체. phase-2: smoke 6건 keyword 교체 + 헤더 갱신.",
  "phases": [
    {
      "n": 1,
      "title": "hook 메시지 교체",
      "scope": "claude/hooks/post-report-write.sh lines 149~155 (additionalContext MSG 3줄)",
      "affected_files": [
        "claude/hooks/post-report-write.sh",
        "execute/phase-1.md"
      ],
      "rationale": "hook과 smoke 분리 commit",
      "risks": ["smoke A/F/H/K/P/R 로컬 실행 FAIL — phase-2에서 즉시 수정"]
    },
    {
      "n": 2,
      "title": "smoke 키워드 갱신",
      "scope": "tests/smoke-posttooluse-hook.sh — Tests A/F/H/K/P/R 키워드 교체 + 헤더 버전 갱신",
      "affected_files": [
        "tests/smoke-posttooluse-hook.sh",
        "execute/phase-2.md"
      ],
      "rationale": "22 tests 유지, 키워드만 교체",
      "risks": []
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 (smoke 6건 키워드 누락)", "mitigation": "phase-2 즉시 수행"}
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```

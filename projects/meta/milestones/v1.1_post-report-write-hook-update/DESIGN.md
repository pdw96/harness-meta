# DESIGN — v1.1_post-report-write-hook-update

```json
{
  "id": "v1.1_post-report-write-hook-update",
  "decisions": [
    {
      "decision": "Option A 채택 — 두 줄 regex 분리 (현행 if/elif 구조 유지)",
      "rationale": "diff 최소화 + FILE_TYPE 분기 명확. 2개 clause 이상이 필요한 경우가 아니므로 DRY 위반이라 볼 수 없음.",
      "alternatives_rejected": ["Option B (combined+sub-check) — 구조 변경 불필요, 복잡화만 증가"]
    },
    {
      "decision": "NotebookEdit → NOOP (milestone 산출물은 .md only)",
      "rationale": "7-stage milestones 파일은 모두 .md. .ipynb 지원 확장은 out_of_scope 명시. sessions-based ipynb 패턴 제거로 자연스럽게 NOOP.",
      "alternatives_rejected": []
    },
    {
      "decision": "Test M, O → NOOP 기대값으로 업데이트",
      "rationale": "기존 sessions/ 패턴 제거로 NotebookEdit trigger 동작은 사라짐. 새 패턴에서 .ipynb는 매치 불가.",
      "alternatives_rejected": ["tests 제거 — R2 위험 회피를 위해 NOOP 검증으로 유지"]
    },
    {
      "decision": "신규 Test R (execute/phase-{n}.md) + Test S (old sessions/ path → NOOP) 추가",
      "rationale": "PLAN success_criteria 정합 (execute/phase-N 감지) + 회귀 방지 (sessions 제거 확인)",
      "alternatives_rejected": []
    },
    {
      "decision": "hook 메시지 내용 (harness-roadmap-update / harness-plan-verify 참조) 유지",
      "rationale": "메시지 재작성은 out_of_scope 명시. 최소 변경 원칙.",
      "alternatives_rejected": []
    }
  ],
  "approach": "claude/hooks/post-report-write.sh의 path-matching 블록(lines 126~134)을 sessions/ 기반에서 projects/milestones/ 기반으로 교체. 동시에 smoke 테스트 경로 및 기대값 갱신 + Test R/S 추가. 2-phase 1-commit-per-phase.",
  "phases": [
    {
      "n": 1,
      "title": "hook 경로 패턴 교체",
      "scope": "claude/hooks/post-report-write.sh lines 126~134 — NORM_PATH 매칭 regex 2줄 교체",
      "affected_files": ["claude/hooks/post-report-write.sh"],
      "rationale": "hook과 smoke 분리 commit으로 bisect 용이",
      "risks": ["smoke A-Q 일부 FAIL → phase-2 이전 pre-commit 실패 가능성"]
    },
    {
      "n": 2,
      "title": "smoke 테스트 갱신",
      "scope": "tests/smoke-posttooluse-hook.sh — BASE_REPORT/PLAN 경로 교체 + M/O 기대값 변경 + Test R/S 신규",
      "affected_files": ["tests/smoke-posttooluse-hook.sh"],
      "rationale": "smoke 통과 후 pre-commit full-pass 달성",
      "risks": ["Test count 20 → 22 (R, S 추가) — Stage 2 헤더 업데이트 필요"]
    }
  ],
  "risk_mitigation": [
    {"risk": "R1 (sessions 경로 tests FAIL)", "mitigation": "phase-2에서 즉시 수정"},
    {"risk": "R2 (M, O NOOP 전환)", "mitigation": "기대값 {} 변경 + 코멘트 갱신"},
    {"risk": "R3 (execute/phase-{n} 미검증)", "mitigation": "Test R 신규"},
    {"risk": "R4 (구 sessions NOOP 미검증)", "mitigation": "Test S 신규"}
  ],
  "approval": {
    "approved_by": "user",
    "date": "2026-05-08"
  }
}
```

# EXECUTE phase-2 — claude/commands/harness-meta.md 9-stage 전면 재작성

```json
{
  "phase": 2,
  "title": "claude/commands/harness-meta.md 9-stage 전면 재작성",
  "status": "complete",
  "scope_recap": "claude/commands/harness-meta.md 전면 재작성: (1) 7-stage workflow 표 → 9-stage 표 (Stage A=OPEN ~ Stage I=PROPOSE), (2) 산출 파일명 PLAN.md → INTENT.md + APPROVE.md / PROPOSE.md 신규 거명, (3) 절차 9 stage 1:1 명시 (현 7-stage 절차 모두 보존 + APPROVE/PROPOSE 추가), (4) AskUserQuestion trigger 표 9 stage 갱신, (5) 금지 목록에 4-tier 추가 + 7-stage 신규 작성 금지 (단 본 v2.0 자체는 자기참조 표지 예외), (6) 관련 문서 링크 갱신.",
  "changes": [
    "claude/commands/harness-meta.md — 전면 재작성: 7-stage 워크플로우 → 9-stage 워크플로우 (ROADMAP 입력 source + Stage A=OPEN ~ Stage I=PROPOSE)",
    "산출 파일명: PLAN.md → INTENT.md, DESIGN.approval → APPROVE.md, REPORT.next_candidates → PROPOSE.md",
    "절차 Stage 책임 세부 (각 단계 단일 책임 narrative + JSON 필드)",
    "Stage 별 AskUserQuestion 자동 invoke 표 갱신 (A~I)",
    "금지 목록 갱신 (4-tier + 7-stage 신규 작성 금지, 본 v2.0 예외 명시)",
    "DESIGN.phases.affected_files 에 execute/phase-{n}.md 포함 의무 명시 유지"
  ],
  "execution_notes": "사용자 진입 path 의 1차 source. R3 mitigation 으로 현 7-stage 절차 모두 1:1 보존 + 9-stage 신규 stage (OPEN/APPROVE/PROPOSE) 추가 명시. R9 mitigation 으로 Stage 영문자 (A~I) 매핑 명확화 + 1줄 책임 명시.",
  "commit": "feat(meta): v2.0 phase-2 — claude/commands/harness-meta.md 9-stage 전면 재작성"
}
```

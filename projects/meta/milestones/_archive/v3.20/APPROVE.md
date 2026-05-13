# APPROVE — v3.20_drift-narrative-canonicalization

```json
{
  "id": "v3.20_drift-narrative-canonicalization",
  "approval": {
    "approved_by": "user",
    "date": "2026-05-13",
    "approval_summary": "v3.20 DESIGN 종합 (6 decisions D1~D6 + 1 phase + lightweight 모드 + 정확 narrative 문구) 사용자 명시 승인 — AskUserQuestion 'v3.20 DESIGN 종합 승인?' = '승인 — Stage F EXECUTE 진입'. AskUserQuestion D1 narrative 위치 = '§ 4 끝 (line 117 → 118)' 사용자 명시 선택 → DESIGN D1 채택. lightweight 모드 (5 관점 subagent 생략, v3.6~v3.19 누적 7/19 패턴 정합) + 1-phase 1+1 commit 도그푸드 + commit timing (b) default. Stage F EXECUTE 진입 게이트 통과."
  },
  "design_review_summary": {
    "mode": "lightweight",
    "subagent_review_policy": "skipped (5 관점 subagent 생략)",
    "subagent_review_rationale": "scope 작음 (1 파일 변경, narrative 1 paragraph 추가) + 충돌 부재 예상 + workflow self-improvement 본질 + v3.6~v3.19 lightweight 누적 7/19 검증 패턴. self_reference_policy: avoid 표지 명시.",
    "user_decisions": [
      {"id": "D1", "question": "drift 수용 narrative paragraph 위치", "user_choice": "§ 4 끝 (line 117 → 118)"},
      {"id": "APPROVE", "question": "v3.20 DESIGN 종합 승인", "user_choice": "승인 — Stage F EXECUTE 진입"}
    ],
    "no_subagent_findings_to_absorb": true
  },
  "next_step": "Stage F EXECUTE — phase-1 (ARCHITECTURE.md drift 수용 paragraph 추가 § 4 끝, line 117 직후) + commit (timing (a) phase-1 commit 안 INTENT~APPROVE 포함 또는 (b) Stage G commit 안 분리 — DESIGN D6 (b) default 채택)"
}
```

## narrative

본 APPROVE.md 는 **사용자 명시 승인 게이트** — `approved_by: "user"` + ISO-8601 date (2026-05-13). 자동 작성 금지 (CLAUDE.md CRITICAL).

5 관점 subagent 검토 생략 (lightweight 모드, DESIGN.review.subagent_review_policy: skipped) — 의견 충돌 흡수 본질 부재. 사용자 결정 2건 (D1 narrative 위치 + APPROVE 종합) AskUserQuestion 명시 선택 처리.

Stage F EXECUTE 진입 게이트 통과.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- milestones.md: [`milestones.md`](milestones.md)
- 직전 APPROVE 패턴 source: [`../v3.19/APPROVE.md`](../v3.19/APPROVE.md)
- workflow 자기참조 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2

# APPROVE — v3.21_narrative-canonicalization-3step-pattern

```json
{
  "id": "v3.21_narrative-canonicalization-3step-pattern",
  "approval": {
    "approved_by": "user",
    "date": "2026-05-14",
    "approval_method": "AskUserQuestion (Stage E gate) — '승인 (Recommended)' 명시 선택"
  },
  "approval_summary": {
    "scope": "ARCHITECTURE.md § 6.2 Lightweight 모드 안 'Workflow self-improvement 동결 정책' paragraph 직후 + '선례' subsection 직전 'Narrative 정전화 3단계 패턴' bold lead paragraph 1건 추가. 다른 host 변경 zero (단일 source 전략). 워크플로우 본문 변경 zero. smoke 추가 zero.",
    "mode": "lightweight (5 관점 subagent 생략, v3.6~v3.20 누적 8/20 패턴 9번째 적용)",
    "decisions_summary": {
      "D1": "host 위치 = § 6.2 Lightweight 모드 안 ('Workflow self-improvement 동결 정책' 직후, '선례' 직전) — 사용자 명시 선택 Option 3",
      "D2": "정확 문구 = 'Narrative 정전화 3단계 패턴' bold lead + 3 단계 (a)/(b)/(c) + v3.18/v3.20 cross-ref + grep 키워드 예시 + 적용 trigger + 도그푸드 표지",
      "D3": "단일 source 전략 — ARCHITECTURE.md § 6.2 1곳만, 다른 host cross-ref 추가 zero",
      "D4": "lightweight 모드 채택 (§ 6.2 trigger 3건 충족)",
      "D5": "1 phase (narrative 정전화 1 paragraph = 의미 단위 1건)",
      "D6": "commit timing (b) default — 단 lightweight 1-phase 시 (a)/(b) 실 동치 (v3.20 L1 evidence)"
    },
    "subagent_review": "skipped (lightweight 모드, v3.6~v3.20 패턴 정합)",
    "self_reference_policy": "avoid (workflow self-improvement 본질, § 6.2 자기참조 회피 표지) — 본 milestone 자체 3단계 패턴 자기 적용 도그푸드 cycle 3번째 (v3.18 + v3.20 + 본 milestone)"
  },
  "approval_narrative": "사용자 명시 발의 (A_user trigger, /harness-meta meta 자유 발의 round 안 'narrative 정전화 3단계 패턴 명문화' 옵션 명시 선택) → INTENT (의도) + RESEARCH (조사 + options 4건) + DESIGN (D1~D6 결정 + lightweight 모드 + 1 phase) 작성 → Stage E AskUserQuestion 승인 게이트 사용자 '승인 (Recommended)' 명시 선택. Stage F EXECUTE 진입 허가."
}
```

## narrative

본 APPROVE 는 **사용자 명시 승인 게이트** 단일 책임 — `approved_by: "user"` + `date: 2026-05-14` + approval_summary. 5 관점 subagent 생략 narrative (lightweight 모드).

승인 범위 — ARCHITECTURE.md § 6.2 1 paragraph 추가 + 산출물 7건 + milestones.md sub_milestones placeholder 교체 + ROADMAP entry status completed 갱신 (Stage I 시점). phase-1 commit + Stage G chore commit 2 commit.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- milestones.md (sub_milestones placeholder 교체됨): [`milestones.md`](milestones.md)
- § 6.2 Lightweight 모드 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2

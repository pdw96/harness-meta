# phase-2 — v5.17 diff + ARCHITECTURE + Stage G+H+I 통합

```json
{
  "phase": 2,
  "milestone": "v5.17",
  "title": "v5.15 diff 문서 (5+2 섹션) + ARCHITECTURE § 4 vector count 갱신 + self-loop 카운팅 정전화 + 9-stage Stage G+H+I 산출물",
  "status": "complete",
  "commit": "TBD (본 chore commit)",
  "actions": [
    {"step": 1, "action": "diff-vs-cycle4.md 생성 (5+2 섹션 D9)", "result": "PASS", "evidence": "projects/upbit/audit-2026-05-18-cycle5/diff-vs-cycle4.md (§ 1~5 v5.15 5 섹션 정합 + § 6 v1.20 apply 효과 + § 7 lint precheck 첫 실전)"},
    {"step": 2, "action": "ARCHITECTURE.md § 4 L135 D4 exact_text 적용 (4건 → 5건)", "result": "PASS", "evidence": "exact_text_new = `5건 (v1.17 first + v5.10 second + v5.14 third + v5.15 fourth + v5.17 fifth)` 적용 완료, grep verify 키워드 매치"},
    {"step": 3, "action": "self-loop 카운팅 정전화 (D3 결정, REPORT 안 narrative + diff-vs-cycle4.md § 5 explicit_counting)", "result": "PASS", "evidence": "18 self-loop + 5 외부 = 23 total, 18/23 = 78.26% ≈ 78.3% (monotonic 감소 추세 지속 92.3% → 78.3%)"},
    {"step": 4, "action": "VERIFY.md 작성", "result": "PASS", "evidence": "smoke 6 + manual 8 + criteria 8 = 22 check PASS or PASS_WITH_NOTE, verdict = pass, 회귀 0"},
    {"step": 5, "action": "REPORT.md 작성", "result": "PASS", "evidence": "summary 3 문단 + delta + 7 lessons (L1~L7) + lessons_learned 명시"},
    {"step": 6, "action": "PROPOSE.md 작성", "result": "PASS", "evidence": "next_candidates 10건 거명만 (ROADMAP 등재 0건, lightweight default 동결 11 cycle 누적)"},
    {"step": 7, "action": "milestones.md sub_milestones 갱신 (phase-1 commit 8acc2a9 + phase-2 status complete)", "result": "PASS", "evidence": "phase-1 status=complete commit=8acc2a9 + phase-2 status=complete commit=TBD (본 chore)"},
    {"step": 8, "action": "ROADMAP entry status in_progress → completed", "result": "PASS", "evidence": "projects/meta/ROADMAP.md v5.17 entry status='completed'"},
    {"step": 9, "action": "phase-1.md commit 필드 갱신 (TBD → 8acc2a9)", "result": "PASS", "evidence": "execute/phase-1.md commit='8acc2a9'"}
  ],
  "execution_notes": {
    "phase_completion": "Phase 2 = 9 step 모두 완료. Stage G+H+I 통합 chore commit으로 산출물 영구 보존 (b 패턴)",
    "regression_count": 0,
    "lightweight_compliance": "lightweight default 동결 누적 11 cycle (v5.7 ~ v5.17). ROADMAP 등재 0건. next_candidates 10건 거명만."
  },
  "affected_files": [
    "projects/upbit/audit-2026-05-18-cycle5/diff-vs-cycle4.md (신규)",
    "projects/meta/ARCHITECTURE.md (§ 4 L135 exact_text edit)",
    "projects/meta/milestones/v5.17/VERIFY.md (신규)",
    "projects/meta/milestones/v5.17/REPORT.md (신규)",
    "projects/meta/milestones/v5.17/PROPOSE.md (신규)",
    "projects/meta/milestones/v5.17/milestones.md (sub_milestones 2 phase 갱신)",
    "projects/meta/milestones/v5.17/execute/phase-1.md (commit 필드 8acc2a9 갱신)",
    "projects/meta/milestones/v5.17/execute/phase-2.md (본 파일)",
    "projects/meta/ROADMAP.md (v5.17 status completed)"
  ]
}
```

## narrative

**phase-2 완료**: diff-vs-cycle4.md (5+2 섹션) 생성 + ARCHITECTURE § 4 vector count 4→5 갱신 + self-loop 정전화 78.3% + Stage G+H+I 산출물 (VERIFY/REPORT/PROPOSE) 작성 + milestones.md/phase-1.md/ROADMAP 갱신. 9 step 모두 PASS.

**v3.21 narrative 정전화 3 단계 패턴 18번째 cycle 도그푸드 완성**: (a) DESIGN.D4.exact_text_old/new 사전 정의 → (b) EXECUTE Phase 2 Step 2 Edit 적용 → (c) VERIFY grep 키워드 verify.

**핵심 evidence (Phase 2)**:

1. **diff-vs-cycle4.md 5+2 섹션**: § 1~5 v5.15 패턴 정합 + § 6 v1.20 apply 효과 (R1+R2 표) + § 7 v5.16 lint precheck 첫 실전 결과 (4 × 3 = 12 cell + MD038 1건 발견)
2. **ARCHITECTURE § 4 vector count**: 4건 → 5건 (D4 exact_text 적용)
3. **self-loop 정전화**: 18/23 = 78.3% (monotonic 감소 추세 지속)
4. **Stage G+H+I**: VERIFY pass / REPORT 7 lessons / PROPOSE 10 candidates 거명만
5. **milestones.md sub_milestones**: phase-1 complete (8acc2a9) + phase-2 complete (TBD)
6. **ROADMAP status**: v5.17 in_progress → completed

# phase-3 — 권고 #7 발의 준비 (upbit next_candidate)

```json
{
  "phase": 3,
  "title": "권고 #7 발의 준비 — upbit 외부 적용 next_candidate narrative (실 발의는 사용자 명시 trigger 대기)",
  "status": "complete",
  "scope": "PROPOSE.md next_candidates 안 upbit pending 3건 중 v1.1_upbit-cross-ref-cleanup (A_user trigger, 가장 시급) 활성화 거명 narrative + upbit/ROADMAP.md 변경 부재 결정",
  "affected_files": [
    "projects/meta/milestones/v3.6/execute/phase-3.md",
    "projects/meta/milestones/v3.6/PROPOSE.md"
  ],
  "decisions": [
    "upbit/ROADMAP.md 변경 부재 — 사용자 발의 권한 보존 (release train 거부, ARCHITECTURE.md § 6.2 정합). 본 milestone phase-3 는 PROPOSE.md next_candidates 거명만, 실 발의 (upbit ROADMAP entry status 변경 + INTENT 작성) 는 사용자 명시 trigger 후 `/harness-meta upbit` 별 milestone 에서 진행.",
    "next_candidate 발의 대상: upbit pending 3건 (v1.4_statusline-cmd-migration / v1.4_manifest-upgrade-1-1 / v1.1_upbit-cross-ref-cleanup) 중 v1.1_upbit-cross-ref-cleanup 우선 거명 — A_user trigger + 가장 단순 (v3.6 권고 #7 'evidence-base trigger' 부합 첫 사례)"
  ],
  "execution_notes": "narrative-only phase — phase-1/2 commit 과 달리 실 작업 부재. Stage I PROPOSE.md 작성과 묶음 1 commit (Stage G+H+I 통합)."
}
```

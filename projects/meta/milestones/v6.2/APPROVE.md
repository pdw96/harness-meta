---
id: milestone-artifact-directory-flattening
title: milestone 산출물 디렉토리 평탄화 (단일 파일 통합)
version: v6.2
stage: APPROVE
status: in_progress
---

# APPROVE — v6.2

## Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-19",
    "scope": "DESIGN.md 7 핵심 결정 + 5 관점 검토 종합 (decisive 0 / P1 11 + P2 9 모두 흡수) + 2-phase 구조 (phase-1 smoke+cascade / phase-2 v6.2 자체 retrofit). Stage F EXECUTE 진입."
  }
}
```

## 승인 narrative

사용자 명시 승인 (2026-05-19, "Stage F EXECUTE 진입 승인").

### 승인 항목

DESIGN.md `## Spec` 안 decisions D1~D17 + risk_mitigation r_1~r_8 + 5 관점 검토 결과 (pass-with-comments × 4 + pass × 1 / decisive 0 / P1 11 + P2 9 모두 흡수) + phases 2 (phase-1 + phase-2).

### EXECUTE 진입 게이트

- DESIGN 안 사용자 결정 7건 명시 → APPROVE 안 일괄 승인 (단어 결정 1:1 매핑 보존)
- 5 관점 검토 decisive 0건 = 구현 막는 결정적 이슈 부재
- v6.1 패턴 정합 (phase-1 도그푸드 + phase-2 광범위 적용)

### EXECUTE 단계 진행 순서

1. **phase-1** — tests/_era_detect.py 갱신 (9-stage-flattened 신규) → cb_4 regex 정확 spike (실 grep) → smoke 4종 era 분기 + posttooluse-hook NOOP → cascade 5 narrative host + post-report-write narrative comment → controlled 비교 4-step + pre-commit 14 hook PASS → commit
2. **phase-2** — MILESTONE.md 단일 통합 (INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md → 4 H2 섹션 + ## SUB_MILESTONES) → ## VERIFY/REPORT/PROPOSE H2 신규 작성 → ## EXECUTE summary table → git rm 5건 + git add MILESTONE.md atomic commit (D17, source hash 인용) → ROADMAP milestones_path 갱신

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- milestones.md: [`milestones.md`](milestones.md)

# milestones — v3.20_drift-narrative-canonicalization

본 파일은 **sub-milestone listing per version** (v3.0+ 9-stage-bundled era 의무, ARCHITECTURE § 6.1). ROADMAP entry `milestones_path` 와 1:1 매핑.

```json
{
  "version": "v3.20",
  "title": "word-fidelity drift 수용 narrative 정전화 — ARCHITECTURE.md 안 86.1% 부합도 + PROPOSE 70% drift 의도성 paragraph 추가",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "ARCHITECTURE.md drift 수용 paragraph 추가 — § 4 끝 (line 117 직후) + commit",
      "status": "complete",
      "commit": "b929cd8"
    }
  ]
}
```

## narrative

본 milestone 은 **v3.19_word-fidelity-audit-v2 PROPOSE.next_candidates#1 (drift-narrative-canonicalization)** 직접 후속. v3.19 진단 결과 (9-stage 부합도 평균 86.1% / PROPOSE 70% drift / APPROVE 100%) 의 ARCHITECTURE.md 안 narrative 정전화 → drift 의도성 (pragmatic 절충) 단일 source 보존.

- **lightweight 모드** (§ 6.2 자기참조 회피 표지) — 5 관점 subagent 검토 생략 (≤5 파일 + narrative 정전화 + v3.18 패턴 정합) + 산출물 LOC cap + 1 phase 1+1 commit 예상
- **narrative 정전화만** — 워크플로우 본문 변경 zero, smoke 추가 zero, 후속 candidate 거명만 (§ 6.2 default 동결 정합)
- **v3.18 패턴 두 번째 적용** — v3.17 진단 → v3.18 narrative 정전화 cycle 의 v3.19 진단 → v3.20 narrative 정전화 cycle 정합

phase-1 placeholder title 은 Stage D DESIGN 단계 `phases[]` 확정 후 1:1 동기 갱신 (Stage D 의무 step, v3.5 도입).

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.20 entry)
- 직전 milestone (진단 origin): [`../v3.19/`](../v3.19/) (word-fidelity-audit-v2, 본 milestone 의 PROPOSE next_candidates#1 source)
- 정전화 패턴 1차 source: [`../v3.18/`](../v3.18/) (Option A narrative 정전화, 본 milestone 패턴 source)
- 진단 + 정전화 cycle 1차: [`../v3.17/`](../v3.17/) (phase-distribution-audit, v3.18 의 진단 origin)
- bundling 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- workflow self-improvement 동결: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2

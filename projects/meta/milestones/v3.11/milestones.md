# v3.11 — legacy-narrative-cleanup (sub-milestone listing)

본 파일은 v3.0+ 9-stage-bundled era 의무 산출물 (per version sub-milestone listing). Stage A OPEN step 7 시점 스켈레톤 작성 → Stage D DESIGN 단계 `phases[]` 확정 후 `sub_milestones[]` 1:1 동기 갱신 (placeholder title 교체).

```json
{
  "version": "v3.11",
  "title": "stale sessions/ + 4-tier narrative 일괄 정리 — claude/CLAUDE.md + upbit ARCHITECTURE.md + CHANGELOG.md",
  "status": "completed",
  "self_reference_policy": "avoid",
  "self_reference_rationale": "Lightweight 모드 적용 (§ 6.2 trigger 3건 충족: narrative 정리 중심 + ≤5 파일 + 5 관점 충돌 부재 예상). 본 milestone 본질은 4-tier era 잔존 narrative 정리 — 자기참조 도그푸드 무관 (workflow self-improvement 부재).",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "3위치 stale narrative 일괄 갱신 (claude/CLAUDE.md L39 + upbit/ARCHITECTURE.md L106 + CHANGELOG.md L3)",
      "status": "complete",
      "commit": "40faa23"
    }
  ]
}
```

## 의도 요약

v1.5_legacy-narrative-cleanup (v1.x era pending entry, v1.4_cross-ref-propagation RESEARCH `untouched_files_explicit` 6건 묶음 origin) 의 v3.0+ 9-stage-bundled era renumber 진행 (forward-only § 6.1 의무). 실재 stale 5위치 cleanup 대상 — claude/CLAUDE.md L41~42 + projects/upbit/ARCHITECTURE.md L106 + CHANGELOG.md L3. claude/hooks/post-report-write.sh L2 거명은 이미 fix됨 (거명 자체 stale). historical entry (upbit ROADMAP L11~13 v1.4 entry summary, ARCHITECTURE L133 historical 이력) 는 forward-only era 정책 보존.

## 관련

- 상위 ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (version=v3.11, id=legacy-narrative-cleanup)
- era 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 (9-stage-bundled forward-only) + § 6.2 (Lightweight 모드)
- 선행 origin milestone: [`../v1.4_cross-ref-propagation/RESEARCH.md`](../v1.4_cross-ref-propagation/RESEARCH.md) (untouched_files_explicit 6건 묶음)
- Lightweight 선례: [`../v3.6_overengineering_audit/`](../v3.6_overengineering_audit/), [`../v3.10/`](../v3.10/)

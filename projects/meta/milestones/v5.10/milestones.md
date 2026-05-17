# v5.10 — external-audit-team-second-call-with-diff

```json
{
  "version": "v5.10",
  "title": "외부 audit-team 두 번째 실 호출 (upbit, proposer까지 read-only) + v1.17 산출물 diff 비교 + v5.8/v5.9 'audit-team 호출 0건' narrative drift 정정",
  "status": "in_progress",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "audit chain 4 멤버 순차 호출 + projects/upbit/audit-2026-05-18/ 산출",
      "status": "complete",
      "commit": "36d364b"
    },
    {
      "phase": 2,
      "title": "diff narrative + ARCHITECTURE § 4 끝 cascade drift paragraph + cascade 갱신",
      "status": "complete",
      "commit": "TBD (post-commit 갱신)"
    }
  ]
}
```

## narrative

본 milestone 은 v5.9 PROPOSE.next_candidates#5 (`external-audit-team-first-call`) 사용자 명시 선택 후 Stage A OPEN 단계 중 발견한 **v1.17 upbit milestone (2026-05-14, commit `16722fd`)** 안 audit chain 5 멤버 sequence 완전 실행 + 12 항목 ACCEPT ALL apply 사실로 인해 'first call' 전제 폐기 → 'second call + diff' 로 scope 재조정.

### 본 milestone 책임 (Option B 사용자 명시 결정)

1. **audit chain 재호출 (proposer 까지, read-only)** — upbit 대상으로 4 멤버 (scanner → analyzer → mapper → proposer) sequence 재실행. installer 미호출.
2. **v1.17 산출물과 diff 비교** — `~/harness-meta/projects/upbit/audit-2026-05-14/proposal-draft.md` (v1.17 산출 12 항목) vs 본 milestone proposal-draft (재실행 결과) — 시간 경과 후 spec drift / repo state 변화 / Claude Code docs 갱신 영향 검출.
3. **narrative drift 정정** — v5.8 RESEARCH § A1~A9 + v5.9 RESEARCH 정량 진단 안 'audit-team 호출 0건' 진술이 v1.17 사실과 모순. ARCHITECTURE.md 내 정정 narrative 정전화 (정확 위치 Stage D DESIGN 단계 결정).

### Stage D 단계 phases[] 확정 후 갱신 예정

OPEN 시점 phases 미확정 → phase-1 placeholder 잔존. Stage D 완료 직후 `sub_milestones[]` 를 phases[] 와 1:1 동기 갱신.

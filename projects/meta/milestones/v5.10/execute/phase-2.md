# execute/phase-2 — v5.10 diff narrative + ARCHITECTURE § 4 끝 cascade drift paragraph + cascade

```json
{
  "id": "v5.10_external-audit-team-second-call-with-diff",
  "phase": 2,
  "title": "diff narrative + ARCHITECTURE § 4 끝 cascade drift paragraph + cascade 갱신",
  "status": "complete",
  "scope": [
    "projects/meta/milestones/v5.10/diff-vs-v1.17.md 산출 (v1.17 12 항목 vs 본 milestone proposal 1:1 매핑 표 + added/removed/changed 분류 + narrative)",
    "ARCHITECTURE.md § 4 끝 D6 정확 문구 Edit 정확 삽입 (v3.21 3 단계 패턴 (b) 단계)",
    "milestones.md sub_milestones[] 2 entry 갱신 (phase-1 complete + commit hash + phase-2 in_progress → complete)"
  ],
  "actions": [
    {"step": 1, "action": "projects/meta/milestones/v5.10/diff-vs-v1.17.md Write", "status": "complete", "output": "~125 line, 1:1 매핑 표 + added/removed/drift + 정량 비교 + 후속 milestone 6 거명"},
    {"step": 2, "action": "ARCHITECTURE.md § 4 끝 (line 133 직후 + § 4.1 line 135 직전) D6 정확 문구 Edit 삽입", "status": "complete", "output": "1 paragraph 신규 (~8 line) — 'Narrative cascade drift 검증 의무 (v5.8 → v5.9 → v5.10 cascade)' bold lead + evidence + 정정 narrative + RESEARCH/upbit/audit-2026-05-18/ cross-ref"},
    {"step": 3, "action": "milestones.md sub_milestones 갱신 (phase-1 complete + commit 36d364b + phase-2 complete + commit 본 phase-2 commit hash)", "status": "complete"}
  ],
  "execution_notes": "Stage F phase-2 완료. ARCHITECTURE § 4 끝 cascade drift paragraph 정전화 = v3.21 narrative 정전화 3 단계 패턴 12 번째 cycle 도그푸드 (DESIGN.D6 1차 source + phase-2 EXECUTE Edit 정확 삽입 + Stage G VERIFY grep 키워드 검증 예정). diff narrative 독립 산출물 (diff-vs-v1.17.md) = milestone 디렉토리 내 audit-output 비대화 회피 (LOC 분리). cascade drift narrative 정전화 1 cycle 완료 — v5.8 origin → v5.9 cascade 누락 → v5.10 정정 → ARCHITECTURE 정전화 = 3 step audit trail."
}
```

## actions narrative

### Step 1 — diff-vs-v1.17.md 산출

`projects/meta/milestones/v5.10/diff-vs-v1.17.md` 신규 작성 (~125 line). 구조:

1. 1:1 매핑 표 (v1.17 12 항목 + KEEP, 8 CONFIRMED + 1 PARTIAL + 3 HELD + 1 REMOVED + 5 KEPT, 회귀 0)
2. 신규 변화 (added) — N1~N5 5건
3. 신규 변화 (removed) — 0건
4. narrative drift (correction needed) — D1/D2/D3
5. 정량 비교 표 (8 항목 delta)
6. 핵심 발견 5건
7. 후속 milestone 6 거명

### Step 2 — ARCHITECTURE § 4 끝 D6 정확 문구 Edit 삽입

`projects/meta/ARCHITECTURE.md` line 133 직후 + line 135 (§ 4.1 헤더) 직전 위치에 1 paragraph 추가:

- **헤더**: `**Narrative cascade drift 검증 의무 (v5.8 → v5.9 → v5.10 cascade)** (v5.10_external-audit-team-second-call-with-diff 정전화)`
- **본문**: cascade drift 본질 + v5.8 1차 정정 evidence + v5.9 cascade 누락 evidence + v5.10 second call 정정 + cascade drift 회피 의무 narrative
- **cross-ref**: `milestones/v5.10/RESEARCH.md` + `projects/upbit/audit-2026-05-18/` (4 산출물)

drift 수용 paragraph cluster 누적 3건 (line 131 word-fidelity + line 133 ROADMAP + 본 cascade) = drift family 자연 합류.

### Step 3 — milestones.md sub_milestones 갱신

phase-1 status: in_progress → complete + commit 36d364b 흡수. phase-2 status: pending → complete + commit (본 phase-2 commit hash, post-commit 갱신 또는 placeholder).

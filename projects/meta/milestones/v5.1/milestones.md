# milestones — v5.1 plugin-component-discovery-fix

```json
{
  "version": "v5.1",
  "title": "Plugin paths nested 인식 spec drift fix — Agents (0) + Skills (1 of 5) 인식 부족 해소",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "agents 재배치 — 7 agent .md git mv → ./agents/ flat + team CLAUDE.md → agents/project-harness-audit-team/ + 내부 경로 fix + plugin.json agents 필드 제거",
      "status": "complete",
      "commit": "7af00f2"
    },
    {
      "phase": 2,
      "title": "skills 재배치 — 5 skill dirs git mv → ./skills/ flat + plugin.json skills 갱신",
      "status": "complete",
      "commit": "94d0740 (+ cleanup cdaa83e)"
    },
    {
      "phase": 3,
      "title": "cascade narrative + CHANGELOG — 활성 host 9건 갱신 + [v5.1] entry 추가",
      "status": "complete",
      "commit": "2ea2c13"
    }
  ]
}
```

## narrative

Stage D DESIGN phases[] 확정 후 본 sub_milestones[] 1:1 동기 갱신 완료 (placeholder title 교체, v3.4_open-stage-milestones-md-protocol 정합).

- Phase 1: agents 표준 위치 재배치 (./agents/) — Agents 인식 (0 → 7) root cause 해소
- Phase 2: skills 표준 위치 재배치 (./skills/) — Skills 인식 (1 → 5) root cause 해소
- Phase 3: cascade narrative 갱신 (9 live host files) + CHANGELOG [v5.1]

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE: 본 디렉토리 안 동치 파일
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) milestones[0] (v5.1)
- v5.0 R1 mitigation 발견 source: [`../v5.0/VERIFY.md`](../v5.0/VERIFY.md) § "manual_checks D9 step 3 — Plugin component inventory 검증"
- v5.0 PROPOSE next_candidates#1: [`../v5.0/PROPOSE.md`](../v5.0/PROPOSE.md) (origin entry)

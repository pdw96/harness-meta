# phase-1 — 권고 #1 명문화

```json
{
  "phase": 1,
  "title": "권고 #1 명문화 — ARCHITECTURE.md § 6.2 'Lightweight 모드 정책' 신설 + workflow self-improvement 동결 정책",
  "status": "complete",
  "scope": "projects/meta/ARCHITECTURE.md 안 § 6.1 (era 정책) 다음에 § 6.2 신설 — lightweight 모드 trigger 조건 / 적용 시 차이 (산출물 LOC cap + 5 관점 생략 + 자기참조 회피 표지) / workflow self-improvement 동결 정책 (release train 거부, evidence-base trigger 만)",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md",
    "projects/meta/ROADMAP.md",
    "projects/meta/milestones/v3.6/milestones.md",
    "projects/meta/milestones/v3.6/INTENT.md",
    "projects/meta/milestones/v3.6/RESEARCH.md",
    "projects/meta/milestones/v3.6/DESIGN.md",
    "projects/meta/milestones/v3.6/APPROVE.md",
    "projects/meta/milestones/v3.6/execute/phase-1.md"
  ],
  "commit": "4ef8a74",
  "commit_message": "feat(meta): v3.6 phase-1 — ARCHITECTURE § 6.2 lightweight 모드 정책 신설 + workflow self-improvement 동결",
  "execution_notes": [
    "claude/commands/harness-meta.md 변경 부재 (D4 — workflow 절차 자체 변경 회피, 자기참조 사이클 재진입 방지)",
    "INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md 5건은 본 phase commit 에 포함 (lightweight 모드 — Stage G 묶음 대신 phase-1 안 포함, audit trail 즉시 영구 보존)"
  ]
}
```

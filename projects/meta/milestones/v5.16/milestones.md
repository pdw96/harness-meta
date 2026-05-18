# milestones — v5.16 audit-output-markdown-lint-precheck

```json
{
  "version": "v5.16",
  "title": "agent 산출 markdown lint precheck 절차 정전화 — MD022/MD031/MD032 위반 사전 방지 (v5.15 PROPOSE#2 carry-over, v5.14 L7 + v5.15 L5 누적 2 사례 trigger 충족)",
  "status": "in_progress",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "3-layer narrative 정전화 동시 변경 (ARCHITECTURE § 4 끝 + agents D8 Note v5.16 + claude/commands `--audit` 분기 lint precheck step)",
      "status": "in_progress",
      "commit": null
    }
  ]
}
```

## narrative

OPEN 시점 placeholder. Stage D DESIGN 단계에서 `phases[]` 확정 후 본 `sub_milestones[]` 를 1:1 동기 갱신한다 (placeholder title 교체).

본 milestone scope = agent 산출 (audit chain 4 멤버) markdown 의 markdownlint MD022/MD031/MD032 위반 사전 방지 절차 정전화. v5.13 정전화 3-layer cross-ref 구조 패턴 정합 (ARCHITECTURE WHAT + agents/project-harness-audit-team/CLAUDE.md D8 sequence WHERE + claude/commands/harness-meta.md --audit 분기 step HOW).

## 관련

- 운영 가이드 (root): [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 메타 ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- 직접 origin: v5.15 PROPOSE.next_candidates#2 (`audit-output-markdown-lint-precheck`)
- 누적 evidence: v5.14 L7 (3건) + v5.15 L5 (8건) = 2 사례 trigger 충족

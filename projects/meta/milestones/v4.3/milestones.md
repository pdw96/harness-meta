# milestones — v4.3

```json
{
  "version": "v4.3",
  "title": "Claude Code subagent discovery 메커니즘 RESEARCH — install (~/.claude/agents/ 매핑) 외 경로 (Plugin spec / settings path 등) 발견 + 후속 milestone 발의 narrative (scope rewritten)",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "narrative 정전화 (ARCHITECTURE.md + bootstrap/agents/CLAUDE.md) + ROADMAP v5.0_plugin-pivot pending entry 등재 (Lightweight 1-phase)",
      "status": "completed",
      "commit": "<Stage G+H+I 통합 chore commit, push 전 생성>"
    }
  ]
}
```

## 의도

원래 scope = `subagent-runtime-validation` (v4.2 PROPOSE #2 + #4 bundle). Stage D 진입 직후 사용자 의문 3 round raise (Developer Mode 의존 / install 자체 의문 / install 외 경로 탐색) → scope rewrite 결정. 새 scope = Claude Code subagent discovery 메커니즘 RESEARCH + Plugin spec 발견 + 후속 milestone 설계 narrative. 실 적용 (구조 변환) 은 v4.4+/v5.0+ 후속 carry-over.

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE: `INTENT.md` ~ `PROPOSE.md` (Stage B 진입 후 작성)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) `milestones[]` 안 `version: v4.3` entry
- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- workflow 진입점: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)

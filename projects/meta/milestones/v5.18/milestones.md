# Milestones — v5.18 audit-chain-direct-read-and-verification-depth

본 파일은 **v3.0+ 9-stage-bundled era 의무 narrative 1차 source** — `projects/meta/ROADMAP.md` 의 v5.18 entry `milestones_path` 와 1:1 매핑. sub_milestones 는 Stage A step 7 에서 placeholder 로 작성, Stage D DESIGN 단계에서 `phases[]` 확정 후 동기 갱신 (1:1).

```json
{
  "version": "v5.18",
  "title": "audit chain agent prompt 'input 산출물 직접 Read 의무' 명시 + v5.13 fact 검증 절차 깊이 강화 (검증 method 분리) — v5.17 PROPOSE #1+#4 통합, cycle 9 evidence 도달 trigger",
  "status": "completed",
  "sub_milestones": [
    {
      "phase": 1,
      "title": "audit chain agent .md 안 'input 산출물 직접 Read 의무' narrative + v5.13 절차 검증 method 분리 + § 4 끝 cross-ref 갱신",
      "status": "complete",
      "commit": "2e44260"
    }
  ]
}
```

## narrative

### bundling 정합

v5.17 PROPOSE.next_candidates 안 2건 (#1 agent-prompt-direct-read-mandate + #4 fact-verification-depth-enhancement) 동일 root cause (audit chain hallucination cycle 9 누적, cycle 7+8+9 = 8건 evidence 도달) 통합. 단일 origin (v5.17 L1+L7 lessons) + 단일 본질 (audit chain agent 의 input 산출물 직접 Read 의무 부재) → 1 milestone 통합 자연 부합 (ARCHITECTURE § 6.1 9-stage-bundled era 정합).

### sub_milestones placeholder 허용 narrative

OPEN 시점에서는 정확한 phase 분할 미확정 — phase-1 title placeholder 허용, Stage D DESIGN 단계에서 phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신 (placeholder title 교체) 의무 (claude/commands/harness-meta.md Stage D 완료 직전 의무 step 정합).

## 관련

- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) v5.18
- 운영 가이드: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) Stage A step 7
- v5.17 PROPOSE (origin): [`../v5.17/PROPOSE.md`](../v5.17/PROPOSE.md) #1 + #4

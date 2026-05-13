# PROPOSE — v4.0

```json
{
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "next_candidates": [
    {
      "version": "v4.1",
      "id": "dev-tools-first-member-add",
      "title": "bootstrap/agents/dev-tools/ 첫 멤버 추가 (도그푸드 Proposal #1)",
      "source": "v4.0 VERIFY 도그푸드 step_4_proposer_drafts #1",
      "rationale": "v4.0 phase-5 시점 dev-tools/ 카테고리 = placeholder, 멤버 0건. audit/ vs dev-tools/ 균형 = fleet evolution 'scope 확장' case. 후보 = claude-md-management 정합 dev-tools subagent 또는 사용자 명시 신규 책임.",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 — ROADMAP 등재는 사용자 명시 결정 후 (e3 정책 정합)"
    },
    {
      "version": "v4.1 또는 v4.2",
      "id": "smoke-bootstrap-agents-add",
      "title": "tests/smoke-bootstrap-agents.sh 신규 smoke (도그푸드 Proposal #2)",
      "source": "v4.0 VERIFY 도그푸드 step_4_proposer_drafts #2",
      "rationale": "smoke-skills-install 정합 — bootstrap/agents/ 정적 매트릭스 검증 smoke 부재. 신규 멤버 추가 시 회귀 차단 책임 정전화 (active hook 7 → 8 검토).",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 — ROADMAP 등재는 사용자 명시 결정 후"
    },
    {
      "version": "v4.2 또는 후속",
      "id": "audit-team-scope-split",
      "title": "project-harness-audit-team scope 분할 검토 (도그푸드 Proposal #3)",
      "source": "v4.0 VERIFY 도그푸드 step_4_proposer_drafts #3",
      "rationale": "5 멤버 team → read-only 3 멤버 (scanner/analyzer/mapper) + apply 2 멤버 (proposer/installer) 분할 후보. fleet evolution 'scope 분할' case. 다만 v4.0 단일 team 도그푸드 후 사용 패턴 누적 evidence 기반 결정 권장 (즉시 분할 회피).",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 + evidence 누적 후 재발의 권장"
    },
    {
      "version": "v4.2 또는 후속",
      "id": "benchmark-routine-first-run",
      "title": "벤치마크 cycle 첫 실 cron 등록 + candidate_draft[] 첫 entry append",
      "source": "v4.0 phase-7 (벤치마크 cycle routine narrative 정전화) 후속",
      "rationale": "phase-7 = narrative 정전화 (schedule skill 호출 패턴 + entry schema). 실 cron 등록 + 첫 후보 detect (예: anthropics/* repo 검토 결과) 는 후속 milestone 으로. 사용자 환경 의존 — 실 등록은 Claude Code 안 자연어 호출 의무.",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "사용자 환경 의존 — 본 repo 안 ROADMAP 등재 X, 사용자 schedule 등록 후 첫 candidate_draft entry 발생 시 검토"
    },
    {
      "version": "v4.1+ (선택)",
      "id": "dogfood-install-precondition",
      "title": "도그푸드 실 Agent tool 호출 위한 ~/.claude/agents/ install 사전 진행",
      "source": "v4.0 VERIFY L6 lesson",
      "rationale": "v4.0 phase-5 산출 5 멤버 subagent 가 ~/.claude/agents/ 안 install 미실행 = Agent tool 호출 시 subagent_type 등록 부재. 도그푸드 실 Agent tool 호출 위해 사용자 환경 안 install 진행 권장 (Claude Code 자연어 호출 'harness-meta 설치해줘'). 본 repo 변경 X.",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "사용자 환경 작업 — 본 repo ROADMAP 등재 X"
    }
  ],
  "register_summary": "본 v4.0 PROPOSE.next_candidates 5건 모두 narrative 거명만 (ROADMAP milestones[] 등재 0건). 사용자 명시 결정 후 정식 등재 (e3 정책 정합). v4.0 정체성 자체가 자기참조 milestone 자동 등재 거부 — 새 정체성 본질 적용 정합."
}
```

## narrative

### 5 next_candidates 분류

| # | version | category | source | register status |
|---|---|---|---|---|
| 1 | v4.1 | fleet-evolution | 도그푸드 #1 | 거명만 |
| 2 | v4.1 또는 v4.2 | fleet-evolution | 도그푸드 #2 | 거명만 |
| 3 | v4.2 또는 후속 | fleet-evolution | 도그푸드 #3 | 거명만 + evidence 누적 후 |
| 4 | v4.2 또는 후속 | fleet-evolution | phase-7 후속 | 사용자 환경 의존 |
| 5 | v4.1+ (선택) | fleet-evolution | L6 lesson | 사용자 환경 작업 |

### ROADMAP 등재 0건 (e3 정책 정합)

모든 candidate 는 사용자 명시 결정 후 ROADMAP `milestones[]` 정식 등재 가능. 본 PROPOSE 안 자동 등재 회피 — v4.0 정체성 본질 정합 (자기참조 milestone 자동 발의 거부, 새 정체성 자체가 자연 가드레일).

### Candidate_draft[] vs ROADMAP milestones[] 분리

v4.0 phase-7 안 신설된 `candidate_draft[]` 는 벤치마크 routine 산출물 host. 본 PROPOSE.next_candidates 는 milestone 직접 후속 — 둘 다 사용자 명시 결정 게이트 통과 후 milestones[] 등재 가능 (역할 정합, source 차이만).

## 관련

- VERIFY: [`VERIFY.md`](VERIFY.md) 도그푸드 step_4_proposer_drafts
- REPORT: [`REPORT.md`](REPORT.md) L1~L8 lessons
- bootstrap/agents/CLAUDE.md (fleet evolution 5 case 매트릭스): [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md) (candidate_draft[] + milestones[])

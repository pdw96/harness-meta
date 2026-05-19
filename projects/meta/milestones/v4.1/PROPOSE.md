---
id: install-strategy-reaudit
title: PROPOSE v4.1
version: v4.1
stage: PROPOSE
status: completed
---

# PROPOSE — v4.1

## Spec

```json
{
  "next_candidates": [
    {
      "version": "v4.2 또는 후속",
      "id": "approve-gate-rewrite-narrative-canonicalization",
      "title": "APPROVE 게이트 안 milestone scope rewrite 처리 정책 narrative 정전화 (L1 후속)",
      "source": "v4.1 REPORT.lessons_learned L1",
      "rationale": "본 v4.1 자체가 APPROVE 게이트 안 사용자 의문 raise → milestone scope rewrite 첫 사례. 9-stage workflow 안 commit 부재 상태 scope rewrite 처리 정책 narrative 선례 부재. claude/commands/harness-meta.md Stage E (APPROVE) 또는 Stage A (OPEN) 안 'APPROVE 게이트 안 rewrite 처리' subsection narrative 정전화 후보. workflow self-improvement 본질 — § 6.2 default 동결 권고 정합 (ROADMAP 미등재, 사용자 명시 발의 시만 재발의).",
      "category": "workflow-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 — ROADMAP 미등재 (§ 6.2 default 동결, 사용자 명시 발의 후)"
    },
    {
      "version": "v4.2 또는 후속",
      "id": "research-cascade-grep-full-inventory",
      "title": "RESEARCH 단계 cascade host 전체 inventory grep 의무화 (L4 후속)",
      "source": "v4.1 REPORT.lessons_learned L4",
      "rationale": "본 v4.1 RESEARCH 안 cascade 7 host inventory → 회귀 risk 검토 + phase-2 실 grep 시 추가 9건 발견 (Makefile + .env.example + verify-lib.ps1 + verify.ps1 + verify.sh 등). RESEARCH 단계 안 'codebase' grep 전체 repo inventory 의무 narrative 강화 후보. v1.5_research-cascade-grep-discipline (현 deferred § 6.2 동결) 후속 patten — workflow self-improvement 본질 → § 6.2 default 동결 정합.",
      "category": "workflow-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 — § 6.2 default 동결 + v1.5 deferred 와 책임 동일 (외부 적용 evidence 누적 후 재발의)"
    },
    {
      "version": "v4.2 또는 후속",
      "id": "phase-commit-markdownlint-self-check",
      "title": "phase commit 전 markdownlint --all-files self-check 권장 narrative (L6 후속)",
      "source": "v4.1 REPORT.lessons_learned L6",
      "rationale": "v4.1 phase-2 commit 1차 markdownlint MD032 fail → 정정 후 재시도 PASS. autofix wrapper 부재 (markdownlint hook = direct, --fix 미지원) 패턴. claude/commands/harness-meta.md Stage F (EXECUTE) 안 'phase commit 전 self-check (markdownlint --all-files)' 권장 narrative 후보. workflow self-improvement 본질 → § 6.2 default 동결 정합.",
      "category": "workflow-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 — § 6.2 default 동결, 외부 적용 evidence 누적 후 재발의"
    },
    {
      "version": "v4.2 또는 후속",
      "id": "audit-team-scope-split",
      "title": "project-harness-audit-team scope 분할 검토 (v4.0 PROPOSE #3 carry-over)",
      "source": "v4.0 PROPOSE.next_candidates #3 carry-over",
      "rationale": "5 멤버 team → read-only 3 멤버 (scanner/analyzer/mapper) + apply 2 멤버 (proposer/installer) 분할 후보. fleet evolution 'scope 분할' case. 다만 단일 team 도그푸드 후 사용 패턴 누적 evidence 기반 결정 권장 (즉시 분할 회피). 본 v4.1 안 audit team 호출 부재 (4 관점 검토 = built-in agent types 활용) — evidence 누적 부족.",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "PROPOSE narrative 거명만 — evidence 누적 후 재발의 (사용 패턴 측정)"
    },
    {
      "version": "v4.x (사용자 환경)",
      "id": "dogfood-install-precondition-carry-over",
      "title": "도그푸드 실 Agent tool 호출 위한 ~/.claude/agents/ install 사전 진행 (v4.0 PROPOSE #5 + v4.1 R7 carry-over)",
      "source": "v4.0 PROPOSE #5 + v4.1 R7 mitigation narrative",
      "rationale": "본 v4.1 R7 도그푸드 모순 정전 — 본 milestone 실행 환경 안 component-installer subagent install 부재 = Agent tool 호출 시 subagent_type 등재 부재 → 메인 Claude 가 Bash 직접 처리. v4.1 D7 5 step sequence 안 Junction default 도입으로 Windows 사용자 onboarding 마찰 해소 → 실 install 진행 가능. 단 사용자 환경 의존 작업 — 본 repo ROADMAP 외.",
      "category": "fleet-evolution",
      "decision_pending": true,
      "register_status": "사용자 환경 작업 — 본 repo ROADMAP 등재 X (Claude Code 자연어 호출 'harness-meta 설치해줘')"
    }
  ]
}
```

## PROPOSE summary

v4.1 next_candidates 5건 모두 narrative 거명만 (ROADMAP milestones[] 등재 0건). 사용자 명시 결정 후 정식 등재 (e3 정책 정합 + § 6.2 default 동결 정합). v4.0 정체성 본질 (자기참조 milestone 자동 발의 거부, 새 정체성 자체가 자연 가드레일) + § 6.2 workflow self-improvement 동결 정책 (외부 적용 evidence 누적 후 재발의) 정합.

## narrative

### 5 next_candidates 분류

| # | version | category | source | register status |
|---|---|---|---|---|
| 1 | v4.2+ | workflow-evolution | v4.1 L1 | 거명만 (§ 6.2 동결) |
| 2 | v4.2+ | workflow-evolution | v4.1 L4 (v1.5 carry-over) | 거명만 (§ 6.2 동결 + v1.5 동일 책임) |
| 3 | v4.2+ | workflow-evolution | v4.1 L6 | 거명만 (§ 6.2 동결) |
| 4 | v4.2+ | fleet-evolution | v4.0 #3 carry-over | 거명만 (evidence 누적 후) |
| 5 | v4.x | fleet-evolution | v4.0 #5 + v4.1 R7 carry-over | 사용자 환경 (본 repo 외) |

### ROADMAP 등재 0건 (e3 정책 + § 6.2 default 동결 정합)

모든 candidate 는 사용자 명시 결정 후 ROADMAP `milestones[]` 정식 등재 가능. 본 PROPOSE 안 자동 등재 회피 — v4.0 정체성 본질 정합 + § 6.2 workflow self-improvement 동결 정책 정합 (외부 적용 evidence 누적 + 정량 데이터 기반 사용자 명시 발의 후만).

### B/C/D 부산물 통합 흡수 책임 (v3.10)

본 PROPOSE.next_candidates 5건 모두 — (a) INTENT.out_of_scope 6 entry / (b) RESEARCH.untouched + risks_identified 13 entry / (c) DESIGN.decisions[i].rationale + phases[n].scope / (d) REPORT.lessons_learned L1~L8 의 부산물 (사실 진술) 을 본 PROPOSE 단계 안 통합 흡수. 단일 origin 강제 정합 (B/C/D 정의 안 forward propose 명령형 부재 — v3.10 정합).

### v4.0 PROPOSE carry-over 패턴

v4.0 PROPOSE.next_candidates 5건 중:

- #1 (dev-tools-first-member-add) — v4.1 OPEN 시 bundling 결정 → APPROVE 게이트 직전 rewrite (폐기, 후속 case 발견 후 재발의)
- #2 (smoke-bootstrap-agents-add) — v4.1 OPEN 시 bundling 결정 → rewrite 폐기 (#1 와 동일)
- #3 (audit-team-scope-split) — 본 v4.1 PROPOSE #4 carry-over
- #4 (benchmark-routine-first-run) — 사용자 환경 의존 (carry-over narrative 미적용, 사용자 schedule 등록 시 첫 candidate_draft entry 발생)
- #5 (dogfood-install-precondition) — 본 v4.1 PROPOSE #5 carry-over (v4.1 R7 narrative 흡수)

carry-over 패턴 정합 — 본 repo 안 v4.x 후속 milestone candidate source 보존.

## 관련

- v4.0 PROPOSE 원본: [`../v4.0/PROPOSE.md`](../v4.0/PROPOSE.md)
- v1.5_research-cascade-grep-discipline (deferred § 6.2): [`../../ROADMAP.md`](../../ROADMAP.md) (deferred entry)
- v4.0 정체성 (§ 6.2 동결 정책): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.2
- 9-stage workflow Stage I: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)

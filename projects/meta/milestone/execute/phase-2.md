---
id: bundled-skill-absorption-cycle-1
title: "외부 도우미 흡수 1차 평가"
version: v7.1
phase: phase-2
sub_milestone: v7.1.2
status: completed
---

## Spec

```json
{
  "phase": "phase-2 (v7.1.2)",
  "scope": "책임 비교 매트릭스 산출 — 4 sub 각 결정 매트릭스 entry (d_1 5 필드 schema = skill_name + category + repo_asset + decision + rationale) 산출. 4 entry = 4 candidate origin 매핑 (v6.19 + v6.21 L4/L5/L6 + dx P3#2 + security P3#3).",
  "decision_matrix": [
    {
      "entry": "v7.1.1",
      "skill_name": "`/simplify` `/batch` `/debug` `/run-skill-generator` (부재 4건)",
      "category": "Bundled skill (prompt-based playbook) 또는 fixed-logic 추정 — 본 세션 부재 (Claude Code 버전 분기 또는 plugin 별도 install 추정)",
      "repo_asset": "본 repo 자산 매핑 부재 — 4건 모두 본 세션 안 부재 fact direct",
      "decision": "drift_verified (cycle 2 backfill — 흡수/유지/cross-ref 결정 본질 부재, 4건 부재 fact 정전화만)",
      "rationale": "v6.21 L4 origin 정합. catalog L120 안 `simplify` 거주 표기 stale → 표 아래 Note 정정 + frontmatter audit_history[1] entry append 완료 (phase-1). 본 cycle 2 outcome = 4 candidate 본질 한정 평가 + 즉시 흡수 0건 (mandate #5 정합). 향후 cycle (Claude Code 버전 분기 verify 또는 plugin install evidence 발현 시) 안 재평가 자연."
    },
    {
      "entry": "v7.1.2",
      "skill_name": "`/code-review` (거주, system reminder description = 'Review the current diff for correctness bugs at the given effort level (low/medium: fewer, high-confidence findings; high→max: broader coverage, may include uncertain findings). Pass --comment to post findings as inline PR comments.')",
      "category": "Skill tool invocable (built-in fixed-logic, L111 정합)",
      "repo_asset": "본 repo 5 관점 review subagent (DESIGN 안 architecture+spec-drift+cost+dx+security 병렬 호출 patten, v7.0 d_2 안 호출 default 폐기)",
      "decision": "cross-ref",
      "rationale": "본질 다름 — bundled skill `/code-review` = 일반 diff 리뷰 (effort level low/medium/high/max + inline PR comments option) vs 본 repo 5 관점 review = milestone DESIGN stage 안 5 관점 책임 분리 본질. v7.0 d_2 + 본 d_3 dogfood cycle 2 후 본 repo 5 관점 review subagent 호출 default 폐기 (호출 시점 = 사용자 명시 발의 시만 예외). 사용자 자연어 'review' 자연 trigger 시 = bundled skill `/code-review` 활용 default. cross-ref narrative ARCHITECTURE § 7.3 끝 (d_4 inject)."
    },
    {
      "entry": "v7.1.3",
      "skill_name": "bundled skill (prompt-based playbook, L111 정합) 5건 + Skill tool invocable 3건 + fixed-logic only 5건 + 시스템 plugin 3건 + 기타 plugin 3건 (vs 본 repo plugin SKILL 14건)",
      "category": "카테고리 본질 분리 — Anthropic 표준 (4 카테고리) vs 본 repo plugin (harness-meta plugin)",
      "repo_asset": "본 repo plugin SKILL 14건 (stage-* 9건 = open/intent/research/design/approve/execute/verify/report/propose + supporting 5건 = harness-meta / harness-roadmap-update / harness-plan-verify / ai-ready-scorer / developer-profile / mindvault)",
      "decision": "cross-ref (narrative 보강만, ARCHITECTURE § 7.3 끝 1 sentence)",
      "rationale": "두 카테고리 책임 본질 분리 — 본 repo plugin SKILL = 9-stage workflow stage 작성 task derived checklist + cascade narrative 정전화 source (v6.16 phase-2 시범 + v6.18 7 stage 확장 cycle 2 dogfood evidence) / bundled skill = 일반 코딩 task helper (review / batch decompose / verify / loop / claude-api / run). 본 카테고리 분리 narrative = sc_4 충족 source. v6.21 L5 origin 정합."
    },
    {
      "entry": "v7.1.4",
      "skill_name": "`/code-review` + `/security-review` (검토 도우미 2건 거주, system reminder description = 'Complete a security review of the pending changes on the current branch')",
      "category": "Skill tool invocable (built-in fixed-logic, L111 정합)",
      "repo_asset": "본 repo 5 관점 review subagent (DESIGN architecture+spec-drift+cost+dx+security 병렬, v7.0 d_2 + 본 d_3 dogfood cycle 2 정합 호출 default 폐기)",
      "decision": "cross-ref + 본 repo 5 관점 review 호출 default 폐기 자연 흡수 (d_6 정전화)",
      "rationale": "v7.0 mandate #6 (PoLP 정합 정전화) + d_2 + 본 d_3 dogfood cycle 2 누적 evidence direct (v7.0 cycle 1 + 본 v7.1 cycle 2 누적). 본 repo 5 관점 review subagent 호출 default 폐기 cycle 2 누적 → `/code-review` `/security-review` cross-ref default 자연. 사용자 자연어 'review' / 'security' 명시 trigger 시 bundled skill 활용 분기 (책임 분리). ARCHITECTURE narrative 보강 (d_4 inject 위치 안 자연 통합, 별 host 추가 부재). v6.21 dx P3#2 + security P3#3 origin 정합."
    }
  ],
  "verification": {
    "smoke": "spec 426/0 + scope 96/0 + cascade-drift PASS + candidate-draft-schema 12/0 (4 종 PASS) — pending phase-2 작성 후 verify",
    "decision_matrix_schema": "4 entry 모두 5 필드 (skill_name + category + repo_asset + decision + rationale) 정합 verify"
  },
  "commit": {
    "sha": "pending",
    "message_draft": "feat(meta): v7.1 phase-2 — 책임 비교 매트릭스 산출 4 entry (5 필드 schema)",
    "policy": "CARRYOVER §9 commit 보류 정책 정합 — verdict RESOLVED 후 일괄"
  }
}
```

## Narrative

phase-2 완료 — 책임 비교 매트릭스 4 entry 산출 (5 필드 schema 정합).

**4 entry outcome 요약**:

- **v7.1.1**: 부재 4건 (`/simplify` `/batch` `/debug` `/run-skill-generator`) = drift_verified (catalog cycle 2 backfill 안 정전화)
- **v7.1.2**: `/code-review` ↔ 본 repo 5 관점 review = **cross-ref** (본질 다름 — 일반 diff 리뷰 vs milestone DESIGN 안 5 관점 책임 분리)
- **v7.1.3**: bundled skill 카테고리 5 (Anthropic 표준) ↔ 본 repo plugin SKILL 14 = **cross-ref** (narrative ARCHITECTURE § 7.3 끝 1 sentence)
- **v7.1.4**: `/code-review` `/security-review` ↔ 본 repo 5 관점 review = **cross-ref + 본 repo default 폐기 자연 흡수** (v7.0 mandate #6 cycle 2 dogfood)

**4 entry 결정 분포**: drift_verified 1 + cross-ref 3 (그 중 1건 = cross-ref + default 폐기 자연 흡수). 흡수 0 + 유지 0 = mandate #5 정합 (mechanism 추가 default 폐기).

본 phase = sc_2 (책임 비교 매트릭스 산출 1건 이상) + sc_3 (결정 매트릭스 entry 4건) 충족 source.

phase-3 진입 — cross-ref narrative ARCHITECTURE § 7.3 끝 inject (d_4).

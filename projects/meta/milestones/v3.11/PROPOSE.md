# PROPOSE — v3.11 legacy-narrative-cleanup

```json
{
  "id": "v3.11_legacy-narrative-cleanup",
  "propose_summary": "본 milestone Stage B (INTENT.out_of_scope) / C (RESEARCH.untouched_files_explicit) / D (DESIGN.decisions[i].rationale) 부산물 + Stage G VERIFY drift 검증 시 발견된 잔존 narrative 묶음에서 후속 candidate 2건 거명. v3.10 PROPOSE dual origin 흡수 책임 (B/C/D 부산물 + A_user trigger) 정합. § 6.2 default 동결 정책 — workflow self-improvement candidate (L1 ROADMAP summary 검증 메커니즘) 는 evidence-base trigger 대기, ROADMAP 미등재. narrative cleanup candidate (deprecated SKILL sessions/ 거명) 는 사용자 결정 받음.",
  "next_candidates": [
    {
      "id": "deprecated-skill-narrative-cleanup",
      "title": "bootstrap/skills/audit/harness-{plan-verify,roadmap-update}/SKILL.md sessions/ 거명 일괄 정리",
      "origin": "Stage G VERIFY 단계 grep 'sessions/' 결과 — bootstrap/skills/audit/harness-plan-verify/SKILL.md (L4/L5/L27/L28/L165/L166) + harness-roadmap-update/SKILL.md (L4/L22/L24) 안 deprecated SKILL narrative 의 sessions/meta/* / sessions/<project>/* 거명 잔존. v1.1_meta-as-project 에서 harness-roadmap-update SKILL deprecation 완료, but SKILL.md 본문 narrative 미갱신.",
      "trigger": "C_improvement",
      "trigger_type": "narrative cleanup (workflow self-improvement 아님, § 6.2 동결 정책 무관)",
      "roadmap_decision": "사용자 결정 받음 — 등재 가능 (실 narrative 정리)"
    },
    {
      "id": "roadmap-entry-summary-drift-detection",
      "title": "ROADMAP entry summary 거명 vs 실 코드 상태 drift 정기 검증 메커니즘",
      "origin": "L1 lessons_learned — v1.5_legacy-narrative-cleanup entry summary 안 'post-report-write.sh L2 stale 주석' 거명이 실 코드 (이미 9-stage 갱신, fix 완료) 와 drift. Stage A OPEN 단계 거명 사전 grep 검증 패턴이 필요. ROADMAP entry summary 자체 정기 검증 메커니즘 부재 — 신규 milestone 발의 시 거명 정확도 보장 불가.",
      "trigger": "B_regression",
      "trigger_type": "workflow self-improvement",
      "roadmap_decision": "§ 6.2 default 동결 — evidence-base trigger 대기 (외부 프로젝트 적용 milestone 1건 완료 후 정량 데이터 기반 명시적 사용자 발의만)"
    }
  ]
}
```

## ROADMAP 갱신 (Stage I 절차)

1. v3.11 entry status: in_progress → completed
2. next_candidates 2건 중 (1) deprecated-skill-narrative-cleanup 만 사용자 결정 시 ROADMAP 등재 (2) roadmap-entry-summary-drift-detection 은 § 6.2 동결, narrative 거명만

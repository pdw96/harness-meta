# DESIGN — v3.12 deprecated-skill-narrative-cleanup

```json
{
  "lightweight_mode": true,
  "lightweight_trigger": "§ 6.2 조건 3건 충족: (1) SKILL.md narrative 정리 중심 (메타 인프라 자산 정리) + (2) ≤5 파일 + (3) 의견 충돌 부재 예상",
  "self_reference_policy": "avoid",
  "self_reference_rationale": "본 milestone 은 SKILL.md 내 sessions/ 경로 거명 cleanup — workflow self-improvement 아님. § 6.2 Workflow self-improvement 동결 정책 해당 없음. 단 Lightweight 표지는 subagent 생략 근거로 유지.",
  "decisions": [
    {
      "decision": "Option A 채택 — sessions/ 직접 거명만 교체/제거, 구조 변경 없음",
      "rationale": "INTENT.out_of_scope 와 정합 — 기능 로직 변경 없음 + DEPRECATED 상태 변경 없음. harness-roadmap-update DEPRECATED 블록 내 역사적 서술(L31 등) 은 보존.",
      "alternatives_rejected": [
        {
          "option": "Option B — PLAN.md → DESIGN.md 등 현행 파일명 전면 업데이트",
          "reason": "scope 확장 위험. 기능 설명 재작성 = SKILL 재설계에 해당 — INTENT.out_of_scope 위반"
        }
      ]
    },
    {
      "decision": "harness-roadmap-update/SKILL.md allowed-tools L22/L24 sessions/ path 제거 (빈 줄로 교체 아닌 아예 제거 또는 projects/ 경로로 교체)",
      "rationale": "이미 DEPRECATED인 SKILL 의 broken path 잔존은 smoke 혼란 없음이나 가독성 오해 위험. projects/ 경로로 교체하면 DEPRECATED 블록과 정합성 유지."
    },
    {
      "decision": "harness-plan-verify/SKILL.md L165/L166 historical 세션 경로 제거",
      "rationale": "도입 세션 경로(sessions/meta/v1.24-*)는 현존하지 않는 경로 — 관련 문서 섹션에서 제거."
    }
  ],
  "approach": "단일 phase, harness-plan-verify/SKILL.md + harness-roadmap-update/SKILL.md 2파일 편집. sessions/ 직접 거명 6+3 = 9건 중 DEPRECATED 블록 내 역사적 서술 보존 건 제외 후 나머지 교체/제거.",
  "phases": [
    {
      "n": 1,
      "title": "SKILL.md 2건 sessions/ 거명 일괄 정리",
      "scope": "harness-plan-verify/SKILL.md L4/L5/L27/L28/L165/L166 + harness-roadmap-update/SKILL.md L4/L22/L24 sessions/ 거명 교체/제거",
      "affected_files": [
        "bootstrap/skills/audit/harness-plan-verify/SKILL.md",
        "bootstrap/skills/audit/harness-roadmap-update/SKILL.md",
        "projects/meta/milestones/v3.12/execute/phase-1.md"
      ],
      "rationale": "세션 2파일 모두 단순 경로 교체 — 1 phase 1 commit 적합",
      "risks": ["smoke 14 hook 중 SKILL 관련 검증 있으면 false positive 가능 (실제로 없음 — smoke 는 milestone 산출물 대상)"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "harness-plan-verify description trigger 오작동",
      "mitigation": "sessions/ 경로 표현만 교체, trigger 키워드('spec 검증' / 'context7 검증' 등) 유지"
    },
    {
      "risk": "harness-roadmap-update allowed-tools 변경으로 동작 변화",
      "mitigation": "이미 DEPRECATED + 실제 미사용. 경로 교체는 가독성 정리일 뿐"
    }
  ]
}
```

## 변경 상세 계획

### harness-plan-verify/SKILL.md

| 라인 | 현재 | 변경 후 |
|------|------|---------|
| L4 | `메타 + 프로젝트 세션 PLAN 검증 ... harness-meta sessions/meta/**/PLAN.md` | `메타 + 프로젝트 DESIGN/INTENT 검증 ... projects/meta/milestones/v{X.Y}/DESIGN.md` |
| L5 | `+ sessions/<project>/**/PLAN.md 작성 후 ...` | `+ projects/<name>/milestones/v{X.Y}/DESIGN.md 작성 후 ...` |
| L27 | `\`sessions/meta/v1.24+/**/PLAN.md\` (v1.24부터)` | `\`projects/meta/milestones/v{X.Y}/DESIGN.md\` (v2.0+ 9-stage era)` |
| L28 | `\`sessions/<project>/**/PLAN.md\` (v1.36+ 프로젝트 PLAN 지원, v1.24b 흡수)` | `\`projects/<name>/milestones/v{X.Y}/DESIGN.md\` (v2.0+ 9-stage era)` |
| L165 | `- 도입 세션: \`sessions/meta/v1.24-plan-spec-verification/\`` | 제거 |
| L166 | `- v1.29 \`--fix\` mode: \`sessions/meta/v1.29-verify-fix-mode/\`` | 제거 |

### harness-roadmap-update/SKILL.md

| 라인 | 현재 | 변경 후 |
|------|------|---------|
| L4 | `sessions/meta/ROADMAP.md 또는 projects/<name>/ROADMAP.md 자동 갱신.` | `projects/meta/ROADMAP.md 또는 projects/<name>/ROADMAP.md 자동 갱신.` |
| L22 | `- Edit(sessions/meta/ROADMAP.md)` | `- Edit(projects/meta/ROADMAP.md)` |
| L24 | `- Write(sessions/meta/ROADMAP.md)` | `- Write(projects/meta/ROADMAP.md)` |

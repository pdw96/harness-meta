# RESEARCH — v3.12 deprecated-skill-narrative-cleanup

```json
{
  "external": [
    {
      "source": "내부 — v1.0_workflow-redesign REPORT",
      "topic": "sessions/ 디렉토리 제거 시점",
      "findings": "v1.0_workflow-redesign phase-5 (2026-05-08) 에서 sessions/ 일괄 제거. harness-roadmap-update SKILL deprecation 완료. harness-plan-verify SKILL 은 7-stage era 에서 PLAN.md 기반으로 작성됨 — 현행 9-stage 에서 PLAN.md 없음.",
      "drift": "sessions/ 경로 거명 잔존 확인 — cleanup 필요"
    }
  ],
  "codebase": {
    "affected_files": [
      "bootstrap/skills/audit/harness-plan-verify/SKILL.md",
      "bootstrap/skills/audit/harness-roadmap-update/SKILL.md"
    ],
    "untouched_files": [
      "bootstrap/skills/audit/ai-ready-scorer/SKILL.md",
      "bootstrap/skills/dev-tools/mindvault/SKILL.md",
      "bootstrap/skills/dev-tools/developer-profile/SKILL.md"
    ],
    "current_state": {
      "harness-plan-verify/SKILL.md": {
        "sessions_references": [
          "L4: description — '...harness-meta sessions/meta/**/PLAN.md'",
          "L5: description — '+ sessions/<project>/**/PLAN.md ...'",
          "L27: 적용 대상 — '`sessions/meta/v1.24+/**/PLAN.md` (v1.24부터)'",
          "L28: 적용 대상 — '`sessions/<project>/**/PLAN.md` (v1.36+ 프로젝트 PLAN 지원, v1.24b 흡수)'",
          "L165: 관련 문서 — '도입 세션: `sessions/meta/v1.24-plan-spec-verification/`'",
          "L166: 관련 문서 — 'v1.29 `--fix` mode: `sessions/meta/v1.29-verify-fix-mode/`'"
        ],
        "deprecated": false,
        "note": "SKILL 자체는 현행 활성 (spec drift 검증 목적). PLAN.md 대신 현행 DESIGN.md 등에 적용 가능. 기능 로직은 유지, 경로 거명만 정리."
      },
      "harness-roadmap-update/SKILL.md": {
        "sessions_references": [
          "L4: description — 'REPORT.md 작성 직후 sessions/meta/ROADMAP.md 또는...'",
          "L22: allowed-tools — 'Edit(sessions/meta/ROADMAP.md)'",
          "L24: allowed-tools — 'Write(sessions/meta/ROADMAP.md)'",
          "L31 (DEPRECATED 블록 내): 'sessions/meta/ROADMAP.md 4-tier 포맷 기반' — 현행 정확한 역사적 사실 서술 (보존)"
        ],
        "deprecated": true,
        "note": "이미 L29-33에 DEPRECATED 블록 존재. frontmatter description(L4)과 allowed-tools(L22/L24)의 sessions/ 거명이 broken path로 잔존. DEPRECATED 블록 내 sessions/ 거명(L31)은 역사적 사실 기술 — 보존."
      }
    },
    "target_state": {
      "harness-plan-verify/SKILL.md": "description + 적용 대상 sections 의 sessions/ 경로 → 현행 milestones/ 경로 또는 간결한 현행 설명으로 교체. 관련 문서 historical 세션 경로 제거.",
      "harness-roadmap-update/SKILL.md": "frontmatter description(L4) sessions/ → projects/<name>/ 현행 경로 반영. allowed-tools(L22/L24) broken sessions/ path 제거 또는 projects/ 경로로 교체. DEPRECATED 블록(L29-33) 내 sessions/ 역사적 서술은 보존."
    }
  },
  "options": [
    {
      "id": "A",
      "label": "최소 정리 — sessions/ 직접 거명만 교체/제거, 구조 변경 없음",
      "pros": ["scope 최소", "회귀 risk 없음", "1 phase 가능"],
      "cons": ["harness-plan-verify SKILL description 이 현행 9-stage 에 완전히 정합하지 않음 (PLAN.md 언급 잔존 가능성)"]
    },
    {
      "id": "B",
      "label": "서술 현행화 — sessions/ 거명 + PLAN.md → DESIGN.md 등 현행 파일명 업데이트",
      "pros": ["SKILL 설명이 현행 9-stage 흐름과 정합"],
      "cons": ["scope 확장 (INTENT.out_of_scope 경계 모호)", "기능 로직 변경 아니므로 필요 이상"]
    }
  ],
  "risks_identified": [
    {
      "risk": "harness-plan-verify SKILL 의 현재 실사용 여부 불명 — cleanup 후 description trigger 오작동",
      "severity": "low",
      "note": "description 자체 의미는 유지, 경로 표현만 교체이므로 trigger 동작 무관"
    },
    {
      "risk": "smoke-spec-verification.sh 가 SKILL.md 내 경로 패턴 검증 시 false positive",
      "severity": "low",
      "note": "smoke 는 milestone 산출물 검증 대상, SKILL.md 본문 검증 아님"
    }
  ]
}
```

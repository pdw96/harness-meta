---
id: milestone-v5.5-research
title: RESEARCH v5.5
version: v5.5
stage: RESEARCH
status: completed
---

# RESEARCH — v5.5 v4x-deprecation-narrative-cleanup

## Spec

```json
{
  "external": [
    {
      "source": "v5.1 PROPOSE.md next_candidates#3",
      "topic": "v4x-deprecation-narrative-cleanup 원 scope",
      "findings": "v4.x SymbolicLink narrative 정리 — ~/.claude/agents/ 5 멤버 broken SymbolicLink cleanup + deprecation 표지 전면 정리. 실 SymbolicLink 물리 삭제는 사용자 환경 — repo narrative scope 만.",
      "drift": "none"
    }
  ],
  "codebase": {
    "affected_files": [
      "agents/environment-auditor.md (주요 — Stage B + A1 + Output 형식 v4.x 잔존)",
      "skills/harness-roadmap-update/SKILL.md (minor — install-skills 거명 L126)",
      "projects/meta/milestones/v5.5/INTENT.md",
      "projects/meta/milestones/v5.5/RESEARCH.md",
      "projects/meta/milestones/v5.5/DESIGN.md",
      "projects/meta/milestones/v5.5/APPROVE.md",
      "projects/meta/milestones/v5.5/VERIFY.md",
      "projects/meta/milestones/v5.5/REPORT.md",
      "projects/meta/milestones/v5.5/PROPOSE.md",
      "projects/meta/milestones/v5.5/execute/phase-1.md",
      "projects/meta/milestones/v5.5/milestones.md",
      "projects/meta/ROADMAP.md",
      "CHANGELOG.md"
    ],
    "untouched_files": [
      "README.md (이미 deprecated 표지 명시)",
      "AGENTS.md (이미 deprecated 표지 명시)",
      "CLAUDE.md (이미 deprecated 표지 명시)",
      "claude/CLAUDE.md (이미 deprecated 표지 명시)",
      "bootstrap/agents/CLAUDE.md (이미 deprecated 표지 명시)",
      "bootstrap/skills/CLAUDE.md (L95 deprecated, L96 'v4.x 환경' 명시)",
      "agents/component-installer.md (Step C3/C4 이미 'v4.x migration 진단' 레이블)",
      "GUARDRAILS.md (이미 deprecated 표지 명시)",
      "Makefile (이미 deprecated 표지 명시)",
      "CHANGELOG.md 기존 v4.x 항목 (backward 보존)",
      "projects/meta/milestones/_archive/ (historical 보존)"
    ],
    "current_state": {
      "environment_auditor_stage_b": "B1~B6 모두 ~/.claude/ SymbolicLink/Junction 존재 전제 — v5.0+ Plugin install 환경에서 실행 시 false-negative (6건 전부 FAIL/WARN). frontmatter description 도 'B Symlink 또는 Junction 무결성' 을 주요 check 로 노출.",
      "environment_auditor_a1": "A1: 'Junction default 도입 후 info-level, OFF 정상' — v4.x Junction 개념 컨텍스트 표지 없음. Output 형식 예시도 '[INFO] A1 Developer Mode OFF (Junction default 정상)' 동일.",
      "harness_roadmap_update_l126": "보안 위협 테이블 중 'typosquatting | install-skills의 0/1/2+ 매치 분기 답습' — install-skills 스크립트는 v4.0 phase-3 에서 폐기됨. 현재 pattern 은 Plugin install 안 적용 불가.",
      "other_files": "deprecation 표지 이미 명시 — 추가 수정 불필요"
    },
    "target_state": {
      "environment_auditor_stage_b": "Stage B 상단에 'Deprecated since v5.0 (v4.x install 환경 전용)' 표지 추가 + v5.0+ 환경 건너뜀 안내. frontmatter description 갱신 ('B Symlink 또는 Junction 무결성 (v4.x 환경 전용)' 또는 제거).",
      "environment_auditor_a1": "A1 설명에 '(v4.x Junction install 전용 체크)' 컨텍스트 표지 추가.",
      "harness_roadmap_update_l126": "install-skills 거명 제거 또는 '(폐기, v4.x historical)' 표지 추가."
    }
  },
  "options": [
    {
      "id": "A",
      "title": "deprecation 표지만 추가 (minimal)",
      "description": "Stage B 상단에 '(Deprecated since v5.0, v4.x 환경 전용)' 표지만 추가. B1~B6 check logic 변경 없음.",
      "pros": [
        "변경 최소 — 회귀 risk 0",
        "v4.x 사용자 여전히 활용 가능"
      ],
      "cons": [
        "v5.0+ 환경에서 Stage B 실행 시 여전히 false-negative 출력",
        "표지만으로 false-negative 차단 불가"
      ]
    },
    {
      "id": "B",
      "title": "Stage B v5.0+ 조건 skip + 표지 추가 (권장)",
      "description": "Stage B 상단에 'Plugin install 환경(v5.0+) detect 시 Stage B skip' 안내 추가 + 표지. Plugin install 검증은 'claude plugin list | grep harness-meta' 로 대체 언급.",
      "pros": [
        "v5.0+ 환경에서 false-negative 완전 차단",
        "표지 + 동작 안내 = 명확"
      ],
      "cons": [
        "약간 더 많은 변경"
      ]
    }
  ],
  "risks_identified": [
    {
      "risk": "environment-auditor.md frontmatter description 변경 시 system-reminder 노출 텍스트 변경",
      "severity": "low",
      "note": "description 은 agent 선택 힌트 — 'v4.x 환경 전용' 표지 추가는 기능 영향 없음"
    },
    {
      "risk": "Stage B check 건너뜀 시 v4.x 사용자 기존 검증 loss",
      "severity": "low",
      "note": "Option B 는 '환경 감지 기반 skip' — v4.x 사용자는 기존대로 Stage B 실행"
    }
  ]
}
```

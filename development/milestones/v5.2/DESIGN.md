---
id: milestone-v5.2-design
title: DESIGN v5.2
version: v5.2
stage: DESIGN
status: completed
---

# DESIGN — v5.2 agent-functional-path-cleanup

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option B 채택 — INTENT 사전 식별 2건 + RESEARCH 발견 3건 통합 fix",
      "rationale": "sc_4 narrative 정합 활용 (INTENT 안 'functional path 잔존 시 추가 fix' 사전 허용). v5.1 cascade 누락 완전 해소. 후속 B_regression 발의 불요.",
      "alternatives_rejected": [
        "Option A: RESEARCH 발견 functional stale 3건 미해소 → 후속 B_regression 잠재",
        "Option C: INTENT out_of_scope#2 충돌 (path string 외 git rm 범주 — empty subdir 는 path 아님)"
      ]
    },
    {
      "id": "D2",
      "decision": "Lightweight 모드 채택 — self-review 3 관점 (architecture / spec-drift / scope-contract)",
      "rationale": "path string 갱신 중심 + 4 unique files ≤5 + 충돌 부재 예상 → § 6.2 trigger 3조건 충족. 5 관점 subagent 생략.",
      "alternatives_rejected": [
        "Standard 3 관점 subagent: path string only 변경에 오버엔지니어링 위험"
      ]
    },
    {
      "id": "D3",
      "decision": "1-phase 구성",
      "rationale": "Option B 5 편집 (4 unique files + CHANGELOG) 모두 동일 성격 (path string 갱신) — 단일 cohesive commit 분할 필요 없음.",
      "alternatives_rejected": [
        "2-phase (사전 식별 2건 vs RESEARCH 발견 3건 분리): 단일 commit 충분, 분할 오버엔지니어링"
      ]
    },
    {
      "id": "D4",
      "decision": "INTENT~APPROVE commit 시점 (b) — Stage G (VERIFY) commit 안 포함",
      "rationale": "v3.18→v5.1 5-cycle evidence 기반 default 패턴 정합. Stage G commit 에 INTENT/RESEARCH/DESIGN/APPROVE.md 4건 포함 → 산출물 소실 없음.",
      "alternatives_rejected": [
        "(a) phase-1 commit 안 포함: stage G 전 소실 위험",
        "(c) 별도 chore commit: 불필요한 commit 증가"
      ]
    }
  ],
  "phases": [
    {
      "n": 1,
      "title": "functional path 5건 갱신 + CHANGELOG [v5.2]",
      "scope": "agents/environment-auditor.md L74 (path 3→2건 통합) + agents/harness-gap-analyzer.md L59 (path 2→1건 통합) + agents/component-installer.md L31/L39 (신규 추가 위치 + plugin.json skills 필드 값) + bootstrap/claude-code-catalog/README.md L34 (신규 멤버 작성 위치) + CHANGELOG.md ([v5.2] Fixed entry)",
      "affected_files": [
        "agents/environment-auditor.md",
        "agents/harness-gap-analyzer.md",
        "agents/component-installer.md",
        "bootstrap/claude-code-catalog/README.md",
        "CHANGELOG.md",
        "execute/phase-1.md"
      ],
      "rationale": "모든 편집이 path string 갱신 동일 성격 — 단일 phase 자연.",
      "risks": [
        "R1: line number shift (low — RESEARCH 확인 결과 다른 host line ref 거명 0건)",
        "R2: smoke-claude-md-drift 회귀 (예상 없음 — bootstrap/skills/CLAUDE.md 유지)"
      ]
    }
  ]
}
```

## Milestone

v5.2_agent-functional-path-cleanup

## Approach

agents/ + bootstrap/claude-code-catalog/ 4 unique files 내 functional audit path 5건 갱신 + CHANGELOG [v5.2] Fixed entry 추가. 1 phase 1 commit. Lightweight self-review 3 관점 완료 (충돌 0).

## Risk mitigation

- risk: R1 line shift; mitigation: RESEARCH 확인 결과 다른 host의 해당 파일 line ref 거명 0건 → 위험 무시 가능. VERIFY grep 으로 확인.
- risk: R2 smoke-claude-md-drift 회귀; mitigation: bootstrap/skills/CLAUDE.md 삭제 부재 → 회귀 0 예상. Stage F pre-commit 자동 검증.
- risk: R4 scope expansion phase 결정; mitigation: D3: 1-phase 결정 완료.

## Self review

- **mode**: lightweight
- **perspectives**: [{"name": "architecture", "verdict": "pass", "notes": "path string 갱신만. 구조 변경 없음. v5.1 Phase 1+2 git mv 결과와 정합. agents/ flat + skills/ flat 신 구조 반영."}, {"name": "spec-drift", "verdict": "pass", "notes": "5 편집 모두 실 위치 정합 — agents/ (7 .md flat) + skills/ (5 skill flat) + plugin.json `./skills/`. RE...
- **conflicts**: 0

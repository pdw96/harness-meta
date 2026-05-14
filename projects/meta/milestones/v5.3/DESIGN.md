# DESIGN — v5.3 external-marketplace-registration

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option A 채택 — documentation cascade only, marketplace.json 무변경",
      "rationale": "GitHub shorthand (pdw96/harness-meta) 는 전체 repo clone → './' 정상 작동. context7 spec 확인. 추가 파일 변경 불필요. 로컬 dev 흐름 보존.",
      "alternatives_rejected": ["Option B (marketplace.json GitHub source 객체 추가) — 불필요 변경, 로컬 relative path 동작 변경 risk"]
    },
    {
      "id": "D2",
      "decision": "GitHub shorthand 를 PRIMARY 표기, 로컬 clone 을 ALTERNATIVE 표기",
      "rationale": "외부 방문자 onboarding 마찰 해소가 본 milestone 목적. 외부 방문자 관점에서 clone 불요 경로가 더 간단.",
      "alternatives_rejected": ["동등 표기 — 방문자가 더 긴 경로를 기본으로 인식할 risk"]
    },
    {
      "id": "D3",
      "decision": "1 phase — 7 파일 cascade 단일 commit",
      "rationale": "순수 문서 cascade, 기능 변경 0, 파일 간 의존성 없음. 분할 불필요.",
      "alternatives_rejected": ["2 phase (primary 3 파일 + secondary 4 파일) — overhead 대비 이득 없음"]
    },
    {
      "id": "D4",
      "decision": "SC1 재해석 — marketplace.json 변경 없이 '메커니즘 확인' 으로 충족",
      "rationale": "INTENT SC1 에 'OR 외부 marketplace 등록 메커니즘이 확인된다' 조건 포함. context7 spec 확인으로 충족.",
      "alternatives_rejected": ["marketplace.json 변경으로 SC1 충족 — 불필요"]
    }
  ],
  "approach": "7 파일 (README / AGENTS / CLAUDE.md / agents/component-installer.md / bootstrap/agents/CLAUDE.md / projects/meta/ARCHITECTURE.md / Makefile) 의 install narrative 에 GitHub shorthand 명령을 PRIMARY 로 추가하고 기존 local clone 경로를 ALTERNATIVE 로 재배치. 1 phase 1 commit.",
  "phases": [
    {
      "n": 1,
      "title": "install narrative 7 파일 cascade — GitHub shorthand 추가",
      "scope": "README.md + AGENTS.md + CLAUDE.md + agents/component-installer.md + bootstrap/agents/CLAUDE.md + projects/meta/ARCHITECTURE.md + Makefile + CHANGELOG [v5.3] + execute/phase-1.md + milestones.md sub_milestones 갱신",
      "affected_files": [
        "README.md",
        "AGENTS.md",
        "CLAUDE.md",
        "agents/component-installer.md",
        "bootstrap/agents/CLAUDE.md",
        "projects/meta/ARCHITECTURE.md",
        "Makefile",
        "CHANGELOG.md",
        "projects/meta/milestones/v5.3/execute/phase-1.md",
        "projects/meta/milestones/v5.3/milestones.md"
      ],
      "rationale": "documentation cascade 단일 phase — 기능 변경 0, 파일 간 의존성 0.",
      "risks": ["R1: GitHub repo public 여부 — 로컬 환경에서 실 검증 불가. 문서 추가만 진행, 실 install 테스트는 VERIFY manual_check 에서 사용자 확인 권고"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1 — GitHub repo private 시 외부 방문자 install 실패",
      "mitigation": "VERIFY manual_check 에 'pdw96/harness-meta public repo 확인' 체크 추가. 문서에 'public repo 필요' 주석 추가."
    },
    {
      "risk": "markdownlint MD032 (list spacing) 재발 가능",
      "mitigation": "pre-commit 14 hook 자동 catch. v5.0 L8 선례 정합."
    }
  ],
  "review": {
    "scope_size": "중간 (7 파일)",
    "perspectives_applied": 4,
    "note": "순수 문서 cascade (기능 변경 0, smoke 추가 0) — subagent 생략, 인라인 4 관점 검토",
    "results": [
      {
        "perspective": "architecture",
        "verdict": "PASS",
        "notes": "구조 변경 0. 7 파일 모두 기존 install 섹션에 additive 추가. 책임 경계 불변."
      },
      {
        "perspective": "spec-drift",
        "verdict": "PASS",
        "notes": "context7 확인: GitHub shorthand → full repo clone → './' 정상 작동. marketplace.json 변경 불필요 spec 정합."
      },
      {
        "perspective": "regression-risk",
        "verdict": "PASS",
        "notes": "문서만 변경. pre-commit markdownlint 자동 catch. smoke (spec-verification / scope-contract) 영향 없음."
      },
      {
        "perspective": "scope-contract",
        "verdict": "PASS",
        "notes": "SC1 (메커니즘 확인), SC2 (README), SC3 (CLAUDE.md), SC4 (AGENTS), SC5 (cascade 7 파일), SC6 (회귀 0) 모두 충족 예상."
      }
    ]
  }
}
```

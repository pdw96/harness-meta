# DESIGN — v3.4 open-stage-milestones-md-protocol

```json
{
  "id": "v3.4_open-stage-milestones-md-protocol",
  "decisions": [
    {
      "decision": "D1: OPEN 단계 step 7 신규 추가 (RESEARCH options.A 채택)",
      "rationale": "step 6 (ROADMAP entry 갱신, in_progress 전환) 직후 신규 step 7 ('milestones.md 스켈레톤 작성') 추가. ROADMAP entry milestones_path 와 실 파일 1:1 매핑 명확 (entry milestones_path 가 가리키는 위치 = 직후 생성). step 카운트 6 → 7 미세 증가 trade-off 수용 (단일 책임 1:1 매핑 유지).",
      "alternatives_rejected": [
        "B (step 5 인라인) — mkdir 책임에 milestones.md 작성 결합. 단일 책임 약화.",
        "C (step 6 인라인) — ROADMAP entry 갱신 책임에 milestones.md 작성 결합. 책임 다름에도 결합.",
        "D (cross-ref only) — 본 milestone 의도 (절차 step 명시 추가) 와 정면 충돌."
      ]
    },
    {
      "decision": "D2: skeleton 최소 필드 narrative 1차 source 위치 이동 (Stage F 게이트 → Stage A step 7)",
      "rationale": "OPEN 단계가 첫 생성 시점 = narrative 1차 source 위치도 OPEN 단계로 이동. skeleton 최소 필드 (`version` + `sub_milestones[]` + phase-1 status: in_progress) 정의 = Stage A step 7. Stage F 선결 조건 게이트 블록 은 reference 로 변경 ('이미 OPEN 단계에서 생성됨, 확인만').",
      "alternatives_rejected": [
        "Stage F 게이트 1차 source 유지 + Stage A step 7 reference — narrative 시간 흐름 (생성 시점 = 1차 source) 과 충돌."
      ]
    },
    {
      "decision": "D3: phase-1 sub_milestone title placeholder 정책 narrative 명시",
      "rationale": "OPEN 시점 정확한 phase 분할 미확정. 'phase-1 title placeholder 허용, Stage D DESIGN 에서 정확한 title 갱신' narrative 를 Stage A step 7 안에 명시. 본 v3.4 milestones.md '비고' 섹션 narrative 가 자기참조 패턴 차용.",
      "alternatives_rejected": [
        "placeholder 금지 + OPEN 시점 정확 title 의무 — Stage D 단계 의도 위배 (OPEN 은 컨테이너 마운트 단계, phase 분할은 DESIGN 책임)."
      ]
    },
    {
      "decision": "D4: Stage F 선결 조건 게이트 블록 narrative 미세 갱신 (DRY 회피 + 보조 검증 step 명시)",
      "rationale": "현행 Stage F 게이트 블록 (v3.2 phase-1 도입) 의 'milestones.md 즉시 작성' 표현을 '이미 OPEN 단계 step 7 에서 생성됨, EXECUTE 진입 직전 확인만' 으로 갱신. skeleton 필드 narrative 는 'Stage A step 7 참조' cross-ref. 보조 검증 step 명시 (예: `test -f milestones/v{X.Y}/milestones.md`) — v3.2 phase-1 의 게이트 자동 강제력 보존 + spec-drift 권고 R1 흡수. 두 절차 narrative 중복 회피 + 단일 source 정합.",
      "alternatives_rejected": [
        "Stage F 게이트 narrative 완전 삭제 — Stage F 진입 직전 확인 단계 의무 narrative 보존 필요 (Claude 가 OPEN 단계 누락 가능성에 대한 보조 게이트).",
        "Stage F 게이트 narrative 보수 유지 — DRY 위배.",
        "보조 검증 step 명시 없이 narrative 축약만 — v3.2 게이트 자동 강제력 약화 (spec-drift R1 거부)."
      ]
    },
    {
      "decision": "D5: root CLAUDE.md L19 워크플로우 표 Stage A 행 narrative 보수 유지",
      "rationale": "root CLAUDE.md 의 워크플로우 표는 thin index — 상세는 claude/commands/harness-meta.md 단일 source. Stage A 행 narrative ('컨테이너 마운트 + ROADMAP entry in_progress') 는 함축 narrative 로 milestones.md 미언급 보수 유지. cascade 부담 최소화.",
      "alternatives_rejected": [
        "L19 행 narrative 갱신 ('컨테이너 마운트 + ROADMAP entry + milestones.md') — cascade host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 영향 검토 부담 + 본 milestone scope 확대."
      ]
    },
    {
      "decision": "D6: projects/meta/CLAUDE.md 모듈 가이드 행 narrative 보수 유지",
      "rationale": "현행 narrative 가 이미 milestones.md 거명 ('milestones/v{X.Y}/{...}.md + milestones.md (sub-milestone listing per version) + execute/phase-{n}.md'). OPEN 시점 의무 narrative 는 변경 없이 정상 작동 — 산출물 목록 안에 포함된 narrative 로 충분.",
      "alternatives_rejected": [
        "OPEN 시점 의무 narrative 추가 — claude/commands/harness-meta.md Stage A step 7 단일 source 와 중복."
      ]
    },
    {
      "decision": "D7: 자기참조 부합 (도그푸드) 검증 narrative — REPORT.lessons_learned 명시",
      "rationale": "v3.4 OPEN 단계 자체가 본 절차 수행 (milestones.md 스켈레톤 작성 완료, INTENT/RESEARCH 작성 시점 검증). REPORT.lessons_learned 에 'v3.4 자기참조 부합 — 본 milestone 자체가 신 절차 첫 적용' narrative 명시. v3.0/v3.1 자기참조 패턴 연속.",
      "alternatives_rejected": [
        "narrative 미명시 — 자기참조 부합 검증 trace 소실."
      ]
    }
  ],
  "approach": "단일 phase + 단일 commit. claude/commands/harness-meta.md Stage A OPEN 절차에 step 7 신규 추가 (skeleton 최소 필드 narrative 1차 source) + Stage F 선결 조건 게이트 블록 narrative 미세 갱신 (DRY 회피, '이미 OPEN 단계에서 생성됨' 표현). 본 milestone 의 OPEN 단계 자체가 도그푸드 수행 (milestones.md 스켈레톤 이미 OPEN commit 전 작성 완료, INTENT/RESEARCH/DESIGN/APPROVE 작성 시점 검증). pre-commit 6 hook 회귀 0 의무.",
  "phases": [
    {
      "n": 1,
      "title": "claude/commands/harness-meta.md Stage A step 7 신규 + Stage F 게이트 narrative 갱신",
      "scope": "Stage A OPEN 절차 step 6 직후 step 7 ('milestones.md 스켈레톤 작성') 신규. skeleton 최소 필드 narrative 1차 source (version + sub_milestones[] + phase-1 placeholder title 허용). Stage F 선결 조건 게이트 블록 narrative 미세 갱신 ('이미 OPEN 단계에서 생성됨, 확인만' + cross-ref).",
      "affected_files": [
        "claude/commands/harness-meta.md",
        "projects/meta/milestones/v3.4/execute/phase-1.md"
      ],
      "rationale": "단일 phase = 단일 commit. 두 영역 (Stage A step 7 신규 + Stage F 게이트 갱신) 은 동일 narrative 1차 source 이동 (Stage F → Stage A) 의 양면 — 분리 시 중간 상태 narrative 모순 (skeleton 필드 정의 단일 source 위치 부정합). 단일 phase 통합 의무.",
      "risks": [
        "R1 (DRY 위배) — D4 mitigation 적용",
        "R5 (smoke 회귀) — pre-commit 6 hook 모두 PASS 의무"
      ]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "R1: Stage F 게이트 블록 narrative 중복",
      "mitigation": "D4 — Stage F 게이트 블록 narrative 미세 갱신 ('이미 OPEN 단계에서 생성됨, 확인만'). skeleton 필드 narrative 는 'Stage A step 7 참조' cross-ref."
    },
    {
      "risk": "R2: skeleton 필드 narrative cascade 부담",
      "mitigation": "D2 — 단일 source 위치 = Stage A step 7. Stage F 게이트는 reference."
    },
    {
      "risk": "R3: phase-1 sub_milestone title placeholder 정책",
      "mitigation": "D3 — Stage A step 7 narrative 안에 placeholder 허용 명시."
    },
    {
      "risk": "R4: 자기참조 부합 (도그푸드) 위배 가능",
      "mitigation": "D7 — v3.4 OPEN 단계 자체가 본 절차 수행. REPORT.lessons_learned 명시."
    },
    {
      "risk": "R5: 회귀 risk (smoke 자동 동작 변경 없음에도 보수적 확인 의무)",
      "mitigation": "pre-commit 6 hook 모두 PASS 의무 (smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift / smoke-bundle-trigger). controlled 비교 시나리오 부재 (smoke 자동 동작 변경 없음)."
    },
    {
      "risk": "R6: 단일 source 정합 (root CLAUDE.md cascade)",
      "mitigation": "D5 — root CLAUDE.md L19 워크플로우 표 보수 유지. cascade 부담 최소화."
    }
  ]
}
```

## narrative

본 DESIGN 의 핵심 = 단일 phase + 단일 commit + narrative 1차 source 이동 (Stage F 게이트 → Stage A step 7). v3.2 phase-1 도입 시점 (Stage F 게이트 블록) 의 narrative 가 사실상 'OPEN 단계 직후 EXECUTE 진입 직전 작성' 으로 운용되어 시간 격차 발생 — 본 milestone 은 OPEN 단계 자체로 시점 이동.

3 관점 (architecture / spec-drift / scope contract) 병렬 검토 의무 (scope 작음, affected_files 2건). 회귀 risk 관점 + 보안 관점은 scope 작음 정의에 미해당하여 생략 가능 — 그러나 smoke 회귀 보장은 R5 mitigation 의무 적용 (subagent 검토 없이 pre-commit 6 hook 자동 검증).

자기참조 부합 (D7) — v3.4 OPEN 단계 commit 전 milestones.md 작성 완료 + INTENT/RESEARCH/DESIGN 작성 시점 검증. v3.0/v3.1 자기참조 패턴 연속.

## 5 관점 검토 (3 관점 적용, scope 작음)

본 섹션은 Stage D 의 subagent 병렬 검토 결과 기록. architecture / spec-drift / scope contract 3 관점 (회귀 risk + 보안 생략, scope 작음 + 절차 명문화 한정).

### architecture (Plan) — pass-with-comments

- 디렉토리 구조 영향 / 파일 책임 분리 / 자기참조 부합 = pass.
- 변경 영향 범위 = pass-with-comments. 권고 1 (minor): Stage F § narrative 안 OPEN 단계 cross-ref 추가 — D4 narrative 갱신 안에 자동 흡수 (claude/commands/harness-meta.md 단일 source, cascade 부담 없음).
- 본 관점 외 issue 부재.

### spec-drift (general-purpose) — pass-with-comments

- v3.1 / v3.2 / v3.3 narrative 정합 + smoke-bundle-trigger status 분기 부합 + ARCHITECTURE.md § 6.1 era 표지 부합 — drift 0.
- 권고 R1 (high): Stage F 게이트 narrative 갱신 시 EXECUTE phase 보조 검증 step 명시 (예: `test -f milestones.md`) — D4 narrative 강화 흡수. v3.2 게이트 자동 강제력 약화 회피.
- 권고 R2 (medium): REPORT.lessons_learned 에 'v3.2 게이트 narrative reference-only 전환 시점 = v3.4' 명시 — REPORT 시점 처리.
- 권고 R3 (low): 본 § placeholder 흡수 — 본 갱신으로 처리 완료.
- 권고 R4 (low): milestones.md sub_milestones[0].title 갱신 (D5 ARCHITECTURE.md 미변경 결정과 narrative 모순) → phase-1 title 과 일치하도록 갱신 완료 ('claude/commands/harness-meta.md Stage A step 7 신규 + Stage F 게이트 narrative 갱신').

### scope contract (Explore) — pass-with-comments

- INTENT.success_criteria 6건 ↔ DESIGN.phases 1건 매핑 완전 커버 + out_of_scope 5건 위배 0 + DESIGN.decisions ↔ INTENT.dependencies 정합 + scope creep 0.
- 권고 1 (D5 cascade 부담 최소화 정당성): root CLAUDE.md L19 함축 narrative ('컨테이너 마운트 + ROADMAP entry in_progress') 가 milestones.md 동시 생성을 함축적으로 포함 가능 narrative (D5 결정 narrative 강화).
- 권고 2 (R5 smoke 자동화 명시): phase-1 commit 직후 pre-commit 6 hook PASS 자동 검증 — VERIFY 단계 기록 의무.
- 권고 3 (D7 자기참조 trace): commit hash + timestamp REPORT.lessons_learned 명시 — REPORT 시점 처리.

### 의견 충돌 처리

3 관점 모두 pass-with-comments + verdict 충돌 0. AskUserQuestion invoke 불필요. 권고 흡수 = R4 즉시 (milestones.md title 갱신), R1 narrative 강화 (D4 안), R2/R3/R5/D7 trace = REPORT.lessons_learned (Stage H 시점).

# PLAN — v1.3_harness-engineering-definition

```json
{
  "id": "v1.3_harness-engineering-definition",
  "title": "하네스 엔지니어링 정의 명시 — 메타 레이어의 working definition + 5요소 매트릭스 박기",
  "goal": "harness-meta repo 가 표방하는 '하네스 엔지니어링' 의 working definition 을 단일 source 에 명시하고, 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace) 를 정전 (canon) 으로 확립한다. 이후 모든 milestone 발의가 본 정의에 대신해 평가 가능하도록 한다.",
  "motivation": "현재 ROADMAP 8건의 완료 milestone 중 다수가 임시방편적 — smoke 추가 / hook 패턴 / 메시지 갱신 / cleanup 등. 모두 의미 있는 작업이지만, '하네스 엔지니어링' 의 정의가 repo 어디에도 명시되지 않아 milestone 발의 시 '왜 이 작업이 하네스 작업인가' 가 매번 ad-hoc 으로 정당화됐다. 본 milestone 으로 정의 + 5요소 매트릭스를 박으면, 향후 발의 (예: 'install.ps1 제거', 'smoke 합리화') 가 어느 요소에 속하는지 / 정의에 부합하는지 즉시 평가 가능하다. 사용자 working definition (메모리 v1.75: SKILL 인프라 거부 + manual context injection) 도 명시 정전화하여 Claude 세션 간 일관성 확보.",
  "success_criteria": [
    "ARCHITECTURE.md 또는 CLAUDE.md (위치는 DESIGN 에서 확정) 에 '하네스 엔지니어링 = ...' working definition 1~2 문장이 grep 으로 검출됨",
    "동일 위치에 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace) 표가 존재하며, 각 요소별로 (a) 책임 (b) 현재 메커니즘 (c) 정전 vs 임시방편 분류 명시",
    "사용자 working definition (narrative + 파일 trace 우선, 인프라 자동화 최소화) 가 정의 본문 또는 부속 항목에 명문화됨 — 메모리 (v1.75 manual context injection) 로만 존재하던 원칙이 repo 트리에 박힘",
    "정의 위치가 단일 source (root CLAUDE.md / docs/ARCHITECTURE.md / projects/meta/ARCHITECTURE.md 중 1곳) 로 결정되고, 다른 문서는 cross-ref 만 (중복 정의 금지)",
    "ROADMAP 등재된 v1.3 milestone REPORT.md 의 next_candidates 에 '정의에서 도출되는 후속 milestone 후보 (#1 인프라 최소화 / #2 hook narrative 분리 / #3 5관점 trace)' 가 trigger 명시 후보로 등록됨"
  ],
  "out_of_scope": [
    "shell script 감량 (install.ps1 / verify.{ps1,sh} 제거) — 정의 도출 후 후속 milestone 으로 별도 발의",
    "hook narrative 분리 (post-report-write.sh inject 메시지 MD 분리) — 별도 후속",
    "Stage E 5관점 검토 raw trace 보존 — 별도 후속",
    "smoke 신규 추가 (정의 drift 검증 자동화) — 정의가 박힌 다음에야 검증 가능, 후속 milestone",
    "AGENTS.md / README.md 정의 반영 — 본 milestone 은 단일 source 박기까지, cross-ref 갱신은 단일 source 결정 후 sweep 작업 (DESIGN 에서 본 milestone 포함 여부 결정)"
  ],
  "dependencies": {
    "predecessors": [
      "v1.0_workflow-redesign (7-stage 인프라)",
      "v1.1_meta-as-project (projects/meta/ 분리 + ARCHITECTURE.md 신설)",
      "v1.2_post-report-write-message-rewrite (직전 완료, lessons '키워드 6건 연쇄' 가 본 milestone trigger 의 한 축)"
    ],
    "successors_anticipated": [
      "v1.4_infra-minimization (정의 #1 — install/verify 제거 + smoke 합리화)",
      "v1.4_hook-narrative-separation (정의 #2 — hook MD 분리)",
      "v1.4_design-review-trace (정의 #3 — 5관점 raw 보존)"
    ]
  }
}
```

## 의도 narrative

본 milestone 은 **메타 정전 (canon) 박기** — 산출물 자체가 향후 milestone 평가 잣대가 된다. 따라서 정의 본문은 다음을 만족해야 한다:

- **Stable** — 추후 milestone 으로 정의 자체를 매번 갱신할 일 최소화. 정의가 자주 바뀌면 정전 기능 상실.
- **Operational** — 추상적 선언이 아니라, 새 milestone 발의 시 "이게 어느 요소냐?" 답할 수 있는 5요소 분류 제공.
- **Single-sourced** — 정의는 한 곳에만, 다른 곳은 cross-ref. 메모리 `feedback_token_efficiency_priority` 의 "단일 source 정합" 원칙 직접 적용.
- **Aligned with user philosophy** — "narrative + 파일 trace 우선, 인프라 자동화 최소화" 가 정의 본문 또는 부속 항목으로 명문화되어, Claude 가 정의를 읽기만 해도 사용자 선호를 흡수 가능.

## 결정 미룸 (DESIGN 에서 확정)

- 정의 위치 (root CLAUDE.md / docs/ARCHITECTURE.md / projects/meta/ARCHITECTURE.md)
- 5요소 매트릭스 표 형태 (markdown table 컬럼 구성)
- cross-ref 갱신 범위 (본 milestone 포함 vs 후속 sweep)
- phase 분할 (정의 본문 작성 + cross-ref 갱신 분리 vs 단일 phase)

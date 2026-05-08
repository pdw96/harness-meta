# RESEARCH — v1.3_harness-engineering-definition

```json
{
  "id": "v1.3_harness-engineering-definition",
  "external": [
    {
      "source": "Anthropic 공식 자료 / Claude Code docs (간이 sanity check)",
      "topic": "'harness engineering' 명시 working definition",
      "findings": "공식 자료에 'agent harness' 용어가 일부 등장하나 working definition 형태로 정의된 1차 source 부재 — 주로 'agent loop / system / scaffolding' 의 일종으로 개념적 사용. 'harness-meta' 라는 본 repo 명명 자체가 사용자 (qkreh) 의 자체 명명 컨벤션. 즉 본 milestone 의 정의는 외부 spec 추수가 아니라 사용자·repo 자체 working definition 정전화.",
      "drift": "외부 spec 과의 drift 는 '명시적 정의 부재' 1건 — 본 정의는 사용자 working philosophy 가 1차 source 이며 외부 spec 의존 약함. DESIGN 단계 spec-drift agent 가 추가 검증 (5 관점 검토)."
    },
    {
      "source": "사용자 메모리 5건 (qkreh)",
      "topic": "사용자 working philosophy",
      "findings": "1) `feedback_iterative_pre_plan_review` — 매 round 결정적 이슈 trigger 의무. 2) `feedback_token_efficiency_priority` — 단일 source 정합 우선, 토큰 2x 차이는 의도 절충 정당. 3) `feedback_hard_reset_for_direction_change` — local-only commit 은 reset 수용, audit trail 은 PLAN/REPORT narrative. 4) `project_v1.75_manual_context_injection` — sub-agent prompt 에 모듈 CLAUDE.md 명시 inject, SKILL 인프라 거부. 5) `user_claude_code_interface` — 터미널 선호.",
      "drift": "메모리에만 존재, repo 트리 부재 — 본 milestone 으로 정전화 필요. 특히 `v1.75 manual context injection` 와 `토큰 효율 단일 source` 가 정의 본문의 핵심 속성 (narrative + 단일 source)."
    },
    {
      "source": "기존 milestone 8건 lessons_learned 종합",
      "topic": "정의 부재로 발생한 비용",
      "findings": "v1.2 'smoke 키워드 6건 연쇄 영향' / v1.1_smoke-precommit-rewrite '리터럴보다 grep 으로 패턴 확인' / v1.1_agents-md-cleanup 'Status 섹션 stale 1건 발견' — 모두 narrative 1차 source 와 인프라 (smoke, hook hard-code) 의 강결합 비용. 정의가 박혀 있었다면 '왜 narrative 우선 / 인프라 최소화' 에 대한 평가 잣대가 매번 ad-hoc 정당화될 필요 없었음.",
      "drift": "lessons_learned 모두 정의 1차 도출 가능 — 사후 정전화 시점."
    }
  ],
  "codebase": {
    "affected_files_candidate_hosts": [
      {
        "path": "CLAUDE.md (root)",
        "lines": 122,
        "role": "운영 가이드 primary, Claude 매 세션 자동 로드 (@ROADMAP.md 포함)",
        "pros": "자동 로드 → 정의 흡수 즉시 / Claude 작업 시 매번 참조 / 단일 source 가능성 높음",
        "cons": "본문 비대화 risk — 122줄 → 200줄+ 가능성 / 정의 + 운영 가이드 책임 혼재 / @import 미지원 (직접 본문)"
      },
      {
        "path": "projects/meta/ARCHITECTURE.md",
        "lines": 77,
        "role": "메타 repo 자체 아키텍처 스냅샷, lazy load (projects/meta/ 작업 시)",
        "pros": "ARCHITECTURE 라는 책임명에 정의가 자연 부합 / lazy load 라 root CLAUDE.md 비대화 회피 / 단일 source 보장 가능",
        "cons": "lazy load 라 root 진입 시 자동 흡수 안 됨 → root CLAUDE.md cross-ref 1줄 필요 / Claude 가 정의 내용을 매 세션 참조하려면 명시적 trigger 필요"
      },
      {
        "path": "docs/ARCHITECTURE.md",
        "lines": 52,
        "role": "글로벌 시스템 도식 (영문)",
        "pros": "ARCHITECTURE 책임 / 영문 표준 docs",
        "cons": "★ stale — sessions/, bootstrap/templates/, INTERVIEW.md, STACK.md 등 v1.0_workflow-redesign 이전 4-tier 포맷 잔존. 정의를 stale 문서에 박으면 정전성 약화 / 별개 cleanup 필요 (out-of-scope)"
      },
      {
        "path": "AGENTS.md",
        "lines": 84,
        "role": "영문 요약 (외부 AI 도구 + 오픈소스 방문자용)",
        "pros": "외부 가시성 높음 / 영문 요약",
        "cons": "★ Status 섹션 stale (v1.1_agents-md-cleanup in progress 표기, 실제 completed) / 영문 단일이라 한국어 운영 가이드 흐름과 분리 / repo 의 한국어 primary 정책과 맞물림 약함"
      },
      {
        "path": "README.md",
        "lines": 200,
        "role": "사용자 진입 (영문)",
        "pros": "L3 'Structured AI-assisted engineering workflow built on top of Claude Code' / L6 '7-stage workflow' 의 정의 비스무리 문장 이미 존재",
        "cons": "사용자 진입용 → 운영 정의의 정전 host 로는 무리 / 기존 문장 충분히 짧고 추상적 → 5요소 매트릭스 박기 어색"
      },
      {
        "path": "docs/HARNESS-ENGINEERING.md (신규)",
        "lines": 0,
        "role": "(가설) 정의 전용 신규 문서",
        "pros": "단일 책임 분리 / 다른 문서 비대화 회피 / 정전 문서로 명시",
        "cons": "신규 문서 추가 → repo 문서 수 증가 / 다른 4 host 와의 cross-ref 의무 / Claude 자동 로드 trigger 없음 (ARCHITECTURE.md 와 동일 약점)"
      }
    ],
    "untouched_files": [
      "claude/commands/harness-meta.md (slash command 정의 — 본 milestone 영향 없음, Stage E SKILL invoke 명시화는 #2 후속)",
      "claude/hooks/post-report-write.sh (#2 후속)",
      "tests/smoke-*.sh (#1 후속)",
      "install.ps1 / install-skills.{ps1,sh} / verify.{ps1,sh} (#1 후속)",
      "GUARDRAILS.md (★ 별개 cleanup — sessions/ 참조 잔존, 본 milestone out-of-scope)",
      "docs/adr/ (관련 ADR 추가 가능성은 DESIGN 결정)"
    ],
    "current_state": "1) 'harness engineering' 워킹 정의 텍스트 grep 결과 0건 (본 PLAN/RESEARCH 외). 2) 5요소 매트릭스 (Context/Workflow/Constraint/Verification/Trace) 표 부재. 3) 사용자 working philosophy (narrative + 파일 trace 우선, 인프라 자동화 최소) 가 메모리 (`v1.75`) 만 존재, repo 트리 부재. 4) 정전 host 후보 6개 중 3개 (docs/ARCHITECTURE.md / AGENTS.md / GUARDRAILS.md) stale 상태 — 정의 박기 부적합.",
    "target_state": "1) DESIGN 에서 결정된 단일 host 1곳에 working definition 1~2 문장 + 5요소 매트릭스 표 박힘. 2) 사용자 working philosophy 명문화 (narrative 우선 / 인프라 최소화 / 단일 source 정합). 3) 다른 문서 (root CLAUDE.md / AGENTS.md / projects/meta/ARCHITECTURE.md 중 비-host) 는 cross-ref 1~2줄 추가 (중복 정의 금지). 4) 후속 milestone (#1/#2/#3) 의 ROADMAP next_candidates 등록."
  },
  "options": [
    {
      "name": "Option A — root CLAUDE.md 본문 박기",
      "host": "CLAUDE.md (root)",
      "pros": ["Claude 매 세션 자동 흡수", "primary 진입 → cross-ref 의존 0", "단일 source 보장 강함"],
      "cons": ["본문 비대화 (122 → 180줄+ 추정)", "운영 가이드 / 정전 정의 책임 혼재", "정의 갱신 시 운영 가이드 변경과 commit 분리 어색"]
    },
    {
      "name": "Option B — projects/meta/ARCHITECTURE.md 본문 + root CLAUDE.md 1줄 cross-ref",
      "host": "projects/meta/ARCHITECTURE.md",
      "pros": ["ARCHITECTURE 책임명 부합", "lazy load 로 root 비대화 회피", "단일 source 보장 + cross-ref 명시", "메타 repo 자체 = '하네스 자체' 라는 의미와 정합"],
      "cons": ["lazy load → Claude 가 root 진입 시 자동 흡수 안 됨 (cross-ref 1줄로 강제 필요)", "외부 가시성 (AGENTS.md/README.md) 약함 → 영문 cross-ref 필요"]
    },
    {
      "name": "Option C — docs/HARNESS-ENGINEERING.md 신규 + 양쪽 cross-ref",
      "host": "신규 문서",
      "pros": ["단일 책임 분리", "정전 문서 명시", "ARCHITECTURE/CLAUDE.md 비대화 회피"],
      "cons": ["문서 수 증가", "Claude 자동 로드 trigger 부재 (ARCHITECTURE.md 와 동일 약점) + 추가로 신규 문서 인지 비용", "외부 cross-ref 의무 (AGENTS.md/README.md/CLAUDE.md/ARCHITECTURE.md 4곳)"]
    },
    {
      "name": "Option D — docs/ARCHITECTURE.md 정전화 + cleanup 동반",
      "host": "docs/ARCHITECTURE.md",
      "pros": ["ARCHITECTURE 책임명 부합 (글로벌 도식)", "stale cleanup 동시 처리 → 1石2鳥"],
      "cons": ["★ scope creep — 본 milestone 은 정의 박기, cleanup 은 별개 작업", "stale 문서 cleanup 자체가 sub-milestone 분량 (sessions/, bootstrap/templates/ 등 다수 stale 참조)", "PLAN out-of-scope 와 충돌"]
    }
  ],
  "risks_identified": [
    {
      "risk": "정의 본문이 자주 바뀜 → 정전 기능 상실",
      "trigger": "5요소 매트릭스가 너무 세부 (현재 메커니즘 명시) 라면 메커니즘 변경 시 정의도 매번 수정",
      "mitigation_hint": "5요소 매트릭스의 (b) '현재 메커니즘' 컬럼을 cross-ref 형태로만 (e.g., 'tests/smoke-*.sh 22종 — 상세 tests/CLAUDE.md') → 메커니즘 변경 시 cross-ref 만 부동, 본 정의 안정"
    },
    {
      "risk": "5요소 매트릭스가 추상적 → 운영성 상실 (PLAN operational 원칙 위반)",
      "trigger": "각 요소를 1줄 정의로만 명시하면 신규 milestone 발의 시 '이게 어느 요소냐' 답 모호",
      "mitigation_hint": "각 요소에 (a) 책임 (b) 현재 메커니즘 cross-ref (c) 정전 vs 임시방편 분류 — 3 컬럼 표. 신규 milestone 발의 시 (c) 컬럼이 평가 잣대"
    },
    {
      "risk": "정의 host 가 stale 문서 (docs/ARCHITECTURE.md / AGENTS.md / GUARDRAILS.md) → 정전성 약화",
      "trigger": "Option D 채택 시 cleanup 미동반",
      "mitigation_hint": "Option B (projects/meta/ARCHITECTURE.md) 우선 — 본 문서는 v1.1_meta-as-project 에서 신설된 fresh 문서. stale 위험 낮음"
    },
    {
      "risk": "다른 문서로 정의 누설 → drift",
      "trigger": "AGENTS.md / README.md / 사용자 메모리 / 향후 ADR 등에 정의 변형본 자연 발생",
      "mitigation_hint": "정의 본문에 '★ 단일 source: <host>' 명시 + 다른 host 는 cross-ref 만. 향후 smoke (별개 milestone) 에서 정의 keyword grep 으로 단일성 검증 가능"
    },
    {
      "risk": "영문 vs 한국어 정책 충돌",
      "trigger": "AGENTS.md/README.md = 영문 / CLAUDE.md = 한국어 / projects/meta/ARCHITECTURE.md = 한국어. 영문 host 선택 시 한국어 사용자 (qkreh) 의 working philosophy 표현 손실",
      "mitigation_hint": "한국어 host 우선 (projects/meta/ARCHITECTURE.md 또는 root CLAUDE.md) → 영문 cross-ref 1~2줄 (AGENTS.md/README.md) 만"
    },
    {
      "risk": "후속 milestone (#1/#2/#3) 미발의 → 정의가 정전화 됐지만 적용 0",
      "trigger": "REPORT.md next_candidates 등록 누락",
      "mitigation_hint": "PLAN.success_criteria 마지막 항목으로 next_candidates 등록 의무 명시 — 이미 PLAN 에 반영됨"
    }
  ]
}
```

## 결정 미룸 (DESIGN 에서 확정)

- 4개 Option 중 1개 채택 (Option B 가 RESEARCH 시점 정성 평가상 우세하나 5 관점 subagent 검토에서 재평가)
- 5요소 매트릭스 표 컬럼 구성 (3컬럼 vs 4컬럼)
- 사용자 working philosophy 명시 형태 (정의 본문 통합 vs 별도 항목)
- cross-ref 갱신 범위 (본 milestone vs 후속)
- ADR 추가 여부

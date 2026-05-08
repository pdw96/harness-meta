# PLAN — v1.4_cross-ref-propagation

```json
{
  "id": "v1.4_cross-ref-propagation",
  "title": "하네스 엔지니어링 정의 cross-ref 전파 + GUARDRAILS 전면 재작성 + docs/ARCHITECTURE.md 폐기",
  "goal": "v1.3 에서 정의 host (projects/meta/ARCHITECTURE.md § 3) 만 박고 root CLAUDE.md L8 1줄만 cross-ref 한 보수 결정의 직접 후속 — 나머지 host 4곳 (AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 에 정의 cross-ref 1줄 일괄 추가 + AGENTS Status 섹션 일반화 + GUARDRAILS 7-stage 정합 전면 재작성 + docs/ARCHITECTURE.md 폐기 (책임 중복) + repo-wide cross-ref cascade 정리. 정의 단일 source 정합 (§ 3.5) 강제 + 임시방편 host 정전화 + 외부 가시성 (영문) 확보.",
  "motivation": "v1.3_harness-engineering-definition DESIGN.decisions[4] 가 cross-ref 보수 (root CLAUDE.md 1곳만) 를 채택한 이유는 'AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md 는 영문·stale 이슈 동반 → 별개 cleanup milestone' 명시. 본 milestone 이 그 후속. v1.3 DESIGN.risk[4] mitigation 'AGENTS.md / README.md cross-ref 는 후속 milestone 에서 일괄 처리' 가 본 milestone 에서 실행됨.\n\n사전 'pre-PLAN' 의문 round 에서 사용자 결정 4건 도출: (1) scope = cross-ref 일괄 + AGENTS·projects/meta/CLAUDE·README stale 동반 정리, GUARDRAILS·docs/ARCHITECTURE 는 별도 처리, (2) docs/ARCHITECTURE.md 폐기 (projects/meta/ARCHITECTURE.md 와 책임 중복), (3) GUARDRAILS.md 전면 재작성 본 milestone scope 안 (사용자 모순 재확인 결과), (4) AGENTS Status 섹션 일반화 (ROADMAP 위임). 정의 § 3.6 평가 절차 적용 시 본 milestone 은 5요소 중 'Context' 정전 보강 — lazy load 또는 영문 host 진입 시 정의 host 인지 가능 + 'Trace' 부수 (git history 영속).",
  "success_criteria": [
    "AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md (4곳) 각각에 정의 host (projects/meta/ARCHITECTURE.md § 3) cross-ref 1줄이 grep 검출됨 — host 언어 매칭 (AGENTS·README 영문 / projects/meta/CLAUDE·GUARDRAILS 한국어). cross-ref 형식은 root CLAUDE.md L8 표본 (5요소 이름 + 운영 게이트 1줄, 정의 본문 복제 X)",
    "정의 본문 (working_definition 1~2문장) / 5요소 매트릭스 표 가 host 4곳에 복제되지 않음 (v1.3 DESIGN.risk[4] drift mitigation 강제). 'projects/meta/ARCHITECTURE.md' grep 으로 cross-ref 거명 만 검출, '하네스 엔지니어링은 agent 의 행동을' / 'Context.*Workflow.*Constraint.*Verification.*Trace' 표 형식 grep 0",
    "AGENTS.md Status 섹션이 'Milestone history: see projects/meta/ROADMAP.md' (또는 동등 1~2줄 일반화 표현) 으로 갱신 — v1.0~v1.3 milestone 명시 거명 0",
    "GUARDRAILS.md 전면 재작성 — sessions/ 거명 0 (milestones/v{X.Y}_{slug}/ 로 갱신), bootstrap/templates/_base / bootstrap/install-project-claude / bootstrap/manifest-schema / bootstrap/docs 거명 0 (현재 부재 디렉토리), 정의 cross-ref 1줄 추가, 7-stage workflow 정합 (PLAN/RESEARCH/DESIGN/EXECUTE/VERIFY/REPORT 거명), DESIGN.approval 게이트 명시",
    "docs/ARCHITECTURE.md 파일 부재 (git rm) + repo-wide 'docs/ARCHITECTURE' grep 검출 0 (projects/meta/ARCHITECTURE.md L5/L34/L46/L76/L102/L112 + root CLAUDE.md (확인) + AGENTS.md L78 (Key docs 섹션) + README.md (확인) 모두 cross-ref 제거)",
    "pre-commit smoke 22종 PASS, 회귀 0건. 특히 smoke-projects-scope-discipline (root ROADMAP thin index) / smoke-spec-verification (정의 본문 drift 검증) / smoke-cross-ref (broken link) PASS"
  ],
  "out_of_scope": [
    "정의 본문 (projects/meta/ARCHITECTURE.md § 3) 자체 갱신 — 본 milestone 은 cross-ref 전파만, 정의 자체 수정은 별개 milestone (정전 본체 부동 원칙, v1.3 DESIGN.risk[1] mitigation)",
    "5요소 매트릭스 (c) 분류 변경 — 'Verification 혼재' 정전화는 v1.4_infra-minimization 후속, 'Trace 정전' 은 v1.4_design-review-trace 후속",
    "CHANGELOG.md 신규 작성 또는 갱신 — Status 섹션 일반화로 ROADMAP 위임이지만 CHANGELOG 자체는 본 milestone scope 외 (현재 존재 여부 무관)",
    "신규 smoke 추가 (정의 cross-ref 검증 자동화) — 정의 § 3.1 명료화 단락 정신 (smoke 키워드 강제 = 임시방편) + v1.3 PLAN.out_of_scope[4] 정신 답습",
    "사용자 user-skill / hook / settings 변경 — 5요소 중 Context/Constraint 의 자동화 메커니즘 보강은 별개 milestone",
    "신규 영문 docs 추가 (예: ENGINEERING.md / DEFINITION.md) — 단일 source 원칙 위반",
    "v1.4_infra-minimization (Verification 정전화) / v1.4_hook-narrative-separation (hook MD 분리) / v1.4_design-review-trace (Trace 정전화) 의 산출물 — 각 별개 milestone"
  ],
  "dependencies": {
    "predecessors": [
      "v1.3_harness-engineering-definition (정의 host § 3 박힘 + DESIGN.decisions[4] 보수 결정 + DESIGN.risk[4] mitigation 후속 milestone 에서 일괄 처리 명시 — 본 milestone 이 그 후속)",
      "v1.1_meta-as-project (projects/meta/ARCHITECTURE.md 신설로 docs/ARCHITECTURE.md 와 책임 중복 발생 — 본 milestone 에서 폐기 결정)",
      "v1.1_readme-cleanup (README.md legacy 참조 정리 완료 — 본 milestone 의 cross-ref 추가가 stale 잔존 위에 박히지 않도록 보장)"
    ],
    "successors_anticipated": [
      "v1.4_infra-minimization (정의 § 3.3 'Verification 혼재' 임시방편 (smoke shell 인프라) 정전화 — install/verify 제거 + smoke 22종 합리화). v1.3 PLAN/REPORT.next_candidates 와 ROADMAP entry 일치.",
      "v1.4_hook-narrative-separation (정의 § 3.1 명료화 단락 자동화 #2 'hook hard-code' — post-report-write.sh inject 메시지 MD 분리). v1.3 PLAN/REPORT.next_candidates 와 ROADMAP entry 일치.",
      "v1.4_design-review-trace (정의 § 3.3 'Trace' 정전 + 메타 고유 차별화 — Stage E 5 관점 검토 raw 출력 보존). v1.3 PLAN/REPORT.next_candidates 와 ROADMAP entry 일치.",
      "(추가 발의 후보) v1.5_legacy-narrative-cleanup — 잔존 sessions/ stale 5곳 (claude/hooks/post-report-write.sh L2 / claude/CLAUDE.md L39 / projects/upbit/{ARCHITECTURE,ROADMAP}.md / CHANGELOG.md L3) 정리. RESEARCH untouched_files_explicit 의 v1.5+ 후속 묶음."
    ]
  },
  "five_element_mapping": {
    "primary_element": "Context",
    "rationale": "본 milestone 은 정의 § 3.3 매트릭스 'Context' (a) 책임 = 'agent 가 작업 시 흡수하는 정보 source 의 결속'. 현재 (c) 분류 = '정전 (manual injection 컨벤션 채택). SKILL 자동 invoke 부분만 임시방편'. 본 milestone 은 정전 부분 (manual injection) 의 약점 보강 — root CLAUDE.md L8 외 host 4곳 (AGENTS·README·projects/meta/CLAUDE·GUARDRAILS) 에 cross-ref 추가하면 lazy load 또는 영문 host 진입 시에도 정의 host 인지 가능. 즉 Context 결속 메커니즘의 정전 부분 강화.",
    "secondary_element": "Trace",
    "secondary_rationale": "GUARDRAILS 전면 재작성 + docs/ARCHITECTURE.md 폐기 = git history 영속 — 'Trace' 메커니즘 (영구 파일 trace) 자체에 의사결정 기록. 단, 본 milestone 은 Trace 자체 메커니즘 변경 없음, 부수 효과만."
  },
  "deferred_to_design": [
    "phase 분할 수 (3 phase 잠정: cross-ref 일괄 / GUARDRAILS 전면 재작성 / docs/ARCH 폐기 cascade — DESIGN 5 관점 검토에서 확정)",
    "cross-ref 1줄 형식 (영문 / 한국어, host 별 위치 — Key docs 섹션 항목 갱신 vs 별도 헤더 1줄)",
    "GUARDRAILS 재작성 scope 세부 (C2~C6 위험 작업 매트릭스 항목 별 keep/remove/rewrite, 신규 7-stage 항목 추가 여부)",
    "docs/ARCHITECTURE.md cascade 정리 대상 파일 정확한 list (RESEARCH 단계 grep 으로 도출)",
    "AGENTS Status 섹션 일반화 정확한 문구 (영문, 'Milestone history: see ...' 표본 또는 다른 표현)"
  ]
}
```

## 의도 narrative

본 milestone 은 v1.3 의 보수 결정 (cross-ref 1곳만) 의 직접 후속이며, 사용자 working philosophy (narrative + 파일 trace 우선, 단일 source 정합) 의 운영 적용 — 정의가 1곳에 박혔으니 다른 host 들이 cross-ref 만 거명하고 본문은 복제하지 않는 정전 정합 강제.

세 가지 동시 작업이 묶이는 이유:

- **cross-ref 일괄** (host 4곳) — v1.3 DESIGN.risk[4] 의 mitigation 후속, drift 회피
- **GUARDRAILS 전면 재작성** — sessions/ 시대 잔존 + bootstrap 잔존 stale 이 cross-ref 1줄 추가만으로는 정전 host 자격 미달 → cross-ref 추가 동시에 host 자체 정전화
- **docs/ARCHITECTURE.md 폐기** — projects/meta/ARCHITECTURE.md (정의 host) 와 책임 중복 + 4-tier 시대 잔존 stale → 정의 § 3.5 단일 source 정합 강제 + 본 milestone 의 cross-ref 대상 host 가 폐기 대상이면 cross-ref 추가 자체가 모순

위 셋이 한 milestone 에 묶이는 핵심 정합 = 사용자 결정 (의문 round 2) + 정의 § 3.5 단일 source 원칙.

## 사전 의문 round 산출 narrative

PLAN 진입 전 의문 round (memory `feedback_iterative_pre_plan_review` 의무) 에서 결정적 이슈 4건 도출:

1. **scope** — ROADMAP entry "5곳 cross-ref + 동반 stale 정리" 가 stale 비중 격차 (host 별 1줄~92줄 전면 재작성 분량) 로 일괄 처리 어려움 → 사용자 결정으로 cross-ref + AGENTS·projects/meta/CLAUDE·README stale 동반 정리, docs/ARCHITECTURE·GUARDRAILS 는 별도 처리 트랙
2. **docs/ARCHITECTURE.md** — projects/meta/ARCHITECTURE.md (정의 host) 와 책임 중복 + 4-tier 잔존 → 사용자 결정으로 폐기, cascade cleanup
3. **GUARDRAILS.md** — sessions/ + bootstrap 잔존 다수 → 사용자 결정으로 전면 재작성. 의문 1 답변 ('docs/ARCH·GUARDRAILS 별개') 과 모순 검출 → 의문 round 2 재확인 결과 GUARDRAILS 는 본 milestone scope 안 (의문 1 의 '별개' 는 docs/ARCH 만 의도)
4. **AGENTS Status 섹션** — 매 milestone 갱신 운영비 + 단일 source 원칙 → 사용자 결정으로 'Milestone history: see projects/meta/ROADMAP.md' 일반화

위 4건이 본 PLAN 의 success_criteria 와 out_of_scope 의 결정 근거.

## 결정 미룸 (DESIGN 에서 확정)

`deferred_to_design` 키 5항. 특히 phase 분할 (3 phase 잠정) + cross-ref 1줄 형식 (영문/한국어) 은 5 관점 subagent 검토 (architecture / spec-drift / scope contract + scope ≤6~10 파일 = 4 관점 회귀 risk 추가) 거쳐 확정.

## 5요소 매핑 (정의 § 3.6 평가 절차 의무)

`five_element_mapping` 키 — primary = **Context** 정전 보강 (manual injection 컨벤션 의 약점 — host 4곳 cross-ref 부재 — 보강), secondary = **Trace** 부수.

# REPORT — v1.3_harness-engineering-definition

```json
{
  "id": "v1.3_harness-engineering-definition",
  "summary": "harness-meta repo 가 표방하는 '하네스 엔지니어링' 의 working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace) 를 projects/meta/ARCHITECTURE.md § 3 단일 source 에 박았다. 1~2 문장 working definition + '인프라 자동화 의존 최소화' 명료화 단락 + working philosophy (narrative + 파일 trace 우선) + 4컬럼 5 row 매트릭스 + 외부 컨벤션 관계 + 단일 source 정합 + 신규 milestone 평가 절차 6개 하위 섹션. cross-ref 는 보수 결정 — root CLAUDE.md L8 1줄만 추가, 기타 (AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md) cross-ref 는 영문·stale 동반 → 후속 v1.4_cross-ref-propagation 분리.\n\n3 관점 병렬 검토 (architecture / spec-drift / scope contract) 가 핵심 결정 (Option B / 2-phase / 4컬럼) 합의를 산출했고 사용자 결정 2건 (4컬럼 vs 5컬럼 / 보수 vs 통합 cross-ref) 으로 산출 폭이 결정됐다. 사용자의 '인프라 자동화 의존 최소화 의미가 뭐야' 질문이 명료화 단락 추가를 trigger — 정의 본문의 추상성 보강이 본 milestone 의 운영적 가치를 결정. 2 phase commit (b7a7007 / 981de66), Stage G commit (정전화 산출물 + ROADMAP 갱신) 별도. pre-commit smoke 8건 모두 PASS, 회귀 0건. SC 5건 모두 PASS — #5 (next_candidates 등록) 는 DESIGN 재해석 (Stage G REPORT 책임) 으로 분류 정정 후 본 산출에서 4건 등록.\n\n본 milestone 이 박은 정의는 단순 선언이 아니라 운영 잣대 — 매트릭스 (c) 분류에서 'Verification' 이 '혼재 (smoke shell 인프라 = 임시방편)' 로 자체 분류되며 후속 v1.4_infra-minimization 의 trigger 를 직접 도출했고, DESIGN.decisions[4] 보수 cross-ref 결정이 v1.4_cross-ref-propagation 후속을 직접 도출했다. 즉 정의 박기 자체가 후속 milestone 4건의 발의 근거 — 정전 (canon) 기능이 즉시 작동하기 시작했다.",
  "delta": {
    "files_changed": 2,
    "files_added": 7,
    "files_deleted": 0,
    "modules_affected": [
      "CLAUDE.md (root) — cross-ref 1줄 추가 (L8)",
      "projects/meta/ARCHITECTURE.md — § 3 신규 (정의 + 매트릭스 + philosophy + 외부 관계 + 단일 source + 평가 절차) + 기존 § 3~6 → § 4~7 시프트 + § 6 단일 source 주의 1줄 추가",
      "projects/meta/ROADMAP.md — v1.3 milestone in_progress 등재 (phase-1 commit) → completed 갱신 + next_candidates 4건 pending 등재 (Stage G commit)",
      "projects/meta/milestones/v1.3_harness-engineering-definition/ — 신규 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT.md + execute/phase-{1,2}.md)"
    ]
  },
  "lessons_learned": [
    "정의 본문 1~2 문장만으로는 정전 기능이 약하다 — 사용자 '인프라 자동화 의존 최소화 의미가 뭐야' 질문이 직접 노출시킴. 명료화 단락 (§ 3.1 후반) 으로 SKILL 자동 invoke / hook hard-code / smoke 키워드 강제 / settings.json permission gate 4가지 자동화 메커니즘을 거명 + '거부가 아니라 보조-vs-1차source 구분' 명시. 정의 박기 시 추상 문장 + 명료화 단락 + 매트릭스 (c) 분류 3중 보강이 운영성 확보 패턴.",
    "5요소 매트릭스 (c) '정전 vs 임시방편' 분류가 즉시 후속 milestone 의 trigger 가 됐다 — 'Verification' = '혼재 (smoke shell 인프라 임시방편)' 자체 분류가 v1.4_infra-minimization 후속 trigger 를 직접 도출. 정전 (canon) 박기는 박는 즉시 후속 발의 평가 잣대로 작동하는 self-reinforcing 메커니즘.",
    "DESIGN 의 5 관점 검토에서 spec-drift agent (5컬럼 권장) 와 architecture / scope contract agent (4컬럼 권장) 가 충돌 — 사용자 결정으로 4컬럼 + 본문 단락 분리 채택. 표 폭 절약 + 외부 컨벤션 관계의 narrative 보존 양립. 향후 비슷한 'compactness vs operationality' trade-off 는 사용자 결정 자동 invoke 패턴.",
    "PLAN.success_criteria #5 (next_candidates 등록) 가 Stage G 책임 — PLAN 단계 분류 오류였으나 DESIGN.decisions[6] 재해석으로 PLAN 본문 수정 없이 처리 (narrative trace 보존). 향후 PLAN 작성 시 'success_criteria 가 EXECUTE 단계 산출로 관측 가능한가' 검증 패턴 필요 — Stage G REPORT 단계 책임 사항은 PLAN.dependencies.successors_anticipated 또는 DESIGN.decisions 로 분리.",
    "사용자 글로벌 instruction '커밋·배포 전 확인 요청' + 본 repo CLAUDE.md '~/harness-meta repo 변경은 커밋 전 사용자 확인 필수' 가 phase 마다 commit 시안 narrative 제시 + 단답 OK 수령 패턴으로 작동 — 본 milestone 2 phase 모두 동일 패턴, 절차 안정.",
    "phase-1 commit 후 phase-1.md status: in_progress → complete 갱신이 unstaged 로 남아 phase-2 commit 시 stash/restore 발생. Stage G commit 에 묶이는 자연스러운 흐름이지만 향후 패턴 정착 후보: phase 마다 commit 직전 status 갱신 → 단일 commit. 본 milestone 에서는 별 문제 없었으나 일관성 차원에서 Stage F 절차 보강 가능 (별개 후속)."
  ],
  "next_candidates": [
    {
      "id": "v1.4_infra-minimization",
      "title": "인프라 최소화 — install/verify 제거 + smoke 합리화 (5요소 (c) 'Verification 혼재' 정전화)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "정의 § 3.3 매트릭스에서 'Verification' 만 '혼재' 분류 — VERIFY.md narrative 정전 + smoke shell 인프라 임시방편. 'Context' 의 SKILL 자동 invoke 부분도 임시방편 분류. install.ps1 / verify.{ps1,sh} / smoke 22종 감사 + narrative 대체 가능한 것 식별·제거. PLAN.dependencies.successors_anticipated #1 직접 매핑."
    },
    {
      "id": "v1.4_hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "정의 명료화 단락 (§ 3.1) 거명 자동화 #2 'hook hard-code'. post-report-write.sh 의 inject 메시지를 shell 안에 박지 않고 MD 파일에 분리, hook 은 단순 reader. PLAN.dependencies.successors_anticipated #2 직접 매핑."
    },
    {
      "id": "v1.4_design-review-trace",
      "title": "Stage E 5 관점 검토 raw 출력 보존 (milestones/.../design-review/)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "정의 § 3.3 매트릭스 'Trace' = 정전 + 메타 고유 차별화. 그러나 현재 Stage E subagent 5 관점 검토 결과는 DESIGN.md 본문으로 통합 후 raw 출력 소실 → trace 누락 지점. milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 로 보존. PLAN.dependencies.successors_anticipated #3 직접 매핑."
    },
    {
      "id": "v1.4_cross-ref-propagation",
      "title": "정의 cross-ref 전파 (AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "DESIGN.decisions[4] 보수 cross-ref 결정의 직접 후속. 본 milestone 은 root CLAUDE.md 1곳만 — 나머지 5곳 (AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md) 는 영문·stale 동반 issue 정리 후 cross-ref 일괄 추가 (특히 docs/ARCHITECTURE.md 4-tier stale + AGENTS.md Status 섹션 stale + GUARDRAILS.md sessions/ stale 동시 처리)."
    }
  ]
}
```

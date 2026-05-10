# REPORT — v1.4_infra-minimization

3 phase 종합. 정의 § 3.3 매트릭스 'Verification' 행 정전화 + drift 2건 제거 + tests/CLAUDE.md narrative 강화. 회귀 0.

```json
{
  "id": "v1.4_infra-minimization",
  "summary": "본 milestone 은 v1.3_harness-engineering-definition 가 박은 § 3.3 매트릭스 'Verification' 행 (c) = '혼재' 분류를 '정전' 으로 갱신하고, drift 2건 (4-tier era 잔존 smoke-l5-readme-link-cleanup.sh / smoke-v1.1.sh) 단순 제거 + tests/CLAUDE.md 매트릭스 narrative 강화 (active 5 vs inactive 22 회귀 차단 책임 명시 + smoke-projects-scope-discipline drift 1건 정정) 로 narrative 우위 명문화를 완료했다. RESEARCH 핵심 발견 = 'narrative 우위 가 이미 cross-ref 패턴 8 host 에 내재, 매트릭스 (c) 표기만 lag' — 즉 정전화 = drift 정리 + 표기 갱신 + matrix narrative 보강 만으로 자연 도출. 사용자 PLAN 분기 + RESEARCH 의향 모두 Option A (보수적 슬림화) 선택, 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 5 권고 반영. § 3.5 cascade grep host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 4 pattern 모두 본문 중복 부재 직접 검증 → 단일 source 정합 보장. 3 phase commit 모두 pre-commit 5 hook 통과, 회귀 0.",
  "delta": {
    "files_added": [
      "projects/meta/milestones/v1.4_infra-minimization/PLAN.md",
      "projects/meta/milestones/v1.4_infra-minimization/RESEARCH.md",
      "projects/meta/milestones/v1.4_infra-minimization/DESIGN.md",
      "projects/meta/milestones/v1.4_infra-minimization/execute/phase-1.md",
      "projects/meta/milestones/v1.4_infra-minimization/execute/phase-2.md",
      "projects/meta/milestones/v1.4_infra-minimization/execute/phase-3.md",
      "projects/meta/milestones/v1.4_infra-minimization/VERIFY.md",
      "projects/meta/milestones/v1.4_infra-minimization/REPORT.md"
    ],
    "files_modified": [
      "projects/meta/ROADMAP.md (v1.4_infra-minimization status pending → in_progress → completed + summary 갱신, updated 2026-05-10)",
      "projects/meta/ARCHITECTURE.md (§ 3.3 매트릭스 'Verification' 행 (b) 카운트 22→27 + (c) 혼재→정전 표기 갱신)",
      "tests/CLAUDE.md (L7 count 29→27 + 매트릭스 헤더 직후 narrative 1차 source standalone block + 핵심 정책 검증 표 smoke-projects-scope-discipline row 추가 + 현행 hook 현황 § 직후 inactive 22 회귀 차단 책임 paragraph)"
    ],
    "files_deleted": [
      "tests/smoke-l5-readme-link-cleanup.sh (4-tier era 'v1.10h2' 1회성 cleanup smoke, 매트릭스 미거명, drift)",
      "tests/smoke-v1.1.sh (4-tier era schema v1.1 fixture smoke, 매트릭스 미거명, drift)"
    ],
    "modules_affected": [
      "tests/ (drift 2건 제거 + 매트릭스 narrative 강화 — narrative 1차 source 위치 명시)",
      "projects/meta/ (ARCHITECTURE.md § 3.3 'Verification' 정전화 + ROADMAP 갱신)",
      "projects/meta/milestones/v1.4_infra-minimization/ (milestone 전체 산출물 신규 — PLAN/RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-1.md/phase-2.md/phase-3.md)"
    ],
    "commits": [
      {
        "hash": "3f918d3",
        "phase": 1,
        "title": "drift smoke 2건 제거 (smoke-l5 / smoke-v1.1) + tests/CLAUDE.md count 동기",
        "stat": "8 files / 563 insertions / 56 deletions"
      },
      {
        "hash": "bd398a1",
        "phase": 2,
        "title": "tests/CLAUDE.md 매트릭스 narrative 강화 (active vs inactive 회귀 차단 책임 + smoke-projects-scope-discipline drift 정정)",
        "stat": "3 files / 58 insertions / 3 deletions"
      },
      {
        "hash": "7ba503f",
        "phase": 3,
        "title": "ARCHITECTURE § 3.3 매트릭스 'Verification' 정전화 + § 3.5 cascade grep host 5곳 검증",
        "stat": "2 files / 66 insertions / 1 deletion"
      }
    ]
  },
  "lessons_learned": [
    "narrative 우위 가 cross-ref 패턴 8 host 에 이미 내재되어 있는 경우, 매트릭스 (c) 표기만 lag — 정전화 = drift 정리 + 표기 갱신 + matrix narrative 보강 만으로 자연 도출. v1.3 발의 시 '정전화는 큰 리팩터' 가정과 실제 단순 변경 (3 phase, 11 distinct files) 의 차이 = '발의 시점의 비용 추정' 보다 'RESEARCH 후 cross-ref 패턴 cascade 발견' 이 실제 비용 결정 인자.",
    "drift 인프라 식별 트리플 = (a) 매트릭스 narrative 거명 부재 + (b) pre-commit 미연결 + (c) era 출처 불명 (4-tier era v1.10h2 / schema v1.1) — 세 조건 동시 만족 시 단순 제거 정당. narrative 책임 부재 자체가 narrative 대체 정당성의 근거 (DESIGN D9 b/c 매핑). drift_evidence_4tier_vs_7stage trace 영속 보존 = Trace 5요소 정전.",
    "§ 3.5 cascade grep host 5곳 본문 중복 부재 사전 검증 = 단일 source 정합 직접 작동 입증. 4 grep pattern (5요소 매트릭스 표 형식 / 구 (c) 본문 / 신규 (c) 본문 / 정의 § 3.1 본문) 모두 host 5곳 미매치 — v1.4_cross-ref-propagation 결과의 연속 입증. 향후 정의 갱신 milestone 시 동일 pattern 재활용 가능 (v1.5_research-cascade-grep-discipline 권고 흡수).",
    "표기 일관성 발견 사례 — (c) 셀 '**정전**' bold vs '정전' 평문 — 다른 row (Context/Workflow/Constraint/Trace) 모두 평문 사용. 초기 architecture 검토 권고 #4 ('markdown link 표기 + (b) 컬럼 cross-ref 패턴 일관성') 와 cascade grep 패턴 매치 영향이 결합되어 평문 채택. 사소한 일관성 발견이 cascade 검증 시 중요 trigger 로 작동 — DESIGN 단계 검토 시 inline 표기 일관성도 검토 항목으로 흡수 가치.",
    "single 책임 phase 분할 + count cascade 분리 균형 — Phase 1 의 tests/CLAUDE.md L7 count inline 갱신 (drift 2건 cascade) 이 architecture 검토 시 'phase-1.md scope 명시 권고' 받음 → DESIGN Phase 1 affected_files comment ('drift 제거의 기계적 cascade, narrative 강화 아님') + phase-1.md scope 명시. 단일 책임 원칙 vs cascade 의존 mitigation 의 균형 — 모든 cascade 가 별도 phase 일 필요 없음 (cascade 가 단일 책임의 자연 결과인 경우 inline 처리 + 명시 trace)."
  ],
  "next_candidates": [
    {
      "id": "v1.4_hook-narrative-separation",
      "trigger": "본 milestone 의 'narrative 우위' 정신 직접 적용 후속 — Context 행 'hook hard-code 메시지' 임시방편을 narrative 분리 (post-report-write.sh 메시지 → MD 파일 분리)",
      "trigger_type": "D_design",
      "status": "기존 ROADMAP pending"
    },
    {
      "id": "v1.4_design-review-trace",
      "trigger": "Trace 5요소 보강 — Stage E 5 관점 subagent 검토 raw 출력을 milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 로 보존. 본 milestone 4 관점 검토 결과 DESIGN.md 통합 후 raw 소실 사례 = 직접 motivation",
      "trigger_type": "D_design",
      "status": "기존 ROADMAP pending"
    },
    {
      "id": "v1.5_legacy-narrative-cleanup",
      "trigger": "잔존 sessions/ stale narrative + 4-tier 거명 일괄 정리 (claude/hooks/post-report-write.sh L2 / claude/CLAUDE.md L39 / projects/upbit/* / CHANGELOG.md L3)",
      "trigger_type": "C_improvement",
      "status": "기존 ROADMAP pending"
    },
    {
      "id": "v1.5_research-cascade-grep-discipline",
      "trigger": "본 milestone § 3.5 cascade grep 4 pattern 직접 작동 사례를 RESEARCH 표준 절차로 흡수 — claude/commands/harness-meta.md 또는 RESEARCH 템플릿 보강",
      "trigger_type": "B_regression",
      "status": "기존 ROADMAP pending"
    }
  ]
}
```

## 종합

3 phase + 4 관점 검토 + cascade grep 5 host 직접 검증 + pre-commit 5 hook 모든 phase 통과. 회귀 0. v1.3 가 박은 정의 매트릭스 'Verification' 임시방편 → 정전 narrative 우위 명문화의 직접 후속. 본 milestone 결과로 정의 § 3.3 매트릭스 5 row 모두 (c) 분류 = '정전' (Context = 정전 + manual injection / Workflow = 정전 + v1.0 / Constraint = 정전 + DESIGN.approval / Verification = 정전 + narrative 우위 / Trace = 정전 + 메타 고유 차별화) 통일 — '인프라 자동화 의존 최소화' 정신의 5요소 모두 정전화 도달.

다만 Context 행은 (c) 분류 본문에 'SKILL 자동 invoke 부분만 임시방편' 단서 잔존 — 후속 milestone (v1.4_hook-narrative-separation 의 인접 영역) 또는 신규 발의에서 다룰 가능성. 본 milestone scope 외 (PLAN.out_of_scope 명시).

## 관련 문서

- PLAN: [`PLAN.md`](PLAN.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- EXECUTE: [`execute/phase-1.md`](execute/phase-1.md) / [`execute/phase-2.md`](execute/phase-2.md) / [`execute/phase-3.md`](execute/phase-3.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- 정의 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3
- 직전 완료 milestone: [`../v1.4_cross-ref-propagation/`](../v1.4_cross-ref-propagation/)
- 직전 직전 (정의 source): [`../v1.3_harness-engineering-definition/`](../v1.3_harness-engineering-definition/)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)

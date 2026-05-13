# REPORT — v2.0_workflow-word-fidelity

```json
{
  "milestone_id": "v2.0_workflow-word-fidelity",
  "report_date": "2026-05-10",
  "summary": "현 7-stage workflow (ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT) 의 4건 단어 미스매치 (MILESTONE 단어-책임 부정합 / PLAN 'intent only' narrowing / DESIGN 3 책임 혼재 / REPORT backward+forward 혼재) 를 새 9-stage workflow (ROADMAP→OPEN→INTENT→RESEARCH→DESIGN→APPROVE→EXECUTE→VERIFY→REPORT→PROPOSE) 로 전면 정정. 단어 = 단일 책임 1:1 매핑 원칙 관철. ROADMAP 은 입력 source 로 stage 카운트 제외 (OPEN~PROPOSE = 9 stage). 5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) — 회귀 risk 1 fail + 4 pass-with-comments → DESIGN 정정 8건 반영 후 5 관점 모두 pass 재평가. 사용자 의문 round 3회 (총 13 question 명시 결정).\n\n6 phase + 1 hotfix = 7 commit. ARCHITECTURE.md § 3.3 5요소 매트릭스 'Workflow' 행 9-stage 갱신 + 'Constraint' 행 APPROVE.md.approved_by gate + 'Trace' 행 산출 7종 enumerate + § 4 9-stage 섹션 + § 6 era 정책 (4-tier / 7-stage / 9-stage 3 era) 명문화. claude/commands/harness-meta.md 9-stage 절차 전면 재작성 (Stage A=OPEN ~ Stage I=PROPOSE). 단일 source 5곳 + 모듈 가이드 3곳 cascade 갱신. smoke (smoke-spec-verification / smoke-scope-contract) 에 era 자동 식별 메커니즘 추가 — 산출 파일명 자체로 era 분기 schema 검증. claude/hooks/post-report-write.sh 에 INTENT/APPROVE/PROPOSE 패턴 + write 시점 분기 inject 메시지 (REPORT → PROPOSE / APPROVE → EXECUTE 게이트 / PROPOSE → ROADMAP 등록).\n\nHistorical 7-stage era 11개 milestone 의 PLAN.md → INTENT.md `git mv` 마이그레이션 (history 96~100% 보존) + 본문 cross-ref sed 일괄. 4-tier era (v1.84~v1.88) 는 era 보존 정책 적용 (rename 제외). 본 v2.0 milestone 자체는 7-stage 포맷 자기참조 회피 표지 (D12) — v2.1+ 부터 9-stage 의무. CHANGELOG v2.0 entry + projects/upbit/ROADMAP 9-stage 거명 + 사용자 메모리 갱신 (project_v2.0_workflow_9stage.md, ~/.claude 외부 path).",
  "delta": {
    "files_changed": 50,
    "files_added": [
      "projects/meta/milestones/v2.0_workflow-word-fidelity/PLAN.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/RESEARCH.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/DESIGN.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/VERIFY.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/REPORT.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-1.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-2.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-3.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-4.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-5.md",
      "projects/meta/milestones/v2.0_workflow-word-fidelity/execute/phase-6.md",
      "(사용자 메모리 — git 외부) ~/.claude/projects/.../memory/project_v2.0_workflow_9stage.md"
    ],
    "files_modified": [
      "CLAUDE.md", "AGENTS.md", "README.md", "GUARDRAILS.md", "CHANGELOG.md",
      "projects/meta/ARCHITECTURE.md", "projects/meta/CLAUDE.md", "projects/meta/ROADMAP.md",
      "projects/upbit/ROADMAP.md",
      "claude/CLAUDE.md", "claude/commands/harness-meta.md", "claude/hooks/post-report-write.sh",
      "tests/CLAUDE.md", "tests/smoke-spec-verification.sh", "tests/smoke-scope-contract.sh",
      "bootstrap/skills/CLAUDE.md",
      "projects/meta/milestones/v1.0_workflow-redesign/{DESIGN,VERIFY,execute/phase-1,execute/phase-5}.md",
      "projects/meta/milestones/v1.1_meta-as-project/{DESIGN,RESEARCH}.md",
      "projects/meta/milestones/v1.1_post-report-write-hook-update/{REPORT,RESEARCH,VERIFY}.md (+ INTENT modify)",
      "projects/meta/milestones/v1.1_readme-cleanup/REPORT.md",
      "projects/meta/milestones/v1.1_smoke-precommit-rewrite/RESEARCH.md",
      "projects/meta/milestones/v1.2_post-report-write-message-rewrite/{REPORT,RESEARCH,VERIFY}.md (+ INTENT modify)",
      "projects/meta/milestones/v1.3_harness-engineering-definition/DESIGN.md",
      "projects/meta/milestones/v1.4_cross-ref-propagation/{DESIGN,RESEARCH,VERIFY,execute/phase-3}.md",
      "projects/meta/milestones/v1.4_infra-minimization/DESIGN.md",
      "(사용자 메모리) ~/.claude/projects/.../memory/MEMORY.md (index entry 추가)"
    ],
    "files_renamed": [
      "projects/meta/milestones/v1.0_workflow-redesign/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.1_agents-md-cleanup/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.1_design-phases-execute-tracking-automation/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.1_meta-as-project/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.1_post-report-write-hook-update/PLAN.md → INTENT.md (96%)",
      "projects/meta/milestones/v1.1_readme-cleanup/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.1_smoke-precommit-rewrite/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.2_post-report-write-message-rewrite/PLAN.md → INTENT.md (93%)",
      "projects/meta/milestones/v1.3_harness-engineering-definition/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.4_cross-ref-propagation/PLAN.md → INTENT.md (100%)",
      "projects/meta/milestones/v1.4_infra-minimization/PLAN.md → INTENT.md (100%)"
    ],
    "files_deleted": [],
    "modules_affected": [
      "projects/meta (정의 single source + 11 historical milestone migrate)",
      "claude (commands 재작성 + hooks era 분기 + 모듈 가이드)",
      "tests (smoke era 자동 식별 + 모듈 가이드)",
      "bootstrap/skills (모듈 가이드)",
      "projects/upbit (cascade minor)",
      "(root) CLAUDE / AGENTS / README / GUARDRAILS / CHANGELOG (host cascade)",
      "(사용자 메모리, git 외부) ~/.claude/projects/.../memory"
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "fix forward 정책 가치 검증 — phase-4 commit 후 smoke-scope-contract 실행 시 historical 11 milestone 이 detect_era 의 'skip' 분류로 검증 누락 발견. 즉시 hotfix commit (phase-4 후속) 으로 detect_era 에 'INTENT.md 단독 존재 = 7-stage era' 케이스 추가. 사전 5 관점 검토 + DESIGN 정정 8건 반영했음에도 실제 phase-5 git mv 후의 detect_era 알고리즘 edge case 는 commit 후에만 식별 — 사전 review 의 한계 + post-commit smoke 검증의 가치",
      "category": "process"
    },
    {
      "id": "L2",
      "lesson": "era 자동 식별 메커니즘 (산출 파일명 자체를 표지로) — narrative 1차 + smoke 보조 (ARCHITECTURE.md § 3.1 정합) 정확. 그러나 3 era (4-tier / 7-stage / 9-stage) 분류 시 transition 상태 (historical migrate 후 INTENT.md 단독 존재) 는 단순 binary 분류로는 누락. 알고리즘은 'present + absent' 조합으로 era 판정 — edge case 보수적 추가 권고",
      "category": "design"
    },
    {
      "id": "L3",
      "lesson": "본 milestone 자체 7-stage 포맷 자기참조 표지 (D12) — chicken-and-egg 회피 정책 효과적. ARCHITECTURE.md § 6 era 정책에 명시 + smoke 가 자동 식별하므로 era 표지 검증 자동화. 후속 milestone (v2.1+) 부터 9-stage 의무 — 본 milestone 이 era transition 단일 commit 묶음",
      "category": "design"
    },
    {
      "id": "L4",
      "lesson": "의문 round 3회 (총 13 question 명시 결정) 의 비용 vs 효과 — 사전 검토로 EXECUTE 단계 결정 분기점 최소화. phase 진행 중 추가 결정 부재 (smoke hotfix 1건만 — 알고리즘 edge case). 토큰 비용 vs 정확성 균형 정합. 5 관점 병렬 검토 (subagent 5개 동시) 도 ~150K 토큰 비용이지만 fail verdict 1건 (회귀 risk) 즉시 식별 → DESIGN 정정 8건 반영 후 회귀 0",
      "category": "process"
    },
    {
      "id": "L5",
      "lesson": "Architecture agent 검토 의 critical_issue 'historical 카운트 14' 지적은 agent 자체 오류 (실제 11 정합) — agent 검토 결과도 cross-check 의무. 본 milestone 의 정정으로 ROADMAP entry summary '14 milestone' → '11 milestone' 정정. subagent 검토는 의견 1차 source, 사용자/Claude main agent 검증 2차 layer 가 필수",
      "category": "process"
    },
    {
      "id": "L6",
      "lesson": "cross-ref drift 방지 — phase-5 의 sed 일괄 후 grep 'PLAN.md' 잔존 검증으로 의도된 잔존 (자기참조 표지 / era 보존 narrative) vs 누락 식별 가능. 11 historical migrate 정확. 향후 era migration 시 동일 패턴 재사용 권고",
      "category": "process"
    },
    {
      "id": "L7",
      "lesson": "외부 컨벤션 정합도 — spec-drift agent 검토에서 9-stage 가 SRE post-mortem (lessons vs action items 분리) + GitHub Actions approval gate + Terraform plan/apply 패턴과 1:1 정합 확인. APPROVE/PROPOSE 분리는 외부 컨벤션 추수가 아니라 단어 = 단일 책임 원칙의 자연 결과 — drift 의도 명시 (D5/D6/D7 alternatives_rejected)",
      "category": "design"
    }
  ],
  "next_candidates": [
    {
      "id": "v2.1_pending-milestone-renumber-policy",
      "title": "v1.x pending milestone 4건의 9-stage workflow 적용 정책 결정",
      "trigger": "v2.0 완료 후 v1.x pending 4건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline) 의 era 명명 vs workflow 일치 검토",
      "trigger_type": "D_design"
    },
    {
      "id": "v2.1_smoke-posttooluse-9stage-tests",
      "title": "smoke-posttooluse-hook.sh 에 INTENT/APPROVE/PROPOSE 신규 패턴 검증 추가",
      "trigger": "v2.0 phase-4 scope 외 — 본 milestone 에서는 hook 자체 갱신만 + 17 test 추가는 후속 강화. PROPOSE.md write trigger / APPROVE.md write trigger / INTENT.md write trigger 각각 test 추가",
      "trigger_type": "B_regression"
    },
    {
      "id": "v2.1_legacy-narrative-cleanup-final",
      "title": "docs/adr / .markdownlintignore / bootstrap/skills SKILL.md 잔존 7-stage 거명 정리",
      "trigger": "v2.0 phase-6 scope 외 — v1.5_legacy-narrative-cleanup 와 묶음 가능 (sessions/ stale 정리 + 7-stage 거명 정리)",
      "trigger_type": "C_improvement"
    },
    {
      "id": "v2.1_design-review-trace",
      "title": "Stage D 5 관점 검토 raw 출력 보존 (milestones/.../design-review/{architecture,spec-drift,...}.md)",
      "trigger": "v1.4_design-review-trace pending — 9-stage workflow 적용 후 재발의. ARCHITECTURE.md § 3.3 'Trace' 행 정전 강화 + 메타 고유 차별화",
      "trigger_type": "D_design"
    },
    {
      "id": "v2.1_hook-narrative-separation",
      "title": "post-report-write.sh inject 메시지 narrative MD 파일 분리",
      "trigger": "v1.4_hook-narrative-separation pending. v2.0 phase-4 에서 메시지 분기 (REPORT/APPROVE/PROPOSE) 추가했으므로 분리 시 MD 파일 5종 + hook 단순 reader 로 일괄 갱신",
      "trigger_type": "D_design"
    },
    {
      "id": "v2.1_research-cascade-grep-discipline",
      "title": "RESEARCH 단계 cascade grep 패턴 강화 (relative + 절대 + symlink)",
      "trigger": "v1.5_research-cascade-grep-discipline pending — 9-stage workflow 적용 후 RESEARCH 책임 강화",
      "trigger_type": "B_regression"
    }
  ]
}
```

## 종합 narrative

**의도 (PLAN) → 결과 (REPORT) 정합**: PLAN.success_criteria 11항목 중 10건 MET, 1건 (SC10 ROADMAP completed) Stage G 마지막 단계 PENDING. 본 REPORT 직후 ROADMAP v2.0 status: 'completed' 갱신 → SC10 MET.

**회귀 0**: 27 smoke 중 영향 받는 5건 (smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift / smoke-projects-scope-discipline) 모두 정합 갱신, 미영향 22건 자연 통과. shellcheck + markdownlint 도 통과 (초기 markdownlint 2건 + smoke schema 1건 fail → 즉시 fix forward).

**user 명시 결정 흐름**: 의문 round 3회 (총 13 question) → 5 관점 검토 → DESIGN 정정 8건 → 사용자 명시 승인 → 6 phase + 1 hotfix commit → MEMORY 동의 게이트. 모든 critical 결정 사용자 승인 게이트 통과.

**era transition 정책 효과**: 4-tier (v1.84~v1.88) / 7-stage (v1.0~v1.4) / 9-stage (v2.0+) 3 era 명문화 + 산출 파일명 자체로 자동 식별 — narrative 1차 + smoke 보조 정합. 본 v2.0 milestone 자체 7-stage 자기참조 표지 (D12) 가 chicken-and-egg 회피.

## 관련

- INTENT (PLAN.md): [`PLAN.md`](PLAN.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- 7 commit: 4846aa7 / 4435eb3 / a682f2a / e3d0478 / 84b0a49 / ab5b514 + hotfix 43472b7
- 정의 single source 갱신: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.3 + § 4 + § 6
- 사용자 메모리: ~/.claude/projects/C--Users-qkreh-harness-meta/memory/project_v2.0_workflow_9stage.md

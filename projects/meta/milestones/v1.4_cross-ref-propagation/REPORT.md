# REPORT — v1.4_cross-ref-propagation

```json
{
  "id": "v1.4_cross-ref-propagation",
  "summary": "v1.3_harness-engineering-definition DESIGN.decisions[4] 의 보수 cross-ref 결정 (root CLAUDE.md 1곳만 cross-ref, 나머지 5곳은 별개 milestone) 의 직접 후속. 본 milestone 에서 host 4곳 (AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 에 정의 § 3 cross-ref 1줄 standalone header/block 추가 + AGENTS Status 섹션 일반화 (Milestone history: see projects/meta/ROADMAP.md) + GUARDRAILS.md 전면 재작성 (sessions/→milestones/v{X.Y}_{slug}/, bootstrap 부재 디렉토리 C2~C6 제거, H/C 매트릭스 7-stage 재할당, 신규 H8 DESIGN.approval gate, § 4 Scope contract 7-stage 정합) + docs/ARCHITECTURE.md 폐기 (projects/meta/ARCHITECTURE.md 와 책임 중복) + cascade 7곳 정리 (RESEARCH 6곳 + smoke autofix 1곳 = docs/adr/README.md L34) + § 3.5 단일 source list 갱신 (docs/ARCH 제거, projects/meta/CLAUDE.md 추가, 결과 5곳 cross-ref host).\n\n사전 'pre-PLAN' 의문 round 에서 사용자 결정 4건 + 의문 round 2 모순 재확인 1건 도출. 4 관점 subagent 검토 (architecture / spec-drift / 회귀 risk / scope contract) 결과 사용자 결정 4건 추가 (phase 순서 / cross-ref 위치 / successors 버전 / GUARDRAILS H/C fate). DESIGN 13 결정 + 13 risk_mitigation. 3 phase commit (df3ea89 / f1a2b6f / 7ac122f) + Stage G commit. pre-commit smoke 5건 모두 PASS, 회귀 0. SC 6건 모두 pass.\n\n본 milestone 의 정전 효과 = 정의 § 3 단일 source 의 host 5곳 cross-ref 정합 강제 + GUARDRAILS host 자체 정전화 (4-tier sessions/ + 부재 bootstrap 거명 제거, 신규 H8 DESIGN.approval gate 로 정의 § 3.3 'Constraint' 메커니즘 보강) + docs/ARCH 책임 중복 폐기. 5요소 매트릭스 매핑 = primary 'Context' 정전 보강 (manual injection 컨벤션 약점 — host 4곳 cross-ref 부재 — 보강) + secondary 'Trace' 부수 (git history 영속) + tertiary 'Constraint' 부수 (신규 H8 DESIGN.approval gate). 회귀 risk agent 사전 예측 (smoke-cross-ref HIGH risk) 정확 — phase-2 commit 시 RESEARCH cascade 누락 1건 (docs/adr/README.md L34) 자동 검출 + --fix 적용으로 cascade 7곳 보완.",
  "delta": {
    "files_changed": 5,
    "files_added": 5,
    "files_deleted": 1,
    "modules_affected": [
      "AGENTS.md — 신규 § 'Harness engineering definition' (L64-66) 영문 cross-ref + Status 섹션 일반화 (L82, 'Public repository, MIT licensed. Milestone history: see projects/meta/ROADMAP.md').",
      "README.md L5 — tagline 직후 영문 cross-ref 1줄 standalone block (`>` quote pattern).",
      "projects/meta/CLAUDE.md L3 — H1 직후 한국어 cross-ref 1줄 (lazy load 발화 시점).",
      "GUARDRAILS.md — 전면 재작성 (92줄 → 96줄). sessions/→milestones/v{X.Y}_{slug}/, bootstrap C2~C6 제거 (C2 자리 bootstrap/skills/** 1줄 대체), H 매트릭스 H1~H8 재할당 (구 H7/H9 제거 + 신규 H8 DESIGN.approval gate), C 매트릭스 C1~C4 재할당 (구 C8 reframe), § 4 7-stage Scope contract 의무 (PLAN 의무 3 필드 + DESIGN.approval gate), § 6 References 정의 host 거명, § 1 안 정의 cross-ref (L20).",
      "docs/ARCHITECTURE.md — 폐기 (git rm). 53줄 4-tier 시대 잔존 (sessions/<target>/ + bootstrap/templates/_base / bootstrap/docs/ + bootstrap/render-manifest.sh / bootstrap/detect-project.sh — 모두 부재 디렉토리/파일).",
      "ROADMAP.md (root) L43 — '글로벌 시스템 도식: docs/ARCHITECTURE.md' cross-ref 줄 제거.",
      "projects/meta/ARCHITECTURE.md — 5곳 docs/ARCH 거명 제거 (L5 § 1 인용 / L46 § 2 모듈 책임 표 row / L102 § 6 / L112 § 7) + § 3.5 단일 source list 갱신 (docs/ARCH 제거, projects/meta/CLAUDE.md 추가).",
      "docs/adr/README.md L34 — broken cross-ref ('아키텍처 개요: ../ARCHITECTURE.md') 줄 제거 (smoke autofix 자동, RESEARCH cascade 누락 보완).",
      "projects/meta/ROADMAP.md — v1.4_cross-ref-propagation milestone status:in_progress 등재 (phase-1 commit) → completed 갱신 (Stage G commit), summary 갱신.",
      "projects/meta/milestones/v1.4_cross-ref-propagation/ — 신규 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT.md + execute/phase-{1,2,3}.md)."
    ]
  },
  "lessons_learned": [
    "RESEARCH 단계 cascade list grep 의 정확성 한계 — phase-2 commit 시 smoke-cross-ref autofix 가 RESEARCH 누락 1건 (docs/adr/README.md L34, `../ARCHITECTURE.md` relative path) 자동 검출 + --fix 적용. RESEARCH 단계 grep 패턴이 절대 path ('docs/ARCHITECTURE') 만 검색했으나 relative path (`../ARCHITECTURE.md` from docs/adr/) 누락. 향후 cascade RESEARCH 시 relative path + 절대 path + symlink 모두 grep 패턴 강화 의무. 회귀 risk agent 의 smoke 사전 예측 (HIGH risk) 정확 — 자동 보정 메커니즘이 정의 § 3.3 'Verification' 매트릭스 (smoke shell 인프라 = 임시방편) 의 운영 효용 입증.",
    "사전 'pre-PLAN' 의문 round 의 모순 검출 가치 — 의문 round 1 의 사용자 답변 4건 안에서 의문 1 (scope: docs/ARCH·GUARDRAILS 별개) vs 의문 3 (GUARDRAILS 전면 재작성 본 milestone 안) 모순이 round 2 재확인 으로 해소. 메모리 `feedback_iterative_pre_plan_review` 의 '매 round 결정적 이슈 trigger' 정신 효과적 — 첫 round 결정 후 모순 검출 round 추가가 PLAN 작성 정확성 보장. 다만 한 round 안에서 4 question 묶음 invoke 시 사용자 답변 간 정합성 검증 의무화 권고.",
    "DESIGN 13 결정 의 4 관점 subagent 산출 — architecture (phase 순서 reorder) + spec-drift (cross-ref 형식 + GUARDRAILS H/C 항목 별 fate 명시) + scope contract (successors v1.4_* vs v1.5_* discrepancy + SC#5 grep boundary) + 회귀 risk (markdownlint MD024 + baseline CI status). 각 agent 권고가 사용자 결정 4 건의 토대 — subagent 검토 → 사용자 결정 → DESIGN 결정의 흐름이 v1.3 패턴 답습 효과적. 단 baseline CI status 측정 (DESIGN.decisions[12]) 의 pre-EXECUTE 시점 측정은 milestone 진입 후에야 결정되어 누락 — 향후 milestone 발의 시 RESEARCH 단계 baseline 측정 의무 권고.",
    "정의 § 3.5 단일 source list 의 self-consistent 갱신 — phase-2 cascade 안에서 docs/ARCH 제거 + projects/meta/CLAUDE.md 추가 동시 처리. R8 (out_of_scope #1 위반 risk) 사전 식별 후 DESIGN.decisions[3] 명시 (§ 3.5 list = metadata, body ≠) 로 해소. v1.3 의 narrative trace 보존 정신 (DESIGN.decisions[6] 재해석 패턴) 답습 — PLAN.out_of_scope 의 추상 항목이 DESIGN 단계에서 구체 행위 매핑 시 본문/metadata 경계 명시 의무.",
    "GUARDRAILS host 자체 정전화의 self-reinforcing 효과 — 본 milestone 이 신규 H8 'DESIGN.approval gate 부재 EXECUTE 진입 차단' 추가로 정의 § 3.3 'Constraint' 메커니즘 cross_ref 안의 'DESIGN.approval (approved_by: \"user\" + date)' 가 host 자체 강제. 즉 정의 host (projects/meta/ARCHITECTURE.md) 의 § 3.3 매트릭스 (b) 메커니즘 컬럼 cross-ref 가 GUARDRAILS host (별도 host) 안에서 hard rule (H8) 로 강제 — 정전 메커니즘의 cross-host 정합 강화. 다음 milestone 발의 시 정의 § 3.3 매트릭스 (b) 메커니즘 cross_ref 항목 별로 host 안 강제 룰 부재 점검 (audit) 권고.",
    "phase 순서 reorder 의 효용 — architecture agent 권고로 phase-2 (docs/ARCH cascade) 가 phase-3 (GUARDRAILS rewrite) 전에 실행 → § 3.5 list 갱신이 GUARDRAILS rewrite 시점에 정합 상태. 만약 phase-3 (GUARDRAILS) 가 phase-2 (cascade) 전이면 GUARDRAILS rewrite 안의 정의 cross-ref 가 docs/ARCH 거명 잔존 list 안에서 self-referencing 부정합 transient 상태 — narrative trace 손상 risk. v1.3 lessons '단순 메시지 교체도 phase 분리가 smoke 격리 이득' 의 확장 = 'phase 순서가 host 정합 상태를 결정', 향후 multi-host milestone 발의 시 phase 순서 architecture 검토 의무.",
    "phase-2 의 RESEARCH 누락 보완이 commit re-flow 일으킴 — pre-commit hook smoke-cross-ref --fix 자동 적용 후 commit abort, 사용자 안내로 git diff 검토 + .bak 정리 + re-stage + re-commit. 본 흐름은 메모리 `feedback_hard_reset_for_direction_change` 와 별개 — autofix 결과는 사용자 review 후 수용 패턴이며, --no-verify 우회 0 (H4 / 신규 H8 정신 답습). 향후 cascade 작업 시 pre-commit autofix 의 정전 효용 (smoke 가 narrative cleanup 자동 수행) 활용 권고."
  ],
  "next_candidates": [
    {
      "id": "v1.4_infra-minimization",
      "title": "인프라 최소화 — install/verify 제거 + smoke 합리화 (5요소 'Verification 혼재' 정전화)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "정의 § 3.3 매트릭스 'Verification' 만 '혼재' 분류 — VERIFY.md narrative 정전 + smoke shell 인프라 임시방편. 본 milestone 의 phase-2 commit 시 smoke-cross-ref autofix 자동 검출 효용 입증되었으나 12+ inactive bootstrap 부재 거명 smoke (smoke-broad-bash-fine-grain / smoke-thinking-effort / smoke-language-overlay 등) 는 정전화 대상. install.ps1 / verify.{ps1,sh} 제거 + smoke 22종 합리화 + bootstrap 부재 디렉토리 거명 cleanup. ROADMAP entry 이미 pending."
    },
    {
      "id": "v1.4_hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "정의 § 3.1 명료화 단락 거명 자동화 #2 'hook hard-code'. post-report-write.sh inject 메시지 MD 분리, hook 단순 reader. ROADMAP entry 이미 pending."
    },
    {
      "id": "v1.4_design-review-trace",
      "title": "Stage E 5 관점 검토 raw 출력 보존 (milestones/.../design-review/)",
      "trigger": "D_design",
      "trigger_type": "design",
      "rationale": "정의 § 3.3 'Trace' 정전 + 메타 고유 차별화 — 본 milestone 의 4 관점 subagent 검토 raw 출력도 DESIGN.md 통합 후 소실. milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 보존. ROADMAP entry 이미 pending."
    },
    {
      "id": "v1.5_legacy-narrative-cleanup",
      "title": "잔존 sessions/ stale + 4-tier narrative 일괄 정리 (claude/hooks/post-report-write.sh L2 / claude/CLAUDE.md L39 / projects/upbit/* / CHANGELOG.md L3)",
      "trigger": "C_improvement",
      "trigger_type": "improvement",
      "rationale": "본 milestone 의 RESEARCH untouched_files_explicit 6건 묶음 — claude/hooks/post-report-write.sh L2 'PostToolUse hook: sessions/**/REPORT.md' stale 주석, claude/CLAUDE.md L39 stale narrative ('현재 silent NOOP, 후속 milestone 처리 예정' 이미 처리됨), projects/upbit/{ARCHITECTURE,ROADMAP}.md sessions/ 거명, CHANGELOG.md L3 stale path. 별개 milestone 으로 분리하여 본 milestone 의 cross-ref 전파 정신 보존."
    },
    {
      "id": "v1.5_research-cascade-grep-discipline",
      "title": "RESEARCH 단계 cascade grep 패턴 강화 (relative + 절대 + symlink)",
      "trigger": "B_regression",
      "trigger_type": "regression",
      "rationale": "본 milestone 의 lessons_learned #1 — RESEARCH 단계 cascade list 가 relative path (`../ARCHITECTURE.md`) 누락 (1건). claude/commands/harness-meta.md 또는 RESEARCH 템플릿 보강 — cascade RESEARCH 시 relative + 절대 + symlink 모두 grep 패턴 강화 의무 명시. 또는 신규 smoke (smoke-cascade-completeness.sh) 추가 — 단 정의 § 3.1 명료화 단락 정신상 smoke 신규 추가는 신중 판단."
    }
  ]
}
```

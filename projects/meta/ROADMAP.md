# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-10",
  "schema_note": "v3.0+ 9-stage-bundled era entry: {version, id (group-slug), title, status, summary, trigger, milestones_path?}. v2.0~v2.1 / v1.0~v1.4 보존 entry: 기존 schema (id flat = v{X.Y}_{slug}) 유지 (forward-only). 신 schema spec: ARCHITECTURE.md § 6.1.",
  "milestones": [
    {
      "version": "v3.3",
      "id": "ci-inactive-smoke-cleanup",
      "title": "CI inactive smoke 16건 정리 — bootstrap 잔존 / install-verify 합리화 / session 잔존 narrative cleanup",
      "status": "pending",
      "summary": "v3.1 push 후 gh CI 검증 사후 발견 (2026-05-10) — GitHub Actions 'Smoke Tests' workflow 가 28 smoke 중 16건 fail 누적 (v3.0 push 시점부터 동일, v3.1 회귀 0). 16건 모두 inactive smoke (pre-commit 5+1 active 외, narrative 1차 source manual run leverage) 의 historical state. 그룹 별 sub-milestone 3건 통합: (1) bootstrap 잔존 정리 10건 — bootstrap/templates/_base/.claude/skills/harness-{design,plan,review}/SKILL.md 부재 (4-tier era 잔존) 영향 smoke (bootstrap-{agents-md,license-{boilerplate,detect,metadata},render} + bash-permission-pattern + broad-bash-fine-grain + thinking-effort + language-overlay + license-line-policy) — bootstrap 제거 vs 복원 결정 / (2) install-verify 합리화 4건 (skills-install + sync-agents + verify-sh-parity + backup-cleanup) — v1.4_infra-minimization 정신 (install/verify 제거) 일관성 검토 / (3) session 잔존 narrative 2건 (roadmap-sync + legacy-cleanup-overlay) — sessions/ 단계 잔존 narrative cleanup. 각 그룹 결정: deprecate 삭제 vs fix 복원 vs SKIP 마킹 trade-off. INTENT 단계에서 그룹별 결정 필요. CI workflow `.github/workflows/ci.yml` 자체 inactive smoke 실행 정책 재검토 가능 (active 6 만 실행 vs 전 28 실행 vs 분리 job).",
      "trigger": "B_regression"
    },
    {
      "version": "v3.2",
      "id": "workflow-narrative-strengthening",
      "title": "workflow narrative 강화 — Stage F 절차 / smoke skeleton 책임 분리 / controlled 비교 cp949 narrative",
      "status": "completed",
      "milestones_path": "milestones/v3.2/milestones.md",
      "summary": "v3.1 lessons L2/L3/L5/L6/L9 narrative 공백 4건 채움. phase-1: harness-meta.md Stage F 선결 조건 게이트 블록 신규 (milestones.md 선결 의무 CRITICAL + INTENT~APPROVE commit 시점 3 패턴). phase-2: tests/CLAUDE.md controlled 비교 cp949 mojibake 정상 작동 narrative. phase-3: Skeleton 매트릭스 2 row (era 분류 vs schema 책임 분리 + status 기반 분기). 3 phase 3 commit (1220a2d/6483d1b/de7f62a), 13 hook PASS, 회귀 0. 2026-05-11.",
      "trigger": "C_improvement"
    },
    {
      "version": "v3.1",
      "id": "workflow-policy-fine-tuning",
      "title": "v3.0 bundling 정책 첫 후속 적용 — markdownlint trap / milestones.md historical / bundling trigger smoke",
      "status": "completed",
      "milestones_path": "milestones/v3.1/milestones.md",
      "summary": "v3.0_milestones-restructure 직접 후속 (PROPOSE next_candidates 3건 + lessons L10) 통합 milestone. v3.0+ 9-stage-bundled era 첫 후속 통합 milestone 사례 (도그푸드 누적). 3 sub-milestone: phase-1 markdownlint trap narrative (tests/CLAUDE.md § '흔한 함정' 7번째 row + MD049 spec 직접 인용) + milestones.md 신규 (R1 CRITICAL mitigation) / phase-2 historical era 적용 결정 (forward-only 강제, v3.0 milestones.md unchanged D12 사용자 결정 P1) / phase-3 tests/smoke-bundle-trigger.sh 신규 + pre-commit 등록 (12→13 hook, 자동 강제 누적). 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 1건 사용자 결정 해소 + 19 권고 자동 흡수 (D13~D18 신규). 3 phase 3 commit (0a86598 / 4bd4ec6 / d136b2f), pre-commit 13 hook 모두 PASS, 회귀 0. INTENT.success_criteria 8건 모두 PASS. minor bump (semver 정합 backward-compatible). 8 lessons (L1~L8) 중 4 건 후속 candidate 등록 (v3.2_workflow-narrative-strengthening 통합). 2026-05-10.",
      "trigger": "B_regression",
      "absorbed_milestones": [
        "v3.1_markdownlint-trap-narrative (phase-1, v3.0 PROPOSE next_candidates)",
        "v3.1_milestones-md-spec-formalization (phase-2, v3.0 PROPOSE next_candidates)",
        "v3.1_smoke-bundle-trigger-validation (phase-3, v3.0 PROPOSE next_candidates)"
      ]
    },
    {
      "version": "v3.0",
      "id": "milestones-restructure",
      "title": "milestone hierarchy 재구성 — version > sub-milestone > phase + v2.2_* 4건 흡수",
      "status": "completed",
      "summary": "v2.2_* 4건 검토 round 중 사용자가 명명 구조 v{X.Y}_{slug} 자체가 grouping 한계의 root cause임을 통찰. 동일 X.Y 후속 candidates가 별도 milestone으로 분리 강제 → 토큰 비효율 + INTENT/DESIGN 중복 + merge conflict 위험. 해결: ROADMAP `milestones[]` schema에 version/id 분리 + 디렉토리 milestones/v{X.Y}/ 도입 + milestones.md (sub-milestone listing per version) 신규 + smoke era 분기 (forward-only, historical v1.x~v2.1 보존). 자기참조 부합 — v3.0 자체가 신 구조 첫 적용 사례 (도그푸드). 8 phase: phase-1 smoke era branching / phase-2 _era_detect.py 분리 (v2.2_era-detect-shared-module 흡수) / phase-3 정책 명문화 + INTENT~APPROVE commit / phase-4 ROADMAP schema 변경 + v2.2_* 4건 entry 제거 / phase-5 milestones.md 도입 / phase-6~8 v2.2_* 3건 잔여 흡수 (cp949 / controlled-comparison / historical-decision). breaking change → major bump (v2 → v3).",
      "trigger": "A_user",
      "milestones_path": "milestones/v3.0/milestones.md",
      "absorbed_milestones": [
        "v2.2_era-detect-shared-module (phase-2)",
        "v2.2_smoke-cp949-encoding-pattern (phase-6)",
        "v2.2_smoke-controlled-comparison-pattern (phase-7)",
        "v2.2_historical-7stage-stage1-decision (phase-8)"
      ]
    },
    {
      "id": "v2.1_smoke-spawn-batching",
      "title": "smoke-spec-verification + smoke-scope-contract python3 spawn batching (66s+12s → 0.6s+0.6s)",
      "status": "completed",
      "summary": "사용자 발의 — pre-commit 전체 1m33s 의 84% (smoke-spec-verification 66.4s + smoke-scope-contract 12.4s) 가 milestone N × stage M 마다 python3 새로 spawn 하는 비효율로 점유. Approach A 채택 (단일 batched python3 호출). spec-verification 66.4s → 0.63s (99.05% 감소) + scope-contract 12.4s → 0.65s (94.76% 감소) + 전체 pre-commit 93.3s → 15.4s (83.49% 감소). INTENT.success_criteria 7건 모두 임계 대비 2~16x 여유로 PASS, 회귀 0. 3 관점 검토 (architecture / 회귀 risk / scope contract — D11 spec-drift 자리 회귀 risk 대체) 모두 pass-with-comments + 의견 충돌 0. 검토 권고 11건 모두 흡수 (D5/D12~D17 + R11~R13). 신규 발견 1건 (Windows cp949 콘솔 em dash UnicodeEncodeError, smoke-python-entry-boilerplate § P2 v1.87 패턴 차용). 9-stage workflow (v2.0+) 두 번째 실 적용 — APPROVE 게이트 + PROPOSE 분리 정상. 2 phase commit (e4cffd6 + de1421e), pre-commit 5 hook 모두 PASS. 7 lessons (L1~L7) 중 4 건 후속 candidate 등록 (v2.2_*). 2026-05-10.",
      "trigger": "A_user"
    },
    {
      "id": "v2.0_workflow-word-fidelity",
      "title": "워크플로우 stage 단어 의미 부합 정정 — 7-stage → 9-stage (OPEN/INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE)",
      "status": "completed",
      "summary": "현 7-stage workflow 의 4건 단어 미스매치 (MILESTONE 단어-책임 부정합 / PLAN 'intent only' narrowing / DESIGN 3 책임 혼재 / REPORT backward+forward 혼재) 전면 정정. MILESTONE→OPEN, PLAN→INTENT, DESIGN(decisions+approach+phases) + APPROVE 분리, REPORT(lessons) + PROPOSE 분리. ROADMAP 은 입력 source 로 stage 카운트 제외 (OPEN~PROPOSE = 9 stage). 5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) — 회귀 risk 1 fail + 4 pass-with-comments → DESIGN 정정 8건 반영 후 5 관점 모두 pass. 사용자 의문 round 3회 (총 13 question 명시 결정). 6 phase + 1 hotfix = 7 commit (4846aa7 / 4435eb3 / a682f2a / e3d0478 / 84b0a49 / ab5b514 + 43472b7). ARCHITECTURE.md § 3.3 5요소 매트릭스 'Workflow' 행 9-stage + 'Constraint' 행 APPROVE.md.approved_by gate + 'Trace' 행 산출 7종 + § 4 9-stage 섹션 + § 6 era 정책 (4-tier / 7-stage / 9-stage 3 era) 명문화. claude/commands/harness-meta.md 9-stage 절차 전면 재작성. 단일 source 5곳 + 모듈 가이드 3곳 cascade. smoke (smoke-spec-verification / smoke-scope-contract) 에 era 자동 식별 메커니즘 + post-report-write hook 9-stage 패턴 + 분기 inject 메시지. Historical 7-stage era 11개 milestone PLAN.md → INTENT.md git mv (history 96~100% 보존) + 본문 cross-ref. 4-tier era 보존. 본 v2.0 milestone 자체 7-stage 포맷 자기참조 표지 (D12). pre-commit 5 hook 모두 PASS, 회귀 0. CHANGELOG v2.0 entry + 사용자 메모리 갱신. 2026-05-10.",
      "trigger": "D_design"
    },
    {
      "id": "v2.1_pending-milestone-renumber-policy",
      "title": "v1.x pending milestone 4건의 9-stage workflow 적용 정책 결정",
      "status": "pending",
      "summary": "v2.0 lessons next_candidates#1 — v1.x pending 4건 (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline) 의 era 명명 (v1.x) vs workflow (9-stage) 일치 검토. 옵션: v2.x renumber / v1.x id 유지하되 9-stage 적용 / 별 처리. v2.0 D11 (out_of_scope) 의 직접 후속.",
      "trigger": "D_design"
    },
    {
      "id": "v2.1_smoke-posttooluse-9stage-tests",
      "title": "smoke-posttooluse-hook.sh 에 INTENT/APPROVE/PROPOSE 신규 패턴 검증 추가",
      "status": "pending",
      "summary": "v2.0 lessons next_candidates#2 — v2.0 phase-4 에서 post-report-write.sh 갱신 + INTENT/APPROVE/PROPOSE 패턴 + write 분기 메시지 추가했으나, smoke-posttooluse-hook.sh 의 17 test 는 현 PLAN.md / REPORT.md / execute/phase-N.md 검증만. 신규 INTENT.md / APPROVE.md / PROPOSE.md write trigger 검증 test 추가 (각각 1~2 test).",
      "trigger": "B_regression"
    },
    {
      "id": "v1.3_harness-engineering-definition",
      "title": "하네스 엔지니어링 정의 명시 — 메타 레이어의 working definition + 5요소 매트릭스 박기",
      "status": "completed",
      "summary": "projects/meta/ARCHITECTURE.md § 3 단일 source 에 working definition (1문장) + '인프라 자동화 의존 최소화' 명료화 단락 + working philosophy + 4컬럼 5 row 매트릭스 (Context / Workflow / Constraint / Verification / Trace) + 외부 컨벤션 관계 + 단일 source 정합 + 신규 milestone 평가 절차 6 sub-section 박음. root CLAUDE.md L8 cross-ref 1줄 추가 (보수 결정 — 다른 host 5곳 은 후속 v1.4_cross-ref-propagation 분리). 3 관점 병렬 검토 + 사용자 결정 2건 (4컬럼 / 보수 cross-ref) + 명료화 단락 추가 trigger. 2 phase + Stage G commit, pre-commit smoke 8건 PASS, 회귀 0. 2026-05-09.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.4_infra-minimization",
      "title": "인프라 최소화 — install/verify 제거 + smoke 합리화 (5요소 'Verification 혼재' 정전화)",
      "status": "completed",
      "summary": "v1.3 § 3.3 매트릭스 'Verification' 행 (c) = 혼재 → 정전 갱신 + drift 2건 (smoke-l5-readme-link-cleanup / smoke-v1.1, 4-tier era 잔존) 단순 제거 + tests/CLAUDE.md 매트릭스 narrative 강화 (L7 count 29→27 + 매트릭스 헤더 직후 narrative 1차 source standalone block + 핵심 정책 검증 표 smoke-projects-scope-discipline row 추가 + 현행 hook § 직후 inactive 22 회귀 차단 책임 paragraph). Option A 채택 (보수적 슬림화 — 사용자 PLAN/RESEARCH 분기). 4 관점 subagent 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 5 권고 반영. DESIGN.D9 narrative 대체 메커니즘 1:1 매핑 (a/b/c). § 3.5 cascade grep host 5곳 (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) 4 pattern 본문 중복 부재 직접 검증 → 단일 source 정합 보장. 3 phase commit (3f918d3 / bd398a1 / 7ba503f) + Stage G, pre-commit 5 hook 모두 PASS, 회귀 0. ARCHITECTURE.md (b) smoke 22종 → 27종 카운트 cascade. 2026-05-10.",
      "trigger": "D_design"
    },
    {
      "id": "v1.4_hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "status": "pending",
      "summary": "v1.3 § 3.1 명료화 단락 거명 자동화 #2 'hook hard-code'. post-report-write.sh inject 메시지를 shell 안에 박지 않고 MD 파일에 분리, hook 은 단순 reader.",
      "trigger": "D_design"
    },
    {
      "id": "v1.4_design-review-trace",
      "title": "Stage E 5 관점 검토 raw 출력 보존 (milestones/.../design-review/)",
      "status": "pending",
      "summary": "v1.3 § 3.3 매트릭스 'Trace' = 정전 + 메타 고유 차별화이나 현재 Stage E subagent 5 관점 검토 결과는 DESIGN.md 통합 후 raw 출력 소실. milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 로 보존.",
      "trigger": "D_design"
    },
    {
      "id": "v1.4_cross-ref-propagation",
      "title": "정의 cross-ref 전파 (AGENTS.md / README.md / projects/meta/CLAUDE.md / GUARDRAILS.md) + GUARDRAILS 재작성 + docs/ARCHITECTURE.md 폐기",
      "status": "completed",
      "summary": "v1.3 DESIGN.decisions[4] 보수 cross-ref 결정의 직접 후속. host 4곳 (AGENTS·README·projects/meta/CLAUDE·GUARDRAILS) 정의 § 3 cross-ref 1줄 standalone header/block 추가 (영문 host 'canonical single source' / 한국어 host '정전 single source' 표본 통일) + AGENTS Status 섹션 일반화 (Milestone history: see projects/meta/ROADMAP.md) + GUARDRAILS.md 전면 재작성 (sessions/→milestones/, bootstrap C2~C6 부재 제거, H 매트릭스 H1~H8 재할당 (구 H7/H9 제거 + 신규 H8 DESIGN.approval gate), C 매트릭스 C1~C4 재할당, § 4 7-stage Scope contract, § 6 References 정의 host 거명) + docs/ARCHITECTURE.md 폐기 (책임 중복) + cascade 7곳 정리 (RESEARCH 6곳 + smoke autofix 1곳 docs/adr/README.md L34) + § 3.5 단일 source list 갱신 (5곳: root CLAUDE.md/AGENTS.md/README.md/projects/meta/CLAUDE.md/GUARDRAILS.md). 4 관점 subagent 검토 (architecture / spec-drift / 회귀 risk / scope contract) + 사용자 결정 4건 (의문 round 1) + 모순 재확인 (round 2) + DESIGN 13 결정 + 13 risk_mitigation. 3 phase commit (df3ea89 / f1a2b6f / 7ac122f) + Stage G commit. pre-commit smoke 5건 모두 PASS, 회귀 0. 2026-05-09.",
      "trigger": "D_design"
    },
    {
      "id": "v1.5_legacy-narrative-cleanup",
      "title": "잔존 sessions/ stale + 4-tier narrative 일괄 정리 (claude/hooks/post-report-write.sh L2 / claude/CLAUDE.md L39 / projects/upbit/* / CHANGELOG.md L3)",
      "status": "pending",
      "summary": "v1.4_cross-ref-propagation RESEARCH untouched_files_explicit 6건 묶음 — claude/hooks/post-report-write.sh L2 stale 주석 / claude/CLAUDE.md L39 stale narrative / projects/upbit/{ARCHITECTURE,ROADMAP}.md sessions/ 거명 / CHANGELOG.md L3 stale path. 본 milestone 의 cross-ref 전파 정신 보존 위해 별개 milestone 으로 분리.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.5_research-cascade-grep-discipline",
      "title": "RESEARCH 단계 cascade grep 패턴 강화 (relative + 절대 + symlink)",
      "status": "pending",
      "summary": "v1.4 lessons_learned #1 — RESEARCH 단계 cascade list grep 이 relative path (`../ARCHITECTURE.md`) 누락 (1건). phase-2 commit 시 smoke-cross-ref autofix 가 보완. claude/commands/harness-meta.md 또는 RESEARCH 템플릿 보강 — cascade RESEARCH 시 relative + 절대 + symlink 모두 grep 패턴 강화 의무 명시.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_meta-as-project",
      "title": "meta repo를 projects/meta/로 이관 — 모든 project 동형 구조 강제",
      "status": "completed",
      "summary": "root ROADMAP/milestones를 projects/meta/ 하위로 이관 (git mv 7 dirs, history 보존) + ARCHITECTURE.md 신규 + root ROADMAP을 thin index 변환 + projects/meta/CLAUDE.md (lazy subdir) 신설 + /harness-meta 경로 resolution 갱신 + misclassified v1.1_upbit-cross-ref-cleanup 이관 (root → projects/upbit/) + scope-discipline smoke 신규 + 단독 active 활성화 + 4 optional sweeps (settings.local.json prune / docs grep / harness-roadmap-update SKILL deprecation / pre-commit-config 주석 갱신). 3 phase commit (7bfa1a5 / 0fa3d32 / e2f59de), 회귀 0. 2026-05-08.",
      "trigger": null
    },
    {
      "id": "v1.1_readme-cleanup",
      "title": "README.md legacy 참조 (Bootstrap mode / DECISIONS|INTERVIEW|STACK / sessions/) 정리",
      "status": "completed",
      "summary": "10-stage tagline·/harness-plan·design·run·ship·sessions/ 경로·Bootstrap mode·Stage 2 bootstrap 설치·Language overlay·bootstrap/docs 링크 제거 + 7-stage 재작성. 2-phase, pre-commit full-pass, 회귀 0. 2026-05-08.",
      "trigger": "A_user"
    },
    {
      "id": "v1.1_agents-md-cleanup",
      "title": "AGENTS.md legacy 참조 정리 (README.md cleanup 후속)",
      "status": "completed",
      "summary": "Status 섹션 stale 표기 1건(v1.1_meta-as-project 'in progress') 갱신 — v1.0·v1.1_meta-as-project·v1.1_readme-cleanup completed + v1.1_agents-md-cleanup in progress 표기. 예상 legacy 참조(10-stage·Bootstrap)는 실제 스캔 결과 없었음. 1 phase, pre-commit full-pass, 2026-05-08.",
      "trigger": "A_user"
    },
    {
      "id": "v1.1_smoke-precommit-rewrite",
      "title": "smoke + .pre-commit hook 4종 재작성 (새 7-stage 포맷 정합)",
      "status": "completed",
      "summary": "4 smoke 전면 재작성(spec-verification/scope-contract) + 최소 패치(cross-ref/claude-md-drift) + pre-commit 5 hook 활성화. JSON schema 검증 + DESIGN.approval 게이트 + 43건 broken ref 정리. 4 phase, pre-commit full-pass, 회귀 0건. 2026-05-08.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_post-report-write-hook-update",
      "title": "claude/hooks/post-report-write.sh 패턴 갱신",
      "status": "completed",
      "summary": "sessions/.*/REPORT.(md|ipynb)$ 패턴 → projects/meta/milestones/v{X.Y}_*/(PLAN|RESEARCH|DESIGN|VERIFY|REPORT|execute/phase-N).md$ 패턴. 2 phase, pre-commit full-pass, smoke 22/22, 회귀 0. 2026-05-08.",
      "trigger": "B_regression"
    },
    {
      "id": "v1.1_design-phases-execute-tracking-automation",
      "title": "DESIGN.phases[n] execute/phase-{n}.md 자동 트래킹",
      "status": "completed",
      "summary": "harness-meta.md Stage E phases 필드 + Stage F step 1/2 지침 갱신 — execute/phase-{n}.md DESIGN.affected_files 포함 의무 명시. 1 phase, pre-commit full-pass, 회귀 0. 2026-05-08.",
      "trigger": "D_design"
    },
    {
      "id": "v1.2_post-report-write-message-rewrite",
      "title": "post-report-write.sh additionalContext 메시지 재작성 (7-stage 안내)",
      "status": "completed",
      "summary": "deprecated SKILL 참조(harness-roadmap-update/harness-plan-verify) 제거 + 7-stage 흐름 안내 메시지 교체. smoke 6건 키워드 갱신. 2 phase, smoke 22/22, pre-commit full-pass, 회귀 0. 2026-05-08.",
      "trigger": "C_improvement"
    },
    {
      "id": "v1.0_workflow-redesign",
      "title": "7-stage workflow redesign — single-responsibility pipeline",
      "status": "completed",
      "summary": "기존 4-tier sessions/milestones 구조를 새 7-stage JSON-schema 기반 흐름(ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT)으로 완전 교체. 6 phase 분할 commit. ~370 파일 정리 + 12 신규. 회귀 0. 2026-05-08.",
      "trigger": null
    }
  ]
}
```

## 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 최근 완료 milestone: [`milestones/v1.1_meta-as-project/`](milestones/v1.1_meta-as-project/) (REPORT 참조, 2026-05-08)
- 다음 직전 완료: [`milestones/v1.0_workflow-redesign/`](milestones/v1.0_workflow-redesign/) (REPORT 참조, 2026-05-08)
- Historical (4-tier 포맷): `milestones/v1.84_*` ~ `milestones/v1.88_*` (참조용 보존, 신규 작업은 v1.0+ 7-stage만)

## 비고

이 ROADMAP은 v1.1_meta-as-project (2026-05-08 완료) 에서 신설됨. 이전에는 root `ROADMAP.md` 가 meta scope 의 단일 source 였으나, 본 milestone 후 root는 thin index, 본 파일이 meta milestones[] 의 단일 source 가 됨.

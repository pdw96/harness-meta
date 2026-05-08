# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-09",
  "milestones": [
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
      "status": "pending",
      "summary": "v1.3_harness-engineering-definition § 3.3 매트릭스에서 'Verification' = 혼재 (smoke shell 임시방편) + 'Context' SKILL 자동 invoke 임시방편 분류 → install.ps1 / verify.{ps1,sh} / smoke 22종 감사 + narrative 대체 가능 식별·제거.",
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
      "title": "정의 cross-ref 전파 (AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md) + stale 정리 동반",
      "status": "pending",
      "summary": "v1.3 DESIGN.decisions[4] 보수 cross-ref 결정의 직접 후속. 5곳 cross-ref 일괄 + 동반 stale 정리 (docs/ARCHITECTURE.md 4-tier 잔존 / AGENTS.md Status 섹션 / GUARDRAILS.md sessions/ 잔존).",
      "trigger": "D_design"
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

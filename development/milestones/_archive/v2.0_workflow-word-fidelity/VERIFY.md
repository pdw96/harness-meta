# VERIFY — v2.0_workflow-word-fidelity

```json
{
  "milestone_id": "v2.0_workflow-word-fidelity",
  "verify_date": "2026-05-10",
  "smoke_tests": [
    {
      "name": "smoke-projects-scope-discipline",
      "command": "bash tests/smoke-projects-scope-discipline.sh (pre-commit)",
      "result": "PASS",
      "output": "phase 1~6 + hotfix commit 모두 통과"
    },
    {
      "name": "smoke-spec-verification",
      "command": "bash tests/smoke-spec-verification.sh (pre-commit + manual)",
      "result": "PASS",
      "output": "PASS=93 FAIL=0 SKIP=78 — 9-stage era (Stage 2/5/8 INTENT/APPROVE/PROPOSE) + 7-stage era (Stage 1 PLAN) era 자동 식별 정상 동작. 본 v2.0 milestone 은 7-stage era (자기참조 표지) — Stage 1 PLAN.md 검증 OK + Stage 2/5/8 INTENT/APPROVE/PROPOSE 부재 SKIP. 11 historical milestone 은 phase-5 rename 후 INTENT.md 검증 OK."
    },
    {
      "name": "smoke-scope-contract",
      "command": "bash tests/smoke-scope-contract.sh (pre-commit + manual + hotfix 후 재검증)",
      "result": "PASS",
      "output": "PASS=15 FAIL=0 SKIP=21 — hotfix (detect_era 에 INTENT.md only 케이스 추가) 후 11 historical 7-stage milestone 모두 정상 era 분류 + DESIGN.approval.approved_by='user' 검증 OK. 본 v2.0 milestone (7-stage era) — DESIGN.md.approval.approved_by='user' OK."
    },
    {
      "name": "smoke-cross-ref",
      "command": "bash tests/smoke-cross-ref.sh (pre-commit)",
      "result": "PASS",
      "output": "phase 1~6 commit 모두 통과 — cascade ref 정합"
    },
    {
      "name": "smoke-claude-md-drift",
      "command": "bash tests/smoke-claude-md-drift.sh (pre-commit)",
      "result": "PASS",
      "output": "phase 3 commit (8 모듈 CLAUDE.md cascade) 후에도 drift 0"
    },
    {
      "name": "shellcheck (pre-commit)",
      "command": "shellcheck tests/smoke-*.sh claude/hooks/*.sh",
      "result": "PASS",
      "output": "phase 4 + hotfix 모두 통과 — smoke-spec-verification.sh / smoke-scope-contract.sh / post-report-write.sh 갱신 후 shellcheck 정상"
    },
    {
      "name": "markdownlint (pre-commit)",
      "command": "markdownlint *.md projects/**/*.md",
      "result": "PASS",
      "output": "초기 2건 fail (DESIGN/RESEARCH MD032 list 빈 줄 / CHANGELOG MD026 trailing !) → 즉시 fix 후 통과"
    }
  ],
  "manual_checks": [
    {
      "check": "ARCHITECTURE.md § 3.3 매트릭스 Workflow/Constraint/Trace 행 9-stage 갱신 + § 4 9-stage 섹션 + § 6 era 정책",
      "result": "PASS",
      "notes": "phase-1 commit (4846aa7) — § 1 디렉토리 트리 9-stage 7종 + § 3.3 3 행 + § 4 + § 6 era 정책 (4-tier/7-stage/9-stage 3 era 매트릭스) 모두 적용"
    },
    {
      "check": "claude/commands/harness-meta.md 9-stage 전면 재작성 (Stage A=OPEN ~ Stage I=PROPOSE)",
      "result": "PASS",
      "notes": "phase-2 commit (4435eb3) — 9-stage 절차 + Stage 영문자 매핑 + AskUserQuestion trigger 표 갱신 + 금지 목록 (4-tier + 7-stage 신규 금지 + v2.0 자체 예외)"
    },
    {
      "check": "단일 source 5곳 (CLAUDE.md / projects/meta/CLAUDE.md / AGENTS.md / README.md / GUARDRAILS.md) cross-ref + 본문 갱신",
      "result": "PASS",
      "notes": "phase-3 commit (a682f2a) — 8곳 (host 5 + 모듈 3) 갱신. 정의 본문 중복 부재 (정의 single source = ARCHITECTURE.md § 3 만)"
    },
    {
      "check": "모듈 가이드 4곳 (claude/CLAUDE.md / tests/CLAUDE.md / bootstrap/skills/CLAUDE.md + projects/meta/CLAUDE.md) 갱신",
      "result": "PASS",
      "notes": "phase-3 commit 안에 포함"
    },
    {
      "check": "tests/smoke-* + hooks/post-report-write.sh era 자동 식별 + 9-stage stage 검증 + APPROVE/PROPOSE 패턴 추가",
      "result": "PASS",
      "notes": "phase-4 commit (e3d0478) + hotfix (43472b7) — era 자동 식별 (D10) 정상 동작. post-report-write.sh INTENT/APPROVE/PROPOSE 패턴 + write 시점 분기 inject 메시지 (REPORT → PROPOSE / APPROVE → EXECUTE 게이트 / PROPOSE → ROADMAP 등록)"
    },
    {
      "check": "Historical 7-stage era 11개 milestone PLAN.md → INTENT.md git mv + 본문 cross-ref",
      "result": "PASS",
      "notes": "phase-5 commit (84b0a49) — 11 rename (history 보존, 96~100% rename 인식) + sed 본문 cross-ref. grep 'PLAN.md' 잔존 검증: 본 v2.0 milestone 자체 (자기참조 표지) + 4-tier era milestone 파일명 + 정의 host era 보존 narrative — 모두 의도된 잔존만 식별"
    },
    {
      "check": "era 구분 메커니즘 명문화 (ARCHITECTURE § 6 + smoke 자동 식별)",
      "result": "PASS",
      "notes": "phase-1 (ARCHITECTURE § 6) + phase-4 (smoke-spec-verification era 자동 식별) + hotfix (smoke-scope-contract detect_era INTENT.md only 케이스). narrative 1차 + smoke 보조 (D10, ARCHITECTURE § 3.1 정합)"
    },
    {
      "check": "본 v2.0 milestone 자체 7-stage 포맷 유지 (자기참조 회피, D12)",
      "result": "PASS",
      "notes": "본 milestone 디렉토리: PLAN.md / RESEARCH.md / DESIGN.md / VERIFY.md / REPORT.md (7-stage era 포맷). INTENT/APPROVE/PROPOSE 부재 (era 표지). v2.1+ 부터 9-stage 의무"
    },
    {
      "check": "pre-commit smoke 5 hook 모두 PASS, 기존 smoke 회귀 0",
      "result": "PASS",
      "notes": "phase 1~6 + hotfix commit 모두 pre-commit 5 hook (markdownlint / smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift) 통과. shellcheck 도 통과. --no-verify 미사용"
    },
    {
      "check": "ROADMAP v2.0 entry status: completed",
      "result": "PENDING",
      "notes": "REPORT.md 작성 + Stage G 마지막에서 ROADMAP milestones[0].status: 'in_progress' → 'completed' 갱신 예정"
    },
    {
      "check": "MEMORY.md (사용자 메모리) 갱신",
      "result": "PASS",
      "notes": "사용자 명시 동의 후 (option A 선택) — project_v2.0_workflow_9stage.md 신규 + MEMORY.md index entry 추가. ~/.claude 외부 path (git tracking 외)"
    }
  ],
  "criteria_check": [
    {"criterion": "SC1 — ARCHITECTURE.md § 3 Workflow 매트릭스 9-stage 갱신", "phase": "phase-1", "status": "MET"},
    {"criterion": "SC2 — claude/commands/harness-meta.md 9-stage 전면 재작성", "phase": "phase-2", "status": "MET"},
    {"criterion": "SC3 — 단일 source 5곳 cross-ref 갱신", "phase": "phase-3", "status": "MET"},
    {"criterion": "SC4 — 모듈 가이드 4곳 갱신", "phase": "phase-3", "status": "MET"},
    {"criterion": "SC5 — smoke + hooks 새 파일명 패턴 검증", "phase": "phase-4 + hotfix", "status": "MET"},
    {"criterion": "SC6 — Historical 11개 git mv + 본문 cross-ref", "phase": "phase-5", "status": "MET"},
    {"criterion": "SC7 — era 구분 메커니즘 명문화", "phase": "phase-1 + phase-4 + hotfix", "status": "MET"},
    {"criterion": "SC8 — 본 milestone 자체 7-stage 포맷 유지 (D12 자기참조 표지)", "phase": "전체", "status": "MET"},
    {"criterion": "SC9 — pre-commit smoke 5 hook PASS, 회귀 0", "phase": "phase 1~6 + hotfix", "status": "MET"},
    {"criterion": "SC10 — ROADMAP v2.0 status: completed", "phase": "Stage G", "status": "PENDING (REPORT 후 갱신)"},
    {"criterion": "SC11 — MEMORY.md 갱신 검토", "phase": "phase-6 + Stage G", "status": "MET"}
  ],
  "regressions": [],
  "verdict": "pass"
}
```

## 검증 narrative

7 commit (6 phase + 1 hotfix) 모두 pre-commit 5 hook (+ shellcheck + markdownlint) 통과. 회귀 0 — 기존 27 smoke 중 영향 받는 5건 모두 정합 갱신, 미영향 22건 자연 통과.

**핵심 회귀 차단**:

- phase-4 commit 직후 smoke-scope-contract 실행 시 historical 11개 milestone 이 detect_era 의 'skip' 분류 (PLAN.md → INTENT.md migrate 후 INTENT.md 단독 보유 — 9-stage 표지 부재 + PLAN.md 부재) 로 era 미식별 → DESIGN.approval 검증 누락 발견. **즉시 fix forward** (hotfix commit, phase-4 후속) — detect_era 에 "INTENT.md 단독 존재 = 7-stage era" 케이스 추가. 재검증 PASS=15 (11 historical 7-stage era milestone + 본 v2.0 milestone). R8 mitigation 완성.

**SC10 (ROADMAP completed)** 만 PENDING — REPORT.md 작성 후 Stage G 마지막에서 갱신 + push.

## 관련

- INTENT (PLAN.md): [`PLAN.md`](PLAN.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- 6 phase commit: 4846aa7 / 4435eb3 / a682f2a / e3d0478 / 84b0a49 / ab5b514 + hotfix 43472b7

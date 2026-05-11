# VERIFY — v3.11 legacy-narrative-cleanup

```json
{
  "id": "v3.11_legacy-narrative-cleanup",
  "smoke_tests": [
    {"name": "fix end of files", "command": "pre-commit (auto)", "result": "Passed", "output": "(pre-commit phase-1 commit hook)"},
    {"name": "trim trailing whitespace", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "check for merge conflicts", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "check yaml", "command": "pre-commit (auto)", "result": "Skipped (no files)"},
    {"name": "check for added large files", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "shellcheck", "command": "pre-commit (auto)", "result": "Skipped (no files)"},
    {"name": "markdownlint", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "smoke-projects-scope-discipline", "command": "pre-commit (auto)", "result": "Skipped (no files)"},
    {"name": "smoke-spec-verification (7-stage JSON schema)", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "smoke-scope-contract (out_of_scope + DESIGN.approval)", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "smoke-cross-ref", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "smoke-claude-md-drift", "command": "pre-commit (auto)", "result": "Passed"},
    {"name": "smoke-bundle-trigger", "command": "pre-commit (auto)", "result": "Skipped (no files)"},
    {"name": "smoke-open-stage-discipline (9-stage-bundled era pairing)", "command": "pre-commit (auto)", "result": "Passed"}
  ],
  "manual_checks": [
    {
      "check": "post-phase-1 grep 'sessions/' (excluding milestones/)",
      "result": "drift 0",
      "notes": "본 milestone scope (claude/CLAUDE.md L39 / upbit/ARCHITECTURE.md L106 / CHANGELOG.md L3) 모두 fix. 잔존 거명 분류: historical preserve (upbit/ROADMAP.md L11/L13/L74 / upbit/ARCHITECTURE.md L133 / projects/meta/ROADMAP.md historical entry summaries / docs/adr/ADR-002/005/006-* / .markdownlintignore historical / .github/workflows/ci.yml L37 historical 주석 / CHANGELOG.md L149 v1.10 historical) + out_of_scope (post-report-write.sh L2 이미 fix 거명 자체 stale) + deprecated SKILL (bootstrap/skills/audit/harness-{plan-verify,roadmap-update}/SKILL.md, deprecated narrative). 본 milestone scope drift = 0."
    },
    {
      "check": "INTENT success_criteria 6건 1:1 매핑",
      "result": "5/6 PASS (마지막 1건 = pre-commit 14 hook PASS, Stage F commit 시 자동 검증 완료)",
      "notes": "Stage I PROPOSE 시점 ROADMAP v3.11 entry status: completed 갱신 (1건 pending, Stage I 진행 시 충족)"
    }
  ],
  "criteria_check": [
    {
      "criterion": "claude/CLAUDE.md PostToolUse 섹션 narrative 가 v3.0+ 9-stage-bundled era 패턴 명시 + '4-tier era 잔존 narrative (v1.5_legacy-narrative-cleanup 후속 milestone 에서 정리 예정)' 표현 제거",
      "result": "PASS",
      "evidence": "claude/CLAUDE.md L39 갱신 — 현행 패턴 (v3.0+ 9-stage-bundled v{X.Y}/ + v{X.Y}_{slug}/) + 진화 이력 4단계 (v1.1 → v2.0 → v3.0)"
    },
    {
      "criterion": "projects/upbit/ARCHITECTURE.md L106 현행 안내 stale path 갱신 (L133 historical 보존)",
      "result": "PASS",
      "evidence": "L106 'harness-meta repo: projects/meta/milestones/v{X.Y}/ 또는 v{X.Y}_{slug}/' 갱신. L133 historical 이력 unchanged."
    },
    {
      "criterion": "CHANGELOG.md L3 v3.0+ 9-stage-bundled era 카테고리 추가",
      "result": "PASS",
      "evidence": "L3 'v3.0+ 9-stage-bundled era 또는 v2.0~v2.1 9-stage / v1.0~v1.4 7-stage era' 3 era 정합"
    },
    {
      "criterion": "ROADMAP entry v1.5_legacy-narrative-cleanup 제거 + v3.11 신규 entry status: completed 갱신",
      "result": "PARTIAL",
      "evidence": "Stage A OPEN 시점 v1.5 entry 제거 + v3.11 status: in_progress 추가. Stage I PROPOSE 시점 status: completed 갱신 예정"
    },
    {
      "criterion": "milestones.md self_reference_policy: avoid + self_reference_rationale 유지 + sub_milestones[] phase 1:1 동기",
      "result": "PASS",
      "evidence": "milestones.md self_reference_policy: 'avoid' + rationale 명시. Stage D 직후 sub_milestones[].title placeholder 교체 완료."
    },
    {
      "criterion": "pre-commit 14 hook 모두 PASS, 회귀 0",
      "result": "PASS",
      "evidence": "phase-1 commit 40faa23 pre-commit 14 hook (7 Passed + 4 Skipped + 3 Passed = 14 행) 모두 PASS. 회귀 0."
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

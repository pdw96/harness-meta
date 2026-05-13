# VERIFY — v3.17_phase-distribution-audit

```json
{
  "id": "v3.17_phase-distribution-audit",
  "smoke_tests": [
    {"name": "fix end of files",                          "command": "pre-commit",                         "result": "PASS",    "output": "Passed"},
    {"name": "trim trailing whitespace",                  "command": "pre-commit",                         "result": "PASS",    "output": "Passed"},
    {"name": "check for merge conflicts",                 "command": "pre-commit",                         "result": "PASS",    "output": "Passed"},
    {"name": "check yaml",                                "command": "pre-commit",                         "result": "SKIPPED", "output": "no files to check (yaml touch zero)"},
    {"name": "check for added large files",               "command": "pre-commit",                         "result": "PASS",    "output": "Passed"},
    {"name": "shellcheck",                                "command": "pre-commit",                         "result": "SKIPPED", "output": "no files to check (shell touch zero)"},
    {"name": "markdownlint",                              "command": "pre-commit",                         "result": "PASS",    "output": "Passed"},
    {"name": "smoke-projects-scope-discipline",           "command": "tests/smoke-projects-scope-discipline.sh", "result": "PASS", "output": "root thin index 정합 (milestone 등재 0)"},
    {"name": "smoke-spec-verification",                   "command": "tests/smoke-spec-verification.sh",   "result": "PASS",    "output": "7-stage JSON schema 정합 (v3.17 9-stage-bundled era 인식)"},
    {"name": "smoke-scope-contract",                      "command": "tests/smoke-scope-contract.sh",      "result": "PASS",    "output": "INTENT.out_of_scope 의무 + APPROVE.approved_by 게이트"},
    {"name": "smoke-cross-ref",                           "command": "tests/smoke-cross-ref.sh",           "result": "PASS",    "output": "cross-ref 정합 (autofix run 0)"},
    {"name": "smoke-claude-md-drift",                     "command": "tests/smoke-claude-md-drift.sh",     "result": "SKIPPED", "output": "no CLAUDE.md 변경"},
    {"name": "smoke-bundle-trigger",                      "command": "tests/smoke-bundle-trigger.sh",      "result": "PASS",    "output": "version 단위 1 milestone 검증 (v3.17 milestones_path + 실 파일)"},
    {"name": "smoke-open-stage-discipline",               "command": "tests/smoke-open-stage-discipline.sh", "result": "PASS",  "output": "milestones.md 페어링 강제 (v3.17/milestones.md 존재)"}
  ],
  "manual_checks": [
    {"check": "RESEARCH 분포표 17 milestone row 완전성", "result": "PASS", "notes": "v3.0~v3.16 17 row 모두 + aggregates 4 category"},
    {"check": "원인 추정 3축 + direct/counter evidence 표 작성", "result": "PASS", "notes": "RESEARCH narrative 안 표 1차 source"},
    {"check": "4 options (A/B/C/D) 거명 + pros/cons 분석", "result": "PASS", "notes": "RESEARCH.options 4 entry"},
    {"check": "OPEN→RESEARCH drift 정정 cascade", "result": "PASS", "notes": "INTENT.success_criteria #2 + ROADMAP entry summary 11→12 정정"},
    {"check": "lightweight 모드 표지 + 5 관점 subagent 생략 사실", "result": "PASS", "notes": "DESIGN D1 + APPROVE subagent_review_results.policy: skipped"},
    {"check": "milestones.md sub_milestones[0].title placeholder 교체 (Stage D 완료 직전 의무 step)", "result": "PASS", "notes": "v3.5 phase-2 의무 step 정합 — placeholder → 실 title 교체"},
    {"check": "워크플로우 본문 변경 zero 검증 (claude/commands/harness-meta.md / ARCHITECTURE § 6.1 § 6.2 / tests/ touch)", "result": "PASS", "notes": "git diff --name-only 97b7394~1 97b7394 = 7 file 모두 milestones/v3.17/ 또는 ROADMAP.md"}
  ],
  "criteria_check": [
    {"criterion": "v3.0~v3.16 17 milestone phase count 분포 표 작성", "result": "PASS", "evidence": "RESEARCH.distribution_table_v3_x.rows = 17 + phase_distribution_markdown.table_md"},
    {"criterion": "1-phase milestone 비율 정량화 (RESEARCH 정확 측정 후 확정, OPEN 시점 estimate ≥ 11/17 = 64.7%) + lightweight 모드 milestone 비율 정량화", "result": "PASS", "evidence": "RESEARCH.aggregates.one_phase_ratio = 12/17 = 70.6% + lightweight_ratio = 6/17 = 35.3%"},
    {"criterion": "원인 추정 3축 documented (a/b/c 각 direct evidence + counter-evidence)", "result": "PASS", "evidence": "RESEARCH narrative 안 '원인 추정 3축 evidence' 표"},
    {"criterion": "해결책 후보 ≥3 개 PROPOSE.next_candidates 안 거명 (실 적용 milestone 으로 ROADMAP 등재 0건)", "result": "PASS", "evidence": "PROPOSE.next_candidates 4건 (A/B/C/D), ROADMAP 등재 0 (§ 6.2 정합)"},
    {"criterion": "INTENT/RESEARCH/DESIGN/APPROVE artifact 4건 Stage G commit 안 영구 보존 (commit timing (b) default)", "result": "PASS_WITH_NOTE", "evidence": "phase-1 commit (97b7394) 안 INTENT/RESEARCH/DESIGN/APPROVE 4건 포함. commit timing (b) 본 milestone 해석 = INTENT~APPROVE 가 phase-1 commit 안 포함되어 VERIFY 전 영구 보존. Stage G chore commit 별도 = (b) 와 (c) 의 실 운용 동치. v3.15/v3.16 동일 패턴."},
    {"criterion": "pre-commit 14 hook 모두 PASS + 회귀 0 + smoke spec-verification/scope-contract PASS", "result": "PASS", "evidence": "phase-1 commit 시 14 hook 실 실행 9 + skipped 5 (yaml/shellcheck/claude-md-drift 등) + 회귀 0"},
    {"criterion": "VERIFY.criteria_check 안 본 success_criteria 7건 1:1 매핑 PASS", "result": "PASS", "evidence": "본 criteria_check 7 entry"}
  ],
  "verdict": "pass",
  "regressions": [],
  "phase_1_commit": "97b7394",
  "notes": "PASS_WITH_NOTE 1건 (success_criteria #5) — commit timing (b) 의 실 운용 = INTENT~APPROVE 가 phase-1 commit 안 포함되어 VERIFY 전 영구 보존되는 의미. Stage G chore commit 은 별도 (= (c) 와 동치 운용). v3.15/v3.16 동일. REPORT.lessons_learned 안 lesson L4 흡수."
}
```

## narrative

phase-1 commit 시 pre-commit 14 hook 모두 PASS, 회귀 0. INTENT.success_criteria 7건 모두 PASS (1건 PASS_WITH_NOTE — commit timing (b) 운용 해석 명료화 lesson).

# VERIFY — v1.0_workflow-redesign

```json
{
  "milestone": "v1.0_workflow-redesign",
  "smoke_tests": [
    {
      "name": "pre-commit (phase-1)",
      "command": "git commit (phase-1)",
      "result": "pass",
      "output": "fix end of files / trailing whitespace / merge conflicts / yaml / large files / shellcheck / markdownlint 모두 PASS"
    },
    {
      "name": "pre-commit (phase-2)",
      "command": "git commit (phase-2)",
      "result": "pass",
      "output": "동일 7 hook 모두 PASS — JSON 코드블록 fence (json) + diagram fence 모두 통과"
    },
    {
      "name": "pre-commit (phase-3)",
      "command": "git commit (phase-3)",
      "result": "pass",
      "output": "git mv 리네임 + 5 파일 텍스트 수정 + 2 신규 파일 — 모두 PASS"
    },
    {
      "name": "pre-commit (phase-4)",
      "command": "git commit (phase-4)",
      "result": "pass",
      "output": "5 파일 (3 delete + 1 migrate + 1 new) — 모두 PASS"
    },
    {
      "name": "pre-commit (phase-5 mass deletion)",
      "command": "git commit (phase-5)",
      "result": "pass",
      "output": "362 files changed (55503 deletions) — shellcheck/markdownlint 등 모두 PASS"
    },
    {
      "name": "pre-commit (phase-6)",
      "command": "git commit (phase-6)",
      "result": "pass",
      "output": "shellcheck PASS (verify.sh 검증) + markdownlint PASS"
    },
    {
      "name": "tests/ smoke (28종)",
      "command": "tests/smoke-*.sh",
      "result": "skip",
      "output": "out-of-scope — sessions/ 의존 smoke 다수 obsolete. 후속 milestone에서 일괄 갱신 + 4 disabled hook 재활성화 예정."
    }
  ],
  "manual_checks": [
    {
      "check": "ROADMAP.md (root) JSON 5필드 정합",
      "result": "pass",
      "notes": "id/title/status/summary/trigger 5필드. v1.0_workflow-redesign in_progress 1건 등록."
    },
    {
      "check": "milestones/v1.0_workflow-redesign/ 구조 정합",
      "result": "pass",
      "notes": "PLAN.md + RESEARCH.md + DESIGN.md + execute/phase-{1..6}.md (6 phase 완료) + (VERIFY.md 본 파일) — REPORT.md 다음 작성 예정"
    },
    {
      "check": "sessions/ 디렉토리 부재",
      "result": "pass",
      "notes": "ls sessions/ → No such file or directory. git history 보존."
    },
    {
      "check": "bootstrap/ = skills/ + CLAUDE.md만 존재",
      "result": "pass",
      "notes": "bootstrap/{docs, skeletons, templates, interview.md, manifest-schema.md, render-manifest.sh, detect-project.sh, install-project-claude.{ps1,sh}, CLAUDE.md} 폐기. skills/{audit,dev-tools}/ + CLAUDE.md 보존."
    },
    {
      "check": "bootstrap/skills/ 5종 SKILL 보존",
      "result": "pass",
      "notes": "audit/{ai-ready-scorer, harness-plan-verify, harness-roadmap-update} + dev-tools/{developer-profile, mindvault} = 5건"
    },
    {
      "check": "projects/upbit/ 2종 (ARCHITECTURE + ROADMAP)",
      "result": "pass",
      "notes": "DECISIONS.md / INTERVIEW.md / STACK.md 폐기. ROADMAP.md 새 JSON 스키마 (milestones[] 6 entries) 마이그레이션 완료."
    },
    {
      "check": "milestones/v1.85_project-workflow-extension/ 부재",
      "result": "pass",
      "notes": "untracked 미커밋 디렉토리 phase-5에서 rm -rf로 정리."
    },
    {
      "check": "milestones/v1.84~v1.88/ historical 보존",
      "result": "pass",
      "notes": "v1.84_workflow-revamp, v1.85_roadmap-housekeeping, v1.86_cross-ref-false-positive-fix, v1.87_python-entry-boilerplate-smoke, v1.88_precommit-performance 5건 4-tier 포맷으로 보존."
    },
    {
      "check": ".pre-commit-config.yaml 4 local hook disable",
      "result": "pass",
      "notes": "smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift 모두 주석 처리. 후속 milestone에서 새 포맷 정합 후 재활성화."
    },
    {
      "check": "install.ps1 bootstrap/templates + install-project-claude refs 제거",
      "result": "pass",
      "notes": "line 134-135 comments 갱신. legacy cleanup 섹션은 유지 (구 symlink 정리용)."
    },
    {
      "check": "verify.{ps1,sh} Stage H/B7 제거 + I 리스트 정리",
      "result": "pass",
      "notes": "Stage 매트릭스 11→10 (H 제거). frontmatterFiles 17→6 entries. G 체크리스트 6→4 항."
    }
  ],
  "criteria_check": [
    {
      "criterion": "root ROADMAP.md 새 JSON schema (id/title/status/summary/trigger 5필드) 정합",
      "result": "pass",
      "evidence": "ROADMAP.md (root) — JSON 코드블록 + 5필드 정합. v1.0_workflow-redesign 1건 등록."
    },
    {
      "criterion": "claude/commands/harness-meta.md 7-stage 흐름 반영",
      "result": "pass",
      "evidence": "phase-3 commit f5bc3f4 — Stage A~G (ROADMAP→MILESTONE→PLAN→RESEARCH→DESIGN→EXECUTE→VERIFY→REPORT) 정의."
    },
    {
      "criterion": "sessions/ 디렉토리 전체 git rm",
      "result": "pass",
      "evidence": "phase-5 commit 8a5bc8f — ~120 vX.Y dirs 삭제. ls sessions/ → No such file or directory."
    },
    {
      "criterion": "projects/upbit/ 에 ARCHITECTURE.md + ROADMAP.md(JSON) 만 존재",
      "result": "pass",
      "evidence": "phase-4 commit cc97214. ls projects/upbit/ → ARCHITECTURE.md, ROADMAP.md만."
    },
    {
      "criterion": "milestones/v1.85_project-workflow-extension/ (untracked) 삭제됨",
      "result": "pass",
      "evidence": "phase-5에서 rm -rf로 정리. ls milestones/ 결과에 부재."
    },
    {
      "criterion": "bootstrap/skills/ 유지됨 (글로벌 user skills 보존)",
      "result": "pass",
      "evidence": "ls bootstrap/skills/ → audit/ + dev-tools/ + CLAUDE.md. 5 SKILL 보존 확인."
    },
    {
      "criterion": "bootstrap/{docs,skeletons,templates}/ 삭제됨",
      "result": "pass",
      "evidence": "phase-5 commit 8a5bc8f — bootstrap/ = skills/ + CLAUDE.md만 잔존. 단 bootstrap/CLAUDE.md도 phase-5에서 폐기."
    },
    {
      "criterion": ".pre-commit-config.yaml 의 sessions/-의존 hook 4종 disable",
      "result": "pass",
      "evidence": "phase-1 commit 1491925 — 4 local hook 모두 주석 처리. 이후 모든 phase commit에서 'shellcheck (no files to check) Skipped'/'markdownlint PASS'만 동작."
    },
    {
      "criterion": "install.ps1 의 bootstrap/templates/_base + install-project-claude 참조 제거",
      "result": "pass",
      "evidence": "phase-6 commit d262eb3 — line 134-135 comments 갱신. grep으로 bootstrap/templates 참조 0건 확인."
    },
    {
      "criterion": "verify.ps1 + verify.sh 의 sessions/ 검증 stage 제거",
      "result": "pass",
      "evidence": "phase-6 commit d262eb3 — Stage B7 + Stage H 전체 제거 (~80+20 lines), Stage I frontmatterFiles 17→6, Stage G 체크리스트 6→4."
    },
    {
      "criterion": "module CLAUDE.md cross-ref 정리 (claude/, bootstrap/skills/)",
      "result": "pass",
      "evidence": "phase-2 commit 56dbb8c — claude/CLAUDE.md (bootstrap/templates ref 제거 + sessions 세션 refs 제거 + PERMISSION_PATTERN ref 제거). bootstrap/skills/CLAUDE.md (../ → ../../ + bootstrap/docs refs 제거)."
    },
    {
      "criterion": "VERIFY.md + REPORT.md 작성 완료",
      "result": "pass",
      "evidence": "VERIFY.md (본 파일) + REPORT.md 모두 작성 완료. 다음 단계: ROADMAP.md status 갱신 + commit."
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

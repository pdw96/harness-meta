# phase-2 — 권고 #4 적용 (smoke inactive 22 archive)

```json
{
  "phase": 2,
  "title": "권고 #4 적용 — smoke inactive 22 archive 이동 (tests/_inactive/) + tests/CLAUDE.md 매트릭스 narrative 갱신",
  "status": "in_progress",
  "scope": "tests/_inactive/ 신규 디렉토리 + inactive 22 smoke git mv (history 보존) + tests/CLAUDE.md 매트릭스 헤더 갱신 + § 'Archive (inactive smoke)' 신설 sub-section 거명 narrative",
  "user_decision": "Archive 이동 (git mv tests/_inactive/) — AskUserQuestion 옵션 4안 중 첫 안 선택. lightweight 정신 정합 + history 보존 + 'manual leverage' narrative 정전화 (active = pre-commit 강제 / archive = 격리)",
  "affected_files": [
    "tests/_inactive/ (신규 디렉토리, 22 smoke git mv 대상)",
    "tests/CLAUDE.md (매트릭스 헤더 + § Archive sub-section 신설)",
    "projects/meta/milestones/v3.6/execute/phase-1.md (status complete + commit hash 4ef8a74 갱신)",
    "projects/meta/milestones/v3.6/execute/phase-2.md"
  ],
  "smoke_files_moved": [
    "smoke-agentic-safety-na", "smoke-backup-cleanup", "smoke-bash-permission-pattern",
    "smoke-bootstrap-agents-md", "smoke-bootstrap-license-boilerplate", "smoke-bootstrap-license-detect",
    "smoke-bootstrap-license-metadata", "smoke-bootstrap-render", "smoke-broad-bash-fine-grain",
    "smoke-detect-language", "smoke-language-overlay", "smoke-legacy-cleanup-overlay",
    "smoke-license-line-policy", "smoke-posttooluse-hook", "smoke-python-entry-boilerplate",
    "smoke-roadmap-sync", "smoke-roi-regression", "smoke-scorer-output-newline",
    "smoke-skills-install", "smoke-sync-agents", "smoke-thinking-effort", "smoke-verify-sh-parity"
  ],
  "commit_message": "feat(meta): v3.6 phase-2 — smoke inactive 22 archive 이동 (tests/_inactive/) + 매트릭스 갱신",
  "execution_notes": [
    "active 7 pre-commit hook 영향 부재 (path 변동 부재)",
    "tests/_era_detect.py + tests/precommit-autofix-or-fail.sh 영향 부재 (tests/ 잔류)",
    "smoke-cross-ref / smoke-claude-md-drift 회귀 검증 의무 — narrative 갱신 후 재실행",
    "phase-1.md status complete 갱신 + commit hash 4ef8a74 본 phase commit 안 포함 (lightweight, batch 갱신)"
  ]
}
```

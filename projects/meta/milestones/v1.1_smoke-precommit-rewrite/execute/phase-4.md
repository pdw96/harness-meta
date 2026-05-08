# EXECUTE phase-4 — pre-commit 4 hook 재활성화 + tests/CLAUDE.md 갱신

```json
{
  "phase": 4,
  "title": ".pre-commit-config.yaml 4 hook 재활성화 + tests/CLAUDE.md 갱신",
  "status": "in_progress",
  "changes": [
    {
      "file": ".pre-commit-config.yaml",
      "action": "edit",
      "description": "4 hook (smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift) 재활성화. files: 패턴 갱신. scope-discipline 블록 주석 갱신."
    },
    {
      "file": "tests/CLAUDE.md",
      "action": "edit",
      "description": "smoke 매트릭스 count 28→29 + hook table 갱신 (4 hook active 상태 반영) + 관련 문서 stale ref 5건 제거(Phase1에서 처리됨)."
    }
  ],
  "commit": null,
  "execution_notes": null
}
```

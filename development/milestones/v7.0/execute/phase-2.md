---
phase: phase-2
milestone: v7.0
status: completed
---

# v7.0 phase-2 — Tier 1: T1.5 Auto-Mode 최소권한

## Spec

```json
{
  "phase": "phase-2",
  "status": "completed",
  "scope": "Tier 1 (T1.5 Auto-Mode + subagent 최소권한 mechanism source-of-truth) 설치 — Tier 2/1.5 가 inherit 하는 base.",
  "changes": [
    {"type": "create", "path": ".claude/settings.json", "description": "autoMode 4 분류 (environment/allow/soft_deny/hard_deny) + $defaults inherit. repo-local (정정 #2, plugin manifest settings 필드 부재). permissions.defaultMode:auto 미포함 (활성 v7.1 보류, oos_3)."},
    {"type": "edit", "path": "projects/meta/ARCHITECTURE.md", "description": "§ 10 Auto-Mode 최소권한 + subagent frontmatter pattern 신규 (§ 10.1 4 분류 + § 10.2 3 subagent 매트릭스 + § 10.3 AI Native § 7 cross-ref)."},
    {"type": "edit", "path": "CLAUDE.md", "description": "§ 구조 규칙 — Auto-Mode 최소권한 entry pointer 1줄."}
  ],
  "verification": [
    {"method": "settings.json JSON valid", "result": "PASS", "detail": "autoMode 4 array 구조 유효"},
    {"method": "pre-commit", "result": "PASS", "detail": "전체 hook PASS"}
  ],
  "commit": {"sha": "7e83ce7", "message": "feat(meta): v7.0 T1.5 Auto-Mode 최소권한 mechanism (설치만, 활성 v7.1 보류)"}
}
```

## Narrative

본 phase-2 = Tier 1 (T1.5) — Auto-Mode mechanism source-of-truth 단일 책임. `.claude/settings.json` autoMode 4 분류 (environment trusted path + allow 허용 + soft_deny prompt 게이트 + hard_deny 절대 금지) repo-local 거주 (정정 #2). **defaultMode:auto 미포함** = mechanism 설치만, 활성 v7.1 보류 (oos_3 + 사용자 '커밋·배포 전 확인' 협업 본질). ARCHITECTURE § 10 = mechanism 정의 단일 source — 실 적용 = Tier 2 (T1.3 design-review read-only) + Tier 1.5 (T1.6b version-tracker allow/soft_deny) 각자 inherit.

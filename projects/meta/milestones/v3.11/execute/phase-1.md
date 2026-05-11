# Phase 1 — 3위치 stale narrative 일괄 갱신

```json
{
  "phase": 1,
  "title": "3위치 stale narrative 일괄 갱신 (claude/CLAUDE.md L39 + upbit/ARCHITECTURE.md L106 + CHANGELOG.md L3)",
  "status": "complete",
  "affected_files": [
    "claude/CLAUDE.md",
    "projects/upbit/ARCHITECTURE.md",
    "CHANGELOG.md",
    "projects/meta/milestones/v3.11/execute/phase-1.md"
  ],
  "scope": "narrative 갱신 only — 패턴/코드 변경 부재. 3 파일 1 commit atomic.",
  "execution_notes": [
    "claude/CLAUDE.md L39 갱신 — '기존 패턴은 sessions/.../REPORT + PLAN.md$ 기반 (4-tier era 잔존 narrative — 정리 예정)' → '현행 패턴 (v2.0+ 9-stage 이후): v3.0+ 9-stage-bundled era v{X.Y}/ + v{X.Y}_{slug}/ (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage 보존)'. 진화 이력 4단계 (v1.1 → v2.0 → v3.0) 명시.",
    "projects/upbit/ARCHITECTURE.md L106 갱신 — 'harness-meta/sessions/upbit/vX.Y-{name}/' → 'harness-meta repo: projects/meta/milestones/v{X.Y}/ 또는 v{X.Y}_{slug}/'. v3.0+ era + v2.0~v2.1/v1.x 보존 era 동시 거명.",
    "CHANGELOG.md L3 갱신 — 'v2.0+ 9-stage era 또는 v1.0~v1.4 7-stage era' → 'v3.0+ 9-stage-bundled era 또는 v2.0~v2.1 9-stage / v1.0~v1.4 7-stage era'. 3 era 카테고리 정합화."
  ]
}
```

## 갱신 대상

1. **claude/CLAUDE.md L39** PostToolUse 섹션 narrative — 4-tier era 잔존 narrative + '정리 예정' 표현 제거, v3.0+ 9-stage-bundled era 정합 패턴 명시
2. **projects/upbit/ARCHITECTURE.md L106** `/harness-meta` 안내 stale path — `harness-meta/sessions/upbit/vX.Y-{name}/` → `harness-meta repo: projects/meta/milestones/v{X.Y}/ 또는 v{X.Y}_{slug}/`
3. **CHANGELOG.md L3** detailed change records 경로 narrative — v3.0+ 9-stage-bundled era 카테고리 추가

## Commit 시점 정책 (v3.1 L6, b 패턴)

INTENT/RESEARCH/DESIGN/APPROVE/milestones.md 4종 + execute/phase-1.md = Stage G VERIFY commit 안 포함 (산출물 영구 보존 보장).

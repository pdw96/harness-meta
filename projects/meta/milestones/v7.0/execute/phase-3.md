---
phase: phase-3
milestone: v7.0
status: completed
---

# v7.0 phase-3 — Tier 2: T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬

## Spec

```json
{
  "phase": "phase-3",
  "status": "completed",
  "scope": "Tier 2 (T1.3 DESIGN review 재설계 + T2.3 RESEARCH Explore 병렬) 한 commit 설치 — 사용자 결정 (§ 11 거주 + 한 commit, AskUserQuestion G3).",
  "changes": [
    {"type": "create", "path": "agents/design-review.md", "description": "design-review subagent — read-only (Read/Grep/Glob), opus, perspectives parameterized. N+가변 분야 review + scope 안/외 분리 산출."},
    {"type": "edit", "path": "claude/commands/harness-meta.md", "description": "Stage D 고정 5관점 → N+가변 + scope 안/외 분리 + design-review invoke (정정 #5 — 1 invoke N 관점 순차 통합, subagent 중첩 불가) + Stage C RESEARCH cb 분야 Explore parallel 매핑 + prompt template (T2.3)."},
    {"type": "edit", "path": "projects/meta/ARCHITECTURE.md", "description": "§ 11 분야 발현 mechanism (RESEARCH cb / DESIGN review 공유 pattern + scope 크기 매트릭스 + 작업 본질 type 매트릭스 + SCOPE_OUT_NOTES 부산물 cycle 차단) 신규 + § 10.2 'review (미생성)' → 'design-review (생성)' 갱신."},
    {"type": "edit", "path": "skills/stage-open/SKILL.md", "description": "MILESTONE.md skeleton 조건부 ## SCOPE_OUT_NOTES (정정 #8 — 거명 있을 때만, 고정 10 H2 아님)."},
    {"type": "edit", "path": "CLAUDE.md", "description": "H2 skeleton 표기 + 조건부 SCOPE_OUT_NOTES."},
    {"type": "edit", "path": "projects/meta/CLAUDE.md", "description": "H2 skeleton 표기 + 조건부 SCOPE_OUT_NOTES."}
  ],
  "verification": [
    {"method": "smoke-agent-frontmatter-schema", "result": "PASS", "detail": "design-review.md frontmatter (Agent(...) literal 부재 → no-op 검사 통과)"},
    {"method": "smoke-spec-verification", "result": "PASS", "detail": "조건부 SCOPE_OUT_NOTES 무해 (필수 8 stage 섹션 존재만 검사, PASS=426 FAIL=0)"},
    {"method": "smoke-cross-ref", "result": "PASS", "detail": "신규 상대링크 (design-review.md / § 11) broken 0건"},
    {"method": "pre-commit", "result": "PASS", "detail": "전체 hook PASS"}
  ],
  "commit": {"sha": "f28375b", "message": "feat(meta): v7.0 Tier 2 — T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬 (설치만)"}
}
```

## Narrative

본 phase-3 = Tier 2 (T1.3 + T2.3) 한 commit (AskUserQuestion G3 사용자 결정 — § 11 거주 + 한 commit). T1.3 = 고정 5관점 폐기 → N+가변 (작업 본질 + scope 크기 자연 발현 3~10) + design-review subagent (perspectives parameterized, read-only, subagent 중첩 불가 = 1 invoke N 관점 순차 통합, 정정 #5) + scope 외 = 조건부 ## SCOPE_OUT_NOTES (정정 #8). T2.3 = RESEARCH cb 분야 Explore parallel 매핑 + Explore prompt template. 양쪽 공유 mechanism = ARCHITECTURE § 11 (작업 본질 type 매트릭스, 사용자 결정 거주). smoke 5관점 정정 = 헛작업 삭제 (정정 #5 — smoke 에 5관점 logic 부재).

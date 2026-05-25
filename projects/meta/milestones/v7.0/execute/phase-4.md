---
phase: phase-4
milestone: v7.0
status: completed
---

# v7.0 phase-4 — Tier 3: T1.2 next_candidates 절제 + lessons P2 자동 enumerate 폐지

## Spec

```json
{
  "phase": "phase-4",
  "status": "completed",
  "scope": "Tier 3 (T1.2 next_candidates 절제 + lessons P2/P3 자동 enumerate 폐지) 설치 — 33 next_candidates 일괄 폐기 (AskUserQuestion G5 사용자 명시 결정).",
  "changes": [
    {"type": "edit", "path": "scripts/propose_next.py", "description": "LESSONS_P2_REGEX + grep_lessons_p2() + lessons_p2_count 출력 + docstring lessons 언급 제거. 후보 source = ROADMAP + 최근 5 PROPOSE only (정정 #6 — script count-only였음, smoke Stage 2 미참조 확인)."},
    {"type": "edit", "path": "projects/meta/ROADMAP.md", "description": "next_candidates 33건 → [] (bracket-aware, 부산물 cycle 누적 임시 후보 git history 보존) + schema_note 보강 (자동 append 폐지) + internal_synthesis 정의 정정. deferred 3 + candidate_draft 1 보존."},
    {"type": "edit", "path": "claude/commands/propose-next.md", "description": "lessons P2 용어집 + internal_synthesis 정의 2곳 정정."},
    {"type": "edit", "path": "claude/commands/harness-meta.md", "description": "Stage I — next_candidates 등재 = 사용자 명시 결정 게이트 후만 (자동 append 폐지)."},
    {"type": "edit", "path": "skills/stage-propose/SKILL.md", "description": "next_candidates append 게이트 note (사용자 명시 결정 후만)."},
    {"type": "edit", "path": "projects/meta/ARCHITECTURE.md", "description": "§ 4 #9 (cascade source, anchor section-4-end-row-9) — lessons P2 자동 종합 폐지 + 자동 append 폐지 narrative."},
    {"type": "edit", "path": "CLAUDE.md", "description": "#9 host blockquote 동기 (lessons P2 제거) + cascade_sync.py --apply hash 재동기 (2313949d → dbc51f0)."}
  ],
  "verification": [
    {"method": "propose_next.py 실행", "result": "PASS", "detail": "JSON valid, lessons_p2_count 키 제거, 잔존 참조 0"},
    {"method": "smoke-candidate-draft-schema", "result": "PASS", "detail": "Stage 2 propose_next.py --scan 실행 (candidate_items 3필드 + dedupe_stats 4필드) PASS"},
    {"method": "smoke-cascade-drift", "result": "PASS", "detail": "#9 hash 재동기 후 'all 1 host(s) in sync'"},
    {"method": "smoke-entry-title-guideline", "result": "PASS", "detail": "next_candidates wipe 후 title 검사 PASS"},
    {"method": "pre-commit", "result": "PASS", "detail": "전체 hook PASS"}
  ],
  "commit": {"sha": "857a85b", "message": "feat(meta): v7.0 Tier 3 — T1.2 next_candidates 절제 + lessons P2 자동 enumerate 폐지"}
}
```

## Narrative

본 phase-4 = Tier 3 (T1.2) — 부산물 cycle (review 거명 → lessons 자동 enumerate → next_candidates 자동 append → 재생산) 폐지. 정정 #6 검증 — propose_next.py 는 lessons count-only였고 skills/propose-next 는 부재 → 실 등가물 (claude/commands/propose-next.md) 에 적용 (헛작업 회피). script lessons grep/count 제거 + narrative 정정 (propose-next.md / Stage I / stage-propose) + ROADMAP next_candidates 33건 일괄 폐기 (AskUserQuestion G5 사용자 명시, git history 보존, deferred 3 + candidate_draft 1 별개 보존). ARCHITECTURE § 4 #9 = cascade source → CLAUDE.md host blockquote 수동 동기 + cascade_sync.py --apply hash 재동기 (2313949d → dbc51f0) + smoke-cascade-drift 검증.

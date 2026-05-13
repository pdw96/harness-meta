# phase-7 — 벤치마크 cycle routine (schedule skill 주 1회)

```json
{
  "phase": 7,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "벤치마크 cycle routine — schedule skill 주 1회 cron (GitHub 인기 repo + Claude Code release notes) + ROADMAP candidate_draft[] 산출물 host (D4)",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "projects/meta/ROADMAP.md schema_note 갱신 — candidate_draft[] 신 필드 정의 (entry schema = id/title/source/detected_at/rationale/category/decision_pending) 추가",
    "projects/meta/ROADMAP.md JSON 안 candidate_draft[] 신 필드 (빈 array, 벤치마크 routine 산출물 host)",
    "bootstrap/agents/CLAUDE.md § 벤치마크 cycle 확장 — placeholder → routine 등록 패턴 (schedule skill 호출 narrative) + 벤치마크 산출물 3축 + candidate draft entry 예시 JSON"
  ],
  "affected_files": [
    "projects/meta/ROADMAP.md (schema_note 갱신 + candidate_draft[] 신 필드)",
    "bootstrap/agents/CLAUDE.md (§ 벤치마크 cycle 확장 ~+45 line)"
  ],
  "criteria_met": {
    "INTENT_sc_10": "벤치마크 cycle routine — schedule skill 활용 주 1회 cron (GitHub 인기 repo + Claude Code release notes/changelog 검토). 산출물 = fleet evolution + conflict resolution proposal (e3 정책 자동 생성, 사용자 명시 결정 대기). 산출물 host = ROADMAP candidate_draft[] (D4 정합)"
  },
  "design_d4_compliance": "산출물 host = projects/meta/ROADMAP.md 안 candidate_draft[] 신 필드 (별도 host 분리 회피, ROADMAP schema 확장). schema_note 정전화 (spec-drift R2 흡수 — DESIGN review_perspectives 안 권고)"
}
```

## narrative

### Schedule skill 활용 (D4)

Claude Code 안 자연어 호출 → `schedule` skill 이 `~/.claude/scheduled_tasks` 안 cron entry 자동 생성. 본 repo 외부 — routine 정의는 사용자 환경 의존.

### Candidate draft entry schema (R2 흡수)

```json
{
  "id": "<candidate-slug>",
  "title": "<후보 title>",
  "source": "<GitHub URL 또는 docs URL>",
  "detected_at": "<YYYY-MM-DD>",
  "rationale": "<왜 도입 후보인지>",
  "category": "github-pattern | claude-code-update | fleet-evolution",
  "decision_pending": true
}
```

3 category:

- `github-pattern` — 외부 repo 패턴 차용 (예: OpenAI Swarm handoff, microsoft/autogen group chat)
- `claude-code-update` — Claude Code release notes 신규 built-in (4 case 매트릭스 자동 적용)
- `fleet-evolution` — 본 repo agent fleet 의 scope 확장/분할/통합/삭제 (5 case 매트릭스)

### E3 정책 정합

벤치마크 routine 산출물 = `candidate_draft[]` append (자동), 정식 milestone 등재 = 사용자 명시 결정 후 (수동). `decision_pending: true` flag 가 e3 게이트 표지.

## commit (pending 사용자 확인)

```
feat(meta): v4.0 phase-7 — 벤치마크 cycle routine + ROADMAP candidate_draft[] (D4)

projects/meta/ROADMAP.md schema_note 갱신 — candidate_draft[] entry schema 정전화
(id/title/source/detected_at/rationale/category/decision_pending). candidate_draft[]
신 필드 (빈 array, 벤치마크 routine 산출물 host).

bootstrap/agents/CLAUDE.md § 벤치마크 cycle 확장 — schedule skill 호출 패턴
(자연어 prompt 예) + 3 category (github-pattern/claude-code-update/fleet-evolution)
+ candidate draft entry 예시 JSON.
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (10)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) D4 + review_perspectives spec-drift R2
- projects/meta/ROADMAP.md (schema 확장): [`../../../ROADMAP.md`](../../../ROADMAP.md)
- bootstrap/agents/CLAUDE.md (§ 벤치마크 cycle): [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)

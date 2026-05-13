# phase-1 — 신규 standalone subagent 2 추가 (environment-auditor + agents-md-sync)

```json
{
  "phase": 1,
  "title": "신규 standalone subagent 2 추가 — environment-auditor + agents-md-sync",
  "status": "in_progress",
  "affected_files": [
    "bootstrap/agents/audit/environment-auditor.md",
    "bootstrap/agents/audit/agents-md-sync.md",
    "projects/meta/milestones/v4.2/execute/phase-1.md"
  ],
  "execution_notes": "DESIGN.phases[1] 정합. P2 옵션 (D1) + standalone .md 파일 (D2) + tools/model (D6 + D8) + Bash 화이트리스트 (D7 + D9) 모두 system prompt 안 반영. yaml frontmatter 4 필드 (name / description / tools / model) 의무 정합 + V1/V5/V7/V8/V10 frontmatter 검사 통과 (콜론 없음 / auto-allow set declare 0 / single-line 콤마 separator 없음 / thinking 필드 없음). environment-auditor system prompt — 10 stage 매트릭스 (Z/A/B/C/D/E/F/I/J/G) 전체 책임 + Bash 화이트리스트 (read-only) + 호출 trigger 자연어. agents-md-sync system prompt — 7 adapter mapping + SHA-256 drift detect (3단 fallback) + -Check default / -SourceWins 사용자 게이트 + Bash 화이트리스트 (read-only default + write 게이트 후).",
  "commit_message": "feat(meta): v4.2 phase-1 — environment-auditor + agents-md-sync 2 신규 standalone subagent (verify/sync agent 흡수)"
}
```

## 작업 결과

- `bootstrap/agents/audit/environment-auditor.md` 신규 (~150 LOC) — verify.{ps1,sh} + verify-lib.{ps1,sh} 의 10 stage 매트릭스 흡수
- `bootstrap/agents/audit/agents-md-sync.md` 신규 (~135 LOC) — sync-agents.{ps1,sh} 의 7 adapter SHA-256 drift detect + sync 흡수

## 관련

- DESIGN.phases[1]: [`../DESIGN.md`](../DESIGN.md)
- 단일 source bootstrap/agents/ 정책: [`../../../../bootstrap/agents/CLAUDE.md`](../../../../bootstrap/agents/CLAUDE.md)

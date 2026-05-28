# .claude/rules/ — operational index

본 디렉토리 = harness-meta **repo-local** path-scoped rule (Claude Code `.claude/rules/` mechanism, 2026-w13+). plugin manifest 에 `rules` 필드 부재 → 배포 안 됨 (harness-meta repo 안에서만 자동 inject).

CLAUDE.md (always-loaded entry) ↔ `.claude/rules/` (path-scoped mechanical rule) ↔ MEMORY (cross-session personal + cross-project 일반 원칙) **3-way 책임 직교** — 1차 source = [`../../development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 4.

## 2 rule file

| file | scope (paths) | 본질 |
|---|---|---|
| `schema-discipline.md` | `projects/*/milestones/**/{APPROVE,INTENT}.md` + `**/*.md` (cascade marker) | milestone 산출물 + cascade marker schema 의무 |
| `candidate-draft-schema.md` | `projects/*/ROADMAP.md` | candidate_draft[] decision_pending = string 본질 |

## MEMORY 유지 본질

audit fact-hallucination 검증 의무 = cross-project 일반 원칙 (모든 repo 의 Agent 호출 적용) → repo-local `.claude/rules/` 거주 부적합, MEMORY 유지 (정정 #3, ARCHITECTURE § 4 정합).

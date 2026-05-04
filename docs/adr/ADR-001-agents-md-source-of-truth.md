# ADR-001: AGENTS.md를 프로젝트 컨텍스트 source of truth로 채택

- **상태**: Accepted
- **날짜**: 2026-04-25
- **세션**: [sessions/meta/v1.5-agents-md-strategy/](../../sessions/meta/v1.5-agents-md-strategy/)

## 결정

각 프로젝트에 `AGENTS.md` 1개를 유일한 AI 컨텍스트 파일로 두고, `CLAUDE.md` / `GEMINI.md` / `.github/copilot-instructions.md` 등은 `AGENTS.md`의 symlink 또는 copy로 배포한다. Claude Code 전용 추가 지시는 `CLAUDE.override.md`로 분리한다.

## 배경

2026-04 기준 AGENTS.md는 Linux Foundation 산하 Agentic AI Foundation이 관리하는 오픈 표준으로 60,000+ 프로젝트가 채택. GitHub Copilot(2025-08~), Cursor, Gemini CLI, Windsurf, Codex CLI 등이 네이티브 지원. 반면 Claude Code만 미지원(이슈 #6235 진행 중).

도구별 컨텍스트 파일을 각자 유지하면:

- 동기화 실패 시 AI 도구마다 다른 규칙을 읽음
- 새 도구 추가마다 컨텍스트 파일 복제 필요

단일 source of truth + 도구별 symlink/copy 전략으로 이 문제를 해결.

## 결과

- 배포 전략: symlink (primary, Developer Mode ON) / copy (fallback, Windows 권한 미충족)
- `.agents/skills/` 표준 경로 채택 → Claude Code는 `.claude/skills/`로 junction/symlink
- Override 파일 중복 금지: `AGENTS.md` baseline + `CLAUDE.override.md` 추가 지시만
- 후속: v1.5b에서 harness-meta 자체에 AGENTS.md 적용, v1.8에서 adapter 분리 구조

## 관련 문서

- 상세 규약: [bootstrap/docs/AGENTS_MD_STRATEGY.md](../../bootstrap/docs/AGENTS_MD_STRATEGY.md)
- 매니페스트 `[agents]` 섹션: [bootstrap/manifest-schema.md](../../bootstrap/manifest-schema.md)

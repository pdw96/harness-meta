# ADR-004: frontmatter `allowed-tools:` 6축 통합 Permission 패턴

- **상태**: Accepted
- **날짜**: 2026-04-27 (v1.10d 5축) / 2026-04-27 (v1.10g A6 신설)
- **세션**: [sessions/meta/v1.10d-bash-permission-pattern-audit/](../../sessions/meta/v1.10d-bash-permission-pattern-audit/) + [sessions/meta/v1.10g-skill-thinking-effort/](../../sessions/meta/v1.10g-skill-thinking-effort/)

## 결정

본 repo의 모든 SKILL/command frontmatter + settings.json은 6축 통합 정책을 따른다:

| 축 | 결정 |
|----|------|
| A1 필드명 | slash command/skill = `allowed-tools:` / subagent = `tools:` |
| A2 separator | YAML list 권장 (콤마 비권장) |
| A3 패턴 형식 | `Bash(cmd *)` 공백 (word-boundary 보장) |
| A4 redundant | 자동 허용 set(`ls`, `grep`, `git status` 등) declare 금지 |
| A5 argument | Conservative — argument fine-grain 미시도 (fragile) |
| A6 model+effort | 책임 기반 model 선택: 실행 = `sonnet` / 논의·설계·검증 = `opus` + `effort: xhigh` |

`thinking:` 필드는 Claude Code 공식 frontmatter spec 부재 → silent ignore → **사용 금지**.

## 배경

v1.10d 감사에서 발견된 문제들:

- slash command에 subagent 전용 `tools:` 필드 오용 (silent ignore)
- `Bash(git*)` (no space) → `lsof`, `lsblk` 등 의도 외 명령 매치
- 자동 허용 set(`ls`, `grep` 등)을 redundant하게 선언
- 콤마 separator → 단일 문자열로 파싱되어 전체 무효 가능

v1.10g에서 `thinking:` 필드 silent ignore 확인 + model/effort 책임 기반 분리 확정.

## 결과

- `harness-meta.md`: `model: sonnet` (라우팅 책임)
- `harness-plan/design/ship SKILL.md`: `model: opus`, `effort: xhigh`
- `harness-run/harness SKILL.md`: sonnet (실행)
- V10 자동 검증: `grep -c '^thinking:' <files>` = 0

## 관련 문서

- 6축 통합 단일 소스: [bootstrap/docs/PERMISSION_PATTERN.md](../../bootstrap/docs/PERMISSION_PATTERN.md)

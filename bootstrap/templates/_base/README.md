# `_base/.claude/` — language-neutral 하네스 템플릿

하네스를 도입한 **모든 언어 프로젝트**에 공통으로 복사되는 Claude Code 설정 baseline. `sessions/meta/v1.8-core-adapter-split/`에서 `~/harness-meta/claude/`의 다수 파일을 이관하여 생성.

## 포함 파일 (17)

| 카테고리 | 파일 수 | 내용 |
|---------|--------|------|
| `commands/` | 6 | `harness.md` + `harness-{plan,design,run,ship,review}.md` (하네스 실행 명령) |
| `agents/` | 4 | `harness-{dispatcher,explore,grey-area,verifier}.md` (subagent 프롬프트) |
| `skills/` | 3 디렉토리 × 2 파일 = 6 | `harness-{plan,design,ship}/{SKILL.md, *.md}` (템플릿) |
| `output-styles/` | 1 | `harness-engineer.md` (응답 스타일) |

`hooks/`, `statusline/`는 **글로벌 책임**이므로 `_base/.claude/`에 없다 (`~/harness-meta/claude/hooks/`, `~/harness-meta/claude/statusline/`에 유지).

## 배포 방식

```bash
# 프로젝트 루트에서
pwsh ~/harness-meta/bootstrap/install-project-claude.ps1   # Windows
# 또는
bash ~/harness-meta/bootstrap/install-project-claude.sh    # macOS/Linux
```

- **Copy** 방식 (symlink 아님) — Windows `core.symlinks=false` 기본 회피 + 프로젝트 repo에 일반 파일로 커밋 가능
- 충돌 시 기본 중단 (기존 파일 유지). `-Force`/`--force`로 `.claude/backup-<ts>/` 이동 후 덮어쓰기
- 복사 후 `/config → Output style → "Harness Engineer"` 선택 필요 (수동)

## `_base/`가 "언어 중립"인 이유

- 모든 명령·agent 예시가 `{executor}`, `{test_cmd}`, `{src}/module.{ext}` 같은 placeholder로 작성 (v1.6 세션 결과)
- Python 특정 예시는 다언어 주석으로 보완 (`Python: ... / TS: ... / Go: ... / Rust: ...`)
- 실제 명령은 각 프로젝트 `.harness.toml [testing]` / `[harness].executor`에서 공급

## 향후 overlay 메커니즘 (v1.11+)

```
_base/          ← 언어 불문 baseline (본 디렉토리)
python-uv/      ← Python/uv 특화 (PLAN: v1.11)
node-pnpm/      ← TypeScript/pnpm 특화 (PLAN: v1.12)
go-mod/         ← Go (PLAN: v1.12)
rust-cargo/     ← Rust (PLAN: v1.13)
...
```

설치 시 `install-project-claude` 에 `-Language python-uv` 플래그 추가 예정. `_base` → `<language>/` 순서로 overlay 복사 (언어 특화가 baseline을 덮어씀). v1.11~v1.13 세션에서 구현.

## ⚠️ Commands는 Anthropic 공식 legacy

[code.claude.com/docs/en/agent-sdk/slash-commands](https://code.claude.com/docs/en/agent-sdk/slash-commands) 2026-04 기준:

> Project commands … stored in `.claude/commands/` **(legacy format, prefer `.claude/skills/`)**.

**`.claude/skills/`가 preferred format**. 현재 `_base/`는 commands 6개 + skills 3개 병행. 향후 `sessions/meta/v1.8b-commands-to-skills-migration/` (또는 v1.11+)에서 commands → skills로 통합 재설계 예정. skill의 `name` frontmatter가 동일하면 `/harness-plan` 등 UX는 그대로 유지.

## 관련 문서

- v1.8 이관 세션: `sessions/meta/v1.8-core-adapter-split/`
- AGENTS.md 표준 전략: `bootstrap/docs/AGENTS_MD_STRATEGY.md`
- 매니페스트 스키마: `bootstrap/manifest-schema.md`
- 세션 소속 규약: `bootstrap/docs/OWNERSHIP.md`

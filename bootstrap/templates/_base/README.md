# `_base/.claude/` — language-neutral 하네스 템플릿

하네스를 도입한 **모든 언어 프로젝트**에 공통으로 복사되는 Claude Code 설정 baseline. `sessions/meta/v1.8-core-adapter-split/`에서 `~/harness-meta/claude/`의 다수 파일을 이관하여 생성.

## 포함 파일 (14) — v1.8b 이후

| 카테고리 | 파일 수 | 내용 |
|---------|--------|------|
| `skills/` | 6 디렉토리, 9 파일 | `harness{,-plan,-design,-run,-ship,-review}/SKILL.md` (6) + plan-template.md / 7d-checklist.md / report-template.md (3) — **`.claude/skills/` preferred format** (Anthropic 공식 2026-04) |
| `agents/` | 4 | `harness-{dispatcher,explore,grey-area,verifier}.md` (subagent 프롬프트) |
| `output-styles/` | 1 | `harness-engineer.md` (응답 스타일) |

**v1.8b 이전**: `commands/` 6개 + skills/ 3개(template role) 병행 (총 17 파일).
**v1.8b 이후**: commands 삭제 + skills 6개(dispatcher + 5 단계)로 **통합** + template 3개 유지 (총 14 파일). Anthropic `.claude/commands/` legacy 선언 대응.

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

## Skill 구조 (v1.8b 통합 완료)

[code.claude.com/docs/en/agent-sdk/slash-commands](https://code.claude.com/docs/en/agent-sdk/slash-commands) Anthropic 공식 기준 `.claude/skills/`가 preferred format. v1.8b에서 commands → skills 통합 완료.

- `skills/harness/SKILL.md` → `/harness` (dispatcher)
- `skills/harness-plan/SKILL.md` → `/harness-plan` (+ plan-template.md)
- `skills/harness-design/SKILL.md` → `/harness-design` (+ 7d-checklist.md)
- `skills/harness-run/SKILL.md` → `/harness-run`
- `skills/harness-ship/SKILL.md` → `/harness-ship` (+ report-template.md)
- `skills/harness-review/SKILL.md` → `/harness-review`

각 SKILL.md frontmatter:
- `name` — slash 호출 이름 (예: `harness-plan`)
- `description` — Claude 자동 로드 판단 기준
- `disable-model-invocation: true` — 사용자 slash만 허용, 모델 자동 호출 차단
- `allowed-tools` — skill 권한 제한
- `model` / `thinking` / `argument-hint` — 실행 힌트

## 관련 문서

- v1.8 이관 세션: `sessions/meta/v1.8-core-adapter-split/`
- AGENTS.md 표준 전략: `bootstrap/docs/AGENTS_MD_STRATEGY.md`
- 매니페스트 스키마: `bootstrap/manifest-schema.md`
- 세션 소속 규약: `bootstrap/docs/OWNERSHIP.md`

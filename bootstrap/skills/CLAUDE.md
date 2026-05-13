# bootstrap/skills/ 모듈 가이드

글로벌 user-skill의 source-of-truth 디렉토리. **v5.0 부터** Claude Code Plugin spec 안 `.claude-plugin/plugin.json` `skills: "./bootstrap/skills/"` (add-to-default 패턴) paths 명시 — Plugin install 후 자동 인식. `~/.claude/skills/` SymbolicLink (v4.x) 는 deprecated since v5.0 (v5.0+ 환경에서는 비활성).

상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)

## 매트릭스 (5 skill, 2 카테고리)

| Skill | 카테고리 | invocation 정책 |
|-------|---------|---------------|
| `ai-ready-scorer` | `audit/` | `description` trigger (Claude 자동 + 사용자 명시) |
| `harness-plan-verify` | `audit/` | `description` trigger (PLAN context7 spec drift 검증) |
| `harness-roadmap-update` | `audit/` | `disable-model-invocation: true` — 사용자 명시 `/harness-roadmap-update`만 |
| `mindvault` | `dev-tools/` | `disable-model-invocation: true` — PyPI 설치 + git hook side effect 보호 |
| `developer-profile` | `dev-tools/` | `user-invocable: false` — 메뉴 숨김 + Claude 자동 로드 |

`user-invocable: false` vs `disable-model-invocation: true`는 **직교**(orthogonal):

- `user-invocable: false` — UI 메뉴 숨김, **Claude 자동 호출 가능** (background context용)
- `disable-model-invocation: true` — **Claude 자동 호출 차단**, 사용자 명시 호출만 (side effect 보호)

## 디렉토리 구조 (2-tier 활성 / 3-tier 인프라)

```
bootstrap/skills/
├── audit/                          # 검증·평가·갱신
│   ├── ai-ready-scorer/
│   │   ├── SKILL.md
│   │   ├── scripts/score_codebase.py
│   │   ├── references/rubric.md
│   │   └── evals/evals.json
│   ├── harness-plan-verify/
│   │   └── SKILL.md
│   ├── harness-roadmap-update/
│   │   └── SKILL.md
│   └── <subcategory>/              # 3-tier 후보 (인프라 active, 실 콘텐츠 0)
│       └── <name>/
│           └── SKILL.md
└── dev-tools/                      # 개발 도구·context
    ├── mindvault/
    │   └── SKILL.md
    └── developer-profile/
        └── SKILL.md
```

**Reserved**: `_*` prefix는 sentinel — 모든 segment(category/subcategory/name)에서 거부. install-skills.{ps1,sh} regex `^[a-z0-9]` 첫 char + enumerate `case _*` skip으로 이중 차단.

## SKILL.md 작성 규약

### Frontmatter (요지)

```yaml
---
name: <skill-name>
description: |
  <한국어 본문 + 자동 trigger 키워드 — 200자 이상 권장>
  TRIGGER: "키워드1", "키워드2"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(python *)
# disable-model-invocation: true   # side effect 보호 시
# user-invocable: false             # 메뉴 숨김 (background context용)
model: opus    # 또는 sonnet — 책임 기반 선택
effort: xhigh  # opus default 정합 (sonnet은 declare 무 — high default inherit)
---
```

### Plugin paths 인식 (`bootstrap/skills/` add-to-default)

Claude Code Plugin spec 안 `skills` 필드 = **add-to-default** 패턴 (default `skills/` 디렉토리에 **추가**). `.claude-plugin/plugin.json` 안 `"skills": "./bootstrap/skills/"` 명시 — Plugin install 후 `~/.claude/plugins/cache/harness-meta/bootstrap/skills/<category>/<name>/SKILL.md` 안 SKILL 자동 인식. 2단계 sub-category (`audit/<name>` / `dev-tools/<name>`) 구조 보존 — Plugin 안 nested 디렉토리 인식.

## 배포 (v5.0 Plugin spec 채택)

v5.0_plugin-pivot (2026-05-14) — `.claude-plugin/plugin.json` paths 명시 으로 자동 인식. 사용자 install = `claude plugin install harness-meta@harness-meta` (Claude Code CLI). 새 skill 추가 시 `bootstrap/skills/<category>/<name>/SKILL.md` 작성만 — plugin.json 갱신 불요 (add-to-default 패턴 자연 흡수). 자세히: [`../agents/CLAUDE.md`](../agents/CLAUDE.md) § Install/Update/Cleanup 책임 + [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 3.1.

**Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — v4.0 narrative ('static `install-skills.{ps1,sh}` 폐기 + component-installer 흡수') + ~/.claude/skills/ symlink 평탄화 narrative (1단계 평탄, 2단계 source 매핑) 는 historical 만 보존. Plugin 안 `skills` 필드 add-to-default 패턴 = 평탄화 책임 자연 해소 (Plugin 안 nested 인식).

## 신규 글로벌 user-skill 추가 절차

1. **카테고리 결정** — `audit/` (검증·평가) 또는 `dev-tools/` (개발 도구)
2. **(선택) sub-category 결정** — 같은 카테고리 내 5+ skill 누적 시 sub-category 분리 검토 (예: `audit/code-quality/<name>/`)
3. **`bootstrap/skills/<category>[/<subcategory>]/<new-name>/` 디렉토리 생성**
   - `SKILL.md` 작성 (frontmatter + 본문)
   - 필요 시 `scripts/`, `references/`, `evals/` 추가
4. **사용자 환경 배포**: 본 repo 가 Plugin (v5.0+) — `.claude-plugin/plugin.json` `skills: "./bootstrap/skills/"` add-to-default paths 안 자동 인식. plugin install 환경에서 Claude Code 재시작 후 `<new-name>` 인식 자동. `claude plugin enable harness-meta` 으로 활성 갱신 가능. ((Deprecated since v5.0, v5.0+ 환경에서는 비활성) v4.x 자연어 호출 `~~<new-name> 설치해줘~~` 폐기.)
5. **milestone 기록**: `projects/meta/milestones/v{X.Y}/` 9-stage (v3.0+ 9-stage-bundled era)
6. **smoke 추가** (선택): 신규 skill 정적 매트릭스 추가 (활성 6 smoke 안 등재 필요 시 `tests/smoke-skills-install.sh` 등 — 본 smoke 는 v4.0 phase-2 안 `tests/_inactive/` 분리, 활성화 검토 필요)

## 작업 시 주의

- **Source-of-truth 규약**: `bootstrap/skills/`만 git tracking. v5.0+ Plugin install 시 `~/.claude/plugins/cache/harness-meta/bootstrap/skills/` 거주 (Claude Code 표준), git 대상 외. ((Deprecated since v5.0) `~/.claude/skills/` symlink — v4.x historical)
- **Backup 위치**: v4.x 환경 `~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/` (skills/ 외부 필수). v5.0+ Plugin lifecycle = `claude plugin uninstall` 안 backup 표준 메커니즘 위임.
- **sub-dir SKILL.md frontmatter**: `name` + `description` 최소 필수
- **mindvault upstream archived 2026-04-14** — PyPI unpublish 시 첫 호출 fail 가능. graphify 등 alternative 도입 evidence 후속

## 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- harness-plan-verify SKILL: [`audit/harness-plan-verify/SKILL.md`](audit/harness-plan-verify/SKILL.md)
- harness-roadmap-update SKILL: [`audit/harness-roadmap-update/SKILL.md`](audit/harness-roadmap-update/SKILL.md)

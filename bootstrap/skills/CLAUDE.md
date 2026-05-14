# bootstrap/skills/ 모듈 가이드

글로벌 user-skill의 정책·매트릭스 narrative 디렉토리. **v5.1 부터** 실 SKILL.md 파일 = `skills/` (plugin_root standard location, 1단계 flat) 거주 + `.claude-plugin/plugin.json` `skills: "./skills/"` (add-to-default 패턴) — Plugin install 후 자동 인식. 본 `bootstrap/skills/` = CLAUDE.md narrative-only container. `~/.claude/skills/` SymbolicLink (v4.x) 는 deprecated since v5.0 (v5.0+ 환경에서는 비활성).

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

## 디렉토리 구조 (v5.1 이후 — plugin_root/skills/ standard, 1단계 flat)

```
skills/                             # plugin_root standard location (v5.1 이후 executable 거주)
├── ai-ready-scorer/
│   ├── SKILL.md
│   ├── scripts/score_codebase.py
│   ├── references/rubric.md
│   └── evals/evals.json
├── harness-plan-verify/
│   └── SKILL.md
├── harness-roadmap-update/
│   └── SKILL.md
├── mindvault/
│   └── SKILL.md
└── developer-profile/
    └── SKILL.md
bootstrap/skills/
└── CLAUDE.md                       # 정책·매트릭스 narrative (본 파일, narrative-only)
```

**카테고리 구분** (디렉토리 대신 매트릭스 column으로):

- `audit`: ai-ready-scorer + harness-plan-verify + harness-roadmap-update
- `dev-tools`: mindvault + developer-profile

**Reserved**: `_*` prefix는 sentinel — `component-installer` mechanical sequence 안 검증.

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

### Plugin paths 인식 (`skills/` add-to-default, v5.1 이후)

Claude Code Plugin spec 안 `skills` 필드 = **add-to-default** 패턴 (default `skills/` 디렉토리에 **추가**). `.claude-plugin/plugin.json` 안 `"skills": "./skills/"` 명시 — Plugin install 후 `~/.claude/plugins/cache/harness-meta/skills/<name>/SKILL.md` (1단계 flat) 자동 인식.

## 배포 (v5.1 standard location 채택)

v5.1_plugin-component-discovery-fix (2026-05-14) — `skills/` (plugin_root standard) 1단계 flat 구조 + `.claude-plugin/plugin.json` `skills: "./skills/"` 자동 인식. 사용자 install = `claude plugin install harness-meta@harness-meta` (Claude Code CLI). 새 skill 추가 시 `skills/<name>/SKILL.md` 작성만 — plugin.json 갱신 불요 (add-to-default 패턴 자연 흡수). 자세히: [`../agents/CLAUDE.md`](../agents/CLAUDE.md) § Install/Update/Cleanup 책임 + [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 3.1.

**Deprecated since v5.0** (v5.0+ 환경에서는 비활성) — `~/.claude/skills/` symlink narrative (v4.x historical).

## 신규 글로벌 user-skill 추가 절차 (v5.1 이후)

1. **카테고리 결정** — `audit` (검증·평가) 또는 `dev-tools` (개발 도구)
2. **`skills/<new-name>/` 디렉토리 생성**
   - `SKILL.md` 작성 (frontmatter + 본문)
   - 필요 시 `scripts/`, `references/`, `evals/` 추가
3. **사용자 환경 배포**: `skills/<new-name>/SKILL.md` 작성만 — Plugin install 환경 Claude Code 재시작 후 자동 인식. `claude plugin enable harness-meta` 으로 활성 갱신 가능.
4. **milestone 기록**: `projects/meta/milestones/v{X.Y}/` 9-stage (v3.0+ 9-stage-bundled era)
5. **본 모듈 매트릭스 1 row 추가** (카테고리 column 명시)
6. **smoke 추가** (선택): 활성화 검토 시 `tests/smoke-skills-install.sh` — v4.0 phase-2 안 `tests/_inactive/` 분리

## 작업 시 주의

- **Source-of-truth 규약**: `skills/` (plugin_root, v5.1 이후) 만 git tracking. `bootstrap/skills/` = CLAUDE.md narrative-only (git tracking 유지, 실 executable 부재). Plugin install 시 `~/.claude/plugins/cache/harness-meta/skills/` 거주. ((Deprecated since v5.0) `~/.claude/skills/` symlink — v4.x historical)
- **Backup 위치**: v4.x 환경 `~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/` (skills/ 외부 필수). v5.0+ Plugin lifecycle = `claude plugin uninstall` 안 backup 표준 메커니즘 위임.
- **sub-dir SKILL.md frontmatter**: `name` + `description` 최소 필수
- **mindvault upstream archived 2026-04-14** — PyPI unpublish 시 첫 호출 fail 가능. graphify 등 alternative 도입 evidence 후속

## 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- harness-plan-verify SKILL: [`../../skills/harness-plan-verify/SKILL.md`](../../skills/harness-plan-verify/SKILL.md)
- harness-roadmap-update SKILL: [`../../skills/harness-roadmap-update/SKILL.md`](../../skills/harness-roadmap-update/SKILL.md)

# bootstrap/skills/ 모듈 가이드

글로벌 user-skill의 source-of-truth 디렉토리. `~/.claude/skills/`는 본 디렉토리의 symlink (또는 copy mode 사본).

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

### `~/.claude/skills/` symlink target 평탄화

Claude Code SKILL 인식: `~/.claude/skills/<name>/SKILL.md` **1단계만**. 2단계(`~/.claude/skills/audit/<name>/`) 인식 안 됨. 따라서:

- **source**: `bootstrap/skills/<category>/<name>/` (2단계)
- **dest**: `~/.claude/skills/<name>/` (1단계 평탄, symlink target은 source 직접 가리킴)

평탄화 책임 = `component-installer` subagent (또는 메인 Claude) — Bash `New-Item -ItemType SymbolicLink` 시 2단계 source path → 1단계 dest path 자동 변환.

## 배포 (v4.0 B3 — component-installer 흡수)

v4.0_harness-composer-pivot (2026-05-13) — 구 `install-skills.{ps1,sh}` 폐기. 모든 mechanical 작업은 agent (`component-installer`) 또는 메인 Claude 가 Bash 직접 진행. Claude Code 안 자연어 호출 — `harness-meta 설치해줘` 또는 `<skill-name> 설치해줘` (또는 영어 동치). `bootstrap/agents/CLAUDE.md` § "Install / Update / Cleanup 책임 (v4.0 B3, component-installer 흡수)" 참조 — D7 mechanical sequence (backup → symlink → copy fallback → cleanup retention) 단일 source.

## 신규 글로벌 user-skill 추가 절차

1. **카테고리 결정** — `audit/` (검증·평가) 또는 `dev-tools/` (개발 도구)
2. **(선택) sub-category 결정** — 같은 카테고리 내 5+ skill 누적 시 sub-category 분리 검토 (예: `audit/code-quality/<name>/`)
3. **`bootstrap/skills/<category>[/<subcategory>]/<new-name>/` 디렉토리 생성**
   - `SKILL.md` 작성 (frontmatter + 본문)
   - 필요 시 `scripts/`, `references/`, `evals/` 추가
4. **사용자 환경 배포**: Claude Code 안 자연어 호출 (`<new-name> 설치해줘`) → `component-installer` 또는 메인 Claude 가 Bash 으로 `~/.claude/skills/<new-name>/` symlink 생성 (D7 sequence, `bootstrap/agents/CLAUDE.md` 단일 source)
5. **milestone 기록**: `projects/meta/milestones/v{X.Y}/` 9-stage (v3.0+ 9-stage-bundled era)
6. **smoke 추가** (선택): 신규 skill 정적 매트릭스 추가 (활성 6 smoke 안 등재 필요 시 `tests/smoke-skills-install.sh` 등 — 본 smoke 는 v4.0 phase-2 안 `tests/_inactive/` 분리, 활성화 검토 필요)

## 작업 시 주의

- **Source-of-truth 규약**: `bootstrap/skills/`만 git tracking. `~/.claude/skills/`는 symlink (또는 copy 사본)으로 git 대상 외
- **Backup 위치**: `~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/` (skills/ 외부 필수 — 내부 두면 Claude Code가 backup도 활성 skill로 인식)
- **sub-dir SKILL.md frontmatter**: `name` + `description` 최소 필수
- **mindvault upstream archived 2026-04-14** — PyPI unpublish 시 첫 호출 fail 가능. graphify 등 alternative 도입 evidence 후속

## 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- harness-plan-verify SKILL: [`audit/harness-plan-verify/SKILL.md`](audit/harness-plan-verify/SKILL.md)
- harness-roadmap-update SKILL: [`audit/harness-roadmap-update/SKILL.md`](audit/harness-roadmap-update/SKILL.md)

# bootstrap/skills/ 모듈 가이드

글로벌 user-skill의 source-of-truth 디렉토리. `~/.claude/skills/`는 본 디렉토리의 symlink (또는 copy mode 사본).

상위 진입: [`../CLAUDE.md`](../CLAUDE.md) · 단일 소스: [`../docs/SKILLS.md`](../docs/SKILLS.md)

## 매트릭스 (5 skill, 2 카테고리, v1.36+)

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

## 디렉토리 구조 (2단계 카테고리)

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
│   └── harness-roadmap-update/
│       └── SKILL.md
└── dev-tools/                      # 개발 도구·context
    ├── mindvault/
    │   └── SKILL.md
    └── developer-profile/
        └── SKILL.md
```

**Reserved**: `_*` prefix는 sentinel. `bootstrap/skills/_base/` 같은 카테고리명 사용 금지.

## SKILL.md 작성 규약

### Frontmatter 6축 (PERMISSION_PATTERN.md V1/V5/V7/V8/V10 준수)

```yaml
---
name: <skill-name>
description: |
  <한국어 본문 + 자동 trigger 키워드 — 200자 이상 권장>
  TRIGGER: "키워드1", "키워드2", "코드베이스 감사"
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

상세: [`../docs/PERMISSION_PATTERN.md`](../docs/PERMISSION_PATTERN.md).

### 자동 invoke trigger 정책

`description` 필드의 키워드 매칭 시 Claude 자동 invoke. 신뢰성은 **opportunistic** — backstop으로 사용자 슬래시 명령(`/<skill-name>`) 가능.

### `~/.claude/skills/` symlink target 평탄화

Claude Code SKILL 인식: `~/.claude/skills/<name>/SKILL.md` **1단계만**. 2단계(`~/.claude/skills/audit/<name>/`) 인식 안 됨. 따라서:

- **source**: `bootstrap/skills/<category>/<name>/` (2단계)
- **dest**: `~/.claude/skills/<name>/` (1단계 평탄, symlink target은 source 직접 가리킴)

`install-skills.{ps1,sh}` 자동 평탄화 — 사용자는 카테고리 인지 무관.

## 배포 (install-skills)

```powershell
# Windows
pwsh ../../install-skills.ps1                    # 기본 = ai-ready-scorer
pwsh ../../install-skills.ps1 -All               # 모두
pwsh ../../install-skills.ps1 -List              # 사용 가능 목록
pwsh ../../install-skills.ps1 -CopyMode          # copy mode (Developer Mode 불필요)
pwsh ../../install-skills.ps1 -Cleanup -Yes      # backup 정리 (v1.30+, default retain=3 grace=7d)
```

```bash
# macOS / Linux / Windows Git Bash (.sh가 .ps1로 자동 위임)
bash ../../install-skills.sh
bash ../../install-skills.sh --all
bash ../../install-skills.sh --copy-mode
bash ../../install-skills.sh --cleanup --yes
```

자동 lookup: legacy `<name>` 단독 입력 시 `<category>/<name>` 자동 prefix (0/1/2+ 매치 분기).

## 신규 글로벌 user-skill 추가 절차

1. **카테고리 결정** — `audit/` (검증·평가) 또는 `dev-tools/` (개발 도구). evidence 5+ 시 신규 카테고리 도입 검토 (별 후속)
2. **`bootstrap/skills/<category>/<new-name>/` 디렉토리 생성**
   - `SKILL.md` 작성 (frontmatter 6축 + 본문)
   - 필요 시 `scripts/`, `references/`, `evals/` 추가
3. **사용자 환경 배포**: `pwsh install-skills.ps1 <category>/<new-name>` 또는 `-All`
4. **세션 기록**: `sessions/meta/vX.Y-add-<new-name>-skill/` PLAN+REPORT (S1c 변경)
5. **smoke 추가** (선택): `tests/smoke-skills-install.sh`에 신규 skill 정적 매트릭스 추가

## 작업 시 주의

- **Source-of-truth 규약**: `bootstrap/skills/`만 git tracking. `~/.claude/skills/`는 symlink (또는 copy 사본)으로 git 대상 외
- **Backup 위치**: `~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/` (skills/ 외부 필수 — 내부 두면 Claude Code가 backup도 활성 skill로 인식)
- **sub-dir SKILL.md frontmatter**: `name` + `description` 최소 필수 (Stage I V1/V5/V7/V8/V10 회귀 회피)
- **mindvault upstream archived 2026-04-14** — PyPI unpublish 시 첫 호출 fail 가능. graphify 등 alternative 도입 evidence 후속

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md) · 본 모듈 단일 소스: [`../docs/SKILLS.md`](../docs/SKILLS.md)
- frontmatter 6축: [`../docs/PERMISSION_PATTERN.md`](../docs/PERMISSION_PATTERN.md)
- harness-plan-verify SKILL: [`audit/harness-plan-verify/SKILL.md`](audit/harness-plan-verify/SKILL.md)
- harness-roadmap-update SKILL: [`audit/harness-roadmap-update/SKILL.md`](audit/harness-roadmap-update/SKILL.md)
- 매트릭스 도입 세션 (v1.36): [`../../sessions/meta/v1.36-roadmap-unification-and-flow/`](../../sessions/meta/v1.36-roadmap-unification-and-flow/)

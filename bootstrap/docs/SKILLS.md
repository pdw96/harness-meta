# Skills — 글로벌 user-skill 디렉토리 규약 + opt-in 배포

`sessions/meta/v1.19-scorer-skill-distribution/`에서 확정. harness-meta가 source-of-truth로 보관하는 **글로벌 user-skill**(모든 프로젝트에서 평가/사용 가능)의 위치·구조·배포 메커니즘 단일 소스.

## 1. 개요

Claude Code skill은 두 종류로 구분:

| 종류 | 위치 | 성격 | 배포 |
|------|------|------|------|
| **글로벌 user-skill** | `~/harness-meta/bootstrap/skills/<category>/<name>/` (v1.36+ 2단계) | repo 무관, 사용자 환경 전체에서 사용 | `install-skills.{ps1,sh}` (opt-in) → `~/.claude/skills/<name>/` symlink (1단계 평탄) |
| **프로젝트별 skill** | `~/harness-meta/bootstrap/templates/_base/.claude/skills/<name>/` | 프로젝트 단위. bootstrap 시 `<proj>/.claude/skills/`로 복사 | `install-project-claude.{ps1,sh}` (프로젝트 부트스트랩 시 자동) |

본 문서는 **전자**(글로벌 user-skill)만 다룬다. 프로젝트별 skill은 `bootstrap/templates/_base/.claude/skills/`에 있고 `install-project-claude.{ps1,sh}`로 배포된다 (별 도메인).

### 현 상태 — `bootstrap/skills/` 매트릭스 (5 skill, 2 카테고리, v1.36 기준)

v1.36에서 1단계 → 2단계 카테고리 구조 도입 (`audit/` + `dev-tools/`). install-skills 자동 lookup으로 backward compat (`<name>` legacy 입력 → `<category>/<name>` 자동 prefix).

| Skill | 카테고리 | invocation 정책 | 동기 / Trigger | 도입 세션 |
|-------|--------|---------------|---------------|---------|
| `ai-ready-scorer` | `audit/` | `description` trigger (Claude 자동 + 사용자 명시) | "AI-Ready 점수", "코드베이스 감사", CI 게이트 등 | v1.19 (v1.18b 이관) → v1.36 카테고리 이관 |
| `mindvault` | `dev-tools/` | **`disable-model-invocation: true`** — 사용자 명시 `/mindvault`만 (PyPI 설치 + git hook side effect 보호) | knowledge graph + wiki + BM25 index. ⚠️ upstream archived 2026-04-14 | v1.20 → v1.36 카테고리 이관 |
| `developer-profile` | `dev-tools/` | **`user-invocable: false`** — 메뉴 숨김 + Claude 자동 로드 (background user context) | 응답 스타일·작업 환경 자동 반영 | v1.20 → v1.36 카테고리 이관 |
| `harness-plan-verify` | `audit/` | `description` trigger (Claude 자동 + 사용자 명시 `/harness-plan-verify`) | 메타 + 프로젝트 세션 PLAN context7 spec drift 검증 — "spec 검증" / "context7 검증" / "PLAN 검증" 키워드 (v1.36+ 프로젝트 PLAN 지원) | v1.24 → v1.36 카테고리 이관 + 프로젝트 확장 |
| **`harness-roadmap-update`** | `audit/` | **`disable-model-invocation: true`** — 사용자 명시 `/harness-roadmap-update`만 (ROADMAP 편집 side effect 보호) | REPORT 작성 직후 `sessions/meta/ROADMAP.md` 또는 `projects/<name>/ROADMAP.md` 자동 갱신 — "최근 완료" + "Out of scope (trigger 대기)" 5종 분류 이관 | **v1.36 (신규)** |

`user-invocable` vs `disable-model-invocation` 차이는 **직교**(orthogonal) — Claude Code 공식 docs ([Issue #19141](https://github.com/anthropics/claude-code/issues/19141) 명확화):

- `user-invocable: false` — UI 메뉴에서만 숨김. **Claude는 자동 호출 가능** (background knowledge용)
- `disable-model-invocation: true` — **Claude 자동 호출 차단**. 사용자가 슬래시 명령으로 명시 호출만 (side effect 워크플로 보호)

## 2. 디렉토리 규약 (v1.36+ 2단계 카테고리)

```
bootstrap/skills/
├── audit/                              # 검증·평가 관련 skill
│   ├── ai-ready-scorer/                # AI-Ready 100점 루브릭 audit
│   │   ├── SKILL.md
│   │   ├── scripts/score_codebase.py
│   │   ├── references/rubric.md
│   │   └── evals/evals.json
│   ├── harness-plan-verify/            # context7 spec drift 검증
│   │   └── SKILL.md
│   └── harness-roadmap-update/         # ROADMAP 갱신 (v1.36 신규)
│       └── SKILL.md
└── dev-tools/                          # 개발 도구 / context skill
    ├── mindvault/                      # ⚠️ upstream archived 2026-04-14
    │   └── SKILL.md
    └── developer-profile/              # background user context
        └── SKILL.md
```

**규칙 (v1.36+)**:

- **2단계 카테고리** — `bootstrap/skills/<category>/<name>/`
- 카테고리 디렉토리 자체는 SKILL.md 부재 (1 depth만 SKILL 보유)
- skill 디렉토리명 = SKILL.md frontmatter `name` 필드 값
- 하위 구조는 SKILL.md 표준 — `scripts/`, `references/`, `evals/`, `assets/` 등 자유
- **language overlay 적용 안 함** — 글로벌 user-skill은 language 무관

**카테고리 매트릭스 (v1.36 — 2 카테고리, 5 skill)**:

| 카테고리 | 의미 | skill |
|---------|-----|-------|
| `audit/` | 검증·평가·갱신 (감사 결과 산출) | `ai-ready-scorer`, `harness-plan-verify`, `harness-roadmap-update` |
| `dev-tools/` | 개발 도구·context (사용자 환경 보조) | `mindvault`, `developer-profile` |

3단계 이상 (`<cat>/<sub>/<name>/`)는 v1.37+ evidence (5+ skill 추가) 시 도입. 신규 카테고리(security/, automation/ 등)도 evidence-driven.

**Reserved**: `_*` prefix는 sentinel (현재 사용 안 함). `bootstrap/skills/_base/` 같은 카테고리명 사용 금지.

### `~/.claude/skills/` symlink target 평탄화 (Claude Code SKILL 인식 호환)

Claude Code SKILL 인식 경로는 `~/.claude/skills/<name>/SKILL.md` **1단계만** — 2단계 (`~/.claude/skills/audit/<name>/`)는 인식 무. 따라서:

- **source**: `bootstrap/skills/<category>/<name>/` (2단계, source-of-truth)
- **dest**: `~/.claude/skills/<name>/` (1단계 평탄, symlink target은 source 직접 가리킴)
- install-skills의 자동 평탄화로 사용자는 카테고리 인지 무관하게 동작

### v1.36 install-skills 자동 lookup

legacy `<name>` 단독 입력 시 자동 prefix:

```bash
pwsh ./install-skills.ps1 ai-ready-scorer            # → audit/ai-ready-scorer 자동 매핑
pwsh ./install-skills.ps1 audit/ai-ready-scorer      # 명시 입력도 동일 결과
```

**0/1/2+ 매치 분기 (보안)**:

- 0건 → exit 1 + WARN
- 1건 → 자동 prefix 후 진행
- 2건+ → exit 2 + WARN list (typosquatting 방어, 사용자 명시 입력 의무)

regex validation: `^[a-z0-9][a-z0-9_-]*(/[a-z0-9][a-z0-9_-]*)?$` (alphanumeric + `-` + `_` only).

## 3. SKILL.md frontmatter 표준

```yaml
---
name: ai-ready-scorer
description: |
  임의의 git 리포지토리를 AI-Ready 루브릭(100점, 7개 카테고리)으로 감사하고
  JSON 점수표 + 한국어 HTML 대시보드 + ROI 우선순위 액션 리스트를 산출한다.
# 선택 필드:
# disable-model-invocation: true
# allowed-tools:
#   - Read
#   - Glob
#   - Bash(python *)
---
```

상세는 `bootstrap/docs/PERMISSION_PATTERN.md` 참조 (frontmatter `allowed-tools:` 6축 통합 spec).

## 4. install-skills 사용법

### 기본 (단일 skill)

```bash
# Windows
pwsh ~/harness-meta/install-skills.ps1                    # 기본 = ai-ready-scorer

# macOS / Linux / Windows Git Bash
bash ~/harness-meta/install-skills.sh                     # 기본 = ai-ready-scorer
```

### 모든 skill

```bash
pwsh ~/harness-meta/install-skills.ps1 -All
bash ~/harness-meta/install-skills.sh --all
```

### 사용 가능 skill 목록만

```bash
pwsh ~/harness-meta/install-skills.ps1 -List
bash ~/harness-meta/install-skills.sh --list
```

### 계획만 출력 (실 동작 없음)

```bash
pwsh ~/harness-meta/install-skills.ps1 -DryRun
bash ~/harness-meta/install-skills.sh --dry-run
```

### copy mode (symlink 대신 directory copy, Developer Mode 불필요)

```bash
# 명시적 copy mode (Windows Developer Mode OFF 환경에서도 작동)
pwsh ~/harness-meta/install-skills.ps1 -CopyMode
bash ~/harness-meta/install-skills.sh --copy-mode

# symlink 시도 → 실패 시 자동 copy fallback (Developer Mode OFF 자동 감지)
pwsh ~/harness-meta/install-skills.ps1          # try symlink → auto fallback
```

설치 모드는 `~/.claude/skills/.harness-install-mode`에 기록됨 (`symlink` 또는 `copy`).

### 환경변수

| 변수 | 기본값 | 용도 |
|------|--------|------|
| `HARNESS_META_ROOT` | `$HOME/harness-meta` | repo clone 위치 override |
| `HARNESS_SKILLS_BACKUP_ROOT` | `$HOME/.claude/backups/skills` | (v1.30+) backup root override (테스트/고급용) |

### Backup 자동 정리 (v1.30+)

backup 누적은 **opt-in CLI 플래그**로 정리. Default 호출 영향 0 (안전성 우선).

```bash
# Plan only (안전 default — 실 삭제 안 함)
pwsh ~/harness-meta/install-skills.ps1 -Cleanup
bash ~/harness-meta/install-skills.sh --cleanup

# 실 삭제 — --yes 명시 강제
pwsh ~/harness-meta/install-skills.ps1 -Cleanup -Yes
bash ~/harness-meta/install-skills.sh --cleanup --yes

# Install 후 cleanup 1회 (skill 갱신과 정리 동시)
pwsh ~/harness-meta/install-skills.ps1 -All -CleanupAfter -Yes

# 단일 skill만 정리 (positional)
bash ~/harness-meta/install-skills.sh --cleanup ai-ready-scorer --retain 1 --yes

# 정책 조정 (default retain=3, grace-days=7)
bash ~/harness-meta/install-skills.sh --cleanup --retain 5 --grace-days 14 --yes
```

**정책**:

- `--retain N` (default **3**) — skill별 최근 N개 backup 유지
- `--grace-days D` (default **7**) — D일 미만 mtime backup 보존 (count 초과해도)
- `--yes` 없으면 plan-only + WARN (비가역 작업 보호)
- `--retain 0 --grace-days 0` (purge-all) → `--yes` 강제

**알고리즘** (per skill):

1. backup pool을 ts desc 정렬
2. top N개는 무조건 retain (count rule)
3. N+1번째부터 mtime 검사 — D일 초과면 delete, 미만이면 grace 보호 retain
4. ad-hoc dir (`<name>.<YYYYMMDD-HHMMSS>` 형식 미일치)는 cleanup 무관 (안전 가드)

**path traversal 방어**: cleanup은 `BACKUP_ROOT` prefix 디렉토리만 삭제. CLI flag로 root override 불가 (env `HARNESS_SKILLS_BACKUP_ROOT`만).

## 5. 충돌 정책

대상: `~/.claude/skills/<name>/`

| 상태 | 동작 (symlink mode) | 동작 (copy mode) |
|------|---------------------|-----------------|
| 부재 | 즉시 symlink 생성 | 즉시 copy |
| 정상 symlink (target == source) | no-op + info | backup → copy |
| 다른 디렉토리 또는 다른 symlink | **`~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/`** 로 backup → symlink | backup → copy |

**Backup 위치는 `~/.claude/skills/` 외부 필수** — 내부에 두면 Claude Code가 SKILL.md를 자동 인식해 backup도 활성 skill처럼 인식되어 충돌. 외부(`~/.claude/backups/skills/`)에 두면 detector 영향 0.

**`-Force` 미지원**: 항상 backup. 자동 cleanup은 **opt-in 플래그 (`--cleanup` / `-Cleanup`, v1.30+)** — default install 호출은 무관 (§4 "Backup 자동 정리" 참조).

**모드 파일**: `~/.claude/skills/.harness-install-mode`

- 내용: `symlink` 또는 `copy`
- dotfile → Claude Code SKILL.md 스캔 대상 아님
- `-All` 설치 시 마지막 skill 모드로 갱신됨 (허용)
- `--dry-run` / `--list` 시 미기록

backup 디렉토리 누적 방지 (v1.30+ 자동 정리 권장):

```bash
# 누적 확인
ls ~/.claude/backups/skills/ 2>/dev/null

# 자동 정리 (default retain=3 grace=7d)
bash ~/harness-meta/install-skills.sh --cleanup --yes

# 수동 (legacy)
rm -rf ~/.claude/backups/skills/<name>.<ts>/
```

## 6. OS 분기 + 권한

| OS | 요구사항 | 동작 |
|----|----------|------|
| Windows 11 + Developer Mode ON | PowerShell 7+ | symlink (`New-Item -ItemType SymbolicLink`) |
| Windows + admin 권한 | PowerShell 7+ | symlink (동상) |
| **Windows + 권한 부재** | PowerShell 7+ | **symlink 실패 → copy mode 자동 fallback** (v1.22+) |
| **Windows + 명시 copy mode** | PowerShell 7+ | copy (`-CopyMode` 플래그) |
| macOS / Linux | (없음) | symlink (`ln -s`) |
| macOS / Linux + `--copy-mode` | (없음) | copy (`cp -r`) |
| Windows Git Bash → install-skills.sh 호출 시 | PowerShell 7+ in PATH | **자동으로 `pwsh install-skills.ps1`로 위임** (아래 참조) |

### Git Bash `ln -s` 우회 — 왜 .sh가 .ps1로 위임하는가

Git Bash의 `ln -s`는 **MSYS 기본 모드(`MSYS=` 미설정)에서 디렉토리 복사로 fallback**한다. NTFS symlink 아님:

```bash
# Windows Git Bash 기본 환경
$ ln -sfn /tmp/src /tmp/link
$ ls -la /tmp/link
drwxr-xr-x ...    # ← 디렉토리 (l 아님)
```

이는 Cygwin/MSYS 호환층 정책 — symlink 권한이 있어도 기본 동작이 copy. `MSYS=winsymlinks:nativestrict` 설정 시에만 NTFS symlink 생성.

따라서 install-skills.sh는 `uname -s`로 `MINGW*`/`MSYS*`/`CYGWIN*` 감지 시 자동으로 `pwsh install-skills.ps1`에 위임. PowerShell의 `New-Item -ItemType SymbolicLink`는 NTFS symlink를 직접 생성 (Developer Mode 또는 admin 권한 요구).

**필요 도구**: Windows Git Bash 사용자는 PowerShell 7+ 설치 필수 (<https://aka.ms/PowerShell>). 부재 시 install-skills.sh가 명시적 에러 + exit 3.

권한 부재(Developer Mode OFF + non-admin) 시 install-skills.ps1이 자동으로 copy mode로 fallback (v1.22+). 사용자 추가 조치 불필요.

## 7. v1.18b → v1.19 이관 사례 (ai-ready-scorer)

### 배경

v1.18b에서 `~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py`에 **57 lines diff** 추가 (Docker/Lock N/A 분기). 위치가 git 미추적 → 손실 위험.

### 절차 (v1.19에서 1회 수행)

```bash
# 1. source 이관 (cp, git mv 아님 — 이관 source가 git 미추적이라 mv 의미 0)
cp -r ~/.claude/skills/ai-ready-scorer/ ~/harness-meta/bootstrap/skills/ai-ready-scorer/

# 2. install-skills 실행 (backup + symlink 교체)
bash ~/harness-meta/install-skills.sh
# → backup: ~/.claude/skills/ai-ready-scorer.bak-<ts>/
# → symlink: ~/.claude/skills/ai-ready-scorer → ~/harness-meta/bootstrap/skills/ai-ready-scorer

# 3. 작동 검증
python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py ~/harness-meta --json-only
# → 결과 동일 (93/100 S since v1.18b)
```

### 효과

| 항목 | 이관 전 | 이관 후 |
|------|--------|--------|
| source 위치 | `~/.claude/skills/` | `~/harness-meta/bootstrap/skills/` |
| git 추적 | ❌ | ✅ |
| 다른 기기 재현 | ❌ (수동 복사) | ✅ (`git clone` + `install-skills`) |
| version history | ❌ | ✅ |
| `~/.claude/skills/` 사용 모델 | 직접 | symlink (투명) |

## 7b. v1.20 이관 사례 (mindvault + developer-profile)

### 배경

`~/.claude/skills/`에 git 미추적 상태로 존재하던 두 글로벌 user-skill을 `bootstrap/skills/`로 source-of-truth 이관. v1.18b 사례(ai-ready-scorer 57 lines 손실 위험)와 동일 동기.

### 두 skill의 invocation 정책 차이

`§1` 매트릭스 참조. 본 § 핵심 인용:

- **mindvault** — `disable-model-invocation: true` 추가. PyPI `pip install mindvault-ai` + git post-commit hook 등 side effect 차단. 사용자가 `/mindvault`로 명시 호출만 가능
- **developer-profile** — `user-invocable: false` 유지 (upstream 그대로). 메뉴 숨김 + Claude가 응답 스타일 조정 시 자동 로드

### mindvault upstream archived 경고

`etinpres/mindvault` upstream은 **2026-04-14 archived** (저자 폐기 선언, MIT license). 폐기 사유:

- "Karpathy LLM Wiki pattern 오해 — BM25 + tree-sitter만으로는 의미 있는 wiki 생성 불가"
- "토큰 절약은 illusory"
- 추천 대안: [graphify](https://graphify.net/) (active)

**harness-meta 보관 정책** — `bootstrap/skills/mindvault/SKILL.md`는 단지 **사용자 현 사용 패턴 보존 + git history 확보** 목적. PyPI `mindvault-ai`가 unpublish되면 첫 호출 시 `pip install` fail. 이때 사용자 후속:

1. graphify 등 active alternative 도입 (`v1.20b` 후속 evidence-driven)
2. 자체 fork 도입 (별 도메인)

본 v1.20에서는 upstream divergence를 SKILL.md 헤딩 직후 메타블록에 명시 (`> Upstream: ... (archived 2026-04-14)`).

### 절차 (v1.20에서 1회 수행)

```bash
# 1. mindvault SKILL.md reformat (single-line → multi-line YAML + markdown 분리)
#    의미 변경 0 — instruction · code block · trigger 보존

# 2. developer-profile SKILL.md byte-for-byte 이관 (cp -r)

# 3. install-skills 실행 (backup + symlink 교체)
bash ~/harness-meta/install-skills.sh --all
# → ~/.claude/skills/mindvault → ~/.claude/backups/skills/mindvault.<ts>/ 자동 backup
# → ~/.claude/skills/developer-profile → 동상
# → 양쪽 symlink 생성

# 4. 작동 검증 — frontmatter 매칭 확인
grep -E '^(disable-model-invocation|user-invocable):' ~/.claude/skills/mindvault/SKILL.md
grep -E '^user-invocable:' ~/.claude/skills/developer-profile/SKILL.md
```

### 효과

| 항목 | 이관 전 | 이관 후 |
|------|--------|--------|
| source 위치 | `~/.claude/skills/` | `~/harness-meta/bootstrap/skills/` |
| git 추적 | ❌ | ✅ |
| 다른 기기 재현 | ❌ (수동 복사) | ✅ (`git clone` + `install-skills --all`) |
| version history | ❌ | ✅ |
| upstream divergence (mindvault) | 추적 불가 | SKILL.md 헤딩 메타블록 명시 |

## 8. 다른 글로벌 user-skill 추가 절차

신규 글로벌 user-skill `<new-name>` 도입 시:

1. **`bootstrap/skills/<new-name>/` 디렉토리 생성**
   - `SKILL.md` 작성 (name + description + 본문)
   - 필요 시 `scripts/`, `references/`, `evals/` 추가

2. **사용자 환경에 배포**:

   ```bash
   pwsh ~/harness-meta/install-skills.ps1 <new-name>
   # 또는 모두 install:
   pwsh ~/harness-meta/install-skills.ps1 -All
   ```

3. **세션 기록**: `sessions/meta/vX.Y-add-<new-name>-skill/`에 PLAN+REPORT (S1c 변경)

4. **smoke 추가**: `tests/smoke-skills-install.sh`에 신규 skill 정적 매트릭스 추가 (선택)

## 9. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.20-other-global-skills-migration` | 다른 글로벌 user-skill (mindvault 등) 이관. 사용자 명시 요청 시 evidence-driven |
| `v1.21-cross-platform-install` | install-skills + sync-agents 통합. macOS/Linux dynamic 검증. copy mode fallback (Windows symlink 권한 부재 시) |
| `v1.22-skills-categories` | `bootstrap/skills/<category>/<name>/` 2단계 구조 (security/, audit/, dev-tools/ 등). evidence 5+ skill 도입 후 |

## 10. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 세션 소속: [`OWNERSHIP.md`](OWNERSHIP.md) — S1c 글로벌 user-skill scope
- frontmatter spec: [`PERMISSION_PATTERN.md`](PERMISSION_PATTERN.md) — `allowed-tools:` 6축 통합
- AGENTS.md 표준: [`AGENTS_MD_STRATEGY.md`](AGENTS_MD_STRATEGY.md) — `.agents/skills/` 미래 표준 (v1.14+)
- 본 규약 확정 세션: [`../../sessions/meta/v1.19-scorer-skill-distribution/`](../../sessions/meta/v1.19-scorer-skill-distribution/)

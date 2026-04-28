# Skills — 글로벌 user-skill 디렉토리 규약 + opt-in 배포

`sessions/meta/v1.19-scorer-skill-distribution/`에서 확정. harness-meta가 source-of-truth로 보관하는 **글로벌 user-skill**(모든 프로젝트에서 평가/사용 가능)의 위치·구조·배포 메커니즘 단일 소스.

## 1. 개요

Claude Code skill은 두 종류로 구분:

| 종류 | 위치 | 성격 | 배포 |
|------|------|------|------|
| **글로벌 user-skill** | `~/harness-meta/bootstrap/skills/<name>/` | repo 무관, 사용자 환경 전체에서 사용 | `install-skills.{ps1,sh}` (opt-in) → `~/.claude/skills/<name>/` symlink |
| **프로젝트별 skill** | `~/harness-meta/bootstrap/templates/_base/.claude/skills/<name>/` | 프로젝트 단위. bootstrap 시 `<proj>/.claude/skills/`로 복사 | `install-project-claude.{ps1,sh}` (프로젝트 부트스트랩 시 자동) |

본 문서는 **전자**(글로벌 user-skill)만 다룬다. 프로젝트별 skill은 `bootstrap/templates/_base/.claude/skills/`에 있고 `install-project-claude.{ps1,sh}`로 배포된다 (별 도메인).

## 2. 디렉토리 규약

```
bootstrap/skills/
├── ai-ready-scorer/          # 첫 글로벌 user-skill (v1.19에서 ~/.claude/에서 이관)
│   ├── SKILL.md              # frontmatter (name + description) + 본문
│   ├── scripts/
│   │   └── score_codebase.py
│   ├── references/
│   │   └── rubric.md
│   └── evals/
│       └── evals.json
└── (향후 다른 글로벌 skill 추가 시 동일 패턴)
```

**규칙**:
- 디렉토리명 = SKILL.md frontmatter `name` 필드 값 (예: `ai-ready-scorer`)
- 하위 구조는 SKILL.md 표준 따름 — `scripts/`, `references/`, `evals/`, `assets/` 등 자유
- **language overlay 적용 안 함** — 글로벌 user-skill은 language 무관 (Python script 기반이라도 사용은 모든 repo)
- 하위 카테고리 (예: `bootstrap/skills/security/`)는 v1.20+ evidence-driven 도입

**Reserved**: `_*` prefix는 sentinel (현재 사용 안 함)

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

### 환경변수

| 변수 | 기본값 | 용도 |
|------|--------|------|
| `HARNESS_META_ROOT` | `$HOME/harness-meta` | repo clone 위치 override |

## 5. 충돌 정책

대상: `~/.claude/skills/<name>/`

| 상태 | 동작 |
|------|------|
| 부재 | 즉시 symlink 생성 |
| 정상 symlink (target == source) | no-op + info |
| 다른 디렉토리 또는 다른 symlink | **`~/.claude/backups/skills/<name>.<YYYYMMDD-HHMMSS>/`** 로 backup → symlink |

**Backup 위치는 `~/.claude/skills/` 외부 필수** — 내부에 두면 Claude Code가 SKILL.md를 자동 인식해 backup도 활성 skill처럼 인식되어 충돌. 외부(`~/.claude/backups/skills/`)에 두면 detector 영향 0.

**`-Force` 미지원**: 항상 backup. 자동 cleanup 없음 → 사용자 수동 정리 (안전).

backup 디렉토리 누적 방지:
```bash
ls ~/.claude/backups/skills/ 2>/dev/null
# 확인 후 불필요한 것 수동 삭제
```

## 6. OS 분기 + 권한

| OS | 요구사항 | symlink 명령 |
|----|----------|-------------|
| Windows 11 + Developer Mode ON | PowerShell 7+ | `New-Item -ItemType SymbolicLink` |
| Windows + admin 권한 | PowerShell 7+ | 동상 |
| Windows + 권한 부재 | — | install-skills.ps1 abort |
| macOS / Linux | (없음) | `ln -s` |
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

**필요 도구**: Windows Git Bash 사용자는 PowerShell 7+ 설치 필수 (https://aka.ms/PowerShell). 부재 시 install-skills.sh가 명시적 에러 + exit 3.

권한 부재(Developer Mode OFF + non-admin) 시 대응은 기존 install.ps1과 동일 (사용자 안내).

향후 `v1.21-cross-platform-install`에서 copy mode fallback 검토.

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

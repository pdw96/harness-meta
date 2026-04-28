# meta v1.19-scorer-skill-distribution — PLAN (v3 정정)

세션 시작: 2026-04-29

**v3 정정 사유** (Stage D 사후 발견):
- 결함 1 — Git Bash `ln -s`가 MSYS 기본 모드(`MSYS=` unset, MSYSTEM=MINGW64)에서 NTFS symlink가 아닌 **디렉토리 복사**로 fallback. 권한 문제 아님 — Cygwin/MSYS 호환층 정책. 검증: `MSYS=winsymlinks:nativestrict ln -s ...`만 정상 symlink 생성. PLAN v2 위험 #1("Windows symlink 권한 부재")이 실제 결함을 못 잡음.
- 결함 2 — backup이 `~/.claude/skills/<name>.bak-<ts>/` 내부에 위치하면 **Claude Code가 SKILL.md 자동 인식**하여 backup도 활성 skill로 등록 → 이중 invocation 충돌. context7 `/zebbern/claude-code-guide` 인용: "Personal skill: ~/.claude/skills/<skill-name>/SKILL.md" — detection 기준 = SKILL.md 존재. backup prefix 무시 정책 없음.

**v3 변경**:
- R2 install-skills.sh — Windows 감지(`uname -s` MINGW*/MSYS*/CYGWIN*) 시 자동 `pwsh install-skills.ps1` 위임
- R2 install-skills.{ps1,sh} backup 위치: `~/.claude/skills/<name>.bak-<ts>/` → **`~/.claude/backups/skills/<name>.<ts>/`** (외부)
- R2 symlink 정상 검증 단계 추가: `[ -L ]` (sh), `LinkType -eq 'SymbolicLink'` (ps1) — 실패 시 명시적 에러 + backup 복원 rollback
- R4 SKILLS.md — Backup 외부 위치 + Windows ln -s fallback 동작 + .sh→.ps1 위임 명시
직접 선행 세션:
- [`sessions/meta/v1.18b-scorer-skip-na/`](../v1.18b-scorer-skip-na/REPORT.md) — score_codebase.py 변경분 git 미추적 위치(`~/.claude/skills/`)에 잔존, 손실 위험. REPORT "후속 분기" 표에 본 세션 명시
- [`sessions/meta/v1.8-core-adapter-split/`](../v1.8-core-adapter-split/) — `claude/`(글로벌 layer) vs `bootstrap/templates/_base/.claude/`(메타 소유 프로젝트 템플릿) 분리 정책 정합

목적: ai-ready-scorer skill을 `~/.claude/skills/`(git 미추적) → `~/harness-meta/bootstrap/skills/`(git 추적)로 이관. 글로벌 user-skill source를 harness-meta repo로 단일화하여 (1) 손실 위험 영구 해소, (2) 향후 v1.18c~h 작업이 git 보호 하에 진행, (3) 다른 사용자/기기 재배포 가능.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(신규)·S2(다수)·S3(README/CLAUDE.md) — 글로벌 user-skill 디렉토리 규약 신설 = 모든 사용자/프로젝트 영향
- **T1 경로 다수결** — 모든 변경이 ~/harness-meta/ 내부
- **T2 스펙 vs 값** — `bootstrap/skills/` 디렉토리 규약 = 신규 스펙. 한 번 정의하면 모든 글로벌 스킬에 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.18b-scorer-skip-na/REPORT.md` "후속 분기" §** (verbatim):

> | `v1.19-scorer-skill-distribution` | 스코어러를 harness-meta repo 내 `bootstrap/skills/` 또는 별 repo로 이관 + symlink/install 배포 (글로벌 통합). 본 세션의 "score_codebase.py가 git 미추적" 이슈 영구 해소 |

**Source 2 — `sessions/meta/v1.18b-scorer-skip-na/REPORT.md` "⚠️ 중요" §** (verbatim):

> `score_codebase.py`는 `~/.claude/skills/ai-ready-scorer/scripts/`에 위치 — **harness-meta repo 외부**. 본 세션 git commit 대상은 PLAN.md + REPORT.md 2건만. score_codebase.py 변경분(57 lines diff)은 다음 중 하나로 보존 권장: ... 3. **v1.19 후속 세션 진행** — 스코어러를 harness-meta 내로 이관하면 영구 보존

**Source 3 — 사용자 의사결정 (2026-04-29)**:
- Q1=A (`bootstrap/skills/`), Q2=b (별도 install-skills), Q3=b (backup+symlink), Q4=yes (evals 포함)

**Parsed sub-items (4)**:

1. **`bootstrap/skills/` 디렉토리 신설** — 신규 카테고리. ai-ready-scorer 4 파일(SKILL.md + scripts/score_codebase.py + references/rubric.md + evals/evals.json) 이관
2. **`install-skills.{ps1,sh}` 신설** — opt-in 글로벌 user-skill 배포 스크립트. 기존 `~/.claude/skills/ai-ready-scorer/` backup → harness-meta source로 symlink
3. **문서**: `bootstrap/docs/SKILLS.md` 신설 + OWNERSHIP S1c 추가 + README/CLAUDE.md cross-ref
4. **smoke**: `tests/smoke-skills-install.sh` (정적 + dynamic install 검증)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 글로벌 user-skill (mindvault, developer-profile 등) 이관 | 별 후속 — evidence-driven (사용자가 명시적으로 source 단일화 요청 시) |
| `install.ps1`에 install-skills 흡수 (자동 배포) | OWNERSHIP S1a 확장 회피 — opt-in 유지 |
| Multi-platform symlink 정책 통합 (`AGENTS_MD_STRATEGY.md` ↔ skills 양쪽) | 별 후속 v1.21-cross-platform-install |
| `bootstrap/skills/<name>/`과 `bootstrap/templates/_base/.claude/skills/<name>/` 통합 또는 cross-ref | 본 세션 scope 외 — 글로벌 vs 프로젝트별 명확 분리 유지 |
| v1.18c (코드 구조 매니페스트 N/A) 동시 진행 | 별 후속 v1.18c — 본 세션은 이관 인프라만 |
| v1.18d (cp949 encoding fix) 동시 진행 | 별 후속 v1.18d — 1줄 fix이지만 scope 분리 원칙 |
| HTML 대시보드 N/A 정밀 UI | 별 후속 v1.18e |
| `bootstrap/skills/` overlay 개념 (language overlay와 유사) | 글로벌 user-skill은 language 무관 — overlay 적용 안 함 |
| 다른 OS (Linux/macOS) 실 install 검증 | 본 세션은 Windows 정상 작동 + smoke 정적 검증만. dynamic 검증은 v1.21에서 |
| v1.18b 및 그 이전 score_codebase.py 변경 history 별도 보존 | 이관 시점이 곧 history 시작점. 이전 변경분은 v1.18b REPORT에 lesson으로 기록됨 |

## 1. 문제

### 현재 상태

- `~/.claude/skills/ai-ready-scorer/`: 4 파일 존재 (SKILL.md, scripts/, references/, evals/)
- 부모 `~/`(C:/Users/qkreh): git repo (origin: pdw96/Trading.git)
- `score_codebase.py`: untracked (Trading repo에 의도적 미추가 — Trading은 비즈니스 전용)
- v1.18b 변경분 57 lines: git 미추적 = **손실 위험 실재**
- v1.18c~h 후속 작업도 모두 ~/.claude/ 위치에서 진행하면 동일 위험 누적

### Root cause

ai-ready-scorer는 **글로벌 user-skill**이지만 source가 `~/.claude/`에만 있어 (1) 버전 관리 부재, (2) 다른 기기 재현 불가, (3) 변경 history 추적 불가.

### 본 세션 해결 범위

source를 `~/harness-meta/bootstrap/skills/ai-ready-scorer/`로 이관 + opt-in install 스크립트로 `~/.claude/skills/`에 symlink 배포. 사용자 ~/.claude/skills/ 운영 모델 100% 유지하면서 source 단일화.

## 2. 결정 (R1 ~ R6)

### R1 — 신규 디렉토리 규약: `bootstrap/skills/<name>/`

**위치**: `bootstrap/skills/<skill-name>/`

**역할**: harness-meta repo가 source-of-truth로 보관하는 **글로벌 user-skill** (모든 프로젝트에서 평가/사용 가능). 프로젝트별 스킬(`bootstrap/templates/_base/.claude/skills/`)과 **명확 분리**.

**구조 예시**:
```
bootstrap/skills/
├── ai-ready-scorer/
│   ├── SKILL.md
│   ├── scripts/
│   │   └── score_codebase.py
│   ├── references/
│   │   └── rubric.md
│   └── evals/
│       └── evals.json
└── (향후 다른 글로벌 skill 추가 시 동일 패턴)
```

**규칙**:
- 디렉토리명 = SKILL.md frontmatter `name` (예: `ai-ready-scorer`)
- 하위 구조는 SKILL.md 표준 (scripts/ + references/ + evals/ 등 자유)
- **language overlay 적용 안 함** — 글로벌 user-skill은 language 무관

### R2 — `install-skills.{ps1,sh}` 신설 (opt-in)

**위치**: `~/harness-meta/install-skills.ps1` + `~/harness-meta/install-skills.sh`

**동작** (의사코드):
```
1. SKILL_NAME=ai-ready-scorer (또는 --all로 모든 bootstrap/skills/<*> 탐색)
2. SOURCE = $HARNESS_META_ROOT/bootstrap/skills/$SKILL_NAME
3. DEST = $HOME/.claude/skills/$SKILL_NAME
4. if [ -e "$DEST" ]:
     if -Force OR (DEST is symlink AND target == SOURCE):
       # 이미 정상 symlink: skip
       # 또는 -Force: backup
     else:
       # backup
       mv "$DEST" "$HOME/.claude/skills/${SKILL_NAME}.bak-<YYYYMMDD-HHMMSS>"
5. ln -s "$SOURCE" "$DEST"   (Unix)
   New-Item -ItemType SymbolicLink -Path $DEST -Target $SOURCE   (Windows)
6. 결과 출력
```

**충돌 정책**:
- DEST 부재 → 즉시 symlink
- DEST가 정상 symlink (target == SOURCE) → no-op + info
- DEST가 다른 symlink 또는 디렉토리 → backup → symlink (사용자 확인 없이 진행, 단 backup 위치 출력)
- `-Force` 미지원 — 항상 backup (안전)

**OS 분기**:
- `.ps1`: Windows + Developer Mode 또는 admin (기존 install.ps1과 동일 전제)
- `.sh`: macOS/Linux (Windows Git Bash도 ln -s 작동)

**파라미터**:
- `[skill-name]` (positional, optional): 특정 스킬만. 기본 = `ai-ready-scorer` (현재 유일)
- `--all`: `bootstrap/skills/` 모든 디렉토리 install
- `--list`: install 안 하고 사용 가능 스킬 목록만 출력
- `--dry-run`: 실제 동작 안 하고 계획만 출력

### R3 — 기존 `~/.claude/skills/ai-ready-scorer/` 처리

본 세션 implementation 단계에서 1회:

```bash
# 1. v1.18b 변경분 보존 — bootstrap/skills/로 cp (이관)
cp -r ~/.claude/skills/ai-ready-scorer/ ~/harness-meta/bootstrap/skills/ai-ready-scorer/

# 2. install-skills.ps1 실행
pwsh ~/harness-meta/install-skills.ps1
# → backup: ~/.claude/skills/ai-ready-scorer.bak-<ts>/
# → symlink: ~/.claude/skills/ai-ready-scorer → ~/harness-meta/bootstrap/skills/ai-ready-scorer

# 3. 작동 검증
python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py ~/harness-meta --json-only
# → 결과 동일 (90 → 93 since v1.18b)
```

backup 디렉토리는 사용자가 확인 후 수동 삭제 (자동 cleanup 안 함 — 안전).

### R4 — 문서 (3 파일 신규/갱신)

**`bootstrap/docs/SKILLS.md` 신설** (~80~120 lines):
1. 개요 — 글로벌 user-skill source 단일화 + opt-in 배포
2. 디렉토리 규약 (R1)
3. SKILL.md frontmatter 표준 (`name`, `description`, optional `disable-model-invocation`, `allowed-tools`)
4. install-skills 사용법 (R2)
5. 충돌 정책 (R2)
6. OS 분기 + Windows 권한 요구사항
7. v1.18b의 ai-ready-scorer 이관 사례
8. 다른 글로벌 user-skill 추가 절차
9. 후속 분기 (v1.21 cross-platform 통합)

**`bootstrap/docs/OWNERSHIP.md` 갱신** — S1c 신규:
```
| **S1c** | 메타 소유 글로벌 user-skill | `~/harness-meta/bootstrap/skills/**` — 모든 사용자에게 배포되는 글로벌 스킬 (현 ai-ready-scorer) | `sessions/meta/` |
```

**`README.md` 갱신** — "설치" § 글로벌 user-skill (선택):
```
## 3단계 — 글로벌 user-skill (선택)
pwsh ~/harness-meta/install-skills.ps1   # Windows
bash ~/harness-meta/install-skills.sh    # macOS/Linux
# → ~/.claude/skills/ai-ready-scorer 등 글로벌 스킬 symlink 배포
```

**`CLAUDE.md` 갱신**:
- 디렉토리 구조 트리에 `bootstrap/skills/` 추가
- "관련 문서" §에 SKILLS.md cross-ref 추가

### R5 — Smoke test

**`tests/smoke-skills-install.sh` 신설** (정적 4 + dynamic 4 = 8 checks):

```
정적 (4):
  ✓ bootstrap/skills/ai-ready-scorer/SKILL.md 존재
  ✓ bootstrap/skills/ai-ready-scorer/scripts/score_codebase.py 존재
  ✓ install-skills.sh 헤더 + symlink 분기 + backup 분기 grep
  ✓ install-skills.ps1 동상 (Where-Object + New-Item SymbolicLink)

Dynamic (4, tmpdir):
  Setup: HOME=tmpdir 환경 + ~/.claude/ 부재 상태
  
  ✓ install-skills.sh 실행 → exit 0
  ✓ tmpdir/.claude/skills/ai-ready-scorer/ symlink 생성
  ✓ symlink target == bootstrap/skills/ai-ready-scorer/
  ✓ 두 번째 실행 → no-op (이미 정상 symlink)
  
  Cleanup: rm -rf tmpdir
```

**한계**:
- PowerShell .ps1 dynamic 검증은 v1.21로 이연 (sh smoke가 알고리즘 동등 검증)
- backup 분기는 정적 grep만 (실 dynamic 시나리오는 사용자 environment에서)

### R6 — Self-score 회귀 검증

본 세션 종료 후 harness-meta 자기 스코어링:
```
python ~/.claude/skills/ai-ready-scorer/scripts/score_codebase.py ~/harness-meta
```

**기대**: v1.18b 결과 그대로 93/100 (S). 이관 자체는 점수 영향 0.

회귀 시 손실 분석 후 rollback (backup 디렉토리에서 복원).

## 3. 변경 대상 (4 신규 + 3 수정)

### 신규 (4)

| 경로 | scope | 역할 | 라인 수 |
|------|------|------|------|
| `bootstrap/skills/ai-ready-scorer/{SKILL.md, scripts/, references/, evals/}` | S1c (신설) | 4 파일 이관 (cp from ~/.claude/) | (기존 분량) |
| `install-skills.ps1` | S3 | 글로벌 user-skill 배포 (Windows) | ~120 |
| `install-skills.sh` | S3 | 동상 (macOS/Linux) | ~80 |
| `bootstrap/docs/SKILLS.md` | S2 | 디렉토리 규약 + 사용법 단일 소스 | ~120 |
| `tests/smoke-skills-install.sh` | S3 | 정적 4 + dynamic 4 = 8 checks | ~80 |

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/OWNERSHIP.md` | S2 | S1c 행 추가 + Evolution 조항 1줄 |
| `README.md` | S3 | 설치 3단계 § (글로벌 user-skill 선택) |
| `CLAUDE.md` | S3 | 디렉토리 구조 트리 + 관련 문서 SKILLS.md cross-ref |

### 신규 (2 — 세션 자체)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.19-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.19-.../REPORT.md` | meta | Stage F |

## 4. 진행 체크박스

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 진입 확인** ← 다음 단계
- [ ] Stage A — `bootstrap/skills/ai-ready-scorer/` 디렉토리 생성 + 4 파일 cp
- [ ] Stage B — `install-skills.ps1` + `install-skills.sh` 작성
- [ ] Stage C — 문서 (SKILLS.md 신설 + OWNERSHIP S1c + README + CLAUDE.md)
- [ ] Stage D — 사용자 install-skills 실행 → backup + symlink 검증 (대화 분기)
- [ ] Stage E — `tests/smoke-skills-install.sh` 작성
- [ ] Stage F — REPORT.md 작성
- [ ] 사용자 커밋 승인 → 일괄 commit

## 5. 성공 기준

- [ ] `bootstrap/skills/ai-ready-scorer/` 4 파일 존재 (SKILL.md, scripts/score_codebase.py, references/rubric.md, evals/evals.json)
- [ ] `install-skills.ps1` + `.sh` 작성 + 실행 가능 (`-list` / `-dry-run` 동작)
- [ ] `bootstrap/docs/SKILLS.md` 9 § 작성
- [ ] `OWNERSHIP.md` S1c 행 추가
- [ ] `README.md` 3단계 § 추가
- [ ] `CLAUDE.md` cross-ref 추가
- [ ] `tests/smoke-skills-install.sh` 8/8 PASS
- [ ] **사용자 environment**: 기존 `~/.claude/skills/ai-ready-scorer/` → `ai-ready-scorer.bak-<ts>/` backup + harness-meta source로 symlink 교체
- [ ] **harness-meta 자기 재스코어**: 93/100 (S) 그대로 (회귀 0)
- [ ] git commit: bootstrap/skills/ + install-skills.* + 문서 + smoke + sessions/meta/v1.19/* 일괄

## 6. 위험 / 제약 (v3 갱신)

| 위험 | 영향 | 완화 |
|------|------|------|
| **Git Bash ln -s가 MSYS 기본 모드에서 디렉토리 복사로 fallback** (v3 정정 — v2의 "권한 부재"가 아닌 실제 원인) | install-skills.sh가 NTFS symlink 미생성, source 단일화 무산 | install-skills.sh가 Windows 감지 시 자동 `pwsh install-skills.ps1` 위임. .ps1의 New-Item -ItemType SymbolicLink로 NTFS symlink 직접 생성 |
| **backup이 ~/.claude/skills/ 내부 시 SKILL.md 자동 인식 충돌** (v3 정정 — Claude Code skill detector는 SKILL.md 존재 기반, prefix 무시 없음) | backup 디렉토리도 활성 skill로 등록 → 이중 invocation | backup 위치를 ~/.claude/backups/skills/ 외부로 이동 |
| Windows symlink 권한 부재 (Developer Mode OFF + non-admin) | install-skills.ps1 실패 | 기존 install.ps1과 동일 전제 — install.ps1 작동 환경이면 install-skills도 작동 |
| 사용자 ~/.claude/skills/ai-ready-scorer/에 이미 변경분 (v1.18b) | backup 시 분실 위험 | backup 디렉토리(`*.bak-<ts>/`)에 보존, 자동 삭제 안 함 |
| backup 디렉토리 누적 | 디스크 사용 증가 | 사용자 수동 정리 안내 (README + REPORT) |
| git mv vs cp 선택 | history 보존 vs 단순성 | **cp** 선택 (이관 source는 git 미추적이라 mv 의미 없음) |
| install-skills 실행 중 atomic 실패 | 일부 symlink만 생성 | `-all` 모드는 fail-fast + 부분 rollback (기존 install.ps1 패턴) |
| 다른 OS 실 검증 부재 | macOS/Linux 동작 보장 약화 | 정적 grep으로 알고리즘 동등 검증 + v1.21 dynamic 검증 |
| v1.18b 변경분 보존 책임 | source 이관 시 누락 위험 | Stage A에서 `cp -r` (디렉토리 통째) + Stage F 검증 (재스코어 93/100) |
| install-skills.sh CRLF | Git Bash에서 `$'\r': command not found` | `.gitattributes`에 `*.sh text eol=lf` 명시 (이미 존재 확인 필요) |

## 7. 커밋 전략

```
feat(meta): sessions/meta/v1.19-scorer-skill-distribution — 글로벌 user-skill source 이관

- add: bootstrap/skills/ai-ready-scorer/ (SKILL.md + scripts/ + references/ + evals/)
  - source: ~/.claude/skills/ai-ready-scorer/ (v1.18b 변경분 포함, ~57 lines)
- add: install-skills.{ps1,sh} (opt-in 글로벌 user-skill 배포, backup + symlink)
- add: bootstrap/docs/SKILLS.md (디렉토리 규약 + 사용법 단일 소스, ~120 lines)
- add: tests/smoke-skills-install.sh (정적 4 + dynamic 4 = 8 checks)
- update: bootstrap/docs/OWNERSHIP.md (S1c 신규: 메타 소유 글로벌 user-skill)
- update: README.md (설치 3단계 § 추가)
- update: CLAUDE.md (디렉토리 구조 + 관련 문서 cross-ref)
- add: sessions/meta/v1.19-.../{PLAN,REPORT}.md

Scope: 글로벌 user-skill source 이관 인프라.
- bootstrap/skills/ vs bootstrap/templates/_base/.claude/skills/ 명확 분리
- opt-in 배포 (install.ps1과 독립) — OWNERSHIP S1a 영향 없음
- 기존 ~/.claude/skills/ai-ready-scorer/ → backup + symlink 교체 (사용자 environment)
- harness-meta 재스코어: 93/100 (S) 그대로 — 회귀 0

후속 분기:
- v1.18c: 패키지 매니페스트 N/A (코드 구조)
- v1.18d: stdout cp949 encoding fix
- v1.18e: HTML N/A UI + multi-repo 회귀 sample
- v1.21: cross-platform install (sync-agents + verify.ps1 통합)
- 다른 글로벌 user-skill (mindvault 등) 이관: evidence-driven
```

## 8. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.18c-scorer-package-manifest-na` | 본 세션 완료 후 git 보호 하에 진행. multi-repo evidence 1+ 시 |
| `v1.18d-scorer-stdout-encoding` | cp949 fix 1줄. 본 세션 후 |
| `v1.18e-scorer-html-na-ui` | HTML UI + multi-repo 회귀 sample |
| `v1.18f-scorer-language-detect-shell` | Shell 감지 + 타입 안전성 역설 (evidence-driven) |
| `v1.18g-scorer-self-score` | 도그푸딩 메타 검증 |
| `v1.18h-rubric-roi-impact-revisit` | ROI 가중치 재평가 |
| `v1.21-cross-platform-install` | install-skills + sync-agents + verify.ps1 통합. macOS/Linux dynamic 검증 |
| `v1.20-other-global-skills-migration` | 다른 글로벌 user-skill 이관 (mindvault 등). 사용자 명시 요청 시 |

## 9. Lessons Forward (예상)

- **L1 — 글로벌 user-skill source 단일화의 가치**: ~/.claude/는 install 결과 수신처지 source 보관소가 아님. source는 harness-meta(또는 별 dotfiles repo) — 본 세션이 명시
- **L2 — opt-in vs 자동 배포의 선택**: 글로벌 install.ps1 흡수(자동) 대신 별도 스크립트(opt-in) 채택. OWNERSHIP S1a 안정성 보호 + 사용자 통제권 보장
- **L3 — 충돌 시 항상 backup**: `-Force` flag 미지원, 항상 `*.bak-<ts>/`로 보존. 사용자 수동 정리 — 자동 cleanup이 의도하지 않은 데이터 손실 야기 가능
- **L4 — `bootstrap/skills/` vs `bootstrap/templates/_base/.claude/skills/` 명확 분리**: 전자=글로벌, 후자=프로젝트별. 디렉토리 위치로 의도 표현. cross-ref 또는 통합은 부적합 (성격 다름)
- **L5 — git mv vs cp 선택 기준**: 이관 source가 git 미추적이면 mv는 history 의미 0 → cp가 정확. 추후 ~/.claude/skills/ai-ready-scorer/는 backup 후 symlink로 대체되어 "soft mv" 효과

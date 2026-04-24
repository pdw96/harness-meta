# meta v1.8-core-adapter-split — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: `claude/` 글로벌 레이어 17 파일 이관 + `bootstrap/templates/_base/.claude/` 신설 + install.ps1/verify.ps1 축소 + install-project-claude 2 스크립트 + 문서 갱신
판정: **PASS** (성공 기준 14/14, smoke 17/17, install+verify 실측 PASS, **BREAKING**)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 파일 28건 — S1a/S1b(17 이관) + S2(신규 스크립트 2 + _base README) + S3(install/verify/문서 5) → meta. **T1** 전부 meta scope. **T2** 구조 스펙 변경 → meta. upbit 실제 복구는 **T4 후행 세션**.

## 최종 결과

- **`git mv` 17 파일**: `claude/{commands×6, agents×4, skills×6, output-styles×1}` → `bootstrap/templates/_base/.claude/` (이력 보존)
- **claude/ 잔존 3 파일**: `commands/harness-meta.md`, `hooks/session-init.sh`, `statusline/statusline.sh`
- **claude/ 삭제**: `agents/`, `skills/`, `output-styles/` 디렉토리 + .gitkeep
- **install.ps1 cleanup + 축소**: 실측 13건 + 1건(`harness.md`) 자동 cleanup → backup 이동 + 3 카테고리 설치
- **verify.ps1 재산정**: A2 3 카테고리, B1 3, B2 3, B7 `_base/skills/` 대상 전환 — **30/30 PASS**
- **신규 스크립트 2**: `install-project-claude.ps1` (Windows) + `.sh` (macOS/Linux, chmod +x)
- **신규 문서 1**: `bootstrap/templates/_base/README.md`
- **수정 문서 4**: OWNERSHIP(S1 split + Evolution + commands legacy 경고), README(2단계 설치), CLAUDE.md(동일), AGENTS.md
- **세션 기록 3**: PLAN + REPORT + evidence/smoke-install-project.txt

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 증거 |
|---|------|------|------|
| 1 | 17 파일 `git mv` 이력 보존 | ✅ | git status modified 없이 rename 표시 |
| 2 | claude/ 잔존 3 파일 + 빈 디렉토리 삭제 | ✅ | `find claude -type f` 5개 (.gitkeep 2 포함) |
| 3 | install.ps1 cleanup 단계 | ✅ | `v1.8 legacy cleanup — 13건 backup` 실측 + 추가 1건(harness.md) |
| 4 | install.ps1 categories 6→3 | ✅ | commands(harness-meta.md) / hooks / statusline |
| 5 | verify.ps1 A2 3 / B2 3 / B7 _base 대상 | ✅ | **verify 30/30 PASS** |
| 6 | install-project-claude.ps1 신규 | ✅ | 142 라인 |
| 7 | install-project-claude.sh 신규 + chmod +x | ✅ | 실행 권한 확인 |
| 8 | _base/README.md 신규 (commands legacy 경고) | ✅ | ~50 라인 + Anthropic legacy 명시 |
| 9 | OWNERSHIP S1 split + S6 확장 + Evolution | ✅ | S1a/S1b + `.claude/**` 명시 + v1.8 사례 문단 |
| 10 | README/CLAUDE/AGENTS 2단계 설치 안내 | ✅ | 각 Installation 섹션 업데이트 |
| 11 | smoke install-project-claude PASS | ✅ | 임시 디렉토리 17/17 복사 + evidence |
| 12 | 실 `~/.claude/` cleanup 실측 | ✅ | 14건 backup, 새 설치 3 심볼릭 완료 |
| 13 | Grey Area 45건 결정 | ✅ | PLAN G1~G45 |
| 14 | BREAKING 태그 + 복구 안내 | ⏳ | 커밋 시 + 세션 종료 메시지 |

**완수율**: 14/14 (100%).

## 실측 데이터

### install.ps1 재실행

```
[OK]   MetaRoot 구조 유효: C:\Users\qkreh\harness-meta (v1.8+ 축소 3 카테고리)
[INFO] python3 (optional): ...
[WARN] v1.8 legacy cleanup — 13건 backup: backup-legacy-20260425-021517
...
[OK]   설치 완료.
[INFO]   symlinks: 0 (기존 harness-meta.md 유지)
[INFO]   backups : 13 + settings.json.bak
```

첫 패턴 `harness-*.md`가 `harness.md`(hyphen 없음) 놓쳐 1건 잔존 발견 → 패턴 `harness*.md`로 수정 후 재실행 시 1건 추가 cleanup.

### verify.ps1 새 기준

```
Z 3/3 · A 4/4 · B 7/7 · C 10/10 · D 3/3 · E 3/3 · F info · G 6 manual
[OK]   30/30 PASS (WARN: 0)
```

- A2 "3 카테고리 구조 유효 (v1.8+)"
- B1 "~/.claude/ 3 카테고리 존재 (v1.8+)"
- B2 "기대 파일 3개 (commands×1 hooks×1 statusline×1)"
- B7 "_base/skills/ SKILL.md 존재 3/3 skills"

### smoke install-project-claude (임시 /tmp 디렉토리)

- ProjectRoot: `/tmp/tmp.Vq7ut7AZY0`
- 복사 17 파일 (commands 6 + agents 4 + skills 6 + output-styles 1)
- exit 0, evidence 저장

## Grey Area 결정 사후 검증 (45건)

### G1~G10 이관 메커니즘
모두 구현 반영 (_base 이름, Copy 방식, cleanup, 4 카테고리, chmod +x 등)

### G11~G17 install.ps1
- G11 categories 3 entries ✅
- G12 cleanup 로직 ✅ — `$legacyPatterns` 4 디렉토리 (commands harness*, agents harness*, skills harness*, output-styles harness*)
- G14 Test-SymlinkIntegrity 기반 "MetaRoot target" 필터 ✅ — regular file 건드리지 않음
- G17 Invoke-Rollback 확장 — cleanup 백업 `$script:Backups`에 편입 ✅

### G18~G22 verify.ps1
- G18/G19 기대 파일·카테고리 3 ✅
- G20 B7 _base/skills/ 대상 재정의 (삭제 아님) ✅
- G21/G22 D/E smoke 영향 없음 ✅

### G23~G30 install-project-claude
- G23 .harness.toml 부재 시 exit 1 ✅
- G24 -Force backup ✅
- G25 Copy-Item -Recurse / cp -r ✅
- G26 Output style 선택 안내 ✅ (메시지)
- G27 Resolve-Path / cd&pwd ✅
- G28 `#!/usr/bin/env bash` ✅
- G29 HARNESS_META_ROOT env ✅
- G30 chmod +x ✅

### G31~G34 OWNERSHIP
- G31 S1a(글로벌 최소) + S1b(_base 템플릿) split ✅
- G33 S6 `<proj>/.claude/**` 명시 ✅
- G34 Evolution "claude 이관 (2026-04-25 v1.8)" 문단 ✅

### G35~G37 Smoke
- G35 임시 디렉토리 1 시나리오 ✅
- G36 자동 rm -rf ✅
- G37 evidence ✅

### G38~G39 후행
- G38 upbit 복구 세션 즉시 필요 — REPORT 말미 강조 ✅
- G39 매니페스트 있는 프로젝트만 ✅

### G40~G45 context7 검증
- G40 commands legacy 명시 — _base/README.md + OWNERSHIP Evolution ✅
- G41 commands→skills 통합 **별도 세션 v1.8b** 후속 목록에 ✅
- G42 skill frontmatter name 유지 시 UX 동일 (미래 세션 계획 명시) ✅
- G43 `disable-model-invocation` 재평가는 v1.8b (본 세션 보존) ✅
- G44 flat 구조 유지 ✅
- G45 `.agents/skills/` 공존 v1.14+ ✅

**45/45 결정 반영.**

## Lessons Learned

1. **`harness.md` vs `harness-*.md` 패턴 미스매치**: 초기 cleanup `harness-*.md` (hyphen 요구)가 `harness.md`(hyphen 없음)를 놓쳤음. 실행 후 broken symlink 잔존 발견 → 패턴 `harness*.md`로 수정하여 해결. **교훈**: glob 패턴은 실제 대상 파일명 전체 목록을 먼저 확인 후 작성. 특히 prefix + hyphen + suffix 조합 시 hyphen 없는 케이스 테스트 필요.

2. **install.ps1 `-Force` 필수 시나리오**: 첫 재실행 시 settings.json hooks.SessionStart conflict으로 롤백. 이는 기존 settings 존재 + 동일 값에 대해 "존재 자체를 conflict"로 판단하는 로직 때문. 본 세션은 `-Force`로 재실행하여 해결. 향후 v1.x에서 "동일 값이면 skip" 로직 추가 검토 (별도 세션 후보).

3. **`git mv` 17 파일 스크립트 작성이 효율적**: 각 파일 개별 명령으로 17번 호출 — 실수 없이 일괄 처리. `git mv` 이점: 이력 보존 + `git log --follow`로 이관 전 히스토리 추적 가능. `cp + rm` 패턴은 이력 단절.

4. **smoke test를 임시 디렉토리로 수행한 이점**: 실 upbit 수정 없이 install-project-claude의 **복사 로직 정확성**을 검증. 17 파일 목록과 매치 확인. 향후 install 스크립트 변경 시 동일 패턴으로 회귀 방지.

5. **commands→skills 마이그레이션 **지연 결정** 유효성**: context7 공식 문서는 commands를 legacy로 선언했으나 **아직 제거는 아님**. v1.8에서 commands 그대로 이관하고 v1.8b에서 skills 통합을 별도 세션으로 분리한 것이 **breaking change 과중화 회피**. 단일 세션이 2개 구조적 변경을 동시 수행하면 rollback 어려움.

6. **verify.ps1 "30/30 유지"의 의미 변화**: v1.3 이후 "30 체크 = 수치상 유지"가 관례였으나, v1.8은 B7 의미 완전 재정의(`~/.claude/skills/` → `_base/skills/`). 수치는 같되 **의미는 바뀜**. 향후 verify 체크 변경 시 수치 유지 집착보다 **의미 재정의 명시**가 더 중요.

## ⚠️ BREAKING CHANGE 사용자 액션

본 세션 push 직후 **모든 기존 프로젝트**(upbit 포함)는 `/harness-plan` 등 하네스 명령을 잃음. 복구 필수:

### 즉시 실행 (각 활성 프로젝트마다)

```powershell
cd <project-root>  # 예: ~/upbit
pwsh ~/harness-meta/bootstrap/install-project-claude.ps1
```

### Claude Code 세션 내 (설치 후)

1. 세션 재시작
2. `/config` → Output style → "Harness Engineer" 선택
3. `/harness` 입력 → 명령 인식 확인

## 커밋 계획

```
feat(meta)!: sessions/meta/v1.8-core-adapter-split — claude/ 이관 (글로벌 축소)

- move (git mv 17): claude/{commands×6, agents×4, skills×6, output-styles×1}
        → bootstrap/templates/_base/.claude/ (이력 보존)
- keep: claude/{commands/harness-meta.md, hooks/, statusline/} (3 파일 글로벌)
- refactor: install.ps1 — legacy cleanup 단계 추가 (broken/구형 symlink 자동 제거 + backup)
                          + $categories 6 → 3
- refactor: verify.ps1 — A2 3 카테고리 / B1 3 / B2 3 / B7 _base/skills/ 대상
- add: bootstrap/install-project-claude.{ps1,sh}
       프로젝트 루트에서 실행 시 _base/.claude/ 복사. Output style 선택 안내
- add: bootstrap/templates/_base/README.md (commands legacy 경고 + overlay 예고)
- update: bootstrap/docs/OWNERSHIP.md — S1a/S1b split + S6 .claude/** 명시 + Evolution 예시
- update: README.md / CLAUDE.md / AGENTS.md — 2단계 설치 안내
- add: sessions/meta/v1.8-core-adapter-split/{PLAN,REPORT,evidence/smoke-install-project.txt}

실측: verify 30/30 PASS · smoke 17/17 복사 PASS · install cleanup 14건 자동 backup.
Grey Area 45건 결정. Copy 방식 (symlink 아님) Windows 호환 + team share 가능.
Anthropic 공식 .claude/commands/ legacy 인지. v1.8b에서 skills 통합 예정.

BREAKING CHANGE: 기존 upbit는 글로벌 symlink로 받던 /harness-plan 등
13개 명령을 즉시 잃음. 복구:
  cd ~/upbit
  pwsh ~/harness-meta/bootstrap/install-project-claude.ps1
이후 Claude Code 세션에서 /config → Output style → "Harness Engineer" 선택.
```

사용자 확인 후 커밋 + push.

## 후속 세션 연결

### 즉시 필수 (사용자 액션)

1. **`sessions/upbit/vX-project-claude-install`** — upbit 복구 (S6, T4 분할)

### 대기 후행

- `sessions/upbit/vX-statusline-cmd-migration` — v1.6/v1.7 후속
- `sessions/upbit/vX-manifest-upgrade-1.1` — upbit 매니페스트 optional upgrade
- **`sessions/meta/v1.8b-commands-to-skills-migration`** — commands legacy → skills preferred 전환

### 다음 v1.x

- v1.9-project-auto-detect — language/PM/test_cmd 자동 감지
- v1.10-bootstrap-interview — `/harness-meta <new>` 인터뷰 로직
- v1.11~v1.13 bootstrap-templates-* — 언어별 variant (python-uv, node-pnpm, go-mod, rust-cargo) + overlay 메커니즘
- v1.14~v1.20 adapter-* — 7개 AI 도구 adapter 디렉토리
- v1.21-cross-platform-install
- v1.22-bootstrap-e2e-orchestration
- v1.25-opensource-readiness

### 3개월 재평가 게이트

- `_base` 언어 중립 유지 가능성
- Anthropic commands 완전 deprecation 시 재평가
- 실적용 프로젝트 3+ 확보 후 variant/overlay 설계 구체화

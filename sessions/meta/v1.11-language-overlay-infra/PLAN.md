# meta v1.11-language-overlay-infra — PLAN

세션 시작: 2026-04-28
직접 선행 세션:

- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Scope contract 의무화 (본 세션이 첫 정식 적용)
- [`sessions/meta/v1.8-core-adapter-split/`](../v1.8-core-adapter-split/PLAN.md) — `bootstrap/templates/_base/.claude/` 신설 (overlay 전제)

목적: `bootstrap/templates/<language>/.claude/` 언어별 overlay **인프라**만 도입. install-project-claude.{sh,ps1}에 language 추출 + overlay merge 분기 추가. 실 overlay 콘텐츠는 0 (placeholder `.gitkeep`만) — evidence 누적 후 v1.11b+에서 단계 도입.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(4) `bootstrap/{install-project-claude.sh, install-project-claude.ps1, manifest-schema.md, docs/OVERLAY.md(신규)}` + S2(1) `bootstrap/templates/python/.claude/.gitkeep` + S2(1) `CLAUDE.md` cross-ref + S3(2) `tests/{smoke-language-overlay.sh, smoke-scope-contract.sh}` + S3(1) `README.md` = **9/9 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — meta scope 9/9
- **T2 스펙 vs 값** — overlay 디렉토리 규약 = 모든 프로젝트 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `CLAUDE.md` 디렉토리 구조 § (verbatim)**:

> `└── <language>/             # 언어별 overlay (v1.11+ 예정)`

**Source 2 — `bootstrap/interview.md` 명시적 omit § (verbatim)**:

> `## 명시적 omit (생성 안 함, 7건 — v1.11+ overlay 또는 사용자 후속)`

**Source 3 — `bootstrap/docs/INTERVIEW_FLOW.md` Stage S5 (verbatim)**:

> `<proj>/{HM_CODE_DIR}/는 v1.11+ overlay 또는 사용자 안내 (S10에서)`

**Source 4 — 사용자 발의 (2026-04-28) verbatim**:

> "**A안 — 인프라만**: `bootstrap/templates/<lang>/.claude/` 디렉토리 규약 + install-project-claude `language` 감지 후 overlay merge logic + 1개 placeholder overlay (`python/.claude/.gitkeep`) + Smoke"

**Parsed sub-items (4)**:

1. **`bootstrap/templates/<language>/.claude/` 디렉토리 규약** — 언어별 overlay 위치 + 우선순위 (overlay > _base) 정의
2. **install-project-claude.{sh,ps1} overlay merge 분기** — `.harness.toml`에서 language 추출 → overlay 디렉토리 존재 시 _base 위에 추가 복사
3. **placeholder overlay 1건 — `python/.claude/.gitkeep`** — 디렉토리 규약 검증용. 실 콘텐츠 0
4. **Smoke** — 인프라 검증 (정적 + 기존 fixture 활용 dynamic) + scope contract self-test

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 실 overlay 콘텐츠 (Python `harness-python/SKILL.md` 등) | v1.11b+ (evidence 누적 후) |
| TypeScript / Go / Rust / Java / Kotlin / C# / Ruby / Elixir overlay | v1.11c+ (언어별 별 세션) |
| `<proj>/{HM_CODE_DIR}/` 골격 자동 생성 | 별 후속 (v1.12 또는 v1.11d) |
| Bootstrap S10 안내 갱신 (overlay 활성 안내) | v1.11b 이후 (실 overlay 도입 시 동시) |
| INTERVIEW_FLOW.md S6 "14 파일" 표기 갱신 (overlay 도입 후 N+M) | v1.11b 이후 (S10과 동시) |
| AGENTS.md.tmpl 언어별 분기 | v1.5 §8.3 manual policy 그대로 (별 후속 evidence-driven) |
| `[project].locale` 기반 다언어 overlay | 별 도메인 (v1.10+ omit 항목) |
| `.agents/skills/` adapter overlay | v1.14~v1.20 adapter 세션 (별 도메인) |
| Language alias map (`py` → `python`, `c#` → `csharp`) | 별 후속 evidence-driven (현재는 detect-project.sh exact 출력만 지원) |
| Legacy cleanup overlay-aware 확장 (v1.9b 로직이 `<language>/` 도 검사) | 별 후속 (`-Force` 재실행으로 해결 — OVERLAY.md 한계 명시) |
| verify.ps1 overlay 무결성 체크 | v1.21-cross-platform-install (verify 통합 시점) |

## 1. 문제 (인프라 부재)

### 현재 상태

- `bootstrap/templates/_base/.claude/` 17 파일 = 언어 불문 baseline
- 언어별 특화 (Python `pyproject.toml` 검증 skill, TS `tsc --noEmit` skill 등) 진입점 없음
- `bootstrap/templates/<language>/` 디렉토리 자체 부재 → "어디에 둘지" 규약 부재
- install-project-claude.{sh,ps1}는 `_base` 하나만 복사 (overlay merge logic 없음)

### Root cause

**합의된 디렉토리 구조 + merge 동작 부재** → 언어별 overlay 작성자(향후 v1.11b 등)가 "어디에 무엇을 두는가"를 매 세션 재발명하는 비용.

### 본 세션 해결 범위

**인프라만**: 디렉토리 규약 + merge logic + naming convention + placeholder 1건 + 단일 소스 doc + 정적/dynamic smoke + scope contract self-test. 실 콘텐츠 0.

## 2. 결정 (R1 ~ R5)

### R1 — 디렉토리 규약 + Naming convention

**위치**: `bootstrap/templates/<language>/.claude/{commands,agents,skills,output-styles}/`

**우선순위** (merge 시):

1. `_base/.claude/<cat>/<name>` — 언어 불문 baseline
2. `<language>/.claude/<cat>/<name>` — overlay (동일 이름 시 **base 위에 덮어쓰기 = overlay 승**)

**언어 식별자 매트릭스** (10건 — `detect-project.sh` v1.10e3과 1:1 정합):

| `[project].language` (lowercase) | overlay dir |
|---|---|
| `python` | `templates/python/` |
| `typescript` | `templates/typescript/` |
| `javascript` | `templates/javascript/` |
| `go` | `templates/go/` |
| `rust` | `templates/rust/` |
| `java` | `templates/java/` |
| `kotlin` | `templates/kotlin/` |
| `csharp` | `templates/csharp/` |
| `ruby` | `templates/ruby/` |
| `elixir` | `templates/elixir/` |
| (그 외 또는 빈 값) | overlay 없음 → _base only |

**현 시점 실재 디렉토리**: `python/` 1건만 (placeholder, sub-dir 없음). 나머지 9건은 v1.11b+에서 evidence-driven 도입.

**Language 정규화** (D4 결정 — option B):

- `.harness.toml` `[project].language` 값을 **lowercase**로 변환 후 매치
- `Python` / `PYTHON` / `python` 모두 `python` overlay와 매치
- alias (`py` → `python` 등)는 **불지원** (Out of scope) — 사용자가 정확한 표준명 입력 의무
- 빈 값 / unknown → overlay 단계 silent skip

**Reserved prefix**: `_*` (e.g., `_base`)는 sentinel directory. language overlay name으로 사용 금지.

**Naming convention** (D13 결정 — option 3, `harness-*` prefix 보호):

- overlay item (commands/agents/skills/output-styles의 file 또는 sub-dir) 이름은 **`harness-*` prefix 의무**
- 사용자 custom 파일은 다른 이름 (`my-skill/`, `custom-foo/` 등) 사용 컨벤션
- 효과: C2 충돌 시나리오 사실상 0 — overlay가 사용자 custom을 silent overwrite할 가능성 제거
- legacy cleanup (v1.9b)의 `harness*` prefix 가정과 자연 정합
- 본 v1.11 인프라에서 enforce 안 함 (regex 검증 없음). v1.11b+ 실 overlay 작성 시 컨벤션 준수 의무. OVERLAY.md에 명시

### R2 — install-project-claude.{sh,ps1} merge logic

**알고리즘** (.sh / .ps1 의미 동등):

```
Phase 1 — _base 복사 (현행 유지)
  pre-flight: _base 카테고리 4종 conflicts 스캔 (사용자 custom 파일 vs _base) → C1
  if C1 conflicts:
    if not -Force: abort + 충돌 경고
    if -Force: backup-<ts>/ 이동 후 덮어쓰기
  copy _base/<cat>/* → <proj>/.claude/<cat>/* (cp -r / Copy-Item -Recurse)

Phase 2 — overlay 추가 복사 (신규 v1.11)
  language = grep+sed `.harness.toml` [project].language → tr 'A-Z' 'a-z' (lowercase)
  if language empty or language matches _<reserved>:
    info "no language overlay (language='<value>')"
    return
  overlay_dir = templates/<language>/.claude/
  if not exists(overlay_dir):
    info "no language overlay dir for '<language>'"
    return
  for cat in commands/agents/skills/output-styles:
    overlay_cat=overlay_dir/<cat>
    if not exists(overlay_cat): continue
    mkdir -p <proj>/.claude/<cat>   # _base에 없는 카테고리 대비
    for item in overlay_cat/*:
      name=$(basename "$item")
      if [ "$name" = ".gitkeep" ]: skip   # git artifact (top-level)
      dst=<proj>/.claude/<cat>/<name>
      if [ -e "$dst" ]: info "overlay overwrite: <cat>/<name>"
      cp -r "$item" "$dst"   # 디렉토리 통째 또는 file 단일 (D12 명시)
                              # PowerShell: Copy-Item -Path $item -Destination $dst -Recurse -Force
                              # sub-dir 내 .gitkeep은 cp -r에 자연 포함 (의도)
```

**충돌 시나리오 정책** (D2 + D13 결정):

| # | 시나리오 | 정책 |
|---|---|---|
| **C1** | 사용자 custom vs `_base` (Phase 1) | 현행 유지 — abort 또는 `-Force` backup 후 덮어쓰기 |
| **C2** | `_base` 또는 사용자 vs overlay (Phase 2) | overlay 자동 덮어쓰기 + log "overlay overwrite". backup 무. **Naming convention (`harness-*` prefix)으로 사용자 custom 충돌 0 보장** |
| **C3** | 첫 install 후 overlay 추가/삭제 + 재install | 사용자가 `-Force` 재실행 (C1 정책 흡수). 자동 cleanup 안 함 (Out of scope) |

**Recursion** (D12 명시): overlay item이 file이면 file 복사, dir이면 디렉토리 통째 (`cp -r` / `Copy-Item -Recurse -Force`). sub-dir 내 `.gitkeep`은 cp -r에 자연 포함 (의도). top-level `.gitkeep`만 explicit skip.

**Idempotency**: overlay 부재 / language 빈 값 — 정상 진행 (인터프리터 언어 misc 가능). 기존 install 회귀 0.

**`.gitkeep` skip** (D3 cross-platform 정합):

- bash: top-level glob 자연 dotfile 제외 + 명시적 검사 추가 (방어적)
- PowerShell: `Get-ChildItem` 호출에 `Where-Object { $_.Name -ne '.gitkeep' }` 명시 필수

**Header 갱신** (D14): 양 스크립트 헤더 (Usage/Description) 1줄 추가:

```
v1.11+: [project].language 기반 <language>/.claude/ overlay merge.
```

### R3 — placeholder `python/.claude/.gitkeep`

**파일**: `bootstrap/templates/python/.claude/.gitkeep` (빈 파일)

**역할**:

- 디렉토리 규약 git tracking
- install logic 분기 동작 검증 (smoke가 dir 존재 확인)
- v1.11b+에서 실 overlay 도입 시 `commands/`, `skills/` 등 sub-dir 추가

### R4 — 문서: `bootstrap/docs/OVERLAY.md` 신설 + 3 cross-reference

**`bootstrap/docs/OVERLAY.md`** (신규, ~100~140 lines):

1. 개요 (인프라만 v1.11, 실 콘텐츠 v1.11b+)
2. 디렉토리 규약 (R1)
3. Language 매트릭스 10건
4. Language 정규화 (lowercase)
5. Reserved prefix (`_*`)
6. **Naming convention (`harness-*` prefix)** — D13
7. Merge 알고리즘 (R2 — Phase 1/2)
8. 충돌 시나리오 C1/C2/C3
9. `.gitkeep` skip 규약 (top-level only, sub-dir 자연 포함)
10. Recursion 동작 (file vs directory)
11. **Legacy cleanup 한계 (v1.9b는 `_base`만 검사)** — D16
12. 빈 overlay / unknown language 동작
13. v1.11 scope vs 향후 (v1.11b/c/d, adapter overlay v1.14+)
14. 관련 문서 cross-reference

**Cross-reference 갱신 (3 파일)**:

- `bootstrap/manifest-schema.md` §6.2 1줄: `language` 값은 overlay dir name으로도 사용. 상세 OVERLAY.md
- `README.md` 디렉토리 구조 `<language>/` 1줄 v1.11 active 표기
- `CLAUDE.md` "관련 문서" § 1줄 OVERLAY.md 추가 (F2)

### R5 — Smoke (8 + scope contract)

**`tests/smoke-language-overlay.sh` 신규** (정적 4 + dynamic 4 = 8 checks):

```bash
Stage 1 — 정적 인프라 (4 checks)
  ✓ bootstrap/templates/python/.claude/.gitkeep 존재
  ✓ install-project-claude.sh: language 추출 + lowercase + overlay merge + .gitkeep skip
  ✓ install-project-claude.ps1: 동상 + Where-Object .gitkeep skip 명시
  ✓ bootstrap/docs/OVERLAY.md 존재 + 14 § keyword 매치

Stage 2 — Dynamic install (4 checks, fixture 활용)
  Setup:
    tmpdir=$(mktemp -d)
    cp -r tests/fixtures/sample-project/. tmpdir/
    # sample-project: language="python", schema_version="1.0", .claude/ 부재

  ✓ bash install-project-claude.sh "$tmpdir" → exit 0
  ✓ tmpdir/.claude/{agents,skills,output-styles}/ 디렉토리 생성됨 (_base 정상 복사)
  ✓ tmpdir/.claude/skills/harness/SKILL.md 존재 (_base 카테고리 내 sub-dir 검증)
  ✓ tmpdir/.claude/.gitkeep 부재 (top-level overlay .gitkeep skip 정합)

  Cleanup: rm -rf tmpdir
```

**`tests/smoke-scope-contract.sh` 갱신** (D11 — option B 자동 enumerate):

```bash
# 기존 hard-coded 3건 → glob 패턴으로 자동 enumerate
for plan in sessions/meta/v1.10h*/PLAN.md sessions/meta/v1.10j*/PLAN.md sessions/meta/v1.11*/PLAN.md; do
  [ -f "$plan" ] || continue
  label=$(basename "$(dirname "$plan")" | sed 's/-.*//')
  check_plan "$plan" "$label"
done
```

→ 향후 v1.10/v1.11 prefix 세션 자동 흡수 (smoke 갱신 없이). v1.10h 이전 legacy 자연 제외.

**한계**:

- PowerShell .ps1 dynamic 검증은 verify.ps1 통합 시점 (v1.21)으로 이연 — sh smoke가 알고리즘 동등 검증 (정적 grep으로 .ps1도 포함)
- backward compat (`schema_version = "1.0"` fixture 사용) 자연 검증 ✓

## 3. 변경 대상 (6 수정 + 5 신규)

### 수정 (6)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/install-project-claude.sh` | S2 | R2 — 헤더 1줄 + Phase 2 신설 (language 추출 + lowercase + overlay merge + .gitkeep skip + C2 + cp -r recursion) |
| `bootstrap/install-project-claude.ps1` | S2 | R2 — 동상 (PowerShell idiom: Where-Object .gitkeep skip + Copy-Item -Recurse) |
| `bootstrap/manifest-schema.md` | S2 | R4 — `[project].language` 1줄 cross-reference |
| `README.md` | S3 | R4 — 디렉토리 구조 `<language>/` v1.11 active |
| `CLAUDE.md` | S3 | R4 — "관련 문서" § OVERLAY.md cross-ref 1줄 (F2) |
| `tests/smoke-scope-contract.sh` | S3 | R5 — D11 자동 enumerate (hard-coded 3 → glob) |

### 신규 (5)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/templates/python/.claude/.gitkeep` | S2 | R3 — placeholder |
| `bootstrap/docs/OVERLAY.md` | S2 | R4 — 단일 소스 (14 §) |
| `tests/smoke-language-overlay.sh` | S3 | R5 — 정적 4 + dynamic 4 = 8 checks |
| `sessions/meta/v1.11-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.11-.../REPORT.md` | meta | Stage G |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + D1~D17 정밀 분석 반영
- [ ] **사용자 진입 확인**
- [ ] Stage A — `python/.claude/.gitkeep` 신규
- [ ] Stage B — `OVERLAY.md` 신규 (14 §)
- [ ] Stage C — install-project-claude.sh (헤더 + Phase 2 + naming convention 주석)
- [ ] Stage D — install-project-claude.ps1 (동상 + PowerShell idiom)
- [ ] Stage E — manifest-schema.md + README.md + CLAUDE.md (3 cross-ref)
- [ ] Stage F — smoke-language-overlay.sh (8) + smoke-scope-contract.sh 갱신 (D11)
- [ ] Stage G — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `bootstrap/templates/python/.claude/.gitkeep` 존재
- [ ] `bootstrap/docs/OVERLAY.md` 존재 + 14 § 모두 작성
- [ ] install-project-claude.sh: 헤더 + Phase 2 + language extract + lowercase + .gitkeep skip + C2 + cp -r
- [ ] install-project-claude.ps1: 동상 + Where-Object skip + Copy-Item -Recurse
- [ ] manifest-schema.md: OVERLAY.md cross-ref 1줄
- [ ] README.md: 디렉토리 구조 1줄 갱신
- [ ] CLAUDE.md: 관련 문서 OVERLAY.md 1줄
- [ ] smoke-language-overlay.sh 8/8 PASS (정적 4 + dynamic 4)
- [ ] smoke-scope-contract.sh D11 갱신 PASS (v1.11 PLAN 자동 검사)
- [ ] **회귀 0** (sample-project fixture로 검증)
- [ ] **upbit 영향 0** — `language="python"` + 재install 시 dest 변동 0 (Phase 2 no-op, python/ overlay sub-cat 부재) — D17

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.11-language-overlay-infra — language overlay 디렉토리 규약 + install merge 분기

- add: bootstrap/templates/python/.claude/.gitkeep (R3 placeholder)
- add: bootstrap/docs/OVERLAY.md (R4 — 14 § 단일 소스)
- update: bootstrap/install-project-claude.sh (R2 — 헤더 + Phase 2 + lowercase + .gitkeep skip + C2 + cp -r)
- update: bootstrap/install-project-claude.ps1 (R2 — 동상 + Where-Object + Copy-Item -Recurse)
- update: bootstrap/manifest-schema.md (R4 — overlay cross-ref 1줄)
- update: README.md (R4 — 디렉토리 구조 <language>/ v1.11 active)
- update: CLAUDE.md (R4 — 관련 문서 OVERLAY.md cross-ref)
- update: tests/smoke-scope-contract.sh (D11 — 자동 enumerate)
- add: tests/smoke-language-overlay.sh (R5 — 정적 4 + dynamic 4 = 8 checks)
- add: sessions/meta/v1.11-.../{PLAN,REPORT}.md

Scope: 인프라만 (실 overlay 콘텐츠 0).
- 디렉토리 규약 (10 lang matrix detect-project.sh 정합) + lowercase + reserved _* + harness-* prefix convention
- merge 알고리즘 (Phase 1 _base + Phase 2 overlay) + 충돌 정책 C1/C2/C3 + cp -r recursion
- 실 overlay (Python skill 등)는 v1.11b+ evidence-driven

Smoke: 8/8 PASS (정적 4 + dynamic 4 sample-project fixture) + scope contract self-test PASS.
회귀 0 — upbit 영향 0 (python/ overlay sub-cat 부재 → Phase 2 no-op).
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.11b-overlay-python-skill` | Python 사용자 1+ 발생 시. `python/.claude/skills/harness-python/SKILL.md` (harness-* prefix 준수) |
| `v1.11c-overlay-typescript` | TS 사용자 발생 시. `typescript/` 신설 + Python overlay 패턴 재사용 |
| `v1.11d-codedir-skeleton` | `<proj>/{HM_CODE_DIR}/` 골격 자동 생성 (별 도메인) |
| `v1.10i-license-case3-enhancement` | LICENSE Case 3 evidence 3+ 누적 시 (이미 보류 결정) |
| `v1.21-cross-platform-install` | verify.ps1에 overlay 무결성 체크 통합 + legacy cleanup overlay-aware |
| `v1.14~v1.20-adapter-*` | `.agents/` adapter overlay 도메인 (Cursor/Codex/Gemini) |

## 8. Lessons Forward (예상)

- **L1 — 2단계 면밀 분석이 PLAN 결함 12건 사전 발견** — 1차 D1~D10 + 2차 D11~D17. 첫 PLAN의 fixture 부재/매트릭스 누락/충돌 정책 미정/.gitkeep ps1 누락/문서 위치/scope contract self-test 누락/recursion 미정/naming convention/header stale/legacy cleanup 한계/upbit 회귀 → "여러 방면 재분석" 단계 정형화 가치
- **L2 — overlay merge는 Phase 분리 + C1/C2/C3 + naming convention으로 안전 단순화** — `harness-*` prefix가 사용자 custom 보호의 결정적 mechanism
- **L3 — detect-project.sh와 install-project-claude language 매트릭스 1:1 정합** — 한 도구 변경 시 다른 도구 동시 갱신 의무 (향후 언어 추가 시 양쪽 동시)
- **L4 — Scope contract 첫 정식 적용 시 self-test 의무** — D11 발견은 "scope contract mechanism이 자기 자신을 검증해야 mechanism 강화" 원칙의 인스턴스

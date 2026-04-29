# meta v1.23-verify-unification — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.22-install-unification/`](../v1.22-install-unification/PLAN.md) — install 흐름(copy mode + sync-agents) 통합. v1.23은 read-only verify 흐름 통합.
- [`sessions/meta/v1.21-install-cleanup-foundation/`](../v1.21-install-cleanup-foundation/PLAN.md) — F+A+B 묶음을 v1.23에 분리 명시.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3×6 (`verify.{ps1,sh}`, `verify-lib.sh`, `tests/smoke-verify-sh-parity.sh`, `tests/smoke-scope-contract.sh`, `README.md`, `CLAUDE.md`) + S2×2 (`PERMISSION_PATTERN.md`, `OVERLAY.md`) = **8/8 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — 전체 meta scope (글로벌 verify + 정책 doc)
- **T2 스펙 vs 값** — verify spec + frontmatter 6축 + overlay 무결성 = 모든 프로젝트 영향

## Scope inheritance (verbatim from v1.21)

**Source — `sessions/meta/v1.21-install-cleanup-foundation/PLAN.md` Out of scope 표 (verbatim)**:

> | verify.ps1 overlay 무결성 체크 + frontmatter 6축 통합 | **v1.23-verify-unification** (F+A+B 묶음) |
> | `verify.sh` 신설 (현재 verify.ps1 Windows-only) | v1.23-verify-unification |

**Parsed sub-items (3)**:

1. **F: `verify.sh` 신설** — Linux/macOS용 verify 스크립트. `verify.ps1` 8 stage(Z/A/B/C/D/E/F/G)를 cross-platform mirror. Windows-only stage(A1 Dev Mode, A3a Git Bash)는 OS 분기 자연 skip.
2. **A: frontmatter 6축 통합** — `bootstrap/docs/PERMISSION_PATTERN.md` V1/V5/V7/V8/V10 5건을 verify의 새 stage I에 통합. V4/V9는 dev-time smoke 전용 유지.
3. **B: overlay 무결성** — `bootstrap/templates/<lang>/.claude/` 매트릭스 정합 + `harness-*` prefix convention + SKILL.md frontmatter 최소 필드를 verify의 새 stage H에 통합.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| macOS/Linux dynamic CI 검증 (제3 기기) | **v1.24-multi-os-validation** |
| C8 changelog 2.1.111 (`cd && glob`) auto-allow 매트릭스 보강 | 별 후속 evidence-driven |
| effort 다양 값 (`medium`/`high`) 매트릭스 — 현재 `xhigh` 권고만 명시 | v1.10g 확장 (별 후속) |
| jq 단독 의존 (python3 부재 환경) | python3 우선 fallback으로 회피 — 양쪽 부재 시 C 단계 SKIP+WARN |
| macOS BSD `readlink` vs GNU `readlink` 차이 | python3 `os.path.realpath` 통일로 회피 |
| settings.json `permissions.deny` rule 검증 | 본 세션 scope 외 (사용자 자유) |
| settings.json auto-allow 잔존 검증 | 별 도메인 (`fewer-permission-prompts` skill 영역) |
| WSL bash 환경에서의 verify.sh 거동 | v1.24-multi-os-validation |
| pre-commit hook으로 verify 자동 실행 | 별 후속 evidence-driven |
| verify의 `--fix` 자동 정정 모드 | 별 후속 (현재는 read-only) |
| Section 3 conflict cleanup overlay-aware (사용자 custom vs overlay) | 별 후속 — `harness-*` prefix convention으로 충돌 0 보장 (OVERLAY.md §6) |
| `[project].language` array 또는 multi-overlay | 별 도메인 (현재 single language 가정) |
| `<lang>` 매트릭스 외 언어 (haskell 등) overlay | v1.11c+ (언어별 별 세션) |

## 1. 문제

### F: verify.sh 부재 — Windows-only verify

`verify.ps1`은 530 lines로 8 stage(Z/A/B/C/D/E/F/G) 자동화 검증 + manual 체크리스트 제공. 그러나 macOS/Linux 사용자는 **설치 후 자가 검증 수단 없음**. `bootstrap/docs/AGENTS_MD_STRATEGY.md` §11에 명시된 verify 8 체크(A1~A8) 중 Windows 사용자만 활용 가능.

### A: frontmatter 6축 verify 미통합

`bootstrap/docs/PERMISSION_PATTERN.md` §10에 V1/V4/V5/V7/V8/V9/V10 정의되어 있고, `tests/smoke-bash-permission-pattern.sh` + `smoke-thinking-effort.sh`에서 dev-time CI 검증. 그러나 사용자가 `install.ps1` 실행 후 `verify.ps1`로 자가 진단하는 흐름에서 **frontmatter 6축은 검증 대상 아님**. install 직후 사용자 환경에서 frontmatter spec 위반(예: `thinking:` 잔존, 콜론 없음 패턴) 발생 시 발견 지연.

### B: overlay 무결성 verify 미통합

`bootstrap/docs/OVERLAY.md` §13 v1.21 항목에 명시:
> **v1.23 (예정, 후속)**: verify.sh 신설 + verify.ps1에 overlay 무결성 + frontmatter 6축 통합

현재 `bootstrap/templates/<lang>/.claude/` 디렉토리 규약 + `harness-*` prefix convention + SKILL.md frontmatter 최소 필드는 **자동 검증 없음**. `python/.claude/skills/harness-python/SKILL.md` (v1.11b) 같은 실 overlay 도입 후에도 무결성 자동 보장 mechanism 부재.

## 2. 결정 (R1 ~ R9)

### R1 — verify.sh 신설 (cross-platform mirror)

`verify.ps1`의 Z/A/B/C/D/E/F/G 8 stage를 bash 4+ 기준 mirror. Windows-only 항목은 OS 분기 자연 skip:

| stage | macOS/Linux 거동 |
|------|----------------|
| **Z1** | `uname -s` 매치 (Linux/Darwin) — 그 외 ERR |
| **Z2** | `BASH_VERSINFO[0] -lt 4` ERR (render-manifest.sh와 동일 기준) |
| **Z3** | `cd "$MetaRoot" && pwd -P` 정규화 |
| **A1** | **SKIP** (Linux/macOS 자연 symlink 권한 보유 — info "Dev Mode N/A") |
| **A2** | 3 카테고리 디렉토리 존재 (`-d`) |
| **A3a** | **SKIP** (system bash — info "Git Bash N/A") |
| **A3b** | `command -v python3` (optional) |
| **B1~B7** | `[ -L "$f" ]` + `verify-lib.sh::test_symlink_integrity` |
| **C0~C9** | `python3 -c "import json"` 우선 → `jq` fallback → 둘 다 없으면 SKIP+WARN |
| **D1~D3** | `bash hook.sh` 직접 실행 (자연 동등) |
| **E1~E3** | `bash statusline.sh` 직접 실행 (자연 동등) |
| **F** | `find "$ClaudeDir" -maxdepth 1 -type d -name 'backup-*'` |
| **H1~H3** | (R3) overlay 무결성 — sh/ps1 동등 |
| **I1~I5** | (R4) frontmatter 6축 — sh/ps1 동등 |
| **G** | echo 6줄 manual 체크리스트 |

### R2 — `verify-lib.sh` 신설

bash 함수 1건:

```bash
# verify-lib.sh
test_symlink_integrity() {
    local path="$1"
    local meta_root="$2"
    local expected_target="${3:-}"

    [ -L "$path" ] || { echo "LinkType=NotASymlink"; return 1; }

    local target
    target=$(python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$path" 2>/dev/null)
    [ -n "$target" ] && [ -e "$target" ] || { echo "target_not_exist:$target"; return 1; }

    if [ -n "$expected_target" ] && [ "$target" != "$expected_target" ]; then
        echo "target_mismatch:$target (expected:$expected_target)"
        return 1
    fi

    if [ -n "$meta_root" ]; then
        local meta_norm
        meta_norm=$(python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$meta_root" 2>/dev/null)
        case "$target" in
            "$meta_norm"/*) ;;
            *) echo "target_outside_meta:$target (meta:$meta_norm)"; return 1 ;;
        esac
    fi
    return 0
}
```

`verify-lib.ps1`는 변경 0 — `Test-SymlinkIntegrity` 그대로 유지.

### R3 — Stage H (Overlay 무결성) — verify.{ps1,sh} 양쪽 추가

| ID | 항목 | 정합 조건 |
|----|------|----------|
| **H1** | overlay 매트릭스 enumerate | `bootstrap/templates/`에서 `_*` reserved prefix 부재 + 실재 디렉토리(`<lang>`)는 OVERLAY.md §3 10 lang 매트릭스 또는 `_base` 중 하나 |
| **H2** | overlay item naming convention | 각 `<lang>/.claude/{commands,agents,skills,output-styles}/<item>` 이름이 `^harness-.+` 매치 (`.gitkeep` 제외) |
| **H3** | overlay SKILL.md frontmatter 최소 필드 | 각 `<lang>/.claude/skills/<name>/SKILL.md`가 `^name:` + `^description:` 보유 (context7 검증 — `code.claude.com/docs/en/skills`) |

H1~H3 모두 통과 → `Check-Ok H1~H3`. 실패 → `Check-Fail H#` 상세 메시지.

### R4 — Stage I (Frontmatter 6축) — verify.{ps1,sh} 양쪽 추가

PERMISSION_PATTERN.md V1/V5/V7/V8/V10 5건을 verify에 통합. 검증 대상 12 파일:
- `claude/commands/harness-meta.md`
- `bootstrap/templates/_base/.claude/skills/{harness, harness-plan, harness-design, harness-run, harness-ship, harness-review}/SKILL.md` (6)
- `bootstrap/templates/_base/.claude/agents/{harness-dispatcher, harness-explore, harness-grey-area, harness-verifier}.md` (4)
- `bootstrap/templates/python/.claude/skills/harness-python/SKILL.md` (overlay 1)

| ID | 체크 | 명령 (sh) | 기대 |
|----|------|----------|------|
| **I1** | V1 — 콜론 없는 `Bash(\w+\*)` 잔존 | `grep -cE 'Bash\([a-z][a-z\-]*\*\)'` | 0건 |
| **I2** | V5 — auto-allow set declare 잔존 | `grep -cE 'Bash\((ls\|cat\|head\|tail\|grep\|find\|wc\|diff\|stat\|du\|cd)([: ]\*?)?\)'` | 0건 |
| **I3** | V7 — slash command `allowed-tools:` 필드 | `grep -c '^allowed-tools:' claude/commands/harness-meta.md` | 1건 |
| **I4** | V8 — single-line 콤마 separator 잔존 | `grep -cE '^(allowed-tools\|tools):.+,'` | 0건 |
| **I5** | V10 — `^thinking:` 잔존 | `grep -cE '^thinking:'` | 0건 |

V4 (PERMISSION_PATTERN.md keyword)는 dev-time meta-check, V9 (YAML list count ≥3)는 파일별 가변 — 둘 다 smoke 전용 유지.

### R5 — Stage 순서

`verify.{ps1,sh}` 양쪽 stage 순서: **Z → A → B → C → D → E → F → H → I → G**

- B(Symlink)는 그대로 보존 (의미 분리)
- H(Overlay), I(Frontmatter 6축) 신규 stage
- G(Manual 체크리스트)는 마지막 (사용자 액션 안내 종결)

### R6 — settings.json 파싱 fallback (verify.sh C 단계)

```bash
parse_settings_json() {
    local file="$1"
    if command -v python3 >/dev/null 2>&1; then
        python3 -c "import json, sys; print(json.load(open(sys.argv[1])).get('$2', ''))" "$file" "$2" 2>/dev/null
    elif command -v jq >/dev/null 2>&1; then
        jq -r ".$2 // empty" "$file" 2>/dev/null
    else
        echo "__SKIP_NO_PARSER__"
        return 2
    fi
}
```

C 단계 진입 시 parser 부재 감지 → C0~C9 SKIP + `Check-Warn C "JSON parser 부재 (python3/jq) — settings.json 검증 SKIP"`. PASS/FAIL 카운터 무관.

### R7 — Smoke 설계: `tests/smoke-verify-sh-parity.sh` (정적 5 + dynamic 3 = 8 checks)

```
Stage 1 — 정적 (5 checks)
  S1.1 verify.sh 존재 + executable bit
  S1.2 verify-lib.sh 존재 + test_symlink_integrity 함수 grep
  S1.3 verify.ps1 stage H/I 신설 grep ("== H. Overlay" + "== I. Frontmatter")
  S1.4 verify.sh stage H/I mirror grep
  S1.5 stage 순서 1:1 — Z/A/B/C/D/E/F/H/I/G grep order check (양쪽 sh + ps1)

Stage 2 — Dynamic (3 checks, fixture 활용 + bash 4+ 환경에서만)
  Setup: bash 4+ + python3 가용 시만 진입 (else SKIP)
  
  ✓ verify.sh -MetaRoot $REPO 기본 실행 → exit 0 또는 1 (segfault 없음)
  ✓ verify.sh의 stage H 출력에 "harness-python" 매치 (overlay enumerate 정합)
  ✓ verify.sh의 stage I 출력에 "I1...I5" 5건 모두 등장
```

### R8 — 문서 갱신 (3 파일)

- **`bootstrap/docs/PERMISSION_PATTERN.md`** §10: V1/V5/V7/V8/V10 표 옆에 "v1.23+ verify 통합 (Stage I)" 1줄 추가
- **`bootstrap/docs/OVERLAY.md`** §13: v1.23 verify H1~H3 통합 항목 1줄
- **`README.md`**: "설치 후 자가 검증" § verify.sh 명령 + Stage H/I 명시
- **`CLAUDE.md`**: 명령어 § verify cross-platform 표기 (`pwsh verify.ps1` + `bash verify.sh`)

### R9 — Idempotency

verify는 read-only — 재실행 시 부수효과 0. 사용자가 install 후 검증 → 차이 발견 시 install 재실행 → verify 재실행 권장. fixture(`tests/fixtures/sample-project`, `empty-phases`, no-manifest tmpdir)는 verify.{ps1,sh} 양쪽 동일 사용.

## 3. 변경 대상 (5 신규 + 5 수정)

### 신규 (5)

| 경로 | scope | 역할 |
|------|------|------|
| `verify.sh` | S3 | R1 — Z/A/B/C/D/E/F/H/I/G mirror, OS 분기 skip |
| `verify-lib.sh` | S3 | R2 — `test_symlink_integrity` 함수 |
| `tests/smoke-verify-sh-parity.sh` | S3 | R7 — 정적 5 + dynamic 3 = 8 checks |
| `sessions/meta/v1.23-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.23-.../REPORT.md` | meta | Stage 종료 시 |

### 수정 (5)

| 경로 | scope | 변경 |
|------|------|------|
| `verify.ps1` | S3 | R3 stage H 신설 + R4 stage I 신설 + R5 순서 (Z/A/B/C/D/E/F/H/I/G) |
| `tests/smoke-scope-contract.sh` | S3 | v1.23 glob 1줄 추가 |
| `bootstrap/docs/PERMISSION_PATTERN.md` | S2 | R8 — §10 verify 통합 1줄 |
| `bootstrap/docs/OVERLAY.md` | S2 | R8 — §13 v1.23 verify H 통합 1줄 |
| `README.md` | S3 | R8 — verify.sh 명령 + Stage H/I 명시 |
| `CLAUDE.md` | S3 | R8 — 명령어 § verify cross-platform |

총 5 신규 + 6 수정 (PLAN/REPORT 별도) = **11 파일** + 본 세션 2 = **13 파일**.

(주의 — 위 표 합계 5 수정으로 표기했으나 실제 6 파일: verify.ps1 / smoke-scope-contract.sh / PERMISSION_PATTERN.md / OVERLAY.md / README.md / CLAUDE.md. 총 11 파일.)

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] context7 검증 — Claude Code 공식 spec C1~C10 정합
- [x] PLAN.md 작성 (D1~D9 결정 반영)
- [ ] **사용자 진입 확인**
- [ ] Stage A — `verify-lib.sh` 신설 (R2)
- [ ] Stage B — `verify.sh` 신설 (R1) — Z/A/B/C/D/E/F mirror + OS 분기 skip
- [ ] Stage C — `verify.sh` Stage H/I (R3+R4) + Stage G manual
- [ ] Stage D — `verify.ps1` Stage H/I 추가 (R3+R4) + 순서 갱신 (R5)
- [ ] Stage E — `tests/smoke-verify-sh-parity.sh` (R7 — 정적 5 + dynamic 3)
- [ ] Stage F — 문서 4 파일 갱신 (R8)
- [ ] Stage G — `tests/smoke-scope-contract.sh` v1.23 glob
- [ ] Stage H — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `verify.sh` 존재 + executable bit + Z/A/B/C/D/E/F/H/I/G 10 stage
- [ ] `verify-lib.sh` 존재 + `test_symlink_integrity` 함수
- [ ] `verify.ps1` Stage H (overlay) + Stage I (frontmatter 6축) 추가 + 순서 갱신
- [ ] `verify.sh` 본 repo 실행 → exit 0 또는 1 (segfault 없음). dynamic 3 PASS
- [ ] `verify.ps1` 본 repo 실행 → 기존 PASS 유지 + H/I PASS 추가
- [ ] `smoke-verify-sh-parity.sh` 8/8 PASS (Linux/macOS는 +3 dynamic)
- [ ] `smoke-scope-contract.sh` v1.23 self-test PASS
- [ ] **회귀 0** (smoke-bash-permission-pattern, smoke-thinking-effort 그대로 PASS)
- [ ] 문서 4 cross-ref 정합 (`PERMISSION_PATTERN.md` + `OVERLAY.md` + `README.md` + `CLAUDE.md`)

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.23-verify-unification — verify.sh 신설 + frontmatter 6축 + overlay 무결성

- add: verify.sh (R1 — Z/A/B/C/D/E/F/H/I/G mirror, OS 분기 skip)
- add: verify-lib.sh (R2 — test_symlink_integrity bash 함수)
- add: tests/smoke-verify-sh-parity.sh (R7 — 정적 5 + dynamic 3)
- update: verify.ps1 (R3+R4+R5 — Stage H overlay + I frontmatter 6축 + 순서 Z/A/B/C/D/E/F/H/I/G)
- update: bootstrap/docs/PERMISSION_PATTERN.md (R8 — V1/V5/V7/V8/V10 verify 통합 1줄)
- update: bootstrap/docs/OVERLAY.md (R8 — §13 v1.23 verify H 통합 1줄)
- update: README.md (R8 — verify.sh 명령 + Stage H/I)
- update: CLAUDE.md (R8 — 명령어 § verify cross-platform)
- update: tests/smoke-scope-contract.sh (v1.23 glob)
- add: sessions/meta/v1.23-.../{PLAN,REPORT}.md

context7 검증: /websites/code_claude bench 83.6 — C1~C10 (frontmatter spec / Bash pattern / auto-allow set / SessionStart hook / skill dir 표준).
Smoke: smoke-verify-sh-parity 8/8 (Linux/macOS dynamic 3 추가) + smoke-scope-contract v1.23 self-test PASS.
회귀 0 (smoke-bash-permission-pattern, smoke-thinking-effort, smoke-language-overlay, smoke-legacy-cleanup-overlay, smoke-skills-install, smoke-sync-agents 그대로).
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.24-multi-os-validation` | 제3 기기 또는 macOS/Linux CI 환경 확보 후. verify.sh dynamic 검증 + WSL bash 거동 |
| `v1.10g 확장 (effort 다양 값)` | `medium`/`high`/`xhigh` 매트릭스 evidence 후 |
| `v1.A4-readonly-update-2.1.111` | C8 changelog 보강 — `cd && glob` auto-allow 매트릭스 evidence 후 |
| `v1.B-verify-fix-mode` | verify의 `--fix` 자동 정정 모드 evidence-driven |
| `v1.C-precommit-hook` | pre-commit hook으로 verify 자동 실행 evidence-driven |

## 8. Lessons Forward (예상)

- **L1 — context7 인용으로 PERMISSION_PATTERN.md spec 정합 재확인** — v1.10d/v1.10g audit는 1차 스냅샷. context7 query (C1~C10)로 v1.23 시점 정합 재검증. 향후 SKILL/agent spec 변경 시 동일 패턴 (context7 → spec 갱신 세션)
- **L2 — Cross-platform verify는 lib 함수 분리가 결정적** — Windows/Linux 양쪽 mirror가 verify.{ps1,sh} 본문에 직접 들어가면 drift 위험. `Test-SymlinkIntegrity` (ps1) ↔ `test_symlink_integrity` (sh) 함수 동등성으로 mirror 보장
- **L3 — settings.json 파싱은 python3 우선 + jq fallback + SKIP** — 도구 의존성 단계화로 환경 이식성 확보. 향후 다른 JSON 검증 (.mcp.json 등) 동일 패턴
- **L4 — smoke vs verify 책임 분리 정형화** — smoke는 dev-time CI (V4/V9 포함 전체), verify는 사용자 환경 install 후 1회 (V1/V5/V7/V8/V10 5건). 향후 신규 spec 추가 시 두 카테고리 명시 의무

# meta v1.29-verify-fix-mode — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- [`sessions/meta/v1.28-source-matrix-expand/`](../v1.28-source-matrix-expand/REPORT.md) — 매트릭스 4 row + §4-2 재발 임계 = 1회 명문화. 본 세션은 §4-2 "재발 시나리오" 첫 행 (`v1.29-verify-fix-mode` — bash sed/awk + glob)에 해당 → bash 매트릭스 활용 첫 사례
- [`sessions/meta/v1.27-report-spec-verification/`](../v1.27-report-spec-verification/REPORT.md) — REPORT § 의무 도입. 본 세션 `--fix` 대상 = PLAN + REPORT 양쪽
- [`sessions/meta/v1.26-project-plan-verify/`](../v1.26-project-plan-verify/REPORT.md) — 프로젝트 PLAN § 의무 확장. `--fix`는 프로젝트 PLAN/REPORT도 skeleton 삽입 가능
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/REPORT.md) — § 의무 + skeleton 형식 단일 소스 (`SPEC_VERIFICATION.md §2 / §2-5`). 본 세션 `--fix`는 이 skeleton 그대로 삽입

목적: `tests/smoke-spec-verification.sh`에 `--fix` mode 추가. PLAN.md / REPORT.md에 `## Spec verification (context7)` § **누락** 시 SPEC_VERIFICATION.md §2 / §2-5 spec 정합 skeleton을 정확한 위치에 자동 삽입. v1.24 § 의무화 → v1.26/v1.27 확장으로 누적된 **수동 작성 부담** 제거 + skeleton drift 진입 비용 0.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(2) `tests/{smoke-spec-verification.sh, smoke-scope-contract.sh}` + S2(2) `bootstrap/{docs/SPEC_VERIFICATION.md, skills/harness-plan-verify/SKILL.md}` = **4/4 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — meta scope 4/4
- **T2 스펙 vs 값** — `--fix` mode = 모든 메타/프로젝트 PLAN+REPORT § 작성 단일 자동화 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.28-source-matrix-expand/REPORT.md` 다음 후보 (verbatim)**:

> | `v1.29-verify-fix-mode` | smoke `--fix` mode (§ skeleton 자동 삽입). 본 세션 매트릭스 활용 첫 사례 가능성 |

**Source 2 — `sessions/meta/v1.28-source-matrix-expand/PLAN.md §1 재발 시나리오 표 (verbatim)**:

> | 시나리오 | 재인용 source |
> |---------|------------|
> | `v1.29-verify-fix-mode` (smoke `--fix`) | bash sed/awk + glob 동작 |

**Source 3 — `sessions/meta/v1.27-report-spec-verification/REPORT.md` 다음 후보 (verbatim)**:

> | `v1.29-verify-fix-mode` | smoke `--fix` § skeleton 자동 삽입 |

**Source 4 — `bootstrap/docs/SPEC_VERIFICATION.md §2 PLAN skeleton (verbatim, single source)**:

> ```markdown
> ## Spec verification (context7)
>
> | sub-field | 값 |
> |-----------|---|
> | **library** | <Context7-compatible library ID 또는 N/A> |
> | **topic** | <검증 키워드 — 본 세션이 의존하는 spec sub-area> |
> | **findings** | see citations below (또는 N/A) |
> | **drift** | <yes | no | N/A> — <1줄 설명> |
> | **re-verify** | <조건 또는 N/A> |
>
> **Citations** (drift=N/A 시 생략 가능):
> - C1 — <한 줄 요약> (Source: `<url>`)
> ```

**Source 5 — `bootstrap/docs/SPEC_VERIFICATION.md §2-5 REPORT skeleton + 위치 (verbatim)**:

> **위치 (필수)**:
>
> ```
> ## 판정
> (체크박스)
>
> ## Spec verification (context7)   ← 여기
>
> ## Lessons Learned
> ```

**Parsed sub-items (5)**:

1. **smoke-spec-verification.sh `--fix` mode 신설** — argv 파싱 + dry-run 분기 + 위치 결정 + skeleton 삽입
2. **PLAN skeleton 정확 위치** — `## Out of scope (explicit rejection)` § 직후 (SPEC_VERIFICATION.md §2 정합)
3. **REPORT skeleton 정확 위치** — `## 판정` § 직후 / `## Lessons Learned` § 직전 (SPEC_VERIFICATION.md §2-5 정합)
4. **SPEC_VERIFICATION.md `--fix` 사용법 § 신설** — 단일 소스 cross-ref
5. **SKILL `harness-plan-verify` 본문 안내 갱신** — § 부재 발견 시 `--fix` 호출 → SKILL이 placeholder 채움 흐름

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| PLAN/REPORT § **수정** (이미 존재 시 갱신) | v1.29 scope 외 — 본 `--fix`는 **부재 시 삽입만**. 갱신은 SKILL `harness-plan-verify` 책임 |
| `## Out of scope` § 자체 누락된 PLAN에 skeleton 삽입 | 본 세션 scope 외 — Scope contract 두 섹션 의무는 v1.10j scope. `--fix`는 § 단일 책임 |
| `## 판정` § 자체 누락된 REPORT에 skeleton 삽입 | 동상 — `--fix`는 위치 anchor 부재 시 명시 FAIL + 사용자 안내 |
| Smoke `--fix` 외 다른 smoke (`smoke-scope-contract` / `smoke-bash-permission-pattern` 등) `--fix` 추가 | 별 후속 evidence-driven (현재 v1.24 § 만 의무화 누적 부담) |
| Pre-commit hook으로 `--fix` 자동 강제 | `v1.30-precommit-hook` 후속 |
| PostToolUse hook deterministic trigger | `v1.31-postoolse-hook` 후속 |
| smoke argv `--check` mode (drift만 보고) | 본 smoke는 default가 `--check` 동등 (현행 동작 유지). `--fix`만 추가 |
| Skeleton TODO placeholder 자동 채움 (library/topic/drift 값 추론) | SKILL `harness-plan-verify` 책임. `--fix`는 skeleton 골격만 |
| `--fix` 후 자동 git add/commit | 사용자 책임 (커밋 전 사용자 확인 정책 정합) |
| 인자 path 절대경로 검증 (out-of-tree skeleton 삽입) | 본 세션 scope 외 — `--fix [<path>]` 인자는 repo 내 PLAN/REPORT만 가정 (Stage 외 `set -euo` 자연 차단) |
| Anthropic SDK 매트릭스 등재 | `v1.28b` 후속 (v1.28 Out of scope 정합) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | shift / case-esac / errexit-conditional / argv positional parameters |
| **findings** | see citations below |
| **drift** | no — PLAN R1/R2의 bash 구문 (`while [ $# -gt 0 ]` + `case "$1" in ... esac` + `shift` 무인자 default 1 + `if grep -q ...; then ... fi` 조건절 errexit-safe) 모두 GNU Bash 공식 manual 현 spec과 정합 |
| **re-verify** | smoke argv 분기 알고리즘 변경 시 또는 bash major version migration 시 (현 4.x 기준 검증 완료) |

**Citations**:

- C1 — `shift [n]` builtin: 인자 무 시 default 1, exit 0 unless n invalid. PLAN R1 argv loop의 `shift` 정합 (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html`)
- C2 — `case word in pattern) command-list ;;` 구문 + `*)` default case + `;;`/`;&`/`;;&` terminators. PLAN R1 `case "$1" in --fix) ... ;; --*) ... exit 2 ;; *) ... ;; esac` 정합 (Source: `https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html`)
- C3 — errexit (`set -e`) skip 조건 verbatim: "the ERR trap... is not executed... **within an if or elif test**, in a && or || list (except for the command following the final operator), or if the command's return status is inverted with !. These conditions align with the errexit shell option." → PLAN R2의 `if grep -q '^## Spec verification...' "$plan"; then no-op` 패턴이 grep no-match (exit 1) 시 errexit 우회 안전 (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html` — trap ERR §)

## 1. 문제 (§ 의무화 후 수동 작성 부담)

### 현재 상태

v1.24/v1.26/v1.27 § 의무화 누적 결과:

| § | 도입 | 적용 범위 | 현 시점 검사 대상 (smoke-spec-verification 6 stage) |
|---|------|---------|-------------------------------------------------|
| PLAN § (메타) | v1.24 | `sessions/meta/v1.24+/**/PLAN.md` | 6 (v1.24~v1.29) |
| PLAN § (프로젝트) | v1.26 | `sessions/<project>/v*/PLAN.md` (레거시 3건 제외) | 0 (현재 신규 0) |
| REPORT § (메타) | v1.27 | `sessions/meta/v1.27+/**/REPORT.md` | 2 (v1.27, v1.28) |
| REPORT § (프로젝트) | v1.27 | `sessions/<project>/v*/REPORT.md` (현재 전체 레거시) | 0 |

**수동 작성 비용**: 매 PLAN/REPORT마다:

1. SPEC_VERIFICATION.md §2 / §2-5 skeleton 사용자/Claude가 복사
2. 정확한 위치 (`Out of scope` 직후 / `판정` 직후) 결정
3. sub-field 5종 + Citations 골격 작성
4. SKILL 호출 후 placeholder 채움

→ **단계 1~3은 100% 기계적 변환**. SKILL 호출 (단계 4)만 Claude judgment 필요.

### Drift 진입 비용

skeleton 누락 / 위치 오류 / sub-field 5종 중 일부 누락 → smoke FAIL → 사용자 또는 Claude가 SPEC_VERIFICATION.md spec 재읽기 + 위치 재판단 → 시간/맥락 비용.

특히 **§ 헤더 위치는 SPEC_VERIFICATION.md §2 / §2-5 spec verbatim** — 사용자 기억보다 spec 직접 참조가 정확.

### Root cause

**Skeleton 단일 소스 = SPEC_VERIFICATION.md §2 / §2-5** 그러나 **자동 삽입 도구 부재**. v1.24/v1.26/v1.27이 § 의무화는 했으나 작성 자동화는 미루었음.

## 2. 결정 (R1 ~ R4)

### R1 — `tests/smoke-spec-verification.sh` `--fix` mode 신설

**Argv 파싱** (smoke 본문 시작부 추가):

```bash
FIX_MODE=0
DRY_RUN=0
TARGET_PATHS=()

while [ $# -gt 0 ]; do
    case "$1" in
        --fix)     FIX_MODE=1 ;;
        --dry-run) DRY_RUN=1 ;;
        --help|-h) echo "Usage: $0 [--fix] [--dry-run] [<path>...]"; exit 0 ;;
        --*)       echo "Unknown option: $1" >&2; exit 2 ;;
        *)         TARGET_PATHS+=("$1") ;;
    esac
    shift
done
```

**`--fix` 동작 분기** (Stage 1~6 검사 후, FAIL=0이면 정상 exit / FAIL>0이면 fix 시도):

```bash
if [ "$FIX_MODE" -eq 1 ]; then
    # 위치 anchor 부재 시 skip + 명시 안내 (Out of scope §)
    fix_plan_or_report
fi
```

**Default (`--fix` 미지정)**: 현행 동작 100% 유지 (회귀 0).

### R2 — Skeleton + 위치 결정 알고리즘

**PLAN.md 위치 anchor**:

```
## Out of scope (explicit rejection)
(표 또는 본문)
                                      ← skeleton 삽입 위치 (다음 ## 직전)
## 1. 문제 ...
```

**REPORT.md 위치 anchor**:

```
## 판정
(체크박스)
                                      ← skeleton 삽입 위치
## Lessons Learned
```

**알고리즘** (PLAN.md):

1. § 헤더 (`^## Spec verification \(context7\)$`) 존재 검사 — 있으면 no-op
2. `^## Out of scope` 매치 라인 # 추출 (anchor)
3. anchor 이후 첫 `^##` 매치 라인 # 추출 (다음 § 시작)
4. 둘 사이에 skeleton 삽입 (`sed -i '<line>i\<text>'` 또는 awk re-emit)
5. anchor 부재 시 → FAIL "Out of scope § 부재로 fix 불가, 사용자 수동 작성 필요"

**알고리즘** (REPORT.md):

1. § 헤더 존재 검사 — 있으면 no-op
2. `^## 판정` 매치 라인 # 추출 (anchor)
3. anchor 이후 첫 `^##` 매치 라인 # 추출 — `^## Lessons Learned` 또는 다른 § (이름 변동 가능)
4. 둘 사이에 skeleton 삽입
5. anchor 부재 시 → FAIL "## 판정 § 부재로 fix 불가"

**Skeleton 본문** (TODO placeholder, smoke가 다음 호출 시 drift FAIL → 사용자 채움 유도):

```
## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | TODO — Context7 ID (예: /websites/code_claude) 또는 N/A |
| **topic** | TODO — 본 세션이 의존하는 spec sub-area (3~5 keyword) |
| **findings** | TODO — see citations below 또는 N/A |
| **drift** | TODO — yes / no / N/A 중 하나 + ' — ' 뒤 1줄 설명 |
| **re-verify** | TODO — 재검증 trigger 조건 또는 N/A |

**Citations** (drift=N/A 시 생략 가능):
- C1 — TODO (Source: `<url>`)

```

**Skeleton 끝에 빈 라인 1개** (다음 § 헤더와 시각 분리).

### R3 — `bootstrap/docs/SPEC_VERIFICATION.md` 사용법 § 신설

§9 (v1.24/v1.27 적용) 직전에 신규 § 추가:

```markdown
## 9. `--fix` mode (v1.29+)

### 9-1. 사용법

bash tests/smoke-spec-verification.sh --fix              # 모든 누락 PLAN/REPORT에 skeleton 삽입
bash tests/smoke-spec-verification.sh --fix --dry-run    # 변경 없이 plan만 출력
bash tests/smoke-spec-verification.sh --fix <path>       # 특정 파일만

### 9-2. 삽입 위치 (단일 소스 §2 / §2-5)

- PLAN.md: `## Out of scope (explicit rejection)` § 직후
- REPORT.md: `## 판정` § 직후 / `## Lessons Learned` § 직전

### 9-3. Skeleton

§2 (PLAN) / §2-5 (REPORT) spec 정합 + TODO placeholder. SKILL `harness-plan-verify`가 후속 채움.

### 9-4. 한계

- TODO 잔존 시 smoke FAIL (drift 값 검증에서 — 사용자가 직접 채우도록 유도)
- 위치 anchor (`Out of scope` 또는 `판정`) 부재 시 FAIL — 사용자 수동 작성 필요
- 정확한 sub-field 값 (drift 판정 등)은 SKILL `harness-plan-verify` 책임. `--fix`는 골격만
```

(기존 §9~§10 = `v1.24 적용 + 후속 분기` / `관련 문서`는 §10/§11로 renumber.)

### R4 — `bootstrap/skills/harness-plan-verify/SKILL.md` Step 1 안내 갱신

기존 Step 1 직후에 1줄 안내 추가:

```markdown
**§ 부재 시 빠른 시작**: `bash tests/smoke-spec-verification.sh --fix <PLAN.md>` 실행 →
TODO skeleton 삽입 → 본 SKILL이 Step 2~3 수행해 placeholder 채움.
```

**근거**: SKILL이 PLAN을 Read할 때 § 부재 시 Edit으로 skeleton 작성 vs `--fix` 호출. `--fix`가 단일 소스 정합 보장 (위치 + 형식 spec verbatim).

## 3. 변경 대상 (4 수정 + 2 신규)

### 수정 (4)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-spec-verification.sh` | S3 | R1 — argv 파싱 + R2 — `--fix` 분기 (PLAN + REPORT 위치 결정 + skeleton 삽입 + dry-run) |
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R3 — §9 `--fix` 사용법 신규 + 기존 §9~§10 → §10~§11 renumber |
| `bootstrap/skills/harness-plan-verify/SKILL.md` | S2 | R4 — Step 1 직후 1줄 안내 + 관련 문서 § cross-ref 갱신 |
| `tests/smoke-scope-contract.sh` | S3 | v1.29 glob 1줄 추가 (`sessions/meta/v1.29*/PLAN.md` — Scope contract self-test 흡수) |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.29-verify-fix-mode/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.29-verify-fix-mode/REPORT.md` | meta | Stage F |

### 변경 안 하는 파일 (회귀 0 보장)

| 경로 | 이유 |
|------|------|
| `verify.{ps1,sh}` | Stage I 6축 frontmatter 검증 무관 (`--fix` 추가는 smoke 본문 변경 only — SKILL frontmatter 변경 0) |
| `tests/smoke-bash-permission-pattern.sh` / `smoke-thinking-effort.sh` | FILES 배열 변경 0 (SKILL `harness-plan-verify` 이미 v1.24에서 등재) |
| `claude/commands/harness-meta.md` | PLAN 필수 § list 그대로 (단일 소스 SPEC_VERIFICATION.md `--fix` § cross-ref만 SPEC_VERIFICATION.md 내부) |
| `bootstrap/docs/{OWNERSHIP, SKILLS}.md` | cross-ref 변경 0 (`--fix`는 사용 패턴 — § 의무 자체는 v1.24에서 정의) |
| `CLAUDE.md` / `README.md` | 관련 문서 § 변경 0 (SPEC_VERIFICATION.md 이미 등재) |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 4 § 의무 (세션 소속 근거 / Scope inheritance / Out of scope / Spec verification TODO)
- [ ] **사용자 PLAN 확인**
- [ ] Stage A — `harness-plan-verify` SKILL 호출 → Spec verification § 5 sub-fields 채움 (drift 판정)
- [ ] Stage B — `tests/smoke-spec-verification.sh` (R1 + R2 — argv + --fix 분기)
- [ ] Stage C — `bootstrap/docs/SPEC_VERIFICATION.md` (R3 — §9 신규 + renumber)
- [ ] Stage D — `bootstrap/skills/harness-plan-verify/SKILL.md` (R4 — Step 1 안내)
- [ ] Stage E — `tests/smoke-scope-contract.sh` (v1.29 glob)
- [ ] Stage F — Smoke 검증 (--fix self-test + 회귀 9건 + verify.ps1 38/38)
- [ ] Stage G — REPORT.md (v1.27+ § 의무 포함)
- [ ] **사용자 커밋 확인**

## 5. 성공 기준

### 기능

- [ ] `bash tests/smoke-spec-verification.sh` (default) — 회귀 0 (PASS=31 SKIP=4 유지)
- [ ] `bash tests/smoke-spec-verification.sh --help` — usage 출력 + exit 0
- [ ] `bash tests/smoke-spec-verification.sh --fix --dry-run /tmp/test-plan.md` — 변경 없이 plan만 출력
- [ ] `bash tests/smoke-spec-verification.sh --fix /tmp/test-plan.md` (§ 부재) — skeleton 삽입 + 정확 위치 (Out of scope 직후)
- [ ] § 이미 존재 PLAN — `--fix` no-op + 명시 보고
- [ ] Out of scope § 부재 PLAN — `--fix` FAIL + "anchor 부재" 안내

### Self-test (본 세션)

- [ ] 본 PLAN.md (이미 § 존재) — `--fix` no-op
- [ ] 본 REPORT.md 작성 시 — § 직접 작성 (--fix 사용 안 함, REPORT는 Stage G에서)

### 회귀

- [ ] smoke-spec-verification.sh PASS=33+ FAIL=0 (v1.29 PLAN 4 check + REPORT 4 check 흡수)
- [ ] smoke-scope-contract.sh PASS=56+ FAIL=0 (v1.29 +2 self-test)
- [ ] 회귀 smoke 7건 (bash-permission/thinking-effort/language-overlay/legacy-cleanup-overlay/skills-install/sync-agents/verify-sh-parity) PASS
- [ ] verify.ps1 38/38 PASS

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.29-verify-fix-mode — smoke-spec-verification --fix mode

- update: tests/smoke-spec-verification.sh (R1+R2 — argv 파싱 + --fix 분기 + dry-run + PLAN/REPORT 위치 결정)
- update: bootstrap/docs/SPEC_VERIFICATION.md (R3 — §9 --fix 사용법 신규 + §9~§10 → §10~§11 renumber)
- update: bootstrap/skills/harness-plan-verify/SKILL.md (R4 — Step 1 직후 --fix 안내)
- update: tests/smoke-scope-contract.sh (v1.29 glob)
- add: sessions/meta/v1.29-verify-fix-mode/{PLAN,REPORT}.md

Scope: § 의무화 후 누적된 수동 작성 부담 제거. SPEC_VERIFICATION.md §2 / §2-5 skeleton 정합 자동 삽입.
- TODO placeholder 잔존 시 drift 검증 FAIL → SKILL harness-plan-verify가 채움
- 위치 anchor (Out of scope / 판정) 부재 시 FAIL + 사용자 안내 (skeleton 강제 삽입 안 함)
- Default 동작 (argv 미지정) 회귀 0

Smoke: spec-verification PASS=33+ + scope-contract PASS=56+ + 회귀 7건 + verify.ps1 38/38.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|---|
| `v1.30-precommit-hook` | pre-commit hook으로 smoke-spec-verification + `--fix` 강제. 본 세션 후행 자연 |
| `v1.31-postoolse-hook` | PostToolUse hook + tool_input.file_path 필터 → PLAN/REPORT 작성 직후 deterministic trigger |
| `v1.29b-fix-other-smokes` | smoke-scope-contract / smoke-bash-permission-pattern `--fix` 도입. evidence-driven (현재 § 부담 SPEC_VERIFICATION만 누적) |
| REPORT § cross-file 일관성 검증 | REPORT drift vs PLAN drift 대조. evidence 3+ 사례 누적 후 |
| `v1.28b-anthropic-sdk-source` | claude-api skill 활용 evidence 누적 시 |

## 8. Lessons Forward (예상)

- **L1 — § 의무화는 작성 자동화와 함께 — 의무만 있고 도구 없으면 drift 진입 비용 누적** — v1.24/v1.26/v1.27 누적 후 v1.29에서 도구 합쳐 비로소 완결
- **L2 — `--fix`는 placeholder 골격만, judgement은 SKILL** — 자동화 경계 명확화 (golden rule: 단일 소스 spec → 기계적 변환만 자동, 가치 판단은 SKILL/사용자)
- **L3 — 위치 anchor 패턴 (`Out of scope` / `판정`) = §의 내장 anchor** — SPEC_VERIFICATION.md §2 spec이 명시한 위치를 anchor로 활용. § 자체가 자기 위치 명시 → mechanism 강건

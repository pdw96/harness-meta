# meta v1.29-verify-fix-mode — REPORT

세션 종료: 2026-04-29
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

| 항목 | 결과 |
|------|------|
| smoke-spec-verification.sh | **PASS=39 FAIL=0 SKIP=4** (v1.29 PLAN 4 check 자동 흡수, REPORT 4 check는 본 REPORT 작성 후 PASS=43으로 증가 예상) |
| smoke-scope-contract.sh | **PASS=56 FAIL=0** (v1.29 +2 self-test 흡수) |
| 회귀 smoke 7건 | **7/7 PASS** (bash-permission, thinking-effort, language-overlay, legacy-cleanup-overlay, skills-install, sync-agents, verify-sh-parity) |
| verify.ps1 | **38/38 PASS** (WARN: 0) |
| `--fix` self-test (8 시나리오) | **8/8 PASS** (idempotent / dry-run / apply / REPORT anchor / anchor 부재 FAIL / invalid path FAIL / unknown opt FAIL / kind 무효 FAIL) |
| 변경 파일 | 4 수정 (smoke-spec-verification + smoke-scope-contract + SPEC_VERIFICATION + SKILL) + 2 신규 (PLAN/REPORT) |

## 구현 요약

### Stage A — PLAN.md 작성 + harness-plan-verify SKILL 호출 (사용자 확인)

PLAN.md 4 § 의무 준수 (세션 소속 근거 / Scope inheritance 5 sub-items / Out of scope 11 row / Spec verification §). **본 PLAN의 § 채움은 SKILL 호출 결과**:

- Library: `/websites/gnu_software_bash_manual_html_node`
- Topic: shift / case-esac / errexit-conditional / argv positional parameters
- Drift: **no** (PLAN R1/R2 bash 구문 모두 GNU Bash 공식 manual 현 spec 정합)
- Citations C1~C3: shift builtin / case 구문 / errexit ERR trap skip 조건 verbatim

이로써 v1.28 §4-2 매트릭스 §4-2 "재발 시나리오 첫 행" — `bash sed/awk + glob` (`/websites/gnu_software_bash_manual_html_node`) **첫 활용 사례** 완료.

### Stage B — `tests/smoke-spec-verification.sh` `--fix` mode 신설 (R1 + R2)

| 변경 | 내용 |
|------|------|
| 헤더 주석 | v1.29 확장 + `--fix` Usage 4줄 |
| Argv 파싱 (top) | `while [ $# -gt 0 ] + case` — `--fix` / `--dry-run` / `--help` / `<path>...` / unknown rejection. POSIX 정합 (C2 verbatim) |
| `SPEC_SKELETON` heredoc | 단일 소스 (PLAN/REPORT 본문 동일) — TODO placeholder 5 sub-field + Citations C1 |
| `get_kind()` | `*/PLAN.md` / `*/REPORT.md` / 무효 분기 |
| `get_anchor()` | PLAN: `^## Out of scope` / REPORT: `^## 판정` |
| `fix_file()` | idempotent (§ 존재 시 no-op) + anchor line grep -n + 다음 `^##` awk + dry-run 분기 + head/tail/mv 안전 in-place edit |
| `do_fix()` | TARGET_PATHS 우선 / 없으면 default enumerate (Stage 1+6 정합 — 메타 + 프로젝트 레거시 제외) |
| Dispatch | `if FIX_MODE` early-exit (회귀 0 보장 — default 모드 Stage 1~6 영향 0) |

**Self-test 8 시나리오 8/8 PASS**:

| 시나리오 | 결과 | exit |
|---------|------|------|
| § 이미 존재 PLAN — `--fix` | "§ 이미 존재 (no-op)" | 0 |
| § 부재 PLAN — `--fix --dry-run` | "Would insert at line 17 (anchor: PLAN at line 11)" | 0 |
| § 부재 PLAN — `--fix` apply | "skeleton 삽입 (line 17)" + 파일 변경 확인 | 0 |
| 두번째 `--fix` (idempotent) | "§ 이미 존재 (no-op)" | 0 |
| § 부재 REPORT — `--fix` | "skeleton 삽입 (line 11, anchor: REPORT)" | 0 |
| anchor 부재 PLAN — `--fix` | "anchor '^## Out of scope' 부재. fix 불가" | 1 |
| invalid path `foo.txt` | "PLAN.md 또는 REPORT.md만 지원" 또는 "파일 부재" | 1 |
| `--bogus` unknown option | "Unknown option: --bogus (try --help)" | 2 |

### Stage C — `bootstrap/docs/SPEC_VERIFICATION.md` §9 신규 + §9~§10 → §10~§11 renumber (R3)

신규 §9 `--fix` mode (v1.29+) — 5 sub-§:

- §9-1 사용법 (5 명령 예시)
- §9-2 삽입 위치 매트릭스 (PLAN/REPORT × anchor + 다음 ## fallback)
- §9-3 Skeleton 본문 verbatim (TODO placeholder)
- §9-4 한계 5건 (TODO 잔존 / anchor 부재 / 이미 존재 / 자동 추론 무 / hardcode drift 위험)
- §9-5 동작 매트릭스 7 시나리오 × exit code

기존 §9 → §10 renumber. §10-2 후속 분기 표 갱신:

- v1.28 / v1.29 완료 표기
- v1.30 / v1.31 / v1.29b 미래 분기 명시

### Stage D — `bootstrap/skills/harness-plan-verify/SKILL.md` 갱신 (R4)

| 변경 | 내용 |
|------|------|
| Step 1 sub-step 2 신규 | "§ 부재 시 빠른 시작 (v1.29+)" — `bash tests/smoke-spec-verification.sh --fix <PLAN>` 명령 + SKILL이 placeholder 채움 흐름 명시. 기존 sub-step 2~3 → 3~4 renumber |
| 관련 문서 § cross-ref 갱신 | SPEC_VERIFICATION.md "10 §" → "11 § + `--fix` mode v1.29" / smoke "정적 5 stage" → "정적 6 stage + v1.29 `--fix` mode" / v1.29 도입 세션 cross-ref 1줄 추가 |

frontmatter 6축 변경 0 → V1/V5/V7/V8/V10 회귀 0 (smoke-bash-permission-pattern + smoke-thinking-effort + verify.ps1 Stage I 검증 통과).

### Stage E — `tests/smoke-scope-contract.sh` v1.29 glob 추가

```bash
sessions/meta/v1.29*/PLAN.md
```

→ 본 PLAN.md self-test 흡수 (PASS=54 → 56, +2: Scope inheritance 존재 + Out of scope 존재).

### Stage F — 회귀 검증 (9 smoke + verify.ps1)

| smoke | 결과 |
|-------|------|
| smoke-spec-verification | PASS=39 FAIL=0 SKIP=4 |
| smoke-scope-contract | PASS=56 FAIL=0 |
| smoke-bash-permission-pattern | 6/6 PASS |
| smoke-thinking-effort | 5/5 PASS |
| smoke-language-overlay | PASS=11 FAIL=0 |
| smoke-legacy-cleanup-overlay | PASS=9 FAIL=0 |
| smoke-skills-install | PASS=9 FAIL=0 |
| smoke-sync-agents | PASS=5 FAIL=0 |
| smoke-verify-sh-parity | 5/5 PASS |
| verify.ps1 | 38/38 PASS (WARN 0) |

### Stage G — 본 REPORT.md 작성

본 § 포함. `## 판정` § 직후 `## Spec verification (context7)` § 의무 (v1.27+) — drift 판정은 PLAN과 동일 (`/websites/gnu_software_bash_manual_html_node`, drift=no).

## 판정

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 4 § 의무 + harness-plan-verify SKILL 호출로 § 채움
- [x] 사용자 PLAN 확인
- [x] Stage B — smoke-spec-verification.sh `--fix` mode (R1 + R2)
- [x] Stage C — SPEC_VERIFICATION.md §9 신규 + §10~§11 renumber (R3)
- [x] Stage D — harness-plan-verify SKILL.md Step 1 안내 + cross-ref (R4)
- [x] Stage E — smoke-scope-contract.sh v1.29 glob
- [x] Stage F — 회귀 검증 (9 smoke + verify.ps1 38/38) PASS
- [x] Stage G — REPORT.md
- [ ] 사용자 커밋 확인 (다음 단계)

### 성공 기준 결과

- [x] `bash tests/smoke-spec-verification.sh` (default) — 회귀 0 (PASS=39 SKIP=4 유지)
- [x] `--help` — usage 출력 + exit 0
- [x] `--fix --dry-run /tmp/test.md` — plan만 출력
- [x] `--fix /tmp/test.md` (§ 부재) — skeleton 삽입 정확 위치
- [x] § 이미 존재 PLAN — `--fix` no-op + 명시 보고
- [x] anchor 부재 PLAN — FAIL + "anchor 부재" 안내
- [x] 본 PLAN.md (이미 § 존재) — `--fix` no-op self-test
- [x] smoke-scope-contract.sh PASS=56+ (v1.29 +2)
- [x] 회귀 smoke 7건 PASS
- [x] verify.ps1 38/38 PASS

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | shift / case-esac / errexit-conditional / argv positional parameters |
| **findings** | no new findings |
| **drift** | no — 구현 완료 후 PLAN R1/R2의 bash 구문 (argv `while/case/shift` + `if grep -q` errexit-safe + `awk` re-emit + `head/tail/mv` in-place edit) 모두 GNU Bash 공식 manual 현 spec 정합 유지. 8 self-test 시나리오 PASS로 실 동작 검증 완료 |
| **re-verify** | smoke argv 분기 알고리즘 변경 시 또는 bash major version migration 시 (현 4.x 기준 검증 완료) |

**Citations** (drift=no, 신규 발견 없음 — PLAN § 인용 C1~C3 그대로 유지):

- C1 — `shift [n]` builtin: 인자 무 시 default 1, exit 0 (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html`)
- C2 — `case word in pattern) command-list ;;` 구문 (Source: `https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html`)
- C3 — errexit ERR trap skip 조건: "within an if or elif test" → `if grep -q` 안전 (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html`)

## Lessons Learned

### L1 — Skeleton 단일 소스는 hardcode + sentinel verification (drift 위험 인정)

`SPEC_VERIFICATION.md §2/§2-5` ↔ `smoke-spec-verification.sh SPEC_SKELETON` 양쪽 hardcode. § 본문 변경 시 양쪽 동시 갱신 의무 (§9-4 한계 명시). **이유**: markdown sub-section을 bash에서 안정 파싱하는 것보다 hardcode + 변경 시 양쪽 동시 갱신이 비용 낮음. 향후 sentinel 검증 (smoke가 §2 일부 string과 SPEC_SKELETON 비교) 추가는 evidence-driven 후속 (`v1.29c-sentinel-check`).

### L2 — `--fix`는 placeholder 골격만, 가치 판단은 SKILL — 자동화 경계 명확화

원칙 정형화:

- **단일 소스 spec → 기계적 변환만 자동** (위치 + 형식 → smoke `--fix`)
- **가치 판단 (drift 분석 / library 선택 / topic 추출)은 SKILL/사용자**

TODO placeholder 잔존 시 default smoke FAIL (Stage 3 drift 검증) → 사용자 알림 자연. "skeleton만 있고 의미 없으면 통과 못함" 강제력으로 SKILL 호출 유도 mechanism.

### L3 — § 의무화는 작성 자동화와 함께해야 누적 부담 0

v1.24 PLAN § 의무 → v1.26 프로젝트 PLAN 확장 → v1.27 REPORT 확장 → v1.28 매트릭스 4 row → **v1.29 작성 자동화**. 4 세션에 걸친 누적 부담을 v1.29에서 한 번에 해소.

향후 신규 § 의무 도입 시 패턴: **(a) § spec 정의 → (b) smoke 검증 → (c) `--fix` mode (작성 자동화) → (d) hook (강제)** 4단계 묶어 1~2 세션으로 압축 검토.

### L4 — 위치 anchor = §의 내장 mechanism 활용 (외부 marker 불필요)

PLAN의 `## Out of scope` / REPORT의 `## 판정` 모두 SPEC_VERIFICATION.md §2 / §2-5 spec이 명시한 위치. 별도 marker (예: `<!-- SPEC_VERIFICATION_HERE -->`) 불필요 — § 자체가 자기 위치 명시. mechanism 강건성 + spec drift 위험 ↓.

### L5 — bash heredoc `<<'EOF'` raw mode + `read -r -d ''` 변수 캡처

skeleton에 single-quote (`' — '` 텍스트) + backtick (Citations URL placeholder) 동시 포함 → heredoc with `'EOF'` (single-quoted) → 변수 expansion / backslash interp 모두 비활성. 이게 정확한 bash idiom (C2/C3 verbatim 정합). `read -r -d ''` + `|| true` (read EOF에서 1 반환하지만 errexit 우회 필요) 표준 패턴.

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.30-precommit-hook` | pre-commit hook으로 smoke-spec-verification + `--fix` 강제. 본 세션 자연 후행 |
| `v1.31-postoolse-hook` | PostToolUse hook + tool_input.file_path 필터 → PLAN/REPORT 작성 직후 deterministic trigger |
| `v1.29b-fix-other-smokes` | smoke-scope-contract / smoke-bash-permission-pattern `--fix` 도입. evidence-driven (현재 § 부담 SPEC_VERIFICATION만 누적) |
| `v1.29c-sentinel-check` | SPEC_SKELETON ↔ SPEC_VERIFICATION.md §2 sentinel 매칭 stage. evidence-driven (drift 발생 시) |
| REPORT § cross-file 일관성 | REPORT drift vs PLAN drift 대조 stage. evidence 3+ 사례 누적 후 (현 v1.27/v1.28/v1.29 3건) |
| `v1.28b-anthropic-sdk-source` | claude-api skill 활용 evidence 누적 시 |

## 선행 세션 (cross-link)

- [`sessions/meta/v1.28-source-matrix-expand/`](../v1.28-source-matrix-expand/REPORT.md) — 매트릭스 §4-2 "재발 시나리오 첫 행 (`v1.29-verify-fix-mode`)" 명시 → 본 세션이 첫 활용 사례 (drift=no Citations C1~C3 GNU Bash)
- [`sessions/meta/v1.27-report-spec-verification/`](../v1.27-report-spec-verification/REPORT.md) — REPORT § 의무 도입 → 본 세션 `--fix` 대상 = PLAN + REPORT 양쪽
- [`sessions/meta/v1.26-project-plan-verify/`](../v1.26-project-plan-verify/REPORT.md) — 프로젝트 PLAN § 의무 → `--fix`는 프로젝트 세션도 처리
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/REPORT.md) — § 의무 + skeleton 형식 단일 소스 → 본 세션 `--fix` skeleton 출처

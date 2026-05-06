# Spec verification — PLAN/REPORT context7 검증 § 규격

`sessions/meta/v1.24-plan-spec-verification/`에서 확정 (PLAN §), `sessions/meta/v1.27-report-spec-verification/`에서 확장 (REPORT §). 본 문서는 메타 세션 PLAN/REPORT 작성 후 외부 spec(Anthropic Claude Code docs 등) drift를 context7으로 검증하는 절차의 단일 소스.

## 1. 개요

### 1-1. 동기

`sessions/meta/v1.10d-bash-permission-pattern-audit/` (5축 frontmatter spec) + `sessions/meta/v1.10g-skill-thinking-effort/` (model+effort A6) + `sessions/meta/v1.23-verify-unification/` (PostToolUse hook spec 재검증) 모두 **수동 패턴**:

- PLAN 작성 → Claude/사용자가 context7 query 임시 실행 → 결과를 PLAN 본문 또는 audit/ 디렉토리에 인용
- "검증을 했는가?"가 PLAN에서 grep 불가 → 매 PLAN마다 즉흥 판단

`v1.23 REPORT` Lessons Learned L1 verbatim:

> "context7 query (C1~C10)로 v1.23 시점 정합 재검증 — 모든 spec이 그대로 유효함을 확인 + 신규 발견 (...). **향후 SKILL/agent spec 변경 시 동일 패턴 (context7 → spec 갱신 세션) 표준화.**"

### 1-2. 본 문서가 정의하는 것

1. PLAN.md `## Spec verification (context7)` § 규격 (§2-1 ~ §2-4)
2. REPORT.md `## Spec verification (context7)` § 규격 (§2-5 ~ §2-6) — v1.27 신규
3. 위반 정책 (§3)
4. Context7 source matrix — library ID + 적용 영역 (§4)
5. SKILL `harness-plan-verify` 사용법 (§5)
6. N/A 정책 (§6)
7. 레거시 정책 (§7)
8. 회귀 정책 + self-test (§8)
9. v1.24/v1.27 적용 + 후속 분기 (§9)
10. 관련 문서 (§10)

### 1-3. 적용 범위

- **In scope**:
  - `sessions/meta/v1.24+/**/PLAN.md`
  - `sessions/<project>/v*/PLAN.md` (v1.26 도입 이후 신규 — 레거시 skip 목록 §7-3 참조)
  - `sessions/meta/v1.27+/**/REPORT.md` (v1.27 도입 이후 신규 — 레거시 skip 목록 §7-4 참조)
  - `sessions/<project>/v*/REPORT.md` (v1.27 도입 이후 신규 — §7-4 참조)
  - `milestones/M*/PLAN.md` + `milestones/M*/REPORT.md` (v1.83+ — milestone-phase 2-tier 도입, ADR-006)
- **Out of scope** (별 후속 evidence-driven): 레거시 v1.24 미만 meta PLAN + §7-3 레거시 프로젝트 PLAN + §7-4 레거시 REPORT (forward-only)

## 2. § 규격

모든 `sessions/meta/v1.24+/**/PLAN.md` (+ v1.83+ `milestones/M*/PLAN.md` + `milestones/M*/REPORT.md`)의 "Out of scope (explicit rejection)" § 직후에 다음 형식으로 의무 배치. milestone PLAN/REPORT도 phase PLAN/REPORT와 동일 의무 (ADR-006).

```markdown
## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | <Context7-compatible library ID 또는 N/A> |
| **topic** | <검증 키워드 — 본 세션이 의존하는 spec sub-area> |
| **findings** | see citations below (또는 N/A) |
| **drift** | <yes | no | N/A> — <1줄 설명> |
| **re-verify** | <조건 또는 N/A> |

**Citations** (drift=N/A 시 생략 가능):
- C1 — <한 줄 요약> (Source: `<url>`)
- C2 — <한 줄 요약> (Source: `<url>`)
- ...
```

### 2-1. § 헤더 정확 매치

- 헤더 텍스트: `## Spec verification (context7)` — 정확히 일치
- 정규식: `^## Spec verification \(context7\)$`
- 위치: "Out of scope (explicit rejection)" § **직후**

### 2-2. Sub-field 5종 (정확 5개, 순서 고정)

| sub-field key | 값 형식 |
|---------------|--------|
| `library` | Context7 ID (예: `/websites/code_claude`) 또는 `N/A` |
| `topic` | 본 세션 의존 spec sub-area 키워드 (3~5개) 또는 `N/A` |
| `findings` | 정확히 `see citations below` 또는 `N/A` (multi-line citations는 § 본문 list로 분리) |
| `drift` | 정확히 `yes` / `no` / `N/A` 중 하나 + ` — ` 뒤에 1줄 설명 |
| `re-verify` | 재검증 trigger 조건 (텍스트) 또는 `N/A` |

⚠️ sub-field key 영문화 — 한국어 `재검증 시점`은 `re-verify`로 통일 (Git Bash UTF-8 locale 의존 회피).

### 2-3. drift 값 매트릭스

- **`no`** — context7 query 결과가 PLAN 결정과 정합. citation 본문 list 권장
- **`yes`** — query 결과가 PLAN 결정과 불일치. PLAN 수정 또는 사용자 재확인 필요
- **`N/A`** — 본 세션 외부 spec 의존 무. 다른 4 sub-field도 정확히 `N/A`

### 2-4. Citations 본문 list

- drift=`no` 또는 `yes` 시 의무 (smoke 강제 검증 안 하나 권장)
- drift=`N/A` 시 생략 가능
- 형식: `- C<n> — <한 줄 요약> (Source: \`<url>\`)`
- C1, C2, ... 순서

### 2-5. REPORT.md § 규격 (v1.27+)

모든 `sessions/meta/v1.27+/**/REPORT.md` 및 `sessions/<project>/v*/REPORT.md` (v1.27 도입 이후)의 "판정" § 직후 / "Lessons Learned" § 직전에 의무 배치.

```markdown
## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | <PLAN § 동일 또는 N/A> |
| **topic** | <PLAN § 동일 또는 N/A> |
| **findings** | no new findings (또는 see citations below / N/A) |
| **drift** | <no | yes | N/A> — <1줄 설명> |
| **re-verify** | <조건 또는 N/A> |

**Citations** (drift=yes 시 권장, drift=N/A 시 생략):
- C1 — <구현 중 신규 발견> (Source: `<url>`)
```

**헤더 정확 매치**: PLAN § 동일 — `^## Spec verification \(context7\)$`

**위치 (필수)**:

```
## 판정
(체크박스)

## Spec verification (context7)   ← 여기

## Lessons Learned
```

### 2-6. REPORT `drift` 값 매트릭스 (post-hoc)

PLAN `drift`와 동일한 3 값이나 의미가 post-hoc으로 다름:

| 값 | PLAN 의미 | REPORT 의미 |
|----|-----------|-------------|
| `no` | context7 pre-check 결과 정합 | 구현 중 신규 spec drift 없음 (PLAN 결론 유지) |
| `yes` | context7 결과 불일치 | 구현 중 신규 spec drift 발견. Citations에 기록 |
| `N/A` | 외부 spec 의존 무 | PLAN drift=N/A 동일 (외부 spec 의존 무) |

**`findings` 허용 값 (REPORT 전용)**:

- `N/A` — drift=N/A 분기
- `no new findings` — 구현 중 새 발견 없음
- `see citations below` — 신규 발견 있음

**부분 N/A 금지**: PLAN § 동일. drift=N/A → 다른 4 sub-field 정확히 `N/A`.

## 3. 위반 정책

`tests/smoke-spec-verification.sh`가 자동 검사. v1.10j Scope contract 패턴 재사용.

| 위반 유형 | smoke 처치 |
|---------|---------|
| § 자체 누락 | FAIL — PLAN 거부 + 사용자 재작성 |
| sub-field 5개 중 누락 | FAIL — PLAN 거부 |
| drift 값이 `yes` / `no` / `N/A` 외 | FAIL |
| drift=N/A인데 다른 sub-field 비-N/A | FAIL — 부분 N/A 금지 |
| Citations 본문 list 부재 (drift=no/yes) | smoke WARN 안 함 — Claude/사용자 책임 |
| drift=yes 명시 후에도 PLAN이 spec drift 미반영 | smoke 검증 불가 — 사용자 재검토 의무 |
| REPORT.md § 자체 누락 (v1.27+) | FAIL — REPORT 거부 + 사용자 재작성 |
| REPORT.md sub-field 5개 중 누락 (v1.27+) | FAIL — REPORT 거부 |
| **(v1.32+ pair)** PLAN drift=N/A → REPORT drift=no/yes | FAIL — PLAN scope 위반 (PLAN N/A 선언 후 REPORT spec 의존 발견) 또는 REPORT N/A 정정 |
| **(v1.32+ pair)** PLAN drift=no/yes → REPORT drift=N/A | WARN — scope 축소 검토 권장 (smoke PASS 유지, ⚠️ marker) |

## 4. Context7 source matrix

v1.24 도입 (2 source) → **v1.28 확장 (4 source)** — `sessions/meta/v1.28-source-matrix-expand/`. 향후 evidence-driven 추가 확장 (v1.28b/c/d).

| Library ID | 용도 | 적용 영역 | benchmark |
|------------|------|---------|-----------|
| `/websites/code_claude` | Claude Code 공식 docs (1차) | SKILL/hook/permission/frontmatter/agent/slash command/MCP | 83.6 |
| `/anthropics/claude-code` | plugin-dev (2차, conflict 검증) | frontmatter-reference / agent-development / mcp-integration | — |
| `/microsoftdocs/powershell-docs` | PowerShell 7+ shell spec (cross-platform install/verify, v1.28+) | `$null` property access / `?.` `?[]` operators / `Select-String` no-match / `New-Item` SymbolicLink | — |
| `/websites/gnu_software_bash_manual_html_node` | GNU Bash manual (cross-platform install/verify, v1.28+) | errexit + `&&`/`\|\|` lists / glob `nullglob`/`failglob` / Bourne-Shell-Builtins | — |

### 4-1. 매트릭스 사용

1. 본 세션이 의존하는 spec sub-area 식별 (Step 1 keyword grep)
2. 매트릭스에서 해당 영역의 library ID 선택 (1차 → 2차):
   - **Claude Code spec** (SKILL/hook/permission/frontmatter/agent/slash command/MCP) → `/websites/code_claude` (1차) + `/anthropics/claude-code` (보조 conflict)
   - **Cross-platform shell spec** (install/verify 스크립트 변경) → `/microsoftdocs/powershell-docs` (PS) + `/websites/gnu_software_bash_manual_html_node` (Bash)
3. context7 query 1~2회 (max 3회 — context7 budget)

### 4-2. 매트릭스 확장 정책

신규 외부 spec(Anthropic SDK / agents.md / 외부 라이브러리) 의존 세션 발생 시:

1. `sessions/meta/v1.X-source-matrix-expand/` 별 세션 진행 (v1.28까지 누적)
2. 해당 라이브러리 ID context7 resolve → benchmark 확인 (Anthropic 외부 source는 `—` 표기 허용 — Microsoft / GNU 같은 외부 권위 source는 Anthropic 공식 benchmark 메타 부재. 인용 정합 자체가 benchmark 대용)
3. 본 §4 표에 행 추가

**재발 임계 = 1회** (v1.28에서 명문화). 매트릭스 부재 라이브러리가 1개 세션에서 인용된 시점부터 등재 후보. 단, 다음 **등재 3 조건** 모두 충족 시:

- **권위 source** — 공식 docs / 표준 단체 / 주요 벤더 (커뮤니티 가이드는 보조 인용만 허용 — 매트릭스 부적합. v1.19 L6 `/zebbern/claude-code-guide` "권위 약함" 정합)
- **context7 resolve 가능** — library ID 형식 `/<owner>/<repo>` 또는 `/websites/<host>`
- **재발 가능성** — cross-platform 도구 / 표준 spec / 본 repo 핵심 의존 (단발 비즈니스 로직은 부적합)

**비등재 2 조건** (충족 시 매트릭스 부적합):

- **단발 인용 + 재발 가능성 0** — 특정 비즈니스 코드 / 일회성 마이그레이션
- **권위 약함** — 커뮤니티 가이드 / 개인 블로그

매트릭스 부재 라이브러리는 PLAN의 § findings에 임시 인용 가능하나 **재발 시 본 §4-2 절차 진입 의무**.

### 4-3. v1.28 적용 사례 (etalon)

`sessions/meta/v1.28-source-matrix-expand/`에서 §4-2 첫 invocation. v1.21 audit/A1이 인용한 2 source가 등재 3 조건 모두 충족:

| Source | 권위 | context7 resolve | 재발 가능성 |
|--------|------|----------------|-----------|
| `/microsoftdocs/powershell-docs` | Microsoft 공식 | ✓ (v1.21 인용 1, 2) | ✓ install/verify .ps1 변경 시마다 재발 |
| `/websites/gnu_software_bash_manual_html_node` | GNU 공식 | ✓ (v1.21 인용 3, 4) | ✓ install/verify .sh + smoke .sh 변경 시마다 재발 |

비등재 사례: `/zebbern/claude-code-guide` (v1.19 1건 인용 + L6 "권위 약함" — 비등재 2 조건 중 "권위 약함" 충족 → 매트릭스 부적합).

## 5. SKILL `harness-plan-verify` 사용법

### 5-1. 자동 invoke (description trigger)

사용자 발화에 다음 키워드 매칭 시 Claude 자동 invoke:

- "spec 검증"
- "context7 검증"
- "PLAN 검증"
- "spec drift"

### 5-2. 수동 invoke (fallback)

description 매칭 실패 시:

```
/harness-plan-verify
```

### 5-3. Trigger 신뢰성

- description trigger는 **opportunistic** (deterministic 아님)
- Claude는 file system event 수신 못 함 → "PLAN 작성 직후" 자동 self-trigger 보장 무
- backstop: smoke § 검증 (CI 또는 pre-commit hook v1.C에서 강제 — 별 후속)

### 5-4. SKILL 본문 흐름

자세한 흐름은 `bootstrap/skills/audit/harness-plan-verify/SKILL.md` 참조 — 3-step (Identify → Query → Fill).

## 6. N/A 정책 (외부 spec 의존 무 케이스)

### 6-1. 적용 케이스

- 순수 문서 정리 (오타 / 표현 정정)
- 내부 규약 변경 (외부 spec 무관)
- 비즈니스 로직 (S7 — 본 메타 체계 외이므로 사실상 발생 안 함)

### 6-2. 표기 의무

```markdown
## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 규약/문서 정리만) |
| **re-verify** | N/A |
```

### 6-3. 부분 N/A 금지

drift=N/A 시 `library` / `topic` / `findings` / `re-verify` 4 sub-field도 정확히 `N/A`. 일반 텍스트 혼합 시 smoke FAIL.

근거: N/A 분기는 "외부 spec 무 의존 선언" — 부분 N/A는 의도 불명확. drift=no 케이스로 변환하거나 sub-field 정확 채움.

## 7. 레거시 정책

### 7-1. v1.24+ forward-only

- v1.24 이전 메타 세션(v1.0 ~ v1.23) PLAN.md는 § 의무 무
- 소급 적용 무 (v1.10j Scope contract 패턴 정합)
- smoke glob `sessions/meta/v1.24*/PLAN.md`로 한정

### 7-2. 레거시 audit 보존

v1.10d (5축 audit) + v1.10g (model+effort) + v1.23 (PostToolUse) 시점 context7 audit 결과는 각 세션의 `audit/` 디렉토리에 보존. 본 § 규격으로 후행 변환 안 함.

향후 spec 갱신 시 본 SKILL이 query 후 발견하면 별 세션 (`v1.24c`+ 또는 `v1.A4-readonly-update-2.1.111` 같은 spec-specific 세션)에서 처리.

### 7-3. 프로젝트 세션 레거시 (v1.26 도입)

본 절차의 v1.24b 후속 약속을 `sessions/meta/v1.26-project-plan-verify/`에서 이행. 다음 세션은 § 의무 면제 (forward-only):

- `sessions/upbit/v1.0-project-claude-install/PLAN.md`
- `sessions/upbit/v1.1-skills-migration/PLAN.md`
- `sessions/upbit/v1.2-python-overlay-apply/PLAN.md`

**Skip 정책 동결**: 본 list는 v1.26 도입 시점 동결. 향후 동일 경로 재작성도 SKIP 유지 (재작성 시점에 § 추가 여부는 사용자 판단). smoke 구현은 `tests/smoke-spec-verification.sh`의 `LEGACY_PROJECT_PLANS` 배열.

### 7-4. REPORT 레거시 정책 (v1.27 도입)

- v1.27 이전 모든 REPORT.md — § 의무 무 (meta v1.0~v1.26 + 프로젝트 세션 v1.26 이하)
- 소급 적용 무 (forward-only, v1.10j Scope contract 패턴 정합)
- smoke glob (Stage 6): `sessions/meta/v1.2[7-9]*/REPORT.md` + `sessions/meta/v1.[3-9][0-9]*/REPORT.md` + `sessions/meta/v[2-9].*/REPORT.md` + `sessions/<project>/v*/REPORT.md` (meta 제외)
- `LEGACY_REPORTS` 배열: smoke가 v1.27 이전 REPORT를 is_legacy_report()로 skip

**Skip 정책 동결**: v1.27 도입 시점 동결. 레거시 REPORT 재작성 시 § 추가 여부는 사용자 판단.

## 8. 회귀 정책 + self-test

### 8-1. smoke 검증

`tests/smoke-spec-verification.sh` (정적 7 stage, v1.27/v1.32 확장):

1. § 헤더 존재 (`^## Spec verification \(context7\)$`) — PLAN
2. § 구간 추출 후 sub-field 5종 정확 등장 — PLAN
3. drift 값이 `yes` / `no` / `N/A` 중 정확 1개 — PLAN
4. drift=N/A 시 다른 4 sub-field 정확히 `N/A` (부분 N/A 차단) — PLAN
5. SKILL.md 존재 + frontmatter 정합 (name/model/effort/MCP allowed-tools/thinking 부재)
6. **(v1.27 신규)** REPORT.md § 4 체크 (헤더 / sub-field 5종 / drift 값 / N/A 분기) — §7-4 레거시 skip
7. **(v1.32 신규)** Cross-file 일관성 — PLAN drift ↔ REPORT drift 9 case 매트릭스 (§11). 5 OK + 2 FAIL (scope 확장) + 2 WARN (scope 축소, ⚠️ marker)

### 8-2. self-test

v1.24 본 PLAN.md가 § 5 sub-fields + Citations C1~C6 채워진 첫 인스턴스. smoke 자동 enumerate 시 첫 입력 → self-validate.

### 8-3. 회귀 0 정책

본 § 규격 추가는 v1.24+ 신규 PLAN에만 영향. 기존 smoke 7건(smoke-bash-permission-pattern, smoke-thinking-effort, smoke-language-overlay, smoke-legacy-cleanup-overlay, smoke-skills-install, smoke-sync-agents, smoke-verify-sh-parity) + verify.ps1 38/38 PASS 유지.

신규 SKILL `bootstrap/skills/audit/harness-plan-verify/SKILL.md`는 V1/V5/V7/V8/V10 6축 검증 통과 의무 — `tests/smoke-bash-permission-pattern.sh` FILES + `verify.ps1` `$frontmatterFiles` list에 추가.

## 9. `--fix` mode (v1.29+)

`sessions/meta/v1.29-verify-fix-mode/`에서 도입. v1.24/v1.26/v1.27 § 의무화 누적 후 **수동 작성 부담** 제거 — smoke `--fix`가 §2 / §2-5 spec 정합 skeleton을 정확한 위치에 자동 삽입.

### 9-1. 사용법

```bash
bash tests/smoke-spec-verification.sh                           # 검증만 (default 회귀 0)
bash tests/smoke-spec-verification.sh --fix                     # § 누락 PLAN/REPORT 모두 skeleton 삽입
bash tests/smoke-spec-verification.sh --fix --dry-run           # 변경 없이 plan만 출력
bash tests/smoke-spec-verification.sh --fix <path> [<path>...]  # 특정 파일만 처리
bash tests/smoke-spec-verification.sh --help                    # usage
```

### 9-2. 삽입 위치 (§2 / §2-5 정합)

| 파일 | anchor (regex) | 삽입 위치 |
|------|---------------|---------|
| PLAN.md | `^## Out of scope` | anchor § 직후 (다음 `^##` 라인 직전) |
| REPORT.md | `^## 판정` | anchor § 직후 (다음 `^##` 라인 직전, 일반적으로 `^## Lessons Learned` 직전) |

다음 `^##` 부재 시(EOF) 파일 끝에 append.

### 9-3. Skeleton

§2 (PLAN) / §2-5 (REPORT) verbatim — 본문 동일, 위치만 다름. 5 sub-field + Citations C1을 모두 `TODO` placeholder로 채워 사용자/SKILL 호출 유도:

```markdown
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

### 9-4. 한계

| 한계 | 처치 |
|------|------|
| TODO placeholder 잔존 시 default smoke FAIL (Stage 3 drift 값 검증) | **의도** — 사용자 또는 `harness-plan-verify` SKILL이 채움 (§5 SKILL 흐름 참조) |
| anchor (`Out of scope` / `판정`) 부재 시 fix 불가 → FAIL | 사용자가 Scope contract / REPORT 필수 § 먼저 작성 후 재호출 |
| § 이미 존재 시 fix는 no-op | idempotent — 갱신은 SKILL `harness-plan-verify` 책임 (`--fix`는 부재 시 삽입만) |
| Skeleton sub-field 값 자동 추론 (drift 판정 등) 안 함 | SKILL 책임 — `--fix`는 골격만 |
| Skeleton 본문 drift (smoke ↔ §2/§2-5 spec) | 양쪽 hardcode — § 본문 변경 시 양쪽 동시 갱신 의무. 향후 sentinel 검증 추가 검토 (evidence-driven) |

### 9-5. 동작 매트릭스

| 입력 시나리오 | 결과 | exit |
|--------------|------|------|
| `--fix` (전역, § 부재 PLAN/REPORT 다수) | 모두 skeleton 삽입 | 0 |
| `--fix --dry-run <path>` | "Would insert skeleton at line N" 출력 only | 0 |
| `--fix <path>` (§ 이미 존재) | "§ 이미 존재 (no-op)" | 0 |
| `--fix <path>` (anchor 부재) | "anchor '...' 부재" FAIL | 1 |
| `--fix <bad.txt>` (PLAN/REPORT 외) | "PLAN.md 또는 REPORT.md만 지원" FAIL | 1 |
| `--bogus` | "Unknown option" stderr + 즉시 종료 | 2 |
| (인자 무, default) | Stage 1~6 검증 (회귀 0) | 0/1 |

## 10. v1.24 적용 + 후속 분기

### 10-1. v1.24 본 세션 적용

- PLAN.md `## Spec verification (context7)` § 채워짐 (drift=no, C1~C6)
- SKILL `bootstrap/skills/audit/harness-plan-verify/SKILL.md` 신설
- smoke `tests/smoke-spec-verification.sh` 정적 5 stage
- claude/commands/harness-meta.md PLAN 필수 § list에 추가
- bootstrap/docs/{OWNERSHIP, SKILLS}.md cross-ref

### 10-2. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| ~~`v1.24b-project-plan-verify`~~ → **`v1.26` 완료** + **`v1.36` SKILL description 확장** | 프로젝트 PLAN § 의무 확장 이행 (v1.26) + `harness-plan-verify` SKILL이 메타 + 프로젝트 양쪽 지원 (v1.36) |
| ~~`v1.24d-report-spec-verification`~~ → **`v1.27` 완료** | REPORT.md § 의무 확장 이행 |
| ~~`v1.28-source-matrix-expand`~~ → **`v1.28` 완료** | 본 §4 매트릭스 확장 (PowerShell + Bash 4 row) |
| ~~`v1.29-verify-fix-mode`~~ → **`v1.29` 완료** | smoke `--fix` mode — § skeleton 자동 삽입 (본 §9) |
| `v1.30-precommit-hook` | pre-commit hook으로 smoke-spec-verification + `--fix` 강제 |
| `v1.31-postoolse-hook` | PostToolUse hook + tool_input.file_path 필터로 deterministic trigger |
| `v1.29b-fix-other-smokes` | smoke-scope-contract / smoke-bash-permission-pattern `--fix` 도입. evidence-driven |
| ~~REPORT § cross-file 일관성 검증~~ → **`v1.32` 완료** | REPORT drift vs PLAN drift 대조 (Stage 7 매트릭스 9 case). 본 §11 단일 소스 |

## 11. Cross-file 일관성 매트릭스 (v1.32+)

`sessions/meta/v1.32-report-cross-file-consistency/`에서 확정 (2026-04-29). PLAN drift ↔ REPORT drift 9 case 분류. `tests/smoke-spec-verification.sh` Stage 7 자동 검증.

### 11-1. 매트릭스 (9 case)

| PLAN drift | REPORT drift | 분류 | 의미 |
|:----------:|:------------:|:----:|------|
| N/A | N/A | **OK** | 외부 spec 의존 무 양쪽. 정합 |
| no | no | **OK** | spec 의존 + PLAN 정합 + 구현 중 drift 없음 |
| yes | yes | **OK** | spec 의존 + PLAN 불일치 명시 + 구현 중에도 drift 유지 (외부 spec 변경 대기 등) |
| no | yes | **OK** | PLAN은 정합이었으나 구현 중 신규 spec drift 발견. 정상 case (REPORT § 도입 동기) |
| yes | no | **OK** | PLAN drift=yes 명시 후 PLAN/spec 수정해서 정합화. PLAN-as-history 정책 정합 |
| **N/A → no** | **FAIL** | PLAN scope = "외부 spec 의존 무" 선언인데 REPORT가 spec 정합 검증 = **scope 확장** | smoke FAIL |
| **N/A → yes** | **FAIL** | 동상 + drift 발견까지 = **명백한 scope 위반** | smoke FAIL |
| **no → N/A** | **WARN** | PLAN spec 의존 선언, REPORT N/A = scope 축소. 정상 가능 (구현 중 spec 의존 제거)이나 의심 케이스 | smoke PASS + ⚠️ |
| **yes → N/A** | **WARN** | 동상 — drift 명시 후 N/A 회복은 의심. PLAN 재작성 가능성 | smoke PASS + ⚠️ |

### 11-2. 핵심 분리선

- PLAN N/A → REPORT 비-N/A = **FAIL** (scope 위반, 사용자 재작성 의무)
- PLAN 비-N/A → REPORT N/A = **WARN** (scope 축소, 사용자 검토 권장 — smoke PASS 유지하되 ⚠️ marker)
- 그 외 5 case = **OK** (drift 진화 자연 패턴)

### 11-3. 적용 범위

Stage 6의 `reports[]` 그대로 재사용. 동일한 레거시 면제 정책 (`is_legacy_report()`) 자동 inherit:

- **In scope**: `sessions/meta/v1.27+/{PLAN,REPORT}.md` pair + 프로젝트 v1.27+ pair (현 0건)
- **Out of scope**: v1.27 미만 레거시 REPORT (REPORT § 의무 부재)

### 11-4. WARN 처리 정책

`smoke-spec-verification.sh` 일관성 (PASS/FAIL/SKIP) 유지 위해 WARN은 **PASS 카운트 + 메시지에 ⚠️ marker**. 별도 WARN 카운터 도입 회피 (smoke 패턴 일관성 위반).

외부 모니터링/CI는 ⚠️ string grep으로 WARN 식별 가능:

```bash
bash tests/smoke-spec-verification.sh | grep -F '⚠️'
```

### 11-5. 매트릭스 vs `--fix` mode 관계

`--fix`는 PLAN/REPORT § skeleton 자동 삽입 (TODO placeholder). 삽입된 skeleton의 drift 값은 `TODO` → Stage 3/6 FAIL → Stage 7 skip ("이전 stage 참조"). 즉 **`--fix` 후 첫 호출 Stage 7는 의미 없음** — 사용자가 TODO 채운 후 재호출 시 Stage 7 발현. 정합.

### 11-6. 후속 분기

- `v1.32b-fix-cross-file-drift` — Stage 7 FAIL 발생 + `--fix` 자동 정정 요구 (현재 0건)
- `v1.32c-cross-section-consistency` — Citations / library / topic cross-file 일관성. evidence 3+ 누적 후

## 12. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 세션 소속: [`OWNERSHIP.md`](OWNERSHIP.md) — Scope contract 직후 본 문서 cross-ref
- 글로벌 user-skill 매트릭스: [`SKILLS.md`](SKILLS.md) — §1 매트릭스 4번째 행
- frontmatter 6축 spec: [`PERMISSION_PATTERN.md`](PERMISSION_PATTERN.md) — 본 SKILL frontmatter 정합 근거
- SKILL 본문: [`../skills/audit/harness-plan-verify/SKILL.md`](../skills/audit/harness-plan-verify/SKILL.md)
- PLAN 필수 § list: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — "PLAN.md 작성" §
- smoke: [`../../tests/smoke-spec-verification.sh`](../../tests/smoke-spec-verification.sh) — 정적 7 stage
- 도입 세션: [`../../sessions/meta/v1.24-plan-spec-verification/`](../../sessions/meta/v1.24-plan-spec-verification/)
- Cross-file 매트릭스 도입 세션 (v1.32): [`../../sessions/meta/v1.32-report-cross-file-consistency/`](../../sessions/meta/v1.32-report-cross-file-consistency/)

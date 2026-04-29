# Spec verification — PLAN context7 검증 § 규격

`sessions/meta/v1.24-plan-spec-verification/`에서 확정. 본 문서는 메타 세션 PLAN 작성 후 외부 spec(Anthropic Claude Code docs 등) drift를 context7으로 검증하는 절차의 단일 소스.

## 1. 개요

### 1-1. 동기

`sessions/meta/v1.10d-bash-permission-pattern-audit/` (5축 frontmatter spec) + `sessions/meta/v1.10g-skill-thinking-effort/` (model+effort A6) + `sessions/meta/v1.23-verify-unification/` (PostToolUse hook spec 재검증) 모두 **수동 패턴**:

- PLAN 작성 → Claude/사용자가 context7 query 임시 실행 → 결과를 PLAN 본문 또는 audit/ 디렉토리에 인용
- "검증을 했는가?"가 PLAN에서 grep 불가 → 매 PLAN마다 즉흥 판단

`v1.23 REPORT` Lessons Learned L1 verbatim:

> "context7 query (C1~C10)로 v1.23 시점 정합 재검증 — 모든 spec이 그대로 유효함을 확인 + 신규 발견 (...). **향후 SKILL/agent spec 변경 시 동일 패턴 (context7 → spec 갱신 세션) 표준화.**"

### 1-2. 본 문서가 정의하는 것

1. PLAN.md `## Spec verification (context7)` § 규격 (§2)
2. 위반 정책 (§3)
3. Context7 source matrix — library ID + 적용 영역 (§4)
4. SKILL `harness-plan-verify` 사용법 (§5)
5. N/A 정책 (§6)
6. 레거시 정책 (§7)
7. 회귀 정책 + self-test (§8)
8. v1.24 적용 + 후속 분기 (§9)
9. 관련 문서 (§10)

### 1-3. 적용 범위

- **In scope**: `sessions/meta/v1.24+/**/PLAN.md`
- **Out of scope** (별 후속 evidence-driven): `sessions/<project>/**/PLAN.md` (v1.24b), REPORT.md (v1.24d), 레거시 v1.24 미만 (forward-only)

## 2. § 규격

모든 `sessions/meta/v1.24+/**/PLAN.md`의 "Out of scope (explicit rejection)" § 직후에 다음 형식으로 의무 배치.

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

## 4. Context7 source matrix

본 세션 v1.24 시점 — 2 source 채택. 향후 evidence-driven 확장 (v1.24c).

| Library ID | 용도 | 적용 영역 | benchmark |
|------------|------|---------|-----------|
| `/websites/code_claude` | Claude Code 공식 docs (1차) | SKILL/hook/permission/frontmatter/agent/slash command/MCP | 83.6 |
| `/anthropics/claude-code` | plugin-dev (2차, conflict 검증) | frontmatter-reference / agent-development / mcp-integration | — |

### 4-1. 매트릭스 사용

1. 본 세션이 의존하는 spec sub-area 식별 (Step 1 keyword grep)
2. 매트릭스에서 해당 영역의 library ID 선택 (1차 → 2차)
3. context7 query 1~2회 (max 3회 — context7 budget)

### 4-2. 매트릭스 확장 정책

신규 외부 spec(Anthropic SDK / agents.md / 외부 라이브러리) 의존 세션 발생 시:

1. `sessions/meta/v1.24c-source-matrix-expand/` 별 세션 진행
2. 해당 라이브러리 ID context7 resolve → benchmark 확인
3. 본 §4 표에 행 추가

매트릭스 부재 라이브러리는 PLAN의 § findings에 임시 인용 가능하나 **재발 시 매트릭스 등재 의무**.

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

자세한 흐름은 `bootstrap/skills/harness-plan-verify/SKILL.md` 참조 — 3-step (Identify → Query → Fill).

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

## 8. 회귀 정책 + self-test

### 8-1. smoke 검증

`tests/smoke-spec-verification.sh` (정적 5 stage):

1. § 헤더 존재 (`^## Spec verification \(context7\)$`)
2. § 구간 추출 후 sub-field 5종 정확 등장
3. drift 값이 `yes` / `no` / `N/A` 중 정확 1개
4. drift=N/A 시 다른 4 sub-field 정확히 `N/A` (부분 N/A 차단)
5. SKILL.md 존재 + frontmatter 정합 (name/model/effort/MCP allowed-tools/thinking 부재)

### 8-2. self-test

v1.24 본 PLAN.md가 § 5 sub-fields + Citations C1~C6 채워진 첫 인스턴스. smoke 자동 enumerate 시 첫 입력 → self-validate.

### 8-3. 회귀 0 정책

본 § 규격 추가는 v1.24+ 신규 PLAN에만 영향. 기존 smoke 7건(smoke-bash-permission-pattern, smoke-thinking-effort, smoke-language-overlay, smoke-legacy-cleanup-overlay, smoke-skills-install, smoke-sync-agents, smoke-verify-sh-parity) + verify.ps1 38/38 PASS 유지.

신규 SKILL `bootstrap/skills/harness-plan-verify/SKILL.md`는 V1/V5/V7/V8/V10 6축 검증 통과 의무 — `tests/smoke-bash-permission-pattern.sh` FILES + `verify.ps1` `$frontmatterFiles` list에 추가.

## 9. v1.24 적용 + 후속 분기

### 9-1. v1.24 본 세션 적용

- PLAN.md `## Spec verification (context7)` § 채워짐 (drift=no, C1~C6)
- SKILL `bootstrap/skills/harness-plan-verify/SKILL.md` 신설
- smoke `tests/smoke-spec-verification.sh` 정적 5 stage
- claude/commands/harness-meta.md PLAN 필수 § list에 추가
- bootstrap/docs/{OWNERSHIP, SKILLS}.md cross-ref

### 9-2. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.24b-project-plan-verify` | 프로젝트 PLAN(`sessions/<project>/**/PLAN.md`)에도 § 의무 확장. evidence-driven |
| `v1.24c-source-matrix-expand` | 본 §4 매트릭스 확장 (Anthropic SDK / agents.md / 외부 라이브러리). evidence-driven |
| `v1.24d-report-spec-verification` | REPORT.md에도 § 의무 확장. post-hoc citation drift 사례 누적 후 |
| `v1.D-postoolse-hook` | PostToolUse hook + tool_input.file_path 필터로 deterministic trigger. SKILL trigger 신뢰성 evidence 비교 후 |
| `v1.B-verify-fix-mode` | smoke `--fix` mode (§ skeleton 자동 삽입) |
| `v1.C-precommit-hook` | pre-commit hook으로 smoke-spec-verification 강제 |

## 10. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md) · [`../../README.md`](../../README.md)
- 세션 소속: [`OWNERSHIP.md`](OWNERSHIP.md) — Scope contract 직후 본 문서 cross-ref
- 글로벌 user-skill 매트릭스: [`SKILLS.md`](SKILLS.md) — §1 매트릭스 4번째 행
- frontmatter 6축 spec: [`PERMISSION_PATTERN.md`](PERMISSION_PATTERN.md) — 본 SKILL frontmatter 정합 근거
- SKILL 본문: [`../skills/harness-plan-verify/SKILL.md`](../skills/harness-plan-verify/SKILL.md)
- PLAN 필수 § list: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — "PLAN.md 작성" §
- smoke: [`../../tests/smoke-spec-verification.sh`](../../tests/smoke-spec-verification.sh) — 정적 5 stage
- 도입 세션: [`../../sessions/meta/v1.24-plan-spec-verification/`](../../sessions/meta/v1.24-plan-spec-verification/)

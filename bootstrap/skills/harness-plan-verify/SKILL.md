---
name: harness-plan-verify
description: |
  메타 세션 PLAN 검증 전용 — harness-meta sessions/meta/**/PLAN.md 작성 후 외부 spec
  (Anthropic Claude Code docs 등) drift를 context7으로 검증하고 PLAN의 'Spec verification
  (context7)' § 표 5 sub-fields를 채운다. 사용자가 'spec 검증' / 'context7 검증' /
  'PLAN 검증' 언급 시 또는 /harness-plan-verify 명시 호출 시 활성. harness-plan(stages 1~4)과
  무관 — 본 SKILL은 메타 세션 PLAN 작성 후 drift 검증 단일 책임.
allowed-tools:
  - Read
  - Grep
  - Edit
  - mcp__plugin_context7_context7__resolve-library-id
  - mcp__plugin_context7_context7__query-docs
model: opus
effort: xhigh
---

# harness-plan-verify — 메타 세션 PLAN context7 spec 검증

PLAN.md 작성 후 외부 spec drift를 context7으로 검증하고 결과를 PLAN의 `## Spec verification (context7)` §에 채운다. v1.24-plan-spec-verification에서 도입.

## 적용 대상

- **In scope**: `sessions/meta/v1.24+/**/PLAN.md`
- **Out of scope**: 프로젝트 PLAN(`sessions/<project>/**/PLAN.md`), v1.24 미만 레거시 PLAN, REPORT.md

## 사용법

### 자동 invoke (description trigger)

사용자가 다음 키워드 언급 시 Claude가 자동 매칭:
- "spec 검증"
- "context7 검증"
- "PLAN 검증"
- "spec drift"

### 수동 invoke (fallback)

description 매칭 실패 시 사용자가 명시 호출:

```
/harness-plan-verify
```

## 흐름 (3-step)

### Step 1 — Identify

1. 본 세션 PLAN.md를 Read
2. 다음 키워드 Grep으로 본 세션이 의존하는 spec area 파악:
   - `SKILL` / `skill` — SKILL.md 표준 (frontmatter, description trigger)
   - `hook` / `Hook` / `PostToolUse` / `PreToolUse` — Claude Code hook spec
   - `permission` / `allowed-tools` / `Bash(` — permission pattern
   - `agent` / `subagent` — agent definition spec
   - `manifest` / `.harness.toml` — manifest schema (외부 spec 무 — 내부)
   - `frontmatter` — YAML frontmatter 표준
   - `MCP` / `mcp__` — MCP server / tool spec
3. 매칭 keyword 0건 → § 모두 N/A 분기 (Step 3로)

### Step 2 — Query

1. `bootstrap/docs/SPEC_VERIFICATION.md` §4 source matrix Read
2. 매칭된 spec area에 해당하는 library ID 선택:
   - 기본: `/websites/code_claude` (Claude Code 공식 docs)
   - 보조 (conflict 검증): `/anthropics/claude-code` (plugin-dev)
3. context7 query 1~2회 (max 3회):
   - 첫 query: 본 세션이 의존하는 spec sub-area의 현 시점 정합 확인
   - 보조 query (필요 시): conflict 사례 또는 changelog 보강
4. 결과에서 다음 추출:
   - 인용 가능한 코드/텍스트 snippet
   - Source URL (`https://code.claude.com/docs/en/...`)
   - 본 세션 PLAN의 결정과의 drift 여부 판단

### Step 3 — Fill

PLAN.md의 `## Spec verification (context7)` § 표 5 sub-fields를 Edit:

```markdown
## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | <Context7-compatible library ID 또는 N/A> |
| **topic** | <검증 키워드 — 본 세션이 의존하는 spec sub-area> |
| **findings** | see citations below (또는 N/A) |
| **drift** | <yes | no | N/A> — <1줄 설명> |
| **re-verify** | <조건 또는 N/A> |

**Citations** (drift=N/A 시 생략):
- C1 — <한 줄 요약> (Source: `<url>`)
- C2 — <한 줄 요약> (Source: `<url>`)
- ...
```

#### Sub-field 작성 규칙

- `library` — Context7 ID 정확 형식 (예: `/websites/code_claude`)
- `topic` — 본 세션 PLAN의 R1~Rn 결정에서 추출한 spec sub-area 키워드 (3~5 키워드)
- `findings` — 단일 라인. drift=N/A면 `N/A`, 아니면 정확히 `see citations below`
- `drift` — 정확히 `yes` / `no` / `N/A` 중 하나 + ` — ` 뒤에 1줄 설명
  - `no` — query 결과가 PLAN 결정과 정합
  - `yes` — query 결과가 PLAN 결정과 불일치 → 사용자에게 PLAN 수정 권장
  - `N/A` — 본 세션 외부 spec 의존 무
- `re-verify` — 재검증 trigger 조건 (예: "v1.24c 글로벌 user-skill 이관 시", "spec 갱신 발견 시", "N/A")

#### N/A 분기 (드물게 — 외부 spec 의존 무 케이스)

본 세션이 순수 문서 정리 / 내부 규약 / 비즈니스 로직만 다루면:

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

⚠️ **부분 N/A 금지**: drift=N/A → 다른 4 sub-field 정확히 `N/A` 강제. 일반 텍스트 혼합 시 smoke 거부.

## 위반 정책 (smoke가 자동 검사)

| 위반 유형 | smoke 처치 |
|---------|---------|
| § 자체 누락 | FAIL |
| sub-field 5개 중 누락 | FAIL |
| drift 값이 yes/no/N/A 외 | FAIL |
| drift=N/A인데 다른 sub-field 비-N/A | FAIL (부분 N/A 금지) |

## 한계

1. **description trigger는 opportunistic** — Claude 자동 매칭 실패 가능. 사용자 명시 호출 fallback 권장
2. **drift 분석 책임** — context7 query 결과와 PLAN 비교는 Claude/사용자 판단. smoke는 § 형식만 검증
3. **PLAN edit-after-§-fill** — § 채운 후 PLAN 본문 변경 시 자동 재검증 mechanism 무. `re-verify` sub-field로 trigger 권장
4. **citation URL 정확성** — smoke 검증 안 함 (Claude/사용자 책임)

## 관련 문서

- `bootstrap/docs/SPEC_VERIFICATION.md` — 단일 소스 (10 § + source matrix)
- `bootstrap/docs/PERMISSION_PATTERN.md` — frontmatter 6축 통합 spec (본 SKILL frontmatter 정합 근거)
- `bootstrap/docs/SKILLS.md` — 글로벌 user-skill 디렉토리 + 배포 (본 SKILL = §1 매트릭스 4번째)
- `claude/commands/harness-meta.md` — PLAN 필수 § list (Spec verification (context7) 포함)
- `tests/smoke-spec-verification.sh` — 정적 5 stage 자동 검증
- 도입 세션: `sessions/meta/v1.24-plan-spec-verification/`

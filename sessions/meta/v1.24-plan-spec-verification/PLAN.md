# meta v1.24-plan-spec-verification — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.23-verify-unification/`](../v1.23-verify-unification/REPORT.md) — verify.sh + Stage H/I 통합 (L1: "context7로 PERMISSION_PATTERN.md spec 정합 재확인 가치 — 향후 SKILL/agent spec 변경 시 동일 패턴 표준화")
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Scope contract 의무화 (본 세션이 두 번째 self-applying mechanism)
- [`sessions/meta/v1.10d-bash-permission-pattern-audit/`](../v1.10d-bash-permission-pattern-audit/PLAN.md) — context7 audit 첫 정형 사례 (수동 패턴)
- [`sessions/meta/v1.10g-skill-thinking-effort/`](../v1.10g-skill-thinking-effort/PLAN.md) — context7 audit 두 번째 정형 사례 (수동 패턴)

목적: PLAN 작성 후 외부 spec drift 검증을 **수동 → 반자동** 전환. Skill description trigger + PLAN § 의무화 + smoke 자기 검증 3 mechanism 결합.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1b(1) `bootstrap/templates/_base/.claude/skills/harness-plan-verify/SKILL.md` + S1a(1) `claude/commands/harness-meta.md` (PLAN 템플릿 § 추가) + S2(2) `bootstrap/docs/{SPEC_VERIFICATION.md(신규), OWNERSHIP.md}` + S3(2) `tests/{smoke-spec-verification.sh(신규), smoke-scope-contract.sh}` + S3(1) `CLAUDE.md` cross-ref = **7/7 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — meta scope 7/7
- **T2 스펙 vs 값** — PLAN 작성 규약 = 모든 세션 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.23-verify-unification/REPORT.md` Lessons Learned L1 (verbatim)**:

> "context7 query (C1~C10)로 v1.23 시점 정합 재검증 — 모든 spec이 그대로 유효함을 확인 + 신규 발견 (changelog 2.1.111 `cd && glob` auto-allow 보강 후보, `effort: medium` 가능 등 — Out of scope로 분리). **향후 SKILL/agent spec 변경 시 동일 패턴 (context7 → spec 갱신 세션) 표준화.**"

**Source 2 — 사용자 발의 (2026-04-29) verbatim**:

> "Plan 작성 후 context7으로 검증하는 워크플로우를 자동화했으면 좋겠어"
>
> 추천안 진행 (C+A 결합):
> 1. PLAN.md에 신규 § `## Spec verification (context7)` 의무 (Scope inheritance와 동격, v1.10j 패턴 재사용)
>    - sub-fields: `library: <id>`, `topic: <keyword>`, `findings: <citation list>`, `drift: yes/no`
> 2. 신규 skill `bootstrap/templates/_base/.claude/skills/harness-plan-verify/SKILL.md` — Claude가 PLAN 작성 후 자동/수동 invoke. context7 query 후 § 채움
> 3. `tests/smoke-spec-verification.sh` — `sessions/meta/v1.24+/**/PLAN.md`에 § 존재 검증 (자동 enumerate 패턴 v1.11 재사용)

**Parsed sub-items (3)**:

1. **PLAN.md `## Spec verification (context7)` § 의무** — Scope inheritance와 동격. sub-fields: library / topic / findings / drift. v1.10j Scope contract 패턴 재사용 (PLAN 거부 정책 포함)
2. **`harness-plan-verify` SKILL** — `bootstrap/templates/_base/.claude/skills/<name>/SKILL.md`. description trigger 또는 `/harness-plan-verify` 명시 호출. context7 query 수행 후 § 채움
3. **`tests/smoke-spec-verification.sh`** — v1.24+ PLAN § 존재 검증. 자동 enumerate (v1.11 glob 패턴 재사용). v1.24 본 PLAN self-test 포함

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Hook 기반 자동화 (PostToolUse on Write) | 별 후속 evidence-driven — context7 검증 (C3): PostToolUse matcher는 tool 이름만, file path 필터는 hook 내부 처리 → SKILL trigger 대비 복잡도 증가. SKILL trigger 신뢰성 evidence 누적 후 (v1.D-postoolse-hook 아이디어) |
| 프로젝트별 PLAN (`sessions/<project>/**/PLAN.md`)에 적용 | 별 후속 evidence-driven — 프로젝트 PLAN은 외부 spec 의존 케이스가 메타 대비 적음 |
| `_base/.claude/skills/`로 SKILL 배포 (모든 프로젝트 자동 활성) | **명시 reject** — 메타 세션은 harness-meta repo에서만 발생, 프로젝트(upbit 등)에 spec 검증 SKILL 배포는 scope misuse. 본 세션은 `bootstrap/skills/`(S1c) opt-in 채택 |
| 자동 query 실행 (Claude가 § 채울 때 context7 invoke 강제) | 본 세션 = SKILL이 사용자/Claude trigger로만 invoke. 강제 자동은 hook과 동일 한계 |
| 검증 통과 못한 PLAN 자동 거부 (smoke가 drift 분석까지 수행) | 별 후속 — drift 검증은 Claude/사용자 책임, smoke는 § 존재 + sub-field 형식만 검사 |
| 회귀 검증 (기존 v1.10d/v1.10g/v1.23 audit를 § 형식으로 후행 변환) | 별 후속 — v1.24+ forward-only. v1.10j 레거시 미적용 정책과 동일 |
| `--fix` mode (smoke가 § skeleton 자동 삽입) | 별 후속 evidence-driven (v1.B-verify-fix-mode 아이디어와 합칠 가능성) |
| context7 source matrix 확장 (Anthropic SDK / agents.md 표준 등) | 별 후속 evidence-driven. 본 세션은 `/websites/code_claude` + `/anthropics/claude-code` 2 source만 (v1.24d-source-matrix-expand) |
| REPORT.md `## Spec verification` § 의무 | 별 후속 — REPORT는 post-hoc, PLAN이 forward 검증의 1차 게이트. REPORT § 의무는 evidence 누적 후 |
| PLAN edit-after-§-fill 자동 재검증 | 별 후속 — 텍스트 sub-field "재검증 시점"으로 trigger 권장 (mechanism 무) |
| pre-commit hook으로 smoke 강제 | 별 후속 (v1.C-precommit-hook 아이디어) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` (Anthropic 공식 docs, benchmark 83.6) |
| **topic** | SKILL.md frontmatter (`name`/`description`/`allowed-tools`/`disable-model-invocation`) + description-based auto-invocation + PostToolUse hook matcher semantics + MCP tool name format in allowed-tools |
| **findings** | see citations below |
| **drift** | no — v1.10d/v1.10g/v1.23 audit 시점 spec과 v1.24 시점 spec 동일. SKILL 단독 채택은 C3에 의해 보강 |
| **re-verify** | spec 갱신 발견 시 또는 source matrix 확장 (v1.24d) 시 |

**Citations**:
- C1 — SKILL frontmatter 4 핵심 필드 (`name`/`description`/`allowed-tools`/`disable-model-invocation`) (Source: `https://code.claude.com/docs/en/skills`)
- C2 — `description` field가 Claude task matching trigger ("Use when..." 패턴 + 사용자가 자연스럽게 말할 키워드 권장) (Source: `https://code.claude.com/docs/en/skills` + `/docs/en/features-overview`)
- C3 — PostToolUse `matcher`는 tool name만 (Bash/Edit/Write 등) — file_path 필터는 hook 내부 `tool_input.file_path` 처리 (Source: `https://code.claude.com/docs/en/hooks-guide` + `/docs/en/agent-sdk/hooks`)
- C4 — Skill descriptions session start에 load + 매 사용자 요청에 task 매칭 (Source: `https://code.claude.com/docs/en/features-overview`)
- C5 — Troubleshooting: description 키워드 부적절 시 `/skill-name` 직접 invoke fallback (Source: `https://code.claude.com/docs/en/skills` Troubleshooting §)
- C6 — MCP tool 이름은 `mcp__<server>__<tool>` 형식으로 `allowed-tools`에 사용 가능 (wildcards `mcp__server__*` 지원) (Source: `https://code.claude.com/docs/en/permissions` + `/docs/en/agent-sdk/mcp`)

## 1. 문제 (수동 검증 비용)

### 현재 상태

- v1.10d (5축 audit), v1.10g (A6 model+effort), v1.23 (verify Stage H/I context7 재검증) — 모두 **수동 패턴**:
  - PLAN 작성 → 사용자 또는 Claude가 context7 query 임시 실행 → 결과를 PLAN 본문에 인용 (없으면 누락)
  - PLAN 본문 인용은 "audit/A1-A5.md" 별도 디렉토리 또는 본문 산재
  - **§ 규격 부재** → 어느 PLAN이 검증을 거쳤는지 grep 불가
- v1.23 REPORT L1: "향후 SKILL/agent spec 변경 시 동일 패턴 표준화" 직접 명시

### Root cause

**검증 절차의 절차화 부재** → "context7 query 해야 하나?"를 매 PLAN마다 Claude/사용자가 즉흥 판단. v1.10j Scope contract 도입 이전의 over-scope drift 문제와 동일 패턴.

### 본 세션 해결 범위

**3 mechanism 결합으로 self-applying**:
1. PLAN § 의무 → "검증 했는가?" 명시화
2. SKILL description trigger → "어떻게 검증" 단일 소스
3. smoke § 검증 → "잊었는가?" 자동 차단

## 2. 결정 (R1 ~ R5)

### R1 — PLAN.md `## Spec verification (context7)` § 규격

**의무 위치**: 모든 `sessions/meta/v1.24+/**/PLAN.md`의 "Out of scope" § **직후**.

**규격** (Markdown 표 + 본문 list — D2.5 multi-line 처리):

```markdown
## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | <Context7-compatible library ID 또는 N/A> |
| **topic** | <검증 키워드 — 본 세션이 의존하는 spec sub-area> |
| **findings** | see citations below (또는 N/A) |
| **drift** | <yes \| no \| N/A> — 1줄 설명 |
| **re-verify** | <조건 또는 N/A> |

**Citations** (drift=N/A 시 생략 가능):
- C1 — <한 줄 요약> (Source: `<url>`)
- C2 — <한 줄 요약> (Source: `<url>`)
- ...
```

**규격 결정 (D2.4 + D2.5 + D5.1)**:
- sub-field key 영문화: `library` / `topic` / `findings` / `drift` / `re-verify` (한국어 `재검증 시점` → `re-verify` — Git Bash UTF-8 locale 의존 회피)
- `findings` cell은 단일 라인 `see citations below` (drift=N/A 시 `N/A`) — multi-line citations는 § 본문 list로 분리
- `drift` 값은 정확히 `yes` / `no` / `N/A` 중 하나 (1줄 설명은 ` — ` 뒤)
- § 헤더 정확 매치: `^## Spec verification \(context7\)$`

**N/A 분기 (D2.3 — opt-out 정확 정의)**:
- 본 세션이 외부 spec에 의존하지 않으면 → 모든 sub-field `N/A` + 본문에 1줄 사유
- drift=N/A → `library`/`topic`/`findings`/`re-verify` 4 sub-field도 정확히 `N/A` (또는 `<...>` placeholder 형식만 허용, 일반 텍스트 금지)
- 부분 N/A 금지 — drift=N/A인데 findings에 일반 텍스트 = smoke FAIL
- N/A 명시는 § 누락 아님 → smoke PASS

**위반 정책** (v1.10j Scope contract 패턴 재사용):

| 위반 유형 | 처치 |
|---------|------|
| § 자체 누락 | PLAN 거부 + 사용자 재작성 요청 |
| sub-field 5개 중 누락 | PLAN 거부 |
| drift 값이 yes/no/N/A 외 | PLAN 거부 |
| drift=N/A인데 다른 sub-field 비-N/A | PLAN 거부 (부분 N/A 금지) |
| findings에 인용 부재 (drift=no인데 Citations 본문 list 무) | PLAN 거부 또는 사용자 재확인 |
| drift=yes 명시 후에도 PLAN이 spec drift 미반영 | over-scope drift와 동일 — 사용자 재검토 |

### R2 — `harness-plan-verify` SKILL (글로벌 user-skill, S1c)

**파일**: `bootstrap/skills/harness-plan-verify/SKILL.md` (D1.1 결정 — `_base/.claude/skills/` 아닌 `bootstrap/skills/` 글로벌 opt-in)

**배포 방식**: `install-skills.{ps1,sh}` opt-in → `~/.claude/skills/harness-plan-verify/` symlink (v1.19 패턴 동일)

**Frontmatter** (PERMISSION_PATTERN.md 6축 준수):

```yaml
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
```

**근거**:
- **D3.2 trigger 표현 재작성** — "PLAN.md 작성 직후"(file event 부재로 over-promise) → "사용자가 'spec 검증' / 'context7 검증' / 'PLAN 검증' 언급 시" (사용자 발화 매칭 + `/harness-plan-verify` 명시 호출 fallback). context7 C5 Troubleshooting 권장 패턴 정합
- **D1.3 harness-plan 충돌 회피** — description 첫 줄에 "**메타 세션 PLAN 검증 전용**" + "harness-plan(stages 1~4)과 무관" 명시. 기존 harness-plan은 `disable-model-invocation: true` (explicit only)이므로 실 충돌 없음
- **D4.1 MCP tool 이름 형식** — context7 검증 완료: `mcp__<server>__<tool>` (server = `plugin_context7_context7`, tool = `query-docs` 하이픈). `allowed-tools`에 그대로 사용 가능
- `model: opus` + `effort: xhigh` — 검증/설계 책임 (PERMISSION_PATTERN.md A6 R2 정합 — harness-plan/design/ship 동일 매트릭스)
- `disable-model-invocation` **무** — description trigger auto-invoke 허용
- `thinking:` 필드 **무** (V10 정합)
- 자동 허용 set 미declare (V5 정합)

**본문 흐름** (3-step):
1. **Identify** — PLAN.md Read → 본 세션이 의존하는 spec area 파악 (SKILL/hook/permission/agent/manifest/frontmatter 키워드 Grep)
2. **Query** — `bootstrap/docs/SPEC_VERIFICATION.md`의 source matrix lookup → context7 resolve-library-id (필요 시) → query-docs 1~2회 (max 3회)
3. **Fill** — Edit로 PLAN의 `## Spec verification (context7)` § 표 5 sub-fields 채움

**Fallback**: PLAN이 외부 spec 의존 무 → § sub-fields 모두 `N/A` + 본문에 사유 1줄

**Trigger 신뢰성 (D3.1 한계 명시)**: description trigger는 opportunistic. Claude 자동 매칭 실패 시 사용자 명시 호출 (`/harness-plan-verify`)로 fallback. smoke § 검증이 누락 backstop.

### R3 — `bootstrap/docs/SPEC_VERIFICATION.md` 신설 (단일 소스)

**경로**: `bootstrap/docs/SPEC_VERIFICATION.md` (~120~160 lines)

**구성** (10 §):
1. 개요 (수동 → 반자동 전환 동기 + v1.23 REPORT L1 인용)
2. § 규격 (R1 verbatim — 표 + N/A 분기)
3. 위반 정책 (R1 verbatim — 4 케이스)
4. **Context7 source matrix** (현 시점 2 source):
   | Library ID | 용도 | 적용 영역 |
   |------------|------|---------|
   | `/websites/code_claude` | Claude Code 공식 docs (benchmark 83.6) | SKILL/hook/permission/frontmatter/agent/slash command |
   | `/anthropics/claude-code` | plugin-dev frontmatter-reference + agent-development + mcp-integration | conflict 사례 보조 검증 |
5. SKILL 사용법 (description trigger 자동 invoke + `/harness-plan-verify` 명시 호출 + Troubleshooting C5 fallback)
6. N/A 정책 (외부 spec 의존 무 케이스 — 사용자 명시 opt-out)
7. 레거시 정책 (v1.24 이전 PLAN은 소급 의무 무 — v1.10j 패턴 재사용)
8. 회귀 정책 (v1.24 본 PLAN self-test 포함)
9. v1.24 적용 + 후속 분기 (v1.24b 글로벌 배포 / 프로젝트 PLAN 확장 / hook 추가 등 evidence-driven)
10. 관련 문서 (PERMISSION_PATTERN / OWNERSHIP / SKILLS / 본 세션 링크)

### R4 — `tests/smoke-spec-verification.sh` 신설

**검증 대상**: `sessions/meta/v1.24*/PLAN.md` glob (자동 enumerate, v1.11 패턴)

**§ 구간 추출 (D2.1)**: `awk '/^## Spec verification \(context7\)$/,/^## /'` 또는 `sed -n '/^## Spec verification/,/^## [^S]/p'` — 전역 grep 회피로 false positive 차단

**Stages** (정적 5):

```bash
S1 — § 헤더 존재
  for plan in sessions/meta/v1.24*/PLAN.md; do
    grep -qE '^## Spec verification \(context7\)$' "$plan" || ERR
  done

S2 — § 구간 추출 후 sub-field 5종 존재
  section=$(awk '/^## Spec verification \(context7\)$/,/^## /' "$plan")
  for sub in '\*\*library\*\*' '\*\*topic\*\*' '\*\*findings\*\*' '\*\*drift\*\*' '\*\*re-verify\*\*'; do
    echo "$section" | grep -qE "\| $sub \|" || ERR
  done

S3 — drift 값 정합 (yes/no/N/A 중 정확 1개, BSD/GNU grep 양립)
  drift_cell=$(echo "$section" | grep -E '^\| \*\*drift\*\* \|' | sed -E 's/^\| \*\*drift\*\* \| ([^ ]+).*/\1/')
  case "$drift_cell" in yes|no|N/A) :;; *) ERR;; esac

S4 — N/A 분기 정합 (drift=N/A → 다른 4 sub-field도 정확히 N/A)
  if [ "$drift_cell" = "N/A" ]; then
    for sub in library topic findings re-verify; do
      val=$(echo "$section" | grep -E "^\| \*\*${sub}\*\* \|" | sed -E 's/^\| \*\*[^*]+\*\* \| ([^|]*) \|.*/\1/' | sed 's/[[:space:]]*$//')
      [ "$val" = "N/A" ] || ERR  # 부분 N/A 금지
    done
  fi

S5 — SKILL.md 존재 + frontmatter 정합 (정적 grep, bootstrap/skills/ 글로벌 user-skill)
  test -f bootstrap/skills/harness-plan-verify/SKILL.md
  grep -qE '^name: harness-plan-verify$' SKILL.md
  grep -qE '^model: opus$' SKILL.md
  grep -qE '^effort: xhigh$' SKILL.md
  grep -q 'mcp__plugin_context7_context7__query-docs' SKILL.md
  grep -q 'mcp__plugin_context7_context7__resolve-library-id' SKILL.md
  ! grep -qE '^thinking:' SKILL.md   # V10 정합
```

**v1.24 self-test**: 본 PLAN.md가 § 5 sub-fields 모두 채워진 첫 인스턴스 → smoke 자동 enumerate 시 self-validate

**Out of scope**: drift 분석 (Claude/사용자 책임), citation URL 정규화 (별 후속), citation 본문 list 존재 검증 (drift=no 시 권장이나 smoke 강제 안 함 — false positive 위험)

### R5 — `tests/smoke-scope-contract.sh` 갱신 (v1.24 자동 흡수)

```bash
# 기존 glob에 v1.24 추가
for plan in sessions/meta/v1.10h*/PLAN.md sessions/meta/v1.10j*/PLAN.md \
            sessions/meta/v1.11*/PLAN.md sessions/meta/v1.21*/PLAN.md \
            sessions/meta/v1.22*/PLAN.md sessions/meta/v1.23*/PLAN.md \
            sessions/meta/v1.24*/PLAN.md; do
  ...
done
```

→ v1.24 PLAN의 Scope contract 2 § (Scope inheritance + Out of scope) 자동 검사 흡수.

## 3. 변경 대상 (6 수정 + 4 신규)

### 신규 (4)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/skills/harness-plan-verify/SKILL.md` | S1c | R2 — 글로벌 user-skill (frontmatter 6축 + 3-step 흐름) |
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R3 — 단일 소스 (10 §) |
| `tests/smoke-spec-verification.sh` | S3 | R4 — 정적 5 stage |
| `sessions/meta/v1.24-.../{PLAN,REPORT}.md` | meta | 본 세션 기록 |

### 수정 (6)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | PLAN 필수 § list에 "Spec verification (context7)" 추가 (Scope contract 2 § 직후) + 1줄 cross-ref to SPEC_VERIFICATION.md |
| `bootstrap/docs/OWNERSHIP.md` | S2 | "## Scope contract" § 직후 1줄 cross-ref to SPEC_VERIFICATION.md (별 § 신설 안 함 — verbatim 의무는 SPEC_VERIFICATION.md에 분리) |
| `bootstrap/docs/SKILLS.md` | S2 | §1 매트릭스 표에 `harness-plan-verify` 행 추가 (v1.24 도입, description trigger + meta 전용) |
| `CLAUDE.md` | S3 | "관련 문서" § 1줄 cross-ref + install-skills 명령 안내 |
| `tests/smoke-scope-contract.sh` | S3 | R5 — v1.24 glob 추가 |
| `tests/smoke-bash-permission-pattern.sh` (D4.2) | S3 | FILES 배열에 `bootstrap/skills/harness-plan-verify/SKILL.md` 추가 (V1/V5/V8 검증 포함) |
| `verify.ps1` (D4.2) | S3 | `$frontmatterFiles` 배열에 동상 1줄 추가 (Stage I 6축 검증 포함) |

## 4. 목표

- [x] Stage 0 — context7 spec 검증 (SKILL frontmatter + PostToolUse hook + description trigger + MCP allowed-tools 형식 → C1~C6 finding — § 위에 채움)
- [x] Stage A — 세션 디렉토리 + PLAN.md 작성 (D1.1~D7.4 22 issue 분석 후 5건 권장안 반영)
- [ ] **Stage B — 사용자 PLAN 확인 (진행 승인 받기 전까지 구현 시작 금지)**
- [ ] Stage C — `bootstrap/skills/harness-plan-verify/SKILL.md` 신설 (R2 — 글로벌 user-skill, S1c)
- [ ] Stage D — `claude/commands/harness-meta.md` PLAN § list 갱신 (R1 cross-ref)
- [ ] Stage E — `bootstrap/docs/SPEC_VERIFICATION.md` 신설 (R3 — 10 §)
- [ ] Stage F — `tests/smoke-spec-verification.sh` 신설 (R4 — § 구간 추출 + 부분 N/A 차단) + `tests/smoke-scope-contract.sh` v1.24 glob (R5) + 양쪽 실행 (smoke 작성 후 본 PLAN finalize 정합 — D5.4 순서)
- [ ] Stage G — cross-ref 갱신 — `bootstrap/docs/OWNERSHIP.md` + `bootstrap/docs/SKILLS.md` §1 매트릭스 + `CLAUDE.md` + `tests/smoke-bash-permission-pattern.sh` FILES + `verify.ps1` `$frontmatterFiles` (D4.2)
- [ ] Stage H — REPORT.md + 사용자 커밋 확인

## 5. 성공 기준

- [ ] `bootstrap/skills/harness-plan-verify/SKILL.md` 존재 + frontmatter 6축 정합 (`name`/`description`/`allowed-tools` YAML list 5개 (Read+Grep+Edit+context7 2 tool)/`model: opus`/`effort: xhigh` + `thinking:` 부재 + `disable-model-invocation` 부재)
- [ ] `bootstrap/docs/SPEC_VERIFICATION.md` 존재 + 10 § 모두 작성 + Context7 source matrix 표 포함
- [ ] `tests/smoke-spec-verification.sh` 5/5 PASS — v1.24 본 PLAN self-test 통과 (drift=no, sub-field 5종 정합)
- [ ] `tests/smoke-scope-contract.sh` v1.24 glob 자동 흡수 PASS
- [ ] `claude/commands/harness-meta.md` PLAN § list에 "Spec verification (context7)" 명시
- [ ] `bootstrap/docs/OWNERSHIP.md` Scope contract 직후 cross-ref 1줄
- [ ] `bootstrap/docs/SKILLS.md` §1 매트릭스에 harness-plan-verify 행 추가
- [ ] `CLAUDE.md` 관련 문서 SPEC_VERIFICATION.md cross-ref 1줄
- [ ] `tests/smoke-bash-permission-pattern.sh` FILES list에 신규 SKILL 추가 (D4.2) + 7/7 PASS
- [ ] `verify.ps1` `$frontmatterFiles` list에 신규 SKILL 추가 (D4.2) + Stage I 5/5 PASS
- [ ] **회귀 0** — 기존 smoke 7건 전부 PASS (smoke-bash-permission-pattern, smoke-thinking-effort, smoke-language-overlay, smoke-legacy-cleanup-overlay, smoke-skills-install, smoke-sync-agents, smoke-verify-sh-parity)
- [ ] **verify.ps1 회귀 0** — Stage I (frontmatter 6축) 신규 SKILL 14번째 파일 포함 검증 PASS

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.24-plan-spec-verification — PLAN context7 spec 검증 § 의무 + harness-plan-verify SKILL

- add: bootstrap/templates/_base/.claude/skills/harness-plan-verify/SKILL.md (R2 — frontmatter 6축 + 3-step 흐름)
- add: bootstrap/docs/SPEC_VERIFICATION.md (R3 — 10 § 단일 소스 + Context7 source matrix 2 source)
- add: tests/smoke-spec-verification.sh (R4 — 정적 5 stage)
- update: claude/commands/harness-meta.md (PLAN 필수 § list에 Spec verification 추가)
- update: bootstrap/docs/OWNERSHIP.md (Scope contract 직후 cross-ref 1줄)
- update: CLAUDE.md (관련 문서 cross-ref 1줄)
- update: tests/smoke-scope-contract.sh (R5 — v1.24 glob 추가)
- add: sessions/meta/v1.24-.../{PLAN,REPORT}.md

Scope: PLAN 작성 후 context7 spec drift 검증 mechanism 절차화.
- v1.10j Scope contract 패턴 재사용 — § 의무 + 위반 정책 + 자동 enumerate smoke
- SKILL description trigger (Claude auto-invoke) + `/harness-plan-verify` 명시 호출 fallback
- v1.24+ forward-only (레거시 소급 무, v1.10j 패턴 정합)

Smoke: smoke-spec-verification 5/5 + smoke-scope-contract v1.24 glob PASS.
회귀 0 — 기존 smoke 7건 + verify.ps1 Stage I 정합.

context7 검증: /websites/code_claude C1~C5 (SKILL frontmatter + description trigger + PostToolUse matcher) — drift no.
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.24b-project-plan-verify` | 프로젝트 PLAN에도 § 의무 확장. evidence-driven (프로젝트 PLAN이 SKILL/hook spec 의존하는 사례 누적 후) |
| `v1.24c-source-matrix-expand` | Context7 source matrix 확장 (Anthropic SDK / agents.md / 외부 라이브러리). evidence-driven |
| `v1.24d-report-spec-verification` | REPORT.md에도 § 의무 확장. evidence (post-hoc citation drift 사례) 누적 후 |
| `v1.D-postoolse-hook` | PostToolUse hook + tool_input.file_path 필터로 deterministic trigger. SKILL trigger 신뢰성 evidence 비교 후 |
| `v1.B-verify-fix-mode` | smoke `--fix` mode (§ skeleton 자동 삽입). 본 R4 smoke와 합칠 가능성 |
| `v1.C-precommit-hook` | pre-commit hook으로 smoke-spec-verification + smoke-scope-contract 강제 |
| `v1.24-multi-os-validation` | (v1.23 REPORT 다음 후보) verify.sh dynamic 3건 Linux/macOS/WSL 실 검증 — 본 v1.24와 별 도메인. 이름 충돌 주의 (별 prefix 권장: `v1.25-...`) |

## 8. Lessons Forward (예상)

- **L1 — Self-applying mechanism의 두 번째 사례** — v1.10j Scope contract (§ 의무 + smoke)에 이어 본 세션이 같은 패턴 재사용. PLAN의 § 의무는 v1.24 본 PLAN 자신에게 첫 적용 → mechanism 자기 검증 (`## Spec verification (context7)` § 본 PLAN에 채워짐)
- **L2 — context7 검증의 절차화 가치** — v1.10d/v1.10g/v1.23 모두 수동 패턴이었고 each 세션 시점에 spec drift 가능성을 즉흥 판단. § 의무화로 "검증 했나?" 명시화
- **L3 — Hook vs SKILL trigger trade-off** — context7 finding C3 (PostToolUse matcher tool name only)로 SKILL 단독 채택 결정 보강. hook은 file_path 필터링 복잡도가 description trigger 신뢰성 손실과 비견되지 않음
- **L4 — opt-out 분기 (N/A) 의무** — v1.10j Scope contract는 빈 표 = "없음" 선언만 허용. 본 세션은 외부 spec 의존 무 케이스를 N/A 명시로 첫 정형화 → smoke가 § 누락과 N/A 분기 모두 검증

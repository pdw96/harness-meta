# A2 — Anthropic docs cross-reference

본 audit는 v1.10f 결정의 권위 인용을 확보한다. 출처 2개:
- **1차**: code.claude.com 공식 docs (permissions / skills / settings) — v1.10d audit/A1에서 인용 1-10 확보
- **2차**: context7 `/anthropics/claude-code` plugin-dev — 본 v1.10f에서 추가 인용 (subagent `tools:` 필드 + broad Bash 의미)

## 1. 필드명 매트릭스 (v1.10d 인용 7-8, 10 + 본 v1.10f 인용 11-13)

| 파일 위치 | 공식 필드 | 인용 # |
|-----------|----------|:---:|
| `.claude/commands/*.md` (slash command) | **`allowed-tools:`** | v1.10d 인용 8 |
| `.claude/skills/*/SKILL.md` (skill) | **`allowed-tools:`** | v1.10d 인용 7 |
| `.claude/agents/*.md` (subagent) | **`tools:`** | v1.10d 인용 10 + **인용 11** (본) |

### 인용 11 (subagent `tools:` 필드 — 본 v1.10f 신규)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/agent-development/SKILL.md
> "YAML frontmatter configuration showing all required and optional fields for agent definition. Includes name, description reference, model selection, color assignment, and **optional tools restriction array**."
> ```yaml
> ---
> name: agent-identifier
> description: Use this agent when [triggering conditions]...
> model: inherit
> color: blue
> tools: ["Read", "Write", "Grep", "Bash"]
> ---
> ```

→ **결론**: agent의 `tools:` 필드는 **array 형식 권장** (`["Read", ...]` 대괄호 또는 YAML list). 본 v1.10f의 `harness-verifier.md` `tools:` → YAML list 정정 정합.

### 인용 12 (broad Bash `*` 비권장)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/command-development/references/frontmatter-reference.md
> "When configuring the `allowed-tools` field, it's a best practice to be **as restrictive as possible**, granting only the absolutely necessary permissions to your command. For Bash commands, **always use specific command filters (e.g., `Bash(git:*)`) instead of broad wildcards (`*`)** to enhance security and prevent unintended operations."

→ **본 v1.10f 정책 재확인**:
- 일반 원칙: broad `Bash` (`*` equivalent) 비권장
- **예외**: 동적 가변 명령 (`{executor}`, `{test_cmd}`)이 fine-grain 시도 fragile → broad 유지가 spec 위배 아닌 **R3' Conservative trade-off** (PERMISSION_PATTERN.md §6)
- 단순화: 정적 명령은 fine-grain (e.g., harness-design SKILL의 `Bash(mkdir *)`) / 동적 명령은 broad (harness-run/ship)

### 인용 13 (read-only는 `Read, Grep`)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/command-development/references/frontmatter-reference.md
> "This YAML configuration restricts a slash command to perform only read-only operations using `Read, Grep`. By explicitly limiting tool access, this ensures the command cannot modify any data or system state, significantly enhancing security."

→ **본 v1.10f 정책 적용**:
- `harness/SKILL.md` 디스패처 — 본문 사실상 read-only (Read·Grep·Glob)
- declare에서 `Bash` 제거하면 read-only 패턴에 가까워짐 (R2 결정 정합)
- 단 Edit는 보존 (디스패처가 미래 안내문 Edit 가능성 — R5 Grey G1)

---

## 2. Separator (v1.10d 인용 7 — 본 v1.10f 추가 인용 14)

### 인용 14 (array 형식 권장 — 본 v1.10f 신규)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/command-development/references/frontmatter-reference.md
> "**Formats:**
> - Single tool: `allowed-tools: Read`
> - Multiple tools (comma-separated): `allowed-tools: Read, Write, Edit`
> - Multiple tools (array):
> ```yaml
> allowed-tools:
>   - Read
>   - Write
>   - Bash(git:*)
> ```"

→ **분석**:
- Anthropic plugin-dev docs는 **3 형식 모두 명시** (single / 콤마 / array)
- v1.10d audit/A1 인용 7 (skills docs verbatim "space-separated string or YAML list")과 **부분 conflict**:
  - skills docs: 콤마 미언급 ("space-separated string OR YAML list")
  - plugin-dev docs: 콤마 명시 ("comma-separated")
- **결론**: conflict 해결 — 본 repo는 **YAML list 채택** (PERMISSION_PATTERN.md §3 권장)
  - 이유 1: skills docs spec verbatim (보수적 source)
  - 이유 2: 콤마 vs 공백 separator 분기 모호성 0 (확장성)
  - 이유 3: `Bash(git:*)` 같은 콜론 패턴이 콤마와 충돌 가능 (실험적)

### 본 v1.10f 4 파일 적용

| 파일 | 현재 (v1.10d 위반) | 정정 (v1.10f) |
|------|---|---|
| `harness/SKILL.md` | `Read, Glob, Grep, Bash, Edit` | YAML list 4 entries (Bash 제거) |
| `harness-run/SKILL.md` | `Read, Glob, Grep, Bash, Edit` | YAML list 5 entries |
| `harness-ship/SKILL.md` | `Read, Glob, Grep, Bash, Edit(phases/**), Write(phases/**)` | YAML list 6 entries (Edit/Write fine-grain 보존) |
| `harness-verifier.md` (`tools:`) | `Read, Glob, Grep, Bash` | YAML list 4 entries |

---

## 3. broad `Bash` (parens 없음) 의미 (v1.10d 인용 1 + 본 v1.10f 추가 인용 15)

### v1.10d 인용 1 재인용

> **Source**: code.claude.com/docs/en/permissions
> "The space before `*` matters: `Bash(ls *)` matches `ls -la` but not `lsof`, while `Bash(ls*)` matches both. The `:*` suffix is an equivalent way to write a trailing wildcard..."

### 인용 15 (broad Bash 의미 — 본 v1.10f 신규)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/command-development/examples/plugin-commands.md
> "Without declaring allowed-tools in the frontmatter, commands using Bash or other restricted tools will fail with permission errors."
> ```markdown
> # Missing allowed-tools
> !`bash script.sh`  # Will fail without Bash permission
> 
> # Correct
> ---
> allowed-tools: Bash(*)
> ---
> !`bash ${CLAUDE_PLUGIN_ROOT}/scripts/script.sh`
> ```

→ **결론**: `Bash(*)` 표기가 공식 docs에서 명시적으로 등장. broad declare가 **spec 무효 아님** (단지 비권장). 본 v1.10f의 `harness-run`/`harness-ship`/`harness-verifier`의 broad 유지는 `Bash` (parens 없음) = `Bash(*)` equivalent (PERMISSION_PATTERN.md §4 매트릭스).

### `Bash` (parens 없음) vs `Bash(*)` 동치성

| 표기 | 의미 | 동치 |
|------|------|------|
| `Bash` | Bash tool 전체 (filter 없음) | `Bash(*)`와 의미적 동일 |
| `Bash(*)` | wildcard filter (모든 명령 매치) | `Bash`와 의미적 동일 |
| `Bash(git:*)` | git 명령만 매치 | filter 적용 |

본 v1.10f는 **`Bash` (parens 없음)** 표기 채택 — 간결성. spec 측면에서 `Bash(*)`와 동일 효과.

---

## 4. 자동 허용 set (v1.10d 인용 3 재인용)

> **Source**: code.claude.com/docs/en/permissions
> "Claude Code recognizes a built-in set of Bash commands as **read-only and runs them without a permission prompt in every mode**. These include `ls`, `cat`, `head`, `tail`, `grep`, `find`, `wc`, `diff`, `stat`, `du`, `cd`, and **read-only forms of `git`**. The set is not configurable."

### 본 v1.10f 적용 검증 (A1 §5 매트릭스)

| 파일 | AUTO 사용 | declare 영향 |
|------|---|---|
| `harness/SKILL.md` | (Bash 미사용) | declare 제거해도 자동 허용 작동 ✓ |
| `harness-run/SKILL.md` | 0 | DYN 명령은 자동 허용 외 (broad 필요) |
| `harness-ship/SKILL.md` | 3 (`git branch`, `git status`, `git status --porcelain`) | declare 제거 가능하나 DYN/WRITE 때문에 broad 유지 |
| `harness-verifier.md` | 0 | (verifier 본문 Bash 0) |

→ `harness/SKILL.md`만 자동 허용 set으로 충분히 작동 가능 → R2 결정 (declare 제거) 정합.

---

## 5. `allowed-tools` semantics (v1.10d 인용 9 재인용)

> **Source**: code.claude.com/docs/en/skills
> "The `allowed-tools` field grants permission for the listed tools while the skill is active... It does not restrict which tools are available."

### 본 v1.10f 핵심 함의

- `allowed-tools` 또는 `tools` = **pre-approval 목록**. 차단 아님
- declare 제거 = 차단 아님 = baseline 폴백 (자동 허용 또는 prompt)
- → `harness/SKILL.md`에서 `Bash` declare 제거해도 디스패처가 우연히 Bash 실행 시 prompt 발생 (안전 default)
- → tool 차단은 settings.json `permissions.deny` rule (frontmatter 영역 외)

본 v1.10f는 frontmatter의 **pre-approval 목록 정정**만 수행. deny rule은 사용자 settings.json 책임 (PERMISSION_PATTERN.md §9 마이그레이션 가이드).

---

## 6. Plugin-dev vs skills docs 권위 우선순위

본 v1.10f에서 발견된 conflict (인용 14 vs v1.10d 인용 7):

| 항목 | plugin-dev docs | skills docs (code.claude.com) | 채택 |
|------|----------|----------|:---:|
| Separator | comma OK ("comma-separated") | space OR YAML list (콤마 미언급) | **YAML list** (보수적) |
| broad Bash | `Bash(*)` 명시 (인용 15) | restrictive 권장 (v1.10d 인용 12) | **broad는 동적 변수만** |

**우선순위 정책** (PERMISSION_PATTERN.md §11 후속):
1. **1차** — code.claude.com 공식 docs (permissions / skills / settings)
2. **2차** — context7 plugin-dev (보조, conflict 시 1차 우선)

본 v1.10f는 1차 우선. plugin-dev `Bash(*)` 인용은 broad의 spec 무효 아님을 입증하는 보조 evidence로만 사용.

---

## 7. 종합 — 본 v1.10f 결정 권위 매핑

| 결정 | 인용 # | 출처 |
|------|:---:|------|
| R1 (4 파일) | v1.10d audit/A2 + 본 audit/A1 | 본 repo evidence |
| R2 (`harness/` Bash 제거) | 인용 13 (read-only 패턴) + 인용 12 (restrictive 권장) | plugin-dev + skills docs |
| R3 (`harness-run`/`ship` broad 유지) | 인용 1 (pattern format) + 인용 15 (`Bash(*)` 명시) + PERMISSION_PATTERN.md §6 R3' | permissions docs + plugin-dev |
| R4 (`harness-verifier` broad 유지) | 인용 11 (`tools:` 필드) + 인용 12 (restrictive 권장) | plugin-dev |
| R5 (Edit/Write fine-grain 보존) | 인용 13 (restrictive) + PERMISSION_PATTERN.md §4 매트릭스 | skills docs |
| Format (YAML list) | 인용 7 (skills) + 인용 14 (plugin-dev) | skills docs (보수적) |

**권위 누락 영역** (본 v1.10f scope 외, 후속):
- subagent `tools:` 필드의 broad `Bash` 의미 — 명시적 인용 없음. agent 4-Functional 미래 확장 시 별도 검증 필요
- `Bash` (parens 없음) vs `Bash(*)` 미묘 차이 — docs 동치 명시 없음. PERMISSION_PATTERN.md §4 매트릭스 채택 (실험적 검증 후 v1.10f Lessons에 기록)

## 8. 관련 문서

- 본 세션 PLAN: [`../PLAN.md`](../PLAN.md)
- A1 본문 inventory: [`A1-bash-usage.md`](A1-bash-usage.md)
- A3 동적 변수: [`A3-dynamic-vars.md`](A3-dynamic-vars.md)
- 5축 spec: [`../../../../bootstrap/docs/PERMISSION_PATTERN.md`](../../../../bootstrap/docs/PERMISSION_PATTERN.md)
- 선행 audit: [`../../v1.10d-bash-permission-pattern-audit/audit/A1-anthropic-docs.md`](../../v1.10d-bash-permission-pattern-audit/audit/A1-anthropic-docs.md) — 인용 1-10 base

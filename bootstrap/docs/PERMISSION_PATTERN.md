# Permission Pattern — frontmatter + Bash() 6축 통합 spec

`sessions/meta/v1.10d-bash-permission-pattern-audit/` (5축 확정) + `sessions/meta/v1.10g-skill-thinking-effort/` (A6 신설). 본 repo의 모든 SKILL/command frontmatter + 사용자 settings.json 마이그레이션의 단일 소스.

## 1. 결정 (Decision — 6축 통합)

본 repo의 frontmatter `allowed-tools:` + `model:` + `effort:` + settings.json `permissions.allow` 작성 시 **6축 통합** 정책 채택:

| 축 | 결정 | 근거 (인용 # — `sessions/meta/v1.10d-.../audit/A1-anthropic-docs.md` + `v1.10g-.../audit/A1-A2.md`) |
|----|------|----------|
| **A1 필드명** | slash command/skill = `allowed-tools:` / subagent = `tools:` | v1.10d 7-8, 10 |
| **A2 separator** | YAML list (권장) / 공백 inline (대안) / 콤마 (비권장) | v1.10d 7 |
| **A3 패턴 형식** | `Bash(cmd *)` 공백 (dialog 표준) — `Bash(cmd:*)` 콜론은 alias | v1.10d 1, 2 |
| **A4 redundant** | auto-allow set declare 금지 | v1.10d 3 |
| **A5 argument fine-grain** | Conservative — argument 제약 미시도 | v1.10d 4 |
| **A6 model+effort** | 책임 기반 model 선택 (디스패처/실행=sonnet / 논의/설계/검증=opus) + opus skill은 `effort: xhigh` 명시 / sonnet skill은 declare 무 (default `high`). `thinking:` 필드 사용 금지 (spec 부재 → silent ignore) | v1.10g 19', 20, 21, 22, 24 |

## 2. 필드명 매트릭스 (A1)

| 파일 위치 | 공식 필드 | 비고 |
|-----------|----------|------|
| `.claude/commands/*.md` (slash command) | **`allowed-tools:`** | skills와 동일 frontmatter (인용 8) |
| `.claude/skills/*/SKILL.md` (skill) | **`allowed-tools:`** | 인용 7 |
| `.claude/agents/*.md` (subagent) | **`tools:`** | 별도 schema (인용 10) |

⚠️ **흔한 오류**: slash command에서 `tools:` 사용 — subagent 전용 필드를 잘못 사용. silent ignore 또는 lenient 파서 의존 (spec 미보장).

## 3. Separator (A2)

skills docs verbatim (인용 7):
> "Accepts a **space-separated string or a YAML list**."

→ 콤마 separator는 **공식 spec 미명시**. 단일 문자열로 파싱돼 declare 전체 무효 가능.

### 권장: YAML list

```yaml
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(mkdir *)
  - Bash(git *)
```

장점: separator 모호성 0 / 가독성 ✓ / 확장성 ✓ / spec verbatim 정합

### 대안: 공백 inline

```yaml
allowed-tools: Read Glob Grep Bash(mkdir *) Bash(git *)
```

장점: 짧음. 단점: long line 가독성 ✗

### 비권장: 콤마 inline

```yaml
allowed-tools: Read, Glob, Grep, Bash(mkdir *), Bash(git *)
```

⚠️ skills docs 미명시 — 작동 보장 없음. context7 plugin-dev 예시는 콤마 사용하지만 conflict.

## 4. 패턴 형식 매트릭스 (A3)

permissions docs verbatim (인용 1):
> "The space before `*` matters: `Bash(ls *)` matches `ls -la` but not `lsof`, while `Bash(ls*)` matches both. The `:*` suffix is an equivalent way to write a trailing wildcard, so `Bash(ls:*)` matches the same commands as `Bash(ls *)`."

| 형식 | word-boundary | 의미 | 채택 |
|------|:-------------:|------|:----:|
| `Bash(cmd *)` (공백 + `*`) | ✅ | `ls -la` 매치, `lsof` 미매치 | **본 repo 채택** (dialog 표준) |
| `Bash(cmd:*)` (콜론 + `*`) | ✅ | `Bash(cmd *)`와 equivalent | alias (trailing only) |
| `Bash(cmd*)` (no space) | ❌ | `ls`, `lsof`, `lsblk` 모두 매치 | **사용 금지** (의도 외 매치) |
| `Bash(* args)` | suffix-match | `npm install`, `pnpm install` 등 | 특수 |
| `Bash(cmd * args)` | 중간 wildcard | `git checkout main`, `git log main` 등 | sub-command + arg |
| `Bash(cmd)` (no `*`) | exact | 정확 명령만 | exact match 필요 시 |
| `Bash` (no parens) | wildcard | `Bash(*)`와 동등, 모든 Bash 매치 | broad |

⚠️ 콜론 형식 trailing-only 제약 (인용 2):
- ✅ `Bash(git:*)` (trailing)
- ✅ `Bash(git push:*)` (sub-command + trailing)
- ❌ `Bash(git:* push)` (중간) — 콜론이 리터럴로 처리

## 5. 자동 허용 set (A4 — declare 금지 list)

permissions docs verbatim (인용 3):
> "Claude Code recognizes a built-in set of Bash commands as **read-only and runs them without a permission prompt in every mode**. These include `ls`, `cat`, `head`, `tail`, `grep`, `find`, `wc`, `diff`, `stat`, `du`, `cd`, and **read-only forms of `git`**. The set is not configurable."

### Declare 금지 명령 (12)

| 명령 | 비고 |
|------|------|
| `ls` | unquoted glob 허용 (`ls *.ts`) |
| `cat` | |
| `head` | |
| `tail` | |
| `grep` | |
| `find` | unquoted glob 시 prompt (write-capable flags 가능) |
| `wc` | |
| `diff` | |
| `stat` | |
| `du` | |
| `cd` | working directory 또는 additional dir |
| `git` (read-only forms) | `status`/`log`/`diff`/`show`/`branch`/`ls-files`/`rev-parse`/`worktree list` 등 — write forms (add/commit/push)는 prompt |

→ frontmatter `allowed-tools:`나 settings.json `permissions.allow`에 declare 시 **효과 0** (이미 자동 허용). misleading한 declare 제거 권장.

### `allowed-tools` semantics 정확화 (인용 9)

> "The `allowed-tools` field grants permission for the listed tools while the skill is active... It does not restrict which tools are available."

→ `allowed-tools`는 **pre-approval 목록**. 차단이 아님. declare 제거 = 차단 아님 = baseline 폴백 (자동 허용 또는 prompt). tool 차단은 settings.json `deny` rule.

## 6. Fragile pattern 금지 (A5)

permissions docs verbatim Warning (인용 4):
> "Bash permission patterns that try to constrain command arguments are **fragile**."

### 금지 사례

```
Bash(rm -rf *)        # 우회: rm -fr, rm  -rf (공백 2), 변수 expansion
Bash(curl http://github.com/ *)   # 우회: -L redirect, $URL 변수, 다른 protocol
Bash(git push --force *)           # 우회: --force-with-lease, -f, --force-with-lease=
```

### 신뢰성 있는 대안

1. **Deny rule**: `permissions.deny: ["Bash(curl *)"]` + WebFetch 분리 (`WebFetch(domain:github.com)`)
2. **PreToolUse hook**: shell command가 동적 검증 후 approve/deny — 별도 인프라
3. **CLAUDE.md 지시**: AI에 "특정 패턴만 허용" 안내 (best-effort)

본 repo 정책: **(1) Conservative — argument fine-grain 미시도** (R3'). destructive 명령 (`rm`, `git push`) prefix-match로 declare하되 prompt 의존.

## 7. Compound + Wrapper (인용 5, 6)

### Compound 명령 분해 (인용 6)

separator: `&&`, `||`, `;`, `|`, `|&`, `&`, newlines.

각 subcommand 독립 매치 필요:
```bash
git status && npm test    # Bash(git status:*) AND Bash(npm test:*) 둘 다 매치 필요
```

### Process wrapper 자동 strip (인용 5)

자동 strip: `timeout`, `time`, `nice`, `nohup`, `stdbuf`, bare `xargs` (no flags).

```yaml
# Bash(npm test *)는 다음 모두 매치:
allowed-tools:
  - Bash(npm test *)
# → npm test, timeout 30 npm test, nohup npm test ✓
```

미strip wrapper (별도 declare 필요): `direnv exec`, `devbox run`, `mise exec`, `npx`, `docker exec`.

```yaml
# devbox run을 통한 npm test 허용:
allowed-tools:
  - Bash(devbox run npm test)   # exact
```

## 8. harness-meta 정책 (Conservative R3' + A6 model+effort)

본 repo 12 파일 (1 slash command + 6 SKILL + 4 agent + 1 output-style) frontmatter 정책. v1.10d β 4 + v1.10f 7 + v1.10g 4 (R1+R2 model+effort) 통합 완료. output-style 1 파일은 frontmatter `tools:` 무관.

### model+effort 매트릭스 (A6 — v1.10g 신설)

| 파일 | model | effort | 책임 |
|------|------|------|------|
| `claude/commands/harness-meta.md` | `sonnet` | (declare 무, default `high`) | 세션 진입점 + 라우팅 (R1) |
| `bootstrap/templates/_base/.claude/skills/harness/SKILL.md` | `sonnet` | (declare 무, default `high`) | 디스패처 |
| `bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md` | `sonnet` | (declare 무, default `high`) | 8~9단계 실행 |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | `opus` | `xhigh` | 1~4단계 + 사용자 논의 (R2) |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | `opus` | `xhigh` | 5~7단계 + 7-Dim 검증 (R2) |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md` | `opus` | `xhigh` | 10단계 + Goal-backward (R2) |
| `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md` | (미명시 — session inherit) | (미명시) | review (read-only) |

⚠️ `thinking:` 필드 사용 **금지** — Claude Code 공식 frontmatter spec 부재 (v1.10g audit/A1 인용 19'). silent ignore되어 의도 손실 발생.

```yaml
# claude/commands/harness-meta.md (v1.10g R1)
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write
  - Edit
  - Bash(mkdir *)
  - Bash(git *)         # write forms 포함 (add/commit/push) — prompt 정책 의존
  - Bash(bash *)
  - Bash(pwsh *)
  - Bash(sed *)         # write-capable -i flag
  - Bash(uname *)
  - Bash(mv *)
  - Bash(cp *)
  - Bash(rm *)          # destructive — argument fine-grain 미시도 (fragile)
model: sonnet           # v1.10g R1 — 라우팅 책임 (opus 강등)
# effort 미명시 — Sonnet 4.6 default `high` inherit
```

```yaml
# bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md (v1.10g R2)
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write(phases/**)
  - Edit(phases/**)
  # Bash 없음 — ls 자동 허용
model: opus
effort: xhigh           # v1.10g R2 — Opus 4.7 default 정합 + drift 방지
```

```yaml
# harness-plan/SKILL.md (v1.10g R2)
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write(phases/**/PLAN.md)
  - Edit(phases/**/PLAN.md)
  - Bash(mkdir *)
  # ls/wc 자동 허용
model: opus
effort: xhigh           # v1.10g R2 — 동상
```

```yaml
# harness-review/SKILL.md
allowed-tools:
  - Read
  - Glob
  - Grep
  # git read-only forms 자동 허용 (review = read-only)
```

### v1.10f scope (7 파일 — 본 5축 정합)

```yaml
# harness/SKILL.md (R2 — Bash declare 제거, 디스패처 본문 사용 0)
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit
  # Bash 없음 — ls/cat/grep 자동 허용으로 충분
```

```yaml
# harness-run/SKILL.md (R3 — broad Bash 유지: {executor} 동적 가변)
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit
  # broad Bash — .harness.toml [harness].executor (Python/Node/Go/Rust 등) 17 PM 가변
```

```yaml
# harness-ship/SKILL.md (v1.10f R3 + R5 + v1.10g R2 — broad Bash + Edit/Write fine-grain 보존 + effort)
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit(phases/**)
  - Write(phases/**)
  # broad Bash — {test_cmd}/{type_check_cmd}/{lint_cmd} 동적 + git WRITE forms
  # Edit/Write fine-grain — phases/** 정적 패턴 (REPORT.md / ROADMAP.md / index.json / milestone.json)
model: opus
effort: xhigh           # v1.10g R2 — 10단계 Goal-backward + commit/push 복잡
```

```yaml
# harness-verifier.md (R4 — agent tools: broad Bash 유지)
tools:
  - Read
  - Glob
  - Grep
  - Bash
  # 본문 Bash 0 but 4-Functional 단계 미래 확장 + isolated context safety
```

```yaml
# harness-dispatcher.md / harness-explore.md / harness-grey-area.md (R6 — tools: 콤마 → YAML list, Bash 무)
tools:
  - Read
  - Glob
  - Grep
  # read-only analytical agents — Bash declare 무
```

## 9. 사용자 settings 마이그레이션 가이드

본 audit는 harness-meta source-of-truth 5 파일만. 사용자 프로젝트 settings.json 마이그레이션은 별도 책임.

### 마이그레이션 패턴

| 현재 형식 | 정정 형식 | 비고 |
|-----------|----------|------|
| `Bash(git status*)` | (제거) | 자동 허용 |
| `Bash(git add*)` | `Bash(git add *)` | 공백 형식 |
| `Bash(git*)` | `Bash(git *)` | write forms 포함 |
| `Bash(rm -rf*)` (deny) | `Bash(rm *)` (ask) + PreToolUse hook | argument fragile |

### upbit 후속 세션

`sessions/upbit/v1.2-bash-permission-update/` (T4 후행) — upbit deployed 6 SKILL + settings.json 36 패턴 5축 통합 정정 + deny 7 fragile pattern 재설계.

### 검증 명령

```bash
# 자동 허용 set declare 잔존 검사
grep -E 'Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)[ :]?\*?\)' .claude/settings.json

# 콜론 없음 패턴 잔존 검사 (word-boundary 부재)
grep -E 'Bash\([a-z][a-z\-]*\*\)' .claude/settings.json

# 콤마 separator 잔존 (frontmatter — single-line)
grep -E '^(allowed-tools|tools):.+,' .claude/skills/*/SKILL.md
```

## 10. Verify 체크리스트

`tests/smoke-bash-permission-pattern.sh` 6 stage (v1.10d) + `tests/smoke-broad-bash-fine-grain.sh` 6 stage (v1.10f) + `tests/smoke-thinking-effort.sh` 5 stage (v1.10g) 자동 검증. 사용자 dynamic 검증은 REPORT 단계.

| # | 체크 | 명령 | 기대 |
|---|------|------|------|
| V1 (A3) | 콜론 없음 패턴 잔존 | `grep -cE 'Bash\([a-z][a-z\-]*\*\)' <files>` | 0 |
| V4 (R5') | PERMISSION_PATTERN.md 존재 + 9 keyword | `grep <keywords> bootstrap/docs/PERMISSION_PATTERN.md` | 9/9 |
| V5 (A4) | auto-allow set declare 잔존 | `grep -cE 'Bash\((ls\|grep\|...)[: ]?\*?\)' <files>` | 0 |
| V7 (A1) | slash command 필드명 | `grep '^allowed-tools:' claude/commands/harness-meta.md` | match |
| V8 (A2) | single-line 콤마 separator 잔존 | `grep -E '^(allowed-tools\|tools):.+,' <files>` | 0 |
| V9 (A2) | YAML list 형식 정합 | `awk` count `^  - ` lines after `^allowed-tools:\s*$` | ≥3 per 파일 |
| **V10 (A6)** | **`thinking:` 필드 잔존 (silent ignore 회피)** | `grep -cE '^thinking:' <files>` | **0** |
| V3 (사용자) | 정정 후 `mkdir foo` prompt 빈도 | `/harness-meta` 진입 후 관찰 | (a)/(b) 시나리오 판별 |

### 후속 세션 v1.21 통합

`sessions/meta/v1.21-cross-platform-install/`에서 verify.ps1에 본 V1+V5+V7+V8+V9+V10 통합 예정.

## 11. 관련 문서

- 상위: `../../CLAUDE.md` · `../../README.md`
- audit evidence: `../../sessions/meta/v1.10d-bash-permission-pattern-audit/audit/{A1-A5}.md` + `../../sessions/meta/v1.10f-broad-bash-fine-grain/audit/{A1-A6}.md` (인용 11-18) + `../../sessions/meta/v1.10g-skill-thinking-effort/audit/{A1-A5}.md` (인용 19'-25 — A6 model+effort)
- 본 5축 확정 세션: `../../sessions/meta/v1.10d-bash-permission-pattern-audit/`
- v1.10f scope (templates 7 파일 정합): `../../sessions/meta/v1.10f-broad-bash-fine-grain/` — R2 Bash 제거 + R3/R4 broad 유지 + R6 3 agent 콤마 정정
- **v1.10g scope (4 파일 + A6 신설)**: `../../sessions/meta/v1.10g-skill-thinking-effort/` — R1 harness-meta sonnet 강등 + R2 3 opus skill `effort: xhigh` + R3 6축 신설 + V10 (`thinking:` silent ignore 차단)
- 외부 reference (1차): [Configure permissions](https://code.claude.com/docs/en/permissions) · [Skills](https://code.claude.com/docs/en/skills) · [Settings](https://code.claude.com/docs/en/settings) · [Model config](https://code.claude.com/docs/en/model-config) · [Common workflows](https://code.claude.com/docs/en/common-workflows)
- 외부 reference (보조 — conflict 사례): context7 `/anthropics/claude-code` plugin-dev frontmatter-reference + agent-development + mcp-integration
- 후속 세션:
  - `sessions/upbit/v1.2-bash-permission-update/` — T4 후행 (upbit 정정 + deny 재설계)

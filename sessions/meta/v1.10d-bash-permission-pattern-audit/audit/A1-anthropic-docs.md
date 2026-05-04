# A1 — Anthropic 공식 docs frontmatter + permission spec (verbatim)

본 문서는 v1.10d audit의 reference base. 모든 추천(R1'-R7')은 본 인용을 근거로 한다.

**출처**:

- 공식 (Anthropic): `https://code.claude.com/docs/en/permissions` (구 `docs.claude.com/en/docs/claude-code/iam`은 301 redirect)
- 공식 (Anthropic) settings: `https://code.claude.com/docs/en/settings`
- 공식 (Anthropic) skills: `https://code.claude.com/docs/en/skills` (slash commands는 skills와 동일 frontmatter)
- 보조 (context7): `/anthropics/claude-code` — `plugins/plugin-dev/skills/command-development/references/frontmatter-reference.md`

조회일자: 2026-04-27.

---

## 인용 1 — 콜론/공백/콜론없음 등가 + word-boundary 차이 (CRITICAL)

> The space before `*` matters: `Bash(ls *)` matches `ls -la` but not `lsof`, while `Bash(ls*)` matches both. **The `:*` suffix is an equivalent way to write a trailing wildcard, so `Bash(ls:*)` matches the same commands as `Bash(ls *)`.**

출처: `code.claude.com/docs/en/permissions` § "Wildcard patterns"

**해석**:

- `Bash(cmd*)` (콜론 없음, 공백 없음) — word-boundary 없음 prefix
- `Bash(cmd *)` (공백 + `*`) — word-boundary 있음 prefix (**dialog 표준 표기**)
- `Bash(cmd:*)` (콜론 + `*`) — `Bash(cmd *)`와 **equivalent** (= word-boundary 있음 prefix)

세 형식 **모두 공식 유효**. word-boundary 동작이 다름.

---

## 인용 2 — `:*` trailing-only 제약

> The permission dialog writes the space-separated form when you select "Yes, don't ask again" for a command prefix. **The `:*` form is only recognized at the end of a pattern.** In a pattern like `Bash(git:* push)`, the colon is treated as a literal character and won't match git commands.

출처: 동일 페이지

**해석**:

- 콜론 형식은 **trailing position만 유효**
- permission dialog의 자동 저장 형식은 **공백 표기**
- 즉 **공식 dominant 표기 = 공백 형식** (`Bash(cmd *)`). 콜론은 alias

---

## 인용 3 — Read-only 자동 허용 set (CRITICAL — declare 무효화)

> Claude Code recognizes a built-in set of Bash commands as read-only and **runs them without a permission prompt in every mode**. These include `ls`, `cat`, `head`, `tail`, `grep`, `find`, `wc`, `diff`, `stat`, `du`, `cd`, and **read-only forms of `git`**. The set is not configurable; to require a prompt for one of these commands, add an `ask` or `deny` rule for it.
>
> Unquoted glob patterns are permitted for commands whose every flag is read-only, so `ls *.ts` and `wc -l src/*.py` run without a prompt. Commands with write-capable or exec-capable flags, such as `find`, `sort`, `sed`, and `git`, still prompt when an unquoted glob is present because the glob could expand to a flag like `-delete`.

출처: 동일 페이지 § "Read-only commands"

**해석**: declare 자체가 redundant (효과 0). 본 repo의 `Bash(ls*)`, `Bash(grep*)`, `Bash(wc*)`, `Bash(cat*)` declare 5건 모두 redundant.

---

## 인용 4 — Argument 제약 fragile warning

> ⚠️ Bash permission patterns that try to constrain command arguments are **fragile**. For example, `Bash(curl http://github.com/ *)` intends to restrict curl to GitHub URLs, but won't match variations like:
>
> - Options before URL: `curl -X GET http://github.com/...`
> - Different protocol: `curl https://github.com/...`
> - Redirects: `curl -L http://bit.ly/xyz` (redirects to github)
> - Variables: `URL=http://github.com && curl $URL`
> - Extra spaces: `curl  http://github.com`
>
> For more reliable URL filtering, consider:
>
> - **Restrict Bash network tools**: use deny rules to block `curl`, `wget`, and similar commands, then use the WebFetch tool with `WebFetch(domain:github.com)` permission for allowed domains
> - **Use PreToolUse hooks**: implement a hook that validates URLs in Bash commands and blocks disallowed domains

출처: 동일 페이지 § "Tool-specific permission rules" → "Bash"

**해석**: argument fine-grain 시도 ❌ (R3' Conservative 정책 근거).

---

## 인용 5 — Process wrapper 자동 strip

> Before matching Bash rules, Claude Code strips a fixed set of process wrappers so a rule like `Bash(npm test *)` also matches `timeout 30 npm test`. The recognized wrappers are `timeout`, `time`, `nice`, `nohup`, and `stdbuf`.
>
> Bare `xargs` is also stripped, so `Bash(grep *)` matches `xargs grep pattern`.

출처: 동일 페이지 § "Process wrappers"

---

## 인용 6 — Compound command 분해

> Claude Code is aware of shell operators, so a rule like `Bash(safe-cmd *)` won't give it permission to run the command `safe-cmd && other-cmd`. The recognized command separators are `&&`, `||`, `;`, `|`, `|&`, `&`, and newlines. **A rule must match each subcommand independently.**

출처: 동일 페이지 § "Compound commands"

---

## 인용 7 — Skills frontmatter spec (CRITICAL — 필드명 + separator)

skills docs frontmatter table verbatim:

> | `allowed-tools` | No | **Tools Claude can use without asking permission when this skill is active.** Accepts a **space-separated string or a YAML list**. |

출처: `code.claude.com/docs/en/skills` § "Frontmatter reference"

**해석**:

- **공식 필드명 = `allowed-tools:`** (NOT `tools:` — `tools:`는 subagent 전용)
- separator: **공백 또는 YAML list** (콤마 미명시)
- 콤마 형식은 **공식 spec 미보장** — lenient 파서일 수 있으나 신뢰 불가

skills docs 예시 (verbatim):

```yaml
---
name: my-skill
description: What this skill does
disable-model-invocation: true
allowed-tools: Read Grep
---
```

```yaml
allowed-tools: Bash(git add *) Bash(git commit *) Bash(git status *)
```

→ **공백 separator** + **공백 형식 패턴** (`Bash(cmd *)`).

---

## 인용 8 — Slash commands는 skills와 동일 frontmatter

skills docs verbatim:
> "Custom commands have been merged into skills. A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and **work the same way**. Your existing `.claude/commands/` files keep working."
>
> "Files in `.claude/commands/` still work and **support the same frontmatter**."

출처: `code.claude.com/docs/en/skills`

**해석**:

- `.claude/commands/*.md`는 skills와 **동일한 frontmatter 스키마** 사용
- 즉 `claude/commands/harness-meta.md`도 **`allowed-tools:`** 필드 (NOT `tools:`)
- 현재 `harness-meta.md:5 tools: ...`는 **slash command spec 위반** (subagent 전용 필드명 사용)

---

## 인용 9 — `allowed-tools` semantics: pre-approval, NOT 제한

skills docs verbatim:
> "The `allowed-tools` field grants permission for the listed tools while the skill is active, so Claude can use them without prompting you for approval. **It does not restrict which tools are available**: every tool remains callable, and your permission settings still govern tools that are not listed."
>
> "To block a skill from using certain tools, add deny rules in your permission settings instead."

출처: 동일 § "Pre-approve tools for a skill"

**해석**:

- `allowed-tools`는 **tool whitelist 아님**. **pre-approval 목록**.
- 명시 안 된 tool도 호출 가능 — baseline permissions에 따라 prompt 발생
- tool **차단**은 settings.json `permissions.deny`로만

→ A3 redundancy 분석 시 "review skill에서 `Bash(git*)` 제거 = git write 차단" 같은 표현 misleading. 정확한 표현: "pre-approval 제거 = git write 호출 시 baseline prompt 발생".

---

## 인용 10 — Subagent frontmatter (다른 schema)

skills docs와 별개 — agents/*.md (subagent) frontmatter 필드:

- `tools:` (subagent 전용)
- `model:`, `description:` 등 공통

출처: `code.claude.com/docs/en/sub-agents` (간접 — skills docs § "Run skills in a subagent" 인용)

**해석**:

- agent 파일 (`agents/harness-dispatcher.md` 등)에서 `tools: Read, Glob, Grep` 사용 = ✓ 정합
- slash command (`commands/harness-meta.md`)에서 `tools:` 사용 = ✗ spec 위반 (skill schema 적용 대상)

---

## 인용 11 — context7 plugin-dev (보조 reference, conflict)

```yaml
allowed-tools: Bash(git:*)
allowed-tools: Bash(npm:*)
allowed-tools: Bash(docker:*)
allowed-tools: Bash(git status:*), Bash(git diff:*)
allowed-tools: Bash(git:*), Read
```

출처: context7 `/anthropics/claude-code` — `plugins/plugin-dev/skills/command-development/references/frontmatter-reference.md`

**해석**:

- plugin-dev sample은 **콜론 형식 + 콤마 separator**
- skills docs와 **conflict** — skills docs는 공백 separator + 공백 형식 dominant
- 가능 해석: (a) plugin-dev docs stale (b) lenient 파서 (c) 둘 다 작동
- 본 audit는 **skills docs canonical** 따름 (공식 product source)

---

## settings docs canonical (settings.json)

```json
"permissions": {
  "allow": [
    "Bash(npm run lint)",
    "Bash(npm run test *)",
    "Read(~/.zshrc)"
  ],
  "deny": [
    "Bash(curl *)",
    "Read(./.env)"
  ]
}
```

출처: `code.claude.com/docs/en/settings`

**해석**: settings.json은 JSON array → separator 모호성 없음. 패턴 형식만 공백 dominant.

---

## 통합 결론 (5축 spec)

| 축 | 위치 | 공식 권장 | 본 repo 현재 | 정합? |
|----|------|----------|-------------|:----:|
| **A1 — 필드명** | slash command frontmatter | `allowed-tools:` | `tools:` (harness-meta.md) | ✗ |
| | skill frontmatter | `allowed-tools:` | `allowed-tools:` (4 SKILL) | ✓ |
| | subagent frontmatter | `tools:` | `tools:` (4 agent) | ✓ |
| **A2 — Separator** | frontmatter | 공백 또는 YAML list | 콤마 (5 파일) | ✗ (보장 미명시) |
| | settings.json | JSON array | (변경 없음) | ✓ |
| **A3 — Pattern format** | 양쪽 | 공백 (dialog 표준) / 콜론 (alias, trailing only) / `cmd*` (word-boundary 없음) | `cmd*` (16 패턴) | △ (유효지만 word-boundary 부재) |
| **A4 — Redundant declare** | 양쪽 | auto-allow set declare 금지 | ls/grep/wc/git read-only declare 6건 | ✗ |
| **A5 — Argument fine-grain** | 양쪽 | fragile, 회피 권장 | 미시도 (Conservative) | ✓ |

**Auto-allow set declare 금지 list**: `ls`, `cat`, `head`, `tail`, `grep`, `find`, `wc`, `diff`, `stat`, `du`, `cd`, `git` (read-only forms — `status`/`log`/`diff`/`show`/`branch`/`ls-files`/`rev-parse` 등).

**fragile pattern 금지**: argument 제약 (`Bash(rm -rf:*)`, `Bash(git push --force:*)`). PreToolUse hook 또는 deny rule + WebFetch 분리 권장.

**v1.10d 정정 5축 통합**: A1 (필드명 `tools:` → `allowed-tools:`) + A2 (콤마 → YAML list) + A3 (cmd*→ cmd*) + A4 (redundant 제거) + A5 (Conservative 유지).

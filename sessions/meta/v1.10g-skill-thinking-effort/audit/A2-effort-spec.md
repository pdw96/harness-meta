# A2 — `effort:` 정식 spec

## 1. 결론

`effort:` 필드는 Claude Code skill + subagent + slash command frontmatter의 **정식 필드**. 5 level (`low` / `medium` / `high` / `xhigh` / `max`). Opus 4.7 / Opus 4.6 / Sonnet 4.6 지원. 미지원 모델은 silent ignore (effort 무관 동작).

## 2. 1차 docs 인용

### 인용 19' — skills frontmatter `effort` (재인용)

**Source**: <https://code.claude.com/docs/en/skills>

> | `effort` | No | [Effort level](/en/model-config#adjust-effort-level) when this skill is active. **Overrides the session effort level**. Default: inherits from session. Options: `low`, `medium`, `high`, `xhigh`, `max`; available levels depend on the model. |

→ 핵심: (a) skill 활성 시만 적용 / (b) 세션 effort override / (c) 미명시 시 session inherit / (d) 5 level

### 인용 20 — model-config 모델별 level + fallback (verbatim)

**Source**: <https://code.claude.com/docs/en/model-config> (Adjust effort level)

> [Effort levels](https://platform.claude.com/docs/en/build-with-claude/effort) control adaptive reasoning, which lets the model decide whether and how much to think on each step based on task complexity. Lower effort is faster and cheaper for straightforward tasks, while higher effort provides deeper reasoning for complex problems.
>
> Effort is supported on Opus 4.7, Opus 4.6, and Sonnet 4.6. The available levels depend on the model:
>
> | Model | Levels |
> | :--- | :--- |
> | Opus 4.7 | `low`, `medium`, `high`, `xhigh`, `max` |
> | Opus 4.6 and Sonnet 4.6 | `low`, `medium`, `high`, `max` |
>
> If you set a level the active model does not support, Claude Code falls back to the highest supported level at or below the one you set. For example, `xhigh` runs as `high` on Opus 4.6.
>
> As of v2.1.117, the default effort is `xhigh` on Opus 4.7 and `high` on Opus 4.6 and Sonnet 4.6.

→ **fallback graceful**: `xhigh` 명시는 Opus 4.6에서도 안전 (자동 `high` 강등).

### 인용 21 — skill+subagent frontmatter (verbatim)

**Source**: <https://code.claude.com/docs/en/model-config> (Set the effort level)

> You can change effort through any of the following:
>
> * **`/effort`**: run `/effort` with no arguments to open an interactive slider, `/effort` followed by a level name to set it directly, or `/effort auto` to reset to the model default
> * **In `/model`**: use left/right arrow keys to adjust the effort slider when selecting a model
> * **`--effort` flag**: pass a level name to set it for a single session when launching Claude Code
> * **Environment variable**: set `CLAUDE_CODE_EFFORT_LEVEL` to a level name or `auto`
> * **Settings**: set `effortLevel` in your settings file
> * **Skill and subagent frontmatter**: set `effort` in a [skill](/en/skills#frontmatter-reference) or [subagent](/en/sub-agents#supported-frontmatter-fields) markdown file to override the effort level when that skill or subagent runs
>
> The environment variable takes precedence over all other methods, then your configured level, then the model default. Frontmatter effort applies when that skill or subagent is active, overriding the session level but not the environment variable.

→ **precedence**: env var > settings > frontmatter > model default. frontmatter는 skill/subagent 활성 동안만 override.

### 인용 22 — default effort + Opus 4.7 special (verbatim)

**Source**: <https://code.claude.com/docs/en/model-config> (Adjust effort level)

> As of v2.1.117, the default effort is `xhigh` on Opus 4.7 and `high` on Opus 4.6 and Sonnet 4.6.
>
> When you first run Opus 4.7, Claude Code applies `xhigh` even if you previously set a different effort level for Opus 4.6 or Sonnet 4.6. Run `/effort` again to choose a different level after switching.
>
> `low`, `medium`, `high`, and `xhigh` persist across sessions. `max` provides the deepest reasoning with no constraint on token spending and applies to the current session only, except when set through the `CLAUDE_CODE_EFFORT_LEVEL` environment variable.

→ Opus 4.7 default `xhigh` + 첫 실행 시 prior preference 무시 → **명시 권장** (default-drift 방지).

### 인용 24 — level별 권장 사용 (verbatim)

**Source**: <https://code.claude.com/docs/en/model-config> (Choose an effort level)

> | Level | When to use it |
> | :--- | :--- |
> | `low` | Reserve for short, scoped, latency-sensitive tasks that are not intelligence-sensitive |
> | `medium` | Reduces token usage for cost-sensitive work that can trade off some intelligence |
> | `high` | Balances token usage and intelligence. Use as a minimum for intelligence-sensitive work, or to reduce token spend relative to `xhigh` |
> | `xhigh` | Best results for most coding and agentic tasks. Recommended default on Opus 4.7 |
> | `max` | Can improve performance on demanding tasks but may show diminishing returns and is prone to overthinking. Test before adopting broadly |
>
> The effort scale is calibrated per model, so the same level name does not represent the same underlying value across models.

→ `xhigh` = "Best results for most coding and agentic tasks" (Opus 4.7 권장). `max`는 overthinking risk → 본 세션 채택 안 함.

### 인용 25 — Slash command + Skill 동일 frontmatter (v1.10f 인용 8 재인용)

**Source**: <https://code.claude.com/docs/en/skills> (Note 박스)

> <Note>
>   For built-in commands like `/help` and `/compact`, and bundled skills like `/debug` and `/simplify`, see the [commands reference](/en/commands).
>
> **Custom commands have been merged into skills.** A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and work the same way. Your existing `.claude/commands/` files keep working. Skills add optional features: a directory for supporting files, frontmatter to control whether you or Claude invokes them, and the ability for Claude to load them automatically when relevant.
> </Note>

→ slash command (`.claude/commands/*.md`)도 skill과 **동일 frontmatter** 적용. `effort:` 필드도 동일 작동.

## 3. 모델별 level 매트릭스

| Level | Opus 4.7 | Opus 4.6 | Sonnet 4.6 | Opus 4.5 이전 | Haiku 4.5 |
|------|:---:|:---:|:---:|:---:|:---:|
| `low` | ✓ | ✓ | ✓ | (effort 미지원, silent ignore) | (동상) |
| `medium` | ✓ | ✓ | ✓ | — | — |
| `high` | ✓ (명시) | ✓ (default) | ✓ (default) | — | — |
| `xhigh` | ✓ (default) | → `high` (graceful) | → `high` (graceful) | — | — |
| `max` | ✓ | ✓ | ✓ | — | — |

**핵심 관찰**:
* **`xhigh` = Opus 4.7 default** (인용 22)
* **`xhigh` 명시는 모든 effort-지원 모델에서 안전** (Opus 4.6/Sonnet 4.6에서 graceful fallback to `high`)
* effort 미지원 모델 (Opus 4.5/Sonnet 4.5/Haiku)에선 frontmatter 자체 무시 → 무영향

## 4. precedence 매트릭스 (인용 21)

```
1. CLAUDE_CODE_EFFORT_LEVEL env var       (highest)
2. /effort 또는 settings.effortLevel
3. Skill/subagent frontmatter `effort:`
4. Model default (Opus 4.7=xhigh, 4.6/Sonnet 4.6=high)   (lowest)
```

→ frontmatter는 사용자 settings에 의해 override 가능. `xhigh` 명시도 `/effort low` 호출 시 `low` 우선. **frontmatter는 skill 활성 동안만 일시 override** (인용 19' "Overrides the session effort level").

## 5. `xhigh` 채택 정당화

본 v1.10g R2에서 3 opus skill에 `effort: xhigh` 명시 채택. 근거 정합:

| 정당화 | 인용 | 핵심 |
|------|:---:|------|
| Opus 4.7 default와 일치 | 22 | "default effort is `xhigh` on Opus 4.7" — 명시 = default와 동일 효과 + drift 방지 |
| 권장 사용처 정합 | 24 | "Best results for most coding and agentic tasks" — harness-design (7-Dim 검증), harness-plan (탐색/논의), harness-ship (Goal-backward) 모두 agentic |
| Opus 4.6 graceful | 20 | "xhigh runs as high on Opus 4.6" — 명시는 모델 변경에 안전 |
| 기존 의도 (`thinking: high`) 보존 | A1 §6 | 우연 일치 → spec 정합한 명시 = 의도 강화 + 명시성 회복 |
| Default-drift 방지 | 22 | Anthropic이 default를 `xhigh` → `high` 강등하면 본 4 파일이 기존 효과 유지 |

**대안 비교**:
* `effort: high`: Opus 4.6/Sonnet 4.6 default와 동일. Opus 4.7에선 default(`xhigh`)보다 약함. **3 opus skill 의도 약화** ✗
* `effort: max`: overthinking risk + max는 session-only persist 안 함 (인용 22). 본 세션 채택 안 함 ✗
* declare 무: session inherit. Opus 4.7=`xhigh` / 4.6=`high` 우연 정합. drift risk + 명시성 ✗

→ **`effort: xhigh`** = 단일 채택. 3 opus skill 일괄.

## 6. `harness-meta.md` (sonnet 강등 시) effort 처리

R1: `model: opus` → `sonnet` 강등 후 effort 처리 옵션:

| 옵션 | 결과 (Sonnet 4.6 default = `high`) | 평가 |
|------|------|------|
| (a) **declare 무** (default `high` inherit) | high 작동 | ✓ — 라우팅 + bootstrap 분기에 충분 + 비용 최적 (sonnet 자체 + default effort) |
| (b) `effort: xhigh` 명시 | graceful → `high` (Sonnet 4.6 미지원) | 명시 redundant. xhigh 의도 미달성 |
| (c) `effort: high` 명시 | high (default와 동일) | redundant 명시 |
| (d) `effort: medium` 강등 | medium | 라우팅엔 충분 but 의도 명시 부족 (G1 후속) |

→ **(a) declare 무** 채택. v1.10f A6 §1의 `harness/SKILL.md` (디스패처, sonnet, effort declare 무) 선례 정합.

## 7. 검증 방법

frontmatter `effort:` 적용 검증 옵션:

1. `/effort` 명령 실행 — 현 세션 effort 확인. skill 활성 시 변동 관찰
2. `/status` — 현 model + effort 표시
3. spinner 옆 텍스트 — "with low effort" 등 (인용 22 setting effort level §)

본 세션 smoke (Stage C)는 frontmatter 텍스트 정합만 검증 (정적). 동적 effort 적용 검증은 사용자 dynamic test (REPORT 단계).

## 8. 결론 요약

* `effort:` = skill/subagent/slash command frontmatter 정식 필드 (인용 19', 21, 25)
* 5 level: `low` / `medium` / `high` / `xhigh` / `max` — `xhigh`는 Opus 4.7 only, fallback graceful (인용 20)
* Opus 4.7 default `xhigh` (인용 22) — 명시 = default-drift 방지
* 본 R2 채택: **3 opus skill 모두 `effort: xhigh`** — 의도 보존 + 명시성 + 모델 이식성 + 비용 무영향 (default와 동일)
* R1 채택: **harness-meta.md effort declare 무 + model: sonnet** — 라우팅 책임에 정합 (Sonnet 4.6 default `high` inherit)

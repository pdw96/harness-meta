# A1 — `thinking:` 필드 spec 검증

## 1. 결론

**`thinking:` frontmatter 필드는 Claude Code 공식 spec에 부재**. 4 파일의 `thinking: high`는 **silent ignore** (YAML parser leniency — 알 수 없는 필드 무시).

## 2. 1차 docs fetch (인용 19', 22, 23)

### 인용 19' — skills SKILL.md frontmatter 17 필드 전체 (verbatim)

**Source**: <https://code.claude.com/docs/en/skills> (2026-04-28 fetch)

> ### Frontmatter reference
>
> Beyond the markdown content, you can configure skill behavior using YAML frontmatter fields between `---` markers at the top of your `SKILL.md` file:
>
> | Field | Required | Description |
> | :--- | :--- | :--- |
> | `name` | No | Display name for the skill. |
> | `description` | Recommended | What the skill does and when to use it. |
> | `when_to_use` | No | Additional context for when Claude should invoke the skill. |
> | `argument-hint` | No | Hint shown during autocomplete. |
> | `arguments` | No | Named positional arguments for `$name` substitution. |
> | `disable-model-invocation` | No | Set to `true` to prevent Claude from automatically loading. |
> | `user-invocable` | No | Set to `false` to hide from `/` menu. |
> | `allowed-tools` | No | Tools Claude can use without asking permission. |
> | `model` | No | Model to use when this skill is active. |
> | `effort` | No | [Effort level](/en/model-config#adjust-effort-level) when this skill is active. Overrides the session effort level. Default: inherits from session. Options: `low`, `medium`, `high`, `xhigh`, `max`; available levels depend on the model. |
> | `context` | No | Set to `fork` to run in a forked subagent context. |
> | `agent` | No | Which subagent type to use when `context: fork` is set. |
> | `hooks` | No | Hooks scoped to this skill's lifecycle. |
> | `paths` | No | Glob patterns that limit when this skill is activated. |
> | `shell` | No | Shell to use for `` !`command` `` and ` ```! ` blocks. |

→ **17 필드 중 `thinking:` 부재**. `effort:` 정식 필드 (인덱스 10).

### 인용 22 — extended thinking 활성화 방법 2가지 (verbatim)

**Source**: <https://code.claude.com/docs/en/common-workflows> (Use extended thinking 섹션)

> ### Configure thinking mode
>
> | Scope | How to configure | Details |
> | --- | --- | --- |
> | **Effort level** | Run `/effort`, adjust in `/model`, or set `CLAUDE_CODE_EFFORT_LEVEL` | Control thinking depth on supported models |
> | **`ultrathink` keyword** | Include "ultrathink" anywhere in your prompt | Adds an in-context instruction telling the model to reason more on that turn. Does not change the effort level itself; see Adjust effort level for that |
> | **Toggle shortcut** | Press `Option+T` (macOS) or `Alt+T` (Windows/Linux) | Toggle thinking on/off for the current session |
> | **Global default** | Use `/config` to toggle thinking mode | Sets your default across all projects |
> | **Limit token budget** | Set `MAX_THINKING_TOKENS` environment variable | Limit the thinking budget |

→ frontmatter 활성화 = `effort:` (인용 19') 만. `thinking:` 필드 또는 keyword 부재.

### 인용 23 — "think hard" 등 prompt 표현 무효 (verbatim)

**Source**: <https://code.claude.com/docs/en/common-workflows> (Use extended thinking 노트)

> <Note>
>   Phrases like "think", "think hard", and "think more" are interpreted as regular prompt instructions and don't allocate thinking tokens.
> </Note>

→ frontmatter `thinking: high` 도 동일 — 정식 매핑 없음, regular YAML key로 처리되어 silent ignore.

## 3. 추정 반증 (v1.10d audit/A4 + v1.10f A6 §6.1)

### v1.10d 추정 (line 108)

> "v1.10g-skill-frontmatter-thinking-effort | S1b | 발견 12 — `harness-meta.md`의 `thinking: high`가 deprecated `effort:` alias인지 검증 + 필요 시 정정"

→ **추정**: `thinking:` ≡ `effort:` 의 deprecated alias.

### v1.10f A6 §6.1 추정 (line 44-46)

> - context7 docs 검색 결과 `thinking:` 필드 명시 인용 **부재**
> - 추정: `thinking: high` ≡ deprecated `effort:` alias 또는 신규 필드
> - 본 v1.10f scope 외 — 별도 후속 v1.10g (`v1.10g-skill-thinking-effort`) 검증 예정

→ **추정 2건**: (i) deprecated alias / (ii) 신규 필드.

### 본 A1 반증

1차 docs (skills + common-workflows) fetch 결과:

- **alias 가설 반증**: 인용 19'는 `effort:` 단일 필드만 명시. alias나 deprecated 기록 부재
- **신규 필드 가설 반증**: 인용 19' 17 필드 전체에 `thinking:` 부재. 신규 도입 시 frontmatter 표 갱신 필수 (Anthropic docs 정책)

→ **결론**: `thinking:` 필드는 alias도 신규도 아닌 **존재 안 하는 필드**.

## 4. Silent ignore 메커니즘

YAML 1.2 spec: 정의되지 않은 키는 **mapping의 일반 entry**로 파싱 (오류 없음). Claude Code의 frontmatter parser는:

1. YAML loads → dict
2. 알려진 필드 (`name`, `description`, `effort` 등) 추출 + 적용
3. 알 수 없는 필드는 **무시** (lenient parser)

→ `thinking: high`는 dict에 entry로 존재하지만 application 단계에서 미참조 → 무영향.

**Lint risk 0**: parser가 오류를 내지 않음 → 4 파일 모두 작동 보존.
**의도 손실**: "high effort 강제" 의도 → 세션 default 의존 (`xhigh` on Opus 4.7 / `high` on Opus 4.6/Sonnet 4.6) → 우연 정합.

## 5. context7 vs 1차 docs 차이

v1.10f A6는 context7 plugin-dev `frontmatter-reference` 검색 → `thinking:` 인용 부재 (검색 결과 한계).
본 A1은 `code.claude.com` skills doc 직접 fetch → 17 필드 전체 명시 표 확보.

**Lessons**: context7 = 인덱싱 의존 (재현성 높음, but indexing window/depth 제약). 1차 docs = canonical source (fetch 시점 reflective). 추정 발생 시 1차 fetch 우선.

## 6. 4 파일 영향 매트릭스

| 파일 | line | 현재 키 | parser 처리 | 의도 | 우연 일치 여부 |
|------|:---:|---|------|------|:---:|
| `claude/commands/harness-meta.md` | 21 | `thinking: high` | dict entry 생성 → application 단계 무시 | high effort 강제 | ✓ (Opus 4.7 default `xhigh`) |
| `harness-design/SKILL.md` | 12 | `thinking: high` | 동상 | 동상 | ✓ (동상) |
| `harness-plan/SKILL.md` | 14 | `thinking: high` | 동상 | 동상 | ✓ (동상) |
| `harness-ship/SKILL.md` | 13 | `thinking: high` | 동상 | 동상 | ✓ (동상) |

**현재 silent 영향**:

- Opus 4.7 사용자 → 세션 default `xhigh` 적용 → 의도 (`high`) **초과**. 결과 동일하거나 더 강한 reasoning
- Opus 4.6 사용자 → 세션 default `high` 적용 → 의도 정확히 일치 (우연)
- Sonnet 4.6 사용자 → 동상 (`high`)
- Opus 4.5 이전 사용자 → effort 미지원, 무시

→ **현 4 파일 의도가 default와 우연 일치** = lint 회피 + 의도 손실 동시 발생. 정정 = spec 정합 + 명시성 회복.

## 7. 관련 인용 inventory

| 인용 # | 내용 | 출처 |
|:---:|------|------|
| 19' | skills frontmatter 17 필드 + effort 명시 (verbatim) | <https://code.claude.com/docs/en/skills> |
| 22 | extended thinking 활성화 2가지 (effort + ultrathink) | <https://code.claude.com/docs/en/common-workflows> |
| 23 | "think hard" 등 prompt 표현 무효 (verbatim) | 동상 |

## 8. 결론 요약

- `thinking:` frontmatter 필드 = **존재 안 함** (alias도 신규도 아님)
- 4 파일 모두 silent ignore → spec 미준수 + 의도 손실 (default와 우연 일치로 발견 지연)
- 정정 방향: `thinking: high` 라인 4건 모두 제거 → `effort:` (인용 21 정식 필드) 또는 declare 무 (세션 default)
- 본 v1.10g R1+R2 결정: 3 opus skill = `effort: xhigh` (인용 22 Opus 4.7 default 정합) / harness-meta = declare 무 + model 강등 (sonnet)

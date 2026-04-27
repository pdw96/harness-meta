# meta v1.10g-skill-thinking-effort — PLAN

세션 시작: 2026-04-28
직접 선행 세션:
- [`sessions/meta/v1.10d-bash-permission-pattern-audit/`](../v1.10d-bash-permission-pattern-audit/REPORT.md) — 발견 12 (`thinking: high` deprecated effort: alias 검증 필요) → 본 v1.10g로 분리 (audit/A4 line 108)
- [`sessions/meta/v1.10f-broad-bash-fine-grain/`](../v1.10f-broad-bash-fine-grain/REPORT.md) — A6 §6.1 인용 19 결정 (context7 docs `thinking:` 필드 명시 부재). 본 v1.10g가 spec 검증 + 정정 수행

목적: `thinking: high` frontmatter 필드를 사용하는 4 파일을 spec 정합 (`effort: xhigh`)으로 정정 + `claude/commands/harness-meta.md`의 `model: opus` → `sonnet` 강등 (디스패처 책임 → 비용 최적). v1.10d/v1.10f 5축 통합 spec에 **6축 신설** (A6 model+effort 정책).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) `claude/commands/harness-meta.md` + S1b(3) `bootstrap/templates/_base/.claude/skills/{harness-design, harness-plan, harness-ship}/SKILL.md` = **4/4 meta**
- **T1 경로 다수결** — meta scope 4/4. v1.10d audit/A4 (line 108)가 명시적으로 v1.10g를 **S1b**로 분류 (선례)
- **T4 크로스 커팅** — 본 세션은 **선행 (templates baseline)** 만. deployed projects (`<proj>/.claude/skills/`)는 별도 후행 세션

## 배경 — `thinking:` 필드 추정 → spec 미존재 확정

v1.10d/v1.10f audit에서 식별:
- v1.10d audit/A4 line 108: "v1.10g — `harness-meta.md`의 `thinking: high`가 deprecated `effort:` alias인지 검증 + 필요 시 정정"
- v1.10f A6 §6.1 인용 19: context7 plugin-dev docs 검색 결과 `thinking:` 필드 명시 **부재** → 추정만 보유, 보존 (lint/break risk 회피)

본 v1.10g가 1차 docs (`code.claude.com/docs/en/skills` + `model-config` + `common-workflows`) 직접 fetch로 결정적 확정.

### 인용 19' (재확정 — skills doc verbatim)

**Source**: https://code.claude.com/docs/en/skills (Frontmatter reference 표)

> | `effort` | No | [Effort level](/en/model-config#adjust-effort-level) when this skill is active. Overrides the session effort level. Default: inherits from session. Options: `low`, `medium`, `high`, `xhigh`, `max`; available levels depend on the model. |

→ `thinking:` 필드 frontmatter 표 **부재**. `effort:` 정식 필드 확정.

### 인용 20 (model-config — 모델별 level)

**Source**: https://code.claude.com/docs/en/model-config (Adjust effort level)

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

→ `xhigh`는 Opus 4.7 only. Opus 4.6 fallback graceful (`xhigh` → `high`). Opus 4.7 default `xhigh`.

### 인용 21 (skill+subagent frontmatter 명시)

**Source**: https://code.claude.com/docs/en/model-config (Set the effort level)

> * **Skill and subagent frontmatter**: set `effort` in a [skill](/en/skills#frontmatter-reference) or [subagent](/en/sub-agents#supported-frontmatter-fields) markdown file to override the effort level when that skill or subagent runs

→ skill + subagent 양쪽 모두 `effort:` 지원. slash command는 skill과 동일 frontmatter (v1.10f 인용 8).

### 인용 22 (extended thinking 활성화 keyword — 콘텐츠 내)

**Source**: https://code.claude.com/docs/en/common-workflows (Use extended thinking)

> Phrases like "think", "think hard", and "think more" are interpreted as regular prompt instructions and don't allocate thinking tokens.

> | **`ultrathink` keyword** | Include "ultrathink" anywhere in your prompt | Adds an in-context instruction telling the model to reason more on that turn. Does not change the effort level itself; see [Adjust effort level](/en/model-config#adjust-effort-level) for that |

→ Extended thinking 활성화 = (a) `effort:` 필드 (frontmatter, 영구) / (b) `ultrathink` keyword (콘텐츠 내 one-off). `thinking:`/"think hard" 무효.

## 영향 분석 — 4 파일 현 상태

| 파일 | 현재 frontmatter | 실 동작 (현) | 의도 | 정합도 |
|------|------|------|------|:---:|
| `claude/commands/harness-meta.md:20-21` | `model: opus` + `thinking: high` | `thinking:` silent ignore → 세션 default effort (Opus 4.7 = `xhigh`) | 디스패처 라우팅 (opus 과잉) | ✗ |
| `harness-design/SKILL.md:11-12` | `model: opus` + `thinking: high` | 동상 | Phase 설계 + 7-Dimension (opus 정합) | ✗ |
| `harness-plan/SKILL.md:13-14` | `model: opus` + `thinking: high` | 동상 | 1~4단계 탐색/논의 (opus 정합) | ✗ |
| `harness-ship/SKILL.md:12-13` | `model: opus` + `thinking: high` | 동상 | Goal-backward + commit (opus 정합) | ✗ |

**현 손실**:
- 4 파일 모두 spec 미준수 — `thinking:` silent ignore. 우연히 default(`xhigh`/`high`)와 결과 동일하지만 spec 정합 0
- `harness-meta.md`는 디스패처/세션 진입점인데 `model: opus` + 의도된 high effort → **비용 과잉**. session entrypoint는 라우팅 + bootstrap 분기만, opus 추론 깊이 불필요

## 결정 (사용자 확정 Q1=a, Q2=a)

### R1 — `harness-meta.md` model 강등 (S1a, 1 파일)

**현재**: `model: opus` + `thinking: high` (silent ignore)
**정정**: `model: sonnet` + (effort declare 제거 — sonnet default `high` 사용)

근거:
- harness-meta.md는 **세션 진입점 + 라우팅** (대상 결정 / Bootstrap 분기 / 새 세션 디렉토리 생성). 추론 깊이 불필요
- v1.10f A6 §1 표에서 `harness/SKILL.md` (디스패처) = `model: sonnet` 선례 정합
- Sonnet 4.6 default `high` (인용 20) — 라우팅에 충분
- 비용 절감: opus 호출 → sonnet 호출 (3-5x 차이)

### R2 — 3 opus skill `effort` 명시 (S1b, 3 파일)

**현재**: `model: opus` + `thinking: high` (silent ignore)
**정정**: `model: opus` + `effort: xhigh` (Opus 4.7 default 정합 + spec 준수)

대상: `harness-design/SKILL.md`, `harness-plan/SKILL.md`, `harness-ship/SKILL.md`

근거:
- 3 skill 모두 복잡 task — Phase 설계(7-Dim 검증), 사용자 논의/탐색, Goal-backward 검증 + commit
- Opus 4.7 default `xhigh` (인용 22) → 명시 = 의도 강화 + 모델 변경 시 default-drift 방지
- Opus 4.6 fallback `high` (인용 20) → graceful, 회귀 0
- v1.10f A6 §1 표 보존: `model: opus` 유지 (변경 없음)

### R3 — 6축 신설 (PERMISSION_PATTERN.md 확장)

기존 5축 (A1 필드명 / A2 separator / A3 패턴 형식 / A4 redundant / A5 argument fine-grain) → **A6 model+effort** 추가:

| 축 | 결정 | 근거 |
|---|------|------|
| **A6 model+effort** | 책임 기반 model 선택 (디스패처/실행=sonnet, 설계/논의/검증=opus) + opus skill은 `effort: xhigh` 명시 / sonnet skill은 declare 무 (default `high`) | 인용 19, 20, 21, 22 |

PERMISSION_PATTERN.md §11 (Verify 체크리스트)에 V10 추가:
- V10: `thinking:` 필드 잔존 검사 (`grep -E '^thinking:' <files>` → 0)

## 변경 대상 (4 수정 + 9 신규 = 13 파일)

### 수정 (4)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | R1 — `model: opus` → `sonnet` + `thinking: high` 라인 제거 |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | S1b | R2 — `thinking: high` → `effort: xhigh` (model: opus 유지) |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | S1b | R2 — 동상 |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md` | S1b | R2 — 동상 |

### 신규 (9)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-thinking-effort.sh` | S2 | 5 stage smoke (V10 + R1 model + R2 effort + 4 파일 spec 정합) |
| `sessions/meta/v1.10g-skill-thinking-effort/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10g-skill-thinking-effort/REPORT.md` | meta | (Stage F 후 작성) |
| `sessions/meta/v1.10g-skill-thinking-effort/audit/A1-thinking-field.md` | meta | `thinking:` 필드 spec 검증 (인용 19' + 추정 반증) |
| `sessions/meta/v1.10g-skill-thinking-effort/audit/A2-effort-spec.md` | meta | `effort:` 정식 spec (인용 19', 20, 21, 22 + 모델별 level 매트릭스 + fallback graceful) |
| `sessions/meta/v1.10g-skill-thinking-effort/audit/A3-model-responsibility.md` | meta | 6 파일 책임 분석 + model 적정성 (디스패처 vs 설계 vs 검증) + 비용 매트릭스 |
| `sessions/meta/v1.10g-skill-thinking-effort/audit/A4-policy-decisions.md` | meta | R1/R2/R3 결정 5요소 구조 + Grey 2건 + scope 매트릭스 (포함 4 + 제외 2) |
| `sessions/meta/v1.10g-skill-thinking-effort/audit/A5-regression-risk.md` | meta | 3 시나리오 회귀 (model 강등 / effort 명시 / cross-model fallback) + smoke 5 stage 정당화 |
| `sessions/meta/v1.10g-skill-thinking-effort/evidence/smoke-thinking-effort.txt` | meta | smoke 실행 결과 |

## 목표

- [x] 세션 디렉토리 생성 (`sessions/meta/v1.10g-skill-thinking-effort/{audit,evidence}/`)
- [x] **PLAN.md 초안 작성** (본 파일)
- [ ] **Stage A — audit 5 파일 작성**
  - A1 — `thinking:` 필드 spec 검증 (frontmatter 표 부재 + 추정 반증)
  - A2 — `effort:` 정식 spec (인용 19', 20, 21, 22 + 모델별 level + fallback)
  - A3 — 6 파일 model 책임 분석 (디스패처 sonnet vs 설계/검증 opus)
  - A4 — R1/R2/R3 정책 결정 + Grey + scope
  - A5 — 회귀 분석 (model 강등 / effort 명시 / fallback)
- [ ] **사용자 audit 검토 후 Stage B 진행** ← 진행 대기
- [ ] **Stage B — 4 파일 frontmatter 정정**
  - `harness-meta.md` — model: opus → sonnet + thinking 라인 제거 (R1)
  - `harness-design/SKILL.md` — thinking: high → effort: xhigh (R2)
  - `harness-plan/SKILL.md` — 동상 (R2)
  - `harness-ship/SKILL.md` — 동상 (R2)
- [ ] **Stage C — Smoke**
  - `tests/smoke-thinking-effort.sh` 5 stage:
    - Stage 1 — V10 (A1): 4 파일 `thinking:` 라인 잔존 0
    - Stage 2 — R1 검증: `harness-meta.md` `model: sonnet` 매치 + `effort:` 부재
    - Stage 3 — R2 검증: 3 SKILL `effort: xhigh` 매치 + `thinking:` 부재
    - Stage 4 — model 보존: 3 SKILL `model: opus` 유지
    - Stage 5 — 5축 회귀 (V1+V5+V8+V9): v1.10d/v1.10f 정합 유지 (frontmatter 추가 변경이 separator/auto-allow 영향 없음 확인)
- [ ] **Stage D — 회귀 검증**
  - 기존 `tests/smoke-bash-permission-pattern.sh` PASS (β scope 변경 없음)
  - 기존 `tests/smoke-broad-bash-fine-grain.sh` PASS (v1.10f 7 파일 변경 없음)
- [ ] **Stage E — 문서 정합**
  - `bootstrap/docs/PERMISSION_PATTERN.md` §1 (5축 → 6축 확장) + §8 (정책 표 갱신) + §11 (V10 추가)
  - `CLAUDE.md` 최신 meta 세션 링크 갱신
  - `README.md` 세션 목록 갱신
- [ ] **Stage F — REPORT.md 작성**
- [ ] **사용자 확인 후 단일 커밋 + push**

## Grey Areas — audit/A4에서 확정 예정

| ID | 질문 | 후보 |
|----|------|------|
| **G1** | `harness-meta.md`에 `effort:` 명시 추가? | (a) **declare 무** (sonnet default `high` 사용) ✓ / (b) `effort: high` 명시 (이식성 ↑ but 라우팅에 과잉) |
| **G2** | 3 opus skill을 `effort: high` 통일? `xhigh` 차등? | (a) **모두 `xhigh`** (Opus 4.7 default 정합) ✓ / (b) ship만 xhigh, plan/design은 high (책임 차등 — 미세 튜닝, evidence 부족) |

## 성공 기준

- [ ] audit/A1-A5 5 파일 작성
- [ ] 4 파일 frontmatter 정정 (R1+R2)
- [ ] `tests/smoke-thinking-effort.sh` 5/5 PASS
- [ ] 기존 `tests/smoke-bash-permission-pattern.sh` 6/6 회귀 PASS
- [ ] 기존 `tests/smoke-broad-bash-fine-grain.sh` 6/6 회귀 PASS
- [ ] `evidence/smoke-thinking-effort.txt` 저장
- [ ] `bootstrap/docs/PERMISSION_PATTERN.md` 6축 확장 + V10 추가
- [ ] `CLAUDE.md` / `README.md` 정합 갱신
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 4 파일 frontmatter / smoke / PERMISSION_PATTERN.md 정합 깨짐.

```
feat(meta): sessions/meta/v1.10g-skill-thinking-effort — thinking: 제거 + effort: spec 정합 (4 파일 + 6축 신설)

- update: claude/commands/harness-meta.md (R1 — model: opus → sonnet + thinking: 제거)
- update: bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md (R2 — thinking: high → effort: xhigh)
- update: bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md (R2 — 동상)
- update: bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md (R2 — 동상)
- add: tests/smoke-thinking-effort.sh (5 stage)
- update: bootstrap/docs/PERMISSION_PATTERN.md (6축 신설 — A6 model+effort + V10)
- add: sessions/meta/v1.10g-skill-thinking-effort/{PLAN,REPORT,audit/A1-A5,evidence/1 파일}

v1.10d 발견 12 + v1.10f A6 §6.1 인용 19 후속 — context7 추정 반증 (1차 docs 직접 fetch):
- thinking: 필드 frontmatter spec 부재 (인용 19' verbatim) → 4 파일 silent ignore
- effort: 정식 필드 (Options: low/medium/high/xhigh/max — 인용 19', 20)
- xhigh = Opus 4.7 default (인용 22) + Opus 4.6 graceful fallback (인용 20)
- harness-meta.md model 강등 (opus → sonnet) — 디스패처 책임에 정합 (v1.10f A6 §1 harness/SKILL.md 선례)

templates baseline + 글로벌 commands 4 파일 6축 통합 완성 (5 + 1 = 6).

Smoke 5/5 + 회귀 v1.10d 6/6 + v1.10f 6/6 PASS.
```

## 후속 세션 연결

### 직접 연계 (각자 책임 — 본 v1.10g scope 외)

- **deployed projects** — 각 프로젝트 자기 `<proj>/.claude/skills/` 동일 정정 (S6, T4 후행)
- **sessions/upbit/v1.2-bash-permission-update** — T4 후행에 thinking→effort 정정 추가 (단일 세션 묶음 가능)

### Lessons Forward (예상)

1. **추정 → 1차 docs fetch로 결정적 확정** — v1.10f가 context7 docs 검색만으로 "추정" 보존했으나, 본 v1.10g가 `code.claude.com` 직접 fetch로 즉답 확정. 추정 보유 비용 (lint/break risk 회피) > 1차 fetch 비용
2. **silent ignore 필드 위험성** — `thinking:` 같이 모르는 필드는 silent ignore (parser leniency). 결과 우연 일치하면 발견 지연. 정기 spec audit 필요
3. **model+effort 한 쌍** — 둘은 분리 가능하나 책임/비용 결정 시 동시 평가가 합리적. PERMISSION_PATTERN.md A6에 묶어 단일 정책으로 명문화
4. **fallback graceful 활용** — `xhigh` 명시는 Opus 4.7 외 모델에서도 안전 (graceful → `high`). 모델 진화 대응 + default-drift 방지

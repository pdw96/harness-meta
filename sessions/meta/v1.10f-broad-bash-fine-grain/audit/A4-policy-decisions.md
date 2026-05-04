# A4 — 정책 결정 R1-R5 + Grey 3건 + scope 매트릭스

본 audit는 v1.10f의 정책 결정을 형식화한다. 각 결정은 **결정 / 근거 / Anthropic 인용 / 회귀 영향 / 적용 패턴**의 5요소 구조.

## 1. R1 — 처리 대상: 7 파일 (Q1=B + Q4=a 사용자 확정)

**결정**: 본 v1.10f scope = `bootstrap/templates/_base/.claude/` 하위 7 파일.

- 3 SKILL: `harness/SKILL.md`, `harness-run/SKILL.md`, `harness-ship/SKILL.md`
- 4 agent: `harness-verifier.md`, `harness-dispatcher.md`, `harness-explore.md`, `harness-grey-area.md`

⚠️ **Q4=a 확장** — 초안 4 파일에서 7 파일로 확장. A6 §2 추가 발견 (3 agent 콤마 위반) 통합. v1.10d Layer 1B "별건" 결정의 재평가 — A2 인용 11 (subagent `tools:` array spec) 확보로 해소.

**근거**:

- v1.10d audit/A2-pattern-inventory에서 **발견 6 + harness-verifier 동상** 식별 완료
- v1.10d β scope (4 파일 — `harness-design`/`harness-plan`/`harness-review` SKILL + `harness-meta.md` slash command) 처리 후 templates baseline의 **나머지 4 파일** 단일 처리
- 3 SKILL + 1 agent 분리 안 함 → frontmatter 정합 일관성 + 단일 커밋 효율
- v1.10d audit/A4 (`audit/A4-policy-decisions.md:107`)가 명시적으로 v1.10f scope 정의 (선례)

**Anthropic 인용**: A2 인용 11 (subagent `tools:` array) — agent 동상 처리 정합

**회귀 영향**: 0 (v1.10d β scope 4 파일 무변경)

**적용 패턴**: S1b (메타 소유 templates) 단일 scope 세션. T1 경로 다수결.

---

## 2. R2 — `harness/SKILL.md`: Bash declare 제거 (Q2=A)

**결정**: `allowed-tools: Read, Glob, Grep, Bash, Edit` (5 entries) → YAML list 4 entries (Bash 제거)

```yaml
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit
```

**근거**:

- A1 §1 evidence: 본문 Bash 호출 0건 (디스패처 라우팅 — Read/Grep/Glob만)
- 자동 허용 set (`ls`/`cat`/`head`/`tail`/`grep` 등 12 명령 + git read-only)으로 디스패처 동작 충분
- declare 제거 = 차단 아님 (A2 인용 9: "It does not restrict which tools are available") — baseline 폴백 (자동 허용 또는 prompt). **safety default**: 미래 코드 변경 시 우연한 Bash 호출 발생하면 prompt → 의도된 안전장치
- A2 인용 12 (Anthropic best practice): "as restrictive as possible, granting only the absolutely necessary permissions"
- A2 인용 13 (read-only 패턴): `Read, Grep` 만 declare → harness/는 read-only 분류 적합

**Anthropic 인용**: A2 인용 12, 13 + A1 §1 본문 evidence

**회귀 영향**: 사용자 환경에 따라 분기:

- (a) 디스패처가 `ls`/`cat`/`grep` 자동 허용 명령만 호출 → 회귀 0
- (b) 우연히 자동 허용 외 명령 호출 → prompt 발생 (의도된 안전장치)
- (c) 미래 디스패처 코드 변경 시 Bash 의존성 추가 → 명시적 declare 갱신 필요 (코드 변경 시 frontmatter 동기화 책임)

**적용 패턴**: A2 인용 13 read-only 패턴. 디스패처 본질 (라우팅만)에 정합.

### Edit 보존 근거

A1 §1 evidence: 본문 Edit 호출 0. 그러나 declare 보존:

- v1.8b commands → skills 마이그레이션 시 원본 보존 (이력)
- 디스패처가 미래 안내문 수정 (예: 사용자에게 보낼 응답 메시지 동적 작성) 가능성
- 제거 시 Edit 사용 발생 → prompt → workflow 마찰. 보존 비용 0 (declare 자체는 free)
- → R5 Grey G1에서 (a) 유지 채택

---

## 3. R3 — `harness-run` / `harness-ship`: broad Bash 유지 (Q3=A)

**결정**: 두 SKILL 모두 broad `Bash` declare 유지. 콤마 → YAML list 형식만 정정.

```yaml
# harness-run/SKILL.md
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit

# harness-ship/SKILL.md
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
  - Edit(phases/**)
  - Write(phases/**)
```

**근거**:

- A1 §2 evidence (harness-run): 본문 Bash 실 호출 5건 모두 `{executor}` DYN. A3 §2 매트릭스 — 17 PM × 사용자 정의 executor 가능. fine-grain 시도 시 매트릭스 폭발
- A1 §3 evidence (harness-ship): 본문 Bash 실 호출 13건 — DYN 4 (test/type_check/lint) + WRITE 6 (git ops) + AUTO 3
- A3 §3 매트릭스: `{test_cmd}`/`{type_check_cmd}`/`{lint_cmd}` 첫 token 13가지 (PM × 도구 분기). Python pip은 `pytest`/`mypy`/`ruff` 3 분기 — prefix 추출 불가
- A3 §4 git ops fine-grain 분석: 옵션 위치 변경 / 다른 브랜치-remote 시나리오 모두 fragile
- PERMISSION_PATTERN.md §6 R3' Conservative — argument fine-grain 시도 미수행
- A2 인용 15: `Bash(*)` spec 명시 등재 — broad는 spec 무효 아님

**Anthropic 인용**: A2 인용 1 (pattern format) + 인용 15 (`Bash(*)` 명시) + 인용 12 (restrictive 권장이지만 fragile 회피와 trade-off)

**회귀 영향**:

- 콤마 separator → YAML list 변환: 파싱 정합 (A2 인용 14 "comma-separated" plugin-dev docs vs skills docs "space OR YAML list" conflict — YAML list 채택 시 양쪽 docs 충족)
- broad `Bash` 의미 변화 0 (Bash parens 없음 = `Bash(*)` 동등 — A2 §3 매트릭스)

**적용 패턴**: 동적 가변 명령 broad 유지 + 정적 명령 fine-grain 분기 정책 (PERMISSION_PATTERN.md §8 harness-meta 정책 표 확장).

### Edit/Write fine-grain 보존 (R5 일부)

`harness-ship/SKILL.md`:

- `Edit(phases/**)` — A1 §3 evidence: phases/ROADMAP.md, phases/index.json, phases/{version}/milestone.json 갱신
- `Write(phases/**)` — A1 §3 evidence: phases/{version}/{phase-name}/REPORT.md 작성
- → fine-grain 정합. 보존.

R3 결정과 별도 — Edit/Write는 정적 패턴 (`phases/**`)으로 fine-grain 가능 (vs Bash의 동적 `{test_cmd}`).

---

## 4. R4 — `harness-verifier.md` (agent): broad Bash 유지

**결정**: `tools: Read, Glob, Grep, Bash` (4 entries) → YAML list 4 entries (broad Bash 유지)

```yaml
tools:
  - Read
  - Glob
  - Grep
  - Bash
```

**근거**:

- A1 §4 evidence: 본문 Bash 직접 호출 0건. 그러나 4-Functional 단계 (line 37) "관련 테스트 경로 탐지 + (제안만) 프로젝트 테스트 커맨드로 해당 경로 실행 ... 실제 실행은 호출자 결정"
- 미래 확장 시나리오 3건:
  1. 4-Functional 단계 verifier 직접 실행으로 진화 — 호출자 (harness-ship) 위임 부담 분산
  2. harness-ship이 verifier에 추가 Bash 위임 — 예: `git log --oneline phases/{...}` (read-only) 위임
  3. agent 본문 코드 변경 시 우연한 Bash 호출 — declare 없으면 silent fail
- 일관성: 4 파일 중 3개 broad 유지 + 1개만 제거 = 분기 증가. 동상 유지가 verbose 0 추가
- A2 인용 11: subagent `tools:` 필드 명시 (`["Read", "Write", "Grep", "Bash"]` 권장 array 형식) — 본 R4가 정합

**Anthropic 인용**: A2 인용 11 (subagent `tools:` field) + A2 인용 12 (restrictive 권장이지만 미래 확장 가능성과 trade-off)

**회귀 영향**: 콤마 → YAML list 변환. broad `Bash` 의미 변화 0.

**적용 패턴**: subagent 필드명 분리 (`tools:` 별도 schema). 미래 확장 대비 broad 유지.

### `tools:` vs `allowed-tools:` 필드 분기

A2 §1 매트릭스 (인용 11):

| 위치 | 필드 |
|------|------|
| `.claude/commands/*.md` | `allowed-tools:` |
| `.claude/skills/*/SKILL.md` | `allowed-tools:` |
| `.claude/agents/*.md` | **`tools:`** (별도 schema) |

본 R4는 `tools:` 필드 정합 — 흔한 오류 (`allowed-tools:` 사용)와 구분.

---

## 5. R5 — Edit declare 처리

**결정**:

- `harness/SKILL.md` — Edit 보존 (Grey G1 결정: 디스패처 미래 안내문 Edit 가능성)
- `harness-ship/SKILL.md` — `Edit(phases/**)` / `Write(phases/**)` fine-grain 보존 (정적 패턴)

**근거 (harness/ Edit 보존)**:

- A1 §1 evidence: 본문 Edit 호출 0
- 그러나 디스패처 본질상 사용자 응답 메시지 (예: "다음 단계: `/harness-plan`. 대상: phases/v1.5/2-foo-phase/") 동적 작성 가능성
- 제거 시 우연한 Edit 사용 → prompt → 워크플로우 마찰. 보존 비용 0 (declare는 free)
- v1.8b commands → skills 마이그레이션 시 원본 보존 (이력)

**근거 (harness-ship Edit/Write 보존)**:

- A1 §3 evidence: phases/** 하위 6 파일 (REPORT.md / ROADMAP.md / index.json / milestone.json) Edit/Write 본문 명시
- 정적 패턴 (`phases/**`) — fine-grain 가능 (vs Bash 동적 `{test_cmd}`)
- 비-phases 경로 Edit/Write 시도 시 prompt → 안전장치 (예: 우연한 `src/**` 수정 차단)

**Anthropic 인용**: A2 인용 13 (read-only 패턴 + restrictive 권장)

**회귀 영향**: 0 (declare 무변경, 형식만 YAML list)

**적용 패턴**: 정적 경로 패턴은 fine-grain 유지 + 동적 명령은 broad — 분기 정책.

---

## 5b. R6 — 3 agent 콤마 separator 정정 (Q4=a 확장)

**결정**: 3 agent (`harness-dispatcher.md`, `harness-explore.md`, `harness-grey-area.md`) `tools: Read, Glob, Grep` (콤마) → YAML list 3 entries (Bash declare 무변경).

```yaml
# 3 agent 모두 동일 패턴
tools:
  - Read
  - Glob
  - Grep
```

**근거**:

- A6 §2 발견: 3 agent 모두 v1.10d Layer 1B에서 식별됐으나 "subagent docs spec 미확인" 별건 처리됨
- 본 v1.10f A2 인용 11 (subagent `tools:` array 형식 plugin-dev docs) 확보 → spec 미확인 상태 해소
- 본문 Bash 호출 0건 (read-only analytical agents — explore는 grep 기반, grey-area는 edge case 분석, dispatcher는 라우팅)
- broad Bash declare 미보유 → 형식 정정만 (Bash 추가/제거 무관)
- 동상 동시 처리 → templates baseline 일관성 + 단일 커밋 효율 + scope creep 0 (audit 0 추가, smoke 1 라인 추가)

**Anthropic 인용**: A2 인용 11 (subagent `tools:` array) + A2 인용 14 (plugin-dev "comma-separated" — 그러나 array 권장)

**회귀 영향**:

- 콤마 → YAML list 변환: 파싱 정합 (skills + plugin-dev docs 양쪽 verbatim 충족)
- broad/specific Bash 의미 변화 0 (Bash declare 무)

**적용 패턴**: 4 agent (verifier 포함) 일관 처리 → templates baseline 6 agent 중 4개 v1.10f 정합 (나머지 2 agent — 본 templates `agents/` 하위 4개만 존재, A6 §2 evidence)

## 6. Grey Areas (3건)

### G1 — `harness/SKILL.md`의 Edit declare 처리

| 후보 | 평가 | 채택 |
|------|------|:---:|
| (a) **유지** (디스패처 미래 안내 Edit 가능성) | 보존 비용 0 + 안전 default | ✓ |
| (b) 제거 (본문 사용 0) | A2 인용 12 restrictive 권장에 더 정합 | |

**채택 (a)**:

- A1 §1 evidence: 본문 사용 0. 그러나 R5 §5 근거 — 디스패처 동적 메시지 가능성
- 제거 → prompt 마찰 → workflow 저해. 보존 비용 0 (declare 1줄)
- A2 인용 12 restrictive 권장은 **best practice**이지 강제 아님. trade-off 영역

### G2 — `harness-verifier.md` 본문 Bash 0인데 broad 유지?

| 후보 | 평가 | 채택 |
|------|------|:---:|
| (a) **유지** (4-Functional 단계 미래 확장) | 미래 확장 + 일관성 + verbose 0 | ✓ |
| (b) 제거 (현 시점 사용 0) | A2 인용 12 restrictive 권장에 더 정합 | |

**채택 (a)**:

- A1 §4 evidence: 본문 0. 그러나 R4 §4 근거 — 미래 확장 시나리오 3건 + 4 파일 중 3개 broad 유지 일관성
- 제거 → 미래 코드 변경 시 silent fail 위험 + agent declare 분기 (3 SKILL은 broad / 1 agent만 미declare)
- subagent는 본질상 isolated context — silent fail 디버깅 어려움

### G3 — `harness-ship/SKILL.md`의 Edit/Write fine-grain

| 후보 | 평가 | 채택 |
|------|------|:---:|
| (a) **유지** (`Edit(phases/**)` / `Write(phases/**)`) | 비-phases 경로 prompt 강제 — 안전 default | ✓ |
| (b) 단순화 (broad Edit/Write) | declare 단순 + verbose 감소 | |

**채택 (a)**:

- A1 §3 evidence: phases/** 6 파일만 Edit/Write — 정적 패턴 fine-grain 가능
- 비-phases (예: `src/**`, `tests/**`) 우연 수정 시 prompt → 안전장치
- A2 인용 12 restrictive 권장에 정합 (Edit/Write는 fragile 영역 아님 — 정적 경로 패턴)
- harness-ship은 SHIP 단계 (배포 직전) — 비-phases 수정은 사용자 의도 확인 필요

**G1/G2/G3 공통 패턴**: 보존 비용 vs 안전 default + 일관성 trade-off에서 보존 채택. Anthropic restrictive 권장은 evidence-driven 예외 허용 (A2 §6 plugin-dev `Bash(*)` 인용 15 — broad 자체는 spec 유효).

---

## 7. Scope 매트릭스 (포함 5 + 제외 6)

### ✅ 포함 (6 항목)

| # | 항목 | scope |
|---|------|------|
| 1 | 7 파일 frontmatter 정정 (R1, Q4=a 확장) | S1b |
| 2 | `harness/SKILL.md` Bash 제거 (R2) | S1b |
| 3 | `harness-run`/`harness-ship` broad 유지 + YAML list (R3) | S1b |
| 4 | `harness-verifier.md` `tools:` broad 유지 + YAML list (R4) | S1b |
| 5 | `Edit(phases/**)` / `Write(phases/**)` 보존 (R5) | S1b |
| 6 | 3 agent (`dispatcher`/`explore`/`grey-area`) `tools:` 콤마 → YAML list (R6, Q4=a) | S1b |

### ❌ 제외 (6 항목 → 후속 또는 사용자 책임)

| # | 항목 | 제외 사유 | 후속 |
|---|------|----------|------|
| 1 | deployed projects (`<proj>/.claude/`) 동일 정정 | S6 (project) — meta 책임 외 | T4 후행 — 각 프로젝트 자기 세션 |
| 2 | settings.json deny rule 가이드 (사용자 환경 destructive 명령 제어) | 사용자 환경 영역 — 본 v1.10f templates scope 외 | PERMISSION_PATTERN.md §9 마이그레이션 가이드 별도 후속 |
| 3 | `[harness].executor_class` enum 도입 (broad → class 기반) | manifest schema 변경 — v1.2 스키마 영역 | manifest-schema v1.2 별도 세션 (3개월 재평가 게이트) |
| 4 | 사용자 settings.json 자동 분석 + deny rule 자동 생성 | tomllib parser 필요 (v2.0+) | manifest v2.0 후속 |
| 5 | `Bash` (parens 없음) vs `Bash(*)` 미묘 차이 검증 | docs 동치 명시 없음 — 실험적 영역 | Lessons에 기록만, evidence 축적 후 별도 세션 |
| 6 | `harness/SKILL.md` 디스패처 Bash 미사용을 코드 변경 강제 | 본 v1.10f는 frontmatter 정정만 — 본문 코드 변경 외 | (skip — 현 본문 정합) |

---

## 8. 결정 종합 표

| 결정 ID | 대상 | 결정 | Q확정 | 인용 # |
|---------|------|------|:---:|:---:|
| **R1** | 7 파일 (3 SKILL + 4 agent) | 처리 대상 | Q1=B + Q4=a | A2 인용 11 + A6 §2 |
| **R2** | `harness/SKILL.md` | Bash declare 제거 | Q2=A | A2 인용 12, 13 |
| **R3** | `harness-run`/`harness-ship` SKILL | broad Bash 유지 + YAML list | Q3=A | A2 인용 1, 15 |
| **R4** | `harness-verifier.md` agent | broad Bash 유지 + `tools:` YAML list | (자동 — 일관성) | A2 인용 11 |
| **R5** | Edit/Write declare | 보존 (정적 패턴 fine-grain) | (자동 — A1 evidence) | A2 인용 13 |
| **R6** | 3 agent (`dispatcher`/`explore`/`grey-area`) | `tools:` 콤마 → YAML list (Bash 무) | Q4=a | A2 인용 11 + A6 §2 |

**Grey 결정**:

| Grey ID | 대상 | 채택 | 후보 |
|---------|------|:----:|------|
| **G1** | `harness/SKILL.md` Edit | (a) 유지 | (a) 유지 / (b) 제거 |
| **G2** | `harness-verifier.md` broad Bash | (a) 유지 | (a) 유지 / (b) 제거 |
| **G3** | `harness-ship/SKILL.md` Edit/Write fine-grain | (a) 유지 | (a) 유지 / (b) 단순화 |

## 9. 관련 문서

- 본 세션 PLAN: [`../PLAN.md`](../PLAN.md)
- A1 본문 inventory: [`A1-bash-usage.md`](A1-bash-usage.md)
- A2 권위 인용: [`A2-anthropic-docs.md`](A2-anthropic-docs.md)
- A3 동적 변수: [`A3-dynamic-vars.md`](A3-dynamic-vars.md)
- A5 회귀 위험: [`A5-regression-risk.md`](A5-regression-risk.md)
- 5축 spec §6 R3' Conservative: [`../../../../bootstrap/docs/PERMISSION_PATTERN.md`](../../../../bootstrap/docs/PERMISSION_PATTERN.md)

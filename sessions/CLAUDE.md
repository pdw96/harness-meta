# sessions/ 모듈 가이드

세션 기록 트리. `sessions/{meta 또는 <project>}/vX.Y-{name}/` 디렉토리에 `PLAN.md` + `REPORT.md` 한 쌍 보관.
운영 docs 예외: `sessions/meta/ROADMAP.md` + `projects/<name>/ROADMAP.md` (v1.36+ 트리거 통합 view).

상위 진입: [`../CLAUDE.md`](../CLAUDE.md)

## 디렉토리 구성

```
sessions/
├── CLAUDE.md                       # 본 파일
├── meta/
│   ├── ROADMAP.md                  # 메타 전역 트리거 통합 view (v1.36+ 운영 docs 예외)
│   └── vX.Y-{name}/
│       ├── PLAN.md
│       └── REPORT.md
└── <project>/
    └── vX.Y-{name}/
        ├── PLAN.md
        └── REPORT.md
```

## 핵심 규약

### 세션 디렉토리

- **버전**: `vX.Y-{name}` — kebab-case slug, 변경 핵심 주제 요약
- **2 파일 한 쌍**: `PLAN.md` (시작) + `REPORT.md` (종료) — **그 외 파일 금지** (`index.json` / `step{N}.md` — 재귀 회피)
- **예외 1**: `audit/` 하위 디렉토리 — context7 검증 등 큰 산출물 보존 시 (evidence-driven, sparingly)

### ROADMAP.md (운영 docs 예외)

`sessions/<target>/ROADMAP.md` 1 파일은 PLAN/REPORT 한 쌍 규약의 **예외**. 후속 트리거 통합 view 단일 소스.

- **`sessions/meta/ROADMAP.md`** — 메타 전역
- **`projects/<name>/ROADMAP.md`** — 프로젝트별 (Bootstrap S6에서 자동 생성, v1.36+)

§"다음 후보 (활성)" → §"Out of scope (trigger 대기)" → §"Schedule 후보" → §"최근 완료" → §"확정 세션 (이력 stamp)" 섹션 구성.

`harness-roadmap-update` SKILL이 매 REPORT 작성 후 자동 갱신 (5-step Identify/Validate/Classify/Sanitize/Update).

## PLAN.md 작성 규약

### 의무 § (4 + 1)

PLAN.md 상단 순서 고정:

1. **`## 세션 소속 근거 (self-apply)`** — S#/T# 명시, 3~5줄 권장
2. **`## Scope inheritance (verbatim from <선행 세션>)`** — 선행 세션 sub-item 원문 인용 (변형/해석 금지)
3. **`## Out of scope (explicit rejection)`** — 인접 발견 issue 표 (빈 표 = "없음" 선언)
4. **`## Spec verification (context7)`** — sub-field 5종 (library/topic/findings/drift/re-verify) + Citations (drift=N/A 분기 시 모든 N/A)
5. (이후 자유) — 배경 / 목표 / 변경 대상 / 성공 기준 / 커밋 전략 / 후속 분기

### Scope contract 규격

상세: [`../bootstrap/docs/OWNERSHIP.md`](../bootstrap/docs/OWNERSHIP.md) `## Scope contract`

- **Scope inheritance**: 선행 세션 PLAN의 Out of scope 표 또는 사용자 발의 verbatim 인용 + Parsed sub-items 사전 공개
- **Out of scope**: 본 세션 본문에 흡수하지 않을 인접 발견 issue 표 + 분리 대상 세션 ID 또는 조건

위반 시 `tests/smoke-scope-contract.sh` FAIL.

### Spec verification (context7) §

상세: [`../bootstrap/docs/SPEC_VERIFICATION.md`](../bootstrap/docs/SPEC_VERIFICATION.md)

- **In scope**: meta v1.24+ + project v1.26+ PLAN
- **drift 값**: `yes` / `no` / `N/A` (정확 1개) + ` — ` 뒤 1줄 설명
- **부분 N/A 금지**: drift=N/A 시 다른 4 sub-field 정확히 `N/A`
- **위반 시**: `tests/smoke-spec-verification.sh` FAIL

## REPORT.md 작성 규약

### 의무 § (5)

1. 최종 결과 (테스트 수, 신규 모듈, 변경 파일)
2. 구현 요약 (각 목표 항목 → 실제 구현)
3. 판정 (PLAN 체크박스 완수 여부)
4. **`## Spec verification (context7)`** (v1.27+ 의무) — 판정 § 직후 / Lessons Learned § 직전
5. Lessons Learned + 다음 후보 (보류)

### REPORT § cross-file 일관성 (v1.32+)

PLAN drift ↔ REPORT drift 9 case 매트릭스 (`smoke-spec-verification.sh` Stage 7):

| PLAN → REPORT | 분류 | 비고 |
|---------------|------|------|
| N/A → N/A / no → no / yes → yes / no → yes / yes → no | OK | 5 case 자연 진화 |
| **N/A → no/yes** | **FAIL** | scope 위반 (PLAN N/A 선언 후 spec 의존 발견) |
| **no/yes → N/A** | **WARN** | scope 축소 (smoke PASS + ⚠️ marker) |

## 세션 소속 판정 (S1~S7 + T1~T5)

CWD 무관 — **변경 대상의 scope**가 결정.

| Scope | 물리 경로 | 소유 |
|-------|---------|------|
| **S1a** | `claude/**` | meta |
| **S1b** | `bootstrap/templates/_base/.claude/**` | meta |
| **S1c** | `bootstrap/skills/<category>/<name>/**` | meta |
| **S2** | `bootstrap/**` (skills 제외) | meta |
| **S3** | `{README, CLAUDE, install.{ps1,sh}, AGENTS}.md` | meta |
| **S4** | `projects/<name>/**` | `<name>` |
| **S5** | `<proj>/scripts/harness/**` | `<name>` |
| **S6** | `<proj>/{.harness.toml, .claude/, .mcp.json, ...}` | `<name>` |
| **S7** | `<proj>/{bot, core, config, ...}` | meta 체계 외 |

Tie-breakers: T1 다수결 → T2 스펙 vs 값 → T3 검증 대상 → T4 크로스 커팅 분할 → T5 애매하면 meta.

상세: [`../bootstrap/docs/OWNERSHIP.md`](../bootstrap/docs/OWNERSHIP.md).

## 작업 가이드

### 세션 시작 시

1. `~/harness-meta/sessions/<target>/` 스캔 → 최신 버전 + 1 (minor bump)
2. `mkdir -p ~/harness-meta/sessions/<target>/vX.Y-{name}/`
3. ROADMAP §2 활성 후보 검토 (0건 시 AskUserQuestion 자동 invoke로 새 발의)
4. PLAN.md 작성 — 의무 § 5종 (위 §"PLAN.md 작성 규약")
5. 변경 파일 규모별 다각적 검토 (≤5 → 3 관점 / 6~15 → 4 관점 / 16+ → 5 관점)
6. Plan-verify (context7) — `harness-plan-verify` SKILL self-apply
7. 사용자 PLAN 확정 (AskUserQuestion 항상 invoke)

### 세션 종료 시

1. REPORT.md 작성 — 의무 § 5종 (위 §"REPORT.md 작성 규약")
2. `harness-roadmap-update` SKILL invoke (자동 ROADMAP 갱신 — `sessions/meta/ROADMAP.md` 또는 `projects/<name>/ROADMAP.md`)
3. 사용자 커밋 확인 (커밋 전 의무)
4. conventional commits 메시지 (`docs(meta):` / `feat(meta):` / `fix(meta):` / `chore(meta):`)

### 레거시 면제 정책 (forward-only)

- **Scope contract**: pre-v1.10j 세션 면제 (smoke `LEGACY_PLANS` skip)
- **Spec verification**: pre-v1.24 meta + pre-v1.26 project + pre-v1.27 REPORT 면제
- 신규 세션은 모든 의무 § 준수 + 위반 시 PLAN 거부

## Manual Context Injection (모듈 CLAUDE.md ↔ Sub-agent, v1.75+)

서브에이전트 spawn 시 메인 Claude는 작업 영역 모듈의 CLAUDE.md content를 prompt에 명시 inject한다. SKILL 인프라 없이 토큰 효율 + 단일 source-of-truth 보장.

도입 세션: [`meta/v1.75-module-context-injection/`](meta/v1.75-module-context-injection/) — 옵션 B (sub-agent SKILL preload) → 옵션 A (`disable-model-invocation: true`) → 옵션 X (Manual Injection) 사고 진화 결과.

### 규칙

| 작업 영역 | inject 대상 | 의무도 |
|---------|----------|------|
| `tests/smoke-*` 작업 | `tests/CLAUDE.md` | 의무 |
| `bootstrap/` 작업 | `bootstrap/CLAUDE.md` | 의무 |
| `claude/` 작업 | `claude/CLAUDE.md` | 의무 |
| `sessions/` 작업 (PLAN/REPORT) | `sessions/CLAUDE.md` | 의무 |
| `bootstrap/skills/` 작업 | `bootstrap/skills/CLAUDE.md` | 의무 |
| 일반 grep/read | — | 선택 |

### Inject 형식

prompt 도입부에 `Module context (from <path>/CLAUDE.md):` 라벨 + content 섹션. 토큰 효율 우선 — 관련 § 발췌 가능.

```text
Agent(
    description="신규 smoke 작성",
    subagent_type="general-purpose",
    prompt=f"""Module context (from tests/CLAUDE.md §"smoke 작성 5-step 흐름" + §"흔한 함정"):

{relevant_sections_content}

---

Task: smoke-foo.sh를 작성하라. ..."""
)
```

### 채택 근거 (v1.75 사고 진화 종착점)

- **토큰 효율** — 모듈 CLAUDE.md (~100~250줄) 1회 inject vs SKILL 250줄 + cross-ref 절약 (단순 작업 시 ~250줄 절감)
- **단일 source-of-truth** — drift 0 (모듈 CLAUDE.md 갱신만)
- **GSD 패턴** — 메인 Claude의 명시 결정 (silent invoke 0)
- **Infrastructure 0** — SKILL/install/symlink 무 (5 module 모두 SKILL 없이 동작)

### 자동화 거부 (v1.75 정책)

작업 path 자동 감지 → CLAUDE.md 자동 prepend 메커니즘은 **본 세션 거부** — silent invoke risk 회복으로 옵션 B 회귀. evidence 누적 (누락 5+) 시 후속 검토 (`v1.75b-injection-automation`).

## CRITICAL 제약

- **index.json / step{N}.md 생성 금지** (재귀 회피)
- **세션 간 연결**: REPORT의 "후속 세션" / "선행 세션" 섹션으로만 (T4 크로스 커팅 분할)
- **harness-meta repo 변경**: 커밋 전 사용자 확인 필수

## 관련 문서

- 상위 진입: [`../CLAUDE.md`](../CLAUDE.md)
- 세션 소속: [`../bootstrap/docs/OWNERSHIP.md`](../bootstrap/docs/OWNERSHIP.md)
- Spec verification § 규격: [`../bootstrap/docs/SPEC_VERIFICATION.md`](../bootstrap/docs/SPEC_VERIFICATION.md)
- Plan-verify SKILL: [`../bootstrap/skills/audit/harness-plan-verify/SKILL.md`](../bootstrap/skills/audit/harness-plan-verify/SKILL.md)
- ROADMAP 갱신 SKILL: [`../bootstrap/skills/audit/harness-roadmap-update/SKILL.md`](../bootstrap/skills/audit/harness-roadmap-update/SKILL.md)
- 메타 ROADMAP: [`meta/ROADMAP.md`](meta/ROADMAP.md)
- 8단계 흐름: [`../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md)

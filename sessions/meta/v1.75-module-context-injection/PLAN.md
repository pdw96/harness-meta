# meta v1.75-module-context-injection — PLAN

세션 시작: 2026-05-05
직접 선행 세션: [`sessions/meta/v1.73-nested-claude-md/`](../v1.73-nested-claude-md/PLAN.md) (모듈별 CLAUDE.md 5건 도입) · [`sessions/meta/v1.74-skills-3-tier-infra/`](../v1.74-skills-3-tier-infra/PLAN.md) (3-tier 인프라)

목적: 모듈 CLAUDE.md ↔ 서브에이전트 매칭의 **토큰 효율 최우선** 해법으로 **Manual Context Injection 패턴** 채택. SKILL 인프라 폐기 + tests/CLAUDE.md 단일 source-of-truth로 enrichment + 메인 Claude의 sub-agent prompt에 모듈 CLAUDE.md 명시 inject 컨벤션. 사용자 1차 발의("매칭")는 manual injection으로 충족 + 토큰 효율은 SKILL 폐기로 최적화.

**중요 — 본 세션의 사고 진화 이력**: 본 세션은 동일 v1.75 슬롯에서 3차례 접근을 시도하여 도달:

1. **옵션 B 초안** (`disable-model-invocation` 부재 + `user-invocable: false`) — sub-agent 자동 preload 허용 → 8 잠재 문제 인식 (컨텍스트 오염 / false positive / drift / 보안 / 본질적 한계 / ROI 역전 / 옵션 1·3 재고 / evidence 게이트)
2. **옵션 A** (`disable-model-invocation: true`) — silent invoke + sub-agent preload 이중 차단 → 1차 발의("자동 매칭") 의도 미달 + 잔존 문제 #3·#6 + ROI 역전 risk
3. **옵션 X (본 세션 채택)** — Manual Context Injection — SKILL 폐기 + 모듈 CLAUDE.md 단일 source + 메인 Claude의 명시 inject

3단계 진화에서 옵션 B/A 작업은 모두 hard reset (44a03a3로 복귀)되어 git history에 남지 않음. 본 PLAN/REPORT가 사고 진화의 **유일한 영구 기록**.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(2) `tests/CLAUDE.md` enrichment + `sessions/CLAUDE.md` (manual injection 컨벤션) = 2/2 meta
- **T1 경로 다수결** — meta scope 2/2
- **T2 스펙 vs 값** — 모듈 ↔ sub-agent injection 컨벤션 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — 사용자 발의 (2026-05-05)** verbatim:

> "모듈별 claude.md와 서브 에이전트와 매칭을 시키는 것에 대해서 논의" → "어떤게 하네스 엔지니어링에 더 알맞을까" → "이렇게 해서 생기는 문제가 뭐가 있을까?" → "방금전까지의 작업을 전부 롤백하고 옵션 A로 바꿀수 있어?" → "컨텍스트 오염 및 토큰 폭발은 해결된거야?" → "내가 처음에 발의한 내용이 뭐였지?" → **"어쨋든 토큰 효율은 중요한 문제란 말이야. 처음에 발의한 의도는 너가 말한게 맞지만 효율성을 고려했을때 뭐가 올바를까?"**

**Source 2 — 본 세션 진행 중 토큰 효율 분석** verbatim:

> "옵션 1 (manual injection): tests/CLAUDE.md 152줄 once
> 옵션 A (현재): SKILL 250줄 + tests/CLAUDE.md cross-ref 152줄 = 402줄
> 옵션 B: SKILL 250줄 auto + tests/CLAUDE.md (필요 시) = 250~400줄
> → 옵션 1이 가장 효율적"

**Source 3 — 본 세션 SKILL.md 가치 분해** verbatim:

> "SKILL 고유 가치는 ~30줄 (§1+§7) — invocation 정책 자체뿐. 나머지 ~220줄은 tests/CLAUDE.md로 이전 가능"

**Source 4 — 사용자 옵션 X 채택 결정** verbatim:

> "옵션 X — Full rollback + enrichment (Recommended)" 선택 → v1.75 3-commit (18c2b97 / 397ed1f / 6d6bf14) hard reset + tests/CLAUDE.md enrichment + manual injection convention 도입

**Parsed sub-items (4)**:

1. **v1.75 (옵션 A) hard reset 완료** — 3 commit 폐기 + symlink + SKILL 디렉토리 + session 디렉토리 정리 (Phase 1 이미 실행)
2. **tests/CLAUDE.md enrichment** — 5-step 흐름 / Skeleton 선택 매트릭스 / 흔한 함정 5건 evidence-base 추가 (~150줄 → ~250줄)
3. **Manual Context Injection 컨벤션 도입** — `sessions/CLAUDE.md`에 메인 Claude의 sub-agent spawn 시 prompt에 관련 모듈 CLAUDE.md를 명시 inject하는 패턴 명시
4. **잔존 v1.75 후보 후속 정리** — P1~P4 (sessions-auditor 등) + v1.75f / v1.75g / v1.75h 모두 ROADMAP에서 폐기 (SKILL 폐기로 의미 상실)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `bootstrap/skills/dev-tools/tests-smoke-helper/` SKILL 신규 작성 | **영구 거부** — 옵션 A 채택 후 8 잠재 문제 + ROI 역전으로 거부. SKILL 인프라 자체 사용 안 함 |
| 잔여 4 모듈 SKILL (sessions-auditor / bootstrap-helper / claude-helper / skills-helper) | **영구 거부** — module-skill 패턴 자체 폐기 |
| 옵션 B `user-invocable: false` + sub-agent preload | **영구 거부** — 8 잠재 문제 (rollback 결정) |
| 옵션 A `disable-model-invocation: true` | **본 세션 거부** — 1차 발의 미달 + 잔존 문제 #3·#6 (rollback 결정) |
| 옵션 C `claude/agents/<module>-agent.md` 별도 정의 | **본 세션 거부** — 옵션 X로 충분, abstraction layer 추가 회피 |
| 자동 inject mechanism (작업 경로 감지 → CLAUDE.md 자동 prepend) | 영구 거부 — silent invoke risk (본 세션 옵션 1 자동 부분 재거부) |
| `~/.claude/skills/` 1단계 평탄 SKILL 추가 | 영구 거부 — SKILL 폐기 결정 |
| `bootstrap/docs/SKILLS.md` / `bootstrap/skills/CLAUDE.md` 매트릭스 갱신 | 본 세션 거부 — 신규 SKILL 0건 (5 skill 매트릭스 그대로 유지) |
| root `CLAUDE.md` "5건" → "6건" 변경 | 본 세션 거부 — 동일 (5건 유지) |
| `tests/smoke-skills-install.sh` 매트릭스 1건 추가 | 본 세션 거부 — 동일 |
| `harness-roadmap-update` SKILL invoke 의무 | 보존 — sessions/CLAUDE.md 갱신은 v1.36+ 컨벤션 정합 |
| Manual injection 자동화 도구 / hook | 본 세션 거부 — 컨벤션 documented 후 메인 Claude의 명시 책임. evidence 누적 후 후속 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | Sub-agent prompt 구성 / 모듈 CLAUDE.md on-demand 로드 / Agent tool description+prompt 구조 |
| **findings** | see citations below |
| **drift** | no — Claude Code의 subdirectory on-demand load (v1.73 active) + Agent tool prompt 자유 구성 spec 정합. 본 세션은 새 mechanism 도입 없음 (기존 인프라 재사용) |
| **re-verify** | Claude Code subdirectory load mechanism 또는 Agent tool prompt API 변경 시 |

**Citations**:

- C1 — Claude Code memory subdirectory on-demand load: 모듈 CLAUDE.md는 해당 디렉토리 작업 시 자동 로드 (v1.73에서 활용). 본 세션의 manual injection은 이 자동 로드를 **메인 Claude → sub-agent** 경로로 명시 확장 (Source: `https://code.claude.com/docs/en/memory`)
- C2 — Agent tool prompt 자유 구성: `Agent({prompt: "..."})`의 prompt 필드는 plain text 자유 구성. 메인 Claude가 모듈 CLAUDE.md content를 prompt에 직접 inject 가능 (Source: Claude Code Agent tool spec)
- C3 — Sub-agent isolation: Agent로 spawn된 sub-agent는 부모 컨텍스트 상속하지 않음 — prompt가 유일 컨텍스트 (Source: Claude Code agents docs). 본 세션 Manual Injection의 직접 메커니즘
- C4 — SKILL preload 메커니즘 의존성 회피: 본 세션은 SKILL 인프라 자체 사용 안 함 → `disable-model-invocation` / `user-invocable` 등 invocation 정책 매트릭스 무관 (옵션 A/B 회피)

## 1. 배경 — 사고 진화 3단계

### 1-1. 옵션 B 초안 단계 (rollback됨)

`bootstrap/skills/dev-tools/tests-smoke-helper/SKILL.md` (~250줄) + `user-invocable: false` + `disable-model-invocation` 부재 → 서브에이전트 자동 SKILL preload 허용. 사용자 1차 발의("모듈 ↔ 서브에이전트 매칭") 직접 정합.

**거부 사유** (8 잠재 문제):

1. 컨텍스트 오염 / 토큰 폭증 — 모든 sub-agent에 ~250줄 자동 주입
2. False positive invocation — description trigger 광범위 매칭
3. SKILL drift / 유지보수 비용 — tests/CLAUDE.md 변경 시 SKILL stale, 5x 비대
4. 보안 / scope 누수 — silent invoke surprising behavior
5. 설계 본질적 한계 — Claude Code SKILL preload black box
6. ROI 역전 가능성 — 단순 작업일수록 SKILL 비효율
7. 옵션 1/3 재고 필요 — 본 매칭이 임시 mechanism일 가능성
8. Evidence 수집 우선 — prototype 효용 미평가

### 1-2. 옵션 A 단계 (rollback됨)

`disable-model-invocation: true` + (default `user-invocable: true`) → silent 자동 invoke + sub-agent preload 이중 차단. mindvault + harness-roadmap-update precedent 정합.

**거부 사유**:

- **사용자 1차 발의 미달** — "자동 매칭"이 사용자 명시 호출로 전환됨 → 1차 발의 직접 충족 X
- **잔존 문제 #3 (drift)** — invocation 정책과 무관. tests/CLAUDE.md 변경 시 SKILL stale risk
- **잔존 문제 #6 (ROI 역전)** — 단순 작업 시 SKILL 250줄 + tests/CLAUDE.md cross-ref 152줄 = 402줄 vs tests/CLAUDE.md 직접 read 152줄
- **새 부작용 — discoverability 의존** — 사용자/메인 Claude가 SKILL 존재 알아야 invoke

### 1-3. 옵션 X (본 세션 채택)

**Manual Context Injection** — SKILL 폐기 + tests/CLAUDE.md 단일 source-of-truth로 enrichment + 메인 Claude가 sub-agent prompt 구성 시 관련 모듈 CLAUDE.md content를 **명시 inject**.

**채택 사유** (토큰 효율 + 의도 정합):

| 차원 | 옵션 X 정합 |
|------|:---:|
| 토큰 효율 (단순 작업) | ✅✅ 152줄 only (vs 옵션 A 402줄, 옵션 B 250~) |
| 토큰 효율 (sub-agent multi-spawn) | ✅✅ 필요한 모듈만 inject (vs 옵션 B 250 × N) |
| 사용자 1차 발의 ("매칭") | ✅ 메인 Claude가 명시 inject로 충족 (silent 아니지만 자동 보다 정밀) |
| 단일 source-of-truth | ✅✅ tests/CLAUDE.md만 갱신 (drift 0) |
| 하네스 엔지니어링 정합 | ✅ GSD 패턴 (명시 결정), scope contract 명확 |
| Infrastructure overhead | ✅✅ SKILL 인프라 0, install/symlink/매트릭스 갱신 0 |
| 5 module-skill 누적 비용 | ✅✅ 0 (SKILL 자체 없음) |
| 잔존 문제 #3 (drift) | ✅ 자동 해소 (단일 source) |
| 잔존 문제 #6 (ROI 역전) | ✅ 자동 해소 (SKILL 자체 무) |
| 새 부작용 (discoverability) | ⚠️ 컨벤션 documented 의무 (sessions/CLAUDE.md) |

**거부 사유 (옵션 X에도 잔존)**:

- ⚠️ 메인 Claude의 명시 책임 — sub-agent spawn 시 inject 의무 인지 필요. **컨벤션 docs로 보완**
- ⚠️ 자동 매칭은 아님 — 1차 발의 의도의 "자동" 부분은 미달. 단 silent invoke risk가 0이라는 가치가 우선

## 2. 결정 (R1 ~ R4)

### R1 — Manual Context Injection 컨벤션 정의

메인 Claude가 `Agent` tool로 sub-agent spawn 시:

**규칙**:

1. sub-agent의 작업 영역(target file/directory)이 특정 모듈에 속하면 해당 **모듈 CLAUDE.md content를 prompt에 inject**
2. 영역 결정은 **해당 sub-agent의 작업 path** 기준 (예: `tests/smoke-*.sh` 작업 → `tests/CLAUDE.md` inject)
3. inject 형식: prompt 도입부에 "**Module context (from `<path>/CLAUDE.md`)**:" 라벨 + content 섹션 (관련 §만 발췌 가능)
4. **Inject 의무 범위**:
   - sub-agent task가 해당 모듈 작업이면 의무
   - 일반 query (단순 grep/read 등)는 선택
   - 메타 작업 (sessions/PLAN/REPORT) → `sessions/CLAUDE.md` inject

**예시** (tests/ 작업 위임):

```python
Agent(
    description="신규 smoke 작성",
    subagent_type="general-purpose",
    prompt=f"""Module context (from tests/CLAUDE.md):

{tests_claude_md_content}

---

Task: smoke-foo.sh를 작성하라. ...
"""
)
```

**예시** (관련 §만 발췌):

```python
prompt=f"""Module context (tests/CLAUDE.md §"smoke 매트릭스" + §"흔한 함정"):

{relevant_sections}

---

Task: ...
"""
```

### R2 — tests/CLAUDE.md enrichment

기존 152줄 → ~250줄로 enrichment. 추가 콘텐츠는 옵션 A 단계에서 SKILL.md에 작성됐던 UNIQUE expertise 이전:

#### R2-1. §"smoke 작성 5-step 흐름" (신규 §, ~50줄)

```
### Step 1 — Identify (사용자 의도 분류)
| 의도 | 분기 |
| 신규 smoke 작성 | Step 2 |
| 기존 smoke 수정 | Step 3 |
| --fix mode 추가 | Step 4-bis |
| 회귀 검증 | Step 5 skip |

### Step 2 — Plan (카테고리 + skeleton 선택)
(smoke 매트릭스 §"smoke 매트릭스" 참조)

### Step 3 — Generate (bash skeleton)
(기존 §"출력 패턴" 참조)

### Step 4 — Validate (E2E violation 주입)
(기존 §"회귀 검증 절차" 참조)

### Step 4-bis — --fix mode 추가
(기존 §"--fix mode 패턴" 참조)

### Step 5 — Register (등재 안내)
1. chmod +x
2. 본 매트릭스에 1 row 추가
3. (user discretion) pre-commit 등록 검토
4. (user discretion) CI workflow 추가
```

#### R2-2. §"Skeleton 선택 매트릭스" (신규 §, ~15줄)

| 시나리오 | skeleton |
|---------|---------|
| 정적 패턴 grep만 | check + grep -qE |
| 정적 + 동적 | mktemp tmpdir + 명령 실행 |
| Cross-OS | Linux/macOS dynamic + Windows skip 분기 |
| --fix mode-only | argv + Python heredoc + .bak |
| LEGACY skip | LEGACY_FILES array + contains check |
| --include-legacy opt-in | flag (v1.34 precedent) |

#### R2-3. §"흔한 함정 (5 evidence-base)" (신규 §, ~30줄)

| 함정 | 증상 | 회피 |
|------|------|------|
| pipefail 회귀 (v1.30b) | cmd \| head -1 시 head exit 141 → 전체 fail | 영향 라인만 set +o pipefail; ...; set -o pipefail |
| grep -c \|\| echo 0 이중 출력 (v1.63) | 0 매치 시 0 + echo 0 → 변수에 0\n0 | boolean 분리 |
| MSYS2 path translation (v1.70) | Windows Git Bash가 인자 변환 → Python sys.argv mismatch | sys.argv 경유 |
| shellcheck SC2010/2064/2088/2034 (v1.66) | 다양한 패턴 | 각 회피 |
| CRLF 라인 종결 | $'\r': command not found | .gitattributes LF + Python newline='\n' |

### R3 — `sessions/CLAUDE.md`에 Manual Context Injection 컨벤션 명시

신규 § 추가 (~25줄):

```markdown
## Manual Context Injection (모듈 CLAUDE.md ↔ Sub-agent, v1.75+)

서브에이전트 spawn 시 메인 Claude는 작업 영역 모듈의 CLAUDE.md content를 prompt에 명시 inject한다. SKILL 인프라 없이 토큰 효율 + 단일 source-of-truth 보장.

### 규칙

| 작업 영역 | inject 대상 | 의무도 |
|---------|----------|------|
| `tests/smoke-*` 작업 | `tests/CLAUDE.md` | 의무 |
| `bootstrap/` 작업 | `bootstrap/CLAUDE.md` | 의무 |
| `claude/` 작업 | `claude/CLAUDE.md` | 의무 |
| `sessions/` 작업 (PLAN/REPORT) | `sessions/CLAUDE.md` | 의무 |
| `bootstrap/skills/` 작업 | `bootstrap/skills/CLAUDE.md` | 의무 |
| 일반 grep/read | 선택 |

### Inject 형식

prompt 도입부에 "Module context (from <path>/CLAUDE.md):" 라벨 + content 섹션 (관련 § 발췌 가능, 토큰 효율 최우선).

### 채택 근거

- 토큰 효율 — 모듈 CLAUDE.md (~100~150줄) 1회 inject vs SKILL 250줄 + cross-ref 절약
- 단일 source-of-truth — drift 0 (모듈 CLAUDE.md 갱신만)
- GSD 패턴 — 메인 Claude의 명시 결정 (silent invoke 0)
- Infrastructure 0 — SKILL/install/symlink 무

상세: [`v1.75-module-context-injection`](meta/v1.75-module-context-injection/) 사고 진화 (옵션 B → A → X).
```

### R4 — 폐기된 SKILL 후속 정리 (ROADMAP)

ROADMAP §3-A에서 다음 후보 모두 폐기:

- `v1.75b-sessions-auditor-skill` (P1) — module-skill 패턴 자체 폐기
- `v1.75c-bootstrap-helper-skill` (P2)
- `v1.75d-claude-layer-helper-skill` (P3)
- `v1.75e-skills-author-skill` (P4)
- `v1.75f-claude-agents-module-matching` (옵션 C 평가) — 옵션 X로 충분
- `v1.75g-option-b-revisit` — 옵션 B의 토큰 risk가 옵션 X보다 명확히 열등 → 영구 거부
- `v1.75h-skill-drift-smoke` — SKILL 폐기로 drift target 부재

신규 후속 trigger 등록:

| 후속 세션 | Trigger 조건 |
|---------|------------|
| `v1.75b-injection-automation` | Manual Context Injection 빈도 ≥ 5회 + 누락 evidence 1+ → 자동화 도구 검토 (silent risk 회피 mechanism 포함) |
| `v1.75c-injection-section-helper` | 모듈 CLAUDE.md §section 발췌 자동화 helper 필요 evidence (메인 Claude가 매번 수동 발췌 비용 누적) |

## 3. 변경 대상 (2 파일)

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/CLAUDE.md` | S2 | R2 — 5-step + Skeleton 매트릭스 + 흔한 함정 5건 추가 (152 → ~250줄) |
| `sessions/CLAUDE.md` | S2 | R3 — Manual Context Injection 컨벤션 신규 § 추가 (~25줄) |

### 세션 산출 (2)

| 경로 | 역할 |
|------|------|
| `sessions/meta/v1.75-module-context-injection/PLAN.md` | 본 파일 |
| `sessions/meta/v1.75-module-context-injection/REPORT.md` | 종료 시 |

### Out of scope (변경 안 함)

- `bootstrap/skills/dev-tools/tests-smoke-helper/` — 폐기 (SKILL 인프라 사용 안 함)
- `bootstrap/docs/SKILLS.md` — 변경 없음 (5 skill 그대로)
- `bootstrap/skills/CLAUDE.md` — 변경 없음 (5 skill)
- `tests/smoke-skills-install.sh` — 변경 없음 (10건 매트릭스 → 9건 그대로)
- root `CLAUDE.md` — 변경 없음 (5건 그대로)
- `~/.claude/skills/tests-smoke-helper/` — 폐기 (rollback에서 제거)

## 4. 목표

- [x] Phase 1 — v1.75 (옵션 A) hard reset + symlink + SKILL/session 디렉토리 정리 (이미 완료)
- [x] Phase 2 — PLAN.md 작성 (본 파일)
- [ ] **사용자 PLAN 확인**
- [ ] Phase 3a — `tests/CLAUDE.md` enrichment (R2)
- [ ] Phase 3b — `sessions/CLAUDE.md` Manual Context Injection 컨벤션 § 추가 (R3)
- [ ] Phase 4a — smoke 회귀 검증 (skills-install + bash-permission-pattern + spec-verification + scope-contract + roi-regression + thinking-effort)
- [ ] Phase 4b — REPORT.md + ROADMAP §3-A 정리 (R4 — 7 후속 폐기 + 2 신규) + §8 + §9
- [ ] 커밋 (사용자 확인 후, 단일 또는 분할)

## 5. 성공 기준

- [ ] `tests/CLAUDE.md` 분량 ~250줄 달성 (5-step + Skeleton + 흔한 함정 5건 모두 포함)
- [ ] `tests/CLAUDE.md` 단일 source-of-truth — SKILL.md 부재 검증 (`ls bootstrap/skills/dev-tools/` → mindvault, developer-profile만)
- [ ] `~/.claude/skills/tests-smoke-helper/` symlink 부재 검증
- [ ] `sessions/CLAUDE.md` Manual Context Injection § 추가 + 5 모듈 매트릭스 (tests/sessions/bootstrap/claude/skills) 명시
- [ ] smoke 회귀 0 (6 smoke 종) — skills-install matrix 9건 그대로 (5 skill, tests-smoke-helper 부재)
- [ ] ROADMAP §3-A에서 7 후속 폐기 (v1.75 SKILL 관련 모두) + 2 신규 등록 (v1.75b-injection-automation, v1.75c-injection-section-helper)
- [ ] git log clean — 44a03a3 직후에 본 v1.75-module-context-injection 신규 commit (option B/A 작업 흔적 0)

## 6. 위험과 회피

| 위험 | 회피 |
|------|------|
| 메인 Claude가 sub-agent spawn 시 inject 의무 망각 | sessions/CLAUDE.md 컨벤션 § 명시 + harness-meta 8단계 흐름에 단계 추가 검토 (별 후속) |
| 모듈 CLAUDE.md 분량 비대 (250줄 → 점진 증가) | 모듈 CLAUDE.md drift 자동 감지 smoke (별 후속, evidence-driven) |
| Manual Injection 자동화 충동 | 본 세션 거부 — 자동화는 silent invoke risk 회복. evidence 누적 후 후속 (v1.75b-injection-automation) |
| tests/CLAUDE.md enrichment이 오히려 모듈 CLAUDE.md 분량 부담 | 250줄은 SKILL 250줄 + cross-ref 152줄 = 402줄보다 작음 — 효율 우위 |
| 사용자가 module-skill 매트릭스 구조 잃은 것 후회 | PLAN/REPORT의 사고 진화 narrative로 audit trail 보존 + git reflog 30일 |

## 7. 커밋 전략

### 단일 commit (권장)

scope가 작아서 (2 파일 수정 + 세션 산출 2) 분할 commit 비용 > 가치. pre-commit hook 충돌 risk도 단일 commit이 낮음:

```
feat(meta): sessions/meta/v1.75-module-context-injection — Manual Context Injection 채택 (옵션 X)

사고 진화 3단계 종착점:
- 옵션 B 초안 (sub-agent SKILL preload 허용) — 8 잠재 문제 인식 후 rollback
- 옵션 A (disable-model-invocation: true) — 1차 발의 미달 + 잔존 #3·#6 후 rollback
- 옵션 X 본 채택 (Manual Context Injection) — SKILL 폐기 + 단일 source + 토큰 효율 최우선

변경:
- update: tests/CLAUDE.md (R2 — 5-step + Skeleton matrix + 흔한 함정 5건, 152 → ~250줄)
- update: sessions/CLAUDE.md (R3 — Manual Context Injection 컨벤션 § 신규)
- add: sessions/meta/v1.75-module-context-injection/{PLAN,REPORT}.md

ROADMAP 정리:
- §3-A 7 후속 폐기 (P1~P4 + v1.75f/g/h — module-skill 패턴 자체 폐기)
- §3-A 2 신규 등록 (v1.75b-injection-automation, v1.75c-injection-section-helper)

Smoke: 회귀 0 (6 smoke 종 — skills-install 9건 매트릭스 그대로, 5 skill 유지).

Co-Authored-By: Claude Sonnet 4.6 (1M context) <noreply@anthropic.com>
```

### 분할 commit (대안)

3 commit (PLAN / 구현 / REPORT+ROADMAP) — 옵션 A v1.75에서 사용한 패턴. 이번엔 scope가 작아 단일 권장.

## 8. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.75b-injection-automation` | Manual Context Injection 누락 evidence 5+ 발생 시 — 자동화 도구 검토 (silent invoke risk 회피 mechanism 포함) |
| `v1.75c-injection-section-helper` | 모듈 CLAUDE.md §section 발췌 자동화 helper 필요 evidence (수동 발췌 비용 누적 시) |
| `v1.75d-module-claude-md-drift-smoke` | 모듈 CLAUDE.md 변경 빈도 + drift evidence 1+ 발생 시 자동 감지 smoke 추가 |

**폐기된 후속** (본 세션 결정):

- ~~`v1.75b~e-module-skills` (P1~P4)~~ — module-skill 패턴 자체 폐기
- ~~`v1.75f-claude-agents-module-matching`~~ — 옵션 X로 충분
- ~~`v1.75g-option-b-revisit`~~ — 옵션 B의 토큰 risk가 옵션 X보다 명확히 열등
- ~~`v1.75h-skill-drift-smoke`~~ — SKILL 폐기로 drift target 부재

## 9. 관련 문서

- 직전 세션 — 모듈 CLAUDE.md 도입: [`../v1.73-nested-claude-md/`](../v1.73-nested-claude-md/)
- 직전 세션 — 3-tier 인프라: [`../v1.74-skills-3-tier-infra/`](../v1.74-skills-3-tier-infra/)
- 모듈 CLAUDE.md 5건: [`../../tests/CLAUDE.md`](../../tests/CLAUDE.md) · [`../../sessions/CLAUDE.md`](../../sessions/CLAUDE.md) · [`../../bootstrap/CLAUDE.md`](../../bootstrap/CLAUDE.md) · [`../../claude/CLAUDE.md`](../../claude/CLAUDE.md) · [`../../bootstrap/skills/CLAUDE.md`](../../bootstrap/skills/CLAUDE.md)
- ROADMAP §3-A trigger: [`../ROADMAP.md`](../ROADMAP.md)
- Sub-agent 스펙: Claude Code Agent tool docs (context7)

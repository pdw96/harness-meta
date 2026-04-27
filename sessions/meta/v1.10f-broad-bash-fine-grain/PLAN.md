# meta v1.10f-broad-bash-fine-grain — PLAN

세션 시작: 2026-04-28
직접 선행 세션:
- [`sessions/meta/v1.10d-bash-permission-pattern-audit/`](../v1.10d-bash-permission-pattern-audit/REPORT.md) — 5축 통합 spec 확정 (`bootstrap/docs/PERMISSION_PATTERN.md`). β scope 5 파일 (1 slash + 4 SKILL) 정정. 발견 6 (3 SKILL broad Bash) + harness-verifier agent 동상 → 본 v1.10f 후속 (D3-b 결정)

목적: v1.10d β scope에서 제외된 **broad `Bash` declare 4 파일**의 frontmatter를 5축 spec(`bootstrap/docs/PERMISSION_PATTERN.md`)에 정합. SKILL 본문의 실 Bash 사용 분석 후 (a) declare 제거 (사용 0건) / (b) broad 유지 + 형식만 정정 (executor/test_cmd 동적 가변) 분기 적용.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1b(7) — `bootstrap/templates/_base/.claude/skills/{harness, harness-run, harness-ship}/SKILL.md` 3 + `bootstrap/templates/_base/.claude/agents/{harness-verifier, harness-dispatcher, harness-explore, harness-grey-area}.md` 4. 합 **7/7 meta**.
- **T1 경로 다수결** — meta scope 7/7. v1.10d audit/A4 (`audit/A4-policy-decisions.md:107`)가 명시적으로 v1.10f를 **S1b**로 분류 (선례).
- **T4 크로스 커팅** — 본 세션은 **선행 (templates baseline)** 만. deployed projects의 `<proj>/.claude/`는 별도 후행 세션 (각 프로젝트 책임, 본 세션 scope 외).
- **Q4=a 확장 (사용자 확정)** — A6 §2 발견 (3 agent 콤마 위반)은 v1.10d Layer 1B "별건" 재평가 결과. A2 인용 11 (subagent `tools:` array spec) 확보로 해소.

## 배경 — v1.10d 발견 6 + agent 동상

v1.10d audit/A2-pattern-inventory에서 식별:

| 파일 | 현재 frontmatter | 위반 |
|------|----------------|------|
| `bootstrap/templates/_base/.claude/skills/harness/SKILL.md:6` | `allowed-tools: Read, Glob, Grep, Bash, Edit` | A2 콤마 separator + A4 broad `Bash` declare |
| `bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md:5` | `allowed-tools: Read, Glob, Grep, Bash, Edit` | 동상 |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md:5` | `allowed-tools: Read, Glob, Grep, Bash, Edit(phases/**), Write(phases/**)` | A2 콤마 + A4 broad `Bash` |
| `bootstrap/templates/_base/.claude/agents/harness-verifier.md:4` | `tools: Read, Glob, Grep, Bash` | A2 콤마 + A4 broad `Bash` |

**v1.10d β 처리 정합 (회복)**:
- v1.10d β scope 4 파일 (`harness-design/`, `harness-plan/`, `harness-review/` SKILL + `harness-meta.md` slash command) — 콤마 → YAML list + Bash 자동 허용 set declare 제거 완료
- 본 v1.10f가 **나머지 4 파일**을 동일 spec으로 정합 → templates baseline 전체 5축 통합 완성

## 본문 Bash 사용 inventory (audit/A1)

| 파일 | 본문 Bash 호출 | 사용 패턴 |
|------|---------------|-----------|
| `harness/SKILL.md` | **없음** (Read·Grep·Glob만) | 디스패처 라우팅 — 상태 판단만 |
| `harness-run/SKILL.md` | `{executor} {phase} --dry-run` / `--push-per-step` / `--reset-step N` / `--from-step N` / `--status` | `.harness.toml [harness].executor` 동적 (Python/Node/Go/Rust) |
| `harness-ship/SKILL.md` | `{test_cmd}` / `{type_check_cmd}` / `{lint_cmd}` / `git add/commit/checkout/pull/merge/push/branch -d` | `.harness.toml [testing]` 동적 + git write forms |
| `harness-verifier.md` | (제안만, 실 실행 안 함) `Glob`, `Grep` 명시. `Bash`는 호출 contract 외 — agent는 read-only analytical | 본문상 Bash 직접 호출 0건 (Grep/Glob tool 호출만). 단 미래 4-Functional 단계 확장 가능성 고려 |

## 결정 (Q1=B, Q2=A, Q3=A — 사용자 확정)

### R1 — 처리 대상 (Q1=B)

**4 파일** (3 SKILL + 1 agent). harness-verifier 동상 처리 — frontmatter 일관성 + v1.10d audit 분류 완료.

### R2 — `harness/SKILL.md` (Q2=A)

본문 Bash 사용 0 → **declare 완전 제거**. 자동 허용 set (`ls`/`cat`/`grep` 등 12 명령)만으로 디스패처 동작 가능.

```yaml
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit
```

### R3 — `harness-run` / `harness-ship` (Q3=A)

`{executor}` / `{test_cmd}` / `{type_check_cmd}` / `{lint_cmd}`이 매니페스트별 동적 가변 (Python `python3 scripts/execute.py` / Node `pnpm tsx scripts/execute.ts` / Go `go run ./cmd/execute` / Rust `./target/release/execute`). argument fine-grain 시도는 **R3' Conservative (PERMISSION_PATTERN.md §6 fragile pattern)** 위반.

→ **broad `Bash` 유지 + YAML list 형식 정정** (콤마 → list).

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

⚠️ `Bash` parens 없음 = `Bash(*)`와 동등 (PERMISSION_PATTERN.md §4 매트릭스). git write forms (add/commit/push) 등 destructive 명령은 prompt 의존 (사용자 환경 settings.json에서 별도 deny rule 가능).

### R4 — `harness-verifier.md` (agent)

본문 Bash 직접 호출 0이지만 contract상 `tools:` 필드 (subagent — `allowed-tools:` 아님, A1 인용 10). 미래 4-Functional 단계 확장 시 Bash 필요 가능성 → **broad `Bash` 유지 + YAML list 정정**.

```yaml
tools:
  - Read
  - Glob
  - Grep
  - Bash
```

### R5 — `Edit` declare 검증

`harness/SKILL.md` 본문에 Edit 사용 사례 0 (디스패처). 그러나 v1.8b commands → skills 마이그레이션 시 원본에서 보존 — **유지**. (declare 제거 = baseline 폴백 prompt이므로 안전 default. 사용자 dispatcher가 Edit 행동하면 prompt — 의도와 정합)

## 변경 대상 (7 수정 + 9 신규 = 16 파일)

### 수정 (7)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/templates/_base/.claude/skills/harness/SKILL.md` | S1b | R2 — `Bash` declare 제거 + YAML list (5 → 4 entries) |
| `bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md` | S1b | R3 — broad `Bash` 유지 + YAML list (콤마 → list) |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md` | S1b | R3 — broad `Bash` 유지 + YAML list. `Edit(phases/**)` / `Write(phases/**)` fine-grain 보존 |
| `bootstrap/templates/_base/.claude/agents/harness-verifier.md` | S1b | R4 — `tools:` 필드 broad `Bash` 유지 + YAML list |
| `bootstrap/templates/_base/.claude/agents/harness-dispatcher.md` | S1b | **R6 (Q4=a)** — `tools:` 필드 콤마 → YAML list (Bash declare 무, 단순 형식 정정) |
| `bootstrap/templates/_base/.claude/agents/harness-explore.md` | S1b | **R6 (Q4=a)** — 동상 |
| `bootstrap/templates/_base/.claude/agents/harness-grey-area.md` | S1b | **R6 (Q4=a)** — 동상 |

### 신규 (9)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-broad-bash-fine-grain.sh` | S2 | 6 stage smoke (V1+V5+V8+V9 + 본문 Bash 사용 검증 + R2 declare 제거 회귀) |
| `sessions/meta/v1.10f-broad-bash-fine-grain/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10f-broad-bash-fine-grain/REPORT.md` | meta | (Stage F 후 작성) |
| `sessions/meta/v1.10f-broad-bash-fine-grain/audit/A1-bash-usage.md` | meta | 본문 Bash 호출 inventory (4 파일별 line:context evidence + AUTO/WRITE/DYN/DOC 분류 + 동적 변수 매핑) |
| `sessions/meta/v1.10f-broad-bash-fine-grain/audit/A2-anthropic-docs.md` | meta | Anthropic docs cross-ref (인용 11-15 신규 — subagent `tools:` array + broad `Bash(*)` 명시 + plugin-dev vs skills docs conflict 해결) |
| `sessions/meta/v1.10f-broad-bash-fine-grain/audit/A3-dynamic-vars.md` | meta | 4 동적 변수 × 5+ 언어 × 13+ PM 매트릭스 + fine-grain 시도 fragile evidence + git ops 옵션 위치 변경 분석 |
| `sessions/meta/v1.10f-broad-bash-fine-grain/audit/A4-policy-decisions.md` | meta | R1-R5 결정 5요소 구조 (결정/근거/인용/회귀/패턴) + Grey 3건 + scope 매트릭스 (포함 5 + 제외 6) |
| `sessions/meta/v1.10f-broad-bash-fine-grain/audit/A5-regression-risk.md` | meta | 3 시나리오 회귀 분석 (신규/deployed/v1.10d) + cross-platform OS 차이 + smoke 6 stage 정당화 + 시그널 모니터링 4건 |
| `sessions/meta/v1.10f-broad-bash-fine-grain/audit/A6-frontmatter-cross-validation.md` | meta | 4 파일 frontmatter 전체 필드 + 추가 발견 5건 (3 agent 콤마 위반 — Q4) + subagent isolated context safety + install-project-claude `cp -r` 동작 + settings.json 상호작용 + 4 형식 separator 매트릭스 (인용 16-18 신규) |
| `sessions/meta/v1.10f-broad-bash-fine-grain/evidence/smoke-broad-bash-fine-grain.txt` | meta | smoke 실행 결과 |

## 목표

- [x] 세션 디렉토리 생성 (`sessions/meta/v1.10f-broad-bash-fine-grain/{audit,evidence}/`)
- [x] **PLAN.md 초안 작성** (본 파일)
- [x] **Stage A — audit 6 파일 작성** (디테일 분석 v1.10d 수준)
  - A1 — 4 파일 본문 Bash 호출 inventory (line:context evidence + AUTO/WRITE/DYN/DOC 분류)
  - A2 — Anthropic docs cross-ref (인용 11-15 신규 + plugin-dev vs skills docs conflict 해결)
  - A3 — 동적 변수 매트릭스 (4 변수 × 5+ 언어 × 13+ PM + fragile evidence)
  - A4 — 정책 결정 R1-R5 5요소 구조 + Grey 3건 + scope 매트릭스
  - A5 — 회귀 위험 (3 시나리오 + cross-platform + smoke 6 stage 정당화 + 시그널 4건)
  - **A6 — Frontmatter cross-validation** (전체 필드 inventory + **추가 발견 5건** — 3 agent 콤마 + isolated context safety + install-project-claude `cp -r` + settings.json 상호작용 + 4 형식 매트릭스 + 인용 16-18 신규)
- [ ] **사용자 Q4 결정 + audit 검토 후 Stage B 진행** ← 진행 대기
- [ ] **Stage B — 7 파일 frontmatter 정정**
  - `harness/SKILL.md` — Bash declare 제거 + YAML list (R2)
  - `harness-run/SKILL.md` — broad Bash 유지 + YAML list (R3)
  - `harness-ship/SKILL.md` — broad Bash 유지 + YAML list, Edit/Write fine-grain 보존 (R3+R5)
  - `harness-verifier.md` — broad Bash 유지 + YAML list, `tools:` 필드 (R4)
  - `harness-dispatcher.md` — `tools:` 콤마 → YAML list, Bash declare 무 (R6)
  - `harness-explore.md` — 동상 (R6)
  - `harness-grey-area.md` — 동상 (R6)
- [ ] **Stage C — Smoke**
  - `tests/smoke-broad-bash-fine-grain.sh` 6 stage:
    - Stage 1 — V8 (A2): **7 파일** single-line 콤마 separator 잔존 0
    - Stage 2 — V9 (A2): 7 파일 YAML list `^  - ` 라인 ≥3
    - Stage 3 — R2 검증: `harness/SKILL.md`에 `Bash` declare 부재
    - Stage 4 — R3/R4 검증: `harness-run`/`harness-ship`/`harness-verifier`에 broad `Bash` (parens 없음) 존재
    - Stage 5 — V5 (A4): 7 파일 자동 허용 set declare 잔존 0
    - Stage 6 — Field name (A1): 3 SKILL `allowed-tools:` + 4 agent `tools:` 정합 (R6 — 3 agent Bash 부재 추가 검증)
- [ ] **Stage D — 회귀 검증**
  - 기존 `tests/smoke-bash-permission-pattern.sh` 6 stage PASS 유지 (β scope 변경 없음)
- [ ] **Stage E — 문서 정합**
  - `bootstrap/docs/PERMISSION_PATTERN.md` §8 harness-meta 정책 표 갱신 (4 파일 추가)
  - `CLAUDE.md` 최신 meta 세션 링크 갱신
  - `README.md` 세션 목록 갱신
- [ ] **Stage F — REPORT.md 작성**
- [ ] **사용자 확인 후 단일 커밋 + push**

## 추가 결정 포인트 (사용자 Q4 — A6 §7 발견)

**Q4 — 3 agent 콤마 separator 정정 확장 여부**:

A6 §2 추가 발견: `harness-dispatcher.md` / `harness-explore.md` / `harness-grey-area.md` 3 agent도 `tools: Read, Glob, Grep` 콤마 separator 위반 (v1.10d Layer 1B "별건" 처리). v1.10d 당시 "subagent docs 별도 — spec 미확인" 상태였으나, **본 v1.10f A2 인용 11 (subagent `tools:` array 형식 spec 명시)** 확보로 해소.

| 후보 | 변경 추가 | audit 추가 | smoke 영향 | 평가 |
|------|:---:|:---:|---|------|
| (a) **확장** — 3 agent도 콤마 → YAML list (Bash declare 무변경) | +3 파일 (frontmatter only) | 0 (A6 §2 분석 완료) | Stage 1/6 검증 파일 4 → 7 | 일관성 ✓ + 단일 커밋 ✓ + scope creep 0 |
| (b) 본 v1.10f 4 파일 한정 | 0 | 0 | 0 | 단일 책임 (broad Bash) 유지 / 6 agent 중 3개만 처리 분기 |

**권장 (a)**: 확장. agent 동상 동시 처리 + audit/smoke 영향 미미.

## Grey Areas — audit/A2에서 확정 예정

| ID | 질문 | 후보 |
|----|------|------|
| **G1** | `harness/SKILL.md`의 `Edit` declare 처리 | (a) **유지 (디스패처가 미래 안내 Edit 가능성)** ✓ / (b) 제거 (본문 사용 0) |
| **G2** | `harness-verifier.md` 본문 Bash 0인데 `Bash` 유지? | (a) **유지 (4-Functional 단계 미래 확장)** ✓ / (b) 제거 (현 시점 사용 0) |
| **G3** | `harness-ship/SKILL.md`의 `Edit(phases/**)` / `Write(phases/**)` fine-grain | (a) **유지 (REPORT.md 등 phases/ 이외 쓰기 prompt 강제 — 안전)** ✓ / (b) 단순화 (broad Edit/Write) |

## 성공 기준

- [x] audit/A1-A6 6 파일 작성
- [ ] 7 파일 frontmatter 정정 (콤마 → YAML list + R2/R3/R4/R6 적용)
- [ ] `tests/smoke-broad-bash-fine-grain.sh` 6/6 PASS (검증 파일 7)
- [ ] 기존 `tests/smoke-bash-permission-pattern.sh` 6/6 회귀 PASS
- [ ] `evidence/smoke-broad-bash-fine-grain.txt` 저장
- [ ] `bootstrap/docs/PERMISSION_PATTERN.md` §8 갱신 (7 파일 정책 추가)
- [ ] `CLAUDE.md` / `README.md` 정합 갱신
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 4 파일 frontmatter / smoke / PERMISSION_PATTERN.md 정합 깨짐.

```
feat(meta): sessions/meta/v1.10f-broad-bash-fine-grain — templates 7 파일 5축 정합 (broad Bash + 3 agent 콤마)

- update: bootstrap/templates/_base/.claude/skills/harness/SKILL.md (R2 — Bash declare 제거 + YAML list)
- update: bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md (R3 — broad Bash 유지 + YAML list)
- update: bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md (R3 — broad Bash 유지 + YAML list, Edit/Write fine-grain 보존)
- update: bootstrap/templates/_base/.claude/agents/harness-verifier.md (R4 — tools: broad Bash + YAML list)
- update: bootstrap/templates/_base/.claude/agents/harness-dispatcher.md (R6 — tools: 콤마 → YAML list)
- update: bootstrap/templates/_base/.claude/agents/harness-explore.md (R6 — 동상)
- update: bootstrap/templates/_base/.claude/agents/harness-grey-area.md (R6 — 동상)
- add: tests/smoke-broad-bash-fine-grain.sh (6 stage, 7 파일 검증)
- update: bootstrap/docs/PERMISSION_PATTERN.md §8 정책 표 (7 파일 추가)
- add: sessions/meta/v1.10f-broad-bash-fine-grain/{PLAN,REPORT,audit/A1-A6,evidence/1 파일}

v1.10d β scope (4 파일) 처리 후 발견 6 (3 SKILL broad Bash) + harness-verifier agent 동상 + Q4=a 확장 (3 agent 콤마):
- harness/SKILL.md: Bash 본문 사용 0 → declare 제거 (자동 허용 set으로 충분)
- harness-run/harness-ship: executor/test_cmd 동적 → broad 유지 + 형식만 정정 (R3' Conservative)
- harness-verifier: 4-Functional 미래 확장 + isolated context safety 대비 broad 유지
- harness-dispatcher/explore/grey-area: v1.10d Layer 1B "별건" 재평가 — A2 인용 11 (subagent tools: array spec) 확보로 콤마 → YAML list 정정

templates baseline 전체 (11 파일 — 4 v1.10d β + 7 v1.10f) 5축 통합 완성.

Smoke 6/6 + 회귀 v1.10d 6/6 PASS.
```

## 후속 세션 연결

### 직접 연계 (각자 책임 — 본 v1.10f scope 외)

- **deployed projects** — 각 프로젝트 자기 `.claude/`의 동일 정정 (S6, T4 후행). meta repo 책임 아님.

### Lessons Forward (예상)

1. **β + 발견 6 분리 → 단일 책임 유지** — v1.10d 5축 spec 확정 + β 4 파일 정정. v1.10f가 발견 6 + agent 동상 처리. 분리하지 않으면 v1.10d audit 5 + 정정 8 파일 + smoke 12 stage = scope creep
2. **broad 유지 정당화 패턴** — 동적 가변 명령(`{executor}`, `{test_cmd}`)은 fine-grain 시도가 R3' Conservative 위반. broad + YAML list는 spec 정합이면서 prompt fallback 의존
3. **subagent `tools:` 필드 별도 처리** — A1 매트릭스 (slash command/skill = `allowed-tools:` / agent = `tools:`) — agent를 SKILL과 같은 처리로 묶지 말고 분리
4. **templates baseline 완성도 — 8 파일 5축 통합** — v1.10d (4) + v1.10f (4) = templates 전체. 새 프로젝트 bootstrap 시 frontmatter 결함 0으로 출발

# meta v1.71-fix-model-effort-insert — PLAN

세션 시작: 2026-05-05
직접 선행 세션: [`sessions/meta/v1.61-fix-thinking-effort/`](../v1.61-fix-thinking-effort/REPORT.md) — V10 line-delete `--fix` (R1/R2/R3/R4 frontmatter 구조 삽입은 본 v1.71로 분리)

목적: `tests/smoke-thinking-effort.sh --fix`에 R1/R2/R3/R4 (model+effort frontmatter 구조 삽입) auto-fix 추가. v1.61에서 line-delete만 처리한 V10 외에 frontmatter 필드 insert/replace 4종 보강.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(1) `tests/smoke-thinking-effort.sh` (수정) + session docs 2건 = **전부 meta scope**
- T1 경로 다수결 — S3 전체

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.61-fix-thinking-effort/REPORT.md` Out of scope (verbatim)**:

> R1 (`^model: sonnet$`) / R2/R3/R4 (`^effort: xhigh$` / `^model: opus$`) — frontmatter 구조 삽입 위치 결정 필요 (--- 사이) → v1.61b 후속

**Parsed sub-items (4)**:

1. **R1 — slash command `model: sonnet`** insert/replace into `claude/commands/harness-meta.md` frontmatter
2. **R1' — slash command `effort:` 부재** 보장 (잔존 시 line-delete)
3. **R2 — 3 opus SKILL `effort: xhigh`** insert/replace into frontmatter
4. **R3 — 3 opus SKILL `model: opus`** insert/replace into frontmatter

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
| ------- | --------- |
| Stage 5 V1/V5/V8/V9 cross-session auto-fix | v1.60 smoke-bash-permission-pattern과 중복. 별 후속 |
| frontmatter 부재 파일 자동 frontmatter 생성 | 사용자 수동 (frontmatter 부재 = 별도 정책 검토 필요) |
| `disable-model-invocation` 같은 다른 frontmatter 필드 auto-fix | evidence-driven 후속 |

## Spec verification (context7)

| sub-field | 값 |
| ----------- | --- |
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 외부 spec 의존 없음 |
| **re-verify** | N/A |

## 1. 설계

### 1-1. 대상 4 파일 + 기대값

| 파일 | 기대 model | 기대 effort |
| --- | --- | --- |
| `claude/commands/harness-meta.md` | `sonnet` | (부재) |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | `opus` | `xhigh` |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | `opus` | `xhigh` |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md` | `opus` | `xhigh` |

### 1-2. Auto-fix 알고리즘 (Python 위임)

bash sed로 frontmatter 구조 변환은 fragile (closing `---` 위치 추적 어려움) → Python `pathlib` + 단순 line-by-line 처리로 위임:

```
for each file:
  read lines
  detect frontmatter range (line 0 = '---', find next '---')
  for each (field, expected_value):
    if field exists in frontmatter:
      if value != expected: replace line
      if expected is None and field exists: delete line
    else:
      if expected is not None: insert before closing '---'
  write back
```

핵심:

- frontmatter 첫 라인은 `---` (전제 — 부재 시 skip + WARN)
- closing `---`은 첫 `---` 이후 첫 `^---$` 라인
- 삽입 위치: closing `---` 직전 (effort/model 묶음으로 끝에 배치)

### 1-3. argv 추가

기존 v1.61 argv 구조에 변경 없음. `--fix` block 안에서 V10 처리 후 R1/R2/R3 처리 추가.

### 1-4. dry-run 출력

```
  [would fix R1] claude/commands/harness-meta.md: insert 'model: sonnet'
  [would fix R2] bootstrap/.../harness-design/SKILL.md: replace 'effort: high' → 'effort: xhigh'
  [would fix R3] bootstrap/.../harness-plan/SKILL.md: insert 'model: opus'
```

## 2. 변경 대상 (1 수정 + 2 session docs)

| 경로 | 변경 |
| --- | --- |
| `tests/smoke-thinking-effort.sh` | `--fix` block에 R1/R2/R3 처리 추가 (Python heredoc) |
| `sessions/meta/v1.71-.../PLAN.md` | 본 파일 |
| `sessions/meta/v1.71-.../REPORT.md` | 구현 후 작성 |

## 3. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 확인**
- [ ] `tests/smoke-thinking-effort.sh --fix` block에 Python 위임 R1/R2/R3 추가
- [ ] default 5/5 PASS (회귀 0)
- [ ] `--fix --dry-run` plan 출력 + Stage skip
- [ ] E2E 시나리오: 4 violation (R1+R1'+R2+R3) 주입 → `--fix` → 자동 정정 + 5/5 PASS
- [ ] REPORT.md 작성
- [ ] ROADMAP 갱신
- [ ] 사용자 확인 후 커밋

## 4. 성공 기준

- [ ] default 5/5 PASS (회귀 0)
- [ ] `--fix` 후 violation 0 + 5/5 PASS
- [ ] `--fix --dry-run` 변경 없이 plan 출력
- [ ] E2E: model 위반 주입 → `--fix` → 정정
- [ ] E2E: effort 위반 주입 → `--fix` → 정정
- [ ] E2E: 필드 부재 주입 → `--fix` → 삽입

## 5. 커밋 전략

```
feat(meta): sessions/meta/v1.71-fix-model-effort-insert — R1/R2/R3 auto-fix 추가

- update: tests/smoke-thinking-effort.sh
  * --fix block에 R1/R2/R3 처리 추가 (Python heredoc 위임)
  * R1: slash command model: sonnet insert/replace + effort: 잔존 line-delete
  * R2: 3 opus SKILL effort: xhigh insert/replace
  * R3: 3 opus SKILL model: opus insert/replace
- add: sessions/meta/v1.71-.../{PLAN,REPORT}.md

v1.61 V10 line-delete 패턴 확장 — frontmatter 구조 변환 (insert/replace) 보강.
default 5/5 PASS (회귀 0). E2E 4 시나리오 검증.
```

## 6. 후속 분기

| 후속 세션 | 조건 |
| --- | --- |
| `v1.71b-frontmatter-create` | frontmatter 부재 파일 자동 생성 evidence |
| `v1.71c-other-frontmatter-fields` | `disable-model-invocation` 등 다른 필드 auto-fix evidence |

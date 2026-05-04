# A4 — 정책 결정 (R1/R2/R3) + Grey + Scope

## 1. 결정 요약

| ID | 결정 | 적용 파일 | scope |
|:---:|------|------|:---:|
| **R1** | `harness-meta.md` `model: opus` → `sonnet` + `thinking: high` 라인 제거 | 1 (S1a) | A3 §3 |
| **R2** | 3 opus skill `thinking: high` → `effort: xhigh` (model: opus 유지) | 3 (S1b) | A2 §5 |
| **R3** | PERMISSION_PATTERN.md 5축 → 6축 신설 (A6 model+effort) + V10 검증 추가 | 1 (S2) | 본 §4 |

총 변경 = 4 파일 frontmatter + 1 spec doc + 1 smoke = 6.

## 2. R1 — `harness-meta.md` 정정

### 결정

```diff
 ---
 name: harness-meta
 description: 하네스 자체 개선 또는 프로젝트 부트스트랩 세션 진입점 (글로벌 harness-meta repo 기반)
 argument-hint: "[project-name]"
 allowed-tools:
   - Read
   - Glob
   - Grep
   - Write
   - Edit
   - Bash(mkdir *)
   - Bash(git *)
   - Bash(bash *)
   - Bash(pwsh *)
   - Bash(sed *)
   - Bash(uname *)
   - Bash(mv *)
   - Bash(cp *)
   - Bash(rm *)
-model: opus
-thinking: high
+model: sonnet
 ---
```

### 5요소

| # | 요소 | 내용 |
|:---:|------|------|
| 1 | 결정 | model `opus` → `sonnet` + `thinking: high` 라인 제거 (effort declare 무 — Sonnet 4.6 default `high` inherit) |
| 2 | 근거 | A3 §3-1 책임 분석 (라우팅 중심) + §3-2 v1.10f harness/SKILL.md 선례 + §3-3 비용 5x 절감 |
| 3 | 인용 | A1 인용 19' (`thinking:` 부재) + A2 인용 22 (Sonnet 4.6 default `high`) + A3 §3-2 (선례) |
| 4 | 회귀 | smoke Stage 2 — `model: sonnet` 매치 + `effort:` 부재 + `thinking:` 부재 |
| 5 | 패턴 | "디스패처/세션 진입점 = sonnet + effort declare 무" — v1.10f 선례 정합 |

## 3. R2 — 3 opus skill `effort: xhigh` 명시

### 결정

3 파일 (`harness-design`, `harness-plan`, `harness-ship`) 모두 동일 패턴:

```diff
 ---
 name: harness-{...}
 description: ...
 disable-model-invocation: true
 allowed-tools:
   ...
 model: opus
-thinking: high
+effort: xhigh
 ---
```

### 5요소

| # | 요소 | 내용 |
|:---:|------|------|
| 1 | 결정 | `thinking: high` → `effort: xhigh`. model `opus` 유지 |
| 2 | 근거 | A2 §5 5건 정당화 (Opus 4.7 default 정합 + 권장 사용처 + graceful fallback + 의도 보존 + drift 방지) |
| 3 | 인용 | A1 인용 19' (`effort:` 정식 필드) + A2 인용 19'/20/22/24/25 |
| 4 | 회귀 | smoke Stage 3 — 3 SKILL `effort: xhigh` 매치 + `thinking:` 부재 + Stage 4 `model: opus` 보존 |
| 5 | 패턴 | "복잡 task opus skill = `effort: xhigh` 명시" — Opus 4.7 default 정합 + 모델 이식성 + drift 방지 |

## 4. R3 — PERMISSION_PATTERN.md 6축 확장 + V10

### 결정

`bootstrap/docs/PERMISSION_PATTERN.md`:

- §1 표에 **A6 model+effort** 신설 (5축 → 6축)
- §8 정책 표에 4 파일 (harness-meta + 3 opus skill) model+effort 명시 추가
- §11 표에 **V10** 추가 (`thinking:` 잔존 검사)

### 6축 spec (§1 신설)

| 축 | 결정 | 근거 (인용 #) |
|----|------|----------|
| A1 필드명 | slash command/skill = `allowed-tools:` / subagent = `tools:` | v1.10d 7-8, 10 |
| A2 separator | YAML list (권장) / 공백 inline (대안) / 콤마 (비권장) | v1.10d 7 |
| A3 패턴 형식 | `Bash(cmd *)` 공백 (dialog 표준) — 콜론은 alias | v1.10d 1, 2 |
| A4 redundant | auto-allow set declare 금지 | v1.10d 3 |
| A5 argument fine-grain | Conservative — argument 제약 미시도 | v1.10d 4 |
| **A6 model+effort** (신설) | **책임 기반 model 선택 (디스패처/실행=sonnet / 논의/설계/검증=opus) + opus skill은 `effort: xhigh` 명시 / sonnet skill은 declare 무 (default `high`)** | **v1.10g 19', 20, 21, 22, 24** |

### V10 spec (§11 신설)

```bash
# V10 (A1) — `thinking:` 필드 잔존 검사 (silent ignore 회피)
grep -E '^thinking:' <files>      # 기대 0
```

### 5요소

| # | 요소 | 내용 |
|:---:|------|------|
| 1 | 결정 | PERMISSION_PATTERN.md 6축 확장 + V10 추가 + §8 정책 표 갱신 |
| 2 | 근거 | A1 §3 추정 반증 + A2 §5 정당화 + A3 §8 매트릭스 — 단일 소스 명문화 필요 |
| 3 | 인용 | v1.10g 인용 19', 20, 21, 22, 24, 25 (인용 19'~25 = 7건 신규 또는 재확정) |
| 4 | 회귀 | smoke Stage 5 — V1+V5+V8+V9 (v1.10d/v1.10f) PASS 유지 (frontmatter 추가는 separator/auto-allow 영향 0) |
| 5 | 패턴 | "frontmatter spec audit = 1차 docs fetch 우선 + 6축 매트릭스 단일 소스 + V# smoke 자동화" — v1.10d/v1.10f 패턴 연장 |

## 5. Grey Areas — 결정

### G1 — `harness-meta.md`에 `effort:` 명시 추가?

| 후보 | 평가 |
|------|------|
| (a) **declare 무** (sonnet default `high` inherit) | ✓ **채택** — A2 §6 분석 정합. v1.10f harness/SKILL.md 선례. 라우팅 책임에 충분 |
| (b) `effort: high` 명시 | redundant (Sonnet 4.6 default = `high`). 명시성 ↑ but 라우팅에 과잉 |
| (c) `effort: xhigh` 명시 | Sonnet 4.6 미지원 → graceful fallback `high`. 의도 미달성 + redundant |
| (d) `effort: medium` 강등 | 라우팅엔 충분 but evidence 부재 → 보수적 (a) 채택, 별도 후속 (`v1.10g2-effort-tuning`) |

→ **(a) 채택**.

### G2 — 3 opus skill을 `effort: high` vs `xhigh` vs 차등?

| 후보 | 평가 |
|------|------|
| (a) **모두 `xhigh`** | ✓ **채택** — A2 §5 5건 정당화. Opus 4.7 default 정합 + drift 방지 |
| (b) ship만 `xhigh`, plan/design은 `high` | 책임 차등 — but evidence 부족 (3 skill 모두 복잡 task). 별도 후속 |
| (c) 모두 `high` | Opus 4.7 default(`xhigh`)보다 약함 → 의도 약화 |
| (d) ship만 `max` | overthinking risk + max는 session-only persist 안 함 (인용 22) |

→ **(a) 채택**.

## 6. Scope 매트릭스

### 포함 (4 frontmatter + 9 신규 = 13)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | R1 |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | S1b | R2 |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | S1b | R2 |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md` | S1b | R2 |
| `tests/smoke-thinking-effort.sh` | S2 | 신규 5 stage |
| `bootstrap/docs/PERMISSION_PATTERN.md` | S2 | R3 (6축 + V10 + §8) |
| `CLAUDE.md` | S3 | 최신 meta 세션 링크 갱신 |
| `README.md` | S3 | 세션 목록 갱신 |
| `sessions/meta/v1.10g-skill-thinking-effort/PLAN.md` | meta | (작성됨) |
| `sessions/meta/v1.10g-skill-thinking-effort/REPORT.md` | meta | Stage F |
| `sessions/meta/v1.10g-skill-thinking-effort/audit/A1-A5.md` | meta | (5 파일, 본 A4 포함) |
| `sessions/meta/v1.10g-skill-thinking-effort/evidence/smoke-thinking-effort.txt` | meta | Stage C 결과 |

### 제외 (이유 명시)

| 경로 | 제외 이유 |
|------|-----------|
| `bootstrap/templates/_base/.claude/skills/harness/SKILL.md` | 본문 `thinking:` 부재. model: sonnet 정합 → 변경 0 |
| `bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md` | 동상 — `thinking:` 부재. sonnet 유지 |
| `bootstrap/templates/_base/.claude/agents/harness-{verifier,dispatcher,explore,grey-area}.md` | subagent — `effort:` 지원 (인용 21) but 본 4 agent는 `thinking:` 부재 + model 미명시 (CLAUDE_CODE_SUBAGENT_MODEL env 의존). 변경 0 |
| `bootstrap/templates/_base/.claude/output-styles/harness-engineer.md` | output-style — frontmatter `model:`/`effort:` 무관 |
| deployed projects (`<proj>/.claude/skills/`) | T4 후행 — 각 프로젝트 책임 (sessions/<name>/v1.X-skill-effort-update) |
| upbit settings.json | T4 후행 — sessions/upbit/v1.2 묶음 가능 |

## 7. 변경 비계 — 의존 순서

```
1. audit (A1-A5) 완성  ← Stage A
2. 사용자 audit 검토 + Stage B 승인  ← 진행 게이트
3. Stage B — 4 frontmatter 정정 (R1+R2)
4. Stage C — smoke 5 stage 통과
5. Stage D — 회귀 v1.10d/v1.10f smoke PASS
6. Stage E — PERMISSION_PATTERN.md 6축 + V10 (R3) + CLAUDE.md/README.md 정합
7. Stage F — REPORT.md
8. 단일 커밋 + push  ← 사용자 확인 게이트
```

→ **순서 의존성**: R3 (PERMISSION_PATTERN.md)은 R1+R2 완료 + smoke 통과 후 작성 (정책 표 §8에 정정된 frontmatter snapshot 포함).

## 8. 회귀 영향 매트릭스

| 변경 | v1.10d 5축 정합 | v1.10f 7 파일 정합 | v1.10e3 license | v1.10c install_cmd |
|------|:---:|:---:|:---:|:---:|
| R1 (harness-meta.md) | ✓ (separator/auto-allow 영향 0) | ✓ (별 파일) | — | — |
| R2 (3 SKILL frontmatter) | ✓ (frontmatter 추가만) | ✓ (별 라인) | — | — |
| R3 (PERMISSION_PATTERN.md) | ✓ (6축 = 5축 보존 + 1축 추가) | ✓ (인용 보존) | — | — |

→ **회귀 0 risk**. v1.10d/v1.10f smoke 모두 PASS 유지 예상.

## 9. 결론 요약

- R1 (S1a, 1) + R2 (S1b, 3) + R3 (S2, 1 spec doc) = 5 파일 변경 + 1 smoke 신규 + 5 audit + PLAN/REPORT
- Grey G1=(a) declare 무 / G2=(a) 모두 xhigh — 둘 다 보수적 + evidence 정합
- Scope 매트릭스: 포함 4 frontmatter + 제외 6+ (subagent / sonnet skill / output-style / deployed)
- 회귀 0 risk — frontmatter 추가는 v1.10d/v1.10f spec에 영향 없음
- 단일 커밋 — 부분 적용 시 정책 표 + smoke 정합 깨짐

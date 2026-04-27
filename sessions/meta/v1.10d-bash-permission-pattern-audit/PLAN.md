# meta v1.10d-bash-permission-pattern-audit — PLAN (β scope)

세션 시작: 2026-04-27. 4 dimension 심층 audit + 12 추가 발견 → β scope 확장 (5축 통합 정정)
직접 선행 세션:
- [`sessions/meta/v1.10b-bootstrap-agents-md/`](../v1.10b-bootstrap-agents-md/REPORT.md) — G28 분리 ("context7 공식 sample은 `Bash(cmd:*)` 콜론. PLAN v1.10은 `Bash(cmd*)` 콜론 없음. 별도 chore 세션 v1.10d-bash-permission-pattern-audit에서 검증·정정")
- [`sessions/meta/v1.10c-bootstrap-content-defaults/`](../v1.10c-bootstrap-content-defaults/REPORT.md) — install_cmd 17 PM 매핑 (병렬 후속)

목적: harness-meta source-of-truth 5 파일 (1 slash command + 4 SKILL)의 frontmatter를 Anthropic 공식 spec 정합으로 통합 정정. 5축 (필드명 + separator + pattern + redundant + argument-fine-grain) 통합. 단일 소스 doc `bootstrap/docs/PERMISSION_PATTERN.md` 신규.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1a(1) — `claude/commands/harness-meta.md`. S1b(3) — `_base/.claude/skills/{harness-design,harness-plan,harness-review}/SKILL.md`. S2(1 신규 + 1 갱신) — `bootstrap/docs/PERMISSION_PATTERN.md` 신규 + `bootstrap/docs/OWNERSHIP.md` Evolution 1줄. S3(2) — `CLAUDE.md` / `README.md`. 합 **8/8 meta**.
- **T1 경로 다수결** — meta scope 8/8.
- **T4 크로스 커팅 분할** — upbit deployed 6 SKILL + `settings.json` 36 패턴은 후행 `sessions/upbit/v1.2-bash-permission-update/`. 본 v1.10d는 선행 (spec).

## β scope 결정 — 12 발견 종합

기존 α scope (콜론 + redundant 16 → 10)에서 다음 12 발견으로 β scope 확장:

| 발견 | 영향 | β scope 반영 |
|------|------|-------------|
| 발견 1 (`allowed-tools` semantics) | mental model 정정 | A3 표현 정확화 |
| 발견 2 (`tools:` 필드명 위반) | `harness-meta.md` declare silent ignore 가능 | **A1 정정 — `allowed-tools:` (R6')** |
| 발견 3 (콤마 separator 모호) | 5 파일 declare 무효 가능 | **A2 정정 — YAML list (R7')** |
| 발견 4 (format dominant 변화) | 콜론 → 공백 dominant | **R1' revised — 공백 형식** |
| 발견 5 (body bash injection 0) | frontmatter declare가 유일 메커니즘 | A2 critical 강화 |
| 발견 6 (3 SKILL broad Bash) | scope 외 | **별도 후속 v1.10f** |
| 발견 7 (disable-model-invocation 정합) | 변경 없음 | — |
| 발견 8 (agent frontmatter 정합) | subagent `tools:` ✓ | — |
| 발견 9 (Skill 호출 차단 별도) | scope 외 | — |
| 발견 10 (콜론 trailing-only) | 콜론 alias이지만 minor | R1' 결정 강화 |
| 발견 11 (Skill content lifecycle) | 정정 영향 세션 전체 | risk 평가 |
| 발견 12 (thinking vs effort) | 별건 | **별도 후속 v1.10g** |

→ **β scope: 5축 통합 정정 (5 파일)**. α scope (16 → 10) 포함 + A1 (필드명) + A2 (separator) 추가.

## 5축 통합 정정 매트릭스 (Stage B — β scope)

A3 결과:

### `claude/commands/harness-meta.md:5` (slash command, A1+A2+A3+A4 모두)

```diff
-tools: Read, Glob, Grep, Write, Edit, Bash(ls*), Bash(mkdir*), Bash(git*), Bash(bash*), Bash(pwsh*), Bash(grep*), Bash(sed*), Bash(uname*), Bash(mv*), Bash(cp*), Bash(rm*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
+  - Write
+  - Edit
+  - Bash(mkdir *)
+  - Bash(git *)
+  - Bash(bash *)
+  - Bash(pwsh *)
+  - Bash(sed *)
+  - Bash(uname *)
+  - Bash(mv *)
+  - Bash(cp *)
+  - Bash(rm *)
```

### `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md:5` (A2+A3+A4)

```diff
-allowed-tools: Read, Glob, Grep, Write(phases/**), Edit(phases/**), Bash(ls*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
+  - Write(phases/**)
+  - Edit(phases/**)
```

### `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md:6` (A2+A3+A4)

```diff
-allowed-tools: Read, Glob, Grep, Write(phases/**/PLAN.md), Edit(phases/**/PLAN.md), Bash(ls*), Bash(mkdir*), Bash(wc*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
+  - Write(phases/**/PLAN.md)
+  - Edit(phases/**/PLAN.md)
+  - Bash(mkdir *)
```

### `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md:5` (A2+A3+A4)

```diff
-allowed-tools: Read, Glob, Grep, Bash(git*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
```

**합계**: 5 파일 frontmatter 재작성. 16 Bash 패턴 → 9. A1 위반 1건 정정 + A2 위반 4건 정정 + A3 9건 공백화 + A4 7건 redundant 제거.

## R1'-R7' 결정 (audit/A4 채택)

| ID | 결정 | 근거 인용 | 변화 (vs α) |
|----|------|----------|:----------:|
| R1' (REVISED) | 공백 형식 (콜론 폐기) | A1 인용 1, 2, 7 | revised |
| R2' | redundant 제거 (-6건) | A1 인용 3 | 변경 없음 |
| R3' | Conservative | A1 인용 4 | 변경 없음 |
| R4' | T4 후행 분리 | OWNERSHIP T4 | 변경 없음 |
| R5' | PERMISSION_PATTERN.md (확장 ~140-160 라인) | bootstrap/docs/* 패턴 | 확장 |
| R6' (NEW) | 필드명 `tools:` → `allowed-tools:` | A1 인용 7-8 | NEW |
| R7' (NEW) | 콤마 → YAML list (5 파일) | A1 인용 7 | NEW |

## 목표

- [x] **audit/ 5 파일 작성** (Stage A 완료, β scope 갱신)
  - [x] A1-anthropic-docs.md (Anthropic 공식 11 quotes verbatim — A1 인용 1-11)
  - [x] A2-pattern-inventory.md (Layer 1A 5축 통합표 + Layer 1B/1C + 2/3/4/5)
  - [x] A3-redundancy-analysis.md (5축 통합 정정 매트릭스 + 의미 변화 검증)
  - [x] A4-policy-decisions.md (R1'-R7' 채택 근거 + 별도 후속 세션 link)
  - [x] A5-regression-risk.md (5축 risk matrix + V1-V9 검증 항목)

- [ ] **Stage B — frontmatter 5축 통합 정정 (5 파일)**
  - [ ] `claude/commands/harness-meta.md:5` (A1+A2+A3+A4 — `tools:` → `allowed-tools:` YAML list, 11 → 9)
  - [ ] `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md:5` (A2+A3+A4 — Bash 통째 제거 + YAML list)
  - [ ] `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md:6` (A2+A3+A4 — 3 → 1 + YAML list)
  - [ ] `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md:5` (A2+A3+A4 — Bash 통째 제거 + YAML list)

- [ ] **Stage C — `bootstrap/docs/PERMISSION_PATTERN.md` 신규 작성** (~140-160 라인, 10 §)
  - § 1. 결정 / § 2. 필드명 매트릭스 / § 3. Separator / § 4. 형식 매트릭스 / § 5. 자동 허용 set / § 6. fragile / § 7. compound + wrapper / § 8. harness-meta 정책 / § 9. settings 마이그레이션 / § 10. verify

- [ ] **Stage D — Documentation 정합**
  - [ ] `CLAUDE.md` "최신 meta 세션" v1.10c → v1.10d
  - [ ] `README.md` 동상
  - [ ] `bootstrap/docs/OWNERSHIP.md` Evolution 조항 v1.10d 1줄

- [ ] **Stage E — Smoke**
  - [ ] `tests/smoke-bash-permission-pattern.sh` 신규 (V1+V5+V7+V8+V9 5 stage)
  - [ ] `evidence/smoke-bash-permission-pattern.txt`

- [ ] **REPORT.md** 작성 (사용자 사이드 dynamic 검증 V3 항목 포함)

- [ ] **사용자 확인 후 단일 커밋** + push

## 범위

**포함** (β scope):
- 5 파일 frontmatter 5축 통합 정정 (16 → 9 Bash 패턴 + A1/A2 통합)
- 공백 형식 + YAML list 채택 (R1' revised + R7')
- 필드명 정정 (R6')
- Redundant declare 제거 (R2')
- Conservative 정책 (R3')
- 단일 소스 doc PERMISSION_PATTERN.md (R5' 확장)
- audit evidence 5 파일 (A1-A5)
- smoke 5 stage

**제외** (이연):
- **3 SKILL broad `Bash` declare** (`harness/`, `harness-run/`, `harness-ship/`) — 별도 후속 `v1.10f-broad-bash-fine-grain` (D3-b)
- **`thinking:` vs `effort:` 필드 검증** — 별도 후속 `v1.10g-skill-thinking-effort` (D4)
- **upbit deployed SKILL + settings.json 정정** — `sessions/upbit/v1.2-bash-permission-update/` T4 후행 (R4')
- **글로벌 `~/.claude/settings.json` / dowon_trading / price-compare** — 이미 정합, 변경 없음
- **PreToolUse hook 도입** — fragile 패턴 대안. v1.21+ cross-platform-install
- **subagent `tools:` 콤마 separator 검증** — agent 4 파일 spec 별건. 별도 검증 (subagent docs)

## 변경 대상 (8 파일)

### 신규 (5 + 1 + 5 + 1 = 12 파일)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/docs/PERMISSION_PATTERN.md` | S2 | 단일 소스 doc (R5' 확장 — 5축) |
| `tests/smoke-bash-permission-pattern.sh` | S2 | V1+V5+V7+V8+V9 grep smoke |
| `sessions/meta/v1.10d-bash-permission-pattern-audit/{PLAN,REPORT}.md` | meta | 본 세션 |
| `sessions/meta/v1.10d-bash-permission-pattern-audit/audit/{A1-A5}.md` | meta | evidence 5 파일 |
| `sessions/meta/v1.10d-bash-permission-pattern-audit/evidence/smoke-bash-permission-pattern.txt` | meta | smoke 결과 |

### 수정 (7 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | L5 frontmatter 5축 통합 — `tools:` → `allowed-tools:` YAML list, 11 → 9 |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | S1b | L5 frontmatter — YAML list, Bash 통째 제거 |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | S1b | L6 frontmatter — YAML list, 3 → 1 |
| `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md` | S1b | L5 frontmatter — YAML list, Bash 통째 제거 |
| `bootstrap/docs/OWNERSHIP.md` | S2 | Evolution 조항 v1.10d 1줄 (S1a+S1b+S2 cross-cutting precedent) |
| `CLAUDE.md` | S3 | "최신 meta 세션" v1.10c → v1.10d |
| `README.md` | S3 | 동상 |

## smoke 설계 (`tests/smoke-bash-permission-pattern.sh`)

```bash
#!/usr/bin/env bash
set -euo pipefail
HARNESS_META_ROOT="${HARNESS_META_ROOT:-$HOME/harness-meta}"
cd "$HARNESS_META_ROOT"

FILES=(
  "claude/commands/harness-meta.md"
  "bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md"
  "bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md"
)

# Stage 1 — V1 (A3): 콜론 없는 Bash(\w+\*) 잔존 0 (공백 형식 채택)
echo "=== Stage 1 — V1 (A3) Pattern format (공백 형식) ==="
no_colon=0
for f in "${FILES[@]}"; do
    n=$(grep -cE 'Bash\([a-z][a-z\-]*\*\)' "$f" || true)
    echo "  $f: $n"
    no_colon=$((no_colon + n))
done
[ "$no_colon" -eq 0 ] || { echo "FAIL — V1 콜론 없음 패턴 $no_colon건 잔존"; exit 1; }
echo "PASS — V1 0건"

# Stage 2 — V5 (A4) Redundancy: 자동 허용 set declare 잔존 0
echo ""
echo "=== Stage 2 — V5 (A4) Redundancy ==="
auto_set='Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)'
redundant=0
for f in "${FILES[@]}"; do
    n=$(grep -cE "$auto_set" "$f" || true)
    echo "  $f: $n"
    redundant=$((redundant + n))
done
[ "$redundant" -eq 0 ] || { echo "FAIL — V5 자동 허용 declare $redundant건"; exit 1; }
echo "PASS — V5 0건"

# Stage 3 — V7 (A1) Field name: harness-meta.md는 allowed-tools:
echo ""
echo "=== Stage 3 — V7 (A1) Field name ==="
SLASH="claude/commands/harness-meta.md"
grep -qE '^allowed-tools:' "$SLASH" || { echo "FAIL — $SLASH 'allowed-tools:' 부재"; exit 1; }
grep -qE '^tools:' "$SLASH" && { echo "FAIL — $SLASH 'tools:' 잔존 (should be allowed-tools)"; exit 1; }
echo "PASS — V7 (A1) allowed-tools: 정합"

# Stage 4 — V8 (A2) Separator: 콤마 형식 single-line allowed-tools 잔존 0
echo ""
echo "=== Stage 4 — V8 (A2) Separator (YAML list) ==="
for f in "${FILES[@]}"; do
    # single-line `allowed-tools: ...,` 또는 `tools: ...,` 잔존 검사
    grep -qE '^(allowed-tools|tools):.+,' "$f" && { echo "FAIL — $f single-line 콤마 separator 잔존"; exit 1; } || true
done
echo "PASS — V8 single-line 콤마 0건"

# Stage 5 — V9 (A2) YAML list 형식: ^allowed-tools:\s*$ 다음 ^  - 라인
echo ""
echo "=== Stage 5 — V9 (A2) YAML list 형식 ==="
for f in "${FILES[@]}"; do
    if grep -qE '^allowed-tools:\s*$' "$f"; then
        # YAML list 시작 발견 — 다음 라인이 '  - '으로 시작
        n=$(awk '/^allowed-tools:[[:space:]]*$/{flag=1; next} flag && /^  - /{count++} flag && !/^  - /{flag=0} END{print count}' "$f")
        echo "  $f: $n YAML list 항목"
        [ "$n" -ge 3 ] || { echo "FAIL — $f YAML list 항목 부족"; exit 1; }
    else
        echo "FAIL — $f YAML list 형식 부재"; exit 1
    fi
done
echo "PASS — V9 YAML list 형식 정합"

# Stage 6 — V4 PERMISSION_PATTERN.md 검증
echo ""
echo "=== Stage 6 — V4 PERMISSION_PATTERN.md ==="
DOC="bootstrap/docs/PERMISSION_PATTERN.md"
[ -f "$DOC" ] || { echo "FAIL — $DOC 부재"; exit 1; }
KEYWORDS=("allowed-tools" "auto.allow" "fragile" "YAML.*list" "PreToolUse" "Conservative" "v1.10d" "subagent" "5축")
for kw in "${KEYWORDS[@]}"; do
    grep -qE "$kw" "$DOC" || { echo "FAIL — $DOC missing: $kw"; exit 1; }
done
echo "PASS — V4 doc 존재 + 9 keyword"

echo ""
echo "============================="
echo "smoke-bash-permission-pattern PASS — 6/6"
echo "============================="
```

evidence: `evidence/smoke-bash-permission-pattern.txt`.

## Grey Areas — 결정 (7건, β scope 갱신)

| ID | 질문 | 결정 |
|----|------|------|
| **G1** | 형식 통일 (콜론 vs 공백) | **공백** — skills/permissions/settings docs 3건 dominant + dialog 표준 (R1' revised) |
| **G2** | review skill `Bash(git*)` 처리 | **통째 제거** — review = read-only, git read-only forms 자동 허용 (인용 9 pre-approval semantics) |
| **G3** | upbit 사본 동시 정정 vs T4 분리 | **T4 분리** (R4') — `sessions/upbit/v1.2-bash-permission-update/` |
| **G4** | argument fine-grain | **시도 안 함** — A1 인용 4 fragile warning. Conservative 유지 (R3') |
| **G5** | smoke 신규 vs 기존 갱신 | **신규** `tests/smoke-bash-permission-pattern.sh` |
| **G6 (NEW)** | β scope (5축 통합) vs α scope (콜론+redundant) | **β** — 12 발견 종합 + 단일 정합성 (사용자 D1) |
| **G7 (NEW)** | format 채택 (공백 inline vs YAML list vs 콜론) | **YAML list + 공백 패턴** — separator 모호성 차단 + 가독성 + spec verbatim (사용자 D2-b) |

## 성공 기준

- [x] audit/A1-A5 5 파일 작성 (β scope 갱신 완료)
- [ ] 5 파일 frontmatter 5축 통합 정정 (16 → 9 Bash 패턴 + A1/A2 통합)
- [ ] `bootstrap/docs/PERMISSION_PATTERN.md` 신규 (~140-160 라인, 10 §, 9 keyword)
- [ ] `bootstrap/docs/OWNERSHIP.md` Evolution 1줄
- [ ] `CLAUDE.md` / `README.md` 최신 meta 세션 v1.10d
- [ ] `tests/smoke-bash-permission-pattern.sh` 6 stage PASS
- [ ] `evidence/smoke-bash-permission-pattern.txt`
- [ ] REPORT.md (V3 dynamic 검증 항목 포함)
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 5축 통합 정합성 깨짐.

```
chore(meta): sessions/meta/v1.10d-bash-permission-pattern-audit — frontmatter 5축 통합 (β scope, 16→9)

- update: claude/commands/harness-meta.md (A1+A2+A3+A4 — tools:→allowed-tools: YAML list, 11→9)
- update: bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md (A2+A3+A4 — YAML list, Bash 통째 제거)
- update: bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md (A2+A3+A4 — YAML list, 3→1)
- update: bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md (A2+A3+A4 — YAML list, Bash 통째 제거)
- add: bootstrap/docs/PERMISSION_PATTERN.md (단일 소스, 5축 통합, ~150 라인)
- update: bootstrap/docs/OWNERSHIP.md (Evolution v1.10d 1줄)
- update: CLAUDE.md / README.md (최신 meta 세션 v1.10d)
- add: tests/smoke-bash-permission-pattern.sh (V1+V4+V5+V7+V8+V9 6 stage)
- add: sessions/meta/v1.10d-bash-permission-pattern-audit/{PLAN,REPORT,audit/A1-A5,evidence/smoke}

v1.10b G28 + v1.10c 후속의 frontmatter 5축 통합 audit. β scope (12 발견 종합).

핵심 발견 (audit/A1-anthropic-docs.md verbatim):
- A1 (필드명): slash command/skill 공식 = `allowed-tools:`. `tools:`는 subagent 전용 (인용 7-8)
- A2 (separator): "space-separated string or YAML list" — 콤마 미명시 (인용 7)
- A3 (pattern): `Bash(cmd *)` 공백 = `Bash(cmd:*)` 콜론 equivalent. dialog 표준 = 공백 (인용 1, 2)
- A4 (redundant): ls/cat/head/tail/grep/find/wc/diff/stat/du/cd + git read-only 자동 허용 (인용 3)
- A5 (argument fragile): conservative 정책 (인용 4)

정정 변화 (β): 16 → 9 Bash 패턴 (44% 감소). A1 1건 + A2 4건 + A3 9건 + A4 7건 통합.
별도 후속: v1.10f (broad Bash 3 SKILL), v1.10g (thinking vs effort), upbit T4.
```

## 후속 세션 연결

### 직접 연계

- **v1.10f-broad-bash-fine-grain (S1b 후속)** — `harness/`, `harness-run/`, `harness-ship/` SKILL의 broad `Bash` declare 분석 후 fine-grain (또는 의도된 broad 유지)
- **v1.10g-skill-thinking-effort (S1b 후속)** — `thinking: high`가 deprecated `effort:` alias인지 검증
- **v1.2-bash-permission-update (upbit project, T4 후행)** — upbit deployed 6 SKILL + settings 36 패턴 5축 통합 정정 + deny 7 fragile 재설계 (PreToolUse hook 또는 ask 전환)
- **v1.10e-detect-license** (S2, v1.10c 폐기 결정 후속) — 본 v1.10d와 독립
- **v1.11~v1.13 bootstrap-templates** (S2) — language overlay
- **v1.14~v1.20 adapter-{cursor,gemini,...}** (S2) — adapter별 frontmatter spec, 본 PERMISSION_PATTERN.md baseline 참조
- **v1.21-cross-platform-install** (S3) — verify.ps1 A1/A4 drift 통합

### Lessons Forward

1. **공식 docs 1차 reference + 다중 source cross-check** — context7 plugin-dev (콜론) vs skills docs (공백) conflict는 단일 source 의존 시 spec 차이로 오인 가능. 본 audit는 12 발견 후 dominant source 식별로 R1' revised
2. **Audit는 가설 검증보다 spec 전수 조사가 본질** — α scope (콜론 추가) 가설로 진행 시 발견 2 (`tools:` 필드명) 누락. β scope 확장으로 5축 통합
3. **`allowed-tools` semantics — pre-approval, NOT 제한** — A3 mental model 정정. 제거 = 차단 아님. baseline 폴백
4. **YAML list 형식 채택 = separator 모호성 차단** — 공식 spec verbatim "space-separated string or YAML list" 명시. YAML list가 unambiguous + 가독성 + 확장성
5. **fragile warning 존중** — argument 제약 fine-grain은 공식 명시적 fragile. PreToolUse hook + deny rule + WebFetch 분리가 신뢰성 있는 제약
6. **T4 분리 정합 사례** — 본 v1.10d는 spec (meta), 후행 upbit 세션은 apply (project). v1.7-manifest-schema-v1.1 → upbit v1.1-manifest-upgrade 패턴
7. **dynamic 검증은 REPORT 단계** — frontmatter 정정 후 `/harness-meta` 진입 시 prompt 빈도 변화 관찰. (a) 시나리오 = pre-approval 시작 / (b) 시나리오 = lenient 파서 작동 — 사용자 사이드 V3 검증

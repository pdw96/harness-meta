# meta v1.33-fix-scope-contract — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/REPORT.md) — Scope contract 두 섹션 의무 도입
- [`sessions/meta/v1.29-verify-fix-mode/`](../v1.29-verify-fix-mode/REPORT.md) — `--fix` mode 패턴 도입 (smoke-spec-verification 한정)
- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/REPORT.md) — `EVIDENCE_DRIVEN_ROADMAP.md` §2 #3 (`v1.29b-fix-other-smokes`) 진행 가능 분류

목적: `tests/smoke-scope-contract.sh`에 `--fix` mode 도입 — Scope inheritance + Out of scope 두 § 부재 PLAN에 OWNERSHIP.md §Scope contract 정합 skeleton 자동 삽입. v1.29 패턴 답습.

부수: enumerate 확장 (현 v1.10h~v1.29 → v1.10h~v1.99 자동 흡수 패턴) — 본 v1.33 PLAN self-test + 향후 PLAN 자연 흡수.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S2(2) `tests/smoke-scope-contract.sh` + `bootstrap/docs/OWNERSHIP.md` (cross-ref 1줄) + meta(2) PLAN/REPORT = **4/4 meta**
- **T1 경로 다수결** — 100% S2/meta scope
- **T2 스펙 vs 값** — Scope contract `--fix` 패턴 = 모든 메타/프로젝트 PLAN 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.29-verify-fix-mode/REPORT.md` "다음 후보" 표 (verbatim)**:

> | `v1.29b-fix-other-smokes` | smoke-scope-contract / smoke-bash-permission-pattern `--fix` 도입. evidence-driven (현재 § 부담 SPEC_VERIFICATION만 누적) |

**Source 2 — `sessions/meta/v1.31-evidence-driven-roadmap/PLAN.md` 후속 분기 #2 (verbatim)**:

> | 2 | `v1.33-fix-other-smokes` (= v1.29b 별칭) | 2순위 | v1.29 `--fix` 패턴 v1.29 검증 완료 → 즉시 재사용 가능 |

**Source 3 — `sessions/meta/v1.32-report-cross-file-consistency/PLAN.md` Out of scope (verbatim)**:

> | smoke-scope-contract.sh enumerate 확장 (v1.24~v1.32 PLAN 포함) | `v1.31c-scope-contract-enumerate-expand` 별 후속 — evidence-driven (현 enumerate `v1.10h*/v1.10j*/v1.11*` 한정. 본 v1.32 PLAN scope contract 작성됐으나 enumerate 외) |

**Parsed sub-items (3)**:

1. **smoke-scope-contract.sh `--fix` mode 도입** — v1.29 패턴 답습 (`--fix` / `--dry-run` / `--help` / positional path / Idempotent / argv parsing)
2. **OWNERSHIP.md §Scope contract verbatim skeleton 단일 소스** — `## Scope inheritance` + `## Out of scope` 두 § 본문 hardcode + docs §Scope contract verbatim 정합
3. **enumerate 확장** — v1.31c-scope-contract-enumerate-expand 흡수. glob 패턴 `v1.10h*/v1.10j*/v1.[1-9]*[a-z]*/v1.[1-9][0-9]*/v[2-9].*` 자동 흡수 (현 v1.30/v1.31/v1.32 미포함 + 향후 PLAN 자연 흡수)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| smoke-bash-permission-pattern.sh `--fix` mode | 별 후속 `v1.33b-fix-bash-permission` — evidence 약함 (SKILL/agent frontmatter 신설 빈도 낮음, v1.10g 이후 1건 `harness-plan-verify`만). frontmatter 자동 fix는 의도 변경 risk |
| Skeleton sentinel 검증 (smoke ↔ OWNERSHIP.md drift 자동 감지) | 별 후속 — drift 발생 evidence 후 (`v1.29c-sentinel-check` 흡수 또는 별 세션) |
| **TODO placeholder 잔존 detection** (D8) | 별 후속 — `--fix` 후 TODO 채움 누락 사례 evidence 누적 후. 현재 smoke-scope-contract는 § 헤더 존재만 검증 (v1.29 spec-verification은 drift 값까지 검증, 본 smoke는 더 약한 검증) |
| 자동 fix 후 `Parsed sub-items` 본문 추론 | SKILL/사용자 책임 — `--fix`는 skeleton 골격만, 의미 채움은 별 |
| Pre-commit hook으로 강제 | `v1.30-precommit-hook` (별 후속, SPEC_VERIFICATION.md §10-2 명시) |
| smoke-scope-contract enumerate 동결 (특정 시점 cut-off) | 본 v1.33는 자동 흡수 채택. 동결 정책은 evidence 발생 시 별 세션 |
| 매트릭스 9 case (PLAN drift) 같은 cross-file 일관성 | smoke-scope-contract는 PLAN-only 검증. cross-file 일관성은 v1.32에서 spec-verification 한정 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | shift / case-esac / argv positional / heredoc / errexit-conditional / indirect-expansion / associative-array |
| **findings** | see citations below |
| **drift** | no — v1.29 spec C1~C3 그대로 답습 + 신규 bash 패턴 2건 (`${!skeleton_var}` indirect expansion + `declare -A seen` associative array dedup) 모두 GNU Bash 공식 manual 정합 |
| **re-verify** | smoke argv 분기, skeleton 본문, fix_section 함수, dedup 알고리즘 변경 시 |

**Citations**:
- C1 — `shift [n]` builtin: 인자 무 시 default 1, exit 0 unless n invalid (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html`)
- C2 — `case word in pattern) command-list ;;` + `*)` default + alternation `pat1 | pat2)` (Source: `https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html`)
- C3 — errexit (`set -e`) skip 조건: `if`/`elif` test + `&&`/`||` list (final 제외) + `!` 부정. `if grep -q PATTERN FILE; then no-op` errexit-safe (Source: `https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html` — trap ERR §)
- C4 (v1.33 신규) — Indirect parameter expansion: "Indirect variable expansion is supported in Bash, allowing a variable's value to be used as the name of another variable. This is further enhanced by the `nameref` attribute for automatic indirect expansion." PLAN R1 `fix_section` 함수의 `printf '%s\n' "${!skeleton_var}"` (skeleton_var 값이 변수명, 그 값을 dereference) 정합 (Source: `https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html`)
- C5 (v1.33 신규) — Associative array: "Explicitly declare a variable as an associative array. This allows for arbitrary string keys" — `declare -A name` 구문. PLAN R2 dedup의 `declare -A seen` + `seen[$plan]=1` + `[ -n "${seen[$plan]:-}" ]` 정합 (Source: `https://www.gnu.org/software/bash/manual/html_node/Arrays.html`)

## 1. 문제 (수동 작성 부담 누적)

### 현재 상태

`sessions/meta/v1.10h+/PLAN.md` 모두 두 § 의무:
- `## Scope inheritance (verbatim from 선행 세션)`
- `## Out of scope (explicit rejection)`

매 PLAN 작성 시 사용자/Claude가 두 § 본문을 수동 작성. 본 v1.33 자체도 위 두 § 직접 작성. **부담 evidence 누적**:
- v1.10h ~ v1.32 = 약 25+ PLAN, 모두 두 § 작성
- v1.32 작성 시 본 명시 누락 risk (D1~D8 사후 발견 사례)

### Root cause

skeleton 자동 삽입 mechanism 부재 (smoke-spec-verification만 v1.29에서 도입). 사용자가 OWNERSHIP.md §Scope contract verbatim을 매번 손으로 옮김.

### 본 세션 해결 범위

- `--fix` mode 도입 (skeleton 자동 삽입)
- enumerate 확장 (v1.30/v1.31/v1.32 흡수 + 자동 흡수 패턴)
- skeleton 단일 소스 명시 (smoke 코드 + OWNERSHIP.md verbatim)

## 2. 결정 (R1 ~ R3)

### R1 — `tests/smoke-scope-contract.sh` `--fix` mode

**CLI 인터페이스** (v1.29 패턴 답습):

```bash
bash tests/smoke-scope-contract.sh                                # 검증만 (default 회귀 0)
bash tests/smoke-scope-contract.sh --fix                          # 두 § 누락 PLAN 모두 skeleton 삽입
bash tests/smoke-scope-contract.sh --fix --dry-run                # 변경 없이 plan만 출력
bash tests/smoke-scope-contract.sh --fix <path> [<path>...]       # 특정 파일만 처리
bash tests/smoke-scope-contract.sh --help                         # usage
```

**알고리즘** (v1.29 fix_file 패턴 답습 + 두 § 처리):

```bash
# Anchor 매트릭스
# Scope inheritance: '^## 세션 소속 근거' § 직후 (다음 ^## 직전)
# Out of scope:      '^## Scope inheritance' § 직후 (다음 ^## 직전)

fix_section() {
    local file="$1" section_name="$2" anchor="$3" skeleton_var="$4"
    local anchor_line insert_line total tmp
    
    # Idempotency: § 이미 존재
    if grep -qE "^## ${section_name}" "$file"; then
        ok "fix: $file — '## ${section_name}' 이미 존재 (no-op)"
        return 0
    fi
    
    # Anchor line
    anchor_line=$(grep -nE "$anchor" "$file" | head -1 | cut -d: -f1 || true)
    if [ -z "$anchor_line" ]; then
        fail "fix: $file — anchor '$anchor' 부재. fix 불가"
        return 1
    fi
    
    # 다음 ^## (anchor 이후)
    insert_line=$(awk -v a="$anchor_line" 'NR>a && /^## / { print NR; exit }' "$file")
    total=$(wc -l < "$file")
    [ -z "$insert_line" ] && insert_line=$((total + 1))
    
    if [ "$DRY_RUN" -eq 1 ]; then
        ok "fix: $file [dry-run] — Would insert '$section_name' skeleton at line $insert_line"
        return 0
    fi
    
    # 삽입 (heredoc skeleton)
    tmp=$(mktemp)
    {
        head -n $((insert_line - 1)) "$file"
        printf '%s\n' "${!skeleton_var}"
        tail -n +"$insert_line" "$file"
    } > "$tmp"
    mv "$tmp" "$file"
    ok "fix: $file — '$section_name' skeleton 삽입 (line $insert_line)"
}

fix_file() {
    local file="$1"
    [ -f "$file" ] || { fail "fix: $file — 파일 부재"; return 1; }
    case "$file" in
        */PLAN.md) ;;
        *) fail "fix: $file — PLAN.md만 지원"; return 1 ;;
    esac
    # Scope inheritance 먼저 (anchor: 세션 소속 근거)
    fix_section "$file" "Scope inheritance" '^## 세션 소속 근거' "SCOPE_INHERITANCE_SKELETON"
    # Out of scope (anchor: Scope inheritance — 위에서 삽입됐으면 그것이 anchor)
    fix_section "$file" "Out of scope" '^## Scope inheritance' "OUT_OF_SCOPE_SKELETON"
}
```

**Skeleton 단일 소스** (heredoc, OWNERSHIP.md §Scope contract verbatim 정합):

```bash
read -r -d '' SCOPE_INHERITANCE_SKELETON <<'EOF' || true

## Scope inheritance (verbatim from 선행 세션)

**Source — TODO `sessions/meta/vX.Y-.../PLAN.md` Out of scope 표 또는 사용자 발의 (verbatim)**:

> TODO — 원문 그대로 인용

**Parsed sub-items (N)**:

1. **TODO** — 설명

EOF

read -r -d '' OUT_OF_SCOPE_SKELETON <<'EOF' || true

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| TODO — 인접 발견 issue | TODO `vX.Y-{name}` 또는 "evidence-driven 시" |

EOF
```

**예외 처리**:
- 파일 부재 / PLAN.md 외 → FAIL
- anchor 부재 → FAIL ("세션 소속 근거" § 누락 — 사용자 수동 작성 의무, `--fix`는 두 Scope contract § 한정)
- TARGET_PATHS=0 → default enumerate

**D1 — `--fix --dry-run` 두 § 모두 부재 case**:

dry-run 모드에서 fix_section 1번이 실 삽입 안 함 → 2번 호출 시 anchor `^## Scope inheritance` 부재 case 가능. 처치:
- dry-run 통합 메시지로 처리: "Would insert both sections after `## 세션 소속 근거`" (anchor offset 계산 회피)
- 또는 dry-run 시에도 1번 가상 anchor를 임시 마킹 후 2번 anchor offset 계산
- **선택**: 통합 메시지 (단순)

```bash
# dry-run 두 § 모두 부재 시 통합 처리
if [ "$DRY_RUN" -eq 1 ]; then
    has_inheritance=$(grep -qE '^## Scope inheritance' "$file" && echo 1 || echo 0)
    has_outofscope=$(grep -qE '^## Out of scope' "$file" && echo 1 || echo 0)
    if [ "$has_inheritance" -eq 0 ] && [ "$has_outofscope" -eq 0 ]; then
        anchor_line=$(grep -nE '^## 세션 소속 근거' "$file" | head -1 | cut -d: -f1 || true)
        if [ -n "$anchor_line" ]; then
            ok "fix: $file [dry-run] — Would insert both sections after '## 세션 소속 근거' (line $anchor_line)"
            return 0
        fi
    fi
fi
# 그 외 (1개 § 부재 또는 actual fix) → fix_section 개별 호출
```

**D9 — Skeleton 본문에 `^## ` 라인 무 검증**:

현 SCOPE_INHERITANCE_SKELETON 본문 line-by-line 검토:
- `## Scope inheritance (...)` — header (intentional)
- `**Source — ...**` — bold text
- `> TODO ...` — blockquote
- `**Parsed sub-items (N)**:` — bold text
- `1. **TODO** — 설명` — list item

→ `^## ` 라인은 header 1개만. anchor offset 계산 정합.

### R2 — Enumerate 자동 흡수 패턴

**현재 (v1.10h ~ v1.29 hardcode 21 row)**:

```bash
plans=(
    sessions/meta/v1.10h*/PLAN.md
    sessions/meta/v1.10j*/PLAN.md
    sessions/meta/v1.11*/PLAN.md
    ... v1.12 ~ v1.29 21 row ...
)
```

**갱신 (자동 흡수 glob)**:

```bash
shopt -s nullglob
plans=(
    sessions/meta/v1.10h*/PLAN.md
    sessions/meta/v1.10j*/PLAN.md
    sessions/meta/v1.[1-9]*[a-z]*/PLAN.md   # v1.10h~v1.10j 외 lowercase suffix (v1.18b/v1.18c/v1.18g 등)
    sessions/meta/v1.[1-9][0-9]*/PLAN.md     # v1.10~v1.99 (v1.10이 포함되나 lowercase suffix는 위에서 처리)
    sessions/meta/v[2-9].*/PLAN.md           # 향후 v2+ 자동 흡수
)
shopt -u nullglob
```

**문제**: glob `v1.10*` 자체가 v1.10/v1.10b/v1.10c/v1.10d/v1.10e/v1.10e2/v1.10e3/v1.10f/v1.10g/v1.10h/v1.10h2/v1.10h3/v1.10j 모두 매치 → 레거시 v1.10/v1.10b~v1.10g 포함 (Scope contract v1.10j 이전 면제 위반).

**정확한 glob** (v1.10h+ + v1.10j + v1.11+ + 자동 확장):

```bash
plans=(
    sessions/meta/v1.10h*/PLAN.md            # v1.10h, v1.10h2, v1.10h3
    sessions/meta/v1.10j*/PLAN.md            # v1.10j
    sessions/meta/v1.1[1-9]*/PLAN.md         # v1.11~v1.19 + suffix (v1.18b 등)
    sessions/meta/v1.[2-9][0-9]*/PLAN.md     # v1.20~v1.99
    sessions/meta/v[2-9].*/PLAN.md           # v2.0+ 향후
)
```

**중복 매치 처리** (D3 검증 결과):

실 매트릭스 검사 결과 **중복 매치 0건**:
- `v1.10h` → 패턴 1 (`v1.10h*`) 단독
- `v1.10j` → 패턴 2 (`v1.10j*`) 단독
- `v1.18b` → 패턴 3 (`v1.1[1-9]*`) 단독 (`v1.10*` 시작 안 함, `v1.[2-9]` 미매치)
- `v1.32` → 패턴 4 (`v1.[2-9][0-9]*`) 단독

→ dedup 불필요. 단 향후 glob 추가 시 안전장치 가치 → **dedup 함수 유지**:

```bash
# Dedup (associative array — 안전장치)
declare -A seen
unique_plans=()
for plan in "${plans[@]}"; do
    [ -n "${seen[$plan]:-}" ] && continue
    seen[$plan]=1
    unique_plans+=("$plan")
done
plans=("${unique_plans[@]}")
```

**v1.10b~v1.10g 면제 정합 (D4)**:

glob `v1.10h*` + `v1.10j*`만 매치 → `v1.10b/c/d/e/e2/e3/f/g`는 enumerate 외. OWNERSHIP.md "v1.10j 이전 세션 소급 의무 없음" 정합.

**v1.30~v1.99 흡수 보장 (D5)**:

`v1.[2-9][0-9]*` = `v1.<2-9><0-9>*` = `v1.20*~v1.99*`. v1.30/v1.31/v1.32/v1.33 모두 매치. v1.100+ (3-digit minor) 미매치 — 1년 내 도달 unlikely (현 minor bump 패턴 ~1/주).

### R3 — `OWNERSHIP.md` cross-ref 1줄

`bootstrap/docs/OWNERSHIP.md`의 `### Spec verification (context7) § (v1.24+)` 직후 또는 §Scope contract 끝 부분에 1줄 추가:

```markdown
### Smoke `--fix` mode (v1.33+)

`tests/smoke-scope-contract.sh --fix`로 두 § 부재 PLAN에 본 §Scope contract 정합 skeleton 자동 삽입. TODO placeholder 잔존 시 default smoke가 PLAN 본문 검증 (sub-item 매핑 가능) → 사용자/SKILL이 채움. 상세: `sessions/meta/v1.33-fix-scope-contract/`.
```

## 3. 변경 대상 (2 수정 + 2 세션)

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-scope-contract.sh` | S2 | R1 — argv parsing + `--fix` dispatch + 2 skeleton heredoc + fix_file/fix_section 함수 (~80 lines 추가) + R2 enumerate glob 자동 흡수 + dedup |
| `bootstrap/docs/OWNERSHIP.md` | S2 | R3 — 1줄 cross-ref (`### Smoke --fix mode (v1.33+)`) |

### 세션 기록 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.33-fix-scope-contract/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.33-fix-scope-contract/REPORT.md` | meta | self-test (--fix dry-run + idempotent + enumerate 확장 검증) |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + Scope contract + Spec verification §
- [ ] **사용자 진입 확인**
- [ ] Stage A — `tests/smoke-scope-contract.sh` argv parsing + `--fix` dispatch + skeleton heredoc + fix_file/fix_section
- [ ] Stage B — enumerate glob 자동 흡수 + dedup
- [ ] Stage C — `OWNERSHIP.md` cross-ref 1줄
- [ ] Stage D — self-test (default 회귀 + `--fix --dry-run` + enumerate 확장 검증)
- [ ] Stage E — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `tests/smoke-scope-contract.sh --help` usage 출력
- [ ] `tests/smoke-scope-contract.sh --fix --dry-run` — 모든 PLAN § 이미 존재 → "no-op" 메시지 출력 (현 모든 PLAN 정합)
- [ ] `tests/smoke-scope-contract.sh` (default) — enumerate 확장 후 v1.30/v1.31/v1.32/v1.33 추가 검사 + 모두 PASS
- [ ] enumerate dedup — 같은 PLAN 중복 검사 0
- [ ] `OWNERSHIP.md` cross-ref 1줄 추가
- [ ] 회귀 0 (smoke-spec-verification + bash-permission + thinking-effort + language-overlay)
- [ ] self-test: 본 v1.33 PLAN이 enumerate 자동 흡수 → PASS

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.33-fix-scope-contract — smoke-scope-contract.sh --fix mode + enumerate 자동 흡수

- update: tests/smoke-scope-contract.sh (R1 — argv + --fix + 2 skeleton heredoc + fix_section / R2 — enumerate glob 자동 흡수 + dedup)
- update: bootstrap/docs/OWNERSHIP.md (R3 — 1줄 cross-ref `### Smoke --fix mode (v1.33+)`)
- add: sessions/meta/v1.33-.../{PLAN,REPORT}.md

Scope: smoke-scope-contract.sh `--fix` mode (v1.29 패턴 답습) + enumerate 자동 흡수 (v1.31c 흡수).
- --fix / --dry-run / --help / positional path
- 2 skeleton: Scope inheritance + Out of scope (heredoc, OWNERSHIP.md §Scope contract verbatim)
- enumerate glob: v1.10h*/v1.10j*/v1.1[1-9]*/v1.[2-9][0-9]*/v[2-9].*
- dedup: associative array

Out of scope:
- smoke-bash-permission-pattern.sh --fix (v1.33b 별 후속, evidence 약함)
- skeleton sentinel 검증 (drift evidence 후)

Spec verification: drift=no (GNU Bash spec C1 shift + C2 case + C3 errexit-conditional, v1.29 답습).
Self-test: default 회귀 0 + --fix --dry-run no-op + enumerate v1.30/v1.31/v1.32/v1.33 흡수.
회귀 0 — 다른 smoke 영향 무.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.33b-fix-bash-permission` | smoke-bash-permission-pattern `--fix` mode. evidence 누적 (SKILL/agent 신설 빈도 증가) |
| `v1.33c-skeleton-sentinel` | smoke skeleton ↔ OWNERSHIP.md verbatim drift 자동 감지. drift 발생 evidence 후 |
| `v1.31c-scope-contract-enumerate-expand` (= v1.33 R2 흡수) | ~~별 세션~~ → 본 v1.33에서 흡수 (archive) |
| `v1.36-skills-categories` (= v1.22) | 5번째 skill 추가와 동시 (v1.31 ROADMAP §2 #5) |

## 8. Lessons Forward (예상)

- **L1 — `--fix` mode 패턴 재사용 가치 확인** — v1.29에서 spec-verification 한정 도입한 패턴이 본 v1.33에서 scope-contract로 즉시 재사용. 향후 `v1.33b` (bash-permission) 도입 시도 동일 패턴 답습. **재사용 가능 mechanism = 도구 인프라**
- **L2 — Glob 자동 흡수 vs 동결 트레이드오프** — hardcode list (현재 v1.29까지)는 사용자 매 PLAN 추가 의무. glob 자동 흡수는 매 세션 자연 검증 + 사용자 부담 0. 단 향후 폐기/변경 PLAN 처리 시 동결 정책 evidence 필요 (현재 evidence 0)
- **L3 — Skeleton 양쪽 hardcode (smoke + OWNERSHIP.md verbatim)** — v1.29 SPEC_SKELETON 동일 우려. drift 가능성. sentinel 검증은 drift 발생 evidence 후 별 세션 (v1.33c)

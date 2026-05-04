# meta v1.34-legacy-plan-migration — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Out of scope §에서 "기존 모든 sessions PLAN.md 소급 갱신 (legacy 25+ 세션)"을 후속 점진 마이그레이션으로 분리. 본 v1.34가 그 후속 (=`v1.10j2-legacy-plan-migration` alias)
- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/EVIDENCE_DRIVEN_ROADMAP.md) §2 #2 — `v1.10j2-legacy-plan-migration` / `25+ legacy PLAN 사례 충분, soft migration risk 0` 진행 가능 등재
- [`sessions/meta/v1.33-fix-scope-contract/`](../v1.33-fix-scope-contract/PLAN.md) — `tests/smoke-scope-contract.sh --fix` mode + enumerate 자동 흡수 도입. 본 v1.34가 동일 인프라 위에 `--include-legacy` opt-in flag 추가

목적: legacy PLAN 23건(v1.0 ~ v1.10g)에 대한 **soft migration 도구 인프라** 도입. `tests/smoke-scope-contract.sh --include-legacy` opt-in flag 신설 — default 호출(검증 + `--fix`) 영향 0, 사용자 trigger 시만 legacy enumerate. 실제 § 삽입 적용은 0 (본 세션 scope 외, 사용자 자율). v1.10j "점진 마이그레이션" verbatim 정합.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(2) `tests/smoke-scope-contract.sh` + `bootstrap/docs/OWNERSHIP.md` + S2(1) `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` (archive 이관) = **3/3 meta**
- **T1 경로 다수결** — meta scope 3/3
- **T2 스펙 vs 값** — smoke `--include-legacy` 정책은 모든 사용자/프로젝트 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.10j-scope-contract-discipline/PLAN.md` Out of scope 표** (verbatim):

> | ❌ Item | 분리 대상 |
> |--------|---------|
> | 기존 모든 sessions PLAN.md 소급 갱신 (legacy 25+ 세션) | 후속 세션 — 점진 마이그레이션 |

**Source 2 — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` §2 #2** (verbatim):

> | 2 | **`v1.10j2-legacy-plan-migration`** | scope-contract | 25+ legacy PLAN 사례 충분, soft migration risk 0 | `v1.10j REPORT` |

**Source 3 — 사용자 발의 (2026-04-30) 본 세션 옵션 결정**:

> "권장" (= Option A — `--include-legacy` flag 추가, 도구 인프라만, 실 적용 0)

**Parsed sub-items (4)**:

1. **`--include-legacy` opt-in flag** — `tests/smoke-scope-contract.sh`에 신설. default 검증 + `--fix` 호출 시 영향 0. trigger 시만 legacy 23건 enumerate
2. **`is_legacy_plan()` skip 함수** — v1.27 `smoke-spec-verification.sh`의 `is_legacy()` / `is_legacy_report()` 패턴 답습. minor version 동적 비교 (`LEGACY_PLANS_META_BEFORE=10` 또는 hard-coded list)
3. **G1 2건 anchor 부재 처리** — v1.0-bootstrap, v1.1-global-smoke-test는 `## 세션 소속 근거` § 부재. `--include-legacy --fix` 적용 시 명시 SKIP + 사유 출력 (사용자 수동 의무)
4. **OWNERSHIP.md `### 레거시 세션` § 갱신** — `--include-legacy` opt-in 안내 + R-WARP 4종 경고 + v1.10h vs v1.10j inconsistency cosmetic clarification

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Legacy 23건 실 § 삽입 적용 (수동 또는 자동) | 후속 세션 evidence-driven (사용자 trigger 시 별 PR 또는 commit) |
| G1 2건 (v1.0/v1.1) anchor 자동 추가 (`# meta vX.Y` 헤더 직후 등) | `v1.34b-anchor-fallback` evidence 후속 (현 0건) |
| Project 세션 PLAN legacy migration (`sessions/upbit/v1.0~v1.2`) | `v1.34c-project-plan-legacy` 별 후속 (sessions/<project>/v*/PLAN.md scope) |
| smoke-bash-permission-pattern.sh `--fix` mode | `v1.33b-fix-bash-permission` evidence-driven (v1.31 ROADMAP §2 #3 nested 후속) |
| Skeleton sentinel 검증 (smoke ↔ OWNERSHIP.md verbatim drift 자동 감지) | `v1.33c-skeleton-sentinel` evidence-driven |
| `tests/smoke-spec-verification.sh`도 동일 `--include-legacy` 패턴 추가 | 별 후속 evidence-driven (smoke-spec-verification는 이미 LEGACY_REPORTS_META_BEFORE 동적 동작) |
| Legacy PLAN의 "Source — 사용자 발의 (retroactive)" verbatim 추출 자동화 | 별 후속 (R-WARP4 역사 왜곡 risk — 사용자 자율 영역) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | argv parsing / case-esac / arithmetic comparison `[ ]` `-lt` / arrays / shopt nullglob |
| **findings** | no new findings |
| **drift** | no — 본 세션 변경은 v1.27 `smoke-spec-verification.sh` LEGACY_REPORTS 패턴 + v1.33 `smoke-scope-contract.sh --fix` 패턴 답습. 신규 spec 의존 0. v1.33 PLAN의 C1~C5 (shift / case alternation / errexit-conditional / indirect expansion / associative array) 그대로 유지. 동적 minor 비교 (`[ "$minor" -lt 10 ]`)는 GNU Bash POSIX 산술 conditional — v1.27 smoke-spec-verification line 86 인용 검증 |
| **re-verify** | smoke argv 분기 / is_legacy_plan() 알고리즘 / OWNERSHIP.md §Scope contract 갱신 시 |

**Citations** (no new findings — v1.33 PLAN C1~C5 재인용 + 본 세션 SKILL 직접 검증 1건):

- C1 — `shift` builtin (v1.33 PLAN 참조 — argv 처리 동일)
- C2 — `case` alternation: `case word in [pattern | pattern]...` (Source: `https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html`) — `--include-legacy)` 분기 추가 정합. v1.34 SKILL 직접 검증 (2026-04-30)
- C3 — errexit-conditional (`[ -lt ]` 산술 비교 안전 처리, v1.33 그대로)
- C4 — Indirect parameter expansion `${!parameter}` (skeleton 변수 동적 선택, v1.33 그대로)
- C5 — `declare -A` associative array (Source: `https://www.gnu.org/software/bash/manual/html_node/Arrays.html`) — `is_anchor_missing()` static list + enumerate dedup 정합. v1.34 SKILL 직접 검증 (2026-04-30)

## 배경

### 문제 (소급 의무 규칙 부재)

`bootstrap/docs/OWNERSHIP.md` §Scope contract `### 레거시 세션` verbatim:
> "본 규약 이전(`v1.10j` 이전) 세션은 소급 의무 없음. `tests/smoke-scope-contract.sh`는 `v1.10h` 이후 세션만 검사."

→ 면제 정책은 명시되어 있으나 **마이그레이션 pathway 부재**. `v1.10j` PLAN의 "점진 마이그레이션" 지정 후 `v1.31` ROADMAP에서 진행 가능으로 등재된 후 8 세션(v1.32 ~ v1.33) 경과 — pathway 도입 시기.

### 사전 분석 결과 (4 옵션 9차원 trade-off)

| 옵션 | 합산 평가 | 채택 사유 |
|------|:--:|---|
| **A — `--include-legacy` flag (도구 인프라만)** | **★★★★☆** | **채택**: Risk 0 (default 무관), v1.27/v1.33 패턴 일관성, 사용자 선택권 보존, R-WARP 회피 |
| B — 수동 22건 채움 | ★☆☆☆☆ | 거부: R-WARP4 역사 왜곡 + 22 PLAN 분석 비용 매우 높음 |
| C — 정책 문서화만 | ★★★☆☆ | 거부: 도구 부재로 향후 trigger 시 즉시 활용 불가 |
| D — Hybrid (A + 1건 시범) | ★★★★☆ | 거부: 1건 시범도 R-WARP1 발생, evidence value < cost |

→ **Option A 채택**.

### 핵심 통찰 4

1. **Legacy 23건 분류**:
   - **G1** (2건, anchor 부재): v1.0-bootstrap, v1.1-global-smoke-test → fix 자동 불가
   - **G2** (21건, anchor 보유): v1.2 ~ v1.10g → fix 적용 가능
2. **OWNERSHIP.md inconsistency**: "v1.10j 이전 면제" vs "smoke는 v1.10h 이후 검사" — v1.10h/h2/h3는 면제이지만 우연히 PASS (1차 demo로 두 § 보유). 본 세션에서 cosmetic clarification.
3. **Risk 0 성립 조건**: default 호출 영향 0 + opt-in trigger. v1.31 ROADMAP "soft migration risk 0" 정합.
4. **R-WARP4 (역사 왜곡)**: legacy PLAN은 closed historical record. retroactive § 추가는 audit trail 시간 거짓 risk. 사용자 자율 영역으로 분리 (Option A 본질).

## 1. 결정 (R1 ~ R4)

### R1 — `tests/smoke-scope-contract.sh` `--include-legacy` opt-in flag 신설

**알고리즘**:

```bash
# 신규 argv 처리 (case 분기 추가)
INCLUDE_LEGACY=0
case "$1" in
    --include-legacy) INCLUDE_LEGACY=1 ;;
    ...
esac

# enumerate_plans() — INCLUDE_LEGACY 분기
enumerate_plans() {
    shopt -s nullglob
    local raw=()
    if [ "$INCLUDE_LEGACY" -eq 1 ]; then
        # legacy 23건 추가 (v1.0 ~ v1.10g)
        raw+=(
            sessions/meta/v1.0-*/PLAN.md
            sessions/meta/v1.1-*/PLAN.md
            sessions/meta/v1.[2-9]-*/PLAN.md
            sessions/meta/v1.[2-9][a-z]-*/PLAN.md
            sessions/meta/v1.10-*/PLAN.md
            sessions/meta/v1.10[a-g]*-*/PLAN.md
        )
    fi
    raw+=(
        sessions/meta/v1.10h*/PLAN.md
        sessions/meta/v1.10j*/PLAN.md
        sessions/meta/v1.1[1-9]*/PLAN.md
        sessions/meta/v1.[2-9][0-9]*/PLAN.md
        sessions/meta/v[2-9].*/PLAN.md
    )
    shopt -u nullglob
    # Dedup (v1.33 패턴 그대로)
    declare -A seen
    local result=() p
    for p in "${raw[@]}"; do
        [ -n "${seen[$p]:-}" ] && continue
        seen[$p]=1
        result+=("$p")
    done
    printf '%s\n' "${result[@]}"
}
```

### R2 — `is_legacy_plan()` skip 함수 (G1 anchor 부재 처리)

```bash
# G1 — anchor 부재 명시 list (정적, 2건)
ANCHOR_MISSING_LEGACY=(
    "sessions/meta/v1.0-bootstrap/PLAN.md"
    "sessions/meta/v1.1-global-smoke-test/PLAN.md"
)

is_anchor_missing() {
    local plan="$1" item
    for item in "${ANCHOR_MISSING_LEGACY[@]}"; do
        [ "$plan" = "$item" ] && return 0
    done
    return 1
}

# fix_file() 진입 시 G1 검사 + skip
fix_file() {
    local file="$1"
    [ -f "$file" ] || { fail "fix: $file — 파일 부재"; return 1; }
    case "$file" in
        */PLAN.md) ;;
        *) fail "fix: $file — PLAN.md만 지원"; return 1 ;;
    esac

    if is_anchor_missing "$file"; then
        skip "fix: $file — '## 세션 소속 근거' anchor 부재 (G1 legacy). 사용자 수동 작성 의무"
        return 0
    fi
    # ... (기존 로직)
}
```

→ G1 2건은 default `--fix --include-legacy` 호출 시 SKIP 카운트로 명시 처리. 사용자 수동 작성 의무 안내.

### R3 — Help 텍스트 + Stage 1 분기 출력 갱신

```
--include-legacy:
              Legacy 23건 (v1.0 ~ v1.10g) enumerate에 포함. default 검증 + --fix 영향 0.
              opt-in trigger 시만 활성. G1 2건 (v1.0/v1.1) anchor 부재 SKIP.
              ⚠️ R-WARP 경고: legacy PLAN은 closed historical record. retroactive § 추가는
              audit trail 시간 거짓 risk. 사용자 자율 판단.
```

### R4 — `bootstrap/docs/OWNERSHIP.md` §Scope contract `### 레거시 세션` 갱신

기존 1줄:
> 본 규약 이전(`v1.10j` 이전) 세션은 소급 의무 없음. `tests/smoke-scope-contract.sh`는 `v1.10h` 이후 세션만 검사.

신 갱신 (~6줄):

- v1.10h vs v1.10j inconsistency cosmetic clarification (실제 smoke는 v1.10h+ 검사하나 v1.10h/h2/h3는 1차 demo로 자연 PASS)
- `--include-legacy` opt-in pathway 안내
- R-WARP 4종 경고 (역사 왜곡 / 의미 단절 / TODO 영구 잔존 / chain head anchor 부재)
- G1 2건 anchor 부재 명시
- 사용자 자율 영역 (Claude 강제 적용 안 함)

### R5 — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` §9 archive 이관

§2 #2 row를 §9 archive로 이관:
> `✅ v1.34-legacy-plan-migration (v1.10j2 alias, 2026-04-30) — smoke-scope-contract --include-legacy opt-in flag + G1 anchor 부재 SKIP + R-WARP 경고 (도구 인프라만, 실 적용 0)`

§9 archive에 row 추가 + §2 #2 제거 + §2 권장 진행 순서 갱신.

## 2. 변경 대상 (3 수정 + 2 신규)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-scope-contract.sh` | S3 | R1 (argv + enumerate 분기) + R2 (is_anchor_missing + fix_file SKIP) + R3 (help 텍스트 갱신) + Stage 1 분기 출력 |
| `bootstrap/docs/OWNERSHIP.md` | S2 | R4 — §Scope contract `### 레거시 세션` 갱신 (~6줄 expand) |
| `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` | S2 | R5 — §2 #2 row archive 이관 + §5 권장 진행 순서 갱신 + §9 archive row 추가 |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.34-legacy-plan-migration/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.34-legacy-plan-migration/REPORT.md` | meta | Stage E |

## 3. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 (Scope contract 두 § + Spec verification §)
- [ ] **사용자 진입 확인**
- [ ] Stage A — `tests/smoke-scope-contract.sh` 신규 코드 (R1 + R2 + R3, ~80 lines)
- [ ] Stage B — `bootstrap/docs/OWNERSHIP.md` §Scope contract `### 레거시 세션` 갱신 (R4)
- [ ] Stage C — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` §2/§5/§9 갱신 (R5)
- [ ] Stage D — Self-test
  - default smoke (no flag): PASS=66 유지 (회귀 0)
  - `--include-legacy`: enumerate 23 + 33 = 56건? (실 카운트는 dedup 후) → 두 § 부재로 FAIL 다수
  - `--include-legacy --fix --dry-run`: G2 21건 fix plan + G1 2건 SKIP
  - `--include-legacy --fix --dry-run <single>` (특정 path 지정): fix plan 1건
  - 회귀: `--fix --dry-run` (no --include-legacy): default 33건 모두 no-op
- [ ] Stage E — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 4. 성공 기준

- [ ] `tests/smoke-scope-contract.sh --help` `--include-legacy` 안내 추가
- [ ] default smoke (no flag): PASS=66 + FAIL=0 (회귀 0)
- [ ] `--include-legacy` 단독: enumerate 56 + Stage 1 FAIL 다수 (legacy 두 § 부재 명시)
- [ ] `--include-legacy --fix --dry-run`: G2 21건 plan 출력 + G1 2건 SKIP (anchor 부재 사유)
- [ ] OWNERSHIP.md §Scope contract `### 레거시 세션` 6줄 갱신 (cosmetic clarification + opt-in pathway + R-WARP 경고 + G1 명시 + 사용자 자율 영역)
- [ ] EVIDENCE_DRIVEN_ROADMAP.md §2 #2 archive 이관 + §5 권장 순서 갱신 + §9 archive row 추가
- [ ] 회귀 0 — 4 smoke 모두 PASS 유지 (smoke-scope-contract / smoke-spec-verification / smoke-bash-permission / smoke-thinking-effort)
- [ ] 실제 legacy 23건 § 삽입 0 (Out of scope 정합)

## 5. 커밋 전략

```
feat(meta): sessions/meta/v1.34-legacy-plan-migration — smoke-scope-contract --include-legacy opt-in flag

- update: tests/smoke-scope-contract.sh (R1+R2+R3 — argv 분기 + enumerate INCLUDE_LEGACY + is_anchor_missing skip + help 갱신)
- update: bootstrap/docs/OWNERSHIP.md (R4 — §Scope contract 레거시 § 6줄 갱신)
- update: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md (R5 — §2 #2 archive 이관 + §5/§9 갱신)
- add: sessions/meta/v1.34-.../{PLAN,REPORT}.md

Scope: 도구 인프라만 (실 legacy § 삽입 0).
- v1.10j Out of scope "기존 모든 sessions PLAN.md 소급 갱신 ... 점진 마이그레이션" verbatim 정합
- v1.27 smoke-spec-verification LEGACY_REPORTS 패턴 답습
- v1.33 smoke-scope-contract --fix 인프라 위에 --include-legacy opt-in 추가
- G1 2건 (v1.0/v1.1) anchor 부재 명시 SKIP
- R-WARP 4종 경고 (역사 왜곡 / 의미 단절 / TODO 영구 잔존 / chain head)

Smoke: default PASS=66 유지 (회귀 0). --include-legacy 단독 enumerate 확장 검증.
```

## 6. 후속 분기

| 후속 세션 | 조건 |
|-----------|---|
| `v1.34b-anchor-fallback` | G1 2건 anchor 자동 추가 메커니즘 (`# meta vX.Y` 헤더 직후 등). evidence: 사용자가 G1 2건도 § 추가 요청 |
| `v1.34c-project-plan-legacy` | sessions/upbit/v1.0~v1.2 등 project 세션 PLAN legacy migration. evidence: 프로젝트 측 사용자 요구 |
| `v1.34d-actual-legacy-fix` | legacy 23건 실 § 삽입 적용 (Source — 사용자 발의 retroactive 형식). evidence: 사용자 명시 trigger + 22 PLAN 분석 자원 확보 |
| `v1.33b-fix-bash-permission` | smoke-bash-permission-pattern.sh `--fix` mode (v1.31 ROADMAP §2 #3 nested 후속) |
| `v1.33c-skeleton-sentinel` | smoke skeleton ↔ OWNERSHIP.md verbatim drift 자동 감지 |

## 7. Lessons Forward (예상)

- **L1 — v1.10j 분리 결정의 정합성** — "점진 마이그레이션"이 실제 운용 시 정합 입증. 1년 단위 evidence 누적 패턴으로 검증
- **L2 — v1.27 LEGACY_* skip 패턴 v1.33+ 답습 가능성** — `--fix` (v1.33) → `--include-legacy` (v1.34) 두 도구 차원 인프라가 모두 v1.27 패턴 자연 답습. 향후 smoke 추가 시 동일 인프라 재사용 가능 mechanism 입증
- **L3 — R-WARP4 (역사 왜곡) 회피 = 도구만 도입 + 사용자 자율** — Claude가 "useful"하다고 판단해 retroactive 자동 적용하면 audit trail 신뢰성 훼손. 명시적 trigger 분리가 핵심
- **L4 — G1 2건 anchor 부재 = chain head edge case** — 첫 세션은 본질적으로 선행 세션 부재. 모든 마이그레이션 도구는 chain head를 명시 SKIP 처리해야 함

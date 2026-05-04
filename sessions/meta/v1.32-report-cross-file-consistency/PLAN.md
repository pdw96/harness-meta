# meta v1.32-report-cross-file-consistency — PLAN

세션 시작: 2026-04-29
직접 선행 세션:

- [`sessions/meta/v1.27-report-spec-verification/`](../v1.27-report-spec-verification/REPORT.md) — REPORT § 의무 도입
- [`sessions/meta/v1.29-verify-fix-mode/`](../v1.29-verify-fix-mode/REPORT.md) — "REPORT § cross-file 일관성 | evidence 3+ 사례 누적 후 (현 v1.27/v1.28/v1.29 3건)" 명시
- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/REPORT.md) — 본 세션을 진행 가능 1순위로 분류

목적: PLAN drift vs REPORT drift **cross-file 일관성 검증** smoke Stage 추가. v1.27 REPORT § 도입 후 v1.27/v1.28/v1.29/v1.30/v1.31 5건 누적 → "evidence 3+" 임계 도달.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(2) `tests/smoke-spec-verification.sh` + `bootstrap/docs/SPEC_VERIFICATION.md` + meta(2) PLAN/REPORT = **4/4 meta**
- **T1 경로 다수결** — 100% S2/meta scope
- **T2 스펙 vs 값** — Cross-file 일관성 매트릭스 = 모든 메타/프로젝트 세션 PLAN/REPORT pair 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.29-verify-fix-mode/REPORT.md` "다음 후보" 표 (verbatim)**:

> | REPORT § cross-file 일관성 | REPORT drift vs PLAN drift 대조 stage. evidence 3+ 사례 누적 후 (현 v1.27/v1.28/v1.29 3건) |

**Source 2 — `sessions/meta/v1.27-report-spec-verification/REPORT.md` "다음 후보" 표 (verbatim)**:

> | REPORT § cross-file 일관성 검증 | REPORT drift vs PLAN drift 대조. evidence 3+ 사례 누적 후 |

**Source 3 — `sessions/meta/v1.31-evidence-driven-roadmap/` `EVIDENCE_DRIVEN_ROADMAP.md` §2 #1 (verbatim)**:

> | 1 | **REPORT § cross-file 일관성 검증** | spec-verification | v1.27/v1.28/v1.29 3건 누적 → "evidence 3+ 사례" 임계 도달 | `v1.27/v1.29 REPORT` |

**Parsed sub-items (3)**:

1. **PLAN drift vs REPORT drift 대조 stage 추가** — `tests/smoke-spec-verification.sh` Stage 7 신설
2. **Cross-file 일관성 매트릭스 정의** — 9 case (PLAN {no,yes,N/A} × REPORT {no,yes,N/A}) 중 OK/WARN/FAIL 분류
3. **SPEC_VERIFICATION.md docs 갱신** — Stage 7 매트릭스 단일 소스 + Stage 6 위반 정책 표 확장

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| PLAN drift 값 자동 fix (`--fix` mode 확장) | v1.32b 또는 사용자 책임 — smoke는 검증만, fix는 SKILL `harness-plan-verify` 책임 |
| REPORT 작성 시 PLAN drift 강제 inherit 도구 | `harness-plan-verify` 또는 별 SKILL — smoke scope 외 |
| 프로젝트 PLAN/REPORT (`sessions/<project>/v*/`) Stage 7 적용 | 현재 프로젝트 REPORT 전체 레거시 면제 (v1.27 도입 이전, `is_legacy_report()`) — 프로젝트 v1.27+ 신규 REPORT 등장 후 |
| Drift 값 외 sub-field cross-file 일관성 (library/topic/findings/re-verify 매칭) | 별 후속 evidence-driven — drift만이 의사결정 핵심, 나머지는 자유도 높음 |
| Cross-section consistency (Citations 본문 PLAN ↔ REPORT 일관성) | 별 후속 — citation은 추가 발견 흡수 정상 (REPORT가 PLAN superset) |
| `--fix` mode에 Stage 7 자동 정정 통합 | 별 후속 — 자동 정정은 의도 변경 risk (사용자 판단 필요) |
| 매트릭스 9 case 중 FAIL/WARN case fixture self-test | 별 후속 — 가짜 PLAN/REPORT fixture 도입은 scope 폭주. 매트릭스 의미는 docs §11 + PLAN §R1 hardcode + 사용자 검토로 정합 인정 (D5) |
| smoke-scope-contract.sh enumerate 확장 (v1.24~v1.32 PLAN 포함) | `v1.31c-scope-contract-enumerate-expand` 별 후속 — evidence-driven (현 enumerate `v1.10h*/v1.10j*/v1.11*` 한정. 본 v1.32 PLAN scope contract 작성됐으나 enumerate 외) (D8) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | case-alternation-pipe / parameter-expansion-suffix-removal |
| **findings** | see citations below |
| **drift** | no — PLAN R2의 신규 bash 패턴 (`case "${a}|${b}" in "v1|v2"\|"v3|v4") ;; esac` alternation + `${rpt%/REPORT.md}/PLAN.md` suffix removal) 모두 GNU Bash 공식 manual 현 spec과 정합 |
| **re-verify** | smoke Stage 7 매트릭스 9 case 코드 변경 시 또는 bash major version migration 시 (현 4.x 기준 검증 완료) |

**Citations**:

- C1 — `case word in [ [(] pattern [| pattern]...) command-list ;;]... esac` 구문 + `*)` default case. 공식 예: `horse | dog | cat) echo -n "four";;`. PLAN R2의 `case "${plan_drift}|${rpt_drift}" in "N/A|N/A"|"no|no"|"yes|yes"|"no|yes"|"yes|no") ok ;; "N/A|no"|"N/A|yes") fail ;; ... esac` 정합 (Source: `https://www.gnu.org/software/bash/manual/html_node/Conditional-Constructs.html`)
- C2 — POSIX pattern removal expansions verbatim: "POSIX pattern removal expansions (`%`, `#`, `%%`, `##`) for removing leading or trailing substrings from variable values". PLAN R2의 `plan="${rpt%/REPORT.md}/PLAN.md"` (suffix `/REPORT.md` shortest match removal → 새 suffix `/PLAN.md` append) 정합 (Source: `https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html`)

## 1. 문제 (Cross-file 일관성 검증 부재)

### 현재 상태

`smoke-spec-verification.sh` Stage 6까지:

- **PLAN** drift 값 검증 (Stage 1~5)
- **REPORT** drift 값 검증 (Stage 6, v1.27+)
- 각 파일 **자체 정합성**만 검증

**PLAN ↔ REPORT pair 정합성 검증 부재**:

- PLAN drift=`N/A` (외부 spec 의존 무) → REPORT drift=`yes` (구현 중 spec drift 발견)
  - 의미 충돌: PLAN scope = 외부 spec 의존 무 선언인데 REPORT가 spec drift 발견 = **scope 확장 또는 PLAN 오작성**
- PLAN drift=`no/yes` → REPORT drift=`N/A`
  - PLAN은 spec 의존 선언, REPORT는 의존 무 = **scope 축소 (정상 가능) 또는 misuse**

**Evidence 누적**:

- v1.27 (REPORT § 도입) ~ v1.31 = 5건 PLAN/REPORT pair
- 모두 정합 (`N/A→N/A` 3건, `no→no` 2건)
- 5건 baseline → 향후 cross-file 위반 자동 감지 의미 있음

### Root cause

REPORT 작성 시점에 PLAN drift 값을 사용자가 수동 inherit. 자동 검증 없이 휴먼 에러 가능. v1.27 도입 후 5건 baseline은 깨끗하나 향후 누적 시 위반 발생 가능.

### 본 세션 해결 범위

- Stage 7 — Cross-file 일관성 매트릭스 검증 (smoke 자동)
- 매트릭스 9 case OK/WARN/FAIL 분류 + 정책
- SPEC_VERIFICATION.md §11 신설 또는 §3 위반 정책 확장

## 2. 결정 (R1 ~ R3)

### R1 — Cross-file 일관성 매트릭스 (9 case)

| PLAN drift | REPORT drift | 분류 | 의미 |
|:----------:|:------------:|:----:|------|
| N/A | N/A | **OK** | 외부 spec 의존 무 양쪽. 정합 (현 5건 중 3건) |
| no | no | **OK** | spec 의존 + PLAN 정합 + 구현 중 drift 없음 (현 5건 중 2건) |
| yes | yes | **OK** | spec 의존 + PLAN 불일치 명시 + 구현 중에도 drift 유지 (드물지만 정합) |
| no | yes | **OK** | PLAN은 정합이었으나 구현 중 신규 spec drift 발견. 정상 case (REPORT § 도입 동기) |
| yes | no | **OK** | PLAN drift=yes 명시 후 PLAN/spec 수정해서 정합화. 정상 case |
| **N/A → no** | **FAIL** | PLAN scope = "외부 spec 의존 무" 선언인데 REPORT가 spec 정합 검증 = **scope 확장** | smoke FAIL |
| **N/A → yes** | **FAIL** | 동상 + drift 발견까지 = **명백한 scope 위반** | smoke FAIL |
| **no → N/A** | **WARN** | PLAN spec 의존 선언, REPORT N/A = scope 축소. 정상 가능 (구현 중 spec 의존 제거)이나 의심 케이스 | smoke WARN |
| **yes → N/A** | **WARN** | 동상 — drift 명시 후 N/A 회복은 의심. PLAN 재작성 가능성 | smoke WARN |

**핵심 분리선**:

- PLAN N/A → REPORT 비-N/A = **FAIL** (scope 위반, 사용자 재작성 의무)
- PLAN 비-N/A → REPORT N/A = **WARN** (scope 축소, 사용자 검토 권장)
- 그 외 5 case = **OK** (drift 진화 자연 패턴)

### R2 — `tests/smoke-spec-verification.sh` Stage 7 추가

**위치**: Stage 6 (REPORT.md § 검증) 종료 후 (Stage 6 `fi` 외부, 결과 출력 직전). `reports[]` 0건 시 skip 분기 첫 줄 (D1).

**알고리즘** (D1/D2/D4 반영):

```bash
# Stage 7 — Cross-file 일관성 (PLAN drift vs REPORT drift)
echo ""
echo "=== Stage 7 — Cross-file 일관성 (PLAN drift ↔ REPORT drift) ==="

if [ "${#reports[@]}" -eq 0 ]; then
    skip "Stage 7 — REPORT.md glob 매치 0건 (Stage 6 skip과 동기)"
else
    # REPORT 검사 대상이 reports[]에 이미 있음. 각 REPORT의 PLAN을 매칭
    # REPORT 경로: sessions/<scope>/<vX.Y-name>/REPORT.md
    # PLAN 경로:   sessions/<scope>/<vX.Y-name>/PLAN.md
    for rpt in "${reports[@]}"; do
        plan="${rpt%/REPORT.md}/PLAN.md"
        label=$(make_label "$rpt")
        if [ ! -f "$plan" ]; then
            skip "$label — PLAN.md 부재 (cross-check 불가)"
            continue
        fi
        plan_section=$(extract_section "$plan")
        rpt_section=$(extract_section "$rpt")
        plan_drift=$(extract_cell "$plan_section" "drift" | awk '{print $1}')
        rpt_drift=$(extract_cell "$rpt_section" "drift" | awk '{print $1}')

        case "${plan_drift}|${rpt_drift}" in
            # 5 OK case (drift 진화 자연 패턴)
            "N/A|N/A"|"no|no"|"yes|yes"|"no|yes"|"yes|no")
                ok "$label — drift PLAN=$plan_drift → REPORT=$rpt_drift (OK)"
                ;;
            # 2 FAIL case (scope 확장 — PLAN N/A 후 REPORT 비-N/A)
            "N/A|no"|"N/A|yes")
                fail "$label — drift PLAN=N/A → REPORT=$rpt_drift (FAIL: scope 확장 — PLAN 재작성 또는 REPORT N/A 정정)"
                ;;
            # 2 WARN case (scope 축소 — PLAN 비-N/A 후 REPORT N/A)
            "no|N/A"|"yes|N/A")
                # D2: WARN은 ok로 카운트 + ⚠️ marker로 시각적 구분 (smoke 결과 PASS 유지)
                ok "$label — drift PLAN=$plan_drift → REPORT=N/A ⚠️ scope 축소 검토 권장"
                ;;
            *)
                # D4: drift 값 비어있음 또는 yes/no/N/A 외 — Stage 2/3/6에서 이미 FAIL
                skip "$label — drift 값 비어있음 (Stage 2/3/6에서 이미 FAIL)"
                ;;
        esac
    done
fi
```

**검증 대상**: Stage 6의 `reports[]` 그대로 재사용. 동일한 레거시 면제 정책 (`is_legacy_report()`) 자동 inherit.

**예외 처리**:

- `reports[]` 0건: Stage 7 skip (Stage 6와 동기)
- PLAN.md 부재: skip (cross-check 불가)
- drift 값 extract 실패: skip (이전 stage가 이미 FAIL 잡음)

### R3 — `bootstrap/docs/SPEC_VERIFICATION.md` 갱신

**§3 (위반 정책) 표 확장 — Stage 7 위반 2건 추가** (D7):

| 위반 유형 | smoke 처치 |
|---------|---------|
| ... (기존) ... | ... |
| **(v1.32+ pair)** PLAN drift=N/A → REPORT drift=no/yes | FAIL — PLAN scope 위반 (PLAN N/A 선언 후 REPORT spec 의존 발견) 또는 REPORT N/A 정정 |
| **(v1.32+ pair)** PLAN drift=no/yes → REPORT drift=N/A | WARN — scope 축소 검토 권장 (smoke PASS 유지, ⚠️ marker) |

**§8-1 (smoke 검증 stage list) 확장**:

```
1. § 헤더 존재 — PLAN
2. § 구간 sub-field 5종 — PLAN
3. drift 값 yes/no/N/A — PLAN
4. drift=N/A 분기 4 sub-field 정합 — PLAN
5. SKILL.md 존재 + frontmatter 정합
6. (v1.27+) REPORT.md § 4 체크
7. (v1.32+) Cross-file 일관성 — PLAN drift ↔ REPORT drift 9 case 매트릭스
```

**§11 신설 — Cross-file 일관성 매트릭스 단일 소스**:

본 PLAN §R1 매트릭스를 docs §11로 이관 (smoke 코드 주석 ↔ docs §11 단일 소스).

## 3. 변경 대상 (2 수정 + 2 세션)

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-spec-verification.sh` | S2 | R2 — Stage 7 신설 (~50 lines, Stage 6 직후) |
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R3 — §3 표 2 row + §8-1 stage list + §11 신설 (매트릭스 단일 소스) |

### 세션 기록 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.32-report-cross-file-consistency/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.32-report-cross-file-consistency/REPORT.md` | meta | self-test 5건 PASS + 매트릭스 검증 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + Scope contract + Spec verification §
- [ ] **사용자 진입 확인**
- [ ] Stage A — `tests/smoke-spec-verification.sh` Stage 7 추가
- [ ] Stage B — `SPEC_VERIFICATION.md` §3/§8-1/§11 갱신
- [ ] Stage C — smoke 실행 → self-test (5건 모두 OK 예상)
- [ ] Stage D — 회귀 검증 (smoke-scope-contract 등 영향 0)
- [ ] Stage E — REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `tests/smoke-spec-verification.sh` Stage 7 추가 (50 lines 내외)
- [ ] 매트릭스 9 case 모두 코드 분기 처리 (5 OK + 2 FAIL + 2 WARN)
- [ ] `SPEC_VERIFICATION.md` §11 신설 + §3 위반 정책 2 row 추가 + §8-1 stage list 확장
- [ ] self-test: v1.27/v1.28/v1.31 (N/A→N/A 3건) + v1.29/v1.30 (no→no 2건) + **v1.32 자체 (no→no 예상)** = **6/6 OK** (D3)
- [ ] smoke 전체 결과: 기존 PASS=63 + Stage 7 PASS 6 = 추가 6 PASS, FAIL 0 유지
- [ ] 회귀 0 (smoke-scope-contract / 다른 smoke 영향 무)

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.32-report-cross-file-consistency — smoke Stage 7 cross-file drift 일관성 검증

- update: tests/smoke-spec-verification.sh (R2 — Stage 7 신설, PLAN drift ↔ REPORT drift 매트릭스 9 case)
- update: bootstrap/docs/SPEC_VERIFICATION.md (R3 — §3 위반 정책 2 row + §8-1 stage list + §11 매트릭스 단일 소스)
- add: sessions/meta/v1.32-.../{PLAN,REPORT}.md

Scope: PLAN drift vs REPORT drift cross-file 일관성 검증.
- 5 OK case: N/A→N/A, no→no, yes→yes, no→yes, yes→no
- 2 FAIL case: N/A→no, N/A→yes (scope 확장)
- 2 WARN case: no→N/A, yes→N/A (scope 축소, smoke PASS + ⚠️ marker)

Self-test: v1.27/v1.28/v1.31 (N/A→N/A) + v1.29/v1.30 (no→no) + v1.32 자체 (no→no) = 6/6 OK.
회귀 0 — smoke 외 다른 영향 무.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.32b-fix-cross-file-drift` | Stage 7 FAIL 발생 + `--fix` 자동 정정 요구 evidence (현재 0건, FAIL 자체 미발생) |
| `v1.32c-cross-section-consistency` | Citations / library / topic cross-file 일관성. evidence 3+ 누적 후 (drift만으로 충분 가설) |
| `v1.31b-evidence-counter` | 임계 도달 자동 인식 — 본 v1.32 진행은 사용자 발의 trigger. 자동화는 별 후속 |
| `v1.31c-scope-contract-enumerate-expand` (D8) | smoke-scope-contract.sh enumerate 확장 (현 v1.10h*/v1.10j*/v1.11* 한정 → v1.24+ 포함). 본 v1.32 진행 후 자연 발견 |
| `v1.36-skills-categories` (= v1.22 별칭) | 5번째 skill 추가와 동시 진행 (현 4 → 5). v1.31 ROADMAP §2 #5 |

## 8. Lessons Forward (예상)

- **L1 — evidence 3+ 임계는 baseline 정합 검증 + 향후 위반 자동 감지 두 효과** — 5건 모두 정합이지만 baseline이 깨끗할수록 향후 위반 자동 감지 신호 강함. evidence 3건 미만에서는 매트릭스 정의 자체가 임의적
- **L2 — WARN vs FAIL 분류는 "사용자 의도 변경 가능성" 기준** — scope 확장 (N/A→비-N/A)은 PLAN 오작성 또는 후행 발견, scope 축소 (비-N/A→N/A)는 spec 의존 제거 정상 case 가능. WARN으로 두면 사용자 검토 trigger
- **L3 — smoke Stage 추가 시 단일 소스 docs 동시 갱신 의무** — Stage 7 코드는 매트릭스 9 case 분기, docs §11은 매트릭스 의미 설명. 양쪽 drift 가능성. 향후 sentinel 검증 (v1.29c 후속) 추가 검토 가능

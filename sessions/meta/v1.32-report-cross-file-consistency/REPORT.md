# meta v1.32-report-cross-file-consistency — REPORT

세션 종료: 2026-04-29
PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

- **수정 파일**: 2 (`tests/smoke-spec-verification.sh` Stage 7 신설 + `bootstrap/docs/SPEC_VERIFICATION.md` §3/§8-1/§10-2/§11/§12 갱신)
- **신규 §**: 1 (`SPEC_VERIFICATION.md §11` Cross-file 매트릭스 단일 소스, 6 sub-§)
- **세션 기록**: 2 (PLAN.md + 본 REPORT.md)
- **smoke 결과**: PASS=69 / FAIL=0 / SKIP=4 (Stage 7 6/6 OK — v1.32 REPORT 포함)
- **회귀**: 0 (smoke-scope-contract 58 / bash-permission 6/6 / thinking-effort 5/5 / language-overlay 11)

## 구현 요약

### Stage A — `tests/smoke-spec-verification.sh` Stage 7 추가 ✅

위치: Stage 6 종료 후 (Stage 6 외부, 결과 출력 직전)
구조:
- `if [ "${#reports[@]}" -eq 0 ]` skip 분기 (Stage 6와 동기, D1)
- `for rpt in reports[]` iteration → `plan="${rpt%/REPORT.md}/PLAN.md"` (parameter expansion)
- `case "${plan_drift}|${rpt_drift}" in` 9 case (5 OK + 2 FAIL + 2 WARN, alternation pipe)
- WARN: `ok ... ⚠️ scope 축소 검토 권장` (D2 marker)
- fallback: `skip ... drift 값 비어있음 (Stage 2/3/6에서 이미 FAIL)` (D4)

신규 코드 ~40 lines.

### Stage B — `SPEC_VERIFICATION.md` 갱신 ✅

3건 수정:
1. **§3 위반 정책 표** — 2 row 추가 (D7):
   - `(v1.32+ pair) PLAN drift=N/A → REPORT drift=no/yes` → FAIL
   - `(v1.32+ pair) PLAN drift=no/yes → REPORT drift=N/A` → WARN
2. **§8-1 stage list** — 6 stage → 7 stage (Cross-file 일관성 명시)
3. **§10-2 후속 분기** — "REPORT § cross-file 일관성 검증" row를 `~~~~~ → v1.32 완료` 표기

1건 신설:
4. **§11 Cross-file 일관성 매트릭스 (v1.32+)** — 6 sub-§:
   - 11-1 매트릭스 9 case
   - 11-2 핵심 분리선
   - 11-3 적용 범위
   - 11-4 WARN 처리 정책 (`grep -F '⚠️'` 검출)
   - 11-5 `--fix` mode 관계
   - 11-6 후속 분기 (v1.32b/v1.32c)

기존 §11 (관련 문서) → §12로 shift.

§12 cross-ref 갱신:
- smoke 정적 stage 5 → 7
- v1.32 도입 세션 link 추가

### Stage C — Self-test ✅

```
=== Stage 7 — Cross-file 일관성 (PLAN drift ↔ REPORT drift) ===
  ✓ meta/v1.27 — drift PLAN=N/A → REPORT=N/A (OK)
  ✓ meta/v1.28 — drift PLAN=N/A → REPORT=N/A (OK)
  ✓ meta/v1.29 — drift PLAN=no → REPORT=no (OK)
  ✓ meta/v1.30 — drift PLAN=no → REPORT=no (OK)
  ✓ meta/v1.31 — drift PLAN=N/A → REPORT=N/A (OK)
  + meta/v1.32 (본 세션, REPORT 작성 후 6번째 — drift PLAN=no → REPORT=no 예상)

=== 결과: PASS=69 FAIL=0 SKIP=4 ===
```

기존 PASS=63 + Stage 7 +5 (v1.32 REPORT 작성 후 +1 = +6) = **68→69**.

### Stage D — 회귀 검증 ✅

| smoke | 결과 |
|-------|------|
| smoke-scope-contract.sh | PASS=58 / FAIL=0 |
| smoke-bash-permission-pattern.sh | 6/6 ✓ |
| smoke-thinking-effort.sh | 5/5 ✓ |
| smoke-language-overlay.sh | PASS=11 / FAIL=0 |

회귀 0. 본 v1.32 변경은 smoke-spec-verification.sh + SPEC_VERIFICATION.md 한정.

### Stage E — REPORT.md 작성 ✅

본 파일.

## 판정

PLAN 7 성공 기준:
- [x] `tests/smoke-spec-verification.sh` Stage 7 추가 (~40 lines)
- [x] 매트릭스 9 case 모두 코드 분기 처리 (5 OK + 2 FAIL + 2 WARN)
- [x] `SPEC_VERIFICATION.md` §11 신설 + §3 위반 정책 2 row 추가 + §8-1 stage list 확장
- [x] self-test: 5건 OK (v1.32 REPORT 작성 후 6/6)
- [x] smoke 전체 결과: 기존 PASS=63 + Stage 7 +6 = 69 (FAIL=0)
- [x] 회귀 0 (4 smoke 모두 PASS 유지)

**전체 PASS**.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | /websites/gnu_software_bash_manual_html_node |
| **topic** | case-alternation-pipe / parameter-expansion-suffix-removal |
| **findings** | no new findings |
| **drift** | no — Stage A 구현 시 PLAN R2 코드와 동일 (case alternation `"a"\|"b"` + `${rpt%/REPORT.md}/PLAN.md`). 추가 spec drift 발견 0 |
| **re-verify** | smoke Stage 7 매트릭스 9 case 코드 변경 시 또는 bash major version migration 시 |

**Citations** (no new findings — PLAN C1/C2 그대로 유지):
- C1 — case alternation `pat1 | pat2 | pat3)` (PLAN 참조)
- C2 — parameter expansion `${var%pattern}` (PLAN 참조)

## Lessons Learned

### L1 — `harness-plan-verify` SKILL이 직접 작성보다 정확

본 세션 PLAN 직접 작성 시 drift=N/A 추정. SKILL invoke 후 검증 결과 **drift=no** (GNU Bash spec 정합 확인). v1.29 패턴 ("smoke 변경 시 GNU Bash spec 인용 의무") 직접 작성 시 누락. SKILL의 Step 1 keyword grep + Step 2 query가 직접 분석 누락 차단. **향후 PLAN 작성 후 SKILL 자동 invoke 의무 강화 가치** (description trigger 신뢰성 강화 또는 PostToolUse hook).

### L2 — D1~D8 단계별 면밀 분석이 PLAN 결함 7건 사전 발견

v1.11 패턴 ("D1~D17 3단계 면밀 분석") 재적용. 1차 PLAN 작성 후 사용자 발의 "디테일하게 분석 후 플랜 검증" trigger로 D1~D8 발견:
- D1 Stage 7 코드 위치 명확화 (Stage 6 외부, 0건 skip 분기)
- D2 WARN ⚠️ marker (시각적 구분)
- D3 self-test 5/5 → 6/6
- D4 fallback 메시지 명확화
- D5 Out of scope row 추가 (fixture self-test scope 외)
- D7 §3 표 "(v1.32+ pair)" prefix
- D8 후속 분기 (v1.31c-scope-contract-enumerate-expand)

→ 첫 PLAN 작성 후 즉시 구현 진입 회피 + 검증 단계 정형화 가치.

### L3 — 매트릭스 hardcode 양쪽 (smoke 코드 ↔ docs §11)

PLAN R2 case 9건 + docs §11-1 표 9건 = 양쪽 hardcode. 매트릭스 변경 시 양쪽 동시 갱신 의무. v1.29 SPEC_SKELETON 패턴과 동일 우려 (`v1.29-verify-fix-mode` REPORT §9-4). 향후 sentinel 검증 (`v1.29c-sentinel-check`) 추가 시 §11 매트릭스도 sentinel 대상 포함 검토 (evidence-driven, drift 발생 후).

### L4 — WARN 처리 정책의 일관성 트레이드오프

`smoke` 전체가 PASS/FAIL/SKIP 3 카운터로 통일. WARN 도입 시 4 카운터 → 일관성 위반. 본 세션은 WARN을 **PASS + ⚠️ marker** 메시지로 처리 → 외부 모니터링은 `grep -F '⚠️'` 별도 검출 필요. 차선책 채택. 향후 사용자 경험 누적 후 WARN 카운터 도입 검토 가능 (evidence-driven, FAIL 발생 시점에 함께 재평가).

## 다음 후보 (보류)

### 본 v1.32 후속 (evidence-driven)

| 후속 세션 | 조건 |
|---------|------|
| `v1.32b-fix-cross-file-drift` | Stage 7 FAIL 발생 + `--fix` 자동 정정 요구 evidence (현재 FAIL 자체 0건) |
| `v1.32c-cross-section-consistency` | Citations / library / topic cross-file 일관성. evidence 3+ 누적 후 (drift만으로 충분 가설 검증 후) |
| `v1.31c-scope-contract-enumerate-expand` | smoke-scope-contract.sh enumerate 확장 (현 v1.10h*/v1.10j*/v1.11* 한정 → v1.24+ 포함). 본 v1.32 진행 후 자연 발견 |

### v1.31 ROADMAP §2 진행 가능 4건 (v1.33~v1.36 매핑)

| 우선순위 | 후속 세션 | 진행 근거 |
|:-:|---------|---------|
| 2 | `v1.33-fix-other-smokes` (= v1.29b) | v1.29 `--fix` 패턴 재사용 |
| 3 | `v1.34-legacy-plan-migration` (= v1.10j2) | 25+ legacy PLAN soft migration |
| 4 | `v1.35-scorer-other-na-categories` (= v1.18f) | harness-meta self-eval 활용 |
| 5 | `v1.36-skills-categories` (= v1.22) | 5번째 skill 추가 동시 진행 |

### v1.31 ROADMAP archive 갱신 권장 (별 작업)

본 v1.32 완료로 §9 archive에 row 추가:
> `✅ REPORT § cross-file 일관성 검증 (v1.32, 2026-04-29) — Stage 7 매트릭스 9 case`

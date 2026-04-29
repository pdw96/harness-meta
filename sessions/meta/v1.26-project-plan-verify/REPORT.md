# meta v1.26-project-plan-verify — REPORT

세션 완료: 2026-04-29
선행 세션: [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/REPORT.md) — Spec verification § meta 세션 의무화 + SKILL 신설

## 최종 결과

| 항목 | 결과 |
|------|------|
| smoke-spec-verification.sh | **PASS=19 FAIL=0 SKIP=3** (레거시 upbit v1.0~v1.2) |
| smoke-scope-contract.sh | **PASS=50 FAIL=0** (v1.26 self-test 흡수) |
| 회귀 smoke 9건 전체 | **9/9 PASS** |
| 변경 파일 | 4건 (smoke 2 + 문서 1 + 슬래시 1) + PLAN/REPORT |

## 구현 요약

### Stage A — smoke-spec-verification.sh 프로젝트 glob + 레거시 skip

| 변경 | 내용 |
|------|------|
| 헤더 주석 | "v1.26 확장 — 프로젝트 세션 PLAN도 검사" 1줄 추가 |
| `SKIP` 카운터 + `skip()` 헬퍼 | 추가 |
| `LEGACY_PROJECT_PLANS` 배열 | upbit v1.0/v1.1/v1.2 hardcode |
| `is_legacy()` 헬퍼 | 레거시 매칭 함수 |
| `make_label()` 헬퍼 | 프로젝트 prefix 포함 라벨 (`meta/v1.24`, `upbit/v1.3`) |
| Stage 1 glob | `meta/v1.2[4-9]*` + `meta/v1.[3-9][0-9]*` + `meta/v[2-9].*` + `<project>/v*` |
| Stage 2~4 label | `make_label()` 통일 (basename 방식 → 헬퍼 호출) |
| 결과 라인 | `=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ===` |

**실행 결과**:
```
=== Stage 1 — § 헤더 존재 ===
  - upbit/v1.0 — 레거시 면제 (v1.26 도입 이전) (SKIP)
  - upbit/v1.1 — 레거시 면제 (v1.26 도입 이전) (SKIP)
  - upbit/v1.2 — 레거시 면제 (v1.26 도입 이전) (SKIP)
  ✓ meta/v1.24 — § 헤더 존재
  ✓ meta/v1.25 — § 헤더 존재
  ✓ meta/v1.26 — § 헤더 존재
... (Stage 2~5 모두 PASS)
=== 결과: PASS=19 FAIL=0 SKIP=3 ===
```

### Stage B — SPEC_VERIFICATION.md §1.3 + §7-3 갱신

**§1.3 적용 범위 (L30-34)**:
- `In scope`: 2-line list로 변경 — `sessions/meta/v1.24+` + `sessions/<project>/v*` (v1.26 도입 이후)
- `Out of scope`: REPORT.md 후속 마커 `(v1.24d)` → `(v1.27)` 갱신, "§7-3 레거시 프로젝트 세션" 명시

**§7-3 신설 (L196-204)**:
- "v1.24b 후속 약속을 v1.26-project-plan-verify에서 이행" cross-ref
- 레거시 3건 명시
- Skip 정책 동결 + smoke 구현 위치 (`LEGACY_PROJECT_PLANS` 배열) 명시

### Stage C — harness-meta.md PLAN § 안내 갱신

L83 정확 교체:
- `(**의무 v1.24+**, sessions/meta/ only)` → `(**의무**: sessions/meta/v1.24+ 및 sessions/<project>/v1.26+)`

### Stage D — 회귀 검증

| Smoke | 결과 |
|-------|------|
| smoke-spec-verification.sh | PASS=19 FAIL=0 SKIP=3 |
| smoke-scope-contract.sh | PASS=50 FAIL=0 |
| smoke-bash-permission-pattern.sh | 6/6 PASS |
| smoke-thinking-effort.sh | 5/5 PASS |
| smoke-language-overlay.sh | 11/11 PASS |
| smoke-legacy-cleanup-overlay.sh | 9/9 PASS |
| smoke-skills-install.sh | 9/9 PASS |
| smoke-sync-agents.sh | 5/5 PASS |
| smoke-verify-sh-parity.sh | 5/5 PASS |
| **합계** | **9/9 smoke PASS, 회귀 0** |

### Stage E — smoke-scope-contract.sh v1.26 glob

L48 라인에 v1.25/v1.26 2건 추가. v1.25는 기존 누락분 보강, v1.26는 본 세션 self-test.
self-test 결과: **PASS=50 FAIL=0**.

## 판정

| PLAN 성공 기준 | 결과 |
|----------------|------|
| smoke-spec-verification.sh 레거시 3건 SKIP + meta 기존 PASS 유지 | ✅ |
| SPEC_VERIFICATION.md §1.3 In scope에 프로젝트 세션 명시 | ✅ |
| harness-meta.md meta-only 한정 문구 제거 | ✅ |
| 회귀 0 — 기존 smoke 전체 PASS 유지 | ✅ (9/9) |
| smoke-scope-contract.sh v1.26 self-test PASS | ✅ |

## Lessons Learned

### L1 — `make_label()` 헬퍼로 label 추출 일원화
원본 smoke는 `basename "$(dirname ...)" | sed 's/-.*//'`로 `v1.24`만 추출 → 프로젝트 세션 도입 시 `upbit/v1.3`과 `meta/v1.3` 구분 불가. 헬퍼로 추출 형식 통일 시 향후 신규 프로젝트 추가에도 자연 흡수.

### L2 — 레거시 skip 정책 동결 명시 가치
v1.10j / v1.24의 forward-only 패턴 답습이지만 **"동일 경로 재작성도 SKIP 유지"** 정책을 SPEC_VERIFICATION.md §7-3에 명시. 향후 upbit가 v1.0를 재작성해도 silent skip되는 fail-open 위험을 의도적 결정으로 문서화 → 사후 audit 가능.

### L3 — SPEC_VERIFICATION.md §7-3 cross-ref가 v1.24b 약속 추적성 확보
v1.24 PLAN Out of scope의 `(v1.24b)` 마커가 dangling reference로 남을 위험 있었음. v1.26이 약속 이행 세션이라는 cross-ref 1줄로 약속/이행 trail 확보. 향후 v1.24c (source matrix expand) / v1.24d (REPORT spec verify)도 동일 패턴 권장.

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.27-report-spec-verification` | REPORT.md에 § 의무 확장 (v1.24 Out of scope 약속 이행) |
| `v1.28-source-matrix-expand` | context7 source 매트릭스 확장 (Anthropic SDK / agents.md 등) |
| `v1.29-verify-fix-mode` | verify/smoke `--fix` 모드 — § skeleton 자동 삽입 |
| `v1.30-precommit-hook` | pre-commit hook으로 smoke 강제 |
| `v1.31-postoolse-hook` | PostToolUse deterministic trigger |
| `v1.11d-codedir-skeleton` | `<proj>/{HM_CODE_DIR}/` 골격 자동 생성 |

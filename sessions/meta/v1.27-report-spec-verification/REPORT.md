# meta v1.27-report-spec-verification — REPORT

세션 완료: 2026-04-29
선행 세션: [`sessions/meta/v1.26-project-plan-verify/`](../v1.26-project-plan-verify/REPORT.md) — Spec verification § 프로젝트 세션 확장

## 최종 결과

| 항목 | 결과 |
|------|------|
| smoke-spec-verification.sh | **PASS=27 FAIL=0 SKIP=4** (레거시 upbit 3건 + meta v1.26 대표 1건) |
| smoke-scope-contract.sh | **PASS=52 FAIL=0** (v1.27 self-test 흡수) |
| 회귀 smoke 9건 전체 | **9/9 PASS** |
| 변경 파일 | 3건 (SPEC_VERIFICATION.md + smoke + harness-meta.md) + PLAN/REPORT |

## 구현 요약

### Stage A — SPEC_VERIFICATION.md 갱신

| 변경 위치 | 내용 |
|-----------|------|
| 타이틀 L1 | `PLAN context7 검증 § 규격` → `PLAN/REPORT context7 검증 § 규격` |
| §1-2 목록 | REPORT § 참조 추가 (§2-5 ~ §2-6), 번호 재정렬 |
| §1-3 적용 범위 | In scope에 REPORT.md 2줄 추가. Out of scope에서 `REPORT.md (v1.27)` 마커 제거 |
| §2 말미 | `### 2-5. REPORT.md § 규격 (v1.27+)` + `### 2-6. REPORT drift 값 매트릭스 (post-hoc)` 신설 |
| §3 위반 정책 | REPORT.md § 누락 / sub-field 누락 2 row 추가 |
| §7 말미 | `### 7-4. REPORT 레거시 정책 (v1.27 도입)` 신설 |
| §8-1 smoke | 5 stage → 6 stage 표기 갱신 |
| §9-2 후속 분기 | v1.26 완료 / v1.27 완료 표기 + v1.28/v1.29/v1.30 renumber |

### Stage B — smoke-spec-verification.sh Stage 6 추가

| 변경 | 내용 |
|------|------|
| 헤더 주석 | v1.27 확장 + Stage 6 설명 2줄 추가 |
| `LEGACY_REPORTS_META_BEFORE=27` | meta v1.X < 27 동적 레거시 판정 상수 |
| `is_legacy_report()` 헬퍼 | meta minor < 27 → SKIP. 프로젝트 세션 REPORT 현재 전체 → SKIP |
| `make_label()` 갱신 | `PLAN\.md` 고정 → `[^/]+\.md` (PLAN/REPORT 모두 지원) |
| Stage 6 본문 | REPORT glob + 레거시 skip 보고 + 4 체크 (헤더/sub-field/drift/N/A분기) |

**실행 결과 (REPORT.md 작성 후)**:
```
=== Stage 6 — REPORT.md § (v1.27+) ===
  - meta/v1.26 — 레거시 면제 (v1.27 도입 이전, 대표 표시) (SKIP)
  ✓ meta/v1.27 REPORT — § 헤더 존재
  ✓ meta/v1.27 REPORT — sub-field 5종 모두 존재
  ✓ meta/v1.27 REPORT — drift=N/A
  ✓ meta/v1.27 REPORT — drift=N/A + 다른 4 sub-field 정확히 N/A
```

### Stage C — harness-meta.md REPORT 필수 섹션 갱신

`### 5. REPORT.md 작성 (세션 종료 시)` 필수 섹션 목록에 `**Spec verification (context7)**` 1줄 추가:
- 위치: 판정 § 직후
- 의무: v1.27+
- 참조: `bootstrap/docs/SPEC_VERIFICATION.md §2-5`

## 판정

| PLAN 성공 기준 | 결과 |
|----------------|------|
| `SPEC_VERIFICATION.md` §1.3 In scope에 REPORT.md (v1.27+) 명시 | ✅ |
| `SPEC_VERIFICATION.md` §2에 REPORT § subsection (2-5/2-6) | ✅ |
| `SPEC_VERIFICATION.md` §7-4 신설 (REPORT 레거시 정책) | ✅ |
| `smoke-spec-verification.sh` Stage 6 신설 (REPORT 4 체크) | ✅ |
| `harness-meta.md` REPORT 필수 섹션 갱신 | ✅ |
| v1.27 REPORT.md § 채워짐 (self-validate) | ✅ |
| smoke-spec-verification.sh PASS (v1.27 REPORT self-test 포함) | ✅ |
| 회귀 0 — 기존 smoke 9/9 PASS 유지 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 규약·문서 정의만. PLAN § 동일) |
| **re-verify** | N/A |

## Lessons Learned

### L1 — `is_legacy_report()` 동적 판정으로 레거시 배열 유지 비용 0

PLAN 레거시(`LEGACY_PROJECT_PLANS`)는 경로 하드코딩 배열. REPORT 레거시는 경우가 너무 많음 (meta v1.0~v1.26 + 프로젝트 세션 전체). 버전 숫자(`minor < 27`) 비교 + case-match 조합으로 동적 판정 → 배열 유지 비용 0.

### L2 — `make_label()` 단일 갱신으로 PLAN/REPORT 양쪽 지원

기존 `s|.../PLAN\.md|` 고정 패턴을 `s|.../[^/]+\.md|`로 1자 변경 → Stage 1~4 (PLAN)과 Stage 6 (REPORT) 동일 헬퍼 재사용. 파일명 독립적 label 추출.

### L3 — `findings` 허용 값 확장이 REPORT § 핵심 differentiator

PLAN §에서 `findings`는 `see citations below` 또는 `N/A`만 허용. REPORT §는 `no new findings`를 추가 허용 — "구현 중 새 발견 없음" 선언이 가능해야 REPORT가 의미 있는 post-hoc 체계로 기능. smoke는 형식만 검증하므로 이 값 추가로 FAIL 없음.

## 다음 후보 (보류)

| 세션 | 조건 |
|------|------|
| `v1.28-source-matrix-expand` | context7 source 매트릭스 확장 — evidence-driven |
| `v1.29-verify-fix-mode` | smoke `--fix` § skeleton 자동 삽입 |
| `v1.30-precommit-hook` | pre-commit hook으로 smoke 강제 |
| REPORT § cross-file 일관성 검증 | REPORT drift vs PLAN drift 대조. evidence 3+ 사례 누적 후 |

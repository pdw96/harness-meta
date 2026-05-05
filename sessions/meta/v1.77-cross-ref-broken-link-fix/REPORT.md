# REPORT — v1.77 Cross-ref broken link fix

## 최종 결과

- **변경 파일**: 6건 — `bootstrap/CLAUDE.md` + `bootstrap/docs/SPEC_VERIFICATION.md` + `docs/adr/ADR-004-permission-pattern.md` + `docs/ARCHITECTURE.md` + 본 세션 PLAN/REPORT
- **edit hunk**: 4 (각 파일 1 hunk, SPEC_VERIFICATION.md는 4 occurrence 일괄 정정)
- **post-fix audit**: living docs broken=0 (12 잔존은 모두 backtick 내부 false positive 확정 검증)
- **smoke 회귀**: 0
  - `tests/smoke-spec-verification.sh`: PASS=540 FAIL=0 SKIP=4
  - `tests/smoke-scope-contract.sh`: PASS=174 FAIL=0 SKIP=0
  - `tests/smoke-roadmap-sync.sh`: PASS=31 FAIL=0 SKIP=85 WARN=0

## 구현 요약

| # | Goal (PLAN sub-item) | Implementation | 상태 |
|--:|---------------------|---------------|:----:|
| B1 | `bootstrap/CLAUDE.md:109` upbit v0.1-bootstrap row 삭제 | `Bootstrap 첫 적용 사례 — upbit: ...` 1 line 삭제 | ✅ |
| B2 | `bootstrap/docs/SPEC_VERIFICATION.md` SKILL path 정정 | `harness-plan-verify` → `audit/harness-plan-verify` 4 occurrence (line 237/322/393/467) replace_all | ✅ |
| B3 | `docs/adr/ADR-004-permission-pattern.md:43` upbit v1.2 row 삭제 | `T4 후행 세션: ...` 1 line 삭제 | ✅ |
| B4 | `docs/ARCHITECTURE.md:45` PHILOSOPHY.md row 삭제 | docs 표 PHILOSOPHY.md row 삭제 | ✅ |

PLAN `Scope inheritance` 4 sub-item ↔ REPORT 구현 4건 **1:1 매핑** 정합. B2는 PLAN 의도대로 4 occurrence 일괄 정합 fix (line 467 markdown link + line 237/322/393 backtick code refs 모두 stale path → 일관성 보장).

## 판정

- [x] B1: bootstrap/CLAUDE.md line 109 row 삭제
- [x] B2: SPEC_VERIFICATION.md SKILL path → `audit/` sub-category 추가 (4 occurrence 정합)
- [x] B3: ADR-004 line 43 row 삭제
- [x] B4: docs/ARCHITECTURE.md PHILOSOPHY.md row 삭제
- [x] post-fix audit 재실행 → living docs broken=0 (false positive 12건만 잔존)
- [x] smoke 3종 PASS — 회귀 0
- [x] git diff 변경 4 파일 (의도 외 회귀 0)
- [x] PLAN `Scope inheritance` 4 sub-item ↔ REPORT 구현 4건 1:1 매핑

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 docs 4 파일 broken ref 정정, 외부 spec 의존 없음 |
| **re-verify** | N/A |

**Citations**: N/A (PLAN N/A → REPORT N/A 자연 진화 — Stage 7 cross-file 일관성 OK case)

## Lessons Learned

- **L1 — 단순 broken link audit는 false positive 다수 발생**: 1차 raw audit 16 broken 중 12건 (75%) false positive (backtick 내부 @import discussion + `[text](path)` 형식의 literal markdown 코드). 향후 audit 인프라화 시 backtick code block 외부 link만 검출하는 정밀 필터 필수.
- **L2 — 동일 fix 일관성 우선 ↔ scope 엄격성 절충**: B2는 audit이 line 467 markdown link 1건만 검출. 그러나 line 237/322/393 backtick code refs도 동일 stale path. 4 occurrence 일괄 fix 채택 (PLAN B2 sub-item "SPEC_VERIFICATION SKILL path 정정" 의도 정합) — 부분 fix는 일관성 붕괴.
- **L3 — replace_all 활용 vs 단일 Edit**: B2 4 occurrence는 replace_all 활용 적합 (동일 stale string → 동일 fix). 그러나 line 467은 markdown link `(target)` 형식이라 prefix 다름 (`bootstrap/skills/...` vs `../skills/...`) — 2 step replace_all로 처리.
- **L4 — Cross-ref smoke 인프라 신설 미달**: 본 세션은 fix만 — `tests/smoke-cross-ref.sh` 인프라 신설은 사용자 결정으로 후속 분리. 정밀 backtick filter + `--fix` mode 동반 필요. evidence 누적 (broken ref 재발 또는 사용자 요구) 시 v1.78 또는 그 이후 세션 발의.

## 다음 후보 (보류)

본 세션은 broken link fix 자체. 신규 trigger 등록 후속:

- **`v1.78-cross-ref-smoke-infra`** (또는 evidence 누적 후) — `tests/smoke-cross-ref.sh` 신설 (backtick filter + 정밀 검출 + `--fix` mode). 분류: §3-B (회귀/장애 evidence 의존, broken ref 재발 시 trigger)

## 선행 / 후속 세션

- **선행**: [`v1.72-docs-cleanup/`](../v1.72-docs-cleanup/) + [`v1.76-roadmap-audit-cleanup/`](../v1.76-roadmap-audit-cleanup/) — docs cleanup 패턴 source
- **후속 (잠재)**: `v1.78-cross-ref-smoke-infra` (audit 자동화) — backtick filter 정밀화 + smoke `--fix` mode

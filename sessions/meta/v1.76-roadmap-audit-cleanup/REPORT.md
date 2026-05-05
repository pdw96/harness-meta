# REPORT — v1.76 ROADMAP audit + cleanup

## 최종 결과

- **변경 파일**: 3건 — `sessions/meta/ROADMAP.md` + 본 세션 `PLAN.md` + `REPORT.md`
- **edit hunk**: 6 영역 (§1 audit / §2 안내문 / §3-A count / §3-A v1.75d 제거 / §3-B count / §3-B v1.75d 추가 / §3-F 제거)
- **smoke 회귀**: 0
  - `tests/smoke-roadmap-sync.sh`: PASS=31 FAIL=0 SKIP=84 WARN=0
  - `tests/smoke-spec-verification.sh`: PASS=531 FAIL=0 SKIP=4
  - `tests/smoke-scope-contract.sh`: PASS=172 FAIL=0 SKIP=0

## 구현 요약

| # | Goal (PLAN sub-item) | Implementation | 상태 |
|--:|---------------------|---------------|:----:|
| 1 | §2 stale 안내문 갱신 | `(0건 — v1.73 완료 후. ...)` → `(0건. ...)` | ✅ |
| 2 | §3-F 빈 섹션 제거 | 헤더 + 설명문 4줄 삭제 | ✅ |
| 3 | v1.75d 분류 §3-A→B | row 이동 + count 라벨 16→15 / 11→12 / 합계 35 유지 | ✅ |
| 4 | §1 audit 일자 갱신 | `v1.75-module-context-injection 기준 — 옵션 X / Manual Context Injection 채택` → `v1.76-roadmap-audit-cleanup 기준` | ✅ |

PLAN `Scope inheritance` 4 sub-item ↔ REPORT 구현 4건 **1:1 매핑** 정합.

## 판정

- [x] §2 안내문 갱신 — "v1.73 완료 후" 표현 제거
- [x] §3-F 헤더 + 설명문 완전 제거 (검색 0 hit)
- [x] §3-A에서 v1.75d row 제거, §3-B에 추가 + count 라벨 정합 (15+12=27, 합계 35→35 유지)
- [x] §1 last audit 일자 v1.76 반영
- [x] smoke 3종 (roadmap-sync default + spec-verification + scope-contract) PASS
- [x] git diff `sessions/meta/ROADMAP.md` 변경 4 영역 이내 (의도 외 회귀 0)
- [x] PLAN `Scope inheritance` 4 sub-item ↔ REPORT 구현 4건 1:1 매핑

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 ROADMAP 1 파일 정정, 외부 spec 의존 없음 |
| **re-verify** | N/A |

**Citations**: N/A (PLAN N/A → REPORT N/A 자연 진화 — Stage 7 cross-file 일관성 OK case)

## Lessons Learned

- **L1 — PLAN spec sub-field lowercase 의무**: `Spec verification (context7)` § 표 헤더는 `library` / `topic` / `findings` / `drift` / `re-verify` **lowercase 정확**. PascalCase(`Library` 등)는 `smoke-spec-verification.sh` Stage 2 FAIL (sub-field 누락 판정). v1.75 PLAN 형식 답습 권장. SKILL `harness-plan-verify` 자동 사용 시 sub-field 형식 정합 자동 보장.
- **L2 — `--fix` mode 미보유 → 수동 정정 비용**: smoke-spec-verification PLAN sub-field 형식 위반은 현재 `--fix` mode 미보유. 위반 발견 시 수동 Edit 필수. 후속 trigger: 동일 위반 evidence 3+ 누적 시 `vX.Y-fix-spec-verification-headers` 발의 가능 (현재는 v1.61 패턴으로 발의 미달 — 본 세션 1건만 발생).
- **L3 — Single-file cleanup scope 적정성**: 1 파일 4 row 정정 + 3 smoke 회귀 검증 = 1 commit 적합. v1.72-docs-cleanup 패턴 답습. 5 관점 병렬 review skip(사용자 결정) 정합 — trivial scope에서 review 비용 ROI 낮음.

## 다음 후보 (보류)

본 세션은 ROADMAP audit cleanup 자체. 신규 trigger 등록 없음. PLAN `Out of scope`에서 분리한 2 항목:

- **§1 trigger 분류 (5종) 자체 재설계** — T2 spec 변경. 사용자 발의 시 별도 메타 세션
- **§8 최근 완료 row 형식 재구조화** — `harness-roadmap-update` SKILL 형식 변경 동반 필요

위 2 항목 모두 evidence-driven (사용자 발의 또는 SKILL 사용 패턴 변화 trigger).

## 선행 / 후속 세션

- **선행**: [`v1.72-docs-cleanup/`](../v1.72-docs-cleanup/) — ROADMAP §3 cleanup 패턴 source (✅ 완료 21건 행 삭제 → 본 세션 4 영역 정정 답습)
- **후속 (잠재)**: §3 row evidence 도달 시 §2 promote — 세션별 발의 (각 row 별 trigger)

# meta v1.52-roi-smoke-regression — REPORT

세션 완료: 2026-05-04
선행 세션: [`sessions/meta/v1.51-roi-action-bug-fix/`](../v1.51-roi-action-bug-fix/REPORT.md)

## 최종 결과

- **신규 파일**: 1건 (`tests/smoke-roi-regression.sh`)
- **smoke 결과**: 6/6 PASS (정적 4 + 동적 2)
- **회귀**: 0 (smoke-scope-contract PASS=124, smoke-spec-verification PASS=315 SKIP=4)

## 구현 요약

| 목표 | 구현 | 상태 |
|------|------|------|
| `smoke-roi-regression.sh` 신설 | `tests/smoke-roi-regression.sh` 작성 + chmod +x | ✅ |
| 정적 4 checks | S1~S4 조건식 grep | ✅ |
| 동적 2 checks | D1(eligible 1건 확인) + D2(na=True 배제 확인) | ✅ |
| 기존 smoke 회귀 0 | scope-contract/spec-verification 검증 | ✅ |

**Architecture 검토 수정**: agent 검토에서 `CheckResult` → `Check` 클래스명 불일치 발견 → PLAN mock test 코드 수정 (`passed`, `detail` 필수 필드 추가 포함).

## 판정

- [x] `tests/smoke-roi-regression.sh` 존재 + executable
- [x] 정적 체크 4/4 PASS
- [x] 동적 체크 2/2 PASS
- [x] 기존 smoke 회귀 0

**PASS** — 모든 성공 기준 충족.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 smoke 스크립트 신설만) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — Architecture subagent가 클래스명 오류 사전 발견**: `CheckResult` vs `Check` 불일치를 구현 전에 잡아 dynamic mock test 실패 예방. 5 관점 검토 값 확인.
- **L2 — na=True 배제 검증(D2)의 중요성**: "올바른 0건"과 "버그 0건"을 구분하는 명시적 test case가 회귀 감지의 핵심. smoke에 negative test 포함 패턴 정착.

## 다음 후보 (보류)

- `v1.51b-roi-smoke` → **본 세션에서 이행 완료** (ROADMAP §3-B 해소)
- 기타 §3 항목은 각 trigger 조건 대기 유지

# meta v1.10h2-l5-readme-link-cleanup — REPORT

세션 종료: 2026-04-28
선행 세션:
- [`sessions/meta/v1.10h-agents-md-license-line-policy/`](../v1.10h-agents-md-license-line-policy/REPORT.md) — Out of scope 표에서 본 v1.10h2 분리 명시

## 1. 최종 결과

| 지표 | 수치 |
|------|:---:|
| 변경 파일 (R1 AGENTS.md.tmpl) | **1** |
| 신규 파일 (smoke 1 + PLAN/REPORT 2 + evidence 1) | **4** |
| smoke stage (v1.10h2 + 회귀 v1.10h/d/f/g) | **1 + 4 + 6 + 6 + 5 = 22** |
| smoke 2/2 | **PASS** |
| L5 라인 정리 (sub-item 1) | **1 / 1** |
| Out of scope 명시 분리 | **5건 (PLAN 4 + 신규 1)** |

## 2. 구현 요약

### R1 — `bootstrap/skeletons/AGENTS.md.tmpl` L5 정리

```diff
-License: {{license}} See [README.md](README.md) for project overview (human-readable).
+License: {{license}}
```

근거:
- L7 blockquote (`AGENTS.md complements README.md...`) 중복 해소
- v1.10h Case 1 치환 결과의 두 링크 한 라인 충돌 해소 (`MIT (see [LICENSE](LICENSE))` + `See [README.md]`)
- "human-readable" 한정자 제거 (AGENTS.md non-human-readable 함의 차단)
- AGENTS.md spec 컨벤션 정합 — license 라인 = license-only

### Smoke — `tests/smoke-l5-readme-link-cleanup.sh`

1 stage 2 checks:
- Check 1: L5 `See [README.md]` 잔존 0
- Check 2: L5 = `License: {{license}}` exact match (sed line 5)

LF eol + set -euo pipefail.

## 3. Smoke 결과

### v1.10h2 — `tests/smoke-l5-readme-link-cleanup.sh` 2/2 PASS

```
Stage 1 — AGENTS.md.tmpl L5
  ✓ L5 'See [README.md]' 잔존 0
  ✓ L5 단독 'License: {{license}}' 일치

결과: 2 PASS / 0 FAIL
```

evidence: [`evidence/smoke-l5-readme-link-cleanup.txt`](evidence/smoke-l5-readme-link-cleanup.txt)

### 회귀 — v1.10h 11/11 + v1.10d 6/6 + v1.10f 6/6 + v1.10g 5/5 PASS

| Smoke | 결과 |
|------|:---:|
| `tests/smoke-license-line-policy.sh` (v1.10h) | 11/11 ✓ |
| `tests/smoke-bash-permission-pattern.sh` (v1.10d) | 6/6 ✓ |
| `tests/smoke-broad-bash-fine-grain.sh` (v1.10f) | 6/6 ✓ |
| `tests/smoke-thinking-effort.sh` (v1.10g) | 5/5 ✓ |

R1은 AGENTS.md.tmpl 1행 — 다른 smoke 무영향. 회귀 0건.

### ⚠️ 사전 존재 실패 감지 (v1.10h2 무관 — Out of scope)

`tests/smoke-bootstrap-agents-md.sh` Stage 2 FAIL (`FAIL S2 license placeholder`).

**검증** (git stash로 v1.10h2 변경 제외 후 재실행 확인):
- v1.10h2 변경 적용 전에도 동일 FAIL 발생 → **사전 존재 실패** (pre-existing)
- 마지막 갱신: commit `9a89bc6` (v1.10c, 2026-04 — `License: see LICENSE` placeholder 검사)
- v1.10e (`{{license}}` 변수 도입, 2026-04-26 commit `f450dcb` 이후) 이후 outdated — `{{license}}` 변수가 sed 치환되어 `License: see LICENSE` 텍스트 부재
- v1.10e/e2/e3/g가 본 smoke를 회귀 검증 list에서 제외했기에 발견 지연

**처리 방침**: 본 v1.10h2 scope 외 — Out of scope `## Out of scope (explicit rejection)` 표에 신규 추가 (이 REPORT에서 사후 명시):

| ❌ Item | 분리 대상 | 진행 상태 |
|--------|---------|:---:|
| `tests/smoke-bootstrap-agents-md.sh` Stage 2 + Stage 4 `License: see LICENSE` assertion 갱신 | 별도 후속 (예: **`v1.10h3-stale-smoke-fix`**) | 미작성 |

본 v1.10h2가 새 실패를 introduce하지 않음 (regression-free 보존).

## 4. 판정

| PLAN 체크박스 | 상태 |
|------|:---:|
| 세션 디렉토리 생성 | ✓ |
| PLAN.md placeholder 작성 | ✓ |
| Stage A — AGENTS.md.tmpl R1 | ✓ |
| Stage B — Smoke 2/2 PASS | ✓ |
| Stage C — REPORT.md | ✓ (본 파일) |
| 사용자 확인 후 커밋 | (대기) |

→ **모든 PLAN 목표 달성**. 사용자 확인 후 커밋.

## 5. Lessons Learned

### L1 — Scope contract 두 섹션 mechanism 2차 demo 성공

본 v1.10h2가 v1.10h에 이은 **2차 demo**:
- 사전 존재 실패 (`smoke-bootstrap-agents-md.sh`) 발견 시 즉시 본 세션 scope에 흡수하지 않고 `## Out of scope` 표에 신규 추가 → 별도 v1.10h3 세션 분리
- 인접 발견 issue를 본문 진입 차단 → strict scope 유지

mechanism 효과 누적. v1.10j 정식화 시 evidence 강화.

### L2 — Smoke 회귀 list 누락 위험

`smoke-bootstrap-agents-md.sh`가 v1.10e ~ v1.10g 4 세션 동안 회귀 검증에서 누락 → 사전 존재 실패가 6+ 개월 지연 발견.

**개선 후보** (v1.10j 또는 별도 세션):
- 모든 `tests/smoke-*.sh`를 자동 sweep하는 meta-smoke 스크립트
- 또는 `verify.ps1`이 모든 smoke를 한 번에 실행 + WARN 출력

### L3 — git stash로 변경 격리 검증

사전 존재 실패 vs 본 세션 introduce 실패 구분 시 `git stash` 효과적:
1. `git stash` (변경 격리)
2. 회귀 smoke 재실행 — 같은 실패 → 사전 존재
3. `git stash pop` (변경 복원)

본 기법은 향후 회귀 분석 표준 절차로 활용 가능.

## 6. 후속 세션

| 세션 | scope | 상태 |
|------|------|:---:|
| **`v1.10h3-stale-smoke-fix`** (가설) | S2 | 미작성 — `smoke-bootstrap-agents-md.sh` Stage 2/4 assertion 갱신 |
| `v1.10j-scope-contract-discipline` | S2 | placeholder PLAN ✓ — 본 demo 효과 정량화 후 정식화 |
| `v1.10i` (가설) | S2 | 미작성 — Case 3 / Issue B / 정규화 map |

## 7. 관련 문서

- PLAN: [`PLAN.md`](PLAN.md)
- evidence: [`evidence/smoke-l5-readme-link-cleanup.txt`](evidence/smoke-l5-readme-link-cleanup.txt)
- 선행 세션 v1.10h: [`../v1.10h-agents-md-license-line-policy/`](../v1.10h-agents-md-license-line-policy/)
- 후속 placeholder v1.10j: [`../v1.10j-scope-contract-discipline/PLAN.md`](../v1.10j-scope-contract-discipline/PLAN.md)

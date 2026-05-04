# meta v1.10j-scope-contract-discipline — REPORT

세션 종료: 2026-04-28
선행 세션:

- [`sessions/meta/v1.10h-agents-md-license-line-policy/`](../v1.10h-agents-md-license-line-policy/REPORT.md) — Scope inheritance/Out of scope 1차 demo (3 세션 연속 적용)
- [`sessions/meta/v1.10h3-stale-smoke-fix/`](../v1.10h3-stale-smoke-fix/REPORT.md) — 직전 완료 세션

## 1. 최종 결과

| 지표 | 수치 |
|------|:---:|
| 수정 파일 | **2** (`OWNERSHIP.md`, `harness-meta.md`) |
| 신규 파일 | **3** (`smoke-scope-contract.sh`, `PLAN.md`, `REPORT.md`) |
| smoke 10/10 | **PASS** |
| 회귀 (h2 2/2 + permission 6/6 + thinking-effort 5/5) | **PASS** |

## 2. 구현 요약

### R1 — OWNERSHIP.md Scope contract § 신설

`bootstrap/docs/OWNERSHIP.md`의 `## Tie-breakers (T1–T5)` 직후, `## PLAN 템플릿` 직전에 신규 섹션 삽입.

내용:

- 두 섹션 **의무 위치** (세션 소속 근거 직후)
- `## Scope inheritance` 규격 — verbatim 인용 + Parsed sub-items 선언 의무
- `## Out of scope` 규격 — 인접 발견 issue 표 명시 의무
- **위반 정책 표** (3 유형: 누락/over-scope/추가 누락)
- 레거시 세션 소급 면제 명시

### R2 — harness-meta.md 안내 갱신

`claude/commands/harness-meta.md` `### 3. PLAN.md 작성` 절에 두 섹션을 **필수 섹션** 목록 최상단에 추가. OWNERSHIP.md 참조 링크 포함.

### R3 — smoke-scope-contract.sh (10 checks)

`tests/smoke-scope-contract.sh` 신규 작성. 3 stage:

- Stage 1: v1.10h / v1.10h2 / v1.10j PLAN.md × 2 섹션 = 6 checks
- Stage 2: OWNERSHIP.md `## Scope contract` § + `위반 정책` = 2 checks
- Stage 3: harness-meta.md 안내 2 = 2 checks

## 3. Smoke 결과

### v1.10j — `tests/smoke-scope-contract.sh` 10/10 PASS

```
[Stage 1] v1.10h/h2/j PLAN.md 두 섹션 존재 6/6 PASS
[Stage 2] OWNERSHIP.md Scope contract § 존재 2/2 PASS
[Stage 3] harness-meta.md 안내 2/2 PASS
=== 결과: PASS=10 FAIL=0 ===
```

### 회귀

- v1.10h2 `smoke-l5-readme-link-cleanup.sh` 2/2 PASS
- v1.10d `smoke-bash-permission-pattern.sh` 6/6 PASS
- v1.10g `smoke-thinking-effort.sh` 5/5 PASS

## 4. 판정

| 목표 | 결과 |
|------|:---:|
| OWNERSHIP.md `## Scope contract` § 존재 + 위반 정책 명시 | ✅ |
| harness-meta.md 두 섹션 의무 반영 | ✅ |
| Smoke 자동 검사 v1.10h/h2/j 3개 PASS | ✅ |
| 향후 sessions/meta/ PLAN.md 의무 적용 (rule 확정) | ✅ |

PLAN 체크박스 3/3 완수.

## 5. Lessons Learned

- **L1 — demo → rule 전환 기준**: v1.10h에서 3 세션 연속 Scope contract 자연 적용 → rule화 적기 판단 적중. 1~2회 demo로는 패턴 안정성 부족
- **L2 — 위반 정책의 3 유형 명시 효과**: "누락 = 거부"만 있으면 구현 중 추가 발견을 숨기는 인센티브 발생 → 3번째 유형(구현 중 누락 추가 허용 + PLAN 즉시 갱신)으로 실용성 확보
- **L3 — 레거시 소급 면제**: 25+ 세션 소급은 비용 대비 효과 낮음. 새 rule은 미래 세션에만 적용 → 채택 마찰 0

## 6. 다음 후보 (보류)

| 항목 | 분리 세션 |
|------|---------|
| 기존 sessions PLAN.md 소급 갱신 (legacy 25+ 세션) | v1.10j2-legacy-plan-migration (evidence-driven) |
| `verify.ps1`에 smoke-scope-contract 통합 | v1.21-cross-platform-install (통합 verify) |
| 프로젝트 sessions (S6) PLAN.md 의무화 | 별도 후속 |
| v1.10i (non-SPDX 정규화 + Issue B + Case 3) | evidence-driven 조건 미달 시 계속 보류 |

# meta v1.31b-roadmap-archive-arrears — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/) — EVIDENCE_DRIVEN_ROADMAP.md 신설 + §6-1 갱신 정책 정의
- [`sessions/meta/v1.35-scorer-other-na-categories/`](../v1.35-scorer-other-na-categories/) — §2 #4 (v1.18f alias) 진행, archive 갱신 누락
- [`sessions/meta/v1.18g2-helper-threshold-revisit/`](../v1.18g2-helper-threshold-revisit/) — v1.35 D1 부수 발견 후속, archive 갱신 누락

목적: EVIDENCE_DRIVEN_ROADMAP.md §2 / §8 / §9 갱신. v1.35(`v1.18f` alias) §2 row 4 완료 표시 + v1.35 + v1.18g2 archive 2 row 추가 + §8 확정 세션 list에 2 row 추가. v1.31 §6-1 갱신 정책 정합 (해당 row를 archive로 이관).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(1) `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` = **1/1 meta**
- **T1 경로 다수결** — meta scope 1/1
- **T2 스펙 vs 값** — bootstrap/docs 갱신 (모든 meta 세션 audit trail 영향) → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` §6-1 (verbatim)**:

> 해당 row를 `✅ 완료 (vX.Y 세션, YYYY-MM-DD)` 표기 후 **archive 섹션** (§9 신설 예정)으로 이동. §2 활성 목록 축소.

**Source 2 — `sessions/meta/v1.35-scorer-other-na-categories/REPORT.md` 판정 (verbatim)**:

> | categories_quality.py: 6 sub-checks N/A 분기 추가 (Documentation 2 + Test 4) | ✅ |

(전 항목 ✅ — §2 #4 완료 자격 충족)

**Source 3 — `sessions/meta/v1.18g2-helper-threshold-revisit/REPORT.md` 최종 결과 (verbatim)**:

> | harness-meta 점수 | 90/100 (S) → **93/100 (S)** (+3, PLAN 92 예상보다 +1 — PLAN 산술 오기) |

(v1.35 D1 부수 발견 해소 — archive 자격 충족)

**Parsed sub-items (3)**:

1. §2 row #4 (v1.18f alias) — strikethrough 완료 표기 + archive §9 reference
2. §9 archive — v1.35 + v1.18g2 row 2건 추가 (진행 일자 + 산출 + §2 row reference)
3. §8 확정 세션 list — v1.35 + v1.18g2 stamp 2 row 추가 (시간 순)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| §3 Trigger 분류 갱신 (B-2 회귀/장애에 v1.18g2 archive 추가 안 함) | §6-3 정책 정합 — promote만 §2→§9, §3 row는 그대로 (v1.18g2는 §3-B에 사전 등재 안 됨, archive only) |
| §4 Schedule 후보 재검토 | 본 세션 무관 |
| 다른 v1.31 docs 본문 § 갱신 (§1, §5, §6, §7) | archive routine bookkeeping만 |
| 새 §2 row 추가 | evidence-driven 후속 (v1.36c 등은 사용자 결정 시점 등재) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 docs archive bookkeeping만) |
| **re-verify** | N/A |

## 1. 변경 대상

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` | S2 | §2 #4 strikethrough + §8 +2 row + §9 archive +2 row |
| `sessions/meta/v1.31b-.../{PLAN,REPORT}.md` | meta | 본 세션 기록 |

## 2. 결정

### R1 — §2 row #4 갱신

```diff
- | 4 | **`v1.18f-scorer-other-na-categories`** | ai-ready-scorer | Documentation/Test/Context layer/Type safety 4 카테고리 N/A 분기 사례. harness-meta self-eval로 evidence 자체 확보 | `v1.18c REPORT` |
+ | 4 | ~~`v1.18f-scorer-other-na-categories`~~ → **`v1.35-scorer-other-na-categories` 완료 (2026-04-30)** | ai-ready-scorer | Archive §9 참조 | `v1.35 REPORT` |
```

`v1.22-skills-categories` (#5)는 미진행 → 그대로 유지.

### R2 — §8 확정 세션 list +2 row

```diff
  ## 8. 확정 세션

  - **v1.31** (2026-04-29) — 본 docs 신설. 23건 분류 ...
  - **v1.32** (2026-04-29) — §2 #1 (REPORT § cross-file 일관성 검증) 완료 → §9 archive 이관.
  - **v1.33** (2026-04-29) — §2 #3 ... 완료 → §9 archive 이관.
  - **v1.34** (2026-04-30) — §2 #2 ... 완료 → §9 archive 이관.
+ - **v1.35** (2026-04-30) — §2 #4 (`v1.18f-scorer-other-na-categories` alias) 완료 → §9 archive 이관. 8 sub-checks N/A 확장 (Doc 2 + Context 2 + Test 4).
+ - **v1.18g2** (2026-04-30) — v1.35 D1 부수 발견 후속 — helper build_sources 임계 5→10 상향. harness-meta 점수 90→93 (Docker+Lock N/A 복원).
```

### R3 — §9 archive +2 row

```diff
  ## 9. Archive (완료 세션)

  | 완료 세션 | 진행 일자 | 매트릭스 §2 row | 산출 |
  |---------|---------|---------------|------|
  | **`v1.32-...`** | 2026-04-29 | §2 #1 | ... |
  | **`v1.33-...`** | 2026-04-29 | §2 #3 | ... |
  | **`v1.34-...`** | 2026-04-30 | §2 #2 | ... |
+ | **`v1.35-scorer-other-na-categories`** | 2026-04-30 | §2 #4 (`v1.18f` alias) | 8 sub-checks N/A 확장 (Documentation 2 + Context layer 2 + Test 4 — sub-3.3 dead code 제거). categories_quality.py + categories_ops.py + rubric.md 4군데 정합화. harness-meta 변동 0 (helper=False), 8 case dynamic 시뮬레이션 통과. D1 부수 발견 → v1.18g2 분리 |
+ | **`v1.18g2-helper-threshold-revisit`** | 2026-04-30 | (§2 row 외 — v1.35 D1 후속) | helper `build_sources < 5` → `< 10` 임계 상향 (v1.18g 분할 부수 효과 보정). 6 옵션 매트릭스 비교 후 Option A2 채택 (YAGNI). harness-meta 점수 90→93 (Docker+Lock N/A 복원). 회귀 0 (다른 6 카테고리 변동 0) |
```

## 3. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] EVIDENCE_DRIVEN_ROADMAP.md 3 § 갱신 (R1 + R2 + R3)
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 커밋

## 4. 성공 기준

- [ ] §2 #4 strikethrough + v1.35 reference (#5는 그대로 — 미진행)
- [ ] §8 확정 세션 list: v1.35 + v1.18g2 시간 순 추가
- [ ] §9 archive: v1.35 + v1.18g2 row 추가
- [ ] §2 활성 목록 축소 (5 → 1, #5 v1.22만 남음)
- [ ] 회귀 0 (다른 § 변경 없음)

## 5. 커밋 전략

```
chore(meta): sessions/meta/v1.31b-roadmap-archive-arrears — EVIDENCE_DRIVEN_ROADMAP archive 갱신

- update: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md
  - §2 row #4 strikethrough + v1.35 완료 reference
  - §8 확정 세션 list: v1.35 + v1.18g2 추가 (2026-04-30 stamp)
  - §9 archive: v1.35 + v1.18g2 row 2건 추가
- add: sessions/meta/v1.31b-.../{PLAN,REPORT}.md

§6-1 갱신 정책 정합 (v1.35/v1.18g2 누락 정정).
References: v1.35 REPORT + v1.18g2 REPORT.
```

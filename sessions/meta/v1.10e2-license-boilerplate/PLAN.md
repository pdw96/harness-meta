# meta v1.10e2-license-boilerplate — PLAN

세션 시작: 2026-04-27 (v1.10e 직후, 동일 세션 분기 — Option C 후속)
직접 선행 세션:

- [`sessions/meta/v1.10e-detect-license/`](../v1.10e-detect-license/REPORT.md) — Option C T1 only (SPDX 헤더). 본 v1.10e2 약속: "T2 boilerplate 매칭 9 패턴 (MIT/Apache/GPL/BSD/ISC/MPL/Unlicense) + GPL or-later + multi-file dual-license"
- [`sessions/meta/v1.10c-bootstrap-content-defaults/`](../v1.10c-bootstrap-content-defaults/REPORT.md) — License default 폐기 결정 + observation only 원칙

목적: v1.10e의 T1 (SPDX 헤더) 추출률 한계 (sample 0%) 보완. **T2 boilerplate 텍스트 매칭 12 패턴** 추가 → OSS sample 50%+ 추출. T1 우선 + T2 fallback + T3 silent. v1.10e의 observation 본질 유지 (사용자 LICENSE 콘텐츠 read).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(7) — `bootstrap/{detect-project.sh, interview.md, docs/INTERVIEW_FLOW.md}` + smoke + audit 5 + skeletons unchanged. S1a(0) — harness-meta.md 변경 없음 (자동 적용 7 카운트 유지: T2는 T1 fallback이므로 신규 변수 0). 합 **7/7 meta**.
- **T1 경로 다수결** — meta scope 7/7.
- **T2 스펙 vs 값** — 12 boilerplate regex + multi-file 매칭 + GPL or-later 알고리즘은 "흐름 스펙". 신규 프로젝트 LICENSE 파일 실 콘텐츠는 별도 `sessions/<name>/v0.1-bootstrap/` (T4).

## 배경 — v1.10e Option C 채택 후 한계 확인

audit/A2 (v1.10e) sample 분포:

- SPDX 헤더 보유율: **0/10 (0%)**
- OSS 비율: **5/10 (50%)** — MIT 4 + Apache-2.0 1
- Proprietary/EULA: **5/10 (50%)**

→ T1 only 시 추출률 0%. v1.10e2 T2 추가 시 OSS sample 100% 매칭 가능 → 전체 50%+ 실용 추출률.

**v1.10c observation vs injection 정합성** (재확인):

- v1.10e (T1 SPDX) = observation (사용자 명시 헤더 read) ✓
- **v1.10e2 (T2 boilerplate) = observation (사용자 LICENSE 콘텐츠 read)** — 동일 본질. injection 아님 (default stamp 강제 없음, LICENSE 부재 시 fallback)
- audit/A5에서 5 시나리오 검증 (v1.10c 거부 3 이유 모두 무력화)

## scope — Option C 후속

### ✅ 포함 (10 항목)

1. T2 — boilerplate 텍스트 매칭 (head -30 라인 grep)
2. **12 패턴**: MIT / Apache-2.0 / GPL-2.0 / GPL-3.0 / AGPL-3.0 / LGPL-2.1 / LGPL-3.0 / BSD-2-Clause / BSD-3-Clause / ISC / MPL-2.0 / Unlicense
3. GPL "or-later" suffix (`GPL-3.0-or-later` vs `GPL-3.0-only`)
4. Multi-file dual-license (LICENSE-MIT + LICENSE-APACHE → `MIT OR Apache-2.0`)
5. NOTICE 파일 보조 (Apache-2.0 confidence boost — boilerplate 매칭 시 NOTICE 존재로 confirm)
6. T1 우선순위 명시 (SPDX 헤더 매칭 시 T2 skip)
7. T3 fallback 유지 (T1+T2 모두 미식별 → output 없음)
8. False positive risk 명시 (audit/A2)
9. INTERVIEW_FLOW.md Stage S3 preview literal 갱신 (`T1 / T2 boilerplate / T3 fallback` 3-tier 표기)
10. `bootstrap_version` stamp `1.10e` → `1.10e2`

### ❌ 제외 (4 항목 → 후속)

- **메타데이터 license 필드** (npm package.json `"license"`, pyproject `[project].license`, Cargo `license = ""`) → **v1.10e3** (별도 evidence 필요)
- **agents.md L5 license 라인 자체 정책** (라인 제거/유지 결정) → **v1.10h**
- **SPDX expression complex** (`(MIT OR Apache-2.0) AND CC-BY-4.0` 등) → 본 v1.10e2 multi-file dual은 단순 OR만. 복잡 표현은 v1.10e2 적용 후 evidence 부족 시 별도
- **harness-meta self-detect** (현 repo LICENSE T2 매칭 검증) → smoke fixture에서만. dogfood는 별도

## 12 boilerplate 패턴 spec (audit/A1에서 grep regex 확정 예정)

| # | License | SPDX ID | grep marker (대표) | head 라인 |
|---|---------|---------|-------------------|----------|
| 1 | MIT | `MIT` | `^MIT License$` 또는 `Permission is hereby granted, free of charge,` | 1-10 |
| 2 | Apache-2.0 | `Apache-2.0` | `Apache License` + `Version 2.0` (multi-line) | 1-5 |
| 3 | GPL-2.0 | `GPL-2.0-only` 또는 `GPL-2.0-or-later` | `GNU GENERAL PUBLIC LICENSE` + `Version 2` | 1-5 |
| 4 | GPL-3.0 | `GPL-3.0-only` 또는 `GPL-3.0-or-later` | `GNU GENERAL PUBLIC LICENSE` + `Version 3` | 1-5 |
| 5 | AGPL-3.0 | `AGPL-3.0-only` 또는 `AGPL-3.0-or-later` | `GNU AFFERO GENERAL PUBLIC LICENSE` | 1-5 |
| 6 | LGPL-2.1 | `LGPL-2.1-only` 또는 `LGPL-2.1-or-later` | `GNU LESSER GENERAL PUBLIC LICENSE` + `Version 2.1` | 1-5 |
| 7 | LGPL-3.0 | `LGPL-3.0-only` 또는 `LGPL-3.0-or-later` | `GNU LESSER GENERAL PUBLIC LICENSE` + `Version 3` | 1-5 |
| 8 | BSD-2-Clause | `BSD-2-Clause` | `Redistribution and use` + 2 conditions (no `3. Neither`) | 1-30 |
| 9 | BSD-3-Clause | `BSD-3-Clause` | `Redistribution and use` + `3. Neither the name` | 1-30 |
| 10 | ISC | `ISC` | `Permission to use, copy, modify, and/or distribute` | 1-10 |
| 11 | MPL-2.0 | `MPL-2.0` | `Mozilla Public License Version 2.0` | 1-5 |
| 12 | Unlicense | `Unlicense` | `This is free and unencumbered software released into the public domain` | 1-5 |

**Match priority** (audit/A3에서 확정 — 현재 권장):

1. T1 — SPDX-License-Identifier 헤더 (head -10) — **wins all**
2. T2 — boilerplate 매칭 — 첫 매칭 우선 (longest-marker first 권장)
3. T3 — fallback (output 없음)

**GPL or-later 감지**: 본문에 `or (at your option) any later version` 구문 존재 시 `-or-later` suffix, 없으면 `-only`. boilerplate stub만 있으면 (사용자 미작성) `-only` 기본 (audit/A4에서 정당화).

**Multi-file dual-license** (Rust 컨벤션):

- `LICENSE-MIT` + `LICENSE-APACHE` 둘 다 존재 → `MIT OR Apache-2.0`
- 그 외 조합도 동일 (`LICENSE-MIT` + `LICENSE-BSD` → `MIT OR BSD-3-Clause`)
- 단일 파일만 있으면 일반 T2 처리

**NOTICE 파일 보조** (Apache-2.0):

- T2 Apache-2.0 boilerplate 매칭 + `NOTICE` 파일 존재 → confidence boost (log only, output 동일)
- audit/A4에서 정당화 — 현재는 informational, false positive 감소 효과는 v1.10e2 적용 후 evidence 수집 후 추가 결정

## 변경 대상 (3 수정 + 11 신규 = 14 파일)

### 수정 (3)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/detect-project.sh` | S2 | T2 boilerplate 매칭 함수 추가 (T1 다음, T3 이전). 12 패턴 + GPL or-later + multi-file dual + NOTICE 보조 |
| `bootstrap/interview.md` | S2 | "License 처리" § 본문 갱신 — T1+T2+T3 3-tier 명시. 12 패턴 표 + 매칭 알고리즘. 자동 적용 카운트 7 유지 (콘텐츠 변수 신규 추가 0). bootstrap_version stamp `1.10e` → `1.10e2` |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | §2 Stage S3 preview literal에 T1/T2/T3 표기 갱신. §3.3 v1.10e 변수 표 footnote에 T2 추가. Round-trip 한계 1줄 유지 |

### 신규 (11)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-bootstrap-license-boilerplate.sh` | S2 | 14 stage smoke (12 패턴 + GPL or-later + multi-file + T1 우선순위 + false positive 검증) |
| `sessions/meta/v1.10e2-license-boilerplate/PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10e2-license-boilerplate/REPORT.md` | meta | (Stage D 후 작성) |
| `sessions/meta/v1.10e2-license-boilerplate/audit/A1-boilerplate-regex.md` | meta | 12 패턴 grep regex 확정 + head 라인 수 + GPL or-later 정규식 + dual-license 패턴 |
| `sessions/meta/v1.10e2-license-boilerplate/audit/A2-recovery-rate.md` | meta | v1.10e sample 10건 재검증 (T1 0% → T2 추가 시 50%+ 검증) + false positive 추정 + edge case |
| `sessions/meta/v1.10e2-license-boilerplate/audit/A3-detect-strategy.md` | meta | T1/T2/T3 3-tier bash 알고리즘 + multi-file 알고리즘 + match priority 결정 + head 라인 수 결정 |
| `sessions/meta/v1.10e2-license-boilerplate/audit/A4-policy-decisions.md` | meta | R1-R10 결정 + Grey 5 + scope 매트릭스 (포함 10 + 제외 4) |
| `sessions/meta/v1.10e2-license-boilerplate/audit/A5-v110e-consistency.md` | meta | T1 only (v1.10e) vs T1+T2 (v1.10e2) 정합성 — 둘 다 observation. v1.10c 거부 3 이유 무력화 재검증 |
| `sessions/meta/v1.10e2-license-boilerplate/evidence/smoke-bootstrap-license-boilerplate.txt` | meta | smoke 실행 결과 |

## 목표

- [x] 세션 디렉토리 생성 (`sessions/meta/v1.10e2-license-boilerplate/{audit,evidence}/`)
- [x] **PLAN.md 초안 작성** (본 파일 — 사용자 확인 대상)
- [ ] **사용자 PLAN 확인** ← 진행 대기
- [ ] **Stage A — audit 5 파일 작성**
  - A1 — 12 boilerplate regex 확정 (audit 시 실 LICENSE 콘텐츠 검증, GPL or-later 처리, multi-file 패턴)
  - A2 — v1.10e sample 10건 재검증 (T1 0% → T2 50%+ recovery rate) + false positive 추정 + edge case (모호 multi-license, dual-license-stub-only)
  - A3 — T1/T2/T3 3-tier bash 알고리즘 + multi-file 알고리즘 (LICENSE-MIT + LICENSE-APACHE) + match priority 결정 (longest marker first / first match wins / weighted 중)
  - A4 — R1-R10 정책 결정 + Grey 5건 + scope 매트릭스 (포함 10 + 제외 4)
  - A5 — v1.10e (T1 only) vs v1.10e2 (T1+T2) 정합성 + 5 시나리오 (proprietary / OSS-with-SPDX / OSS-without-SPDX / dual-license / multi-file-dual)
- [ ] **Stage B — `bootstrap/detect-project.sh` 갱신**
  - T2 boilerplate 매칭 함수 (12 패턴 + GPL or-later 본문 grep)
  - Multi-file dual-license 함수 (LICENSE-MIT + LICENSE-APACHE 등)
  - NOTICE 보조 (Apache-2.0 confidence — informational log)
  - T1 우선순위 유지 (SPDX 매칭 시 T2 skip)
- [ ] **Stage C — interview.md / INTERVIEW_FLOW.md 갱신**
  - "License 처리" § T1+T2+T3 3-tier 명시 + 12 패턴 표 + 매칭 algorithm
  - bootstrap_version stamp `1.10e` → `1.10e2` (interview.md "현 시점" + INTERVIEW_FLOW.md §2 literal)
  - 자동 적용 카운트 **7 유지** (T2는 T1 fallback이므로 신규 변수 추가 0)
  - INTERVIEW_FLOW.md §2 Stage S3 preview literal — T2 fallback 표시 추가
- [ ] **Stage D — Smoke**
  - `tests/smoke-bootstrap-license-boilerplate.sh` 14 stage:
    - Stage 1-12 (각 패턴 single-file boilerplate matching)
    - Stage 13 (multi-file dual-license: LICENSE-MIT + LICENSE-APACHE → `MIT OR Apache-2.0`)
    - Stage 14 (T1 우선순위: SPDX `MIT` 헤더 + body Apache boilerplate → `MIT` 출력. T2 skip 검증)
    - Bonus stage (선택): GPL-3.0-or-later (본문에 `or (at your option) any later version` 포함)
  - `evidence/smoke-bootstrap-license-boilerplate.txt`
  - 기존 v1.10e smoke (`smoke-bootstrap-license-detect.sh`) 5/5 PASS 회귀 확인 (T1 우선순위 유지 검증)
- [ ] **REPORT.md 작성**
- [ ] **사용자 확인 후 단일 커밋 + push**

## Grey Areas — audit/A4에서 확정

| ID | 질문 | 결정 (audit/A4 §Grey Areas) |
|----|------|----------|
| **G1** | boilerplate 패턴 카운트 | **(a) 12 패턴** — promise 7 family 전부 + GPL family 5 변형 (R2) |
| **G2** | head 라인 수 | **(a) head -30** — sample 100% capture (R3) |
| **G3** | GPL or-later/only | **(a) 본문 `any later version` grep → suffix** (R4) |
| **G4** | Match priority | **(a) longest-marker first + early return** (R5) |
| **G5** | NOTICE 보조 | **(a) informational only** (R8) |

**Recovery rate evidence** (audit/A2 §3 — sample 20건):

- v1.10e (T1 only): 0/20 (0%)
- **v1.10e2 (T1 + T2)**: **14/20 (70%)** — OSS 13 + multi-file dual 1, false positive 0
- 알려진 한계 1건 — PortableGit `or-later` 의미 conflict (R11). SPDX 헤더 추가로 회복.

## 성공 기준

- [ ] audit/A1-A5 5 파일 작성 (Stage A)
- [ ] `bootstrap/detect-project.sh` T2 boilerplate 매칭 함수 + multi-file dual + NOTICE 보조 (~80 라인 추가 추정)
- [ ] `bootstrap/interview.md` "License 처리" § 3-tier 갱신 + 12 패턴 표 + bootstrap_version stamp `1.10e2`
- [ ] `bootstrap/docs/INTERVIEW_FLOW.md` Stage S3 literal + §3.3 footnote
- [ ] `tests/smoke-bootstrap-license-boilerplate.sh` 14 stage PASS
- [ ] 기존 `tests/smoke-bootstrap-license-detect.sh` 5/5 회귀 PASS (T1 우선순위 유지)
- [ ] `evidence/smoke-bootstrap-license-boilerplate.txt`
- [ ] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push

## 커밋 전략

단일 커밋. 부분 적용 시 12 패턴 / 14 smoke / 3-tier 문서 불일치 → 자산 정합성 깨짐.

```
feat(meta): sessions/meta/v1.10e2-license-boilerplate — LICENSE boilerplate 매칭 12 패턴 (T2 + multi-file dual)

- update: bootstrap/detect-project.sh (T2 boilerplate 12 패턴 + GPL or-later + multi-file dual + NOTICE 보조)
- update: bootstrap/interview.md ("License 처리" § T1+T2+T3 3-tier + 12 패턴 표 + bootstrap_version 1.10e → 1.10e2)
- update: bootstrap/docs/INTERVIEW_FLOW.md (Stage S3 literal T1/T2/T3 표기 + §3.3 footnote)
- add: tests/smoke-bootstrap-license-boilerplate.sh (14 stage)
- add: sessions/meta/v1.10e2-license-boilerplate/{PLAN,REPORT,audit/A1-A5,evidence/smoke}

v1.10e Option C 후속. T1 (SPDX 헤더) sample 추출률 0% 한계 보완:
- T2 boilerplate 매칭 12 패턴 (MIT/Apache/GPL-2/3/AGPL-3/LGPL-2.1/3/BSD-2/3/ISC/MPL/Unlicense)
- GPL or-later 본문 grep (`or (at your option) any later version`)
- Multi-file dual-license (LICENSE-MIT + LICENSE-APACHE → `MIT OR Apache-2.0`)
- NOTICE 보조 (Apache-2.0 informational)
- T1 우선순위 유지 (SPDX 매칭 시 T2 skip)
- T3 fallback 유지 (T1+T2 모두 미식별 → output 없음)

v1.10c/v1.10e 정합성 (audit/A5):
- T2 = observation (사용자 LICENSE 콘텐츠 read), injection 아님
- v1.10c 거부 3 이유 모두 무력화 (의도 위배 risk 0 / 사용자 명시 LICENSE만 read / SPDX 표준 정합)

v1.10e sample recovery rate 0% → 50%+ (audit/A2 검증).

Smoke 14/14 PASS — 12 패턴 + multi-file + T1 우선순위. 회귀 v1.10e smoke 5/5 PASS.
```

## 후속 세션 연결

### 직접 연계

- **v1.10e3-license-metadata** (S2) — npm package.json `license` / pyproject.toml `[project].license` / Cargo.toml `license = ""` 추출. T2 본문 매칭 우회 가능 (메타데이터가 더 정확).
- **v1.10h-agents-md-license-line-policy** (S2) — agents.md spec L5 license 라인 자체 정책 (유지/제거/형식)

### Lessons Forward (예상)

1. **Observation 본질 유지** — T1 (헤더) → T2 (본문) → T3 (메타) → T4 (fallback) 모두 사용자 LICENSE read. injection (default 강제 stamp) 없음
2. **Recovery rate evidence-driven 후속 분기** — v1.10e (T1 only sample 0%) → v1.10e2 (T1+T2 50%+) → v1.10e3 (T1+T2+메타 80%+ 예상). 각 세션이 다음 세션의 evidence base 제공
3. **Match priority weighted 회피** — bash로 weighted scoring 구현 가능하나 false positive risk 추가 + 디버깅 어려움. **첫 매칭 + longest-marker 단순 우선순위**가 결정적 + 검증 용이
4. **boilerplate 변형 한계** — modified license (e.g. "MIT License (modified)" 추가) → false negative. v1.10e2도 100% 보장 안 함. 사용자가 SPDX 헤더 추가 권장 (INTERVIEW_FLOW.md 안내 유지)
5. **GPL family 복잡성** — or-later vs only / GPL vs LGPL vs AGPL / 2.0 vs 3.0 — 본 v1.10e2가 7 변형 처리. SPDX expression 복잡 표현 (compound) 미커버 — 사용자 SPDX 헤더 권장

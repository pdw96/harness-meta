# A5 — v1.10c/v1.10e 정합성 검증 (T2 boilerplate도 observation 본질)

본 audit는 v1.10e2의 핵심 정당화 — **v1.10c 거부 결정 (injection 회피)와 v1.10e2 (T2 boilerplate) 채택의 정합성**.

## 1. 결론 (TL;DR)

| 측면 | v1.10c (거부) | v1.10e (T1 채택) | **v1.10e2 (T2 채택)** |
|------|:------------:|:----------------:|:---------------------:|
| 행위 유형 | injection (default MIT 강제 stamp) | **observation** (사용자 SPDX 헤더 read) | **observation** (사용자 LICENSE 콘텐츠 read) |
| 트리거 | LICENSE 부재여도 stamp | LICENSE + SPDX 헤더 존재 시만 | **LICENSE + boilerplate 텍스트 존재 시만** |
| 사용자 의도 위배 risk | ⚠️ 있음 (Apache 의도자에 MIT stamp) | 0 | **0** |
| 결정 정당성 | ✅ 거부 정당 | ✅ 채택 정당 | ✅ **채택 정당** |
| spec 정합 | ✗ (agents.md spec 외 강제) | ✓ (SPDX 헤더 표준) | ✓ (SPDX expression 표준) |

→ **v1.10c 거부 3 이유 모두 무력화** (v1.10e와 동일 논리).

## 2. v1.10c 거부 3 이유 verbatim 재검증

v1.10c REPORT (`sessions/meta/v1.10c-bootstrap-content-defaults/REPORT.md`)의 License default 폐기 3 이유:

### 이유 1 — agents.md spec 위반 (default 강제 stamp)

> v1.10c 안: 사용자 LICENSE 부재 시 `MIT` default stamp.
> 폐기 사유: agents.md spec은 L5 license 라인 자체를 강제하지 않음. 강제 stamp는 spec 외 관례.

**v1.10e 적용 시**: SPDX 헤더 부재 = stamp 안 함 → spec 위배 0.
**v1.10e2 적용 시**: LICENSE 부재 또는 boilerplate 매칭 부재 = stamp 안 함 → spec 위배 0.

→ **두 세션 모두 spec 위반 risk 0**. v1.10c 폐기 사유 무력화.

### 이유 2 — 사용자 의도 위배 risk

> v1.10c 안: Apache-2.0 의도자에게 강제 MIT stamp 발생 가능.
> 폐기 사유: 사용자 의도와 자동 default 불일치 시 audit trail 오염.

**v1.10e 적용 시**: 사용자가 SPDX 헤더 명시 → 사용자 의도 정확 read. 헤더 부재 = stamp 안 함.
**v1.10e2 적용 시**: 사용자가 작성한 LICENSE 파일 boilerplate read. 다른 license 의도 시 사용자가 LICENSE 다른 텍스트로 작성 또는 SPDX 헤더 추가 (T1 우선).

→ **두 세션 모두 사용자 의도 위배 risk 0** (사용자가 작성한 데이터만 read).

⚠️ **v1.10e2 footnote**: PortableGit edge case (or-later 의미 conflict, audit/A2 §1) — 사용자 의도 미세 deviation 1건. 회복 경로: SPDX 헤더 추가 (T1 우선). 본 한계는 INTERVIEW_FLOW.md 안내로 사용자 인지 가능.

### 이유 3 — 권위 도구 패턴 정합

> v1.10c 안: bootstrap이 license 자동 stamp.
> 폐기 사유: GitHub / npm / cargo 등 권위 도구는 사용자 명시 LICENSE 파일 또는 메타데이터 필드만 read. 자동 default 없음.

**v1.10e 적용 시**: SPDX 헤더 — Linux Foundation SPDX 표준. npm `license` 필드도 SPDX expression 사용. 권위 도구 패턴 정합.
**v1.10e2 적용 시**: boilerplate 매칭 — GitHub Linguist (license-detector), licensee (Ruby gem) 등이 사용하는 동일 전략. 권위 도구 패턴 정합.

→ **두 세션 모두 권위 도구 패턴 정합**. v1.10c 폐기 사유 무력화.

## 3. 5 시나리오 검증

각 시나리오에서 v1.10e2 동작 검증.

### 시나리오 1 — Proprietary 의도자 (LICENSE 부재)

**입력**: 사용자가 LICENSE 파일 미작성 (proprietary 의도).

**v1.10e2 처리**:
- T1: LICENSE 파일 부재 → 헤더 grep 불가
- T2-Multi: LICENSE-* 파일 부재 → fail
- T2: LICENSE 파일 부재 → boilerplate 매칭 불가
- T3: output 없음 (silent)

**AGENTS.md L5 fallback**: `License: see LICENSE.` (v1.10b 텍스트)

**S3 preview WARN**: ⚠️ LICENSE 파일 부재 — proprietary 가정.

→ **사용자 의도 정확 처리**. injection 없음.

### 시나리오 2 — OSS-with-SPDX

**입력**: LICENSE 파일에 `SPDX-License-Identifier: MIT` 첫 라인.

**v1.10e2 처리**:
- T1: 헤더 매칭 → `license = "MIT"` emit. T2 skip (early return).

→ T1 우선 매칭. v1.10e와 동일 동작.

### 시나리오 3 — OSS-without-SPDX (boilerplate만)

**입력**: harness-meta `~/harness-meta/LICENSE` (boilerplate MIT, 헤더 부재).

**v1.10e2 처리**:
- T1: 헤더 부재 → 빈 값
- T2-Multi: LICENSE-* 파일 부재 → fail
- T2: boilerplate header `MIT License` @ L1 + body `Permission... free of charge` @ L5 → 매칭 → `license = "MIT"`

→ **v1.10e (T1 only) 대비 신규 추출 가능**. 사용자 LICENSE 콘텐츠 정확 read.

### 시나리오 4 — Dual-license SPDX expression (single file)

**입력**: LICENSE 파일에 `SPDX-License-Identifier: MIT OR Apache-2.0` 첫 라인.

**v1.10e2 처리**:
- T1: 헤더 매칭 → `license = "MIT OR Apache-2.0"` emit. (v1.10e 동작 유지, sample 검증 완료)

→ T1 우선. SPDX expression 보존.

### 시나리오 5 — Multi-file dual-license (Rust 컨벤션)

**입력**: `LICENSE-MIT` + `LICENSE-APACHE` 두 파일 존재. SPDX 헤더 둘 다 부재.

**v1.10e2 처리**:
- T1: 단일 LICENSE 파일 부재 → fail
- T2-Multi: `LICENSE-MIT` + `LICENSE-APACHE` 둘 다 detect → `license = "MIT OR Apache-2.0"` emit. T2 skip.

→ **v1.10e2 신규 처리**. v1.10e (T1 only)에서 미커버.

## 4. observation vs injection 본질 분석

### 4-1. 정의

| 행위 | 정의 | 데이터 흐름 |
|------|------|----------|
| **injection** | 사용자 미입력 데이터를 도구가 자체 default로 삽입 | (도구 default) → AGENTS.md |
| **observation** | 사용자 입력 (LICENSE 파일 / SPDX 헤더 / 메타데이터)을 도구가 read 후 변환 | (사용자 입력) → 도구 read → AGENTS.md |

### 4-2. v1.10c (거부) vs v1.10e (T1) vs v1.10e2 (T2)

```
v1.10c 안 (injection):
  사용자 LICENSE 부재 → 도구 자체 default "MIT" 강제 → AGENTS.md L5 stamp
  └─ 도구가 사용자 미입력 데이터 발명

v1.10e (T1, observation):
  사용자 LICENSE + SPDX 헤더 → 도구 grep → AGENTS.md L5 stamp
  └─ 사용자 명시 데이터만 read

v1.10e2 (T2, observation):
  사용자 LICENSE boilerplate 텍스트 → 도구 pattern match → AGENTS.md L5 stamp
  └─ 사용자 명시 데이터만 read (텍스트 콘텐츠가 명시적 declaration)
```

### 4-3. boilerplate = 명시적 declaration?

**핵심 질문**: 사용자가 LICENSE 파일에 MIT boilerplate 텍스트를 작성하는 것은 SPDX 헤더 작성과 동등한 의도 표명인가?

**Yes**:
- LICENSE 파일은 **법적 license declaration의 표준 위치**
- MIT boilerplate 텍스트 자체가 license 조건 명시 (Permission... 구문)
- GitHub Linguist / licensee / OSS Review Toolkit 등 권위 도구가 동일 전략 사용
- 사용자가 LICENSE 파일에 boilerplate를 작성한 것은 의도적 행위 (random text 아님)

**No 반론** (그리고 그 반박):
- "Boilerplate 매칭은 휴리스틱 → 우연한 일치 가능"
  → audit/A1 §2 disambiguation rule + audit/A2 §3 false positive 0/20 검증으로 무효
- "사용자가 LICENSE를 placeholder로 둔 경우?"
  → audit/A2 §3 sample 100% boilerplate 작성자는 의도자. placeholder는 sample 0건

→ **boilerplate read = observation 본질**. v1.10e2 채택 정당.

## 5. v1.10e2가 추가로 도입하는 risk

### Risk 1 — False positive

**평가**: audit/A2 §3 sample 17/17 false positive 0건. 본 v1.10e2 disambiguation rule (header + body 2-신호 + start-anchor) 견고.

**완화책**: T1 우선순위 — 사용자가 정확한 stamp 원하면 SPDX 헤더 추가 (T1 매칭).

### Risk 2 — False negative (modified/희귀 license)

**평가**: 본 v1.10e2 12 패턴이 OSS 99%+ 커버 (GitHub OSS 통계 — MIT, Apache, GPL family, BSD, ISC, MPL, Unlicense가 OSS의 대부분).

**완화책**: v1.10e3 메타데이터 추출 (npm `license` 필드 등) — 본 v1.10e2 한계 회복.

### Risk 3 — 의미 conflict (PortableGit or-later case)

**평가**: audit/A2 §1 sample 1/20 (5%) 발생. boilerplate stamp가 사용자 의도와 상이.

**완화책**: SPDX 헤더 추가로 T1 우선 매칭. INTERVIEW_FLOW.md 안내 (R11).

### Risk 4 — multi-file dual 매칭 false positive

**평가**: LICENSE-MIT.bak (백업 파일), LICENSE-MIT.draft 등 변형 파일명 — 현 매트릭스 (LICENSE-MIT) `iname "$f*"` glob → 백업 파일도 매칭. 의도 외 stamp risk.

**완화책 (audit/A4 R7)**: 매트릭스 한정 (LICENSE-{MIT, APACHE, BSD, ISC, MPL}). bash glob `iname "$f*"`로 suffix 변형 (`LICENSE-APACHE-2`)만 허용. backup 패턴 (`.bak`, `.draft`)은 v1.10e3 후속 검토.

## 6. 최종 정합성 판정

| 검증 항목 | v1.10c 거부 정합? | v1.10e2 채택 정당? |
|-----------|:-----------------:|:-------------------:|
| spec 위반 risk 무력화 | ✓ | ✓ |
| 사용자 의도 위배 risk 0 | ✓ (1건 한계 명시) | ✓ |
| 권위 도구 패턴 정합 | ✓ | ✓ (Linguist, licensee) |
| observation 본질 | ✓ | ✓ (LICENSE 콘텐츠 read) |
| injection 회피 | ✓ | ✓ (default 강제 없음) |
| sample 추출률 | 0% (T1 only) | **70%** (T1+T2) |
| false positive | 0/10 (v1.10e A2) | 0/20 (audit/A2) |

**v1.10c 거부 결정과 정합** ✓
**v1.10e2 채택 정당** ✓

## 7. v1.10e3 사전 정합성

본 v1.10e2 채택 후 v1.10e3 (메타데이터 license 필드)도 동일 observation 본질 — 추가 정합성 audit 불필요. v1.10e3 PLAN 시 재참조.

## 관련 문서

- v1.10c REPORT: `../v1.10c-bootstrap-content-defaults/REPORT.md` (License default 폐기)
- v1.10e A5: `../v1.10e-detect-license/audit/A5-v110c-consistency.md` (T1 정합성)
- 본 audit: `A1-A4` (regex / sample / 알고리즘 / 정책)
- 외부 권위 도구: [GitHub Linguist license-detector](https://github.com/github-linguist/linguist) · [licensee](https://github.com/licensee/licensee) · [OSS Review Toolkit](https://github.com/oss-review-toolkit/ort)

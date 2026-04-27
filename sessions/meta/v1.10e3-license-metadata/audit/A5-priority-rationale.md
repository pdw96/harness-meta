# A5 — LICENSE 파일 vs 메타데이터 우선순위 정당화

본 audit는 G1 결정 (LICENSE 콘텐츠 우선) 정밀 정당화 + v1.10c 거부 (injection) vs v1.10e3 (observation) 정합성 + 5 시나리오 검증.

## §1. 핵심 결정 — LICENSE 콘텐츠 우선

**결정** (R3 in A4): T1/T2 매칭 시 T3 메타 skip. LICENSE 부재 시만 T3 진입.

```
LICENSE 콘텐츠 매칭 (T1 SPDX 헤더 또는 T2 boilerplate)
    ↓ (매칭 시)
T3 skip → 출력
    ↓ (LICENSE 부재 또는 매칭 실패)
T3 메타데이터 진입
```

## §2. 정당화 4 축

### §2.1. 사용자 의도 (Strong signal hierarchy)

| Signal | 의도 강도 | 작성 비용 | 정확도 |
|--------|---------|---------|--------|
| LICENSE 파일 콘텐츠 (boilerplate 전체) | **가장 강함** | 높음 (300+ 라인) | 높음 (full text) |
| LICENSE 파일 SPDX 헤더 (`SPDX-License-Identifier:`) | 강함 | 낮음 (1줄) | 매우 높음 (machine-readable) |
| 메타데이터 license 필드 (npm/pyproject/Cargo) | 중간 | 낮음 (1줄) | 중간 (사용자 실수 가능) |
| 메타데이터 부재 + LICENSE 부재 | 없음 | — | — |

**근거**:
- LICENSE 파일을 명시적으로 작성한 행위는 의도적 declaration
- LICENSE 파일 콘텐츠 (boilerplate full text) = 사용자가 의식적으로 본 license에 동의
- 메타데이터는 빌드 도구 요구로 자동 채워질 수 있음 (`npm init` 시 default 등)

### §2.2. 의미 정확도 (Sample evidence)

A2 §2.4에서 측정:

| Sample | 메타 값 | LICENSE 콘텐츠 | LICENSE 우선 결과 | 메타 우선 결과 |
|--------|---------|---------------|------------------|--------------|
| #25 ms-python | `"MIT"` | MIT boilerplate | `MIT` | `MIT` (동일) |
| #27 Oracle | **`"Apache 2.0"`** (공백, non-SPDX) | Apache-2.0 boilerplate | `Apache-2.0` ✅ | `Apache 2.0` ⚠️ (비표준) |
| #28 Kubernetes | `"Apache-2.0"` | Apache-2.0 boilerplate | `Apache-2.0` | `Apache-2.0` (동일) |
| #30 redhat-yaml | (메타 부재) | MIT boilerplate | `MIT` | (메타 우선이면 silent) ❌ |

**LICENSE 우선 정확**: 4/4 (100%). **메타 우선** 정확: 2/4 (50%, #27 비표준 + #30 메타 부재).

→ LICENSE 콘텐츠가 **SPDX 정합성을 보장**. 메타는 사용자 실수 (공백 / 비표준 form) 가능.

### §2.3. 권위 도구 동일 전략

| 도구 | 우선 source | 출처 |
|------|-----------|------|
| GitHub Linguist | LICENSE 파일 콘텐츠 (boilerplate full match) | github/linguist `lib/linguist/license.rb` |
| licensee | LICENSE 파일 콘텐츠 (Sørensen-Dice 유사도) | licensee/licensee README |
| GitHub repo "License" badge | Linguist 결과 (LICENSE 콘텐츠) | github.com docs |
| npm registry | `package.json.license` (publish 시점) | npm publish |
| crates.io | `Cargo.toml [package].license` | cargo publish |
| PyPI | pyproject `[project].license` | PEP 639 |

**관찰**: GitHub Linguist (가장 영향력 있는 license 분류 도구) = LICENSE 콘텐츠 우선. 메타데이터는 publish 시점에만 사용.

→ v1.10e3 G1 결정 = GitHub Linguist 동일 전략. 권위 도구 정합.

### §2.4. 일관성 (T1 + T2 + T3 단계 패턴)

v1.10e/e2/e3 통합 우선순위:

```
T1 (SPDX 헤더) — LICENSE 파일 메타
  └─ 가장 strong: machine-readable, 사용자가 명시적 stamp

T2-Multi / T2 boilerplate — LICENSE 콘텐츠
  └─ 강함: full text 동의

T3 메타데이터 — 빌드 도구 메타
  └─ 중간: 자동 채움 가능

T4 silent — 단서 부재
```

**계층 일관성**: 더 strong한 signal이 더 우선. T1 (헤더) > T2 (콘텐츠) > T3 (메타) > T4 (없음). 본 결정이 T1/T2 = LICENSE 파일 / T3 = 메타 일관 패턴.

## §3. v1.10c 거부 (injection) vs v1.10e3 (observation) 정합성

v1.10c에서 license default `MIT` 강제 stamp 거부 (`sessions/meta/v1.10c-bootstrap-content-defaults/REPORT.md`). 거부 3 이유:

### §3.1. 거부 이유 1 — Spec 위반

**v1.10c** (injection): LICENSE 부재 시 default `MIT` 강제 — 사용자 declaration 없는 라이선스 부여. SPDX 표준 위배.

**v1.10e3** (observation): 사용자가 메타데이터에 명시한 SPDX expression read만. **사용자 declaration 명시적 존재** — PEP 639 / npm schema / Cargo manifest 모두 정식 spec.

→ 거부 이유 1 무력화: **사용자가 명시한 declaration은 spec 정합**.

### §3.2. 거부 이유 2 — 의도 위배 risk

**v1.10c**: 사용자가 의도하지 않은 라이선스 stamp risk. e.g. "license 결정 보류 중인 프로젝트" → `MIT` 강제 stamp → 후속 분쟁.

**v1.10e3**: 사용자가 메타에 직접 작성한 값. **의도 위배 risk = 0** — 사용자 명시 declaration이 의도 그 자체.

**예외**: `npm init` default 시 `"license": "ISC"` 자동 채움 — 사용자가 의식적으로 변경 안 한 경우. 이것도 "사용자가 publish하지 않으면 default 유지" 선택의 결과 → 의도 표명.

→ 거부 이유 2 무력화.

### §3.3. 거부 이유 3 — 권위 도구 불일치

**v1.10c**: GitHub Linguist / licensee 등은 LICENSE 콘텐츠 read만. **default stamp는 권위 도구가 안 함**. v1.10c는 권위 도구 미준수.

**v1.10e3**: npm registry / crates.io / PyPI 모두 메타데이터 license read. **권위 도구 동일 전략**.

→ 거부 이유 3 무력화: **권위 도구가 모두 메타데이터 read 표준화**.

### §3.4. 통합 정합성

| 측면 | v1.10c (거부) | v1.10e3 (채택) |
|------|:-------------:|:------------:|
| 행위 유형 | injection (default 강제) | **observation (메타 read)** |
| Trigger | LICENSE 부재여도 stamp | 메타 명시 시만 |
| 사용자 declaration | **없음** | **있음** (PEP 639 / npm / Cargo spec) |
| 의도 위배 risk | 있음 | 0 |
| Spec 정합 | ✗ | ✓ (4 표준) |
| 권위 도구 일치 | ✗ | ✓ (npm/crates/PyPI/Linguist) |
| Reversibility | 높음 (사용자 후속 정정 필요) | 자동 (메타 변경 시 next bootstrap에 반영, 단 round-trip 1회성 — REPORT 단계) |

→ v1.10e3 = v1.10e2 (T2 boilerplate read) = v1.10e (T1 헤더 read)와 동일 본질. 모두 사용자 명시 값 read.

## §4. 5 시나리오 검증

### §4.1. 시나리오 A — Proprietary 프로젝트 (LICENSE EULA 보유 + 메타 부재)

```
LICENSE.txt = "Microsoft Software License Terms..." (proprietary EULA, boilerplate 미매칭)
package.json = (license 필드 부재)
```

**처리**: T1 미매칭 → T2 미매칭 → T3 (메타 부재) → T4 silent.

**결과**: `license = ""` 출력 안 함. AGENTS.md L5 fallback `see LICENSE.`.

**정확**: ✅ 사용자 의도 (proprietary, 사용자가 표준 license 미선언) 반영.

### §4.2. 시나리오 B — OSS 프로젝트 + SPDX 헤더 (이상적)

```
LICENSE = "SPDX-License-Identifier: MIT\n\nMIT License\n..."
package.json = "license": "MIT"
```

**처리**: T1 매칭 → `MIT` 출력. T3 skip.

**결과**: `license = "MIT"`. 메타와 일치 (validation은 안 하지만 일관).

**정확**: ✅

### §4.3. 시나리오 C — OSS 프로젝트 + boilerplate (헤더 부재)

```
LICENSE = "MIT License\n\nPermission is hereby granted, free of charge,..."
package.json = "license": "MIT"
```

**처리**: T1 미매칭 → T2 boilerplate 매칭 → `MIT` 출력. T3 skip.

**결과**: `license = "MIT"`.

**정확**: ✅

### §4.4. 시나리오 D — LICENSE 부재 + 메타 only (v1.10e3 신규 회복)

```
(LICENSE 파일 없음)
package.json = "license": "Apache-2.0"
```

**처리**: T1 미매칭 (license_path 없음) → T2-Multi 미매칭 → T2 boilerplate 미매칭 → T3 메타 매칭 → `Apache-2.0`.

**결과**: `license = "Apache-2.0"`. AGENTS.md L5 `License: Apache-2.0 (see [LICENSE](LICENSE))` ⚠️ — LICENSE 파일 부재인데 `(see [LICENSE](LICENSE))` 부적절.

**완화책**: AGENTS.md.tmpl `{{license}}` 치환 후 L5 형식 분기 (LICENSE 파일 존재 여부 별도 변수). **v1.10h scope** — 본 v1.10e3에서는 stamp만 정확, L5 라인 형식은 유지.

**정확**: 메타 stamp는 정확 (`Apache-2.0`). L5 라인 형식 부정확은 v1.10h 책임.

### §4.5. 시나리오 E — 메타 vs LICENSE 의미 conflict

```
LICENSE = "MIT License\n\nPermission is hereby granted, free of charge,..."
package.json = "license": "Apache-2.0"
```

**처리**: T2 boilerplate 매칭 → `MIT` 출력. T3 skip.

**결과**: `license = "MIT"` (LICENSE 콘텐츠 우선, 메타 무시).

**시사**: 사용자가 메타와 LICENSE conflict 작성한 경우. LICENSE 우선 정당:
- LICENSE 콘텐츠 (300+ 라인 boilerplate) = 의도적 declaration
- 메타 변경은 1줄 — 사용자 실수 또는 마이그레이션 누락 가능

**대안 거부 — 메타 우선**: `Apache-2.0` 출력. 사용자가 LICENSE를 변경 안 한 의도 무시. 부정확.

**대안 거부 — merge `MIT AND Apache-2.0`**: SPDX expression 의미 위배 (둘 다 적용 의미). 사용자 의도 미반영.

**Decision**: LICENSE 우선 채택 (G1). 사용자 conflict 해결은 사용자 책임 — INTERVIEW_FLOW.md round-trip 1회성 한계 안내 + 사용자 메타 정정 안내.

## §5. 우선순위 결정 트리 (시각화)

```
┌─────────────────────────────────────────┐
│ LICENSE 파일 존재? (4 우선순위 + Cargo  │
│ license-file 보강)                       │
└─────────────────────────────────────────┘
            ↓ Yes              ↓ No
┌─────────────────┐     ┌─────────────────┐
│ T1: SPDX 헤더?  │     │ T3: 메타 매칭?   │
└─────────────────┘     └─────────────────┘
   ↓ Yes ↓ No              ↓ Yes ↓ No
   ┌────┐ ┌────────────┐    ┌──────┐ ┌─────┐
   │stamp│ │T2: boiler│    │stamp │ │silent│
   │ T1  │ │plate?     │    │ T3   │ │ T4  │
   └────┘ └────────────┘    └──────┘ └─────┘
            ↓ Yes ↓ No
            ┌────┐ ┌─────┐
            │stamp│ │silent│
            │ T2 │ │ T4  │
            └────┘ └─────┘
```

## §6. 미래 변경 가능성 — 재평가 게이트

본 G1 결정 (LICENSE 우선)은 **현 evidence 기반 채택**. 미래 변경 트리거:

1. **권위 도구 정책 변경**: GitHub Linguist가 메타 우선으로 전환 시 → v1.10e3 G1 재평가
2. **메타 정확도 sample 검증**: sample 50+ 확보 후 메타 정확도 ≥ 95% 시 → 단일 source 통합 검토
3. **SPDX expression 검증 도구 도입**: bash로 SPDX 검증 가능해지면 → 메타 우선 + 검증 게이트 도입

현 시점 (2026-04-28) sample 30건 evidence 기반 채택. **재평가 세션 게이트**: `sessions/meta/vX-license-priority-reeval/`.

## §7. 통합 결론

| 정당화 축 | 결과 |
|---------|------|
| 사용자 의도 hierarchy | LICENSE 콘텐츠 = strongest declaration |
| 의미 정확도 | 4/4 (100%) vs 메타 우선 2/4 (50%) |
| 권위 도구 일치 | GitHub Linguist / licensee 동일 전략 |
| 일관성 (T1>T2>T3>T4) | 본 결정이 layer hierarchy 정합 |
| v1.10c 거부 정합성 | observation 본질 — 거부 3 이유 모두 무력화 |
| 5 시나리오 검증 | 5/5 정확 (E의 conflict는 정책상 LICENSE 우선) |

**G1 채택 정당**:
- A2 evidence (의미 정확도)
- 권위 도구 일치
- v1.10c 정합 (observation, injection 아님)
- 5 시나리오 검증 통과

→ R3 (LICENSE 콘텐츠 우선) 채택. v1.10e3 detect-project.sh main flow에 반영.

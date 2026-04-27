# A5 — v1.10c 폐기 결정과의 정합성 검증 (observation vs injection)

본 audit의 핵심 정당화. v1.10c가 거부한 "License 자동 default"와 본 v1.10e의 "T1 SPDX 헤더 추출"은 **본질이 다름** — 관찰 vs 주입.

## 1. v1.10c 거부 verbatim (`v1.10c/PLAN.md`)

> **License 자동 default 폐기** (Agent 2 + Agent 4-B 중복 신호):
> 1. agents.md 공식 spec — License는 권장 § 아님. 60,000+ 채택 사례에서 LICENSE 파일 reference가 표준
> 2. 법적 오인 리스크 — GitHub repo 34%가 license 미선언 (proprietary 의도). MIT 자동 stamp는 Apache/GPL/Proprietary 의도자에게 git log 영구 박힘
> 3. 권위 도구 — cargo new 의도적 미stamp / npm init ISC RFC 논쟁 中 / poetry init default 없음
> - **결정**: v1.10b placeholder `License: see LICENSE.` 유지. v1.10e-detect-license 후속 분리

## 2. v1.10c가 거부한 행위 vs v1.10e가 채택한 행위

| 측면 | v1.10c 거부한 것 | v1.10e 채택 |
|------|----------------|------------|
| **행위 유형** | injection (사용자 입력 없이 stamp) | **observation** (사용자 LICENSE 파일을 읽음) |
| **트리거** | 사용자 LICENSE 파일 부재여도 default `MIT` 강제 | **LICENSE 파일에 SPDX 헤더 존재 시만** stamp |
| **부재 시 동작** | default value 강제 stamp | **fallback "see LICENSE"** (v1.10b 텍스트 유지) |
| **사용자 의도 반영** | 의도 위배 가능 (Apache 의도자에 MIT 박힘) | **의도 정확 반영** (LICENSE = 사용자 명시 의도) |
| **read vs write** | write (값 생성) | **read** (기존 값 추출) |

→ **본질이 다름**. v1.10c 거부 = injection 위험 회피. v1.10e 채택 = observation 안전.

## 3. v1.10c 3 거부 이유의 무력화

### 거부 이유 1 — agents.md spec 위반

**v1.10c**: "License는 권장 § 아님"

**v1.10e 정합성**:
- agents.md verbatim (audit/A1 인용 2): "Are there required fields? No. AGENTS.md is just standard Markdown. Use any headings you like"
- → license 필드 자체가 spec 미정의. v1.10b가 도입한 placeholder 자체가 spec 외 관례
- v1.10e도 placeholder 자동화일 뿐. **위반 정도 동일** (변화 없음)
- 라인 자체 제거/유지 결정은 별도 (v1.10h)

→ **거부 이유 1 무력화** — v1.10b가 이미 spec 외 관례 도입. v1.10e는 그 관례를 자동화할 뿐.

### 거부 이유 2 — 법적 오인 리스크

**v1.10c**: "MIT 자동 stamp가 Apache/GPL/Proprietary 의도자에게 박힘"

**v1.10e 정합성**:
- v1.10e는 **LICENSE 파일 SPDX 헤더 존재 시만** stamp (T1)
- 사용자가 SPDX 헤더 작성 = 명시적 의도 선언
- LICENSE 부재 → fallback `see LICENSE` (의도 불명 처리)
- **사용자 의도 위배 케이스 0**

→ **거부 이유 2 무력화** — v1.10c가 거부한 것은 default `MIT` injection. v1.10e는 사용자 명시 SPDX 헤더 observation.

### 거부 이유 3 — 권위 도구 패턴 위배

**v1.10c**: "cargo new 의도적 미stamp / npm init ISC RFC 논쟁 / poetry init default 없음"

**v1.10e 정합성**:
- cargo new: 사용자 입력 없으면 미stamp ✅ (v1.10e도 LICENSE 부재 시 미stamp)
- npm init: ISC default RFC 논쟁 中 ✅ (v1.10e는 default 없음, observation only)
- poetry init: default 없음 ✅ (v1.10e도 fallback `see LICENSE`)

→ **거부 이유 3 무력화** — v1.10e는 권위 도구 패턴 정합. 사용자 명시 의도 (LICENSE 작성)만 반영.

## 4. observation vs injection 본질

### v1.10c 거부 (injection)
```
사용자 입력: 없음 (또는 LICENSE 부재)
시스템 동작: default `MIT` 강제 stamp
결과: AGENTS.md "License: MIT" + git log 영구 박힘
risk: 의도 위배 (Apache/Proprietary 의도자)
```

### v1.10e 채택 (observation)
```
사용자 입력: LICENSE 파일 + SPDX 헤더 ("SPDX-License-Identifier: MIT")
시스템 동작: 헤더 read + AGENTS.md L5 stamp
결과: AGENTS.md "License: MIT (see [LICENSE](LICENSE))"
risk: 0 — 사용자 명시 의도 정확 반영
```

| 행위 | injection | observation |
|------|:---------:|:-----------:|
| 사용자 입력 필요? | ❌ | ✅ (LICENSE + SPDX 헤더) |
| default 강제? | ✅ | ❌ |
| 의도 위배 가능? | ✅ | ❌ |
| 권위 도구 패턴 정합? | ❌ | ✅ |

## 5. 시나리오별 정합성 검증

### 시나리오 A — OSS 사용자 (LICENSE + SPDX 헤더)

```
LICENSE 파일:
  SPDX-License-Identifier: MIT
  
  MIT License
  Copyright (c) 2026 ...
```

**v1.10e 동작**: T1 매칭 → `license = "MIT"` → AGENTS.md L5 `License: MIT (see [LICENSE](LICENSE))`

**의도 반영**: ✅ 사용자가 SPDX 헤더로 명시한 MIT 정확 반영.

### 시나리오 B — OSS 사용자 (LICENSE만, SPDX 헤더 없음)

```
LICENSE 파일:
  MIT License
  Copyright (c) 2026 ...
```

**v1.10e 동작**: T1 미식별 → fallback → AGENTS.md L5 `License: see LICENSE.` (v1.10b 텍스트)

**의도 반영**: △ 사용자가 MIT 의도지만 SPDX 헤더 미작성 → fallback. 사용자가 INTERVIEW_FLOW.md 안내 보고 SPDX 헤더 추가 또는 v1.10e2 채택 결정.

### 시나리오 C — Proprietary 사용자 (LICENSE 부재)

```
LICENSE 파일: 없음
```

**v1.10e 동작**: 검사 대상 없음 → fallback → AGENTS.md L5 `License: see LICENSE.`

**의도 반영**: ✅ proprietary 의도 보존. v1.10c 거부한 default MIT 강제와 정반대.

### 시나리오 D — Dual-license 사용자 (LICENSE 단일 파일 + SPDX expression 헤더)

```
LICENSE 파일:
  SPDX-License-Identifier: MIT OR Apache-2.0
  
  This software is dual-licensed under MIT and Apache-2.0.
  ...
```

**v1.10e 동작**: T1 매칭 → `license = "MIT OR Apache-2.0"` → AGENTS.md L5 `License: MIT OR Apache-2.0 (see [LICENSE](LICENSE))`

**의도 반영**: ✅ SPDX expression 그대로 보존.

### 시나리오 E — Multi-file dual-license (Astral 패턴)

```
LICENSE-MIT: ...
LICENSE-APACHE: ...
LICENSE: 부재
```

**v1.10e 동작**: 4 우선순위 (`LICENSE` → `.md` → `.txt` → `COPYING`) 모두 미존재 → fallback `see LICENSE`

**의도 반영**: △ multi-file dual-license 미커버. **v1.10e2 후속** 명시.

## 6. 통합 결론 — v1.10c 거부 결정과 v1.10e 채택 결정 모두 정당

| 결정 | 본질 | 정당성 |
|------|------|:------:|
| v1.10c 거부 (default MIT injection) | injection — 의도 위배 risk | ✅ 거부 정당 |
| v1.10e 채택 (T1 SPDX observation) | observation — 사용자 명시 의도 | ✅ 채택 정당 |
| 둘은 반대인가? | 본질 다름 | ❌ 반대 아님 (정합) |

본 v1.10e는 v1.10c 폐기 결정의 **연장이자 자연 후속**. 거부 이유 3건 모두 v1.10e에 적용 안 됨. 본 audit/A5는 v1.10e의 정당화 기록.

## 7. v1.10e2 채택 결정 시 재검증 필요

본 v1.10e (T1 only)는 observation 본질 정합. 단 후속 v1.10e2 (T2 boilerplate)는:
- T2 boilerplate "MIT License" 첫 라인 grep → MIT stamp
- 사용자가 boilerplate만 두고 SPDX 헤더 미작성 = 명시 의도 약함
- false positive risk (LICENSE에 "MIT License" 텍스트만 있어도 매칭 — README 등 흔히 언급)

→ **v1.10e2 PLAN 작성 시 본 audit/A5와 같은 정합성 검증 다시 필요**. T2가 observation/injection 경계선에 위치.
